Return-Path: <linux-fsdevel+bounces-48344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B15AADCDE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330F517F90A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF2D21770A;
	Wed,  7 May 2025 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DtB4wjvX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mai4DyIQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B42153D6;
	Wed,  7 May 2025 11:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615883; cv=fail; b=NIdpKYTxZlM0zSSMEAtkpS/pUGLLrd5l3XzpJZzpk9REOeLcXKq7zv2I9kxg8mwjYaQezgUQuh0lvwioLV5p4ZuaokPNLiEbnuq28z4V37z70C/y6+z3HscDmcsAx5v6rFkK2AXGmozIfodFQOG7ftJggP93v+EX+brGvi2dqZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615883; c=relaxed/simple;
	bh=CVWT5f0azKXXBOn4WkXf/jjXfEHLltg4Y8gcmFOQ8io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eO536igD07n6OyNenaL9w4ebsS8ixu+DzjVO2ep/pv0brWTrHzfpYQAB7DftBN4jtgST0wrMm0ZpXpdU3VUvFcH0Iqxla8i+PUNwR6xM0b2IUVsIRf5mtypccZ30S2sht5xs8sOV5Aun4b4UUSRUhzdLkBYBzr6Wr40tu2IynyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DtB4wjvX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mai4DyIQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547A7LKP016607;
	Wed, 7 May 2025 11:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6cqLKnECg9JHKbvOixy6orNdEIT5FbsnaFQehYrObck=; b=
	DtB4wjvXmNYxlW/A/WyuRTXalpaB2mQOIW+LlaWleN6JwIImvgeqKZ/BUAqOA/cF
	6kxpOdXEzWM8IV3Pw0uR4cGpzsBS0sdH8qFwLlPKU1jljdLTo84zjm9Qz3NT9U0r
	Qy9Ory4x4FNau30SLRQCYcTwWMKSgbfAdMexX60QuIb0QS0gG4PTc17MVkfkYN15
	wZJwWzAvQUBy2oTF6mbC4hRtzBbBVo3UE8zm5zs/zvfFsBb0ta2cBbyNiA5AO/So
	3fpLiqSB4CQNYM5x8lxsdmgXtBax1LzhZthWkptj2tiSiRAg2vOORhX03z+ur33f
	0D1gNlueI5maURvHek+jfQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g5fy03vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547B10pj037590;
	Wed, 7 May 2025 11:04:06 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010004.outbound.protection.outlook.com [40.93.11.4])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9ka0rpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yi8XT2aho6mrDxkGb+5iENhL/5SGyw4gAQW55h9+myJwokxOMZJFTfzw1UcqOBTsRhq76M/w76/lFAj+2XWR+ddkJc76Vbjj2/oorDAIsySoRvhFDgDHWRxDirOImIse1dq1BzsWlw+FWehgt55pa97hockmXxJFpp2SNAjRdx90UqoHFvyW7QJPKSj/LTXqfivosnb1uSUlP7oMQ9Pk68jtXeoX5KnlNQknRUXB+F7EFufTSKFemC6IVy+yVOYet+8vuMdG/ySJ8Zuutg8Q5PJCl6Q4XXUEva5TH+ToWNNTe8SG2cNzCYpNRzTYLVLCuxcIkP5ZYOnJWe+V4DW5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cqLKnECg9JHKbvOixy6orNdEIT5FbsnaFQehYrObck=;
 b=Fg+ACUYbomwKacPgR0bkbFszyJRT3SpJLYtUG+UiFjrAZpbKkpmtQuH9pnM3Kv99eLVKJ25Bp/+a4BmbZrWz5DFimq4yygGTAxBo6GzWv2QnkRtOJ09u8hQEwTZh06Zs46Jofy9h4NHLAR9nXa6EODhfrV9zGqGGiR+spe3BghqizA2l6/jqbnUOhhOrC/gRAH/f3pMJI5oIBZw2R5+cJgnN1a5drUA4OO7vBaIOBUyHn7RsxHbHe4DX5X8g2OCypxL+BeWWHBelLBsetQnuU/dtXCtHCeGmHiMR/ObDvf1EGtKphXklbBVqdmnmiNZEOpnettvKBBCDDcZrUCcQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cqLKnECg9JHKbvOixy6orNdEIT5FbsnaFQehYrObck=;
 b=mai4DyIQMDjIjGvGCE5mWxIxOK3KdSgq2PTEAF9dVqzbyLf7qlpSlzbhkBb/GGCT9BTrg2AXpQEr5rf7NtLpCmPq/V3X5kmouJpEpEmC6t0zFRfG3kGXX4hCv3prxl78J222zVdBLKfcwG068qNcr9XQe7bi+Haq34+vtDh/5co=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 11:03:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 11:03:59 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 1/3] mm: introduce new .mmap_prepare() file callback
