Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC21217F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfEBR6V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:58:21 -0400
Received: from esa10.utexas.iphmx.com ([216.71.150.156]:14296 "EHLO
        esa10.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEBR6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:58:21 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 13:58:20 EDT
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 147469355
IronPort-PHdr: =?us-ascii?q?9a23=3A0lKsXxNp7Et6E7naUjQl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEu6g/l0fHCIPc7f8My/HbtaztQyQh2d6AqzhDFf4ETB?=
 =?us-ascii?q?oZkYMTlg0kDtSCDBjjI/nncz4SGc1eVBl443yrOFMTFcrjNBXf?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EkAABqLMtchzMwL2hlHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwUBAQsBgT1QgWEECygKhAaDRwOFMYlRgjIlmFCBJAMYPAEOAS0ChD4?=
 =?us-ascii?q?CF4ZANgcOAQMBAQUBAQEBAgICEAEBAQgNCQgpIwyDRTkyAQEBAQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBBQI4OQEBBBIREQwBATcBDwIBCA4?=
 =?us-ascii?q?KAgImAgICMBUCAQ0CBA4FGweDAIFrAx0Bogw9AmICC4EBKYhfcYEvgnkBAQW?=
 =?us-ascii?q?FAhhBB4FGCYELJwGLXAaBQT6BOAyCXz6EMBSDCoJYizmBaCyGWpIcZQkCggm?=
 =?us-ascii?q?SOgYCGZVBoHkCBAIEBQIOAQEFgVYMgXxyE4Mngg8ag1WKU0ABMYEpkGOBMAG?=
 =?us-ascii?q?BIAEB?=
X-IPAS-Result: =?us-ascii?q?A2EkAABqLMtchzMwL2hlHAEBAQQBAQcEAQGBUwUBAQsBg?=
 =?us-ascii?q?T1QgWEECygKhAaDRwOFMYlRgjIlmFCBJAMYPAEOAS0ChD4CF4ZANgcOAQMBA?=
 =?us-ascii?q?QUBAQEBAgICEAEBAQgNCQgpIwyDRTkyAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBBQI4OQEBBBIREQwBATcBDwIBCA4KAgImAgICMBUCA?=
 =?us-ascii?q?Q0CBA4FGweDAIFrAx0Bogw9AmICC4EBKYhfcYEvgnkBAQWFAhhBB4FGCYELJ?=
 =?us-ascii?q?wGLXAaBQT6BOAyCXz6EMBSDCoJYizmBaCyGWpIcZQkCggmSOgYCGZVBoHkCB?=
 =?us-ascii?q?AIEBQIOAQEFgVYMgXxyE4Mngg8ag1WKU0ABMYEpkGOBMAGBIAEB?=
X-IronPort-AV: E=Sophos;i="5.60,422,1549951200"; 
   d="scan'208";a="147469355"
X-Utexas-Seen-Outbound: true
Received: from mail-co1nam05lp2051.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.51])
  by esa10.utexas.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 May 2019 12:51:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBil9MNwU3c3MwJpc3Ej1bXxs5s1gcPPCD7c6NO11Pg=;
 b=Hlgi0+EAAZCq9pOYQKkidOKCcpk8A5iWfWIusPRW4Y8n5dJdkJRgQB92qn+2wgf1mrdaGJhlMzYldIk/kRgIof+BYV46j0a3/TcBT2dUjkRi5LO5OK1pIMC+x/Cj6dmJV9SIco8QAm19yZc9/mBpRr6rmuwy/HZDIpvojPVFXo8=
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com (10.167.109.15) by
 DM5PR0601MB3735.namprd06.prod.outlook.com (10.167.109.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.14; Thu, 2 May 2019 17:51:12 +0000
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::d02d:6aa3:ca06:3507]) by DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::d02d:6aa3:ca06:3507%6]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 17:51:12 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     Andreas Gruenbacher <agruenba@redhat.com>
CC:     NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        =?utf-8?B?QW5kcmVhcyBHcsO8bmJhY2hlcg==?= 
        <andreas.gruenbacher@gmail.com>,
        Patrick Plagwitz <Patrick_Plagwitz@web.de>,
        "linux-unionfs@vger.kernel.org" <linux-unionfs@vger.kernel.org>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Thread-Topic: [PATCH] overlayfs: ignore empty NFSv4 ACLs in ext4 upperdir
