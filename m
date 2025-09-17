Return-Path: <linux-fsdevel+bounces-61991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4B8B817E7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BBCB322B29
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3241336295;
	Wed, 17 Sep 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ddDacGpH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qMkwnXLL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6142321298;
	Wed, 17 Sep 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136343; cv=fail; b=NDsWJiileWMsFQWc+fyHuAOHFCsqyUmW+RWOJ6+pQUviEUiFIzGFNm/0uueNrubPfNxg9IDZzHKCAWSGH319X65hrH2QGajK6QtAOvZW7pihB773XjEILiPh/tGN3pptOtZxPopS49LUWLHS2oW8wYuQ21U0L3vvddSb7TOlEGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136343; c=relaxed/simple;
	bh=+YXbU+V+3RsOzkxrjcID3+UxB0edH6sjaNSe56/JePs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q4sjuhpO384G/s8Vm5GPvOC85nYMReZEzb+g1N3YxTyY3gWoJdc6TjKxg9c/tMdGx1NVO/996Ecdk7Kf6+Mhjw+MsTEagB10QkxUtuzOvWiAWhVmz6dwuCPN/O1Fn9ST7GZlumYh+O9Md49wWxUNOQJ0MEeLYLj/HAAOqc0HnDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ddDacGpH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qMkwnXLL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEITuh008296;
	Wed, 17 Sep 2025 19:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=t74fB1rLq63mz3sL6A47wt/uIDjXLjx7Gbd52PfTYGk=; b=
	ddDacGpH2hdVMs5Bf3GSC5mg5waxe9tTULs7i1kCn51HMV54eZM6O8BS9Fsw1ljK
	nlDaYLJXGnrgh0ClPZNQTgLSIBFQHa6pPlmbNkosF/6zXDUzLb6qfQAfsFGYdkfh
	x4oLgHr2I+nynnt0gIvIRkDtJCv3KklAbAZVqXcZDCAoSSDyHiNPyFpeP5etYDR6
	mwvPwuE0FRhpKd3lPqeuZad58N1dHMDMfegfoBqH8ggFSR50HILbphBSvInb67Fp
	OIb/dsSefSOI/rDyXb+m6gV5onP7ShlQ+AthGYDTY2D3u5CjQcRl1Bk6B9/57pM5
	uxhwYyWz2U/iR0N30I579g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8hxn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHmk6W001628;
	Wed, 17 Sep 2025 19:11:34 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2edr1x-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfk03IvahQlgqe5cYBOCTzP1tdjTWbhRTssW+GFJqSI6Q92de8wS9U7F1oyZhTIkpaApmtruSVpc63k2AQ/WyB9s7uexW6ZrgY+fk7R2mQet5nAsyzJImlCX7aWZFFVAronnkxxlRpkOsPUvdb3ds7YON5zjr4S0YtfyPR3o88avX4kJjduuC3oKCwnIaZizn+7U5iMbFur3oHhajZiGsdyv1Bm74R7/kqmGEpUiSPUYSPmcYo9F77HKPH5BmYbqUvgKG/tK4LGzfz/rj9M8z8JLQcYUXOBdoAmfZxQcYPpsQ9dBhnEUhkFKz4K6TbrYPrl0cQWk5uH5web/azz0rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t74fB1rLq63mz3sL6A47wt/uIDjXLjx7Gbd52PfTYGk=;
 b=eCyWEF+njhN2FBXemQFG2j9RGgfuLuwo0OxRq/Kezlu02f6Jp8TZF1jdOuVQ7TPOD0gcwXNULMwf/uGxe1n80I6whXFt+K23Tbw5X2eXrvA+urL1kt46qaUbHvPsBrcaldwSyw1wm+GHzVjE7RPlucmNk9ZYBLsejDIjVJM9MIzUafYb9q86M0w/BrFTrO2xQGBfeKC5N220T9U0UeGiq+mlnRGBEoQPLqaHToOcxTfwM2wg5KAquVzgxqqahKmaWH/+v/bxgj5VfHdnPaUD90QZBJiiSlg6TAWGrgdW9ZY1ruoepzy/o/cwHBMzojBQeb9jVeAz+AAoIu5zdxbH5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t74fB1rLq63mz3sL6A47wt/uIDjXLjx7Gbd52PfTYGk=;
 b=qMkwnXLL37lPhaOhyJdnefmT9H94bst5Cfsl0k4EwmaiYTqwho1XNJ7sL/k8JXaei3bqtvXsFzL/Bgy+raoh41jnaMsu4X4Dkuyile7++AJZ95hspZvoyzXN8xNR2pKEXTeti5GwiUZ3o486tgXw26BGlaDD0hZrXnX7zuLfAEM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 19:11:29 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:29 +0000
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
Subject: [PATCH v4 04/14] relay: update relay to use mmap_prepare
Date: Wed, 17 Sep 2025 20:11:06 +0100
Message-ID: <4b2c7517603debcc40be1e2274215eba2bfc6d40.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0064.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ae5105-73f9-4e78-98e7-08ddf61e019a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wS480CAhrsMHrs+iZ5DkjFfLJ45FhN0IvPpZ+NuRL8UqoKdy6XShKavWjFk1?=
 =?us-ascii?Q?9HBM8ygUiuOuEljHg6pTPza/nda0lUl3gvtWoRf0eShpix+FKpza/f/YF9VE?=
 =?us-ascii?Q?a7zVPh4Jac5aPGmToNXyG9iLk1XKAFYytIUQ7EnC8DbWfYsE8pA8/rpP0PjX?=
 =?us-ascii?Q?HaTKRZGDwwTO4aaHzPk1zTnj8AqRcjsZoLqPe8HTuTOgGBSLzx5FG5HlYLD/?=
 =?us-ascii?Q?nWk75pxw3rLUpxTtpcyKY/8BKhOgNsaHGA9JKmtDiedPSI6xwF61eC1wpQb1?=
 =?us-ascii?Q?k3DHbZeXuZC8BdxLcnz/FEQ3hna528RdGRbmx8FWztfW7XcyfFER7hYLcOgm?=
 =?us-ascii?Q?6tOBD7gArW/R0MheaCWcIeYyEvKOrCWwiTU3ciK1FM1oiWFUgjOiMvUwIbxe?=
 =?us-ascii?Q?QDkQ26XfNCwxvYpmumwWVKcrFROX87QxOc85NcQghVrpaOxNNJtpqdtpNXo8?=
 =?us-ascii?Q?+NLxDIg5tuFrRHE2tGqTwcH1QR8TnBK1cOSKNqBesW9RpSaQ8PYq9DunNgzZ?=
 =?us-ascii?Q?XGX1odWIJcrjr7zqSRSSeHxnuTUCiU8cHwYqfByC+PBgdQ00Fl+BqF2ktqp3?=
 =?us-ascii?Q?CUurPOUsc2mReekXFNxt78vBNg/tzVsbuDYleikApog4x4FTG4puP6lzFD/T?=
 =?us-ascii?Q?D1ptgZFjG8FK3QCRzCZ2lo/l6qYFPC4CrxvTgVrAGg5e9+c/qAKRsBnbOyJe?=
 =?us-ascii?Q?5Vrl4M701qMtkW/ez1Q+2utqXi8SwKivIojRk1jVClB8MnFaMj14PM3h2nDb?=
 =?us-ascii?Q?7Ikxwhf2ONd8bnzmPsCymxFsC488/+XsSQ6+u3vQKrgGbjf7K3QchwXH1rID?=
 =?us-ascii?Q?4uwKzbZnHUJk7bu+9oOAde0979+Cmu1pOnD6pJKdTsZhfzVqLSoNe4Mie68e?=
 =?us-ascii?Q?uUk555caI3Gykyv9Rk7iFXcdGEVZac+b7qFcUC73/pR3UVl5C+DhCwK/sexx?=
 =?us-ascii?Q?/S7v0++IpB3IZqb7B2ojeDo65H40FEgXLl787TbB/TPpldhiVDIMQAme9l/O?=
 =?us-ascii?Q?RlyHjs4jyfVuiBzDRpFDd/qpSfoPKgu5196apeEcU8ws/nMdhcLTltjDDBHT?=
 =?us-ascii?Q?3K8/09asaNR3LSmtiKN5wnZH/xf/eKKujh2EyMXpvnWkFcmdfdgGufbdRDJd?=
 =?us-ascii?Q?+f2fUhnNCsN7KGgwLLVqI3VAM24zCMm7HvlWr18EUXULNbPnjX1XbuNRNQsH?=
 =?us-ascii?Q?MybGxL5G/+3iBYcAh6Visqm6BHEPG7hsP5Q+0LHnjjKk/T90UrDwOdhXDZUE?=
 =?us-ascii?Q?wy2mf1D+5rnEcLAPNStXUyvYEedmhw6qjMIRkdbLgvX+EczJ7ptqqIBOlI/j?=
 =?us-ascii?Q?ja00tpXSAnsnqhiftu3vxbezqif3kd4r43uXNMzPVzO7YzgIqxW93AvYMJXb?=
 =?us-ascii?Q?5nFvFX9pmVTdNSYs1lhr6NRGFDvjI5vemtYQMH7VIrg6evq1bQg7IQphbX6R?=
 =?us-ascii?Q?/dGDKDy6m8Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5SW3oC3tPdM5NZDekb65dmPrjyvIGeeI1WliCCqbKlozxjkuMcpPg3mq4D+8?=
 =?us-ascii?Q?uccLNOj1/N/THSI6TD6bUlPqpEc+1JU/y/iqfNfq/XcAvsL3KA2hMr9a4G72?=
 =?us-ascii?Q?PdERFPrb4LhfsVBhMfm2PUpQ0KSeEsSa13eHtcnFU4ntVWcqQdywCunhnIst?=
 =?us-ascii?Q?QP32IoMDlBzptcDedp+3UaZlsCJDxkCJ+tVTvMAfxPIhaJxO7coG4pmEfFo3?=
 =?us-ascii?Q?RV7l5FlF6k0GlAXXtwdJsEvw8l1y+Z337b4EJ+dJeHh8PlHIBBBVlrPpkNRv?=
 =?us-ascii?Q?tDaHAd8gEO3DLvaE3LHkB+ezluMA0ALKNDeM2kYKwvKcnjuCFlyq49IF9h6X?=
 =?us-ascii?Q?on0Pb8qHcosIsnobppCbyq1zIN5k4GYmI7BlWCxd1lW8eNk/uBpiGSs1JZMi?=
 =?us-ascii?Q?nCzG8Es06GdCgFuaYSHP2QjmLJWj/5TmxD6pSu89ziyNgME9AcZuWgfQqKk7?=
 =?us-ascii?Q?cyb/JN7YynDQl8pTUOb2NHJX3RlsfiUN3ta4GoNNIt7rNLgIvW0mxnvjwF46?=
 =?us-ascii?Q?D9MULkYoziYtg0BwSJLEWQVfYmosVtbeHTxaDamuh6/6Ek1c6BC3SKq3U1zP?=
 =?us-ascii?Q?xq6WRTxYOlhM//4GamsKANS+yTb8+HtPUPmUCO7CBoyqXUoDy4ilPLCbw2DU?=
 =?us-ascii?Q?eOZOf9nF/GKESiO2OPwIgSFF3qY26xyAh5C4btv63Ip2cIsN2goDyRAL7Xvm?=
 =?us-ascii?Q?vGafMedCaqOT/u23qJFxz2+rcVf4LKyFjlL5dfFzcVt/BDbIY/FDEGjfASQe?=
 =?us-ascii?Q?hzLukDYIVXdJjzAO15g9imI61v+tKyh1lvadqqsyr51CdgE8xiC2mIs0do4a?=
 =?us-ascii?Q?E7yLIltZp7ozhATTKKOAZRb/v+u2fcgEMJOLwPYenmE7liSZj65YmqI0m5Uv?=
 =?us-ascii?Q?SHGKNqY5zXM51RhdHkrNU/imNFewURguvPiWxiB3ImFaNIvb5jWVOpTMgdfI?=
 =?us-ascii?Q?Ky2N+ZH3E4NpS1gZR9ysIcjPNC/BFYvnMrjGROxgii3PtoUDg4LFz3g6WzwX?=
 =?us-ascii?Q?F4m6+pM9NRWfAYAmZVYljvnnntwKpn3FfN7m+vedaqMncLbXkyvSOdZjxFSX?=
 =?us-ascii?Q?mtmAUNjsOgg4qcMUFH3TOUVksCFPOD5TIGDGE8XRpWG4ZtjWIRz3LLtdEkE5?=
 =?us-ascii?Q?Y5RyWqYAeVhWKBgfCic3ZMexq6UkgXwWvzKZh77kHxifVjKyaimG83NqGhcM?=
 =?us-ascii?Q?Ir76+tdsCO9TgPsptu3NonPCYgrzG78djw5kE5sDfOeMo/4JoTf5PST/BwRR?=
 =?us-ascii?Q?XOZ2Mrrf9EMpKoyxc8mtZy/B/C7xTtgYC39gR8f61a8YYjDlrYq1wsM9LHns?=
 =?us-ascii?Q?lUvZGa7nxoAjw6AORmJlNrPqrtAcHOFgJ6eSeE2WSFXwxVtb2hoe2frEW7CS?=
 =?us-ascii?Q?Gbqga7uejyRNyS02PFl4kfrktlQOsTaLEv7/C+DEis42ndRB5oRm+Lt5v70X?=
 =?us-ascii?Q?G5x1RdHf1keEtR9Pj86v3/RGCUkk5zBWs4W3iXFiGviMYInEkzkRcm05BmJX?=
 =?us-ascii?Q?rfxkp2RZwsL8jDwD3QJ0oUIhGKhda4QzC+GpbfdSvfmnAW2n1LsdFOlLtx20?=
 =?us-ascii?Q?GNPCIkBXndXzlmOMrJdH99G5m0Dti1zE19tk/aYbl6aPwsWqWLNtA/GUydOn?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U5i6b89eS8cABuaD/XxI/mQcQJ7EjjpFdu+yATFO+wxldvh+B7vQwQkNh/bPn164DzaEABfTQLSnQu6bqfgmk8zBD2qIymikQAxjJSj+WXrpWG1sDCV0NHq0Hk/EyondTNzi+wwzz/VRlZJCpVEB7p7buTe78f3Z+phJ61tajoPgis4p7b5xu3hu8uguUtgiFtIw7xnojOJWaORoheYYLS4K1uxMLD9SpXwF82tPxRIu4U4IZLj54opeskWFjr4kcjrY/h9ztnkhiBPecrG+9orpjgJO7+13NiT0SmA19BgBFIbi4CyXzFcRDWYa2FYHrrg6YErdlN7JsqVcLsohTnPYQYoFtLDwP7cxydpxvd+kQ+YbmMW1IKo7Dkk5J6ghAwpC3lq7wKclxfCgzi5BMGKQwCaRJnH/hoRK7AlJvsqdEEvQHVPUA4eKsXQt2CoCI3JBnjzYL03/UO8G8r1urwozPs1d+9DoLS6JjNkqxjmhrFdlgXJ68JnYVTk5/qTNYKCWLHO46osKIIqILlaFRCZEsOY2bEFJMp+j1fsm10a4S40ln23aE75WoPajEZ+tGs/SbFwfT82/TTERTat5J8/FfULCkNwwEFJQPo+/hHc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ae5105-73f9-4e78-98e7-08ddf61e019a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:29.3423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzijCH0599ZRGVnWevj1rLG+Yx/m91lK2WOtGRX4re1V+wO+2DJ5KAZnZ/uoxsiR6hO6zjawAuii51LIFXaT6jZYPEnS2rS7VDa7LeCvs/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170187
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cb07e8 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=kVp6y68UWkg0hX7IE8kA:9
X-Proofpoint-ORIG-GUID: 8pziynDq8CuVUX1FpSB2XA2xTpUgbd5T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX+Erq8Xp2XE7o
 +Ne0q3FVoGjGyDxm1kLYYYDtYGW8k1xDHG3czOK7MJZOlog4+EoGF5pgpv1UezQQeyBegdVXZCe
 ZdcFNzU6nDUMVuFWbpMZrvV2AZ5TVZgL/W/J+w4ufbxz61/ludnx0hqM8JPdBrcXIrR1UjL6Crt
 MbgJy8iZbTR+qQh+g3kRFTTqofQ9yfmlN9vFNbroIRI3DyJGui/s8tlh5GWje+FCHbJFtYmR/23
 geIGtjA2RWePVYKnWOH1lYHj8k+f1NvSHFUfl/R6ki+Nv4LtxhrsxGbn9statFLOXGnlRCFbwE7
 L/43aijA1+EIp/+ta9n2Uypn54x3SuHdGUMvD7iVWTyP+Vk92CzR4vN0D36WdrVIDhLaUBfsnPW
 nrScMpqz
