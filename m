Return-Path: <linux-fsdevel+bounces-60849-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7176B5222D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58B41895F7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61830AD13;
	Wed, 10 Sep 2025 20:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXoBATT3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Lhp/Pfvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF902F6196;
	Wed, 10 Sep 2025 20:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535849; cv=fail; b=E6pkJwMIyRjb4gSeDpVFUoAqw2VFyK4UfhQDq4RHdttgRzcfoHxQ4x5x6larF2yOoprGPqUOvBCQIkOyFuvvWJEHuuEUhbgzxLK3sGjjlmv7Y+Ww9qGtDp0Emt6jFa/pSFUKZkEQs99/8yJsBHa81GJlywwyD7EFU1Qn84qYTHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535849; c=relaxed/simple;
	bh=1JfdXBZRZLU1ilQ7TO3Xv2SbxUPYw+73vGPGbPcjgLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ITp2Yeb7X5VhSb5eJxpXYhNH5o2BqDuq4MYHTxFq6bSwpUUGsJgn7o3ifaxKn6rD7s9fkuTaj/f+oR0MIUUC6j5chc/5D4V95o3aM1NJ9JqC/mR7r3TMrCjjlERtsv4v46+63gknMnjS9cI+zcGrZ9tY3iSgTpwBh1Abvxq+E0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aXoBATT3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Lhp/Pfvv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfmod031800;
	Wed, 10 Sep 2025 20:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TDZj7ctZsILMMs8wq9yQ/WUrQo+JNZFgrh7mrnA11/M=; b=
	aXoBATT33kWpFcaaRQ+XFgLLfSfdedgJDgkdB9aUTU8nclsbQBZu2oAIxgQ8j1FP
	nSWrmziGvDIsEXdngXPHRuVKVRWK6y+qRlqiCAjt+Cl3OsvPWrn/SaIqr2KO6ANO
	WlSz6DEq3PxtXeJ45NtrXSGwz3e7Fpf6zaG5KEAbO5vwbKESrDajuJ/dxiBEf88j
	g4s+fxD2SxTOYa65ZprLqGtWTvJ9VsgHtBk88TJHtMTzVkzvb2aZJ7Lu3sW4kWhL
	DCIlQHMRNCyx5l8Ra7xRr4UrkFfbP0mzrES0BOOclB4hWDCckTIg8yERXXavKfEe
	iv63ZKOOoCa/oNfci/yHgg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921m2w002-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AIW1Jm002913;
	Wed, 10 Sep 2025 20:23:28 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdj1ca0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jf3hKZZeCnrOWcBviGwW1SiPDwPBAh7fwUPJybNRrk38aPJ3TQuUpLIXY/WDflQdqdHrbsYazCP5EnxbWlLBrgbTnaZqOLheIAUHG2rp4ILnzE3hnwY0qrOpc8A2UFp0TW8tCgjK6SCTS3ByV1ZFnTZ9ROSRCOkzhLyrZuTwqpNfpXJ8xJltildMeOoW1vJM/7sc2KL9LGX/oIbxS8tGYfKr7ooUvGnLpo0/0Xfb685WFRAt7wO/Cxnb4E/UzUGanuItwa25+/oRnYPw1LS7jKwh+nbx1haTsK06oqAFym8n1KRso/FeeDkEpoemFyFgPF0CsEHTtHaGWv5/SsAa5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDZj7ctZsILMMs8wq9yQ/WUrQo+JNZFgrh7mrnA11/M=;
 b=MENj6d1awHzQh3RksBa/4Kf+j5uEZGEskziMXSGRmEDShDnh57a0Lh5IaFwGGvBpfjLJo4VsMqCJPx+JcByn/4w6VJedbKHV3ZtOVRENCsOVeaBTiKvVLQnQa+u4pYG7qrT53W+ZgIhSINFPH85n3pokoq9k5eg6kYb8B7yuM1KGcsEYIY2hkyZgslVw7gpePgO2nVrP6imsMGMgIUIq4D8zjGKIItyJKJI86/pApgI29vimOtL9GSAYnT42TMtyuHzbmXTwe6QAvZSH7R5kCkmtKG+y4J9VJ9AhkWfYkaLSJl4P7RGl+veqDGwpSZ89ShqzwIbfqUPYbJ1dkfeJfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDZj7ctZsILMMs8wq9yQ/WUrQo+JNZFgrh7mrnA11/M=;
 b=Lhp/PfvvAOwbfPcfm5GydKJrxA483P6bcwzUIigJWChTbK49iO8d1GfcTEKfNSsBlyqzwuaJnayZ50X2vmfOKq/wUQUBgDDjDm5nmdWLfQk4ONRZmGBKpvNMLkWmnRE3RK4TIixLOXkM3TRWcdPJHr/sxHcXIUtj1yrKAgNfCC4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:23:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:23:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Nicolas Pitre <nico@fluxnic.net>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        ntfs3@lists.linux.dev, kexec@lists.infradead.org,
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 13/16] mm: update cramfs to use mmap_prepare
Date: Wed, 10 Sep 2025 21:22:08 +0100
Message-ID: <0b1cefb4e4021e95902d08c7a43a3033d1e3a4d9.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0055.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f494f9a-45c4-4ce6-9e01-08ddf0a7d92f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FUCDREMuJs5Njdv2lkz1C5WZj9okwnq9ZRd1ph0Ub6S8BXfShvC6H7VcKhkh?=
 =?us-ascii?Q?Fu63TRx/ZI8AhHDNFj4ZDsevZqqFOvY3fHMt8bUuQpwUAfnHZj4gO/BWcmjz?=
 =?us-ascii?Q?p5I2QBZcaW/1kgDv4uVqNr3qIZTyM5KgZFYmSjThtNbVZiTJs1PkiSE8oYcq?=
 =?us-ascii?Q?tkCZNpQBPn3vg5Z1dT0ac5CqECBryUGdbVJG69mqGkhXNs6IBzCE0/qmGn4o?=
 =?us-ascii?Q?lFNoeBUgz18kXYXWlhEnFIJlxmeTBPQENwAX/5NX7dvD1EdFwZoencCPBiEY?=
 =?us-ascii?Q?3kDJ3tl2q8YvCXbdkcamrg9bryeoIRjAZWpreDEikiv0SqxslM8gfk/7KxEK?=
 =?us-ascii?Q?hjslPs9j0NR2RKc0gXmJVQYVUwKr/NX38ofn9DWQzaNVDeDOZ3Hiu/IoFJ6A?=
 =?us-ascii?Q?o6gTS++FcHpXlo7cwxEcYScRQF6NJTwoeFQJAVdWDJCCxtRwySCabX1lUcfV?=
 =?us-ascii?Q?UWs8iQnw8zvy4XnPUIebTcGw8+WlMPpLcXxPTmrhKcB+Ft8t4APdav2rC6zA?=
 =?us-ascii?Q?oIcPJmllyUhes0/atyC8FABEippA6sNGq/Hfw6hYTAnnR1QXiFVFTScBbfPP?=
 =?us-ascii?Q?WXykDK7Eep6aI5Qyjmug9rriMUVF524z5BLzGof62ubJBwACxMAmwxc2hsYf?=
 =?us-ascii?Q?e3nDI7rmgh+0fYBQWeShQIDKqQoHH1V0gvp6XjqkRQt9IC72gBd51LEeby+E?=
 =?us-ascii?Q?DQMbNJbpzXpyuB+9hbaUTLkPmiJsA8yArv/w7asSMdNDWnUnD7Rhke7fHhcr?=
 =?us-ascii?Q?Y6eLyitWJSM+qOLtIrsuqpF/TPK7Y+P0fUnYWYDpM6qGlPyQdZ4fFCEzopBa?=
 =?us-ascii?Q?eew97UKezybpfTFZ3gBZkftpaCPECuQbPSHiM6rpjaMziQ729Qb9ifNL9OPl?=
 =?us-ascii?Q?i36dYwpA9eqpo2BqQxTIYXQKtDXS+GzxrIvfE7idvO/6yRLt7V4KeXmI8hQn?=
 =?us-ascii?Q?UjbCcBh0WrY/tQ+frChOkTZlMvqfF4Vs57IUdVrSCqyClfS4lyK2jV+THH/j?=
 =?us-ascii?Q?+eTBkluMrIxFjcgfxHgUNn4KUgXH26voSkTUwOaT4m1JdU4PMPDiO8ypyEst?=
 =?us-ascii?Q?AACWcITYILlYBqYw8L0J5KJqxqgCLK92e4VMCvUqnd/qAXFLRbAic1sNysFw?=
 =?us-ascii?Q?WYxygxkObcsW6aTvGSIDVEDGf3pBiioTzRmvv3Yr+oLlDlngEpsa642sCPCy?=
 =?us-ascii?Q?OJdNY3Wk60AbSQMfgH44Am1shUEsDnj1BcxgeyWB1SeHjNLjBrGb1pcrFk8D?=
 =?us-ascii?Q?zShAh4RmJ3pNNgQnbqrS3ahk/yO1ZLtjHiaXcFL3krwLOiGnMqcExP6hOhjQ?=
 =?us-ascii?Q?wo7bJVnc4MneLmNc+VREarNtpYq6ofKgrl9ynN5xALq1PderWh6jhZr8LhLY?=
 =?us-ascii?Q?msQPYgsAokIDVDyYz+lyNCluI4UC5FyoBHMJYJe8kXjh04xeTPt3+XqlY4BC?=
 =?us-ascii?Q?kJpkPsIGTRo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d4iIPIyfb9JjcIDyosu3QC7Gvw4j9ITXckm5asPtBBi8BbdY+PhzH58F2vde?=
 =?us-ascii?Q?OrZ2jl/Snuzq+d84RwliDMd6zfSG7jQfQUOKSKYu4sxbrcSfJV8R+/pP8uCe?=
 =?us-ascii?Q?J4gVQAuzlhIqS+hGVQyryxY/X4hk8no09LLbtxYiV3i3Zj3TE6HdqqynxIRF?=
 =?us-ascii?Q?t+XsS5GnS3g25Qle5isid+3r7IMQtFqs+lHt37JiF0bD7fi0F0HbB5cCpw72?=
 =?us-ascii?Q?UunYY2vU5OlBQiXNE56wqM2z6M0TTVXD5lgK6zyidinPAE6wU5ICLCreHduZ?=
 =?us-ascii?Q?wdf6lYembHWY+9CxvwFkKFYOXatZAbFYwy+y3j/WPADG09uBOniPYz8cTNn4?=
 =?us-ascii?Q?+4qMp9h/7B0/bNjSCcqeH+X0Qi5UNom9QUCIwdkXMjEd1XpvoY/mrHkq8sbm?=
 =?us-ascii?Q?EwMrEE1zDOzmqA/SLSFxMtbuxY3ppSvW2KOl+2jx6uZnw6RSo/LmkTCkDu7l?=
 =?us-ascii?Q?8mr7dDanxhKLvt86jGbE5aKCsZLxo2BwjHwNyQGVvuw7tBtuKKu4VXFuqJH3?=
 =?us-ascii?Q?sheBB4X4hHT1QbSOrw9qk1cVrYpiknNvanJ1IbVqPCvxoZk1O8I4rRHDOwc6?=
 =?us-ascii?Q?L8G5V/C1fMvfEPBw/o+yaqjIesn57XuLlyO3cw9Wua9UzDuZ8JeA/YIYiUtg?=
 =?us-ascii?Q?kBKTxUvp+ppDvhQJXPk9PGWmpVOYF82KkCETIE0juL6k8YER09EGY3cgxcfe?=
 =?us-ascii?Q?ftE/bFZW0Lfdvg5wJNrwBit849n2ItdybwYKWQqMbwwYfCNJTygebH+GOP5P?=
 =?us-ascii?Q?6yC7fx5We/QZK7yUqgfatKcdCsXeAgSTE4yT07DPEWMzNCIYI1OIAjmnrRwk?=
 =?us-ascii?Q?dcj0Guf1DAyavGQvGTvxSDu3ZEWAlIpCAFZKgqauDclNGlzwfARZBndrOKnB?=
 =?us-ascii?Q?5+ETd0lWvyHa+0nPj0FihqPNwTiSrREoT/W7RRfzMxZ1svQD9n6j7L7Kxguy?=
 =?us-ascii?Q?xxfyFisSnka5l1lXXO4mX4wDEpqn+toB4J0qqQKncsO93mDJz06L8u5VTKKI?=
 =?us-ascii?Q?nNzeV9QS6uB3IbHM4tJGr8NqiueK0to17cYm2qBKrCtYxaWJffDKYV6/PPAp?=
 =?us-ascii?Q?JmvAi8ZtpvqOBYzoBoi9eOygcgabW3lKlbc/rRqSRJfY1ZH60uiL4sGksQgc?=
 =?us-ascii?Q?Y4nXLyKdSyoahs+wzGIo8ZNppZz8P42PEGuZ+E7qdq4JWMowMmY7xgb3ThfK?=
 =?us-ascii?Q?TVRCuYdOHXKERRDkS9eVuAnsT8Md1X2PkcZrvuPUcSAIdQCMGkny7z/wi4Sw?=
 =?us-ascii?Q?Dml5fZ/b+owtmlumtP1FcWRgnQYSp3QrbswcyEyRxhti05FuzvuxuhTOeG9s?=
 =?us-ascii?Q?k97KxEcVdPgRw8usyZJS5pzvgRutNS9zftI7MIJdNEV+Fy1K8iRraIm3CUMC?=
 =?us-ascii?Q?R8HuhhLb2NnpGL3FolsnKYIWQA2zGINQBMRGKG0BfyoFPY1ElwviE6ccA3pb?=
 =?us-ascii?Q?SRHS0OiFQVtByHtFue3vtwYCLEHxkXEYEjUv2o5hT/h62cVZi6fodlEDW2fY?=
 =?us-ascii?Q?wqETDJIgGFChdGbBbVAcuvPTyaFCVVoY5VQfFpd/71hUkFvA/Z9Iwm1rAzSg?=
 =?us-ascii?Q?ybJY0gvzD8SomiKla5sJ0JExeqsTqZHMb/GdaQ/rAZV6yUWW3uLgF+KviSLN?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RV2fp/2Q2beM2kS/c9x+L7vbw1KSBRo0UKCBswaNEU4XFLd5Ar6n//3pXw7eWlvdG9biK3oHOYV/sypKkIJqMatca2Iqu9d3CYIUvDaPfkZZ6aB9S8J/LBNj1zr3/c37Hs1hn+aZwl4mGFFE+cRn9doGB+GO+kjblJvPUnsS30iXCIkJ8vUOU/aAxJ//JsOTbQ/1XIf+huQcWesfBGsuFDSRkLOqJ4+Gdhgd3q/bTHlW6PTOy5AcyGOZDC5UjKbvlX9uorcXizE6wyjrcN0mN+rG1xsM+drbQbBCY0kUMHMfpSaTJvQLJO3RzTaUcvMNc6Tx8+ud47FuvA9r9njwdSeItiiG1jwgH9duZZK54UqeItcDajQiIAoz7rrcGyBUWYC8zZQJfZDAy6xunPe7ZjNZpAS7xWIOopXmWMnHA9TfkPYKd4dad/zS+SrrnJUoBW3EJC9FHG0Xc9Z0HpsAd28WxiqImn/ozy/4ME4Ru9dA4Z1xZ4KKw9kDl04M3bMfsJiApcQfx8wykWHW7r2oO7q/iPjprm/+FTrE6BWLYrsypH3lxuiIB370d4Wm3Te4pU5o4IIISLzWLJYMCG+TTCHP7yWFAmqlj4QS7t3eJfU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f494f9a-45c4-4ce6-9e01-08ddf0a7d92f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:23:05.1423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +PU3pU0I0I95bNgB71GixTh2oi7pKNlkYuyzEimysaBoZ3caDrF5s7pa45HjdKhKYyHflS75LdCSOOx3e5ImRo4kG32EMTjmhfcROgmFdKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100190
