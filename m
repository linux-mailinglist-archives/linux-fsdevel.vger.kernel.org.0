Return-Path: <linux-fsdevel+bounces-78767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDTEAlzxoWnYxQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:32:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 618451BCD5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 20:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 789EE3073F4F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E1F39E17E;
	Fri, 27 Feb 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MbqkTNqh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F2835B654
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772220576; cv=fail; b=rAAZp7c0gl3OVSXkzuJAorgIdwdMlUS9WnpNYT127WJ9AzD2h47cElyA5KW62cWW4l7RSXF3qF+4/uK6RXMGcfHvUMI35aNf8qzcgsefCZ9SJi4wcuWaStcpUNmRAwY0dZDNocDCLOUWPjzqvdkjh+Gvbwmy5QrMZIi7i3TULxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772220576; c=relaxed/simple;
	bh=NGNyqk5TuSXasLrlVbHY3Zyj/gmaoSzk8E6Tpq7fmXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQBw4XiMZA9/em84HG01ToZu3VH4rxLm0VG87VHaeHOJi8GQF5OwPqlJGrEAcSRyVFlym/X9wtvy5HB3pOROgosClsduLVmuaK0R1AtXUvmVRwEPq0tElGYgZhDyRWh2WKybOicPFEs79zqnxXk/FJpoStHDYi6CTy8AggUaW94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MbqkTNqh; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCXKKxlkPslN6v53+Q8qVdXxzSlHjlUCTUXRzgP+vobF5ab9Y1/1CQggqiU/u7aU97p7Hb6NMEW3GCIQOqrZVgcpdts1I4U5zyG8Jbtm6wdCdQB9SyS07GpjtoJr6sMVYykZ4OTDiuybGWiMSVF88okuZRyNk39rMXhobqMLVCAsyJSudXHu8L1yBIl49shEsbNpqep5AyvE2GfhYaZbuGCdUFId4kkLIQ6Fd7a/3HPhx7MagvTR1xgxIca0KsPJIqV6FpfGMH9mwbHQzDXj+r0n5gH5+7LpxjdYbeUr1EHWw1wFInoGAPK7KEsumay6HTIijUyrQoQK4ZV7UKqxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqOvhgHxxA6tbsCi6vwEklCq2IoKlU6xaXjDCV35SJE=;
 b=e+sLZyGDQw0er/wM5JnwYflJryXqElvkQn7SzArd5Vi9/m6dds3tuAEFRnZhh5hFiOH1BsWm0kMYi6BLIzOTLPJCo2S1KNYbk2/lgwQLG2g1cQASJq8QdglkA72BCvd0vrOpz54JNqmuZhjzZ/Gu495wtlbWv68BIO/YmWPmnht42Qh4QSCRORlioqPRAkd94JoSmoaLPKA32xYa7V/d6Q6RqpNzF2fwV6nci3wupT0zqAQuQJNKrfMmklRZZPoxYEi7Izgh1tTJSxkeac20tGAypDy6xQpLs4510V3JC9EMwzpsB1dbxRKHYaYp18ymvnGz2zqln3V83s1Luc6nnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqOvhgHxxA6tbsCi6vwEklCq2IoKlU6xaXjDCV35SJE=;
 b=MbqkTNqhRxvshVNb4snpBhsO2NCuXvIdepgrmhZcen37fQ0wfoQ0A/zC1I0Cre8rrxHYI+aiXGHrTl7Nb9nkufwL8ZOmxxG5gy1lJYLZdishdfzY91qTw/oHbidT62+uBgLzIVd8ucmflFIfllDXQ+6d8pbaYH2Ez8sgPLSS2GQST3DQFIeXzy4T/TKXO5m1TMLOCPTCzkk3k8Omt3KawqdEwD6rRKdu+ADkofeR6ZpDhZUkleCpt270m6w1pCHUv3WP7VYyqJHqcQZ/iRv9VL0EaBgCSsYx8Lker+NwC3A7gM/+a8y8TzyTUDpzmbBcSTMVKRZco9zlQ61UkdqGPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 19:29:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 19:29:30 +0000
From: Zi Yan <ziy@nvidia.com>
To: Bas van Dijk <bas@dfinity.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, regressions@lists.linux.dev,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>
Subject: Re: [External Sender] [REGRESSION] madvise(MADV_REMOVE) corrupts
 pages in THP-backed MAP_SHARED memfd (bisected to 7460b470a131)
