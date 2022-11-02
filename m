Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A222615FA6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 10:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKBJ1E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiKBJ0p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:26:45 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42FC11A32
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 02:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667381077; x=1698917077;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=SYEIEphqIrWnIJ8/RC85/B3WUlu5f2rrrIIqz8fCGz9ZdzENYnbUg2CJ
   a6eePzwGQCL/Pwkuj4+MHONQlIcRj/dRcJoOUyTNc7w1Gn4nrnuIA7j1V
   EMqzr1N3ApMD95wbwmXqrNz8QEi7ti5JDkFpmirQHS3xbTh6Sn7o7/vya
   TBYCnlbNcmSm3SWCUTqXPGLgVLEgYSXNTun/V+VvShlgsRuKsmQuBcwiy
   cIiOYFpfRc0GSjILxzANX1OVF1gatWTBCcke6fp0S+G061SddUtzK8yHH
   Lf41EonvQ57fHbgicntPkLTwss5zOB8+zKeDWOz1ST69yJ/hoaeMfhkFt
   w==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="220452671"
Received: from mail-mw2nam04lp2169.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 17:24:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQZoykGrDOl65aW68K3wyHXakq5FpLpfQ0ZxH/VpZZ173j8h097pbOMmBIDdmY/tn5k0s86ykNv4IaeygxTg2HYaELSS3kiTmjhjEeo9Fd2J00Q8TqDHKJ0hftpXKapNvckMFfq1CqymHZQt+BxNNQj2WYIwufF++Z9P+g1VBNPVOoYoxhLc/6uDnQ6K/IjaDXoYFVdGg8X1li8c4XWQSX7LDreDXfzKcO4lArQMykbqtE9DNZcvPyecIvhmpdzO3YuZtcITDRc0VXxxz/gr+OSa+UhObDXz+s45pnccwQb7CWYdr2rp1x1wS896lk2xLdR4eql6xIkRR5p6M93Hlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=g1PtFLGgKJ463wGrjRBESskFS671gantJ6mEDaUDXAyh3bQsAG7trOWxG1inRA9JCRVDd3y1y46hNAPuc4tPyuVCQX4zJh6yXNieQ7gYSn0w0caGQcwBbqAQBHgU7ZVAW2Qql0U1RvZuUiGLxCnOyrnNEJi9GCoRp3ZtlIyZsYUqAShHNi6wayzmpRiA4K9lfv+i3lmaMYGTuLpvc5RhLXTv8/jmoFDfCckaAAb/yz7lM0lyujUvH4gMRR8gy5UdT1N5MZfkfRcFhpDmOD3gwwSWzpf/gzcYPbkIROlNNj9qwYh31bxojjOZXD1/jpCtdg8wFee7NJmHMu9NhRRYiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=C7i8YlrqjO+x0X/wUL3WWXcnCpjzaSX7ByUGMowBLszXd7m2PsXzUEHSwhp7BzkzGoiCRMe80YBpLjPQAn/Ph/LIdVqD6lfu2upi7JGJbmH2XO38gNhrD7sS2y6u7hg9w6KBdar5UewJ0TPMiOblbgwY8NJA6jGJV2Vu2zC/eBA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7736.namprd04.prod.outlook.com (2603:10b6:510:53::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 09:24:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.022; Wed, 2 Nov 2022
 09:24:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] zonefs: Remove to_attr() helper function
Thread-Topic: [PATCH 2/2] zonefs: Remove to_attr() helper function
Thread-Index: AQHY7NTqTzn2g97mo0mefiNHqyM5JK4rYC0A
Date:   Wed, 2 Nov 2022 09:24:35 +0000
Message-ID: <7d2070b4-18f8-9d2c-872b-f971ff5e572d@wdc.com>
References: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
 <20221031030007.468313-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221031030007.468313-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7736:EE_
