Return-Path: <linux-fsdevel+bounces-65721-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AF3C0EF94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 16:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB0203AE783
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 15:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E788A30BBA2;
	Mon, 27 Oct 2025 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HtjE2fZy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cDmToSYs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B391730B512;
	Mon, 27 Oct 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578858; cv=fail; b=EO2TnY6HQPEQPa1nxh0GbwDqti/numNbiYu7h5n/ItsGX9+zDCtkp1I1MNaClDTHYAGDZYk70DL8FKYlnqe1XbNZMGGQjtlHvPZDArj9dIfrB4CfIa7tErCLuiWIyX0KcjmLKgpaFVsF8coOdBayNm50ECTYkdnkkJ0emhroT8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578858; c=relaxed/simple;
	bh=9u/inCE1QpkgHw/QVDu3b1dgOgT5/8WgqTbKmC2KR1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sozsAW80gjN5JcoMvrLjtpHMfiJ7lHjjaMI24JzsAIX6FeExJHtnoYHB16N8lOLkaWxR7C5tUOBwiZZiidEZ7O3ok3bxTADnjyc8tty5aqojRPpmNeDs2v79wSwkzu4yoaaI7ZDEbv/zuIHLRsPM9ugO0IMga3oMcjnpMT0OFmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HtjE2fZy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cDmToSYs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RDYCkr024998;
	Mon, 27 Oct 2025 15:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KYK32ZFV2E7P3mbxVA
	idSloAbf8xETsUHxHqkz0jp/k=; b=HtjE2fZymXVOs2j60fx21D5cV35sgGPta4
	Gn6IVMIgO+Z1hHGqZi87g+P6fX7Nk1inCBsufzQV4ncQkJtH7XYFMQdTUPXqBtRA
	porPZzGBvR04g8HitA8ybzPc52UK//Tko28zP4nq0qlGCzj3d2ejF2RAlINtbZJ8
	xWMP0MY6Oh/Qif2BIJNCcAUy+cajVZJeEKZTpk2dv7csrF85PshyMZedIr/14gb+
	ANDiCf+BwzVrisEi3BlvqNiEk8QukozHgN4ESrd3hweSvIm0lgjWVGRyOb5Pv/KH
	7p8mQIscrYZQdAtLk7OivarMqaWcrhC5Uhdf7WZt3Frw6n8x6qWg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a2357h6eb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:26:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59REq2e0024547;
	Mon, 27 Oct 2025 15:26:33 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07693x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 15:26:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GBrvV0kgQdA8ujPWjTQ8JGdAQzAGFi7mhrmIFVneI+XkXrF9SrjZM25gUq3w2j5mDDRh8b6nCGVjYQMWD/tHOMgWbbLt4JCf72oVWJzifen46GE4lEhhb5R0EHpPqIMm19VsSoLBKPJbCO90wyiTufrj/v9lj8JkqAxYry8n0Mcb+a7aOpxgF2X76Q74vCWUGecBXR7dHO1/jdISqtEzm0Kalgnt8TYsDwd7sGtO7nFwTiGOsXBTXJpfMqZ3EjuzkupNHSwmCw378AOYubKVW/WDToOReiwgDmBCbMDNDQ947ItPufKq5FtJVhJ4Sf4oBdg/76gS95FhTbNK/B0w+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYK32ZFV2E7P3mbxVAidSloAbf8xETsUHxHqkz0jp/k=;
 b=D9rh3ahKEToS9MrPxok7UJ/jB0ZURDDuQC4u9w2fDt5krA3c0uLclVHgwyUgwYYuyL9/kUqFGIQRMVi+bS0/mX5oSK/4U15y2GEunHE6b4bLCmGtzIndI3kkD2c84VV3iW8WFVsFPYa/bx84OUjxaNEXPepQpfIFSB8wvcsv1S78OZEHbpKeYCHkDIzpcrrXLQqLzKZdWRoammDuj/TDC2ediWU50XV3+bGGS/9ul3T1x8KPNgwCIFgURiwLmHf6IcMoy1X9MhrA/a16ORJNA2nANu+kdivaNPuxWCNoCzP/XYZ5f1tBBFs3M+mYOd6ahK/8ocJj5fUs2xHVRaDtCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYK32ZFV2E7P3mbxVAidSloAbf8xETsUHxHqkz0jp/k=;
 b=cDmToSYsg0jm/b5qE6BUNY1Xfdx8DxjUqBmhW6OoUBGbMzAb3OXJqCJjTQwShbxYJoCFTWCTuTXO5Zzk5vX6iImEzF+UDV/oVGa9gnLjqfILWcpUTvjeEGawhEDNexZXo5MUIqWTMvypE8H1zmahUzl4u1INIqL2NLdaXs5CYHo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5038.namprd10.prod.outlook.com (2603:10b6:5:38c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 15:26:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 15:26:27 +0000
Date: Mon, 27 Oct 2025 15:26:18 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
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
        Byungchul Park <byungchul@sk.com>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>, Pedro Falcato <pfalcato@suse.de>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 05/12] fs/proc/task_mmu: refactor pagemap_pmd_range()