Date: Fri, 27 Feb 2026 14:29:25 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <2EECA9B4-E1F0-42FF-9E61-3E4AC4B4DC13@nvidia.com>
In-Reply-To: <CAKNNEtwZzt3xWh_b1pn4X4FG+cq6FLOP5rR4+G=WUsjHsJRjaA@mail.gmail.com>
References: <CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com>
 <CB5EF1C4-6285-4EEC-ABD0-A8870E7241E8@nvidia.com>
 <D4BD80F5-6CA2-42E1-B826-92EACD77A3F3@nvidia.com>
 <CAKNNEtwZzt3xWh_b1pn4X4FG+cq6FLOP5rR4+G=WUsjHsJRjaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: ca251c79-0168-4647-5731-08de763686ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	+f3nQX2UetkGvf1MltWf1ivkMCtvkXuSF4zvLQB8tnfBqVNkr+gLeh7IgyRipgGKZ5csAIaH48G6So6M/ZGkd1U2ZpyrviEC8Xk133/NNDsS6uRLU7vOrgc277mt/TxeQGXz1Xbk9lXWw0r3NVRpvPcTiKKt0UiYEWajlOnZ4KyiKr/aJPm0/5AJf8MUgtFmYH6F2lPxQurBhLDq9cSY1hhiO9icjw2fcE8EyxdHdSHFI6WFXvcTBr/k/BUQNgiLCblStpa7aC1xCUbp/TjbtYNl10e/GHlyJyiRDllH08Yf5J2PcGAbeFO1ZwT7tLyrbEVwcWRIXhhvjX9q8Otpj2G3C0uId6FCRYaVflv/lpEuQkbQUNkQQtLsTZQBfPqLVT7VyAlbGlaAjAQsYZ5GTheJUAneTfKvhYNozI3Obj+lGs5ZdYYyi+4F/LbdOYNBKqhjD5ocuLYhAq4lQ/y3qhMQ4hxJLKYFzc133soQBRzzwy9NpvojYb1PM7vciePmpXF7tZTmAYhnnbDMpuSX9fp/TLnsoLc0nkqJeOZgD26hfF7fiUzkjByyvbmG+Vm6gdUwL6Yi/uKgD896TTkrOIXg3xXK10j6jdetAVDODSswy9wGESiuCPHlLtOLvrHTiEyBXfLGDrdKenInOsglazlL4Rji750gjGn4wQA1OtT+sTRWLd89Wv1T3Hj8s+Y/nXbiOZqRCzOayjMPDWWKs9PCWeXSFxjpkdPtiPV36WSoEOEAj6wc5Ql3cC6OFewE
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnhPUXVIZWlRT0M2MnZJUFJHZWNRWFRPbFRuK2NoZTgraTc2ejJ6Zzk2NTB6?=
 =?utf-8?B?eEtxenRoZUJMQzFXbnVZZU85b3BBbGd2MDZURURYaUNWN3ArOFFyRjdxZDdv?=
 =?utf-8?B?TGlzTTF2YlZTNVA5d0E3OFZab1d5eDFucGgzNnA2ZFlPT1J3RE02THNpWlF2?=
 =?utf-8?B?RDlHRFlMUUQzRHZzTkFBbVNTVmw0Z05NZHNLUnA1STFDeGNIYTVoZ2I4dWJk?=
 =?utf-8?B?djBTZEJTb25aSDZnTU56U3lDYzd5NmRUanUzSWQvQlpPY1p1eFRGaWpiM05m?=
 =?utf-8?B?UlRCeXJtL3Z5Q3NqYm8xdFJ3cG5sMkU3TjVidlNzc25zZm5qTmJkWjdOSjBq?=
 =?utf-8?B?VlZhM0E2YkdZZnFiVkV2cjVsQU9qNUtBbXoyVnBLdGNSbnNnZ0FTY1FxekJn?=
 =?utf-8?B?dFd3dTBJYkgwZXF4RHNtV0dLTXh4RkV2WmF5NHlSU1JUWWZQVDI1Qzh4M3VT?=
 =?utf-8?B?VG0wckdwZDRLN1ZLREZFaWtGZEcva3ZnbkxmaENmeDIvU0hBUXZCZlVJY3lV?=
 =?utf-8?B?TFhmRHZxVUJvR09nKzBvKzQ4dnladU5td1FOc3NQYXNkY0xEK3lEa0Q5aUdl?=
 =?utf-8?B?UVNHTVJFVENtVFRwOEVxa21rVm1YZmJOM3c1VXUxSWNvSTZRMWlJMko5VkdS?=
 =?utf-8?B?L3hYQWNhUU0ybHZBaVhMaXVJMURtaGUyKytIaTZHaUx5RGZaYzJZL3V6dHRB?=
 =?utf-8?B?R3Y3bTk1QUhxeUVNRm5wS3o5KzhHSnd5dWJmUlZVZmdqeG9obG10YXU0N2hl?=
 =?utf-8?B?YjBtT1d2ZlpyOUl5QmkvQWIzMFViQ1EybGZLZTA2TlFxVmFnT1AzOHpKb2FG?=
 =?utf-8?B?VzRiZkNJM2VKVEJMbjFFdnlZMGNxK2hLUlNJWDZrOGZyUzN2Rk1FeGJvSXdY?=
 =?utf-8?B?QWxwdEtLc0ZlQ1hLeWRTSEw5SkJDa0dWUkhRMUdnR1krN2hSZ3RDUWNCeVg3?=
 =?utf-8?B?VFhvSmdsVEZSWU9VSWZ6a0tnNHZmK21pR0lzWDVOY2plNVQ4VHhLYUtBY1Y1?=
 =?utf-8?B?NTVaK0M5YWZreU1Zd1c0QmxJeXA4V2YxVXgxQlR3K2RoRDRicjltN203VXc0?=
 =?utf-8?B?bUc0ck5IcHRUZmQwN2kydDlqK3RqeHh4bGVBUkpzUFVTZklOQkVDM05BY3h1?=
 =?utf-8?B?NkJIZjlxYnA0RUd0VzJnc2xjSlo2aTdseUtJTVJKb3U4NHFwNWxNRVp0R0dK?=
 =?utf-8?B?Q2VDWEJXSURtQ2tzS3pZOUhGYzhZdnV4R2hieStTQlR5TXVucm1ZWDhLZERI?=
 =?utf-8?B?MWFMTXpWdzFGTnU3QnRIK3RhRUtLU1ZSRlBFVVc0OUxLZno3dmxTTVJKZU95?=
 =?utf-8?B?MU5udXg2b3JRS0x5Vnp2MU9HNVlOZGowOFRlMFY3V2pWOElQUzF4ZmpaTGdT?=
 =?utf-8?B?WmczQTdMYWJQMm5NSjRIR1F2MlBGa0oxekV3Z2tndG1teUdmd3dVS2NmbDJL?=
 =?utf-8?B?aHpkWHQ4NnFicVQ1RHJHbFdRQnROUStxTVpzVmg1ekZhU3lGL2xnRlRMSmQy?=
 =?utf-8?B?eXFMQmdXZC9XVGVrWFpRWWE0SzBWdjN4aFV6SnNsbE9CWGlBMWR5aGozMkxw?=
 =?utf-8?B?eTdrb1hhK2dGTUR3dmZKWEwyQkY4VktpZnFJL0N0aUxZNVozRGFqYzVLaGwx?=
 =?utf-8?B?amd3QnZUV3JKUWdwa2hCRG0xdmtoSkhvRnpHMVFnbGtwUjh5ODVkSEhCcGFO?=
 =?utf-8?B?ZEcrV3RmU0xMbDlJOUdLUzh6RFBqQTV2ZllNaXo5QXpOUkxPVVhnL2lybnNq?=
 =?utf-8?B?OFFwMExmY3BRUEtYTlJ6cHVtcFZNNXJ5bFU3OHpVR1NpRmJ5TjZmc3ErY1VN?=
 =?utf-8?B?RERweGFpSDdPVGpkN3ZOS25aQ3JSNjFEa1JDNTZ1bXFOMGNSK1lCVzIvNVdr?=
 =?utf-8?B?Yi84NUtXWGpIVGlXeUxqMmZwNS9tSGY0SDZyMGVQSzdtbE92dFZZYTJMNlhx?=
 =?utf-8?B?c0k3QVp0WUJSaEt4N3JxdHY0dkF1WmVaTzVGZVhXMWFxK3pyVHBvOGdXeWlC?=
 =?utf-8?B?QUxhanpBODdWNkVUSEF3UW9acE5RRThFeHFYVXZpQ2hVOWVzalR0TU1Rbmpp?=
 =?utf-8?B?OUtWSDdMWk0weXJydXhzKzJZT2p1NzBpSlFHUlowZFltWVowcnAza0EvOCs5?=
 =?utf-8?B?RmRtUzhLbysrcGdtdEJYeGh4Z2ZGVzdNK0Z0L2RuTzlvOU9IYTlOakp0WTVJ?=
 =?utf-8?B?cnV6TlZrM3FQK3B4K3hFRkk5aTJGaGJaS05ndFNFNmQzcndVOEVzcS96VzNU?=
 =?utf-8?B?VXVtRXFEZ3JmTVdDRkh3dGlrQXJyZDg4cE9Bb0FSZjNDbm8rNVJFcEtjYi9L?=
 =?utf-8?Q?UDx/9nUN4TzYBWOOBR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca251c79-0168-4647-5731-08de763686ff
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:29:30.0335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QpEEggjBkxS5/XTrOSLIYG8YvFAQXeBe7YwxCG7vWO5bBC0dWFtgLUrK2ok3Ah18
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78767-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 618451BCD5B
X-Rspamd-Action: no action

