Return-Path: <linux-fsdevel+bounces-55284-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68644B093EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAE6F1C46C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A4E20299E;
	Thu, 17 Jul 2025 18:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xu+B5dJY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IlXFhuOR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5E31BC3F;
	Thu, 17 Jul 2025 18:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752777041; cv=fail; b=cAER2ll3hX6x23fZazYHg38JKcDvL2D5LnUlHhaCwalikeLq/Of37hyh9GBdFR2ZWjOLr6IXD5byHrrnyrqHypuUPr2XtzotVAFnASnGR2Ls5lnD5+rYS8/EK/rtcfG4VT1d8tLUjn+dSHZM0prdsyEL5JdkgA2yQ1f27ojZHBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752777041; c=relaxed/simple;
	bh=d+BhPakPkzRnIeCXj1puErccXYINrozd+TG5sdg57fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VZm4YCmkXHVZOAvjQCz1UO+0Ag2PByWTm3jiF/AoA7P9B7ndMVTylMRQ/SBoSxPi5dpKHshS9d1mxAOQNz9/0li5FmFhYupLVleaWJy07UIemE0lhJEeiWDEFcrsnrP5MGTx9D+DzpaHJ8cyiRJvgiT0+fgCuOeKkkzQKpBmv4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xu+B5dJY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IlXFhuOR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HH0hQU027480;
	Thu, 17 Jul 2025 18:30:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jCVErSjY9j4kFQZZhZ
	Jn1T4o4Xhqna9iwJ7QJxdvbnA=; b=Xu+B5dJY0rqxVbmEatL2Zk/SCsGCi7jAMo
	eEGAbrGy6TTrncddyttVXwhT5QH7PRVTwanKMzYNrRAcIT6/h1ItP/h5dkWfZEKA
	iYsCKTHID3EJ13oXlBH3Psqt2mG4qKxssN2P0kNz3mAz3Wsmv/OSoiiyV373h2EI
	UlTOm8fMUxAae2VT2tzIo8WMb9UTuoMAgyvauTAr/yPULg2vnyIlmnMl/CIhK4Mh
	WOSgduUvFNx7W3iZx5+/ceRErGjOv/YNO2KdteoyAbbjtPPdXDDaicdHD+N7g5St
	ZcYt79ASTJMIpXEe8zyItXkqsXfpo27+saF6LB1p0XJa0qQxlEoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk1b3rqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:30:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGwQVR011697;
	Thu, 17 Jul 2025 18:30:02 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5d4tmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 18:30:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDUwLNegLO3WA7ev2di7RW/Ze+OHAe2KsMagOR5sXAOG0YHmixySnOgeq4vDysIsqn5xAHmvGeuphumOUBMcjjQeERCgXr1yzWkzzUZCguNvd8C/0GVwh1MnyVw8QYSeZGQG7umLi+6frnST5hc09McIEIwbAZ+AwJlYr1uCMLLUA5bM12cHdQL6inIGuK4MmV5PPH55gkR3xtv+1tHBNEVn6v9EBMRPwQppmSYNOVSFu2BYW+QkyayAKBGB1bIjEaJY+BkqpoIdPTFt4gCmn8Y/iOmomMWMuWr2oUefBs1I1/z4F86Zsb6V2QwWelwMFI5O2Q0qI+0uBxVTLQjrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jCVErSjY9j4kFQZZhZJn1T4o4Xhqna9iwJ7QJxdvbnA=;
 b=esGv4De2HhYkE2sdKomGP5bxWWCEkGknwRbu01I+GzFxMgJ5b5Tv8efU1eubBGuuOJzdIJjr9GC/o8UZIGTOt3OPUAUnoIvUQvtMwlwSWozPtgiAQldjtDzWKJ6g49HpeX2v/cnR+XgseTEx4Qq8MeG9dSoSb+kJ/G20a2wVY3z107GwsCGbWvKHMENLlCRnQM3JvE9pzHU7fOEGOZcsVZGyexG3wf02VbkB7CL0DHcWsRwp3oyTjSq8KSFz+/LKSiXezVeOjTmMgKZTwP3GoBPyGdPZdFnNctHcWSFFwFzdbw566tUnDuKXyiVTU6f5XvGwTf3eP7Iq4cQ0VvBJrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jCVErSjY9j4kFQZZhZJn1T4o4Xhqna9iwJ7QJxdvbnA=;
 b=IlXFhuORjRtSAokVQQCv7rARKMO5xKUzKkCeiOpOZwyUNP1gTzHA+OHl1JuKd+EMFdLAB4mUY3LID5HY99HyUvXLeBytj0GP2EOMWQTmbDv0esp/PGpvwKwCmo1oncWVv8sfqPaEUab7NVZYkoSXlxa6/jnt9DlmwYxH2KNziN8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ1PR10MB6003.namprd10.prod.outlook.com (2603:10b6:a03:45e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 18:29:58 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 18:29:58 +0000
Date: Thu, 17 Jul 2025 19:29:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH v2 5/9] mm/huge_memory: mark PMD mappings of the huge
 zero folio special
