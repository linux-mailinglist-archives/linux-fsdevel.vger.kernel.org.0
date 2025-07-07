Return-Path: <linux-fsdevel+bounces-54049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F3AFAAEF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3851731BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E65D26FD99;
	Mon,  7 Jul 2025 05:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0Gck6xF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tBeEyeza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA5A270ED5;
	Mon,  7 Jul 2025 05:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866213; cv=fail; b=cYAzpZChzdIGzUR8LNj+I9gC7RE0cLoXTRtyIkhTXqkOnBptO7ZoYekVZQd6u6uGoGjrszJYFWeJehwCVe69/rj8tUyrusMoRpoLGNjK96904yMYpymEFXSKkQzJ/5qJQU081hIgcFEhu4t6JF0uP1A41/uBR6nfRCWBzAp+gX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866213; c=relaxed/simple;
	bh=KR6ah+h1Deg+m8toAShWhW//tAiGYZykywWxrPftY5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rA1rh/KuBO+LlU7wQm60fCoW6iqTPCZ/r6izZLHbwnYG+CjqgJ+PQPCPgKVsUP8z6Mxn6OafWQMXQjeQKB21Uosvgauysyr917sB2CEUTYIwDLmDjysp5Yj5Vw6LFgQxp0Ib+2lAdhba1A3VPko1dZHlwtA69HWmrddzJI4WwrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0Gck6xF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tBeEyeza; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ3MY021464;
	Mon, 7 Jul 2025 05:29:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+e8BcbUhNG0d5PeCkSY4+5l1JXjD4biGqaRlpiD6vrk=; b=
	k0Gck6xFqivQkRK4jJE0qNH5JY1ymJp+hvGereSYUpaY6VWb41IsNbDOmM1RBawM
	yNCNv9fvxWOIF6xS5YvZpKmtld/ecEId9rKUKDIPgm/n1Kt29bfvDEJ7jW4USwe+
	M9MxZfwbwL/Y+FR5gCYA/59ZdS/1Tx86EWb8yqJRmyFf6MDiD5ZgF/me01Sfjr8B
	mS2Lx3aJbK1rEnuWxxnLHuhUW82I5Ei7KyzNqpjNQI1Bt+C3R3UssuanGMMywPMo
	+A3670WMWKyXi+vAWyscXZwzHCzr+14oorAPBSUK0ea6UGsjvRc9SAoi9JYrczOj
	ioB5br+rPw30z0YbgsRV/g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptyfj0vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBp024285;
	Mon, 7 Jul 2025 05:28:59 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:28:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pCMkV4vgSEG2BDDX463kM0lV0s9tkavFf6x7sv+GxXTi+vS1sNgQKeAX7f2+3Hgl8bZXVLEJb/+nn6HubsHfAJL1jMJzIGKWzRVYbhWtmkyOnUXujHGimtZun6+x8u2b7T5trTDTr7gL39hYIu5WkFkOdjMqROLpZxGSmXtCUktEdA466wSDZTGaagUnfWrLNbMEE13V+L2oMY1nLSrx4D4QP9BXVmocWcP6UA4Pa9+Ddg68x4k5JmEFzJHR6cuOJoe7YW02ZUoobve9JzNyyi/TUomAPJT+KQDD8YcNNk7oJrCcBO34BXyBL1wq88kfJARaYxwj9kkPy7iHucTagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+e8BcbUhNG0d5PeCkSY4+5l1JXjD4biGqaRlpiD6vrk=;
 b=e9hKrVMjEN+Rr8ZuvkOTYstMZsp4uUfTbAS9Mm0TgPIiKFnLGpOX4HxzkuWx+RO+UT5TUja1wL44lqY+3si5cF8Anu3HcPh0ZR18oYCyqeRYHPSCJe7tl65vH68Byw2aCTG/m1Uw3FmNdbq27SO70zlukU/vVvFM6D+t30ENoCloxHVTyxmSnzMD14nztxYOIMFc6STC72Rbz3ahqQK72w7YC/tqpxCkDqmvTzMKlFspbuuF4X2Bu+XgKFJROSYq7pwSLdguFszPkWrmWiRvPE6Qw+1IpH2drmWgDRM7N+JmBcrjGLijz7c/IY6XOnvveTDsH/0Uwnkq3mxlsvb33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+e8BcbUhNG0d5PeCkSY4+5l1JXjD4biGqaRlpiD6vrk=;
 b=tBeEyezaW2s188wUdPHkSzgQ/PJpBdZyP0G96GeG0a91jb+ItWsKsJfnChR34r+35liH6BDJSG2EeKFoPWld8tbzXCzPN6zuzrJw7sBKLmILwGppmHzJP6ngmK0PRYS/0PGKUMcHVFDX6oUIym293Dzl1WeeBcT2Udh+0S42P5Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 06/10] mm/mremap: check remap conditions earlier
