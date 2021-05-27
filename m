Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEA43926FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 07:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhE0FrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 May 2021 01:47:08 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:39580 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233288AbhE0FrH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 May 2021 01:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622094335; x=1653630335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EHff6jTV1wc5FNk28NeY/11tx8YuJbDtOKoozkA2JDI=;
  b=aoh9c6ZFHv7Xe0h6+S7trKG2dy9cZSr0ew4HKhWbTKXdjMqsKjEdGSoz
   RcgPV/E5Gjt2eIPbLRYU22ouM5wdNTMjyTFK+3w45FotTEVZCpzotdhRg
   gPEcxx6gOvN8l05IsYctpVFE/FBt/DzIRX0nE+UVhPXRqgeVhQaIl3A6p
   rlEnNZ3cqqJH0NlmJkWqIshC2ox7dsHUPeZwxwH99J6rijp/x7eDTec1y
   dD33vlZC1fMqJ+z3dmwipsKD0jj5Wimy5DBX8s4eLMtrZX0sbODUfEZDq
   9oNJZHnQTRU93VADCbtoOkpxg9buUS4KOSNX2dRcT/lcnozX/fRF3PPNq
   Q==;
IronPort-SDR: 50yi/NWJKaeBoiyO6ZQeZmlVNIu9zL2RBwsi+WvhUGc2uFrUa8odte3z6gJ7e/ggrvHQEuvzRp
 5bhLowYJd2r7LALTP20Skj7SxHLVOkF2mQzIy2qpiEqYQnF6lgp2IK41SSyUHMZn/0jIom9BR/
 egsUnRmWh/iLIuRsZwxR8CUQJchDr8L0ASm0Nnz5Q0mOkB7DzyHX8BKRYCGD8N5gEoxfuyOMAJ
 t9ZkX3pcwsZsi6FUT1gq+AT15fM31wMojtOPA1zoS3OrpXqn5+R5rGrA6Sl3JaoQEHpo32SIAO
 eHs=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="280920836"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 13:45:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy24HBPCQUiVErVZzpVKDGRhXRXepcs2Z8gUTjPDxRDOnSVYDnWIBjUO2OhobVQBOqkrgpDA828pEp8uED8ABo93KKl1WPhdIwm+gM0SenZrEDDH2D1Yu/Xg7do7dpIFhkhriTk/IexLrZg0ta/IaUDT6zp2Uj7BnBr/4uRxGq8FHLfl5t+QDwsUuwtOSmQssLXB5Y5MVY0mw7yS0hmEgkejtBkD/pAA58nnefqaQQ9F2kln7zZL8eNjcL/A7BqzNP23ReZ5qBYfkL0d472VFHBmK8RK4FAYdU3GEbqDJ+DYiD4Ls8USlba081vISyzlcn0x/5pbCOWFSRlgw3HjsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHff6jTV1wc5FNk28NeY/11tx8YuJbDtOKoozkA2JDI=;
 b=frYU9TXeWPHSIbBfjfekvCymIlvBPwr0HspUBxlYlEo8qJbOxB4i0nv1AIxlcbRCvHOmT27k2D2LhZ/CJMBAMzmYy1LseBrwfkpbVd4qoXzbshYBeWbLPK5C4EgYnvprUjDJpsmVvLZoYgI82YiHYjgRKVK8bVusG8MABzE2fLvRM54YjJHC7Su2eqaUSUbjSvAK60t0gCJStmfpLl/x2LDFfytrYzJ9QPe9oH6AHQzryLF7eP3EzICSP791TMGEVjLdNnKD2E8tFFzJoabmz9SDVfILbMMGHfPTWnbaECnoQ3QICpqyLtrplm4vfgFyE3o15LpgF7kSXf4Gtgaw5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHff6jTV1wc5FNk28NeY/11tx8YuJbDtOKoozkA2JDI=;
 b=j51hj8H/oJBCnpVYvbl7gEwI87DXtrXi3eqV8V+jLWIPocGJ5ytDzyQQCzlwFleeOV+J8ceX8HpJAk3viaWKPeof/wQAErE/PE5QZS8oeB+OiPXh+oz9hgzyKkaTWthADUQEFmSS6tz8HNpYTk/yRx2O2VEED181mTxuRShb9tg=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4921.namprd04.prod.outlook.com (2603:10b6:5:19::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Thu, 27 May
 2021 05:45:34 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 05:45:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "wjc@cdjrlc.com" <wjc@cdjrlc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] zonefs: delete useless complex macro definitions
