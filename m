Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6312E6693C6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 11:11:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbjAMKLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 05:11:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjAMKLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:11:25 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27BC50E6C
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 02:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1673604684; x=1705140684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=TJ2oyQfENZ1H8JkRU1wstd718+/eoc7M4kpB5F3KIDCoTAoa3QEM4ysm
   /P9qMmqZo7V1F+hywtP+puyH/uz5cIiESgv/NmxpHxx8ABcgJMR4GRmuu
   lX9jiLZkZUaDnCnG59w3ZVFv26S3WEU0iTYqPoph1YMEAJ2s1ACR7PpFn
   MipMbdMVBfa6Fq6p5r+w1ZtQbINGqLa0gFzbXm7FKoX2BtGUUEQDl6TPD
   2dXacMROsGSTTL0Ei6YyimLXhhCP5HgOdfYAgL8cX1agRDYoJHm8Y6rR5
   kRApEZm44yfVX5FukU7IVKp0UC7Cej5H6lbQsRloQkMph8y9cEpLvpOuN
   Q==;
X-IronPort-AV: E=Sophos;i="5.97,213,1669046400"; 
   d="scan'208";a="220588709"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2023 18:11:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG33QDvYNYK8zT9c7kqVcUjeCXl29Wl0IdFJ88FcbAnSCeNOnilg8UTVT1k+ufjHDwksN4Ch6TuzRACM/2uoD//gHwxFVRUSlNf2p7/9NYsjuyI9s+bB+dh0Yf4Q3oEO4bD/co0B3mJhmChKXBC49cTTY4Hg7t5N9kJrsrk8pFgkYgL03h+Co4bx+x1tbM3b8+LlnqeHfg4rxNGQ6OtbdQaBMeyTqdVqW97Bsotn18NWCulCcoW4d+9yd7aBBay3q872UOVmyRPBjBMWoLrq5sBgrSlLaLXNzX31x4Pnbif35aNQa/fxliqsFh29/9q4O9PDQnpxnLt/Zk7kzgm6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=let4X7FEpTn982zDv32UZXtYPVLBw+GpDbK0+VraD4nNJSUkUbGTCZvAJidD2lENh8/Za7wy5TTj5Ag+Xgexwu8JQXtmW3mJNAEL2dthJeWwFALH2l2/kBxz6iNG9Cwtvklu27PEIVrFAij5v3ni0REtflXcXCmcxbxCxVDcoHna0Lt5RckqBIo/8odqcPv7I1lpmrWxHu9UFILPjHtloA7OyW6gKhC6uppYIWJisST0UCh6ySaKJY0B64Fb3voZtFJ26E/9D97DlrrnQnxw2Gkht85B4oEA2pOC2CeajVOrZQVQdpEDlRxFqvpZpq1L+HU1vSBzSZS0kHQ7exk1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ZQXTkkZ8oNq5kxK5jMLGf24Mar7BRShpi763u8ARP1RrcdXqsP4eMWA4uamCTvDiPVLI4ndIr2tZNs7iKuKEaLU0sCCGLbGATQ0Ue+V8cV42y0AUTwQP4L9krnpOAW91n1mgzx9dcqjVw5zoao74ivWyspIysFU/pjsDgYRn/a8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5727.namprd04.prod.outlook.com (2603:10b6:208:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 10:11:18 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d4bd:b4ef:5bff:2329%4]) with mapi id 15.20.6002.013; Fri, 13 Jan 2023
 10:11:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
Subject: Re: [PATCH 4/7] zonefs: Reduce struct zonefs_inode_info size
Thread-Topic: [PATCH 4/7] zonefs: Reduce struct zonefs_inode_info size
Thread-Index: AQHZJPSq/vgfHkYzfkyILFkfJq6Itq6cJNaA
Date:   Fri, 13 Jan 2023 10:11:17 +0000
Message-ID: <9f496bc6-4e5b-c003-cd63-07c4dc560b94@wdc.com>
References: <20230110130830.246019-1-damien.lemoal@opensource.wdc.com>
 <20230110130830.246019-5-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230110130830.246019-5-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB5727:EE_
