Return-Path: <linux-fsdevel+bounces-55930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4EAB10305
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9034163A00
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B16274B49;
	Thu, 24 Jul 2025 08:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CVe7hCw0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vcfWLF23"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AC22749C3;
	Thu, 24 Jul 2025 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344777; cv=fail; b=Lr9lUs3ny405GFM7RbVqdH2RoM6WP0TumxWiIljcTCiphT0sJhp3g2/aWZBz52G6IO73EnGk7QU2DHdcItog6b4OjBcCTKJPDH4cZcO0WqM5f5pN+PXs3JpijgYSRj/FkTAKGpvan8TcIKIvyCNH0olMySYmYToHuIkoQPzJYl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344777; c=relaxed/simple;
	bh=k6GS8HJSLHDE7TPohWsleG4kRXArAkxiOx1Kih6ci70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D5iqyqthfT0apy9vbVSzp3nv4Zs1RIj8kRZbnxXkU23+TvDkzqcwF4QX8q5LmlIH+C6vTqfhoVvXfYLzSR83rYJB3MAPHZNaWGDaTrALmS4n3OBZ09oE7lAuUIOc9Nnpy4QejLChTiIzMNldz3t2MgzRfqtduWPFVU7E5Q14Fqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CVe7hCw0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vcfWLF23; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O6ukIK030721;
	Thu, 24 Jul 2025 08:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DhseojoRr4OEQaWq8W6XILqCmh8g/Uro20xjUfpIYgk=; b=
	CVe7hCw0XpjJREes5REKEMG0VSGlPoWFxkds7ZsIFGnR7dQKOrMZ8t/cndEHu4Em
	5FP+N9/xDtZ6dcBObjH1eguRAx8irSS5H4nAYTGj7SSwdEgFkHaoYNGj8RDeDcdd
	J1JImBhrLeZN8Dvhc0IAfeS7wM7/Y2Fmi7Wy8LHnqF9UUNTzmXwmswUJx8Q5TYM4
	gL0fnlpo6TfB4oyTwpBtH+FWFdt3g57Ojl42b6Vn7aWYA7b4IWtAddwCi3ZCsylC
	b/N/MebEjN8xAjHCgyGU7Q4u1qVDknlZombmFX0SyHyeG7XAUXMpfjSJT8Pj/L5q
	o27Uciye4uEOObUYfdL1pw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 482cwhujhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56O79eZH010475;
	Thu, 24 Jul 2025 08:12:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbjqv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 08:12:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp2HIYiFX+vdbs18XkrSvWtW43RbHgk1SVyh+qbd8Mq3kHjmCSABxAGPx5BcbpzpbfYLnSdlCo1p9vaLa1PKUxVWKGa6td+ZjhtFnJmhLlzUYDb9KQi9zZrU975g7mngIGvH1mlaaDb07H9jo2rOcvHlqJU/VuFcsicHaki1MvkvxcSzan8M6pccV1xFSC4vgkzfCeDVs71tWArt3Q1eKocIy/mpVlYxddBgCaEAQh7fd5vBRQfd/ojW/vjqDvS6qOQjqXUcXDONeP992z9iQmweIfX31hZqM40pwl9x+MFF6kU74y/+3ZuIB2VUsF4grF1EKAfFTjSOhNdKJFZDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DhseojoRr4OEQaWq8W6XILqCmh8g/Uro20xjUfpIYgk=;
 b=QlYlV0Wxe8ehw9yU8NdMvNUm38DeU06AT5FzbE/bfklakFSfMUGLlMnLzI1KNcce2HOLD7n0gQj47Vw5/UVxvldOoO7JKNA8cypm4VgMU3GXI8r1vJ8jmlhfP8l3PBzl5OTKpXTfW3V+eH7HppOxMOIRA5lDctaUYcvEObCOkItZPDmY9S4TBzQftahhImJeyUraqdcaNUv+1flhI95HWBCCKUBEsJ2yvv50hXE0E91FBRfblQnm7hnC0c8pYFz2mAYnc6ksrY2QHStBbuQg1nE3dlX3e5nTddKn/h8d9aii63uFnDvwoqZ3V66PgVqc4yr3KBAy5FPKq9WrqMgHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DhseojoRr4OEQaWq8W6XILqCmh8g/Uro20xjUfpIYgk=;
 b=vcfWLF23/7oGFSZ4xJX2UmXOWZm7/oedWeIJFOKr3I5FLAgp7l7oV0lUCORRBY+rvBPFCpdzyg2nRlgT8x/aVl0oJCynd0OHaU6eGFVY5ZwK3/yjdqPfT4aUnyFotPbnNIJ3MBTMCsx1y//fWA5GWATTLqqIII30QTVxJ0nRbOc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by SJ0PR10MB4815.namprd10.prod.outlook.com (2603:10b6:a03:2da::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:12:38 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 08:12:38 +0000
