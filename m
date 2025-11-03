Return-Path: <linux-fsdevel+bounces-66771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E810C2BC64
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C851B4F49CF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C985F314A6E;
	Mon,  3 Nov 2025 12:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S0tHTa2p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DMn+Sr8M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB51B3148B8;
	Mon,  3 Nov 2025 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173317; cv=fail; b=ScrmJq/TiomeABmAQ2SnCkUnmLJypt8jZe8lQtntUhVMFYz+wEK0x7Yo5zQKmj4sm+mpoMSkPQa3AxdkAADZoibMHJ18vVSuQ1BC0IQyWxiRli7Qw6iaCeT8B7ItArH140zjpuLjP5x/5ZlsKKj+XufVmxmHJTSvs/pC0vbsziw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173317; c=relaxed/simple;
	bh=QBJKhRDFlr++Mm6mTlGCqUZyP/HJ1Ou8HEOsCdHgiRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfPT+JYXu8kU6U+Qu/kzCXeq298gCkp/18SmLSCBvVlgNUsT5Sa5fyw4Q0RvwcS/sLcBPYOZCsYM4ljFUqp5rOUNR5w2QxFVMI56x6J825gP4xCG/XJse5gboDHT5xjTRF2OmgJD9FDSwfNOxSrtgXYECMzgLu8JRX4lths7LT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S0tHTa2p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DMn+Sr8M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTpq4011573;
	Mon, 3 Nov 2025 12:33:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=V7Qyup/0b2hllUs/jtYn5BodrJWAtBT5wbbkGhOZbDc=; b=
	S0tHTa2p3Aw6EkakLFCLrcW96VyGWNlNwrp2X7Zv307EDR+0OV9LoPdCo67XsNPg
	FGmtPI5ZOaZHBwJn71ZIB3ze/BOkP3pB4t8k0xowe1SEM5Xpd/bz4JAvlPvR7vA+
	cM8wfrQAKEzx0NeJ9eiHN9bgjzJfGzG2tdg+S7Um7pBB6Zt4RGH3XLEFMYwyhdI7
	jlt0w4LxrdrX52YUUi02r9nNGG/wuy5uP10CzN/JKatkgPglw6031yLhewRORQUf
	OOwB3UBE1dPjWJvQIHJHt4BI+ofAimdypn8BkL06FJLX0KPKFzSsIFblJT22NPTo
	VpOio3fPTmMNQ6vpMHbcUQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vep009r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:33:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3Bx7kR021025;
	Mon, 3 Nov 2025 12:33:23 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58n83ev0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:33:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJ/mwvMYK48MQTmUDELJbek7dOIE/u+pDHb7ZcnUOqs90S+yuvznigQhKCDu8YrkiMZhAR+frk5nrXm9tdWZdNuSFZUe9PEHw1t/jr963Y9mpuDZnabGxH1d03pGywS3erg03ccx7BaxMPsVpwKC5QFhUCFMfj8SpnnIFRRZSXrLD8MJDyguE47o83qzoc3kOd49J8cHc3UYZXcTEu5DlhUP2PPglFoQGNErOa78C0bnQIFSjqQzdI/5y2JIFu4SF9M226GwniVna4HAdWReJNB89n3VF+nKxXifYUjNkWJiaOE9eruwz4bQteBiTOkCbLEfdJdLB8fhPKrOmBqfHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7Qyup/0b2hllUs/jtYn5BodrJWAtBT5wbbkGhOZbDc=;
 b=ZovJQkZCEQyc0W//ug0vu2SmzJZMm3epfLOs/VaaVVNpAKpQdA/hwpN7TmpT7mfs1HSukXbRQgWgdkWcdw6SusZkj6HTSMbY6+43svHi52Dh44et+zI+ibn+UTJ9qOTYxM/WoubFh0zth0JxMznGk9TrHFMsopT40SWDpl4lYhYrPFhZHaxOhCLN7NI1a1ibKbWDFppuATRGHKl5nntHKOCPJmxJg2x82tCY+nCWdNPE+WYB184C35F40pJ/m9f4hzFjd/ZskpN4JF6MxJajZeJoFWnhOLky/xE2Sdxlj8Dj+wIknI3AAk53BgT54mAgVItAMfSovBn2XAAIRXX4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7Qyup/0b2hllUs/jtYn5BodrJWAtBT5wbbkGhOZbDc=;
 b=DMn+Sr8MJJa2lAb18UraDh5rnyP+tEZ47dWCu9E7N6u1QRSndl7BPLEnqoOlBow/8E1nMuGvH7qrSXoKtKbpyvVMLxQdsVCjOXAzxWzP2xGSbcL9yI4ojmWHfylxdBbISLHch9J3o7jBZ/8WPWgjtdZqDZQ8VK55iw+kuFET3lY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:53 +0000
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
Subject: [PATCH 15/16] mm: eliminate further swapops predicates
Date: Mon,  3 Nov 2025 12:31:56 +0000
Message-ID: <4710023e2a19d01efb023fff3e074d015f0bde10.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f7229e-2f83-4090-f30d-08de1ad51bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2/DYhK30Nd9Qj+PV/ogFx7jRJxfxTnQK/qMJlSfIOFSX693ID5ePgBjcIuYI?=
 =?us-ascii?Q?njG9BCRuwK7wJm5rWxAYPPvdofR7E9gi8d28pmw+IpwwfsN5Fq2cuu2RqDTP?=
 =?us-ascii?Q?ZDF+ILygf4KrZVitTLgXrzBVfWTJqKTgcnLpwjAkbxgkkhpoCMy9QwAJ30W2?=
 =?us-ascii?Q?EeEqhatsX7DlQ5AK9RPzgryM8JLwIjIeY6gyzB13HaOEd05B0mb8wEIlOvCd?=
 =?us-ascii?Q?1x1d8s2S+0sPGKvRB6KfIcbkwKNj8UCRCP1/+2jXUHy5qy0r9jbOf5JkamhU?=
 =?us-ascii?Q?WKx06JncKrTYOa0XZq4r+sfexprCc9HW1HU5YV8Aoi3lxRV51NLDukT+rGUB?=
 =?us-ascii?Q?0lj2CCwOasJ0CyFysq6vjr8twCXi8tT85Ap+omEhtAb3s0+2BOs6aynp5/rq?=
 =?us-ascii?Q?n2y6sXOnA077FThJErbvKmCFLIzY65rUIQmrQBb/Om3ai31syajtGTbhUIBH?=
 =?us-ascii?Q?JaNcf3g2A+0t7v+6RYuSkMFM3Ljr1hEgS32TG0RsJqsVPuvjmpFCEvjlK4B0?=
 =?us-ascii?Q?FB+sH5Z/LAzQ9IkV+aoMu+iu1vmgvzlFfyBgMObwCgJ6JZnb3ZBoT9xD3vFy?=
 =?us-ascii?Q?HTNN3MlN6t2Pt2uyyx3p8K7s2ooqEgrsGhW3ZCwxyZUUNJ/b0W/QT3K2gtmV?=
 =?us-ascii?Q?yV/t4h1OWb6eToxif+lNVogD4/7lzbvjl6kxhWnJ0BEVoqRj0YUQ1mrnDFOc?=
 =?us-ascii?Q?4DJT9xPDRWRVR0t9Zv/aQD9n2ACv5SSZdCkI0TEyn4kiDCqiVwFe3kaxBHx/?=
 =?us-ascii?Q?e32ZiIzQHpSM2D0f9lYSEa0x0YNHjlH0aDV11JHHV8IdAqyVaedDv2xViVF7?=
 =?us-ascii?Q?ZUz3dFEW+ckjn70cRR93MaeADuPNo7c9fK3Kc0FKkomQxbuMklVnZgOD+D6l?=
 =?us-ascii?Q?z6dq9wT29fbO/hQNN6rGYx3NWejORqz8QtK46GHqzl0FEveRYuxQrOoC7ibv?=
 =?us-ascii?Q?Sz0wTh2781cJntx1IvL/s8RYxwTkgTxb5ini0ypm+OyEyHBSgHbfKVeJcMyr?=
 =?us-ascii?Q?rTIY9z+yiisPay2cf/+AS2Gl41GrlSoaRxLoHIjqetduiIZjNMrz6Cf/S8Q6?=
 =?us-ascii?Q?8+WuVLupYqHEUUGJ1f674jUlUb4HfMaeNVkcO4ZtDdUajNT4IeqzcipZtvdX?=
 =?us-ascii?Q?NvejU2oGoHNSJEuK8XCV/Y0PMTfi3s7H8iEgj9pfLmoaOCZkyU1pF8nUchtu?=
 =?us-ascii?Q?O/LtKDId8Ba669aWLcvsk5aw1xbUtA5aCKODD8xf1T44TriUV83S52D5LSPf?=
 =?us-ascii?Q?gZ5dl1zn9ShS8EeQ69y5TDPYubjvsz8Esw+j63eqr4jigPo8qGSksdYppcqe?=
 =?us-ascii?Q?VB4FlXScAc0CnBvvA8akrO7Lh6FmWXslHJNnbAMVI6bamTfm7r+wjDbGjpul?=
 =?us-ascii?Q?6bH9b5UT3LjlLbs7qbEzV7FsEYhedxg7wUKXCn9t1ZT/DovQNcKdLIZzG9qZ?=
 =?us-ascii?Q?0CEFtCKElHx7AojlOU4ZRGda20ZL7xbf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wbNSght04S4cEZJe/aAX4J9Qe3ezwh1Pm4hXIq2RDz84JNsjkhqogWbc9NRM?=
 =?us-ascii?Q?qVROjnY0Tg5LbpMxIRdaxVd/lqviGxnAcVoDTB8oeGmttcumdOPy8ghhSqum?=
 =?us-ascii?Q?FnbgC8twlvSQ8o8uHHvbQCEM+nRoQf56KEhA1JbXbbYzUHGXM917/vqDgZm2?=
 =?us-ascii?Q?gh1+hp28lpezIEQueKFKlmw/450WIrdsYHlmQHt/jpI/rvlZvfsVA2P8IptD?=
 =?us-ascii?Q?ZUf83//RdrFoVHxgXSGBDNbhndPmNhmrWJml1ZevzZonKHM/+zbdQlp8+afT?=
 =?us-ascii?Q?n7OcX4sF6FfVF5VZEkjrEsHgwqSw8TupYWtx57UT2aIZfeaOwhMkP4pUHGxB?=
 =?us-ascii?Q?BQWZCMXJmIsQd5luiCM6oslSRnfdqsQ26llusfnwXPEcekCbuPKq2NLmoAfE?=
 =?us-ascii?Q?oN0B6TTc7kzfrOfJb5hjpm2AYNEaI2pAXlI85+uwyvWVXKXoeqv08CBfa8Bh?=
 =?us-ascii?Q?VttwbgTkEApaNvr56VRyXGIs+4lopP+NcgVHwD8Ky6EHcnabMgai8yOa0wgP?=
 =?us-ascii?Q?RLKBc1sp+8JWZuDqTXatYxAKKITuq92MuogfLJIn8GeAlGZxzLoRhSeGjnSR?=
 =?us-ascii?Q?pkAZLl2iRzzrKeIfHcvE+J2f5sQDbnvxR1gEx1E6K6sAFqVLeCqebGoWGWYa?=
 =?us-ascii?Q?JmgrecJe6m7JMsqkVWPFyw15s0hS7mXkFmMpxOmdkd7SgHcPuUcIP0jIgKDf?=
 =?us-ascii?Q?NVkA1R8uEcebX8/FTTsQ23qczR7P7TDXriCZmzS+8Mtd0WBPnYYt517DFIIs?=
 =?us-ascii?Q?4shKi3fit5P4gRzXWfCxPG+l50pH4//jSONXrJF8B8Um2TRP0vcoaN7QBc4A?=
 =?us-ascii?Q?hoPpzeqeHaRHBEw0yaozuqwsbWUc5qD0kncI/h9TeCCGT5A7PW8eeFbvLXXQ?=
 =?us-ascii?Q?ouS0y0LG6fkM2KSUvM3b3eKxBzcnk3+1xCWS8mVNdh9Zp4LkQ7stJ0tnOiew?=
 =?us-ascii?Q?sITIaCrsHqclpBY+67zcBOffOjkc2ChkxPFsbLJ2aYfvWlpHq0fP0nGO4OgT?=
 =?us-ascii?Q?63AaTNB1gdAF0BX8NfPTw81BkOmNmEAnLwBe4PNs6L5kMTOe+Xwuc5iCPuhR?=
 =?us-ascii?Q?GGm89sSNDMgHf1Hvimdkl94qRBkJYWnJpLdLAtNEHwVLbr+qPLlNxDpQ5Y4p?=
 =?us-ascii?Q?dy3KW1DOto0VjOKOJ3IEnn7mSrmNltT+ukOhofwDkwh3R2L1A/CLspOoIZMt?=
 =?us-ascii?Q?db5Cu47MnPMDBkF6tAU+NLjbi8F2AXzmeV4QngcgY588bwOcH1hqi+5tD8fq?=
 =?us-ascii?Q?uflc0czYuco1irwBhnPFyxMyLGT1Gsk1TT1rkDdFe6i/4mUwifLEieiQKlmo?=
 =?us-ascii?Q?2awRRx8P8WzpPv2rWZQ8QCHvdHKmVgzDbuuCds6tAVe1k9h4CUROz0e8RHEt?=
 =?us-ascii?Q?aIM7ZIOT0hKRrF87P8wcFrJH5GKjPtuOlYhu9Lf/gFkGYV9ZgdvVhenF2ywJ?=
 =?us-ascii?Q?mktfRLpMkhE2VYdFctjVQ1ApzkbpiIUU2ZJPOPQWcJC+Bj7XztCTtmEqmGQ5?=
 =?us-ascii?Q?5rpA0T7WH1WhUnXaFQkP0DUONmPOAOc+NXNaGFo1xJaw+gAZ+8u54RjX4WQV?=
 =?us-ascii?Q?yoedROB5RsN5X0s91l4tJe1tGnIRIIMAWhzTwwlPDJtKl3llEeQhhXf952k2?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0NUKFnmTGyrjsZxUz+eTi58Osc+aik08mkVs9SihQNUQZ2xWotd4C7HGMKhJUDU3VMJc5JRiL6kgnstotv1cuy/EOF/7/pE1XQFM0anG1k8B7bABt39h+RnOaGv73U+my0KcwvEXVS8pxHwfaGSWjqMLufNi/JnNTzwRlqCSKW3cZz2s0gfr1GGCs7usQy2YgTw2LS/GsiY+13QQOaHk5Z/NxDvRivfx3G4gdEqvel/JLGMzYLN4O5dpCD0uhpg6lVMzGV8HOJoTtipT+OoN+OXvv8EQ5F5QMOAaDIOlHMNocHhckRqzLeAUm8JXAItAw5N1aERHOWcWe5gi2Lmq2Wk2ZppGi8SDfIoYrFiae2yZ6eZp3KIJIHnV0kFMvoX287sOlbNmKvoNWMG4+WhqPmBpSbb61kcy2lQvE+AIm5e8oVKwlEpywf2sj4NJvdb3DHVXMzawcjQhT3iKIB6K8oIaoerYe2rwkPWIMNemADVUOibj9e1M/vFnM3Fajxd3EkIAkstRmjwp9IiIgysrs4Ed4tcUn//hdqVl0UoK4bWerxj0kf62q38/WYQefegRmKVebRUvgU/VzeGYiqn355xRKrC2nk753+AkxT3MBho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f7229e-2f83-4090-f30d-08de1ad51bcf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:53.1867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwdE4o6ay+zQk/UO8VOR+Wv5WHd3XZANLMslKQ7CQttkPZ8PEcizIkq9H95hkHB2Nyni1+ahTJMm+CvZ6UNiMwpXyTRyb+r7fMiXqd9qdV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030114
