Return-Path: <linux-fsdevel+bounces-62001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E98B818A4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05D9D1C26A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3130CB5F;
	Wed, 17 Sep 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YpASukFS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TgM4MI2U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C0630C10E;
	Wed, 17 Sep 2025 19:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136359; cv=fail; b=TaURrDf4NU+GWZ8Uvy9AApxTWELuF3hmkXY/pjEHcFylbLO4H8mghJOvrQIqHRMmioapQamOP3jQaP21vUU18+JeyPbP8Xrseukqh5ky8ouPpKjMYbYZ9d3NqYZVVAWVzOpaAqc3/iBImh2iicJzi11+hVJVQHMj1qmBDNA4DaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136359; c=relaxed/simple;
	bh=GSs3dL3odT+zCuEqwbLvyT8LUCpAmOkR7y8LTtgrFvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M7pk9SRBRnjlFZ7yxTtqC1ZtvlAGrpkPUphcfc71jPTu8y0c7x397iQO0ujna59r8OxRts5FfxdYX+HzaUczxtGHSEb74y98/+LFQnxvKlpTw42RFRo4PRbjF4n+OjRcObLqivafzIkfvPxtL10iXux3wf01RyKxCETIehqsGXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YpASukFS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TgM4MI2U; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIUBW008330;
	Wed, 17 Sep 2025 19:11:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ifDybNd1FFTpiT8KBj4dj/LTPTfvZy3z+rGnRHu9H88=; b=
	YpASukFSh91uvTF/gIR4BwMBZyguCW6twTx7nEwAgrsrOAK9H2HwMthaCQd5Z0oa
	AGSGorooOWxJXhMYQunsbx1Jp8UfcPFXqGvM8HEDDwK8yJD6yeGKENEa/XCOJsqW
	BIz+hRgzwEodp2yze7Utz69fZ16POKPois1UxnCbJ3yuDhYoc+YRV/4iRXVVKxe8
	/EphoVOywXH8ESy35VHDk6uHtn3N+ByU9VNmck9DkY67zNwBW4zKqAGvtqiGCjwW
	eCgHVXu16cWNDMP6KpECXmMjJMJh97GWuYypNASY9I44mRxAglLhoLXpNtD2Bi+m
	r/tj4W1K0bOGfkyBqW67Bw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8hxnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHEIeZ033687;
	Wed, 17 Sep 2025 19:11:42 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012009.outbound.protection.outlook.com [52.101.48.9])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2e5fqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIWEsSNv4h7Bew0wn1paO8zzFbuXxIVrcpxu3ak4Gdm4Fo/gKQNyt37tQGbVt1yAp+HQf9bfFxXEJOSGSiPSR6DRSyyE1YLjiT8XbL8Tf+eUO5AcHq4daC5BO9ZB1gnVfsTzw20JMz6WlHvlykDarQo4SyWbFcQpxbdYSszeMf4VrnMj5FS83V+Ix3ObgjqY16LzFO2LK6GPZ/DLao8Qnw0HDMCaMhcx2MEjil43h0DHlNiixG8wuvGeWA1RtDsrHSr+DupCCVlWCoF4+bUHJmCj7yODdnEXm+hCCtvhgb/Zrh8qh6is4L9zGdKXiobp41CjCz54+rO9+ysiybUJEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifDybNd1FFTpiT8KBj4dj/LTPTfvZy3z+rGnRHu9H88=;
 b=gLzCggpqycdtqEEiOIGH6aFrrf020G4iy6mFx0il845WHMKWTlYLTfEAbbM4Q9emGxC8L0C9umJGBA7V7KtAHkNdQWbJirNpgB1kEZSbNiiPOBbzX5fjJNM8FUj6siSSO51a2vlcpw12LhprGAKF8y5/wIKKWnPLt/kS3oWhip7D5PBXzOq9O8yLNy4r/g3Z5gKsdM7J6fsXeBH5W7E4JDE/A11WV6QUvzyUNBJPLLQnIZuF+xVnl/owFeHke9mGFDH+cCAoQ6RPr89V1NS7Kyf93U56pOpzyAwRhb40ZM222VWqz8CQjz29WsxVtvmgoTCHtB4KB2F08iGhilwR/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifDybNd1FFTpiT8KBj4dj/LTPTfvZy3z+rGnRHu9H88=;
 b=TgM4MI2UAHQXdvNwBckWTp700UlB/+s+Pt8lgNqvrX2pui7gqND0Xa3m3kEIF3VpiUp35SXcevlBqcodzKdjGYoAURFQWRYqdDwMF8qQcVivLnKFthRhH6a1WDHvaVOP6l0OQyIqOuTcv4YL6tc5k5PDprcK4txkk6Q9YVl/3fo=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 19:11:38 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:38 +0000
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
Subject: [PATCH v4 09/14] mm: add ability to take further action in vm_area_desc
Date: Wed, 17 Sep 2025 20:11:11 +0100
Message-ID: <777c55010d2c94cc90913eb5aaeb703e912f99e0.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6063:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fff4e0-e746-4979-1b9b-08ddf61e06f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SjXCUvKbGQF4xxHUdh/PBqpGvm7f6e8lkXZ1b/wIbr4T94AYCC/wdWfuxUup?=
 =?us-ascii?Q?2W2AXO2K2WYFq2hAxN6mgm1XH+XTWyxHwREClVzWbJtmEHpgBGlIUDycB2Gp?=
 =?us-ascii?Q?l5ck4ytzuJdvURRE7yjnzmK0OkdSG9Kp6BqZ7ml8Yl07BnEOvimHJB7TD9wD?=
 =?us-ascii?Q?BDaKzm/IPtAPhMAV1sOupE62Q9mV3PBxrA2pEcfr5a9bxLalk1F2HCyMSR95?=
 =?us-ascii?Q?uEwe8Du7+dl0gNs3Sl5MWmFRq7xconN1nSkAVXTrrVlLaHE7M8f0sY5f/eaj?=
 =?us-ascii?Q?TJYfXKmTU7rQRZE65k14SKtZCBTCJvJWq3MvecPIomwhF+H1aSq2E7wkJbLo?=
 =?us-ascii?Q?OquNnMmb+AtQ6uMRQaWEnt1C8aP6ObczsAVBFUboPg2I5cgT+7fIDErVSFq+?=
 =?us-ascii?Q?SU2mZub5BOPY97bQgH4wC+ClvkuCtiyKT7kvqIlyE+SKcEnc/GA30EXE6N6w?=
 =?us-ascii?Q?O7PYeXwmh1H5b8KRWjVRSx2aXQ5b/lhnS0EQGd86WuQ1KVAuUl0Qys7rzKF6?=
 =?us-ascii?Q?k8SsSJxD8G7tzDN5Uomte8cATpGMXNSv05/ZRm6dMLVbJ25oiWAL/8tgpK3/?=
 =?us-ascii?Q?MGslQd/Rjw6oRYn3BcwTuye8diRDRU4jasDaYMsvjL4766WwKX3L+mswxrCf?=
 =?us-ascii?Q?Zxyas2aYEcIr24t0QYfQoXTQv6ESC4GpULSI+SZvCmSKUrag8OUBcUWc04rB?=
 =?us-ascii?Q?UL1+ohjBMGr6nJ9ye878fYa1S64+Nx1Co9v2fF4P1XQASMlzeKgXlhC3tEQW?=
 =?us-ascii?Q?WwH1OH64JLE6s8wU6T7cLgctyNB7roP7ZLlewGyPt7zRPkycAZ/tSzmxqVFW?=
 =?us-ascii?Q?Sk2ZrSoBlZac2LDSt7uRzFAjerlT4ZT5qZSolwoh9VGikpbco0iZKS5nNcqQ?=
 =?us-ascii?Q?o/ONH2ROfSRG66fSMsU3ucpDlfYDgDDLjaZ6bermapd6G1VFFPDcxWCukq0D?=
 =?us-ascii?Q?0YJWX8uHa/mVNuN/Dak/OVJ1gmXkGPeUAhVICsiTHVCDBCoSQjsmLhtlEufv?=
 =?us-ascii?Q?l0SkziqLwtsW0vMZnlpyMY2AagkjQtkATLhoHvE/oObb6Ce6QC8g/6KRlSXd?=
 =?us-ascii?Q?anIu3FurJcSuzyKrAvpjxM0Vifsj0fGZJuTKkPn6DcnypRzbeTBu8WtkZNiv?=
 =?us-ascii?Q?icj1q16s2qG4W+GjmFt5EyrIGCfL8OfIoj+Y3Hu5icGkd8ERbouS9m4Wn1G1?=
 =?us-ascii?Q?dPbUARgKRloNtedxC2vVlL26pvTOfBjoPxUKYY+kN3uoC67Lpeh4PvnvtyEd?=
 =?us-ascii?Q?vRmso5hUvTubJitKC2tj+ZauIbXmegcNS4fvgTbZy1Z0GMnXbSvknB07pLUn?=
 =?us-ascii?Q?uTD32jz0P5BZ+S0hU30D2Gf7+Nzg3aTVth6glX6nYRZuYyKa/3Nds9LZ1JlO?=
 =?us-ascii?Q?SXXfnNsofs0ALg0D9FChQJ3Ib0MSR0g6u2Y3RaPQhw7IakXqWm1tu1MZR8So?=
 =?us-ascii?Q?0ISVhHGYkmY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Qn8o0QfwythFGwZEAMnrdCVIS69YZZxL51qmTSdvL0DOBtI9mkSf5BI/eRY?=
 =?us-ascii?Q?iYBEWjhYlOAXegTDijJYh7Gi4si/aqtRVz3qKulMtLYFg366ZBizweNTvHi2?=
 =?us-ascii?Q?haHb5YZ6k+tBGssd1UuUSmAM9lAHOcr+UNAwevFDSde3PLrWOIj3i7o/JglM?=
 =?us-ascii?Q?oMthqfdGI+swXyfDKqgVAkW+mcLB+c/Hytq/6STuKWkT+QeqP48cXp47QslY?=
 =?us-ascii?Q?IBFckDwsXtEdzsbcF8EqO6n0/0Xc3VUAT9odc08Wa6mop8r3peLfcaZm3A40?=
 =?us-ascii?Q?Rgnk7a16S0wMD/ECER85iQ5hdou3DPy+uKpDYF5LiBQP6mmaA6ErLVKKWyla?=
 =?us-ascii?Q?c1rZYHO05FvPx+dyzco7/Int2EQTTRp4dLSfDCf8da0n+iI/Eq+KhkoXcmlv?=
 =?us-ascii?Q?e0zh+Af3PpS7ducxu6Ds9aqGx1S7dy1EAxFfahQobB6MjePRzs9o3+qB/goB?=
 =?us-ascii?Q?JnjbX+A8mNcu7UHs0EZqNThfojPAMh0QTVInn6pMG/NJGMbaCD+iLAFzEWzD?=
 =?us-ascii?Q?PMqagOI4eANSYP44s15jFChRq2/Ysqdpe+DOGnT0cC1Fmq1gEAtH2tuC8oVX?=
 =?us-ascii?Q?EK4ibG+a+WEZRCcNkLhYtQwEmBfQwgafE5djPd1VhK2KVcmAQvPcXFQNnSc1?=
 =?us-ascii?Q?Zw0XKwdDxaoQ1uQnhhBw0C1FQ2Mz2jAm3CBoUyldHAfrCEN6j5Ee79Gw79IP?=
 =?us-ascii?Q?k8N0VJeuitWvFIUhSmMY7xmxZ/e79QQWaeUIWE4r765y0xeAyzgwDc3G0j4l?=
 =?us-ascii?Q?TXRBbBdkaxvtZaWjSi8TSYVZve+dp2JqNX3oNEN4coNCmIvuUZ1l5wXatcDm?=
 =?us-ascii?Q?x9tjVpHn8iX3aW4kiU3flJJpvS7VjHyFIRXXaZukJUjWAn80MDfnUMlAPlt7?=
 =?us-ascii?Q?4vvdRI8Uycu8UCvyniqCWKvzXJYQZ7jyENMtK4e5AK1ldiKFHYvlP7RMnoFV?=
 =?us-ascii?Q?h/xybSuCnrfnxwAbO5tR9S/kaedYfc97/DGIm3TTIwp8MQFDF83aFAJakhao?=
 =?us-ascii?Q?7TwIw5dSofu7fifmUQRk0re48kquv5AA9D2fqF9cnlojNsuKuvx5VbGueUGz?=
 =?us-ascii?Q?bDV58h0wC8J4UHL16Mvz2idbIi2u5b+GYneKg9h0sdoqyy9+1p8vETuxTMeU?=
 =?us-ascii?Q?0Ar2rutPJxzoNEefQLfXfu3CoFGkHgkoUwlM45U93SrL4tJTAHgjv0NkkVYa?=
 =?us-ascii?Q?Rx40942wUwpGLvPAgMZHSH0fw7KzwGr17/6xzABk4kNoFfPVnBIc0cqAipxF?=
 =?us-ascii?Q?/miCxxkN4mzpQtvFZRRk4/+9J5ObJFMehiRveoOD9akvdTjbX9QJYQyqwu6H?=
 =?us-ascii?Q?ZHo5TchxV0od/RlUq+YzIpcEagzubi0ewDIRJBC2qF4T9qyz0PwuZ4i7uAsB?=
 =?us-ascii?Q?gaVoM913IG9lEXQGx+Yx81wFCM4JLrbtVCSQzHMDvRo6aUY/t3atonl6ADCe?=
 =?us-ascii?Q?Mv/L2v0SW6rxdH22upYl+rRofoGb1rpgP70TuXhCF70TagzUSnwXBItGKE1K?=
 =?us-ascii?Q?Hy4SHwwdlodEJ83obPXInc5mMCkpgQ6hDHBl/5Chwgdhs7aOqDXjkD9mLouw?=
 =?us-ascii?Q?PE91yeSJZ/dlP1zQf8qLpxZ9iCeW0K2d1hJiAyhLQsRDIhvxaEdxFGVLU010?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	F1b0EmdnpEFEpDlY87Qd/gSVUV4/JW7FhzqmewqMogKJwZX5IBbTXuHkEKxEWrBlZf7h5S9CxGsaDWpcGRJTBommhGCf+Bi7+7z7SmepBVH5Ga25Th69Ss6wxsZ+YmvzjVANYmNlktQz7Krf0nQStQeQ4Jwc4fhj/jMcKSvFMEdYcHefyAugxq90lXSsCOBgjLY/Erwk89kmbhwQjjZy+R0UKwWRug/AU4z/j19VM0GWMcfODcoDrze2tK6y23LfnKLC8YrCbcUKIFXfAGV74BsmmiRuh6gz9ndsKeR+zRwXMBAsbpqJzhtjSqu0G51UOixmya5WZNdFLV7zgLnChcOYikrC0EhHxSyxWsmGM4PF1MaI1+fB/T7ksDvwM4yEVnAERNT+Fb2iOPLcYzNgi0carrdI/6/XCLgtFHhXtGCLscgECJZw/sDXfcPGkH7UbxBliApIwT0Y7rVkYPq2vZevBGHeyc6vpaHNItlZpGjs0nUtdBPsz5Sustx7z5C+0YSOMsv/touieuuJH8EsSCc4OUVImSWf7dXWLOV+KP0YNIgE0pytf3vTAsZsvx34THSP9enjIK5cnJRdXcGMw9PzSTqMGycoZg0iX1VWFv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fff4e0-e746-4979-1b9b-08ddf61e06f8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:38.4153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxM4jWGnpbEickRMCLi8o2EJNYkwKCVcOWjGmjAdwXXK8EBCE4yfbEOG3N6J0HzSdbzH5fJMr7KZS0Rv6yZd6EZyldHdt2drFJ2n5myXlFo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170187
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cb07ef b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=LTX6yydndTU1YmvmmuUA:9
X-Proofpoint-ORIG-GUID: wx-RUO4fJm9BRDSPOXYf5UqFYQelSaiM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX7oLzGc69n+eM
 ln7T1RQ6bxA3YKlAVH5Sm53w6rJuLaJfdNoxPXX1ToQ49YSLO/lfXlYFXRgT5l3aLkUTddmZxam
 ZLnw8bxyed6M1b9rTdzq8ZHaUh0sqjrn/Vl+oe/7fZ7zgcRXs6CTWrnr3PXQlXPYcxGuKv2kwvD
 zU8lhxfU+b9Q4BVAJWKHKWQw9ZhNaX1+yZRAIY4yksNiSvIGyMluUDjYUBL/+N6Qq2Sqar2SDZ7
 LlqA78rtZYvnUbIUHipZ1tD1jy7aGdPBuqoLF2Lhhzn9pkqZChx0WR4YxAPeZcgmIcdqrTslbX1
 r7E5ajCjAGgbmdyq1j/aqMha47hzZIlC/LTo+pzLYiXF+7eMgWg0Nm7BCDhJ4sEtpi5GIxlhvFL
 QWUC8pzU
