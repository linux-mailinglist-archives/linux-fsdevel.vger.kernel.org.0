Return-Path: <linux-fsdevel+bounces-67545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F345AC430E4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EA2188C5FF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E94127991E;
	Sat,  8 Nov 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FRNp5ks7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eUUVSxCp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4437123F27B;
	Sat,  8 Nov 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621885; cv=fail; b=Y9coabP7bDaz1rLgMHKUE3mjTDTWuwY+gNv2iTcNXwFEWnI9u8p81tnCak5xPEI08i//rljGadactphpMfrn/gwkmblg5FuuvOyxzJmKEcIR9D5B0Imj+PIMK5qeNipDEdZ87OUIup2n8DOZU0nGeG6H1Cx1KqAEex9qdT0vw3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621885; c=relaxed/simple;
	bh=Tvs+4my9yc+vCQg1GhCyFmSQ7xuioNkL6B9uK3iRXfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e7vUJUJadra/Vv1hGUVSuLs2JXU1mkPtD0QcKSbsA7KI+lH8zswx0E6n7aicH7thxJRYG4XPJq3YBp7PDWJb7PfGrytiyH5FKB5RO2W1HNiOakVNsY4nmDZuu7BEp1yh+L4+JglZQR8nTC3cIkaqIzIgpAsmqeSis6R+D5XbVLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FRNp5ks7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eUUVSxCp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Fg8vu024800;
	Sat, 8 Nov 2025 17:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Eb9WAlRir1/Mp42rNrETH8HLWzdOqSGxrC9P0/htsIM=; b=
	FRNp5ks78TXI8UoAG98FDfRrk1vrfcEDZgMcl6iYuuGlG5Sg3p8rlS5QkwQPU4pM
	A3YUq/+J05Y7Im7vAi8hAE7AbOtjbz74L2gNcI4aFT0PXZClFP92jfyLZwo+O3aQ
	O6MRb90RIZQJ72o7L54iUtvaqJ6UHnkNV0glU3EKN7EMw+saWhjx1y+pIp9HAQjE
	SXsaBc+ZXpEsLBUeE89bRqYm35+Uh4BIJtN+VETxPt0q2sLvQgSOWmttGq0YjvYX
	AJ2p41NhAubID2GrRbSTkjY+WyFh+YqB6mPY2Wkm5GhP/TnOetyj2S1M50wB/Unp
	lhv7s2MRLns4RAveFN7K9w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9vs8gnmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8BijdJ007604;
	Sat, 8 Nov 2025 17:09:35 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011002.outbound.protection.outlook.com [52.101.52.2])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a9va76n3y-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kL3m40sP016YAC2xrFNaph1/Denk3mVyz9mDYvBuX4dZniu24+gaAGKrQJdFK1amdHvoBPccQOxsvIk+TNtVXfAtaAgHQMkVANwv3ZOHfQK2/TITaopVv3+Flr49Xxl2S12PoIsKZ1Uv/BcaaVxDyuyVmLdf2yTk+CpG+cyVkWCyDMGtBlR3eoeXEmfkixpkWszw44msG9GYk1asPc3QlTHz2DlY9rcAv1PAi5hlOH/yKPNi8qeyJyOJlgTprLq48MSWXNGyJLRyBh+9PNUxN3ODcu4iXNparc3n7pHmaudA0XACvNL5dzBaV6fPSfl9rQ+9b7/NGOYBMTFfXhUynQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eb9WAlRir1/Mp42rNrETH8HLWzdOqSGxrC9P0/htsIM=;
 b=ro5R0BHgNU/DaDimNBQpE/vdUeN2iVZxBEOcOwmXzitOpdh9AfwN8PC/KTsG1WIIUDwWKz3SH0cQUFdnPNGPOenRQXQnQVrdGG/lcjr6Gw2OS22cMLKQYeJtQMLayADhpeIQZsyIYU4p+OQNB2PCRwU53/IyPbs1MNM93es0Yx8Gxv9rY643aYn/nKqUaGcmOYmSYeWX2TXDbg4zjwCvA05jHyyhkIBOAsxLwrlHDJfFK5I4IHm9seXSoH2CgZjIGGGlU3I6Y5LPojZjFa9R0QtlaHkZfHeACH/z/s/Ty1sGiXnulya/zNMkp8YqaCkHpbeBj1RJ0T35ZLKv1IZ/Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eb9WAlRir1/Mp42rNrETH8HLWzdOqSGxrC9P0/htsIM=;
 b=eUUVSxCp5NnCYCTDuA668+L8O0snGPGxFNkw2VM3r/Y+uzRItK1caZxkTKVNQ/ruuquncurstWCozTtw7Y7WvBrSC6rtbI7Y+zu69lzIUNHpRmHmVU0oGJMRplY0x5tkF/rTeDO618/a36F0TbatDsiZjAVmgR2yvRNJ12K4MT4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:27 +0000
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
Subject: [PATCH v2 13/16] mm: remove non_swap_entry() and use softleaf helpers instead
Date: Sat,  8 Nov 2025 17:08:27 +0000
Message-ID: <82298e05b0c33bd95fd07b71845286d4df880a1f.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: c630c2aa-a906-4838-a4fa-08de1ee99298
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NWeIBDPaMG2FatJdvEyMjrZCbD2QCUgBZUbPz08LpucKeEqnZs9h10mpaaft?=
 =?us-ascii?Q?1+59gKd/Ea9Un/NobxMWgxxe5wjGyrXKWoPPChgo7AWcRPG6HUPosRE7wLan?=
 =?us-ascii?Q?k4FY7r9LEcGVayRnWDO+vt+UsDrypo4WFpQ6GilBGDhvXquNmgSL7nrnoEde?=
 =?us-ascii?Q?1oENaMvUMCGyIfMATtuz9BHZP+YrhcmGcfBH4oPZtVY7wsulf0xQ1YjNMnHV?=
 =?us-ascii?Q?Oy6/rgCUB9sl0fkVfmxH5WZH61VaJHW5odWMa+nDZiIr6RRVJvcD9tS/j9nx?=
 =?us-ascii?Q?0TxAsqI4/C6uAl5cPCxlje72cCKJn4D0dJhv0eK/74P9BDWiJsGwJIfhJbdj?=
 =?us-ascii?Q?s9gpeC0hanO9blLBe3YzoiMQ6oBpSIB2nQ9Nfwo9u8hE9hB1U9aG+WcmVUhX?=
 =?us-ascii?Q?lPFLFjb7avbON7KFR4RCZ1PI+sDC1Fgd5am2URhjtjFXxysnWHCzLwq+Szol?=
 =?us-ascii?Q?ycDMg6DndXxG9jceM9TkgWcrajNFqX9ErNPUQAxCmfmQceR8aOFVU0JZhup9?=
 =?us-ascii?Q?yB9sUDSXijwHkQQnWp/nzV/QSoSIjlzUYCcZSzgT2OFFltZV+AokHStvX5le?=
 =?us-ascii?Q?Gx5JKneIKJmFJUv044OU37K3LGLuHQA4/6YFpjxwMdQ/5tDeWb6AddPF0x7h?=
 =?us-ascii?Q?Myyff7GxLQydyrXzYGlfPlY9wM+NNnrS9hCxwo68zmtm7Cm4bWBEIcSLVn2v?=
 =?us-ascii?Q?bE7L+nSzaXmtcdfXNARk3MrXcu+Bu537ybikwGr0nIwsa9cbay9ypEd/SGUE?=
 =?us-ascii?Q?eEt1scRPRfPoSyWi1L2vIYiosPsBK//gh/tZElp4heHXdAZyCXCBX5tOKCRK?=
 =?us-ascii?Q?UVFNsPCkbaV9VvYnw6sPXgHYiPlOIiNS7nXhXjuOVQcfIV5LnvPU8icdSlad?=
 =?us-ascii?Q?Bvqb8UBFduH+yFkpe9ZPIQrUt/4d8pgN0DeOSiZHFv486SXoJLI794AUW9mO?=
 =?us-ascii?Q?L0aCkNoOVfdye4L/3KbdA8LtZzAYvEan6EBxgSmwPsOf2UIVPlNA6qClSMOH?=
 =?us-ascii?Q?OK/rJiadmdjcGgjrvyxpsRJ+whgVOGAfD6+QWbIdtvS3qk2CuWs4DW7yzS31?=
 =?us-ascii?Q?BmW7yoaNDryW6cPmcfcObAfGSJ+VGZ5KQ4Afbl+m2l3rOkiNaADPlf9//oI4?=
 =?us-ascii?Q?nGExWmsVi4vY04bjDhi6HeK3tQdyvXuUyfilmDYZnQ78cWb2uTxKPFe8O8ds?=
 =?us-ascii?Q?+loQPAV6H9rVVA51/g1yh/pJ7BUVjv/NT4+waRLHdjdwCQgKbEl2OBWj1n9E?=
 =?us-ascii?Q?nxFSGfrGbzem/YlMDkv83G17y6hYJDbTwPgs1tOynlV4eTgV/c7vwTRVXr8w?=
 =?us-ascii?Q?mkBpYtkBVi0E3DkC9Vrf13d27v3PQYrla2lGOIAcMomvgRt/iaLvGPfW03DG?=
 =?us-ascii?Q?Gknf1jQ6pPUArVl0PwjFyp+8DHfXnkqo+ieII+QP88IOpyHaTf6I48F5l2oX?=
 =?us-ascii?Q?pLB4DK/7smfCp6AixYMs+ipn6giCZKDg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?diWlbuHzpwb0FIpclMZUgyyO6hA55vdzBf13AJ/WtKTz0czgBcW/tV52/qIT?=
 =?us-ascii?Q?4D4VcrdOVRZzkDOkqErySvFbljtadBtugm80DriWBihU74IPeAVl26HkkdwC?=
 =?us-ascii?Q?fCb0QffeIcqmctQGfD5eJZ74abOpkKpKg6JPZmdtp7k5bqHK3P1GYDcVs5r4?=
 =?us-ascii?Q?vcTdjlbv+AXo9NAEb1c/63g/c5DdAez6immXbVlkE2QgMnhcb8WdFzs+n4qC?=
 =?us-ascii?Q?GD6sI/xFzJ6bqEAclIbsY6cybYgjsEBPc36MeoI4yBYSr9TqPW5fNfNjPVEo?=
 =?us-ascii?Q?1f8Q2EVsaUjPyNyPu0m0IRD9ar7mIQosbnOENBqavVKQCmvfTP7AF5ovc2yz?=
 =?us-ascii?Q?XMFmQ70CHZOi8olIH3pFz6nT+lYAXS3WxdQpEhG88tXn04FJDJh8/QxuCps4?=
 =?us-ascii?Q?DnJv+sbegs5IZzsRsm152bUoQFxnuT/TPT/+mcXbki5ymwcV1EY18JeoUnCb?=
 =?us-ascii?Q?crgRhVb1EHB0KVJuYmQ03XXnHJnjH0bzqgqD0UvS9tS/RocOPW+YFhVYlvSo?=
 =?us-ascii?Q?t4P3xV935SUa5qNRJm9xcHZeJzDpqQLPnLPxToStuF+N9eoVXex1CXy2369s?=
 =?us-ascii?Q?D3+janGhI6wqHKCT+WeS4XaaSmRY6c94eMhNqsaia5CKTTW2N9We6k/l6xi4?=
 =?us-ascii?Q?rPmYUcfw5i4ezhrW7p9lujezj4zfwWGgByb2gsoYpJOVrd75327zpxmat4jQ?=
 =?us-ascii?Q?sHWzLuc4T+g8uu+nMuayMupMJKVM6wHz4X2mQfpzrFt/+6BMW7kG/UNHeH2H?=
 =?us-ascii?Q?U+wMU4/ADnrio5VO70Vaap1pBzh90+28VmjV4VFr2Ll8mbsWlo6czC93RTwr?=
 =?us-ascii?Q?8NAtsYbag9oUfpauoO1CgLDs4d911dv+VBS+QMt7W9fw7uFeIhXuasCdXE2e?=
 =?us-ascii?Q?S5UmRJ6UwnllzlYNZveWQMdtJBS19prxgEZ29E8GyXMg7WNSBNWnYVbZw8R3?=
 =?us-ascii?Q?mQhTXXFpxQzgUxMqpbe0fUGwxb+aE6exbi6SY/RTug4lMt4lwomuVYG93O7t?=
 =?us-ascii?Q?XMpyqNs47ttRhV9/3QRrJz4TmXR0Bb57K6g2ACR+f3qPESLeiGQPDL9uPM49?=
 =?us-ascii?Q?30CJxPZSFrpz1aqijn82kwKo9GYJpv+b4dp6eBRMEhLlkeM79CJLh3U/Pjr7?=
 =?us-ascii?Q?DyVoSsb4duq+jIlj+x+BGTRn9R3sReN1nIkzt/UBzbLdWkTeF2iHkrA/rwVN?=
 =?us-ascii?Q?GqbgGCJtO//v19DHOxQ0ONZj/Jw9R/CMNhU2FN21OQ3flr/JGXkRIXp9tcUv?=
 =?us-ascii?Q?aMRi3GhXrWiDwqFl4A8ZfLQ1URHIGj9GI5IZIBOb2rjIKiVwf/EjjmIRHJsM?=
 =?us-ascii?Q?QI1x0dn36ZYgjENWesYMSHlcgOXCN9p1KwDCBbjSQc6eV59lmDgdzIVxzpMf?=
 =?us-ascii?Q?60IXQIo3YoROdfgiiFjoMYeSZtFZJx8GXxsf6Y3TNBA1QaoIxsa5zU+cBiTz?=
 =?us-ascii?Q?Sb9YZJ2c/UL/S549ApKJONHia7GO48l8zjElwJkaYrzgFGV45S2/NPcTnP1d?=
 =?us-ascii?Q?ScpFlVTAQ5iM2y+5ikkx3TDT0vgWo+i8dRiyAe69m26+mVsj/U6tAcXZqzXj?=
 =?us-ascii?Q?IdboZwIsgMR1QL50zkelyfkD0bP9incE42bmykexdZTB8/axfzHW7OpXNySn?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Sc/0ReeyNb6JA8j5lLr5CFZbAyMqFfuYb/9pddIneAOe610vlXh/ngGNaigv8lJYwUDExU+Wrja6fp6c+iTaes9mpipQQZw5HBHkVTNT3c/da6D0YTqP/UmX3c5ECCt33GjMyHIgmWLGNA/86w4HPeiInZLR+FpOydSTgLlVz2J+cF5fsj1VuIHt07pEsqEIqm2tNlOXVfzGvxcVT3WEQOOtiWzbhxl2RChYCEn35qrDFdkiCluDiCeafjCN7IjjUSj047e3W2WmiXBA30yuJV17KGFPuSJFvoAOVjSTLrOZf5azzDiz+Jr99yuAB2Qi7qlOYRCA6clQZd/XLECf/3CEx+OY95V99lSpOBu6zs9NelFvOiz5DealdZ+hrRXYtvFTAxbOUF51qMltQMgQ0hN92phtWwnWEhlv3e/lt7WOoG1F1WOU+QDefdtSE8r7L4sdUKCNVmTNquQaqPzB9jgM8be2hR8mq3W+3v8LVG9OLFxnNQmXjjYoL3TOhZMQEgDkgt8PySfAdsBhOF5ST/ADOnd+0ugC/ZrIi6XzHXRQVQw+Rqdu6rsKRnKXRdIizIHTCwb3TGlQhyQNKNJNbfoyHHpuuZcGuyHSzAKDsM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c630c2aa-a906-4838-a4fa-08de1ee99298
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:26.9605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N92FvLOmKRaO5Cg7Dpnb2CTan2CpG5yVLt3Idxg8lW9YRhlJt2tS/jgbVI8U655fSlQsdF+bgGblDcfc+skKm+76hfGuvbIx7DCgQPLM/XU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAxNiBTYWx0ZWRfX0S08px7rgSwc
 tqCoYrU5uKufWz5W3wIEFEstTUSq5YI/DlA+Hx6Pp0lfX+y1KcwBMnpdU++kWKiub5wdSVgFmbN
 sYKoTkM52/TEcuMDbG/dLF/d/LtWqUWCD6MnWprsJeaMucXKJpHSpk8HAXLdbLYiMZ4kkNjByo4
 7sB10EtPTGLF/K2W/QIgvDt4X0liegnZXnmCLjAhBkne59/FiydQ1Hr9xmvjyKQJN0HtHZ6I2al
 xm25bnViLE6e3OZEsY5hAl0BEiGC1k4xkchibtTgTjpUwgcDZYBIczJFmPboFj0XC+fAU4WHuLi
 G94koZL9e4S/yX7jr1F790KnxPF0z9cDvldYpjrlz13dOjxrTXEqT4x+GHjZvTV20l1KgFIxBLU
 jrZPCk2bKgArK70Z5HQ9kdh6shP4kg==
