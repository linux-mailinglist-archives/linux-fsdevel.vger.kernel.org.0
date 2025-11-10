Return-Path: <linux-fsdevel+bounces-67636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD14DC451B0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 07:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D4C3B1775
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 06:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855B42E9EDD;
	Mon, 10 Nov 2025 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AdYp01j7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="js3Gqx/D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCE226D17;
	Mon, 10 Nov 2025 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762756709; cv=fail; b=nO0GD3K1c1PHq1/94BKEz+yrCS0NVeptBtzLVBOzm1jALy1eb5PTX3Vps3izxhK2D33nWYDgjPIGil11qiPT/Je9GGhgTWWRj3aXmIMkCb82cQvW0zINOUmR3EaNsrehlZv3VbKo8s9xvt5J+FPlqNfYHGtDGZD13hCNB5UpmiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762756709; c=relaxed/simple;
	bh=a9H/JQ1F0eRuF0eRm1UT2vK71gbTLRowVFY3QR15TxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VWvni3b5fsE4VNcpQ7r5SBr4WpRA/bpoXWCtRbLZzUb5jrNWCrcqeGcd/fWYCd+kWDmdQHVe4DKJ/PlmmfL6WMrExBPrHPnix4wJKWHXtSTna1tVsm5bytgEw2fu7V6dwGQ70wGzax0+LrltqKlQBBNoi8yKDQEZSg7DcoVXppw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AdYp01j7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=js3Gqx/D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA6Ahw7019259;
	Mon, 10 Nov 2025 06:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZQcoqszeuQMeY/1yiU
	zR/DpV75atjhp8xh2smHDnnrI=; b=AdYp01j7AyhGDErw1P7LpUYbemMDbLuSy9
	1Ppvavlsy8Ci3E5bKILgM9yeT6226urXBzILJgXLNRhWkprALi2XPNd4XA2Ih4SV
	wsn1vnMXqCa5Prq+IsZQL94d/I9wkSBtPwZ+VNePClfkolCkUdV623Q1OcLQBbgx
	kMn91IR7SelgxIQtSORGyw/x7NZiXk6VIX/5Pjno31jMiToiAppuFMf4fW8zY+Jd
	csy5CvIic6JVCPmDE+8gQaVlrywzGCclmQRZTIgJ2evxG16Lll9SsBh2gIyF9mLB
	IPWF2a0mbnRHvANWXlHra4gJcH15CAWlOQHzVoljjuIZjI0uC5cw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ab8qa06pn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 06:36:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AA4lQXl000889;
	Mon, 10 Nov 2025 06:36:53 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012010.outbound.protection.outlook.com [52.101.48.10])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vabrv6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 06:36:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbjwvFE71Q+RRYJykyABhPYFjmtRqzicnTI2QiizoLN2cBzU5t/AhjRuTOzNoNxQKfNCtY6M7X1YVMieQRPD7StLK7IO/26tyZWDbAUyjQWRYIxz55Q384xByRA+i/hwDFer6zO486HQwy532983kYEIiPan3T5bpJD3ihOoetyzq5UINqPGE1jHXV0K9mtUtT04yU3aO9UBGta+405OxVqt9fTgXbWJfAUcxwem9AMFkr0tKjzLVvrIScVTCcfSvcUo10SBrhvNsmZzWT9nGQKwg5BpxML7kMN+/W9/te8Xg2WgTwtaACHAd9MpStlLYjnpqogSNTQIYX+LV0hHxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQcoqszeuQMeY/1yiUzR/DpV75atjhp8xh2smHDnnrI=;
 b=VAO8Gl1kFeiBo/bCkJE6SC/AE+3dWuQXLVesdRJR7rzOaFJYIx+AgfiWsOi9C+tFPVzQY/b5a0warsNyj3FZc5WK77As5UQGOGucTZYsYwvj/vdWh4qeyZ0Az2IBnvrCwDtOG1rcRmO+2tYgHMe8n1gdihExlyqrKmg4R3O7csaef3tf37OxCaslpeTsUoEu4ZJ7i5VF2GSC3/v/ZtPBrm+H0JT0elPuchb+JO08hHj0optRTrwA09nlNDT2LLGOGSPS2UP6HLhDfroXtcoXSxP2ernIySp7NoD4FCkm/KlknVm/AVSnDo6eNWSB9HgVWavkCPeAq0cK9s6uEav3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQcoqszeuQMeY/1yiUzR/DpV75atjhp8xh2smHDnnrI=;
 b=js3Gqx/Dx2tOBRTiM1Ijq7etlKSeBEtJhezCxydDLo0ATndcchi6h706OAGGpfHc7G/ca/H6ucPChZb1L1uX1wxpI6jB76uq+CeMo3ee0DklI7vWWEFBsHvfuIkpMRBKjtXnB2H2ReATsUJFK7ewTmWQ0ajIW+vDAlowjpX0eF8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 10 Nov
 2025 06:36:49 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 06:36:49 +0000
