Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB82337F3D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 May 2021 10:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbhEMIGc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 May 2021 04:06:32 -0400
Received: from esa3.fujitsucc.c3s2.iphmx.com ([68.232.151.212]:55797 "EHLO
        esa3.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231834AbhEMIGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 May 2021 04:06:31 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 04:06:30 EDT
IronPort-SDR: nBYRPwjlzdxsM3XUbe6Mrxmo8f5Idciyc4HulaNZQEdk5z5zz1iHphdl+x1eoRyo2wUua2iomi
 9ATUagdVLINeDkAf2msfmGXF0Rp7VXHibTaDHh3NAOQD1YUqSnGQvalzUhMU7t/wyHs9+Srm0a
 9WHm6qhOQVQNs2wXDHpcDIDSFlpoaGayn0a04y32+P36wia1aMFjSkUmpcwjWRiGPBj0WnavIZ
 bq2FyO4IkCAQzR6o0KC7kwuL1wdVqdV37Ib1wWDgyXU2sij1TxMK5fCimjVL6h0wqIOEjILKy6
 52s=
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="39344606"
X-IronPort-AV: E=Sophos;i="5.82,296,1613401200"; 
   d="scan'208";a="39344606"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 16:57:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGrQTR4y+mJT1LJ1QxZtDCluwyzSL5HPr48+WtbDdBHF+fNKNo8z7REAqwSFErm0enVcR0M4TulYcPfXgOQT88sHMfCEBbcQcXthjwTk+ZPvYPqmt9W/ivwAGwQcnOx4VSDCZoVe/byNC9GyM6gi6b+hZXBnnUwHUxCJvjMysL2FuHOYPNNJtu8plgPR/Mqj3fvqCCqNFVHYWEuRrnBhzT1V/WoEZM+JddjgjVd8sMBVSXI9zM723kULunvm3MrGUuOgQ8KMtF8nfTodAnOUn5zq0tnl0JtW2KAEn/u2w4RXwwcHpHpCoSmvAhUEXH9+uOSz4nPxgew5TCvXXiXmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XXZP2p64MUEzoBDHgC1N4f3CRyJhlr5nw62SY11xqU=;
 b=liUY4YdbuO5eeXexCPKo9bn6diTe6/cjQCNrkYt5vpvSQGWBEsBjN1OKrcwga11DSLLXItZ2gMDhsxqb6Ye9k2hrSj+nBN/YRMbC16SHrTlvOxKsUeuo2g1MfNElo8e5ue7r+3sdFvhftSI2EkXNr24Xbo7RFQAGsYaiNMzWU/evaE9pNVJH8cFxWMyWKoX5rWdBIl/VQf1xW90gfqWqp/Ks1eAnUpOmc9Z14D2ZMvYnJUaYa2wodAOBWaArmaa/IbNNBqD8/xA98Ibk83abVf9in592zCzWHWdtQyc4XJ1rkXHe1b6F80eatMGziF3aEu9XdKmd8jJeJKXjG79ypA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9XXZP2p64MUEzoBDHgC1N4f3CRyJhlr5nw62SY11xqU=;
 b=hOtL/adneYXERhEoqjfYVsQd2fPH3EhZorUw0hO3RyABB0PgZDKimqAWK+l9K+xNr/cKHl/qKAujYa5NyFkMeRKkU3hICZ1UwgOSM/QwQ6YYU/Rz7onxOE717H3y2RaZFijVYn9FTdWOWiY47NC75AedJRg0eiTXyYCpza9zcUo=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB1617.jpnprd01.prod.outlook.com (2603:1096:603:2f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 13 May
 2021 07:57:47 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::b985:8239:6cf0:1228%7]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 07:57:47 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
Thread-Topic: [PATCH v5 1/7] fsdax: Introduce dax_iomap_cow_copy()
Thread-Index: AQHXRhMt0iZsAJx3Qk6pgqIZS1uA+KrfCmUAgAICTOA=
Date:   Thu, 13 May 2021 07:57:47 +0000
Message-ID: <OSBPR01MB292062DA13D47BDBF3E2321BF4519@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210511030933.3080921-1-ruansy.fnst@fujitsu.com>
 <20210511030933.3080921-2-ruansy.fnst@fujitsu.com>
 <20210512010810.GR8582@magnolia>
In-Reply-To: <20210512010810.GR8582@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [223.111.68.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a09ebc5-dc35-43b9-37af-08d915e4cc44
x-ms-traffictypediagnostic: OSAPR01MB1617:
x-microsoft-antispam-prvs: <OSAPR01MB1617D5037325586812163093F4519@OSAPR01MB1617.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RLrW3v9OwMLdYnFwguN8UTQdJ7QC4koMZiQMctXaruUJ64+BB1FGwPmNfUbVDvmvo4KZYqw6xOdaMEiW7P81wdVcZtrk9sPc/a6eIdBWTxtlyJHFmtsDwK7HR3gnGm8xDGDy39oqTfg8Ka2mBWXZ7wvM+DYekGVj2gaE6j1z99I4rkyr1htjRnHAvi7IJyEZSGaS+hd+wDSIHgK/GGd12sE8kKbf3O/WW/jONmKxP3WAIVIpiOmHA2Brm5TmqqGowMO294H46ZrNgVdwF8sdBAFPpcX16ToQr5Uhlb5AuCTaYeQtMuj9m+0fx7B0MWDH2KLhdVQNp0OuMVqViQD6XtrDko1dzQnNKcws2w7pYQD2UEudm7MdrNNQVmZSVrfC/0xveubqVH823zVh4284J30ELIJ566mgWGESZlb6BcAGSpPKs2OTmaCrvkXL5+eW8ybPsZtBB9Zq2ng96mQDCz3uIwFpAtOq33pQlfenoQayNj/Uce+RyCRgl9v7sfNxvU3hKdIQJ+G9DT5bTan6MOq8718vsqNDcoLn0Bd/uY34ANMIvZP7oLcz97rXY8d9iYKlsGrs1TrAbM5+WNc2dtjecUDuuWnq1XuDQONl+0E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(366004)(346002)(5660300002)(186003)(2906002)(9686003)(83380400001)(26005)(7416002)(6916009)(33656002)(7696005)(54906003)(478600001)(64756008)(38100700002)(316002)(85182001)(66446008)(6506007)(122000001)(66476007)(76116006)(71200400001)(52536014)(86362001)(8676002)(55016002)(8936002)(66556008)(66946007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?YXdBbHpLaGFMNFRGSS91QjBmQWMyTjZQR21wdWhMVXVzMG9VTTJrdHc0RU9W?=
 =?gb2312?B?QStLMlNzS2laSWQyR0hwM2lTS3FTZUNzekVkUWtqemVNSGdkd3dWWjB5NVEw?=
 =?gb2312?B?YnNYRnBTTk9kZC9zQmtXT1JlMVFDVTAwQ0dyUkl3VmlxcWd3STVrbjA3VnF6?=
 =?gb2312?B?QmZUUlFiSmR6YW9qWFh4enZFeWcrZ3RZbVV1RXBLcDNoYWgxTXZobE1EdFA3?=
 =?gb2312?B?UzhMUTZVemRXeHp2N2VwNEFMSkk4VmVaWkJGMkRhZFV0YTVGWHdseUlQK1Fs?=
 =?gb2312?B?cEx6eUUzNlR4UEpDd2xWNGpiTmNEbjZoc1RaK092endpZ2VOQWVVVC83M0k5?=
 =?gb2312?B?bFhwUkhDbmg0cExrT3h0bkJKNVNYelVSR0ppUDhzN1IvQ3hPS3VPL3Erc3I2?=
 =?gb2312?B?VHlDbjNYZ1VsamIvSk9xajdUbEQ0Q1dtNk5INDliSS9zaWh3cGczYjBkdHZs?=
 =?gb2312?B?MHdZR2wyWWtYYlhWZndrOGJPVDBwMW5kbXN3bzRLbGZHbXZobXZ1R01VUllK?=
 =?gb2312?B?blYrd1d2dXpyaTVTMnRxSUJrYVlnZ1BLNFkvZzU4SjlBMUxWQkh0L3ZIYWsz?=
 =?gb2312?B?VVJ4SjEzVUpEbXM4dm1Ed0FvT1JwbW1uZlNaalFJZm02MVhyd1pJU2UxRnFT?=
 =?gb2312?B?MXRzdERhTXhYS08vVkNJQ0t4K2gzYUNTYmJsbG5rbzgxempEU1hiUnJTdHln?=
 =?gb2312?B?ZzBhenoyQzRDZnJEV1FGeUxxdm81NkI0NEthdk1FOVJtN2t3eE16RVo0WXRO?=
 =?gb2312?B?Vzc1WWNVaVMwN25hQ3pLOWtIODVDYUlWL1cyallQbGx6UjZmdDZaS0ZCeG1V?=
 =?gb2312?B?bUkrcWg5d2d1SW5JU2lnUnNUMmF5RzJhdUttUmFBRGM4SU54clRPckhjMmRy?=
 =?gb2312?B?WmxuWGNPMHhlY1hnUjI2WEpHNXJCNzBMeDlmNUNQNStNejJ4cS9rWGtrU0gx?=
 =?gb2312?B?aDNLVmZJVWJIc1Z3ZTc4YnpRK1dtckFtTm5NWWwzYkhIMmpxNVVVb3R4Tkt5?=
 =?gb2312?B?S1ZVYktiaXZDb2lvR2FvRHZMeUZNdDdFZW5zeFlQU3cwMFQ4cG0xNTBCWXZC?=
 =?gb2312?B?Y1lwdjRUUm9QbjErc2xyaEMxbVFOckhOSlJhNjhKNXFKSXk0M1ZCUTBucVdH?=
 =?gb2312?B?bWRXWkJZQ05sMEY4YkZyUlI5cTk0RGpJVnRHdXNIOHlGVTNYVjVvMG9SSGNv?=
 =?gb2312?B?a0Fob041cEN1SlNiWk9td05VSXZQc3dFRkxXbmxUelE2TkxZNHRNUElnYmxO?=
 =?gb2312?B?M2pkR2YveXV2bHdUWndrUXM4U1M2MzJHbEVrRkpLblg0R3BkSHVBTUpIQmE3?=
 =?gb2312?B?emx5ejlxclNURTlOMjVkYnNSdytFNWh3TXNDaCtwL2ZuUkdteU14Q0FyUDRK?=
 =?gb2312?B?Um9YWVpHQXJXYVY0TEsxN25vUThlcmp6TVg4aTlGSWd6bXpxSUI0TFJsMEFy?=
 =?gb2312?B?QUQ4TS9SaE53Smt1OXBUS1VGVFovMC92TVNrcGpiOWFwMVRZTFhtcVErNkRu?=
 =?gb2312?B?Z1NOaHI4cGhyNVdpa2IxNkRZMTVEQTNnYlkzOThQR1R4VFZJejAzeXp2endO?=
 =?gb2312?B?eUtIdHJEZXN0OFByTTU4aG5paTFFRkRxSXJGMHZjZk9STnJDODg2ZzZBZnp6?=
 =?gb2312?B?RTk1dTd5SWk1TS9lREErWGdCUUtNelQvb3NHL3NETzF4Q2Vlc2NpQzI4SzhE?=
 =?gb2312?B?aTJOb2hxWjRRTnNZVlRUeUdUdDVUSk55bFFzNHJObFZGNUUwUEdMVUVmU1FH?=
 =?gb2312?Q?YOqtIPCE2MybLrAGqbryFEJML0caCv6rXs5iNzs?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09ebc5-dc35-43b9-37af-08d915e4cc44
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 07:57:47.2675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UglcJfQ6wCbpkJ0jevJZJ2JxpE8olmVlhMhHaTMTjqYRUdl0foVb9fW+0ZoXr0KuguDCWOEh0XFwIU1epSaG/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1617
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXJyaWNrIEouIFdvbmcgPGRq
d29uZ0BrZXJuZWwub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDEvN10gZnNkYXg6IElu
dHJvZHVjZSBkYXhfaW9tYXBfY293X2NvcHkoKQ0KPiANCj4gT24gVHVlLCBNYXkgMTEsIDIwMjEg
YXQgMTE6MDk6MjdBTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdyb3RlOg0KPiA+IEluIHRoZSBjYXNl
IHdoZXJlIHRoZSBpb21hcCBpcyBhIHdyaXRlIG9wZXJhdGlvbiBhbmQgaW9tYXAgaXMgbm90DQo+
ID4gZXF1YWwgdG8gc3JjbWFwIGFmdGVyIGlvbWFwX2JlZ2luLCB3ZSBjb25zaWRlciBpdCBpcyBh
IENvVyBvcGVyYXRpb24uDQo+ID4NCj4gPiBUaGUgZGVzdGFuY2UgZXh0ZW50IHdoaWNoIGlvbWFw
IGluZGljYXRlZCBpcyBuZXcgYWxsb2NhdGVkIGV4dGVudC4NCj4gPiBTbywgaXQgaXMgbmVlZGVk
IHRvIGNvcHkgdGhlIGRhdGEgZnJvbSBzcmNtYXAgdG8gbmV3IGFsbG9jYXRlZCBleHRlbnQuDQo+
ID4gSW4gdGhlb3J5LCBpdCBpcyBiZXR0ZXIgdG8gY29weSB0aGUgaGVhZCBhbmQgdGFpbCByYW5n
ZXMgd2hpY2ggaXMNCj4gPiBvdXRzaWRlIG9mIHRoZSBub24tYWxpZ25lZCBhcmVhIGluc3RlYWQg
b2YgY29weWluZyB0aGUgd2hvbGUgYWxpZ25lZA0KPiA+IHJhbmdlLiBCdXQgaW4gZGF4IHBhZ2Ug
ZmF1bHQsIGl0IHdpbGwgYWx3YXlzIGJlIGFuIGFsaWduZWQgcmFuZ2UuICBTbywNCj4gPiB3ZSBo
YXZlIHRvIGNvcHkgdGhlIHdob2xlIHJhbmdlIGluIHRoaXMgY2FzZS4NCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRzdS5jb20+DQo+ID4gUmV2
aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiA+IC0tLQ0KPiA+ICBm
cy9kYXguYyB8IDg2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDgxIGluc2VydGlvbnMoKyks
IDUgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZnMvZGF4LmMgYi9mcy9kYXgu
Yw0KPiA+IGluZGV4IGJmM2ZjODI0MmU2Yy4uZjAyNDliYjFkNDZhIDEwMDY0NA0KPiA+IC0tLSBh
L2ZzL2RheC5jDQo+ID4gKysrIGIvZnMvZGF4LmMNCj4gPiBAQCAtMTAzOCw2ICsxMDM4LDYxIEBA
IHN0YXRpYyBpbnQgZGF4X2lvbWFwX2RpcmVjdF9hY2Nlc3Moc3RydWN0IGlvbWFwDQo+ICppb21h
cCwgbG9mZl90IHBvcywgc2l6ZV90IHNpemUsDQo+ID4gIAlyZXR1cm4gcmM7DQo+ID4gIH0NCj4g
Pg0KPiA+ICsvKioNCj4gPiArICogZGF4X2lvbWFwX2Nvd19jb3B5KCk6IENvcHkgdGhlIGRhdGEg
ZnJvbSBzb3VyY2UgdG8gZGVzdGluYXRpb24gYmVmb3JlDQo+IHdyaXRlLg0KPiA+ICsgKiBAcG9z
OglhZGRyZXNzIHRvIGRvIGNvcHkgZnJvbS4NCj4gPiArICogQGxlbmd0aDoJc2l6ZSBvZiBjb3B5
IG9wZXJhdGlvbi4NCj4gPiArICogQGFsaWduX3NpemU6CWFsaWduZWQgdy5yLnQgYWxpZ25fc2l6
ZSAoZWl0aGVyIFBNRF9TSVpFIG9yIFBBR0VfU0laRSkNCj4gPiArICogQHNyY21hcDoJaW9tYXAg
c3JjbWFwDQo+ID4gKyAqIEBkYWRkcjoJZGVzdGluYXRpb24gYWRkcmVzcyB0byBjb3B5IHRvLg0K
PiA+ICsgKg0KPiA+ICsgKiBUaGlzIGNhbiBiZSBjYWxsZWQgZnJvbSB0d28gcGxhY2VzLiBFaXRo
ZXIgZHVyaW5nIERBWCB3cml0ZSBmYXVsdCwNCj4gPiArdG8gY29weQ0KPiA+ICsgKiB0aGUgbGVu
Z3RoIHNpemUgZGF0YSB0byBkYWRkci4gT3IsIHdoaWxlIGRvaW5nIG5vcm1hbCBEQVggd3JpdGUN
Cj4gPiArb3BlcmF0aW9uLA0KPiA+ICsgKiBkYXhfaW9tYXBfYWN0b3IoKSBtaWdodCBjYWxsIHRo
aXMgdG8gZG8gdGhlIGNvcHkgb2YgZWl0aGVyIHN0YXJ0DQo+ID4gK29yIGVuZA0KPiA+ICsgKiB1
bmFsaWduZWQgYWRkcmVzcy4gSW4gdGhpcyBjYXNlIHRoZSByZXN0IG9mIHRoZSBjb3B5IG9mIGFs
aWduZWQNCj4gPiArcmFuZ2VzIGlzDQo+ID4gKyAqIHRha2VuIGNhcmUgYnkgZGF4X2lvbWFwX2Fj
dG9yKCkgaXRzZWxmLg0KPiA+ICsgKiBBbHNvLCBub3RlIERBWCBmYXVsdCB3aWxsIGFsd2F5cyBy
ZXN1bHQgaW4gYWxpZ25lZCBwb3MgYW5kIHBvcyArIGxlbmd0aC4NCj4gPiArICovDQo+ID4gK3N0
YXRpYyBpbnQgZGF4X2lvbWFwX2Nvd19jb3B5KGxvZmZfdCBwb3MsIGxvZmZfdCBsZW5ndGgsIHNp
emVfdA0KPiA+ICthbGlnbl9zaXplLA0KPiANCj4gTml0OiBMaW51cyBoYXMgYXNrZWQgdXMgbm90
IHRvIGNvbnRpbnVlIHRoZSB1c2Ugb2YgbG9mZl90IGZvciBmaWxlIGlvIGxlbmd0aC4gIENvdWxk
DQo+IHlvdSBjaGFuZ2UgdGhpcyB0byAndWludDY0X3QgbGVuZ3RoJywgcGxlYXNlPw0KPiAoQXNz
dW1pbmcgd2UgZXZlbiBuZWVkIHRoZSBleHRyYSBsZW5ndGggYml0cz8pDQo+IA0KPiBXaXRoIHRo
YXQgZml4ZWQgdXAuLi4NCj4gUmV2aWV3ZWQtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtl
cm5lbC5vcmc+DQo+IA0KPiAtLUQNCj4gDQo+ID4gKwkJc3RydWN0IGlvbWFwICpzcmNtYXAsIHZv
aWQgKmRhZGRyKQ0KPiA+ICt7DQo+ID4gKwlsb2ZmX3QgaGVhZF9vZmYgPSBwb3MgJiAoYWxpZ25f
c2l6ZSAtIDEpOw0KPiANCj4gT3RoZXIgbml0OiBoZWFkX29mZiA9IHJvdW5kX2Rvd24ocG9zLCBh
bGlnbl9zaXplKTsgPw0KDQpXZSBuZWVkIHRoZSBvZmZzZXQgd2l0aGluIGEgcGFnZSBoZXJlLCBl
aXRoZXIgUFRFIG9yIFBNRC4gIFNvIEkgdGhpbmsgcm91bmRfZG93bigpIGlzIG5vdCBzdWl0YWJs
ZSBoZXJlLg0KDQoNCi0tDQpUaGFua3MsDQpSdWFuIFNoaXlhbmcuDQoNCj4gDQo+ID4gKwlzaXpl
X3Qgc2l6ZSA9IEFMSUdOKGhlYWRfb2ZmICsgbGVuZ3RoLCBhbGlnbl9zaXplKTsNCj4gPiArCWxv
ZmZfdCBlbmQgPSBwb3MgKyBsZW5ndGg7DQo+ID4gKwlsb2ZmX3QgcGdfZW5kID0gcm91bmRfdXAo
ZW5kLCBhbGlnbl9zaXplKTsNCj4gPiArCWJvb2wgY29weV9hbGwgPSBoZWFkX29mZiA9PSAwICYm
IGVuZCA9PSBwZ19lbmQ7DQo+ID4gKwl2b2lkICpzYWRkciA9IDA7DQo+ID4gKwlpbnQgcmV0ID0g
MDsNCj4gPiArDQo+ID4gKwlyZXQgPSBkYXhfaW9tYXBfZGlyZWN0X2FjY2VzcyhzcmNtYXAsIHBv
cywgc2l6ZSwgJnNhZGRyLCBOVUxMKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJcmV0dXJuIHJl
dDsNCj4gPiArDQo+ID4gKwlpZiAoY29weV9hbGwpIHsNCj4gPiArCQlyZXQgPSBjb3B5X21jX3Rv
X2tlcm5lbChkYWRkciwgc2FkZHIsIGxlbmd0aCk7DQo+ID4gKwkJcmV0dXJuIHJldCA/IC1FSU8g
OiAwOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCS8qIENvcHkgdGhlIGhlYWQgcGFydCBvZiB0aGUg
cmFuZ2UuICBOb3RlOiB3ZSBwYXNzIG9mZnNldCBhcyBsZW5ndGguICovDQo+ID4gKwlpZiAoaGVh
ZF9vZmYpIHsNCj4gPiArCQlyZXQgPSBjb3B5X21jX3RvX2tlcm5lbChkYWRkciwgc2FkZHIsIGhl
YWRfb2ZmKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJCQlyZXR1cm4gLUVJTzsNCj4gPiArCX0N
Cj4gPiArDQo+ID4gKwkvKiBDb3B5IHRoZSB0YWlsIHBhcnQgb2YgdGhlIHJhbmdlICovDQo+ID4g
KwlpZiAoZW5kIDwgcGdfZW5kKSB7DQo+ID4gKwkJbG9mZl90IHRhaWxfb2ZmID0gaGVhZF9vZmYg
KyBsZW5ndGg7DQo+ID4gKwkJbG9mZl90IHRhaWxfbGVuID0gcGdfZW5kIC0gZW5kOw0KPiA+ICsN
Cj4gPiArCQlyZXQgPSBjb3B5X21jX3RvX2tlcm5lbChkYWRkciArIHRhaWxfb2ZmLCBzYWRkciAr
IHRhaWxfb2ZmLA0KPiA+ICsJCQkJCXRhaWxfbGVuKTsNCj4gPiArCQlpZiAocmV0KQ0KPiA+ICsJ
CQlyZXR1cm4gLUVJTzsNCj4gPiArCX0NCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICAvKg0KPiA+ICAgKiBUaGUgdXNlciBoYXMgcGVyZm9ybWVkIGEgbG9hZCBmcm9tIGEgaG9s
ZSBpbiB0aGUgZmlsZS4gIEFsbG9jYXRpbmcgYSBuZXcNCj4gPiAgICogcGFnZSBpbiB0aGUgZmls
ZSB3b3VsZCBjYXVzZSBleGNlc3NpdmUgc3RvcmFnZSB1c2FnZSBmb3Igd29ya2xvYWRzDQo+ID4g
d2l0aCBAQCAtMTE2NywxMSArMTIyMiwxMiBAQCBkYXhfaW9tYXBfYWN0b3Ioc3RydWN0IGlub2Rl
ICppbm9kZSwNCj4gbG9mZl90IHBvcywgbG9mZl90IGxlbmd0aCwgdm9pZCAqZGF0YSwNCj4gPiAg
CXN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2ID0gaW9tYXAtPmRheF9kZXY7DQo+ID4gIAlzdHJ1
Y3QgaW92X2l0ZXIgKml0ZXIgPSBkYXRhOw0KPiA+ICAJbG9mZl90IGVuZCA9IHBvcyArIGxlbmd0
aCwgZG9uZSA9IDA7DQo+ID4gKwlib29sIHdyaXRlID0gaW92X2l0ZXJfcncoaXRlcikgPT0gV1JJ
VEU7DQo+ID4gIAlzc2l6ZV90IHJldCA9IDA7DQo+ID4gIAlzaXplX3QgeGZlcjsNCj4gPiAgCWlu
dCBpZDsNCj4gPg0KPiA+IC0JaWYgKGlvdl9pdGVyX3J3KGl0ZXIpID09IFJFQUQpIHsNCj4gPiAr
CWlmICghd3JpdGUpIHsNCj4gPiAgCQllbmQgPSBtaW4oZW5kLCBpX3NpemVfcmVhZChpbm9kZSkp
Ow0KPiA+ICAJCWlmIChwb3MgPj0gZW5kKQ0KPiA+ICAJCQlyZXR1cm4gMDsNCj4gPiBAQCAtMTE4
MCw3ICsxMjM2LDEyIEBAIGRheF9pb21hcF9hY3RvcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2Zm
X3QgcG9zLA0KPiBsb2ZmX3QgbGVuZ3RoLCB2b2lkICpkYXRhLA0KPiA+ICAJCQlyZXR1cm4gaW92
X2l0ZXJfemVybyhtaW4obGVuZ3RoLCBlbmQgLSBwb3MpLCBpdGVyKTsNCj4gPiAgCX0NCj4gPg0K
PiA+IC0JaWYgKFdBUk5fT05fT05DRShpb21hcC0+dHlwZSAhPSBJT01BUF9NQVBQRUQpKQ0KPiA+
ICsJLyoNCj4gPiArCSAqIEluIERBWCBtb2RlLCB3ZSBhbGxvdyBlaXRoZXIgcHVyZSBvdmVyd3Jp
dGVzIG9mIHdyaXR0ZW4gZXh0ZW50cywgb3INCj4gPiArCSAqIHdyaXRlcyB0byB1bndyaXR0ZW4g
ZXh0ZW50cyBhcyBwYXJ0IG9mIGEgY29weS1vbi13cml0ZSBvcGVyYXRpb24uDQo+ID4gKwkgKi8N
Cj4gPiArCWlmIChXQVJOX09OX09OQ0UoaW9tYXAtPnR5cGUgIT0gSU9NQVBfTUFQUEVEICYmDQo+
ID4gKwkJCSEoaW9tYXAtPmZsYWdzICYgSU9NQVBfRl9TSEFSRUQpKSkNCj4gPiAgCQlyZXR1cm4g
LUVJTzsNCj4gPg0KPiA+ICAJLyoNCj4gPiBAQCAtMTIxOSw2ICsxMjgwLDEzIEBAIGRheF9pb21h
cF9hY3RvcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgcG9zLA0KPiBsb2ZmX3QgbGVuZ3Ro
LCB2b2lkICpkYXRhLA0KPiA+ICAJCQlicmVhazsNCj4gPiAgCQl9DQo+ID4NCj4gPiArCQlpZiAo
d3JpdGUgJiYgc3JjbWFwLT5hZGRyICE9IGlvbWFwLT5hZGRyKSB7DQo+ID4gKwkJCXJldCA9IGRh
eF9pb21hcF9jb3dfY29weShwb3MsIGxlbmd0aCwgUEFHRV9TSVpFLCBzcmNtYXAsDQo+ID4gKwkJ
CQkJCSBrYWRkcik7DQo+ID4gKwkJCWlmIChyZXQpDQo+ID4gKwkJCQlicmVhazsNCj4gPiArCQl9
DQo+ID4gKw0KPiA+ICAJCW1hcF9sZW4gPSBQRk5fUEhZUyhtYXBfbGVuKTsNCj4gPiAgCQlrYWRk
ciArPSBvZmZzZXQ7DQo+ID4gIAkJbWFwX2xlbiAtPSBvZmZzZXQ7DQo+ID4gQEAgLTEyMzAsNyAr
MTI5OCw3IEBAIGRheF9pb21hcF9hY3RvcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgcG9z
LA0KPiBsb2ZmX3QgbGVuZ3RoLCB2b2lkICpkYXRhLA0KPiA+ICAJCSAqIHZhbGlkYXRlZCB2aWEg
YWNjZXNzX29rKCkgaW4gZWl0aGVyIHZmc19yZWFkKCkgb3INCj4gPiAgCQkgKiB2ZnNfd3JpdGUo
KSwgZGVwZW5kaW5nIG9uIHdoaWNoIG9wZXJhdGlvbiB3ZSBhcmUgZG9pbmcuDQo+ID4gIAkJICov
DQo+ID4gLQkJaWYgKGlvdl9pdGVyX3J3KGl0ZXIpID09IFdSSVRFKQ0KPiA+ICsJCWlmICh3cml0
ZSkNCj4gPiAgCQkJeGZlciA9IGRheF9jb3B5X2Zyb21faXRlcihkYXhfZGV2LCBwZ29mZiwga2Fk
ZHIsDQo+ID4gIAkJCQkJbWFwX2xlbiwgaXRlcik7DQo+ID4gIAkJZWxzZQ0KPiA+IEBAIC0xMzgy
LDYgKzE0NTAsNyBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkYXhfZmF1bHRfYWN0b3Ioc3RydWN0IHZt
X2ZhdWx0DQo+ICp2bWYsIHBmbl90ICpwZm5wLA0KPiA+ICAJdW5zaWduZWQgbG9uZyBlbnRyeV9m
bGFncyA9IHBtZCA/IERBWF9QTUQgOiAwOw0KPiA+ICAJaW50IGVyciA9IDA7DQo+ID4gIAlwZm5f
dCBwZm47DQo+ID4gKwl2b2lkICprYWRkcjsNCj4gPg0KPiA+ICAJLyogaWYgd2UgYXJlIHJlYWRp
bmcgVU5XUklUVEVOIGFuZCBIT0xFLCByZXR1cm4gYSBob2xlLiAqLw0KPiA+ICAJaWYgKCF3cml0
ZSAmJg0KPiA+IEBAIC0xMzkyLDE4ICsxNDYxLDI1IEBAIHN0YXRpYyB2bV9mYXVsdF90IGRheF9m
YXVsdF9hY3RvcihzdHJ1Y3QNCj4gdm1fZmF1bHQgKnZtZiwgcGZuX3QgKnBmbnAsDQo+ID4gIAkJ
CXJldHVybiBkYXhfcG1kX2xvYWRfaG9sZSh4YXMsIHZtZiwgaW9tYXAsIGVudHJ5KTsNCj4gPiAg
CX0NCj4gPg0KPiA+IC0JaWYgKGlvbWFwLT50eXBlICE9IElPTUFQX01BUFBFRCkgew0KPiA+ICsJ
aWYgKGlvbWFwLT50eXBlICE9IElPTUFQX01BUFBFRCAmJiAhKGlvbWFwLT5mbGFncyAmDQo+IElP
TUFQX0ZfU0hBUkVEKSkNCj4gPiArew0KPiA+ICAJCVdBUk5fT05fT05DRSgxKTsNCj4gPiAgCQly
ZXR1cm4gcG1kID8gVk1fRkFVTFRfRkFMTEJBQ0sgOiBWTV9GQVVMVF9TSUdCVVM7DQo+ID4gIAl9
DQo+ID4NCj4gPiAtCWVyciA9IGRheF9pb21hcF9kaXJlY3RfYWNjZXNzKGlvbWFwLCBwb3MsIHNp
emUsIE5VTEwsICZwZm4pOw0KPiA+ICsJZXJyID0gZGF4X2lvbWFwX2RpcmVjdF9hY2Nlc3MoaW9t
YXAsIHBvcywgc2l6ZSwgJmthZGRyLCAmcGZuKTsNCj4gPiAgCWlmIChlcnIpDQo+ID4gIAkJcmV0
dXJuIHBtZCA/IFZNX0ZBVUxUX0ZBTExCQUNLIDogZGF4X2ZhdWx0X3JldHVybihlcnIpOw0KPiA+
DQo+ID4gIAkqZW50cnkgPSBkYXhfaW5zZXJ0X2VudHJ5KHhhcywgbWFwcGluZywgdm1mLCAqZW50
cnksIHBmbiwgZW50cnlfZmxhZ3MsDQo+ID4gIAkJCQkgIHdyaXRlICYmICFzeW5jKTsNCj4gPg0K
PiA+ICsJaWYgKHdyaXRlICYmDQo+ID4gKwkgICAgc3JjbWFwLT5hZGRyICE9IElPTUFQX0hPTEUg
JiYgc3JjbWFwLT5hZGRyICE9IGlvbWFwLT5hZGRyKSB7DQo+ID4gKwkJZXJyID0gZGF4X2lvbWFw
X2Nvd19jb3B5KHBvcywgc2l6ZSwgc2l6ZSwgc3JjbWFwLCBrYWRkcik7DQo+ID4gKwkJaWYgKGVy
cikNCj4gPiArCQkJcmV0dXJuIGRheF9mYXVsdF9yZXR1cm4oZXJyKTsNCj4gPiArCX0NCj4gPiAr
DQo+ID4gIAlpZiAoc3luYykNCj4gPiAgCQlyZXR1cm4gZGF4X2ZhdWx0X3N5bmNocm9ub3VzX3Bm
bnAocGZucCwgcGZuKTsNCj4gPg0KPiA+IC0tDQo+ID4gMi4zMS4xDQo+ID4NCj4gPg0KPiA+DQo=
