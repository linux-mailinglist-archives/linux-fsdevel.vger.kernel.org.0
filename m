Return-Path: <linux-fsdevel+bounces-78856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGMEIuqSpGktkwUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78856-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 20:26:34 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 002321D14CC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 20:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 925A83016483
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 19:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EA33382EC;
	Sun,  1 Mar 2026 19:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="cetNTeIp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022128.outbound.protection.outlook.com [52.101.101.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C578C325726;
	Sun,  1 Mar 2026 19:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772393159; cv=fail; b=E2FT1c+uZm2dc4Ao0qOsAncNkWjDJXOiFUqJqC5wG4Fqr5UIrzqPWtJP3dxQly4alUPFa0sOZbYTnnDdok0H0d7veTgGknARHN4yVyMJow9iosSED3Oiydwi5gNWMgDN8ogkilq7VKBPw+Q1Ve0jodwK+tlzM7FWjMpXusw9WwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772393159; c=relaxed/simple;
	bh=MYgWCjTflTshHjp3F47Q3meXlLIYdjPI4BjJOtO5EN8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ofF5XYPAxfXC0DgPD/W+1W3PV1Ng4jxTKgE9TUw4V1faWupC+CP96EFk7AKz0lNNHINxQDUvlQ8vQ+Tyq7hO4RzJctIcfnGySusoOIC2GVDz9Cl1ffkQNELi+XKvr+R7MSuy8gzgzZ34aYN/5XE3wViKStytSe4nTe6g0GQwUvI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=cetNTeIp; arc=fail smtp.client-ip=52.101.101.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KKTpQVgPahrRMA/3cEaiI1fj8TeyT6YsmMqKHzUC4KdQE6SohWsOBk7u3HbRFKeJ4DYCGW51yWeBNIezl2VdDbIHjFo2521symK/+bfPYwIkCQUGX/8Z0A8ixpoWOBk4lAaJCtQBFde5vxl/cfXIO2w8NuFsgFsHkmFRs/MmMLPu15CTHLOmUsxFAJ61Rf/kMAW3/Tv8RKOUAITWJ/9qV5CitOFoStWoWEjWsR/dm0a2rOJZ9RGwAb8XSUB1rHZQjrIJKbpDta+IjpHeTNf+Sz3yyY1eZbulEjnNNWcn8XR3Bc4GPAOgQGUJtnM9Ak/UuNp33n9UuE79NvnSv8fi+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5Wf1tsE0Jr9Hc1wtRY+HQqNFSe2Jlj1Lzb7w3W6HZE=;
 b=vBi4GC6H7U7dXeT9qZMgJ23aA4+8MBR/ziwhvbi+wppuxj+qsFGTEW79vW29Qs3yrZKrZmmqO/nZW8w9L4G2yQKZDlAcKG16JrEG6+Y98cvH6GoN10J8BOVjmygP5MDJNjtOlH8dbrIA4hJUGULDO7j8h9KfWrJGSUyPK/PErt3BBFqOZDq4NTsre7glz1XxzWSDZIFlfVFF2QKzkLue2dWRPHQsGTqYXdHLpC0o5iFolzaxajUhKC6I2CotfBdzwprWOLAsj2hXmnYtqa+7W6i6b5ykzx4VedxHXVJaYuKyHmDCD6+Q+N+CpBfKogf6RzFx+5KfGMnz9paXQjqFRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5Wf1tsE0Jr9Hc1wtRY+HQqNFSe2Jlj1Lzb7w3W6HZE=;
 b=cetNTeIp0sTgjmO0pvwQiIyI7YnIpAVfQU5Wa6b1ow4TtQ/TZuGStyZ5gjd4hDmHNhMFLpgt8vyw+9WRBodXBhLuBxCXdm16O1hfK0fVKp7pBTobY6OTIVRtktpS0XYJ+AhAAKrkfckWH0lIcKvRNCp4I9CWuEG4adAxeY+tbsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8947.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:48f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Sun, 1 Mar
 2026 19:25:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.020; Sun, 1 Mar 2026
 19:25:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 19:25:53 +0000
