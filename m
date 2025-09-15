Return-Path: <linux-fsdevel+bounces-61410-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7B2B57E0B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096231885EA8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 13:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7A9207A22;
	Mon, 15 Sep 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Je/bfMan";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eRJbFBJO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E781F4C83;
	Mon, 15 Sep 2025 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944363; cv=fail; b=uQcD+UJE6F8A7FEK2qE7gzMvujQJ6E8Uj3v21tEmmLlV2z3F3Fx8Udj5lvcFczP3pWlqX5aDhxu1dnp8wx852sX7vxW91jbeiWNHtHTzhsKAEmCGlQfQAZpVL2xheNAT+6kOk4HmaHqqKr/DZMrLykSGyacJgzot+BRSDW0uj1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944363; c=relaxed/simple;
	bh=Vkjj/W1tmUIkngN14rnfnwrDICbNXT3wER8+ZQTmM4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ehCkGlN5sfhk8Pkd0OxUKe7MduE01SX2W1YC+gHSJJnQ45Yur48cduWPWcz0Qubi/Vgj9dFbeYL9FW+JWh/Xx9LSBIt5m6t8JnDkIS+ZnjuLz5MmMTKvqNJAAbgCMmbOIED4Fhu1AsJNOMv3iFrxVY5/8G2c/5cnOw9xLaH1j1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Je/bfMan; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eRJbFBJO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58FDCFQw029411;
	Mon, 15 Sep 2025 13:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=kqola0MdN7qJFl5/Sc
	cvB5ilHkN8lF2Mp/LG0uGP1VM=; b=Je/bfManiq0Pc3vIgXwIsO8lFsOAY/vKhY
	G6gXs3RCk8ERirOMdlhZaB0itKYDIC4g3bv8PegZqi3GDPsCoqVAMSN/93icgOVT
	Uv/py9HANQzKVCjLieaC9NIKzPj7AMnTuGiQI9+sW/zH3rec20kC0NnFjC933QwQ
	SrMI+NMQcIldmOjsL6LH6StYCP16ja60Q3AF71JeUApzssS6+qPeETzjo4uoq8wf
	UsQyaC71xgdllIifCafl4Ej7WJed8d0UJhPzwmsLdf+DrRNa4U2AFJ4EXQ7R7srS
	bfiwf/8i/wzwtppt+ywJZwey6EG2ctnIBIeoRcGQ0T5SA2iuZaOw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 494y72tfst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:51:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58FCoHA3010552;
	Mon, 15 Sep 2025 13:51:58 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2b27j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Sep 2025 13:51:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GgFBdxd+Jv1zpCAMAHA8fHBCt+MRwQN2radDYRhINqqmaSu8vX3NsZ6NdoQagSMGCvk19VE/DUBCYyFQYz8lPLqpr70vnMhaT+X0wAkz3GQ5P6+s4TZ5urJVQSHm3EDpMrCoVS1bODjZuaV6Ro7eBJAgo7zxRwPlKRjqQnia8+5R/XEKDJJrh3OoETuAgn/lPHsoKkqCjb+nxul+D9ov7yWYiKKKSLLx4z2MfHMSVOfRURqwAiD3vGcfRL7CAQYH2w1ujTRwoWIQpFQU2bAKomJ+uwzHuJocKtA21DrZP1PB1wpFgykUuwpHwh05I7UqkuCSqrI8sKWa++46wCxbWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kqola0MdN7qJFl5/SccvB5ilHkN8lF2Mp/LG0uGP1VM=;
 b=C9YLxOLhNr4oxKDBR2wtYGjijsvns9J9OLPczoQ92iMFBK8BkGC8+bm0SCWNOyvix1TAcvXI8AjPefaI1qn8EKXC99fnkWlyPpT0VvpWV7aiUppycqxRAJrq0S86690wMkRZKkovk4mkEe9L1gddmXpMBNjPdBa3BakPY3sR2BpVSy25L440iibSqM1tETnqzko/BQzqCc539iVkrVWeLxGnz6sr0HgsEzwJkExhSN6OtwDggIKouMp/M1LEh5GR/ocZYhV7NYmN6LeLVBFTXu3iIdhWd7a5XMkpof5Fei4NHf/rSmCF5IizaeapGr6mxQuZmfBelsa7NngMVjUcRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kqola0MdN7qJFl5/SccvB5ilHkN8lF2Mp/LG0uGP1VM=;
 b=eRJbFBJOwSSjGm+Nf8DtPhQ19GpxtrGFa7aRWj0jwfHS8v/AxA2Umie8Wg7YYhHPO6Vc6L2+uU38nCxzmPZv3hB/dauGfRDd0xol+yHS4ZeEc2mAxcLerdS0rnvPJM4na5i5PJLHCmEGa32l2Ob/uslikIVcgeuOXhEPUQaeazs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8178.namprd10.prod.outlook.com (2603:10b6:408:28c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 15 Sep
 2025 13:51:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.020; Mon, 15 Sep 2025
 13:51:54 +0000
Date: Mon, 15 Sep 2025 14:51:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
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
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 08/16] mm: add ability to take further action in
 vm_area_desc
