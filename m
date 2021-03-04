Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFFFF32CA29
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 02:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhCDBp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 20:45:56 -0500
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:23554 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235085AbhCDBpu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 20:45:50 -0500
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 20:45:49 EST
IronPort-SDR: BQtHiU4AOJIr7GeJAAYCTDbGw9rqdsvCP5GIvwYnUl2Bb0uo8HriH2OBWHh67DhbVbnCWpp+dZ
 nlpB2AHEXJC1UTxVPsGqap9xtu02F9FvfOPeyiz/Nrl7XSgypHK7FZIbZ/pMWOk3+MHFxlH2Ao
 wAXL+Iu3b2CsAZMS4HUMaHA5an7us2DjxmlZwkctD73EEaogZomHkvWPlImc0EPlRwJjylAu73
 UJYecVD/DU5YjX/YZJQM5DQHCmymFh/EExd0VrTsxhXKZiukTLHT9SMj/MqKLD7z2k3FMjI0zs
 78A=
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="27265699"
X-IronPort-AV: E=Sophos;i="5.81,221,1610377200"; 
   d="scan'208";a="27265699"
Received: from mail-ty1jpn01lp2056.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.56])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 10:35:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9ZO1Xy8IZUhetjtsoJmmTlBNTBLA1MzXEeLLobL13xBcPSAorTFuZuGkCZ+h974kUrqFRu5HuiJqQviP2yilFGMeSnMhQAJ5DMYhQQ55SB0vQbVUg70yZiGb/er/7u485EgSnCW+cCqthJJsUO9/gMyIfvPm1p0dRmtzASJpPKfL45aC2uBPwWfN4BSLP9wJb8vhApx/YfbzaWdOejYzGGpDJft2zxjiwswP/dI3adO4qx9EhR8ypOVMXUJ+dwojI/CGJQhflyZEwBkZz5hIOcauGA9Ovm3uxn8xOF+1OlVwG1nvvBvyNi8GBT5WuwApo1WUN6sWsyMbJVZsDBeMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIL2Dr2YdSTWXskDM/fOA2riQ14xz+EbLhIn02JrwuE=;
 b=UndqhMGIYxoYvZ2eUk+c8OfQZBDiPj8YeLV4eULnQkrnOwCENWt1iuGGfO1zfirm4MjAoRqtf9XRopDShu8LHF5JMslY+F/3sjzvX/uQ8HqTOFydFv0XqfzGaXzrXHvqvw4+1sszh11WUey8k+Xtd5wfsjMIwTVzi12LS3GBAdgyOICmZaZWx/WFYhYLWSIfazAr5ttZtXKvzyt/k+qfbkJyUU0u7UAUMDE2OjhEsr2NjZH9Ctwml4VxHS+RZxer9mONfxxnXq3fkpZ4b0pQViA4Gw3XlwBgjkm8urtUYbQTDW9Uf3iAww6Yr7eHRMaNohFMjQ67J06J1tvMBVnJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIL2Dr2YdSTWXskDM/fOA2riQ14xz+EbLhIn02JrwuE=;
 b=M+8G2rG9hrn7b/usa4Yjsp5cR1pZQxkGLN4590n8+toG4v3XlHdqWHTLlqDrsQPUF9gR9uy+YpTWiqGFFQQXY0QfVj+GjaIQ9sFZHsHEenvoYIxbFqqLYBNgdTlcMZ4So0GqNzXmOZxI4wybMI0Nf8EXT76WirTRYUEo8GKyesg=
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com (2603:1096:603:3f::16)
 by OSBPR01MB5223.jpnprd01.prod.outlook.com (2603:1096:604:7f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 01:35:46 +0000
Received: from OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::c447:a3af:7d9:f846]) by OSAPR01MB2913.jpnprd01.prod.outlook.com
 ([fe80::c447:a3af:7d9:f846%3]) with mapi id 15.20.3890.029; Thu, 4 Mar 2021
 01:35:46 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Christoph Hellwig <hch@lst.de>
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
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: Re: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Thread-Topic: [PATCH v2 09/10] fs/xfs: Handle CoW for fsdax write() path
Thread-Index: AQHXC9Vk3oCFfiQYI0S5UeFuOjPnZ6pyC5KAgAABpsWAAA89AIAA9U0O
Date:   Thu, 4 Mar 2021 01:35:45 +0000
Message-ID: <OSAPR01MB29138D275A7375EF6BA52E0FF4979@OSAPR01MB2913.jpnprd01.prod.outlook.com>
References: <20210226002030.653855-1-ruansy.fnst@fujitsu.com>
 <OSBPR01MB2920500BEA2DF0D47885A8FDF4989@OSBPR01MB2920.jpnprd01.prod.outlook.com>,<20210303104336.GA20371@lst.de>
