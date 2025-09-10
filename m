Return-Path: <linux-fsdevel+bounces-60841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CACB521F1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE62582D6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB8730149D;
	Wed, 10 Sep 2025 20:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X9gEdbst";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rgRVhBvk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698682FC02D;
	Wed, 10 Sep 2025 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535807; cv=fail; b=A7xGaNvAB8stmCC5H42XTsaZWvpjXRrPh8sy9SIp0lEwx+4QfgdDnnhpOC8cWJQ8SnQg6HFO1m8acJLk/fN77I+sO/1pi9N4UJw8d48k5fqB8TOkLIosQkvIUGfNWBTu29YsX2WCHXGbGQokhsEaJDjxbuvjGYd4FHioUNo0HAM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535807; c=relaxed/simple;
	bh=k2XGB9E4cOp07KmspqD0BZCpLQ/LZsm5Djbfe6LcoRM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ZAhZNWmOX0vqdNiOZUJZo0LoXdj70pR3VW4SDaThU7NdA8HF1zcdO0oXLeByoL+Pykl929B9Lsn3U/oRfweQxIqxSRdZgapL4n2WbRq/s+m6S+rfgzCdrLX6H/dwVLmPM94M4eAFpfX9HS/UCdONNlKm2IhomfQd1u8i4UFPZRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=X9gEdbst; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rgRVhBvk; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfmYB023920;
	Wed, 10 Sep 2025 20:22:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=YcwhDDKPC+Wgd+S0
	BuuOasYn8m5m2vYlO9DBNnY9B8U=; b=X9gEdbstXIhCpWMGRNoOaghbo4vz8p0T
	nTdtRo4IGzEwHhHIVXClpCsSyulRMnAMf4jMbWVS0xtOuc0OyBqaTVtnyPz38Jr6
	Iz/KUXqMVhne208MEYgA5Lx6fDhmVnY+k2+EHv7zDYVtXtaofbsTtWMDr+EopcdD
	Bft24DdJUki5ba9RPxdfE9XKqjZsgNB7wXKB8/NKj8M0vxe4QghZkfm6Qz/XDNlM
	BGmgYdfIYsQ7uXYcAIFpr7V44dI03wq3H0RfNYPobjhqRU6oUuTR87Yq97Ytd0U9
	+Bq2osC9D01Ii16HNvFSVC0Eaab3PmR6+evga50ecshFKsaFd88p6g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x94x9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AK3dAm030716;
	Wed, 10 Sep 2025 20:22:32 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdbfhjs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yt8tEjjHxptOyL9AAlZlUcZ5BhR6ZZP5nYRM317jTfkRNOlhdvFSbHYexroVMSax8hjCojjfFljTD4eWII6sw+xHNuMXj126g2LotpC+9YOizzWkrV3yzzbtLyoYjX4hmxQyNCdgByDP9WO8gVyohzK86RPpLd7PGdVNjKEcKaFLvvxbhUFIqejj4FfiuK743hm1YNAjYV0JUZQoqAbus9me3nE/hzVSWiwQ1fBkARnLkQPMaKLNISpx9ZkWaiQbpZ59vmAhXjLSZAOjG/5lOKciDNrojia2T8Cj6hkF1KPxG+k1cPZh3jZWhwXcB5h+wyAUW/oopAgLRlJsEH4Z6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcwhDDKPC+Wgd+S0BuuOasYn8m5m2vYlO9DBNnY9B8U=;
 b=RLmbngIXBYmIEqvSMw7S4EzBsiYvDOd+P3vGoM4UQQrDrot6G7RCgtczexVSG3cbyrr7O6xsHt3E8bvGvH5unFhcde/x+zfBGP72pZF/Wdn1/qCO/Pe68YdeuFY/qL3E+12jfUxpF3hOAP3FD/Y4hhCWWVnTx7oG72w/LpuNuk/SjaNS2uSU8UXbwlJAqKknTPBDeZhNVNp1rckp0CY50hagNp0wdZlfF2b1F6GxuSkwu3Oe6y4w2L9+bmyzrgy/Q6yjx0H79hqxxMuVy8TO5FPugy3EAoZQYsUIw9ruCTL70E0DOusqfga5RK7fXW+IavQcBqti9LO+/0SpbcRzDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcwhDDKPC+Wgd+S0BuuOasYn8m5m2vYlO9DBNnY9B8U=;
 b=rgRVhBvkuZb/WTz350P9o4HskZjB0BGhBAPURsWZuab1xDelrxJ5NzCOhuntGX8l4daLYQMNU6z+hoZloa144hVTWTEcLnrDAVdv5qu7c5LH89sqYRgRhi0V0QGGxgzjHZxYe1NT3lZ1emHswwZzdZNSlpq0Z3wotebZCw0D5+E=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO6PR10MB5789.namprd10.prod.outlook.com (2603:10b6:303:140::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 20:22:27 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:27 +0000
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
        kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v2 00/16] expand mmap_prepare functionality, port more users
