Return-Path: <linux-fsdevel+bounces-45332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64734A764EF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 13:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5B2E3A7AA4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Mar 2025 11:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886311E1C36;
	Mon, 31 Mar 2025 11:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D1pNnq8N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ozK2uyBZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0351DC9B8;
	Mon, 31 Mar 2025 11:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420452; cv=fail; b=nZb/Z8x3aEKJYpYvF65cfiJVrQ1de/KDbaxQ3zrZWFjwnHv8nRSt9j7SFukXJlET5XA3Vv2UaCpTwQVpkIMrAPPPM2LYv/a6DRVdsBUr92IxtsbZkWtRYH2XsOQYL/DYMN8LYcjrxZ1oFhKU7dxORNEU0VwOeXEvnbK/T7wZ0XI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420452; c=relaxed/simple;
	bh=QpjalamQZ8yxPZVTaJkkeiNpn1/AwjCFDhqu4g/PBSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JWqCaUxcUXy7a9nwytp6CZgvbJHutMaIW6do61oxhRpOeRj0UWd06a8Uhug/E9kGZ3RU9JdNRm4qG1TTiXxuegvMmAYhFuz+ZtAnC/37hVmmxTUkaD2u7t8KM16FG/tApvMubZpcE2/B1/l6usbBnoWK2BXqn0rFZMVqecXhQwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D1pNnq8N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ozK2uyBZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UKtNkk023510;
	Mon, 31 Mar 2025 11:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JZi0WY4KbDDGON7pXO
	h62D0M/1iBNSLE4XY87m+aNDk=; b=D1pNnq8NPpG29c0eBWYRGgYV7eZgsI0sWv
	NmGIcEy+jbt4PyvvZu/EAAxGAcRunZv7ige8uYL7XBIX45idOfqiF6TmAvIf11WK
	ZVybx37e0wMcMzGeCMTSxPkDybsvqSGvI8nIfj+Y/Et4Rf1R0auahng+zZkeYn4H
	+PUFVt3oZKBMiaLGRIb5W/LE4HS1veoojUJuVcZ/JiIdxVaKw6UM2TqNJE3uSTUy
	0fS6WcxrzTU1XYrxnSnaVLcCZJTF7sFIoJj6a2qXT20hCUH2KoRpWJtdWLcIhpIE
	U2Km/V+ngPHYIHCFWIt8QOewWOUefQE9j/z0CuvMWbwqoEpO1v8w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9axuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:27:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52V9grhw032567;
	Mon, 31 Mar 2025 11:27:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7a7swe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQt0VNoSu+kFrhI+PQVqFQaFB0S1/0mowcpmJBdKy5kCakUGmucBec9ZRcN0+VQr+fM4KsMsV+L3t/lco4TM66X1K+g5BZohCJq6Rfru913az/u/c+dA0q4WTIql6GykW+oFGp6IHG0VJC+WrlYl1X0ERP6vFu6o7Z/8UBHzPRIAKSgpYLcBi4sHueTdz/eUQlpxDro1NHmpYxlNMO9MvXnCjbPFRjH6Ep5EgdBPDpGJyPaLibuuhp8g+tyCcDH4GCbIUDNfkd9rBAzVqNGkwmKOot9++3veihw7weP2xkRPD7suTLawHzkR/zf7ZVi9UqwBA4HxcfR/zEDDhi9vZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZi0WY4KbDDGON7pXOh62D0M/1iBNSLE4XY87m+aNDk=;
 b=ieBBGOWzUv1Bhx8sbxstr3DTwepi59lbyJxNd/+14kSn5KM8MjcdxKpWNlZ4Wv4fPaU0Oel5ExM6QnJGEI0z7uYNr296+GU3v4oCEn25ay1kQiKScUK2d5M8XI5jlRdjAlQ8YqlE8LaKC+jYxDGzG77QYRf5fWzWaiqwebHHFmWjOqO8l9BCFwh2fQ55TXov4ebYWYeFzZ1ZtChHEiEJHVl4YZb9e4XoqyUcC8n7nVwzBjam+qd7Zvjtb/B/cssPkeO3MnFMXjnIqJZviCxrhEVRK0osE10ArSWcLNbDNUPD6fdZIkJQdPK0HVm6fyZQtECaX753dghnp8aoJR2NCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZi0WY4KbDDGON7pXOh62D0M/1iBNSLE4XY87m+aNDk=;
 b=ozK2uyBZxyaIhT8TN2LTWKnzWFS99R8d5Mv3HhWNqAYXvHi/FdWz08pysyHY8ixd+mGejWC1IyG7bIiCcJTXkerxeKa3J1v8lygw4DE3Y39KXJYq0cnDE8eqF1pCFrJdVm0gXjrPTjqBC1Im/C5tDkbsKmsDszTXX0YjliCfHS8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.37; Mon, 31 Mar
 2025 11:27:08 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.8583.038; Mon, 31 Mar 2025
 11:27:07 +0000
