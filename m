Return-Path: <linux-fsdevel+bounces-61764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F687B599BF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 047DD46609D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8F36CC9F;
	Tue, 16 Sep 2025 14:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pUv2iZyz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F2wHkZNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7749C340DA6;
	Tue, 16 Sep 2025 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032084; cv=fail; b=PJ3PffGocCPunH5KY+ZSNg+jJGN0MGIakssvIjream28b5ftNbHWxZNR2VRYzu89Pb/dP8HtzYBl/b7SlewjjyVa89r5E4ifrILXEcbhIHbmtXxpQlwpxSR5RaD5rAE1mR4NU79givVpo4dE0FhOENbjhOt3r+hYjW6M/EcZ+lQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032084; c=relaxed/simple;
	bh=66HO73jWEr0F/H1QCfYp8qFInEP4oLVgwbyZAt5XDZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sa5w/H8Sq+07VewMSPFzuMeaMjulF6b39fk41mv6avAkcFd1kT4yigtZNeXHym93oQmLMP4R3OhVKBK7d1sCUglxFXB8w6Hipu7pdoqy9NZzkA4sLq0oGUhjZvs9L6lqQvap8Do8hIYRrcwjPuuxeUy0UFCB6dua2exc667aV4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pUv2iZyz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F2wHkZNo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCvNf3004341;
	Tue, 16 Sep 2025 14:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rK1XFCgAcOYEXULFZyLx7hWVjtzMuI2R0aG7InHbZok=; b=
	pUv2iZyzIE8OJz2W5qm5uoc7HkoqbU/5kj/EO4H+3M1DDYRJ97SjgQsOAwT9On3c
	eBhpaH0vzazHshmFhOsA6ekw/V202eBgaHR17E8JRqmfORE8xq9nFLtDQGWxLpsG
	+P1Vmy1U/2vOv5PdrGX2P12aM6GjmtKELV6k2wCnhb7LTaolmBDhU8D0gxZAPWhY
	487rhPoX+eL3+n4G2Vfpv2OcR3YkOg5MPoPMPpKTQDXWbpuva2r0rzY9qFtjmPbM
	ecCajCslou+EIb/3V67lNFlXTqiUixCstT6XMxo7j9d7Yj7HCpoJKOImfeHcY3zt
	ALPmbylFaxNmoHOFiK03eQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fmqky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDW8Y1033813;
	Tue, 16 Sep 2025 14:13:28 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013026.outbound.protection.outlook.com [40.107.201.26])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2cede2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XxGD41r6eh0tbRguSnSfvP6TseAIq9SQ8fCOaKC5Ck8bokzJ8ZywVPtHNZcpy7JJsYOSuzWOnSx9a8BN4SS6X4tOdWeCbFr+5lXNgWwx1Pc8u+NqGz2Kxnf3aNLjJVMTgPlQ+CmYsqT+5bmde5EwBiIeBCNjOODMojX5QR7S+Pq0CidDxve5NUsm+Vqu1L0Ujo3d1Nir6VIdHsPX6PZ7LVOJPVH/CildcOv+MGLNH+h8D+gQYzGRK6Rcg0JTieLKjzeOzIuKB+sGHjeiMF4IaiYV7nxwRz9svtbxumaEylY5R8qZC8QLofZ99jiYhrc9hhZyvGWbVJBwgavpAuDFqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rK1XFCgAcOYEXULFZyLx7hWVjtzMuI2R0aG7InHbZok=;
 b=u3I2Q3mO8sunk1j2l30AkfpsyfRniSIs8U1e5ai41xe/wlipfNvY53bEcJxws3P+2Iyc2ShnrN7yQgF0s9gr+thKF1c6zBdkN+IiW7tlIu3ds0j5SLGNDzUfsNf8Tn1J0qJnPD68Wm2n+hlFQ1wxucjX5osceSzMzTt1mNhSZSOwOcm1PqcDT7GFi1mZhX0FJiAWYionf1LRl+VZKiBCgcbsIuORIw6rrp+Rs5vXxiCvTr2NUH2YcDO8xHPgQC5d7L/STWRWjtCyIQXURMJIbZFkyH3MFWgpMD28fIlz1ymdRJGnQ58EFA/XBMYBYRjXMJCq5iRJ5g7z6lls1vdUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rK1XFCgAcOYEXULFZyLx7hWVjtzMuI2R0aG7InHbZok=;
 b=F2wHkZNokZlqkPIpDvu9hOwY1oqVIILSETIXLQCSvw+L+xTzl2vibW1YRj2X1b8Baiby+hpqQlfDz44K8/EsYkZHTX+SUIawoPRnUmymkBTiJT+9ds+6Vm5IwJ9uBxcenbeY5VbK5/ftcaf598KnIGPhiEFgt9hBiVD7kjErn8U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6366.namprd10.prod.outlook.com (2603:10b6:806:256::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 14:13:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:13:06 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>,
        iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v3 13/13] iommufd: update to use mmap_prepare