X-Proofpoint-GUID: YxRiJ2glE3Gu_YqWiiyBz9mmLyRvVJum
X-Proofpoint-ORIG-GUID: YxRiJ2glE3Gu_YqWiiyBz9mmLyRvVJum
X-Authority-Analysis: v=2.4 cv=B9m0EetM c=1 sm=1 tr=0 ts=6908a113 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=12TsxHtCQ5kFwp23Kd0A:9 a=UhEZJTgQB8St2RibIkdl:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfX2laHw6luLnUV
 V43ukoDlFc8d8mFUplHU8cCZ4gyNvGq3ks7IB4wEJu7PtNuibn8akwRQqVsjN8qQ6H9bKpmzRe+
 /TMs6XuTIyq/x+3WtT3TrcCTvf0mqoHzerwVn3yJnFN6EbJJPmucf/MXMXOHl6N+K2Pxn8NID9/
 FuZx2exdqu2r/ASLe9QZRetdsfQYsNccyDoatkGddxV+MO8udpJfyr+WLMhgXfzjnfx0iEljmx5
 eGKCbpUk5qHGgsmfYA2yX0rVzmbdeXgNxeI4PyMxs8wFA34EwIlyUCtChQiPYdEbZJTD7le1eMK
 DHTvQ2YIDH5j/53QCpD6HBfWGdnIGAR2/vwfy0owJoEE6BnIra+uJPILlqoOszkLnESXfxJr1Cp
 /VftoF3j9Be190JIJJbfanAFJGEOdg==

