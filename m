Return-Path: <linux-fsdevel+bounces-22971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B447B924692
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 19:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E55F1F232DE
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D7D1BF313;
	Tue,  2 Jul 2024 17:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BKgmIENM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YEN8M42y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7A1BBBD7;
	Tue,  2 Jul 2024 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941960; cv=fail; b=qBSWgiUzHLH4lnTp54vkJVrGWZtQv42GxRIya9SxycL/E+CKUsfmdOfNOgWvi2oh6W5uUiVU0seTvV4Y98yPvH15XVIHOxHMwlyM9091RDcmFRhiBYgjcJgKuPRy2xrRoufykNDNGpKsUHYJLyJS2xcL2DDLiFvt5sJhJPPNN4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941960; c=relaxed/simple;
	bh=qQ9OQSC1k5F63WEQb92SBmbFvx8nF+iXh9r0c/hNflg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UUgoaSqkVG2Gq+BCY88ej6OnCYTuZmHHNcqyDivn7IgpKiMXJu6/aF+dQXjmam24Wbel7TEAv6LJnzZ3b6RuTOwLSZKQBrwmqxESHu4XNFYLFPrmgAcMYGLB7zGp2jCzaVy+vtCiFXL1vVgnVdjnUxQrv0OL4lRPDnsitg+71Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BKgmIENM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YEN8M42y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462GtTja009667;
	Tue, 2 Jul 2024 17:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7eqYzgXdtvMvx1b
	RKDsagpZBIE+Zg0SPu28o3F6ioJ8=; b=BKgmIENMJJPs173AIgeQh2jAYXwO18i
	lUiMvjSOBVy+EQibQrA7as+wA3QKSzrbK4PkxOpQfvZbY1JgqPP3ZSnlFofHYSsj
	WfTT3HQtBWTnV8NdhoOnJ2D7v6VV+OOV1PCKqo41Obb2xsoW4qLDt31/DSLpVoPE
	SMf0m4QpoHkw4wOBGA1LUkyQTgyBkhLctgMjK4XrzrmeBWeFSEJwUYcXJxpTOVVs
	iK0ZgFXg97PRwegz0pW/oiaeAAAvd2vO1egYse3fKf85i8M2yk8UpsbtjlOMPvlC
	ImDLpNbroaa7X69vWtVq8dWbynQXWHgNAwcAcUF/Kv/ZXLsSwTHE2EA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aaceh0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 17:39:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 462GL2sE021600;
	Tue, 2 Jul 2024 17:39:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qe74np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Jul 2024 17:39:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfsxI1Aei0zeERzdrRrkcrUlFyXvXRkrKtnshK8ZQ7CaL1iiitcEIUrkduYZ2Ket1ilIPAwL/vpcXQ7DFThzHKKp+QiqwAIuehsg3ruo0B+FyDNgrzNP6CL2htOFjI0lttPMZBvtcu9ixJrmNNRAmK5xoVQf2V85BvZGKAbzApu9VqDy6Knq703aHGUCAitOeg/lslzmYQARL0y3OuqVWgBOMxSbjQgnQN3HNdx0M/7AwNzbGJbgOXMuFFc0DPLrhSQ7F19iNHmQWF0n+N5AXU8Bxfe3QMT3/1PB9u5N3UQkBtxqaI1hmdh/rgs6dtaxbrl2Fo8fCHU0LuSi1R0SMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eqYzgXdtvMvx1bRKDsagpZBIE+Zg0SPu28o3F6ioJ8=;
 b=I0/kHRgSDWsMCROZ18Tv7t3laMvv9WGk8H+KCsUokBsczlQ4Mp57iuH8QqVVw5JsFJ/1UbC7HH9UO34bDlgNLoSGxrAnJYAHbqP2x0dw1nCd8h44WgTcwMa9r4PFsJl7L8AEJT0ib909goj5R3b/90M21TEH0xBIYY6EAOQJuTtM9q289inGUVWLijNVrKT7rj1ZDTJkcmmsZZSEAq91TkZ8qPQ3U+McS3bITI+cvGA2Hh9nFywRf6SnHEsE2vTTiy0uFOco+J2On6N05G1REqVmRPPJJeW/qa45j+aEJiLxWj3OTz60idwmzjk1d6WWTeAwYHEdl7g6kgIudg0ZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eqYzgXdtvMvx1bRKDsagpZBIE+Zg0SPu28o3F6ioJ8=;
 b=YEN8M42y/InQ+dnn+Qwb+4fLUxD+j3HYz26qwpTz/rgAzEquLq0m+Abg7Bwz046qsdTomZSH2ax5FqawJTT+mBWw66L/3MfzdIs9sthD19IyhhJG/Ttn6139Rv0qy2q0tBUUqJt8xb8Q0/5mcHwCov2qnltlKdl1I4nkGgn5T/c=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB6982.namprd10.prod.outlook.com (2603:10b6:510:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 17:39:00 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 17:39:00 +0000
Date: Tue, 2 Jul 2024 13:38:58 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 4/7] mm: move internal core VMA manipulation
 functions to own file
