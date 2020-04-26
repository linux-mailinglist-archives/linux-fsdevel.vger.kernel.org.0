Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4293A1B94AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Apr 2020 01:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDZX7d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Apr 2020 19:59:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44616 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgDZX7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Apr 2020 19:59:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587945586; x=1619481586;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=xsailwaLcA/qwg/HKI4dlYldD6vfStkab6Ifb4WgCqc=;
  b=JioAFDy25zkjBHggLlc5bs+LnkAPXs5ocq37nkUcHdq/L8F1EektwvBw
   gOW2LgOWZhaFfNh3nwBz4VoOukO7qlBuNLCE/sAyt16ASv9erD3p5rPFt
   uEgzDDbtklA3PhWyjVNiq0ATzykzmc05Fuje6udS825rAaVPq3KC+3yx1
   AS/oUSLD/3ozPANJNSyj2xMNRHHpBLirnxURF2XZDrlEp6hijYIikttIh
   XKaJRyFje2Q5hhqzkAmftFLPEiK+809QsY8ipoUemUlUtKoTHJDKq80HK
   sY3lLQ40vJURrfD3kacH2x4e8Hf3ETUlIxuX0mWRAHNOXbcB6rrsIw6Od
   Q==;
IronPort-SDR: 8Vi6CoLYncHNOyZOIHrffm99E6/c7zL7OgFUjRAy7XnDVo93113JKyFMFU+3SZz383RAbyCHmv
 ECCgxRRw8WQ3AJwlMiuJMydCLuqbX7Sj6l0iuXDf/a2Z6AdKuuBgR7lBTjIacB50AIj/alkto6
 vhA0gKHDADUC1MLMpkFHLZjajcLDzobno1nvmL8ZIiwjroY5nm0VwahyAaLXHbnQ/3zteJ6E5S
 zz/W7GUUjZ22Rvn7nyOTyIsD5zBUipX9N+a71o2m+049si/S3qqyRgAFjJgUu9LaQ1Et/5I1yA
 HgY=
X-IronPort-AV: E=Sophos;i="5.73,321,1583164800"; 
   d="scan'208";a="238735123"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2020 07:59:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeLWTbbcjHvyK+SNzgQuxcTTZbijZCxFmncTffrwEiE6GEo7Zy0sc3bIsfSEc25VULA84NO+V4hgD/FMIVQ5r1+tpivi7nfzqsbBYk7AZt5qpXjzP1gRP/rrpfjhfpWIADCWlR7LUuRUrFwenLc+gTM7UUXtcnx8BdM980wvnqn8enjKcfL/JhYncCeNMvRyq3IXi5usrK28hZvo8KXNrmG+bLc9rajar8UCozr6r33hFvJaYezzbJaHHI0iBNAW4F2ShvJX1U0zmsnsMbJciWIxZ6AX9WKidVyCNI344tv9Q70NC9ZTg/YyomC4ui3N+hE63C05qVkgMm2qhOFWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsailwaLcA/qwg/HKI4dlYldD6vfStkab6Ifb4WgCqc=;
 b=lKOxVY7UmbTwO0tFXCXQ14+bDiPyMweLQwQTtGOwhkwk77mPMOCLU33+mfb7bjfo4S8BasCmoUOH5AbV2Ad/OuFZz/aZVXra0Dsr5dsQZqiu1nmM4ed+TYv5mlY84yV4NfruLj7XtKNJsEGeD89hLgg6olrJiboccPmFIW6A3YMbpWUS/WaUuPK1dz5RHEyxAcmfqVTwuYNFNuRF4hCzHm8WnkabeMiMKEJUz3f/o8ui2yu1PKnUucmPsGcBSOIl+ARfbXpLtvbPb0U0Ng34lxVY66aO2RuiFwvuZ/0UroJMgaByZfyar01fsEBMosvz8CF8yiVUYCIr79meV0oNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xsailwaLcA/qwg/HKI4dlYldD6vfStkab6Ifb4WgCqc=;
 b=D5x3/pwjt0Ke+pcM0MgM0lIyRk12pPpXqA82DlJ2KsuBUrvmQbiO/AHAQ5OpCqoQ7GMbI1MZZ/7FHNAPC2cKNs+oeMyNOQCBn1SQbQi0c1aUSQOBNrtofxyisbfjCrLOpKEOFJLTfivR8GTp9uj4mK1eybklcQyL3QqeEjkxhe0=
Received: from BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20)
 by BY5PR04MB6993.namprd04.prod.outlook.com (2603:10b6:a03:226::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Sun, 26 Apr
 2020 23:59:25 +0000
Received: from BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606]) by BY5PR04MB6900.namprd04.prod.outlook.com
 ([fe80::b574:3071:da2f:7606%8]) with mapi id 15.20.2937.020; Sun, 26 Apr 2020
 23:59:25 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
