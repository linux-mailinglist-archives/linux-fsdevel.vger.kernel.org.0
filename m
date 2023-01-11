Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFB666015
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbjAKQMX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 11:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAKQMW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 11:12:22 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B14B65AE
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673453540; x=1704989540;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=jhmOXbzF88bUSX9/ilMXCt7sYp1iW2A4MGqq5zz7gndbY9+vpzeRIvy1
   HVp1AIf0H7+GFw3BJDu+lRJVHT04QTSrIE++pqxrIKDTKCcbdoyEDYKDA
   kFVWsYF4G3IjkygKkwm4II1ueR7r2JUxRpHqqJWq0WckrQPKtzQnwaYqW
   ou4GmyVDkabu/UlZCOPU7zTifdActvMn5UI7XcQcDchVYuarERDs+qkip
   SYJ8sQOXZJy6Q2wfsCI0bzWD4iPk2vKcHxpsFEbqlLMM2GgxwIewupL0g
   I24peQvT3vbD9uSlItuyYPmTFdzXuyXmj7dYUjlZ+fkF5p3jh3C8CB0kE
   w==;
X-IronPort-AV: E=Sophos;i="5.96,317,1665417600"; 
   d="scan'208";a="225593147"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2023 00:12:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOcMgVNDQEO2EuHs6DJXInL411dyPTpOAmWOgRE0vqhc1gdp3CNi/Cejtt/WOeXG4vEFgAi4uSDa2Ker720tbWwHb3dsmx3KUPEd8cAlNS4Kd9sSw11TTjufamGwfAC/y2CzLyX+HB0030csOyNJenpWd6QF5NIQXUnL574+Dixj6sf5HxqSusiFDgJyEfO8v5gVRVbJXpD51XoVjKrRFS3bG7D/n7R9yeWahtQWeyYXz/QdSMDPqDtv17Au6+EkTuyA9A3diY82AiCKV+PolaEj3MCz7pgVxLhkjk5VYcT33Kq2ZjHIEqiz8+ZelDciKNLR9c4LIVKIgKnW3WwMkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=C6vRw7Vy7frjK/DvjEu9n/rpBVd+U5997/127O5OkL4im1uZbtDfLFdb8FkrdqeCqQCsFlq3utYtEfP/SBQuinoqIUrWROcQTTOmTWiykinIgVkp8ltlBTT1a6zoujNioFwbsnDi0LJaiIlnIyaZifhsTi66QecjCg4AXV5EmD5lTbTc+Vf6mtuJ+ORpX59d0nZEtDUo+wc0RzgEFN4tEilfFYghBo15bNZVanlERTxWfhaaRMSM4QhDhkTDqDNJtv58RvOYzhdfGHVwpxSN272jvOW+T58su4r1VuX+BgWegeVTgOU5gUmuXH7a4o9sPIcW1bbTdBnvmqf8vWqk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=TcBsbzt1WFN+XHfIGgkK9nJdfou1PceTbdgxZgzEYpUiqFbG2LvJ/M+XyW5rw/opPSoy+a3x0Cf67c9+LeThlkOXlChFdeEincsmmBdF4RNcBXDJpR6mZRuOuskiDrjD6MrvY8e4MAhEhIhQmD0HJEQUQprsq0c3Fw2056I3fX0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6189.namprd04.prod.outlook.com (2603:10b6:208:d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Wed, 11 Jan
 2023 16:12:16 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Wed, 11 Jan 2023
 16:12:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 2/7] zonefs: Reorganize code