Message-ID: <c9c576db-a8d6-4a69-a7f6-2de4ab11390b@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <d85cc08dd7c5f0a4d5a3c5a5a1b75556461392a1.1757534913.git.lorenzo.stoakes@oracle.com>
 <20250915121112.GC1024672@nvidia.com>
 <77bbbfe8-871f-4bb3-ae8d-84dd328a1f7c@lucifer.local>
 <20250915124259.GF1024672@nvidia.com>
 <5be340e8-353a-4cde-8770-136a515f326a@lucifer.local>
 <20250915131142.GI1024672@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915131142.GI1024672@nvidia.com>
X-ClientProxiedBy: LO2P265CA0376.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8178:EE_
X-MS-Office365-Filtering-Correlation-Id: 61017c59-a778-4efa-9177-08ddf45f07b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RyTD4n53R7bk2i7QEH16BZGE74ArW3Fte1TI2FFlIEbCn2KofG3dLnA6Bnx8?=
 =?us-ascii?Q?kBsI0ddoitZ6mp4/9ESzU2aKKuPLEv8VVoS7lK35pG0LJv8QdEZaLBD8T9Pu?=
 =?us-ascii?Q?0sLf73XZmvaNb4HXR7WDdM982/v9jXmHPxRxOnTq08lWBiHvkfF0T4J8w3nM?=
 =?us-ascii?Q?NQlTGIhAfFUuIZOLYrfKqKW+NWNX438KGgP73OqQDA4V5kH6DeLXLArkuxQL?=
 =?us-ascii?Q?fpr0P6H4bFO13mMXwXw663ip8UpMbtogyVvkR+iK9qji6ibng3ptDhJVqkWb?=
 =?us-ascii?Q?ofZ334wSUf40ZZ6QBOnQktfLShy6gAHC4lIZ0WlkXUVyxrWthwblmb7Nif85?=
 =?us-ascii?Q?FCXQlQCyLJbuVHbsMwFbAcUlYyjjQ31zr7YWyrRl6lQcXMVJ9ugejBiCgnZw?=
 =?us-ascii?Q?KqRsGRsYvF5FZUnJWydqu8KF4Ux4b/7W8VG3pCpNy3D0ID2DN5JouKEMiR/u?=
 =?us-ascii?Q?qIyQLRIYoObReqnYOq4qyfJVaCojiua9wKWPiVPMx+WEtzGHtztyB9EP/lUz?=
 =?us-ascii?Q?JGIz78jqDvoz6DO0ExN4ZbXQZPFVtP5LzQznHHXUwrS7Rs51Zubo5W/RlOid?=
 =?us-ascii?Q?0Knk7CtKvshPl9rLa6e7/qb1C+OkV4vrS7yh7am+WVLo4RmfHxGiNNtxNXHN?=
 =?us-ascii?Q?q15RAnTC1e7LFYpPOi/Fw0d9zt1f4RT03TuzLNznNyRXnG1O3YgC601M7K0y?=
 =?us-ascii?Q?64pnPgCeZJM8Xb8umDc44U5SDOjsLpDx2SmHV2utqE3NZn8h9aGVl4KyMa0o?=
 =?us-ascii?Q?8wE0ZoxOjSRRZqU3imhTckhsrq4uxvh8dU4fUfaLEnkC4PaipfqQqzNYWRqr?=
 =?us-ascii?Q?3+tAkMi0lmc1yrTMrarfJN4jnN/Jj+i8ZkECy0jG7YqOOuEA1bpvb7cI1osZ?=
 =?us-ascii?Q?hse7xKkJsaSmtFlKO/JdterWeykaHtBC4sMPkU18zFDCrlNOgk3yu6HKE2ZM?=
 =?us-ascii?Q?EbsA2w/5ua74QXi9KiF1tgU3YOzOUnK6fxmUlhISgL196WbeHwdxGhWpP94p?=
 =?us-ascii?Q?zTOxfzu0ZQhWEqfk0abledRxUDt7keEqmpC80t1S0Aq80jnA/gaRSgwVCkXa?=
 =?us-ascii?Q?ujQgPY0MOHT/bBzrtD3kzh1ZmPC7TKfaUiQ1zMro3MCmVexu/BexQIqbTNoJ?=
 =?us-ascii?Q?BEvgKwyEfoztH6GO8WC3chJg+R0sYxK3hcXXFwwwyQEhsgQx0I7syQtrR2tO?=
 =?us-ascii?Q?3hBl0MK37hTz/1EahcHbu+1bZ4tZKxQCmsME0D/NEaWyRwr+uep1TVCiegFn?=
 =?us-ascii?Q?BpLveBo4EnD/wQvviz5ycM7LWkcleVYihcuIbPSuvgGnfRg00G3HIV+kiyKJ?=
 =?us-ascii?Q?wriH35UX4adsx+hy+9NDU4ruvQg+KYcMfYTj7t1Uj4OERM7lGx4Cjhb+88Pn?=
 =?us-ascii?Q?e/Ga8wQHXbHE+qOs6v2VYypgfGO11wuQURSwq/8RpRYq5pdReTivv8tOqmzl?=
 =?us-ascii?Q?aWLrV6AXov0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1f23maKpzUfQPEb8tUw/BwwCraOzyEKMHo7gMKsW4nYCmAXofpgBjWI6A+e1?=
 =?us-ascii?Q?EWMBgNZgiup3VNntUQreyfeRWnk3hsJKYfKKcwQqWGb7YNZxbTXe7AiNS89S?=
 =?us-ascii?Q?vs2UKd3nGMRkkhDSLedukWqr7Z2jWpnhJMH2sGVQ1ABi/hlW7rnzoGpry35M?=
 =?us-ascii?Q?O7lzR14N4MkKYwwjihiR0kygw/HRAwhpIP6UkbCw8E74mTIYTO5vScKgOIk5?=
 =?us-ascii?Q?6U2mtinWP0t0dc1AQCMVgbK18LB0kuYdunY2MgokIiO7X5U6krGOA596OlFg?=
 =?us-ascii?Q?3XZUWXvWSbDk01/2OmctVTb8TOfg24CEpsGt8b4ECv8a34+7jQHBJl3pO7JF?=
 =?us-ascii?Q?3+rhpm+tLjXO5++8DinxvgyIjhU1CRkOupm1IY6aNp16aweRcWXN8t8ARJx3?=
 =?us-ascii?Q?ce/5z+iQEi7nG5yt/nlGeOfSyuAwwgt5TjK/q5Jz6v2DxRNhuzPo7V/PxRQ3?=
 =?us-ascii?Q?OIJ+j5vHpZrmnXMTTkbyNtIcK3q5eZVU4NE4ZGrhFGhEmJf26zqFyO5i56vD?=
 =?us-ascii?Q?CnjNCKnCs/+ypOgKcEALaovUUiCXeSxVcdGucFTrB5oLWJ4eOWfUzDbhYtoZ?=
 =?us-ascii?Q?AoyDW221f4D5Xn37RM2lQCUKWVuBPh2LvZx1v0aoFpkQ+ZzIDKss+xmdTuQP?=
 =?us-ascii?Q?oJ+c7wzmZ6YnJ0hl0JYcB/uJoGgcwdvgPuj+Dz+P1FmB5L0NfUiQG/SB+Ble?=
 =?us-ascii?Q?FJN2Q83f9N0DZGpD2on2octcZ3Q0e6ebt7UXxhX+ctbN4l6aP3WLmV0QOdff?=
 =?us-ascii?Q?KGVHc0z4h0PzdAH5B0IkDv5cG1VYhi1uFFvRmVNKZvSReYyG1czQR78/5+zU?=
 =?us-ascii?Q?fpmzHwIN35JoDX/vzJJKqIjLNfzmNKp/MwAHkkVwZ2mK3lLVQT6yAjqL/+JM?=
 =?us-ascii?Q?GJWVkVTvwlyToGjuQLzmlDummK3OHMlbRVpnP7XNAlGeRB3OBv4C39lG6JY/?=
 =?us-ascii?Q?mAm6UosALr3P5l6IrsdsZysmD4Wbw3JKeq2Oqnt4FN7mhbQEASMkJ5kHJqk+?=
 =?us-ascii?Q?e2ZSjNEjalr6rQvE7C3le3Mb7pMJsQd51W6VqlKg/MOgAOJlNjy48kGjS1z7?=
 =?us-ascii?Q?8sb9YaDAFTTHQ+Y6HExKQC+SnzDV17HsOeViWJFZS+n1/2qdLM8E5pT87xd0?=
 =?us-ascii?Q?LHMX0pcZm4vYx+BoBTG+4dxYZS2Koo6DXT3CaEDYh155/M8oN+l5/i+5VuD8?=
 =?us-ascii?Q?rmj7inhUg/CpsjEbSMjRUmcBnyEGw1ZQzumDJSqFj7J9hjGOFSEnhpLT/wy0?=
 =?us-ascii?Q?fHIGoi5fEKvbcSdHHk8YEs7QEf5ZI8W6PIa92SAdLJup+EkyXt0BhjygL2sW?=
 =?us-ascii?Q?aXQPfmXM0f/pwPqDZtDR9qKBqx7N8ZTuDR5KIQ5+UxN8MFtyn3OhjH6mQii1?=
 =?us-ascii?Q?A74ctus+dfEMXw16O9NwSv6ILjV7xhlVwuUInBHWsQ+CiaZqnYIC8xOpD/RX?=
 =?us-ascii?Q?5awjKY15xseqWaM12zCl9HL74mSPY12Nc5BYkuBbtY1e8NhUSG+gWTB9MEsA?=
 =?us-ascii?Q?U4gCzb93YSRKI+ZokkLuoNcKqw/8QFDX/5akg1a2iNyCorHTeysPrnjCW4q/?=
 =?us-ascii?Q?tSD1g52vMoIk/GvsztE/cezJaVHjmIQ7VEnVvYJG2/6A6f8iPvgiI5z/eZvM?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	r2CgnSnv92gAftfG2ElsbuVf7bKxxw2kyFDIsqGzXW6atNOzV2mPEZS9nsVJH7VmlSC6S5XLyLkD3Ti4Q5OrFt6t+QX0kbNrPK6xIFk8iBVkOxq6SO8BmVGKO3jKRsj+s/TEP+dz+O3agmYD8kzTNA9J8cZCb6LpQFZcJjPUWHM7P16GHPlVYEjH/MIMPfpg3+hio5fMCulUVz+UCO96nuAippMoUfNTxf5sys1jY6qtd3D+CDXbYfnxLPcROf0Rx1ifZt6jBTjmgXmp2OuMZft6bMVtl9XnCJIV+O06js2YkvcKJBw7ta0vqcpPi+ObVWmVfw+4Ih04oRTF8MFIIeFg7EBqM6SoNR9i+UkTvOjHR1bWwZ/DXpq7xoh28BMzGFvrEcT8HggQKwe4YtMrDRkqTZzP5ARb33DW79+3bAgVVUTPSyjj8AdUvEYZWf4VLnwb0AXqJjO6BSbN05Ix76aWo/XlykhVxI/KXX3cSluskx2awZkV6LLMZTlghzHYFS3wirybLHnriM6XbV5YnSSXaM3hiUdz/bexB/YVENbLi+cN3WT+5XHFVZpWI/ilbdI+QUhTBQ6ccFs5JYExbGPB1O2uu5vWECuvsjsEhjg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61017c59-a778-4efa-9177-08ddf45f07b3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 13:51:54.6639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT+WR51P9CDksfkZ3sF5mySHwBZVaiUnn5UUshuo89gtQUrDxoAJElPzT7h6wYEvmNfJCYyffH896iJyeSgrrdQhte9KoX/i+k36KJuvTw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-15_05,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509150131
