Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908A67221AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 11:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjFEJBl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 05:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjFEJBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 05:01:40 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A9683
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685955699; x=1717491699;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=lyQygVKJqeZx6UEJ1sGnVwKhwq8ETe/ErwTZtq9y1RhRoHGmfjDBLYNF
   cWCIa4fyB/eShVApG3vpjCjXiRdw74ERWYJP6VfslTSnVkd3wy+uGjFCo
   d624/JxoRCsB6ur3t0uOtdH/FddXRlc4Ut0CT7xI6C8CHNqTg0bcqdU4S
   qZRBe0htXZIla8XvEys5/sBMqHTXwgAoK98aJVRh7sTmD2MuP0HEmGLn7
   325x7UHcdLFVzrXs8iMWvZyth4yywmhURVN4eEgCsLRyXeNBBz3AZsDJL
   h6ffZP6YHdfH1f2irdvljYKdFqVkJpn6u6HdaXcQ4g3CLgTcUpXU4Zqjo
   A==;
X-IronPort-AV: E=Sophos;i="6.00,217,1681142400"; 
   d="scan'208";a="230635602"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jun 2023 17:01:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kg0wSHi18TW6hnQS5ZSXBOmhqURIyxRhZN/TZhM7VUC6MmQcFWMuP3QeL4Sz6FxfVdljahFo+9/zBXXXc+qy+ZPZfvYIq0xaZkVE8rI1SdI1+EClAL5H3XsNd4BQccYpu+lkpqe/k3nsFDlixNMNvtrsHizB6SH7ACerhGQ5uJbwWw7dIeu7KiXN7xlxPwNZksk2MnXz0zKE4gPYb7iveV46OKQwD4AzC2qR0VCuB6XnyrtSDwuUknSjtbl/HgTAZQpoguPO+5VVvE2RcVh3tV2F9hjtrQO1IIapoT34UzRXuZhPv8stLTejiIq5BM1fL2dclAM9E8IWPA04bOXALQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=RF1j4D5uHbd1ToEG+6CPCmzWZVBnTt7hcLJIxZJGMDF7DJ6LTG+ENV0Wz6RmfkhLl9ch5ZW2+sefb5R8SMBU/WC98lNMnP3RZns6DXI4XRwbrpQfiwfbWlXnM7nyimTPbfOxuCBCFOSjMSCFmt4kmlCtlTJJ9thx6+KCYYVez0xRIQUUuqmNr0UnJI0WJBAIXAuq0mJaj0A2vZ9QOCjH1kBNwqpvU5rWhXg5f2xdFqLhHI6Q5J9BSO0Zl1aaVnx+WYv7pirmkPvMzrMXNsbzK8XIx5MMkETdML2EHY34EZhuHdhKutgErdIabJ/MGgjDxsA80nFHdownje6Po6wLPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=KvSMOfEhMxk7lXx9+Td7GBMSl3N3/MHDzkHdhfRopMKliXNc16tCKPwGQJkWALy1WMNfBZlx+fRtKZQpZtNQYjMYWAQbAlo3VIi25A6FXO1SZaGsMxBt5ZYaoL0xH3gJbeR8eMkQIb7RSLNhNWyXLoZrvtmqW3TlEy03HEVO580=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7330.namprd04.prod.outlook.com (2603:10b6:303:71::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 09:01:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::23cf:dbe4:375c:9936%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 09:01:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] zonefs: use iomap for synchronous direct writes
