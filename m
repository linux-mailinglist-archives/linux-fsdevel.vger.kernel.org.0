Return-Path: <linux-fsdevel+bounces-60628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F5EB4A686
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C879C7AD836
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D30E27AC54;
	Tue,  9 Sep 2025 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gR+SbYYA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cbZ+YCrx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6EC2750F6;
	Tue,  9 Sep 2025 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408692; cv=fail; b=OUx+z+olMc7j0DXSC13DQ22MEZl87YAsQdB+2szG0rqeRnZb5il1on/GcdxJwK/I03qjme3jPeTP2cvgvEMZUp54Y19QJnRl2bmZbb6MMbLomRz/3EQY0UYAr8zWax9Xlg7i2/p8zFORydf7lpAIDpVwK/GfIIhMDc7Lq76HEvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408692; c=relaxed/simple;
	bh=z8+NnwcdF6pCN7ItqA6l6osNNL2OzU605fxy98/w7no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B+ewA2Upbum41Hn+lluERpPDussII36RH22XQqCEHLBZEGZc/F8h83lNzXSwRyqMm6RBESe296aDlhhIhUdoeYIPMGKHcV1VZpvDTCnlDV2KAskkSJeRrhPZ49/g9fuPUYsivQYi/ejsPR41C+P67fudYtFUjBLSGTwP649zgnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gR+SbYYA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cbZ+YCrx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897g1PG009625;
	Tue, 9 Sep 2025 09:04:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=z8+NnwcdF6pCN7ItqA
	6l6osNNL2OzU605fxy98/w7no=; b=gR+SbYYAOp7xJL53jb8Fksr1NXlxmRCFBt
	UQWIbwfosUIg8iXUF4Qp7xPmZywRKed6Q1r+q5Bh1RZTyekkxrq74Lf+lX6RuACF
	+z9L9v8+HYP2Tb14jwSvsoxMwiAtKzC4obNl3ChrSIvtUv7bY+x57ub4oQMN6kYn
	ZsYwcDEm/SwJfP1eq33XeN1e+0pc+8ZDs4bdpKk6gGchivT5/IT5Pv7MBUdzHgz7
	0SwvUsg+slbvqYk2UKXRy4ql3SPDnx2nw5Cqw5tb4YFhcHiu4BVzVDnbz0VVDFRl
	8Tdff2NbyYMTgwNfAf4NGfOkz1SnCm5hqgNcybI2P8IXC1Shz09w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgsdf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:04:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5898UJAg032837;
	Tue, 9 Sep 2025 09:04:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2058.outbound.protection.outlook.com [40.107.100.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdaaw0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XrJfnmLNUH4xKUsUtcncRI3d+xxM2Wjd5NCqpVBEbZDQNTZHaoQrkWGb5SezxSH/kA0aFNy5tj0hIdtxHmd1z6C0gvRltCB67e2uJV6Mg+R5jEJggGH45E0rgR4wuGn4Xk1zfuT/x2YtGspadPjzQVZWh1HTKi8k2PKhxd5C0+HXM3oZjX6FKZtI8X+LL8o7VSdodml52zgs5Z6zZEuZP2d7I1K4vT7gXOwEZFgTSYwEzD8qIOuHx4YqwBKjgeMx+kZiLMy7bN6RqY7xbHi1WsAQqYampirlVdFfu56GfBVzGFEkcTxxY18JvmckCobvvgoUW5480zpHk7+bqAwtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8+NnwcdF6pCN7ItqA6l6osNNL2OzU605fxy98/w7no=;
 b=u5rd2N0O6dmJzY/p3xsdAJMN3Yj6OY4KR6q80FrsCkJsTy2pinQzwxSx/Ic0iIge9WmE6AcM1l/1mFKeX4Y2R51mlgWajOI0mFRWODoy7LVF6uWtKBoltwsi4ar/dFTwEVuTqVL1T3jkzrt6aOK+O8e7JzO0crDwT0YC9C/hFQgwbTne1EFg3hlNGSN43rggKUJdsknu4FOARPCEGMJRr5aZ2cY5ybvYvuw55r/9zsYzuOtrobZRNb4HAGrOf1cLe9im21s7d4whAfiu4K/J5qJE9D1c//4TDBW+9Veqd1kCGbyiIputkAW1TOSbBcS3O0PN55Hr+ZB6WWMi1IQt2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8+NnwcdF6pCN7ItqA6l6osNNL2OzU605fxy98/w7no=;
 b=cbZ+YCrxyrciQ9S0K5ERG95GIKcU4udhyJBXZLTtbBXdyGg+Q9sWlWn03Cx6p15p2MXZDcqPS04oALIEjA7w6dpWpH8b1ab4NXlBf4PQwBnDJV1th3l7PXCpoVPQffAwtfSayu2pLGQjyXBI90E6oUyQaSvjgkxyYmyvx1TqPh8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFD7011BF84.namprd10.prod.outlook.com (2603:10b6:518:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 09:04:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:04:04 +0000
Date: Tue, 9 Sep 2025 10:04:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
Subject: Re: [PATCH 05/16] mm/vma: rename mmap internal functions to avoid
 confusion
Message-ID: <dacfa550-df12-481e-a47f-068c440e6a8b@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <626763f17440bd69a70391b2676e5719c4c6e35f.1757329751.git.lorenzo.stoakes@oracle.com>
 <07ea2397-bec1-4420-8ee2-b1ca2d7c30e5@redhat.com>
 <a8fe7ef8-07e5-45af-b930-ce5deda226d9@lucifer.local>
 <225a3143-93de-4968-bfc5-6794c70f3f82@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <225a3143-93de-4968-bfc5-6794c70f3f82@redhat.com>
X-ClientProxiedBy: AM0PR06CA0130.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFD7011BF84:EE_
X-MS-Office365-Filtering-Correlation-Id: 24a52fa0-f087-4af3-0392-08ddef7fd32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZKJ7pwZx6vT5F3bq0DsvgNEhdbQXij17wE7pX0pEnvIxg0ZHEFIk154EZuDk?=
 =?us-ascii?Q?3bnhBnuzQhr0LAJNuDxRLDrKYC3LGFfH1xV89ggiT1k6fOXvaC8fatuTUbeS?=
 =?us-ascii?Q?HMoF8ViYeZ7sVCwNE245qJ4nH+oN6fFDFLirBvl6nYMhokvaX9fFG9MoQCnx?=
 =?us-ascii?Q?2IsDy+nwn1gxz7NDHzqYQgbs150J7tINdUnMjIKbfMKrZ2sqewRZdo+j3ZU7?=
 =?us-ascii?Q?9iHhJeZZx+gDdyNrQi78hEOULBTdCKk3J52IJvomMqfrCA7sMKNDpEL5k857?=
 =?us-ascii?Q?lbgFaODXmD9vhB6t3P8qmqaln7qLVBQbwKtaa2rrKJakRhTj8luvHg7FtK2W?=
 =?us-ascii?Q?DvTPTEuS6kHK/D08+5ZkB2PojuMOPmjQZPKSZLGdyjdzTuDE7J99ThzAC+tV?=
 =?us-ascii?Q?XTb93iQSvZIfYI6x8L2lMUJp9oA1jbsfN5eXgouZo83kfL3RullUfQOu/BNO?=
 =?us-ascii?Q?AGZu1zWu9E8OoZUVHkEJbIZw3j5BPvmr6h3Jm/dqaTHHsAJhVdibejh7p+tU?=
 =?us-ascii?Q?AIdPLqNFYobl4vnTi940oE9WOEr8EV9APG4k2nwptNemEtgbHnMRWH7aC3dK?=
 =?us-ascii?Q?JJGmk5AsvCXfZVMdyoDPkqRvnIO1hYPAjCDanU4m8AVpDNcty56YdvEmFcRT?=
 =?us-ascii?Q?rt4C//QJrSBY1yoQu887n6S7V0bdkmHU5GQvAz+oMNqM3Wiqhu7IhDT7BC28?=
 =?us-ascii?Q?BYe2IQG9i79pXNFng12cFOUzGpF+vRnBGc8jK82gQVLpVzhPrYiCcRD4YLlj?=
 =?us-ascii?Q?VHlc/YmV+oc+NkL0MkjoxkNoTWdE0dyJIwZiLHVoIOCsyovJCWaL3t/9Arg6?=
 =?us-ascii?Q?oCIMe4jlq/rlitwTWnDJhyIvg9a6AR8xIshrpJ5cd/PmQCC0qGsAFNK6CtaH?=
 =?us-ascii?Q?0xHeWqAj3Ok9u+PX9RgWYUPxG2tQCoKwjFNIBe4gt8zHiMqLxEWfRF2KDVrq?=
 =?us-ascii?Q?f6PN22VIQuLqI4iiU8SiPXmMr7n7BZVoPqgH6wsL5ywn6g4v3A9gJe8rbgyM?=
 =?us-ascii?Q?AA5zWZ/+O/8SsVx2O8Me+eEBkEtYamfMQqPForgmbs4dbjrpxqLxYA3NPxE8?=
 =?us-ascii?Q?aeTihL+TH5iMw1e/q6xSOP+7T/nMNBd+IysbEsOEcQRA1JymN3l1Qq6nQ+Cw?=
 =?us-ascii?Q?WnvY4hxI/hp4NdzbXbXVWWjOTXWsBATYtnbk7Xd2kovdQpMZuA4UDK5vauoj?=
 =?us-ascii?Q?K1/RB4YL2vROxIFfWFfgyozuw1QhMqbXyWHCPyJUjGTO5RViG+UW+y2gfRnH?=
 =?us-ascii?Q?G1XZwt7hyD3asLy7suvnKPlwsqWZFvCkBrssMJv4dN4PZsu5pkEbpsD5giic?=
 =?us-ascii?Q?wUqpRv1XP9Gv3QF/0jKOWCRxsdCUhBNj8tmJw3EJiGig8g6U+YqxqfaZDBWk?=
 =?us-ascii?Q?T+CBJycbJkQmJrKeKX9pHEpmPsj8FafVLCjuzWqABLosSiEMzf8bfcrKl7TA?=
 =?us-ascii?Q?XvP/uF5iK5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mg3HRGywhIv2azhgo2OZ04NecRp5y9YzI+ef3dMJisd2MK7FbJerHlZUZrd+?=
 =?us-ascii?Q?P0f+RyD9a8lAR1SUt1HUu9BcQ8wtUuNhEQoZsXFHyggV/PRjODR9YagMF/wC?=
 =?us-ascii?Q?dgWK1lFwpOmbSsJfLcpBoShgzhGyp5ngonrNXiiUK2h+jJ8xMi3BNKiEgfYY?=
 =?us-ascii?Q?aSd4lMf+FlBupCm1p/wx+pbfVSo89XHCj0WKHpfmDdsenfZrdF8zccyoFyPC?=
 =?us-ascii?Q?IrzaSBMSNx+J8q/ViQTVcrXmvA6DEbuCL0d+DrbSxE8HstbMts1azDrj6ADv?=
 =?us-ascii?Q?e42cED0YXtQ0k6nR9UcMDr/mGgKx0X03SYXzSz2VIDWwSsevgGiAZIWv12T0?=
 =?us-ascii?Q?h8xwnONNJSK6tkzmq9ELl1R2KrcmEnlSYWj5ef0WknYv/7qLkZ0DxVH5uyTr?=
 =?us-ascii?Q?MkGKBsKWWtu+Gc1GHD/0ptRmiy4Yu45hotbH+Nt5s+IeDB8M9I0MvkLtIKNs?=
 =?us-ascii?Q?m0S82+XHieIQZjsjUmSvNsU2vtMkCtcE1oeHqx4ZAL5mdqNTszeWg/gW7l5j?=
 =?us-ascii?Q?UCm1E3t6cct2jy1AFMFpJUEb8P9r+FHOfMzYvdnD1ojXh+CbMXN2SwW6gNOB?=
 =?us-ascii?Q?+xn+Uojau7TI3HwMFjkZJoxZcOWbFIO1REo7Og96xwgqgXLuKXXfU9mK57Ia?=
 =?us-ascii?Q?QA8t5NWtuLHJMA8a44d3RWlqEKbkK56DQ+BbZ/2n58bCWJPHx4YO8ideDsuy?=
 =?us-ascii?Q?EeAdk+cmnAbaL98SJqMcv6gloo6aTs0p2C43fgoS33G62b8V2o8Lap6WlYoW?=
 =?us-ascii?Q?q0ZrC80XH6PPMbNwRKO7KT9toBlZt7u1xLdIHKzgyWo85v+9ONtRvzvh7nux?=
 =?us-ascii?Q?hZ1/eE4pFoeiAZR0JyIJA2hHvDQeT49JOsCWPg8W+PchqW2AomMoUJ8eWmyc?=
 =?us-ascii?Q?otJccO7HEOmZuhXKS0Ms281H9P2fU8uSI9F06Wxj9jMxjSvOf4FXSrcTl1Ke?=
 =?us-ascii?Q?+OjovU7SLp9b5xQcoPF1UV2QV48OWhoNY4tPNxKp4DIMLLDTY38cBdAGXn2m?=
 =?us-ascii?Q?Hcbmao0cO5vLQ3L/O5yuC46bjGE/TtyCtWc9Cg51z9viv9EYTqYLIXuv5HEF?=
 =?us-ascii?Q?O1YXcDZiMFmiOgnRCulfBNeUO0W6gpW4wiDgOGJpHFgfOwE2uHwGynMrfMs3?=
 =?us-ascii?Q?091HFMAtwu9QUBtsWiHBxjk0s/j9zb8AQ6usYgHPYsKHOwLk0JlQH+2Bwp5w?=
 =?us-ascii?Q?Vpjs/jhlf9wnu8HuvFEpU1SnuAa6kZpanIWn0/Jo1D3wyn/Lp+9ZC809XYU1?=
 =?us-ascii?Q?AvMqcMDeRgfOTnwJnibAZx1QkAz3EQfEEC61IP9LtiBhEFpbP5z+JqILUfnt?=
 =?us-ascii?Q?X1/K1OtDduX7rYDtLp3S2wR4huFRalOIS7Qgt971JNunPY1qgV2A3tGPQHGO?=
 =?us-ascii?Q?84ETBkN1W6W+IfhVHj2uoA/o76C4sG5ygbrcARjvGNUdyds2WEvOb5dUZnvs?=
 =?us-ascii?Q?p1sdHO9G1rbge5J55wVxGHa0IRN4oUTrv/0VtPBFy1j6CeqDOH7Nvz63fpo4?=
 =?us-ascii?Q?HVIeRBl2ltWMj21CzkB6ocppO8+ANErcQgLh7GDHE195Yu8hKew+QOoG5nWA?=
 =?us-ascii?Q?mp95dEY4OHykQPEEUrHy6K2ih77W8LYcHY3oJ9lw/3IoSvOsWnsIQKGwjYu4?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	36Pf14rwLufn9PGFSbY098eIhPaogQd+mRxDdyDLLctgrJ9BkcCeDtaESsZsU41cZZ9YQsR/WpKgInhOCkf3b1fe2qya6P96MUH7b5AgGMBzWWPGoGEY+FzcnQYaHfL1sK4n/uLSFPNWLyIKqUKgVZ8VVHtQ1m3JZK50Fp7L/TB4TfMtmxsSEXbsQ7qKn2ynuNulT7c7D5/9DHGJVAEBiqwAzFm7jywnFv26V+pzklx3jNaVKdG8LZY3cxRB7e+MhjuovIBl5wUP/945NicxjweI/tVDhbt/1JLZme7HpmnmBiSOIEch3cP7L+TOgb6F6VcI2UXvnBD0IMHk9EYsRQJbu/hS6oq8ppK7U3cMUHMyv2WOPLUqr2elwSycn/UGymlohylkxLwWQDEh975l8w6mySZ/BnrOwy/gUiHeUVBN7p3GGjdka+r/KZec4geNlbtyLQ7ieScj1kTI2QWyXWvAwV509m4Ohef7zsy2qwd+t5i99S+CYCYkFqq4oOnzxu9C95MalbgnGP9Yr6edg8y/6803mUyBNVts76ejXWpCuziFT2FlJDNh2Bx1hMpmezfe0ChJ3RG3NVXvsB5IrHgNY4DGoKc6KHb+voglbWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a52fa0-f087-4af3-0392-08ddef7fd32b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:04:03.9839
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +2xjt+KBRDpp3XOF6i9I+mw+TJaGSe29G9trE1p2rNZLMk1qp/+ge8MHKOSq1WEsXN8whZGYXldudGS9nDxFxFz8mqnvjx51/3bW/D4I7Co=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD7011BF84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090089
X-Proofpoint-ORIG-GUID: P5x6t0CgYSOdBKo1CrTAwMuGKUY3I1FN
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68bfed8a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=gCCswXOMG9V64mD6cYEA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: P5x6t0CgYSOdBKo1CrTAwMuGKUY3I1FN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfXyd/Qx6ybAQbh
 7Dj8UwskNE/S5odziWFy/3fYV1fKhcbnEw1/3qK0EBcklozh+3hPp8mkL6wYDXZYeTSSxWZzve8
 5h/SgfUANUf+aAQsu0aAZdgyodP3dVdOU+gFZLkG21cVGywj1M3uGGO857hYVnhEmxEjUukXcoW
 vhFjUeukeUd7cWB31tBK8cgDTYrkxLxVaoEpmtHHGjUEvMje20+sI8+oXSZiLonI92t5nYmVkGq
 KcJtQ2CBW2WzGb+MNKc8Sn+7RRyGfyCedTNDwkSV/ggPP3TrpMd6DxrlKV0j1eaf91XQ0jSyRJ/
 yqEZxW/qspnLQNwYjhSPGpu1O/2tk0CFOAU394nuw/5c2WJQ/ebf5lIUT1hcWb5Y9SNXH2tX2V7
 +r7EMv43

On Mon, Sep 08, 2025 at 07:38:57PM +0200, David Hildenbrand wrote:
> On 08.09.25 17:31, Lorenzo Stoakes wrote:
> > On Mon, Sep 08, 2025 at 05:19:18PM +0200, David Hildenbrand wrote:
> > > On 08.09.25 13:10, Lorenzo Stoakes wrote:
> > > > Now we have the f_op->mmap_prepare() hook, having a static function called
> > > > __mmap_prepare() that has nothing to do with it is confusing, so rename the
> > > > function.
> > > >
> > > > Additionally rename __mmap_complete() to __mmap_epilogue(), as we intend to
> > > > provide a f_op->mmap_complete() callback.
> > >
> > > Isn't prologue the opposite of epilogue? :)
> >
> > :) well indeed, the prologue comes _first_ and epilogue comes _last_. So we
> > rename the bit that comes first
> >
> > >
> > > I guess I would just have done a
> > >
> > > __mmap_prepare -> __mmap_setup()
> >
> > Sure will rename to __mmap_setup().
> >
> > >
> > > and left the __mmap_complete() as is.
> >
> > But we are adding a 'mmap_complete' hook :)'
> >
> > I can think of another sensible name here then if I'm being too abstract here...
> >
> > __mmap_finish() or something.
>
> LGTM. I guess it would all be clearer if we could just describe less
> abstract what is happening. But that would likely imply a bigger rework. So
> setup/finish sounds good.

Ack will fix on respin!

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

