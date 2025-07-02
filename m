Return-Path: <linux-fsdevel+bounces-53643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A377AF16D3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 15:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797A317BF90
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jul 2025 13:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8CD277007;
	Wed,  2 Jul 2025 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OGbs2tBj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YFatH2Sv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52AB276041;
	Wed,  2 Jul 2025 13:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751461453; cv=fail; b=Ry1iM8QzbG4cptkuiZuPn2rktbXZHgIOJMkx1WohfiqqplMIu+Pr14hskx0UpvfQBicRtISUoAsygkeZ4XDLbMDlhDcKTqhqRnrifO3yxzXLuhCYrMVGZcZcG5fa5ab4Zkf7r/QlkS7PAyv0FJXxlxl4jdRLAnaa3q0gTMluIe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751461453; c=relaxed/simple;
	bh=7Y9TZq7X31hH8RDHQ3QHYxCul4XhXS/KUYagOtzyooc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HYc1Kl51udaCKjP/qW8jcJ+WQPsfbP7mKnYzfvObBAcH7bQ3Vi+i9Iv6UAnO26PlZ26HuSfxBxQN8AVG/VF+YrPnlyrwEywd6ZT3dbaDU17u/lpyH5JT9yP/rp5hhvk0rWgi+6iw7ok98D+kp5NkIAaCP2KbJEwC1nckxBjMwQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OGbs2tBj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YFatH2Sv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562BjCna021598;
	Wed, 2 Jul 2025 13:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=993h0hL/+TEf0Ni0Uw
	rlXxYvP7OEv8YYiZQgPbCul9A=; b=OGbs2tBjWcv56in1XhCLvzY/B5A0292ciT
	MSDrrwUkxMXKy6HNf0m5J6GqqRRcwGeYiJ6O3mtLeSBKKPUbc20DsV6vgCAABCiG
	qNRQlwRk5eCMUkzStfboOK1vX1llX6dKqy0BAtBDqoESx/rgU2RyiMcqgXYD8UjW
	EqAYtxv9RDOFLE4ITcTVyUlpS5iAfoNSk0Rz7yeW3eTDJH61WdHVfQqgmktumuI1
	1ISVRct/ut07qnBGSNwM1PjpbK3FLatOSjmhtfzrZ/Ai97HVb2deGGXi6gBUrFBd
	RjWDlAK8CBXaTF+UsJmTW2Ux/xSGpdFEU2c3oJNQWMY17dqpWong==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7x5ay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:02:30 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 562CXDSI019582;
	Wed, 2 Jul 2025 13:02:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6uaxcj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Jul 2025 13:02:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgfr0meqpaVyND3d9AykYzBO6bU98v1HXVWe7WMOl6NUo6FxTcprytE0QW2eq3JGSPnscdm3YRS/gPPzo7Qe6aQPPy2jrX9sQh0eK8nFtBZBZteXoNkl2NbBRrpZTRgeTm2R620cBHGDqefmqJqo5q9YDK6dfcKTYL0Sra8VskazExBJZw/DdYRMOCaozYc8WHwJH1artLt8n721ONmmpr6f6XcO9pUwO9WQ9SBXMUO9PV7DRTGPelXJtI/DSXPHaxqoYnqdExag+SCq7tb2IcpM1pOceXPmDdv8661Gf93iKoX9Xivdv/YGQpzFqgGpdDIgegYwT8IrDdHyOKY1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=993h0hL/+TEf0Ni0UwrlXxYvP7OEv8YYiZQgPbCul9A=;
 b=NAJi8oBAFTNTnwHTNWBTjMIsyZfVeVQvo9IjGGJwzhAaEBhGIv5gnoNhNDpiEhvvor+i3qoGYDyN0FUtC7ncQoEpdaNGBrE8HAHrvuNzvtZbfB1tNDRLcTZjBVROosyPkMXyGCHr+3/a8JxygQzD3d8g+NKgGjoqTSf1rCkHjtB7XlFryFrjDv2RLAwU9AbMMTmdyzN7veNjuK0pmjkmPhWUSPrHGc4laGqFyDaFHgNPrZQdKLZneLeyenAxTEponHP1IuseZqULS83siIjkjgz7+/2kNnVXJci1MLQpX4kqwwgEul26rgJS5hiba/KX+a9RMPZL4f19S5DPiKYkHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=993h0hL/+TEf0Ni0UwrlXxYvP7OEv8YYiZQgPbCul9A=;
 b=YFatH2SvQKG8wHxDkgfEr5aBc0iiOpETuEAz/uhhNJfTMJNHZW7h+8+EENLSNeWfACQiMH4Yj+40PUs3ORR9VdejZ1Fm0TYEAKTjNU80xkOTz0r61rUS+M+Cav9HAqYl6PeHkoQ3lrsSq1toLNHpZ15Q5+LotLFFiBx5PJxoXn8=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8011.namprd10.prod.outlook.com (2603:10b6:408:28b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Wed, 2 Jul
 2025 13:02:22 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.8880.029; Wed, 2 Jul 2025
 13:02:22 +0000
Date: Wed, 2 Jul 2025 22:01:57 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
        Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
        Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
        Ying Huang <ying.huang@linux.alibaba.com>,
        Alistair Popple <apopple@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Brendan Jackman <jackmanb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH v1 20/29] mm: convert "movable" flag in page->mapping to
 a page flag
