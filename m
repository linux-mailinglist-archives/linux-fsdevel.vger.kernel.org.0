Return-Path: <linux-fsdevel+bounces-57561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827AEB2372E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 21:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7721B667B8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 19:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5102882CE;
	Tue, 12 Aug 2025 19:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D00U2Q+Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MM8hyw+g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6097F27781E;
	Tue, 12 Aug 2025 19:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025673; cv=fail; b=AT5uULW/olOwsFh6j3T8k3+A0HG+3wZ9cxj2mX71mLLjXn9dPHiaVR5VnjTrOG4jyWRwxW1ZbwOrXon8Wfmd6A3BT4w2ba/0aWP9kc+Y2T/DQSbGP/9mKcBFHYKBLqLn/FPwN63aWuQDjGQWpArLOJBiG0rEWQrb1hcZgx+KIoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025673; c=relaxed/simple;
	bh=uQoq+tz2B7zdfPtatxGovBn0jqhwmjM1bldC06FNRJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YlEjiFChiHr85nlztX7pvtHk0HQLsgtqGJ2GvfRkcFX3qrL8+nJbWSOqn5QLcFd+b2qm9UId9cCEYTlbs+tBNMnWjVc7QhUrFVjF/x3GXvbc3DXj22zh//mEpJkn9le3jLmch3Lb7dBU82ZWcYbzJIb+0ZI2R3BpSNtlGi4SWJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D00U2Q+Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MM8hyw+g; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CJ2a3H020745;
	Tue, 12 Aug 2025 19:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=M4Ufarry8myM4TKgab
	CN8p1VgTaBLW410dFYmTYHM/k=; b=D00U2Q+YCooqIXfN4znqux5GCjfTkNI0TK
	dG0rG9iJxPfMoESfxiOBMnSLTqwCaf3BnTbp8e/Wo7hLilCJ+UkvMp//pYQkw1Yh
	6mS5ephifDign5IyzVBiKClFbbUCj0N1085cVConZ3lpbampRBcbFR68j3HT2Oob
	abVknATkNXmAeTNGdBB/R2kWgWBaECCjM2ph4enChvtMaoqzh1lsV0pcmLN19Hn3
	ay309ByiykQ+kiHvb2sFgJKYr3TBgozy9zHGqsjryBcZMLchLPhTMWDZaJjXMAp9
	Oj8O1EyIsF7/00HBNcjZ7u31saLQPFFOSzgrrhFqHn2O/3pbcmNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf5gq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:06:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CInspO030150;
	Tue, 12 Aug 2025 19:06:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsacsxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 19:06:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+5VowJriljlYj4FB7JsH/V0KHqnz9ab4k4XQKGqoMcI66vimkZ+OI+m+HqibQvo4OvfjG7wS/DgEqJwl82bPIRcPDXjjd41m7S6KnzvSmxfYIb1TxSmjsh4x5+bMfsNAojyTzXo1oDM+mWI4u92MLq4nAj/lF2or9v7+qTu01PAwoPEPFCdKkwLJjKVAYPPDgB0EV88fSOF7CzpFa7yL1FYlajd+hvYcHIRfjkVzvXsKHddsrsm8w5OOwnY7ftrOm61xL4CQbHDzj91BocMxbDMamEH3BuKmNvOITqKVtkwvRVdUy9Ur/kBZyyADa0WGiMV98HleVLjkDjIBQvQGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4Ufarry8myM4TKgabCN8p1VgTaBLW410dFYmTYHM/k=;
 b=mBFeJTi/lSwFmCIPw2p2/23SFzRQUTzXlulwBIB2rwyX2equEEdiTLd0z9IQBh/YMCHePv5Ul0nx++2l79ete4R3YNzuDZxsDdht7lkOoZ5TILWy89I5ghIBymNBDYJT4gDUTw21mzRxVDNeLb+3emUbDEbLlOBb/H6+VLT11MWmqaA5HioOQx3TsU8CKf/R9PA1lTQ4sCfOijC/UmI50yoHzzqvI0qUgjUwL0+HImSBAbnf52j+sQ+uQAAY1jAIwk7i5ZQ9TBEEbWiH39+L5o8CPeB1sT/pGy+hlc5zExmVS0XoAeL2Y2KzIncdt3DkEJIcF/69U8p11l6SCflNjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4Ufarry8myM4TKgabCN8p1VgTaBLW410dFYmTYHM/k=;
 b=MM8hyw+g4G3inm4zYXkr1ibrneCd0iwQF5JNHiVrF6SwhkZbCEA1lF5q5IICTe2y/y80sHPFWxgaiy/P77AIT6rVcGmFAhbUDRwmD19GjCDLyZouPPpIrNM0pi9h6EIUlUlQZPMnF47wsvebSPpbo7+19WjfUQ8RMcK6cGsxPlw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA2PR10MB4681.namprd10.prod.outlook.com (2603:10b6:806:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 19:06:44 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 19:06:44 +0000
Date: Tue, 12 Aug 2025 20:06:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Hugh Dickins <hughd@google.com>, Oscar Salvador <osalvador@suse.de>,
        Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH v3 09/11] mm/memory: factor out common code from
 vm_normal_page_*()