X-Proofpoint-GUID: 8pziynDq8CuVUX1FpSB2XA2xTpUgbd5T

It is relatively trivial to update this code to use the f_op->mmap_prepare
hook in favour of the deprecated f_op->mmap hook, so do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
---
 kernel/relay.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/kernel/relay.c b/kernel/relay.c
index 8d915fe98198..e36f6b926f7f 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -72,17 +72,18 @@ static void relay_free_page_array(struct page **array)
 }
 
 /**
- *	relay_mmap_buf: - mmap channel buffer to process address space
- *	@buf: relay channel buffer
- *	@vma: vm_area_struct describing memory to be mapped
+ *	relay_mmap_prepare_buf: - mmap channel buffer to process address space
+ *	@buf: the relay channel buffer
+ *	@desc: describing what to map
  *
  *	Returns 0 if ok, negative on error
  *
  *	Caller should already have grabbed mmap_lock.
  */
-static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
+static int relay_mmap_prepare_buf(struct rchan_buf *buf,
+				  struct vm_area_desc *desc)
 {
-	unsigned long length = vma->vm_end - vma->vm_start;
+	unsigned long length = vma_desc_size(desc);
 
 	if (!buf)
 		return -EBADF;
@@ -90,9 +91,9 @@ static int relay_mmap_buf(struct rchan_buf *buf, struct vm_area_struct *vma)
 	if (length != (unsigned long)buf->chan->alloc_size)
 		return -EINVAL;
 
-	vma->vm_ops = &relay_file_mmap_ops;
-	vm_flags_set(vma, VM_DONTEXPAND);
-	vma->vm_private_data = buf;
+	desc->vm_ops = &relay_file_mmap_ops;
+	desc->vm_flags |= VM_DONTEXPAND;
+	desc->private_data = buf;
 
 	return 0;
 }
