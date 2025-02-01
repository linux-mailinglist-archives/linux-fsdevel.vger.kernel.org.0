Return-Path: <linux-fsdevel+bounces-40537-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0685FA24A7C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 17:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A883A4A3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Feb 2025 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E4B1C5F0F;
	Sat,  1 Feb 2025 16:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RTldoeTp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hloM3lGA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6671BBBD4;
	Sat,  1 Feb 2025 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738427960; cv=fail; b=i7DK1mzFyDJymEHbyh7APra3Awmqd5eDp9pAlzFHbEUPaCJtkFkHKYpPTcisNLFriLAItdlLg233fevdaNq7/aBo+hrv8V4edGuZFUBGjAekGzaBq+esE3Rh2yO+idugyauLsCnRbBgg98tZ6VbozPq6jYssskiJ9pDiHHa+/mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738427960; c=relaxed/simple;
	bh=/0y2OJtggpEXoIvU6BA+JDs/8rRjht5rf3y2t6NwyP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GzzPzT6J51jKcbshFSQLS9opUPYvhj5QtZsQiTuEABZMDIwm4vwTaSUSmhNK7xIpVJglFNjRK2ubLqRKJ9+cHKImh51lSVps4ExMzbcmMR5T21Q7488nDCDddxHO4lcEZXugkPZ5LV1V0K5/F/ZSZM6uibrqMKN9VnWGFBfP3cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RTldoeTp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hloM3lGA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 511EB8dA032167;
	Sat, 1 Feb 2025 16:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KanpYMEvajl5ceR0EV
	CHO57xNvfMeLSaGkBP/HpKi4s=; b=RTldoeTpf6A0YFBSY59RSLKhaOHmuCxrB/
	JU9DPl8kJ+5Z/NGLmiAEwDgT4vLdWrHWGiCl3BdzV+J+7VS8+rfNd0pd+oR2TWLL
	F9ZFqgmS8UJt6xe7bpOZrIh4SBcL4jbD2Hm3nCtpnG3tQKic0BGq9CMzgs4sIGz2
	0AnRPczu1bNmfsMsCudcsT8PTbxrjfRUBzR1lVSqDLIwW6K3JmSktLV3ZinAX1As
	w0HwaFS99JII+J+rQ3XDhLp+8dLOVz/w7+VdWD+B7cTmnWRrD6IDnL9IYCA0bhnn
	e71qm9w1402K+OUr6J+HYNHW/1m+ko9I1+1L/1mAY6mAj5rxr30w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhsv05m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Feb 2025 16:38:40 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 511F1kbk021202;
	Sat, 1 Feb 2025 16:38:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44ha2d4x10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 01 Feb 2025 16:38:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JncfF6ocO3Ew1APoZt82FMYam9zcauKuMIjloeGJ7hCzjYyILJXf/m6c+Jtt87Z6hfRSGlbroSHFoSYHN5iOJcfMKepwoUEJOxdpiRTi2aML26XR0Ch/HCWK3WVpxctZZE34uFI2u884vB6gh5gqG75J7ydQkzzvWObe7EJ3HJ0b6tcHw1gl++2UigMcH+28OimWd16vLlcTC6MbnRxCaYWZ/5FC7sHzn2JGuPi0IBWBQjZuu4f+SShigNt7GxaNV3c5sbsC91TR4Oxzai5IYmnu7fUeIYd10B5Db1siHuMMrISX+BcqqzH6E7eUOy5gPFkC25fGliqtK/wcSTsCrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KanpYMEvajl5ceR0EVCHO57xNvfMeLSaGkBP/HpKi4s=;
 b=YN1jMHbl/y4MRiVsYbt+mYSZeG/RhEmhxeMN4wJW/XOc5g8166edGWthrbeHxMfpWTOrUwQCNzp8KFnD0hBF8CvlA5fSpAvKvGS1MlE7ksQ74+QogRFXY+ppcAVWD5el0UIVCF5tM1Xc1eyzj1VwGh08YwolQxZtlGhEJcIGIKIn+3bqJevFu6mFeYw4IPO52lP69qPP8qmqEPhGSN2Hz2WrR22nYGCHjp97HlBX4DYCwjFJjLuC7cmD5LEAayWDXefRlJHXWHa0lR5qf6XAKRv4FiPu2ak4CHwkYJ3hRigNfpBSmW/zj0X3l1c/vBAoUBmQ3N7xfdgj/nJVGE0ZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KanpYMEvajl5ceR0EVCHO57xNvfMeLSaGkBP/HpKi4s=;
 b=hloM3lGABdHKJyhEdTqsLGNM+fPvHkEebaLZdEv4LyiRTzI9e6NQyHGHUO6bJAUn8vkW0UxJisekm2yKCURowwJK4qbpttdH4AkX2NagvWli7FLUtco8mCa9cnq9cON4QF27aF9nO19dQxGR4MOTR8Sx/2wQvo9AqzkJnUwOPKc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB5120.namprd10.prod.outlook.com (2603:10b6:5:3a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Sat, 1 Feb
 2025 16:38:36 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.020; Sat, 1 Feb 2025
 16:38:36 +0000
Date: Sat, 1 Feb 2025 16:38:30 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v7 0/6] introduce PIDFD_SELF* sentinels
Message-ID: <abf5cbca-ec64-4eb6-acb6-f4b274f837a9@lucifer.local>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
 <20250130143754.1b8bb87bfb15175dd434529b@linux-foundation.org>
 <b396487f-b906-410d-9ff4-6956d99e2771@lucifer.local>
 <CAKbZUD3w4_4MjrME-0mgRL01eFggb7et2BLa6012tzQX78KK9w@mail.gmail.com>
 <20250130153236.198664b9a19ccfcdb24f888b@linux-foundation.org>
 <7519b85a-cd04-4ae9-a8c8-3d16fb20582e@lucifer.local>
 <20250201-cremig-desorientiert-aac3b09da8e2@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201-cremig-desorientiert-aac3b09da8e2@brauner>
