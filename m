Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99118584A6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Jul 2022 05:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbiG2D4i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jul 2022 23:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbiG2D4h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:56:37 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 28 Jul 2022 20:56:35 PDT
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3409867CA0;
        Thu, 28 Jul 2022 20:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659066997; x=1690602997;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JHMS9WFaJ7eAJlE5dTeU/dqqPoo04V4EEEfqJ/zXlUo=;
  b=pZp1XK5u1jTWtaP4TflcUiZ9+9rVIvNuPUDqyf/LCGQhXYD9tPJlCIvx
   f1fv+4GbmaVDEpnrlJ/+qkOA32r4WfGgt2oezFGBkJMnydBnpqQLvT6Yz
   b2IIPi+Khevf+eTpO7E0BODnkByUQAXWN4DqZbFjaHAQF0hXXjWuutt0C
   lz1PZiRGy4tZCK1MyStoxWCO4ja2pZDB2CsyRd4omKFvx0SJ15F6xsz+L
   QF7+3TB7T2qIFGpkbejtiNewyzrE5bKElCrHXdBip3JKyu7POLnjClyRp
   pDUB8RORlh6Bm/JDY4NXJLqJR0LS16CnuFUzjINUNDQD1qsOoiqhky5hH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="61503096"
X-IronPort-AV: E=Sophos;i="5.93,200,1654527600"; 
   d="scan'208";a="61503096"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:55:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNV3jUh3yDN5uqKQc3/afoCHLsl1KdueXjV13EhER9uOIL++i3c6COfLphWuolVPzqLuEGkumTlT//qU4ObMg9Qcb1qKiuckiULNoh3xgvmHMdRJ6uoCfOCvH67/2sJydUmmnnnXdjfVUuqov1/KXUvT3giYRil/bK+7uK9ST0c4c/pT/l3uG3+6lIwfL4sthRsBxNh6mhJvMpprX0YizyVJIMCny//VN5W0oXb1m4xNpofz6dTQwlO5Hof8YwgOutaq4anGCcbVgIkeu31mWXpBJcT+snt6L+6DSAM0oHbfEn+14mkzuaOya7h+83UXmdg3bCn/IYC/L/ARr2n7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JHMS9WFaJ7eAJlE5dTeU/dqqPoo04V4EEEfqJ/zXlUo=;
 b=Wxh7LmeqmKgZEA81BNBcrA0TSEyLdBPAxMKF0eTRJ/cs5vpZ0sXlS4ivn2fZ6V73/GA1eJUhlQ8f0x0TgevRciZSgmfP0osCw4AZZBWbyDT0o5Q5t+EXogZJzkKhJxiQBT1zJuD2Cwnvw5aH9hCtMeHUniBhF0MABpZtSkl/pgsdAciD01psaJXisTJb9ARRjQLGhxAbj2yTpfbAPi1fU7cqL96vZfeI1gqoKiRtxTuCC30yInNQ1o/Wa1PgAFQqfRi8Hr2WUR1zC1oyq7/znZCQcyPs2NeeFtIsLoo1TRjACufWy+z1U6GVyf1R4QjcZ4UwkpvtDVNl8UGGbOYoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by TYAPR01MB6345.jpnprd01.prod.outlook.com (2603:1096:400:a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Fri, 29 Jul
 2022 03:55:25 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca%7]) with mapi id 15.20.5482.010; Fri, 29 Jul 2022
 03:55:24 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Topic: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Index: AQHYfA4g5aj+ViA5o0mdS5cU960Zpq1oy6eAgCBSEICAACSLAIALwwSA
