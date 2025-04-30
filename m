Return-Path: <linux-fsdevel+bounces-47757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87288AA552C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 22:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5808D7B4F6A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 19:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0F2116F6;
	Wed, 30 Apr 2025 20:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CyWHi+E3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GOiWvtJw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64B420F07E;
	Wed, 30 Apr 2025 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746043216; cv=fail; b=gD/ZPzPjDMv9rkoBnImqrZCZx4Hd3i1dD1ZBQIFlL+CDL3AfbnK+I0y/ZGFBjjctsSrCh9VvCuyFyEEyOCnqUBJODGHidkApTZ+Zm118QVMY11ydnVTYhSfgifdu4C8K0njzt9qwBP6vc0LpQ38sArQg2q3mgqqx/uBsuVfqdn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746043216; c=relaxed/simple;
	bh=RxJSvcKdd/caP9KRvsAFtZEy3/tNhNjRQ6z2zhqo6m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJjMGvwwlnWneFM047ePqiec0YgdApoasu0QgF4WB+6v9oe5X1outSicDIoyNPtLpWqVmQviICvUPjbqNZJD1LXcvFYVi1I9CFRdS5jQ9H9m1eVW8bl17n8lN7EaS0YgnhKkreZCkiApS+E6FM57UbjH0K/7OHDH6WYOpbdzF2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CyWHi+E3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GOiWvtJw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UHu5sG017293;
	Wed, 30 Apr 2025 19:59:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OmQPY3QSds1O1QJKBLd0uNk+vb+5JphREDqX1bV8D3c=; b=
	CyWHi+E3W8+/oHBnZzQ19jz+lmA26EiF9g+Yq0TCPwbldYyFO0osWyRiPQ4ELdkw
	V+636wwTeSGdb008EBDGFbBRvRjZS8WzpfeoYp77llMOizDn9X2nqa9xygvyO1cQ
	h4ElpOtnmSm4EkcER0arsP3d2Zim1k/l3pmHxZLMQ1TbCYPLaqwxXS50zGWmDmVD
	yx+h8SC2xC4G9+0HXYa88thXzNkyO1/GlIwN4yZUguIqSYJiqUqfU5tMlfjlS7wE
	08lmVW6i2qNwhaD+ohKiJOwhVNWFdRu3EiJ8iKijRyZs79IkXMh6gSXlZfwj8YmZ
	wZAq9X9jRY8USkX5RsrqXQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uma0bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJPCno035547;
	Wed, 30 Apr 2025 19:59:57 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxbj50n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Apr 2025 19:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCjYDFT+J0nBQGQGQmEC/2BFtj1eI43UKWc/fexsf/NNZKEETpwcfoy0QsJ70bHiEqfnUyBd8sMgoTGz94uT/QGjBDCXw2s++lO6TBZGKm/1IGr5/iQdY6ISe/FP/K5jD2EDJhjEBR2sUiVW18p/b9UZHrzjKDiVWN5xxjuoKY8xJxDgRFJ0fheYQpnDz/N9EXcPTa/hh1q1+tPBmWj+Kpm61QGxJb5Uwu8eIoz6ePjajeIwP/Qfi+DfxSe2WFA/j/wQP3KBxi9OrRLIcWwi6nj6wiOw/Hwxjg1YvuzbGiX31W7lLgmrk1bFVUodcuMcdE87JMwros05y5v3dufx2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmQPY3QSds1O1QJKBLd0uNk+vb+5JphREDqX1bV8D3c=;
 b=Acb02+99jwOo7EW/4zqfHYgjg5n0XrrozfY+8Gi6MmTbADon3CQPOZSLQPoE10LDEiGftUJvGIlRgV2PLDbxt5Ezx0csSvFdamgCAe+rARgHPMAJiJh94jsKnQn/cqQiXRNEKtZ3WQ4xv2UEfqrd/VFTKKo+tYQyJ73w7BUVjMuvRtNe0e2py4MS6wKyZ9oSjUx/XGut0T7LG6RJ30aNBODL+P32aJxu2jGeGCL9422RP9atL/4JABUml9jY/FtuiXJEmVm29FzTB4i4FWCtiLBgCjLlxW86wpBftT6AxCEPBEKVJVgk8XVEcX/fa1ozD3g1mFDtWKGnmQWbGn0zyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmQPY3QSds1O1QJKBLd0uNk+vb+5JphREDqX1bV8D3c=;
 b=GOiWvtJwzEZdTGvgnRqC5xpopZbVaEOqYgWKb9OXlAOkf2zp5wOsdLEfL64IfpC4nlIjr9BaNKXFIbqN3Rf15Mp7ilEm3LefefTNAIgfKxh1XwEx/HPo6bxTkrPTavQS3KtNViQpfmZH8Ei+Nfxpg5zAoCQWW+Q8vu6vgsotiwA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 19:59:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.028; Wed, 30 Apr 2025
 19:59:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 1/3] mm: introduce new .mmap_proto() f_op callback
