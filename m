Return-Path: <linux-fsdevel+bounces-66770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79610C2BBB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3712F188328D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0631030E842;
	Mon,  3 Nov 2025 12:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iDd2suBZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bAWX2+Ng"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2714E313529;
	Mon,  3 Nov 2025 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173314; cv=fail; b=ADWVlBbGR6kP2Myti467WFrRZ4TxpU1pcHeFpEC0/IxZr7wTW4asI6fJ8TCEFi5Ht4uKnX+pPi6omWfMJQlfzh+oh1iVkC6lLT670MAhy4fvxVcvJakBjebgMPJRyuGwVVxl1C+M81roI2IBr5gmyTAR/IwbPnIu2Uh+js55bAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173314; c=relaxed/simple;
	bh=Qt6ov0F68f9RJQJuPoqHMwbTsBmZ6ZAwdCIuCVy+P0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=B3i57JxpwHPLkzirFR+ya0Rzv0Jjg98KYigL+G8RCZUN533nI0smsPK5Vlip/b0CP9kxii6lWdBKDK7WcomU3tlimKbaJkCbv/6mEopYVVX0+KTJI1g/5Vwr7IcZStQ+gNEkmxh+VpEmKbYnFhKDcjigmKp5ng5j4giNkJVc4ec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iDd2suBZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bAWX2+Ng; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTm5m011561;
	Mon, 3 Nov 2025 12:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n1elD2KxJdX09ELZo0YYk/oZImFOlJN2Ko3RGZS4bMA=; b=
	iDd2suBZTrfKwb6+hgZ2JvlttyUFsAy5iha08/tVQ82Qly90voFVRdFyLSJclbN4
	M/cEgMjzPOas8jWi0ZgYEM82rMbIlSVpGYc8T87P2BtYTpSgub+nMAn+0vrE1oT4
	Zc7FmIIDtCr45GJNT7MS8WbIgUALTFWeO1m7TjC8Slv/DkH1xy3Xvhbp11UPHYeY
	1MmCug/hTiTRxzADu8rpollUei3cCz23noq+NlvlanmDSgy+2XCzAEhP9bgCfduy
	HRd+Cn5G+NG+uCcHxQLkGZVZLEnJb9FSVUtIf2zzAR9yvnGbIB2e3Q9S49eLZwvk
	JAe0Cojxfsv81cXorDR3uw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vep009g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:33:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Bx7kP021025;
	Mon, 3 Nov 2025 12:33:20 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n83ev0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKpMCBXui5an7c8xyNPRbSJuOw5WMpSY6ZJ/Ba64Qh4CysiYSTtWqIaRtFYZi/uMDoC/R+0uIDQmMrV08uu+8yH875wnXw7Miv2f2RgsSIkFXm55kMmmSkUT5w3OAniaQz0KKwHzpzIp9FU/IqFXnn1aD7oB8x1G3MJmqyseDqEjCLBNbKSVnTPJaJsmFdEDN4J6obUWSAX7QSNYpUyVqs4WXLrCt7sPK/e1rz+O0C48/jmEnb6TS+xT3m3lW8rmuxDuSGTJ+meo1immd9THrFvpya9/9owOK0J28PUvZsybfJwy7Vo76Hw8SVXYTMzO5oggp7O+L8GyFI/XEaDSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1elD2KxJdX09ELZo0YYk/oZImFOlJN2Ko3RGZS4bMA=;
 b=k8gNxTa5wAYoOjBJwapaUsJfJliDyBU+Gb00+Bv+Tz1557GG7/0xonybsfSpSkEOEZjUeP251veNCxN4xPiCaa7K7RTUvmgoZvvnLAhBfqDW0cMqdDIhwnmg+NmdL2tWKd/NJHTu8WOHjgaoRaw28D2Cp6UKNLsDuTQhMHm+adI7kOrjThKkduO579EIdoFnja76ZRZKo3QfdHn4mbFvLl+I/SmOmntEuXqPOegutNiDY9ktYqE0V5oiksD+JmDQASDlpHBS13RhCbcFAmlnylLkt5VJ6krRF0ofFryhYUzPJfMN9v4O15c7cNU/l3ECvaJ/xgQHMfUXyEl0JqIpvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1elD2KxJdX09ELZo0YYk/oZImFOlJN2Ko3RGZS4bMA=;
 b=bAWX2+NgB1v1MARfgHS8p+MYk6WwXuoDeyh1r9pXgV9AgIgn6GYSH7Dkjsjk6WrHQgXTVxW/47luyJTePathMO+dfPbqm12erg3h/OIUWQ2UvoC6IfHAgza1S5W9mFRvZY6qtFF3iWJnOaiKIZNE1KtZfuKx/OZl4O7MpwGSdmw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:50 +0000
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
Subject: [PATCH 14/16] mm: remove is_hugetlb_entry_[migration, hwpoisoned]()
Date: Mon,  3 Nov 2025 12:31:55 +0000
Message-ID: <c5ee5f5ef6d9ca513487cacf36dea0c418ee587b.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0080.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 22141c06-f34f-44db-a4aa-08de1ad51a4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QoSA++OxI+fjGmPxu1J+QnCOOmhfIK5WWllSPCnU4zJ9xLGqoKsO/w968hnv?=
 =?us-ascii?Q?vPHN7UdudLGyKGPGDFSbG0WfRF5pmkyZPocAdnhx8Zj6wRQHk6Pb8/eNjJ4y?=
 =?us-ascii?Q?LKmtdFrbcgrlLwAUCY+uIiFJwUlqH4510B9Lg6p49W/MaBpKdECeMvg5msop?=
 =?us-ascii?Q?GxoptDTl+/w/vHVeZju2edU5rQniiOJdRJZHCy/J32DZE43rwq8ZFHECaJYY?=
 =?us-ascii?Q?9W5gOUznqAxbAFdcCvFH0yIe0ZR1VkUPDdChojvpq0fSQKQyTOll9+cwb4LI?=
 =?us-ascii?Q?QfJAdYAsGkje2Odp7F0z+nVVgwqypA4tgeCrp2GN9Fh2k8NyqjFCDWlUBajz?=
 =?us-ascii?Q?xX1hiq6gU5rkKzImJCie3YHpOdLtiVU3sCwn9b+fB8cT8OI+Pa1LSDlH4Z85?=
 =?us-ascii?Q?SLbIyjQRyXjvxbUZLzXFjFkUl3WINabBy79FM1LA4bI7HwMUBiFU97KjtMny?=
 =?us-ascii?Q?O8G5fWbFcR4RrNtJwy5ERcIvZHLWjPem4y/jTyyJJ9bBB7Cqr1MWIko8IDQm?=
 =?us-ascii?Q?Xp9jHmzwop9zNL7pZcsB8h0WowZArOYIMEq7Zr1kA6PAwa49d35yfMmORdIM?=
 =?us-ascii?Q?SPffoP7+n/lu+I0wPoarswOwtEqebKvkjBU21HgSc1qGirgrppQlsOTdftzI?=
 =?us-ascii?Q?uGx7yLWEXczfOVwoFqjLRc6hZmKnZKLlEujbPUEAnc5f7BdQ5p+ea+QtZCMS?=
 =?us-ascii?Q?FGLiJl3pUTgfb2B3ct1mm5KXT8PZL3ul9vuwEW1nxlKQCFbsQGxrowG+rObN?=
 =?us-ascii?Q?96ymOPcS+RvR247ZZtjU79rsp+0Pz0d//dFpOcoQ+5Q/G+GESqOhtFOXYWzQ?=
 =?us-ascii?Q?0YN+Wqalk7nMBMZVQ6ons4cdSnRDuLiKZqsTQ0HCIQwIpUKP3SwXiYAqAMza?=
 =?us-ascii?Q?s9qgUu1lamqMEMhwWhWrmb580s6nomJ3+gZcJ1tzoyDiFaXFhM44qt27rqR8?=
 =?us-ascii?Q?xqwIYeXcSYjIf3jy0Tbs4/pDyeWbsFu/UNEInWhbhGGd79hcW5ZKETgxXhM3?=
 =?us-ascii?Q?akg/HmvxTmugG/yJSyc4vzXm5NjjQb1IfV9S2Li5prmoSRpQfvP/6D1jXI7P?=
 =?us-ascii?Q?KYedsmpXCvucbhuTjrrfMrNXpvXXP598FwWgjR1dLO5StkhFeC5U4/gH69PQ?=
 =?us-ascii?Q?EcenkIRKKEDN64iuVyToAQs5jiCJyDl9kpfV0WuMeUEdRGSJ/62w7G0de4Vv?=
 =?us-ascii?Q?r/+NCs0Ut6gNa2wo1py/MB0Vre+VcCopDxnabtn9wZl8zEOT31fvmYahgDfJ?=
 =?us-ascii?Q?ZoGOXIqhqV7BypIU/qvpWcclXnS8aUljRaF+8dO35y690Ua+tGGfbBnv2eFe?=
 =?us-ascii?Q?a/K3zVSpU7OM/xqCkoQd+yy7ywMg6l5dg/5fIkA918q5T7o3h3b3I5kZW4Y2?=
 =?us-ascii?Q?cmUpDXHOb54zq++7QU0zsV5jbG9nJyx13Py4liOfJnQR/m/pHp6YychSnAco?=
 =?us-ascii?Q?0TKn4QG3yLZx9M3Uobodz7pKckyWx/sl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rv34q8Mq9CdsFw7/x84cKbGv8tkvBAGLzpLohkUcglpQMHqJjmLSiKJecLyD?=
 =?us-ascii?Q?C1NJdawUnW4pd9i79xjBOz4o9sLlvuaFE/16fxJfQMWJ5yNi2Zgfio3luiHq?=
 =?us-ascii?Q?SFjEl/9Vq0Fc9V4NcCwuV5NQ37vfEBoUxGLzkWLpvYj7OQyw+qyjnTPXgppz?=
 =?us-ascii?Q?/CHnXYMoDPkjvosFntz9GNDyW6lXbVPmxvmul0giRNS9kuDbUAvcwCUHfjQT?=
 =?us-ascii?Q?pZLZy1NqJwImxR3WacNs5TI9d2TWoGbZwQHjyTZ7TIAa/IBc2UUGUwNKkFza?=
 =?us-ascii?Q?qbG2hC70Lovtx1W4m3uM4wsYCLE5ownBPiVNo2mXbCejHMqNRAXfInqrmV/C?=
 =?us-ascii?Q?CwMQQuiZON5/Hrry0C+rifAdaShIB1vZRrJdz/0RQdO3+kqVK/LBL022l6RW?=
 =?us-ascii?Q?U7lCP1aFIRNP6nIeLL3LbKr9L/hw76WUbY61r8AmrYcbqDvfjXpJtTMnNqEz?=
 =?us-ascii?Q?NlZYp1cBPSdrBYDzoSQN5qBCjygV4ro63dAzRskk3mnbTSqKY8KcLH1J3A9/?=
 =?us-ascii?Q?+NvBA4pTL9GDZKdZTU5V6BMR92FvfL1mND5/9RFbMHoEhRpg+Uq0xl4zqkP3?=
 =?us-ascii?Q?JOYQTVXe8iMC8oRVw/06fpDqAqY/ZTRISBoDE7gCVPzXOpD6qH5H1HhUsf6X?=
 =?us-ascii?Q?NIhpE8cBr1u2HFvsiN31UBdc0uAvOuN2IC6zhbBaBrMG4oojw+6yZ+m9pXFl?=
 =?us-ascii?Q?y1wtU1kQ2a1ouuYsYCk7tv8cUMf2wooljX1NC8FgNXHGKXcGH8PmKVNFR/QJ?=
 =?us-ascii?Q?sUs1gRPRNrh4qVSSFrpjaQKCpjASU1OwBQupkLMcDYajyXtV0hUNWQofr0J2?=
 =?us-ascii?Q?XjkZprImO/u8j6gOZQtBbjRQ6jDTAC9hGildfMLxAMsIqh7ofD4+WtwaDTv9?=
 =?us-ascii?Q?qtrtBE497X4JIvlknBrxC7toY4MAon7RpSqglGeGrBxCMrkM6sgkvl9xVgxJ?=
 =?us-ascii?Q?ArLH+Pi5pZYdfBb3xEBVP8HjD79nHLXC8UdBzh/5XdCtknViuPy5iIFoOzIP?=
 =?us-ascii?Q?2zT7El2OU3vjEPGZ/7LdbGjrCJMB/RXbeCaVuK2fRBGCVEKbWyrvH32bCg+Z?=
 =?us-ascii?Q?5DhNb1XfMh/uxbomz1aiXbLVG//ioB5Sn6cixFxiDEqyq9PACkaEt997vOtu?=
 =?us-ascii?Q?q8kaTNIe2dZuAZy8TEz8zbw7+sblLnNCq92KKnS6/R39KErfQAB0f2d501p/?=
 =?us-ascii?Q?sPhAhc+iCPgwwu2MvUxE0DpHADje9W3NF5qQH0Ow4cMpolVNQIjKc6A/c9V1?=
 =?us-ascii?Q?WdIvYVyOgC8PB4yDEG+YtRnGnFU1QAZnJ7KUB6DH/1kXNB0KYwnTg8Cz3+bF?=
 =?us-ascii?Q?m6LiPXHQW8OdVLk/lVGkAkhY6P/GnSV8nZKgxSXJ08pFi+IeCS28d6w5wKVS?=
 =?us-ascii?Q?HlWHRwX2hEJMKj7nFe8qeNsemxQ2aezZayTgZEwxdkc/tuTPQ7WKPuz8DSTl?=
 =?us-ascii?Q?QpsW4YI4G0HQzav7X5+RbYzhWeWSK36A37X+hLldK/1C9+3h1OMxPb5zcyNP?=
 =?us-ascii?Q?vlqwsUHJxN5BtkxlCQjIA6OII/O9oLuce/efNV7xHSAty+LUHvMArsQN+pjj?=
 =?us-ascii?Q?On8b5HSMYmBop2ruvFKtR38gioZ8QbbgEI5nDvKwIXA0CEyvpNvDyF3AE815?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sDpSDqGNN409ISE1jG6okA8zwSMwZFK10WyElYW8FWyM+WSMNqcSPkE/5GOu6YxpoGj2LWVba1ZdJXVZng1paNxQaVsbTT6JSN3LVv8TvcEjZ0V5/CO7606i9Ww+93KxnwSp/OzbJVnHVdLQOtnWj8l1jKyyluWFZlCSfHxe4ysEHqxhPeiCjcr1IarW+Dl/fxbaqULZEdtyrvd9H9et2CP9dCZjL/uZbjwS2SM2AXVbc8jhyl/SlTeNE4pDd3uqRwdR77qpeTIG22UBSia2sMKUixRi7HEC2bC4cAlvXkuIskj3awpOkA9aVDwQNfET5slnpSixqdQb9Q5V6WJYTCPtuqH0aDvcW2mT6CNQgpT8LL6HJwM5WudefN8fVwSHqD1NyodEQ9wltYqoOYUAN9742MPQWWM8c6M6AXYEAnAExmhTqXU7CcQXBDKuwr4kiUz2PR+PyPnaxQDgFJAosLxcc64MEz9lFE8jl1Fhs2Nfw2k0oyGs27Yi+ICScMGgnPXPAYLO/yRZiOnHZ6YghbQNdYT6fsVCVczuMX5UA3mBt+6LzOD8tYdSAvzxjlE6McZO/6Vc00jjk4ARspycUEX1+ly52cZ+VdMXwSsdrhg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22141c06-f34f-44db-a4aa-08de1ad51a4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:50.6332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBwjQvShYdZWNAf1Vj9M+QcEY1lwnetWH1DU1iljJwTEZvzVWH4WVfcYyOoau6r72Ap0JCvDN1eW0QLYTeIVK8Yt+v8BBhW1FkuWDh02a0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030114