Message-Id: <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
From: "Gary Guo" <gary@garyguo.net>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>, "Uladzislau
 Rezki" <urezki@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
 <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid> <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set>
X-ClientProxiedBy: LO4P265CA0209.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:33a::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8947:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c04f73-5cb3-4f68-b6a2-08de77c85b94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	grFu6kicpJhXUmscz1uUv/zWkFTWnN9VmHz8WtyYdE3sVbX8erHexk1tMCNx6carcqp2ENu77eKaEnrXrZSyauCroCaikmTeGghLTrq7ll5XUOT3/t407z3+yFa3zZoNjDvaia7LuhUUiRlj+Un2pwt286mIZCJL0xOs3TGQBL/hA33QZBhpPei8tgoGgfHDE3UMDKXNoN0b/rm3BjZkK2a4B8eU32Z66pObAkS7AHdXnbd+5dm5pgVK8ruefDTuCzXdtSH6+v37QRG+r7ysx05JEKSgpdvCJCxXzyYgtjBSCYvy93biIGKkwW7MrezSzC7MJICcp4SLwrBk4UsNw5U9Wvij7TPj+574DhvWPUxvl0zpVVvJ/cFpe/wJmbe6uMxFDvisz36OayAoQT2E9rDSL9IUgYc5dRkRjhuJ6NLUbin2Q6hQf3RpBfnILfZLYtrGq1KC5/B/TVthbe+e81/yYTmJPAmwy1SKc6ZrkvoHNekb9hMxJoTjY63JZaw/rog8RR3XHilnKJUEE+WUo7Gz6JR/8PRWEYfysAkAQ6ugwbROhj0wfksWzdO9dL9WSXJw/n4u+EnBfWCQL36XbLghFfB+Koyhwsx64sE1Wk9pF2nJlyJkB93gUckifyMk3+qPhNXRmCX3a7oCAzDk+GIyXZUs7690vr39ip5L9B8qvYmjMyhCu4LzfHPa7iKgfHu7MRHVE1ZWKSqqsiauj4kFCBGA3b0Yi0sM6iiFoHBKPaVUVEIawxA5l4rdoyAA9fD2OC44oWC4IEENHW4sgw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czl5a1dPTFVrYXhIelptblZXMlJxQzNuY3l6WDFyUGZtM2QwVEI3Z09xL3Bv?=
 =?utf-8?B?bmwxVDhodFFBWDNUaldCaFcvbjRxd0M5RVNVRzNPRjBRRlZxUGlFbzNBR0Er?=
 =?utf-8?B?Q1FmY3pBdktKS2VpNHJ6b2RUTGN2S2htVExpZjNkbDRVZC94Tkt2eVpwSlNm?=
 =?utf-8?B?UEZoYWoyakxQRndTeFRpbHpsS3l0KzV1Z2hNV1RHdUV5YS9Qc01VVTRvd3M2?=
 =?utf-8?B?Sm1wSCswZWpXNnNESG5FMFlGWjJ0YWJzZFZOQWZiRXRLRHRBNCsrU2ZwbFFq?=
 =?utf-8?B?b2JHejNRSjB1eWNXbng3V0ZMSXluRDRmaTlEK2doMGROQ2djZ3pmVWxnZ1FO?=
 =?utf-8?B?Uno1Nmd0Y05MMTZVdG5meE5Ec1FBQXAzZWY5TWluM010SUJLd0I5UW5hMXFP?=
 =?utf-8?B?VHVtcHFLRE5SQ0VvQS9nY2FRVGdaM1UyTXhHblNObWt2ZEZGeXV3SHV1QVl4?=
 =?utf-8?B?ZkJZWVVNQnladDEwcmRmSVRFQWtCSVdMZHc4Sm5XcldLNDV0OHhYNzVnUWJz?=
 =?utf-8?B?YW91ejVPdjJCNDFsVUpoMGFIV1FQWFhldjdadHEvTy9WS01UcHRJU1dRSXBa?=
 =?utf-8?B?ZnU0dlgwTDA0a3llNEhBUzZOdjJHTE84aGsveERhbU9KMVFPUDNkalR2d0FF?=
 =?utf-8?B?cTdjaXBjMnFmbkF0N09jZklQQ1Y1M01ndXBUY2x1dWtzVFZCR1VheGFmSTc5?=
 =?utf-8?B?U1p1OXp6TFdYWm84dEpYYytIZjkvdU5BSjBYRnZkZmRYYnpuazgrNmtTb0Nj?=
 =?utf-8?B?My9Xd1RLeHNuTkI4dGdYWi9Tc3RaZ0I2dTE2NW1TV2NKaDR1a2JsZnhwbURl?=
 =?utf-8?B?QUoxeEdnMlBKOTVmbjhPYzhMQ3pTbG1ZYUhtbFdkUVZkdVMzaFNJa0ZUUTgr?=
 =?utf-8?B?dmJYdFIyRkoyZU1DZXNxTktlamlHQ1pWYzVTY01JOHN6Tm5TY2dvbG0zSjVY?=
 =?utf-8?B?Y1VhMmQwVE00QXNMKzFWQUhBOHl6amtPYldpcTY2eGJucmZPaGZRN1BQUWk1?=
 =?utf-8?B?dFh2bE15MkFtbm44VmdxaVIzTFdnUEo1NzZwekY0eEdpSUxvWjJiTUhNY29V?=
 =?utf-8?B?aWs1U2NuZWhnYndCUG5VUjRWRzR6RDlINkV6NDNEV3cvaXZWRjlSM2ExRnRD?=
 =?utf-8?B?cElzbDJQWmxDYUd2L0JlVlR0bjlJNXdrZ3dGV3F3NUk2OElsYkM4ZjBTMjZr?=
 =?utf-8?B?ZXRHQlprRTVQR3d1WTZ1Ymt2bE5PMDVxUWJCL1h2cm9Pelpxbi9jVSsrVDhY?=
 =?utf-8?B?TERkZGhtdVZFWFk5UWFtN3Bmc1BEeHAwSFJQSmdvS1NmbzE5bXVnUDl6WkFD?=
 =?utf-8?B?YWhUNmYxYnZPRERlSFplRDFlMWFMTW5PLzhYSUFIVndOWUsxRHJvWmJMVFlN?=
 =?utf-8?B?UG1WZ25jbkQ5VW9LMUo3eSt5RzRyNnpXcUdadW1DaGV0YzJrUFN5VU9iYVVH?=
 =?utf-8?B?OEtOeDRXTlBTekM0OUFZeTlqR244a2VpWkQvRnc5WE0weVR0dE9uaCtSTWRt?=
 =?utf-8?B?eXNYd2VCL1ZqRndwSnhBRlZzb1QxeFplL2tRWGVDT2UzLzdNdGh6U2ZRVjF5?=
 =?utf-8?B?eUlkRnpNaXk1UHVjaWg2SnUzRkQ4USttNWFzRE9LTFJkQXpueFNlbGVmWXBU?=
 =?utf-8?B?ZGQwNE42S1JTaUdwUlRkM25QK2d0OHZqempNM1FBYlFUWmxxdHV4QWZzRzdC?=
 =?utf-8?B?MnI0anJ3ZE80ekFYOVhLMkRJemVKekgvUTI3SHlHbXRYMlVnRTNEYUcvQ1VE?=
 =?utf-8?B?THJDeHhuaXJOYlBNeVJrVGo3dEZxdVZTbjNUY08rNjdpcDJvTGV3MWZVL0tn?=
 =?utf-8?B?UEFncmNtamhXUXp0ZmVXTVlhUmFhYXhESW5yN1ZNOGhvTXVHa29CRXBDeTgr?=
 =?utf-8?B?NlU3b1B0L2VHblUrY1pLMWhNSFVTWkpYZVFjQlJpNVlrVTBwQ2k5dGsvMHNM?=
 =?utf-8?B?dEpna2JYTEdQVFJlNmVrWmVPRUhxWlFVS29RZEJiRm91M3czb2FlZjZyMjhC?=
 =?utf-8?B?bFl6QzMwZmFtVXNTbDhWVzZ4algveDRRYmtKSHFKWjNha3RCTmtPT2hkcDJF?=
 =?utf-8?B?RE96SnBkNy94YW45ZnlGbzZ2eEcrT1c5STJtQTZUSWFEUnAwL3VSd0c2bFRw?=
 =?utf-8?B?Qk1YbzVHbGFldWxxbGtqOWhBK010dXFRWStaenl0QTZFUHdSazJvQzZYbVVo?=
 =?utf-8?B?YkQraThDRVFUSlorMkpScWFNRHlFSExZL3FEeWN1bVUyQTl6MlNVd3ZTYWJn?=
 =?utf-8?B?Q0xnWkg0SG9MTlR1T295SGQvSGh2bXB3ZCtRREZ3My9QZmJQKzhpckEwS08v?=
 =?utf-8?B?VjdSbFNQWFJEcGZZTXJFeEZIZkNzS1ovNzBPc1R6Vk0wenVPUWhEdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c04f73-5cb3-4f68-b6a2-08de77c85b94
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 19:25:54.7481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtM9275RAmSoRjtKm50xhQnJNois6Xli1dBTe2UnwBM2huwjioOEQ1jRPzgaV0yl6RGQ4oZGkCo3hCoMG6RZhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8947
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78856-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[41];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:mid,garyguo.net:dkim,garyguo.net:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 002321D14CC
X-Rspamd-Action: no action