Date: Wed,  7 May 2025 12:03:34 +0100
Message-ID: <c958ac6932eb8dd9ddbd2363bc2d242ff244341b.1746615512.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0069.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::33) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: e6958f08-5c97-4ae3-a2c3-08dd8d56de56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6kuDVfPhKCNnQP6CdSzdrjp24Qc+uWQiEpO3dOEaGYAlks/1rWmxTNsHs0B?=
 =?us-ascii?Q?9SfaMkMfeVSnA7IFufwOcq19GG89RhcM0AwqImvxMztpr7+Wf24NPAZ/MNqZ?=
 =?us-ascii?Q?VNtAHhY7Wew9fpHIq23q1pmwToUaYmrTgIAxTkU0WYgMG6M3fGcIN99qIv5e?=
 =?us-ascii?Q?bjT5NzTK8zy9ooTMHRUAMWWGT8gWuQCPrLtt8l5qK3ZzHajdEGG1PebEbRdl?=
 =?us-ascii?Q?2kjmREyNOCaM0QFOg13jtWUwfWEyIBwT/htAeeNe/lTMIaEVwRfXf6HihmNe?=
 =?us-ascii?Q?m7jm30oHdsJHDRXm7AU+7mLfY64eXQc9wrd5WiFSXSziazVa5elNM4ou9rik?=
 =?us-ascii?Q?8V5JPZQ/IRT2/ggRRa413gt9fDAyo8wH2t5DObSkDtXXaRG9DFM2ORLv+bvN?=
 =?us-ascii?Q?J/Y+vT849+8KvP+QOiAKj75v87Md4JU5lINibgfFr43HT3Es0473X8kAv7nt?=
 =?us-ascii?Q?JBKOSaEVvpRmTEjRf6aWXtTCmewZDnJVZbIPLf2o43t8WAuPScnMiCC+wQXu?=
 =?us-ascii?Q?hRcDxDVEsBOchinz9HtHjzIejlvc9n4gKCs32gH89Z0PvBQpFmEifySP40mo?=
 =?us-ascii?Q?MNzQsY14faLApkfISCKwtbv5uT+1NWan7fcj8bV4ImxVyHepzhTBeXLCHvyU?=
 =?us-ascii?Q?3e1aHFnpZuNvcbU7Eu/d3TGsOTt0bxuo/xV9N9AxnwMaohYyyHhoWxiKzo2Q?=
 =?us-ascii?Q?wmwIxOOR65zSo0eZ5cl5PzxkGNw6LYC76kCv8OPawbw9J3bjlHpBxOTdIlHy?=
 =?us-ascii?Q?IieqwliHMFBFXkYy2ZocNSBv1SmwTtVXiWDJGXW1+OMyLWTciItMPw5jmt43?=
 =?us-ascii?Q?/hHeyzw6jVC+Anljiq6NrGO88AXB84q1gnIvfivMmq7RGs5DuhGI1Batf17F?=
 =?us-ascii?Q?oezmjDMxV/dZwmUKQ/4iXdlsl+gR1LgQXu6o+L8RCWVaJIxMYcz2v0+ymAei?=
 =?us-ascii?Q?J9y44EpTvu4n144cRifyxbTRZ6NRwCEygagUTxQIwSYUmGGFywejR3xChjSX?=
 =?us-ascii?Q?7uhUqhJYt3biogHb2qoaZCGNZzYEEJmJmhcryxFyvtP70Xt2g8kDHpg5jVkT?=
 =?us-ascii?Q?jQJ/wyzJTbo2zApUbN7bC51tSVxkf4vELrIhWLG9FJWljFhV4n6IhIF7L3Ct?=
 =?us-ascii?Q?Hy4ErFBaBQdXhFHUKE4dPLnDDpVquPlNAb56kHpzDfP+/9/zu9U2rhagkgu4?=
 =?us-ascii?Q?ys5TvneeGjSRjMIWe5KN5l/HOGsWfG1vZ8mDk8EJfYfrlmLbqgAdXVPYf17c?=
 =?us-ascii?Q?H5GzGcKH9xTSvydfnm+yEQkt36HtTpP/4mKV5gXfxP4OPekituSk+sq1kmUZ?=
 =?us-ascii?Q?XK9Y9XpdfVPjEwWhB/fJ1DmmsyJizNPqykHimRPTvcKxwVIozsi1AuVHC5wE?=
 =?us-ascii?Q?DcsbufmmzLwglWH1m2bSBfbSY2Re+Oh0dwRBotA5tmD2ibUfYtermj+TyBC8?=
 =?us-ascii?Q?krohQvZEy14=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HkJQKfitpxfpXVlCHpitheI3toW0eHjuvKk8UVZFrPTdzhLLFMl+/dK540hE?=
 =?us-ascii?Q?7y9VXt3r+fduOqQoniYkPv72/ZAy1IR1JDG9iUnhf992m0OGYxFtMKPic/k3?=
 =?us-ascii?Q?5LmXr9sigp1/HlDKaBX/+xLQsnuTn1auzNKsouHcCqjD7/jLq+VdPLCKdpwi?=
 =?us-ascii?Q?0IpZhcSQ2SLYOs02swDRFtXgmwBuS1gwfF+FRXGgCUkzKuB1DPrYb3oC9ZIf?=
 =?us-ascii?Q?/nKFbS9rFEOJDgqgKYHbONcBa194lXU/I+niEoL0I9vAceNMhjRg/0SO5lh0?=
 =?us-ascii?Q?Lka8dOkZXITYmvE8vRMHy0Zgtn8lv/AheVW1ZxYNN73U2///NYcKsb8nyzwX?=
 =?us-ascii?Q?i5KlgcMCaWeKmSHQTNte0j1fi8bx5YbbogyD7WBL3+DqH0g33HodetoGwXSZ?=
 =?us-ascii?Q?3NEFT3IgfaN+zfr/9Fe31mnVT1FFkaZ/gdvQammGZVdC46S82LI4iTf6vKvG?=
 =?us-ascii?Q?6VHYSMLZW3E2mbM6JZfneSsm+6eSR+v/qub3VR6A+JyW8rKwrJEsEYJuksOW?=
 =?us-ascii?Q?HFMimQfZCmew1OAJS/NJSjH6gfU+H5Vk3VYg4CUaMev1ChU2ZugMNfG6k3RQ?=
 =?us-ascii?Q?jAmPVyagvHd2KrETf2QCt9Mw5GK1ssRrfQ0EDVDiSzp+RvWEf+bqG7FfdRoD?=
 =?us-ascii?Q?hZRabb3QtiIhE6O2HjZMFxh5rU1CIPQM7V8zsPvvBKKiUxcmM25MPWLrr4Qh?=
 =?us-ascii?Q?rj6IjbtPu6GhhyQ2IjJSz2nJkB0/nfYRaA9ro8e2+7Mo6FtbaYN7Sg/7RAoE?=
 =?us-ascii?Q?5sbLN2lIw6MnMlULEy96Zex2xlTa7ijE5C2da4mF9fQ5TW6cOmivFgR0nJve?=
 =?us-ascii?Q?ww31OVoEV/I9sUds0VIIzJP4GC6QeD+EuAWs9JLdybocTplIk4F+ipJ0t/cM?=
 =?us-ascii?Q?MAa15c2liXpR+PalHKTciZ71xC89Nv2EVuGRUkzY/sTIARSMqaKtD5Y2Lqe1?=
 =?us-ascii?Q?2RxQUXiSLRTI3S1eeEU4GvQ8uAlWB0GOP8Sm0WOH157ZnODa/bOLdZ5D4hLM?=
 =?us-ascii?Q?KpOWVzjmTUgpWR9EUfqvNTKAdyBSrZJmKPdOuJAJRaNBCtj6ReboWLTiTU3a?=
 =?us-ascii?Q?xiVG/Yzt9E6QoLcaicS3M1kZ5QB+wcEp9dLVcwGOe5xmq6FpUs4XJPk3gqYx?=
 =?us-ascii?Q?P2242f2l/hZlRZfCAP8GKx0RUd5wog0j044lH1u67EK0LYTzt21wcffUn/Xt?=
 =?us-ascii?Q?9+4JqXwaxF6C17r//o44xSNeMLgoIt11a7De04pyQeyEQAUdt7tlOfja0ZZe?=
 =?us-ascii?Q?xf5Q58uLzIZYEMgnCJ9BH8AbvgAgT8TLsvUSFE9Zuzc/rHhcEl9jEocX+i17?=
 =?us-ascii?Q?qK+IDg8QERILm6MFSMqSyXK8ZG5sKpSchm/3tf7Yj8hS4YTJW4F88BPT5nyb?=
 =?us-ascii?Q?sx6a6qvGpG0VzqbH9jACvcGLBwXofoMCPVWjvqQFJxJU9daPqpE+h1gc8ShN?=
 =?us-ascii?Q?pb++VDDCdJa7OgDgbm3PokD7b0YMc8cK7mFJIrhmbnkyy3BpHoskXYqDBj9f?=
 =?us-ascii?Q?oCi2d+fRQeSLMgWK79ma9Fk7vnlEQ185yTjyu3Gxz6BmYh+SMCyOiC8FLBXB?=
 =?us-ascii?Q?OsCzJYDqe0uvKGk4MkbSuT8iR2kbUcuWGZn10TMWIdp7+VHR8tCzcOEd+cCm?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ddu72eUnu1Pd4qYjoWkRzNUwfFlM7MHC2CFMN9HxkL6chqCtdy8Qz2LucL8Ib8H+/0ydOcUwOZCFIVyPhoIlvoogmgLio5kvGc+ShDaUEE01O7tPaJwa0old3behe8uvxhqwOLsvadSIAGNi9B2pPsraluVDOJemEU7VjBcMNGqf/0Oi+Pwqp1OCuPFw4FtK7y1KQCxjuhYHBdl7uyLhYvfPCpRevtdT77ZSOnWOiFNIj6plJWj5skl+fd1/8rE6RRD+lQWAg+DbGYftBTY2rsQalAQS93KhmtEjWsPsgpH2rgxAGaBhKW1vc1LFh1JxssWEurss3gz+CFOk/1tCZ5wTGPt0F3mtI1MDeHefYxeojezzKp7ZBO53Jl8w5soc74emCRTR3Cyc2XY1HQRH4QOm9OWqaqBHGu/A347MNrvLh4KsC8W+bVUKgAQMuCIU+KxS5ra15sXijDfwBivYQiSswLzY/XQQNPYG0JrSwv4BcK3CH4hmlJyn+kBDMaqGPPSB14uhWY8VB+sxW6UAsm+Djogi20eTFEkR+964zLU75TrBv8QCVxYD8b7R9S2E/GjUmmET8Dp8FEzfgBqLvtvyg65x7wHBFxvirhLG9QA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6958f08-5c97-4ae3-a2c3-08dd8d56de56
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:03:59.5172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dKQjQHrbKAQfnwqIMlARocfT67o8xjsQvKki803p+nEZ2xquttUFxV9wZP780VWg2IqZM74h4vEgwQSOutHpC+UGNBELwWaQYi7Im5zcnGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwMyBTYWx0ZWRfXwjOmFWBoyUtF LHxfe8pw3rxA0FYzXiUQ65523fbULTlN7+dXpw49uOsc6WxW63TgDg36kAx0aHbhUWJ6dbS+jaz 2gklFAyB3mbz9rIV3oDqSf7QbLOjjpljms45xnUfa3ZkR7Sf3Z8Ma4tqy+AVAAPVl9SMEchGBL7
 lYqi4e0VtNIYQHF3A88JeN7Eed3iFnQOhpAPLbtZpuBtt8mcaShTBSylJKWETVN+ffjm0NDdWUl eEY+G/eeZwlPdyqLAEIwzu4gfyBYojdOilsI6qq7jU9Gz6NeSNhktNn/kMoRBf/rrWETOOLbgv9 rxfN/f0j1zUJ2EvTwG5YVClmGHW+gapObAoTcSfWGWwSe7qyChHuS7GJ2BwhtmMwYYC2CiD2kKU
 Q0Sop4NFv05+JClsNy1+ZAbsFCwZt9iRucmYaqdM6WQJH73P2dpWoE0aVuN/SVPy83Dp33Kp