From: John Garry <john.g.garry@oracle.com>
To: djwong@kernel.org, hch@lst.de, cem@kernel.org, dan.j.williams@intel.com,
        willy@infradead.org, jack@suse.cz, brauner@kernel.org,
        viro@zeniv.linux.org.uk
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 2/3] xfs: disallow atomic writes on DAX
Date: Thu, 24 Jul 2025 08:12:14 +0000
Message-ID: <20250724081215.3943871-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724081215.3943871-1-john.g.garry@oracle.com>
References: <20250724081215.3943871-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132F0.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::33) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|SJ0PR10MB4815:EE_
X-MS-Office365-Filtering-Correlation-Id: e594da89-50a8-4a29-24b3-08ddca89da6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DslJ59n9fVfuRAp5YXCDKTwtHWpq+NWnWVRo+yw1YC/QEN37BzIsXgZcTCQe?=
 =?us-ascii?Q?8Q8HiT17pVCL8OlrENT3XNA5Y61Ls5vc+B115CNIRRwIsNtDltvDWGBaTUcI?=
 =?us-ascii?Q?p3pOrx1kb5Zk6qqFWuAiWCN1PN1ofRZ2piONmdtmohe6zERjXx2kIqrBS0EL?=
 =?us-ascii?Q?M00WZsNXXI1z+twYg8c12121cauamFSF+5aewSSCAr/Q3ylyxei837LkCdvo?=
 =?us-ascii?Q?uopm3l87oqDhKTW/vYFKr/ykcgv0PaLya9CG6pmFoX9t8mcLsPWdtrt5sPcq?=
 =?us-ascii?Q?h839Vlje0SqPEyZLFqdQoKEVwdEo3+E5g4LVxARMoPRdIq4pssXWW1y8jkzu?=
 =?us-ascii?Q?k9g8W2RGBN989AqwaoXnWAooe/7OvRIrKVjQeC5wCu8h6gMkQdEFb1RtO+HL?=
 =?us-ascii?Q?tTXNNogg1Pnke3PJMtJ4Lvj7QLXP0Kf6Ct+SKMuCgDTrOuWCxSuuKu7H7dkl?=
 =?us-ascii?Q?hcAkNC+Ju8lNuuJFbKOcC4trGQ4PkS9Hgq8l+KGRFxWrgQT3pnjGgs0vDZ/7?=
 =?us-ascii?Q?c7nQbfSQfjIZS4d4ud3Xb6z/XqWDBltDq1B1VZKUhfe58UNbpaKYoh/cttWp?=
 =?us-ascii?Q?f+FIiORmlY2l+1tX/KcB6Kl4ngKQrPgd6R1nXfnit6JwtQ42BjL6eOXBN84H?=
 =?us-ascii?Q?TB6G8sFnyomn3e/zuvRek5GoInmxSmmmSdwVcJhXWeZsoXCjHda5IE9Ntq6W?=
 =?us-ascii?Q?CiqielikEa9V+0YTQopY19KhngyRdWK15LL2R4GCEVpTCClKcMdJ/TwCUmVB?=
 =?us-ascii?Q?wnkAd0uNdFId1PGIMTUGqHKn5WSARhVDSTPQ3CsKFx4mxBD1m5vTSBM02Dbk?=
 =?us-ascii?Q?sK2M4oJXiuEQvWY3XwAC8so6KjVxPk9JluW18Pqeh+hihJoigM0PjKqjFXV1?=
 =?us-ascii?Q?aBxE6KmUz+4sD8FnLpTgHlrY8Sl2jgDw2AwP1sA6mwkMeH+J6quYhaHXOT0j?=
 =?us-ascii?Q?yE9c22OL5LLx6KJ4RoRdAifZBDWdm/P4SH3aVV+G+EDeAF9vyfzA1HcQauOb?=
 =?us-ascii?Q?2l9nZvKdDC/NOaYs9A3Yjm2mAEoDmhN5gzKr/zFIkY5dHbtdFg77LOLqqvLW?=
 =?us-ascii?Q?bKfMJNixmwY0huCfOc+ji1+5ORyH1g7FXldYZoA7WgaIPP3Hy/LWyNUBXQLC?=
 =?us-ascii?Q?wjhnfEz7i5BWFkxTqlJKIdgPDflBWo4LWU1trCJy0ujfylOcW+60CCSbEfOm?=
 =?us-ascii?Q?FtaXx4UTh4ViUqjrZLwwnMk+vhMKn5k0mUiv5//xTdpzjyfSi7jHged57ITX?=
 =?us-ascii?Q?zqzHNCOV8/WXkeiHd2jI3OQdpLdpYXqBNqJ5goUbTlXAJijevMbDOXXwbrqz?=
 =?us-ascii?Q?NZaAPSh0CO0mm4mdJnJIEhi1w68+fSZrTsyaGevxAIkbeCSTY4UC4zUmZqgm?=
 =?us-ascii?Q?eDA+rl1xAAhONrY4LCuDA9OWE/5FUexOGN2GVoZ+kKyuNfkfaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n9i6ehdsQMKAyUqudDFzGy1qguLfO7PVK4dfsFHb3AuemMqOtvoVLnlAJYjq?=
 =?us-ascii?Q?4iRZBTvkd/D4qE7O/vjoYJaQIi/dsyfDrXt2GTPc8B5RoYEP0C77A2KoMzL1?=
 =?us-ascii?Q?AoQj5PLNBnUetMvr7qUBoBKHQjOX3wzIaVoEl3wCKsmPo5OcWBhWMDxFeeqF?=
 =?us-ascii?Q?u78T3IRLHEMRHysgosMEaiPbs9oZMSDIY2uHqmWsNyJEVlhN8BeuuaDok54P?=
 =?us-ascii?Q?Gw+EbE8Q30AYsaRm25zq52aQb4p9YEeq7OECsHGCOIZyvehPFAvupqB1uD8E?=
 =?us-ascii?Q?TcWaGTnGwJ2/ekr7iKXLqW3frDemopzyTt9yUZ6b3m0AyvKBcnv4mAEdTlbr?=
 =?us-ascii?Q?5XEWy9uJuoaLxFqwiBWEGcsCylXb1zCBfdPzX+Gz9rmwfblFFK87bV8lbknK?=
 =?us-ascii?Q?/nean5a1bHiFQU5XfmcxlBDSZY78nwYF+9BdUlIQ39dqsPU1yZETNL5pHbr0?=
 =?us-ascii?Q?wb5Ia4xeDNipmruIUIe32rF1pOjHgiyFmyWbZNsznLoe2NufRnCGNHv1YY40?=
 =?us-ascii?Q?YNHx+DyjI923LdIHmRUQqmUXud/jLkBVSx/lJTzY0mi/Zbc5SzNGQXAR7HN6?=
 =?us-ascii?Q?5MqYKDMHZWco28KFkb/owAsG2P55mTztRPW8xoisf5kwl7Bq5fPCSlgRCgHz?=
 =?us-ascii?Q?j0No9FHb7W5t+Yct8c815qb9BqcHRl7TlamzSWHYI6m2/4inIR3q10J6Isws?=
 =?us-ascii?Q?dM8pJcTaxHzNPErYyESWcwYeOqk7GadGY1Lxh/ft3RbjUntLbx/BmxnzF5Jg?=
 =?us-ascii?Q?AUWXJ+Wi6oQJ0swVtTHtR8StTv9ungId/mR7geWQjCZL6Vo7GBWoTNPUA+kL?=
 =?us-ascii?Q?MtksRkpyuWAOFjjl/46rNBjkmw36DdZfSJExGJRMlsxHVwfqueKgZC2anoYt?=
 =?us-ascii?Q?ThsFP+zTzNhs93DlR0+V5t7AQFWs6eTCJhapRNSlfesThlqFjTvxDzI5Sj89?=
 =?us-ascii?Q?HMjEE7PMucoJWHhu2N9neOsQgahFD6t23yWyQVC4re+yeln+TRdTl+uioWEs?=
 =?us-ascii?Q?7Tju5D9/xGNykOTKa4mM9/CncboC9KLln9eYRAPSE3gS/+isWTH+kGZhUnNF?=
 =?us-ascii?Q?MBLR1R+RMXrDVwZhdCAr2w6nqFiLAVnib+/46YdWAyJhVBwcnLLBPr1XstRU?=
 =?us-ascii?Q?85xRM5VaKbNiN63tfn5Hro03ZSCLZhqxOka7FRn2IO3OxprWCOxrG+4e+bXU?=
 =?us-ascii?Q?Cp1cte6tfzUHjdrVy6QiRn4toINjblWHFtrMpxxq07wMMbrZ+TQRB73lFRZT?=
 =?us-ascii?Q?FgDoIB4IjYm+1tYAVNyv7rGWEA2GA6q/8OIW3Z4NvIncPjYi9x3TmYd9g8lQ?=
 =?us-ascii?Q?QURWfVksTWy045g3GDE9VvAtsSYooWZ8eAR7hgfaK1P/t/NAj2QtpZM+26Jx?=
 =?us-ascii?Q?uO48oeIuP2JOFpFCoLqFyiNUI9GauOWsTlRTcYJhOK0uxcDLD2lKPGdrGzR0?=
 =?us-ascii?Q?45+LrSbT/drzXZc2Gnb8SaTA1NLBxwGmazy8zryL/OSMVth8DCgV1l+qbe9A?=
 =?us-ascii?Q?BlE6tzRE82T4VLZ75kB1fFutOW6ZFWNHunC2e0zxXGesuXvYTulydHf/t7hY?=
 =?us-ascii?Q?/njclxq0NxIs7WD9VKRlG/KTTMOf0SAaTbY+PUCy9t+LuSprXJWaEL/bVkqD?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kLWxz9uH2i+6Anp6muE73//taX1OBduDtuYzqflEGC2JkqtilDUL4UPR9z8z/BKuRU3N703fVjcIl7xFdbbujVnPj1BwvmcgvRUl6hiW8HYaFr8r1ReiFlevcUO2IC77FDiHqvVOzGVHH5pwUkj4u0yGnwvFhKSL8OhT4gI0YsP/+n00rh+rntSkHNlhpVu7LTyp11xTzElCVmwygNy+/Wu3fDbgdWvIWwDIzB2q+wv8pOAmF+OK+Cl+tIt034+CLaRQgfEma0s/NGHl+jWML2hPAa0JZ1/TSUT22Kh9gJLbJ5IX/7JXkLwHKlIcpYOykGZjVx/I8zVpOHzYHVIkw33WmARB10beL599xeeM7RFVd1Qxsm7fP5ImfXrqMlrPzyOb83CScQp/5djVWwsoo0IUp4Dr7l+x+Me30tgltUhAyWvUb+zRnHBtTo1ATLNPHc38fSV/Jnz3g7PVwFH+DSSnkvMaCiGMlmRu0RfiakdMxeNLRgnaAP2Prx3OZ4AI91nikoMNDcfXPS8Rlqf5hURI4ihqViu/1Svo+tZukbjvxJ6arFur9WnIkj0wbXH1cOYiZHRBajJ+O73hYuw6m4gNnPy2l9lVYSXGeBuzc8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e594da89-50a8-4a29-24b3-08ddca89da6d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:12:38.3739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hGTbhjoOggT1h9wx7TQl8eQx+wPr20s5/TBaA2+LQ57EZRfDeE+HIyUQrWcjqSdYf/FloG+lfhqSvpcUJb1EVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4815
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_01,2025-07-23_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240058
X-Proofpoint-GUID: Z4DtWBtfNy5YEHKa8slklX5d2nTg-NSw
X-Proofpoint-ORIG-GUID: Z4DtWBtfNy5YEHKa8slklX5d2nTg-NSw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA1OCBTYWx0ZWRfX3bNe6cl4rggT
 rzwkZYCLwsXYGpVaI69ovvl0FWvrPTicTVbGghHuH2nmg8KKu8a4dZqAlnSouwvyd5ZI6jf1BfV
 zMboAmff7Qlmos47E8t8zHBAyISAy5LRKz7QsbMXLs4h13oiR95fBMcj/F9pZ5h+eEPG8D6WT0F
 wloEDaEFthyLqD+P82VgS6Jah57SoWAz85ZyyzkKJ0NAyahbVOzgnC7ipQNOJ8/zQvu2ypYcUtX
 9XJCS31pN6vRBKf74XYhoFHAlT9l7uHGnITX5pjDnUUkoyJ/Ro1fsO3gh7LlfvIMyq/moQEiVoj
 c/KeUWxzAH6m/4XEuIbMaGIRQJIhwhpP9AbcNGf/aXO6LN3EH2lXJtXuDwvMS08OBfwQlA2ZFpI
 dC1WzkiAWowQY1w9QRwCvayQmWeAJ3phqmViEA+JtDR/+clsc6JhdB3/ZZwdWxkBGuDrsHKR