Thread-Topic: [PATCH v1] zonefs: Replace uuid_copy() with import_uuid()
Thread-Index: AQHWGYRhqGOw/VlGRkeMYRfvIOCIA6iMGmMA
Date:   Sun, 26 Apr 2020 23:59:25 +0000
Message-ID: <7135cffafc196874284fa8bb158312ff9865392c.camel@wdc.com>
References: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200423153211.17223-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c3cde5f7-9c99-4940-6c02-08d7ea3dd951
x-ms-traffictypediagnostic: BY5PR04MB6993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6993D1E6D686E10D7FA417E9E7AE0@BY5PR04MB6993.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:469;
x-forefront-prvs: 03853D523D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6900.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(6636002)(6506007)(2906002)(110136005)(4744005)(478600001)(316002)(5660300002)(26005)(6486002)(71200400001)(91956017)(76116006)(86362001)(66946007)(66556008)(64756008)(66446008)(36756003)(2616005)(186003)(8676002)(6512007)(66476007)(8936002)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MIy9jxD1oQEO1Hf6VrG/BD24iAErAv9jlKOY3rIGekQpPjpcyiU029zmJo/pbIxZrVTT8qH4/8zCQwWaiiYW0ckp77kj7fgfK1BDBV40ztz8UrUU7tgNou7PQZVJ0gGnzOfuxFubs1vnTMkaU+OnMYKi1ahxgAuxZubkFA71B703dmC72i2mMghuP4NIlFh1VugfZ+hDoHRgam3vNRSxQENaSJjIaYBi7dxDkdvp53Jiz6JXcBbtpTsZw+/uQ+cY/aNoC4YyFp6dyiRFOGGrl9+tEdHvbABEF16g3N2Kd97juRyQmCAtyUo/Wi6rZB+aXCyuy0Y1W7Vp2gQIwP1d7WTNeuEVgIeZH9Nwo2QB/YJi1UDoAB+1/qF2O/RrUQ+0a9TtmelcRdlyfVPL02TjUYHgM5rNtJ7dANcYaIeWj4buZ6vMluTmd+AvdnBFVhwE
x-ms-exchange-antispam-messagedata: UQE24biuSrmrTcj41HDJOKnpQFOynkLnKOXd8EjfrIOteOEIWx4fraC3VYcLYB4fAc1Mh9ND2Rc4l2TWE66ZriR/KGYWRsD8+zsSvF68D2AOZ31GhRgvodOWWFVGuUCsxstSD1actpjlnxpU05Fz1gUN+3dGl4IVc27DM59mUI0LZ0LCpmq9VAWalxprZGHttVwhQ3m56DQdSJM+F1eWBb1E0u7qG1q0+IpV7r8AEY6sAqM+m5OJn7L74cTdLSGD4loMXWxL33Su8EI8be5IhhCJc6LfmALbdkSyFa9yvCUz4icp9j7COCgMJupy5alviVsWyo7/OJiMvnvaT2tRwZvXwGTI40EEWveSpsKs9gNIs8OqVQccHCaMx405iDEyajfMSuwHOah5l/fZ3Zx6KSJiBHx3T7Q+80CJJCJEZO5pnqegjosbvUu9uqDCV1wwaItFu8/gdwNUSnYmDvHkySDw4J0Fc+bjltAZ0kdtUUZwieyMSB4dGs1bPD4xjV0B727zyqc4gglVMVZVtYJTBAPXC3++ghV18S9eFVrSr8LtJPHr9MKS5JU+GW0IICyI3sMlICc1W8hsCDN+D28ACuXwnqkAi/dZynhob4uTCFJOpHX0duToC4Spck23RJEWVnTCbGV3ViiuXMvDWM75EUuK5alLL3al0xn1bCC5d4VOoIPjbr15IK+Dz7C67eUHM4WjUS9IvwfkVk+uj0bA/kjgMQxP52ICkS2S4+fxwp4UOsj+oErrMfianDIo+zRF9Btkg0Api+e05775M4Uq7RnvezAmt52J8tZskLeaP6Q=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BFE05BAF10FDC46893FDB49D1911F46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3cde5f7-9c99-4940-6c02-08d7ea3dd951
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2020 23:59:25.3940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hq3M1gQAHdQdfKWKAOb8Ro33TYc97EOVY4ywqKaCqt+ukZr3ZAREjuBcH9kVSM1ey6YjQvERB7dkfwLfhyNs5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6993
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTIzIGF0IDE4OjMyICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IFRoZXJlIGlzIGEgc3BlY2lmaWMgQVBJIHRvIHRyZWF0IHJhdyBkYXRhIGFzIFVVSUQsIGku
ZS4gaW1wb3J0X3V1aWQoKS4NCj4gVXNlIGl0IGluc3RlYWQgb2YgdXVpZF9jb3B5KCkgd2l0aCBl
eHBsaWNpdCBjYXN0aW5nLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5keSBTaGV2Y2hlbmtvIDxh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgZnMvem9uZWZzL3N1
cGVyLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy96b25lZnMvc3VwZXIuYyBiL2ZzL3pvbmVmcy9z
dXBlci5jDQo+IGluZGV4IGRiYTg3NGE2MWZjNWMzLi44MmFmMWYyYmQ4Yzg1YiAxMDA2NDQNCj4g
LS0tIGEvZnMvem9uZWZzL3N1cGVyLmMNCj4gKysrIGIvZnMvem9uZWZzL3N1cGVyLmMNCj4gQEAg
LTEyNjYsNyArMTI2Niw3IEBAIHN0YXRpYyBpbnQgem9uZWZzX3JlYWRfc3VwZXIoc3RydWN0IHN1
cGVyX2Jsb2NrICpzYikNCj4gIAkJZ290byB1bm1hcDsNCj4gIAl9DQo+ICANCj4gLQl1dWlkX2Nv
cHkoJnNiaS0+c191dWlkLCAodXVpZF90ICopc3VwZXItPnNfdXVpZCk7DQo+ICsJaW1wb3J0X3V1
aWQoJnNiaS0+c191dWlkLCBzdXBlci0+c191dWlkKTsNCj4gIAlyZXQgPSAwOw0KPiAgDQo+ICB1
bm1hcDoNCg0KUXVldWVkIGluIGZvci01LjguIFRoYW5rcyAhDQoNCi0tIA0KRGFtaWVuIExlIE1v
YWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0K