x-ms-office365-filtering-correlation-id: 5f3ead69-f81b-428b-cf3b-08dabcb40ea3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WTxQdj+4yshbXcEAXnNHmLpBXyYIH/patmpbhc20cuRh2AAHZQ0pUIMdkw0aakyGtU8MiRNvwnKYQ1KkXMlckjFjcPTXj9A7LMxO+lBlXmQVdKyx5BNAtHOMqD+LV361KbrTBYqwG8pJ32PrOLgQq0zvm4CHIy9AhWEFfedHV3JaLCwXDsifxATWm8HhT+BBvbWeTRK534aRvK1qZRJknl7OoGoh0eMHYoevWdwpS/d7zAI7SDAGX5DDRAqhvlXZRavoLPkIKO2zLw76O/qhYVdDtnxlJr4YWJTGE0C0T8R60vp4EwIeqhfRJLOTKvjM869b+JLr6GLlPlYoKxXZFGQR6aoOLImpYWmtZj5W+4c/vuxcog/pIJAOj8bV4pS+lOdOss9j9UhvM159WSqUUJ6ahyPx4uUetMAa9FPyoCvpAlkRY4X6MQdpMDErBJ94aIo04fhbw3P8okGu0EICL4lhQ+t1XWlidzcHktNBEASyCnJLSpDRZQSO3jvLZ0TKc0I/6bqzrndaSv8IXzYlTcDlMLJBLfHdUYfdkGtQplUrAK02wJHyfNnG1ur6lwzBB/YCpkLG9igZ30eKJllQz7prIjD137j5cNDcXurNKjDFejQRP5+X4uqOnk/s82QkB4sf4g7BB/LX9wtppGv4Ff1xWjZqaS5jOo5aGP8qrEP19zq6Da93YYt9eOaZzZrU41TInQdX3NFhMOqIsOZeFdDHjmpUPBJrPhVTxIbAgaru93bBWiBTgz0ldpMK3nkMEXgatqntwbqOgUWaDh7c/FCNcylYLF/tQVBn4nvLkS5GmFSxgQkkQn7I6nN+FnoyEt34sGE2+m+tKtsWof6KHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(2616005)(6512007)(4270600006)(6506007)(186003)(478600001)(2906002)(19618925003)(316002)(91956017)(76116006)(71200400001)(66446008)(66946007)(110136005)(5660300002)(6486002)(8676002)(8936002)(66556008)(64756008)(66476007)(41300700001)(31696002)(38070700005)(36756003)(86362001)(558084003)(38100700002)(122000001)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWdrM2JWT1B5QnBJRlA3MDNXZDdDbXZ3OXVOeDZmNkIrZUFEZzVwYkI3WWFX?=
 =?utf-8?B?QkpnangyVEphUXNHUU9LV2lYRFV2TDNwRjVudi9SdGlmbUVTOEVRRW1tVXFv?=
 =?utf-8?B?ZGRKb3Q5VHBIRnhiK0dMV1F1V2Ryc2Z6N3JsRURPb1IxUUZSZEdtVkFjRWNL?=
 =?utf-8?B?K3BEeUYzQmpudEdkaGloeFhoSUdZZldZY3pQZklWOENNc0I5Rzl2d3pmT3Uw?=
 =?utf-8?B?T2s0SmN5WHpCLzR6QzlYVXlTMDEzZFNvMENrUy9OZTlyVmpxRlNUdWpIZGwx?=
 =?utf-8?B?WGhKM3VvSWtYNmNGdUUzRVlkcWRETmIrZTJxRURoSlIyWVNFdDMxS01xQURp?=
 =?utf-8?B?MmcwZFJ3UUlqenVDSWN6RXpUeFBrSEFkR1VTcnMwZmNnOWtteU15TG5VYjNT?=
 =?utf-8?B?ZGlLVlFMUkNjOFlmUXpaQ0dZMEt2Y2IveXJCQzhuTnBOQUNjU09kNWZxdkls?=
 =?utf-8?B?S1lTTFBpZEJ4Z0tlRHd5VlpGdHl5bW11YXJiNk83S1hneVpVN1AxZ2MxVGhJ?=
 =?utf-8?B?eWJabUNiZUJrcTJZR1dCUk1pK29OSGpCWVB5Y3UzeDdqNnZjck1MaVZoRmNB?=
 =?utf-8?B?bjdFV0N1RjJZKzNXQS95UjV6UFRlYTI5OFlnYVlNSURFZm9OcFcraHF0RlRu?=
 =?utf-8?B?VlQ1NEpudVQ2M2hUOW96clFualIraG5KTnFzOTJseXJHOHR6ZFhYdTI4UGFT?=
 =?utf-8?B?dkxLVklTbno2em03aVY2ZXVVQW5kRWNpV1hmQ0xJQ2FkdGR0WjVwSnRKYVYy?=
 =?utf-8?B?WGRlUE90SDMxaERHZnQyeWtHZmpra0tqVEF5U3dhWnhVZUMrM2d5dUg0Mlp1?=
 =?utf-8?B?eW56eEx5NTJUZWVWdXVNNEk5eldtVDRLRHA0SnVEekNwZFRjL2F1RWsyWlJu?=
 =?utf-8?B?L2x6bkc5T1RXbmhVQ2FRdXMzeDl5WERKVkZxQVRKUnpXbXYvdGV0NjdvMUxp?=
 =?utf-8?B?dE5iOUUzdnNpTGJ4QkorWURoZ1hEUFJoa2lUYVN6clVoMTRkY2prMkc5bjBJ?=
 =?utf-8?B?V3U1YVY1Rm9xWjFwYUxabFNzdFc5dWoyUXNFb0F1S3JlR0RQY1RDYk45L09v?=
 =?utf-8?B?TUpTQzB4RVc1MDlBd3U0UERWODdWdVA4QkViR0hxNHZlc3l2ZVpYQ0JGbktZ?=
 =?utf-8?B?cTY3dmxFdWU2ZUFFZnZlTGo2Z0xIOWVkcGR3RVJJRFdHY2o5ODVKSElRMmJF?=
 =?utf-8?B?SDNXcEFwOERFb0ZIYWVPN0I2R24zMDJOTm5TVXIzeFNwTHhHdUpnZ0dCSVpy?=
 =?utf-8?B?SGtpZ2t5aDRZaTJRR2Q0bW11cmJINVd3T2M1QktUMEVsclJYK3paOURqbzR3?=
 =?utf-8?B?NDhaWkM1cndzcFkyOTZBWGJLZmYzRGlJNGhTUTJTU2tBWkp5VEM1VFcwd0RZ?=
 =?utf-8?B?aVkwZzNZcTZZVUpHQnc2WlQrbEVPSjlDNnRmN1lNTEpzb2tRYkR0WUg2SGp4?=
 =?utf-8?B?VG8zYXFIZGdxcHE3L3JKcVVMVk5VdW11TTZibDNlaCtsdEk4aU9rY0xxMmZ6?=
 =?utf-8?B?VE9kcjg1cncremVjamVLa002TDNwV1R1YTJlTGtNb2orOC82QWtyWWVxeEZ4?=
 =?utf-8?B?eEJheHplVmU4NG8vYUdtMzdGazZCbWQycmZQRVQyOUd5Tnh6dVZEVW9PTlBM?=
 =?utf-8?B?Y3luUGU0VWdGcHo1bzdxdzJURGc5U0R5L3hrRDQwdFpHWVhZUU93WWVPdXJE?=
 =?utf-8?B?YXNxU0ttK0VwQU9NNGdyS1pOVUF4VUVWMjQ3WFl5ZHFCL0Y3V0Q1cjAwYi9l?=
 =?utf-8?B?WlZtQkpMcGlPdE91ZlVVbUtuaTNReWh3L25LWlpBTGlTaWNnVkJHY1FrM0FY?=
 =?utf-8?B?d3hTbHRxdGwvTG4wMnIwdnlOZThIRUthNVNtUXpxNmpDdE5pZ1BTYnBLQVVi?=
 =?utf-8?B?Slo5QXlndWRmRjZOekUrdHlIaXA5Nks2di81ZGxoZW5GS3dub01WL0JNYW5i?=
 =?utf-8?B?a2VUQVNQQUM5aVA2V253T01sMGx3VmNnRmdweGlJM3ZXdXd3cTdmb2FKVVAv?=
 =?utf-8?B?bGkyZjVnQkEwQW1qVTZ3bDRZeVlBb05EQng1WWNoMTBIWkJRalVZNkYzNVZi?=
 =?utf-8?B?dGYzcFFuNGZHUTBIUnlsRlNTMFZLSWNMKzJxREt1Q2xMY0ZhMUdkT05mekdP?=
 =?utf-8?B?ZHFWcnJRbklBSldsbStEa0NZRENITyt1bmMrQ0p0MmxZRWM2TkZraDZKM21R?=
 =?utf-8?B?VHVMSEQyTDlBVVFWVTJ1ZXl2Y0szeGYxS3ptNTIybVFIQzVNbzdFSlVML3Va?=
 =?utf-8?Q?+aZqkHeR/xDv+qAOm6IaHwax5PHEbR3O9Ta6XiDBZg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA296FACB83E9143AE269897B50BFF29@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f3ead69-f81b-428b-cf3b-08dabcb40ea3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 09:24:35.1785
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAexeIsSNtLsTto/A4nWwoxcL669tWpKato3SFAd/RxDtXgSCcL363GWNqcu+nzGIdNJy+kxl7ZWfw1nVgop3BKOFzIfWEDoiIEBVKf2JMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7736
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
