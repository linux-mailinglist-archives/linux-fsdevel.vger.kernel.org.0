Return-Path: <linux-fsdevel+bounces-52169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1EAAE0068
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F6219E0283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA19626562D;
	Thu, 19 Jun 2025 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H5kK8zTU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xx8zqzTB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD3E200127;
	Thu, 19 Jun 2025 08:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323068; cv=fail; b=QWsrGMi0TYkPC9/1UpsX6FRhwuIcQzkIwEW7GzOPh2P4tTwrLDAqh8aGbDQgS+Qaja/4B3cH69QSTz8kWKx0YY/BqJk37zkxvTsM9dDIoDoFkPz0eGz/Mep7GyzzXATnbOs+Y6lfJYaIDPCJfD+UezZS/9bW4E8MrDz7N+7lp0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323068; c=relaxed/simple;
	bh=sSb9/7SLUHt8MNAwREMc0HtW3o19brWt5WW5Swr6YlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UlEH1UEyOyFTogHnWpSXNiMC9gdxY9BWwKkfrRo708i/OkfsktmBLZMd1U3SwAoOKIxUX4yw7n/XvdxQbm1QxwY4gzz/WS1dQ0MdpOsE/bQuLOYfPdTKECgB2TqBL/+113rhF8lDZSlbNRRHKy7ePPQK+w84rpcQX3cT3Jq2DpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H5kK8zTU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xx8zqzTB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0ftTQ022043;
	Thu, 19 Jun 2025 08:49:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sSb9/7SLUHt8MNAwRE
	Mc0HtW3o19brWt5WW5Swr6YlM=; b=H5kK8zTUkV40MNvyk/WkM9ryuWycKPYpKZ
	qtg6A0ZOjNmeC8ITBJ43yc1hT2EW2nAppoKUCT5u+f9QA+gdQUKvk43YocvvWVj7
	6lTh6d36QBpALdN9XJEc3rR3LJ33vMjFgHxD6UJxr1pYo0Dkk2G9x9KTmlLfPIPi
	4BrKwnD2me0lB/i02RzlZaLvE1jZRJ2u0+G2qoIo+uBnR7yDSPWXDdAAFMEZbVM3
	9VGPjEP/GjcmBLy3Zh9ymYElCDWmnGhS8qbqAeNF/hubNWgxbHYRZXzWDQ0X1DOp
	6d5ai5iAN7Fk7F3jp6ukU2eAVPCrrG7scLZYy1DRykq3kDl+bsLQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47914eshh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 08:49:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55J7A2rt036406;
	Thu, 19 Jun 2025 08:49:09 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04on2049.outbound.protection.outlook.com [40.107.101.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhj63xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 08:49:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4SL42vuatOTTcoDDF0EBEdieaXKqrnGbAHbz2HJYgS6R7kzRFgTPVtq+Zvq4c3nty0sH7dvrgbOZhCJCBylHTBa+9mwGfqW2/f9sIzwPzAFSD8iXHI68mK+6fzBo2wClUlpSe/D2oCgw4u2mUW5vFu+J31K2v7DS5ZfgihRJ42IyQsVCi0xgsv0PEruSITK+MGnUOUw5X8J/vYyolv0q7zuJz88hNhxiMBFK3216p9YDbqSzV0a7PdFXPUGmYMUgzKJaAjT5YpB+tzG+v6+26bE+PtGHlN74uUGheThl+TKeF6VjWptdkOVI+U3MdtGZNOTApNENDkH7AEL4iO45g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSb9/7SLUHt8MNAwREMc0HtW3o19brWt5WW5Swr6YlM=;
 b=VT5e6B+c2V+zrSgn3HnpAOHRa6aAeoObwv8gdSlwX8sTq0TwSYkrc7SNZ/OdpG96z7TKZIVopENK+t9d/jan8znYpOg7QHiScE3gumgvAYyRnZREN7/xXe8RVyd78YZ1QeiRAZ9afUMfU7l0KKDF3qbyNi2cEKbSeOQVtR3H/1jY7fOKHx71pzRx/Dek3b3MfkCqdhZwXA4jewb2uSbJDqAKTT7me6o3YcAZib4lq2Du446FUra5PcyMcZvAUnYAfOz4DGGGT6W+Ra0ifkohO3oGmLPuEUeR5WTksDjfbVnW7MYq30ZW7I49MNhc25m/AFqZJMf2QdGgQuKP/DXmzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSb9/7SLUHt8MNAwREMc0HtW3o19brWt5WW5Swr6YlM=;
 b=xx8zqzTBIl+wp2kx5vFXeGWgyifUMUAhF2HuEIap5/81aA+1GsKExUiL+Kge5u7qZGGwE/UNJDznSJdV3GmaBwmkjEQi7Z/4oVW8t08TbVnjZg0JRFcdmNVMiAHpUJ4ckCm1NqY2V95VVy7yf0oV9+FrUDxAHyA8DNqOtBR5eVI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF3494AF07F.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Thu, 19 Jun
 2025 08:49:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 08:49:05 +0000
Date: Thu, 19 Jun 2025 09:49:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm: change vm_get_page_prot() to accept vm_flags_t
 argument
Message-ID: <a21c59dd-5d2d-4cd2-a04d-63eec059f3c9@lucifer.local>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
 <a12769720a2743f235643b158c4f4f0a9911daf0.1750274467.git.lorenzo.stoakes@oracle.com>
 <20250619-unwiederholbar-addition-6875c99fe08d@brauner>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619-unwiederholbar-addition-6875c99fe08d@brauner>
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF3494AF07F:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ee308ea-9a99-4a15-ab53-08ddaf0e259c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zehwc2hWklCQzHk3RQAr4cV8oebzABNIFrOdgvJ8ppP/W6IcVFk/ywMVFbjy?=
 =?us-ascii?Q?u17U1DSb0ojuwIvIzWylC8cVYRI+dDAcRb205k75pb1tzXOFlR5gXTApdueS?=
 =?us-ascii?Q?6rGsWmtvi01WQyYSvp7FyJbhBcFBrdmhxNRe4aGb/9H0mLMiAmt3iq3VzCQA?=
 =?us-ascii?Q?4jyRkhYJS1pEp9eORttsy/m4RuN5B+H21V/DTIgKy2EUiMQVNRXSerZgeK60?=
 =?us-ascii?Q?j05sgijbZti4E0lBgEAmUBNKo7HrzYwpUZdK1yO5amlTe+RCtICmhSjrCb6y?=
 =?us-ascii?Q?6aKJ4H04hK7jA9u8/hMApYxyFGSm0sQk96gAtzKLaq0e04uppSG3dGygAAH5?=
 =?us-ascii?Q?M+bHE0W+n5O/kRYw/RaelzVAI8FAuJPo1aEkhmGIVJq2NijjnUq9UJBRuFPl?=
 =?us-ascii?Q?08ccfnwOgUEYpUUIshkPF7CxTbVcBlvWcHcU1peuPCxH7CU7M50Q7UHxl7M7?=
 =?us-ascii?Q?srIyZLgoRZ6w05N7lbAw3j5nrDq05o7hQ+nvwKt65GHqaX6g+dQKoeMh6k7n?=
 =?us-ascii?Q?nSf3HRWqLC2D5Fn7Ql7D8gFiyfsN/I6bWJYvy0Dh71Myq1F3HzAihaGmPeAh?=
 =?us-ascii?Q?vNPpuhq9KISuSa9JHaqpKSIlek0PM3LoHzBbKUVN9jhhGaZHnxZIsBaL+/ZK?=
 =?us-ascii?Q?jXL/dzSBQrdBrdYQFfa4CfpxTm123zRHQbRRZ9C7u7X7ExX1r/qLWwDjeZQ8?=
 =?us-ascii?Q?gWShlduJ/qvT6bI9nPsDGea+GY0DDoU24/Vq8XplfUuYE/6TdPzju0saPXrS?=
 =?us-ascii?Q?6wRFTd7t5TPWs1B1bLdJ+vXaY74R7qM8VKD5JjBJxcvT3kPpYorF/Iyk4oGR?=
 =?us-ascii?Q?I0ppmcxpnxjt1p19jWFUF/oGTnD8VVGU0W5dyzbc17Oa95wwRgp1+NcQYOmz?=
 =?us-ascii?Q?YOjNda4P/YSeYwDpugqXDsgqb32qA1w4Ixp8yx4ytIBZ0yvzJVnH6LWmgN3M?=
 =?us-ascii?Q?e6uhhwnCo9HViCU53yKueXLkQUPjMe1hCw8GMFwWZS5Qlw0JSyKsy/Pad1wu?=
 =?us-ascii?Q?+78UgBcE0pksgxNJ/4qSHsi8CyUcD81Mt3xpVlfKLYpHK1KqbOxGoPGpgCYo?=
 =?us-ascii?Q?WbGIsg1a5dHGzTnTdeye+pcqeQAXii/4OctSU9X9f28ZTnvAsOwOdBNlwRRB?=
 =?us-ascii?Q?L/M9k+CZaizo//9FMMC/8pjHnBY7BCWU1tlmNfSeIBnT22P/3pCZC8v0VHU9?=
 =?us-ascii?Q?WNthPNBoqbrYgVOXHdzuzwcK8g+o62pDL8IKtyouS9TYH9JeeelmoLdKYuOO?=
 =?us-ascii?Q?AfDyS1sNlfzSHtOj43z6L6UiGbQLRB9Hq9r9BtikU0XPDzZuOYdOKvogZnJf?=
 =?us-ascii?Q?pM48alhXF9U/de7+t0cBX/zUSTGxmMd/3pCnOhcRWOmwyeuwynbiZk0d7W8Z?=
 =?us-ascii?Q?+MY49ijXnx/0QfY1mXgmiPx4SBne14kDt9dYkt1YPlwXf89iMfKm/0SNTTS7?=
 =?us-ascii?Q?4FMaYWLobic=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVCgDlxha2Y3TrS4K7uyQC0pt9chHgS2sRaZEf53uH431MERtyP9iqaBCeGM?=
 =?us-ascii?Q?xUXSMS/2pr41zGwhSAHY7jtWvXnShyLpeGOHi5OZVriB2LpTuRlOp3WG6w6e?=
 =?us-ascii?Q?hzMCGuTgvMpNwjRmRGEjwi6vwKFlnHQSOECJhKCb20bmtbflLFPLL+jmm2Z4?=
 =?us-ascii?Q?Hjzb+iPNK50Gai2M+xaC0Kl2VFRGDwrtB6OM2ti6108BVsEpZCC2QJ+6LhOp?=
 =?us-ascii?Q?Rk/X/dx2X6ADxz1nYk68t1m5nEjUV+FDOikR3jze2MxmiVLmhkPOWUxMva+o?=
 =?us-ascii?Q?5i3vlYiOBFEakZRa6HPNmkxdTeqynYW/TZj15qEQyQtlpC9EZrO7H5YgUPR+?=
 =?us-ascii?Q?t15eGRoyhkAUwA4YX3ihgNsqbcYqehQwwm2lSzuLge3Ux9gckPYJ3X54Xjwh?=
 =?us-ascii?Q?N66lm1uUpDMfFsZt7TqWvKjUuXS0dhq9057jJ9Mw7iomgd1vLGiBdOxh18rf?=
 =?us-ascii?Q?FUyDMF6XJZZm732Wx9sRt09KrjsTp4WgYnhZJJwtDEi1J6SwwSPUIXFrUbEd?=
 =?us-ascii?Q?MvKSu55htnjqE5gRN9djpp3mW6rx4grzEn5zvLBZg6MopbDcKQCvpdlCYKed?=
 =?us-ascii?Q?4VLOUrkj7AIv7a+MlWc9iMrAQ9K25xo8cmeGTBAq3XZiDt7E4oy+E2UmXdiF?=
 =?us-ascii?Q?Ichfb0qKm9f8G0Rnxs1I7wAjD6OGE9V+7I6r6kyPapIXBTXh54aAsmv/BiUG?=
 =?us-ascii?Q?J2GH/sfAbYf4Bh3wE+/ZDEjM2L4jM/B290u/X6BKeCNCby7A1iNtV4tX2kHY?=
 =?us-ascii?Q?uYqXB9/jbZ/dzpUhb3tHsryzfJ6uerl1ANgXQC2DPDerVxADQUxqxPMASDKq?=
 =?us-ascii?Q?g1Jm9YL9wc8klxEN1Ibh+rq7S+Wff1ZP4bLngZsoC/gVN9T2Yce596YkuDVq?=
 =?us-ascii?Q?0OtfmTKdknbdal4C1Y8QbElxCR3WL+xvbo0/+1qKp8qUoFzFGaDr7Q6ch1Ro?=
 =?us-ascii?Q?FgTrOeXV9E8O+KGgdYoNlyZbSM57llbgTLwz7pqqC2pYCn01LRryU0qLLSLW?=
 =?us-ascii?Q?9FK8WUo+mK0sUkOPH0d7QjQo+kbc0kJxaL+P0vpnhY4XD/5k5yaGUnn+D3Ej?=
 =?us-ascii?Q?k0fFZebC/zrK9dW4qvy8cyWpDNcZBzlp9rMqijYurfehtLKTxQhvhe5qudxv?=
 =?us-ascii?Q?x250Nbdf0vYCtRRIVH4Eeeb1tCFOSLvvs/Jfw5F1F4J/YFU6zLJa5xuJxhLY?=
 =?us-ascii?Q?bDoomNxO9E/fBjTmzMZQrjyas7Sk2cly37vOPmr2tnqDta1VES4mVecguhuY?=
 =?us-ascii?Q?X48vnXM0zgET2Gnp5p0gn+1ZYHTNLqrEJ5msh+cpXrSMeH3Ai/6QMAJcn6QL?=
 =?us-ascii?Q?F/7uiYykMq4wVSukxUnh0pxeZj9aWCzzCF87ScxbfITxudSPljMTDrpEZG5G?=
 =?us-ascii?Q?n3BhCRFqCsKWZ66rd1E6H7hcEDYOqIJlz2aNJ397TvrLk8OqWi2c26IoRXVC?=
 =?us-ascii?Q?Lb2M/JxIoanrWl2xh5IBkr/sTbSanlVzzkXPlUrllnmsk1DIlyXOuuX3hwfh?=
 =?us-ascii?Q?iDANIbgquwRTnt0L2V9J2LCPdTZ/9GnvPi7Pzgde2snaakjkRoVMpys2/jF9?=
 =?us-ascii?Q?wi1VgIg6KnByK6bqbToaQk02NVuSXvWgKh/sXEi6QcJWH05IP6GBI55ZHqJU?=
 =?us-ascii?Q?Lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DdruD3hqqfeqV1eQ0R92B0BrK6kfR55CicmLTcxW00nAt/zKvNsAkU71SzBi8PUWkOs7scglCxNCUhNLm4SH0y0gN6WQJ5SiL0bYeKs9zLjFSshFYrI7OisJ/kdLN50qNTSIGdzQBJ3bcOnuHlyIndKsm2ySzy1EBzPxsj95WfLHg1jDRO5Tbx83JgEJIJCyYG0rDYRm86d5DO6eK16gwzTI2tzGD4pJ0DaGPtmB+JoSCQBFIRiSmAAuIVeRJiOTF+vqICnNa+7bWClhj6Lm5cE4ucGItVShXy/sRRdicWtwsI0Ynzb1wjIaSgJsU47ix3tk2zswFE0qWILqKqTTHJO77EfsgHl2BhCo08SUJl84lhZygqQ5fBBgAaVMgsCkz4vHVB75yY7gxAVvdZrCJxZ1QxCY7HmFaA0yjBCzFdg777YOP584eGQ9GuCT/bbbEp2ZepB8dHIQNdqNT/OqhCjC0rMlEcN4SSQxfCVA4Nhnr4ZzgJC5ZZQB7L40a9Ld1gqHyRII+c4pcG5KKLbSarHsA7YJZ3ou95pYapCAlqwaIMKjOTmmBPYanezTUmDWhANPu7OJSq/zqebsYre54dDa8jx/KTFTJg7RZJ4pZ7g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ee308ea-9a99-4a15-ab53-08ddaf0e259c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 08:49:05.2603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUsBsKA+fLV2JkKLyGog0l2QGqWB1iX0rflZAXn8IgxfGjQT6COw7D0wqwEM93Tu8oKGAik6XC0kTA1BggfRX+Xxx9e8qrLd1gTsuD9fikM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF3494AF07F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_03,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506190073
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA3NCBTYWx0ZWRfX4vk3lqpBa+SE i5ilOo1fir68qV2ZuoR6GLQfTq7sQWy4PnJSXMfIF56GKuqJmqw2LSf+gt4v6PY8xodCi3r5raH YBAaVy+WBcxyT97JUHpwBSZ7fzVGgjSecsQoaxpKp7RAI85QXtWpCcNWLWsU113+bGI4LZLBa/5
 Q2E2QzhH7v/eNHCPuOINPORsIEcc+h55dOAkhCcO/1xKWYqUIVJgSJdKoteXRwZeQJNJWf3alSi 6HiHaYkljckM8IixHcAOxVMVymUEruVyQdiC6ErMDNsqbbOzG406yl2Lak6J+VICpX/aKhsUk8v Z3yZlHmBPthnDGRyIBR8yB18DgVwYSfQeHwgE3GH2+m25fZRZ6r+XhiT06OqRdvNv7uKCazN9Z2
 WI2m0thRCiHl/byQDp3RRb0yAX0UGhflCf6M42In9MRgH8KKEWvSTcGyTmC/AI4uON3tvVal
X-Authority-Analysis: v=2.4 cv=U4CSDfru c=1 sm=1 tr=0 ts=6853cf06 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=k8i7m6ecPFb9PYNpu1wA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: EJMuhmKuJi4-RkWgIJgmZbgUTP2B2UdQ
X-Proofpoint-ORIG-GUID: EJMuhmKuJi4-RkWgIJgmZbgUTP2B2UdQ

On Thu, Jun 19, 2025 at 10:42:14AM +0200, Christian Brauner wrote:
> If you change vm_flags_t to u64 you probably want to compile with some
> of these integer truncation options when you're doing the conversion.
> Because otherwise you risk silently truncating the upper 32bits when
> assigning to a 32bit variable. We've had had a patch series that almost
> introduced a very subtle bug when it tried to add the first flag outside
> the 32bit range in the lookup code a while ago. That series never made
> it but it just popped back into my head when I read your series.

Yeah am very wary of this, it's a real concern. I'm not sure how precisely we
might enable such options but only in this instance? Because presumably we are
intentionally narrowing in probably quite a few places.

Pedro mentioned that there might be compiler options to help so I'm guessing
this is the same thing as to what you're thinking here?

I also considered a sparse flag, Pedro mentioned bitwise, but then I worry that
we'd have to __force in a million places to make that work and it'd be
non-obvious.

Matthew's original concept for this was to simply wrap an array, but that'd
require a complete rework of every single place where we use VMA flags (perhaps
we could mitigate it a _bit_ with a vm_flags_val() helper that grabs a u64?)

Something like this would be safest, but might be a lot of churn even for me ;)

The 'quickest' solution is to use u64 and somehow have a means of telling the
compiler 'error out if anybody narrows this'.

At any rate, I've gone with doing the safest thing _first_ which is to fixup use
of this typedef and neatly deferred all these messy decisions until later :>)

I am likely to fiddle around with the different proposed solutions and find the
most workable.

But I think overall we need _something_ here.

>
> Acked-by: Christian Brauner <brauner@kernel.org>
>

Thanks!