X-Proofpoint-GUID: 97Fpw0HOO_5yt3NTEGoOhFepokWCgKKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MSBTYWx0ZWRfX2cJjtJuz5RNW
 PguGRYaQujM7V+razkBSUNrEKLFnalar9DyuOZDO3PHc92dVEiQrjKEPorBx7Ghn/tB0sH4OKLx
 Nhw30/y6WFcmd2Frc6Fp9xaUJMpGNsqNeTwXt82uu63i+nVAR6xulfj7LoBrbpzOCM3FeHVj4Me
 RfEsd1GaHc+s1sONrk+X54XxHVoIueVaOWB6c7Jn1YoncoPcX75dN3VyjmowPLGAiXjFzZ10b2K
 +fe7t5W7+m9V6iPWKzcq+L4bVpue791Q6ZBeh3a4gintQFyZAKlIFEuzQNTVG10RLP0XnRd/crD
 BzSrJi+59tHLOb4Mm2r2pCS8vwhYfXVbB3K2vtvThk3Ag9iJj1RpqnBPosg4b6D1Urc3foqADnW
 8uyL0LwLcdHshpOG1ctenxYsF8f3jw==
X-Authority-Analysis: v=2.4 cv=Dp5W+H/+ c=1 sm=1 tr=0 ts=68c1de41 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=m4A7AkdywhOBhaBTiuYA:9 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: 97Fpw0HOO_5yt3NTEGoOhFepokWCgKKn

