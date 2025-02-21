Return-Path: <linux-fsdevel+bounces-42223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A95AA3F3D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7DDF3B3707
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 12:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530021127D;
	Fri, 21 Feb 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MBvwvzqy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n2OIVZNG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9837A2101A0;
	Fri, 21 Feb 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139552; cv=fail; b=pQeasizxSZEglzStjZEC5huBg4nCQgqL4XO5Fhl6iy6fheWeAhfFZBPXvEugv5n4ivLe4ahuDQn0EGjKkl3Kva/a1A5RjmYGSxe4MxicLzoQJaYsWMuHw7zd4xP3qsRWkJTV+qQ/8jKpKoIU2MRnTtHGWlFsv6d6ZMqhSAZmW1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139552; c=relaxed/simple;
	bh=1yClyU3PQi0yHR5knHGJJaFm+h819uJUqWBLaoTI18Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ndEjWuYTZmaTWMEH7TC1vSyJEGSLXI/da4L/jS9OODS4BnVKu967u2mTf05VygkSYNp80Jr7RgXifXszhB7vINnoIayVwHAKtknAg32/kEYuH2uPf1ZiUcyROZZjhbHhCbJXTF5XWFT7tf35IcU41X9uU7D14Wi3aVtPawA7GWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MBvwvzqy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n2OIVZNG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8faC5001450;
	Fri, 21 Feb 2025 12:05:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vun78FUdkDyEjVURPXOKQ87Bg45hJy5GFD/l1ztXF/k=; b=
	MBvwvzqyIY/HKt48Mf3OVBQ59EyNlc4J8+93a85apOQ+J36OStJVjo0sDxlpmLPf
	OCXZI7/qwaC9UBoGTWwkegjIgEUvashRwRryF1iA6vSeqWROA7Ra25Yey03OMGff
	SIP+rNIUHqpvPk5z2KroAnglluSizaBD4GnANpW4hDdUkR5bUV8CWSomy/fMablv
	q3+z3CMNHu8PKWBu9zN+AK1YFb2odgpkQtBugsppFdMDJ02PnacDI2FrFZQG9s1Z
	Y1w5aWeSujnzl47qozWV2LRG2ru4FFRXBbc7a+K2fuiA9wTdFFNvQJLkFPx9rKcz
	0hu9Z9BWMJrchD6dBKYMEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yp54k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 12:05:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LC2iK6025222;
	Fri, 21 Feb 2025 12:05:35 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w090g52r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 12:05:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOWT26zXEMtnSTW5NL+m8oVf2xr83Ax26V3m7VeTxR24+9JPPUeOSDFYkWyAKKr7RfA8hwU4DS03+D4MmzfHUAeos5tQRY+djuI/9K0uJEVkxezyX3edKtPXcYc4AAdIxsA19yeQv8WwuCD2ZA1Z6USsLCsZp00eVDHEhDiALryZlRD1Kld8WyygtC48BqPAb6AleWJCYKXN5AH8mX3CRAdaLCvaXf6g5m3RRLz/f+B1knM5g0hT84QyM4Gz1AGDJb7xH+aSz35urbDg4f/4yU3WYuv5pJHCwB9+z39qzyyd+9Z6CBZWvb1MefLnfIZ2Zkt4iITW/j0usyyguPHfxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vun78FUdkDyEjVURPXOKQ87Bg45hJy5GFD/l1ztXF/k=;
 b=A1LX7s+pQc2Mt3Gzfjy8jnL5zW93lotafRvbNZEKZ/53JaSKS7Yuwi+yjYF5XUDgQOGgvI5YkmBAf5B+X65Of2AHt1l3QFLVTKb9GQ9l7sGuk/zR2FgvPjcuFPE0gpznQCbYcL6LhS6EuNYplsMX6TLdYGWITlBdk8BUSl7JNZ6+vT8nlwyzwCEYigNslBrCo9hGyB8oU8NI0hkU9kBKRZV0+Q89hOpIhHD0C46o+sagiLVFk+/oW5MgZNBOLQvJXwWYAJaczLLHmoI8ez07bPR9qCbI2Hihs2wggNwFPj5yQUwFithMnpHi+3JJijjuR6/8s46yqy9x4a9X0hOCWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vun78FUdkDyEjVURPXOKQ87Bg45hJy5GFD/l1ztXF/k=;
 b=n2OIVZNG7Quc9V3gXRcKFqAQUmk2wqps7EdBlnodfmzZr0u9JLoDyAFkGnEhRF6XX7EnXtufi2hMw/zBxJ8AX4uOlWi6bb0w3J5mnh8+5tcVjf4fRHCz6IRa/XIrYjuGNb9SOR8Ryvt9pRuY2tRmlIxe/J5oubGlhgvSBTkS7R4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 12:05:32 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 12:05:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 2/2] tools/selftests: add guard region test for /proc/$pid/pagemap