X-Proofpoint-GUID: wx-RUO4fJm9BRDSPOXYf5UqFYQelSaiM

Some drivers/filesystems need to perform additional tasks after the VMA is
set up.  This is typically in the form of pre-population.

The forms of pre-population most likely to be performed are a PFN remap
or the insertion of normal folios and PFNs into a mixed map.

We start by implementing the PFN remap functionality, ensuring that we
perform the appropriate actions at the appropriate time - that is setting
flags at the point of .mmap_prepare, and performing the actual remap at the
point at which the VMA is fully established.

This prevents the driver from doing anything too crazy with a VMA at any
stage, and we retain complete control over how the mm functionality is
applied.

Unfortunately callers still do often require some kind of custom action,
so we add an optional success/error _hook to allow the caller to do
something after the action has succeeded or failed.

This is done at the point when the VMA has already been established, so
the harm that can be done is limited.

The error hook can be used to filter errors if necessary.

If any error arises on these final actions, we simply unmap the VMA
altogether.

Also update the stacked filesystem compatibility layer to utilise the
action behaviour, and update the VMA tests accordingly.

While we're here, rename __compat_vma_mmap_prepare() to __compat_vma_mmap()
as we are now performing actions invoked by the mmap_prepare in addition to
just the mmap_prepare hook.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               |   6 +-
 include/linux/mm.h               |  74 ++++++++++++++++
 include/linux/mm_types.h         |  46 ++++++++++
 mm/util.c                        | 143 ++++++++++++++++++++++++++++---
 mm/vma.c                         |  70 ++++++++++-----
 tools/testing/vma/vma_internal.h |  90 +++++++++++++++++--
 6 files changed, 385 insertions(+), 44 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 594bd4d0521e..680910611ba1 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2279,14 +2279,14 @@ static inline bool can_mmap_file(struct file *file)
 	return true;
 }
 