Date:   Fri, 29 Jul 2022 03:55:24 +0000
Message-ID: <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
In-Reply-To: <Ytl7yJJL1fdC006S@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-07-29T03:55:24.282Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 528662fc-9a18-46b4-ae22-08da71162adf
x-ms-traffictypediagnostic: TYAPR01MB6345:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RhVZReBzLDcwnkzP+h+d1SEhP+43zpL4ZAjcOaSS+OrkNUlqeSgsIEF3JXT4xdCXQqP5a2k0guom7Jjeq0U4ow+u0xouWCIqxHei8NQHnP7dmfef94SajJjA6BTORTsXeTJ4cSIPvSZCVEOiKUzbcn0tw7uYUlNstWzFYsVQ5oNjCkSfhAJNv32AhuygANjaMgEeaGl1lQCzOEVurZx8doUqf9wyTi3SVkxnBlG1S+PSDl5DSabqaWS5j1woocHVF/kYoNtFr6bH2RmbtyIPQGu28GeX5cvd6KnXtIc+OO7kwn08aJ52VqDBLdP26BqFwcjIljmwDTdgiduJ5hc/Z9MJeJzOUdR3P5Ngksh0q9cCnoNsHiP8oG31kkOoFaT4AH9X67S9DFnr2O0XYlHaQPzb3axgzmOOPCBIcLpTLOdQbadOXtS+RIWDSTb658zYuuqkTtkwBH/OKJ2CDPxNlHYnRAaCpTzPWKxKRsTfzXzbMg4oWGygYCXMZ8o0BhHJLCqP0yaKaSuFsx7VC/ScN9MKQuTfUlTt9/Bj8ng6FqcD//4CcErV0oJDR2AYcJwedMff/MMXWIahOMqdk2FGjQytxkjU3uR3p1uVvWLgsQS0gI1JICobiHZ6zCgCgxmSOCd8Itnp1/diufkQKn8y3Dz8yCnYC7bFJ8aidJLN8ebObVTXu86U5DUNaeTeSQ46YmSrbpoCAwXBaXlLQs8p6yrSeUtNSNIcguLmXHmwk33IKSJn++WNRhJrNXVryKmbsxOYfrnfOWggl/RAlbn2juAMI/flYdQIUvtD8niQeGlkXU9yxEpc2/z41iocqdVH332yOUgCFU5N7L0tUYvXiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(366004)(346002)(136003)(6916009)(71200400001)(478600001)(31696002)(122000001)(38100700002)(6486002)(26005)(41300700001)(6506007)(6512007)(82960400001)(2616005)(66946007)(186003)(83380400001)(2906002)(31686004)(85182001)(76116006)(5660300002)(8936002)(8676002)(66446008)(4326008)(316002)(91956017)(54906003)(38070700005)(66556008)(66476007)(64756008)(36756003)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?bW5jY05rQmdVdkYvTmRmcVcveU8vd0lLOE1xa253cThjbXcxcjlXTWgzR2xP?=
 =?gb2312?B?YVJaeEYwK040L2o2bXF5a0VRWlhDWENUemVVUklMY1pqVndFMkszOWQzS1lk?=
 =?gb2312?B?UGxRamI2L0pFY2x0L1gyTDlIUGlha3d3UWJnQTRCSVV3STI0WUJYemQvWlZ6?=
 =?gb2312?B?ckxhdFA2a29MS01oc1ZreUtZQWRmb3psaERwVGJpa09rQlBNdWoyVTh2VzZR?=
 =?gb2312?B?UnBWb2tCdk1tMTRaT3k4dUNQUmVZUGtjVjNUOUJPUmZaVkVlMVExMmN4bVZv?=
 =?gb2312?B?aDBicXc3ODVBejRvZkUveWY4RjVwM0M0L2duZkhOTE05TWxKT25TYmJubUd1?=
 =?gb2312?B?a2FYVldzYXhBSlp1eDluY28rZGtZUFgrYTJEc3dWbnhWNmc4cC8rVXFIMis4?=
 =?gb2312?B?WGsyUU43NEdDSEo4UmpXUi9zMzJjdVFOcE9lRVBwQVpYRHBJV0Exa2lEM3RG?=
 =?gb2312?B?L0NpRzd5UGtjTFBwTnBqcTE4Q1BMZEtkMDVqclpLNy9oM2hHVXhobzQzUlo5?=
 =?gb2312?B?ZDFyMXdERmFwVnlnRGtVVDVQVndrekpmVTI5R28zMmNFdVdXK2FVOExBS281?=
 =?gb2312?B?Ymloams0UFRnSGVkZnVGcmdJZkw4NzRTUzJjWVgzV2tFOG8vS0NuczR2Ulcx?=
 =?gb2312?B?azIvdUVOSi9IMnBSOGJqVUo1SE52cklUNEpaSk8zMEJOU1IvTjVpVkhxcENP?=
 =?gb2312?B?ak9TRjA5UmYrYzhidWlyaEFKS1JnVXV6U3daS2kxeEF0aStkNm1vRWFwSng1?=
 =?gb2312?B?eUgwdGJWa3llTkNOWGxrSHZ4R29iSUZINzZTSWhCZWVjWFAraTFZREExcm5Y?=
 =?gb2312?B?enRyM1ZVc2kwbFJVR0JsL0g4R3Mvc2ZNZUJsNmdPTGUyc3hnb0VjcGxuQkVC?=
 =?gb2312?B?L3oxdi8xYmhFWWZoMEJIbnhtVTZCdUdwbEU4S1BkY3ZkRkF0VjQ2NXRNY3Y0?=
 =?gb2312?B?Z05zaGRGWS9paGRMNmRwZ1hGaVhWUCs1RTFZVUFJeWdudE9ma29UcElnT3Iw?=
 =?gb2312?B?MDltVUdncjVQdk1wbWlCY21mRkkzM2FPdU1GNCtrRElMRzkwOFAyREdTdFhB?=
 =?gb2312?B?V2syNGRhbkFQOFdWNCt2b3daQ29xREd5ZE1Lc1VkRFZVUStkQUwydnAyRHNO?=
 =?gb2312?B?VmN4VGtIb3I0VU8yeFlNUEUrVVg5U0xLc3JRK09ncHRkWXBmRlpvMm5YRzBj?=
 =?gb2312?B?cENzTkpQM0NMR2dhTG9uY014V0FsL3ZFSldpblBxdyt5d0dZU1ZKZ05tSktH?=
 =?gb2312?B?a1JZNmEwRHdoYXVHZC83ZFNQSDEySzd5TUoxSWpqOGY1YzlrYTJwNHBqdVJT?=
 =?gb2312?B?VytucUlyNDVPMXBNTTNEUDFROGJkRDVzbkUwUk5zSWhWdFN6Y094VW5JSTI3?=
 =?gb2312?B?QkU1bEMvS2ZRUFF4ai9KK3loQ2U2SWN4TTdmcitLS3l0WjhGa1kwTExHZ0pz?=
 =?gb2312?B?SEFoaGZjOERPWU90aTUzeDJXUHRsS1NBUzFBY2ZLZk16T2NtY2wwN2dDWWNN?=
 =?gb2312?B?a1lHMCtSTEJ5NHZJakdOZ0RTS0xnTjBJbFExT0ZkcVJkT0FVMWlMS2s5YzRn?=
 =?gb2312?B?QlVGeWdnTW1lc2pmYTMzakozZ0hERGh5Y05vOENnaWhNSExyNklDMXV1UGgx?=
 =?gb2312?B?b3NjNzJva09iQjV6K3cwVmNkQ2toWVlVMTFDMmViOUdNa2FMYWIrTTkrdmgw?=
 =?gb2312?B?OGl4MXIwcFU2QzRDK1VIeTZ0bnF3Vm51NUtXbFhPT2FOUkJJOFhXSHA0cmps?=
 =?gb2312?B?N0xkd012UlhSVmxMUFhuR0cyZVRtN0NJbVU5WmlpcVZSczdCa3RmMWp6Z1o3?=
 =?gb2312?B?dE9GK3NtM2hoM1FlclhGS2RvczIwZzFFcUdsY0ZwNFowMGhoK3J1elRFMW8z?=
 =?gb2312?B?TUh5QlA4NHNTZCtrMkR2eW1Ec2VNT2dMSTFnaWZxU2I5Q0xMYU56SWl1TlFD?=
 =?gb2312?B?YkRvaHVPb0ZjL011dlFOTTdPcmxobzhndzJscTNvWmxIQmp1aHQrbFhoRERh?=
 =?gb2312?B?RDBmSWt1U2plVXVYTUVjeWFTWGo5Y2RBK0pvNGlZVjNrSzBxNjI4R1ZQWVhJ?=
 =?gb2312?B?M2RyTS82QzA3SzVFL1QzeU8wR1NzNjdvZ1pmSTQxY0w1b3ZXUDBNRjc5eURN?=
 =?gb2312?Q?vYPM8f0a3mjxHuWuUf5H2mory?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <EA32E426B0D18846B26A9448199BA063@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528662fc-9a18-46b4-ae22-08da71162adf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2022 03:55:24.8242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RctUARQ7Y09ZOWZLUDdoY3dsUYSqX3XFijq2USSGaXzig/qTvkD2Thho/MyoXD/GTbX7cziM16aY89/VIEIplQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6345
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CgrU2iAyMDIyLzcvMjIgMDoxNiwgRGFycmljayBKLiBXb25nINC0tcA6Cj4gT24gVGh1LCBKdWwg
MjEsIDIwMjIgYXQgMDI6MDY6MTBQTSArMDAwMCwgcnVhbnN5LmZuc3RAZnVqaXRzdS5jb20gd3Jv
dGU6Cj4+INTaIDIwMjIvNy8xIDg6MzEsIERhcnJpY2sgSi4gV29uZyDQtLXAOgo+Pj4gT24gVGh1
LCBKdW4gMDksIDIwMjIgYXQgMTA6MzQ6MzVQTSArMDgwMCwgU2hpeWFuZyBSdWFuIHdyb3RlOgo+
Pj4+IEZhaWx1cmUgbm90aWZpY2F0aW9uIGlzIG5vdCBzdXBwb3J0ZWQgb24gcGFydGl0aW9ucy4g
IFNvLCB3aGVuIHdlIG1vdW50Cj4+Pj4gYSByZWZsaW5rIGVuYWJsZWQgeGZzIG9uIGEgcGFydGl0
aW9uIHdpdGggZGF4IG9wdGlvbiwgbGV0IGl0IGZhaWwgd2l0aAo+Pj4+IC1FSU5WQUwgY29kZS4K
Pj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IFNoaXlhbmcgUnVhbiA8cnVhbnN5LmZuc3RAZnVqaXRz
dS5jb20+Cj4+Pgo+Pj4gTG9va3MgZ29vZCB0byBtZSwgdGhvdWdoIEkgdGhpbmsgdGhpcyBwYXRj
aCBhcHBsaWVzIHRvIC4uLiB3aGVyZXZlciBhbGwKPj4+IHRob3NlIHJtYXArcmVmbGluaytkYXgg
cGF0Y2hlcyB3ZW50LiAgSSB0aGluayB0aGF0J3MgYWtwbSdzIHRyZWUsIHJpZ2h0Pwo+Pj4KPj4+
IElkZWFsbHkgdGhpcyB3b3VsZCBnbyBpbiB0aHJvdWdoIHRoZXJlIHRvIGtlZXAgdGhlIHBpZWNl
cyB0b2dldGhlciwgYnV0Cj4+PiBJIGRvbid0IG1pbmQgdG9zc2luZyB0aGlzIGluIGF0IHRoZSBl
bmQgb2YgdGhlIDUuMjAgbWVyZ2Ugd2luZG93IGlmIGFrcG0KPj4+IGlzIHVud2lsbGluZy4KPj4K
Pj4gQlRXLCBzaW5jZSB0aGVzZSBwYXRjaGVzIChkYXgmcmVmbGluayZybWFwICsgVEhJUyArIHBt
ZW0tdW5iaW5kKSBhcmUKPj4gd2FpdGluZyB0byBiZSBtZXJnZWQsIGlzIGl0IHRpbWUgdG8gdGhp
bmsgYWJvdXQgInJlbW92aW5nIHRoZQo+PiBleHBlcmltZW50YWwgdGFnIiBhZ2Fpbj8gIDopCj4g
Cj4gSXQncyBwcm9iYWJseSB0aW1lIHRvIHRha2UgdXAgdGhhdCBxdWVzdGlvbiBhZ2Fpbi4KPiAK
PiBZZXN0ZXJkYXkgSSB0cmllZCBydW5uaW5nIGdlbmVyaWMvNDcwIChha2EgdGhlIE1BUF9TWU5D
IHRlc3QpIGFuZCBpdAo+IGRpZG4ndCBzdWNjZWVkIGJlY2F1c2UgaXQgc2V0cyB1cCBkbWxvZ3dy
aXRlcyBhdG9wIGRtdGhpbnAgYXRvcCBwbWVtLAo+IGFuZCBhdCBsZWFzdCBvbmUgb2YgdGhvc2Ug
ZG0gbGF5ZXJzIG5vIGxvbmdlciBhbGxvd3MgZnNkYXggcGFzcy10aHJvdWdoLAo+IHNvIFhGUyBz
aWxlbnRseSB0dXJuZWQgbW91bnQgLW8gZGF4IGludG8gLW8gZGF4PW5ldmVyLiA6KAoKSGkgRGFy
cmljaywKCkkgdHJpZWQgZ2VuZXJpYy80NzAgYnV0IGl0IGRpZG4ndCBydW46CiAgIFtub3QgcnVu
XSBDYW5ub3QgdXNlIHRoaW4tcG9vbCBkZXZpY2VzIG9uIERBWCBjYXBhYmxlIGJsb2NrIGRldmlj
ZXMuCgpEaWQgeW91IG1vZGlmeSB0aGUgX3JlcXVpcmVfZG1fdGFyZ2V0KCkgaW4gY29tbW9uL3Jj
PyAgSSBhZGRlZCB0aGluLXBvb2wgCnRvIG5vdCB0byBjaGVjayBkYXggY2FwYWJpbGl0eToKCiAg
ICAgICAgIGNhc2UgJHRhcmdldCBpbgogICAgICAgICBzdHJpcGV8bGluZWFyfGxvZy13cml0ZXN8
dGhpbi1wb29sKSAgIyBhZGQgdGhpbi1wb29sIGhlcmUKICAgICAgICAgICAgICAgICA7OwoKdGhl
biB0aGUgY2FzZSBmaW5hbGx5IHJhbiBhbmQgaXQgc2lsZW50bHkgdHVybmVkIG9mZiBkYXggYXMg
eW91IHNhaWQuCgpBcmUgdGhlIHN0ZXBzIGZvciByZXByb2R1Y3Rpb24gY29ycmVjdD8gSWYgc28s
IEkgd2lsbCBjb250aW51ZSB0byAKaW52ZXN0aWdhdGUgdGhpcyBwcm9ibGVtLgoKCi0tClRoYW5r
cywKUnVhbi4KCgoKPiAKPiBJJ20gbm90IHN1cmUgaG93IHRvIGZpeCB0aGF0Li4uCj4gCj4gLS1E
Cj4gCj4+Cj4+IC0tCj4+IFRoYW5rcywKPj4gUnVhbi4KPj4KPj4+Cj4+PiBSZXZpZXdlZC1ieTog
RGFycmljayBKLiBXb25nIDxkandvbmdAa2VybmVsLm9yZz4KPj4+Cj4+PiAtLUQKPj4+Cj4+Pj4g
LS0tCj4+Pj4gICAgZnMveGZzL3hmc19zdXBlci5jIHwgNiArKysrLS0KPj4+PiAgICAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj4gZGlmZiAt
LWdpdCBhL2ZzL3hmcy94ZnNfc3VwZXIuYyBiL2ZzL3hmcy94ZnNfc3VwZXIuYwo+Pj4+IGluZGV4
IDg0OTVlZjA3NmZmYy4uYTNjMjIxODQxZmE2IDEwMDY0NAo+Pj4+IC0tLSBhL2ZzL3hmcy94ZnNf
c3VwZXIuYwo+Pj4+ICsrKyBiL2ZzL3hmcy94ZnNfc3VwZXIuYwo+Pj4+IEBAIC0zNDgsOCArMzQ4
LDEwIEBAIHhmc19zZXR1cF9kYXhfYWx3YXlzKAo+Pj4+ICAgIAkJZ290byBkaXNhYmxlX2RheDsK
Pj4+PiAgICAJfQo+Pj4+ICAgIAo+Pj4+IC0JaWYgKHhmc19oYXNfcmVmbGluayhtcCkpIHsKPj4+
PiAtCQl4ZnNfYWxlcnQobXAsICJEQVggYW5kIHJlZmxpbmsgY2Fubm90IGJlIHVzZWQgdG9nZXRo
ZXIhIik7Cj4+Pj4gKwlpZiAoeGZzX2hhc19yZWZsaW5rKG1wKSAmJgo+Pj4+ICsJICAgIGJkZXZf
aXNfcGFydGl0aW9uKG1wLT5tX2RkZXZfdGFyZ3AtPmJ0X2JkZXYpKSB7Cj4+Pj4gKwkJeGZzX2Fs
ZXJ0KG1wLAo+Pj4+ICsJCQkiREFYIGFuZCByZWZsaW5rIGNhbm5vdCB3b3JrIHdpdGggbXVsdGkt
cGFydGl0aW9ucyEiKTsKPj4+PiAgICAJCXJldHVybiAtRUlOVkFMOwo+Pj4+ICAgIAl9Cj4+Pj4g
ICAgCj4+Pj4gLS0gCj4+Pj4gMi4zNi4xCj4+Pj4KPj4+Pgo+Pj4+Cg==
