Return-Path: <linux-fsdevel+bounces-65417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C35C04D3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 09:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A01AA2557
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066E72FB612;
	Fri, 24 Oct 2025 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mNBR1bO+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8J98eK4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967AA2FAC14;
	Fri, 24 Oct 2025 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291853; cv=fail; b=bTTS1t1DzBwunjs7LwjbpFfCoEEZYs9Z9/f7XOCkjsa7asvy9HD9GuPrQdaSX3UdGtUxwz5Nexkj8rlGinVRf+CbHMz8eHnhk2bS+SyBcBshchUENE7C9BB4r3oMdVt1EK4a8MaKHlHI6eJno6meX0n8Pnr1ABkDBTSvONpYBRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291853; c=relaxed/simple;
	bh=aAxZiticGzyRjqPvVh+Adj04dvvrgYwJP5rdBgH1QJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HgB4tl6jFBYwF9xKuDfiStZmjsURoBI4TjlO8UVRXHkVUdtIfZI98Ypx11JbfQOPq+KMRYqzZwyb6oN/6gwcIW5aPDQbaJEqJKDmkyVKDxbxamNuwekUEwGTfhlt3Vb3BmV0ObuJHI1x/kDUH0dYfX/itkUV17R8/JwbXOSiDiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mNBR1bO+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8J98eK4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3NTnJ021637;
	Fri, 24 Oct 2025 07:42:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=tmHqIK1K6YJL5DltqSzp136H5TfbUkWYVXIOWQlLyos=; b=
	mNBR1bO+he68ijcejEkPo1fncjguPh+YOitdCFWts1d8TuSFcVvZbL1IGXu5WQaj
	/rKl44sjwa8fGQ7/YOStdwy3TZPnnTHc55PCfk//lfd+2YMP0V5xXVpyHMo2/EVP
	4ryC7VUzXBvMtuxYsXSnnbF29DP/S4g6CJy/JoGc9gq130cdVhimwSpIa65KDSrf
	AxppiPILxBkHMLPfFA52Uktsp0nHPJa38f+V42gU+nShIUVj6eS9AL86fOwYG1xv
	DfDlK94Rj5EI1XyB1psNJcWUAEubs0xx3SVjIiXR5rj/q8BQzCV7c1TPc4OG53FP
	4n7htesUfTAVJj1UOe3G0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k46cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59O63wa4000933;
	Fri, 24 Oct 2025 07:42:14 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011061.outbound.protection.outlook.com [52.101.62.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfj8h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 07:42:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGx4Nv8a/o7wpUABIxdTVRFCb1ZRH7PJl0v0oXXN3ycO2aK2AJMGbtrzQxt01pZ/Pbkl/Nr8BZmWmLvOMY4PnnX1rSo0hrqe2/PePykQzFI/02iwGYSACI+htQviXTNVSZ/hKWeq8lUgaPsco7lr9AQTmjVoGaxZUzeUaw0gIKsSK+DoO/VbkCn/p5boLnHIs/TIIer5Kw6vAuGCBCuori6RX0SM8YEFClQa/CWIeOKkIsE1jYRKhD49DfFo2ha/RJZAOFhxXs4I2wKsK37yMPCVvHOQg6xAbPW43Bg46LffFGiyxR5qXp5v6L0tObm4fkPXa4QR4MJn8QtySnMBww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmHqIK1K6YJL5DltqSzp136H5TfbUkWYVXIOWQlLyos=;
 b=VpoYLjDp2t5ZBKWh+k9R8gtLqoFrDAt/z/AYLC5wHhA71/oqgG68nQbBjSGKET99kqQUkUOXcV7XkBAB9l35JBE5RibWpiqcrU7bs03cCLpzDhrOTa4+NKBimA2EeHfrhLwVEJ3VBb48kADz9da9w9ExUscBuowsx/FOSQNf7wpdeGOIMWrcJIrUss2eQCU2wEXqObx80T6McLWrm8hxXZ8q9btiuUMsKqUWwt0dpPBC5psueW+A5ygvB6bHYjyj9+TItfqlaHDrkcnUZ1LZYbYdBBqgGtp4gTJRaKC4OD7t3VfVBt/5qYQMOFJwavn1wt1NtezGjj5aT16WF9fWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmHqIK1K6YJL5DltqSzp136H5TfbUkWYVXIOWQlLyos=;
 b=d8J98eK4Dnmya5IuCI2yFv81q8GKpmo7/pCasDK3FnlfboqQT8BR3HKdGffaebiDbKSZcmr4GvJvpMAezwiNMrrj5hwJ1wmHzFnSt5i12nkSdVsos8Ipg4+dPc01bpzko10fc+bhR9U1YmarH3HMxr1qFTCoYrKjIlgLC1vtA0k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6716.namprd10.prod.outlook.com (2603:10b6:610:146::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 07:42:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 07:42:10 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
        Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
        Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 09/12] mm/huge_memory: refactor change_huge_pmd() non-present logic
Date: Fri, 24 Oct 2025 08:41:25 +0100
Message-ID: <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0002.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5de::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cce6c36-0ef7-41d6-6f7f-08de12d0d6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3sTE1cDp6DSglPxebEc2UPkF1/UvL5rCBFbQ8A8GJxDg3Lt1Zo6EcOKmi6vV?=
 =?us-ascii?Q?R9KdAxw8wka18WZ3IC11WGrGyfQCVijmm0SAqxS5/MGNccEuWyRBeQRU2Cy1?=
 =?us-ascii?Q?8A99I5D4fmqtwbsIIqSvLj7J2B81VdfiryIRdm8JlfrM+uSSFNPmUBnXFtDY?=
 =?us-ascii?Q?aXy0Gfqx5dvRdqElB0R1zoEVOLopwtJwOUOUDNxc70Ay0Q34TeUPzt+dFgZZ?=
 =?us-ascii?Q?jToA4bmS3KhezU3xE6TaKnT3jZ46WqYNsMH1LwQ6aYh1ihy0iqxbFfwDc4x7?=
 =?us-ascii?Q?S4PX3RJWMAv0jsWu9qDeQhr30inQiZZNycODt9G0S1PEiVJQXWwDxUTEd+Ef?=
 =?us-ascii?Q?as73R5MJ7MyJq5Znm0M5RNS5UUIgOslXU1CGEEIuHpHTZtx+A8Alhazq0vc/?=
 =?us-ascii?Q?IN0g4mQX311pF44fIEX3cH/QXkKDShcDD3Y3UDawtxo0Bi87+nvpVKL/VHDT?=
 =?us-ascii?Q?JfWFQxRA8raV12f1m+MX7DwRsbr6249ZFhySFNvss03HqKjd0/6zKURV+5Vw?=
 =?us-ascii?Q?d04w8nwBS6e5F+LWNfcPPHm5WDGme+U0D0YTPFnzlDeHNwkcNNn9hb7pUpji?=
 =?us-ascii?Q?LtihAbqX3Yo9gloDIW0X4mlcL8i1bGrfy9lajE4F8gLvt/g2xbRxMkGuM5Kw?=
 =?us-ascii?Q?9epcrEvn+ozm2RpIIQrtk2/9dt4e8hMX/4itrhHzioeDSSyavpP1ZG+eUysS?=
 =?us-ascii?Q?V6991cSrqIVuTcAtw8J2TfmUXQcON6yhlWJxONyQZrtdIOknEZ/2LwAMt8gm?=
 =?us-ascii?Q?La1fFc29fT0NrumIjzdP2O1ZqqtJ4zf9yLE/JiEOIJ0neoWEaJ2a9ASDOaXG?=
 =?us-ascii?Q?UEiIS/yXoQP0Q1V4i9cF7t0YEM5kTCm4y2Ny0H69Axs0WDO0YfT6kkzMfeUQ?=
 =?us-ascii?Q?1b1PNKRFx+LvBgd1SrPIDmlp/sJCjYb29EXODqfhuG0ojt19ZjC1jPNgo0Fe?=
 =?us-ascii?Q?+0kT7M0FsjvcPAZILzTiQgk2uMYcPfhwhBZ+WFQqpyGCYGpKHLaYJ0YRucbf?=
 =?us-ascii?Q?r3NMpbTvD+ZWENUauX4473FmkAJwxcVy71kxQN9IJcq6G2QdpEfdHlrhmuZR?=
 =?us-ascii?Q?8Hsu3Pd6cEq1/0rp6pRB3656zpjfYwuZe4NsX/EtYKMWARNcL+XEX9Y66R8h?=
 =?us-ascii?Q?tSz8amuZUjqt3XDawU28/fuPKAi81xE5S0PStp/NhW5IeQdxorD5eYpVvSAb?=
 =?us-ascii?Q?KEQ8eQQCmT1DGe7uTtSvzd4eVa4tBXjbyKdE/fFk8hXdTSlU25GCnVm7tSJE?=
 =?us-ascii?Q?jtdaQRsjt+NLr0g5kfZM7qFcVM1tXlxszPq7XrWV+wxoAJCfPRncG4qN06Xf?=
 =?us-ascii?Q?QemLp5dbrXxLWhPGCYpKZillV7AYktbHq5E/PeOTgSVKS/AXwNaabvy9Rn3N?=
 =?us-ascii?Q?0WaIJMd49HJZJ9V3bittvHC1+ImHHz94N5R3w7cia24fGCsGSeL5Yg6PG9xE?=
 =?us-ascii?Q?qL9bWrHuKPVZmq8G8RCEer6sno7LPgXB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RrXkuEUgSXgORyotcQfW2cQbnpIneN6hqyGlM+fqVl+p+RrCRhu7aDJiWSPu?=
 =?us-ascii?Q?sNv77pY7MH59RcT8Ral48IB35DaX97JtyZsA3Az7xczNk+4FXyfvtmti5Xhi?=
 =?us-ascii?Q?YGraOVAmVNoj1fx+TDZJIm5n0yR2GRulWXuGo8fXV84LwbpnSOxuANII4A1f?=
 =?us-ascii?Q?feX7YcUmP4uZU+l0wNRqSizDtms2qpBa7OVpfye/AlYiEK88WwXY04aL7dxZ?=
 =?us-ascii?Q?GiFttn1Ks9ncoalxqIuvfBxtNYSiq9lZvfbCzNdOFrrJA+B+gWY0Ora8S7Es?=
 =?us-ascii?Q?tjE2qF9bR5kKYCRGe8TUbSpnOrNQbfZF3f/TAHLPh9egAU+EOQkzRPcBBQQ3?=
 =?us-ascii?Q?bVqEiAc/lpM7xWhf5DuQalBGEn5hFjkBbOpoROeN43BjGyBG0e0nAmdWHG9W?=
 =?us-ascii?Q?NEEV0cyIcK8mwMEY43UE5vmGj6TdI3o6dS/VjmJZISyjDt2E1M2YxtKtzNuL?=
 =?us-ascii?Q?5l2IoPfD8W5bZUWleaeQPre/5HxcG1JRN2WwLJh+U0ov2PyE4dPZO8G8KE+E?=
 =?us-ascii?Q?A74HEDJfv1oBZRcrAkAKkJ8HqdsW0LXj1837gjKE/1ylVCbAs+F8hE+mu08z?=
 =?us-ascii?Q?7c2Zr3x2ITBbmAqn/TNxoUOg4p4LVFpQuVcf7PHKrGphrxe/tFukVRIJgzSi?=
 =?us-ascii?Q?ZhLJBIotHnmSbqIavrtJZ7dBDxpz/4RbTTZSRuqLLpzW6tFhQQ1FmrsFKNma?=
 =?us-ascii?Q?23c07wg5QdlOTBRjqoDAjariJu3KGZrT/n4X8y0ce9BPIdaiTcPXsgM0M2cb?=
 =?us-ascii?Q?lhXf4fqkEcRRqNeG3kLUTh7fgjm7xAT8LGZuU/C7DtKMd0B5k0wzxsFaCGxz?=
 =?us-ascii?Q?+N+oZWaL/gKQ59e5wgRBfZ1+/TPRF47NaiHkz3+x2+0MJVUFFfwZOAq1DHKR?=
 =?us-ascii?Q?Lh7DCrXWiYmjgFX/f4pfrPYQtR0Id/GTv41qakvXa6qMb1i177LPG68+zyzH?=
 =?us-ascii?Q?7UW4CF3rNwy3kpUcd7ANT1qvhKhTyCa1/K8OWaM6oKkvC3sVG+A8/jV56bIF?=
 =?us-ascii?Q?/7ydD4HPI7WgRWDvtvWMGUD/vvYm2aXVpkwB0RVtE/LbWUd0NOoqksWj4N3V?=
 =?us-ascii?Q?LO4Hvgr9VrxjO2p2oJ7raACz26hCQ6/XGgmYcmb5Itm4WOpM0uqTl3tcItek?=
 =?us-ascii?Q?wpBvlOKXw596tksG3ima8na6K71ao2lZaINB9zW9QXxXmOmzh880tAWhrD8T?=
 =?us-ascii?Q?nx41eMQGw5UmeVaeUG/jpAIK7CY9NPzrHe4V74CvZez2mswPv+WkGbb1AxcV?=
 =?us-ascii?Q?0cfvd7IebceVW3JAWrfK0Pqcd0/dXxi438XmetXrh3BU38/3E75S3xRg5DIM?=
 =?us-ascii?Q?bKEon1GIOimkqe8yiYPVNs91CP3WXJDXUiXEixvJ6FYXbBkiQwcSIvUIkX4v?=
 =?us-ascii?Q?phpU3VgWpHNDTLdK9zwQ6BZYTbXtAgHy2bwUdXU70JcXVuSLYbtgbVJteQ4J?=
 =?us-ascii?Q?yn7+TKhsCT4JNLVVGbQm/3zeJzG4ElErG3p2Yw8dHvIJTR89KCXdbJjho7V8?=
 =?us-ascii?Q?IQ6ce763igcI8FkB2SC9JQjfFTVDNLCrCI9XQyOJ4csgH5ffPn04NIjWELXm?=
 =?us-ascii?Q?melFot0qbuhgRCX1ey8svudVMc9FIfVjJ28D0KNe5uJWnt2FIVNVafy0Yods?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EoQSfc5JBXXkHVCIOb777cMMSJyP1lzfQWhVgO1o+mbjSL0OzlK2EqRSJKpZ3Rm08DWtXyvPmRwCoXTfIc3EwNX6J47TZgdi36Z1P76eli2Wuizp8c+b713quxr+q6x6bBPdn4f3NjClITkbFAzTfz+obcFziZT+arPYu1zq3pBsjr4O5PuuIKsNls1vHVcWpuPnz1bPx8U02FvvBnnBQ15XmHR/7jZmA5sH92NRp5ojVQPNK+lRl5mXuqBf7tDiKeNaXe6CHQEA6mzCUTQFVh35O3zke4tVc0NAgnb77hVihnEg6ig9luYAD9PCvlNnfOxdjCmwPFYrKa2u5r8K3k6wWWb2iKsTVw2088i6ctBt9HvL4e4oZP3N8/busHn9N1XZ7qUI+vZxId9nC69PyjvF9pkEENIt1P76w5xZ4bNqysZsA60FNEi2DYyc7bLsGZvIPj/+UQvVyDqjg9y2OpyvNT5eJPiZ12C951P9Wdm9+V63TBz/ACup0vdP6qTne4xd5e3Drb/Is8nrRkW22mE35MMviklj6CNISZfddsX1EjoYWjgA8bwpVD3mQq36+tS0eLEWU6sJDfqtR7HzeZXs2PB095WJRoEDTpHaPAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cce6c36-0ef7-41d6-6f7f-08de12d0d6e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 07:42:10.2564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: piyO08NW4M/obJTy6NiFdi5Bgwoli1iw2z6YCq4AE4bW6xEYSg7ObHYAg94A16Ap+lyjWO6Jfq18tx5X+iPlzcKpAtIVBXnb7WUOl3xZnbo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510240066
X-Proofpoint-GUID: hXgG_6Am8CIgsjwF73Q0-LmFaClCv8Nf
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fb2dd7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GiTFkVEORUr9-xJPv0EA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfXx54pccBLoia8
 NpVImIFmrkYBBWEQw9e922bvsB1vfAxNQj6nCobeFaQVZAvn+0uo63OAVt50WfMtsYyvNCiAPnq
 GU9NHBCWa/QBXFO5XtxC2wUresM3+Iu/Gw9V40/GAH65QBJo50CU+udaa9Bj9pSpKQwBAhXQZtP
 UTzJDocM7d7+lKGVB4i2oMPSGaLCBwn/9RrqQ+xrEtJYGCnT2Q816O3m+V7GxgVJMow+GzS7YXD
 tVmO9r9m8ILXZmz3qDudUdh4WJIE3a+feifJoPOGBeo834ts2scudzFRLYSPWibhmrNnD3i/U5f
 MG7qGbM5Hz0m8o5158i+YluHPSk8sJN9gjvGp8jWZRGk/5JB1jBA2Uf+V7Bd9kfFe/BiTsRugjU
 4cTafwXzNzSPUvreDEoqxUU9EhE4cg==
X-Proofpoint-ORIG-GUID: hXgG_6Am8CIgsjwF73Q0-LmFaClCv8Nf

Similar to copy_huge_pmd(), there is a large mass of open-coded logic for
the CONFIG_ARCH_ENABLE_THP_MIGRATION non-present entry case that does not
use thp_migration_supported() consistently.

Resolve this by separating out this logic and introduce
change_non_present_huge_pmd().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 72 ++++++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 33 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 755d38f82aec..fa928ca42b6d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2498,6 +2498,42 @@ bool move_huge_pmd(struct vm_area_struct *vma, unsigned long old_addr,
 	return false;
 }
 
+static void change_non_present_huge_pmd(struct mm_struct *mm,
+		unsigned long addr, pmd_t *pmd, bool uffd_wp,
+		bool uffd_wp_resolve)
+{
+	swp_entry_t entry = pmd_to_swp_entry(*pmd);
+	struct folio *folio = pfn_swap_entry_folio(entry);
+	pmd_t newpmd;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
+	if (is_writable_migration_entry(entry)) {
+		/*
+		 * A protection check is difficult so
+		 * just be safe and disable write
+		 */
+		if (folio_test_anon(folio))
+			entry = make_readable_exclusive_migration_entry(swp_offset(entry));
+		else
+			entry = make_readable_migration_entry(swp_offset(entry));
+		newpmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*pmd))
+			newpmd = pmd_swp_mksoft_dirty(newpmd);
+	} else if (is_writable_device_private_entry(entry)) {
+		entry = make_readable_device_private_entry(swp_offset(entry));
+		newpmd = swp_entry_to_pmd(entry);
+	} else {
+		newpmd = *pmd;
+	}
+
+	if (uffd_wp)
+		newpmd = pmd_swp_mkuffd_wp(newpmd);
+	else if (uffd_wp_resolve)
+		newpmd = pmd_swp_clear_uffd_wp(newpmd);
+	if (!pmd_same(*pmd, newpmd))
+		set_pmd_at(mm, addr, pmd, newpmd);
+}
+
 /*
  * Returns
  *  - 0 if PMD could not be locked
@@ -2526,41 +2562,11 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	if (!ptl)
 		return 0;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (is_swap_pmd(*pmd)) {
-		swp_entry_t entry = pmd_to_swp_entry(*pmd);
-		struct folio *folio = pfn_swap_entry_folio(entry);
-		pmd_t newpmd;
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(*pmd));
-		if (is_writable_migration_entry(entry)) {
-			/*
-			 * A protection check is difficult so
-			 * just be safe and disable write
-			 */
-			if (folio_test_anon(folio))
-				entry = make_readable_exclusive_migration_entry(swp_offset(entry));
-			else
-				entry = make_readable_migration_entry(swp_offset(entry));
-			newpmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*pmd))
-				newpmd = pmd_swp_mksoft_dirty(newpmd);
-		} else if (is_writable_device_private_entry(entry)) {
-			entry = make_readable_device_private_entry(swp_offset(entry));
-			newpmd = swp_entry_to_pmd(entry);
-		} else {
-			newpmd = *pmd;
-		}
-
-		if (uffd_wp)
-			newpmd = pmd_swp_mkuffd_wp(newpmd);
-		else if (uffd_wp_resolve)
-			newpmd = pmd_swp_clear_uffd_wp(newpmd);
-		if (!pmd_same(*pmd, newpmd))
-			set_pmd_at(mm, addr, pmd, newpmd);
+	if (thp_migration_supported() && is_swap_pmd(*pmd)) {
+		change_non_present_huge_pmd(mm, addr, pmd, uffd_wp,
+					    uffd_wp_resolve);
 		goto unlock;
 	}
-#endif
 
 	if (prot_numa) {
 		int target_node = NUMA_NO_NODE;
-- 
2.51.0