Date: Mon, 31 Mar 2025 12:27:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrei Vagin <avagin@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        criu@lists.linux.dev, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 2/3] tools headers UAPI: Sync linux/fs.h with the kernel
 sources
Message-ID: <1d9f9bab-6e0a-4b30-82b3-774bd0d9465c@lucifer.local>
References: <20250324065328.107678-1-avagin@google.com>
 <20250324065328.107678-3-avagin@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324065328.107678-3-avagin@google.com>
X-ClientProxiedBy: LO4P123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d1fbfa-f79b-4254-b704-08dd7046f88a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qrxkAs4fMTflzA4TbxHnN9TQgn6/6K44nbfUWmLgs70MHnSr6ad8GOARAkpY?=
 =?us-ascii?Q?/pL28llqLq0538WO07NtQ/361ca4RiGqv/6d+anM6f8Q8pDnxA5m15sGKgV1?=
 =?us-ascii?Q?SnNSmztYFSglsitZBBw7yFGnr0Oo39Ch7kaQSPp+LNLD1gnEDTub62T+74fK?=
 =?us-ascii?Q?iAhY+GL3XCvD3xRpG0dETvhYT8L1BVoDUJRZpdJifHM8QKtf16EhLCgmBpMA?=
 =?us-ascii?Q?r50OcePRlbdpObcSJ/k1Zeozo7zG75cEEjTODcTASmMsHVvKFI3ypE1jAhd0?=
 =?us-ascii?Q?UH+yhZyvxxLCG4MYoMdgo93iipYzvj2QX0G7IW5iiKMUC2jqR+iD8Rbu6eQh?=
 =?us-ascii?Q?0Fi/AgjSnL/9aAwtfGC+vJdRtvCGF1bu9swXjZhhHV0HBAvJwAOkW+SJtoVc?=
 =?us-ascii?Q?O9zu3YKcaf9+5LFCLWhfkjAjAqll7bIOMQq+nT2vAySfgpymgJ5doQpSvbWg?=
 =?us-ascii?Q?CkmOhn86t3XLGC8peE/4xkYc2hxoSKWkfh3F8MnaD8JfmkJxBLXo2EhLdlE5?=
 =?us-ascii?Q?9QYShPeHT7o10I88OdfjaYHtBWOtayEfMjR5JyemHnKeluAIzsBfWHxXVlNI?=
 =?us-ascii?Q?sudT9O3/IYEDwcoWAkaSMWFuxzwyMoK3aBZxBy6eaDCy2FxbNejZMui8PQZD?=
 =?us-ascii?Q?9UWYPHg5noou5iMZW7xEcfMIB3t7mwYRvZ6RSIcEIKUPFAb8cCLzXuVmUAzJ?=
 =?us-ascii?Q?kv0fSlFzvNRsYYdP/O/wqxWIKuZY/Rt0r2v8f4bZVLUUEc/ObR7+5W4Rp9cR?=
 =?us-ascii?Q?lKuaZwXpT1QOymH1B3DfY+B659/XJNFoiyO8vBGGv0OUtnn6oVpmagtK9xpw?=
 =?us-ascii?Q?7w7nRpftuYd+k/9+iiB0u9xDNAMbWY17AeOOJ7jkZfosHR9WXxEDahFG5OK+?=
 =?us-ascii?Q?g29OgStbMbmRYnkbfu6a/zgVjBcfgSVq9jOhD+ZHTCQzkhkHmxZd8J8gekfG?=
 =?us-ascii?Q?GjvlRsr6UvsayWvyvLrKs3YtyasLAqK0QfS4oyR54iScG5xH3HZjEs4YcmEv?=
 =?us-ascii?Q?DVt2xWROGFAiiI0Z5pvciNxTlrd8C5rKSQ2Mt10AcX3zb8q7VJA8ASI9YosE?=
 =?us-ascii?Q?qZKQBPS/NUx2313VVa1xTqVeNRITTv3TRGEJbiOzahKTF38GztfYs3A9Jr9H?=
 =?us-ascii?Q?NYqBFvHZqE9pom7deMYkTjuYkngB2qBAo0dVMWoCTsJ//8EOm5qq5eYgULtO?=
 =?us-ascii?Q?Gm8N9f/eE5tif+xS4yFjs7ydKxFOiWFgJ4nTBV2jMFyjAV/h/ElmXzp7P0Z+?=
 =?us-ascii?Q?1ii5r3pv6mAeBafODL+m0CAABaiAU7VfSeddAmUnALdqFK3RLIhHaqG2Ef6x?=
 =?us-ascii?Q?VGijl/mmk1ymoILDfrrPQo0fOTI9Nhhy6e2haL2uj1VV9TlBt+3OnRp3Cq9F?=
 =?us-ascii?Q?QElOHSrOteQn9+YsnmWiw1gCKdhz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gNp1ZeUpGkW3jeIafQ8l4ywphifSSM+tdA4zLcO0e/bP7JddWurNsq2qJYNm?=
 =?us-ascii?Q?ya6l9xpsfjVUbCfIqiF7LMLPdBjUukuFKafeT4Kwg3wQpgY2GRt9Ihvs8kzt?=
 =?us-ascii?Q?/Gn33ysAFXWAGq1xOMib7BEaPv0qCuhgUcUKaniPG5v0i2KZXQZcmeCvBCzd?=
 =?us-ascii?Q?gv5LDIjgHDs8Pzo+fNLCkwzFJ2V6b1vYC6rr3L3iAnicsxasQzk0XeWW1/R1?=
 =?us-ascii?Q?p05BV+UaWr804goaPed8Pb8tXGHHIIPwK+hZ8kb0Myw7e09/nXYnLctyEkue?=
 =?us-ascii?Q?UPK6+Mx0RVIRIkyA3MwAjBwDzcOZHZM0efrAiEgljzGX/D9zb65tDqGOSVP5?=
 =?us-ascii?Q?paXq2B8MHz4OsobzDWqRMMHHK3UwgxoNew1dqkG8WWmLlhMrkUriQXuVL/Y4?=
 =?us-ascii?Q?CfNgE9xL4kI2JLnzW1kf4eZAasYIH3v7iaybAXGVmBLH09dUzOe65MLcstsJ?=
 =?us-ascii?Q?SA7WEEY9VrExZWCfbt3Ops0xvMpQ4lVpsoIJK0iwB2x/YAU8jNmde3j4cNIv?=
 =?us-ascii?Q?eHCDjjJ7JO8YeLS2M4isQnQSi2i7rr+V649EfxgTu4P0asXYA//9P2RcT5fL?=
 =?us-ascii?Q?z2f/OiqWDIhgDy5c8TxTqcba+pfn/mFiFbIHqYutZY5svkCFhoumSEFsQt0r?=
 =?us-ascii?Q?JmmJgk0OdKEiSfqNIpaCWavpcLAQMWmTlEifHBSl23inKZTfikDr5t7ZO73S?=
 =?us-ascii?Q?YLWkGupJoJUSQKhf8EJlm8v6V6mHwbXuuqHODCwGQ8XWmgnerTZJ9PS2iZhT?=
 =?us-ascii?Q?NIFQNeLlQXWi2UgNkeZkbJHD4Wj5yoH6h1rz5JJjSiytxyaTEVQVDD/WZc9p?=
 =?us-ascii?Q?QToPsP1QI/2Isug3+qyId8bCznJa4WBIOf41KDBr7rvrVa+M/DMN5LFkJq74?=
 =?us-ascii?Q?FMqqFOmGQ7KqXHT8CjA8mOd6/WEDyvwjy/V3m4cFBekanyVIJg3i2WeLLglw?=
 =?us-ascii?Q?N1GuZTr3U1wkCVa+cts5e9Mv+8hDMLNcxVd5EbRTsMiK5CguaPJp97GE65xh?=
 =?us-ascii?Q?gcPQMbtDLglBUSnKw8JIk/cB3W7/qsSV67m490yzocwKy/KApzT3v9pygUxG?=
 =?us-ascii?Q?TejJV5Rr9dkGkB0Hp6pPY9ohbiDQFWbNvJ481Y+QO7YKTn145O6gzAUlWSoa?=
 =?us-ascii?Q?7T3j66MeekmPZA1Kk0u9dRK9EGw0b2akA5E27p2iWpSUbx8dSYOFLmzWK1Kx?=
 =?us-ascii?Q?dRexGcJQaCHYFEOW1oNMLEF5sNPX/IbrfMbMGRpybwR4sHkjUBuRkqijJLiE?=
 =?us-ascii?Q?LHB41ts46t1wN0QJUpIDxCYi9QxqSrimLxJUHyRCf8vO7sCclll1EkaNiwgN?=
 =?us-ascii?Q?omy25YE62O0mQs2PUQu7DURs7HOag7LXnD6W87TN1ldmsWNybSo275J8HeiN?=
 =?us-ascii?Q?BoWyJ29xwDQKnQHxXFQkVtPdCJHxs/XLLe8oA5FluMLPl7JwDau6vD23BsTh?=
 =?us-ascii?Q?WPlFtk+BuyZwzetqpsR5h32OvaxGhGNFPaaaxe+Smafb287BkjdoUTZxbQ2U?=
 =?us-ascii?Q?QGJaSJs9aU9NMRC0CDmcSSd5QY7jCPT71T+snobxOI2LfH52Pqt+7GCHBwLh?=
 =?us-ascii?Q?AzMh48XJ4aZopSJ5ow8Rjd3MLkM+QG7oBN+AtvZnBICU1gx7lN/yQKJXBHt1?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ocMZdXBtnobJhvY6vq9vjxt7e3++3I/j8XQ69m5vgIgKB2gc4TKWZkQLRzmlg2NqmqZ4Jk64LUwQoiKXQJz2Zz7AUk7lSlfrE3aToxHumPIjdlje9O+j/QFEY6HN1kFi+f28tGykmTcO6yH6jgfmazXjorwNIfXU5WUqgt+lKHeHGl0Tvg1Buh6sFks9wwLLCuKEGKsMpL6oGjkpsAZErYebqV+SWUbYm1naDDjKZQ1uWaRy3wM2dwCeSaKXYqibE3h9ElpuexcJ81KHk1xNYH/m37ZjM6Q9OnAf+dp/SS/Nu8xw0AVMX04wBMztTSJB0Kf67IwbKm9b1aDBEGXmrSmDA+gTGZTxT/m9BFp3jereVzh5mJjLLrrgPTqqcl1I/p2VPwOKr68wbxtYKBrCFXzeXhB73CgUsxClBGBmYZueXPj84yd8RroeueKpzWN3Tj+0vPaq7kC82GRBznP1RQI7a8I+Y43Fzq/wujFA05J97wgQdb6I2gjbgkbNIs9oESkkx8ed51+hHd8EL0PbqOQhkIknL7rck/d4TDhin+v7YIfuqipxsbi9+d6AV9fbpn03+oGJVJjDfM59B7qFztxJ5091XgQte+cDv5dQgJs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d1fbfa-f79b-4254-b704-08dd7046f88a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 11:27:07.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i4b5wyHxhhSMydXvSPcQGvHJnqiE39qYqGZ6SGdC7+2cClX2HbErVG2xM54Q+gOfLfY1oVKK+wMPt56DZVKJJDDwBZQe+qDeeqNoIiW2zTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503310081
