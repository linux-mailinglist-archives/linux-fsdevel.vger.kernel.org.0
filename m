Return-Path: <linux-fsdevel+bounces-64691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E911BF1142
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270D618A4B7A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287423161B2;
	Mon, 20 Oct 2025 12:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DFLB0HIP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k9TOFhEB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16343191B0;
	Mon, 20 Oct 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962393; cv=fail; b=YIvW/n+UiRo1Phpexf8SoTJKo4UetuQqUA1wttPBTwzqS6JbfN+QtNOZnJ0IJwPwVjxofygxWAhkF7LH7UOp8bofBFTCJbKwiS7pQfRJdI8/TdxWc3CIhlCddEwywYGmWSB6aB+C4ZeibAV9rjlB89JKCJkgXJqc+RhKWU7LikE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962393; c=relaxed/simple;
	bh=fVE+XrEP5lYQu8iR1kZhS6hi5RaTumMAEvYaQj5XOYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ox0Jpd5KtHYu0cQrLQqA4OVM7Bt1RsGTHlBPqXZqzHXUmRF3TuuKXAhCIiOQdKVB/lX2zf0+3vvo+SFwmmAk0iUpq9zg6q3wIBpwyhnOKYQBA4pjVopKQ6TSFd8/I4lm4cQTfBvASDqoO+VGk4y8ltmnnQYus9mDF2HwNTmW/AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DFLB0HIP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k9TOFhEB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SChQ027930;
	Mon, 20 Oct 2025 12:12:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DmtmxspVYK8qiZlkLGCcNvk+7f0tzFC7tmh1hbziWeM=; b=
	DFLB0HIP+zlHCn7UvsaRfDKUv7N9HZqnDMFlCvgxkoQOP3iIF9Xlb1/M8A6H/qvB
	MSjrsxegmzPPPXoB3+LnjVnUaOWMSxiqdh9IxrwWGlDwWYE3x2gPIJYCZZoYdphR
	7OkejCF5uPGOHwKQG9oYQlkcbHhl2qmjfKAxIoCECcSanNXYn0lB8TIILm74ywMb
	dBkxiCZcC8cqmHHeI1GQISHLni/l9/QAIggMYZ/3ewrq8P0t+inbcFRPA3PHgh60
	d/zydq8ppLB3i5nQSk1L7YMp3f54SImd9U2K28MFyaYC88SA4sSMpgYGBrk1orVi
	mf+s8tjnV5FojbbHyWihoQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypt5k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KAgp85009470;
	Mon, 20 Oct 2025 12:12:12 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011044.outbound.protection.outlook.com [40.107.208.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbvbac-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ruOUgJ4KGQrTeTdb5enhfFmbgg7QjqurbEOQ1xCSicYM5L5K3soIUA7zsQwwhul9ZXkqnphhFik2hnHXjgTzp9a1HJ6u37nFkGtRY//zcbD2e13CL64QF4cD7V9X0IKLx9v0YjPdZn6NrZZvn2Zue1Tt01BlFomSCcXWAh1S7Blj0srD0L0lLavJKv2w3FdqfUwJSymabczVfv3kAPqdYr4Fj+4t/Jf9hSctBylvcTfm7X/6FuHcq1Ko3IoXyyec4JNCtOK8pYWGE0dIyRf82phz4ikCEsoVGu6sysWDP4lrfYV3VUqH5bZzAUlPqWtFVfZ9QxoqGvjDNm/9950I1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmtmxspVYK8qiZlkLGCcNvk+7f0tzFC7tmh1hbziWeM=;
 b=cBv+cUNr+4wBHSSsJSL5OKDVI0gUYdXeY6Prl5FIcGzF/J/Z+wlxzdyCNINCOt1swAxvPqsrYIJKZky99lk27UbViMLLEB0YB/8/IL6L1HNqTyr6EI6CisAw6WPf/QoRZp1Tk1ckfJjAmWg4cUEmNoaZ8afuiMhqiUlG1TGAUrBWuJbx4eDxGc30qfAjPWippoW8ODkGavdGje++TjDJgp9PmNcckkytavG+7ayhU4wDODJG3EgCpDyT+N9qfOJse+f5O/BlptSMbHW31B4IdqJeVA0ls5mdeFgz6HUrK5/WyTpXqsoLKtSxd56SG31Qr3re1TZJlIahL+9gfbFb1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmtmxspVYK8qiZlkLGCcNvk+7f0tzFC7tmh1hbziWeM=;
 b=k9TOFhEBJkLdVH4P9MAAdhmvvus0Ych037rvQP7HiwRtqIv1yop3HdJYYS02r9YtbNXwUD+mjs/7MkXj3Ot+jMOv/flIbZwc9N5p5Vjk1C7zTbMl8UuPy064xNUOmbXnSQ4ia6od//+NeBhISaoqwmmSP49UtF6PkcZ/mSl9WCQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:12:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:12:02 +0000
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
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [PATCH v5 11/15] doc: update porting, vfs documentation for mmap_prepare actions
Date: Mon, 20 Oct 2025 13:11:28 +0100
Message-ID: <472ce3da7662ed1065cc299d14bffb70b1a845e7.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0064.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::28) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d0d344c-51e5-4236-23f7-08de0fd1e01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vkDwPOpi5dUbjq8GMV+KH0IsQdk0kDeWTpIVYKsSyppFVP+j7AOJiBq6oga0?=
 =?us-ascii?Q?HmHUMpTsT9EOsHVXWsShPx1R5tkqLdHq8Bro0Dafer6bkWDX+ugua65p9x8o?=
 =?us-ascii?Q?RZ7BuvXKU7+0gl83FHQKEegJVk9p0Qj77Fro8T7tkn7gUaZlUfv+PuGdIGVP?=
 =?us-ascii?Q?B0lb1kuOKPXgKx6M5+DJP1mjQAuK6tcszWpCqRtI/e2V3J6BRqQmqnqLMHUI?=
 =?us-ascii?Q?1+y9mPwdhfb9xjOMlfF7nTJJqErlVPXdgkH9hP+S2tVBPXAEm4ubnLTI+TNs?=
 =?us-ascii?Q?OVVPhLz5ab+Y5uExncw30gZmV5FYS3VPjMED4qdJjPcfrpsEhUClZm50mNVK?=
 =?us-ascii?Q?xCJhAKMcBWdBcD41uJq9rI9MD22BXtq+DBoGREXZfxiNMcPttCXE+C3ZHlyN?=
 =?us-ascii?Q?Hc9B/9jQsj2zFpi9TFS9u48eBKJiLKmaChsatchA2YGWTSEqib7iWoj6/ZQ6?=
 =?us-ascii?Q?YlySzTVhgJGWnq8FQ39vLdQ6X2y4+fIjiKvd6XEPZGzRzI9OPp0Z6A1ckqG3?=
 =?us-ascii?Q?zgkyjudjqFWONlmXDiLRtb9CJ8pNFIc40Hh66QNpBoUGRAMay0UpD8lQanfX?=
 =?us-ascii?Q?0PwchsUKflTlfmjr+zp5HzSmSW6fZdTyLrpyvsQRkRxBG0naYCcWIW/MOhJx?=
 =?us-ascii?Q?CPHAN4Su2n6JnDBxWxA+4AYSu4jDHOg9Sib6V6YxyV3jX6N+0hhDOxaONosW?=
 =?us-ascii?Q?6SUDwHNeoooK0Qp6xGhD4XSQTwaHa3iC2ZRIBNm9ttUmh19r+jEtY9ClSEqo?=
 =?us-ascii?Q?dlMiZ7sjYFKaHsZcgj0fr43j6WByuBcrLhe0E50YktjIT5fTC3YzaVGsv3eL?=
 =?us-ascii?Q?/buW7VBqxSon7Qqko9crfrcHG6byq555oPC7Dx++DwfXW33JuxvuLxAMn820?=
 =?us-ascii?Q?uhYTpSFznhWKOf8noLIxX3THEeW/wqrTFEqW05zddv5RC3WZ7rAGZLp4DzSs?=
 =?us-ascii?Q?z4U16BbbfobfepPH7ZhTKlBKRNslNWmUnVm9LzEWvTpkO4fLgpG18zKtKd3R?=
 =?us-ascii?Q?3K6nlyQvLfszKeFSiHShrGjxK8a1K+ax5pOiGVYe5unxr6Qp8G6yXGIew9sL?=
 =?us-ascii?Q?3o0seRLyqyBucp7yc+WssOPXPZfnarMlzU2UBcDfiw8CwN7gRVAmdcGvrJRA?=
 =?us-ascii?Q?2wITY96UXooRBp4mHwZqWZUyPGXXP8W7awjX8rjx8ARqawnq8FVCUyljWdjJ?=
 =?us-ascii?Q?m2BBi55BbpwYQRYaXXuiFvT0qjmhQODkKFdEPO2wbGhSX+v8/DBA3ydbslKV?=
 =?us-ascii?Q?DG62Yj5g1VHTN433ZHaQ3TJndRN4TxYUcULQpvchjepNISitDGYFNktaZ3T9?=
 =?us-ascii?Q?cqQskPJrJxE05V0n+i0WRkSQhwQELfSo1GNaJladrZvafEiHoxv4gaupEyjv?=
 =?us-ascii?Q?TTHh/KkiHugDhTNupwsIbjQbkiC99IAIxMm7BfaHh0a/MsAcVqXNGcBn0Wn9?=
 =?us-ascii?Q?naN9+nMcFvNxs7rzr9k+CyAAA2qarSYP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xbRR4SAMCdJj7+Ucln69ksBD1MUTgIJwfVUGGaHagupbMLzWWv69AFV3w8rv?=
 =?us-ascii?Q?EZSpQuHoLkXsTtaRRh0drpdvEHnkyI4jggwJ8zAfrrqZJbSfRHPOuLUXZEpn?=
 =?us-ascii?Q?AVYg6QYcTChE21fJFfZ0GhqxZCKjtILnvLIyIoCTSmbwalCdw3yYo17RnvXx?=
 =?us-ascii?Q?xIQtatfbLbchMi/N72IHWLy7sKNAQUCkgA4nKuMOBLI3/zxU1xa/zmTmSA4v?=
 =?us-ascii?Q?rqz97GRru3Q0zUc7JDmwZpuTzImkpq4QsMRXQp3f/8g0lLh8jCwH1mI7h+y1?=
 =?us-ascii?Q?DUEBD/E2IlT4d5Nh5fvgCqOC24rbMi26s4xNc6MBZFTlc09qeW/LYSYHZAmp?=
 =?us-ascii?Q?6awFgqN54GKdW8ZyyEnDS683yMgwlX7H3HV/ytC/v9LDpqPUAr5sQM3vKJqA?=
 =?us-ascii?Q?9oZOygHhR1X+WDjtdnZ/9lEl+FCOmJsDViHw8Mmcz4wauLSrbMzjQ6bn9mMq?=
 =?us-ascii?Q?t1q+81hQyeq+Bzthppo2JrOla784Wq2RhsUQ4TKn1Qs5m/bHqqwGCkiwWitF?=
 =?us-ascii?Q?wUJ4V1iOXAYUbpwMMSxWtbFFAqtuoVCraBkEoU8NZRU9h9UgE43bySFwjtcV?=
 =?us-ascii?Q?L82fTTkVVjUGD/Vo9TAXsXcRlzfHWerfe43ZANKYDDnLuCrJ9IPzWH2m5LkI?=
 =?us-ascii?Q?xaohPhG9cmSadn90loEkrHXsERJ1SvnbB/hCDRL/uISk7WxTg6JvnCSsUbF4?=
 =?us-ascii?Q?bhbC3joMnpwGBeCHCezU3QTSnBivD4nJ/ojF+4YjYDuHw30EWxZxWceWQz+t?=
 =?us-ascii?Q?Qno59PM0NC5fruFfh5nKLGZz1y3l1QBf133q8pobrgIERxhRg80Q6IkPGXFa?=
 =?us-ascii?Q?/qMiZS0HpNNeOyejAGIPyjbYcJ9voL2gKzOwoFUX/znIggRMj+Lopg6sB1uH?=
 =?us-ascii?Q?i6s5H6RyD1JxPZbVGRZBY9jTLQ/17QobPDyaQ18lme8cHo83OiyIBrZp5Onn?=
 =?us-ascii?Q?6+AfZWbkkUifey8P22kS2u9nQaZAl4yMD51K2ROxbuohJxp6aRdj3kDbn4wg?=
 =?us-ascii?Q?nt2mVMWEr3M3/yGspbV+XNQH0e7izp6K1uRV3AtgOeNPyRjpcVsmrxpyVb83?=
 =?us-ascii?Q?/1Mi6gyJDlfKlj1ogCCBfza7U7CMlhmPA1hMaZgAN5/T5HxVmz1kZ6I65nti?=
 =?us-ascii?Q?l5OefcvRMFHmy5kZZpH4A0fhs68zq5bChws3VCECumyYNHX4o4vTv5bHxy3A?=
 =?us-ascii?Q?gnhED+F7wTyKYrTFOAFyqgzHnCkvZyRAjq/wUVBmRmfCmsWOwjq4SY2hxJgx?=
 =?us-ascii?Q?lHJxgYngLE+JK/ug6h6Jmm+HAmIqiJ/Lj+x1JJB0/XFKZW2EI9I1zXx41ewT?=
 =?us-ascii?Q?e3/YTB5VMpuByOm2oNt39tQWqhgrdbk/O3UHNAkglBNWeren2DLqKS14gOKC?=
 =?us-ascii?Q?pfka6e3k6puqPLZ3GDnT/CmpK+AC4CL6fjPrfg/3mAiyUzA821BxLirSDHYS?=
 =?us-ascii?Q?zTzvjbjI5qLSrNuKrbtP3fVAoD+qALHMIkPhiDjMFa9RJ6Xf908CJTNAKsDA?=
 =?us-ascii?Q?7JnMesgWDR/OnZuO6WxvfuN0irKRIl4N5RtMosoS+f2tKxwrOKlOH4ivjUr6?=
 =?us-ascii?Q?KA2cDW3b8sOknVh2UxeUfeRoNbbSKpJOSgoJNqcS7Z6n6KTDcPSa2Yj4X3LR?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PcJTQIXDjFHM7tl3hxl6k4aoARcQOSgXZcnh8TRfz1g0azc238S1Z3t8uv126GMNwK0X8SGCmWsCg8jGY+TWNwc/uMyuWPWzlRlnlM7FrNCckAvgzipj2geAwUcbLr2KhRDteP9PTt7kcPLvDFuKNSdjMX6AKic2nipLRsMwEavD8PKsUNuP+BD5QIfc/OHzgRsa/TZFou11/GyshrFosEfDFLd4ImNp3Lbfihwq8IR8LfN90yOvxQyVnJ6DIX+8a72TOIE5iYxKz58PK/D7dORI3Dh35YEISQKAABEC0MXmM8G+BNR10ZbkwzFj7kPK7aUZqHyZz9uwFSLr4W9HXbNHWPq64WTaH+u+eNus3NMzP8CNoihiQJECekF4NibVoatz4E60Crm0N3EZGNYmc3+zoqnP06tpb7YqwmDdVgebIEu3W64K5+k2blADsMOKCy66VDoJvhyuBYqd3irFr2LZCe7rguX5B6rEfveqWNloJDaaQYMJ7Tl5POUHMRm0WzOtRypWYfI9o0SIEb4/i0cS/oXwW4HMudfwIbrZkYGPgta5TLaITwHKv+5nOKu63WTbclVM9gRxbQbZKX5vzAH4Vyv6iPYsCti1GjDP1bs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0d344c-51e5-4236-23f7-08de0fd1e01d
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:12:02.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J7ClpnrAZuW7IzRBDQ7mj0P1owAf9UFVk72vm+VrEIz9hHFqGhredNkK2fnhj18M0N19kGIZQb3/WSIdk+59wWSE4lKN6SON+tJM0Wb6oGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-GUID: RUGEhq87N60b7YOxJM7p9t0iPCD0rg4b
X-Proofpoint-ORIG-GUID: RUGEhq87N60b7YOxJM7p9t0iPCD0rg4b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX+IoMew82B3ae
 qcM+NVGj148HIY0duol5rY+//xfInVomMVDDgkBwEPZIRqFBiCQCnQk1l4uf1NSDZA/u++pF1F9
 k8uaio1F6ON0VJV8oy5HWTMITnJkoXIqhN1upTqvzpN2nohvdtF7ZG26fVCu3ZIexLR5DgFJIuE
 UyCseMG+6OUltExieCiy489D1BOymgHeR7a57TdHfdSNcxUtl6bx07wLqglQ9BAgFMXmMRKxM4+
 svUWXo1hsNQIKXg17OqdtIFC3k591X/n+mZNDJ2H6dUVia26WtP/gp6wv3ZxV5i40ExBq1GBHUx
 cDM92qWvtY5hVgcH0F81piR2Kz/KCUdD+SvzGQ8I3VbhAXd8TZfikii4VqCRRpqPeFYc9twqU+9
 1mSz5r2mQkGJwJWJSIhmDwqx4mSACi2RiLdtaSBUkAyaGVm9vPU=
