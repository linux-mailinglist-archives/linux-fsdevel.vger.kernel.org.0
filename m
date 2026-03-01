Return-Path: <linux-fsdevel+bounces-78860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCWYABeopGlxoAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78860-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 21:56:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FF41D191F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 21:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0ED630137A1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2723333A70A;
	Sun,  1 Mar 2026 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Egod5Ay5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022085.outbound.protection.outlook.com [52.101.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1532D0CF;
	Sun,  1 Mar 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772398026; cv=fail; b=GHpZneRMs2G3oiXyZ4aAzIVbjQkCFgUL/seYDD9A+OxoQ539etsGWbIK/3kFvW4JRYfnCK2++6dfN2d9hZizybGUeYoaHgfyePPvmkSoRgqqroyeDw6SXCJXuwq6nmgeFi/JJPR8jfeTXn8MVW6yQrvW89/hoNlNx+SD3gNtT7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772398026; c=relaxed/simple;
	bh=vgOGFLU+LyXQQtaMKEnXBbBhab+r2DXObTGrWpTmk+Q=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=n+ywEEkXgArCT5EIsZqCoTEcNptYJHSRCNSWKzF3koA7eqHhWqH35twI6t8uPcR4s1+rmX5PneXsw37cQdtBzOFbEmayhOu+QXEzabKK1XP5X90ZDEcGuGoIA2z/VHipWsV06Behsdj/7qa6pg0O4Pt2btNOSilP+pGasPQ9qhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Egod5Ay5; arc=fail smtp.client-ip=52.101.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xb0QKoxFoj4qhaEzm8s6x7vfTall2fmFpBexc/UrMxYvSioVSXPD9QheCZg0HmqoyK1mDAxvDYl7TGRiyYBkxnoF2v0mE8+xGKB/KGc1zpnd3iznLXsGn3UqFMIki07BXb/cEd/w+cOLI/6OpXuP47mZg02eRd53TBNxxoZi7GsmAb8g4YVfHyggVGfpNGngiKWHPaX9/Weki/MneAQQ+taV85Tdc1MaobEdG4cAQIsD4Uvy4SGurBr0uDwnNLSYyg2hYk72K3Ab2Lfum7Anc+vfq52KfHD9cHh2ehvByakaJpxlVb6j0Ky2niKVezcApFlUKZFYa60pIKVJFJ1ynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgOGFLU+LyXQQtaMKEnXBbBhab+r2DXObTGrWpTmk+Q=;
 b=bULryEAy3KGgN1ZuQp2I1iFfSwQ1jSYuFwTAxEUs2YFBTBQT+cTkJzzwyzbqbzUzJl9LEhuRxo94t1+AmnPk1lfrrzUuv5zRAoj0lgPSe+uo6cZ77PVl0zSTs7SDFlHlD70c25AJi2YE+uj+iEUU9K7P6NtjIT+Q/NOiQDM5HffCK4gYyozQbeTpbRK580uyIUkyol2kJcJs1OzE2LaXl/MBXk/YFsx1JkqWVXATSOLB3oMWP4YuYVelc1amO2z5v7JZF1gjsTtyP3mIn6hbU2rmfVw+q5cZD5x2ZDm6I+JJHkMEFZGaa/bJocRkMSRJ5a44uoxv/wvhILPvqeNQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgOGFLU+LyXQQtaMKEnXBbBhab+r2DXObTGrWpTmk+Q=;
 b=Egod5Ay5vQaLkXLSpUiu3oOdp/Wxtou/59nOxk0XCWtJgQzByG6zUBwf0kcP0U/c8J3rLW4/lK+d7KJO2EVXZZ+ipcJW56UmX1B1w5as20wgcc2f4yhZ03DqG6hGwIzr3aMykeEMX0yfbxMWOWWBm5I+4F8KUopyGavCsoC0HBk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOVP265MB8673.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Sun, 1 Mar
 2026 20:47:01 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9654.020; Sun, 1 Mar 2026
 20:47:01 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 20:47:00 +0000
Message-Id: <DGRQNTVD3N23.33347CYLKMKEH@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Greg
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
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
 <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid> <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set> <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net> <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
In-Reply-To: <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
X-ClientProxiedBy: LO4P265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOVP265MB8673:EE_
X-MS-Office365-Filtering-Correlation-Id: 3005ec67-92c1-46a3-de4a-08de77d3b01b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	dhUpQNVugHCBnbuyqOvvB21QE4DlvulNCmqXgeEOPwMP220IOCXGupqw0MnQxlpZeyFghTTDoKycwl5AtpOzV2G7Ua2x0MOkKdrETOsO+iAsyk9eEfRIvbu1Oyx5EXlHbRAJzqOMVrS2ZYmYawbL4nj5RobTxrhFttZTq6OaAusjEKPbb+EG4PqGtkGHTaYWuwsDGJ6VGu3iMFrBENxUnwO/zmv4qqhBInoCvvTC9e0+jPvbl3g3uTewS9mq932wYKxW2Ff7vMpDLjVHAdsD2DuPdBqjWy8ix2n2nlOLOJI9yoq1GQ0UZanu9U8Sv5ktiASllaqNqPJSIEgwXEFgJpj+o8R8FGK8/LizDzqbn3+h6BK6GihO6UUeDCsncZxw81N7aQTxAy4w54ky7BSD3WScp44HrpvOXCfJjupi3w+fPk6+6nMNgwRTq9JKO3LkNSyp9cxNJWsMGUMKA5RbT5KPgfULeOoq5VOuvtLb7v47QO4PExE6tq2YoYcMMzkhCsg7iR8slONjOQxvtx1oMNTs7J1jgjFb6qLCEO+gxzFR+CABvINm4xx/C9hkm/4zkQ495G2qA/I/lCbPzXf6FiXeAcUyOPnCMwoW+8I4ls3FUEiFOfOhrDCpwjXOc5g0kI30lv5/WykfuWBUX+EZtD/FuqtuP6PBnDth+W1lGjaPCLZDn0HDJR7OVRkY1kEg5JdflDevVk7wxblNs2Oza5A+xF9a1zEEgQISJMm+FiE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWpDL200TGpzMzhkQTlMekNxeTBTRC9FN0g5aGlaL1pjNllObzBmY1NpZ0s4?=
 =?utf-8?B?aVhvZVV2MVNmcE1PZ2I0K25kWjZMazR5a1JqSk5QekRsN05DUktyUmlnV3pq?=
 =?utf-8?B?Q0ZNenlpazN6M0pHU3VXYWlqUnFQVFRlTXc0c3JpaVZCam5EMTlwK2dpdmRp?=
 =?utf-8?B?RW9hMXcvWWlYZElpbFdBSGVhUGVKZFZkcUJ5REtYVVNzd2RMM2t5ZWdvMkMw?=
 =?utf-8?B?c0tTT3Z3TGIzeTJSdFNoM3hJdHVDUVgwd3JQcmErT21WWU1ETUZwS0tBazM5?=
 =?utf-8?B?NUZMejFaUGM4MVJHcHlkRnhzWC8wMXBTVDVpS3hYU3RYY09hWTZ0bGo1Y2tl?=
 =?utf-8?B?Q1N2OS9EeG5xNXRobmFGSkFJL3FObmtrUjR1QkRZcnJlUHM5SFlkS0pDVmpT?=
 =?utf-8?B?VldqV0J4MzF0ZDhmcnJLdDNhZ0ZwZnpsUHZTUmRuRjRxaVFndjA0ejJhZjBT?=
 =?utf-8?B?MVMwTHJ3a1lXTWwxemdLV216ZmJOUVZreTJLQ3QrZTRkbVk5NFRkUTBMV1Jz?=
 =?utf-8?B?SllNS2M1V1ZYaytRWkUza2pVQTBOUTZ4VGNHUzNGRFpXZEE3eG5YeXEvU2xJ?=
 =?utf-8?B?TU9odFJsaG80VmN3dW1Ucms1YjBYVHBjaXl3UGczaEY4MHNsUzFmVlRZZUh2?=
 =?utf-8?B?NTFnb3hIMXFDUHI1NFlvcHcxZDhoQTl1OVNTekNXVDZrS0F1RnpKSkIzRTlH?=
 =?utf-8?B?Wk13K2lXZzVxYStQY3NHVEpnY2hLc1VhVWEzMFQ1bmNEK2VuOHN6RFdjUlNy?=
 =?utf-8?B?WDk3UGd2eTdxMzU5TWl0V09BTVNQMEorK2pKcnA5R2sraCtpZ0FVTUZGcnJs?=
 =?utf-8?B?aGxrRnFmNFpndmtOMjRFd2NTL0ROUm0rQlJuYW1uZ1NKRE5idXowYXRpYytG?=
 =?utf-8?B?Q3htNmxQNHRUUkhrcWpMTUlzckJGclhJdGcxTXQrdGpmaDUrSnExUFhsQWR1?=
 =?utf-8?B?MUJnMVJGZzZURmluSiswRmpidW9RS0ZPY0cyQ1RIejJMWllmL1EwcVdGbGRT?=
 =?utf-8?B?bVJ2UU56WjJmL2Y5dEYvem1OeTRLS0pSVTk4bW9hTzBDRk5nck1KQlhuKzZt?=
 =?utf-8?B?RWZmTjh0RTlCbms1WGh6S0Z1WE43YWZBZUJ5UXc1YWlsQUpuaUVVR1VFUjVh?=
 =?utf-8?B?eWE5a0daUmsyRjlqQUlSSjRXNEMydXFURmFnb2lWWjV2MThLWFc3TG9DZVAz?=
 =?utf-8?B?aUlCLzR1OERtOFIvbVZkUlRZRFBpY2ZPdEJ4OG5sUkRWeGZuSUhOWWF3R2Jj?=
 =?utf-8?B?OFc4S2NPUDRobmpaVFlCYTh4YTNVNkVuQVduQVUyMXJiNythWllOeXlUbTdx?=
 =?utf-8?B?MVgyb21FaGVwYjRLT0tsbGt6by9zcFYxMzF6d1Qzcjg5NS9VeEp4bFpLRUxH?=
 =?utf-8?B?NzBWb3lOcTJsQUtZRFEwZlFjd0RkbU1ZMklHanJpZnB0TGJoc21EVXp3L3NS?=
 =?utf-8?B?OS9oYTRRcmVvUkcyZG9aYzBLRHZqWDBTUVFOSDNPclJHRnlQV0R4QnhOTjQ2?=
 =?utf-8?B?NVNHbktkTzRTaUN4c0tuTklIM1JjU0pEWXkzNnh2YWh1eHFDeXJzY1hzUTlE?=
 =?utf-8?B?WmNXSWFlZGdKWjVNbm8wOUFzcW1ydXY5QkVWbC83dWZhYlB3MW5nejZFZ2dB?=
 =?utf-8?B?WkcvaFBuZGhqaFg0N2NLRHdzN1ZJL3k4RzdYWW05WEhUWm5XbVlwZHBjOUNW?=
 =?utf-8?B?WXZtODFyWEpGTFErRWcwYlhFSVQ5ZkRBamJwdVdIK1R4djZ2NEd0MGFpMTRk?=
 =?utf-8?B?ZHVEMmhPLzdSd1dpdWh3MUFINVFMZVpHMGhPQXZyTVFacTNqb051VUgzM1Iv?=
 =?utf-8?B?UWZRT0xTVnpDZUU5V2NlR0xnbSsvcFI0SW1Zc01oSlVwUGtUdnRodFNvUkp0?=
 =?utf-8?B?UjhHeXVDeitRNzJtSFhSUWhZUnYzUUJ3Sm9TdkJFQ1lKdjJ1ZkVwUU82VHJV?=
 =?utf-8?B?cWd4NmVKdmtWYXZIaWpGQjJrQkwvWFZDc25TWjBVbFhCWTN6d1ZOQk5TOGxw?=
 =?utf-8?B?S2w5VW1ESmg2YTVKRnoxNUpWOC9iZklKbmlNM2M4SUt6TitVcTI2VmI1SWRE?=
 =?utf-8?B?YnJJd2owUzJVQzRpUnBBNkN5RXdOeisvaWNpWDA5OUU5a0trK3ZPNUgvOFpC?=
 =?utf-8?B?Ukw5S2ZNOEdMSEMvYTJpSXpkWjFGU2Q4YWhwYkVkOFF4VEJjVHFJRkVBRkdV?=
 =?utf-8?B?cjJLOVloek81ajFyWkcvMWgxZzZ3enYwcEErd1Z3dTlZa25BWFpIRVZxSVJJ?=
 =?utf-8?B?Mld4K2RlZXVCSjZEWDJxaDVjZ2x6T2ZtYVpacUdHcUp3K1lWaDExZU45SnpJ?=
 =?utf-8?B?RjB1SmpBVU10RTVrcEdHbGJjTE5icEpVaUU4MmpRNHcxVGJJbURRUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3005ec67-92c1-46a3-de4a-08de77d3b01b
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 20:47:01.0480
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GyJqiYRwvLPy4YUSUxPiuyGLALAaauEVb5TgKJ1XH85z2JxItTbo8WbpU8PW3N6RapiJ6y7M4vuKGOp8UijwDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOVP265MB8673
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [9.84 / 15.00];
	URIBL_BLACK(7.50)[rust-lang.github.io:url];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[garyguo.net:s=selector1];
	TAGGED_FROM(0.00)[bounces-78860-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[garyguo.net,none];
	DKIM_TRACE(0.00)[garyguo.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-fsdevel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c0a:e001:db::/64:c];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.998];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rust-lang.github.io:url]