Date: Tue, 16 Sep 2025 15:11:59 +0100
Message-ID: <59b8cf515e810e1f0e2a91d51fc3e82b01958644.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0246.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: bac94301-e4c3-4abf-378e-08ddf52b2836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rJpJBGZB08GC0VjL8OmgaXubU+pISb2yCn8spdanNBDM/YE2Z/JhM/OAyEjN?=
 =?us-ascii?Q?0omBfpcubpuYdcc0eQbsU+yI77fUJrlls6asxF36DsbmUb5p/bvkLOdP4cB4?=
 =?us-ascii?Q?Ds93Tzrzlj90e5yTo5tHOO6V7eCV2qsmYXZsRnxvgMObSHtOgI5XYr1SfRhb?=
 =?us-ascii?Q?rsqsGfOuYZpGqeyiW3ccpMQkiOQbBe7Bmbt9tvH+C4yobNryQotisxm2ztkD?=
 =?us-ascii?Q?c956DUDkznjltKiB4pwmPY5FQ6mlr2WnlqvmqCP6XBv5REbxGS8Mva8Muga7?=
 =?us-ascii?Q?LieVdrTI/maigagtPJb09/pOuPedj7I/vQkf+8fubT0WhYZxd7adTS64Rnyl?=
 =?us-ascii?Q?GG+3EqKqUX03/MdMnPNEhF52wkWSSobdNdFeJ3PM52V+EbhSGwtxc1ByFja+?=
 =?us-ascii?Q?OTARp1eTjS9VmjSdQ1U1lP3wy2ZDGucWtTGXqeZ/hNmDEp9qza8qSKEaiKbm?=
 =?us-ascii?Q?28B7SilD7RT9FUSDqx46tmV7EOSA6I/smTaSXissz0vPAuJFVZyW+xR6t0rN?=
 =?us-ascii?Q?3z1IbfKRmM1SMYGDprvx5VEK7bL99vWe/1QWwM9ccB8podJW5fKNNud3kmpN?=
 =?us-ascii?Q?whbQzQYnHQI4G6fCi1fUE4pb5WTwdVXT8A099PcuvsTu/HiuQj0NTvH1BzZo?=
 =?us-ascii?Q?w5pXoK/nWfPXFcBPs+TTJMVpJFCcUHTF8S8QjfqfAuXY9M3W/lA3fp5otVbU?=
 =?us-ascii?Q?rkUbM7XfPuwFDWkBkgLEKTjmPrCeD25VMU91BTRK3TaJc7Zo4qfbnlNyQdYE?=
 =?us-ascii?Q?aStoW8aOtXN5WEQsddWBHytwryo60FfqN5YRTHHeXRDogLCFD2DgEbeZt2Rk?=
 =?us-ascii?Q?Bwf63qhQBFfMripw5TrXiJRwMZTunTck5ybqZzI9k9JRXzlBs78ZJ2gSAHho?=
 =?us-ascii?Q?BTiBnF3v8C5l9aWG70czXOCl286AO/VXSuoh6v/TD3g5XPZl+Bj0MGdzpHTN?=
 =?us-ascii?Q?YFATCO2m6QugBEsu4syk/2CmeD5unwJTUZEMOxZsxXaaytpqasnBZHydhc68?=
 =?us-ascii?Q?9bZeD1NPnd1VGF7qepeGl5YbPPWjyVEkNmG8ypv0RF3ABYgY0kNNTkD6Q2bS?=
 =?us-ascii?Q?2xzmtCmYG0/RrDeAw9EAdneb6qOaiLdNRdp0nfK3DIH2Grg2xg97U4hFvB/W?=
 =?us-ascii?Q?Mn+Tx+5dGiJPXcPkLBxMrjK1Rv0wNEupaZKKt6iYXzpVjwG5d1m5X4Nl1PoQ?=
 =?us-ascii?Q?hpaM/fX14IpRvFgDO/E7mgFzZqfAUlnqpPiM4l2wbpcvDxOR4MqDWmdh7cqY?=
 =?us-ascii?Q?uQn/Kx0T8kXGsndI2o9fo4o1m004d2VzKwCxXnJe6PK/wVZ00jML//nUJ4pL?=
 =?us-ascii?Q?Q4j67O1FEnhH30F+hPWdaRStu8+bVgbcjigpbacQ/yEPFTYhAFqP86AjvEWT?=
 =?us-ascii?Q?kPTUtLAub4IhtYE2jClE/uiofs62v/sYfaoXVdIEfhhAZOrgnQM6nTZvO992?=
 =?us-ascii?Q?uzkJ+2Tex5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K4VazVE/VKFJRKw+lilCQSKS8k4zfacrhp/RJ80dpOzg8pWSDPnSvxHsxIW4?=
 =?us-ascii?Q?VPPsxdyoooY+yI1UqOmbvMSFRZ6pMk8iiUOvNOhs7rYByTaSgy1zaARUUMJV?=
 =?us-ascii?Q?2iz/dl16pgYuCFBsGaAk+8A6DREfbCy8fkc0VDgbTPVT841EDapGmeJEu0qm?=
 =?us-ascii?Q?tfm7+6QwNWDXkBtIsh5FSwtqqevMgBl9OtuE2nCqCmPYwDkFmCpT4WZyoChZ?=
 =?us-ascii?Q?PzhunVjgvj+XpJK5ZZ0KdlvpluiHsuJ8+zfjoGPH7DkJnbudmZk2xp2+v2Zo?=
 =?us-ascii?Q?0AD02MgAJMIDLK2R7bEa7ByZ4e+EpBs3aandwEbjd9IyELYaErLTYAiiuVmP?=
 =?us-ascii?Q?Pr6l/3l5to8Pty7P80oGXs5plEBvLGHiJsK5VmE6Et7sISBJAcseEA6ws2xk?=
 =?us-ascii?Q?Pk5qkhRJtHhaUqUoOe7h8iXeFMyda16c8nNAMGqeIevJ4fLsBO2bqZxrPfId?=
 =?us-ascii?Q?E7qd58sdYQkABomBGQz/fyzWcpbhxnDHANhk3Yl8jc1sW8avizYYyT6qhGfn?=
 =?us-ascii?Q?tnd3shgRD+BJafg/HrMNqjsSJQdBuzaEHlswQ0vp+qOu89MPUJruhdUH0si6?=
 =?us-ascii?Q?5lyzaZMhj5OIhgIYHN9rs2vXLHrg8QgTf+S6IQTG1D3qATyqfXT888K94ltG?=
 =?us-ascii?Q?gx5C7KIpU+hpgYUM969jSUWFGADDA/GPF6AlLTyuQ66FAOizv/44CEC5oQ0O?=
 =?us-ascii?Q?/Oom9DIZhasuCyeniCKj7S9sazHr87JZ6PB5TF/uuLdyh5Gz/TZ5tYjVWfoK?=
 =?us-ascii?Q?NsTGUDJ4gwuS4dqzuCy23iUB13amdS4iFhXzHbQp2qw2wCWJBps+6E1UIjlV?=
 =?us-ascii?Q?s0M+AP1aIHT9GXWoNhpRapH2jDvS7pWgSTbGd6hpWta55NbhZL36zDvuCk4p?=
 =?us-ascii?Q?R6Ezt4TntcUP/VMifzRBY6N9YlnE2/+T4AzqIoepVMoo9zo1hzEBvQomdcM4?=
 =?us-ascii?Q?4Z4IeWE7WuBPwpyT9kzjQExNd6C4JPhIKNQ3uyKTwOreqkGDhkcFnoyNY3tp?=
 =?us-ascii?Q?UAGYGUwC3khxJ2YsDq5dcGSzdDuN1jmUrgVHzXx5o2/rYZWFc8l8xMdYmIgl?=
 =?us-ascii?Q?FzmGZ4bievae6lNzH9SSEEg4OUBrHBZzMpprW6OsQHivy1rxXqVFwDxzsjOs?=
 =?us-ascii?Q?zc++XUz7NVU6kFXmh6kJhPgS6bJhQ69lPbIoaL9Wk5f8MQy8a3cEa7+PZ3ul?=
 =?us-ascii?Q?Xi3nLKTN4pMsBbK2IWToKk7+MQVqK1HM9cwLBgNnvw6IjZSItsoQi9ubHH94?=
 =?us-ascii?Q?lTtjSD2lobwYJ+9ZxErcVsmU/rXgAghXesS1YyWY8e2auKeZ+9u/f/6wA81g?=
 =?us-ascii?Q?9bqp3Kbr8FP7hkf8XbYY+bthoyiZVLAjmYyH0m54AacXlY8VhV0K7LGlhjsK?=
 =?us-ascii?Q?vvkCNR8ULN1YRf/aMsScl66fs7T/9a9ea+FNhcQyFYvupYTRjz1V0tqzwgYF?=
 =?us-ascii?Q?351N9f1WjhTFGTMPsK0D+sRaMBo6MkyPcipQYzJPBKQmYBo3ipKXnwML/Waj?=
 =?us-ascii?Q?QcjcjuubtnnqzOqpTW7BKHLPVjo5CxRVrUWdb3HfHAqNzExCojjPeTrodZRR?=
 =?us-ascii?Q?LGDEmcQQs+EOf27qEqCmSlD4C2wq4MxiUzFSXpRVSwDc4y3U0h18uKgYwpFO?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9KxoiGoWCqI7nl/MQSHCqtwM6bV/6vk7MwUQJWziTtEppBxi8r3cD5pNIs2nsf2EGzXZiS2UNyodohQQIbuPuVIXyQUR52KJdxtbRHMEBR7ee5bO2lJyfSwspUt/455lHISIQNMN+LC/RR0RHmJx16H2u9zOAw1n65ZM/C7wE3dx8Q8/EtlJ1H2OIe4PqZG5xmdSLDQv5qnjpx2hCMDlnqyrQ268wHAf2R8V5vfLw9Tk7HgMAnWSWOUNKPN+OSeHT/rJMTi8aUvEJcjdz2FPheFvIYh5i78/mgxR6rmf6XHVNiyV3IUBWDrUeorMB5rc9wfPKFuTz0rathQuBR0hsLrBn+i/yNJv9EQC79WZSx3EuRbZ16d2Y3Ivx3GrCO+KGAbUMvFeqZYd+VfJskTCdFSQQV5ZHqY9kto9gOYfMC1eivLPIuj6KeI23jA4BT8qZxTcr8Dv2E/d9iefBWAxuX/2tXSVH/SwDxeaCCIrM0iHyr+ji/5NzgMCYUGg4R6/+EyIQnhxXxzdiQOfNGrmhP9qATUTz4E/YAPqIC+RWL61w/cyrqVnwiU/ZUiTcr1C98+EmTZrmTxl2cIwUyQ/hxZyrA7Z42NDNEeyeS+NN1g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bac94301-e4c3-4abf-378e-08ddf52b2836
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:06.4182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRGjf7XO7R7YEaCtJ0ZdN7gDrOR98TpKMMu7o8FQ3vHTeUzbdPM47kLaF2eKrfZGDFAxZbTvyyoEDgrXBMzr3gCH7x7S8ygLlwKKYvl750k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6366
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160132
X-Proofpoint-ORIG-GUID: tviA6lFbUPCD5ZeDaqnqhcv-mHeMNT3p
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c97089 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=evtQ3R5P2d0fZvBkJCYA:9
X-Proofpoint-GUID: tviA6lFbUPCD5ZeDaqnqhcv-mHeMNT3p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfX6pLkwSjipB3f
 ahuk9mcZeXU0w9LqqbsE7KFOuZjOcWpRnuKCwTZ2n4EKQ9DM/VY7Y6CrplY+HUpBgjzvZNHINGv
 ff8mRqZ9Rxu5mkf4dgGeDSDB25u2Y6GhGM7Cg2QfGbQPIpdrbNOAl+QZUgxfG3p7u19FoU40YKF
 tBXYr1pbm99AwvpZbOQYEUY2ZknB5XypsU3j4FkKae3Cn/1jJLg+RzwuarhnWqdod4ZSYju1fny
 0aL5IwgUOT2CGQ3xHVKxyabktxuirOXSEWAlTHyjdOeuxcScdrTzq9xq53v9yxiFnurdrFoKVWi
 ccgvovE7BrolI2leAxzK+VCXVbvfbY2ViTNUYWfl2TSCYHq3z92wU6yM+LUqtE9rM8iWBJdoxIg
 IN0sr4Nd