Thread-Index: AQHVAIspItZqAESGCECfW8viq8okK6ZXI70AgAARYICAAI5xAIAAWKOAgAAB8oA=
Date:   Thu, 2 May 2019 17:51:12 +0000
Message-ID: <31520294-b2cc-c1cb-d9c5-d3811e00939a@math.utexas.edu>
References: <CAJfpeguwUtRWRGmNmimNp-FXzWqMCCQMb24iWPu0w_J0_rOnnw@mail.gmail.com>
 <20161205151933.GA17517@fieldses.org>
 <CAJfpegtpkavseTFLspaC7svbvHRq-0-7jvyh63+DK5iWHTGnaQ@mail.gmail.com>
 <20161205162559.GB17517@fieldses.org>
 <CAHpGcMKHjic6L+J0qvMYNG9hVCcDO1hEpx4BiEk0ZCKDV39BmA@mail.gmail.com>
 <266c571f-e4e2-7c61-5ee2-8ece0c2d06e9@web.de>
 <CAHpGcMKmtppfn7PVrGKEEtVphuLV=YQ2GDYKOqje4ZANhzSgDw@mail.gmail.com>
 <CAHpGcMKjscfhmrAhwGes0ag2xTkbpFvCO6eiLL_rHz87XE-ZmA@mail.gmail.com>
 <CAJfpegvRFGOc31gVuYzanzWJ=mYSgRgtAaPhYNxZwHin3Wc0Gw@mail.gmail.com>
 <CAHc6FU4JQ28BFZE9_8A06gtkMvvKDzFmw9=ceNPYvnMXEimDMw@mail.gmail.com>
 <20161206185806.GC31197@fieldses.org>
 <87bm0l4nra.fsf@notabene.neil.brown.name>
 <CAOQ4uxjYEjqbLcVYoUaPzp-jqY_3tpPBhO7cE7kbq63XrPRQLQ@mail.gmail.com>
 <875zqt4igg.fsf@notabene.neil.brown.name>
 <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
 <CAHc6FU4czPQ8xxv5efvhkizU3obpV_05VEWYKydXDDDYcp8j=w@mail.gmail.com>