X-ClientProxiedBy: LO4P123CA0345.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: f97a2f23-daf2-464a-372e-08dd42dedfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v9y1OXOQY1kN8DE0Sm2TrbQJ4WENM3cnKh8u3roInN5NO0mwB3uf+Cj7hBgq?=
 =?us-ascii?Q?LrbepK9Te3eBUA6ri6C+qEsPUmTVDj3qS6z0B0+pFpOV3TsvWQbfNlIy1+/5?=
 =?us-ascii?Q?DmGhExiEahunJ2Q/quanCf6Xu7A5EYyrtebZa8pLOSfkqufb7QpSFUTOmQYn?=
 =?us-ascii?Q?vhl37gBvY50v3x77a8HKT1IJBcNV0CUIV2viF1z/mc4uaTTnE0ZZkbSujAIw?=
 =?us-ascii?Q?JAiwLw5Ot6UNfWMrMDHiicpEfINmglNMi6ImaHdUxPM4B1eN44t0txdLLgvV?=
 =?us-ascii?Q?wkCtzH2GVFBJl6hDVJyWodBrfUDvpFe/JQMgoUpdXuwQzMrWIFrTtKgmigbk?=
 =?us-ascii?Q?iVr5LmFHOOnLWGVif1W2/bVHgY3GkUqRFwP4OAByV3LWmiuUgCQ1bc3sErMa?=
 =?us-ascii?Q?gmZqdq20CguveNMvZzTqaisKpWMGJTfrSDKI/8JwgmU04QQvPUZBNdbDSH2f?=
 =?us-ascii?Q?VeqpNPMTxJ69Fa4SWmRKNCr6OPbybCcjQYdEp1OO9JPltzk7SWikEaMAeve0?=
 =?us-ascii?Q?vY1MBhkjHQil0QbVmqxSNy7eRNnia53FrH3I4am4qNWwyw6QV1QENqQRT7vD?=
 =?us-ascii?Q?v8k+0+Sw/oklmtWVhsDNdJBmQ3lpR1JPO//vOnBLveOqE1JLk+CstX1j0whR?=
 =?us-ascii?Q?1A8+vw0V+LoHqrPo82DrCghJWvCFzX3mAl/4RtVHJmJQN1Lz0Pl6maKCl9ER?=
 =?us-ascii?Q?y7qQPv8JUAzqdgL4grhVV5Z0fzrmmBCctsz8RSHO/NnBnCuD02UxqzFaPJ0G?=
 =?us-ascii?Q?bcs18wv+s6ZTDyzKx2HjlmtZfvtZr9aw53Js67++9tHT7pNEPkavrisXMIcK?=
 =?us-ascii?Q?Amz2SVICHrSwY0TLm3qCxK3h/lfG3p937o5KPiOjJ2DmN/TBtvhGlOFodEzH?=
 =?us-ascii?Q?fpkvDxCZ7nPV8p9wkmV6wPua7uD1RWSO8UqEYSEj7wpTD8QCp4UJ4AVANSiQ?=
 =?us-ascii?Q?dd2pxF9uOR4Cg6kmjiEF7hjmxh0lYSARPeQx6yjLk+dchw5+S2r/qVyLEaYk?=
 =?us-ascii?Q?nqt9iDpLM+lPn0oSNVneQz2T2jazT9SWINr2yl81KuGy0EjPkDpn0kdGXOZo?=
 =?us-ascii?Q?ywzkmVVPqaKebeStHJbGdI7xv5SqmftnGgYYedYyNxCaE3JgkL6STNZXMyOe?=
 =?us-ascii?Q?UFUx+QXD+EyP5xDM5MiFrX+R/UON01cwcMkWKSP7PmykUQ5/nB8P12eNPOrP?=
 =?us-ascii?Q?JwF/uDnQ5+7kJfGiFJVKKWc8z1LYl+9+Pbv9NIML0EVUYkm4oK/zYtLy6e9v?=
 =?us-ascii?Q?tt3QEXYkF9mLt8uIngW7CsLrN/PL5tUW2E5xIfzNuqNhbIp7X25dufv3+m33?=
 =?us-ascii?Q?vK84CIva9cVd3Pl92ZiVeH0/ZYQe5QceNHfx/16YUU8o6Y6G+jIvE/fB/ILF?=
 =?us-ascii?Q?IOSA08y84D9hpVtRR5MxpEomb2Gv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ygugvSThsWNqodtTEdWnR6HaDjHKksj9GSrNklOc1VZ8X2zJzk5B9P0/Ij/b?=
 =?us-ascii?Q?j0uiBEfYKIuVjXVeL1bjH+Dj6zs6I0KXC6WsYvbLYItA4iW7a7hYaD1efAQL?=
 =?us-ascii?Q?yXlCC78fGL1MXE2zzvui+xtdvVcadDXN7rQfjky8Jucyjp/g87TrakdA2KSI?=
 =?us-ascii?Q?FdHR67tTgbL0dT5Gt0Ae2IvYSOWNmEbq2zB+ywkVoE6nZ7CFWHjOG39IJA1v?=
 =?us-ascii?Q?FsEGtbqzEzK+DpSFBj5Hm/8cjaSu9GkI10/hu1p4s58LwSzUEDJv5y+NygHY?=
 =?us-ascii?Q?bNstgAnk1mWTFHyB0OBOhVuCJfFqtZrYcgR2fAB3wJhchKFKDzI6Jb1tNWVy?=
 =?us-ascii?Q?H0ygxj23XFuXjgOl/oXyG5I5Rd8crxhDwlg8FTY7i5J/b0lTbCgK8Dq8Tcb7?=
 =?us-ascii?Q?9dYMK3C7RpqowWy6615L7G9CWc/rb9TT3pGAxnGNOPJsGw8+cNftdyyhHUIT?=
 =?us-ascii?Q?OZHhOyD92mEFnHMwhAt1BDsbgb5V+MSdb4kXX//Kwu0sxO7M2Hq+Lc+epJQN?=
 =?us-ascii?Q?Zqa/2dy1Ml+okd1TVWscqT66APthJ0k/CS69iZngeMLcN7NxJTjo6WN4/oSo?=
 =?us-ascii?Q?WZ5Bg7jFvtUiK2f1sgWLqJqrL9RLUleukX0rXfqkQe5zy0evni+142wHCikB?=
 =?us-ascii?Q?AipMZZBHQpLgtu2DUMxD8xvDnEuCx1eCGA+hdysJ3i80vnrsfANZ28XLBGCi?=
 =?us-ascii?Q?XhVz/Sh6NxqBF5TPYBhU9Vl6hp4rBf71KQtUSvkmBiZCxqDUvmz5HkZ92Hw8?=
 =?us-ascii?Q?6zvgtrhMyjGdbb7QmZ8qoJq8FL6/Szv9Krw41HUJgD08eYKLmwcPe9PhbCs0?=
 =?us-ascii?Q?W6s3l0TNXXNimFmShvlcN8niMlDoLI2KpljJEQ8O93sSNhikb7BHaJb2ZuzW?=
 =?us-ascii?Q?/lPLXYIFIHjUV3+3bYT7pz6Q8PAXDKoiVRNAPAAUGCHAmxShfBbMro7QJBSS?=
 =?us-ascii?Q?DThxXW4RqePY0j7N1UyJT1oez+fHBHHWKvUyawkV094iQNqF/RTC+WuWoyPY?=
 =?us-ascii?Q?YLXHvcIcjTSIzP0nAUNjD6HuvDxgHQCTe6hwULnUNzDu022fgYRo5Ae/y429?=
 =?us-ascii?Q?E/Zwy4j2kxuLOP8ZQJei/KIgyKR4jDPeIRZ4JcsfxjufcZXvtgiVroG8OraS?=
 =?us-ascii?Q?UseEUlk6wWb5xyjMqVeFXMJj7kNs5DJXhTxtVofxsj3hoL/lWuLJ0D3yHpAW?=
 =?us-ascii?Q?53NL0Oqc2t7SfxVb0j/DLcHheK7bbsxoeM++Hxfb7wuAUr+JQxAJXwK+oRfv?=
 =?us-ascii?Q?37NMi59CWkbygGoaYaDzrHC6uUNGO8Vk51Pb3V0V5eC0GMuziZKcksPdDVY1?=
 =?us-ascii?Q?zfLSh0A9tMw+KqmbbMeJj9Crdhy6a0QUkrUxZsxllAJdQag6++4IUdNpshqX?=
 =?us-ascii?Q?DRYKeO7KklXsP4RvHoG41Ft3arvqFC0x81C66gjnj0jvuApscm/XXOk9A+EM?=
 =?us-ascii?Q?MqTIVH6eE4rwOMM+sHQKuYLJeTH74uum8eLdW0xoxLvzdvyKG0x8yhe/RTKV?=
 =?us-ascii?Q?IxsmWL/HxQuTimGkcmRrE+Bil9H7o4CepvZjv0xWJk12rVmL0eBxNc108gzg?=
 =?us-ascii?Q?hWn9gbSj62i+ISOBJhKa8YD+xpyMQotQYzpAy4XF+xZCsExvwQKInma3kosm?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yFhm9CRVwbPP6QCbdHIDhCKDq0i/yZjojV/vqVcFyxpbK5Sz6jwUJZHHGfuFuSWbr6O5EVCERVQgGBdErOymNREhDdB1oNGf2LT7ObsF3qhpQo7ke0E/RLaWXWdxtaARTDuoUOARLWCD6Z4RdGMMrIuTJKZPPFl3sydX4kgoAbpt6ynnLJkpkDbmPhVT0Ov2AZ+e07+JcUH9AhB2R95a7V9phbgZi/0OZuOaXLbXJow4zSq8iVvSe0/wYh6E6jMe9csidZaUcHqwo8kxqjbcmHwJjTzm/PDcxI+TK+v59TgWHiPSTR6vmwsmzEzFsWx9pGWBC5v6wIxu4f6ydYOJVcG7dYwblyCHFKhzPp3HZCSo6SQuHpU9KWW7sb0qkLL7K0SE/k6vOlSrZ/t9OqHBD/f6VSX8lVK8SzdajiI+zUoW6iFjVvIUnKqsZItdBassQCisAbDl0jwh58HgUDJI8yVmOqunWxs/qmaB4e5Bxj2OBt+cB/zJ/ih6o4T5qytOR7nW78KuUcpTpWUGKVYZAKpEgI6ByiWWzLUPEy9T4Bgg7qDD3gHztMTovo9/1DpMUfWFtcTvRZ1nQsTzjZA8//OWfkHyYzo/p24E7KehFYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97a2f23-daf2-464a-372e-08dd42dedfe5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2025 16:38:36.6903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uvzs16Bt0mfa+UaHImNLEx1cedbwx0T9gQGq923A0G0yHdjY2E/5MhZ+2w93op6ByGlSWsCV65yztqNmDgaNAw6YdCIN6SUFx7/Q4PJ2v8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5120
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-01_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502010144
X-Proofpoint-GUID: Gl-zUh89W1NIr3_e9BGfAHdo69VuFkUD
X-Proofpoint-ORIG-GUID: Gl-zUh89W1NIr3_e9BGfAHdo69VuFkUD