On 26 Feb 2026, at 16:16, Bas van Dijk wrote:

> On Thu, Feb 26, 2026 at 10:06=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>
>> On 26 Feb 2026, at 15:49, Zi Yan wrote:
>>
>>> On 26 Feb 2026, at 15:34, Bas van Dijk wrote:
>>>
>>>> #regzbot introduced: 7460b470a131f985a70302a322617121efdd7caa
>>>>
>>>> Hey folks,
>>>>
>>>> We discovered madvise(MADV_REMOVE) on a 4KiB range within a
>>>> huge-page-backed MAP_SHARED memfd region corrupts nearby pages.
>>>>
>>>> Using the reproducible test in
>>>> https://github.com/dfinity/thp-madv-remove-test this was bisected to t=
he
>>>> first bad commit:
>>>>
>>>> commit 7460b470a131f985a70302a322617121efdd7caa
>>>> Author: Zi Yan <ziy@nvidia.com>
>>>> Date:   Fri Mar 7 12:40:00 2025 -0500
>>>>
>>>>     mm/truncate: use folio_split() in truncate operation
>>>>
>>>> v7.0-rc1 still has the regression.
>>>>
>>>> The repo mentioned above explains how to reproduce the regression and
>>>> contains the necessary logs of failed runs on 7460b470a131 and v7.0-rc=
1, as
>>>> well as a successful run on its parent 4b94c18d1519.
>>>
>>> Thanks for the report. I will look into it.
>>
>> Can you also share your kernel config file? I just ran the reproducer an=
d
>> could not trigger the corruption.
>
> Sure, I just ran `nix build
> .#linux_6_14_first_bad_7460b470a131.configfile -o kernel.config` which
> produced:
>
> https://github.com/dfinity/thp-madv-remove-test/blob/master/kernel.config