Date: Wed, 10 Sep 2025 21:21:55 +0100
Message-ID: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0006.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO6PR10MB5789:EE_
X-MS-Office365-Filtering-Correlation-Id: c88233e9-fef3-4f22-bf92-08ddf0a7c297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GoIBD1Uj/jW8XaFw+V4E8FYNl4TAuWg3oxVAfUvrRUNwhof4YC89otBTooJz?=
 =?us-ascii?Q?tgxKW84bEQrnsHG9KpcbeDeEPF7OUHzKKp1HeqUCy5KMy/XUFTNxsF5Upoc7?=
 =?us-ascii?Q?DrDZiW5eYaQoWojfkjhF+AspYeWmzzm1cmWAX28HDjdd8NQLJ3G4ha4SHgNm?=
 =?us-ascii?Q?yeDyxnX8jb7MKVyBIxvq4R8qQPk4kVxTeATuDrQaZMzwDJvstV9UM1vDZGq9?=
 =?us-ascii?Q?YZmf6VW17ftO7bUqO1+w9vp4tBqBOdR2YBN61olxaWxL/+dXHdPvziURyv4k?=
 =?us-ascii?Q?3m6ghAONqbvDaD7IYpEJx9/O2gvrE34yxSOSDB+XfZBZiw627aRDdGcJJlLy?=
 =?us-ascii?Q?+1syPLzt6suDXPDVuro0JfdJeGpRGke5+wQrC4qprYi7ycTuFdJPVB2XupCI?=
 =?us-ascii?Q?yR/agBVFBtHgzcFvW0dMNjoJ/j2kB4JLtLoRwPPjbQLOJ7375wk0VZhYVI3x?=
 =?us-ascii?Q?XF+mnkeVFr6Cd9gsobBRmOaZyYb1n2ZtO8G03aqmErv5xuHlvTJFTmvHPMVM?=
 =?us-ascii?Q?T57nP/meTBABnsvr3vcHPBziv2CyOyeCSJ7inXvEKzAF8EaEuH4sop+pPEe2?=
 =?us-ascii?Q?Zc6495QtaY6zoSnbxpjqokGizXWXjmY2z1c28/mpJJDA0M0JclCdiTpd+MKJ?=
 =?us-ascii?Q?4Mafq1kSfx5tTEyJHqp/L22VLKJIw8c1dtQOH2iAxjA2GEAzyua8uqiftRvw?=
 =?us-ascii?Q?n3/sMwpdPwSsndjCxl7BQ5mRmY5h4lCllAyPD4lWRS/iJB3akgxFwA4axcUt?=
 =?us-ascii?Q?D5EXXIESJyU/1BHr+R0GZ3mX29JBGyXKCYnF83Z5FaDsEdgV4YytvPBq6LiH?=
 =?us-ascii?Q?Kum1TUK5gh+cBjNARNoRmtdvK2OYZhtyEfKhXcCFuVaz3LoKjJc+MvoeDPxX?=
 =?us-ascii?Q?spl9bR4vSNMN8SRvh2WtJlRaHQtU9E44vxhEYTVAEFB+qUoHt0aGFyQwyhME?=
 =?us-ascii?Q?FdW9MtGEEEcOven1Cqee79m60WEymA32r5rfTNd71QUnv2RmqlZvCYoQQJnR?=
 =?us-ascii?Q?lYxU6yUdygIa1h6V/zDf4Q0z27wTq+PHQcY1T2Af3olkFUxu9YRCQJxiv6D0?=
 =?us-ascii?Q?nfUjGiYQwVpNLxxBtKmZv8GsBp2tN5cAdHs5KPOPMrjZP+8Tsi0hGB3+Iz5R?=
 =?us-ascii?Q?bpdmccnt8Yhj5XPLeSzk3ht+ocPUIF4IviABmXE9UdXNlL85Mn7N70f9cJ/B?=
 =?us-ascii?Q?Ckig3IoDnQ2FN5N8hjGb+HsUq33g+R95YzYjeZRV/N6/6Y7z7vqWdpC20mB+?=
 =?us-ascii?Q?Fb+eN8PGsJwZSN8nW89zsBXoZPQk0aOc7p8TioPMn/wOIVhntqUV29H/6yvy?=
 =?us-ascii?Q?fOfG+4RkdVT0vgXaEvxUjhojfc5c5F90Tofjx8PoGRIOsM13XM1O0eJPl8GR?=
 =?us-ascii?Q?r/qqwEjxB2xX7EUiCWjPmkHc2g21?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xlULALOY+F3D0ZtLF5RU+Pr01Qvim09E7gX9vBSaK1uJXBSDsd9uvJTfnwJv?=
 =?us-ascii?Q?150jbpg5GSL4YsN6nRppvZ4sblLFbX0lRf/b0zSfr9MB2RktzLsnmG4jr+zS?=
 =?us-ascii?Q?N5WpnVKmQmkHbiCpHsmnkI+AdIn+lAu0Mq6A7Q34i6ABXB2Jar3kLmi6lOuA?=
 =?us-ascii?Q?QRXUSSVC6iOy2D4ITslSRQfih+lIZjmNoA60CHd9EzHTNi+KRXUXixP/YaJP?=
 =?us-ascii?Q?xd+l/vkCKqZZGRyywVUrWJAPd+REE+UO8HhNx3kXppWjMFliP9hDGpGL+dCq?=
 =?us-ascii?Q?rMsIlk6zlpcAR2J6rpMJu5AtHjdErq1+H76cpmuACv/nuQOd7GQ84J+HsVLI?=
 =?us-ascii?Q?S1PSkJWVZou6ZqgxytDg2vBD2h0i1+9kOFfP1p9t1K+w2mhgIoJD2uGb6QGy?=
 =?us-ascii?Q?q+aoS283JxUNrhNwhGc+JPLhA8nCYwIujjPkb2m2jowCv9YuPNxEIrOlxH32?=
 =?us-ascii?Q?ynNuw5SQl9xBcPJt56hOezxsbpqlE67fcM/j9O4baDsyE8l6MjxTZGIpz56z?=
 =?us-ascii?Q?tzPeujaB5Q3v4fdgxDkMfkWQ7m5M+UaMdmhjSltZV4EzPIgH/yztiB27tqV5?=
 =?us-ascii?Q?wH+lH1HJqUwFuHPU8DvaRoZg3c0eGrUftJ5IGMpgrfq5WBNbBgSRQMPX+YtX?=
 =?us-ascii?Q?1lwerN6EW1xHzrqajXQzyNnF7CLjCLnnMl6UARQJFu5VfcPq2n0WfVptur7l?=
 =?us-ascii?Q?3ZYd2U97m6Jp/hrh53H2bVpSXWv10xBcx3vBQZlPHww6+Tz3w+6W+Y2VBhk6?=
 =?us-ascii?Q?1gkKlRNPtRKBU+yhehIO/HtkV5hVUxO3OgMdAva67YKyjMCNqbmmSCEhAbez?=
 =?us-ascii?Q?ga7D/Q0DDgeiThExax+dWktF0fhS/fKDjSgM1PmFs/T66i/KAXEW6Ayn3Iyq?=
 =?us-ascii?Q?hyj5qVzRxSTviCW2JqWc1m9PuXIvxDYcC0PMZXbzK9GnxxJNYsoO0OIX/Dt5?=
 =?us-ascii?Q?1lRrM2tl54wVfIkqaSSuIYxEaObYebXk7getfln2SYhQERjpyOMsm0Zth6MN?=
 =?us-ascii?Q?QLJzxSv4H6tan6+blDcwGJhuVGubQbo5BRiDJSd37A6Oago8QPrEwJ/igerY?=
 =?us-ascii?Q?gjyfmLNWBHQNcM8HbRwRqPsYwfh1LqnaY8VezlDwtrKs8kE9nvfS8G3MYoX/?=
 =?us-ascii?Q?bqyk65X34EbwAIe4Dpd8wIdjCBd49s29EpyrpbGe/4VYVk46ePNnqyHbyiCj?=
 =?us-ascii?Q?vTm4c2tQxBKBEec0tWxDY/xLuoyU7n3AG/GSUwNYZLcN1orjWY8zF1txC3+F?=
 =?us-ascii?Q?kOKYHp6uyVH1bO9WKTnX+FS5yLzY1JqkoK+wHYtWHmVl6Xvqj0atOtzJo0f+?=
 =?us-ascii?Q?qKgksZZlNZWw3HrlqSqn1hKO0s4OT1oBnu4Jh/ZfP8IhayqQo3bFHaMD+kuU?=
 =?us-ascii?Q?QK2ZpG2b3eI5hOPMnJzucTV23mMNRwotVkn5Q6FlisQdv4iUvPbGu+seBj/r?=
 =?us-ascii?Q?Ger3bbEVaGn6MrqwjXr3ILZyHGyM4kMl/ZJK10jXuM6SswZ0SCDdDYOUIuzz?=
 =?us-ascii?Q?USSeOT32GC7JeCkFAXAQi1Xdp+tciPcVTIDV0yYARF1HBdr4qN5WiVfD2nJW?=
 =?us-ascii?Q?LRgkqRUWXKDgQcouqAXNgEfDXo33O+XE3Y31MAOixLZS+L3QGl30pmxFwJh5?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1p3MWw+CNm7IYbrEmgLhtAaMMw2OCf2IqaxKKRK9vPl0vtuc4PPSxtY6RrjQcZzX07op+lB/1zQlHks5Ed7iIzyYKJwFCXjKqzKtJhLZ/RUUWz5PIkSQl9JWMs8gx88Arf2EDeJnwaGRIi+CDgKQryF6uCih3zsU7hpF5HC9hLBHqJZedE4fmGOVt0tmuAKnk2sx9BmriiuqZ7+ulo2nYlfYqqn0wMPEjpLMUOSXVgs3EWz/d9A/lz4BtR1aSToNmdTvG8pnYRd1tUior+iQ0shrXlvcgvMd2Uv8ShyLH4RyXfKVeGi1gGfsUpSMZLtm1rkP3sd3kHzbYdkiVLOGJ6pD+UDFow08Jf50e1DogW8ePI6zpli5+2wT1exUVQO2HGHVEVZNGU2PqeYOqeQBFhzIMVWwoED5FrEIgC734KX5+D4thWO6/1Y+LSIxP4weGyGeIuUMM0acwepwRG8uqjHlArtb+4ZukasijqsyE90s4EPXoRzmtX0DJi2+NEETC2A3B8oxsWB6QFqKh2NGzPsvLsdnp0qTWItnLZyYMJgj6RU6ksDYpEwieEMsu/ES55rktM4Q/na7C0BzTS9fp9jRbMDmnnJMqEOnSFJWHoY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88233e9-fef3-4f22-bf92-08ddf0a7c297
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:27.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jJ1js1E6q/77HrYOGwOse7zSl2h+byl2IjvMvpEZvwv87uTBnjsY96zsCjTxvfjcN2Ydmla3VRehqVKWfwc8XYeqR38sW8QbgAX30thY0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5789
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100189
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXw9Ew38f8bex0
 jtxTNah30hmz8asEvKnRlea4maqXpjSWcdQrpQUTsPrZzsGB/Zkly7SeZulJlOzcWDJNmzdQJQg
 XkUISJvH6ZhRlcVUM+eBlEi5Z64lBCJlLWuE7YLFI9XrG2cTh5qy6fqriCdqL0j4xtCGVDYNYHZ
 +u4qxLb+MDMPg2fGMnJYXn+Y7TfSADBLEn9QJC/dPPciNuX0IDss+U7MUiZrrcgAjBzT8VtJNE6
 XukzkvqZIMF4Usf0z+XQ0NJ7VqASKjtCWtRtceFo5VBDQ3RRNPFLh+WROCxZ8zMtKPR26TQDJJo
 gB/5GrKoBf4KxTiHkYJCQw1AEuyaXbG4TZqGT0ORcCcdjcM78gtyAAqcuX9udSmLypT7KoKUovt
 dYsFYnM7