Message-ID: <59c0c6b2-7112-4afd-8ea7-9e8bfaf86394@lucifer.local>
References: <20250811112631.759341-1-david@redhat.com>
 <20250811112631.759341-10-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811112631.759341-10-david@redhat.com>
X-ClientProxiedBy: GV3PEPF00007A90.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::60d) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA2PR10MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c919d05-3cd4-460e-360c-08ddd9d360e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/gEH2ffgQ7KVDeT0Ww9Ry5wY/38KqtLoBYvGbGREull9Kj9vUECxKYBfIe/5?=
 =?us-ascii?Q?GJ+EXDEaXkWibgdSh5QKPLG3fiqGL/m8fJksNHQK/hkea6zN5Zdxq8ihonby?=
 =?us-ascii?Q?tAIiWpR4uqMsgAyuTL0W0Cf+qZpXfzaRtqRZhR9Kiz/WfFW3NwRBZ4K2pJsO?=
 =?us-ascii?Q?j9UzP7Lq2iFo5P9qPg3tcRbH9zi+D+AlODFgQb++Mh1A8wNDXZ9Oqduc37g0?=
 =?us-ascii?Q?G8g+Idj6hBvuDgkqQih60P3EQAezW6E4DZxQFcTyJzyRwDjblYAtEIb098kH?=
 =?us-ascii?Q?Gm1J4B/lEuPkTdES6FwAZxuEV5cYlDujDeqPw2LgIb6s3rlxBQljqNJ7f+ZT?=
 =?us-ascii?Q?6yeR0a5Opa1r137FaB7hPb0a2X4yzKG2R4J3lX26HZj/suCjMphhpxSn1xCR?=
 =?us-ascii?Q?shpPDC6JeVTV0zI5oMIXLaoqlkFI4U30KWpaYpSZt8iCRvUr45orAEZ7EbuT?=
 =?us-ascii?Q?S7JgqzbDbw/mVR14hwQ2+C7ffS/6mcoeyClzHuC4gaPS69dlDpUtX1udQQrU?=
 =?us-ascii?Q?b+z8tsD7qo1yPlL+Bv5pnQp16+6utxL4XFC8pPM5+D/P1IpePoy2TLNraALi?=
 =?us-ascii?Q?PEYXPlrqZNXdaWQwyviqGMoCERbjeThK4MX6rRaCtRTZC25se6VO0yOcwpy+?=
 =?us-ascii?Q?c/T3a+q1wuADk0QZrNeiDzuEJAIgxKzXEQZti5T4RnaZ8jXLYN/NVovnP9vY?=
 =?us-ascii?Q?8yyfZCF0KInqlCD9T6IrexUQRRrf6pBJGuaUoaIDMTkr3W9MEGQxksKwhL5I?=
 =?us-ascii?Q?qmzVA2K+q1kH4DpnWeaAGVSwDlEZLVU5hKnBQlwWAWgmzPk55y8KNmfNSBRQ?=
 =?us-ascii?Q?Fcu/AemWsT4Nev0M439SgrO+ICHAuUXhKOU0zbXYZtJdwwbVGg6im1f3ts0M?=
 =?us-ascii?Q?r6qbnMX+fZoXr0G4MtwmvVEPDHba8fhIjClqgzHzCk4bTeHmowLwapR6tYlo?=
 =?us-ascii?Q?etMxDdALPoOYEL/9BTPCnRrSDmdh2sAalSXnI8JztNttOs+LETu8pUahnzyH?=
 =?us-ascii?Q?5Gxkoh6I5fN7kS9kVwnz6V6LfCM6hTRbpxfK6L9gF9ggme1dwxvHjqnMucuk?=
 =?us-ascii?Q?06BPSHdrIZktNsu6SlBEJCkDeE0U5LEDbIdr2aWLh4nvlDD8qTlB1tkoZcRp?=
 =?us-ascii?Q?y5x91FLljHAZp6WCMWGliIpsx2c3esvX6EWeRvqmfQ5mhefnW4mzPKOur7eJ?=
 =?us-ascii?Q?ZhWerLQpFYYeJNWWc2NHGun3+tHxut4973HJucxWPVsmr9zB1Z97fQ1IhqiG?=
 =?us-ascii?Q?RciEZRNc8mFjr/MYJPEcn2M4HIUqEpI5lZRrFeI/+5OA3veUFHNJJUy9/BfE?=
 =?us-ascii?Q?i7uoKVbT3g6rgO6m609xf81QLvGcnzjEhajoyiCELcLKeLFIg4f3DUZOchXu?=
 =?us-ascii?Q?hIP6IRyRXT0SgTC9kzLAZeHqJCAKWRpZL/1B8AnK+hihBFTbcLwAy66CTKS2?=
 =?us-ascii?Q?Iy/I1Zrsh6U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YzXWqCv6QBLa8860ukoxvUb6P3H6KYKm1Ha6mxaQPSpc4TTpQDOYHJ1wpduN?=
 =?us-ascii?Q?PyZlBgIWweZg+8QXwaxVNohaaLLrqJFgPCqNpGXoUY5+UWom9lUIpPHW1gxD?=
 =?us-ascii?Q?lO3BNKv/AGtgZUH/XUtPGa3ZlpAKSfqOoRBXapxc6pfeZ5pHsXo/U1TZdBZD?=
 =?us-ascii?Q?FunUFW5L2+rPx6zinDbHULQgVQ/ZDgbZNVw24WOi/kWTkpIvHLHk53QJUKy7?=
 =?us-ascii?Q?n3auPwcSzt5WhPwm+n61lJdEqO5Py/M9wXJFd0LXIegWy5ExM6PTKP/xdJeX?=
 =?us-ascii?Q?HZNTkFXeUv75P1m5K1Hwlw7rk2JCtCA5+Kv/ZxNjdeC/dMG1u5XIPB4dl0BU?=
 =?us-ascii?Q?H/y190hFZzWsg1W7hI4KNBD4p/DiLrsHbJ+0L2qeezKo4hByT1inEVwJw9kS?=
 =?us-ascii?Q?EX5H/yRQO96r+n9R2N89LPXfzJwIZmEMRDvIcgkAro/AjOK+XI1ASqEGR2uT?=
 =?us-ascii?Q?db5TIDUdxLP1D4BwHPLJ68m1JL91I/aUcNSmQvj+8DWzVzxPvJL+QVBY0rrY?=
 =?us-ascii?Q?hNwtLZyLfwA8xo5nmpwkuEGGkOOTS8gAZsdiYM6RGK7I8FGf9aQh/mTvETQx?=
 =?us-ascii?Q?2qSBnWkTazN5aMTjlgNPaKpAHx094JJDa4FNmibPNIAvy53tNqqTKVPbb5ZJ?=
 =?us-ascii?Q?U68gX4WZEp7auCR0y/eH8mX8Z4I+rnQrl5JNgPpXfjn4UpSzV24+xxM12pEN?=
 =?us-ascii?Q?1Lm64CRzE+6dfV4O68YYCME32veBDk5BGgTw/JavrX/UhhMbyucK1zsK4cMa?=
 =?us-ascii?Q?ovBp8kVYNWx9ffBupnRV7sNtpVMPzsxfwehk80A8l51vNGFUIpbpeOHpH2+R?=
 =?us-ascii?Q?CTHvyCW0+cRnfKUmvt8rN4WrBxY/yfTd9AX49hntZZGGyQ+UQ11030qlxMya?=
 =?us-ascii?Q?KUMSuywcqRm+LEI9qWSzna1Lahun2QEoZMrHqVjgyIxuzjlud/6HptODjI6H?=
 =?us-ascii?Q?H+nfjgRexd6hDHHvWqJqnJVAvRCj1RQmQl3GlmRyuDklsQycL8jMn3wWw617?=
 =?us-ascii?Q?aD+OSxOwhqw3G6akCaKmjiK2SjX6nb626UYqFJ1H3caFJkWYpVZkyYPYN6EW?=
 =?us-ascii?Q?VPCFeAR1bgUqWuwz359JL9FyXzVzzWmhH5v7Q3AJp5q3QlngxtWu1cV1fSH4?=
 =?us-ascii?Q?j3LNAkKiYgMvoZKvhv4iCfnZlqHAK3aUvouULxOrclTdEiUZC8aq3FoOlDgi?=
 =?us-ascii?Q?S9KLq4Rzu5sqSfMC51yYEDD6jKEuEC10sQdI/CoM+ZjeCt0lnsPQgL+Ytm7Z?=
 =?us-ascii?Q?3SEQrf90yArNVZsqUO5zyt0P3XnHPvGgcRxusb/1lTbfhdHmKnIegY9tm+Tx?=
 =?us-ascii?Q?+HxhX5Jm9MS0l/tSn6mU2pFhsKaJwjkbKIdowKud8DVCLjWIjVkK++puqAQi?=
 =?us-ascii?Q?ByXJZlavdipoBKVdg6uHm4W0L963jh/cWe1+waWsKpZS60gETdCWYYRs9Zdg?=
 =?us-ascii?Q?50R9K7CKnWiAO72vqTYrSsfPYYBFFJxtOQySuQX5Az+EbuSPti67v6d1QH6G?=
 =?us-ascii?Q?vkfAsaHxK3TBWWoc5MEOvH26QJCvGCkA3ydZnq4FUeKNk1tRIlSZOa0Ews5G?=
 =?us-ascii?Q?QsoxdGTaK6HQJfpJO/Ya/rPWAho0ZCO5h8z5yoCExzC9B7q6WRYZcEW9/qyj?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	63sPOl5EBe5qbMZPEyJrdojSP3AmJj31qnkrF5YsAMi//gmcOXal1nx1TeCcosQFpMvnKLjw2FqsfVyFlZPxUUu3DP+f0B19Jg5xuiiDK1Zl0FBqxPBwtClo18RpP24niX7aBZcLMJl/NQVhwzBKhB4pDXlJUGyoGHfltZFApIn/wrado0B3unekJg4d1YbujYwAhJOZZ4U0lFvaPLq4dUpsNJFgEykPxZY9k2hh/yGQTvB2WGeiGLF5rMg61/gbTJIigZyV6vgsF9NzxWDlpakBAUtLPuunHmrdEd7UlUWWrCUm3BcBGYnVCEAjh9tEaaT3/iVip7Ri/KHPadti6B+J4yvNh3K1T9KOzWdDgz92bA4iZCkRef41Q96HFt1nVzVui1pwpsidbLVbN3TvzALO7GLxijw1hraj/bfHJPMXN8HeO/xVM3/30aD8JTOXdH5SnvC35IhnpTL+LRQjJlkgzxdSPeSQeRHM55vDzMdFiFvFvwXVhbVK6Ox3fqUbUnYK+TdQaTTFzUJdnLv7eSujzvESeWFORZzRGHFpWOjm5fNy0PcOYSCCPQtg6Te4vEyetFmlkzDBhpKcDoz3UxTwSKZE0haJXkRVzDQwAIg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c919d05-3cd4-460e-360c-08ddd9d360e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 19:06:44.5598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkKOAQkjSWRxYT3qvmvmxIv9rZ4sbZiDENakQowW7Wj1kkDjOszqXDpMDcgp0Am4OZrOiVjLiyO+Uu8INCMyXIm5HQ8owZCPdFDW2L/iEKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120183
