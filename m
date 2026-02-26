Return-Path: <linux-fsdevel+bounces-78592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4J/ACseJoGlvkgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78592-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:58:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0C1AD1EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0416733D9A0F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0A2BAF7;
	Thu, 26 Feb 2026 16:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bhewb5co"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT3PR01CU008.outbound.protection.outlook.com (mail-canadacentralazon11020094.outbound.protection.outlook.com [52.101.189.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A72426EBE;
	Thu, 26 Feb 2026 16:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.189.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122618; cv=fail; b=kFXEGjH0UX8wA1OY+L+g21ec9l4ni/66iZcWfCSAtYMEXRKaHxHIUIRk/Krdyg/A4XFmK9ZZZ4CN/P8tNyhuBQRpYQrIPqC80k9dglGZW1DvuSDJIXxoTNLJmQsEOykVKdNF511UaKQBeL/t3wYQHbfEyLgolxoXqsT8OwoY2fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122618; c=relaxed/simple;
	bh=1QnisX5MpMv8IPDAOL1lhmF5VtaAm2WFCi00IBxTlbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cjkha/gmVhJUMkkpwNZHb97vKOTo+qNLaOGdl4DYKBgU1S/1pQhg7yXGLbGu2jGotF9ZEJeYhya5uXDdOzv88Vyh2UThVG1KmxD+tW8QeZMEaA6bU87bBdFOLZsP+E9Hn00SrXB8MQ/ZNl5LxCjfnHC/lYS/ur/1wfChALhMgi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=bhewb5co; arc=fail smtp.client-ip=52.101.189.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSf28LxC0w0WWzX0/ID6Ep2FvnqQ8txOFiPyY7QRgnvQrrfY70C9NniRdKU74jfIaPLPdOCiBlYsW0huxbMmEDRYMe9T1EcNkqsIucTjA9wGgZafTfq8BkNuK19k18/Q3m9XkGSf9jEAE6h65u9oelBjplWdbTW0OwpqMSuZdNC3oEi3VDTtjNDQVW6KIU7zUmqyFQ1Ffe34dASM+zdX/xj4NK0nX9gO07DYp1cIfSA1RmUxkrG2uq78ZC8WX5p/SkcC+vnCiYHyKYpUqsV6BRDrqE0BnIxCZZ197mv45ch14wcZdQIfqt9POfDt93TNu03vF4VX/Mk9R9g+6e7ySQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oqyr1rLDfzoumNWpRpdnewLfZKp+M8vl8j1tKXe2blk=;
 b=iCrGoZzIPSvB2aonY+oyuIFAHxOFVZ4Y77no/EzP0+S/yOvECdl51jTCKW+SES4mMiIt/Wfefq1cvgjKWOjcKRDICsSIoBDphyIZgl9KJ+hTJUmM/f17sEjuxmnPVZMaMcdPdceWhaXy3y0OqosT2DG+X1jdQXK8qGE62KkYRXhQWbCtuTtRNAzxzt4UfpoKnLwUnGcFyfhcdQLPZwhPTBrFyd0rGKFskXrvSSpfP44LZOTcX+tKNMZVsAsOLMK6V8WTgFUkLrlQKenR7y936FkP/fzTV5dDNcmOj47zMnc6ovIIpLel6zIcm6JrZjL2nVkpcVIANbl9wkxAvRE+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oqyr1rLDfzoumNWpRpdnewLfZKp+M8vl8j1tKXe2blk=;
 b=bhewb5co7f1CKrf6KdVHetMXBLM1pSuEqf87NBuZntRnWaAvl/WPQKKokCAW+ekTlvd8nmlqFTvSOhcTlEkBe/+Y4Bns00ZXj40F7GYZgxhA02PwCcn8+W7F9Q/7GfmKi1pAf4LZgCYIIqFf6FvtiEjLxLrEgg1BLTAlLBcMYsF/GNMYhADtzVjp+STmzFmwX7oAQMx4q1+GOpr6HV0tyqz/oHc9GcLP5/+FUdVPhUja9+6nfP1SpkhFs/M6RN8DqTMOVeAkDWGgxI1cioy6aZwC8BJIQ8RlcH3OZVZyDnBU+wz9/EJxl7iI7zuu6E2eNVBZGt+J12Bsat4i5X5fzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB9755.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:8b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 16:16:53 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:16:53 +0000
