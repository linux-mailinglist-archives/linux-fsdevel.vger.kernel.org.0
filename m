Return-Path: <linux-fsdevel+bounces-76038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKN6N8CYgGnL/gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:29:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A05CC5BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 13:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A9A43004D18
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 12:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3272336605E;
	Mon,  2 Feb 2026 12:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="0X0mbuQp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022098.outbound.protection.outlook.com [52.101.96.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E73719D093;
	Mon,  2 Feb 2026 12:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770035375; cv=fail; b=tzkPLLGI0IFILcCFTCsjPO9F9nPqyQaBONLdwmktLeFtrHm5u3yFvyWPnWpgI0LsiDLTN+3rrx5HlKc8+mJdHh/bnyAvDsW+txo9DYTFGdWS+wXDuRbqHhb85gRE2Q4bunaKDGM0K8zwtWqGT3Trjbp6w7XePP60PerdrIir/EU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770035375; c=relaxed/simple;
	bh=p/OVEe4lOH7N2B8rcGP1UmTA5NWtxEDwzSJmBuCqBEQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=a9UfDE3sBWrDXgJFZ7Bg7HUe6dkv3nyOMF28BcRWPELzkMxKEno0M2PjATYgZi8vBWxwmPLqAwfkvqjdE/Tq1HKR7EBgJreTepq9aJqKSQkXouzCt2ia1erSBScicvzTUHnyvc/7SPk9qZkbv5T0XflOQboI5Heb5+e+fnVEppA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=0X0mbuQp; arc=fail smtp.client-ip=52.101.96.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoiAxIvtVpLwLVHJmnZfyOPZTLwMInv/fgL41T7ui1oyJJGLMgSMSMMMxK5yk0PUbQVl3uvK5n9/drrTrGRMZlv2psSs9aKNxvUfJ8FqcelFPNWGhQRzC9H+WxmCxai8PVz46SpJsmjXOgWt6XiA7WtYimsFbaHoDjAFbL7+Zol1nfcg8PF7N7NxvDJR5zffh802DRsVHRK8BXQjigD63UAWVfBEWlnhTW/qkdQI43BYJ0KWMjoD9maJuipxvgthxWRHqhUKvoPcK0kCqV5adl+iFJ1RSNl35uIC4pfY5Pnrh+EICFqdxEvTF43NMCzn/n92wDbEfhFCJbjaluOKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rz/EY4KH3M+xF+iXiCZ6IRfUWPnwmZjwYsOm5pHELm4=;
 b=Zy2aYlAgagm7mAQAlAyeH6vMCqhK6l7YU0uDvF8GTSojTVRyLayJAnM+xEBrkPwx1HwaxfPXFXrvuMNJ2boEYegSzfujL3fQ2VF8V+l9KWbiu/8T4WN6wMnFDhK9rVnYOvnfbrO2kT+Alb6B1X8dTQ6XoT7Q14ubhWxU5K9H8CIPyk9BVK6Law6ybks7VbbBD1bjVh+PDi6XdEwzMqHg+Aje56a9HKZG7DhU6JVLokmDqtM1gR0dm9MgdV8efW0jk2JWoIeMxGsg8QgRmRAMQyhbCpflsjHc2IZueEFZvfkYjCU/XoQTdvTjJHko07LRxQBzAUcy2iGh3BD6MNsvIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rz/EY4KH3M+xF+iXiCZ6IRfUWPnwmZjwYsOm5pHELm4=;
 b=0X0mbuQp5WcQGVv033AWCHPqkGdJ0NC4SkWKh4S8xhVZFYZQ+/6x/Co0Od7p2V3xbNMBh6EbLEsPzI+qmxRBVwUEJoR6FMEkk5O8AfNQ6fytc1cuCHJezXTJHsZK3qbcJGz4DNlRVoEBhB16Um7SPkmJ9JxMRErMmQodXdZamb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB5469.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:25c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 12:29:29 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 12:29:29 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 12:29:28 +0000
