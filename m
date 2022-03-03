Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110324CB9A6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 09:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiCCI4f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 03:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiCCI4d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:56:33 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3B531768F6;
        Thu,  3 Mar 2022 00:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646297749; x=1677833749;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uD24xLr3b5lOoj+/2R+LOjPt2V/czg0NMXhKoC5diN8=;
  b=TRTneFZaLLDkr6Z+gYBCnkLO4X7jutXDRzZ64AFAxqSeTYTHdoqXxMMV
   eA4dt3yEnONLeqFBIqDIoISEXUbnzcLr0XU4M0qvShte+Qho+hnvA7F72
   PGjUgepgVn4ZePLQ9Y7jhknmbslS9iX/ZfHuBIwPpWgzGB43Ap3Gg5cm0
   /qxA+ZBGBdvzIa7p5rybVOwhW4cKugrbcWjs6WZaejhErbswtlh3aYEcf
   s/4LKd64kIyv6h5FHrw1UZTvypkZAyMYoBZYh2TgVeig0Sp0en9r+I0zl
   pCtEhHUCQ7lx6g94eEG1jglb5JIru1hDQS3BPTVlt7J+DWHHNzapn0iUH
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="195334794"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 16:55:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9w6ByhHmUGaBJkKlx96+jZeugxFQzol9TmR5dv7P+SKgnnUdIBdU4WTivIdgBzlY0fi5jXs32pJ6WmW70XaA+0GIc7pX4I7Bz1RWfBNtRVaf15Yju20Iky7hoNwSAp0ofn0A4b8y8zw/3RZnL93uq9ychuvKKmJFUF8z8/QNVittUaW2I/q1Zcr98f6u2EV6DxH1vBoRiUgt0xxUoHhEz/AW50cS6tl615ku1H1qWknzxjGZevgSnVf/ewcd3Q7auD5L3HdcKAGJsPTztAcnoYK48ilpOOPg0i2DUAPq/0Z3ozcK2h3WEnS+cCQZY7qwuXGCb4RQSP+jpKYWI2yRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uD24xLr3b5lOoj+/2R+LOjPt2V/czg0NMXhKoC5diN8=;
 b=MEjDtj9sSyGKmEbqIpp+LlkNAMots/F9oJDGeRGqRXnSyiWMExaZO8zJO9HI8F0HH8QtTAEV1JItgYBe5AoRItHbtci6htQRCD4Y5PwxEs+RUccjaUNtXd97It6sfLd6aI9jJRbSB/YvNqsN5+t2hVhb48IJtmvQ1dO2/9V3x7f8cFdnLeCKXfAgObK8aOOC/A8X7GZLQmKFX2gXQYIfc3WPTingxgmRyWKTVl4/VKaPab7QiC3p1QFw13Bb2ZbcyBqD+CLgVcGR8QGsqJSWyKT8SEnpRWfibKYmJNCMO3nb5wHkxLgGpSgvGnyJJXIVPwaCeHcuWdL4SAnMzGhNfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uD24xLr3b5lOoj+/2R+LOjPt2V/czg0NMXhKoC5diN8=;
 b=mw27t/U/GgCjxr3D9ddtfOKRLbvvTaU3p1WL3ZGaB30+DHdNHc+xB3VvIIwQTWkrCk/YFF34qf5Wjt3KqQBa3uYpote/p+8GMWW4necJWT42fFccWUMlFPxh3Pu/YNergvk3hn1oWr/tdetp0qioRMpYNu7GH0vdRt5RxtxTGBo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BN6PR04MB0484.namprd04.prod.outlook.com (2603:10b6:404:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 08:55:45 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::c8f4:8499:a5fc:1835]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::c8f4:8499:a5fc:1835%3]) with mapi id 15.20.5038.015; Thu, 3 Mar 2022
 08:55:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <Matias.Bjorling@wdc.com>,
        =?utf-8?B?SmF2aWVyIEdvbnrDoWxleg==?= <javier.gonz@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmd1Ny4qtE3bUeyZ6TIm7TKKqytQVkAgAAaYgA=
Date:   Thu, 3 Mar 2022 08:55:45 +0000
Message-ID: <ee09e58c-7b1f-b36e-311c-45fcdbfa5718@wdc.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
 <3f54a0f2-03ae-2d12-8ebb-b6b8a61cc8a9@suse.de>
