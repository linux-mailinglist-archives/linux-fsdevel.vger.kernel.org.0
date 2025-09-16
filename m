Return-Path: <linux-fsdevel+bounces-61756-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D834B5998E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392FE17255E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A1353350;
	Tue, 16 Sep 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KCYh2ziZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b4c0nAEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF0350D58;
	Tue, 16 Sep 2025 14:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032012; cv=fail; b=oablOz11myQz0ceV8cm39OzAahG8stkVyPN7DrNp+tGwGA6dlH867yz0mOwuhZ5NKwTNBKlMGG2tpAbEuidye7O+xZ65baM4q5dg1EEwD6Vo0dMkaeN8SYihiqqqX2j/Yo9LlzeZR0Db2UYJuViazPEdD9PsgMnVSyVx3ySHn9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032012; c=relaxed/simple;
	bh=7F3hNrGAWa4Ry22yxHekKizW0SlNuhzoLwDYSIkk+sQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TEoQ1JQqxGsHpvbKEOfeYjLJJXmW0/ordSWR/KhjHJ+gTuhIG14jWeD3/IUXPfelUrCBCj8qKGsU6Bf58EQjG2gKRUH13etgTs09VrKYfJVy3DGWMcAyNmgqwhu+BwP9LBdMMsUfeU/3xG9qJEizMm7sS2gi8I1DDAJyAZV1m9o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KCYh2ziZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b4c0nAEg; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCxYJH029086;
	Tue, 16 Sep 2025 14:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F7R6PkNElHoEy0RyA91jd5SCVekku5k2j2iVpNfTz9w=; b=
	KCYh2ziZMSs5GmMC8sm2O4J+fXsE8OIDZkfJjRfWNONmiaa1b252FAtEhK2IHFDM
	fnLXwDJJs2YzGuaK5xF1i6oIoPCn+sne6fOq0R+H5ACjQv64u2i5E7stlANvlw4B
	Gf6WZkcCplmbDZ4J5hwFsKYjdEfgDtnGcI6suqv6/Q3Ym1akTJvbYWvG0d+4VbDS
	4vgFpifYP1MHgQYYI3uKn+ck0i6GwOheyxn45SqD2d3kyA5KZid08qHRIwkkN6JW
	yA6ZY/jiX/Q8OfdvzkewI0ZXWO1w7+28VJFoPybDMAxMSIDraYRWFLrBmLHWDddu
	zfhg8LnIs5aqQ3H9oKM4uQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w4r8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDKAEK027247;
	Tue, 16 Sep 2025 14:12:42 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2jqp8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PY3HCyjNlO4nVQb/iCf57q02RdH9X/RRcO0chVlXJ/Vi6oUMscCsA5gx8d8dwDPmL3sMDusC0SbVQ0JNZVn/2WGIkzZk3IrDaB7w1kL6TX6uf/nmKXBAVFCkOtsfXI9wQRbXFSAc/zJDKsjYTp84xkb2OhJxq/TEN/4FfNJgz48knyHnxx9RGS8b/2+yXqTUIUDrZtUrkkhZSjfcLBoLtlku9W8CN7E1zJm01Bj5z2w7ntQSg59mR1OqmbQL+9rmhKXajq5U0d9NiUvneoQkSCpn0KF/PeC5VB29chlziQDk7N8YX71cMIN2Q1mN8zEjEXhuPCzboy2nYhVfd2+Tkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7R6PkNElHoEy0RyA91jd5SCVekku5k2j2iVpNfTz9w=;
 b=iWJkeqHRZ93sKOPMn2n+sdxjiL1UH+/asWJbaoC5WHrFhBtaRDpPd9dmnEtOy0TB/hIP3xVhOQg+wkh39PjsgH2bM1wvactaGQ0ACAu/lKVJrZmLKF4BPO/CPbm25nldlpE3rbUqWPGdusVjnyc2UgJANojTbkTfkurJdSTS7JxWSTcRy8TT3HBZYq3kCC2ZOdCzIZfB+ocXPDubEOOseiaq2cjCN6kOf7RRYw51wZuQcI2cgyK/4+5czS3WUeX3U5MAKlobBepl3aJA4HjaxBVOR5dxv3w8Q51HNqppPOzZwqnhXzHq0Q1MXKJVnX5zBjDONSn2cDRqMOysCBcOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7R6PkNElHoEy0RyA91jd5SCVekku5k2j2iVpNfTz9w=;
 b=b4c0nAEgTu9PjauBghI4jbb692Ho6u5seWwtMecE5SZEgNRkfh8Jl+Tb8pOtTIkzfoe6RUXmHYDVIwxr5evMP19oAXDUyEn/EA+2Je58fBA+C4cb0izo0pSaPw28NGvi1RBsuz8U/keb8UaSEg3axAex5IAlqZuQCsamyTPu1FE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:38 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:38 +0000
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
Subject: [PATCH v3 03/13] mm: add vma_desc_size(), vma_desc_pages() helpers
Date: Tue, 16 Sep 2025 15:11:49 +0100
Message-ID: <011a41d86fce1141acb5cc9af2cea3f4e42b5e69.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: dafebdef-8283-43d6-7ebf-08ddf52b1771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dcF7tl2wUu7EWxmJtcJxBhgP6p9TX1MvVpau0YgFEhr1c4Gd2cgNNecBM0ol?=
 =?us-ascii?Q?taHS7vKQPiBMhMy35xwTRudIhaJP6qvJPvJXzXwiXWl+fdxr7nQM5nqW2AhI?=
 =?us-ascii?Q?0mV+DDT4MCfaGbYS25fRcVHbmB2mwUtG+12LGbA8S7NjuVYHLmX8KtOEpK1m?=
 =?us-ascii?Q?QJ2zBYMP+BsJHn9mFSjCR1owysPilGrqS9hQ4vY0X+vPAUgbf0eWneEcWqlE?=
 =?us-ascii?Q?yY45mftEpH5cXkD0iiXoTHJgk+UXcfipREfmcZ5hitbPUfxWHmG/Yj82+tDR?=
 =?us-ascii?Q?szMrEK2uutvR35dJ1PYrIXqlzHHPcKieQJwhKXkHU1j9qc+fsnQ3ICXJNjsW?=
 =?us-ascii?Q?JFfXE7gBnjiKsxfJeosjSjdrvawdy6GSqVpIDgVJF/KmbRzOIeHptZQKEDHV?=
 =?us-ascii?Q?LjTfuVahUtWiFNKU4wcUASwaJcA5DyW06DSNyjvpti1skNczOrESkmxtvANE?=
 =?us-ascii?Q?JreAhnEXwSsEUan2JjzS/FQqaoUTix+YPaRLh80mV4Fx4obu7Gh49DcMbAMN?=
 =?us-ascii?Q?WYPLYPofVTyhQo2Cd0NmsxZnN3zh+xQt7odOS4n6Wn8N/n0JJqsa6zYhyjSg?=
 =?us-ascii?Q?FtMRA8pU9El+8IK2aPRoPXFoU7r5FG0ogYnCfirlIeTre6gUgAp+phuCj0Y8?=
 =?us-ascii?Q?oV6j+beHfcljF4sW7ix02pALxKba/53kl9Vhf0s0ZXXUzZyzhhj8SZQ4Khyy?=
 =?us-ascii?Q?GDozcaAW4w8NU4Tht1ISlRwlPJ18ymVgAp9TinS6pVMDrO8D39+nL+oUwNQY?=
 =?us-ascii?Q?Q9smbYpu2GiegmntaHkzAo3HC1OnLkKXzm+xj/YKeZhYU909Ebvenkjdq3Sw?=
 =?us-ascii?Q?sgYjEywvQqeyfhbz1P6BkBYBVD3JfZ9Le3hkH0rCjQk28IFlLy26Auk3cVIE?=
 =?us-ascii?Q?HD0VWba9SnfCNoTuKlPE01N85oFPaDUfmImVzUNOXjlKQpUPe04+y5Ln3dFN?=
 =?us-ascii?Q?pu0k3vqIJ92oWAunMSMaMM7cM+0rHlNWIXojTJ2TM5O7sc16ViDt9Ls4tvTa?=
 =?us-ascii?Q?1eT0oOYIx0FBO+q/RnCW2GWhi6kkH0IFFWB+eAaT5vDiiOg9367ijhvUMVt8?=
 =?us-ascii?Q?0YktdEh8ajg3xS0IZ8AdWldGWHWy9SZj9nSLhIQewo/qZ778W4MG2MixUEli?=
 =?us-ascii?Q?redGqPWYrHr3onPtLZi/wW5o0eearA6cUXe1/5tKgcRksW+wd4b0dYdRboFC?=
 =?us-ascii?Q?LZt5jfk6GFb+gCQQM7QGyP6Q/5QRaVWkXwOsLDHgDQfzA35jqUq516qnsu79?=
 =?us-ascii?Q?/c7HCFRPQ5+hhBB1ZVp18baMBgH2s6wRgUhQvh5sEOcBYBy2XaIj6X/qQ1F2?=
 =?us-ascii?Q?5aADVXHrU2GizT/Ags0R0KyNqts65hP5E+1tZKeYhIhjS6Ed5KaUyALcX5yc?=
 =?us-ascii?Q?ew8XN3ul947Q5KdXt0zoXLORUDx8jQc32oUIjFCsFNSgD2QDpiWa9ZBqiMKr?=
 =?us-ascii?Q?f8Vp8LBPRfI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JA5W5rt73k64pFJ9H6Wf88fj+0MhSnSG9pz9H6jGSy1IYu9UsvxZFEt6qqaR?=
 =?us-ascii?Q?wN+i/HpIe+13LInK6Iqlvd7QjBetM+DGbZQXQE/EFFpVUBYT7f9lszmvxvOu?=
 =?us-ascii?Q?poE8ngjqwrBX1OYz1/+YiFrlmqSiNq9XAOW/WljrB2uWDsEIpWbsF+5j35ci?=
 =?us-ascii?Q?WyHfb2hL3LqGwHuIrY4zVGM75ipsRIzIvwFlGD2Hx4sCqsw6hRI/I1EqZ/n5?=
 =?us-ascii?Q?qYDRPHelfMvNXNvQpOyCdaE3pOZX3jbxO+ssgtfeuyzalEnL+7c+Py0Pjz90?=
 =?us-ascii?Q?HOA/GXaq12MQojlCkFWpvulPoxkfgVMtdrCiZaiVIJqR/xCDvzUaS95dCuR9?=
 =?us-ascii?Q?IlOESvEYfoYs3YZ5RMaed617fDYDFJLsLKS7mcp9ukk6yPZWUIp2Aj66uLde?=
 =?us-ascii?Q?e1GX6xvwzwhWrgegUeCbLHAHEP959RfjpLWtwp1PYPuCQ77+FeAgNTz/hLUz?=
 =?us-ascii?Q?fuAZIGhxBbP2NpBSpyzTCAzCI1aOreIsN7llQio8bjJwtpc1wOPRLCOpQzNC?=
 =?us-ascii?Q?rnunQLDoE1oMeBD+AsCuo5t1mGCrBzBQY5y6EmNPHBaMpc80mKvoZ3DoFIc4?=
 =?us-ascii?Q?wfOSWInIRY+D6Cl1toATul2NKki9QBgiB8aGJR2zfR/8TxbTROoH3xsqh47o?=
 =?us-ascii?Q?XDcaqIxtI6JW5jgZGDD2MMdH4QeonoeOjdqI0vMEw8rIYEBxVeccdOgDqQSN?=
 =?us-ascii?Q?ndBfGTqBFKkOmbe0k3fKKXiji1LUT57WLXgzAal1e89wE4A/ciSWxLWIj+6C?=
 =?us-ascii?Q?fH1oms8Y79DMEdI6Z/z0eoyART6rpha5wkfDUdpfnj2budbvMSBamHFd5Ivh?=
 =?us-ascii?Q?2gvGGWxZrQuwpwkcYmOQEFGPdv0/134CIYONKVM7o0JvBYwNeVsxCDKsUJyk?=
 =?us-ascii?Q?sOIMrlCTII9mvZsHD8iCXWpeOzorqHl2rkgtoxwqoyg3i46C7s2jPRmK8NCz?=
 =?us-ascii?Q?pkUVElCl0qnwSuKV7iTmxWNOqWY3HI14e5Nh8Xf9gkyuJz/eY7JIlXD+qxrQ?=
 =?us-ascii?Q?wytrM08O1lIAFSQPhh/Lr1ogit/ym6IsrQcK+YGpnKlqb/qfSIsxrstwQlz1?=
 =?us-ascii?Q?uB4BIbD57cGRdIQjMwFVv02/QCBaHSBopgA1Ap8r9S3CzQFXf8v2BeaaNPX7?=
 =?us-ascii?Q?C4eEL86UQzacWI8VXIn+Pv/3b1wi4Qy9MBAlCH7PoliZUtE+fZak1zCoa09b?=
 =?us-ascii?Q?E1h7KwCiJj677ReSmJ+M5ECW8cbIqLPZCqICx2kfzCV3imMF7f38BdMavfK3?=
 =?us-ascii?Q?5sbipZ8DvJKy8T20feEYIAYeuOLbJ4V2uEF/NfBRYamR8y1Im4/6ZBt4NTc/?=
 =?us-ascii?Q?ZRqlJfOkGBHHJcESCAt2Vuvj8yTPYPiZktcUshqWbBmi6hsDoe507Q6H41Lb?=
 =?us-ascii?Q?xtstGdDlOHW/pEm4j+2DF9dNWOOBHsX8p0bxTrQgzBHEO5CsQ/uQ0qnM52GC?=
 =?us-ascii?Q?MDecbpdHRMwldGH1mAv1bWDcBk4ftcbLNl4PEfDWE0TEqCAzmbImbc5gDdet?=
 =?us-ascii?Q?EmSHrZGx8Qv76jfLXMyMhSqKAmPrmNlOPH4ifdx5vlhM74ncMJE/1C0XYwgP?=
 =?us-ascii?Q?zFP00TpmpHdU8s48c8XvfExb0UsoW0f72D5C4W7a2cthRL5RX8TI9rqvalx1?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D9BlWiEAiiAPbXo8tLMB393vV/bauTaJoP3GwhwWd2IAeBD4cdqp2S2Jww3bUKNNZVOk3Vsms22iceNYLttCR9lDkIHGx7/oHyPUhBJ+SJilkjP+PwL+Mg3O0NEPVQpPZ5evO3sVkxjZw9FN1gCPuW+YxAN+y3Bh6s5TwSVHKiS9ygW5pq628yb/Chwrhz3ElbYZ5Eq9dhcoljdgvMmxHHv9ggqzq1TmaxOIataVBAvLdDkyTvPyoCqkWz993TPXU7Ia2GWrYDTO3cjrDwhLoYWezrVckxnFmxGajGf0bnxoxAsHPfjHbCcVAhNXXX8K8usBSzn6CcYMCg5GbD2C4NfYARGeuQRya8sweZXwZDApGz0in8sWu+vWT1JdCIJvLK4ON698nYMYZ/+B5Dy269N5OuSaZgqkwP1u2126KUCZyEpPWQkOkEI84At08rl4EjxhzZiMSO/K133V4X68INxGmb3DHo/d89LHs4djBTdxdT1uKoeZZhlI4P6agSwUH0it06ys2nyegRysLgjvATIaDFObaSRYcwrVLdfQv55CpLNljenO4nHMJ/1mR5T/7oErweSxCIlVVUgHUzK/eock2uYg2MNpEedvns/+Xyc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafebdef-8283-43d6-7ebf-08ddf52b1771
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:38.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agAvJxLa3q+oDsUcgCODPpu4VZx7+C5nltpSxWNdW4Qsdb05HQt0eV270VdY3kCK0Do/ozJ33+P95gnYl4Ny4GAYj604hbP9yqPJI3X4EqU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160131
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX9uq18RVvuAoS
 4tjB5GLldIZRNRDWYa1n8vW68wJwBbLkPu1z5bOCZ1+nlDU7LWawZ2Ka05hSL6AGXP536EyRbwF
 HqySOIKoUH7Mp9tK6/96Io/3qI8D4Pkm5/vj0xlJq5sjoC1Xbv6tRff2YdZmw7MU8pbzCXCSZoO
 U+urJfUmj9wV/BDUjDb6m7NmyT0X1sbltkQWORW3Vgdwot/UD7Ed6De7AxcEkclzFsjuh1h6KC/
 CvM3nsg4qr8277VsUN8oZRnRfEpqgn3SKoceFS1UrMpT6Sk1UseugV+BdGHNUlydHVW+ZQjiCIr
 7Lk7YOw+1yvr+rlx2/LS5kFUNBDM6cmXx8L4igpAGD4O/NDHS9IFQ6M6nV9nieocjm2RQyzGxfQ
 NBARPUZ4gzmd0JYwEw/iSzLO7k6o6Q==