X-Proofpoint-GUID: 7r_xqn5qy8IBPfOFjJGMJRVTSGn4uU_6
X-Proofpoint-ORIG-GUID: 7r_xqn5qy8IBPfOFjJGMJRVTSGn4uU_6
X-Authority-Analysis: v=2.4 cv=B9m0EetM c=1 sm=1 tr=0 ts=6908a111 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=gaN7zjf0O2erDMybN6AA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfX/PDaucsctCOb
 gAGIlnqRM/U02y4ZrjVl9jIb09EORSGuIKQItPve2VErczqHitMRJF9XRQrPKDsQAb2eXc8lfKr
 bgfBFzlcBOYKxEPUdxniCxR+Owvj93ZPca/bgSDIFpsgVwpw3Lo0V/KUQdW5lFfsC/zS15Y9Jec
 vLhc4TeHAJ2PMY0xWyBH1JZwMIqLeEabCwx7taCqxCvZdCOg6n+YxF6vushwn/bcYoU4/36H9IK
 VsqViSbkVT/VxvOVWU/YNxeufVRB03SLinYO8wuNthdtVsWGiw3LokfyGdkWyWA2ymyVzHtiP2X
 0k4C4gfEnEx6M2oKcmdWwBjl9/dsv5Ucpaxek9JEQ/NQbv7iCLUmS/iRSS/VS5tVGu4PSH7HtMm
 MaoXz1/vrv5BjQNqRmcdPvPKYhxvOQ==

