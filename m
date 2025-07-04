Return-Path: <linux-fsdevel+bounces-53983-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1F3AF9B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 21:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9B7586D9F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 19:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BB3320DD47;
	Fri,  4 Jul 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Adc72UJv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VBc5axRV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914623AD;
	Fri,  4 Jul 2025 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751658593; cv=fail; b=gQqaHNne4AguNxbFhbjV+omK5T/pSSSsu34idSEe/jP072yLaEsEiw7ZrPYQokvqQQITsNTPoJMEJ0GiSGfXT9lc0FFA8EjYJlhIJqwmpsxp8EJxZYlvOAWdvapVHDJPG1OHmDNNKa0fFvC+UNcMglgq89iwWMM0lr9A2ownxIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751658593; c=relaxed/simple;
	bh=c5ubfq1kAYoJzl7WLdAyTkCe4hL8AiG/9fyHL5qPFac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IkEQ/XDwLajPZngUMmPB8lOvGJ3fQoiXcKcWgcQ6j0HC2Z3n83pOZtM2+9C6ol7PzU7mU0PZdM542f0ioanN+uJw31ycaCqF5u2KPRIeYQa+mQJYqkoeqTqxA864bL57a5734zTlbqFSJ4dVJNYy5poLpHTc87MgXPPYYSbHSiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Adc72UJv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VBc5axRV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 564HZFFt016085;
	Fri, 4 Jul 2025 19:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9EgkeH7urAyTme4GWmrMDihbc5w2VlFbuRdcOGMjI+E=; b=
	Adc72UJvDIX5fstVNT35hcH7c29RuzCRedKLSm7loCEa04Rdq3npUAGNW2v+cvnt
	/bFun6P/5giLVXqd+hkV6apKoR9dj6hCX9BBOg4NQx1KU3mCk8F5l7iKaHdEXnQO
	hi1HUiI2sA+lqq2oRRYK4DEJKDJ9I+3fjiCSB7YfMT3iEZA9lGMTk0y8v5PYXZwA
	IGtIkBmFH4CBOgElQV3YF/iex3rBhPXqJyULiuDvQsxKmfuCTARZWssTRWyqPFFp
	td4sNq7Z/TbkfpeKG3bUjs4EjZ//Cme1gCKWh15cmxxbW7Lupbodwr3TgPcKH2p5
	HMf8Ca6I9fjCd/wxRwaoUg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j8xxb5hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 19:49:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 564IXgNc030075;
	Fri, 4 Jul 2025 19:49:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6ue3186-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Jul 2025 19:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rp+5b3PAlwCflOzaGEoYyXMHLnHhO03c85IEIA5PFkvEVTEG6l1/jFoMgM262gtAgIp5xUMfJr/DQvnCAh3eNV6MdP/dT2oy3fcqKxqOoKvLGvclbGzf12XXv9RD5wzRQ9yggCv87w4hX7UNzWgd+1EpRIpt7/BezzZsoL1hg2oADSSS/UwgCetCIBFKkPDLnpd0WygO32Qsm2VlOoTt/B4HZfX4IjqIicfkORt2Nyw9r2oAM3gt9mLgo4SFaOLgbrwslWzB0KpKOEU7icHTe9UCROQzb+f4oKGqGVbYzx1Zi1IvfvYyYmg6p/DRVbqfFvtJAXKmdtyIDI7PZar8gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EgkeH7urAyTme4GWmrMDihbc5w2VlFbuRdcOGMjI+E=;
 b=p9F3salipWpMakxSEOFcKLfzncAXlnqL6H8/JV8bc7Ejws/WKO0S2pgaRyHj2TLEhKK11Y2wmz5hHrY8tLI88QocVHCQRUHZp5d++3scniRBrjjH/qjbipeosrqfBqy7lZTrgLrmQaaEcI32l7Cmcs1KZTLHkN1oITkHQYbt/xo/ItDYz876M0ZQ5iY0k3vdEsK6v3nndvrwwxZZQBexQOJj2OmjD2Y/4ZMU5iqLa468BP/1p58yaP9bVR7gPdWFW+xhzBrWzn2TjwUYztc8u+KdIg1PEFbmJSHx+b21/7ObI5ztPbay3nzBAafl2HBpJ/6v7kwAEx2jD6H1R8n0ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9EgkeH7urAyTme4GWmrMDihbc5w2VlFbuRdcOGMjI+E=;
 b=VBc5axRVKb9hm8YSNWjcsq72Qr4VfMMcS1d4EcfiU3AEN/5SrgsS7B8EzFVE9tHNffMM/59TcsChNZmB+Piu9HKKQ27wBV9j4OQEs2NvHcTJUCulGV4iesVbA+ta0U8Bo+FbYgXPPtHPqWypqvy+r4EC4xwuV4PlUIwf+B4RXjw=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7364.namprd10.prod.outlook.com (2603:10b6:8:fe::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20; Fri, 4 Jul 2025 19:49:42 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 19:49:42 +0000
Message-ID: <9118b28f-05a2-4342-a5f7-f4ff3047cd2e@oracle.com>
Date: Fri, 4 Jul 2025 15:49:40 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
To: Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        keith.mannthey@hammerspace.com
References: <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
 <aFBB_txzX19E-96H@kernel.org> <aFGkV1ILAlmtpGVJ@kernel.org>
 <45f336e1-ff5a-4ac9-92f0-b458628fd73d@oracle.com>
 <aFRwvhM-wdQpTDin@kernel.org>
 <3f91b4eb-6a6b-4a81-bf4e-ba5f4d6b407f@oracle.com>
 <aGgvoWo7p0oI90xE@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aGgvoWo7p0oI90xE@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0025.namprd14.prod.outlook.com
 (2603:10b6:610:60::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2a7535-e809-49be-5d4f-08ddbb33eb7d
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?bk50eWxWdU8zOGFaRlJZUWhrTTBNakdaeEQxTnhMVmFraTVXWnRlamxsaTRK?=
 =?utf-8?B?alpnbDY3a2k5a08xZTN0d3ZaOENoSUN1L3JiR0t3TXhVVU44S0pPTjFna1Zy?=
 =?utf-8?B?ZEdZbVlleW9ZUVhrQ3VUVUlXNjQ0MXV5Tm15dC9hTXg5Nkd0RjkvZFArYWh4?=
 =?utf-8?B?dnRLcW1qOTRPN05iQTJpMUI3bnBZMENRZ3NoSzBzcyt1bXpzc3g5QVhwYVpC?=
 =?utf-8?B?ZXJidmJKKzV0Q0crbW9Od3pUak11S096VldtOHBpb0N4UW42TnN6Zm5zRk1B?=
 =?utf-8?B?ZEoweVNod1pZYnVkbjI4UXdwbWttRldYRTdYY3JXcDRMOVhvYWJ5cE02bVRH?=
 =?utf-8?B?Ny82clVJM0VtZDkwMlBMRUtqVVh3bUEvVkxra055RDV1ZGRVdm1ZL1JqV3RZ?=
 =?utf-8?B?ZDFNT0Z1WnJlZllhWWhSSG1kMWU3eFdrTHFqZ3ZRZG1LNnVXejVsZ0lmdFBC?=
 =?utf-8?B?VzdBZ3VGcWVySnVURFJ3eHQ2ZVdOWlVBWlJTOVYvVUkwUDhtR3ZvQkROL21a?=
 =?utf-8?B?Y3o2Qm1tdWpyM1Fubmpja1ZkNjY1ZHZmWEpDV3FvZGdHeGZOYXpYY1hJZmVq?=
 =?utf-8?B?bnQ4aHM4TjNxbVlCZHIzOVBXSmxGUTRNWS9rMWgvSEh6Q3duQis5U0FSbUV3?=
 =?utf-8?B?M0ZZSWdtT0x3KzhvcGlxYWtjbUsvajBDbHpPK1VKTVdkc25abGZaejZHdFdp?=
 =?utf-8?B?TUlBVGs4S3NWNm1iT0ZqcVBtWHlyNk84SXJsYWdSczA5MFFtVTdCQ1U3bHYw?=
 =?utf-8?B?YjA1MHF6Y05uY0k0RFZOcEx1Y3c2SkwxNTBENHNxbEU1WVpiV1R2aHZXRUls?=
 =?utf-8?B?L1FxRkNqU0Fsa3MzeXd4Vm1VNnhXT3pVZjB6U1E3U0VkUmdEeU0rSHN5cWZY?=
 =?utf-8?B?aVloTFM2Wko5RVQrdk0vTUY1YUZldUdBNDI3OUhKMU1HcUhKck9aSG5GTmhW?=
 =?utf-8?B?cU5hTU4ybVNtZS9DVitWZ1pmVHg0S1NQcHRpUkNJai9Pc3pTWTJGQmoxV1V1?=
 =?utf-8?B?cG10NmVUdzlwOWxKakhVcUJ6Ry9UQTRLNDhvdlhvSDQxaW9KVE10WTUrRWxX?=
 =?utf-8?B?Y001U204NitOaFBJUnBGN2lLVmgzMEp6RjQ0ZGFLYWU1aTluUTJpdkV1RmRG?=
 =?utf-8?B?a256eVZYcm94MmJuQ1hIeXNBOUhlbkkySUZzOHVleDg3dDVPTnc1T0VYUEN6?=
 =?utf-8?B?SktJKzdVcmhzZ3JJdG9sbW9UbE0wS01MT0IzZkM3SWlsck83Nkw5ajJFc0Uy?=
 =?utf-8?B?aUZvWkFBbnJwM3RTUXdOWGtYa2NraUc5aDFOVTFZVXlvd1Bodm5wSGlQUUUy?=
 =?utf-8?B?TjRYUVhyTHJmZGxPM0F0OXZqb3l1NVlSYW5QMUl3MlIxUGdaYlBYVDZON28y?=
 =?utf-8?B?TDI2NVVsTFRQVXJJY2tOSjFISzJVaE5GWGFhODUxVzFJcElEcERQa2NELzBJ?=
 =?utf-8?B?aFYwa204T3AvS3hucUQwOFBmR0E4NTYxdk5lTlp2dWNDSmNXS3dxTlE2K0xU?=
 =?utf-8?B?Zkl3YXFQZFo5ZG4valFzc2ZzeGNHcEtLWCs2MmNWOTZJQWRWUHhkRGtEZUgw?=
 =?utf-8?B?M1BJQndjUEtFaXhRYVRjcmppajVZY0o0enFpTHdVOHFrUTF2M2NWZzRSVmtW?=
 =?utf-8?B?QmorbkFUWHEvQU5nSU1XWmhuTlBmSnhaZUdQOXdSeisxcDkzVThyeXlrMTNt?=
 =?utf-8?B?aE9SVFJiVE1sYVpIdDFDbytCK1NMMGRHWk5EcHNoK0szQ0lGM1AvdkE1ZGJz?=
 =?utf-8?B?U3JITXhaMjRpVG1waDM3bjBRU2JHTDJKRXJ5MXBmcUJ4VzJXdlE1UVVCTHg5?=
 =?utf-8?B?K2hVcDFRRys3eERXOGdRNk04NzlnTEs3R0ZjallXMmFESkUxenE2Y2lMSThs?=
 =?utf-8?B?bWFzT0NGRkNBNlo1SGE0MllrWTByRHdiQ0VobEpmWkJzZmg5cEN4QkhpclU5?=
 =?utf-8?Q?cpKiyh0IYAo=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VE41T1lRYWxRd3JPa1MzZVpWb2FteTROOVZSVnMwYnFvYjRzYlFMR2xQMTFy?=
 =?utf-8?B?OU95RXc5MGV1YURybDlMd05jTHJLd1ZsTlJNNXpKTU9PNEpudFI0QWk1bTR3?=
 =?utf-8?B?blVvR3ZmTThHSDdvSk9FMi9EYTJacm5pMGtBYkZIeERYU1hYYStDT045dTlR?=
 =?utf-8?B?Q2JBQTFlamc3d00zNFhMUE9MWlV2SmZ6ci9menVjR0xMbCt6dU9HdnRiR2lp?=
 =?utf-8?B?OTVIdE1RRXE3eWMvMjVWYi9zNmk5RXBlNVpOSmtsM2tPY1NTUHRUbHRLTjBL?=
 =?utf-8?B?bENiYlJXVDRpTGljUVBzTXdBcktDRkRoU2xsK3A1WEtzMGdtVFpqdWhzd3Jo?=
 =?utf-8?B?ejhUY1BNRzVmTjhUZE9lL3FwYnllS0hSVE5WV1ZJSnRvazd5RE02bGNROUt4?=
 =?utf-8?B?MkNnK2VrVU1EdkY5ZXFVbURpaE1rM2xUVmpKZk9HeTFZZUJUaXVZSC9JSXRL?=
 =?utf-8?B?YTFyMlFhU0Zjdk1rUHlPcytPSGorTG1qRkJCaUFmUFBVd1JrbXJLK3I0SWpl?=
 =?utf-8?B?Q3RoS2p0ZEQ1WDIvcFp5U2Q0SkMxdStCdGNYcUl4MHJMK1BlZlREZG8reTNS?=
 =?utf-8?B?Y0xhSC9DcFpzRVFMMXlHQWV3UmNySmRiRmFwWVd1MlIzQ1hoMjRsK3BWQTh1?=
 =?utf-8?B?SUdOTGRDTWNuYUU0b2ZsVFhBZ2NCRjhNNzNldXhzeWRVRk9IK3lXUHBPUXox?=
 =?utf-8?B?MDNUY2JaTjNNL01BN2tyeFhranVQR2ZLMFJIeWRjMnNqZVZ2V0RVa0tsdFBX?=
 =?utf-8?B?UldYUUJPYmpSbDN0cXV2bENpeFlOd1FxUGtyVFppYzdVRU9BTXErMlYxNTZH?=
 =?utf-8?B?RHJidUFDSjcveE9EN2NwSzFLSTE3Qks4aFlSUjNZTmJGTUNyRUM5MkdWMzZP?=
 =?utf-8?B?TlpGUGhLdVdlOWZFa3VkTDl3em1tdDB0Yjh6SjF1NnVJand4YUxoc1ZHVUFi?=
 =?utf-8?B?VlV6cUI2cThOWmlQTHdnNTFXZnY1OWVRaW56NVQ0a1k1OVdyUGg3RUJzTWNa?=
 =?utf-8?B?N1h2WU9sOXdlVGRrV1JYWllTNEQ0ZjVBRm5uZUxSOUFnMnhCK2hjU2hWVWdE?=
 =?utf-8?B?YmpmTHFtV1Z6NFlxY3BiOG5uZUh4bGFNMTUzOUd4RXZVSzd4MHlGWXovWUdy?=
 =?utf-8?B?eTZuOFFhSUw2UVk0MkRBLzFGd2NnbUJINHZuRjUvUXhMd0c1ZkhvT09ldFRT?=
 =?utf-8?B?NFVLWU9BNVR6aUg3WlNuQkJQVVlnNFNNUTNxN2ZWVE1uaDRzMk1BRTdEaW9a?=
 =?utf-8?B?dTA5Syt3RzFJWmczMjIybGExNUwwUWF6bWU5WW0xZDU3SkhKWFpMdkJTamI5?=
 =?utf-8?B?RGZhaUJRTjhmM1hTMXE1RE5DMlk5WU8raFcwcHdVRjRYeGNrVUZ5Vld4VG5p?=
 =?utf-8?B?OGx3ZC9RRGN4ZXo3cExEZ0tlY2hzN1k2eVk3dXJXaW5wUFVSamJxUE1Wempq?=
 =?utf-8?B?MzEvSFYyVThNb0FLVVVXalkrNEplTUpQRWNtSXpKak5qS0VORjd6cUh4OWVk?=
 =?utf-8?B?MTJYNlBaTUozTm9Mem1tRjJJZVJ5QUtmakZubUUzTUp2R2ZWYytOY1NPRCt6?=
 =?utf-8?B?TjI3YzloWGRuQVlWeFl2ZlBFRXhtOWp2VGNZL0k4TEhNSElNL0QvL2J6TlZQ?=
 =?utf-8?B?SzhtY1pUS3ViMGwrdHF1bnBOeW1TU2puVWcyTE1yU2JDcWtxd1pveUFZeTN5?=
 =?utf-8?B?dHNxaE0ramNSV1pYL29RakpFa1JUVjNGOHNFT29OVHhMWEs5RGxNQTFqOHBG?=
 =?utf-8?B?dXBpd1I5WjJsZ0xid05kN3JJVjg3dXMyaFdiMENtZ1V0NHh4LzlvMVQ4Tlps?=
 =?utf-8?B?ZTcxUWttS2VGZFRqdS8xUGtxNEk4M1FLbllDeE4rUU9LbHk3UDdjZStoYno4?=
 =?utf-8?B?UGNhNXd4VXo4UXZ5ak9mWWFYTWJ4QmgyMzZjVFRJeXdTTUVHZkNRQ3NBQnBT?=
 =?utf-8?B?UEhYeENDaW5uNEE4STF3eXE0NTNwVG9LT01nUCtSR1B1cVNqbkpFcUtsaENi?=
 =?utf-8?B?bFl3TTg3Y2NDWXdPbDE3WWpvSzRSSEwzT3ZJVnRmcjFzM0pwZytVV2JrTng5?=
 =?utf-8?B?OVVadnJMVTE4c0Z4dXNPYm55aFIwNkJ1MUZ6YXlRRmp1aG9XN3RscHBVT05D?=
 =?utf-8?Q?+OUcs6ycX6eEvyMMZ7xmg5zmP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3jGSXKySl0FVi1NV9SDboN3wrBOJroIGHliPpTiowgi9Vlm1YIF4hJFOFN2VhcPLR+P/KTNHnYUhIFIiGITtTIj9w8ZeGEaYDiOC1ma8xTZ3UqRs4lwdvcNf44zL0f+4MGp9jLWqP4vm/L793VXW8jHzMaXb3cCt6lgW8AFCLnjEnMMesrmP92w+StiNZgydESl/lpl9NfmmIme8jq9MAf+zUUUPs7QkvR9t4CgZH69sDKxla6Wk7KLSWeuCNMWs040IhknzUEMDe4ecZMM3HfReXWhfSnsBKPiFXXYHGDbu4l4ZXtBc/M61/p47rk44ujhhGv/uIZONKxn5jc4zPfhCq9QLuzYIB6fLpzskFZneFP2BjbX4uUrun2hDcW4pLN6sAgYm9gEqrV8BZwHfDUwLSd5I7QEgD6Negh35LKD5ftnql7aGUPvW25Rngp4vPa2+DnGLW79o7DcToc3GUt+Diytf7PAjBnzXk8pkthM+YSVGAFPer4ikE7VCBgJZiRAjVg0WiQm5p+23DUKHVOrjju4DmOJjH30ATb8yBgZ+r8uySbk22cBLnykIeTVV+YUZP/lojnPP3U+iqgVNFlKMoA9iOZc8yfRYuHn76t4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2a7535-e809-49be-5d4f-08ddbb33eb7d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 19:49:42.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rb4hTKxL6Spk1stemWwBEegIF4Xufns145t4Lwg43/LI2k1QZ9PgN98LnbWdCvFYtXVpUZLRYRdw7hcsJsSh6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_06,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507040149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDE0OSBTYWx0ZWRfX5KNCfWkb5Hru q8Irm2fizkO4AuGeGPEujTvprDw3r/Fn7+waRJ7mUY9ajzBQCQefecGqLC/I0u4DpyklaIjETIj tA0bZQmqtYanoG/BGdK/WIrk94+4+66SI+41862OMcU+xCAJNKN9FWeE/dOllTthce3+jv7ejZ6
 NPs1FSWaH1PFO/tUO3qL/UsDEbmhFURL6/Er5LueQZ9c8RIS2ugjujVcyHRQObDk1vHZ7DP2Zat OamCj7jzLCaRkOaPXjn/RTlJjoEImBOHHLqwRn8CIpL2MNwNb4Z8VvzQJn2hSHQ/87yJ3+MpjRG AaXskRfxKn9cv8wtjq8FUKNyNlbDmnWyDc56cHShng9PZBlyXZUQwoHbyFwg80stUJTDEoI0rVb
 kGOB1YRG8cHmsQJmBI8Esh2Av9XhwocbEhMuTqa9ji+txXi81k7cyQuV/HUqIXSS5H5YKvpm
X-Proofpoint-ORIG-GUID: f65y9M2XMfUD95n9RfAQcUfcEAN7yvlE
X-Proofpoint-GUID: f65y9M2XMfUD95n9RfAQcUfcEAN7yvlE
X-Authority-Analysis: v=2.4 cv=QfRmvtbv c=1 sm=1 tr=0 ts=6868305a cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=TRtTYcYt5kwXhoch:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8 a=i_E_NpI5xbjsuNmFBSAA:9 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22

On 7/4/25 3:46 PM, Mike Snitzer wrote:
> On Mon, Jun 30, 2025 at 10:50:42AM -0400, Chuck Lever wrote:
>> On 6/19/25 4:19 PM, Mike Snitzer wrote:
>>> On Tue, Jun 17, 2025 at 01:31:23PM -0400, Chuck Lever wrote:
>>>>
>>>> If we were to make all NFS READ operations use O_DIRECT, then of course
>>>> NFSD's splice read should be removed at that point.
>>>
>>> Yes, that makes sense.  I still need to try Christoph's idea (hope to
>>> do so over next 24hrs):
>>> https://lore.kernel.org/linux-nfs/aEu3o9imaQQF9vyg@infradead.org/
>>>
>>> But for now, here is my latest NFSD O_DIRECT/DONTCACHE work, think of
>>> the top 6 commits as a preview of what'll be v2 of this series:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=kernel-6.12.24/nfsd-testing
>>
>> I was waiting for a series repost, but in the meantime...
>>
>> The one thing that caught my eye was the relocation of fh_getattr().
>>
>> - If fh_getattr() is to be moved to fs/nfsd/vfs.c, then it should be
>>   renamed nfsd_getattr() (or similar) to match the API naming
>>   convention in that file.
>>
>> - If fh_getattr() is to keep its current name, then it should be
>>   moved to where the other fh_yada() functions reside, in
>>   fs/nfsd/nfsfh.c
>>
>> In a private tree, I constructed a patch to do the latter. I can
>> post that for comment.
> 
> Hi,
> 
> Sure, I can clean it up to take your patch into account.  Please share
> your patch (either pointer to commit in a branch or via email).
> 
> Tangent to explain why I've fallen off the face of the earth:
> I have just been focused on trying to get client-side misaligned
> O_DIRECT READ IO to be expanded to be DIO-aligned like I did with
> NFSD.  Turns out it is quite involved (took a week of focused
> development to arrive at the fact that NFS client's nfs_page and
> pagelist code's use of memory as an array is entirely incompatiable.
> Discussed with Trond and the way forward would require having NFS
> client fill in xdr_buf's bvec and manage manually.. but that's a
> serious hack.  Better long term goal is to convert xdr_buf over to
> using bio_vec like NFSD is using.
> 
> So rather than do any of that _now_, I just today implemented an NFS
> LOCALIO fallback to issuing the misaligned DIO READ using remote call
> to NFSD (able to do so on a per-IO basis if READ is misaligned).
> Seems to work really well, but does force LOCALIO to go remote (over
> loopback network) just so it can leverage our new NFSD mode to use
> O_DIRECT and expand misaligned writes, which is enabled with:
>   echo 2 > /sys/kernel/debug/nfsd/io_cache_read
> 
> All said, I'll get everything cleaned up and send out v2 of this
> patchset on Monday.  (If you share your patch I can rebase ontop of it
> and hopefully still get v2 out on Monday)

https://lore.kernel.org/linux-nfs/20250702233345.1128154-1-cel@kernel.org/T/#t

But no-one has yet offered an opinion about whether to rename fh_getattr
or move it to fs/nfsd/nfsfh.c. Things might change.


-- 
Chuck Lever