-int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma);
-int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
+int compat_vma_mmap(struct file *file, struct vm_area_struct *vma);
 
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap_prepare(file, vma);
+		return compat_vma_mmap(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b65c33bb31a..7ab6bc9e6659 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3596,6 +3596,80 @@ static inline unsigned long vma_desc_pages(const struct vm_area_desc *desc)
 	return vma_desc_size(desc) >> PAGE_SHIFT;
 }
 
+/**
+ * mmap_action_remap - helper for mmap_prepare hook to specify that a pure PFN
+ * remap is required.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start: The virtual address to start the remap from, must be within the VMA.
+ * @start_pfn: The first PFN in the range to remap.
+ * @size: The size of the range to remap, in bytes, at most spanning to the end
+ * of the VMA.
+ */
+static inline void mmap_action_remap(struct vm_area_desc *desc,
+				     unsigned long start,
+				     unsigned long start_pfn,
+				     unsigned long size)
+{
+	struct mmap_action *action = &desc->action;
+
+	/* [start, start + size) must be within the VMA. */
+	WARN_ON_ONCE(start < desc->start || start >= desc->end);
+	WARN_ON_ONCE(start + size > desc->end);
+
+	action->type = MMAP_REMAP_PFN;
+	action->remap.start = start;
+	action->remap.start_pfn = start_pfn;
+	action->remap.size = size;
+	action->remap.pgprot = desc->page_prot;
+}
+
+/**
+ * mmap_action_remap_full - helper for mmap_prepare hook to specify that the
+ * entirety of a VMA should be PFN remapped.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start_pfn: The first PFN in the range to remap.
+ */
+static inline void mmap_action_remap_full(struct vm_area_desc *desc,
+					  unsigned long start_pfn)
+{
+	mmap_action_remap(desc, desc->start, start_pfn, vma_desc_size(desc));
+}
+
+/**
+ * mmap_action_ioremap - helper for mmap_prepare hook to specify that a pure PFN
+ * I/O remap is required.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start: The virtual address to start the remap from, must be within the VMA.
+ * @start_pfn: The first PFN in the range to remap.
+ * @size: The size of the range to remap, in bytes, at most spanning to the end
+ * of the VMA.
+ */
+static inline void mmap_action_ioremap(struct vm_area_desc *desc,
+				       unsigned long start,
+				       unsigned long start_pfn,
+				       unsigned long size)
+{
+	mmap_action_remap(desc, start, start_pfn, size);
+	desc->action.type = MMAP_IO_REMAP_PFN;
+}
+
+/**
+ * mmap_action_ioremap_full - helper for mmap_prepare hook to specify that the
+ * entirety of a VMA should be PFN I/O remapped.
+ * @desc: The VMA descriptor for the VMA requiring remap.
+ * @start_pfn: The first PFN in the range to remap.
+ */
+static inline void mmap_action_ioremap_full(struct vm_area_desc *desc,
+					  unsigned long start_pfn)
+{
+	mmap_action_ioremap(desc, desc->start, start_pfn, vma_desc_size(desc));
+}
+
+void mmap_action_prepare(struct mmap_action *action,
+			     struct vm_area_desc *desc);
+int mmap_action_complete(struct mmap_action *action,
+			     struct vm_area_struct *vma);
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 31b27086586d..abaea35c2bb3 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -775,6 +775,49 @@ struct pfnmap_track_ctx {
 };
 #endif
 
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		/* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		/* Remap PFN range. */
+	MMAP_IO_REMAP_PFN,	/* I/O remap PFN range. */
+};
+
+/*
+ * Describes an action an mmap_prepare hook can instruct to be taken to complete
+ * the mapping of a VMA. Specified in vm_area_desc.
+ */
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long start;
+			unsigned long start_pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Note that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(const struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+};
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -798,6 +841,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 6c1d64ed0221..0c1c68285675 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1134,7 +1134,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
 /**
- * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
+ * __compat_vma_mmap() - See description for compat_vma_mmap()
  * for details. This is the same operation, only with a specific file operations
  * struct which may or may not be the same as vma->vm_file->f_op.
  * @f_op: The file operations whose .mmap_prepare() hook is specified.
@@ -1142,7 +1142,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  * Returns: 0 on success or error.
  */
