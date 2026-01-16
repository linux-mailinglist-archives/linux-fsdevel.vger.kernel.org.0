Return-Path: <linux-fsdevel+bounces-74065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65128D2DF46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 09:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E0130393E3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 08:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAFCB2F549F;
	Fri, 16 Jan 2026 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Tv3FXpKZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TtG3Ps/9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E183282EB;
	Fri, 16 Jan 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768551668; cv=fail; b=D/FpX13kZZk/FzuKBXsRaMU+28YPOGkbNVmMhcINoRd5cBMgJKT2dRJ4+RUzhvd8mgw/BEiWZc+TOobHg1tnX34va78JRVGipxMdnhJTw2u3QiXQYHGqCL0QjPo1TAKBA4e8yFLY0zKwdGjlx0acWyxt17E04hCKGazCOhs4/9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768551668; c=relaxed/simple;
	bh=ui9oTUH0/K7Eo2+qJypy+SDkdsPRXpmg8mc5O77++TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LTv+5deMdpp+WXH38q76t3fHed1rzmC4qehn3UNOHKBCsiZ2x5vIWObAc58z3etJsPh6suNN8T56NauFiC2TnGErHk9ma73GsRWQo9fwckQv0h81vkVZoFKtTSJ9VKQx9Xil+ftZxPFNJ7uNJC3meFj71JaRyLqnI7FPsh+hVms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Tv3FXpKZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TtG3Ps/9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNOHhF1432554;
	Fri, 16 Jan 2026 08:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SM0Qho/mLqz/7rpZSY
	HCFp6RvQuiZY4/4pfHadY/TPY=; b=Tv3FXpKZMhd1Vu1r8ra4k0WJV0qnBmuOBh
	r17lZ7+c9rFwKKs5pPrqQmDgpxipSnmCgj0TqvcvZF6Npq3R/Fg7w0f9dKU2iRwX
	A7VgJhM/6EQQKBNnhUkYF3TrAoYQ0rVz1oGXttIQaXoESrBB/hkTFvV0LlRjfVeh
	P3zWp5ws16giRfN4PzdBuzOsUkTOHybIlJGFcM8E7XWI2b2x6UwdnM6tVstDFJfo
	lxWt2Oz8laznaEeTwImeO3JaTLZRsN0wZPP4RKiRGljqHSesMeVqo+aQQ++lsjiH
	A4fb7Kp5dOOkV58wOkK/cPwrlS4POa0KqEWJZObOQ9PAO2i+v+gQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkqq59m63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 08:20:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G8BCkR001924;
	Fri, 16 Jan 2026 08:20:10 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7cm5r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 08:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqPibCFrn2fSCXPfV//O40Q4H9bEPNDenh/kaTMXIC5UOtqixMkfkWz/0WMXlswXRwDbIo1E7WtoNPH/VA+ad5qb9eqlO2tEH8R6prokZ9/hLgFNo/HYuWGUVElQk8fvzF5tH6A3ZIjOQysT/EVaLbKHpQy7/O93o2wpAS2uZiTN69FdsDAmgBsViwVEBfsxnzeYPG0IQnBz3KUekKCFzgn2tLn1OV5iG9Qmm3BDdj9HrgoJ5uDLZ1YWPAExT51XNnh0UVuTdeShbqg4Gi7Gb9RrZET12yGT4LIWhIbfLDjSFRF2vWte3VC0efvEvrGktRDCBla9hjyQNcecPIIp+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM0Qho/mLqz/7rpZSYHCFp6RvQuiZY4/4pfHadY/TPY=;
 b=HklM5Z+XrMCr7DiX8sTOWhQKuVQO0HmoDzI/YqpLg2IIxOpXPSQkMP2sJoXkuUAhfziPBPN1brtbVesaRKLRAdNZs5xnbDG5YSPaigGgaiOag7m26WNsgTiKpu0uRfwP6I4XEhWsXHv5zqiCYy4ED+9xNz96CynPyv7ldJPQIY9FWPjPdFfY4K+9reF7YGHLLhgVp4ExzM1TrFNX5sDfEZgIEHw+ERMH78Uszt/FuQWD/BiN3KgkrtGp4+C8UMd9o/0t/Oj3jRo8EEhGeKXRgBD391rOWStmCP6mn9KaXsTRdGkcN+0rDuNyIRrPFoRa9CGcA3F6jgjUSH2RFY04lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM0Qho/mLqz/7rpZSYHCFp6RvQuiZY4/4pfHadY/TPY=;
 b=TtG3Ps/93wDu7mz8vKm9v+J2ZDU9vQfKreSVX3DmDZL4YKWhDAX5BaogdBHFrYfU0Kp2Vw87w9qkZKeRcp8aXKDHaKX1F+ROBU1BvM53RICXcIyKwGLUK5JPx9ZDpkju5F/OOx/9XnNPKoE24mkrjOFa+3WkzyI3Ur15l9VlVCk=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by CY8PR10MB6905.namprd10.prod.outlook.com (2603:10b6:930:84::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 08:20:06 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%6]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 08:20:06 +0000
