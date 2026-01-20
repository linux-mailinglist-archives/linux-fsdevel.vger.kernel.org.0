Return-Path: <linux-fsdevel+bounces-74694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIQJAa/cb2n8RwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74694-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:51:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3834AC41
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 20:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E613AA24508
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 16:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E923446B6;
	Tue, 20 Jan 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="oUqFY6YC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022141.outbound.protection.outlook.com [52.101.96.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8B5340A46;
	Tue, 20 Jan 2026 16:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768927631; cv=fail; b=AdYLltn+ZjL7NrIzj1lOYG7/NanocJ8LrpcZFxSsG3iVg0u0KaM21B+wYNnzAiH5Y+fZyrklKD6f3mSmbWqG5+LYPMQJyyi/ndujrWEtVKnI+/0dqdh+PSPxjU5YN82zbAryUeY1kdDoU+aZTytmZSRD6Gbc3PNxkgY9ou6vMr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768927631; c=relaxed/simple;
	bh=3WUfT+KSWsTeeBnVqSTKVn4fPEG2avfUiUG2MI3W/lY=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=kwlxOXDax84DB+QE0HDWmkLDVUCLbmNtk7M/pEp4bwCnZnbzDFrJJwhft/VaEemdsOQG2mLkvyPWUbyQlO+wkIyrGQrh9S/DOsjMmrygzK5TSCmDd5AHMbEKOx5VsYtUozj99VPbE7eDhVQApsLpntsfrr7F0ZmyuVEE189AQEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=oUqFY6YC; arc=fail smtp.client-ip=52.101.96.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceEyMETBY5qVlsQcOdWzKmupWyyrfbBxT4Z0RWlLfVREtM5sazSJkRQuHxydda8shoQ519/ndfnNjc3lGuDQAM5SLn6M7/QqiGWOWNMDD9wgrruYUGC4ogpiwZ1146k77H2i9H3xvkt9LflzRVMYAzvEURb0/3uef44YObb6BFUOsjkhdgCIHYyQus3u0fA+0ToOWRHopVFgnHSq8L6/Er4+WoELP/L+EDya7Z8X6t4gtFVzdhHZYEwvOOVfuxXZ4QLRklsPwEjIWSnKS6DYzZntCmBx3qXg0XSPDUCc9E+IhauFtzNIxCc8Gl7hTbVGi5oTdXrXcPrLZ3BQUa5Kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dW+u8TlYgkM4UdidoWGcQJdulKogz+28gjTDfcHIvh4=;
 b=v9YyL4JXqP0CnCEo0fLHZzBoG9Xf+hydy8yPibxmaRD4mjKk6WqYda040KwxF41q14DfeHmHMibTI7/7RFC9CmDyEmJXdbH+awMPqDlUgGtqman24sZNOPW7rq5WmgnhxFSwEC4711T3x2boPF+NV15MNrsHf5vxqxFgDhVINAFWtRdlp/CRkxhRxSY/8d8fUA52EyStbN4zORCn7gx/pumvQ8PJeOzhZaeXnVF1xb/vlvDGloJlT3n4IicrUHPKZqpWJAiQJoLZGg1XUBV62jMtYduOhB7q76bTZ+06wlLV9BMVCdrVDZPjKtHhkDOl0a8xNKAl7zFudu6//0krkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dW+u8TlYgkM4UdidoWGcQJdulKogz+28gjTDfcHIvh4=;
 b=oUqFY6YCZb7VN+cenjAaBepeljVcNdCsG2UpwdhUk+/KIgzch7wvQ4/1oDgpnUCvlflGsoQkDtHP+iABpP8MnspTei1i6bFEBC7SfDwlbfa225753vU2KX3nAtl7+5c6lpQtUf4lI0aOsnruphz+96+CaM2Fayf/F/B9jDZrWgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOAP265MB9205.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:493::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Tue, 20 Jan
 2026 16:47:00 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9520.012; Tue, 20 Jan 2026
 16:47:00 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jan 2026 16:47:00 +0000
