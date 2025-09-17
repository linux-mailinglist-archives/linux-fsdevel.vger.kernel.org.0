Return-Path: <linux-fsdevel+bounces-61997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9485FB81859
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0FF51C817BF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32E3408DF;
	Wed, 17 Sep 2025 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="onnlntGG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uKu0PGsO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394733BB14;
	Wed, 17 Sep 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136351; cv=fail; b=LjYvdauaEVEgIJdiJIkjW68YFmjMX10kMftji+5V570rwhz2g8PFvgFDx8j5lILs54z+DlBWOZZ/K4BU6jJ62W07FnMMO+7qw57eJT8sLtCbVykRGW6pcj41XtGcMs/8pW6ivgsHgmUVj0KLvtus0tYyaRHicb/UGj9jx36HKIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136351; c=relaxed/simple;
	bh=C3on0dFj3S8nsQlqd/yhWnBhV4Xbvv9g5sLFiqeSXnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fS94/xvalTfVhN/9AaNxK7cTOcEIzTNPfzUnnHyIGeovjPUVfPAwryaOIo6ZTvn9XBikl19aajl8MFjPStpL76tLNCkgWqqZb480ImSXnvkaj8L/BqP3Ii8AgEsY5dz13LULJNe89Qf3vA3vD1FvF7O/kuWwgXBZLbl9WMZNbmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=onnlntGG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uKu0PGsO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIStP001868;
	Wed, 17 Sep 2025 19:11:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=MMq8Fwoq+FC5z6IadMuy9kAFBTgSiUi3FeQsL7FPZKQ=; b=
	onnlntGGIJZdQEirUOuHd8k1YUqQ+x7D/7kr7cVMCyUcmYmWcKyNyy0JW1ZRFlad
	rvKVOZSpclwIMLmLxUSqy+SnjOOuZTyIY2s1FAqUhav/QLvFybkfRXqCqwwwkcut
	jUsz2u+5MjQOxugo1c/EM7MCknX4VCfmZbfr9cnjeJQ1OvkGcf5j1YtYj9jL82Bp
	xQPJ1fUp/tSebxf5qnda+dzeBVag1oChfvdonB8XBosqUYGuC3D3frDECv+Pvl0s
	y6hlTM6aJqJZ3yG75O+fcN5YHCWNehxTIj4vDiz++Q1w9sHTTRRF6Ax62J8/Uht4
	DlZrMoCBCI3CJUmiFFVpZg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd207r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHEIef033687;
	Wed, 17 Sep 2025 19:11:47 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e5fqw-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YtuvysRyB85LxSNlUwWdS4QVoOzG69cNEmlAdC7E/SZlNza1+buegAOWipezI6QnzoDwJIC31NS9G9lq1F2+30NPJnf/sFyAHJ1KykppZbtrop3yTi1KjkyjxNPMPlWz+2Rl3+Piy+hSQmcUtEsmMDjqroibJodRQintZJxRzFSiSQCcrEXQV6NEQxxSWYRdjqyGkBoCE5Op2KOhWpzhiZxq4oo/bgkaqh8xhLfP52kIDyxADaKnhTB/yLnB/owpRjLxaqZAs4JtfHoFS5JS7C5L+wSXUc12Ev7fDBrwzfzmDtzpXYFgjh/d7Ka+g9d3r41xFXjpUjOr4+XG6I5KBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMq8Fwoq+FC5z6IadMuy9kAFBTgSiUi3FeQsL7FPZKQ=;
 b=sI2d7Z/eMB+S8D19hwUyuCJLlQxA2B++a9DLz+y6EO5aiuB0SolNtSh1TnJqN2clgXWN6OlCHExn+34RFpKONESQcRmqsra5dpKpl78bUVmMZkATsWPD+YTjiRQQUEVBAmlgocvp9vzk88P+8+NdgBAxxcABPUDA9ObhfXlRvN45cMGDzo5VwlebNLtq7vULdeTHSndKyzJRHmChmi3dF+9aHDrEHc5NzFbsPgKVmSwnxgXx4ZwPsZqCJEw8Nw7+ngSf7g0Nnpyt42toS8IllQPQ/4GV4AuIsX+2s4YazUctdKK0rARNo0QWhXksSJfKtBV/wlgf1K/OYWiWd3Y1pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMq8Fwoq+FC5z6IadMuy9kAFBTgSiUi3FeQsL7FPZKQ=;
 b=uKu0PGsOLFo9tfrmS+kQrfa78rQ6MJyYtoH3uBLcACKnDOQ0zRa8Zwf3Y+VdrwZHjiClmbh4XiLm7W6SNIiZ0TR62o1i55W9U9rllrgCPyrbswxxkvTjcmcDBvKFdv7QxX7SCnqeKcERzAc/D0TjHE3AnBqQlJo+YUhej5JRZGI=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 19:11:42 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:42 +0000
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
Subject: [PATCH v4 11/14] mm/hugetlbfs: update hugetlbfs to use mmap_prepare
Date: Wed, 17 Sep 2025 20:11:13 +0100
Message-ID: <e5532a0aff1991a1b5435dcb358b7d35abc80f3b.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 378c819e-99d8-4061-16f6-08ddf61e091d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U1xduY81BKSlTl9a25tdMOawZjwVqo0tDzaubsL4gi2ByUW5ulUW1pvX7L8R?=
 =?us-ascii?Q?aTTyjV/8WYmDbl5hxDWBRjeGx8rjisiYN3a6LF6jOq3FSeJE74y9FrYEmpBF?=
 =?us-ascii?Q?q1auAKkgoRCIkkY6hV5wYDA53tIg/tpsi83/ATNb1Okr+qK50/ldjdk+QfNQ?=
 =?us-ascii?Q?9HotpdcIGa8t6s1nxs23xC3D85xOExJ4o82M7krLJHq0/vREnhmt4IBe69zc?=
 =?us-ascii?Q?HAzcH9tKiJr0WpUj/bpyhL9xzpjUPNPUTkr3ZkkvBle/y3DJVZqImopIgPUk?=
 =?us-ascii?Q?8cvpOjYWA5+rMRUb1v274jEXEuD6RwWEYmf4WkN4vrvb7rpRBSCZTF8t9i7N?=
 =?us-ascii?Q?+9WrnvP/eB+YpXUhk4RBUHmJeC8tBJctEuq26OpJ85eznIPbOsdX3erkEyjt?=
 =?us-ascii?Q?8Ge/hcoVg1f0rvaRm37oK5/QJt7ILgUXDvfvQyc9VOqxVBGVJoHMnCCZKMsh?=
 =?us-ascii?Q?qc1Rzag1FXyuZFW+7KMO59HIwalfLrkWYNwP3scZFGapqYwzsCIW1JttbUwK?=
 =?us-ascii?Q?pPOLMyMz/Unw8GmCSD4BXXVqbngQi2vFEJEpBtCc2xjnsHDLeFM3IYf0RGhL?=
 =?us-ascii?Q?iLK/wqnLxK28Bi59WsoJgo6fDCofSonh7MxdunpHUDcE82W7p4Ed5ho9y2q8?=
 =?us-ascii?Q?B575Igzqz6Oqn5nY4RMz4XXYvjq9G+FAXuc9YPXvWjyhmHanIavj2asuKNKS?=
 =?us-ascii?Q?A1J0rU7Z32kwHz1Z4wpcuvq3vjGq5eIRHRsoiGnCr+hnLSw7cgp+6+kfhaw9?=
 =?us-ascii?Q?CP+0g24quuq0EMH0eF3A8AXUZ2HKf4qAAWtHrlaixO4XSNkShjf51+QAa876?=
 =?us-ascii?Q?4j0HE34Rwj+oeirEqmSQ2wHvjIHXOx/iOtGoMool1oeDVL5JaoKOzION9UAV?=
 =?us-ascii?Q?C57Pa+Ujq2kdcSdxJoQEx4uXxb86sVMJ8JQHQRmAm2pjYBpvo07c4oEe2jho?=
 =?us-ascii?Q?g1I5g7DNC94C2p9Qvw4qGGSLoy+zTA1O9m+ENJuGhFe0PLsX72/jDMB8Dw/Z?=
 =?us-ascii?Q?hMyPGm/UfJCVpYHGCfvRUrGoyjcTKYxph/uP98uAANwJoX3/zCZnwmEbiF7m?=
 =?us-ascii?Q?v6qg3d4Zt8F+kqCTri69pTXxNKuxJP2XgUp7D8qrTjpPRfd4gUq6TcZDoH2B?=
 =?us-ascii?Q?U0HXCsDWEcWTtXEBw7aIfJamhoveS4XTtWMqQhbfWUxkeL3/3SxutstOB2hG?=
 =?us-ascii?Q?qKJVyHbLL8Ceoqt577CijGShUGhn8z9+cEZwaZhkBwUIqj5Rp7q9MhLNz3ai?=
 =?us-ascii?Q?8DIEQmKH3eiJzn9aBeC+78tM0mylnaKTeuByo/jJFrf4/DPGqUdlrB1SpufO?=
 =?us-ascii?Q?AiVWm18FIWeoOv59Qig2ihVnJe6X0WHB6nN2M7wQLO1nYy1LctKJS5f83vSc?=
 =?us-ascii?Q?22EGn0nPxohFQB6lBlut3y12T4PXjye0ybhuGIMfo7YXcQSzAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VK6SvqTL8y2U+X6AeBN6Q3DiifVRIkLqdib27g20qPPkLUipRdYvcSSJIweT?=
 =?us-ascii?Q?cXT03k6dkXfGimQiCNXN6QyIcNKlswEs8LUPTbdSe58wwGqhY/8sxaxJl/Vk?=
 =?us-ascii?Q?6uJzep7BAq3fLKCsn34Nzd0zz0jNvX4Ny/KVs698cQ7vEGOLmdR639TtODmy?=
 =?us-ascii?Q?w7fPyf8HaGcnnxNHG0hcQWcL4uPos07kBKfnehW10fx519IvfYD0/0B4IrCd?=
 =?us-ascii?Q?eTu5j6nB3qIN2PiIzuiitQybK5tZ4jcwGVom//3YpL7lqmv+cMkzEMWcBqNY?=
 =?us-ascii?Q?olz8/X9c6A/dJPT+M5JivoZh/KmUS7O3mH+NThgDuikXuEA7UdxagX4q5Z7t?=
 =?us-ascii?Q?qIL3l0L83Bl1TQEFvQDdsKGDlwTpXS1BTw/Z8grI7tF1AI026lwviWDoULNk?=
 =?us-ascii?Q?ls9wiJgFF9hbzH+wq3n5U92hR2V9AitdfptYqSh11euftlpyj0dXgO57c3p5?=
 =?us-ascii?Q?mbN3TOAvgBlCrunPRTp3qgjDtcugMvGoEs2xyR5ko6Zdv7TBZMSg7Mgruvzk?=
 =?us-ascii?Q?x0RlHTg9OTod+62XjZcphgd52hQkDPtll3bo+R9FBDNWiYASYgucS6YEDovH?=
 =?us-ascii?Q?j18PrzhnBYbj95KHk/BzIh2VvCrdLs/jRmiVqNONeso2WCmxuIX1Q6YCNSJ4?=
 =?us-ascii?Q?iWLQpADWax6n2StW/2/guFwjFzvN1VfA+Wt6mJLvUaxMYbPEZWS78JJf23BS?=
 =?us-ascii?Q?LB24fqDS4H/HUnEBJKot103NFhVoBR/4PtsNTo0K6uokiy9/cRXEdTnYtXH5?=
 =?us-ascii?Q?u4ydaDNAgVfGqXEXNp3WiM3GwkKAuxFwR3NKwfocLSqBt/nxKuxy/FVcYeMF?=
 =?us-ascii?Q?p4lf60j58DlVdRTKE9yqk6NH6OU+nK6yJ/s6JKyX99GCUNgBAn7NcEAdRKua?=
 =?us-ascii?Q?c1uHKsgra1bhNLoOQCFje2yFm8XbkkBvyRkFctnZJojMIaeFPPWywA7wIpz1?=
 =?us-ascii?Q?wH1RNlsbrdxm5FV0WIW6YuqhqnS5KX+goJVt9Q+LQHiIDAuWyYdA2LaGIX3N?=
 =?us-ascii?Q?beaDfxPnu4uCCigF4R++NkaCL1W8J1XAHdCEwzCpsapVcqRWkOwWTgbxVlSz?=
 =?us-ascii?Q?j3yeodTTBM4JSmnqmYZl+ch8j18CvNIXEXIiv11exgNDMRCZ/6oO1huF5VJL?=
 =?us-ascii?Q?8dLLlgU7iagucLFg3UUXPPmKlYR6AjRKNs9KKubwvvXE5NsbtqFOTArov1is?=
 =?us-ascii?Q?D9iA9uNnUr9qI+Lph79UfsgZ3Vi9bFDy+Wbhltx/Pqkln3rSfneojpjjni70?=
 =?us-ascii?Q?dA2dGBLFkW9g0VpjqgG2F/rnEV9ZO8PKyA+7+bjujKoyOdTu0ZfogQ1IaBE+?=
 =?us-ascii?Q?3Tx83kDvlArHnvs4frduBqROYoPJ7zRFLraSHm21bG8C6Hdsg9Qo5MhWParh?=
 =?us-ascii?Q?K6Yt4X6hjVOZChrw3eB/W9Q0Wf9PT5dEjmTt6ubJWg+H/3LAp45YCrYefP7t?=
 =?us-ascii?Q?+ZpFyMi/9R5ytKQ2LLuNJng08KW870iNXIDKqj6IRwpcinImba5Pup4pAU5h?=
 =?us-ascii?Q?W0/goOXHe6Sm2boLv/FlKn23KQmSZF2OYrqqSbKgsD3Cwp0I0SMESnKL8NHn?=
 =?us-ascii?Q?pwnji2F9YPDqGqmJd1FpO8DLLZFiktMkKDH5dCTxATWPgZZxnD9PWtbNc0FL?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o1tMfzKWjGeSyF3wdfsc6tr27w3TqG2N7B63BwNx2qtPhxyW+R2IUL8n2LAcbQOA9WIiPsNEdFKYwI3oh7f5wGjsC9SF1P+gEaXHEtEfNsQm9x3+B03hTaJ4uEge6063Mi6RVthQS3+21Jl0e7ZRqNtFU5ZsZ/guIGXh+5nwFCknppAjIBJ+Vdo8kcXb2somYE1KRMklqlXN9ppeX2hBThDw44+OtHWSblHSScP+m+KpyIPpmPPRkeJWJM1dHpWs44j/X24PBTw5pAYoe23adUeD+TyRAhURTwuCpqmptJlH4rf0/g/GiBCdbad4H/KCNq+YV5G9vwcITNi4YW8Q4a+J29DTYPrbhuDE/7l6AghZGEUIe7j+SdlMFw3Ue3D8neLgoZE/njUzIvO49yOcjYGlZs+RGYgKAEqmsLO1mVuJBH39d4XCdqH47f4t4MlRpIPZijEniYA429du0zS0A5oO+clo/5dcZmpk6di/MmXXQJu7ADQdvfpA64K2V0R+fcpzMGcjXuDC0kIiGK8Pfcsu9UgkJ64fonbQq4G0PoCt7xxjO8tt6sORcK+cKoxNhK9hrQHV0E3Sg8rHFNQc+NGyPYVInc8IL2nMUhV9E+E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 378c819e-99d8-4061-16f6-08ddf61e091d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:42.0127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FyLtT9zFBtDreKpdrL1+90h+fL0MyNWrO63+tzsHfJqQ0/Q0N+OVqvRKuzYMeA2QAqTXRJd9LzgUd3yQzkAj0A8aG8Dxw9Fm0VgQFJ4bGvQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Proofpoint-GUID: kP92pRDfDsuTnJSwusUditcVwGJTp5e1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX42fUrJ68Fb4U
 W5HlCfBpQ92bYeEBzELNT2qd1ywFew+Qa/7ZOcbK4XK0TuovjHHkwcllGY0wUCisnMDJkLEfPG+
 gXbDM632WpQ81jY9weeRqO3Q+YGcQvmDgptzfng6S4R+Xw4SuxX1OPcnIQgdeGOwYOrxHnNGVXG
 lyds0mKMmAW8xjvmLWHTd3n0Zs5kwZXbXtomAdCsLG85ys3+HY/e/3S90onG7j7BdZZVOJ6d1sr
 mN2K+0tFnSU88L7l1AN5q7F7vQjyT4JP2ZcYoLlykbV84EQz/vh5Nax6bGjLCaKUh9m6gtU2v07
 zyb8ogsFbhaP+wQSxe6OUmPX2DN6VWQAo8Zc1S8nif1MwiVMSOv/HGuo7o4e3Eyy/W3t8hqCAnA
 n8bNaQ49
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cb07f4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=i1sCd5a19pX9XIFVDjUA:9
X-Proofpoint-ORIG-GUID: kP92pRDfDsuTnJSwusUditcVwGJTp5e1

