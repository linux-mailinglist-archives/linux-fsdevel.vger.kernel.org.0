Return-Path: <linux-fsdevel+bounces-61987-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49DDB8176F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 21:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CFD46263E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 19:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647B321293;
	Wed, 17 Sep 2025 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SvqhhI/d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OkwbVwO5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5552FF163;
	Wed, 17 Sep 2025 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136340; cv=fail; b=FP1LvLuFomycIGu/0RUs7bT+yK4lnHH4Iir0s+SS4eFOGArcdRfITQOdrqz6W+KGvqcwHtDwpgZ4aRpXTI7TXTdzMh3Jk8SlK0ejdah0O+SghEituYIWs7YkznWfvuiMiRcnP3gNs5uoiRsmiG1fXOribFoVwhpAVrDSMKsGGqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136340; c=relaxed/simple;
	bh=x/gytmsF0AqreyLSU2AW6Cc7U8Po/hW0NeKMHerdevA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4ZsAGUks/nLNaDvP/oHvMZcAfr6ljMzfnctLMVm2c5ztrfxWDBXlARnTdcoGfTolsIJk0LWl0MPsvJeckW0C/P9VbcHf5oRj0zjlmr1lkcy6zqdNrCKGY2KMyhlJK7ge5w13I5z9aWTCHj2ZOTqxtCqC+hqGTjvtOZNh+8Sd2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SvqhhI/d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OkwbVwO5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58HEIRmq001776;
	Wed, 17 Sep 2025 19:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W1DbtbJcDWMh9bkVnPjTAPguBV5ySqOLxt9f4a5AmWQ=; b=
	SvqhhI/dq8m+0zlqGMjJ1+4211FtRGjJ3CORbhY0/v8TUW30yfgTRIMy5FvsR6bB
	jVnzVkitdZBvbjQ73WjRJwdmgKIHrWe99KCw/CdpTUk8262/6CRhc/p9UQKnmpAJ
	hBUYS8SLHcQOMTjzAV1GmqzynaASLq3n/hoKDFa0cciiQWjxIG36zC6edhPTMGEc
	Tg+z2uLF/PwMOFLe2lhaOEXiIeAT2gINteJb3gCUEZ/1+oA8Enfyq38df6cdSP2y
	+UdVFtUQ9gK5mhj8sk8nEodppomH2Zu4+N1owfsb3mf3QWMyvsSlzxlMceKl0DQQ
	et/iO7vUWswIBqJk04SQ5w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd2073-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58HHmk6U001628;
	Wed, 17 Sep 2025 19:11:32 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013068.outbound.protection.outlook.com [40.107.201.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2edr1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 19:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUOsSKa5FU+yU5x/5xcyW4T57k2EYWSQgImTcWWr5yyswehxQqOit4OQOD42sJZ0uf17c9X1iG4BIo4czhO0mb8OAATSKjRFURsvU/WhDzlfWBc46VgQDcuvVuBsLZQ1MMtu8+GzXM8u9WjLe7Yf0hdRoHTf/PJx8TAmVctn9hqj2QzXp9AGR+LtFnROeN7ns7usiIXT7Vt2uG0fYe+rLvYRz8aWgGz9B17QJC6j2/shuH6yZ0O94hhuBOXgQjBt9kVsvDvq/pN3MiMUlJKyRx8dz6a57OQiL0AxuoPHpEkBsZkNtr2bA36N+KkjqeiU9ulPkeE7mmqMxuiVrukIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1DbtbJcDWMh9bkVnPjTAPguBV5ySqOLxt9f4a5AmWQ=;
 b=Cx/K+XDH+zVWH+8bqu8piq75oQIdver1T8Dxr+VE8D6300LiThtMJjbulQMDpv7G01OLcAQAgcftNun7hLKNT3D/CdgOpRWMKCg9sdD8aMhLnMxl3KXSPxTrOu4ZkX1BPZt8N4APnv7Yo4RO4Taj08BHsaBkeedzccsUc9RahHCDjrcKwO2sJU/dq4ZItWZ7YknlSHClVI2nqYgum11vu/t3QTSCszzsNrWJsvNExA0uZKRYTQAWAUPv1pGyC0xDkXaBLEy2jrY4WuCZyGomHB1IORpyDMOxUbJFGDI+yKquP6U+CSTFlLc0f9gBc0ROBp9/F5ZurLG79sE1CL3ZMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1DbtbJcDWMh9bkVnPjTAPguBV5ySqOLxt9f4a5AmWQ=;
 b=OkwbVwO5ihtVhK0/ClcD8M+aZV5M+nGG5iHtFBDUxYYOs0yxrG1s5seQ4J9UFM+9vhwiNT5SauCUasNCTEtnpfRUcBP66FZzqejKcu7bAoEmUPwZ5FHCRwuFeDxFrvGuuV5uXhO1B3wcC1Mcf+zVnFsJeRiQQeeETqIT+Gn9qu0=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 17 Sep
 2025 19:11:27 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 19:11:27 +0000
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
Subject: [PATCH v4 03/14] mm: add vma_desc_size(), vma_desc_pages() helpers
Date: Wed, 17 Sep 2025 20:11:05 +0100
Message-ID: <5fa007dc4905c863abe6fe97de1238c30b1958ff.1758135681.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
References: <cover.1758135681.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0638.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::18) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: 6371dcdd-74ce-4322-0987-08ddf61e00a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IMr4ADZQ188vB5IA5SSEnfaIxlXcD4al6d8bTXTTe8vP0jB1s+FTU4V3r3LZ?=
 =?us-ascii?Q?Dtjt0mu1LbT6Zl9W7YRRgBVjkvzJOSz8aPki3H4xAHiMPyaQThgStNIwIU1A?=
 =?us-ascii?Q?sUoC907T0hBgGZD+eVmu+RveRwAFKg5W6/RHRvXj//M7lgoabCt+xbwrCogD?=
 =?us-ascii?Q?QT0IxvmDTg3q0bMhzkH3DCz7IztaA+G+ehl6VJSyiwFHBPSHICyl7/yMVBzX?=
 =?us-ascii?Q?u4iDBf1P7K2Ld2UHbkgKD8c64rWn4UFrskp3elxZNbggp+yf17FZSj6KDDWh?=
 =?us-ascii?Q?Pg4GcOx/uiY77fi7TGSqyKl70M/z+PA7eXdtOg/Zxk4wmGr/XmksOWTCmFWB?=
 =?us-ascii?Q?gkNuPCCpUUt4/qaKOB2EllcGacnexr5wLcZ3ulUpbafQ32+iPdH6IOWODhEp?=
 =?us-ascii?Q?8bXj9fj331W41a1dO/SanB6GG6we2eKpM3hlBC/nVvFO/F6yJUSqyUJ+FKwP?=
 =?us-ascii?Q?e19+Oj2L+QgbuPHuvbbRhkB6iuCvpcu5MzK+e2syWozsWnsFTDL79KKyG0K6?=
 =?us-ascii?Q?wUCt+jwFKsdGuc8oL47pG0R7zJlYiMittsaNIpPKvasVBnNjh/N40+osNWGY?=
 =?us-ascii?Q?P0F9dwzzsoUQ3tqDdUDqZiYQ5gVBWefTnVw8On5c71rPyvTB9Q+CysMgCsdG?=
 =?us-ascii?Q?HO/GsuTR0CZIZMpK1zzVc3P8/LgG/9KzLS+OxFjJx8fX+IIknoZ1RonrSJk0?=
 =?us-ascii?Q?yRI8t2uvhIgxSwKf4thwPlXvOwIU0VP2knMdhbt3AzpNwqRpmBYUiQGO6qEs?=
 =?us-ascii?Q?EZaFsO64W4YaudrPBIt9IxmwxOv2L8CqNUxpMExrWxtdnj2aVXo2tvbZ084U?=
 =?us-ascii?Q?QaCp1V7WdX8F/iq5aonGw6/pt0nGk2HNeZHOEChybY3Ta520f94Woob8Oq/r?=
 =?us-ascii?Q?OUEplsQvIdnfu2Wedlf/FtLEMJdOxKDI/xsA/eBdzpJTgON0LNiay7Ygnzl8?=
 =?us-ascii?Q?+hiR+Yy7LwP7M4sQySXpggCDdCVQUJ23WEnC7E+1C85SUa/zgWMsHCznfvLL?=
 =?us-ascii?Q?rp946+JvGRkqjgu8QukkcYUWUgIq5tOM3XaMl23ZGZUHxLcfPf1gYxfwe8vl?=
 =?us-ascii?Q?e3DN6cH8znkyVktlAY8WSo8NNEXfxen2rX9XJrlEzXyp6S/VdxBBfJ1h0+nA?=
 =?us-ascii?Q?KLCLSC6W80H+Zt/q4s8/4+P0YtcZuDlI8cCzwBFyRc/Oj9oxd6XOlrrWxo2A?=
 =?us-ascii?Q?/TzmtSEZjPewVOpxoLFEEvuxM8zYzG6KFo2avwvu2uVb01xyJqdMPiv34yoV?=
 =?us-ascii?Q?IpAttKeHd5nPEHpvHwdLOZ1cvvpr1nLk4Z1iMhDiO8URZ3PEj7WmMTxS2/Jy?=
 =?us-ascii?Q?XLg77eI4buqCXacMQrR1oJ9B1HLMEKPGriYjqv578Z6Wieks/v7YMq/ANU/C?=
 =?us-ascii?Q?LSSUN+6D4AZC3zI0suBnmzw4PKEAPj64WuW6jcUTHAmLOAoBat6/97dCqK8A?=
 =?us-ascii?Q?PswphvOQ/CU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+xjl7vmhgfh5O9ZxSzTMH6LYon9cDJcBEezgtkSA0/5sZSBXl+PIjzvRUQlm?=
 =?us-ascii?Q?FFRoI1cy+FoXOChEUUyhVbJCFAELiXc80bW9Rm8vMyZPWvlV35OG7ukZe5H+?=
 =?us-ascii?Q?Mq2ygWozwF/BlHL6qiwgzAiW3vJiySiSCLQPnZH0RaaWiPB+jjXjYgvRqy2y?=
 =?us-ascii?Q?rF9BvdWu6qIHCoJEqxsz06uRTLWsGfEvcFH5Qlf7jPJhBrzx8dTFMJ6Wbral?=
 =?us-ascii?Q?7ONojhiND4ZMBb4zxieOAmBxUJVNRP1kd4KCWnd3Jee8ZOG3GSbQqyyBLdoX?=
 =?us-ascii?Q?fI+t6EjOJHwj3HHTFoupR90S9fvnCk5K1DAKgHb8oiLtYKOn4K+p4ZYNEjfP?=
 =?us-ascii?Q?DrcM3ATRKBPntA9weYYz0vAnMrwm6rLrV77mcIK+eHjZp6TN+8f5Gk/APBTE?=
 =?us-ascii?Q?T9JeukIUMEUpZau5bLXcXtfKC133SLA8nCUPvtGRmnrxnkhpha90UPkTlDjO?=
 =?us-ascii?Q?QgL2/DZwGhbE4ju3HuOypeRtD2GIYs3PVKh/M7em00T/09h0TjCRjt0BAhwZ?=
 =?us-ascii?Q?ZZzSMB9900XV/TkCTlxUyTGjMP5GRrsRou5A0LJEd8NgofdSfZ0j+iwxzzs8?=
 =?us-ascii?Q?76/hIDdgiFhNNwAex0q3bnv9b2KWFFiQ86IrcDzKsGl5FONkp+qFN4BLvtRW?=
 =?us-ascii?Q?m7HvinbUd/4Imi6lNAiuTK+L2aORY2nqooYWaA+gMX+qY96WHFp6/v5qkkMq?=
 =?us-ascii?Q?NU/zBuaxNatYtL3l9++kneMWro1ZlzXfV79OWI2RlBUlsJYbQxX9Z4Gd2ugP?=
 =?us-ascii?Q?QzbVzY47XPSpEX5QjWBV6FYOd0LDiBZMcPTt0OprvezAlAaXxSOBLBH6WF0b?=
 =?us-ascii?Q?E/8n5QifpWqFvW5wZu2/AtGJaSf46dUSgZeZN6LARXkph0a3Y92uugg9xkRS?=
 =?us-ascii?Q?B8HZRvF559eamkHFe4M6be1Dc/Aai4qdrKu7xQy/jp7RTZSLyeIUVOKjrMTY?=
 =?us-ascii?Q?mZf2HYRoX/sQ7mo2UXOmPVJp01BIxlcJ+gIFJLIIzXrRpx/4l+E4tmJWIB0i?=
 =?us-ascii?Q?ZgVxYBn8U5CRd/DN2OeZfU+CFCmnPkp2BvIT7uSCRW0QvLQwc+VcliwngcpL?=
 =?us-ascii?Q?KaaroXl+YOMBd9Euj+xTpzQeyE+yFn6sopJv8PVOdYM6Ab3hSCLZDNdhQy4Q?=
 =?us-ascii?Q?wkhlvvQkrZjK8KzYBpLHde5Fuu8LL7H9jBol71iwBLUVVJi164e7Q/yWOI0P?=
 =?us-ascii?Q?hryoD7EySffb6JaCGKIpymxhARBZ6/BzOHtdL/vMsnOI0jAVUSlUalib7fzK?=
 =?us-ascii?Q?pUsPq4a1/g5CH3cAdMRXxKbZFcVvsBVypbX9P19B2IwvyUJTIu38s63YWNjp?=
 =?us-ascii?Q?D6MKbUyjBuB9JfCdgpfPtP0oQw98WHBe3J7uGHhiT6rmSBVxOY0Y85zgyI/h?=
 =?us-ascii?Q?mjPOxLhO086mTFpGjDfbyuw1xEKZQOFEjbWHB5E+e6eiWEfc11lMvNC0Veu2?=
 =?us-ascii?Q?c2snv+J/kJMV0t4yNzRv7SjN0F0zLTKZWAoQ2zxOS+XQr4SMavwGv5ZBZ/Q7?=
 =?us-ascii?Q?EWVAqTSyKLbeArLuphey9MK1S+CvVlE/EG1GC8jwJTEW1TgMFLEBzafWfcfC?=
 =?us-ascii?Q?j/GpqG3xrxOqmmlW1O/T/+qCjvsdej82pfRkFScjIjPY4otBSHIUbJvNz72q?=
 =?us-ascii?Q?SA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6XMvTLZ4rCSlPz72VJxyJePgHJi5A6FlUQDMURa8qugBiBRKw+PyXYMxUh+3T8m4omRZ0hZzoDg4frvUJKIn2bb95YNFv6nv3qW63hFpOFZ4NPFiQ7/28hHULCGuPercdpTwPYH4zGKDgkm+Mwx/MBhQRf6WTq1vFfWecVBJm5EKTAo/vlUzqel3c8XbRhRS7x4+rU9B2IyL+VI6uvqkyYvbE0XrPkEIESmaMh9R+uOp+zbbrr7FfKudPLg6Wmmslxj8oPSGEEtTNvr7xbHy05zDvl11+YoRltGj2mZEofEiJWZWfgQLrd7SPEoaUt/gNjVR4KSs4wNV/HEYfMba1j4E8F3UU+W2SOIBrCsRSwHeDBg1n57Bkdl9owlAm0KagPc7IyH+FX3LnRXwe40nDFMEYUaM55IOHr9PwcQRu5dQO8m3Z7DRZA1jPpTCUDLHG2LR7yxDrPCpgVq9bHvvnhhhjTJWpHhGZYqAwaBqhXpnqzOKdo942E0blM7gwQmol0dW7tii3RFLuA8mhyhsBZBsf0yIqEeNt1ifDKpljFH4QpXw+BsW5EAoYdw7U8S8kw4SrCUfUj2lEuj1qsaVBT3R5njotfRWZhFtNRPqV+o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6371dcdd-74ce-4322-0987-08ddf61e00a9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:11:27.7538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ao1Wt/WLMPlNgFsVKfW6SddlGeYTVuIAeQh0br7rK2Y5Sw5h5+IhjHWRl7lq8ruo8zff79QBfTb8inVMIWimQ+ER9XY7ccDzTYyxZUj3G0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509170187
