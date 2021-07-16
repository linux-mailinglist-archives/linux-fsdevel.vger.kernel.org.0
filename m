Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE31C3CB2A0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 08:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbhGPGfU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 02:35:20 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com ([68.232.159.87]:13707 "EHLO
        esa7.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234429AbhGPGfT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 02:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1626417146; x=1657953146;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6HQa2/Z9WpXWSCAbFS7mapVAEg0O8QQIj3k4eyyMET0=;
  b=TjMDJeVkD3GF055wBsHNPrRJlLKf5Gy6FyaCQgbxvTen01BeoOwC2plV
   /vBGFhPJ46w2FBwewzms8b3ykRIbsnawtTPYWVcynZH+qala8Y07PbNRK
   77A7xrSXMoOuSkLpMKiGAAhxvfap/PcRzFD6gjZCggW0+RItNZGARsn+E
   s2I4GSJ8yyj6HmU/TG8+0efKEuLY6nA84L4o8uQxr8DbPC/cBJVCDJdd9
   g9usjJMZ//H5bQaISs0UInGUSfSAeVdBOya8f4+trp36XVT/AOgjYThVb
   QuexDx2tuzK0/WDosmcVRc9ZaV2JpfwEvDhdLclcK5Re2NXhZcNr+WmNT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="35021219"
X-IronPort-AV: E=Sophos;i="5.84,244,1620658800"; 
   d="scan'208";a="35021219"
Received: from mail-os2jpn01lp2055.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.55])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 15:32:21 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1e4cT5af6vm8Wjv7FJNzJLMaVXwpMqffY6utk2iWhmGHZLYuEHQjgEGirAvwuUchQpHx/pzpF6RhR9zo0gleHXqv/dQhgwtzZU9j+lub1KVfbxCodb8qVeQWvMk1lAP9/56xcFUwaY6eyvKjgDB3L0SjeSVhSmk6l1ki9DlZquADLAeQls9BeSmZu2B3aeLutI0Lz6x/8OdgT8gw1WwjBoeyDfWbzMyxFS5XJysNfsgYnc9W+2glYmsp4I5XS3Nn3gc++xxSPBqsJm/dq+pEWoUGyg5LDi2oylWwtqRu9GppCREZGy5Id5v1jNnsuAA/bgSxLXPAZp5/LhjZaf8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HQa2/Z9WpXWSCAbFS7mapVAEg0O8QQIj3k4eyyMET0=;
 b=RpkGVUB/Prs4L+NKB0p8roGJZXgrs1BDYFsMYFw5Y0v3/I2ky/tR4P6UXzKJukJHxSQpb6rXbFSzgBdfE51G6NZw5ENLMk5xqaAyfhSeMXow19FRXrxNoLeLuBAxNW2xOJBNLxQAuhuKOJdiI8sO33Ch3bLONIi3ldkFN24nvC/vssevohfHyQRs0fEClhsFHQ0Fm0Kama+haCvnKlD25eI+Eg748ubEIPGKO4h/JVtjp5hXwTqAMpIIdGy/wDhGEDTdIl0P+Yuf/6AFk0LKHQI+quGJNJFu+FTYpgMPfUwHzK1j/gl4jRoYzuesZC3IMZsHK+r4jfGiptgO+Ksb4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HQa2/Z9WpXWSCAbFS7mapVAEg0O8QQIj3k4eyyMET0=;
 b=D9AOIXAZqff2EULMguU/qHJeEyuflP2nZIvohgXeDWa6LK7atymQH69qoabLxA1ubqrs7RC2pLfjE6/gKnA48CHN9mz1y4sifeCXX5ch3eEQ5/TKeDZMuhquXeyl2jVXFU7vKT7/Jq9Din4JgB4dTI/aQNzWWwfRs7Ml1pqBnPo=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSZPR01MB6197.jpnprd01.prod.outlook.com (2603:1096:604:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Fri, 16 Jul
 2021 06:32:18 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b88e:7015:e4a2:3d9a]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b88e:7015:e4a2:3d9a%7]) with mapi id 15.20.4308.027; Fri, 16 Jul 2021
 06:32:18 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v5 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Topic: [PATCH v5 5/9] mm: Introduce mf_dax_kill_procs() for fsdax case