cramfs uses either a PFN remap or a mixedmap insertion, we are able to
determine this at the point of mmap_prepare and to select the appropriate
action to perform using the vm_area_desc.

Note that there appears to have been a bug in this code, with the physical
address being specified as the PFN (!!) to vmf_insert_mixed(). This patch
fixes this issue.

Finally, we trivially have to update the pr_debug() message indicating
what's happening to occur before the remap/mixedmap occurs.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/cramfs/inode.c | 46 ++++++++++++++++++++--------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b002e9b734f9..2a41b30753a7 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -342,16 +342,17 @@ static bool cramfs_last_page_is_shared(struct inode *inode)
 	return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;
 }
 
-static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int cramfs_physmem_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
 	unsigned int pages, max_pages, offset;
-	unsigned long address, pgoff = vma->vm_pgoff;
+	unsigned long address, pgoff = desc->pgoff;
 	char *bailout_reason;
 	int ret;
 
-	ret = generic_file_readonly_mmap(file, vma);
+	ret = generic_file_readonly_mmap_prepare(desc);
 	if (ret)
 		return ret;
 
@@ -362,14 +363,14 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 	/* Could COW work here? */
 	bailout_reason = "vma is writable";
-	if (vma->vm_flags & VM_WRITE)
+	if (desc->vm_flags & VM_WRITE)
 		goto bailout;
 
 	max_pages = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	bailout_reason = "beyond file limit";
 	if (pgoff >= max_pages)
 		goto bailout;