On Sat, Feb 01, 2025 at 12:12:46PM +0100, Christian Brauner wrote:
> > Intent is for Christian to take this in his tree (if he so wishes) to be
> > clear!
>
> If you send me an updated blurb I can fold it.

Thanks, I therefore propose replacing the cover letter blurb with the below:

----8<----
If you wish to utilise a pidfd interface to refer to the current process or
thread then there is a lot of ceremony involved, looking something like:

	pid_t pid = getpid();
	int pidfd = pidfd_open(pid, PIDFD_THREAD);

	if (pidfd < 0) {
		... error handling ...
	}

	if (process_madvise(pidfd, iovec, 8, MADV_GUARD_INSTALL, 0)) {
		... cleanup pidfd ...
		... error handling ...
        }

        ...

        ... cleanup pidfd ...

This adds unnecessary overhead + system calls, complicated error handling
and in addition pidfd_open() is subject to RLIMIT_NOFILE (i.e. the limit of
per-process number of open file descriptors), so the call may fail
spuriously on this basis.

Rather than doing this we can make use of sentinels for this purpose which can
be passed as the pidfd instead. This looks like:

	if (process_madvise(PIDFD_SELF, iovec, 8, MADV_GUARD_INSTALL, 0)) {
		... error handling ...
	}

And avoids all of the aforementioned issues. This series introduces such
sentinels.

