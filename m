Return-Path: <linux-fsdevel+bounces-78598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLxwMqyDoGkDkgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:32:28 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA7F1AC7C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 18:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2606A3366F75
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Feb 2026 16:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3580A3290B8;
	Thu, 26 Feb 2026 16:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GSyPd+jT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020139.outbound.protection.outlook.com [52.101.191.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D0F3290A9;
	Thu, 26 Feb 2026 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772124060; cv=fail; b=Dsx+c0nf9myyqH8azlW8KvPRaADwZU2tbF/3PXVSENhFrJAY+xGj7F/Djzzuv8IfRL6YhSC+gdClq5q+VHaz8Tqkh8qj7//auGqS71RvPcZ5HG1JA3+rfu47ksrbmjurtNHR3ruelMD3lMBc0O95qd4ihZdEasAgpVYDDntc4S8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772124060; c=relaxed/simple;
	bh=UBW5EOhQYklkf/9E+JX6kJ/8VR1WLxUsek3EgtQjGOI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=q6f8wfTlWor8JaTA9ys2nGx+13T4x9FuV5jWcz78gT6/ld6Nt51rJcdZ8f4WsVQ/7kK285IseBv9Q4yZZ63HJ/1BdmVKoiS8F8swLegXJwB+VTzXorvsIOYTker7phnx+yBdkgXR/4ILQbEVl9BboGOo35ASrOpQbSTfR+QMIK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=GSyPd+jT; arc=fail smtp.client-ip=52.101.191.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jbfFQ6i5ISV4Z7YUMQDOHb923NTkybEOmdcqE4FmX6GqE77q+SEvJUhkBiAqkGPoY56YSMX/Q4t2LYS847/nJscQ7Cy6xeYbOjSbLNvs1B5Dje8rWEWMUlxGcWYavr7htecCpnG/PIFXMWLymap49rNOWzlRBBSGIbV4k9u8ulhDJoQzaglTeLCfj3/ohWCWh/dete+9NluDyS9foXKIny8Ner0s87zA+RZ14B9cF3FWNRnqlULcT0wx/Yh94s+GPHCWPj5fnYpEfjAVdoYhVT2EyZJpIDcgS+NRpDL+2sFOA+d8knqdzd8b9i74sHDH+QLA2HB+YPfl42jtE6b4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiSxF2GJ5iPLF9Z5QKv0+UvuKqhizFojrOViC9jU7b8=;
 b=czFkyZlCC+WuM3qo90ayJaykywdKTmtXVG4XwRFcazIFucB3HUJx02/Afx5gkuAxjuNtu2uVNy/inUvm+TBORDo4Sgs0gcNtnPnNmP9O7MdlFSFNbT/MK4NLBixK6Khw3Un71wXjVKqKrqRCEp5vRtVCA0WiE/W1d5iqP5+uy1E9F1RI0Qpl9Hc8qjI515f5UPV7meX8FAcSdHn4ub/MDrNiFXPRPhuDSRyonfeMPyWHktLAdRAC00lkTXWbwmZ31bgFSD11rZLcNcWrMmK67OG+Y/xoWWwjZlCaWjGyqHSFpQA2ZDYc2G83eiDMnysxiKE6NpelWmUUnZNb5cMX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiSxF2GJ5iPLF9Z5QKv0+UvuKqhizFojrOViC9jU7b8=;
 b=GSyPd+jTErYQq8xaXUC18if+Zjo0zjBzHbpIuDkFfujfhPkrk7nWIo1v786mk1kvvs9Djgiwis658X413xY/DlIwqmjC6oc/OWBv2FuULEkJED8gpggc/avSYRXZxXBphJhWQurBQqiy2wQVqbRReoe/9IVH1m7vP7ptgkZaLRStGBwvrZIDCwv3N7JlRtL5wxmS1nOwdAs7DcF55c2zzet3jjkGIhURCvD3PUHz1kHJYkjYNGzDAJXQZ6+yAG/X1EZXpu30+zO+osHS00K9XtATzyetRtjoeWs7vPnzcFLTThdt55wv5JsJmEmDC+YSg2Z4E5hpRbJ4/BTs1dEVVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB5871.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Thu, 26 Feb
 2026 16:40:55 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%3]) with mapi id 15.20.9654.014; Thu, 26 Feb 2026
 16:40:55 +0000