X-Proofpoint-ORIG-GUID: SRi1feQYmhEO6v4iVTzHlmJ56Npb_Iy8
X-Proofpoint-GUID: SRi1feQYmhEO6v4iVTzHlmJ56Npb_Iy8
X-Authority-Analysis: v=2.4 cv=eYgwvrEH c=1 sm=1 tr=0 ts=690f794f cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=jXjnEuVU91_iq225JjgA:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22

There is simply no need for the hugely confusing concept of 'non-swap' swap
entries now we have the concept of softleaf entries and relevant
softleaf_xxx() helpers.

Adjust all callers to use these instead and remove non_swap_entry()
altogether.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/gmap_helpers.c | 20 ++++++++++----------
 arch/s390/mm/pgtable.c      | 12 ++++++------
 fs/proc/task_mmu.c          | 12 ++++++------
 include/linux/swapops.h     |  5 -----
 mm/filemap.c                |  2 +-
 mm/hmm.c                    | 16 ++++++++--------
 mm/madvise.c                |  2 +-
 mm/memory.c                 | 36 ++++++++++++++++++------------------
 mm/mincore.c                |  2 +-
 mm/userfaultfd.c            | 24 ++++++++++++------------
 10 files changed, 63 insertions(+), 68 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index d4c3c36855e2..549f14ad08af 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -11,27 +11,27 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/swap.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/pagewalk.h>
 #include <linux/ksm.h>
 #include <asm/gmap_helpers.h>
 #include <asm/pgtable.h>
 
 /**
- * ptep_zap_swap_entry() - discard a swap entry.
+ * ptep_zap_softleaf_entry() - discard a software leaf entry.
  * @mm: the mm
- * @entry: the swap entry that needs to be zapped
+ * @entry: the software leaf entry that needs to be zapped
  *
- * Discards the given swap entry. If the swap entry was an actual swap
- * entry (and not a migration entry, for example), the actual swapped
+ * Discards the given software leaf entry. If the leaf entry was an actual
+ * swap entry (and not a migration entry, for example), the actual swapped
  * page is also discarded from swap.
  */