@@ -749,16 +750,16 @@ static int relay_file_open(struct inode *inode, struct file *filp)
 }
 
 /**
- *	relay_file_mmap - mmap file op for relay files
- *	@filp: the file
- *	@vma: the vma describing what to map
+ *	relay_file_mmap_prepare - mmap file op for relay files
+ *	@desc: describing what to map
  *
- *	Calls upon relay_mmap_buf() to map the file into user space.
+ *	Calls upon relay_mmap_prepare_buf() to map the file into user space.
  */
-static int relay_file_mmap(struct file *filp, struct vm_area_struct *vma)
+static int relay_file_mmap_prepare(struct vm_area_desc *desc)
 {
-	struct rchan_buf *buf = filp->private_data;
-	return relay_mmap_buf(buf, vma);
+	struct rchan_buf *buf = desc->file->private_data;
+
+	return relay_mmap_prepare_buf(buf, desc);
 }
 
 /**
@@ -1006,7 +1007,7 @@ static ssize_t relay_file_read(struct file *filp,
 const struct file_operations relay_file_operations = {
 	.open		= relay_file_open,
 	.poll		= relay_file_poll,
-	.mmap		= relay_file_mmap,
+	.mmap_prepare	= relay_file_mmap_prepare,
 	.read		= relay_file_read,
 	.release	= relay_file_release,
 };
-- 
2.51.0


