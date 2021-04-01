Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468BB350FB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 09:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbhDAHB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 03:01:56 -0400
Received: from esa15.fujitsucc.c3s2.iphmx.com ([68.232.156.107]:42242 "EHLO
        esa15.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233195AbhDAHBY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 03:01:24 -0400
IronPort-SDR: RmnJhydFbZasSQ1LskITt8J+lQXp8OsIKxZQD8cyMkGfg49LGq3vb2ReNZwyB4KZWWKexlyUwu
 6wdXBDjwedNMcxh5L5Afd+tUSj2VtQo3Bk6X15SqTP+ZaHC297U3sAHebkEi4TLPPgMk4uDYFm
 /xZdCBWTLdc7KilZgNvbFTZsi2b4UHw+ljsHSjAgv4QikY6GqEftCgV5Ew/ruMjvlT3x54R468
 GkYqZDHDpWYcU5ZJHY4k/EyWLmz0JR3lTlP7carMU3RxuXrfsff7PHhZ3oeX00X38z1OszOSi9
 wa0=
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="28782842"
X-IronPort-AV: E=Sophos;i="5.81,296,1610377200"; 
   d="scan'208";a="28782842"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 16:00:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMvfzLjsv+K9o5+ZBtV27V3voh8i9nL57hweGf0ElfVXZ0KuSEmk2ixC6qWylp1JcHHAFXNOWz2nGb2QBxCGH/z3kBih1Spn+UCMqts6q0AG2oDXJlbpRupUPEJq1yng8c+vfbiLJAwZh3ihN6sbaoejxNaJIPmTNwZO1J/jtUoDPYQw6N5I7f0nAf7wgZLzm4Jpt1zlHMJ5FL9fUpruir+vIITY4UA/HGNqxqjIWS32zc3vTybqNCAhLZ4w0M6TDg40Arb4r8J8e11dUC0y2thV/3201Qvh8qGHCscrmU8X7+CvPqj6ncDToPYsFLpW+Vg6GSjyFFB/WL4iuQc9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WfKqmT7eVYmofPM3U2KDpt3nefTCfdTOOC0Mb4YIRw=;
 b=NZAxPsl02eRvOKxTZRsYUnW6MpnfdCvhQWnSeSxTuBO1RHSwKSYVLcrXRP6zjzS0QyD3QdKsOiHr0VctL+BEY55kZqyiij+5gUWDhbXMEZGSNG0UK9V+WOjn0DBWgf+rJi4DfTVwK6CboyRROYl/Xq19re5j28vneeTaDAyCeo44uy8IPudUveL29MTzZ+qggzMXQ10fPqzvVCr0b7FS8kCA8bpLaZopIjV4vBGkh7O4IqjbEYVgR/QvHkzVBtRFaxwR72/Hlxj/TUm+jBFwdEGPmrJ2tPhcbd1B0xHjuQWahdrJrAYlqDnJCZz9ogYNv6DnTESoJts/uoAeuWmJAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WfKqmT7eVYmofPM3U2KDpt3nefTCfdTOOC0Mb4YIRw=;
 b=j4Cfe6k3cdazlDmc/yWE4GziagtsRDaYCXPd0orMl6OA4OgHgOMPf3wQ66Dl8PNM2OhxnvdlYVMltC8kJVu02bDevjpoURdWTyV6tJvlyGrqbv5XT1DXTmAoZ+YwBm7jjEKLLUnzUZMVkqQZZ9Tbcss9k5qWpHnmD3kIhRhRHe0=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OSAPR01MB2178.jpnprd01.prod.outlook.com (2603:1096:603:1a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 1 Apr
 2021 07:00:56 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 07:00:56 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
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
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@lst.de" <hch@lst.de>, "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v3 06/10] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Thread-Topic: [PATCH v3 06/10] fsdax: Add dax_iomap_cow_copy() for
 dax_iomap_zero
Thread-Index: AQHXHGKpPihQKC5ahUGgPX+Z1EC1I6qfTFQAgAAC37A=
Date:   Thu, 1 Apr 2021 07:00:55 +0000
Message-ID: <OSBPR01MB29206BCD28F769EA87E1609BF47B9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210319015237.993880-7-ruansy.fnst@fujitsu.com>
 <20210401064506.47pz6u2gegp6s2ky@riteshh-domain>
In-Reply-To: <20210401064506.47pz6u2gegp6s2ky@riteshh-domain>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9e52d4a-99e1-45f4-dcca-08d8f4dbe5ad
x-ms-traffictypediagnostic: OSAPR01MB2178:
x-microsoft-antispam-prvs: <OSAPR01MB21785B96A1E2871BBA4D7816F47B9@OSAPR01MB2178.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lE2uRPsGZu+yYU1dL6XJp9NsEd2JuyUnPinUMNmeyWfRIPBoYzETFfTSXosnIkSj2+V2InZ4HSk/auo96Q8CP+TleKf7S+UxUOF1gjJG3DB73RnskOXPr5bkcZPvuRyQbexjw4WygfNsxF8os/+iiw4DwcVzKsHjw8Mo+l55L74NvKM7RTBtvtxk95GwSImJDUF2ArXqTNbVsRC87SfQq5hobBWp3N7bZuS8YaAFrI1MaJ6pExF7CQVUX2R5hVLkbDCujFFL5XcLZrQvukCUxwKIoF2OUOYvP+eFjVbAEZCFZpGCpg0TMVvA/1eOBZAwhbt5uYW35u5LT1WJT46F0PpD762r3w9hVkQh6rtYRhnSXExUgSmLWGGJcU0M1qJ7JFt7eiz4eayylO0HpOkBCkqI2QTgqN7lYBopKVBPtWlSF86B5OfdhgDbiLpgeA7lNJ4IudF33ux9ktFzq2M5NzmMwBPxYiNI8Hd44lXIKYCaJro1xTuxHkAOsc4omEEVvkkmmGm/1dmfKhR64IOAkyJFF6sswb+ylXa/FJDMj4QNrGvRM9JP/GfRoWSmuI5iuCRhYHyPXQ8LQWtqKJQEA1K8WaewAldERPAfeck++2aNLV7XChJF/W3Dy7gf7Vffl9JLLZbdAd4H5l0qQxCqT8ymsZTCbU1momjg4v1S7w8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(26005)(83380400001)(71200400001)(7696005)(54906003)(9686003)(66556008)(52536014)(478600001)(64756008)(53546011)(5660300002)(66946007)(6506007)(66446008)(186003)(55016002)(33656002)(66476007)(2906002)(85182001)(6916009)(8676002)(8936002)(4326008)(38100700001)(76116006)(86362001)(316002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?MVdFZ1JmMHpYUkM1NDJDTGNuNXo5eldIY09XN21VbVhFRU1PNVNUL1VOU2Nu?=
 =?gb2312?B?eEU0WkRNMWdWbVorUXVINnJBSVVTSURabC9WenVJL0hUakxpaFhMRWViOWRG?=
 =?gb2312?B?TExweStsQWVsMGRncFlWejNZUjFFZ0FoU2hsM1NuZUd3Q0dqVkh6Z0VwV2VB?=
 =?gb2312?B?WDhjU0lzYmgycW5qUEVFVGVoWVQ3NVp0NlYzRGZ2ejg3TnozMm43UFQzU2dk?=
 =?gb2312?B?RGx1cm1uaE9GWGpQaUU1eU9xRldNdnZyWG1aSVhyalBGT0Y4UUlNZXkvYzNo?=
 =?gb2312?B?T0xLeGx2TWNqVkVrc2x2YkVRbDFBZDVJM1BDeE1SVTVQN1hPQzhOeHB2eGEy?=
 =?gb2312?B?Zk1adlJDejhwQ3FhdjVZV2s1NkFNN0NsTzFNUW9oazFPWjN5NkFEQ3V0MlBu?=
 =?gb2312?B?NkhhMzNodmFTU1hqdDY5M0ZnRXNEVFNnNFZBOTZ0bWJRY0I3Z1NGRlI2S2lX?=
 =?gb2312?B?ZHpQR3hKT3JuQ3lOYTlNS0hNdlpncU1MU3BzL3ZEVFhtOTZ3blFlWDYrZktJ?=
 =?gb2312?B?b0ZmTWQxWldGMVRZbXdzdy9hd0I3WDVBTytHSVlsOTdpNXhmdXdoVlNvOHkr?=
 =?gb2312?B?YUNSKzlTeFhDeThzSG1KQ2FXSzVHNU42YWVmSVlnMXR6MnhGMmdhMUptRUda?=
 =?gb2312?B?ai9icW1nb3F3WVBTRXVHNVF6TXI5UXBoTjdJbzFiMTF4SzVMc0ZZTjJuRm5l?=
 =?gb2312?B?THowZTdSQkZmVXR3MFN6T2R5M1NDbG5pYzJWRkh6Q1pyYVJEZnFtZ1VFVFdX?=
 =?gb2312?B?V0Y2L0pubXp4dDRLbUhGNDdiazNFSHFPdDhjMkdvYWlCdXc1b0xDMXdQT0Nq?=
 =?gb2312?B?bkRNOUltWjk2OWdoY0FjdE1jME1lb0xDdzJ6MzgxcDh5TzlUdGh5QU8rNFJL?=
 =?gb2312?B?Nk9ZWWszSm1kbU9YYUtPblI1cDVjZnFJSEIvK2ZidU8ydmx1dG9HV3VqYTVU?=
 =?gb2312?B?MWpMbVpBNmtjUGJrOWlTUVRDSE1hUFlrNjQzNkx5QmI0aXFaS01EVW9obkN4?=
 =?gb2312?B?cFpzS1ZLMmxNNHExSzZINkZqWk1xQ3NROEFabCtySnZpYTNYbVlkWVhyamkv?=
 =?gb2312?B?dmFlNTZUMnR4NTFiTEJINHFoVTFpSWkzVzhOL2dGZUw0UGJqeldsWFdQd083?=
 =?gb2312?B?MGxnTG9aOGxHYnZwdVhQdC9wTU5OQlhNaVRWeForT2Q3S3Mxd0QrSlU1OWdD?=
 =?gb2312?B?dWo5MzRYc0VFUzY4Y3BUc3BQQWlPeW9wOHNOakp3azNCNmYwOXIwcXpjVWc1?=
 =?gb2312?B?R1Qrd2oydDZZTndCWk5BcXhTeWlTdkFoS3g3MCtSeFYyeDM0KzNsVk5CWEt0?=
 =?gb2312?B?OVBrUjdBY3E1VC92cTRXdlc2ZFBEaXhOM2lXV28vakhTZXgwY1ZRVk9Eb3h0?=
 =?gb2312?B?TTNvYmw3UXoxZVphRmNnRnhvSVlLT3MwaC9adDcwTkFScjBLOHl0UTRrMFFD?=
 =?gb2312?B?dG56SVd0Q2h6VmdqM2xOSXd2Q21YU3N2bFFRaFJ6ZVlXQ2hUZmpJWVd3NVhn?=
 =?gb2312?B?SmtJanhDYUp2cTJVbUZtOHRmWjUySGNkSFM0K3JIQkNxNXIySUcxc0RwM1lZ?=
 =?gb2312?B?YVFHYkNBVEhkOVBpa0RWRUlXWWlnM3Q0NVdIK09OTmVJaXhVRC9iZDdjUzBS?=
 =?gb2312?B?eHNHWFR0NGwyMldnTHdRdDBQeXo2ZDZEL1pUZS9zNXdVRFFrMm1iRFFuc3E5?=
 =?gb2312?B?di9HQ0xUN09Uek1jU3NZMEVIeXcydzBSeE8wRldoUmhQY2FNQlpkM3UyWjBv?=
 =?gb2312?Q?2d57fq0EPXOWzJPsH+la4KmroGoXhtigKyUA9Kc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e52d4a-99e1-45f4-dcca-08d8f4dbe5ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 07:00:55.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpH1gFhopND6pEgnDQpTfKHbjYa+PviZ8QX/Zi7VcVRnw3wg6Gpd/b/g7FmuvSrYROt8lAyuR1JoKIY6kWeviQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2178
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUml0ZXNoIEhhcmphbmkg
PHJpdGVzaC5saXN0QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEFwcmlsIDEsIDIwMjEg
Mjo0NSBQTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA2LzEwXSBmc2RheDogQWRkIGRheF9p
b21hcF9jb3dfY29weSgpIGZvcg0KPiBkYXhfaW9tYXBfemVybw0KPiANCj4gT24gMjEvMDMvMTkg
MDk6NTJBTSwgU2hpeWFuZyBSdWFuIHdyb3RlOg0KPiA+IFB1bmNoIGhvbGUgb24gYSByZWZsaW5r
ZWQgZmlsZSBuZWVkcyBkYXhfY29weV9lZGdlKCkgdG9vLiAgT3RoZXJ3aXNlLA0KPiA+IGRhdGEg
aW4gbm90IGFsaWduZWQgYXJlYSB3aWxsIGJlIG5vdCBjb3JyZWN0LiAgU28sIGFkZCB0aGUgc3Jj
bWFwIHRvDQo+ID4gZGF4X2lvbWFwX3plcm8oKSBhbmQgcmVwbGFjZSBtZW1zZXQoKSBhcyBkYXhf
Y29weV9lZGdlKCkuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5z
eS5mbnN0QGZ1aml0c3UuY29tPg0KPiA+IC0tLQ0KPiA+ICBmcy9kYXguYyAgICAgICAgICAgICAg
IHwgOSArKysrKysrLS0NCj4gPiAgZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyB8IDIgKy0NCj4gPiAg
aW5jbHVkZS9saW51eC9kYXguaCAgICB8IDMgKystDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9mcy9k
YXguYyBiL2ZzL2RheC5jDQo+ID4gaW5kZXggY2ZlNTEzZWIxMTFlLi4zNDgyOTdiMzhmNzYgMTAw
NjQ0DQo+ID4gLS0tIGEvZnMvZGF4LmMNCj4gPiArKysgYi9mcy9kYXguYw0KPiA+IEBAIC0xMTc0
LDcgKzExNzQsOCBAQCBzdGF0aWMgdm1fZmF1bHRfdCBkYXhfcG1kX2xvYWRfaG9sZShzdHJ1Y3QN
Cj4gPiB4YV9zdGF0ZSAqeGFzLCBzdHJ1Y3Qgdm1fZmF1bHQgKnZtZiwgIH0gICNlbmRpZiAvKiBD
T05GSUdfRlNfREFYX1BNRA0KPiA+ICovDQo+ID4NCj4gPiAtczY0IGRheF9pb21hcF96ZXJvKGxv
ZmZfdCBwb3MsIHU2NCBsZW5ndGgsIHN0cnVjdCBpb21hcCAqaW9tYXApDQo+ID4gK3M2NCBkYXhf
aW9tYXBfemVybyhsb2ZmX3QgcG9zLCB1NjQgbGVuZ3RoLCBzdHJ1Y3QgaW9tYXAgKmlvbWFwLA0K
PiA+ICsJCXN0cnVjdCBpb21hcCAqc3JjbWFwKQ0KPiANCj4gRG8gd2Uga25vdyB3aHkgZG9lcyBk
YXhfaW9tYXBfemVybygpIG9wZXJhdGVzIG9uIFBBR0VfU0laRSByYW5nZT8NCj4gSUlVQywgZGF4
X3plcm9fcGFnZV9yYW5nZSgpIGNhbiB0YWtlIG5yX3BhZ2VzIGFzIGEgcGFyYW1ldGVyLiBCdXQg
d2Ugc3RpbGwNCj4gYWx3YXlzIHVzZSBvbmUgcGFnZSBhdCBhIHRpbWUuIFdoeSBpcyB0aGF0Pw0K
DQpJIHRoaW5rIHdlIGNhbiBoYW5kbGUgbW9yZSB0aGFuIG9uZSBwYWdlIGhlcmUuICBUaGUgbGVu
Z3RoIGNhbiBiZSBtb3JlIHRoYW4gb25lIFBBR0VfU0laRS4NCg0KPiANCj4gPiAgew0KPiA+ICAJ
c2VjdG9yX3Qgc2VjdG9yID0gaW9tYXBfc2VjdG9yKGlvbWFwLCBwb3MgJiBQQUdFX01BU0spOw0K
PiA+ICAJcGdvZmZfdCBwZ29mZjsNCj4gPiBAQCAtMTIwNCw3ICsxMjA1LDExIEBAIHM2NCBkYXhf
aW9tYXBfemVybyhsb2ZmX3QgcG9zLCB1NjQgbGVuZ3RoLCBzdHJ1Y3QNCj4gaW9tYXAgKmlvbWFw
KQ0KPiA+ICAJfQ0KPiA+DQo+ID4gIAlpZiAoIXBhZ2VfYWxpZ25lZCkgew0KPiA+IC0JCW1lbXNl
dChrYWRkciArIG9mZnNldCwgMCwgc2l6ZSk7DQo+ID4gKwkJaWYgKGlvbWFwLT5hZGRyICE9IHNy
Y21hcC0+YWRkcikNCj4gPiArCQkJZGF4X2lvbWFwX2Nvd19jb3B5KG9mZnNldCwgc2l6ZSwgUEFH
RV9TSVpFLCBzcmNtYXAsDQo+ID4gKwkJCQkJICAga2FkZHIsIHRydWUpOw0KPiA+ICsJCWVsc2UN
Cj4gPiArCQkJbWVtc2V0KGthZGRyICsgb2Zmc2V0LCAwLCBzaXplKTsNCj4gPiAgCQlkYXhfZmx1
c2goaW9tYXAtPmRheF9kZXYsIGthZGRyICsgb2Zmc2V0LCBzaXplKTsNCj4gPiAgCX0NCj4gPiAg
CWRheF9yZWFkX3VubG9jayhpZCk7DQo+ID4NCj4gDQo+IE1heWJlIHRoZSBhYm92ZSBjb3VsZCBi
ZSBzaW1wbGlmaWVkIHRvIHRoaXM/DQo+IA0KPiAJaWYgKHBhZ2VfYWxpZ25lZCkgew0KPiAJCXJj
ID0gZGF4X3plcm9fcGFnZV9yYW5nZShpb21hcC0+ZGF4X2RldiwgcGdvZmYsIDEpOw0KPiAJfSBl
bHNlIHsNCj4gCQlyYyA9IGRheF9kaXJlY3RfYWNjZXNzKGlvbWFwLT5kYXhfZGV2LCBwZ29mZiwg
MSwgJmthZGRyLCBOVUxMKTsNCg0KVGhpcyBsb29rcyBnb29kLiAgTmVlZCBhZGQgY2hlY2sgZm9y
IHJjIGhlcmUuDQoNCj4gCQlpZiAoaW9tYXAtPmFkZHIgIT0gc3JjbWFwLT5hZGRyKQ0KPiAJCQlk
YXhfaW9tYXBfY293X2NvcHkob2Zmc2V0LCBzaXplLCBQQUdFX1NJWkUsIHNyY21hcCwNCj4gCQkJ
CQkgICBrYWRkciwgdHJ1ZSk7DQo+IAkJZWxzZQ0KPiAJCQltZW1zZXQoa2FkZHIgKyBvZmZzZXQs
IDAsIHNpemUpOw0KPiAJCWRheF9mbHVzaChpb21hcC0+ZGF4X2Rldiwga2FkZHIgKyBvZmZzZXQs
IHNpemUpOw0KPiAJfQ0KPiANCj4gCWRheF9yZWFkX3VubG9jayhpZCk7DQo+IAlyZXR1cm4gcmMg
PCAwID8gcmMgOiBzaXplOw0KPiANCj4gT3RoZXIgdGhhbiB0aGF0IGxvb2tzIGdvb2QuDQo+IEZl
ZWwgZnJlZSB0byBhZGQuDQo+IFJldmlld2VkLWJ5OiBSaXRlc2ggSGFyamFuaSA8cml0ZXNoLmxp
c3RAZ21haWwuY29tPg0KPiANCg0KLS0NClRoYW5rcywNClJ1YW4gU2hpeWFuZy4NCg0K