We do not need to have explicit helper functions for these, it adds a level
of confusion and indirection when we can simply use leaf entry logic here
instead and spell out the special huge_pte_none() case we must consider.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      | 19 +++++----
 include/linux/hugetlb.h |  2 -
 mm/hugetlb.c            | 91 +++++++++++++++++------------------------
 mm/mempolicy.c          | 17 +++++---
 mm/migrate.c            | 15 +++++--
 5 files changed, 69 insertions(+), 75 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 1df735d6b938..82532c069039 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2499,22 +2499,23 @@ static void make_uffd_wp_huge_pte(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep,
 				  pte_t ptent)
 {
-	unsigned long psize;
+	const unsigned long psize = huge_page_size(hstate_vma(vma));
+	leaf_entry_t entry;
 
-	if (is_hugetlb_entry_hwpoisoned(ptent) || pte_is_marker(ptent))
-		return;
+	if (huge_pte_none(ptent))
+		set_huge_pte_at(vma->vm_mm, addr, ptep,
+				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 
-	psize = huge_page_size(hstate_vma(vma));
+	entry = leafent_from_pte(ptent);
+	if (leafent_is_hwpoison(entry) || leafent_is_marker(entry))
+		return;
 
-	if (is_hugetlb_entry_migration(ptent))
+	if (leafent_is_migration(entry))
 		set_huge_pte_at(vma->vm_mm, addr, ptep,
 				pte_swp_mkuffd_wp(ptent), psize);
-	else if (!huge_pte_none(ptent))
+	else
 		huge_ptep_modify_prot_commit(vma, addr, ptep, ptent,
 					     huge_pte_mkuffd_wp(ptent));
-	else
-		set_huge_pte_at(vma->vm_mm, addr, ptep,
-				make_pte_marker(PTE_MARKER_UFFD_WP), psize);
 }
 #endif /* CONFIG_HUGETLB_PAGE */
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 2387513d6ae5..457d48ac7bcd 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -274,8 +274,6 @@ void hugetlb_vma_lock_release(struct kref *kref);
 long hugetlb_change_protection(struct vm_area_struct *vma,
 		unsigned long address, unsigned long end, pgprot_t newprot,
 		unsigned long cp_flags);
-bool is_hugetlb_entry_migration(pte_t pte);
-bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e797abdee04..6c483ecd496f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5552,32 +5552,6 @@ static void set_huge_ptep_maybe_writable(struct vm_area_struct *vma,
 		set_huge_ptep_writable(vma, address, ptep);
 }
 
-bool is_hugetlb_entry_migration(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_migration_entry(swp))
-		return true;
-	else
-		return false;
-}
-
-bool is_hugetlb_entry_hwpoisoned(pte_t pte)
-{
-	swp_entry_t swp;
-
-	if (huge_pte_none(pte) || pte_present(pte))
-		return false;
-	swp = pte_to_swp_entry(pte);
-	if (is_hwpoison_entry(swp))
-		return true;
-	else
-		return false;
-}
-
 static void
 hugetlb_install_folio(struct vm_area_struct *vma, pte_t *ptep, unsigned long addr,
 		      struct folio *new_folio, pte_t old, unsigned long sz)