Date: Fri, 16 Jan 2026 08:20:08 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: akpm@linux-foundation.org, david@kernel.org, riel@surriel.com,
        Liam.Howlett@oracle.com, vbabka@suse.cz, harry.yoo@oracle.com,
        jannh@google.com, willy@infradead.org, axelrasmussen@google.com,
        yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
        mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
        kuba@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: add skipexec mode not to reclaim pages with
 VM_EXEC vma flag
Message-ID: <14110b70-19e7-474d-b0dd-ba80e8bed9b0@lucifer.local>
References: <20260116042817.3790405-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116042817.3790405-1-jackzxcui1989@163.com>
X-ClientProxiedBy: LO4P123CA0694.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|CY8PR10MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d501caa-ce88-447b-51e4-08de54d80e4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IPnpA6FnWG8ersCF1XbER8fTKk0JeCxuvFc1fQpEnw2+hCg8i+kmzn6/NFm6?=
 =?us-ascii?Q?S9iUeD16ZEsD/Gn87l4k/CdTq/mKaGix2OV2n8tqtMOPf42dVDJWMfVtDazy?=
 =?us-ascii?Q?WIPSX2jBlXw4ad/kN6QhGZFZ6y5yi6ENTPikg+pqcSCvjwrapciToyAdFduZ?=
 =?us-ascii?Q?Kjjq6KzkHQT7TRMfyjA0/idCQ7DvAsbcrGTutjnJHD+4E7gETf8Ik6xgfwJr?=
 =?us-ascii?Q?36aA1OdOAlgnutyIDFLH44w1ju9voTaowBuMp3aaQKIOXqA160lm73P9dZgr?=
 =?us-ascii?Q?kqNnAFOzs7d+uSMac9EEDixLUknz8VvxZlNttVu+UibDW6mg0J+fDlRrSLT+?=
 =?us-ascii?Q?kEYgUB4d9dL85OTK1w++29qeOWsgs9OCM6KBgJas0e1OQNBsnQ6/fXhNbzCN?=
 =?us-ascii?Q?Tn2DiPuRdDBgP/WziYQ6SRw4IRxTGlGsONZyxhSAcnJVJXMZF9Eod90I7PCi?=
 =?us-ascii?Q?C3it4tnySvP+NrkdicW2CD4+g7q5zub3svQjwq6sAeT0OyTyDgWu8z+TAdaW?=
 =?us-ascii?Q?H6a5MSRxmB94cGGjd6y1C+SP3/Z+u1cprS+WNH9AgtzJIKVPTPmykk6w00bN?=
 =?us-ascii?Q?4sI2xEXF4uDlC6Cb7SoOjfuNv7OO9wLFY+/hByTlBQzX0v3bmubelRg9RHvN?=
 =?us-ascii?Q?P5Ad7XpiTbYJ0Tw73SfiXuc7w206AyTa5hosJ3JIMpcQF5IxyJ+1IX4M9Yku?=
 =?us-ascii?Q?kK68rdTjlOiEzZ3soQIZX/pCCfXoAD/CUWGJjTVEQfaXi4lFM0g8OrRy75Z4?=
 =?us-ascii?Q?tzcWzg474RkvhG/wSR/nOpYIlt2ULAOwn4Ri7QolENkEUrmuwADw50IHcDzw?=
 =?us-ascii?Q?jS7zDeL/I0uj/rFuC5Iqz7Kg90ZPl+CR5BPrxzoe82yXbYSKwIqzEHJ6fwwH?=
 =?us-ascii?Q?CnzIbibPiD8Vz3e35taRJyTfxuiUzMz2U1yyaGGGmWDajEEZ8yNMOXllK5kd?=
 =?us-ascii?Q?wU27mPakuJ7W3e6/n5YpG0j2Odr506MBy/Asupzh06SKLN6liAu318NqW0E5?=
 =?us-ascii?Q?o7CHEMSko4yyULqQNZz7Wwhpy96tqzoza1hXWllJTPhUKdVONi+g+lEF4nMl?=
 =?us-ascii?Q?9EFo8bnn6VH33+PShlRTmyEn2ASMbyJTrQjSTNOZX13dYFZQAllxtFzoXHmM?=
 =?us-ascii?Q?/zy1ePkTN/9YLi6Ls9Yw84XJB7OWgQwzf3rWViG5U3RbFDvj7Ks7aLXJqXij?=
 =?us-ascii?Q?SO91C+cYuhMgs4b8TuQBsUt4mi1HDyedbiq1MighTLN7DGeVWg0lMbvX9mCs?=
 =?us-ascii?Q?8A2m+ubCKcVPxuw5RG/caoiXymE+g92hkOE1GxvQBZbesWl82mwM7/zijQhF?=
 =?us-ascii?Q?EpajFbuuuFQCIkbOikBDBaWNxfhSOJ9K3vZLZ4RsmC45hAPpybWauIoK+ayW?=
 =?us-ascii?Q?MZymgAoa36Jxm+JH6G3/2BlXuOy+0vqDGAI+ilo8HSgBvo57V+fHw94XJLd+?=
 =?us-ascii?Q?a/ew0XkpHI/QST5ChImLUNfSepsZLfwXfWCkTasmrLSShZdVVbRSXptezHvp?=
 =?us-ascii?Q?wQbhAJCrhRUUiJ0qCAs1A3UaCP7phtGy+T3Cw6ddujUPv4/ii5+ByTEhdH6I?=
 =?us-ascii?Q?OTp9g4mKyf7puQ1ElWE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lkAxFY0K7W7Wi61xftqS9zHoMmsLbjqBpthL6X01kQu7R/k6hEULfW1W8K4J?=
 =?us-ascii?Q?j/OmXSxFOUimcHBSyXCKthQ0eAJNdnGylRDPOzeUfO+/r7dJtOC+kHNEuR/h?=
 =?us-ascii?Q?WauOOtM4netvuSKRNl7+bpfQLCTBpORDS8CCN6aie66OMmdMwfGYIVPDaoyO?=
 =?us-ascii?Q?j9IgI8TG5R3Z79aYvJf/AjSvfEGIn1/lvXMqyVWFwDCm/ZUM/drapsKohwPD?=
 =?us-ascii?Q?sg+Bg9XxSxIOjbWIF2gS4XuLL5SikYJ9Mr1UEmyczVsqydhqmvwAYStv4sBU?=
 =?us-ascii?Q?mVXCokueWRoYMOje1y1dxCGfISnKLvGJp5nR5yPEB7I9LpA5F8BfoNF8BnMX?=
 =?us-ascii?Q?R5jqLmgGJGpIHBE/BHaPN/vTcPhc2gt1y+mSK9lthbi46n2N0L05Zelk2xDX?=
 =?us-ascii?Q?2fuz81UAAu3wtL1otIl/hjbdTSH3fDun7JNtHMNVD7QG+QzIUCPFOQYJ1GWv?=
 =?us-ascii?Q?t0rvJxri1JxCdJStMKAX025PIJpslHLB7VRomdzPAXw0QqilJ2IdNaaoLaZ5?=
 =?us-ascii?Q?JyzdoXgkvkPHs+YeTjpY3CygzemdTVlkb3ZCl2zvwAna7SYeojKzFKPcvUMT?=
 =?us-ascii?Q?ZEmGYSGftXux5aTjuepQT+HVtYJ32gTfFwwQwQb5C1dgoT27KVL+9U9SMKWL?=
 =?us-ascii?Q?AV7YpZ7rExlvSQv4JYtboGKpYaZowy2tIPoLzmIGQqPAqHWmVzQw8ZQC7oT7?=
 =?us-ascii?Q?F8fdDqenSvOlqAcKoIPkUORVj4CxlSxv8Nx8Adx0EAuCxujliq+cw3tANmSE?=
 =?us-ascii?Q?+joNmfq/1/LPpLCv6cYBQ6YiDrRdH9zduLacwFDAwrWvA1t/JbWU13OAP/vj?=
 =?us-ascii?Q?g1TKUT30KI3zXyzELj6XUG9vigaiCp5g6v93Ov45OusLHeopx+N/QWr85tkd?=
 =?us-ascii?Q?SDYpDaoy4hyp50gRnB2guH8wSw5/DdvWgsRHTGI/M8Zxasj/ArEsnaU3y+fw?=
 =?us-ascii?Q?MTh8uEZ0fTcTMxE+1Lr6YC8v451GZ+ONl6Pi3GfTu67J/Pt2LGkQgTowafxu?=
 =?us-ascii?Q?QeLoEvM8EzmU9o+3Heh7/ByBLIMl1Z9wn+ebqlZBdGaiw4XgbvktfwIazUl1?=
 =?us-ascii?Q?Ixl1i80LuISfz5qV8Zigzbehk1f5iVgEpqvymj43P7WKDs9R1PjZEXfAJLGH?=
 =?us-ascii?Q?HtL4mLAxevU8LliLnN8F3TpAACTJsa44jMdm40M6NBOkMXz4fA0z0kYdJveh?=
 =?us-ascii?Q?MUY42vrXzZHv9+u5cNGamzXmlJw5dxq+S8ZTOJUwVw7FzslFkh5KuNXZzB0Q?=
 =?us-ascii?Q?VeTy+OJyq+TWg0IU/NHyoigHuxd9/lF6JcS2TnUqNfgXTQBZXysJgpjTn390?=
 =?us-ascii?Q?KY/QJgB9J2OTEhGQ871voPhtPIO95RHIqjYien7508K8tFkSHZtceKP58DF9?=
 =?us-ascii?Q?B6EARtk+v1BB8Fx4/KSHDBx8vGgSV7/FJFhlgP/HaYOUq1V6MuM+EqFGcBP3?=
 =?us-ascii?Q?u2NKpJp/4Tdgaptm9gptQ5+0s1ccQ2SVW6FMscdK9XRlDVyeXCUludlNX/Gk?=
 =?us-ascii?Q?SSs1zzQFei30CfFqCGmQ6yQweNOSE9vuFJB3gS1RzzcStLRXahckL7iah6oy?=
 =?us-ascii?Q?lXNoDOy0leFIArGA+kDQxrR3bNwcv81Z/pvP+FwcvGBQS+qJV4GIH0qsUpv/?=
 =?us-ascii?Q?D53mpVlFyqelNns+q6cQjoyBNVrATzm0M5tIt1KTVK7B3p0x6QpI/8E9t0+n?=
 =?us-ascii?Q?cpLE/mM9hQvGo3LIaupOUjcg4+imcjwrlgFARro5mZrzmw3sCU5iOjeC7Y0E?=
 =?us-ascii?Q?upcBNUHE3z5z9RGjORJIuWivVHr9hTY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2RYXMkUmRZRffnJST8qC3bIV71Jjxvqk+jGkle1wrChko9126MYJjHBMbRmEZBgcP0s7HSN6DyLgEJYu/8tHbOfSIKNWFRcB9iAXhec7lUECcSbA9RoGs+29rFCngymwizu+YfpBbHVO7VXiBz3Tp9Nuk3qacaEK8ZmnKNBEXg+jgr+GA3cZiyfPcLjSx8O2oOkEg2NjZBWTPQ1+mvEVGbmdZOTxRgFbSETc3zpOaxB4ekSeqVu2AsXKY10+VHHotIMHw9ES2qqw7vJuhwHneU53PnHpGEcYHX0UzmJcx9vJfVheh8EFQHC6Ckyz0l4tY5xH5hepzBJrHTlb89EIhTG7ZUB3woatjZBMOXP8QH9+WXYwDp0ipihffM+w2j0xg4sP8Uqs0P8g3vxgCTBVTYmI+UHlpz5K6vgqcwYAA5Vexkl0T6uq3pFhU1Rh4f2DTXOc3RbjoP6FPNbyVO5SpVk3AVUNgW8sJWyUZbDEJXpJFl+zzYXpH0/eV/zGLCEMttMgkWKbQ3K61SSUXz0t+XUVOcVnCOvcZ5uY1anejd04yekunbzjDaa8XYKt5I7A8BS4aOhH509j/ieIDX6beI27CUwj9rMoBumT/ROc/O0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d501caa-ce88-447b-51e4-08de54d80e4c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 08:20:06.6407
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c4B9dsXhYXA2zpizH+d65JiMsH2wbPsy0ZaO7+bmEHDYE0+WK5OuX0buMSeDQvUmV+2NcW2fiy7DfqQoVr0bJ+tQdshGadg8tiT3F2l/e0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601160060
X-Proofpoint-ORIG-GUID: -5_bNJAmbcSX57FmGh4_MEJjPHf6qW8y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA2MCBTYWx0ZWRfX01zHevDKqAOP
 cWpGnoheRF/9q2dF15d2mAdQJ6+SBThQjNHExtaeVB8DM+kO9qWot1aeZ2rFtUncfq37mDnkegl
 jfxJtc3BSJXumosCb4cEjaBtWo3t2ep2u8rPacNTG8357G7GZVLtlPrgbrA8k16X2MIwss3bioj
 ceTJfHgV1SivSlzNFFJtNjLl5JzTgYgMiMl6no1BpimDkmUDlya3THQmaTMxjvxWW8l4o9XeiQt
 U73GkBYzPjB3Ng3Hu6HWmoJn6bhl7qk+etYNm0r4J99ZI0C4okPsJDm5RJblorT/nJXnHYq5Z0F
 qgLa5vDhVFQEjR0kFkJhKvcIIK/Lz1zqyh/r716Xsf9885TinfE7MaYARbZLOTRSzIh3f33FvYC
 FJFn8W+1T2mRhm6Ky9Gg5334+dM0550RGOQs4a6h+blGleLFAR5Hw4LEJdgrgpNYGaFia5y+zst
 dQooPoNYk5vPBX4ZYYA==
