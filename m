Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9643F9E1B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 19:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbhH0Rkr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 13:40:47 -0400
Received: from mx0a-0038a201.pphosted.com ([148.163.133.79]:44976 "EHLO
        mx0a-0038a201.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230035AbhH0Rkq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 13:40:46 -0400
X-Greylist: delayed 516 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Aug 2021 13:40:46 EDT
Received: from pps.filterd (m0171340.ppops.net [127.0.0.1])
        by mx0a-0038a201.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RHT559029119
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 17:31:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0038a201.pphosted.com with ESMTP id 3apnqb1ju0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 27 Aug 2021 17:31:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3y/OJzlqIWHSV3cOi0z70b1ThOg3bnn5CMVmkFEAkM5Q5AUaLF3yii/pBF1ADmyLRFjyBWN6YQ2XklQewjaBNnPfeZCKWEuUf4zqULZxtM+6IJ/y0skUvo5HZwusGgaLIXwxfu7HIniFV90TJMGm2T7keXPpyD80WfjZ5+GlLuaZSTJRbl5isx/sD4W/0r4XvrbZZ5WR+u4NiKfsus9qjZ47+mQ5w10PyYVB4vBytR/HURvSD/JkMI9DlIQSwrZl46RYJuorzvUrFeWwshnG3FpHIpE9K1sKcbWe1WRlj6EA2BsYQVQj0c16jimGm5SSVpk/pxrxkKsX/rfHBHXDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9zzLBEZdHt9313K/bvPYMtEY15MP5R6F0bX7GhmtKo=;
 b=aYVVEGDd7gJs6VJtyU0jDKcImjYlJnSOwvWs6IEjjkUypd5ed7EWGJQwkTuaBZ9nGAELVGJd4WsNvyj+iuyFtJomF3928FLoHIwz9V77c0RN9U5yCau0q/9t/lg4/SGCVmJdbaBHRZId+hofAXaaEYUeRDEl8NSguCTJXvNwzi67rlVfhjO1MO+xvqKfQW8nFxd8HXa1rh3RwtVNh8hZVeE976zuzfZGYhnvomepH2/QZsz9ApZY8r1pRa4KPTX1yLSRSPQIw2WyC+153zuvBRhhd7yZmuW8yqDioYGjgkwdOHNYiIdfD8zEk7aOT2LirORDSaBbxXILC2dDb25qLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jumptrading.com; dmarc=pass action=none
 header.from=jumptrading.com; dkim=pass header.d=jumptrading.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jumptrading.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9zzLBEZdHt9313K/bvPYMtEY15MP5R6F0bX7GhmtKo=;
 b=Zzcrs7sg53knDmeHL1XXcuIZE17Q2v2XUJ9r8lOEQmdXI0u4P6pNs0WKElwhMZA1OVSqf5szrWAa/9m9UZCQ0bDU7zf5Bh1QIp3md433i6D1zndBoa3/oWBbzFFyqNLxohnquvVZp1zohasS8yN/8RjAnh/v8rZ/eItavPv3RKM=
Received: from CH2PR14MB4104.namprd14.prod.outlook.com (2603:10b6:610:7f::16)
 by CH2PR14MB3563.namprd14.prod.outlook.com (2603:10b6:610:63::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 27 Aug
 2021 17:31:18 +0000
Received: from CH2PR14MB4104.namprd14.prod.outlook.com
 ([fe80::f1fb:648:6dac:99f4]) by CH2PR14MB4104.namprd14.prod.outlook.com
 ([fe80::f1fb:648:6dac:99f4%5]) with mapi id 15.20.4436.027; Fri, 27 Aug 2021
 17:31:18 +0000
From:   Teng Qin <tqin@jumptrading.com>
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [FUSE] notify_store usage: deadlocks with other read / write requests
Thread-Topic: [FUSE] notify_store usage: deadlocks with other read / write
 requests
Thread-Index: AdeZ8rM258neq6zBQ6uAJij+XB6GmABdlqvQ
Date:   Fri, 27 Aug 2021 17:31:18 +0000
Message-ID: <CH2PR14MB41040692ABC50334F500789ED6C89@CH2PR14MB4104.namprd14.prod.outlook.com>
References: <CH2PR14MB410492CB0C3AB8EA0833F963D6C69@CH2PR14MB4104.namprd14.prod.outlook.com>
In-Reply-To: <CH2PR14MB410492CB0C3AB8EA0833F963D6C69@CH2PR14MB4104.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=jumptrading.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c4aebb9-3c5b-4794-8251-08d969807a9b
x-ms-traffictypediagnostic: CH2PR14MB3563:
x-microsoft-antispam-prvs: <CH2PR14MB3563159D16F72BFA6514D04AD6C89@CH2PR14MB3563.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqhsx7eZhs8+2O0TG11GIwW4towN2XhrdzpxZgoj5iA5n8AvXLzQnMe5r4bgtWG45P5h/uKaAQsHE2+UhMHDatYoEW12Y0Rzz0Ry+UJKBV5HqjjNMdATH2frBi9H0u/KgXvelrNeCG8Cg839bV+gTz9y5XnvciNRfQc9x4i8QO9T3RamL9dGy4r1TQcdiEV66gxpRGi3CxKiUPdm1Bo3OXXiQjeMMjFkcGJvmVRSP6kkyCg2yEgDju4NJEegwaklQFehr4lALj7lPa2bsg7n2jVpMNqYkKL1mUMIuA+bvoozU92KxuJQbs6NRfF7X8h8DS6LckLF779CD/r7bT+sBpmo9b3p7Ud5b2o52w8KvSrRoovpBAXNLsrAXoDVbBRrTh5FM2x4SfyQnuhtzW195Kc3r4w9ejlgR3CNZ6HkHRDUrG5ENAhoMtTCAFsuZtrwsnbp8c+PYTecDHWyGNli8BSEo7dBal6rcqnlCmhUBRuiOu1nOt0UeBNGPZgnSN05BXuu+NVttE3rMkTRbkilBcPYE45STnqZVug7HPEgU5tV0sl2NKvYNKn3DhTCnlTWK/ZGOATdONVOp0Uy24QpAwzPC2Bwxppty+GcQpm5wuEboWf9fLPDa1Yje59l7q3pk4qVIynYm/wgjEP5yc2yHcEuubHGp8kuCvzvWpdxexrI6VSYOJlgNghgBSkuUEhwMknaOWUhPh9GoDCD4nYf+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR14MB4104.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(64756008)(66446008)(66476007)(66946007)(2906002)(83380400001)(8676002)(66556008)(6916009)(33656002)(76116006)(122000001)(316002)(26005)(38070700005)(38100700002)(478600001)(7696005)(86362001)(6506007)(5660300002)(8936002)(52536014)(186003)(9686003)(55016002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SytqdlhPRUtBWm13Q1RCWVlwK21KeGxwSXZTWGFxQld4U2JuWFI5TXhtbytX?=
 =?utf-8?B?K3BLYk5RQUNsRWVSWTVlei93TXM3VytKM2FXNmtKUlJHTlBvZXNmbmtIdDZ2?=
 =?utf-8?B?dDBYZ0hKZWg1VFdLSVo4VE9SbmJLMitsbTRjVjZ3ejVKaWk1ZGI5WmRVdSsr?=
 =?utf-8?B?eE5GUGJvNUlocXBaN0lRMTlZMVUzUXFLOE5YeGM1UUNRMkFsL3VTSVBTYU9u?=
 =?utf-8?B?OXVsamluL2dyT0NKSEZqN0dUbnFYWDViWUU0aE9QbWowNTk2M1RMZkJmV2xH?=
 =?utf-8?B?R1RCZ0h2RlhKa2lRdjYrTkFTUDN6NktNUTloUkc3YVNKbmpSYW1zRGZMZXRR?=
 =?utf-8?B?UEROTHVZekEzVUZxL04zVTZicDlsK1M4V3c3UktqM0Z3NWgvTDJEQzRuL0Nw?=
 =?utf-8?B?Zk5UTUlKckxuTVhDRjFsc045T3JnaExrb0hjNnpNaUc3NWtqb2RkS3NpRHB1?=
 =?utf-8?B?b09XN1VaUmxpVCtub1cvSG50bWFyVm4xNFcvNURFSkZzeDZOcXM5NG9YOCtS?=
 =?utf-8?B?cDVqbGdEYmMzZlNvMmRSRlhmYTdKanB2aXRkcTluTGpUQWJrYWJseVZpOE9m?=
 =?utf-8?B?bkFUYjU0NndneGJRV1J6cGh0NlhqY3FJTjA5M0FndG5LMUhab3BQdDBRTG1Z?=
 =?utf-8?B?SU11LzBBV3hrOUJ5TEJpOE5TeXhnOU56RWxmUllUMnJ5RXNxdmRsZk56d1NN?=
 =?utf-8?B?YzdFZmoraWEzV1FGUG9Bc1IvbUlSQVZUR2s2Nmk3Ymg0MUZZUCt1SzlDVGxK?=
 =?utf-8?B?TDlRRHZrcWxrY3hCTjh2cHUyWEFtWURzN0NrMnNHRGZ2a0ZSQVZ1MFdWeDEr?=
 =?utf-8?B?c1I1cElPaEIwcXZiRVJIbkc3L2ZidTZ2MFgwd1EyTFhZRHh5UmJFYUxGS0NL?=
 =?utf-8?B?MVIzY2RkdStSZFpkMWFLV1Q2clJhemRYaWFrcUlONDBpR0hNZ0l5OElFb2Nj?=
 =?utf-8?B?RGJOVWFQSXZoTk5VNENKa3J6U0tJZWJXQnNlYjJpR1MycFpvWlh3R1Z3RnBv?=
 =?utf-8?B?SWtmQnViekZXdTdRenBoRXovK1RxMkNPR2pYTkh3QkJ4VTUyNGZOSjZJY1RP?=
 =?utf-8?B?L1lvSW4rNFREYkIzUlp2RlVRQkJuVXd1dCt4Z0pVblFlcXJ4TkFrckdDbGw3?=
 =?utf-8?B?SjBZVllBQURsNzZNeWdqQzlvOGNrNWhML015bGhRNkNvbUxKeno5QWNTOWl5?=
 =?utf-8?B?cHdCclI5SmxlMVA0aTEzZXlscVF4ZkF0ZGk0cktzNzdzdWNLOGVScmxhR0Rj?=
 =?utf-8?B?Wk9iU2tmWHluM2hCajMrbzJiSzZoN2FmM3A2SUN6RENtbGtTMm1Mc1lLNCtR?=
 =?utf-8?B?R1dKS1luckNWMENVZkZoZ01yRTM0akVpemdPZTZqc2RReUlDeVZFSXk5TzRj?=
 =?utf-8?B?ajY5ZFU2OEdzeVRZR3RRN3A3S2xVMll3RnRIREJ1N3V5M0gzNnppVU1udmVK?=
 =?utf-8?B?Y0ZkaHFPOC9DcVdWdnNoOHZ1OE9Ec2NBSktITWFwMjBwbXQrRml5d041QXcw?=
 =?utf-8?B?NS82dW9UTWJOeVBQOFNmTFpFT084ZlRxdENBVWIxRTV4V2JrN1djTmFiYzNN?=
 =?utf-8?B?aEkrb29QMm82K0YrdGpsRmhWWFpST1hudzdmalF4UnZNUWFBaWVpWmpPYWly?=
 =?utf-8?B?Q2pVbGRIVXNXUmhBZVpkNURwN0x4cXkvZHVMV254NWEwczRaL0U3bXk2VnlY?=
 =?utf-8?B?dzRPb2oyaGdJQy82MUYxYXUzZW1KaFQwSDA3ZHpteG9HY0g2VVkzenY0TldD?=
 =?utf-8?Q?thfa3YV42dyYbvajXw=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: jumptrading.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR14MB4104.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4aebb9-3c5b-4794-8251-08d969807a9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2021 17:31:18.1755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 11f2af73-8873-4240-85a3-063ce66fc61c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /EPGicGUcKRrQxEnOTTAeUKoOfj/E59damGsN2V+nQ57982e6lf3/WKY2HDmCfjSrVPCz8s8bgRQ7AoXdjz1sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR14MB3563
X-Proofpoint-GUID: AXlDLeydV1sUHf_RuHFv0CqoBI5bRZoY
X-Proofpoint-ORIG-GUID: AXlDLeydV1sUHf_RuHFv0CqoBI5bRZoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-27_05,2021-08-27_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270104
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SSBhbSBkZXZlbG9waW5nIGEgZmlsZSBzeXN0ZW0gdGhhdCBoYXMgdW5kZXJseWluZyBibG9jayBz
aXplIHdheSBsYXJnZXIgdGhhbiB0aGUgbnVtYmVyIG9mIHBhZ2VzIFZGUyB3b3VsZCByZXF1ZXN0
IHRvIHRoZSBGVVNFIGRhZW1vbiAoMk1CIC8gNE1CIHZzIDMyIHBhZ2VzID0gMTI4SykuDQpJIGN1
cnJlbnRseSBjYWNoZSB0aGUgYmxvY2sgZGF0YSBpbiB1c2VyIHNwYWNlLCBidXQgaXQgd291bGQg
YmUgbW9yZSBpZGVhbCB0byBoYXZlIEtlcm5lbCBtYW5hZ2UgdGhpcyB3aXRoIHBhZ2UgY2FjaGUs
IGFuZCBzYXZlIHJvdW5kLXRyaXBzIGJldHdlZW4gVkZTIGFuZCBGVVNFIGRhZW1vbi4gU28gSSB3
YXMgbG9va2luZyBhdCB1c2UgRlVTRV9OT1RJRllfU1RPUkUgdG8gcHJvYWN0aXZlbHkgb2ZmZXIg
dGhlIGRhdGEgdG8gS2VybmVsLiBIb3dldmVyLCBJIGZvdW5kIHRoYXQgdGhlIG5vdGlmeSBzdG9y
ZSBvZnRlbiBkZWFkbG9ja3Mgd2l0aCB1c2VyIHJlYWQgcmVxdWVzdHMuDQoNCkZvciBleGFtcGxl
LCBzYXkgdGhlIHVzZXIgcHJvY2VzcyBpcyBkb2luZyBzZXF1ZW50aWFsIHJlYWQgZnJvbSBvZmZz
ZXQgMC4NCktlcm5lbCByZXF1ZXN0cyBhIDEyOEsgcmVhZCB0byBGVVNFIGRhZW1vbiBhbmQgSSBm
ZXRjaCB0aGUgMk1CIGJsb2NrIGZyb20gdW5kZXJseWluZyBzdG9yYWdlLiBBZnRlciByZXBseWlu
ZyB0aGUgcmVhZCByZXF1ZXN0LCBJIHdvdWxkIGxpa2UgdG8gb2ZmZXIgdGhlIHJlc3Qgb2YgdGhl
IDE5MjBLIGRhdGEgdG8gS2VybmVsIGZyb20gb2Zmc2V0IDEyOEsuIEhvd2V2ZXIsIGF0IHRoaXMg
cG9pbnQgS2VybmVsIG1vc3QgbGlrZWx5IGFscmFlZHkgc3RhcnRlZCB0aGUgbmV4dCByZWFkIHJl
cXVlc3QgYWxzbyBhdCBvZmZzZXQgMTI4SywgYW5kIGhhdmUgdGhvc2UgcGFnZSBsb2NrZWQ6DQoN
CiAgd2FpdF9vbl9wYWdlX2xvY2tlZF9raWxsYWJsZQ0KICBnZW5lcmljX2ZpbGVfYnVmZmVyZWRf
cmVhZA0KICBnZW5lcmljX2ZpbGVfcmVhZF9pdGVyDQoNCk9uIHRoZSBvdGhlciBoYW5kLCB0aGUg
bm90aWZ5IHN0b3JlIGlzIGFsc28gd2FpdGluZyBvbiBsb2NraW5nIHRob3NlIHBhZ2VzOg0KDQog
IF9fbG9ja19wYWdlDQogIF9fZmluZF9sb2NrX3BhZ2UNCiAgZmluZF9vcl9jcmVhdGVfcGFnZQ0K
ICBmdXNlX25vdGlmeV9zdG9yZQ0KDQpUaGlzIG5vcm1hbGx5IGRlYWRsb2NrcyB0aGUgRlVTRSBk
YWVtb24uDQoNClRoZSBub3RpZnkgc3RvcmUgaXMgYSBwcmV0dHkgb2xkIGZlYXR1cmUgc28gSSdt
IG5vdCBzdXJlIGlmIHRoaXMgaXMgcmVhbGx5IGFuIGlzc3VlIG9yIEknbSB1c2luZyBpdCB3cm9u
Zy4gSSB3b3VsZCBiZSB2ZXJ5IGdyYXRlZnVsIGlmIGFueW9uZSBjb3VsZCBoZWxwIG1lIHdpdGgg
c29tZSBpbnNpZ2h0cyBvbiBob3cgdGhpcyBpcyBpbnRlbmRlZCB0byBiZSB1c2VkLiBPbiB0aGUg
b3RoZXIgaGFuZCwgSSB3YXMgdGhpbmtpbmcgbWF5YmUgd2UgY291bGQgc3VwcG9ydCBhbiBhc3lu
YyBub3RpZnkgc3RvcmUgcmVxdWVzdHMuIFdoZW4gdGhlIEtlcm5lbCBtb2R1ZWxzIGdldHMgdGhl
IHJlcXVlc3RzLCBpZiBpdCBjYW4gbm90IGFjcXVpcmUgbG9jayBvbiB0aGUgcmVsZXZhbnQgcGFn
ZXMsIGl0IGNvdWxkIGp1c3Qgc3RvcmUgdGhlIHVzZXIgcHJvdmlkZWQgZGF0YSBpbiBkaXMtYXR0
YWNoZWQgcGFnZSBzdHJ1Y3RzLCBhZGQgdGhlbSB0byBhIGJhY2tncm91bmQgcmVxdWV0c3MsIGFu
ZCB0cnkgbGF0ZXIuIElmIHBlb3BsZSBhcmUgT0sgd2l0aCBzdWNoIGlkZWFzLCBJIHdvdWxkIGJl
IG1vcmUgdGhhbiBoYXBweSB0byB0cnkgd2l0aCBhbiBpbXBsZW1lbnRhdGlvbi4NCg0KVGhhbmsg
eW91IHZlcnkgbXVjaCBmb3IgaGVscCBpbiBhaGVhZCENCg0KX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18NCg0KTm90ZTogVGhpcyBlbWFpbCBpcyBmb3IgdGhlIGNvbmZpZGVudGlhbCB1
c2Ugb2YgdGhlIG5hbWVkIGFkZHJlc3NlZShzKSBvbmx5IGFuZCBtYXkgY29udGFpbiBwcm9wcmll
dGFyeSwgY29uZmlkZW50aWFsLCBvciBwcml2aWxlZ2VkIGluZm9ybWF0aW9uIGFuZC9vciBwZXJz
b25hbCBkYXRhLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCB5b3UgYXJl
IGhlcmVieSBub3RpZmllZCB0aGF0IGFueSByZXZpZXcsIGRpc3NlbWluYXRpb24sIG9yIGNvcHlp
bmcgb2YgdGhpcyBlbWFpbCBpcyBzdHJpY3RseSBwcm9oaWJpdGVkLCBhbmQgcmVxdWVzdGVkIHRv
IG5vdGlmeSB0aGUgc2VuZGVyIGltbWVkaWF0ZWx5IGFuZCBkZXN0cm95IHRoaXMgZW1haWwgYW5k
IGFueSBhdHRhY2htZW50cy4gRW1haWwgdHJhbnNtaXNzaW9uIGNhbm5vdCBiZSBndWFyYW50ZWVk
IHRvIGJlIHNlY3VyZSBvciBlcnJvci1mcmVlLiBUaGUgQ29tcGFueSwgdGhlcmVmb3JlLCBkb2Vz
IG5vdCBtYWtlIGFueSBndWFyYW50ZWVzIGFzIHRvIHRoZSBjb21wbGV0ZW5lc3Mgb3IgYWNjdXJh
Y3kgb2YgdGhpcyBlbWFpbCBvciBhbnkgYXR0YWNobWVudHMuIFRoaXMgZW1haWwgaXMgZm9yIGlu
Zm9ybWF0aW9uYWwgcHVycG9zZXMgb25seSBhbmQgZG9lcyBub3QgY29uc3RpdHV0ZSBhIHJlY29t
bWVuZGF0aW9uLCBvZmZlciwgcmVxdWVzdCwgb3Igc29saWNpdGF0aW9uIG9mIGFueSBraW5kIHRv
IGJ1eSwgc2VsbCwgc3Vic2NyaWJlLCByZWRlZW0sIG9yIHBlcmZvcm0gYW55IHR5cGUgb2YgdHJh
bnNhY3Rpb24gb2YgYSBmaW5hbmNpYWwgcHJvZHVjdC4gUGVyc29uYWwgZGF0YSwgYXMgZGVmaW5l
ZCBieSBhcHBsaWNhYmxlIGRhdGEgcHJvdGVjdGlvbiBhbmQgcHJpdmFjeSBsYXdzLCBjb250YWlu
ZWQgaW4gdGhpcyBlbWFpbCBtYXkgYmUgcHJvY2Vzc2VkIGJ5IHRoZSBDb21wYW55LCBhbmQgYW55
IG9mIGl0cyBhZmZpbGlhdGVkIG9yIHJlbGF0ZWQgY29tcGFuaWVzLCBmb3IgbGVnYWwsIGNvbXBs
aWFuY2UsIGFuZC9vciBidXNpbmVzcy1yZWxhdGVkIHB1cnBvc2VzLiBZb3UgbWF5IGhhdmUgcmln
aHRzIHJlZ2FyZGluZyB5b3VyIHBlcnNvbmFsIGRhdGE7IGZvciBpbmZvcm1hdGlvbiBvbiBleGVy
Y2lzaW5nIHRoZXNlIHJpZ2h0cyBvciB0aGUgQ29tcGFueeKAmXMgdHJlYXRtZW50IG9mIHBlcnNv
bmFsIGRhdGEsIHBsZWFzZSBlbWFpbCBkYXRhcmVxdWVzdHNAanVtcHRyYWRpbmcuY29tLg0K