On Sun Mar 1, 2026 at 4:34 PM GMT, Andreas Hindborg wrote:
> "Gary Guo" <gary@garyguo.net> writes:
>
>> On Tue Feb 24, 2026 at 11:17 AM GMT, Andreas Hindborg wrote:
>>> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
>>> is a convenience wrapper around `Self::into_raw` for callers that need
>>> a `NonNull` pointer rather than a raw pointer.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/alloc/kbox.rs | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>>> index 622b3529edfcb..e6efdd572aeea 100644
>>> --- a/rust/kernel/alloc/kbox.rs
>>> +++ b/rust/kernel/alloc/kbox.rs
>>> @@ -213,6 +213,14 @@ pub fn leak<'a>(b: Self) -> &'a mut T {
>>>          // which points to an initialized instance of `T`.
>>>          unsafe { &mut *Box::into_raw(b) }
>>>      }
>>> +
>>> +    /// Consumes the `Box<T,A>` and returns a `NonNull<T>`.
>>> +    ///
>>> +    /// Like [`Self::into_raw`], but returns a `NonNull`.
>>> +    pub fn into_nonnull(b: Self) -> NonNull<T> {
>>> +        // SAFETY: `KBox::into_raw` returns a valid pointer.
>>> +        unsafe { NonNull::new_unchecked(Self::into_raw(b)) }
>>> +    }
>>
>> Hi Andreas,
>>
>> It looks like this patch and many others in the series are missing `#[in=
line]`
>> for quite a few very simple functions. Could you go through the series a=
nd mark
>> small functions as such?
>
> Sure.
>
> Could you remind me why we need this directive? Would the compiler not
> be able to decide?

`#[inline]` is a hint to make it more likely for compilers to inline. Witho=
ut
them, you're relying on compiler heurstics only. There're cases (especially=
 with
abstractions) where the function may look complex as it contains lots of
function calls (so compiler heurstics avoid inlining them), but they're all
zero-cost abstractions so eventually things get optimized away.

For non-generic functions, there is additional issue where only very small
functions get automatically inlined, otherwise a single copy is generated a=
t the
defining crate and compiler run on a dependant crate has no chance to even =
peek
what's in the function.

If you know a function should be inlined, it's better to just mark them as =
such,
so there're no surprises.

Best,
Gary

>
> I know we have an issue when we have call to C function in short
> functions, but not in the general case?
>
>
> Best regards,
> Andreas Hindborg


