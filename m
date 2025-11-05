Return-Path: <linux-fsdevel+bounces-67198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9363C379FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 21:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2A7994EBE9F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 20:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC173431ED;
	Wed,  5 Nov 2025 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sUjOm1dN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WxVv3q+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BF25522B;
	Wed,  5 Nov 2025 20:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762373169; cv=fail; b=H0IyWeSI7B4D1FHDPOew8F4Ho4xMwRwU4/pGLUm3PjwFe56WaTYiqsAO5RP6hGEff61mHeM4suEqDtwCk+baCvD766yORnedRqAbncV7H4tvMi2fqeoii2yE3rG7D2tSURf/DXJhgxtuXOQ7N57SLFLAX2oYT05OAPufTBiEAzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762373169; c=relaxed/simple;
	bh=NXkS39eeJipMtaYWZxH9g4M4NrmX3bH7eTkpgn+hIWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HBpUb6/pPTOP+9zvEUjTDlbcAAb9c4BEPCSimQn+GWzqimb0H41VMjvuidqBWT2e/ErTNzB6zmLTQ9UhtISKUek+ZZ1geP1UWA++xkGe3zUd57RH8sIs169+0b9OS6YAmBf3k1svo3RfBeN1rJe4fgMPH1MLCH51u6R0MAY+HYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sUjOm1dN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WxVv3q+F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5HdYk9017434;
	Wed, 5 Nov 2025 20:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NXkS39eeJipMtaYWZx
	H9g4M4NrmX3bH7eTkpgn+hIWM=; b=sUjOm1dN0LJdat1AOSz1sA528opQ8MGEUr
	xXX0Qs+g9ayOdEc8NWhS1UGQTHnoHMp325463GFCxG6fEhIOXyHNIqOXaco4lvDh
	uQVTkmXKafj/HK1kmhGBz2nBZRLNRIh4DjKUr1BwYprTeKyGGHIn7MOvxhWUbAo/
	NDY2tSdeXnjilu/35zLbqw6/QfYS96YU/KTlt1ajdUZ3V0qWBhVe7eo+1Z0fidQO
	FHDG1oVJ8q9KD+V7bAojLJQXCJCyBbtRxVDdqPIJ4D/clhmKIZf+0s2GYlcRSHYi
	qZwqYi3GzXEDpMc8xpBkNQ9e10NtMGxpFkObtn7/rXxqnaIgYs3Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8b5yra3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:05:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5JpWjA002755;
	Wed, 5 Nov 2025 20:05:09 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf1nbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 20:05:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uKG9Y/PjOTEs1eqFUXnsZtAKSoSuK/jTbJMh+VPeqPNB5Y+ypXXJdGcBid33XROdwfx16SiGyySmUUN/kRHcTJTaJ0/uNYx8bpw8gafUY5dNzhv0z3hhQdYE/ZWv2DHL5bUNGHhi6W4Okom8WhZL77DuJG5gvF6BWTEt+/5x+FRDqb96c+dNlfiHap5B97y76zetfrB1dR+gZlcCDplZygWDo7L3D1jsg9Wm7TsC+OQQ+CT9JpvemoiBETrjHi8GcTOsfMw57CSYeay6H+8u2AsY44Roqd4T3EDkF1pNMCfKzmdQMNcw4uBH+gy6TeSs9854uOVrfdEu/116Oa40lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXkS39eeJipMtaYWZxH9g4M4NrmX3bH7eTkpgn+hIWM=;
 b=v3rr2uA+B8qVbSh7m8y9vIjLvkQs3HEUu0ZXGvdM9MeaCVvMSotBYCb5XHsRwGiuPpaiC37MFSZ2uCJLSRBdFyvdB6cNDIi4mH4xwfa91LmaXYif14mSy4rZrgZ7GtJEKd2Qwdqp6psbd5IZZDkzofvS3V+JYvl9pALO0TvKvrLzbis44MCd+go9B7CrPPKLM3Q8Hh1WcIA/TdhRRNjO234C80O6zbogwKmRHHHXRQtDp0du9Nc5OWgaU/MDQ7M7PlE3N9SnZvF6Ov5fL6MMNsPmRQfNd4lIyCdQVUhZCEA1MCK3x6yNkEycaWgJw0OJrfyko9sgdGoxmk7tEOyOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXkS39eeJipMtaYWZxH9g4M4NrmX3bH7eTkpgn+hIWM=;
 b=WxVv3q+F1su8ghxFdjp7P7ukHlFuCKg0CaH5BxBzqC94K9QZSqtVGqSWojjj/3+PPYr/X+ACGsTfyv8EsPsaHwSNq4/SQoFvmgbAsxQPmnvLV0AEWeb/wGlG04Jd84wRtKGFL6XOf42UvjCOMMyf6wE/RmM1nJpF+t8LXkpzoa4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB5769.namprd10.prod.outlook.com (2603:10b6:510:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 20:05:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 20:05:03 +0000
Date: Wed, 5 Nov 2025 20:05:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <fb718e69-8827-4226-8ab4-38d80ee07043@lucifer.local>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
 <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO2P123CA0072.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::36) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c348c7-0c07-4a42-7db9-08de1ca69b82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9wFRtcSELJiUNsQWqlaKy15+n1oipLijT6LqizPQv88BJB5NpZO2kS81WNT4?=
 =?us-ascii?Q?Byqeyp8KxwUVHkckzg6eENUi2u7UtEVcv5YpO/NCHzTOPAAGM5WaTVCy+uL5?=
 =?us-ascii?Q?UwRcKm7vXICpIQwrvVDnrb/A7nEqSx7hkYcHTM9Vf6CxoRRhiUmbNlhMRtO3?=
 =?us-ascii?Q?smkoTpwFS6pLe827vFNlGO73G9qbqymypAMOHAC7EBrs3bEnWX8Cj2La9yff?=
 =?us-ascii?Q?sNxag5EU8q0Erjf1qWw0AYpV1gtH1PkoJNzz/qa0agSA7lNq1xjxhMYj1sNg?=
 =?us-ascii?Q?1/bi6zjYYWts3q7o7TGfvdYnk2ePrbttECoTm9DTpsgh1F0fp7pJm7Lb6YMJ?=
 =?us-ascii?Q?mFceDISe0SYrsdEJxpu1cEYFkKEd6v2a1JpiEzOnnvc0gwoHjfvDQsh7Aozz?=
 =?us-ascii?Q?g+vugRe3KnXEhMrWfrWrE/xJI/1kz7BeZwivwacTV+mype4EQcyvrm/koAq3?=
 =?us-ascii?Q?ThbpQmiUFJOFs62VwsXQvHasqtC5GYUyYLFkoCBvxfcP5NBgPjbTzSecrnLe?=
 =?us-ascii?Q?nNB5K0OklSTs7ruqfcC67svBGFR0btxGm0GICM7U4e+rRCCK0PomKaU2jCgP?=
 =?us-ascii?Q?1l49zBKOPmv4B4gncG17I5hb7z6nO0jbh9hHHmY5K+kQVL6O8g3XzNuigH70?=
 =?us-ascii?Q?F+phI2ze8iQzpJyYQ9Iq7gumP+9a6NAepX/dQNa8HqiCMfRfP7lqzVh1LNXW?=
 =?us-ascii?Q?pk4XRtbZ5Lfk578VscTeeADNgQ2kvwEIkzuknqZDLzN38yHds4YMB8THWcSt?=
 =?us-ascii?Q?rit7/YkV90MhUA4kDTGlxYx2CFcE915cds8/lztaki9CH9JUcuAnqfW062bH?=
 =?us-ascii?Q?8dPkaAFv2y/4rOpstohqFcS+RMMY7SoCfEu4T1Q6gz/oJOdyi3mbSufCTDQC?=
 =?us-ascii?Q?nn44PittBnfm2cF06ldp8KRCQ6nQEiN/R10x6lfHzxhbNZD0TaRGMXUwAcNy?=
 =?us-ascii?Q?3pQbj0++GicMN8b6Xc9FED0pGm8OltCF5JAavoQJmDUXtJAjRUA+LLwZRvnb?=
 =?us-ascii?Q?mFalUFd0OG34F9TstJbXPUWWp4+Xh153n+6pBH1pZANGi7cuZ9met+6veUjI?=
 =?us-ascii?Q?P3mCBu1HWUB0+IYbDV6T5i1fqmuZNZjT+3p0C9fy7PrID/usfS21Bali3i/6?=
 =?us-ascii?Q?yATCiutl5XqYKTTOsxB8VW6bNHfpsE7Nqb5SbJPCWI+wjXW+OL9AO0G72D0h?=
 =?us-ascii?Q?6M3NMwdc0/DB1IHQ/+AzZPaz7RlkVLPCVYXE2URZ7Ke8Q5BE8Ek3CPmlRnfe?=
 =?us-ascii?Q?SSJl5q2h7TBZNUtZX7CMc0AwKRQF4xkmsC0CcKVSgRhbbgae0sGZojtyNawP?=
 =?us-ascii?Q?P6E42a/BIScNjgSZv+eC372lj4pH4hl2Sm1Fn+byM6yFrpopbXzeFfWc+41o?=
 =?us-ascii?Q?9Npz6MwzLXuDBWoNVCK2gzpeTAU42hzRo64qXHs3fyQ6EevYqJ3SQHwYnn2S?=
 =?us-ascii?Q?RwX62Je8ji29i7c7nJ69+RNnD28les13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NiQBQwK+PshjxuxZmv+NzwR+JW3PFnCgu8A7dxBDXGani6afjQaIFNSy3WJQ?=
 =?us-ascii?Q?ooEcm7P03CCAAl/cZlaRIDh9S5YHYz4M3A2kfwvj7MFPo2unqNP9R2DlmmIo?=
 =?us-ascii?Q?rqRAfiehg2GtDtKbus1/vb92OAKSmfKcR1p7ulKyre6jp1wl/U/EZuDiDj3h?=
 =?us-ascii?Q?6Jg88MugwQypn7AwpmkIL85IUwtfTjJqIEskzont9WDDESYiYWfqzDm6yFed?=
 =?us-ascii?Q?plLYMV/vnNsWitZJ/xwMkiW/M+cB8DItSveJk6KDuEtGwdEXCYgZqQFSD+gB?=
 =?us-ascii?Q?5Oif7vifs1dWkzx1L5S52sVhq2DPLvuJqbuXTT4abgYTLQ5ia+cmR8FfbRav?=
 =?us-ascii?Q?e/M/z/fbF5a5bMAga1AseOHiucpxVNOr9/jK1xjfEaLeC+7oOblfs3otyoO3?=
 =?us-ascii?Q?DbN02E8UTqhd0hfm9ZugDfwklPblgQVDwdnh6XTUnEBEFKIfpAlrn59jsvvh?=
 =?us-ascii?Q?R/jP0Kb3FM3XFVBfIg6m/B1FV1n5IOwp0/FfurTW9uf1EHZMM4zxg7hyDjx0?=
 =?us-ascii?Q?rxKgzHW1ifOik0q+tHuKTq4hRXzCtJNH9wkoswIot+2yUHiYIQZXl/iJbI7X?=
 =?us-ascii?Q?k6t3qIMkxyrmkHPndt2uxxMQv3j1I/GAKTlaw7cOV4l/yUnu7ELR/mhMUFSo?=
 =?us-ascii?Q?WQ605FRsLSXhCXQEqQqAj/8b/uJyRpsYrIVzcC+OLUP/qk+HpryNZOO6Bfx/?=
 =?us-ascii?Q?e6/IwyHLXnEn66aRqeZ8gdWBsLBs4etrszz0vrKuc8fPk+0GOuEew8RSAWgx?=
 =?us-ascii?Q?EJdIA9ZNF/xMdfBwHXDedNyA42SYRhloKMoz8urI11V+q2gopMFHt97Ao+JZ?=
 =?us-ascii?Q?KRZAgFzm/gy1zqqPMeS0HVZpZkxNhHPRuUskRO4b3Uat8VmrZr7Im1mcaTMP?=
 =?us-ascii?Q?nx8O7+gYjMiakkxSY/jPPOVDRVrnm06rA2xJgDCKNEC6fsoolhmTRP3nYUfI?=
 =?us-ascii?Q?Ntnet1UWMJCNVjEoA2kTRAMeA5Y7Sv9op1ld0fU1npQVIW9tgHC2HzSl2W1i?=
 =?us-ascii?Q?Tz3tVMoilCBO6aLgHtT5W50U1i8B2Y6y+l+vCmwN9Hi3h/4UWnL+NY6zvEWB?=
 =?us-ascii?Q?6b4WtsA7OkLEPZacuTDdUOEENtw351g/8ZPhiuYp6mcAWbAB6L5hGndXJ3Li?=
 =?us-ascii?Q?LDdKd9hSKI72oIMp8lMJ8gpiXv+hsWPfr9mX0b+q84l37080tqQ1jzw2v1GH?=
 =?us-ascii?Q?JupY1+UtCaREpxexui/yZfIA/73fcRg+EEYPMcpCnfNSL0fYfMUf2TZz1upz?=
 =?us-ascii?Q?gvj9haz14Hytrlbf2o9o5H+PmhbFAXxq3n36yQgIXLnqxeKQZ7Kkcjo7nGrM?=
 =?us-ascii?Q?AvZsu6UKMTacpzotIsw8PP8+n5WipAaVJFN7u9eFDL0n/Aozzskgmtue6DTm?=
 =?us-ascii?Q?vNV7RJCSRDUtndGcKxrSBWK7n/DiCwxgVUzC0r+CC0c6wkfvtlF+FDRT8MWk?=
 =?us-ascii?Q?/kwBF7Yip8BTbCdk/hnYctCtskJBGoXh+574O3t5P0ukY2JUzUPfcUMlYrJZ?=
 =?us-ascii?Q?9G9tdbugAxAvcp5ypTID+Tzs7XXOuWw+ARZT0mxYFPd4orYgKJk+RsT1LOMu?=
 =?us-ascii?Q?C9BnJKO5ZKaKZsXF1sWhn0qtaDA3cf8iTxFFPGhUrdWmdkg5IJIC7Fp/ZBqo?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jle4z/7FaQ8tuXP/FRlS1bFkw+UWdyZJFa2DIiiRx0EztBwL3ckMujd9NAlOxmL59LyX9OSus7vsHRkuWlcBar6aSnOqacwuDICPcPNS+BnqR0gXxOaIjJ2JRtGKADfjmY3nnpvboWdBJUlx25xL2slZJz6IY9P0mdRzkODIMKRN04kt5G+iHgpU7cFjjQ5n038ROeHvIVskViDGZTY6JeRPGQq5hCb9tEs/vuyioa5p7egU9TDFfqnR7vLqtm7RG3uqiUAMki4FqdJ/LNFVF9it9zYQZNnVBiPiBPfiYJIjHIq96nYuEfekSKcmgJkz8+uFvDdCsYZX87Ebkd6gy95Ukp4Tv+HrT9+zf/zXEUuwJ4ELjAD9Q4yNElZ+m/Qondi3SERv3iMqSPOjB4jnqlGc8rSJ51jeGUgiUc6GF7wMQQWH00f21fSUXsZGOSsvc1TTg2ngbSsYAEWu7Mi+Y/JYtmYwWdBlisfIbigPEWCxLwGdriCNDRgyXunk+YPBP+e1VOynbnpYymf0HTWXyfbjbCd5fLHadlK2wroqMzRXFGZoOblaShv7TAiYNVK6ieGPgA1jWVGGj/z+LCfPJ1VWlDDcm4hR4sxXqTgjevA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c348c7-0c07-4a42-7db9-08de1ca69b82
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 20:05:03.4043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xeJNzo5sfRPFSnVbI26EmLd0fXTM/AbKB31r5QTaiX0TfNYuPzX2uYDrBWgIA+6CQxdSHQiDrb2HJQwpBUy2QkXxCT6Fg8DXq4nxIJjpG60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=968 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050156
X-Authority-Analysis: v=2.4 cv=IcKKmGqa c=1 sm=1 tr=0 ts=690badf6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=4TGGTmxd0CBT_p7sECEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: uOasI3e8DvIUPvFktO5ujOipEIcl8GCE
X-Proofpoint-GUID: uOasI3e8DvIUPvFktO5ujOipEIcl8GCE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzOCBTYWx0ZWRfX/8IzXOjM21dj
 qBbcc247ArDBIgCTKzURCG9Loy1P8KivqyUUYv3L7EztYMlcrCsIQsk/+hBcN1/4pFFYYaWiByA
 pJnqoUYFtFGzRJLhk/8QvPVPxJzaZC1gLr9AOhKShlmfg+Upu3DslQhj5kxNgoVe9gIUlhV/e2Q
 JWMOt/Qj1kW6JDf62qnJNoWc8pNvBIlzrnQL7CcxwP6lD/EAvwi67TJrH2OYE0CFLJmAxD8KBzs
 geyesXPKOqVdRtuK4jnlRHMKpZnWTVROZMWGDdlIMcalWUrzNCe0eHMdG7PxC5Ph0IZCQyMckCJ
 Z0AxCRbNCZcExNWZRO93o6O585zuvWIt3uamBkq78MhIBv/+MOL6ZS7Pzv2N7mR0PkNJB/8LiGF
 GC6jQM8GTArTDS/njfYeb+5CyEpEoCyAvs1gH2MxZ81YVOMo+Lo=