Date: Wed, 30 Apr 2025 20:59:35 +0100
Message-ID: <f1bf4b452cc10281ef831c5e38ce16f09923f8c5.1746040540.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
References: <cover.1746040540.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP123CA0006.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 343a85a9-b761-4588-c7b5-08dd88219327
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YRCD0YV70OeoqG3g20Kpoo9yX3GQgDctAi+/XaRMte2K8HlFLyONVsUUN4zj?=
 =?us-ascii?Q?dZy/XenmW1A7MsLkEv2RJQj6dvZ85BNsIr9Lu25QIEgKOI+UBo1o2CqQTAee?=
 =?us-ascii?Q?/ZQ4NC6xVj6CL/BqJkAq5a6QqTQsyF6R3T2cvgZRB+dfDU+9UpFUlw9vDlCn?=
 =?us-ascii?Q?LvUm+UX77W0uCJGx89tgwjBWtosdB2sJ4eyDOm0NfsSHBMJJZ6PuYxD9n59R?=
 =?us-ascii?Q?x8bszbMgXo4rAg5tMzQJnDBG1qkdfmch+QMuWSrime00cY3AzNcqDo7haca7?=
 =?us-ascii?Q?6r1ldzvpdkVWlvGZnQU7Hy3Cz3OOpF6BkOHf1epvDt/4gVRyDVWkUTqh+uBD?=
 =?us-ascii?Q?SRG0ld/1JtODOSp39OmYlyXMza/bg784n3kVFzp6z5MqdO+K67HmRByU1TED?=
 =?us-ascii?Q?YqOfGPZeAQ0bJXvHGU4m0qFHRY5cu0Kw+gRI6UTvPEs3MMZuUFIkZ4esM0VM?=
 =?us-ascii?Q?5Is3of7aiDQzDc0DIRvGgALV5e+6E+Hqj51guKBe8x1mmEmTHrbg9kfLpM29?=
 =?us-ascii?Q?0mX7Y7dF3cZ6qlxrRCMse24aXJiLPHjztcAzqYbEGE1P8YxyWaXSopMMzReG?=
 =?us-ascii?Q?lBJhCQD4Hz2A6Yc8fvZ+r6FtiIfMEkp9JnZ8Ep9QV+uPcNFRIKkiP8AjV3OD?=
 =?us-ascii?Q?ezfxAiTQqGRU73S5cz5VbPirXAHA55hPSTbWOommix/JyEy+4aL4R45DovS6?=
 =?us-ascii?Q?gFhF5AXUteSDkTXyuE3cxJOlF429XrrOWtBJQEImrhPMMVdGPSRxC/rrH1fC?=
 =?us-ascii?Q?0XRvQavYowqJeSv96+cxBGAv21mfZrWh1dZjZTDr017K+xrX5eFXlOa9bnIj?=
 =?us-ascii?Q?enVux0UnyKoSPGDb5Xjygeop2+Gr3gc+FUWaLjasqqfHOhaPVEZDgCTlXINZ?=
 =?us-ascii?Q?cZ0nUfn94QvLibe47Me5Y+D6OCP4p3hr8whE2scNdff9QNHJiww37l4Ksi6i?=
 =?us-ascii?Q?BktyubCPMHw1JFjzkLqKXnTv/65tA8m8ogO7ak/cy2i4FvkX8qV06X+Pcwpk?=
 =?us-ascii?Q?u4hrHwZCsSTAEpfPrKrQIm0/tKDRGO35PwQxQtQCE9YEypS9Mr+DKCA9Gd5r?=
 =?us-ascii?Q?x9TGaBLpLxBBDQ3bK4hK8X4sNpKoSEeQJUI2xyukQUQ8S2T1AfCG1FPJCWyl?=
 =?us-ascii?Q?JzTH5Ewu82S3E2GX2RKlnko/ATN1D5UTSvQO96wmcd4qXh+qo0HhaZCwjH8x?=
 =?us-ascii?Q?fSaWBtmMv2z+spJdytblPQOTfVEKUhBfdaEPyPyJESnaO9Mgs0InHbnETztb?=
 =?us-ascii?Q?M6b49i5uU8Rl0GEMur5LglrlGuKalDfU72MIulixZIDKfz5d9N+pgCkGg6HV?=
 =?us-ascii?Q?XYu8UufaLn/DLBPil62hKXG0bXYyXmhUVY083rTCvdY1styn7Z6Ged/+xKXS?=
 =?us-ascii?Q?w5EFPRZu4Ct376N7x4o/eB+5WhoE9Bvj85S6/izXGrM1MhLfzw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oF0CRpv8kjcnPKKaewhb1jrohv1QoihTDJ/UHB30o/flfMNEbEsmHDvpKddR?=
 =?us-ascii?Q?BWYYaQreB93NBJGqnluPZJjWks6nAVyuMUnYMc8Zk74wwaCE/uWpYQvf2TlR?=
 =?us-ascii?Q?aGI1Yhkih6ioLh4een0EnvkjYMu2S3A5sOD9esBrZ1E77n/WnAESdU2viQAG?=
 =?us-ascii?Q?VMDgaWKe2wNwE0TeKlgnqu2T95vE3KJhQzEt5REzN7JnCzjQzT3GxoIW49fD?=
 =?us-ascii?Q?Da6vbJd1nq3XbxSxMxxyMdO0UKrrk7mAUWwQIDk/IJJcHf7UhxHKctWciZ6K?=
 =?us-ascii?Q?iBPH3ryqD7ajTRVDNcdg9w1oxrNz7wHL9PlRFrQrrHE8nsX+aYzqdlurxXhE?=
 =?us-ascii?Q?0pkwfyorn4zIx7rozPRWmPMdvDBQ2YZUmrf5uYkWTn54oWDAMbdJ/HULUVB+?=
 =?us-ascii?Q?vg9Xx/xUmHwgtKdspEkQz7b0B256+grYG7D00E5oF7lnZ/vTg++51ejcyzhq?=
 =?us-ascii?Q?jmVK4F0qjtZ3/c/xm2uMa9X0afbkVGJrBLZoFdN1wjUpeDuMWnL52p9MRHMQ?=
 =?us-ascii?Q?wZyssokqAOOse8iJXLU3E2KJMVZA4acZTY2uqE3LwcMybOUiw9P+2mn9CcoW?=
 =?us-ascii?Q?jOr46iilUUZvElgdFt32V511ehNckMRGYYWTRNE3OJfLQ1ONnvTkKjmVdUP5?=
 =?us-ascii?Q?PF8NsNZGh9xsJyjo/xHIsZEohuPun5iWs0Haf9ERxFEglx8O03cjOYgkwqks?=
 =?us-ascii?Q?1vSirOeBmyvX6AjcJbTMx+8k/dtD2c3TXKCVheItzQ3gf+5/BbtFn/ag4dTa?=
 =?us-ascii?Q?ISvfMc55bT4valLozMlX1XmMQxw4mxzcr9LSjmO2axtpxOO1sqRNGt1rbQg9?=
 =?us-ascii?Q?SNOWepCCd+IOyxBfXyqyRUqYPsspkifVZ3ZrC5cR93bhQbjX0ICbO+8+Cwl2?=
 =?us-ascii?Q?wPDAxIKve+lB70BNkJGvuCcH90Sk23Q4z+R2yel8EdiPAo8rJRtNnapu9/4+?=
 =?us-ascii?Q?Q5yU+w1Zluiic0jztZm2TKEienIKrDsrL6mJTKK1J1MXVR19MEJfF9nAERSl?=
 =?us-ascii?Q?oAvDF/6mtr6bmLHlA9ezD/9F9GS+GGa+GhnVYgUg3EcpHd5YWlnSLEDMMpRe?=
 =?us-ascii?Q?sVcDPoDYpOZb5oZQILAB/LGphY4Qinns2HG2K8O5AjWkPg/+RsRGiMDet4AU?=
 =?us-ascii?Q?DFf4up0hkt2/OwSvN9V87CXkLfnElj2gyN2p+tO6uHSvrHX7yBGf2wm6czDL?=
 =?us-ascii?Q?BVjlMTxZcVV2d9de5ayuk+31QR9qLb0mEcJNtjm2qFgr2EiFoXb5o5THkjFu?=
 =?us-ascii?Q?gjBz5xl/FWe0Hku3CO8Mu+GrM/I1ewNziRrFaJKvQ4/byXw9V2JAkeVQEO66?=
 =?us-ascii?Q?1WAsA0uxBM6DLLcExVucn4tXKFOh9rq01veCrtz/4lizIzbunpArpbH4hUoF?=
 =?us-ascii?Q?oXpam1wSG3kXMqjfLjTGWQ3KoasGimTKFjU/OGj78COGC/gLru7GpH+XWq8Y?=
 =?us-ascii?Q?MTOGq0ikmbmnSOhtuep8voi1xjDzfAVXIBovp7fHN+bSWh9Lnx25LL8zeClD?=
 =?us-ascii?Q?WMyudHjeDIFzVscLU3O6nk+uOB+2qRNRRjZCiYHLyd+XC8ErqEA23nfLzNRw?=
 =?us-ascii?Q?vd/Cg5+3xmv6R2zVhCmpVv8yNhKtnmhvDbrBe4yjTyWRswgLXqSZfAuhiUjc?=
 =?us-ascii?Q?5g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ffDbsPueToPO7L69tF6dz7Uwn7GwMUqYt7Bpvxt+Z/Uu4jTPLudyyrHUZce28lmnnAbkqTP0YLbJGmGF7heHFzX/18Nk62etdEwuoCtTU28tNKmaAMhQEziuILGugoNt9RIKrgMSL2ZegZWvdgFS902y14KXeKnzW6gnRX0pjx8J7VEGdYDpPXDwa0KUE6MzypUYCwQAp8gA8Pq2KDGG1V6G45RHP4oCYpOAb2X1I0YyR6DWyG8PLOYs3cgkhnC6VBVJYiuR2rR8lvmrD0CyLLYndOiF6JohNzbr6C0/T9yfnwB812V7XdZiVMLERWmyuMCKEkyOXA8x7uFweGaSZytaX2REq1fjarm+EQtljJI5Bf8Fx/oT1A2GrOMAFGyEmKyemAJD7Yyyob2JUj7O+16qQBpINsS+CZ0HE56iLsXuUQBWnvfmt8Kp5HE2Fxnk8iy9J0abgn0wbtBtLIXNLGJJqeUvvXEsIJTBj8JAaw+o7NnuLomPAqUQx0ANllU+dlVEG1d7Xd5Eto1C8e9H5bAcK81C8450tbVzhm5INE7NbjZ40HvKGsEcqFl0aVtC+LpXVMMQdRyXB1n8jflQTXJYnu3BBjxFpCj1efvux10=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 343a85a9-b761-4588-c7b5-08dd88219327
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:59:54.2601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3Td2nOqpj1yv0TkOlLUyigpI3iv48kih9ROHv9Sbq5JLWI4GmlnidFjuflt5JYgTrqssdeDNQYAnxSFMptV9rXATX/b4YxNoo7M2wYL1xE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504300146
X-Authority-Analysis: v=2.4 cv=dfSA3WXe c=1 sm=1 tr=0 ts=6812813e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=bBcQKemid6v3KLeQvokA:9 cc=ntf awl=host:14638
X-Proofpoint-GUID: IINubwoUxVu6XHYBlLR9X9x27nFkpsKi
X-Proofpoint-ORIG-GUID: IINubwoUxVu6XHYBlLR9X9x27nFkpsKi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NSBTYWx0ZWRfX7cnoU+2CRZCY 3mgdf2MiSg//wgdlDQd5lhGVaqJAZW/S3m8Klzhs/idIogo4W+TYMOwdy2XiaXgAKynqf4VARmY 8ZeVqIBMWm2exsFiHo3s3CN8WL3d2JvN4dIw5Cy64onuVyb2gMLIghkt0Av37T0g9w8tqq95NS9
 JivRxB25vqsnW2XZ0sldP0+n+uNSBEUtdumlsRkDv/fyBEDFc7ZkYZKT129YubpxuzjZJyaA5Np R+ZOXJ9sOoJlDsDCYZAPytTorAxNTREPOI0zgZJEOr4QC1R3QW/puum76UmWVaToomcM7Cm5UYW 79iNjbAZoYtKd+IT7k3FMm4JwzpiucXJg8clGP7qnPQZX8LRkliIYKVAPwvve2xRVewTH11G+da
 7Wi3UH+2VLTYC1NCNN/pvUmOHjTCXG1M1Z9MAogYvfNPG8VvTvMuWUn750Xvj6uoB4oWHY58

