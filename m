Return-Path: <linux-fsdevel+bounces-27888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 122B7964AEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E1A288A33
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 16:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACF41AD3E2;
	Thu, 29 Aug 2024 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UYh+XtGn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KKob/VCs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EF11A2C0A;
	Thu, 29 Aug 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947323; cv=fail; b=cacFlreTk0RME6+FRVGUIY3skRXayRgZY2aAT/AbSz0kWbVb/tUbN213vm+s2XrA7xRtuX/hN0iYTQECqoK4rkeNIPcZmV7Nx5S+NRzC3+XPjKy7cAZFqwPV8QnnhRUhGa/Obbz0Y/2eWq2RPrYyXOxaJhyr2uJ2NQgJsc852dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947323; c=relaxed/simple;
	bh=HzO9lE2MntK6PRn1trO7olBm6qAkJ0JqinNy49JM4Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cDzNvgp4zuqO20ueM3i2H7nZp6x1xrYEklda1Bzz/IzlFq+YrT/n16xYhbCB9cFxCwoh6spztMn6ufPOONI9598Gjy4/qyiOJlujEqD4veU0sb7YxAGatFacYI8zc4zSmz12UoQG3up6Y84TOan1bWqgms+9XpruAm0VZYP+prs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UYh+XtGn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KKob/VCs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFKA57032574;
	Thu, 29 Aug 2024 16:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=vgTizOus9IRHvG6
	FZu2RayyJhoEWROK72GdPG0LT3Zc=; b=UYh+XtGnDnXL+Jdxd9FDiIn+yu+9q6A
	OyIKHaaOTyvs952XyoBVMOU04E6ilsg6gmHKbMlZfu9/gL0mt4Xtcp1vA4wCjMST
	1Cg3CX3QdeI6DltglXPc+j1FXFK3xWgbw2q+wFWI5t6Y5wQeehlQqAwOxYpoG8gF
	STrY1LycwH4wPFJAdhA5zITYQF0+wn88BRGEFdH/zpYmPWgEmxZG1/efXKl1lK2c
	mVxEMItXEQnRK+ZhdjmJDGq1RpIpQQv+ZPFPwSxEiwR9fRDBqmfmlU+dZZEymLIo
	iyYtOwSHDifcmY3ZbNYOIQtdevADOmfmr8dWqpNSc7L3x8RmWaZxESw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41arbt0kcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:01:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TFe7IW016635;
	Thu, 29 Aug 2024 16:01:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 418a5vau08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 16:01:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ee1TY0GiZOnvhCqPHcw3Ilen+iedLCW9ueMgytZ790l5fmIzYwFLw///U0JHO6XrnPUUy8uGbyblWZIhSbM/9bchXjQWCadpdkeHaLFzAc4559D++K+r9WAeqsRT8P/6t+5IWRFn7e+wgejJzjqsFKxvwchHaTNyMSsHRUS4GeZa3CANH23Reei26s2nV/bXyCMkmcGealhWLHlt3JGsAL+fHjT0mb+H06O5dqPtYRhqvwM7WxdQB6V6clRA3aCDrVckcflkxmIP7z5IuUQrtQbFD4CljaRE6R0cz29RtQLPh7ZcZ03jCCnxJ+jx/6GKncr7KSV5xWbC25Ph9Jhb0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vgTizOus9IRHvG6FZu2RayyJhoEWROK72GdPG0LT3Zc=;
 b=cQ6z5FpkZJvPUBh7UlCzMoGlKsS6ADrZL75YdOw3QJeC35kNZrcQArG7il3qrBDHWUzSV0u4b7/XQiJNVml/KL47MJHqbZzx5whCJgNrD1Aal3LpXGDxNucyjkDqgU+5gqf7Y2AkHQHKRy2nHLZ+AZhvs6RF6e+iJKfqVtk1Si9H0Fi3xA/5XIT6vWkCtmBENByM6X6JsMYjmQaedBt8J3TYCat0DbHofyWwDLknq/RsPp96GO6vNbJtvzu46d6vnyOmAC5hXroJGHlzdc+YwObWDnf1M/lt7MLbiXpwknKqWooWKSq6PQrVauYQiIR99U7qP/djgnsjiloT9tf0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vgTizOus9IRHvG6FZu2RayyJhoEWROK72GdPG0LT3Zc=;
 b=KKob/VCsfm+rHwknrbzMaZMIpgdf0dOlWeIXiVVRSDZIzoBEBnUiMwyApO+x1fuA+ti9fnnwMwNUBoL6iymE+aqRC4R8IC+2g6MVRf3JZiWMPsSJzUMUe+BZrYmP59aiICoeZolx9i4vB/0IalI19zREgfjQcFCx4DIUaGF79ac=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.11; Thu, 29 Aug
 2024 16:01:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 16:01:46 +0000
