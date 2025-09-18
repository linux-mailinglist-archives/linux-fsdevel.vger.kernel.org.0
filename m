Return-Path: <linux-fsdevel+bounces-62123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 389C4B84C87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E389B485108
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658553081CF;
	Thu, 18 Sep 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RAE41okb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zG0l+dVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B02FB62B;
	Thu, 18 Sep 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201635; cv=fail; b=L4zGt6N6KoJ84QgNhqtJHdju8WYotXBMJ1v1Rd5MPhZBCakwnrBVeiBEh061JWMlw9lTlHUYcVBPXX2g23joQ3FVNoDOzi7a9HRvvqvvO9Ncm5XM2NAjINrsznvbNPSCkEYit6Xzv8S+hVDXsoysRF8HTEcjrEP3m+3DjjBojgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201635; c=relaxed/simple;
	bh=R5JFgOOoEQtAThBtMLPwzcHeNgJoabmF7EroBfupuvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C/mLPq8g3Q7v2AwcPbnO+rZODsYrTZZra2bqMsQ8/Y7gIUDg81GAWW/F1TA2lG+yCZnzf06bbdWx0jAM3VsW8bsp8V4jGx8RYHuwLfiOZef1FoELIOa4azqBqqsEz98xO1XtNBu75QjI5LbTliUfqk7Kq3H2UD26C1fS8PkiG+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RAE41okb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zG0l+dVt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7goMP003443;
	Thu, 18 Sep 2025 13:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Ll4roQArHcXuZanaah
	J+ueARRS0QUISNoRefxLkbeSU=; b=RAE41okbCRUpULTsOV68RfycWtOB9v2K0h
	OK3pnL8IagvB/x9/TutQUCMNzCT/sbWSEywtMApzkcoz5G12HYmXlZagGx5MIxuM
	z9I8SpE9RSG2n3Hd085r+hiaYJvv7BYcwy9KuijxgQXtDg2yu+pKLn46T37etmzk
	XIu0Bae596OHCvVilVXWkuWN2QUq/2mn2MDBvSzHsA4w4qcszQFaVSE/FYbQ0QKC
	4VSBkIctQOqWP60IVhY8GwQaN1kOX8bCBWNjx8nCPdg4PVBOgLko7H0ak08yhhIz
	9lKtrytRoeRuDAwHPz2S2fFJ4lor5QDJ6x/qyZlodInRXvs/wdyQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx93dq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:20:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58ICDTND001486;
	Thu, 18 Sep 2025 13:20:09 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010019.outbound.protection.outlook.com [40.93.198.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2fbgh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:20:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY39l4cLLsM09q8L5h+M8cLz5iSc5j4tsm+hiUF7SjRXSkrNJlKmWsNRl9Yg16mPP+j7BTYE6LMLb14DFh9yWMLzbh/UeAL3GJbhFu+kY8RO8P/SJuGhxl3yUkQpXvnqx6Zx7kQSCv/UrkpDd1k5RvLvSqDi0NnesQOsqZiVU/LRv8892xDiBalNZfF9+2VdDd+4ZgN9I/hsrT94+mA3w0kTauoZPm2PgtDqspsAkqZTv/R84UrxLazRpEuO2rKfzLOKbY1ZiexkABj8dQToFm1uhJIc7h/r1GN/Gf1d7S4WErb2NbPXGKlDPpzsfTbXgdjPIMnDXDlb8QYUDervbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ll4roQArHcXuZanaahJ+ueARRS0QUISNoRefxLkbeSU=;
 b=ExgSW4ENUAK8g11CjnvmXgPNOCyetnEb7IhFtyIGr4CscYaMvDmGyx18Ki/vxEAr+o1b2ao74W6pLYMBuhZts3aAJULQKRWJakt+w23YjwGe7p4BPRkGT8O6/ugBzEVlCqmeSKJgr4Zppq5z5Vr76N3aL1I3ftmJY+nDa89lj2bWgzGW4MfeAky8jebdB+wCjKYi7RkvvLtg4rBM/Ro0qNNRZYyF1e2mKj+StJ+F0JRTsPQgOt7K+g+gGYPJLxnGl1gZVfRwKAI8KV15vPqWBIvAAA8haLOhyStEthAKFCFzizkjk8Yl3uttxCCR5LR/jn9A71CJylHn2PQCkZvn/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ll4roQArHcXuZanaahJ+ueARRS0QUISNoRefxLkbeSU=;
 b=zG0l+dVt7qe+jrjCIUmHGXYnpcJCXBQos/ifUx97ZHG0NOTGYJemhrs/JM3YAeFelXwS6SIv7fWeI1TTZPD+tG6VgfUEoEYdmw+zT+PfAip8L1Mc6EJ3W+eszJ7qmtJhM4bL69tz5lmjuVR2xalCA7CA0t4erI4/sHwbFYvV/aE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4528.namprd10.prod.outlook.com (2603:10b6:a03:2d4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 13:20:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:20:06 +0000
Date: Thu, 18 Sep 2025 14:20:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
Message-ID: <48c29189-30d5-41fc-ac53-09ce98e87cf4@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-4-kaleshsingh@google.com>
X-ClientProxiedBy: LO4P123CA0220.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4528:EE_
X-MS-Office365-Filtering-Correlation-Id: 7121a589-6c09-4908-47f4-08ddf6b61578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rq7TcHgf3Pxf3qSWKWjXuf6Jb5+OMEr0byX0+hW2eor9jFI1CGX2Xj4IBUbb?=
 =?us-ascii?Q?EL0cL/KHNxjRr1ZwbKlzIJDIJXEI8vc08hWXD0JLv2bkzpz6pZikicfNvdpj?=
 =?us-ascii?Q?43KnwvfI0D7YW7xKoGSmR1bA79aGzsKhIOd6FnFcvt3z4XfSoidZw2Su0czp?=
 =?us-ascii?Q?QIDQ8rNRtH4dil34EmOwXfbThKN9uTMfBffFFncBq+5/NqFqwoWS+sJap3RS?=
 =?us-ascii?Q?qOdYusl7GcZRXLN7REXzvFuyfrOt0EF5XXDx5FoX21h5Uhbn6pNPXyUkJw9F?=
 =?us-ascii?Q?3f3CMCm749AJBZYrj5hql6tZpLd5E5y+4M5QFL/Wa24LBdhz8NwTX1b9cGGJ?=
 =?us-ascii?Q?GGWvXNmb4ybsAOwvYgyZW8vmfIyamNRmPyxw7bvMmvxkxubzVmjjYSWhIxXU?=
 =?us-ascii?Q?rKKm7W6nMI8tqNOftyAQhpK73NilHltINsYq+/WRPXY0E4W4kWPfMUoiexM4?=
 =?us-ascii?Q?s+O0l6tc3OJDySVDAxJTpHRjKSHfEqfPRnyEoM6njBKDcpKX2qzV8/OqfXeX?=
 =?us-ascii?Q?0vk24lkQ/3WKgUCJ/LUTBXgQ+I4E+0pTyCLbKfKPpQcIt6G8k17p0Fhr9v97?=
 =?us-ascii?Q?pmXBgL4NlylAv7Bn/Gy5N7sYxUFl0WamPIVJKFpwXF+RtYgOSWqroFN2IILq?=
 =?us-ascii?Q?tjdY5vPeVBzvN4VSggIo0VP4b7tYJRmQEZCaBh9hWHKP5qSZ5xSQANdw+4zz?=
 =?us-ascii?Q?7mJ2kJmFAU2zi0pbICRZQVrS6WryNPqn0cs9KvXklMWUhhHcCYD4f38smEUn?=
 =?us-ascii?Q?YYJYs+P7kh6oymZwJaXbXSAhkUxczawo3ZIzPn1+n464OB3Nasxt/XqgFQ8C?=
 =?us-ascii?Q?MxzUpviXzXTqLBlTzXaFjFV/38pDtDdn7XccGKCA0QcfWSw+jP95SWjhlt1E?=
 =?us-ascii?Q?lSPT49zbwsW34aSkNJGxfOdlOeA13FrfU5ZdO1i/Y/veR9eJxgPojCnibFnt?=
 =?us-ascii?Q?fDdou5EvNenLECY8eDMEOCIYDNxdb1kNFv8JMOXyuO3vLVYI5jOEaxMz4G9T?=
 =?us-ascii?Q?smuUkokRNHwwhCasD0GbHyD575rDS3nNAM6T51wNNQDbgks/xj2YO+2c5ki3?=
 =?us-ascii?Q?wJg9vMQrJC64UBl536eD9UnacvMrMMeZazT7Duyn2mOVu0jWuOgH2K3OGw5/?=
 =?us-ascii?Q?ji9Z/ksNF8xURz4NgWL3u9JDTnFhdy7Nn72YrBikezVFtn3ZoRxx9afF5kjx?=
 =?us-ascii?Q?1HBHxQ1vHbMUIcC6W4SvO9wCHERUL9+JgsKwNkikpfx8xG9F6wptY8PFECXD?=
 =?us-ascii?Q?4/NxTtfVAXMrkYTrgWU1kY+JMwEJBFxVBjA6jqrqTalmEq8q0k5nffYxg+4r?=
 =?us-ascii?Q?uTZ/i3xhnlgv/jynCNDpLi4KaKCAJ2jWz18fh95SNXahXn29q7iwZsC4U4Pt?=
 =?us-ascii?Q?+CKv9YHw6JjMC+I3g8IoecYRWqD7H4SH8vePwKEWjiPmxaO8sEz1jabuMqVp?=
 =?us-ascii?Q?jaA7EAcYPBI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tG3hFNOy/8t9dmZz5y6dJUoo5A0UjyvEKFec8KjY+ag9H0G/vsELAFZTyeq8?=
 =?us-ascii?Q?foiE8tM1VjDnTklZwd/PEW8SLgzG34U5D1AyneyJeO5mZiZSrtdn89CpU420?=
 =?us-ascii?Q?jFwc2EM9Gte8GWrW0tdCBPb9NKIe+24tdGbAmtAw2gSc9Vm9ZgcrucKWEOPj?=
 =?us-ascii?Q?p5gT0RUHR9nSvkTki4JEHzHn9ajAezMvOCsbL6R7T1GHeh1S7AJODTE/voBA?=
 =?us-ascii?Q?WulQKeqohNPTqhiSDM5j09BN2y1Pa3PEyMb4tPN5UoLogLlFVBqi9oQ6a34A?=
 =?us-ascii?Q?lQSFpeGXWHrHu+ufivG6K7gKXMrj+9vsYDejGpux/6A+rbMxPWsJInp/slcA?=
 =?us-ascii?Q?LASHn08G4B9FVMp5ykKFdK+UVHQ7mJJev2Y7JnVbVlLSGQIYdT+HAy/QB1nN?=
 =?us-ascii?Q?LSh6796T238JBBet4Z2Bk3aZV0+GdlQCa2bBaV82BPvScrsjE+K9WU7PRYp7?=
 =?us-ascii?Q?Cam55tZrh2iE3GKIlwztN6lCSp0EGHmpmfgCR8SLKo3FwN961hmm5qqW8gAT?=
 =?us-ascii?Q?jqrotUkYVmL62r+TJ+Jm3gwe8J1xsdw2K0ZABFID4cKs2XBGrpNCTx6Yh7hh?=
 =?us-ascii?Q?Ww90ezLea50fJ5j4vVXIl/XYt8iUYpSXSR5+3Me4zndgie1l4joRBF09MRDq?=
 =?us-ascii?Q?MPzWQ37Ctg/HIg0gEN87C3OZPnO2px5QTOZeA4lXkbRFV8wwOlNhjKSWXush?=
 =?us-ascii?Q?FJZjiCuqlA8iRwmHMxkq3YjZfJ4p3PPT+NOynm9JU59eZ/UYI4Gph2ltLATC?=
 =?us-ascii?Q?hQ+zl/0TzcYN9holFPvk35q7gO5kQNowLa9w6PlJGHVFBIqgVaAh8mMgFguX?=
 =?us-ascii?Q?IW3twYefbeibYJXk8NCDjoPIwkBJdn02ogogdYuStal7636qZqdc2fdAl/L1?=
 =?us-ascii?Q?RpUeYxP//wSXbf78cfNKIAZ0vTQ5QM6wyXhyX0clhoAFdDiLffKz83q4HLw5?=
 =?us-ascii?Q?MYvSjzNJE5+lct/Z1zCEpyTzrrLQpoWpnXL2KIaDPHkJP+WrboI7bScb6mz0?=
 =?us-ascii?Q?i8lOS4SzjUigaVX66O2x1rXgiEUXvBC169f7kK/N5OfY792bsUWXbXVu4zr7?=
 =?us-ascii?Q?HZyIYPiKZgQgVXtOWKx+CEsf2J/1NGKxcKVofkolVliCCNYparRSTtscsVCP?=
 =?us-ascii?Q?rpplNBpTsLPGeIoZphFHzoWrg2Uiga0aG/1XzF1gdTFy+FncVokzUlCehdo7?=
 =?us-ascii?Q?zhKxKeTWzZGwJiRxHCrMNpcI3/AkBGzsW62qTMm3rsJsjXXYKQxdqvtUNfbX?=
 =?us-ascii?Q?ffOjveAW1i+gnOhjW67N9ZvATUNrd7x72cUrphOsI0xwWO2lbGarvEv6Z35E?=
 =?us-ascii?Q?2ylx9j6QzxvCWz6yNWODqLmeUcA5n9cQYTxuE/amJbQg5DETEBkcJn1iys6I?=
 =?us-ascii?Q?5+4nYCricabI3FOoXz30b/auo3Z2JpCZHC7IPVOroLdHF+QVgV8sF16s/xNW?=
 =?us-ascii?Q?opBFbsm69Xv9qOMeZTNMx5MoGHSdAR4N91+2rZM6iNC8Sp8odEtIJrAzFXt3?=
 =?us-ascii?Q?2PnWgiFUv3X4KP85lI2/4MoqPQzOhz9isJt7ewJMbQXoOwcHZ//LqdNCsuSE?=
 =?us-ascii?Q?R5VWiSBC70QUWRwdBPRz0daFY5wWBSORgO91QSvKFcRfYi4rJKXRHYzFw3pI?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iv4I5Aoh/yHHNvPljKBzcyaNfYU0oNIKENkcRdMzylh0UdhZ3Fk5+ai/5APL2TWUeCmvsS2v4SRgexCEuOI/FwG0F9QUd1yvl2T8DQKDSyigdIt+Lp3+hrVr3mEBdBvEPJjs0uPwISe0yiLOICkIUzb0fN7vq/gQET/L/NueP/dicjE88LYNrr03etEHvi4oZ8TA/lwRinH+9YZ7GKeREAKdYVW6MBPQYwyn1TKjG6jW5vmwJLMlMSuHfkoarlwdvSm3fviB9nPYg4l20e1dCwkbLLRm5J5vruFx5jq7fsu6hyUo7s6IWsLoGhbBVUgSolb5KVw3Tcqbazvpfna6wQUkvccZJacGXbdzzO/QV0hai2bSgKo5o3pB1zFpE2OFSInMZnJCmqWntmotsHDe53tz4vi9pB8ayXuV/qSXpomu4FrdxqFdMt8kB+d5QewFrfIlF6llx7ex10wy08VEv7uF0/ri0Te3eFhwtqmrUvXV8mRuaq5l0+116T2lcewqgBTktmFlNVO4nZ/fTcf1gGlVm0LnnDcHldjALBDfba8mPMzfbk3FVqEnzy9CmfopkNr0GkZb9ejTxuVb2eBOfNfF7eqaR4hBnCtewFds75A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7121a589-6c09-4908-47f4-08ddf6b61578
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:20:06.2116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAt+gWnWHB4CIkp7wd01QYzvQgpOIQ0cW1w9rAH41dFWw805sF+Sk9BC1DoI4TCyXV8zkXQGHYWN9/w1YgR2BeMfPw2StOTi2Fhi6alO7wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=997 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180124
X-Proofpoint-ORIG-GUID: hA9M1VdAS_whA9DYi7sGg_smq92HtcuX
X-Proofpoint-GUID: hA9M1VdAS_whA9DYi7sGg_smq92HtcuX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX5BPQbCD6rQl6
 DuQTDHWYwUYk9e214SprxQLT4Cugq3rQGbTv+x+4Gq1bU4Bg1QSRDdExoRgtYJdvgvQ9pYv+o9t
 nqrHNffmc+p7+pTjjP/WZKS1knj8Yv2hTi1EDDoKEDnsJR6A5prIeo//KgThBlhMV0RahC8SA9/
 WbEgYJgK6yUWRizXFt4EJZdX4dKHKBRUIxK/4S/z0SfvKdSY6kT5Vsfhcdnoia4oZ0a9As8UTNO
 Go4tLV0TJ5SFoWgsjtWhVpzaRTDBAMfr0OMId43mj7piHKL1v68ec8tDqGEw3jv+rfQ18NTLf6A
 t2b9twElKfc8zVGz9pCzvhW3H2UGq9yx2/li+wsxT2NiPfyCNEBj6dU7Ulx9GJgJF+G2QWFd/y/
 CnNw0WpA
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cc070a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=u8LonBRhK3MTdQgp-kYA:9
 a=CjuIK1q_8ugA:10

On Mon, Sep 15, 2025 at 09:36:34AM -0700, Kalesh Singh wrote:
>  include/linux/mm.h               |  2 --
>  mm/internal.h                    |  2 ++
>  mm/mmap.c                        | 21 ++++++++++++++++++++-
>  mm/mremap.c                      |  7 ++++---
>  mm/nommu.c                       |  2 +-
>  mm/util.c                        |  1 -
>  mm/vma.c                         | 10 +++++-----
>  tools/testing/vma/vma_internal.h |  9 +++++++++

Will look into this properly later, but there's a conflict in vma_internal.h
atm for mm-new FYI.

> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 3639aa8dd2b0..52cd7ddc73f4 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -1517,4 +1517,13 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
>  	return vm_flags;
>  }
>
> +/* Helper to get VMA count capacity */
> +static int vma_count_remaining(const struct mm_struct *mm)
> +{
> +	const int map_count = mm->map_count;
> +	const int max_count = sysctl_max_map_count;
> +
> +	return (max_count > map_count) ? (max_count - map_count) : 0;
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> --
> 2.51.0.384.g4c02a37b29-goog
>

Probably because stuff got added at the end... :)

