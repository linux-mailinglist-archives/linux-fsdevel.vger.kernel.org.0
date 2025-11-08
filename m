Return-Path: <linux-fsdevel+bounces-67534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20B3C43066
	for <lists+linux-fsdevel@lfdr.de>; Sat, 08 Nov 2025 18:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D02033B1C4F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Nov 2025 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C423D7E8;
	Sat,  8 Nov 2025 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gkl1S+rM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o2Uwfnma"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABBD145329;
	Sat,  8 Nov 2025 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762621810; cv=fail; b=KP0XM5OhSteAMATXDXm5egTQo9Kimi2bnyesGmWuTkutEl7swsBNhJZ9M/FTF55At1meLWktXzAxhhSU1XAoQaquOWBoSSwrN/+/F+QdMyHM5uMscvA4CJHNvEKqi4vTbNgk6D8NgOHDtL3lFORH4Yam0OG2fMDdnqQmu0I/18o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762621810; c=relaxed/simple;
	bh=7XmOOpaf5TmZLupavCzYibr5KX6ZsU6IglQlUo1EsoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FIT9Rae2gyXKCXw22l86uwUXY3RF4a2MpDXVgJ9Bu1o61d6En+Jew4XPWkrpf7415tp2EpTE0oPKZRRf5oLQbEftnGwFPavv23Efl2jSgCwpn0jlur6SXzFmKY0TydHumxIGIOxvkSaxGhRBVGnRzZ992y9+eTMvl0GlJVrae+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gkl1S+rM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o2Uwfnma; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8GeCYk007260;
	Sat, 8 Nov 2025 17:09:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VW1rVEDry31QDVbfRseXtsv01MYxQ7aH996ZkSCtb9U=; b=
	Gkl1S+rMjLcxur1UUr+JX312njS0Lx5AcAJZJUbwL05byE7P21NhhVvJYOoLm/ye
	lI9GaRSMmZuzTiYya4IIwCM/T+qpkxfEx3QL1Tb7CjBT9ChbA9ENBElEF2LmbxXo
	RJtTa557NUKB0GREhnyIjx0h/i1QPPmGgjm7uhzXeXrBDseTTfP+htbCJ8oh3pW0
	OAYTCK+bu7kmL/AMPakxDJqwKyLkJuzA4JLgNsW1UEeS/pyyfcKezSms/JJx3Uou
	RcEIpLfhWQX2azggM9LzSnXMDytv7DA6qosWNot6wN1p43pcvivC4D0scCiyBXYt
	UX0xp6y501k7ilyzCA36eg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aa9k8g0j0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A8Bgdsr010112;
	Sat, 8 Nov 2025 17:09:06 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vagemb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 08 Nov 2025 17:09:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/0Uzln7fGqreNchmpnQz+WW/yAS3QFieKuOqhoVjg9tIkJUYJefOIFuQgalrYRfcuc24k3BtlfO0p5z3GhKxjfgneLVRtpoIraou8qwqtaScSlXjvcQOPA27kwH0kWhr6qEuKdnmACMp1y+JiTGsgHnrCVHVGsyqBRRe4PhoWTpglawOwM0YPBgYXSu+8ZOjlcdZ8kjk+82LcRGnh7i5Rn+DA6WiVQYdmG3I8CBqS0d8uDF14sxOoUBNK1pTq2JLOZSndXV2iK/+eD7gHXJlAkTMoxQ1ICRY2kgNetUL/bxc7ngIltQqoa576Hux+69fULNwuW455h6LOJY4Y+WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW1rVEDry31QDVbfRseXtsv01MYxQ7aH996ZkSCtb9U=;
 b=xSVcOOMyOQtnqdx1xsserMKXX1wAEZ9lDk0CR8lDp4CQ6hxOzBpfblEcUulMSo8YABGb5LSZyEkhY26URTg3lGjGjZLE9PmtiUauR4KNv/VvKOm4850h2OKIXa6wIegMV2se0ISxvQT3EDZeZyoGAkDkV9VxA8xav+btgGEHhtECJYq4vEBSt1aJvkGzlfsGy02Jbqh50if01AhQisjaWHzHk6Z4wCgoBrW7lecaLWI5TG+mIwI3ekNADBOPsRaNy+WNQgf/UybszpaIIo0/vFIHWjVHAet/2kt6FKexYKeMfuOFe4LrE5KHaKCNXkZVWz9DyCQQX4A4C03AS/E+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW1rVEDry31QDVbfRseXtsv01MYxQ7aH996ZkSCtb9U=;
 b=o2Uwfnmaq+L86PjBr9DNH6SkHKYsAyYu6jqD2/UsQzpReAJYcEMzF8/MKWo1++9WT0gn7yFaw36F/+lbz1sxk/3e43vHKG5br7iyMSfJ8vlKIAy/g7Kw9nvPWgRtQtIPS+dKBr83q6T45RCivMGg05pZ+Y5LF5dZt6PHhX5wUmU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF04D2D7FA7.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.15; Sat, 8 Nov
 2025 17:09:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Sat, 8 Nov 2025
 17:09:01 +0000
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
Subject: [PATCH v2 04/16] mm: eliminate is_swap_pte() when softleaf_from_pte() suffices
Date: Sat,  8 Nov 2025 17:08:18 +0000
Message-ID: <75c2e8fa38de383757a49bcc3f5c081be1e27a40.1762621568.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
References: <cover.1762621567.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF04D2D7FA7:EE_
X-MS-Office365-Filtering-Correlation-Id: 600d7dfe-ebd8-4089-294f-08de1ee9833c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfUDLf9y5Cjew+dPRxmaAXl0plPnuv7xBcnyVa/QvI/vX5N87YwFsfayOYgD?=
 =?us-ascii?Q?GDD6pSRgVOqa+mEJFEsTupBB20OBpP6nG5HhIfIZRzeFNnaq/gaPuakKB5Xd?=
 =?us-ascii?Q?LOfII7sjb/3VsdqQPg8/LJWKZRCzZv9mlwVZ8/kZCgb65jLVUNRyRmSgBnYV?=
 =?us-ascii?Q?FYSB1njK/vNgsh0jgAGpy8eeyQ6GGD7crtx80PiOPAkwMcVSzCob2GiXjLa+?=
 =?us-ascii?Q?pfbYrDzlJ3qZUrK0oKgw4c78NsEckH0xmzcMwlbDUhbvSdZ9NUGrhM1O7d9A?=
 =?us-ascii?Q?V8xLXzorCrvqkAVAt/cAqc1FOjO3Ya2snIu0GdYNi48N1OE9XXBSr3wRXYuU?=
 =?us-ascii?Q?+2QLsEPA5HZAqgdA11VO8QVeLTkzlk5OTUde17Jm4xNRJhnqJ/l5VQ9p8LhE?=
 =?us-ascii?Q?5HrUMyzxVKh294qlfqoQcSfc4mDx4/qafoFwxGhWBo6dn0K65l57Q0wNn6Rq?=
 =?us-ascii?Q?J+ZriuMThE2i6FtHpAQ4n0FhRO0rNK6zn7Au0TXnAkazpRll7xJwatHZGvgD?=
 =?us-ascii?Q?dY/7ua3IWlcST5RnDeKxPFGVY5fZRrR+0sHrm0Ua3WFDvkkn58aPsizbIyfl?=
 =?us-ascii?Q?l+YpGjlaIpwyli/0yg68AYjQnZN3sx44D3aFpf1M8vh6xNv6bFowy5Q6dxwt?=
 =?us-ascii?Q?qFWnvgODfMqAVmOJDb8RvooEjzSmS+jKOC1i421J+qFGNDZO+jKXl4WRX8lK?=
 =?us-ascii?Q?clV/SBcIKe+Oevf3w+jlfPG+5C5QV/qYetEsURMkSgz24D+DwyqSzeKSR9BL?=
 =?us-ascii?Q?lUyckxov4VUzPtQ8vntYE0EnVtvOurprtC5uhsZ+izyFEk1O0OUbXFlNsC0y?=
 =?us-ascii?Q?IbZpSkAAu+SvjMVSOcEGb2SzwDA6u2CZoDBAxBcs3nGPoSYXnS5OgRavDb8Y?=
 =?us-ascii?Q?XL7IZmq7lfJoqPT+/KucaWNqQSspH9yt5C+4EIapD0XfbKsyytu5v8Tr0+QJ?=
 =?us-ascii?Q?o4E8KA67cOWPr316CrolAb5ySZHpaQZ0HK9UxIZxOED+5dagkqpHQbPAz6FU?=
 =?us-ascii?Q?NfsGLi9VdPp1vsahk1l30/0RPwMvxytpSD3OLacGM8BK78FLF5v+2lMetKVM?=
 =?us-ascii?Q?2XSP42xcsbx9hkgqLOO5mOEmyrlo43jrVf8k9Zgd5Q1kyGImlnOAVDd8Aoco?=
 =?us-ascii?Q?q9KA4zlD0MVd2C9v4UTpiQmsxjoV3qfiHqUwN+IM9f6c7wGR3mcyyj0IOooY?=
 =?us-ascii?Q?4ZqA+4+mgm0GvabDqFO9a1tH5LUFGON903iUYfTGmuLacS7lt1UedYzV5VGG?=
 =?us-ascii?Q?O6lPbLd2wMwHOoQrlurOSXHWgEaIn7TexFB2ft5cXrePbtcqvegj2ltfDD4k?=
 =?us-ascii?Q?5fOUoapBfjW2B7C6DlcMn/nDQqDNBt5J24ApGujxgtC6O0DuCLC6VRJaJPuu?=
 =?us-ascii?Q?da6hCvBRs7hoHhuBnML6Ci7Q9ag9Bo1pXfoG0o6HyNcY3rHZEPONqsPfD6Sw?=
 =?us-ascii?Q?Rh0IvuERqGQi4fF8EHIgfjcAsgiWTdH0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9+ue1x4m+E3eW2aNeuDKprxHLoxqbfJQWm1WrP4/OOGxBuDhB0Nos5AORzlB?=
 =?us-ascii?Q?Aj+UrEMLaIbVVJfmRGjRyXiOe5gtk+om2kARM9uFL1ld1Y3JF2CpR7uWUlyT?=
 =?us-ascii?Q?O/TdBvVXI4EKmOKfWAKMA7g6rAUNpBXRyEr/hJ3bsWmaQRgQIANY4mKSH7ob?=
 =?us-ascii?Q?RGjsuggujbMAlOZp4PytbboypGm5OO81bxZTaYMg6w732oORxtjscedFI5Ld?=
 =?us-ascii?Q?fPwISeJoLNJDNDIttkkIUNKDgUSOhZKwjGpwKFdzp3iCxUNSdMN8+wjGN5RJ?=
 =?us-ascii?Q?UvTx+mLMOHRmBOHFKW82N/bxpIPE9IgkdT+c26EIC7KNVTZKoO3msQUr80MA?=
 =?us-ascii?Q?+alELZbqAU+srs+wRyolcoTCgo0Vhr7V5WmL+WuA6t3EBQQrhYmb8/g67q3N?=
 =?us-ascii?Q?Mtun/z5qW48NzfNWlZDzetQuTNyJnpKyeqCs4/o4JMhbpCw3/62IVnQULMja?=
 =?us-ascii?Q?hJ0gjbcCzycLDcl+T4fD10tCL1S5jy7L8ZbKTxo/5PdLwf9hj9YMrpKprs/O?=
 =?us-ascii?Q?plQkkhm+9V5vL9xE7R0hK8wt2ehII3v/EIu+q72H++dQgpSg55wJi8UAk04L?=
 =?us-ascii?Q?I126VWOalaRnv6Sp+TKvzmqGUUiQWrMfmROrLWm2yI6S6eUcKEEtqFgww9/b?=
 =?us-ascii?Q?x8jMmnnxMFihBQZeb/zD0LozwFGJumgL+0nekgBIKghkJ/Pe4Z1JQkdEO7G3?=
 =?us-ascii?Q?rO1kb91kVklAqtfzblvDUvu1uIN991gxukJGtmZa7JEdyQ7j0roBVqwLJ0b6?=
 =?us-ascii?Q?vl5/s8fcu4/RAU13upbwBE3q9t7dvBmYH04Nz/ICNxsdYHi0UI4P37pfWpcc?=
 =?us-ascii?Q?FchVhz+cTMvMurhl5c/lMa2GLHWF1IVOuERX6fR0dts6xsjFMzHSNroL8QGG?=
 =?us-ascii?Q?tBXkkmYOFyvZ6S7ctJqfLoDmLhN91/VgbZN8JBYDy2w13TKBb9bZI+lcYmf9?=
 =?us-ascii?Q?gDDEsDJob+R8gdpv6iytI9ImXFMu55xLlT4Vn3fWf51szUcY3hceykyqcg2H?=
 =?us-ascii?Q?aIb/848U0fAxydatyyvvPxHkaFqg5o+4IgIrGqO6beDV1DYM0MbambffEYnC?=
 =?us-ascii?Q?b5AQCCbV0aP2G/SDLHYPBCr7SIv2l8HppTfdXz/x0c2QBVqr+YKw52K4pqr3?=
 =?us-ascii?Q?PeGHnBI9xsUoX1iqqzXPo1vbV9mw8vlndNH6JrLdXHNcQ+K/NtMX3sgO3sm4?=
 =?us-ascii?Q?7hYPdpYAvY7q0CaLhkRa5MLDPAbSRAtfrTgjTqvaLStM49nAYIW/misolwep?=
 =?us-ascii?Q?2DWMHj2v+9X6Y4LVrN6oDYMe4LaI6EQXptEhjaqE2T7oGWJmhFGIY6mGc8kG?=
 =?us-ascii?Q?QJogXrfD4iRVZzWcXJdBxUPsZh0z94teEVxZffm+3+KwHif3ZEt6qS3gKe34?=
 =?us-ascii?Q?bgGmC06LNYQPxWew8DImS5S42ge9JMibn4IQgYjVM8Hoodttj15xPBNHOCf7?=
 =?us-ascii?Q?6yjXNbns1zZCuUcwqGLchMRGcMVNaRjjIPzFoLfZLUKDrupF+QVqQwxCaeFE?=
 =?us-ascii?Q?md1tZTsPAeXhlRR4ZNTvqiW6QkJ83BRWRbeGysWxjxXID0aE9R86tzyY88uH?=
 =?us-ascii?Q?Q73gUSf/EyHqkqhHX/W+0TFflf6FVbooZvvo2+eURQjz++eeZsznw90HkgaZ?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MZC3Td3qWWcQayQSbWyyJur4x92igO4/1sJtS1de8iSx5jc8pwHId16tGfoPKSYZTSGXkQkSKqPcdGxQcZZLXAF7JzHDVOssV4YLVD4QTi5xrkiInGsFb5Joxa40qjHfSn98D8FW0s+H9A0LYJYzUcCU6o79WcpUjz9K6V948yOZNrmoTBsn0GLArzGS7kAsL03PEs94ua0HdrTsjPqg4pMXxfb2EtRVsvc8NQ4iP+Rc5jpW1SpdOeL87k/N5eEPWmRWt7GdqJYxmhmB6R9XyR6keeDMg7FL166P7DpsFgvJkcGV5yANcy0fP2H3G1IGGMvl0uT1CXPKP1+6ZiHJQ3pXIT33Mn7eCqOwl5cgQyuVk+Fo55rxww/argIzBF62X0y3kWZRaUS517zfQRJnU7JcaQlh/VNPMwfvBsG88NUkZRDgKayaoEyE9ZopYCj5l4NOm7hJ3ZJsr6y/txDrLHK7lpMf6VRsDioBbYksdsZuonwfT5NyV5YilUnJTO8COHXXZOrfcl8w9Tvh+Hqe+LxocxCWoPEkboR3r8RdAeNFSNCTpZKW3H4/oxNQd5SoeugpsGiSIO0pqp3QRnU/x/J3hgTMsJl7vCLdpTdCjFE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600d7dfe-ebd8-4089-294f-08de1ee9833c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2025 17:09:01.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: old6vNgrcIviA/XaisvC19TSMK17hts8pdMh4FRy4H15BBZ0jcQPwuLwW8S3LG0VzRzmQv3KqTr2g3x6Wts7u2g6n29SJvP5BB/zXFc+AzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF04D2D7FA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-08_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511080138
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDEzNCBTYWx0ZWRfXzVt2BptLdtCV
 EzzAexKn+67A4T84mUKODYl60jsFsEv+xxFX+ryASVmd4Ksxra7gpKbsdeDVyxMqy4R4ENXciyv
 r126040+sOSQ0Z5FKzF33pXmEqolWzZbAeqX5ihuV/8FQMoavYtB1sBUtgYZsKI7yxXJ5ohmW7z
 /VP0T5wWVQCnt3gGFls72YgDL6TTe39ZHWL+1eLCd8Lcse4EnVLQBytRjXX8+y3WuJ67U2mmPhW
 CXTfd3nHnY5YZI9B/lSMbggRCgu6X8pCCSasvxBnZxNdziEiwn003+qVbYE8rQCiPYXqP/hzM3L
 zf0y0VGixBTlghVCorL8BanAzN5LLMmMyjoUGI2OBxey5Ch7zx6HvJi+yBZ8/CUp0ZvSGC4TwsP
 VDqkqr2WvelzoFTYs7uMNqW+NoG5I3H3gBLi1pbgqyjh0hQ81r8=
