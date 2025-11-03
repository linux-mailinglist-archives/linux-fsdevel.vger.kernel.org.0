Return-Path: <linux-fsdevel+bounces-66762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A5CC2BB49
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0AE4188FF1B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8360430FC3E;
	Mon,  3 Nov 2025 12:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JTNV4tID";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IveFWjeu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E530F807;
	Mon,  3 Nov 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173253; cv=fail; b=mYgDPhoHx/iUAMmim0A7W5vbTKNriRd2WtnzIKEk6MaAmkc4OpKBpLKCgyDiyjGuXyM09r83UK3oFTqPgXnT11/ObVa3MFI+yfE0QijD75St5nU3x5j/+4QqUu6hv/v8Q0YJhvfO+x+BZXO/Alc9ete/iaV/ZCccwCdbBmP6oR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173253; c=relaxed/simple;
	bh=Qo6daWNbBRlUhxp8OkqMSYXUjCxLzJ8bLqEynR0eIgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aUa05jwavaYIB8etj71v3M0bnrCT8dKVXf2nQA1OvBbrA42xwJmLBh4I2pOWA2sxDt5Pc1qaNblkBoLmD7LDMSLhWuqbGKJYs5I4NSpLOq8BCM7Wtn97oEfoCZFVBiPyMvWd9cnTwY0zayDaE/j0MirjQAUW3FEs7DcchbcM3Do=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JTNV4tID; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IveFWjeu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CFDNc018204;
	Mon, 3 Nov 2025 12:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Xb2WuoV1n9d7enOgQK2mVmgEDn5DmGN/bpAYSAaohe0=; b=
	JTNV4tIDc2J8RwGFKFb1abGOV8q4oUOfDiTjTpBCUFldKC/pzRSGFCW1CVslpkD1
	GELjye8GKLzg4zf9IESYx+rBNAz2n9cux/I8b8DbUAjnbgMgpbBfkoyq2Ht2rMey
	MvIrGGrxw4wTNEu5lSgNHA0+cvWnh664BYRl22G1OLwZNgZ0+kJxMaYjpw81W0IH
	FW+/e9dEyy2IZEudyOLI9HsBVuWTDvGgebwzAzG6Zmy+7lzT7vSQXVK9c9U9djg7
	ZNBNX4jn6UrYRzaG6U09fcuAH2CSsQBiBYSivHPIke0ScjpJEjawDOwe8qUyoBLm
	KeKZnEJT2SKRwyYdG1eXVQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6v7kg0wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BVq3h039882;
	Mon, 3 Nov 2025 12:32:24 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010026.outbound.protection.outlook.com [52.101.46.26])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nhux3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+b5Ewn71jlPbkv87ULG1XeE2wkItt9qP7MxJoxEHx6sYw0ebWItILuLSFOMyunP2Rm6Q8GTVWQ8DzGfmiWxnQlA7gxBSTf12QxEQDLMaJgrFNQ8b9pWnddPle2DAf8eRAkCCygguIf65YkRpicbV2UYUSIez6uK+uzQGEvCfTh5MYNVKn4lN0u5s6yhYpkH7fT0CQsQB/GCp3tGBWCKMB2kHKpcZUMluPA2US0FbMjF+G9B3pAV2IEB7yVnU9dWMIxQuIqM2yb8FGhYQNc1x567eG1Y6eNoRaHejmv+P5LDCrPjTM8G2EcYvBeSzb8O+NdUA5py4lSKKHeSi0oiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb2WuoV1n9d7enOgQK2mVmgEDn5DmGN/bpAYSAaohe0=;
 b=NtvF1HTFSgj1tWIjiE7rclSE1IlQVtVyOSaO9wTj9eFFXsyhfYvG6cUthH1WpEd8RmftYtAmhDCMW+WMKW5wX1x6KMe5VmesbeJxkd5PsU7bdO3d5KoiEPALzRHvRqNd6XhF5wACW9oq12/hqAJTXtMgPnNtBh4kfdmBLpRyBuXeH7H6xWv53pLcApc5PbAbLCTcZIULBvS6r7Oa+byGYnJR6h3CuNnlvDrCqC6Q1XwvVasp4SLmYGlbCYLITFYLH8PutxA+85xFDTBzx+SIytFVJayXzSrULg+TrVHCicrk7jB8JABXlcx8mi5XLLzHrFvdsFhykfC4VJLHDmW+Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb2WuoV1n9d7enOgQK2mVmgEDn5DmGN/bpAYSAaohe0=;
 b=IveFWjeuTm8neKaJYd+xj2N2Yyb7poONgFco+vsI1lYxX4M9a6Ttj03Un72KariaV6R84uDptff/857AUVPDA8+Flk8KB4lsycliomteRR/OUVktcpaxrm/hrtBWatsEY8lZHhmeVkua/79CtyLHEN+pxuptcpBikUD4ixrThEM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:20 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:20 +0000
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
Subject: [PATCH 04/16] mm: eliminate uses of is_swap_pte() when leafent_from_pte() suffices
Date: Mon,  3 Nov 2025 12:31:45 +0000
Message-ID: <ebb295656b6ecf9e40262fcd8e28ad7f23641b58.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0128.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: ae58ccca-34de-472f-ab20-08de1ad50828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fjzAqxr0RBw9klXJ9QecXtMab3h1EeQ/wfhllpR8m9al9dfea7pGG2pIZ5BV?=
 =?us-ascii?Q?80VFXBSemx7ViiKbFOTx2jLwSg4N+VXuY56DS4DNRPOiGqraqiTm+yBnrz56?=
 =?us-ascii?Q?Wr4o/81rhU1J+bvJk28nY/M54XmDtEFhV8oZr9H9VDMlWr0eVIyJhEejljLC?=
 =?us-ascii?Q?t9q3knL+/6YyHe4uOY1s52a5ZXoUdFlF1QgNjb7XCwaKJjbeklGqQ4TeSGE6?=
 =?us-ascii?Q?MZi63yxet8N482qTCHypRks+uo5C77vfKWm4pB/OdALOnp6LPQtX0QbYK8Jv?=
 =?us-ascii?Q?0+SXXkY9TyHfUk1lSz7rD/+1nuXaThAVyX4ESDJCmyZuv5Jb5vWP209qQbk2?=
 =?us-ascii?Q?oLjOXUxHbLezL44BlEgWECHu3E/dbkUrm2aq4zHd4iWKHNwCZhbKxiuVFk9f?=
 =?us-ascii?Q?5HXVe4i9Hjp3AhvrGldAEQdH46uJNAurUvPX3yRffgsOIF4rQHw3O7QCY9Xq?=
 =?us-ascii?Q?81PeJ0naLAv7roQdY0M1+gs1VXRKSPpC5jHP3PbadFJGYuG7+kGmVC3zSQuu?=
 =?us-ascii?Q?0DCWnuKKi05Kbhx2mscZDQHMi3Pbt6qecNW5lCvJfBwayK2rb9SE9JnsjQFc?=
 =?us-ascii?Q?CieEAMjMGKKe4SnnLHbMTS+as+ePXvXz9iF5NQXFBwanKaAweXUGRLuj8bUB?=
 =?us-ascii?Q?trogM3jkohSPmMj2y2uap8EUXngVC+6xSpdCuqtiCZQOLcs4B6Peel3kHVTK?=
 =?us-ascii?Q?Ob9IJVj68fXaypGjRTiaQ6swanRt5hqHYl5CM3M51bktaNYJIskyDuAMbbBX?=
 =?us-ascii?Q?R4xX99WKvsxcQ428gcoDEOjDSvFE2LBh5BqvL5pn7ErhpAE57fT6Rpyjlihj?=
 =?us-ascii?Q?gb5zJv2Eytw+NKv1fq05lda8DyCtb34sj6Zg3emEXTkvRnfjUEQj7iMh5W8+?=
 =?us-ascii?Q?cuENO6+LkDtpb5OnjhvNSRAUZ6BWKQArybApWSU+NjUB4vHKRIMPG+keCYFN?=
 =?us-ascii?Q?k6MpzDkbK1f55lV2KpaQqIoiEDEWMZErZBQWMKT6Hc5VfODxm6KRKLfi2UWn?=
 =?us-ascii?Q?V41hQpbcAtxAlDTJkOkrWEOpnsDZwuEpxUHer8SKR9GON+5LpDJXnnsp1K06?=
 =?us-ascii?Q?LQcM1/kkxWnNvsdecygHDZRE3SgkPaRqk2qro4GUIjiOzfN2ruYrzhE+JAbN?=
 =?us-ascii?Q?H6X2an6yld/2pLmT3J1tboigqyd6sQiQ12uvGg3uf15sFXiChxof+A0lPDUz?=
 =?us-ascii?Q?fK0+RXFLiFMoYY2Y09McdKidF6JxHgx/LciZNKfpvORfVL896CbyghuIpP4I?=
 =?us-ascii?Q?lT/ouh4uzO+OIrNMu/v2vJECYb6xZ4jP5diQdcOKcGLpooPsszLMI8W4kHgW?=
 =?us-ascii?Q?/T7FQ6+XkigAtSZI6TLuQgDMiM2IIeO5EQAp0reUGttPtecMlmFiKWdRem75?=
 =?us-ascii?Q?/ho+rPFR2gcGJS72MMoAJUISATwjLlY1QjTplgOC9BktA5sQhHdDM6f/jv6t?=
 =?us-ascii?Q?hbjph+MNZkDhH6gT7FlELnb6LXo3PUJW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8r27DwHGGA4/1hi0WECzdFBjAZNfjZ2LRQPauQ2WvouWIR9CA0qd5f88zZd?=
 =?us-ascii?Q?lEXHq9sdaFqIzQCnbGQX32Zsd7BVdCZQngUOivZo2XcMtfjfwHBbpSiouutc?=
 =?us-ascii?Q?u4GbKVopIh1wkeIsEypqIbOQF8vY6ES0c9QX2Bnjb7xZ8MVHEMQTKbrzSqCz?=
 =?us-ascii?Q?MrM25148//zZQuLmqFS2zF9OMysP8VPJpSlKL9aLUJGPGsnfz/nKzOJbOyG/?=
 =?us-ascii?Q?R6kVv8bDVcAdwLc/Lnu+8EttE144NnKWLUUCV7RvHk5AJAZ9ePeBGUMYJmTA?=
 =?us-ascii?Q?Aw8Bhj+hz1AuqA/Y+Lbf4AUXyxaQyA9iUM7EBbOfnBDp2cDXzxXBCVe8iSjP?=
 =?us-ascii?Q?1FBmYAJVSfXPLBQWEzXR8EbvtYBIk7h8ef+PNlnHjlJ8AjcfUb8ETz+mY3cr?=
 =?us-ascii?Q?iXL8tyXvKcaNvJd4tXTMdovW0OGKzlqzgIqCPPyAF74Ip+SxyYI6t5Il0DHf?=
 =?us-ascii?Q?Dz5JQk5OcDmNIRCb00vCEqth+PKPDDk8UQp+A0Q2/xVIPYcUrmp4wTICBpRN?=
 =?us-ascii?Q?xzRgPqPuG6meVZ58T5eqMZNHmnyp+ELJKaRsUEqzs4bM1M77YymT0M72HKAO?=
 =?us-ascii?Q?15KZnt7/G3KwpHAYbG/oruKBibzrvmLQr2J8tj1ILL70RZYYUr6ZPnfNW44T?=
 =?us-ascii?Q?6Zq00CCAvZng/tEqzkP8WIKCh0ONR11IvZeIB0d62sQ21XCd67Z2XqsH656j?=
 =?us-ascii?Q?YLzHlvhNXLL6ImNatEP5OZqBXvuz63qE6Mu6o6Gqi7cTe1FJ1nz1S0YLeXsm?=
 =?us-ascii?Q?S3umV4dW5vQC2OhC/rfp2xvY+DA1myCpZ/HEAUSjVQrnsdtdTkOa39d/dH2E?=
 =?us-ascii?Q?Hps39jZ96Wl8b1DVBW+pHy9LSoftwLb6i39ZRq1okvtPdYCLUfR7iHoYxbLO?=
 =?us-ascii?Q?qMOs75DvJIRb1Icf/HBB8uzDpTJqFbm4pogDsHzUOqbEr+gLFo1VjaL1jUON?=
 =?us-ascii?Q?M+eWPymThlwvUDMk0MT+wBnVbocwU2KHJeJIwIvFHrmZ06y5fpciq8ZtNNHl?=
 =?us-ascii?Q?OugjUMfO2y/mNXPM3+pqkLmEl2/pRxeU8DM3B6vTFg5HRYjw4eR7Yt7DUhVR?=
 =?us-ascii?Q?Ge50tbRhRflEoh9R5/mSV9r5PrRIMvseBMAHzDRG/rpwHze6bBrVjJxw9K7G?=
 =?us-ascii?Q?IPhjaESzOJLZ2qZz4hMI8ag+Pig0AdPwqJvTkVQ/vTJiIpT50hviQZ0GqP9N?=
 =?us-ascii?Q?scBtKO9jHWhBX7lJ7CcscHXuzYj5SnOSUoqY8DEG5l5pdRghUK/8aLoWwqhH?=
 =?us-ascii?Q?yFJJyQI2p3zp5k0pTaVQaX5uGPpVO4RhzsFrHJGGTKp3HNSRCty1FW51Z5v8?=
 =?us-ascii?Q?3AWL9lOjD38lfXW6PqkYwLg95CitpjTyZ7rsOsQcwA4fabOp1depqpbiMahP?=
 =?us-ascii?Q?dTREg/qm8X+OTqGHXtA/SPAzX3HfYZnBZer8V5UEqoX9rM8u7XKCBpO09B2P?=
 =?us-ascii?Q?jF3tY0PALXYN1hPXIOMQCl7Gl7ccgZXf+H1dmmLBhPZmJ9E02wYKvkbkvzAj?=
 =?us-ascii?Q?WGiv5YjKW7uCfv/HZ8ebGVwQNFYxMTO9efW1gjC3nq4NFmIWlBjHGlMZMxz7?=
 =?us-ascii?Q?rTknQ/mG46m8wVhNcBLAvIxZ3tPyuyC3/Cr27Zx9HMswmUR+ItTjJbUSIi56?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K4zTIdqELgezAlPNu2TDaX23x4LR+HLvZbjZrubCVmvqfjoOou8oWIY3raOXKdvKOuCoVhGO9iIZ5lHNFuxp+FK6u/3xZ9JWXvFHFXJCK/3ZxUTDpLKnIRmWaPPeRfACde+cG77g03sgh5r4Qh8loaiChmzhoA65kNvhDAS1ttZt3LO+FvwLj6c89IdLLEbVNhnQkdyeJkQRiaMDRcw+0vDMqIg+0VVmSYLTOWWsaNlvWtzvsZ/i+WZ+qj6OFFtNJU8+oSz6lxp9FYZ6Ppl6tXBkRmoQNOgmJQ4JKoJTsgRLW6XnnsauYmBsP0J1VSDE+Kp6U5jpWzkbgQfHoko1+TCkw9rmEivSE9CH1PUC+Nq2aFG0slyDz00vjkyBCzG1is/nS+/hzOxbjMKJbZaqRplvaxlLwPbxHybT5NqIOv11OGjwIzd4WnJV4z3qdNEqAWVnKcSIYLxGRvuXayXvCc/VrZQgazpGqCc/aVw8VOH/MElD9yerBVZr4cPZ0GtKH4yQnk7mtopLZ0mJNLdP/P3o+N15Slcip2xekthSEMhS9U7fAOTPMOXuXk5zRBfMnjoNsq+6mJ0Zx8/jHI/oPoNDinJWKbUArI5AZ3JXFK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae58ccca-34de-472f-ab20-08de1ad50828
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:20.1192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bKtzyZtGO0WL7dLWqFX41mjvIVh4tQF5Z6QAbRPGO1zxrfLqzf7nxC0Eo4gTpxw0KthzpPCy9bwYdzY+g8AXySc+BMPgxUri2Tu1sPN4YkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030113
X-Proofpoint-ORIG-GUID: fPeVpAZtYuW2SOzRmll5O3zK679bVVgq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMSBTYWx0ZWRfX0g31nEblHkLa
 1wkz33oWO3WDjQ2OyN9AyEakmmcEs/1UUYAXC0zJ1AFRhy3eLzvHoD3RM+IGd/IVet8GVU/i8Zw
 PrJP0gdP0veKq9H4ucBn8+DgbugHKnNr/qYPWRKzXmlWj3fQCwUm5U06Pz5CvRBCUJu2lT36iYs
 Ch6ry88lHDo0cl/Rsc1NciayAxTNafMnS9S+bVolqrbt52NOYqMOTEyIJvcrVNQV9gQ5njzvvYg
 Wx0Ynl745NoJFE3xDQbEiWHLsh+qodVH3bjGSm4fHVubpD6feIaMeR0GkNnkJf30gQu6lke0Zpv
 iN0PJOF39UdHwGkci71oLNSxI+wR5iIB4m0SlsZxE0clWtJ3nn/fJnpugtK5WFWhzQumsKOyhlp
 VogYakoQ7mrLDCNyIsSlcNZZj7OthgZ+3PvAskdbFLGbMNlhP1M=