X-Authority-Analysis: v=2.4 cv=J9KnLQnS c=1 sm=1 tr=0 ts=6969f4ba cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Byx-y9mGAAAA:8 a=3MewoBcQR-eoXlM1gVMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: -5_bNJAmbcSX57FmGh4_MEJjPHf6qW8y

On Fri, Jan 16, 2026 at 12:28:17PM +0800, Xin Zhao wrote:
> For some embedded systems, .text segments are often fixed. In situations
> of high memory pressure, these fixed segments may be reclaimed by the
> system, leading to iowait when these segments will be used again.

We already absolutely deprioritise reclaim of VM_EXEC regions, so you must
surely be under some heavy memory pressure?

> The iowait problem becomes even more severe due to the following reasons:
>
> 1. The reclaimed code segments are often those that handle exceptional
> scenarios, which are not frequently executed. When memory pressure
> increases, the entire system can become sluggish, leading to execution of
> these seldom-used exception-handling code segments. Since these segments
> are more likely to be reclaimed from memory, this exacerbates system
> sluggishness.
>
> 2. The reclaimed code segments used for exception handling are often
> shared by multiple tasks, causing these tasks to wait on the folio's
> PG_locked bit, further increasing I/O wait.
>
> 3. Under memory pressure, the reclamation of code segments is often
> scattered and randomly distributed, slowing down the efficiency of block
> device reads and further exacerbating I/O wait.
>
> While this issue could be addressed by preloading a library mlock all
> executable segments, it would lead to many code segments that are never
> used being locked, resulting in memory waste.
>
> In systems where code execution is relatively fixed, preventing currently
> in-use code segments from being reclaimed makes sense. This acts as a
> self-adaptive way for the system to lock the necessary portions, which
> saves memory compared to locking all code segments with mlock.

