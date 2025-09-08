Return-Path: <linux-fsdevel+bounces-60503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AD3B48B78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25631B269C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB1A3019CC;
	Mon,  8 Sep 2025 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JIDNbyO1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O+jE08CZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C772FD1D8;
	Mon,  8 Sep 2025 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329937; cv=fail; b=g924AnMKc18JYHWyBreaZnlcqOZMRy2G7AXHF+C8x/9UAUYRD4a8twZxzBKTFvl9vJzWLxiyNJuU/e2vMn29dEzJ4pffhYj9Y/Abrf6dFPVvlBgua99T8zyUWqliwkv+2IOAKOwSgexiUvyA+rMHLfXqtrfb8Jw9ftkowx1VQr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329937; c=relaxed/simple;
	bh=TfxrawM7mat7dNNfoO8iGJivlQ5cRmI8BqVq3zYc6JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LLSjwvIRDNGkYf+J+6Hc6Lp9VEUTxlGaNravgssyYblYedemmgEAQtu8K58C7Lcucs9PYDRuhOoim2C5T75W5SdMbgjbJ/iTBYCgos+FxF42BFSBqBpIQQzVqKdOhVf6XSqOpCx/HzuwTgd/rgzrvHQLFap9Pjx77cgiwdfL5eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JIDNbyO1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O+jE08CZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889ic7g000817;
	Mon, 8 Sep 2025 11:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3Vzt7N0rvfnL0nFRJzJ9pTiHwoRpZgf5xB5+X6M5R3g=; b=
	JIDNbyO1xBJAigw8bQexz5WRxprv2mZqaFG1Y57m9bXy3wkrbtKBWU+cqm+CA1by
	DXBqPsB+mAeluwj/6X8mGWjvbQxAn/ceudkdu9gAt9Q/Wrg5Q7BqlmfBzCS2SKdj
	Tp0h9IVWiEILl9VI4wslLOkQpzh4RUEs32KVbnk85/BxfCLx9FL7YqWf7WEFqe0T
	tmpmViIPfYYusqOZ8/frv7id34yF0jgbKsEtXhDSkcscHufFmPY/6ZlLQaT9Cxtw
	O2541/AjLj/c5islf9Cr89p2ZHdp5946IOdYyX515C/Qc0pB0cJ1TKg1MLdtXeal
	a5MjCl0voAQzvgcZDnSdIg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491vsc04sp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58896IbD025964;
	Mon, 8 Sep 2025 11:11:37 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bd81ndq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wu5j2xDC4qC++kSOQa3EfTSUa8S2BDHjHFKaUdOvkloJMUmGKk+1ot0RyvlTNTtYoQ8CSUkS3lll1TpO8+MCUNN4HiAHJydyBD4TSMRgRHcseJTG7LQ84/5oaIGAIfdI42QjHfR9TQ5DoPr+hnjmZL4HmxYRJ8JNtQTDSevK8/CTBoxa3F0noUs6k/XO9406Rhe6e5zpGCuUaksduhUlu1fDe07HX6B3shkWz130hpBCx38nZltICRYhym4a78VRYbji++QZm5m1cJEy6lCAsoU2jldDsb/BIKyb1vhLEKLDNRMyvDcfdnkNRoDxGyW/wmaHX6uPgvMBPLRc6co2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vzt7N0rvfnL0nFRJzJ9pTiHwoRpZgf5xB5+X6M5R3g=;
 b=IIlew/KAKupw3ZxjQEJtJwxlHTYktVSp5x4pFPg+8ImpAvmVlp2k+TyFu4mv7gAMaCVSzHEAX/yA+WNzAuz7Eg5bKdGJ9A/HFfCd6f0WFdHn0TVdCgg+XNLrMNryJk2UiNOf8yxtPmogoE93BMCWs9We/IPvyDaJFzaYBJr1uQhGALMlDtNPLAQUYtMa8C2Va0UadSNfKq8ps0TT29f4TWLf2lxS3EnNgNuZeRlFY+kF/X5pnJr1/fPwhLRAHdMWnGSf3VXXJZMsyRKLcrUmz3rVeuGuXwR0NJSzUSkzKQ4SiO8E/0D2czE3o1lMk9bGzyLY3+ojak+TLVzAsi2kYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vzt7N0rvfnL0nFRJzJ9pTiHwoRpZgf5xB5+X6M5R3g=;
 b=O+jE08CZ3pOHmeF+NGY4EEw1KuhLDMT0TM88UvZhvcyp8XzbQfySXcc5/opVze7zbPUm9D+Zh41SnhiiBV4yKYWv2inHiW4qWmB4Adr5xoYBcgvyXgP0ChpBX+mJdv3PPQaM9tx1M6zV3xp/KXOEASZxwfRPqS7IRlHuOUZ9CeA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:32 +0000
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
Subject: [PATCH 08/16] mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
Date: Mon,  8 Sep 2025 12:10:39 +0100
Message-ID: <895d7744c693aa8744fd08e0098d16332dfb359c.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0005.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:273::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ed2911-d7d3-4903-4a3e-08ddeec8773d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SSVDyZraWoKOZNRwpkvuLo1FZMSufQM3+IZXNC5QuHYXTN/ARtmVZTqv4x0E?=
 =?us-ascii?Q?Bx2/Um6d8tkbDFAetYv+ajM68bAwVCCZ+oBPeATJJc/WE08Sf1/bBWKhnMIl?=
 =?us-ascii?Q?AB+KzbRxQ7RaZiBmz5RrNcYdT+IjbqAy8rMt9TPJdYLWwWqOQWejsYz8I8Lj?=
 =?us-ascii?Q?zYXlz1i7qE9i8jw1cAekeWN+HZg38SXF1JH+Yn4v07V4gmqyz46a5jjJwV7X?=
 =?us-ascii?Q?hotwchVGksOownYIQQLbT+U1YKXJ+CmC0SLw/mjJho/cwlIlrC0aQ2JhuZcJ?=
 =?us-ascii?Q?ba0FHR4kBeDkg5IBu6R/xw4NFVfVnnvKSw+w5mdcscLB8wnyL152mnBKkSKc?=
 =?us-ascii?Q?13nhk1CjKQ9NdkH0ja/6bpwaGs3ch2b2Bgh3F+L3PExiusngHhQyaOheT/Qs?=
 =?us-ascii?Q?9klw7B+fZYTLesnUPq9iDYLiwHeXxReKLn8CTu6FiX4z/QrRrR7ZLwJkEdSt?=
 =?us-ascii?Q?lXhwgIOFeUCwCGJZ/8nY4MIm5GeMbB2At/E5YBk7KA9LJDqyxSaACCExSosb?=
 =?us-ascii?Q?4Lz04u3vy7tP9lkuWcHWwf4UpOlTSE+BBWxVaEKlqMi2wKsy+Kef6Sm5gD4W?=
 =?us-ascii?Q?YU51/wypksh5FcZdL5LDu0VCoz9lM24/sP0ByCMnQxtvUz1DqP+cX7R2hol9?=
 =?us-ascii?Q?CBYqCLnZu1fU3cPTZFPcFHRS+6LgePg00RCRg1LxPAS/T+bGkfhvKbtRO+qd?=
 =?us-ascii?Q?7UyCLbREnHFp7ESpLXTjScZ2YbfH/EXbpOGfsS4Dqj5ucJY8gEeO4cFYzh43?=
 =?us-ascii?Q?AYLROK75/cOn+YtxvmgrjrU2RMThAboAh1P+L3wSPpgzCr7hDaH7mR183Jvt?=
 =?us-ascii?Q?8j89QMXppQPzv0DefeF/RNU0x7ghhSzd6kmr4wA4q+uhnfaS1mn0/CakNbqx?=
 =?us-ascii?Q?1DSnTIf0R/2/nLI6FJMxXoRPovSihKRAlSnmg7SD7JfLHv+Jkkj4pOwngkZi?=
 =?us-ascii?Q?3MDnOnLYxtUR7E6P5YRVyUfzPw1buA3Irqfefi0FAnXHtJQ3gCNaZbuNNrRk?=
 =?us-ascii?Q?EOn9g+MYTD7oqHycczAjKdkLwAI25Ved00R+Fun47cv9tjtwLevPEICrkf6D?=
 =?us-ascii?Q?MGTxWSmyGT6bU9RPLF3z8Bweo90vkJwor5oKoxitWjvY5AejSCHW+qg+Jfnc?=
 =?us-ascii?Q?EhMFZk7AUh6Wff//M4Or4ZRoFIZrnD6MgcHKJJkQxZASNPrgA+UEun/g4gY8?=
 =?us-ascii?Q?ztuvhz5wHuR92ysfUZINkR24+n+1fN1LasmKq1YQI/p/9QF4WDIeFTnEClxG?=
 =?us-ascii?Q?gnL4QXuCM4/hNp8XuGC1oNewfSrQncl7ZOIrJKWzqfmHZTO2x5beao6goiQT?=
 =?us-ascii?Q?PiqfkBU7LIoyTZheMAj3UM0/JJ/SNJvCqqmRus8kpJ4IQ1VytVb7XKHRiPte?=
 =?us-ascii?Q?4ZMClo0GJJLCMdAyBwCae0A40SMX5DXe+WXRlzNyRdUtDydDMVRAN36LiDJz?=
 =?us-ascii?Q?XDiRyVUf3ao=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vKUSiOEfe263YAibwe8mSpQ37NSj8AmSS+2iyffZKM156OaXirhrChgK6axL?=
 =?us-ascii?Q?TpWjmfqNaH5jw14Q/+T3A4BVgw9f2I6RrWZwMT+OuJo3EOg1IDyqkJOVdcju?=
 =?us-ascii?Q?H9dmpoudYCEDiDkzWxBU8vTqdWdv0XjbIMZYAqDmQ5z6xe82K0GqPPcGjzs9?=
 =?us-ascii?Q?WTJK01Q6ip3uCaa9jng4kvAD2aQ0jVvZdR/tj7FX9szheooSv4MXa2oOmBRO?=
 =?us-ascii?Q?svaYlW0wpbntAhzJfkhQa8B1edzppqhoo48f7OoCvxTDFMSeENiL8A3nwMTw?=
 =?us-ascii?Q?Tdz140Ro1MLGJDJEHNSsaiW2UDSQKZuF130e1tFoiZDT8E+vnuHCHFlVh8vZ?=
 =?us-ascii?Q?2u+Hd2DyqWOuSkNj3/neIHGG9VkNtmQ2gdd4LWpL4A07t2JMqKdq2nmKkhVT?=
 =?us-ascii?Q?/w0M6uHBPl/ythPLC1kDvqTZEfPhBIsnKs5mRRc7Atse+lhiloaihAc/S8uF?=
 =?us-ascii?Q?4reLnFtUysxg0biuFDZeWEYZpYpw4+ojV2Q5AdTjgNaEMwWP6DXuzIR0G2X8?=
 =?us-ascii?Q?x+S7iUcAs6ZU2sBwQUBGdsNSnQhnr3nPTk7MHa1KkiMV1fT9TDXJccjh59px?=
 =?us-ascii?Q?gBEXxGPNHTxjsD6z18GNKZnYhsKAOWGxvWN5BAK5K0d+jLUVS4Vthg553t7h?=
 =?us-ascii?Q?lKa8iuUhVoHj8cgV5NgZbT5puUjNV/fRh3ZtmHFZ57fHnhm8M2uMCIrN3Zqr?=
 =?us-ascii?Q?o5OIOTdrwQ2MAsoXBuDtVsGtg0242LFG/eHFIeLP85HRkkIujBmRxuhU9HPE?=
 =?us-ascii?Q?qfkuq2DKwysi75++GySpq/xUd6qlECPUQgRqPCh0yJo2JUMFu3/r9gR4PhUB?=
 =?us-ascii?Q?7psSwGxf2q6j7VMePHQ+Kfml1Nx2jTkFCuJwghuqUfgeggoX0qBo3Wij3oh6?=
 =?us-ascii?Q?3IDUmdWju3YA0PC4igMbr7ec8GB/U59bykEaQoDPcmbmYRLtS42S/GTzG0kP?=
 =?us-ascii?Q?y/wN6Nust+68Q+swTo83mRmauWmGEe2FIoaLkEQsc5lLPF2fMyS5ea7gFCFe?=
 =?us-ascii?Q?zRoTh4lzeSJz/4yfYNkGf+ezqBdjFem41hgNC3EeaU2y43hUVkJUKoTI6onM?=
 =?us-ascii?Q?rJIFtnsz7DevpT72zw01phPOjIhZtSI3xE8jGWJkmJD2GEwedBVKbUk6QOgl?=
 =?us-ascii?Q?G6TJfEf8AhPnBHC4F4dXCiL7sVJGKHcjtlPnqEmDoI8Jo2jZaTdzNOC6RM7r?=
 =?us-ascii?Q?MTBgJtokpdwlQxXclIxenRzvKlehrVjqIWShRJk8Jl5EQYzgrLD9UHqy6V7X?=
 =?us-ascii?Q?bmTYM7FVV08dIWQo4gwAIDARkYUuY5UsWR4B7OK8vwHvjuIZlMbP8Nsakk/G?=
 =?us-ascii?Q?/uPRlFyiBjHFKlrno1spkbzciWW44WI77YQhdG5nHba00yjEdkyeVTWiPuRd?=
 =?us-ascii?Q?28KVnlbNtQzAyJRofkeBsHcw9i/6feKwUVwSxTXcxupW9dqL0IF/LxdHB5+Q?=
 =?us-ascii?Q?LHCDSecJDj7kHl3rgOsjvq+n6GkdVUjotUVqzk8NqyRu9eQXXxgRhbAPOPAq?=
 =?us-ascii?Q?vacJT8DaFrzYNY13lSfRYZ6Jvhq15HK7p80qDQaHSKB8yfR8Yv3yPD2ogUdi?=
 =?us-ascii?Q?xtk35wuhGGfUzq+XOhbV11MuHMsrZLaPs3T5OoB5JjMUg6jItPboh5aw6A9P?=
 =?us-ascii?Q?TQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yQ+q2qz4ym/VYkdnBDlOsw66E3LrlPeErgv+PTGHZ/Fbqh6fAoaAGl1OKTRChDM6eV63jAQy700sLcJYJl6Icil6npomG/nLfH1XvfXAzbjb61wdIvUe6mtd91hXq8DbqMQyzDqk6RPWrlm/vh/Fd314MGpTsUcJIbo4MF7/Alu3lAwumiX7MV7Pq1M2bRVo/soHdkvklPoFjzUawCV8ONiK9P7l5Y7qfj8Q2vGFm/it9wS8ywqKGK4CVYqUGOt+f5D9iSLKdTgLzWKkGhpfZPXcerPVHybGQu5+ytn7+Y1m1bEvjvxfQf4CrtoCurwplEKg4r7tb01MqvpZe8Kq5b0PkEGhtdfAEBr0R9iZiVgdyJZpajAZCb+qkV78VDgkMEruppfERsvX9DfpkWpA1wvk9TU3kwRCHIOxZlGVYSxtoy5SkyrvbPif1pFeb3zH07IrAiOIAqTL5XP0czhBAVajavQIhfXTWzNg4asiArfV2XZqTlpg9wPUpyeI2piH7ysUtGcaU2XdDc1qT7bi5YXyDElQ0wgM3YEgyz+YDHCx8B4DHcvQGf2gNzjLmhTfVc8icaglv5CWn3jiKHUWHWaqNglsBOVazGGqiSth//w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ed2911-d7d3-4903-4a3e-08ddeec8773d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:31.9657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkrATbXW+RH0SBb99JJn+l9imk66zLEqqTu1jPsU2/g2r/d9zhXiJ7vYqpCPYZBVosTl7UGzJPV8oMOED61yqYvajm7w+vMHzcGd5V2MIkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Proofpoint-GUID: YNAAYCP9oSKjhnlMfUodmkwn7TRHaWSz