Make use of the new mmap_prepare functionality to perform an I/O remap in
favour of the deprecated f_op->mmap hook, hooking the success path to
correctly update the users refcount.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/iommu/iommufd/main.c | 47 ++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index 15af7ced0501..b8b9c0e7520d 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -535,46 +535,51 @@ static const struct vm_operations_struct iommufd_vma_ops = {
 	.close = iommufd_fops_vma_close,
 };
 
+static int iommufd_fops_mmap_success(const struct vm_area_struct *vma)
+{
+	struct iommufd_mmap *immap = vma->vm_private_data;
+
+	/* vm_ops.open won't be called for mmap itself. */
+	refcount_inc(&immap->owner->users);
+
+	return 0;
+}
+
 /* The vm_pgoff must be pre-allocated from mt_mmap, and given to user space */
-static int iommufd_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+static int iommufd_fops_mmap_prepare(struct vm_area_desc *desc)
 {
+	struct file *filp = desc->file;
 	struct iommufd_ctx *ictx = filp->private_data;
-	size_t length = vma->vm_end - vma->vm_start;
+	const size_t length = vma_desc_size(desc);
 	struct iommufd_mmap *immap;
-	int rc;
 
 	if (!PAGE_ALIGNED(length))
 		return -EINVAL;
-	if (!(vma->vm_flags & VM_SHARED))
+	if (!(desc->vm_flags & VM_SHARED))
 		return -EINVAL;
-	if (vma->vm_flags & VM_EXEC)
+	if (desc->vm_flags & VM_EXEC)
 		return -EPERM;
 
-	/* vma->vm_pgoff carries a page-shifted start position to an immap */
-	immap = mtree_load(&ictx->mt_mmap, vma->vm_pgoff << PAGE_SHIFT);
+	/* desc->pgoff carries a page-shifted start position to an immap */
+	immap = mtree_load(&ictx->mt_mmap, desc->pgoff << PAGE_SHIFT);
 	if (!immap)
 		return -ENXIO;
 	/*
 	 * mtree_load() returns the immap for any contained mmio_addr, so only
 	 * allow the exact immap thing to be mapped
 	 */
-	if (vma->vm_pgoff != immap->vm_pgoff || length != immap->length)
+	if (desc->pgoff != immap->vm_pgoff || length != immap->length)
 		return -ENXIO;
 
-	vma->vm_pgoff = 0;
-	vma->vm_private_data = immap;
-	vma->vm_ops = &iommufd_vma_ops;
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	desc->pgoff = 0;
+	desc->private_data = immap;
+	desc->vm_ops = &iommufd_vma_ops;
+	desc->page_prot = pgprot_noncached(desc->page_prot);
 
-	rc = io_remap_pfn_range(vma, vma->vm_start,
-				immap->mmio_addr >> PAGE_SHIFT, length,
-				vma->vm_page_prot);
-	if (rc)
-		return rc;
+	mmap_action_ioremap_full(desc, immap->mmio_addr >> PAGE_SHIFT);
+	desc->action.success_hook = iommufd_fops_mmap_success;
 
-	/* vm_ops.open won't be called for mmap itself. */
-	refcount_inc(&immap->owner->users);
-	return rc;
+	return 0;
 }
 
 static const struct file_operations iommufd_fops = {
@@ -582,7 +587,7 @@ static const struct file_operations iommufd_fops = {
 	.open = iommufd_fops_open,
 	.release = iommufd_fops_release,
 	.unlocked_ioctl = iommufd_fops_ioctl,
-	.mmap = iommufd_fops_mmap,
+	.mmap_prepare = iommufd_fops_mmap_prepare,
 };
 
 /**
-- 
2.51.0