Date: Thu, 29 Aug 2024 12:01:42 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 16/25] nfsd: add localio support
Message-ID: <ZtCbZtHG3iKqWIkF@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-17-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010424.83693-17-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR03CA0287.namprd03.prod.outlook.com
 (2603:10b6:610:e6::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 34529088-0346-4e91-0b6e-08dcc843e1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OU3yIcsKcvPn7XFaf3Hvp5z+lhcOR0lr9aEy12y5mHrZib3Ip3Xp31RmlKrd?=
 =?us-ascii?Q?s8k4Dqubh7wxmrqbSl8Z2eBn933aC6ZRxgGeCHPFjyLNTjA4hQM8Z7d+IGFH?=
 =?us-ascii?Q?yywHPzPDt+qieikeLD695Lq2OGHwy5scyj6nCtcjdQTVw9nNFFff27ED+2pZ?=
 =?us-ascii?Q?OnQeW7G+Xjh81bXTdA6AM1MJWexCICrVhTasC2SMc53obz8s/DhCgqmdodS0?=
 =?us-ascii?Q?Ix/9PJVDcMr7quWJbrTJWrWgemwZmqX3rq0lsTRviK6rleNZlnNZADi+dtUc?=
 =?us-ascii?Q?NDn6CxU/NnOQcWxJF94UmQdbLTr+HR3A/6APBo+7mrcCPfUOyXaWmBkaacux?=
 =?us-ascii?Q?5VEQGrOvHKCj5+Qp/aIITeEQkoRhyJ6mbwIVYE9KlElv6l4wNEJ/yYeQcwCk?=
 =?us-ascii?Q?05w/EXsvs09IV9oS1EwJp0YlYDNqF6nQsE1Kp5VYzqXdWRJejuMIFTY3RHVV?=
 =?us-ascii?Q?sGud6I+bE/j0xpuTZWFqwA/Ba2N/au5dnrJQ7pNFrSOw6/Cr+GQmhPyyg30m?=
 =?us-ascii?Q?EU1IeQ+5jiL53T3Sy7PtutE/qLvWkSdHvkP36yZIBus1MJjzDrJAtxeVssLw?=
 =?us-ascii?Q?zHPUt/fDQCDblNboKY9eEhQTFP2ek24n9DHKqACM1nTYPTut7s50IXC4iOzV?=
 =?us-ascii?Q?PMRRf6OdssSoYsYxIBcQCQO34RBYN5rIkzPuY568FiC9dIwbfdZLw7FvH4D/?=
 =?us-ascii?Q?4Bd5vZdkesPr1/RZ32gxfB1ivl7U8pMI4xJLfK4RbUt55qGfGKLdXkrnegI0?=
 =?us-ascii?Q?HTv+1zdDAwAcPYLXrjNTt5gpErZiPbnDnOMokdI+rYs6ni3lEYkziygCEjjn?=
 =?us-ascii?Q?skpnN+ubPqp6ihNuOwJVNyBTBjGYfEPl1JfHIeQopUZElAIkmFwLlS/PBabM?=
 =?us-ascii?Q?1SFP90+zPtibX2PRVZzWXDgdFHCgGSu0SVLHMbcwvZqm/VtJLr49meKtj24O?=
 =?us-ascii?Q?pR2J+aCpqkODJa4J0Tlv9I8L6vts0zfKCYMduwo39YH0UzLzAS6xrba0vuEs?=
 =?us-ascii?Q?0roiJNh4THu+pIOP0qAbFo0YHNrmTTllHAaflmTTtnII3Ype+poiSIcWcThh?=
 =?us-ascii?Q?9j/76E0Ro+OPiROTn58U+Y/LOb/l9e0LBGyMwKCTedPFh6v1Jd0UcVkWMAZ6?=
 =?us-ascii?Q?eh1T5a1iq4IKBje1tg+WSdUiL2mWLmuhcImaLSZZxkWUsXGUDmLV9Cwfntb1?=
 =?us-ascii?Q?lFKGoxEGynCz+Q9hO4TG3iYcTgu8W2T9C18l19cB++WZdBEF5vVQInsy8Uci?=
 =?us-ascii?Q?UDI1nIvyToGpLD2Uo4b4msXfUARC22oBfGH1yeyynoPbyXCBs7xK2TfIBHH9?=
 =?us-ascii?Q?pHUrGEFFG5m/8k64VSLFTIpFHJnQ9UOkrKXmHOR7uZA0Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W0JA9mfTb2jh650DNfYUgIFFvtLs5KDKuLCx9Jjrm239StKgkqPEt03Kwd58?=
 =?us-ascii?Q?/iMyJxLpvY31QxnYdZq85SJFR7H7sXVsVUc+l0plUsuZcgGjcRVKpMkkG0iw?=
 =?us-ascii?Q?zG6a+q5zOJfCtmezR2LKkvipaDHKCxs8VgLLO7qSkKkCgTnmSwehkuCc/RjO?=
 =?us-ascii?Q?bWbDwN0kbvq1ATz9TFcDwP8tCDNciYuc2zfJkmGCyIKh2Q9ZQZACqOqoiEwW?=
 =?us-ascii?Q?dGJnVDUUk3y7Wwe9d5b1bq9Pdq+IqbblvkHqxZ8puNgwasV8vrg3+VTyMpti?=
 =?us-ascii?Q?vO7J6rm+RBWfyzYY5w1mkfkTr7rhUStqcIEQqEV72zGgrygEWfMpZlDh0fl3?=
 =?us-ascii?Q?JHOQWfzbjUPheaHXAOPdeHCqlRF1exI7XZRZO5ZHV/F78S2a1jTKVJq8mOXu?=
 =?us-ascii?Q?o+PwThhc+iIrPdYrcbXhibapJ8XSPGfm2fscpYcQfaAXB+g0WRiB7geZQsXw?=
 =?us-ascii?Q?2cCR7rEOPtRhWTd+1Dltqa0vqU/YWDg3aalqDYIWeLDoor2QLwPETw0XF8bm?=
 =?us-ascii?Q?pqI55Do/UTZHmM0CaEn4zoj8jaZJAdWRfGGn534H3+I0M5gfWjYqxUg9sAR6?=
 =?us-ascii?Q?aj2GsIrCME0x2njRZkk5uQgfeOGQETugN5ZdAIi2vnutS+d96jAd77ogqc1n?=
 =?us-ascii?Q?CvhG2U5/gj0MQYEH7nNHURoR8Nl1uOArG0NZV7pP2e0mCBmy/KG3xH8x3WHO?=
 =?us-ascii?Q?2G1wjt4pudgzzMfMHxJLK2ur/vJqILgXWlHC/JTUgZIp20WjlZTCNjKQdw1l?=
 =?us-ascii?Q?TE29yJVdyg9aYAPJrhqOVeHDEijNQ7AmdewWsTY8tPPLCDdOdZggci2S87Ak?=
 =?us-ascii?Q?69OyXc6G1iWUK3oe1Q5+ajYuifqGWtbFlCk3jsAWZr6L2YxqAQCfyN/b3PSf?=
 =?us-ascii?Q?zF72lwFjr9QS7/rZHlWHOGfOmRN4Y2ERLgR1k0bBIV+4Lys0OgIzKyxMTJ/7?=
 =?us-ascii?Q?Niq2hytDt8fOwCWA372taMNDr6skTFvnbtWu1mlZfyuch3K/RXe6lWIYe+q6?=
 =?us-ascii?Q?H3RvHSYGB1IUNMuW5jsd3TIyspruWKr5qztlHktmKLZGvVFBr55mp+wn4Ftu?=
 =?us-ascii?Q?SH9LuHdJ2Te3D6SmokOQw+KVjEMz975WPlNNJcOUD7Aw7JQYWvbqZzadjt5D?=
 =?us-ascii?Q?NIUBctEorK5DAyGwH6CT7B2+iDt2G0c+CeNR9vh7FDnt1KSGmaO0L2UmA/46?=
 =?us-ascii?Q?M1v33jR1ZXF6Sp2Ct+U9cTFZwuWINLkKNdOAPqteaBgmOwypdRnzrsNd8kgJ?=
 =?us-ascii?Q?mPnjY5xm4Iy/ZveWvhkXrN6Mm7sEv56h1z55lXW1dIcY9MBqfxVHBVsLSVTJ?=
 =?us-ascii?Q?S2MlI22ZJVtsZQM+lc7K/dQJSuruy/vsw61c5YLAU+AAY+mucha2SAb7W0gb?=
 =?us-ascii?Q?33anZ1zmH+Ei6U1V26R8P3tUU3k+DMDUjLvUp1sN63guGfbvKmFyt0pFKYHI?=
 =?us-ascii?Q?XaQnLFcs9x4Cx6X9mZUDRFl7Sz3m5i4gEMkyT2JKFQF6Z+Ja1ZbKOSSBNAGo?=
 =?us-ascii?Q?srTYmNpwJDpx3Vd6k5K3YndP0wtf20WIe4fchlQ514+w/HdgVq1hjNBISnPU?=
 =?us-ascii?Q?DbzTYTwha2+XY8JYef0qq4at6MIlvpXmrVPSbxqLsFuKTBAd1H2GCzPb0yw5?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XLPKgGX9FnjUm/ECDlQi3/XrCDvu9i8FGPtcBy8wFLiq9q8dddY3Ok/6d4Q2bkLT5WMxs/d5iFzQeIXVYP0NFmOnVZ210k5elTZy82R/zPnNGBJV5u8ExJN0r6vA4dUZbR1HkKapmtFEevmiXmaOnso14oB7V66lcnv42eCBByuKmeXyz44bw/NqW3WdrfrU3o4SZ4gF2tCqwLs2qOEqaBt0HjLNYwXDn0bsHfHmweWDlmtVV4keC4Vca/Io9XjkbbAy2/VHeQxIVy2whY1k7fG3zqo/YdVc+en5ns3EZkkM146XzmNpMcO5FVHp4Jj4My9GMUcscMFDgMIvSmzGzGzz3vEWLOpJ0lgPOdcl7kscpKOASJJRdAc5dGroXAXGUp9GkXA74c5gVxBtP/oztQOAOy1wXZX0MNzapYffB6by3NSC2PQav9GdU9yvp5AkNAsizYuKPFICqb12HHL25QEg6sJDM5a7HC1C8SGg7xQS28BUYinS8RnR07r33iSjpNKVYDE+McVZFWLrTP3SaTPHWsYuZNd1Z2+StDx54t7VRQLd1w0Q0kHVZ3GUmjeUJNqkP/ChQkob7DBAieNI0v94Utxw4hG7oG7K9Hk9r3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34529088-0346-4e91-0b6e-08dcc843e1f9
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 16:01:46.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfHjtlsNjTChDKmmZ+BN1ekC/ZshiAhq1giWO5Yz0AxGdhQEiWc4CX+s/i/pXxtIsr+2aUztzWJr92dIRUfENQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290112
X-Proofpoint-ORIG-GUID: K2wxmpLbQIW051DEJwN7wDekkaHIIeJd
X-Proofpoint-GUID: K2wxmpLbQIW051DEJwN7wDekkaHIIeJd

On Wed, Aug 28, 2024 at 09:04:11PM -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
> 
> Add server support for bypassing NFS for localhost reads, writes, and
> commits. This is only useful when both the client and server are
> running on the same host.
> 
> If nfsd_open_local_fh() fails then the NFS client will both retry and
> fallback to normal network-based read, write and commit operations if
> localio is no longer supported.
> 
> Care is taken to ensure the same NFS security mechanisms are used
> (authentication, etc) regardless of whether localio or regular NFS
> access is used.  The auth_domain established as part of the traditional
> NFS client access to the NFS server is also used for localio.  Store
> auth_domain for localio in nfsd_uuid_t and transfer it to the client
> if it is local to the server.
> 
> Relative to containers, localio gives the client access to the network
> namespace the server has.  This is required to allow the client to
> access the server's per-namespace nfsd_net struct.
> 
> CONFIG_NFSD_LOCALIO controls the server enablement for localio.
> A later commit will add CONFIG_NFS_LOCALIO to allow the client
> enablement.
> 
> This commit also introduces the use of nfsd's percpu_ref to interlock
> nfsd_destroy_serv and nfsd_open_local_fh, to ensure nn->nfsd_serv is
> not destroyed while in use by nfsd_open_local_fh, and warrants a more
> detailed explanation:
> 
> nfsd_open_local_fh uses nfsd_serv_try_get before opening its file
> handle and then the reference must be dropped by the caller using
> nfsd_serv_put (via nfs_localio_ctx_free).
> 
> This "interlock" working relies heavily on nfsd_open_local_fh()'s
> maybe_get_net() safely dealing with the possibility that the struct
> net (and nfsd_net by association) may have been destroyed by
> nfsd_destroy_serv() via nfsd_shutdown_net().
> 
> Verified to fix an easy to hit crash that would occur if an nfsd
> instance running in a container, with a localio client mounted, is
> shutdown. Upon restart of the container and associated nfsd the client
> would go on to crash due to NULL pointer dereference that occuured due
> to the nfs client's localio attempting to nfsd_open_local_fh(), using
> nn->nfsd_serv, without having a proper reference on nn->nfsd_serv.
> 
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  fs/Kconfig          |   3 ++
>  fs/nfsd/Kconfig     |  16 +++++++
>  fs/nfsd/Makefile    |   1 +
>  fs/nfsd/filecache.c |   2 +-
>  fs/nfsd/localio.c   | 105 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/nfsd/trace.h     |   3 +-
>  fs/nfsd/vfs.h       |   7 +++
>  7 files changed, 135 insertions(+), 2 deletions(-)
>  create mode 100644 fs/nfsd/localio.c
> 
> diff --git a/fs/Kconfig b/fs/Kconfig
> index a46b0cbc4d8f..1b8a5edbddff 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -377,6 +377,9 @@ config NFS_ACL_SUPPORT
>  	tristate
>  	select FS_POSIX_ACL
>  
> +config NFS_COMMON_LOCALIO_SUPPORT
> +	bool
> +
>  config NFS_COMMON
>  	bool
>  	depends on NFSD || NFS_FS || LOCKD
> diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
> index c0bd1509ccd4..e6fa7eaa1db0 100644
> --- a/fs/nfsd/Kconfig
> +++ b/fs/nfsd/Kconfig
> @@ -90,6 +90,22 @@ config NFSD_V4
>  
>  	  If unsure, say N.
>  
> +config NFSD_LOCALIO
> +	bool "NFS server support for the LOCALIO auxiliary protocol"
> +	depends on NFSD
> +	select NFS_COMMON_LOCALIO_SUPPORT
> +	default n
> +	help
> +	  Some NFS servers support an auxiliary NFS LOCALIO protocol
> +	  that is not an official part of the NFS protocol.
> +
> +	  This option enables support for the LOCALIO protocol in the
> +	  kernel's NFS server.  Enable this to permit local NFS clients
> +	  to bypass the network when issuing reads and writes to the
> +	  local NFS server.
> +
> +	  If unsure, say N.
> +
>  config NFSD_PNFS
>  	bool
>  
> diff --git a/fs/nfsd/Makefile b/fs/nfsd/Makefile
> index b8736a82e57c..78b421778a79 100644
> --- a/fs/nfsd/Makefile
> +++ b/fs/nfsd/Makefile
> @@ -23,3 +23,4 @@ nfsd-$(CONFIG_NFSD_PNFS) += nfs4layouts.o
>  nfsd-$(CONFIG_NFSD_BLOCKLAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_SCSILAYOUT) += blocklayout.o blocklayoutxdr.o
>  nfsd-$(CONFIG_NFSD_FLEXFILELAYOUT) += flexfilelayout.o flexfilelayoutxdr.o
> +nfsd-$(CONFIG_NFSD_LOCALIO) += localio.o
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index a83d469bca6b..49f4aab3208a 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -53,7 +53,7 @@
>  #define NFSD_FILE_CACHE_UP		     (0)
>  
>  /* We only care about NFSD_MAY_READ/WRITE for this cache */
> -#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE)
> +#define NFSD_FILE_MAY_MASK	(NFSD_MAY_READ|NFSD_MAY_WRITE|NFSD_MAY_LOCALIO)
>  
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_cache_hits);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_acquisitions);
> diff --git a/fs/nfsd/localio.c b/fs/nfsd/localio.c
> new file mode 100644
> index 000000000000..4b65c66be129
> --- /dev/null
> +++ b/fs/nfsd/localio.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NFS server support for local clients to bypass network stack
> + *
> + * Copyright (C) 2014 Weston Andros Adamson <dros@primarydata.com>
> + * Copyright (C) 2019 Trond Myklebust <trond.myklebust@hammerspace.com>
> + * Copyright (C) 2024 Mike Snitzer <snitzer@hammerspace.com>
> + */
> +
> +#include <linux/exportfs.h>
> +#include <linux/sunrpc/svcauth.h>
> +#include <linux/sunrpc/clnt.h>
> +#include <linux/nfs.h>
> +#include <linux/nfs_common.h>
> +#include <linux/nfslocalio.h>
> +#include <linux/string.h>
> +
> +#include "nfsd.h"
> +#include "vfs.h"
> +#include "netns.h"
> +#include "filecache.h"
> +
> +/**
> + * nfsd_open_local_fh - lookup a local filehandle @nfs_fh and map to nfsd_file
> + *
> + * @cl_nfssvc_net: the 'struct net' to use to get the proper nfsd_net
> + * @cl_nfssvc_dom: the 'struct auth_domain' required for localio access
> + * @rpc_clnt: rpc_clnt that the client established, used for sockaddr and cred
> + * @cred: cred that the client established
> + * @nfs_fh: filehandle to lookup
> + * @fmode: fmode_t to use for open
> + *
> + * This function maps a local fh to a path on a local filesystem.
> + * This is useful when the nfs client has the local server mounted - it can
> + * avoid all the NFS overhead with reads, writes and commits.
> + *
> + * On successful return, returned nfs_localio_ctx will have its nfsd_file and
> + * nfsd_net members set. Caller is responsible for calling nfsd_file_put and
> + * nfsd_serv_put (via nfs_localio_ctx_free).
> + */
> +struct nfs_localio_ctx *
> +nfsd_open_local_fh(struct net *cl_nfssvc_net, struct auth_domain *cl_nfssvc_dom,
> +		   struct rpc_clnt *rpc_clnt, const struct cred *cred,
> +		   const struct nfs_fh *nfs_fh, const fmode_t fmode)
> +{
> +	int mayflags = NFSD_MAY_LOCALIO;
> +	int status = 0;
> +	struct nfsd_net *nn;
> +	struct svc_cred rq_cred;
> +	struct svc_fh fh;
> +	struct nfs_localio_ctx *localio;
> +	__be32 beres;
> +
> +	if (nfs_fh->size > NFS4_FHSIZE)
> +		return ERR_PTR(-EINVAL);
> +
> +	localio = nfs_localio_ctx_alloc();
> +	if (!localio)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * Not running in nfsd context, so must safely get reference on nfsd_serv.
> +	 * But the server may already be shutting down, if so disallow new localio.
> +	 */
> +	nn = net_generic(cl_nfssvc_net, nfsd_net_id);
> +	if (unlikely(!nfsd_serv_try_get(nn))) {
> +		status = -ENXIO;
> +		goto out_nfsd_serv;
> +	}
> +
> +	/* nfs_fh -> svc_fh */
> +	fh_init(&fh, NFS4_FHSIZE);
> +	fh.fh_handle.fh_size = nfs_fh->size;
> +	memcpy(fh.fh_handle.fh_raw, nfs_fh->data, nfs_fh->size);
> +
> +	if (fmode & FMODE_READ)
> +		mayflags |= NFSD_MAY_READ;
> +	if (fmode & FMODE_WRITE)
> +		mayflags |= NFSD_MAY_WRITE;
> +
> +	svcauth_map_clnt_to_svc_cred_local(rpc_clnt, cred, &rq_cred);
> +
> +	beres = nfsd_file_acquire_local(cl_nfssvc_net, &rq_cred, cl_nfssvc_dom,
> +					&fh, mayflags, &localio->nf);
> +	if (beres) {
> +		status = nfs_stat_to_errno(be32_to_cpu(beres));
> +		goto out_fh_put;
> +	}
> +	localio->nn = nn;
> +
> +out_fh_put:
> +	fh_put(&fh);
> +	if (rq_cred.cr_group_info)
> +		put_group_info(rq_cred.cr_group_info);
> +out_nfsd_serv:
> +	if (status) {
> +		nfs_localio_ctx_free(localio);
> +		return ERR_PTR(status);
> +	}
> +	return localio;
> +}
> +EXPORT_SYMBOL_GPL(nfsd_open_local_fh);
> +
> +/* Compile time type checking, not used by anything */
> +static nfs_to_nfsd_open_local_fh_t __maybe_unused nfsd_open_local_fh_typecheck = nfsd_open_local_fh;
> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> index d22027e23761..82bcefcd1f21 100644
> --- a/fs/nfsd/trace.h
> +++ b/fs/nfsd/trace.h
> @@ -86,7 +86,8 @@ DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
>  		{ NFSD_MAY_NOT_BREAK_LEASE,	"NOT_BREAK_LEASE" },	\
>  		{ NFSD_MAY_BYPASS_GSS,		"BYPASS_GSS" },		\
>  		{ NFSD_MAY_READ_IF_EXEC,	"READ_IF_EXEC" },	\
> -		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" })
> +		{ NFSD_MAY_64BIT_COOKIE,	"64BIT_COOKIE" },	\
> +		{ NFSD_MAY_LOCALIO,		"LOCALIO" })
>  
>  TRACE_EVENT(nfsd_compound,
>  	TP_PROTO(
> diff --git a/fs/nfsd/vfs.h b/fs/nfsd/vfs.h
> index 01947561d375..e12310dd5f4c 100644
> --- a/fs/nfsd/vfs.h
> +++ b/fs/nfsd/vfs.h
> @@ -33,6 +33,8 @@
>  
>  #define NFSD_MAY_64BIT_COOKIE		0x1000 /* 64 bit readdir cookies for >= NFSv3 */
>  
> +#define NFSD_MAY_LOCALIO		0x2000 /* for tracing, reflects when localio used */
> +
>  #define NFSD_MAY_CREATE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE)
>  #define NFSD_MAY_REMOVE		(NFSD_MAY_EXEC|NFSD_MAY_WRITE|NFSD_MAY_TRUNC)
>  
> @@ -158,6 +160,11 @@ __be32		nfsd_permission(struct svc_cred *cred, struct svc_export *exp,
>  
>  void		nfsd_filp_close(struct file *fp);
>  
> +struct nfs_localio_ctx *
> +nfsd_open_local_fh(struct net *, struct auth_domain *,
> +		   struct rpc_clnt *, const struct cred *,
> +		   const struct nfs_fh *, const fmode_t);
> +
>  static inline int fh_want_write(struct svc_fh *fh)
>  {
>  	int ret;
> -- 
> 2.44.0
> 

Acked-by: Chuck Lever <chuck.lever@oracle.com>

I think I've looked at all the server-side changes now. I don't see
any issues that block merging this series.

Two follow-ups:

I haven't heard an answer to my question about how export options
that translate RPC user IDs might behave for LOCALIO operations
(eg. root_squash, all_squash). Test results, design points,
NEEDS_WORK, etc.

Someone should try out the trace points that we neutered in
fh_verify() before this set gets applied.


-- 
Chuck Lever