X-Proofpoint-ORIG-GUID: YNAAYCP9oSKjhnlMfUodmkwn7TRHaWSz
X-Authority-Analysis: v=2.4 cv=JvDxrN4C c=1 sm=1 tr=0 ts=68beb9ea b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=biaX2fR5Clc4S6gQdq0A:9 cc=ntf
 awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5OSBTYWx0ZWRfX7FIlJSg02feA
 QqF1ewx680a7CQGiSlwqoPkq51O5o520peFitnmatmKMCHMe1lraFKCqUnJPOrIWXUZICb/aLtK
 T6OS2KDTHyy9OOM/J+Qc7i13FklhjG4uNkVKkpGw6tfBn1b0IJTwNIRIU7zZxSduwwYNmdOVWZK
 /FpPdKFRfxNPWkX8cGyLQfopmYG5pPQyrTB/di563zpAbbXKyFG/My0TdtjtZ5lNsWmAAu7MLe8
 HurXnsCbomjWXe+Q1SjHG+MTaWqw1KoeXZyy9ogS+wF6BoB4RV79Qn8SG7fHARo0XDGZ+grzGo5
 3XWI3oxttwD2JJq70fh1W/meri2ONn5hvxN2De68Y8GFKWcQZeyctn8ahoZql8hV8z/e9AHtqfC
 PKst2Wh7PwIKxuYyyd16qSER9eNxrA==

