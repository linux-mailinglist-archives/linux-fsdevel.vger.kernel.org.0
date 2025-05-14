Return-Path: <linux-fsdevel+bounces-48937-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7CEAB65CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 10:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4508A189E18D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 08:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C67920C02D;
	Wed, 14 May 2025 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LAxlPBgN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="At6JjwAv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6744921B9E4
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 May 2025 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747210945; cv=fail; b=MI45XQTIEODiXK2xHVqEjWQSvjdwZ6WlqzbErcqcjeyeuZGJXPozozTLGg73woUN4x3Oet+zl+Fw/8oo+dTg551U9f1sPH0aVWl/iLxWDaGE8tyXt30biSCeHHZssDfcpDf2bIRUQTwvz24MoXr8f+CoGRb3PFl7o1SXKLJJoE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747210945; c=relaxed/simple;
	bh=F/sExjKEWPf8hsx5SOMtF4x7AhcZHprEESo2AtgF5t0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=t2969qJpS8NQdpLbldWlg44eddgAGDGtWBk1YgxCYVFMSEfir+AfWryreFaHt7H4PVmwozvvCsRkA6YVgj6LDWYrqHmjcVEiNwh6DctGR17QNr6ndZp1/XgxDY85bXcMBBglyCdytPtI8IVUjXd5fFdZiRedrPJ+GZ1drw/UQ3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LAxlPBgN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=At6JjwAv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E0fq7o026818;
	Wed, 14 May 2025 08:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FiZLwCyX/ulkyq1483
	8dVNq+H+rLb3ewOFQbMUkDEuk=; b=LAxlPBgNAuxW7G4xgkU0v6M3CQQgjKnKdz
	vjXWC8YyXhKgXZ3GA4T3lM5Oh6cxniQwpavSGh8zMStvm2uYEaRMdxwaf+A3x/aH
	Ax2cmkj+1wk9RDPeGQFNF4ajX+adV3Lh+CPHst1TzJPcXN8JBT1Voru5p9zR8Sox
	JkjNpEbQsB1led0G87wNFfHL+F8tJJQgPCzY+/TzmptW+CYnF2py2k2SWudWJhHy
	mPZT6MW9G/5yhPbjkK4llDK1GGPAAmIIqjGezk2r7Dnqo17hLSr5Xx8INUH+Obty
	j0EQTRJzN1GnqPo4N375IM5SMfmmzk/DN/uqQBFBN+kHNC4NQ2Uw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbccs235-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:22:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54E75M3S033246;
	Wed, 14 May 2025 08:22:02 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011027.outbound.protection.outlook.com [40.93.12.27])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbs8w6b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:22:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nvkiSzWErJb4E+ewTo9rAlMk9NllVLe0F2TIE4w09FNcCOSxzZ0yeX/uo7evEu1em/RD5mJ8N9tTkSuGZmb1S5wZE8QnkifiwZoYxCq0YSLWak6Ob4p3V8ygDbopJFdLmSK6aV4uqvSz8LY7HElnO6W520hTZ/ag1AduGHyMs6k9a2j1/lQe20ixQjTVQdFeY0a0GHMGdzRr0kiHTuH5L9QFelGojG7FOgNdYeaqChPa+X1KzBLPa/TME0HPd6EIy3qKlUkHQvKLKikpMFnuqNjo16s8yRe3Fz4/Jx3+8UGyXpdIP2h0lAHkNkJrWhuM1XNKvSzGCAyFWEzttmRxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiZLwCyX/ulkyq14838dVNq+H+rLb3ewOFQbMUkDEuk=;
 b=v3XTYItIlsx/GDZN1arR/Gxk2CoDncm+YL7BuESTYMiAdiAwRXBTJDydtC1AxunhfeiCNNGAqB9Nl5SZ2LXKT0TQmgEJpn3qdT8K3Xkcni9dsqW56Abmi/oGIbPIJRZx2ZzWXYW0v27pbGgC5wXPzr7otRqIxvqOeQ4FyCSNm4U2JuhqF8EpaiIAEtlSUst8d9kZiuUzIZmdjkJYjpwHVcvLXCPbJyjA0YXHkP6u7nqo48/1THJ3zADqKY1LK2pEMPcKhC140ZgBb9/4kdYHQMyhuGFkQLHKErbupFPi800gnlFLCnMNytnpgdwnR6oSI1Dz6tJbyFvmZUASpUS4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiZLwCyX/ulkyq14838dVNq+H+rLb3ewOFQbMUkDEuk=;
 b=At6JjwAvX9KqpkgXFU1ww6gYPr/b/8Ie5hXW0cI/twT4WWST2Gj+cdmLjWxK0zKkdgNkDyeGFccYyiIdkYsC8e142zqZU1X7wR0eWwC0MVVg1qmV8vfr2sB0yF3S4u1ybIpm9FTj/UJmE0Y4joWB4W9aW3dd61fonfkNyBJ1IXE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB6661.namprd10.prod.outlook.com (2603:10b6:806:2b8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 08:22:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 08:22:00 +0000
Date: Wed, 14 May 2025 09:21:55 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [linux-next:master] [mm]  54fc2b6358:
 WARNING:at_include/linux/fs.h:#file_has_valid_mmap_hooks
Message-ID: <7577d505-087d-4b8c-8ddd-dc87441e3694@lucifer.local>
References: <202505141434.96ce5e5d-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505141434.96ce5e5d-lkp@intel.com>
X-ClientProxiedBy: LO4P265CA0231.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c0b69c2-2bf3-4728-0af0-08dd92c06649
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vtfRMsZsZNRI/6uKhVtFcwNxm1pfwkctu1iQQVoKqYUBJGf50w3zWGnhpdSD?=
 =?us-ascii?Q?HV66m1rAgtNI63gc6SJ9hdV7kD85/A2TJHjn/gYmuEm8yRBIdjhZazPFhRck?=
 =?us-ascii?Q?SvqpWPreydxSzdc7phoxRY9veeJwblDN0LhYCOmSl1fRQ7imTqGiDzit6O+W?=
 =?us-ascii?Q?3z150NnxJ+SlF6opiSZoi+xeb4h/QSAqmP+RYKNUPdQ+OgygyP+eGj2ySh0N?=
 =?us-ascii?Q?lyD4IITe0vlSs5rPb5BouKBszaJelNW0QWYb0kRr04so+0sQb9VhXoo97Zz4?=
 =?us-ascii?Q?ljkQE/i09IVgTB3pe5nb8RkRyka6ZG4AtRV533bkv8rrsH59M75m/rSx3euy?=
 =?us-ascii?Q?H7gILCMJBO0McYJzjey9MdH5whGQvdOlMXks5SusnF3eGhiu60n9Xc4F/QHs?=
 =?us-ascii?Q?/4WpegzP44olXTE222jdejFXEX0cC6VSsmwQx5t8/4NB60TewnfjJHKnBg71?=
 =?us-ascii?Q?T5QB0pYGk0mZQHvB5i4WVqebXHX7Wyq21Fl4D5ylw7jvwEbD7EzXyZEFS1V2?=
 =?us-ascii?Q?NUUDp9bTe0xw9lJkcTI84NLLZ78mEyW7A/aoOnb9XVU1YIyLqN+DB8FOU1Ka?=
 =?us-ascii?Q?3OKy9z/gjV20L3c+RTgx8p7aD27tTqrXQH8LWJIw5PXSgKUM0T3tiRtWrrcx?=
 =?us-ascii?Q?tu+rjYL0mcwRZ6Tt2jNpJ2x01OSFjyT3JcuPQQvf+W9kbsNJEl+/i7MCFL13?=
 =?us-ascii?Q?GZsL4vN/cMvT1gOA7pYc50hY3PO27petOEr93VsLA8kXc6P37RzCkg68Usbp?=
 =?us-ascii?Q?CytaZUDr3NSzaH8Qb6XDgYr1AbIVvkOYog3dOKd8C1JQussApm0ptEPc6P+q?=
 =?us-ascii?Q?CmgexPm0Ltz4Pg4OXBMuUeVHrgsabxQ+rng9I7RyYzIPh0TzCxJBzX/d4HLj?=
 =?us-ascii?Q?lMflYcNnXOFMzaEeaCHXdSlvfZKlxQXf5tnSzq/FzH2/mAF6Crfk5QpEw5uQ?=
 =?us-ascii?Q?5oDoufu9kAHsLYVdWy35No6So44ZCrZK5LZtvB7Q4dRzbg+OnqxuCp2kekjv?=
 =?us-ascii?Q?ES/pBar6K7NeuI/XnQ2BLihu3t0o4LAhpRSq2Jm3xUj8FXaIw17Xr/xHkqTr?=
 =?us-ascii?Q?C2ixR43FS4/IpsiJz8aGAWVPmYUYD7fdNx++vFTMdAIR8uEKYQ9yGaNE16V1?=
 =?us-ascii?Q?En8jhhyKgQHSQ1Z15VMl9ts/zadUEeZid7AZ2UdrdvtZTmE+90fXPcazjJBI?=
 =?us-ascii?Q?i2/Y7OkPkmyYWwHJDE/J22mAwBIOlqv+ugs3b2p9Z6kFk2Aun9kNHVB1VFdk?=
 =?us-ascii?Q?ItMr3x+pmEVWNMtUDyhizGIP3xP68ZHdxs8QkhD7ZM6CSSBs9ljcZRTEylyK?=
 =?us-ascii?Q?L2EcxR/MjDeZCiMBbvnWJwJbrzmBeYSJi0FBHt61KvO2fKuDzezwwsEVQzrb?=
 =?us-ascii?Q?KuYoJvPXikTUsmaC8yv7kKfB9spo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EC8ylEKerWd/hpovSg5Bz02MhG0setymbnXLa3mFNyv1KNMGNnEm0tDVyjrB?=
 =?us-ascii?Q?QVnj8M6NW88jE216W16ABBxiy2PQ/T2EmmF01qQ+b3oAfWvR6VX08KL+pYVn?=
 =?us-ascii?Q?GM66oFOCQ5Zq9CmYVkSdg8E7JkBs4lnkCS0FnmDNFkDDLCkEqf62BZLWVI+9?=
 =?us-ascii?Q?qQuJbnGyYOwPKmywmCHe1n1WOxtXLzVczSb0W/kzQv3EwpXIJuKDWcUnUact?=
 =?us-ascii?Q?Qdn9bsnpZ0wmzP1SvkRr7dg7MZ71sMUUp61Xyd2ks7wX1Jl13YSUsYetmrv+?=
 =?us-ascii?Q?7r1wRwfXa5KSrhhWMxkZ4KTqAMALW3+hWCOZKZ5V+LCPtU5bE+sdxh7sxmvF?=
 =?us-ascii?Q?ZKxI5fg8fy8J7C+krugRmbwGd1/B41Xmlw0Kf6MHLMYiPekQqsUkGPpKZxzA?=
 =?us-ascii?Q?3EPh8ONtsO57b3x6c+6uHJCQw8TxNVwvX4wk+Wd8Bu/wbFe5y6Ba4OFWG+M6?=
 =?us-ascii?Q?j8v4j8h5bMpSCBYoJJKuK1DbRfnFt13m+tGC6TnJ/dgLdU0eSzinAgO5gYmV?=
 =?us-ascii?Q?PAvmbn6iu0NPNNZSKnoVJP0DzZ+tKKOGrTsb1NV/RzSglWokHKW6QYl1GQOc?=
 =?us-ascii?Q?GUl7tvq/TbmS1QY78OmhQaPKwDTLBEO0Y1Ga/vVb7tevBdJzWgPLefrIocM1?=
 =?us-ascii?Q?ojF04t7jHiTM5cy7+SYE1LduAi6lDRZhUtBWK1sXX5+Ui3X/FhaM426mnY+p?=
 =?us-ascii?Q?MISmqnL9EsaCCjVma89U5XSwAY41Hrv7tF1VRtqGHbQVs0bTSAXCRzDCX2nF?=
 =?us-ascii?Q?GaA1dJeHlV5mX4sBaf50glNys3/2zd+3+jUEhlDwdBSVqRMcGsLYosNRxTfF?=
 =?us-ascii?Q?86zoQiqbUV4ic6wWCGha0VsJZtz8YBYaNbekW2ENQtpu6I4R/FYesedBjYCn?=
 =?us-ascii?Q?1x0PsD5hf4skalTaq/g6Wm2307UsWfiTKmcv5lyVBHELayGPHj6GZ+bHcEtS?=
 =?us-ascii?Q?v9YrC9m1PJQwE6dgKEJdx4MfVOBVJx3dbpIzXpyiBBDPEsBNesE6amkB776+?=
 =?us-ascii?Q?shtAbx7HO/5/s9x6DHSInlA9ai6ihtVxVXtSXrKa5/TeRXmLB9yMCd3suDLj?=
 =?us-ascii?Q?KHr2lEO2EgMLXb0PkBjRMryWL8RD40YhDojC8jPdysySw332zIsZgzuL1pXf?=
 =?us-ascii?Q?pxIaNs8l8PabCvmlhAMckI5pGn+1aXR1g5+kQw97Bh2sCIRNXx0bXABYgljt?=
 =?us-ascii?Q?rOAScH/rxbth9lLoqggXRhZo0EawSPhdaZBFpsjJd/bgj/cDLPfsN3KMjRcQ?=
 =?us-ascii?Q?L7jE9clvsfWALP9eoTgJZ4Mdh5SZKvlpoWLzXSYXAeO8Wc6Ip42ojzuPwtbr?=
 =?us-ascii?Q?SUnJ3OLrBgAZ+ugBhKX2rPpcoL0uG7iqgawV5S6LajjGvznqHvxhRNOTAtdx?=
 =?us-ascii?Q?cjj0ms9fPG2UYKY/ZvK4eOszjLPCOWxD6ULl+q/KuBPYnJ7flPLTi6ULv+KN?=
 =?us-ascii?Q?xOLc3A17MdoDDHSBZBAV2oSmAs5zyxRXIeAzZJhkq7Mu2Lx3EtR982rbZ0kL?=
 =?us-ascii?Q?GKKpQ2bZwnDp71XgMI5A26m5rUwK9peQNiC3SEDyeN6z4F9l64wsrbYAiyUz?=
 =?us-ascii?Q?6EtkTh2+XJn3Fs+gF8vJPdQGZm2YJCGQKRsdOap/5x4m5bDvcpagLUI0khNe?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aWSr+CRp2SiR8pz9z6GsDZq5mw+oztz7BpDAV2hN8t3CunrpF74Q3Nc/Cue+Wgfbdl8QXcN+IYynVmdk0uiz5+o/D/arDMT5YWueXCQWp3wV0M3NxCHmR90xcIun3YCctTsOg72WMT3Zy6vqaM8cSSgiRVz4kIM1825sDp6lsDnLcvrzam/2CaVcBzS0Kwd8wHzqL/mRUoWY5IMn/oDL6WvwfvawKtl6EaB/Pm+i8xWGGwaMloLRRJVdaXR1TvLkDUhvadmHPXItn/UF9VKizAyJXqMVnIClglGhuexXel+E8FR5FqLRaRpTv2zDskswyO0M3f8dgZE3Mks1r9SmneH4SwcPe4FYws/SN3RCEVMlYeLlS80mFPLRfv8/fpy9HP6H5kgfnVgTV8dEVXkhalmQi4KeEnFq7HrozHB94iAdwTQpUijqCA9UZijcYz2YgXjMWWbk4bTm1jjiCxDyxoVzvhY4x+W3mgiqPgsdymHbsiZltIf7qsSYXwBgTnRvEBR28q+34iEhsHU6Cjn/bhHFn8nD3Ajfv/AULBHndrCJHn0Jzg6V64LKeFhW4ZVkA4BxPH4r7vJM6lNE+MgYZPjmvx9zFSLc8zeFStMsKhE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0b69c2-2bf3-4728-0af0-08dd92c06649
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 08:22:00.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uRDfbJ+m4AoAe77gUeWi7dCIP2bTumbljS15wIBI1HBD56QR2Ygj06C76zIvWoP7EvRNhgP1iCfn/OnuMBr8lgpHYDfY5KsBZv8JG4aBzLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6661
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_02,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505140071
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDA3MiBTYWx0ZWRfX9HalPWZ2pSp4 /vqQCVXQwUS3H0GP5gRJJCa9H0bGOkK9KNE4SQEk+YKRk9/hP4DLLQEctW+LOfFJ/NUmeqMaye3 qgdG01X6s556FZhoLxvb4V//uePoYi3bgYHzwDZRRzF5aqoGAWooG93EpxRqesK+5xvRtapryRu
 9fgPhwfCqSTmajPkazW0BkfzVX/D5DVpofF2OH0sKtaMlkNGALzxKrcH/P8rzYVaE+3QZK0KnYt rN+plPjNtJ1voqeKH+DM18qWkKJDCpnx6pkINaxBxfQnpxT2g8MdgCuqLa++zL5DvtbQlWQlwRO Y14yFabHnOFgllCahUlGh2nwaozmQSr/CGo/su0Vxtrtl1zw8LpaWIvLMD+fF5Hbq549oy9RAd7
 5hdefC2x1cyH+MQgCouK471ygC1OwO12P+3Yt6ocaFKjLdyl7iQxiofJl/70oXkPEVlnL8aj
X-Authority-Analysis: v=2.4 cv=Y+b4sgeN c=1 sm=1 tr=0 ts=682452ab b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=i3X5FwGiAAAA:8 a=NEAV23lmAAAA:8 a=vSEQ7V6NwNYNPCrLuXYA:9 a=CjuIK1q_8ugA:10 a=mmqRlSCDY2ywfjPLJ4af:22 cc=ntf awl=host:13185
X-Proofpoint-GUID: fQa8pkXh-o-Vwp8s84H3LOpbLo8tN_-k
X-Proofpoint-ORIG-GUID: fQa8pkXh-o-Vwp8s84H3LOpbLo8tN_-k

On Wed, May 14, 2025 at 03:38:57PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "WARNING:at_include/linux/fs.h:#file_has_valid_mmap_hooks" on:
>
> commit: 54fc2b63585940cce17810a9ef5d273087b0939e ("mm: introduce new .mmap_prepare() file callback")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> [test failed on linux-next/master edef457004774e598fc4c1b7d1d4f0bcd9d0bb30]
>
> in testcase: trinity
> version: trinity-i386-abe9de86-1_20230429
> with following parameters:
>
> 	runtime: 300s
> 	group: group-00
> 	nr_groups: 5
>
>

Thanks for the report.

>
> config: i386-randconfig-141-20250512
> compiler: clang-20
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
> +----------------------------------------------------------+------------+------------+
> |                                                          | 7661dba205 | 54fc2b6358 |
> +----------------------------------------------------------+------------+------------+
> | WARNING:at_include/linux/fs.h:#file_has_valid_mmap_hooks | 0          | 12         |
> | EIP:file_has_valid_mmap_hooks                            | 0          | 12         |
> +----------------------------------------------------------+------------+------------+
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202505141434.96ce5e5d-lkp@intel.com
>
>
> [   81.501132][ T3731] ------------[ cut here ]------------
> [ 81.502015][ T3731] WARNING: CPU: 0 PID: 3731 at include/linux/fs.h:2251 file_has_valid_mmap_hooks (kbuild/obj/consumer/i386-randconfig-141-20250512/include/linux/fs.h:2251 (discriminator 14))

This is:

static inline bool file_has_valid_mmap_hooks(struct file *file)
{
	...
	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare)) <--- here
		return false;

	return true;
}