X-Proofpoint-GUID: jPp0BwB2hQxTjukL4RWt9koOnapmYEpi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE4NCBTYWx0ZWRfX7pA3YifGHnPI
 cHPFcj5ZQPAb2Z6fnKJdSEdI27Q9fOAhIyJ4fplJYBIqdPGsWeNw66JCzf4rx5qCHdSjNgl41kd
 3xYYNx5sDyBLRqp3WgZlBfvLQni8D3GRllY1SpWKxBPK0X1PDgWj8wVlU6uv3l9lZwCCk+umYYc
 cV9GhpLldVo+G4CdOjruFAYbThhcf1HEK7qvGApjdPH4tJZaqL/Oe9ibp0lRXUvRBfXc5fu1FDk
 IKp+oMNJZK46p/bqqi1dOf3YQTc26Tl3/CZOCD5M1JMWgleWyjaR7UEJ0qmvgFkAVDK4fvlWRVa
 Dj81C0pTJgD7z24XCfnZB0lPKuY39G0EHIekbLPo7gg7fSGquNCSFlUA5phn7mjeb9PM87v1rl+
 /5y3T85pDk5DXeEQ2nvAlqfGigSNaj9h4C0vVbXGFhHsEmsKYAY8w7Cap6KaOTm2drlBD8Pb
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689b90c8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=so3LeFcWHr71qdPntTEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: jPp0BwB2hQxTjukL4RWt9koOnapmYEpi

