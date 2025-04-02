Return-Path: <linux-fsdevel+bounces-45488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D703A78725
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 06:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43D923ABFBF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 04:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763DD230988;
	Wed,  2 Apr 2025 04:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwg2bXYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hY9jsj+A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52561581F8;
	Wed,  2 Apr 2025 04:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743567335; cv=fail; b=BgtuoIySeHNPylgx0+QbduLU+wTKCXwZC3Ee1WSQzqFx6knInH2TpcEuijMlNp6/K7YoqLnYEE0/Rp9ojMDNoEV2MVWqvrM5T/PmU2FtDbzuZZFWOW0nMvLAwHAuduznZvCE1bjZPZdwidUkd/F5NEvimrnKO71Rpkx4S2QIdKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743567335; c=relaxed/simple;
	bh=I5H+AIgnpiFVeqBgabHZFGp7XvnYvTTWP3uoWY73yfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L/sQ0sxAGT56RQ9mDIUJgjx2/5PKlFy3lHChfDYflOl7nAqUsqXbD4bUv9Mv7hmD5DJrTP72uw3SNEPVuoORMb5bafEqMilT2awq6h8WevmLKcU/pHbucsmqCx0hqGP/FZwG1yZSs8lmmAHKGIt9/fB01wR5vu77Lj367bmWTm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cwg2bXYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hY9jsj+A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 531L2TK6007213;
	Wed, 2 Apr 2025 04:15:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7ZSQByRaM0Hg26qKtr
	CBNIcVOwGm6iUbslIjvphVy9c=; b=cwg2bXYcvtPX+YO1Fz+ublhNZYVRvTGPBf
	ILKvRqZFdO4sCQ4JGorkBA4FAuW9SrboB/NxWiEp8KyijgGVi9Foppq0kIYmq2Wq
	tTUwqVSY1EvCHim7avqpBlCGpqk0z/W5Rf3FZSBsDoJPS/zLFB6TbiATTMB69i51
	peG7tsaBcDwTcHeF+R3/w+ZstrQAYHNaN/+0izWkfoINnIah1xaCNFsmjPCcnlR4
	cg7k45aafXrCurLt75YgzPaPbMF25FDzSxdoYzbJ+93It8gIYi0I768+Rce5sFhb
	zinNaclibxT7A+lRBYUXuFKf0atLcNVPminfOR9G25tJU7kQiClA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8fs9vxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 04:15:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53241xbD032623;
	Wed, 2 Apr 2025 04:15:22 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7aa9jeu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 04:15:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDfUX8RFDrAcghWhZocmaP6HUSD561hTsLYGlZBSX0qHmV2zcry51WIZJF+YnNq2VmbJoxvTxRFyrItSDiqQOeVap9XqxFdxBZrRbuKbbWafybToik2x8kvSAsf37HuawFvc5Ux5IzelYumcjUBKKFPZsMSJrgvKOnF6O/vr7FUv6RbrKH1U7sl//I3Ozi6uDmdbXBaa0hKw//E0k2iicFhPQ4vrG/bEv25SMDvFyX6mFo6vToOAQpko9JyWI3FEbuf0v03a1jS2PTLjVvJAKNNUcISYKK0IcdhlBZP7AjpZTxIc7dJXPzpU6pt7iVo4YkqUL3lQhJQPBY1vnRWrNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZSQByRaM0Hg26qKtrCBNIcVOwGm6iUbslIjvphVy9c=;
 b=wkZ2ef0RhcWeCywxuP/sl8ezbcKvMsOuaC5+/Ay9MG/19BqUUombpW+eIthOB+dpo4SlkXRxaf5KqF7EQXphVyTdVj2BEQj7qFhcG1u/rhWj8umKQi8JyWPyzDoO3wFuED6HAsFgXJGTC1wR3PLl/9jkw8bGdfjMkO4kBEYeksVVN5Nj3lRLZfTxcGB4POliKfVv8V1s+NB6XockiiYYEBDDHdLSoQlRqOS7dRDfIh7dARQ5//Mrc7FFyNTellaEXWe+B1sAFJ8mhp6NMA4L/lSC5/Ry2xBh2GkvdEN1EaaQ+MnwKWrl5vo7joGD0hMJD9L4UmjicHSfU9Q7vzg6GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZSQByRaM0Hg26qKtrCBNIcVOwGm6iUbslIjvphVy9c=;
 b=hY9jsj+AWxTsGHAk3uiMaeLh84AiyBkKKDn19Qlt7NB3jPKWOpvfeQBQg+ZQeMnnAj+AVV8S+dvPOX8MOdKDTQETxqD/W2J3T6dfy+s9qhGIf62+9n2UVrilUkv0neOBVaqHs1y+uru8rYfbaYT51dyzX/SfkLEumZm06idvBhk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 04:15:20 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8583.038; Wed, 2 Apr 2025
 04:15:20 +0000
