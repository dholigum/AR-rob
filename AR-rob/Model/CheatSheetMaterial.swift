//
//  CheatSheetMaterial.swift
//  AR-rob
//
//  Created by Arya Ilham on 10/06/21.
//

import Foundation

struct CheatSheetMaterial {
    
    var materialName:String = ""
    var materialSubTitle1:String = ""
    var materialSubTitle2:String = ""
    var materialDetail:String = ""
    var materialQuickSummary:String = ""
    var materialImageName:String = ""
    
    init(materialName:String, materialSubTitle1:String, materialSubTitle2:String, materialDetail:String, materialQuickSummary:String, materialImageName:String) {
        self.materialName = materialName
        self.materialSubTitle1 = materialSubTitle1
        self.materialSubTitle2 = materialSubTitle2
        self.materialDetail = materialDetail
        self.materialQuickSummary = materialQuickSummary
        self.materialImageName = materialImageName
        
    }
    
    static func getMaterial() -> [CheatSheetMaterial] {
        return [
            CheatSheetMaterial(materialName: "Glikolisis dalam Sitoplasma", materialSubTitle1: "Glikolisis terjadi dalam sitoplasma dalam sel", materialSubTitle2: "Glikolisis menghubah Glukosa menjadi Asam Piruvat, NADH, ATP", materialDetail: "Dimana Asam Piruvat akan digunakan di proses selanjutnya yaitu Siklus Krebs sebagai bahan bakar, sementara NADH disimpan untuk diproses di akhir, dan ATP sudah merupakan hasil akhir yang digunakan tubuh sebagai energi.", materialQuickSummary: "Total ATP yang Dihasilkan = 2 ATP", materialImageName: "test image"),
            CheatSheetMaterial(materialName: "Dekarboksilasi Oksidatif", materialSubTitle1: "Dekarboksilasi Oksidatif terjadi dalam Matriks Mitokondria", materialSubTitle2: "Dekarboksilasi Oksidatif merubah Asam Piruvat menjadi 2 Asetil Co-A, 2 CO2, 2 NADH", materialDetail: "Reaksi antara glikolisis dan siklus Krebs, yaitu pengubahan molekul asam piruvat menjadi asetil ko-A.", materialQuickSummary: "", materialImageName: "test image"),
            CheatSheetMaterial(materialName: "Siklus Krebs", materialSubTitle1: "Siklus Krebs terjadi dalam Matriks Mitokondria", materialSubTitle2: "Siklus Krebs menghasilkan 4 CO2, 6 NADH, 2FADH2, dan 2 ATP.", materialDetail: "Dalam satu siklus respirasi, siklus Krebs berjalan sebanyak 2 kali.", materialQuickSummary: "Total ATP yang Dihasilkan = 2 ATP", materialImageName: "test image"),
            CheatSheetMaterial(materialName: "Transpor Elektron", materialSubTitle1: "Transpor Elektron terjadi di membran mitokondria.", materialSubTitle2: "Rangkaian transpor elektron menghasilkan 34 ATP dan 6 H2O", materialDetail: "Pada tahap ini terjadi pengubahan NADH dan FADH2 yang dihasilkan dari proses-proses sebelumnya menjadi ATP.", materialQuickSummary: "Total ATP yang Dihasilkan = 34 ATP", materialImageName: "test image")]
    }
    
}
