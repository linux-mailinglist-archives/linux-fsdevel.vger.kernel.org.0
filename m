Return-Path: <linux-fsdevel+bounces-78583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iDvOIvh/oGnWkQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78583-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:16:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9D01AC16F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 19E0F32576DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D415C332616;
	Thu, 26 Feb 2026 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="D2fOi7aA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020142.outbound.protection.outlook.com [52.101.189.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7FD4418EE;
	Thu, 26 Feb 2026 16:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122111; cv=fail; b=RBWtIus3kgFGYavxozaLUv9lMh7c33creUeowc9MlExOTwCmPY7o7wjG6P4pBQtTukuxByzzFXLpBiZfXt1pHpUGOKttY0s/BKmxAiho3y5qGLPwclXxGrc2vMxPs5qGC+JixoCLXWbDVc/mXKU7w7DTS+oh5nXWiNiw202g6KU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122111; c=relaxed/simple;
	bh=QiXy8EraQQFdGl5K0oLR6LR8SlB+Zl6E45ANXOsdKPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HD0Qvf5fkDN8PBVDa31N9eMPPdcLUhTDkmf6yqlWqR3em9p+t+E2wTABld2R9L4yKZMfjn1LfLiUo9c7nVmyT1/C92Rzc2RBoGHqZnPgYqLWRimeAT9/CmGrSUwwg4J+Dz86VWdkd1tc7eJFOE8EMPVJhWKdbgqJmhaLvC6ofX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=D2fOi7aA; arc=fail smtp.client-ip=52.101.189.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmX4DcEoeE0F88eSu+5nYZeys9dDaq9uITQ+/rd2blKjw5ERzRSD3nUUxVYU6aNfncMDhFjm98/j2OPS4ZgKCcnSdQ4DddLz24ZRqrxa8ALrPuQL2uyHQaKx61Ml/RXVHfiayGo9dJ6BVZHFhwZ+oHvR0kZXdbonmL/lmFJqZyWH6gEHB4Ot0sGaBbwFyKWG51Lg4ir8oUC9sSpmYGBLE4+LZwqFJ+6DuBhC9WdmJjEMt7kivqNFFMGN+U5AWq/kjZIfLRs3sJow0gPqRcdwOAfMyypvLH21YcF81+DjRtfBpaQJBkWHVAWn4BHiFE2WyGMBNc3v10r/LPAJBnM5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqF9vLca7TuNJDGJYEIr+YojC6HJf/3OaVry/XzXW/Y=;
 b=b9IJj4/U8MQe7AAtKVQSb3+F8xULy1KuJOCcvtvTn8HyttqNpQ4GO236TuLc9XXV0EMwBtDmBNm91e0KX7svTMfH+yKvgL4NnlZD0CG4q4Ft/xjLoSixRD+2ni3dX4OttW5zHfehWMTwWvMvSwh/qOvjgmBR16KQTx8iZIozIhaVAjs2yCq14jfn9FoIG7+vFx5AP64x9xvJsQhORfSNGs6dzd0bb6a1mqB91FMJXJJBSOZXCobINyaNf0V7XWP9WmnN46rWqGhZZh3Tv6SZDRX8Tz4sWVemMpWlADvEsjmtv5dNM1VMbSNEr7esUnnNTHzpcZHf/i5iqdZIXqxiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RqF9vLca7TuNJDGJYEIr+YojC6HJf/3OaVry/XzXW/Y=;
 b=D2fOi7aASzeMTtuUcYL4p+28oW1bxYDgbO35q6mO8HTj/ZnbZQrdHXSzrHLN2EIo1xPykYh+Hav0sqFqnLs9KUpEbYYfzlwSNAecIXgYSJ8vYiNhHSlWbh3wNwG48TuzKZoH4kjwSPtLjszL+G0KgBRRbW4KL7mP2eR+DuSRkPzh/Itvh+Wz8qLrnfEbboI3gnK/9tD6o5UkTTeiKeehYF9QCEeZUaavVrvK8udcbT7amXggKXaw90nOStrdxBQykNXZslGPA/h+4HZ44Mc5fKwSafPvbj/IkpPnVjLQfL2Aw7wjWDj1rLIOZYu0Mjm7tNWhEfDKl9beLcTCe8TUoQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQXPR01MB6511.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:43::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Thu, 26 Feb
 2026 16:08:19 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:08:19 +0000
Message-ID: <421a41a0-6199-4e2c-9184-4b4d0d95d86a@efficios.com>
Date: Thu, 26 Feb 2026 11:08:16 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/61] cachefiles: update format strings for u64 i_ino
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox
 <willy@infradead.org>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-24-ccceff366db9@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260226-iino-u64-v1-24-ccceff366db9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQXPR01MB6511:EE_