X-Authority-Analysis: v=2.4 cv=Nu7cssdJ c=1 sm=1 tr=0 ts=68f6271c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=CxsoVSIMbwK9moDqu60A:9 cc=ntf awl=host:12092

Now we have introduced the ability to specify that actions should be taken
after a VMA is established via the vm_area_desc->action field as specified
in mmap_prepare, update both the VFS documentation and the porting guide
to describe this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/porting.rst | 5 +++++
 Documentation/filesystems/vfs.rst     | 4 ++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 7233b04668fc..b7ddf89103c7 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1286,6 +1286,11 @@ The vm_area_desc provides the minimum required information for a filesystem
 to initialise state upon memory mapping of a file-backed region, and output
 parameters for the file system to set this state.
 
+In nearly all cases, this is all that is required for a filesystem. However, if
+a filesystem needs to perform an operation such a pre-population of page tables,
+then that action can be specified in the vm_area_desc->action field, which can
+be configured using the mmap_action_*() helpers.
+
 ---
 
 **mandatory**
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 4f13b01e42eb..670ba66b60e4 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1213,6 +1213,10 @@ otherwise noted.
 	file-backed memory mapping, most notably establishing relevant
 	private state and VMA callbacks.
 
+	If further action such as pre-population of page tables is required,
+	this can be specified by the vm_area_desc->action field and related
+	parameters.
+
 Note that the file operations are implemented by the specific
 filesystem in which the inode resides.  When opening a device node
 (character or block special) most filesystems will call special
-- 
2.51.0