Date: Mon, 10 Nov 2025 06:36:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
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
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
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
Subject: Re: [PATCH v2 01/16] mm: correctly handle UFFD PTE markers
Message-ID: <1e8da66f-0af9-48f5-9c70-d71d3108fb52@lucifer.local>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
 <0b50fd4b1d3241d0965e6b969fb49bcc14704d9b.1762621568.git.lorenzo.stoakes@oracle.com>
 <5ed51639-604c-4e15-84ae-4bf3777f83c1@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ed51639-604c-4e15-84ae-4bf3777f83c1@linux.dev>
X-ClientProxiedBy: LO2P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f67dafe-ac3f-40d5-9880-08de202386d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WkXS35OfDU4hoOl5L//AuWfl4TnKfqqePSdpPGH6Gu92Xo/nmd7/z3UmESy/?=
 =?us-ascii?Q?LkZd+0WbVcr5WkHEGSJgJOpAus9FB+0Z/tyU3jAu2DX2dAhmULyRsW2M2oHV?=
 =?us-ascii?Q?yV8dOtGYTj06cQbk8c9TrRqlpPIGT7JOxHPPMswUGMqKcKrzo15M6mkZ/syl?=
 =?us-ascii?Q?yDTtLySOjvSEsUsIZtLic4Pt3AU/CoLxXvo6WmKub8VUplZLqgN95oHGXzSx?=
 =?us-ascii?Q?Pp8V6BIEsPBQYcr617Va/ZuJdgVCF7WH9F+KeuKtYMpi7EQsUvNjX0FPJCN0?=
 =?us-ascii?Q?LZd1ZcSshOGqgGOUgJ0niuCRQAVlqQ8vyK0cyFklBrBbGtd9fRQqtptKD7wV?=
 =?us-ascii?Q?T99/EeNFi3kaukc94FxiExfSb4MM2ye6M9KeF3ihdfkuW7zHD32SEPKFMiJo?=
 =?us-ascii?Q?6kEclqvk2mKOsLJbDKFKlwcbbDhe4utluB3N5JY38/mZ6RUmzAR1JDi3O2VX?=
 =?us-ascii?Q?EMqk49u9Z1R/HcTQLPW8ttnJyi2Cm5NrBYfHvcNLc+agESbVSHfV+uW5wl6e?=
 =?us-ascii?Q?XYWVH0GCrjwb0/4aOpt+GfKDTmPv+zEOusuUFZ7sevX2NkfRT/rzDA+xSmu9?=
 =?us-ascii?Q?aFC8RaetfM8YyEHoY4sXJQkWefsAYLrjxWCcxxgw4cqjbm2vWp0YBJidg0us?=
 =?us-ascii?Q?MlM8M54UOqIyyt6H+0yLX8vITpwTIM/4F621UmIe9sslkX1KdWHvUImZ4MSn?=
 =?us-ascii?Q?5CnR9P5JqS9IbSgdRtXynYm7fjXzHNC2Zwu3FV3pG2uYRjMk+SVKZoy4MECp?=
 =?us-ascii?Q?cHmUbzUl2nd+olHyeSfh6qAnVHErNRdZTZmrXmYD52283FKwATxPvFlRJLpl?=
 =?us-ascii?Q?t55Dw8qnYlnFkjpPsSKZcNZzxkSGSLOK24Amy8YLCO80+FoUe9b45PZIakd9?=
 =?us-ascii?Q?RoX9OU6NDp0K/kbCCq48eHUl8vVfVuWlo6K+m9BrQXQRL/3rIK485hnK5QlJ?=
 =?us-ascii?Q?QfMiE3xQyTeVBkhEgNlcqKg+u12ZgBl2Ckeq8uw2bxB9T8cSwG1nwrccLszO?=
 =?us-ascii?Q?5eTQkYQsIHESZe8W2g5Kt6jxAZGlPqdwhwjtQA3ddd0Z2EfRZpVCEuV7kSsU?=
 =?us-ascii?Q?FgdkaqgnJR/OzTwMCsN8Z0c5804xIhbTiBEr90Mox1vTffMFadpaKiEYDGNw?=
 =?us-ascii?Q?WyK+aEHMDP9BbGXNN3d7BNTc1rqI2jIzwNTgLCykJcXHFiSLB76dgoV0B/ap?=
 =?us-ascii?Q?dLEAMDrpmwZDFRz8II1lAb0YzL608urVqyeIEIrG/5vbxFpVRo819rfUEwLV?=
 =?us-ascii?Q?In+r1oHA7zw8TGNCTq4lsJjiR5r6Yz+rHTtEWdoA1Uqsd+rv5LhhI2sEHuCz?=
 =?us-ascii?Q?u98liXxU94F2RTVU1EKPwA59akJrXMrD8haDqBW+kGKF6Xhiq9fxjXWjAnCD?=
 =?us-ascii?Q?9cy412HBwVvWGs95BysLDiPKQ/hXKbVrd9soLiddioKYKl94VlJmSAtfMUZk?=
 =?us-ascii?Q?2kaswV4sSq9z9/zQN+df5o4DGgJMr/cE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4heUkBmTH3PfbGP3X2MRfoa6QgsPJhW3WTrRiLVpVBMovE2QhI5UPQdaA3g?=
 =?us-ascii?Q?G3gjQMoRFo26aU3/fcaK4K/iweykZzWDHk5QAze981qQ9rAsNdtNFJ80ut4E?=
 =?us-ascii?Q?nmNdau2ufEA8i8LjnVy26I3FyrbzwTL/Qy54GMp5wGC36SJ7pCgaeO//PDB/?=
 =?us-ascii?Q?5/+3fa/mYjKJDV14crDTPB9hmNX/T+CZbVJezDx5o5mPvs/5AGl5l0GpWocX?=
 =?us-ascii?Q?srPyuY7cvfgsW6SDWoDADs+XWXhNqyNbMor0zwHVVFZBCN/QnKkI5Q6H8PDD?=
 =?us-ascii?Q?7UkwHbjxwAHzUYseZBszMctYJh9lrDVmBi50nBgYfo6F3xzvhMEm7myNTlPQ?=
 =?us-ascii?Q?NWHy3U7FFq/MZH+K6IXIrP+65qPHVA61BpMBJPqP2wVYQ/AIOsZkRVSglmi2?=
 =?us-ascii?Q?fTsqkvq9hQjvQxrUFHsJVt6WqPMcNbGyuA4Ir5OBjn1RRDocHP8ORBdj33DA?=
 =?us-ascii?Q?iBqi4ia1ZUGAr6fdBcC7SXacEsidYTxAHyKqJlnu9dN2WRDYsvpbNbqKxbYl?=
 =?us-ascii?Q?d0CxiXHopZwjbg2WkB0U/aye2FLBxq3VebpLJhEbgMLqePquJyK5wEU2tvYr?=
 =?us-ascii?Q?GZ1wONyeE3tyIFkEzgjM7Sy1USbZJIHSjk6D8eyeMtwjBKMLtC0IalNzmjcl?=
 =?us-ascii?Q?7MUacPVOP4MTE0W6mJrqnElo3CQIzyJdrOx7YoL8uWoqdydAOiQBZJwS3cZn?=
 =?us-ascii?Q?KEJ3RQXtSrbaB7sY2Y31Q67z72Hh69L91ZzKXl/PSvPQ8wMauwaeqBGtf/1I?=
 =?us-ascii?Q?UMAUv4SeRfGxZSisiQM9GwBkuq/a5XAI5HClo295bV6l/4knYkZFlt+3Ov2x?=
 =?us-ascii?Q?GABLJc/PKY74daNqwjnPVt3rQC489fhxjGKG3nwW0eNdReHc0zWLGLRIYDvg?=
 =?us-ascii?Q?3boyqkXz5QgTzKmQUDPfsD435p78IW9zRDdNYuW1amDTCrQTpQvxZ1FNGgtF?=
 =?us-ascii?Q?u6YcqOC6dIVgCTEf3LqxycykaLIJ9BpzwvQDmCyjJN/epaZY7VdTEWBDAWWI?=
 =?us-ascii?Q?xSAwcX6iY6m/5kFwIsVuqJTRgfpiTGHpPQfEnW67IJz9zsKkx630DEEkO7Y0?=
 =?us-ascii?Q?mfy+R862rbYl1MnNFSdR5Cwe6Y768j9kGq3IPMntW5pyqlCWHl+q2QEYRlYd?=
 =?us-ascii?Q?zUnxfXt6e05AhomGY6ishPoNkVYl/b/J7RUD0YdSAURlMRwuV4H1UW4drUez?=
 =?us-ascii?Q?7LdLG9C6CxAIOYt/2VjpXrz3dCbGBB/vxDuVPTAnlE8OrarttiH6vl66XvKb?=
 =?us-ascii?Q?VBEqY3qnWPIhSJv31f6PH6k33QN/baAs7S2sdObqMlX0PbdduqpTxlnss5dC?=
 =?us-ascii?Q?+GQtKHoHm1D1XzSTiUnRNPMcr+fHt/e/hJOY101WydHfHtwX89WDhRS+Bp4t?=
 =?us-ascii?Q?PO1fSgFlsu5Z1nfTn3mikobX7BpR2NqpYG8/nZIowMTvmaWmeNu4rP4NYruP?=
 =?us-ascii?Q?VUSx0WcXl5osR/1GQAEq5GS6setLLZn1B+DMVdXC55v5EVGfJ3EXlB444lpL?=
 =?us-ascii?Q?oki85DXtR4kWXqgUf56hR7jcOuLfcDtzzPzyxYbtgZnzOwr9B8zuGI5RsLDW?=
 =?us-ascii?Q?mu3QHUMRL6MJQhOW2PAo3Fyi6AYXM6DjGLnoap5/ylnteM2FFyVV3gxfEv/i?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VdLW+fdCFTsgo4cwq35ERz4JxBabVVvcWDeyb7zx7DKSLMDI6RrfJ3RvWodi7OnYsL9rDq9e9Q95FA4QIRdhtlVgsTOrXYCQcxGapaDJX4zTPVZUvDXgz7k12rAVOqjDAo6UUzWfahMumNbCJSuIdsqXePImyGj66NPaDZPPWYWXISyx3rUUzc8eDrp+DeQnVemIvMPFWDMx30ESrNr0e8Vsk/YNLvduiTm+qTp1qgdTxq+1/kIxr2evyO68aziOKLCnMguNvwi2xmBvr9cGwicO2HL1bn87NyQqFOhBhhJ9nmULvsGvn9u33mvg/T/vqYFjqH5gyzlGs3ROTbdM6BKLhpdTGJBBiOuO9zm5XlSLTXHf0GE4jxidaexO1G66RTvYTYzfjVNjDzRiHWhHwr/JHjrkWK3LSy5Gd+8PJ2kmj8Zbcd1UXTwPMEzcuFCXVTMxKiOUaMOIsnfbuajON0fBeViq+lY1zGkbT3RVb8xy+h+S3hWdrND7rvj0bTOl13T8lPCrDNbMZ9IdrvVC33XETUIyq8qWB+tFndpctRwdjxX/9knDhLioiryb+lRcvd4vRs0YKKzXlCoq8QBj8dO8aS7GhEh3sZpWJxA/K3c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f67dafe-ac3f-40d5-9880-08de202386d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 06:36:49.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urR9K0hiOdp7nO0k1hXHYdMp9Pm7ACzTxlEk4OmFatDEEw7a1OwNAVwJNqiJJm+5n6XEdoKHbz+rq7CYnWAGrvck9g6raxbnYsr2kX8mRQs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_02,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511100056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAzMiBTYWx0ZWRfX9+mPP3nW4h60
 OtCInRUB+qQG97puS3DBLYbpZ0TAiZhe8Sn1JuvXniTZT2XvrOgjDEMeZrnTHsNrXowQTPATk7N
 FI4/rjIR1GEz5mREkB36zxxni7y6PESxtrMsILOt8iFEjd8PzQcStQKKAurfKRN3FGnnUnqHzZY
 UNnHyKKhKAxOusoaXI91t+DV0/glIVKLqFlUPa98E8mYPkK6kaEa2LOZEQHNibwR2c5lsxAEk5R
 gBrDAZnnT74QSJxZd81D2fEmRDZcxBUFQ7tUuDnZn7G9GkObt3DFGs5vbN4dn0sKxq6OCZC6fyC
 KV/vd9+dA1CZurL7lH2UVq9osT87OeqBRMtakCRrYZp5O3NJhjCp+W9DVJ3Bmg8Xb0TK8k5d/hA
 +C98rIlsJPpyNxeN0UkNzbnBOjEJLVig+zAXghJnQwRN93Qecws=
