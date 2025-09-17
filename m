Return-Path: <linux-fsdevel+bounces-61993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DDFB817ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 383441C28696
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFCE337EB0;
	Wed, 17 Sep 2025 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bHu0b6Lr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZmUJ+sXS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE293330D47;
	Wed, 17 Sep 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136345; cv=fail; b=BUp+ZEFossCmye7/Nci5GWIwFYaTGNux3uEXf2UsS8jUgq1kP37JxRsIWtIyvPL2bQAt1lOo6zL5yqgIg233Y3dES2L2+mSZhJD8MM0HnVDOgn0FjUNmpPMA5h/mhInbx/TbBhxImM9Rz1NttqErl2GXI/CylT22YgpON4uHSfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136345; c=relaxed/simple;
	bh=cWcGBiprI3C0HEzyacXB1h5fGxn7v+JeltaW0HVafN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PshRZ6k/eJZaDU6/4L7IT/1C0RbNH6kLMw/QuzH/U7IYMVSvfVzr8LgltCMv/+OwM1CHzkTHUfm8dCX1N0JSkwHGA0JRj9ywngz0RCmIXohHq29cH3df+bZxcClns3INWbEan6yUJCXxe0Uaqj3UPqrKFYreRWrfVECS98+H8Pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bHu0b6Lr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZmUJ+sXS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIV3K008351;
	Wed, 17 Sep 2025 19:11:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dIlBonpzpBuI8Nh/1IICJAlRCKSS6BU3sWWec56GXQw=; b=
	bHu0b6LrJ10oycvtih2RH+pbANslb128U/M69pZYQxmyzC0e7NW/7XI7gR2exV68
	eyCkWk40DWJT75yyccQbcibtya6Vj11qWkI+5wU/h8O0nCR6PfscBYyW6K+cnaXR
	/yGqctQjDfLFUteEzObvoHbI4ej4khtWf6911bq7DzkHKNi1N4h9KNAcYO5Ormp0
	T0ruBh9cg3bW42kB9HMPskbkMD2ivvIPU/CfZO1TSGIQHyu+IkgNDqzCSTi9FQEa
	+Eor12ZX6GtY2ugItrK7B17ypiIozY4HoasGhr++nK1FHp+VIoL9SWWOt/hxSiEM
	hFXVp9Q/cEB4DbZFF+4STA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx8hxnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHmk6a001628;
	Wed, 17 Sep 2025 19:11:37 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2edr1x-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4ZST5UCiuQTW0pSBWto1euqggAAc7NcRb9D66KiyMMQGLMOg/DMCK1I2Fely6rDnK2AH7urgW/caNvqttkRFmnKE1zQUFi6FAlHKt4tUTiyf3vL7QtQdGHauIPejJwDypBqcLQgKa2GhPRljWkvM2GH3P1Dr1uaNGZVaJqlUP+kSqgHGg/Ihl6mWirx5x/ORsrKdWY5vwLzG5f84JTQ/OCAT0IQdIvbRKxXLg9yGNgJHiV7/TKi+3A02YQVb/Fiuqcj8ufxKWMHfQpeRZgybxeDBmXWvnTVSz9kNaJrGot5Dbqtygi/XpwYldG1IPKNnQjo4R1++5tN5O+TcakBFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIlBonpzpBuI8Nh/1IICJAlRCKSS6BU3sWWec56GXQw=;
 b=nAvyWR0AvSdu7zeGW/IYTGIjbMcKwyqZ2QqIvlfc6QimXudV38lgL+7tHljNymV561b5csQeZCvohRnaPQoAX6Obkp9ymMzMt24hqXrQ7enf820EIGwse0N0i9UMeN64Aeyad/oC6F3XpGa5VbWWsOmuvsw8/tr3UE2PfdBmrXWb5UKgBhyx28VLkD9CE9FeNDVDoJdUGUVrWBWF3UC+iIR79X787qAGIM2do7ZGXztM/qtHI6pppjrbOamZZQMZFfm2ri8QRkYhAV/zvRlGPKauYI9yoV2o9cmCkC9vg95Da/8VQLuR1YFefemf+4dKYDd9TcFrwgcZc/8Fs6+Z3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIlBonpzpBuI8Nh/1IICJAlRCKSS6BU3sWWec56GXQw=;
 b=ZmUJ+sXSVx2dGRodDDK3mh+6z6USh4L9hSpQEHo6V0WJm2z6CyeTr4dTmWr6pS3BfXrHipKl9HLGYXs3g5dNwvL3BJv04D+QMzqyz6t/dh0cVP82ncBSgYDttW1rjbg+tB5GgdFF/cauAtuX6/usi8MBN5wEke5lR9kP5o7r7lg=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 19:11:33 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:33 +0000
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
Subject: [PATCH v4 06/14] mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
Date: Wed, 17 Sep 2025 20:11:08 +0100
Message-ID: <ad9b7ea2744a05d64f7d9928ed261202b7c0fa46.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0014.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: a7766dc4-57d2-4ac1-35ee-08ddf61e03c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bDqAbRMjatjAX2nr/xCsbYemcIGicxOqqPOKNMMfUHlGxvTs/B0k6rzrOI9c?=
 =?us-ascii?Q?HgLXgNY2YTZDKDspqISduWEKgsjLRHFD4TPU8G39g1ZjJTlv9v4wGBLupGAs?=
 =?us-ascii?Q?5OFyeOc4pSkkTCXIddS6fsaP0xDC3J6bA3+a8CbTxUKdDFYYH6GWf1l8HkGA?=
 =?us-ascii?Q?6eDhf7QEKtb+VDTItvA+zGAp4WoW2w147KVXv8mcZ8+cje209EAiJqxA4gVU?=
 =?us-ascii?Q?Blim1TG9N9LE+GfI4hcJn4HJWV5dGF2sQj0mkhD4sSA+opqhneR7hXyn6WZL?=
 =?us-ascii?Q?UpiAdLubJU8j9O8O2q6MLY1+YPRIsE/BWBh5G95wAPuCOWSl2DNDeMXtdRX/?=
 =?us-ascii?Q?0eigKC1bZpXwLgtpRbOODsMGjD+lSqm9YM90N7pawwx3pRecp53lSLtlEE8I?=
 =?us-ascii?Q?mPYD/rO/9aPLxZHlZ6+VxVvCH844UgP2WqFS41oliM8sCObuPYyoyg4o9sY9?=
 =?us-ascii?Q?zILBa1gcCNKVb1NLYSvW4NlXJPEHgy49NBK+G2vnIAbsuTDo1QjVk8iSiZ2u?=
 =?us-ascii?Q?QcaYX3GuvlCYwb2kjQ7bxPpnzHSyQ2bUamK264Z+Ord84NXdURDMFOzOjCqA?=
 =?us-ascii?Q?vd8X2Vb/IWNc5tqlVASoe+ZIIQFXJht2OsjNBdzs4pGmdyy4ppM7xTaJI8zl?=
 =?us-ascii?Q?Qga4rG+npGQ+99TUc+1h3QmKlPaeoHyRuF6Y7jzF64+qfF53hVSSlz4LjLC5?=
 =?us-ascii?Q?QLuh6Y46Cfic2kFzeLa1m0HFKvYLkBX8F+GxkD0nXgeSElMWP1M8F7xSAGQi?=
 =?us-ascii?Q?9C0Xf0+XZnZtqvtUwOsb9pNIMfBcPmBPxtYOjbYumwTD6ldwBbATaCQGrVGh?=
 =?us-ascii?Q?QYEMbVFwv8lXtFzicUq3LG5fuOHiuxOC0SyA576KLcPSuQKzRAsNOJHvKVLu?=
 =?us-ascii?Q?9916mHDx6t0HMNbURJYaOvZhKkIy9/spkVgZi3cLWzyUuv5qFDBfFr3xznI2?=
 =?us-ascii?Q?hFS4TAs/kCbSJJx5BrgvhZTbuS561YweGic+iEqSjODyU9jUJqCWexZbRkln?=
 =?us-ascii?Q?5wrjymeWKdV8wzY+GZzr52OIYiAtr5wg9hvdycM/HLzKIao0+cArkDYjZFAg?=
 =?us-ascii?Q?+jk/oZ+LAFRJaENnTSiQnAEHhAvGvg7jn3lvMBmeVvKR+3f0u2Rr7TXYBnzz?=
 =?us-ascii?Q?FjUgS4BVbYfD7pkNqO6+5JSxYudUa/yB9to9/Xiew5sTO6IkcK58LC5S+lP+?=
 =?us-ascii?Q?wC2OhimpY9mgSgc3NJdfzhm5aCJ+09BctzfpvHYcKHhQzIv+l8u0PQfVvtFN?=
 =?us-ascii?Q?yEZ48C7DdC5pDlNZUCm4nWyB44+d9pfIuqtjP04BH+/c8NwyeCHItJg7KEkJ?=
 =?us-ascii?Q?mKWLJOfjdbrvNJng9QnRha2wUbP85GxfZJCWi/QRInuYuV0vAxVwi49Uzqa0?=
 =?us-ascii?Q?FsoG65uKdqszbcjOlAK0DKI312rJb2Z6HrjpWrWaKvC9g+fADj4J99ZSdxnM?=
 =?us-ascii?Q?nOGhyWgoS0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K0kVxfjf9YE3Akp/wPfb8sYjXLU0U7ZbB9cnhZXBvBO4KC0uO2wHTBlsxgbQ?=
 =?us-ascii?Q?ow6H4C/cF0i5NFB/W5uyI89rGC32p48Kcv6YSdK7aRii4Uk/doA1lzeGPtLY?=
 =?us-ascii?Q?H0fi6XpwzFHHSZbGorcZJQUri8o5Ukrwh+Iasq5U7LGcoQlxt8RrAc+7080g?=
 =?us-ascii?Q?OpVWRqom2vur/xsPyqx59Z07y1YUWvKXmZJqWJx7RXqPiDOdFj0w2eg4TG7X?=
 =?us-ascii?Q?esVszBzk6vGw7R3C5MeqcneWSx2vSIQDu8q2IgZkY4XNWH7CvU2opM/TPlg/?=
 =?us-ascii?Q?i3Du1aVfnPTNjsRY779tn0CUi9cTCTU0iztz6neBy12z1EwWUyhsuwomVuok?=
 =?us-ascii?Q?i4xFBIV3h0kiT3NKhE+Ya/Wrei0IcvKkiqimm7sGQJaHh6kJ/Lh+d50MlYwo?=
 =?us-ascii?Q?XlKLpoqA62FC56gXlAAZeu2CKl3yOjsNVe41h9mFetO/2bwLRZySHe9P9a3p?=
 =?us-ascii?Q?R4DSmRJ2GXUzgpL3TnOt6MK3ekDTm8B3k9ilsn39l/s5Vhex6FxbLfeiXGlh?=
 =?us-ascii?Q?14kmu7new+2QNjKrm4j20utw1D9xRLBVB+ZG6xFM/XvHdGVrAoDlTb/sob/G?=
 =?us-ascii?Q?Vf5qLvCKfjJcGyAkcy9Xe2qkSZeD977pkNSQxd4RDmvykuhpv1AWn7eTax3p?=
 =?us-ascii?Q?9/0DJ1rSdxvFa0OtPyaxdePQ6Ma+YNoYxL2W2YYYjfV7/6FsGr7y2r4uKmdq?=
 =?us-ascii?Q?8JDAHg106qTpZnXbR7s94Po/PktwRrMkbwXr63NIoqIrgOhAUGywRnsfoqAf?=
 =?us-ascii?Q?AOrBuKg9FS50Ju5QVtUMFvPgN175fNCyq3Eh6EdmUEGDyN3/WWlRjdEFUM46?=
 =?us-ascii?Q?cP3bMWeuGciqBjVuYJx0Qh2vQU4qa5Me+wTAhPHDZkl2QjGd+I1dPYU22dFo?=
 =?us-ascii?Q?IK3cli2iGX+nGMfYxGc7OhBylcJ+Dg09YNxZnv879Fmm+VoD/VF2INWcpxyh?=
 =?us-ascii?Q?Aqzy/SEAWwcgiJRX8CTP6x6/k4b3eN5QzmoTw1wSXia2/m6ABuyxyN985vFf?=
 =?us-ascii?Q?lRxAWa083Iv5M0b6gMGQxtXIk6aHvNH6cSamJgyZ1BqFzT/2NLuYV+Euk0QG?=
 =?us-ascii?Q?sV5vKCvT3PXi2S4kDDoPNLhVTLCjrafksT6uE+qLXw0hWuK6n3tuucZW+1Pa?=
 =?us-ascii?Q?UegRRGb2PiT4qM6aN/ZnYArYNsWdETWQDT9Gz2Mc1WoP0MEtyW3wHtf5affR?=
 =?us-ascii?Q?BOjCYjcntZJ+ATEyCx/xKG8n02HA5k3Xjcy4a+DwbNLOcysd4OBSKMTgeyh7?=
 =?us-ascii?Q?PZSauYi64aIzd/jhFWq6KxlgTQsRFBGEvkUVkhmyjqjcAFfNY7M2vHBiux9m?=
 =?us-ascii?Q?fqKmxj1VpBOA71WhoK6qvnan9KnqaSF6KcRDJ0hhawUBtDEo0IF6klyKFkdV?=
 =?us-ascii?Q?nHTP+S63xVzmxGDn6vyp7wXwgNH9/XqLGyBWnAkQ5j5HCDQC+2Expq8fLYs3?=
 =?us-ascii?Q?TALjIyAlTixuechDbeS7k0PtO1LweNTdHyd9Si8QwGYRgAIThz5ilauD3Ci3?=
 =?us-ascii?Q?Hbt0VsxFg3r2lghsvQ6JLnKYw3y55ftH2Im+/aoDSL/78RXDktS9asHAemOB?=
 =?us-ascii?Q?k6UP3nk+9yuqyOIUFWVnPnve/50HQL02mrk7ZIrlydpJsBnKr1MM0tvGe7FL?=
 =?us-ascii?Q?yQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zC4uA32LqU8rRzKlE666zL5buXwBSsuzdc1zilkiKsuu/piXC1aXI8FE43gYYgXqUHnRdhNvC6plnMKCmf6Gm8aHvelfdwdBdBIlPbw8nc2DNpzbntiOhfaj/Z1H1Z+mUNnO+ka27kcZ7dHXik6G7hWLxWyKpfR4tOaM0ahHQZm36xG3UqlaoNGi0PGY/AceSTrw++O682n+4TOgwyDpr/I5k0iiBakJ0nQqN/5/YcijRz9CY6S2K51hj6l6uDanHjaajig5SegvR7HwSRyT0yZVso0a7gsCG0m6ZBzwqM4NSNnBBjjchQvLxHnhmemVrytGCqZ9iDzZfBwIATtMa6cFTlWAlITiD9qiNLDDRdA2IX4+taiKCLol7IvU7jDwhFwswIECyVMcHrMCscTWe/mXkjBVG6oGZwlpSWtm91APmHoVVZsce6qiSgn9YwTtQO6PelfhhY2y8aEZj0L6CtelX5O0aI4VPDNv72GMkyOrZsc5J4JtKQz4+Hiz4mgYRzVFTlIxpb7CtYxI3bBzWSzpTANmOsyg+JE5pjABiA4mQBffVOeEL3jAkPqHG0wjWH4/aTEf8MOAw24drXIx+Qqb9ttGc6TFnZpZpneEqAU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7766dc4-57d2-4ac1-35ee-08ddf61e03c8
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:33.0660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llczs6P3tk7pmlOzA2ourIgQNKNI47GD6U5NEhPfU5YZXaCIIwy8TA+GTSPpQUb3WE9IsbzVuw8EysglnD7bJa1WAWUe1zf+W+FG2ogZB94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170187
X-Authority-Analysis: v=2.4 cv=JNU7s9Kb c=1 sm=1 tr=0 ts=68cb07ea cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8 a=AjtsbyE0BD3NTU5drM4A:9
X-Proofpoint-ORIG-GUID: 3Jm5M0sOtmcUr9UARYG2sJm3tDuyWkls
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5Ipu2ODG2TaZ
 9+Th79zwsIi04K44Nr+U32XPgs52IeDmMZBOn0HccDUeskSU/jl+bdpibEZshuaNEGbaa/yaXfD
 kNq2150YV+letupKFzRsJH8u8VAC4XZtxX1GUlAJKIP8eET5G1pcRzJudErzGWg/jvcNBO1aW/A
 9VVGm9YcjZ63E92p/bzDw26N+nhyFb+tEftOYdeCzTpHURnPTXJuSl2Q6lVCCiGNsIwSrs1VM9U
 PdZGxG2ETgE9rRq332NqZhaf6nAgd+ZkSaEMg4XUx/07rabBfOz6EVqx1xqBub6epgwDXKipT63
 CTSnScg+cAU3VahFhBLOtrx33c6OfBzhIb+1X9nfKNQG0hxG5OfqGe6uFYNaoZwj9xYcqCwNEW2
 hrVdfh7Y
