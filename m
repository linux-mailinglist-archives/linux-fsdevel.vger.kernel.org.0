Return-Path: <linux-fsdevel+bounces-60510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCDDB48BB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9564B1891429
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E12FE05A;
	Mon,  8 Sep 2025 11:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L6SAtgzW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Bq47YZ1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBDD3054C9;
	Mon,  8 Sep 2025 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329966; cv=fail; b=jfGx0T1Q/zkaoF9WVBVd2R8Zh37W18Y1Xgxmz30IbAxpUkx2Gqn4l4jaW6Ce8opdhK23RJwX3XDI1bQMc5LN7xZan2fEJrDdBt8lVdq3WHln4732sHJyJtUi2WupNq2qi9mQ4AI9Ma7TR1x3vkiN89jZBodq+Hx2JSeLkrXVZhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329966; c=relaxed/simple;
	bh=yXA5D/w7hxblrJN507b/ggzD1SFekBq4lqbF6mrV/7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JvopPUcycuXN8gd/nADfEkWB1Sbwy9Lr/EAlAIoYux4K9NktXYwUgUj2x9tYsnabruF3ImO3jZUTOAlhIJqzdaZobb254ezeHFte3hWm05uCiCHJ0n3ZoRd08F7uPI+nA9pedsUeDGHYMWtQPzq8JubGez2bUBjmBcp6b99Lzyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L6SAtgzW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Bq47YZ1h; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588B9FOQ008065;
	Mon, 8 Sep 2025 11:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9asM2VWDRlwAf2y5E9FZCCSijbXu0rYS4DVguFpaS3U=; b=
	L6SAtgzWpeRixpKUqALNRMuyfxnqYec915+06+/GY70ylzzA82J6dkPcVbFhYk+x
	Dx4Q25y6tuCjuRmy/V0DZjapUlQPZUvx7R3UUW+p1b/bOWOeurhOumtQdc4Qvh83
	Gv1Ag0KZUwFd5oNivpviK106D5PtYu1YAUTZvwDZ2orOH3PDEY6V2AY9zV6w4+XU
	7lzZKKkx3ZRzS0rk30soGZ0NTPQ9lmVIyvsD3JQqp/iGSyPwfRBfrEJk07CsMI8v
	nMSoF3l35fYNQjTalyq6HyWuujbld4KrMy+wcSUzxXwW9rYvoH7DQ1rJF3ru9d03
	RWbjI9AeRd4k8t+VaLEjOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491x16g04v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:12:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588AV27O002883;
	Mon, 8 Sep 2025 11:12:02 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdej0pt-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pxe0lcKK58jL0bDVPBbHE+hfL5tLDtZnH6qhG5ysyPJbIfRCFyjLjdcE1wUoE2+qtyBx5WtIZfRGnmaJODbjX2R4TGbjcsQpdFjs19jmMfBXceoxIJHAQt7MfFmEL3dsZT33NUcTB5Lz+b96QrOf8hYs/now0P8QMmroKs7A2fKjkzliR47eXbkK+ZbGsf8ZxE1Yz2KjAaC/kKJl6Vb2dN4A2kahL72QwRcEHSR3DiFfznUm9raOKHHHxwY7imf1DQY+s2VcC0xFKxKYqCnJDScE1H/4BXA8gGAt7jYJFcprwmn55/WZOq1sJbGM5vC1NOVPiSUTtSEYNAnr627/Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9asM2VWDRlwAf2y5E9FZCCSijbXu0rYS4DVguFpaS3U=;
 b=l24JlOTnu56gqY9wE4Q7ZcM00Sj2+87+z8u60cC8KHsfetXn3CM6DsDpfH7RFPXYKUN/PhDqQQbPECVyrn683CueXe6NswalAf/jSMgA0Bo1jeCbcYVvm2UxWp5n8cCJAwzvJWkAFeDT9J3Lp75faL1uYefrFYKGfSGrxoIEAk80ZJ3gF0LceXwDUc+sAft5TU+aynD4u+kxeKn3trxQjFFhdXkKUZ9f13sQIdeehYWKgXhJWVMiOp2dq0gv2WR0iCrJ97O2bTRQtsE3vUmmw4jZ+WmGqGRhPp4dt1Lz6jE0WaoSDPj7TOb5zSgzyWBqo/8DJX/0LlMt2IhInifP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9asM2VWDRlwAf2y5E9FZCCSijbXu0rYS4DVguFpaS3U=;
 b=Bq47YZ1hNm6ADcUpGdYATu8QDPO9IvqiTZW4i7KYplmGwvr6is4EfAini2mMid5mNrNSjEdyQkNm2Ot5f8Ti+eOU+eCEAH0l0mwu6He/q1pBHv3mkcd2PccQs/7lXKtSaWaXHsGcPDVK96sKReXPrgShcjVUIG5pu6xssFgEJ44=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:57 +0000
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
Subject: [PATCH 15/16] fs/proc: update vmcore to use .proc_mmap_[prepare, complete]
Date: Mon,  8 Sep 2025 12:10:46 +0100
Message-ID: <acb0b2be300da0a153ade0d8099edb5b3a77851f.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF000045C5.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::43c) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 33aecccd-afde-4120-3332-08ddeec88628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J6+7xWhKy+OZtKrDTRAhweZAWCAa4JBv8oYYIUz/zVcMfqsT97YQ9LPTV4dF?=
 =?us-ascii?Q?BWZVl7zhOE4BDsVDSVt5aXH0RAQdqC3WpEHay1iNsxO9I3gw2x/bXzhvUJDM?=
 =?us-ascii?Q?bDfrxl/2Smd7Wjm5t9hdHXckygPFf5goCvnyUgJOGaaCJ5SEQXUFaznNCAIL?=
 =?us-ascii?Q?dph/+rZQRnhLZHnMpb/Zai8Ga891OYjCN30L3b3F2Tk13SUe6EjY4gn/6tjL?=
 =?us-ascii?Q?cDmFToawtcLjX583AkdPqn5D9VN7+Rr21rmGciRGU9jhgsDxfq4aMbab5c7g?=
 =?us-ascii?Q?8a5WzJI7cw6uFpqtJEGhDI0XzajTCMB7RwYJzrfAO8XvVdzvIursfjqO9TtJ?=
 =?us-ascii?Q?ATMbKjpeFIYLj8GzNjFRFTdpQSFeF1klhan44huKxOPYH/My5Cy3y9Wq8jlK?=
 =?us-ascii?Q?0idEexeMZqUJZNC/DWNiny1p+ugEbamsN3+tpN6fenb5ivojt/aNljkFDpCA?=
 =?us-ascii?Q?wjUDYxEc7MBprrK6j7svU7UW6XRYC+411VTas60lJyAcV6gEcJns47k2i0R/?=
 =?us-ascii?Q?4QVezqN+VevQCXn5DkY+5Le543vyIwtLsNiCfzDOrySiebNEfSFsE1dSsw/x?=
 =?us-ascii?Q?W+Nd+dTW3sCIM0CDq7yqqXLMeYchzjkAh5uSWUw0fbajugxbK3cQBQzm/ic4?=
 =?us-ascii?Q?BFlrOgsgpY16JEmNzw3nkOquQRMK3snoFHrYy1ZYPlHJW+dR9EgKDEQjPFyU?=
 =?us-ascii?Q?PuWGiKvSv3sHCbJKWRDn36G6xMEzFG+bNlSdutTDLX6Wf8jEzbxM/whCmeKz?=
 =?us-ascii?Q?wQ80qM3KUq2OYwHQmJl2oo53gl2/uxXT0jKqUJGpYk8sc91UJkf17RNobB0Z?=
 =?us-ascii?Q?J6anipe3ykhAF0YUJjrUmY1ojuo0RhNxTrVQRThjWkTZck4iydF2rq6DUPG7?=
 =?us-ascii?Q?ukdFug4amxyKKDapUWALgkUQF70xYOVpIE80gwLRt1c8N76Ww3ibk5Vg+hRP?=
 =?us-ascii?Q?PSHYEJfwwdqwi28g6QhrwXRIv295w4VXxmn7dFaOf2aJOCSWKisAz8XwUC0f?=
 =?us-ascii?Q?SPF5q6dYBdof3Zca3OV13cWaLjnRIBi1vTuXJlGrVvu07huLAl8sC7e6nzHI?=
 =?us-ascii?Q?Erm46TW668uAnVUBE6ydTyjnNFhj2s6OkMHQUfVr1/uOXsPIJTscaWUFHbzb?=
 =?us-ascii?Q?ug8tlhEct9YdYYSLf8sOIukuZiJHQqLIGxrfi427KTNnsc1odCSMu42TqCGE?=
 =?us-ascii?Q?wc4P9m/HjnXgbQ54fJCRsBLamwgRaSCOKK+nt2sHBqlGbWUBAiSrsX/l7V57?=
 =?us-ascii?Q?iLktXAnzdmFbEO7JO2GWB4WS083q8Hj37p7byE2VImZaXLWS0WL9f45oacwt?=
 =?us-ascii?Q?v+5yQ0HFjULm/x+H/9X/GAUuJpTlCRLBCTLqyecgonWpOG0gmrcBfqwTcPR+?=
 =?us-ascii?Q?1ydP7E+B2b9ucwprq1+ot4+HszTGHS1B1e0wpNpsKEGDacXJsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMdbthi245slViN9ff0ep8Cw9SE+ChVjFrZiGbsfLxdnqB3d/WyT2vY9argq?=
 =?us-ascii?Q?Qg5SHjJX9/IKdiQHlZBPthpC3e0ZIHfgCMflyf+nNZ4B0xAuHioeNUtY71G8?=
 =?us-ascii?Q?67PKaimX1wif4fG/VZiRvj3lMMyrbogQuRQSAdSOMzWdZv4jltejqtQN1K0u?=
 =?us-ascii?Q?HgAH+/enhzgCVI9ionIZKSfcPqrvxH3YkhrRjQnJrOr0SerlGPk6a6ZFdR9R?=
 =?us-ascii?Q?T/9d7iT0qgqO+1i9u/Z9Cpthm3W6XEQJcXWpZ6tJhije8ll6l3BbMTH+W2vz?=
 =?us-ascii?Q?QBfJwT3Yr6mgznh1x+tJ2zFucIpt5Ww6F6JwhiEZqvXkLcOM60XmY9X18iMi?=
 =?us-ascii?Q?Np1MbG0+kOPdBr9PqqGhKeg5x20+dFiiAhbZK0Ju8vmZ67KMVPypl1JZcyh/?=
 =?us-ascii?Q?DTIwyBlM/0a4Ru86522IG9zNnInuvRAoE7wTzFptsZKlReCs1zsGsqUIH3bT?=
 =?us-ascii?Q?2XCUuWZXZFOKIZH4NPkdPOewWrShgZ9liZ8xTMYi4HHljR6fYyZagaP50Cps?=
 =?us-ascii?Q?0DbQTiOa6Ds7dTsnPSRR/6jZbD7wtSiCQRMgnlrCGl/xF4dqEPjj3psdzNdl?=
 =?us-ascii?Q?mq+qyE5CXpDaL6RryFkeiLkT0HO1yLqUmuB2No3K7CxyoX8Az1RwngY3ZF7e?=
 =?us-ascii?Q?TwMGA46XXb/MTmiEo+jArt/LndiOkMpJN0Sw6YpRd9BH+xZYVhQfYeEEgEwi?=
 =?us-ascii?Q?8x4nZDKHdg0t3Q6hkwRSGc1dUD3y0MYpuWDrUxbfrujAiDpyllj3F6rP4WNz?=
 =?us-ascii?Q?3nW95198TrHeaEFDI7v3ZyO7QD0BfnB/rRr7qsBEEIfryUMn8lOw9X/eCzes?=
 =?us-ascii?Q?SvvnCvAncvqc7nsVvdHlIxil/JUdTWvfcAIFwNvLxLXGRyhnrGE3UGPViYau?=
 =?us-ascii?Q?uqvq89uw7efGY7eNzN3VOARAHsM80srLClCwnvOG8yuaLEk8o8HZrAZcjeLN?=
 =?us-ascii?Q?l9BgrRFfZF959cidKpaq1lFNCmc6rS7iDCPIevE+wpxAijBw4h7ypyDqMWA7?=
 =?us-ascii?Q?Hwa842dV9HEPmdyeTc/gMyTo6n1ep70FfyWMKs9Fp32qRj3v+R851QD55W8e?=
 =?us-ascii?Q?QHW6nXW4rjrXtNohTAqb7LJxTKjN5zH4IZcbk/3TJ6ppB3Ck/lkzvfEaW/Rd?=
 =?us-ascii?Q?NNysQvjpq9T4V5V8YURp7pAtIWNtXNJ793LIO1DdiKfbnvjni3uk0UQWg24n?=
 =?us-ascii?Q?mY9WjT6g3zYgFjQM1dYlCPthGGg2vtj/ZwOfWWKdXveLv6MD+l7qQK4RF3js?=
 =?us-ascii?Q?KaFWwsL/GNX+DpA9U6nZ5h3oSzc12JFNxX/M/L5jJR/yZ2S8Zl4TpaaU5V46?=
 =?us-ascii?Q?W9eUN2hMZd6u2vyRaf9Zx/1wBJYtn+12kqbO3bk7u/G9iKw0nD0rn2BwKOi2?=
 =?us-ascii?Q?jU/kSz+PxLBDxePx/j002srMsVH5AemAd4wLcyxbXgqOxWMp6TaKfOaHeeAH?=
 =?us-ascii?Q?U2XZiRHO7t43DOW6dE29s3z5JPVezogafEVrSjPKbRreM7In44h1odtlseez?=
 =?us-ascii?Q?l+emOqmhuLrZAjydBA/5MrNurHrAnDmQhRFZN/j+VZa3aeY3USgkY6aWYFSv?=
 =?us-ascii?Q?IG4T8X4yn4Q/IiR/YIforQrbIag8WhRQfUS7Zo8cePoV5vkqNL3HVmdSvRiY?=
 =?us-ascii?Q?KA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ATkHRw6NCP5C2yLP2XmSyBj4RTX0SHrpbKGUolh6laP+OAdaWTZ2d6CDR9kXAp+QRsjByxt1dfR+9J8GYEmCSlUsDW/S2MLLBUFkDyMfeoK6Zb6IiVLq+gQBDHfyeuZsq04Jeo6jC9UPiFGAYYfPoz3W3/ZBtLVvjAnihugYu9nzIGljv96q7nCDmPsBLBk+DO1OIX08Yiwt9p+I80DLSSmspvd1U9tL0k1iT99IrQzwHZnvjvfG+ivtLllqDE8pGO8VhJic0c6+gQdqhw2W/FZYk9DpefKnXMf6FGoX/vqOSiKwk/KPg2tXISat3TCQOtgUXMRIRcSmkEo1YEL8/s/aJ9g+0eIsaa9QHcnwko7msWms/5Ei+dYYZ9w36pcb8Nrx8ygc6viiXd9x6sx3P0MxFpi5TmoetSuZ0vHa4T0ev6f0N7xHBDcAUowf1gMjZgmnxdyqhQ50V8CW4m2z/dCHWk3fTjgWaG/6qymH7D01sJgEOywCxVOyd49p5mR61dMTQPvwFtBfEYOhys1dMmW4PtOBk2/hYXLJqpq/5jsfvO6EkT6Xjo5F5FM2So4RMDc3QXO0S+KJQJtUGpmu7NMEALfEL6pe7Bk2HZDX9kM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aecccd-afde-4120-3332-08ddeec88628
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:56.9731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LcGDe7YYM9HAc2SIjswdnKOU65zwG1OrIFhdRXWixGfzOM20U9ZIX4+jB8aMedqOwHkZPJQxkhdTIeu9afUY/kXBqVjxvqYgHf5go0y/Dhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Authority-Analysis: v=2.4 cv=ULPdHDfy c=1 sm=1 tr=0 ts=68beba02 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jqFLf27dcFbTZjay-QcA:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDExMiBTYWx0ZWRfX0Mg91RQ2ip+d
 xQnyiFuGSlRAyLF5+XPE7YmKr6dLT/yuF09MpIQGD0PBNm4xN0Pa1L0j1mz0+R4qAPEOijyQph4
 4OxwFyzOwixKj5rGtDGZtYoltZc3lWQevUF7u/8goKLKXh9fr8MKqabGcg0uny0OdK3LSNJj4YM
 3yizMCvYMcWD+555fEE1r24LUVsf18ktmgiJATQCgqMbl6O/JOfxCp3rQaPG3OajqKNe5KN9OLI
 5Sw0iJjs2OUMsWpRBuJPRW7q+4aye3YQ3LXvff5TMCsT52YrdipOQqG7dUbF/+f7Nbju7NZcHkY
 JjBTLQDwRFq4ttOKwe+o82bEelDGWOcUvoiNh7OLvHWIfZIyZaPE2a+Nv385J9gE+NTCmvQqr9k
 E2UvaWr3RIktlRnvMEL8ZQNO14b9EQ==
