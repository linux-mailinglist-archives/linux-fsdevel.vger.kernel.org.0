Return-Path: <linux-fsdevel+bounces-60509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F4EB48BB2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 13:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B7563BAB5E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 11:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A453054C0;
	Mon,  8 Sep 2025 11:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YJj8F0Da";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FQqqNdy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BD304BCC;
	Mon,  8 Sep 2025 11:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329960; cv=fail; b=LiQRqHNK5F/YDdV9itXYoDaqzUbxZHoFp7wSdR0yMl8j710iEbd9JLR3r/9zMUGr1zShbcVwEAU++PXQ+nXCgA/7hNdTlNw5CX0a/Xu868BOqVaWL0zLzExS2kOhHTMMcna9BQ7/Sg6YFV+HQQEqgUlpIl+vpFoa1gAOoPO3VFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329960; c=relaxed/simple;
	bh=lOOnlkVP+5SjgwSlSEINdbeeE03SrmTb8iJeiepZeK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bKCCX4TnoOAYSrlUYU/+C6mGeepYWwTfaLx1zp7pcK+iI/67ai5T5kADtk2nzXOcgFrVFEqsKL3fvyY4ZYiaFwUODx0bl72NHnjPbBgUQflo8xHtZUyDq3B3TnbpgmFora0X3EqUq7/ioeXxLET+pezv2oGX0LaWFOdpP3+6Do4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YJj8F0Da; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FQqqNdy+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5889ie4P000837;
	Mon, 8 Sep 2025 11:12:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JPxPeBWd5XW/9bcprIBGU2m+T/kb3G1NVDwRoRlwiWU=; b=
	YJj8F0DaHapDAXigcbTGX3iXc1iAOJMRlWQ16zW7n0m79XAZt2shGK2sL21wLIyP
	+tB5DMf/JE1o5UTLkR2KmajJ8EnkEMMfVkkruf7GAYJ/IHcrkiHsNrjqF+eRrPgM
	rFlrCjTRU31pXB3cE3fzV9RtC1zxOX6lUtgCa1/xRyiElgVBkL0LmTP0VdQHaVfO
	H+K/WQitkXR28NndYJ92bwEhPsQ7PNz8DBh850BdAZu9ImZZfhNZefNq956TTPVZ
	5QhRfVMZ+Wm+JQ4naq2K0qrMPlQpH/rBDsw+F0VjbR1lLE/skVEd3smcYbTWxxT5
	w6bcrDmGtsAXnIirw3U8aw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 491vsc04u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588AV27K002883;
	Mon, 8 Sep 2025 11:11:59 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdej0pt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 11:11:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPfYbFKwOSu2OQ01ET23l6P0cuY2WTkfHxPUB/G/kgsm8kTZN3olyksJvOeMJfigVr6qEUSiEEBw9v5us64iIb/k+8lEb8xTgODIdrRmP+Xoxgdau9zEt8coM/bFOvHF1P4c9xb9KflD+xHQJAM73hLrXTitGFUhNcmnoDE0bhYncQeKYZOx3NlYs82x2KUh6VIS6UOMVB4QFOS89bhANhv37+5Xx7wds/0peDVEAZqZb8ow4YwoS1r+M+Em2on68xl6n8gbmmhFGIgI0CQfz9hKtZxRi63f7ZdgMHtpGUmyTSs9HDZPKeQdQsZcnciDbL7um4uYar60g+Fv4bvtpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JPxPeBWd5XW/9bcprIBGU2m+T/kb3G1NVDwRoRlwiWU=;
 b=UUX+meXG6/0WM6oybPWAKdgBuooYQ+J90OJkvib0jdCqu7ZWG3Vu1YepsiFWYqEOYdEEdSpi7+my64kfy+H6ChTiCiuuPnfsdG/NWefDBLf35fKkA+T3UhSa2YW6rilso9Y9mOrIn66hunn1uaRe8zeXvsXhdnCuXWz7sv6z6EhDEP0uJs1gbckzZzqVVmu9NXLiqFSAPJMZ7KxveUSBWnFYp79gAvgZoeG0UHBgGREiRHHMebsw9rRGnDPhCp6SM1deaM0fSrkO7ZG0taj7avECJ/bMXO44cQDxMDrQshBFnlVP7WKhhDOKu4Q3wnprlof/p273rjlRvskgFC/W9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JPxPeBWd5XW/9bcprIBGU2m+T/kb3G1NVDwRoRlwiWU=;
 b=FQqqNdy+q+YMXnyKepQR6ksyVhlClbg7EJn6Y1XZYI4egUaMtvfC+tmnMN3MkrL2wUfgAytAtl9UY0kntxjwJ8GBmd4RtnChctPd9rw/4/uXyQrnIqfydD3dVbTsnDpMWz8VZCC/GO/svWbt0i+rJ9tRZcWxAAcBsl/IhFzC7GU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CY8PR10MB6588.namprd10.prod.outlook.com (2603:10b6:930:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:11:50 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.018; Mon, 8 Sep 2025
 11:11:50 +0000
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
Subject: [PATCH 13/16] mm: update cramfs to use mmap_prepare, mmap_complete
Date: Mon,  8 Sep 2025 12:10:44 +0100
Message-ID: <e2fb74b295b60bcb591aba5cc521cbe1b7901cd3.1757329751.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVX0EPF00014AE6.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::30e) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CY8PR10MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0e2d6c-d9bf-495e-a9e6-08ddeec88260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7hYqVzYwkQW1Fu7g4eCuGn/tAgTIB6ETKMjje/cGAvjTGSn0UiG8ds3PUcec?=
 =?us-ascii?Q?6YLKxH0tsYgeLQEXxTZO2DsOYEwyAZMnTWgmNyp5Y1+AJ3OSUG6z7Sep+cxt?=
 =?us-ascii?Q?aX6W2wTRzJrG3WfXCKZuiCXsp8UKdeMq42nCdKcKPfDQvUQDyQmA7O15vowe?=
 =?us-ascii?Q?+2U39oi52WclyJviiuYN6qavmi9lvkbLCTmRRDt7A7hKXvWkb3g1nvlQqMSv?=
 =?us-ascii?Q?fnnfcmkQipuO6zN5UzOiuIEw3hcPtw79HTywirYUGfQ2/UBOd8pQHndGSfQ3?=
 =?us-ascii?Q?2ZTotKYKm9HGFW+R+AiyQmfNZ4MfC6GMj7w1iuDFFikXchxbZNajp3ujiKsv?=
 =?us-ascii?Q?/drk7swhDJeonNUOrFVrJQH20SJvxc6Fn7+XLreciD7IceTNWN37iau9US6H?=
 =?us-ascii?Q?pJ4U5mufyi9en+u0tQj0XCMgfLoXIerr/c6s9yCEs0Q/nGnU9Pwr5ICBylZU?=
 =?us-ascii?Q?N99VXvut7z2hI0spO92hQJcuuODfON9sMwfT7nNn3ovi/zOPSolqjW4MPPrX?=
 =?us-ascii?Q?s+VhJQwt7YZjUdJgyb7jnae4Ru6vlvOaVwAIChbQJo39AyW1pw03Ki9Egx57?=
 =?us-ascii?Q?WQbl96o6wnwox7VOBVbHF08YJjMDbKOIoFcdHTJvEm3DSkZPPDzfUN7y7dmd?=
 =?us-ascii?Q?SD6+N18qSpyepeeVhg4KC8QOGtON1SOkKGyOGZ2GP97MoaY4YnXUBiq4CySk?=
 =?us-ascii?Q?wfZlyOgFKt8M69ru9C3aMWmvwiYF03nsG5OUDacoxaUXZboYMETlCafjdx0C?=
 =?us-ascii?Q?h3zPxzjDkIENz1LEA+kLgWvfVEoeG7O44z5L4OyHSqQ1V10YkEKwE4F29PFM?=
 =?us-ascii?Q?ngNfL9xb9zU7Xx154h1AlQFolCQIUKXYwdV8yo6HWdPyISxo6pqYAb7TsQx+?=
 =?us-ascii?Q?e55QbFuF8MbQxWWLCN/nuWMCzzuS82867Agx4MFSbv2CcL5Y0onWD4NTDj69?=
 =?us-ascii?Q?XPYAhixe6Yygg2hmj+L7DfAZwSKhGXRVMVcZWGAoLMaBSiH7sZCCfbmrFFpR?=
 =?us-ascii?Q?5o9utFK+FeqYkaCVYNGu44jy//u+scrGVFgOV/33T97ftoz//IirkZoGjInx?=
 =?us-ascii?Q?KCYWl2hPXiJ6W3pxUYaljoz1T9+6MpMid8HOYkLPxblO4jTtj7LF9s7qEC1W?=
 =?us-ascii?Q?i/6TPZw9OFdzekJTuvyIt4EToBOVQnos7b7armxJeu9KvC/cuAB4Efy3SdsU?=
 =?us-ascii?Q?fe702eM9NdkvkR2qaRYF9PInSi+Xu2JtyDUg/5frZ0nDsXvxjw2mBqTDI7W2?=
 =?us-ascii?Q?9Dg224TZj6JLHj4Ix2KJajhG7JPpAoc/Rdt+1/40Yw7rGkRlgYMxFTlY1k4o?=
 =?us-ascii?Q?K+1Fnw3c1KaISeeLONbk/J5q2DpyjNMRHRyHLzTHdeKEQjNm5xYzhl14RAsr?=
 =?us-ascii?Q?3YW4AVX2+zoUf+yxafJIPVZRDJgk6NyM7NnvViLMSI91ev8EWD3dS1+ox+hJ?=
 =?us-ascii?Q?NMRjIBTyaVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rg1xChbgsoNYSkpqMdZR4ZHq9Bs5BL4fll0TWh5ah6u/D6Whh0Ff36CxIuhA?=
 =?us-ascii?Q?GUPXX1w09AdytIEtK/21Mw0MbcfPXkOd69gHcBRbbhn6OSM4PTzxjivrSMQI?=
 =?us-ascii?Q?L5K+z4Nyvw+A1g2Mh8q7t94kfNGxyolfySAH9KgZ6EhNC66zyHykq20YZ4jL?=
 =?us-ascii?Q?j3+F0WJ7EK27QCO4JNpRLZhGx9kWxQvxfb+5dOcvB67yZijuPZy63o/Fz3+E?=
 =?us-ascii?Q?zGG4nIx9BgluvI5jSalSoIC6A9y5rTwb8c1HJ8PHkdEv9XWtqKBwT018Vf8a?=
 =?us-ascii?Q?NHigfQ35ZN/dz4/YTHtivu/Hm2Uf45OXHcsaJr97su8hTTR72smkAv9wQcdK?=
 =?us-ascii?Q?3Pt4eYVnPH/V96Cg7x+MvDRb6qNUWYmOnviuuWYZ7lX3hYxKTCVR1R3EBjtW?=
 =?us-ascii?Q?ghwLm1RAQRd9nMW6WSKJtVO1iUYCvv89hKmsna0sKFvwA2Ge9NKf2exYpmPg?=
 =?us-ascii?Q?5NkTay/Ep+dORsnwx9ylHw5acLIJkns/6O0Dk9WiXzEfSJ9nV5qj99/e3Ubz?=
 =?us-ascii?Q?Ia7g7C4bWtfXpuZ536p5nnqfZMqr8iGHI/TmXz4qQo593gFrxXW4hFKoW0K4?=
 =?us-ascii?Q?r0Dv61jdaYmWo33/JJnPlGHVW5mZZqOpMLGKPOvDPlsnuGAxcXh8ciNW6WmO?=
 =?us-ascii?Q?bCN9fHwuHWUHvXXYrcg4jP/fxfhYhArw7uxiG3xH+gyzcxNRuzFbL+C6N/Ms?=
 =?us-ascii?Q?ZWW2fXDUYBeMXWb5LrK2XRDqrOlYyK3lg1N7vev+/zLecVuEGK04K0GpDwYl?=
 =?us-ascii?Q?5NdjfyF79Dghc7nG4Hw/bLHhLNsWqhhLSuOMmhkXulYab1dFc5RqC0GHU+83?=
 =?us-ascii?Q?xzu9L8uQQg0+2i0Jub6je/DXc8M1c2N+LbBOZd3Cq4ZimHFNGVyQc6/RRlHL?=
 =?us-ascii?Q?8w4CVLubjLF9P7goRwhejEYVrvDQ1zZUwzf3tx+RtXHibLICjjwhw8j7V0qT?=
 =?us-ascii?Q?EVn8wwPn+4DYlT2qmUjPI/XgOEsiFXYMQ1r0QTIOSE1t9C4BpTPDaxjAGVdL?=
 =?us-ascii?Q?OrupTB4t1j4nkAzv5Nd76M9axS0w3RtIqhRP0HG0+562jAQjGTjUYcZ1nWlV?=
 =?us-ascii?Q?vD92mbOCsWKGQQMdp3K6EtTXv9HTWMJFuBtEOX/2y1Jh5lMWJPuHhX9D0+A1?=
 =?us-ascii?Q?onO+HW5uxriM+ez0df8Qwlpb8/YyMo8KFQfvRwaVHD5U4xb5UTo5+jhdE9Ot?=
 =?us-ascii?Q?E+nk2tshDY/4EzlIykAyqmkEQLX3ADgGb6E78ssmivFoGtbK2ayeuwOmPvbE?=
 =?us-ascii?Q?F4ElprKWO+QJAd+luYsFq1qlLp7dGaxooxgtrTpl4V/No02kEQvp36YeCAgt?=
 =?us-ascii?Q?zjYDi4dBCd7z6MlwB8AdRT6+hTdiwUUQV8cXw6Kn6v/VPOMp1KCcU3TGrE9d?=
 =?us-ascii?Q?uGUspaC6+9SdtW6xqCm/b5gnf7dHMzOLnXiSAXTvnbDVdqiJUPhAZfTk1uQL?=
 =?us-ascii?Q?vg04ZF6RunN0I9CfAVmWXwZvMTqJgU6/OKmkoYI83/uXI9q99KFs1tydRDwV?=
 =?us-ascii?Q?+9cHRJoJbGVsk7UDTlWFFNEzHjsEcbSqvVUPMPT/d32L9FUUmtix9GzbzSSD?=
 =?us-ascii?Q?B1HXhu0G4pF9QRgIAyOq7qd1qParsbcFgyIVdMwjMNWzvP4K+AhBXhg1hkDJ?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ABeGlWF6xHtGRVC8mPESV5myPZDIR+3ogZyQwpeBZ8mjpOy3W21WHkirP7QOCmvpAJtiHjvYycExxOouFDCZs6ueEb0Uqw1GkaVWEINr8nT6Q5rKKP5xywl9k2SHB9S3FWI/2yyqI/F2X4J9B3LlOWaQMyDgznEEv8Xxl/G9dnkmoayWaMJiThhilXL/cC5bGDqICqDDzH+YnN7vvDjW/fVlEXidnyyEAz8NGrqJE9e1qWYlCZv/Tw7bdSNlXhcGuv/NC339EVqiXnMJ8vuu/xB7yeUujYsOWu9J0QT5pdT4foBTrovksj8K+kgbbpK9aDQxiltJxi6T3oZSLfKQiK0kkBUCgv5Gl9OZtn9CPJk/DRyGv0rWmxQmaPCNjT92nrK323k2Vnk2BMo4naYHxhZVvSI4mHRQIOLD3OZxc/ib+fOQOI7aV6Qo7EJkJzsnItxbMO4p0tnh4F+1qRuZDmiTGrURIJXC6jwEoPtuSk51Nxc+WCW3sTjq4YJx2rfrB4ePAtfBo5tUqWoZw+1HzeANjfPTlqn+PBqDvzisuydn+nh4FQ3bVYhZUD5pVm9O778PfVsqZwyMs2d6QWHetfnJDFyaFPuk/U/aD3XfUzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0e2d6c-d9bf-495e-a9e6-08ddeec88260
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:11:50.6477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INZeDwcqc+q583ip/JQP+RfjyCL9j26JrgxIVNKdqo6rRTnfscMJkY+K+ZwR6bN563+QAweexju0hf35Fcx2ALOWwdkSgQdSDoiVOrnXZ/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6588
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080113
X-Proofpoint-GUID: jwboypc346e2vPYckrVwE6789gb8XU0B
X-Proofpoint-ORIG-GUID: jwboypc346e2vPYckrVwE6789gb8XU0B
X-Authority-Analysis: v=2.4 cv=JvDxrN4C c=1 sm=1 tr=0 ts=68beb9ff b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=mb0LTnrAWyJ-Fku-QCsA:9 cc=ntf
 awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDA5OSBTYWx0ZWRfXzwpQ7sVeC24p
 abgwCkfa2Dye8w5uJ5v+VS9nKyqDGhKfF97EW/wIFSNqS6MuiMCuSKiMkxsaSeWGlajbiWYizFU
 Gat4MsrC3vXYxh2G8RdRDHkkbU5xOvbr9aiPM5KysOpXJM0datPotuTbUiZO9co0M1tYa9vYVW8
 UOVcwoD6sartzQ1A7jHFtu90es+cOMwN3vj5vI0VAHV9SZ4/cVm1WYXtmjASnLUOqtIcYfJG7r6
 sdvEx+6manxNpJ2T1tS9MT/1oLAEemmfkptC4GfU1yWBDc+CEIEhv6MmyJF17+8PxoYwvd9wozX
 soxzCSA7UaMkBpaISR3KGAkLhfyKZKNDaRysJHxLfzBzaD6+jmnQ0IAB9DwPJdPvX7KKBbas22L
 lpvUE10t7YThK/Ljey1R2j/azB4GHw==