-int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
@@ -1155,21 +1155,24 @@ int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		.vm_file = vma->vm_file,
 		.vm_flags = vma->vm_flags,
 		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
 	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
 
-	return 0;
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
 }
-EXPORT_SYMBOL(__compat_vma_mmap_prepare);
+EXPORT_SYMBOL(__compat_vma_mmap);
 
 /**
- * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
- * existing VMA.
+ * compat_vma_mmap() - Apply the file's .mmap_prepare() hook to an
+ * existing VMA and execute any requested actions.
  * @file: The file which possesss an f_op->mmap_prepare() hook.
  * @vma: The VMA to apply the .mmap_prepare() hook to.
  *
@@ -1184,7 +1187,7 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare);
  * .mmap_prepare() hook, as we are in a different context when we invoke the
  * .mmap() hook, already having a VMA to deal with.
  *
- * compat_vma_mmap_prepare() is a compatibility function that takes VMA state,
+ * compat_vma_mmap() is a compatibility function that takes VMA state,
  * establishes a struct vm_area_desc descriptor, passes to the underlying
  * .mmap_prepare() hook and applies any changes performed by it.
  *
@@ -1193,11 +1196,11 @@ EXPORT_SYMBOL(__compat_vma_mmap_prepare);
  *
  * Returns: 0 on success or error.
  */
