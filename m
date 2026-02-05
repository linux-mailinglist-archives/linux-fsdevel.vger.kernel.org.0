Return-Path: <linux-fsdevel+bounces-76449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM2HE4qZhGmh3gMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76449-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:22:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EA3F32BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Feb 2026 14:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DB05300F5C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Feb 2026 13:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE43D668C;
	Thu,  5 Feb 2026 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="KVkjzVur"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020108.outbound.protection.outlook.com [52.101.195.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9A378F39;
	Thu,  5 Feb 2026 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770297715; cv=fail; b=h9SXG8iQlc75zXyKU0nuAScgsGEVSdYVyqBm7Hf91uNPgbgTHqw4FSGCJt/u8nTArhgnRDDjC+VrgujgXCbJ+hsE6YoT1YMgRUv2n9lxPuVrgwyEowGpqwX5IRprkFcoNsEGgiBJlR/QyQIrkggdGShOUGSY/1S0+7kTyAQ2A98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770297715; c=relaxed/simple;
	bh=zQDSG/o7UA4wU0lybdORzLVJjPGdZItxqjgeQTNY2co=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=h3OijdpFulFUtRzskFPb2n7ev/gT5n686Fi+4zNal2W3X34dEW3M/5YtLvfqyZQe8bepidvpVd3MaPOTZ7EAXwDoRvwZFcYFwZy41LlebMhVyDopj5v08IktwUfkQWqzMn1prud/D6eKQXPbfJ9dJ+YFO9Q0Pd41OuEI+HQy8u4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=KVkjzVur; arc=fail smtp.client-ip=52.101.195.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=anK59EADLUXSieWh614vOyBeLlywjGnd1+wnAbl9TGKnO9iVORL9X5ASFNAD8uto8PGEAZzFPULup3MP7ZbU7cJ1Y7GjFU1Dj1SfUGmgTRdgDZbwJtPH1MY5QTAlKzUNArV07X7w009AEonfCIoRhW5mNzyLTV9R5doX3rj5oh9he+GRw90A+TE8gVtp7aNJztvPkMvFnloxvFWds7rqZYDqVgeO2oiG1mKX/1I7hadeFKkuOBvMWPhfoIwCCHA1qaaoh1ScrBPdJSX4qs0GAtxIO+GjCEhjEe72tYpcAZV8xz0vyXf5eZ2uLRYU/vYea4iDV+B5122fQ2uNAisxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1wh8qW6xwR3Y83irtAbziNc0hGcc/XN0c+iRXooG2XQ=;
 b=D2t8XRsJP/og/PQEsUCUcZIBUTeMU+JNtTOTxxFRaks98QbsVV3MO4Dqea1gjs1FbwFYfb+LsMLFnWImw8p6V63Z0AgeMRkkEWq26gjsy8wKgkV0f8OjmZDkRhu9AXNKkgiTQUReThUltFOuUtfMARIcylljB2yXHXOWAEjRzUxXFb3dOfh3GBlDKs0zoKhQ0kaWrIRGYWd1MoSDvRjhIxC5YIQe3MybnzHL9lF5AucGYq23VQOG6DdpGtsS0mZI09Ds+7NSCa2P0viy/JqgkaAtVgGWVrzdD8TWt+V5rlP2tiB1q3Pk3DnI95qR2lVn6gbasYiITUpfpiCDszvGpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wh8qW6xwR3Y83irtAbziNc0hGcc/XN0c+iRXooG2XQ=;
 b=KVkjzVurxhFP8qjDQQ2inBid1sdGrsdqjKGOBUvXPIpv8gNUlDCHAXgluJDFh9tB0gKCNdbmgW4PL05VfSRx0oX9wVPiNmonRNWm9vGQ5M2rhJNOR35vvaQed5upYOSa8fAN9k883plxsBE3yKzPzWj5wZ9Ix5uNvb4pOANt8FI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3296.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:177::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 13:21:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9564.016; Thu, 5 Feb 2026
 13:21:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 05 Feb 2026 13:21:51 +0000
Message-Id: <DG725XBFQBWE.286RQFKOIX19J@garyguo.net>
Subject: Re: [PATCH 5/5] rust_binder: mark ANDROID_BINDER_IPC_RUST tristate
From: "Gary Guo" <gary@garyguo.net>
To: "Alice Ryhl" <aliceryhl@google.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Carlos Llamas" <cmllamas@google.com>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 "Dave Chinner" <david@fromorbit.com>, "Qi Zheng"
 <zhengqi.arch@bytedance.com>, "Roman Gushchin" <roman.gushchin@linux.dev>,
 "Muchun Song" <muchun.song@linux.dev>, "David Hildenbrand"
 <david@kernel.org>, "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam
 R. Howlett" <Liam.Howlett@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>,
 "Mike Rapoport" <rppt@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <kernel-team@android.com>,
 <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-mm@kvack.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260205-binder-tristate-v1-0-dfc947c35d35@google.com>
 <20260205-binder-tristate-v1-5-dfc947c35d35@google.com>
In-Reply-To: <20260205-binder-tristate-v1-5-dfc947c35d35@google.com>
X-ClientProxiedBy: LO4P123CA0126.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3296:EE_
X-MS-Office365-Filtering-Correlation-Id: 723d31f8-c37e-49fb-2059-08de64b98641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDF2NXd5am1WNzNkZmdzRktQZC9lUVNxeXl6aVE3N0YrU2tqdlRqQ2IwZlhl?=
 =?utf-8?B?SkEzRWloWnc2K09HaS9hMjlnS2dxZGJTcVRHdEkrczYza3d6Sk9oV1E0WVMx?=
 =?utf-8?B?L2h1WlM1ZHNrQURPMU5pd01FS2dHYXg4UWJPbXNxa2ExdDVsM2lSWjk3Z0lV?=
 =?utf-8?B?WnVaZnlTNzR6OG94Zm5UblJrekNQZEdpOWVmY1ZLTjJtQzJoaXM0YzVZSUs2?=
 =?utf-8?B?RnVwc2l3MWFPQzJjYmRrdlYrVkZDNGh6dlBUb251N2tPcTFqVWVlVS9FWTBU?=
 =?utf-8?B?czc3d1ZzdWE2anYxMEFUNXl6b1FIeVBEZEhsUWphUGpaRDdvSFd0RCtxNWM1?=
 =?utf-8?B?bkM3OEpPV0M0bU50OXFYZXdkeXIxWWdGdnRTSzBJYW1NRnJWVnZlczI3Nkhx?=
 =?utf-8?B?K09YajlNWEhoZjhGZFFKdXlUeXlqZmdUeldKOWNWZ0Z4Ky96clBvQktwUHlT?=
 =?utf-8?B?T0dLanhJVHVRclVwallFRDZQOEVvMlF1aHBiSWdQejNBTFRHelZWbzNGYXBn?=
 =?utf-8?B?QzVFNVRZV2tKYnJaU2VTYU5lb21yNjdyamVsN3lKdWpWazNEbFlzTTQzczFz?=
 =?utf-8?B?QVhjQjkyOEZzTWkvZnNaNGlBaUdWUnFsSVF0OWc2V29kbXJseDJmeXFBbWlR?=
 =?utf-8?B?OTNQL3VSYWFzVDVQZ2ljYTRFd1ZyTE51VGtMcTJnaldxZjFvcldJMWhCSVlw?=
 =?utf-8?B?UHNvQnB6eWd3VFdQZ3pRQjlxVWx1UU42a0N2SVJ2M05XRGhueFRhWHA1WnI4?=
 =?utf-8?B?d3Z0QjZuQnU5RGtzVWVjbVppYVdweTZWNnVMQURLRnpHYmc1WG1ZcVFQRTlu?=
 =?utf-8?B?SzMrYVRVZFdrblR2bnJTVFVtNWJDOUxsaC9jOEVWR09uK05JOStMNVl4K3E4?=
 =?utf-8?B?SFhHeTMvblZVZ1dwbnpXbTVsOWFTU282czJ1bjNuNU5FWWpFREY3TGtBOE00?=
 =?utf-8?B?bUVBVVM1VzJ3eEx5V1Ztclh5M1pyK3puZ3pmSmhpbDRlRlltSTZOSEdYdkhn?=
 =?utf-8?B?elE4R0tuY3dNMzg1eGhxOFJUMlZuS3pwVmpKK2pYTVdoY0Vkd2krTHRMTEM5?=
 =?utf-8?B?c3ozM1dOUzRXbWl4MHhoUDB1bnBIYzFJUmVQSWVuV2hiWDlheE9lZ1ovMjVq?=
 =?utf-8?B?TDRYM1lFekU0OFFYdnY2S3BnNk5KTGU5VW1tTE94dG9mQ1AvMDYyVHE5bGh0?=
 =?utf-8?B?SzlYRkRPdm5lMnFxSkFNeHFpaTBYbWZkOWw0QitjRTZmUC9nSk1BSmxqSmZs?=
 =?utf-8?B?QjR2empXaEFkT2M0M3gvY3c2QmVYTU1hM1VreGliNUhESm9jZVBhVTYwYURp?=
 =?utf-8?B?QUtUVnlYaDBnWDhHSnhXT1JjYXVremlVWFZOeG5UZ2g2SzJ6ZGp5bFBiN1VV?=
 =?utf-8?B?QVhzbXl1aDZ0SzNua0I1dzE2bFVwZFl2cmtic28zMC9zUFluVVBsMlRBMGlX?=
 =?utf-8?B?M2tFQkZ4UXVweGJxeGhjdDh1a2lsSmZCVnU4MnF0SWtQaFZJU2x6Q241NmRM?=
 =?utf-8?B?bnNna0RrdHJxV3NrVWNPOHBNTlRjVGtZaFF5d3dPRzdmVjFPR2pBenpISzVS?=
 =?utf-8?B?eDFPWUMrc0N5VkdJWEtEdXVFai96cXJBR3dwdzVnL3F6a1dZUFhVTHl1YXV0?=
 =?utf-8?B?MkVGUEJMclhCMFBZdkJsMVROcXFFeEg2TWMvRzE4YTI2R2FLSlAwSWJnYzNT?=
 =?utf-8?B?QzFHKzZJNlArUUE3SWxHT3BBS2RWS2E0ZC9EWUp2b1piajhiV3FodEFCWWw5?=
 =?utf-8?B?S2ZMQmlka0xXb29JOUl5K29wOVdCOTU5OTFzT1VtUjVMK1Ntdnd0TnViOHJM?=
 =?utf-8?B?M1NHQVZnWVlnSjNFYUg5dzhSTU40cHR4VEZQeklYYitFNDUwczBHVnluOE5x?=
 =?utf-8?B?TWhaa3FTUDdkK1ZRUlc1cStxNUptYzdTVDhsTzhuUk03ZjBtQSs3ay95Z0lB?=
 =?utf-8?B?cWl1SlhTMXdJVy9hVXNuWVk0VW5IQ29IMy9KRVFqekdmZzJ6bHFwNU5TRnpn?=
 =?utf-8?B?bnptMW9qTGZEUHZYQjJXaUpBMG81ekx6MTh4NFUxajNldlhqZHFKUngwcDIx?=
 =?utf-8?B?Q0NGTE1SYnc3WDdPR09RYmhPMEFnTjkyNUI3NklhSGpLZmo4a2FlSHBRczg0?=
 =?utf-8?Q?wkvg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWZ1OG0yb1pyZHFDN1JqMy82cGVJYlJJS3EyY1BkRmxvU0lEODRlT2NmYk1J?=
 =?utf-8?B?cWd4cUlkM1l3NWlzMDJhMlphQmNicWZBcjdQblpjOUdXWE9GbDlVN0pEVFU3?=
 =?utf-8?B?SnlqbFpvU01QOEtHdHByK05YSmJYZlducEIzWEpnZWN1MVQza2pOZjB5Y3NH?=
 =?utf-8?B?TURRU2pkc2dNZG9EK3NxQThZUzZ2d3Yvd2RSL1BJb3VzcnplZjJHV3JQa2Qx?=
 =?utf-8?B?QngwWDd1NktleXhxVklGYkhpQjBMTnV5V29wSk9Fb0FxVkhyTzlQa1FYSXlk?=
 =?utf-8?B?M2hBWGYxLyt5bDh0RFF4aStETG9Oeld5SVRnTTlaN2kwVzlDUVZ5L3UzbUdR?=
 =?utf-8?B?ZEdoOG50LysyYldBUkR2REdYdlpaYllmVCtIYS9IaWVTWVhvcEpVclcycVRH?=
 =?utf-8?B?SXpUaDdqaVlzWDMvNW0rKy8rakI0U3ptV1pWMG9uS1lsOUN6UmV1ejV1NnN5?=
 =?utf-8?B?S2RMUDNab2tMWFZuK2g1ODd1OXRKcGZjUVcvVVJtdTJoajdLeCthM0RndGJz?=
 =?utf-8?B?SXkvMkZrMWhCUlhHSVFBVkl4LzIzODdzOHpUUGxuR1M4WnJYc0R5d0JMMjlZ?=
 =?utf-8?B?QzdNVmkva2tzRWs5T2hsWGF6SnRJRlA4NFJUNkRDcVJpcjd4a0ZZZDRWREw3?=
 =?utf-8?B?Z2lOQ2lVMGt0NU1PWTBaeWpscGpuNlBPYVRuNll2c3RBaVUrK0NSUTQ0RUd2?=
 =?utf-8?B?VGtuamdBQzJ1V2tKRmR0UmdSRXp4MTFIUERTeXIzNGc4MC9PZUd3MDFLRkg0?=
 =?utf-8?B?Y2M4VHh0MVFRK0dNU3hZZFBiVjR5cVl5bkkrVjhxa1pueEx2RzQzTFpPVFlP?=
 =?utf-8?B?aU9ha0tCOEJLQ1ZzckE3U21ibmsrQWt6ME9YcDdDTjVJNmZEUDV4K3c2aFRy?=
 =?utf-8?B?d280R004aEVhRWJEMEMvU2dDQk1EMWdOamd3SXZXSlNCd0c5ZUFuZWlKNnRp?=
 =?utf-8?B?VkwwOWF2cmJ5aUpLa0ExSnloRHRIWVp3Y2pxNUlnaVVtMGVCbU9oS3p1QXhC?=
 =?utf-8?B?VTFVQWNRa25nZStVTGJxK3NvajYrQi95VmN1QXJ1eGN0NlVJUXlnSXRnUmVM?=
 =?utf-8?B?cUxsbFRZNkFNR0IvRUVDVU1ldXhkQ3d3NlNsVXFXcHZFMnhtNWJGTmNoY0Y3?=
 =?utf-8?B?SnQ4c28xbHE1MWdNS2hTVHk3bUQvS0sybUdxYk1ZdUdMaC9kRGxMSFZHL3Mv?=
 =?utf-8?B?dlNqZ1FsUkpYTldPbnJ5VnpHOWYrdzJvVnFlQjVpS3lCMmwrYTkrSmp0LzBU?=
 =?utf-8?B?M0ZKSXk1OURxVzdxa2ZLZmtKUTRxc0Jxa284c3REb1ZqTE14cFF6bWxkN2wx?=
 =?utf-8?B?LzIrcXJIellXMzM5MW9MWnZ3eHdGbkNKVXhOam0wU0wxbFRqT3F4TTNlRFZV?=
 =?utf-8?B?Z1BhMVplV1JiSFZXNkowbHlBZGNtWHhrODFhU2xZQVRidUF5YjhzdE55U2tG?=
 =?utf-8?B?NlN5MlhvSmRGOGpkUFlhbVh6SE9wUWl0M3ltdHBBWkhGcUYxMjUrL0tyeTZN?=
 =?utf-8?B?Mll2Qnc4RytGNnpzRmtvclBFMkhaMjlzS2tOMUh3SkQvaWZUTkFFaEFUTmd3?=
 =?utf-8?B?aWlkeGNLM3dxL2VZcUsyaHNYd0RMU0RPNWJQT2dtZld3Q253aHJyS2dCTHNV?=
 =?utf-8?B?ZWdrYmhKczErdlgzVnBETmtUamZqeU5IcndZSE5ld2NXbzN1a3JIV2ltVTNT?=
 =?utf-8?B?alIxQ243eGpEZDhpWHBaOEJvZW1vcjRHajZQUVlrY2plU3M3SE1HNFJkVXYz?=
 =?utf-8?B?YUczMjBjZ0xyRk5oZzB0UzdKRWZ1NXU4ZVNNVzRGa3VzYmR4bk4xS0Njbmxq?=
 =?utf-8?B?ZFlqM0RBaUhkMGZqS21PVTcyT01NV0FhbCsxTlpteHJJOS8xNUNEZWh3TkxC?=
 =?utf-8?B?NWlpSDlZZUdmT2tZLzR5NFpCSUxLbkFBeVdMM0dWMkZDVzJCWk0rKzc2Z3pR?=
 =?utf-8?B?UHZjNEVUdkRWZjFFZlkya0htNTdLTHJoV0hkc093ZjB6UHpxRWt2Q2tITHBH?=
 =?utf-8?B?L2RuMWFzNlRzcnZGeUpyeVdqZFRkWlFpYjdoeXBHeFNDK1VEZlc3cGNWRk1T?=
 =?utf-8?B?QTdxb2NuQWlNYmhJQVFQck4zbTRZYzJGd0w1bnA2VWFYYWFkVUxCanJoU2M0?=
 =?utf-8?B?R2doeXZRY0tId29yaFdJSzBDeG9UR0VoWmZ4QkF5d0owOXI3VVNMbW1RSDQ0?=
 =?utf-8?B?bzk3R0MzOG96SmEzS1Z6QjlLS2pvR3Rtck1MdG9xK1p2UGdWSUdSRllPTFJm?=
 =?utf-8?B?cXlmZDZGdDNNT1I2S0dTT3J4a0JldmdLVVVCVUNiY05JRmZBTFZ2RFJhcUJw?=
 =?utf-8?Q?jHTN5aqD1iiR3fXYVJ?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 723d31f8-c37e-49fb-2059-08de64b98641
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:21:51.8158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXvQrc7Z0VqnWfRl+nNeGI0pIcPbRGYYOy+lmFrln3HEWas4gDSnhF05NC9cbGEyyUyrqWw8UV2E5RXIiSXr0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3296
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,paul-moore.com,namei.org,hallyn.com,linux-foundation.org,fromorbit.com,bytedance.com,linux.dev,oracle.com,google.com,suse.com,gmail.com,garyguo.net,protonmail.com,umich.edu,android.com,vger.kernel.org,kvack.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76449-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D0EA3F32BC
X-Rspamd-Action: no action

On Thu Feb 5, 2026 at 10:51 AM GMT, Alice Ryhl wrote:
> Currently Binder only builds as built-in module, but in downstream
> Android branches we update the build system to make Rust Binder
> buildable as a module. The same situation applies to distros, as there
> are many distros that enable Binder for support of apps such as
> waydroid, which would benefit from the ability to build Binder as a
> module.
>
> Note that although the situation in Android may be temporary - once we
> no longer have a C implementation, it makes sense for Rust Binder to be
> built-in. But that will both take a while, and in any case, distros
> enabling Binder will benefit from it being a module even if Android goes
> back to built-in.
>
> This doesn't mark C Binder buildable as a module. That would require
> more intrusive Makefile changes as it's built from multiple objects, and
> I'm not sure there's any way to produce a file called 'binder.ko'
> containing all of those objects linked together without renaming
> 'binder.c', as right now there will be naming conflicts between the
> object built from binder.c, and the object that results from linking
> binder.o,binderfs.o,binder_alloc.o and so on together. (As an aside,
> this issue is why the Rust Binder entry-point is called
> rust_binder_main.rs instead of just rust_binder.rs)
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
> index e2e402c9d1759c81591473ad02ab7ad011bc61d0..3c1755e53195b0160d0ed244f=
078eed96e16272c 100644
> --- a/drivers/android/Kconfig
> +++ b/drivers/android/Kconfig
> @@ -15,7 +15,7 @@ config ANDROID_BINDER_IPC
>  	  between said processes.
> =20
>  config ANDROID_BINDER_IPC_RUST
> -	bool "Rust version of Android Binder IPC Driver"
> +	tristate "Rust version of Android Binder IPC Driver"
>  	depends on RUST && MMU && !ANDROID_BINDER_IPC
>  	help
>  	  This enables the Rust implementation of the Binder driver.

Hi Alice,

AFAIK Rust binder doesn't specifically handle module unloading, so global
statics (e.g. CONTEXTS doesn't get dropped).

If we're going to build Binder as module, we need to ensure that we have th=
e
mechanism in the module macro to prevent unloading of Binder.

Best,
Gary