X-Proofpoint-GUID: 3Jm5M0sOtmcUr9UARYG2sJm3tDuyWkls

We need the ability to split PFN remap between updating the VMA and
performing the actual remap, in order to do away with the legacy f_op->mmap
hook.

To do so, update the PFN remap code to provide shared logic, and also make
remap_pfn_range_notrack() static, as its one user, io_mapping_map_user()
was removed in commit 9a4f90e24661 ("mm: remove mm/io-mapping.c").

Then, introduce remap_pfn_range_prepare(), which accepts VMA descriptor
and PFN parameters, and remap_pfn_range_complete() which accepts the same
parameters as remap_pfn_rangte().

remap_pfn_range_prepare() will set the cow vma->vm_pgoff if necessary, so
it must be supplied with a correct PFN to do so.

While we're here, also clean up the duplicated #ifdef
__HAVE_PFNMAP_TRACKING check and put into a single #ifdef/#else block.

We keep these internal to mm as they should only be used by internal
helpers.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Pedro Falcato <pfalcato@suse.de>
---
 include/linux/mm.h |  22 ++++++--
 mm/internal.h      |   4 ++
 mm/memory.c        | 133 ++++++++++++++++++++++++++++++---------------
 3 files changed, 110 insertions(+), 49 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd1fec5f028a..8e4006eaf4dd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -489,6 +489,21 @@ extern unsigned int kobjsize(const void *objp);
  */
 #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
 
