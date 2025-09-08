Return-Path: <linux-fsdevel+bounces-60599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D6B49B08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C77AA5D5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Sep 2025 20:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046352DAFB4;
	Mon,  8 Sep 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Vb+QwcWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tOFnmpKf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976832D97BC;
	Mon,  8 Sep 2025 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757363120; cv=fail; b=DqW7nWvvYKPftGCdtSiJLhheaT/cSP6TGcgetBKXfeyOj+1ckYHVhqnK4vcsX4nPIHEJOGd4P2YyMRxbL2JPBVZV8q++InOZC2bSN2lvvgEoJzw+87kX1qPU5J5RI1FNC8i3oKbyYub6BdMGSozcdWE4tPAWb/HosXS8G/xdd+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757363120; c=relaxed/simple;
	bh=Mtn2IUmbR5Y8sZeEkHZHo/Iv5sxtNEfXJqDRH5Wik1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nEugKyjeIoMgAS6wkS0XNz+1czcNoAB3bgViyr4p+ZgAHK/qn3Mn7aZfiQtM3sWNL7lIPDsLKIHheNqpYaUaLPHV/GokoXxZw45W+o/l6Da/Pp5ULdpUIfVyelpoOah3xGSjxaZ7UIKA5Z0k4UBpEb+bC69TEoftMLe4ezkvHy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Vb+QwcWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tOFnmpKf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588HgDTo027562;
	Mon, 8 Sep 2025 20:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FC2F/m+AlpPRYXYsa2
	wbUbk/FuIWgWu3qTMjuX9d4Tc=; b=Vb+QwcWcrdHTMk6xXgAoccXACsdQYckLZD
	eAAt95GP2UWyVg3mjWKe3+2cxAXlIcXPJbCHWFhpI8f5qKXt8wcMe5rXI/5yKzU3
	iVlbuaMGspOWAo0X24RuJPmtgLQJHvvL9xhBnNpxH7P5tpp18Cwb0hiH6O0aqZU0
	3ObcdHThOU3zpGDA6/wTI+S59jH4xkw5yVm7XpUZZorD9EumzKGiKsV9QnVEefSx
	kRPHjyASWs3W2CUXh/VZu9waPR3H9y6l1l7fT2nqU5VhB5XPxlq5kEC6kCkeusz9
	fOShr5EvRHqtVd1QF596HybJ2LPcwOw4gj9svDqSPoHdjW4JDq3w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1gmyd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 20:24:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 588Irkde033216;
	Mon, 8 Sep 2025 20:24:35 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02on2082.outbound.protection.outlook.com [40.107.96.82])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bd9pjfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Sep 2025 20:24:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HRnKx8YaJ545rMWln12Htz32QB1b65G0Dy5lrv0QlMrDRYNtPCdQ6P40MIBezzIbBLrvtTRi2iPNinvM2jylBpJ0q07CkhYrrs7jrLXCQX+bHugD7yZf2oGWi2sVkQfsHM50i/zz+Or6KeLURPfdwtAD2NOB/Ae6P9/ztKOgnrpmuMZiPDAlQP+EpdXqgfHf+MNFTItLgmVHcpqoS0Iv1bWFP7zJgIKixcMPwODL3s2EsNMESqpNcIARxzMMRI/sCMqA1RDE+2hBek5T+fEGBf1UDEzfXom6yErHJ2+xZXh//dMR++FDphHsyHgyu9JOjRZGfI/FIyxGOUxgsqP5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FC2F/m+AlpPRYXYsa2wbUbk/FuIWgWu3qTMjuX9d4Tc=;
 b=wEpWvK4Ia5xiVXiJDMPkofqZeg6HdQWh/jPf40HTgT+bMTFfRxh0X98s98O93RfVFvPnIBt/lv09eGSkNvWdR49NaM0bMyVmoiOvgRSbEDwTFbssXcxWGpQHtREahQ4Sa6SCA7ekXC4B5tH/mmABPgI+r8eCg5dsLloi257fdeJmEWXAqTXrNxhb1vtd2necNcdOY2rZhETNONPP1joLS+4S5tzfnsCNNxYI+bILUz+q6aCfFipDVQzNPoNmrteFKxMH7lluoP0JSY3aHtsrklyBOmPbolIFVri+8Uktw466XClV+1way0PAgQQS2cxAxwoaTsmq9GBMGHKgyly4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FC2F/m+AlpPRYXYsa2wbUbk/FuIWgWu3qTMjuX9d4Tc=;
 b=tOFnmpKf+movwqAL33vhI5xEus3kIA/u3C/9hu9eHZdy6oBGPuW9eV6IiWIt3pWkWrVpZ8R2ym/1c0edrC6bJIbQPCflTZuFe4X/Iyb1vhePFisFSfTdutx7AK68jiiXramIekNtKENkdrGoUyBCm9FTu18o2lTgLfKDvfb6wUU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8201.namprd10.prod.outlook.com (2603:10b6:408:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 20:24:32 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Mon, 8 Sep 2025
 20:24:32 +0000
Date: Mon, 8 Sep 2025 21:24:30 +0100
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
Message-ID: <b1a1f4be-8f1c-4fc1-8f60-a5f02836bd12@lucifer.local>
References: <090675bd-cb18-4148-967b-52cca452e07b@lucifer.local>
 <20250908142011.GK616306@nvidia.com>
 <764d413a-43a3-4be2-99c4-616cd8cd3998@lucifer.local>
 <20250908151637.GM616306@nvidia.com>
 <8edb13fc-e58d-4480-8c94-c321da0f4d8e@redhat.com>
 <20250908153342.GA789684@nvidia.com>
 <365c1ec2-cda6-4d94-895c-b2a795101857@redhat.com>
 <3229ac90-943f-4574-a9b8-bd4f5fa6cf03@redhat.com>
 <20250908155652.GE789684@nvidia.com>
 <7b0f5b81-e18c-4629-a715-b5fee722b4aa@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b0f5b81-e18c-4629-a715-b5fee722b4aa@redhat.com>
X-ClientProxiedBy: LO4P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 01d4567a-1c9d-4773-d2a5-08ddef15b83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q0OmDrDqygb281pLKLMD9wBCHIj13cn/ErjS7pBZAf0dyF1Mdh4RuNVS7bIO?=
 =?us-ascii?Q?/igGQY02/j2N0ALCrnaYtOFXUgMwhYzosDkGfQ4jaXf126SApXbEQcvXFfLE?=
 =?us-ascii?Q?GwEt7uWc44EUqrcwgDmOTLY58LnmiFX/e3w/e3yAkgp1a8WPrA5CSpyikNHe?=
 =?us-ascii?Q?dvhPkkedOz4awnmfPGvGBOf1j2pWjHUC+19hu7k5IOgmI8SZLeLzcLjl/6uk?=
 =?us-ascii?Q?QC81KwI1HWPBDdu0xswygfw9HhaoTnxDmTtVv7QDQNItsAjtfeHJ6w1j908Q?=
 =?us-ascii?Q?9yIAaGTapmeCFwFRq4Kfq8/rwQUDnt7A+GfYwRHqEbTxgo3Ko/GuQbmy0WEs?=
 =?us-ascii?Q?uayKv28Ky1/J7eQhzK3ihz73IFcuxBq0VnNY+IUm8eUmru73vsidFGyy/FJq?=
 =?us-ascii?Q?gln61R4JjVw+mrYcWMhv3D7uIhT3N1houki9jpObW/5Jjxz2BjB34KQCZ3gd?=
 =?us-ascii?Q?KT6GlvZUVTVUC/4Wuz14lcLUICn5MVurmtkKbHB1JnjB/2jtIE9o+PluQ0Nl?=
 =?us-ascii?Q?Kx+a5+tHqEYugAMkmwIY88RD2DAWoHWmOK5hxEuxxSZqvbG5JtPsg5PS+uRv?=
 =?us-ascii?Q?UTFQgZhWFfVBjbBpAkwWNsLjzCo6XswEQzKhtwihv33lb5paS7yYyPtsbYyV?=
 =?us-ascii?Q?VFJi5owX7XevtsXvSd/hF6N/ccCHtWEGGborimF4UXPy+/rlyzJ1F67eXJZA?=
 =?us-ascii?Q?C5BO4hGpbUWZALpzKBlIMRi7Y1LbvaO9MT0MkE4vfG4vPrMLCfRlbzm5yiR1?=
 =?us-ascii?Q?NL29MAjZAxzT5Wi3ilS9XcJK7AHIrDPoDQAv8dJvzzU7/bEvEZAiE97zoweH?=
 =?us-ascii?Q?anVm3mMI/DthtLN1vLGmuRX+F456acUo2s4mmfNu+D3oXVStaW8SQ6z2DSog?=
 =?us-ascii?Q?yiG1UU/PgZp5o6txOviEnYiKwcP2TFOKlJaHmRNk7PsdlwIAbzEt0u/Bpb7k?=
 =?us-ascii?Q?XPdsNPicVfaR22mmwf0iBvGggc6TzEoG1YhxVBbTiXZN3DHr3YBoJFB+QZF2?=
 =?us-ascii?Q?bUDz0JfzBABbicIIe2fESqyrGuza/vWJ6XpbJdDfSKN8ixxOXdKriypIS2hU?=
 =?us-ascii?Q?KV06G2YJKPzUu3sKGfZt7riqSQ2NNHzDVRiVAGpa0XsN+laUDWPeogpM5n5d?=
 =?us-ascii?Q?ShDcbt16qoFcf4JszH2Wr6gyX8alfAClEMEzz2BAruFd7jcmUEuKyXfVyJCx?=
 =?us-ascii?Q?2OrcDPIw+Ffv6UhPKysHxVGZ4UftxJA6+j+zuphgeud9DsVwMnIi1GztpZHE?=
 =?us-ascii?Q?T1gT+KNC3wGlBVefZwMhulAl3JZHSay5d1cksW+DuaCnLJyeNtMmjK6fuu3v?=
 =?us-ascii?Q?4wUxwMIremuItWhf9qYrhtTqDBPByMYNdNNyhVYwUBvJCzdmsaT7tkFpD90t?=
 =?us-ascii?Q?oVCu5y3a5XLhNxCN9eN3v+YAB4QA3KDmdkYsvBYxeTSl+QIy54hzzjqEdq0B?=
 =?us-ascii?Q?e8+lDPSNdwU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zb1Vr9Qr5y4LFWNgx0RyTfR7vaGJe2o5t6FlO/pLcWFwgMSEnEFeF3a/K2r5?=
 =?us-ascii?Q?pKOGM46pirvQv5V8CO4YSlxUDEJRAaSiJkN0QYoHp/8Uc2OC2x9xBW50EebW?=
 =?us-ascii?Q?l1xY1LWA1kAA3f/dsmTTkGOhkWiZtZQAknDHQTx2CLjYvJL/t05dOO38xTza?=
 =?us-ascii?Q?A6Jb0Wor7AJO/rAaQDsGLTnx+dXtjq4uB0oxn3Jp5ZNGNPZRJoaNbDgIlDf+?=
 =?us-ascii?Q?HYwfIXRQh9Li0wTNuAlxfhjkClTV3LJMtAsU6ccVH7OySyNny62JfbJ8/T8K?=
 =?us-ascii?Q?dmQNzhYXaE5HBgiLyAYF9ciMX6IiXoHaolYXDeH+rmpvXTdVB7GobyVc2N++?=
 =?us-ascii?Q?BWlNff0Y3C9PZf6HuoQ26scPctN2hgxXMZMkDYEw81QUuLm5KefI7//m65Ks?=
 =?us-ascii?Q?aAmNdPm/1fhLP2qlzjLeNKDXjzp+RZOMZvghS+10Bra1uH2OhmdVbwRR0lzt?=
 =?us-ascii?Q?NKmUGShs2CowhLiXMgIszOkPIY6tYhnX30jcjsRz4G1SnFElA4rCskuqjBDF?=
 =?us-ascii?Q?HAHczud0FudfrVi2ATX2gwxhWbRxZEdC9tGLWmZlkLYIZN09N99UtiCAKLJ9?=
 =?us-ascii?Q?EGxAknoqETySmAMvuREsiQHE7qLvf+W5WDc5dC96i660w6x7B10TYRnrXuyA?=
 =?us-ascii?Q?XdA/zVViLMH1VGd3PO7zX1Ep7jwSwh+GNuV5f95JUV7VqDTRcT7w2btKYv1C?=
 =?us-ascii?Q?6AVTL+GySMFbliMQYNEOuUaJbENWc8eqssakKSpfVRsGEI1ERYhJckU4lT9v?=
 =?us-ascii?Q?8s1SpaIcVEPmUc3q4SZ89eLCGXU35JQn7ElOBcq3dxJZwUEW3wO+0OUWR9su?=
 =?us-ascii?Q?M9BcjyTGjmqi1tSzrCBkekZmQ0fgdqfWmBfheQ0JlJU2m7+rLq8PDTN8utIO?=
 =?us-ascii?Q?VPee8JJcxqvTYrI7ypMsXL6AIcW4BPo/5v+qBn+b7NZxSNwW3UXpCSh7TdUH?=
 =?us-ascii?Q?2FQY6+wCizl2UGXCaeytBeCNzUdSfwsA4e17j3xn6oW/YKc5F6/Dqt3qUH1m?=
 =?us-ascii?Q?MJZ+noNgdWcOnTP/FzW+X36iWjlRPYqlXcpMEZE8jZfC8nUR1neguaDn0tnY?=
 =?us-ascii?Q?IK+Ua7kPbebjiewmczAQM4e2mrfpxv9NXmFCGFVTUqvMiTK6Tk56ncytVXO0?=
 =?us-ascii?Q?qQvAAPrmGEVbGBmCM9eIzHZ28HI21ffKM3hV0Te65402JXLWmf6fkQLiA4WR?=
 =?us-ascii?Q?0YnYNX7SeksVohXF5lorXsb4qxykWNNnIQuawCHujm9BKQSkD9DES4Jr8Efy?=
 =?us-ascii?Q?nlp/TaMt8Urjt2GWifmXOEoZCOglUQWIYpMde8FaNQ57pQ8s2KcS8HiMXdqr?=
 =?us-ascii?Q?9bTYEh921VzWNsbbx4ZPyjLUyB2wKNavu9F3tKYvU/hnrXLtwspWUNBKuNkC?=
 =?us-ascii?Q?o7snNkrp/WRVhRzEkG6U2F+usfl+rLKKdzGnVBwnxYQSUBqGT6wEHykX+4EN?=
 =?us-ascii?Q?SbGmZAkdmOUQD3H/UK50nRLGiPNA0WIc0xVleddYKRnTDkCl9hrYA5gcr/7k?=
 =?us-ascii?Q?neV6HJi4nk4Jx5b8XMSwX7EUC/463ExH7bUXOm+ETBmeMNFcnMfX1wXImT5F?=
 =?us-ascii?Q?Gh4gPajKifzG48PRZ3UUJDQgcggCYNLDFKssyxlEgcPetxrgD+mHYvz9GETc?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ueWZ4Cny9fi7PXsOfcZifA3vj5A7gDoATJeTj6RpY1leuxPrSJXSjz+vvqpK2MuoBVX/zkWoy0IeVaGwTHUEWzMiLVb5aLhwSjH+GwDbrFnQuLo6TwL6B8WvXBqTh13IC92F0SahlI5M4gTyEHSMK/FEJ8c4YAQd4t5SjmcTbT/rCi2DKzsBDa4l/b0hZcr4vQd027XsHsMa4EOguJ94hsyfLpgL3JpS2MLnLMd6jqmr0wkzodv0B0TSXhbAvJzD6MuadUNYGXv4mshB+DyIu9cffaEs8az7QJaV/og4hA3HIKQLe0DMi4RgtA9Erxqvb9gZzZqHrJMBAAH0YQsRw3DPiYNodRxGNrygMR1m42eoKujfJeH0nW1lwjEIg0PnG1YEG+kLluECyUBhsaGcdwzs9X4DGBKqgo0paViYUjqSJtRxUMm9fd5EyQBs+cjww3VhSruayWoMd4n6Chnjqw3n5bTGskM3p/7kUvaqZyKkokE3ckDG5qqAlqS19cPqF4HG7YpV3VYUWO0jfQqNnRYqyiaBcvfSq/zphpWlXcCB55ES/w5Wrpsad9G5RGzcv3kHiokRUyGN759M/c5729baVIbhQBrItVX7Phg+M/Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01d4567a-1c9d-4773-d2a5-08ddef15b83e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 20:24:32.1748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XEP7/3m9ZDNNL0t9c0wudLRR3YxkVvihO8ZZLl2P22Bh/uuaKLi4a79vx82dSkA+h6UzmyjFHJMmxYrVuIHShsuSBguPo/tgsGrgN1/hj5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8201
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 bulkscore=0 mlxlogscore=947 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509080201
X-Proofpoint-ORIG-GUID: MrXTDaRR4a0fUYThPF0QGV2Y15ofTDvu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX/k/YRljf827Y
 IUkTDziokwxP5ZBtkurbauGHcAolns/RYKn1YT4sMUqsJ653WT9/YVqirmCfK6V/6FgJ+uoBpd6
 Ms48M0Ir+6njOBbclGtaVBXyIHaWibiv35Rj4uPdh8pUCDEV0nBhJx5O+7uDPQG1RrhJLQs1ArP
 bKQPL7wwAEOycwR7KdyXzjqRuI29nmarQTzB5Pe96uVRliHwkSwGtBgQQqFULL4YaCP3QTW6sYP
 EM0LqfPiO/s89VG1SiA0qFiAr1BC7WxFr2Oc/TtV0/drL3aUH630g6OVeVlHrbWGvsKWOGix3iF
 4dYbaF42z2YSVXmbo1y3fbQ73w4As8X9vw6Izuks7Ks1jEn00MPpFzzQNl8TJ8rrs3ZwsNDXvsy
 T3zmYgfK
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68bf3b84 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=4VBzR9d_3lDgCFCmRvwA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MrXTDaRR4a0fUYThPF0QGV2Y15ofTDvu

On Mon, Sep 08, 2025 at 07:36:59PM +0200, David Hildenbrand wrote:
> On 08.09.25 17:56, Jason Gunthorpe wrote:
> > On Mon, Sep 08, 2025 at 05:50:18PM +0200, David Hildenbrand wrote:
> >
> > > So in practice there is indeed not a big difference between a private and
> > > cow mapping.
> >
> > Right and most drivers just check SHARED.
> >
> > But if we are being documentative why they check shared is because the
> > driver cannot tolerate COW.
> >
> > I think if someone is cargo culting a diver and sees
> > 'vma_never_cowable' they will have a better understanding of the
> > driver side issues.
> >
> > Driver's don't actually care about private vs shared, except this
> > indirectly implies something about cow.
>
> I recall some corner cases, but yes, most drivers don't clear MAP_MAYWRITE so
> is_cow_mapping() would just rule out what they wanted to rule out (no anon
> pages / cow semantics).
>
> FWIW, I recalled some VM_MAYWRITE magic in memfd, but it's really just for
> !cow mappings, so the following should likely work:

I was invovled in these dark arts :)

