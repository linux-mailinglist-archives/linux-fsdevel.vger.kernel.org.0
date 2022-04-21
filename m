Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6743F509487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383574AbiDUBOz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 21:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiDUBOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 21:14:54 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB14013CFA;
        Wed, 20 Apr 2022 18:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650503525; x=1682039525;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mS0PvV3F8cqET1Pnkz4aMpPTuSfNRYjXA8QwHLJ/Pa4=;
  b=s4lGoynzvnRNIsMe7uRjprVNTHS1I82dQg2KUJe5YYsCXdi5TZNQV5ZG
   r7pHNs83DSapJjwr1AJPuYX0jy/acCoaJ9WFQeXYqdl+YSGJnPoq6JNHZ
   XIm9RiH2b28zEJbwpQy3vMgXyKDykYox47vdXj9mxRA8Tt3h7frm6+Sln
   fEHffk/YsXhMoV3KiDRd7sStEJqwoVGQTtTHvOPSNzfmasJNpegf9rj+d
   Hj/GoJuvPN46DasvNA9i0p8TJmGzrvWW+8rysa0Idwiy9te2UPQJOwrub
   jAeRp6z7MlNj6CD9+K1dfx7RPjZGHHh71xe1ma7cVaTi/Vtxfa2m60RVJ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="54356804"
