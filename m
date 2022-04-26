Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C950F2D4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 09:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbiDZHmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbiDZHmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:42:23 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107101344FA;
        Tue, 26 Apr 2022 00:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650958757; x=1682494757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HuoO/dvFxmdyK7AA4NNJB6gQhnBgcqUPNrrIguDUCuA=;
  b=Pvi2BnomNqAtIDKNMcVi5AxF0zF2WmPOiM3VUd6DOD79JtMNhWwv9mRk
   YsMrBWjBIqJDFSqj6KQtSUFeJdjJkJ2Ct53Ei6P1e7TmyuB1wo8ZKQdIp
   JO0yDRxDuDD4ChAVbztLC6kpw7/9o2CUPA7ZpBTPBBmy5Jgoh0G5vMR+A
   0Bnbd4C+YZxjVMDjRrCSHZSsiyUxIK9s+oZCnQ40MrkA3MTFgXpYLkxMp
   lhge65BL/xdEGtJ4/v5q5S1xDvRYWHyZUsKu1hc1WUtyHSLHk0WxAjtn/
   7yatIfF+MbDI+DrA71yL8XZthDKDCYkdRUG46Qr/RCJJg8ZvjDPy/OiBQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="54700087"
X-IronPort-AV: E=Sophos;i="5.90,290,1643641200"; 
   d="scan'208";a="54700087"
Received: from mail-os0jpn01lp2112.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.112])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 16:39:12 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6jhXbKrIYa7456qaSHjLUVBOuov2qoyg0rh9vHHGwUzJu50WJ1OgEcox3KjTLdYNr6I/ufthAc77WLoB2zl4V5iiTSTFxyGDMsVDbQzQXAAD136/2Ic1kcdO3g/ldp/BgNwMMxOBRhGTTklFG4k44qjyXtWibXlBWHxyM6qsAdLCA4GSSnMd8xJoU9sbCPX451d8rj89e0S0iBDR5HwkpuU3ZWgjdvDKoWM4A/6U8R/Wtiovxsc71YzhCVYIwZxvKKEk/4EidzCh9QGV1CwfLFUQDOhmgbJo9Xa45YMPffs86kGgVuzTPhTYlAR/mwhOrK4+78w2rddmR+IL7vS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuoO/dvFxmdyK7AA4NNJB6gQhnBgcqUPNrrIguDUCuA=;
 b=lYxPd5kZI5Dbe6YP2bD21snC8TO2SpuQJIAewtIp4P+u5RWYXH0LwFW0yz2xSie8PWeCIfmI9sIjkfIj6i8AN0izKaiqqYEpcBit8gWpEafSZWsbhEKlOUgmJctPmROBicv7p7bXe1qxf7Nmy71RkJH17kt6tkfVMiaHq0zwQWEyLS2vLMeguIhoPM5XWt4IUIPl6Y0RT2B6LUF8L/Qo4av6UkEw8ejaBnvpdwM4l37mzoA+o/MHPhZmjzfEcqv+kzK6g4rXA+t7w4GJYuAOCNPjuWokrTxHaZ9HLDDlQu7jyzATzBvjIppn2rnhtqWupBMUR3gdIrIY4TNDaboDKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuoO/dvFxmdyK7AA4NNJB6gQhnBgcqUPNrrIguDUCuA=;
 b=jadaMGeh6c94Y9xLEELrqQuJfxZvi2lTBCoetDBI9P4knXfdMxOOxx8XATU5zXDSuSAcf7H7HyVhnXAmYgPjg4qjX+dtGzcg9lyZUwgZ2ANLT1AGKA1u8aQOSGQf2m0YWiC5nOpHRQc5dALOJbF1TeFGGfNx76Q+M10kq1CNt0w=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB8367.jpnprd01.prod.outlook.com (2603:1096:604:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:39:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:39:07 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v7 1/4] fs: move sgid stripping operation from
 inode_init_owner into mode_strip_sgid
