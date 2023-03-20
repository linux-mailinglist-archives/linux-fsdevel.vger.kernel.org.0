Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 525AD6C0C5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Mar 2023 09:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjCTIiZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 04:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjCTIiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:38:22 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5D7687
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 01:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679301500; x=1710837500;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=j63fFhKk+hg/VHaFI+IjsygQEUde3EwOqw8r3wYQ9jSsAeIW1iNBOJmw
   4sV2YGpyZSw5RdduHWCmbCQvMCAs8TGJvo/ITOgUsT55zsXUpCouCZZkq
   zBMKlKpGw3Qjk5rOH/nQXsoO22v7GnWvIH2fVIZDmubPz54ljzAXDo+Ab
   V4dXEOhHasx2awvFJ9Nx2DXMd5UlJjYA8COWAejwWl0vrsUdoCnWNhMzW
   9Jeq70mVbVcUf1uVksfnt+1H23YzXhp7mjLBGzosfjRBLHR/09wMrryL+
   JtlguZcNf7uqz+DPLxb8q2o08GGiJbWuDt/VkthTG9vM6Zwj083tNeeBE
   A==;
X-IronPort-AV: E=Sophos;i="5.98,274,1673884800"; 
   d="scan'208";a="330434875"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 20 Mar 2023 16:38:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TuVTBcHysP4WPQrloFVG8m58BnWLmVrsxZvzwb8IKc0i0Lc6cCtbupzjUAIObHblhhW9C1TvKxTx/CDQBDN6vtninev2WyaP0SGKMrE12a7wZNUaefTSSnxFUDJ4yDejMpZ1XLnwxpHOJ3kzV954nanFG6g+8jP5VAHkoOuVvXgSAY9V30PfqEGkQGUR3ek5RZqXcvieriCBLNHw0uXZ5rrXs8IHPt8lPFcQKskX5ap4Ornaqt+u7sxZy+N7Hmf//kVq0FwoC2vmJUjMSMKLTisZli5zdYHkZfcmj2VullXrMMiNn19/EBmgwEycDx2a2Op5sEl+yFeWRGYIQFLDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=lJgJrkvjpkUbkoveoQSInsqkwf7C9QB8zH4wbkSmUc2Gtd6RvX7S04ETUOMBdA0ohW0qOukYpmZPAMDmhNstqIt2VDzaBkIcavnWvacfKy10R+W+3+jmH06l2jowBdzaYwew8ZX03IMEuiPeraavgaWsMqyAy9eBpKjCLDynwbs7G+t84+AwwG93QJub6BaWaGQkYfrmMMyjJJsDar2NDOVLeZBY38fDuDoB3HDiX24rTna0oL96vA1HoTR848a7rdpD87pET9ETySCYirRSM6Ze+jqDPQs9r1sYvFspfinX5OJHNYccFDDC7iMUbYUpr4c7tOukDbp/IQpWkQ3rvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=pVuBdG3wzqAwxBoqPq25h2+7BUp9TLSUzPuXL1i1rjunWft68WtDImM+kDyf10gXt9RXWDBniWaP5eYmzp0grOzDUem5bHBkAyO4R0MlEspTwTf5u/6JH/Jm1QKehuRuCbSblLWnsDG6txy/quN0j+ykhxt0A1pkKzAsbF2Dx/M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6752.namprd04.prod.outlook.com (2603:10b6:208:1ee::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 08:38:17 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%7]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 08:38:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: Prevent uninitialized symbol 'size' warning