X-Proofpoint-GUID: yd6O2lKPmsnWMZUvkW2ngacxHj0kFT1m
X-Proofpoint-ORIG-GUID: yd6O2lKPmsnWMZUvkW2ngacxHj0kFT1m

Now are able to use mmap_prepare, complete callbacks for procfs
implementations, update the vmcore implementation accordingly.

As part of this change, we must also update remap_vmalloc_range_partial()
to optionally not update VMA flags. Other than then remap_vmalloc_range()
wrapper, vmcore is the only user of this function so we can simply go ahead
and add a parameter.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/kernel/crash_dump.c |  6 ++--
 fs/proc/vmcore.c              | 53 +++++++++++++++++++++++++----------
 include/linux/vmalloc.h       | 10 +++----
 mm/vmalloc.c                  | 16 +++++++++--
 4 files changed, 59 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index d4839de8ce9d..44d7902f7e41 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -186,7 +186,7 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
 
 	if (pfn < oldmem_data.size >> PAGE_SHIFT) {
 		size_old = min(size, oldmem_data.size - (pfn << PAGE_SHIFT));
-		rc = remap_pfn_range(vma, from,
+		rc = remap_pfn_range_complete(vma, from,
 				     pfn + (oldmem_data.start >> PAGE_SHIFT),
 				     size_old, prot);
 		if (rc || size == size_old)
@@ -195,7 +195,7 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
 		from += size_old;
 		pfn += size_old >> PAGE_SHIFT;
 	}
-	return remap_pfn_range(vma, from, pfn, size, prot);
+	return remap_pfn_range_complete(vma, from, pfn, size, prot);
 }
 
 /*
@@ -220,7 +220,7 @@ static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
 		from += size_hsa;
 		pfn += size_hsa >> PAGE_SHIFT;
 	}
-	return remap_pfn_range(vma, from, pfn, size, prot);
+	return remap_pfn_range_complete(vma, from, pfn, size, prot);
 }
 
 /*
diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index f188bd900eb2..5e4e19c38d5e 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -254,7 +254,7 @@ int __weak remap_oldmem_pfn_range(struct vm_area_struct *vma,
 				  unsigned long size, pgprot_t prot)
 {
 	prot = pgprot_encrypted(prot);
-	return remap_pfn_range(vma, from, pfn, size, prot);
+	return remap_pfn_range_complete(vma, from, pfn, size, prot);
 }
 
 /*
@@ -308,7 +308,7 @@ static int vmcoredd_mmap_dumps(struct vm_area_struct *vma, unsigned long dst,
 			tsz = min(offset + (u64)dump->size - start, (u64)size);
 			buf = dump->buf + start - offset;
 			if (remap_vmalloc_range_partial(vma, dst, buf, 0,
-							tsz))
+							tsz, /* set_vma= */false))
 				return -EFAULT;
 
 			size -= tsz;