Hi Bas,

Can you try the patch below? It fixes the issue locally. I was able to
use your app to reproduce the issue after change my shmem THP config
from never to always.

Thanks.

From 03b75f017ffe6cf556fefbd44f44655bf4a9af48 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Fri, 27 Feb 2026 14:11:36 -0500
Subject: [PATCH] mm/huge_memory: fix folio_split() race condition with
 folio_try_get()

During a pagecache folio split, the values in the related xarray should not
be changed from the original folio at xarray split time until all
after-split folios are ready and stored in the xarray. Otherwise, a
parallel folio_try_get() can see stale values in the xarray and a stale
value can be a unfrozen after-split folio. This leads to a wrong folio
returned to userspace.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d4ca8cfd7f9d..3d5bf3bb8a3e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3628,6 +3628,7 @@ static int __split_unmapped_folio(struct folio *folio=
, int new_order,
 	const bool is_anon =3D folio_test_anon(folio);
 	int old_order =3D folio_order(folio);
 	int start_order =3D split_type =3D=3D SPLIT_TYPE_UNIFORM ? new_order : ol=
d_order - 1;
+	struct folio *origin_folio =3D folio;
 	int split_order;

 	/*
@@ -3653,7 +3654,13 @@ static int __split_unmapped_folio(struct folio *foli=
o, int new_order,
 				xas_split(xas, folio, old_order);
 			else {
 				xas_set_order(xas, folio->index, split_order);
-				xas_try_split(xas, folio, old_order);
+				/*
+				 * use the original folio, so that a parallel
+				 * folio_try_get() waits on it until xarray is
+				 * updated with after-split folios and
+				 * the original one is unfreezed
+				 */
+				xas_try_split(xas, origin_folio, old_order);
 				if (xas_error(xas))
 					return xas_error(xas);
 			}
--=20
2.51.0



Best Regards,
Yan, Zi