X-MS-Office365-Filtering-Correlation-Id: 8402eac2-920c-44cf-d27b-08de755141d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	+7sN6eLdbZd5MbA1bd9MxSDly+gT1lqvtdFjCgNmjD1y/i09ZZe2FKfv/eHbrDQoSRoDow/47vOxwZJkllzHdHWGUJxKj4++6GcT0F7Zv32O8slRrajiEALI5gIqVd5Lm5DdN/jy/3eTNncZc+9/752jHKnq5zJf0/nndtSHantmdk8KHedDm44HDNivybrpwvXYPm8nrLkwnHnzFcn39Huu8fddCM17JZGXjDLjdebtEIIy8BqcJ8BIFm2+WrfF/XxnWNpDl7Q+vE2jwNj1ZJglUfF3wyhd07ozOZZXDj6eBwnehrEySVEC3fjXBOVFUwqlir+/XzNkm6RPAA+ransaLfg3zvyvo0icqdnjhzdOSl0DqQHom/bswtqli+3xdgscWyPrgrEBzgvoH9ddMyI5/CWf8u8XDps3BiVBCY4TBMcxJXa24M7dwYcRJAwyjZgj8GVYjJm7DEcUlWK9fhPc/wnnWiPz/pifAgHLAfpE8sHcYPhPSzOd4k6Lz68G5tUtdUIYYD+/MlIfv5Q5osxgCKrXqM/pTF/Ckgn4EUbTGkiKWh7Jwt5kUOq8B6eyPSg2UxUba1rfsaR/4WVzOjDy198rPx0jZdfI30U8UNbW+hscwZfYltEeWqwCQES2drdPWo+TFGM3MGprcPcrRS5j05H3npM4gvmNKiLAJVVOC7yg+nHiC0LZeNipQKIKUwKWdxijpc5LN9FYKA1/cduHVPCFtr+xWK0oXPRo9vw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L1Z2RXk5SXl6bGh2K2JMTjZZQldYMGdCTG1ZK2hqQkJpZWxVdEVFMm9MczlF?=
 =?utf-8?B?aXJSeDZsdTJqdmpQclRETVpjanNvNGN6cmdUcGNxTXNqWnpRZVNIY2k4QXdO?=
 =?utf-8?B?ZXVXL1NiQUU5MXozdlZoVDdmdzQ2d2pZSU1QaEpUWWNsNFdBOCt0TTlyK2xV?=
 =?utf-8?B?N1BIWWxwMy9mV0Z2bW1qV2JieERldzRJVTlsYVpxRXRaaVl2SncvVm1VN2tp?=
 =?utf-8?B?RFBQVmxHdWxONGRIR2hoYW4vVkQwbVZnZkl5OURoaVZ5MzQzT0ZjdXVpeDF5?=
 =?utf-8?B?MUFVTkdNRXRIYTNDVkdMbGhmQlNuV0w3V0o5Zm11b2ptSlhNeVV3MTdzUFlF?=
 =?utf-8?B?REZNVk9IckZnOGtNZFBOSEU5SjJxcVZPWWJnQzFST1NsWk4vdGxteGhYMVpi?=
 =?utf-8?B?aW9rVGFPYTVHdjNnVWxVU09LVDQ2MkM0aFNpSjNSVFNlUXh2NVNrM3RIZVpp?=
 =?utf-8?B?UnVEUXgvNXEyUndGbDhFRDB1a1BWeGhkcFc0MDBLMngxRFl6OERNSC9KTjh6?=
 =?utf-8?B?MmNSd1VtcmUrNm5ESE5VcUtaSUExWG5zOFk3blpNdGNWNW9GamRtOVBFMEp5?=
 =?utf-8?B?amhYd2tSNDArSXhmZDdkM3cxL2ZGYU1ZQkdwNklaK3Foak1aY2xBK3BsWTFQ?=
 =?utf-8?B?OERETHMyLzJ4ZE9qWW5XMUlxVWRINTNKVTRYWGJQUGJIdVFNNlpYQXhRbTdq?=
 =?utf-8?B?UlVLbi9wbWo4OGdxVjZXcGZZMHRLNjlTblRKYXdPdkEyQlJRc09LUE9nSDlR?=
 =?utf-8?B?b3hHTi85dHVsK2tPVlZ4ZXY4cFcyN3BFdlNwTTlRK1NNWTR3QjVCK1FNSUhZ?=
 =?utf-8?B?cHJwZnAxa0t6eDdrWFlLMnprRE5vaUY3UjF5OE5CaWtSL1BYdFlvZWdqamM3?=
 =?utf-8?B?bDhhbEdxTGFmaXIxM3NHdUx5cDdMTjBLalBWNHg5THkra3NvY2hucU1hZkFS?=
 =?utf-8?B?STdLS1A2V3dxNWhMVlpkeWRHZnE3Uk9vZU5xTnZMMXRwRTBSZDZKb2RESDM0?=
 =?utf-8?B?NU9BMGRRcjRsay9CVStaOFlhakN0OGdscW9VblF1R01oV0hlb3ZzSHJPc3ov?=
 =?utf-8?B?bmNPY0pWWHhta0t2VmVZOXo5d1FZd1dpdDkzWm03aWM2OW1rNzlSRlpVdFJm?=
 =?utf-8?B?R0hZcWJ1NUFTT0RNZ2w1THRuMm9jbFNZMmJqdW54VHBUaVAvUmcvRWYxZXZx?=
 =?utf-8?B?Q1VMWWJQcnFTcFJVeU5hMTR6OXRhdXZNbTY5cklCbG1ENncxd1dTaUFDOWRT?=
 =?utf-8?B?S2tNblM3WUl4UGpWcUVGRW1lSldJQTlxT3UwTlpEbGRES1hha0xaVXlqMHJO?=
 =?utf-8?B?aXlEUDhXSk03dGtJSm1RTW1MTXU4SVBmTTFNQnJGUFJraFBBTU80VStDaWdi?=
 =?utf-8?B?eHphV2N5Z21JdzczSWE0cm5VekVoS0o5ODA3TWF2Sk0rSUhWNjVWaWNLR3p6?=
 =?utf-8?B?dXN2OXJkcEhQVi91MWdOa2FqbkJhVklZeHduaVNvSEY2SVk2SWJYTmVaeVEr?=
 =?utf-8?B?UlNWaHRjaEYySGNqNGtNdnlRWGV2QkJTbFBJZTIrVXNHVmpGRFlFeHROUWxB?=
 =?utf-8?B?R1NaNThwRHVPQ3VkaWtlby8rcEJCTndUOUpLU3hwRGxXN2phbW1RU1lEcncy?=
 =?utf-8?B?dmpMK0tLREpaRWhpSUpVT3NpblhNeDRDbndQSTF2L1BKeHlwNkpJWGs1dGdY?=
 =?utf-8?B?WTFraGQyMGl2MG4vK2hYNGFjM3ZrSWtCcXdTM05ieGFmeC8vcTZQK25QSUcv?=
 =?utf-8?B?b0ZiWVZmUlFmUk54ZEh3a0VWNFJoRE0rQWw1cjVXU3ZLTlQxanFoSjREY3E5?=
 =?utf-8?B?SkNZRVczYitTc1BvTmJ1V3Y5TGJ6OGFrWEFSZlVjSUloVGpiYVlTUDljeVEw?=
 =?utf-8?B?QStlQUkxbHVtNE9ZcmtEZTlzQmRFRkJXa3RudTNpdCtJdXNFMWtPVUdLZnM3?=
 =?utf-8?B?Y2ZDakUvZXFpUmR0L2lqejZoekNFQ2l6aFFpb0hxaXRXMFMwL3ZUZ3NEMGhN?=
 =?utf-8?B?dkFFaEFoeFFTbTdybVBVVHFwanJxelNWb2RIVjhlUXp5blhyQ1UxOXZ5akxk?=
 =?utf-8?B?YnU4ZUdyU2xMSitONWg1VWVmTzBUdjFQR04vdUw2WEZlcjJoaFEvdFBPRWEr?=
 =?utf-8?B?eWRjcGlQVmdZWFNyWlhLeVEwZzNTYzBtMDh4RkNGbXZGcFJ4WUdiWitBcC9h?=
 =?utf-8?B?Z2l1ZmdHNVV3SU9JT01tek9YY2FaU0xmajJRSnJRejBpTW1ndGtOT2hwbTZH?=
 =?utf-8?B?UGk5M2dKS0NUL1FrdlVpbkpsMHUySE1nMUlyUmttOUxMUHNPMWpMbnpIczlr?=
 =?utf-8?B?UnYzUDhKT0plQWs0UFBvWGV6UXVxcmtpaFB6dDZkeXVrVDI0TnJKNEpDTm9T?=
 =?utf-8?Q?p1f6Y3Vr7jt1iUEe0Qs/bfPqOeeGtggjxRBSu?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402eac2-920c-44cf-d27b-08de755141d2
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:08:19.1579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FS+fq7MDkQISfoyILFh+J2DDQcFWuU+h2ZHNOTb6Z9MZJg24JUp/Fax2jN93Oz/BXDwekAgjcjX2MxugzITrGkKv4EDjlPeOehNpy42uw8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQXPR01MB6511
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78583-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[efficios.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:mid,efficios.com:url,efficios.com:dkim]
X-Rspamd-Queue-Id: 1C9D01AC16F
X-Rspamd-Action: no action

On 2026-02-26 10:55, Jeff Layton wrote:
> Update format strings and local variable types in cachefiles for the
> i_ino type change from unsigned long to u64.

[ Trimming huge CC list. ]

May I recommend shrinking the CC list to the list of people who actually
need to be CC'd on individual changes ? Yes, this is a big task on a 61
patches series, but it's part of the expected work that goes into
submitting a large series like this.

>   
> -	_enter("%pD,%li,%llx,%zx/%llx",
> +	_enter("%pD,%llu,%llx,%zx/%llx",

This changes from signed to unsigned without any mention of why in the
commit message.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