Having converted so much of the code base to leaf entries, we can mop up
some remaining cases.

We replace is_pfn_swap_entry(), pfn_swap_entry_to_page(),
is_writable_device_private_entry(), is_device_exclusive_entry(),
is_migration_entry(), is_writable_migration_entry(),
is_readable_migration_entry(), swp_offset_pfn() and pfn_swap_entry_folio()
with leafent equivalents.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/task_mmu.c      |  14 ++---
 include/linux/leafops.h |  25 +++++++--
 include/linux/swapops.h | 121 +---------------------------------------
 mm/debug_vm_pgtable.c   |  20 +++----
 mm/hmm.c                |   2 +-
 mm/hugetlb.c            |   2 +-
 mm/ksm.c                |   6 +-
 mm/memory-failure.c     |   6 +-
 mm/memory.c             |   3 +-
 mm/mempolicy.c          |   4 +-
 mm/migrate.c            |   6 +-
 mm/migrate_device.c     |  10 ++--
 mm/mprotect.c           |   8 +--
 mm/page_vma_mapped.c    |   8 +--
 mm/pagewalk.c           |   7 +--
 mm/rmap.c               |   9 ++-
 16 files changed, 75 insertions(+), 176 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 82532c069039..8a9894aefbca 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1940,13 +1940,13 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 		if (pte_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
 	} else {
-		swp_entry_t entry;
+		leaf_entry_t entry;
 
 		if (pte_swp_soft_dirty(pte))
 			flags |= PM_SOFT_DIRTY;
 		if (pte_swp_uffd_wp(pte))
 			flags |= PM_UFFD_WP;
-		entry = pte_to_swp_entry(pte);
+		entry = leafent_from_pte(pte);
 		if (pm->show_pfn) {
 			pgoff_t offset;
 
@@ -1954,16 +1954,16 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			 * For PFN swap offsets, keeping the offset field
 			 * to be PFN only to be compatible with old smaps.
 			 */
-			if (is_pfn_swap_entry(entry))
-				offset = swp_offset_pfn(entry);
+			if (leafent_has_pfn(entry))
+				offset = leafent_to_pfn(entry);
 			else
 				offset = swp_offset(entry);
 			frame = swp_type(entry) |
 			    (offset << MAX_SWAPFILES_SHIFT);
 		}
 		flags |= PM_SWAP;
-		if (is_pfn_swap_entry(entry))
-			page = pfn_swap_entry_to_page(entry);
+		if (leafent_has_pfn(entry))
+			page = leafent_to_page(entry);
 		if (leafent_is_uffd_wp_marker(entry))
 			flags |= PM_UFFD_WP;
 		if (leafent_is_guard_marker(entry))
@@ -2032,7 +2032,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		if (pmd_swp_uffd_wp(pmd))
 			flags |= PM_UFFD_WP;
 		VM_WARN_ON_ONCE(!pmd_is_migration_entry(pmd));
-		page = pfn_swap_entry_to_page(entry);
+		page = leafent_to_page(entry);
 	}
 
 	if (page) {
diff --git a/include/linux/leafops.h b/include/linux/leafops.h
index 2d3bc4c866bd..b74d406ba648 100644
--- a/include/linux/leafops.h
+++ b/include/linux/leafops.h
@@ -357,7 +357,7 @@ static inline unsigned long leafent_to_pfn(leaf_entry_t entry)
 	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
 
 	/* Temporary until swp_entry_t eliminated. */
-	return swp_offset_pfn(entry);
+	return swp_offset(entry) & SWP_PFN_MASK;
 }
 
 /**
@@ -368,10 +368,16 @@ static inline unsigned long leafent_to_pfn(leaf_entry_t entry)
  */
 static inline struct page *leafent_to_page(leaf_entry_t entry)
 {
+	struct page *page = pfn_to_page(leafent_to_pfn(entry));
+
 	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding page is locked
+	 */
+	VM_WARN_ON_ONCE(leafent_is_migration(entry) && !PageLocked(page));
 
-	/* Temporary until swp_entry_t eliminated. */
-	return pfn_swap_entry_to_page(entry);
+	return page;
 }
 
 /**
@@ -383,10 +389,17 @@ static inline struct page *leafent_to_page(leaf_entry_t entry)
  */
 static inline struct folio *leafent_to_folio(leaf_entry_t entry)
 {
-	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
+	struct folio *folio = pfn_folio(leafent_to_pfn(entry));
 
-	/* Temporary until swp_entry_t eliminated. */
-	return pfn_swap_entry_folio(entry);
+	VM_WARN_ON_ONCE(!leafent_has_pfn(entry));
+	/*
+	 * Any use of migration entries may only occur while the
+	 * corresponding folio is locked.
+	 */
+	VM_WARN_ON_ONCE(leafent_is_migration(entry) &&
+			!folio_test_locked(folio));
+
+	return folio;
 }
 
 /**
diff --git a/include/linux/swapops.h b/include/linux/swapops.h
index c8e6f927da48..3d02b288c15e 100644
--- a/include/linux/swapops.h
+++ b/include/linux/swapops.h
@@ -28,7 +28,7 @@
 #define SWP_OFFSET_MASK	((1UL << SWP_TYPE_SHIFT) - 1)
 
 /*
- * Definitions only for PFN swap entries (see is_pfn_swap_entry()).  To
+ * Definitions only for PFN swap entries (see leafeant_has_pfn()).  To
  * store PFN, we only need SWP_PFN_BITS bits.  Each of the pfn swap entries
  * can use the extra bits to store other information besides PFN.
  */