In-Reply-To: <CAHc6FU4czPQ8xxv5efvhkizU3obpV_05VEWYKydXDDDYcp8j=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: YT1PR01CA0001.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::14)
 To DM5PR0601MB3718.namprd06.prod.outlook.com (2603:10b6:4:7d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16015bef-47bb-4f55-98e5-08d6cf26c3d2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR0601MB3735;
x-ms-traffictypediagnostic: DM5PR0601MB3735:
x-microsoft-antispam-prvs: <DM5PR0601MB37355CD99EA7A034ED7DB89283340@DM5PR0601MB3735.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(366004)(39860400002)(199004)(189003)(6506007)(386003)(53546011)(88552002)(14454004)(102836004)(186003)(31696002)(6512007)(66066001)(86362001)(53936002)(26005)(478600001)(6246003)(4326008)(54906003)(786003)(25786009)(316002)(73956011)(66946007)(6916009)(229853002)(31686004)(66476007)(66446008)(64756008)(66556008)(75432002)(7416002)(256004)(3846002)(6116002)(486006)(14444005)(446003)(11346002)(2616005)(476003)(68736007)(6486002)(8676002)(6436002)(2906002)(8936002)(81156014)(99286004)(5660300002)(305945005)(7736002)(81166006)(71200400001)(76176011)(52116002)(71190400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3735;H:DM5PR0601MB3718.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JSsCTRzYVQaBbkDKoSIXjdDF98muhvKc+dX38ZMAnccxWjimqJCGLn46co+0N5mz1evGFMmoAjCdcVTnux/JVxqMNYnNiz0lKwkcMCJaD4vEF4b/jqtAg5SBTl4zZiGlITR3F/rqYJKN/Oyl/fLUAucEeZEc7+hsup+tVZGl9KW5HgDMkMT0T7H8CV+3jWJRz2ch2cvsdGwUTiekwvoZXw3KkQklU9GfbH6/CjMiLbG49NCW2hL/QTUf/K835saq7coaWyxfhl76+SCtLDKf2khbBa73u25Ax5coojVsjTZlFsa0JsVN6tF3IDBxZbewz5S8klDeYQrOKDuRaWBFwhumF9P/Gohbh8AIVO1nrQjUbvfUoTIl884lNCNLPTLpKp1/Yul+5x1SikMiDKRQT2i/orkU/dGJdq6mO7QFQ0Y=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CB6D9727B74B4EB8D9F2DD984EB149@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 16015bef-47bb-4f55-98e5-08d6cf26c3d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 17:51:12.3281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3735
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCk9uIDUvMi8xOSAxMjo0NCBQTSwgQW5kcmVhcyBHcnVlbmJhY2hlciB3cm90ZToNCj4gT24g
VGh1LCAyIE1heSAyMDE5IGF0IDE5OjI3LCBHb2V0eiwgUGF0cmljayBHIDxwZ29ldHpAbWF0aC51
dGV4YXMuZWR1PiB3cm90ZToNCj4+IE9uIDUvMS8xOSAxMDo1NyBQTSwgTmVpbEJyb3duIHdyb3Rl
Og0KPj4+IFN1cHBvcnQgc29tZSBkYXkgc3VwcG9ydCBmb3IgbmZzNCBhY2xzIHdlcmUgYWRkZWQg
dG8gZXh0NCAobm90IGEgdG90YWxseQ0KPj4+IHJpZGljdWxvdXMgc3VnZ2VzdGlvbikuICBXZSB3
b3VsZCB0aGVuIHdhbnQgTkZTIHRvIGFsbG93IGl0J3MgQUNMcyB0byBiZQ0KPj4+IGNvcGllZCB1
cC4NCj4+DQo+PiBJcyB0aGVyZSBzb21lIHJlYXNvbiB3aHkgdGhlcmUgaGFzbid0IGJlZW4gYSBn
cmVhdGVyIGVmZm9ydCB0byBhZGQgTkZTdjQNCj4+IEFDTCBzdXBwb3J0IHRvIHRoZSBtYWluc3Ry
ZWFtIGxpbnV4IGZpbGVzeXN0ZW1zPyAgSSBoYXZlIHRvIHN1cHBvcnQgYQ0KPj4gaHlicmlkIGxp
bnV4L3dpbmRvd3MgZW52aXJvbm1lbnQgYW5kIG5vdCBoYXZpbmcgdGhlc2UgQUNMcyBvbiBleHQ0
IGlzIGENCj4+IGRhaWx5IGhlYWRhY2hlIGZvciBtZS4NCj4gDQo+IFRoZSBwYXRjaGVzIGZvciBp
bXBsZW1lbnRpbmcgdGhhdCBoYXZlIGJlZW4gcmVqZWN0ZWQgb3ZlciBhbmQgb3Zlcg0KPiBhZ2Fp
biwgYW5kIG5vYm9keSBpcyB3b3JraW5nIG9uIHRoZW0gYW55bW9yZS4NCj4gDQo+IEFuZHJlYXMN
Cj4gDQoNCg0KVGhhdCdzIHRoZSBwYXJ0IEkgZG9uJ3QgdW5kZXJzdGFuZCAtLSB3aHkgYXJlIHRo
ZSBSaWNoQUNMIHBhdGNoZXMgYmVpbmcgDQpyZWplY3RlZD8NCg0KRXZlcnlvbmUgbG92ZXMgdGhl
IHNpbXBsaWNpdHkgb2YgbW9kZSBiaXRzIChpbmNsdWRpbmcgbWUpIHVudGlsIHlvdSBydW4gDQpp
bnRvIHRoaW5ncyBsaWtlIHRoZSBuZWVkIHRvIGF1dG9tYXRpY2FsbHkgY3JlYXRlIGhvbWUgZGly
ZWN0b3JpZXMgb24gYW4gDQpORlMtbW91bnRlZCBmaWxlc3lzdGVtIG9yIHNlY3VyaXR5IHNpdHVh
dGlvbnMgd2hlcmUsIGZvciBleGFtcGxlLCB5b3UgDQp3YW50IHVzZXJzIHRvIGJlIGFibGUgdG8g
ZWRpdCBidXQgbm90IGRlbGV0ZSBmaWxlcywgYW5kIHRoZW4geW91J3JlIGtpbmQgDQpvZiBzdHVj
ayBsaXN0ZW5pbmcgdG8geW91ciBXaW5kb3dzIGNvbGxlYWd1ZXMgcHJvcG9zZSBhIFN0b3JhZ2Ug
U3BhY2VzIA0Kc29sdXRpb24uDQoNCg==
