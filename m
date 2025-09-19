Return-Path: <linux-fsdevel+bounces-62198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A43B87E58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 07:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0907C41FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 05:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48111279DCD;
	Fri, 19 Sep 2025 05:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rlXXHpSP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PjDVnyqJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BE01F462C;
	Fri, 19 Sep 2025 05:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758258690; cv=fail; b=omt06uAf3XtUkS8oEGBTbo16ub9nEQHcOpUd8/LLMOQQWs5R5rjQIt2xmoaCgGsaEtDXQngw75D9iqUUfYMmiwhqd5iqHhW299ICXw4i28QZARVBaWhnXF94EEMQ7Z3xq8UNPEGesByrTrbReh7Ejk2EIV82vit4A6rfDO3HUUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758258690; c=relaxed/simple;
	bh=xAQwp8cFsomIi9IN1Ga3OJdWMFMbWvehLadaJ8zvS5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bEKu1a51xOMzNYetzMF90eLK/FK8JZJ/SOQDFuCMp/cfrFCJtQp4S4KgGP5obGPLNG7AzcRaHFVvgdGzKU7uKja8kxq6Bgo3WIpSN+bidTUSlbfe1y5MSYP2QR25XDRfoHqC8LWIfWjH8puptzi87oqqUFG0W69saRgtMFjumXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rlXXHpSP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PjDVnyqJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ILFVRZ004759;
	Fri, 19 Sep 2025 05:10:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=aWfh/j1hhKwhq2JXag
	nZPhERwMR1IqTqWOMO9u+TSDg=; b=rlXXHpSPkkBtXr8gOSmYzMY4Oqd1ki/+Nw
	rYTNS5svyr+/jUL5KMyO9SVOKRsoiA+mr6flXctDKCJ1DLloZVjDmB3JqRexLsUI
	A80basghfFjS3n7SJ6D1fW9Z3LHDmoGuvW1cpuGq2TL2wnT2uznqHGNhQEOxd1lo
	I34VX3gKdO7rcxy3H98HbCJZ9VnwBxHWjmpXWcfdJmScMIrctWgt72kXmloKnl+r
	4xaG9Y4b3MFGLdBFB7OGUvR1KfS+c4DG2I4AyxLOikyLrTIAdw2wY/6gVjcbXNif
	XoB3UIauAx906kOoma7budsiC+mwlpq9gicbLQdvIsMz/auNwwWg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd4u12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 05:10:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58J31PUV035255;
	Fri, 19 Sep 2025 05:10:19 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2pbsm7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 05:10:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lJjhttsveew9lXZV5CERZ+KffX5FMz9cQxyAJdiTOUDwowCZrmDEpkpvxMmh679Ea0x5yiYeUrRCky6xYyZ3ZgSW1rhs0rLjTEArpMeoy64pmoJFvTXkFFT0uUKNZJq8g41N5Rm4QxZXXi1hft9zrDDwvbm3nqI3domzeXaiHyDRye28Ds+a6C5LMc8SNuSkgfzxJhkUH1H820695Jr9/irl6P2+NToqbxiageeat8eDHTJaKklxanNWsTL5ZmOue5JUe3qHJVdlFsFCTHKre9jXjL6EzSnxj4+bNDG9EiF34OxEdmiES9SYyq9lxCXMTQxQu2Akzjb3Cl/KpX7vfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aWfh/j1hhKwhq2JXagnZPhERwMR1IqTqWOMO9u+TSDg=;
 b=tvCdkN2gh+bpnVJ7QrlAhrOwEfglOnmfBLIVbIxX5BvepvBPKm5OBye5tBBWssMG0xzzcWF3M1ocvgQN02S33GKaf7RwbXrE1So2sH6/dmUL49o3c9VtyHjmMGsA9LDN/jjdxZ/Ma0568Ng5Nq11vveVDDuD22NsqucNOBlpKsR7131uwCak8U5YdyLC/ijppwbNCcH/xWNpMjg14HCJVp8RbaAu8gUYfifwj534Xju8jBGib3pMdObLZHbBg1jL4igCAwzYPkmfvGGR++cW/lA0dvx3kWb/pgKQHtMzGDRU3V75CrTC91iRcsCePcBAL0vltdkjlaogpf0AxWfCFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aWfh/j1hhKwhq2JXagnZPhERwMR1IqTqWOMO9u+TSDg=;
 b=PjDVnyqJgVy/ZUZOQr/nK+hOVawxdcCs8O4whut8kqHkq/K6qbD4tiXTrhtP3ABqx4T1GiMtFegn2Ei5hEry8J4QRRdvZd6V0JGuE3upu0wIYWFDJC/D9mAipsQNgKXLFTq8t/V7+PdRKIG9QUMjMD8u7Tb4KIA/K3XXR/tKx9s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN2PR10MB4333.namprd10.prod.outlook.com (2603:10b6:208:199::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 05:10:14 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 05:10:14 +0000
Date: Fri, 19 Sep 2025 06:10:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chris Mason <clm@meta.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>,
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
Subject: Re: [PATCH v2 16/16] kcov: update kcov to use mmap_prepare
Message-ID: <17bef9e0-575f-4ced-9884-3fd5a8f77067@lucifer.local>
References: <5b1ab8ef7065093884fc9af15364b48c0a02599a.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250918194556.3814405-1-clm@meta.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918194556.3814405-1-clm@meta.com>
X-ClientProxiedBy: LO4P123CA0685.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN2PR10MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 337628fc-9ef8-4431-b493-08ddf73ad134
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?/iIi/0qLwcmovAoZZ/f8BF+lliI56VQnYyS90qR/hr+tVloEtE3A0lTZE1IA?=
 =?us-ascii?Q?gT+ZKE6NJd7aj98zmGkYdlbsgOsnTT81qrE4blzLG10pYSzd2fkmqtndzLXu?=
 =?us-ascii?Q?nXHZ5gRBCoz+Too/mu2wsS6JISlt1Owq7LjYZU9I9t4GNZ8EKty7sku+L5dK?=
 =?us-ascii?Q?eoRXkqrl5aR54NpYcTlLW8EEHtB+sLmSDlT5izosJh30gP8wQab29G/F9hv9?=
 =?us-ascii?Q?n33ex8Pvnvo08vM5f/jG7L+9kpQ3KadJKs1aisu7oHDGx2UXp65vgCZv0XxG?=
 =?us-ascii?Q?GPcN8OsLWzLluUGVFQWjsA7QFfKLudC8H2NJ+uKiN/HQr+hVrrm6ic9vEb3s?=
 =?us-ascii?Q?IhqLrEBsoyrYMAFAIQG/ZUneMldSSZYHOf1aqSTMuB0AwHMtQg+heSwZBJxY?=
 =?us-ascii?Q?c6jKQd26FDfJiuRNlk3WyRLlKdlVzQ3eEtS8i2iiaVjHbOw2LSPtNIsTwrRU?=
 =?us-ascii?Q?u3BNFKBZrrzTCds6dUKRv11IbHf5cQV+HAU20OEtuVafv1ZrR0ky+jU3ccbz?=
 =?us-ascii?Q?/0/eHaJ7/fAO2bbuv/ZPyqnzWvgWoPZ/AEib6U5mqINrGYmTJRfTX/ujfV1T?=
 =?us-ascii?Q?6ri2JtcEejZkEqzTUsPeLVS10REhAKD3kpbJyuVWQRh2FyBYULMFlwb8uV7C?=
 =?us-ascii?Q?qo+2GE0tooytm6nLPOZBTxtqQYSgTJ217KffhxAwIuBn8TAxDonMuRliOm+W?=
 =?us-ascii?Q?KSM6ryOI0joaBmlUEFx/jdBdMQCs8EU4WOzRTofU7OShmCwqkxKBFOTmq6OG?=
 =?us-ascii?Q?kGANaUbQDCI4e0cEmYIYUqgc6BaRCQaPlKUAdyMS4q7SZLKUdYqFuMWDpPBM?=
 =?us-ascii?Q?dbHigjGqkAbwIA+HTmyBcgbaGwRC8xO+m+GA7wOOWQ9f9exb8nIukenZ93UC?=
 =?us-ascii?Q?9M0Ar/ODq9/iK1hNjOU227C3E3PAry+E6aP79tY1nXGLWKjpS3hFnxeANhoe?=
 =?us-ascii?Q?nyGy9zdnUIG1/4Pe7nq5XcuPc++LMtuut7PNbr50KsyP9NNytWn/C8MstnOB?=
 =?us-ascii?Q?amFTWtvsuO7Xw9hKZMFl1AjJY+k+citmyEKXwRxt+0JXajYgM2RQ4myN0MF9?=
 =?us-ascii?Q?BANXtFLkE0N4FIXCK6gtNSjj3L7dUFsZcF//NVowH+MEtsJb88/eTlXKnmWu?=
 =?us-ascii?Q?VUJSrdJ2fh1eojMv/OkOg8uzZ+cn/x8tHcjMvheX10TVJjjpP+VstrZgTAMj?=
 =?us-ascii?Q?zK7cV8qi1HmMadqNM5cXKdXphn9eG6xuuesxB/ZtrxQiwfx+/W13nDpvc135?=
 =?us-ascii?Q?I+ZiBaOYZdjzf+iie4LqYGvDEKH4zZeFdMJ/RosSX5i4SqDW//mKshMC4pBh?=
 =?us-ascii?Q?ZZaMMzmLdxUzs9iW4rbIuFU5OgiMZL+YLoTuz8XwnJ0z37DlY3ZJjbdls99l?=
 =?us-ascii?Q?q3+kDOQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?Usb3VIbr3ciiLKdOpT5HNGN9rHkXtBIE+07S66RxDIaHixPCqV7r1hnOcggp?=
 =?us-ascii?Q?21nMfOdf+tMnJiqiB2j1N3gX1dAc8V4HyVmCXbqJs7eTKm3YZ+1gylFkWXCS?=
 =?us-ascii?Q?2niko9Cd+O2IFXXDR0wnoPkZCncB/HM0bOE9ozMyLR/zFO/31YaHJRbxsWB2?=
 =?us-ascii?Q?jY9a0rPCvvOR6sF2pNexGc7Dw8vHbWqswyUkDTkyAZbG7caV5bfOKMqK4jL0?=
 =?us-ascii?Q?/3XA2IRCF8uEwT5AIb5/qU3QvZ/Jm+kfMqwo5vMmrWx5iwOJlyEbAAMmBzXS?=
 =?us-ascii?Q?KbCcPGqtfbzUsb9kYUFaNfLftt8xWoK75anH50f94NYNioSCgoHGIOm1jcV/?=
 =?us-ascii?Q?Tn9X3aZvAWhDMnlLg0Oh7/CWAi+3rUH1sGOHZkFs8FO+Mxd8zUhppuLV7Stp?=
 =?us-ascii?Q?bEBtpF14yZsqRItJ1BhWoExYY4bmyzO3AsbRZTCuCrfU+YzwiYSCgEy51XnR?=
 =?us-ascii?Q?MEGhyjFbWGahshI7vgkBTpSSLCgwwSEnqiZXo1iuVFP0XVOS6pwLwGUcrNkd?=
 =?us-ascii?Q?0KIFOqpXSQPNePE/JWDI/wq3OtAhqdtOlvFfRoA63JUkQTE2AcwX4iOOMime?=
 =?us-ascii?Q?ibzredJMra+sMqWW+neZx5SqFBKxyokhYpT3jEa0AfKupNukZ5jbNWmjEyTR?=
 =?us-ascii?Q?abUgunrgH9f899eZBBawS/QBW/YuvjviRh1xAxgy18FZBFTEcAoh9jNduhAv?=
 =?us-ascii?Q?MWyQQglmYbtMw8s7zpM+ns1vEoKUwhP4sUZb2sOGiVlg+niTuTbRRIAq8jV1?=
 =?us-ascii?Q?rd40o3m7cdYUhnaZeWqpoI1IZo81QKq8rr7KUlDBeFK4kKm+GlhG1Nfn3Dos?=
 =?us-ascii?Q?m1adKzl+Vbkfb8vLO2tCyv2AoG+2CSyJQ2IPHuiSCoeKBS/G/AeIxBfH+42j?=
 =?us-ascii?Q?xxgzeq9gzS/b3vmNABIROdW2QpeMam1HFogX+/tj/7eEKPzG/ks46Kt+tKE9?=
 =?us-ascii?Q?N3ZS8SAT2XCgs9N4u1/w2KGvIV/rtJ8FycpbVUODof2nZ0rLaeHdp6gk2LeX?=
 =?us-ascii?Q?AIolYGLYMKTqOxK7h4TZX6RAdUcfV2H76lt/KWidCZ0YljJ7BqNYPMdCfMks?=
 =?us-ascii?Q?YKab42BPdHddMBN/+XmO/EHcnNItJZef/U/BxiBVBdXtyXs1LslXGo+tYvN5?=
 =?us-ascii?Q?849qUWu6fQ/YI79X0l9QXnY7Rk/6TFrzD2og3e3fjo0tZn3zdhgR924MCYkf?=
 =?us-ascii?Q?SfIclPZLtRaVL+u26dK9o2Veq6XfSjv/j2oIOYrWAhfzAY6y910361PhIPjm?=
 =?us-ascii?Q?z7LgiKVL+kpX5fORvo9TFvcwoZr/Eo5CqEwdJRGjXszL7Ygsw5B820IdS0wp?=
 =?us-ascii?Q?k8FDlEO1He/gY7r9JJqnqJkQmp4VOIjP8iF1Obsnd8YJg87odUEFIJAKFFrE?=
 =?us-ascii?Q?AZiQtEA5T1ycUI7wmSiz8QShud6VQZ+A5aZEHvgMP9iXpmNag8jI2UQNDrP7?=
 =?us-ascii?Q?cWchCvTAGpnbbNUSuzax8A7k47BxZKtOYcGWvKJK8L9Q4RHc4G9cTKBsJEju?=
 =?us-ascii?Q?qi3r5AbVG/pmrg5MP5ORgPXiINAM1kTlZGE10WJsTRxDfmXL2Vig1k6Y6KQz?=
 =?us-ascii?Q?2uZ1gUIewknJlyCVjd8eMsdJRl2maVkZftJBPHt6iPQEuj8ySMJjnWVdckdF?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YtCEfLcHvs59JJpIjX0O4QJivziSZkKTQuKsAqt75ECQ6WI/dlQiFiFNxYtkTYIYak+jpOfSDcByUVpiwAKz9gTzROiykMXWp4LxcqjmZQIo5Koc9Hqg5DfRf9lXY6aoLACq5twU5gjtShSxniHELOrijuv63T5hPjM1gD1+hA5dw2fOXHrvMQsED8CStPnmlUS4B8P3kJtjDsEiePmHCkISzc1tJ5gB35A0x8cA5ulQCU+s6vbDzUsVrL5JUby1xeU54i7OXT1osoVWUaMZlNhceSoet21CI/BFQZIlgnPqh3wCLeEIZf9WoFYMN0SuNqAkQGkORweU/96xWsWg8I+KbjQ0ofTTsXG7CzhK2ya0L8UAdtE4WMswHOMeMWha2VF9JdLt2a8a+HmjAvsFl0LILixvJ1TdXxbG5a4WAVqQxiIsWZZFHJve0rtogCSSx0nGYsGiGPTk6YqCiNhOiftqaHyVw+7Tn8KsJMhqEFkH1HH7Hxs3r60cbe1fuxfYAvcKLqfsOfF/qyafgL60hnqV2PeLMyvmKO8cNIdU/EGWuqakIDJ7R5bCJlS3TuDMzHuA9D0/qivBOAbMLrVbraDil4G1PTIgMtTA1r0fa2Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 337628fc-9ef8-4431-b493-08ddf73ad134
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 05:10:14.7467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XjG8PHHbB+lfNlLNwQKtsMl1VDQeHgG8u8GP78D8w/BGbLVwfEoKYfdVwarR85AxUaezHjZ2F35bBLL/huzp11MCW5fN6DrNzNmU34g3DyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4333
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509190043
X-Proofpoint-GUID: yJSw5CDOWio5EANrUzoBrm0X4Zi-0BT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX9qCkfflg9yFz
 ODwnczr9G3Rb16QUuBEok5Nild8Wl1pEjVgbetb3w+I6T5NfGfwhHtPcZrro4hBYa4G41xszTZO
 epPDd9mTTmjlxprywB6AtOQw+zoUvjXa4vpqbTu4WX0ONa227TzCBF4NqnlEPKt8r7BPK4ej6ZE
 ck6Iz3N40YLgXwrn3gvh4L2Yqiqm0IzeBq23edFEubY5d+xT6WyNzKKtUiJUoSj04XwknKfFpaW
 PI82F+Vaiy1xwlT1BH5c55Ml0jFPjarD2KoZHobjHCT01LyC49EHZdT4BECgNGd1+FxWDft5FQk
 h0D6lybn9s4Ts+f4QuxDtt2/pTdOC4ZfbmPv+45orUnLcOYFMsXs+cTj+xzDgKbF+X7WU6VI2QP
 mMg/wc/QHkE2AyIic83nr4LAEbvmRA==
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cce5bc b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=GBp2PlFQoT0y_MyTeIIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: yJSw5CDOWio5EANrUzoBrm0X4Zi-0BT0

On Thu, Sep 18, 2025 at 12:45:38PM -0700, Chris Mason wrote:
> On Wed, 10 Sep 2025 21:22:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > We can use the mmap insert pages functionality provided for use in
> > mmap_prepare to insert the kcov pages as required.
> >
> > This does necessitate an allocation, but since it's in the mmap path this
> > doesn't seem egregious. The allocation/freeing of the pages array is
> > handled automatically by vma_desc_set_mixedmap_pages() and the mapping
> > logic.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  kernel/kcov.c | 42 ++++++++++++++++++++++++++----------------
> >  1 file changed, 26 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/kcov.c b/kernel/kcov.c
> > index 1d85597057e1..2bcf403e5f6f 100644
> > --- a/kernel/kcov.c
> > +++ b/kernel/kcov.c
> > @@ -484,31 +484,41 @@ void kcov_task_exit(struct task_struct *t)
> >  	kcov_put(kcov);
> >  }
> >
> > -static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
> > +static int kcov_mmap_error(int err)
> > +{
> > +	pr_warn_once("kcov: vm_insert_page() failed\n");
> > +	return err;
> > +}
> > +
> > +static int kcov_mmap_prepare(struct vm_area_desc *desc)
> >  {
> >  	int res = 0;
> > -	struct kcov *kcov = vma->vm_file->private_data;
> > -	unsigned long size, off;
> > -	struct page *page;
> > +	struct kcov *kcov = desc->file->private_data;
> > +	unsigned long size, nr_pages, i;
> > +	struct page **pages;
> >  	unsigned long flags;
> >
> >  	spin_lock_irqsave(&kcov->lock, flags);
> >  	size = kcov->size * sizeof(unsigned long);
> > -	if (kcov->area == NULL || vma->vm_pgoff != 0 ||
> > -	    vma->vm_end - vma->vm_start != size) {
> > +	if (kcov->area == NULL || desc->pgoff != 0 ||
> > +	    vma_desc_size(desc) != size) {
> >  		res = -EINVAL;
> >  		goto exit;
> >  	}
> >  	spin_unlock_irqrestore(&kcov->lock, flags);
> > -	vm_flags_set(vma, VM_DONTEXPAND);
> > -	for (off = 0; off < size; off += PAGE_SIZE) {
> > -		page = vmalloc_to_page(kcov->area + off);
> > -		res = vm_insert_page(vma, vma->vm_start + off, page);
> > -		if (res) {
> > -			pr_warn_once("kcov: vm_insert_page() failed\n");
> > -			return res;
> > -		}
> > -	}
> > +
> > +	desc->vm_flags |= VM_DONTEXPAND;
> > +	nr_pages = size >> PAGE_SHIFT;
> > +
> > +	pages = mmap_action_mixedmap_pages(&desc->action, desc->start,
> > +					   nr_pages);
>
> Hi Lorenzo,
>
> Not sure if it belongs here before the EINVAL tests, but it looks like
> kcov->size doesn't have any page alignment.  I think size could be
> 4000 bytes other unaligned values, so nr_pages should round up.

Thanks, you may well be right, but but this series has been respun and I no
longer touch kcov. :)

Am at v4 now -
https://lore.kernel.org/linux-mm/cover.1758135681.git.lorenzo.stoakes@oracle.com/
- apologies for the quick turnaround but going to kernel recipes soon and then
on vacation so wanted to get this wrapped up!

>
> -chris

Cheers, Lorenzo