@@ -66,8 +66,6 @@
 #define SWP_MIG_YOUNG			BIT(SWP_MIG_YOUNG_BIT)
 #define SWP_MIG_DIRTY			BIT(SWP_MIG_DIRTY_BIT)
 
-static inline bool is_pfn_swap_entry(swp_entry_t entry);
-
 /* Clear all flags but only keep swp_entry_t related information */
 static inline pte_t pte_swp_clear_flags(pte_t pte)
 {
@@ -109,17 +107,6 @@ static inline pgoff_t swp_offset(swp_entry_t entry)
 	return entry.val & SWP_OFFSET_MASK;
 }
 
-/*
- * This should only be called upon a pfn swap entry to get the PFN stored
- * in the swap entry.  Please refers to is_pfn_swap_entry() for definition
- * of pfn swap entry.
- */
-static inline unsigned long swp_offset_pfn(swp_entry_t entry)
-{
-	VM_BUG_ON(!is_pfn_swap_entry(entry));
-	return swp_offset(entry) & SWP_PFN_MASK;
-}
-
 /*
  * Convert the arch-dependent pte representation of a swp_entry_t into an
  * arch-independent swp_entry_t.
@@ -169,27 +156,11 @@ static inline swp_entry_t make_writable_device_private_entry(pgoff_t offset)
 	return swp_entry(SWP_DEVICE_WRITE, offset);
 }
 
-static inline bool is_device_private_entry(swp_entry_t entry)
-{
-	int type = swp_type(entry);
-	return type == SWP_DEVICE_READ || type == SWP_DEVICE_WRITE;
-}
-
-static inline bool is_writable_device_private_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_DEVICE_WRITE);
-}
-
 static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(SWP_DEVICE_EXCLUSIVE, offset);
 }
 
-static inline bool is_device_exclusive_entry(swp_entry_t entry)
-{
-	return swp_type(entry) == SWP_DEVICE_EXCLUSIVE;
-}
-
 #else /* CONFIG_DEVICE_PRIVATE */
 static inline swp_entry_t make_readable_device_private_entry(pgoff_t offset)
 {
@@ -201,50 +172,14 @@ static inline swp_entry_t make_writable_device_private_entry(pgoff_t offset)
 	return swp_entry(0, 0);
 }
 