-int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
+int compat_vma_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+	return __compat_vma_mmap(file->f_op, file, vma);
 }
-EXPORT_SYMBOL(compat_vma_mmap_prepare);
+EXPORT_SYMBOL(compat_vma_mmap);
 
 static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
 			 const struct page *page)
@@ -1279,6 +1282,124 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 	}
 }
 
+static int mmap_action_finish(struct mmap_action *action,
+		const struct vm_area_struct *vma, int err)
+{
+	/*
+	 * If an error occurs, unmap the VMA altogether and return an error. We
+	 * only clear the newly allocated VMA, since this function is only
+	 * invoked if we do NOT merge, so we only clean up the VMA we created.
+	 */
+	if (err) {
+		const size_t len = vma_pages(vma) << PAGE_SHIFT;
+
+		do_munmap(current->mm, vma->vm_start, len, NULL);
+
+		if (action->error_hook) {
+			/* We may want to filter the error. */
+			err = action->error_hook(err);
+
+			/* The caller should not clear the error. */
+			VM_WARN_ON_ONCE(!err);
+		}
+		return err;
+	}
+
+	if (action->success_hook)
+		return action->success_hook(vma);
+
+	return 0;
+}
+
+#ifdef CONFIG_MMU
+/**
+ * mmap_action_prepare - Perform preparatory setup for an VMA descriptor
+ * action which need to be performed.
+ * @desc: The VMA descriptor to prepare for @action.
+ * @action: The action to perform.
+ */
+void mmap_action_prepare(struct mmap_action *action,
+			 struct vm_area_desc *desc)
+{
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+		remap_pfn_range_prepare(desc, action->remap.start_pfn);
+		break;
+	case MMAP_IO_REMAP_PFN:
+		io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
+					   action->remap.size);
+		break;
+	}
+}
+EXPORT_SYMBOL(mmap_action_prepare);
+
+/**
+ * mmap_action_complete - Execute VMA descriptor action.
+ * @action: The action to perform.
+ * @vma: The VMA to perform the action upon.
+ *
+ * Similar to mmap_action_prepare().
+ *
+ * Return: 0 on success, or error, at which point the VMA will be unmapped.
+ */
+int mmap_action_complete(struct mmap_action *action,
+			 struct vm_area_struct *vma)
+{
+	int err = 0;
+
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+		err = remap_pfn_range_complete(vma, action->remap.start,
+				action->remap.start_pfn, action->remap.size,
+				action->remap.pgprot);
+		break;
+	case MMAP_IO_REMAP_PFN:
+		err = io_remap_pfn_range_complete(vma, action->remap.start,
+				action->remap.start_pfn, action->remap.size,
+				action->remap.pgprot);
+		break;
+	}
+
+	return mmap_action_finish(action, vma, err);
+}
+EXPORT_SYMBOL(mmap_action_complete);
+#else
+void mmap_action_prepare(struct mmap_action *action,
+			struct vm_area_desc *desc)
+{
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+	case MMAP_IO_REMAP_PFN:
+		WARN_ON_ONCE(1); /* nommu cannot handle these. */
+		break;
+	}
+}
+EXPORT_SYMBOL(mmap_action_prepare);
+
+int mmap_action_complete(struct mmap_action *action,
+			struct vm_area_struct *vma)
+{
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+	case MMAP_IO_REMAP_PFN:
+		WARN_ON_ONCE(1); /* nommu cannot handle this. */
+
+		break;
+	}
+
+	return mmap_action_finish(action, vma, /* err = */0);
+}
+EXPORT_SYMBOL(mmap_action_complete);
+#endif
+
 #ifdef CONFIG_MMU
 /**
  * folio_pte_batch - detect a PTE batch for a large folio
diff --git a/mm/vma.c b/mm/vma.c
index bdb070a62a2e..1be297f7bb00 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2328,17 +2328,33 @@ static void update_ksm_flags(struct mmap_state *map)
 	map->vm_flags = ksm_vma_flags(map->mm, map->file, map->vm_flags);
 }
 
+static void set_desc_from_map(struct vm_area_desc *desc,
+		const struct mmap_state *map)
+{
+	desc->start = map->addr;
+	desc->end = map->end;
+
+	desc->pgoff = map->pgoff;
+	desc->vm_file = map->file;
+	desc->vm_flags = map->vm_flags;
+	desc->page_prot = map->page_prot;
+}
+
 /*
  * __mmap_setup() - Prepare to gather any overlapping VMAs that need to be
  * unmapped once the map operation is completed, check limits, account mapping
  * and clean up any pre-existing VMAs.
  *
+ * As a result it sets up the @map and @desc objects.
+ *
  * @map: Mapping state.
+ * @desc: VMA descriptor
  * @uf:  Userfaultfd context list.
  *
  * Returns: 0 on success, error code otherwise.
  */
