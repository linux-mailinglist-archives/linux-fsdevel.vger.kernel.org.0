Return-Path: <linux-fsdevel+bounces-60504-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED0B48B84
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C0E3C7027
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994B93019C7;
	Mon,  8 Sep 2025 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T9mVqpzP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xMh4PKb7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD83019AA;
	Mon,  8 Sep 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329938; cv=fail; b=pDWeZp7QiHJI3v5Cdcq50n1bk7XSijjce+HMCYCxyefXn7q/2feebn1WduDUSeKw29P/RLKmRDTXYM48wwbOUIsTk4PLQLh6DyDtW4/leSkpbPcbWJCxnuWNzkHTgbBtbpdpktitPbITemmsGn+V1AKFV1wb5l+zTRhT/t9hwPg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329938; c=relaxed/simple;
	bh=oonLgxvY8o8RsL3opcQNzfZ2A7+BPrtkNNlwJ3FQNI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bR6LhIlD4pMKqD89pvIa6GA4aB2MrWMcdJxL8PKcAQqtjYSGJEQ0OgjaIn63RgNncqjC4ewY7Z8HgxOZwXxrho/ErEj1MGMFjXW0N7XNbBPn5N1GG6aerej/FhnRG55zAiZakbxTSokojuUi/rUQNrEHRRIItEhyfw6ov8tday0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T9mVqpzP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xMh4PKb7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588AAfi4006090;
	Mon, 8 Sep 2025 11:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vnJGGQpT06A0M5VHOEQAJKcM9q9L5KSz36BgqfA+FY8=; b=
	T9mVqpzPzMctfBk/RZ/3lZ9nYCu2gGXUgGS5V+y6tE9SM4mlns2QUzkELCNuBnej
	VSZXPr7W7b2BjQLPPh2Km/esF+2Smez8S/m3rzeFTCjikXVo207m80A9irn39nJ2
	T9gKZ/PJAsbLLasZb8XpuvDjiKeo4C6mEx/yYRrHPmexcprYcQQHVpXeXymPBQ5p
	YuVoWYKuvw18okdJ7GwqVLYG+fyAvyxY1X+sZTBHuORSBNs9N1jm5sKx3/RevhPD
	KqjWGopK0cQt/h3/yZYc1e20BpSv1QGqsxiIJdwW2FK4/fwzm0nuiYNwsMWtqRxH
	GR6xdbJ4iq3icegoGOTUEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491w5402x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58896IbB025964;
	Mon, 8 Sep 2025 11:11:35 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd81ndq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fhhf99VqkfaNkcGT2KhmRzVAt7P71GQGuEilkWqBA2Hzf2ly1uhP6ljDqI8wo57utjmQY8EuwuOjQziOQotxbESmaSlbDZFTtShRNPeJSMNx2CuB52FwthjJlT903VgQZpkqLH2yzv1+IGjQjZbRixL0Asq0q2AKyia9dfkOEuS2IhEdCveaqkn9TPzGjrm67feTC6Ehjz34+JKtMnAWIScU0lCu2sCnT2gYBjVMqzIkJo2vMLrd72SuWQ9PuOsp3Jm+JpkKxZlRlckLaFLpDrw7bVw5vNyrQbhA4/7Cq+DIySmcNWmYqvApeKbmTc1io9lVjC4j8MtF6Gl5O7Qtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnJGGQpT06A0M5VHOEQAJKcM9q9L5KSz36BgqfA+FY8=;
 b=zQRkTn79z/UHrk7oq9iA0zc4o43BA1vInmIt5g4hG/kIC0dCNSWs16WJ5Bs5Bz9v1VVQnrgO92FhCuqKjVneoc9+/QXzwgzxsyBT3W0eKrRbltmaXxY909TF9F0Kx3xTI+BxhN0hMt3Z2In2HTmmH4Z3npXp8EJE0x31ZXkmqvKmlAK3KYhs0PmdAi2MraDHhXnYAiAqNirlW6HajuKif1e69CDVSgx+dyfCDWvjtdlCydUbCX76M5mU06PijHpuE1nuBedlNxUHIAo0iXoPeDBTsrzwk7pXqFZKRi3FQzW5lqaL5rniuu0X61KglsLdToq+uYdefgRL5/JIaE7HtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vnJGGQpT06A0M5VHOEQAJKcM9q9L5KSz36BgqfA+FY8=;
 b=xMh4PKb71kpTMi/laKtoBA8b6yWahZUjSS+lFwUPJO0LfsfCncD90WxgvA6c/erH4SC1k8/qe2envW1I1m6LePimkEso9JYymwiHNHiymzRdlEbxuoTRfdm1/fVjLJ7xeB5BcS0makUR+Yl46GcBcXO9oMpk9+4+HtCuaOzK/tQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:27 +0000
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
Subject: [PATCH 07/16] doc: update porting, vfs documentation for mmap_[complete, abort]
Date: Mon,  8 Sep 2025 12:10:38 +0100
Message-ID: <1ceb56fec97f891df5070b24344bf2009aca6655.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ccf734f-a620-4ed8-2e4b-08ddeec87470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XQLsjN9wqtveO+baesXz6UFiyVPW1tjJZOc/oiFKce6wwHS1UX1e5mdNd1lj?=
 =?us-ascii?Q?XbQdtxUA1SQu+r0yN3cCmyYgoyQdV8UJtILVhOVXC8Ydqs6S7t9LPNdtlVTb?=
 =?us-ascii?Q?GxGtiF2VARvsEdbcIukZGx9+3+M3hQcb/p69cODDYtJpIYUS2L9+CDxNnBwf?=
 =?us-ascii?Q?EdwVPy31NGn8r1bJUdvBCmsaq58PBPK4YYgY8/xJG53u2yommDOldAD3bISk?=
 =?us-ascii?Q?5boQQrm90KmHJjkn5ZhsOGz2KlI4q4r7BgB7Z7qZNWoQRHSJazzj5nANCYAm?=
 =?us-ascii?Q?tAjtPA/C8g+ebpb8w34XREKiZ7KJSfYW+VMWrA+cuT3Qrq0Io2+IK05q0btf?=
 =?us-ascii?Q?iB6fe3Z+1xSa+jO0KZxobSc/fTQAZy0EUmxlNT2cXYDV6fYu8mSXyCCg1hIY?=
 =?us-ascii?Q?RUJuh92HYu8DajM683Eaw2XOzodDHuFeKk19HjbzRtkIvUj7hmz4kaF3xmY1?=
 =?us-ascii?Q?g2EaRn2ezSqqW4H7p+6eP75bbNerYZdbknqW+mZrgB6Vi8mtlLrX6bEjGWbO?=
 =?us-ascii?Q?rfPNKdmxUgHOyxDJAYO5UUXnL6jzt2LdiQz5rEDYFbyBWjGgL7JUIxPpiyMb?=
 =?us-ascii?Q?Qwt4qKzAnhN4qNNDjjDOLcuhDSKnINSi6kXqlsjTYmfmOWCKkm/5ySDEFcX0?=
 =?us-ascii?Q?uQX+IRJKwNZFrVISoo3cjlKxFwrOpGnfEQqBsm7eA9cox1JEVem/xedUpqGV?=
 =?us-ascii?Q?idEsBE81F7iptAfDKuHUM2GBE5hwEWaaBkc+wQcRb29Tkz82ezK+wh9z7IiR?=
 =?us-ascii?Q?pfd7CaiIfRaQg1Q9XnPY5wmBgV8+eU1xjkEMwWOU8XtZT+BajEioFynUYOoH?=
 =?us-ascii?Q?1U4jnnnF/ddKH0yAYqo9P5pTmBPpg5jCRknPe9mIzXGBDHdn6nhiHEzNuwvw?=
 =?us-ascii?Q?ahhT9pU35ahZftaDhnktN+1/L5zSVVuUue/109iYA9bsgSBb7DX70vq85FKn?=
 =?us-ascii?Q?jOokLK+4KjlUd2uEZQP36jP5d2Wr5/q3X/SJjpHo/xUiOpCDeJnqMt6B14dM?=
 =?us-ascii?Q?pb5lWXf9XSVaB2NBGvi++TsqrrpNW2ceIpmKEXbjwia1B0tP6CjTPs566U7b?=
 =?us-ascii?Q?rCiejP1JK67RdG90meQBwrO1lETAl19bOfs2FNLUS51Vd8c01nFPhlH1tSqr?=
 =?us-ascii?Q?5Fbga70qdHm+OdWRd0vN4gy0N011tp/r58DoH0tGONlxvpOC+Mjfl4X9A3pn?=
 =?us-ascii?Q?dtcenVyrXUCB7nznkbWADcPAueNxw68bKZkfcy8FSa/ap2Vz2pydRuWm/3MU?=
 =?us-ascii?Q?O+IElvzCrsEkIbWLgh8Ew2VPC15bZpw8n9W4hD7Jv4ld5bK7rqqEldtSPzf+?=
 =?us-ascii?Q?cdtYAGM4p5AvSFk0hMq+xXZ2FImN/YWH4eiM8vpcTQr3QnrHhnpPEUahP9Wj?=
 =?us-ascii?Q?KkHZwVE3KlfbsuSlb6CPDQ2m987afH09Hb1TBE0cZ39oUFSBwdPPWHdqJ08n?=
 =?us-ascii?Q?0LuM2ISQx/A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yATurTEPMEh68UktbrO0jPBLBcRmsjMNq1z/c7CNk6yxyJDGYAJR0xujTAe/?=
 =?us-ascii?Q?Ka56AfIVkgO9gP2mdopEJG+VuIKtqcIEMduNYyrgtdRYbmV9XSaElHh4Jcyj?=
 =?us-ascii?Q?KwDA52rkmCEYMl3qDT5SytGt82IVD4kVYN/R5n/dOZhEDqe8cYoPa4frZjDy?=
 =?us-ascii?Q?pnXtOMmqDZXSNRs56Hj4EyQFhspE37nO4Y7A/RGr9fJf9rXlhSBcthg+O1bD?=
 =?us-ascii?Q?TR8gdvZsUS1MYfqMNW3oE8cYSv9ES6fjzE9vBPB0US6OHGIjnREP3fq7Klc6?=
 =?us-ascii?Q?zb2OwtgSR2TcM79csEEeGym0BNqly43b+OgQBSkiIgxBTMC9C7N2lSHRnpqo?=
 =?us-ascii?Q?D5h512pZzBpZY69CfJ5mARy5w6ju0QOn/hPpbG2eIH8yb9TWHNpF+WZq5M7e?=
 =?us-ascii?Q?ifYXIxD5EUo/sYH3MjAxfZhERMNxmV+SfUUR4lSqFhUswZmBBBvGzn4ekG77?=
 =?us-ascii?Q?HPwv4XkYOcOW3ue0ZhxSOgC/5/qB1rlOmy5LjXV4L5BITx7QsOzBXZBffPFl?=
 =?us-ascii?Q?VHdJsICHWG4nmvEJ5K+DYHIwqgSOiSo0aJjKjEVIrmqyP6LrCwi7R9ld1jUG?=
 =?us-ascii?Q?8ffwqBCWW+FOF6WYYTQObTz+m9Z0fgikq9Qpme9ElZ5g/rxowqb0WRLE3Fy1?=
 =?us-ascii?Q?6SUPogtpf2avSLKGyNEuMfXLtRMsJJH5FN3WWufrSnP/PntbaEecY/fJ5dJB?=
 =?us-ascii?Q?F80oVldsrKW9uG9o2Wiymc8xvbOChmmxsJHpvaIQMK1QF1EiNcICXc5IH5mC?=
 =?us-ascii?Q?sY+cZHB4q89y1VzgcBF9biFyyZjjjKybE7SWB5k+8NYV4PEP9/g/3RDXCNM8?=
 =?us-ascii?Q?79r/KmrufHV6Ielb5xrD5GnT+zBxJpkbEtm4iEk5JXOMB1JXH+DQ7N46jpIz?=
 =?us-ascii?Q?2vU+eNxswkIxOFF35ibyXmB69z3B1xHKwRZMjgY0/NBYJ7tvURZxONPZ9V6E?=
 =?us-ascii?Q?qNyLf4dEtVH3z40jc2eOMs+8v1J07PzMZvHmlDcyvq4e5FfffDKMMFy931eK?=
 =?us-ascii?Q?e2gukl9CaSEgDvzElXTL9ndabMY8wWmgVQQUwca9WAYbuvOTxV0w7JuhAoqf?=
 =?us-ascii?Q?3Fm9DFtdH37tw00MitOOdYdUtdrmJdWDtYJP6hVXHV90LhcKsG4L4xLm6qCG?=
 =?us-ascii?Q?hUwQjgFOjr82yZVTYdOi/5daLXkBsSPYto8lu8vw3KNHyJKV7k8VlozKMrdx?=
 =?us-ascii?Q?1ELNIX/YxN3oBI2+jiuzoGYkj/wkBwhHVqBSgK2vbl7fWqNovBOaZCOxvnLs?=
 =?us-ascii?Q?iR2cOpAelijzasdXS14MT6W+w6Cp8RZqrQQrHaj6CTJUgxKm9mrCpelyjBVq?=
 =?us-ascii?Q?TQxBnQmqgauPqN/UFZZt0n3efo+VSEJjTp8SO7eQpIx61ssb3i5Ma/rn7Y+h?=
 =?us-ascii?Q?LChHsKFRFDpspmzqC579zZV4vU5/FljRhH2UzZ4V/dlZyPW0TrWr6m696gYT?=
 =?us-ascii?Q?8/e3XOWj9Y7V68Q5z1X0IUqMh5uinDlJc+CCTbM1yGHp5/qI0W+DtEMbf9B1?=
 =?us-ascii?Q?Wt0V/5nOlWP05Odms6oYoj5AGtg4pqQKmKM+H61xVAG4T/BIyPGY9ZUzxLt8?=
 =?us-ascii?Q?zSWjWAHrnaGb5wySnPVH5EXGYQe7S732j7T+B/X7AsAJFEnkcn6cM5J27dYs?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JvKpr1uRDCcfpS4ASWxFLTFADJ1rBS52KXAF7aA9r7wSm8RqPwd8SWIwxe8mPnIJJb68yAcZL7pBnl6zBdTl9/RHtR5UifN7APyQKLmnXr081Y6BKBvs1bIFs+zecCmNrK7Szyini1MbEjQLpMTP9oJ1lkVAvti62h6ZzJen5bWCJMLJSLUB6/7V7blz1c9C2375THJgLIghbBkmE/WHEduyFU0eabX1SVePlrc6RiuA81mDchFPGaNd3X+dpVLC4WMGipJaHd7zSf2zpiusnd0WLxQEBhOCCSBPFe55YuwdSDeT1f2q/2qhabDyp/NQXCG3oM2BL9Bfng2Qmmc9/LOO3e/gfkBNqM2IIf/lpPCyPcgfoVcLPrib12km6SWrMMHQnuBesWVCOWzndTD6KExAFO66xmXIZwuWOiY0oAgaJsJTUyUld8FNWEDyVLbIlmzDfxhaZ8dF81Of0b/GKFKi/kUS0P1SWAVmDN1/DVfrBFb7xepPuaZ5SR8P0Pz6ZhNx99H8zctvIHt95u1cEEelhRYQ9JTVdWRvJIb4AW+DE/hNnigC1NMISZaCxNZPAYHB8AihDbotibYYDrItLvgnNUxCEdSMxLjazRKK5k4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ccf734f-a620-4ed8-2e4b-08ddeec87470
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:27.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rcHEHzwEReXjOMRoGf1X1IjswNxJBifalAxWOm9ABxCNeh9Us+sXjAOLB4QzMKEc9P0NHH+wybQGmqP1a43CIGO8rDdBYEYiYWYhkOelPtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Authority-Analysis: v=2.4 cv=M5RNKzws c=1 sm=1 tr=0 ts=68beb9e9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=yN9NYRaSLP7fF4NI21cA:9 cc=ntf
 awl=host:13602
