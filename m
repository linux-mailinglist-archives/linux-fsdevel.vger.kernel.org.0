Return-Path: <linux-fsdevel+bounces-48587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4034AB1313
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88E151C037D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A572900B7;
	Fri,  9 May 2025 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bMWKIWS3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pc1uGK4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EAD290D8F;
	Fri,  9 May 2025 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792891; cv=fail; b=qL+QlHoDOQ0iYG3qcJ/+aNvh6KZYw2VvBvejPJ3L+DcJnH9keF/4TK33HBvPgncyKl8Qyy/PmYUCEz1LNoXRNr+ZBrFsZ+lWkHYGU6RzOZz+QX4ra+qMutzbkWX/aHGNwS8ETtfVqgYDIDBetvHGU+PElUoWSFrJy2QSnoWD3Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792891; c=relaxed/simple;
	bh=g2mnmnamjWKbthY6BHZudyMiSJ7SaQqEn7eBLxzeiQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZCLys+4bw+KokGMtYhRaooAWtM3p3VLVRcyKZ7qwSx5cwKUfkBV6Xo4CY7nEeSsbJiLUQ61RfWNhIjvGCb/hJtqBQM43e3ZM9bLql48IAEPmi+tSl6aoIDNMXGt5PRAtjYfx5ZRC2vgsdaZ5Wv6B465O7FjKasi35fdntL7vQ+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bMWKIWS3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pc1uGK4e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549CDFe3016044;
	Fri, 9 May 2025 12:14:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LO65HkFPxUvNnWsc31mkOZ+NLDjClzDzj96F4tKoO+I=; b=
	bMWKIWS3K9g9J+VzD7EgXvTXHnV1j88KYyKkZk/xIxeit2A1zoOfkgjPeUBmGn+B
	D4xFOpO4fXiqwkxR2LKiKHFzTGHm2067qzxO0t9/G18U40nXAGlxJGTCVQtOMnQL
	ybXvCVFFvuQ/YJnTwCOlDCj8RBJ36rRptKH6DbV/S2NjlAoqE8AYmbGAqQJhRQjn
	xB7cAVkEuAKQmNOAL5SKzFMAcQH+O6t+yuG58qHuVeSi8/110YfHeaWdfHkWW26T
	8UGk/QBGhlrd08M4EHEKPF5IVvHdSxM8F8gkXIk4oyHEKWWwykkXVVeVLBRO/Ix7
	UyDDGFQe7uNYuj9HO2ICow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hhgjr03u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549AenT8007400;
	Fri, 9 May 2025 12:14:09 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011026.outbound.protection.outlook.com [40.93.6.26])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fmsbgtna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eFvinH3eSZ28VZooFLJWwY2iuB+1vmnAeTuTR3UDFJE7HPxpfFfDnenJG50Nss6ZS8YR5EQQQFKUCn29iztFitFXfqpnjE2XJlq/pwj+IyDpAYJvGwJdxV3vuy+90ID9pe1W5ThbV6YKIVuFNKY21CsK9U6whRZT3qbae87q1a7uTwoob41G00U+gGNpIF4LLeHG/vwdT8batLk4fvSUmg9piWOoawVldwqC6izaa4VglFHDWL8NCL+QhbdL8Wx+WM8bTDWRuDYZig/fnmNFvqvNqcFynsaQF1VrPhz9133r4jAGK7Wz5e+p3bYZullIDMLivGPuoNkDOZNHxlICOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO65HkFPxUvNnWsc31mkOZ+NLDjClzDzj96F4tKoO+I=;
 b=JQFrmoXXLGK3IJNOF0AXUqBMpvxvgUJZZkj4DYVLdbqDOmAZAHjp+X5Tef0ldHYrAWAgR92HECnJiGRJFfuW+DN0M0749WMZbBOpAgJW10ihkLJWAH88QYwe4tnZk/8Sn5+LDdrymIvW7NsVMXBDL0g5thKsYkC0HGu/gKQNXK1ax6bXepP/uh6/sSKzlcGZGy3W/oa+ILsGzr9InlKCIfxzJayVSuTJAj5sBwlZ04s3UJNp3bC8C6tOpy4ucZTcNthb5Ke5DYeIxNFeT9XLX+wO8qI5FRsXV5BWB0/tLzlNKhceDCI+ZiIjjpls75ldYnqbhs6cwjfbuuG3A+yr9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO65HkFPxUvNnWsc31mkOZ+NLDjClzDzj96F4tKoO+I=;
 b=pc1uGK4eKKsUS44stNFoyqva1BnyutknkeLf9aCg+U30DN6DN72cVgeZmYNrWD4UymXwFh6+ELjjFfaUUiKV91PzwT5fVer7ieaCWs2a0sc+68vY+Sfel/28FXPez8lB59xNhPvxfSJCIhgqvI0cBh29T8u0mG7UUmN44fjAjUo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 12:14:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 12:14:07 +0000
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
Subject: [PATCH v2 2/3] mm: secretmem: convert to .mmap_prepare() hook
Date: Fri,  9 May 2025 13:13:35 +0100
Message-ID: <0f758474fa6a30197bdf25ba62f898a69d84eef3.1746792520.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0126.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 5232c242-db94-41de-27d9-08dd8ef2ff4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8fCJiP/urlpcv+2OMMfSO/GtE/riktX5p8t8X3/PhwIzf2MKylWfMKbxYrxb?=
 =?us-ascii?Q?CJzd70aIaPGulqAeAb0hv2Uef6U7GLtMajtaKok8y1tglU+7EsJZUsww3vzT?=
 =?us-ascii?Q?gEhT6UTm1DY/eFUtzt+Y6x9pWVtpgpXdSFkxJvabG2D7Yox7nNJxyAjKm1Uf?=
 =?us-ascii?Q?mkOhXMjDEVkreOpcvOR2ylkjAIMLkoM8xavJF9etZXaxaQ+zFhaBYckksLJO?=
 =?us-ascii?Q?b5eLvz/uio6u+A84taW/QcUHn9TPH+hdzG+QQgcTu84kR1Yx6ADfWvV9y5Nl?=
 =?us-ascii?Q?yUC06Gk1YuDPcs3zm+1WgO10eosjtfkFAaH1YO3UU3lLsVlBhJeFY8LeUQ3r?=
 =?us-ascii?Q?93+PWL2XCkeHdhedP12znzXZi3jTYSeRE72nK1MYTSuAxLC8VjgQCVM1pGwN?=
 =?us-ascii?Q?Wotdq3T+pyu9XszpPrD8ysOKei7xeTHI9WWAz1vCh1eRiWjqKdf6Rj+po5ZM?=
 =?us-ascii?Q?UFxaecPt9KpEltaCud+vJYRPK+fjYXokAkaxaIHCrxI1QpLb4cG0SE/GyqzY?=
 =?us-ascii?Q?61teGFc6ySxAtOgNmw2TqP6Q1v2YYTdftY9nGJVc1259j90h1KBwLbgxh1Ib?=
 =?us-ascii?Q?4UBVu6VTgDjtSAMk4EQP0o39pgbp/llWDKm7W5HntY4kpwHRbY/VD8+bab4I?=
 =?us-ascii?Q?jgHu6+5WDfhsfF07AQejsyaOwsFTVZ1G9o0qhYHbDAW9tYRv4rrPFBoK5KNE?=
 =?us-ascii?Q?JMeg1ASMPU/wf/EBwJjKjuXI+rSxNPWueRedOIepJzTKCm/F7Qr61mx60n7w?=
 =?us-ascii?Q?fF39j2uJ7G0ml/+TQOqdCol7I2ptp0DQn5dEQj/nTAjM93zvoDJsFM+JQ3BF?=
 =?us-ascii?Q?4Q/zBX9vL723cc94uVEcyu6LP8ULceNS6QKcq1Sal644F3ajNKsdLO/twyrX?=
 =?us-ascii?Q?XUCqToUs+ijjzDnGEnOIfVmx4L8mJU5rc9h9Ct51cREbnimKi6qVqGDcr+kv?=
 =?us-ascii?Q?xeCn1h6X3FzWvvXX/iaUid2t0mgHqayqP+5OKR8p1DDmPZ3X5eJ3bKhuQiZb?=
 =?us-ascii?Q?iqjM+qTOHUKrNaRSqKNRM77f5M/mqmj1gz6pC2KU2BarOrxT/ZOvDvm42ej7?=
 =?us-ascii?Q?3SMhaFDKAmihr++JR4pKEoP3B8zp276UNx9g9+1yG0Amu6U048rry8FDBw6m?=
 =?us-ascii?Q?/y6R1TTsQjpHiJAc/HV+c89U2pTHDgTUJsEwQcbwYr6q+Tto/fT/yGPc50Az?=
 =?us-ascii?Q?O2WryjGkeEiN+5IGflrPvX3y5NM5ICY3ndzuTAwP5EUtHR59BJRWEHt4LUp7?=
 =?us-ascii?Q?I7GNuxerZEiWyXgR8ylETcpK9nR0Vi56Wx9lJmYJquiaF7lR/oKUbiIm+rZu?=
 =?us-ascii?Q?o5dxjgwrPmIfnPRMhCqv8ti9iV3AfqUqqkFl4+gtUxUH0ZgNUmK2ZS+VTt5q?=
 =?us-ascii?Q?pHI2ZeafBgHeG6Y6U5j8NZ7lVVOGDg7GS5qW0MgDt8jMQyt5ur1MTF/9u20v?=
 =?us-ascii?Q?U17avpIKv+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0zwUpeuK9Sd7Ps1zcZC2/DrIzuT2567WiLR43RWeyFsOT1Jx1l86cTP/IvvC?=
 =?us-ascii?Q?p23b9qYTTLgDJBFuUauiQM7gsdv4gRfhpxpjWqpKAtuzG15zezJkm1ZxUGX+?=
 =?us-ascii?Q?sAjhGqZ40R+fdgiwT1rnqD9myUzxHcDw5Gzjt2ec34MSHzxe2SkLuMUp+K2h?=
 =?us-ascii?Q?LZRvIGZDWa8his6CFmL+UDXaRX/zjDt4g05l67BJVWrqeKOYwvK6KNqeHWMY?=
 =?us-ascii?Q?tvPebq0BVZ153REUmax/cSNFztb8MqIIpqRZOJ75PySkWQqxm7q4o3YIYne1?=
 =?us-ascii?Q?taCK7B8sLd+wedYafVH70mZXew1luEOYzAtsR+nI5Sytx0BFlWl0nMxhqNst?=
 =?us-ascii?Q?2dST4YYeWPk2P31/n9iHuClgJpjLPnuVTsG/jsMbQLOx1uAmUap/Twl28cXO?=
 =?us-ascii?Q?yzn63ZmOA+gWdSF7l5p0j+HXDm5FSGlS6fIHbAuZDtL2sQJdf3m9WUp2g6fo?=
 =?us-ascii?Q?2fAokUDYBHaUE3nFo/akoOtD98fwQ7e1PVBlf1X2Q2A8q8g/6PrcXtr1xDWo?=
 =?us-ascii?Q?iXAEIYzF1X4tAwtj4vaQqv0pvsy/5h023NEG3DF9dsPoalvqj1mJAzZYRn1d?=
 =?us-ascii?Q?RruOxWgElCqsEhRD9SI6jwEp5UrZ8nfz6PWZdqnfpwoMXNE3EbHFSilnW/fk?=
 =?us-ascii?Q?HlJUtl33Vwo7hECtMIlz5ttKoBlgfvCgWbg1rKAzIPgSq8O46U6xxrvTJO/k?=
 =?us-ascii?Q?tGTSbE1a5RiFR+EMM+YZNQAtv/4I1i4iKGuvGr4J9ZPOaeoVBxI/IgSmvcTM?=
 =?us-ascii?Q?2mH+RV7PtRjQz2E7JBMRpi6Pugta/JINKjps0q2uFd90nsgxh/WG+sMf+MMU?=
 =?us-ascii?Q?fRgLgNYpABeXkFnZd7r3ScREA/NBzEw04nFuByeH6GNWsZELouLoDrZPu1cG?=
 =?us-ascii?Q?fY4zrSVZXCB4PaAxc3G1TMl1aeCoNeFd4qekHzD4wjLG+MiuR3Sj3O570Gqx?=
 =?us-ascii?Q?44Ygyood4tdJqWLdI+a8wNh79jMnG0aDIseGjxrt4Xzizz0FlB38fyQdz93S?=
 =?us-ascii?Q?XKL0BkC88remvVgu2xpsOXzSCmh+p86WVOQaFu1OFvUfbAUSuBiVGUXoAIq3?=
 =?us-ascii?Q?DZr13zp3gIXz8L2OlHMXRDwwvpWKhMs3SMaVl7uNQIEKZ8qPrJQKNd5ipcT/?=
 =?us-ascii?Q?NBbchgGj+wKJIhCsObhUPjIEpYb4bIFPLYdQf1MYc4YjZO6fFCcMohg/5Vl/?=
 =?us-ascii?Q?WyMqOe08ieKp7Sorp9WIhJmq8Pf+i2+lUa25o9ktEQhttrn05P3L533KSzYK?=
 =?us-ascii?Q?nq3haAmO8PWuHfuOP5i7C0+w+v+Jpl6C0YrBjpcmcUzBtgvCV5ljETQnONrq?=
 =?us-ascii?Q?qd9Nq7GELJHaahemoNNFLcnZb+6biufu3YqfqyhcFoVMsZelvXnvGzEEjq07?=
 =?us-ascii?Q?uNTjCkzpujxq/CLzP3fkjGIo1bg7Zo4vb+QhivrayBSus56Y0yAjeZqjmV4v?=
 =?us-ascii?Q?NbEO2DTvncfdOdeJe2lalqyl4lPGHCHr082NtBktu8B95iMjp/hcqW+CoVNF?=
 =?us-ascii?Q?oNdF3nFiX5EMwvQm7F7awp8gU1IXzaQgs/a2m2PMdsE8OtRErs8t1zEB9yUs?=
 =?us-ascii?Q?KCLSBg/mvLIeTBmwxZGOIlZesaaoAhvZjKzgw0CDf+khgJrsKO+JpTY1gG5J?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K5F8f550RB25NXdnARcUgBXGm4R/BkUaW97CZ+sFPaLir3cx3pWuZuEwGXttRfijZ/R9AKZ9xJGB5X/UNPwax7LR4iHE6udTVRxnJE/dXyjA5HZibca/nAN+I+sFo3nSsL5uysgYId/Gc+GyN/+j0EVRYyD72RHzeCu1fMjuFKaB6uokoTkTynai2AyD8TGsVcepmvQC+9GRPex+PUnMHD4YivI9Ry9pUGy/taUAYzbJtqD9nyBya1kw7JVxMf7x1LUV7KRAD1lQnCSZPavtKTPDmr43Ygv+vw8rxY2eReN0fvYaYxm2/5oYRUoKfuKbPHMFSd/mw+dvxPGrTwUG0SHFYJpzScTlLjPOd+0Sk1sadWOJV/ztFY3TKwFXn88GxajJphPaatuVZaI2aWdbtmyArrA/RFSS9qr4fh/VyARCXpOUu4JnkmFPYzMVuUn8csh1zzsCRU+vMBulnctn/+oONDsJ4nfBa9J4JqTAY/Y6ppI3cvba9JSAhTr7TSiFwNHpy02p50sCMFiODtSI1rzaIoBkGSBEQnHANt42st/WLkDEvEYlI9z4XfNyTLoKVDPD/G8A5muERMao9PVuHriq5sz4380bXR66LJpBwvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5232c242-db94-41de-27d9-08dd8ef2ff4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:14:07.3609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9lAFU8wmtX/jNUtC4Spw86paTZgFE0DOSKYEQgMzrcHeJ4dT4Aglw82ukzCCR7xY+frkfsGwGOBuM92PCg2Z9FncxA5xd/cL/9d5R5BMM0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090119