Message-ID: <46c9a90c-46b8-4136-9890-b9b2b97ee1bb@lucifer.local>
References: <20250717115212.1825089-1-david@redhat.com>
 <20250717115212.1825089-6-david@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717115212.1825089-6-david@redhat.com>
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ1PR10MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 92932ffa-bbd5-4cd1-6429-08ddc55fef61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z/OOzy1ici6d48CfXV4ndQGX4YLevG1P1YmrqOdKMgbYJeEtxjuoKa7VCdPN?=
 =?us-ascii?Q?Wix2kMipLcooemHLbN/djIc8fS5iTtZNkkTFINyL8hbC9iMPWtQdOjjIITkC?=
 =?us-ascii?Q?+SJ3lifaNvvlRIjHuDBacOLPFCEeFKZU9x6LAuev7KEfO+4AgMn80O8YSvNi?=
 =?us-ascii?Q?TispwwgoedZSRYi5UOSN8cQhTRMhOrLn0N9u/6Pf2jk4440wI0Gp46PPanSz?=
 =?us-ascii?Q?wfCP4Px4P8jmo/cZMqfGd95NfTLS3j9FOpZnEzu+h/JzCSzNNM3rLzpVf7ra?=
 =?us-ascii?Q?gS4sff3Hf713VUQNraA+9ee19NNeh481LMFwOAD+BDqDvVY2jJZW4YMfdRUj?=
 =?us-ascii?Q?neY2cHGy6UgCpZ4eNkHJ20dEciynxszZvw5oRw8hDpqMpVD99RIUMCGUlQEG?=
 =?us-ascii?Q?Utt55wkrZwB8vijfoOeUcyq47SC3uOBPcUjkAQiXBwh/rcijSLO959mLH9On?=
 =?us-ascii?Q?To6Li2rAburMLln1rPSuxTI9hYaeYCdwTRP4tN7oOAowsnMvxz9qyYQIGTkV?=
 =?us-ascii?Q?kcOpip/PKLEOJHGzK7iWt4Gm3hKqqVarXIGqXDQS9YVHyvOYb5NMFxUgjk7J?=
 =?us-ascii?Q?ZU6j8GyAPte0TifcoPDE8E6j9PNId3kA6o0x8JgsLuiYICaoi53Dz1h+dj4w?=
 =?us-ascii?Q?r2E/ZHG8XyXWaiGp73ktX9rp4Ryub7BvFnqThXeD4NSzyr5mUxv2hKn2vkWh?=
 =?us-ascii?Q?JPGU87W8AXbIYm32nshN2DsWfjO3L1q7SMdeEEkauQUcmEB/7pRag5MYQhhh?=
 =?us-ascii?Q?IBZ7EAIVc01OJW2woWpuHPUZEhw9hDPcQ4GH76gQA7Oh5FfNPJwXhOrLHVT+?=
 =?us-ascii?Q?Xz9Gtv5NwYAYnvZVOdJiJbFPaYbK3C5HS1tcwzjw8S3m6HeEK7NVMHktODy6?=
 =?us-ascii?Q?x4NAIRJos6/1+t+jATqdY+TpZQsOAZSPA6y9H+Otkv2uNDgVNteidM4/yEy6?=
 =?us-ascii?Q?v8yn0dDe/oD6fkM1eKqJqFCb39Xi4EOtEOsPaBRW70IB8cY2vU0DNmfJ42E3?=
 =?us-ascii?Q?4bD7yCKjyfgXf2/Sqgj/GPhX19YM4mCtnPIsA2jmEo7d47lpYIMr5CnrvYka?=
 =?us-ascii?Q?UjRIZ2oQWvBXhJ90kFTSH5y2DiWgExHXSGqjFQ8AZqM63Bwd1l8fUrJR+lsf?=
 =?us-ascii?Q?B5zHn5O5DUdTglTT6/G+OAnfnH8Fq0e8iVKszJGmgpWPcaGKJRAJWjNUDokD?=
 =?us-ascii?Q?SQYPx37eXrKgpgS+ZPxb7kocXc1SFF40KJdmlpVtP8BFp54/aYFw9MsTHf04?=
 =?us-ascii?Q?loSH5lUsJUxw7qi072VWzhwgUOan4dKzbBvKO2bcCu5OtI2N42F1+uHXlw6g?=
 =?us-ascii?Q?/VSzB7I/h8NArAgOREMxh3gxB8pIGDYG3uLLxPVEJpoGc1tq4atB0vkcieuR?=
 =?us-ascii?Q?bOeKTJP45SqpypsuuEVKD2JnI6W40R1cm7TgIz/mrjg9eYq78s4baX12fSva?=
 =?us-ascii?Q?a7c/JGhfL1I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AieGuzgInfjR5HttSH1zrzh48dT8ae9m6bxGzLQc8zmUyHYaIWlqsJTjY3zD?=
 =?us-ascii?Q?j3Jfti0YhJBlMK9UlebFPr0qeFaz0nxAZg39UHwmIeZeHtbaiNU6eULJtmN7?=
 =?us-ascii?Q?h2+0rbbilozkcnKnH5UtsrdPDPdxY5lb6ak6oSE2YGMKn1FiQjqc2iucYczq?=
 =?us-ascii?Q?pDEM+pQVZnXwwfNVJdB+CSnn+3/LfvMKCDhJOn7HoJjAHyDhvhI+yMnWVp7j?=
 =?us-ascii?Q?K6XVyPXwckCO8swBuCZzCsE/RyGOYCl8WyTVI0cUO8XNbzHbxq853yH6NP6y?=
 =?us-ascii?Q?G9Ep1Jbq85qJD/TheiqOQ+0rf5rsH2BJYjUF49Ak2iG6dMqJHYSAD8pQFtQ9?=
 =?us-ascii?Q?XvwS5dcxfrcCoUbJ3bq5aQsSX8Z0x7fDe9mpsek43YUKjDReJyfNqgc1eDFc?=
 =?us-ascii?Q?2v2RxVa9QzHHd3BwdJKN8rXFwFjbyZ9my4uL6ovkBpyghxizRmY8NhiOrC1/?=
 =?us-ascii?Q?qCRvEJ6SUBFNKM6wtSLL3vVIxq+PncUnRkiflWCS5VPPIkoROWoH4pnEg/nY?=
 =?us-ascii?Q?ECvV0Hxbk3rrKNEw2jVo1iE+D8FqklfSlBdQHTGC8J2ysWMyc1NGVSne06aq?=
 =?us-ascii?Q?RgIkckEoQAvGH8LLWOk/Vqgb4Bg2LHCW0tKhlUNWewRvusUekeSHc1ThfWt4?=
 =?us-ascii?Q?lj1HHRqwivEeSnNiw1FbHAmAmRTKGyOB9IuHMiCUbcEljQ7Mt8Q5l4I7lzoE?=
 =?us-ascii?Q?4g/hihntaFhz2b5mpEE2El1GibUpTFg6+1OhH3VuTK8NulgVAcgTkddLnLDX?=
 =?us-ascii?Q?o/nJYOOOqU1fyMfnJ2SY2iPk5k9AdpAwmVuLgkH39uEKh6eKCe3BA2vPH84F?=
 =?us-ascii?Q?LgWRWHMgK0RDtdsBTi9cLIuaNujX2sxz4iCu6jWgV3MOjTuoZTEZxRGuKLv9?=
 =?us-ascii?Q?d1jg6NyNBQzyC3zxOGy9BKBmpZcXEYbx6zrTSRQ5ATXvymZ5uZYJQ84umiUP?=
 =?us-ascii?Q?CAxWxOgvIYmfzUd0ScHJI4oyelIo4khA54t2fQNGfJpubpjTZZqEIakNAuLX?=
 =?us-ascii?Q?hefD0DAoX/LENUDj/mdXJUySutjJlz9AeHupRszlLTdsLm+XZuXLx/GSfsLs?=
 =?us-ascii?Q?9iFK8QG5BHGfUvUg8GgnfRqWZtPNdZMw+bYTfyuhbQH3fDEnfFbTpzSfWrJk?=
 =?us-ascii?Q?qOYyap7T5rS5AdHw7F6nl/Ois9symvGJm4OSwzSVpXGB+IfkvOSHFNfG3F6a?=
 =?us-ascii?Q?UPoG00q3hEkXS4N3m8VCIbALq3S2xKWcs369CuWcbCxtFEO3MnwQlRrHBzHp?=
 =?us-ascii?Q?Xe0IVkC+2mVBCkUVAVKONCgIb0YPkBLX3D98CXnbMj9K+CJnxPgrq9ln4ZCZ?=
 =?us-ascii?Q?J2OE2HczrspLa49j0E3UrvtehLtwyypJw1lT0KHO8kLWpgOFS8GqF+OiYF+I?=
 =?us-ascii?Q?lTXTiJ1jvHy155yspdvJrZXhciNvU/vW9XLIiCqecU+d6rh3l3zX/dk6eoWr?=
 =?us-ascii?Q?hSvkSnbgyi7jwSr5AfBAyil1bKy6r5RnBR9nE5VrY3CmbI3DEyTqzUv+EalK?=
 =?us-ascii?Q?+arWBUXEeBMhk2h1j9o2U9XaIIwLma8Q1LHGkWBPzXQZRGhrae4bI2h4TI+l?=
 =?us-ascii?Q?BEjFReDUkr3JR+t7I6a695V9QBwiLjitPVW5Q6WgTFhSZ7XLgy1px/VEBDv8?=
 =?us-ascii?Q?Pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	spdu9VDNlzyRjfMSeHPGGHKIK2gTKLU3Qu/q62IjHS8wb+rcDIcNeHSA4CImIbdJFYL6/wdr5DGbEI5KhP7GIMTeC6QWSkP0hmMIkBxW6iYFbK24rK4QZheFBWCShhjSn56nYuKSX2qhw10ngYIAh2q28qlLXrNq0Kvde9RhGMoV7S6DCKdJO7sNadvMKZjL2jgEtxP6bD2JXamrQ0aAESboaTjQgqKxzDjzoXpM29Nkkl+8Ye2BPdSdBWF2lhL5s91AcGBwrbVvBaa2zzGmjOPfyNtqguD/TPLe2IOsggjri8zuZftBDbvlzptgJoQcFJTPWspNJdAtjxMa1JuDEWZF40JSD2GlYBv2fe/BaUXfLJXeWfRn65rk147+MuMaZTlpk5QSiSS6akNSZJ4iJeNvgzXGAJ8UoiN96pD91gIMrf3joxHRbBDYALO8ztL9NcvZQvb9XrACSQOGeb3PpKi9m09VSVfX4HSyZU2EaG4V4MoHQrfgMYqYjrkAUW9lCAwuGCyIJZTiKdgIBEGRazTT334RcUdTahT50Nf5LeOablafYj41wuJFJuya99sEe0hHCw5EMvsS/zHFWGQDEucw3y8xYINt6zsalz2rlPc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92932ffa-bbd5-4cd1-6429-08ddc55fef61
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 18:29:58.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUiQNQqwTLadDSu0aNmOgERetYJFkEI5ypnBJCi4PNlxmjaFxJAUoGUxGhbNy5SaYs/ecVcX9685I8U3chHanMkVpq348MiKvlkx7zyl5NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170164
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE2MyBTYWx0ZWRfX64v4kNMaEMa/ USq/ZNIk8I9xfyGWGTN/zmg5u8J0S0HmRwdm6o0BJAMn4oJaRld47Owvsnt6xGjNxg8fSNNlOKj piSvi4T14+Ls4Ed3TO6eciiDQ2Xl4zjWDkGubE0zZblqcERvdo9V3M2P4seloEzbFMV9JKB3rrx
 Kuh8cMLQlpczduj4hUdvtKKN9cZdjH6ay2XRijOso/vTefnll1yesF29w4WrlbMaKdzdN1Go8Xb Vr97fE9pmIwnMWTONnAm7BgXb2PhYTa5X4H/ob7ivVLtg2YnDCXwgFqWGodx+Lk3EXpDlv9lEsU V9H4Oy74O37NpXcyEWI+AKpSmPHhxcf4i+Dxyq6tZQVytLxWo3Qkr17S8QrOEW6/wua4kQFqc7Z
 twOxTuQUWiKIPnSuOQui/1gmKvMav/jZHiVUvD9Qo1lap9FwhSezMScxcXvJtG7ajhqO9Kmh