+/*
+ * Physically remapped pages are special. Tell the
+ * rest of the world about it:
+ *   VM_IO tells people not to look at these pages
+ *	(accesses can have side effects).
+ *   VM_PFNMAP tells the core MM that the base pages are just
+ *	raw PFN mappings, and do not have a "struct page" associated
+ *	with them.
+ *   VM_DONTEXPAND
+ *      Disable vma merging and expanding with mremap().
+ *   VM_DONTDUMP
+ *      Omit vma from core dump, even when VM_IO turned off.
+ */
+#define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
+
 /* This mask prevents VMA from being scanned with khugepaged */
 #define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
 
@@ -3622,10 +3637,9 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
 		unsigned long addr);
-int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
-			unsigned long pfn, unsigned long size, pgprot_t);
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot);
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
diff --git a/mm/internal.h b/mm/internal.h
index 63e3ec8d63be..c6655f76cf69 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1653,4 +1653,8 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index 41e641823558..daa7124d371d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2900,6 +2900,25 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
+static int get_remap_pgoff(vm_flags_t vm_flags, unsigned long addr,
+		unsigned long end, unsigned long vm_start, unsigned long vm_end,
+		unsigned long pfn, pgoff_t *vm_pgoff_p)
+{
+	/*
+	 * There's a horrible special case to handle copy-on-write
+	 * behaviour that some programs depend on. We mark the "original"
+	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
+	 * See vm_normal_page() for details.
+	 */
+	if (is_cow_mapping(vm_flags)) {
+		if (addr != vm_start || end != vm_end)
+			return -EINVAL;
+		*vm_pgoff_p = pfn;
+	}
+
+	return 0;
+}
+
 static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
