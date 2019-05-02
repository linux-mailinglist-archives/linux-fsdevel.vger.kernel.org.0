Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 874211210F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 19:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEBReJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 13:34:09 -0400
Received: from esa12.utexas.iphmx.com ([216.71.154.221]:14337 "EHLO
        esa12.utexas.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBReI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 13:34:08 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Thu, 02 May 2019 13:34:08 EDT
X-Utexas-Sender-Group: RELAYLIST-O365
X-IronPort-MID: 138834046
IronPort-PHdr: =?us-ascii?q?9a23=3Aip7gOR+mjZgpSf9uRHGN82YQeigqvan1NQcJ65?=
 =?us-ascii?q?0hzqhDabmn44+8YR7E/fs4iljPUM2b8P9Ch+fM+4HYEW0bqdfk0jgZdYBUER?=
 =?us-ascii?q?oMiMEYhQslVdaKDkDnPtbvZjA6WtleWU9s5De2PVUGUMs=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EFAAD/JstchzImL2hlGwEBAQEDAQE?=
 =?us-ascii?q?BBwMBAQGBUQYBAQELAYE9UIFhBAsoCoQGg0cDhFJfiVGCV5hQgSQDGDwBDgE?=
 =?us-ascii?q?tAoQ+AheGQDQJDgEDAQEFAQEBAQICAhABAQEIDQkIKSMMg0U5MgEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQUCODkBAQQSEREMAQE3AQ8?=
 =?us-ascii?q?CAQgYAgImAgICMBUCAQ0CBAENJ4MAgWsDHQGiED0CYgILgQEpiF9xgS+CeQE?=
 =?us-ascii?q?BBYUCGEEHgUYJgQsnAYtcBoFBPoE4gms+hESDCoJYjSEsmVsJAoIJkjoGG5V?=
 =?us-ascii?q?BjBaUYwIEAgQFAg4BAQWBT4IPchODJ4IPGoNVilNAATGBKZITAYEgAQE?=
X-IPAS-Result: =?us-ascii?q?A2EFAAD/JstchzImL2hlGwEBAQEDAQEBBwMBAQGBUQYBA?=
 =?us-ascii?q?QELAYE9UIFhBAsoCoQGg0cDhFJfiVGCV5hQgSQDGDwBDgEtAoQ+AheGQDQJD?=
 =?us-ascii?q?gEDAQEFAQEBAQICAhABAQEIDQkIKSMMg0U5MgEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQUCODkBAQQSEREMAQE3AQ8CAQgYAgImAgICM?=
 =?us-ascii?q?BUCAQ0CBAENJ4MAgWsDHQGiED0CYgILgQEpiF9xgS+CeQEBBYUCGEEHgUYJg?=
 =?us-ascii?q?QsnAYtcBoFBPoE4gms+hESDCoJYjSEsmVsJAoIJkjoGG5VBjBaUYwIEAgQFA?=
 =?us-ascii?q?g4BAQWBT4IPchODJ4IPGoNVilNAATGBKZITAYEgAQE?=
X-IronPort-AV: E=Sophos;i="5.60,422,1549951200"; 
   d="scan'208";a="138834046"
X-Utexas-Seen-Outbound: true
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by esa12.utexas.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 May 2019 12:27:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=utexas.onmicrosoft.com; s=selector1-utexas-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MEN8xRdIofZXWFIwJFbJpfIVZjNRVNflFWfswFQ1tw=;
 b=MTg5UjaFQGlig1mKIrjRxWk9mSrUhWP4rfsOrrptrIU8269wEOwgBmbmjB2KeaPw0Zt+0+0CLY/O+McBkUeruGNzMFzoNBrwQg1TYp1Qp0EZ94dod1zPJbpNYu96o7xVPYa4c02Yxe4s0UVaYvcXB+0ahauyM3EYZ5S32aXV8Fs=
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com (10.167.109.15) by
 DM5PR0601MB3688.namprd06.prod.outlook.com (10.167.108.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.11; Thu, 2 May 2019 17:26:56 +0000
Received: from DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::d02d:6aa3:ca06:3507]) by DM5PR0601MB3718.namprd06.prod.outlook.com
 ([fe80::d02d:6aa3:ca06:3507%6]) with mapi id 15.20.1856.008; Thu, 2 May 2019
 17:26:56 +0000