@@ -588,24 +588,40 @@ static int vmcore_remap_oldmem_pfn(struct vm_area_struct *vma,
 	return ret;
 }
 
-static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+static int mmap_prepare_vmcore(struct vm_area_desc *desc)
 {
-	size_t size = vma->vm_end - vma->vm_start;
-	u64 start, end, len, tsz;
-	struct vmcore_range *m;
+	size_t size = vma_desc_size(desc);
+	u64 start, end;
 
-	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
+	start = (u64)desc->pgoff << PAGE_SHIFT;
 	end = start + size;
 
 	if (size > vmcore_size || end > vmcore_size)
 		return -EINVAL;
 
-	if (vma->vm_flags & (VM_WRITE | VM_EXEC))
+	if (desc->vm_flags & (VM_WRITE | VM_EXEC))
 		return -EPERM;
 
-	vm_flags_mod(vma, VM_MIXEDMAP, VM_MAYWRITE | VM_MAYEXEC);
-	vma->vm_ops = &vmcore_mmap_ops;
+	desc->vm_flags |= VM_MIXEDMAP | VM_REMAP_FLAGS;
+	desc->vm_flags &= ~(VM_MAYWRITE | VM_MAYEXEC);
+	desc->vm_ops = &vmcore_mmap_ops;
+
+	/*
+	 * No need for remap_pfn_range_prepare() as we ensure non-CoW by
+	 * clearing VM_MAYWRITE.
+	 */
+
+	return 0;
+}
+
+static int mmap_complete_vmcore(struct file *file, struct vm_area_struct *vma,
+	const void *context)
+{
+	size_t size = vma->vm_end - vma->vm_start;
+	u64 start, len, tsz;
+	struct vmcore_range *m;
 
+	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
 	len = 0;
 
 	if (start < elfcorebuf_sz) {
@@ -613,8 +629,8 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 
 		tsz = min(elfcorebuf_sz - (size_t)start, size);
 		pfn = __pa(elfcorebuf + start) >> PAGE_SHIFT;
-		if (remap_pfn_range(vma, vma->vm_start, pfn, tsz,
-				    vma->vm_page_prot))
+		if (remap_pfn_range_complete(vma, vma->vm_start, pfn, tsz,
+					     vma->vm_page_prot))
 			return -EAGAIN;
 		size -= tsz;
 		start += tsz;
@@ -664,7 +680,7 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 		tsz = min(elfcorebuf_sz + elfnotes_sz - (size_t)start, size);
 		kaddr = elfnotes_buf + start - elfcorebuf_sz - vmcoredd_orig_sz;
 		if (remap_vmalloc_range_partial(vma, vma->vm_start + len,
-						kaddr, 0, tsz))
+				kaddr, 0, tsz, /* set_vma =*/false))
 			goto fail;
 
 		size -= tsz;