Message-Id: <DFTKIA3DYRAV.18HDP8UCNC8NM@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <kasan-dev@googlegroups.com>, "Will
 Deacon" <will@kernel.org>, "Peter Zijlstra" <peterz@infradead.org>, "Mark
 Rutland" <mark.rutland@arm.com>, "Gary Guo" <gary@garyguo.net>, "Miguel
 Ojeda" <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Elle Rhumsaa" <elle@weathered-steel.dev>, "Paul E. McKenney"
 <paulmck@kernel.org>, "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH 2/2] rust: sync: atomic: Add atomic operation helpers
 over raw pointers
From: "Gary Guo" <gary@garyguo.net>
To: "Marco Elver" <elver@google.com>, "Boqun Feng" <boqun.feng@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260120115207.55318-1-boqun.feng@gmail.com>
 <20260120115207.55318-3-boqun.feng@gmail.com>
 <aW-sGiEQg1mP6hHF@elver.google.com>
In-Reply-To: <aW-sGiEQg1mP6hHF@elver.google.com>
X-ClientProxiedBy: LO4P265CA0103.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOAP265MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: ba67b6c7-45b4-476b-eeba-08de58438842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHN3dHU0dVo5SGdOK0xhd2pVQktGMjBkdE1wRzZwKzZYQVVLR2pyMm9uelNF?=
 =?utf-8?B?YU52dG9wMGhEMmZsNHFyaHNRSndlYTdNNFdURFZUaURhL3hsRUtYWWtDMTNh?=
 =?utf-8?B?ZDh1RzNkQnI1cDJUSjJGQStYbFZUUUFydDdueUF2eG95cXhxdFF5aHZhenRF?=
 =?utf-8?B?T0M1WWVyOGp2dWFaMzZZK1dOUWNuYXkzUXpFVksvRlQvNzhYTkpHVWRpMjN6?=
 =?utf-8?B?RENQb3QyQ1o4TlozNnJEUTBwWFpXV1hBVkszSE8raDhVR2lNVjZXUzFubWt6?=
 =?utf-8?B?QmswYTkxOTZkeE95MlNUV012WTZ0ckhkem9zY1dZV2hIOVRRS1lsWVhIUHhs?=
 =?utf-8?B?ZHdNLzNMVzFkWnd5V1pMdUhXQ0RHREF5RHV5bXI0ZkFkTytVSG8wcS9nczQ1?=
 =?utf-8?B?cmVVUjIxM0lNck0wWGEwL0NNcGtnVi9GK2RlaFlMWTFOQW5IWEVLNDVJN0VO?=
 =?utf-8?B?eTE3VS9JMTNwSTZGSTl2bGJKbVhJa2R0SEVpWlIvdFVZeHdJbkRqZVZTSkxh?=
 =?utf-8?B?dEI1M1QyakwxR1JSaGxFUU5nTUh5aktPTy9NVUlsdzBzSHJrV1o5LzkxaU9N?=
 =?utf-8?B?dk5PaEpJV1BIdjBwUXlCWC9Qek15TkJNeHFDQnZOR2pFL3JrazMraUxvL1JV?=
 =?utf-8?B?UU1kYUhlU2F3S0xmVy94WGFKclNqeTNwbWtYZWVtZk5vU0s2b0xGU1htcXVs?=
 =?utf-8?B?Nm9lVEJwTElsVDVqckVmWHBidTJ6STZnNnlSa05WUURncGxCbDR5QVl6d2Mr?=
 =?utf-8?B?RWw2blR4eGpIc3BpQ2VvaS9FTGM2KzNpSFJndEUvam1mRTVaRWk5dW5BcTgw?=
 =?utf-8?B?Y0U4ckQ0WEx1M0IrUFMxVTlhYU5sdzR0R3hqZnYzdERaYzFlODRnbGFUWWx4?=
 =?utf-8?B?Qm1wZjBhQ3lEeXprWGQrdmM4TFF2RE5QNTQ2UjZNbWl6ZDFGME1RR3ZqZllQ?=
 =?utf-8?B?dVVpMXZ1dDBmb1Q1a0pLVDhXWGtzV0ZlRWZpeDFmYW1nVmpSbDRrRGhsQmJB?=
 =?utf-8?B?Z2k1eFh1Z3ZQRys2VUg0Nm5CZnFOUTI1MFR2WkZjRWVFUElEZWhNaFkxZWl4?=
 =?utf-8?B?TUtLbWhFdWZXdnFHQmMxSEV3NkVZbXZsOFpvUmc2YWQ5ZzV2RDZsRW1oVytF?=
 =?utf-8?B?VkQ3MEp3MjdEdll3MXVqNFNpcFVDbjF4RkltQTl5WWEwc2RvRDBxVXpjVjdL?=
 =?utf-8?B?MTF4ZXBuSVR5czhqa0JZYlBGdENCajNxekF4bnF0Q2FXTTIrd1h2TEpsVkRH?=
 =?utf-8?B?L0ljT1JrNnpLYUwveHU0ZjFtTitQQnBHSU5vMW82aWlNRUdVdERGUElIc2tB?=
 =?utf-8?B?WlRWRkdZYkVKYkRrMTZ1K0FYM1ZiSzM3S055SEdnSnFRaFJLY2dORXUxb2l4?=
 =?utf-8?B?WEFwV0MyVEFzWWwzOVVoRHo0UVY3T3E5UXRNc1B6VS9YMWxObmlLbkxrYTc2?=
 =?utf-8?B?cXhRQkxzQkRyMW5HdXBMT293ZTEzRWtOQkhJMGl3RDkvRENVVllGNFZDTVJM?=
 =?utf-8?B?cGRyZ0lmelkxL1h1akZGQlJkUFpOTlpVRGFuSEZJNHVReHRVK01zaHdmNmlL?=
 =?utf-8?B?eFlvS05kclVNVUlydHJsTDQvYzNPS0paQlZrKzIvWU1DOFlCc2Y3V0ExbXkz?=
 =?utf-8?B?U096TUQ1N2FZemxjNmdML01KcFpnOE92allDU2pqODRpNk8rd0xRSS9YdU1P?=
 =?utf-8?B?a0hiSFhsVGVKSkEzbzlmcjBDZjhGL0xEL1VUNGoramxOdUlPKzFQQklNbE5T?=
 =?utf-8?B?VE0yWUJha0tjcGg3MEtxWU0wMUFEQ1U5aUEySDM4allZbDQwVW1wN0gxMExk?=
 =?utf-8?B?NjFTL0hZR0NvSmxyR1BaRlRaSzlWVk83WWY0Vy9uRzF2RWo5Slg1WWM5TXIr?=
 =?utf-8?B?QjBJYXZjeTFNdlQ3WmtRQ0Zra3V6b0pqSEVXeU5TbmVPRVJwL3N2V2EzRG0z?=
 =?utf-8?B?d1NUNFh2enZQWlY2V2hhbTZzcDE4SVAvRUl3d3BEWWs5TktIUGZlUjZkSEpu?=
 =?utf-8?B?WFU4UDJwdDZmbDFnR2FxQWplc1JoTDNITDdMektXUGFPb3JOeGJtdG1FMXRG?=
 =?utf-8?Q?1Ng/iQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGpzVERWcXpZaDBUNzU1Mk9QU1lDRWJ4bHc1WXd2TG5VMUoxS3V1MjUyb21t?=
 =?utf-8?B?M1BiMzhOa0Z4bTJHU1E1QWpoc2JtZzlIbW9ydnVhSUh0TEdnMVNleWxnbDRt?=
 =?utf-8?B?OGZ0Z2FhSUVqVnZ6TndyQlI0V3BJdG9MUnJoTjFDRWQxbUcwZjhIY3FGR2V3?=
 =?utf-8?B?d2JEYmRqL2YzcVIyRFJQQndoQjVDRHllM0xiSEZpTUp0NEhONVNNc2lQNm0v?=
 =?utf-8?B?TngzQ3pvQnVTZk1VSU5Ed2k1UzM0c1k4aERFajJBSUw2UUFpUHcwUXV3azVP?=
 =?utf-8?B?ZFppbXhEK01KRHJvQ05XQ1JKZWJrelViMUo2amthT1U1czVQUHJRc3d5VlEy?=
 =?utf-8?B?SXRBZFBxU3M5Qm1uMkVYZk5DUHkwV1ZiVGZSMWlPWVhKQUd0M1dPUVJaU2Yr?=
 =?utf-8?B?WDV1SEtEemoxNURoSS9WQThZWGdwbStmTkk5cVRCb2c2SDNBRTBIQzgrRTNy?=
 =?utf-8?B?SFVKK3M5eG05em8xQ2VSZnhRQW9lMFk0NjhtS1lrUEhvbDFXUjFrWFdSTzBO?=
 =?utf-8?B?dVJMSmZuTEhacWh0MHZMQ0Jpb3I4Z25obkZicitUakVHcmFUWkJrNEQ2T1Q5?=
 =?utf-8?B?WjJ3VWVWOGMzV0NzZzVzUW9BV2JZQlBlV2MvVXZrK3ozNzVWckpyck4vQW1L?=
 =?utf-8?B?NnBmQUpUeXBWTW9rdTBBdWN0SkJZTG54alF3ZGZGRENRRWM3MnFRUWhvZy96?=
 =?utf-8?B?YzlwbWpmRkgrUC84MEF4eFY1UnBVMldrQ09JM1hnWUF4aW96SjhtL0NPb0pK?=
 =?utf-8?B?NDFXaFRPTXczSG5ISENNNjUwNDJBRXI4Q2liajVDTjY0dDVWS2VOTFBwNHpK?=
 =?utf-8?B?TU84YnJ6UHpiK1d0cCtMTFk5V202eVYwNXQ0dmlvdmI0TEZvRTVodU1VQTVs?=
 =?utf-8?B?Tk1xZW1DMUxaSkUwNHRXOXpyT2tqZHZYYS9IQ3ZMWisrOGsvZXljYk4zb2cy?=
 =?utf-8?B?QmJSTkVSL2RvWnJKRHdnbnZJZyt4dktnV3g3TEtuLzV3MTliU0w5c3I2V1Zv?=
 =?utf-8?B?SXdwL3JCTXB0cm51bUt0WlNJU3gzcVBOTHdDVmZ0UGJYeW1WNGlxTklJWFJa?=
 =?utf-8?B?SnpLd2hQOVpRdTRpK3ZnMllFTEZQSzM3akpoV0M0RnhidlpsMW8zQWNtRnVY?=
 =?utf-8?B?bnVPOHNmV0JtazExRkc4N1AwU2V4cXJyYitWVnlxVnVQT1ZWT2ZrN2hhcXUx?=
 =?utf-8?B?UUFNNThBMmRNVjRFR09BaHRhNGMvcnFvWlFlbEN5aXM4ZnZuZTMrRXBTM0Jo?=
 =?utf-8?B?bUVSdjkrV1hlZERQcU12eitiYXMrQ2dyVzVsUmlQQXFVdUgweTJKWmkydmsw?=
 =?utf-8?B?cWlCMkNvdW9adDZ6YmZYRmR1dURRS3pXVDlWNVl0T09rU0lkN1VqWFR0ZVZQ?=
 =?utf-8?B?dVgwNkYwN29DV3JWOGZONndyL3FCV3lNSmhlUTRUZEE1Q0U2d3RlTVZSY09q?=
 =?utf-8?B?Mzgvdmo1TnBUbFk4UnA5aXUwWkovRW0wVWNuTXhnV2k5WEUyWFVpSjVVWnRG?=
 =?utf-8?B?THUwUUh3WHA1a2VTcnFvKzRrOE1CYmN1Z2dxckZaWkxjVWZ2SjhtSis4RXQw?=
 =?utf-8?B?LzBPZ0FkR21JYWtuVXVoNE1xd29ZTldSNkQ5a2QyLzM1elMwcnJKRE1yM3Ri?=
 =?utf-8?B?bUZFVGpwUS8vN0RySnM5blJLdUtWZE0zd3ZnMlVkMFM1Y29EV1ZmMU8xQ3Na?=
 =?utf-8?B?ZTFqdXlTNFhOa001Vngzejl6ZVBYZVRHdXZIWWxCRXJNWitjU0Q2V2M0SXB6?=
 =?utf-8?B?L0daajJEV2hCNUFHNks2T1BzRkZVZi9QbXdvcHZpa1ZCdnRzQVc2dWFVRHA5?=
 =?utf-8?B?TUpUQ09nZVQzalpjejhsRTRqcVZvL3c0TncwdndNb1JoT0lQV1Y2U0d4cE1Y?=
 =?utf-8?B?TVdzU2ZPZW9QbnFZOXpWUWxXMkxyQ2FNMXhrVm03em9BOEJmSmJzTUppNmN4?=
 =?utf-8?B?TXRDZ0lOWUFCYS9ORGF6UTlnZmcreko3UjRUMTdncDZzSmU4alpxTVZKRGl2?=
 =?utf-8?B?dnhhbEpYYllBZHlkZ2psakN6dXlKMERoZGdyUUJZaUpiWGtCRGFlM3lFTnp2?=
 =?utf-8?B?eHBZbGEzMG5nL0hGTnRlVVo3SzRSZ25TbTVVUTRtbTR6MVloTGc2RVUxdHRl?=
 =?utf-8?B?QXp3TE9vSUZZVzJwbnlhQVMrODByeCtGSDZ3OGE1OUxTa21QWmpFajcxUjQ0?=
 =?utf-8?B?SzhLWmxJSm04VlV6Umx0SlNFRDhlNG5VNlA5dmRYVmVsM2k3aEdFNFdPaXRv?=
 =?utf-8?B?UmZBSEJST1dENGRaZHdibndpbFcxY09tbmFQOEZIS3RvYWJhTWoyQWs3ZUVT?=
 =?utf-8?B?VEgrcXFVU0JVN3A1MzNQSnZaN3BOb210dWhBNHFiL0MvdzJCaWVVdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ba67b6c7-45b4-476b-eeba-08de58438842
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 16:47:00.6031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vsrk2aopH79eS6qiFHAtzuM3wwS7k3EhfIJYmKuqRuNWIa7jZZsnxvBmDPbQ34yWZW5iwQF1kBK5l3oC21ECPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9205
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-74694-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,googlegroups.com,kernel.org,infradead.org,arm.com,garyguo.net,protonmail.com,google.com,umich.edu,weathered-steel.dev,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lpc.events:url,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 6B3834AC41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue Jan 20, 2026 at 4:23 PM GMT, Marco Elver wrote:
> On Tue, Jan 20, 2026 at 07:52PM +0800, Boqun Feng wrote:
>> In order to synchronize with C or external, atomic operations over raw
>> pointers, althought previously there is always an `Atomic::from_ptr()`
>> to provide a `&Atomic<T>`. However it's more convenient to have helpers
>> that directly perform atomic operations on raw pointers. Hence a few are
>> added, which are basically a `Atomic::from_ptr().op()` wrapper.
>>=20
>> Note: for naming, since `atomic_xchg()` and `atomic_cmpxchg()` has a
>> conflict naming to 32bit C atomic xchg/cmpxchg, hence they are just
>> named as `xchg()` and `cmpxchg()`. For `atomic_load()` and
>> `atomic_store()`, their 32bit C counterparts are `atomic_read()` and
>> `atomic_set()`, so keep the `atomic_` prefix.
>>=20
>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>> ---
>>  rust/kernel/sync/atomic.rs           | 104 +++++++++++++++++++++++++++
>>  rust/kernel/sync/atomic/predefine.rs |  46 ++++++++++++
>>  2 files changed, 150 insertions(+)
>>=20
>> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
>> index d49ee45c6eb7..6c46335bdb8c 100644
>> --- a/rust/kernel/sync/atomic.rs
>> +++ b/rust/kernel/sync/atomic.rs
>> @@ -611,3 +611,107 @@ pub fn cmpxchg<Ordering: ordering::Ordering>(
>>          }
>>      }
>>  }
>> +
>> +/// Atomic load over raw pointers.
>> +///
>> +/// This function provides a short-cut of `Atomic::from_ptr().load(..)`=
, and can be used to work
>> +/// with C side on synchronizations:
>> +///
>> +/// - `atomic_load(.., Relaxed)` maps to `READ_ONCE()` when using for i=
nter-thread communication.
>> +/// - `atomic_load(.., Acquire)` maps to `smp_load_acquire()`.
>
> I'm late to the party and may have missed some discussion, but it might
> want restating in the documentation and/or commit log:
>
> READ_ONCE is meant to be a dependency-ordering primitive, i.e. be more
> like memory_order_consume than it is memory_order_relaxed. This has, to
> the best of my knowledge, not changed; otherwise lots of kernel code
> would be broken.

