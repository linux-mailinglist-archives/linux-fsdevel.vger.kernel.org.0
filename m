Return-Path: <linux-fsdevel+bounces-32458-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EF9A5E40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 10:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF11DB235F6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 08:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451FC1E1C07;
	Mon, 21 Oct 2024 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L4gruhwA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F5LpgXK/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2CE1E0E11;
	Mon, 21 Oct 2024 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729498303; cv=fail; b=XeL06FHVZOZ5KTt87pmubYHMbxhL0mOcgX9PM4YTEWokO2LnE7LLpr0MfWQcX/tVZeEUvMoYMD1Q2dMNMkFCyYEt7XoQczejAz5qNTOlYiWJ4o/4Mo1opcqCZFK1vREA+RfFD3yHIwcdsyBFxIc7NgZ4rPld5LoYXpxr7IsIbWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729498303; c=relaxed/simple;
	bh=ZS4l0SJ9MyMpRPhlsjY+bn0sYS/XPUVlpC4lO054dtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWm2EAV/KE1f4gkQTtAN+Ck+4/vkPYdQ/thidoLGy7w9ldjJhYXZq9umkN9KLygCAJg5WpWKHvUzCmIICAZRH4T2O+RGQaYQW23ZH98US6kBm9nBx3FOrCXwPK2PxTf3z6EKFYI2ZpFXAaKGaLnDkBaU6SZxb7s7U4MRb9zEEXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L4gruhwA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F5LpgXK/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L1uD1p028245;
	Mon, 21 Oct 2024 08:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3YOD6Hco4oG6q3I9xe
	PtoTmTX0QyPe9STLDsA78wbEE=; b=L4gruhwA1PWP8n2p3vVvkat4a1mzrG6Xfl
	XR5idAhcWQgDM2TGT7T/m2xPnOpHe+mygxFRNLBJDwSgS2Qb8asxmka/DlWBBHOS
	zwhcQbfXPdPKROpgt3JFv/z9ckYAG3Jgpn6eady6/4nHDwOnxiWlxMVicJyNyraX
	uRfWb/DzKwn1dth5IZOWTZvewygUhvD+M3abWkiacZXyt11vXM7coSSbBBThky3A
	5nICZSirceNdPELf7HF5jQuKPNVcgJRPqXYLAMzujje8kgC6ksKMZbJ0I9bwx6HH
	3NKFE37xhBEN1PpJk2reCxTnf2LBhAe7iqVlEagKEQ6UVPnaO32w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqsu53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 08:11:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49L6SPE7007611;
	Mon, 21 Oct 2024 08:11:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c37618d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 08:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CHXRQE2G1mC0a+Ehxdst3flGXeNn5PPhS8h1s+yfgWwB8XstL50aKLXMyOHAfLO+ps0dwSXqj/0RiEM+GkEvVcxfZXTu56qf03ekcf5Y4ZtxfP6+J/UaXHwolWqKI7IzMMDZy8lqCCtQdcLKyqU3ZKwz9qeqpsIpxfZalgzhu55Tk1jrZ9qhmOIyDyzhUn6ImvZ8LRvQMIuT/v5kjZ9oICdySnSa+KcRtWEKGdlY9UTiVfgg42qo0pk0n0EwrXzsNyU+GQN/TOxv5k3BCN6yQb9a9EPxLGO9cqTlTv66frWoc8RHkecTcu6UrdQP9wy+qxTrMpb6i0tOUIQ33qlVfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YOD6Hco4oG6q3I9xePtoTmTX0QyPe9STLDsA78wbEE=;
 b=t52Dx+5zFrucnDjLxunI7iDcIizmXxvi5tVZCx/H2Zv/GaFlQF4fPb4V0qz2ebb+VaFUhLTWG0Id5ntDMdWchXe/2v0CcXmAFfnizAl3VnvyElxvrI67O3qJCAbWQi0F56T02wWpdlQXTfWDUHH7iaCTU6FGWpKHMkmqjTUGA7Q3JhdchQxFibXyggTqKRwqkn6qFLC3peufIlyh9ZEkHLGrLQZnIkBk6xj1uuI/dVTOvZOvdBSttVvOOvj8j4SySkoOSRm//vSb3cwf4iCCQ2rQ8HJoOdUM77gmMT5fuw7CQTcnW1WpE+4Gr276xwWecB1tijkbbEVIPxUd0ha4Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YOD6Hco4oG6q3I9xePtoTmTX0QyPe9STLDsA78wbEE=;
 b=F5LpgXK/+kXlIn+uJm9GanrfNPVNiBlYOQmlqNWXeK+NxgOqBUJF2t6Rhr0SuXPmgjYAfRAot5q5WlcygHNC9wXw3cOI+0f7B0sOHyuuO59St7GnpACzToiR6EzzRKvo37vR64Jv4343BF8/b05vopO+Lh+gylUB0GMrBXFFva4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4625.namprd10.prod.outlook.com (2603:10b6:303:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 08:11:23 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 08:11:23 +0000
Date: Mon, 21 Oct 2024 09:11:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 2/4] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <3a12d0b1-a3c4-453e-a09a-c95f3e545abe@lucifer.local>
References: <cover.1729198898.git.lorenzo.stoakes@oracle.com>
 <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bf7f2d8efc768007b5de8122275405afc9942d4.1729198898.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::9) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7182bfb6-676b-4050-9e22-08dcf1a7f396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YohSGAsleyoFmfAu+4jRBoEkwCvB/gxf3NuFlCUWIxWouhbfwwNt8HO8FDAX?=
 =?us-ascii?Q?CVu3eC9BqdTTEji3NODX3xHVd7Xzx1VAWcEAtlvbTI4lLy352rLrAuwfbHh1?=
 =?us-ascii?Q?1u1XhhTtic5yrTr9fn9g4TOAft2aRYjEJdWFh9WT4+fy038IuNRDkO6GfG7h?=
 =?us-ascii?Q?p/uPV0/E9sLVhusAI/ZaNhaB2hYzFoDX/1swAGLcukKsuDJUG9AzO3yzgBor?=
 =?us-ascii?Q?3pI2zDYklylrloqlsc0t0VI4wrNju8tGKJ9nBIk7Ai2NsSrGmPl5+ny/WY1b?=
 =?us-ascii?Q?2baVOHOcIJ5FLrnAcNHHyg15pAj1qpfxA9Tjksk5pr/2MigEObgviXdp/qrG?=
 =?us-ascii?Q?XPjJO09rj1drZsm9QHsLLFNb+QyT9596JFihLflAiPhx47418BFWXmrNE0KK?=
 =?us-ascii?Q?c7r4FLK4QX4OgahswWvV02EBgpYgMrj/OOFP8stLbBimT4TnWo9xxCzZl/ZO?=
 =?us-ascii?Q?PlbuD2HYz8LkPiMd9cw/EMfR1tADUPyjvAUx1/kS0nI58i37GaXeqmhV+7E8?=
 =?us-ascii?Q?Slr/6nerFaNtf6kt9c6I54otq4+qS43Bts70UhNhzdWOsMzuEyZpQ8Lh6YUf?=
 =?us-ascii?Q?Dj4b6eMng4LvRwVBH26N+qVq3mUUGQrTFPcaSDw39+caoXgHAwFjQ9sRc9P+?=
 =?us-ascii?Q?P3+2wdWh9hXOZBW+edSptKcqHs5UFaznJb9kjxavifiasETlDxnSo5FyAG5D?=
 =?us-ascii?Q?cZRQ9+CjcJ4r/ZLIx34qQpSC/NM9/CxxTJ6SdHV7Pe9Ds35hcy8eWQKIe0mF?=
 =?us-ascii?Q?mW/l0F0CEcZcNU1Ntf89wWjqiLye504iLNYTFMpElOHe9b6tXyLAXsUSB698?=
 =?us-ascii?Q?GPO+aIHKWTJiNWY6JLgABkFuH/upDVyja64J0w4yP76bWoMZ276BpQBYoIe/?=
 =?us-ascii?Q?zNEd8Dj8dkVpO3D3FMJXePXkuN9asyzYzN2ScN4b1zYOqIgbgxI2d5pEOmln?=
 =?us-ascii?Q?WrEvUMujOD1i0WUh9i7FywK6qsoIVv+OJVPcmFH8MpA8LzbvcAe1bipm+YEg?=
 =?us-ascii?Q?e9Ew64KMGQg95GbVM3bff733SNwsWjUPwmDr2H8WqJK0BmsGhb43BY1mgAVp?=
 =?us-ascii?Q?2uMeeAxDYaXtylMg56/2CaqSMNjjSF77oVxYlbZHTflYMjw91xLAvNAhZX2c?=
 =?us-ascii?Q?+VIOWu3ZLlcsW5Ba+O3EHVxTDTIErKyz6tLgeivcKCRa8LJn+21ZLoM5jxS7?=
 =?us-ascii?Q?4t3VQ3nJIcOv5Ms3hxkYhciXQFLGrecRchoO1lgukvduKEo4z70sUgObWlhl?=
 =?us-ascii?Q?Tlljt88+9i4mRiKyBpWXDI/A6HXO5Uax4kdmXiQgx/TVNNCAipRHt5dwAK+r?=
 =?us-ascii?Q?gOsyqQAZP6mBNnSSoWtfPIHV?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RNpmEMlp+Lp6qYi3ge80x1O3LzfQXjPzT37MB5nOIgFEuUWIhEFCN11P5CZQ?=
 =?us-ascii?Q?LrVHcTcQbbcJvPBVlYabL6WCrwvuTvDWZ5lezx52e4Ym8J9TsH4/LA4O1m0R?=
 =?us-ascii?Q?TM956DBGj9/CtI3ALQmrtCQFphJM+N11KBLGQAPvjte6Uin7mWAUuBqo5llj?=
 =?us-ascii?Q?BB5dVRULSKaKAHtehw1AL/8brzbQwh8NAtV/GPt2Y2L2TC7MF4eIK1/rol5S?=
 =?us-ascii?Q?lHH7VltxWOGDZy2MLLYbRos/YYPZbvIRVlMhWd4oLkqU7zbC4R7u+ry9a4Sq?=
 =?us-ascii?Q?amZtI00q6DO00Kdj/NpaOrPh9UtvO+wBnoiKw1SOzSHicDmPvjSaAI8Hej4M?=
 =?us-ascii?Q?y70zq4+O0aSP4WaHdz5xMyezQm4QJOOdTEaJxHapjECoGa22tmilzMnYiCxC?=
 =?us-ascii?Q?QzGg9n3OYLT1jisaJfyX6N8KQcQNcF0F7z64ixW3H6Em6DepbhXMDVJcVwvO?=
 =?us-ascii?Q?lg6+wu1CiWxKvwmOAJpbJvPLydcwtLSf1fdVVjNXd1vZvUcSD24W+4ua7Mex?=
 =?us-ascii?Q?GiNFrx3STDCzGY0Yyy3KKnMzfEdjpM+dCxvj87eoJ36A43VVoh7bELjjlFdh?=
 =?us-ascii?Q?RQYLMwZTzveBBIEUYRbxRxLf0YBuRejEkRdMi0S200l5JzpPthVNXnzZtLJ3?=
 =?us-ascii?Q?6MUQc31NbrSGZ341UOwPvMrPfWQtI7b+LBU1Pmd1XP+qwyI0/C1iHrQwwYdH?=
 =?us-ascii?Q?e7KjtwyZPoYHYtdIFx1Dnb8aFeFD+wxsyhDfXwDznvp8ytVUrH9oqAJYnEAo?=
 =?us-ascii?Q?eDIhDXeCwNCnmY0XjXA+yK/tsupKinvVZ7o87K19WmrjfRBSQuNXiK9T3196?=
 =?us-ascii?Q?1wvVDq++DL9ax3qIWJQ9RLc3x+zhhUamnGeZg2N+9Tuf8TwUgyYIFhNymAvH?=
 =?us-ascii?Q?/rUc/Qs/NP5axW3M5APnDbBnbFl4M9c12334f8kxa0mpCqz38k3uYcen40w0?=
 =?us-ascii?Q?UFRAslpFMAwQHnV7j6/FJTSFzBYeIrlavU3n8aFnMgN7pOTqdSZxRlfmK3TN?=
 =?us-ascii?Q?i3NHwI9iqRbT8V+qBpIctMT6N/yeVXwyHK/7O1dlvcDgI2uFsogqzy4K5UWF?=
 =?us-ascii?Q?yaenPJCpTc8tccAjUzmpcw0hYCsA/9/59lPhG4usnJCDBj+w61sWAqMewkoc?=
 =?us-ascii?Q?YD8bVs3b7Rum8gX29mosR6Zt8xskosn2Nu3jnlDCMGemNXlcgYAAM5tKZ0a9?=
 =?us-ascii?Q?aQZu9DVzawQoj8UMqB7tAxjFBjgb7X+sh5nUh+wgbXN1rIPZIhukFlH0jV6a?=
 =?us-ascii?Q?2LqaGV2WmCn335LClg0imYQtj/ZBHVz8KAH1N/bHjmWpQOFg7vRJEwHvjLRi?=
 =?us-ascii?Q?tAtyj1TDQ97gLz7FtI9C0bgPS5Qjay1smr5Gbtk0vVdrErw3KniVDx8T9doS?=
 =?us-ascii?Q?TS06zPh7kpCoaRtf+Xh7sYazz6Ud3d3OxDI/qFtHc8CHRpJoA9YoqM1wTgqv?=
 =?us-ascii?Q?1fKfvxdUoOFxVq3GJlf58mr6KXZBvNWZPwu49Spd+p/luWCtrNwqCttW0LQh?=
 =?us-ascii?Q?uTZRahLq2xpshy9Cnfm+eAvmsi4L51ufCNOYqRqmB7LZHq6UoXSJ0jIRENfa?=
 =?us-ascii?Q?bXIavEXll+ZWgl7YWnKRR6vUgRM/ariZbWPDQQC3Ph/aMsYIGGSR1wWr819X?=
 =?us-ascii?Q?srl7VPlWjjih9/PLsdD1Ku/rA6T1nvm+a7bES7CN1WdkRr/BWvCEaB4IRDRG?=
 =?us-ascii?Q?tIuIvQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xlNCFlL/PNTRsYKxOn+eidT/rWZWz18TNWOCF/4qDVKPF/QBB4LUATG8TyHo8DBpldif3sLmGwI3Jk+jL5qfK8apf2ulnEep24XZcNf2h2Z1V6lTw2y8sDFS9kC1I1yP8304iKygFzU/dn6LC/IC1pzZ1w2olMGODpXx9qPTsVqPMV4V8rJXRN7w0qClaIh5cZFqe271ZZna5qRNWvE2O2s+5fL8t6g10G8WRsZ5TZCelZXE3lV/Gt5nrOykS+VO14fmkAsaLP6x2IcfEGTlQrLct6xxNH9XMn8ylnSVL/h8kYmgTjJ8sPUSUbOeoI8cZnqbXDer86u9nMo2iJjhPoSnspvWBBtp4sVd4r5fxV4xxvIIst3QhOjwTYMRdhJGPpAr+zfmPfrkogX2uNckqoIrNtffQ+EiaSP6qoeVGxKzhfN286VwzNkSTbFBA7RZPos3/S6zFTCSmJgZOKFrcuj9MMcs+IgvnuPd+wlUUpV2Lu/onYVpWWvg++jC2cA3BcpVNs9tooR4OTe2DpKjB13Tp6JUStcrjKlSAhasgDPfpmaBK1A78AC/kgluZMVZEUCyZKQTshHhfeR6vGylVo0BpcgPP0HajV/Jvhn8Fxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7182bfb6-676b-4050-9e22-08dcf1a7f396
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 08:11:23.0954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQvBa+h4lqtUsrUmhlUD0PCHf5LEetya1Y/jfdmp4bJe3TD+cQajSy7I8ZLPdROGIQ9iI7zEqUMqgtYmwp/1fuft7B909QlqGaaUE3IBSqA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4625
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_04,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210057
X-Proofpoint-GUID: 6B3LwUegrez2E-susJ5-M1X8suodvrOz
X-Proofpoint-ORIG-GUID: 6B3LwUegrez2E-susJ5-M1X8suodvrOz

