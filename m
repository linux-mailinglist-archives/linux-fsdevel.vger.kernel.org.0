Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1066C1462
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 15:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbjCTOJe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjCTOJd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:09:33 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8190072BD
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 07:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679321372; x=1710857372;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=mwXeZawKpCbtbt3cATbMzcg3aC6On3Aw/x6L9fyO61/7U7u8bIuyIDuG
   mk8m2ulz7Xs7wXkQj2aExeHGJvf25dH8YBYoFNrnaxJMOUafQu18koWaD
   4EX9sTXHR21J38NuO+6Rl91gWHmrEFZrvaZlcuwpUWTAnBISlkB3atcoC
   dEk81fSl712SkXnttYOWZUi9wMZMWSmW7E6rbYUEj0nSZ73u3dz83BKfv
   VHaGKdSU7dC5O1DVJHq7ApSWOzifTOkbrVL+coDaUDBBQlQMSrKZOTasQ
   5CcZgp0itoyBz6bicuAOM7s1bw+oW7+AFuP8bt3w0SxYQ/+26b1omN3Ef
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="231015558"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 22:09:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGOLDOGZb2dxwkcT7QVQrT2G7ICtxDsyfzQ9tzmtCac3lqNa8VWXIZ7nIdjZq9/fpCiqBjGj0ZEKrzMtg+Bh6PpjBfjJimBp9pIZ006C1Phve7Z8SzAKVmYIuM83LKDf9ifV+3HwxZVxF3D5mAUNEoClOLVJIM22F2OyyJU5UTqNmtETwtw/0dcYP12+K2bCMGegLxkkQGiFiQoqdxki76Iy36yg8qL3/0WJjAShfcovGbSAw7UPhl6uu8FoGKbtsRZvUhA5gceK/pzw73Q/+tQZPvJotJ2Mlrc6effOXlX3LyHjJPvKQsxGsYSiVs/qTOTMYZ5rrHXI/pliGShbLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=GttPKMIXdBfBQrgJ1WDY7yC6PnP4mkgL16dO5rrMtp/aGELK7ridcCIfatQ3I2xnY0t2rTmDPAobMifgH+Kt3EIV+Ju8ZQse7s/6V7G68LfixcUoyGsOUJDZY3DK8+EXXZRYzvyn+OS8eYf/eVlAbtSrkkKlzWkgz6cWtjGJXGzX5YRItbxyiH6VHFctgN+1z2spiL9mlta+Ge3yhVxaNTDzsuf8YPusipuqMApclMYvEVMMcGQCVji55FOizcffcMalcJXEWl0oxnu8MzoS5e/lbY+Ki+ti8GSB9weAXo+83Y4O06qYi+zQomlkZdvU1VHKlriDIhruS7Shjjx+rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=Zl9HhqHF8n+02zDLTLQB+Xlq2TgNm1Cwo6eJPsPEnda0br964owd+R4H1d/T6orycXUraQNXQyO6uG6t03aSTPm5UcijOYLKT93t5HE0duHmJQqvPhqwZrL3pJrUD448KsCZA7RbkjVd7SCDCLCCV4c9OTIQDown6AaFSd8PDRE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7011.namprd04.prod.outlook.com (2603:10b6:a03:21b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:09:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:09:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: Fix error message in zonefs_file_dio_append()
Thread-Topic: [PATCH] zonefs: Fix error message in zonefs_file_dio_append()
Thread-Index: AQHZWzOfMmk1DkUdAUKJRQOOkShvXa8DtMKA
Date:   Mon, 20 Mar 2023 14:09:27 +0000
Message-ID: <04a7f734-817a-dad9-03e2-29524255bf3f@wdc.com>
References: <20230320135515.152328-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230320135515.152328-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7011:EE_
x-ms-office365-filtering-correlation-id: a201a611-3960-4877-a074-08db294cb798
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L7bFRPdP6toWFC/Va5SH0HV4MIVoArmrl8JMCBjQ92SME77Auksx61XbR+nYQyTvLxLN0oNhST6Vq8C2y9hRl3avArJ3ieUxE+dbpVRa/87hqz90MRUREN+deL2U+eWP5/SQTOMaNnluuq5mr1vyBAUikmsWr3JMwA0zO1Paq49V5nXxjpsY1YqQla5juBsUa07FHbGrvhypl3ka92cW14Wb4pR1gUotC2oFBWsoZCH3divNsHpkxGUuAN5QP3Y2UeVxtD/DVwsIHOGd26hUr1rj6fDRLmG2liDZvlxPbuBhRnNMjyQYzdT267SWxaz45Dxy8ZAyEpV9VD8BrqPddHX8LwBcmdSc4BboRLxvnkqpkN2yKB2F4gLcEKs+QvD+t5lDN4rdmORCzNEuvHleArpYmlaNj1+kPKg0xvBzI3TFc/0ihZgJVcauzC5lqNYXbxZwMcmapTartPt5Nu2jqzn+KCX+c3TzCqdLyNZs7AyILFXqZnINKXOZzYJu04Y/LXTCKvFOg4HEsF+ToMPmEmBv6a9Xk8Ym4KHveW00KbpWcroJ51GwWZLUbZO4CghZOcI3qYwO/KIHjSmcZYuX2zEllEip6yLOB0aiX/vuw3++WIRKaX4ofpoa62jJB8bFMYFnYPLOlyoFX4dTiKnSGETmIfLNSkvg80y1kUC0xVeU5areqguZTCv0xtEINqeoV/MgGMEdHrpH31Je4JxBbwD56wvQ5ICEIC/qvmKHb/20YafR8fw4+T/yoVlQTIgNmth1o0JVxq2t8VfClTlkWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(451199018)(38100700002)(19618925003)(31696002)(86362001)(71200400001)(316002)(558084003)(110136005)(91956017)(8676002)(5660300002)(66946007)(66556008)(36756003)(66476007)(41300700001)(8936002)(64756008)(66446008)(76116006)(478600001)(2906002)(122000001)(82960400001)(4270600006)(38070700005)(2616005)(31686004)(6506007)(6512007)(186003)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y29YamtyL2QxQXIzblVFQU4wVkN5NkFXNU5ueDhpNWtNb29NZ2d3WUZCVnJJ?=
 =?utf-8?B?WHptMmxYVFUxbCtCSjJ5Q1JxSFBQNkVNcWU2WXpRdnA1aS95NHdXbjlYL3p4?=
 =?utf-8?B?L0htcUt1cmUyZ1B1RWozcWNpVmxET2xTbFFXTDVPSjlKb2QzOXpFSktIT1Vy?=
 =?utf-8?B?MTFHWGp6OHJUZ2VMWkJMamZqY1grdjFBOWRNRUJ5UmRicVhWU01tUWVtREV6?=
 =?utf-8?B?SGpBZ1R5dUE0SjlISmtPdjkxUHF6NEwrUmdRYmJ3OGtlRzlLdDJWMnpEZll6?=
 =?utf-8?B?OTU3NVpGVHduQkJvTGpSZ29hV25WYXRNTTMvZzZaS29nb0RnaTVVWUVSQll0?=
 =?utf-8?B?Nm1DMkkyNFN1ell1N3JleGZmR2Uvc1dCSEI0dm1QelRDSUg0dWZxeE9CWDNz?=
 =?utf-8?B?YmxNSVVCeEtXdHR0RndTcWVpanQzUFBIM3NJdFhNRnZMaUo4RGxzUU9jQ0Nv?=
 =?utf-8?B?UXd6bUNpRjgzdnlaQjRRMnRTWFhudTlkM0tRUWdXb2lxcFdMRmxDUFU4WURK?=
 =?utf-8?B?YmhmVy9DRWdrdVBVamhnSWVsREhuL0kwWm9sZVhaanNjbHFQZ2VhMldYVWhV?=
 =?utf-8?B?anJ5TGtaSHpEODd0d01rSGJBaVdDQmRRTW0yKytHTm1Ic2xPWXR5Vzh4RXB5?=
 =?utf-8?B?ZHJTdEl0SDZaUkVYTU4weHk5QlBONnpuWEdDU1Npd0RyTjJTYXFYU291aUl4?=
 =?utf-8?B?ejVwZmRYUExWZkJLbzNZb0Q5WlkwNlhtMEJLY1NtY1NtLzdJQmdvWkk4THFO?=
 =?utf-8?B?cmZYclVPQUUvamZmclR2a2JYVGlYRXRVU0d0NXlMeWphWEZSeDZzclpaVTZB?=
 =?utf-8?B?WDRoZ1dxY3M1T3RiZTNsUmVVY3dIaHBycStBaUpBb00xL2FTdVFzVXNwVW1Y?=
 =?utf-8?B?RElXakhMSnZKd1JMUmhZdDlWQnN2bG94RGNkdVBxU3RqNUpGaVJ3Ry9XNmlR?=
 =?utf-8?B?cTVoTWtZK0xKbUZXZzBSeUt5ZEEreHN1V3o4WGJTeDJkYzFDSEUxUWx1Uzkz?=
 =?utf-8?B?VlZ2d3pkNnpoNlBFWDRQSXJYbHpQc0RMNEpqSlBPbU15UUJSd0JXQXRSVFZu?=
 =?utf-8?B?Qkp0REVTNnRKNGd6dkZ0UzBjNlJ6b0M2WTJydy8yWmhSU0NwMVBVdkRuYTFu?=
 =?utf-8?B?MnRVTmorUWt0OUJoQ1NaNFZWMXN2Q3Q4RjNjOEZESUQxUVZEK0YvVVJ5SGhx?=
 =?utf-8?B?MWRldWxSeVgyVktmQ1hCczZhakovdEpBbm56c2RoZ3p3THZETUdWTXFkU0pt?=
 =?utf-8?B?WTQ3SFppOUJoeUFZRm55Y1M1dm05OWRoRjFmQXlFc21GcTFONGVtL09ISU1C?=
 =?utf-8?B?Qk9KTlBiNjBTVzlGdlpJMWNsd3YyMUN6a0s1eGJqOEZzcHA5THk4STJKOFRl?=
 =?utf-8?B?L1VkNlBwZ2lhRkc2MTJEbE44RVRpVjRmOVYvdmIzS0hPVWV3b3FYc1VPdTJV?=
 =?utf-8?B?TmhwaThrK0s4ZHVhWU0zazQ0MGQrUnNvTGR4a0tjZFYvNUVBazMyKzJEUHYw?=
 =?utf-8?B?Q1RBYnJOSEtaQjRXVU53Ri9JSTQxMnJRVysvanFMOVo3bHFqVTFodlVDaUw3?=
 =?utf-8?B?MW9nM1lkc2U5Vzk3YllaSXlMaytmVzY1NitpU0N5c0hMemlkVVJYSzV2L0Q3?=
 =?utf-8?B?RnhZc3JTRW1CUURDckRkTGlha09kL2dGRjMrc0I0bXNtNXdkeXU4MVNJakZN?=
 =?utf-8?B?N2JmWWI0aDc4dzh2MlN0bFJJQTd4RVZDQ0RiYnlQWDlweTE2UWQwY1ByZitV?=
 =?utf-8?B?eDBFZnhBS0NLNWM5TWQ1cjlKUDVXK2pnM0N6aytFemdZdUxvNDRWRzM1WWxh?=
 =?utf-8?B?a2xPdGlWN0FWck1zV1NRUjZpa3RWTVkzN28yZGpjMnZzN1hwZlpQNDJZbVds?=
 =?utf-8?B?YVdycW9rZmQrS0hvYVJ1ejcvcEkyTWVidU5OTmJhZGx5bjJiN2l5QVRGbkc3?=
 =?utf-8?B?UUhFVFEySjJVaDY5YXRyM05ZT0FKMkRrQ0tCSmpZTlZHVlRUS0wvTUtxV2sz?=
 =?utf-8?B?UGRJWkhSeVFZQU1yb0ozSkFwSUNrSUhud1NsejVGa1NBandOdHFqNUl5L0xp?=
 =?utf-8?B?Qm1jMUE1V3grUVh2OVM4MlJvUGJXSFZXczNDa3djZzB2a096NkNjYTdpU05q?=
 =?utf-8?B?NmcwdW5zRUVnUk1OTnlML0Q0NFZmV2tlc254UUdzZnp1ZXJXV0xsdDl6Nnc2?=
 =?utf-8?B?V1hrRndENGVQTHp0dTNyd2Z3aUVIeXovVGpNSXJPUHNhRFRiN1hubFoxZnhq?=
 =?utf-8?Q?8Avh4VK3Nt7i1zZTRWeUPpkpD674NLPbnRHEE8mI0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D44177CC8426DC40A2912D41EA6BAF46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: r8zderXNBxezhdW6qudhyO0qd6I1mNdjfD/CnKzd3mj88smlrfvv91qhQMvp1xcFGFIGeWvrP0sNXVEgNTQ45r83PjKyIxJyQHBfN9TgYyvgGNYK20/KPeU/8Slbo74DwIYwzgBqnaxV3/lseueQSHA8Gi42UbfRE1yUDZaLmdd8jZd/DnaPY0iUO3wpkGSXOEZh4sb1aRxSr0GXZsyex2oLR+TTilMyAvzZDJ2cviLenMAwpJ3pRclJivRoTJ7VVZDphIyPYTGDg6FrvtXBc7bfaSr1b7Z+lAwV9lPyDSLeuQJko8gMQh272g98vhYrAti5YCeQgRy7zOm1qnkcDG8i2lLq7MUIuhxJLEtUh754sEMOcya0hLDBJJg4GD0qqaU3mEYtxNXEWCiL2A+o16tbE29C1s8/Pwy26cgtfk9V0URvgpszgFwl8xQ0Qia+qiPSlY15dtx0+aD6CRVvrcWqcxKSEuJdPxXW6cZVlzM4z3aVREkbLmrzfk1b7dBPjDjzvE+QxL8lj6ve84Ytn1uFJxr3tG+fzZjlAerdgpeJBcWCMl7vSt+IKNjHVx3nUDNQB/MMdOpzOTRvpgGLTLDvbbLcegGuUlQi/SiQxA5lmHUVSC8DqDF0KWVyrjWfkpkYLNXruXdJMPRM+AEeeXnlwSyUw0NbmRgbyfDpB1ucYs9wlIB5Vv4L+hf654PTG3vMMQohFhtpAxbeNL0dJwZHQSUZy5s3P/wOgqW4G/47nkvZVv7nU5fR1vBhDmlb74Z/pApXLeCMVJkkJbwASw==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a201a611-3960-4877-a074-08db294cb798
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 14:09:27.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J7KU7X9L9bzcRRRoIIYtGXGtsWW3mPFCbWS+fpZIoLjS6WW0yHVrp6XTDfD91KweIV995NxRLNLcO89hjQaZUh/mhzrEh8Xv3NXOPjKkN2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7011
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