@@ -5606,6 +5580,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 	unsigned long npages = pages_per_huge_page(h);
 	struct mmu_notifier_range range;
 	unsigned long last_addr_mask;
+	leaf_entry_t leafent;
 	int ret = 0;
 
 	if (cow) {
@@ -5653,16 +5628,16 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		entry = huge_ptep_get(src_vma->vm_mm, addr, src_pte);
 again:
 		if (huge_pte_none(entry)) {
-			/*
-			 * Skip if src entry none.
-			 */
-			;
-		} else if (unlikely(is_hugetlb_entry_hwpoisoned(entry))) {
+			/* Skip if src entry none. */
+			goto next;
+		}
+
+		leafent = leafent_from_pte(entry);
+		if (unlikely(leafent_is_hwpoison(leafent))) {
 			if (!userfaultfd_wp(dst_vma))
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
-		} else if (unlikely(is_hugetlb_entry_migration(entry))) {
-			leaf_entry_t leafent = leafent_from_pte(entry);
+		} else if (unlikely(leafent_is_migration(leafent))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
 			if (!is_readable_migration_entry(leafent) && cow) {
@@ -5681,7 +5656,6 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				entry = huge_pte_clear_uffd_wp(entry);
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 		} else if (unlikely(pte_is_marker(entry))) {
-			const leaf_entry_t leafent = leafent_from_pte(entry);
 			const pte_marker marker = copy_pte_marker(leafent, dst_vma);
 
 			if (marker)
@@ -5739,9 +5713,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 				}
 				hugetlb_install_folio(dst_vma, dst_pte, addr,
 						      new_folio, src_pte_old, sz);
-				spin_unlock(src_ptl);
-				spin_unlock(dst_ptl);
-				continue;
+				goto next;
 			}
 
 			if (cow) {
@@ -5762,6 +5734,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 			set_huge_pte_at(dst, addr, dst_pte, entry, sz);
 			hugetlb_count_add(npages, dst);
 		}
+
+next:
 		spin_unlock(src_ptl);
 		spin_unlock(dst_ptl);
 	}
