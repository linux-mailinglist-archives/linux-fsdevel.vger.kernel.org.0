Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E02B23591C0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Apr 2021 03:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhDIB5I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Apr 2021 21:57:08 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com ([68.232.156.101]:10485 "EHLO
        esa14.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232426AbhDIB5I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Apr 2021 21:57:08 -0400
IronPort-SDR: CGYKUzoRfrkLxdYlwYcHevp9DvZGlT2HuhFh1mIcJawK+I7dRvUU9WxDBKb1BjBkfZb0KUMLsu
 amV3D1q8I4OC0JPsO+yvZEsW4Rb+od284/DQECikqFCRemQSH6x9btXrK8RRrtSEPkBcZM93ne
 EHnd1BLBXT1Geo9h5IfuvhiPxsqFzzQ51rCIbPoHEB/JJ9kuSV7g0uB+uusfcMiXhmRX42Mj0e
 T6zC+gYfkRYUGV/k3saqjwlABKnFHWfXYYvx6kiXolXTAdZfdAH52lcEg8kZqYNnC4kThL3b2p
 tS0=
X-IronPort-AV: E=McAfee;i="6000,8403,9948"; a="29245544"
X-IronPort-AV: E=Sophos;i="5.82,208,1613401200"; 
   d="scan'208";a="29245544"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 10:56:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H6QpZbm4OM+B5jPbWmNFNuhRmvIybRxIn1H26UpG57524yzOm4nZKOZe3FnVsf0rKKRGkmfnm9AHfA17/1Mi2ZK9pUni+Qc2rluV0YNuQ233ZER3URb0xv4jsjCFj4U+c7QFTSOrJsu25hEluO2cZhN1RQ9qVJsSQN8W2W/oDbUuyiawbKkUAvD2Fq0rNyijngVKCo/Uf7kgwEVqLR4qd0Znt97mXkFIE7KuUemGae7oaC6z/YnRVYgJIxvz3gXACvFiw/sFH+qxI3A4LAZ2oYWpVI6UBSJDLtcEAxJNfsH2uD0kXPCEKQVF+neddPyhS2YB1yiwaLgRVH1OxMh5nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J8YTAnBiIV/waonUTMMv6X9fLAMlH3lU/Fns6nfRUw=;
 b=RwpDcMcPcuMsOrN8h1NHYwCWfuzQklwIrBXbZ3WJk7iCDciYVTJTsG2IIrlRcf9TFRpw0Ixmz4ZZq3tgA65kYtzrXkgWs76wA68sxVXUU0D/3+JoKtfQKqDgsW3H32jD7o95yInJddpDPJ3WTBQoGPYzuko17rOdg95t8Rl8EzPnlGhQY94nL/D26NMuWb2p+eSlIl92jC9f0BjXt3HkdB4VL4EaLT9+QNmevqkEiO5tHxfvk4/KGznODw20biow6A6kZi06Kp69/Q/RXAUTycQ1sGq17l9JSdexATIWSPBgvYMP47pEFy/X2XV27+Hnnb66Oefb1uK9JDcCmobo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J8YTAnBiIV/waonUTMMv6X9fLAMlH3lU/Fns6nfRUw=;
 b=m4hhhZpxYBrLr4qO1g6YNnFpo68EeH863I0KIMBNIvQYwG4fDJOybZUTP7GOq/EAoHtO7tCL/nCK19HKTwreQ/lKa77AQu1YoOKbymlgIBTE+4QkqvRPXGYjUg8NGHtDvlPR1m5Nv/VoFWMkiNVrmyH9FRoquK9oSEYj9Zz2jpU=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OSAPR01MB2995.jpnprd01.prod.outlook.com (2603:1096:604:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Fri, 9 Apr
 2021 01:56:48 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::5a:7b3b:1e18:3152%4]) with mapi id 15.20.3999.032; Fri, 9 Apr 2021
 01:56:48 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Su Yue <l@damenly.su>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Thread-Topic: [PATCH v4 7/7] fs/xfs: Add dedupe support for fsdax