We thread the state through the mmap_context, allowing for both PFN map and
mixed mapped pre-population.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/cramfs/inode.c | 134 +++++++++++++++++++++++++++++++---------------
 1 file changed, 92 insertions(+), 42 deletions(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index b002e9b734f9..11a11213304d 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -59,6 +59,12 @@ static const struct address_space_operations cramfs_aops;
 
 static DEFINE_MUTEX(read_mutex);
 
+/* How should the mapping be completed? */
+enum cramfs_mmap_state {
+	NO_PREPOPULATE,
+	PREPOPULATE_PFNMAP,
+	PREPOPULATE_MIXEDMAP,
+};
 
 /* These macros may change in future, to provide better st_ino semantics. */
 #define OFFSET(x)	((x)->i_ino)
@@ -342,34 +348,89 @@ static bool cramfs_last_page_is_shared(struct inode *inode)
 	return memchr_inv(tail_data, 0, PAGE_SIZE - partial) ? true : false;
 }
 
-static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int cramfs_physmem_mmap_complete(struct file *file, struct vm_area_struct *vma,
+					const void *context)
 {
 	struct inode *inode = file_inode(file);
 	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
-	unsigned int pages, max_pages, offset;
 	unsigned long address, pgoff = vma->vm_pgoff;
-	char *bailout_reason;
-	int ret;
+	unsigned int pages, offset;
+	enum cramfs_mmap_state mmap_state = (enum cramfs_mmap_state)context;
+	int ret = 0;
 
-	ret = generic_file_readonly_mmap(file, vma);
-	if (ret)
-		return ret;
+	if (mmap_state == NO_PREPOPULATE)
+		return 0;
+
+	offset = cramfs_get_block_range(inode, pgoff, &pages);
+	address = sbi->linear_phys_addr + offset;
 
 	/*
 	 * Now try to pre-populate ptes for this vma with a direct
 	 * mapping avoiding memory allocation when possible.
 	 */
 
+	if (mmap_state == PREPOPULATE_PFNMAP) {
+		/*
+		 * The entire vma is mappable. remap_pfn_range() will
+		 * make it distinguishable from a non-direct mapping
+		 * in /proc/<pid>/maps by substituting the file offset
+		 * with the actual physical address.
+		 */
+		ret = remap_pfn_range_complete(vma, vma->vm_start, address >> PAGE_SHIFT,
+				pages * PAGE_SIZE, vma->vm_page_prot);
+	} else {
+		/*
+		 * Let's create a mixed map if we can't map it all.
+		 * The normal paging machinery will take care of the
+		 * unpopulated ptes via cramfs_read_folio().
+		 */
+		int i;
+
+		for (i = 0; i < pages && !ret; i++) {
+			vm_fault_t vmf;
+			unsigned long off = i * PAGE_SIZE;
+
+			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
+					address + off);
+			if (vmf & VM_FAULT_ERROR)
+				ret = vm_fault_to_errno(vmf, 0);
+		}
+	}
+
+	if (!ret)
+		pr_debug("mapped %pD[%lu] at 0x%08lx (%u/%lu pages) "
+			 "to vma 0x%08lx, page_prot 0x%llx\n", file,
+			 pgoff, address, pages, vma_pages(vma), vma->vm_start,
+			 (unsigned long long)pgprot_val(vma->vm_page_prot));
+	return ret;
+}
+
+static int cramfs_physmem_mmap_prepare(struct vm_area_desc *desc)
+{
+	struct file *file = desc->file;
+	struct inode *inode = file_inode(file);
+	struct cramfs_sb_info *sbi = CRAMFS_SB(inode->i_sb);
+	unsigned int pages, max_pages, offset, mapped_pages;
+	unsigned long address, pgoff = desc->pgoff;
+	enum cramfs_mmap_state mmap_state;
+	char *bailout_reason;
+	int ret;
+
+	ret = generic_file_readonly_mmap_prepare(desc);
+	if (ret)
+		return ret;
+
 	/* Could COW work here? */
 	bailout_reason = "vma is writable";
-	if (vma->vm_flags & VM_WRITE)
+	if (desc->vm_flags & VM_WRITE)
 		goto bailout;
 
 	max_pages = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	bailout_reason = "beyond file limit";
 	if (pgoff >= max_pages)
 		goto bailout;
-	pages = min(vma_pages(vma), max_pages - pgoff);
+	mapped_pages = vma_desc_pages(desc);
+	pages = min(mapped_pages, max_pages - pgoff);
 
 	offset = cramfs_get_block_range(inode, pgoff, &pages);
 	bailout_reason = "unsuitable block layout";
@@ -391,41 +452,23 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 		goto bailout;
 	}
 
