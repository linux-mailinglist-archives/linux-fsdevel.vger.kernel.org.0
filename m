Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 590E163A00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2019 19:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfGIRNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jul 2019 13:13:46 -0400
Received: from mail-eopbgr750090.outbound.protection.outlook.com ([40.107.75.90]:26947
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725816AbfGIRNq (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jul 2019 13:13:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7UV0asC5t9GJUAkFa9mjL2FGXv1qsjmP0dvCNBFYC1HBGzp204Jz2JMhUBin6FUmXn4W1nk7E1tRUoFmcVbBmfrW4m7P+glKLcfJMSPepdywUwtfmJ9M+KJK9AHfhPc5/0o6vPK0ACjZJG5n+EO8378hQmLbZGNsyqWjlqc4gXcMBCfOkRBKXHe9ijeWFMaR6AK4RixNmUvqxCVHQuks0NYJP88bkESxPrxEAVZiyZ4bVEX+mCUX8zBlmQfEMDYq3IxJlmGonMOl+2J9KfC4e7mxn+V5A+cS/B2ZYOF0SjDRicdTh2UTn0/DCHAB8J94eK/JA/plbkQDRcDvfEbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP3LNMtwIYWedXvp7hid1F0bR0TEPiBQ7tYYBhq+3U0=;
 b=apsTXTqJNASS/7XWedHEdPQvlkTASxOofh+M1JSJRjQ7Ef4sO56qvxiBnR209mADZhRUVh2qhyuiIUtxTXXALKxgy2iRat1SJGJeeqIi3HkVHRqQHgs8zQeLiyCRmwq5XyIkBfF30dwmJZtuF5a//N/7vnET3Pwb32y1g75/CbyCN5f59pY0H8odDlVBwhMOhw8O6AgjF9hRKvlWRl85tBXGk0p7cYLy1s/WAtDNgWeVb5lxWWpCpcwxj3HgwrN7GfbTTEbemX3Ju2LXSejbA4Z5FV1jZOFKP7rTfuzyxbZGY1GdP6ylDb7JKfT6BiSnlVluJd5UWiZxrv59y0PWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microsoft.com;dmarc=pass action=none
 header.from=microsoft.com;dkim=pass header.d=microsoft.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dP3LNMtwIYWedXvp7hid1F0bR0TEPiBQ7tYYBhq+3U0=;
 b=CqGbga2LHM08AzUmuA1nBI2u97+tWIbYdIpArG2G7gDPMsgflks7r+AGhbM1W0gHDRUt0eejTDkusJp8d97DzVq6+mHG+j9PsiIhT6Ufbd+5joR2Iup0zDofjUdG7Lg9KVwXvcxPlv4cyiKDK19PzYWsv2lWvuwuUCZFfHfyHPQ=
Received: from SN6PR2101MB1072.namprd21.prod.outlook.com (52.132.115.21) by
 SN6PR2101MB0893.namprd21.prod.outlook.com (52.132.116.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.3; Tue, 9 Jul 2019 17:13:02 +0000
Received: from SN6PR2101MB1072.namprd21.prod.outlook.com
 ([fe80::f9cc:1b2a:1b20:808b]) by SN6PR2101MB1072.namprd21.prod.outlook.com
 ([fe80::f9cc:1b2a:1b20:808b%8]) with mapi id 15.20.2094.001; Tue, 9 Jul 2019
 17:13:02 +0000
From:   KY Srinivasan <kys@microsoft.com>
To:     =?utf-8?B?VmFsZGlzIEtsxJN0bmlla3M=?= <valdis.kletnieks@vt.edu>
CC:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Sasha Levin <sashal@kernel.org>
Subject: RE: exfat filesystem
Thread-Topic: exfat filesystem
Thread-Index: AQHVNm3O4cwoiVd1wUyFaPLSrlI8N6bCfKmwgAADYICAAAX+sA==
Date:   Tue, 9 Jul 2019 17:13:02 +0000
Message-ID: <SN6PR2101MB10721504993B62F1D6EBD693A0F10@SN6PR2101MB1072.namprd21.prod.outlook.com>
References: <21080.1562632662@turing-police> <20190709045020.GB23646@mit.edu>
 <20190709112136.GI32320@bombadil.infradead.org>
 <20190709153039.GA3200@mit.edu>
 <20190709154834.GJ32320@bombadil.infradead.org>
 <SN6PR2101MB10726033399AEA1D0BD22067A0F10@SN6PR2101MB1072.namprd21.prod.outlook.com>
 <24605.1562691043@turing-police>
In-Reply-To: <24605.1562691043@turing-police>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kys@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-07-09T17:13:00.3872415Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b52e4a9b-c05c-4bff-90d5-72834542d3f8;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com; 
x-originating-ip: [131.107.147.171]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1c8405-6141-4117-a594-08d70490b350
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR2101MB0893;
x-ms-traffictypediagnostic: SN6PR2101MB0893:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <SN6PR2101MB0893978BD40A176D9F82AA38A0F10@SN6PR2101MB0893.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0093C80C01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(189003)(199004)(13464003)(22452003)(14454004)(4326008)(26005)(54906003)(55016002)(8676002)(81156014)(81166006)(102836004)(966005)(229853002)(25786009)(186003)(498600001)(76116006)(53546011)(8990500004)(10090500001)(73956011)(66946007)(66476007)(64756008)(66556008)(5660300002)(52536014)(221733001)(66066001)(6916009)(33656002)(6506007)(486006)(71190400001)(71200400001)(256004)(99286004)(53936002)(10290500003)(86362001)(6436002)(476003)(7116003)(2171002)(7696005)(6246003)(76176011)(2906002)(74316002)(446003)(7736002)(66446008)(8936002)(68736007)(305945005)(6116002)(9686003)(6306002)(3846002)(11346002)(3480700005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR2101MB0893;H:SN6PR2101MB1072.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YkReqCBulvsW55rHq5L6rlGwT6yp4oLvq7CVMtAZP9lUR2BqgPQA3zZSigiA56hNJSLhh3EKjobuDLyL7wnVKKwEWZ9gpT0wLPZjpZZEdN3MOBuTaOKkfw/1H4rF9a7IZ67UIYwA4DNpxC4WqkB94cQUhQb2/gNRQNZ0ppBv7ZOfWdNfRkEBjlFjFybChW32vBsk3eeRdUxjoFsc2Pi8Pm5e270dhRW/XGEqtdmylT+jOZFx4I/Eskj1rIgRnFSpagAl7WLrLUMF7P4w/EDSQIyaSrNi7wBQDkltJYXd1VQoGz72CGeFHPYy/+qivoqGn7oefbCLO7eNKa2GtITSO6ncUG9LNPmqQhkl7fh3GFIZ4G+fCu9sstk2UGKHSTuVKlzv4SHJYPtEKFwtXh0kmVr5vQjE/NSX+vmlb5r8VLc=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1c8405-6141-4117-a594-08d70490b350
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2019 17:13:02.3035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kys@microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB0893
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmFsZGlzIEtsZXRuaWVr
cyA8dmFsZGlzQHZ0LmVkdT4gT24gQmVoYWxmIE9mIFZhbGRpcyBLbGV0bmlla3MNCj4gU2VudDog
VHVlc2RheSwgSnVseSA5LCAyMDE5IDk6NTEgQU0NCj4gVG86IEtZIFNyaW5pdmFzYW4gPGt5c0Bt
aWNyb3NvZnQuY29tPg0KPiBDYzogTWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+
OyBUaGVvZG9yZSBUcydvDQo+IDx0eXRzb0BtaXQuZWR1PjsgQWxleGFuZGVyIFZpcm8gPHZpcm9A
emVuaXYubGludXgub3JnLnVrPjsgR3JlZyBLcm9haC0NCj4gSGFydG1hbiA8Z3JlZ2toQGxpbnV4
Zm91bmRhdGlvbi5vcmc+OyBsaW51eC1mc2RldmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGV2ZWxAZHJpdmVyZGV2Lm9zdW9zbC5vcmc7IFNhc2hh
IExldmluDQo+IDxzYXNoYWxAa2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IGV4ZmF0IGZpbGVz
eXN0ZW0NCj4gDQo+IE9uIFR1ZSwgMDkgSnVsIDIwMTkgMTY6Mzk6MzEgLTAwMDAsIEtZIFNyaW5p
dmFzYW4gc2FpZDoNCj4gDQo+ID4gTGV0IG1lIGRpZyB1cCB0aGUgZGV0YWlscyBoZXJlLg0KPiAN
Cj4gSW4gY2FzZSB0aGlzIGhlbHBzIGNsYXJpZnkgdGhlIGNoYWluIG9mIGV2ZW50cywgdGhlIGNv
ZGUgaW4gcXVlc3Rpb24gaXMgdGhlDQo+IFNhbXN1bmcgY29kZSBtZW50aW9uZWQgaGVyZSwgdXBk
YXRlZCB0byA1LjIga2VybmVsLi4uLg0KPiANCj4gIldlIGtub3cgdGhhdCBNaWNyb3NvZnQgaGFz
IGRvbmUgcGF0ZW50IHRyb2xsIHNoYWtlZG93bnMgaW4gdGhlIHBhc3Qgb24NCj4gTGludXggcHJv
ZHVjdHMgcmVsYXRlZCB0byB0aGUgZXhmYXQgZmlsZXN5c3RlbS4gV2hpbGUgd2UgYXQgQ29uc2Vy
dmFuY3kNCj4gd2VyZSBzdWNjZXNzZnVsIGluIGdldHRpbmcgdGhlIGNvZGUgdGhhdCBpbXBsZW1l
bnRzIGV4ZmF0IGZvciBMaW51eCByZWxlYXNlZA0KPiB1bmRlciBHUEwgKGJ5IFNhbXN1bmcpLCB0
aGF0IGNvZGUgaGFzIG5vdCBiZWVuIHVwc3RyZWFtZWQgaW50byBMaW51eC4gU28sDQo+IE1pY3Jv
c29mdCBoYXMgbm90IGluY2x1ZGVkIGFueSBwYXRlbnRzIHRoZXkgbWlnaHQgaG9sZCBvbiBleGZh
dCBpbnRvIHRoZQ0KPiBwYXRlbnQgbm9uLWFnZ3Jlc3Npb24gcGFjdC4iDQo+IA0KPiBodHRwczov
L3NmY29uc2VydmFuY3kub3JnL2Jsb2cvMjAxOC9vY3QvMTAvbWljcm9zb2Z0LW9pbi1leGZhdC8N
Cj4gDQo+IChMaW5rIGluIHRoYXQgcGFyYSBwb2ludHMgaGVyZSk6DQo+IGh0dHBzOi8vc2Zjb25z
ZXJ2YW5jeS5vcmcvbmV3cy8yMDEzL2F1Zy8xNi9leGZhdC1zYW1zdW5nLw0KPiANClRoYW5rcyBW
YWxkaXMuIEkgaGF2ZSBzdGFydGVkIGFuIGludGVybmFsIHRocmVhZCBvbiB0aGlzOyB3aWxsIGdl
dCBiYWNrIEFTQVAuDQoNCksuIFkNCg==
