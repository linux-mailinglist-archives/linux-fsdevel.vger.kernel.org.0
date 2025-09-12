Return-Path: <linux-fsdevel+bounces-61027-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9E2B5496C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D1827B1593
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 10:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43922EBBA6;
	Fri, 12 Sep 2025 10:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bqpqcsir";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kLoRIS49"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15912EBB93;
	Fri, 12 Sep 2025 10:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672119; cv=fail; b=uZ2CjCTH6Fp05NS4ONGkYlFbyhcQNX7iJXhjihMJQ7li12Hb7kbaXLoVkHwZ7dPLuqaA+9bDaEn5+bmYqUzB7M1//jVozjZhHEPI2Hxl0GyaN5H5yGvqjNhYREHOr+OpRAiXMiMPq95cfuleZ5gvaAGnkDDRvMbGlj9+xJZ+QHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672119; c=relaxed/simple;
	bh=leXgaYc2OLtbB88LPNxZsLmQ8IAVz6DvxE08qBUpeJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ir8Mdkam/udGQmcWANefnD5+r/ImJMQoPxyyHs5bVpzn1Gw2rO+1eNXe/53BRtfZxm9KcdvNy6bZgPJvToDtilnCa6oJf5lwdysqfRNExHjPCG9sklVmiaqaNq0WrsuxCfk3qz/4IHeQztzsJ4abIsGisJygJAXslOjLJVf+F5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bqpqcsir; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kLoRIS49; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1uY1u023133;
	Fri, 12 Sep 2025 10:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zdr1hPU6JA/zhG50uc
	+HHu8Adr5bmnNS6oki/jy1LgQ=; b=bqpqcsir5C8inuTClkTyjVBBUvzixm+gYI
	1XJNIdsOfaAzswshiWt9ybo8MJXDyqXUSFQ9m3nWV/K2LS9KS/aIPsWCuMWgvcLW
	c/nRzYtfF+DpyLTA0Db7M5lbTs9JR5aSrTW8AxGWYUEdFqf7mtWdbO55zht/qqSX
	6L5TrnSA6dkQSeLkdqLigE7AryGG8b0InItYgX3RwsACKnBa1gonjbIU/Q01f4r4
	p5l31c60fUYoR7XKJLVB3eDY6A0R9csdqoDP3I1J4SGHxH5GeQreJKQoc1K8rs72
	GIxK89zjwX1M8GmL3HybD00BFh8McKXGglkM3g8k6OsH/2lA4J1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921pefyg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:14:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CA50ML025951;
	Fri, 12 Sep 2025 10:14:21 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddqg0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 10:14:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6z8mGQFgHLXQytGuzpN49J4jmRC1XZFnEr7obyKzNNFDhW2OTJsX9+FiPZRmfeBXp8lhsXMp7ZtdMo58GyQPVJ7AOyKiwNyL+89rFVBvz7bIOf4wAdCQIdGNeSfKH30CBwGI8zjhkwxeASvKuQsx8Ngrgob75ToPcGiC/wqqEvuGwdBMfSxUmUBG1+YwJKcWLKwkYe8tC0siClIq6FIGTpoqJNU3skgJQWXMt++iPSXjSrbbgwT+EP9cgZb9n5TvoxxbZAPFlmik+U8J0fsxkAHxbm/Uz1IkSE3SZYr43/JYC/99j+KDhlK/OW55qBtfqzw7VLi5w20WOsQ/Q61Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdr1hPU6JA/zhG50uc+HHu8Adr5bmnNS6oki/jy1LgQ=;
 b=bMGBSeCpQ/r6tSVaUN7cjW4ri3ak0+y5VpXjA3uQ6BH8ihpLTn2LI3S1ymMBks+h+uDr/uvGVDJ9BqlREHE0SSQGVzY7MgcCYHCDgOa2QfnaAFEL3Rzg500LBdvvRbnqkgelbIo55DbJqUO1zsrxPx9t36syY1p43u61nyso4wsP6oJdzB2NnyrbAo6VWDi86xlZBJif93WfdPC8oCRn2BmQgKGr2HdO91KjdyDS9ZpKpmyMlAJzcjSEAEaICMJmjLXoLihxREjAKmi/mrL/thZhT5EBrCPYR8lYoILrg+XeIdurBReEe5M20xOsfvkdz4NRVmEMSKqvecMVUJhGMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdr1hPU6JA/zhG50uc+HHu8Adr5bmnNS6oki/jy1LgQ=;
 b=kLoRIS49aPOHAHtxp0V8MAD6MrEy2F2qeZ3HW3S38x0F0CCY6rQVIbrByFOKT/qRYDoTFHXqoi4gmQxfhMNBL+za/NxY87RfUrwb34zfEOW2QVppZY49Oz5+AHkzs01F65QnBPaUowlR0DvFqXbSjwZBkB/S8d+sQJpLNnMsr8I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB4630.namprd10.prod.outlook.com (2603:10b6:510:33::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:14:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 10:14:18 +0000
Date: Fri, 12 Sep 2025 11:14:16 +0100
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
Subject: Re: [PATCH v2 15/16] fs/proc: update vmcore to use .proc_mmap_prepare
Message-ID: <26d584a9-86da-4286-b980-d45ecf6321d4@lucifer.local>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <163fba3d7ec775ec3eb9a13bd641d3255e8ec96c.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163fba3d7ec775ec3eb9a13bd641d3255e8ec96c.1757534913.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB4630:EE_
X-MS-Office365-Filtering-Correlation-Id: 993c8130-a3fb-4d68-9be1-08ddf1e5223a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OHPSzSr/YWz4v8Cuqk2qBw0k9Rg0hM8vnCgwxch4hQex8YgkZ8mvEaJrfBae?=
 =?us-ascii?Q?bgDxcWFIp0wOV3fr8lOwp7CXHF4tZuMGO6Tjob4sutsEQ6fxFLtSYBsFu6Fs?=
 =?us-ascii?Q?ltbTHRkxJ3Xx5e/fvPNOFoK3XOyIWjo8RDZzBjNQlJmYd0YM7AYsZbQYKaTt?=
 =?us-ascii?Q?V3F5KfYkcgbyU20XDSl4NUnAPHXlhZ057jANg84ggbNsrH/kSO6syod1DAvE?=
 =?us-ascii?Q?JCB/VfyVUKXISWxnhbq6O3/3QD1fvFY52cPD4r1sFmAfJqMJBIoJZxuknDtb?=
 =?us-ascii?Q?1D5SNzRZrOGcrLWyZ1xdVLhkA02gxuOIjU0qQ/jzrju45wOHO+y1vReBxGDD?=
 =?us-ascii?Q?fZRkr2U7vmBgkls/Y2T1EOaKJbL2tKyz2j7X6Kd9hMNsrxnlotYJu9CtF670?=
 =?us-ascii?Q?i1PFGU6TPkSSNt4LdpgKCDo45NCeZtvI+i2g7oz3YVFKEPq3tVUBcvnvPS71?=
 =?us-ascii?Q?pgPb6mXLBoTAEeKW4YaJd7gPXxZ8L+2YRvLo0CLMvLD6MwUXPIG1nCkQmHIG?=
 =?us-ascii?Q?9KYzvOKb2b5mvYzPHhtijeadxPV30cEiAJraG96yOgpYviugsaZY1IV0yJDC?=
 =?us-ascii?Q?18LmVPQzB6n95ew8wOFykkxVmQMwwhd0L1foE2cS9lEcCsw0gkbNNSaml0Xq?=
 =?us-ascii?Q?yo//IM0RskXFypBZQHUZT46MEp/r8D6eRIs7BQY/P2VSASaFd6MPmEaLOqSu?=
 =?us-ascii?Q?Po5v5U9pEeeB2ze2RwVhnlNRxH7dn0KjGKjmr/Zv+jz6vVj6229W7P3zOaQ5?=
 =?us-ascii?Q?wnl2Ve4wf87juBK2q5S8PgZeJIDhYfN6GWNXtokfwgnmGJR9I6QP2WJEzXoQ?=
 =?us-ascii?Q?o5t+wG96K9lV1DFacX9T7kjrjwVGQlyc6UVDRAInuJCfx9PXGCz7OPqhZqhd?=
 =?us-ascii?Q?lDTIcweZmHZv+AKcAESLXNju0gf4Xc5LhdjKBn5ASBAGgCskd1MET/6efFIk?=
 =?us-ascii?Q?9I/cuiLDdh6VghBM4Ksc/panEdlCvHmglfFQAVqBLPuL4oPVDS0TuZvYnldP?=
 =?us-ascii?Q?7viEqBTLNDlf7LgdY+NW/+7jrAqoYKzt6sOvTa/A0UgeIwycGmYzwMpsygzW?=
 =?us-ascii?Q?HvQ5bunr9ewQ83CfJ2ftcuzui8OT2KC0WyTLbTPnfC5ekNkudrIRPQXmRO0o?=
 =?us-ascii?Q?FHNvWPY26kvjWn5N5tuwwWS8JFnMtZdubIySyMqA8M5NesUctl/VoHxUgm+J?=
 =?us-ascii?Q?kuwOy5IFNpYuvlwuxD2WT9O9oV2SYulLeBQJeEwJM5CKk58Y3eF5qBcGLEni?=
 =?us-ascii?Q?akuj+HEMQkYiG+PF/CscZ0tyjkXjMf3PRf0MReiFaw84yRsx02QBxs83K78N?=
 =?us-ascii?Q?yNQQn1VXwLFtG3MwDBu7grQ8nZQ+rM3MkvcSFlXnvwX7jbOcxCAhcsrH0geW?=
 =?us-ascii?Q?bzCPpVUJ6MRVxguDCPNTlyWBkE5VgtJa1B27IfrsAnPKgLh7YE0HGD4WJ0+f?=
 =?us-ascii?Q?+sxRVAGOwAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pctqzPbGODlOr8TocSUmgA5LvHZVLRPHZ/gQwm9v1FdOItIEPWMLN78789+F?=
 =?us-ascii?Q?ML/yqfLKC5XSmWG2GOFWHXcDAH0hpw4W+RcCA03FZamMZWnOcmVQG7kYjA9D?=
 =?us-ascii?Q?Yl1z8+wqXR2cAwbJsE2/fWNLZ5kBzkVoX5TTFeyqLDShGq4aZ+M1Avsk5MpR?=
 =?us-ascii?Q?3JpXUq73tiLqW3rngdx1d+17X/1STp30zOrItg1m5+ac3OKkqUGxn0C1tMfP?=
 =?us-ascii?Q?TKaBEvk8k/46/FTdmHZnokf8xOHNgHg8JaFM/qaRwJxKgSsrSFC1N69GZyO/?=
 =?us-ascii?Q?k56MGv4V7fW2/ZEVtnH5fksBgwqz0bUTkjRP2TDVshJznAXdTrilGP71wN6g?=
 =?us-ascii?Q?cEs58TzOcV41oG/56E3KG43EvfSDU2gpoTT9bOVgQx0v+ORa8E9B60ezMRVU?=
 =?us-ascii?Q?eKFS3/DWa6drrBE0PPj2Y6uZAAppVqjZR9WWYze72rktq3InGoDsYzko4ycK?=
 =?us-ascii?Q?QgW0b2vVM4Kp7969E6IET15Y0gI9YApT3UZmvKH53m2KaaVp93brnVNQVIw4?=
 =?us-ascii?Q?ck2qZtUoRLYVWv8sHmTHqN5BBolss/bxq+l9v/jpZoDUfOvZgSAGtyYMaCXu?=
 =?us-ascii?Q?m4cjm8qjET6uwRQA1bE1FJ/D57aui+5G7C8fdkPcs3+F06bDNgDBUwdWLcaX?=
 =?us-ascii?Q?3bJ6ZcVs3LS/lLt6ugD3vO3zc2BFjEvyrxYB8zF/YGuIpeJj+v06rtbbNCwc?=
 =?us-ascii?Q?PBO+Su0v9O/JTxzMkjSSFfVKd+8pXbH+b/Ltppl3dKvyZTJZDKwYJEd5ZV23?=
 =?us-ascii?Q?JmQIpGYr560KHKo5UOsdvDoVZObX5xe8IcVaWHTHvPA4OBnMbQ9O8TOeJtuy?=
 =?us-ascii?Q?3/3pASrCBqCRxE8s7vhQk+koX16QCkvxhhGpMO6zzYFCOP2Zjp5ivrvCgkMR?=
 =?us-ascii?Q?CGqdJYsU4cFeWCHQ1w6fBVE0iSWtnIIYwy3eaX8H9E0U73PzCujSuIfT6I/K?=
 =?us-ascii?Q?cW6NJXnJOPFjlnl0n/NmmhevbQHRf9y0kprbmatINiU5Dit5iTag8jnLVZTd?=
 =?us-ascii?Q?5tVk1AMuZkrWSTmA7Qhcb2vk+F2hb+Fkej0EkMrBKcOsEsjTuVcsj5QAV56v?=
 =?us-ascii?Q?opnz2DWJsUnI9QXMvPKATPIxILe5lPCoRfy2w2Inw07rSl+BZKzrxSk+i1GC?=
 =?us-ascii?Q?VsEcJn9PrJ5v57Aru68bmDH9bFmtY67jXpJ6zQuw1PUSdsJOvFGBB+z3oBSo?=
 =?us-ascii?Q?zlLP7FLMjron+ic5VSy6xAzs8E0Q6uXg9hY0mO1hTzmS1QHT+qEX/PGBvbE3?=
 =?us-ascii?Q?MtrOwjlMTxR4CtN3ej4cFgD5La1JkXjcfsIabk69CibMgMpc4TL/7ahOkmAI?=
 =?us-ascii?Q?Zm371z8odxoxRQ5p4FUVsZrfqYGjvmFNil1pCN5K9lN4qPrh72O8BenrkuW8?=
 =?us-ascii?Q?gVK4XKkT1wZQiDDPsCOgeB5a2g+Ia2+3w+x22fAd5/aGNSgnhPfOGiS8lO8f?=
 =?us-ascii?Q?vnWOJkY9TSCERfnpSQZgfQmHyZRPnjJ3Cko5zoy6k0Pybl5UZVUvpIk3FK4Y?=
 =?us-ascii?Q?HC5q35MoHqBsMnxqoVbkE4h69tZXaZIEc5oOhgRloNRBoC3V7DqSQqTqcgnn?=
 =?us-ascii?Q?J8x3gpedmUMvGzb1Bbbgz97gID3KXLOIk+vMlg7yjV/bvhjbWmNPclk76SqT?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E2LnCv9XrsHH7leTuGZ68v5Wd9SVw6b9gaS0DtbG8HP0dpKK8qyWx0gRiTFEhvtJ3RA5L2vbkDb52/m6M0QIFb7m3fRsH+ztlTBhl/WyMCvOqwFP5tn3q7PXKVIDUoLLWXEWg1tsUKOlcDCUXYMFhRDHATcbkb+Z7TeMwEyOeS8syrYk2N8NbZpVmizFkGaB/2kfMVuemNH3FmzEFSaXOcphXWzZet8aZs6EmfFs+VDT6eTs8NP7t+8Dct/lyQRDg1soR/GmSJxG5LUE4W65H/sdp0AvrqU3nShA28PIw2gjCzpvXEmVXAIt4nNNaFGYjY0tLdrcsGxUEqXbJi8OoMoL2qKPh8GsXRNtHy+GPjNqqXZt28mDlzqkhI+w1thRXKyLn4lIOKtwYm5QhwJ5SfwxoxAKySXhKmXQEw37G9BRwP9ZdtwKD9Ru9XdGjJo+vjpQAM0+nIdCW901a7zQwIJErYi9NIZFFXu2WGXyfkRN9QfM/N480DekI1Hh1y00bnUjkVale/F+zPueB8lYUsnYN+zi7HlNQOQgU6SVoXXm7pZ9vyb42Nn5aD9TcHll85Bq+FYpPDYlso8g7FefM4dXFcTIgjBI/dFePX7PkxU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 993c8130-a3fb-4d68-9be1-08ddf1e5223a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:14:18.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /N0jZubBhh+zDpboBXIXKqyrwmqN8zcDSOrwhTqXudt8itO/TWsCEjy8JnkLi5nCcF24Blx3U9xYD1nFxsN5MiAHs4cGuqA9zEt+TUmAv2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4630
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120096
X-Proofpoint-GUID: TTO9fSkDZzVHAlryTATiZ0uBolnrm7fq
X-Proofpoint-ORIG-GUID: TTO9fSkDZzVHAlryTATiZ0uBolnrm7fq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX5MIg6YepPqx1
 vgokq57DZgdxdO43xoVXbVSXaKEIreFCRdsWNf2KS9+uwJ4PwzOB1zKDQnL9Plcl+02Q1rv4W8L
 Nr7uOzs8GNifVHFQDF8Yqfirmk5WwnrTyVGArszMH7A8eJFfneTb8lIKcQTCK2iYJ93RTQs9oSU
 TKunHwmbz/YzeKm7AGSvfOdwe8LRwgGATJ8P2E1EMMD9VFw+70PQb5vRApy2KIFyY6SKP4//kFD
 lOT4HBk89a/Ar2/8CrYGx7nspZHRthuZOQ+mmGGoVsCwX90Obkm5GBdEaLgzIzpSew7GQjlrH1m
 ltB2GG9iQh1CqQu0I09Ul0a5+lhnr7Kr++PBwWL30/ItlnbbpjzJVMvmY7kUCHXV9FdH460AJdv
 FEQa2VFy+1sRx/nzyEIVwImhbkzbOw==
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c3f27f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=c34yhIT1r7kIJM1nUv8A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614

Hi Andrew,

Can you apply the below fix-patch to address a trivial variable use warning,
thanks!

Cheers, Lorenzo

----8<----
From b9d0c3b39d97309bf572af443e2190bb20f6b976 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 12 Sep 2025 11:12:10 +0100
Subject: [PATCH] vmcore fix

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/vmcore.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index faf811ed9b15..028c8c904cbb 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -592,11 +592,10 @@ static int mmap_prepare_action_vmcore(struct vm_area_struct *vma)
 {
 	struct mmap_action action;
 	size_t size = vma->vm_end - vma->vm_start;
-	u64 start, end, len, tsz;
+	u64 start, len, tsz;
 	struct vmcore_range *m;

 	start = (u64)vma->vm_pgoff << PAGE_SHIFT;
-	end = start + size;
 	len = 0;

 	if (start < elfcorebuf_sz) {
--
2.51.0

