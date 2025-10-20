Return-Path: <linux-fsdevel+bounces-64686-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48268BF10E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4639E3B1C2A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 12:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B37A31282E;
	Mon, 20 Oct 2025 12:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eb5PZf2A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a2dNH6s0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EF72FDC20;
	Mon, 20 Oct 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760962389; cv=fail; b=AT0oIYNH/qllDuVgP0dJnSi0arzaar9TijJAHGjBu6kXKcQllvX0gemewrViSvezuogMwA1aFEn54MmF1HBfro1gsonD0Tl5O4pX05uwF1O2NWPSacokswL2+qAiOi0XEwBk90afERrD1GFGjTleJGwmZFQK5ZjBO8RchDOYHo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760962389; c=relaxed/simple;
	bh=Mw1aJqnVDZ3mqbT+fJNTROd/K2fabq++LXlN1CKZqpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q6uKay5sWB1lFY+pfLc+Ca4Eq9/MmplUifSnLq8UwqeMDVx4U92nnbdHfsJKHRr4I7zmU+M/Ha1mSLre/jb3JsI0DWHkdTdwfm+b08DSfydZVY2uyXTDmlHM4DccKKi+9wrD8DKasnYwheEqdvrVFtuE21ULAGxbZ9l7y6Wo95o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eb5PZf2A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a2dNH6s0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59K8S52N028179;
	Mon, 20 Oct 2025 12:11:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TRCEoGT3dwR4s/ThYrfBe+tuWb/+7tbuFosrJmWgB1c=; b=
	Eb5PZf2A/Qsov36hJijTDb4FF3yxdhEHqj9/Mt/1MqVkr9Xl+dUweEg+hI0q1y9J
	fQladoixI7rKlQgNCHee8BmAGOMs/B95OJ8SJICqt0RLppwSLHl2VkiD2TLOVSmB
	Em2GsUXpVuIyTlf4jw8fnMQuE8TEqXKEiWbltPT+A1hQIdrzI2MX0SxZNxsZkBlc
	G1qKd1kIAb/WqlvOPo5U2VsdWBq9p74eYsln1MKS7125kVSTXaU44go7mAsHC0eW
	shk7bpiddosrfl38KSo4J6FcbKQyaxRlGGEAlrFH7eTC0OvMr1kONST2yLQ93o0D
	xuSsUEoFLhQaOiuhyJwG4w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v2ypt43v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59KA9Z9j032462;
	Mon, 20 Oct 2025 12:11:57 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012028.outbound.protection.outlook.com [40.107.209.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bbmfad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 12:11:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T3cWeB6IlJJf2Q/d0skL+EjySePaBTAdHzERaN6BFtrbLqudJwunDXsmEMlpJ9E5QtodatkmfuOqoUvP21kiJvfzGfCpR5Dudeefok1r2jqIrk51yu5GFjFSXnOUxtBwlKYgYSWjg6fN44Pea/CZNl9fHrYpTXCugTeNTz+KgHTe8CgqIGmsVe5s8aqQ0GZjwEbDac7T/DnVg2bAQWNjuRl++dh74LGMZAOmEINVwVLJ5twS4MPpD3Gqd0sza2/JYua4YA4LGJ3dayrSIzra8TaIUu5GAkjUK8ZPLDZCU/TyPWwg7fK82AdrKpGxob2JPDpqOnBCnTbTEuo7o5DXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRCEoGT3dwR4s/ThYrfBe+tuWb/+7tbuFosrJmWgB1c=;
 b=RfNCxGFtUi9k7XyxcC7RomiW+BUMCrkrMycw21OFF+vuubvpflbVvxd+ZC69EEdvugBAxyKxKC2BrcQw2Sv+cyauJ7AtyhKyzZ7MHFmUAwH4hfA5hAWzFcCSozLaH0j2ItvSl9OyA0hZts8+qOYhMGsv4XvF4jpSPW46Je5obdMrpYwcHspqRKg2zFRkWnkZszTLmmcuvRO7CtbhpEFAKzR3AQ5x9/gL2SkA+lwH6nRdGiWTwEGG5DXDBl5U6eIN7H5OCfwYudWOypBw/VXYn18ZjXnDvIyaHa7gc4BM59iLZbcuPFNVJBt1epIo8rly4kmK5yyTA4LzeGKOLZsktw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRCEoGT3dwR4s/ThYrfBe+tuWb/+7tbuFosrJmWgB1c=;
 b=a2dNH6s05ImdcGVZgahdDHRuv3ARYoB3xnNqvOOobvixwn+PRTJsUngzCtnBtGMlf//d4+7B5I6ArRhsHXb/D/pgaNEysD70ZIZOxA0K9Wum306O9QONEChcsrWMAppMTfRUF5/w+snPra0H3HkDQGeEDdgWWEBYfHhtMDrCA5o=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 20 Oct
 2025 12:11:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.016; Mon, 20 Oct 2025
 12:11:53 +0000
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
Subject: [PATCH v5 07/15] mm: add remap_pfn_range_prepare(), remap_pfn_range_complete()
Date: Mon, 20 Oct 2025 13:11:24 +0100
Message-ID: <75b55de63249b3aa0fd5b3b08ed1d3ff19255d0d.1760959442.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
References: <cover.1760959441.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0286.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a1::34) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 1417cb2a-5b27-4974-0d1c-08de0fd1dac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZAYCOw70G1sO/1chGop29tv7ffuAokbhDWtjZhgEXIexDQti/uAvVDw0vlbY?=
 =?us-ascii?Q?BsVA8R08Hb/fcwaW/VtSUrlhv6Q+PnksMyYzEH5VdsJh+OKiR5FxUZSn7KKq?=
 =?us-ascii?Q?pMDI/Vm3SUPDDyL2rUrFPh4Etv7EdZniFgJzInLIZlrFpeCtPD27Uh5TcIZr?=
 =?us-ascii?Q?HbzE8Gz/nQ6yX1APzF09E4HlYtvWjm+QNCezneysGHPRgPMUToz5gSVpxjyq?=
 =?us-ascii?Q?oM7Y9pEXaUfh/pYzyexCnOVCsjf+u6DVUQGBTEusrkRANmQy4XVum9Rad6At?=
 =?us-ascii?Q?vtWLFEY+AlgkNSJSFM2PU3JhgRnktPplHvgWhX0DinofLX6R4oWQ8bFOxX5D?=
 =?us-ascii?Q?4u5j46hF6gord16hPMSKYEJHXFrIeKP5hpmZWYWSEBWg8beHeADg8kwy83uA?=
 =?us-ascii?Q?MNCntOdQuahPwnI5/9l7eVFe+l5f07NUj6PxTsO9FMNiJSQA1zeYedLpiOka?=
 =?us-ascii?Q?B9Xwgd1lkcU7oq1LX78OiPH0oSktxQXIJOnhnK+9Fi/fC76+bcq7aYsNh/ZS?=
 =?us-ascii?Q?V5Ptks0ErWLisNK3w9hGs3YQBSi4QaZVKkSYBJllwZgB28t4+6z2yw4bq5G9?=
 =?us-ascii?Q?i9tzXT6oOt61vau8dKsr/VZsLY6LAhlJz7exJ0QUzMaz5xOyqw6D/68XGiG8?=
 =?us-ascii?Q?PaqHN4QkcaEkAyHj+DwJNeUfxmpB8ikdxQjKOMAIqanfEPQpae1eXxyO124L?=
 =?us-ascii?Q?HkU6bKNwll1aJRIvj9AOffed+kflxEZhBfIbSyGVjP5VFCpoGrqqpp43oFiu?=
 =?us-ascii?Q?3fkMImVRFGKKQ8IS2bXelRXpZBfYEOevyriqGi73n6OhlF2M46gup1hmnEjB?=
 =?us-ascii?Q?1yOP1ybg9FwfJyOKdPwP2Eaj99wrf1N3Q6roTQzZfbFO9lI6/Q6ha6lT33Js?=
 =?us-ascii?Q?V93o4+tY2RzHdd7WVzMFiWXK8DMROo8ZsoGnxI8QXsNjiE2RCzgFWa/lS/1Q?=
 =?us-ascii?Q?l7MkTW5fcgdD3wfGb3brLOp7+vRsikugFaWUSfS+AMwdOxFbjgOE6D4GE0gt?=
 =?us-ascii?Q?KKh3L/aXzBm8aPik1BXkCKWchiU5SgSYdszMdE9PIFdw5mYijg2HBoTluZhb?=
 =?us-ascii?Q?n/pbNNAwXjvIhsKi6UWUB1CI1hfeb+Lex+li9oUDowQf5GxIiTNv+DoaymsT?=
 =?us-ascii?Q?oX2cLHm7nSDA0siogIPSULcipuHXqe0xCbvEiw9CcTZnFy/q+pPHStPqX2sW?=
 =?us-ascii?Q?ODUGh9x6/MXenOWOK0wrfDYjtZvLe7EfjfEmg8dNaDqwUxY+DOvGLifdvL86?=
 =?us-ascii?Q?JVu+oDZGtehT7MMykVHrppLQb1W+lbs2/fnDKvT40PLERJw+rMt1/m7fpPcA?=
 =?us-ascii?Q?ohCdCJ/vPi8kKnv/VH6/yGu4yBDBqqOamOv3xVglSp49w3jkCj5aQ9KNoYs4?=
 =?us-ascii?Q?DvcJNxyjHLJa4BDUdQ3CCzZGiuUiKwY0qht7vojy3HHBdrsdYQ/SL2ziOurh?=
 =?us-ascii?Q?7rT/n6re6AAkkqMe24x1kM0Q/Mw6ZpzF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kUrFghg6jGfkV6pJcSgRHRjqhwskndGFwcm20KAcg/XmFD/wb5jHUKmPJryF?=
 =?us-ascii?Q?4AVe7Z4U6CES1l8DPB6aDsEJEuAhuHOtArVVuaeby1sps62pJmBuJ29ftlEB?=
 =?us-ascii?Q?oLCHkDXu38EXiVNGGF86eZdXgipw4kqiIKUyl9lNomETDNMRq5MJ7nFof4bf?=
 =?us-ascii?Q?2Kzsa+e4HW59g9/RZWQXnRK8BNRgxVs1xKvZd/PcudHoYh86kT1MEKF70J7Y?=
 =?us-ascii?Q?0KlV9j6fN7sFh3SC6T+lUxLof3MIC/IqI7qSAYQh3bNRynAzn0eiUiYZb3iY?=
 =?us-ascii?Q?gxnR1Rc5eICIxLI0I7S9FjVhHHHj7g5mF0tjs2hV4w+DhLZgLaPHQMDesvVd?=
 =?us-ascii?Q?Hpx/nq26EiHgZaJjcPt3k9rRvp965i7XqGIO4BcsP/3pZpQMCvpzw61WLY/4?=
 =?us-ascii?Q?q21eRjwL3CmnGuhX5wRzsBqDqAv0mqSc7941ijHY6BFqa/CH1yK3XEqdW9Sg?=
 =?us-ascii?Q?CSTeF4LIwH254CfN3x58ohoHZT6BVU+GRafaiiFQo7kuT9DTWrk3rm/1cjuq?=
 =?us-ascii?Q?a5h94GMq/zhdFoiY8mA/Azou+Untgj7GV+uTqeppT26PvJq2vtLy+oji+Ije?=
 =?us-ascii?Q?+1n29Xfho60hHcXG5QzpYATWzzgK1Az6dQmG7k7uvmd6QpwWztbr9jqepSA1?=
 =?us-ascii?Q?zGUL8iKSxqxfz8SgwJZM/a5lwLIsoPfBzhnFcwo0zdOZ8dGRmNxikXobCtiF?=
 =?us-ascii?Q?dmvv0Ef9ZisfAWBWBMnP8oKJvoYM24RwhPFRzfKSaG6jrqKs/jFk87DMdZ7U?=
 =?us-ascii?Q?2+dbT0HAw0mbDbTUQdFbjdRcw38KO3fYMtVZnQFrw9T1PpS7OYvlf0hAn9Qr?=
 =?us-ascii?Q?qRqEzDYG7v93Wtbkclie8lDQdE0uiA5hzFADsiNxjASPLhC9c/6trAskFug6?=
 =?us-ascii?Q?oYt1IfsbqkjeXt/81Ff6GEa9AgK8EPNSRi9UUdUxl8TnR582qjQQiHkF1/vY?=
 =?us-ascii?Q?Kwsp5hFwkPjt8NsmjuJCr7u3jC71rR7hikcoRXH1GJWUilvtuYRv1gEydz/R?=
 =?us-ascii?Q?ALvmytuv0y+ti4JEGxf2/A+HXJ/O7DIOmNIpwCjq4XzQIf4bSvGSjLff2qAD?=
 =?us-ascii?Q?Hq7/IT6Y6JjldMwHp0Wn3cgtatXfIcSKXUDCumUhuCERDXOX1ci2+23mcYJv?=
 =?us-ascii?Q?Jz85cfxut6nY74RcQAdsLXq/49OGJyVP2W+ITKsT8M5iDnoOXtnSTKrd1DUa?=
 =?us-ascii?Q?S8bXY+MYB70eund7mQPC7+kK3FNxjqb2/M69TnpbMxy0o4PmszSoOxcEoGQO?=
 =?us-ascii?Q?axY9YOHQIAAA0+bpUFkqolrK5QoS/KjhqZGyTga5MMoFHvKJUDLdEvVIq/L/?=
 =?us-ascii?Q?fYH4pTSoa3ZlyBF5ZFZwEHLLZg7JwkyV279Z2xrfyYZL3XCd6aTd7KE7khij?=
 =?us-ascii?Q?ABOWwi1QeEUbSu65l/FjEHjhrhb58lLZEqgP92xfimtSja+dhnCnTRmoMK5I?=
 =?us-ascii?Q?VrJVsWmL9rD7qtJsYwvoBznmTRgFP7ZJ7Ge9JQH6s1jA8psJ0s81NYcQ6LTZ?=
 =?us-ascii?Q?3B8TPrZw2YfJhOe+6TT+BR3e2GCqHX2LOVMPyUTeBRgBwwHVzCv8bwcGZJOo?=
 =?us-ascii?Q?8LXHsinzswlMqqo/8EFwpfmB30IRs9ntJLeifZR+3qjmaTjYnagjB1JMljUI?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3rHqat5FPMN5rptxRk7X+yViBh6syMkAqmaxluefJTiMJWh23fBnRilKDsiWF52HdRIhQubLr/IGIpT+OmegVqfdkK3MmD8YyZyz7OeS50CgkqzmLDRTCqridz23UzHhjpOxvXKrw83EBc4maOlmxR+ZeQNfy56+Cp/Gg1A0Wbwz7CDI5aH0EsGgY+jE0qMdw0CkNSjViIA9tyNni/UVaKeFK+3dMvVnJ0cZ0dhEvzMKu+ASxpcT8HNbBCfTYBsXITAM2CXjg6wBhZNg33NgxcAs0qTlSXeYfEKXSVLL2vJAuKlYv1RoIy5y8jqLB6Nh8jNehMZWoWxGNyOLzi+vvxowAZXU0zx9XqNTespnIuPJ3XsEvvpqwVECines/B80Br9EzYBhSR9eXTEFXpDbC0JpyRuU5vUa8dykITujUxnfJtr23LOLMoZcqRGgVeLfAq2dRi36ZVfqKWCMVrkYB6yMSN9R2UOlIfCuSznsKkpwwsaNso2k/5AXhvNI5jFjAaLgJNdFU5r4R/fccpC7AlhzaUQb8+jwOHnzXxdG6xtkC4uUPMSnLqjK88+zooUW9D7h1G+qk9rSpFv/4ITEX+AHfVPwdA2f0QySMA1pfN8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1417cb2a-5b27-4974-0d1c-08de0fd1dac9
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 12:11:53.3128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8AVu9/olgrWoCM8BifcgLd9oyaWJ6T9JZ11MrXgU1IK0PQWmJBp1Hj6XauDMqXcdvYh4MdoxngSC9cz9h9iKtqH54Cr/1sAF2PKpniuFkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510200099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfX+KoeOpSSr23Z
 UHbap+B0A+vfzaIUgQjtvJ9SKpfl89OG82suPRe5h5KXPHGe7IBuw8JMPUWlFZUarBlRzqD98+7
 bL/nQd6DJ9oDLAhqa6iWV0srAS/5cL8xfndRod7D2u7NIwijYzzPQWmPUYNg2HojdXCp3DoGTEX
 McgJhXxeJ4ykBV2DgAg2coVCLI5bRQLkVvhKyr/lzwMveLa5zrivrWl1+QnrrnbFdwXRNm4heyD
 /wsBeKpCtnOL0ZFZD8WfJDIOP9xrJVnTdF/5+xCCPhytZG/JcNAu1rx0lKl21Mg0AM9XTVW3ttk
 1vtBkmQj06he6/+ksSUekoDfryKqpSSm49xOMbveiIy425LO11JPLJMN9ityWp7qkY+bmHUcTc5
 8RkczNi11ZGT1qqqJwYH3TgiUk1Fr21HafGri4oUNbfPLpz8HKI=