Thread-Index: AQHXa7EmrHLpSGG2eEOWO38ftnVtTKspT/mAgAFCBXCAAE9xAIAaXSKg
Date:   Fri, 16 Jul 2021 06:32:17 +0000
Message-ID: <OSBPR01MB29201EF10FBF32FF8B3A9168F4119@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210628000218.387833-1-ruansy.fnst@fujitsu.com>
 <20210628000218.387833-6-ruansy.fnst@fujitsu.com>
 <YNm3VeeWuI0m4Vcx@casper.infradead.org>
 <OSBPR01MB292012F7C264076E9AA645C3F4029@OSBPR01MB2920.jpnprd01.prod.outlook.com>
 <YNsIGid6CwtH/h1Z@casper.infradead.org>
In-Reply-To: <YNsIGid6CwtH/h1Z@casper.infradead.org>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b5045b9-91a2-4d62-98d8-08d94823756a
x-ms-traffictypediagnostic: OSZPR01MB6197:
x-microsoft-antispam-prvs: <OSZPR01MB6197E43ED10BFFC2CD2362C8F4119@OSZPR01MB6197.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GzS+26NwGxg4d9jZzsN5HTKGfCCu/x9fbpkZvvYP2BETjo6CpicTjGCdL3ebzA7cWui4Qb2G3jcc8we1jApiwNXcnkeQwdo0DyDQNTNrOMX67JYI2swuyYqhN2JZiVzx4mE3jKToowFKK1TV0FEs6qwuCY1KuOD8vvQCuRzfUopSSPtS+J76w5sfsdDNbqp9BGgtjULWATJebNkifi238dPfdjFoYTT8sQ3N8nAs2H1VHR6o85MPizOQ0yuc6CldAaAt34V1wRDiRlrXRk3NP59fn09hVYCdVx+3vU9QKpGeV1YTwlpVeeuN/adwX9VYoK4zANYbowtWn+RPkKlR1nsz1docAUFDqfL3lO0GQKyAYVFlAYGyh2EET54B4g+P1qkTq0UChyfmsdjXIOSqKrFEOq8uhfs8Fxp58j3x7IxCrea0qEui7d0pf/lfF51+kXEsRtXiN0KA5POfZ6U6MzDgU5RQ4zXeUkVFhwuq9uu7hNvzDyfqC7FSHr6WVVLEGKrPDra8+mizy5b2MSVSYadTJ6xtUa+w2R050XsEjTKh44SrCso0GzEshxv/bHBoiWcV1kM4ZtYrkD76dfH6N+noCw7d+T8XieWT+d/IBIiMSCsVn0RGnGueDuxzX8Y31ZNVsOu35ngJhSWlu0p0ShtPa5PMjGuvDHuCWUe2nw87n4327cTdD4yw7mHkmBvnP6vC3LYTFtREZDcOxJQotA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(366004)(396003)(136003)(83380400001)(8676002)(85182001)(7416002)(6916009)(71200400001)(122000001)(316002)(76116006)(38100700002)(86362001)(66946007)(8936002)(66446008)(54906003)(33656002)(4326008)(26005)(66476007)(66556008)(64756008)(2906002)(5660300002)(52536014)(7696005)(6506007)(55016002)(478600001)(9686003)(186003)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?KzJSeWFTMG1tb3hxbFNVb0tJZXdxOUZYY3Y5MGV1TXJ0cmJ1T0VCNHpVVnR3?=
 =?gb2312?B?bDJ4bXhEVy9FMis4Z0RXRndCZHpOWXYxMjlBUFI0cW9sUXhQMWFwc1ViMjVB?=
 =?gb2312?B?ODVHR3p1MHdLYVlEdy91TmFMbVIrTFVGK2NKNTVlRnh1OG1yclB5NVZRWlhz?=
 =?gb2312?B?WTZyK0w1T1RTWkhTV0E0REVyT1l2b0tKYjhnRDF1SmhseUF2dEk1ZmEwY05z?=
 =?gb2312?B?a05vY1hRY2Y1SDNHZ3dyaUhHaUhJc1hTUlNzRW42em5WZlNTcktTYkNNNnAx?=
 =?gb2312?B?VG9LTUtVOEZrck8wcUkzYVMrNjErcUJQcEJkNEFFdHovM3VPb0hyaFNjTDVJ?=
 =?gb2312?B?c2NoeXVRNjc0SStUNnVhdUoxdU9Md1V4cFVPUCtyL1c1V3RXNDhhU2ptZGQz?=
 =?gb2312?B?WGpUVTBwNkFQdXdzMXNrWGRSN0ZmdXh2VytQMG5aSmpMMHp4dnhiYU5lL3JB?=
 =?gb2312?B?bUhJSlZJMGUrSkV5ZVNmMmtIcWtaeWVFZDJMTTJQd0grYVAzV0tTV0E2MXhM?=
 =?gb2312?B?R2ZFZkZzVWpzZXZrL0oyWFdZSlZCSTAzbmttcmdkWGJHVGRlelZQUXpCazhp?=
 =?gb2312?B?NUxGZjh2MFRNNEszTWFiV2ZscmJnNnJ1TDl6RUJVdDZWdlhWWHArUnJvemlq?=
 =?gb2312?B?QXROYnFuZHVkUmdFU1ZHQWErY3Qzem0wZU5sM29lOFB6cldtUC9YMTloek8r?=
 =?gb2312?B?RlY2TTgrTElIOHF4eWVQNnl3cTdHYXg1Rys5MFptdlhLM3hqTUJ2Z1RqUmhw?=
 =?gb2312?B?SmFLRVVHaFNUTS9JV0poeHFzWFBSRGQ3QVNwbUtHQzgvekhhTkNqYld0ZGs0?=
 =?gb2312?B?QUNBUVVrYVUva25taTZleXNtVjBWeEtHcXE4N2RPY0lKSFJXQkh6UU9HWHUv?=
 =?gb2312?B?N3duY0UrZ01RajVHQkw0MVEvM2w5NmFYb2lsdjgrSmZzc2JUMEpmNnNDdVdr?=
 =?gb2312?B?SHhxMUZTMGhEand5c2N6dFo3RU9Hdk85NFdXeUtlUFYxN0kxUkdkbDZXdXRF?=
 =?gb2312?B?SHRpbSsxOW16RHVMSVZRODdoM3grYTRUWmpHNS9XOWJlL3dvVFgrR0pXWHdV?=
 =?gb2312?B?TmZDa3U1Tmxua0pCSTFodmhPYXNsOEV0MW1Td0hLN0JxTlFDOGVzY2wzM3dU?=
 =?gb2312?B?ZnkxNFlzYVU5S1dMV25PUGdhMUIrZ0s3dnJKOUtIbWVVbU1LVDd5dDZqNDRr?=
 =?gb2312?B?ejhjY3RiL3hJTno3M0lYaVhGcmZrWnBlb2wvazhpaEhuOXk5NEdTamdjWHdx?=
 =?gb2312?B?UFIxOXdIVHFramhubnRIZEhLMEZBZHVxNCtESWxxVTVMYTZOSkJyelNFNk9E?=
 =?gb2312?B?Q1lEc0FkWlhQUDFyNHVTS1MyOHdVRFRWQ0l2bFNCcGNjcFJQZ1piaDd6Vjdh?=
 =?gb2312?B?TjJ4a1NoaGFmSDVYeExiNHdDTW5zaVZ4T2tBZ3Npb2szODFJR2Z2d1J5VDVT?=
 =?gb2312?B?VVpEQjVpRmE5QkxMYTRlZm9BZmtPMDNpWkZtN3ErR1VFZ0c5dEp2Z3RzR0J0?=
 =?gb2312?B?NHEwMlk1a0UrUFhVd1ZOd1RhYnBiQmxYQ0lhOGVKSG9CL2I1NWhwMUIya1hH?=
 =?gb2312?B?VERHTWp2akgrQ1FMNjg3aE40WHFNS2ZLMFZuQU9Hc3N5Uk5yUTM3L0JVZWRC?=
 =?gb2312?B?anc4SmZHUFluT1RoUmcwMmoxKzFUMWg5OUxDaUpkRlgwdldjU2tKSFF4eGZo?=
 =?gb2312?B?cmpUeXc3b3VURlVudnpqY0JhR1BtRFlLUFRKTHh2WHJVbWgrZEZRMUJJeWpP?=
 =?gb2312?Q?wc7P+Omjt9VjSkBFFRRx7Q2EkCjjBlSUXlAKPS2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5045b9-91a2-4d62-98d8-08d94823756a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2021 06:32:17.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ur7kzhuP7Nyf66n+Ap10UBKipaGIxZibiMbF7I88Wb0pAbSrASfOiCD4KONmwckEXMc7fIBESGgG9te4V+PEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6197
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NSA1LzldIG1tOiBJbnRyb2R1Y2UgbWZfZGF4X2tpbGxfcHJvY3MoKSBmb3Ig
ZnNkYXggY2FzZQ0KPiANCj4gT24gVHVlLCBKdW4gMjksIDIwMjEgYXQgMDc6NDk6MjRBTSArMDAw
MCwgcnVhbnN5LmZuc3RAZnVqaXRzdS5jb20gd3JvdGU6DQo+ID4gPiBCdXQgSSB0aGluayB0aGlz
IGlzIHVubmVjZXNzYXJ5OyB3aHkgbm90IGp1c3QgcGFzcyB0aGUgUEZOIGludG8NCj4gbWZfZGF4
X2tpbGxfcHJvY3M/DQo+ID4NCj4gPiBCZWNhdXNlIHRoZSBtZl9kYXhfa2lsbF9wcm9jcygpIGlz
IGNhbGxlZCBpbiBmaWxlc3lzdGVtIHJlY292ZXJ5IGZ1bmN0aW9uLA0KPiB3aGljaCBpcyBhdCB0
aGUgZW5kIG9mIHRoZSBSTUFQIHJvdXRpbmUuICBBbmQgdGhlIFBGTiBoYXMgYmVlbiB0cmFuc2xh
dGVkIHRvDQo+IGRpc2sgb2Zmc2V0IGluIHBtZW0gZHJpdmVyIGluIG9yZGVyIHRvIGRvIFJNQVAg
c2VhcmNoIGluIGZpbGVzeXN0ZW0uICBTbywgaWYgd2UNCj4gaGF2ZSB0byBwYXNzIGl0LCBldmVy
eSBmdW5jdGlvbiBpbiB0aGlzIHJvdXRpbmUgbmVlZHMgdG8gYWRkIGFuIGFyZ3VtZW50IGZvciB0
aGlzDQo+IFBGTi4gIEkgd2FzIGhvcGluZyBJIGNhbiBhdm9pZCBwYXNzaW5nIFBGTiB0aHJvdWdo
IHRoZSB3aG9sZSBzdGFjayB3aXRoIHRoZQ0KPiBoZWxwIG9mIHRoaXMgZGF4X2xvYWRfcGZuKCku
DQo+IA0KPiBPSywgSSB0aGluayB5b3UgbmVlZCB0byBjcmVhdGU6DQo+IA0KPiBzdHJ1Y3QgbWVt
b3J5X2ZhaWx1cmUgew0KPiAJcGh5c19hZGRyX3Qgc3RhcnQ7DQo+IAlwaHlzX2FkZHJfdCBlbmQ7
DQo+IAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiB9Ow0KPiANCj4gKGEgbWVtb3J5IGZhaWx1cmUg
bWlnaHQgbm90IGJlIGFuIGVudGlyZSBwYWdlLCBzbyB3b3JraW5nIGluIHBmbnMgaXNuJ3QgdGhl
IGJlc3QNCj4gYXBwcm9hY2gpDQoNCkRvIHlvdSBtZWFuIHRoZSByYW5nZSBvZiBtZW1vcnkgZmFp
bHVyZSBtYXkgbGVzcyB0aGFuIG9uZSBwYWdlIHNpemU/ICBJIGZvdW5kIHRob3NlIG1lbW9yeV9m
YWlsdXJlKiBmdW5jdGlvbnMgYXJlIHVzaW5nIHBmbiBhcyB0aGVpciBwYXJhbWV0ZXIuICBTbyBp
biB3aGljaCBjYXNlIGl0IGNvdWxkIGJlIGxlc3MgdGhhbiBvbmUgcGFnZSBzaXplPw0KDQoNCi0t
DQpUaGFua3MsDQpSdWFuLg0KDQo+IA0KPiBUaGVuIHRoYXQgY2FuIGJlIHBhc3NlZCB0byAtPm1l
bW9yeV9mYWlsdXJlKCkgYW5kIHRoZW4gZGVlcGVyIHRvDQo+IC0+bm90aWZ5X2ZhaWx1cmUoKSwg
YW5kIGZpbmFsbHkgaW50byB4ZnNfY29ycnVwdF9oZWxwZXIoKS4NCg==
