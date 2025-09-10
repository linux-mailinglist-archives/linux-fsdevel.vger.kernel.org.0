Return-Path: <linux-fsdevel+bounces-60848-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E98B52223
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 22:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148545602EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15293093AB;
	Wed, 10 Sep 2025 20:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ck/DZ8rf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G2civP9x"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0100C2FA0C4;
	Wed, 10 Sep 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757535847; cv=fail; b=JOsIUBqW0M++CGTI9e1oB4jE7wZCOLDYKWgD+jAYgSUL5AvCMNEc0qylNQPcM/boVrIhvtGBHsKXGYJz0gqRO+i5JFTQ2YIdbsxNSKgFBkfDK71/t50rP8ba5y2u3Ly9mHwz0zHGrB4e0elAvTWr8R+ig0DbBJ2dfd6mgbz8CcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757535847; c=relaxed/simple;
	bh=GRHEYwakitjJgzJu+H/ALci+LZifoQ/RCY0ZhWlEM7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uG5LEY6FnhlyazhfEnm8qC7Bs+xozZOaS8MzkNc2PqnY6PE64GqSrtDPz+rX3zz1h79AaZQrz+j+Oy7UGSrfUqWN2X1IE3P2I7J+xipnnEJ1ucFc/sIzJYDO9pXSHW5NYFbJdPW+x1PR50BNQHQ3wsSSRtAJ/zBLXC4os6a9QI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ck/DZ8rf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G2civP9x; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfnXt009945;
	Wed, 10 Sep 2025 20:23:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kUN6SM1+aVR2lrCuz2N5zRg3kub0zNJvVFxoF7l1Cqs=; b=
	Ck/DZ8rfLkupKCj/ykSMv6aINpA0puZeTyeERAhNB/YE/SujTqvqTU1RIyAylEtV
	BbwhIMkSOAcVaA5LUCBs3eKB/beasW5LzZEXb66k7GI4J8PgpPuq+00K7EkRp6Dv
	zoTFC83fYzHTrN409EAwPLrcZjhkhs0EGrCEKTZR8a9q07agntiaqzCOgkqO8R0y
	f4GHtYDVPn/kIOuIMjReh6uxZwPs38z9MJsfquxKcmkrBbA1W37T0zq5t43li0XV
	A+Pk4y4usDd7kFVBvSzt4RGmInEkSop46W2LBX0HDO+aNr1lFSq3UeSH3vd3koPr
	71JzgcKmb0r5c0CWRo3NzQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shvv3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58AIW1Jk002913;
	Wed, 10 Sep 2025 20:23:27 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdj1ca0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 20:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ssi+Xhf1Kn9EAyTFfnQaZjjiN46oQmZuD3kru1lYHtz8MP2Mv0zWhk19VeIdAUWxLdSq6l8KNPcSNAfWipW03PKHSLEbOQJA0UE8+D5sy8oERGm3w2MIuOFAOq2mBTiuPTifjeb7TvvLXKtwoP1N0fT/UM2BEtKiq7YwN/b10mmCyk6PncdzouaW0acNR0ucTu6GBkw8Zvo4YHmnbtF4HZiogOP+8fq8dvLJLbcMTkaK1nepiiY2fj3DL3wYw9kVcHfFdyP8RyQhxWw2P68q4oasdGg8R0pqGTLB/WKciy92J1tcHui+n5Ll54nDpoOFeHTyR085CjTLeCmXyxFMYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUN6SM1+aVR2lrCuz2N5zRg3kub0zNJvVFxoF7l1Cqs=;
 b=n/ktFzy05Ng6Ijn09+RXKL6CY97/RQxqfLNi+BuBVdk3Uqx5IhCArX0scTy/ohkaITrqClc7qdCGfDkgAv+ZDakDdSKAPUR1qDrZDrfqx05Z8zV+WgaJiMvqfdF1gZwtRuWQiy92CldLH0IRsV0d6kncASXyOr8o4mhVk/iPpW3H8pdE0BO8Pfl3uGD4U/bnsVTo6lK9xrDL6Og4wCt6XLt9NFbKMiFA0jkGawiLfR47ubM7SqMIynMJ/T0YBa79+rq9K1zy1da4uKvQTHQ8AZWPhHkyRd3kjKJZ+TUYWnA0J9sJET/yvCh/9HvEf7R0UqX9m8xq2lHMSKWaRla+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUN6SM1+aVR2lrCuz2N5zRg3kub0zNJvVFxoF7l1Cqs=;
 b=G2civP9xJX0s9O24fPYitngv3hXqx7Cn1KKPEns+CceebuGjMYQrtlr2ft8ZWs4Avbz65iaL15gDV1J04k0fURzBTVIm/d3RttlKF3QHhMdNBElqR9QSSgvMesr4Vdzn8qekzYQbgqd5PoJ6NN2Qf+v2LbGQzGlx3qSdLr5XCNI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6278.namprd10.prod.outlook.com (2603:10b6:8:b8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 20:22:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Wed, 10 Sep 2025
 20:22:59 +0000
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
Subject: [PATCH v2 11/16] mm: update mem char driver to use mmap_prepare
Date: Wed, 10 Sep 2025 21:22:06 +0100
Message-ID: <aeee6a4896304d6dc7515e79d74f8bc5ec424415.1757534913.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF0001A057.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::48d) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6278:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d58a13-8b4f-4a51-b319-08ddf0a7d5d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zW+DEGvAn6Fmem4nzFSRteeoT9X2IJ9MDCTqU1trL1GA8ipqAgCKx9WhjdR2?=
 =?us-ascii?Q?QYDWs5Ne9IJjJCgmSuKi01Wp8hCbi0HcCjaKyaLT0jDxjyl5ArFmhjBz0zgA?=
 =?us-ascii?Q?hHt2450lXg18WL46bfdSxJnRorZ2W0e6G3QP0uzH0+qtUrFDGs7SU9epufx4?=
 =?us-ascii?Q?wLyWpO9DtrM6M8eqJhsruCqYODfE65jUkThrzheT+sP/prW4yw8Czt5djwns?=
 =?us-ascii?Q?hEMTiIy7vgVgCsaUoQeb61+MzARbVCFNiSvw+TCMg653mGAI5kYIOU2Zqsqo?=
 =?us-ascii?Q?NB9+topJDO0CjH7rIUw8P+5FX/8o1MLV4FbrDmyYuEy42Iy5qA4Ucyk3geN7?=
 =?us-ascii?Q?p4qY3J3j1O0jqach3QPG+nm7F3SR/6sk7OwM4JmgRc6Te/xPgYM/Y+TwkY4n?=
 =?us-ascii?Q?0PwCcAwlLWcfZVSD1kJr2/DG+ZtPqAVTXBUPfjulQ4X6Yb3Pzh1oZMJ/eShx?=
 =?us-ascii?Q?sLg/SpFKmZi5k5G0P4LPjQLaSQG78W9vl6F+2xN53/GI1fCdl8z+AyO7uJIF?=
 =?us-ascii?Q?bONG7Q04CNOa/FVuGEb/HT8vitdyoQSQS8uTvU2cH4iYzgAK5gINHBAssGvE?=
 =?us-ascii?Q?SL6LG0mSPHeFM+2LnQOGBHK4o4tZu4dQlwEli1m65TxvUDcIVkDrYH01EzKy?=
 =?us-ascii?Q?KMkfg/AHJHGT/xhp+ZA0eHJuHnCIA3DCfigMhZukeL6y/oRyEz37hZoLJJH1?=
 =?us-ascii?Q?RB6M7iLm4RjnBKun5KZWaQOUc4nSIfXzYRTiqxRdcrVvRTYb+oQIh0Wwcnx3?=
 =?us-ascii?Q?GIM1rBa6a/F9mm2ta8HFBWfclWHunPGUcmb3UxDOYirh4dhYu+Rix5xo+vED?=
 =?us-ascii?Q?oC5qSQDyS1sDEze50b0q5732HRpIH4u3497cH0A2OF8nGhSEzUhEStdobq4P?=
 =?us-ascii?Q?gxfig+8Y99ztRyIGtZ/pnzJaB3iaJhDPsrhvKO1Y1FE7gDMwSDZ5BLoz1GVX?=
 =?us-ascii?Q?Ih5YciAAosz4IEzVxwmiWmlfu1XYkvsBWdi6kIoG11+C3uevFUgWGgf5Frjd?=
 =?us-ascii?Q?pE3WxfZ6/0fs7WKLmd5mXjhmOFondOtmr5e3sHAP446UJuhGdSGNWMM+h7sg?=
 =?us-ascii?Q?HQcBwXeRkERHU+lHtbjO2W/sMNH2WVSvfy49d8rCfMW5ZT8Ed3K4X4XIRy8y?=
 =?us-ascii?Q?h6Fh3wUh7MNmwnnse/RiZdFFryWGATom1TJRjoqZfVX3BRVc+q+RmULNghB/?=
 =?us-ascii?Q?S6+8xM6FAqNoBo18ujvhsuI0GDrWJoR2Uz5pqYNvNK26k9ePnYQidyVp4W9o?=
 =?us-ascii?Q?LX/hH4Z22BFvbzoF349ESdqxZ7egUA6zqhjQIf/ZIoJeGXmTJT+7zibWG4BD?=
 =?us-ascii?Q?BVKam5ZOvpMKDwNJg/FbZ6TAy4eEEJJ5moDXZUJWXl4GGwGPtcpUS8hUMhBs?=
 =?us-ascii?Q?nlIqfAbYcGIPTlukzFVsaZHZudF4u0Z5fNGwnlk80emEZ7BuhnT3IbNW95Cd?=
 =?us-ascii?Q?wXMCByvkNR8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VRgrxbAmbDa7rzqCY4gtEGCJ8wb8FWL0zyUaz1Tv/sgG2cG5APjbR61Ur65g?=
 =?us-ascii?Q?inM0iyWt2duM3vJC58ivpdgPvhtzenPlM1nECFInmqD6wr/pGPU/gjl/WrK5?=
 =?us-ascii?Q?qGlsPv9SRSTbk+/DUDl2TCcvkispaLcdq3PIZOnQOL1YuEY4sgVU2yEgXTsU?=
 =?us-ascii?Q?jnL4yeHXP3lkIQZp3Bd1fZaRgQ+7nLsdUFcEytstZFY9na7HNAImfRTdKlXi?=
 =?us-ascii?Q?6wz/8RApUiZQOXRX3UCMkwPmkqdNPK6FKrSa9mZ6/DoopQ60xQSeA8muslDe?=
 =?us-ascii?Q?JuRoRrXROCWl2mYmo7QCApKxPLzyIICSxey97jvwshTSjRm6x7v8YSl/qhwg?=
 =?us-ascii?Q?MbtjEkgYRYcY1esTx6b0Rsnfupb65arVsurregePItL6UcxZINBPtYaoQE+R?=
 =?us-ascii?Q?R3aUwa7sHrxNbfMeO7Ta0PJFp58Z8Mqd4bgcVe7uJDS9Mluf73Q+OT671vPi?=
 =?us-ascii?Q?qiX89QB8F0a81WUKkpIezkJRjHMYFoM2KeOd2kHeLBWkC45m0CgdhkTmGKN4?=
 =?us-ascii?Q?PQ1MAPhxX1VAiQvomJfXd53tayefznc9zD2N1Oq2Ahpt7LtpvNNRjFVUpOfz?=
 =?us-ascii?Q?0/HOd4g0vTlQs1ZfUu79lYXuxe0N7fT5e5IoHKKj/Q0W7cf1OGZQdEuKe+R2?=
 =?us-ascii?Q?Dqjsshz0Bpu0ihbunPlVVBH+dDNJAtC44iW9uvhaIPjVsGjddwYNsJrRyhqT?=
 =?us-ascii?Q?BFuZviiUARbVpN0y+DvcuLcgDrLpX6C93lQw8Vo4aI3QuyTJWjw0O9osML9r?=
 =?us-ascii?Q?CHpVkUGD3bp0alD1OP9sbdDFq9cAIrbuzkyGtak7hAxAN9fTBj51pXQTMtnq?=
 =?us-ascii?Q?54tiCYQaOkdPA6SB160K72S1flFS25BWk010NtMdNRYRmsVG1qXGrBFA9GHs?=
 =?us-ascii?Q?3I9igDtE1U/qClVt60ou8a2H1MWyespIrDo6BXEh1cE5F8JfzHLFv850bjlc?=
 =?us-ascii?Q?+tx/sveEp8ed4HitU+VeQpxIWOC5N7XFGH7fSUcBBZzdGRskrzFDzcB7/08Y?=
 =?us-ascii?Q?Vu33w/f1edxca/oVmE+6qQkEwsiJmsUuv0uXA0GQPLkM1nz7LrZN7Z6pVnsB?=
 =?us-ascii?Q?E7yHSB2rjZJpqYznnhs2mugiGNa0p55PP0ih0SDb/1v8FOdK8F5SRmMU9xyN?=
 =?us-ascii?Q?qphnD1MH03XJT81T93S4cI8sdqBln6FDE7wRSYyE5oe4JJe2PD+qhSdrQhSb?=
 =?us-ascii?Q?2cTNjST9Yu96NW5ZBZvJjDbGV4jAlDysmDNkhmwkXXIJIkJSVyM3IIU8ia/s?=
 =?us-ascii?Q?mZtyE4UfMXrI5nv0U7kK91e2NEKAJs+m1/sekMv/z97n+QbHbi1yQ50PJb6C?=
 =?us-ascii?Q?a3ywDNwvBaHIPa33pR7RgbZHL2tWGbdwdSFoA34dGo7Dsa6kNzQao9avFbzs?=
 =?us-ascii?Q?CWn+ccTxxXp0p2sVMYn8MI2bgtW+3IB7v2RC53/USH4LunSI7fhJc4yStoAt?=
 =?us-ascii?Q?+xvhL4AXmzn3Ww9ZNL+rtYGpqPaTIj/izAl7Eme+LmFunXEKjwxxVw6ss+nD?=
 =?us-ascii?Q?e9jhV4AI0c4rZiJ9LwHAfEAO6LJzyK2B6I/yfU10OG9NJ0TzGkr4mrpVzNFx?=
 =?us-ascii?Q?4Gpz3eXcx4JKlgYpkwZyROGB+OmpAfFz5NSaEqFxx7NkzwRv7SkWx0POevHK?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6COe4595yN09cIjaBDrEatoIjnwPOhwmQQA4j8G7QVKDzdojagXFLKU0rz+XZMxVnK1xSvZqR4KTaAdEIO7nCg9WXB3F66DpF/AEomjc3PTGm7vLaDXSVWHDRPliD8f68m8dPrNgVLL9mI8GLN6FbzRKebpyVKXRG4Og9/VRwWvqzDDt18Yd24p6eOwQ+wm3v/1yuxL7Ws3B2UnhK/m87eiWSMTU5B7gBcizYujdVqSx6Z9R+QocpZnKspV7fMusIIs2qG6etadcAx1VPu8qlWvBkpyQlTmsHCjx3pKY1EZPZeMHbCS3LlopFnRhVvpkHkiXucFJLBQmcY1LBp52TCBwgsnQnhYkWrp+umeJlB91ueBeufhwe9O3qOTcuO5dLz5Zbg+t8ABiF5eaERqDy6NoHUm+43Kht+Btq825WIU9e1T//o602kcibQglIeUW+4jfUv5rrF+PmsDwa6MRBUX9UMvx8dxn4Rz6eOCfBc+OwLxBG/tBq2SmQwEwvQne+bzS8SjtCZQdaMOC+bWZfxpCwDjCXjIvpngiaUD4qIEkA0/fivKe0iUkAuigUI5mvdkl8bFZ+i0BPBrfDsmZ0VkoyFs7qOvdQBiFcl+smh0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d58a13-8b4f-4a51-b319-08ddf0a7d5d9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 20:22:59.6325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/58K/cScUVjZE22zANKFJFLlUKOpYwl31WTeJ2p3D0qUUy/0T21VKA6aTPwnMsgzwg/zmM7yJF6eK+EPtnUYo5gmHalYgXfhpIqUJEf+ss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6278
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509100190
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c1de3f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=7X8Cq549UNVAXTOeWE0A:9 cc=ntf
 awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX4f4809Ol13GY
 TXERyQe+EglL3m+GZXuQp4n1NkbjULUQ3zUlhlec30SPFfDYd7BJjdkf4Muz4tLb21+/4vKI32Z
 82vDe5uofEn3XuMey1hwqbkY4OO16XZDAgo+QMuqh0b/MiJc5sKbTLzPceUQ+a7/6SjY2+qEb9i
 5NvrLAR//zggJoZ7wYezqSgXKagcrsLRCAC6dWTujKIw6xtxvkz8Kgxl6Pfl097G5Z8vR2jgkSQ
 s2y40mC3U8l7cONTLm5BIOINduxGVIRJGpYCKy/qz2K0o9ckvF00AcWCZW7a4CZ2iuBgEQSZfFz
 vwd1s0Y14bZFuVC/R7X49oCl8LOuYDF6AsLz5A08BKIgf9deiX9DydDDAite2nlf6EQp3BB7GcT
 S98FjXDetAdeGJzdCWAWGobGbPqg9w==
