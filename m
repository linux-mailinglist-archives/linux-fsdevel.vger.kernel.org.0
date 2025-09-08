Return-Path: <linux-fsdevel+bounces-60563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6283EB4939A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 17:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20BD018969B4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 15:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA4F30CD92;
	Mon,  8 Sep 2025 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NFCpALo/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xj4gC0oa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53132235BE8;
	Mon,  8 Sep 2025 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345698; cv=fail; b=peUHE1kQmkpHccsinMaP/xXldqBYgveChnQz0ioX7rrHGdx6EYx2BdLmKOjdwOtsMyY60H0DXMoDIAuHYMnaK+kByA31RGLyiiGKY27ThI/A7mcoCv2P/7X9ktR0AFuCGfUvx9fQKN1+AxtWI2cA1XjwMv1OnIrxggrL5xtWmcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345698; c=relaxed/simple;
	bh=D369ynQR2O4iZgPez3DMZ3cGNHf5wQEjqY+V0iofwzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H/sC2gDnrMCfUkik2W4U0n1DH3MiCswcQZXXcQItb51RE43HPjFmjt+bqIcMw1/rxI0a6+fhsfyJKoULIa5w20Rq114K/7WTAAAM731/QAcaQpdA9aRQE+nBjlrU0Ezh4Jn4NiUjEkqwDUy7IstC8tBdfWI27kXMjedZHNE96k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NFCpALo/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xj4gC0oa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588FNQeR006855;
	Mon, 8 Sep 2025 15:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=D369ynQR2O4iZgPez3
	DMZ3cGNHf5wQEjqY+V0iofwzU=; b=NFCpALo/rQeFaOKI8XbOs9UpHr/EAkGZVg
	7YBSJdAmxWe2o81sajKyIvmqbKkWXO29UgcDSS70maDjHjd42IBpzKOsveLF9BXP
	OrCPbGXDi0Ec+0yjAuxarqsmy/+2/YMPvy/j4hUGbXDwyo48PExZowVd9sgOuALB
	11quFTnHWKj9dBlRT1HckGfI7wpE0OU1NHl7ZLBoItp0fxzHwo/TSccalZC3YqT0
	aR1xSBufsY+RbQ7SRnTNYcga1pYcDat5C6YN/cHHysDO9D8jq9UYOHgaSS1n+orm
	dplmpMVVnGXXzbQ6SlQ6FO59rYdbV8/HRa6SpDRF1kpY8t9aUpyQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921ra0175-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:34:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588FCHo5030655;
	Mon, 8 Sep 2025 15:33:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd8bxhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 15:33:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+GcZCKzsGxDmLX7Z1xUG7P5ahr+MfMC/UrTDYZ5z+vN5f97GRUDXlqZBYH667q1SJbaUydyztX/M4N8a08F0wbFBbjaSMoPRU76tC24K+Woo8bZlENOmm2ScHxwsPAufEWY8N882RAKKbWgXqaJbLiiYkkXPeFTH+Zlu/VG5KmQNjTvPymw3K/3I++Eq8lBMym9mzUDI0vvJUD8ove3ouupKGeQObezHEpP3Ce0cmoBQwVSzJsZ/b1wJdNpvJXjsEOKNuL+RHMYXlj7/Wp6xnJMeVnUBcJFFhMXZ8RaAyV1aLLy7jk1rFxT1Wt3v/YEsU7Xj41a3GQ/154ZhgNrKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D369ynQR2O4iZgPez3DMZ3cGNHf5wQEjqY+V0iofwzU=;
 b=a7uUZS/HW8JdSNk7um5wv9MnpT+x3Uc2OAmL2L7waq0UiH4oWyXGgZaztGT2Xa0xvMOqC3fBpQ032uVojFGqASQrMrcQgQfmKCwfBoMl5zEgbfpb9zFcorFpxGDqsvCYAyUu2BWDnm5aGWJwPPf5IAsYhzrNLaqHx8sbDnvJNipFKI6iVh+VfJ3ju636cwF2fRLOnXUTJPRloPD+QGzyK2VM7REUHxLvUkwEHynP5GMwIL6Ehkc9vDQJpabG5ZuZYDp3n12d1eaXCsWu3y8HyIWa8PKqdo02SAwvvnFIu2STxsQlDyizgIfbGX2vyxZFT2t285Fcy41a+8721d2dWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D369ynQR2O4iZgPez3DMZ3cGNHf5wQEjqY+V0iofwzU=;
 b=Xj4gC0oabKH/SDRcyKiFFgujO02LOfIGphYrNwW9qqJuFVsT5AdQHTVqzUqwMJJuowzbwjZnvrvcnL2+6inwKI7q5AfiQM1CNv1gvRhnYn+NI2uBw9tsf3Su8P8ujmfsUKRu+UAeIrK5vFUXYVYIuEZudIto504iOjIziyZJI9o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF6AE862AC6.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 15:33:45 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 15:33:45 +0000