X-Proofpoint-GUID: suP55U1FubN7XOgQWlJxxZ7KV3hgSlpe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEwMyBTYWx0ZWRfXwHBlRMELhmh9
 g4PtbsWFo8Tq844N8CfJRSlOKKLWzAA0pzdl3m0miCS8iUGv/JZxbI+Nc5dWOMVKztgBo/8m/Zg
 QBbbqgooMgXnA6mMR8OKFo0piCj9EciBUAEoQULonZcvM06RLaGPL0qnEMMks7jv65fuCw7wtse
 SqhM8p3mwoe7xtzKYIUZoki6y4UrlSDOfxlK5a8YFvG2zs7VIAFjbqSjb+58AuUTEvwSWzM6zQ3
 Rs6zBY/gpzhVdojOaCwjO+NnSiXOovBdFs+Z7B0dubUFZbsGCFmYZTKEaxFsTOXVu40/reYyUFG
 NUWdKTQnfGFtvw+PnV0TyUO2f/de54d6fHKB4/iACB+Wcw1dK9bZf2d3xy8cErxqYzmYFiO2bkC
 S7ss7xGBEfcwR5NqWOd2U7tA1Hcaxw==
X-Proofpoint-ORIG-GUID: suP55U1FubN7XOgQWlJxxZ7KV3hgSlpe