x-ms-office365-filtering-correlation-id: 0c6810b1-aaa7-4760-bfe2-08daf54e82e8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNRXwv5bB0UHCPKak/jXMqDsHqrZZvnpuFZYQBt2w/xQ9xtB0uhf7YhMc2Hw08kSp19yVJ/309rknpsoxiZ5fw9jJTBXD/yQmk8ismavvoVSUaJ42vjTI8Ah3lBZDfXUHtaSWdX3XXdI8Ug37ZHjGJLLLij0A43cMnlngiBU7SlvqHUi/9sOZ04EQxdk/CYImIEj2VuHCDKA+K1mq6xlR+xMIRjUmEz0gyHr+xcrvWLt3jCJzl5f6b7IWHj++qOqauHaCf12xCV8vnabiacLLpFU0DOjK0H2kVl3Ns9/seQFRcQVDRAjI62b81TwQDNI0em+vs2/ZC0j33RvmQldiEq4OzecGeRXEQAL7Z+i0YBntCi61KVn7W5bpu/3ojJqdPmzUZyxoTdZeI61RA3UBSaEK7FqIiAwQjMfYIIcwm8lYEB0lPYJ4kUwzzDLrxRnr4uyLcZeLw363sGdU6GZPcVZ3DCt3FTqv5ZSsfgGiIA7ZGVqWUBNm6XVVeXI2TcGyhViRQU7MLIkepIa6QRfSe0Y0wtNjPnURouBTLbMy2zZrgZIQZeja2lqL2qfCKKpsg9aGoTwoW7d0C9sHcRHqgsQ++j70CLSZaCeC9cj8MfeXMNsTxY8BRlPXqncZR/to4DPzOYRRtAWkmtxtU9GxyunKXY7bpAThbg1k4z3iEzhOLjIXGQigrxktiWQB3X7QROCHQa3POxtLOdzO7im2hgLjuyz2XCHCitf2u0E9+LmACCDk7jcvbPEG4N2nvNPVXivtdn6gzi94MHeifqsjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(451199015)(8936002)(41300700001)(5660300002)(19618925003)(6506007)(2906002)(31686004)(66946007)(76116006)(64756008)(66556008)(66476007)(8676002)(4270600006)(122000001)(82960400001)(38100700002)(4326008)(91956017)(66446008)(316002)(36756003)(38070700005)(2616005)(110136005)(6486002)(478600001)(31696002)(86362001)(6512007)(186003)(71200400001)(558084003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEg3T1lFS1hIUUUvc2JUUElDZUdVa2hycGxsaE1DWjFLSmYvMW1VNFZuSE5S?=
 =?utf-8?B?czltM3lzNHVZcEhhK3RDbjhXZCs3V3l2T0lidC9MNUI4ZVNOdng4dWE2SGNu?=
 =?utf-8?B?cVBxYzJkV0JRZXZIc0RlNjhiRTF1MVRVbXhSdFh1ekdNVHVSWm9VS01oMmJy?=
 =?utf-8?B?aFphTkVkTEpaVHE4aGhXV25SekluUjlNc2RRVlRsdHMyaHBQQm1VZVd3ZWdO?=
 =?utf-8?B?eTU4THhzTitBTFAzSjhXSHNiSmpoR2x2YUdodjVmM1d5MFdybTZJb01HeXRt?=
 =?utf-8?B?TE56S3dWUTI5ZFB1RVZsOUMwRHBjT01nSUUvUlhscGpaM1h2WU0yek43N2kw?=
 =?utf-8?B?U1NaSWFmZDBCSzBlc0N5NkN4NVdhWjErT1ZhMURGN1NlMXRTMVZkMDQvOTlZ?=
 =?utf-8?B?Zm5FK1E0V1FJN09RMnE4RFFrY3czUllTT2tLdFhMZzlTSG1ZZkp4QXppb3FQ?=
 =?utf-8?B?K0tod2xCY1BRZHF6YjdpWkRaZERJN0NWOVhxb003TTJGei81VGxJa2hzL0Yz?=
 =?utf-8?B?TWlMeCtGTG0yUmVsK1drdC9BYjJKNGN4QUFPelBvRDR3RnlhY3V3MmNoNWQv?=
 =?utf-8?B?VFhXNUxCUkRaalVpaE4wQXpMUVhsUnhUTzhKQnBaODlxelJOOFo4L1VlK2RY?=
 =?utf-8?B?eWFpMDBYUkFnRENzcUNlNmFmbFRtaUUza3k0bXdjYmpEM2lRRDFiTGVYdEkw?=
 =?utf-8?B?Q2lUamQ3UEFMb1lqdGJ2SThGangxTVZ0dGFhck5qTXN4WnpsZkpqMDdoZDJo?=
 =?utf-8?B?S1VKY3hlVkkyV0VWOW15dmd6SlR5NGpPT3RhVGFNcENNbkVrSFNrUkkzR2FX?=
 =?utf-8?B?TjBTUjZCeGJSVDJlUnBZQXlMVXdoZUhjdkNBYXN2bHU3UkVhMkhMUmpzMzhE?=
 =?utf-8?B?YnBwTkJEUE1NN2UwTXdlcm9HaTROY0phUWJ4YmxvSXh1QjdNa1FySWFQMXFW?=
 =?utf-8?B?T0JOMTFWbzBBTXRocWZLdEJqaWJmczErWW9rLzBRdFNDS25VNERkWTl0djAz?=
 =?utf-8?B?TTk5eW1MeFVIVG5IcElGVlFTMUV5cThjVVpzY01oU0JFbVRHVlc0RU51dFYr?=
 =?utf-8?B?RE90VDdDU0JCaWdWMmFMZ2E5VHlQMFN0YkFObHNqNHJCcGVyMExYOHRtQzF0?=
 =?utf-8?B?M0srcVV4ay9IZDdTSURaOW5iM0haYTQ5R01wTHp3bFJiOW9KVFVrNEc5VjVM?=
 =?utf-8?B?eDFXWEhxNldCbnl6Z3JFRnpmd1dqV1ZSTS9FdXphdjk4NU5VeDJNcWI5Ymhh?=
 =?utf-8?B?UFpET0NWNGtnYjdmV01kOVc5b1pPeUFwWWprd0txemhneE5VOHBDWXhCMkRm?=
 =?utf-8?B?b2ozS1Q2UjZnZE8yWUR0eENLN3BzU3d4SVpVdURnbGpVR1laT2dkUHFJMVBz?=
 =?utf-8?B?Z2puT3d0TTg4V2RyMkk2TkdsOGtQK3ErM1Q3YXZvWEgvU2UwRjZDOFpFR2xk?=
 =?utf-8?B?UFJLMVY5NmpYOFYwU3dXT3h0M01aMVB1ck5vT2RUVVI3Skd0eG5aaGlWeTRi?=
 =?utf-8?B?YVk4K2Y5djhvM0t1VU4zeUdaMXNxTVQ0amMwN2YzdXVaTndSTE5DZ2FpZE00?=
 =?utf-8?B?dHUrWGdveUU0ejllaEJXQngvU1dPYVBXTlVPNkplNDRlalV4NS9hZmc1NEhz?=
 =?utf-8?B?ODZBUVl3Z3hLK04rU1dXWG56Sm9oTFlvOEIwbFdzdWlIbDl1VFBlY2ZwSUkx?=
 =?utf-8?B?MzZPWUVRWUlYcCtuVllZVkR6ME0zcXJsTXZ6TXJsYkw2ZnpnNkxFS2V2RWVq?=
 =?utf-8?B?elN2TVV5a2F1WTQvUytKWFprdlNQbVNUZnFraVZ5QjRrdHVGZHl6QlhvRU1U?=
 =?utf-8?B?TkRUdWQveUowazdna3ozUFJOOHM4SzJGb0NveUhrUmp2S3hSdzdXR0hDYStB?=
 =?utf-8?B?MlVxV2R2ekdXcEJlOGJiTnlGd2dlOVI0a2liUCtreWRPM0o4ZEVKVU1GOVQx?=
 =?utf-8?B?WUhSZXJPa0JOS3JaVVU5TjM4K0FmSW83VUQ1bTJCZnYyTlRFWi9lUjhsTTNT?=
 =?utf-8?B?K0dHMkNxdldPTmwvZ2thaUkxZ2JKTkN5UklWOTBubG1CemJMWTFtS3B4dzBX?=
 =?utf-8?B?aXlkZU9CejBsZSt3eUI3OTN3RkdSS25EaUoxbzk1ZFpxdDZTMGc0aDlEYmZM?=
 =?utf-8?B?Z0JHMmtSTzhUK2F5QnBoWjd2QS9rWGI1R042eEtHdG9Qdm5wYThXMHEyQ2FU?=
 =?utf-8?B?cHoyY0xMTDRmMGtBNFBGdERZd28vM1YvTTRZL1FJM1ZuaTdLeHNZMVFac0th?=
 =?utf-8?Q?jdkiH/6UzgMXSehvJ6ayzZoizezRv1b33XABbRuygQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0CC591899C4C944786D9A93D27C3F079@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vdoTQ2FANO4FEIhgxXqaCknQEQ8HlrC2rt7M8yFK3T/mFXsfbrDX6n3sU3+3Ofb7kGJPxNvdq744WTQP7VoeqjS7SVn5afZP6wFERsewAitYjVJhfsTsjDQ/xNhHzhf7yZ9JJ3UPYuo1mRG7Fbpso4PP5WbUSpjvPPFNa0ZUGKvyOgjDYbZmtoQPwr3Np/G6NjLA1mE+GaRv8pGBf4sOnQUcRTzfmb4Wq6YXM3SDhMZrxD4cHGNxv5Vq04YHJ4hmUfTmbadiF2nbLqNJzM8GY62idJ73nnkezqzDveQyisNf+WGKD+0q94cHn06sMOr5b98JumOpAx+fP8/fNWYmVhD+K+FMPgblc90UetvLfId/qAoOWGX6Wnr/C2J+znfgrkRCwdATVyJU6dUW5+fkiF6WD76ON2K01OPNdKVeoHxAZfOj8nK1PKB01W/8bvXZvRMiDhAFN82UeFSJiGoFU01rf5eTFdnrs2pqYcMoC8Ejyl9MXyhtHiCcqOaurJ5BHeahGqfXQ3ZhIJjrKQ1MoxJL8PoYVt1bH8l9q37ByjMtL4C4b/YJy/haAqH487t9Sc+wKZUcMmTx7UDqlgFKpfFdXI+Ta8QvqpZb6gjq8tlWxGRgRP8cLIqm7l1o5MP1LBLJ6GviUbrVPjlz6gTIs5RFPZWXcm1r0XwmMZFoEXwnne1E7qlQDNExybT6a2otL0G3AAk88IuE+sF8ceaTW+Q3e2jlEMUSJj55bUIgv8aUTsRRV7KDRgqbkdAzgXvMWpOX0X+THXup1Ea05Lpp70SbqtEvY1WYNfx7zw7Fq6k=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6810b1-aaa7-4760-bfe2-08daf54e82e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 10:11:17.8267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc90eIo4G6PPTkGuUuWFjINpJMOdPTwOOqc9T0A05BxoiIGaaw3FdF8UC3+vWVng5dHsUoqVUZmCIQR1ZrhE/ldicERL2UGp7yQiH13Epqo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5727
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
