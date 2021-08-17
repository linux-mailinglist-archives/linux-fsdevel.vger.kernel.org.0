Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D753EE40B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 04:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhHQCAh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 22:00:37 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com ([216.71.158.33]:22224 "EHLO
        esa16.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233238AbhHQCAh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 22:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1629165605; x=1660701605;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=DiTwuDtFJEsUC+XjCCB3KwQ8luBISPCMnRHXmPQzDFQ=;
  b=dIFjnrOZIRoDwfwbmdRnUdY6VDcpt6r/dfRTydPCGfYfFUs5vriLhjIu
   usiAWZWQ/Dj/aKV0Cf7+IrWZA7c2Jn4Wxhvv5tkYNaKXDy5Pqew0+hoEw
   9HGSu8p0ktrpRaUg8BvDqD59RGy3ZNx4jQWnoEXLgODXI/oZpdQWdigTo
   pWgLdVe2QMzchOtra3y8IND1pU+hTeNnvSgteEMZf3I273bf4gVwJ2QqU
   I2dbuVB9AdaP3tWiPeH1AQbkMY+neXe3ZbQZfNK0xTrBb4UD8ftS0HOJN
   oUICs0E6hHb0hiradtOVFj85F9TIXj1DfyW+I8+Qg66pEWwlS3cmGfwiF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="36784935"
X-IronPort-AV: E=Sophos;i="5.84,327,1620658800"; 
   d="scan'208";a="36784935"
Received: from mail-ty1jpn01lp2053.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.53])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 10:59:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxfNh3FbVk8AheYoelXeSn4kf0CKENDYid7U5GQAq7Ewapo/MvZdwAQsxxnBQHNP3b71IH56sYvtQUCbGX+1XUGewkweLG/Z44mrNS9sAvG9BvnudX4ZCID6sVo17sCvgO90NEzMtYESAbt3msuJDje1ozLkPOyb2KaSND42huEd25sXEYrYfKMqXvnu+XZ13sqJ3X/DsO4nTVwu95RkiY/UQX/OyR8RhTTOpCYSLVTyWKrbKD6zaGICa0LZjGD8xQnqqJe8oIHnBFWjLylx2SKtJnzGVkQFGOdd6pfWvvTiH8Bze80AsBLMLfgJa0F6fwoA0wkN3qqTSRvNbE8Gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiTwuDtFJEsUC+XjCCB3KwQ8luBISPCMnRHXmPQzDFQ=;
 b=CxK86+gIM8bHXcdu4Ab68GGLdTAakbpLc46EXoofANjcIm5bEFYjK1cWmzM06ci8FYxXac2CnQevnGm7Bc9AngAfv96wbxqoJGG9BKRWOgl8NjJaKWG3c11CxPlH2Al8qir7Jz1CIK9j6hMROSjEoYmz84FILj+0zmn5CyxJrKEc8JXrKzKMyEmwyV/CVjidy8ZnRP+i75Ms5l6XJ/W9xcsPidLiuIkJGEGYSNo26FRjWyJPr+Xu4638UMphSU4Q6+XMldzIA9YyxJ9g/afgj9h9e5Iarnr11iUYIyuiEP7FHIAAHvPzJSXzFTDyUaog9gz47zj7sDJH/opFBcn4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiTwuDtFJEsUC+XjCCB3KwQ8luBISPCMnRHXmPQzDFQ=;
 b=n6is+M7o2W47TT69bAQyS3nHmzJrfaLHJJjRbVAJSAEv/zaGQjZ/Q1OTDIncCeYO3r5SySd1R7P1X6M7Q5pLm6ef5mFFXVBmtjyl5qp8xMm9Q8CSm6J3mr1l6SmhAE0t4XL+R68zqKxG72QmWTbHgtOMKHNVOjfG4IDnastdspI=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSBPR01MB2261.jpnprd01.prod.outlook.com (2603:1096:603:25::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.18; Tue, 17 Aug
 2021 01:59:56 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::6db8:ebd7:8ee4:62bb%6]) with mapi id 15.20.4415.023; Tue, 17 Aug 2021
 01:59:56 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>