We have introduced the mmap_complete() and mmap_abort() callbacks, which
work in conjunction with mmap_prepare(), so describe what they used for.

We update both the VFS documentation and the porting guide.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/filesystems/porting.rst |  9 +++++++
 Documentation/filesystems/vfs.rst     | 35 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 85f590254f07..abc1b8c95d24 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1285,3 +1285,12 @@ rather than a VMA, as the VMA at this stage is not yet valid.
 The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
+
+In nearly all cases, this is all that is required for a filesystem. However,
+should there be a need to operate on the newly inserted VMA, the mmap_complete()
+can be specified to do so.
+
+Additionally, if mmap_prepare() and mmap_complete() are specified, mmap_abort()
+may also be provided which is invoked if the mapping fails between mmap_prepare
+and mmap_complete(). It is only valid to specify mmap_abort() if both other
+hooks are provided.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..172d36a13e13 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1114,6 +1114,10 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 					unsigned int poll_flags);
 		int (*mmap_prepare)(struct vm_area_desc *);
+		int (*mmap_complete)(struct file *, struct vm_area_struct *,
+				     const void *context);
+		void (*mmap_abort)(const struct file *, const void *vm_private_data,
+				   const void *context);
 	};
 
 Again, all methods are called without any locks being held, unless
@@ -1236,6 +1240,37 @@ otherwise noted.
 	file-backed memory mapping, most notably establishing relevant
 	private state and VMA callbacks.
 
+``mmap_complete``
+	If mmap_prepare is provided, will be invoked after the mapping is fully
+	established, with the mmap and VMA write locks held.
+
+	It is useful for prepopulating VMAs before they may be accessed by
+	users.
+
+	The hook MUST NOT release either the VMA or mmap write locks. This is
+	asserted by the mmap logic.
+
+	If an error is returned by the hook, the VMA is unmapped and the
+	mmap() operation fails with that error.
+
+	It is not valid to specify this hook if mmap_prepare is not also
+	specified, doing so will result in an error upon mapping.
+
+``mmap_abort``
+	If mmap_prepare() and mmap_complete() are provided, then mmap_abort
+	may also be provided, which will be invoked if the mapping operation
+	fails between the two calls.
+
+	This is important, because mmap_prepare may succeed, but some other part
+	of the mapping operation may fail before mmap_complete can be called.
+
+	This allows a caller to acquire locks in mmap_prepare with certainty
+	that the locks will be released by either mmap_abort or mmap_complete no
+	matter what happens.
+
+	It is not valid to specify this unless mmap_prepare and mmap_complete
+	are both specified, doing so will result in an error upon mapping.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.51.0