@@ -701,7 +717,13 @@ static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
 	return -EAGAIN;
 }
 #else
-static int mmap_vmcore(struct file *file, struct vm_area_struct *vma)
+static int mmap_prepare_vmcore(struct vm_area_desc *desc)
+{
+	return -ENOSYS;
+}
+
+static int mmap_complete_vmcore(struct file *file, struct vm_area_struct *vma,
+		const void *context)
 {
 	return -ENOSYS;
 }
@@ -712,7 +734,8 @@ static const struct proc_ops vmcore_proc_ops = {
 	.proc_release	= release_vmcore,
 	.proc_read_iter	= read_vmcore,
 	.proc_lseek	= default_llseek,
-	.proc_mmap	= mmap_vmcore,
+	.proc_mmap_prepare = mmap_prepare_vmcore,
+	.proc_mmap_complete = mmap_complete_vmcore,
 };
 
 static u64 get_vmcore_size(size_t elfsz, size_t elfnotesegsz,
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index eb54b7b3202f..588810e571aa 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -215,12 +215,12 @@ extern void *vmap(struct page **pages, unsigned int count,
 void *vmap_pfn(unsigned long *pfns, unsigned int count, pgprot_t prot);
 extern void vunmap(const void *addr);
 
-extern int remap_vmalloc_range_partial(struct vm_area_struct *vma,
-				       unsigned long uaddr, void *kaddr,
-				       unsigned long pgoff, unsigned long size);
+int remap_vmalloc_range_partial(struct vm_area_struct *vma,
+		unsigned long uaddr, void *kaddr, unsigned long pgoff,
+		unsigned long size, bool set_vma);
 
-extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
-							unsigned long pgoff);
+int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
+		unsigned long pgoff);
 
 int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 		     struct page **pages, unsigned int page_shift);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4249e1e01947..877b557b2482 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4528,6 +4528,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
  * @kaddr:		virtual address of vmalloc kernel memory
  * @pgoff:		offset from @kaddr to start at
  * @size:		size of map area