Thread-Topic: [PATCH v2] zonefs: use iomap for synchronous direct writes
Thread-Index: AQHZlIiFFTk2yyFBY0e+2x5LHAORF69775gA
Date:   Mon, 5 Jun 2023 09:01:36 +0000
Message-ID: <fd23d4c3-2c58-dac6-318c-6e503fab8b37@wdc.com>
References: <20230601125636.205191-1-dlemoal@kernel.org>
In-Reply-To: <20230601125636.205191-1-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7330:EE_
x-ms-office365-filtering-correlation-id: dd6eac6c-4447-42fa-3356-08db65a377b4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M6sQJOD52ex5zlFQ2G6vXGHyxJrnaX2PjHjiWdL/qSAddmDEtwygLnwYqPabrMPdpBHeWOEZR8jxNNHU2k7cqPyULaRJm7mg46E99SkXoKMoxCjmo8joVcTzz+TavQkc2pY5F0pk3WoJIoTniCMTTrq4/JnPa3/k/OQz3qR5GTpq7X3pq24olNvDUcPevLfBST5BY5TQlRWN66B5riWefGvhhuEy5YZEbY8yAoBqqjoFry9dnq4OqY+Y4v6YAT1TiGaHshgtZx5g7OEsQBj2F7R5Gws4dTCfzdjaqrbxBFYW6xWcziXfNG0NrmV7s0fbm+MjxT+wJbvo8cF2d2KrQOmw07GFIYYEFI5H/GXrW9AGW3DvgQobI93kvQOaJ5AlTRWq+Gkr8mrj16LF4/3sSdoEwCYoGkiJownyjVABGfeWuNy84TovlChxF47QOrAg2oQ/Y0LWo0R4EaUcxAiIVecTXz1bb4jJVE/ONGWs2cQgAO2w4gzTG38E37anidp21ouVGOGdprwoR7HVZ3a3eldzRaajSkPJdVk8K2psxvj3Usoa1l7/UjM7VBv74j4IUJ4YeI1MwBpSHynbpSr8ftdE6XZYIRndlibzKZUx2kZ0mH5/vUnzdAtU+a4xVwwCPC2Lt/+Ve1EqdCZTVxXdhIsjMcEzhjRwV0x+pd8Ccd60Flvc0im9tUgdDWTvO0Np
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(478600001)(71200400001)(122000001)(82960400001)(91956017)(38100700002)(4326008)(76116006)(66946007)(36756003)(66556008)(66476007)(66446008)(64756008)(110136005)(8936002)(8676002)(38070700005)(31696002)(86362001)(5660300002)(558084003)(2906002)(41300700001)(316002)(19618925003)(2616005)(6512007)(6506007)(4270600006)(31686004)(186003)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TGR1YjVSeVBTeDJTRGNPUlk5dFVMN3ZCa0RFcE9jMys5UmwrOE9PaHBHbkxn?=
 =?utf-8?B?dWpSZldSUFlCK1FKRXN0dG42THpQVktJK0xCS1phaEZOa21PdWFuVGhwbzlS?=
 =?utf-8?B?R2JiVXJIbWQxNW5yQitnL0R6NkdkRWw0L1d4SFhRMXE0TENldFNWdHA2Q3Fr?=
 =?utf-8?B?aEFldTFXdzdJcmI4RUtiVm5Td3U4d2Naa2dEZjBQUThNUTk5YzdDOENWQ2hh?=
 =?utf-8?B?UHd4R3h6SGVONytZdVIyaFJNQXZMZVVQbEhVVkUzWlFUL1Q5RGxMUUUxRDhS?=
 =?utf-8?B?NXdxcEo3YXFUeUxhNkRzditMQnhTYTBQVlltUnBsWjJyVnkxWmQ0Vm9rUTVh?=
 =?utf-8?B?T0JiYVg0ci9lUm5rSlNlWVpMOExNOEFCTmdmS1JTQkRlTzJtSjFsZjRrQ1Q0?=
 =?utf-8?B?VkhIblpwQTk5ZnF6VWNkbGZFbXBNeW5xN1BzWUxOMGsrVVdpNDVrMFFxUS8x?=
 =?utf-8?B?N1JUYnIxU2JOWmNEMkFicXhzcGRUNEZNUkgwNFlYVVRsRUpZaUEvdk9Rc2xX?=
 =?utf-8?B?eWlEcHluWHlXQUE4TVlmV0dyM1Z5ZHZpVlpQL1ROSjJlSDVTZk9IUXBPeTZR?=
 =?utf-8?B?Vy9xQ3I0Y2NwWFduSWNGc1VmWXVia3FuUGQ5YzhQZ2JTVVlmM2h1SE1ZdWVQ?=
 =?utf-8?B?Y1oyd3RXemt3bldRMXhId0Y3bk15VDhEblh1N0JoMkVZMXlkc3lFNGJqcWcw?=
 =?utf-8?B?VmpjRWlOeWlJcGtvRmEzbm03WFV3aTJwUjhKelRJU0M1bUFNTjQzQzFqQkJy?=
 =?utf-8?B?emFlVi8xdGVGck1HQnhNK2hjSEk1SHNGWFFOc2FkSHI3azBsVHFjcHdpSWJj?=
 =?utf-8?B?NEtRUjVUTFBmWUF6T0hjSDJjc2hPQWc0dG1TWFQ3Y1IrYk5Qa3NRaTVTay9B?=
 =?utf-8?B?YjZqMTE4Z1hEeXg0S0NXVk8wWnBGNFVXNWxSUW9rUTVacStuaVFaSG0wRFdO?=
 =?utf-8?B?TlE1WHdwTFI3d2RLSEhnd0dBQmxqbGpzenhDaHlBdkdxMm9xOElYWFpaT1Iy?=
 =?utf-8?B?T09JMFNXMmgyWXgwMmJRRGlKK0RaaHVZakF3UUx3RDFxTlFNMGJETjJhUWlq?=
 =?utf-8?B?ajhCUURmRUdRS0xkWXZQcWVadHFXRzNVOXJwVDdvbW0rUjBSb202Q3FnVExQ?=
 =?utf-8?B?Vnd1bzBHL2FuazdDNXFaQXEyOFNZSTNOYmJHSG9Gb2wxV0xheTRHWG9WMDFm?=
 =?utf-8?B?UGhHNlJYcHVHZG1xemRJSjJldHlBaEN4b3N6cHlDMEpIcFVnN293aDdsTUw1?=
 =?utf-8?B?VGhVQlpoRDdJOGhFKzY2aTdwVEptU0F6d0NTazRPbnlzUGI1OE11S3hYRmJO?=
 =?utf-8?B?YVBSSjV4N0p3dkh5VFd4OExqN3BuQXZQODJjVmZRZWxCa3YzSFArZS9OR2M2?=
 =?utf-8?B?RUM2S0NFTzJSRGNlajZIYlpuVWdqOUgwaTVrSnpwWWN2VjRxcTVaYU5VZ2Jr?=
 =?utf-8?B?d0U5aEhlaWpSc2tVbDJzblJvZkt6eHMwUnRvbEV5VUVNY1dua2xYZzJ5bUVK?=
 =?utf-8?B?Smt0b0JGSmZ0RkZROUducmlZZDFDTURHUFY0aGcwMk9lNTFQTWM3dXVDalJs?=
 =?utf-8?B?dmVSbHZOUmZNS2F4UStMRHBoOHFrRWJSQ2I0cll0VEg0NC9hTnlLWmxwckFH?=
 =?utf-8?B?TVRRa2ttOHdaZ0ozdVBhOVg1WjREbmk1bEt0aUFUVExaZzJmUjF3Q2RUNGgz?=
 =?utf-8?B?V3ZMeDdOTE1xMXBPNURhcEZ1K0xuMkVLUC9ZNXNZYnIya2k1OU1Vd2pqREkw?=
 =?utf-8?B?SVhNSTlyRGtadkhBTmxuNnA3UXgzc1RiMnovMnNlbXRPWnl6SjB4UVVpTVN3?=
 =?utf-8?B?eDA2RXhaaE5xdFZSai9MZVBOdG8xN1ZDc21UbE5NVHhCemJyNEtJaVhBT2RC?=
 =?utf-8?B?NTFaNU90UkZqOEhLYTFncWcrNGs3YkxuWktSSElLL3d2aWZ2anZXdnJVNnVw?=
 =?utf-8?B?TnJBbDBjQVYrdCt6LzdkSVdyaWFQMUpJZ1Vld3lVUFpaVFVTbFpDWUFBOWly?=
 =?utf-8?B?bTJrc1pWUFpHYVBjMWEzZ21Fa1BnLzlzRlN2SCsxZHUyZFI1OFpkQTJ1YzdD?=
 =?utf-8?B?ZTFQcDdBbEhNdXphcmhyWityTlNxUkpSajZBcnVrcStLbVBGVUk1MzZ5bUZl?=
 =?utf-8?B?Wlp2b2hYbDd0V3V3NWhERUVVVTBCbzlCekNJcHJZT3REblAyTTBEdnJZdlRl?=
 =?utf-8?B?d0x0bmd6QmpOUlFTeWJBT1JPRE5pd2JHU2ttaC93MmR6STdiZ3FLdGJJNEJC?=
 =?utf-8?B?NzRGTDhBdXpqeU9RWHJZMjJEb0lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7FC6327055EA14CBF848787C04CE61D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Ao9p1AbH8LpqpFvpxjX4Kr0cm05wjBetE0jPpsjZGSRYmUT2lJUpOLg04h2KObSfg/audOC0DVNOuhc11bIQwImRWbTiHG4Imu5ngjp5IV6fDGBX2pO4vZIA1nAttkoCdKhpyckIg7GaHosqQ6OtpjSjRRBq7t9jkWzOPS9dtNDJkXoe81/9IibnJOFaPITUK30wwoHhQeXIV4KbFb/iNqghrVUop20VEQ9ya75mHk0vuT3tEXT1ExO1/zyXhR6gUTwXyzIow6NFt0cRiZt3sIrh6qq+6veZh2LBWWl4p4j8/HDAzniH8biskoSScDX4qfbo20Pvdz46Mqu1JkD6XPREcjOtQcoNvk/fBFqwaNp0hdXm07wNHIEwXZTAkQ8AmuB77/mfHQdiVMLYC2w93JbZXbeeb3mEOdHQEwR1kq2/EAIeYm9P2pQhqCyQA4CtLshU+d6qhIC2d2YnE9LjEesDnRQVDxFPScI+DcKJLU14Ek7EhxKEAITkVEvWavAZfdhfRcxsSUQga8bJNTO4WutgLMdpVss4uFeK7ILg3S4fCzlXOdVR2bR2RFCsIFg9GECcB8YcQAqmaMp5UNtq9Xs9oEdX0K9dol25go8J2Gu6RTkAp3OdglKpChG3slIvmrAbINf6ay+irnbkzgB4kmgMqnYSyhtRiMcSLDnZRELclm+nAQ4n7iULE7eDN3okUOdy9Bnnt2orjWOAD21a/X3ze+GojOI4n/gs20YDKAO0DBNXbRyR8V0vfUgsnlhDvu3Hkc/2SQbdY0woMZm64f9OuPOzrtLkqgnRZ66bBJFT9DA24trpqzxh/bKA7Fej030sVsE2FFf3PKgmtY+eJg==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6eac6c-4447-42fa-3356-08db65a377b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 09:01:36.5233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x/kvt1qt22OWRzu5rN+cUS5VXrSeud8EvxcDgb1uZO6jHbWc4Zr2U196jAAJ4CzmQGYPHloYvgpRkvdqpuyQyTnlQTvOr2YELqeWEFqzqTg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7330
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