X-Proofpoint-GUID: KvCOwA_cZBFmo7Jklzp0iOrjcjN2cBn0
X-Authority-Analysis: v=2.4 cv=XZuEDY55 c=1 sm=1 tr=0 ts=69118806 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-D80Zjvrs50afXV6huEA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13629
X-Proofpoint-ORIG-GUID: KvCOwA_cZBFmo7Jklzp0iOrjcjN2cBn0

On Mon, Nov 10, 2025 at 12:26:26AM +0800, Lance Yang wrote:
> > @@ -175,8 +186,8 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
> >   		pte_t pte = ptep_get(ptep);
> >   		step = 1;
> > -		/* We need to do cache lookup too for pte markers */
> > -		if (pte_none_mostly(pte))
> > +		/* We need to do cache lookup too for UFFD pte markers */
> > +		if (pte_none(pte) || is_uffd_pte_marker(pte))
>
> Seems like something is changed, new is_uffd_pte_marker check will
> miss non-UFFD markers (like guard markers) , and then would fall
> through to the swap entry logic to be misreported as resident by
> mincore_swap().

I intentionally changed cases that seemed to be explicitly wanting to only check
for is_uffd_pte_marker().

The issue with markers is it was first implemented on the assumption that it was
only one kind (UFFD WP) then other markers were added without correction.