On Thu, Oct 17, 2024 at 10:05:50PM +0100, Lorenzo Stoakes wrote:
> It is useful to be able to utilise the pidfd mechanism to reference the
> current thread or process (from a userland point of view - thread group
> leader from the kernel's point of view).
>
> Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
>
> For convenience and to avoid confusion from userland's perspective we alias
> these:
>
> * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
>   the user will want to use, as they would find it surprising if for
>   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
>   and that failed.
>
> * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
>   have no concept of thread groups or what a thread group leader is, and
>   from userland's perspective and nomenclature this is what userland
>   considers to be a process.
>
> Due to the refactoring of the central __pidfd_get_pid() function we can
> implement this functionality centrally, providing the use of this sentinel
> in most functionality which utilises pidfd's.
>
> We need to explicitly adjust kernel_waitid_prepare() to permit this (though
> it wouldn't really make sense to use this there, we provide the ability for
> consistency).
>
> We explicitly disallow use of this in setns(), which would otherwise have
> required explicit custom handling, as it doesn't make sense to set the
> current calling thread to join the namespace of itself.
>
> As the callers of pidfd_get_pid() expect an increased reference count on
> the pid we do so in the self case, reducing churn and avoiding any breakage
> from existing logic which decrements this reference count.
>
> This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
> ...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
> pidfd_getfd() system calls.
>
> Things such as polling a pidfs and general fd operations are not supported,
> this strictly provides the sentinel for APIs which explicitly accept a
> pidfd.
>

We need a:

Suggested-by: Pedro Falcato <pedro.falcato@gmail.com>

here, will add if respin, otherwise could you add Christian?

My apologies Pedro, this was wholly an oversight and my mistake!

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