X-Proofpoint-GUID: xNVMpZd53jc4LKesR0lqIi54vB6JW6FT
X-Proofpoint-ORIG-GUID: xNVMpZd53jc4LKesR0lqIi54vB6JW6FT
X-Authority-Analysis: v=2.4 cv=J8mq7BnS c=1 sm=1 tr=0 ts=6879412b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=NB37xtsDAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=jxEKDuIVVPS2-SOLZhgA:9 a=CjuIK1q_8ugA:10 a=IlkzfGtsIyjWS4YjqO81:22 cc=ntf
 awl=host:12062

On Thu, Jul 17, 2025 at 01:52:08PM +0200, David Hildenbrand wrote:
> The huge zero folio is refcounted (+mapcounted -- is that a word?)
> differently than "normal" folios, similarly (but different) to the ordinary
> shared zeropage.

Yeah, I sort of wonder if we shouldn't just _not_ do any of that with zero
pages?

But for some reason the huge zero page wants to exist or not exist based on
usage for one. Which is stupid to me.

>
> For this reason, we special-case these pages in
> vm_normal_page*/vm_normal_folio*, and only allow selected callers to
> still use them (e.g., GUP can still take a reference on them).
>
> vm_normal_page_pmd() already filters out the huge zero folio. However,
> so far we are not marking it as special like we do with the ordinary
> shared zeropage. Let's mark it as special, so we can further refactor
> vm_normal_page_pmd() and vm_normal_page().
>
> While at it, update the doc regarding the shared zero folios.

