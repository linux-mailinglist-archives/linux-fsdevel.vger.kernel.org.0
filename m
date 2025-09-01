Return-Path: <linux-fsdevel+bounces-59783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EE9B3E105
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 13:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D32013B3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 11:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B2231281F;
	Mon,  1 Sep 2025 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NHPJyomB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RufdzI1j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63EB311963;
	Mon,  1 Sep 2025 11:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756724772; cv=fail; b=k78HJRy8vcOR/lbwL0a2ruO+faQVGKxPDNYrtd0o0OvqMaGOhQPF62dyscAqjFUd5X7/FBJG+kJftLwWcaxS2w0MV1KjUgxN0zZz/yKMBu1b0efDU5dzdwW1RwwrZSEuTENAxO15mjbllXrYy3jWhprweNdp9FWBC0IBfnka6BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756724772; c=relaxed/simple;
	bh=iqx+kLNe7JgDGXiV3c3JLSc42gz7dQ4fyHEgI3HJGMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gmCrt6y85DONJMoJ8JvsN7X4WQSPVt//kFykBOg7MWCEwK8GmURdZHBDeMfrjbzBP4WYqpWXS8AIsviB5gMSgeWKe8Uz3nU9VT1axlD58pzkM62ZSElLzXayX4CUrXUOoeeiPoQj1W8fXb8EETww9/HRRNmvDJjWCh0TST+NaBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NHPJyomB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RufdzI1j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815gvmn001828;
	Mon, 1 Sep 2025 11:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p/jZXAPr57A7/+iMVuOOjyUpGy9Ccky1QwITkYQfRSg=; b=
	NHPJyomBYj6NmdB2OzRHblSlBJooqOmj4ohtl6niPAOPFvpew1krkAR1js7SfA51
	jTsrm0VO6TF9vpIE485cFteleDcl9/R35wg97mPD+WtaNXev4BmcUQfdHeiFWi/D
	2GbLuTOO3rStm8HRxiw4fkTGa4wILp07YtjJV7BSt//oaOkHT3xGy7p65n42f8iX
	NvZ7nl2kSYFXbTh0o2Y3bP5BsRr4051YyA82uZ9//ABrwTWKdSyk57XqX9WjA8v+
	h9IldAw02KpkMEavBYAt8nokQsapAg0LKXPJgAri+x1BSYriX6pInsbm03MgnPTQ
	epeiYB/akLFcb8K3i4X8DA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmna9jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 11:05:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581ArCnY026754;
	Mon, 1 Sep 2025 11:05:10 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01m9f0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 11:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9YEqy6pXYMRwN9zewshHUIvMpuHcFAywVqGS+Wa/w54edwMUrOPAbZuVVsJi9ud5D7wjlSIjdSgK5/NQA7LV9MS8peGvD3eOi7XQD8DXDUSW26WlfQahiSSrh9DcTfl2S9WT+wv7aGdkFtkid3wpo1520opffDkJIfqTXw7WrHKU1nzAxEBeKop3tEj1nofyPuKfgLRHzvxYQR7tlfe+6lMF2ftqdvOlg0G9jLiz1Ap3dKUF4eEvcBxtlqjvZOKZZ21ApCp9h19SXeGwS2IENC/p5V7YPtGOI8T5EVQls+r8uhzUa0fo+SHL/h9GnQLpq9Fqgbm65wqsHEoecRdOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/jZXAPr57A7/+iMVuOOjyUpGy9Ccky1QwITkYQfRSg=;
 b=I5TbJfIAOgue9FM2YLYh4CqpTlD/TEvko1X/zrm13a6Dkabo+e/+x7RHidPfR0H5wpRh7u5OZGE46LfQeTILHccWEAcG10f7PLvng/vtfkKqkVMBYi2kgMxZjv44j3AXOSPHkB9/gdhHs4LhVrsL69chi+GKgdQnv7qkGmMZC4tzvSTuzNjofCZhlZt8YTSnIMx6kgkbb/w5Hn9jX1lfU+DQpPTrSeo0BXOYZJ+yCnQwpu3O1tURX2YupYDd358hD9KsqB8xUXW73YiS5jPBZDr7qOhfm/akpzgVXbY55Hk9bXvNfgJfVRg/da6gzzeUkkue40K+GVubjwGPoX58Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/jZXAPr57A7/+iMVuOOjyUpGy9Ccky1QwITkYQfRSg=;
 b=RufdzI1jY52o5DaWflNsH4u5HUiw8pKTchdvyheQtEytBL6PzUrvQYyxQJmGnrKMEk71myI+ki5xA3lvaVkCL19yYfqQS32EBqGYTAOBIyBY5pd9RhCCxD+dG2m7Vhiqt1GDs5b0rRF5CVObKcAG00dn8PUq6yQU4CPJGcak7wA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB6775.namprd10.prod.outlook.com (2603:10b6:8:13f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 11:05:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Mon, 1 Sep 2025
 11:05:06 +0000
Date: Mon, 1 Sep 2025 12:05:02 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
        hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
        linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        conduct@kernel.org
Subject: Re: [PATCH v4 00/12] mm: establish const-correctness for pointer
 parameters
Message-ID: <801c5eb7-33dc-448f-8742-256ac40f357e@lucifer.local>
References: <20250901091916.3002082-1-max.kellermann@ionos.com>
 <f065d6ae-c7a7-4b43-9a7d-47b35adf944e@lucifer.local>
 <CAKPOu+9smVnEyiRo=gibtpq7opF80s5XiX=B8+fxEBV7v3-Gyw@mail.gmail.com>
 <76348dd5-3edf-46fc-a531-b577aad1c850@lucifer.local>
 <CAKPOu+-cWED5_KF0BecqxVGKJFWZciJFENxxBSOA+-Ki_4i9zQ@mail.gmail.com>
 <bfe1ae86-981a-4bd5-a96d-2879ef1b3af2@redhat.com>
 <CAKPOu+_jpCE3MuRwKQ7bOhvtNW8XBgV-ZZVd3Qv6J+ULg4GJkw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_jpCE3MuRwKQ7bOhvtNW8XBgV-ZZVd3Qv6J+ULg4GJkw@mail.gmail.com>
X-ClientProxiedBy: MM0P280CA0050.SWEP280.PROD.OUTLOOK.COM (2603:10a6:190:b::9)
 To DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: 81765614-a871-4efd-3a88-08dde947686a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3JSa05NbkEwL3lqeUtrUVdBd3Y5VTlTK0ZNNXhRbmtSVEYvajdQVVpIZ3lI?=
 =?utf-8?B?MWVpOFFZejQvOEhYemRRZ0hsSkd3MUUyYjMvTUo1ZExuRG9jZXlzc3pvQzlB?=
 =?utf-8?B?cDA3djIrVlJwL3FlK1o2QVBMcXV3bDArd0Q3QVlGTHFsWjI1V0I5RGpzVklR?=
 =?utf-8?B?RGw3YU5ncUR1K0x6RE45SWxvSENSYmpvY2tNSXpwN2Z6WXBCaWsrbTNFZjJM?=
 =?utf-8?B?emtVdE5GN281MVpaY2J3ZnFjVmtzOGpSd2RiaDQzZXhGUUcwWFZpRW1ON0Vy?=
 =?utf-8?B?NGxKenlKTkJ1bytwbWNxSm1BRG11YlJvRmtzdyt6bWZ0UVRvZWRraHhHcVNT?=
 =?utf-8?B?c0dyM3dhazBiNFFiRWlsRTBTTVJlUklMVVRJcUQ4eFp5TnBad1JySE9KOHI0?=
 =?utf-8?B?bUtZUDIyYjRPSDY4dDAwa1daeUdPTDhQTUlVUjZSbzk5UzZTSnlkM0FVUDVn?=
 =?utf-8?B?N2lXcWFBMGJDNmJIdnQ5dy9taFFDMFlucEVMWjhsVVpKR0h0UkxEL29UUFRu?=
 =?utf-8?B?MGV6RW5aRGkzR0NWNkV4QUx2QWw3ZWM0S0dDejAyOFYzWDYxZ0lpUVVpN0Ur?=
 =?utf-8?B?aU03dVpJNG1GR0lBS3NDQlBzZXVFNG4yOUpIS1p5VnVSUWhsK3gydmo3ZVlp?=
 =?utf-8?B?RWwrcDVsWHF3QS9XQjZReWVBYkFobGdRYVZYeUtWViszNS9zR1ZFNWpTNVNW?=
 =?utf-8?B?blhlQzdhNk5JckZVajViR3lLQ3Q3OUJqZlNJNmdoaE4xbnVnZDNpNFhBZlk0?=
 =?utf-8?B?SmVRYVVkY3ZTSGJyTXpzaUhna2xTdmI4L004Vkt1aGVoSStSMVhPVGtJM0xV?=
 =?utf-8?B?U00vZElrMDdielltT1p1MEoybXNtTjhENzY3c3EraHZLenJZdWhPejE4cDZh?=
 =?utf-8?B?djZvdnVLRGV4M3R0N1NvZElvTVl0cjRVcnZWQXJzV1VWeTc2cGxGdDFVTVp2?=
 =?utf-8?B?YlYxbWtUYzBYcXg2MEFrZTVBSCsxZ1I3WTNUMnBZYjdTMW5weWF3WGduQWgv?=
 =?utf-8?B?Unl3RDluR1BwRFhCSElaaFNRK09Ea2hiMXdzeEJqSkd2Z2d4RkRUY1lGdDE2?=
 =?utf-8?B?djh3THpOMlVwQWRkaWR0cFpLNVBxdC9VZk5WN2tNNWFBb29tZjhkZmppUW11?=
 =?utf-8?B?bWFncnJ5VmtoNlJGWEtMOUJIM3ZhOFVXV0E0S0xMZUgwcEhLVlM5UCtMci92?=
 =?utf-8?B?Z2lGc2ZYNWRlVWtIejJ4dGJWbEp3K1lhU2F4ZHU1TWZZVlRwb0g1d1h5aks3?=
 =?utf-8?B?MW5iRm96T0xFNkdCSVp6RDZSU202K3A3YTJkL3JsL01Pa2ZURnNBaElSelUw?=
 =?utf-8?B?bGQxaTRGSzlqTzlFQVRvRkVPeEUyS1JrVDRGOEhBb1pxZlI5RHhOZGI5SnlY?=
 =?utf-8?B?MmY1dThEYVdGV1FiVU9wZktTVWdnMjMrUVZ0aGpGNTNZQ0JRVEE0emRGVDNh?=
 =?utf-8?B?aUhRQUFsaHJtbm82Mm9oS1l1bFp0SHNPSGkrY2pSZFlQUjdBcVFlSk9qem5l?=
 =?utf-8?B?dVBnSVBqRVpkMmtGVkIvWXAweEVkTGl4ajJLMnBCWjN4R0tXY1BURk5Nb1E4?=
 =?utf-8?B?cElqZEhySjRTN2xBUnlaTlVxRU1EdEt5Y3A4U0hvU1BHbWdpdXAyMTNMZ2dn?=
 =?utf-8?B?cGczL2dMbU5FT2JndXZSay9IVVg0NWxaZ1Z1OG5taURuOGVMOVRUK1dLNUtS?=
 =?utf-8?B?NmNVeEV0SWhpTHlJeS84S00vWEVCSUdiTGkwZ0sxUE9NNEtLSkppbXNkK1E2?=
 =?utf-8?B?Wm9EN09WdG5vLzZYYmlnSmJjdUtiK0o5elZoakxpMnp0KzRGd3U5UXh6TGU5?=
 =?utf-8?B?eC9RdnNXR2RNdUVTVFpLSThLYmQyWHhOQUpaVXdnSkpyV2xpSko0VGIxTFVn?=
 =?utf-8?B?bVJkaWt3Um45T2RvemZpckJobk9ZZGtkcG9sVEZHUkFzZHgwMGtuNmhub2tK?=
 =?utf-8?Q?u8TCLoGSQd4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M05LblViUTIxRHNrUFpHMnlUVHo4czZBbmxzaGxpWmtNOFZkNUxOcFplRElO?=
 =?utf-8?B?b0lIaE1OWGd0SERVMS9QRUJUWnBjMFFMT2R1UitYZzMxOXNkNnYyblN4TEI0?=
 =?utf-8?B?VTlTS1hiQ0JXTFpTL1RQQ0Z0OFBkcDc2MDU1L2EyM0JqMU5IZDJWNFBTZUlh?=
 =?utf-8?B?YW1XTlRKUGlUNytCNXJPRHJ4dmJJNjBVRkRtemxudzZIUGhhL1U2OSt3VHRP?=
 =?utf-8?B?SWprd3NFZWFzT0llZ2hjNHpEMGZ5Rk9sejNyOFlLNkI0TnBrK0pTbTBMUHFq?=
 =?utf-8?B?VXc3ZStmclh5eWJaNzhxSjFxVTcvMFdZUSsxd3JkQUdVVEZQSGdPcitSOGpw?=
 =?utf-8?B?SFlZU2txRWRqV3BqaFdVQUtzTUlFSTRUUEE2RE9CblRYSUt0UXE4NytJODZ3?=
 =?utf-8?B?d0tNMGVBTW9OMXRLZzVIRnNxY2Fvb2lKZ3N6RWo1bmhwRndub3JyQzl6dGpO?=
 =?utf-8?B?b1FTMjVtYXdjY21RNDV0SmRIbGZaaSswb05oNXFJaGRrT0IyY3dNVDlWOWRS?=
 =?utf-8?B?MkZZSXlmcWcxRWRGVWhvcm1qM2JiSTRlOHJIdFozWFgxNko4TGI0bG9MTDNj?=
 =?utf-8?B?QWVWenpENHhxZUUyekQxL3pZY1FoeUMzWmNYL01BeW1FMlJPYTBqTnZJK0hz?=
 =?utf-8?B?V0FhRXRrTUp5aWg4WWdVRGdzYy9DV3picWFQTFlPR096ZTY1K0tGRlV4NnFD?=
 =?utf-8?B?SU53NnFrL1QvR2hXakN4b0k5Qi9QR1plb0Z3R1lsRUNONXg3ZjRFMmU0cElB?=
 =?utf-8?B?b1pOamZtWDcrRUkwUkUwVGQ2c3JBejhDMTdvQS84UXgvM2c0dTVoSXJFTlE4?=
 =?utf-8?B?eGxVdWdOUmkrUVJnc2tXMUlmNzZGVjQ4aE0zektpdnAvNmVYQ01SMFlXZTZU?=
 =?utf-8?B?OGtCNmgzam43M0N6U3ZQMDNNdXJ6aWlFbnZNUitpS09qZjVMNW5uZ1pKQVhm?=
 =?utf-8?B?TGhRcnp5eVNzRkZkNnZ2Ty9KTGpUcFpjZU85TUxrTnNWYTA3ZGlvVjAwZnMw?=
 =?utf-8?B?a1ZHZmliRmh3bVEvUC8rK2dmUE1jTE5idm52K0d5Q3pqY0FuVmJ0TjNpSGNW?=
 =?utf-8?B?Y0hOQTdHQmZtNllNY040VnZCbW9FQW1lalNHR2RpcHl3RVBQYjM5d1J5Zllm?=
 =?utf-8?B?WGVYNGoxZUl3bDZ4WXZVVHQ0VWE0dEdlbTR1alVUTHZ4d24rN2xqY2hQTUs2?=
 =?utf-8?B?dFNqYy9RUllTajBvQ3ZPK2JQZnVvaWdXQlVRSzNabGl1WlJQSmtpZGxMWWNm?=
 =?utf-8?B?OUR0WGpORHNIdngwbWozdjZQMDlDVGJMN0h4TlRqTWM1Qlh1Y3dySW1EanhS?=
 =?utf-8?B?Q3FVcGpTaFNqOEYxQk00L1RmcFZkNDF1T2tLYXpFT2NVZVJlb2ZWNHJNakY3?=
 =?utf-8?B?WmxFNm9qcDdKZ3krdWRRRmFFTUdBYXl6TzN3U1hWMGdiTjhJVmNVZ3MxUHR5?=
 =?utf-8?B?cVF4K3hSMjR6emorVU1CTTlRamFzZ2lxaUFmc2Jha0p2dG90OHJLemN0bDRp?=
 =?utf-8?B?L3BqeWg2Z2o4aDVmQ3U5UWRJRE1kRi9oSWRUa0JyenRoNUJvV1VKbWxoa3Vn?=
 =?utf-8?B?ejFBQnhhem1jMThCVnJHVk9DWXVvc2RTc1JERWdMOWJDVlFVc0FpWkZnYUlw?=
 =?utf-8?B?dnlFV0pDZW50SUhFSjU0eS93VDFqR1Ayck9RODJVY0VlTmIvSFFzZUtUNysx?=
 =?utf-8?B?a09tWUc2Q05LV1NGZTdpam1GVzd0R0xDNWxvVC9vTHA3bzg5YWp5d1FKbXly?=
 =?utf-8?B?K2JyVFd3aGczZEc0YmFGWlJmZXBmQkZJeTA1SzU0VEJpWjJHNVhzbGhSNEYr?=
 =?utf-8?B?VGtPdmNEdzUwUDE5U3hGVzNseHczajRNbitYMWp4SVhkTTVDSDdkc1p2QXVP?=
 =?utf-8?B?VFBtdlNNWHVTb3lCMUpndWNtRlQyTXFaNnVCWCtoSjZJOWFibEtEZXg2N1cr?=
 =?utf-8?B?VWhqY2FEcmhCRDIyYTVzeW4wVzdqWTRLbDF2K2pTSmRhL3d6bWtGLzRrb1po?=
 =?utf-8?B?eGRsUzk1MDhjWm1tbFBBbG9WdldFVno0dTI0azlYQjlONEpUMTJlSkpsKy8r?=
 =?utf-8?B?bWRuOStILzZqang4MnFsMTFTanpTM0hoNUFWRjVaVmc3T2NtMDJTSnZYODh2?=
 =?utf-8?B?dDRsUEtRUFlHK1I0YkgvQVhhMEZvcm5ML2hMbzB3cUg4OHJqZEZLZ01vRUdN?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FV/Em/BuCjKo+K+3uSP846sBXRM/k58+wFebkoExpAZjT7HNBtzMrPzZjHz9DegJTZ6xqlu5ONvhzbj7xW/75Jl2ux7NNHoBFuG4k17+fEJ/5ypZVMNwvEKoWuN0bEDQ5qtmO7ypvXVELc2qMy5xhK+wkS5sG2nqex6MtSU/JkAeCnrQpaLn2be7/M9ty52ehTmZIQLWrsn18kk4A/FDwUuZtvodUQ788kSvAdhCn+SGTGJ/6OAwZ3hjomXhZWaEhwXBFDvWEb4MJXhgDl5BL6ItTQV9NkvWaFWk0+hh6CLUXc2txlRB72EuDNBnCWM8xl8f8ILulno0n4t9V8sQQdksxieUcNmHqlOUlEFBqnAdxNG3qq9/Httvld7TYQWMrgmbFkOW5MS7SudfC44kG3ww8St9e3ripndZ0sGg1/usM9qWSuFZhKYn8x5Tgi78Kf6UE3nSBjVPRL6IvRBMO9sfHQq85Cz81XFzIhlfOrGAt3o35KB8kcSdFkCl6AduoPHBQ9xSHbVW9rSNI4ZSpxmWUlhSmE3EHbMnnrlKe02nOvD28dWjXXoMXbE2okf9jURq/wddNt/duJf64NYLWBgkMEIjKm97OMcrD5f6M4Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81765614-a871-4efd-3a88-08dde947686a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 11:05:06.1002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2No/iLWKzl+tro0D45T6dslgmKvhgO9FRF5GlkCYSbaNnNX3TDZrX6JZoMmnKaJIAAvqfMDMlF2+ksFpEn6Q4JCvCBk6PRPWZbW/AofV40A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6775
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010118
X-Proofpoint-GUID: 2OKkVM8j_FiUIFn_sxRBQnvPDlETOvWx
X-Proofpoint-ORIG-GUID: 2OKkVM8j_FiUIFn_sxRBQnvPDlETOvWx
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b57de7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=6dd6xkbKkwb0OfQoy7sA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX7LCMpKcTZtsz
 8e9HqDlbBWmk76ykUBoQ8l8syge/kvxiI0YV3wnRxNHFcQWYHffFalfwbO3CaRaUfGs1WE0Oxn8
 RndgPGKhalmUYTz2PDsea3CVIjUn2AHzzYA1/sheLABV/iXs9t6SZEWw+1b9O/TZOjMygXZgi6c
 uS5OpyYXmkj0tBRz4Re5kgQRtd5AYZ36BEbK5yxz6izNYuf9O75seZwvx0rx7ZkmirbmWDT4nbB
 KVugD/9Pw26r6OUMuPH7lTDj1cEKNPVG/xEVVEvYcJdhBXNr4V67KStQV/e28Cc3eCTDIiGiHWv
 Fykr+LUdpcjwtswmlLhc92kQSaV/CNn0D8yZH/r8uGS+pqUtAmi20gMPAGmL6sVsw+qoPvSyGs7
 k63C422Z

On Mon, Sep 01, 2025 at 12:54:40PM +0200, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 12:43 PM David Hildenbrand <david@redhat.com> wrote:
> > Max, I think this series here is valuable, and you can see that from the
> > engagement from reviewers (this is a *good* thing, I sometimes wish I
> > would get feedback that would help me improve my submissions).
> >
> > So if you don't want to follow-up on this series to polish the patch
> > descriptions etc,, let me now and I (or someone else around here) can
> > drag it over the finishing line.
>
> Thanks David - I do want to finish this, if there is a constructive
> path ahead. I know what you want, but I'm not so sure about the
> others.
>
> I can swap all verbose patch messages with the one you suggested.
> Would everybody agree that David's suggestion was enough text?

I'm fine with:

"constify shmem related test functions for improved const-correctness."

In the summary line, but, as I said on review, with a little more detail as
to what you're doing in that specific file underneath.

You don't necessarily have to list every function, but just to give a sense of
_why_ you chose those.

For instance:

	mm: constify shmem related test functions for improved const-correctness

	We select certain test functions which either invoke each other,
	functions that are already const-ified, or no further functions.

	It is therefore relatively trivial to const-ify them, which
	provides a basis for further const-ification further up the call
	stack.


You can re-use this kind of text for each adjusting sensibly as you go and
noting the dependency as you mentioned I think at 6/12?

Just something that clearly expresses what's going on in plain English.

Cheers, Lorenzo