From:   "Goetz, Patrick G" <pgoetz@math.utexas.edu>
To:     NeilBrown <neilb@suse.com>, Amir Goldstein <amir73il@gmail.com>
CC:     "J. Bruce Fields" <bfields@fieldses.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
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
Thread-Index: AQHVAIspItZqAESGCECfW8viq8okK6ZXI70AgAARYICAAOJCAA==
Date:   Thu, 2 May 2019 17:26:56 +0000
Message-ID: <8f3ba729-ed44-7bed-5ff8-b962547e5582@math.utexas.edu>
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
In-Reply-To: <875zqt4igg.fsf@notabene.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR21CA0051.namprd21.prod.outlook.com
 (2603:10b6:3:129::13) To DM5PR0601MB3718.namprd06.prod.outlook.com
 (2603:10b6:4:7d::15)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pgoetz@math.utexas.edu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [128.83.133.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a162ef5f-9ecd-483b-7eaf-08d6cf236032
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:DM5PR0601MB3688;
x-ms-traffictypediagnostic: DM5PR0601MB3688:
x-microsoft-antispam-prvs: <DM5PR0601MB36887E3013395627E1834B4C83340@DM5PR0601MB3688.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(396003)(39860400002)(136003)(199004)(189003)(478600001)(305945005)(66066001)(8676002)(3846002)(7736002)(316002)(6246003)(6116002)(229853002)(53936002)(186003)(88552002)(52116002)(110136005)(6512007)(6436002)(54906003)(75432002)(102836004)(786003)(26005)(7416002)(99286004)(5660300002)(476003)(81156014)(8936002)(486006)(76176011)(81166006)(4744005)(2906002)(31686004)(6486002)(25786009)(256004)(14444005)(71190400001)(386003)(66556008)(6506007)(66946007)(73956011)(68736007)(64756008)(31696002)(66476007)(66446008)(86362001)(446003)(4326008)(11346002)(14454004)(2616005)(71200400001)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR0601MB3688;H:DM5PR0601MB3718.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: math.utexas.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eNnPxdoBxHCsSUSMbxFo2KJMLgxuOV+u2EnQIcLcXcU268MZNWgG96dwJlPEFyQ1xt602hp+RKO/orzwJhThJ6umjdZyXo5zKlaALf1LOh9O537cdcvFMVUKvqC/gChVUkO154TDBPxXy8hU94uxIaqmnOLjp5BA5a6tNHjYggBuay/+QFFfHGvfhDJdcssDuBS/jUIdkaVvU0arfOPS0+a9k5Q7pMzXDNi1s7hx8TDM7CYweAqxVlT0X6ZLot98zyuYtslsM6+MlMqJMKA2zeIscID2KEOaomBzaYoCJjwGk6wCFKn/dsv7qC0dYKZBz/sJUVjf+KETgIlHQdkmpN7/Jxa0t2nKouDm0EdkUyRnX5xYW1TXlgIlVk6vutfRUaimtf4lLoSd6vxJYbUWRCgmBGl220OYScmkFwS99ms=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E61925DA62D1E54E930FFD18D9DA927D@namprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: math.utexas.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: a162ef5f-9ecd-483b-7eaf-08d6cf236032
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 17:26:56.6852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 31d7e2a5-bdd8-414e-9e97-bea998ebdfe1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0601MB3688
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNS8xLzE5IDEwOjU3IFBNLCBOZWlsQnJvd24gd3JvdGU6DQo+IFN1cHBvcnQgc29tZSBkYXkg
c3VwcG9ydCBmb3IgbmZzNCBhY2xzIHdlcmUgYWRkZWQgdG8gZXh0NCAobm90IGEgdG90YWxseQ0K
PiByaWRpY3Vsb3VzIHN1Z2dlc3Rpb24pLiAgV2Ugd291bGQgdGhlbiB3YW50IE5GUyB0byBhbGxv
dyBpdCdzIEFDTHMgdG8gYmUNCj4gY29waWVkIHVwLg0KDQoNCklzIHRoZXJlIHNvbWUgcmVhc29u
IHdoeSB0aGVyZSBoYXNuJ3QgYmVlbiBhIGdyZWF0ZXIgZWZmb3J0IHRvIGFkZCBORlN2NCANCkFD
TCBzdXBwb3J0IHRvIHRoZSBtYWluc3RyZWFtIGxpbnV4IGZpbGVzeXN0ZW1zPyAgSSBoYXZlIHRv
IHN1cHBvcnQgYSANCmh5YnJpZCBsaW51eC93aW5kb3dzIGVudmlyb25tZW50IGFuZCBub3QgaGF2
aW5nIHRoZXNlIEFDTHMgb24gZXh0NCBpcyBhIA0KZGFpbHkgaGVhZGFjaGUgZm9yIG1lLg0KDQpB
bHNvLCBpdCBkb2Vzbid0IHRha2UgbXVjaCBuZWVkIGZvciBzZWN1cml0eSBncmFudWxhcml0eSB0
byByZWFsaXplIHRoYXQgDQpQT1NJWCBBQ0xzIChub3QgZXZlciBldmVuIGZvcm1hbGx5IHN0YW5k
YXJkaXplZCEpIGFyZSBmYWlybHkgaW5hZGVxdWF0ZSwgDQpidXQgbW9yZSBpbXBvcnRhbnRseSwg
ZG9uJ3QgcGxheSBuaWNlbHkgd2l0aCB0aGVpciBXaW5kb3dzIGZyaWVuZHMuDQoNCg==
