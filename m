Return-Path: <linux-fsdevel+bounces-67767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE23BC498E4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 23:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F633AF9A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 22:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9BF346A16;
	Mon, 10 Nov 2025 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZGz0UZWF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0F4kRLid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAFF7337BAF;
	Mon, 10 Nov 2025 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813466; cv=fail; b=KOqqHtBVTsc3+xa0Szqfz4Q0zlodfdzaBJ4fGWEvtMjX/SvbUh3dToxjt3HadJAIXUPzXmBElbZFLMyJ8A0zfiOHAqirU6Tb0JFALQBBHcXqwRCtvH7S3+2sPAl6V4kocOzfhtOYg2Tr4/M7tMwQedsP+mCOepn8LRb5MalbD4g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813466; c=relaxed/simple;
	bh=oxEdzxGrJWd6pCTi5NwurPb3nyfqg6tRupFAuDaPM60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4K3+QukiSKMmIB3euudTKOBv5/E5G42urAJxB5BlfcLSEMHT/D/hHIb3m/i+sgc4aTCHF590EPlsByP28L/ZQ8AYNJMf3t8QeR2MguSq7422+QkCzYQBYwChdwBbkk43YZN4m1x6u1R34OfDX4rjtrApXQbFq34uyztNby9thw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZGz0UZWF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0F4kRLid; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AAL8d3I009183;
	Mon, 10 Nov 2025 22:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GuY2tVtboAEPardNoS8eL6m9Qb5SaAi7gKx5ePxzR3o=; b=
	ZGz0UZWFJM0VU4Wgfm5nAnVKsMJOlrZ0skPcSHmWSsX+RRNl0h0j/oYNJCdZXh+q
	n73El4+2ljdk7iK/x86xrmfjBX5CTcyRqiEfnjvPgS0bFtS5x6PKGGzcIcYrJmnd
	48mc7eUfVo8Sdc1XQYmgctDrLNLTyoGN5PDC7KviQplc6qR9VYFfGdvYvt/iM9ut
	7bb6WQQ6LbHDjdZQLD4ws7sjhjsFB+86Z+K3WhYa6QrztGlbzoot8E0WM+WzOY7c
	Dmf2ol4Vzf6Ut+mdLDsDODGPf2rJSSkGwYjwtBre7GU+wwweGsGTcBnv/F1s9pCH
	XNr7ygzX20852cCzWs+Cjw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abqpug5s3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AALo2I8040096;
	Mon, 10 Nov 2025 22:21:54 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va8rypg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 22:21:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nRc3he5gR/IEnRvew4hf3qj2/HiJ7fVdHe2AoECXTlDASHsjcbbIrqT6OarxYc8Fm2NkoXJwekcpy+0raZgECg+a/VuV6Tr52fNnWHQSDXtLIQq32/nJEvc/n2xz+9UHWEdHXP7y+ln13Q3V33ED5b+0npPcsOoG9q0nT5Ct1Ti35lL0lUZNYyECFLAeWt9rrL0lqBTG40d8Kd54AoK8rVce2RAidQe7BFHps5i3yf14zMuij4Dug+hJaZH46tzrzo2QfpO2prAmBcQGQiG0xSpXyUNQbBVDIjAADexlriCO09gNUud4N85WItTpuqFsr8K+vSCIIi/PUyi0AUOJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuY2tVtboAEPardNoS8eL6m9Qb5SaAi7gKx5ePxzR3o=;
 b=SHXHy0OrRij7NyO2ewNia5LCEwPaPeRVUPdK/7nzcLBN+L7pKYGDj89uCHZ3GS5vM5dQ5bNCuRD7v5u04F+hMdbsgETqlfiwTKHPtEodIb1d0WiaMwLC9c2WV3OG+qbqsvqUJfkizY+iKAvxSh12wpt3ukNol0FRRnha2kMPWwcpsb8vo0g622ohysjS9TRwHIxZx28VtbRHlvKi8VI6Rfgs+qQftBgEt+fElcA7DFsxwTyHxB17ZF6r4/DtvU0c/u16wvlA3cFLnazk8BzqMcnaNLHeeBL2l42HhHxfwpPV3uCaYy6oIChXP6jfa5K1wbgKpzBz4m8nDApM1amrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuY2tVtboAEPardNoS8eL6m9Qb5SaAi7gKx5ePxzR3o=;
 b=0F4kRLid8UsSzQc0RPYnEiJJbqeu/S39y6Tf/nl4UZg8+QULS0lZelpgu0ezrUD1KhXYc03RlwdeUp4iLcXj1jL+29/It5nLNN/iVgTDM07zfVj6AGD0JgKsg/xTRdkJZBwInzsJv2qWGxKa72KHM8bpCWacrkM5pmrm5ZvQJCE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 22:21:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 22:21:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
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
Subject: [PATCH v3 06/16] fs/proc/task_mmu: refactor pagemap_pmd_range()
Date: Mon, 10 Nov 2025 22:21:24 +0000
Message-ID: <f9ce7f3bb57e3627288225e23f2498cc5315f5ab.1762812360.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
References: <cover.1762812360.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:b::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7622:EE_
X-MS-Office365-Filtering-Correlation-Id: aa9510b9-0c33-424a-5667-08de20a78b6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p920Y/VbKyjo4rWlfSlNEd45F56UeZ0T9BoSyiMfPC36y1J/0LMCn54eYt5U?=
 =?us-ascii?Q?JOZyPnwhnitrwFLshRHRtiGfBoDJk08irHQ0gFITvlB4tAPKVGejn+zQF2Vd?=
 =?us-ascii?Q?X5ppfAjq+1UTjrcjwnfYIDvd3qA6MhWvJeeHTaMMdTn3dGRZvvnYqXE/4rea?=
 =?us-ascii?Q?uCrJyeGehTCUQ1ISC4tGfKYj+5LxsVjedYzv9zcxTSkhriiHHDwr97CqgdLg?=
 =?us-ascii?Q?smPfUhvQH/Rxr7qeHN2WhtOSvb1ZQp1NsglLbJhCStCSaH9+nsDouhaoPcx4?=
 =?us-ascii?Q?xynZQtEKVGU92Oo17tgGr78RUEjHn25l4I3qtJ+Sc6p4T1ukG1Lm5g8yrtmR?=
 =?us-ascii?Q?B65mZYxN/+njmgfQO8nHPCRkCFEYB4zHJvhgHfw36DisF7Zrt9YkZODjSSaQ?=
 =?us-ascii?Q?w7BJiPrccYDIUJoN8HbionRdl+vGbyfKcHUkO55HtNsHFeroSAsA6BWTTkij?=
 =?us-ascii?Q?0FH3TqoLqJVkrzmMTn222OgMvWblMq6ODk7NXGEfhfOvS5iikRaKHhdJPaRv?=
 =?us-ascii?Q?YS988OdCwY2AouymNCXIo7K0jVyl/Dmt9ioc/dnkYj5Om7kj9DtqETdBq9kw?=
 =?us-ascii?Q?oErczpHei1Oz8Kj7PiQGk3Jdu2NZhsGJcnzYsGYW6KZGRNbumKtiN5yiWwje?=
 =?us-ascii?Q?AtP7NwusfytLz9DKkN4r0TQpbtKkEjWYklOMNFCNjQypZFlwf3dpjuqo5bOM?=
 =?us-ascii?Q?7Q9HP6izSF9NS8QU75SrkuPezJKCCJWkSnwrcnyD5w7wjWtYh8bx7RnC+K3I?=
 =?us-ascii?Q?FvuCQhmT6QmKhErj/JmDO0mXeXq+ne+jV5jD/n08aboX0rYXoyR0FUh0f8zG?=
 =?us-ascii?Q?4ZpDfbQ4xV7X5XU4F5egunfn6x0VFTfC5VYNjplSvU+MYJLHMaC0OwLOBp81?=
 =?us-ascii?Q?5tvi1O1fmT+eSRXK89DXbvuN//GF59kMSuyTjV/xDCVC2EuIvzBmpH30NpgF?=
 =?us-ascii?Q?NMEHJ0LLt8EuV0RniV284OPmIpa6gcYBRszRlq/2JKFkJA6ZNWwvTJ9zJojA?=
 =?us-ascii?Q?P0CjgiaGi/OJptZlzp8eAshA9T6bzOV3TwXn0apfF6ZEAjY64hh9SOQeTkHx?=
 =?us-ascii?Q?rAVy2cRFOKsA42OCsdKnpTdIjmbp4ImEQM55cLdLnxAxbh1uPsQU+qPtPbeE?=
 =?us-ascii?Q?GXnKkfXam1zKqb5wtvyeen9y/DJ+exqpfyv6Z6lx5D+6kyVy0TFMHbYcNbxs?=
 =?us-ascii?Q?kFd9woQ94W49eyTXh8kBfS1qnmuE/lJuakRwWOELLWRG0wAgSUtp833aGo7e?=
 =?us-ascii?Q?l5YXJIH/35VSX4xtEL9xtLQP0h13ePuCP5vuV3GFcvhcPzSURJ9IwRQ29KfI?=
 =?us-ascii?Q?btaT6zilfDeeaD/dwOuV/ZMm/XhsRUtf/23mWquPKr+3QwrwtJhp465Aywaf?=
 =?us-ascii?Q?UQ4bE8soYWoMx52OhFPfXO+QAuFgNGizr+SuMHmG9uMwDtHsgcfo3TDzijpb?=
 =?us-ascii?Q?AUpBexuUirkAX5Ar1zaitaQMAn3TcqO3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JOmedkeX/n+YM7fJh7RVABnEpuEJq+s2ePUGaGbYoWbt7IZwkUxgPP8E4c/+?=
 =?us-ascii?Q?4T8tQsTaRpz2iIrxdFjUyOZdUyUzY/PIHAhcTk2VD5xCmY4+eA84ExE56nQa?=
 =?us-ascii?Q?AlP2ewLC1m3bTfhu2YstQwauTzAZ/DiRYlVYNnfqx6ALHAmRpvZEeWCVHLsi?=
 =?us-ascii?Q?0WXrGehY26aygOmBAiB1ELHX1dL433l8V+O3hsnzC+O785ikSHatJxnqJhTQ?=
 =?us-ascii?Q?nS0J0Ev6aaS+JNqXqfXAjyJAleUisMSrLNxpyCHABVrbJ7w/M55AklHT5njC?=
 =?us-ascii?Q?cx3BGaI+3bA6Fq7PV+Kgr8YC8cF7/ZqEr4AWCZMdPilWN+VUOyHnVEQdpuOo?=
 =?us-ascii?Q?bnUAJSrhWnNSuuGt8ua9RBaz0WPquYfWE5NEZhF0yBMzz9SXCq1whFl1GGby?=
 =?us-ascii?Q?IW3MLqBGjDgby2zdMeSjuMvmbWDobfwwjSK9sOG4VkPrg+tshakW64AwbiEC?=
 =?us-ascii?Q?mhqyPiPHQT56lB4ukQ4yz/NiaDk38ofnhXbO+cnTs8By+LxszqK6mv0eCCOI?=
 =?us-ascii?Q?Pobu+mTYZ4ChEpA1IDPxYV2cYZA4RDZMIyxq9ANJ/VMC9L/NwNiqDYgF8BjW?=
 =?us-ascii?Q?/D5RscGyC7dqDu63EsWCEgxYW7MKU1d/aceRIJLIRGU0SUHadIMEy7s1na9L?=
 =?us-ascii?Q?7qx2s485idZyt1QhPpL0lXNIfnsBJfxzSCpK3o/sI0hqKQRdkM2htP7L4pZc?=
 =?us-ascii?Q?lyQRQUMHo2Afu4g6mILGnaYlOwRAg7KAze+lHobZLO4J3ibx4C9eL1BfFq77?=
 =?us-ascii?Q?zDUGnInbHtr28fFOo5QvbDxFMBun5kyd3dtbY7empFnfvqHJ6peQ2oGQkfxf?=
 =?us-ascii?Q?Xnxzud9JfbcoG0aOmIcnuMEMGZlxLGPNP+pib69JjzDOtLOPY2A5+hPmCDPN?=
 =?us-ascii?Q?uDkf3xn4uJ9LAAEvcGcHdlgRyHDY/EcFiAjuYpYRIHB+SG5BDYoMOXZTDTwH?=
 =?us-ascii?Q?SCebwQ1nPDRwBlmJHj7bFLNRLCVDJH3J7uuNlHEIK1RKbr1MSm/rm1JUUvE5?=
 =?us-ascii?Q?UqDTPbVvE5qD203gobJfJ7q4/nzfoPCZScijy/NgwKfyfAsv0Vg08a4zYKX4?=
 =?us-ascii?Q?QE9eRB0eVevDEkGmc0UDf7PI/wMIvRirwdykPX9Y1xxjTk5ylGtdouJ2qS44?=
 =?us-ascii?Q?wiSmtlVw9GqldpHKY3PTnCMTCWE7yFXhy2M52n5QVFKmVXP5ahu3Euhz3WK6?=
 =?us-ascii?Q?xXGlNHTxZf1Egj8rOLhK8iClMjovh1rgeGY9gBK/nSCgGKKDlsaF7N9tzo3C?=
 =?us-ascii?Q?sQxgyQF7uzGmbYZVjLfuwNGVSuJwBt0xtYLjyrGwbcirpnqCP1Rvlic3nOUx?=
 =?us-ascii?Q?2BAxYPuBPSalKBsidYv/rjyzytXsZct6G4LKfsAtE5s46Qto4eU5vp59bTtY?=
 =?us-ascii?Q?a4goYBcH0KB0qkH3iUG1hiNJw0K4Y3oqx1PSMwYgV0143Lq61QG/yQ0bzbrB?=
 =?us-ascii?Q?JigsjbeM2E3ldol+hMXO0HuBFhf1xs2gvMb2xLxo8ENUI3mjBVj7laer+umu?=
 =?us-ascii?Q?1VFEZK/dWsgHSSiCdEo0DnuBpjyE0ItZS/PMBVuZL6YR2wY1qtpWcbamAWhf?=
 =?us-ascii?Q?5BH+iOE1Bh3xw6XP4doLvgEcgnUlE9Jh+fUOrhV6morBecCN8dIIwD4QznA2?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6wvzntT0VGo5cIrmfs457FdgMfq2Emazd7ngC03DCes6VVLLVVf2OZ6a6NCdFhTF8RuoFCaLJEXa2b1nKHtop86S9zyF961rXiO+8Hmpi3j4y7i9LZP+m5xSR0BzXA1lSJTVFdmTFpv7cHLFl4tHBNta55ZjUzvimV1Uques+4VXSO1qT3z5bc2e+oTQ8iP19uLXMg2L2g9CUx5dKxqEJnKpwn0xyQFbLGsQy8C8yWLF+DgEvEhHUnMzhXFR+I8OZJRoXcaXKIL+aZeBokxRyYiJ5q4OkYc8eIlUQmSSXojzy1+8x1uUC3RAjUBlS7OW/060Pf2NyBuUXZQg4R5C+fymTzYnQieTSEolZRwn3132hR84GU6dOepE9VQreJ7wgkYbLv7ov+7OQ2urToDIiW50MUOONKMYoTyDa37qWT1wtC4tCHMedhqCAUlD3ZszP6IkXnswr6jU57Gl6k0dcVNTdENGjanU8XDMc5lEXCgbza59M/SzjlotOOrDJglUAeN48TUtJLbl9r1CEQJsODaAw1zKy6ifQTJGhSTBUO8aX6J7A3pm6UJGH3wXoNrKkfeSlwYJ8skfRiDZdi1IPy1R/XzRVSEX6QJ5Xqad/yY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa9510b9-0c33-424a-5667-08de20a78b6e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 22:21:50.4669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFp76T0bpmz4L5PsfzGaKrIvjfiliksINl2hjs+/j0Hxgt1miSAnGYFMLMWljl36mwK2axA2ZvVyazn1XYJ9T6cz69gXf0/JNAv0UJTGoVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_07,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511100190
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDE3OSBTYWx0ZWRfXze5O4FXLhfkl
 5Lv6/Lgo+/hophBFGpJoT3m3aQLgVuhPjC6HQV1kcpM6q1V5RLGY2YrH4KCC6p6IgNexivqHiVZ
 Z36rH+uCbinNwXDDxis91J0Ml0cuNXkMYata3PerEhaReSeza6/yN9++xaMdtLsFyHkP3Qengcx
 nLzb0Q+sHagzzhdmW8paAw5DxBBkYQwtnp5vS/zRPguF7Y71rj+JBUuAmbmFP+eEccSyXzPmOmX
 38dSj9AT6+QEdGX80IS+nmIrVUIUDdmvuMdxMih8UEBZDP+ypPOTDsNXsv1is1e07kU+yVHIY7+
 +zedOUPtKaslDGzjBW8yBNwiAWmlYTvzxJRradM1rfTqB/p9bpBCgMbMoC4TnqLIGF32KEg6KU3
 3vpaEjdWE33uStbO3QHkLOfZAmhb0A==