X-Proofpoint-GUID: iaDZA6z4fDm08eYffFl0RwXPwWn8G1K6
X-Proofpoint-ORIG-GUID: iaDZA6z4fDm08eYffFl0RwXPwWn8G1K6

Update the mem char driver (backing /dev/mem and /dev/zero) to use
f_op->mmap_prepare hook rather than the deprecated f_op->mmap.

The /dev/zero implementation has a very unique and rather concerning
characteristic in that it converts MAP_PRIVATE mmap() mappings anonymous
when they are, in fact, not.

The new f_op->mmap_prepare() can support this, but rather than introducing
a helper function to perform this hack (and risk introducing other users),
simply set desc->vm_op to NULL here and add a comment describing what's
going on.

We also introduce shmem_zero_setup_desc() to allow for the shared mapping
case via an f_op->mmap_prepare() hook, and generalise the code between this
and shmem_zero_setup().

We also use the desc->action_error_hook to filter the remap error to
-EAGAIN to keep behaviour consistent.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 drivers/char/mem.c       | 75 ++++++++++++++++++++++------------------
 include/linux/shmem_fs.h |  3 +-
 mm/shmem.c               | 40 ++++++++++++++++-----
 3 files changed, 76 insertions(+), 42 deletions(-)

diff --git a/drivers/char/mem.c b/drivers/char/mem.c
index 34b815901b20..23194788ee41 100644
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -304,13 +304,13 @@ static unsigned zero_mmap_capabilities(struct file *file)
 }
 
 /* can't do an in-place private mapping if there's no MMU */
