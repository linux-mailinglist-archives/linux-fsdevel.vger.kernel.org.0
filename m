Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AFB574ABC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jul 2022 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238417AbiGNKet (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jul 2022 06:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238393AbiGNKel (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:34:41 -0400
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6ED74BD31;
        Thu, 14 Jul 2022 03:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1657794878; x=1689330878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AL+n3rpchvxeHAWcuSYVma9eU5v5v5BPE5FiFPQHoIU=;
  b=L3WMTyIaRyoTdEbb1g7VqxVk++kNEmX0hldqQTXgOI7Cv3PkjjOE7kdd
   TgQfUofVFP7IE7iTrF5P050R11Is8D3lW8b+Aog9NiqkTwAbjmJTVi/d5
   VqdHonFmNYo/9xHNy8P2UeABn0Ba4z7Wc/eIelvOfN9XZeeG9oHd86GA3
   DZ+/i2zZ0KvPGfNrRV7jCmvl0wnxOAunjzBNSnW9MCyVaANZ580pU+6Mf
   GxcUiuj+bKeRqdaJRVd5ntv9GVrzgvlnf8fXKU9z1OXXLQpey2y6+xsa9
   RBZLm1kcmDYv93q5NXxnTbSk8l7Ktzn3gs2Ol+Heex+Qir53Wfqimdpx1
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="60417266"
X-IronPort-AV: E=Sophos;i="5.92,271,1650898800"; 
   d="scan'208";a="60417266"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 19:34:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjUFhrpCqarok3ie7/+fD7Vo6opIEFTIZf56oTn3cFUmySm7Zl03B7OgnXmy5NoSRdaswX6OJ4TY4OszHxTncueq+RgLU19SiTpEBXYltNgQOZHMT7ZQFci4nuNkMEd5fQsQSL3f4/i3OxPjpy4q0uBaqgGv8Ge5+kN7zwzmvRdw2SnX1iVRCmIqpMhFbVa1/LEjW5zleOinz7n/hLF5H4MThfe2X86STkzb1XZc6SC3l7qWKJ2wQFmUIxegh29AHJb36T1Nx0dpwoIZEZRJXZdoCghZLLp0Q6Qi0zkeTeZEP9dAHn7IPKHcb8jMhnFm/1QgePHs0jR+Q0GNhhCrwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL+n3rpchvxeHAWcuSYVma9eU5v5v5BPE5FiFPQHoIU=;
 b=dxWP6uxOt29RUZn+tu2l3j+DysWUqoUz5yQXsTUVW568Q+ekgsP2stn7SgcwLdtXTo17JQ5NbCan1A7NooMQQGRDy1ryJN0obLg/8KVt2sH2ANyvaQPz2Z5wvyGx7U8jjSQF6+1cUygEGgzlaN5SxR/jhygafoGLI8xnrNHdaRd+7za2oj9GRL8Az9jv6tZOLMBCj9fx0lk2okI9iGhdne1HNFYzNj69SHiXiUdwTSCleNsGUqnXzbsWe/HG6ZL2/NVQ14u98VZVbsQphb7tKoIM5iymfRC09XpjVmaKxP4Kpvu/4EmYZihVxhOuhQm3PbHQ2AinGF4UgARVVLEurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AL+n3rpchvxeHAWcuSYVma9eU5v5v5BPE5FiFPQHoIU=;
 b=Qe8S/WS5o3Fb/9HkduE1qYOxTHisUXiLlYcAeJ8fFhj/WM6pXG1mb+EZcS9i45TBjbsK+noECuocEj6LYrx6AEOscTrrWTmEsCMYWhSpM2fTV+L6ijn6EZGPwhV//LbYtBHLdpL+p4icvtyBpkqvj9j3p+Ljb4W+be4zAFFr2iA=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB5685.jpnprd01.prod.outlook.com (2603:1096:604:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Thu, 14 Jul
 2022 10:34:29 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::ece2:4ee0:93a4:ce47]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::ece2:4ee0:93a4:ce47%7]) with mapi id 15.20.5417.026; Thu, 14 Jul 2022
 10:34:29 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Topic: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Index: AQHYl21MSZyYmdiLqka88bTs8k0Skg==