X-Proofpoint-GUID: EDSkEw03yV6_6I7J_hmHqp2QbXC4_gil
X-Authority-Analysis: v=2.4 cv=Db8aa/tW c=1 sm=1 tr=0 ts=68f6270e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=AjtsbyE0BD3NTU5drM4A:9 cc=ntf awl=host:13624
X-Proofpoint-ORIG-GUID: EDSkEw03yV6_6I7J_hmHqp2QbXC4_gil

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
 mm/memory.c        | 132 ++++++++++++++++++++++++++++++---------------
 3 files changed, 110 insertions(+), 48 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index b6ff6c640ba1..2b08ab2c42b9 100644
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
 
@@ -3627,10 +3642,9 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 
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
index 26e7901e963f..3bd01028ade9 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1662,4 +1662,8 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
 int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
+void remap_pfn_range_prepare(struct vm_area_desc *desc, unsigned long pfn);
+int remap_pfn_range_complete(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t pgprot);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/memory.c b/mm/memory.c
index f4233c2539f1..19615bcf234f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2899,6 +2899,25 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
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
@@ -2911,31 +2930,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
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
@@ -2956,7 +2951,7 @@ static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long ad
  * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
  * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+static int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
@@ -3001,23 +2996,9 @@ void pfnmap_track_ctx_release(struct kref *ref)
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
@@ -3053,15 +3034,78 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
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


