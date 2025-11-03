Return-Path: <linux-fsdevel+bounces-66769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93AC2BB94
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 13:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 852C734A395
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 12:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017003128AD;
	Mon,  3 Nov 2025 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S0Iwumke";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jisatVVU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9276C30CDB5;
	Mon,  3 Nov 2025 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173295; cv=fail; b=Vn+4PCtpoZHNiBXIQNsUAQlxkcx47EoIrhKcNQEyePEjid9lITjsIqGXAekO/hVqi+6Wuwty4M5Ravgt7ufKtUWLNH3i2132JdYqd9amZNtw/vztapzk1ccxUYqjuYhWqNNJeymaTxYpohgj8bQAVmebqcIox/Aq8I2uzOC9dBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173295; c=relaxed/simple;
	bh=AZ3s0B+uhePQZXTS6i9X9ezX6E6ciUS6QFxCmlxX9io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2feE0q9t6BS3TyOlp9UV4flhRQcHTg44n/JsIxfsOpAGXpG8wcjsydY4XoYITACH5lTm92LH88NFkvGI5wdE0jOhB24yxTrfv10Rdlnf/InnfPAxdTqoa+vQnO9l7HXLW9mntg1OlkE2O8/ktmg9SnlO0/mkW/fR7196tPO2gM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S0Iwumke; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jisatVVU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3CTppr011573;
	Mon, 3 Nov 2025 12:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=; b=
	S0IwumkeSXNSIV1j+VErMC8UGnfcVwReF4OSLQgNQ52mRRs/b4x4J0cW9Nk6xYd4
	YcasJmsKSX24Q2xI6IEmBg+CgS9D8KRvwS/z4An0d3RdYZ/wwegHTdAsUZdo6HZR
	gXqfhgFxQMpvAtZszr38uCLhhrBWzJrhtaH2NK4ugMTLw/quOc27TYNR2iN/QKiA
	KKsp8nNx3C4cPUgThoqkF9QxofXrdbe6nxj8GdeZbSf6yMXdL6XxFZPhUUXUhPBZ
	bPYTdaRbJosme0RgcfHvaItoqnBPmZTUgxoixwpgY6qKOOkEsSdjoWVTsjYT8//I
	YOyzOGU1vcl8NUgCjiJsCQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6vep006x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A3BDrp6008001;
	Mon, 3 Nov 2025 12:32:35 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbkq5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 12:32:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=chnkFAd+6C10g8fTekQ2Iw57rRqYXZ+ufOUuH0uEqxQFu21zr2hv/NmRy7LbgxGpdrfmMRe88+oID7HjANqUvcfAgKN5VajaZqwnma7XaLaZsIKQEukzjwcBfky6O8CQW3WK3wVYVp9TsrOCxzwSXItV21qwFa/EJQsbgmFZOoit00snKIVSmk5UyZEgIcC5ilva4zfyLhwy0SsyDE91glSLWIti7Lurr76va7LcHpj1uEVQF/HJFxWuY6lC2Fo7kfebEDal4cg7/m0pmv1TimnnuP3Qbcbb03O6RwwtFCfryICp1zHRZ1xyejq9Vs0kMzhOnROF4FT2BR9NsWMwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=;
 b=JI0rvb51roUbwudL4axm2FmQm5xbHXq7ULEQB//wNsvhrqasnmWUP1oC0QEPgXWP4LzDfDtFFeosz+cQzbDeU/hh+ZE/DcWgXUGL7icc+c5etgP7NvTU0VZzU4zMV9yrp5MpLfhvsksIWg9k2D5DuA+GbLayoZ4VmcZMRWdzlK4Oduy5xClP/axTKwzk+iTRzexkoo/UV9VAQ0QTDod6uWGz4DocQxeZ8K7z0znPP+MtwqSVyF/VVDqcH0pjJkC/GjoaN7ng8DLkB0nJ7j31iid9AwRfM3aDNOw7A76s+P2Lkm+d0VaU43XLSYKFq1QtE4JDsv+B0LJ0gTAd/BB0Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vzCGIt3sJ5ONOndZRuqYi7OVSaXyL8N0gC2xsfawbow=;
 b=jisatVVU3UZmwipCM00m4daQHRSYUkBKSzD6+eS66smYDJ5h7lRqF1wVGqnhWVjFeZQPo5rk85t9aTgQ4EUpPF8PBtjeKapLC4aRrRZvhXqYBhLJ8nyOtT1G3Hp2YDA2w/3bfzMgrXn80KzCq7ea0FqKkI/W7CZ1uBx4bCXe+VY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PR10MB997575.namprd10.prod.outlook.com (2603:10b6:8:31e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:32:31 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Mon, 3 Nov 2025
 12:32:31 +0000
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
Subject: [PATCH 08/16] mm/huge_memory: refactor copy_huge_pmd() non-present logic
Date: Mon,  3 Nov 2025 12:31:49 +0000
Message-ID: <d9e0856e597da9cc02ac10f98852aed0cdef25bb.1762171281.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0248.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PR10MB997575:EE_
X-MS-Office365-Filtering-Correlation-Id: 97d10fe1-76b1-4aef-fbde-08de1ad50eee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?goTqqAEet28J/wcc/+aWlwlbOYlwLmxvEkA9Cgfp9lqMMKpLcyTp7WXjOvyV?=
 =?us-ascii?Q?8NItD7dgjNHvKR46lf/xeD9AfmgF+pUyBXgC6kTKJXyWdbr4TXAVgU+9vZc6?=
 =?us-ascii?Q?Qrh/v9aBpwB4+0xKsy8UqkX8d+aQ0iGhn79aR24TVVCk5NGD7U1eRbThyxxf?=
 =?us-ascii?Q?Md9dDfV5jHu6139K+xOSKHXqIPFU6bY9hklS3AaS6mli2T0F2uG2SJysbw8F?=
 =?us-ascii?Q?DkynwDq6r9Ib07XGp5kGSlVjr/OIpnnF/6PdnbOcm+6kdUHmuwKWCViuUu+i?=
 =?us-ascii?Q?+qgIxGnJVGbUhtLJQoAM6h6cnV0X14zjOQDXvxu0QWd8DXpksjI/r05AvsRY?=
 =?us-ascii?Q?bFNtGraa+YACu29YBq8gH4l/Bii03W+MvE3u5OWhAUbSq6+U0Ev7WsTcZCXR?=
 =?us-ascii?Q?z0hs2UE0J+zogGWHxkPzPDCBcYA09O+DyOk9xmCOYsV/QA31aIZKuHsnLrXe?=
 =?us-ascii?Q?uOB0OprRyU5aZ6JbGh1mWeOE9Zc+0pZ0YmwE5z4LKBiG/gmvzSQ1p/sNwbxX?=
 =?us-ascii?Q?lm6oMfAJ2M7DIVyyl6Wr9RVr9hhLabnXzP6n/6EqCymuThcyjqDAAgbyk0sZ?=
 =?us-ascii?Q?Qh/RGpjGaoa4WQSZFhItBPmK8UKs65b9zsUOfBFW7W2zhX2wfe8ZI40OTqDV?=
 =?us-ascii?Q?t78V3aH+/LHmoQex/BPoPh3t1i47/PR7za8ajR8UfATEfve6CCZgqGwwHSrL?=
 =?us-ascii?Q?w5tJbSAl4h3DU0pmA+CfC/VmipG0V5FITF+eVmyYXYuZYKS/rSfeoWGMoCCa?=
 =?us-ascii?Q?+Ich+nohSng4umnIA1lPYTh4Yfyct6Q3fYnErBfQROLs9Zf44Ck50hwQ/syb?=
 =?us-ascii?Q?sFVofekilZ6/s6lzVWL/M/AAmoJC8wSrvTibtEryhAcuix9YWZM6bjtkNGTv?=
 =?us-ascii?Q?hV2r+FRV74E81WwNpDEt1zKZZAIvz7e25rT+kW6cSukb0sNXIyFp21hFWmMI?=
 =?us-ascii?Q?OVkQNNNDWXSL5h8yfotqrLTPv7bbKZeCZUByIdBmCbLomPGy9mFXPRYxGyk3?=
 =?us-ascii?Q?v4UGRfLQjSYtUHPRrTAi6ZiJ6KlIEF5H1mbw2JdrMhlA4EcMkaEmLusm4Zfs?=
 =?us-ascii?Q?w7F41y2tI28TXchrAL+/xshZB5+ZslikOGMfGG7g8ZlXfBnb1LlExBPL66hw?=
 =?us-ascii?Q?A78PI0a/OfspSeHDkRHxZV2AESNdZGq5UHt5V7w2B6zDibOyiUvRHMNM7UxP?=
 =?us-ascii?Q?K080XajvSc+RMa+gJit4JXL6e+S0hMlqitBn2M3ZWA4Sh2t9bUNYSSD0+EKl?=
 =?us-ascii?Q?ugljUoOjDnlpR41jJjpCFC7G55qP8t+XHcYR9YH+/HhPxhccY6hNubczrlqw?=
 =?us-ascii?Q?T8hVFy5BBNc53usPRYHbpCa7wvBBLOa5l/tMAh70SSbfuzOpblURILDKo8Rr?=
 =?us-ascii?Q?Nw6m19d2omdKENebkzXJdWTpCkemOXiLFnB1BPf3AN7IToYeymOeR5ZT9LaU?=
 =?us-ascii?Q?R6tb4rA1ND7bYNxPQG9WvbRjWahga5j1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1Mhuidb3Wy2VFdfYQqxOxxeCC0sjMr8gmiBFS8ysPg42DvwhDEUVekMvQGzH?=
 =?us-ascii?Q?PbG9wiZtBSaaPmYPDM2lPhU6/jVBp+QI46tT4gwYZF6pGX8uwIDOdL0xmtxz?=
 =?us-ascii?Q?yoomh0Ay66RQY6dz/eA7e5DHVIjdVRIoWlYHnWPqq30050MWbTxrM91nK6/Z?=
 =?us-ascii?Q?4RI3wPS8cq6srgFa7LslGhMl9bRPHhi+sM2uDrg4N+7xLQR6I1eM1ed7V+f1?=
 =?us-ascii?Q?zvwCkO/UzokcoQA7H+YbB2N4jFtrViiU43SG3TR1u/8+QoRHOyZP8cQ2XEaD?=
 =?us-ascii?Q?7NOJXkcXqFsuJzhMc0Sl3t9hMCedY+RtlyMe/uE1Uq2fWG4QmjVHVWHOvI73?=
 =?us-ascii?Q?2r77FgTliVkuaXPw/+DEj93jyp1Od7zYXgKnKxmJIlSTSDUYqrPMCpocMsup?=
 =?us-ascii?Q?M/L1tXL47IK0Q7D0PG6/1ga4pgoeV92Jd0YaJsQ/yDPUZPfrC3O8y+rg36q2?=
 =?us-ascii?Q?L+ZHofiCz1RUys3MTqL+YerThLc9EKXSm9KFJcfHBKu/vB4u+ccCFZJqlgr9?=
 =?us-ascii?Q?uXNuixkJECGL/vnvJrK0fog3C8+TMKCJbGxc/YM9Y/eC/zYLf8OB3QttpFme?=
 =?us-ascii?Q?TwQZjx9fst0tXqzmRZjWYb66OlBSEW2M1RYKeMSCDIAAgY/kcKqZoUTKtgZL?=
 =?us-ascii?Q?MJFalO1G28j1qKlPCgNIq9QJXAkYe9N+wy+3HycF4mOJqZbh+FHU1pr9iXjA?=
 =?us-ascii?Q?Y+gzV6RPxqHoY8TDoMRqSLuK2XiuvzCTqJEipc0pdhe5HbH5DGo/raIInqB7?=
 =?us-ascii?Q?MiJ+IlQcfqUY5U7rSUmuSf8Ixq2av0mOmjKotV2modN7bNd/gA6/kRxAfhS4?=
 =?us-ascii?Q?NJCFzDaWXu+PVseaV8dBVH7Ii9lYnwKRkgbsdETCZ48TEXtfIP+X3rmansQU?=
 =?us-ascii?Q?VWRNWZvl0f9wQjSqcDk5KZPhXvhGuLaWIxH3ojYLOJyJrkaTHgBxh84xwlcZ?=
 =?us-ascii?Q?SkKKWIyN8sVpyyBjE1pzFfjbHjJqjU5aOBCPIWjVHSA5KlIrsBLcX4VLP1wW?=
 =?us-ascii?Q?5AiJ/OxNK1LvPgouDJgnqJP9BpHDSWpaWqE00iUFUeN9gguh301A6TbJVOZS?=
 =?us-ascii?Q?QOQG5ovdg6Ykm3iC6qyhN7mwBRSEWMWZkQXilmw6k2k8TZ/VtPYspXE8Ofja?=
 =?us-ascii?Q?E3hSPWB/c0E+ZwVftkrhrHbBFZe+oZRbTCRQ2PUNsbo9v2euN9IyTIiJX206?=
 =?us-ascii?Q?ib44ySrA9HIfmbQjAv+H1Mbs5syZDZd/KhViFq5H9jvDXTAHPg0+MIipb+iG?=
 =?us-ascii?Q?FYneRzBU3gx46dLBc4PMOS6i/71IlWM+mEyt6JYzqTMUc+MFP+bDec+vm22U?=
 =?us-ascii?Q?/KYDT9UeJpNVDP7cCu6eoyCL3NU8zOa5h0C8GVUwTqhusAO1rnSR2PiNhlyq?=
 =?us-ascii?Q?grMfTxg54+QmKE0Ap20N+DWVg0IZPtF+4rAlDbt6icta0vVM5WX2BcjBuzK+?=
 =?us-ascii?Q?aMux0MF0ckjtZOT/5bgZv9lEjWLJSDJR7zL31OOyvQQmeRGZTp5Nc8j6qKNZ?=
 =?us-ascii?Q?8CiABNHY8lqPKtaUwyj19SusJcmhPhagxFzAibWDWWdPILeUgW/Q2u3hfjtV?=
 =?us-ascii?Q?LAO7YdJlPB1Q55Xs9zk6Tsbi7OS0XIGoVhDrYuF1uViSRpJDYXFMm4Gx4LBK?=
 =?us-ascii?Q?tQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IckzrXV//19uGhfjeY695J7LPJJdAa26P3hjOzR0GEHXqiBcaTl9/vz1hX3m/LhKLR+9BB71Hts9Y1gfw0u+/dnKzzCT/qeMM1N3ETgWu6DWqNZ2KobcjEzvHEoi8HoAK6/+dh/t/lBDGkqt3JBurLeroZR92JN++WDJ+HjwX0FB3PD5X/5iSWHLQVSIy3zDXodZRAfyDW0P1c+cUsczjKtOYxysZjCGs46N28amM0SavD4o8JQHNYI+HrOmmKPiREkOa/KH+cRy4qsxoIbPnBzZv4+DozYb2sYrwukWNXnQ6sKDYM8inP11MBKdYQA3x5kqNKnuMbFnHOtpJoTr2RRoWEFq5ePEd3SpbmlyO4ydg5EepuWT/88iH6I2CqmVD3+Ps1V7E8czbmee4X+IpwU7P29hUv71Nv6Qav10wmAsVvAtUrey4+Dcss0Y4ifTAw5GhF4baW57PlGEX1gvYgdaol5vH7CUu/T8ICGU3WualEQIZldEIronqQeJSQGbTpOmr+z292YF+ozcVtcLravKEL+XzSM7oOcc9ggcPsqusRa5ilTU9EoGZSB41hpe/1glCwst2OIOqYV2U2aHn3oAEGEcjvndebKzqbXp8+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97d10fe1-76b1-4aef-fbde-08de1ad50eee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:32:31.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4Eaiiw9o2tGM5ODSUaUULinKQ83cMxLSjl5oWgR3/IEUUMjy/3tSKDZrDptLZCt5iVYjR5/SVR/9yjCXR58EV41pG99nEyN2ef7+SiUcDI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997575
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511030113
X-Proofpoint-GUID: j_BMPxljbS4l8BBsb4L5dv0UdDfqOv1s
X-Proofpoint-ORIG-GUID: j_BMPxljbS4l8BBsb4L5dv0UdDfqOv1s
X-Authority-Analysis: v=2.4 cv=B9m0EetM c=1 sm=1 tr=0 ts=6908a0e4 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=9UmCEYkwnbpDqGD1g-YA:9 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExNCBTYWx0ZWRfX5sIhcI5yuHwt
 pyGRrFfRhatjT6dxPYKI+TCgTzklj3LazTsbyKPEkYy4XD01Rvs3uBRKCRoqgJW+qBOv5UoEnYR
 ysAV4sFqlhvPQ5b+4C0btp58DP1FSNoll6D5BcQJYKAccOQ65ydgcARCMm5A9nne1lNo/2NQ3Zg
 qi145m2l6SHpNHnHdRwYe6mW1GjwG7XYgm4I+P5RZNJxqNtv7bXrc6nKmEiZ0UN7OacojG2lKZE
 h3h4aU5W2bWa8OkqamQPq54Q25Gxxc8ozLnhB6tNATkf2ctT5Q04H51u9B1paa30WQkJk+pkBPH
 smV11p+uBMTfynDngXFfXbnzrmEh8Q39ijylv52xf4jBZYC1wXsA49BXtkjH1LguPcbPTrB7qAJ
 g2I7wolVarFOGePXJ7q/MpE8MGO5eI2igv01RpkCFalW/YiEx0I=

Right now we are inconsistent in our use of thp_migration_supported():

static inline bool thp_migration_supported(void)
{
	return IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION);
}