Since we explicitly test for the softleaf is swap case I assumed we were good
(we check for softleaf entries explicitly):

	/*
	 * Shmem mapping may contain swapin error entries, which are
	 * absent. Page table may contain migration or hwpoison
	 * entries which are always uptodate.
	 */
	if (!leafent_is_swap(entry))
		return !shmem;

But obviously didn't read that carefully enough - mincore assumes literally all
soft leaf entries can be considered present for not-shmem and shmem would only
have no-longer-exists swapin error entries...

Really that function needs refactoring and the is swap check put higher.

But TL;DR you're right I"ll send a fixpatch...

>
> ```
> 		/* We need to do cache lookup too for UFFD pte markers */
> 		if (pte_none(pte) || is_uffd_pte_marker(pte))
> 			__mincore_unmapped_range(addr, addr + PAGE_SIZE,
> 						 vma, vec);
> 		else if (pte_present(pte)) {
> 			unsigned int batch = pte_batch_hint(ptep, pte);
>
> 			if (batch > 1) {
> 				unsigned int max_nr = (end - addr) >> PAGE_SHIFT;
>
> 				step = min_t(unsigned int, batch, max_nr);
> 			}
>
> 			for (i = 0; i < step; i++)
> 				vec[i] = 1;
> 		} else { /* pte is a swap entry */
> 			*vec = mincore_swap(pte_to_swp_entry(pte), false);
> 		}
> ```
>
> Wouldn't the generic is_pte_marker() be safer here?

pte_is_marker() now :) I fixed the silly naming inconsistency...

Cheers, Lorenzo