Date:   Thu, 14 Jul 2022 10:34:29 +0000
Message-ID: <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
In-Reply-To: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.37.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de819951-3121-4655-86c7-08da65846ee8
x-ms-traffictypediagnostic: OS3PR01MB5685:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QRmZNgku170Y7u2dqsntP+u4RY/lCvWSdExR3U25yfupzjunPl2h1fCxMTnCllHPRZzZQjMH+r2zkzoKntqfmEXtN5JcAd9zj1ZknZqlAlZs3z/ppORRUWMAmhiIKkAhX4wEw1AiHfrTCu5o5od+HFmdXRvvBtbN1sdrKhol2wFMyU4jX0tOFpWWp2c40PJaXqf0FEDLH9XUD4uk5KFaChUoRCASn9jibAD/RApltLCACfSC/iC1hRCbi80V4nIVkbIdTKuodQ8CepBin9/uUjFy4m5LcE0H56LHbMjFoYlfs0KWkmc+0olzPlVzVdyS6ZHovHafYI/NGJK4zdBwZ1wLYATMH0/XRL3znfRTrqIGsZ7sRBrdhsEYghQ+D0FTgSo/da7ceJbqURzo2PidQgR7Ef6Bf2ohYbtRBW9PtwbZ62TZfMUFMadNWC0mloHFo9l6qachvTOtybI2ZdYKD/jxMU2y1fl2nQp27SIjbbVNsYiXTdwCDolPau/HPrQhDfXstw/lrNZqYtACtyofhfa8aPYIggNbinfRGgTmL/Oc7uMjznxGvBRt4KS3hxtGdWmujgxoi3ejwQPsadFrfLMLEHi95NhkFezXmb4l8vTxLmFwrFxp4N2ODBSyydskAP8uKoBk9ken4twfnrdoV0/u6LfVLiarsmHu9r/3YeSqSa7t9nqH0Vi7sZt5O6ofNbtkQAm3D+H3oVuIA+vaMbkBHHIW10VyudKjXAMzmFyThytaencIdn7iuBqR72/OH/zmfeEgNEdagmzZsL1kzXD9dIfMzq3TIeRkO0DnvzFk2G4IpjlqPhsKYGTnGK/IKpexoa5lItx47B4884F7RBgfYIWgm1KfIHZqiUJYJIo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(396003)(366004)(376002)(66446008)(1076003)(66946007)(4326008)(66556008)(8676002)(66476007)(91956017)(6512007)(83380400001)(36756003)(2906002)(5660300002)(186003)(85182001)(76116006)(7416002)(8936002)(64756008)(26005)(71200400001)(54906003)(110136005)(86362001)(82960400001)(478600001)(38070700005)(966005)(316002)(6506007)(41300700001)(6486002)(2616005)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?TXVTZXBsZjhKZnp6bHAvV1hJbDhqV2d4OCtWb3Q3a3hlUzRiUjZjbTUwODhp?=
 =?gb2312?B?LzVyOGtBTjZZRnpqeHhmTFJMZWRPdDBVRk4zREVsd2VwTnIvaVZDbTdkN2tP?=
 =?gb2312?B?czNPSktWeTNDbTNFckZvWTBVU1pyUVRacGhQN2tsZFRjOFYwanFNMngzdVI2?=
 =?gb2312?B?aS9MQmcxclVsNjhSYWM5UndZdGJrM3NaNXBJM3ZteTVxVlFUMGgyVnIvU3dC?=
 =?gb2312?B?NldTMHQ0b2ttWWZZL1Z2T3U0NW1NM2RXZ0orS0FqZzhNcmxaLzFtQzJFWnVu?=
 =?gb2312?B?UzNxT2RUQ0UvTUdmMU5valN0Ym1mNHlwOFlWM1k5Q3NRU0s4akwxbHBBS2pj?=
 =?gb2312?B?cjBxR1Y0b0RQQmRWZ01JQjE2MlE1aysrTkpKTXE4MVNrM3p6aUxEVFhzK2ZD?=
 =?gb2312?B?VStYODNjVkx1L2RiKzNYbVFpUFNVRmFZTVRVR1FpK2dKdnBMTHRWeEF3ZFNh?=
 =?gb2312?B?NzYwUmxqdStvcndEUHJhK2pIVlJZQkZ0Y3hOWE8zNnhicjY2VEEwWHN4aFJM?=
 =?gb2312?B?czA1Y1hVbjQ1TU1rMDVYMVVZQVJzUkV3NHRGaDYwcDZ5bTY5ZGt4YnYvUWJV?=
 =?gb2312?B?MEk1dFcyajZSL0pLYXMrcXQySHZjcUh2Tjh5Q2REejVmeXhPcTNDR21xQ0pm?=
 =?gb2312?B?Z2gvcStUL1hhZTZZMXU2MjNtZG5URys2a3IrZUZHeHFHUXpmVFlWR2d5ZzRa?=
 =?gb2312?B?YzdSTXoxVXEzSFQ0T2Jza1kraHRqUGk5aUx3elJVNU9XWHk2Z0VSYVo5bWRZ?=
 =?gb2312?B?MTYrUnpRY25mMlZBM3F1dzVqZlVZdTVKWlhEZzZlbVpYOWhjb3pER3EvaTlo?=
 =?gb2312?B?S2d6R2VqQ2x3Wnl6RjNqdUs3blc1VzMxN0VIVWNMR3lVNDRVN2xqTFUxR0Fa?=
 =?gb2312?B?NzhkZkhaeXBQa0Z4M0pFNldlajNueE1VZGo2TUF6LzQvZFNsNTl3NVNhM3VN?=
 =?gb2312?B?VDB6Ymc1cVM0NXBQSUV5UENaT2k4K2RKQ2NLMlVveFBna3FvQXczUGRLcmRW?=
 =?gb2312?B?cmNWOUQ4Rkk2OVpKTHZYWlpNVDVXNW05Z0pmbkhWTWlZTkV3VGh6Wkc3N0tB?=
 =?gb2312?B?KzhrTHB2VFo0TllxaFpoeFlrVko2YmxOczJkZkJYRU9VU1Yya29oUlhDY0o2?=
 =?gb2312?B?SzIxSjJHK2puWDA1eG9xRCtCSWVHZmVJcWF2WmFxWnljNUNHUUtHd2h4aEg1?=
 =?gb2312?B?YjNiK3FWZHVtZzltUDQzNHY3SHR1QVhrOXJBT0pPdk43b1FtYjhqRS9VZHZn?=
 =?gb2312?B?VllTRk5SSVJNNHR5dmx6SmY5QzF4Z0Y2R29kZ3lydjYzeU0wVG5iMVpjbVZR?=
 =?gb2312?B?OE5Cd21lTys0TDdNREFZMmlCSlRDMS92MkZVMjd6cUlGZVB0OHh1ZVRUOFlI?=
 =?gb2312?B?ZEs2YmpNZ2RLd0U0My91Q29GN0hvd2Z0L1ROVERYVndlWkUwdUVkYVZ3MGhL?=
 =?gb2312?B?NllNdEYyWjRrUXdPRCtDK096QTEzTHoxemNtdVI2Y0hvc3RUR3R6N1M1d2l5?=
 =?gb2312?B?VC9LVk90RitaQXZVWlNDWG05ajFZKy9MdXAwUEo3UTl0R1BIVytjNldNdUVp?=
 =?gb2312?B?NVZkUEh6dHZBNG1HWnJyeHAyYmU1VUZEZXAyeDVBSXJYclYwWllyNVF2YVB0?=
 =?gb2312?B?NkRZS1pyNkpId1V5L3NYUDhkNjhOYUlNNnhSQVpSbThJSGpzOTZXanZDZVFh?=
 =?gb2312?B?djFwWlFJeVlnZytFUmZsVjhzWHUzZFZTdTZCSFZsMWs2THFNclNsR296VEts?=
 =?gb2312?B?WEt2RkJqNVFaUUJGSWxZcTZob3JyUGJmQTJKTkNQUGtvZ3cyMzMwRVdKcXdS?=
 =?gb2312?B?RFl2NUlPbXUxVlFmZGRMSS9DWCtTcVRnbVp3M0J0cDZQNWJCcktCcldNYlVH?=
 =?gb2312?B?aWhiOWxobzBucFlYUTNuRnd3RDZURkthUjJUNXBPTnB4QlMwTGNuRE1aaEVO?=
 =?gb2312?B?VWtyQUVEbEQrWjF1K0JOakE2Q0dVWUUxaGN0S215VW5hVWNmVnFneXEzUFVu?=
 =?gb2312?B?QllVajJNaVlnaFl2QWJCY25tRGQ2QU84bzdsZGdEOVpUT1NyVExDSTdpY3pN?=
 =?gb2312?B?Zi95eENiVXNwWE5IbnB3SGcvaCtiSmJpbncrQUV3MVAxbm5zYzd1N25tSGxH?=
 =?gb2312?B?MGxjaTVGaUYyOElTNTVBVE5pYmVaMWJTaHM0bUgrVGJJOXVPNGQ5Z0dIMDJP?=
 =?gb2312?B?dVE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de819951-3121-4655-86c7-08da65846ee8
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2022 10:34:29.6542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Th+v/LRBfwuyWvqBebMp4QnqeCgGkhWgcYYjFDUpHi05+7kznkeCeXyxdTIsZ+4pGWH2gQACTrXK9K+tFrfiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5685
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhpcyBwYXRjaCBpcyBpbnNwaXJlZCBieSBEYW4ncyAibW0sIGRheCwgcG1lbTogSW50cm9kdWNl
DQpkZXZfcGFnZW1hcF9mYWlsdXJlKCkiWzFdLiAgV2l0aCB0aGUgaGVscCBvZiBkYXhfaG9sZGVy
IGFuZA0KLT5ub3RpZnlfZmFpbHVyZSgpIG1lY2hhbmlzbSwgdGhlIHBtZW0gZHJpdmVyIGlzIGFi
bGUgdG8gYXNrIGZpbGVzeXN0ZW0NCihvciBtYXBwZWQgZGV2aWNlKSBvbiBpdCB0byB1bm1hcCBh
bGwgZmlsZXMgaW4gdXNlIGFuZCBub3RpZnkgcHJvY2Vzc2VzDQp3aG8gYXJlIHVzaW5nIHRob3Nl
IGZpbGVzLg0KDQpDYWxsIHRyYWNlOg0KdHJpZ2dlciB1bmJpbmQNCiAtPiB1bmJpbmRfc3RvcmUo
KQ0KICAtPiAuLi4gKHNraXApDQogICAtPiBkZXZyZXNfcmVsZWFzZV9hbGwoKSAgICMgd2FzIHBt
ZW0gZHJpdmVyIC0+cmVtb3ZlKCkgaW4gdjENCiAgICAtPiBraWxsX2RheCgpDQogICAgIC0+IGRh
eF9ob2xkZXJfbm90aWZ5X2ZhaWx1cmUoZGF4X2RldiwgMCwgVTY0X01BWCwgTUZfTUVNX1BSRV9S
RU1PVkUpDQogICAgICAtPiB4ZnNfZGF4X25vdGlmeV9mYWlsdXJlKCkNCg0KSW50cm9kdWNlIE1G
X01FTV9QUkVfUkVNT1ZFIHRvIGxldCBmaWxlc3lzdGVtIGtub3cgdGhpcyBpcyBhIHJlbW92ZQ0K
ZXZlbnQuICBTbyBkbyBub3Qgc2h1dGRvd24gZmlsZXN5c3RlbSBkaXJlY3RseSBpZiBzb21ldGhp
bmcgbm90DQpzdXBwb3J0ZWQsIG9yIGlmIGZhaWx1cmUgcmFuZ2UgaW5jbHVkZXMgbWV0YWRhdGEg
YXJlYS4gIE1ha2Ugc3VyZSBhbGwNCmZpbGVzIGFuZCBwcm9jZXNzZXMgYXJlIGhhbmRsZWQgY29y
cmVjdGx5Lg0KDQo9PQ0KQ2hhbmdlcyBzaW5jZSB2NToNCiAgMS4gUmVuYW1lZCBNRl9NRU1fUkVN
T1ZFIHRvIE1GX01FTV9QUkVfUkVNT1ZFDQogIDIuIGhvbGQgc191bW91bnQgYmVmb3JlIHN5bmNf
ZmlsZXN5c3RlbSgpDQogIDMuIG1vdmUgc3luY19maWxlc3lzdGVtKCkgYWZ0ZXIgU0JfQk9STiBj
aGVjaw0KICA0LiBSZWJhc2VkIG9uIG5leHQtMjAyMjA3MTQNCg0KQ2hhbmdlcyBzaW5jZSB2NDoN
CiAgMS4gc3luY19maWxlc3lzdGVtKCkgYXQgdGhlIGJlZ2lubmluZyB3aGVuIE1GX01FTV9SRU1P
VkUNCiAgMi4gUmViYXNlZCBvbiBuZXh0LTIwMjIwNzA2DQoNClsxXTogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvbGludXgtbW0vMTYxNjA0MDUwMzE0LjE0NjM3NDIuMTQxNTE2NjUxNDAwMzU3OTU1
NzEuc3RnaXRAZHdpbGxpYTItZGVzazMuYW1yLmNvcnAuaW50ZWwuY29tLw0KDQpTaWduZWQtb2Zm
LWJ5OiBTaGl5YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPg0KLS0tDQogZHJpdmVy
cy9kYXgvc3VwZXIuYyAgICAgICAgIHwgIDMgKystDQogZnMveGZzL3hmc19ub3RpZnlfZmFpbHVy
ZS5jIHwgMTUgKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tbS5oICAgICAgICAgIHwg
IDEgKw0KIDMgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0K
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgvc3VwZXIuYyBiL2RyaXZlcnMvZGF4L3N1cGVyLmMN
CmluZGV4IDliNWUyYTVlYjBhZS4uY2Y5YTY0NTYzZmJlIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9k
YXgvc3VwZXIuYw0KKysrIGIvZHJpdmVycy9kYXgvc3VwZXIuYw0KQEAgLTMyMyw3ICszMjMsOCBA
QCB2b2lkIGtpbGxfZGF4KHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2KQ0KIAkJcmV0dXJuOw0K
IA0KIAlpZiAoZGF4X2Rldi0+aG9sZGVyX2RhdGEgIT0gTlVMTCkNCi0JCWRheF9ob2xkZXJfbm90
aWZ5X2ZhaWx1cmUoZGF4X2RldiwgMCwgVTY0X01BWCwgMCk7DQorCQlkYXhfaG9sZGVyX25vdGlm
eV9mYWlsdXJlKGRheF9kZXYsIDAsIFU2NF9NQVgsDQorCQkJCU1GX01FTV9QUkVfUkVNT1ZFKTsN
CiANCiAJY2xlYXJfYml0KERBWERFVl9BTElWRSwgJmRheF9kZXYtPmZsYWdzKTsNCiAJc3luY2hy
b25pemVfc3JjdSgmZGF4X3NyY3UpOw0KZGlmZiAtLWdpdCBhL2ZzL3hmcy94ZnNfbm90aWZ5X2Zh
aWx1cmUuYyBiL2ZzL3hmcy94ZnNfbm90aWZ5X2ZhaWx1cmUuYw0KaW5kZXggNjlkOWM4M2VhNGIy
Li42ZGE2NzQ3NDM1ZWIgMTAwNjQ0DQotLS0gYS9mcy94ZnMveGZzX25vdGlmeV9mYWlsdXJlLmMN
CisrKyBiL2ZzL3hmcy94ZnNfbm90aWZ5X2ZhaWx1cmUuYw0KQEAgLTc2LDYgKzc2LDkgQEAgeGZz
X2RheF9mYWlsdXJlX2ZuKA0KIA0KIAlpZiAoWEZTX1JNQVBfTk9OX0lOT0RFX09XTkVSKHJlYy0+
cm1fb3duZXIpIHx8DQogCSAgICAocmVjLT5ybV9mbGFncyAmIChYRlNfUk1BUF9BVFRSX0ZPUksg
fCBYRlNfUk1BUF9CTUJUX0JMT0NLKSkpIHsNCisJCS8qIERvIG5vdCBzaHV0ZG93biBzbyBlYXJs
eSB3aGVuIGRldmljZSBpcyB0byBiZSByZW1vdmVkICovDQorCQlpZiAobm90aWZ5LT5tZl9mbGFn
cyAmIE1GX01FTV9QUkVfUkVNT1ZFKQ0KKwkJCXJldHVybiAwOw0KIAkJeGZzX2ZvcmNlX3NodXRk
b3duKG1wLCBTSFVURE9XTl9DT1JSVVBUX09ORElTSyk7DQogCQlyZXR1cm4gLUVGU0NPUlJVUFRF
RDsNCiAJfQ0KQEAgLTE3NCwxMiArMTc3LDIyIEBAIHhmc19kYXhfbm90aWZ5X2ZhaWx1cmUoDQog
CXN0cnVjdCB4ZnNfbW91bnQJKm1wID0gZGF4X2hvbGRlcihkYXhfZGV2KTsNCiAJdTY0CQkJZGRl
dl9zdGFydDsNCiAJdTY0CQkJZGRldl9lbmQ7DQorCWludAkJCWVycm9yOw0KIA0KIAlpZiAoISht
cC0+bV9zYi5zYl9mbGFncyAmIFNCX0JPUk4pKSB7DQogCQl4ZnNfd2FybihtcCwgImZpbGVzeXN0
ZW0gaXMgbm90IHJlYWR5IGZvciBub3RpZnlfZmFpbHVyZSgpISIpOw0KIAkJcmV0dXJuIC1FSU87
DQogCX0NCiANCisJaWYgKG1mX2ZsYWdzICYgTUZfTUVNX1BSRV9SRU1PVkUpIHsNCisJCXhmc19p
bmZvKG1wLCAiZGV2aWNlIGlzIGFib3V0IHRvIGJlIHJlbW92ZWQhIik7DQorCQlkb3duX3dyaXRl
KCZtcC0+bV9zdXBlci0+c191bW91bnQpOw0KKwkJZXJyb3IgPSBzeW5jX2ZpbGVzeXN0ZW0obXAt
Pm1fc3VwZXIpOw0KKwkJdXBfd3JpdGUoJm1wLT5tX3N1cGVyLT5zX3Vtb3VudCk7DQorCQlpZiAo
ZXJyb3IpDQorCQkJcmV0dXJuIGVycm9yOw0KKwl9DQorDQogCWlmIChtcC0+bV9ydGRldl90YXJn
cCAmJiBtcC0+bV9ydGRldl90YXJncC0+YnRfZGF4ZGV2ID09IGRheF9kZXYpIHsNCiAJCXhmc193
YXJuKG1wLA0KIAkJCSAibm90aWZ5X2ZhaWx1cmUoKSBub3Qgc3VwcG9ydGVkIG9uIHJlYWx0aW1l
IGRldmljZSEiKTsNCkBAIC0xODgsNiArMjAxLDggQEAgeGZzX2RheF9ub3RpZnlfZmFpbHVyZSgN
CiANCiAJaWYgKG1wLT5tX2xvZ2Rldl90YXJncCAmJiBtcC0+bV9sb2dkZXZfdGFyZ3AtPmJ0X2Rh
eGRldiA9PSBkYXhfZGV2ICYmDQogCSAgICBtcC0+bV9sb2dkZXZfdGFyZ3AgIT0gbXAtPm1fZGRl
dl90YXJncCkgew0KKwkJaWYgKG1mX2ZsYWdzICYgTUZfTUVNX1BSRV9SRU1PVkUpDQorCQkJcmV0
dXJuIDA7DQogCQl4ZnNfZXJyKG1wLCAib25kaXNrIGxvZyBjb3JydXB0LCBzaHV0dGluZyBkb3du
IGZzISIpOw0KIAkJeGZzX2ZvcmNlX3NodXRkb3duKG1wLCBTSFVURE9XTl9DT1JSVVBUX09ORElT
Syk7DQogCQlyZXR1cm4gLUVGU0NPUlJVUFRFRDsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgNCmluZGV4IDQyODdiZWM1MGMyOC4uMmRkZmI3NmM4
YTgzIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQorKysgYi9pbmNsdWRlL2xpbnV4
L21tLmgNCkBAIC0zMTg4LDYgKzMxODgsNyBAQCBlbnVtIG1mX2ZsYWdzIHsNCiAJTUZfU09GVF9P
RkZMSU5FID0gMSA8PCAzLA0KIAlNRl9VTlBPSVNPTiA9IDEgPDwgNCwNCiAJTUZfU1dfU0lNVUxB
VEVEID0gMSA8PCA1LA0KKwlNRl9NRU1fUFJFX1JFTU9WRSA9IDEgPDwgNiwNCiB9Ow0KIGludCBt
Zl9kYXhfa2lsbF9wcm9jcyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBp
bmRleCwNCiAJCSAgICAgIHVuc2lnbmVkIGxvbmcgY291bnQsIGludCBtZl9mbGFncyk7DQotLSAN
CjIuMzcuMA0K