@@ -2912,31 +2931,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
 		return -EINVAL;
 
-	/*
-	 * Physically remapped pages are special. Tell the
-	 * rest of the world about it:
-	 *   VM_IO tells people not to look at these pages
-	 *	(accesses can have side effects).
-	 *   VM_PFNMAP tells the core MM that the base pages are just
-	 *	raw PFN mappings, and do not have a "struct page" associated
-	 *	with them.
-	 *   VM_DONTEXPAND
-	 *      Disable vma merging and expanding with mremap().
-	 *   VM_DONTDUMP
-	 *      Omit vma from core dump, even when VM_IO turned off.
-	 *
-	 * There's a horrible special case to handle copy-on-write
-	 * behaviour that some programs depend on. We mark the "original"
-	 * un-COW'ed pages by matching them up with "vma->vm_pgoff".
-	 * See vm_normal_page() for details.
-	 */
-	if (is_cow_mapping(vma->vm_flags)) {
-		if (addr != vma->vm_start || end != vma->vm_end)
-			return -EINVAL;
-		vma->vm_pgoff = pfn;
-	}
-
-	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
+	VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) != VM_REMAP_FLAGS);
 
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
@@ -2957,11 +2952,10 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
  * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
  * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
-
 	if (!error)
 		return 0;
 