X-Authority-Analysis: v=2.4 cv=F9lXdrhN c=1 sm=1 tr=0 ts=68c819ff b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=mw15ZVPzND2R50_b3F4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: gXkSIKLhG0XouVYveTZoUWreTQ6b8lYz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAxMyBTYWx0ZWRfXwUmNgx1yi9Lu
 12UWAiDDyqcjgrjwHEhUTlgCQFCUahzYwxuriP+JIbwFsFU39rtam3PrAjfBgfD3tzo8sxaFJUH
 rTyjWo/Unh+Eym4uvcrRv5zWgJhv15RWZ9UxPkljmNtMsf9yM7KWSOIDXdvrzv3zsFEaIoEaln1
 k2rmKhXh1mm6B2H01XMph1k61XUDk3S7j5rNXX6pR+l4k76Zh7c6VODHA5UV/x28bLnEvUZa5kL
 AgibcrsJ92MWW0iTTWHlXz0CvCwf14nMKm+s/eiVvTAtYO5RyTKgowO4dfWOtt8Gg72UXNpnqMi
 k3Syfp6lM6qQR57bXLthoQBwzmE8JPcEjdz9YBJcnP6Zuqk59TbGhm3THCqeVqb8oQgOntALzyD
 lTaM38Mg
X-Proofpoint-GUID: gXkSIKLhG0XouVYveTZoUWreTQ6b8lYz

