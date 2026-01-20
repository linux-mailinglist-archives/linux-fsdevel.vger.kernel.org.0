Return-Path: <linux-fsdevel+bounces-74679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICkJA/ukb2lIDwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:53:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D046CB4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1647B9C09F8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 15:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E68C44CADE;
	Tue, 20 Jan 2026 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xCi31Qxj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020127.outbound.protection.outlook.com [52.101.195.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CC244CAC7;
	Tue, 20 Jan 2026 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768921353; cv=fail; b=VDY8YHX9izd19L0uYhGVbomfsV82YdsZY0WGOSftC3yr34WbXhySEJs6WAEuAKJcz+IEF+3kQ+FpR4Kd6reVJOpkCjWVgjANC7GGWbzRJq2SPwO7pN3XSC5YJVrw3wnCH6NGHqJLqDS5wJhvozVuqDVW8NI6JqXVCvpwxl0TvS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768921353; c=relaxed/simple;
	bh=yFUZBNsPYVN2G/8eVuVc+pa7FWejRMk/y9mPJfZelR8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=QnKDo/Cmdx0aTVkhehJvCKF6Lq2+Um5KyECfSVqrOzADhzhY6Gc+eHJuKqVpVFbfLVXqTB0e1SHyWjxBfu/MTbdAM4RtQ2/vvalm9zJnTW+3IV8lWLDkfzQ7lTbfNnq0B3EkBcN8I7cXHdPpzcWsa/UxXQg8NNZE6wAFgjsuwR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xCi31Qxj; arc=fail smtp.client-ip=52.101.195.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8bZV6xI5pRYhdK9J7+asvsFzgQ+4/RoeuAqT5wJ3Ao8bl4VJaqcZPwLnCNG0IYHCltDfIwgB33Eo00MZvrbqJq01nnYkT/YsgHSN6Ljv50FRjujHfmILNRjDjc63sKicHxKHWgoGhuyT1f2qOJ3Mt0cM4CwhdqMvMoyLOGuzkg7dfX6ie41iQyKbRT33Jj/+Pg8lgSBz1+Ds3KNlhoHHAN11tuDpOqp6NL/l0FMaF3P0CpTGlZAmI2WKpWS4m9LcURPodlNZvBpQci4OiWbMLITma3wiMQ7rdXR+zafMgCElj1fsyRT2d/qZlUi4K0E4ndL+DYC9bGUdr9PnFpzaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wve/qPEHZp2VJOtAK46cDNchXWSZ80hTLqAvVw48kdE=;
 b=k5fOyHPkuETFPRReFaI/HvDgyoyv2JwvLcq755GyRXwsGv3CgcnWZfiXJ19/cPMVydJt0ghU/GhwxfMrb5y91MnZN74zxgumB2Y5qmHosegIxyKTg5KZC8VdzmEns58fhEUm+VAE4EHP3rauT9WsZkDslKTPZc7MmdadpyOhjgesOfsXZRYo+CLiLW+wgqxmrbgzLl2MhTN8x4wZ44kKw4YgFChmZyla70X5Icmyx5AXwwzEs/8ABmuVLLj24iKsZNlDlms0nnwly1hp67cg1bp6+JXIQPVaqd/dwSTyENqgYJ2G1E5oCgJcEh3R9gT1sBhs3exf9yG1VrUSakLVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wve/qPEHZp2VJOtAK46cDNchXWSZ80hTLqAvVw48kdE=;
 b=xCi31QxjvWvOzT+Tk5Im/OTh3lTdZn7vF0j5eUga3aeeIyYiESOT2vfPQpBZSBHSvJ5QND8/UzdMTH7yR8/Kes1+LdUGxnSeLF1wbJbV6slXfeZB3Rq67T5PWK4REL/HMDCb+FZsh5xcFDReo/WH1slndHJc9VX15FSCPLw4IKA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB3665.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 15:02:28 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 15:02:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 15:02:26 +0000
Message-Id: <DFTIA7Y3MZFR.3LEHVWENE4Q4R@garyguo.net>
Cc: <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <dakr@kernel.org>,
 <gregkh@linuxfoundation.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lossin@kernel.org>, <ojeda@kernel.org>,
 <rafael@kernel.org>, <rust-for-linux@vger.kernel.org>, <tmgross@umich.edu>
Subject: Re: [PATCH] rust: replace `kernel::c_str!` with C-Strings in
 seq_file and device
From: "Gary Guo" <gary@garyguo.net>
To: "Ryan Foster" <foster.ryan.r@gmail.com>, <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <DFTI0P4F3UR9.14CA9H3I19GCB@garyguo.net>
 <20260120145912.281977-1-foster.ryan.r@gmail.com>
In-Reply-To: <20260120145912.281977-1-foster.ryan.r@gmail.com>
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB3665:EE_
X-MS-Office365-Filtering-Correlation-Id: 69992d84-8c6a-4675-edb6-08de5834ecc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1RYRzNyaFZWNExNczFOemtHTEJSUzdaaEpoUGQzcEVkTktkMWFJSm1YRjJi?=
 =?utf-8?B?QXVBOHI4TnRzQlgwYm96OGxhcEFTSEIxSUgzeW9HaGtiOWZMQmZvNHhUS3lF?=
 =?utf-8?B?RjFuSEhrM0Zxb2N0L3RjQzkrTGJvUkJKdHVLd3R4M2hvVWVvWGltbEduaDN0?=
 =?utf-8?B?OXhRdzQ2KzNzakM4THZaVXFyMTljVXk2WmFiVFNoSHV5OVhCVVVvN0NkWUZi?=
 =?utf-8?B?Tmh5WUlhdEhTMEtBR0N2MVBBVEpkUDljblM1Zm1hN1E4NHduMzhSc1RjQzRL?=
 =?utf-8?B?b1JtbVF2TVljUkNXZytjTkR3NDVhR2pTdFl0eW9EVVk3RTNSR3pRRWlpYjND?=
 =?utf-8?B?Tm1oVHBSZ3dKOFhFTzBsMzhOZHhaZDNTSW9zRHQ3NEp2bkdTaTZXaG1hL0Zp?=
 =?utf-8?B?TXJSMU9ZK1hRMzV4YXJMS2MvS1dmYU1lRGZPYmZYT09wNTQ5bGZOSVV2WE5H?=
 =?utf-8?B?c1FwVitiWDBhTUJFQWVWaFlEZWkyM1FXek55SFIxWmlYeTU1YkF0N1dGVmFM?=
 =?utf-8?B?Q1RwSVJQZFQyUjh3NnlXU0tZbHkvcmZQWnVwQTFFS3FuL1hwblFJTHJLUm1o?=
 =?utf-8?B?bHplazlocEdCZklmZHFiRDVybkJRYlRqUkwrZTNCNHlUcFZUZHlYdVlBcVRt?=
 =?utf-8?B?VC9MTXhDNGpJMFViQXQ0NFlMMG1mY20rcjZaTXF5aEoyRHd6Wm5yRmdXN3ZJ?=
 =?utf-8?B?UTdMUnFleFNXR09uY0MreHN4RWxWa2RQY2s0U2lNNmdkaThMeHA5dkdaRXJl?=
 =?utf-8?B?RGp1TFYwUFNMSWlRdHJxcUtkQTBwSU1RQjRCalE4MzNrMkdvUDVFM25JWTFC?=
 =?utf-8?B?QXRobTdSZTRXUk9BNXlvdFA2M3Flb0xLUzR5UDNVdDdGMHFwbkYvVVBJQXpK?=
 =?utf-8?B?TksrS21Wc056NWUzdEIrV2l0V0dEWnBEcVRiMUtpTlRDdVg3TnRKYytrMVZy?=
 =?utf-8?B?dkt6emVHQXlGQTZmcnVKVjNDNk9RWHFmcW9HanMwQ0c4YUo0U1dJNm15aGpO?=
 =?utf-8?B?MnN4UTltamVWclR4TWpNeTUzdzdFaUg1eFQ5OGVydStFQTdaRmVIUytuTUIy?=
 =?utf-8?B?eHQvcjhWaVZhQ25ZR1VqY3dZejk2SXFNYjlDeEo5NHoyUVB4NTV3QnRZeUVC?=
 =?utf-8?B?ZlZRY21sNXl6L1RiaFZnRHZDazI0VUJSRVE2a2hXNHNOdTVONXYyMFh0UGQw?=
 =?utf-8?B?TEp2LzVDdWIya1hGTDZFM0UzREx4a2FOVEwwcFp5aVgybnFsS1U3VXhxMkZF?=
 =?utf-8?B?UlIwMGY0aDdoajk1ZVQvMW5MRGJzektuUVN0UnB0UUZTdGVGVTRqaWJ1a0lh?=
 =?utf-8?B?d0pNdGprZDFDMkY0MldNT2ZkbkVGVTBBS0JyNGluTzdLRTlmQVFHbVJYOGg2?=
 =?utf-8?B?STZOSGswQ2FyeDduVjlIeWhaekNnR3FTYVpNNUNTVE00dnJGWUxGNnZibWM0?=
 =?utf-8?B?RFhqV25CRkhaemEzRnRnbzNOK1hxT2tJUDczck8xeDZNbkI5ejFIYllxN1dq?=
 =?utf-8?B?dEFQcU5WU0dKbjNGU0lsRGhNeVB3dXRSZUtGZHluVjd2a2NzYWM2STZ0OU80?=
 =?utf-8?B?SkZ6ejFXVERDNlorTy9CWTNmdW1jN3gxaHNIblNveEVkZ1ZEdTBnRXJpNDVC?=
 =?utf-8?B?S0hUODJKUDhjTFhOdFVrVFZlNUlSb1FIbng5dnJlOXhzTzhGd2s1by9aRlpS?=
 =?utf-8?B?MTlKWVZDeGJCVFZsQW5qamJxNUJiZlZrRHBXZFY5WndOR0huVmdCZzVvMkNm?=
 =?utf-8?B?VG1LdmY0VTJMUGVObDVjby9lNnhKbURqRGdkSUx5OTJQZElLNFppcnM2THRW?=
 =?utf-8?B?VU9tc3lXZEg3UUlFWHVUUjdRS3pwVjF2ZktIMlBlNEZJODlWU0hpWkxzemU2?=
 =?utf-8?B?dHg1Y280Z3I1OCszb1ZuemRZT2JuNnFiVDlDUktuY2RGL2JlUTZtMFJkUVY1?=
 =?utf-8?B?WXZtc2VSY1ZNZTc4SVY2cXpKMEg3WE1qSUh3Q3BmS0ozeXRFWjFIWEo4bUx1?=
 =?utf-8?B?ZjNFUE85aUM4YmdlR1VMNCtoOTZHWFVHeTB0dmt5MDExNFFrb1duU0xDTVBR?=
 =?utf-8?B?bHNJdXJaczZYM3prV1hjVnJMNUx2Z3BHb2grL25VVUtldXgrb2lFdEliRDJl?=
 =?utf-8?Q?VNE8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUR0YXA1OWJranRWOXZJSkNrVmFweVp4WFZ1RjRtU2FWRGZDZm9FMEJsUmUz?=
 =?utf-8?B?b2NpZXRIdEMyNnhzYm9Jb1NtSUkzRTA3ODFrc3JDdlJRcHBpekJ2REFiY2Fh?=
 =?utf-8?B?RHBUUDB5cXJJYzNUcVJsMjBJNjFoS0FUMWg4QUxNVE10aTJXcXNvb0VNT1hy?=
 =?utf-8?B?YzhFbU4zcWh2RmxLUVhKVDQ2Y2RBWHFwRitqbjFBamZzejh5QUFPQ0JJT2lk?=
 =?utf-8?B?c3RSbzhnMk5KN2dieUk4SWhZRUU3MC9OenV0c2VuVmZwczdCaGMycThKcHJZ?=
 =?utf-8?B?M280WEVoRWYwa1FsQU9UYnk1NW9nd1kvb1BkeHJwTWZ2RHlXeXhLYUU0Nk1P?=
 =?utf-8?B?SWFsZFVRbUZzWlByM0NsZklWN1hsRG1iVnp0UEltVmRyT3VFaW42aDZSUWdI?=
 =?utf-8?B?bkJlbHJKNDdKTmp2UWU5TitvTk1VcHhDNVcwdGpMYUkyU0cxNHR6TmMrQ2ZF?=
 =?utf-8?B?VG9ud3J6NkNEaFRyOTBKc0pFc3ZIbGxFRzhVcEJpUDc1dm1FbHVlWndHVkVi?=
 =?utf-8?B?RXpkUG9xWEIwUEhMY2pjUDQyVDgyT3JVMmVKNCtaNGZyb3JqOFAra2ExZEhX?=
 =?utf-8?B?cmhPaTE1ZERsYUhaQW00Y0o0ZHhWVEliZ0wrMUllT2w4Zi9JdXBzYnc1Ymg2?=
 =?utf-8?B?bXFmSVFmaUF1L3dmeUM1cmpSbFpTSmxCcjNYOUZrVEtka3EwaGhxOWd0d0lF?=
 =?utf-8?B?UnJxRWl5RzgzNXQyRnZsODlOZGdXYTlhUVBqWUM3VGlUMEl0TlAyVGJiTnc0?=
 =?utf-8?B?UC9iZngvQlFhQXR5aFh4QlR5SjEyajBzWTd1VVcxcDlsYS9JZ28xbEFnTUtq?=
 =?utf-8?B?bmRjY2t6NUxaVXN5TlcvVml4alFzNUlqWW9UNUVnOUMxNkExRDE4aUQrVEdp?=
 =?utf-8?B?Q1ptVXk4eFNpWFBIZVdBaVBnM1ErcFp0ZlNXeFJIcDhES2JkcnlwaldCZ0s0?=
 =?utf-8?B?L1M2cmhxTTVBSEVsalE4dGZ5bjI0QmRPTVdTbkVqc0c3NWV4dFRQNThrNmRL?=
 =?utf-8?B?cU5DbWEyWUFFZVNQNVBXL2lvL01ZVjFHcFRpcGtWeno4K0l0eWF6MXpBZ1BV?=
 =?utf-8?B?aWlSMTRwd0NWMGFBL2xhV0pVQjNDZFBNRXlpYmdudkN0aEgyR0s0ZFZnVG9s?=
 =?utf-8?B?dHdDeVpTRHREK3dlTlUwZXN3M25JMW8weWFBVzVyTnRuZXE2Yy9YdHUweUhz?=
 =?utf-8?B?VlVSck1VUW1Tck4vQkRJZ25wUkRYU29GdFZDKzNTbVllcXloeFMycmxaUjhx?=
 =?utf-8?B?c0MrODllU29qRVZwQlNpZWhTeHFKQy9IQ043ZldlcWQ1TmpNVW9tVDFWMXdI?=
 =?utf-8?B?UWpmUW9jeUtvdTNvNWNyY0RET2NOTjZ6Y3h6bFZMWXBlWnRZVXVnNE9YRFB4?=
 =?utf-8?B?bW5Ub0tmVnZuZktRSFZpSXpsa2FXcE5ieW1IMjhGVnd4TnJCRnN1RzJuc0dN?=
 =?utf-8?B?TEp1d3FQSzUybURQNHQvR2RwR3NaamZEaUpvb2FXYXMrRTRzMnV3TklJYldy?=
 =?utf-8?B?bDlLQTZmSk5zTnRHaWFqUDdQdi85K01iMmx6c0xKTVY4aS9Kb2R2UXlvUE8r?=
 =?utf-8?B?RVNoWDlhOENyOE9BdngzaVVrVlQ2SFRweDVKTEdRaXBtUGV3WVU4OWRneW9s?=
 =?utf-8?B?cVJGcU8vTUpaVUtMdnRMamRzalJvV1l5Rk1xeUhuSE9DalE5ZVRyMHkydnBN?=
 =?utf-8?B?OFZIcjF5Z1NkOHhRUUV1d2dQN1REYWJYVjlvcFZCYnNQRG9PVXdhVGRqUmhG?=
 =?utf-8?B?TjNCQkMyWjArTHFMMDdSTjVsbTNEZEtaMGRWVkZZdDM0RzR4UHhtSklERHFC?=
 =?utf-8?B?RzB2c0ZSY3BvODFPSGRPajQxUE9wVDhzNGVQUmk0aHN6ekhHSUp4MFJRT0lx?=
 =?utf-8?B?b2lDeXp6MTJKeUJ6L3BGNThYNkwzeFlHM01zL3c4alpROXBLRGxlcXpPRzBv?=
 =?utf-8?B?QWlabFlZUnd5OXBwZU10enVYT2lQWG11UWVveE5pWWFrOWU5ZXdOOFhENTIy?=
 =?utf-8?B?L2RiaHBKaFdFa1QraitXa3JXaXVNZk1GQ0dlbnVhZk9nS1lqQ1FRNGJQbnFu?=
 =?utf-8?B?UjFha3gzeVRkT0p3V0lHM1hLbjUvVURmNWt0NVpQamxYRE9nL0JmQ0ZDNEVN?=
 =?utf-8?B?YkdJSWt5ZnJTSDJnelo1Vng3VzNZV2gzYkRJcHAyend5UXRoeG1QVCt2Sno4?=
 =?utf-8?B?RGRlaThtdVY1eDQ1dSswOGR4S1Vjb2dGc3MxZEtiS0d6TVkvQk10Q3o2VDRV?=
 =?utf-8?B?Y2FGYkNHUHpDNmZSQnJnbTE5NzNJTVRpU0VtNytFMk8wZ2w2OUVRcTRGWkk4?=
 =?utf-8?B?bGs0QlVLV1VJRE9VMU9QOFlpd1lRYWhHamwvNGZPQmdtQkRYWDRsZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 69992d84-8c6a-4675-edb6-08de5834ecc6
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 15:02:26.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0ZqfemfzNchDC1EunuhWYxZHh80cxhzVcBL6edSFrppqZ3lHYz44l8cnUskBKlYyFLyHr3pD/Ny168nJANkVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB3665
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74679-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,garyguo.net];
	RCPT_COUNT_TWELVE(0.00)[15];
	SUBJECT_HAS_EXCLAIM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,protonmail.com,gmail.com,linuxfoundation.org,vger.kernel.org,umich.edu];
	DKIM_TRACE(0.00)[garyguo.net:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 9C6D046CB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 2:59 PM GMT, Ryan Foster wrote:
> C-String literals were added in Rust 1.77. Replace instances of
> `kernel::c_str!` with C-String literals where possible.
>=20
> This patch updates seq_file and device modules to use the native
> C-string literal syntax (c"...") instead of the kernel::c_str! macro.
>=20
> While at it, convert imports to the kernel vertical import style.
>=20
> Signed-off-by: Ryan Foster <foster.ryan.r@gmail.com>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/device.rs   | 19 ++++++++++++-------
>  rust/kernel/seq_file.rs | 12 ++++++++++--
>  2 files changed, 22 insertions(+), 9 deletions(-)


