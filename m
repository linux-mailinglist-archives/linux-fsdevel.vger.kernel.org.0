Return-Path: <linux-fsdevel+bounces-61761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A2AB599BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3DA188656A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66436934A;
	Tue, 16 Sep 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GOuryGM4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eSJWXO9X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABE133CEB5;
	Tue, 16 Sep 2025 14:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032055; cv=fail; b=W1T9xsiVPVd70uQ7PXZF+aUcUH/dZi6Z55VwPxpskWBLgjK0GoisxlhgkbXT9kE6MlqlPEop596S80Xbs76sxEk9qF4QLPs9guE/Gu+TCKFe1z7EKwGQK2248agpFh+csPvzPeIAN0nOvNR++Q2I6fb5f41VOTGjJUZp9vqC3Kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032055; c=relaxed/simple;
	bh=EfI9m5aXmkOFfn2c/WUxOQk4evRttw9Mp5l9dAf4Lcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SJUdtmPmkJAYVeHD/nYmupLcMuUjpCiCuzJhUUui5At5bF9mGvToaAE7GDtvuIqZXvjfeG69dFDhT9vcABy2GxmyQbB9FY7dzjmCPpjkUXaggJL+xb79kmjQQ98Yx/b+C/xpgLED192Q1Vac8Yj6Fbsm01Ie8jWanH/Zo2jBtI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GOuryGM4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eSJWXO9X; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCxWoW029789;
	Tue, 16 Sep 2025 14:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ErVRX0ZRTGsQeYtNHh90Ro/bmpyObxsPVCjOGsAiAe4=; b=
	GOuryGM4WVe0T774JL5A7f/Ba7kkL8S0EgAc17/P2vVWBitlL57NKSEQ4slLVCWW
	Oew0rOT5CA3Tq230H06QzhzhoYvHVUMPahY3UvXNLGhZYCoXj+8lWcib4PU0hceM
	RRcIHkXf+TTPVjJIQL9EwO/96hIZMjfkXBv6IC5gpeTmAOUQci3qUUbABPTIRZxl
	Zxu1cmwSRuC/8gZ/4LP41f92vvyozrtoqYXgTY9mTsawrGEIP9CQRU73F1QxHZS9
	2Oo5cGs8ok4BGD9cwZpTi13QpEzm1AAqfgv3hQUSSbJ3WKxzdMJP78ZctJG68UO6
	XsC1chY0h6ZVIlqlCqoQMQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w4rb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDfijR033734;
	Tue, 16 Sep 2025 14:13:32 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ced7h-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3zy/IjYk0T6fcX2tMoeS7lutd/3E+K02/XfTVBAft52iqr1jRbhhwJAUjqz4P11nTxTQNSphQiIMXVc3Qt1wJMNarpGDyDrub/5q+AbM/sDWBLIofGhYsWQ/VFxglwNsrmLIrgPVWh5H8B9fd4qzT7qN2Lmb6gfsiL6wfvzqfIz+p/xqUABtBk4RGCZ7inOPIg5GK+0UALywXUyvqfngalLZF0UX4rhbVirHEcPfSmcAy6K0+yAn5yFU8uv2cksmGwVrUvTfWg44SxmmyLI5blP9uv7Wz/kKnNAEN2kjnHr1unB1c/zxmY8muBamhvBXKLqAHPbmlh3GYF51tRsbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ErVRX0ZRTGsQeYtNHh90Ro/bmpyObxsPVCjOGsAiAe4=;
 b=JupKmSOmXxafuT0/ZlCi80jW5uVS+UyI2Za9cpJJEtQgMLnVAQ1Qz+mnK7wI6eLc0CKjFX9CsndzIa8V80kD8uRZz9acIlvZcviJHkpYBseMpGrfEnkC6y2z/hJ2xOD3FTAhq/Yjl0kuZ6qPEB+HXqhlrajcpgXrR0N5cYmDcQcwpJkIjhyQXok7Qojo5GBBfG48aqmw/7omMqkWdisylhubliXxztEAbBkSnX+gKdQ46JvkvW2g+PqyeO3856cuNLWdwiYizGMc+PoBo0AMdm6sMcHakoU+c28YZZF/jjJL2OYOg6gOMD9nti88VvBInvcxRsRl8TmS3935iNhxjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ErVRX0ZRTGsQeYtNHh90Ro/bmpyObxsPVCjOGsAiAe4=;
 b=eSJWXO9XAvHaO1Cq6DLiHPiKNoYINO+1tXil3E5+Bb7l0irJAjDMuds1Xpna5aZc57E0crPKn/O9VMkYnV4QKpDoHaeG7tzLZHui+z/8hx1Nuxef3Opb7jFT2envSP4tabsfqZQLR9Qg1/6xa5GQ4MCeD5mtvpCZNMWFao6A4mE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:13:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:13:00 +0000
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
Subject: [PATCH v3 10/13] mm/hugetlbfs: update hugetlbfs to use mmap_prepare
Date: Tue, 16 Sep 2025 15:11:56 +0100
Message-ID: <8b191ab11c02ada286f19150e5ec3d8eae4fe7e7.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0354.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: e109353c-0954-4276-9aa4-08ddf52b2461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oMZIcsEw3LTDdvnyduiCR0jMw07Kx85lq25d9b+GuobPiNbenO3XnAOHl/Px?=
 =?us-ascii?Q?r8Oh+uVc89iTIfdjbx97nDpEjOSDVK0FNfbUles2yDQeBxNj9NVB2BDSrIh0?=
 =?us-ascii?Q?g7CwBK5UYP9CXYKrfkoWrzkVXfVDiOEdESMVUm5qhl9DfNGh14jvST9np8/Q?=
 =?us-ascii?Q?7/Eu8MHZHdxf69KAREZr+sz7lvoriDxIC6/XsF3yHdh6p8en4IdCEskTEjtk?=
 =?us-ascii?Q?JqtSvXxuCKiTnxsRrJyuw7qOjzmSC9UCAbuqZyourGKnsnpcG1KSsVAUIS9P?=
 =?us-ascii?Q?jp5LEp70gRG5m5VKKdGhyXTbQMQIVywKsKxHwIrBi6Br2UQhDhlRLayfClwJ?=
 =?us-ascii?Q?1DXKP5gUfTdH+xSJUjg0aGDUOWzbM4E0vU1MJ01rxTc1sl5oa6ZJZ3OhfAWs?=
 =?us-ascii?Q?InYz7Icp+coxQ4aMTihGGnSwKBUr6S/L3aWINmK5Ggo4biPIrRkC1w1keSwl?=
 =?us-ascii?Q?HxbO4lDjokBRDI8AKEYXjtOIvAVaWslQCx7r/bCtm9BNpR+fmatZWtDrXheT?=
 =?us-ascii?Q?bkhA3j+wt08GJle7Yi8sfa9tN9ZEarApW3r9YgkNbzHeM/P/F2OwMBwxeSOF?=
 =?us-ascii?Q?xZMkWgoAzr47++N7STFRWAnM+V07iciMfqytcreaHOZ+0rtaQQ9LI3f4dWbH?=
 =?us-ascii?Q?slp/ntsr9/PneofUnfzZTI9pqByvaOWz2NImSVEb0XdxUEjwj9UNWUy2NaNh?=
 =?us-ascii?Q?PuLO2LVkE/7Wc3xWhYOmEjo4R7CZadSTfDMeWioTnrq3yOZT5zeD+gwbHkIQ?=
 =?us-ascii?Q?K/t5m1kbI44gag4SJuadLeyoU/4YaXpFLxSxZFBQRetciV/O6zNIMJKum4o2?=
 =?us-ascii?Q?+DYMcTZNunyQgwg7cshMHBbRMqFDH/ScChGIZ5HQmCeWcPvL9J8PySdRA78y?=
 =?us-ascii?Q?VXF9WA3lLPDte1PHgjoxe49ehwiERS+v81PPWPaeZlBgX0NWeGeRclhhs23a?=
 =?us-ascii?Q?htqTF6PYk7QvwxhpxGphg8YCR1yffGoERSpEI7zon4TomCzh1vYOj0MWxOBW?=
 =?us-ascii?Q?y74duUeL+kKcO13PrrLOkbEJY1YyXa0mqBti0ep8VnsEGcHTzcLX8N3Ihk4r?=
 =?us-ascii?Q?Du2ttvrNClbC7IOnK640KMMW7MTAeB9HANUjfdQru/oFgrEQulH8G/mPot2M?=
 =?us-ascii?Q?X/EaACi8yU4F5jXv58BYkMmn9enCbcCtlZb9NLldj1phKVpOG06EBx+3AP02?=
 =?us-ascii?Q?1K/aFu2tJ4q68sDq1SJrT+dRdjZs3kJBMuuTnUil0l/VKm7Uk+pBoVJ7qU6G?=
 =?us-ascii?Q?98/1dh1+dvcXLeZ9lYqZ3PjZ+jW/a1vLER3l3LiKJnxUXkG8neK0EdvuBwen?=
 =?us-ascii?Q?lWJqtxY+D9ihuL+HvUOs9lfT5YWpswPEnzfhQSZ3fkW+85KrHivgOuEArAKq?=
 =?us-ascii?Q?12fvFpeF8R7T2slqlI/JVEdr6HfYtDexeS84gKFxVF2teKV2/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MGie88nSSrpBCUemmXXw2Vl1miQB/kioI3napiC9I2VFGrAfw+ZVOKixDZ4b?=
 =?us-ascii?Q?3tUt38quluYQ6yySbCtTEZXoWlb+xpLZWBLMIxlGBe0pn1D/YX4EooluuKkZ?=
 =?us-ascii?Q?pvyr5jAh7VTM6trXAzbEKs5ceKLHzu0+yyJdBpqqhDhxZWLtF6LA9EgaBUm+?=
 =?us-ascii?Q?8kScuKqZw0k7a6VnyEpH4Au1przFOouvrSFV2AfYBSMTvaxbj8uTwqkKcPZA?=
 =?us-ascii?Q?G8vtq896q+YfBa9ASe25v/d51Eezdv0mEhWjGne60xTw+K2jfwXIkcgQpdA3?=
 =?us-ascii?Q?tM0HuDccpgtQ08JxhBq3j67pTOmeBPpj4x3vjrV1eYUc6eFGiS3oWONpF/xs?=
 =?us-ascii?Q?U32ot77BD3cWPpqcM+GHS498cgZ2kmGz79bfjwvR5AUOyB3EsI/LZTU/BpoD?=
 =?us-ascii?Q?ebXho0OpGQ/voEV9WrlEK6C/ALRUFl4i72sm3fg436sYRgb277CKkV4C32nR?=
 =?us-ascii?Q?/MgZqOIALLz0eSp7J+/jLwJP5TthClYZxeAPJTTNUuHcxJ84zYUlvpwtV5qL?=
 =?us-ascii?Q?ACVFHamufyWkT03+YdX3r1Zr/z93afw3fxI8H8a+jarOqVGo1WTQtSnKJqoK?=
 =?us-ascii?Q?SEjX52yX87Zji5acrZ5eIE/fzGgtvGaVb1tjKXOqccX+R9cuVurQYt43dDWy?=
 =?us-ascii?Q?eB5R3FaMW4wCPSW8SOkK9h3rAgZWQenPy0xx9ww5I35GF+mWwxFG7Eo83Sfk?=
 =?us-ascii?Q?+8rNjvHRaFqppUBM13LRdh43/k/OiggC/aLtlnvnRBWcgAkPOM92fiPNNlcS?=
 =?us-ascii?Q?XEI3T/VZbld0gRLJ7tikXTMuuTOS/xtdjGMWd+Bovw6xjjPazQ7nYMXYUdOc?=
 =?us-ascii?Q?Tk/LJS8CC9yt9vHn+Oko9WY6ub+R7NeSrTlTHlv+mXv5vtrS8c6oBlu3vBW6?=
 =?us-ascii?Q?98TInGXAkZOupzIRyQjnTFHTz48XGxISWvqQ/sgawkjDk8aN3sE2DuqNNS2F?=
 =?us-ascii?Q?W8IDMqX0ACMTCvdRkYhtXbZ75Ij8+tdLKSpytRgB+VYZ594rx+lybHN/+BZY?=
 =?us-ascii?Q?nlJ+lUBp2FN4KK5DXykX0DFHPVMpX2BqUX6v0qyMzi71QfkseR/JcU2INwYU?=
 =?us-ascii?Q?Pe/rdAw07Ya3vEswL0VdoK++B1/9eaM5BrLMp2lBYqQmKGporxFTHwFkb8JA?=
 =?us-ascii?Q?FHA3qrywf7aifzvs/rWqy9YMaRcbWHzIlG5nsHTxCcDeR4L3Phqq6Ckr3DF5?=
 =?us-ascii?Q?QJOfEaK2/Qti6nW+kJV+AykSTdivT5fW1hJv6DnhAo4obylWKejtf0/seRej?=
 =?us-ascii?Q?bY7KaKTGY10Kjk5aNoQNviczMoJQXSHPsI2TV9/1KF/F5aUC2OqbScVia01q?=
 =?us-ascii?Q?TkYFwyTRNrBwKAtSr1ZCRcfGzclBGviQTBlAB96FzIWnG3LdMm8LsEjXtyW8?=
 =?us-ascii?Q?tPlR/1AA2k00IDnwmnRB2GJcvTO0wudAL1s+ELqB2KTP5C41tbQ82nUlkgZc?=
 =?us-ascii?Q?rYLtSftaw5t7HkfwNAJIqpJ/6iiqw3ZlDoOQuVRc46m4POXD9WtND2J+005K?=
 =?us-ascii?Q?PhB5cF0dSVbv1eNFtaqfwGZCma1f7wFCLSTtIkYZrkouZ49dc4nctc0qSYbg?=
 =?us-ascii?Q?C/Ybca1pHeDUoufz3G6HR9ftam2p76abWXm+eEj8Z9RqaOcWCjE04LE0dhgZ?=
 =?us-ascii?Q?YA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OLQDvYmPQF+hwXCkcQvakUUjBf5tkZ+ae1G1brr8yKKUK5NkovWDmosFAKSimfekS2mz+4ODhfh6PlKq5rAYNKNnqp2AWQF2PrfP1Dm1yIIgh1SEzKHMG7QBuR8KGP3WG5Rm1jVqzXXY3fuldWxnKfIZPQl+01liqXP54un9UOF6zwhd1Cj/2BjM74gPJoLVtrs43CGWjPlh7s38pPOwpxAh4pbWj13PG1/4YgLbAbtK0V96LqK/7eyuk1XVmmj2teeveU0jcSbmrt1p9kyMXIylBOrPzCnbCr2aB/o5PyQKw/fauRub7hnzksXQp0vBQg4yuoRdZY7XPEA33oaF4fDk5GsVjKChmD+sCLHSEdTTMpEnPwyuUpNUBMjOYAhI6ghDdtaNwr0z2nmznoCelZUaCP7yRRUC+0yCmnoFXlivZtWrpzw3hGPkRuddBRJ1x2jXbSNHjPMLp0Y+7Ar9aUlSyCgVfOhkIeKol/qWIuX3i+NYOPPQBTimOXQG4A9kBfFQCHSu6VqW4kgm1WSpT5msvrOlk6mnVlTPzuDxCMlhGtAnz7JIG7D5p4vvqzvWcpPFQ9SHLfmtGYak4A+BLhIEha7YECgj9Gw/36zfYXM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e109353c-0954-4276-9aa4-08ddf52b2461
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:13:00.0969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7euKuBLuEQXS84uioY1S7nuEauaRdDs+gL2buWkvjvFoxY1XfsTgCJfC5uTVrRaayoXb00nLjRsqEuIYRzAfIgDBghQ9JTouYWP+ahEIzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX/bSOKcx0B2jX
 QzFIxQqmjNFLBCwwfWDJrjI8ZSQZrRkgxXJTt5K1O/REoa/WL3h8dnJl3ZjqHuXADaE1mzRJFzP
 6W7B8jYBGhPFc5vtOaYmHXnsOFIiniaF6I0pw8XN10JfmnAm+BDXLU2FOhPUDVW4pY3f38ij3t8
 eJ3kGc8Fe5YrzLAyhXpf8SkCaNl7IY7X1whu8aKTuXmV2pQTrVlexR90vyclugvEIy8NcnuCFL3
 N6+DNwXNtOjMSG4hRr/SS1ZjSoxmqvd6ZWqwxAXdDGWi4YD/5uGRQpBocbLxsVKpI1omzeGysvn
 6E4Rl8ncQTxNjh2RHORuYTfVHEsVjbcZrL+dSaaposRWOMRjBhXzI9mNW4LSf77OJKV9jD1Urts
 docxC5XA
X-Proofpoint-ORIG-GUID: V2dpLXLHoDIXfv8yBesrfdAT5dSd8GUp
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c9708d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=i1sCd5a19pX9XIFVDjUA:9
X-Proofpoint-GUID: V2dpLXLHoDIXfv8yBesrfdAT5dSd8GUp

Since we can now perform actions after the VMA is established via
mmap_prepare, use desc->action_success_hook to set up the hugetlb lock
once the VMA is setup.

We also make changes throughout hugetlbfs to make this possible.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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