This seems like you're trying to solve an issue with reclaim not working
correctly, that is causing some kind of thrashing scenario to occur.

There's also nothing 'self-adaptive' about a user having to specify a
sysctl like this.

The fix should be part of the reclaim code, not a sysctl.

>
> Introduce /proc/sys/vm/skipexec_enabled that can be set to 1 to enable

No thinks, we emphatically do _not_ want a new sysctl.

sysctl's in general should be the last resort - users very often have
absolutely no idea how to use them, and it in effect defers decisions that
the kernel should make to userland.

> this feature. When this feature is enabled, during memory reclamation
> logic, a flag TTU_SKIP_EXEC will be passed to try_to_unmap, allowing
> try_to_unmap_one to check if the vma has the VM_EXEC attribute when flag
> TTU_SKIP_EXEC is present. If the VM_EXEC attribute is set, it will skip
> the unmap operation.

Hm I really don't like the idea that was pass around a flag to essentially
say 'hey that thing that has been scheduled for reclaim? Just don't'.

>
> In the same scenario of locking a large file with vmtouch -l, our tests
> showed that without enabling the skipexec_enabled feature, the number of
> occurrences where iowait exceeded 20ms was 47,457, the longest iowait is
> 3 seconds. After enabling the skipexec_enabled feature, the number of
> occurrences dropped to only 34, the longest iowait is only 44ms, and none
> of these 34 instances were due to page cache file pages causing I/O wait.
>
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>