Message-ID: <o3c66lbg2c43wtut6hyoruggdp65jdb22gtyn6scnycluevqs3@f2rzgmqlri2w>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719584707.git.lstoakes@gmail.com>
 <4fd37092b65caf30187c29399c2cc320a8126a66.1719584707.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fd37092b65caf30187c29399c2cc320a8126a66.1719584707.git.lstoakes@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0320.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10a::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b05f44f-1f68-476c-1991-08dc9abddbba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?tmfXwmXbU1h/YjwLLSr1GxoghIg4I8dIbVGEMf//Xk8eMybQPzaaofmzkW3d?=
 =?us-ascii?Q?HPnTDCP8ivJD+u5be0h1hJ5rOCoUAKrIgspgmJshHvGomwxsYrMLyrgUAj2L?=
 =?us-ascii?Q?nhzJZQl9/KXJIHDwV8Ww2p7nW7dNJhT5KnLgvKYGvzVCAtZ4bQOxCRDt8Nf6?=
 =?us-ascii?Q?l17up8h6a5v0EX+czsyO+mBOD74jgK9zcxdHQyYUeIE1bExAlEDy3x7aSm1V?=
 =?us-ascii?Q?TivPLH6XtqUqGQTSDvmzDpiQICTu2GXAwQUbjf0ih1YnTBLACT0wU6Wg2CRD?=
 =?us-ascii?Q?Uy7ocXg1pS86POQdJLtfU3VQDcMc1lPsbkCF+qsWzct2f72xL7+L5lwGCAHb?=
 =?us-ascii?Q?AAzdffwJhIkStIteC7aXTXDmwJWw4s7nqF4cPGLP0jKf9RQ73EXrTEslPNgL?=
 =?us-ascii?Q?XbNuwgOjIEUrQ8dDJp3yxhv+syfb5gP6RML2axj0UQwpD5bMM9EBjuwSyUKn?=
 =?us-ascii?Q?oFR5Apii5fQpvuBQIshJdCfgEP/kQlya1CVjaG1ObONyMJfXph6GKxwNo5iF?=
 =?us-ascii?Q?WWUfYVlLkbsVCAAv4mmdCtVaIrKLs5U+1P1M85joAbtk+g/LuBEwwjx3wKA7?=
 =?us-ascii?Q?RA69h1HF3nminFBE3nrb3g/gUVTT2Gmux0bAVlrVavmSNC1iWerRzRgs8Bqz?=
 =?us-ascii?Q?pydh+eDMH11feds2MtusCHH+kaR2zJytXAokcvC7yiDH2a76YQHiyJkCLP5t?=
 =?us-ascii?Q?uXqrvWsQr+vo+nI9fGT8xWTGigk4CUadTpT5/v9zT/qXpBTRBKb2gmVievx4?=
 =?us-ascii?Q?FZg7ZlOVh7yY04yYvpYn484dneDYvlLDdyF69PHPq3TZlN72tSyiCSHs1oVl?=
 =?us-ascii?Q?sDFC9nVvriHdblvD9Xuf9P5dGJunLxRwqLBXUGYoiw9SscztvHIlpYwOQ02m?=
 =?us-ascii?Q?utJBoezH6r53SHixwOWDLnDAsJCMf/qgQB4rtI0ccnr6XCJx3Y9zUDhTHcT3?=
 =?us-ascii?Q?1rnmz9DkCCl5SGADPRfx9EbOjTd+Hj6zyq8srGYtryKBPP9ckFKJ5AXSHmHs?=
 =?us-ascii?Q?v4Or4zKgz1PtQhsBrp6bNMtflv0yPviG17eAL17cS0l1VwYFlCMevgi2ICSP?=
 =?us-ascii?Q?eAzyllvUniKI258yqJ7tasI1OcqiRRHBIo2JLzSFAWZLiscocr6VnDNZ2hc7?=
 =?us-ascii?Q?PGQWt7bWyhWbAisw0Lu8LQ5O4PZcNE6V4fZXj9C6UlVjvyvM6DajA2L9hZ6q?=
 =?us-ascii?Q?vxkhLKNrf3ALHmynuUi834QZ6iMwHbktrZQd9Vsj+B9Cd+brKs5Hxpr6tHrM?=
 =?us-ascii?Q?hirpbB3lP426nubunedu+44vokzpUGY9e3Y6Ajs3wniK9QO19sixrLO7pw+D?=
 =?us-ascii?Q?hu+jymp+WBnWHRfYDeTuQoRp0IdgEtA2HFSi2H0yXeqlmA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?oqc/Zlkoz0QW3dkRYJXK58HBMmlDgJcnnO5nuCTG1tBgyYTdjNyMyyd3kowA?=
 =?us-ascii?Q?ZiI9PgHXNHKccBbzlo0bZ4P4vqrz3PYgldGMBCt25m3i2vihja6JncI2f7U4?=
 =?us-ascii?Q?7+WnLTBtHSMTTnDYSEfUEModdBfjl71CC983+mELg1g4mXtgLbu6iib1ji80?=
 =?us-ascii?Q?IYVpev8P8qF9vMOsnSUC2lcxv9DpO9PLtzyI1O4MfYxCA1WCipzoRK66bfgN?=
 =?us-ascii?Q?kwEpCMGoDF47Ol2R84fKqh6+krsot6fKP3ssRvs9sgONePF1HBlLKAJMdGrf?=
 =?us-ascii?Q?CENB60sh4LPqnGEl7R+Gx9uo0E2MyDbAF00XrUSt8WjznsfBsYmhSEdrBH/n?=
 =?us-ascii?Q?YdoqCaxrOAls+5chtIV6iztwnPeRu/aDQUZH8NTHr6cnCH2Aeo8UXv7uhnYt?=
 =?us-ascii?Q?H1P/rb7fxtgeX8DK0sECk54tBByn3B6muy7fVf+MglKEmuZVn2OgTwo/dxEs?=
 =?us-ascii?Q?uAUYzaCTklLS/be5pHyHmGQz7AUUd/LeDZKRp9MPeHaOnZWe6TrXlzeU906I?=
 =?us-ascii?Q?ZS8qAg43hQSaqXRMyhr3sFS7+OAxDvCcUK6QxDvWr/ywAvg6MQhJ4ZHqw8vj?=
 =?us-ascii?Q?C2USWXsTp1WGtp9VqynjQGBDHu8H/2561Oetkh2GxcHFuk/PKIk2TQtRA/ok?=
 =?us-ascii?Q?Ou5g/w2L+dqpHp5osK6ou2ZNh7pUy1RbkvSA+twsndiR4FTJQju1RTx5cUeu?=
 =?us-ascii?Q?Iq98YUd3VX6kxTqrfeiRTktexpYNxtcc509Oq5Y1UlbYkQiy6+NfRTY0DdkH?=
 =?us-ascii?Q?z1ZRIG/IV07kQsZhLWiO4EdQkwhuBvldLxpIai8ZuZuLDl8uhfVFFiqJLjor?=
 =?us-ascii?Q?6+lrZ8MQkVMjR4PI3xvAT+UMDQVsLbZl0LzQ9JnoT8x//oRlAyeVL4f74RGv?=
 =?us-ascii?Q?KGnjs/mWy/MABhfzqCezLOwKGxXLGB0Ggm+2MjH9ch+HYoaj60wcTYS/onqP?=
 =?us-ascii?Q?pB9I9k98+SbugWxWVODOPpQ6Sig4/NHTxQoLNnRcLJrzWsWlww7YVcn1kLh6?=
 =?us-ascii?Q?CFfIKWspx8JNtxNO0//yYi40qc+8n5hcV1iE597/cW+LUyMM3+iEweC/uBfG?=
 =?us-ascii?Q?Qa65dsPaKH+EXsWfneMvrqpTavzQt8DIrZgq1QlBdbiO4jDYOhyYehzDg8xc?=
 =?us-ascii?Q?6At2t7n0ftcyC/zt3xyjA872RPRzfKEqbk8ycfbiCqYJii6zdvOf9fsuR6vL?=
 =?us-ascii?Q?bUgMJyxp+i6BNI1XKSRzbA9isDZmqH9IVbmYPsAIYTLAY4ZCQbNSghV4qZR4?=
 =?us-ascii?Q?3UEx18qg1TZ3sZJrfZTtq5JqKSQAG2a+eRV682KYmxaF8yh0RyhFNBREx0Hj?=
 =?us-ascii?Q?4iyrwsxVhFaEegx9PwQDbHTgEEvee2T5dZp54fuOWZYhqoHc6246sX/hD7W/?=
 =?us-ascii?Q?gdInPhTJ81wP+6MdUQwxzYBvMNTSJZohVO7pCl0nVs7T/JqvuedwXJc1w0pC?=
 =?us-ascii?Q?/d6Kq8h4eXUjUmsqaFrQW+2KceAvRrtjn3/PWPA7Q3DtMoepP/X/E0OtrePw?=
 =?us-ascii?Q?pbh1L2IPKNYWbVfhlD9WBMXyUS2ukMJ2HSyA5z4L6mzdSlUQ0qXBrxUFlpVz?=
 =?us-ascii?Q?fQqEUbxQAYbCjv2z4fMp6TNZZzEHCSiXtlS/WOxg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+6LkA73gm7SQ8igS3T2bcsyRBRIOhQNfdZ0z26HdG3jPxuF7O32jkIlMOUi8baJTmuVRPydzB46W+obZlnJmaIkJG5IftwOzvzIDMFHe5yUKczNIpXxfCFRKw8LNXZ/8y/O+Zmw2dtvsb5iLH+sUl2mgq7IuvijK6mMdyUZMdZeSvI5dnFLOxAZCT4KwJXqF9OKsG5L0CkWUuQzJoum7csCww0ECYnKWL3LOGS4iQCXbBipzMFVlIkgGsFTh9jIJkA5EZcirLZwI0hfrRfSpGJ+31qnQhgxFHsKCu5Du1CTbaQOmCfhtf8EtX8FX3YYGTdGFVMKKz/vcBBWSRFJqukePmfnzOTKQCCjFBuziXdbS8S8Dyktu5NelLyS7YaCtDbGeFbSpMgSFkM6ZAA6I2WnavNLgSDBLqfR+YDO2Qj20dx3VOnz1ZLxPOKmOJtJKZm68AQaK99fGaSkVi+d1eyW89u+YKoebgj0uMmbs5i6wvBnFWPKbgSqKDa3S+IekV3MCrZi88dca6s0UaKJE1dAtmjCRIyMGs10JYMK9rOHEc+DLgsbSWDT83XJVQjQaSuSPzOekH+06kZj2hjx8+cS6xyK8V4aMOVrSWBTJpRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b05f44f-1f68-476c-1991-08dc9abddbba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 17:39:00.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/iRCHWRtERtodJXMH57yVjxzog29AZVFU69MXIn652LumtGJhy5/XNKXEOh5YdcizWx/uvyEqUfOjA0SokLtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6982
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_13,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=984 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407020130
X-Proofpoint-GUID: dJFMr2sl7Hp2swT58YblZbpnC27qOnv2
X-Proofpoint-ORIG-GUID: dJFMr2sl7Hp2swT58YblZbpnC27qOnv2

