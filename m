Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B315D741ED5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 05:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjF2Dos (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 23:44:48 -0400
Received: from mail-psaapc01on2125.outbound.protection.outlook.com ([40.107.255.125]:19530
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230447AbjF2Dor (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 23:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNdmt96TFs0lyRQgZ8IQTH5UqVpuvHL7CDZ5Zf4VmbTA4586FD338lIpiSIjXJUGkHqFOzK1XFLtiAy/MlRHeSiQCj5Qq8nFqhx/Rcd1q25e7I2jvC7Y7NZQEUA1EUg3h1UVEm76JQS03xpWNNVh9oh49UMT/ciVLmyint/rn5HtvliEIkBQlJdUD9ZAi7k3hquFFGeo6rTl8D2+6465JL+XLF1IAuSKeP9nOxKr9AWJGJy5flLunAhQ9RTE266ApZGdIAr++TUSMqusSfL83cT6jxfP/zyAPsPUKAjj4y3ks/vVA6qWqOYUm7SRsvQWCTFTfr2jKgGbnHn6VwjA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GbKm/FCqArMGc67sepeNxrec5XpxYd089ot+2J/FL/s=;
 b=Zx99c62WiltOH+q8tKGd3LAJBVmtXL6FTUvvgmJBATg/HD4XBVFxnLSbvaw2NCi2anQBuuPjcMDJu/CYQ2RmdfLAgfIQA1/ce3u0xcST5cP8xyDerTQOtRMje2gAO36+D5y0qGLHsU16DaoNceniw/gLTreEpDEcPk1/cqgQpMaCuXviTp3pwLjVdS1q9iiiXRt27AbYgOZ8o95TsPFfgx/iHdRp58DaUjTjGZTl12qCY8nvWIkJJIwck6l5WCqAESQt6usbrJC3Rq3KX0zPss28djakjx+BtKe3Tx2azVvhwjZfvxvAJAK+V9eTD50AAl47m79mDt3z1UaMEEIi1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GbKm/FCqArMGc67sepeNxrec5XpxYd089ot+2J/FL/s=;
 b=ko8imOsQWVOPcKwUXaXkoaX9+bAaU31TeGo4Uv+Wx0VTlDW44oMhSnnC1vNn1XVMWD+OwuRs31tHcMFV/8kGR83c6w/AWRnDljXVBZQrFxI9FmFr42/KCoUR8AzzIB72YIB5+SqICNKmuvx0jeUappZqQRTa+mebDwYqE6BLPR1/mbELnAX3h1DOp0CWJkg5DbLC2wX2HhdyriZKYb2aflLyahopNyvEzoww1g1CBAE2un6nHAhxrrkmursqJenyAGMVR35v21ERfWY5YxqwT/LPscJWBJoNQNX2F3pky40t2Ji8vCgOI5Ypkx3oB2o620gJ5AKVGRnqm7GWZjBj0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TYSPR06MB6433.apcprd06.prod.outlook.com (2603:1096:400:47a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 03:44:42 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::fa0e:6c06:7474:285c%5]) with mapi id 15.20.6521.023; Thu, 29 Jun 2023
 03:44:42 +0000
Message-ID: <ee27ca83-a144-7468-4515-efa93f01aa43@vivo.com>
Date:   Thu, 29 Jun 2023 11:44:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/7] block: add queue_logical_block_mask() and
 bdev_logical_block_mask()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     axboe@kernel.dk, song@kernel.org, viro@zeniv.linux.org.uk,
        brauner@kernel.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com, hch@infradead.org,
        djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        linux-xfs@vger.kernel.org
References: <20230628093500.68779-1-frank.li@vivo.com>
 <ZJxj6odz49iB5Mmm@casper.infradead.org>
From:   Yangtao Li <frank.li@vivo.com>
In-Reply-To: <ZJxj6odz49iB5Mmm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TYSPR06MB6433:EE_
X-MS-Office365-Filtering-Correlation-Id: 29630706-8e9d-4152-3a2b-08db78532bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i99cAzY5KTZEYK05vF5As5XRfGfxUugkS5p/Z4w5mvxpgx/xVa/JrNMmIcCxS3UKAA2ZStAwRuhlxOK38pE/J//zewH/IdZd9l4JNLKUFpx4llBlpPFQUDbohDjUJVGJk3sz8vPnlZEJCaMJkLWmT405HGiLKmo06p1DQDSrtJJxrv4rpjuNfGXhPdiSmMmiLdqfpVu3FB67kvMp2NwxZ4KkQuwA6flgP2yyzCZk5tKhauUCXeUXzef5MHnU704XbytWsJRFgKvgwX/PLGVa8G4j6fQfXFw1Q4ZRHYE2/vU1sNAXcB32DdCdZSx2yMqe1w5BJw7rb5mcjZjCdQ/NBdli1Unwj/mA3c98mUzFfvEOHGUHmUDkBmdw+z5EqYAO7lfDz5WCVtVf2TCy5JlGoKXRyY6+i/HUphyoSUPOkMbyiYwonL7G6QOk7aO4GjI/d72zNZS9Xf3rkOh6ZwKuv7D6zqsXjY0pBbXpkq1qh73mGh6SlwEFHtykCk6e1lYNcKw6Pg/hFtc7Ej1muSBZITTj2LC1zbf+ABY7uTPb9NfHP0WEL5YeYnAKeFHcP9F3nA5POuAPeQhuRmvWnO3xFMWqMpcXz4v76Ab+JhkvbA7zQZvhdLJoY+GzOvDiAQ6B5V3zBfMEfVfG9Rok0HU0o9v80pGuri/qUptPdThIBbeGCkc0WGOKXK3+uia1sOO1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(31686004)(6512007)(66556008)(66476007)(4326008)(66946007)(36756003)(7416002)(86362001)(6916009)(316002)(38350700002)(41300700001)(8936002)(5660300002)(8676002)(31696002)(38100700002)(478600001)(6506007)(26005)(4744005)(2616005)(2906002)(186003)(6666004)(52116002)(53546011)(6486002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1hWcDMyWHk4L1RhdnRnMHBuSWZadVVOMURuYWIzRzJqN3ROTFIwV3BhaEQy?=
 =?utf-8?B?OXUvR1plREFJMHNIQkg4ckRKcW5ZVE5GaHFqRllGY1BYRW9kdGV2WlNydVp0?=
 =?utf-8?B?ZmZLOXRUbnlVdVUrcGdaQS9INWxpTUhtT1phWFFPWUQ5VGNkSStxNEIzcmtB?=
 =?utf-8?B?MnlSRW03RVJNYXFFeXMzTmV2dEhwcVZyR3lpM2tYMmswcjF3UHdzWkltc05I?=
 =?utf-8?B?Z1FBT3J2anpyVXN4VnhqaTFlS3BXbUFEK0dVSFROaU5DQzEvYzB3VUhsb2Uy?=
 =?utf-8?B?OXB4VzlVenNVL2tlMnQ2S1lZUVpkN1lzTEVtcFR4dEVqZlQ5bmhqM1BscFU0?=
 =?utf-8?B?UGd5RXRWQTlSNkVnbUtLNHB6L245NXlZSTJnc3V6YzlBQmZDdUNMSVpPS05H?=
 =?utf-8?B?cHNJdHYwS0pCdWEzdm0xY3JHcGllandoaW9zeDhRSEN5Z3lyTnpkeXg5V2JQ?=
 =?utf-8?B?ZVJvNjk4NGlVcjNRcjhXVDFLZ2tJeXdWK2MrZkZoQ2lQaHJQWVVqYXoraExR?=
 =?utf-8?B?ZE1xcEcxY0Z6QjludWRyZjJaVnEwSVIra2dpOFZpaVhlQkxsc2VIakdLaXl5?=
 =?utf-8?B?V3NmVnNQU0ZreGtTaUtwdm1zQWlNaUEwY1JYeHNZVnd3TUVwaGFTNU5RVHhN?=
 =?utf-8?B?RXJVZTRiU05YNmQ4aGhYUFRrU0FmSG5jeXExTUY1U3NPNEF6OUV3QnVDNEEw?=
 =?utf-8?B?c2dxQ2ozVlpRKzlWM0l1RzllSHhMN0NmbmhaSml2Ymo2Nzc3QXV0MUpPL2wz?=
 =?utf-8?B?em5ZNFplSW8zSWRrdVpWUlpJc01jUW5vTnlsRk9Vb2dqN3hKTkpGZ0tWL3hF?=
 =?utf-8?B?aUlxdTlsWUtVMndLcnFTUllTTkd3NmpaQVF2NldsTGtHL1pqS2pieWU2VTVD?=
 =?utf-8?B?am1ndzNZQ0JVbi9mYUNMb3k2emxEeVZDOTR1Vkl5UGpxaFkxVDMwSlU0NVln?=
 =?utf-8?B?RVpjcVRxbWJRSGR1b0JKUzMrdGcrdU04UVdLU0ZZTytFUTVIOHloL2FBWmRo?=
 =?utf-8?B?bjAvRVVzRmFhUGVlaVBvQTU5WS9vMk5nRTFTb2dzNkI1SXpPQ0l3SzkvV2pu?=
 =?utf-8?B?VW94RjNiYkh5dCtCMXpTc0RkQmdwQkhUOVNybEVFYXlmZ3VPVjBOcmlKcENh?=
 =?utf-8?B?cEVud2xOa2I4TXdScy9Da3lVNDdsNnFzMUtUWEJNc29kSVAwcHo0djBqajVD?=
 =?utf-8?B?U3AyL3VPOEtyQ2JpemRLQUhNdU51Wk1STlU0bk01L25veVRmSk1vZ3NPcmhJ?=
 =?utf-8?B?TVQzOWVBa2drbzNYL2xxZEc5emFVWGpXSVh6T1FHbXlKL2RwZHVJWnJ0V1p1?=
 =?utf-8?B?QVVLc29IRWp3d1BweHlPY2RlUDZveHZkaEpmdkU2L3AyVlVZYXhvMmFHQ1l2?=
 =?utf-8?B?ckZZZlh3dU5zanY4czhEQ25JREN0aEdQR2xyUUV5SVh0RS9sQkdUaHR4QVJt?=
 =?utf-8?B?QlFGR0tMeDVZWDBrMnhxSlZ3aTA5YjFMTkY2MVNFeUhuVGdjS3Q2SUk0OURy?=
 =?utf-8?B?R3VDaUxQWEpEeEtNSGQ2VWswZ0pLeXR6U2ltYVo2UGRCTDFhbm56Q0VKYUx0?=
 =?utf-8?B?RGFvczk0WFhjdldoMXd2RFl2cU5SK1Q3MFErYyt2SEZFeUNzdUgrYTlHUzNi?=
 =?utf-8?B?aHlUa1FyZ25NcjlkVTltNmhaSTRLS29uc2R5MnJRbVN0dlpuazRrVDhNVHVP?=
 =?utf-8?B?bnRnWHdqTVFwOTdsZUdCaWJDaDlHc2J5VkIyd2NDaDFGdXdGbE5VcDhycXBh?=
 =?utf-8?B?U3RjbHdJdlIrWU1lY3BtcksyTGJ1N1FtVzZZcGhpOE5zRC8wdlorZ3gvdTZK?=
 =?utf-8?B?aXh2am1OVEpYcjBBT1hiTGJ4R2NlQndhRS8zZ3J1c0loVndwNjRZQUt4M0FD?=
 =?utf-8?B?UlpCenJkTjJkVHJFekh2cTBocE1vQUg3blZKWHhJbzlIYnQ5ZnNKa25kTmYv?=
 =?utf-8?B?NkZsNkNqU0FqdGx6L2tvRjRWelpIano1VFJVZHBVeXBXdTE5cmtpVHZuVGhG?=
 =?utf-8?B?dEdlbllhRldXcXhGZG04ekI3L3BRbkJKMFNmVDNEck53M29mWDF1L2ZmSFk3?=
 =?utf-8?B?RFFLN0Uzb0dIdkJXUWZDVFlBN0NpZlBXV0c4S01VQ0NiL1BwejBhakJNTHBr?=
 =?utf-8?Q?YVU6Fj+ZQlfEhECBoDD8s76xr?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29630706-8e9d-4152-3a2b-08db78532bcf
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 03:44:41.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEQfGYhmsrO+wgcOJN8QbCczw65GxZTEgfnJA53ZaDHebqt0SgR6pbbnSIJkmDp7ryB8ACBH25mSOooPtpjUFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6433
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/6/29 0:46, Matthew Wilcox wrote:

> On Wed, Jun 28, 2023 at 05:34:54PM +0800, Yangtao Li wrote:
>> Introduce queue_logical_block_mask() and bdev_logical_block_mask()
>> to simplify code, which replace (queue_logical_block_size(q) - 1)
>> and (bdev_logical_block_size(bdev) - 1).
> The thing is that I know what queue_logical_block_size - 1 does.
> That's the low bits.  _Which_ bits are queue_logical_block_mask?
> The high bits or the low bits?  And before you say "It's obviously",
> we have both ways round in the kernel today.


I guess for this you mentioned, can we name it bdev_logical_block_lmask 
and queue_logical_block_lmask?


Thx,

>
> I am not in favour of this change.  I might be in favour of bool
> queue_logical_block_aligned(q, x), but even then it doesn't seem worth
> the bits.