On the Rust-side documentation we mentioned that `Relaxed` always preserve
dependency ordering, so yes, it is closer to `consume` in the C11 model.

> It is known to be brittle [1]. So the recommendation
> above is unsound; well, it's as unsound as implementing READ_ONCE with a
> volatile load.

Sorry, which part of this is unsound? You mean that the dependency ordering=
 is
actually lost when it's not supposed to be? Even so, it'll be only a proble=
m on
specific users that uses `Relaxed` to carry ordering?

Users that use `Relaxed` for things that don't require any ordering would s=
till
be fine?

>
> While Alice's series tried to expose READ_ONCE as-is to the Rust side
> (via volatile), so that Rust inherits the exact same semantics (including
> its implementation flaw), the recommendation above is doubling down on
> the unsoundness by proposing Relaxed to map to READ_ONCE.
>
> [1] https://lpc.events/event/16/contributions/1174/attachments/1108/2121/=
Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20=
Kernel.pdf
>

I think this is a longstanding debate on whether we should actually depend =
on
dependency ordering or just upgrade everything needs it to acquire. But thi=
s
isn't really specific to Rust, and whatever is decided is global to the ful=
l
LKMM.

> Furthermore, LTO arm64 promotes READ_ONCE to an acquire (see
> arch/arm64/include/asm/rwonce.h):
>
>         /*
>          * When building with LTO, there is an increased risk of the comp=
iler
>          * converting an address dependency headed by a READ_ONCE() invoc=
ation
>          * into a control dependency and consequently allowing for harmfu=
l
>          * reordering by the CPU.
>          *
>          * Ensure that such transformations are harmless by overriding th=
e generic
>          * READ_ONCE() definition with one that provides RCpc acquire sem=
antics
>          * when building with LTO.
>          */
>
> So for all intents and purposes, the only sound mapping when pairing
> READ_ONCE() with an atomic load on the Rust side is to use Acquire
> ordering.

LLVM handles address dependency much saner than GCC does. It for example wo=
n't
turn address comparing equal into meaning that the pointer can be interchan=
ged
(as provenance won't match). Currently only address comparision to NULL or
static can have effect on pointer provenance.

Although, last time I asked if we can rely on this for address dependency, =
I
didn't get an affirmitive answer -- but I think in practice it won't be los=
t (as
currently implemented).

Furthermore, Rust code currently does not participate in LTO.

Best,
Gary