-static inline bool is_device_private_entry(swp_entry_t entry)
-{
-	return false;
-}
-
-static inline bool is_writable_device_private_entry(swp_entry_t entry)
-{
-	return false;
-}
-
 static inline swp_entry_t make_device_exclusive_entry(pgoff_t offset)
 {
 	return swp_entry(0, 0);
 }
 
-static inline bool is_device_exclusive_entry(swp_entry_t entry)
-{
-	return false;
-}
-
 #endif /* CONFIG_DEVICE_PRIVATE */
 
 #ifdef CONFIG_MIGRATION
-static inline int is_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ ||
-			swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE ||
-			swp_type(entry) == SWP_MIGRATION_WRITE);
-}
-
-static inline int is_writable_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_WRITE);
-}
-
-static inline int is_readable_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ);
-}
-
-static inline int is_readable_exclusive_migration_entry(swp_entry_t entry)
-{
-	return unlikely(swp_type(entry) == SWP_MIGRATION_READ_EXCLUSIVE);
-}
 
 static inline swp_entry_t make_readable_migration_entry(pgoff_t offset)
 {
@@ -310,23 +245,10 @@ static inline swp_entry_t make_writable_migration_entry(pgoff_t offset)
 	return swp_entry(0, 0);
 }
 
-static inline int is_migration_entry(swp_entry_t swp)
-{
-	return 0;
-}
-
 static inline void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 					unsigned long address) { }
 static inline void migration_entry_wait_huge(struct vm_area_struct *vma,
 					     unsigned long addr, pte_t *pte) { }