On Mon, Aug 11, 2025 at 01:26:29PM +0200, David Hildenbrand wrote:
> Let's reduce the code duplication and factor out the non-pte/pmd related
> magic into __vm_normal_page().
>
> To keep it simpler, check the pfn against both zero folios, which
> shouldn't really make a difference.
>
> It's a good question if we can even hit the !CONFIG_ARCH_HAS_PTE_SPECIAL
> scenario in the PMD case in practice: but doesn't really matter, as
> it's now all unified in vm_normal_page_pfn().
>
> Add kerneldoc for all involved functions.
>
> Note that, as a side product, we now:
> * Support the find_special_page special thingy also for PMD
> * Don't check for is_huge_zero_pfn() anymore if we have
>   CONFIG_ARCH_HAS_PTE_SPECIAL and the PMD is not special. The
>   VM_WARN_ON_ONCE would catch any abuse
>
> No functional change intended.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Fantastic cleanup, thanks for refactoring with levels, this looks great!

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/memory.c | 186 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 109 insertions(+), 77 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index dc0107354d37b..78af3f243cee7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -614,8 +614,14 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>  #define print_bad_pte(vma, addr, pte, page) \
>  	print_bad_page_map(vma, addr, pte_val(pte), page, PGTABLE_LEVEL_PTE)
>
> -/*
> - * vm_normal_page -- This function gets the "struct page" associated with a pte.
> +/**
> + * __vm_normal_page() - Get the "struct page" associated with a page table entry.
> + * @vma: The VMA mapping the page table entry.
> + * @addr: The address where the page table entry is mapped.
> + * @pfn: The PFN stored in the page table entry.
> + * @special: Whether the page table entry is marked "special".
> + * @level: The page table level for error reporting purposes only.
> + * @entry: The page table entry value for error reporting purposes only.
>   *
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
> @@ -628,10 +634,10 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>   * Selected page table walkers (such as GUP) can still identify mappings of the
>   * shared zero folios and work with the underlying "struct page".
>   *
> - * There are 2 broad cases. Firstly, an architecture may define a pte_special()
> - * pte bit, in which case this function is trivial. Secondly, an architecture
> - * may not have a spare pte bit, which requires a more complicated scheme,
> - * described below.
> + * There are 2 broad cases. Firstly, an architecture may define a "special"
> + * page table entry bit, such as pte_special(), in which case this function is
> + * trivial. Secondly, an architecture may not have a spare page table
> + * entry bit, which requires a more complicated scheme, described below.

OK cool, nice to have this here in one place!

>   *
>   * A raw VM_PFNMAP mapping (ie. one that is not COWed) is always considered a
>   * special mapping (even if there are underlying and valid "struct pages").
> @@ -664,63 +670,94 @@ static void print_bad_page_map(struct vm_area_struct *vma,
>   * don't have to follow the strict linearity rule of PFNMAP mappings in
>   * order to support COWable mappings.
>   *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
>   */
> -struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> -			    pte_t pte)
> +static inline struct page *__vm_normal_page(struct vm_area_struct *vma,
> +		unsigned long addr, unsigned long pfn, bool special,
> +		unsigned long long entry, enum pgtable_level level)
>  {
> -	unsigned long pfn = pte_pfn(pte);
> -
>  	if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL)) {
> -		if (likely(!pte_special(pte)))
> -			goto check_pfn;
> -		if (vma->vm_ops && vma->vm_ops->find_special_page)
> -			return vma->vm_ops->find_special_page(vma, addr);
> -		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
> -			return NULL;
> -		if (is_zero_pfn(pfn))
> -			return NULL;
> -
> -		print_bad_pte(vma, addr, pte, NULL);
> -		return NULL;
> -	}
> -
> -	/* !CONFIG_ARCH_HAS_PTE_SPECIAL case follows: */
> -
> -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> -		if (vma->vm_flags & VM_MIXEDMAP) {
> -			if (!pfn_valid(pfn))
> +		if (unlikely(special)) {
> +			if (vma->vm_ops && vma->vm_ops->find_special_page)
> +				return vma->vm_ops->find_special_page(vma, addr);
> +			if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
>  				return NULL;
> -			if (is_zero_pfn(pfn))
> -				return NULL;
> -			goto out;
> -		} else {
> -			unsigned long off;
> -			off = (addr - vma->vm_start) >> PAGE_SHIFT;
> -			if (pfn == vma->vm_pgoff + off)
> -				return NULL;
> -			if (!is_cow_mapping(vma->vm_flags))
> +			if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))