We need the ability to split PFN remap between updating the VMA and
performing the actual remap, in order to do away with the legacy f_op->mmap
hook.

To do so, update the PFN remap code to provide shared logic, and also make
remap_pfn_range_notrack() static, as its one user, io_mapping_map_user()
was removed in commit 9a4f90e24661 ("mm: remove mm/io-mapping.c").

Then, introduce remap_pfn_range_prepare(), which accepts VMA descriptor and
PFN parameters, and remap_pfn_range_complete() which accepts the same
parameters as remap_pfn_rangte().

remap_pfn_range_prepare() will set the cow vma->vm_pgoff if necessary, so
it must be supplied with a correct PFN to do so. If the caller must hold
locks to be able to do this, those locks should be held across the
operation, and mmap_abort() should be provided to revoke the lock should an
error arise.

While we're here, also clean up the duplicated #ifdef
__HAVE_PFNMAP_TRACKING check and put into a single #ifdef/#else block.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h |  25 +++++++--
 mm/memory.c        | 128 ++++++++++++++++++++++++++++-----------------
 2 files changed, 102 insertions(+), 51 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9d4508b20be3..0f59bf14cac3 100644
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
 
@@ -3611,10 +3626,12 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
 struct vm_area_struct *find_extend_vma_locked(struct mm_struct *,
 		unsigned long addr);