Thread-Topic: [PATCH v7 1/4] fs: move sgid stripping operation from
 inode_init_owner into mode_strip_sgid
Thread-Index: AQHYWRxiXlzZQzop/keBoP18JzYMnK0BxisAgAAaNIA=
Date:   Tue, 26 Apr 2022 07:39:07 +0000
Message-ID: <6267B003.3050602@fujitsu.com>
References: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426070648.3k6dahljcjhpggur@wittgenstein>
In-Reply-To: <20220426070648.3k6dahljcjhpggur@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9ed5a33-76a6-45c0-9945-08da2757d8a2
x-ms-traffictypediagnostic: OS3PR01MB8367:EE_
x-microsoft-antispam-prvs: <OS3PR01MB8367ABE76C56F98E109532FFFDFB9@OS3PR01MB8367.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JLlt0CUcBnSOF7WzAiEPmRr4zp+u6Tj8PAVhzDDGPp2FuCxqYcF9WedRl2TiMYmBbrB8tSK/fRL5s6k3ddBsRKurH4/lKj5kReWCQfu+7X0kiNpcsDXIVTfMiCoDiye1NGbbI36cryBZ3blnDMMQGjpBWb89I/JnnencSi1dnHoO4vM6xSmkUP+BNU7ZcC+kOTZyTGDoDXpjsRhUqzULbqaTfs8JiL+vcIqm6t5QuwLl7tZuP3NzZ9dLFLP8fiGHGwmVd1S9UtGzz88JrZWyVxF1gfzMUOTq6TD8hzbHjFidj1o9yRze/pSKggKOjYrDhEfSSrrl4UR00SjSBLCoglC9XfN0Xn+IECH3bgvHZPdTuF6oO6Tfc5pWAmHq33htz18JuAxUqRQudSa/vrjc84MyR4mjPJvX6mUnEyAQ/tCANieZ4kknUBCfH2IavM9m3tMtJdkDzSAO1MSrolGAPJrf2/Jj1cwf9eOWMOhmuTgKLm2RsVPuWlq/wf25lWNV5C/gpS2VYafuA3tyG4OU+AYzc3jLjaJa+bV1/9X+my2pYZCyGrmj9hJDiaLxy2qYhISkcYus020FGqYIASpoZ9FwwLBFEPPNtbQcDMTDEp6Wfh1NKSr/Hf2fbnv+UZAtJBSHsnQiTa9IJFpymIjG8/MSKNsj2XS+DuxRpYXQp8ti3SWSrsBM+/nfR9R5W0/JQHGQ7CCDbL0g3P75rXrdyNU9ebH6QMHz+Yr2uMfsFw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(2906002)(91956017)(6506007)(87266011)(71200400001)(6916009)(2616005)(66556008)(64756008)(66946007)(85182001)(5660300002)(8676002)(66446008)(76116006)(33656002)(4326008)(316002)(8936002)(36756003)(66476007)(6486002)(54906003)(26005)(6512007)(38070700005)(38100700002)(82960400001)(122000001)(83380400001)(508600001)(45080400002)(186003)(168613001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjVCTlZXMUlLSHN3a2NMNWdFTDM0cS9oTzBGcS9mVmFRaFE3ZnBGdE5DczQz?=
 =?utf-8?B?eEpNSEVGNTlDbnZUSWZLajNTMTcxTHNwYm5kdXcyT0VWblVKTThqN1paR1ZD?=
 =?utf-8?B?a1locFFsQ3NxcXVjOFRQMThZcGpUdFpISldFSm9XYzNCQm9oOGpZTVJLamow?=
 =?utf-8?B?K2FJbDFUdmgraW9CZXVMSXA1NFVGMW5oY3JJQk50aFVBekk4VGlRdk01ektW?=
 =?utf-8?B?ckJoajVETllBZlZURko1eXU4OXpBUTBZT0xOQjZaTkZPRHFwSU1ZbGQvRW1K?=
 =?utf-8?B?SGNhQitzaEVuZ2R1ZHFRTDdVZUFkMFluZUY1NUJzL3lBc3JndVBjZ1Zsalky?=
 =?utf-8?B?ZTczTUJWd29CM1pRek10QlVpdWpiL25pTGFHVU5TU0FqWHM3WUQxcnVYQ0pE?=
 =?utf-8?B?ZEVVb01Tc0dXRXF5V1BlNisxWC9pM3pzbDMvdTRjMnNycEsrZGhwcU9Ra0xQ?=
 =?utf-8?B?UCtCLzhTb3h5c015REJpYVZpM2VJU2xtc0huTGp3RG1lM0ZnbThteklpN2t2?=
 =?utf-8?B?SGh3MXV3ZDN4bmlaTWNBOWJhbVE1ZlB2V0d4UEpEMG94aHhoYmxMM21rdURB?=
 =?utf-8?B?Sm1POXpqQ0Nvd3ptczNFbnBYUmgvVmYvQUdhTEtDUEVlb1FCMWNyc2dja2RM?=
 =?utf-8?B?QnhJbVpSVDMwMk5JVHVKNXN4c2Uyd2k4cVhCNEwyVko4dXdPR2NJNThRMFhR?=
 =?utf-8?B?R0lkcDhkMk5yQWRiZjEzZFhxSnU0Tk1xV1E3S1NzSzNVNC9RMjhuWklTNkJS?=
 =?utf-8?B?Y09XaDJ0UGQ4VXRMNjRFUkgvR1owOHMzZS9LbmxOUnJlcWJkd3EvYmdBQ3lP?=
 =?utf-8?B?eGxXQUppRUVzbml1K0tLellmbnBsK0dEc3R5L2RYT2wzMjRrMDJpTVRCaFln?=
 =?utf-8?B?UDlpZzNOK1NWb1VJbTY3ZEczR2FHTG5lZkFUVWd0bHZ6ZUN6QjUyMnZXdEM3?=
 =?utf-8?B?cWdQOU00eGVGUWxIQlhDY29JZi91dHRIZnJKZGo0bi9YZU8yUmM4ZGMwOElv?=
 =?utf-8?B?V3FQYTJENlgvcmdjcDE4ZWR0dEUyRm90ZFMrRGUreVJaTzZ0VXcvV0l1YXR4?=
 =?utf-8?B?YjR6KzUvdXJhOHRzeEI1MjdaK3FOeW1WblVQcUtvRWVpVjcvdUQ5M0NRUG9R?=
 =?utf-8?B?M0hPWGhUOVVneitYcDFSWm0xSlF1VmVyTTZLOUxtSGFhSXJDTHZGa1pzbk44?=
 =?utf-8?B?MzJ1UDhEWkxiSExOUGd6a213R3BjRkhQNzhmZXZrdUpjeW02eWlDU01uZUpq?=
 =?utf-8?B?TzF6M3RhQnBQTVQ4cGdTNE8wcmZlMlNHblRBUFdFbnlEYU91TWZKdXliWFNa?=
 =?utf-8?B?MGRZV21MTnpUbmhnaXZ5K2tGQTgzbm9SM0JQWmlRbWFQUkZZeG5YRXp1a2hI?=
 =?utf-8?B?andabGplaEZFV0gzYkkvWmlHRGs4VGl0QWQ3a2NoREQ2a0ljSE1vWTVzdG95?=
 =?utf-8?B?T0xRcjNFbmcwUWVVcGxKTlZqZnZOM3BOalFYdEJEbVE4U1dKbEtyM0hpeTAv?=
 =?utf-8?B?Y1NzS0tXV1Z2QUtjVHNrNUgwa29ZODU2eHJGSGR1WVg2YWJXdFdVNWxPNVRr?=
 =?utf-8?B?NVlPdEhJUGxiRE5vcS9pMHBtQzIxU09XREZvYUlpbmVxclhaVktaMzloazNp?=
 =?utf-8?B?aGFUSlpIaXdxNER0OUQ3NkxicVRKaUxCWElGZXFrdEowZW4yM1I5RnNmc3FX?=
 =?utf-8?B?QzgzeisxK2NNbWpJVVhTVzQ1UitGVnhrS1RqbEs0MU9ReW02UVIyOU90czFM?=
 =?utf-8?B?MXREMTY5d1BmbVpKZHAxRHhVYUw1V0hGYmMzdFdVOCtwK0UzZHNmMU9jaUNj?=
 =?utf-8?B?TlUydnFGNUxTNlc1WDFJbzd0TnNoRGVsbERlZkZaMnROZkRVSFl2S29pRXlp?=
 =?utf-8?B?eWRGMFdxOC9JYmxVU04wdUxKa0NrbU5KdjlvOEQrMWJjN0g0MVFvcStZOGIr?=
 =?utf-8?B?N2VKRm1ta0JVM01kRTcxL3EzcGNlbkFHbzlVbGZac2YwVnJ2NmVQcEc2cDA4?=
 =?utf-8?B?RnVKQk9HSXpiUmI3RGI2Y2doVDN3RG1HRnJ4ejMrcXVDMk1zZlFzclNWcTdu?=
 =?utf-8?B?VEhER1lUdkhRZjZpWmlkZjF0NVByVFdRSzZUbjE3UHNUQlVIR1lzajZrUE9O?=
 =?utf-8?B?L2RvSUowV1VDZEdkSE9HU3pBeldHVCs0cTNla29JOGN5c2Jram95TXdlK2sx?=
 =?utf-8?B?cmhIY0w2dzZDRGR2U0hiaXBYTUE1Y05nZC84RmM0OWllMVZmYW1xVmtqSU9n?=
 =?utf-8?B?QVBaNkdnOWJJVEF4UEhGdm51UEZpTmZKK1hmejBMVlh3UXVFUjZwWjVnenhV?=
 =?utf-8?B?QXdHVzNiNVJDaHlYdzYxUTJjVkV6K1ZGeU0rdjB1NGlOYVJMZTFvTHJYdGly?=
 =?utf-8?Q?Fj2rnRBvsZ16JRUMA4mkuMcmgMx4eXIGxxcZQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F986596A99F7C4A873FF8B393EF9F96@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ed5a33-76a6-45c0-9945-08da2757d8a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 07:39:07.6206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hIPvTcjkhiI+JyPMOCTzAnToWNIMvcDho4EVLoYDRytlrmVDvL0ASRWtHvIWnvFqWplWe2HTovDCIzWImRGKNVMFm6HVxRIaRjy0t3oWPwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8367
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI2IDE1OjA2LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVHVlLCBB
cHIgMjYsIDIwMjIgYXQgMTI6MTk6NDlQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFRoaXMg
aGFzIG5vIGZ1bmN0aW9uYWwgY2hhbmdlLiBKdXN0IGNyZWF0ZSBhbmQgZXhwb3J0IG1vZGVfc3Ry
aXBfc2dpZA0KPj4gYXBpIGZvciB0aGUgc3Vic2VxdWVudCBwYXRjaC4gVGhpcyBmdW5jdGlvbiBp
cyB1c2VkIHRvIHN0cmlwIFNfSVNHSUQgbW9kZQ0KPj4gd2hlbiBpbml0IGEgbmV3IGlub2RlLg0K
Pj4NCj4+IFJldmlld2VkLWJ5OiBEYXJyaWNrIEouIFdvbmc8ZGp3b25nQGtlcm5lbC5vcmc+DQo+
PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgKE1pY3Jvc29mdCk8YnJhdW5lckBrZXJu
ZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3Uu
Y29tPg0KPj4gLS0tDQo+DQo+IFNpbmNlIHRoaXMgaXMgYSB2ZXJ5IHNlbnNpdGl2ZSBwYXRjaCBz
ZXJpZXMgSSB0aGluayB3ZSBuZWVkIHRvIGJlDQo+IGFubm95aW5nbHkgcGVkYW50aWMgYWJvdXQg
dGhlIGNvbW1pdCBtZXNzYWdlcy4gVGhpcyBpcyByZWFsbHkgb25seQ0KPiBuZWNlc3NhcnkgYmVj
YXVzZSBvZiB0aGUgbmF0dXJlIG9mIHRoZXNlIGNoYW5nZXMgc28geW91J2xsIGZvcmdpdmUgbWUN
Cj4gZm9yIGJlaW5nIHJlYWxseSBhbm5veWluZyBhYm91dCB0aGlzLiBIZXJlJ3Mgd2hhdCBJJ2Qg
Y2hhbmdlIHRoZSBjb21taXQNCj4gbWVzc2FnZSB0bzoNCj4NCj4gZnM6IGFkZCBtb2RlX3N0cmlw
X3NnaWQoKSBoZWxwZXINCj4NCj4gQWRkIGEgZGVkaWNhdGVkIGhlbHBlciB0byBoYW5kbGUgdGhl
IHNldGdpZCBiaXQgd2hlbiBjcmVhdGluZyBhIG5ldyBmaWxlDQo+IGluIGEgc2V0Z2lkIGRpcmVj
dG9yeS4gVGhpcyBpcyBhIHByZXBhcmF0b3J5IHBhdGNoIGZvciBtb3Zpbmcgc2V0Z2lkDQo+IHN0
cmlwcGluZyBpbnRvIHRoZSB2ZnMuIFRoZSBwYXRjaCBjb250YWlucyBubyBmdW5jdGlvbmFsIGNo
YW5nZXMuDQo+DQo+IEN1cnJlbnRseSB0aGUgc2V0Z2lkIHN0cmlwcGluZyBsb2dpYyBpcyBvcGVu
LWNvZGVkIGRpcmVjdGx5IGluDQo+IGlub2RlX2luaXRfb3duZXIoKSBhbmQgdGhlIGluZGl2aWR1
YWwgZmlsZXN5c3RlbXMgYXJlIHJlc3BvbnNpYmxlIGZvcg0KPiBoYW5kbGluZyBzZXRnaWQgaW5o
ZXJpdGFuY2UuIFNpbmNlIHRoaXMgaGFzIHByb3ZlbiB0byBiZSBicml0dGxlIGFzDQo+IGV2aWRl
bmNlZCBieSBvbGQgaXNzdWVzIHdlIHVuY292ZXJlZCBvdmVyIHRoZSBsYXN0IG1vbnRocyAoc2Vl
IFsxXSB0bw0KPiBbM10gYmVsb3cpIHdlIHdpbGwgdHJ5IHRvIG1vdmUgdGhpcyBsb2dpYyBpbnRv
IHRoZSB2ZnMuDQo+DQo+IExpbms6IGUwMTRmMzdkYjFhMiAoInhmczogdXNlIHNldGF0dHJfY29w
eSB0byBzZXQgdmZzIGlub2RlIGF0dHJpYnV0ZXMiIFsxXQ0KPiBMaW5rOiAwMWVhMTczZTEwM2Ug
KCJ4ZnM6IGZpeCB1cCBub24tZGlyZWN0b3J5IGNyZWF0aW9uIGluIFNHSUQgZGlyZWN0b3JpZXMi
KSBbMl0NCj4gTGluazogZmQ4NGJmZGRkZDE2ICgiY2VwaDogZml4IHVwIG5vbi1kaXJlY3Rvcnkg
Y3JlYXRpb24gaW4gU0dJRCBkaXJlY3RvcmllcyIpIFszXQ0KDQpUaGlzIHNlZW1zIGJldHRlciwg
dGhhbmtzLg0KDQpwczogU29ycnksIGZvcmdpdmUgbXkgcG9vciBhYmlsaXR5IGZvciB3cml0ZSB0
aGlzLg0K