Provide a means by which drivers can specify which fields of those
permitted to be changed should be altered to prior to mmap()'ing a
range (which may either result from a merge or from mapping an entirely new
VMA).

Doing so is substantially safer than the existing .mmap() calback which
provides unrestricted access to the part-constructed VMA and permits
drivers and file systems to do 'creative' things which makes it hard to
reason about the state of the VMA after the function returns.

The existing .mmap() callback's freedom has caused a great deal of issues,
especially in error handling, as unwinding the mmap() state has proven to
be non-trivial and caused significant issues in the past, for instance
those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour").

It also necessitates a second attempt at merge once the .mmap() callback
has completed, which has caused issues in the past, is awkward, adds
overhead and is difficult to reason about.

The .mmap_proto() callback eliminates this requirement, as we can update
fields prior to even attempting the first merge. It is safer, as we heavily
restrict what can actually be modified, and being invoked very early in the
mmap() process, error handling can be performed safely with very little
unwinding of state required.

Update vma userland test stubs to account for changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               |  7 +++
 include/linux/mm_types.h         | 24 +++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/vma.c                         | 87 +++++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h | 38 ++++++++++++++
 6 files changed, 158 insertions(+), 3 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..f8ccdf5419fc 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2169,6 +2169,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*mmap_proto)(struct vma_proto *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
@@ -2243,6 +2244,12 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
+/* Does the file have an .mmap() hook? */
+static inline bool file_has_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap || file->f_op->mmap_proto;
+}
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e76bade9ebb1..b21d01efc541 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -763,6 +763,30 @@ struct vma_numab_state {
 	int prev_scan_seq;
 };
 