Yeah this works fine.

>  				return NULL;
> +
> +			print_bad_page_map(vma, addr, entry, NULL, level);

OK nice this is where the the print_bad_page_map() with level comes in handy.

> +			return NULL;
>  		}
> -	}
> +		/*
> +		 * With CONFIG_ARCH_HAS_PTE_SPECIAL, any special page table
> +		 * mappings (incl. shared zero folios) are marked accordingly.
> +		 */
> +	} else {
> +		if (unlikely(vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))) {
> +			if (vma->vm_flags & VM_MIXEDMAP) {
> +				/* If it has a "struct page", it's "normal". */
> +				if (!pfn_valid(pfn))
> +					return NULL;
> +			} else {
> +				unsigned long off = (addr - vma->vm_start) >> PAGE_SHIFT;
>
> -	if (is_zero_pfn(pfn))
> -		return NULL;
> +				/* Only CoW'ed anon folios are "normal". */
> +				if (pfn == vma->vm_pgoff + off)
> +					return NULL;
> +				if (!is_cow_mapping(vma->vm_flags))
> +					return NULL;
> +			}
> +		}
> +
> +		if (is_zero_pfn(pfn) || is_huge_zero_pfn(pfn))

Yeah this is fine too! This is all working out rather neatly! :)

> +			return NULL;
> +	}
>
> -check_pfn:
>  	if (unlikely(pfn > highest_memmap_pfn)) {
> -		print_bad_pte(vma, addr, pte, NULL);
> +		/* Corrupted page table entry. */
> +		print_bad_page_map(vma, addr, entry, NULL, level);
>  		return NULL;
>  	}
> -
>  	/*
>  	 * NOTE! We still have PageReserved() pages in the page tables.
> -	 * eg. VDSO mappings can cause them to exist.
> +	 * For example, VDSO mappings can cause them to exist.
>  	 */
> -out:
> -	VM_WARN_ON_ONCE(is_zero_pfn(pfn));
> +	VM_WARN_ON_ONCE(is_zero_pfn(pfn) || is_huge_zero_pfn(pfn));