X-Authority-Analysis: v=2.4 cv=HOjDFptv c=1 sm=1 tr=0 ts=681df193 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Kl9-pRb9PRCpSRKwHLEA:9 cc=ntf awl=host:14694
X-Proofpoint-GUID: VvzMBK-iDbXURab0k0PKeItmuIeBqIna
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOCBTYWx0ZWRfX5PtHo2xA/dKh dYs0p2rcaGHV9OkqLjeoSi5QTjjp4Vtu1Pfwyo7ksAv8KRraSU1TnE4W6Z7H01MB6GNfYxIaTJT 7S+coYzgQT5x4bmyZY0y2Nh56dhh5WTNhI+aMW/mleE9eFmf0AWfZDMlCkxU/qtuFVI8K+mNkEH
 iWAqNLy3SiZmBkymrlPyhzRMnnhIZ5USE+BqKQD8JZqmzPO3d2EoCZn2Z/1Y5YdCg2DAlQq90dQ gctGLoZpPGYvbtKxGGWmijkwoptzTuMxKxvcL1EniJ7g87SQ5OF9N9wcZzqsUqam6cpDb3zHbrl UPW5ZwQz5e7UXERLMYpxncIwO8CZ9Rw3qvv+iaBJzLw9zRQRgXXEdi6Buxo21vpD2D/ZKAL/36C
 HCHJFd/MXsWHwZFO0Q9kPNqh2BexObGkKhjv2sn4o4fnxWTIqJHIDcIiX+4xEM9QYY8PJ77A
