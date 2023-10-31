Return-Path: <linux-fsdevel+bounces-1604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E697DC409
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 02:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A4B4B20E74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 01:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E25ECD;
	Tue, 31 Oct 2023 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rELrATAD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7741EBF
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 01:56:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2106.outbound.protection.outlook.com [40.92.23.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D7CE6;
	Mon, 30 Oct 2023 18:56:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcV5V6FC6EulIzNRc50kBa6XC88bu25hbMjGeN3GkFMaF4/BcydS8+ciAnNgw3wf24zA+p+Zw8P/jabCHNGF7BWEQd9MxdWpOGmKxiLEHDmDcbX8bcqOPgx+Li+KHyTzvDepYNC00xLI9MHGNdB1+JDmrj5JCvoGO0olmKD/X6/ZnJmf/6iAyzADcj/oF1JQceGARV9eGBVR4iFkwk2C0EDKxAtAefiCuH3ZCfV+DKZEPsV8uvjVUkZBJOOGgu2t9K0KASZuqe0G3uQWNIaclA6BzYwIYsh56Mf5ZRmuYFIP9C1x5wzwGoHFT9r5PbvIpaFry2b449eZ0Fp9gFQYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1cKIt4YTjl+JgtpYfp+qBWwMmlTfYpok9wlLMu/M4Y=;
 b=R00Szw7gNJJM2DTqNHRiB6PCXNPJ0Zwe8IMLb3ybOYcO8fGn8t1We1PDP4CA869QUYsTeJod/u2AmEqkb/0ItzR+PgesUtefY81WskIvX1dp+Q3vbUhmZvvYK+DiH30C0jsy88/dC1Xh5VefRJSQlI3NDJjCUeJ27H8UCC/Ps0zXPOBT/7v8E7eQdl7JZZYXwJ56UmU7cx7gY6BC8TiLfTou1BsZxwbE8gg3Ya4qLmTivVSftaRLGBJFCl+P0qOQUEEG7g/0s8nC4hyKMH1qt5cmTQWH0hBzbbOtavzzggCJ6gMvKLs04mltEL+egooRcdSaC6jO90PJV1KRRdxn5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1cKIt4YTjl+JgtpYfp+qBWwMmlTfYpok9wlLMu/M4Y=;
 b=rELrATADzmmdzC0cwQbWhGSW2FXkBNVu5V77TqPvEG15xAZEEGi1b48NsK8fvvQ641uy1pfOh45YgQnlmGzGjw0WNPvMjhgs3BHy5YYRZPTvcXOuH/HtbjvFIEArb4sP5ynIx65r7J2elLK3OQHsiPyY9xj9wjnCdZ9C4eBd2CpxOhfFFV/615+Lsl3WW47JbcERjsSc9L3ULMngbY2FLI3l6lY3mkyp1ep8iJIWRZfHQF+bFaiNggC+3npktOLuNs9rndcqlx/Ied1lUfZY8DtX3Rv278AIqBRAx6u6/f3ojtdqrNyWeTUPTgfsDFzFFUqFfi1imxmQNuJZO0yWkw==
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1e1::10)
 by DS0PR84MB3626.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:1bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Tue, 31 Oct
 2023 01:56:35 +0000
Received: from MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6]) by MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6761:2623:329a:27d6%3]) with mapi id 15.20.6933.027; Tue, 31 Oct 2023
 01:56:34 +0000
Subject: Re: [PATCH] readahead: Update the file_ra_state.ra_pages with each
 readahead operation
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, tangyouling@kylinos.cn
References: <MW4PR84MB3145AFD512F2C777635765B381A1A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
 <ZT/eCvQ/Iug8GB1l@casper.infradead.org>
From: Youling Tang <youling.tang@outlook.com>
Message-ID:
 <MW4PR84MB31450CAB2035C820B016E3F581A0A@MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM>
Date: Tue, 31 Oct 2023 09:56:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <ZT/eCvQ/Iug8GB1l@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TMN: [0uJCwnfJvWWNhEPOzfmNh9bv4r58Nz0A]
X-ClientProxiedBy: TY2PR04CA0017.apcprd04.prod.outlook.com
 (2603:1096:404:f6::29) To MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
 (2603:10b6:303:1e1::10)