+/*
+ * Describes a prototype VMA that is about to be mmap()'ed. Drivers may choose
+ * to manipulate non-const fields, which will cause those fields to be updated
+ * in the resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vma_proto {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
diff --git a/mm/memory.c b/mm/memory.c
index 68c1d962d0ad..98a20565825b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
-	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
+	pr_alert("file:%pD fault:%ps mmap:%ps mmap_proto: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
+		 vma->vm_file ? vma->vm_file->f_op->mmap_proto : NULL,
 		 mapping ? mapping->a_ops->read_folio : NULL);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/mm/mmap.c b/mm/mmap.c
index 81dd962a1cfc..411309c7b235 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 				vm_flags &= ~VM_MAYEXEC;
 			}
 
-			if (!file->f_op->mmap)
+			if (!file_has_mmap_hook(file))
 				return -ENODEV;
 			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 				return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index 1f2634b29568..76bd3a67ce0f 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -17,6 +17,11 @@ struct mmap_state {
 	unsigned long pglen;
 	unsigned long flags;
 	struct file *file;
+	pgprot_t page_prot;
+
+	/* User-defined fields, perhaps updated by .mmap_proto(). */
+	const struct vm_operations_struct *vm_ops;
+	void *vm_private_data;
 
 	unsigned long charged;
 	bool retry_merge;