X-Proofpoint-ORIG-GUID: VvzMBK-iDbXURab0k0PKeItmuIeBqIna

Secretmem has a simple .mmap() hook which is easily converted to the new
.mmap_prepare() callback.

Importantly, it's a rare instance of an driver that manipulates a VMA which
is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
flags which may adjust mergeability, meaning the retry merge logic might
impact whether or not the VMA is merged.

By using .mmap_prepare() there's no longer any need to retry the merge
later as we can simply set the correct flags from the start.

This change therefore allows us to remove the retry merge logic in a
subsequent commit.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/secretmem.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index 1b0a214ee558..589b26c2d553 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
+static int secretmem_mmap_prepare(struct vm_area_desc *desc)
 {
-	unsigned long len = vma->vm_end - vma->vm_start;
+	const unsigned long len = desc->end - desc->start;
 
-	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
+	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
 		return -EINVAL;
 
-	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
+	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
 		return -EAGAIN;
 
-	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
-	vma->vm_ops = &secretmem_vm_ops;
+	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
+	desc->vm_ops = &secretmem_vm_ops;
 
 	return 0;
 }
@@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
 
 static const struct file_operations secretmem_fops = {
 	.release	= secretmem_release,
-	.mmap		= secretmem_mmap,
+	.mmap_prepare	= secretmem_mmap_prepare,
 };
 
 static int secretmem_migrate_folio(struct address_space *mapping,
-- 
2.49.0