X-Proofpoint-ORIG-GUID: uKDAGDXDgJHbd8_dVW2x1F24MfznRWPR
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c9705a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=V8PVCHvh7cpLA54rH4kA:9
 cc=ntf awl=host:12083
X-Proofpoint-GUID: uKDAGDXDgJHbd8_dVW2x1F24MfznRWPR

It's useful to be able to determine the size of a VMA descriptor range
used on f_op->mmap_prepare, expressed both in bytes and pages, so add
helpers for both and update code that could make use of it to do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
---
 fs/ntfs3/file.c    |  2 +-
 include/linux/mm.h | 10 ++++++++++
 mm/secretmem.c     |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index c1ece707b195..86eb88f62714 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -304,7 +304,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
 
 	if (rw) {
 		u64 to = min_t(loff_t, i_size_read(inode),
-			       from + desc->end - desc->start);
+			       from + vma_desc_size(desc));
 
 		if (is_sparsed(ni)) {
 			/* Allocate clusters for rw map. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index da6e0abad2cb..dd1fec5f028a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3571,6 +3571,16 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+static inline unsigned long vma_desc_size(const struct vm_area_desc *desc)
+{
+	return desc->end - desc->start;
+}
+
+static inline unsigned long vma_desc_pages(const struct vm_area_desc *desc)
+{
+	return vma_desc_size(desc) >> PAGE_SHIFT;
+}
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
diff --git a/mm/secretmem.c b/mm/secretmem.c
index 60137305bc20..62066ddb1e9c 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,7 +120,7 @@ static int secretmem_release(struct inode *inode, struct file *file)
 
 static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	const unsigned long len = desc->end - desc->start;
+	const unsigned long len = vma_desc_size(desc);
 
 	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
-- 
2.51.0