X-Authority-Analysis: v=2.4 cv=IPoCChvG c=1 sm=1 tr=0 ts=6881eafa cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=gOl9iw8zJ5YvPalRciMA:9

Atomic writes are not currently supported for DAX, but two problems exist:
- we may go down DAX write path for IOCB_ATOMIC, which does not handle
  IOCB_ATOMIC properly
- we report non-zero atomic write limits in statx (for DAX inodes)

We may want atomic writes support on DAX in future, but just disallow for
now.

For this, ensure when IOCB_ATOMIC is set that we check the write size
versus the atomic write min and max before branching off to the DAX write
path. This is not strictly required for DAX, as we should not get this far
in the write path as FMODE_CAN_ATOMIC_WRITE should not be set.

In addition, due to reflink being supported for DAX, we automatically get
CoW-based atomic writes support being advertised. Remedy this by
disallowing atomic writes for a DAX inode for both sw and hw modes.

Reported-by: Darrick J. Wong <djwong@kernel.org>
Fixes: 9dffc58f2384 ("xfs: update atomic write limits")
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  |  6 +++---
 fs/xfs/xfs_inode.h | 11 +++++++++++
 fs/xfs/xfs_iops.c  |  5 +++--
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index ed69a65f56d7..979abcb25bc7 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1099,9 +1099,6 @@ xfs_file_write_iter(
 	if (xfs_is_shutdown(ip->i_mount))
 		return -EIO;
 
-	if (IS_DAX(inode))
-		return xfs_file_dax_write(iocb, from);
-
 	if (iocb->ki_flags & IOCB_ATOMIC) {
 		if (ocount < xfs_get_atomic_write_min(ip))
 			return -EINVAL;
@@ -1114,6 +1111,9 @@ xfs_file_write_iter(
 			return ret;
 	}
 
+	if (IS_DAX(inode))
+		return xfs_file_dax_write(iocb, from);
+
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		/*
 		 * Allow a directio write to fall back to a buffered
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 07fbdcc4cbf5..bd6d33557194 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -358,9 +358,20 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 
 static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
+	if (IS_DAX(VFS_IC(ip)))
+		return false;
+
 	return xfs_inode_buftarg(ip)->bt_awu_max > 0;
 }
 
+static inline bool xfs_inode_can_sw_atomic_write(const struct xfs_inode *ip)
+{
+	if (IS_DAX(VFS_IC(ip)))
+		return false;
+
+	return xfs_can_sw_atomic_write(ip->i_mount);
+}
+
 /*
  * In-core inode flags.
  */
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 149b5460fbfd..603effabe1ee 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -616,7 +616,8 @@ xfs_get_atomic_write_min(
 	 * write of exactly one single fsblock if the bdev will make that
 	 * guarantee for us.
 	 */
-	if (xfs_inode_can_hw_atomic_write(ip) || xfs_can_sw_atomic_write(mp))
+	if (xfs_inode_can_hw_atomic_write(ip) ||
+	    xfs_inode_can_sw_atomic_write(ip))
 		return mp->m_sb.sb_blocksize;
 
 	return 0;
@@ -633,7 +634,7 @@ xfs_get_atomic_write_max(
 	 * write of exactly one single fsblock if the bdev will make that
 	 * guarantee for us.
 	 */
-	if (!xfs_can_sw_atomic_write(mp)) {
+	if (!xfs_inode_can_sw_atomic_write(ip)) {
 		if (xfs_inode_can_hw_atomic_write(ip))
 			return mp->m_sb.sb_blocksize;
 		return 0;
-- 
2.43.5