And simply having arbitrary and ugly #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION blocks in code.

This is exhibited in copy_huge_pmd(), which inserts a large #ifdef
CONFIG_ARCH_ENABLE_THP_MIGRATION block and an if-branch which is difficult
to follow

It's difficult to follow the logic of such a large function and the
non-present PMD logic is clearly separate as it sits in a giant if-branch.

Therefore this patch both separates out the logic and utilises
thp_migration_supported().

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/huge_memory.c | 109 +++++++++++++++++++++++++----------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2e5196a68f14..31116d69e289 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1774,6 +1774,62 @@ void touch_pmd(struct vm_area_struct *vma, unsigned long addr,
 		update_mmu_cache_pmd(vma, addr, pmd);
 }
 
+static void copy_huge_non_present_pmd(
+		struct mm_struct *dst_mm, struct mm_struct *src_mm,
+		pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
+		struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
+		pmd_t pmd, pgtable_t pgtable)
+{
+	swp_entry_t entry = pmd_to_swp_entry(pmd);
+	struct folio *src_folio;
+
+	VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
+
+	if (is_writable_migration_entry(entry) ||
+	    is_readable_exclusive_migration_entry(entry)) {
+		entry = make_readable_migration_entry(swp_offset(entry));
+		pmd = swp_entry_to_pmd(entry);
+		if (pmd_swp_soft_dirty(*src_pmd))
+			pmd = pmd_swp_mksoft_dirty(pmd);
+		if (pmd_swp_uffd_wp(*src_pmd))
+			pmd = pmd_swp_mkuffd_wp(pmd);
+		set_pmd_at(src_mm, addr, src_pmd, pmd);
+	} else if (is_device_private_entry(entry)) {
+		/*
+		 * For device private entries, since there are no
+		 * read exclusive entries, writable = !readable
+		 */
+		if (is_writable_device_private_entry(entry)) {
+			entry = make_readable_device_private_entry(swp_offset(entry));
+			pmd = swp_entry_to_pmd(entry);
+
+			if (pmd_swp_soft_dirty(*src_pmd))
+				pmd = pmd_swp_mksoft_dirty(pmd);
+			if (pmd_swp_uffd_wp(*src_pmd))
+				pmd = pmd_swp_mkuffd_wp(pmd);
+			set_pmd_at(src_mm, addr, src_pmd, pmd);
+		}
+
+		src_folio = pfn_swap_entry_folio(entry);
+		VM_WARN_ON(!folio_test_large(src_folio));
+
+		folio_get(src_folio);
+		/*
+		 * folio_try_dup_anon_rmap_pmd does not fail for
+		 * device private entries.
+		 */
+		folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
+					    dst_vma, src_vma);
+	}
+
+	add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
+	mm_inc_nr_ptes(dst_mm);
+	pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
+	if (!userfaultfd_wp(dst_vma))
+		pmd = pmd_swp_clear_uffd_wp(pmd);
+	set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+}
+
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		  pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
 		  struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