Message-ID: <aGUtxakO8p_94rTl@hyeyoo>
References: <20250630130011.330477-1-david@redhat.com>
 <20250630130011.330477-21-david@redhat.com>
 <aGUd34v-4S7eXojo@hyeyoo>
 <a533ae7e-f993-4673-bb00-ec9d10c11c83@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a533ae7e-f993-4673-bb00-ec9d10c11c83@redhat.com>
X-ClientProxiedBy: SEWP216CA0005.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::11) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 692405f6-f5e3-438b-a93a-08ddb968aec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JSMCP6tofT9igL2mUTOy4b1U3+w7AXsrvwC4rc3o/gbPc+6lieIBiQ5qXh4Q?=
 =?us-ascii?Q?pLTrFRNiIf0qoI54Zzr59RyHGk3LnsN3WpZSACyVPMoZGgepblBd6KqMlOvV?=
 =?us-ascii?Q?BzmhvDPQTI4fV5+cK/d/ejBjwh9cX/lVV2R7xm+72BDGIRYCjRIFsYcBxoK6?=
 =?us-ascii?Q?TwZLVrLKcHNpHxKcizwhEGc3qPzIKJ8s8EbbtvjRhk9tbvuZjJlolgGQRQ81?=
 =?us-ascii?Q?Vc08usC6Tj8jPcEQDQD91hLPcrTKCNX6Q6hnhdGJ8Y9o06DItlEC6e4ISvqy?=
 =?us-ascii?Q?JtThKMwB6VaZjig0ILR1cWUkKT7rmZv8+dTiPOuqALdrhWTUjwnVjNb7VIND?=
 =?us-ascii?Q?SbxELTxSf4zc7F3oAWoUH09YNY+OwqwWrdh3iN76/e22bo/pbsVmMGkfGQI5?=
 =?us-ascii?Q?VnyH8jHY54HgkqxN7tvZ5sK7pMTjZsRmjIZw1rigbh1iggLt+8KlqYAFSrfW?=
 =?us-ascii?Q?hDDbMwsPJ4OFMz7+yr2LBHKe0K4N+F3U24W99vMAb4A6LKsXeFirgzVt8MVi?=
 =?us-ascii?Q?w+KceWUzxc9N3y6s7nJj4Bt3qyDk/PAa58vE2rx7fbOvV8GSAEJUeIp9qxSV?=
 =?us-ascii?Q?/4DU/U2p4nkhIy57TLAGkC6Yk9qWqFosajyenAI1tNTgJM2h3RyBcRUBUWte?=
 =?us-ascii?Q?tGwgBS6UGJIqQQsz75EXMgVob5XcVyeV5YTNVavxMe5vzk5FmtQ5dBc51vSM?=
 =?us-ascii?Q?Kv+dtlvnXtXITzTMcdZybrVxUOlJPg7W6RU1zFsDzqQAFwrneS4WQfmoah/a?=
 =?us-ascii?Q?kWeQKtYnDVWJiorQGONPSBbkBoWFyyiZES0RM6PSrNgRRyFpy4/EzzV+9P9E?=
 =?us-ascii?Q?vI/8fD26sljw3mJthGbAm7+DRuxCmBiSO2EVbK23qYoYGBkVKI+9PHnqgk/I?=
 =?us-ascii?Q?J8o42ZvqwgesmviDUM0f9dg0isiuYUNuLYybHULBAKNz2/yxBbMwfqhhoah4?=
 =?us-ascii?Q?CRoEn4A8G0xKjb2gdNH/9L4ti7h1exbA6xXITV+CnR/IStNFUZT6xI9kCQkG?=
 =?us-ascii?Q?QywoztI2QeG+7nPggRBW6qIhw1giOOHf/IYGa2kDHYmPaY0pddLJuic/a5Z4?=
 =?us-ascii?Q?J/LjZtcnL3rkdRFQf07hiknP8Nfl2uBBmHhiA63lDxnKxoE646QJGQ3QA0P0?=
 =?us-ascii?Q?Bzl7JvtXpFoI9hdsaIhLUO3xwoQbVmOtqUcJYYRw39FIyVBBWDpSoy1SOd1f?=
 =?us-ascii?Q?EegbINs5sYD/EQFPAMNudeV7Sl8c0edlMAf8J5WpkaOGygmSH8rG4O1ux79g?=
 =?us-ascii?Q?UP5W56nj/jX8NoPArJj9VNjWhbuh26mU7RiXOFqK/Zc3e/yVt2/3OLgddUr5?=
 =?us-ascii?Q?sKX0GCeMtzsIVpESAKgXmuovobdZWisViVMxZ/YNQDPy8KmDvjpi9NJooBzE?=
 =?us-ascii?Q?yw7N/7tar4UxBKHgHRa6hQ+TqUsl8OvP+00U7m/Fndd4itQFFdrC+eTapOC6?=
 =?us-ascii?Q?EkB9jyhrlsY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8PXUuulKBykrLOMRx06+jyfk1xgStXbU5/4JiksDNULxKmWhAklQU3GYmTns?=
 =?us-ascii?Q?gE9rNlklxN2huO+2omH552n6ZED8ymgYgUvowyRNH042IjbXu2FkB6i/qpxk?=
 =?us-ascii?Q?TtG1ZWdkWLivHBN6dfXw77Mr5NSkvMtCFbZH3slNeKW94OyOJrKM6X9HPHwc?=
 =?us-ascii?Q?jba3/tbXdNZv2DDfjLwXN5L9gOqN8G0j/L/dBhty99c8aT/CJZtgAMsZMGjU?=
 =?us-ascii?Q?MSOgiTNSyGT3z5g78RI9vGSp1c0N2IMuBH+fnLUbYLbq7QyT0fg+9Pyaz4NN?=
 =?us-ascii?Q?+0zACsbBh3NjaN163B5C/nHd0Cc1DKEjwTld2Rq8eat3eHY+UeEGEzyeCPZf?=
 =?us-ascii?Q?Fs6Xnl2rFCmZZ68hcGTcmxU5iccCtsFar9fJ0+5o+tHZNIhe0GiiVEQaoaNq?=
 =?us-ascii?Q?V9G4UIB0MFe8/niClwfSJC1HlvYYdXjSjYqYSQCaPhbYgitOOPxHjYbHHXXW?=
 =?us-ascii?Q?NHEnkH7z17svw3dFB+r5Pub+RKLJ+X6CC8zzlOrzRbc6EVSn9Cll90haYGO6?=
 =?us-ascii?Q?PHpC6Eog+WDWAsRd2L/5Cb3FN/HEprGIdPmy5So48YhiuuPREu4x9Qc09a1W?=
 =?us-ascii?Q?jXUmskK5MXIRj36Yt3G0e8y/SUi6YVGRtqUtOqnbzC+1avRpw4eerk1c5s5s?=
 =?us-ascii?Q?nWdSkIAV/IoNwcInvHAOnRDg4H1j4mPa0bujwYGwGDQ/cEkX1UkDA96w0XlM?=
 =?us-ascii?Q?1FnjwSQzg0o83I96jZD5ScEtzbYY1+I6SEO94GcJEJbhOUyfA3ikjPOCPPbn?=
 =?us-ascii?Q?4MGUT4R/UZYHkLEkKeDA0/X3eHW0oh40x1NKIclLkEbPd4oDeBJe7WcDpCIT?=
 =?us-ascii?Q?lUz0ZJuZtHaeeuxJXzUSJDweiyELttBaqRpdY/DTmwszXAggpsxBF0wYU0qH?=
 =?us-ascii?Q?mdkMd4w8ozJcs2tJm4EfY3YeUTt1jlOQEpaV+WBb0Oa/fuyL5V8UU1PLZyF1?=
 =?us-ascii?Q?bxXlscJyZmC48dXhVfSAAM+tbGNITyvwg2vjw+QHj9GBsuJdKQwUyuBst8i5?=
 =?us-ascii?Q?Dg3+tEjqUvzbpFu+6fOORthYYA6EbaerBpbb1DFvNmWkkSLEayCaH+43ptLn?=
 =?us-ascii?Q?qIriVcZ7OucXhIKQikVzN4Ixx0QB+x6YAWKj8TBk0Je/GmtG2XjJVrPhmga3?=
 =?us-ascii?Q?pLwAKZD7az9IM34P7fdgCBJRbOx3Dc7S60Rz/7OQ67EYQas8q3TKa2A/0TOQ?=
 =?us-ascii?Q?fwugEuNbNkFjwelxVuH8xw+72rOvyjEcWFUYWuYvZ5RNIEDlKiRUccJ02WHg?=
 =?us-ascii?Q?01EuYiz1WNGk3CWd3sN+Z9OEpHKTpBDCVOy2rOgZXca0/jM/t7RVtCD9UdNf?=
 =?us-ascii?Q?RjdMkPo7uuPyIetHS/KLurJlmZi+JWaBZ80jv603URyUuYByYvbkwHKFCSDi?=
 =?us-ascii?Q?dYAWfl7RDfjBeCjn+eRdsHR0XSVoaFDRy6sg/K+wN+keLMxj8sxAqsHL7OjB?=
 =?us-ascii?Q?YK1UvrEYDH1hbekB90+chMnpd8ZfGd3sCuGoBuPOthgyfUGrQen7JEnTqA3w?=
 =?us-ascii?Q?HAM6l+TCN8B3/sOx9/fe3AF6vj2xA3CQzWGtD+7G7913Yfk8zd8A9P78NIuw?=
 =?us-ascii?Q?NLbFTgL0AKxx8pbpgKK3E4G7tuyCDBBjZDQaLP/T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cP8ZgGe9fBHta/3OkctESuqTWyWC3DdPs6zIqLJZKUGPqRo0aTX/2MHDzh9bS7kbTrtVVThGIuPFf60svJ63i7Z4V56Sc4xkm5BnaGzlNaoxtREWFT2eAqsZRTloGsWFaD1YkdDvb9yPikaeIzfANoMr17g87g5RMzm7b9Gwnvm+rXBROf6Cm72Yto9IMQUHS5XrWRAJF9RKNCOKx4OBrCT4CvIJQ4jVkaSs1TCioKfqDOUq9pJnuAxOEW3IxkUd0hZ8YqRX938ajPL6/tVMMmcrTn+jQpaa2BARmmiVEKZn/ZkBlWqU/qU+a6A+InAz0Qq7cHgDmWxwBEr5DQKfZx72dCeRNOYzgPnUt/WZtfKjifWkf5D8c4r/y9IYvBvfoVtXvHgrlaZP6CSW25jjxa7988NpuXg9Jzfg5q6QFQ8NR9jfl0486YflJl6I7pKulRoozKOnXP72khlp6F1ikevKHoMh0CY9TgJz7PbScPbRj4Gul6XMhdxxhLZZpT2/a3vrZC/aa7943tPM1AJY1xidK7JbDpqpxLvxSAnqXDA6AzaCCVogweZING3yC5tAmyUPZkwWlWarXksa19IEFzWJIurytNyn96GVzOROgVo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692405f6-f5e3-438b-a93a-08ddb968aec8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 13:02:21.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS00VbzK8Zegq1Vwj6o3equk331b8hQvnas6sKLwN0BL2iBSQTDWqo1ugOuToZwrkEK5hMKg5PY/SdTLCSR4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8011
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-02_01,2025-07-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507020105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAyMDEwNiBTYWx0ZWRfX45Cg+/JtLRjY I8TNDefEfDtLRodxYKNHPK7Wwe6T0MoBXChSe5G39wfXAzhsT0RH3Ft03ZTg4hf8XnGrlr0lmhH 0/sVMumD8q6nhMc01bsgcQ2OjdA82UxZY8oZG4Ystobj0cBQ//Tg1xUQVOOShX/XpYs527OdLNB
 tLhpws2yLgag+D/rybEqw3AsI4FBkmgppB5Nz7AaRLAhMRZ0K/NB+Hs/bSytPyD1G7lvBQXxadr jGdUvex1nPwU/CTV2LH3/oPGA6t462svni8Z8gkG0occKNhK9pb44PUS2adr/NPSTgT5aL4haw1 PTEuvmNjg948PfA4DhVTApfvhBnoOpyvIvj678eOJOAQCGZDp8Ze3e4X5TGgUyW34mkwJtv4O3f
 kkJdrGkyUhl+j5ELFk7cJ+FMvbVImMQkrhDF8zzPGnlSQ7oEX7O0wZIDDXJHPjLFSRnAnfvD
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68652de6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=Ikd4Dj_1AAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=m7dAX-iqkMTnI9mmn_UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QI4BwI0dI7Ql9IlzwEvMVN2sZpo12stN
X-Proofpoint-GUID: QI4BwI0dI7Ql9IlzwEvMVN2sZpo12stN