Date: Fri, 21 Feb 2025 12:05:23 +0000
Message-ID: <164feb0a43ae72650e6b20c3910213f469566311.1740139449.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::23) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f0b30e-b1b7-41a7-7c84-08dd52700ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p7TQRhdp3s19CWvxe6nRA55V/N+iF1zF/XWRBT1IIy/Pf7mpYX+sVD7XJDTy?=
 =?us-ascii?Q?U/gbwhoZzmOZ89XYmKN7v0eKQ0w6dA5EqoH7FptFeI0LE2Gb1aH9hbUJwVTN?=
 =?us-ascii?Q?ua8t1m4tV08ir2Hp45W4c1stRetX08FwQt/TUe2yjs2cDhFqQCq4z3mZAtR8?=
 =?us-ascii?Q?q+AuNh3Nr/Mv/srEaXArA2D3shqSdaskI4OnySFWFz2ul7Grz4Id50uxOVh2?=
 =?us-ascii?Q?fCoZaQUexVP7E8IRESUh3TGYUpNtP7jDcuan8X0UU0WH0nBY5xvrDKiDk3F0?=
 =?us-ascii?Q?6VHI+5PsMyTYNGCErL1EO1vAJ8fQHukBVDJK1VI3XR0DrsmrU3z2K+dRrlx0?=
 =?us-ascii?Q?bwDBaNbTyKlvslL+M7kgTUAOamciYMCMCwN/U5MtgxjcHCqBe/sYW0AK9Ery?=
 =?us-ascii?Q?fGi2yfhZX9RvmRopCZblMcETq3oSGD+cmCZPjo3JurfXibX25hWnWQUESvoB?=
 =?us-ascii?Q?WW094COoEJF1qPbvpM76D1MNKhSoLDO09AkQDtJ2dqP8LebsF/3AXEu6w1mB?=
 =?us-ascii?Q?r1OftVcAiYwTRgqI+vxgkUuSMWEWpTTOAo/jtAn3ujYgYgCLqi3oL9vQxHRK?=
 =?us-ascii?Q?Qi/Ll8dAy1xq7qFJtrUFACfN7uTWh8vTILQHpR0MUvnbnhmY+Omxr2rodBGd?=
 =?us-ascii?Q?BCoJncqIoXpgka5uU5C1QZe6nvNCmgoXJoyR/Drd6gkuPpfiAZ/hKX1faXyl?=
 =?us-ascii?Q?YXighPI6cSAk5GnZSxRMLLCkRdqp2s7djRuHy9t7BIB2SiDgFCZTBiWDbLav?=
 =?us-ascii?Q?pHlwwOHJHkahaIkBhpIqNJJup0+1kf0ZlUdDuerxYy8SMLL61SsSz9l2eKaY?=
 =?us-ascii?Q?qWO8aQI79GqVV7BAJamY3Hb6I2yvTUecBCk5OBEuONfZy11sw68YEennPx3L?=
 =?us-ascii?Q?mG+SQJWM7O+BGImbaUG7z7VzzV4fyTc+JDe5nG31CC85y9LPF6VQIsdaD9KS?=
 =?us-ascii?Q?fdXWK7JLOp6LVUalMJj1QBa63sYhMKZjBa6EGd5YAlhJiEPDC7FP6a8MLetN?=
 =?us-ascii?Q?M+u2uZx46+sWXWwoMLnsl/OVX6oHPrYIiJU8w8N5Sm5j6r52xZFqUk7QUj8L?=
 =?us-ascii?Q?IZl80kxGt1Q/fmHE7xrXuRy5lVRlJnwBdmIJ2jRAQ5xhb5kJJpV9NyrgB20I?=
 =?us-ascii?Q?oMuVJBd1VLq3IocB/gaNpbVdUDGhnxk2orXics3kRtZ0jtm9UjFPjpqiMMgE?=
 =?us-ascii?Q?bwS6OjJ+e/N+oAJ/2npn08lT6Ezv7CYCvuAzK89j0HMYzxI+1untua3bfmr/?=
 =?us-ascii?Q?vTLX6/tyPEk7I5GBZ75svnQoRvHR5Fy7sfgxs0Wp7B9HjJ5MWHyOaT28xoBH?=
 =?us-ascii?Q?9gLkCz/ukhMXFuY1EzdLQlsfViwXLCOl+JQ7mDwcmbErx4txhARYExOuNRyX?=
 =?us-ascii?Q?bYyc9tfqItt+ame5kt8qqgYVjmWO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uG1K+u02CLYguao6RCuvHAEdc4v8Fcvc2jofaSLFBZnsV+NEPZtwnwV6qWAY?=
 =?us-ascii?Q?6RUA0JvlLL/it0MUzAtXU/51TJgTq/eyH/xJUFWAqZUC5DxwwyecBtXOVZvK?=
 =?us-ascii?Q?GpRJZru1y77RBkoAkLJlLU3f8xgn9BY3cUnbQyZ06zESyhwWfNem5KN7HCQC?=
 =?us-ascii?Q?oLLKsQgsiIwpBzvCz0PhcnnLcEpU7MTkx/A8au1qHjfTf9wLXDsW1GCHtgeI?=
 =?us-ascii?Q?A6IBcUyAML6pAoRVJ6LFjXOu5aX6vsRMjPveA3n/XzDqS6BgI8Qc8jPwIGG6?=
 =?us-ascii?Q?zZ2s77MVhtWp3Fz97S++uYVQ6249iRebSn1nrxk+LS33xwaA6UH2PjZq4N5B?=
 =?us-ascii?Q?+ODuTqKDoeg4fQLJp828D3wWjv8v8H2x3WVXfSC3oMRkPX0K+7Yjv36gOyys?=
 =?us-ascii?Q?gMx+5pk0xlZc74hfy+6gp/mtsXITIfYQfYVhpXcvsYBqBvpJFYyc9LEw0Z1K?=
 =?us-ascii?Q?BK8/Hv1ue0KfE8Uoph7IWosGqZjxzcrECHgfN7iE324mHi3Do4+mu0kMaBDM?=
 =?us-ascii?Q?MpemOZukB2BX2JzfNPAzMig+R1PFgC4iNAyIf02pIm8WBtijkpMCUZQ8K/yf?=
 =?us-ascii?Q?kb/VySaM0t63m6mqQrLc8Cqei7JJWTH4mnKAN/PUH67XHkS1GWtTk+BYQeXE?=
 =?us-ascii?Q?hSLE3IuW0WXJo5JZm8cDo5R1eijCbzaxyPCoYscdLtlszq0ZkQg4kCU2YCmO?=
 =?us-ascii?Q?uKa2pIxDQrCKYoUDqS3jcPs0s/hWT8j3QHVajgEHeRTy2YoMRLdeOtwepp/z?=
 =?us-ascii?Q?c6CDt8SuiaRUmou8bDDvmoG5batnBJbt/6nSlBWxcLVhmdeW7bqV12DOEZfx?=
 =?us-ascii?Q?v1Cvlp4AKGWINP8V+tTw+jBUTN0GKtkFvNvHmgcItrDEDYspAOQaEbAUtv/x?=
 =?us-ascii?Q?rR3G3mn/pTySkFMOCdzhtcavlhDWPTQYGoGrYx0upzNRXyeewzMV+ZQyjlES?=
 =?us-ascii?Q?Gsj6U9cCCtWuAdi4dfXPd5zJsRQFx6SzXHp57xD3HU4RT56TgqUB4H0xTNTD?=
 =?us-ascii?Q?B1EjpDUk12Sj3DPlt0uL0hxc+Fnk/Z+WGqhEAyZv3Di0bRF781Rh6MbAB/pa?=
 =?us-ascii?Q?FSnnZaOSIxn/BjZFcggN82NDXlVejIMDA6TSMMwiqFiMlifuT9raPPVsJ18Q?=
 =?us-ascii?Q?PWWyoorvd5v+N4hHeq5jIpr2bAt6YF6NbtZs70hqs7X2GBmIvmN8/JPALm5u?=
 =?us-ascii?Q?rtt/wrb+oI5zXnWUnafSGv1pW4YTL816zw5TZtUdUjYt5QzVhTZTh3sXUNnD?=
 =?us-ascii?Q?qHwNgfRvRT0YFe3bniTn5jPx2Nb+Lj+7PEIq9/6GZhV7ACXcnlh7T6tdo2uc?=
 =?us-ascii?Q?TYQZA0jXq9WcCiMv0riIS4bhxjII4H6yUJVYcFPPZqsT0FszXYu69q23prkr?=
 =?us-ascii?Q?n+bN5I89NX+K5OeJkJtHhzE1nlq+WEWXQZZddVu1onM3U+Z9sRBXWBX6QetU?=
 =?us-ascii?Q?qTZDLhHDXaiETtoNvHt79+rA8EA8JgW0ALte6CrwfO9pZcmVK7ewTHjP5pDH?=
 =?us-ascii?Q?QzHoYMdAYzyxi382IK0jqXkpKbvnqr/aTzvb7uZYWO4nduK4ptxQMbXkTLXv?=
 =?us-ascii?Q?aea3kx9uZYJTcdhuQR9xJ1/vSWa2F382LKJ5ppxl6j1n8jUvSZHoW5qoK7gd?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NJrUGqCSV748xRJOEXoaEYUnkAGZsv2wS8GcmsY24Us0P8A6wE6VW1aC2Z2kFawAc5yGwNJ+gPCtY9Wq7PTOi/qC28l9WmAy+zw5jkbgbGaAT/Esg05NidsWQ/x3GcY4q8n5Znubpokli/oVkcaSOIMql80zer0LmkBZ++TRidzye+qwuS8GrrgQeMOgRQNskemPM2pevSpXwdxbnA13W5D3/Zg1v+s7e9yM///5EMoo5lq1s5kCwb2r0vnojR9xfoQy8Nw7Oe6QLgK6kq9cz7CPW6lQCqdhFldImCo8eLXqxGkeAotRa1RJrFrY0LsC6ftU24c5yvIGnvNSPQWhS4s7Jc3FTHQ8NUTpp7xG7WfL7l2LVb49yK9pPxZJgu3f5V4xoZUODLzkA4NddqUc1jE+xLs/hsId5kQbLnEViZ34r88uK6C7C8bazW5nr3p7id/aijVKKshUdqVAaTBFXnGLdV/MvYZC0TXpZdQEJMPJlFR6AES/QqocWDTLwWrAngap5Apx+xL8Bxu8m0svZD58idwZtltSsAnvKh6ZQvtBB1jguVqCTnJ3pS3AB8XusCyCZ1aoK5DhOEjBJrMEguC3vi70RSUyzxlFVz9x6Lw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f0b30e-b1b7-41a7-7c84-08dd52700ac3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:05:32.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: no9NqkCfQGCH3EK17w1wdoC/TVFX3Otd5iEtQ2n2kLphs8Sl7p+3PhSg2HjYxLLDDIfr8RLfxzncKZtaKh2kOGs3SJBz7VWazTVBp/Hekj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=969 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210088
