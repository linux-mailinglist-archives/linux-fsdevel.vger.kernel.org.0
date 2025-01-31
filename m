Return-Path: <linux-fsdevel+bounces-40499-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1F6A24014
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 17:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA36168101
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 16:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62E31E5708;
	Fri, 31 Jan 2025 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nduDZSf4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QPgJpq45"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA4220318;
	Fri, 31 Jan 2025 16:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738339778; cv=fail; b=g7WDPjgX7+7fMrtMFytUA44RaykWxu2j9/dpRxFthYhjBFSAM0CjtJCfQQ6AON0f5UtC2c6/zvWxg2eIfq3/gFiZo1KLGmZb5h6a+sPsDJPPUFvTSWeWzHmyvZFMcItN0JAIqWnuJBruV9hWHYKqMG5/ClVAqio9THqszVxeziY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738339778; c=relaxed/simple;
	bh=/1IsOu/8qSdO6klnuGZC5SaY0ie1ZMopztsV7TlgkBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3mbNPr89aDnUC8WigsqK7sa07QuDqLrRKuqj43tOIPjyAjmq8cVujGJSVLjlfEcdD73m4TdKYaqTZqcMTtsa2NhcTgPepJUrVo3kPRrO3pJ0q2wOrGVJPjAi3wlthzJ4kLUYrwQdTl6anLDpSZYcb/it+3Wzc6Mn6UAcYSCAdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nduDZSf4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QPgJpq45; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50VFtifg027196;
	Fri, 31 Jan 2025 16:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=x+eXck/VS1zjIPGXjBDaN5SAuzfxxJoMGfZegtDkPl4=; b=
	nduDZSf4jPTBrHRa2u496cv0y1bNq0/EHVm8v8JX/UV1YAJHNgrQmLBiYTwPJBLV
	+gKL4ZHE328HCuDVgim+8HEQ5yDPj59IOkK6xUIPGh6bQDNJRC3MTlZwakxI1bE5
	0hqBujKI2NntPX46NllGaJ6mAC17M73zSF0hXh8neCERPv5KwmncFSfl/gB94Xoe
	IiASVFBkOe5J51ad8Q0xfHSuX9h/WQhsn+1WSk9+W172UL6l7SxnZZiEMA1jarNm
	f0GlUsLm66Fn/FUyQWjwfJOFM49/th0oex4G2TDR7CC1IBCyK9CD9L12HjGPtLEx
	rFjTvP6QaQkmf82jJ8GthQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44h184g2qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:08:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50VEvk4T032251;
	Fri, 31 Jan 2025 16:08:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gf943eqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 16:08:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUytk65oQUJ43CiYpSX87Bk5DYFWlcyvjElBfpHYwhCuVU9KhsK7m4zi5L0ZoB5cfUya7WfrD0JcfZ6IKSrvF27qMdaSrcKfp0qIBQ2r4s0/zAMimrcbc8UcUyJRSzGxbmMnYV/dZKGcyBsVU3sqCytso2CBwyl+OX3o4Rl/PBqULk0p4Hor5wQcuuhC/Qd5R3flU5b7kDQG39+qoZ4T/Tr/DlGM4/K159eAOfMlp/vEWmI0IgHSA26GRneYbnnb0llgMlcJmMjh/zZ5bv9jd5qvcN30wDPtqArVIfmshBvVLQ1vRQnY5EYuePFyKZO7/p/OOmE05Y0FRuMP6chTZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+eXck/VS1zjIPGXjBDaN5SAuzfxxJoMGfZegtDkPl4=;
 b=IDxxKHNW5qUWzs2SnDQGErokPYI4IEpRrB8PG0xasIxVINb6GLbNTyV8lxmnmluSvx8vr8jbtZbJIQvoX+2tASMikHy0rNXh1fbtGR6dn8ie9COcHy3PCK+8vIb9xoyhD6ABk8M3ly/q8dz0mWXelRTOjVQy+5QaKQq93EKtb4vYG/wYXrxFyQftVpYVVCwfvI8wYMXQT4Hgcio5+/0eWPJYXCd4rlw+J/G9yFO7RJbMasI3wCe5LLZbm7nRlS7litiOuA8C/j9yLF58MbAoSirG6tIlZEGH5T+pcbAhhs9qPO+zlVpQga+eBhlua75eLzAhG7pPufzIKiMYlO+5ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+eXck/VS1zjIPGXjBDaN5SAuzfxxJoMGfZegtDkPl4=;
 b=QPgJpq45N/zjmy2ZHCMXKeATOdgHwhJCQB20RJfyYjKiN6zKIt7xGZDmNxYiwEhSXSW5Faphedrn6iK63K90HsSqHm8TbyD9T16bEL5n0pbte2FTpHrVuGZuko8aogIP7teZ0SIxzNO9djkGrrav7Xl1UetQXKsilNbCtTEivCk=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.21; Fri, 31 Jan
 2025 16:08:51 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.020; Fri, 31 Jan 2025
 16:08:51 +0000