-static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
+static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (softleaf_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (is_migration_entry(entry))
-		dec_mm_counter(mm, mm_counter(pfn_swap_entry_folio(entry)));
+	else if (softleaf_is_migration(entry))
+		dec_mm_counter(mm, mm_counter(softleaf_to_folio(entry)));
 	free_swap_and_cache(entry);
 }
 
@@ -66,7 +66,7 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 		preempt_disable();
 		pgste = pgste_get_lock(ptep);
 
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(*ptep));
+		ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
 		pte_clear(mm, vmaddr, ptep);
 
 		pgste_set_unlock(ptep, pgste);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 0fde20bbc50b..d670bfb47d9b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -16,7 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/rcupdate.h>
 #include <linux/slab.h>
-#include <linux/swapops.h>
+#include <linux/leafops.h>
 #include <linux/sysctl.h>
 #include <linux/ksm.h>
 #include <linux/mman.h>
@@ -683,12 +683,12 @@ void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep)
 	pgste_set_unlock(ptep, pgste);
 }
 
-static void ptep_zap_swap_entry(struct mm_struct *mm, swp_entry_t entry)
+static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 {
-	if (!non_swap_entry(entry))
+	if (softleaf_is_swap(entry))
 		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (is_migration_entry(entry)) {
-		struct folio *folio = pfn_swap_entry_folio(entry);
+	else if (softleaf_is_migration(entry)) {
+		struct folio *folio = softleaf_to_folio(entry);
 
 		dec_mm_counter(mm, mm_counter(folio));
 	}
@@ -710,7 +710,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 	if (!reset && pte_swap(pte) &&
 	    ((pgstev & _PGSTE_GPS_USAGE_MASK) == _PGSTE_GPS_USAGE_UNUSED ||
 	     (pgstev & _PGSTE_GPS_ZERO))) {
-		ptep_zap_swap_entry(mm, pte_to_swp_entry(pte));
+		ptep_zap_softleaf_entry(mm, softleaf_from_pte(pte));
 		pte_clear(mm, addr, ptep);
 	}
 	if (reset)
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index d982fdfcf057..6cb9e1691e18 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1020,13 +1020,13 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 	} else if (pte_none(ptent)) {
 		smaps_pte_hole_lookup(addr, walk);
 	} else {
-		swp_entry_t swpent = pte_to_swp_entry(ptent);
+		const softleaf_t entry = softleaf_from_pte(ptent);
 
-		if (!non_swap_entry(swpent)) {
+		if (softleaf_is_swap(entry)) {
 			int mapcount;
 
 			mss->swap += PAGE_SIZE;
-			mapcount = swp_swapcount(swpent);
+			mapcount = swp_swapcount(entry);
 			if (mapcount >= 2) {
 				u64 pss_delta = (u64)PAGE_SIZE << PSS_SHIFT;
 
@@ -1035,10 +1035,10 @@ static void smaps_pte_entry(pte_t *pte, unsigned long addr,
 			} else {
 				mss->swap_pss += (u64)PAGE_SIZE << PSS_SHIFT;
 			}
-		} else if (is_pfn_swap_entry(swpent)) {
-			if (is_device_private_entry(swpent))
+		} else if (softleaf_has_pfn(entry)) {
+			if (softleaf_is_device_private(entry))
 				present = true;
-			page = pfn_swap_entry_to_page(swpent);
+			page = softleaf_to_page(entry);
 		}
 	}
 
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index 41cfc6d59054..c8e6f927da48 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -492,10 +492,5 @@ static inline pmd_t swp_entry_to_pmd(swp_entry_t entry)
 
 #endif  /* CONFIG_ARCH_ENABLE_THP_MIGRATION */
 
-static inline int non_swap_entry(swp_entry_t entry)
-{
-	return swp_type(entry) >= MAX_SWAPFILES;
-}
-
 #endif /* CONFIG_MMU */
 #endif /* _LINUX_SWAPOPS_H */
diff --git a/mm/filemap.c b/mm/filemap.c
index 950d93885e38..ab8ff5b2fc3b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4566,7 +4566,7 @@ static void filemap_cachestat(struct address_space *mapping,
 				swp_entry_t swp = radix_to_swp_entry(folio);
 
 				/* swapin error results in poisoned entry */
-				if (non_swap_entry(swp))
+				if (!softleaf_is_swap(swp))
 					goto resched;
 
 				/*
diff --git a/mm/hmm.c b/mm/hmm.c
index bc3fa699a4c6..d5c4e60fbfad 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -253,17 +253,17 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	}
 
 	if (!pte_present(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
+		const softleaf_t entry = softleaf_from_pte(pte);
 
 		/*
 		 * Don't fault in device private pages owned by the caller,
 		 * just report the PFN.
 		 */
-		if (is_device_private_entry(entry) &&
-		    page_pgmap(pfn_swap_entry_to_page(entry))->owner ==
+		if (softleaf_is_device_private(entry) &&
+		    page_pgmap(softleaf_to_page(entry))->owner ==
 		    range->dev_private_owner) {
 			cpu_flags = HMM_PFN_VALID;
-			if (is_writable_device_private_entry(entry))
+			if (softleaf_is_device_private_write(entry))
 				cpu_flags |= HMM_PFN_WRITE;
 			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
 			goto out;
@@ -274,16 +274,16 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		if (!required_fault)
 			goto out;
 
-		if (!non_swap_entry(entry))
+		if (softleaf_is_swap(entry))
 			goto fault;
 
-		if (is_device_private_entry(entry))
+		if (softleaf_is_device_private(entry))
 			goto fault;
 
-		if (is_device_exclusive_entry(entry))
+		if (softleaf_is_device_exclusive(entry))
 			goto fault;
 
-		if (is_migration_entry(entry)) {
+		if (softleaf_is_migration(entry)) {
 			pte_unmap(ptep);
 			hmm_vma_walk->last = addr;
 			migration_entry_wait(walk->mm, pmdp, addr);
diff --git a/mm/madvise.c b/mm/madvise.c
index ffae3b566dc1..234178685793 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -249,7 +249,7 @@ static void shmem_swapin_range(struct vm_area_struct *vma,
 			continue;
 		entry = radix_to_swp_entry(folio);
 		/* There might be swapin error entries in shmem mapping. */
-		if (non_swap_entry(entry))
+		if (!softleaf_is_swap(entry))
 			continue;
 
 		addr = vma->vm_start +
diff --git a/mm/memory.c b/mm/memory.c
index 087f31a291b4..ad336cbf1d88 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -932,7 +932,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	struct folio *folio;
 	struct page *page;
 
-	if (likely(!non_swap_entry(entry))) {
+	if (likely(softleaf_is_swap(entry))) {
 		if (swap_duplicate(entry) < 0)
 			return -EIO;
 
@@ -950,12 +950,12 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
 		rss[MM_SWAPENTS]++;
-	} else if (is_migration_entry(entry)) {
-		folio = pfn_swap_entry_folio(entry);
+	} else if (softleaf_is_migration(entry)) {
+		folio = softleaf_to_folio(entry);
 
 		rss[mm_counter(folio)]++;
 
-		if (!is_readable_migration_entry(entry) &&
+		if (!softleaf_is_migration_read(entry) &&
 				is_cow_mapping(vm_flags)) {
 			/*
 			 * COW mappings require pages in both parent and child
@@ -964,15 +964,15 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 			 */
 			entry = make_readable_migration_entry(
 							swp_offset(entry));
-			pte = swp_entry_to_pte(entry);
+			pte = softleaf_to_pte(entry);
 			if (pte_swp_soft_dirty(orig_pte))
 				pte = pte_swp_mksoft_dirty(pte);
 			if (pte_swp_uffd_wp(orig_pte))
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
-	} else if (is_device_private_entry(entry)) {
-		page = pfn_swap_entry_to_page(entry);
+	} else if (softleaf_is_device_private(entry)) {
+		page = softleaf_to_page(entry);
 		folio = page_folio(page);
 
 		/*
@@ -996,7 +996,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		 * when a device driver is involved (you cannot easily
 		 * save and restore device driver state).
 		 */
-		if (is_writable_device_private_entry(entry) &&
+		if (softleaf_is_device_private_write(entry) &&
 		    is_cow_mapping(vm_flags)) {
 			entry = make_readable_device_private_entry(
 							swp_offset(entry));
@@ -1005,7 +1005,7 @@ copy_nonpresent_pte(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 				pte = pte_swp_mkuffd_wp(pte);
 			set_pte_at(src_mm, addr, src_pte, pte);
 		}
-	} else if (is_device_exclusive_entry(entry)) {
+	} else if (softleaf_is_device_exclusive(entry)) {
 		/*
 		 * Make device exclusive entries present by restoring the
 		 * original entry then copying as for a present pte. Device
@@ -4635,7 +4635,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	rmap_t rmap_flags = RMAP_NONE;
 	bool need_clear_cache = false;
 	bool exclusive = false;
-	swp_entry_t entry;
+	softleaf_t entry;
 	pte_t pte;
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
@@ -4647,15 +4647,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	if (!pte_unmap_same(vmf))
 		goto out;
 
-	entry = pte_to_swp_entry(vmf->orig_pte);
-	if (unlikely(non_swap_entry(entry))) {
-		if (is_migration_entry(entry)) {
+	entry = softleaf_from_pte(vmf->orig_pte);
+	if (unlikely(!softleaf_is_swap(entry))) {
+		if (softleaf_is_migration(entry)) {
 			migration_entry_wait(vma->vm_mm, vmf->pmd,
 					     vmf->address);
-		} else if (is_device_exclusive_entry(entry)) {
-			vmf->page = pfn_swap_entry_to_page(entry);
+		} else if (softleaf_is_device_exclusive(entry)) {
+			vmf->page = softleaf_to_page(entry);
 			ret = remove_device_exclusive_entry(vmf);
-		} else if (is_device_private_entry(entry)) {
+		} else if (softleaf_is_device_private(entry)) {
 			if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
 				/*
 				 * migrate_to_ram is not yet ready to operate
@@ -4666,7 +4666,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 				goto out;
 			}
 
-			vmf->page = pfn_swap_entry_to_page(entry);
+			vmf->page = softleaf_to_page(entry);
 			vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd,
 					vmf->address, &vmf->ptl);
 			if (unlikely(!vmf->pte ||
@@ -4690,7 +4690,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 			} else {
 				pte_unmap_unlock(vmf->pte, vmf->ptl);
 			}
-		} else if (is_hwpoison_entry(entry)) {
+		} else if (softleaf_is_hwpoison(entry)) {
 			ret = VM_FAULT_HWPOISON;
 		} else if (softleaf_is_marker(entry)) {
 			ret = handle_pte_marker(vmf);
diff --git a/mm/mincore.c b/mm/mincore.c
index e77c5bc88fc7..e1d50f198c42 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -74,7 +74,7 @@ static unsigned char mincore_swap(swp_entry_t entry, bool shmem)
 	 * absent. Page table may contain migration or hwpoison
 	 * entries which are always uptodate.
 	 */
-	if (non_swap_entry(entry))
+	if (!softleaf_is_swap(entry))
 		return !shmem;
 
 	/*
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 055ec1050776..bd1f74a7a5ac 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1256,7 +1256,6 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 			    unsigned long dst_addr, unsigned long src_addr,
 			    unsigned long len, __u64 mode)
 {
-	swp_entry_t entry;
 	struct swap_info_struct *si = NULL;
 	pte_t orig_src_pte, orig_dst_pte;
 	pte_t src_folio_pte;
@@ -1430,19 +1429,20 @@ static long move_pages_ptes(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd
 					orig_dst_pte, orig_src_pte, dst_pmd,
 					dst_pmdval, dst_ptl, src_ptl, &src_folio,
 					len);
-	} else {
+	} else { /* !pte_present() */
 		struct folio *folio = NULL;
+		const softleaf_t entry = softleaf_from_pte(orig_src_pte);
 
-		entry = pte_to_swp_entry(orig_src_pte);
-		if (non_swap_entry(entry)) {
-			if (is_migration_entry(entry)) {
-				pte_unmap(src_pte);
-				pte_unmap(dst_pte);
-				src_pte = dst_pte = NULL;
-				migration_entry_wait(mm, src_pmd, src_addr);
-				ret = -EAGAIN;
-			} else
-				ret = -EFAULT;
+		if (softleaf_is_migration(entry)) {
+			pte_unmap(src_pte);
+			pte_unmap(dst_pte);
+			src_pte = dst_pte = NULL;
+			migration_entry_wait(mm, src_pmd, src_addr);
+
+			ret = -EAGAIN;
+			goto out;
+		} else if (!softleaf_is_swap(entry)) {
+			ret = -EFAULT;
 			goto out;
 		}
 
-- 
2.51.0