-	if (pages == vma_pages(vma)) {
-		/*
-		 * The entire vma is mappable. remap_pfn_range() will
-		 * make it distinguishable from a non-direct mapping
-		 * in /proc/<pid>/maps by substituting the file offset
-		 * with the actual physical address.
-		 */
-		ret = remap_pfn_range(vma, vma->vm_start, address >> PAGE_SHIFT,
-				      pages * PAGE_SIZE, vma->vm_page_prot);
+	if (mapped_pages == pages)
+		mmap_state = PREPOPULATE_PFNMAP;
+	else
+		mmap_state = PREPOPULATE_MIXEDMAP;
+	desc->mmap_context = (void *)mmap_state;
+
+	if (mmap_state == PREPOPULATE_PFNMAP) {
+		/* No CoW allowed, so no need to provide PFN. */
+		remap_pfn_range_prepare(desc, 0);
 	} else {
-		/*
-		 * Let's create a mixed map if we can't map it all.
-		 * The normal paging machinery will take care of the
-		 * unpopulated ptes via cramfs_read_folio().
-		 */
-		int i;
-		vm_flags_set(vma, VM_MIXEDMAP);
-		for (i = 0; i < pages && !ret; i++) {
-			vm_fault_t vmf;
-			unsigned long off = i * PAGE_SIZE;
-			vmf = vmf_insert_mixed(vma, vma->vm_start + off,
-					address + off);
-			if (vmf & VM_FAULT_ERROR)
-				ret = vm_fault_to_errno(vmf, 0);
-		}
+		desc->vm_flags |= VM_MIXEDMAP;
 	}
 
-	if (!ret)
-		pr_debug("mapped %pD[%lu] at 0x%08lx (%u/%lu pages) "
-			 "to vma 0x%08lx, page_prot 0x%llx\n", file,
-			 pgoff, address, pages, vma_pages(vma), vma->vm_start,
-			 (unsigned long long)pgprot_val(vma->vm_page_prot));
-	return ret;
+	return 0;
 
 bailout:
+	desc->mmap_context = (void *)NO_PREPOPULATE;
 	pr_debug("%pD[%lu]: direct mmap impossible: %s\n",
 		 file, pgoff, bailout_reason);
 	/* Didn't manage any direct map, but normal paging is still possible */
@@ -434,9 +477,15 @@ static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
 
 #else /* CONFIG_MMU */
 
-static int cramfs_physmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int cramfs_physmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	return is_nommu_shared_mapping(vma->vm_flags) ? 0 : -ENOSYS;
+	return is_nommu_shared_mapping(desc->vm_flags) ? 0 : -ENOSYS;
+}
+
+static int cramfs_physmem_mmap_complete(struct file *file,
+					struct vm_area_struct *vma)
+{
+	return 0;
 }
 
 static unsigned long cramfs_physmem_get_unmapped_area(struct file *file,
@@ -474,7 +523,8 @@ static const struct file_operations cramfs_physmem_fops = {
 	.llseek			= generic_file_llseek,
 	.read_iter		= generic_file_read_iter,
 	.splice_read		= filemap_splice_read,
-	.mmap			= cramfs_physmem_mmap,
+	.mmap_prepare		= cramfs_physmem_mmap_prepare,
+	.mmap_complete		= cramfs_physmem_mmap_complete,
 #ifndef CONFIG_MMU
 	.get_unmapped_area	= cramfs_physmem_get_unmapped_area,
 	.mmap_capabilities	= cramfs_physmem_mmap_capabilities,
-- 
2.51.0


