Return-Path: <linux-fsdevel+bounces-78591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMosDBGBoGn6kQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78591-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:21:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C66FC1AC3CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3ECD032FF879
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC842B73E;
	Thu, 26 Feb 2026 16:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="LwHWAWGk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021100.outbound.protection.outlook.com [40.107.192.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64542883B;
	Thu, 26 Feb 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772122319; cv=fail; b=hGDVJu+g6o7DF6mi1/SURzkKsz3I5VpKRx4fd7Q//bKhZkpnKlcdxIa29937f7qpNYijwKUrZxJuNYGRFy8uKKTdUF7JGMWxLdZksy+m7wVgoWO+U0ppl/ERI4DP9i6V621dpzhT3SARaBV7KgXQa8xKa6ZOfctuyMDo03CSkr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772122319; c=relaxed/simple;
	bh=gCQl5kPxmWTBmM9N/CuPfjBbj6C5aeiqP0E6d+nnldI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h2hnfj97D61Z0DwmlSd2V6Ry3jwtQmOz3Lf8aj2iCj6Ft8fgcWxyJ8HhOZvU7BD7KLE+92nuEoztmWS6WxcvC7OxA8JKFdXcVKMkiu/Ri2xeijCwMPHCYqrrtSMBXzglkPJ7ifMxZD0yIpKodkJY2gLc5vDHZPhhYU/GQvy5eqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=LwHWAWGk; arc=fail smtp.client-ip=40.107.192.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldQI+FlHOt5Xv9HhQJnUHzSOtYqp9TX7OFPjK9Uxsd0zO3M3E60bUr5yA1bP8jaqODWXaSH0q0XvBfCCP0dyxM5ZoZoFZkc8p1BbQnYb41v549NhIBR0PwzIFSZ6eIPNIvQ37O4JBIt21FPrSWVYgvizJP/qtGf99cLG3oYDOzNTsuaAD3OIoc6TYi9QlG3Q3ZxYNHRPv22qapxZNg9CR5C6MdOmoJfJT8BMi9/4h7mncLrPTT/zHU8L2Fc2LK00iPsXV323pwKs7LHWGha/jRAyAfuUYPjSAr8Py6MH9yBkAPWlrz3w9uklAVIDdYyR2dvK/OfsOaKNFlPbDHuVMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5u8uVyDpQGp+Sw3yu+01DNPoTy6efQI/ielpzkZoKE=;
 b=PTKd6kgkei14Iyyg2IGYRdCvGYqlEY6wRqqwMTnS0XwovIh+8+3HG5hVRBGMOf4e7Dl7yUZrcGz8jXJzfv2rKY+OpLllJ5loo0BXkk6qWYzX/OJ2YX4jj8UOj27ZLNMnm1ssLnZEEtN7cfG6tHpYj3Fg7iWPH+O/TOaepQQxio2aFhrmJfbMv1NAfvgt66VnLjmDG/W7nTC3OIEeCUm1iPEDT1Wh6zEMw8lwj+R0ogf1+emOesP5aDr0LfTly+29Ta/5jed0eCPyVPuxZqtiIQcVvm1dzMKUY5FaUhIdMEuTy543Zl2Y3k96pJnuoXpKPiIs8Qk5kupDkagVGETi4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5u8uVyDpQGp+Sw3yu+01DNPoTy6efQI/ielpzkZoKE=;
 b=LwHWAWGkukImWUtH3tbamXb6JVatRc9FR30xWkQc1hAivQj0/Mf2g4pIBu3zUQE78KoCkFIJQEwgAcwH5bXZ+dPv5L01wUdUN25IgyYG4gBaPzikkxiWWgADWzMJ7pQE7xlsgvytJwG1pNw19HL1NS6xLXDV6tl+DIs+kt+HRZnI6PzFmtSLyqwcSEB9ANI0hiFuqfne+Nww29IBDUTHA8hkj6dT5vvG1+cJKa8ZwM7kjWH2PfR/UNs+9g+nK3tmT4oBLl6KX00g04EuQi1vS3+ZQVcvIl1/P9MSdTrCg5VF4Op4vwzM/cyu9+w+zn0KoTyDN3XUbNYPCAOSNlHxZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5855.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 16:11:48 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:11:48 +0000