-static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
+static int __mmap_setup(struct mmap_state *map, struct vm_area_desc *desc,
+			struct list_head *uf)
 {
 	int error;
 	struct vma_iterator *vmi = map->vmi;
@@ -2395,6 +2411,7 @@ static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 	 */
 	vms_clean_up_area(vms, &map->mas_detach);
 
+	set_desc_from_map(desc, map);
 	return 0;
 }
 
@@ -2567,34 +2584,26 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
  *
  * Returns 0 on success, or an error code otherwise.
  */
-static int call_mmap_prepare(struct mmap_state *map)
+static int call_mmap_prepare(struct mmap_state *map,
+		struct vm_area_desc *desc)
 {
 	int err;
-	struct vm_area_desc desc = {
-		.mm = map->mm,
-		.file = map->file,
-		.start = map->addr,
-		.end = map->end,
-
-		.pgoff = map->pgoff,
-		.vm_file = map->file,
-		.vm_flags = map->vm_flags,
-		.page_prot = map->page_prot,
-	};
 
 	/* Invoke the hook. */
-	err = vfs_mmap_prepare(map->file, &desc);
+	err = vfs_mmap_prepare(map->file, desc);
 	if (err)
 		return err;
 
+	mmap_action_prepare(&desc->action, desc);
+
 	/* Update fields permitted to be changed. */
-	map->pgoff = desc.pgoff;
-	map->file = desc.vm_file;
-	map->vm_flags = desc.vm_flags;
-	map->page_prot = desc.page_prot;
+	map->pgoff = desc->pgoff;
+	map->file = desc->vm_file;
+	map->vm_flags = desc->vm_flags;
+	map->page_prot = desc->page_prot;
 	/* User-defined fields. */
-	map->vm_ops = desc.vm_ops;
-	map->vm_private_data = desc.private_data;
+	map->vm_ops = desc->vm_ops;
+	map->vm_private_data = desc->private_data;
 
 	return 0;
 }