Message-ID: <46daaf1f-4dbc-4f61-9fa1-7c6340ab73c7@oracle.com>
Date: Fri, 31 Jan 2025 11:08:49 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Improving iov_iter - and replacing
 scatterlists
To: David Howells <dhowells@redhat.com>, lsf-pc@lists.linux-foundation.org,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: brauner@kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
        linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org
References: <886959.1737148612@warthog.procyon.org.uk>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <886959.1737148612@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:610:b1::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 136480a1-2cb9-43b5-359c-08dd42118d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T25uZ2dBc2owWm5GUTUrR2FzM2pEaThwVGQvUjhHWE94Rit3K1I2ZE5OQ3hW?=
 =?utf-8?B?UEhqM2t6RDdWZnAyS1ZDR1JGdGJxVzhQVVF1YkkrN0U4MnF0c2dxOWlmSGxz?=
 =?utf-8?B?NXpsSGJZMy9OVEVxbDhqVDQvamg2c3RnRGdRS3QwZmZqZEhRWDFNdFp0QmI1?=
 =?utf-8?B?ZEhZaU1CUng2ZDZ6UCtocW1kYlUzSElLZmc4enEybk10Sm1aY21STEZJdXV6?=
 =?utf-8?B?c3Q2Y28yMUV0WWNmTWZmTEM2QlBaMmtRbVZtVFpSTDhyUmRwQ2U3OThvVUxY?=
 =?utf-8?B?dTNmank1UnBvNHVzSmx3MlA4R1R3MUVtcnloK1ZvQTJyZjlJS0Zqc3FlSDdH?=
 =?utf-8?B?T3F4NmJkTXBYVWxEQUhyZzBjWDJEZExvT0JHbDdVYVNIbVptTktyNUZTbHhJ?=
 =?utf-8?B?M3NUU2wxUXV2R2xvVG9pdGxTNjJrdldWc3RvMUpZQXk0djV5UTFqd05YUEZ5?=
 =?utf-8?B?MlZLUk5LYjZnL25zVlVKSmJTZmxIRnp0amJWUjgySWVkbnlQbnQ5MEtWUXNk?=
 =?utf-8?B?cGVjbEJUUzdUZHdVZXpkeVJzRXcra04ydVZaRVlzRkkxY3I0eFBhV3VwamdO?=
 =?utf-8?B?eU5XaFR5NTM2WjgyU0d4TUlMSGkzcEhnaVFSNG9QeUhieXFndlE2UVdoK2R5?=
 =?utf-8?B?N3dXM2FGMDlhU1RvVjc0ZEVJV0ZSY3pURHAxZW02WjgrMzZhTE44Umh6aWtx?=
 =?utf-8?B?OGJSeExMc2RTdEFzUzRSYU1pcWh2WkZJSTlXVEdBWEVSWnJxNzNSNk9lNkhY?=
 =?utf-8?B?NHk4akx3MkJFeHNGWlVKaHRwZ2pIU1lNWFpNMy9JTU50Wkh1RkhsTFExMVZW?=
 =?utf-8?B?QkhFRU05TFlTYUU0Uy9DVi9ubi83a3owc3drVVB4SWx5NFMzeXdOUFZCVmNW?=
 =?utf-8?B?WlVpcktFNFI5K2YrY2w2a0xUemhWNWRlRlVRVENOaEZwV1ZEY05YUTdTdFhm?=
 =?utf-8?B?cTdjdS9qSFczNTB6c0k5MWp6dEdReHh0ajNxdUY5OURVbXZweFRpMzBNRElM?=
 =?utf-8?B?SUFUeDM3YzM3c0hwc2xUclNUU0cxZ3VyZVFXWHJqbDhLd1QrWFB3UFRaQXU3?=
 =?utf-8?B?RjhrMkZ4MTlvRFJBdDdsc01RSU9HelVlblBhRUVYTlRabnlrYU02Y1F5TVk2?=
 =?utf-8?B?cThiV2J4QTBzSTNBMCszVzM5SGRqSWpVLzJVTFl3bktZRTZ0SmdzZEtCNGlR?=
 =?utf-8?B?VTg4bytITTNyTDZCNEVUclpUK3F4NHpvWlhFNjVxOFQ2amlvYUQ0L1Vsdmxa?=
 =?utf-8?B?bEE1TUptZGxDM1M0T2ZHcURaYmtMbHkyeWVtb2sxanJjOWFYZXJpalYxSUwz?=
 =?utf-8?B?bGVqWW5uUzdBUVQ2WWU0M01HKy84REJtMkhCNGhDc1Y1Ris3TW5NUVFFLzRq?=
 =?utf-8?B?dzNHbXpnK1NjczFJcExlVDM0R0M0RjNpYTY0aUZEVkNZM0FkbWJnV1M5WEto?=
 =?utf-8?B?am03S0NBdDVXaXBuMWpUNmxNTFRXakpCSkdaL1JWWHphK1gyRkcxUzVSN1No?=
 =?utf-8?B?d2RaQzVhU2ZXV3pEdVhpNnlWS2ZBV1M2SmlMSXNYTDFPNnhrK3BkUCtuUWxW?=
 =?utf-8?B?R25WcmFNaWtheHhFZjRuM3pNQW11RmxraisxS0JaVWt1bVY5NVlEbUJoMGNL?=
 =?utf-8?B?UHJGUk83RUdlN01KZ1BTTzhPN2lUWGlaQ1VIbXBHSUNKbENCMDBlWHl3VEZR?=
 =?utf-8?B?Zi8wbTVGbzQwNEtacUh4c2kzTU9pWmNad0FtMlBqZldqbEEzZDhmVWxrWWth?=
 =?utf-8?B?Z0gxNEZ1a1NOZ3ZaNVBwcnljd2ZVbHhaZEFydjVMQ0VkSWZXSEJ5L0VZMStV?=
 =?utf-8?B?NmdzcENhQ0s2VGVqbklPMHViVmJ0Umx1NmlmbDBIQy9MSTRhM1FyWFNIWHFF?=
 =?utf-8?Q?/JZfQ0WndXN/O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXN5amhYc0xGN1JJaUp5TzdqZUI2aUFBU2hLS3pxR29CQlp1eXUvSmFmNDM4?=
 =?utf-8?B?M1o5eWxSMHg1Ui9vdm0vR3MvaGtrdVpwamNXOGJjeExsUXdSd0Jqd0hBSm45?=
 =?utf-8?B?cVRwVXdLL1RPcHFQNUZ6bk1FWi9STjI0cWJ2bmo2bzY4bWJmWlBoek1xczVo?=
 =?utf-8?B?LzdYZlFPdFNneFR2Ung3V2hKV1l6MTY4dGFnNGc3L3dSaUlkVTh0SENzRFBG?=
 =?utf-8?B?aWh5dnRqb1ZuTVpLVjRRMkIxb3Byb0JqN3I5L2Q3VTVkNnlvbEF5RlpxaktN?=
 =?utf-8?B?K1o0WnhLRWgvZEIxR3BvR0JtRHFzYkJZcWN1YTN2Wk16NVhnNHJ0eWxZZEd6?=
 =?utf-8?B?WEJNai9qQmxSSkJFOXhWTjZSSFpBNmtGUUxkN2hyN0d3VHc4dEpDbHlORGY5?=
 =?utf-8?B?UzE0eHdLNFBYV3hyRXdFYURTNEo4c1lPSHZwaXNCdlp0SHZPRGtEMU1mN3dD?=
 =?utf-8?B?cDR3VEZkdTFJS3YvaHZSTWJnaUhaMXpYR1lyWVlFVDE5S0Q1K3BqT3hVZlQr?=
 =?utf-8?B?SWM1TDhoelBzOU9QbEJ4Y2N1RmVKSnMzSS9CZXptL2tUWDViOEpNTUt3TklN?=
 =?utf-8?B?OThaSklBUk1lTTBUZzIzVXpMVjY2NTNyTE1pakY1ZDlKY0d2NzBqMmlhWmY1?=
 =?utf-8?B?RXpSVWdFbXZFUWZpNUhJUU5SSjVhOTlqU2lSbURZaGFoZEoxWDIyMGRWQ0NE?=
 =?utf-8?B?ZDRyVU51aDNuR1R4cWtQYVB6TVRYRDcwY2Vhc3VUWTdHbHc4UUJSSkI1RGsy?=
 =?utf-8?B?TVFxNTVYd2hBbHlDaCtuZjduQ3NjNGM4amc0ZVkrL0VHMzRtK1NEbHVSZFZK?=
 =?utf-8?B?RXdGRGJRQXc0bHBoWlRPNXBUdlVNNmt5Mm9FNVZyUlVMV1ArMjl3OVQ5RlNl?=
 =?utf-8?B?dS9ENjBwQkpMckJMbDVGRDl4eUhndi9adFJMYlVtSENpbW95OTZyL3lWdFhM?=
 =?utf-8?B?bGl3TTlQUmhIaHVWeTJqL0dxZVQxYTJVUFRGczZYdkxUYXA3UWMxeElwNFZv?=
 =?utf-8?B?dHFkalBkNVJqVTAydTFYM1R5NjFOUCtZZDc0TXhBTWp4QlpXN1ZVRmRteE55?=
 =?utf-8?B?eDNjeHl0Z09nWDlCSlZPT3VTaXdqaWdRdEg1NDh3SHc4OFJvRS9IYmEvL0tu?=
 =?utf-8?B?cGdjdlJDTHJ0MmtYVkF3SlV6d001OVpXZmZXRFQ2OWxKQTBHM3AzenNSSjl5?=
 =?utf-8?B?R3VlZEgwamY1NXBsTHFwRzlZL0VBdFdtZ3pPQWNjZFQzWnh5QnFyMDExbXo5?=
 =?utf-8?B?ZDhYMU4rb1N1cmJ4dU1LNWRDR2Y1cERwNFQ0ektUQ0luV1YwMUZ6MFl0bU04?=
 =?utf-8?B?Si82dkNqd0RXWmlyajBVNll5aXhpU0RScklETXdFdEpWWUdSQmtrODZzS2ln?=
 =?utf-8?B?RmowQmhiZ09OWWdIVEtXODVXRU5PbVRNSzNad0lqQXliRTBEOVFINXd0ZDRM?=
 =?utf-8?B?YVd0MmZrZVd2Y21hUW1lSlB1MG1rSWZtZzVvdGV5TmJLL05nVi9qYXpya2lN?=
 =?utf-8?B?NnJSNUZZVVZ1eUpnYy9vVHdsdFRleE5LWVh5dGtGaEl3MWlwYXRFV3EzVVFQ?=
 =?utf-8?B?WDY3MW80ekJHbjg3MWNmUmpXdFh5cUMxM0dKRzhOZnBCRGxZRklPdzZiYVcz?=
 =?utf-8?B?c3E0MklydDVDc2d1ZUpydTdEeGc0RDl6Z3J6RW84eUVaQ1J5WXBEU3FWNGV4?=
 =?utf-8?B?MThId0RCdlI4aFB5SWczK3Rzb3Qvby9NS2cveWltU3ZpOS9uZ2p6KzhaM3l3?=
 =?utf-8?B?ekxxTmpWaVJ0TjBxMFk1YnpHNXoybUZDQTdQYzhWenBUSU5SWGRlZHQ4RDBu?=
 =?utf-8?B?aXhDS29Xekp0M3ZINUl4WnkySkpLRitBOHZHSjlBdEl6eTNSOVlsSGowN3VK?=
 =?utf-8?B?YmtFakVyZWE1cTlwRGtUL3VHZURsYXNMR1ZPd3YwWGI1dGZvMzFVeXQxQzg3?=
 =?utf-8?B?eUtFSGRtNC94STBLdGtVZlFNOUl5UlZPYTR4aVlPeHMyR2krNVh5elZ6STA5?=
 =?utf-8?B?eERsQit1SjY4R3h4bmc4WnNOT0VvellNbnFkWHZwWFJqVFFMOEZtc0t6UDBo?=
 =?utf-8?B?YUdPd2FjRWdUVElyck4wcVc1ekJHN0Y4Mm9uVHJDUHI2bENMelNZWHhSL0ln?=
 =?utf-8?B?MEN5Y2V3RTFRUzlEdEZDd0NWQ3J2VXorbDhleGlvcEQ5dU0rTk5lTk5tbStO?=
 =?utf-8?B?MlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	clOtg/d2iiAagQp55zDRBSwzirHUvxXRvHoRu73Pi1t4FQYzygumCsLQ2hdefGQG6+rNHuSOKpN3MluHaVCzevyoejKpTQy/+PJte8ySX5Hnrz2nAWcqz3P9AHkT0OAzDpij0Xk8b+B3VT+FJlsaIbAz98N8O+/7NFkhsEhtvaWcrBnGUUK+Y5qRoCQBeuoS9XBObrefu9hGxr3VyJDWSsMZHlWJXOdq0S0T99QBSIhcHvoBgIduChLPiYNBAC92kYAfzX6fCYWVFCK/2P/96RHUhOQcu/lzg0SC02fZI3u8Mxy23IZh5cAZbMa99HOwCq4+mRhvPEt8WTMzszKUK+mYk5UrCJ0H0DyoiEPxRVkVWHJZoOA5UMYI+Y9cJoQ4pnOmgTEuzSTn/APqPfspKLrS4s+Fb+HnjS54LQrZWAcIXbgcLxtHJt92P0pl+LCQ1V7NYtz524MY0i7O9IxjS3xxu3XlE2874/DqHY54VDw+Anas96eCG/y099tCC5TbvZmph+p4Cn5RyD1TNodeu/gfcswTKq/Yi11QX1gMqbguATGZ3d5DxJAKNf6jy3mpwNYVEAI28qMN9eHHVuvYg+H6kY92hFIEHcjx8tckPkc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136480a1-2cb9-43b5-359c-08dd42118d33
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:08:50.9588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqdkJTXBV1+oGE0RSnn2VwTd7oKtUNTNBPxo0ofOQJMczPgQtNpuXoAfKKKZGqZZY+Sz7NH6/VGB7BGqeIX+zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2501310124
X-Proofpoint-GUID: 2Sc-vSkJRasHS7Jq-d-bXBVckgAH-van
X-Proofpoint-ORIG-GUID: 2Sc-vSkJRasHS7Jq-d-bXBVckgAH-van

