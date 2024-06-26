﻿using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Telerik.Windows.Core;

namespace Flora.ViewModel
{
    public class ItemViewModel : INotifyPropertyChanged
    {
        public string ItemLabel { get; set; }
        public ObservableCollection<Plant> Plants { get; set; }
        public bool IsEnablePlants { get; set; }
        public Plant SelectedPlant { get; set; }
        public int SelectedPlantIndex { get; set; }
        public bool IsEnabledQuantityComboBox { get; set; }
        public List<int> ListQuantity { get; set; }
        public int SelectedQuantity { get; set; }
        public decimal TotalPrice { get; set; }
        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