On Mon, Sep 15, 2025 at 10:11:42AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 01:54:05PM +0100, Lorenzo Stoakes wrote:
> > > Just mark the functions as manipulating the action using the 'action'
> > > in the fuction name.
> >
> > Because now sub-callers that partially map using one method and partially map
> > using another now need to have a desc too that they have to 'just know' which
> > fields to update or artificially set up.
>
> Huh? There is only on desc->action, how can you have more than one
> action with this scheme?

Because you use a custom hook that can in turn perform actions? As I've
implemented for vmcore?

>
> One action is the right thing anyhow, we can't meaningfully mix
> different action types in the same VMA. That's nonsense.

OK, except that's how 'true' mixed maps work though right? As vmcore is doing?

>
> You may need more flexible ways to get the address lists down the road
> because not every driver will be contiguous, but that should still be
> one action.
>
> > The vmcore case does something like this.
>
> vmcore is a true MIXEDMAP, it isn't doing two actions. These mixedmap
> helpers just aren't good for what mixedmap needs.. Mixed map need a
> list of physical pfns with a bit indicating if they are "special" or
> not. If you do it with a callback or a kmalloc allocation it doesn't
> matter.

Well it's a mix of actions to accomodate PFNs and normal pages as
implemented via a custom hook that can invoke each.