X-Proofpoint-GUID: B-RLd1Cdj2789ze_eqY6Ii6huvYciChB
X-Proofpoint-ORIG-GUID: B-RLd1Cdj2789ze_eqY6Ii6huvYciChB
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c1de09 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8
 a=1PknxEJ185HeLLv6iRwA:9

Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
callback"), The f_op->mmap hook has been deprecated in favour of
f_op->mmap_prepare.

This was introduced in order to make it possible for us to eventually
eliminate the f_op->mmap hook which is highly problematic as it allows
drivers and filesystems raw access to a VMA which is not yet correctly
initialised.

This hook also introduced complexity for the memory mapping operation, as
we must correctly unwind what we do should an error arises.

Overall this interface being so open has caused significant problems for
us, including security issues, it is important for us to simply eliminate
this as a source of problems.

Therefore this series continues what was established by extending the
functionality further to permit more drivers and filesystems to use
mmap_prepare.

We start by udpating some existing users who can use the mmap_prepare
functionality as-is.

We then introduce the concept of an mmap 'action', which a user, on
mmap_prepare, can request to be performed upon the VMA:

* Nothing - default, we're done
* Remap PFN - perform PFN remap with specified parameters
* Insert mixed - Insert a linear PFN range as a mixed map
* Insert mixed pages - Insert a set of specific pages as a mixed map
* Custom action - Should rarely be used, for operations that are truly
  custom. A hook is invoked.