* Lorenzo Stoakes <lstoakes@gmail.com> [240628 10:35]:
> This patch introduces vma.c and moves internal core VMA manipulation
> functions to this file from mmap.c.
> 
> This allows us to isolate VMA functionality in a single place such that we
> can create userspace testing code that invokes this functionality in an
> environment where we can implement simple unit tests of core functionality.
> 
> This patch ensures that core VMA functionality is explicitly marked as such
> by its presence in mm/vma.h.
> 
> It also places the header includes required by vma.c in vma_internal.h,
> which is simply imported by vma.c. This makes the VMA functionality
> testable, as userland testing code can simply stub out functionality
> as required.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> ---
>  include/linux/mm.h |   35 -
>  mm/Makefile        |    2 +-
>  mm/internal.h      |  236 +-----
>  mm/mmap.c          | 1981 +++-----------------------------------------
>  mm/mmu_notifier.c  |    2 +
>  mm/vma.c           | 1766 +++++++++++++++++++++++++++++++++++++++
>  mm/vma.h           |  362 ++++++++
>  mm/vma_internal.h  |   52 ++
>  8 files changed, 2293 insertions(+), 2143 deletions(-)
>  create mode 100644 mm/vma.c
>  create mode 100644 mm/vma.h
>  create mode 100644 mm/vma_internal.h
> 

...

> diff --git a/mm/mmap.c b/mm/mmap.c
> index d2eebbed87b9..721870f380bf 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -57,6 +57,7 @@
>  #include <trace/events/mmap.h>
>  
>  #include "internal.h"
> +#include "vma.h"

This isn't needed as internal.h includes vma.h in this revision.

>  
>  #ifndef arch_mmap_check
>  #define arch_mmap_check(addr, len, flags)	(0)

...

Thanks,
Liam