Date: Wed, 2 Apr 2025 13:15:14 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, joel.granados@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] proc: Avoid costly high-order page allocations when
 reading proc files
Message-ID: <Z-y50vEs_9MbjQhi@harry>
References: <20250401073046.51121-1-laoar.shao@gmail.com>
 <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3315D21B-0772-4312-BCFB-402F408B0EF6@kernel.org>
X-ClientProxiedBy: SE2P216CA0050.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef40114-5294-4e43-32a0-08dd719cfb1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ArRVjNOk3r8nM5fLCbxkRbMt7oa1DGLSmqMVsrjUMIIilmdw09l6yvaaXDn5?=
 =?us-ascii?Q?K4qFagujRtmlI0nv8V55ikYJbVkfOzxKGU9wrmOo7QPjiconAvO6EDy81eIp?=
 =?us-ascii?Q?3GE/pYDTD1n7WWbpTvGjwYBSJJNMzbw7DZUyzC0o7QjzPORy7cb6GYpTfUN6?=
 =?us-ascii?Q?lQUt8HagLQ6LcG1bO3Li4WPFgOUMTFN00WKtes/nHFSKLOJYPjLJO4d5pyA8?=
 =?us-ascii?Q?hACOP6TKFNLqiFcLvY30xKiKgAetr6P74auRPBvXwykht9K8CfuW4GwCQweJ?=
 =?us-ascii?Q?/M3pWGJAMGfer8ds/IFo6ofpHga1VrQa2kZycfid160/+RRzTqJtzPU33fUB?=
 =?us-ascii?Q?NOgoGSHtrmFInlr/HiaGoN4OTorvHkAvQM56gRCHObKbIJ4K+r4xhbQQefYo?=
 =?us-ascii?Q?kxSH8NsDdN1S4M+++AGm6UOCWVPz7J/r4YAma1Pg3VquCz96ztg7sgjQxrhL?=
 =?us-ascii?Q?Cn0/4zvw1ilb/SR4CnpaBQPs+zqKH7rfnNSK+z9zzL7Jyfx/w84HRShil5MQ?=
 =?us-ascii?Q?UnwA/u4Gf8IiYZAHxQYrI1APyVRCemYBqNv09HEGD/JPOPH4hUQqAI+8hyGL?=
 =?us-ascii?Q?P6OSDvjBdJQpdl8KM7T+aylp5perafn5of7Zga9FTWgcAqVE1529E0QAbFjq?=
 =?us-ascii?Q?byQgMXRkoQL070FfBMxDICYpP2x75PXGGAS5HRoRL2hYO7EJDECIXHqBHeij?=
 =?us-ascii?Q?ZKkDUWSH5zs4EBzo4Pk54/xc0OCRN6oTIIV23u1kPeNzsw75TdP64KTbauNi?=
 =?us-ascii?Q?KTS/U3oBqNNswYq9FFgFTsIfdyllHn42hu+pUr+bslYT7cahlq8mtMXb7unT?=
 =?us-ascii?Q?WBFiUWOg2AlDaG4v8paQ7g3UWH9v/5AeVE1po/7OZmB3vSSYUzylJZNENF+J?=
 =?us-ascii?Q?sGzwWMijTTJ83ncUcfPGNet3ndtYFcG2GoFFYsuqwOiUXPTPONbGtd1E76gz?=
 =?us-ascii?Q?tGb3n4k4ol2X6VTpmp++/6eYesOT6XDLg77lRJkJOl0pbBlwyTDlTfqODeA2?=
 =?us-ascii?Q?3QJN/1f22zOpJ5yzdIXMMjBOLQydwAc/Hx1ootGpBrSgmStcys0h/6IcYE5Z?=
 =?us-ascii?Q?hvyQaFDuOwYMo4Pp8aMZ5ugHn4tpLRzEETqZeuu6E+hHC1FYAOu2bJWUoQ9n?=
 =?us-ascii?Q?j4bHAobJsR4nFVb2XzVjOeI1z11aUOp2oa/f2jgUoG40KdkOaSelVGuuBwec?=
 =?us-ascii?Q?RjbyhUUBNk6U9qAv5BscL29juFFE3T/Uo8uMSSdfkP5J2+XLUJ8OgMkzHiif?=
 =?us-ascii?Q?ZriT/Z7mH3GYIymfoDf/qgXXEApvZnFKbBZaoNuT2HeB3YVobadeYgEM1ywR?=
 =?us-ascii?Q?cTkqVIpncySHY62oMMHzECpk58bN6qMP2ezY3KGBlm9AEB8oOntXm05nfv4v?=
 =?us-ascii?Q?0Sw+o4K2Tgh4ae39UOERDUxsH3LX41xRth5iXrx4DJWgZy8MJHDDTsnzoLSl?=
 =?us-ascii?Q?cR4AGNmyv0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nPIJq1rTZUr74eypA4n5bNqFCHom4y38Rtlv5uyOFC3873un8wL/0wAuouRG?=
 =?us-ascii?Q?sGiAKM6r/zmjvMAtTqS7c+zzuD0/5Ln7OJoWLzBQF/+mrf317844BFU2tXxZ?=
 =?us-ascii?Q?o1K+KcxJlofG42yaSjTC3BZLd/OdUVIzOXSqXSDiA3pYAXeAVWekrD3u3NVy?=
 =?us-ascii?Q?cqbrRHWvNxOmfJynkQmXkw1YuoPL51YQNgkXb2JJINhs6Fr08ZyDxQldbKkB?=
 =?us-ascii?Q?0Lb1ii4YL3Cuzh5V2a4zplbsdy5/H6oSxHCJLa/OCdNrwQLb5hILyNmOpJz5?=
 =?us-ascii?Q?YkXLfFzJ5mwOcS+HTa4NOrwdFGfXGKWLQQvntrPVekTS9OJWgCSUWdoeW1Bk?=
 =?us-ascii?Q?3CN4TiBv/ZI51ogjrhDuwD75rW7mQuZ/Dsy/8Q6SOFEr+kHx/RD8RXo0Kfgc?=
 =?us-ascii?Q?9b8a4VXZ4EKzVG4yYkIogQlwU3Q7WN7O0IwTtcoqcv+/uZuMit2EgMH0FTWo?=
 =?us-ascii?Q?W6SFuxoXM09usBnMeDaatoGRLpXmM0+VN6w3zVdtwmpxD5N5/rfhsrlrZrgo?=
 =?us-ascii?Q?LqWkaJO+TFBKL+0tYDXiKFCuVxRYX8XMYxt12EFo707rqRpkPmiTBI++agNv?=
 =?us-ascii?Q?0D52xiaQ6eqU5dcglWWgHkmTO/0UgtnIXZmeOsyVByBL+1Reu7kZDujDxFv8?=
 =?us-ascii?Q?rR3umEcCG3uaTiJ+iEnNDaQM2LnLKF3O8g9ONUS8CPmDOwWwoGPdBKaR9s3b?=
 =?us-ascii?Q?1umBkjO4EM3AQMOvGGF7u0x8rHYqRGiqN897bfmFpGoYxbaTok009Ru0ko5D?=
 =?us-ascii?Q?fb1uuQewzZXkozSdc6agosQxZ15D1BBRhgodGrhyHFFNdqK+opUxTy3CD/c/?=
 =?us-ascii?Q?OZdWzOF24zTI76EhbBd7Va+K9WuRMfhlBCWSWCQhfIanmteQHcDc3ERz7GG4?=
 =?us-ascii?Q?1worDP4yA+72D1+dgToUByN1gdY6HvHK3vWxfG28hQSBoxwx3GmuP1aAmk5r?=
 =?us-ascii?Q?dSjZyX69rRF40WyTSp+sh/Qk2MF1kmXscHngIed/YGYXmftslbB4LfWdn2V+?=
 =?us-ascii?Q?6/nKaXjGERp0zUZLHJaf7zifnbx6avQfHKqnkfnPjxqNr3KqBT9ztwnejlfY?=
 =?us-ascii?Q?7sck0ZHW8KQq6torOr6uMJ0RgcYmgj/5FX33kWt8WY62NxD3shP7RYLQJE96?=
 =?us-ascii?Q?t/W86f46svbEA/AL/WhrjoDtdZ2CBiS+6OIDPRkvpZ9K44WLmA9J0OYi3JGj?=
 =?us-ascii?Q?b8//Q6swHGlS2Dz76ELThwZZv2wVAiTI2E8WXdJR7J4vzfBvQ6Tqn9BQ17xC?=
 =?us-ascii?Q?pue5liW/Sc1lL9jeDMkPFiFvVoiiOKbXXkZ5sLGtloRiHdC+J/xBXmXrvyin?=
 =?us-ascii?Q?2aI1FqJm1gXeUDicQQGFG4Gr+2Kt3DMP1/VOcFQPRyVWZrjzNEn18VHEDmw1?=
 =?us-ascii?Q?PEWMiRZBKNeA7WtFUr4zpNiagbYYIImAIDl6mvqvk1TkNW5D2Aa3htlOAhHj?=
 =?us-ascii?Q?8FftoC7CP8K8b0B9m04AQF8O+sIhbj4lSTkvdrgGAIyFd3bQ+lLFk5inu7XJ?=
 =?us-ascii?Q?pBNdC3rE+4vszeev8VBxczlMfAaYu4adWsrA6hKFd+gCBGUm3ph/NbD4HoN3?=
 =?us-ascii?Q?SlGQrFe8Sgp5RBvqDyqIHuEuBGbsgh+18iQuj+s/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cbBn+C9ezSWVPMf79ZQZFDhnZjsg0emjGKUAasNJbFY+XBin7bZlDpnSTJQEmJ5sgtCQqxSKzttnCP9KyuZK8ST3LNVIN5mKfjIjntjiS+BDrHCNDwx8t9seOWUqcn6j58Gae3ZWjPH0BmcJHj21uvfwiHdqSP18pGv2+Gb7W99p9uPH+S2D7G9nwlzwVIso32fTXAzOrQXuQHBhRL+eF5L+Sf4Rr1ejtqecSXm5iy46EBwNGH0kJDk2ZJfRShxoxpAjZk66pRJbUT7R98Le+ltHb001jTvYsCbvQ/LVp+y4vygLmAIwfDjddPGNq6Jju/J/vah+a3Ubk0PmzVlOn4QjGdxt9mhv2DEOnXNktZNquxkDjfHSCyMJXhfAoB5JrwolbMZSc3BXy71N4YsiVy8UIKX1t25LPRhG/O6Xf3M5QT3P32WOjhWVG3s5eq5YY791jeHvqTVUSjWS6Hq4C722xzWobGQrrAehOYUDPOOpfuGH+/Z38F8TVezxQ3119sj02TTt7QUs1qwpZK9en5fWYtPHAJwsFHsl/8uqiM9Yuo0LV0x+Jx4kY5ljdjkzl81SuTCyDzHXz15ENPDGIYl4y9FcUvsetBAB4qJoLPY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef40114-5294-4e43-32a0-08dd719cfb1a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 04:15:20.1176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1llSKdAtSKD6gTQWgEZdseJJFBg+ipIG7WeTqDp+XZrOhjLsl0DrgTkbPlGwZV5RnMCMdwnHbdgbzdeNVchxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_02,2025-04-01_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=821 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504020024