X-Proofpoint-ORIG-GUID: aM6NPh4AFMeQKNMzsel8WVfKo8Huki3O
X-Proofpoint-GUID: aM6NPh4AFMeQKNMzsel8WVfKo8Huki3O

Add a test to the guard region self tests to assert that the
/proc/$pid/pagemap information now made availabile to the user correctly
identifies and reports guard regions.

As a part of this change, update vm_util.h to add the new bit (note there
is no header file in the kernel where this is exposed, the user is expected
to provide their own mask) and utilise the helper functions there for
pagemap functionality.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 47 ++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 2 files changed, 48 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index ea9b5815e828..0c7183e8b661 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -19,6 +19,7 @@
 #include <sys/syscall.h>
 #include <sys/uio.h>
 #include <unistd.h>
+#include "vm_util.h"
 
 /*
  * Ignore the checkpatch warning, as per the C99 standard, section 7.14.1.1:
@@ -2032,4 +2033,50 @@ TEST_F(guard_regions, anon_zeropage)
 	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
 }
 
+/*
+ * Assert that /proc/$pid/pagemap correctly identifies guard region ranges.
+ */
+TEST_F(guard_regions, pagemap)
+{
+	const unsigned long page_size = self->page_size;
+	int proc_fd;
+	char *ptr;
+	int i;
+
+	proc_fd = open("/proc/self/pagemap", O_RDONLY);
+	ASSERT_NE(proc_fd, -1);
+
+	ptr = mmap_(self, variant, NULL, 10 * page_size,
+		    PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* Read from pagemap, and assert no guard regions are detected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+		unsigned long entry = pagemap_get_entry(proc_fd, ptr_p);
+		unsigned long masked = entry & PM_GUARD_REGION_MASK;
+
+		ASSERT_EQ(masked, 0);
+	}
+
+	/* Install a guard region in every other page. */
+	for (i = 0; i < 10; i += 2) {
+		char *ptr_p = &ptr[i * page_size];
+
+		ASSERT_EQ(madvise(ptr_p, page_size, MADV_GUARD_INSTALL), 0);
+	}
+
+	/* Re-read from pagemap, and assert guard regions are detected. */
+	for (i = 0; i < 10; i++) {
+		char *ptr_p = &ptr[i * page_size];
+		unsigned long entry = pagemap_get_entry(proc_fd, ptr_p);
+		unsigned long masked = entry & PM_GUARD_REGION_MASK;
+
+		ASSERT_EQ(masked, i % 2 == 0 ? PM_GUARD_REGION_MASK : 0);
+	}
+
+	ASSERT_EQ(close(proc_fd), 0);
+	ASSERT_EQ(munmap(ptr, 10 * page_size), 0);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index b60ac68a9dc8..73a11443b7f6 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -10,6 +10,7 @@
 #define PM_SOFT_DIRTY                 BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
 #define PM_UFFD_WP                    BIT_ULL(57)
+#define PM_GUARD_REGION_MASK          BIT_ULL(58)
 #define PM_FILE                       BIT_ULL(61)
 #define PM_SWAP                       BIT_ULL(62)
 #define PM_PRESENT                    BIT_ULL(63)
-- 
2.48.1