Message-ID: <06c94e29-32d8-4753-a78c-8f5497680cf4@efficios.com>
Date: Thu, 26 Feb 2026 11:16:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/61] vfs: change i_ino from unsigned long to u64
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-2-ccceff366db9@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260226-iino-u64-v1-2-ccceff366db9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQ1P288CA0020.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::29) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB9755:EE_
X-MS-Office365-Filtering-Correlation-Id: 893d5738-1c1f-4f9e-9cfa-08de7552741e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	dpd4/RGAnIHtrLU9L4W3qqCVonr+1FHAnxIowAVfNiyrPx/Ho5Yi8RVFUMkZwfKreN7M23wLIiL332sQHhDOlt5zF19PVrt0zhh/AWqU3bfPG6htTEj1Ur2S4x2Jm5jvT4OcghdBOgOWzogpBg4s5hULrr5F65gB9xqZQXbP4k/FlpbRZSbeiVhGWkDyRtfvs8qhSRGs+uKzL4/3fYjflZM5pQMMJRQcR5eGEIx1mrnzwciOAUxeVBmHB/CudLkSorPNgzlgtvY7VxLuKQ3Hvyem4m1Y1rEr+ej2Q67SvdGM4uLfxJ9xnwFYjyhCkgR3hO3gIcYp6y+OzEjNfVaTE1Z+dXC+nRnpxW/AwYQBWHBN21vlnRqxIrRYP7DDSF8StCYWKVdQ4OFowXofJKCr4NCVDJFXQKSCUu8nV0mVJYk/+kUJoxyZ9hpDR1kHCzks3gLlj7TO46kcQCvp/fWvgqX/KXvtvyTx9BWBDiRpDdCjTSmqvocgt2BMQDYypvXz7LRBccH6kLbNqtl9TKhPp02S9kuHPgcKyX1A3OAUcAd5SA41EYwOSobik7GimxWwSVriMQcVCgA0nAhR5y6sWMH+6DVM2hL1OEdd7XRBn3MgG1VqMUhAuybRALv3BcNCK3IjNflvaUTC3ELNNZvyxZ3oo/OR37JvoVMpe52Oij+QlUBM5a4yRkuH5jYY09wG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHl3SVF0VDg1Y3dJMjVaTkFaK1NPSnVRQ3kxQXV4a0xNdk5RcXd1c08raXJx?=
 =?utf-8?B?bmN3Vmt5M0I5N29ISG9TRjZuU053ZXo3VFRlR0k2bzFUL09Jcm5JcDh0TVhi?=
 =?utf-8?B?QnNQWUg3ZUhyMFJKQ1hFVGxOUUl6RDVOazIwYmMweG5pWXRjV1dNajVZeUNL?=
 =?utf-8?B?ZTBkRytDRXliRlN6N3FBSURzN3JTR0RyZGI4REtaRUdRdk5CcjlCM3RNSjVV?=
 =?utf-8?B?Ynk4UDN4cVl6ME1VanBCRnNlZmxBTHV6cmszaFdoa0krYUJUTWR6QlNoYllS?=
 =?utf-8?B?RzNSM01jbzk3bWhoWmhEc2pqNFFnUTRQd3RJeUROOTMzczNlSHIxYzFHeUpl?=
 =?utf-8?B?dlRSUlhXVGZDdXZ6R2U4VU1EeDB1RFZHK2F1UFQrR3VWc1RLRkt2MmI5SkYw?=
 =?utf-8?B?NG1nR1V4NVYyRU9NRVZkdUtzbnVTQ1JiNnFuRnUwSWtmZ0RRM0E4WnRPOU0y?=
 =?utf-8?B?cG9SYVRrL01CcVdyU2xCaFdQaEVtaFRHbFNGNG81SHFFTzNaR1RMNnlMVDlF?=
 =?utf-8?B?dlNicDNEMHhXc3VybWt5aDJiK1BKUy8rSHh3U0NLd0xobCtmU2E3dVVBZ3ly?=
 =?utf-8?B?MmM4SFlyVmJvMDJyN3ZYQ21pWlNYdUhTWWtmRnlod0o0c1Jsc3FhOTUvczVz?=
 =?utf-8?B?R3BBVGVLQTFKM1dOWm51SXh5OEhCM0xTVGp0cmpubHlyUlZXbTJrbmlsVWdy?=
 =?utf-8?B?OHZUckRFQlREZWVCd20weXlMa2NJZHZDcXRsR2s5MXpTNDA2dytwSDNYM0VR?=
 =?utf-8?B?dURld2MyQmxwTGNBTGtLR204cUEwMU1QemsybmpDVXVXdVlVNTZNbXdmcXps?=
 =?utf-8?B?MG1oeGg5bzZkM2llTkRiSEUwS0ZtSmovTTFnVUJNSE4wQ0lZb2E3QlZuWVVZ?=
 =?utf-8?B?ekkyK1lqTFZ4YXp2b3VtTjFjWG4zOGVYYXpucVpmdDJRUlFqa1JXT3hZcUEv?=
 =?utf-8?B?enZEcHFZdUlQOFE3Mkc0dHF2Wk0yN3B6OWtheitCV0pIUnVqOW1pRFlXNkhL?=
 =?utf-8?B?SUdoakJMbmxkZUJDM0p4SVpGUENnMzdUcGhRMDRDV0ZTaWxjS05ETmVnQlpI?=
 =?utf-8?B?WFZ0TUxBWlp4SG1mZFVwdDNKSVBEZDRnSHU0UCtqWnJHVjgwdS9TVFRaZWVp?=
 =?utf-8?B?MzFMVFpWaE0yNlFNS01Jc3ptdkdjQ3lidkJRem5kZmJTZkJsOWhpM2pzRC95?=
 =?utf-8?B?bjgrb05MMGgyeFkwSG9uMmt0cTluQTdoTFNsblRSSnhzTE9VbGFBdW1DK2hV?=
 =?utf-8?B?dG9kZ3pXK1JLR0hOYkJnMmkvR25uNVRhTXRIdnc5MGYyYlhDSVJlNlhoOU1q?=
 =?utf-8?B?WXdLbHU2YUg0WVVIZHdnOHBDWXgrQmlDK3dNbjhvQVZWR2hieVVoMlR5WkV3?=
 =?utf-8?B?ckd1cHdGUksyUVFRZFdUckZteVQ1eUFaZXRKbnoxVlpyeHBLaG1oMTNEL0JC?=
 =?utf-8?B?Zm9vaVhCYmNSWHk3Qy9tNVFMSVdrckRmYWlEdmZKaER0ZDZnKzFqMVVFUmNB?=
 =?utf-8?B?eUw1NWw3T0wxbCs2R25MOVFkYy81Yk5OS3VFR2NISjhvbmNsZXRRZnFTYzF6?=
 =?utf-8?B?WWRJK1NhRGVrSGpSNHJIaXNMTVZxQUNlQWlPTlJCSWQ2QXZGUVZkMFdCZnZY?=
 =?utf-8?B?bmRQbVVrWUl5Z01OTjNSaTBmaTZMM1hzckFGVlVlREl3T2hxNXNjenRBSkVJ?=
 =?utf-8?B?NnMveHRDSlhBcEhhSExkR3llV3lGWXlxOUtRZGs3cmVMVFNMK1Q2U09PU3Jh?=
 =?utf-8?B?Qll3aVEyVUEycXd1SVJWUTNyeDlOank3VHhlMWVPUURWWWYxSXh4eUU3UnF5?=
 =?utf-8?B?VDMveVJaVytrK3FjRktaQjgwdUU2OEEycW1xSm85ODVtd09jbnl6WGRhOU01?=
 =?utf-8?B?QXEwZDVJU2xBNCtDbUJnc3JWVVlHT2VPeDU2cTZCZTVRUEVIYTZCNmROSVF2?=
 =?utf-8?B?bEtrM3NnNWhGdzVUUE5QQUJQWC9COU0vYWpQendQWndFNEVCODB3WmtRZGNY?=
 =?utf-8?B?Mm9HUjRvOVJqWjlsUGhJRHpEeXpRbXo4eW9vMzA4Z0FNc3ZSNGRUeU1ETGFs?=
 =?utf-8?B?cjd5UkIrbEhWUHFIZ1I1VjlsTFI1SlA2VU5YSzFYVEpIay9UeEF5Z283ZnFP?=
 =?utf-8?B?M2l6RkdTY2QzWVRHSTNrZStkaTU2b1ByTmY4Y0tTWTRmUjN5ckIvUXdScjVx?=
 =?utf-8?B?M0JaOHhNbkVDcmNvM1VONjJqSDluNnBlRjd0Q0t6dnYwaU1IZEh5NWR2UFJa?=
 =?utf-8?B?V3A4UEVIQW0zdVZ6OWUvVHVxQTdwbkZ4TGtyVjJtWmtVTzVvdG1SMXJ2YUVk?=
 =?utf-8?B?Z0dOcStKeHlWUzViRzNNdnp1bi9HaUJRNTNMN3NaV2xkZUoxeHZ3RWQ3cEFG?=
 =?utf-8?Q?cGsWOV0ZQWtnPeyU=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 893d5738-1c1f-4f9e-9cfa-08de7552741e
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:16:53.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wX4+M0cjF1Gaxk45D9/gpXRMGXGH87e5rbl8A8UHEdyFx6lSrjpIn8ulGKhXyCYCvAm+W9F4stQHImz+pIBNnjAi/+CUe6KzXVjrgWGPOs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9755
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78592-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[efficios.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,efficios.com:mid,efficios.com:url,efficios.com:dkim]
X-Rspamd-Queue-Id: A9F0C1AD1EF
X-Rspamd-Action: no action

On 2026-02-26 10:55, Jeff Layton wrote:
> Change the type of i_ino in struct inode from unsigned long to u64.
> 
> On 64-bit architectures, unsigned long is already 64 bits, so this is
> effectively a type alias change with no runtime impact. On 32-bit
> architectures, this widens i_ino from 32 to 64 bits, allowing
> filesystems like NFS, CIFS, XFS, Ceph, and FUSE to store their native
> 64-bit inode numbers without folding/hashing.
> 
> The VFS already handles 64-bit inode numbers in kstat.ino (u64) and
> statx.stx_ino (__u64). The existing overflow checks in cp_new_stat(),
> cp_old_stat(), and cp_compat_stat() handle narrowing to 32-bit st_ino
> with -EOVERFLOW, so userspace ABI is preserved.
> 
> struct inode will grow by 4 bytes on 32-bit architectures.

Changing this type first without changing its associated format strings
breaks git bisect.

One alternative would be to introduce something like the PRIu64 macro
but for printing inode values. This would allow gradually introducing
the change without breaking the world as you do so.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

