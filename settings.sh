#!/bin/bash

print_line() {
    echo "-------------------"
}

ask_reboot() {
    read -p "Reboot atmak ister misin? (y/n): " answer
    case $answer in
        [Yy])
            echo "Sistem yeniden başlatılıyor..."
            sudo reboot
            ;;
        *)
            echo "Reboot iptal edildi"
            ;;
    esac
}

print_line
echo "1) Mouse Setting"
echo "2) Power Plan"
echo "3) Change Background"
print_line

read -p "Choose 1 Or 2 Or 3 -> " choose1

case $choose1 in 
    1)
        print_line
        echo "<--- Mouse Setting --->"
        print_line
        echo "1) Touch Pad Config"
        echo "2) Mouse Config"
        

        read -p "Choose 1 Or 2 -> " choose_mouse

        case $choose_mouse in 
            1)
                print_line
                echo "<--- Touch Pad Config --->"
                print_line

                if hyprctl keyword input:sensitivity 0; then
                    echo "Successful Touch Pad Config"
                else
                    echo "Hata oluştu"
                fi
                
                ;;

            2)
                print_line
                echo "<--- Mouse Config --->"
                print_line

                if hyprctl keyword input:sensitivity -1; then
                    echo "Successful Mouse Config"
                else
                    echo "Hata oluştu"
                fi
                
                ;;

            *)
                echo "Geçersiz seçim"
                ;;
        esac
        ;;

    2)
        print_line
        echo "<--- Power Plan --->"
        print_line
        echo "1) Saving Power Plan"
        echo "2) Hybrid Power Plan"

        read -p "Choose 1 Or 2 -> " choose_power

        case $choose_power in 
            1)
                print_line
                echo "<--- Saving Power Plan --->"
                print_line

                if sudo envycontrol -s integrated; then
                    echo "Successful Saving Power Plan"
                else
                    echo "Hata oluştu"
                fi
                ask_reboot
                ;;

            2)
                print_line
                echo "<--- Hybrid Power Plan --->"
                print_line

                if sudo envycontrol -s hybrid; then
                    echo "Successful Hybrid Power Plan"
                else
                    echo "Hata oluştu"
                fi
                ask_reboot
                ;;

            *)
                echo "Geçersiz seçim"
                ;;
        esac
        ;;


    3) 
            # Dizini doğru tanımla (Başında $ olmayacak)
        WALLPAPER_DIR="/home/coolkie/background"

        # Dizine git, gidemezsen hata ver ve dur
        if ! cd "$WALLPAPER_DIR"; then
            echo "Hata: Klasör bulunamadı!"
            exit 1
        fi

        echo "Lütfen bir duvar kağıdı seçin:"

        select img in *.jpg *.png *.jpeg ; do
            if [ -n "$img" ]; then
                echo "Seçilen resim: $img"

                swww img "$img"
                break
            else
                echo "Geçersiz seçim."
            fi
        done
        ;;



    *)
        echo "Geçersiz seçim"
        ;;
esac