-static inline int is_writable_migration_entry(swp_entry_t entry)
-{
-	return 0;
-}
-static inline int is_readable_migration_entry(swp_entry_t entry)
-{
-	return 0;
-}
 
 static inline swp_entry_t make_migration_entry_young(swp_entry_t entry)
 {
@@ -410,47 +332,6 @@ static inline swp_entry_t make_guard_swp_entry(void)
 	return make_pte_marker_entry(PTE_MARKER_GUARD);
 }
 
-static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
-{
-	struct page *p = pfn_to_page(swp_offset_pfn(entry));
-
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding page is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !PageLocked(p));
-
-	return p;
-}
-
-static inline struct folio *pfn_swap_entry_folio(swp_entry_t entry)
-{
-	struct folio *folio = pfn_folio(swp_offset_pfn(entry));
-
-	/*
-	 * Any use of migration entries may only occur while the
-	 * corresponding folio is locked
-	 */
-	BUG_ON(is_migration_entry(entry) && !folio_test_locked(folio));
-
-	return folio;
-}
-
-/*
- * A pfn swap entry is a special type of swap entry that always has a pfn stored
- * in the swap offset. They can either be used to represent unaddressable device
- * memory, to restrict access to a page undergoing migration or to represent a
- * pfn which has been hwpoisoned and unmapped.
- */
-static inline bool is_pfn_swap_entry(swp_entry_t entry)
-{
-	/* Make sure the swp offset can always store the needed fields */
-	BUILD_BUG_ON(SWP_TYPE_SHIFT < SWP_PFN_BITS);
-
-	return is_migration_entry(entry) || is_device_private_entry(entry) ||
-	       is_device_exclusive_entry(entry) || is_hwpoison_entry(entry);
-}
-
 struct page_vma_mapped_walk;
 
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 8f247fcf1865..181fa2b25625 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -844,7 +844,7 @@ static void __init pmd_leafent_tests(struct pgtable_debug_args *args) { }
 static void __init swap_migration_tests(struct pgtable_debug_args *args)
 {
 	struct page *page;
-	swp_entry_t swp;
+	leaf_entry_t entry;
 
 	if (!IS_ENABLED(CONFIG_MIGRATION))
 		return;
@@ -867,17 +867,17 @@ static void __init swap_migration_tests(struct pgtable_debug_args *args)
 	 * be locked, otherwise it stumbles upon a BUG_ON().
 	 */
 	__SetPageLocked(page);
-	swp = make_writable_migration_entry(page_to_pfn(page));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(!is_writable_migration_entry(swp));
+	entry = make_writable_migration_entry(page_to_pfn(page));
+	WARN_ON(!leafent_is_migration(entry));
+	WARN_ON(!leafent_is_migration_write(entry));
 
-	swp = make_readable_migration_entry(swp_offset(swp));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(is_writable_migration_entry(swp));
+	entry = make_readable_migration_entry(swp_offset(entry));
+	WARN_ON(!leafent_is_migration(entry));
+	WARN_ON(leafent_is_migration_write(entry));
 
-	swp = make_readable_migration_entry(page_to_pfn(page));
-	WARN_ON(!is_migration_entry(swp));
-	WARN_ON(is_writable_migration_entry(swp));
+	entry = make_readable_migration_entry(page_to_pfn(page));
+	WARN_ON(!leafent_is_migration(entry));
+	WARN_ON(leafent_is_migration_write(entry));
 	__ClearPageLocked(page);
 }
 