Hmm I wonder how this will interact with the static PMD series at [0]?

I wonder if more use of that might result in some weirdness with refcounting
etc.?

Also, that series was (though I reviewed against it) moving stuff that
references the huge zero folio out of there, but also generally allows
access and mapping of this folio via largest_zero_folio() so not only via
insert_pmd().

So we're going to end up with mappings of this that are not marked special
that are potentially going to have refcount/mapcount manipulation that
contradict what you're doing here perhaps?

[0]: https://lore.kernel.org/all/20250707142319.319642-1-kernel@pankajraghav.com/

>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>

I looked thorugh places that use vm_normal_page_pm() (other than decl of
function):

fs/proc/task_mmu.c - seems to handle NULL page correctly + still undertsands zero page
mm/pagewalk.c - correctly handles NULL page + huge zero page
mm/huge_memory.c - can_change_pmd_writable() correctly returns false.

And all seems to work wtih this change.

Overall, other than concerns above + nits below LGTM, we should treat all
the zero folios the same in this regard, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  mm/huge_memory.c |  5 ++++-
>  mm/memory.c      | 14 +++++++++-----
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index db08c37b87077..3f9a27812a590 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1320,6 +1320,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
>  {
>  	pmd_t entry;
>  	entry = folio_mk_pmd(zero_folio, vma->vm_page_prot);
> +	entry = pmd_mkspecial(entry);
>  	pgtable_trans_huge_deposit(mm, pmd, pgtable);
>  	set_pmd_at(mm, haddr, pmd, entry);
>  	mm_inc_nr_ptes(mm);
> @@ -1429,7 +1430,9 @@ static vm_fault_t insert_pmd(struct vm_area_struct *vma, unsigned long addr,
>  	if (fop.is_folio) {
>  		entry = folio_mk_pmd(fop.folio, vma->vm_page_prot);
>
> -		if (!is_huge_zero_folio(fop.folio)) {
> +		if (is_huge_zero_folio(fop.folio)) {
> +			entry = pmd_mkspecial(entry);
> +		} else {
>  			folio_get(fop.folio);
>  			folio_add_file_rmap_pmd(fop.folio, &fop.folio->page, vma);
>  			add_mm_counter(mm, mm_counter_file(fop.folio), HPAGE_PMD_NR);
> diff --git a/mm/memory.c b/mm/memory.c
> index 92fd18a5d8d1f..173eb6267e0ac 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -537,7 +537,13 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   *
>   * "Special" mappings do not wish to be associated with a "struct page" (either
>   * it doesn't exist, or it exists but they don't want to touch it). In this
> - * case, NULL is returned here. "Normal" mappings do have a struct page.
> + * case, NULL is returned here. "Normal" mappings do have a struct page and
> + * are ordinarily refcounted.
> + *
> + * Page mappings of the shared zero folios are always considered "special", as
> + * they are not ordinarily refcounted. However, selected page table walkers
> + * (such as GUP) can still identify these mappings and work with the
> + * underlying "struct page".

I feel like we need more detail or something more explicit about what 'not
ordinary' refcounting constitutes. This is a bit vague.

>   *
>   * There are 2 broad cases. Firstly, an architecture may define a pte_special()
>   * pte bit, in which case this function is trivial. Secondly, an architecture
> @@ -567,9 +573,8 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
>   *
>   * VM_MIXEDMAP mappings can likewise contain memory with or without "struct
>   * page" backing, however the difference is that _all_ pages with a struct
> - * page (that is, those where pfn_valid is true) are refcounted and considered
> - * normal pages by the VM. The only exception are zeropages, which are
> - * *never* refcounted.
> + * page (that is, those where pfn_valid is true, except the shared zero
> + * folios) are refcounted and considered normal pages by the VM.
>   *
>   * The disadvantage is that pages are refcounted (which can be slower and
>   * simply not an option for some PFNMAP users). The advantage is that we
> @@ -649,7 +654,6 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,

You know I"m semi-ashamed to admit I didn't even know this function
exists. But yikes that we have a separate function like this just for PMDs.

>  {
>  	unsigned long pfn = pmd_pfn(pmd);
>
> -	/* Currently it's only used for huge pfnmaps */
>  	if (unlikely(pmd_special(pmd)))
>  		return NULL;
>
> --
> 2.50.1
>