-int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
-			unsigned long pfn, unsigned long size, pgprot_t);
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot);
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t pgprot);
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
 			struct page **pages, unsigned long *num);
diff --git a/mm/memory.c b/mm/memory.c
index d9de6c056179..f6234c54047f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2900,8 +2900,27 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
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
-		unsigned long pfn, unsigned long size, pgprot_t prot)
+		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
 {
 	pgd_t *pgd;
 	unsigned long next;
@@ -2912,32 +2931,17 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
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
+	if (set_vma) {
+		err = get_remap_pgoff(vma->vm_flags, addr, end,
+				      vma->vm_start, vma->vm_end,
+				      pfn, &vma->vm_pgoff);
+		if (err)
+			return err;
+		vm_flags_set(vma, VM_REMAP_FLAGS);
+	} else {
+		VM_WARN_ON_ONCE((vma->vm_flags & VM_REMAP_FLAGS) == VM_REMAP_FLAGS);
 	}
 
-	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
-
 	BUG_ON(addr >= end);
 	pfn -= addr >> PAGE_SHIFT;
 	pgd = pgd_offset(mm, addr);
@@ -2957,11 +2961,10 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
  * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
  * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
-		unsigned long pfn, unsigned long size, pgprot_t prot)
+static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
 {
-	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
-
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot, set_vma);
 	if (!error)
 		return 0;
 
