# Brightness Vicious Widget
Простой виджет для регулировки яркости экрана для AwesomeWM с Vicious.
### Зависимости
Необходимо установить дополнительно `brightnessctl`

### Установка
1. Копируем виджет в директорию виджетов.
```
git clone https://github.com/AliceZed8/awesome.brightness_widget.git
sudo cp awesome.brightness_widget/file /usr/share/lua/LUA_VERSION/vicious/widgets/
```
2. Отредактируйте ваш конфиг ( чаще всего `.config/awesome/rc.lua`), добавив:
```
-- Simple Brightness Control Widget
brightnesswidget = wibox.widget.textbox();
```
3. Регистрация виджета. Аргументы: "device_name" (можно посмотреть через `brightnessctl`). Выходные значения $1 - текущее значение, $2 - максимальное, $3 - значение в процентах. В данном примере обновление каждые 0.2 сек.
```
vicious.register(brightnesswidget, vicious.widgets._brightness, "Brightness: $3", 0.2, "device_name")
```
4. Базовые настройки клавиш. В данном примере регулировка с помощью колесика мышки.
```
brightnesswidget:buttons(awful.util.table.join(
    awful.button({ }, 4, function () awful.util.spawn("brightnessctl --device=amdgpu_bl1 set 1%+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("brightnessctl --device=amdgpu_bl1 set 1%-", false) end)
))
```
5. Рестарт AwesomeWM.