Thread-Topic: [PATCH v2] zonefs: delete useless complex macro definitions
Thread-Index: AQHXR6sfEyId78W8I0q4b0dHqy09Gar2560A
Date:   Thu, 27 May 2021 05:45:33 +0000
Message-ID: <900d6fa2f2a55f77e20ebe7714b0494604691277.camel@wdc.com>
References: <20210513035017.54029-1-wjc@cdjrlc.com>
In-Reply-To: <20210513035017.54029-1-wjc@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 (3.40.1-1.fc34) 
authentication-results: cdjrlc.com; dkim=none (message not signed)
 header.d=none;cdjrlc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.61]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dfc541c2-9807-4629-bfde-08d920d2a56e
x-ms-traffictypediagnostic: DM6PR04MB4921:
x-microsoft-antispam-prvs: <DM6PR04MB492129CB3D79247E4FD755D7E7239@DM6PR04MB4921.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TH9bbiFfkNC4KuAGch8LR+PhtfePETTM+cGajwDj3mezM5Yz6Ijm8gb8g3ke21KqQgQ2mXMh2jeb2t5d6Y7B0hyiVPaS4kANRlr4a5DX8KEiV2A/MZmLyvO1Vnr+sTgvx5zFB2EnzNDMyk3w/VBUKWuLNzv5JS4pKBfKVr2A217IiXrG1NLzyTWDAOw8N2iGprqVOqdV83zpVkWcg9fqwTc/IncrI1ht8F0T03sWRL7rUhsbTqoj7bJ00wlma5ho6M472nLvw+UFHrjmnFIbz19WO0rbQSERY25FuhSzTIXNe8hlKclHWqU98Vgzc1YpKPtIoqW6xdxbu7i1jCyBYOQLFyWn+Ip1sQGdodGbh3IDQze0ocyL0dj+hwDDbCkUVQzgrqudjSx7KNW8LcZEi/izIetaKMOt/N1EETRShko8VmPlWXFj0Ov/F/4fZUCTMsB3GMghpyu2crhN5SfC/XsmaHMEh2A4TXomLqxkBPS9wbGAl0+Rgxg3gqbI9t8qi2Ibm6ckNZSHi5QLqCXxX5IzpLH8IHo0/r+Kdly8eri6YmyFgCBbLP2E5MmyPgAdOwW0vZHf1ytmakJu1l+ctNA/jP5ZnkqGAKyAgRyBmUc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(91956017)(36756003)(64756008)(2616005)(8676002)(76116006)(83380400001)(8936002)(122000001)(2906002)(71200400001)(316002)(4326008)(66556008)(66476007)(66446008)(66946007)(5660300002)(478600001)(6916009)(6506007)(6512007)(186003)(26005)(6486002)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?MEpUTUh4NDNUTTBwa2xqOXRUZ25wZ1VId2poQTF1QUdRemZmWU02OVg4ZlNj?=
 =?utf-8?B?c1hyY1FnemdUK2p4eFBwc0hIRXBLUm1VNm4xUUpkRHZBeHp3T2VESDE5VkpV?=
 =?utf-8?B?b3orclcrYW1qa3FnYjZqWmR2YXdZUXFxcmZQRGdSYlpJbkJTZlNNeFUwdTBn?=
 =?utf-8?B?bjk0RmIxSVhibmZvTFpsNjBpZDRmYzBUeFo2citBY2VUL1Bka09USUV6WG1R?=
 =?utf-8?B?VCtPWmVwa3dZWWgyQkdwbGZyVzJJakNTOG9YMExaRzJqRXg3cnB4algvUEhn?=
 =?utf-8?B?a3dwUDVKcTJZeW43Ykp1U3lpUW5sVmdqTzFJRGNBSHdGYllMeTcyUTZrUEJs?=
 =?utf-8?B?OGJrTTJLS2dNS2dtR3NBUHFtYy9HU2o4ZDV0RWhLaEpkQVh3L3hiMjh4aFdv?=
 =?utf-8?B?YnBhUytkaXV4VW41TG04bVV0Q29RUzgzU0tYSzBNS3VYQjR0MW4yNXJRaU1R?=
 =?utf-8?B?WGNPVW0rSndud0ZLNWw5cDN2ZlpqN2pCazV1RFJpdmdkWGlmbW1uZkNUOHhL?=
 =?utf-8?B?Rk1taEtoTWhrcVhjMTZFYXQvaE10azg1QXN4UTBueUZYSWQ4bVZuOVVsdzgz?=
 =?utf-8?B?c3RodFJ2emQzMjJXNC9SR1lIRnhqQkJvdmpTcDRFK3pmeHlmNXY5MXNUSkFn?=
 =?utf-8?B?RllWR21rVTFsc05WVWFzVSs5aThlak95dW1jaHFGR3FNVjF2M0xRWTk3RGV2?=
 =?utf-8?B?TlNIZ3pZS0dlTTQ3dm9WakRoZ1hiWGVWSUt5TldoSVlTclVDNjV4SUt0dWpw?=
 =?utf-8?B?eTJzSjloSmM1Ylk5cll5Y05qN2VVMnJaSFllNm9JdEJ4YUt3V2xQQm1CUnpt?=
 =?utf-8?B?M2ZYNm5rTFdMZjJIMU1rTVNLUC93V2g4L0NxNkFSSEE4V2s4T20rMmZPODRN?=
 =?utf-8?B?aXMrekIwWW1pRmIwTmljUml0RG16Rk4yNUdJUm9tMS9RM291YkdDNW9EQThF?=
 =?utf-8?B?SmVZRldDMUFaRTI5QWZBWDZUNkJMK2p6ZGVEd0tpL0VBelJETVNQZkVsYjRK?=
 =?utf-8?B?NnFpVzBCc0JIcTIvYzlxVUVlYlJqaTAxcDhvTFFMUVJXN0dIc1U3Q2UxYnRx?=
 =?utf-8?B?L1hTSDhac1JmUjBIc1VaS2QwUWpFaHZMOERNaklQY2Q3SCtrUFFhTnY4N09h?=
 =?utf-8?B?Z2ZlSzJ3SWxkV0RTQVBPTm9SRVhwZTRpanRoZ3lsNkNmRG1WUVBKdCtBOEZP?=
 =?utf-8?B?VmJKV3FiQnc1R3RNT084S0Z6VlVPallCTEpiQ0E0M3hYWUNEcnNNMUE4UVJC?=
 =?utf-8?B?U3VMcHFhMTBjQVFkd0tHeVpQTG1UamxUUEJlRzBSbCtIbTlYbTlGMXkzeWgz?=
 =?utf-8?B?cnpiNjNISGFuTHdNSlZmV2tld1ZGd3Y3ZHlrL09ScU1TemxWRHYvbytrNjlt?=
 =?utf-8?B?NkdjTTBDZUtPWTJCam82R2QzMXBDajZ4aURTeU1VbkZtc2c1R0dQQ0JDU09k?=
 =?utf-8?B?VW51VElpVXVQeEZBN0czSlc0T25FazNRYk5XSzNWd3dQQjc1dTVhaXd2SXBS?=
 =?utf-8?B?My9ESEk2S0xNMWFvWnFTYTNoQ2pvNUhzanhmMmI2bVFzTjRmWkFEMjEvL0Ry?=
 =?utf-8?B?bjJSZThUUDIrTUFNUTZOYlFEVW9LNmtSQmtBbWFvUmZjNnFhandkank2UTg0?=
 =?utf-8?B?d2s5RWpUWjc1eUJQYzIzanlMWVRWSmY1THR5bnFacHFhN2d6bG5HUm90V2Q1?=
 =?utf-8?B?S2k1SWdRcGQ2WWp6TWVkb3dHbXhkSGM2Ym1LOWJZak85ODQ3UWhiL0F6TDRx?=
 =?utf-8?B?MFR6NGFJYUlVMk9ScnFBaFg4RG5CcmlRU1pDM3FTOXJQeXM4cFpCdWYveDIz?=
 =?utf-8?B?YmhGcXhWdFdPdE5kcU1qdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <52C35D9F61543140BDBB1160F9C79B37@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc541c2-9807-4629-bfde-08d920d2a56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 05:45:33.9857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EOYnk3YYExDP0FQpXAcI5n1JWR65yTwMcQ6UOdZu9N0EzKQU13KLTJ63RD67fq4E2EdzqFMlOqdvGtTkFJZ8gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4921
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVGh1LCAyMDIxLTA1LTEzIGF0IDExOjUwICswODAwLCBKaW5jaGFvIFdhbmcgd3JvdGU6DQo+
IEZpeGVzIGNoZWNrcGF0Y2gucGwgZXJyb3I6IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFsdWVzIHNo
b3VsZCBiZSBlbmNsb3NlZA0KPiBpbiBwYXJlbnRoZXNlcy4gQnkgZGVsZXRpbmcgdGhlIG1hY3Jv
IGRlZmluaXRpb24NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEppbmNoYW8gV2FuZyA8d2pjQGNkanJs
Yy5jb20+DQo+IC0tLQ0KPiAgZnMvem9uZWZzL3RyYWNlLmggfCAxMCArKysrKystLS0tDQo+ICAx
IGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2ZzL3pvbmVmcy90cmFjZS5oIGIvZnMvem9uZWZzL3RyYWNlLmgNCj4gaW5kZXgg
NWIwYzg3ZDMzMWExLi4wM2YxMmJjMGM2NDEgMTAwNjQ0DQo+IC0tLSBhL2ZzL3pvbmVmcy90cmFj
ZS5oDQo+ICsrKyBiL2ZzL3pvbmVmcy90cmFjZS5oDQo+IEBAIC0xNyw3ICsxNyw2IEBADQo+ICAN
Cj4gICNpbmNsdWRlICJ6b25lZnMuaCINCj4gIA0KPiAtI2RlZmluZSBzaG93X2RldihkZXYpIChN
QUpPUihkZXYpLCBNSU5PUihkZXYpKQ0KDQpUaGUgY3VycmVudCBjb2RlIGRvZXMgbm90IGhhdmUg
dGhlIHBhcmVudGhlc2l6ZXMsIHNvIHRoaXMgcGF0Y2ggZG9lcyBub3QgYXBwbHkuDQpQbGVhc2Ug
c2VuZCBhIGNvcnJlY3QgcGF0Y2guDQoNCj4gIA0KPiAgVFJBQ0VfRVZFTlQoem9uZWZzX3pvbmVf
bWdtdCwNCj4gIAkgICAgVFBfUFJPVE8oc3RydWN0IGlub2RlICppbm9kZSwgZW51bSByZXFfb3Bm
IG9wKSwNCj4gQEAgLTM4LDcgKzM3LDggQEAgVFJBQ0VfRVZFTlQoem9uZWZzX3pvbmVfbWdtdCwN
Cj4gIAkJCQkgICBaT05FRlNfSShpbm9kZSktPmlfem9uZV9zaXplID4+IFNFQ1RPUl9TSElGVDsN
Cj4gIAkgICAgKSwNCj4gIAkgICAgVFBfcHJpbnRrKCJiZGV2PSglZCwlZCksIGlubz0lbHUgb3A9
JXMsIHNlY3Rvcj0lbGx1LCBucl9zZWN0b3JzPSVsbHUiLA0KPiAtCQkgICAgICBzaG93X2Rldihf
X2VudHJ5LT5kZXYpLCAodW5zaWduZWQgbG9uZylfX2VudHJ5LT5pbm8sDQo+ICsJCSAgICAgIE1B
Sk9SKF9fZW50cnktPmRldiksIE1JTk9SKF9fZW50cnktPmRldiksDQo+ICsJCSAgICAgICh1bnNp
Z25lZCBsb25nKV9fZW50cnktPmlubywNCj4gIAkJICAgICAgYmxrX29wX3N0cihfX2VudHJ5LT5v
cCksIF9fZW50cnktPnNlY3RvciwNCj4gIAkJICAgICAgX19lbnRyeS0+bnJfc2VjdG9ycw0KPiAg
CSAgICApDQo+IEBAIC02NCw3ICs2NCw4IEBAIFRSQUNFX0VWRU5UKHpvbmVmc19maWxlX2Rpb19h
cHBlbmQsDQo+ICAJCQkgICBfX2VudHJ5LT5yZXQgPSByZXQ7DQo+ICAJICAgICksDQo+ICAJICAg
IFRQX3ByaW50aygiYmRldj0oJWQsICVkKSwgaW5vPSVsdSwgc2VjdG9yPSVsbHUsIHNpemU9JXp1
LCB3cG9mZnNldD0lbGx1LCByZXQ9JXp1IiwNCj4gLQkJICAgICAgc2hvd19kZXYoX19lbnRyeS0+
ZGV2KSwgKHVuc2lnbmVkIGxvbmcpX19lbnRyeS0+aW5vLA0KPiArCQkgICAgICBNQUpPUihfX2Vu
dHJ5LT5kZXYpLCBNSU5PUihfX2VudHJ5LT5kZXYpLA0KPiArCQkgICAgICAodW5zaWduZWQgbG9u
ZylfX2VudHJ5LT5pbm8sDQo+ICAJCSAgICAgIF9fZW50cnktPnNlY3RvciwgX19lbnRyeS0+c2l6
ZSwgX19lbnRyeS0+d3BvZmZzZXQsDQo+ICAJCSAgICAgIF9fZW50cnktPnJldA0KPiAgCSAgICAp
DQo+IEBAIC04OCw3ICs4OSw4IEBAIFRSQUNFX0VWRU5UKHpvbmVmc19pb21hcF9iZWdpbiwNCj4g
IAkJCSAgIF9fZW50cnktPmxlbmd0aCA9IGlvbWFwLT5sZW5ndGg7DQo+ICAJICAgICksDQo+ICAJ
ICAgIFRQX3ByaW50aygiYmRldj0oJWQsJWQpLCBpbm89JWx1LCBhZGRyPSVsbHUsIG9mZnNldD0l
bGx1LCBsZW5ndGg9JWxsdSIsDQo+IC0JCSAgICAgIHNob3dfZGV2KF9fZW50cnktPmRldiksICh1
bnNpZ25lZCBsb25nKV9fZW50cnktPmlubywNCj4gKwkJICAgICAgTUFKT1IoX19lbnRyeS0+ZGV2
KSwgTUlOT1IoX19lbnRyeS0+ZGV2KSwNCj4gKwkJICAgICAgKHVuc2lnbmVkIGxvbmcpX19lbnRy
eS0+aW5vLA0KPiAgCQkgICAgICBfX2VudHJ5LT5hZGRyLCBfX2VudHJ5LT5vZmZzZXQsIF9fZW50
cnktPmxlbmd0aA0KPiAgCSAgICApDQo+ICApOw0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpXZXN0
ZXJuIERpZ2l0YWwgUmVzZWFyY2gNCg0K