>
> vmcore would then populate that list with its mixture of special and
> non-sepcial memory and do a single mixedmem action.

I'm confused as to why you say a helper would be no good here, then go on
to delineate how a helper could work...

>
> I think this series should drop the mixedmem stuff, it is the most
> complicated action type. A vmalloc_user action is better for kcov.

Fine, I mean if we could find a way to explicitly just give a list of stuff
to map that'd be _great_ vs. having a custom hook.

If we can avoid custom hooks altogether that'd be ideal.

Anyway I'll drop the mixed map stuff, fine.

>
> And maybe that is just a comment overall. This would be nicer if each
> series focused on adding one action with a three-four mmap users
> converted to use it as an example case.

In future series I'll try to group by the action type.

This series is _setting up this to be a possibility at all_.

The idea was that I could put fundamentals in that should cover most cases,
I could then go on to implement them in (relative) peace...

I mean once I drop the mixed map stuff, and refactor to vmalloc_user(),
then we are pretty much doing that, modulo a single vmalloc_user() case.

So maybe I should drop the vmalloc_user() bits too and make this a
remap-only change...

But I don't want to tackle _all_ remap cases here.

I want to add this functionality in and have it ready for next cycle (yeah
not so sure about that now...) so I can then do follow up work.

Am trying to do it before Kernel Recipes which I'll be at and then a (very
very very needed) couple weeks vacaation.

Anyway maybe if I simplify there's still a shot at this landing in time...

>
> Eg there are not that many places calling vmalloc_user(), a single
> series could convert alot of them.
>
> If you did it this way we'd discover that there are already
> helpers for vmalloc_user():
>
> 	return remap_vmalloc_range(vma, mdev_state->memblk, 0);
>
> And kcov looks buggy to not be using it already. The above gets the
> VMA type right and doesn't force mixedmap :)

Right, I mean maybe.

If I can take care of low hanging fruit relatively easily then maybe it'll
be more practical to refactor the 'odd ones out'.

>
> Then the series goals are a bit better we can actually fully convert
> and remove things like remap_vmalloc_range() in single series. That
> looks feasible to me.

Right.

I'd love to drop unused stuff earlier, so _that_ is not an unreasonable
requirement.

>
> Jason

I guess I'll do a respin then as per above.

Cheers, Lorenzo