In-Reply-To: <20210303104336.GA20371@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [49.74.161.241]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5edba1ac-f314-4c52-2569-08d8deadd534
x-ms-traffictypediagnostic: OSBPR01MB5223:
x-microsoft-antispam-prvs: <OSBPR01MB5223CE37A3F18AE517F0CCE1F4979@OSBPR01MB5223.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: feMXUbB3X5SGfAZvFxhtx3Y9cA7OobVdaGt5yo47BbUfN6hsmnq+HN/5xy2NwHKehbIh/w/6HoT0liL6uAR0bPLYy2aHzCtJU2xViU3dL7vR07FdwgDQgWHyYKR4oJclG58kZpoBaptZVFGsDL4zWYUJbWW2KjBEI+fQabb22/tdfDf2vXEz/j/EYrUCoQUYABuOIH9R9166abiTxcwiC8DXM7neK9AxKAtqzWKuBY8QPthWMUwfbjglSxj/L4+EmUHs+6tEpGd1Bu8dFYjQ+u78trX8AHC4OslAuQhJGi7gbEgZoUkXsiKElCWoPi3FNpBkVSDAcye8A6FwEfTY3ufEf9XaNVr2OIpY/4pgHi1vj9B5QIGEJnjtmfyPF1iDHHLHR/3QOCnTIdpPGLhnIR2KxBHY1c8I27OTJ5VEepLT56b0NHQOGFBc/DVIUGZFr9nPuGfL2EucIJg86+ff+HEzi5RIOmqZKl7ck/qtkaPdPP2zHzOksZlynzmS2DtLFCI/Bv14AMgqx6xMNLkukw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB2913.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(366004)(8936002)(5660300002)(66446008)(52536014)(8676002)(71200400001)(66556008)(7696005)(6506007)(55016002)(478600001)(33656002)(186003)(4744005)(26005)(6916009)(7416002)(86362001)(54906003)(85182001)(64756008)(316002)(76116006)(2906002)(66946007)(9686003)(66476007)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?ZWVUckI5cDA0cTFwSFNVSmxSSWtQOVduMFJGZ2h0elJ6ZFUwY3kraDY1Wjh5?=
 =?gb2312?B?cFFBYWFOSm9scFpSQXA5bGt5cFFDQ1V4RmFQWDNnQ09ManhNZXdIeXRySmwy?=
 =?gb2312?B?dWV0OGVreVBLZ3BQU3RraFR4SllOSVRxSFo4VFdLSUpnVCtlYWw3UFF0Y25z?=
 =?gb2312?B?T2VlQ0JjZjJLaEp2dUxRaDQxVW9FNmhobnNGWWk0cGlhNTFLR0cvVzRRRk50?=
 =?gb2312?B?RXlXNVVKYVlmQzg1LzN5WWVYblJBUDZEZWRPTjFRZ054d3VzZlZMV05DNU5o?=
 =?gb2312?B?Y0p2REVLQkhEZHF3aElxcUoxZmxoZ1hzbzJGc3JvcjVTbkYrK09HRmI2dVBV?=
 =?gb2312?B?SkxpSDlZOFh5emR2NlNLby9nZXA0UlpsT2NoVm0yNTVNN24rY2xBMm9IZk1o?=
 =?gb2312?B?S3FuMkZ0M3k2UG0xSjRaaHQ3ZW9rUkE4UElIaVVYQkJaeU5nY3NSWkkzQ2pH?=
 =?gb2312?B?UDNPYkVuUzAzMmJaWlVidlR0MVhpUHZqclQrcE1ZZ2NNRU5KR2RvZ1A3cHNM?=
 =?gb2312?B?NjY4cnhOQU9mZFJrVzI4VkZWNmlLc2trOHNvVlRYMjhkaTUzczI3TnRwTGNr?=
 =?gb2312?B?NHF4S1B3SENwWTh5SVRtSVZOSGVQSzZmUEtyQkxvZTd0eGk5czdjNUdRUXJw?=
 =?gb2312?B?NzhNVnVvNVlrSFJ6MFQ0L1BVMmJ2VGpPSlhNRjR3RHdWZFpEYk5MR3ZudUla?=
 =?gb2312?B?eG1MOW5rdGRtUTlqYUs2YUNBTmJwQUM1cldKSHBzbnlCd3h6d3pkMk9ZUWZE?=
 =?gb2312?B?WUx3azdYZ0M0UkIveWRjWUFHOWhXYlVLd2tWZUhaRGlTdy9qVUo4VGNVQnlp?=
 =?gb2312?B?MFJWY2dVS3h4MWZaNThVNVRSbDVTVElSekp3MFVrK01vMjhGbUh6U1dOREly?=
 =?gb2312?B?S2JQNU1IU1R4ZkxJY3FGSGdmNzJDMllabU40dzJsYlYvZWFQWlYvUVpKZUtu?=
 =?gb2312?B?Vlc1TDBSaS9vVkFOM09IYWhYTjdRZXZPUTJRSDRiTS96dnFWT3JLWXMwOU1s?=
 =?gb2312?B?VVRheDdjS25CR0lWWVRubEpHM2VwVWNVUC9vekxGa2k2QkJJZE44M3VXVHAz?=
 =?gb2312?B?SUhMMkhTYWFjOEVnMHRtZFBwNStnSC9pRDVnTmF1WEk5WEVPTHRhbkdtWlNl?=
 =?gb2312?B?cWp3eHpuaDJUbVdtbm5LVW9uMXRKQ1dzdFZRSU9QWnpNcWVia0pkS2c5bzNz?=
 =?gb2312?B?SDJZeWFXT3NiNDZVSDkyNGdldlY0V2JvZGxQcUFaUnhMYlQrVjVuc3kzN2g4?=
 =?gb2312?B?Tm90SHNZd1BsVVZyR2tDTzF2Ni9UY291SDIxN0NhdWl6WnB4c0NDdVNYcXFN?=
 =?gb2312?B?am4vTjZFNmhNaWFRN1BYWDRGSytoRjl4RDFaWlJFZHl3b3g5NkpUeGVMMEtH?=
 =?gb2312?B?ekRqU1lVcnJlMThyMFNsQ0crWlhYaGpxQndLSnhuaTZCWUsyb3FGVzlQRFVH?=
 =?gb2312?B?cXB2bDlSVVhEOE13MVloVUwzZ3VqNW4zOVgvVnF4YlpEMnJRYWZ2ZGE0WkZn?=
 =?gb2312?B?aUxvVE5VanhjWnBTNDhwMmNYN3lja1FDeU0ybjE0cG1CRXpSay9WZzd0cFRm?=
 =?gb2312?B?bTJQZ2JsVzVyUlRBZHRweWJoNWxKUTZFZGFxVDVOdGRXQ291OFNZSmduay9h?=
 =?gb2312?B?dlorTnBBbHVuZjZxME4waTdqRHA2cldrZVZFOWNGaFdHVk9Ec0w1ZWhrMVkw?=
 =?gb2312?B?RFRZVzhySEtuOHdFM2VyTHRuWGJWR3ZUd0ZoOCtrZFlHWkJmQmZUSk9XdGpt?=
 =?gb2312?Q?GrVoJT06xDUFYJH1OY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB2913.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5edba1ac-f314-4c52-2569-08d8deadd534
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 01:35:45.9588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIyjeACilrpZm3yU52qPFQwUXfSG59mZAxRsT8b3hbGQEShYeA1se1S2koUJKKjsIQlMtucbrZhq8iHu+3YJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB5223
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBPbiBXZWQsIE1hciAwMywgMjAyMSBhdCAwOTo1Nzo0OEFNICswMDAwLCBydWFuc3kuZm5zdEBm
dWppdHN1LmNvbSB3cm90ZToKPiA+ID4gV2hhdCBpcyB0aGUgYWR2YW50YWdlIG9mIHRoZSBpb2Vt
YXBfZW5kIGhhbmRsZXIgaGVyZT8gIEl0IGFkZHMgYW5vdGhlcgo+ID4gPiBpbmRpcmVjdCBmdW50
aW9uIGNhbGwgdG8gdGhlIGZhc3QgcGF0aCwgc28gaWYgd2UgY2FuIGF2b2lkIGl0LCBJJ2QKPiA+
ID4gcmF0aGVyIGRvIHRoYXQuCj4gPgo+ID4gVGhlc2UgY29kZSB3ZXJlIGluIHhmc19maWxlX2Rh
eF93cml0ZSgpLiAgSSBtb3ZlZCB0aGVtIGludG8gdGhlIGlvbWFwX2VuZAo+ID4gYmVjYXVzZSB0
aGUgbW1hcGVkIENvVyBuZWVkIHRoaXMuCj4gPgo+ID4gSSBrbm93IHRoaXMgaXMgbm90IHNvIGdv
b2QsIGJ1dCBJIGNvdWxkIG5vdCBmaW5kIGFub3RoZXIgYmV0dGVyIHdheS4gRG8geW91Cj4gPiBo
YXZlIGFueSBpZGVhcz8KPiBtbWFwZWQgY29weSBpcyB0aGUgY29weV9lZGdlIGNhc2U/ICBNYXli
ZSBqdXN0IHVzZSBkaWZmZXJlbnQgaW9tYXBfb3BzIGZvcgo+IHRoYXQgY2FzZSB2cyBwbGFpbiB3
cml0ZT8KCk5vLCBJIG1lYW4gbW1hcGVkIENvVyBuZWVkIGEgeGZzX3JlZmxpbmtfZW5kX2Nvdygp
IHRvIG1ha2Ugc3VyZSB0aGUgbmV3IGV4dGVudAp3aWxsIGJlIGNvcnJlY3RseSByZW1hcGVkIHRv
IHRoZSBmaWxlLiAgT3RoZXJ3aXNlLCB0aGUgZmlsZSB3aWxsIHN0aWxsIHJlZmVyIHRvCnRoZSBl
eHRlbnQgdGhhdCBzcmNtYXAgcG9pbnQgdG8uCgpXZSBhcmUgYWJsZSB0byBjYWxsIHRoaXMgaW4g
eGZzX2ZpbGVfZGF4X3dyaXRlKCksIGJ1dCBjYW5ub3QgY2FsbCBpdCBhbnl3aGVyZQpleGNlcHQg
aW9tYXBfZW5kIGluIG1tYXAgcGF0aC4KCgotLQpUaGFua3MsClJ1YW4gU2hpeWFuZy4=
