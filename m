Return-Path: <linux-fsdevel+bounces-35482-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5239D54B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 22:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFC8F281A77
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 21:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D750B1D041B;
	Thu, 21 Nov 2024 21:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AOXi0g0n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hQDUIe6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F0D19DF66
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Nov 2024 21:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224634; cv=fail; b=UsLdasnbIwgLCS2+G/MWPC0tcuVuQ9ZwTYovif8DKpYuuHJG0c0AvAlJSU8CcfzR4/g0Eljs87Wa4Oz6+VgsqX413T+zaypDWEFmSnRSWA/38Ey3fJj390nGcyQN7Iid5phTa8DBh8aZoU32TuyvOyvmk+crUQaZ3baZ6zoLy9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224634; c=relaxed/simple;
	bh=QSN4WNf3y3XvjTLSqBmp8u9ZR/Cz+xbbg4BrXkOckMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VYuLuj2nx3QaNIhwfYsFQOxCa83SHd1cVf61jGJmCbl+T1sASUTvhBP0sekzaT94+m6UHkXbhldz6xn1yr65/lBaeOL73YSgXqbvsrGBfBKWufGrbXAVq1wo1rRwX5qIuKtg39PN8gCo7JXqk3d9FNjBugvL+4e+UmnEkFV/mgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AOXi0g0n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hQDUIe6e; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALIBfWg014299;
	Thu, 21 Nov 2024 21:30:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=fZjfOyKgmBATyssfwm
	fiMF+LnsgwIsTdn3euSdolVb8=; b=AOXi0g0nOJkKjXMBOfebbfvRadhaXLKjMz
	aNgLzD8S8Wa/EPQJgJ+QXTl8pHmaQCgIT1u8owrO4zdMpgnJnEMmgCR9tYYttVbS
	osJEDauLHNjta0fEVWAAB2PBlbz3i6ql/2rWkhWbBEYZlv9Gbw+X65Dg0yHVCB/Y
	nUQxBQCrRFrKVrXYxZlLtFMPU/+D+vZCPknOF8or7Kh3cxXWin2qbTIv7crfzN4l
	RyATHgRztrJ1yIyQIZm/vbh520Wixz+vMkNRsIgE9j4OApElipMmv22nDD/twLn7
	UaCKRlbhKymvHsL3Dp39JvLv5U8H7LQRRNAAGKeBlJKoi/asb6Vw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xk0strm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 21:30:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ALKjTf8037199;
	Thu, 21 Nov 2024 21:30:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhucf7ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Nov 2024 21:30:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VR8+D8TDCZPEGvWweHDIeRVEJZlNvws2dILqglEt6EoJZO3DewyMubM0evikLNKqjyRrtyLetC6F1h+dqea6Y17ykrou8AVbUWcpU2NdoRFQ3vuavEuEeHynxIKmw79Ls3dGbeLI7r/O1veq+tMqJOley2YEQyz2DewqRXFwA/0fL7OUBDm5xolAywj8jvOdaTNQMnmnWmBRocVa368VrUEhfgRwzOqoXhZ/Ly6KaRuN7/1Kw3/yyTZF+GMKPzSWs9uz+lAzQPsCJL+MONpL2epuLNJFAu5R1SOfPXTLlKuaBm7rQcLNjgan1Q0DJHMpuCkhVclQk7fYXkfqBEPl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZjfOyKgmBATyssfwmfiMF+LnsgwIsTdn3euSdolVb8=;
 b=Gz9V9V/Hl6XA/4N705xy7E8GAfYySpcBdUbvrnWbIEFktOYALlkNzmlHXu5MFIMQMMJohBoGoOb2xwyyxs9pePoy2qrjmgsmsb9QDzqNv9sMS6YwIcr1MbPy2Dtw1mR9+y+vYvXWxqnbMcRND8EhLkVWXLO3tTiKcx6W43yNvm4Oq/7c4aUHCLrWkRjndCsGXOFy6Sj14XFQ6FilOQgY98/rtB8jXVMLH8v31tAbiySL0zyCqntvpdDeCOK6kHxIBcqpsZYS05RhuxMYeqVRqsIOemQ+akYQPIDH1aTjC1KMl1CKs1mhRvm6kOe0BjQWxWubIBHrG6BirF8Jlf7Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZjfOyKgmBATyssfwmfiMF+LnsgwIsTdn3euSdolVb8=;
 b=hQDUIe6eztyUVOOoWhile6WDxlOz52wM2J9dK5l5E9o0Faa6QPFcmlqNn/rkSX99QUMT4L52+DZFoUcLekpEHsM2CBBkb1N8xC+6sMeLlS2X9Qf4fJea5n+JOmpuvQ1dYZEjBcCpWEscCLlUIikMMbdHz9mTOuIjIImvdRVs6ZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7742.namprd10.prod.outlook.com (2603:10b6:610:1ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Thu, 21 Nov
 2024 21:29:56 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 21:29:56 +0000
Date: Thu, 21 Nov 2024 16:29:52 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: Hugh Dickins <hughd@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <cel@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Daniel Gomez <da.gomez@samsung.com>, "yukuai (C)" <yukuai3@huawei.com>,
        "yangerkun@huaweicloud.com" <yangerkun@huaweicloud.com>
Subject: Re: [RFC PATCH 2/2] libfs: Improve behavior when directory offset
 values wrap
Message-ID: <Zz+mUNsraFF8B0bw@tissot.1015granger.net>
References: <20241117213206.1636438-1-cel@kernel.org>
 <20241117213206.1636438-3-cel@kernel.org>
 <c65399390e8d8d3c7985ecf464e63b30c824f685.camel@kernel.org>
 <ZzuqYeENJJrLMxwM@tissot.1015granger.net>
 <20241120-abzocken-senfglas-8047a54f1aba@brauner>
 <Zz36xlmSLal7cxx4@tissot.1015granger.net>
 <20241121-lesebrille-giert-ea85d2eb7637@brauner>
 <34F4206C-8C5F-4505-9E8F-2148E345B45E@oracle.com>
 <63377879-1b25-605e-43c6-1d1512f81526@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment
In-Reply-To: <63377879-1b25-605e-43c6-1d1512f81526@google.com>
X-ClientProxiedBy: CH0PR03CA0211.namprd03.prod.outlook.com
 (2603:10b6:610:e7::6) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: ea3329cc-3658-4d01-ce99-08dd0a73a46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SIJP6Pfr5PAG3jfOs/Yn1gKUZ/6Gf7CHODGhko+f336letFodTchERYRWfme?=
 =?us-ascii?Q?jdY9DXOqrLj8L7bMpyx+1or/7N3ZGXwqx+cmk2Biw1kZzl7qjHjm7O9Qz+kq?=
 =?us-ascii?Q?ye6yOvvO/yv/39e6v5CYAGrn5M0ZJkJwk4dQuQZCB73DZqPsw6okklyqAjV2?=
 =?us-ascii?Q?9YJcKB1voeN00i6ini/A1K4ywDoSXhquZC0YIG43ywRjhAbQTKihXWU6mgFE?=
 =?us-ascii?Q?tw5apG28E0VfyDmk0c4zBd4r6BcROSsNyY6YQiE54wao77fHVUvPZbXwIjZF?=
 =?us-ascii?Q?wv5a4r/83KJSfF8XXsSJjq7K52qBC1UTNfk9H3+jYnzYv8Bf6xCT2QAkOcsl?=
 =?us-ascii?Q?61rnwBn5kArtZpuGPuvsbAV8cgnjmto4/Ovf8gbbnLjpU6ONdoOl/xjRNPYl?=
 =?us-ascii?Q?gtwTXvDUepDZn7//lY90CtqN72XYcpiswKcJc4jvoFDDVsdA3vP4nUZr6s19?=
 =?us-ascii?Q?WCJ/+O4wEaIzh1MGpTU/BbTznVN6fIl6AmnsS3swTfpCxiGcb/TrYXsmPqx3?=
 =?us-ascii?Q?gXyy3jteZXlK2Idz2zfZ5aupGB6NAogN8cRrrdLKAmjNigB1HL38IBbey49z?=
 =?us-ascii?Q?le3bJzDaU/MNadcHoPyfky0yeB+tHiPNO6soXJs+Kx17VyAvVMuPuZ70NrEg?=
 =?us-ascii?Q?zfrmasjjLwt4lnlBBw8caYIRSp5z8vTIIvKnFQTruffGn3lXKDlkdVxRikHh?=
 =?us-ascii?Q?eoNDggkPsUL7j9S6GoR7V7HGYxrvUTmZrsDUdfIFAfHnY4nP/hHLxoD0VfqW?=
 =?us-ascii?Q?5xfZ9Vb4tXjAddRgNmDMfUKmR31N4y/fGGxkwrO6To4v3yGAAK3p2jO+YwwT?=
 =?us-ascii?Q?sPbxt+TIQwayIjGIKL+Cri7xNGXZCSm168r0d8zgTd32PwBlHUWspSY+d4Qm?=
 =?us-ascii?Q?u7hLdPYSrPK1Z5kQZqk+UvQbzFZ6tfZiMqA/Awm+aYR584QTJNJB2i0LnmJn?=
 =?us-ascii?Q?JSi8qu5WoMXgXL+zudrYNlrHfe1fjjijqgFcsaNnGgIyN14czhMACGEsb1xE?=
 =?us-ascii?Q?A0Z/iXUxLnhNq0YLqOcoyv9aC+ohAXRcV/IPclP/isTyVrE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sL05fUuaP5YY1X2UABdwFfRQuqyrvWppgTgn6kJFUY/kehc6r3fYEXd04Pg0?=
 =?us-ascii?Q?IfMySHMuajhJWc0jxGe4zvCpUnOb57ndtir2FwUYJVc2Lq1oGFGXppzPaS6/?=
 =?us-ascii?Q?ISKOv6IqlvKa1SGCmhH0htbaXc+aIx+1d2OmoZS1TcM1BpdekFzagaicfkrg?=
 =?us-ascii?Q?DyFXgYgm5OALyDSOrKWzj1Y065ZIMmExZPIOnijqkzYNFm3PsrIWnvpdFGd/?=
 =?us-ascii?Q?XE+1Yu2w8hVHi0kIogBUY5KqMUXxvveK6rBkniIzDwJk8JaFbuKMMZL7LbDR?=
 =?us-ascii?Q?e1XCa2emFO2tuTMnkawqJ0OduR129lEBsBtjab2X4GfUCRTYzGDp/O0JPkpI?=
 =?us-ascii?Q?SwTrz6UlhkJcEeyKZypnL9WuWbZuA1Nh5vlWDuUHQ/ZLNGjMwG54w+f7OIKc?=
 =?us-ascii?Q?QuFgteqcCqdEdx4bu8xZsK1LkDKBM6JZ+puPrpduPsQlrMb/G3bViLp/7nfU?=
 =?us-ascii?Q?knLQXVrWLU5vyXmUh3G73dwrn5NgICVrEYefYdPY/h0R5BLvcT89YfyFiPqb?=
 =?us-ascii?Q?B3Yq7McUuY6tBBV8jXNp00fqMQZ9+plJpeJ9UeWY9H42i60psxiVjsKMIrkf?=
 =?us-ascii?Q?k5iCd3j4+0Rpd6wtPdAeQlxzhN/c+Mmb2fSaQ2EFqY9+a/9bzpfIZvsivGeu?=
 =?us-ascii?Q?IMQxyLwuBvQ5VLsXsKZez+/3PkP0zZbmXON160IFfcB4lxtQtvhscM5emin4?=
 =?us-ascii?Q?w+26zj8iFDVGdifvzJ71GPMPLAnMUojds3JYVfasIvMb5ueaLvv4Ta/i0Tj+?=
 =?us-ascii?Q?CfVQ8jqRBgJYXpPtjG/HAZzvQ04X7go22Mgt9NWWtowjF/DCtTFcM1mSJ6vH?=
 =?us-ascii?Q?KYegZRwklLqDgRrQY/0qamFGxixHjr7RZIH0LfZTsZHhBGgPGvQ2RG7RfIGQ?=
 =?us-ascii?Q?1nhA5ruCynWW5FNJPO3n8+EhEfmfKadsnZlPnIkNjnte3hZoVeBMcdIMdgZp?=
 =?us-ascii?Q?9KK62aoXyYCB7MWdkoTYlGkEvYY+O+4h3QdDW5wOHpdKUSPYWwpd3Vq1kQft?=
 =?us-ascii?Q?iKMwCc6hdt1mOjNXYNnHxiiu8+1WWUecPBIDikJTGZcK2B9ZBgUrO+FOyoyL?=
 =?us-ascii?Q?ld04USr2DV4dKJaWkJ/IXMWGbZ0O88VObitBQilooDi7m+rTs69tj+vy4Ayk?=
 =?us-ascii?Q?cucfVghAklA6+Ab+z/0dIh9MnFKKUeJaLTTvcZfwxbZn8GSkVwJiDnNZEhIA?=
 =?us-ascii?Q?gmWnbfhcbBqK0U1qPi/KacUe1GmZgiqfgP+76JBCQnNUSAN79V8PQmsCrTWe?=
 =?us-ascii?Q?NayzQmAb+EuV0GpkOQcHx32qc2WWStMktpsCr/Upi7mXZ5/eA7D0aP2OSacz?=
 =?us-ascii?Q?ysQBtrTE6VIJwQflNNeOiwDCz84WlJ09jTjv1mibcFWVjRjLH1Vh/hE/QBQR?=
 =?us-ascii?Q?EaJNDyBVaCnbQ9F/3Lfhq1A2DIwa4UtVbN6NCC9isrrY0JQ3DO8pFEjzwffR?=
 =?us-ascii?Q?F00SlULCjuf2782AfmfzYdw0nC3F6SCKLQy24ryWc9dcGyuXobxRocEjd839?=
 =?us-ascii?Q?FnOS3vTzBEyDYlXjuDtJGqfum1CUnXlxcufyUDuXx8cHpu6zQdOXUOWd/761?=
 =?us-ascii?Q?Ky9L25Wy5Fq0S3cpKc499ncklSy0PXrkN7Rf+GFF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Wah5R8Zt0u4YDqqqRhkDJjthD23gzFajADOjvMl5paEI+3jW7qvyAN2vQSop1zrAvKpXAc8FnRTZdBnlgX9LvyQ8ORfXv3fHG2MRGQAA7F6/Loi23lKhTCmNOUq0yNDDMy96n5apCaJZ+jNEQ7eflMHoOWzT8bGALDnjClBlTMstWv6pLoZKdwgGvbVin1+0GtQ1VZpw7QDkO3zrLrJx934qQfneEvSnNcGf23JGpBahPXEb3tUgVA3ZK2Q3zzaPsSN3rAUWBQMbg84HgzbXQTm/ncKUYaln/vaVNh4NCru+9R9fTTxglHCW5s96Mg8NEXczT1aCOMjMQzsGxBtMbRcsN1BVnHXYh6UtNEdkNqtnIbLRe/OQdlkcJO/48/byftosLuJ73msEALqxL01V/FYpqF0fu7vLSzZIzKkmRAtgkGpEhDr2dQVo6MTNe+epB8LEPMJBWwn6CkcV97d54iBZ/3REGfk84RhyaCpExvaPNFRiQcJ4uQTULihcJBsxxWQgIeA+MRWP3GOZ60PxUzBZUhfCALWvVHO/cW2uiGJtYZNNYXwhuklADuMRPqLoQukb5lRUW5fvnPcBjePeo6iVQYNB02VhoQiri07TAZ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea3329cc-3658-4d01-ce99-08dd0a73a46e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 21:29:55.9477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kTIyqHftWyZwhk93j4ozkCVZZAJ8xaQIDdK7FHvGEhk5f3YDUKSFafzPDHSeEQiQbCMKan5HI56MHAl3Vlzc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-21_15,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411210161
X-Proofpoint-ORIG-GUID: hNwUFVfOgYiLnb_VQJNYjmW2LdU8jQ-A
X-Proofpoint-GUID: hNwUFVfOgYiLnb_VQJNYjmW2LdU8jQ-A

On Thu, Nov 21, 2024 at 01:18:05PM -0800, Hugh Dickins wrote:
> On Thu, 21 Nov 2024, Chuck Lever III wrote:
> > 
> > I will note that tmpfs hangs during generic/449 for me 100%
> > of the time; the failure appears unrelated to renames. Do you
> > know if there is regular CI being done for tmpfs? I'm planning
> > to add it to my nightly test rig once I'm done here.
> 
> For me generic/449 did not hang, just took a long time to discover
> something uninteresting and eventually declare "not run".  Took
> 14 minutes six years ago, when I gave up on it and short-circuited
> the "not run" with the patch below.
> 
> (I carry about twenty patches for my own tmpfs fstests testing; but
> many of those are just for ancient 32-bit environment, or to suit the
> "huge=always" option. I never have enough time/priority to review and
> post them, but can send you a tarball if they might of use to you.)
> 
> generic/449 is one of those tests which expects metadata to occupy
> space inside the "disk", in a way which it does not on tmpfs (and a
> quick glance at its history suggests btrfs also had issues with it).
> 
> [PATCH] generic/449: not run on tmpfs earlier
> 
> Do not waste 14 minutes to discover that tmpfs succeeds in
> setting acls despite running out of space for user attrs.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>
> ---
>  tests/generic/449 | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tests/generic/449 b/tests/generic/449
> index 9cf814ad..a52a992b 100755
> --- a/tests/generic/449
> +++ b/tests/generic/449
> @@ -22,6 +22,11 @@ _require_test
>  _require_acls
>  _require_attrs trusted
>  
> +if [ "$FSTYP" = "tmpfs" ]; then
> +	# Do not waste 14 minutes to discover this:
> +	_notrun "$FSTYP succeeds in setting acls despite running out of space for user attrs"
> +fi
> +
>  _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
>  _scratch_mount || _fail "mount failed"
>  
> -- 
> 2.35.3

My approach (until I could look into the failure more) has been
similar:

diff --git a/tests/generic/449 b/tests/generic/449
index 9cf814ad326c..8307a43ce87f 100755
--- a/tests/generic/449
+++ b/tests/generic/449
@@ -21,6 +21,7 @@ _require_scratch
 _require_test
 _require_acls
 _require_attrs trusted
+_supported_fs ^nfs ^overlay ^tmpfs
 
 _scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount || _fail "mount failed"


I stole it from somewhere else, so it's not tmpfs-specific.

-- 
Chuck Lever