Date: Mon,  7 Jul 2025 06:27:49 +0100
Message-ID: <3a24bca518001fea3a5f2733c55cf727e566b438.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4a7277-d91f-4385-faa8-08ddbd172523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T+5Ex+IwttMBrFJMU5BsZzrtqB/A8wrpt/2yjJyTLTye5nckTXNEHECw/o8l?=
 =?us-ascii?Q?hUn0R0W19YDpeRg9y+W0qIF81AspkJAQpzjlBQGgKkM+O7ulgE3sLl3aRtQ4?=
 =?us-ascii?Q?TPb7JiJOLoq6iByDyDeHnbnJ42Le/Y/SQwfng8rt4xrFk3rfPI0Nnzzotr5W?=
 =?us-ascii?Q?hffyLL/81rXdG8nrIJgy8//rDLgKHxDnOeRvoqmXStTW0YU4R8VKvtgxGpAX?=
 =?us-ascii?Q?hOybKRvP5uQcu535i6oRHbcHOCkwtGcKT9BJCCwt7vU6zjSGHZ332OqIXBhK?=
 =?us-ascii?Q?sEQFWMgyCPFp3x4QUzQNEpIWnCCAr32M0JpZcAOYHE2n8KcTlkSJ0IhTOFR2?=
 =?us-ascii?Q?bIlaN/e1lZQh9Pl1ep9QWswPljWTwWXdM3TUqbqo3S2HD0f1UKp11jZyFFL1?=
 =?us-ascii?Q?wcUlzX/Gh6GqW46uVaBY3vMKVFQSQWJcm/NLk2R6aV+xH//PTVyqFaPlt9mF?=
 =?us-ascii?Q?ehHDqhs9i2mOvuMelbPa+W/mwojVGA4W1FRYgSuwhrLY4aQJJRXXZZiH6pAc?=
 =?us-ascii?Q?K/dIjuszxl96ec2n6Es4q2z6Ld5A5HllS5VgQHX8qRSfYohXs4/S30CZpWVs?=
 =?us-ascii?Q?R7CiENTtzoqHhGU6v4Mtl+HahnaT0uOvsFRTF5dsw4W7KaWBHwaaJBdtV4eO?=
 =?us-ascii?Q?++aokfAniU9e2Cax0yGh2eFYtBVwFPLwkE4N/+apzeaeQVQsBjuR1PkZ4kB7?=
 =?us-ascii?Q?tC7ycDWZ6dulbpYBG8Jr8GyAPPlbTFcTP2cOyA6ol0641dNzgHnTVkFabgza?=
 =?us-ascii?Q?oJLe535f2j7Trivrp3Hu3tleIl9Cw9Ic+GoT1VK/6WlIoV61W3CJAXVVhctP?=
 =?us-ascii?Q?2Npl+i2qF47q13CsmENGf+VqI2ZBTMtySeoVDgzZiI1wiphM+PBA6yvRyarz?=
 =?us-ascii?Q?UPZyS5s4i1+0DfGgqGxCtFuiVH7JvEpMGK2OyRHRe15mhuecXrOXNzgBGeMP?=
 =?us-ascii?Q?xl/qc1zVx6ld4rI0X2cEJ3R9e+86D8AS79fPnuGkIQKhMZiC2BQ8GBzglgYw?=
 =?us-ascii?Q?msJT/sYHFzQhVa1joNlkowPbQXFLRLJHIw+1QkzfbzU3GVI2tOGZNmq750r2?=
 =?us-ascii?Q?eS8REGo3+Y+Zxfsd99QesQOzCsJf2HSixvIaOVogtAZFIYHfs+1n+AXi7YQp?=
 =?us-ascii?Q?p6mXLmU6kecsgUC91fHBJje2Isj2KpLW+HK2tZZRTPqHNHxqIWdfKj1D+2jA?=
 =?us-ascii?Q?ZtP9zPLq4HsdvD+N6muC3hUk1c+M+wOusgIG3ldNvaEOXUKbDWKJAuzRp9Ma?=
 =?us-ascii?Q?xQnJiwwBr3Hf35mynT4X01mAoKeCX7rff8lld+Mo0xOOZ1/XDkA6MUmsRDU+?=
 =?us-ascii?Q?Pgt29yKeCI/YwANVJUXXp/3G9m1kA2jO0UCfIXCDfXWTvYS0iCpwC30HZ2qv?=
 =?us-ascii?Q?lucTm3EojhTdGbWLa7P61RKPiYXvDroL+OmXfASyLpaol23Tjw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3qF1M6BIR/waLOJYMozNSwKhS20cnt+c7qsn3eCma/RfaCUDmXJCkpKYYfJL?=
 =?us-ascii?Q?/+qxdkxjdKJjiE556ozPGh+L2yOgbwn9PA/A/Bi59zDIrqH6iihdESVxpeBh?=
 =?us-ascii?Q?1Jio9/PnTge1oJAvQXgPb58unkNvlLWRfsZQKpj9jtIeULMPgf4bvymsUvIj?=
 =?us-ascii?Q?PIOWCEP4JJ+pmSTxDUfWQgcJyYpHPMM/GCBWNaR/yXskVcCA+T8wnSrHYmf2?=
 =?us-ascii?Q?ehGoq3ugKhggapD9/xTVkQRgLqNemeXs7gCvl7ju1fuaFHiY192qot0dLfJj?=
 =?us-ascii?Q?a2ZJSx2V9j4O4LcL+le0YK5PsPAtEobDmD5Kr1GAueD+hADeKDSTlYElT6Ko?=
 =?us-ascii?Q?0pxUXGUgTEsnMw8ESU7TyExKBpY6y6a3tYMRd/kiPRjEGmdFNd+eyibh2QN7?=
 =?us-ascii?Q?6bjgRiXa5gcgs6LVCzQ2wPTGD39iJdG6qswqEdOt9prRz24/uRBjS6vBHLJ2?=
 =?us-ascii?Q?YeqlH/CVmOB5MT8Z/BGbtnfqI9si7E4+/eYOMZlTyKqw6ywsJ4aTqNYdhERD?=
 =?us-ascii?Q?mocQCOrJrlEgyZacYe2g9r4P1cV/VqVjNELh73BzubedKaF8rTVRKnlyu1F5?=
 =?us-ascii?Q?3jUQkN3JamsQmN+wlH8fP0A/yoagjnuIEh2s9eHakk8Kjas0TmReS+C34tIA?=
 =?us-ascii?Q?WVr+x8fT3IvwVEB46iMHzqV7qDckOtaOicIQx4tl+uOP1g1ByGX18mxrXgeO?=
 =?us-ascii?Q?LaekDxy/rcIhe7GlARTZNlJlU/lW5kGKRDJ0rh3V/Q6Jpo+AuHh+fn0yP90m?=
 =?us-ascii?Q?kUElADKp3ximXCJ4FeFRzpblS/B2ut2+k+7AQWlthsrQVn8p2RWanoPVDqAc?=
 =?us-ascii?Q?je1vGuBA01EAAYqYBe/ieGgb1XQhMAoabfLEVTtMzQD0afasjv78DSe6vidg?=
 =?us-ascii?Q?nDA6ZKMMIzegjdJYmOFn93O6tHdZa/eXFI5M3C2Um6uGqP9ZikVc0kdRl03b?=
 =?us-ascii?Q?ZOyKbjWzZ9LK1mgSPkPLgdfMeo8mVUv9LNC/nZE7Ze7++Uoj+/lA8OtYJvS6?=
 =?us-ascii?Q?0c8PgwZz7YR4kN7gx56zWp2sav+5oFzU5GEsrF0elyqkEvhn+qGu3wW+c7Wy?=
 =?us-ascii?Q?79aua//Q9jxyVK0g9I/Vl1Kykt8iiWS01ExTuHF/jRPSF1akU7jgDbe+cAMt?=
 =?us-ascii?Q?DMcbzr4l4pHlBJVMcBBdEojf4fkaelLEO+wFn0iLleBgRV3M8cbrw73hLF+4?=
 =?us-ascii?Q?YsGhxVXXPRQ2+h2auG0OXcyaiWSJeGlCKmwe5aK5TCafXat3FUcxOWavDnKL?=
 =?us-ascii?Q?s8cWGt4VWdVK28/rKdE3dyy7n+t4F39ODBOglMme2PpqlyeY6xTC/yWRyN83?=
 =?us-ascii?Q?ZbNbLyzE11785+3trhj+qDKkeRuKaG95yjNDJlK5Eiv9b4TX8lj4gU4flJFo?=
 =?us-ascii?Q?YnehqJZ6G+1MdvsjBjXtGqUrkik1nfSTFbXUNeyqORzozaFvr6u7sPK5g72r?=
 =?us-ascii?Q?e7BZUzvD+UxPoHTk/QbVeYeKqA/mN3j9OIsic2HR/NZ/hIn9c+Rd3yLxMIfc?=
 =?us-ascii?Q?hFymyioJ2cLGAWbID3EhORizORkj/j+BFTalW2SkHAKxCGKo2sWqp2+DDXLz?=
 =?us-ascii?Q?4Hx+DD55X9WPB/wPa8IJwAb4lEmK/Ql7Ph6DjzjB2HnLVizu7oAbLvMWuoHl?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rakblP2UgPOPhaBMd126Vx1M9MZlqE7l5tzQShhm0E6WtkOdBsqasJXBH803LPB4h9b9hBYuShj+zZieZG34BShzvbrccOPSyX+MpUf0UokWM3x000fSzEH5GhqQGFxMzQTyX8WW+T7eljdBhdkLsh0Kj5r/YJogvhmc2kyrYnoiuOqd90emhyqkvneakSgP+spQMKLBNF73vAOsQTmSy6eTflCKzJ2M3KWVPLTXmVb/lQRnQmdgUdgeft+dxqd12nlWNHLV8SYrJgtzRud25LPjxNr4p7JAzA8v9IgnvAHm29AEfuY2vJAqWFKVaTlVIEB/R10GZugZP4145B0AB5UCqOzM2uE8AlI27NQMdnR1m6kkr03b6INpFyABATIbKQjU0UNUSykKeCEPSv1P1GH2CLs53ahfMpLSklT0URcrTV+1Wz16VUHfgw+ZfQoOm/O5RXDghGilD4OhZPid0f4gdsL8VgQ/ar8MahUm78EsMbnRM4c57L5DmBzje07U5h+D5tvCLFqlo3gskYofQKUrnWTiFwxPdfvk5ldrGF7K8K2VdpuTG5j+UISbu785O5PFYo334d8bz9AAt/pyRdAPgG6hOw4618QVGr20s7Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4a7277-d91f-4385-faa8-08ddbd172523
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:46.2146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPf4nzMOZol4lkFuboQSUUR/NhjpRYHbE23fEdA0UH0MQ6THJX+X7pKTNXHKYxxIi6ZFaILeVdpOst0hSrg44XdSQYNcWN/ue7qVT+gocRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=686b5b1b b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QQFbvnUwB9Dxs2rSiigA:9
X-Proofpoint-GUID: eebGw0-E47brR3x86r9-jpNy_7XPur31
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfX1lC2h2SvARAl 3lmWVYQtizCMpcqWbQ+TJjXPYGf9YnpCkqSSXX6rKrqgROizybV6WFQdceUBrFusZ88rmg6aEko VBAoF58NApFqsCqc2MKp3Bo1q40kI0TRhKOH0/TsSxD01EvfbhwcSK/eYkXG/hruMuQiW/SjilB
 5Ko8tKB8c++ooQI/fnY1q+c75h7YXTAN4XkIiCG8pS/jBOEjEOdcNYmwpHV7m2c4tMXSAhEnyV1 fdSI/ZcaKT3i7O2y9WxqIHcvVcG8vmp2TvgtWEcHD981l3ZAtkpQlFms9u+fjTj+kU+ZZXUyBBy 7sfkg5ljapue954Gek4hqKdigO2b+QKVR+dQrLw0YnFekrvRiEz6zpooKU82OdrOkkzT2DW46vA
 ZKfoJA4Lc/5cPkGsUXpuhNeENe6NXqqvrIvZPmXAm6/GBlAjOJjS/eNEbRolBRu0VZfrFrCB