Since we gate the check_write_seal() function (which is the one that removes
VM_MAYWRITE) on the mapping being shared, then obviously we can't remove
VM_MAYWRITE in the first place.

The only other way VM_MAYWRITE could be got rid of is if it already a MAP_SHARED
or MAP_SHARED_VALIDATE mapping without write permission, and then it'd fail this
check anyway.

So I think the below patch is fine!

>
> diff --git a/mm/memfd.c b/mm/memfd.c
> index 1de610e9f2ea2..2a3aa26444bbb 100644
> --- a/mm/memfd.c
> +++ b/mm/memfd.c
> @@ -346,14 +346,11 @@ static int check_write_seal(vm_flags_t *vm_flags_ptr)
>         vm_flags_t vm_flags = *vm_flags_ptr;
>         vm_flags_t mask = vm_flags & (VM_SHARED | VM_WRITE);
> -       /* If a private mapping then writability is irrelevant. */
> -       if (!(mask & VM_SHARED))
> +       /* If a CoW mapping then writability is irrelevant. */
> +       if (is_cow_mapping(vm_flags))
>                 return 0;
> -       /*
> -        * New PROT_WRITE and MAP_SHARED mmaps are not allowed when
> -        * write seals are active.
> -        */
> +       /* New PROT_WRITE mappings are not allowed when write-sealed. */
>         if (mask & VM_WRITE)
>                 return -EPERM;

>
>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