-static inline int private_mapping_ok(struct vm_area_struct *vma)
+static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(vma->vm_flags);
+	return is_nommu_shared_mapping(desc->vm_flags);
 }
 #else
 
-static inline int private_mapping_ok(struct vm_area_struct *vma)
+static inline int private_mapping_ok(struct vm_area_desc *desc)
 {
 	return 1;
 }
@@ -322,46 +322,50 @@ static const struct vm_operations_struct mmap_mem_ops = {
 #endif
 };
 
-static int mmap_mem(struct file *file, struct vm_area_struct *vma)
+static int mmap_filter_error(int err)
 {
-	size_t size = vma->vm_end - vma->vm_start;
-	phys_addr_t offset = (phys_addr_t)vma->vm_pgoff << PAGE_SHIFT;
+	return -EAGAIN;
+}
+
+static int mmap_mem_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
+	const size_t size = vma_desc_size(desc);
+	const phys_addr_t offset = (phys_addr_t)desc->pgoff << PAGE_SHIFT;
 
 	/* Does it even fit in phys_addr_t? */
-	if (offset >> PAGE_SHIFT != vma->vm_pgoff)
+	if (offset >> PAGE_SHIFT != desc->pgoff)
 		return -EINVAL;
 
 	/* It's illegal to wrap around the end of the physical address space. */
 	if (offset + (phys_addr_t)size - 1 < offset)
 		return -EINVAL;
 
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
+	if (!valid_mmap_phys_addr_range(desc->pgoff, size))
 		return -EINVAL;
 