X-Proofpoint-ORIG-GUID: eebGw0-E47brR3x86r9-jpNy_7XPur31

When we expand or move a VMA, this requires a number of additional checks
to be performed.

Make it really obvious under what circumstances these checks must be
performed and aggregate all the checks in one place by invoking this in
check_prep_vma().

We have to adjust the checks to account for shrink + move operations by
checking new_len <= old_len rather than new_len == old_len.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index db7e773d0884..20844fb91755 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1343,7 +1343,7 @@ static int remap_is_valid(struct vma_remap_struct *vrm)
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
-	if (new_len == old_len)
+	if (new_len <= old_len)
 		return 0;
 
 	/* Need to be careful about a growing mapping */
@@ -1443,10 +1443,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/* MREMAP_DONTUNMAP expands by old_len since old_len == new_len */
 	if (vrm->flags & MREMAP_DONTUNMAP) {
 		vm_flags_t vm_flags = vrm->vma->vm_flags;
@@ -1635,10 +1631,6 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 {
 	unsigned long err;
 
-	err = remap_is_valid(vrm);
-	if (err)
-		return err;
-
 	/*
 	 * [addr, old_len) spans precisely to the end of the VMA, so try to
 	 * expand it in-place.
@@ -1705,6 +1697,21 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 	return -EINVAL;
 }
 
+/*
+ * Will this operation result in the VMA being expanded or moved and thus need
+ * to map a new portion of virtual address space?
+ */
+static bool vrm_will_map_new(struct vma_remap_struct *vrm)
+{
+	if (vrm->remap_type == MREMAP_EXPAND)
+		return true;
+
+	if (vrm_implies_new_addr(vrm))
+		return true;
+
+	return false;
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
@@ -1726,6 +1733,9 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	if (!vrm_implies_new_addr(vrm))
 		vrm->new_addr = vrm->addr;
 
+	if (vrm_will_map_new(vrm))
+		return remap_is_valid(vrm);
+
 	return 0;
 }
 
-- 
2.50.0