X-Microsoft-Original-Message-ID:
 <68aef890-5239-df10-5819-753f144e724c@outlook.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR84MB3145:EE_|DS0PR84MB3626:EE_
X-MS-Office365-Filtering-Correlation-Id: ed52238f-2062-4e31-5b21-08dbd9b49c66
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P6VW6ITg9Kdoy4x8FZoY3hU+vfQXudakX7PLzyGDrNs/H/Do1zxJOGwqwglbk2JEFDs1nZwBJrqG2uXxb4g8Tm/spGTtuM4x6UKjKA1yJ1rN8o7w0rVloAspna3y35ywwttFJVAlnZT9M8JIs18kOqZFEssU0HP98nI2+QkJ0Bl/oH0hguzUyJlTPk4qw36xzQADYY+ivPLPFJ3y2t7xDMRarjaVBHlAURrN8eRaJ/eVawXoVsfvZ8XGRVAQjOjXWgQnOiNMAoA3tFTizT0td2gOnWdFTsFjusnGwjFFoAtywGut1lfa3Vo3wxurjowxGSQvtbVNT0NpcJ/9h3he2zvUhB2O77Zw1H+PD7pPh3p2dQJ4pZWbnazn7K6MSfKa4hSkMB1BCrxbuzKl2pmQB5d5iN9g3uN6+NqZVLjVxNIlLxfbkkNCbLRJyIOGMqFczSf4yVcQU1Uqoo/eb09wl9D8AJaGREXdKndRmzgplusBReMjEo167OmWY9Ipqc+wN0UzacrmuJB8UQmHrRXX8kHkyjdNiXMMgxbxk+BVKO82JzpcR94rcWhANC44gUP3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGJpWk5hUnI5MTM3SmxnM2ZVd01EWU02dXlqNE9OTUl6T3JiVmRLdUwvdlUv?=
 =?utf-8?B?Z3V3ZjRyWXBiNEUrMjVHdGxBU2JsLzd2RUxURlRLNE5OOEhxaHJHRi9WSGhE?=
 =?utf-8?B?S2l4a09zWFRZNWtQZXFFQ0JKb2dKS1ZRa2hoMFdmS1A0MkxuWVFiZzNOeS9Y?=
 =?utf-8?B?NTczS3E0ZGc5N2x6RGVpR2J6NVZtc1Rqejloc2Z6bHlxb01XOGpZaEJTL2Jz?=
 =?utf-8?B?Mzd3OTZpSVRqaTFLVE1IbGkrWVlHYUJ1RHNncHZJTDZOWERrdjBrT3VxQWpN?=
 =?utf-8?B?dW5MQ25EMzhQZE8yblZLQ3FiMVNGdm1VNlhXaVErMkV1NGFtejBnN1RicmNh?=
 =?utf-8?B?ZjQ3NnZZbS9sZGM4Z0hZMXpwejVNS29id0JVNjFvTVlKNitxV1dqT09neGQ5?=
 =?utf-8?B?TzFZRmJmTUlaeURsdXRDMmNlVTBxN0FGcVArbmlZZXo1Mlh5SzBuMEpvY0dE?=
 =?utf-8?B?Wk1SeTUyRkxLdkFHUmJlenZ1Q3NqS25VOUtiN0g0azFqdzhVdmNNTCt1NjZD?=
 =?utf-8?B?S1NSNjVVTklRRWEwekRxV1VzUWVWQStnVXczZTUvM080Y3o3bS84TXhSbk9u?=
 =?utf-8?B?bUowWU9yWkVPRkNpL1RKekxLSVdVdXFXZnhCN2phWVBCSFc2STBpWSswNlVB?=
 =?utf-8?B?bldkdzBWRTErMGpWNG00NUVvcFZSRGYycU1Kd2FpQzRoZ1o0Tm9VS2tudjFo?=
 =?utf-8?B?N2d2OWZSUzlEMlY1VkZpanZQVis1bTRUZEwrTTY4UVN4NTcrVkduWS9tOFQx?=
 =?utf-8?B?ZXdhYW16RTBLVTF6MnJGSGVBL1o3bG1BUktUTnBGbE1WU3YvSXJsNzVnNk1j?=
 =?utf-8?B?TGRyVWdXTy80NXpWcHdRUDlUK09QendLV3R1MGFHZURjYUJUbTdZY01FZVBw?=
 =?utf-8?B?bisyWUJHVDdqd0p1RkJhOHJ3dkROMDErR2JXVUd0SlVsa3lkQmxCSTRkcDM2?=
 =?utf-8?B?T1R0b21od3FmTThDMEVrWlR6dWx1Q1VwY002eWlsSk4yVjhuQnFQUy9iSmFh?=
 =?utf-8?B?amVLRk54ZlFsMGU1czBncVczRnJmYkRvR0Zha0FSKzQ2ZVBwNkFMMUlVcXY5?=
 =?utf-8?B?UkNRc1ZHRHhoNjV6WCtXNis0OVk2ZFlNbk5mckhKdXdicHRBazdkemRCUUMx?=
 =?utf-8?B?MHpHT0FkVXkyUitvZjcrdjBOOVBvNTdUVHhlbTM5bGNSR2xuTkExUHFEdVV4?=
 =?utf-8?B?VlAwUTBJalJScWMvV0EyVTNTUDZ5NWJnS0F2SUszOUUydW1BakVMOUdYaFJG?=
 =?utf-8?B?NVpacEVwRzVxOXNhR21zV1ZXWlhIdzNsQnlzRFQ5aWJZVUdqeDVpWjNqNHhG?=
 =?utf-8?B?RjF6N3hLeEZ4WDBBbHNkQytNaHRkOXVLSS9Cbmp2SzZLWi84MEY3b3Zic1NB?=
 =?utf-8?B?NXQzeitKUW9oMTkvbTNzTnpkQUYrVnZIVnI2Q2tPUXlKbmxLUlpVbmFycnF3?=
 =?utf-8?B?VDlINDFqQy9WYjNxd2lnY0xvalFrNEdycDlxekx5Uy9jTm1wbU9PcGlSc05V?=
 =?utf-8?B?MkJraDRrWnJJTjVOY3BNTnRKNVFpUFYrNXg2WkRKSzBnMS9MWThHaDRCakl6?=
 =?utf-8?B?NytjWjVlcWZ5Nm5pR00xWCt1NnFvbUx5S0JZYllxSG9pWmhTaktQR0d0b1Jh?=
 =?utf-8?Q?yI1skrjNQiou7TH65mxFtXVvd6Q7n0xco4PqHYY4WpRg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed52238f-2062-4e31-5b21-08dbd9b49c66