So yeah I'm not happy with this patch at all and I think you're doing this
entirely wrong.

You really need to dig into the reclaim algorithm and figure out why it is
not correctly protecting VM_EXEC mappings.

Consider:

		/*
		 * Activate file-backed executable folios after first usage.
		 */
		if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio))
			return FOLIOREF_ACTIVATE;

In folio_check_references() and:

		/* Referenced or rmap lock contention: rotate */
		if (folio_referenced(folio, 0, sc->target_mem_cgroup,
				     &vm_flags) != 0) {
			/*
			 * Identify referenced, file-backed active folios and
			 * give them one more trip around the active list. So
			 * that executable code get better chances to stay in
			 * memory under moderate memory pressure.  Anon folios
			 * are not likely to be evicted by use-once streaming
			 * IO, plus JVM can create lots of anon VM_EXEC folios,
			 * so we ignore them here.
			 */
			if ((vm_flags & VM_EXEC) && folio_is_file_lru(folio)) {
				nr_rotated += folio_nr_pages(folio);
				list_add(&folio->lru, &l_active);
				continue;
			}
		}

In shrink_active_list().

We _already_ take into account VM_EXEC regions, but for some reason your
use case either encounters such extreme memory pressure that VM_EXEC
regions end up being the least recently used.

It may be your workloads are doing something crazy here or you would end up
thrashing anyway, or you simply need to mlock() them?