@@ -1819,59 +1875,12 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 	ret = -EAGAIN;
 	pmd = *src_pmd;
 
-#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
-	if (unlikely(is_swap_pmd(pmd))) {
-		swp_entry_t entry = pmd_to_swp_entry(pmd);
-
-		VM_WARN_ON(!is_pmd_non_present_folio_entry(pmd));
-
-		if (is_writable_migration_entry(entry) ||
-		    is_readable_exclusive_migration_entry(entry)) {
-			entry = make_readable_migration_entry(swp_offset(entry));
-			pmd = swp_entry_to_pmd(entry);
-			if (pmd_swp_soft_dirty(*src_pmd))
-				pmd = pmd_swp_mksoft_dirty(pmd);
-			if (pmd_swp_uffd_wp(*src_pmd))
-				pmd = pmd_swp_mkuffd_wp(pmd);
-			set_pmd_at(src_mm, addr, src_pmd, pmd);
-		} else if (is_device_private_entry(entry)) {
-			/*
-			 * For device private entries, since there are no
-			 * read exclusive entries, writable = !readable
-			 */
-			if (is_writable_device_private_entry(entry)) {
-				entry = make_readable_device_private_entry(swp_offset(entry));
-				pmd = swp_entry_to_pmd(entry);
-
-				if (pmd_swp_soft_dirty(*src_pmd))
-					pmd = pmd_swp_mksoft_dirty(pmd);
-				if (pmd_swp_uffd_wp(*src_pmd))
-					pmd = pmd_swp_mkuffd_wp(pmd);
-				set_pmd_at(src_mm, addr, src_pmd, pmd);
-			}
-
-			src_folio = pfn_swap_entry_folio(entry);
-			VM_WARN_ON(!folio_test_large(src_folio));
-
-			folio_get(src_folio);
-			/*
-			 * folio_try_dup_anon_rmap_pmd does not fail for
-			 * device private entries.
-			 */
-			folio_try_dup_anon_rmap_pmd(src_folio, &src_folio->page,
-							dst_vma, src_vma);
-		}
-
-		add_mm_counter(dst_mm, MM_ANONPAGES, HPAGE_PMD_NR);
-		mm_inc_nr_ptes(dst_mm);
-		pgtable_trans_huge_deposit(dst_mm, dst_pmd, pgtable);
-		if (!userfaultfd_wp(dst_vma))
-			pmd = pmd_swp_clear_uffd_wp(pmd);
-		set_pmd_at(dst_mm, addr, dst_pmd, pmd);
+	if (unlikely(thp_migration_supported() && is_swap_pmd(pmd))) {
+		copy_huge_non_present_pmd(dst_mm, src_mm, dst_pmd, src_pmd, addr,
+					  dst_vma, src_vma, pmd, pgtable);
 		ret = 0;
 		goto out_unlock;
 	}
-#endif
 
 	if (unlikely(!pmd_trans_huge(pmd))) {
 		pte_free(dst_mm, pgtable);
-- 
2.51.0