X-Proofpoint-GUID: kUsjm6oNQJTTERRaKK1kVOoo2u_865Fb
X-Proofpoint-ORIG-GUID: kUsjm6oNQJTTERRaKK1kVOoo2u_865Fb

On Mon, Mar 24, 2025 at 06:53:27AM +0000, Andrei Vagin wrote:
> From: Andrei Vagin <avagin@gmail.com>
>
> Required for a new PAGEMAP_SCAN test to verify guard region reporting.
>
> Signed-off-by: Andrei Vagin <avagin@gmail.com>

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/include/uapi/linux/fs.h | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
> index 8a27bc5c7a7f..24ddf7bc4f25 100644
> --- a/tools/include/uapi/linux/fs.h
> +++ b/tools/include/uapi/linux/fs.h
> @@ -40,6 +40,15 @@
>  #define BLOCK_SIZE_BITS 10
>  #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
>
> +/* flags for integrity meta */
> +#define IO_INTEGRITY_CHK_GUARD		(1U << 0) /* enforce guard check */
> +#define IO_INTEGRITY_CHK_REFTAG		(1U << 1) /* enforce ref check */
> +#define IO_INTEGRITY_CHK_APPTAG		(1U << 2) /* enforce app check */
> +
> +#define IO_INTEGRITY_VALID_FLAGS (IO_INTEGRITY_CHK_GUARD | \
> +				  IO_INTEGRITY_CHK_REFTAG | \
> +				  IO_INTEGRITY_CHK_APPTAG)
> +
>  #define SEEK_SET	0	/* seek relative to beginning of file */
>  #define SEEK_CUR	1	/* seek relative to current file position */
>  #define SEEK_END	2	/* seek relative to end of file */
> @@ -329,9 +338,16 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO negation of O_APPEND */
>  #define RWF_NOAPPEND	((__force __kernel_rwf_t)0x00000020)
>
> +/* Atomic Write */
> +#define RWF_ATOMIC	((__force __kernel_rwf_t)0x00000040)
> +
> +/* buffered IO that drops the cache after reading or writing data */
> +#define RWF_DONTCACHE	((__force __kernel_rwf_t)0x00000080)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -			 RWF_APPEND | RWF_NOAPPEND)
> +			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
> +			 RWF_DONTCACHE)
>
>  #define PROCFS_IOCTL_MAGIC 'f'
>
> @@ -347,6 +363,7 @@ typedef int __bitwise __kernel_rwf_t;
>  #define PAGE_IS_PFNZERO		(1 << 5)
>  #define PAGE_IS_HUGE		(1 << 6)
>  #define PAGE_IS_SOFT_DIRTY	(1 << 7)
> +#define PAGE_IS_GUARD		(1 << 8)
>
>  /*
>   * struct page_region - Page region with flags
> --
> 2.49.0.395.g12beb8f557-goog
>

