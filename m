Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D276A30EDD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 15:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfEaN2R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 09:28:17 -0400
Received: from mail-eopbgr740119.outbound.protection.outlook.com ([40.107.74.119]:49984
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbfEaN2R (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 09:28:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=E3KBpTd0xyMdNaxJXIJZVITxjn9NIeZmmDyfBTEkvN6FjBjyQm3Lu7Xue+aeUlJzb8p7yq9miSOZdmecJKgfBjfW9spTaxDXwg8h3fyaOk2EMusosAzwkk5i64QaIn6kt63k8gxSTKkqu3sEeNKwZjCHCF792cOU/0SPLfADSy0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdOb6rzHgBDxtjL/AiaXUe+r8vXl1OiHRjXF/0vzntM=;
 b=SrybtDiuewZ+aOfGkOlSeMtlYNjZ1g6Tk5o4c9H/z1UN86yMYmCTKLM2O1HpRHDruSKBaNihrTVsV5bO0f4YlV9YOuZ9jONY7R+vlKbed45JMZlRUyaiFGfSS916Tg/iwyxJov3wGD/0F3ePKWlRK6Owx1ZDohahw3/WC+Aqpz0=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdOb6rzHgBDxtjL/AiaXUe+r8vXl1OiHRjXF/0vzntM=;
 b=DolljYr4MxaQOxOF4Sm3L/FEkcaUG6MmXhVj0FiDwtO8yJNm87aAViNv0WBTGcYtZ0woOFT+pGobqY2wrD/swvIjRXzqkqh4SU8l7Q/Knf4YrEG13DmCiTi+aqUjAA8RBODJwR2tM5UKZS3lCNidfLiINVGMGtqJfOpvSWjxXjg=
Received: from CY4PR21MB0149.namprd21.prod.outlook.com (2603:10b6:903:b2::19)
 by CY4PR21MB0149.namprd21.prod.outlook.com (2603:10b6:903:b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1965.2; Fri, 31 May
 2019 13:28:13 +0000
Received: from CY4PR21MB0149.namprd21.prod.outlook.com
 ([fe80::e1c7:3b83:c1b6:5e0]) by CY4PR21MB0149.namprd21.prod.outlook.com
 ([fe80::e1c7:3b83:c1b6:5e0%6]) with mapi id 15.20.1965.003; Fri, 31 May 2019
 13:28:13 +0000
From:   Tom Talpey <ttalpey@microsoft.com>
To:     =?utf-8?B?QXVyw6lsaWVuIEFwdGVs?= <aaptel@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "sfrench@samba.org" <sfrench@samba.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "trond.myklebust@hammerspace.com" <trond.myklebust@hammerspace.com>,
        "fengxiaoli0714@gmail.com" <fengxiaoli0714@gmail.com>
CC:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Murphy Zhou <xzhou@redhat.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517:
 notrun on NFS due to unaligned dedupe in test
Thread-Topic: NFS & CIFS support dedupe now?? Was: Re: [PATCH] generic/517:
 notrun on NFS due to unaligned dedupe in test
Thread-Index: AQHVFwCtNpComz/EyU6n3bhBoiUdJaaFDs8AgAAq4hA=
Date:   Fri, 31 May 2019 13:28:12 +0000
Message-ID: <CY4PR21MB0149348B4B4049D9C87BAA39A0190@CY4PR21MB0149.namprd21.prod.outlook.com>
References: <20190530094147.14512-1-xzhou@redhat.com>
 <20190530152606.GA5383@magnolia> <20190530155851.GB5383@magnolia>
 <87woi6yk53.fsf@suse.com>
In-Reply-To: <87woi6yk53.fsf@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=ttalpey@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-05-31T13:28:11.1679427Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0d1ccff3-8f24-4005-b357-693d867128eb;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttalpey@microsoft.com; 
x-originating-ip: [2601:18f:902:71e2::1008]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b49af1a4-3e4d-4889-477a-08d6e5cbd4cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR21MB0149;
x-ms-traffictypediagnostic: CY4PR21MB0149:
x-microsoft-antispam-prvs: <CY4PR21MB01498745DAF1E12665F41932A0190@CY4PR21MB0149.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(366004)(346002)(396003)(199004)(189003)(13464003)(478600001)(186003)(8936002)(46003)(5660300002)(81156014)(305945005)(14444005)(52536014)(66574012)(110136005)(10290500003)(53546011)(54906003)(6246003)(446003)(256004)(102836004)(81166006)(8676002)(25786009)(476003)(11346002)(2906002)(486006)(2501003)(76116006)(7736002)(55016002)(6506007)(229853002)(66556008)(6116002)(74316002)(7416002)(53936002)(2201001)(64756008)(8990500004)(14454004)(66446008)(33656002)(76176011)(99286004)(4326008)(71190400001)(7696005)(73956011)(68736007)(71200400001)(10090500001)(6436002)(86362001)(66946007)(9686003)(316002)(66476007)(22452003)(52396003)(41533002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0149;H:CY4PR21MB0149.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 52oYiHYaqGiK+7tkHQG3RcdZCq/R8vlAwgtB7sKTMZDz0g1iOHXpCl8K0ZNq8X77FKte1eErct8/Nft0ePfoog2+tDNoOyHkt/iYiQaypmBB4db97o3nqgnP0Gcs4f5hxhiNfqG9uzV4TVTl9N3bP/OrW6P8tyg5npVmuBbbk4Hp1bZEX3hDWkOZ+Vh9syDIxtlcIoomrQ+YnmtT8Hyzb1LwFkLMVcQpgjBD0RZMPMfE5mPZwz41hNKMttqjbOkeKdloWyxvB752jEGfhOOtuE395YUG7LLdiz2GsxCs5hdsahPn/L32HS68YRrshDcWUCEFr2We+XBnH7tW+YV7OkfagDV83AG6uGXmMpit/v7+jkNzE0689K0ik+b22UhdCcaxcD/4zoxfF+O/WwVFPCmBexf5HZt/1qJ0cU0yD58=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b49af1a4-3e4d-4889-477a-08d6e5cbd4cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 13:28:12.9447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ttalpey@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0149
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1jaWZzLW93bmVyQHZn
ZXIua2VybmVsLm9yZyA8bGludXgtY2lmcy1vd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uDQo+IEJl
aGFsZiBPZiBBdXLDqWxpZW4gQXB0ZWwNCj4gU2VudDogRnJpZGF5LCBNYXkgMzEsIDIwMTkgNjo0
OSBBTQ0KPiBUbzogRGFycmljayBKLiBXb25nIDxkYXJyaWNrLndvbmdAb3JhY2xlLmNvbT47IHNm
cmVuY2hAc2FtYmEub3JnOw0KPiBhbm5hLnNjaHVtYWtlckBuZXRhcHAuY29tOyB0cm9uZC5teWts
ZWJ1c3RAaGFtbWVyc3BhY2UuY29tOw0KPiBmZW5neGlhb2xpMDcxNEBnbWFpbC5jb20NCj4gQ2M6
IGZzdGVzdHNAdmdlci5rZXJuZWwub3JnOyBNdXJwaHkgWmhvdSA8eHpob3VAcmVkaGF0LmNvbT47
IGxpbnV4LQ0KPiBjaWZzQHZnZXIua2VybmVsLm9yZzsgbGludXgtbmZzQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtZnNkZXZlbCA8bGludXgtDQo+IGZzZGV2ZWxAdmdlci5rZXJuZWwub3JnPg0KPiBT
dWJqZWN0OiBSZTogTkZTICYgQ0lGUyBzdXBwb3J0IGRlZHVwZSBub3c/PyBXYXM6IFJlOiBbUEFU
Q0hdIGdlbmVyaWMvNTE3Og0KPiBub3RydW4gb24gTkZTIGR1ZSB0byB1bmFsaWduZWQgZGVkdXBl
IGluIHRlc3QNCj4gDQo+ICJEYXJyaWNrIEouIFdvbmciIDxkYXJyaWNrLndvbmdAb3JhY2xlLmNv
bT4gd3JpdGVzOg0KPiA+IChOb3Qgc3VyZSBhYm91dCBjaWZzLCBzaW5jZSBJIGRvbid0IGhhdmUg
YSBXaW5kb3dzIFNlcnZlciBoYW5keSkNCj4gPg0KPiA+IEknbSBub3QgYW4gZXhwZXJ0IGluIENJ
RlMgb3IgTkZTLCBzbyBJJ20gYXNraW5nOiBkbyBlaXRoZXIgc3VwcG9ydA0KPiA+IGRlZHVwZSBv
ciBpcyB0aGlzIGEga2VybmVsIGJ1Zz8NCj4gDQo+IEFGQUlLLCB0aGUgU01CIHByb3RvY29sIGhh
cyAyIGlvY3RsIHRvIGRvIHNlcnZlciBzaWRlIGNvcGllczoNCj4gLSBGU0NUTF9TUlZfQ09QWUNI
VU5LIFsxXSBnZW5lcmljDQo+IC0gRlNDVExfRFVQTElDQVRFX0VYVEVOVFNfVE9fRklMRSBbMl0s
IG9ubHkgc3VwcG9ydGVkIG9uIHdpbmRvd3MgIm5ldyINCj4gQ29XDQo+ICAgZmlsZXN5c3RlbSBS
ZUZTDQoNCldpbmRvd3MgYWxzbyBzdXBwb3J0cyB0aGUgVDEwIGNvcHkgb2ZmbG9hZCwgd2hlbiB0
aGUgYmFja2VuZCBzdG9yYWdlIChlLmcuIGEgU0FOKSBzdXBwb3J0cyBpdC4NCg0KVGhlcmUgaXMg
bm8gZXhwbGljaXQgc3VwcG9ydCBmb3IgZGVkdXAgaW4gU01CLCB0aGF0IGlzIGNvbnNpZGVyZWQg
YSBiYWNrZW5kIHN0b3JhZ2UgZnVuY3Rpb24gYW5kIGlzIG5vdCBzdXJmYWNlZCBpbiB0aGUgcHJv
dG9jb2wuIFRoZXJlIGFyZSwgaG93ZXZlciwgc29tZSBhdHRyaWJ1dGVzIHJlbGV2YW50IHRvIGRl
ZHVwIHdoaWNoIGFyZSBwYXNzZWQgdGhyb3VnaC4NCg0KVG9tLg0KDQo=