-	pages = min(vma_pages(vma), max_pages - pgoff);
+	pages = min(vma_desc_pages(desc), max_pages - pgoff);
 
 	offset = cramfs_get_block_range(inode, pgoff, &pages);
 	bailout_reason = "unsuitable block layout";
@@ -391,38 +392,31 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		goto bailout;
 	}
 
-	if (pages == vma_pages(vma)) {
+	pr_debug("mapping %pD[%lu] at 0x%08lx (%u/%lu pages) "
+		 "to vma 0x%08lx, page_prot 0x%llx\n", file,
+		 pgoff, address, pages, vma_desc_pages(desc), desc->start,
+		 (unsigned long long)pgprot_val(desc->page_prot));
+
+	if (pages == vma_desc_pages(desc)) {
 		/*
 		 * The entire vma is mappable. remap_pfn_range() will
 		 * make it distinguishable from a non-direct mapping
 		 * in /proc/<pid>/maps by substituting the file offset
 		 * with the actual physical address.
 		 */
-		ret = remap_pfn_range(vma, vma->vm_start, address >> PAGE_SHIFT,
-				      pages * PAGE_SIZE, vma->vm_page_prot);
+		mmap_action_remap(&desc->action, desc->start,
+				  address >> PAGE_SHIFT, pages * PAGE_SIZE,
+				  desc->page_prot);
 	} else {
 		/*
 		 * Let's create a mixed map if we can't map it all.
 		 * The normal paging machinery will take care of the
 		 * unpopulated ptes via cramfs_read_folio().
 		 */
-		int i;
-		vm_flags_set(vma, VM_MIXEDMAP);
-		for (i = 0; i < pages && !ret; i++) {
-			vm_fault_t vmf;
-			unsigned long off = i * PAGE_SIZE;
-			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
-					address + off);
-			if (vmf & VM_FAULT_ERROR)
-				ret = vm_fault_to_errno(vmf, 0);
-		}
+		mmap_action_mixedmap(&desc->action, desc->start,
+				     address >> PAGE_SHIFT, pages);
 	}
 