Message-ID: <045af923-9067-4898-9a0a-3728e7935346@efficios.com>
Date: Thu, 26 Feb 2026 11:11:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 61/61] vfs: update core format strings for u64 i_ino
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-61-ccceff366db9@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20260226-iino-u64-v1-61-ccceff366db9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0434.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::6) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: 414bec42-0b59-430c-c994-08de7551be9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	3tAqcYM8QWD4NT5itqaBqPA8vyYRJlCLncWth/YXQ4VQwyWH/RkP42FGb7LIyeKfVmF3rujgDkoirG6/ojmAi9UZOYkptZRpdiw8vD5LUn2494tIEUyoGReOuuLCb6F1ky0ja3Pey+7xH9Blp27x7+Y4PjaPiWmr8W+o5f3B/61igGszxDqTHZpSgg/heUKYn43mQ/jQN2Jm81WQWh3cSUJQ1KHsf+rLJUFVP7frHceWzSsoYos/RRXix6dXo5+fzmsGPUH7PUmbmMoXAebvucrTEVofmZ61NtC5njJOy8bpETiFLbKjzYW4YAhw+lVoZDr8AgNAzvvW061amiw0MP2NSjiTtFDe2+tjO96uu7WQxe3G1sPtj29WIfzbNOnj2KYPlB9BTEF/Pgsw2fMjTPqVdOyDa1hRA8mc5qtPYlR3VfXleIsspMQ6nRvQbmcilURn1OmPZj5ql3H6klPXyYIQS70QlQQwZGTn7Zjk93At1S5YOFotWWcpV/btcM5Ek5s+TCylUmDv7rZ4i0F+m41Y2cmqJ55CShRj0h6iLw3t4au6L52vX2fqKyB5W3oMzbjKHSW7uEnyhOm4Kw3AEGHTGi+2ffAESVdtuuRigZa4cp31hwQZPsXsGQhE6fJ7LbbNY+CGrem6ezp7cmQX5KyNDf9EfGaDwD0BoDZR8DJ/EXOmVKGfoI+UNPtytzc0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjZkdjNvN3E1V0FtdTZHUXdWN0o1bEdIcHFtUG0vSCtwYUJvSnZQeW04NXNu?=
 =?utf-8?B?SktveW1tT2tsRVppTEliS3c4MjRKMnUvcHE4TExYemlYQXJUNkw2SGc1L21p?=
 =?utf-8?B?OUR3alBLdXhNQWVYUkxsOFhzM2pNVmNKWHlKMFRaeDlndG5nK1dhNk9sbGZ5?=
 =?utf-8?B?cXM0aWRkaHBqbEs2UFpqQjMzR0VRalM2NmZLOWYzODhVZ3MzOWY4WTRYSkM3?=
 =?utf-8?B?aVo2NERwbTZGaXErc040VmhLL0xsUnREdkIxSEJFVWZEK2R0SVR4Z3NyVU5q?=
 =?utf-8?B?SjVIOGxWT3dkNVluQlBDK1FneWI2YW9mYndRemQrYmZOczczWmZpTEJIQUlV?=
 =?utf-8?B?R0hoMzZLalQxWTI4ZC9wcFA5VXgxYnprZW9rd1ZkWFdzRExnUmRHeURWRm43?=
 =?utf-8?B?Y3Y4eUxzMzBJcHBPemNlR0o5RndUNGVCcnV1Si81ckxDeXBxbWNHYWptN25C?=
 =?utf-8?B?Q0JGcHdIcGpHTjRDTnJkK280UkgyRjNSZzJUWUlFV2NOaFlFL0wvUzNqYUhm?=
 =?utf-8?B?bHd2M1d5Q0RJankxWVllRlFpdWpWZk5WdlpOeWZFT0Ivakc4S2lublVnS1Jz?=
 =?utf-8?B?UlBuRjViYmh5bGgxTEhkWGRTNHNlR2ZEVkZQU2Z5WVJsTmQzMnBRUFo2a2h4?=
 =?utf-8?B?c043UGl0UnlPY081NGNFRm1Lc3dyZ1pIbXhnQTVQYlNwV0txc1NqY25NOUlt?=
 =?utf-8?B?VUs3cjZCYk5HbHpvY0owT2JhN0pOTGg0TTRMY0JFS0s3d08zcnRzOTVDTDk0?=
 =?utf-8?B?MGhWZmdZOTVkQlplSWZaS1NKTHNScnZ4Y05aSTFTZ2dZcURTeGZPZnQvdTdI?=
 =?utf-8?B?ZlpHS0d4T1VtSUNLK1pIRG9EcU9aK2xQcE52eS9EclprS1U2eWhkbEZLdXdo?=
 =?utf-8?B?cThUdWZyRnVNd0V6bytWTEFZWEpRUUZSWmhNcGRpNkd5UEcrTVduMXZhOVV2?=
 =?utf-8?B?YjRKTzN3WjR6NkdQa29GYVR4a2hrY3RtMUFMcjBqSFdlSkdtYXMxYTVPUk0x?=
 =?utf-8?B?dURYblQ1dkZxeWpaS0xvekttREJjTHptY1ZGSnBtTXhoQzNWa3ZNc3VQSlpY?=
 =?utf-8?B?TktGcHBMWE9DamM5Mkl5NDFHR3J4ZWJBYkNpdXI1ZHpNanZlTmEyUjlSWVps?=
 =?utf-8?B?VDZPOFU5NTRHTUVWNDZSMDFid3hNNnRyKzZnVlA3S3dUUmxZQUc1SG1Bcm5j?=
 =?utf-8?B?Mmt3V2ZqNXA1VW5vM0FrdFFaMlU4aEQwSDM1YnZVVjFwb3BDQndVdlF2UHY5?=
 =?utf-8?B?N0ovVzAwT2FrUnBlSjZ4c25yUldvako2M3RkMURHTXAvUGFjSHhpSmYyRDNQ?=
 =?utf-8?B?MEpLV0xlc1FEcWN1UXBaSVhsYW5rSDd4OFhkQnp5c0VjNWZBdGlkSDgrSy9k?=
 =?utf-8?B?M1UreFl5VmtQd1VRVjRqUlFvR0VUcGNDM0dFeUYyMEdlazA5amNYYzhFT2E4?=
 =?utf-8?B?dXlaRS9ObUJndlRYOUlBaTJBUWdMMU5jb2hodUlBTFlxZkJTdG5oWUZycnJD?=
 =?utf-8?B?dno3SUhqcUJRcTdWKzJ0U1Ard3MvVTNqZHdydzU5Z2libVlRZERtQ2ZHL0RN?=
 =?utf-8?B?eEphblpISmlhUTBIUlUzUU41YTEzbmMvdEpJUFJTWVJPOURaNmVwZ3dKWjhY?=
 =?utf-8?B?WVM5U1VnK1hsTVd5L2tJMDFoRWRlYmdDTEpVUCtnRDRUTDNJKzQwT0hIVWhM?=
 =?utf-8?B?SUZlMVgrNjYySEU2aHlHWkwrNzk4RmpWQklucTlCbzRSRjVVU09nZWFzL0xC?=
 =?utf-8?B?Rm43QWtEcXNZNGZCN2NjT1VuSHhGY01PcTdqYUJJTzRvUlI2cWoyYk9TRkww?=
 =?utf-8?B?dWtBeEF1amtURkdUU2Fmc25EdGNoK2tMN0IxWWg5WTQ4RGpCT2RmQXdOaXlu?=
 =?utf-8?B?ZjZTNmZsVUhCYTF0cktSYVZkY0lKakhCNkNpV3F3YzAvN1d2RS91QlBCU3Zo?=
 =?utf-8?B?a3E0Qkk3dXpCRjAxUDBjWENnVEsxcURSREZDVys2aFZuMVhTVmpPeTJGN010?=
 =?utf-8?B?bURKM0RkdENGUlU0Nm12cVJUVUpMYm9mV2RmZ2hxeEVSWk5iN2VCL09XcTRk?=
 =?utf-8?B?aU5wNHdDdVZicjEzMkpibDVNandnQTlOK0tJT3dQZE1wTkVSUTFiL3h1Nk4r?=
 =?utf-8?B?SDNLWHFSY2RVS0RzV2tOd2xZS2phb1JQZDFKZkNDZHBSTmljcUJ0QkdpSEJR?=
 =?utf-8?B?RXJnc3VRTjlOWW8yOGJiUlFlSWg1anpxVzhSOEJWZEV3WlRYU1hhd2tzTENR?=
 =?utf-8?B?N2tNZGQrUFY5MDcvQzYxc1d3eWx3WCtMUEJSUVJsV2hiUW5BSWxjbHFlTTdC?=
 =?utf-8?B?aWgvOEVsUGQ0d0d0ZkRCUFh2bkMyQnRjbTBiRGNUSWdXYXEzbmtwTE41NmF5?=
 =?utf-8?Q?IPO9CAFVRJ6GRZJk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 414bec42-0b59-430c-c994-08de7551be9c
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:11:48.5253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSjY/2YCUGJPf8e1PHYGNsrPhWD/M0iFDYsSYFIlB461s6CP1vSCRpZ7lyUGoSo519dKaN0miOKr0EI9cpS/5S8/t+FoeZkWHoP9YK1BCsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5855
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[efficios.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[efficios.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-78591-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[efficios.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mathieu.desnoyers@efficios.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:mid,efficios.com:url,efficios.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C66FC1AC3CF
X-Rspamd-Action: no action

On 2026-02-26 10:56, Jeff Layton wrote:
> Update format strings from %lu/%lx to %llu/%llx and 0UL literal to
> 0ULL in pipe, dcache, fserror, and eventpoll, now that i_ino is u64
> instead of unsigned long.

Doing this as a fixup at the end of the series breaks bissectability.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

