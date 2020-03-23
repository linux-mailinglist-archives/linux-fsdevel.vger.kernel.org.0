Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2E418F5CC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 14:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgCWNe7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 09:34:59 -0400
Received: from mail-eopbgr1300102.outbound.protection.outlook.com ([40.107.130.102]:7392
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728407AbgCWNe6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:34:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciKxsn2+bDYnuU45czYbYfhn4hgkG+wdl3oe24GVviNejUo97uNJeLXTZWlfLbYzq6x6FxHOQvpYdvr9NGkpjZegaWVwMQPDSnQhCnJScYrn7v/zgCjRXR1Ba2WukP3g34aW7cRwzeewjHpTX+6pfAbJykL677YgS4p7egj/jOojynSwbDIb3GO6Ix/+JWmep8DBc/ifJ21w9qj97he05xtbT8RCcSYQ+YHbBc51eIEP+on1hTD+W77EU+RfCDcDBca6h1tzX33kCGkmFmEUGs17v9mAZkzrjSi8ScXJQsjIo0Nxiipn/R9YiYMdXCBF5tkZ+IWNHU4xVOdgVjckEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HISfkdfSxfCDvUWPE4HKszOqCovhgBdtKL6Xd+oke+s=;
 b=I2CHVyjwIOgDF65/ZJDG05Fe1KfOVgqUXhgp48zMGrPV8Y1+g9s4Or0GJ58J08Tv1oOgXYw5v1B8s4c87Vv1SDpZIdCBproseT+3QC7D8FpGuYDcA1zAfKizi6BycwUbOIz6ZfliHHdXnN9OqAnN+WsYoSsOwlvv4SXwel9uW00Mv65gzTV+/UAT3CgJLRyCwnSWfjcGyM5M3VNzpXb3BnnsnSvJ0Ip1bdrlVxFy+BXBle5BRfwzmYrpb5CM1K8UE7uQQiMLITJ+CvR/rZkCElJIeeMoH/EDmLq4gmQRIfy7KKwmknPTYQ8bne7brQNLtI68bJmu14mst3YuCElogQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HISfkdfSxfCDvUWPE4HKszOqCovhgBdtKL6Xd+oke+s=;
 b=WMHG4syFpBB6RsdJVPmvSLASIePu4OYE7VhML/z++dj9QvKJBn6Tpcsz/saJivbGaCDHBPWtPsuF3k9g2u5V4bHDQPOaTI9298okBYRuLqsj+YTJa8VYuAGHYSYckZkqDqtfD+hQdEN7dDYoNb5KX1KdKwQa8EJcszxTNkYGkjc=
Received: from TY2P153MB0224.APCP153.PROD.OUTLOOK.COM (20.178.144.138) by
 TY2P153MB0223.APCP153.PROD.OUTLOOK.COM (20.178.148.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.2; Mon, 23 Mar 2020 13:34:52 +0000
Received: from TY2P153MB0224.APCP153.PROD.OUTLOOK.COM
 ([fe80::5cc4:e2ba:5714:ad5b]) by TY2P153MB0224.APCP153.PROD.OUTLOOK.COM
 ([fe80::5cc4:e2ba:5714:ad5b%6]) with mapi id 15.20.2878.000; Mon, 23 Mar 2020
 13:34:51 +0000
From:   Nilesh Awate <Nilesh.Awate@microsoft.com>
To:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
CC:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Fanotify Ignore mask
Thread-Topic: [EXTERNAL] Re: Fanotify Ignore mask
Thread-Index: AdYAcWA85bxd3AqDTsC7u6B9RogQewAmOn0AAAJRqQAAAQOicA==
Date:   Mon, 23 Mar 2020 13:34:51 +0000
Message-ID: <TY2P153MB022430EDF9F91E7F457667739CF00@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
References: <TY2P153MB0224EE022C428AA2506AD1879CF30@TY2P153MB0224.APCP153.PROD.OUTLOOK.COM>
 <20200323115756.GA28951@quack2.suse.cz>
 <CAOQ4uxixHS6p44DObK=raGjmRUjLVoCozhpv_H85gUcdftOeRg@mail.gmail.com>
In-Reply-To: <CAOQ4uxixHS6p44DObK=raGjmRUjLVoCozhpv_H85gUcdftOeRg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=nawate@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-03-23T13:34:50.2686703Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=fd1e201f-2b5f-4007-8326-7a74d7d79128;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nilesh.Awate@microsoft.com; 
x-originating-ip: [2404:f801:8028:1:34e0:aea6:e1f2:809f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9bab0bd7-bafd-4398-e219-08d7cf2ef733
x-ms-traffictypediagnostic: TY2P153MB0223:
x-microsoft-antispam-prvs: <TY2P153MB0223CBCD1D0552B2370457C49CF00@TY2P153MB0223.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0351D213B3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(86362001)(966005)(66556008)(8990500004)(66446008)(66946007)(66476007)(64756008)(76116006)(4326008)(7696005)(55016002)(53546011)(9686003)(6506007)(478600001)(10290500003)(5660300002)(52536014)(316002)(2906002)(33656002)(110136005)(8936002)(81156014)(8676002)(186003)(81166006)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:TY2P153MB0223;H:TY2P153MB0224.APCP153.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWgyry19oV9swFDOwt/u6dZo9DlnYTQ6rnVoy/9XOPWkJ254VXM1RDbodfBZdTz7q4SEVNrRVff7VovDMb3G+tQgPv6Xeqwseo04rvbkQ+DCP/3RJ3WyuGRdVPU1d9vNRL230RS0SQGH+0lawQsbKKPauP2HhZE64kjDya+x1DUGQVszUYyMD8M7okas6gFjQ7EoB5y5x87/7tV+7I1kANI12XJw4WKUquv9YO1PGF39Z5K+B4DyJDiRWcW+jX8gbQiBIY9Y2nAuUbWkn4zqxrLTH0pKkYUxovJB205x/YuvMoT+OaPUnh9bcUoCjqwiXIUc8Ggi/IVNpiJTUoml7XqghOkScgH5MFoZIzBE+GBt1fLa9jtacDrd0XB+BqpCA3NSYOALz+a3LTJJW2Q5c8/NH7kFto0GChCQI9XQ/gyuK3iKSjH8DdVNYI8EZMJcPJ1scYFv33XDtj13gNxE500Iypv/2ECIcAAseyuSEfDwDqpGrGln/oI5+rylWxhwpoLsnsvrpB8kGQXUi2YKzQ==
x-ms-exchange-antispam-messagedata: 1Yqhm5k3udqqcf8NWTyRvDiHgp/QFdSKGjQ8qp5yD/Kl79D08R1EviDOqbwIUSZ8Qc83vtp3raUYSzkj07iqqMzNeeFtjYy07ap3jYSJO1oFYk3qbUa3tLPvqTqpBguXtd8OF3rub5ViDopuuUBTxrmYL17G7CJM2YiiP7Z4t4RWTRI82+fifaQH14gP3r3X3tWJSLodwYCQ+2f9QO4+WA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bab0bd7-bafd-4398-e219-08d7cf2ef733
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2020 13:34:51.6323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlpeXCCe5w0yCEVFpIw/MQ+md063M5V/yk/x6e8Kz3kiXK1WhPnKVW+JhNC6JwqIDsdsZvSl5D+mBlaTmhyYWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2P153MB0223
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgSmFuLCBBbWlyIC0NCg0KVGhhbmsgeW91IGZvciBxdWljayByZXNwb25kIQ0KDQpZZXMgd2l0
aCBtb3VudCAtLWJpbmQgL29wdCAvb3B0IGFuZCB0aGVuIGFkZGluZyBpZ25vcmUgbWFzayBpdCB3
b3JrcyBhcyBleHBlY3RlZC4gDQoNClJlZ2FyZHMsDQpOaWxlc2gNCg0KLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCkZyb206IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IA0K
U2VudDogTW9uZGF5LCBNYXJjaCAyMywgMjAyMCA2OjM0IFBNDQpUbzogSmFuIEthcmEgPGphY2tA
c3VzZS5jej4NCkNjOiBOaWxlc2ggQXdhdGUgPE5pbGVzaC5Bd2F0ZUBtaWNyb3NvZnQuY29tPjsg
bGludXgtZnNkZXZlbCA8bGludXgtZnNkZXZlbEB2Z2VyLmtlcm5lbC5vcmc+DQpTdWJqZWN0OiBb
RVhURVJOQUxdIFJlOiBGYW5vdGlmeSBJZ25vcmUgbWFzaw0KDQpPbiBNb24sIE1hciAyMywgMjAy
MCBhdCAxOjU3IFBNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3RlOg0KPg0KPg0KPiBIZWxs
byBOaWxlc2ghDQo+DQo+IE9uIFN1biAyMi0wMy0yMCAxNzo1MDo1MCwgTmlsZXNoIEF3YXRlIHdy
b3RlOg0KPiA+IEknbSBuZXcgdG8gRmFub3RpZnkuIEknbSBhcHByb2FjaGluZyB5b3UgYmVjYXVz
ZSBJIHNlZSB0aGF0IHlvdSBoYXZlIGRvbmUgZ3JlYXQgd29yayBpbiBGYW5vdGlmeSBzdWJzeXN0
ZW0uDQo+ID4NCj4gPiBJJ3ZlIGEgdHJpdmlhbCBxdWVyeS4gSG93IGNhbiB3ZSBpZ25vcmUgZXZl
bnRzIGZyb20gYSBkaXJlY3RvcnksIElmIHdlIGhhdmUgbWFyayAiLyIgYXMgbW91bnQuDQo+ID4N
Cj4gPiBmZCA9IGZhbm90aWZ5X2luaXQoRkFOX0NMT0VYRUMgfCBGQU5fQ0xBU1NfQ09OVEVOVCB8
IEZBTl9OT05CTE9DSywNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgIE9fUkRPTkxZIHwgT19M
QVJHRUZJTEUpOw0KPiA+DQo+ID4gcmV0ID0gZmFub3RpZnlfbWFyayhmZCwgRkFOX01BUktfQURE
IHwgRkFOX01BUktfTU9VTlQsICBGQU5fT1BFTl9QRVJNIHwgRkFOX0NMT1NFX1dSSVRFLA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQVRfRkRDV0QsICIvIikgOw0KPiA+
DQo+ID4gTm93IEkgZG9uJ3Qgd2FudCBldmVudHMgZnJvbSAiL29wdCIgZGlyZWN0b3J5IGlzIGl0
IHBvc3NpYmxlIHRvIGlnbm9yZSBhbGwgZXZlbnRzIGZyb20gL29wdCBkaXJlY3RvcnkuDQo+ID4N
Cj4gPiBJIHNlZSBleGFtcGxlcyBmcm9tIA0KPiA+IGh0dHBzOi8vbmFtMDYuc2FmZWxpbmtzLnBy
b3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpDQo+ID4gdGh1Yi5jb20l
MkZsaW51eC10ZXN0LXByb2plY3QlMkZsdHAlMkZibG9iJTJGbWFzdGVyJTJGdGVzdGNhc2VzJTJG
a2UNCj4gPiBybmVsJTJGc3lzY2FsbHMlMkZmYW5vdGlmeSUyRmZhbm90aWZ5MDEuYyZhbXA7ZGF0
YT0wMiU3QzAxJTdDTmlsZXNoLg0KPiA+IEF3YXRlJTQwbWljcm9zb2Z0LmNvbSU3QzYzOTNmZmFj
NTQxYTRlMmNlMGRiMDhkN2NmMmFiYTg3JTdDNzJmOTg4YmY4DQo+ID4gNmYxNDFhZjkxYWIyZDdj
ZDAxMWRiNDclN0MxJTdDMCU3QzYzNzIwNTY1NTE5NTQ4OTQwNiZhbXA7c2RhdGE9ejhUbU0NCj4g
PiA1eVZCQzVoZCUyRmVnTmt4dSUyRlZhVHFKOWtURW9mbHlYZEVtRm8wbmMlM0QmYW1wO3Jlc2Vy
dmVkPTANCj4gPiBCdXQgdGhleSBhbGwgdGFraW5nIGFib3V0IGEgZmlsZS4gQ291bGQgeW91IHBs
cyBoZWxwIG1lIGhlcmUuDQo+DQo+IFRoZXJlJ3Mgbm8gd2F5IGhvdyB5b3UgY291bGQgJ2lnbm9y
ZScgZXZlbnRzIGluIHRoZSB3aG9sZSBkaXJlY3RvcnksIA0KPiBsZXQgYWxvbmUgZXZlbiB0aGUg
d2hvbGUgc3VidHJlZSB1bmRlciBhIGRpcmVjdG9yeSB3aGljaCB5b3Ugc2VlbSB0byBpbXBseS4N
Cj4gSWdub3JlIG1hc2sgcmVhbGx5IG9ubHkgd29yayBmb3IgYXZvaWRpbmcgZ2VuZXJhdGluZyBl
dmVudHMgZnJvbSANCj4gaW5kaXZpZHVhbCBmaWxlcy4gQW55IG1vcmUgc29waGlzdGljYXRlZCBm
aWx0ZXJpbmcgbmVlZHMgdG8gaGFwcGVuIGluIA0KPiB1c2Vyc3BhY2UgYWZ0ZXIgZ2V0dGluZyB0
aGUgZXZlbnRzIGZyb20gdGhlIGtlcm5lbC4NCg0KVGhlcmUgaXMgbm8gd2F5IHNvIHNldCBhbiAn
aWdub3JlJyBtYXNrLCBidXQgaXQgaXMgcG9zc2libGUgdG8gdXNlIHRoZSBmYWN0IHRoYXQgdGhl
IG1hcmsgaXMgYSAnbW91bnQnIG1hcmsuDQpCeSBtb3VudGluZyBhIGJpbmQgbW91bnQgb3ZlciAv
b3B0IChtb3VudCAtbyBiaW5kIC9vcHQgL29wdCkgb3BlcmF0aW9ucyB3aXRoaW4gdGhlIC9vcHQg
c3VidHJlZSAoaWYgcGVyZm9ybWVkIGZyb20gdGhpcyBtb3VudCBucyBhbmQgd2l0aCBwYXRoIGxv
b2t1cCBkb25lIGFmdGVyIG1vdW50aW5nIHRoZSBiaW5kIG1vdW50KSwgd2lsbCBub3QgZ2VuZXJh
dGUgZXZlbnRzIHRvIHRoZSBtb3VudCBtYXJrIG9uIC8uDQoNClRoYW5rcywNCkFtaXIuDQo=