It is useful to refer to both the current thread from the userland's
perspective for which we use PIDFD_SELF, and the current process from the
userland's perspective, for which we use PIDFD_SELF_PROCESS.

There is unfortunately some confusion between the kernel and userland as to
what constitutes a process - a thread from the userland perspective is a
process in userland, and a userland process is a thread group (more
specifically the thread group leader from the kernel perspective). We
therefore alias things thusly:

* PIDFD_SELF_THREAD aliased by PIDFD_SELF - use PIDTYPE_PID.
* PIDFD_SELF_THREAD_GROUP alised by PIDFD_SELF_PROCESS - use PIDTYPE_TGID.

In all of the kernel code we refer to PIDFD_SELF_THREAD and
PIDFD_SELF_THREAD_GROUP. However we expect users to use PIDFD_SELF and
PIDFD_SELF_PROCESS.

This matters for cases where, for instance, a user unshare()'s FDs or does
thread-specific signal handling and where the user would be hugely confused
if the FDs referenced or signal processed referred to the thread group
leader rather than the individual thread.

For now we only adjust pidfd_get_task() and the pidfd_send_signal() system
call with specific handling for this, implementing this functionality for
process_madvise(), process_mrelease() (albeit, using it here wouldn't
really make sense) and pidfd_send_signal().

We defer making further changes, as this would require a significant rework
of the pidfd mechanism.

The motivating case here is to support PIDFD_SELF in process_madvise(), so
this suffices for immediate uses. Moving forward, this can be further
expanded to other uses.