X-Proofpoint-GUID: ubTKsO5itZkln7UpzK8Wmft2_QLCotv1
X-Proofpoint-ORIG-GUID: ubTKsO5itZkln7UpzK8Wmft2_QLCotv1
X-Authority-Analysis: v=2.4 cv=BOGzrEQG c=1 sm=1 tr=0 ts=681b3e27 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_cC7IYOJfOS3saVh3_QA:9

Provide a means by which drivers can specify which fields of those
permitted to be changed should be altered to prior to mmap()'ing a
range (which may either result from a merge or from mapping an entirely new
VMA).

Doing so is substantially safer than the existing .mmap() calback which
provides unrestricted access to the part-constructed VMA and permits
drivers and file systems to do 'creative' things which makes it hard to
reason about the state of the VMA after the function returns.

The existing .mmap() callback's freedom has caused a great deal of issues,
especially in error handling, as unwinding the mmap() state has proven to
be non-trivial and caused significant issues in the past, for instance
those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour").

It also necessitates a second attempt at merge once the .mmap() callback
has completed, which has caused issues in the past, is awkward, adds
overhead and is difficult to reason about.

The .mmap_prepare() callback eliminates this requirement, as we can update
fields prior to even attempting the first merge. It is safer, as we heavily
restrict what can actually be modified, and being invoked very early in the
mmap() process, error handling can be performed safely with very little
unwinding of state required.