X-IronPort-AV: E=Sophos;i="5.90,277,1643641200"; 
   d="scan'208";a="54356804"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 10:12:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjKJ0RUoilwZRUFLBSo5MiEHvciLQpmwE7kD42g329sagixF3zPdhTgBT+S7tUrCEarLNfblgarnW7pv0Yu26yt8ncr52UJVc/o7FvthlZRR8gi1UzP8VIPsDRcZSYMQZKnmFNNc7b4UG4r4XaHmld4126ysDzMYkGFek6KEGBCId/W6ox5XYt7S4gypfRfKbWUmVLl0w/dQYwi2t6d2Ao9kdCGU+3BWERPjgCwE/CKLn6Zda/1evksut26dmBL+vvH+fkqEJbMyb5r1I+1k19hzONnsG4No0rblE6rkJod+nepagnHDJg2RNAXef9jLrJq2TczSSAVxhvCfWW9tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS0PvV3F8cqET1Pnkz4aMpPTuSfNRYjXA8QwHLJ/Pa4=;
 b=ds7GFgUOVwABkrwkaZSjlwrDhKSck+ixQoxuJmf9ul0eQ6GwBb+LawlWS9+KztmUi8IPZPyupeD+RVA7zrGuPZIBlGGDjoJE0QRYc0ZdEfXIjqgOl7bcWnzvCVp3rNWW/zJIikUIL2EDQHH7f8somAOmqDn0K4uS+f0XLd1xGdX1U1zhqgN6DwQovShHawJGAgZfM33OmW1rr2sYOEWnHhoCgMNJxGwYVhHdmurEoYEmIusCi17jMxPbF7F2lSw0QgYscIg8fcseRHAIyHAid+TVmz+U3JjzpQhW8lQyLZZgh7yGz/iasUE8sWvddKsFAaEzAANcuqEepyEJYUcgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS0PvV3F8cqET1Pnkz4aMpPTuSfNRYjXA8QwHLJ/Pa4=;
 b=kblL3avbz16lV6En4rcAU2m0X4TAwn01Xk1rdOc3tdXjXgCvkwkyCaHDNdJMeElhYKRrNq2z6V2SqU7pTJVPoxbL9GsYJW7cv6fCmtFsTnepM+vETw1jfMFxru5JZWbAKruAKta76niNhROumhYGLx2QkbuogyqUw/c4dBXZQL4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TY3PR01MB10060.jpnprd01.prod.outlook.com (2603:1096:400:1df::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Thu, 21 Apr
 2022 01:11:57 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 01:11:57 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "ntfs3@lists.linux.dev" <ntfs3@lists.linux.dev>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
Subject: Re: [PATCH v4 1/8] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Topic: [PATCH v4 1/8] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Thread-Index: AQHYU9rGMcoXoXAhFUC0+s6Sqe+NAqz3RT4AgADPzgCAAUU2AIAASLwA
Date:   Thu, 21 Apr 2022 01:11:57 +0000
Message-ID: <6260BDB8.3020001@fujitsu.com>
References: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220419140508.b6c4uit3u5hmdql4@wittgenstein> <625F6FE6.4010305@fujitsu.com>
 <20220420215252.GO1544202@dread.disaster.area>
In-Reply-To: <20220420215252.GO1544202@dread.disaster.area>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b106fc63-0dd4-41f5-804d-08da2333ee23
x-ms-traffictypediagnostic: TY3PR01MB10060:EE_
x-microsoft-antispam-prvs: <TY3PR01MB10060303458DBC5072B163B1CFDF49@TY3PR01MB10060.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HK5vpFVvybv3nKj/C1u2xGCP6sc4TDAU/GaZgnE1Eu+ovPqFh3Eq77joKZQVvZXqkpoTrqA6gWfB8/pb1WbpscQBbvCj0vEmxh/1nWrH5P/u+4PPzLwoIR7mMGqVL07VTE/GHZkX0qqj52Cb/E9STd9ANp0gwljY+oZoi0Up8Dx0oUbIyC9tUW9xTRR8f/xayBkgafULCQlPSvf0ysUIZPtOrPFYZU3fB16ytjItXyxW42RVSp2xXP+CSazI+lwG8B6Rr9+1yyDW8GDvHCT4VJsep5QmrZKfAbVjXuh3VphV/vpbEg4teuFhqBv/hdzvu6n+n8Gv8CRvWv25pcSbHnD/5NY35p3fYkdVY4+ZDqvTuKhCL3iablaAetLqBu+iE+0AIhX7JsW8zkpLgBT5/U7VKHRs19Pllkw0VHaepr7FTqCxlBbw9gdFW+8w+ZFiqzfl/+wa+0/GJy2dol5gNZyRyVeq/EpSBPGSseTxjvzAlWRERc7Lv8spF7RTeFQapi74FdRYVIUOX7wQqTRILdy6PKLnrIg92of0WlFx3APJgTlFoAkg+8hrAxKk1SF2E0CMyoXFV9p7HBGfL50mQpSmEGvVIzXe1v3S0PeoEUjXvzhZ9KaNtTquAxWxev+DrXtvrmKb1PZsvkHcA8YkWRHuqdciSFNkvAZ2Auc8LyyR7dl04H3zAz3YJK5a8mfYEEFUZl5oxM03MkVtdCbV8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6512007)(85182001)(6916009)(122000001)(66476007)(54906003)(76116006)(66946007)(91956017)(64756008)(2616005)(4326008)(8676002)(66556008)(66446008)(508600001)(33656002)(71200400001)(83380400001)(26005)(38100700002)(87266011)(7416002)(316002)(8936002)(82960400001)(45080400002)(186003)(86362001)(36756003)(38070700005)(2906002)(6506007)(6486002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?Y1N3cjF3MHdNSFgveDNZbmtnTG0zd0YyOUJ5WnVDUzVjd0JWa3FCWFgxZ0hL?=
 =?gb2312?B?dXRQL3FaZnJpUEhrdGF2dkJROGUxZVA4cEFTdVczWGcyWG5kSitLSU8vV2d4?=
 =?gb2312?B?cDRqWHFzWnc4VkhISEMzNy9WTnlSZ3cvTHRUNVpQbVN0c05qcUR2SjNCTUp3?=
 =?gb2312?B?N2l0RVlRTnQwZDBoMTh1VHR0YXFpWUE3OVlwTmMrZHBWT0tEbks0dFpxV0ZK?=
 =?gb2312?B?bi81WHk5VnN1MW9GZHNaUFh1dHU2ZG82eXI0Zzc2cDJQNjEyTDlEQnBUVTU2?=
 =?gb2312?B?eFJrMW96d2dYOVFtS0dLczNjVlJKeVhTQUtEa2tZejVkVHc2cXZiS0VocE81?=
 =?gb2312?B?d0pJUzZURmhzcFIzOFA4TnBhSzYvUEkxd2ExZEdSQ3VLWURlRVZKQjBYVjF4?=
 =?gb2312?B?UHg0WVRidHBCcU5WdVlBaGVMejl0S1hxdEtHR0ZjT3UrNXRrRVBlQ1FGQ1Vu?=
 =?gb2312?B?YTJLTkpOT3h5RmV5Qkt4c0ZJN1dMbVA5a1REdmUwc2wwOUFKcFRpWElJNXpv?=
 =?gb2312?B?enFKZ21hd3ZnZUJ6UnNGanZSSlhHWUVSS3BZL0pRWFc2UFdYL2E5MXFIWGJn?=
 =?gb2312?B?OXdxL2xUV3JpRldQTkxibUQ1M3dBdC9rZ1o1K1VNbGtzeVJZVTRLMUFvYyty?=
 =?gb2312?B?VStvdVF0b3dBblg5OG11VkRKMms4TFdsNHFCdzRqdzJuN1MvVkhDWnF1MXph?=
 =?gb2312?B?NGR0WXkxWHRrTkRjcTJvK3BWb1lQdHM2R0ZHK0kwSFAvb1JhM1M3UGEzeHEx?=
 =?gb2312?B?UE9oaCtPYXpkYXF0TTBINWpLdGdLcmZVcnBYMW5vTjI1akN3c3VpejdOVzJn?=
 =?gb2312?B?TmxIOW1lSzZDSjNwWmxGWndkS3hCRXY2ck04bWRYWndvWklEd1ZYU0FUR2lr?=
 =?gb2312?B?d3JKeEg1UkVoa050VnQ1YjNIb1VNMnZvNlMvYm1Ea0p4OGM2QTV3YzlwVEhk?=
 =?gb2312?B?bVVTMW0zeURjNlF3YkhzQUcwK21abysyZzlVN2FaV1RTQ3NYVFgxaGQ4c254?=
 =?gb2312?B?QndCZFFRZm81UmxrYlp2dHlseFFTWWdpUGQvWnNYWWtTTG1obFRPK1g2QWJ5?=
 =?gb2312?B?aEdnbWVMWTgyRW5OOWFvRXlVNjVPVDNRaEVKNml5d09GeUZNOEZzL3ZhRVhD?=
 =?gb2312?B?aVBJOVNlTmw2enJBMXhINFRORThrNzM4aEJkOGprM3ZFZG5Yd3d4NThhSXZi?=
 =?gb2312?B?b0x5bm5HNFZIMXhNb20vN3RXRy9wSUpqYlFUcXVMazNQOG5ISXFjVzViWmZT?=
 =?gb2312?B?WGd0cnpOdS9Zek8zMWt4dHlYc1A5Yzd5SjRRMHdmUUxKVEZ0eXlhRm9rVUhs?=
 =?gb2312?B?aVZmMVhzQkp6N3o5YkxFZ0tud1NRWEVicnZxMHA2VnZWVHFkYzJ2WVFoWndq?=
 =?gb2312?B?M2dCcU8yQjZuem9kcHZkdUsxQXErclFuQ1B0YUE0eHlXeVd1NFB3MGtzdXhY?=
 =?gb2312?B?R0lNeldaVmRGVTg0RFZ2ZE4rNGtHREFmK0dTOTV2Z0lOT3NZRE5UeU9CNnFi?=
 =?gb2312?B?emI0UkNIdExnK0FDUGt3Z3VFWW5zQm04SWhINjJTT1pqTTAwaFNFcTRJekJR?=
 =?gb2312?B?cDZzZFhZbmdIMWsyOGIzQS81Wk1uNVNyT28wSitsQjZ0eDhOYlMzZmRFc3Ry?=
 =?gb2312?B?ZDB3UUFYVndjdnpHQXhhaVZYb09DQS9oeURnRmJYdHpPdlVmc3JZeEtKWDFq?=
 =?gb2312?B?ZVlmRjZwM1F0WUg4ZVBrT0g2TXpMMXBLVDVxUmZDQ2dvc1duMmcydE9oRE05?=
 =?gb2312?B?OG1UTmZpcG94VEZ5WDhWdEI0dGt5WXkzeGpwdXZkNWd3bC9yRmtURDRaU2hk?=
 =?gb2312?B?UXJ0bUs5M0JWbkFyMG1remZ4cFZvR3hySk1tMUJBTVZ5L1lOdWsxbkRHVlJP?=
 =?gb2312?B?LzFUUk94Yi9EM0crY1p0dTlSYVNpdjNTRStzNi9GeVdtajJ0WXM0UjdXMnk4?=
 =?gb2312?B?QytscUZmRWxzV2E2empxa1hkTGpEMHMrNDRqaGhEamFHaEJ1dE5CQjMwYUgz?=
 =?gb2312?B?N0VsVFFpeFBKajc3QXl4anZXWkVKYU53Z2IrekExT0kvcjJXSzZBSHpwZERT?=
 =?gb2312?B?Z0Z1aEtaWTVsVmVaNCtua2w3cGtYaFBVK3gxSHpubXFpQmFKZXRYQWx2M2Ry?=
 =?gb2312?B?ZEYvNkNOUjYxcXNLampDVFBySEJHYTFwVk42bmp0bDJFSithVmRnUWxRNUxP?=
 =?gb2312?B?YU9XZWNSTmYyUERqKzU2WWR3M0c4YkNjWHpSYWVwUnFzcG56cmtlRHg2dEhu?=
 =?gb2312?B?NW1oUGVhNFI4ODBDQndIbEJCT1JnWFRPMVNRSzh3Zmx3VGpKWGllRktXQXQr?=
 =?gb2312?B?Q1ljakJVeGRSQytWcjJ6RGFHMmdWOUlCZjRhZTBaakIyb3RWUXhHNGhERmR2?=
 =?gb2312?Q?dmKDMqUd2uw8eEvUwQoUPdCeHn+Ja2ZTfdaSE?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <91BC94D3CE65E147B59FDAB845BA23A2@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b106fc63-0dd4-41f5-804d-08da2333ee23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 01:11:57.1642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAMKYS38UFeDmC3Cg/C/VTHBkWzi8GV5+0kB48iS5bwX0EMIhMyeTUxsWtxT9Qp8/tspeEFQWtEPEWfkOYCSwbqFUEP65cYDRHaoKcp/u5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10060
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzIxIDU6NTIsIERhdmUgQ2hpbm5lciB3cm90ZToNCj4gT24gV2VkLCBBcHIgMjAs
IDIwMjIgYXQgMDE6Mjc6MzlBTSArMDAwMCwgeHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbSB3cm90
ZToNCj4+IG9uIDIwMjIvNC8xOSAyMjowNSwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+Pj4g
T24gVHVlLCBBcHIgMTksIDIwMjIgYXQgMDc6NDc6MDdQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToN
Cj4+Pj4gVGhpcyBoYXMgbm8gZnVuY3Rpb25hbCBjaGFuZ2UuIEp1c3QgY3JlYXRlIGFuZCBleHBv
cnQgaW5vZGVfc2dpZF9zdHJpcCBhcGkgZm9yDQo+Pj4+IHRoZSBzdWJzZXF1ZW50IHBhdGNoLiBU
aGlzIGZ1bmN0aW9uIGlzIHVzZWQgdG8gc3RyaXAgU19JU0dJRCBtb2RlIHdoZW4gaW5pdA0KPj4+
PiBhIG5ldyBpbm9kZS4NCj4+Pj4NCj4+Pj4gQWNrZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChN
aWNyb3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWFuZyBY
dTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4+PiAtLS0NCj4+Pj4gICAgZnMvaW5vZGUu
YyAgICAgICAgIHwgMjIgKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4+PiAgICBpbmNsdWRlL2xp
bnV4L2ZzLmggfCAgMyArKy0NCj4+Pj4gICAgMiBmaWxlcyBjaGFuZ2VkLCAyMCBpbnNlcnRpb25z
KCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBi
L2ZzL2lub2RlLmMNCj4+Pj4gaW5kZXggOWQ5YjQyMjUwNGQxLi4zMjE1ZTYxYTAwMjEgMTAwNjQ0
DQo+Pj4+IC0tLSBhL2ZzL2lub2RlLmMNCj4+Pj4gKysrIGIvZnMvaW5vZGUuYw0KPj4+PiBAQCAt
MjI0NiwxMCArMjI0Niw4IEBAIHZvaWQgaW5vZGVfaW5pdF9vd25lcihzdHJ1Y3QgdXNlcl9uYW1l
c3BhY2UgKm1udF91c2VybnMsIHN0cnVjdCBpbm9kZSAqaW5vZGUsDQo+Pj4+ICAgIAkJLyogRGly
ZWN0b3JpZXMgYXJlIHNwZWNpYWwsIGFuZCBhbHdheXMgaW5oZXJpdCBTX0lTR0lEICovDQo+Pj4+
ICAgIAkJaWYgKFNfSVNESVIobW9kZSkpDQo+Pj4+ICAgIAkJCW1vZGUgfD0gU19JU0dJRDsNCj4+
Pj4gLQkJZWxzZSBpZiAoKG1vZGUmICAgKFNfSVNHSUQgfCBTX0lYR1JQKSkgPT0gKFNfSVNHSUQg
fCBTX0lYR1JQKSYmDQo+Pj4+IC0JCQkgIWluX2dyb3VwX3AoaV9naWRfaW50b19tbnQobW50X3Vz
ZXJucywgZGlyKSkmJg0KPj4+PiAtCQkJICFjYXBhYmxlX3dydF9pbm9kZV91aWRnaWQobW50X3Vz
ZXJucywgZGlyLCBDQVBfRlNFVElEKSkNCj4+Pj4gLQkJCW1vZGUmPSB+U19JU0dJRDsNCj4+Pj4g
KwkJZWxzZQ0KPj4+PiArCQkJaW5vZGVfc2dpZF9zdHJpcChtbnRfdXNlcm5zLCBkaXIsJm1vZGUp
Ow0KPj4+PiAgICAJfSBlbHNlDQo+Pj4+ICAgIAkJaW5vZGVfZnNnaWRfc2V0KGlub2RlLCBtbnRf
dXNlcm5zKTsNCj4+Pj4gICAgCWlub2RlLT5pX21vZGUgPSBtb2RlOw0KPj4+PiBAQCAtMjQwNSwz
ICsyNDAzLDE5IEBAIHN0cnVjdCB0aW1lc3BlYzY0IGN1cnJlbnRfdGltZShzdHJ1Y3QgaW5vZGUg
Kmlub2RlKQ0KPj4+PiAgICAJcmV0dXJuIHRpbWVzdGFtcF90cnVuY2F0ZShub3csIGlub2RlKTsN
Cj4+Pj4gICAgfQ0KPj4+PiAgICBFWFBPUlRfU1lNQk9MKGN1cnJlbnRfdGltZSk7DQo+Pj4+ICsN
Cj4+Pj4gK3ZvaWQgaW5vZGVfc2dpZF9zdHJpcChzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91
c2VybnMsDQo+Pj4+ICsJCSAgICAgIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90ICpt
b2RlKQ0KPj4+PiArew0KPj4+DQo+Pj4gSSB0aGluayB3aXRoIFdpbGx5IGFncmVlaW5nIGluIGFu
IGVhcmxpZXIgdmVyc2lvbiB3aXRoIG1lIGFuZCB5b3UNCj4+PiBuZWVkaW5nIHRvIHJlc2VuZCBh
bnl3YXkgSSdkIHNheSBoYXZlIHRoaXMgcmV0dXJuIHVtb2RlX3QgaW5zdGVhZCBvZg0KPj4+IHBh
c3NpbmcgYSBwb2ludGVyLg0KPj4NCj4+IElNTywgSSBhbSBmaW5lIHdpdGggeW91ciBhbmQgV2ls
bHkgd2F5LiBCdXQgSSBuZWVkIGEgcmVhc29uIG90aGVyd2lzZQ0KPj4gSSBjYW4ndCBjb252aW5j
ZSBteXNlbGYgd2h5IG5vdCB1c2UgbW9kZSBwb2ludGVyIGRpcmVjdGx5Lg0KPg0KPiBZb3Ugc2hv
dWxkIGxpc3RlbiB0byBleHBlcmllbmNlZCBkZXZlbG9wZXJzIGxpa2UgV2lsbHkgYW5kIENocmlz
dGlhbg0KPiB3aGVuIHRoZXkgc2F5ICJmb2xsb3cgZXhpc3RpbmcgY29kaW5nIGNvbnZlbnRpb25z
Ii4gIEluZGVlZCwgRGFycmljaw0KPiBoYXMgYWxzbyBtZW50aW9uZWQgaGUnZCBwcmVmZXIgaXQg
dG8gcmV0dXJuIHRoZSBuZXcgbW9kZSwgYW5kIEknZA0KPiBhbHNvIHByZWZlciB0aGF0IGl0IHJl
dHVybnMgdGhlIG5ldyBtb2RlLg0KT0suIEkganVzdCBkb24ndCBrbm93ICB0aGUgImZvbGxvdyBl
eGlzdGluZyBjb2RpbmcgY29udmVudGlvbnMiIHJlYXNvbi4gDQpOb3csIEkga25vdyBhbmQgdW5k
ZXJzdGFuZC4NCj4NCj4+IEkgaGF2ZSBhc2tlZCB5b3UgYW5kIFdpbGx5IGJlZm9yZSB3aHkgcmV0
dXJuIHVtb2RlX3QgdmFsdWUgaXMgYmV0dGVyLA0KPj4gd2h5IG5vdCBtb2RpZnkgbW9kZSBwb2lu
dGVyIGRpcmVjdGx5PyBTaW5jZSB3ZSBoYXZlIHVzZSBtb2RlIGFzDQo+PiBhcmd1bWVudCwgd2h5
IG5vdCBtb2RpZnkgbW9kZSBwb2ludGVyIGRpcmVjdGx5IGluIGZ1bmN0aW9uPw0KPg0KPiBJZiB0
aGUgZnVuY3Rpb24gaGFkIG11bGl0cGxlIHJldHVybiBzdGF0dXMgKGUuZy4gYW4gZXJyb3Igb3Ig
YSBtb2RlKQ0KPiB0aGUgY29udmVudGlvbiBpcyB0byBwYXNzIHRoZSBtb2RlIG91dHB1dCB2YXJp
YWJsZSBieSByZWZlcmVuY2UgYW5kDQo+IHJldHVybiB0aGUgZXJyb3Igc3RhdHVzLiBCdXQgdGhl
cmUgaXMgb25seSBvbmUgcmV0dXJuIHZhbHVlIGZyb20NCj4gdGhpcyBmdW5jdGlvbiAtIHRoZSBt
b2RlIC0gYW5kIGhlbmNlIGl0IHNob3VsZCBiZSByZXR1cm5lZCBpbiB0aGUNCj4gcmV0dXJuIHZh
bHVlLCBub3QgcGFzc2VkIGJ5IHJlZmVyZW5jZS4NCj4NCj4gUGFzc2luZyBieSByZWZlcmVuY2Ug
dW5uZWNlc3NhcmlseSBtYWtlcyB0aGUgY29kZSBtb3JlIGNvbXBsZXggYW5kDQo+IGxlc3MgbWFp
bmF0YWluYWJsZS4gIENvZGUgdGhhdCByZXR1cm5zIGEgc2luZ2xlIHZhbHVlIGlzIGVhc3kgdG8N
Cj4gdW5kZXJzdGFuZCwgaXMgbW9yZSBmbGV4aWJsZSBpbiB0aGUgd2F5IGNhbGxlcnMgY2FuIHVz
ZSBpdCBhbmQgaXQncw0KPiBzaW1wbGVyIHRvIG1haW50YWluLg0KT0ssICBpdCBzb3VuZHMgcmVh
c29uYWJsZSBhbmQgd2lsbCB1c2UgcmV0dXJuIHZhbHVlLg0KDQpwczogT2YgY291cnNlLCBJIHdp
bGwgcmVtZW1iZXIgdGhpcyBpbiBteSBtaW5kLiBUaGFua3MgZm9yIHlvdXIgcmVwbGF5Lg0KDQpC
ZXN0IFJlZ2FyZHMNCllhbmcgWHUNCg0KPg0KPiBDaGVlcnMsDQo+DQo+IERhdmUuDQo=