Called from:
			if (!file_has_valid_mmap_hooks(file))
				return -ENODEV;

So I think probably we should make this NOT a warning, as it seems (it
turns out...) there are legitimate scenarios where this is not specified,
or perhaps a test is explicitly relying on this.

Previously this code was:

			if (!file->f_op->mmap)
				return -ENODEV;

With no warning... so this would get things in line with what was
previously the case.

I will send a patch.

Cheers, Lorenzo

> [   81.503344][ T3731] Modules linked in:
> [   81.503951][ T3731] CPU: 0 UID: 65534 PID: 3731 Comm: trinity-c1 Not tainted 6.15.0-rc5-00294-g54fc2b635859 #1 PREEMPT(lazy)
> [ 81.505454][ T3731] EIP: file_has_valid_mmap_hooks (kbuild/obj/consumer/i386-randconfig-141-20250512/include/linux/fs.h:2251 (discriminator 14))
> [ 81.506235][ T3731] Code: 8b 48 30 8b 90 84 00 00 00 85 c9 0f 95 c0 85 d2 0f 95 c4 20 c4 80 fc 01 74 0c b0 01 09 d1 74 0a 5d 31 c9 31 d2 c3 0f 0b eb 02 <0f> 0b 31 c0 eb f0 90 90 90 90 90 90 90 90 90 90 3e 8d 74 26 00 55
> All code
> ========
>    0:	8b 48 30             	mov    0x30(%rax),%ecx
>    3:	8b 90 84 00 00 00    	mov    0x84(%rax),%edx
>    9:	85 c9                	test   %ecx,%ecx
>    b:	0f 95 c0             	setne  %al
>    e:	85 d2                	test   %edx,%edx
>   10:	0f 95 c4             	setne  %ah
>   13:	20 c4                	and    %al,%ah
>   15:	80 fc 01             	cmp    $0x1,%ah
>   18:	74 0c                	je     0x26
>   1a:	b0 01                	mov    $0x1,%al
>   1c:	09 d1                	or     %edx,%ecx
>   1e:	74 0a                	je     0x2a
>   20:	5d                   	pop    %rbp
>   21:	31 c9                	xor    %ecx,%ecx
>   23:	31 d2                	xor    %edx,%edx
>   25:	c3                   	ret
>   26:	0f 0b                	ud2
>   28:	eb 02                	jmp    0x2c
>   2a:*	0f 0b                	ud2		<-- trapping instruction
>   2c:	31 c0                	xor    %eax,%eax
>   2e:	eb f0                	jmp    0x20
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	90                   	nop
>   33:	90                   	nop
>   34:	90                   	nop
>   35:	90                   	nop
>   36:	90                   	nop
>   37:	90                   	nop
>   38:	90                   	nop
>   39:	90                   	nop
>   3a:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
>   3f:	55                   	push   %rbp
>
> Code starting with the faulting instruction
> ===========================================
>    0:	0f 0b                	ud2
>    2:	31 c0                	xor    %eax,%eax
>    4:	eb f0                	jmp    0xfffffffffffffff6
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	90                   	nop
>    c:	90                   	nop
>    d:	90                   	nop
>    e:	90                   	nop
>    f:	90                   	nop
>   10:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
>   15:	55                   	push   %rbp
> [   81.508815][ T3731] EAX: d1880001 EBX: fffffff3 ECX: 00000000 EDX: 00000000
> [   81.509606][ T3731] ESI: ebd21c00 EDI: 00000001 EBP: ee6fbebc ESP: ee6fbebc
> [   81.510420][ T3731] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 0068 EFLAGS: 00010246
> [   81.511506][ T3731] CR0: 80050033 CR2: 042df000 CR3: 2e7c0000 CR4: 00040690
> [   81.512398][ T3731] Call Trace:
> [ 81.512840][ T3731] do_mmap (kbuild/obj/consumer/i386-randconfig-141-20250512/mm/mmap.c:?)
> [ 81.513390][ T3731] vm_mmap_pgoff (kbuild/obj/consumer/i386-randconfig-141-20250512/mm/util.c:579)
> [ 81.513966][ T3731] __ia32_sys_mmap_pgoff (kbuild/obj/consumer/i386-randconfig-141-20250512/mm/mmap.c:607 (discriminator 256))
> [ 81.514625][ T3731] ia32_sys_call (kbuild/obj/consumer/i386-randconfig-141-20250512/./arch/x86/include/generated/asm/syscalls_32.h:318 (discriminator 201523200))
> [ 81.515267][ T3731] __do_fast_syscall_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/syscall_32.c:?)
> [ 81.515980][ T3731] do_fast_syscall_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/syscall_32.c:331)
> [ 81.516686][ T3731] do_SYSENTER_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/syscall_32.c:369)
> [ 81.517325][ T3731] entry_SYSENTER_32 (kbuild/obj/consumer/i386-randconfig-141-20250512/arch/x86/entry/entry_32.S:836)
> [   81.517972][ T3731] EIP: 0xb7f71539
> [ 81.518452][ T3731] Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 58 b8 77 00 00 00 cd 80 90 90 90
> All code
> ========
>    0:	03 74 b4 01          	add    0x1(%rsp,%rsi,4),%esi
>    4:	10 07                	adc    %al,(%rdi)
>    6:	03 74 b0 01          	add    0x1(%rax,%rsi,4),%esi
>    a:	10 08                	adc    %cl,(%rax)
>    c:	03 74 d8 01          	add    0x1(%rax,%rbx,8),%esi
> 	...
>   20:	00 51 52             	add    %dl,0x52(%rcx)
>   23:*	55                   	push   %rbp		<-- trapping instruction
>   24:	89 e5                	mov    %esp,%ebp
>   26:	0f 34                	sysenter
>   28:	cd 80                	int    $0x80
>   2a:	5d                   	pop    %rbp
>   2b:	5a                   	pop    %rdx
>   2c:	59                   	pop    %rcx
>   2d:	c3                   	ret
>   2e:	90                   	nop
>   2f:	90                   	nop
>   30:	90                   	nop
>   31:	90                   	nop
>   32:	90                   	nop
>   33:	90                   	nop
>   34:	90                   	nop
>   35:	58                   	pop    %rax
>   36:	b8 77 00 00 00       	mov    $0x77,%eax
>   3b:	cd 80                	int    $0x80
>   3d:	90                   	nop
>   3e:	90                   	nop
>   3f:	90                   	nop
>
> Code starting with the faulting instruction
> ===========================================
>    0:	5d                   	pop    %rbp
>    1:	5a                   	pop    %rdx
>    2:	59                   	pop    %rcx
>    3:	c3                   	ret
>    4:	90                   	nop
>    5:	90                   	nop
>    6:	90                   	nop
>    7:	90                   	nop
>    8:	90                   	nop
>    9:	90                   	nop
>    a:	90                   	nop
>    b:	58                   	pop    %rax
>    c:	b8 77 00 00 00       	mov    $0x77,%eax
>   11:	cd 80                	int    $0x80
>   13:	90                   	nop
>   14:	90                   	nop
>   15:	90                   	nop
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250514/202505141434.96ce5e5d-lkp@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