The .mmap_prepare() and deprecated .mmap() callbacks are mutually
exclusive, so we permit only one to be invoked at a time.

Update vma userland test stubs to account for changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               | 38 +++++++++++++++
 include/linux/mm_types.h         | 24 ++++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/vma.c                         | 70 +++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h | 79 ++++++++++++++++++++++++++++++--
 6 files changed, 208 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..d6c5a703a215 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2169,6 +2169,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*mmap_prepare)(struct vm_area_desc *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
@@ -2238,11 +2239,48 @@ struct inode_operations {
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
+static inline bool file_has_deprecated_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap;
+}
+
+static inline bool file_has_mmap_prepare_hook(struct file *file)
+{
+	return file->f_op->mmap_prepare;
+}
+
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool file_has_valid_mmap_hooks(struct file *file)
+{
+	bool has_mmap = file_has_deprecated_mmap_hook(file);
+	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
+
+	/* Hooks are mutually exclusive. */
+	if (has_mmap && has_mmap_prepare)
+		return false;
+
+	/* But at least one must be specified. */
+	if (!has_mmap && !has_mmap_prepare)
+		return false;
+
+	return true;
+}
+
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	/* If the driver specifies .mmap_prepare() this call is invalid. */
+	if (file_has_mmap_prepare_hook(file))
+		return -EINVAL;
+
 	return file->f_op->mmap(file, vma);
 }
 