Since we can now perform actions after the VMA is established via
mmap_prepare, use desc->action_success_hook to set up the hugetlb lock
once the VMA is setup.

We also make changes throughout hugetlbfs to make this possible.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 fs/hugetlbfs/inode.c           | 36 ++++++++++------
 include/linux/hugetlb.h        |  9 +++-
 include/linux/hugetlb_inline.h | 15 ++++---
 mm/hugetlb.c                   | 77 ++++++++++++++++++++--------------
 4 files changed, 85 insertions(+), 52 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f42548ee9083..9e0625167517 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -96,8 +96,15 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 #define PGOFF_LOFFT_MAX \
 	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
 
-static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
+static int hugetlb_file_mmap_prepare_success(const struct vm_area_struct *vma)
 {
+	/* Unfortunate we have to reassign vma->vm_private_data. */
+	return hugetlb_vma_lock_alloc((struct vm_area_struct *)vma);
+}
+
+static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	loff_t len, vma_len;
 	int ret;
@@ -112,8 +119,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vm_flags_set(vma, VM_HUGETLB | VM_DONTEXPAND);
-	vma->vm_ops = &hugetlb_vm_ops;
+	desc->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
+	desc->vm_ops = &hugetlb_vm_ops;
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
@@ -122,16 +129,16 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
 	if (sizeof(unsigned long) == sizeof(loff_t)) {
-		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
+		if (desc->pgoff & PGOFF_LOFFT_MAX)
 			return -EINVAL;
 	}
 
 	/* must be huge page aligned */
