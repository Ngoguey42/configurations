# exec(open('/home/rb-desktop-10/configurations/qgis_shortcuts.py').read())

print('Hello World')

import datetime

from qgis.PyQt.QtCore import Qt

# Main routines ********************************************************************************* **
def setup():
    setup_rasters_visibility()
    setup_vectors_visibility()
    setup_vectors_focusing()
    setup_q3d_shortcut()

def setup_q3d_shortcut():
    objs = [
        o
        for *_, o in list_all_objs(iface.mainWindow())
        if 'qcheckbox' in str(o).lower()
        if o.text() == 'Preview'
    ]
    if not objs:
        print("Can't set Qgis2threejs shortcut!")
        return
    o, = objs
    def call():
        o.click()
    bind(Qt.Key_F1, call)

def setup_rasters_visibility():
    for key_digit in range(1, 10):
        class MaSuperClosureCallable:
            key_idx = key_digit - 1
            def __new__(cls):
                tree_layers = QgsProject.instance().layerTreeRoot().findGroup('rasters').children()
                if cls.key_idx >= len(tree_layers):
                    print(cls.key_idx, '>=', len(tree_layers))
                    return
                else:
                    print(cls.key_idx, '<', len(tree_layers))
                tl = tree_layers[cls.key_idx]
                tl.setItemVisibilityChecked(True)
                tl0 = tl
                for tl in tree_layers: # Hiding all others makes qgis faster
                    if tl is tl0 or not tl.isVisible():
                        continue
                    tl.setItemVisibilityChecked(False)
        key = getattr(Qt, f'Key_{key_digit}')
        bind(key, MaSuperClosureCallable)

def setup_vectors_visibility():
    def call():
        tl = QgsProject.instance().layerTreeRoot().findGroup('vectors')
        tl.setItemVisibilityChecked(not tl.isVisible())
    bind(Qt.Key_QuoteLeft, call)

def setup_vectors_focusing():
    keys = 'ASDFGH'
    for key in keys:
        class MaSuperClosureCallable:
            key_idx = keys.index(key)
            def __new__(cls):
                now = datetime.datetime.now()
                last_hit_time = globals().get(
                    'last_hit_time', now - datetime.timedelta(seconds=1)
                )
                elapsed = now - last_hit_time
                if elapsed < datetime.timedelta(seconds=0.5):
                    last_hit = globals().get(
                        'last_hit', QgsProject.instance().layerTreeRoot().findGroup('vectors')
                    )
                    if isinstance(last_hit, QgsLayerTreeLayer):
                        # Not timeout on sequence, but reached a layer
                        print('Beginning of sequence')
                        last_hit = QgsProject.instance().layerTreeRoot().findGroup('vectors')
                else:
                    # Timeout on sequence
                    print('Beginning of sequence')
                    last_hit = QgsProject.instance().layerTreeRoot().findGroup('vectors')
                if cls.key_idx >= len(last_hit.children()):
                    print('  noop')
                    return
                hit = last_hit.children()[cls.key_idx]
                print('  -', last_hit.name(), '->', hit.name(), f'(of type {type(hit)})')
                if isinstance(hit, QgsLayerTreeLayer):
                    map_layer, = QgsProject.instance().mapLayersByName(hit.name())
                    iface.setActiveLayer(map_layer)
                    print('  Focusing!')
                globals()['last_hit'] = hit
                globals()['last_hit_time'] = now
        key = getattr(Qt, f'Key_{key}')
        bind(key, MaSuperClosureCallable)

# Shortcuts tools ******************************************************************************* **
def bind(key, fn):
    disable_all_shortcuts_using(key)
    shortcut = QShortcut(key, iface.mainWindow())
    shortcut.setContext(Qt.ApplicationShortcut)
    shortcut.activated.connect(fn)
    print('Connected new key', shortcut.key().toString())
    please_do_not_garbage_collect_me.append(shortcut)

def list_all_shortcuts_of(obj):
    yield from obj.findChildren(QAction)
    yield from obj.findChildren(QShortcut)
    for g in obj.findChildren(QActionGroup):
        yield from list_all_shortcuts_of(g)

def list_all_shortcuts():
    return list(list_all_shortcuts_of(iface.mainWindow()))

def list_all_shortcuts_using(seq0):
    return [
        c
        for c in list_all_shortcuts()
        for k in ['key', 'shortcut']
        if hasattr(c, k)
        for seq1 in [getattr(c, k)()]
        if seq0 == seq1
    ]

def disable_all_shortcuts_using(seq):
    please_do_not_garbage_collect_me = globals().get('please_do_not_garbage_collect_me', [])
    globals()['please_do_not_garbage_collect_me'] = please_do_not_garbage_collect_me
    for obj in list_all_shortcuts_using(seq):
        seq, = (
            getattr(obj, k)()
            for k in ['key', 'shortcut']
            if hasattr(obj, k)
        )
        print('Removing old', obj, 'bound to', seq.toString())
        obj.setEnabled(False)
        try:
            obj.disconnect()
        except:
            pass
        if obj in please_do_not_garbage_collect_me:
            print('  also removing from `please_do_not_garbage_collect_me`')
            please_do_not_garbage_collect_me.remove(obj)

def list_all_objs(obj, head=()):
    head = head + (obj,)
    yield head
    for obj in obj.children():
        yield from list_all_objs(obj, head)

# Run ******************************************************************************************* **
setup()

print('Bye World')
