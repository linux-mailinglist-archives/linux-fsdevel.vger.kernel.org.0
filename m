Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5F1352755
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 10:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhDBITE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 04:19:04 -0400
Received: from esa9.fujitsucc.c3s2.iphmx.com ([68.232.159.90]:9557 "EHLO
        esa9.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229522AbhDBITB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:19:01 -0400
IronPort-SDR: HKxPSRS8hySZ5m6V7BjbWLRYcKXfpSXXRyGgOaYRt2iOuV2CAhBU7foqpIE+f4j4NS3BYi/6nI
 /LAQ2LJHbKiNyRCXQtE849nsRHvgKyAXbZykjxXgS0M1RQy2Q7T8FB/7m5KamI4jeq/Iikbw6y
 2VLivcct5blphvcUNCTkl4l50T04Mfq/8Lv6rI9tHhnMyX+Yq3OB0Vn1C1oMO3JMq9ikJWqJFq
 6ADLMoGo7apWcqN7ErWXiQqfEOqAlZ7VpNnGQ+WSm3zMrTI1QvE7XZnKfpOHnXZjVM6s3K/dOF
 KD0=
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="29033759"
X-IronPort-AV: E=Sophos;i="5.81,299,1610377200"; 
   d="scan'208";a="29033759"
Received: from mail-os2jpn01lp2057.outbound.protection.outlook.com (HELO JPN01-OS2-obe.outbound.protection.outlook.com) ([104.47.92.57])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2021 17:18:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZ9a8JAoR0qYfZCzj6U4glypxu1vzsAlXDXUK3EBHICSue7+rrZamwh0Js9zx2ZY2EQKbkM3gsL5KdQ4MmqgKFSH3xK5RedbtMkhRXOTENf3YGGEk3TWh1MHHeaaA9u2EHhEVFQsLpNqW391SbwuZmJE5a3M2xv5EmPpfOVpZbHmpMEWouMnQEIt8O60Ul2Nydqm/H0arxUo/AyGwu/yxZ3LIca2SZ30N3vvfewJhtJYnC1lP/K6M7AYXK/W07luOHNj+BoYxDf9+Oge4KgCEck4tpi0NUmMieL0Pikc7+2WWlsibbc51+ripsbgYGPwJFd8egfAnGWaJwSNaF/P/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbiko/8hLx+mPtM6OKoUIuPFaX4Y2wRQtP24JBim/2o=;
 b=W2VG1zlyhTCx2JLJmBhBwwzx38AGMqzd4D1hT1y8rlOYDLtnPF6ZCjsJcgj5EXUDFP9bugCj9pFQCEyG1TBqbK1NRNyAQ0fsg7nmnsPODfPKPJ9olydhSKoeLVqw+xqMPK/sr4ogw/TfdTdyknD1/jQH8RNQvbPkK2TnvI0hmARed4cc2qVjtauQrN6iNIaDPpeTMYnhiKtIjfPClv7bythSkOMKpppeLqQt2GOGbQYlER0CUTfpLrunO/J1cUlKwxROPcWNc4qGGWrdaXw6jCPDeC3Rb4oR4zzzx1Vjfng9xQdn5PQUzVWYHYQMGM26+/VV7edL4+CsFne/rOJuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbiko/8hLx+mPtM6OKoUIuPFaX4Y2wRQtP24JBim/2o=;
 b=O+nbDK6rUIc9Dy2L5g0RL/C12DCWsi+Lph3w5A4AqhE6UqApJT/Vp8o/SpeZ1pQ9mVwTZbZgRPZndXKAhs+uTzi9e0xQqyLBVh521XZejmqGTxngbFnmLra5iRmqMZmrMY93PBnUmX+MM+SZEycssj/RQebRme3Fk4FFxok7wlg=
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB6722.jpnprd01.prod.outlook.com (2603:1096:604:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Fri, 2 Apr
 2021 08:18:53 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::68f4:1e20:827c:a2ca%4]) with mapi id 15.20.3977.033; Fri, 2 Apr 2021
 08:18:53 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Christoph Hellwig <hch@lst.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "rgoldwyn@suse.de" <rgoldwyn@suse.de>