Thread-Index: AQHXLG+b4elRrPTeA0mbgmZnucDQOqqqmKUAgADU7sA=
Date:   Fri, 9 Apr 2021 01:56:48 +0000
Message-ID: <OSAPR01MB291345BD169337AE2BCAA717F4739@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210408120432.1063608-1-ruansy.fnst@fujitsu.com>
 <20210408120432.1063608-8-ruansy.fnst@fujitsu.com> <czv4syut.fsf@damenly.su>
In-Reply-To: <czv4syut.fsf@damenly.su>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: damenly.su; dkim=none (message not signed)
 header.d=none;damenly.su; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 311eb91d-fc95-483b-21f1-08d8fafabcb2
x-ms-traffictypediagnostic: OSAPR01MB2995:
x-microsoft-antispam-prvs: <OSAPR01MB29957E2B0B8F408D0AE870BAF4739@OSAPR01MB2995.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f1W8cEmZSV+PDBcWlPA0wrYMKTG1OSpX3Io30TGvCwI9VeiQLj/7gH3c7Cxkg31tImQpPs1vkJVHHdBDu3Q5uWI1jJbAPh9C7RhQgAr1zenGLXX6S7id3uolNTVct7g3yOOAyzVjyzfHr5a1NpY8Tnrji/A76YwCm7ehn07gYvad+ZZ5ntiLjQxDeF4Luqe21bkLYyPwIbvQ8kMiUOaEQl9nATmzLBfZF/JMh8IOrGltTY3uhJe9l50CSJZ7TR3sAxVFtfw1qVBbjVREh8A9QmM781lWqMuN3cowx+GACYcencD6qxq/7ebIy5Nwfapkp84Z/34mdUUBC1Ifb4BkzWvDdZ0RQ7n90cETwfg4Ki0nc36DGF4e4qOdOtlEHWt2z4DcgcrKNDdtai9TNB3vKjWzSBmN8juIgieruYUI3OI6G/v/yD1BGsMgLFb3jJGg1yGwNX4Qd47ODZgjfBgOCwRzNc4A4jENZNi8ARYaINrhhFslxpzUG7SmncJk7FbbEyrGAgHJB5YNN47oRxpApEtSokW8VBeqOs/ONXlqmOwoW44wCKnkG4I2xQrj6U97V7ycvDDw8+j/CvPcwNCVX9jY3vgAn5uclsEcu6+UiFPu7/HaHwHDMnblcg35Yt0GdCU18vPkd/RWIQcH9pq/vxWuwC8YSKtKnQi4SW6UNx9UoFT9h7a1zCA2H8eaniYm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(83380400001)(66446008)(5660300002)(76116006)(66946007)(86362001)(2906002)(33656002)(8936002)(26005)(66476007)(38100700001)(186003)(6506007)(64756008)(7416002)(7696005)(54906003)(71200400001)(4326008)(52536014)(85182001)(6916009)(478600001)(55016002)(316002)(8676002)(9686003)(66556008)(781001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MW9yMUlJeENrYWIveHR5NytQNkFwLzJzU0hUb014R3lKNS9rb2tQZHY3T3Ux?=
 =?gb2312?B?aWw2VkR0VmJXRlVJVjRaRFhraXRGQys3d09LWWx3WkpXV0h2NUdJdjZWQWtj?=
 =?gb2312?B?MmJ3Zzg3T3dPaU5ybGVBcS9ZZWhRYjV5VERGbVMzV09PTEsreFBNbm11NTEw?=
 =?gb2312?B?RGoyei9GN1ppd1A3ZGtMOFhXUmxnUEVHU0FwVUtkMFlndFcxd1VXaFpEdW4y?=
 =?gb2312?B?N3hwSjhVSWczNS91N3N2NkRTcWM3NHQvMHArSGYwVmRmTmtrRjJDN1l5dGNR?=
 =?gb2312?B?SzVJeUFYV3pZV0toY2Z4SlhSZjNud1NlZ2gwOHIrdDVvMzF6aVA3L2tQVUlO?=
 =?gb2312?B?LzhSRjVqN05PWUdZajk4RnFBaDRydFpyWENDUTZjSFVObTcrektrZGdyTUx6?=
 =?gb2312?B?ZzZQZTQ0YjRMK3B3OWF0eUFrS0orRURzSmw0QTUyaTU0cEJZVno1SFdjdEpu?=
 =?gb2312?B?TkV5WGhES1ZpRnJOZUp0dHJFMENTS3cxcEJpUjJkOHpxK0V3azBYaGNRY3Q1?=
 =?gb2312?B?Nko3QVh3VUxPZGExZXNsSzM0ZlF5ZityNWwzVjl3QTlGTTcxLzJSQnFwVUFX?=
 =?gb2312?B?YzYxMUFCNUJiOEdjanNxNFlQUWtuazBZQW5UUXpVQmt0dnZ3NTJYSnI2bXQw?=
 =?gb2312?B?NWljTVFxZ0VXS285Umo2eFpuMGg2UHIrWGlkdlRMMkg3ZjJCSFlxazJOaE84?=
 =?gb2312?B?NkpzQnFmWUI0U0xUN1ByOU5qUnRXTFZTVlpLUm9KWEFOQzlscUxzMmZ5RWlj?=
 =?gb2312?B?eEUyVWtUMVU1dHdiR3JTckw3VFdlcS85bXJqT1plUTFqYWg1VW52eXVtcWxN?=
 =?gb2312?B?RnArYmpzMkNEMTk3QUpLUjZLTHc0dkRPMnRhRDc0M21YdjFxSXZXcm9IN01F?=
 =?gb2312?B?RjN0MTliVm1lSnd1ZjQzVzBxME9EVy8yNlRGZTZ0QVV5UW96Y1g1VW0yZnVH?=
 =?gb2312?B?empqNlFPMlZzdTR0ejNWaStVQjlUd3Jmcm51Q3VMUFV5dThIK0NpbDMrdXBH?=
 =?gb2312?B?U25PUmpVNForRnF1WnBjeTJEdStrQWppU2RQTXFBMEg0azFMN0xPazRmeW16?=
 =?gb2312?B?cjJNSXM5TWNBTWh1UEFCbHVOUURoWmFJVE5wdHZMQU9CdlgvbTJzV25La0R0?=
 =?gb2312?B?TE5Rc21VUU9lb0wvcHBzcjBpMHl0eWJSNFhsamxDU0tjUXU1M0JQbXk1SzhB?=
 =?gb2312?B?M0tJalpROS80Q0grcCt6a0R6cFVVWVRnN0NzOE9zc3kvbndTeGhxRE95RmZG?=
 =?gb2312?B?TVMvNUxiRXRsUUNUVm5WOHpiK1hPaEFTNFMrcGlYWFZLQWR2QlFFS1lHSHFt?=
 =?gb2312?B?SFd6Yy9qV09OdTN5WEtmRG83dGNjdytvazg5WFNoT1VNMW81a00zeURGbXov?=
 =?gb2312?B?WDY3N2hNM3JuRkpxWTlvek11eDZlUFg3WXU2QnNJeTFXZ0MycC9yWkZlUVJT?=
 =?gb2312?B?eElHd2VUSlVLM28xUExyVTJUc1N4Z245cm5lL2gvdm1OaGVwOEZjRFJWZlI5?=
 =?gb2312?B?bUhvbkt5UVJGWXlVLzRkbndBbzRKMmFRZGpXZTBkVjV2RjRWK042bVRkQmFh?=
 =?gb2312?B?L3J2a1RRTUZnK2xqREgraWs0MytQall4QTBaN0pUU1pTaDd0d3NhNmR2Z0Yw?=
 =?gb2312?B?dXpCdTF3ZHhQRWFPc0lkNEc0M0hWZEFoK29tWWtmYWROTnRFZVJBODExaHQx?=
 =?gb2312?B?R1ZaSVZrcnNtWnpCUzJkZXNhWmFObWhmakZvamJ4M1NxOUxmTEtsWUtFeFUz?=
 =?gb2312?Q?OFXryaARjwnqtAO233PzXWh3Zn8Rf1ijUNgao2J?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 311eb91d-fc95-483b-21f1-08d8fafabcb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 01:56:48.6734
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mSKLZ17Dq+lfGTW3uU0GgB5FhIo46WjilQwzheFWrzR5oVhL2ymSAZ5aajYnn0tuniE7OgQJezNeUy6Fn2TVqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2995
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3UgWXVlIDxsQGRhbWVu
bHkuc3U+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgNy83XSBmcy94ZnM6IEFkZCBkZWR1cGUg
c3VwcG9ydCBmb3IgZnNkYXgNCj4gDQo+IA0KPiBPbiBUaHUgMDggQXByIDIwMjEgYXQgMjA6MDQs
IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+IHdyb3RlOg0KPiANCj4gPiBB
ZGQgeGZzX2JyZWFrX3R3b19kYXhfbGF5b3V0cygpIHRvIGJyZWFrIGxheW91dCBmb3IgdG93IGRh
eCBmaWxlcy4NCj4gPiBUaGVuIGNhbGwgY29tcGFyZSByYW5nZSBmdW5jdGlvbiBvbmx5IHdoZW4g
ZmlsZXMgYXJlIGJvdGggREFYIG9yIG5vdC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNoaXlh
bmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+ID4NCj4gTm90IGZhbWlseSB3aXRo
IHhmcyBjb2RlIGJ1dCByZWFkaW5nIGNvZGUgbWFrZSBteSBzbGVlcCBiZXR0ZXIgOikgU2VlIGJl
bGxvdy4NCj4gDQo+ID4gLS0tDQo+ID4gIGZzL3hmcy94ZnNfZmlsZS5jICAgIHwgMjAgKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgZnMveGZzL3hmc19pbm9kZS5jICAgfCAgOCArKysrKysrLQ0K
PiA+ICBmcy94ZnMveGZzX2lub2RlLmggICB8ICAxICsNCj4gPiAgZnMveGZzL3hmc19yZWZsaW5r
LmMgfCAgNSArKystLQ0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDMg
ZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMveGZzL3hmc19maWxlLmMgYi9m
cy94ZnMveGZzX2ZpbGUuYyBpbmRleA0KPiA+IDU3OTVkNWQ2Zjg2OS4uMWZkNDU3MTY3YzEyIDEw
MDY0NA0KPiA+IC0tLSBhL2ZzL3hmcy94ZnNfZmlsZS5jDQo+ID4gKysrIGIvZnMveGZzL3hmc19m
aWxlLmMNCj4gPiBAQCAtODQyLDYgKzg0MiwyNiBAQCB4ZnNfYnJlYWtfZGF4X2xheW91dHMoDQo+
ID4gIAkJCTAsIDAsIHhmc193YWl0X2RheF9wYWdlKGlub2RlKSk7DQo+ID4gIH0NCj4gPg0KPiA+
ICtpbnQNCj4gPiAreGZzX2JyZWFrX3R3b19kYXhfbGF5b3V0cygNCj4gPiArCXN0cnVjdCBpbm9k
ZQkJKnNyYywNCj4gPiArCXN0cnVjdCBpbm9kZQkJKmRlc3QpDQo+ID4gK3sNCj4gPiArCWludAkJ
CWVycm9yOw0KPiA+ICsJYm9vbAkJCXJldHJ5ID0gZmFsc2U7DQo+ID4gKw0KPiA+ICtyZXRyeToN
Cj4gPg0KPiAncmV0cnkgPSBmYWxzZTsnID8gc2luY2UgeGZzX2JyZWFrX2RheF9sYXlvdXRzKCkg
d29uJ3Qgc2V0IHJldHJ5IHRvIGZhbHNlIGlmIHRoZXJlIGlzDQo+IG5vIGJ1c3kgcGFnZSBpbiBp
bm9kZS0+aV9tYXBwaW5nLg0KPiBEZWFkIGxvb3Agd2lsbCBoYXBwZW4gaWYgcmV0cnkgaXMgdHJ1
ZSBvbmNlLg0KDQpZZXMsIEkgc2hvdWxkIG1vdmUgJ3JldHJ5PWZhbHNlOycgdW5kZXIgdGhlIHJl
dHJ5IGxhYmVsLg0KDQo+IA0KPiA+ICsJZXJyb3IgPSB4ZnNfYnJlYWtfZGF4X2xheW91dHMoc3Jj
LCAmcmV0cnkpOw0KPiA+ICsJaWYgKGVycm9yIHx8IHJldHJ5KQ0KPiA+ICsJCWdvdG8gcmV0cnk7
DQo+ID4gKw0KPiA+ICsJZXJyb3IgPSB4ZnNfYnJlYWtfZGF4X2xheW91dHMoZGVzdCwgJnJldHJ5
KTsNCj4gPiArCWlmIChlcnJvciB8fCByZXRyeSkNCj4gPiArCQlnb3RvIHJldHJ5Ow0KPiA+ICsN
Cj4gPiArCXJldHVybiBlcnJvcjsNCj4gPiArfQ0KPiA+ICsNCj4gPiAgaW50DQo+ID4gIHhmc19i
cmVha19sYXlvdXRzKA0KPiA+ICAJc3RydWN0IGlub2RlCQkqaW5vZGUsDQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL3hmcy94ZnNfaW5vZGUuYyBiL2ZzL3hmcy94ZnNfaW5vZGUuYyBpbmRleA0KPiA+IGY5
MzM3MGJkN2IxZS4uYzAxNzg2OTE3ZWVmIDEwMDY0NA0KPiA+IC0tLSBhL2ZzL3hmcy94ZnNfaW5v
ZGUuYw0KPiA+ICsrKyBiL2ZzL3hmcy94ZnNfaW5vZGUuYw0KPiA+IEBAIC0zNzEzLDggKzM3MTMs
MTAgQEAgeGZzX2lsb2NrMl9pb19tbWFwKA0KPiA+ICAJc3RydWN0IHhmc19pbm9kZQkqaXAyKQ0K
PiA+ICB7DQo+ID4gIAlpbnQJCQlyZXQ7DQo+ID4gKwlzdHJ1Y3QgaW5vZGUJCSppbm9kZTEgPSBW
RlNfSShpcDEpOw0KPiA+ICsJc3RydWN0IGlub2RlCQkqaW5vZGUyID0gVkZTX0koaXAyKTsNCj4g
Pg0KPiA+IC0JcmV0ID0geGZzX2lvbG9ja190d29faW5vZGVzX2FuZF9icmVha19sYXlvdXQoVkZT
X0koaXAxKSwNCj4gPiBWRlNfSShpcDIpKTsNCj4gPiArCXJldCA9IHhmc19pb2xvY2tfdHdvX2lu
b2Rlc19hbmRfYnJlYWtfbGF5b3V0KGlub2RlMSwgaW5vZGUyKTsNCj4gPiAgCWlmIChyZXQpDQo+
ID4gIAkJcmV0dXJuIHJldDsNCj4gPiAgCWlmIChpcDEgPT0gaXAyKQ0KPiA+IEBAIC0zNzIyLDYg
KzM3MjQsMTAgQEAgeGZzX2lsb2NrMl9pb19tbWFwKA0KPiA+ICAJZWxzZQ0KPiA+ICAJCXhmc19s
b2NrX3R3b19pbm9kZXMoaXAxLCBYRlNfTU1BUExPQ0tfRVhDTCwNCj4gPiAgCQkJCSAgICBpcDIs
IFhGU19NTUFQTE9DS19FWENMKTsNCj4gPiArDQo+ID4gKwlpZiAoSVNfREFYKGlub2RlMSkgJiYg
SVNfREFYKGlub2RlMikpDQo+ID4gKwkJcmV0ID0geGZzX2JyZWFrX3R3b19kYXhfbGF5b3V0cyhp
bm9kZTEsIGlub2RlMik7DQo+ID4gKw0KPiByZXQgaXMgaWdub3JlZCBoZXJlLg0KDQpUaGFua3Ms
IGl0J3MgbXkgbWlzdGFrZS4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0KPiANCj4g
LS0NCj4gU3UNCj4gPiAgCXJldHVybiAwOw0KPiA+ICB9DQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZnMveGZzL3hmc19pbm9kZS5oIGIvZnMveGZzL3hmc19pbm9kZS5oIGluZGV4DQo+ID4gODhlZTRj
MzkzMGFlLi41ZWYyMTkyNGRkZGMgMTAwNjQ0DQo+ID4gLS0tIGEvZnMveGZzL3hmc19pbm9kZS5o
DQo+ID4gKysrIGIvZnMveGZzL3hmc19pbm9kZS5oDQo+ID4gQEAgLTQzNSw2ICs0MzUsNyBAQCBl
bnVtIHhmc19wcmVhbGxvY19mbGFncyB7DQo+ID4NCj4gPiAgaW50CXhmc191cGRhdGVfcHJlYWxs
b2NfZmxhZ3Moc3RydWN0IHhmc19pbm9kZSAqaXAsDQo+ID4gIAkJCQkgIGVudW0geGZzX3ByZWFs
bG9jX2ZsYWdzIGZsYWdzKTsNCj4gPiAraW50CXhmc19icmVha190d29fZGF4X2xheW91dHMoc3Ry
dWN0IGlub2RlICppbm9kZTEsIHN0cnVjdA0KPiA+IGlub2RlICppbm9kZTIpOw0KPiA+ICBpbnQJ
eGZzX2JyZWFrX2xheW91dHMoc3RydWN0IGlub2RlICppbm9kZSwgdWludCAqaW9sb2NrLA0KPiA+
ICAJCWVudW0gbGF5b3V0X2JyZWFrX3JlYXNvbiByZWFzb24pOw0KPiA+DQo+ID4gZGlmZiAtLWdp
dCBhL2ZzL3hmcy94ZnNfcmVmbGluay5jIGIvZnMveGZzL3hmc19yZWZsaW5rLmMgaW5kZXgNCj4g
PiBhNGNkNmU4YTdhYTAuLjQ0MjZiY2M4YTk4NSAxMDA2NDQNCj4gPiAtLS0gYS9mcy94ZnMveGZz
X3JlZmxpbmsuYw0KPiA+ICsrKyBiL2ZzL3hmcy94ZnNfcmVmbGluay5jDQo+ID4gQEAgLTI5LDYg
KzI5LDcgQEANCj4gPiAgI2luY2x1ZGUgInhmc19pb21hcC5oIg0KPiA+ICAjaW5jbHVkZSAieGZz
X3NiLmgiDQo+ID4gICNpbmNsdWRlICJ4ZnNfYWdfcmVzdi5oIg0KPiA+ICsjaW5jbHVkZSA8bGlu
dXgvZGF4Lmg+DQo+ID4NCj4gPiAgLyoNCj4gPiAgICogQ29weSBvbiBXcml0ZSBvZiBTaGFyZWQg
QmxvY2tzDQo+ID4gQEAgLTEzMjQsOCArMTMyNSw4IEBAIHhmc19yZWZsaW5rX3JlbWFwX3ByZXAo
DQo+ID4gIAlpZiAoWEZTX0lTX1JFQUxUSU1FX0lOT0RFKHNyYykgfHwgWEZTX0lTX1JFQUxUSU1F
X0lOT0RFKGRlc3QpKQ0KPiA+ICAJCWdvdG8gb3V0X3VubG9jazsNCj4gPg0KPiA+IC0JLyogRG9u
J3Qgc2hhcmUgREFYIGZpbGUgZGF0YSBmb3Igbm93LiAqLw0KPiA+IC0JaWYgKElTX0RBWChpbm9k
ZV9pbikgfHwgSVNfREFYKGlub2RlX291dCkpDQo+ID4gKwkvKiBEb24ndCBzaGFyZSBEQVggZmls
ZSBkYXRhIHdpdGggbm9uLURBWCBmaWxlLiAqLw0KPiA+ICsJaWYgKElTX0RBWChpbm9kZV9pbikg
IT0gSVNfREFYKGlub2RlX291dCkpDQo+ID4gIAkJZ290byBvdXRfdW5sb2NrOw0KPiA+DQo+ID4g
IAlpZiAoIUlTX0RBWChpbm9kZV9pbikpDQo=