@@ -6770,8 +6744,10 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	ret = 0;
 
 	/* Not present, either a migration or a hwpoisoned entry */
-	if (!pte_present(vmf.orig_pte)) {
-		if (is_hugetlb_entry_migration(vmf.orig_pte)) {
+	if (!pte_present(vmf.orig_pte) && !huge_pte_none(vmf.orig_pte)) {
+		const leaf_entry_t leafent = leafent_from_pte(vmf.orig_pte);
+
+		if (leafent_is_migration(leafent)) {
 			/*
 			 * Release the hugetlb fault lock now, but retain
 			 * the vma lock, because it is needed to guard the
@@ -6782,9 +6758,12 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			migration_entry_wait_huge(vma, vmf.address, vmf.pte);
 			return 0;
-		} else if (is_hugetlb_entry_hwpoisoned(vmf.orig_pte))
+		}
+		if (leafent_is_hwpoison(leafent)) {
 			ret = VM_FAULT_HWPOISON_LARGE |
 			    VM_FAULT_SET_HINDEX(hstate_index(h));
+		}
+
 		goto out_mutex;
 	}
 
@@ -7166,7 +7145,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 	i_mmap_lock_write(vma->vm_file->f_mapping);
 	last_addr_mask = hugetlb_mask_last_page(h);
 	for (; address < end; address += psize) {
+		leaf_entry_t entry;
 		spinlock_t *ptl;
+
 		ptep = hugetlb_walk(vma, address, psize);
 		if (!ptep) {
 			if (!uffd_wp) {
@@ -7198,15 +7179,23 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			continue;
 		}
 		pte = huge_ptep_get(mm, address, ptep);
-		if (unlikely(is_hugetlb_entry_hwpoisoned(pte))) {
-			/* Nothing to do. */
-		} else if (unlikely(is_hugetlb_entry_migration(pte))) {
-			leaf_entry_t entry = leafent_from_pte(pte);
+		if (huge_pte_none(pte)) {
+			if (unlikely(uffd_wp))
+				/* Safe to modify directly (none->non-present). */
+				set_huge_pte_at(mm, address, ptep,
+						make_pte_marker(PTE_MARKER_UFFD_WP),
+						psize);
+			goto next;
+		}
 
+		entry = leafent_from_pte(pte);
+		if (unlikely(leafent_is_hwpoison(entry))) {
+			/* Nothing to do. */
+		} else if (unlikely(leafent_is_migration(entry))) {
 			struct folio *folio = leafent_to_folio(entry);
 			pte_t newpte = pte;
 
-			if (is_writable_migration_entry(entry)) {
+			if (leafent_is_migration_write(entry)) {
 				if (folio_test_anon(folio))
 					entry = make_readable_exclusive_migration_entry(
 								swp_offset(entry));
@@ -7233,7 +7222,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 			if (pte_is_uffd_wp_marker(pte) && uffd_wp_resolve)
 				/* Safe to modify directly (non-present->none). */
 				huge_pte_clear(mm, address, ptep, psize);
-		} else if (!huge_pte_none(pte)) {
+		} else {
 			pte_t old_pte;
 			unsigned int shift = huge_page_shift(hstate_vma(vma));
 
@@ -7246,16 +7235,10 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 				pte = huge_pte_clear_uffd_wp(pte);
 			huge_ptep_modify_prot_commit(vma, address, ptep, old_pte, pte);
 			pages++;
-		} else {
-			/* None pte */
-			if (unlikely(uffd_wp))
-				/* Safe to modify directly (none->non-present). */
-				set_huge_pte_at(mm, address, ptep,
-						make_pte_marker(PTE_MARKER_UFFD_WP),
-						psize);
 		}
-		spin_unlock(ptl);
 
+next:
+		spin_unlock(ptl);
 		cond_resched();
 	}
 	/*
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01c3b98f87a6..f5b05754e6d5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -768,16 +768,21 @@ static int queue_folios_hugetlb(pte_t *pte, unsigned long hmask,
 	unsigned long flags = qp->flags;
 	struct folio *folio;
 	spinlock_t *ptl;
-	pte_t entry;
+	pte_t ptep;
 
 	ptl = huge_pte_lock(hstate_vma(walk->vma), walk->mm, pte);
-	entry = huge_ptep_get(walk->mm, addr, pte);
-	if (!pte_present(entry)) {
-		if (unlikely(is_hugetlb_entry_migration(entry)))
-			qp->nr_failed++;
+	ptep = huge_ptep_get(walk->mm, addr, pte);
+	if (!pte_present(ptep)) {
+		if (!huge_pte_none(ptep)) {
+			const leaf_entry_t entry = leafent_from_pte(ptep);
+
+			if (unlikely(leafent_is_migration(entry)))
+				qp->nr_failed++;
+		}
+
 		goto unlock;
 	}
-	folio = pfn_folio(pte_pfn(entry));
+	folio = pfn_folio(pte_pfn(ptep));
 	if (!queue_folio_required(folio, qp))
 		goto unlock;
 	if (!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)) ||
diff --git a/mm/migrate.c b/mm/migrate.c
index bb0429a5e5a4..8f2c3c7d87ba 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -515,16 +515,18 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, pte_t *ptep)
 {
 	spinlock_t *ptl = huge_pte_lockptr(hstate_vma(vma), vma->vm_mm, ptep);
+	leaf_entry_t entry;
 	pte_t pte;
 
 	hugetlb_vma_assert_locked(vma);
 	spin_lock(ptl);
 	pte = huge_ptep_get(vma->vm_mm, addr, ptep);
 
-	if (unlikely(!is_hugetlb_entry_migration(pte))) {
-		spin_unlock(ptl);
-		hugetlb_vma_unlock_read(vma);
-	} else {
+	if (huge_pte_none(pte))
+		goto fail;
+
+	entry = leafent_from_pte(pte);
+	if (leafent_is_migration(entry)) {
 		/*
 		 * If migration entry existed, safe to release vma lock
 		 * here because the pgtable page won't be freed without the
@@ -533,7 +535,12 @@ void migration_entry_wait_huge(struct vm_area_struct *vma, unsigned long addr, p
 		 */
 		hugetlb_vma_unlock_read(vma);
 		migration_entry_wait_on_locked(pte_to_swp_entry(pte), ptl);
+		return;
 	}
+
+fail:
+	spin_unlock(ptl);
+	hugetlb_vma_unlock_read(vma);
 }
 #endif
 
-- 
2.51.0