On Wed, Nov 05, 2025 at 03:01:00PM -0500, Gregory Price wrote:
> On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> > On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> > I thought about doing this but it doesn't really work as the type is
> > _abstracted_ from the architecture-specific value, _and_ we use what is
> > currently the swp_type field to identify what this is.
> >
> > So we would lose the architecture-specific information that any 'hardware leaf'
> > entry would require and not be able to reliably identify it without losing bits.
> >
> > Trying to preserve the value _and_ correctly identify it as a present entry
> > would be difficult.
> >
> > And I _really_ didn't want to go on a deep dive through all the architectures to
> > see if we could encode it differently to allow for this.
> >
> > Rather I think it's better to differentiate between s/w + h/w leaf entries.
> >
>
> Reasonable - names are hard, but just about anything will be better than swp_entry.
>
> SWE / sw_entry seems perfectly reasonable.

I'm not a lover of 'sw' in there it's just... eye-stabby. Is that a word?

I am quite fond of my suggested soft_leaf_t, softleaf_xxx()

'Soft leaf' breezing in the wind... quite poignant no? :)

But also embodies both the leaf entry and the fact it's software, coins a
new term which is easy to figure out and of course the comment will
describe what it means, and doesn't cause eye fatigue? :)

Yes naming is subjective and hard, as always :P

>
> ~Gregory
>

Cheers, Lorenzo

