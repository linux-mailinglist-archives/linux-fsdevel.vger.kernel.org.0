Return-Path: <linux-fsdevel+bounces-61425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AE8B57FFB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 17:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBF733AC46A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782CF33472D;
	Mon, 15 Sep 2025 15:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sn77ifHc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZNJyof1r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F044F32F77A;
	Mon, 15 Sep 2025 15:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948822; cv=fail; b=C5y+Cm/PuIjQh3S3svMWQomqNchqWNjJRglRRlP7m0wE/2XfRA5dy8WiGoBRP1Ap/oRjkDk0g/BFSvN8XJgtaiXG8Ow+fmWJxumu13kt0zp8BvpqAWPmphRnlCRYAz+g2Wg36KhxaR/wUxBL4znTI+Hf0cb6wCwuPgVq11MLH18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948822; c=relaxed/simple;
	bh=2AzuQW3LOQtD528XTK9MazyGiq/eO4T6g5JiRMu7gsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NVRFa7dY/jR12CZYl5P8K/8Fk0mvC+wo83SwfcWaYJubQIXBn+05J26uclFewV03bOiT8DIbIxU1lrRt/9wSt4MATrnE++1cDtRPcoG/wDmIFiDVNCfeU2x++NTg88Wd5sVVJsuMZjrwaMXVhOyzujepysosgVW39Y5pcjxGLNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sn77ifHc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZNJyof1r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FEMnSq020268;
	Mon, 15 Sep 2025 15:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9zi855moYw2KbC3ZX0
	OCjYwrIf9mR21txiFBMDTcDv0=; b=Sn77ifHcYf9YyRx51T8dqgmJn0uZ2v4oCK
	VJ4MYk38kVkchoLr9YVgff0pkLC5BKAxeIKLXPjKqUKsXqcXoMqBvjDwRPYP4j3T
	XD/r2eX+X11YwnFw2x3hPDj+89yik8Hv7pGN/F2IbovdgHlJlq+qJwf+4rfIfLZo
	yF/biTJNSHapaL1ZKoKVxrRriBjFtj9aQeK0ESIiq3MqHtB0PE1BwnVQ1FN8lT70
	7aTKwcJr5ESlJ9lhxWiT9hxjyuBdbt0F1NnVHWRlDdect5ApZKRmsLekh8/jYEbJ
	0WLdFB7N7ZKFX+UEEow+ANFWPTVNlhXU8M076uSTQcKPENvkKkPQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y1fjkvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:05:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FE42iW015298;
	Mon, 15 Sep 2025 15:05:11 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011056.outbound.protection.outlook.com [52.101.62.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2he78s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 15:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfMzvZd8XodgwW3KBh5w8g0Us5Vq8WVLzT8VZjqtUpoAKuFHBz6Lx1xG1J56V1skLVB996qtAfxQoc2Q2HJaOrifaNasLI+qn254UeQFs9ZPKtYnt/mbz5rrJ2jfN3NMqfmTxjsV98HnLKNTrEkxqdN8O3pa747tA9C8R91R6zf1HVZ9LRC7+BxwVc0Yy/Ao2FhXOC3tOtCW0MKlbZYi2s328BQHXEoBk9cF5CBDy+8XW2BpmapmDE/heHEBBRW2qU3Y3znkV6xFfUg12/L0dlH5nRJ8FmIF5J4pm05GpwRT3CBmehnZZst/M7qhW1QK8alXIsocmY+pOXUuJ/Bc7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zi855moYw2KbC3ZX0OCjYwrIf9mR21txiFBMDTcDv0=;
 b=W7nS/5Wbp3DwnfVdj7+I16rlXCPAYPbffAf5coxEjJsdjmYghNygURQkJxnf4GAAdYOoikht4/KarK3kfwqy2yVnfvFlmjhkKriJ7sej/7LWV/InKx99+cNBoKBt6Qhbrm8Xxk1FMweuP3wKK2QQGffZpNWz3wrXd8Ln6aYiXTr93DN2znWZ1W9+dSzLTwwozCwmMyRzN7k6g805b/6ZJbaEclYzruxQNyWIgcWLDAfEkb5sGOTYbUHMiNfPvifLSatt24YhzZjHDwkAPpxJvYGY/hQ+CRP7wCluZ1eALWZh++iOdVgtqt0xf9FCXc6FaFFGFGLNcACIi7KtUTi7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zi855moYw2KbC3ZX0OCjYwrIf9mR21txiFBMDTcDv0=;
 b=ZNJyof1rk3Sc2xjYVVCags/6/6XeT7Jxo5ccKLz2exYfy7ULtzi9iTTHdMbtTk0nNuQBXnt9cHBw59sHDk00BDdKLbTdS+bzORpytouSbnV7McgsDF2NBAaD2Up/vJVRIv6XpzLVQ/gZI+biFOujiDZuxNtZMZapobSLXa1fZvE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7430.namprd10.prod.outlook.com (2603:10b6:8:15b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 15:04:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 15:04:47 +0000
Date: Mon, 15 Sep 2025 16:04:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <3c968a23-cf25-4b95-bb44-f7cdfd47c964@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
 <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
 <20250915124259.GF1024672@nvidia.com>
 <5be340e8-353a-4cde-8770-136a515f326a@lucifer.local>
 <20250915131142.GI1024672@nvidia.com>
 <c9c576db-a8d6-4a69-a7f6-2de4ab11390b@lucifer.local>
 <20250915143414.GJ1024672@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915143414.GJ1024672@nvidia.com>
X-ClientProxiedBy: LO4P123CA0526.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: df62b800-e704-4760-dfb9-08ddf46935e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YpZ4FA9Tu9aRn9wxD1uu+x/6JA8Unni8i/1eX+zZ0KzCaO2U85NVrHOdAQze?=
 =?us-ascii?Q?ua/mR2LvwgC0VRIh6SaFk/YrigVU9krt/jExgR7ARSTqSnoBF1tfL/IdGUMT?=
 =?us-ascii?Q?PKH3K2FF62erzrEQNWwb5KHBOAlb+Aw+NOFfBO4DeF0R5MJAHkC5M3dQBx4R?=
 =?us-ascii?Q?XixKogvhnWLweY8mkNwN11aM8DlVTOTevUiHluRCn7ACrQhii6x5+24EbRsc?=
 =?us-ascii?Q?bryD7fmv5SuWC6xMjPZ1toUTB4JBUEQTpPuVqyanJVBu7O3sSImyJwvk3CKv?=
 =?us-ascii?Q?leFMq2IjA6P8YODcNtMEMHqoAh9NQsb5KTZ8eQJFYNrbVopSPMOTJs/bzTou?=
 =?us-ascii?Q?nL7dkiZoCcx2SMhW0vaEclFuWzm0bv4j3LdnEAwyn1s5Ps0STlIc3lfDW9Q7?=
 =?us-ascii?Q?mqH7gewh5/BFIc8gsis+TsAv5uaMszA99A+WfrBa2g4d99zXbNLsr31k4jFF?=
 =?us-ascii?Q?hT6RRkXKNhik8NOrNpVBKpjfhzr49dypVwg2TWZX8nYMcZLuZrJrjPWwkTQ6?=
 =?us-ascii?Q?m//rijDO2/38abTpxpzDQn6CC91fa4IeujZQDGAMxq+EphCl7xsmMRLiZ5ee?=
 =?us-ascii?Q?tkiUW54jFKnDqGWs4/ympd+APAkoyqk14okQtzB08r21ggQkVVEpgu0Aa2Ou?=
 =?us-ascii?Q?59Js01AAoWTWzch8ICOwRxLWcNrWAOY8YnzGRrjyxQC2EE0NdH8Zyld50R6P?=
 =?us-ascii?Q?SO1dPThbYtmFhsJsKvCZIoTWzXbXPstI8kCfHe25oAIVXbcZwWiUIJDDboST?=
 =?us-ascii?Q?8h7pAVttv9JMJ7e2LOlPmHSxXOMwPPyxr0o1rZUoEn2N9j9zAkEJkJ02hOCM?=
 =?us-ascii?Q?etDjUoDA1cPEI9EJODdjAdeenR6NugZUd4NG99z4ddQKzK7r0fJ2aA+CE3UQ?=
 =?us-ascii?Q?6CbT65aJvy8QzVu7Oo+8P2gscGcBJ8CKAzQW/M4LEoKfZ6qYGbkM0ly13apB?=
 =?us-ascii?Q?OjUEAHG8k7+O4XwEJvDBaJ0q4YfcNIA3P455/NHLrAC20F9JiS2bM7V3h0fe?=
 =?us-ascii?Q?/Y9f8II0+TYR9DVsxyYh7k3fv3JglnbwCy28KD5VQPf/BFi83E37RBdE47+o?=
 =?us-ascii?Q?jClK51YAlOtRtJiNwYRhaqgzB2Wg7ajNyFxJQEFSpnI6ocrP38ZJnpJvJ88U?=
 =?us-ascii?Q?FAxnxsEYYqUabEAiNrCY8ViWUsnZfTkns4CZM5xHNtJLYU4+tPiZvRc+6VUW?=
 =?us-ascii?Q?HfopLmIEnEsjfOlY5fTNkWpTPkK9r5ECT7taCuhkG/neSoZzbpcZUi+tFv3D?=
 =?us-ascii?Q?F4nNuDTs0oSLZNz8pnjNQPtg/+t/HVebDtK9jQ3EezhsS0fSiwfJUwFtHhpN?=
 =?us-ascii?Q?MIAvcYXR5jB7JyZppbLc2mAXPsAqZ9KnUR7/Xsqw2bt9R6gmEXTjzyJIQlaN?=
 =?us-ascii?Q?489wzxO7vZciUbu6QaIXxbDiLsCflg9Xd8bxVhgyxFCLPYOTDS3NOLpP2BkT?=
 =?us-ascii?Q?oYtesUFR0s4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qyIZAj5xz/8d3bystBZevVhTWIq3lS8NkSAahae9kc4xpk669KOQtTNVNDUo?=
 =?us-ascii?Q?CAGCUHm5k/hKwt//sXhXh1bNLrUc8rA+fKyXLTlnYptBdRMmxunF7Bjm6ZpP?=
 =?us-ascii?Q?OlwXLhdnPlZm4l9QRs6h2YRWbKVWLUJnK31R9V416Oi1yk1ezXenyqGSYAe6?=
 =?us-ascii?Q?5jtWFCUpJGdp0EALs9Tkl27ZBzvMaTXGAfaUEZhAcR3/LTpopXJDzTwEgmD0?=
 =?us-ascii?Q?6l8ylT5NxqyQaXz6+z/2DvEmnP3St8Eee+VJXJNrRmfzAiwcumcUkp3rb6yg?=
 =?us-ascii?Q?dxLLv9Pk9VSmdmSsNzg48R/6NhOjveK7+S+2TqPeEqIQLtjgk4wrznymCsza?=
 =?us-ascii?Q?WVmCwJ5UrU8OilvVH1jUUGCV0pZSSYpTvoJ/1nKS03EQG6UXuruxbnz0Q+wi?=
 =?us-ascii?Q?9DzhXYo1uEdCsd+aKYHUmFiI+dbeHKroLgsLEro7Rk/rjy93Orgvxrhm8x5t?=
 =?us-ascii?Q?Rk/vZcvI9gKCDobZpmifoxH3tNNKP7DfFei+llxPg7rPMe8unvKlIpILAtUx?=
 =?us-ascii?Q?1W7uu7bQPEWiM0X1wNd0T/4alupTUdMe2G+B2z3XuFI81aOlfWKDSq3c26ER?=
 =?us-ascii?Q?XM4P4YXjZu6AOYYw01QXUp51vtjUtydS5DzOmSTdIb4BjczD4kg6G9KHjJhh?=
 =?us-ascii?Q?+P6kmfAC7A2nK6NJpxPZCAdRscpt4cPrfcvg5WJYrQQifKjAehsIm+gNz1RB?=
 =?us-ascii?Q?idKDnDGhwxyJ6PU6rDWYtwjwDlRnXMCWKtOf4PboNR6dNDqnFPJUybtwA9BR?=
 =?us-ascii?Q?InPe8Utbpv07gYIKaD2jnhKWqaaF7GpePROjGb7SakH/nqhNA+06jv5pKl4u?=
 =?us-ascii?Q?Yplfu6yUIZ6D+qa/ViDKfqYg1Di4gvKz2SBp6LUKgYROnX35vvo8MgUN83Fv?=
 =?us-ascii?Q?HdXkIRtPlVdJmGCI5Nd4XPA5AWRy44Ki1V2i+5RYZJrMTznh5MPRFXH8ypsG?=
 =?us-ascii?Q?wZ6I6cX5tGVNXNAQCpyFfPJ3DFDB5EbB/amuUz77y7f0oi6L+FnF4M6ZkOQ+?=
 =?us-ascii?Q?3SF41gQ4FhcULsy+rmAF8tlbD6/x7slJwdK30+Y3PKMRht9aSbhzAOzjQ2Zm?=
 =?us-ascii?Q?3RKbm4GQSA118pVuqzGov2FMCa9TWwWSjbRaTRKH2aAo4hkj+2pRNGVFmhm/?=
 =?us-ascii?Q?qfp+9ba07f2aFFTJjkFZthD6ODppudZIDbyJzLjWMJMEsvlL2A70R9EWKZO0?=
 =?us-ascii?Q?VyOUd+7zZVDFQj2IParSz5ZsO1HBISW3Jkm3z2ytH9pQF7sswVm+KdfDowz9?=
 =?us-ascii?Q?JjUGL7Cq60KO5h5ZmuDOH33WHGFZmRCfZ+DReq+ytbQAz2FJcFgofcM61pNw?=
 =?us-ascii?Q?acmJhfW9dxM/ltCWk0+dJ2BvBZFqXuX9jIHXQAewkt7Ip7LPeAUDNxDhrvHC?=
 =?us-ascii?Q?j0+oVPzaEY99rYFW5jR9zhG6rRm98HFJ6GQtL4UjwCFVCz0tEjaaww/VjfpN?=
 =?us-ascii?Q?h/zeLxWfD/qEKOFq4F3gWAA9bJBohu6cfAz74LZVShfy5+5/cch3EXKhCw+A?=
 =?us-ascii?Q?8JqPEfb17OwvEVtwQ7R6HO331WazHTT1pjMoFf8DzlI1juKOo0BS230mO8YK?=
 =?us-ascii?Q?y+tAE0iCI6if4MGVIjrgnnkw8/peWiDW2jmQrjMCYJrcptQJe77meSaeXfA+?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RdSHP8JynCFQSzEXbIa8F6Pxqi/bRRo1nrHQSoa+Y8KBeV8L7w6PUS3Z6zez9tAwvjeUvWl+ojVBvp05IffMJvyHAHely+ERClaUXGmMrwQ8amvQP2esdf8HqwRXmAT0BFJlKxF8+IN+aOGrZGzw3WWB5kqzkJpMBXKBLFtkLK2hJJERyJe6N7HoS4wzWVV5kvOi7g7djA/17ccieB+orv49pBaPXKRxAF/OEP/chdc5S0tqFby4dGYFvjB+DM6x9Q5//u4dzZ++2labwG6jYWH16hOpEmTvqe8CCKZleX5uOuroc3PBx35mPxPDo2hr3vhAh/kQ6Kbyt2Bw3yBPDrAMoEmSEFjZIZtADEGgeWjvlaR+F45FNHiqyNIH6DKWsYByzKdCEZ1so3Kf69fxdyDq6aTEbBjPnc1BivNOKvmeHfoMmPtdPhrehxE4dUBz7eTSC4qgRyIz8LJbMgFMooBnDelmxGJgDPA0eYO+atl8TOHxnEGjK+T2s/v9Kps5h/RQoPpF5d8XSFm50Lqbh73LrXzK0Gh9LNc7qq9lbPOo6QGtIRzv5oY5GCugsyvljv99d8JaCdS8Bwl2RsLgHv2ZTa4IFbwizBl0q/r2KV4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df62b800-e704-4760-dfb9-08ddf46935e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 15:04:47.1148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lzQr/RfVA8jKjcnFLpbkEa+T35n8j3u5Fc9VyF9xRK3nrVm+JQARrJJcH8/GhnXnLXJPtoaEqKvEy1i9n6hh5ktDES0ojZ44SATAKRJU1VA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7430
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_06,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150143
X-Proofpoint-ORIG-GUID: _Clld2-6NJqe8w8m6ACRtj6Oy6FwjEkr
X-Authority-Analysis: v=2.4 cv=KNpaDEFo c=1 sm=1 tr=0 ts=68c82b28 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=xsfo4qHKq2V8f6MN6hQA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-GUID: _Clld2-6NJqe8w8m6ACRtj6Oy6FwjEkr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMiBTYWx0ZWRfXyrIBTSUbnnTT
 FuqhtNFRAaCEfjqsnNTP3iEI5jrOpL7wNvvSnXnkab/NeOY//2LEFF270ePnFvOLeXgjO5DRJiX
 j7EeP4pXkBCFuHegtr2iB2Psi069f4d7wvw/6vVpQX9LiVLBLhDRflVO0aBeZdvsJVN9hx5+lB1
 qxqZWnK7Sq+E6a2MsCCFuNXYk8ia4HTl9DCyiqxOLr1i6v0IEzlG7jvJty8erXsukOKCiDTKZK2
 lrdnoeBtRoKGPhUInxwn53nuTWKLanHcYGlRNtwvEKxKkd+JshQxjjRHpY9rbx3SI0WKC4EHrwf
 DOWzq9yve2MHp5Vh5o8qXkcK2JCUhKnLClTGrPitTMicwWegwE8XMaaWPRRsTkkAGQ4ziEcJld4
 lKq+n3/E9yuBU473nphj0Q4f+hzBLA==

On Mon, Sep 15, 2025 at 11:34:14AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 02:51:52PM +0100, Lorenzo Stoakes wrote:
> > > vmcore is a true MIXEDMAP, it isn't doing two actions. These mixedmap
> > > helpers just aren't good for what mixedmap needs.. Mixed map need a
> > > list of physical pfns with a bit indicating if they are "special" or
> > > not. If you do it with a callback or a kmalloc allocation it doesn't
> > > matter.
> >
> > Well it's a mix of actions to accomodate PFNs and normal pages as
> > implemented via a custom hook that can invoke each.
>
> No it's not a mix of actions. The mixedmap helpers are just
> wrong for actual mixedmap usage:
>
> +static inline void mmap_action_remap(struct mmap_action *action,
> +		unsigned long addr, unsigned long pfn, unsigned long size,
> +		pgprot_t pgprot)
> +
> +static inline void mmap_action_mixedmap(struct mmap_action *action,
> +		unsigned long addr, unsigned long pfn, unsigned long num_pages)
>
> Mixed map is a list of PFNs and a flag if the PFN is special or
> not. That's what makes mixed map different from the other mapping
> cases.
>
> One action per VMA, and mixed map is handled by supporting the above
> lis tin some way.

I don't think any of the above is really useful for me to respond to, I
think you've misunderstood what I'm saying, but it doesn't really matter
because I agree that the interface you propose is better for mixed map.

>
> > > I think this series should drop the mixedmem stuff, it is the most
> > > complicated action type. A vmalloc_user action is better for kcov.
> >
> > Fine, I mean if we could find a way to explicitly just give a list of stuff
> > to map that'd be _great_ vs. having a custom hook.
>
> You already proposed to allocate memory to hold an array, I suggested
> to have a per-range callback. Either could work as an API for
> mixedmap.

Again, I think you've misunderstood me, but it's moot, because I agree,
this kind of interface is better.

>
> > So maybe I should drop the vmalloc_user() bits too and make this a
> > remap-only change...
>
> Sure
>
> > But I don't want to tackle _all_ remap cases here.
>
> Due 4-5 or something to show the API is working. Things like my remark
> to have a better helper that does whole-vma only should show up more
> clearly with a few more conversions.

I was trying to limit to mm or mm-adjacent as per the cover letter.

But sure I will do that.

>
> It is generally a good idea when doing these reworks to look across

It's not a rework :) cover letter describes why I'm doing this.

> all the use cases patterns and try to simplify them. This is why a
> series per pattern is a good idea because you are saying you found a
> pattern, and here are N examples of the pattern to prove it.
>
> Eg if a huge number of drivers are just mmaping a linear range of
> memory with a fixed pgoff then a helper to support exactly that
> pattern with minimal driver code should be developed.

Fine in spirit, let's be pragmatic also though.

Again this isn't a refactoring exercise. But I agree we should try to get
the API right as best we can.

>
> Like below, apparently vmalloc_user() is already a pattern and already
> has a simplifying safe helper.
>
> > Anyway maybe if I simplify there's still a shot at this landing in time...
>
> Simplify is always good to help things get merged :)

Yup :)

>
> > > Eg there are not that many places calling vmalloc_user(), a single
> > > series could convert alot of them.
> > >
> > > If you did it this way we'd discover that there are already
> > > helpers for vmalloc_user():
> > >
> > > 	return remap_vmalloc_range(vma, mdev_state->memblk, 0);
> > >
> > > And kcov looks buggy to not be using it already. The above gets the
> > > VMA type right and doesn't force mixedmap :)
> >
> > Right, I mean maybe.
>
> Maybe send out a single patch to change kcov to remap_vmalloc_range()
> for this cycle? Answer the maybe?

Sure I can probably do that.

The question is time and, because most of my days are full of review as per
my self-inflicted^W -selected role as a maintainer.

This series will be the priority obviously :)

>
> Jason

Cheers, Lorenzo