Thread-Topic: [PATCH 2/7] zonefs: Reorganize code
Thread-Index: AQHZJPSsDOebqb7CvEOC0bPtgl0xUa6ZZQeA
Date:   Wed, 11 Jan 2023 16:12:15 +0000
Message-ID: <b7019246-d334-3275-d067-46cd801fccd0@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-3-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-3-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6189:EE_
x-ms-office365-filtering-correlation-id: 6463e840-e022-436d-b719-08daf3ee9b38
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H8RckjiK+b/rSLtEu4DfhPL8SLcTqX5DcQEXWh+WsSaWpIL54lm1pd6NNQSEX9ZIlG+FHAoJCG/14MTJyR4KZBpu3i+sIyfWiBLXJU+HwnZXcZbG1hlukD75d84u8/PdvpITml3gFAAFmSY8ygBvQE+KokNEEVlOM6LLUf8V/UFzbLviS9ychsXnYmwGqwqy64S5KS2IqTAUPE7G40zOUApUbDmu+Am2/iLayyDZ959+/inpW+Y+QrXSG2t3cAFhvlDUOkCAuhktmtOGplL/vJ2eXX9F0q9F5R4Ac19OBoiRHuHlZxia1GYis5VrP0UP2weDCbj35UZargXfu+UAR/5coJIKcTGYc6yFH6ka7tJ2l58XTdbbWUPfo0HFE9K3ci+CLRU9EPSnk2VTMX2ZfhCnPe2gJco+miYFEhpYsjxCa//4LFsaQp7wc8vCboHzYSHh+bUnyUo4hLfEwd7ZbJNb0K3YoO/Md9nJEaRrZogxmsUqkx+1ogBpzY7zmHqBZ1hC3bDAaQfxq/g+X7utmjF5UCG/BHHkc+/pOPR0BzfnTm9uIybp53g2Z0TiM+lt44TAr1Ib2zYB4nVOD0h4Hts3ZEbk2/+60/K9iR6YZDA4OAjuTpDDx7qpbe1+cVybFkzF7zxkTD4C9M7zgdz8BzPMoIplIudUqW+Qw/nhTxK52yDD8lE3Ldiu0TUzfku5czX3Hl7cIV+XqwJxXL5wQ+78ScRz4YdsYEaLyr2nnvCvtzqo6GexXbLBar7SE6N8xTyY3wT7PznaMxTIeWjbfQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(4270600006)(2906002)(558084003)(71200400001)(6506007)(6486002)(478600001)(6512007)(186003)(31686004)(316002)(64756008)(76116006)(4326008)(110136005)(36756003)(66556008)(8676002)(66476007)(66946007)(66446008)(2616005)(41300700001)(122000001)(82960400001)(8936002)(38100700002)(5660300002)(19618925003)(91956017)(86362001)(31696002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aEtJeFkvNzgrSm5XazhadFA2WkxXK1NwTmtSRjZLOGwzUmk3OTgvSUUyeEJz?=
 =?utf-8?B?K1doVC92ZWZ5MVdPSVk2d2JocVpQK2IweTJJYk05bjV3NFpEL0hRMnliNjVx?=
 =?utf-8?B?a3JyMlpRM0N5NG5FQmFRcTNJcHBzTVh3TVNrWEwyRHFLSXdhbWFDS3dvWml6?=
 =?utf-8?B?dW5jZS9JZkZZbnpHSGNUN3ZyWG1lTmJWTW1YTVQ1SHo2dFpFUTNUbExFeWFU?=
 =?utf-8?B?Qm94RTZmQVAwcUp4TUpWU01lTmQyelNhWk8zdndFZlpNN255NWNOOE0xalhr?=
 =?utf-8?B?U0RGWjVtcHYvVVN3VGxUcFBGNmNjeGpLMFhBQU9PYTd1MWpkV25oeUlZZW5T?=
 =?utf-8?B?bWlvNXVOQ0g1MHNJZmJjRklaZldzU0lla2JadVdRaHkvenhNdXlXV1hHLzFa?=
 =?utf-8?B?dW1xUFc5VGRvUnVWTW5aTW93bFhZcUVmRGZuNjVZSFhyL3M4ZXp0eFkrODNN?=
 =?utf-8?B?WEFWMzAxc0k4d3c0NlJOcTNkYmFXVGY4S0xUMWtTNlhQQ2VLcHBCdG9lVHpu?=
 =?utf-8?B?dTF1dmdMTlJ0amtsQUsrWXpFNTZxTWkvdnlBOTNlRDF0OE9pdUxmTEpENmJk?=
 =?utf-8?B?Ym85L3AwM0hXSHVIN3JsbVpPWlpGclF3YW12UUR2S3RpMHZtTkQyYzNsWkY4?=
 =?utf-8?B?RXdzMS9obi9jb0U5QzBPZFVCaktCd3NFQnU0Tk5SbU9iWWNRTlJSV2gveElV?=
 =?utf-8?B?SDdvRmJYaVFjSUZ6ZzlTUGd5WG9hRk5BRmxNYy9JRzJFK0tJTUNQN1NrNzdu?=
 =?utf-8?B?UGpud3l2UWJsZmNUZGdZNDZpbDFYMDNIZnVReExRWlFXUHA5ODNheWhPMHkr?=
 =?utf-8?B?VFJOVEtKZWJqRFlia2xoRVhxV2RKcGY5Tjl5d1JxSXFDQjV4cTk4VUVvZk9k?=
 =?utf-8?B?UXJVc2JnQTVmQmJYS1daUFBtZ1VGTzBGQlQrd0VLbGQxSTh6clUremNLVGor?=
 =?utf-8?B?UjIzTG1abEVoNjY4b0J5UTV4cXZORW9oYnN3TUZXK0N2bmdSUytiOFliUVMz?=
 =?utf-8?B?czR1VXV3Vm1zU1J2aENaMjZHcEk5em9LUVZ2anVwT3ZNRnMyTlloWmp6NG4x?=
 =?utf-8?B?cTEwTFFOTmNteEpIY0lJZ3A2RnhlbWMvL3dlNW9KOTd0VGx6ZUlqWWZZMFJW?=
 =?utf-8?B?QUxGRjVSMVpJcWZHTVk5Vm1NL0RQQ3VoZlNJdGJacmxiR1RNRFdESmJUOCsz?=
 =?utf-8?B?MzZBZDZUT2ExRFIvVWoxaFgrdTVXcURsSVNLQkdRZHo0WlJmOXc2c3BFMTZu?=
 =?utf-8?B?dEd2eVRZZjRZSnc3SGVZRHVRaVQyd2dVQ3l3KzFybEFHTkcxUzQ0Q3FkaWRx?=
 =?utf-8?B?ZkdKejR3Skg1bGNic3ZmVFFYczExNEk3Q09mWkhNOUpxdDZpZDJKa3FTam5Y?=
 =?utf-8?B?Mm44OW9Sd2xaalRxd2JoQjFhQ3k0K2J3ZXVWVEM3WFE2S0NtSFk4cFhkWGpx?=
 =?utf-8?B?ZDF5VGZHdjJkdUQzdEZ1bzdVZWJYL1lWUnorL3hadmk1WVFXN2swdlJmZU01?=
 =?utf-8?B?Wno1QWttOHVTc2x3ek10UzU4NFZ6ZXoxKy96ZWFNZjVZYk9lVHVpN1hjYmsv?=
 =?utf-8?B?MkgvUkZTV1R4LzJSTVNJOHB5Zmt4ZVdXbmtmaTdNUzhoblRvVkxpNDdvZHA4?=
 =?utf-8?B?L09MN1F2bm9rWTAyUXZON2JwZHgwazIxa0VlNDIxR0ZEbDQ5Qm0rdkNIMWd1?=
 =?utf-8?B?YUVNS0MvUW1XWmZjVGxRL0ZJOXZjYm81Z0gzczQyMWlYRDhEK0xMamZwa25o?=
 =?utf-8?B?ZktDbEpwVUZZUGJKcm5MR2libUVaQWVyVnIrUTBJSXNaMXpDcmI0SEl0SURm?=
 =?utf-8?B?RC9WTWZacFBlUkZRRmFqS3Zaczh3ZVg4eEY5Vk1UUGRoMHVJdllaL2kvdzMr?=
 =?utf-8?B?MlZTeW80RjVLWGlSSlhtQWM2N2hBTlQvbm1NcWRCcFJndk5VemdMUUt0VFU3?=
 =?utf-8?B?ajhsM2NuSGJ6L2prcFJWVW9qL3NjQ3U1SHB2UTNMdzhjSmJueGkxcDVXNWtY?=
 =?utf-8?B?b3FUMzV5WVk4N0VvNkdabG8yc0Jaei9zbmpFR3VLdyt6ZWdocnVRUkY2TEs3?=
 =?utf-8?B?OFpwbm4yRFFHWE1LaEEwOE5STURoVkM4ZUlkZlIxRmRLWnpTVDhkVUtCZ29a?=
 =?utf-8?B?bzNQRW5JUE5vK2xzWXBZZ29HNzI3WVZHMVBBVlRaNXk2K3Vld1N0YThSUUtS?=
 =?utf-8?B?UFFsTzk1VVhnejY4ZWZSd1MrVFBsNGhBUURna1dpMkJHdmNRaVg0dldEUjBn?=
 =?utf-8?Q?tHlhfdCrainMCgGohQMHl/+YDtj/iRJQwputgoW+n8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10479B6773AC4341A6B01A63412F8B1D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ih2n1jxdjMKmuCl5k7MKet2+JRid9PH6D0gqi2YOMxzGDf4pnDpkGxKqZT3lM0ULp4Mmmxk41zvJQyNiQqXVPCI0cxWXXu59GROCX2P6850GriA4YaIaLbY4p+r5bJGyi1bw5ggPDcIcQ3DGMV3IKrHC14kwCXKxSPofGYpDG4OrJNIb76GcKvanOHIfgJ4ypK0Bh0ocfMfEg/Ue9+X/RiNhfOcAwOrkW/fyzvOQgIDj6W8EzBNWOpdWAiTazxo0paQIYjfSSabqev2vvV51Hw7t9wHHnZ08/jk6pQN2Yz2Li7B5MJpG2pdC9uzcjiwhl6TKssdgylQgD4G/GHiYsm221uo5D6BWkvksdxr4ji8ChSSOhguS6GfV0zMUbd91NsbiaKsX3ryIYITfaxUl+vQtYQy0VUpMHxKIEnLfI6qwitbxe0qWNpqMplKTQHROU0f8tnFIyhwVAE7WHtXrpoUY4HB1n/sJSnZg1gA9lEnoGMiz83u9jjaqlCL0LbU3aaGBzVIZzj3ksRnvk6NLh8gBcoEuhDaphWTqJF7wEUeqCSqnZEfMAqsiWY7bWXlMtep65N5yVkv9YEJdljuB5pk2WxHDOVws9cWeVeAlD+xnx2gaqGdmnncOZ78VUnJJ9IB+/HEJseECS/5EAMjNWtU/G93wkzEfpafcCZ1QDK/eYIIbR004rGt+044LjwL6YzkO8mdxSes/2TMybC2qEI0vxkZbP8S/EEMK+TKhz1HNck94Ucgz6McZVMa6TA2O7b883EdcFSPo5ZZ8YL1uYQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6463e840-e022-436d-b719-08daf3ee9b38
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 16:12:15.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkSHfcRtomigoHiRvKZoYk0SZRkO+Muh4I6yQ8UTZFGSHGr/kgkAw6G7Tc16bkW/ejWzB2YCPPZZsB01VRJEV5Pjyk1QN0sKZ4QNntib7v0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6189
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