By setting the action in mmap_prepare, this alows us to dynamically decide
what to do next, so if a driver/filesystem needs to determine whether to
e.g. remap or use a mixed map, it can do so then change which is done.

This significantly expands the capabilities of the mmap_prepare hook, while
maintaining as much control as possible in the mm logic.

In the custom hook case, which unfortunately we have to provide for the
obstinate drivers which insist on doing 'interesting' things, we make it
possible for them to invoke mmap actions themselves via
mmap_action_prepare() (to be called in mmap_prepare as necessary) and
mmap_action_complete() (to be called in the custom hook).

This way, we keep as much logic in generic code as possible even in the
custom case.

The point at which the VMA is accessible it is safe for it to be
manipulated as it will already be fully established in the maple tree and
error handling can be simplified to unmapping the VMA.

We split remap_pfn_range*() functions which allow for PFN remap (a typical
mapping prepopulation operation) split between a prepare/complete step, as
well as io_mremap_pfn_range_prepare, complete for a similar purpose.

From there we update various mm-adjacent logic to use this functionality as
a first set of changes, as well as resctl and cramfs filesystems to round
off the non-stacked filesystem instances.

We also add success and error hooks for post-action processing for
e.g. output debug log on success and filtering error codes.

v2:
* Propagated tags, thanks everyone! :)
* Refactored resctl patch to avoid assigned-but-not-used variable.
* Updated resctl change to not use .mmap_abort as discussed with Jason.
* Removed .mmap_abort as discussed with Jason.
* Removed references to .mmap_abort from documentation.
* Fixed silly VM_WARN_ON_ONCE() mistake (asserting opposite of what we mean
  to) as per report from Alexander.