X-Proofpoint-ORIG-GUID: 8qlM6wBoRWxHUyL4DVzC9P-Ms4t2bohv
X-Authority-Analysis: v=2.4 cv=U4ufzOru c=1 sm=1 tr=0 ts=690f7932 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=x3qbZFVQRPWiRpXx7eIA:9 cc=ntf awl=host:12097
X-Proofpoint-GUID: 8qlM6wBoRWxHUyL4DVzC9P-Ms4t2bohv

In cases where we can simply utilise the fact that softleaf_from_pte()
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
index 9465129367a4..f0c7461bb02c 100644
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
+	const softleaf_t entry = softleaf_from_pte(pte);
 	pte_t *ptep = start_ptep + 1;
 	unsigned short cgroup_id;
 
 	VM_WARN_ON(max_nr < 1);
-	VM_WARN_ON(!is_swap_pte(pte));
-	VM_WARN_ON(non_swap_entry(entry));
+	VM_WARN_ON(!softleaf_is_swap(entry));
 
 	cgroup_id = lookup_swap_cgroup_id(entry);
 	while (ptep < end_ptep) {
diff --git a/mm/madvise.c b/mm/madvise.c
index 2d5ad3cb37bb..58d82495b6c6 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -195,7 +195,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 
 	for (addr = start; addr < end; addr += PAGE_SIZE) {
 		pte_t pte;
-		swp_entry_t entry;
+		softleaf_t entry;
 		struct folio *folio;
 
 		if (!ptep++) {
@@ -205,10 +205,8 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		}
 
 		pte = ptep_get(ptep);
-		if (!is_swap_pte(pte))
-			continue;
-		entry = pte_to_swp_entry(pte);
-		if (unlikely(non_swap_entry(entry)))
+		entry = softleaf_from_pte(pte);
+		if (unlikely(!softleaf_is_swap(entry)))
 			continue;
 
 		pte_unmap_unlock(ptep, ptl);
diff --git a/mm/swap_state.c b/mm/swap_state.c
index d20d238109f9..8881a79f200c 100644
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
+		softleaf_t entry;
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
+		entry = softleaf_from_pte(pentry);
+
+		if (!softleaf_is_swap(entry))
 			continue;
 		pte_unmap(pte);
 		pte = NULL;
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 543f303f101d..684f78cd7dd1 100644
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
+		softleaf_t entry;
 		int ret;
 		pte_t ptent;
 
@@ -2267,11 +2267,10 @@ static int unuse_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
 		}
 
 		ptent = ptep_get_lockless(pte);
+		entry = softleaf_from_pte(ptent);
 
-		if (!is_swap_pte(ptent))
+		if (!softleaf_is_swap(entry))
 			continue;
-
-		entry = pte_to_swp_entry(ptent);
 		if (swp_type(entry) != type)
 			continue;
 
-- 
2.51.0