Date: Mon, 8 Sep 2025 16:33:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 03/16] mm: add vma_desc_size(), vma_desc_pages() helpers
Message-ID: <b62e38e7-9f27-4594-943e-987a14dba05e@lucifer.local>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <20250908151637.GM616306@nvidia.com>
 <8edb13fc-e58d-4480-8c94-c321da0f4d8e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8edb13fc-e58d-4480-8c94-c321da0f4d8e@redhat.com>
X-ClientProxiedBy: LO4P302CA0029.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF6AE862AC6:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4abb8c-42b7-4014-35e6-08ddeeed1909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2tWxLcFTGQpj4G8+FW199SCjW08eJ/yFdDC2ev5MBH5iZO0G45ko8XhZSWrN?=
 =?us-ascii?Q?IFWMf4/Liblt0cRQ3mPJyMOMPd4i5Q7YTytq5CWprBOKQeVAimXwHg7+qIfr?=
 =?us-ascii?Q?9XVktmckgVSD0iaPVZLShUr8S/zb/aID58uQkkRnccM1U35ijycd8ufdeGAL?=
 =?us-ascii?Q?mJA8Y9VbQ9+OQaRcnEaOO5ga0efLH+gp4BV2lYvZ4N+9raRq3zrodQBfBEdj?=
 =?us-ascii?Q?FPvd6ZqiD3xxxdIyaaHRs7EVL7vJKJTx3bA8BmHNJq1JnOKqj0Xx3VxhcGxz?=
 =?us-ascii?Q?kBmpCvj0/u5sAZRYzhcJ/t9n6bqBL7rcmzNqxM8WF98Yw2tJRiYwechF/IiK?=
 =?us-ascii?Q?6oVvjzzCPbYifPjlkI5uDoNRG0wdzqrQ7++ybc0qMe+dGvsUHyN5vQzcVRyP?=
 =?us-ascii?Q?XgJnk4fhNzi7iSr0Mot4/+kUpRuEEYas0e23KbllcuWOw2F0nKvT6uvVgJVX?=
 =?us-ascii?Q?UG5N13atNbkl7rut2jlMjMeg1asWXsHXkDP+35yk3UM0Jn1Hvc1FA7EBzGgb?=
 =?us-ascii?Q?tVa+zWHzH/cKvfeo23nrXHj+M0/wvg2ClY2bbTZ2Kk+xAlAM8ISPYXil0azq?=
 =?us-ascii?Q?Kz+sMovEamgtTB5/q8e3jM4JAGOed/TNTEpQNgDUsVfA8L5iD8JHd72BC9qI?=
 =?us-ascii?Q?R8s2LKkpaUIdfMx/ES+b40TX8yS5jnJMdFBjQr2TUNIAlX/Kbg9zpqkT/OB8?=
 =?us-ascii?Q?79uu2APL00Z25HH8K1d6D9T6jpM5jTp1V9fHaCWKooH1QPEbA6IWrRjKeA3q?=
 =?us-ascii?Q?yS8MOAfshPKLi3UeON2eypWRkIDBHnqiqAQEkA2gAj9av8tu9DRM0zVZczPW?=
 =?us-ascii?Q?skxsw/BVuesfu5jtwMbJMcm9yMAlsBdRPpMB34nP8NYeDr2L1Ga8z0ut8qZ1?=
 =?us-ascii?Q?4BX2cGQveo6xCnzM+QLvpw/LR7MLp32Z0b/gVr6Zj4Aq4jRGzqQZgTehK8XK?=
 =?us-ascii?Q?xp3nwbE4nE18Q6i4TJLLb4JebSCiJcLZ7PU03JItlWfd8+vYKHzUeSXmUcNO?=
 =?us-ascii?Q?S0cIkmpv6qXb6qs5vYSK9J5o1JNgoryS+fhLtlzhWyh994MY9qobSHXXrOZM?=
 =?us-ascii?Q?TJ0H0pMQEul6E3XgP6u3LPuiyxvQEy0+2ujvr6g8dBaF0mQcsVrIvvC0X5mo?=
 =?us-ascii?Q?N1nZegcdnvriPB7Qydd4R+GGw1hxth/8BP/4ahovrOyN8sImgSkek1/beLRT?=
 =?us-ascii?Q?8fSaRMKnnpCHKjSbXQhph8Cv6LwpYSMSl7M8su9E/zahKVXqtK4tfQue1WWN?=
 =?us-ascii?Q?d8IR16Y9d5v1zCIdleIURfZnMzyEktxuU8imTrkZVORuZlfiWpcxR+f3LXRJ?=
 =?us-ascii?Q?teslc82tYFZ7dOf/KFQoxLJKpCwAo48A+pq/hrVP1b1oElGwE1Hr29dYyarz?=
 =?us-ascii?Q?q86a8/2lKz2PIq9lu0rx06qZv7fovLq3HDD2oywiEHc+xSU9wFaaU8MgIMOF?=
 =?us-ascii?Q?83sa+HP+/P4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pm9FW7QyVuEv5uppkK6z42vh3PJBsQ1L7Jz14wCY2XufmyldaHpQy+ARlBzQ?=
 =?us-ascii?Q?DpIrZU+/bMZe8xgFCHQZNgAcLu+hHwNkO8Slg/KeodoiviFUwPvKggUWCu2g?=
 =?us-ascii?Q?SUvQcItfifn131HuIFu9LSsezK1wEhU70Tp3fiBh60Ocjc6XPbQMo7wW2PE3?=
 =?us-ascii?Q?0uRRGysNSnurH+WMkglG7rFZ0K0ptAdoKC4XBYlsUNS91zgppkfDhTlMUt0T?=
 =?us-ascii?Q?8hdIJhGOCJ57H4hfI/+fgElQ037Q3Zu2d7YHcQTaWQSa/x7Nuz2t6sXQgooq?=
 =?us-ascii?Q?xCJ+ZBb/ygo3hK2aFNP/ALc7TeiqPAhsMKdI2BFyYcS3IcF/cJBGsyS7zgi3?=
 =?us-ascii?Q?RHidI5xhOYfmByQsUP2LcIQy5J97boSmH24BfeiTiMeH7rZAiLq6Gk8cwfl9?=
 =?us-ascii?Q?CjDKlHv3Bg8vT1QYrjTh/EJE5Lad6ZH3UhV93KvYVB2f7ZD/YaHmxy5RiaV2?=
 =?us-ascii?Q?F44N9H7+iMXhVzNckm0Q2SYv1ZDLKAxklVAWIcksEd6yZ0KP4Xm3Jl7RXy2a?=
 =?us-ascii?Q?6l/LN00nn6AO2aM1WiUuvMzrMad5DSUAzo0gT1KmtCEiPnCnNvRzp97SLI37?=
 =?us-ascii?Q?6W/o6NOz8odHS+/tQPKfXIk/6A3niod3mcx/vr3taEP5jnH26llb9nL4uKNM?=
 =?us-ascii?Q?gaGhJnArUDwNBy/DagQvI6xeNuUKZUjrPgp2ceY1VsQev8ynXRvcpq3/tk4S?=
 =?us-ascii?Q?y/+DK6QusiRYvzq/TVxL1Ljz0D8tWDMaSmZYUIGmVPkuaKeoXiCdDU4ljV2b?=
 =?us-ascii?Q?aofrd0Ei1pjbuLs5HVoIwdX3axaJESUG6dSNrSvSfDtCkxr4MA0EispUQlWG?=
 =?us-ascii?Q?uIr5+3cjn/3XCZCyOf3akSOcMWX9JPU3okGfw//nKlf6MMPyIzN50yvc3iW7?=
 =?us-ascii?Q?EmVCrBi5GYUWWmH8SIO9RNSXgz0Vr/djlsusSl6qwbTjR9BcwTyhjgNNVMJy?=
 =?us-ascii?Q?DbR8mUfUrV6B5P4g88XMPJpL4qGcBDJKHZZtJG1RrTKHlwoSK5aTpxQY5Oww?=
 =?us-ascii?Q?Y05eEokE3HNnk7Esk8t/m6Hz6r55flMzMb6UCJhu47RP+JMsmki8wwA/vz/T?=
 =?us-ascii?Q?03CDC32YSJcD3i/oPjcGe870wrGb9zSXX6iigXHRpbGbL0UzAeX9Hapjh8Tc?=
 =?us-ascii?Q?iRwkQe0ibf8fDgS9t5WMK2/6pwQhigkXS5+tPfd94VYCVE3hg/d9uv4zTuhd?=
 =?us-ascii?Q?m8F6JQzbuRxIfabap4WWVkcyTDGVQ/w+T0R6IlqHq7eoj/sy9dscSNHxNvBY?=
 =?us-ascii?Q?6hcoBcnePRgIsBEFPJFtSjd6BxoUMUPEjfZfBMwQwvlzBogL+QJXRXh0qEOm?=
 =?us-ascii?Q?38gLiN6BHM2qIQa+c0OAwhwNlt7Npq4RqPOTwjawL8O5jq9TTeVkYD1xJ+TL?=
 =?us-ascii?Q?wVZnKYcCvPB58V3X1Ylo9Q0mOfIuYUl4d/kqQKc/kcl2m2BYe/eUfXC9TxH0?=
 =?us-ascii?Q?N3agAG6yFzjEh7e+B2S2P0EmjnlU/A9Sfw3uDTqSYYCApheV09GzE2oMK2os?=
 =?us-ascii?Q?lGHRKYnfmp51mM8HPF8xl2I5fbsnCRQ3EFDiTwz/N7LnoaHsidSXiOKKTntC?=
 =?us-ascii?Q?XjA/4S+xTMZmn7TRisWK/ram15WIl2hOWpm0T4e+9xwprCY9F9BqwMseEBJg?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5DJDxnGuhAaTTCnfMdR679RtRjz1m5e1AY2ibU5FXN+dy53St5ksWaOnnXaxg/47YyyAahIGUw9ycLBrd1kPqktSjlPUpZP265dcWpsVP4K0HJf44IxuS8LojZCsWvyuDaFgZF+Wb4fnd8g486wWSuezf7nP4GYr7XxY4k90GAxcHPmQ6YlOUd10N8EiPaNQCeF85lQAoWV5a1fkf3RPaipoD9zRPiWXAoTKO8KDZN22wE5qhG8Q9TIZPZ/neWqzm/mYH0KQAfek5zWolh1UVAmaG+RUhiahyjHuH0yt3GkX1UyT8WFPmRCl010ds7t8YWWLbCxGfliQpqWPfycHurX4T/y4ECEs4xHnLP4fDHLH91Dw+snl/AP5jgOc9WQuEJD6mXE7zf0IF/SSmr/Ge20ouZIl3+qC3Q0znjO90X0ftmuhhEynExPqqPwebS0+8AcOOQdy47Ml6aM8b318p5TkzvaBsnZXbBaB/V1n59ZBvNfggVxoTodGux2gESWlOdx2nijQ1LEjhd0sY2fJqyG72WKBtHwQXW9CYEMrI2Bqk6kbkcYGMbG2UGdZRw/9VxgnPVHLcfDlbQN02hk3amDFRJ++hQCzMollqC+j00=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4abb8c-42b7-4014-35e6-08ddeeed1909
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 15:33:45.1759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LXrsfOK2DsR6TsDan4EvInOaxOlfVWuqDVhJga5rZnbTbpAQI5rmYh78EeAo92xAG2aTA5yvUvWxaunnhHQtSKb5bRxWMQ3B0HoGlMTl0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF6AE862AC6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_05,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=915 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509080154
X-Proofpoint-GUID: hF52dygi0qT4PHXGfEr4WBEF1qhZ5m1N
X-Proofpoint-ORIG-GUID: hF52dygi0qT4PHXGfEr4WBEF1qhZ5m1N
X-Authority-Analysis: v=2.4 cv=J7+q7BnS c=1 sm=1 tr=0 ts=68bef768 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=CcX3mz_LIa5ZTRlDaXkA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfXwXUlP7DZ2RG6
 fh4ZX0oVsKKi+7GImNVTZdscBIb41gHcrlu1XL1j040UcBJBmouIjXAQQxL7yMllJhRmLGZaYZt
 dk0F2TOgm0xv88jBNFHTHvoyQyJTbe8yuRGHZBc/KyZSlUR1feNwOc9FBoXloUqajRQRSAAQFfO
 5RddMOYyNqcZAyzkjggSPPab9LpaAoiNQcF+xgpK2Nb9pRnZT7ozo6sNh7dzmUa9/IY+6VSXEBh
 ldzvKiMbmU0AiaKrDvpG3BmE16q40YYszTahxmQyZ92fWTJ8yxJJMd8uyahX6pw2zk7Q3Uwl7Rt
 WIyBP3YDZqQeusooBI+qz8CSgCoQlz00zdUYQeYAnQDPi/0wcIXLqeOxEpezZ6Z2wcHZCrFribO
 fJ+aE3Im

On Mon, Sep 08, 2025 at 05:24:23PM +0200, David Hildenbrand wrote:
> >
> > > I think we need to be cautious of scope here :) I don't want to
> > > accidentally break things this way.
> >
> > IMHO it is worth doing when you get into more driver places it is far
> > more obvious why the VM_SHARED is being checked.
> >
> > > OK I think a sensible way forward - How about I add desc_is_cowable() or
> > > vma_desc_cowable() and only set this if I'm confident it's correct?
> >
> > I'm thinking to call it vma_desc_never_cowable() as that is much much
> > clear what the purpose is.
>
> Secretmem wants no private mappings. So we should check exactly that, not
> whether we might have a cow mapping.

Well then :)

Probably in most cases what Jason is saying is valid for drivers.

So I can add a helper for both.

Maybe vma_desc_is_private() for this one?

>
> --
> Cheers
>
> David / dhildenb
>