On Wed, Jul 02, 2025 at 02:01:33PM +0200, David Hildenbrand wrote:
> On 02.07.25 13:54, Harry Yoo wrote:
> > On Mon, Jun 30, 2025 at 03:00:01PM +0200, David Hildenbrand wrote:
> > > Instead, let's use a page flag. As the page flag can result in
> > > false-positives, glue it to the page types for which we
> > > support/implement movable_ops page migration.
> > > 
> > > The flag reused by PageMovableOps() might be sued by other pages, so
> > > warning in case it is set in page_has_movable_ops() might result in
> > > false-positive warnings.
> > > 
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: David Hildenbrand <david@redhat.com>
> > > ---
> > 
> > LGTM,
> > Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> > 
> > With a question: is there any reason to change the page flag
> > operations to use atomic bit ops?
> 
> As we have the page lock in there, it's complicated. I thought about this
> when writing that code, and was not able to convince myself that it is safe.
> 
> But that was when I was prototyping and reshuffling patches, and we would
> still have code that would clear the flag.
 
> Given that we only allow setting the flag, it might be okay to use the
> non-atomic variant as long as there can be nobody racing with us when
> modifying flags. Especially trying to lock the folio concurrently is the big
> problem.
>
> In isolate_movable_ops_page(), there is a comment about checking the flag
> before grabbing the page lock, so that should be handled.

Right.

> I'll have to check some other cases in balloon/zsmalloc code.

Okay, it's totally fine to go with atomic version and then
switching back to non atomic ops when we're sure it's safe.

-- 
Cheers,
Harry / Hyeonggon

