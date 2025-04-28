Return-Path: <linux-fsdevel+bounces-47534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3AA9F940
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 21:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6359A4659C1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 19:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033DE296D3D;
	Mon, 28 Apr 2025 19:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bYYzVfkP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wedLud6j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59ED91AA1E0;
	Mon, 28 Apr 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745867615; cv=fail; b=E9RVohQ/zb7hkMTR2WbeGnJFQ3bP1InpBvy0/63oUiR2cd8ZEiYaIQ5urTxFZ64VjxV+5wymrjRwmIpN6cqpKz9Xsc1TvzfS1WD8ctATHurxYmgA0m7530GBjgujjqJpthSm+Y3cKlIvrKdtw/NqmR6IqYolp4eFEvNFKVABiDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745867615; c=relaxed/simple;
	bh=PffMYa6j1INvGxMDJIeSSQ+aF340WhUfAFn2WklanaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j6Up15T70oVcSNUnlzYmCZ4jC0jtfz0X1DEHfGytiEo19FOaoAT4nslI70We/Hu2gPoda5jG9rljvV/N+/eHLeisWwTV0kZGMvtl36up5HxrsQ+wkdE/kIMD3uLqfhyulXwqH1tVKJZhSWMEJMmGgCpmncbsIyVXUElmHX6w8Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bYYzVfkP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wedLud6j; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIM4hZ007877;
	Mon, 28 Apr 2025 19:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=UOOF7PA1wP57kgtJ1s
	DA8RkYD38dSLtgFJrUjDXYotE=; b=bYYzVfkPTM8fRMoJuTij1zLXFnqpp8tkZc
	AsMcI6fd5Cno5mEjCmoCPmzg7vky8mJ3VHivv3nkLqncjtu0pG0jp1Ru5nC1VD1z
	Z6VyGq57EXtLIzoC6N7X9LdusnSjJuMGXBOJbiwghmRMCGE19RD3q1HpNxARByEM
	bLT7NoaGNJ+GESwRxiVvgoC13OWGVnTKWIjUUHGYb2wNyO60fsoOa1G6xh+jGCXz
	Y5uTQqmbhgCjYTA+fBODm0JEkIR/aBv7WckA8Lp5vwd0HszlDcWFFGmWtK2+b9O+
	jBwy0HW0nQVTQQ6niGvyGae/QI3GJq7iSyu005z4Eb2rKc+mcChA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46aevtr3qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:13:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53SIPvBT013797;
	Mon, 28 Apr 2025 19:13:16 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011027.outbound.protection.outlook.com [40.93.14.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nx8v769-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 19:13:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCaxuDrITeF0k44IUAmamwuGt9hwNjnasnrGJGVq0kztiNgRP+WumfKphPlI+Hb792urnIU1wMkhSpsnegG/v8VMq540gw5KMgfPVgDi1mL38OOAzmI0Zq1TPsaMcktTLXdIrQo2IWhM6O9L8EFc2T8kVKLtM5xWX7vzgTOAetp3pMT08g7pgygALo6eLc9Ucw5KQVGOdEcUzAbFMv4GsLkE9nCtqUbxMlS92TpawMF5RS24noydS62LgFCGa8JwoQixFkgrpE3Abzw8Jh8+6hOgdEUPFYIBBi8Ml+wHba9oTE8NzwViUNNDbt2z9a9Bc8CnbvZWwxdTLLZq96SSDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UOOF7PA1wP57kgtJ1sDA8RkYD38dSLtgFJrUjDXYotE=;
 b=tB8l4LNZH76HlX15MkXqaytsRzXTVQPLu0AKUbFO4qNKVpWnCLEfdv5OvPWrN1j0OvrD9Zn3w71wh5I+zS1evB/OITAOwfJXIL45+6wPZ7CCvyDCpbASyY/YVP7CNBb0W+6xbDGgYm6JD+eOVDx0/N+G0Kt/oWt6NHII2rf/ke+lxxTEob+BngHgzMPNAcdXqfZvFsfdCh+5HSmQ91tWnpgXHW+/tHPmNGGBnZU5+pLMBSs18mtRY33Kta+Ki0XN1yAuMdLX8GL3NWv4LMukpjiS2hbJgYFg1i8whgJ5a9hVhvXIfXneclSVFUCdFVn2jopEPEFNxJETqrd2UVkt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UOOF7PA1wP57kgtJ1sDA8RkYD38dSLtgFJrUjDXYotE=;
 b=wedLud6jP0wM2JxUIu8hRpG/s1X0/HjL4DtpmCTxjLJfPyyy97UzpVMOOgGDwrH9DPbht7I6/WO4YtIuQNl4IoFjSzav3m72agBzKwJeB+kdV47eJHUg631kFy3rm7d38Q2H1ni+oyZyBAGqQiCERqgYFItoo0SLZG2E705fc9U=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BY5PR10MB4227.namprd10.prod.outlook.com (2603:10b6:a03:208::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 19:12:47 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 19:12:47 +0000
Date: Mon, 28 Apr 2025 15:12:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm: abstract initial stack setup to mm subsystem
Message-ID: <xw5wjewzwffce3peydddutkf7jorooi35jy6hcgt3qoisaj4lf@axu3ktfkwkdl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <cover.1745853549.git.lorenzo.stoakes@oracle.com>
 <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <118c950ef7a8dd19ab20a23a68c3603751acd30e.1745853549.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0071.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::12) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BY5PR10MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: e381abd9-3460-40b5-efd1-08dd8688a96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EMhArfqeri2sddbOjexwCJsK0gs1bfKN3taxGkiU4w8J0kNMXOTEMfsQg1cY?=
 =?us-ascii?Q?yFwC/ZUeWEzthhG07fBCKzoUNuak9m48p51qTva2zuiOzmqJXz5eslcoAgKu?=
 =?us-ascii?Q?6tq3rrF1WttfdccX3BTMCkOiSxjaWKimuXIgsrUusPkHV+ntl5i4BAhXyJB6?=
 =?us-ascii?Q?LZsO8EK/U/3/NMb1czyTbP67VNjHugxE323z4Bc6x5BOKWlbI9yQK/NGjM6Y?=
 =?us-ascii?Q?WKDd2TFovs/INBhZihsQlpeBLvf+ywrVPvv+kkTB+Mue7vizPz5a6MxPCnWU?=
 =?us-ascii?Q?ClqM7B4bpwrcAmiTd3lqx88s9WWKDKnxhDd5vY3aJmM3X76tkymiFQqhLo+y?=
 =?us-ascii?Q?Tf5O3/XvfozmnUGnyyrAz1A81NTHMuxMoAb+cIORBMwB3xGk/ttu2XvxaiqU?=
 =?us-ascii?Q?vJyRp1XptcmW2dTuizjln8L7kWoW+pd3AvOi46GqwpinmHyNq7g5QsT/xrNK?=
 =?us-ascii?Q?CypChuJA0NGLnoyDB2t5UuZbRJooJeHBFwmGiFWcRDlrWpO6ZnKvsAu2XALJ?=
 =?us-ascii?Q?HvRSutuZMCbmCdet+HYJgoxr45oTeETo+7SmBVen9e0y4kARJj/f5uv/Djr9?=
 =?us-ascii?Q?l3cQrg1AiL6GNfjvlgnwdN5lrSlztOHnwF+B7D7UrMMbU1U2HA/cId+nDRZ0?=
 =?us-ascii?Q?tu6P+l1DkyqYvx0Lrn9zuTf4nZnABvCpeB+4T8fJoyJ/j3XHx4ZEuesFZGOn?=
 =?us-ascii?Q?8H3QAnwos1nKwC0VZppugyuwdeR08tmzJXXXpqxYB8co+Dk+jJ8rbJMqtCXY?=
 =?us-ascii?Q?rbWu1fa4EbZxy5YWZM8qNumMgafh6tbrIDFqc4js0k9C4YG2Wlk5CBgWH3NJ?=
 =?us-ascii?Q?j5YCfZLOlvayYNojYSaCHrwhJaN4/qFZbC4Nyk7zRJpxTYipsw3M5wOlUpKb?=
 =?us-ascii?Q?hvqOf3X01ECydnjKzavdLcCZcUXuvqzFEyJLtncFTvAhdUnAw8qeidVNfLlf?=
 =?us-ascii?Q?YyZ9DVUw40ylmX8NSRVUwOlH6acOoplpeshwO/bvvUOz6bwB0w+RelChtCRs?=
 =?us-ascii?Q?gm2D3fybJkWjA5zNq+/E8eTgjmytvZJKoIPxE4DPLjGQfdMlt96IPCyqDyFQ?=
 =?us-ascii?Q?aqmv4N+Ej7chXK/AgE5y8jA1ssriGR8cZNBWkJn44+4WINEojH0M66uDNXUC?=
 =?us-ascii?Q?808+9PFgnQfuR/FbZBFu8avq/EaLoCwYaaFEmQK8Bu/D6mkYATvNk23jnKj0?=
 =?us-ascii?Q?Y6sAN5QhjLlF3VdNHfd4uSupfkyW1dtz9yVL/Fq8wRwiG4zKb3eKOccfZFn1?=
 =?us-ascii?Q?5llBLr2+2HJYEKZWKNZG8VCn6xoj6stfy9VLusQ981j9Db9+ohDrV6zRb7hE?=
 =?us-ascii?Q?VBtNPlvMaa8b1US4SRHtmCGDW2Kg6gXoqWW1RXx3NcEb3qf2NG0xCgqOW/gR?=
 =?us-ascii?Q?0bVbOFIOzmI5JdYYTMWJzEIUCDyIK3N7ibalYWvCNyoxt4eLBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zw1Pa/X7JuFme6W4dUx422ToocLYtSlRh5827oGd/JtqAsnLrsOQ2JDPYhr2?=
 =?us-ascii?Q?KMXc8kwz1QPyWlHHkBXWeR0I4SwFLpOARiwpH8AePoLwLDtzfEev+OaAaeqj?=
 =?us-ascii?Q?C0gQIHjtbfA78GB48pKHCGdcHw+04d4Lkns6hc+4VaqZlfDRVF6xzgmXL5Jd?=
 =?us-ascii?Q?BOF9UbsPeLMDrZ6T71okIUBoNmytS+/ttgR3Z/xMVa4sNFiJ1tnH5RohwshO?=
 =?us-ascii?Q?xsuIK8+A3sWOYG3gZHDR3/4bkBmwUHKk/9r9aLOgaZ7OyiPauUS4hxjYYFIm?=
 =?us-ascii?Q?jHma85Mstopkjxdb5d0rcqEq/yFtk5vORnak9947YdZKE70LDTd4/2UFKlFY?=
 =?us-ascii?Q?mdqe17J6mN+CLO5Hb1QJZokJP+2EYCQKX5aRjbUX0OR/xapwaSP6Qr0AUe/b?=
 =?us-ascii?Q?jrj84hUqt+hNPwSs1A1TtclfpHAtLHUbYDMl+7VOlWfKSWjCK8Ozzvy7sr3r?=
 =?us-ascii?Q?EcQFutLKjzEMkwtS832Yrot8tg+PfSRy+jGtjDaaHcXbIYZDDufBnugRhVs/?=
 =?us-ascii?Q?PudlT73z5bwl58qtA1Dp41FbW6OC9Vj2KUv7lsa/DiUbEEmNosF6q/70qlpq?=
 =?us-ascii?Q?/NzSWN+n71YBTbKz2G2qN1WXnjHpqGxzOGo7xeuo+Bj2Azml+X05BlwkSsQ4?=
 =?us-ascii?Q?N6TUrSt1GvWGUzZvpiOaX4K22ZExjjLdmTZFwDhXpF7h4nthVU+l6Ue7t+yH?=
 =?us-ascii?Q?0Sf1ePGCexGUNip6Uqqngvbtc5SdIf4hXJjma18XVJDVqvLUHkXoO4svGCtM?=
 =?us-ascii?Q?j6zW7ldrO/mucmCVq6wrixwvObfMxgd+3HNIlVbgth8THI8eboKp9mTV23+g?=
 =?us-ascii?Q?PV76RUTQvBxO6a3Pm0d2vMwJ8ZBOc33y2aeHSPRrn6pXPNZv2zTwJdlLlcoy?=
 =?us-ascii?Q?YcrtrvUaWBEBFQtYtGn0ZkwIHdErguJH5zHr4GHYGl7zIG6trZOwDQQw8Xtb?=
 =?us-ascii?Q?G+usGZtAT+B0ok0illgKZ0O3RMPX3p2HR5Imp1sr2gWq2roHM/NPp7PM9TDZ?=
 =?us-ascii?Q?9Id0tjYBvB2edK2Iw9ZUS5aIZ3js/tRoeDlAJzlLb7g51apxiU18F3EomjSj?=
 =?us-ascii?Q?kgp31zFt0XNaBAS4bPPAKRxYiTJ+JjLELw8+QzMetSrbrdmR60KADwqeI1Zp?=
 =?us-ascii?Q?kdaDS/fCpzVqcmIUjQkbJ5VtMsPjMRWZLJKrbR1+WVfIpmosY4x4L11Xz8Wx?=
 =?us-ascii?Q?T5UqHs0G+WPgdwpTTYlAWHKVY7GieElaR4PM61WH4yebKVxSFp8nfIv69V4K?=
 =?us-ascii?Q?4xJiuPNsTjwz57C9ekPNymMO0+tqyh0c6y2cTkSyzprH0itNLg+sM6Rwis+F?=
 =?us-ascii?Q?A+ml6axCDp4ZJQul40cRDpjCAAhDvib1d+RJxV3rV6sQjqVoXT9DW08e4tGt?=
 =?us-ascii?Q?IQDGqD1afxgu2BuA1ihI9z8hczaxo3XjIC9UMLGfS76QN/mucl5VQiGvLZBm?=
 =?us-ascii?Q?j3ZdzTnDN57yzKWVHRyUrJOl9VoweQ5nXMMcfP8o7EMNtkDlJY5uUptmsV7Z?=
 =?us-ascii?Q?UH/HT26h0fscA2TuLOR/eU6W4LS0wpScMxAiJmfqgzC4Cp1vfu/lzd1fTMtr?=
 =?us-ascii?Q?4oBpYUVZEZrxQ042AAIIES5sZkrIjcKaHt9513u8QUECM8GH3ufs3+jKw+OD?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WK3/5/Q8kTZxtoiXfo3ZZPLXaXokVEJyL2aZO5/8KgyrRiUrtSgfDSOlk43HTtx0QaBbqWHF+RO16xOVsLTAc4j7Uugm51YzLsMeUwf4BdjrUsMB6Zj9VFoYgViDoi+txVooceKfrInwbGoSfASGGkUu+cwiOHJT/o2a0mpvLzz5D7+/2T5oidmFJ9FDTRxCjBPen5wqXCmlije12X75C0Q88WxqN4ydXSrYbPZaF8IcE9iMUayzeYaeMYDDVguB5vvBoT9Pty7dWP6DrMsrZhEnl2Vy2fpm0kRyArgCKkYTgSDnEfbnoCyUvYsvJ2+XGZuyKciZhEGfw4vbw59aRP1/JzeNLUkm0IFR+cQ2yfKRIyNsRba5gRKo75utre4l+3mr/rt71CrtgOz2lZeytlT48c5wabHcEO9sbRaIuVAbQ85+sFDQ9n/Fs4WTnA0EEG1NqYf4I8/lfdy4xPh2ZwbhTkqQe+YqKkFyt42GjnW6OjCAxxzIuD7BPb8D0owLtcXiya3s+X7L+5v7QUBTdkKc3tKQhlKBXkwL3PN/le8yOwpNGL/rVvnxsbZ/Ar72u8vKSRUWENX91cHd7vz8MsWJrs2W0tpXSy66wetTqtw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e381abd9-3460-40b5-efd1-08dd8688a96a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 19:12:47.4560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVgVN9Fn5cvZqItTaIIDFh8mukv9ih21AIVdkps6IWOn7SYbgYg44p2iCrFhvQ1mY5kVxgQaBUkCbRJxmT7jKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504280155
X-Proofpoint-GUID: YMzNNFQO3GQIGuv4P8QYbHryuYTnxBVP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDE1NCBTYWx0ZWRfX057Vqv+i0b77 nNGTU9DbN08Sl+5/YC9ByqL9kC9Bgmfk+/9eoVjodRunnsJdK5u3Y27fh0UpQ/6BLKim2taOAlB DxZojG0ZR2NqwTCPC0VxOmV4U6vSoj2jOftZx4egJWP8hW+FA7vTfBHx6kx2WeMAsAfX6lL2pEh
 cn92d+F/fpoigNyrZgpa+ThFceeNP1RL9Z2ILeShX5nJErA95uGrZN17j6zEpsTv+HPQDVjKn6m Gi7KzU8oJVRrlMAS3SvmXx/PgWKc6hMhordlUtawuPriY4Sz8NhJo/opjNw7qFQwXMOuekX8ex2 9awjVrnZB1P5HHY1KSARFDxTNQ8RsETV91NK/LUaAl0wSh8ZZ8sKbpofulKicJzUNm3iMMXAELv qkZH0jS5
X-Proofpoint-ORIG-GUID: YMzNNFQO3GQIGuv4P8QYbHryuYTnxBVP

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250428 11:28]:
> There are peculiarities within the kernel where what is very clearly mm
> code is performed elsewhere arbitrarily.
> 
> This violates separation of concerns and makes it harder to refactor code
> to make changes to how fundamental initialisation and operation of mm logic
> is performed.
> 
> One such case is the creation of the VMA containing the initial stack upon
> execve()'ing a new process. This is currently performed in __bprm_mm_init()
> in fs/exec.c.
> 
> Abstract this operation to create_init_stack_vma(). This allows us to limit
> use of vma allocation and free code to fork and mm only.
> 
> We previously did the same for the step at which we relocate the initial
> stack VMA downwards via relocate_vma_down(), now we move the initial VMA
> establishment too.
> 
> Take the opportunity to also move insert_vm_struct() to mm/vma.c as it's no
> longer needed anywhere outside of mm.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  fs/exec.c                        | 66 +++---------------------------
>  mm/mmap.c                        | 42 -------------------
>  mm/vma.c                         | 43 ++++++++++++++++++++
>  mm/vma.h                         |  4 ++
>  mm/vma_exec.c                    | 69 ++++++++++++++++++++++++++++++++
>  tools/testing/vma/vma_internal.h | 32 +++++++++++++++
>  6 files changed, 153 insertions(+), 103 deletions(-)
> 
> diff --git a/fs/exec.c b/fs/exec.c
> index 477bc3f2e966..f9bbcf0016a4 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -245,60 +245,6 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
>  	flush_cache_page(bprm->vma, pos, page_to_pfn(page));
>  }
>  
> -static int __bprm_mm_init(struct linux_binprm *bprm)
> -{
> -	int err;
> -	struct vm_area_struct *vma = NULL;
> -	struct mm_struct *mm = bprm->mm;
> -
> -	bprm->vma = vma = vm_area_alloc(mm);
> -	if (!vma)
> -		return -ENOMEM;
> -	vma_set_anonymous(vma);
> -
> -	if (mmap_write_lock_killable(mm)) {
> -		err = -EINTR;
> -		goto err_free;
> -	}
> -
> -	/*
> -	 * Need to be called with mmap write lock
> -	 * held, to avoid race with ksmd.
> -	 */
> -	err = ksm_execve(mm);
> -	if (err)
> -		goto err_ksm;
> -
> -	/*
> -	 * Place the stack at the largest stack address the architecture
> -	 * supports. Later, we'll move this to an appropriate place. We don't
> -	 * use STACK_TOP because that can depend on attributes which aren't
> -	 * configured yet.
> -	 */
> -	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
> -	vma->vm_end = STACK_TOP_MAX;
> -	vma->vm_start = vma->vm_end - PAGE_SIZE;
> -	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
> -	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> -
> -	err = insert_vm_struct(mm, vma);
> -	if (err)
> -		goto err;
> -
> -	mm->stack_vm = mm->total_vm = 1;
> -	mmap_write_unlock(mm);
> -	bprm->p = vma->vm_end - sizeof(void *);
> -	return 0;
> -err:
> -	ksm_exit(mm);
> -err_ksm:
> -	mmap_write_unlock(mm);
> -err_free:
> -	bprm->vma = NULL;
> -	vm_area_free(vma);
> -	return err;
> -}
> -
>  static bool valid_arg_len(struct linux_binprm *bprm, long len)
>  {
>  	return len <= MAX_ARG_STRLEN;
> @@ -351,12 +297,6 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
>  {
>  }
>  
> -static int __bprm_mm_init(struct linux_binprm *bprm)
> -{
> -	bprm->p = PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *);
> -	return 0;
> -}
> -
>  static bool valid_arg_len(struct linux_binprm *bprm, long len)
>  {
>  	return len <= bprm->p;
> @@ -385,9 +325,13 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>  	bprm->rlim_stack = current->signal->rlim[RLIMIT_STACK];
>  	task_unlock(current->group_leader);
>  
> -	err = __bprm_mm_init(bprm);
> +#ifndef CONFIG_MMU
> +	bprm->p = PAGE_SIZE * MAX_ARG_PAGES - sizeof(void *);
> +#else
> +	err = create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
>  	if (err)
>  		goto err;
> +#endif
>  
>  	return 0;
>  
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 1794bf6f4dc0..9e09eac0021c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1321,48 +1321,6 @@ void exit_mmap(struct mm_struct *mm)
>  	vm_unacct_memory(nr_accounted);
>  }
>  
> -/* Insert vm structure into process list sorted by address
> - * and into the inode's i_mmap tree.  If vm_file is non-NULL
> - * then i_mmap_rwsem is taken here.
> - */
> -int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
> -{
> -	unsigned long charged = vma_pages(vma);
> -
> -
> -	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
> -		return -ENOMEM;
> -
> -	if ((vma->vm_flags & VM_ACCOUNT) &&
> -	     security_vm_enough_memory_mm(mm, charged))
> -		return -ENOMEM;
> -
> -	/*
> -	 * The vm_pgoff of a purely anonymous vma should be irrelevant
> -	 * until its first write fault, when page's anon_vma and index
> -	 * are set.  But now set the vm_pgoff it will almost certainly
> -	 * end up with (unless mremap moves it elsewhere before that
> -	 * first wfault), so /proc/pid/maps tells a consistent story.
> -	 *
> -	 * By setting it to reflect the virtual start address of the
> -	 * vma, merges and splits can happen in a seamless way, just
> -	 * using the existing file pgoff checks and manipulations.
> -	 * Similarly in do_mmap and in do_brk_flags.
> -	 */
> -	if (vma_is_anonymous(vma)) {
> -		BUG_ON(vma->anon_vma);
> -		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
> -	}
> -
> -	if (vma_link(mm, vma)) {
> -		if (vma->vm_flags & VM_ACCOUNT)
> -			vm_unacct_memory(charged);
> -		return -ENOMEM;
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * Return true if the calling process may expand its vm space by the passed
>   * number of pages
> diff --git a/mm/vma.c b/mm/vma.c
> index 8a6c5e835759..1f2634b29568 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3052,3 +3052,46 @@ int __vm_munmap(unsigned long start, size_t len, bool unlock)
>  	userfaultfd_unmap_complete(mm, &uf);
>  	return ret;
>  }
> +
> +
> +/* Insert vm structure into process list sorted by address
> + * and into the inode's i_mmap tree.  If vm_file is non-NULL
> + * then i_mmap_rwsem is taken here.
> + */
> +int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
> +{
> +	unsigned long charged = vma_pages(vma);
> +
> +
> +	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
> +		return -ENOMEM;
> +
> +	if ((vma->vm_flags & VM_ACCOUNT) &&
> +	     security_vm_enough_memory_mm(mm, charged))
> +		return -ENOMEM;
> +
> +	/*
> +	 * The vm_pgoff of a purely anonymous vma should be irrelevant
> +	 * until its first write fault, when page's anon_vma and index
> +	 * are set.  But now set the vm_pgoff it will almost certainly
> +	 * end up with (unless mremap moves it elsewhere before that
> +	 * first wfault), so /proc/pid/maps tells a consistent story.
> +	 *
> +	 * By setting it to reflect the virtual start address of the
> +	 * vma, merges and splits can happen in a seamless way, just
> +	 * using the existing file pgoff checks and manipulations.
> +	 * Similarly in do_mmap and in do_brk_flags.
> +	 */
> +	if (vma_is_anonymous(vma)) {
> +		BUG_ON(vma->anon_vma);
> +		vma->vm_pgoff = vma->vm_start >> PAGE_SHIFT;
> +	}
> +
> +	if (vma_link(mm, vma)) {
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			vm_unacct_memory(charged);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> diff --git a/mm/vma.h b/mm/vma.h
> index 1ce3e18f01b7..94307a2e4ab6 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -548,8 +548,12 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
>  
>  int __vm_munmap(unsigned long start, size_t len, bool unlock);
>  
> +int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma);
> +
>  /* vma_exec.h */
>  #ifdef CONFIG_MMU
> +int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> +			  unsigned long *top_mem_p);
>  int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
>  #endif
>  
> diff --git a/mm/vma_exec.c b/mm/vma_exec.c
> index 6736ae37f748..2dffb02ed6a2 100644
> --- a/mm/vma_exec.c
> +++ b/mm/vma_exec.c
> @@ -90,3 +90,72 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
>  	/* Shrink the vma to just the new range */
>  	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
>  }
> +
> +/*
> + * Establish the stack VMA in an execve'd process, located temporarily at the
> + * maximum stack address provided by the architecture.
> + *
> + * We later relocate this downwards in relocate_vma_down().
> + *
> + * This function is almost certainly NOT what you want for anything other than
> + * early executable initialisation.
> + *
> + * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
> + * maximum addressable location in the stack (that is capable of storing a
> + * system word of data).
> + */
> +int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
> +			  unsigned long *top_mem_p)
> +{
> +	int err;
> +	struct vm_area_struct *vma = vm_area_alloc(mm);
> +
> +	if (!vma)
> +		return -ENOMEM;
> +
> +	vma_set_anonymous(vma);
> +
> +	if (mmap_write_lock_killable(mm)) {
> +		err = -EINTR;
> +		goto err_free;
> +	}
> +
> +	/*
> +	 * Need to be called with mmap write lock
> +	 * held, to avoid race with ksmd.
> +	 */
> +	err = ksm_execve(mm);
> +	if (err)
> +		goto err_ksm;
> +
> +	/*
> +	 * Place the stack at the largest stack address the architecture
> +	 * supports. Later, we'll move this to an appropriate place. We don't
> +	 * use STACK_TOP because that can depend on attributes which aren't
> +	 * configured yet.
> +	 */
> +	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
> +	vma->vm_end = STACK_TOP_MAX;
> +	vma->vm_start = vma->vm_end - PAGE_SIZE;
> +	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
> +	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
> +
> +	err = insert_vm_struct(mm, vma);
> +	if (err)
> +		goto err;
> +
> +	mm->stack_vm = mm->total_vm = 1;
> +	mmap_write_unlock(mm);
> +	*vmap = vma;
> +	*top_mem_p = vma->vm_end - sizeof(void *);
> +	return 0;
> +
> +err:
> +	ksm_exit(mm);
> +err_ksm:
> +	mmap_write_unlock(mm);
> +err_free:
> +	*vmap = NULL;
> +	vm_area_free(vma);
> +	return err;
> +}
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 0df19ca0000a..32e990313158 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -56,6 +56,8 @@ extern unsigned long dac_mmap_min_addr;
>  #define VM_PFNMAP	0x00000400
>  #define VM_LOCKED	0x00002000
>  #define VM_IO           0x00004000
> +#define VM_SEQ_READ	0x00008000	/* App will access data sequentially */
> +#define VM_RAND_READ	0x00010000	/* App will not benefit from clustered reads */
>  #define VM_DONTEXPAND	0x00040000
>  #define VM_LOCKONFAULT	0x00080000
>  #define VM_ACCOUNT	0x00100000
> @@ -70,6 +72,20 @@ extern unsigned long dac_mmap_min_addr;
>  #define VM_ACCESS_FLAGS (VM_READ | VM_WRITE | VM_EXEC)
>  #define VM_SPECIAL (VM_IO | VM_DONTEXPAND | VM_PFNMAP | VM_MIXEDMAP)
>  
> +#ifdef CONFIG_STACK_GROWSUP
> +#define VM_STACK	VM_GROWSUP
> +#define VM_STACK_EARLY	VM_GROWSDOWN
> +#else
> +#define VM_STACK	VM_GROWSDOWN
> +#define VM_STACK_EARLY	0
> +#endif
> +
> +#define DEFAULT_MAP_WINDOW	((1UL << 47) - PAGE_SIZE)
> +#define TASK_SIZE_LOW		DEFAULT_MAP_WINDOW
> +#define TASK_SIZE_MAX		DEFAULT_MAP_WINDOW
> +#define STACK_TOP		TASK_SIZE_LOW
> +#define STACK_TOP_MAX		TASK_SIZE_MAX
> +
>  /* This mask represents all the VMA flag bits used by mlock */
>  #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
>  
> @@ -82,6 +98,10 @@ extern unsigned long dac_mmap_min_addr;
>  
>  #define VM_STARTGAP_FLAGS (VM_GROWSDOWN | VM_SHADOW_STACK)
>  
> +#define VM_STACK_DEFAULT_FLAGS VM_DATA_DEFAULT_FLAGS
> +#define VM_STACK_FLAGS	(VM_STACK | VM_STACK_DEFAULT_FLAGS | VM_ACCOUNT)
> +#define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
> +
>  #define RLIMIT_STACK		3	/* max stack size */
>  #define RLIMIT_MEMLOCK		8	/* max locked-in-memory address space */
>  
> @@ -1280,4 +1300,16 @@ static inline void free_pgd_range(struct mmu_gather *tlb,
>  	(void)ceiling;
>  }
>  
> +static inline int ksm_execve(struct mm_struct *mm)
> +{
> +	(void)mm;
> +
> +	return 0;
> +}
> +
> +static inline void ksm_exit(struct mm_struct *mm)
> +{
> +	(void)mm;
> +}
> +
>  #endif	/* __MM_VMA_INTERNAL_H */
> -- 
> 2.49.0
> 