@@ -2642,16 +2651,24 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
-	int error;
 	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	struct vm_area_desc desc = {
+		.mm = mm,
+		.file = file,
+		.action = {
+			.type = MMAP_NOTHING, /* Default to no further action. */
+		},
+	};
+	bool allocated_new = false;
+	int error;
 
 	map.check_ksm_early = can_set_ksm_flags_early(&map);
 
-	error = __mmap_setup(&map, uf);
+	error = __mmap_setup(&map, &desc, uf);
 	if (!error && have_mmap_prepare)
-		error = call_mmap_prepare(&map);
+		error = call_mmap_prepare(&map, &desc);
 	if (error)
 		goto abort_munmap;
 
@@ -2670,6 +2687,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		error = __mmap_new_vma(&map, &vma);
 		if (error)
 			goto unacct_error;
+		allocated_new = true;
 	}
 
 	if (have_mmap_prepare)
@@ -2677,6 +2695,12 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 
 	__mmap_complete(&map, vma);
 
+	if (have_mmap_prepare && allocated_new) {
+		error = mmap_action_complete(&desc.action, vma);
+		if (error)
+			return error;
+	}
+
 	return addr;
 
 	/* Accounting was done by __mmap_setup(). */
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 07167446dcf4..22ed38e8714e 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -274,6 +274,49 @@ struct mm_struct {
 
 struct vm_area_struct;
 
+
+/* What action should be taken after an .mmap_prepare call is complete? */
+enum mmap_action_type {
+	MMAP_NOTHING,		/* Mapping is complete, no further action. */
+	MMAP_REMAP_PFN,		/* Remap PFN range. */
+};
+
+/*
+ * Describes an action an mmap_prepare hook can instruct to be taken to complete
+ * the mapping of a VMA. Specified in vm_area_desc.
+ */
+struct mmap_action {
+	union {
+		/* Remap range. */
+		struct {
+			unsigned long start;
+			unsigned long start_pfn;
+			unsigned long size;
+			pgprot_t pgprot;
+		} remap;
+	};
+	enum mmap_action_type type;
+
+	/*
+	 * If specified, this hook is invoked after the selected action has been
+	 * successfully completed. Note that the VMA write lock still held.
+	 *
+	 * The absolute minimum ought to be done here.
+	 *
+	 * Returns 0 on success, or an error code.
+	 */
+	int (*success_hook)(const struct vm_area_struct *vma);
+
+	/*
+	 * If specified, this hook is invoked when an error occurred when
+	 * attempting the selection action.
+	 *
+	 * The hook can return an error code in order to filter the error, but
+	 * it is not valid to clear the error here.
+	 */
+	int (*error_hook)(int err);
+};
+
 /*
  * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
  * manipulate mutable fields which will cause those fields to be updated in the
@@ -297,6 +340,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 struct file_operations {
@@ -1466,12 +1512,23 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
-static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+static inline void mmap_action_prepare(struct mmap_action *action,
+					   struct vm_area_desc *desc)
+{
+}
+
+static inline int mmap_action_complete(struct mmap_action *action,
+					   struct vm_area_struct *vma)
+{
+	return 0;
+}
+
+static inline int __compat_vma_mmap(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
-		.file = vma->vm_file,
+		.file = file,
 		.start = vma->vm_start,
 		.end = vma->vm_end,
 
@@ -1479,21 +1536,24 @@ static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		.vm_file = vma->vm_file,
 		.vm_flags = vma->vm_flags,
 		.page_prot = vma->vm_page_prot,
+
+		.action.type = MMAP_NOTHING, /* Default */
 	};
 	int err;
 
 	err = f_op->mmap_prepare(&desc);
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
 
-	return 0;
+	mmap_action_prepare(&desc.action, &desc);
+	set_vma_from_desc(vma, &desc);
+	return mmap_action_complete(&desc.action, vma);
 }
 
-static inline int compat_vma_mmap_prepare(struct file *file,
+static inline int compat_vma_mmap(struct file *file,
 		struct vm_area_struct *vma)
 {
-	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+	return __compat_vma_mmap(file->f_op, file, vma);
 }
 
 /* Did the driver provide valid mmap hook configuration? */
@@ -1514,7 +1574,7 @@ static inline bool can_mmap_file(struct file *file)
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	if (file->f_op->mmap_prepare)
-		return compat_vma_mmap_prepare(file, vma);
+		return compat_vma_mmap(file, vma);
 
 	return file->f_op->mmap(file, vma);
 }
@@ -1548,4 +1608,20 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
 	return vm_flags;
 }
 
+static inline void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+}
+
+static inline int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot)
+{
+	return 0;
+}
+
+static inline int do_munmap(struct mm_struct *, unsigned long, size_t,
+		struct list_head *uf)
+{
+	return 0;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.51.0