* Fixed relay kerneldoc error.
* Renamed __mmap_prelude to __mmap_setup, keep __mmap_complete the same as
  per David.
* Fixed docs typo in mmap_complete description + formatted bold rather than
  capitalised as per Randy.
* Eliminated mmap_complete and rework into actions specified in mmap_prepare
  (via vm_area_desc) which therefore eliminates the driver's ability to do
  anything crazy and allows us to control generic logic.
* Added helper functions for these -  vma_desc_set_remap(),
  vma_desc_set_mixedmap().
* However unfortunately had to add post action hooks to vm_area_desc, as
  already hugetlbfs for instance needs to access the VMA to function
  correctly. It is at least the smallest possible means of doing this.
* Updated VMA test logic, the stacked filesystem compatibility layer and
  documentation to reflect this.
* Updated hugetlbfs implementation to use new approach, and refactored to
  accept desc where at all possible and to do as much as possible in
  .mmap_prepare, and the minimum required in the new post_hook callback.
* Updated /dev/mem and /dev/zero mmap logic to use the new mechanism.
* Updated cramfs, resctl to use the new mechanism.
* Updated proc_mmap hooks to only have proc_mmap_prepare.
* Updated the vmcore implementation to use the new hooks.
* Updated kcov to use the new hooks.
* Added hooks for success/failure for post-action handling.
* Added custom action hook for truly custom cases.
* Abstracted actions to separate type so we can use generic custom actions in
  custom handlers when necessary.