-	if (!private_mapping_ok(vma))
+	if (!private_mapping_ok(desc))
 		return -ENOSYS;
 
-	if (!range_is_allowed(vma->vm_pgoff, size))
+	if (!range_is_allowed(desc->pgoff, size))
 		return -EPERM;
 
-	if (!phys_mem_access_prot_allowed(file, vma->vm_pgoff, size,
-						&vma->vm_page_prot))
+	if (!phys_mem_access_prot_allowed(file, desc->pgoff, size,
+					  &desc->page_prot))
 		return -EINVAL;
 
-	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
-						 size,
-						 vma->vm_page_prot);
+	desc->page_prot = phys_mem_access_prot(file, desc->pgoff,
+					       size,
+					       desc->page_prot);
 
-	vma->vm_ops = &mmap_mem_ops;
+	desc->vm_ops = &mmap_mem_ops;
 
 	/* Remap-pfn-range will mark the range VM_IO */
-	if (remap_pfn_range(vma,
-			    vma->vm_start,
-			    vma->vm_pgoff,
-			    size,
-			    vma->vm_page_prot)) {
-		return -EAGAIN;
-	}
+	mmap_action_remap(&desc->action, desc->start, desc->pgoff, size,
+			desc->page_prot);
+	/* We filter remap errors to -EAGAIN. */
+	desc->action.error_hook = mmap_filter_error;
+
 	return 0;
 }
 