@@ -3002,23 +2996,9 @@ void pfnmap_track_ctx_release(struct kref *ref)
 	pfnmap_untrack(ctx->pfn, ctx->size);
 	kfree(ctx);
 }
-#endif /* __HAVE_PFNMAP_TRACKING */
 
-/**
- * remap_pfn_range - remap kernel memory to userspace
- * @vma: user vma to map to
- * @addr: target page aligned user address to start at
- * @pfn: page frame number of kernel physical memory address
- * @size: size of mapping area
- * @prot: page protection flags for this mapping
- *
- * Note: this is only safe if the mm semaphore is held when called.
- *
- * Return: %0 on success, negative error code otherwise.
- */
-#ifdef __HAVE_PFNMAP_TRACKING
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+static int remap_pfn_range_track(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	struct pfnmap_track_ctx *ctx = NULL;
 	int err;
@@ -3054,15 +3034,78 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	return err;
 }
 
+static int do_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_track(vma, addr, pfn, size, prot);
+}
 #else
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+static int do_remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	return remap_pfn_range_notrack(vma, addr, pfn, size, prot);
 }
 #endif
+
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn)
+{
+	/*
+	 * We set addr=VMA start, end=VMA end here, so this won't fail, but we
+	 * check it again on complete and will fail there if specified addr is
+	 * invalid.
+	 */
+	get_remap_pgoff(desc->vm_flags, desc->start, desc->end,
+			desc->start, desc->end, pfn, &desc->pgoff);
+	desc->vm_flags |= VM_REMAP_FLAGS;
+}
+
+static int remap_pfn_range_prepare_vma(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size)
+{
+	unsigned long end = addr + PAGE_ALIGN(size);
+	int err;
+
+	err = get_remap_pgoff(vma->vm_flags, addr, end,
+			      vma->vm_start, vma->vm_end,
+			      pfn, &vma->vm_pgoff);
+	if (err)
+		return err;
+
+	vm_flags_set(vma, VM_REMAP_FLAGS);
+	return 0;
+}
+
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target page aligned user address to start at
+ * @pfn: page frame number of kernel physical memory address
+ * @size: size of mapping area
+ * @prot: page protection flags for this mapping
+ *
+ * Note: this is only safe if the mm semaphore is held when called.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int err;
+
+	err = remap_pfn_range_prepare_vma(vma, addr, pfn, size);
+	if (err)
+		return err;
+
+	return do_remap_pfn_range(vma, addr, pfn, size, prot);
+}
 EXPORT_SYMBOL(remap_pfn_range);
 
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return do_remap_pfn_range(vma, addr, pfn, size, prot);
+}
+
 /**
  * vm_iomap_memory - remap memory to userspace
  * @vma: user vma to map to
-- 
2.51.0


