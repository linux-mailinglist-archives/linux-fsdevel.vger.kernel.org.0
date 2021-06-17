Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D8D3AACBA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jun 2021 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhFQGxy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 02:53:54 -0400
Received: from esa2.fujitsucc.c3s2.iphmx.com ([68.232.152.246]:22287 "EHLO
        esa2.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229616AbhFQGxx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 02:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1623912707; x=1655448707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=q3SWwtj4qzmFnyMwMbjBILrRVzaGsuXQfK38ahs8v5c=;
  b=cMDE69pKtzSar0km4H9ZfASbxbOfIfU3WZcf7+mZuoWpIzzUtvhM8uP/
   n5hhIohfotRzkkHz6G6p8qD4gefNe5GxApbQup9WvO1R552O9homv20Ig
   keO9qTaq6P+fI7taJc3+xmjwOseveayLvW8vLMDbQhMWWaRDbpoZIDabA
   QV3+3pDBARjZZdxBLk+1rQ+w2IOh0sD1lub+5stnPWFQUvN2hjf9Gxo1N
   T88UMee0Qx61LwJC51rI30GW8U5ow926/AfYQz04yaa2sz98KkZ1CJW2y
   mmGyhxZmwYT9JIcdY80ueTIOPrG01+FcG/8eaKRgBauOEgMhp5qrgy0yJ
   w==;
IronPort-SDR: AuDTIrPqhhn5FGoDfRNZPlWCYwFCZt4BlwwM4q/eVoiAurV4LvZRbHGt+HEmRE5RUJBv7kyJbE
 EO0khuLelaOPhVC9m5BLTHJFbcGXS9AS+2ThY3qDCqOgFrTleHlg5+Ab1QMWcGuFfsDGGUNew8
 NS7zhuuw5rDF4zM401KmT2UIq1PHvq3URBcqytEcpDco5kxy730/UfkcH2zoxAfYhzU7FnwZNC
 mDHn1l/PUtYauUu0DkvuGhGEIOOm5Epme9UnGjsGExZLxiVp6GRX1DG2+bi7C1h3ro6WQ+uxre
 pPI=
X-IronPort-AV: E=McAfee;i="6200,9189,10017"; a="41442165"
X-IronPort-AV: E=Sophos;i="5.83,278,1616425200"; 
   d="scan'208";a="41442165"
Received: from mail-os2jpn01lp2052.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.52])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2021 15:51:05 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSU9zVF3PQwGTrGOaKxXB1iqY0y9Jyjyiy6uM3vk6fT0yhqxOzKEd3ODo6GRFo8LR7AGTgaqdw4axWi4WYgVbbDhnkK9CO5gEyfYbcyTRjYdXt3gkYAaQ316D+xVNCLwYVyOc9sDMlAl2O9gr4yMe3g1y8Pz+hdHW0URlZLB9bYl2lX8pBoKO49P3Qs0lQqQp43TSDeG0PxAYV3ouLl70I0icIrMy3/U5zQ69ImTI3RaC7CtPYATBBBKqTJQXRWv3ElPkP4Tb4xAYecra8R31RZOdNKLPR8JzslYuzHwksLe5RHmirLySFBeKafMMZuIcX4gFyV+0o5Go+nmP+o7AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3SWwtj4qzmFnyMwMbjBILrRVzaGsuXQfK38ahs8v5c=;
 b=I0ug9q7tacmymhdMrPpbGP/ydSAv4uC8apqusNPdzszMCysDAwhZFSo7j5D5HYxZ4YdZW/y//2LjYxq+taxzbpY2OPDuzdXVCj4xC7DK3g57zStWPHiZ7TE5FtRQ5Ophaisjejj5JRu3h0WvWyW4Q+s3jnUVJFKFQQEFaSKhNC9N4ee4LpfxLMGQeOi+Ej3sysgelhjKaZGwf66sw6QIroaF7jlAujgQzA0+Drsl1nzDz+F2+BY2y3xxg8jwyxfVjQny5ujLab9rE+349epe7bVq/Hgxb4ZEJ8uhiLsj9wVwSa82jdTc/nJln9ee/aXa92glSdGxk6g0AVQGjAkgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q3SWwtj4qzmFnyMwMbjBILrRVzaGsuXQfK38ahs8v5c=;
 b=iWZewIaPt0LIGEgujahZYObTIVKUGoTDf+ZGK4JUk5NbfnBQ/glec5dOcQ9bSBJ5uIZ87nRdCMvhaz+9bo2CvE5xav6bM9JcfdhSw6None7jcXQiOXl4jqqhNFWYy3ZiMJM9KmEw0AQIjw8k1NRcBIJ2RPBrT9s7fbxK0PH5XY8=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB4856.jpnprd01.prod.outlook.com (2603:1096:604:7c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 06:51:01 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4242.019; Thu, 17 Jun 2021
 06:51:01 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        david <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Subject: RE: [PATCH v4 03/10] fs: Introduce ->corrupted_range() for superblock
Thread-Topic: [PATCH v4 03/10] fs: Introduce ->corrupted_range() for
 superblock
Thread-Index: AQHXWN/AzVDrjJsgmE+2b5OugDUMoqsV4P2AgAHv3zA=
Date:   Thu, 17 Jun 2021 06:51:01 +0000
Message-ID: <OSBPR01MB29203DC17C538F7B1B1C9224F40E9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210604011844.1756145-1-ruansy.fnst@fujitsu.com>
 <20210604011844.1756145-4-ruansy.fnst@fujitsu.com>
 <CAPcyv4h=bUCgFudKTrW09dzi8MWxg7cBC9m68zX1=HY24ftR-A@mail.gmail.com>
In-Reply-To: <CAPcyv4h=bUCgFudKTrW09dzi8MWxg7cBC9m68zX1=HY24ftR-A@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bc86cc8-d9ee-4736-37ed-08d9315c44f3
x-ms-traffictypediagnostic: OSBPR01MB4856:
x-microsoft-antispam-prvs: <OSBPR01MB4856A89FF3579D50D3422FC8F40E9@OSBPR01MB4856.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tYl0grprqRz+W6fT1QjtUggeWce5+pK/AHly/LYAfJmrvhqlNtcx+JaHfJw2SZmpcfHQFdOw1cegHG4MuYiXaryM10FXIOaRraX8OImoVEbrXWycrCF47gXmSaxEm4Y1xvJ79pHo2sDIHz7b6g7cRj8jw2jMu+x4zCYL61vYVV4lUBHc1nLfLAeIO+nfpRn8SRh0SpEMB6YiGvZHdSl71s3HFtWK3Nwq1AF5rgGJvxhM7R4VXopmcvak7p2B91tWHg/L3GShc2veEpTVt2Bme7omt7wmY6glxBZDtAkgVhBH1WK9DY8uZ38ImosVX4RYNqr/yELO/ldabbPaObjoqunRWedf1Y6OpbMo+HX4y3aEjv91fQDvsKXH+u7iTo/lLcpYrZ17MztZkDHQIC7q1rcybgeJQrcWuuP+qI9IlR0qqobSyiocJAsJeVAuJYSiXogF5Jk+sRaDk6fpwJiDo7AsG16m7s3HGOlsZrd6TpCysN1SO+zDSWB7vzUyouF1ZaoFP6DaWacfIAQQ3LJCglEgA/m29WNZmuKbKJwqWGsC/jTllEjgAXcBJ2tj5/yufN9vES1Cez81oW18/Rxf/yDhdo1WRPKOLX8VYnAI4SQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(346002)(366004)(396003)(83380400001)(316002)(7416002)(66476007)(478600001)(38100700002)(5660300002)(86362001)(7696005)(2906002)(8936002)(54906003)(6506007)(186003)(9686003)(66556008)(55016002)(26005)(71200400001)(52536014)(8676002)(6916009)(33656002)(66946007)(66446008)(85182001)(76116006)(4326008)(53546011)(64756008)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGNGa1pCek5FR0pNQjZtci8zMWQ2SmRySnJ0NDNjcmxlZUtmcm5EeXkwV0xp?=
 =?utf-8?B?VjUxZ3dKc0VNa3d5bWtxejczY09DWVlmd1dpYjJIdHpYZ255S0ptcXBMa011?=
 =?utf-8?B?ekZPeG9hTE1HTlJGQ3BOanVSZmFvbW1KMC9qQUh3cXdQVU5HRU53Sndwc0Jo?=
 =?utf-8?B?czN3ajdFRjBldE5rZW80VWdqeHY1L0gxRVd0SFErZk50a2hiUm9CZGw3R0dV?=
 =?utf-8?B?VnE1MHgwTTgrMFFMcmUzR3lwWXJUMUhWeG9jOFR3WkIvWWNEK2ZFOXB0TCsv?=
 =?utf-8?B?R3MyWmJvR3ppcVA5NWIrZnVabTdzb0FWL0lBTUhFWW0wK0ZYTTlyL29PZi9P?=
 =?utf-8?B?ek4yeVFwdWJlNlBVSGFjSUpwbDJ2MUVuck5rWitiK2RLekUvYjRCTVBDeWdS?=
 =?utf-8?B?bWxPZVJwdElaMTJ3Z0JyaEJYclBqZWFxNVo0VGFBcUQ2SXpzL2hxSkFCTTlj?=
 =?utf-8?B?U092clJ0QjdHK0JBVllGNk1pVlRMN0FHdW80YjFQVzIxWnpjTWEyeHJzRkN3?=
 =?utf-8?B?cE9OeDQ5RVhaWUttVXBQbjlhQURwTXlKQ0JxNW90VndNZ25OOHhLS09Kc0RN?=
 =?utf-8?B?aGt3SnhscklLRSt5SndFSFk5SGFwR2FLUm43bUFnVGFQNVRnSm9WU1ZrbG1D?=
 =?utf-8?B?RTVtMXlnYTJkazFUY2VPOS9tMnJKNTVsWFVQT2pyVzlWdVVpcDZsYi9vcDM4?=
 =?utf-8?B?L29vNnZtWHF4RW0raUUybnhtNlFkOHd0MEZ4WnZqOUU0R3ltdkgvY2VqcXBU?=
 =?utf-8?B?Y0VjSW50S3VITGR3WmdNN0VKM1Y2dCs0d0U1ZmI4NHE5aFFnSm5sUXJXa3NQ?=
 =?utf-8?B?WE5OZDV5cm9RWERFU0dVd0g3S3dXemxHcWxCRUJqOUFLdXRycm03L2VqaEVv?=
 =?utf-8?B?dDM0cFl3b3VqdVZ4OW5vcHc0MU1sZmZKdElVYjhLZ3NLRStsYjcwaURYYnFy?=
 =?utf-8?B?ZHBNaGo4NTJTQU5GRzJRTW9EK0pqR2IySDdDUXd1NnpjOWYvYnp2ZVpRNXVu?=
 =?utf-8?B?ZktGR0w2ZmdySnFLUEdCWDlEZjNHTUxEYjJjQ1ZhU2lWTVNJTThhWTVhLzdF?=
 =?utf-8?B?bEVOeUJWMUYwNWVUdjRVR1loSWFNdk42K2J0Z2FNNjY5REQwUHRkaUZMdVUv?=
 =?utf-8?B?ay9RRE12cUJHWjc1NktkZ0FndzVZT0srdGw5QWhpUnBoYjVVdVdWRGk5VDlM?=
 =?utf-8?B?eFpPOTIyWjFWaG9wRENCWlYraWxwcnNIVzdPQkQ2MzZISzYxdmgwMkRRQlo0?=
 =?utf-8?B?Smd3WllMdXNVcG4weElXdHFFWE1WZEJmeEcvakVHeGVYYllseFNwY2Mvbzkx?=
 =?utf-8?B?UW1DczE4OHJKdXY2UHVaUWZlY2tiRkNEbFlhNXpZeEZJYmZES1RrQld6cGZt?=
 =?utf-8?B?cC9mUnluNHNKZnNGNmtEUkFUdXRnVjkwQi95TU03Z3hqUDV0amdUalVjbFhm?=
 =?utf-8?B?aDluV0RrVlY0b3cxUWowOWpOV2l0d3IyalFIQVp5VldYMjdFbnEvRXg3NnNm?=
 =?utf-8?B?SFIzcmZrdEVJZkNyTXlIQnhiMlJkbk5tUW54bXBwbnZocS9CRk91a0lkMTBW?=
 =?utf-8?B?RFo3b0lMYmpPR2kySk9iYTcwdFVabUxEeDFrcHlUMW5QbHl3OU1ZUVRZbmIy?=
 =?utf-8?B?aGZja1hPd3dFalYzMEQ0Qno3K1BJZHphT2VkZHJva1ZhRG5iVE9rTk9LREcz?=
 =?utf-8?B?T0oxd3NxRlBNVldLbGZvZmtZb1VyNW1OdXM4ZFV1czdZREtwSUJ6QVcwYkZX?=
 =?utf-8?Q?xKgrLvvn98zJ+7/l/E/nlm2QRA0yEYD0ETrBs3y?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc86cc8-d9ee-4736-37ed-08d9315c44f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2021 06:51:01.2138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZNyeEpxnh2h2NQPVuaOkbKiYSDw2095Z24xBRfNevIfCBaZDaLNG0jLJ2hrGzsmX/it518RqkD7VhyWT6aWFkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB4856
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW4gV2lsbGlhbXMgPGRhbi5q
LndpbGxpYW1zQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAwMy8xMF0gZnM6
IEludHJvZHVjZSAtPmNvcnJ1cHRlZF9yYW5nZSgpIGZvciBzdXBlcmJsb2NrDQo+IA0KPiBbIGRy
b3Agb2xkIGxpbnV4LW52ZGltbUBsaXN0cy4wMS5vcmcsIGFkZCBudmRpbW1AbGlzdHMubGludXgu
ZGV2IF0NCj4gDQo+IE9uIFRodSwgSnVuIDMsIDIwMjEgYXQgNjoxOSBQTSBTaGl5YW5nIFJ1YW4g
PHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPiB3cm90ZToNCj4gPg0KPiA+IE1lbW9yeSBmYWlsdXJl
IG9jY3VycyBpbiBmc2RheCBtb2RlIHdpbGwgZmluYWxseSBiZSBoYW5kbGVkIGluDQo+ID4gZmls
ZXN5c3RlbS4gIFdlIGludHJvZHVjZSB0aGlzIGludGVyZmFjZSB0byBmaW5kIG91dCBmaWxlcyBv
ciBtZXRhZGF0YQ0KPiA+IGFmZmVjdGVkIGJ5IHRoZSBjb3JydXB0ZWQgcmFuZ2UsIGFuZCB0cnkg
dG8gcmVjb3ZlciB0aGUgY29ycnVwdGVkIGRhdGENCj4gPiBpZiBwb3NzaWFibGUuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0K
PiA+IC0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2ZzLmggfCAyICsrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmggaW5kZXgNCj4gPiBjM2M4OGZkYjliMmEuLjkyYWYz
NmM0MjI1ZiAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4gPiArKysgYi9p
bmNsdWRlL2xpbnV4L2ZzLmgNCj4gPiBAQCAtMjE3Niw2ICsyMTc2LDggQEAgc3RydWN0IHN1cGVy
X29wZXJhdGlvbnMgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgc2hyaW5rX2NvbnRyb2wgKik7DQo+ID4gICAgICAgICBsb25nICgqZnJlZV9jYWNoZWRfb2Jq
ZWN0cykoc3RydWN0IHN1cGVyX2Jsb2NrICosDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc3RydWN0IHNocmlua19jb250cm9sICopOw0KPiA+ICsgICAgICAgaW50ICgq
Y29ycnVwdGVkX3JhbmdlKShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBzdHJ1Y3QgYmxvY2tfZGV2
aWNlDQo+ICpiZGV2LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsb2ZmX3Qg
b2Zmc2V0LCBzaXplX3QgbGVuLCB2b2lkICpkYXRhKTsNCj4gDQo+IFdoeSBkb2VzIHRoZSBzdXBl
cmJsb2NrIG5lZWQgYSBuZXcgb3BlcmF0aW9uPyBXb3VsZG4ndCB3aGF0ZXZlciBmdW5jdGlvbiBp
cw0KPiBzcGVjaWZpZWQgaGVyZSBqdXN0IGJlIHNwZWNpZmllZCB0byB0aGUgZGF4X2RldiBhcyB0
aGUNCj4gLT5ub3RpZnlfZmFpbHVyZSgpIGhvbGRlciBjYWxsYmFjaz8NCg0KQmVjYXVzZSB3ZSBu
ZWVkIHRvIGZpbmQgb3V0IHdoaWNoIGZpbGUgaXMgZWZmZWN0ZWQgYnkgdGhlIGdpdmVuIHBvaXNv
biBwYWdlIHNvIHRoYXQgbWVtb3J5LWZhaWx1cmUgY29kZSBjYW4gZG8gY29sbGVjdF9wcm9jcygp
IGFuZCBraWxsX3Byb2NzKCkgam9icy4gIEFuZCBpdCBuZWVkcyBmaWxlc3lzdGVtIHRvIHVzZSBp
dHMgcm1hcCBmZWF0dXJlIHRvIHNlYXJjaCB0aGUgZmlsZSBmcm9tIGEgZ2l2ZW4gb2Zmc2V0LiAg
U28sIHdlIG5lZWQgdGhpcyBpbXBsZW1lbnRlZCBieSB0aGUgc3BlY2lmaWVkIGZpbGVzeXN0ZW0g
YW5kIGNhbGxlZCBieSBkYXhfZGV2aWNlJ3MgaG9sZGVyLg0KDQpUaGlzIGlzIHRoZSBjYWxsIHRy
YWNlIEkgZGVzY3JpYmVkIGluIGNvdmVyIGxldHRlcjoNCm1lbW9yeV9mYWlsdXJlKCkNCiAqIGZz
ZGF4IGNhc2UNCiBwZ21hcC0+b3BzLT5tZW1vcnlfZmFpbHVyZSgpICAgICAgPT4gcG1lbV9wZ21h
cF9tZW1vcnlfZmFpbHVyZSgpDQogIGRheF9kZXZpY2UtPmhvbGRlcl9vcHMtPmNvcnJ1cHRlZF9y
YW5nZSgpID0+DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC0gZnNfZGF4
X2NvcnJ1cHRlZF9yYW5nZSgpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IC0gbWRfZGF4X2NvcnJ1cHRlZF9yYW5nZSgpDQogICBzYi0+c19vcHMtPmN1cnJ1cHRlZF9yYW5n
ZSgpICAgID0+IHhmc19mc19jb3JydXB0ZWRfcmFuZ2UoKSAgPD09ICoqSEVSRSoqDQogICAgeGZz
X3JtYXBfcXVlcnlfcmFuZ2UoKQ0KICAgICB4ZnNfY3VycnVwdF9oZWxwZXIoKQ0KICAgICAgKiBj
b3JydXB0ZWQgb24gbWV0YWRhdGENCiAgICAgICAgICB0cnkgdG8gcmVjb3ZlciBkYXRhLCBjYWxs
IHhmc19mb3JjZV9zaHV0ZG93bigpDQogICAgICAqIGNvcnJ1cHRlZCBvbiBmaWxlIGRhdGENCiAg
ICAgICAgICB0cnkgdG8gcmVjb3ZlciBkYXRhLCBjYWxsIG1mX2RheF9raWxsX3Byb2NzKCkNCiAq
IG5vcm1hbCBjYXNlDQogbWZfZ2VuZXJpY19raWxsX3Byb2NzKCkNCg0KQXMgeW91IGNhbiBzZWUs
IHRoaXMgbmV3IGFkZGVkIG9wZXJhdGlvbiBpcyBhbiBpbXBvcnRhbnQgZm9yIHRoZSB3aG9sZSBw
cm9ncmVzcy4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbi4NCg==
