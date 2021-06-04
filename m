Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0652E39B142
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 06:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbhFDEPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 00:15:49 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:34472 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229445AbhFDEPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:15:48 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Jun 2021 00:15:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1622780043; x=1654316043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KbleuPwjtSSYjAJ8cqs8XULfIlUT6Dmwb3DzPJUizDw=;
  b=D3n4KtrGzufyklf1VVi5c5+r3rk9LJ+KEUKunYZ5yRzGN2af1pvMQSj/
   lT0f+qlBdj0AvAUx6cgr43FBGDUOhGdT+2ubhrJY/VikTCSZaZvF46JeI
   sGgaUgkqiQixAqSSCo/XPMFIajRokDJvpVc5lwExaHieTKCdi9pznh//b
   2815bBl3ag+p+zWJdESfQq624MwvVQCVheEj2iSpu//PkmRtbvlGMMh8W
   Hew5NoH/oFilaEtYOixecqrATPAI09sjPQQ2P1cnVEsKPgRYaMkX7ZCj7
   palIyKDMEsNkQ4HXi9ZMqAXjiTMeYWgBShr6T6T/ibYo+9dZEkdxPwzl7
   w==;
IronPort-SDR: UfEKCHZ++o05OH8fRmAMDQgYjC6psOszygnCugtALMzxhjzwouhaX+9p1ARcGDTNIPNthGF19D
 2YfjU1DkTp/e9helS8SgOh2NhRPTfnW59zB6xeaUvTPiqpl6b+lL5M91sMZ5CJDbAhxVKuireS
 3gCQdsOqey68NfqqNJjjjevslV88qN96sX6f1KgjefgAntKBMMMvpy0UsAlTTgC8w4wvKXY+Hp
 cbFKMPn2AinVjLHnFWpNp0T3CCAmAl1yQOMNzbpvvrTGMeOnfX2QnGGkXgUnSEhdG6Ou5BO8aM
 lVs=
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="32402982"
X-IronPort-AV: E=Sophos;i="5.83,247,1616425200"; 
   d="scan'208";a="32402982"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 13:06:48 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5RGwphXjI7gk4MQriLQORZT43mV2xcvBVeIYxlNrDjkfCWeAkChVih3AgvkAALwQMINWq/QWARmS/zzJzJoWRp1cSNlTNKDSAA3KaOv2F4oUtWRt3guGdmYniPanbY+PqMra3D0eOEhAycGR8e8Bb++9qTNVEl1p7nCUSN2X3e53XbCfNdiE0Cz1nj+TjRyt4NvrmC5q4SkNRRjmskQtXY/rVSfZ+rvHKC+WjEblgN9szEa3d6Q1RUKbNMbzQO4RlvPu03K1NQgNgGAUWfX2Gu0i4ZbMOoWnQKDKcpr5LXh+zDJJLwCYbvdTZo+TOfeyJZ22SBi4GPudENp8hKpIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbleuPwjtSSYjAJ8cqs8XULfIlUT6Dmwb3DzPJUizDw=;
 b=O/5xwCYkZrrsreiPygMUREyvtVxEh4oSFkhbOEdn5KmVdXgGH0TNmkjuV0km+sNks9BNTlATP6dOmCH3CE7s/0RdDcohCnemNZJomCjhqAD4dmwy7v4bwnoNWnWrO4RLu0hZlDaMch1snYnVX0+Sx2npcFn2l7PCQr8A5wSiRswx8O7gLHuu0Xpj1UpBEAJ9uOUF0OfUiiJhOctasvt9h3l3HMvq0YYBWx9FNjSMLsXdB+d9jARMQNEMtEZ2syXdhUZnKhtxVVjTP1u33vXWh9I3RyljpP6/Jpcwt3aFSdR1dGlIXFAJrr+z9C21op5g2yRaEFr7MmYsoM2PfBR+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbleuPwjtSSYjAJ8cqs8XULfIlUT6Dmwb3DzPJUizDw=;
 b=juvQzzN0TV44yLaayUm6EJUdpeV5WE3OguTsm3BSWjtz57yh7hWEZ779ptavm6+1EXBYpST0sCKI1mcUbbs5Xn9/LXojssQjQFOA1Q8GGCM2pUIz8CFuZKuDrOo0a/Ow0bMOvOo8o5Zn+7z0daCyrOGW947evQxBUtUZByXB23o=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6870.jpnprd01.prod.outlook.com (2603:1096:604:123::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 04:06:45 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4195.022; Fri, 4 Jun 2021
 04:06:45 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Thread-Topic: [PATCH v3 0/3] fsdax: Factor helper functions to simplify the
 code
Thread-Index: AQHXN325ZvNg0AwKgEyTZt/tgpBu/qrZJMtAgAnCTLCAIDwDgIAAW48Q
Date:   Fri, 4 Jun 2021 04:06:44 +0000
Message-ID: <OSBPR01MB2920F2BDC15B22E655192C1CF43B9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210422134501.1596266-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB29205D645B33F4721E890660F4569@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <OSBPR01MB29201A0E8100416023E77F80F4509@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <20210603223733.GF26380@locust>
In-Reply-To: <20210603223733.GF26380@locust>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9b8b5d6-5efb-4f9d-d61e-08d9270e2ace
x-ms-traffictypediagnostic: OS3PR01MB6870:
x-microsoft-antispam-prvs: <OS3PR01MB687035CA68C194E81512B259F43B9@OS3PR01MB6870.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWvP2YmyoeL8rk7eE1n2EqzfX8yrme7nJHBGKWBKHS1AENg7qpRmGtDf6vwDlYJ8c/Pc8NQfiYaH3Nr5pOTnBe5FBEZDxhKaX/H13D1rpcMD9bor1JTV2+IqCR8uf80W18g+BMHKKxDPPfkgkD9RMorYM/1pQmW82qDYf8Ti5YKIpS29y/Rz2r9aErHWBj23VOMIj08oLRIp1vuZAzJvDsw05jkFdMMIAIEDxr/CSJqydx38OlCfqQmM27zVQNs4b6zfE4BBcGZ5JNLIfpgyNlQ0oq7Z4Us2828XUDDm1l0qxVSYPk8ROuViTnec5OCOhaPaOjVLhJ4PUBoXsBb0+QpuybAzzTZPR5IppUMg7dmwK5gKkgzrvu5+Be0zIDpmxABBU579WXmqTNlnZ/oON3KYc6IxN+lBAfLxFO+jQBZfIPqlc/G2pAmAr3M1ksYGBBv+2cdpfXX7YNpq4Vrg5cAObw1ieemSvLjkA9w3kmHDtn+Lh2Y0Bs4RpBTXJ9h/iduQ37GiK+m2cyX0IvCyAqwPxRBpZmIR1cF+nZAf4x0gxBi/nBtif7EzdaLKx/M+By5ILLiuJ5e7IJg4TaC5cztQvmM1svG9LKIiizAqNwgi2A3WVm14s80t/xOA4YGnxPw+3IxM2vnP3B6nEqKYCJVaTHFlHVv2x05lUjU9uBV95dFOysQg++2JOSP0A4tLaOBY/GM0hN0i9/VhEHaSfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(66946007)(66476007)(64756008)(66446008)(66556008)(7416002)(86362001)(316002)(83380400001)(6916009)(76116006)(54906003)(966005)(26005)(7696005)(55016002)(8676002)(186003)(8936002)(53546011)(71200400001)(6506007)(9686003)(4326008)(5660300002)(2906002)(85182001)(33656002)(38100700002)(52536014)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?R0FvaUFzMmN0anpHSXZYdHVqMVdUR2J1dnJXMnQybnBXbDdCRkNKSGYxTHJ0?=
 =?gb2312?B?L1F2YXdQOCtEcDBHQjJobFR1L2FUK0pCVkI1RDdkaXFkNFdOVlpFYVAzdUsw?=
 =?gb2312?B?a3dYZHNZWnp4RTZOWDJOYVpjS0wxZis3WDNCRG9YaGx6aWN4c1Qzby9CWElW?=
 =?gb2312?B?YU5NR2U4SldGTGMzOHpTVVl1Y1lleE85dlc3blhiNnE2cTBYRTR1WTZmTEhJ?=
 =?gb2312?B?L3R6dTlIbVplT0RLbGpWRWx3SThLYndKNnVudW1OWUIxOWZXMTFhWWhDMEw0?=
 =?gb2312?B?Mm9vb2Jjdk5YQXZJM3hMK2ZEQnFCRk15bFQ2K2FtL2lWSjVQbmRBQ3BsK0pU?=
 =?gb2312?B?T1FKNUJKV0RJVCsxbmJIVm40VmMvNUFqV3pQSkJmYnZlUUlSK05EaTFsUzFN?=
 =?gb2312?B?bTBCbDJ1Ung1KzRaNERzc0xXWVhVVFdSV2pwMDFKMWxrSDBIQm95SmxqNm10?=
 =?gb2312?B?aXEvZzlQV2dqTUE0UDJyNTRsSHBOb0JPeEtvU1M5cFR4ak16Z3NlZzVZY1pm?=
 =?gb2312?B?SWczY0h4d01NWERSSXloM0RiNUtZM3pyUjIwQlFaa0JJbkFiNUlmaG92N094?=
 =?gb2312?B?S1hDVE5rUUFUdFlZeUhHM0psaGozVXpZdXZVR2I5YzliQ2M1N1B4b20wYWI3?=
 =?gb2312?B?ayttaVRPc3hONVVSaEZRVlBDY09mUHhKZWtQenJQdUhDZFhUSi81UzVQdWYr?=
 =?gb2312?B?cWU4Rm8vMkJPSUpkNlRYL2sxYTI3THVNb0VYOWM1RHB1L0NQVkVmUVZyazNu?=
 =?gb2312?B?Smc5dGFhQ0NmSk1IV051bGRacDBJSmdIRlBBWlc3MFc0UFMvcDFoNVR3WTJ4?=
 =?gb2312?B?T0V0OUJyYnphdmM5dGpRaG14RXRBc2JKN2VZWFR3c2gwdTdvRW4yWm1tMm9i?=
 =?gb2312?B?YVpqN1J1VndJTDByVWdCTWVEc3U5cTFhQm5IMGRMbEl3MWlVNEp6R0VCblN3?=
 =?gb2312?B?YXl5VTVmSnBFWVppelNweno1c3h6Z3hYNmRWVy9Bb0QvY1FXU0lnQ29ZbXk0?=
 =?gb2312?B?L3R5dE83SmFvNU1ocGtJM3ZrU0U2R1NLUmhvazd5RlZ5d2p0VW9zUDJTOXRW?=
 =?gb2312?B?V2ovZHQxZjRNRVlYWlBwT0NWb2RDVGk1ZDlzTVAvN0V1SmN6eDdzeENRcjBV?=
 =?gb2312?B?SVJmMmppRUR5R0N1VVRwM3ZUR3oxaFg0Nk82cElWVm9rMFVmU0hPNkNSMlpC?=
 =?gb2312?B?bXJnUU1aSXJIUnA0M1hxbTBtcm1QMEZzTkZ1cWxEU1pzSDVKRWRJWWczamhl?=
 =?gb2312?B?TnF1dHVnRlkvK1J5QThlMWkzRTJHTDVkUk0yN3Y0M3JkNEJRZVhSd200RTJJ?=
 =?gb2312?B?ODUwU3RXRFZkTWdYYlRjbkVTaDVlM05XaStBOC9ldkhkZzA1VDlsZjZ2bDJv?=
 =?gb2312?B?b3l2a2MxS294TFZYNU5GOVpjYTVVVjVrdDRIVDZvcFFqbmpCbTlWSTVhMjRB?=
 =?gb2312?B?OHdHaHozUll3RXFHbksrWHI1cTR2RU9TRlFaV2Z2SUw0UjFnZEhNeW9EZkVE?=
 =?gb2312?B?dlptcHp2SHdmVW9Wc0RRUmV4bFlaZW1tbSt3a3dmNUU1NzAvUEtkcXZ3d05B?=
 =?gb2312?B?RU5YNkQ4U09BY09OK1VQdGRIWS85Y3N3Rko2Nm1pbk9BVnRHdU05RGZPaStw?=
 =?gb2312?B?YzhGUHcybHZUWjZZN2RHbTR3Mm9uUmZiL0VGMlllMjBZSnhqcHpFRTl6OU1q?=
 =?gb2312?B?NWhzZ2xjalBuOTFIV2F5OUl3amtVYnVweTh0ZHVGTUdFZEtJK1YwU1k2VXE5?=
 =?gb2312?Q?dQznKgxWvarYexa/SU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b8b5d6-5efb-4f9d-d61e-08d9270e2ace
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 04:06:44.9980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvYV/s0ftvgLp0jYQ+95EnqpluNAngBoF3oGKlK96pVDdeXWl2AvFz5uvLjEjGgaYXTz3MWU7E3yYqky0lnvuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6870
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXJyaWNrIEouIFdvbmcgPGRq
d29uZ0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvM10gZnNkYXg6IEZh
Y3RvciBoZWxwZXIgZnVuY3Rpb25zIHRvIHNpbXBsaWZ5IHRoZSBjb2RlDQo+IA0KPiBPbiBGcmks
IE1heSAxNCwgMjAyMSBhdCAxMDoyMzoyNUFNICswMDAwLCBydWFuc3kuZm5zdEBmdWppdHN1LmNv
bSB3cm90ZToNCj4gPiA+DQo+ID4gPiBIaSwgRGFuDQo+ID4gPg0KPiA+ID4gRG8geW91IGhhdmUg
YW55IGNvbW1lbnRzIG9uIHRoaXM/DQo+ID4NCj4gPiBQaW5nDQo+IA0KPiBUaGlzIHBhdGNoc2V0
IGhhcyBhY3F1aXJlZCBtdWx0aXBsZSBSVkIgdGFncyBidXQgKEFGQUlLKSBEYW4gc3RpbGwgaGFz
bid0DQo+IHJlc3BvbmRlZC4gIFRvIGdldCB0aGlzIG1vdmluZyBhZ2FpbiwgaXQgbWlnaHQgYmUg
dGltZSB0byBzZW5kIHRoaXMgZGlyZWN0IHRvIEFsDQo+IHdpdGggYSBub3RlIHRoYXQgdGhlIG1h
aW50YWluZXIgaGFzbid0IGJlZW4gcmVzcG9uc2l2ZS4NCg0KVGhhbmtzIGEgbG90LCBJJ2xsIHNl
bmQgdG8gaGltLg0KDQoNCi0tDQpSdWFuLg0KDQo+IA0KPiAtLUQNCj4gDQo+ID4gPg0KPiA+ID4N
Cj4gPiA+IC0tDQo+ID4gPiBUaGFua3MsDQo+ID4gPiBSdWFuIFNoaXlhbmcuDQo+ID4gPg0KPiA+
ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiBGcm9tOiBTaGl5YW5nIFJ1
YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KPiA+ID4gPiBTZW50OiBUaHVyc2RheSwgQXBy
aWwgMjIsIDIwMjEgOTo0NSBQTQ0KPiA+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjMgMC8zXSBmc2Rh
eDogRmFjdG9yIGhlbHBlciBmdW5jdGlvbnMgdG8gc2ltcGxpZnkNCj4gPiA+ID4gdGhlIGNvZGUN
Cj4gPiA+ID4NCj4gPiA+ID4gRnJvbTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBjbi5mdWpp
dHN1LmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlIHBhZ2UgZmF1bHQgcGFydCBvZiBmc2RheCBj
b2RlIGlzIGxpdHRsZSBjb21wbGV4LiBJbiBvcmRlciB0bw0KPiA+ID4gPiBhZGQgQ29XIGZlYXR1
cmUgYW5kIG1ha2UgaXQgZWFzeSB0byB1bmRlcnN0YW5kLCBJIHdhcyBzdWdnZXN0ZWQgdG8NCj4g
PiA+ID4gZmFjdG9yIHNvbWUgaGVscGVyIGZ1bmN0aW9ucyB0byBzaW1wbGlmeSB0aGUgY3VycmVu
dCBkYXggY29kZS4NCj4gPiA+ID4NCj4gPiA+ID4gVGhpcyBpcyBzZXBhcmF0ZWQgZnJvbSB0aGUg
cHJldmlvdXMgcGF0Y2hzZXQgY2FsbGVkICJWMyBmc2RheCx4ZnM6DQo+ID4gPiA+IEFkZCByZWZs
aW5rJmRlZHVwZSBzdXBwb3J0IGZvciBmc2RheCIsIGFuZCB0aGUgcHJldmlvdXMgY29tbWVudHMg
YXJlDQo+IGhlcmVbMV0uDQo+ID4gPiA+DQo+ID4gPiA+IFsxXToNCj4gPiA+ID4gaHR0cHM6Ly9w
YXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW52ZGltbS9wYXRjaC8yMDIxMDMxOTAx
DQo+ID4gPiA+IDUyMzcNCj4gPiA+ID4gLjk5DQo+ID4gPiA+IDM4ODAtMy1ydWFuc3kuZm5zdEBm
dWppdHN1LmNvbS8NCj4gPiA+ID4NCj4gPiA+ID4gQ2hhbmdlcyBmcm9tIFYyOg0KPiA+ID4gPiAg
LSBmaXggdGhlIHR5cGUgb2YgJ21ham9yJyBpbiBwYXRjaCAyDQo+ID4gPiA+ICAtIFJlYmFzZWQg
b24gdjUuMTItcmM4DQo+ID4gPiA+DQo+ID4gPiA+IENoYW5nZXMgZnJvbSBWMToNCj4gPiA+ID4g
IC0gZml4IFJpdGVzaCdzIGVtYWlsIGFkZHJlc3MNCj4gPiA+ID4gIC0gc2ltcGxpZnkgcmV0dXJu
IGxvZ2ljIGluIGRheF9mYXVsdF9jb3dfcGFnZSgpDQo+ID4gPiA+DQo+ID4gPiA+IChSZWJhc2Vk
IG9uIHY1LjEyLXJjOCkNCj4gPiA+ID4gPT0NCj4gPiA+ID4NCj4gPiA+ID4gU2hpeWFuZyBSdWFu
ICgzKToNCj4gPiA+ID4gICBmc2RheDogRmFjdG9yIGhlbHBlcnMgdG8gc2ltcGxpZnkgZGF4IGZh
dWx0IGNvZGUNCj4gPiA+ID4gICBmc2RheDogRmFjdG9yIGhlbHBlcjogZGF4X2ZhdWx0X2FjdG9y
KCkNCj4gPiA+ID4gICBmc2RheDogT3V0cHV0IGFkZHJlc3MgaW4gZGF4X2lvbWFwX3BmbigpIGFu
ZCByZW5hbWUgaXQNCj4gPiA+ID4NCj4gPiA+ID4gIGZzL2RheC5jIHwgNDQzDQo+ID4gPiA+ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyMzQgaW5zZXJ0aW9ucygrKSwgMjA5IGRlbGV0aW9ucygt
KQ0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjMxLjENCj4gPiA+DQo+ID4gPg0KPiA+
DQo=
