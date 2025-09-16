Return-Path: <linux-fsdevel+bounces-61760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F0BB59982
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 16:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 995D03BE3C0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 14:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F062C2357;
	Tue, 16 Sep 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dlCtUJwa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rmZftsLc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4B3368097;
	Tue, 16 Sep 2025 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032054; cv=fail; b=pvdzya0Se+hrbmiLUaXJgXkCrxaGp7PO0vM2voQsu6vKT03wzlPhISEMhponWxkpZvHNzRewA002YSc5HnYIvIzItAgca9YbJuX0eYONfN2uPDUBP6kfJsPwh6xl7zsCRkECHxydWc+SlgkoiTYkrlraEXliurcttW3zIKcEgWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032054; c=relaxed/simple;
	bh=YRDMR1q8eT/H2Gb1bHb+4+9Hi0pbNX0R2xlU6HIt/ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xx0ML8ggYoEjBgHltOVZyVUEt1lhI4dD6uhfqc5pfumI0J+Ofmc3sfB1aTuUXM74DNR9z2kx9fXtOqQqWtEd/9hudY4HQT+sNwLDruLtA8XJYK1WsI6Aqjd7v2MPgb75SxNsXPcWO1sNTPKWahgsmBpbPkl9Vcsu97HNbZ+L0OQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dlCtUJwa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rmZftsLc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GCnrIL029022;
	Tue, 16 Sep 2025 14:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dzIc0zTF5d/VDiZI3o8SSaiIagfLFaqqLrL++N97isY=; b=
	dlCtUJwaCiTIma17NAKnePby9exW0VF9XuUosvhTs9LpEqqxC4mIqmTvKY9AZb1g
	ygk6z3Uu4bFCw5/jv2zBRUp8ioGYev9wGxsqb0Zu/BT+xEInAeaUWIAdHsS5goFl
	RHOJz/T/E9giks9FUuQxDG9BuDPYd1wYySnOr0Z6wns0thsBmELFoRJPXSGW/bJz
	qbSA8U0bLsYyg+2/AzWAHWK2Hz5BmxOy0lWhwWR0upZITG9npdRF0BGqsUqkAlR9
	FwXc7FFfFDjMAsOJH4+XwEzOmDQ8gHgNLzHn8CheTvalPq1XgcVMQaYc9qkKgnU8
	JXwtiMZkj80GMRvsrJRZow==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w4rar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GDfijL033734;
	Tue, 16 Sep 2025 14:13:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ced7h-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 14:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KinuRN53FlnU/cWUJ/CQyqZ5aFoHAfU/OP1eW5CBfDqJaGn+EXBOt/Z6YwhQUAQU64+SBv1sA8F5KKBwPteVyFCSy+D5JpkaH46tXSkx1YdBmnrzUIIhV9brvwead909qHBOpp3m3rmgXfx4r7jXJVS1jwKYvvh07jBJAH4uAq+Dr9RKskU6yVVlK7CAU/Cx1S/o1yDN06Qz+CeME6aANuVxbp9DZ8RvyPnqrBA9ayx2PWVgW4NqME3H5vy+jiBqyXQbQmqIQ5qvE0a8uaHLbOltYXv9iUmAlesHMKtfQpInWy4LG7/gBVlXdzonaRqCcQtOXQVCZQOE6F4BmNBYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzIc0zTF5d/VDiZI3o8SSaiIagfLFaqqLrL++N97isY=;
 b=bgu6WD1Rhx0XNR8ao0Tv0UQl1GpsOAkLQ4JTfF1yiNgogd2+tRN/0TlparaRtuVcApzMMLbnQYt+PEyf4Vz4eMgEmRt8ezLsuHr/+Rq7ce1ubIAHiZHerVxbikO7O8nyMfRgYvnOZV5dPSHSJHn5C7C893R7698l3H5EiXimeSA1h5v4QiN45NyMe05yufo5cELx2BfDPtGMkHcI2terQssymIcLdW+Y2589L84HM5y29ZE4r5aaD7EURNbmFq+iALMCDrlTASi+l8Eefi+vp2xY/PDqbAGZNiqmqY8cvZg8uXaj9gl5CxuxuD61/wlhpsRXTOeQsB10nQeckcMRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzIc0zTF5d/VDiZI3o8SSaiIagfLFaqqLrL++N97isY=;
 b=rmZftsLc8J78pOxmVRDJkCRjvxp0iCAUjTyPGY4nQwh6qT8+aTyAsamKtBGZGjY8OU481SJezeYKtYiW6kyNQnBmysrb2RqUgoTc3vkCInpmtC/fNcuNm9ZDAttLDHANAX9Lt9YmSoSFONIfZfYd4Um9PhL157XtsTjZSxwOnPo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8108.namprd10.prod.outlook.com (2603:10b6:408:28b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 14:12:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 14:12:56 +0000
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
Subject: [PATCH v3 08/13] mm: add ability to take further action in vm_area_desc
Date: Tue, 16 Sep 2025 15:11:54 +0100
Message-ID: <9171f81e64fcb94243703aa9a7da822b5f2ff302.1758031792.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
References: <cover.1758031792.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0356.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 2266dc93-6b8a-414d-3760-08ddf52b21ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fl2GQkuxntJCHa4tmE3Kw4EXX3Cm2fjf0v1mxu7tbuHL7+DXtGT/ddYRMjue?=
 =?us-ascii?Q?Zhi0Axr91Y/v893lwy57zoIZxDO7/z/tAGzqLx+8q8niQxVgTcoIOetrZZwb?=
 =?us-ascii?Q?3PlJVUmVDggy5OVOxhkJTjDvToLTbqktfUXtlM1xpfMoo2CGAowMC+mNDzoL?=
 =?us-ascii?Q?i3OIUhx6sSIt0xAUBzZYUQ2HuzYBd/X4lelHa+gGFITnXI+VGZlP+RZ4MJ7E?=
 =?us-ascii?Q?D3rxB9Wo9IL0ntIYr8ylt+k8WoN1IRDB1o1FScRZ+n200+IKRTdt3rNCl4Qb?=
 =?us-ascii?Q?J3TgEUd552GyQKUt5dea8Qy0umZX/pXp5l16UVsmZn8s5FvnyLbTD/vCZ/Z4?=
 =?us-ascii?Q?cVZVhW+8oxft4kUbSn5cIyltu7ZmZGtiA/ORcL/IerNMLt2z3lLeHbPgnwg9?=
 =?us-ascii?Q?f1EVHQ6yB9HRhuLyZDYCnLftN5U4ZH79oiznAnghdctJkz0s7bQ6CpiTG5M/?=
 =?us-ascii?Q?RtjLp9XF1pojStrQMbD1Uz7jJc8iFQz2Cx28pcHelG+1oDDkIhiJ7nYFQKts?=
 =?us-ascii?Q?fvjKFfXkjsCmpCpnj+9OH3INLosv5Jmmx+AI33uyT/gMqQtC2kddIEHCGNcy?=
 =?us-ascii?Q?HI2dHf+myCYrqgC+65pTZnyNOgZHucuUT11pOqfwk05k8B21PB+fSqU/1JHg?=
 =?us-ascii?Q?H6IGE/syOyDhAGD6LyPRPX9u2Pekme3NPn8Gb17DkgIH7HCiFoAlcL1zy4gV?=
 =?us-ascii?Q?xEvk/pLF9YiSPXWuLjJtZZN21IJldA6c29iANdc1ScVYv/QROE8mEaFFVbKQ?=
 =?us-ascii?Q?2kNOcNqBflmYuFbuzji3AgEFUSTcVs+o4NEC80MJbc1jb1sazkAiwfCHIYm/?=
 =?us-ascii?Q?/bIAaJwu9T7x42MsDJF78ryMOX9C4fYfgY6qgaSatYmXO/568EHKPa8kOSuo?=
 =?us-ascii?Q?WPWsHYYdrXoKh0dfAe6fgyZRsGuJd4V/r6vjdalG8e3LSB+U48PrbHHLZNQE?=
 =?us-ascii?Q?t1kKQsYZmGSMk5qMGDVxhr6cnWkMk+Adz+0V5NJVS5GFvU/bcY6vOpffgDhf?=
 =?us-ascii?Q?VP8G1+kd/EYXDC3cvcM773ZAosJRjSTpZrFNzMVsEdtX2a0A1zo7/vL45hS1?=
 =?us-ascii?Q?g9Jnw9Y04srXRVKkaSd/Nlb7/qxIPi/Nfk4pdyIi851xMydG+/Kp4mzddfKm?=
 =?us-ascii?Q?NCW8Uiuk/2meLfBUNDqvI7Z4JXpQieLYRQZjT0+f6BeWvpaGjSqxaNazSjBb?=
 =?us-ascii?Q?G8FSBBtjgPu7AJp0gpsGfFC0a8PbCIxsELmUROizq/ihafUAfZO2t2AlKbz9?=
 =?us-ascii?Q?bJWYd/pQmtUUGiMAO5cOevJ6rQkxSdnLaVZTteA1Uued2urclC4qeY2M3JWG?=
 =?us-ascii?Q?vny19alfNWCB5RkAn+GViy/nAMGgWNrwkMXYymSi+2fZ52pIiTfrYNSc1Xf1?=
 =?us-ascii?Q?ohvLwcT+El2nt99QrLMDb5N2MMmdQL+MYpsL9fsux8vRC6H/kjRnSqZDatJ9?=
 =?us-ascii?Q?rlzQZmWnb1E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?biI93x65OGuDjuzJLgOh9tS+ZDS3WVM+rSiiGdscT4GapDg3EQAMyKGZrmuk?=
 =?us-ascii?Q?qL4l2qn5nQMBKhpYmhPIiPy9BtkW6CT+xftJdukczRm1zrGcgSfG6th5EGww?=
 =?us-ascii?Q?XscQERfFUKItZH2eI8QwJfi/TA7DcC6jfIuyGhTx2M/ovRrXl3tCUnFI0Vhi?=
 =?us-ascii?Q?vTWl6BDHRXyZt1+IlnXo9OGjp6NY6kZFVJ4tvO7O28SbHMh8RGh0zCp0Uyhn?=
 =?us-ascii?Q?AcScVkR7ILeZi1lwKH3fp6WQMTux7XqvSdwDMGveG301Lc3XXi82QIcVt0PH?=
 =?us-ascii?Q?W17hZMjNr5Us/cJXq29dtysyhyIY6JrBSDITGCMA+ipGGjfd/lIU0xJZqUod?=
 =?us-ascii?Q?Li8f1YRBaXThM+vldLkO9K2teNd6RbBHkU1oA+RuofB1tnaaYEw32ihtxCvT?=
 =?us-ascii?Q?v++b7U/edOW0OPCzawysQTfqUaanhsHxLzOE4W8ofn7Ryf5BiSs7eze0xZCw?=
 =?us-ascii?Q?Qi3ZIDdBfZlffnDoIHbyqhfSUX77HUfqHwFbXZ80vNZRBxS0Q5WtdHBy4KrC?=
 =?us-ascii?Q?rGmsy5iwWO6L5mtstOO0TfDcbzfRqZG0yvdiNBj38uEq7gioIf9VWFo/UQhy?=
 =?us-ascii?Q?vyGQwfFSrBvOzFVwuFiDhkoBu9Z2CAkUkqlrKCEVj7c09Af8p1uJEPIh/R/0?=
 =?us-ascii?Q?jqBfpVwPcsZ+62ALZWvdBXeVHL326+RU648g5a/G9n0cKxvOdjJKCxQLRbbL?=
 =?us-ascii?Q?0+eSOKtr4o4+iDl24SwIEp8aX5gNpJXYT0xscZVwacAuOnuFru1q1MQYDsGh?=
 =?us-ascii?Q?PNBREZe5ZVjXClCw9zuNGzF1yV0myPB5sI8n4CECqsvJ2W2mI0eMBXg7F0rF?=
 =?us-ascii?Q?mOpNlh3hP2uYWHIv74MnCPNdWUQ7VgwIKyiQI0Uy+JZQEwwFKPLPImuisoKa?=
 =?us-ascii?Q?akdwvmxTv64hc/xJ6ry0YGxpa0Re9DN7x1ejLeMUChLW/zUVHfmf+NEiqMj5?=
 =?us-ascii?Q?qQY/rrNv2av9j8JifyAG8EcjjOtrqY58x8vBLOwSxSRs4UT1c+OhP0V6oBpj?=
 =?us-ascii?Q?UqwxGe2PnRBGpeJtr4YX2Dl6qMbZS74agxbdRVz4CjjEKBNNIWjK/OmbJXei?=
 =?us-ascii?Q?oMpPAV6W0Hc6RwTrg3OUrihdGznnljdZTqhi6CSiyGhvyQ7sO7LIzpNzzD2X?=
 =?us-ascii?Q?l3ovKhze1ZHuBnkjgMWIPRarO1ABxR3yvA1KWYnfOs8wfXbZrKHJ7w7g0yWf?=
 =?us-ascii?Q?Qmiq0FXdQpOrndZwZ5dlI/+kcfHgVkRPO77iAq8Ekau/5bmFDIc5/ZBJfMUJ?=
 =?us-ascii?Q?2H3/JcPGFTJ0O5XhMVp6BkTV51AtTu8rlLjnS2jbJYvCV2gR2y/ZfFlLG8d/?=
 =?us-ascii?Q?s4+wn/rAJclur1KMgrmCF1x0BjdGl4sr/UCa2SsDnv0Bgzz3yW/H2eYy14sc?=
 =?us-ascii?Q?/SbvOOqUS1RP0vQPnUjiox+sAX19EBS56XcoBzrhJSVqPUDLb7nwfSRV9JnQ?=
 =?us-ascii?Q?JdACcajQYHSu1kOERJPmE5u5A+W3xP9EhN6xDnPmXvsJvp4+M/2nDHTe8ebH?=
 =?us-ascii?Q?qagpWlOibjUvB5I2Kw95WYrEcGGniptRtJNqFhCQWPCQKGN4Ax5OWufm3f8W?=
 =?us-ascii?Q?d8OsaKF42Anv/0hbmVv8R7OPC0f6FVvp9/tGJpt9vKewJTvBol8PFHw2Gdh0?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XF+ZcsrgVlPOTy5M5L7tMSosd7aRwwRq2xNjjmzwd98FoxtvVleDDJot85xBMLfhFVeGLXAsuFYnLvCXdWLK7tv+WOJa8khmmgKFQ2ETqzpJ09Vf/v3GiIzHeDmyuaYRNBU+iOquGxaCKC43JJD5xipNYysXCcVbcozlnOG9Ug6RI40Wggv569SYkDqJTW4whjgIpIywx8XMFKU/fP/2/m+gBx7YGHwfae0kss+uTj8DNNJRVcFWzS1oGIn0+IfoVTx38Sfl2naZKFv1Tz/CYbrOi1TsN5C58FyUV/lxtdUrCkaRKUOaGtTKL7+xuutRGheVwCQYjjEW/q2g8lZTsn4GPGuj/+71WXvFUf/9e6QKdma3zjtnYxOSg+7g34QI2rO/sQQZ49INN8lg8geM0UDMNlwqxL1i+vHPaj0uHXQ0VA6EQt+N64DXwh/2Iq/ZpVPDqV6HPyMSQtCndJz8fGmh7Swrh9hxWSPrppEk4ra6WF8van9i+0Py2o2Y+WDwyRP+Tagxxvl0zNM25rJLYnR8o8bJ55gOffL+ZW08BxOz9SdnFL9JxPj00IiDy4deTmVpT9O2oAfcqeaDp+k72HrUQ/5MjEBnS4NkEwUdfH8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2266dc93-6b8a-414d-3760-08ddf52b21ef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 14:12:56.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9r9qZowSbrpSVf9pjP4YYhe80sSdFiCzyVxPrQH/zcxPA7M4HZeo7PTNMbcTN7iahpJNAaKNq85BeuMrfhlKGMWeIuLyyOfyDjRYAt98nR0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8108
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160132
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfXz2Gxt3xQaXMk
 tucUBjjiPMPdXoqqshRtNy+MAea2xFuvv70Cb8j9Sdo7jA3LCsdR+FwB/mL8JUmcaQds3UkPSaO
 Nj8x+k/uRvUNTNDQvgfHBfB/AvZTRRTUeFJQQELtbSyAdQr/hgmekdAXDJkm1IOLJscO+Hqcg6D
 RDlcuNg04lJRubasZWBiY/tfHTrPy5vqRoH/VvvW9GyT7PpeoWpixzXaz//rUTWX4qCt4Sm305s
 0cEFjonsDZSlczDA/Sp58bd2iA1GwX+1diauzdVyMpo+Gg19V0iyNvra6PC3iSxBjrwwX+/h8Jp
 +h0yUbtrB+BNiNBZMlk4rK0cUer5E1O9Y07VXAo7vSW7iujTzTGLqlWJzxPBPHHVOPwXTQEsVM+
 A0kFJyxQ
X-Proofpoint-ORIG-GUID: tXfBgSTgXw5GFNzdqLoy7A6lV_523Rve
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c97089 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Lihj1saml2GZpWlknRcA:9
X-Proofpoint-GUID: tXfBgSTgXw5GFNzdqLoy7A6lV_523Rve

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

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h               |  74 ++++++++++++++++
 include/linux/mm_types.h         |  46 ++++++++++
 mm/util.c                        | 145 ++++++++++++++++++++++++++++++-
 mm/vma.c                         |  70 ++++++++++-----
 tools/testing/vma/vma_internal.h |  83 +++++++++++++++++-
 5 files changed, 390 insertions(+), 28 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6d4cc7cdf1e1..ee4efb394ed3 100644
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
+	desc->action.remap.is_io_remap = true;
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
index 31b27086586d..aa1e2003f366 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -775,6 +775,49 @@ struct pfnmap_track_ctx {
 };
 #endif
 
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
+			bool is_io_remap;
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
index 6c1d64ed0221..64e0f28e251a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1155,15 +1155,18 @@ int __compat_vma_mmap_prepare(const struct file_operations *f_op,
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
 EXPORT_SYMBOL(__compat_vma_mmap_prepare);
 
@@ -1279,6 +1282,144 @@ void snapshot_page(struct page_snapshot *ps, const struct page *page)
 	}
 }
 
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
+		if (action->remap.is_io_remap)
+			io_remap_pfn_range_prepare(desc, action->remap.start_pfn,
+				action->remap.size);
+		else
+			remap_pfn_range_prepare(desc, action->remap.start_pfn);
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
+		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) !=
+				VM_REMAP_FLAGS);
+
+		if (action->remap.is_io_remap)
+			err = io_remap_pfn_range_complete(vma, action->remap.start,
+				action->remap.start_pfn, action->remap.size,
+				action->remap.pgprot);
+		else
+			err = remap_pfn_range_complete(vma, action->remap.start,
+				action->remap.start_pfn, action->remap.size,
+				action->remap.pgprot);
+		break;
+	}
+
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
+		err = action->success_hook(vma);
+
+	return err;
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
+		WARN_ON_ONCE(1); /* nommu cannot handle these. */
+		break;
+	}
+}
+EXPORT_SYMBOL(mmap_action_prepare);
+
+int mmap_action_complete(struct mmap_action *action,
+			struct vm_area_struct *vma)
+{
+	int err = 0;
+
+	switch (action->type) {
+	case MMAP_NOTHING:
+		break;
+	case MMAP_REMAP_PFN:
+		WARN_ON_ONCE(1); /* nommu cannot handle this. */
+
+		break;
+	}
+
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
+		err = action->success_hook(vma);
+
+	return 0;
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
index 07167446dcf4..8c4722c2eced 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -274,6 +274,50 @@ struct mm_struct {
 
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
+			bool is_io_remap;
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
@@ -297,6 +341,9 @@ struct vm_area_desc {
 	/* Write-only fields. */
 	const struct vm_operations_struct *vm_ops;
 	void *private_data;
+
+	/* Take further action? */
+	struct mmap_action action;
 };
 
 struct file_operations {
@@ -1466,12 +1513,23 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
 		struct vm_area_desc *desc);
 
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
 static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
 		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc = {
 		.mm = vma->vm_mm,
-		.file = vma->vm_file,
+		.file = file,
 		.start = vma->vm_start,
 		.end = vma->vm_end,
 
@@ -1479,15 +1537,18 @@ static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
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
 
 static inline int compat_vma_mmap_prepare(struct file *file,
@@ -1548,4 +1609,20 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
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


