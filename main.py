meters = {}

def add_meter(name):
    meters[name] = 'Не підтверджено'
    print(f'Лічильник {name}  успішно додано.')

def verify_meter(name):
    if name in meters:
        meters[name] = 'Підтверджено'
        print(f'Лічильник {name} підтверджено.')
    else:
        print(f'Лічильник {name} не знайдено.')
        raise KeyError(f'Лічильник {name} не знайдено.')

def display_meters():
    print('\nСписок лічильників:')
    for name, status in meters.items():
        print(f'{name}: {status}')
    print('')