-	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
+	if (desc->pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
-	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
-	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	vma_len = (loff_t)vma_desc_size(desc);
+	len = vma_len + ((loff_t)desc->pgoff << PAGE_SHIFT);
 	/* check for overflow */
 	if (len < vma_len)
 		return -EINVAL;
@@ -141,7 +148,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 
 	ret = -ENOMEM;
 
-	vm_flags = vma->vm_flags;
+	vm_flags = desc->vm_flags;
 	/*
 	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
 	 * reserving here. Note: only for SHM hugetlbfs file, the inode
@@ -151,17 +158,20 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		vm_flags |= VM_NORESERVE;
 
 	if (hugetlb_reserve_pages(inode,
-				vma->vm_pgoff >> huge_page_order(h),
-				len >> huge_page_shift(h), vma,
-				vm_flags) < 0)
+			desc->pgoff >> huge_page_order(h),
+			len >> huge_page_shift(h), desc,
+			vm_flags) < 0)
 		goto out;
 
 	ret = 0;
-	if (vma->vm_flags & VM_WRITE && inode->i_size < len)
+	if ((desc->vm_flags & VM_WRITE) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
 
+	/* Allocate the VMA lock after we set it up. */
+	if (!ret)
+		desc->action.success_hook = hugetlb_file_mmap_prepare_success;
 	return ret;
 }
 