And ACK on this as well.

>  	return pfn_to_page(pfn);
>  }
>
> +/**
> + * vm_normal_page() - Get the "struct page" associated with a PTE
> + * @vma: The VMA mapping the @pte.
> + * @addr: The address where the @pte is mapped.
> + * @pte: The PTE.
> + *
> + * Get the "struct page" associated with a PTE. See __vm_normal_page()
> + * for details on "normal" and "special" mappings.

Lovely.

> + *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */
> +struct page *vm_normal_page(struct vm_area_struct *vma, unsigned long addr,
> +			    pte_t pte)
> +{
> +	return __vm_normal_page(vma, addr, pte_pfn(pte), pte_special(pte),
> +				pte_val(pte), PGTABLE_LEVEL_PTE);

Nice and neat!

> +}
> +
> +/**
> + * vm_normal_folio() - Get the "struct folio" associated with a PTE
> + * @vma: The VMA mapping the @pte.
> + * @addr: The address where the @pte is mapped.
> + * @pte: The PTE.
> + *
> + * Get the "struct folio" associated with a PTE. See __vm_normal_page()
> + * for details on "normal" and "special" mappings.
> + *
> + * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */

Great, thanks for adding this! I especially like '*special*' :P

>  struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>  			    pte_t pte)
>  {
> @@ -732,42 +769,37 @@ struct folio *vm_normal_folio(struct vm_area_struct *vma, unsigned long addr,
>  }
>
>  #ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> +/**
> + * vm_normal_page_pmd() - Get the "struct page" associated with a PMD
> + * @vma: The VMA mapping the @pmd.
> + * @addr: The address where the @pmd is mapped.
> + * @pmd: The PMD.
> + *
> + * Get the "struct page" associated with a PTE. See __vm_normal_page()
> + * for details on "normal" and "special" mappings.
> + *
> + * Return: Returns the "struct page" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */
>  struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
>  				pmd_t pmd)
>  {
> -	unsigned long pfn = pmd_pfn(pmd);
> -
> -	if (unlikely(pmd_special(pmd)))
> -		return NULL;
> -
> -	if (unlikely(vma->vm_flags & (VM_PFNMAP|VM_MIXEDMAP))) {
> -		if (vma->vm_flags & VM_MIXEDMAP) {
> -			if (!pfn_valid(pfn))
> -				return NULL;
> -			goto out;
> -		} else {
> -			unsigned long off;
> -			off = (addr - vma->vm_start) >> PAGE_SHIFT;
> -			if (pfn == vma->vm_pgoff + off)
> -				return NULL;
> -			if (!is_cow_mapping(vma->vm_flags))
> -				return NULL;
> -		}
> -	}
> -
> -	if (is_huge_zero_pfn(pfn))
> -		return NULL;
> -	if (unlikely(pfn > highest_memmap_pfn))
> -		return NULL;
> -
> -	/*
> -	 * NOTE! We still have PageReserved() pages in the page tables.
> -	 * eg. VDSO mappings can cause them to exist.
> -	 */
> -out:
> -	return pfn_to_page(pfn);
> +	return __vm_normal_page(vma, addr, pmd_pfn(pmd), pmd_special(pmd),
> +				pmd_val(pmd), PGTABLE_LEVEL_PMD);

So much red... so much delight! :) this is great!

>  }
>
> +/**
> + * vm_normal_folio_pmd() - Get the "struct folio" associated with a PMD
> + * @vma: The VMA mapping the @pmd.
> + * @addr: The address where the @pmd is mapped.
> + * @pmd: The PMD.
> + *
> + * Get the "struct folio" associated with a PTE. See __vm_normal_page()
> + * for details on "normal" and "special" mappings.
> + *
> + * Return: Returns the "struct folio" if this is a "normal" mapping. Returns
> + *	   NULL if this is a "special" mapping.
> + */

This is great also!

>  struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
>  				  unsigned long addr, pmd_t pmd)
>  {
> --
> 2.50.1
>