Message-Id: <DG4H66NZ5ME0.3M9CQY1ER4Q0X@garyguo.net>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Benno Lossin"
 <lossin@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexander
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>,
 "Jan Kara" <jack@suse.cz>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, "Viresh Kumar"
 <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen Boyd"
 <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Paul
 Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>, "Asahi
 Lina" <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v13 1/4] rust: types: Add Ownable/Owned types
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Oliver Mangold" <oliver.mangold@pm.me>
X-Mailer: aerc 0.21.0
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-1-b5b243df1250@pm.me>
 <20251201155135.2b9c4084.gary@garyguo.net>
 <87343jqydo.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87343jqydo.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB5469:EE_
X-MS-Office365-Filtering-Correlation-Id: a65cfe18-98fe-417e-3147-08de6256b5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003|7053199007|3122999021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TWRwNTNadkJISktPRklVdWFlQVc1d0h1QWNkU0ZTSHFXREsyUmxsN3UyOGdm?=
 =?utf-8?B?TmtDOUYvTkZndUFJMlFYREFZNmt2Tkt0UDc4VktPSGdNczMybkRpKzlSV2Vw?=
 =?utf-8?B?NEp4U2wwWC9Rd200dlFDOGhWVDVsbm5qYkUyQTJuSWJnSEs3eTNMNTV1bDVL?=
 =?utf-8?B?YldIeHNtUEFxQmtnQVFMNXpLTkZOdTIvdW9OTE9TKytpNUNWQ1pGYk9HN3FZ?=
 =?utf-8?B?VmM3Q3orbkw5WUpPM3pMcHhCUVFZVGxoSllWVFh5N1RpUWdVY3ZWa2tLd3o1?=
 =?utf-8?B?L2dXKy9YSTB1N1EvRDluNGw3d2JqUWRFQVRKU2I3Vi9DMlBNZHZpd3NkcFFk?=
 =?utf-8?B?QnlhcU5WeUU4cjFXK3JrOG43ajJUSHZsRTFWakhmbllOcndYaGlPRE5ZVU9E?=
 =?utf-8?B?T29tUHJJbFI4dEFNaDRldVFLRDZzOFUzS1p4WVI4YzhQdHNiK094T2J3Yk1o?=
 =?utf-8?B?NnVoSEZWRVdvQlZycllVYzJGemRYb3VsbHVMdThzUys2ZTUvVGxJajgzMDRL?=
 =?utf-8?B?eXBaRUZ2SXFhSGdGczhLTUNLSTFickdyd2lwTFcwaCtYNzBaK242ODNjWEg2?=
 =?utf-8?B?cnJQRElKL0MvUFR3QzBJUnY5YjY5Y2JqZ2pGUTJhRUsvN3dIdUgzSXRmVm5Z?=
 =?utf-8?B?OWVyVlB4d1NvWkRCRVdVSUkvVXRRYWNXNklxZFdTOGVDeEpWSFFMcEtGdXU2?=
 =?utf-8?B?ajNTK052ckx5RnVkZFBId0RjSGgrQ1JuWkdFeVdJTEluaFczSnkzay9NcEUy?=
 =?utf-8?B?T1lLbTkzQU1hSlV0REJoem52QVJvZDg5L2cyamgvdE1YOFlkVVdTSTBnK2ds?=
 =?utf-8?B?VVArNTRGQ1RFUWp5ZEhpSXVIeWhTZTJVYTl5V2xQVGxIM2tyTTJJMGg1cXdz?=
 =?utf-8?B?L2xnbWQwVzZXeE9tUHJ2MHJZWm43M2phaVg3QVJIaFNNUUF2Rng3U2JhOTBL?=
 =?utf-8?B?SHlLeGxNMFF1RUFVQ244cGc3SlYyTzhqcXhxZDdPNE15dkYxblU1VE94OS9j?=
 =?utf-8?B?RGhxNThMeDQ0bVBBYWhndjMxWkl6SkZlTWVvWWpvbFU5cVpaT0RDVDlyZ244?=
 =?utf-8?B?S1J1WmlmMGM4cmhXVGhteGNqR2kxWHlxTDFzNGtIZkY4eUlNQzBTQ1hpdTVS?=
 =?utf-8?B?ajJRQ011MnNsTkRRSmd5ZHJRaFhaaHQ2RG8xTjdTSnZrcVZmY1hIbVA4NGh6?=
 =?utf-8?B?cmlGbW9ZQkN5TlVBTEU3VlRnZE9ON203eFpkZ0lXU216NzRVR1NkTEtUZFBI?=
 =?utf-8?B?anFVWi9IaVJCcGdtKzdtdSszTW5neVZ5Mi9yUVNZckVVYmpDV2xzNHJTRkI1?=
 =?utf-8?B?S0FlNGFCa1hlRS9XYk40SHJ4S04vbzZHUTBVUlQwelZQOTNNbjNWd2twNjNl?=
 =?utf-8?B?L2NzSWNSbmVXTDZJV214Y2k1VW14dWhaSFl4SXZvNHJ4ZVB5Uyt3cERZZ2dq?=
 =?utf-8?B?a3hublFYQ0ltTUFJcVB4cU44cUh2b1BSaUkwRWdIaE1OdDc5ekZuYVdvaXAx?=
 =?utf-8?B?cDZWeFMvM29XZlo3YnprV2h5cjIwY2kvTy9lSmFVS3VUQUk4QXAyQnRxL0hu?=
 =?utf-8?B?VEw1RFBERFZzS3FhS3NrdU5zMExDS0lBSkdvVldEdmpDTkZvS1MzR2l3eXBB?=
 =?utf-8?B?emJYMmxwK042SjBZYzBJNHg4enZGYUhSQXQ1TjRnbW5JV2U1c1ZhV1laNUlC?=
 =?utf-8?B?NFNVeTlHMWsxdmZJZ00rb25CejAyMUd5UHpDaEtYOEVjamhoVmVjWVVYQWY0?=
 =?utf-8?B?OWFvL2djc0lHbTJLOFNUeE8rQk9EMmc4UGpPWWVRcG1adFc4QnoxODVJVnA1?=
 =?utf-8?B?Q1Zta1AwaFZCZ2pYQUMrWXNhdEFMMk1uNFpMWTNzUmtMdzg3SFBNUDNKSW1G?=
 =?utf-8?B?bUdTZ2I1Z2N0aENCMm1jWjQxRVA3b08xK1pMMlZiTlN0NXdMQ0hUQi95L0s1?=
 =?utf-8?B?Nit4TDFkZncwbzNZOVNXckNudnBBeENMUFltSTkxZi8rTGwvYkZDdnhKb2tM?=
 =?utf-8?B?bVBXVGR5UXR3cENLMC9DVDZkczFOUVA0ZlNWMFRDdWlacGVpYXNOVUd3VHZJ?=
 =?utf-8?B?NE40aVV6d1BHNldxQ09iWXZrdG5IZ29ybFZoc0JhZTRkN3FBbVpvcGJ1WmtD?=
 =?utf-8?Q?nObg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003)(7053199007)(3122999021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkd4SDBuaGtPYm9reDdrTS8xdkJCRExQek5IaUFvQUlkUk95VEo3TXNyL3lQ?=
 =?utf-8?B?ZFZGbkFxRjhTekhsbStkSmhDc09nYTRSeW1rN2pDNWE4UWVPNGRUdUhvVDgy?=
 =?utf-8?B?OWxNUDJPTzQzVE0reEh2QzAvaWRhdWp0QStlaGk1VnFJdGFnemVOYTBVcnRs?=
 =?utf-8?B?YWp2OGxoZUUzTHVUZk91Z1JMaFlGRVFWWW1kNG9CSGNKSVlaRWVIY2ZYQUNa?=
 =?utf-8?B?eGM2bGN1R3d3UktPNDlwVWNOSlVsYzJ4NkZGQ1c2UWlVaWc1WDBkNjkxS3FL?=
 =?utf-8?B?S1B3a0N3a1E1c3VsaDJCK1BUaWJvcHNwZXJDd3plK20vWTVjU09ZVldIa2Zt?=
 =?utf-8?B?dGdZU3dIb2d6MGVYT0VxNXdXL1BCUXpTS3VtYTQ1QVBIb0Z2MHBXSGZrTGds?=
 =?utf-8?B?WHAwY3h3OVRCaDlpbDV5Rjh0ZjR1c1BHSVgwMmRCNlE5S1hKY3RTTUt4aGxh?=
 =?utf-8?B?Zks5aTZIVVUwalpXdWkwU0dlN3d1RzYzTXE3d3d4NGU3WHROVlIzNEl2UzJq?=
 =?utf-8?B?N3Brek1uc1FUQzJQNGI5eEVaQ2xjYVE3emdVME5MSHZDSmxXUGxKNCtzM3Fx?=
 =?utf-8?B?aHN3dmp5R25Ed1A2ZnNiQ0E3eElUVGlrSGQwand6NzVhSWpFR0hnVWNTN2dM?=
 =?utf-8?B?ZnQ3VjZacTZhdXVoUnpKTVNvaDVqSHB3aEdNekxNNmpQeE81TFJ3QjZBWUNj?=
 =?utf-8?B?L3NHMHdoS0dvVmFLVVY1NVJsZjVHSnZyTDE0eFYrcXhGWlBleXdYaXRoWlJW?=
 =?utf-8?B?RUJFVWhWVHlNTHJraGd2S2dXQisvM0JIbW1DbVFZb0ZwbEp4Zzc1L0NNZk9K?=
 =?utf-8?B?b0UwU1F1eEhRWlY3SDdqaTl2R0lMUWI0RjhDRDdOK0ZqNU9SVkc3WFIxMUxQ?=
 =?utf-8?B?SWU4WXFkRjh6L1BZTHIyT3RscHpvRFFpSXIyRmtuSmJKSHZzSy93bkYzWnc3?=
 =?utf-8?B?WjdxbG1qdWVVclE5VTVrV3BidlQ5Q1hnUXIyWTBNMkpzVldmczZEdXh5anVN?=
 =?utf-8?B?Wm9zVXBha2xlWHVnOXl2bldrWG1IWEZsbHVHOG9YejdhUVZFMEMrb01oQzZp?=
 =?utf-8?B?Nm9CNWtTNWVsLzBYdVExcENLVFkvbElHajVaS2hHcFU1elN2NTBaQ1NBNlM0?=
 =?utf-8?B?TU9VRjVYNHV0UzI1U3poOGNDWVBYNWZmdHBTNjlGTnQrKzBaRS9vUkdCQ25W?=
 =?utf-8?B?Um9oR3Z6Y3dWdysyeXByYWJCRmNXekFrTjFYVk04bHJIV1BqWGVQMzBhL0Q2?=
 =?utf-8?B?elZ6ZlZLb2dKQXFYYXhkTnZ4VDBKMjdVWGk5M0FkQ2F6RDl1MlRFdVdsTmVr?=
 =?utf-8?B?dDV3QzMzMDVWdUxiUm5sekFIamVrd2pna3RvZWJGVWFPSS9CRTREeXBJVU5Q?=
 =?utf-8?B?NkVHS0ZpYmVraXdTcFpoMzZ6OHhSQ3VPWCtIaTFnWlpxRVQ5cGthSjZGN0p6?=
 =?utf-8?B?TXNxZCtDUERJTzU0eEwwRWxuUy9qdHQzY3RQNlJZOGdraG5vcWJrS0NsR1lT?=
 =?utf-8?B?M05yQ2piRHhDaEcwOGVCRVkxWXdGVlJVYVZLUjYwSWdVMUgrY3NsM1VqbE9l?=
 =?utf-8?B?UUFqcngxVDhRUkRma25pc1Z1QTlQMnMyUUYxbXMvZE5sTGFVV2UwY3djcm9B?=
 =?utf-8?B?TERGWGtEb2lXQndFVWpVRFNHOXB1aGRnOFVIVWF4ZnovL1ZoR0tybVZ2c0NZ?=
 =?utf-8?B?YmNBTWFRVTVUcGM4S21YYWVTdzdrY1dIYUI1YmxrWi82bEx0Q2E2eG5rYkRz?=
 =?utf-8?B?M3R1dHZGT3gwdjBVV0dFa3g1Q29nU2FrVS9vdjYzejBLeDVOUE1MalBWVVNM?=
 =?utf-8?B?elQrZi9aYVBTR1hpR2lmdnNUOGR5ODNvWXJwc1lhd1BDdm0zR0ZBeDNEYWZa?=
 =?utf-8?B?RTNRRzBGZG1SRWxoYUlrNHlvQ3dwMDFudXlVM3A0TzBHOG9UbFdReWJlVnlI?=
 =?utf-8?B?eGJoTkNLaUdVeENpci94L3IzTHV3Qm10UjlMV25PNitKRnl6SC82eUMwL1R6?=
 =?utf-8?B?K0k5cGw1Zno5UElsdE9nVGRjWjdmMFpmcFZQS2h0S0R6TUpFVXdGNW90clFM?=
 =?utf-8?B?YllwUVRxNE11c3l3VkVOWkpOYUJnREp2dzlWam4yTVVKN2hzZFZETkRWUUVa?=
 =?utf-8?B?eWo1MGhxUTkwTXAyOE0rcGpUQnFHNHFuSHh4dnRSbUg2ZDUwK3JjeWNLVVRI?=
 =?utf-8?B?MnhzSHdTL2RMZGxsVUs4NytjSG1uaDlsMEkyWWloTEgvMWxYeUtiSzBncnly?=
 =?utf-8?B?eGloWXd4M0JNU3RtWWhZNUtkWGdRQXYreWgvYUtEL3hoMTRFSkxzb0U0cURs?=
 =?utf-8?B?T281RWFINmc1TFlRVUZYVFNUdFF1UE9OYU9iY2ZkWGg1OTNKdThvQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a65cfe18-98fe-417e-3147-08de6256b5f8
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 12:29:29.4701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gB7f8qgRlyBGh+RQx7Xbx1aFzlKPl+4erOte/9RDAQmyLmYs9r4lXW/4T+AOYSSwNEy9GVohdBbLpF68iTJ1wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB5469
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[43];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76038-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,linux.intel.com,suse.de,ffwll.ch,zeniv.linux.org.uk,suse.cz,oracle.com,ti.com,paul-moore.com,asahilina.net,vger.kernel.org,lists.freedesktop.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,garyguo.net:dkim,garyguo.net:mid,pm.me:email,asahilina.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 06A05CC5BF
X-Rspamd-Action: no action

On Mon Feb 2, 2026 at 9:37 AM GMT, Andreas Hindborg wrote:
> Gary Guo <gary@garyguo.net> writes:
>
>> On Mon, 17 Nov 2025 10:07:40 +0000
>> Oliver Mangold <oliver.mangold@pm.me> wrote:
>>
>>> From: Asahi Lina <lina+kernel@asahilina.net>
>>>=20
>>> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
>>> (typically C FFI) type that *may* be owned by Rust, but need not be. Un=
like
>>> `AlwaysRefCounted`, this mechanism expects the reference to be unique
>>> within Rust, and does not allow cloning.
>>>=20
>>> Conceptually, this is similar to a `KBox<T>`, except that it delegates
>>> resource management to the `T` instead of using a generic allocator.
>>>=20
>>> [ om:
>>>   - Split code into separate file and `pub use` it from types.rs.
>>>   - Make from_raw() and into_raw() public.
>>>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>>>   - Usage example/doctest for Ownable/Owned.
>>>   - Fixes to documentation and commit message.
>>> ]
>>>=20
>>> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@=
asahilina.net/
>>> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
>>> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
>>> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
>>> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>>  rust/kernel/lib.rs       |   1 +
>>>  rust/kernel/owned.rs     | 195 +++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  rust/kernel/sync/aref.rs |   5 ++
>>>  rust/kernel/types.rs     |   2 +
>>>  4 files changed, 203 insertions(+)
>>>=20
>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>> index 3dd7bebe7888..e0ee04330dd0 100644
>>> --- a/rust/kernel/lib.rs
>>> +++ b/rust/kernel/lib.rs
>>> @@ -112,6 +112,7 @@
>>>  pub mod of;
>>>  #[cfg(CONFIG_PM_OPP)]
>>>  pub mod opp;
>>> +pub mod owned;
>>>  pub mod page;
>>>  #[cfg(CONFIG_PCI)]
>>>  pub mod pci;
>>> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
>>> new file mode 100644
>>> index 000000000000..a2cdd2cb8a10
>>> --- /dev/null
>>> +++ b/rust/kernel/owned.rs
>>> @@ -0,0 +1,195 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Unique owned pointer types for objects with custom drop logic.
>>> +//!
>>> +//! These pointer types are useful for C-allocated objects which by AP=
I-contract
>>> +//! are owned by Rust, but need to be freed through the C API.
>>> +
>>> +use core::{
>>> +    mem::ManuallyDrop,
>>> +    ops::{Deref, DerefMut},
>>> +    pin::Pin,
>>> +    ptr::NonNull,
>>> +};
>>> +
>>> +/// Type allocated and destroyed on the C side, but owned by Rust.
>>
>> The example given in the documentation below shows a valid way of
>> defining a type that's handled on the Rust side, so I think this
>> message is somewhat inaccurate.
>>
>> Perhaps something like
>>
>> 	Types that specify their own way of performing allocation and
>> 	destruction. Typically, this trait is implemented on types from
>> 	the C side.
>
> Thanks, I'll use this.
>
>>
>> ?
>>
>>> +///
>>> +/// Implementing this trait allows types to be referenced via the [`Ow=
ned<Self>`] pointer type. This
>>> +/// is useful when it is desirable to tie the lifetime of the referenc=
e to an owned object, rather
>>> +/// than pass around a bare reference. [`Ownable`] types can define cu=
stom drop logic that is
>>> +/// executed when the owned reference [`Owned<Self>`] pointing to the =
object is dropped.
>>> +///
>>> +/// Note: The underlying object is not required to provide internal re=
ference counting, because it
>>> +/// represents a unique, owned reference. If reference counting (on th=
e Rust side) is required,
>>> +/// [`AlwaysRefCounted`](crate::types::AlwaysRefCounted) should be imp=
lemented.
>>> +///
>>> +/// # Safety
>>> +///
>>> +/// Implementers must ensure that the [`release()`](Self::release) fun=
ction frees the underlying
>>> +/// object in the correct way for a valid, owned object of this type.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// A minimal example implementation of [`Ownable`] and its usage with=
 [`Owned`] looks like this:
>>> +///
>>> +/// ```
>>> +/// # #![expect(clippy::disallowed_names)]
>>> +/// # use core::cell::Cell;
>>> +/// # use core::ptr::NonNull;
>>> +/// # use kernel::sync::global_lock;
>>> +/// # use kernel::alloc::{flags, kbox::KBox, AllocError};
>>> +/// # use kernel::types::{Owned, Ownable};
>>> +///
>>> +/// // Let's count the allocations to see if freeing works.
>>> +/// kernel::sync::global_lock! {
>>> +///     // SAFETY: we call `init()` right below, before doing anything=
 else.
>>> +///     unsafe(uninit) static FOO_ALLOC_COUNT: Mutex<usize> =3D 0;
>>> +/// }
>>> +/// // SAFETY: We call `init()` only once, here.
>>> +/// unsafe { FOO_ALLOC_COUNT.init() };
>>> +///
>>> +/// struct Foo {
>>> +/// }
>>> +///
>>> +/// impl Foo {
>>> +///     fn new() -> Result<Owned<Self>, AllocError> {
>>> +///         // We are just using a `KBox` here to handle the actual al=
location, as our `Foo` is
>>> +///         // not actually a C-allocated object.
>>> +///         let result =3D KBox::new(
>>> +///             Foo {},
>>> +///             flags::GFP_KERNEL,
>>> +///         )?;
>>> +///         let result =3D NonNull::new(KBox::into_raw(result))
>>> +///             .expect("Raw pointer to newly allocation KBox is null,=
 this should never happen.");
>>> +///         // Count new allocation
>>> +///         *FOO_ALLOC_COUNT.lock() +=3D 1;
>>> +///         // SAFETY: We just allocated the `Self`, thus it is valid =
and there cannot be any other
>>> +///         // Rust references. Calling `into_raw()` makes us responsi=
ble for ownership and we won't
>>> +///         // use the raw pointer anymore. Thus we can transfer owner=
ship to the `Owned`.
>>> +///         Ok(unsafe { Owned::from_raw(result) })
>>> +///     }
>>> +/// }
>>> +///
>>> +/// // SAFETY: What out `release()` function does is safe of any valid=
 `Self`.
>>
>> I can't parse this sentence. Is "out" supposed to be a different word?
>
> I think it should be "our".
>
>>
>>> +/// unsafe impl Ownable for Foo {
>>> +///     unsafe fn release(this: NonNull<Self>) {
>>> +///         // The `Foo` will be dropped when `KBox` goes out of scope=
.
>>
>> I would just write `drop(unsafe { ... })` to make drop explicit instead
>> of commenting about the implicit drop.
>
> Agree, that is easier to read.
>
>>
>>> +///         // SAFETY: The [`KBox<Self>`] is still alive. We can pass =
ownership to the [`KBox`], as
>>> +///         // by requirement on calling this function, the `Self` wil=
l no longer be used by the
>>> +///         // caller.
>>> +///         unsafe { KBox::from_raw(this.as_ptr()) };
>>> +///         // Count released allocation
>>> +///         *FOO_ALLOC_COUNT.lock() -=3D 1;
>>> +///     }
>>> +/// }
>>> +///
>>> +/// {
>>> +///    let foo =3D Foo::new().expect("Failed to allocate a Foo. This s=
houldn't happen");
>>> +///    assert!(*FOO_ALLOC_COUNT.lock() =3D=3D 1);
>>> +/// }
>>> +/// // `foo` is out of scope now, so we expect no live allocations.
>>> +/// assert!(*FOO_ALLOC_COUNT.lock() =3D=3D 0);
>>> +/// ```
>>> +pub unsafe trait Ownable {
>>> +    /// Releases the object.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that:
>>> +    /// - `this` points to a valid `Self`.
>>> +    /// - `*this` is no longer used after this call.
>>> +    unsafe fn release(this: NonNull<Self>);
>>> +}
>>> +
>>> +/// An owned reference to an owned `T`.
>>> +///
>>> +/// The [`Ownable`] is automatically freed or released when an instanc=
e of [`Owned`] is
>>> +/// dropped.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// - The [`Owned<T>`] has exclusive access to the instance of `T`.
>>> +/// - The instance of `T` will stay alive at least as long as the [`Ow=
ned<T>`] is alive.
>>> +pub struct Owned<T: Ownable> {
>>> +    ptr: NonNull<T>,
>>> +}
>>> +
>>> +// SAFETY: It is safe to send an [`Owned<T>`] to another thread when t=
he underlying `T` is [`Send`],
>>> +// because of the ownership invariant. Sending an [`Owned<T>`] is equi=
valent to sending the `T`.
>>> +unsafe impl<T: Ownable + Send> Send for Owned<T> {}
>>> +
>>> +// SAFETY: It is safe to send [`&Owned<T>`] to another thread when the=
 underlying `T` is [`Sync`],
>>> +// because of the ownership invariant. Sending an [`&Owned<T>`] is equ=
ivalent to sending the `&T`.
>>> +unsafe impl<T: Ownable + Sync> Sync for Owned<T> {}
>>> +
>>> +impl<T: Ownable> Owned<T> {
>>> +    /// Creates a new instance of [`Owned`].
>>> +    ///
>>> +    /// It takes over ownership of the underlying object.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// Callers must ensure that:
>>> +    /// - `ptr` points to a valid instance of `T`.
>>> +    /// - Ownership of the underlying `T` can be transferred to the `S=
elf<T>` (i.e. operations
>>> +    ///   which require ownership will be safe).
>>> +    /// - No other Rust references to the underlying object exist. Thi=
s implies that the underlying
>>> +    ///   object is not accessed through `ptr` anymore after the funct=
ion call (at least until the
>>> +    ///   the `Self<T>` is dropped.
>>
>> Is this correct? If `Self<T>` is dropped then `T::release` is called so
>> the pointer should also not be accessed further?
>
> I can't follow you point here. Are you saying that the requirement is
> wrong because `T::release` will access the object by reference? If so,
> that is part of `Owned<_>::drop`, which is explicitly mentioned in the
> comment (until .. dropped).

I meant that the `Self<T>` is dropped, the object is destroyed so it should=
 also
not be accessed further. Perhaps just remove the "(at least ...)" part from
comment.

>
>>
>>> +    /// - The C code follows the usual shared reference requirements. =
That is, the kernel will never
>>> +    ///   mutate or free the underlying object (excluding interior mut=
ability that follows the usual
>>> +    ///   rules) while Rust owns it.
>>
>> The concept "interior mutability" doesn't really exist on the C side.
>> Also, use of interior mutability (by UnsafeCell) would be incorrect if
>> the type is implemented in the rust side (as this requires a
>> UnsafePinned).
>>
>> Interior mutability means things can be mutated behind a shared
>> reference -- however in this case, we have a mutable reference (either
>> `Pin<&mut Self>` or `&mut Self`)!
>>
>> Perhaps together with the next line, they could be just phrased like
>> this?
>>
>> - The underlying object must not be accessed (read or mutated) through
>>   any pointer other than the created `Owned<T>`.
>>   Opt-out is still possbile similar to a mutable reference (e.g. by
>>   using p`Opaque`]).=20
>>
>> I think we should just tell the user "this is just a unique reference
>> similar to &mut". They should be able to deduce that all the `!Unpin`
>> that opts out from uniqueness of mutable reference applies here too.
>
> I agree. I would suggest updating the struct documentation:
>
>     @@ -108,7 +108,7 @@ pub unsafe trait Ownable {
>         unsafe fn release(this: NonNull<Self>);
>     }
>
>     -/// An owned reference to an owned `T`.
>     +/// An mutable reference to an owned `T`.
>     ///
>     /// The [`Ownable`] is automatically freed or released when an instan=
ce of [`Owned`] is
>     /// dropped.
>
> And then the safety requirement as
>
>  An `Owned<T>` is a mutable reference to the underlying object. As such,
>  the object must not be accessed (read or mutated) through any pointer
>  other than the created `Owned<T>`. Opt-out is still possbile similar to
>  a mutable reference (e.g. by using [`Opaque`]).

Sounds good to me.

>
>
>>> +    /// - In case `T` implements [`Unpin`] the previous requirement is=
 extended from shared to
>>> +    ///   mutable reference requirements. That is, the kernel will not=
 mutate or free the underlying
>>> +    ///   object and is okay with it being modified by Rust code.
>>
>> - If `T` implements [`Unpin`], the structure must not be mutated for
>>   the entire lifetime of `Owned<T>`.
>
> Would it be OK to just write "If `T: Unpin`, the ..."?
>
> Again, opt out is possible, right?
>

When the "mutable reference" framing above I think you can just drop this p=
art.

>>
>>> +    pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>>
>> This needs a (rather trivial) INVARIANT comment.
>
> OK.
>
>>
>>> +        Self {
>>> +            ptr,
>>> +        }
>>> +    }
>>> +
>>> +    /// Consumes the [`Owned`], returning a raw pointer.
>>> +    ///
>>> +    /// This function does not actually relinquish ownership of the ob=
ject. After calling this
>>
>> Perhaps "relinquish" isn't the best word here? In my mental model
>> this function is pretty much relinquishing ownership as `Owned<T>` no
>> longer exists. It just doesn't release the object.
>
> How about this:
>
>
>     /// Consumes the [`Owned`], returning a raw pointer.
>     ///
>     /// This function does not drop the underlying `T`. When this functio=
n returns, ownership of the
>     /// underlying `T` is with the caller.

SGTM.

>
>
> Thanks for the comments!

Best,
Gary

>
>
> Best regards,
> Andreas Hindborg