+ * @set_vma:		If true, update VMA flags
  *
  * Returns:	0 for success, -Exxx on failure
  *
@@ -4540,7 +4541,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
  */
 int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 				void *kaddr, unsigned long pgoff,
-				unsigned long size)
+				unsigned long size, bool set_vma)
 {
 	struct vm_struct *area;
 	unsigned long off;
@@ -4566,6 +4567,10 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 		return -EINVAL;
 	kaddr += off;
 
+	/* If we shouldn't modify VMA flags, vm_insert_page() mustn't. */
+	if (!set_vma && !(vma->vm_flags & VM_MIXEDMAP))
+		return -EINVAL;
+
 	do {
 		struct page *page = vmalloc_to_page(kaddr);
 		int ret;
@@ -4579,7 +4584,11 @@ int remap_vmalloc_range_partial(struct vm_area_struct *vma, unsigned long uaddr,
 		size -= PAGE_SIZE;
 	} while (size > 0);
 
-	vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+	if (set_vma)
+		vm_flags_set(vma, VM_DONTEXPAND | VM_DONTDUMP);
+	else
+		VM_WARN_ON_ONCE((vma->vm_flags & (VM_DONTEXPAND | VM_DONTDUMP)) !=
+				(VM_DONTEXPAND | VM_DONTDUMP));
 
 	return 0;
 }
@@ -4603,7 +4612,8 @@ int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 {
 	return remap_vmalloc_range_partial(vma, vma->vm_start,
 					   addr, pgoff,
-					   vma->vm_end - vma->vm_start);
+					   vma->vm_end - vma->vm_start,
+					   /* set_vma= */ true);
 }
 EXPORT_SYMBOL(remap_vmalloc_range);
 
-- 
2.51.0