On 1/17/25 4:16 PM, David Howells wrote:
> Hi,
> 
> I'd like to propose a discussion of two things: firstly, how might we improve
> iov_iter and, secondly, would it be possible to replace scatterlists.
> 
> [*] First: Improvements to iov_iter.
> 
> I'm trying to get rid of ITER_XARRAY; xarrays are too unstable (in the sense
> that their contents can shift under you).
> 
> I'm trying to replace that with ITER_FOLIOQ instead.  This is a segmented list
> of folios - so it can only hold folios, but has infinite capacity.  How easy
> would it be to extend this to be able to handle some other types of page, such
> as anon pages or stuff that's been spliced out of network receive buffers?
> 
> Would it make sense to be able to have a chain of disparate types of object?
> Say a couple of kmalloc'd buffers, followed by a number of folios, followed by
> another kmalloc'd buffer and mark them such we know which ones can be DMA'd
> and which ones must be copied.
> 
> Currently, the core iteration functions in linux/iov_iter.h each handle a
> specific type of iterable.  I wonder how much performance difference it would
> make to have each item in a list have its own type.  Now, I know, "try it and
> see" is a valid suggestion here.
> 
> Rumour has it that John Hubbard may be working along similar lines, possibly
> just in the area of bio_vecs and ITER_BVEC.
> 
> 
> [*] Second: Can we replace the uses of scatterlist with iov_iter and reduce
> the number of iterator classes we have?
> 
> One reason I'd like to do this is we have iov_iter at user end of the I/O
> stack, and it percolates down to various depths.  For network filesystems, for
> example, the socket API takes iov_iters, so we want to plumb iov_iters all the
> way down if we can - and have the filesystem know at little as possible about
> folios and pages if we can manage it.
> 
> However, one thing that particularly stands out for me is that network
> filesystems often want to use the crypto API - and that means allocating and
> constructing a scatterlist to talk to the crypto API.  Having spent some time
> looking at crypto API, in most places iteration functions are used that mean
> that changing to use an iov_iter might not be so hard.
> 
> That said, one thing that is made use of occasionally with scatterlists is the
> ability to chain something on the front.  That's significantly harder to do
> with iov_iter.
> 
> That that said, one reason it's hard to modify the list attached to an
> iterator is that we allow iterators to be rewound, using state stored in the
> list to go backwards.  I wonder if it might be possible to get rid of
> iov_iter_revert() and use iterator copying instead.

I don't have much to add other than that I am keenly interested in this
area.

The RPC client and server implementations are using bvecs and page
arrays for now. It would be more efficient if these consumers could
move folios from network to file system and back rather than splitting
them into individual pages, and use proper iterators to keep things
straightforward.

It would help us grow the maximum NFS rsize and wsize if we weren't
nailed to arrays of page-sized chunks of data.


-- 
Chuck Lever