X-Rspamd-Queue-Id: 58FF41D191F
X-Rspamd-Action: add header
X-Spam: Yes

On Sun Mar 1, 2026 at 7:59 PM GMT, Benno Lossin wrote:
> On Sun Mar 1, 2026 at 8:25 PM CET, Gary Guo wrote:
>> `#[inline]` is a hint to make it more likely for compilers to inline. Wi=
thout
>> them, you're relying on compiler heurstics only. There're cases (especia=
lly with
>> abstractions) where the function may look complex as it contains lots of
>> function calls (so compiler heurstics avoid inlining them), but they're =
all
>> zero-cost abstractions so eventually things get optimized away.
>>
>> For non-generic functions, there is additional issue where only very sma=
ll
>> functions get automatically inlined, otherwise a single copy is generate=
d at the
>> defining crate and compiler run on a dependant crate has no chance to ev=
en peek
>> what's in the function.
>>
>> If you know a function should be inlined, it's better to just mark them =
as such,
>> so there're no surprises.
>
> Should we set clippy::missing_inline_in_public_items [1] to "warn"?
>
> [1]: https://rust-lang.github.io/rust-clippy/master/index.html?search=3Dm=
issing_inline_in_public_items

That requires *all* public items to be `#[inline]` regardless the size, whi=
ch is
excessive.

Best,
Gary

>
> Cheers,
> Benno


