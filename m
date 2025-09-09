Return-Path: <linux-fsdevel+bounces-60641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F8CB4A821
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 11:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD4831C61E50
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 09:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578102C11E6;
	Tue,  9 Sep 2025 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rJoxywO/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HIT3+zuI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127232882B6;
	Tue,  9 Sep 2025 09:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409739; cv=fail; b=t0uS+J/bcDSH/h/Br9LUaJNtrYyF/vpF+nvCu7RvrjJw/wQ0ocALPjiW44HVglbDDhhaXkuhOswp3lg0k+NwZjV3pgFCMGBCQWZ0A7sxg0pi2AZycE280ucr0fQuLX+MwaAZSnHTQlqhGyB7RgXvYCR0ryX9DiNU0kJK6yczpiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409739; c=relaxed/simple;
	bh=Jm6AVTteZQOrMzbVnQEzE7LDVy+ynhm3c4/hJNWrjDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y514sstcTCEYuF7cSO8CrA9U4AXbuRVLd+R20CQ6cLYn0lCER3lIWlb/M/0T93u+IH2TPrQBUzGzHxssFLbJkXTkubDGfYbbG3KsPUwyU9jiIe+odB32E+BbuxG9nWlmaETyg0GDFg1AHS8V9pLpBKvbYa6Q9scm+Ln3I+lMaBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rJoxywO/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HIT3+zuI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897g23s009632;
	Tue, 9 Sep 2025 09:21:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=31gLRNrjbFDKLczjXZ
	yUbDsvkbA0iZ5t+mBrqJdTkio=; b=rJoxywO/v31aeo12kGrAOQ/wvPkFEA2Nd4
	dJkYCNWBj5EbhBhlnrY+xRoNZU3C1lUr+8DM0elSk/aHe8WsfVyhClB9v/GnexcS
	cEJr7s3cJnywpBftn9S58LRwfH2bTDuqj188UZRmECzffji2Qr5y3O1Nnoh+iZTe
	DK5OBaDgNvIQVWKukhNco1MtXc3FBAINmCIL3hZkCfs+erbsq8vqy3opmztcHoFN
	aGrdUdwMQOIB7dZ177pmZccAPduylnVJIarkwrWDnu2g7aCdOzL9ySUe1GDExg+K
	x8p2cnK4O7V9iksr4p/uEYenJblwkq6ybTVNanm1tBuVPpifqgOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgsefe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:21:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58981Qvs002897;
	Tue, 9 Sep 2025 09:21:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdfv3me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 09:21:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlPjvtemWHvMAlGof0t/JlJtzFfZafUPNu4HappUBEkkkQh8/eviId9/OlTuGXdK3nv7fORENh3a1JfF0pMxpQHnRpbpTV2mXLyAlwizBFf+zS702QsYYuy/aPuw31Y8lLmZIe1/1QCZxphwm0GXubWsdE/YXkR2set7kgYM5BMDO2hrh7WwqSm6FBHLxgqy6x6B+ed4haD4UeOpnFjeKTlF7Zlb2qSCcDQ7kxHoX4m2syz+CQVUkTeaBSGpABdodJ14ozc/iIwmJIPVsKyeMeIV1I2qU0BaclaYSkJni1Pl5NXr43GDGpsC/M1h6duNbwMNS7CM1Wm1o2myBHlEUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31gLRNrjbFDKLczjXZyUbDsvkbA0iZ5t+mBrqJdTkio=;
 b=DtF5zI2LDrWBKCi9o5eExbmsLLxEkWNWNxqTPtVkG+ju+w/7Q2ncmOca8W9Qdm/TUALVZmoybBTNdbew8bW+F5PVUZttTHl8u0OoGRp6wCJ1Wy9A5EitLjeB52mjikvEFqKVFy5EAbCambTuBbpY0UyMX8BrJoJ/MzYkLshLd2r549QrsmO9VBYJ9MgoNawk5io/c5/RKXEKK++nw+HjykqaOiEG1pm3kTx/FhnZ6ggx3UkKs0AFeAiWYYxIo5gnogbYlYnTdkc2SKqumwMrbRgPVw2/k1hGLV+ZtYTfQcOTJSy4/t4MaJBKOuHhGoUbfpNQG7MuFy9GvWVhOizLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31gLRNrjbFDKLczjXZyUbDsvkbA0iZ5t+mBrqJdTkio=;
 b=HIT3+zuItOSS3b9r57YGtByto5+D+f0XXSdKoVdtxV0/RfjE5n3seUElTVSACMlFq92n0OAc0m2fS1rQGKeOZQJuIxwbwbPtqXoP2/4EiX7GV2KGma+1VqTabRFVYNF7mw49PZ59UA1T1NDwGvGomqSyIyWt9Fgq5dTFKjbIj9w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4969.namprd10.prod.outlook.com (2603:10b6:610:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 09:21:29 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 09:21:29 +0000
Date: Tue, 9 Sep 2025 10:21:25 +0100
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
Message-ID: <731db7f1-5a0a-45a3-8173-be1f19470bba@lucifer.local>
References: <d8767cda1afd04133e841a819bcedf1e8dda4436.1757329751.git.lorenzo.stoakes@oracle.com>
 <20250908125101.GX616306@nvidia.com>
 <e71b7763-4a62-4709-9969-8579bdcff595@lucifer.local>
 <20250908133224.GE616306@nvidia.com>
 <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <af3695c3-836a-4418-b18d-96d8ae122f25@redhat.com>
 <d47b68a2-9376-425c-86ce-0a3746819f38@lucifer.local>
 <92def589-a76f-4360-8861-6bc9f94c1987@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92def589-a76f-4360-8861-6bc9f94c1987@redhat.com>
X-ClientProxiedBy: AS4P190CA0038.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4969:EE_
X-MS-Office365-Filtering-Correlation-Id: 89999ccc-2fc7-4e20-bec3-08ddef824249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RlSe/aN/nSDTW6gazHuL3KOb88hjJ7iO+2/GVOlUJs703rYKhNzOhwySIP8+?=
 =?us-ascii?Q?31aXOYRUCYvikdAxt0Q/OKbGqjBIDTTYLvPPbEjpOhEhaFTZrMVjcjooK+1v?=
 =?us-ascii?Q?1/yWwmPl2pZJFWP8aT3bUu7Me+B/O8uFuAXEs9WFHt0BuK804uqTc+PS3yAk?=
 =?us-ascii?Q?SaW7PhGb2aISdA2J2g5LzW4XulK9Gs7GmGXoZwn5X1FEotfmfT36ZA6NndAP?=
 =?us-ascii?Q?2A8KRQl+S63VMqREW9R7FdNqvbECiXpFadFcHQWzVzzq+hTpdo/g8KENJS4t?=
 =?us-ascii?Q?m8BHEVDyNd06ugn/GCmwiiox8OxbtQ3kPM957wSTDNErS5yFtuFHOfyWbxfs?=
 =?us-ascii?Q?SoaaBV2SpTwSgU9Ax3q5B8hGoVHkYyDX/tOffqY2WXcckjhYrXPdh+9J2SMC?=
 =?us-ascii?Q?7MuO20frEInwSbwR0Tx2as9pFfLjmIqMAKfnO/qntM/WuGbKQNZuCuArS3iO?=
 =?us-ascii?Q?nVRuGEonww0u6yxzRS2k7KbuLSa6d2WCbF4VTLPBIVKZpLgqCEY7JlovllQk?=
 =?us-ascii?Q?6wr45BPKJoErhuSKLatV5NCNIyiTeLMmr1UizPSI3NUwJ6+zgX37yiEhAMRD?=
 =?us-ascii?Q?VilcEcwkYNpTDVaUhQFYI+8B84y/a1AH4FTfyjOujalGb8qIy8ydH39AZ5Z1?=
 =?us-ascii?Q?W14ZmTj7vFds1/BrMIafVL/m8PQGTMi1hcxMXK+zQFYQm5/K9ZgkTCjvHc9y?=
 =?us-ascii?Q?8a0nGLyBxhOZIm0F95o7gcscrEVnVeHLMOID41xm9WczpWmBs3fXNR06rFKN?=
 =?us-ascii?Q?7b1lsZfM/0ZcIHQ6W8X0VhVqS6ZNDgAlMmdpmsTPPDrwqmFBnVVjmqWrrT8K?=
 =?us-ascii?Q?rq369XjGkJsbInWDLmIPW5xUrxZ4g2jOdCz36sgH4hWUosBNenppN049OrxY?=
 =?us-ascii?Q?udfuKqrCagR5Vknzx+6djYcbbtUZ5TKWA8oEUBS3Sy8s8q8VjEBFruREQOjl?=
 =?us-ascii?Q?WyYijjZGBpElyVeIC7HXQdampz1kBEzKMlOEn1qn0sRtQTfjUlbvCpdWwaGv?=
 =?us-ascii?Q?RTwMF10z5U5Ew3t/JTJM2+EVcCiNvgBor0FfMvnfemlKVuGFcp3xTZazc8K2?=
 =?us-ascii?Q?5wc05Vi7IcmY769qGYpTkA+14yGtdQTzkDZZQZagkBSsITcWZco18WZF3SQ8?=
 =?us-ascii?Q?Dw3k3JvktAlfVfC6esT9fApSOPCJBzOYo52jXu3AsmOdFYaYYXemdwv0umhM?=
 =?us-ascii?Q?4C4l0sXOFTM5MwXifpOd+RRMWw8D2mkBacAl3/+4QWrW/bmnWVw7GMwCVjb4?=
 =?us-ascii?Q?uIxYioivXH2B/CReSDzgfdqZ0cHPs9qYZM15/djQH13wVFAthmLD12tRhE2f?=
 =?us-ascii?Q?JUUNGTHVQDcDIH8KaHgNjL7LAya6gvnhKb+f8gjOe0482czlYrQdwF+k+3D3?=
 =?us-ascii?Q?RYsJJUjU3A0tK2m6GH0k04JzJsvKHfyfkUAI+1D/UvYLzfNiD598/7yKQBLQ?=
 =?us-ascii?Q?067Q5YUfqXs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mL0fAdqDD8Lnk+vNHpR9BxwR2dv4py0mqp5p9+ak0lkk5ZHt5AqqTVgok1KN?=
 =?us-ascii?Q?jQ7BfxSCyvEsthgra5z+1Fh0Ay2++saACBLLJgc0h3E1X5cCtbpqlE14vQGv?=
 =?us-ascii?Q?VtXPFmlhVIsjKyQzbyb5WT5nzWbEu9BQJWslFqHbreY3anUafaLtQ62hOIpE?=
 =?us-ascii?Q?CTSSq5tEK36W2R3zfxiioDgvGhOS4ORYRn8CJlQc+PDC3hoKwxYLmCPaAirV?=
 =?us-ascii?Q?c8Ajg8/OZKZO/3HwA8vYGyGj+5023BTWZC6xsjszg/7ra3+LyB65LnComF3P?=
 =?us-ascii?Q?SEd+4Eiraiww6zhJkw0wLS17H3YnnuzjMZciqLoEj7KJO1mAObw0dCAoxZlo?=
 =?us-ascii?Q?H8lJwCbYeUMg3cQxxfr6il9IkgSpEoyhxPAcZ7+u/ZW66VoHspnqSYZOrZry?=
 =?us-ascii?Q?rTjg4JHG+hE2yDxuzFtEQJiRBBx7HIi2Cyn9XOsg+iKoRSx/HfVbr+mQDQQW?=
 =?us-ascii?Q?Fy8f3dRMYXuw22T0vo7wRKYGO6qbISWzTzIT/G9aSvypcFgKJLACxVVuHA6j?=
 =?us-ascii?Q?Sb1O1MostqHovwNQBh7U8re3zDSrzA1hJ88c+n9ppYRceU7p3M9Dpj+FLKyj?=
 =?us-ascii?Q?3XdiVOfSZTxBxldgnsTv712JpTrUhsAOj6QRQ9FHPE15PjbDRmysF31f5GA5?=
 =?us-ascii?Q?fzaUcJQMjCj0QhJyPFDnBrIyUUb4Vm9HPUHP6e9ed1orGZKiuoFruWpk0hDw?=
 =?us-ascii?Q?uKvXqlJSdiNvXFuY13YryTOttCWiFsia1bgRTFRbkRIfJa2Hb/Jzd5QvE5MZ?=
 =?us-ascii?Q?pn+Qv3V5Spjf3snv5dRNUaD68ydJKElvyOH4T+ej+E5u4aGQ1gt1leBYJzw2?=
 =?us-ascii?Q?DByTBhnB7ZGzTOfqkwyvM09p9LSUu1Tq/tJwCG+ZKkUSJ70weB4tjAUAfbPI?=
 =?us-ascii?Q?T/cPxBgvmwZ1g3Z0H2QgIbzf0414WL6rvj1nJ1FmXll1iZ5aB4d/NdnipR/h?=
 =?us-ascii?Q?m30W32MJYn8IjqB9DRPx1aA0xgqBWw8hzBhoMjhHtn4YGZMvFwWEtFQdpobW?=
 =?us-ascii?Q?lo5CplNU5oPp3r/2fr0yTcgBqXGspFFsVautABxnJ0XTMCVziu1jpD+BK8LQ?=
 =?us-ascii?Q?MLZBAiie4CsoiBmMYWfpww7puzIiKXfv1uETCou4tpv7LBw+yTDMCHG3rYBn?=
 =?us-ascii?Q?PCJr8z5z9yrAwpWyDzw3pZLvj+BnxurcfPhNe/AmJvo/vXsDjsb96VaIdCWT?=
 =?us-ascii?Q?rn1BQuxAwmq9K/l4FrgrsTI7zVWu9h7yPqTzS0SQXxwo51PS84FQlSoyM1jE?=
 =?us-ascii?Q?cOGzJwXExdi6bDutH1KCjwjGPLnKuA29N8S6Am5UDExH2UP+lx1AhWEEq2C/?=
 =?us-ascii?Q?f3J5ofs5nkssV4ndms+QOaVO99/Lg38FjOiTg3BLdsiOoIeWRgifhR6GiutJ?=
 =?us-ascii?Q?c40EVNqmWoBs9jzfcYTwE6eMxnx2OnZ1JnnPdyzfIFNf70ksV7ZD4c3saoAQ?=
 =?us-ascii?Q?9H39c/w1tV/QJgMJmdilB1nEOirGi+CIKZXfvrvZmzCjjWZPNTd6KjPk28ps?=
 =?us-ascii?Q?qMDVrhWY5Q5jd2Dvry+2GKjkoATupxXbdCwcEqkmQZJaOkHvPVNRvdJkFmom?=
 =?us-ascii?Q?U6p11sNNndncM10E7/WGAYP/Xb494miw1ZK/y22za2Nb0UeHRG26GjDN57c4?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UedZ9jt2h5O15BrCEIeud8484EJ+6MYaAk6kq/3+g3ntZNC0aGIHfrYEaBc7s4ermyl90nKhDYNIpO5XFIEJjYgKdBl2ig9ZjN0Mmjz+rWO1c/Ls9V8SilRgzHiPxfWebvNsNDrdAETZAV0/+BHYVRNb/ByqgdIW1AENwsC5NaJhHbiIn0NiP0wfveqmapmUlTTytmRbshxqWu1M0wk9t9+kPiJ2mihajBl5UsJWcGnmS/5A0GrDuUv1G+h4Z47u7Xo8T8rWiqVzalee/76FkrRm7VghkQEfxon7ciFuEJnX1Ieq4WQsuPDHI/HCq6tuwKpmYp4JYMlft7X9WB6S5GmhI/jKaYsmRDaqS3xpfCoVonFz3ldnHoecD1I+zm2PaYPapInNtwJq/e2toxg1PoiF5vh68+NRJWBF1e2QcqL0UQIs75GGeuMRHK8UDusSVQ+oIpIlLfCt8DitJLnivulv5RWJCrayaPO/kSDEcMwoXki1F5e0iG6MXwoByXjpYe8EmJ+1etthaaIvw8IP8Vs/fu0HUTDsTlOGkED3XnITwmgnYWniKLflmzTLz2yTylg24Ux9lzmtgdIqsG0zWAtSmYoEdzC8w4z6kZZJBWc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89999ccc-2fc7-4e20-bec3-08ddef824249
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 09:21:29.5200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tAjFS+zCRBAHAvKgwyfUWRAqGhCVYr71cwgrE26+ThETfkZo50bYQQma1dSTqL2CG6DPEeCiZ5TLKXAeE7BgVyLKayF01YUkD18oyJ29tNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4969
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=935 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090091
X-Proofpoint-ORIG-GUID: NU8i7bTJylkUCmbS_rPXFxmKC4KDJL3e
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68bff19e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=2_v4jMvWlZbjAAE9TA8A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: NU8i7bTJylkUCmbS_rPXFxmKC4KDJL3e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfX73Yx0MJYl1Pc
 u6WqSFsBTdiwykgNsuBhn7WDewRt2gofyCUfH8nZd9a6qVwZMsyyzDzKqS/oo1jbOm3rRf69avS
 2mjIdLjk4/RB+uHZqR1X/HFtkVeMaH3sQhow2oqXZUa5DA6b1ns9xW4iWP9NAtQNu5K4Hqc6ukj
 KTFj7BuGI/8I7Srf9LaLS5Unb7Zy6vBhQ0yspig3tNURComClFjL+uSYaTPK5VwqYLRj0E1cjeb
 qr26IZObGVdbX0l8shCDcTxZ7PHJz0k26We357vqc5LHqAii25QxxSkOqAOtGZ/oE6Ogtpz2EYm
 BJbqqcDxRb3yjZk6gVn4kt1zzkRg/NmLsROqupSz6GXvD9FXsnT1NSBxCauLi5ccvsW84LWmyp0
 JgVIRpH37psyIj5NTVQ18stYJmMQdA==

On Mon, Sep 08, 2025 at 07:30:34PM +0200, David Hildenbrand wrote:
> On 08.09.25 17:35, Lorenzo Stoakes wrote:
> > On Mon, Sep 08, 2025 at 05:07:57PM +0200, David Hildenbrand wrote:
> > > On 08.09.25 16:47, Lorenzo Stoakes wrote:
> > > > On Mon, Sep 08, 2025 at 11:20:11AM -0300, Jason Gunthorpe wrote:
> > > > > On Mon, Sep 08, 2025 at 03:09:43PM +0100, Lorenzo Stoakes wrote:
> > > > > > > Perhaps
> > > > > > >
> > > > > > > !vma_desc_cowable()
> > > > > > >
> > > > > > > Is what many drivers are really trying to assert.
> > > > > >
> > > > > > Well no, because:
> > > > > >
> > > > > > static inline bool is_cow_mapping(vm_flags_t flags)
> > > > > > {
> > > > > > 	return (flags & (VM_SHARED | VM_MAYWRITE)) == VM_MAYWRITE;
> > > > > > }
> > > > > >
> > > > > > Read-only means !CoW.
> > > > >
> > > > > What drivers want when they check SHARED is to prevent COW. It is COW
> > > > > that causes problems for whatever the driver is doing, so calling the
> > > > > helper cowable and making the test actually right for is a good thing.
> > > > >
> > > > > COW of this VMA, and no possibilty to remap/mprotect/fork/etc it into
> > > > > something that is COW in future.
> > > >
> > > > But you can't do that if !VM_MAYWRITE.
> > > >
> > > > I mean probably the driver's just wrong and should use is_cow_mapping() tbh.
> > > >
> > > > >
> > > > > Drivers have commonly various things with VM_SHARED to establish !COW,
> > > > > but if that isn't actually right then lets fix it to be clear and
> > > > > correct.
> > > >
> > > > I think we need to be cautious of scope here :) I don't want to accidentally
> > > > break things this way.
> > > >
> > > > OK I think a sensible way forward - How about I add desc_is_cowable() or
> > > > vma_desc_cowable() and only set this if I'm confident it's correct?
> > >
> > > I'll note that the naming is bad.
> > >
> > > Why?
> > >
> > > Because the vma_desc is not cowable. The underlying mapping maybe is.
> >
> > Right, but the vma_desc desribes a VMA being set up.
> >
> > I mean is_cow_mapping(desc->vm_flags) isn't too egregious anyway, so maybe
> > just use that for that case?
>
> Yes, I don't think we would need another wrapper.

Ack will use this in favour of a wrapper.

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

