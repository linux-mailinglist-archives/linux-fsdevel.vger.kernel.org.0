Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFB4FF1F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 10:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiDMIeR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 04:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233800AbiDMIeP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:34:15 -0400
Received: from esa10.fujitsucc.c3s2.iphmx.com (esa10.fujitsucc.c3s2.iphmx.com [68.232.159.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B64E047ACA;
        Wed, 13 Apr 2022 01:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649838713; x=1681374713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EMxcvjQ3QEA7+hJe7hH4vfRVvn4L5XJqTNcsfnvZJAw=;
  b=RcUCjwozE4xC9Kukq5/okrNDPHdUDaMxO4ITLD9dnwANxLzQhzlbMhkO
   JCjEBZJX5/N5ZNC1rw722Q73V+9/WStYHA1HeyqjYn6JCGpTbRrHQBcj2
   fRbUEGkLNGGdNvFn7LL83WMHXn+fwq+SYM3zRV0k3f14W5IOFCy3l0yPg
   TOG6eYMWn3shmdeBh8lzVWQhsRGQSOp1oyTeNp8SOREiDclJ+HTgh/8hB
   hIPxT4kOBqOpVqdvOFVM2cQs/f0zFlB8qI/5Inun/k48vm1cQshxfBx1/
   bMTbw5UlfUCyEfGRQbTz6yo+63dq46sACN2H+j+jbRMHUhpQ53eoUB2G3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="53938609"
X-IronPort-AV: E=Sophos;i="5.90,256,1643641200"; 
   d="scan'208";a="53938609"
Received: from mail-os0jpn01lp2110.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.110])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 17:31:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2QpVYMEN4KP7O/UGT9wQwPtZbIeL1+J4AF+DxqCeSUMiknxErkzE70uZ1vsCeKVL8PfwY40k5AS3cP6hDBSWMnIGe/ocR9JoyJHE04kBBuqowoJIJ/txZtvhEj0se0yxhmF9xl1KmfNTMpOG94yWu4j6o/PTlY6hse6+vVIfPttvBVCQhPL1pBw5EyzuVk5TB8oFsTYUrDfBrPduESJPAP3vDeJM+0cdjTDEfKLNahv3JQtNaJTL3CK0LQ88KqKqQCIEONCSwPPaBXJK+Sw1p9PRytOS/wOsXWh6YOhZpQmuXpIrKAWEEWaYgtN/HWmwaAJI3PjnTiVMLH3ih2/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMxcvjQ3QEA7+hJe7hH4vfRVvn4L5XJqTNcsfnvZJAw=;
 b=JG529skv9EKIihbmEWLHXPzxKrzQD9O5eE7bZPp5+o0HnxPXpmnqdk8gwJNjkT3uPoGetsdvBQY+fg0uXziiLWGMp6FF5Id0x9gcvsbI7qeEWW+6mOQkg8bu4+RtGBeutXUPW6TUKFp/gMXWBkQfm/cqO2rNaeaV06JPxmP8jNPDzU+7cptgireo+sQEI8y7X1KwLPzDkqf/YkV1FqOA7e5RLdz160o+/F30jw+q4rwi9YRwyWE6FOK8EnABaoyxzZvikMoWKHn66xIIcLk1J7oTppyzaZnBTVQrsG/jDoyhi/ySdfFXbZP2sXQf9YLZ4+rjA2pOHjKBOfbXRGQ1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMxcvjQ3QEA7+hJe7hH4vfRVvn4L5XJqTNcsfnvZJAw=;
 b=Y1tp51MKHYn7Ngpv78hQWXBpT6v+neSvds3MKY3IQlGu5ibyghxttutKZpPAEPzwH89CkuSyIYm4zABz253d+jzmJICJABmKUUMNoDUOV3s83ZOuSzd5b1vIqHigVYreyhjmLvPFZ7H+aVXzYMuDpAvJtG0CaAHAnrkfVx04hxs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB9520.jpnprd01.prod.outlook.com (2603:1096:400:190::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Wed, 13 Apr
 2022 08:31:46 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 08:31:46 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Topic: [PATCH v3 2/5] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Index: AQHYTljHgy7KpPtqaE+z9siscHWI86ztfBeAgAAaD4A=
Date:   Wed, 13 Apr 2022 08:31:45 +0000
Message-ID: <625698B9.9090509@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649763226-2329-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220413075925.f52jcurkieorm2df@wittgenstein>
In-Reply-To: <20220413075925.f52jcurkieorm2df@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 636092ac-60ae-445a-1776-08da1d280bf4
x-ms-traffictypediagnostic: TYCPR01MB9520:EE_
x-microsoft-antispam-prvs: <TYCPR01MB9520D5708364DC1383069A6DFDEC9@TYCPR01MB9520.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uM2cEtHs9jnHUXRa7y2tR1G761oCKBHRnWGJdDjaP0GI7pAMGkG5MMoR+5y07cgTlDxP33lvl46b9T1Pv/WZKquHYz8dg5rRs+1aJPwzpAloSljnBUbWHnDO/rpP+S8DNsduM77Sy/dyuFFz99KL1GYW/PpV9G6bNiHOm5y93gIwBzWfX9wEy7ktZ0LiJW7OHLqMLBLkV60M7nKW764p7Q94HQWYTOv5WVPtrutjduy6cMgarfrT2x4XjUaMtHML2EDESS7zjdi5ZtroxXO03MZYpFM8Ht0K+8LYKUtk6AfFxdYnf1gMAugRdXEX/2xhc4jfGneoKLmjWDTb0KFAu5M8AcwS/pCVEQGL+jo6PVVAOuRv1gWknQF1e/IzVGEuv29B2XoEiYPYR3Sn6I84ITkMWbdUQ1lZTRbDmA7TvjrOr8f2DqtkNrpW8+Mn7q+rRirIIKak5CeaAAHeK/COubkbptiqE78PM6X+dRmHXCgj4IkAlhnsfg3+31sxlbq5hzVqT5CTSi/IY3xNwnprxKeWjuht9WOtBNjhWv2IVF//kNL0/GoPiFGNBAnHrjb5lh0Fj+efk1Hvy1NkCgaTbMa90SkyoQp+AKazXzbDah77515X1w80p7D1xYTP9FS6WVY3OdtDMvI0PpkD2Cxi+1ULiQrdQ08J5Vy5yS3oU+49ISImvRZKxPt9Zvjk2fzouO2BOm6K0PDNkOPii7tj9nEO5BSV6iZck4QnZpHn2KQgjdco01XEdlPORMNhDctpvrkMPeUnqat/q5S3brvEINGXvjnc4ntJgz72tiQrNEg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(186003)(87266011)(26005)(122000001)(8676002)(4326008)(66446008)(66946007)(76116006)(66556008)(66476007)(64756008)(508600001)(2906002)(6512007)(82960400001)(36756003)(38100700002)(2616005)(71200400001)(6486002)(966005)(91956017)(86362001)(316002)(54906003)(6916009)(83380400001)(8936002)(38070700005)(45080400002)(5660300002)(85182001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZG95a1FJTm5YTXZnbWJHb21xd3dxOWVmRVphMjhXVStmTDRSQkpiQjlPRWdC?=
 =?utf-8?B?d0krOHNhaXR4K0tacXM0L1hWNlNXYjlMeWc1TGlndThaYXB2NWpWSk9xWjZT?=
 =?utf-8?B?cHQ5L3lIem9zVTB2bmg5endhekVEdkwrVTE2aEZORURxQUREdzR5ZjVEem9H?=
 =?utf-8?B?bVd2MXh5NUtiSGtMR0VjU3VtSzVTYm9kZkJEUWlxWlpJbk00eElvaEFtd0l4?=
 =?utf-8?B?cFZvTzN1S1RKbHhiNS80azQ1Zm1OSThwUE9sbG9GZ1pZYUZGYmxEZmIyMkRQ?=
 =?utf-8?B?MHZuTUdlRGMyWWd6RDFqTXRSM25pMDdOZ3BoWHU0Z0NFREpFQ0hLdW1ndnd4?=
 =?utf-8?B?OE9PNXNCTlRXeGYvMTkyWVdYd3pLQWJFQ0FIRlJWTlIvYk55R2xha0tNaVh2?=
 =?utf-8?B?NE1lS0FqVFdnQW50R3NVK29rblVxVkxTTUFpaW5sc0F1MEt5OEZqcGZLMjNY?=
 =?utf-8?B?NTRDSy9LQVJzRjNYaVo0dGhsU3dONGVIODlCWXlISmNCWm4rVlpBOE80Y3Ey?=
 =?utf-8?B?RnkrdUVSUldaY2V5WVVyNU9ibnpaNnluTmF6YUNUTGVHWVlFWTVSZUJSTXhS?=
 =?utf-8?B?N2U4UlNuR2c3WkZwQjZYNisvMUZYOFcxdW0zclc1MEdIcUdUT1R1Q2VINXps?=
 =?utf-8?B?Ykh5WEtuMWVjZHBjVmhDaVk2eEY3djdTWEpVMytKRmRRSitid2lCQlB6MHRp?=
 =?utf-8?B?d3Z4NjY4MU1Mb1BTNEVKOGVBNnhDU3JIZ0t5bTREMlpjTkI0YVdhL0R0ZGlS?=
 =?utf-8?B?Y1RISVlRS0crZldCZ0VsVnl3YUpnZGlVU3N6V0N3VXgwVlF4TG1DbzdyNXRi?=
 =?utf-8?B?VUZEaXBXTkJSRDZOTkhsSVBBbGd5MU52ZDI5ekk1MGVnMHVnQTBsTElIbHUx?=
 =?utf-8?B?a3NzOHpadndXMVlDVFJKY2JiRmVKeHNjNG1paXZWSUpZSElOR0VjZzFIUDda?=
 =?utf-8?B?N2tIekp0ZGI5SlIxYjJVbVYrTUJZVGxpMjdCV2Y1dERCU0J6eDlqTG0xWkZM?=
 =?utf-8?B?MGdiTTAxdmtmYTFDQk80OGpHWGpJOWc5TWxLaTc1VkpFaEREZGR1U3JQTEZn?=
 =?utf-8?B?dE9WL085UFRRdVlndHNTakVoSkZVd044aHRZKzVkcmJVUEFVZzRMNW83N05C?=
 =?utf-8?B?UkhhMFpsVmZ1N2h2aFZrMU1iZE5kZFNqMWdaWU00ZHl2aWVHSm0yN3YrSzJn?=
 =?utf-8?B?MXVEc1ZYVTZBb3VWZm1ON3NqR3dURGpiRHAwWEZoaU5EczBGa3NEdXM0M3Bw?=
 =?utf-8?B?a0NvV09mdXU3cy9mdlo1aHJra3ZQV1FWWjNkZGlSa2NsQ3VjaGp4OEJ5WjlM?=
 =?utf-8?B?YnF3dTg1L3JMS0hieHVSRVpBZ0czbGl0dG1icXJZNHdHNllHa29qb2QyVSt2?=
 =?utf-8?B?QzhDL3pyOVN4blNPU0tiUHR2L2pMNndJNVdmZzhlVkVnWE5MeFcrWkw1VTlG?=
 =?utf-8?B?WnNTOExaM1NzMVRrdm1oMnFLTU5KdUtTSjlCdHR0azdOSmVvUEp5RXg4cThQ?=
 =?utf-8?B?OFRjaldZUTlZOXZvK2xLcTRLWm5vcFN4cXVQNzlsZzJiNTRxM2doWjIyRVJi?=
 =?utf-8?B?UG5rQ3ZGT0NOaUJpc0IvcnRHY1cxdVNiWEFlUDlralRRQ0VadlEvQnBNQ2NC?=
 =?utf-8?B?M1NSMlZUcThHSXhuNVFiUWpZSVBXUjkxKzJodGcvRnovT0QzZlM0TWoxWCtF?=
 =?utf-8?B?aHAvTnlOeDFpc1I1V3dvU3JFMXkxZzd1bGFaUVZvelVjaWNtTWdpUDRkU3dn?=
 =?utf-8?B?bGVtaW1GTzR3V3BvU3ZOL0VGamRVcU02bWJYYnVjTGZiTUp0dzY3dHJZcndl?=
 =?utf-8?B?M3ZKSWZrUDlYMWswNFZPc2EyVmZJYjA3ZTVOQitLZWczVS84MUcrYTh3S3FB?=
 =?utf-8?B?R2xYMG9XbGIzb3k1dk1DYXhFUWRhSXRMREU5Q0xhR0RGNFlBUWNJYTQyVjIv?=
 =?utf-8?B?ZVBlM0JZRXNqZ2E0b25tVUw0WitIZDRoZ2RQbkFuWjhLcnlwQzU4MnpLeDlY?=
 =?utf-8?B?MDV6NnlvcnZjN2lIUUQzQUIzdDBNNjZEOEdmMW1WYzNEeVdzeWx4U2t1bThD?=
 =?utf-8?B?SXBDTmhpTnBDbzRDZnNnS0VKaG15ZHNZcXFMbkVFNFhHdHpUdFYwR0hvYzgv?=
 =?utf-8?B?RXJpek9BYWk2aDlnanZVNm51b0NzZ2NhQW4xeDk2ZS81U1J3OEZIalhrNkI5?=
 =?utf-8?B?SFJQQzBaN0lnUFZSMVJOYlZPaENBbUxkOXZxcEtzdW42UWl2dFNEdURZMzNt?=
 =?utf-8?B?U25lM1RYcGNwSXhCeHUzT2VLMXZZdDYwRUpQZ2c5d05pZ2lNK0dLYkJFd21p?=
 =?utf-8?B?SWVITmVyZHlCZTVwbUZnaitseWg1NnQ1d1NaZEtXZGhhWUFNOVQ2WUplVkdv?=
 =?utf-8?Q?pEp1sSbE/x8P1ozc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8B274ED8342A54787DC03E0D58F7185@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 636092ac-60ae-445a-1776-08da1d280bf4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 08:31:46.1540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMjgOH/kbQlUmw78OLf6SDxh+ZZG3gKINaxAjQWcUnRVHYZ+J/3pe/YFbI1X7pRBUE9k+DMd3KlQvW9Irc1Hd7BC3kGHdEEue7DPwktzQ+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9520
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzEzIDE1OjU5LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMTIsIDIwMjIgYXQgMDc6MzM6NDNQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNl
IG1rbm9kYXQgY2FuIGNyZWF0ZSBmaWxlLCB3ZSBzaG91bGQgYWxzbyBjaGVjayB3aGV0aGVyIHN0
cmlwIFNfSVNHSUQuDQo+PiBBbHNvIGFkZCBuZXcgaGVscGVyIGNhcHNfZG93bl9mc2V0aWQgdG8g
ZHJvcCBDQVBfRlNFVElEIGJlY2F1c2Ugc3RyaXAgU19JU0dJRA0KPj4gZGVwZW5kIG9uIHRoaXMg
Y2FwIGFuZCBrZWVwIG90aGVyIGNhcChpZSBDQVBfTUtOT0QpIGJlY2F1c2UgY3JlYXRlIGNoYXJh
Y3Rlcg0KPj4gZGV2aWNlIG5lZWRzIGl0IHdoZW4gdXNpbmcgbWtub2QuDQo+Pg0KPj4gT25seSB0
ZXN0IG1rbm9kYXQgd2l0aCBjaGFyYWN0ZXIgZGV2aWNlIGluIHNldGdpZF9jcmVhdGUgZnVuY3Rp
b24gYW5kIHRoZSBhbm90aGVyDQo+PiB0d28gZnVuY3Rpb25zIHRlc3QgbWtub2RhdCB3aXRoIHdo
aXRlb3V0IGRldmljZS4NCj4+DQo+PiBTaW5jZSBrZXJuZWwgY29tbWl0IGEzYzc1MWE1MCAoInZm
czogYWxsb3cgdW5wcml2aWxlZ2VkIHdoaXRlb3V0IGNyZWF0aW9uIikgaW4NCj4+IHY1LjgtcmMx
LCB3ZSBjYW4gY3JlYXRlIHdoaXRlb3V0IGRldmljZSBpbiB1c2VybnMgdGVzdC4gU2luY2Uga2Vy
bmVsIDUuMTIsIG1vdW50X3NldGF0dHINCj4+IGFuZCBNT1VOVF9BVFRSX0lETUFQIHdhcyBzdXBw
b3J0ZWQsIHdlIGRvbid0IG5lZWQgdG8gZGV0ZWN0IGtlcm5lbCB3aGV0aGVyIGFsbG93DQo+PiB1
bnByaXZpbGVnZWQgd2hpdGVvdXQgY3JlYXRpb24uIFVzaW5nIGZzX2FsbG93X2lkbWFwIGFzIGEg
cHJveHkgaXMgc2FmZS4NCj4+DQo+PiBUZXN0ZWQtYnk6IENocmlzdGlhbiBCcmF1bmVyIChNaWNy
b3NvZnQpPGJyYXVuZXJAa2VybmVsLm9yZz4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4gQnJh
dW5lciAoTWljcm9zb2Z0KTxicmF1bmVyQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZ
YW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgc3JjL2lkbWFw
cGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYyB8IDIxOSArKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3NyYy9pZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQtbW91
bnRzLmMgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1vdW50cy5jDQo+PiBpbmRleCA4
ZTY0MDVjNS4uNjE3ZjU2ZTAgMTAwNjQ0DQo+PiAtLS0gYS9zcmMvaWRtYXBwZWQtbW91bnRzL2lk
bWFwcGVkLW1vdW50cy5jDQo+PiArKysgYi9zcmMvaWRtYXBwZWQtbW91bnRzL2lkbWFwcGVkLW1v
dW50cy5jDQo+PiBAQCAtMjQxLDYgKzI0MSwzNCBAQCBzdGF0aWMgaW5saW5lIGJvb2wgY2Fwc19z
dXBwb3J0ZWQodm9pZCkNCj4+ICAgCXJldHVybiByZXQ7DQo+PiAgIH0NCj4+DQo+PiArc3RhdGlj
IGludCBjYXBzX2Rvd25fZnNldGlkKHZvaWQpDQo+PiArew0KPj4gKwlib29sIGZyZXQgPSBmYWxz
ZTsNCj4+ICsjaWZkZWYgSEFWRV9TWVNfQ0FQQUJJTElUWV9IDQo+PiArCWNhcF90IGNhcHMgPSBO
VUxMOw0KPj4gKwljYXBfdmFsdWVfdCBjYXAgPSBDQVBfRlNFVElEOw0KPj4gKwlpbnQgcmV0ID0g
LTE7DQo+PiArDQo+PiArCWNhcHMgPSBjYXBfZ2V0X3Byb2MoKTsNCj4+ICsJaWYgKCFjYXBzKQ0K
Pj4gKwkJZ290byBvdXQ7DQo+PiArDQo+PiArCXJldCA9IGNhcF9zZXRfZmxhZyhjYXBzLCBDQVBf
RUZGRUNUSVZFLCAxLCZjYXAsIDApOw0KPj4gKwlpZiAocmV0KQ0KPj4gKwkJZ290byBvdXQ7DQo+
PiArDQo+PiArCXJldCA9IGNhcF9zZXRfcHJvYyhjYXBzKTsNCj4+ICsJaWYgKHJldCkNCj4+ICsJ
CWdvdG8gb3V0Ow0KPj4gKw0KPj4gKwlmcmV0ID0gdHJ1ZTsNCj4+ICsNCj4+ICtvdXQ6DQo+PiAr
CWNhcF9mcmVlKGNhcHMpOw0KPj4gKyNlbmRpZg0KPj4gKwlyZXR1cm4gZnJldDsNCj4+ICt9DQo+
PiArDQo+PiAgIC8qIGNhcHNfZG93biAtIGxvd2VyIGFsbCBlZmZlY3RpdmUgY2FwcyAqLw0KPj4g
ICBzdGF0aWMgaW50IGNhcHNfZG93bih2b2lkKQ0KPj4gICB7DQo+PiBAQCAtNzgwNSw4ICs3ODMz
LDggQEAgb3V0X3VubWFwOg0KPj4gICAjZW5kaWYgLyogSEFWRV9MSUJVUklOR19IICovDQo+Pg0K
Pj4gICAvKiBUaGUgZm9sbG93aW5nIHRlc3RzIGFyZSBjb25jZXJuZWQgd2l0aCBzZXRnaWQgaW5o
ZXJpdGFuY2UuIFRoZXNlIGNhbiBiZQ0KPj4gLSAqIGZpbGVzeXN0ZW0gdHlwZSBzcGVjaWZpYy4g
Rm9yIHhmcywgaWYgYSBuZXcgZmlsZSBvciBkaXJlY3RvcnkgaXMgY3JlYXRlZA0KPj4gLSAqIHdp
dGhpbiBhIHNldGdpZCBkaXJlY3RvcnkgYW5kIGlyaXhfc2dpZF9pbmhpZXJ0IGlzIHNldCB0aGVu
IGluaGVyaXQgdGhlDQo+PiArICogZmlsZXN5c3RlbSB0eXBlIHNwZWNpZmljLiBGb3IgeGZzLCBp
ZiBhIG5ldyBmaWxlIG9yIGRpcmVjdG9yeSBvciBub2RlIGlzDQo+PiArICogY3JlYXRlZCB3aXRo
aW4gYSBzZXRnaWQgZGlyZWN0b3J5IGFuZCBpcml4X3NnaWRfaW5oaWVydCBpcyBzZXQgdGhlbiBp
bmhlcml0IHRoZQ0KPj4gICAgKiBzZXRnaWQgYml0IGlmIHRoZSBjYWxsZXIgaXMgaW4gdGhlIGdy
b3VwIG9mIHRoZSBkaXJlY3RvcnkuDQo+PiAgICAqLw0KPj4gICBzdGF0aWMgaW50IHNldGdpZF9j
cmVhdGUodm9pZCkNCj4+IEBAIC03ODYzLDE4ICs3ODkxLDQ0IEBAIHN0YXRpYyBpbnQgc2V0Z2lk
X2NyZWF0ZSh2b2lkKQ0KPj4gICAJCWlmICghaXNfc2V0Z2lkKHRfZGlyMV9mZCwgRElSMSwgMCkp
DQo+PiAgIAkJCWRpZSgiZmFpbHVyZTogaXNfc2V0Z2lkIik7DQo+Pg0KPj4gKwkJLyogY3JlYXRl
IGEgc3BlY2lhbCBmaWxlIHZpYSBta25vZGF0KCkgdmZzX2NyZWF0ZSAqLw0KPj4gKwkJaWYgKG1r
bm9kYXQodF9kaXIxX2ZkLCBGSUxFMiwgU19JRlJFRyB8IFNfSVNHSUQgfCBTX0lYR1JQLCAwKSkN
Cj4+ICsJCQlkaWUoImZhaWx1cmU6IG1rbm9kYXQiKTsNCj4+ICsNCj4+ICsJCWlmICghaXNfc2V0
Z2lkKHRfZGlyMV9mZCwgRklMRTIsIDApKQ0KPj4gKwkJCWRpZSgiZmFpbHVyZTogaXNfc2V0Z2lk
Iik7DQo+PiArDQo+PiArCQkvKiBjcmVhdGUgYSBjaGFyYWN0ZXIgZGV2aWNlIHZpYSBta25vZGF0
KCkgdmZzX21rbm9kICovDQo+PiArCQlpZiAobWtub2RhdCh0X2RpcjFfZmQsIENIUkRFVjEsIFNf
SUZDSFIgfCBTX0lTR0lEIHwgU19JWEdSUCwgbWFrZWRldig1LCAxKSkpDQo+PiArCQkJZGllKCJm
YWlsdXJlOiBta25vZGF0Iik7DQo+PiArDQo+PiArCQlpZiAoIWlzX3NldGdpZCh0X2RpcjFfZmQs
IENIUkRFVjEsIDApKQ0KPj4gKwkJCWRpZSgiZmFpbHVyZTogaXNfc2V0Z2lkIik7DQo+PiArDQo+
PiAgIAkJaWYgKCFleHBlY3RlZF91aWRfZ2lkKHRfZGlyMV9mZCwgRklMRTEsIDAsIDAsIDApKQ0K
Pj4gICAJCQlkaWUoImZhaWx1cmU6IGNoZWNrIG93bmVyc2hpcCIpOw0KPj4NCj4+ICAgCQlpZiAo
IWV4cGVjdGVkX3VpZF9naWQodF9kaXIxX2ZkLCBESVIxLCAwLCAwLCAwKSkNCj4+ICAgCQkJZGll
KCJmYWlsdXJlOiBjaGVjayBvd25lcnNoaXAiKTsNCj4+DQo+PiArCQlpZiAoIWV4cGVjdGVkX3Vp
ZF9naWQodF9kaXIxX2ZkLCBGSUxFMiwgMCwgMCwgMCkpDQo+PiArCQkJZGllKCJmYWlsdXJlOiBj
aGVjayBvd25lcnNoaXAiKTsNCj4+ICsNCj4+ICsJCWlmICghZXhwZWN0ZWRfdWlkX2dpZCh0X2Rp
cjFfZmQsIENIUkRFVjEsIDAsIDAsIDApKQ0KPj4gKwkJCWRpZSgiZmFpbHVyZTogY2hlY2sgb3du
ZXJzaGlwIik7DQo+PiArDQo+PiAgIAkJaWYgKHVubGlua2F0KHRfZGlyMV9mZCwgRklMRTEsIDAp
KQ0KPj4gICAJCQlkaWUoImZhaWx1cmU6IGRlbGV0ZSIpOw0KPj4NCj4+ICAgCQlpZiAodW5saW5r
YXQodF9kaXIxX2ZkLCBESVIxLCBBVF9SRU1PVkVESVIpKQ0KPj4gICAJCQlkaWUoImZhaWx1cmU6
IGRlbGV0ZSIpOw0KPj4NCj4+ICsJCWlmICh1bmxpbmthdCh0X2RpcjFfZmQsIEZJTEUyLCAwKSkN
Cj4+ICsJCQlkaWUoImZhaWx1cmU6IGRlbGV0ZSIpOw0KPj4gKw0KPj4gKwkJaWYgKHVubGlua2F0
KHRfZGlyMV9mZCwgQ0hSREVWMSwgMCkpDQo+PiArCQkJZGllKCJmYWlsdXJlOiBkZWxldGUiKTsN
Cj4+ICsNCj4+ICAgCQlleGl0KEVYSVRfU1VDQ0VTUyk7DQo+PiAgIAl9DQo+PiAgIAlpZiAod2Fp
dF9mb3JfcGlkKHBpZCkpDQo+PiBAQCAtNzg4OSw4ICs3OTQzLDggQEAgc3RhdGljIGludCBzZXRn
aWRfY3JlYXRlKHZvaWQpDQo+PiAgIAkJaWYgKCFzd2l0Y2hfaWRzKDAsIDEwMDAwKSkNCj4+ICAg
CQkJZGllKCJmYWlsdXJlOiBzd2l0Y2hfaWRzIik7DQo+Pg0KPj4gLQkJaWYgKCFjYXBzX2Rvd24o
KSkNCj4+IC0JCQlkaWUoImZhaWx1cmU6IGNhcHNfZG93biIpOw0KPj4gKwkJaWYgKCFjYXBzX2Rv
d25fZnNldGlkKCkpDQo+PiArCQkJZGllKCJmYWlsdXJlOiBjYXBzX2Rvd25fZnNldGlkIik7DQo+
Pg0KPj4gICAJCS8qIGNyZWF0ZSByZWd1bGFyIGZpbGUgdmlhIG9wZW4oKSAqLw0KPj4gICAJCWZp
bGUxX2ZkID0gb3BlbmF0KHRfZGlyMV9mZCwgRklMRTEsIE9fQ1JFQVQgfCBPX0VYQ0wgfCBPX0NM
T0VYRUMsIFNfSVhHUlAgfCBTX0lTR0lEKTsNCj4+IEBAIC03OTE3LDYgKzc5NzEsMTkgQEAgc3Rh
dGljIGludCBzZXRnaWRfY3JlYXRlKHZvaWQpDQo+PiAgIAkJCQlkaWUoImZhaWx1cmU6IGlzX3Nl
dGdpZCIpOw0KPj4gICAJCX0NCj4NCj4gUGxlYXNlIHNlZSBteSBjb21tZW50IG9uIHRoZSBlYXJs
aWVyIHRocmVhZDoNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtZnNkZXZlbC8yMDIy
MDQwNzEzNDAwOS5zNHNoaG9tZnhqejVjZjVyQHdpdHRnZW5zdGVpbg0KPg0KPiBUaGUgc2FtZSBp
c3N1ZSBzdGlsbCBleGlzdHMgYWZhaWN0LCBpLmUuIHlvdSdyZSBub3QgaGFuZGxpbmcgdGhlIGly
aXgNCj4gY2FzZS4NCkkgcmVtZW1iZXIgaXQgaGFzIHR3byBpc3N1ZXMNCjEpcmVwbGFjZSAwNzU1
IHdpdGggdmFsaWQgZmxhZ3MNCjIpY29uc2lkZXIgZnMueGZzLmlyaXhfc2dpZF9pbmhlcml0IGVu
YWJsZSBzaXR1YXRpb24gYmVjYXVzZSBpdCB3aWxsIA0Kc3RyaXAgU19JU0dJRCBmb3IgZGlyZWN0
b3J5DQoNCkkgdXNlZCB0X2RpcjFfZmQgZGlyZWN0b3J5IGluc3RlYWQgb2Ygb2xkIERJUjEsIHNv
IEkgZG9uJ3QgbmVlZCB0byByYWlzZSANCnRoZSBTX0lTR0lEIHdoZW4gd2UgZW5hYmxlIGZzLnhm
cy5pcml4X3NnaWRfaW5oZXJpdC4NCg0KSSBoYXZlIHRlc3RlZCB0aGlzIG9uIGVuYWJsZSBhbmQg
ZGlzYWJsZSBmcy54ZnMuaXJpeF9zZ2lkX2luaGVyaXQgDQpzaXR1YXRpb25zLCB0aGV5IGFsbCBw
YXNzLg0KDQpPciBJIG1pc3Mgc29tZXRoaW5nPw0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHU=
