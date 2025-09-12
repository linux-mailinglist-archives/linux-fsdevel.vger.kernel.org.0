Return-Path: <linux-fsdevel+bounces-61028-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8FCB54963
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7F91CC3EB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121E12F6567;
	Fri, 12 Sep 2025 10:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KhVj7WMB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GGYSLKct"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCB92EC0BC;
	Fri, 12 Sep 2025 10:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672124; cv=fail; b=LgCVek0IvNakV6v7E0LakqzoyzPr2HPdAapg6Q9xFWbr0SlacOCUN5MtsZiJUITFAl2hXeoqghmMFWXhdZFhONedqQobSDJYfabukyZl4eiQr5Z97SSFTNDdeV9yYY46QJVcsz3B6nPyI+stwbrO83FkbGD5Av6DzfNKaNQNXaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672124; c=relaxed/simple;
	bh=74szNepit7JPKNNRqPqFrB2B5M5QEMTeQmyHsfLNhOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GGxtpFx+yy5Q2m9XhdFT16ShDuhuuA5+OP80eK9gcbArcoykshihS6WG7WotPxlnjxWqCZUvBPpnuWjsi3lgtJfT0w4jz7kkPgukkmU2C7VGl5rS8YELz4viBAmt91LUGbYYh9CFkz0Qg23jB/B3nqRoDEoztiPO61ob4nJi338=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KhVj7WMB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GGYSLKct; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uOLf009834;
	Fri, 12 Sep 2025 10:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=74szNepit7JPKNNRqP
	qFrB2B5M5QEMTeQmyHsfLNhOE=; b=KhVj7WMBdp9mwOmdPAWGcgMGmeQTwq990m
	TDx8MZLOW9un4nZ7it8adILaC5AyyYsxsPO8U7x4j0r+5OWflRHMhzJEDYuqbo3n
	FGyyr3W2jQv6xZVIrKDa6/dZ2C6HhGhygNTC0baUTm2mWgpXE/EEREqsZ5G0je6s
	7xijhg4WXV5DnyrL94YKeNWUU4dzidxEk7tSXLSZ0PuRBUIJnTH3NhumfDJKpcVa
	8K/wKpW1p8GeY7P/LsmyVUapElfekDbrqT/xDecX7YYMp4sbRJ7Xm2/TT8Oh4l6/
	jKLVGLC+eAWJxvI0z2Xii+aJNyElPUmKIBH6BER9+VnluJqQFjyA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1r2wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:14:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C8uNbh038862;
	Fri, 12 Sep 2025 10:14:43 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011069.outbound.protection.outlook.com [52.101.62.69])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddpjxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=th4Kq8gHaEA3bAQmHZs2b0lolEfWI5yr/4M9eiFxDVAUBYNmEz90P8jQ1CpaOIkTy9FIIXB0CWY1Z5+IC+xEzEL4CnYzCtSlfCfoG7dpii7qHoOx6nZgfaADGSlaqoWtahYbRbgp0ovLGH3noNZSJWA9W1CJgecMdD5XAxhgymELhhLXaS18/FY6/dT7sICwJAKx9KHO3n7C8T1NTR7fpnj9MApbdKrldgI/3cclGLhJBBrcD1tINnVVAIvT2GdCFYY3HxyN5D2li024IgHZgoLbkSspWPtFIDPySfI+fU3VlgCLpXNdXEYrzlcnrovVYvmHXmJzYr8nIO7w7Wv01w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=74szNepit7JPKNNRqPqFrB2B5M5QEMTeQmyHsfLNhOE=;
 b=bLgFsCCADhDy+Nq5LC3yDtnqjS7zF2HTNY+/X6tSpKOk2FbMri0XFD0bVpdsa17YHKU3KTmeYb2c80Ly/jYeEv1qHMIjZjJlvp/M/FW2RYfiJZ38lTcWeRyCYX5nVxKEiNwE8sSReENiei82J0QVsvLnUzTFcUi1m55kMFIKQuQBqUvRGrn4A3DdRD9RXzrKoBo3MCqO4YgrIW+d+UQVBUVF+IuZ7Fh6IuQ7XskOV1Nc6/jZdklTGOT5Mnc2b7UcLXOHyKg3C2x+Slp9w/kFEghpMdaNVgmrTqKJVf8S1s20AyFA4YllkWaipkom/K5KEJLrXvpFk1XCNe5E77KB8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74szNepit7JPKNNRqPqFrB2B5M5QEMTeQmyHsfLNhOE=;
 b=GGYSLKct1Eg+yCJSO8GpW8Rr8yzPk+myfkaCIe5xZ+vwwHt5NtmnoR3sqiJLgFgvZ5epOL9Xcwp7M52T342dibTaCQkhABygbBK+p3PPJvj5OwG9Zt6zcjQnDwgoVG7TD2iLDAgABnVPLV5oChPLtCqSRX2h6K3NSyZjYZS6eK8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5566.namprd10.prod.outlook.com (2603:10b6:a03:3d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:14:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:14:38 +0000
Date: Fri, 12 Sep 2025 11:14:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Reinette Chatre <reinette.chatre@intel.com>
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
        David Hildenbrand <david@redhat.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
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
Subject: Re: [PATCH v2 12/16] mm: update resctl to use mmap_prepare
Message-ID: <b7ae95b6-e26f-4fc4-9146-b7ff3b0a0cc1@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <f0bfba7672f5fb39dffeeed65c64900d65ba0124.1757534913.git.lorenzo.stoakes@oracle.com>
 <f04792c6-f651-41f7-a960-56ca37894454@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04792c6-f651-41f7-a960-56ca37894454@intel.com>
X-ClientProxiedBy: LNXP265CA0089.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::29) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5566:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fad6b7f-b515-4689-85ae-08ddf1e52e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0lLVPBn0md+x6jXe/pFRYzbHvBmjbNdFXNbik7MpxLR02u//V6iGn8ggKVNc?=
 =?us-ascii?Q?929nruupgCx2fZz6bKXepemJ3cwrzL0M8jRIsKXImzj7X098To8ffr6UZ+C0?=
 =?us-ascii?Q?/nP8umtvgH3Q4ZzlpI3Z1Qtz3X/hKOSRX31TJ+FuveBLnxIpWQqW4XfuUVCs?=
 =?us-ascii?Q?uxXQzURqmY+7g+cnsMTTJIrHk8zfNX2sSCQDBEGtdB+R/vSA2of4f5wgKDWq?=
 =?us-ascii?Q?utDbQ2UokDZVa9PltPOIiX4+/CSCtisO6CTRNL+dQ+g2ZcNpmVQj9LomXe0x?=
 =?us-ascii?Q?DIWjcfcHjhengBOSqgDbm5Jne78GWJI6bd3/vyyA94GciDFhk43gSXJxJKNr?=
 =?us-ascii?Q?3d9SfYEiGTtqgb9xLWgoB4yIhb1KrX3PTvRJ8js49I0tdfQyyxNWcego6rbz?=
 =?us-ascii?Q?GNCVKXfkrJ21RHyxqt531nXB0yfkJKasi96ephdg33IriNMRkhISAxgUow5n?=
 =?us-ascii?Q?OyZ0NtjEADBj0PLH0eIMlAMWnonNE8P8qD6sLxrs9OoqLhhRhSKlDcLVIF/7?=
 =?us-ascii?Q?kUVw/NLSvODheubL5VDlNohJQbejjoFmXnnpLOHZut4daXnAXOmGedY5a/na?=
 =?us-ascii?Q?c7jVK8YOSVKP4ne5qizi+CIG4hbb61W8HPW5qMMBG5arowqM2B2rW1MPOrQh?=
 =?us-ascii?Q?c+GgSMHePmpyKnRWQomK92/NJ1cfQVYEITBUlxOAJYke5BdGxez3wnCQZBpU?=
 =?us-ascii?Q?socrZhYNEcLil/Qtm1CguwThiLI1Mm9u6wE1YOYdrBFu3lGctAYCfDBZhV3V?=
 =?us-ascii?Q?azLdEiabUFKo5HPctTXJfhee0HxwWeUAlnq0QtnRYyQiWCsnDVYgRuVcws2h?=
 =?us-ascii?Q?q8j1WaYzmLJEnyZ8VnURH19ueMXw6/Jz+b+SERk5sfR28aM4TCSsaaLQDLiZ?=
 =?us-ascii?Q?7E1Ik6nrqpwR6Tx1BmnMCAJiH6KtABKcx4+nlFa3Aj5XSTNPklrtAEGBZZK5?=
 =?us-ascii?Q?L7bCuDPiXUok2Cr9XEDRzEj1LOq1sY3EEHjQq3uJ9auKTEutvlwYMZ88Z3ir?=
 =?us-ascii?Q?6Rx2dw25VTqo21St7FT9dKGU8A2m0mRwJQa0ATDSwPbH25jho5BGR2dJIvvW?=
 =?us-ascii?Q?aSc9ZejLzDgo4LIieVVnWi6xTm9DoSh89JsIytMVAnf/1UbBPZkdCHz24kZ2?=
 =?us-ascii?Q?MpewDTogRCVy+/en/ni1Or7nDFcd3+fg8skK/o8PXDWd3+rwsBmzzB6wxzkZ?=
 =?us-ascii?Q?4SpP27NU94sm6nMv9GRCTVVHWVwonLY8xf6iLcdcrlSiZeUtVUoGB6Ol5Bo5?=
 =?us-ascii?Q?PEaWtEyT2kz9QaYeVVDfmGaGi6GDcyE7ulc8D5ze26ZQX0r/4ID+vwBHNP9d?=
 =?us-ascii?Q?+ofEJxms40OATZykYit0JhVo5jjpE3utVki2mUfFKV+9orE/LyL4+Q2nunR2?=
 =?us-ascii?Q?to3NrRIz0QBkm3n268y+1rN55MpbBvIMw2WIocjkfyX80KhfMOn7AC5OENS4?=
 =?us-ascii?Q?uKuvxfUQpv0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tqCk7q+M+ywRrg54pEQ1/FwfN7+H7hG/C5pqaHrB9iBYdU0flbcZ9R53HCC+?=
 =?us-ascii?Q?LTvCjCJETPOwM1/O4dIpHgb8UoZ0ElBMZi5u5ssYDDJ68ITa/UpDYwvcyQ/5?=
 =?us-ascii?Q?LfZumGiQR+/wZxPjqLS/41pGtAySfufdOsbxU7j6Zy9VZ7i+3m5TMnAlQf7C?=
 =?us-ascii?Q?/MPe2Ob67l0HWKWCEHtLZzZd352AShqMyWVIKxNToQ35WT1OXyxBrHtJWkfV?=
 =?us-ascii?Q?4hYouwhqDiaK0nmjvYclp5ClEUo32yGc0iiaUQoFOZBIxEl4mLzN4iuJcWbM?=
 =?us-ascii?Q?Ltz/opU4dFu1Ji+Y69E8U1NiPvpQZBGNqhCNKF4QoAlV6YqByMDS45IthAG/?=
 =?us-ascii?Q?TevCP/LXxH80HW8GOWlmcE32c3yX575I0XzsWzlwSwF+DKBHVBcHiSMvJ6AM?=
 =?us-ascii?Q?QNJ70iClAe+W3NiWXaLYVt8kYQ3/LZshRst7SLXLxnqUkQcZymNxK7PbBQo8?=
 =?us-ascii?Q?Szp0PzhlWB2llj3xBK+hzcKHzR01G7e6fERpMfLveOtv+tH2fwwCAerrtbKu?=
 =?us-ascii?Q?dwpOLmvL8ueKrzdEOYRipauPvPLTaA/HgaXJY++k+IOFha9INg5Y9qNpw1gE?=
 =?us-ascii?Q?6RDHnOoWHnlAYoVC3qh+UWco32U5IThOwZHbD86JdHNXYoJkcLNysEbGIxGa?=
 =?us-ascii?Q?qWIX4d05BMV/UdUBmahw3QEKHGoxI9+fTUuJGj1i650LKU9xjori7r+k17Ml?=
 =?us-ascii?Q?zLYGUyxX3RqEUdgfKb0C5vwrskvYNDyKhWjJRjIbyNie46YQUgUgqzW2aHGj?=
 =?us-ascii?Q?Yn2SoVRq3d0QR29kJd+7W3m3amBKrXo3BV20crOdg2j8SrdYqkzqSk+Ba7iq?=
 =?us-ascii?Q?08MiqAR/FIS5RJgu0+xQPl+aitvp3hMJ2qg/z3TGx66Y6fKh8YRREr4+ceOy?=
 =?us-ascii?Q?Iz1Q1Sz/2jx/CBDpHIMdKvbXWItlSaAIoKxllBNwUTUTn1OBPrcQrahyCRI7?=
 =?us-ascii?Q?icfp0q8uDfGaFCjdAuRT5QVPBKCzCxFAfnh32LDrDzY3kiV2uO4h0PkF3LIx?=
 =?us-ascii?Q?VN0cDf9/wFceZSbOdbRJOfRgflmrjzuDtknzQmziBjzXgr/HMLgGAFoXCoQE?=
 =?us-ascii?Q?VJsHSdPUTW5TDoWDn02Ltjzv/n1W2YEfJCdNmpEDzBs50JzcK273deSmJ+1Z?=
 =?us-ascii?Q?1oOWSEG1TE6BHGeZop/FLF9qONMNBns6EhA3ApWYkxGSJAEqsYtNbrPYbTY0?=
 =?us-ascii?Q?o2KK5NJeUU9KicFrOjsLgXVfvxE5kBqh/l2/8hnD7UX9syQVSHkYCP+TE+zK?=
 =?us-ascii?Q?TI4txaE8IS+mH2QCWvGeQJxUofK41HtcKjn0J/Aoe7v1P5tPsePXxzaQ+mzl?=
 =?us-ascii?Q?Y9pFrgJr4+riuzKFkOu+e7l6+AgjyfUsSEyrFOEM65J8d8Z8Nhm0BIgKa7ZH?=
 =?us-ascii?Q?a9rBucHYfAx/TtmwT9jB/nfwU4P7QQWgXptdDDDRIGnL7oZCFg7X8hEc65T+?=
 =?us-ascii?Q?yJlgyxkWL8+atYzqkAX7apS3B1fi2N7cZUpv68XQqRJO2Xp6Ggbp8Go2GIhD?=
 =?us-ascii?Q?tSvBh0JMYUDg7t1n+SQjSOx9SGYkKFiTFBVbo6sYfTcZBQ6GAs9pPPhRMBhh?=
 =?us-ascii?Q?atGXTDcshCcDEpx89LoICy6PxmPe8isLJjbIhK5cBT2H64UnngBoyh4h9FcN?=
 =?us-ascii?Q?6Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WvnQ55FsKGVNJa+dy9b9Nl9IzMc/WBwSQ3p+hAw4SzEYBqFN4ayIbFnVaFvL3FaI6u5oexFLGK1P+bQ8MCuzx9P7KWU3T/1aqsdwIF9CF9O78Tyt6qF02Vnhkxlm+yaXa60yBWEb/Mmd/3Mn7Bz8n6XZv8Eppw6bgyVJD9GhdjH/pWn4aJQWbKzjz13Ada1YUQQ0Jgfr0rYreFO7e+il6gqdw+LOu0OX8wSQD+NbsjynR6r0pyN3qDbfOaJkEW0RLt9TLiC+ZRyltivzJJPgBKpdONGmujFaoZxLiOkYiUv6SiVcVVMFasKz1W7qJWMDPmKQOGQSsx0G/xiOetN18E4sLEABScA2NgaHQSBjGowVbXIDvMUIvqOUW/bJa/Piaw2KClLnjvLbD1vkWriXBINYzLFqOB7c30FccIueBExLhSi+oODqJyd/Eprd8Oi3WU2JifycZPtd706HwzHvyVc03T8f2VLLlpWWQK+tYxF1cmUHz92jmCWej4b70pKMap4KXBAR/9bhRzkSi2VuHEfqqJGVv3bnRgn9ZIA836pbiLo8MspWWZZ4FT4Js4LreEUVFoXFa0QFp3wu3C7dcskMOLq2LnivFWd/VpYDbck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fad6b7f-b515-4689-85ae-08ddf1e52e95
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:14:38.8579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGzQaQoMUBYLWPnuTu2S0te7fUY2Tfs50XEY+RHWqE7dPg34VuioM6mhE2tbX6EgRjxOJd3JnDRhpt4yuN5kSamY9OUmUKCA1M+7yeQqkMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5566
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=979 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120096
X-Proofpoint-ORIG-GUID: DnovnlT_EjWlQPSfMaqHGWk7Lsgzuqp6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX4dNmXddAwSgh
 2WzGrjNM5pv7OaryeZ1vssPbLuitHCXBvLTiLyW3Exe/3TNlK5kfBNdowjkp99W5Zd1979rUq6N
 Er92DI/PsSbB32gmmGhsI82PPSpVvKw+2uUkgTUJ4AZK+VyyU9xhpbzwqdHRE90jmzTzkbldSsW
 HjLUpHpKKRiPICMTGfMR2nV9XszyN4EOM0pTxqNDajPkO39O5Iwx/gi8WAo6HW+FVDWZsWJ2djt
 AqvnFpB53Wdwy5ZPSynt6ZvKqmh4xvqD48V0UiPIrAfyczf166E6U0fsZP59/pSPD6ucA12wrwJ
 OBQhatbWRMO0pApWKGDxfYG/TAHAEVZBACtvYyGNuEm6g2L3UtFCywihB5vsTtDWUyIfj5VvFCU
 PVC3xSO8f5CluECRIt+0+83oL3szwQ==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c3f294 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=eReYpSRbD1796KMRBbsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: DnovnlT_EjWlQPSfMaqHGWk7Lsgzuqp6

On Thu, Sep 11, 2025 at 03:07:43PM -0700, Reinette Chatre wrote:
> Hi Lorenzo,
>
> On 9/10/25 1:22 PM, Lorenzo Stoakes wrote:
> > Make use of the ability to specify a remap action within mmap_prepare to
> > update the resctl pseudo-lock to use mmap_prepare in favour of the
> > deprecated mmap hook.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
> Thank you.
>
> Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Thanks!

>
> This does not conflict with any of the resctrl changes currently
> being queued in tip tree for inclusion during next merge window.

Great :)

>
> Reinette

Cheers, Lorenzo