Message-ID: <540a4fa6-40fc-4302-aaef-3df5fb3a8cef@efficios.com>
Date: Thu, 26 Feb 2026 11:40:53 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/61] vfs: change i_ino from unsigned long to u64
To: Jeff Layton <jlayton@kernel.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260226-iino-u64-v1-0-ccceff366db9@kernel.org>
 <20260226-iino-u64-v1-2-ccceff366db9@kernel.org>
 <06c94e29-32d8-4753-a78c-8f5497680cf4@efficios.com>
 <df0b9e26fca0dc56a10e2f6792892c7b5f23c84b.camel@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <df0b9e26fca0dc56a10e2f6792892c7b5f23c84b.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0398.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::19) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 407258dd-4889-468f-38a1-08de7555cfa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	T2A5KWkJ8AXw1OHx2nEBuk5ZuDJiwNaSfdkN0F7qOPTKuiswUF3Lpr6PxuS7j6cj9uhetK2ECAH5gEIiV2g0NGTIC79cyABLk8fntWN9AXnipz/z3ogMqXr8bpRa2nZjV+QRPdGSvZg1hHQimTgeQAl3kCaBiYEtb/UFA6tWPsDD5u43w3kpqc+A4nlSMfpy7z0MUqf3Agyv04jVI4+UJUpls0iG3jNQ8xYr1XIhRckKbw9XqlFqc+gzVQKosf897VsnVwIlPA50FT9L/jubXUH4AfhErnCwUsRSHC/4vRuIlbQYPjR/Co6tuiJBoq7ZETVNQ4AWZgSQMUhCSvZE6ZC/+QEbKawjVIRQtIqzgJIFtbkCF2CPh6lsuwsQY5En2Chyu3XlOZSmLyclXTZIQ+gry0NN0jyivygiafy4RBB/TOSk7aoUKvsXpJ7byALhzWBeUTdK5HzJReCzQ5ecpyFu7wCQMfrOHdCDiuofP3uIzDNVnk3LKv1runQmYFeT2GjbpIPrkKnxBhddo9sYpo7W+eWZSyO3VcAHKzxa1X+UPFEdHhlAuzU/OuOKRDqXi/0xtXz7chmHWMs//lpU3XYuz2jFD/ppamzr/tDt5Bs93M7OTBpN7Ya71N5k16Xv2i+hkG0ykQNEHYKpph1WEf/GmWnxk5Kp/oz9KYs5ih8Oe0adWPVvKdvG0Wd4OMAV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bEJqaWtoclA2aDJ4d3djdklCNXYwYjNaQkN6TExNUnQ5S2pBTjF4VnhyZzVp?=
 =?utf-8?B?RTUrYlZFQ1dBMnV3a2s0bDQyS2lPUXZpSDZOVlV4di94WTVVcnVvYmsvY0FM?=
 =?utf-8?B?ZG4yQUs5VUlETmJRUWdCdHRqMU1NeFJDNjNtdEZvNmthQ0k5ZWVBR0tjckhp?=
 =?utf-8?B?U25uQ3RPVXpnSEdFL3dRZmhuSkpIalRvQkZpK2lJR3duNThFSlhXREdWN09k?=
 =?utf-8?B?M2FMUlRWRlVpendqMUxQblJiQ3ZPVXRJRW9RTjIvVFRkeDdNeUZMaFJRSUsz?=
 =?utf-8?B?TnVWRjhJQmNhT3dJdDhMQXN6TTl5QmpCb1BPK0hHamxLMTIzRTF0TTZNNWxI?=
 =?utf-8?B?L2NtS0F6SlNXdVV0by9nc3h6cTAwUjBTNFdpNjRIRzkyTTVaeUpJZTBGZ0xU?=
 =?utf-8?B?ZE0yQ20wcVI0SWExRmhHNDZjQ0ZNeEFPbzVCcnJpTExEbTEvMHBFazVSeUtC?=
 =?utf-8?B?cm5Qd2VLSkkyRGUzSWhwR2ZiY3l1SCtiaWhxYkE5MGpOd0xkdlh1MGR4LzBM?=
 =?utf-8?B?MmFnWE9lK3FEUjNPbWgyNGdJMlBMaG5ibEtIbU5QYU5YQmVYWjVOTUgzTWxT?=
 =?utf-8?B?eWd6RGxWSmNBdlV5Z3VQR21BKzZLSEZWZEtRN2oyZmswZTg3SlNJVTNIeVhY?=
 =?utf-8?B?RCt6WExBTjZJdTIvdFhEKy9vYVNNVVpTOXRqMG5yV2hVRGdzaGdFZVNXL3RC?=
 =?utf-8?B?ZUVscWM3Tm9KYVlmTUE0ejdQbmRIRkRRelpzdDNmL1YyTlBnUHQ4dm0zQ1Nn?=
 =?utf-8?B?KzhjYlFJRnpQemJDb0VJejZCckZQWng1aW8xZWs5b1d5eUpoOGFvNmJTeGJX?=
 =?utf-8?B?MjYyclpVbDhLazhoUFNOSDF1S3U4aFk4cVdHWlBKTjB1VjVTUld4UTdyNUYv?=
 =?utf-8?B?dnQwKzJrNGRkTUZKWjVyQ2E5U0pmZC9TbGNPWk5CQkVNUkxJZFhFWVBnd0Np?=
 =?utf-8?B?eWh4c0MxbmhsaGJhd3Q5RkVwOWc2WkF2WjY1cTV4NkZIK0RlSVRRZ2JBUnhr?=
 =?utf-8?B?MUdwaGw3NmtTUEV6a3d4a2gwNnFWYzRQcHhSZGpJVEw3TG5CWThtNHRpR1Nl?=
 =?utf-8?B?UUgwMWVja2FnaStpUjM3RzVNV2ZaU0dwK3ozYTZsT3BmK2VtZnBiVnlSaFRj?=
 =?utf-8?B?UWJQMjJZTUQ0ZFhQZmFSSG9YZHEzcWN6SW8zdzZXUU1rZ0FDYmtQNVFGR25p?=
 =?utf-8?B?RnIxUnh3RGt0eG1ydEFUcnVjSkREdERQOVphdHpPRzZ2VStmaVYyekU3OWQr?=
 =?utf-8?B?a001RGhtQy8zanZFM0xYVTdKMEdxRGEyWDNobkJxOE9FOVA1alQxOEU5MVZj?=
 =?utf-8?B?YjNGc3R5T0hoSS83U1B6d2VYdEFDaVRFb3BtZHBKWE1kWkRmQUp0SU1pa3RM?=
 =?utf-8?B?SFV6eDVLaTFTaHhEbHhxcGErRGpIVnluUjI5bUdadTZoRTVSSE01dDRKenFs?=
 =?utf-8?B?QnZ0eGM4QklZOWEwVTN5eEFYd0FSWmRUMUxrWUVWakJHa20rM2pxb1ZsdzJz?=
 =?utf-8?B?YTdRMHJGMnhmT29GZ1lEZzUvWHRPVHMxQlU5SHc1MHJvV3RIY2trMTBoNHh4?=
 =?utf-8?B?bFlGeTRZdWtwY3RTZmVQckdLemZHSitZei9VRnBPUEZxa2VpQjVTV3AwOEFE?=
 =?utf-8?B?bEZLK3U4QWNnamNVN0xzckZzZ2xCc2JNR3dNc0lrbWhXcTdWZzhkOThQdWhI?=
 =?utf-8?B?WmtuaERSaTVsR2ZubUFpOG9DN3o5YURIU1J1N2FxM2labU9aN2VvZStxcVpS?=
 =?utf-8?B?dkF4b05DZkRtZnJxVGRXOG9IS1lsVFpoUUV2NTV2UU44cU1WTGVHQmthMVhj?=
 =?utf-8?B?Y0Y0OUhmUmtXTlJSWEUzNUIvTEl2YmorOVR6TGFQTnVDUWJTSlVUckpsSzY2?=
 =?utf-8?B?d21ZVFp4VVJTcWkvZUgvbFRwSytHTmdDK01RSjhaRnA3L0ZhOXVZV1FDdWIz?=
 =?utf-8?B?UVBuVG1OYkRMbUk1d1dYNGZCQWRsVHIrMVdreEdkZGpYWEFjbXQzd3F3bDZ0?=
 =?utf-8?B?WWQ3aXFZUWhyTit2Qm84bjlURDZDL1ZXM0hGOU9HUGtGRXF3MWYxWnU0cTBw?=
 =?utf-8?B?THg0T0pybWZjTXhtdDVQT0FqSlBjL28xTncvWjNQR281VjlPTjBPWFpGTCtO?=
 =?utf-8?B?b0F0TmtET012Mmo4Kzl4blM4VGZDTW03MGNFbVU4NCtjZXcwbUtqMS9RY1BI?=
 =?utf-8?B?VWJIUEZWYlRySEJWWVc1V0lRb0hJdmtSOHlmKzQvOWZQbnpzRU41SmV3SDRL?=
 =?utf-8?B?V3krSnk5OHJ6S1dKNzJVMklhNjlXUXlPaE84NHB3ODRXRU9jUDVxc25LNWhU?=
 =?utf-8?B?c2FYd2RHM3NiUy9CRnhTR0swbGZtQjUyYmVwWm9Tb1puaVhaMnFheXNXOTlX?=
 =?utf-8?Q?lCH7ydG5N46iDM9NIlRsLV+liV6SSjht9KsNQ?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407258dd-4889-468f-38a1-08de7555cfa0
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:40:55.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu5dKKP+/8NTfMrIiiZPrmicoSFhtIkg0jXl292z4Z+ER2kZoP2MY7tLg9N20yFrYaBmnSQlGxJWAPhdVygyaVV+X76CknIZNJgS04AKUAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB5871
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
	TAGGED_FROM(0.00)[bounces-78598-lists,linux-fsdevel=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[efficios.com:mid,efficios.com:url,efficios.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CA7F1AC7C0
X-Rspamd-Action: no action

On 2026-02-26 11:35, Jeff Layton wrote:
> On Thu, 2026-02-26 at 11:16 -0500, Mathieu Desnoyers wrote:
>> On 2026-02-26 10:55, Jeff Layton wrote:
>>> Change the type of i_ino in struct inode from unsigned long to u64.
>>>
>>> On 64-bit architectures, unsigned long is already 64 bits, so this is
>>> effectively a type alias change with no runtime impact. On 32-bit
>>> architectures, this widens i_ino from 32 to 64 bits, allowing
>>> filesystems like NFS, CIFS, XFS, Ceph, and FUSE to store their native
>>> 64-bit inode numbers without folding/hashing.
>>>
>>> The VFS already handles 64-bit inode numbers in kstat.ino (u64) and
>>> statx.stx_ino (__u64). The existing overflow checks in cp_new_stat(),
>>> cp_old_stat(), and cp_compat_stat() handle narrowing to 32-bit st_ino
>>> with -EOVERFLOW, so userspace ABI is preserved.
>>>
>>> struct inode will grow by 4 bytes on 32-bit architectures.
>>
>> Changing this type first without changing its associated format strings
>> breaks git bisect.
>>
>> One alternative would be to introduce something like the PRIu64 macro
>> but for printing inode values. This would allow gradually introducing
>> the change without breaking the world as you do so.
>>
>>
> 
> True, but it makes all of the format strings even harder to read. After
> the conversion, we could go back and eliminate the macro though and it
> would keep things more bisectable. I'm not sure what to do about
> tracepoints though. I guess we could declare a new typedef and change
> its definition when i_ino's type changes?

For tracepoints there are two things: a TP_printk format string (which
would be handled by a new pretty printing macro similar to PRIu64), and
the type used within TP_STRUCT__entry. I don't see why you'd need to
change from ino_t to u64 there. The conversion will happen when you flip
the ino_t typedef from unsigned long to u64.

> 
> I'll let others chime in first, but I'm open to going back and doing it
> that way if we don't want to live with the compiler warnings during a
> bisect.

On 32-bit archs, I suspect it will do more than emit compiler warnings.
Trying to boot a kernel in the middle of the series is likely to lead to
interesting inode value printout results.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