Subject: RE: [PATCH v3 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Topic: [PATCH v3 00/10] fsdax,xfs: Add reflink&dedupe support for fsdax
Thread-Index: AQHXHGKQk2Eu++5KRkanzs5GTu34M6qg8K4AgAAHZQA=
Date:   Fri, 2 Apr 2021 08:18:53 +0000
Message-ID: <OSBPR01MB292043A4BEC48C87404084E0F47A9@OSBPR01MB2920.jpnprd01.prod.outlook.com>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
 <20210402074936.GB7057@lst.de>
In-Reply-To: <20210402074936.GB7057@lst.de>
Accept-Language: en-US, zh-CN
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [180.96.28.100]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b3c90c2e-af98-46f1-8d39-08d8f5aff421
x-ms-traffictypediagnostic: OS3PR01MB6722:
x-microsoft-antispam-prvs: <OS3PR01MB6722E543F8A392DCD3133C90F47A9@OS3PR01MB6722.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bdGcrS8NecVXmItl71TwsbTrCdJNODr5UAdPLKx5p3QOFo0OJ76EMfOgg7ZW5LR95vkaoFNmPkz2CY9X2sywfaXYjku4y5q09MXgEs2EyDO2meMJT5dafxW1zlJVg6+ALH329BfvwqHfLBBSSUtJc2YJPPMnyBFfXlzIrGFwH5nN7pDfckHIld18X3+9A+n+SE34Eaee9QE0Dl9afzqQUCwsILiImbGlHKndMSl0tZSShwY9WV8Eowyok9kM5i0PE5VjuE4AN9GMAOMVJOO4Txc8gUwNGtrgVz5ID8WSOdWuzBA5zghq+dFpyzU4wHwhjRH0q9gXdVYdq/IYMNTCUIM8xQH6kjwMZjFVVa8nrMk8aymt5cP4b+/jCWsIJDeQ9/NzYnCBdePMZb258c/6o30jfqaYV8Bkhov9rvi11RSpbL/pfZlqGR7GoWXGBvIJb0MsDG/1xBle9ljNeEp1IbvqXpnckH7psV+ePvIqLRpqn9LjZb0MeWOHFmSLzrJbL8+kXvNypn3GUM2360LMcehJg3+TrGXxwHYQL8JOkt+lNkRaTklXtEhTT01UZZZE8n9B6Tmj3mIUlXR8VFBx/lJYvpRjiFTXMVAFcidkqXMMQv5JViT5PhsYHbPNgw5FGBy/4CmUpiYe1qD61isy4JLZz06uT74STZsywlni0Q8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(66476007)(86362001)(66446008)(38100700001)(55016002)(5660300002)(8936002)(2906002)(9686003)(85182001)(83380400001)(6506007)(66946007)(8676002)(26005)(7416002)(64756008)(76116006)(66556008)(186003)(7696005)(478600001)(4326008)(52536014)(54906003)(110136005)(53546011)(71200400001)(4744005)(316002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?gb2312?B?SU5mTWVhQklvSGNDRVpXL1ZrQmJPeUV3ZUMyc1Y1Z0Jvak1tMGFHa3pCc3Iw?=
 =?gb2312?B?OUdEOHlLczE2bEtiMUlFbDRYenRlNzJYZTdPNExZZTJXSFNPMThCVUtpeFRp?=
 =?gb2312?B?cUI1ZXpuaDZyR3UrcGt4aGlYaFN6NXpKL2Y4MXVaMmlNbWo0cXViTlMwYmZH?=
 =?gb2312?B?emt2UkVtVXdDbUk2K1ljVHBpZk9yalI0R3FhdWtFN0c5M21qT3krWDVCSzRF?=
 =?gb2312?B?U1VjNUNaYzI4MCtxK0I0U1IyVm9uN3FPWi9qbFFBM1Q4VUZPWHUvNlBPaEhO?=
 =?gb2312?B?K25Wbk1WMzF5ZjJVcnRrVEJFT1ZRS0R0QXhtZTQ1N3AxYUE3ck5YbUtQbGdN?=
 =?gb2312?B?WXphMVRPR0xib0JaOUxOQmpkNUpxQ2Rwa3hEb1diSGZieU91YUgyL3VaaERx?=
 =?gb2312?B?bG1LaTdhRjIwTjlERXBWcURZai9wcTRuOXU4akRWT1NWem1QeEpoUFE1QjUx?=
 =?gb2312?B?R0lhdHlkbTFqU0xsL1JKcG5ZYnl3dzVibmFKNUUxUmhSb3o0R0ZkNlRZTkpW?=
 =?gb2312?B?RVZFTjB0bGZNd2lYZTdzZW1GSTlpMFRZUDJob3R2K3lEVEpmenE1Mk9ZUURs?=
 =?gb2312?B?L0FyemY3SVdIYnpTbEpHNCtqRWhET25meHo1Z3hnUGpCdUJqSldzY2xzNFVs?=
 =?gb2312?B?MUwvVDhjSFkvajRXY1lHSmdkZVVGZnYySFJHRkttRXB3a1Q0YjlKeHlNWkZu?=
 =?gb2312?B?TkwrSTBkSWNnVklXeHJQS1c1MlZLN2NqQVBvMGJhVVJIRXZtQlBGS0xoY1pS?=
 =?gb2312?B?b281N282TFRSRmUwdTF5M1Y4QzBRUEd5SndwcmpOZHhxWityVHc2SXhadjRo?=
 =?gb2312?B?NVBoYzBLV3RSQSt6SkdUQThvQ1d5cUJRUElRL05lbGNoSnpaKzJOQnRVS2M5?=
 =?gb2312?B?VG5EaktQb0Rmdlc1SjM3bnBtYytxYzY5bEU5elNydFNNMHVoa3MwMUJibVF0?=
 =?gb2312?B?a2pIQ2JibG81emgvb0wwcGJNZlNSaXFhOTd6UmVYYnlNMithckN6alZIUlJV?=
 =?gb2312?B?OENjbWVrN055SG1ZNlB5QUtzYTZBRlBnOFBUY3gvR2tiSk9DN1UvanJob0dh?=
 =?gb2312?B?NDhKV0oxQ05qUjlBT1FyYjRSUy9KeXVRQlBqMmZ3ckJmSzB6MllKZGFaOGEv?=
 =?gb2312?B?YldjWGxJdGRmS2tQbTRQaFdHNjZ2UG5ldkV0NEJqa3hualJleTFweENmWnVT?=
 =?gb2312?B?QzBROVdFUWhXQmF4QWpxdHlIQWlDTk9BZmlCdzYxb24vaWFzTVNiSjIrbnJZ?=
 =?gb2312?B?QVZyS2J3OStpbEVoWHlDcHdCc3dkS21YSXRMai9DT245VmhXWkZyaGthZ04w?=
 =?gb2312?B?WVJhMDgzMFB5VVRiajZsbUVabHlPVlN3allWWE9IQ3lDa2FJUXdRZEF0NktR?=
 =?gb2312?B?V2xIaWNrZ3l0VlMxRy91NWU3ank5bTd6YXlhMFpLandmTS8yZWJmcndYT1Vv?=
 =?gb2312?B?a200Zjd1UDJPYzQvU1BsV1F2SUk0QXo2eVVZZkF0Tkw0b0F1a0tMdER1LzVv?=
 =?gb2312?B?TWkycEdOS3B0ejAxdFQweU84S3RjQ3loSjNtVmI2R3J2YlRBcW5JajZXNUEz?=
 =?gb2312?B?c3pkT3RRbXVZeHU2amFRcC9aRjh1YWhqVkRCdFZrNjhQcmFxQTlDWXJacTdM?=
 =?gb2312?B?K2lmelc1N29iSHRGU3NSRjRsVW1JWGRTcUtzVUpRcjBBVFhSTy9lS0IzcWRD?=
 =?gb2312?B?UUpuMk1mRlpvSkJmYiswLzd1QzJwRUs2ZHBLdDc5NlZoak1rMTlKOW5NV1N5?=
 =?gb2312?Q?1p51bath+vTPNKm/+/SU2n6cYzx1rfgWlbNqq/u?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c90c2e-af98-46f1-8d39-08d8f5aff421
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2021 08:18:53.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3nUR/hHttEu+HBIXc+vGg8H4p41I9plyXqIEUa1psnR8Xbjg+I9UbK/5+zinvXhNxSBjj0YryIftFdp34Da4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6722
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hyaXN0b3BoIEhlbGx3
aWcgPGhjaEBsc3QuZGU+DQo+IFNlbnQ6IEZyaWRheSwgQXByaWwgMiwgMjAyMSAzOjUwIFBNDQo+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMDAvMTBdIGZzZGF4LHhmczogQWRkIHJlZmxpbmsmZGVk
dXBlIHN1cHBvcnQgZm9yIGZzZGF4DQo+IA0KPiBTaGl5YW5nLCBEYW46DQo+IA0KPiBnaXZlbiB0
aGF0IHRoZSB3aG9sZSByZWZsaW5rK2RheCB0aGluZyBpcyBnb2luZyB0byB0YWtlIGEgd2hpbGUg
YW5kIHRodXMgbm90IGdvaW5nDQo+IHRvIGhhcHBlbiBmb3IgdGhpcyBtZXJnZSB3aW5kb3csIHdo
YXQgYWJvdXQgcXVldWVpbmcgdXAgdGhlIGNsZWFudXAgcGF0Y2hlcw0KPiAxLDIgYW5kIDMgc28g
dGhhdCB3ZSBjYW4gcmVkdWNlIHRoZSBwYXRjaCBsb2FkIGEgbGl0dGxlPw0KDQpPSy4gIEknbGwg
c2VuZCBhIG5ldyB2ZXJzaW9uIG9mIHRoZXNlIDMgcGF0Y2hlcyBiYXNlZCBvbiBsYXRlc3QgY29t
bWVudC4NCg0KDQotLQ0KVGhhbmtzLA0KUnVhbiBTaGl5YW5nLg0K