diff --git a/mm/hmm.c b/mm/hmm.c
index 831ef855a55a..618503c8fd1c 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -265,7 +265,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			cpu_flags = HMM_PFN_VALID;
 			if (leafent_is_device_private_write(entry))
 				cpu_flags |= HMM_PFN_WRITE;
-			new_pfn_flags = swp_offset_pfn(entry) | cpu_flags;
+			new_pfn_flags = leafent_to_pfn(entry) | cpu_flags;
 			goto out;
 		}
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 6c483ecd496f..acb0c38c99a8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5640,7 +5640,7 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
 		} else if (unlikely(leafent_is_migration(leafent))) {
 			bool uffd_wp = pte_swp_uffd_wp(entry);
 
-			if (!is_readable_migration_entry(leafent) && cow) {
+			if (!leafent_is_migration_read(leafent) && cow) {
 				/*
 				 * COW mappings require pages in both
 				 * parent and child to be set to read.
diff --git a/mm/ksm.c b/mm/ksm.c
index 7cd19a6ce45f..f9dbe93fcffc 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -637,14 +637,14 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long en
 		if (pte_present(pte)) {
 			folio = vm_normal_folio(walk->vma, addr, pte);
 		} else if (!pte_none(pte)) {
-			swp_entry_t entry = pte_to_swp_entry(pte);
+			const leaf_entry_t entry = leafent_from_pte(pte);
 
 			/*
 			 * As KSM pages remain KSM pages until freed, no need to wait
 			 * here for migration to end.
 			 */
-			if (is_migration_entry(entry))
-				folio = pfn_swap_entry_folio(entry);
+			if (leafent_is_migration(entry))
+				folio = leafent_to_folio(entry);
 		}
 		/* return 1 if the page is an normal ksm page or KSM-placed zero page */
 		found = (folio && folio_test_ksm(folio)) || is_ksm_zero_pte(pte);
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index acc35c881547..42cd4079c660 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -691,10 +691,10 @@ static int check_hwpoisoned_entry(pte_t pte, unsigned long addr, short shift,
 	if (pte_present(pte)) {
 		pfn = pte_pfn(pte);
 	} else {
-		swp_entry_t swp = pte_to_swp_entry(pte);
+		const leaf_entry_t entry = leafent_from_pte(pte);
 
-		if (is_hwpoison_entry(swp))
-			pfn = swp_offset_pfn(swp);
+		if (leafent_is_hwpoison(entry))
+			pfn = leafent_to_pfn(entry);
 	}
 
 	if (!pfn || pfn != poisoned_pfn)
diff --git a/mm/memory.c b/mm/memory.c
index 3d118618bdeb..f7b837c3c4dd 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -902,7 +902,8 @@ static void restore_exclusive_pte(struct vm_area_struct *vma,
 static int try_restore_exclusive_pte(struct vm_area_struct *vma,
 		unsigned long addr, pte_t *ptep, pte_t orig_pte)
 {
-	struct page *page = pfn_swap_entry_to_page(pte_to_swp_entry(orig_pte));
+	const leaf_entry_t entry = leafent_from_pte(orig_pte);
+	struct page *page = leafent_to_page(entry);
 	struct folio *folio = page_folio(page);
 
 	if (folio_trylock(folio)) {
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f5b05754e6d5..48c85642fbe2 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -705,7 +705,9 @@ static int queue_folios_pte_range(pmd_t *pmd, unsigned long addr,
 		if (pte_none(ptent))
 			continue;
 		if (!pte_present(ptent)) {
-			if (is_migration_entry(pte_to_swp_entry(ptent)))
+			const leaf_entry_t entry = leafent_from_pte(ptent);
+
+			if (leafent_is_migration(entry))
 				qp->nr_failed++;
 			continue;
 		}
diff --git a/mm/migrate.c b/mm/migrate.c
index 8f2c3c7d87ba..22e52e90cb21 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -483,7 +483,7 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	spinlock_t *ptl;
 	pte_t *ptep;
 	pte_t pte;
-	swp_entry_t entry;
+	leaf_entry_t entry;
 
 	ptep = pte_offset_map_lock(mm, pmd, address, &ptl);
 	if (!ptep)
@@ -495,8 +495,8 @@ void migration_entry_wait(struct mm_struct *mm, pmd_t *pmd,
 	if (pte_none(pte) || pte_present(pte))
 		goto out;
 
-	entry = pte_to_swp_entry(pte);
-	if (!is_migration_entry(entry))
+	entry = leafent_from_pte(pte);
+	if (!leafent_is_migration(entry))
 		goto out;
 
 	migration_entry_wait_on_locked(entry, ptl);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 5cb5ac2f0290..490560245ab6 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -282,7 +282,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 		unsigned long mpfn = 0, pfn;
 		struct folio *folio;
 		struct page *page;
-		swp_entry_t entry;
+		leaf_entry_t entry;
 		pte_t pte;
 
 		pte = ptep_get(ptep);
@@ -301,11 +301,11 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 			 * page table entry. Other special swap entries are not
 			 * migratable, and we ignore regular swapped page.
 			 */
-			entry = pte_to_swp_entry(pte);
-			if (!is_device_private_entry(entry))
+			entry = leafent_from_pte(pte);
+			if (!leafent_is_device_private(entry))
 				goto next;
 
-			page = pfn_swap_entry_to_page(entry);
+			page = leafent_to_page(entry);
 			pgmap = page_pgmap(page);
 			if (!(migrate->flags &
 				MIGRATE_VMA_SELECT_DEVICE_PRIVATE) ||
@@ -331,7 +331,7 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
 
 			mpfn = migrate_pfn(page_to_pfn(page)) |
 					MIGRATE_PFN_MIGRATE;
-			if (is_writable_device_private_entry(entry))
+			if (leafent_is_device_private_write(entry))
 				mpfn |= MIGRATE_PFN_WRITE;
 		} else {
 			pfn = pte_pfn(pte);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 2134e28257d0..3358a3774db1 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -317,11 +317,11 @@ static long change_pte_range(struct mmu_gather *tlb,
 				pages++;
 			}
 		} else  {
-			swp_entry_t entry = pte_to_swp_entry(oldpte);
+			leaf_entry_t entry = leafent_from_pte(oldpte);
 			pte_t newpte;
 
-			if (is_writable_migration_entry(entry)) {
-				struct folio *folio = pfn_swap_entry_folio(entry);
+			if (leafent_is_migration_write(entry)) {
+				const struct folio *folio = leafent_to_folio(entry);
 
 				/*
 				 * A protection check is difficult so
@@ -335,7 +335,7 @@ static long change_pte_range(struct mmu_gather *tlb,
 				newpte = swp_entry_to_pte(entry);
 				if (pte_swp_soft_dirty(oldpte))
 					newpte = pte_swp_mksoft_dirty(newpte);
-			} else if (is_writable_device_private_entry(entry)) {
+			} else if (leafent_is_device_private_write(entry)) {
 				/*
 				 * We do not preserve soft-dirtiness. See
 				 * copy_nonpresent_pte() for explanation.
diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index b69b817ad180..52755d58ddc5 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -49,7 +49,7 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		if (is_migration)
 			return false;
 	} else if (!is_migration) {
-		swp_entry_t entry;
+		leaf_entry_t entry;
 
 		/*
 		 * Handle un-addressable ZONE_DEVICE memory.
@@ -67,9 +67,9 @@ static bool map_pte(struct page_vma_mapped_walk *pvmw, pmd_t *pmdvalp,
 		 * For more details on device private memory see HMM
 		 * (include/linux/hmm.h or mm/hmm.c).
 		 */
-		entry = pte_to_swp_entry(ptent);
-		if (!is_device_private_entry(entry) &&
-		    !is_device_exclusive_entry(entry))
+		entry = leafent_from_pte(ptent);
+		if (!leafent_is_device_private(entry) &&
+		    !leafent_is_device_exclusive(entry))
 			return false;
 	}
 	spin_lock(*ptlp);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index fc2576235fde..6cace2c8814a 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -1000,11 +1000,10 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 			goto found;
 		}
 	} else if (!pte_none(pte)) {
-		swp_entry_t entry = pte_to_swp_entry(pte);
+		const leaf_entry_t entry = leafent_from_pte(pte);
 
-		if ((flags & FW_MIGRATION) &&
-		    is_migration_entry(entry)) {
-			page = pfn_swap_entry_to_page(entry);
+		if ((flags & FW_MIGRATION) && leafent_is_migration(entry)) {
+			page = leafent_to_page(entry);
 			expose_page = false;
 			goto found;
 		}
diff --git a/mm/rmap.c b/mm/rmap.c
index 99203bf7d346..061d988b6ddf 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1969,7 +1969,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			pfn = leafent_to_pfn(pte_to_swp_entry(pteval));
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2368,7 +2368,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 		if (likely(pte_present(pteval))) {
 			pfn = pte_pfn(pteval);
 		} else {
-			pfn = swp_offset_pfn(pte_to_swp_entry(pteval));
+			pfn = leafent_to_pfn(pte_to_swp_entry(pteval));
 			VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
 		}
 
@@ -2453,8 +2453,11 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				folio_mark_dirty(folio);
 			writable = pte_write(pteval);
 		} else {
+			const leaf_entry_t entry = leafent_from_pte(pteval);
+
 			pte_clear(mm, address, pvmw.pte);
-			writable = is_writable_device_private_entry(pte_to_swp_entry(pteval));
+
+			writable = leafent_is_device_private_write(entry);
 		}
 
 		VM_WARN_ON_FOLIO(writable && folio_test_anon(folio) &&
-- 
2.51.0


