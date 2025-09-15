Return-Path: <linux-fsdevel+bounces-61299-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFE4B575DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 12:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D0C7AE0C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EAD2FB63E;
	Mon, 15 Sep 2025 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KWuj17G/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zS32OWNL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF052FB615;
	Mon, 15 Sep 2025 10:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931232; cv=fail; b=T2chydgrEnqg6zqgz8HjGWB4J/YuzcB8Bk9DGxmccZtzqqa1ppbQ71tmkwD2NVCMmmBgHnG5+gf9jnbfC30+22I8zzt+1PHXIPb8y4CtpJuzf6mmDgf+ffRKSZoNJk0JVSyuiW5xwGuY4u1LcfdMhmKtaapJ0UlH3G45fohqm+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931232; c=relaxed/simple;
	bh=v+OaEi3fqWZwIzaLAX6fVKqtqWxbBdaMdgYC84kX/qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jWmieQQsxrLXpbW1GHhTr9CvVVIcieLFDtA+C2PWn26IKMZwv3uR8Q+FyW1z10PAFj05dPcQb/wNB0xUp6xKhkqMBsemL+/voYhuQCjkMEhsV9OcY0xBhWvXtMVx11InCa7PKSv5y/vxRDrdt2oQV/InY9ghGgCKfbrHZ78g4q0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KWuj17G/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zS32OWNL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58F6gEAv022095;
	Mon, 15 Sep 2025 10:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GCethUuV17gJFa6OTL
	14zfdca6W5aNJIDGIsOhmpPTo=; b=KWuj17G/L5BHF9WAJaiTrDSgfCWmfOwXe4
	0UHLC1aLI0yicqalHPAR9VOnQrISjSjTEBlEVqj24TfJmZklv789tGzyd9pTbivp
	CM5apTH6fMlJxKr3E3NxoDZJ5xDvCPxq8OBz0nC5vPQzGCj7PP/02j2pymsAbJ7r
	dqkO4I+oImXeOWW90NNzkUL7FkB0/KBKgaBIBYfowNKg+12lOrzJKQMtzSsz9K9A
	/GkRSOFB5/vOduOnmEmljaX6ca9uSI9724NeNtdr3nvk5mh4TSTeCf3WS1Ef7Dou
	At88vtaEldmleuzR6zuom7Bzl2BPuuN8NYU4Nb4DxMoBGKxksbQA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494yhd22gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:13:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58F8GIxd015644;
	Mon, 15 Sep 2025 10:13:07 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012064.outbound.protection.outlook.com [40.107.200.64])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2au1ge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 10:13:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRq0UbydLYml3HrS1mTbFh53+MtIB7Z3XgkbcfbkMPL4USd2/JYS9hPOPkYermj/SfjKKHlHJM8VWbc5ltxVlIAvcW0mEXs2CTHrfa0XJrlbDgBphcgxx0L0uUxetGcXj0RB9Sj1qTK1iVnCOKOLTaE71xttbG9YkhZ6ZXBmqh1CJPmJEsbkjtXNQJqqGHRC/SaglmAIVTHXeMf8W96Wg5L/nift1o07IqWqEmOm/3fHQEYDXv22c+hpjZSp62S4E2rReOLUGXNZWmTLFPvR5SJS/Hh97xcdQfeU4TBP5/8zoj08fy+se+2vnQaWvSEya6LoxJlpwquO5nIowTay/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCethUuV17gJFa6OTL14zfdca6W5aNJIDGIsOhmpPTo=;
 b=aT3iip1idI41es5HWKTAhCBYWtEvzg49TScGUpzFml9MJLUN110J7Z+8xS1wdbpoYNPIrGTbys6VSBv13slXHor/exnI8zTnyx4DYT/qzW8iAVbt0e9WeTxlESPIn00s8RRuvziNPGOsOLkaeTQYnDQIrbYxVT3s451vK72k4HNKo8dhPb5/gyVf568cNfYD/VF9ogtKfz5WU2HHhg5wyLQhob29Yzow+E2CQjUT2xt+QQQFl3CApDLNOKUvj/sOj3NYyIXDJlu1DUGTMaR9CD/2ZVHYtZmO6hfdRA9fiPFTfWoV0wLYqRYDzxqHrGDjZyUCvtVevMDmtePkp7OYvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCethUuV17gJFa6OTL14zfdca6W5aNJIDGIsOhmpPTo=;
 b=zS32OWNL1xVGns7XxyDpQ9s0UpeKj6ihT63L8mhJNzhLuX8MmMTRvbMzMuDLJz2yBobcQ0IR07UfIGaceyAiu8QbGI7QzUags0NxHj31/kuoX6X0Hnscsk4BtCc+sVhwHrXUfZOZ6pio5MbnKskrdZ7AiBdX/6boNdcnZLc1e30=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5612.namprd10.prod.outlook.com (2603:10b6:510:fa::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 10:12:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 10:12:53 +0000
Date: Mon, 15 Sep 2025 11:12:51 +0100
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
Subject: Re: [PATCH v2 03/16] mm: add vma_desc_size(), vma_desc_pages()
 helpers
Message-ID: <17b6846e-d06e-4a2f-9104-17b147cafc7d@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <5ac75e5ac627c06e62401dfda8c908eadac8dfec.1757534913.git.lorenzo.stoakes@oracle.com>
 <3f11cb3a-7f48-4fb8-a700-228fee3e4627@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f11cb3a-7f48-4fb8-a700-228fee3e4627@redhat.com>
X-ClientProxiedBy: LO4P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5612:EE_
X-MS-Office365-Filtering-Correlation-Id: e5383b1e-e715-4c26-4b98-08ddf4406f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SG35pWArFkPDWZ2PfuQ/4riSlyF0OlxNqCHg1NKEdB6qoQBncO2Tncr8FfX0?=
 =?us-ascii?Q?BgIkknOMvl5zjeHwofjIa1vaxHUzLVlWqce9uSKqnNHwSZBT7wXlBDCUdu//?=
 =?us-ascii?Q?NyQ63c9ctbfcKVdkmew735nl2Xq42/q1pYDqi+1uylRkRh20Ly/wRAyaL4uP?=
 =?us-ascii?Q?skArMKaTJmWXKXf0p0nRcfn4mmfMKXldwaqTH9ib/y9F8IyhTwPW0zF4Z5kI?=
 =?us-ascii?Q?QQ6+gTyQ3JjCdVXAaBlTh1IUfXTwmLlTlgulqsxP08n3Zot69MmAKj4nmajG?=
 =?us-ascii?Q?ac+b7ibRpBemrZIOgdfylzAMCo/hHA1XcL+xTRtRl5vFuz8VyJvr0cH5r5GM?=
 =?us-ascii?Q?iHpWHrftjTt+uKvhiREoE2bRJBkpqtKA0lIQ/0lGAs+CZAruJhh1axoO523B?=
 =?us-ascii?Q?btDpP9JDVMK9MN13QbNvKulc3S5RK3adQ1l/Hhn+/Wa8pZifJdMZtDzCx/g9?=
 =?us-ascii?Q?sG36Yjd9QoKkZKyGxDSYPsmxUC9ZzufZ/zUTTXOJQ8ETVFdxT1xze7fG2JlP?=
 =?us-ascii?Q?jH38JFJB81geeC8l0nFWpydxTq54uqL12Vl9a1oCeEbeysMTH3sVYif2YgZ5?=
 =?us-ascii?Q?SQ8ekXGD1vlB04O1latl2zNyCRcnm4jKraGHCUCR5YJy/jbQ9rOmG1ZudV0x?=
 =?us-ascii?Q?CeNCpAmIPuPPNNljxLHqejt8XSmb9Kt3VLtlWiuQvPQydxAeM/ZBPH6oN9Lu?=
 =?us-ascii?Q?Vl+jbMkvwE7Q7GzsaeZ6pMMbyFVKv5PnTVlleb04l6Gua6DoYjJbyrX5Z7pk?=
 =?us-ascii?Q?MLTzsdb9R/PzXgb2jhD4UQ6yX9S9J2iTxeDMe1SknbRv7BEEGLRS8cJWTOMN?=
 =?us-ascii?Q?CaOxVjq0V2MiFrXSWY3o4tag/QGyDPv+UygCsQGFmlFjfZ3N+Coisqzg6g/Q?=
 =?us-ascii?Q?ceWELZtBmR+BHpYvqgU/KtGOF5HIOjwZtQ6/pGFDOg+ybNEidn4lq84ypmAB?=
 =?us-ascii?Q?uywXGGg9djUEcxdDU/4MSxjT9b7wMxeFi9ZAwyUBpDVCKN5g/Oufcxn+UUIj?=
 =?us-ascii?Q?ZWjkR3KUhogLSXUuap1TwPC3fPrnWPVYu0Y8UaBduEpc47FpU+MNvbGHP7J2?=
 =?us-ascii?Q?95Emt9tmnxJli1UWiemzI4rUNa8C1DmaHw2Qp17X3jkY61sPBbrMoG07RsUX?=
 =?us-ascii?Q?QgQ12ZM6z9qoHVqtdK+XKA0Iuzdlg69VVvBe1wUaXz+wRk8SJMnS5u4GJiW/?=
 =?us-ascii?Q?ZuFUSYP7MoSqtqJwVl/hJBjMdtyzrzY6r6ec4+Xw/+iPDe2mT/ZlJfvctxNK?=
 =?us-ascii?Q?eq3cNFlAz+UIgrnY88Z9R2+67F+PqaisMU2rK0/abEGotdjNRFF4orZANj5U?=
 =?us-ascii?Q?eIxHWElgUBGlpx1UBBq9H2DI8FaeqH22v5Q1vJaFXT8LZCikGbgjzku86isb?=
 =?us-ascii?Q?rm8QZx2kDXt01JhWxIvlbTT5T3DS6wwmPD2mxifoZRmqI8GmSBn6xyjDCM5V?=
 =?us-ascii?Q?G1n6BOtH3xc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lqj/c8ApIm2MFwBVLoluJ6/gypc86b4HTJ5qkSyfMTr/qzSZMeqgblt/P/+O?=
 =?us-ascii?Q?kX5SH2FHPtCAjpH7anNs6I3/HIvJDfKPqfkdX/Ts+5dnbCCUOBQrYqj1XYTt?=
 =?us-ascii?Q?7aFjglgK8vp9ogtMSmZ2SY1mETHm3N+XHGtd4qH0Ec4PNY+/5F64bd3N+AMP?=
 =?us-ascii?Q?9tzHZy/KbU1bG+bKFVXajNWtYXzWh9JrcFoVhHpi/ZAEa6jT+EuHiUkpA2hj?=
 =?us-ascii?Q?x1OwjAyvnuad6zZ/qPB4X1494YaJcEA89eOwMV2PpFWU+p2eisEotUAgIAdM?=
 =?us-ascii?Q?XC+2x1zmIJrRZU1JSej69/COSGN0Jh6nlTHA+9A0rYA+d+cFQwlECotXAwE9?=
 =?us-ascii?Q?Hc1fHkfSZixNNJ7BbDgWhCo7l3nAZlAun1OZR2Mi4viMhUdGRJ5ETrUgDkGK?=
 =?us-ascii?Q?a7ywQwmNl470L2fOGf7f9v3/9gx15a6MEVLf/zjbjXvgWL5GdsjpVe6Ep5ZY?=
 =?us-ascii?Q?gOFywdsZIQImqfnZ5y7Oar9dcvSp497S3lQ8Y3qRJgB60//rTeEhkkzSXcig?=
 =?us-ascii?Q?D4ZFY7/GIUxRDE9n0rxDoZKPxrhD8gOFyMpHPRYjwWUYP9RQlZ9qLFXxB2xj?=
 =?us-ascii?Q?+Kz5K2M7AKkAKpk63XW0AzmrLpqKDYLrelNepP1glfo+8F/xLYxYJBjcYoG+?=
 =?us-ascii?Q?AIbaei9ca+w2lCJXxd25fbMa+gpDbwn17BhrrP/+quDI06jHaxlYGEwDcNPV?=
 =?us-ascii?Q?+/Q141itKYn/XLpzZZNVyrZr2BelDl1QbLqUqR7KLTyQWG/hfizbJs0WNcQe?=
 =?us-ascii?Q?hXcLDskzIxdOdAK4TtAOI6Mn6+9qMvv99C3a6wqZYp4UQZP0vGzu29MwBoYv?=
 =?us-ascii?Q?ND0b3s0+PjUs7Zle70hjOq7tPraOEYyKK3J0m7dF6QBMEyUU6Ii7foWOG1yO?=
 =?us-ascii?Q?W4vPwllvtwD7DY/qFJcBTm1W4yWOKI5uv1xmd5cQ/AIva2P4I3hd14/rSXqP?=
 =?us-ascii?Q?hAHtGWH8wLPpJhjMEtrY+3nLsxL5rBTpbaWv2jxXEutQM9z8+1jH3NR970yw?=
 =?us-ascii?Q?+nf7pu+iPogiJcHBfBscfPIpLyLIlCXHtA3U/sLXH0/O5N7uBeEgX2yHzLds?=
 =?us-ascii?Q?rwHdmFKayvAybaICg/a64TuzMx/ItdIxKEFSFgpq1OMNVieYwbwMeuJL7EDA?=
 =?us-ascii?Q?FT074vcaEtUyh6pBU7jKrl+kVFbkoulF1UgLST0+x03T2b4phL14D0wp2XtI?=
 =?us-ascii?Q?Mo70NbTp5jNSyHgOKefY1WKZfHRdgWFl+vD9YazKBpCWSHKW6XBRW0q9qSR3?=
 =?us-ascii?Q?kpwEa8K3iLuNG4T4DwwV9si0qpnZuQfJaQ7hjRnFwovtWkpJ1EWpafBulMtn?=
 =?us-ascii?Q?dI4/AbWqF5kxQQXKOJS/H5I/Txscl5fnZB/E064PuD7KuD9rkwYASV7jD3dk?=
 =?us-ascii?Q?t19uvc4hz48yGNf0z+ebTGMWcQxCbeTW0w3W6/G9xUmRkhYG7UXCZtxMmKjH?=
 =?us-ascii?Q?m2xUC4+96Hn8JI8gTnDql0zM19Tmkt4PUUi5rGfKWDMPdjIxPkxitGnaFspa?=
 =?us-ascii?Q?GyfbUq8sMN+aPiO2mAOz3976GaQCCMP+NmPqJ4hVPvvj0z7PljO3YC0wgwPG?=
 =?us-ascii?Q?kipSRP392gaje6zeqEqcAehI+C/C39Wq/0CQTgXeVHv/AzHzCA5B6NJvorxV?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2Zhj3AVoDc5Jo17wr/6Du9KM0xqyme4HIFtiJPs66aenf5VpJrnrbgin47UpBS+JVqKY4oUtqyn7FAx0sIGwsbzPnD8FKKEqMBH8DU/jLPuUkqmjEwn7NvlYAjeYXhySBW661t9rF0zO5/oMMizcLyj/BURI7IZluyTeNe/tdSxPCAdxquY52V7ox/NqwbCewY66LHnouLReo24B5YHvVEeDn//CjPG6Fzuwgcg1MTjMr+kVxDcDXuEFBvFB7o6g+UfGJlAtRWHhDCb0+vPXnW8qAdUIzsEXfmjPLY0XGAupM9770AhS5E318q72ReFwDKjiozEvHzqTmSqlAjSNhIdYDfnQoc2WkQ6Jh9qQhFNYjsEwk0vPfJ1RK1yIJ+dU0aRQdUnLWM9cTRFXB2wCqDDmNkx2vRNJXHHoJ+o6M8NaMtladAnoUa2XtJfbfuSe7rHAi5j+nzlE1yzUat+at+vBZfEb6zYD2C4HPqTou5qeAKrG/c8VNJNiWw7177Do8uwpYpiLxtMDICL3WpRvVpyDStB5zB35H+ijs2aeUFNWKyY6j7kendowks3a2a4yw/A0rFY9i6sk8FFstKmfUQccAoWURrplcPZFC5xyWaw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5383b1e-e715-4c26-4b98-08ddf4406f19
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 10:12:53.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sHbAWRXsRjPhbZt0MGfxflTq3/KBpdRmgZ3AGrSeRbhE0cX+GkLNd7ztpT7wiDVTsfRce4NvP+7nVt/Op1VDfC1CKIZg5cHy5k3QfjjDDjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5612
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_04,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150096
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxOCBTYWx0ZWRfX0F1TI9micXUH
 5AMBQJGD2j1yb0QS+K4udaWPfMbD18Fenw2eSEDEDDKrxih6aP7cWlN4vGliDaI0fwj+ZOyW1XJ
 Ly34qsxjLp5WrzP21OrWH3rjAznU1yRX3zlMvoRCdAFucShcsgDKO6MTUI31Yf+EF6c+WP9Y59l
 wI/kDUyO0FKQRUJFYxBL9o0YSJnkURhdrSB9aAQVi6iDzRBLeLIyLC3rXbM4wMYm9r0SdjZo/cH
 jG6nn6abh9eWi/qlHoP8X6zXkDpNO7clF7ASXUfp2bcr0PzqrgXAy2/TpZUAu7CrBDDZeJG978E
 0OaO9IUWEqdLpCHgU2fWpMhuHWKOcqm/vF6a2qLiwR1I1zWH9VSmPA/L4NHWfOAZ+A+QYtM4ZZz
 ECp0lt+Vc897HlVm236C3O91L/PHLw==
X-Proofpoint-ORIG-GUID: x1o_KvnXyXvmDZGkSNz-Lqo_8eS4MihF
X-Authority-Analysis: v=2.4 cv=YKafyQGx c=1 sm=1 tr=0 ts=68c7e6b4 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=P0_JBuDFtRVjPN4rMcMA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: x1o_KvnXyXvmDZGkSNz-Lqo_8eS4MihF

On Fri, Sep 12, 2025 at 07:56:46PM +0200, David Hildenbrand wrote:
> On 10.09.25 22:21, Lorenzo Stoakes wrote:
> > It's useful to be able to determine the size of a VMA descriptor range used
> > on f_op->mmap_prepare, expressed both in bytes and pages, so add helpers
> > for both and update code that could make use of it to do so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   fs/ntfs3/file.c    |  2 +-
> >   include/linux/mm.h | 10 ++++++++++
> >   mm/secretmem.c     |  2 +-
> >   3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> > index c1ece707b195..86eb88f62714 100644
> > --- a/fs/ntfs3/file.c
> > +++ b/fs/ntfs3/file.c
> > @@ -304,7 +304,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
> >   	if (rw) {
> >   		u64 to = min_t(loff_t, i_size_read(inode),
> > -			       from + desc->end - desc->start);
> > +			       from + vma_desc_size(desc));
> >   		if (is_sparsed(ni)) {
> >   			/* Allocate clusters for rw map. */
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 892fe5dbf9de..0b97589aec6d 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -3572,6 +3572,16 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
> >   	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
> >   }
> > +static inline unsigned long vma_desc_size(struct vm_area_desc *desc)
> > +{
> > +	return desc->end - desc->start;
> > +}
> > +
> > +static inline unsigned long vma_desc_pages(struct vm_area_desc *desc)
> > +{
> > +	return vma_desc_size(desc) >> PAGE_SHIFT;
> > +}
>
> Should parameters in both functions be const * ?

Can do, will fix up if respin.

>
> > +
> >   /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
> >   static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
> >   				unsigned long vm_start, unsigned long vm_end)
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 60137305bc20..62066ddb1e9c 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -120,7 +120,7 @@ static int secretmem_release(struct inode *inode, struct file *file)
> >   static int secretmem_mmap_prepare(struct vm_area_desc *desc)
> >   {
> > -	const unsigned long len = desc->end - desc->start;
> > +	const unsigned long len = vma_desc_size(desc);
> >   	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> >   		return -EINVAL;
>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