Thread-Topic: [PATCH] zonefs: Prevent uninitialized symbol 'size' warning
Thread-Index: AQHZWvcbLK3zTQ3XYEeRpCox2y40ZK8DWLMA
Date:   Mon, 20 Mar 2023 08:38:17 +0000
Message-ID: <db94a4a2-2883-5744-081b-f5bac373594a@wdc.com>
References: <20230320064205.148895-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230320064205.148895-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6752:EE_
x-ms-office365-filtering-correlation-id: 19c356ee-d94c-499c-3d60-08db291e73e4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z9l5MpVPOM3uPQ/w56mi2FvNL6nabiLPFCbX2L5PmoW15EoQ6wDKfDJC4p/Gc3nDEaZTQRZ4i0Vp7ZRFMqvk7ekV1xPVXdrj62zKWxuDBq1Xwq1dHu6hxeGH/K27gOylmpSBN1NBnMJ0FBNQpLGW3OiThTUAnFrkqJgquBudNTO6eIeYK9In++LcFSYYmqzEnPPARzz6/zbdMFV+rDjwW6gXREFFgi5EsQhrXDdP/vBRKywbTOL0g8HCD0ektBYVrgav9oT/mdIPfG+QgJR+K+21SXdLEhSwdCGmLnIHNOEwq15JcAk5Zpqj4N3kVn73/w5khXtGVMkVGQ1THqrR98Dlciy1F7NqYYOt6gSt7CWJB6j+FYIKI4dTcI1dr903W9e9/71DtjFdCBkdmwVHPBt4yeeOYzmh5F4VcgIxtW30vtQbBgpRxSrMbEl2gaL2agcU0L/77W2CTSS7WLlkCPZTWR6C6GWyhVkFzypXMWVkh2yOMmFPaJoH9J9m10hFA4nQxQeo91rPMIM2LnrEs6pIHe9Hyz09po+VAxkqcyDJclng67YFiiTPOWyWD8Qu4H6ifwOPaIdfH5aRgrjYJ31wg5jgB84pV15eRVTJ74nQvYcz8fTRX3iCi81NOQSKDggQY3dt1BQ2At6Poih5CSa3J2jIVG2WDqr2X8pGhfhn1Ehlt2ntO3lEqFWhd/HZ5q8Ed+i+FawtAu6lA9pFFkKZ5I4jji6y0oNy1HZZA3WpKgKHbwgmB5al2ppmw7myN7Qil6pfSUdUkVZ6EwbSVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(451199018)(4270600006)(2616005)(6506007)(6512007)(31686004)(316002)(8676002)(71200400001)(66446008)(186003)(6486002)(64756008)(66556008)(66476007)(91956017)(66946007)(110136005)(478600001)(2906002)(5660300002)(8936002)(41300700001)(122000001)(82960400001)(19618925003)(76116006)(38070700005)(38100700002)(86362001)(31696002)(558084003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TjFmM3pzMXJmR3JaWnZJNTBSajA1UU1wYS96em5aeXpTZHl3Y3FjM1FERVFO?=
 =?utf-8?B?WEVNWTVHdUNvdDdCUWRrcUwza1pJRGFsRGFDMzk3QTFmV0hOcnB1VWRTT1FV?=
 =?utf-8?B?SkFLTHQ5NCtsemRUYzF2WXlKTHZLZU95UkxwbVdndEh2ck5MSjJZZ2w1bU5w?=
 =?utf-8?B?aDhHUHBnRmp1YzJraU9mcGNXOUdaZ3ZqNjZuVTZPKzU4THBZQ1pGUHpvd29V?=
 =?utf-8?B?aHRaOVU1clZYRGFtNFhjZ2h4WGlQQXdHMGtQek9GUk15ZTZacXNobGhmUXhC?=
 =?utf-8?B?OEpUMk9qZm4rVkNHYmFGbVhjVlpsNTcwYmUwSVNuNEpnN2l4ZmtScEQvSUR5?=
 =?utf-8?B?YzlvTnA5NzJ0RFZsdDhsRm9ySExuTGM3M0ZSNFF3dXBuYXlVNUdJeFpPakV3?=
 =?utf-8?B?UUdhdG1vNWcxdm5oL0RPeFlCOUNHMmI0MkZJdzVRZlhrU2d1Z2g3MDRwZG5E?=
 =?utf-8?B?VHR3OVE4T0w2WDY2T1NuVXR5cUx4NDh6bUlRK1ljeG1lZ25UOGV5MmZ2Lzkx?=
 =?utf-8?B?THd0TWJmNk9Qb1lnbEtWQXpUd3RPeHc2WE1DazB3R0pOd2MrVzFWS3d2ZDda?=
 =?utf-8?B?K2pSbjRGOGN3SUJtWnU4WERCdTZsZnJEL1NPdHBTSzRBSEhlc2FnSTlnc3VT?=
 =?utf-8?B?dDdpaU9zUjBYMGl0ZzRheVpacVFCM09mSVc0aTJJdUtja2hUM1o1aDdIclhW?=
 =?utf-8?B?dkl2Uk1xa0pnNEMxYlZvOWZ5a1grUEozUkVWOVJNeGoydjBFWlNud1JKZzdE?=
 =?utf-8?B?bTY0UUVXNXVlNTNmWVhKU2RUeUNiejlYQ0lwcDdid0xQYU8rZWorU2d3ZHQr?=
 =?utf-8?B?ZVQvdlovSVUweUlNamZBeCtNRTQ3d1V0WnZ4L0JzaVRBR3E3SEp6Tkd6RVNN?=
 =?utf-8?B?Z3ZRY0VNTXk2OVZtUGpnTlU5QnFFbHcvMWw5L3dkL29HWUhmZXNvcW5lTGZx?=
 =?utf-8?B?UWRTdks3WW0zakpIS0FLQzNMdW1OcHdLbXAyY292OHI2WFJLSjNPVFZrU1J3?=
 =?utf-8?B?clhwMDZ6eC9FNnE4eldQSjNDczN4RzRIQUZQdEh0b3RPNGsrSHhqSTZUZkhw?=
 =?utf-8?B?eEprL2ZtczFmQmVIZEs5QnM0QmZaL3ZoTktOQWNiYWlPS3NRMTFJWDV4TTFt?=
 =?utf-8?B?QlhyakRuTmZueVhPbXMwdmh2NlNFenBUb1lCVjRPMnVNTjhhWGRGV2JobGdP?=
 =?utf-8?B?ejNWbDRvWnNCMTBURmgxSWFPZXRkYXpiKzJKZnZOQUdrV242OXIvSXJsb1RN?=
 =?utf-8?B?WEpHR1NhYzhYUDBhb2hKbXQxYk93Z1BZRXdGVUtPOC81TVNLN2E5NlRBbnMz?=
 =?utf-8?B?ZjYySS9pNEhuU2FNNEx2WWIvR0NMT2txKzJwSmQ0YnljY05KUnNUbmlqN01X?=
 =?utf-8?B?UjVYRHovNlBTdlR1VHFuR1Z4QWlFVTU5TmZQV3A4N1F3ZVFSYnpGaWYzckNI?=
 =?utf-8?B?V0NJRldKSkdJdHhaREc2bldYWCtFV0I2cy8zVzVhQndBSE5Da0pUVFE4S29W?=
 =?utf-8?B?OFZLQkJBazlhTk9kd1A0azhHNUxHNXRoZWRaYmtQRkhFSkR5R2l4Qkl6Z1Qv?=
 =?utf-8?B?Y2JTNDcvMzhKRFAyaGZST0p5QkVJT3hIbTBDajZaeHlTMU0vd2pjbFM3eXIy?=
 =?utf-8?B?QjJ5YUpXblEwYlE4Z2N0U1BHSG43SjlmVEZsQmt2OGVVZURydFk2VVFxYWtx?=
 =?utf-8?B?a29WSzFsdnQ5bzNNR0RhWUhkRnhpSDR5N3lEWTNSb0NHb25HZmFZRGFRTnhj?=
 =?utf-8?B?TzY1WVJQM0ZSdXVNMlFhTm9VT2lKNGgvTkY3QlROd1UwSm1NRjBpQ29BSENF?=
 =?utf-8?B?cUc5bTBHR2Yxa1VwNFNlUnYvbWprVzJxZlFMN2JJOHkwUWtlYTFHcjNxK0VL?=
 =?utf-8?B?c1ptNWdQMWpxcHlvamdNOVdjbTdtZkNEZjhXSlhEMHd0VStNWTNkYnVESHMr?=
 =?utf-8?B?anM0UC9neEVXcFFYT2loZ0ZxekhlZ2RRai9uRnpaeWRGbWEvVkNlY2s5Tm9q?=
 =?utf-8?B?VkpxRlVHTGp4RmxpMVdQOXNqMW05QWl1eFYyUHk1cGVnRUg0MWd6ZWV1SWFi?=
 =?utf-8?B?WWlreEtrbkdXNU9LUXRiUkNMMjVxSXRDVTZhQnBSWit6L29wclVZa3d2ckFt?=
 =?utf-8?B?RVV2ekJUUmlZUVJ1NEoxV0dObjZaQzlEdUR6dzQxSjRqd2pYWVFLdHpFQm0r?=
 =?utf-8?B?VnhCWnhxMmQzV0kvNTNCYTlUNHk1cStFMVlFSmxJbUNIcXovN2JNQzV6WVFP?=
 =?utf-8?Q?QyWXYXYR30SmMOPZEflIGV9eZdhUnTxc5ccP8ZpK6E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <971543CC77BD4740BB47C32E0B142671@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yU0OrdKKWBu4k30POEqlQ8wMwb79iD96yx8txRpRdud/bx2+Tg7BhHbBHsaimz718ulVbVIjPf0umUHNcfFbNWdMjUExjCDqD1bzhlog4flVkJR8JHKE1eep3SAgl0GTz5FsC9HpwIuS+cywc+jUQSJrlKGABvEokb+LUBTTgTFZKqyL2YCLE98yAGuO2fU7JfprOgb4Iy70DrQlEQmvmwc1kA9k/yR6x6nI4qslsXWIfSv+MpSvdJwgFPRs9yYdl5KaqzCUA5ADxYSSqQOMHheX/IQYeIIBNksRNCulz/tgqj30zD736Lvg81lN2icxl8PpaOQvTtFnbEqRVcSZCnWVQySYQ34TCgK71eNDBPESeHbpmWd5ZQ/OoIN/cS+1IjvgPpSkBWqZKWCSq5Kmjm1UH6c4ULuhp7cql0IXx+s+TDQryXkp9CEfTku4aWr2S+gvH34ZDTU9J8R4FiyGTku4Bv2ksbN6gLKO1vLQ7+bRQ7XPE17ucBWyL4Z+A21qnBbksjFZ7VJ+zNeJIKKcZxxgTxQB/toYNHEPo8vi3j+5Z0tG+1zEcAu8bH+AgG+pccNpt7SpOU0fakQyoS+Wfqlg0pVxP6uOUTwLJVyFBAh8jqL2hN2YFsz0AJ8M8aBzlu3kRVcp7UTW0vuGtHp1pgpQV8bzxY4R7KyXggc1tTzrB6xAcnMkyQTrtOcO9o5URF7+W0VNlS5F1JwPpGdEw7IuT70Q7Jf03y28qgKeKMDniDv88xtTgcmyqv+fSLcSJr847PhsShX04TsilZzD0w==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19c356ee-d94c-499c-3d60-08db291e73e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 08:38:17.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yYQECwYKkZxLAJW+7wjS+pryCWnC8/W5UlUhQjkaaBzfQPEtWBs6FKrShVwJYCo/sltdWDqzE5shMKiZ+1Txpr01gG9eU8HAiYNrA2fpmOU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6752
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