X-Authority-Analysis: v=2.4 cv=Fbs6BZ+6 c=1 sm=1 tr=0 ts=6908a0d8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=RPBNNRGYkw5XAb79-8kA:9 cc=ntf awl=host:12124
X-Proofpoint-GUID: fPeVpAZtYuW2SOzRmll5O3zK679bVVgq

In cases where we can simply utilise the fact that leafent_from_pte()
treats present entries as if they were none entries and thus eliminate
spurious uses of is_swap_pte(), do so.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/internal.h   |  7 +++----
 mm/madvise.c    |  8 +++-----
 mm/swap_state.c | 12 ++++++------
 mm/swapfile.c   |  9 ++++-----
 4 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 9465129367a4..e450a34c37dd 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -15,7 +15,7 @@
 #include <linux/pagewalk.h>
 #include <linux/rmap.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/swap_cgroup.h>
 #include <linux/tracepoint-defs.h>
 
@@ -380,13 +380,12 @@ static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
 {
 	pte_t expected_pte = pte_next_swp_offset(pte);
 	const pte_t *end_ptep = start_ptep + max_nr;
-	swp_entry_t entry = pte_to_swp_entry(pte);
+	const leaf_entry_t entry = leafent_from_pte(pte);
 	pte_t *ptep = start_ptep + 1;
 	unsigned short cgroup_id;
 
 	VM_WARN_ON(max_nr < 1);
-	VM_WARN_ON(!is_swap_pte(pte));
-	VM_WARN_ON(non_swap_entry(entry));
+	VM_WARN_ON(!leafent_is_swap(entry));
 
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
diff --git a/mm/madvise.c b/mm/madvise.c
index 27e078098926..398721e9a1e5 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -195,7 +195,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 
 	for (addr = start; addr < end; addr += PAGE_SIZE) {
 		pte_t pte;
-		swp_entry_t entry;
+		leaf_entry_t entry;
 		struct folio *folio;
 
 		if (!ptep++) {
@@ -205,10 +205,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		}
 
 		pte = ptep_get(ptep);
-		if (!is_swap_pte(pte))
-			continue;
-		entry = pte_to_swp_entry(pte);
-		if (unlikely(non_swap_entry(entry)))
+		entry = leafent_from_pte(pte);
+		if (unlikely(!leafent_is_swap(entry)))
 			continue;
 
 		pte_unmap_unlock(ptep, ptl);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d20d238109f9..991256c6254e 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -12,7 +12,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/mempolicy.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/init.h>
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
@@ -732,7 +732,6 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 	pte_t *pte = NULL, pentry;
 	int win;
 	unsigned long start, end, addr;
-	swp_entry_t entry;
 	pgoff_t ilx;
 	bool page_allocated;
 
@@ -744,16 +743,17 @@ static struct folio *swap_vma_readahead(swp_entry_t targ_entry, gfp_t gfp_mask,
 
 	blk_start_plug(&plug);
 	for (addr = start; addr < end; ilx++, addr += PAGE_SIZE) {
+		leaf_entry_t entry;
+
 		if (!pte++) {
 			pte = pte_offset_map(vmf->pmd, addr);
 			if (!pte)
 				break;
 		}
 		pentry = ptep_get_lockless(pte);
-		if (!is_swap_pte(pentry))
-			continue;
-		entry = pte_to_swp_entry(pentry);
-		if (unlikely(non_swap_entry(entry)))
+		entry = leafent_from_pte(pentry);
+
+		if (!leafent_is_swap(entry))
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 543f303f101d..82a8b5d7e8d0 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -44,7 +44,7 @@
 #include <linux/plist.h>
 
 #include <asm/tlbflush.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/swap_cgroup.h>
 #include "swap_table.h"
 #include "internal.h"
@@ -2256,7 +2256,7 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		struct folio *folio;
 		unsigned long offset;
 		unsigned char swp_count;
-		swp_entry_t entry;
+		leaf_entry_t entry;
 		int ret;
 		pte_t ptent;
 
@@ -2267,11 +2267,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 
 		ptent = ptep_get_lockless(pte);
+		entry = leafent_from_pte(ptent);
 
-		if (!is_swap_pte(ptent))
+		if (!leafent_is_swap(entry))
 			continue;
-
-		entry = pte_to_swp_entry(ptent);
 		if (swp_type(entry) != type)
 			continue;
 
-- 
2.51.0


