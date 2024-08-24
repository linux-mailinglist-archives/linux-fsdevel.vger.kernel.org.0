Return-Path: <linux-fsdevel+bounces-27031-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F995DF51
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 19:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08627281BD9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Aug 2024 17:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAAD56B72;
	Sat, 24 Aug 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E/0/yvz4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="R7hYdVZX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCE44C6F;
	Sat, 24 Aug 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724522360; cv=fail; b=FEN1gOW2n9KNzRN7BKyNUI3ZjJ4pR46NxWXlALKUIP9N3dsvuN2p6D4SCOK9SQZof+meQLBB+JaoKzIZJUPQB4ij0Zg2x5OaOqPlt/KWQ2E3ueyuLY5BptNfW8sZhQzXunbYICaU3YBrMLEL2QNJPFrdpQA97ObdCx3TZu6HRhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724522360; c=relaxed/simple;
	bh=OPbWT2ehxKzO/Rqt7Y+GlV7Z6Eib3n2SU/c4rqhJHdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DEB6vglXLooJG5ceoL/vpLXITWv2JqHTDLyPw2Xq7O3a1TVLqf7yOsHsCniGpfNZVZykDwQJoRNQmFNsmXw84aCpXT4pUPJIZEqsQv0FzpI8KNKV6QpJ5iojFosXGNSPQqtxc6HZ1iMuGT8KliVRF5JF8J6U/nfFHr0ooA9pz4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E/0/yvz4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=R7hYdVZX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47OEtdRN015909;
	Sat, 24 Aug 2024 17:58:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=plEG41F4uC+P4cl
	ZiDAqwXyQtDY9zWXHRVtfq/pF1Fg=; b=E/0/yvz4rfbJmdtPsEl5jrBd11dFBGj
	Gc7NcKdZJVvin2LdEfTmog0wmqo+01075ynDpTETuBImbKEkhh8lhdolo/MpUI1D
	8E+sr0wP9ElMAlEkCG+9SVGF44wXlp0LTwB1RbSZZn2huzKhWE5dXi0mTshubVZh
	xO7bMaETUHPbqS8pktorJ5reBAgN1FN9KZJ2IQLFURO17Vw/n8wV0IlYQ5+9VlFR
	1mqefxpugi97xLBp8CK2sV77GvJU9txLAKH0kw6Zx3i32jdNr7m+UUS0zcasmR7G
	CqNvRprkwvQptusnuQcVT6j3agfa3vx+0WCdWSSgjWN94VPjurKvjIQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177u6gj7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 17:58:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47OHEJPd009866;
	Sat, 24 Aug 2024 17:58:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 417kra0q4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 24 Aug 2024 17:58:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItHmKTUxA40iavu8AbutuhzqhWFnP6gSz09lIdxzoeWgkG+exc7eeXsoodn63C0lHh3Is8kzTkILEPG7c+rS5dWACfqSkg0V1g3XV1WqnPrtBCbMN8O9BuxmzFMNPP0NZ2SoY3xzXpuFV//5WblbKwnddsSzlhLt58aNz56JkQp9c7S/w+gFy6rLnIBBhmRiUCb/yFiFkne8WHkkcv8Tsv3Em/HB7pE9LDYZgk6JywYD8dhDYTlUMqI1K2xfWBzsjUCxUlSkoeRA9pqx5eHIgJjov2qXU7KGvUq+7YLGWcSgyY6EuS99sczbuORcBPSy5FpRtvb0MAH8mwdNo/HWSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plEG41F4uC+P4clZiDAqwXyQtDY9zWXHRVtfq/pF1Fg=;
 b=Vn7qDSNnMJ/KVeg2Z8YCmcPP4OXxeOqRabxvZKqdszBU0RqaxsPPNPwLDP6fsfRDvIa353LRN7RddBzPDUiC8C5dvmz9aTCEQ9KGU8372s8F12nh4V/m5p3iSZNgkQoy5iIWw3hBSSWcIyspXr8m37ugGiXKmU4/ApFf62TJX/n+Ly1fQhEKAhsaZsnwkdviMqE2Mcp3dFB6V7RoaZ5YjbTaJ2CScP1tW9LD54MMtdAua1dARrmCsSSyH+KsZINBVbJBKWukhkCLW9xGK81LAZsJQMS89vzHrBxyQjKQU0qv+8SAk2Dtlgp9A6ydtJ84REX3ulnyh16scJhBX0lHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plEG41F4uC+P4clZiDAqwXyQtDY9zWXHRVtfq/pF1Fg=;
 b=R7hYdVZXYP8WAscG9Fl8RDAxLaqvLnLX5hKvnSIVJCtKa51yOGgrVPqglmCu+of8LW1yfJSf5ojaqsxDsF225LtZm8RZOlxm+bkCDJ4BHamZr8GocAwo1bEErcqWD/GODkP+BYOBRgH6A4Y8VuoGVF12/u4unmsP5h/NtoNx9jA=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7185.namprd10.prod.outlook.com (2603:10b6:610:129::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.13; Sat, 24 Aug
 2024 17:58:45 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.006; Sat, 24 Aug 2024
 17:58:45 +0000
Date: Sat, 24 Aug 2024 13:58:41 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/nfsd: fix update of inode attrs in CB_GETATTR
Message-ID: <ZsofUUJeB1wbONyi@tissot.1015granger.net>
References: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824-nfsd-fixes-v1-1-c7208502492e@kernel.org>
X-ClientProxiedBy: CH3P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::32) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 3feb9ff7-4be4-4c8b-5f70-08dcc46665b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9JT5wIeInMcmmNTnGlY3g9szeTgfsBvY6XKTHone7bAbpFABDVJ/UPSiVIKN?=
 =?us-ascii?Q?WzMItVKTjaZHjqhQCADKxUbuanBz4CBSCnPQhaAXpblQqluN7asA80J8UsZ7?=
 =?us-ascii?Q?oWFMFm6xYp5rih7wGesB5urJ5bn3LsQuehELoa5nNsZxnoHkwfNF6f0lZbIq?=
 =?us-ascii?Q?WXd9dpRBHUijR2RfCAEYq8/XlESOtGQD8AYkc544GweBObaVVrfmwRG2whjo?=
 =?us-ascii?Q?sItfl4KQbOkjI9UpFx2DS2HwY7qC6DGsn3Jd0RuMEAZjj5AUxp6N6cL0AXem?=
 =?us-ascii?Q?RVzFAgpg+knronDWKvadJyLEGay9GiW/n44TWJ9DnOjkk/AopnUqaAXD0dI0?=
 =?us-ascii?Q?gCurZHopq05yfRvJ0g22A9uKcfAtKTMONncQDST2j7vQiRmO5O1MXSDYhYyH?=
 =?us-ascii?Q?urN42u6jhPrprs7j7czRT/8vmeN00Oa0XzE1lyZJ89o3geUYuTyJQuTfdhoG?=
 =?us-ascii?Q?vpX5gyVJSNhxYZowGFwMPzc7D2CkzPnA8CFWzITV3BPCr4ilgnYpdlkTrK2b?=
 =?us-ascii?Q?suB9/Ao1RkuBaD5XLssUcNLzf5d0lzQQIOSTvmmjxTe377+Os93UM8l9cQ1e?=
 =?us-ascii?Q?O1eJ2hfKT/+E4LW7DYKcFUGbeFdFpz23/JdhmLXDqXegwtUrsipVzmXkJ+c1?=
 =?us-ascii?Q?7YcvwmpBeZ9gWOPTzqF2gw5hCe3n7e7vE1qrI3NzvrFw1xwoEEIifzMaPKjY?=
 =?us-ascii?Q?gFNWay8UMpbsG8bzDsLnYWRkKwo6d8S5WnROu3f7vyLbe2wS5G6oYNXsnH2x?=
 =?us-ascii?Q?fzYq4qv12GYHLz5m6ofTyQLbVMe+b4Gtfv6tl3SxRkqXIN2ENSy0cVr/TKUI?=
 =?us-ascii?Q?x/Kb06eqFqZTCUOw4wEElmVxkH6n1lEhib5LUNyNy7MTW5dz25No4yxuDHRQ?=
 =?us-ascii?Q?sh/QvAruTrS3Z+zlR9JXCv97woVR4WslgefyffzfsqhnoGB/lqyTHylsj1Iw?=
 =?us-ascii?Q?oIXM0aEBq+o02d+0FHDrCKfG5rMj0K+jTXGulnkOi8t65FiaZ/GQbRP1OplF?=
 =?us-ascii?Q?P95vZ9/BNWc2RFsq2pPKSHIRLJTFLe3XnBddca9V7tfTySGtfjZDYQ3OyieI?=
 =?us-ascii?Q?z1v5AA4Wu2cAyV1aNOU+nwQQ0NWmCc3kgNsQXfgO3PZhzWxcq1b5KAPlztbn?=
 =?us-ascii?Q?oOQT4tz6JjYHsj+UqHlUs44Wbt5p3DWfHI4mfBjBUpBC0eNvG8hFdEc6M7ly?=
 =?us-ascii?Q?qk7RYA4Cg5nEDQdKQhjFYQ3pFsSNhdednIw8PQYS3VXEBWYZ689dKWlzstnQ?=
 =?us-ascii?Q?6A8PjMVWsO7kEZw5ldKx6fO9RwKQRz58c/1UNT7pDRbjuIxqhjv78eGn6/fy?=
 =?us-ascii?Q?niVRkTte8gg6xJ6AXSZGcZ4XaHmGScx5nX4IuNubzE3rBg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RWx32adIh7W7JqUO9lUQE8Rejj0SKHnRMqyoUNDd5r6z8nxOOJb68QmAB6Mi?=
 =?us-ascii?Q?xUMGZiEU6Fn+g9jb9z5MPzrQwsTOLmTcfXRLkF81Mw0b/GGhchxV5o9zO48q?=
 =?us-ascii?Q?BHhadVHNNJtdMolgklgbkkd07o1mPvWLW7HzH73Q/FjQR/Q1qp4PiFpr5/1W?=
 =?us-ascii?Q?OeFVCSWAWXi2aP4TwAMs7nUCuoH1qsMhr023BMrE0svIDSSqfiIJYzgG+udT?=
 =?us-ascii?Q?Z/Uk/bFHJGWArBO01o1Cx8oSmUbwg1hCsd9oVxSf6N4hABZhkFHtfDjPFqks?=
 =?us-ascii?Q?nPSePwjJHpgaGRcqIJsKxet3c6cmDmH2PVdj7CsxU4PHktlAwcD9wrXO8QM5?=
 =?us-ascii?Q?GZE1rqW0Jw1hbDngGYHGIy8sJPCy0lXhZtRQLQ/fsdMq5wAnnYn9WFyH3Qyl?=
 =?us-ascii?Q?6KkifKbeEeiwxfGDSZ1wv6Xyxmf8OrtvxlnRvJVkn5u6AC/FpdJstzmkKZym?=
 =?us-ascii?Q?8W6WXViPBmRiK3sgFTU3/P02ZH8KOVRNJkGYhOtaiFzrbSFDPxSv3k1unnqP?=
 =?us-ascii?Q?jBwR6tOpmUCW5FkOCT0o85IIpooW8/19U4izP/o01CNtXBXhZZAaPpa6MYqH?=
 =?us-ascii?Q?NiBnFBB9MfBkERih8kYm6SQBIdaJFzx7A1sNGwslG65EKccC7AT9of8uuGD7?=
 =?us-ascii?Q?x+BU6sQ/FROkqgVRd2lizdCSm3SeJ5Cr3WKCQK/VB3hn6pHXAW7qj15RgRyF?=
 =?us-ascii?Q?fZE2ylaiN3+xa358HYhTeecNORtywX0Ms1K6bpv8dWZnIeKbvJURckCdxygQ?=
 =?us-ascii?Q?JTtmU7A9pG/lb/ylEUtmEj3o+w62qaovTftkVYq1sCondoEmxtl2/sDlI1Nu?=
 =?us-ascii?Q?gDh1kbZZg6u82uaVWVW7mc9t6qz0UXg0YdGRRa1RPJTHLqy0rxk2YDKN6++o?=
 =?us-ascii?Q?RSh1WaQTcAE4tYL9UB4kWgEjLsHYob+xiEwWWD/dnIfxS6a62JgH1jfoeeaz?=
 =?us-ascii?Q?y/qgkCCIKCV4swe0zfVaf7NQjoQz/N5s+ugR+UWsidqXuLHULOYIKkZuTYby?=
 =?us-ascii?Q?tLDtRstAmuBCustB5/H6LZyereSCkbTUwGNeq2XiZ256OZv+CpIZCXidqlnK?=
 =?us-ascii?Q?M5yggyhl+uzkoHsnkuQ4RTbuwRjXfAe5ziYQ3l57U6SvpXQruGwdADN+BGZg?=
 =?us-ascii?Q?wSJUULWF4Su1nMnhFB6wlEGGvjFrGQeciuR0J+R05JvvOMgpAWhwZjk5akpk?=
 =?us-ascii?Q?cqMaTKevtIW/b2MB0L/EWv4wGmgBEW0py0YEykUbVp+oUPSyvSDxLDV6aMnG?=
 =?us-ascii?Q?SGnTar4obfm36PG53uL+84gnRd8y5i0f6dJ8jFIgGhWTF4Y20LJ4VdO+/4ge?=
 =?us-ascii?Q?zaL8SzTeDzJNUtKVVj2gFtZrcTVdqPlx5IPlCe2tx8ke6hvHUNRT1VRBlz2f?=
 =?us-ascii?Q?Lk49Bc16zlssowqxJN0tl5KnC+QfAQfTh2evlL4vrD4pLAkPqHFZRjgVrimw?=
 =?us-ascii?Q?5P7Anxd8uovapgLK6KxIHZH9X2eRspC+8N7J6OaZTOsMQK56WRWx5h7pE5xP?=
 =?us-ascii?Q?Kh/HSmsWOUVRAbUDwcYJIJ4Dd5/RVFkj5MBGEflIiN6i/C9HGLkTAJT5Ok9S?=
 =?us-ascii?Q?beaxVvnimBuHa9NsX3FZRl6o/ctyqcXaH+ar7LhA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Qg5qz0hipsEQveExKjUQX/VzwRxuE8Ri9cUHM0lFmWf5gozdVkCeBwg9qDYuIvgws+3d0qhIgr+pHyS6/kQX2kOzpiADKIW6T+t+ATdh2GSUdbvVFpXoFelXYepjhhE84d9BMvFEgt6rgDA8wjaKAknoe2Lv/E/uQLWAdENVsoLedyWb3ptv8XFXI/GKsfwDqRTUDns0jLQORhJGa+hVb/FKRpGFbsTM6cGfE901Cw0H0+W/BUkHewXvbgMVNfhPcnvpzL8QZ/SWtseDVZi4VxR1j0PwEUXrfTvCMn0/HHCOYwF7Tq7YSC5+XbJw8kztxfJdoBK3v1jJh7y7GSaOda9UrDke5KPDPbIfcmTRmvoTYLB1tSv6tuLW2QIm2gg5i4AvV+b+H7qkqRIrbp85XCT93o3m/7NKiauzSnvahit2NOnkFMPE0i4IjgWUmbWfAcelMLnXdvIFhSHXztuzXET7G/nth4Sn8fgL9TKTlmUo/xbbLlqMoqc05G6ilqGUUZQwvuYlKXtYjplzsvHSnpyuaCpIcRTiAfxhKX5jVFbCtpVhap/pu2bLnWrrh7VD9bz/GdkJkGHC0C2trTJJqH4MhYg6DrhAdOoThechqeA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feb9ff7-4be4-4c8b-5f70-08dcc46665b4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2024 17:58:45.3308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wDxPNlh3Jv2nzumslas9Ez3q1+TZ+d2rnmf04kFKbg96522BFa7VTv9jnIHYxEyc8CHEYJoctbT5WovhXKLoSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7185
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-24_12,2024-08-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=826
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408240117
X-Proofpoint-ORIG-GUID: 6904xf6X7shXQtXCVa1nUvWTvqZBA37P
X-Proofpoint-GUID: 6904xf6X7shXQtXCVa1nUvWTvqZBA37P

On Sat, Aug 24, 2024 at 08:46:18AM -0400, Jeff Layton wrote:
> Currently, we copy the mtime and ctime to the in-core inode and then
> mark the inode dirty. This is fine for certain types of filesystems, but
> not all. Some require a real setattr to properly change these values
> (e.g. ceph or reexported NFS).
> 
> Fix this code to call notify_change() instead, which is the proper way
> to effect a setattr. There is one problem though:
> 
> [...]

Applied to nfsd-fixes for v6.11-rc, thanks!

[1/1] fs/nfsd: fix update of inode attrs in CB_GETATTR
      commit: b0367a7cf033841257d6cc1ff5f9d383aad97b61

-- 
Chuck Lever