In-Reply-To: <3f54a0f2-03ae-2d12-8ebb-b6b8a61cc8a9@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dada018-bb48-4b21-b6d6-08d9fcf39b09
x-ms-traffictypediagnostic: BN6PR04MB0484:EE_
x-microsoft-antispam-prvs: <BN6PR04MB0484E0C47F1A41C36F30D6CBE7049@BN6PR04MB0484.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uG699rGXM3Px0H/U2CrRPiIsDWotnzbhCl3MAcX/fKcmXxVBrn6KrEdN9perJJ8RmeGxEzwZD6QSzRaZiqDR5qzS6pG84OWOdJGz3LpG5WVBbkPmPrAJz9ZQ+YGyXs2UE8Aw7RNWzybh+PCUQAx12lLnfnGfaifGq89NYCnzAMum04pepiSxzFiggKat2VuQ7jqtbmeN0oqvebxrLjldPuBmAPMSXoLgJyxjljyuPPCDmFM7NOWdTGETVPFo5UvJ8UuoPkyMvZXO2CUD2owdkjLANlvqWZJclaxUcehFAEcUMjZ47I7p8zmjrchq4wClxJ6zg24h3DFPY2hr+UrZXEgJFjmalO+AhH56vs1e2PM6uvIVrAnb1btZKqsZ62GUwbPIEaj3v5Hg/2rHZ6OWTsoDfLkArkh4xwslR26iXf3l8i8RlOksPrniZWPOCMkbKjQbsMtfVgW6v/9gvxu+tIlOSxd1JdkrKnob88/BSOgWg+1nR/pcfU9GdW7vi3YLtF3pPaIeH8NZCVpn9GvdtdJ7nryvaPHbcQ4bbLrn+/kd5AuLiudMDRq5AfELsi69Z+Pg6x7EFOtR0e7FyHhOw8Rmte6FleTdhVd976zIKvTsiVfj+/eSvr47MmcQ7Rph32oUMXliUnGT3NXMs7ynJgk6WGLK7XSD5l0SRCp8NXLup0iV65cx8ln2kfr4b92OTRnlrX2VTXIxrodPcuyVIhTr3eGVAQAnaxcu4pnuo2QUZmsgfLjS2x9+7WymW9lKt1SujX5vjgNiEWuL/yKJsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(31696002)(2616005)(6486002)(66946007)(66446008)(66476007)(66556008)(76116006)(86362001)(83380400001)(64756008)(110136005)(54906003)(316002)(186003)(26005)(4744005)(8676002)(4326008)(7416002)(91956017)(38100700002)(71200400001)(31686004)(36756003)(6512007)(38070700005)(53546011)(8936002)(5660300002)(6506007)(508600001)(2906002)(122000001)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTViZ3dHQ0YxVnNBNEhWVjhvTysyUU5DWmdUeGNXam5zVmhHYTN4UXZuekMv?=
 =?utf-8?B?RlhaZ1FBS2QxamlwQ1h3Rnl0MjNSVG9ud2tFQnhEOUV0c0dhL3Jhd3VsS3g1?=
 =?utf-8?B?VjBTbzlzald2dVBCMEd1Yi92emxIa2RvSGJ1WW8vQkJyc1hMQ2E0TjNrMlIr?=
 =?utf-8?B?OGdFeW4yNS80SmV4THg4dWIzQzBDM0xNNGQ3VkJRYi9Ya2pKY01WTE4rc1dU?=
 =?utf-8?B?cWptK1dmSlFxY29kYTM4UjBXdW5KbFdYcVJUVlZMcmhQekIzNHQ2NEsxYTdR?=
 =?utf-8?B?d0NTS3RxbGlTeHVBU3ZMWEtvaC9McGo3cFNGYUJoMk0xTGhMemJXUzROcjRi?=
 =?utf-8?B?b2U4eGZTZEJvUm1PaXZ3SnV2MXhUeG85b1ZQQ0tTWU02NHhmZ1ZpTVRWSDEv?=
 =?utf-8?B?b1Z4aE96TTBEMVNWenV4ZER5ZXVlSm9pQng0Z0cvbEJlbjUzNDlmMDdGMmkx?=
 =?utf-8?B?eFlJUVRRd3MrWHBXM1pQVUVnQ0hiZ3VySzBaQ0E3RjZmeWlCMVVRVnBPWXEv?=
 =?utf-8?B?bUJObFJxMzNVeFJtczN3WVpVaTljYkFhWi9sMmV2aEExMTQ4MHNMNENtakFN?=
 =?utf-8?B?UE90R0s5VDNacUtZd3pvaG5TZTZwcTBLZXMvUXFDT3pHTmVSbGNUTUJralVr?=
 =?utf-8?B?cjE4VGN2WC9xamR1UXBQV0RocWo2M1JlM25Hd2d4alR3V3l0LzVWUTdZb2h6?=
 =?utf-8?B?eUdnbUswQXBYSDR3YkpXMktaVUdySzBNYXNmMHdvR3NFVFM3V2UvM1RCZko0?=
 =?utf-8?B?N2k1YTU0QmZhejl2aXpEd1Z5YTF1TkRHQ0s2VXBMNWFrQy82dmZORjZYbTFM?=
 =?utf-8?B?SFZPTnVZVFJPYUcyaWx4dmlzTVVrSlQ3dmwwcTMvMXpWZjF2akZncC9WVEdt?=
 =?utf-8?B?R1RqZ3RzaVN1b3Q3OHJUZVhGSDg5ZjVnNzl0MWZBV0tNcVNFRkFwK2JvRjdn?=
 =?utf-8?B?MzdIQXZFVnJlM3o3emhueFVzZURIb1pJQXZVd2ZzQXNDa3Brbm0zVmlLZUFn?=
 =?utf-8?B?NkdCWkk4SGhRaXBoU3pJQlJXL1RIN3JaQWVMbjYzSVFSUE1oS0lIbmsvYncy?=
 =?utf-8?B?Nm1GenNGVVduYWIrYUd3VVFpNDZtQ2w3ZlJ3Y2d5S1h3Ulg1RjR0OWFGOXRy?=
 =?utf-8?B?YVNKRVVyQ1dVS1FMNWhnaVVKMisvZTRwbVBERkpQckF6STEwU0NvRm5qSzFB?=
 =?utf-8?B?V0txSXpRWmtEZEQvQVA3ZmdqVGdlV3lWeG5QMjdJL0xvTkdVSWRpT2gxOG42?=
 =?utf-8?B?bHVyRENzVlQrZ1VFYzhaS2hYN3g1TlllT3hrMGg3dkRqYTFHTCs1SzFCc3ha?=
 =?utf-8?B?dkNINUdTNE84V1k2clo0SWZGUGJyekdDK2VkaTljaFZ5M1VKdkZsWUpOakgr?=
 =?utf-8?B?RzdSdWJyMlJERWF0VnVYcERxemhDY1F6SUhmcndXRTUyamQ5TGtBVnBoQkt3?=
 =?utf-8?B?ajN0RnRQanpQdVR6MmNsL3JJZ295cXE4Y2ltaUtsTTV4bGg4OGJVZFZpUWF6?=
 =?utf-8?B?ZVBnbnZlOEJkQnlJVEpjSVdxOVJnYVdUMksxMmhsUUxYcU9zbU15QlNhSHAr?=
 =?utf-8?B?dUV5bjd5ODduZ3lOYnJjUnhyRWl1NXFYMkdSVzkyTEhxN2h1ZFpSYWJtTFNR?=
 =?utf-8?B?dFpwMTRWNlJpMzdHMnI4MXhRd0ltYUd4YWFYTjZFOXJ1TEZSQzBxczlPc1pT?=
 =?utf-8?B?MzlkVU1DU2V6UFJCc2hKRHNGSjMweXk2d2JLNHgwNmw2VDFjZGZ2NDJWWWM3?=
 =?utf-8?B?emdyY090bzg3bFdIblFpYlU5d3BVTzJoU3h3bzFIbkdXRnYzMGZuN3ZJU1k1?=
 =?utf-8?B?OEo4Rk9MMTY5dkQxM2JvWFNmOGNXQmxnRG82YjlmNHc4dzVNR1l6azFHV0hv?=
 =?utf-8?B?dmtIQ1NJZDkvOFdTOWJLa2xkTFU4bXFZSWdneWVGd1pvQmFoWWExQ1VwV2hL?=
 =?utf-8?B?TFBXVVJXNDUvN1h6ZjdoL20xQXQyS3Q2dzJoZHZhczYybGp6YWM2WE0wdk01?=
 =?utf-8?B?QzRnWnJ3RjFNc3Y3ZzZRcjF3RjJjL1FTSURLR1lhMnpMUWptVVk3Wm51aE5m?=
 =?utf-8?B?SDFiSTVMeFpTanloblBlbjl2bFVJQk1pTC9FYlhDWnBRUnRuY01Yd0FXZHo2?=
 =?utf-8?B?NDN2dVVsVU9pR01jY29CWGtRanJFUVB3ZXI0M2dUN0NPdzg3NnFwcW1EbTgz?=
 =?utf-8?Q?kJkxQcA9WL1UrUjK5JnRWQf446SnGePeLt5QFGtD0i6b?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7E7B6C6952CBB40A10AD42D324A9E79@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dada018-bb48-4b21-b6d6-08d9fcf39b09
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 08:55:45.7056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wNA2aXmLiYZxRwdy77SX0fwp0WdZOlrgbI3hiEjtWaa8tW6ZIgAxwxB8SGrP/xDZsv28w/eN5gJgqsCfUKZyLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB0484
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjAyMi8wMy8wMyA5OjIxLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDMvMy8yMiAw
MTo1NiwgTHVpcyBDaGFtYmVybGFpbiB3cm90ZToNCj4+IFRoaW5raW5nIHByb2FjdGl2ZWx5IGFi
b3V0IExTRk1NLCByZWdhcmRpbmcganVzdCBab25lIHN0b3JhZ2UuLg0KPj4NCj4+IEknZCBsaWtl
IHRvIHByb3Bvc2UgYSBCb0YgZm9yIFpvbmVkIFN0b3JhZ2UuIFRoZSBwb2ludCBvZiBpdCBpcw0K
Pj4gdG8gYWRkcmVzcyB0aGUgZXhpc3RpbmcgcG9pbnQgcG9pbnRzIHdlIGhhdmUgYW5kIHRha2Ug
YWR2YW50YWdlIG9mDQo+PiBoYXZpbmcgZm9sa3MgaW4gdGhlIHJvb20gd2UgY2FuIGxpa2VseSBz
ZXR0bGUgb24gdGhpbmdzIGZhc3RlciB3aGljaA0KPj4gb3RoZXJ3aXNlIHdvdWxkIHRha2UgeWVh
cnMuDQo+Pg0KPj4gSSdsbCB0aHJvdyBhdCBsZWFzdCBvbmUgdG9waWMgb3V0Og0KPj4NCj4+ICAg
ICogUmF3IGFjY2VzcyBmb3Igem9uZSBhcHBlbmQgZm9yIG1pY3JvYmVuY2htYXJrczoNCj4+ICAg
IAktIGFyZSB3ZSByZWFsbHkgaGFwcHkgd2l0aCB0aGUgc3RhdHVzIHF1bz8NCj4+IAktIGlmIG5v
dCB3aGF0IG91dGxldHMgZG8gd2UgaGF2ZT8NCj4+DQo+PiBJIHRoaW5rIHRoZSBudm1lIHBhc3N0
aHJvZ2ggc3R1ZmYgZGVzZXJ2ZXMgaXQncyBvd24gc2hhcmVkDQo+PiBkaXNjdXNzaW9uIHRob3Vn
aCBhbmQgc2hvdWxkIG5vdCBtYWtlIGl0IHBhcnQgb2YgdGhlIEJvRi4NCj4+DQo+IFllYWgsIGNv
dW50IG1lIGluLg0KPiBCdXQgd2UgbmVlZCBNYXRpYXMgdG8gYmUgcHJlc2VudDsgb3RoZXJ3aXNl
IHdlJ2xsIGp1c3QgZ3JvcGUgaW4gdGhlIGRhcmsgOi0pDQoNCkkgd2lsbCBiZSBhcm91bmQgdG9v
IDopDQoNCg0KDQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rlcm4gRGlnaXRhbCBSZXNlYXJj
aA==