In any case this needs deeper analysis on your side and any proposed patch
should be in the reclaim mechanism, not to provide a 'ignore reclaim'
sysctl.

> ---
>  include/linux/rmap.h      |  1 +
>  include/linux/writeback.h |  1 +
>  mm/page-writeback.c       | 14 ++++++++++++--
>  mm/rmap.c                 |  3 +++
>  mm/vmscan.c               |  2 ++
>  5 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
> index daa92a585..6a919f27e 100644
> --- a/include/linux/rmap.h
> +++ b/include/linux/rmap.h
> @@ -101,6 +101,7 @@ enum ttu_flags {
>  					 * do a final flush if necessary */
>  	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
>  					 * caller holds it */
> +	TTU_SKIP_EXEC		= 0x100,/* skip VM_MAYEXEC when unmap */
>  };
>
>  #ifdef CONFIG_MMU
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index f48e8ccff..16cf08028 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -343,6 +343,7 @@ extern struct wb_domain global_wb_domain;
>  extern unsigned int dirty_writeback_interval;
>  extern unsigned int dirty_expire_interval;
>  extern int laptop_mode;
> +extern int skipexec_enabled;
>
>  void global_dirty_limits(unsigned long *pbackground, unsigned long *pdirty);
>  unsigned long wb_calc_thresh(struct bdi_writeback *wb, unsigned long thresh);
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index ccdeb0e84..e7c4a35ad 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -101,7 +101,6 @@ static unsigned long vm_dirty_bytes;
>   * The interval between `kupdate'-style writebacks
>   */
>  unsigned int dirty_writeback_interval = 5 * 100; /* centiseconds */
> -
>  EXPORT_SYMBOL_GPL(dirty_writeback_interval);
>
>  /*
> @@ -114,9 +113,11 @@ unsigned int dirty_expire_interval = 30 * 100; /* centiseconds */
>   * a full sync is triggered after this time elapses without any disk activity.
>   */
>  int laptop_mode;
> -
>  EXPORT_SYMBOL(laptop_mode);
>
> +int skipexec_enabled;
> +EXPORT_SYMBOL(skipexec_enabled);
> +
>  /* End of sysctl-exported parameters */
>
>  struct wb_domain global_wb_domain;
> @@ -2334,6 +2335,15 @@ static const struct ctl_table vm_page_writeback_sysctls[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec_jiffies,
>  	},
> +	{
> +		.procname	= "skipexec_enabled",
> +		.data		= &skipexec_enabled,
> +		.maxlen		= sizeof(skipexec_enabled),
> +		.mode		= 0644,
> +		.proc_handler	= proc_dointvec_minmax,
> +		.extra1		= SYSCTL_ZERO,
> +		.extra2		= SYSCTL_ONE,
> +	},
>  };
>  #endif
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index f955f02d5..5f528a03a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1864,6 +1864,9 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>  	unsigned long hsz = 0;
>  	int ptes = 0;
>
> +	if ((flags & TTU_SKIP_EXEC) && (vma->vm_flags & VM_EXEC))
> +		return false;
> +
>  	/*
>  	 * When racing against e.g. zap_pte_range() on another cpu,
>  	 * in between its ptep_get_and_clear_full() and folio_remove_rmap_*(),
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 670fe9fae..c9ca65aa9 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1350,6 +1350,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>
>  			if (folio_test_pmd_mappable(folio))
>  				flags |= TTU_SPLIT_HUGE_PMD;
> +			if (skipexec_enabled)
> +				flags |= TTU_SKIP_EXEC;
>  			/*
>  			 * Without TTU_SYNC, try_to_unmap will only begin to
>  			 * hold PTL from the first present PTE within a large
> --
> 2.34.1
>

Thanks, Lorenzo