* Added callout re: lock issue raised in
  https://lore.kernel.org/linux-mm/20250801162930.GB184255@nvidia.com/ as per
  discussion with Jason.

v1:
https://lore.kernel.org/all/cover.1757329751.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (16):
  mm/shmem: update shmem to use mmap_prepare
  device/dax: update devdax to use mmap_prepare
  mm: add vma_desc_size(), vma_desc_pages() helpers
  relay: update relay to use mmap_prepare
  mm/vma: rename __mmap_prepare() function to avoid confusion
  mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
  mm: introduce io_remap_pfn_range_[prepare, complete]()
  mm: add ability to take further action in vm_area_desc
  doc: update porting, vfs documentation for mmap_prepare actions
  mm/hugetlbfs: update hugetlbfs to use mmap_prepare
  mm: update mem char driver to use mmap_prepare
  mm: update resctl to use mmap_prepare
  mm: update cramfs to use mmap_prepare
  fs/proc: add the proc_mmap_prepare hook for procfs
  fs/proc: update vmcore to use .proc_mmap_prepare
  kcov: update kcov to use mmap_prepare

 Documentation/filesystems/porting.rst |   5 +
 Documentation/filesystems/vfs.rst     |   4 +
 arch/csky/include/asm/pgtable.h       |   5 +
 arch/mips/alchemy/common/setup.c      |  28 ++++-
 arch/mips/include/asm/pgtable.h       |  10 ++
 arch/s390/kernel/crash_dump.c         |   6 +-
 arch/sparc/include/asm/pgtable_32.h   |  29 ++++-
 arch/sparc/include/asm/pgtable_64.h   |  29 ++++-
 drivers/char/mem.c                    |  75 ++++++------
 drivers/dax/device.c                  |  32 +++--
 fs/cramfs/inode.c                     |  46 ++++----
 fs/hugetlbfs/inode.c                  |  30 +++--
 fs/ntfs3/file.c                       |   2 +-
 fs/proc/inode.c                       |  12 +-
 fs/proc/vmcore.c                      |  54 ++++++---
 fs/resctrl/pseudo_lock.c              |  22 ++--
 include/linux/hugetlb.h               |   9 +-
 include/linux/hugetlb_inline.h        |  15 ++-
 include/linux/mm.h                    |  83 ++++++++++++-
 include/linux/mm_types.h              |  61 ++++++++++
 include/linux/proc_fs.h               |   1 +
 include/linux/shmem_fs.h              |   3 +-
 include/linux/vmalloc.h               |  10 +-
 kernel/kcov.c                         |  42 ++++---
 kernel/relay.c                        |  33 +++---
 mm/hugetlb.c                          |  77 +++++++-----
 mm/memory.c                           | 128 ++++++++++++--------
 mm/secretmem.c                        |   2 +-
 mm/shmem.c                            |  49 ++++++--
 mm/util.c                             | 150 ++++++++++++++++++++++-
 mm/vma.c                              |  74 ++++++++----
 mm/vmalloc.c                          |  16 ++-
 tools/testing/vma/vma_internal.h      | 164 +++++++++++++++++++++++++-
 33 files changed, 1002 insertions(+), 304 deletions(-)

--
2.51.0