X-MS-Exchange-CrossTenant-AuthSource: MW4PR84MB3145.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 01:56:34.8056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR84MB3626

Hi, Matthew

On 2023/10/31 上午12:47, Matthew Wilcox wrote:
> On Mon, Oct 30, 2023 at 03:41:30PM +0800, Youling Tang wrote:
>> From: Youling Tang <tangyouling@kylinos.cn>
>>
>> Changing the read_ahead_kb value midway through a sequential read of a
>> large file found that the ra->ra_pages value remained unchanged (new
>> ra_pages can only be detected the next time the file is opened). Because
>> file_ra_state_init() is only called once in do_dentry_open() in most
>> cases.
>>
>> In ondemand_readahead(), update bdi->ra_pages to ra->ra_pages to ensure
>> that the maximum pages that can be allocated by the readahead algorithm
>> are the same as (read_ahead_kb * 1024) / PAGE_SIZE after read_ahead_kb
>> is modified.
> Explain to me why this is the correct behaviour.
Because I initially expected to immediately improve the current read 
performance
by modifying read_ahead_kb when reading large files sequentially.
> Many things are only initialised at open() time and are not updated until
> the next open().  This is longstanding behaviour that some apps expect.
Thanks for your explanation. I will discard this change if the next open 
update is in line with the
apps expectation.

Thanks,
Youling.