+static inline int __call_mmap_prepare(struct file *file,
+		struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e76bade9ebb1..15808cad2bc1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -763,6 +763,30 @@ struct vma_numab_state {
 	int prev_scan_seq;
 };
 
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
diff --git a/mm/memory.c b/mm/memory.c
index 68c1d962d0ad..99af83434e7c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
-	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
+	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
+		 vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
 		 mapping ? mapping->a_ops->read_folio : NULL);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/mm/mmap.c b/mm/mmap.c
index 81dd962a1cfc..50f902c08341 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 				vm_flags &= ~VM_MAYEXEC;
 			}
 
-			if (!file->f_op->mmap)
+			if (!file_has_valid_mmap_hooks(file))
 				return -ENODEV;
 			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 				return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index 1f2634b29568..acd5b98fe087 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -17,6 +17,11 @@ struct mmap_state {
 	unsigned long pglen;
 	unsigned long flags;
 	struct file *file;
+	pgprot_t page_prot;
+
+	/* User-defined fields, perhaps updated by .mmap_prepare(). */
+	const struct vm_operations_struct *vm_ops;
+	void *vm_private_data;
 
 	unsigned long charged;
 	bool retry_merge;
@@ -40,6 +45,7 @@ struct mmap_state {
 		.pglen = PHYS_PFN(len_),				\
 		.flags = flags_,					\
 		.file = file_,						\
+		.page_prot = vm_get_page_prot(flags_),			\
 	}
 
 #define VMG_MMAP_STATE(name, map_, vma_)				\
@@ -2385,6 +2391,10 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	int error;
 
 	vma->vm_file = get_file(map->file);
+
+	if (!file_has_deprecated_mmap_hook(map->file))
+		return 0;
+
 	error = mmap_file(vma->vm_file, vma);
 	if (error) {
 		fput(vma->vm_file);
@@ -2441,7 +2451,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
 	vm_flags_init(vma, map->flags);
-	vma->vm_page_prot = vm_get_page_prot(map->flags);
+	vma->vm_page_prot = map->page_prot;
 
 	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
@@ -2528,6 +2538,58 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vma_set_page_prot(vma);
 }
 
+/*
+ * Invoke the f_op->mmap_prepare() callback for a file-backed mapping that
+ * specifies it.
+ *
+ * This is called prior to any merge attempt, and updates whitelisted fields
+ * that are permitted to be updated by the caller.
+ *
+ * All but user-defined fields will be pre-populated with original values.
+ *
+ * Returns 0 on success, or an error code otherwise.
+ */
+static int call_mmap_prepare(struct mmap_state *map)
+{
+	int err;
+	struct vm_area_desc desc = {
+		.mm = map->mm,
+		.start = map->addr,
+		.end = map->end,
+
+		.pgoff = map->pgoff,
+		.file = map->file,
+		.vm_flags = map->flags,
+		.page_prot = map->page_prot,
+	};
+
+	VM_WARN_ON(!file_has_valid_mmap_hooks(map->file));
+
+	/* Invoke the hook. */
+	err = __call_mmap_prepare(map->file, &desc);
+	if (err)
+		return err;
+
+	/* Update fields permitted to be changed. */
+	map->pgoff = desc.pgoff;
+	map->file = desc.file;
+	map->flags = desc.vm_flags;
+	map->page_prot = desc.page_prot;
+	/* User-defined fields. */
+	map->vm_ops = desc.vm_ops;
+	map->vm_private_data = desc.private_data;
+
+	return 0;
+}
+
+static void set_vma_user_defined_fields(struct vm_area_struct *vma,
+		struct mmap_state *map)
+{
+	if (map->vm_ops)
+		vma->vm_ops = map->vm_ops;
+	vma->vm_private_data = map->vm_private_data;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2535,10 +2597,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	int error;
+	bool have_mmap_prepare = file && file_has_mmap_prepare_hook(file);
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
 
 	error = __mmap_prepare(&map, uf);
+	if (!error && have_mmap_prepare)
+		error = call_mmap_prepare(&map);
 	if (error)
 		goto abort_munmap;
 
@@ -2556,6 +2621,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}
 
+	if (have_mmap_prepare)
+		set_vma_user_defined_fields(vma, &map);
+
 	/* If flags changed, we might be able to merge, so try again. */
 	if (map.retry_merge) {
 		struct vm_area_struct *merged;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 198abe66de5a..a2cc54e9ed36 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -253,8 +253,40 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access */
 };
 
+struct vm_area_struct;
+
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
+struct file_operations {
+	int (*mmap)(struct file *, struct vm_area_struct *);
+	int (*mmap_prepare)(struct vm_area_desc *);
+};
+
 struct file {
 	struct address_space	*f_mapping;
+	const struct file_operations	*f_op;
 };
 
 #define VMA_LOCK_OFFSET	0x40000000
@@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma->__vm_flags &= ~flags;
 }
 
-static inline int call_mmap(struct file *, struct vm_area_struct *)
-{
-	return 0;
-}
-
 static inline int shmem_zero_setup(struct vm_area_struct *)
 {
 	return 0;
@@ -1405,4 +1432,46 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+static inline bool file_has_deprecated_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap;
+}
+
+static inline bool file_has_mmap_prepare_hook(struct file *file)
+{
+	return file->f_op->mmap_prepare;
+}
+
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool file_has_valid_mmap_hooks(struct file *file)
+{
+	bool has_mmap = file_has_deprecated_mmap_hook(file);
+	bool has_mmap_prepare = file_has_mmap_prepare_hook(file);
+
+	/* Hooks are mutually exclusive. */
+	if (has_mmap && has_mmap_prepare)
+		return false;
+
+	/* But at least one must be specified. */
+	if (!has_mmap && !has_mmap_prepare)
+		return false;
+
+	return true;
+}
+
+static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/* If the driver specifies .mmap_prepare() this call is invalid. */
+	if (file_has_mmap_prepare_hook(file))
+		return -EINVAL;
+
+	return file->f_op->mmap(file, vma);
+}
+
+static inline int __call_mmap_prepare(struct file *file,
+		struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


