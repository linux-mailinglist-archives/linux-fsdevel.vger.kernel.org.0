Return-Path: <linux-fsdevel+bounces-60559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B8B4936E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B493A98DC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653132FAC0B;
	Mon,  8 Sep 2025 15:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SFvLQco6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Te6apsDp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4E330DED4;
	Mon,  8 Sep 2025 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345408; cv=fail; b=juVdFbdvyqNwmVpEuXzTAzmUIPiF2lT9K5uqDK8gkO43CcC2fFDhXuJBDSAPvWwU8uPPrQ2o9DApLTdHPgAUnFMgLhhOA45Uw84jz6W0IU4cFMjr2bIuwupFKrXCH4IJCx5veb5Hy/giwEDrx4QWDNnEJfNGwfT1PMcnZrOY9DA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345408; c=relaxed/simple;
	bh=/aJ7MaalIE4vtmfq16saILTkbQCcztv2EhUCvGpoEO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WiGGKqzQXMcVOzF8Fi9eZMyErKpkvkawp+8vkkpUW62h2zgY+Ks7RcOlS5B8eyXAyNMMmUXiCbE+5wVgURJrSJ3K0mzZftlTmhBrzuZKIU5XYvY8rCYX1nzOguXt63is5hPrqqQemIS7aqVJcLGjlGxsuNypgiJ2a1zRq7KN9rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SFvLQco6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Te6apsDp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588E1tnk017874;
	Mon, 8 Sep 2025 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=/aJ7MaalIE4vtmfq16
	saILTkbQCcztv2EhUCvGpoEO4=; b=SFvLQco6ilB7UUbYMm7WZ/HC+QxagsykoG
	wMJQ0X8AV4I+FYVheYo7mTQ4+NlFvD7t54bfW4X26JwHtUaXIJSvlGovPMXYplpq
	RrDL0X1t3COtKXjIVnBgSekblkN4vhgyyVtWmmCfD6l8998jQPt9Rtv7s3A4XBcC
	Mkf2QQboKqEd3hKzJErAlFqwKh5Txm/BY68h20lRZYWF3kmERf0nbUqD/lDb+kAc
	t1VhHtgPjvjZ4UjLB/4TvmyrOEqk2Xq9PFhuDcMlmSSdI+i78hPTPIL7TIXyK67V
	csQ2rh+nENXaTLQ9nOvnT0AlQWZRCuXcjkcavwC989EDRwUhVjaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491yx6rabe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:29:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588Es9HA002957;
	Mon, 8 Sep 2025 15:29:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdevj8n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:29:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nu4Z+0sjTLYAwpaLlnbGj9jQtq2h+Jb/W3gd6TpsxC6vjbjkMdymNFE7b+1E+K2QA7cZASIDdddn7UCaSVXTIoDw9QskRwpiAastiGV3PGpVYGCsGkyZBJ/IE+rrqH6/jXcrr9c8pv5GpFSl2cPLhWetzmw09UGz+qOqD07qCETPHAIExXTua2aq/Z7p/Id6BUxODOQrrwmvrNF21VlfWyvBWe9panXE15iRdq7+6S0w2FBdVbPG9ywa+Fel5AuPwjiHaMIzdB3/ndAz4CzrR7FCGvG2VTbvbdG3yV8VUkZ4EyhaFOhG+FS3Fg1ot1KephnRKLSqpkKv9xRDJ209ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aJ7MaalIE4vtmfq16saILTkbQCcztv2EhUCvGpoEO4=;
 b=n0bGgpeoJ3s8KayJdmKhNMrCKDg/LRjyHwCtc4IsHK9XCPSA0F24/s8cjH/TpybCe1QIgULMgRvmg1S/voKJez3PuKg9+btPNUQL2z4dpHfhc6+wleVbHMPTU8+FK6X71OqwIm/yy2nWS1F52sa5+1jkCBbiadF+4tVD054R3o5lpWH2u/4SbkHAexG/6vBoAaNnrS/0mt5R9W3IOSudlrGm9WbuVqfMnuJm3sOXvuaMHK3HKs28FvKVgIh+nu2d0q5qlIO6Fwh1VVQviL0Q2yr4IuCsigFQmC7DoI6iX3lAdUCR/Sdz5hyTNF6iy4/BrJsCgkQ6Ttf7YSrv5n4NYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aJ7MaalIE4vtmfq16saILTkbQCcztv2EhUCvGpoEO4=;
 b=Te6apsDpL+jS7sGApX9l/vxP9oeoZIEDErfAJbha0GSAQO8kkZA4E74LD81VzSaRjfY5MA6034WWz2MLr3lwwGsFV08v6yIgMgdSdDUibLjVfHeRkfMElnhfRdyR+F9Y7B8W4xh3igI7fIOoi+ynz+615XN8u0D6zl5TPXYR4mw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5214.namprd10.prod.outlook.com (2603:10b6:5:3a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Mon, 8 Sep
 2025 15:29:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 15:29:23 +0000
Date: Mon, 8 Sep 2025 16:29:21 +0100
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
Subject: Re: [PATCH 04/16] relay: update relay to use mmap_prepare
Message-ID: <4ff77411-f760-4837-b5ab-24b4e181dcaa@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <9cfe531c6d250665dfae940afdb54c9bd2e9ba37.1757329751.git.lorenzo.stoakes@oracle.com>
 <e9b9b4f4-8ed1-40e8-8b49-22a0b10c72e6@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9b9b4f4-8ed1-40e8-8b49-22a0b10c72e6@redhat.com>
X-ClientProxiedBy: LO4P123CA0170.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5214:EE_
X-MS-Office365-Filtering-Correlation-Id: ffe4ad9c-e35a-45ef-c386-08ddeeec7d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Auhg6WnS42YFUmgqzkWNjiUJffFttrbrqnY+z44fISUfBnE4bOF41yXyy4I4?=
 =?us-ascii?Q?0IXHYi21i0CNyeGD6gMoBIak7hLvi9CriSoSpbZPZ6cTfSdLd/9pQggwqKQu?=
 =?us-ascii?Q?qMPpV7Ei9QRQ51G5exUqAxH6im2a8jmA+BQdGsJMVR8Wn7EN40bAs/JE4BRS?=
 =?us-ascii?Q?mNsbV6NEZb06xGcHadn5K8Sv0bFEjifBENIEjtPfTfXOVJMeLX/jlde5mvBs?=
 =?us-ascii?Q?lXIcHZZiNsbn6x1V7ZJJ6m+q5koHxkEXS3Zaoz+P70INxcYcTtPwgzWTSylH?=
 =?us-ascii?Q?pfSnBy5iGE/y3RZhmWZLF4MdlmQpKIv0T40y7vfV2ir+jbQSjBjwG9cUasWu?=
 =?us-ascii?Q?FGfeN8Qevu4sReNtoKP8trtlRpOlzuDgHzfz0us7TVwzvC7uPnfSN/PUBj98?=
 =?us-ascii?Q?GAvvEo0Ctgim26zyHCkltcYgLi29o5cDyazcMNNx2SDroakXLgrnqpI6/T1T?=
 =?us-ascii?Q?gs8kwMwkWb6UUaXGU1IV+ikmC4LxSAGERoNlc4wq7uwi5M5jRD/3ozWO9pcB?=
 =?us-ascii?Q?WuNQxcUhfHCgiIhIAYRXdvXm9X6QRxBJDLDu92WYPLe+xhBjks2P6jGAegUO?=
 =?us-ascii?Q?XZnMFS4zA4WjWIRA/5GDiodkGrOu486jBHxaw3k7bC8xMIkEzL6FELOEnKrw?=
 =?us-ascii?Q?J51D79gPOIVnLN4WqRjmlO6AmLW35m4OHtfWOZUOlGXMLgfNl2ZGZWujtsGP?=
 =?us-ascii?Q?Ttj44o1Id6OcqYs7KSUlaVyaX0vFaSRZ3im3FlABStpvHSMaHWzWl1Zexvid?=
 =?us-ascii?Q?ojmSPIPC/sawXhJyIkgemijpu7wpraKv9pN3ZzvDaWy34WTZ2r5LbPxEGwhS?=
 =?us-ascii?Q?6HWoSntVLiVONqvdmtM0MgyJud5wcMWzhhLvikcUYGHgGtkOyczbGRDh3Msv?=
 =?us-ascii?Q?KCH4y9TRE9Emip5Wdrg3/xEvGmtm8+FTGeGZBMfd3sOdmUCPzvNvNsp3/1hs?=
 =?us-ascii?Q?yR5OLeREAjTpEowpX+d7+xFaR879Q8B9HF1TLah2BoUi6GoO6psmq6K9kxHZ?=
 =?us-ascii?Q?hU82rZU/LZdRaMw8Xzr36EfUrdb6DrsCLd3bxpBvCftg49sPK+8dpuitXZgv?=
 =?us-ascii?Q?BH+u4SDhYze+ezfeEcpIj2uhF/TLps1kYfqeYva9Ukk25nmGqnkUX+Y3wuXE?=
 =?us-ascii?Q?qUj/v+Xr4XFVMF9Oa937dlgIzpFUU/hoYjqyxIN7A/1QRjyooSi8pZfw9tLo?=
 =?us-ascii?Q?7Tyts9t+Jf2E6Pbp5g8onq2ehQy0nH5qSdvUKrs1mjtH3Ms4jAmvwmopuxFd?=
 =?us-ascii?Q?zAQ7dqCEzQvDfXS6dy4wD5Pps2TwbzVxNduWGYiQ6QIV2YvLMCWUkFtUYQTw?=
 =?us-ascii?Q?1/cfKyjfRIWYocb0Iv81/GDr2zUkLZiBugQah/B5RVYQUIN8s2VWaEOYc65e?=
 =?us-ascii?Q?xMjo9Kr4DywE6Ho5nyyC1N3akM++XGWcnG1aqMSn6Rr3R3JdEF8pG0YY2ptM?=
 =?us-ascii?Q?GIXgBv6rNqk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DaDOTvnLRPB54zVyfs/PVrYYXoe0A8yUkPIQKXUm2x5S0apimVe760+qjU5j?=
 =?us-ascii?Q?ZFOCCMOk1SJpdZafQuLny/9LaQViZTlqpTc9Qn4uegEBgZHE87mxUJ0x6KzN?=
 =?us-ascii?Q?lsJAkp9Vn78/KMA8GGGwttCa4m43/ocCVGEZMWHC49cHY6KmZ9N1BfIGGCdm?=
 =?us-ascii?Q?zoheguBqOOqmOT7mS3vjRcf+1XraG0aO7at1qZhEa2v/oijhfG8z016HJNhp?=
 =?us-ascii?Q?t0mKwUfOBTmbFyCjHj1WLTGJYwmpK6chPX3QlOu/KUhltGvokUvknSrjqolh?=
 =?us-ascii?Q?ikUgGuZaUhzdRGo8qOHkF7SYvjjLhI8oFHJasppwnim6P7BlH/KWmAVaAZVJ?=
 =?us-ascii?Q?mYMeM+EHSINXmzWR8Jja+VY/yTBsiYLX7c28NcI/eJ1+FSwgy2GqIy/Q3IJB?=
 =?us-ascii?Q?dAZ7Prfnk5wRyqG8SqlQ/dcxU+cAodUQwzbUYDD6LQWGd4/b5jm+uYwWeMTm?=
 =?us-ascii?Q?gJZwuPR1EgiToQdszWVfsVdx7IvflhhqSaILKC8chiI2Oc7qUsgyJTR8qduv?=
 =?us-ascii?Q?38eAHHa9op46IiiXFVZHMStBq23g6eWIYjTWINnzeDfe9l2DS+p8Ntb0L8iT?=
 =?us-ascii?Q?owHRD6VOEVZVZZYAylcVuo9BryHUQscNsNNYDL++CLkAJqFcnB7+S5ARP4E4?=
 =?us-ascii?Q?L1vBNdUh2/7pPGxvRvY0vH+YrwBT0OdT5PWIch0PzDJ2o4dP5f0hyuaxCBof?=
 =?us-ascii?Q?yTH0wLBW6azewWoCnoWQbScRr9Oc1z014WkQeEGJCz5JO9YfpbdH+Pp2r6WL?=
 =?us-ascii?Q?c9GtC+fPw29jTSsPogNAP3rrO26RJscajUIQ2a9/geLOzMzinuomZIYvaYjF?=
 =?us-ascii?Q?Wh4CldJz3jVNI/aN3U5u74PBUckm0H7wIGF7XV6G8j/VRGbyTayMseN8kXes?=
 =?us-ascii?Q?mmflHiHEVlQSJ2qJq3j5DDuj53FWdfzpvU7hWd4NBVU6Z0jvk3sg5RfvvMWm?=
 =?us-ascii?Q?3UxtNnf8PbUB/OjigA9teI11Q06lrwRuhIbScpkb1KN4TyVdvRIr2cdj6/6X?=
 =?us-ascii?Q?3LvC8LqBUcPK+IYU2q2bipoqsHOp3sqUlJMK8r74/X9vGdX4Ln4pRIhVzMiK?=
 =?us-ascii?Q?TtrY/EvupfNSR1NzZGuqvKJmUsFq2z0OJ04rXrw7Img0Xr8zH/SuvmG1eGlP?=
 =?us-ascii?Q?GH1TDCXf42bnC7KGzEK+dmhOz1P+6yhlvnvVBtxW94kqdIbfgKlmS9VYhtvH?=
 =?us-ascii?Q?Q44zGqCOyBI3kW9r2RjUcuiZSFkZo3poa4rTUdvxkt+LuMVjV7UL4qT8nj9m?=
 =?us-ascii?Q?NMohIYqhJq+ehFzxKCKOxqaIC1mwpVOu7nzlEhoE+ok/Ad+burOj9Ti35V83?=
 =?us-ascii?Q?RHooyFYv8wACUh7WJGlm5ta6SueLHkWTr9xSdgvV4bmltTWuZUotdf64cOOw?=
 =?us-ascii?Q?vuFPpn4eAkflunhZZ0mzPAphi3hzSHppVrWOlwnBagNzo7kjLYvR+iCvcEHa?=
 =?us-ascii?Q?TVyZwcq4XSp4PM/M637MvD49V+C8ZlMyCU6sFkHnqWxfpOZEuYBOV4lJHxgM?=
 =?us-ascii?Q?fuu+5qqYJt9wQ+QXcry15SRrM9nOiZHpGKbLz651ML41QYl9m4CiAAA7VCbt?=
 =?us-ascii?Q?D+S9Ygun1MnPnU4tya49TzA01tcOd5Q/gMgF92j4LLc403e9oezucU8Y447V?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lJpGcq4XNcFO4EDb17CKV6I+n+cHBAJ1tlqTOB8k90OL2MBdEkyUDd88TgjCnFAfdeMG5ONGQMpoi9FL8NtHQMb2cWQAqyDnwi2iA2Bby20sjt8//BFulfiJnJEfdv9P3178E/vyVqI51QBVqt4QkF74vEqM5XtHnZp3jMqe/oJGxLE5AIAIr2dQSaUy/HAgvqgt7W7d5hV3RgsfoXCVBHNwKuoSY9JX9kgle/IE7nH70Z6t8z6XtNRDCdN9VPMoDhvi7p4CJ4qrEXNYPcwEPK8AHGTabCa6IZ8xSeT3V2P9V1G3tcFL+0BQEmdWyHzv/pvBstb8YI9rjGHluk7DuKfc5K5nsv/ZBXpBBQU5/0ZG2uzzc550a4AqZtMds43YfZ+xAwlupRqHE1f9vrztGUo040Z7nrlB8DrRLMLuFF6MIRhnXYwPg7Kw+rtf2O+i3rhscYnYimFKALPHypsYTCcwByKL+566I3yEQqMQ0CsiVHOMEHbEyaNXD2VyRmVf+nhBUGRDc0pPiFIdruqy2YITE0bQt4vyWF6j2/ideOQVrzyg87EUiAFRgQ/VoH0aIY1pqjg3AHVEe/68766J7HpflVhQu5dWVWK+QXMg4Ok=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffe4ad9c-e35a-45ef-c386-08ddeeec7d3d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:29:23.8018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WNU7gTCbz4oDjO1rb87/HHjTWxiqDW2E/hvcfAvJNUTA6P3iq0ragIiICoWyjC50i/2wIgcTo7k0Db5KOHFnK52OgTSFqgdVXjOhAQGQNFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080153
X-Authority-Analysis: v=2.4 cv=SaP3duRu c=1 sm=1 tr=0 ts=68bef659 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=W5T_QLJ0vP-x9Pfon6UA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: fIKLBgMxq1uWnp09MlV3wsW5G_6I3kG_
X-Proofpoint-GUID: fIKLBgMxq1uWnp09MlV3wsW5G_6I3kG_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEzMyBTYWx0ZWRfX7OAvJN+91qlR
 DfCEdQxmTglbt6sfX27bvW6r4Wd8DgXzjwOLEkXxgwgYYuasPuBT7EgserC763ojbVmS/tPq4y9
 4qxn3WOKOhS5ig/Dh98zwzlykNw5uD6PKYQvq30Z+BBm4ihKb/0KxD8C1obbCc5FwkpxIN9zW48
 HS8Wx2Yk2BYG8Cy8dd9He7kU4kTokAaEOujpfTMeDoRLccBUro4pbyMEokKJQXEgcSwsZUiOOuO
 pQG84V5rYq0BeMLTxH5StGGxRcmeXor2Rg5572nMfh3nn9sxHkWTKrYhY7hM/a69eMyh55tgv4e
 wtBje+4XMRn6Ep610728xGDdK87h4fxzq9sGUcRVCb8ln250rGJmYakqVbfuYG31JALr/fb18NP
 kmYlKwm3YHEwhwsANP4vy3CmWI0t+w==

On Mon, Sep 08, 2025 at 05:15:12PM +0200, David Hildenbrand wrote:
> On 08.09.25 13:10, Lorenzo Stoakes wrote:
> > It is relatively trivial to update this code to use the f_op->mmap_prepare
> > hook in favour of the deprecated f_op->mmap hook, so do so.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

>
> --
> Cheers
>
> David / dhildenb
>