X-Proofpoint-ORIG-GUID: PTnUU6kL25pPl5y_tQ6SfsnMVzNqY8yo
X-Proofpoint-GUID: PTnUU6kL25pPl5y_tQ6SfsnMVzNqY8yo

On Tue, Apr 01, 2025 at 07:01:04AM -0700, Kees Cook wrote:
> 
> 
> On April 1, 2025 12:30:46 AM PDT, Yafang Shao <laoar.shao@gmail.com> wrote:
> >While investigating a kcompactd 100% CPU utilization issue in production, I
> >observed frequent costly high-order (order-6) page allocations triggered by
> >proc file reads from monitoring tools. This can be reproduced with a simple
> >test case:
> >
> >  fd = open(PROC_FILE, O_RDONLY);
> >  size = read(fd, buff, 256KB);
> >  close(fd);
> >
> >Although we should modify the monitoring tools to use smaller buffer sizes,
> >we should also enhance the kernel to prevent these expensive high-order
> >allocations.
> >
> >Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >Cc: Josef Bacik <josef@toxicpanda.com>
> >---
> > fs/proc/proc_sysctl.c | 10 +++++++++-
> > 1 file changed, 9 insertions(+), 1 deletion(-)
> >
> >diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> >index cc9d74a06ff0..c53ba733bda5 100644
> >--- a/fs/proc/proc_sysctl.c
> >+++ b/fs/proc/proc_sysctl.c
> >@@ -581,7 +581,15 @@ static ssize_t proc_sys_call_handler(struct kiocb *iocb, struct iov_iter *iter,
> > 	error = -ENOMEM;
> > 	if (count >= KMALLOC_MAX_SIZE)
> > 		goto out;
> >-	kbuf = kvzalloc(count + 1, GFP_KERNEL);
> >+
> >+	/*
> >+	 * Use vmalloc if the count is too large to avoid costly high-order page
> >+	 * allocations.
> >+	 */
> >+	if (count < (PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
> >+		kbuf = kvzalloc(count + 1, GFP_KERNEL);
> 
> Why not move this check into kvmalloc family?

Hmm should this check really be in kvmalloc family?

I don't think users would expect kvmalloc() to implictly decide on using
vmalloc() without trying kmalloc() first, just because it's a high-order
allocation.

> >+	else
> >+		kbuf = vmalloc(count + 1);
> 
> You dropped the zeroing. This must be vzalloc.
> 
> > 	if (!kbuf)
> > 		goto out;
> > 
> 
> Alternatively, why not force count to be <PAGE_SIZE? What uses >PAGE_SIZE writes in proc/sys?
> 
> -Kees
> 
> -- 
> Kees Cook

-- 
Cheers,
Harry (formerly known as Hyeonggon)