@@ -1221,7 +1231,7 @@ static void init_once(void *foo)
 
 static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
-	.mmap			= hugetlbfs_file_mmap,
+	.mmap_prepare		= hugetlbfs_file_mmap_prepare,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 8e63e46b8e1f..2387513d6ae5 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -150,8 +150,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 long hugetlb_reserve_pages(struct inode *inode, long from, long to,
-						struct vm_area_struct *vma,
-						vm_flags_t vm_flags);
+			   struct vm_area_desc *desc, vm_flags_t vm_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
@@ -280,6 +279,7 @@ bool is_hugetlb_entry_hwpoisoned(pte_t pte);
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
+int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 
 #else /* !CONFIG_HUGETLB_PAGE */
 
@@ -466,6 +466,11 @@ static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 
 static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
 
+static inline int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 0660a03d37d9..a27aa0162918 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -2,22 +2,27 @@
 #ifndef _LINUX_HUGETLB_INLINE_H
 #define _LINUX_HUGETLB_INLINE_H
 
-#ifdef CONFIG_HUGETLB_PAGE
-
 #include <linux/mm.h>
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+#ifdef CONFIG_HUGETLB_PAGE
+
+static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 {
-	return !!(vma->vm_flags & VM_HUGETLB);
+	return !!(vm_flags & VM_HUGETLB);
 }
 
 #else
 
