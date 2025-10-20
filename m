Return-Path: <linux-fsdevel+bounces-64687-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39229BF109A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3069E4F3429
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480AE3128AC;
	Mon, 20 Oct 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WZWiqnB9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AhnVo0FN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59120314D01;
	Mon, 20 Oct 2025 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962390; cv=fail; b=fbeMIPhX28bYrETi+df03SuICEQDXMh7V6Fk52kAgiy4E0p4KvT/M9nmgV8s5I/qUMyPZFHZlskFSsvpYSkPKSz6C2XalCd24AkGU4+qpehtjAP1twePbzmo+CN29QYacC66AI/itVfnLZ4Tk92v902xEiEgPWNknErUIV8ftf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962390; c=relaxed/simple;
	bh=5j626KLvKEdtS6BLFWCDGpd7lVYSWibrX+A3z4VRFX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kLDeEMORrUsuhOUbi08dVbOdy2xoscjiMVZxHti2uX9oH2cmkkTmGmondurPlx+Cbv13sQs3WC3v58CqB3VHBqrJAb+1w9V8F8iILQbTEIi4oAQbxmm17bKkYv7rsELJp451D05WRjkDoU6KBzlHYgZqkGDg9k9XVWvh7Jj8JZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WZWiqnB9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AhnVo0FN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8SELT028325;
	Mon, 20 Oct 2025 12:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1FYqNnfG2o5930FDWL62i+nYa3ZbAaOhg6GETH9ngeQ=; b=
	WZWiqnB9UgjwN4AuttATmNq4dlj2kxUMdjlVhqLtpruc9+f3n8Z++/rBtNIQLMLz
	ZI7K8muVN/01teqOifNI1GHV1/kXM9OANzM0lX5fuJmIBLSfJ2OqpBRsZt3pLau6
	XHX6RNDJpzBMSNhR4/mSHQ422P+jwjUNOXLSKjgvVMe4ugmdi867lRnB/NbWX6T7
	YZKsO1UzGcE96dVYjFdHe/kJX5PqQb/7mgHqK8aCXvyJ6L+BdIx/MexnGgrGM7wf
	ktKT8D1Zyqzxoz3+wwNqlfQ8bzbz0gFa234pGpwYbsd49CKHeRX+NMWck2tpmtq1
	KePjY4vyvNn88MQfb3pzZw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypt440-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KA1i6i032254;
	Mon, 20 Oct 2025 12:12:03 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011015.outbound.protection.outlook.com [40.107.208.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmfc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:12:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jeLXS7THdFmrpBpNSP1o2hIOqtVGhR2Og0aAjsmc+96ofnC4zC9AtXzzK8SZBzBgetoJCI3a/7e91L3opGx8CmlBbrRQImAwFTQwe/pEi8tKIpBoqaR5yeJ3x5JtbXy337alR2kgaoTQL85ThTiAQwzzc7ELxZKLe6OVcVWIFuXItZe6WXLxpHDyZvnvSl2PBU12Hy1FQzwp/N4DZuI7pB23n2Zl0UZQrd2G0XGUsILwo13C+mwjF+75hiBcnizfWVxSzm+f9w3evY887hrjV5yPl90/V1CS3PyMSkaK+rgfVIDtxPdAc4g+UD1ql7f3rdn41CLzmUm/HnEIalkg/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FYqNnfG2o5930FDWL62i+nYa3ZbAaOhg6GETH9ngeQ=;
 b=Il0z9Fg0e/NVsDsKTZWJhv5QEkJ9D6ZESNniFjldei7QHU7zQBeRvGpOy0EbNmBHUzkKVqZ18bFxCWrYL1vIXobQnoVl6DDKdd3zoXYPQPDZzxqGr/NTDCgK0f/JP8Q9hG9slFsTP8RtE44IDtfUx+RhSZl3UWUqO6MkrLME4okV2vCsLUAMKfkx4vieB1KMkiTgOoNOlroy7b6qet2euEj/Cn8GqQA8DbspZElEqLNnRgz3wOQGCS7jJRG8o+pKHw/ETBgWgt75lpa59caPIdwu8iZw4TbhAXk+5yZKrGWjJkqzM7r6ralULZaKP6FIpkrvkw/j/Oe63IrC/KHMvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FYqNnfG2o5930FDWL62i+nYa3ZbAaOhg6GETH9ngeQ=;
 b=AhnVo0FN7qorMUc+p6ibIaYfutsashgvDTo8PEkWybsV8Xo86ohamiODk0D7SRfn0CEQG3Z0rPvx69ho4n3+YF3ob+Rj9Q0n1GZAcYb6fuyXetl5e43XjFsYTauvqMVGqkD61+PeibXCjfdVQO353P7eDfr+jMPpGMXk0xIGQrY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:57 +0000
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
Subject: [PATCH v5 09/15] mm: introduce io_remap_pfn_range_[prepare, complete]()
Date: Mon, 20 Oct 2025 13:11:26 +0100
Message-ID: <4065134f13a24a3e14691b7443bcee7490b18a5c.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:ba::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 161fdf3d-70c3-49c7-4a84-08de0fd1dddf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ainv3i1IZLTbcoa7o++N+Q3Y8e5xSCWuIbfmK7p4H7w7UVsqw+784PgVluwL?=
 =?us-ascii?Q?dhorqtYBZmwKSjF/CcP1U/3cfY+oacuEmCUKrtAMN6ix5PgHh2XGWvZN3oEt?=
 =?us-ascii?Q?l8SigjH/W7fBQEeygMjLE+xpet2zMWLqLQ/7gbLa556S9GAR2oi/YcXNezjU?=
 =?us-ascii?Q?yTsinrlYbwnKKdWjVwJefGyspITQpnFHEY8dg8MmTAOLEGppDP7tRcmI/pqh?=
 =?us-ascii?Q?Nt5AVQ1KGyBpQ7sIq75m4d5JGiFK3xl+VcBNNzGlQqHx9XsN6ifn78P+i9Wb?=
 =?us-ascii?Q?uJDC9TnOiEbCUoKaImb59S76OxDSetSnM4nnVxmNf5ULEG+Xakc+TsW/sntI?=
 =?us-ascii?Q?Qy/cE57jGXCToiDdk4V+8k3KUULFAgELnQlnaT2mZ5usUDsHIGgz79SU6Zud?=
 =?us-ascii?Q?ICTFGid1WpQj5j5h1Pdt31ironHZoL3MxZDiQyZ2I6J6aIVq4iibRfAWhVmR?=
 =?us-ascii?Q?VN1dadfRHsf5dGo4p2aKNZ5HeyzcNNYCr+GZG+DvO1F9c/TSt9EOMYn+VVcy?=
 =?us-ascii?Q?LudigsCq0WRI12vcbNIBHA4ybysJGcg+JHGpeVx3lQXsNJrZtPhdyhEwMf0E?=
 =?us-ascii?Q?yF3IKu4Qlv2n8ETOVmyQHlyJepy3EdFbWX3T7kWV5SRL7FVjYjZYSYqcEXgV?=
 =?us-ascii?Q?Wd51cMEj8xttQShEYqIQF3emvvwHt5bQ9PgqQ8lMPJeK7Yw+YQXuTIAPhkxv?=
 =?us-ascii?Q?ExwvDrISoqrkSJk82fFjTn0YghpUAG7la74ntdyvQtePFPhH46Qz/7fb/hQE?=
 =?us-ascii?Q?WyMxtoO+deCko0TX7JYiWuBxa0xi+0davK9W1Mk/1FixK2nmwcVoOl680Zbw?=
 =?us-ascii?Q?r7jEtkMfLoWjH7r2ge+7uhUAoT2o+DjviGChrZlAnxOST5COJ7SNZOMOodoq?=
 =?us-ascii?Q?LsdFlYabfCoYlOZAKcE+YbWhP0XpPEVaSdx0rYa3XtqXpM1MfdeIIAlHv7Jr?=
 =?us-ascii?Q?TtxC3VRK3qCBXmSR/fe9SNYtEt2ZeSNWCSYBaFiO7UpOC5GeE4L3z1Qj9nT2?=
 =?us-ascii?Q?g/qHihnbQLbjSwcptCfeRnMooriNXr8lX2/4133UEwphqBrnr0puIgrN3QRm?=
 =?us-ascii?Q?Z/I6TVzlQuGnToZyNUzguE2mzH9Yidxt4sC+foNdhy7Q3Ab3yjPdv7KVfSh9?=
 =?us-ascii?Q?hJXIwtSw7BMtbCyBvZCQeGR2CU9AjHM12wuVBT44n2bvru/53Y1ZRxiroQdH?=
 =?us-ascii?Q?Byjg6DJAnWoGeLONB2d8xtNaYmoAjkZWFPvUctIlcgUHCHz53g5lWsHOXJi8?=
 =?us-ascii?Q?ZW4Q+y6kPNpP41Ngz6Ax12wWFuy03Tqc2gQxEunicCdIEDoNVhbqDaYhGyRW?=
 =?us-ascii?Q?7mlf3O+ZCg94rPCHtFHwsJnGFkfFso5eRvGupwKcHQ6cM/zs3jSPdsgSUza2?=
 =?us-ascii?Q?Covq8EIw7hPp+/ijpWTW8C1rUbVWynN5jnAKmyigLdYh3rTpuBlssZdRp1+V?=
 =?us-ascii?Q?dI+uyX1cdok59dMViZGBS0GyVQ6Nvtnc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bvBBVZXX9v//etZfdsYuW36AatVzQsrQBhSP+eQ2IrzOjF28sltXVIfW3EOC?=
 =?us-ascii?Q?ApsmcB1nfizEaEaNc9aNdmzXlZx7oIpCrzHYWZx+Kbd7Sx91e9J5V/kflKs9?=
 =?us-ascii?Q?O4RZOezeXhvu7nukm4Q3rFMWQZmwUavpxD7pYJICepaFHhlFGbNkgVb0PQme?=
 =?us-ascii?Q?2Y1gJ4ZWAI6ULtPhvsKvSEIQ+DzvgrLZKeZSkcPgZNkBcodKlrJDHNeu3IqG?=
 =?us-ascii?Q?qj+1ty95Uop8sVh3sO0wRANvUZkFziYUU3kFHbWBubOZCx/gHCpCygnhLrId?=
 =?us-ascii?Q?hcGXxeTfKoZJu9l/xSULySO62uDm420dB9+haXshWUZDWf4cph5uB7WBwCqt?=
 =?us-ascii?Q?5CE6sc5aFDloBIrABZQp+WxY1k/otDxZz3CVUBnqOyuDcLGnXtw6B0fT8AMr?=
 =?us-ascii?Q?pvvvKk8BzpDZi308i9Mtdgq+4lLSVj5kDLkBrjQSNKub9AvdGG/Gv7D1jXtn?=
 =?us-ascii?Q?YOF8yR7b2k4ZGGNfIOTJBtc2EZSWTIVH4dyqBlQ58pxl4toFIJjkIant5zzJ?=
 =?us-ascii?Q?rc2jdT/7M3rLUWLIi5q+DWSHpJJ6G7t7jxhiB8S0FrSTSyOuK+htd3r7xIv8?=
 =?us-ascii?Q?KbNhjGZ4S0sgHpNjUdtuAsCIqtsc+QnbKChZU5ykVRSC8RDme4xzqPIQ/Vjs?=
 =?us-ascii?Q?gZ7wFg/4+SUxwvRwGg1ZlyCXgQl6AZwe30gA2E7HQjy7uwYVBpzVb7olA2HX?=
 =?us-ascii?Q?rY8Zz6TmO9Ef/88phFDIxElrf2RvvgXurk89ZpVgtCZO1thz1fpCG7uTEpKZ?=
 =?us-ascii?Q?AiszGlCFsrJCMlN29+2exJYfmPAJ7qe/rai7xLGcgSrHU8PEEVuB7507DXpl?=
 =?us-ascii?Q?G5dJ9wG8gWAPmD/VlFmKVu0LTowZBxx28IxPXXQQVGvuL8OEDzEh9YTYPdPn?=
 =?us-ascii?Q?LH3XNEUWmIFbuq1j4FJnis7tuvnWoiZY4NSke0VKtpKURKTApy+Fa9O1KAtg?=
 =?us-ascii?Q?HBYbk5l3hTG4cfoSxE8CoA7n1A7oQqBxoUpEEtzW6ZCJ2F2z3+Kd0cVn/SQg?=
 =?us-ascii?Q?lXFLqQDOd3iKhSnRmt3PXS+dAPRiTz8xVR1cvVwJkXxI1a59fGL4Aoyp165O?=
 =?us-ascii?Q?BW23V+GeL3ac66Ew4y3oPgidPi+HuswyVGNEOcyu8EhBAwUK12Me5ZvM7YVA?=
 =?us-ascii?Q?PqnOnu+A4QbJGrw6HSJGr3TOA7pN/tg353eai65uEJUIt1tFy9Zj47kqpY3X?=
 =?us-ascii?Q?7/vxwCrsakXWPxG7cjio2YjLqKpbyJgkzip7KwdF/uJiu0ErBPOdn1e/lXCW?=
 =?us-ascii?Q?mAAhoDCFxw0TQcSe7wbr6DylW9twQF66Liazowdqc+EP8i4euVyo7+gZ5s0V?=
 =?us-ascii?Q?NllzURubun5ELPICs5ux/TcRoEru+gm+VeVvxYapUem/YumcXp+EDdPv3//r?=
 =?us-ascii?Q?dNsxLaJJtBePEbUqK8eDF/lPCcAwpYYfcUxP4dn/0b10FfWHWu//jIHXfsOf?=
 =?us-ascii?Q?o7Ebgfl/3WKR0Zp4eftEkl0o1HGfqkxKLV/lhnGGdK8zxY/mlxBWvF93KleU?=
 =?us-ascii?Q?wPoBnO9WxEVWgq1RjZulrYPo2Uw2mMUBrAmkntntfB3GCLbvJYXDlGNeMitH?=
 =?us-ascii?Q?bGa5P3pv8xuBwgmIVHoFcV9vpNvv/g0FgnNrsoOKKeBTdqdi5BakFZj2YmZn?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PTLY1++XyiBqre0NFH4mdjGaY590cm0xIFBQaPmmJV+NfzayVe16v5UIBToCOekkuKihAvbx4vu6FdUa1NxBA0qBFQW/OhmM+DNEQiR6jqBWG9cTOvHPIrPtjvQQi+bdVyoNgB/VYQn2f2ni93muLBs294+fWXHKowVoVVosNxeevv+PbUkNGEx+q2rIhyTQnsSPOywQghBpr+0QBMMLtAifHUGSOtJi/YjrFtHLdYOfP+dzjp/8GxurjsAuJncw+uDOGd8m7EaTU1Da+1/jox/fJtSBlkBblIJb2eX+UaYiKCBCt0lmoItqFI9QXPuMs6HaumbN89aaCypRMOc3xO9l4HyGoxYY8qPEsau8ySai3SUtHWFHXVNO1Yi/F4QRJWV1JpLU5bv5++P3IQ39WcfZPIlZn4dF2bHw+XS8EJPEUdUFtXFLhf0UWG8JRy66QikaKVHB/h9b/rfxJHWFtNgDtiPQce4qeqepX12rsCKTvBNRqV5mN8n9vl1KfYUV5HA5XXL6AXG03H+RaGpso05pKr7NUaJErqIDljC8nSVi1uh+W0bL/A6W5+doqw2T4PB/lMvHXp6VZz4gHYY35sVEggakFG5+jgcUOrS1rMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161fdf3d-70c3-49c7-4a84-08de0fd1dddf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:57.8852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51StJDZ/2gUKVY08N4SOgH5ldhptjN7uKM6Z/E5LXegiQj1AN0PzqAFNSjHJ+sKBzl6jJmIBTuC01zEEPih6feeAZLNcAkKe5kQK8rRKwcY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX0areCe6CBfbR
 1XXGlytbmYU9O9JuR/kM/XIlbA6JBbu6sr+3BFgqe0BYGPvB4zzZepx2awHma1L1NvS8wbnEdF5
 TDOKj/8AF8pDt19m9v8ZXvPl+Ehgbw31uu8TApceq8kM9Rbx41RwJ9rv/W6NXilXoaC4pm8UxiR
 w62yyHXEJEV1yy4O8ey+JpAXM3symXG7zv41k8oTUl8ycxnNU5UJBPKUgx2e2AJkoinsIrDcEjX
 zHpeOj8AezQXEOG/hMh5B91MGVh5f3IW8H+umsh7wIJMvauua/1gWzwacVkplRF+rsXht1mp9yO
 9qXaU/Nhr8PTJ9eK1aOtaQvGnsfyC7snTuWe8WNdeo2reX4U3i9Vs6s0xsosqYKsOb40Y39rv3q
 mZTt8ABJ9d9pMwsdr9Q+g30enJcBC6gF+rjL43dBfVt5ZdvfoGw=
X-Proofpoint-GUID: lu82oBXbfT698n8ZeRb8EIcU3kuMs9Yu
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f62714 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=ANQtcE5oiNAsODQ0kQwA:9 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: lu82oBXbfT698n8ZeRb8EIcU3kuMs9Yu

We introduce the io_remap*() equivalents of remap_pfn_range_prepare() and
remap_pfn_range_complete() to allow for I/O remapping via mmap_prepare.

Make these internal to mm, as they should only be used by internal helpers.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 mm/internal.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/mm/internal.h b/mm/internal.h
index 3bd01028ade9..cbd3d897b16c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1666,4 +1666,22 @@ void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
 int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t pgprot);
 
+static inline void io_remap_pfn_range_prepare(struct vm_area_desc *desc,
+		unsigned long orig_pfn, unsigned long size)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+
+	return remap_pfn_range_prepare(desc, pfn);
+}
+
+static inline int io_remap_pfn_range_complete(struct vm_area_struct *vma,
+		unsigned long addr, unsigned long orig_pfn, unsigned long size,
+		pgprot_t orig_prot)
+{
+	const unsigned long pfn = io_remap_pfn_range_pfn(orig_pfn, size);
+	const pgprot_t prot = pgprot_decrypted(orig_prot);
+
+	return remap_pfn_range_complete(vma, addr, pfn, size, prot);
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.51.0