Subject: RE: [PATCH RESEND v6 8/9] md: Implement dax_holder_operations
Thread-Topic: [PATCH RESEND v6 8/9] md: Implement dax_holder_operations
Thread-Index: AQHXhSopehJgFSDaDkGtTOEeGatGUKtlryUAgBFalfA=
Date:   Tue, 17 Aug 2021 01:59:56 +0000
Message-ID: <OSBPR01MB2920473CC67AC99C3947B2C5F4FE9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210730100158.3117319-1-ruansy.fnst@fujitsu.com>
 <20210730100158.3117319-9-ruansy.fnst@fujitsu.com>
 <4573e358-ff39-3627-6844-8a301d154d3e@oracle.com>
In-Reply-To: <4573e358-ff39-3627-6844-8a301d154d3e@oracle.com>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4cb0254-1af2-4fd0-259f-08d96122b632
x-ms-traffictypediagnostic: OSBPR01MB2261:
x-microsoft-antispam-prvs: <OSBPR01MB226182C387CBCD43108E0685F4FE9@OSBPR01MB2261.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYGjrMLKa95Xr8fP1z1uF3GdghjbHGdZlIindImlKBUMhk3dB5h1F003YBmui1qj3qrCbH+K5vZuWajsL4/VEa8yq/rDBJ/v7PTFsLVHlENg1H/lL+CX68UYMeioDjfFaaDtwH5fdjrn2QcCw4XKfhS6wf1/UA2qM2lrig5ZDvyL7VhH10lbSl7DeeUhnysXd4P+2LgkwY5eTwWu2W3hDS26kEJdjBVeHMautrhHA+sHAbN01DHkHxJvQdKlqIJ6F5dqOh0XJDPd3bUuSOoC4IEj6bFPO56WQXe9zuKRgVAzH4v/wF0EtzGac6DlG0w7nY2B1s5dhyHzzTpwG3TAxib8qZ8PkuvxpN6edRCg/0DjXktwPPnfc1Z+IL4oEtLMxJJcZi1uDcf8zSBbmmQvhtkv9zFUIhHnYu51MJqAW4ecv528GFeI7XjN0XMhd82PFDB/jocD0QscN/PJWaoPlG7GGcP4l4/5J5A5swueJkxRY/zocNuLQthJ/WqWuXYOK2vkXusppCpwXlTMVqM92BtcwrhT/buvm5cRRwYpbhcJPhKlzh3K2/7nHtDPNVHS1h2iT+Qgo3pJFYdM5+gW0Sh/TJQ1BFCSSxzmYYPPdOHrvSCvBpsKzsH2orJ+w4VjfEvvRU1wDf1wZjrlXHW5E+QvSrVaYlssAFpNxmvrUQExL6Fwk9X5dfiSakJo7bsdDpkHRBTp+Bgom/fI4msH0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(55016002)(83380400001)(7696005)(186003)(4326008)(9686003)(86362001)(52536014)(33656002)(85182001)(508600001)(66946007)(6506007)(5660300002)(71200400001)(316002)(8936002)(53546011)(66476007)(66556008)(66446008)(64756008)(38070700005)(38100700002)(110136005)(8676002)(76116006)(26005)(122000001)(54906003)(7416002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzB0ZTZPS1FScGhsczF0T3FlOE0vMlN0cllxRk1IN0d6WkpXNTBhU1JpTDRr?=
 =?utf-8?B?TUZ1M3BLSnJWQXdod0p4Z3pCbDdrcWZISHA4RkJ1a3d2RG4yR0N3cFpmVTZO?=
 =?utf-8?B?Y3o5U0Z0OTc1YUJlYlpIVGJqaUxFYWlVZWlRR0Q0VlFtYUZHdFNFN2pQYlpN?=
 =?utf-8?B?cGQwOFB6aDB6T2pTVHpkRDJIYmIyY21jZGxsS1BaRWg0VURjZTRqNy9wSGor?=
 =?utf-8?B?ajlXeFZScHdPUm9aaFRCdEVBS2hMSjhWSXpmV3dCa3FQVFNFQ2FXcVlLVHNE?=
 =?utf-8?B?aGFzblJCNlZWbVlrWmZLRkxpSEY5ZVJ2UVEyNGFiZHJnMTJBYks0a20vUlZE?=
 =?utf-8?B?c3RMV1RPL2pDNkR6OGlXem9OUGxhTUJ1aDdLaTYvM2htNEg2Wm1CL1ptYVRF?=
 =?utf-8?B?QU9UbVBBQUlNWUhSK1dObll5N1JZdnh2MkhBQ1BST3o5ZndDd3pKUDlHOFpi?=
 =?utf-8?B?UTJaa3d4SGhQZEZzSWZuOEcwd3NhdjRvOG0rbjRmZVh3ZmozcysvZmJpS1dR?=
 =?utf-8?B?NFFwVXo3OGJEZExJK1dOZEUrK1FqODcwaXdoZG0wT3I5TGNCK0VoZllCL2wr?=
 =?utf-8?B?WSsvb2RjbjgzdHBiZnhjL1FvMks4Z3duWEpJK0h2ZHRsMmkxTVRXSWdidlhL?=
 =?utf-8?B?Njd4L0QzMFhSc1hoY0szQkVEZGRsUXRnbkwzQVQ3ZzEvbnZtanFVZkpRNlBX?=
 =?utf-8?B?ZDlMb0VoY0FveFBuRkpYUVdEeVpuUWtneWZ3STM4VVJrMkNsWEp0dE8xeWcz?=
 =?utf-8?B?ODhROFJBS1I1TWdPeVhISUp3N244dkJhV25DQitRdTZkUVpEeHU4d1JWbDd2?=
 =?utf-8?B?dk1TMWdlN2RNYVA1a2djdW8yQnNQOGhjeWVJdHJpV0VvcTY4bUNpdkJvSVBH?=
 =?utf-8?B?bkE3RHR0WFJFWVdGTnQwOGErQXhYUkVlWGVUM3lSSXk2Rk1STTVHM0NpTlUw?=
 =?utf-8?B?NGZSWURnV1VBUldEYmoySjFGalBpaDlIOGlRRzNCOHNmYWdDZC9TbE9OTThr?=
 =?utf-8?B?aFo4Q01SclpoMFozUWdVWmxtcEdsNStaeFVkeEIwOU4rR0I4OTNLVVZnb3Rl?=
 =?utf-8?B?dXdYSFNySVAyQzlIbGoyam1ETi9VWHdOcXZSQVI3bGxIaVBHMHhpQ244TStK?=
 =?utf-8?B?WC9iNVZZVkVYb3YxWW1BT3BWR2xVWnM5RDNLcWFwRm03NGpTR0lnMGRGYThl?=
 =?utf-8?B?eFcwaWM1TkxQRW8wa2xBNmlnWXl2QXY1bWtmNkdVQzhYcWVrQ0ozUFdYZmdJ?=
 =?utf-8?B?SXJ3YlU3N3lETlI1TmtGR0JQRjk3TE5nanpXaURmMjZYSHdWZW5PWWFZd3RH?=
 =?utf-8?B?YjBvTlJqNHlkRDZuVWNRZ1lSdXNDeXZ2T1VxQmJWNG9HK1paRHRHK3hTOUpx?=
 =?utf-8?B?cGxrRHc4RUtwK05GYmZ2Vi9lYUZJSTRHTGUvUzZjSUk0U043WEpWODJoMTdl?=
 =?utf-8?B?T3h2N0xVU0xCdytFdzhWYmtKc3R0Z1VQZ095cTkycXBySFNBbUpxUEVHRlhD?=
 =?utf-8?B?cnNvZTdhYk4ybjRHSjVnck85Q2RoNHZERzY4WFV3cG5KSkNSemVaUDl0cnE3?=
 =?utf-8?B?UlJSYXRVT0VGS05icDNTKzZRRm9rQ0tqUG5qREN1ZGQ5WnpFNVRVcEJUUDBm?=
 =?utf-8?B?S3AwZjdTM1ZlZWVtbFFhMXVXYUlEYWRrb0NLd1J2ODE2WHdva1lOY0lCR3dt?=
 =?utf-8?B?SzdPVnlLZWNRMnM2dkROQ0dERU1FOFBvNXR5REtTMmZMaDV4ZGI0N2pBYlZk?=
 =?utf-8?Q?pVgaHGZO/C0eAX0crUJaId8engNYTCN+JeJ7Jan?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cb0254-1af2-4fd0-259f-08d96122b632
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 01:59:56.2248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdbpO3aLhwdXCFVjeFWrnOGx16OQaGwGyT4jU8rdsB1h5UHzKGYxzSayt6iRdNUiv3ci90MGO7CNp8AdhHef7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2261
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKYW5lIENodSA8amFuZS5jaHVA
b3JhY2xlLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgdjYgOC85XSBtZDogSW1w
bGVtZW50IGRheF9ob2xkZXJfb3BlcmF0aW9ucw0KPiANCj4gT24gNy8zMC8yMDIxIDM6MDEgQU0s
IFNoaXlhbmcgUnVhbiB3cm90ZToNCj4gPiBUaGlzIGlzIHRoZSBjYXNlIHdoZXJlIHRoZSBob2xk
ZXIgcmVwcmVzZW50cyBhIG1hcHBlZCBkZXZpY2UsIG9yIGENCj4gPiBsaXN0IG9mIG1hcHBlZCBk
ZXZpY2VzIG1vcmUgZXhhY3RseShiZWNhdXNlIGl0IGlzIHBvc3NpYmxlIHRvIGNyZWF0ZQ0KPiA+
IG1vcmUgdGhhbiBvbmUgbWFwcGVkIGRldmljZSBvbiBvbmUgcG1lbSBkZXZpY2UpLg0KPiANCj4g
Q291bGQgeW91IHNoYXJlIGhvdyBkbyB5b3UgdGVzdCB0aGlzIHNjZW5hcmlvPw0KDQpEbyB5b3Ug
bWVhbiAibW9yZSB0aGFuIG9uZSBtYXBwZWQgZGV2aWNlIG9uIG9uZSBwbWVtIGRldmljZSI/DQoN
CjEuIENyZWF0ZSAyIHBhcnRpdGlvbnMgb24gYSBwbWVtIGRldmljZShmc2RheCBtb2RlKS4NCjIu
IENyZWF0ZSBMVk0ob25lIExWKSBvbiBlYWNoIHBhcnRpdGlvbi4NCjMuIENyZWF0ZSB4ZnMgZmls
ZXN5c3RlbSBvbiBlYWNoIExWTS4NCjQuIE1lbW9yeSBmYWlsdXJlIG9uIHRoaXMgcG1lbS4NCg0K
SW4gdGhpcyBjYXNlLCB0aGVyZSBhcmUgMiBMVk1zIG9uIG9uZSBwbWVtIGRldmljZS4gIFNvIHdl
IHNob3VsZCByZWdpc3RlciB0aGlzIDIgTFZNcyBpbiBkYXhfaG9sZGVyLCBhbmQgaXRlcmF0ZSB0
aGVtIHdoZW4gbm90aWZ5aW5nIHRoZSBmYWlsdXJlLg0KDQotLQ0KVGhhbmtzLA0KUnVhbi4NCg0K
PiANCj4gdGhhbmtzLA0KPiAtamFuZQ0KPiANCj4gPg0KPiA+IEZpbmQgb3V0IHdoaWNoIG1hcHBl
ZCBkZXZpY2UgdGhlIG9mZnNldCBiZWxvbmdzIHRvLCBhbmQgdHJhbnNsYXRlIHRoZQ0KPiA+IG9m
ZnNldCBmcm9tIHRhcmdldCBkZXZpY2UgdG8gbWFwcGVkIGRldmljZS4gIFdoZW4gaXQgaXMgZG9u
ZSwgY2FsbA0KPiA+IGRheF9jb3JydXB0ZWRfcmFuZ2UoKSBmb3IgdGhlIGhvbGRlciBvZiB0aGlz
IG1hcHBlZCBkZXZpY2UuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1
YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9tZC9kbS5jIHwg
MTI2DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEyNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZC9kbS5jIGIvZHJpdmVycy9tZC9kbS5jIGlu
ZGV4DQo+ID4gMmM1ZjllNTg1MjExLi5hMzViOWE5N2E3M2YgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9tZC9kbS5jDQo+ID4gKysrIGIvZHJpdmVycy9tZC9kbS5jDQo+ID4gQEAgLTYyNiw3ICs2
MjYsMTEgQEAgc3RhdGljIHZvaWQgZG1fcHV0X2xpdmVfdGFibGVfZmFzdChzdHJ1Y3QNCj4gbWFw
cGVkX2RldmljZSAqbWQpIF9fcmVsZWFzZXMoUkNVKQ0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0
aWMgY2hhciAqX2RtX2NsYWltX3B0ciA9ICJJIGJlbG9uZyB0byBkZXZpY2UtbWFwcGVyIjsNCj4g
PiAtDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGF4X2hvbGRlcl9vcGVyYXRpb25zIGRtX2Rh
eF9ob2xkZXJfb3BzOyBzdHJ1Y3QNCj4gPiArZG1faG9sZGVyIHsNCj4gPiArCXN0cnVjdCBsaXN0
X2hlYWQgbGlzdDsNCj4gPiArCXN0cnVjdCBtYXBwZWRfZGV2aWNlICptZDsNCj4gPiArfTsNCj4g
PiAgIC8qDQo+ID4gICAgKiBPcGVuIGEgdGFibGUgZGV2aWNlIHNvIHdlIGNhbiB1c2UgaXQgYXMg
YSBtYXAgZGVzdGluYXRpb24uDQo+ID4gICAgKi8NCj4gPiBAQCAtNjM0LDYgKzYzOCw4IEBAIHN0
YXRpYyBpbnQgb3Blbl90YWJsZV9kZXZpY2Uoc3RydWN0IHRhYmxlX2RldmljZSAqdGQsDQo+IGRl
dl90IGRldiwNCj4gPiAgIAkJCSAgICAgc3RydWN0IG1hcHBlZF9kZXZpY2UgKm1kKQ0KPiA+ICAg
ew0KPiA+ICAgCXN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXY7DQo+ID4gKwlzdHJ1Y3QgbGlzdF9o
ZWFkICpob2xkZXJzOw0KPiA+ICsJc3RydWN0IGRtX2hvbGRlciAqaG9sZGVyOw0KPiA+DQo+ID4g
ICAJaW50IHI7DQo+ID4NCj4gPiBAQCAtNjUxLDYgKzY1NywxOSBAQCBzdGF0aWMgaW50IG9wZW5f
dGFibGVfZGV2aWNlKHN0cnVjdCB0YWJsZV9kZXZpY2UNCj4gPiAqdGQsIGRldl90IGRldiwNCj4g
Pg0KPiA+ICAgCXRkLT5kbV9kZXYuYmRldiA9IGJkZXY7DQo+ID4gICAJdGQtPmRtX2Rldi5kYXhf
ZGV2ID0gZGF4X2dldF9ieV9ob3N0KGJkZXYtPmJkX2Rpc2stPmRpc2tfbmFtZSk7DQo+ID4gKwlp
ZiAoIXRkLT5kbV9kZXYuZGF4X2RldikNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArDQo+ID4gKwlo
b2xkZXJzID0gZGF4X2dldF9ob2xkZXIodGQtPmRtX2Rldi5kYXhfZGV2KTsNCj4gPiArCWlmICgh
aG9sZGVycykgew0KPiA+ICsJCWhvbGRlcnMgPSBrbWFsbG9jKHNpemVvZigqaG9sZGVycyksIEdG
UF9LRVJORUwpOw0KPiA+ICsJCUlOSVRfTElTVF9IRUFEKGhvbGRlcnMpOw0KPiA+ICsJCWRheF9z
ZXRfaG9sZGVyKHRkLT5kbV9kZXYuZGF4X2RldiwgaG9sZGVycywgJmRtX2RheF9ob2xkZXJfb3Bz
KTsNCj4gPiArCX0NCj4gPiArCWhvbGRlciA9IGttYWxsb2Moc2l6ZW9mKCpob2xkZXIpLCBHRlBf
S0VSTkVMKTsNCj4gPiArCWhvbGRlci0+bWQgPSBtZDsNCj4gPiArCWxpc3RfYWRkX3RhaWwoJmhv
bGRlci0+bGlzdCwgaG9sZGVycyk7DQo+ID4gKw0KPiA+ICAgCXJldHVybiAwOw0KPiA+ICAgfQ0K
PiA+DQo+ID4gQEAgLTY1OSw5ICs2NzgsMjcgQEAgc3RhdGljIGludCBvcGVuX3RhYmxlX2Rldmlj
ZShzdHJ1Y3QgdGFibGVfZGV2aWNlICp0ZCwNCj4gZGV2X3QgZGV2LA0KPiA+ICAgICovDQo+ID4g
ICBzdGF0aWMgdm9pZCBjbG9zZV90YWJsZV9kZXZpY2Uoc3RydWN0IHRhYmxlX2RldmljZSAqdGQs
IHN0cnVjdA0KPiBtYXBwZWRfZGV2aWNlICptZCkNCj4gPiAgIHsNCj4gPiArCXN0cnVjdCBsaXN0
X2hlYWQgKmhvbGRlcnM7DQo+ID4gKwlzdHJ1Y3QgZG1faG9sZGVyICpob2xkZXIsICpuOw0KPiA+
ICsNCj4gPiAgIAlpZiAoIXRkLT5kbV9kZXYuYmRldikNCj4gPiAgIAkJcmV0dXJuOw0KPiA+DQo+
ID4gKwlob2xkZXJzID0gZGF4X2dldF9ob2xkZXIodGQtPmRtX2Rldi5kYXhfZGV2KTsNCj4gPiAr
CWlmIChob2xkZXJzKSB7DQo+ID4gKwkJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGhvbGRlciwg
biwgaG9sZGVycywgbGlzdCkgew0KPiA+ICsJCQlpZiAoaG9sZGVyLT5tZCA9PSBtZCkgew0KPiA+
ICsJCQkJbGlzdF9kZWwoJmhvbGRlci0+bGlzdCk7DQo+ID4gKwkJCQlrZnJlZShob2xkZXIpOw0K
PiA+ICsJCQl9DQo+ID4gKwkJfQ0KPiA+ICsJCWlmIChsaXN0X2VtcHR5KGhvbGRlcnMpKSB7DQo+
ID4gKwkJCWtmcmVlKGhvbGRlcnMpOw0KPiA+ICsJCQkvKiB1bnNldCBkYXhfZGV2aWNlJ3MgaG9s
ZGVyX2RhdGEgKi8NCj4gPiArCQkJZGF4X3NldF9ob2xkZXIodGQtPmRtX2Rldi5kYXhfZGV2LCBO
VUxMLCBOVUxMKTsNCj4gPiArCQl9DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAgCWJkX3VubGlua19k
aXNrX2hvbGRlcih0ZC0+ZG1fZGV2LmJkZXYsIGRtX2Rpc2sobWQpKTsNCj4gPiAgIAlibGtkZXZf
cHV0KHRkLT5kbV9kZXYuYmRldiwgdGQtPmRtX2Rldi5tb2RlIHwgRk1PREVfRVhDTCk7DQo+ID4g
ICAJcHV0X2RheCh0ZC0+ZG1fZGV2LmRheF9kZXYpOw0KPiA+IEBAIC0xMTE1LDYgKzExNTIsODkg
QEAgc3RhdGljIGludCBkbV9kYXhfemVyb19wYWdlX3JhbmdlKHN0cnVjdA0KPiBkYXhfZGV2aWNl
ICpkYXhfZGV2LCBwZ29mZl90IHBnb2ZmLA0KPiA+ICAgCXJldHVybiByZXQ7DQo+ID4gICB9DQo+
ID4NCj4gPiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0RBWF9EUklWRVIpDQo+ID4gK3N0cnVjdCBj
b3JydXB0ZWRfaGl0X2luZm8gew0KPiA+ICsJc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXY7DQo+
ID4gKwlzZWN0b3JfdCBvZmZzZXQ7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGRt
X2Jsa19jb3JydXB0ZWRfaGl0KHN0cnVjdCBkbV90YXJnZXQgKnRpLCBzdHJ1Y3QgZG1fZGV2ICpk
ZXYsDQo+ID4gKwkJCQlzZWN0b3JfdCBzdGFydCwgc2VjdG9yX3QgY291bnQsIHZvaWQgKmRhdGEp
IHsNCj4gPiArCXN0cnVjdCBjb3JydXB0ZWRfaGl0X2luZm8gKmJjID0gZGF0YTsNCj4gPiArDQo+
ID4gKwlyZXR1cm4gYmMtPmRheF9kZXYgPT0gKHZvaWQgKilkZXYtPmRheF9kZXYgJiYNCj4gPiAr
CQkJKHN0YXJ0IDw9IGJjLT5vZmZzZXQgJiYgYmMtPm9mZnNldCA8IHN0YXJ0ICsgY291bnQpOyB9
DQo+ID4gKw0KPiA+ICtzdHJ1Y3QgY29ycnVwdGVkX2RvX2luZm8gew0KPiA+ICsJc2l6ZV90IGxl
bmd0aDsNCj4gPiArCXZvaWQgKmRhdGE7DQo+ID4gK307DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50
IGRtX2Jsa19jb3JydXB0ZWRfZG8oc3RydWN0IGRtX3RhcmdldCAqdGksIHN0cnVjdCBibG9ja19k
ZXZpY2UNCj4gKmJkZXYsDQo+ID4gKwkJCSAgICAgICBzZWN0b3JfdCBzZWN0b3IsIHZvaWQgKmRh
dGEpIHsNCj4gPiArCXN0cnVjdCBtYXBwZWRfZGV2aWNlICptZCA9IHRpLT50YWJsZS0+bWQ7DQo+
ID4gKwlzdHJ1Y3QgY29ycnVwdGVkX2RvX2luZm8gKmJjID0gZGF0YTsNCj4gPiArDQo+ID4gKwly
ZXR1cm4gZGF4X2hvbGRlcl9ub3RpZnlfZmFpbHVyZShtZC0+ZGF4X2RldiwgdG9fYnl0ZXMoc2Vj
dG9yKSwNCj4gPiArCQkJCQkgYmMtPmxlbmd0aCwgYmMtPmRhdGEpOw0KPiA+ICt9DQo+ID4gKw0K
PiA+ICtzdGF0aWMgaW50IGRtX2RheF9ub3RpZnlfZmFpbHVyZV9vbmUoc3RydWN0IG1hcHBlZF9k
ZXZpY2UgKm1kLA0KPiA+ICsJCQkJICAgICBzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2RldiwNCj4g
PiArCQkJCSAgICAgbG9mZl90IG9mZnNldCwgc2l6ZV90IGxlbmd0aCwgdm9pZCAqZGF0YSkgew0K
PiA+ICsJc3RydWN0IGRtX3RhYmxlICptYXA7DQo+ID4gKwlzdHJ1Y3QgZG1fdGFyZ2V0ICp0aTsN
Cj4gPiArCXNlY3Rvcl90IHNlY3QgPSB0b19zZWN0b3Iob2Zmc2V0KTsNCj4gPiArCXN0cnVjdCBj
b3JydXB0ZWRfaGl0X2luZm8gaGkgPSB7ZGF4X2Rldiwgc2VjdH07DQo+ID4gKwlzdHJ1Y3QgY29y
cnVwdGVkX2RvX2luZm8gZGkgPSB7bGVuZ3RoLCBkYXRhfTsNCj4gPiArCWludCBzcmN1X2lkeCwg
aSwgcmMgPSAtRU5PREVWOw0KPiA+ICsNCj4gPiArCW1hcCA9IGRtX2dldF9saXZlX3RhYmxlKG1k
LCAmc3JjdV9pZHgpOw0KPiA+ICsJaWYgKCFtYXApDQo+ID4gKwkJcmV0dXJuIHJjOw0KPiA+ICsN
Cj4gPiArCS8qDQo+ID4gKwkgKiBmaW5kIHRoZSB0YXJnZXQgZGV2aWNlLCBhbmQgdGhlbiB0cmFu
c2xhdGUgdGhlIG9mZnNldCBvZiB0aGlzIHRhcmdldA0KPiA+ICsJICogdG8gdGhlIHdob2xlIG1h
cHBlZCBkZXZpY2UuDQo+ID4gKwkgKi8NCj4gPiArCWZvciAoaSA9IDA7IGkgPCBkbV90YWJsZV9n
ZXRfbnVtX3RhcmdldHMobWFwKTsgaSsrKSB7DQo+ID4gKwkJdGkgPSBkbV90YWJsZV9nZXRfdGFy
Z2V0KG1hcCwgaSk7DQo+ID4gKwkJaWYgKCEodGktPnR5cGUtPml0ZXJhdGVfZGV2aWNlcyAmJiB0
aS0+dHlwZS0+cm1hcCkpDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ICsJCWlmICghdGktPnR5cGUt
Pml0ZXJhdGVfZGV2aWNlcyh0aSwgZG1fYmxrX2NvcnJ1cHRlZF9oaXQsICZoaSkpDQo+ID4gKwkJ
CWNvbnRpbnVlOw0KPiA+ICsNCj4gPiArCQlyYyA9IHRpLT50eXBlLT5ybWFwKHRpLCBzZWN0LCBk
bV9ibGtfY29ycnVwdGVkX2RvLCAmZGkpOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJfQ0KPiA+ICsN
Cj4gPiArCWRtX3B1dF9saXZlX3RhYmxlKG1kLCBzcmN1X2lkeCk7DQo+ID4gKwlyZXR1cm4gcmM7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZG1fZGF4X25vdGlmeV9mYWlsdXJlKHN0
cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2LA0KPiA+ICsJCQkJIGxvZmZfdCBvZmZzZXQsIHNpemVf
dCBsZW5ndGgsIHZvaWQgKmRhdGEpIHsNCj4gPiArCXN0cnVjdCBkbV9ob2xkZXIgKmhvbGRlcjsN
Cj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgKmhvbGRlcnMgPSBkYXhfZ2V0X2hvbGRlcihkYXhfZGV2
KTsNCj4gPiArCWludCByYyA9IC1FTk9ERVY7DQo+ID4gKw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9l
bnRyeShob2xkZXIsIGhvbGRlcnMsIGxpc3QpIHsNCj4gPiArCQlyYyA9IGRtX2RheF9ub3RpZnlf
ZmFpbHVyZV9vbmUoaG9sZGVyLT5tZCwgZGF4X2Rldiwgb2Zmc2V0LA0KPiA+ICsJCQkJCSAgICAg
ICBsZW5ndGgsIGRhdGEpOw0KPiA+ICsJCWlmIChyYyAhPSAtRU5PREVWKQ0KPiA+ICsJCQlicmVh
azsNCj4gPiArCX0NCj4gPiArCXJldHVybiByYzsNCj4gPiArfQ0KPiA+ICsjZWxzZQ0KPiA+ICsj
ZGVmaW5lIGRtX2RheF9ub3RpZnlfZmFpbHVyZSBOVUxMDQo+ID4gKyNlbmRpZg0KPiA+ICsNCj4g
PiAgIC8qDQo+ID4gICAgKiBBIHRhcmdldCBtYXkgY2FsbCBkbV9hY2NlcHRfcGFydGlhbF9iaW8g
b25seSBmcm9tIHRoZSBtYXAgcm91dGluZS4NCj4gSXQgaXMNCj4gPiAgICAqIGFsbG93ZWQgZm9y
IGFsbCBiaW8gdHlwZXMgZXhjZXB0IFJFUV9QUkVGTFVTSCwgUkVRX09QX1pPTkVfKiB6b25lDQo+
ID4gbWFuYWdlbWVudCBAQCAtMzA1Nyw2ICszMTc3LDEwIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZGF4X29wZXJhdGlvbnMNCj4gZG1fZGF4X29wcyA9IHsNCj4gPiAgIAkuemVyb19wYWdlX3Jhbmdl
ID0gZG1fZGF4X3plcm9fcGFnZV9yYW5nZSwNCj4gPiAgIH07DQo+ID4NCj4gPiArc3RhdGljIGNv
bnN0IHN0cnVjdCBkYXhfaG9sZGVyX29wZXJhdGlvbnMgZG1fZGF4X2hvbGRlcl9vcHMgPSB7DQo+
ID4gKwkubm90aWZ5X2ZhaWx1cmUgPSBkbV9kYXhfbm90aWZ5X2ZhaWx1cmUsIH07DQo+ID4gKw0K
PiA+ICAgLyoNCj4gPiAgICAqIG1vZHVsZSBob29rcw0KPiA+ICAgICovDQo+ID4NCg==