@@ -501,14 +505,18 @@ static ssize_t read_zero(struct file *file, char __user *buf,
 	return cleared;
 }
 
-static int mmap_zero(struct file *file, struct vm_area_struct *vma)
+static int mmap_prepare_zero(struct vm_area_desc *desc)
 {
 #ifndef CONFIG_MMU
 	return -ENOSYS;
 #endif
-	if (vma->vm_flags & VM_SHARED)
-		return shmem_zero_setup(vma);
-	vma_set_anonymous(vma);
+	if (desc->vm_flags & VM_SHARED)
+		return shmem_zero_setup_desc(desc);
+	/*
+	 * This is a highly unique situation where we mark a MAP_PRIVATE mapping
+	 *of /dev/zero anonymous, despite it not being.
+	 */
+	desc->vm_ops = NULL;
 	return 0;
 }
 
@@ -526,10 +534,11 @@ static unsigned long get_unmapped_area_zero(struct file *file,
 {
 	if (flags & MAP_SHARED) {
 		/*
-		 * mmap_zero() will call shmem_zero_setup() to create a file,
-		 * so use shmem's get_unmapped_area in case it can be huge;
-		 * and pass NULL for file as in mmap.c's get_unmapped_area(),
-		 * so as not to confuse shmem with our handle on "/dev/zero".
+		 * mmap_prepare_zero() will call shmem_zero_setup() to create a
+		 * file, so use shmem's get_unmapped_area in case it can be
+		 * huge; and pass NULL for file as in mmap.c's
+		 * get_unmapped_area(), so as not to confuse shmem with our
+		 * handle on "/dev/zero".
 		 */
 		return shmem_get_unmapped_area(NULL, addr, len, pgoff, flags);
 	}
@@ -632,7 +641,7 @@ static const struct file_operations __maybe_unused mem_fops = {
 	.llseek		= memory_lseek,
 	.read		= read_mem,
 	.write		= write_mem,
-	.mmap		= mmap_mem,
+	.mmap_prepare	= mmap_mem_prepare,
 	.open		= open_mem,
 #ifndef CONFIG_MMU
 	.get_unmapped_area = get_unmapped_area_mem,
@@ -668,7 +677,7 @@ static const struct file_operations zero_fops = {
 	.write_iter	= write_iter_zero,
 	.splice_read	= copy_splice_read,
 	.splice_write	= splice_write_zero,
-	.mmap		= mmap_zero,
+	.mmap_prepare	= mmap_prepare_zero,
 	.get_unmapped_area = get_unmapped_area_zero,
 #ifndef CONFIG_MMU
 	.mmap_capabilities = zero_mmap_capabilities,
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 0e47465ef0fd..5b368f9549d6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -94,7 +94,8 @@ extern struct file *shmem_kernel_file_setup(const char *name, loff_t size,
 					    unsigned long flags);
 extern struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt,
 		const char *name, loff_t size, unsigned long flags);
-extern int shmem_zero_setup(struct vm_area_struct *);
+int shmem_zero_setup(struct vm_area_struct *vma);
+int shmem_zero_setup_desc(struct vm_area_desc *desc);
 extern unsigned long shmem_get_unmapped_area(struct file *, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 extern int shmem_lock(struct file *file, int lock, struct ucounts *ucounts);
diff --git a/mm/shmem.c b/mm/shmem.c
index 990e33c6a776..cb6ff00eb4cb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -5893,14 +5893,9 @@ struct file *shmem_file_setup_with_mnt(struct vfsmount *mnt, const char *name,
 }
 EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
-/**
- * shmem_zero_setup - setup a shared anonymous mapping
- * @vma: the vma to be mmapped is prepared by do_mmap
- */
-int shmem_zero_setup(struct vm_area_struct *vma)
+static struct file *__shmem_zero_setup(unsigned long start, unsigned long end, vm_flags_t vm_flags)
 {
-	struct file *file;
-	loff_t size = vma->vm_end - vma->vm_start;
+	loff_t size = end - start;
 
 	/*
 	 * Cloning a new file under mmap_lock leads to a lock ordering conflict
@@ -5908,7 +5903,17 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	 * accessible to the user through its mapping, use S_PRIVATE flag to
 	 * bypass file security, in the same way as shmem_kernel_file_setup().
 	 */
-	file = shmem_kernel_file_setup("dev/zero", size, vma->vm_flags);
+	return shmem_kernel_file_setup("dev/zero", size, vm_flags);
+}
+
+/**
+ * shmem_zero_setup - setup a shared anonymous mapping
+ * @vma: the vma to be mmapped is prepared by do_mmap
+ */
+int shmem_zero_setup(struct vm_area_struct *vma)
+{
+	struct file *file = __shmem_zero_setup(vma->vm_start, vma->vm_end, vma->vm_flags);
+
 	if (IS_ERR(file))
 		return PTR_ERR(file);
 
@@ -5920,6 +5925,25 @@ int shmem_zero_setup(struct vm_area_struct *vma)
 	return 0;
 }
 
+/**
+ * shmem_zero_setup_desc - same as shmem_zero_setup, but determined by VMA
+ * descriptor for convenience.
+ * @desc: Describes VMA
+ * Returns: 0 on success, or error
+ */
+int shmem_zero_setup_desc(struct vm_area_desc *desc)
+{
+	struct file *file = __shmem_zero_setup(desc->start, desc->end, desc->vm_flags);
+
+	if (IS_ERR(file))
+		return PTR_ERR(file);
+
+	desc->vm_file = file;
+	desc->vm_ops = &shmem_anon_vm_ops;
+
+	return 0;
+}
+
 /**
  * shmem_read_folio_gfp - read into page cache, using specified page allocation flags.
  * @mapping:	the folio's address_space
-- 
2.51.0