-	if (!ret)
-		pr_debug("mapped %pD[%lu] at 0x%08lx (%u/%lu pages) "
-			 "to vma 0x%08lx, page_prot 0x%llx\n", file,
-			 pgoff, address, pages, vma_pages(vma), vma->vm_start,
-			 (unsigned long long)pgprot_val(vma->vm_page_prot));
 	return ret;
 
 bailout:
@@ -434,9 +428,9 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 #else /* CONFIG_MMU */
 
-static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int cramfs_physmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(vma->vm_flags) ? 0 : -ENOSYS;
+	return is_nommu_shared_mapping(desc->vm_flags) ? 0 : -ENOSYS;
 }
 
 static unsigned long cramfs_physmem_get_unmapped_area(struct file *file,
@@ -474,7 +468,7 @@ static const struct file_operations cramfs_physmem_fops = {
 	.llseek			= generic_file_llseek,
 	.read_iter		= generic_file_read_iter,
 	.splice_read		= filemap_splice_read,
-	.mmap			= cramfs_physmem_mmap,
+	.mmap_prepare		= cramfs_physmem_mmap_prepare,
 #ifndef CONFIG_MMU
 	.get_unmapped_area	= cramfs_physmem_get_unmapped_area,
 	.mmap_capabilities	= cramfs_physmem_mmap_capabilities,
-- 
2.51.0