-static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
 {
 	return false;
 }
 
 #endif
 
+static inline bool is_vm_hugetlb_page(struct vm_area_struct *vma)
+{
+	return is_vm_hugetlb_flags(vma->vm_flags);
+}
+
 #endif
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1806685ea326..af28f7fbabb8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -119,7 +119,6 @@ struct mutex *hugetlb_fault_mutex_table __ro_after_init;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
@@ -427,17 +426,21 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	}
 }
 
-static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+/*
+ * vma specific semaphore used for pmd sharing and fault/truncation
+ * synchronization
+ */
+int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 {
 	struct hugetlb_vma_lock *vma_lock;
 
 	/* Only establish in (flags) sharable vmas */
 	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
-		return;
+		return 0;
 
 	/* Should never get here with non-NULL vm_private_data */
 	if (vma->vm_private_data)
-		return;
+		return -EINVAL;
 
 	vma_lock = kmalloc(sizeof(*vma_lock), GFP_KERNEL);
 	if (!vma_lock) {
@@ -452,13 +455,15 @@ static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 		 * allocation failure.
 		 */
 		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
-		return;
+		return -EINVAL;
 	}
 
 	kref_init(&vma_lock->refs);
 	init_rwsem(&vma_lock->rw_sema);
 	vma_lock->vma = vma;
 	vma->vm_private_data = vma_lock;
+
+	return 0;
 }
 
 /* Helper that removes a struct file_region from the resv_map cache and returns
@@ -1190,20 +1195,28 @@ static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 	}
 }
 
-static void set_vma_resv_map(struct vm_area_struct *vma, struct resv_map *map)
+static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 {
-	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
+	VM_WARN_ON_ONCE_VMA(!is_vm_hugetlb_page(vma), vma);
+	VM_WARN_ON_ONCE_VMA(vma->vm_flags & VM_MAYSHARE, vma);
 
-	set_vma_private_data(vma, (unsigned long)map);
+	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
 }
 
-static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
+static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
 {
-	VM_BUG_ON_VMA(!is_vm_hugetlb_page(vma), vma);
-	VM_BUG_ON_VMA(vma->vm_flags & VM_MAYSHARE, vma);
+	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
 
-	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
+	desc->private_data = map;
+}
+
+static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
+{
+	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+	VM_WARN_ON_ONCE(desc->vm_flags & VM_MAYSHARE);
+
+	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
 }
 
 static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
@@ -1213,6 +1226,13 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
+static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
+{
+	VM_WARN_ON_ONCE(!is_vm_hugetlb_flags(desc->vm_flags));
+
+	return ((unsigned long)desc->private_data) & flag;
+}
+
 bool __vma_private_lock(struct vm_area_struct *vma)
 {
 	return !(vma->vm_flags & VM_MAYSHARE) &&
@@ -7250,9 +7270,9 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
  */
 
 long hugetlb_reserve_pages(struct inode *inode,
-					long from, long to,
-					struct vm_area_struct *vma,
-					vm_flags_t vm_flags)
+		long from, long to,
+		struct vm_area_desc *desc,
+		vm_flags_t vm_flags)
 {
 	long chg = -1, add = -1, spool_resv, gbl_resv;
 	struct hstate *h = hstate_inode(inode);
@@ -7267,12 +7287,6 @@ long hugetlb_reserve_pages(struct inode *inode,
 		return -EINVAL;
 	}
 
-	/*
-	 * vma specific semaphore used for pmd sharing and fault/truncation
-	 * synchronization
-	 */
-	hugetlb_vma_lock_alloc(vma);
-
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -7285,9 +7299,9 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * Shared mappings base their reservation on the number of pages that
 	 * are already allocated on behalf of the file. Private mappings need
 	 * to reserve the full area even if read-only as mprotect() may be
-	 * called to make the mapping read-write. Assume !vma is a shm mapping
+	 * called to make the mapping read-write. Assume !desc is a shm mapping
 	 */
-	if (!vma || vma->vm_flags & VM_MAYSHARE) {
+	if (!desc || desc->vm_flags & VM_MAYSHARE) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -7304,8 +7318,8 @@ long hugetlb_reserve_pages(struct inode *inode,
 
 		chg = to - from;
 
-		set_vma_resv_map(vma, resv_map);
-		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
+		set_vma_desc_resv_map(desc, resv_map);
+		set_vma_desc_resv_flags(desc, HPAGE_RESV_OWNER);
 	}
 
 	if (chg < 0)
@@ -7315,7 +7329,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 				chg * pages_per_huge_page(h), &h_cg) < 0)
 		goto out_err;
 
-	if (vma && !(vma->vm_flags & VM_MAYSHARE) && h_cg) {
+	if (desc && !(desc->vm_flags & VM_MAYSHARE) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -7349,7 +7363,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!vma || vma->vm_flags & VM_MAYSHARE) {
+	if (!desc || desc->vm_flags & VM_MAYSHARE) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -7403,16 +7417,15 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	hugetlb_vma_lock_free(vma);
-	if (!vma || vma->vm_flags & VM_MAYSHARE)
+	if (!desc || desc->vm_flags & VM_MAYSHARE)
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
+	if (desc && is_vma_desc_resv_set(desc, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
-		set_vma_resv_map(vma, NULL);
+		set_vma_desc_resv_map(desc, NULL);
 	}
 	return chg < 0 ? chg : add < 0 ? add : -EINVAL;
 }
-- 
2.51.0