Message-ID: <6bd01af0-c4c1-4988-a80a-f0b40388d083@lucifer.local>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <2ce1da8c64bf2f831938d711b047b2eba0fa9f32.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPu4LWGdGSQR_xY0@gourry-fedora-PF4VCD3F>
 <76348b1f-2626-4010-8269-edd74a936982@lucifer.local>
 <aPvPiI4BxTIzasq1@gourry-fedora-PF4VCD3F>
 <3f3e5582-d707-41d0-99a7-4e9c25f1224d@lucifer.local>
 <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPvjfo1hVlb_WBcz@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5038:EE_
X-MS-Office365-Filtering-Correlation-Id: fb065e66-87a1-4708-ae81-08de156d3270
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MsKz3/S7ECvB5WRgbRLKrtTcWkRzSyhD3Rbf+ArWP82qKsR7puwK7C9Qvwnf?=
 =?us-ascii?Q?dFW6NSFVnNqhX9p/N7rPDYn6NBohobs1xv+TbGomgTYSFpBQKflhUKcpwonr?=
 =?us-ascii?Q?1xHOnCVKp0Cvm+ES3ogYD54p/Ypc68T7SeWtaj0PPeeij/xOU/0YXLYwCntU?=
 =?us-ascii?Q?BWe/Q57gcnLx0nK1sbulvt3tfXuFac4CkUr1Uh84RPj7weNJO4oxdwUzreM+?=
 =?us-ascii?Q?o7zzwkM2QfkLWOl7PKO7QvaSzvc8Z5afmJvE6TU3SKsgATrp4bbUZMztprO2?=
 =?us-ascii?Q?DzPiSEOYRJw+ku1aLbH2H4nVjP/rRO4O3xhbqJjV/5QGMaKUWkTKVnm6P76z?=
 =?us-ascii?Q?gK+zRSjKvDqw1xGO+bHWXkOSi6RYC1gfTQWdOKf78DZGWBR3wHPuicNyj1kG?=
 =?us-ascii?Q?JDP6IhoyAxcnk3YkPhmeujVMG7k54T3Yx1jYzgn1k50yJzQqe5cL7sHwVjco?=
 =?us-ascii?Q?fkhqdarI3aaOgUgvmvePqGbyEqiy6I84CAFSuCo/xpqt9+eNvB6w4io6vTlC?=
 =?us-ascii?Q?W6EhgaWecyG0roNd7fyjEYF/b/a8e7dKa303f6OyRPSm1UZOKs+06MJxuk8+?=
 =?us-ascii?Q?4GQjcammZAUXFbKM34C0xhafvnySFhLkhk9MDIZMcmlEyeaZlTCVXy4cFk7E?=
 =?us-ascii?Q?kIGHaR4ZE/KyfUNz3/71OVsn1co3yI+5TGZoeUi+7mafMROXYEC8wlHQzbJ3?=
 =?us-ascii?Q?NfF4+W4+ALRWMst2/Y0d2OopFijXY2brkXOTAUdY8ZwZ77Te5OpE3kyj5c+a?=
 =?us-ascii?Q?KCNfFXlq0QQRav/LS6po9WVsE4c+aCiF7BsxdFHcoWCrP6YGRpPvwTp1YVMs?=
 =?us-ascii?Q?E3sIEeV3sJnjEC2hz9B7a+Zchfk217LlZ4JqGjE7oAJ3JcERAAvfvMbBkHlQ?=
 =?us-ascii?Q?cUYVnOT9lvxRIkrlAD1c2DD+uI12K4h7y2X7UFeUC6iasZoDCPpG2TbMEgKG?=
 =?us-ascii?Q?x340dGhmbsQAf1hl7sFlCeNSd5ZSi4Zng00QmOg1cYv9pg8LIqrq7hCWJe5e?=
 =?us-ascii?Q?+NaSe2ZkU5dH5TLiD+A9RErzLYeezv0lggYJCsoMvCAiYDWpdOUdfG2dyfjC?=
 =?us-ascii?Q?/GzfFxa3yHRffB8eZTDbqLq89VtxqRtDzf+YuS1MU+k+KTv3SILsUOfhpPTu?=
 =?us-ascii?Q?cw1P+l3pTLPiyMQY5Qr9ntyg6+2iFtjP73qtGzcz1D6tol4LrHy+YDpZnlJq?=
 =?us-ascii?Q?tDzRb/FYoBjyHQMjGMPiJ0hXYGsEAcCmzltto5/8WlbAinxYkzZkfFM9esvU?=
 =?us-ascii?Q?pi+HtP9817UpUjgWMqvEEXjuowEatx7UoRMuNf4r7/N/uPztk22Fnmi0UpvP?=
 =?us-ascii?Q?7HYh8xhI4/wnvvpBxEiLkgB7/yFfiReM0vlskHLds9IKShVIp3SGGFdLGrEB?=
 =?us-ascii?Q?pZo6dpmmDpgiAlJN6SWPYkXTqj/QWk4gURDp/iuwYHEyopRONMo3Wo3rcab/?=
 =?us-ascii?Q?fh5IuwldhmllsZSDrQ/jmkfmL33P53Nf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ytuRpYJlAK7ZR5Fnso9EoTnuHDioVRvGxJ1eO2ABTA7fmAHloqJD/OEJQVk?=
 =?us-ascii?Q?ACtP/8FdTouquuuJ57qdWjpyJEif+0TwBrEzo+PmVjae96KSbGKzecvtyNmH?=
 =?us-ascii?Q?3Kf0Iono4H5ogXPBbWyJHitOtyAPxNRrhGUKi0jLS5ZOoQr1uJpaKcbz7ki+?=
 =?us-ascii?Q?Tczb0Zl5kIUh65Dh0iQ2TxCGoMRd2MHo6R7f22w1kq0rz1IeUUKQRfpC8sWu?=
 =?us-ascii?Q?LkDN2ozfzP81rMUi0CazfVHEfwyb3lBmmRyYvcEE+HIV3nyvtW5uC1u+ipJr?=
 =?us-ascii?Q?XjNPPnJbQXaQNv6FEVDozZi/8LHMVDQvDUv16uDfuLRrMtKRvlarRBfuUjh5?=
 =?us-ascii?Q?jq/z6cDqUjc6vIfk9LMzpmEUnA9Ilu3N7QwK4/+xfqayRotaFCof8xVUfQqR?=
 =?us-ascii?Q?/8sVvRtp+EFr8zJ+FRYyHJPs0wC5GHggqQ/bPI5J4JRpo99UCVGXPvkPrT8b?=
 =?us-ascii?Q?g8tQQQJ0WyzmhjWQW/YexpLeTSQpHKyYeh3mAy/JZRnCD5bqvLRNhxZgvB+7?=
 =?us-ascii?Q?JVImimQHnw7QwzOsYJlLT97wFoRTAs3N8mbsUHVaM+8CMsTcRxj6FAP5Y3xG?=
 =?us-ascii?Q?m2nDQ27BUw4eznp28OROkdRMkO1qtgNjWZ1Fr9DQf7J7IPaHTt7yD149YOzv?=
 =?us-ascii?Q?a4JBZuF3VQNForPBb6rdFcz+/kCRoAKulYUnKuuHGXuOrqNH8jdSz+HkKfDm?=
 =?us-ascii?Q?6hw18K75cMi1JcANOnxCvR66DFriLUsQKNRsU6NPLkmG/3UhJqr/vQqyjIu7?=
 =?us-ascii?Q?tXn7k07rLVW7PgmTyx0IFKhk1wVY6NCeu5C8/DcChTKHJ1vcJUTX36mpy/U5?=
 =?us-ascii?Q?FYjaey9JLSQ5RE5UuTh/yP6TacuGRYgjsE5Zep8jTL/GY0AhG/b0kF/OORSo?=
 =?us-ascii?Q?yH8ac7sOyt6I5bZd+y2EInPBjlOCFQxEjZzpzt/QUzFJfiuQkkr40jS3cJ+i?=
 =?us-ascii?Q?GnvpUQMFwHPv6pLQW7aSJwx9BzVDpX9UWgTcyFrGEcX0DiYEvqk4HHr6yH8N?=
 =?us-ascii?Q?HR44GT7T1OWP7ltgDxXa7LCrfR2FD0sxQe7/KjsS9iuug+9WQvM7PNTmcF5g?=
 =?us-ascii?Q?1YaSKS4gD6hSSl0MB/xt2dAymIKgg7GO7fASqs+uH5V12pOUunBvn3EvCwax?=
 =?us-ascii?Q?mck9pW8eB0g0DgwAePTmgGVATxfdJ0BwazTEA570Mt4sit8SI9pBs4EVDalI?=
 =?us-ascii?Q?bDQd4nXh5aLFZ63TRh+VvflupqQweekW8zkhNXOgYv/gsnJcSeguyeXTio42?=
 =?us-ascii?Q?sX4iR+o3dCrExFsMpXtwyCf4MAi9RqwunWnJRe2UrUkdDkOdQeOKYSIMSwCR?=
 =?us-ascii?Q?XikaL7kRGGX06Y3sMKkOJzf3x+4pUvI3R7XlowPiG2xYriVfSPwu0HAVfD1H?=
 =?us-ascii?Q?2DeyPkUgc4A0O8tDWuCmPgYZ5AI0/Y6uxjlMCwteXulS8WafSCLNdi3Ao1tx?=
 =?us-ascii?Q?29jaFWpjWpeHib/OPqWYZcBSNS1Rdl3vYQIiyE46CWUPpoqwISjppJuAqoVj?=
 =?us-ascii?Q?b6dOPU7oMogeE4Rqyq50A1lid8NqwIhyxdjT3deMwmK3hfE7mlBsRlLI0Ulx?=
 =?us-ascii?Q?FRMhABHyjGi9+qBD2PPUP8LzhtC+w7dUyaun2GmXdjxIyapCLqMTXSJ6sgqO?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	P7GwfMWh7HY/Kj8Y/nItS29APoYjAGpboq6JL5/I8/b5ETDUbeJDRzakCW+84/K1kgZ/ZdBVqpXoEn4dihLUDnN//xTJ6+iRJ8FyPYSVkm0bonow6SCxiNaVeMMvUDixSY5FVmj3vfU0e5boyn7SO8Jvrql+/1OhLgnb2Ni8XEwIaDXhaBSODELtgx/bWQS9g0kksFOHW2iV68D/VRcU1w+qQbVkrRXcvReJ93K2/FEe7jeT15eODBUfoNw7GRJE8s0wqS7y+yJwMNbcCL5LT3PlT1EUrP5gSEf7wR9xjCxtueGgx/AUi1Uv/bgtBOxBhAAb9003Tp4dpYqspB6mT4MSPWpuiYT4/MRZUNVHWRY9YAzrDQW6r58WEZI/iBmmKdFyBz65hsAQVH9UY37FsLrFJlIm36eG2dkiZRydwx6tQ5p/k/r4pO0icxNyTCjuteb/Z7WIDSOliDiLrHFR7hCPALqhXgl1IjYXDEMqS1jMSnjhAxrhYOa/SLfGxHXRerAVUYhOm0PoIEszJqn9Ex0D3M/TKg9/CIMlHIZOpzjGfBqZnxZMlsU3Cn137F9OcEexiKWyZLPVGOq3vAymKSBhf7HLJEBs1k86Z+5UQpw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb065e66-87a1-4708-ae81-08de156d3270
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 15:26:27.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IiMdAxp6UCJkX82ySyTsqPZFnRD0z1t+3zDYR0ikC3s2iT2WIaNOyDqQ8JQ7oUWHqzGSbk4bDfPZTo/sbPfxta2eJjrIIXTXeX55YjmGZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5038
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510270143
X-Authority-Analysis: v=2.4 cv=Bt2QAIX5 c=1 sm=1 tr=0 ts=68ff8f29 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=LCAwMMO7VcjFAgT2DlkA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: 7ujjLbi7QTqz3OejpALrUJqY-N-QxoC-
X-Proofpoint-ORIG-GUID: 7ujjLbi7QTqz3OejpALrUJqY-N-QxoC-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1NCBTYWx0ZWRfXyx3AYACYR9l7
 s4ks/VwH2CZEDrsXmzNGkcEE5D8DlFifZb26BX0UdrueKMeXrjXt4QBFJprtmWckelEJBSwGj+X
 cz8LVQt7IJ5V/P3ZE3RHMuuRTM338PQpmmfkehj5HatKxLT2Wq89l5aHGzHu2rWkvSglzZhcf2c
 5XPV7nDhWVNAAVPjF7JL6pwGplFFtKSqUXkm6cH4wbOlt/4xl53RiDh67BTVlYc2Cb+RiKRLyfo
 ak12KDrLlEjXzzrfrJ8j/EycDU2fn0u6e4pkZ+r4HLasKwSH96YQ3KK++wIWpdoikVO9jOL2bK6
 nAi6PzPZBwERUWLC00Q0Me1Yym+J10QW2B5/S3lE9lyXS9lrFsbiRQ7rBxSG0gb7bcD3bbRy1pX
 gwg64Kn22tnuhOcdQJSo9b24zaiaqQ==

On Fri, Oct 24, 2025 at 04:37:18PM -0400, Gregory Price wrote:
> On Fri, Oct 24, 2025 at 09:15:59PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 24, 2025 at 03:12:08PM -0400, Gregory Price wrote:
> >
> > So maybe actually that isn't too bad of an idea...
> >
> > Could also be
> >
> > nonpresent_or_swap_t but that's kinda icky...
>
> clearly we need:
>
> union {
> 	swp_entry_t swap;
> 	nonpresent_entry_t np;
> 	pony_entry_t pony;
> 	plum_emtry_t beer;
> } leaf_entry_t;
>
> with
>
> leaf_type whats_that_pte(leaf_entry_t);
>
> with 20 more new functions about how to manage leaf_entries ;]

:))))

Hm well the union is an amusing thought but more seriously leaf_entry_t
seems pretty good name-wise actually :)

>
> no not seriously, please have a good weekend!

Thanks :) Hope you had a good one too!

>
> and thanks again for doing this!

Thanks again :)

> ~Gregory

Cheers, Lorenzo

