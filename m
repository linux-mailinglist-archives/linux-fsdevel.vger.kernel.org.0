Return-Path: <linux-fsdevel+bounces-39448-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 513E8A1443F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA0273AA349
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5068236A81;
	Thu, 16 Jan 2025 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B7qw/bTp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZMdRGFhT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4ED153598;
	Thu, 16 Jan 2025 21:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737064478; cv=fail; b=cWEpFtHCbd/iI/JWMwN9TvrMQ66jL4g/9LU9I8LDc246Tf1pPBS1Dz1zY4f316o24DKkosg82PUWX1FM2i2AKS8LO1/XDIu+CH+7BOPPb/u0bNksX6++dajL8tbF/gibIZOaSd5NtUauCWEaNZclS0iwkXfirRGj90Z9kTr4lKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737064478; c=relaxed/simple;
	bh=J7rAiBx/gX5syX6ahNollQ+ehhaJyCn7nnhzJeiqxV4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=FOVbBTj2eYrR8coEuuh1bywp0ZkbtA1wEhkwms2vD3SpV/nBQI0LbqPkZvqJOiMARKzk+xVodyu4cd4pi7lYyrcQndEOlV5/6MH9hIGYj57nNizJdSjErnVL/zU/dBx9mgSh0UQ2MfRqylrK8kc+tzKBf3uHST66Ux9Wco7qiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B7qw/bTp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZMdRGFhT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GJBo3H014546;
	Thu, 16 Jan 2025 21:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Pyu0Rl4cOq5Fmvp5yP
	KoaSigDEM3O5/l7MEaST9BK5w=; b=B7qw/bTpm1Zn1KK9IEHUfJZ7Tf2QAeZsrU
	fwk9Tv6UwnhtEN62k5/9rE1nJuQkcxpVGvPCOMn1N5XzoBP3PdgiGb7zjmfpwOiA
	47Dyl+nMcd8Y04uGm5MJvOF2g61wKzEjEwcPofeEUChpOGgYEyOk9ZKA2eZhAC4I
	+whfp8MxbxNbHJUtYm9HZRDVLUfncOtebL7jwGKevImBJ7uxdnkQr3zos8kw5sK0
	Z16EnOHJGdMuxnDw7910fYhJQKc0B7ApHNG/G6HQf6bpsIDJG3IriXf9nMGyx+1f
	iYBkWGjXu4x5MYsGHLXer5eH8XNhOB9lWScXLG9BB9oTYL9I0/Ng==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4475mfgnxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 21:54:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50GLdVG6038606;
	Thu, 16 Jan 2025 21:54:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 443f3bcpxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 21:54:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXCL059w4iwneeUMEP8oXXEpSon42H7qyND1fhYILILmnpc5JkU5LA3ytkvGEyOReG3kLxRfO47yCQynS+HEcxGumaJ6UsxJPBxb/47xZcsuvJVbAYybisXll3eWgNqsXa2JxU14ICwvsDgl1+RFDfLSbKBlreRaqjSXvziAh8fdkedPmOYfzq4CDh3FYDb8aHeh9SbQVTG2tBIyqccD2798jQFlrtYc6hHMzegnCdoGcPiu0ora6LT6vF8YH4RS4CD5nb62OifVVa7ltgpi2L9jDZdZGCE6tV0leQtMZikeplqDpZITP7W+GJnO7rnMQHnDbxwE5amX4zzSyg7R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pyu0Rl4cOq5Fmvp5yPKoaSigDEM3O5/l7MEaST9BK5w=;
 b=s2oR3pf4cgSTzEzqzutXHxoi+nXsGPrbz4oEnAsgewdWtdDhhCRFVlMKXUW1hfEDI2/jnTHiTwScd6erxt8M0r8QuztAV5Vm/LjzbVjZyEV8eAOREOCUa2glIMA/n+7sXWJeCbUqF5uHfOJ3cN7wAvfQnjGb0X7OxWCIGxdw5mtDT3imKjd0JF2Rwh05aWFM8fmEDQ/O/OikCjiJrW8d/U5f4KzaEW7IImrLWOcw9K2zBAMQGveo2WW+gBKaPdW0Bfg9gKEFecX3TY5jL2t62XVUV4LR0gQSAyLIJ3z1QxSVvZXOuaCeJuwnf5HfdTjYU9A4zHqbyvl1JKLmqREKjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pyu0Rl4cOq5Fmvp5yPKoaSigDEM3O5/l7MEaST9BK5w=;
 b=ZMdRGFhTD5KR6LE5lXoHvvTKamIsHGzgSUA12E0Zqwc0dn6sdfsv8qEAfsZOu5NpVDWiUlIj77Ik3wyPZclviKt5uQCe3wuzQLuEugKbImsvoZTK866pS5OMsQ8jSilY0ckA2BZrtmAG0fSu7DG9XfU6EXXaoX1IlblZoiHQmmY=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 21:54:22 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8356.014; Thu, 16 Jan 2025
 21:54:22 +0000