@@ -2974,6 +2977,18 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 	return error;
 }
 
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
 #ifdef __HAVE_PFNMAP_TRACKING
 static inline struct pfnmap_track_ctx *pfnmap_track_ctx_alloc(unsigned long pfn,
 		unsigned long size, pgprot_t *prot)
@@ -3002,23 +3017,9 @@ void pfnmap_track_ctx_release(struct kref *ref)
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
+		unsigned long pfn, unsigned long size, pgprot_t prot, bool set_vma)
 {
 	struct pfnmap_track_ctx *ctx = NULL;
 	int err;
@@ -3044,7 +3045,7 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		return -EINVAL;
 	}
 
-	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot, set_vma);
 	if (ctx) {
 		if (err)
 			kref_put(&ctx->kref, pfnmap_track_ctx_release);
@@ -3054,11 +3055,44 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	return err;
 }
 
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
+	return remap_pfn_range_track(vma, addr, pfn, size, prot,
+				     /* set_vma = */true);
+}
+
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	/* With set_vma = false, the VMA will not be modified. */
+	return remap_pfn_range_track(vma, addr, pfn, size, prot,
+				     /* set_vma = */false);
+}
 #else
 int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		    unsigned long pfn, unsigned long size, pgprot_t prot)
 {
-	return remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	return remap_pfn_range_notrack(vma, addr, pfn, size, prot, /* set_vma = */true);
+}
+
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+			     unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	return remap_pfn_range_notrack(vma, addr, pfn, size, prot,
+				       /* set_vma = */false);
 }
 #endif
 EXPORT_SYMBOL(remap_pfn_range);
-- 
2.51.0


