class Weed {
  final String name;
  final String image;
  final String desc;
  final String herbiside;

  Weed({required this.name, required this.image, required this.desc, required this.herbiside});
}

class GulmaData {
  static final Map<String, List<Weed>> data = {
    "Gulma Daun Lebar": [
      Weed(
        name: "Amaranthus Spinosus",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Amaranthus-Spinosus_gdsgnd.jpg",
        desc: "Amaranthus Spinosus adalah gulma yang memiliki daun lebar dan batang berduri. Gulma ini sering ditemukan di lahan pertanian dan dapat mengganggu pertumbuhan tanaman utama. Amaranthus Spinosus dapat tumbuh dengan cepat dan menghasilkan banyak biji, sehingga sulit untuk dikendalikan jika tidak segera ditangani.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Ageratum Conyzoides",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Ageratum_Conyzoides_e0w0tb.jpg",
        desc: "Ageratum Conyzoides adalah gulma yang memiliki daun lebar dan bunga berwarna ungu atau putih. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Ageratum Conyzoides dapat tumbuh dengan cepat dan menyebar melalui biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Phyllanthus Niruri",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Phyllanthus_Niruri_ccaukm.jpg",
        desc: "Phyllanthus Niruri adalah gulma yang memiliki daun lebar dan batang yang rapuh. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Phyllanthus Niruri dapat tumbuh dengan cepat dan menyebar melalui biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Asystasia Gangetica",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Asystasia_Gangetica_kasfa0.jpg",
        desc: "Asystasia Gangetica adalah gulma yang memiliki daun lebar dan bunga berwarna ungu atau putih. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Asystasia Gangetica dapat tumbuh dengan cepat dan menyebar melalui biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
    ],

    "Gulma Daun Sempit": [
      Weed(
        name: "Cynodon dactylon L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860405/Cynodon_dactylon_L_c4rflt.jpg",
        desc: "Cynodon dactylon L adalah gulma yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Cynodon dactylon L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Eleusine indica L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Eleusine_indica_L_pfgftj.jpg",
        desc: "Eleusine indica L adalah gulma yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Eleusine indica L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Imperata cylindrica L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Imperata_cylindrica_L_tnjvwe.jpg",
        desc: "Imperata cylindrica L adalah gulma yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Imperata cylindrica L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Echinochloa crus-galli L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Echinochloa_crus-galli_L_dcnjis.jpg",
        desc: "Echinochloa crus-galli L adalah gulma yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Echinochloa crus-galli L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
    ],

    "Gulma Teki-teki": [
      Weed(
        name: "Cyperus bervifolius",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Cyperus_bervifolius_ny8j9r.jpg",
        desc: "Cyperus bervifolius adalah gulma teki-teki yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Cyperus bervifolius dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Cyperus rotundus L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Cyperus_rotundus_L_dv1jnu.jpg",
        desc: "Cyperus rotundus L adalah gulma teki-teki yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Cyperus rotundus L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Cyperus difformia L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860404/Cyperus_difformia_L_ejz88f.jpg",
        desc: "Cyperus difformia L adalah gulma teki-teki yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Cyperus difformia L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
      Weed(
        name: "Cyperus halpan L",
        image: "https://res.cloudinary.com/df2k8l02r/image/upload/q_auto/f_auto/v1776860403/Cyperus_halpan_L_csw8a2.jpg",
        desc: "Cyperus halpan L adalah gulma teki-teki yang memiliki daun sempit dan batang yang merayap. Gulma ini sering ditemukan di lahan pertanian, kebun, dan area terbuka lainnya. Cyperus halpan L dapat tumbuh dengan cepat dan menyebar melalui akar dan biji, sehingga dapat menjadi masalah serius jika tidak dikendalikan.",
        herbiside: "Herbisida berbasis glifosat atau herbisida selektif yang mengandung bahan aktif seperti atrazin atau metribuzin."
      ),
    ],
  };
}