@@ -40,6 +45,7 @@ struct mmap_state {
 		.pglen = PHYS_PFN(len_),				\
 		.flags = flags_,					\
 		.file = file_,						\
+		.page_prot = vm_get_page_prot(flags_),			\
 	}
 
 #define VMG_MMAP_STATE(name, map_, vma_)				\
@@ -2384,7 +2390,17 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	struct vma_iterator *vmi = map->vmi;
 	int error;
 
+	VM_WARN_ON(!file_has_mmap_hook(map->file));
+
 	vma->vm_file = get_file(map->file);
+
+	/*
+	 * The caller might only define .mmap_proto(), in which case we have
+	 * nothing further to do.
+	 */
+	if (!map->file->f_op->mmap)
+		return 0;
+
 	error = mmap_file(vma->vm_file, vma);
 	if (error) {
 		fput(vma->vm_file);
@@ -2441,7 +2457,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
 	vm_flags_init(vma, map->flags);
-	vma->vm_page_prot = vm_get_page_prot(map->flags);
+	vma->vm_page_prot = map->page_prot;
 
 	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
@@ -2528,6 +2544,69 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vma_set_page_prot(vma);
 }
 
+/* Does the driver backing this implement an .mmap_proto() hook? */
+static bool have_mmap_proto_hook(struct mmap_state *map)
+{
+	struct file *file = map->file;
+
+	return file && file->f_op->mmap_proto;
+}
+
+/*
+ * Invoke the f_op->mmap_proto() callback for a file-backed mapping that
+ * specifies it.
+ *
+ * This is called prior to any merge attempt, and updates whitelisted fields
+ * that are permitted to be updated by the caller.
+ *
+ * All but user-defined fields will be pre-populated with original values
+ *
+ * Returns 0 on success, or an error code otherwise.
+ */
+static int call_proto(struct mmap_state *map)
+{
+	int err;
+	const struct file_operations *f_op = map->file->f_op;
+	struct vma_proto proto = {
+		.mm = map->mm,
+		.start = map->addr,
+		.end = map->end,
+
+		.pgoff = map->pgoff,
+		.file = map->file,
+		.flags = map->flags,
+	};
+
+	/* Invoke the hook. */
+	err = f_op->mmap_proto(&proto);
+	if (err)
+		return err;
+
+	/* Update fields permitted to be changed. */
+	map->pgoff = proto.pgoff;
+	map->file = proto.file;
+	map->flags = proto.flags;
+	map->page_prot = proto.page_prot;
+	/* User-defined fields. */
+	map->vm_ops = proto.vm_ops;
+	map->vm_private_data = proto.private_data;
+
+	return 0;
+}
+
+static void set_vma_user_defined_fields(struct vm_area_struct *vma,
+		struct mmap_state *map)
+{
+	/*
+	 * If the .mmap() handler set these, that takes precedent (indicated by
+	 * the vma fields being non-empty).
+	 */
+	if (map->vm_ops && vma->vm_ops == &vma_dummy_vm_ops)
+		vma->vm_ops = map->vm_ops;
+	if (!vma->vm_private_data)
+		vma->vm_private_data = map->vm_private_data;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2537,8 +2616,11 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	int error;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
+	bool have_proto = have_mmap_proto_hook(&map);
 
 	error = __mmap_prepare(&map, uf);
+	if (!error && have_proto)
+		error = call_proto(&map);
 	if (error)
 		goto abort_munmap;
 
@@ -2556,6 +2638,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}
 
+	if (have_proto)
+		set_vma_user_defined_fields(vma, &map);
+
 	/* If flags changed, we might be able to merge, so try again. */
 	if (map.retry_merge) {
 		struct vm_area_struct *merged;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 198abe66de5a..56a49d455949 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -253,8 +253,40 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access */
 };
 
+struct vm_area_struct;
+
+/*
+ * Describes a prototype VMA that is about to be mmap()'ed. Drivers may choose
+ * to manipulate non-const fields, which will cause those fields to be updated
+ * in the resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vma_proto {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
+struct file_operations {
+	int (*mmap)(struct file *, struct vm_area_struct *);
+	int (*mmap_proto)(struct vma_proto *);
+};
+
 struct file {
 	struct address_space	*f_mapping;
+	const struct file_operations	*f_op;
 };
 
 #define VMA_LOCK_OFFSET	0x40000000
@@ -1405,4 +1437,10 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+/* Does the file have an .mmap() hook? */
+static inline bool file_has_mmap_hook(struct file *file)
+{
+	return file->f_op->mmap || file->f_op->mmap_proto;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