X-Proofpoint-GUID: 3ncm_bUCDgasLYZgmdDx9Lsq6L6_pFNq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX6QTHInmyos0u
 TOe0JTWtHrRVTBxL2eQKndgObQDF4uCqYm+1V05vA1AOtIbv08YRyL7uEeYUHXQkNeVEykvyzpT
 6aFHR8Z9nAsR8qkO7NAfPWE9QRT0f/DJ3tCdIkZipBznMwl1PaVeZ+qiXCEYdIw5pDQJ4TNZ6vX
 wzjnZeKXVkGYqO80rStIMR3CMwkU59rnYONjzPbt8PXAAKHy6KdU0pllvwVYg+FtE+/TkANewpA
 NYmGpR6efFyMS/ink7yV6SqJjvxzUTl0XvebriXVoNEIsKgSSNDlAGUFZa7cCWyT7x/Y8piboL6
 +FPOnrVjjxf1kdUncvf8Ue+ODo8lzgpq5xfCY6QFVkfVcqHvpQE6ArVX327i4ZIQgNbaahXVp8I
 Qbo1JGfE
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cb07e6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=Ikd4Dj_1AAAA:8
 a=V8PVCHvh7cpLA54rH4kA:9
X-Proofpoint-ORIG-GUID: 3ncm_bUCDgasLYZgmdDx9Lsq6L6_pFNq

It's useful to be able to determine the size of a VMA descriptor range
used on f_op->mmap_prepare, expressed both in bytes and pages, so add
helpers for both and update code that could make use of it to do so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
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