X-Authority-Analysis: v=2.4 cv=H5rWAuYi c=1 sm=1 tr=0 ts=69126583 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=r4PJAH3pRi85-HfG15IA:9
X-Proofpoint-ORIG-GUID: cvej-drcshnieka4Fs_gMFCcwA7JLDWR
X-Proofpoint-GUID: cvej-drcshnieka4Fs_gMFCcwA7JLDWR

Separate out THP logic so we can drop an indentation level and reduce the
amount of noise in this function.

We add pagemap_pmd_range_thp() for this purpose.

While we're here, convert the VM_BUG_ON() to a VM_WARN_ON_ONCE() at the
same time.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c | 146 ++++++++++++++++++++++++---------------------
 1 file changed, 77 insertions(+), 69 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ddbf177ecc45..5ca18bd3b2d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1984,90 +1984,98 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 	return make_pme(frame, flags);
 }
 
-static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
-			     struct mm_walk *walk)
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
+		unsigned long end, struct vm_area_struct *vma,
+		struct pagemapread *pm)
 {
-	struct vm_area_struct *vma = walk->vma;
-	struct pagemapread *pm = walk->private;
-	spinlock_t *ptl;
-	pte_t *pte, *orig_pte;
+	unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
+	u64 flags = 0, frame = 0;
+	pmd_t pmd = *pmdp;
+	struct page *page = NULL;
+	struct folio *folio = NULL;
 	int err = 0;
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
-	ptl = pmd_trans_huge_lock(pmdp, vma);
-	if (ptl) {
-		unsigned int idx = (addr & ~PMD_MASK) >> PAGE_SHIFT;
-		u64 flags = 0, frame = 0;
-		pmd_t pmd = *pmdp;
-		struct page *page = NULL;
-		struct folio *folio = NULL;
+	if (vma->vm_flags & VM_SOFTDIRTY)
+		flags |= PM_SOFT_DIRTY;
 
-		if (vma->vm_flags & VM_SOFTDIRTY)
-			flags |= PM_SOFT_DIRTY;
+	if (pmd_present(pmd)) {
+		page = pmd_page(pmd);
 
-		if (pmd_present(pmd)) {
-			page = pmd_page(pmd);
+		flags |= PM_PRESENT;
+		if (pmd_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		if (pm->show_pfn)
+			frame = pmd_pfn(pmd) + idx;
+	} else if (thp_migration_supported() && is_swap_pmd(pmd)) {
+		swp_entry_t entry = pmd_to_swp_entry(pmd);
+		unsigned long offset;
 
-			flags |= PM_PRESENT;
-			if (pmd_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			if (pm->show_pfn)
-				frame = pmd_pfn(pmd) + idx;
-		}
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-		else if (is_swap_pmd(pmd)) {
-			swp_entry_t entry = pmd_to_swp_entry(pmd);
-			unsigned long offset;
-
-			if (pm->show_pfn) {
-				if (is_pfn_swap_entry(entry))
-					offset = swp_offset_pfn(entry) + idx;
-				else
-					offset = swp_offset(entry) + idx;
-				frame = swp_type(entry) |
-					(offset << MAX_SWAPFILES_SHIFT);
-			}
-			flags |= PM_SWAP;
-			if (pmd_swp_soft_dirty(pmd))
-				flags |= PM_SOFT_DIRTY;
-			if (pmd_swp_uffd_wp(pmd))
-				flags |= PM_UFFD_WP;
-			VM_BUG_ON(!is_pmd_migration_entry(pmd));
-			page = pfn_swap_entry_to_page(entry);
+		if (pm->show_pfn) {
+			if (is_pfn_swap_entry(entry))
+				offset = swp_offset_pfn(entry) + idx;
+			else
+				offset = swp_offset(entry) + idx;
+			frame = swp_type(entry) |
+				(offset << MAX_SWAPFILES_SHIFT);
 		}
-#endif
+		flags |= PM_SWAP;
+		if (pmd_swp_soft_dirty(pmd))
+			flags |= PM_SOFT_DIRTY;
+		if (pmd_swp_uffd_wp(pmd))
+			flags |= PM_UFFD_WP;
+		VM_WARN_ON_ONCE(!is_pmd_migration_entry(pmd));
+		page = pfn_swap_entry_to_page(entry);
+	}
 
-		if (page) {
-			folio = page_folio(page);
-			if (!folio_test_anon(folio))
-				flags |= PM_FILE;
-		}
+	if (page) {
+		folio = page_folio(page);
+		if (!folio_test_anon(folio))
+			flags |= PM_FILE;
+	}
 
-		for (; addr != end; addr += PAGE_SIZE, idx++) {
-			u64 cur_flags = flags;
-			pagemap_entry_t pme;
+	for (; addr != end; addr += PAGE_SIZE, idx++) {
+		u64 cur_flags = flags;
+		pagemap_entry_t pme;
 
-			if (folio && (flags & PM_PRESENT) &&
-			    __folio_page_mapped_exclusively(folio, page))
-				cur_flags |= PM_MMAP_EXCLUSIVE;
+		if (folio && (flags & PM_PRESENT) &&
+		    __folio_page_mapped_exclusively(folio, page))
+			cur_flags |= PM_MMAP_EXCLUSIVE;
 
-			pme = make_pme(frame, cur_flags);
-			err = add_to_pagemap(&pme, pm);
-			if (err)
-				break;
-			if (pm->show_pfn) {
-				if (flags & PM_PRESENT)
-					frame++;
-				else if (flags & PM_SWAP)
-					frame += (1 << MAX_SWAPFILES_SHIFT);
-			}
+		pme = make_pme(frame, cur_flags);
+		err = add_to_pagemap(&pme, pm);
+		if (err)
+			break;
+		if (pm->show_pfn) {
+			if (flags & PM_PRESENT)
+				frame++;
+			else if (flags & PM_SWAP)
+				frame += (1 << MAX_SWAPFILES_SHIFT);
 		}
+	}
+	return err;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
+static int pagemap_pmd_range(pmd_t *pmdp, unsigned long addr, unsigned long end,
+			     struct mm_walk *walk)
+{
+	struct vm_area_struct *vma = walk->vma;
+	struct pagemapread *pm = walk->private;
+	spinlock_t *ptl;
+	pte_t *pte, *orig_pte;
+	int err = 0;
+
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	ptl = pmd_trans_huge_lock(pmdp, vma);
+	if (ptl) {
+		err = pagemap_pmd_range_thp(pmdp, addr, end, vma, pm);
 		spin_unlock(ptl);
 		return err;
 	}
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif
 
 	/*
 	 * We can assume that @vma always points to a valid one and @end never
-- 
2.51.0