To: Chuck Lever via Lsf-pc <lsf-pc@lists.linux-foundation.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Chuck Lever <chuck.lever@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner
 <david@fromorbit.com>,
        Anna Schumaker <anna.schumaker@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Implementing the NFS v4.2
 WRITE_SAME operation: VFS or NFS ioctl() ?
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <5fdc7575-aa3d-4b37-9848-77ecf8f0b7d6@oracle.com> (Chuck Lever
	via Lsf-pc's message of "Thu, 16 Jan 2025 10:45:01 -0500")
Organization: Oracle Corporation
Message-ID: <yq1cygmzc2j.fsf@ca-mkp.ca.oracle.com>
References: <f9ade3f0-6bfc-45da-a796-c22ceaeb4722@oracle.com>
	<Z4bv8FkvCn9zwgH0@dread.disaster.area>
	<Z4icRdIpG4v64QDR@infradead.org> <20250116133701.GB2446278@mit.edu>
	<21c7789f-2d59-42ce-8fcc-fd4c08bcb06f@oracle.com>
	<20250116153649.GC2446278@mit.edu>
	<5fdc7575-aa3d-4b37-9848-77ecf8f0b7d6@oracle.com>
Date: Thu, 16 Jan 2025 16:54:16 -0500
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0029.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::39) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e0db56a-9ffb-4508-3a42-08dd367855f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?txLPRf+SJp3ccgaMJPyRt+1/sAb3XzAVzHCOCARwEh62EXguzrCkKYmsnDac?=
 =?us-ascii?Q?DJd57i/t8qygdd/QOpN6QPxqAdi9biTFM0cJP9+gjOzWc19Y98jMuN8DrIeD?=
 =?us-ascii?Q?EMUl8a0ongA3Eqs6j0jI6+Pgz1crCh6iG1qiduMFvQXyfd2Zkv0tGM5MSKD5?=
 =?us-ascii?Q?z0Hm623TzTBBpH4aI6/rv+Nzposb7z/uTwn1UITMxAixx2SjvZi9QoWDUphQ?=
 =?us-ascii?Q?qfWIzEQOASXWmCwvXQAp7m+Nz02tFh8ru3HxlfYjowt04UjLpYhxzXOlcm6m?=
 =?us-ascii?Q?Dnn0Dq5kPeEomylBKe0NHZCFOX9f7t65OVCIgZNYCbHAYoK0unVBLn/JMgBd?=
 =?us-ascii?Q?AqnNVnUthU5sN5GUJF+v5tVe9neooo/Shvbj5sSIdKZXZdPYUcms8YkQ/M2Z?=
 =?us-ascii?Q?DGQ8nMw0r3CyejEbZIPOvV48ePAAN3tkPehd5RLkOJP7VZL6KJIcKAT4hoLr?=
 =?us-ascii?Q?tIvTGNSLnt+TLCtUK9AoIasVRp7R6S3RKhjfUFtoD2G+SHnGr7Mlu8eKvuaa?=
 =?us-ascii?Q?oChCGJDmkzDE7Pc0WhEKTzBLok1Qc74hT8Lr6f4FbzocRqrp0gXx8QLvDAvz?=
 =?us-ascii?Q?Dn/WLA7yVmkPIJiYsmBxs77BKh5KpNN25rSx+JLjKMXH9RMDySYpfx7Qm9NT?=
 =?us-ascii?Q?aa2DHPOT5cTvFFdaGuXk9FMzaTTWhtjzYlx1e0Hj6exoo/pNotgnL3eGCqJ9?=
 =?us-ascii?Q?kxnu1hBfV6yGwt/YOSHdimEi+9H/1KC83bXMCtE+tL2fcgGAKIrBL0/uRm46?=
 =?us-ascii?Q?8azM418cjiW1+fdHeDgPIEHJRdZxFAF6ORxVRM1goNnWgZsjnDg3totXmQh9?=
 =?us-ascii?Q?CDd4CYzbC7jKJeRua0zutJLfWa0TWAc8Ed1WF7j51RK5jD0NmEwiMistpEeO?=
 =?us-ascii?Q?ZfkY2GPCHGsB+ArXD105SsSweTf/25CrCijt7tV27AnCClFp6vMdaZ6NaMMM?=
 =?us-ascii?Q?NzqiRR6z9Zt8dbZ56NpWDh35U8Lx4pinaNwI95PL5Lu9hUuQ28851h5NIFAU?=
 =?us-ascii?Q?qXbr9uSY4c8sLN1sbl8IktCIlqXC/QuWFiul7jTVKp3kU7caTV97CYrRPvy6?=
 =?us-ascii?Q?Y6LjO8aIUmws0hO/dlihC1yptWrTujLycvHj7zutAEBXFR+Oj/2FulIjmcD1?=
 =?us-ascii?Q?Y7CuXL+ATKTGQGVJ7jFprsqsnnd/k7ywDwfuAcEAaw/h80xCEcau3R35Q56I?=
 =?us-ascii?Q?fJqs55OlKxgbtUlEekun56U8Qkt3rWbj7mG4akPhmMiyO5JBoJrztsEse33v?=
 =?us-ascii?Q?5/KXGW9Ox/LtcsZQdiR/kzFnfZEl4NyQE7b08WbLu+d00b9a+2gCTCHHhGhI?=
 =?us-ascii?Q?BGrNTZ1pMPGT/EmeUFNX9hZGNwW8t5eJVzZ3hQ4m+PVOY8S1w75BYxusjbyN?=
 =?us-ascii?Q?DSqf5bRGjMbWTGiOvwxposOmH0LG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/4omy5cdLQ7c4FHhkROK64CeIYLV2qJSYbAOYP4y6z6OAy3B3zP1lJVlaaFD?=
 =?us-ascii?Q?87n8hSzjjsPZ6x19yJ7c5H3vIbH8ta9GNNNHZLdxLbA6EQoJuKAVTxDypsVV?=
 =?us-ascii?Q?VwohBN4Uk4L8HRmFm8bT6zH3XkQXruj9+e9ItUBq3YLEP72+ooOudXTxenDF?=
 =?us-ascii?Q?M0bGQG6y81uvXXZKVH7NPdNOXtNyGc40r9SwPjkmDN+lOxkpo+KqtxzWbyF/?=
 =?us-ascii?Q?8ym8Wdfv4/7C6AqQO86XDlR3E8NAjlBy52a1JbavixtvjL1bDt/cYHemg8Di?=
 =?us-ascii?Q?sWAvhgWlMyNCQNcR54autTl9naGLlJUx9Oug2mVUjH002zrtR/yBPu4ZFetE?=
 =?us-ascii?Q?XyYC96uXtAsSN6W61fNbECBPIvSUmrWnV6isKOlnr6TydiH4ELfLLj2fKsI1?=
 =?us-ascii?Q?FjTC2PFtLpxxYXbKspb4xoYejmFEp4cE7PZ9gZujbEqkqQrr/jo0KnsVoMgv?=
 =?us-ascii?Q?nt50jLZVJSaf7kiYupPh75gHB28c64m7uxTttXWnNIjL5f65HP2JNR75nslN?=
 =?us-ascii?Q?DokA4Bwf/44nwCN1GJQ7CZW+1hcCxDMFNHZersCzV3XrhlH7BYvPfhkOqVcn?=
 =?us-ascii?Q?Nu2FJ3miib0WgeSIYISBTjsGeYjKSrFFhkW24Y5EtvQVhFyxcua5leq9C9Ho?=
 =?us-ascii?Q?RknDD7Gdc2nltiJCkmqPFDvyvdsUu8yzglEfGixAApu2By/k23aiCmKIEfas?=
 =?us-ascii?Q?sWw9EfmcFBTucn/jqDKT8k3hpmoVpK/c8pFzTRLIF+Wyk/ImJYEFshrlNJ+J?=
 =?us-ascii?Q?X2U2qaUa5DjmYw6eWgRP43DPB8B4Yt2xovzWtW9YeM9917hb4efv4RVpj/l2?=
 =?us-ascii?Q?+yob4hmRtrAPY1i5aLSqF6dbcLNQ3BUA2a7Zfz3slbtVWLxelEIFCYYqd5C0?=
 =?us-ascii?Q?cLNuZcjwokvH6U2X/ClYTEo898CXbPWizauzIeVdshn1KMAubDsgan7JjYXu?=
 =?us-ascii?Q?aTxRxS5arV9jh0lHX8emBEBKso8ORqQD21/mDSHCZRS0JxxT7R0BuOsFvobJ?=
 =?us-ascii?Q?ATRki9WvbRJzKKIl9GAXhQoMTckFv0aauGhEiNUOwt+lEelAQWdNf3blcVfx?=
 =?us-ascii?Q?d5BvvmJEwWoe5Q9TzoIx26fZ/ictNFUNTQYL9iOiIdNciHIWm/LrjyfxYZJ+?=
 =?us-ascii?Q?cum0GWSwLFWD3G9AEbTjvkhCJUaARUEfHhqTJeCuHp+V4f8eW/j/1N+nFMie?=
 =?us-ascii?Q?oZNBtUo4Afr1jHqG1I4V5Kf4OmeVouc19teQ8dxwIE62RjTeoSsE1T0KGQWF?=
 =?us-ascii?Q?kR0jMyyhkBmNOcla45FarU1Up8tzVSTqIBulq6guknwCOTXFi69h8/3Y1HVB?=
 =?us-ascii?Q?c8ih9Bsh5ByPaZuLui9+XpkjO68E8WFXtZPGrUGNSVfyd/DspMK1Kx8OWiWJ?=
 =?us-ascii?Q?hWy8+EHBtu0VvKt4hn8GiZOxBb8Ayk/LkD7VC+tIeaT7cQFBhpLDFrOcDda1?=
 =?us-ascii?Q?7TmdddfCApqMuxz9j7rJlj6zxZ3Jx4+j/T0KoxLjYiNcrXIe44abUdKRe7jR?=
 =?us-ascii?Q?fQTEnVPwFY0/hKepBdxCgJXNrjlvrPQ7vj4EmcADMohqYES+C3+KiUyEs+C4?=
 =?us-ascii?Q?CnRwOhwBQZyl32hDXgm34RIaV6mx2EYMsrPwSIivfkpAN18MbApcbHnGM4jP?=
 =?us-ascii?Q?xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MpuW1qErown/7WWOrUZgno/z7nh2yIZdLYDASxmkBmrUgjlhnV/cNxTx1yy1Luq8xhuOXUX2ipuNpzErEgTJeRdep2MRrPYliCHg+hldS+URBVgFuE6m3tHzev4haHdyC0Liq7fwSxLEyCi1VTn6HRjr0hhr+IR0Is1ZDYE3Bc4wn74/jaI0E91EFvXWGj1q757dSjNWmXToTyYYk30+iIVpNp40y3aTYiRf7lcyQLF70gnxTAKi6F3w1XylyrDnuO8lJJ5NpjFJCC85ssFhB14pRL6dHhv2unsJLm4LhLi6ei/hxNKHkYKTu5qGdvpjHH0fanuClTumSb0DsCUCJwFJtL1rzZjloyf+fa6a7LGdcS+Z3n4GjfRFv/6hDW+dNDEWQqR90EINPoqBGdByDK1FZQ0pMyvJPYkZ0eFa4jhcQw2UKhqWGdXWVPEbDpjNPe0foRmZqLptMxjTl5sGoDK2xpgIuRBAKgi1FXMnB5iLu2x6A/EqA/lhnClx8pbsh85Ywldr3KxJbtnHpL783lstwlMNd67T5K/Xi/253dpigIpJysC7u36iaBVlWFveK1f/1F8nTlm3GwsJa41wHjHu7fI3BY/fmQRTGvzocSw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0db56a-9ffb-4508-3a42-08dd367855f6
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 21:54:22.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +WeK0G81PkqMQskFRPNa3y8wI5K2wCPCChGtC7Eus39jlJ3wvGSlEz8Jl93jYhsvqED14LT7cnrSNrbZRBoFT3DHj8Fc65Kp9K1+rs7isSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_09,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=735 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2501160162
X-Proofpoint-GUID: i5ReMNQI6AVj9zJwEZ3jwMH9NHrmRpOn
X-Proofpoint-ORIG-GUID: i5ReMNQI6AVj9zJwEZ3jwMH9NHrmRpOn


Hi Chuck!

> The purpose of WRITE_SAME is to demark the database blocks with
> sentinels on each end of the database block containing a time
> stamp or hash.

SCSI WRITE SAME writes a contiguous range of logical blocks. Each block
will be filled with the contents of the single logical block data buffer
provided as payload.

So with SCSI WRITE SAME it's not possible to write a 512-byte sentinel,
followed by 15KB of zeroes, followed by a 512-byte sentinel in a single
operation. You'd have to do a 16KB WRITE SAME with a zeroed payload
followed by a two individual WRITEs for the sentinels. Or fill the
entire 16KB application block with the same repeating 512-byte pattern.

I'm not familiar with NFS v4.2 WRITE SAME. But it sounds like it allows
the application to define a block larger than the logical block size of
the underlying storage. Is that correct?

If so, there would not be a direct mapping between NFS WRITE SAME and
SCSI ditto. As Christoph pointed out, NVMe doesn't have WRITE SAME. And
we removed support in the block layer a while back.

That doesn't prevent implementing WRITE SAME capability in NFS, of
course. It just sounds like the NFS semantics are different enough that
aligning to SCSI is not applicable.

-- 
Martin K. Petersen	Oracle Linux Engineering

