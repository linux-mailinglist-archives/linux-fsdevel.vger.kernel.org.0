Return-Path: <linux-fsdevel+bounces-55274-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E064CB09271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09EC4A619BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121592FEE17;
	Thu, 17 Jul 2025 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NeT2eYH1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xrYOg1fH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967F92FD59C;
	Thu, 17 Jul 2025 16:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771462; cv=fail; b=tqbwpjEcE7ebs3mYqyuUn13nWDnv1rwTEs1oQEcbbFsoe5UZFL0xQLkunbIaTykI62DoY+S/fBYikHmp3pf9iXAsdcx/TalgVdPdx5cyLwCzuFYP1o9PcRwVelXPBndEQLvlNnlCJ4xMN26i/O7cyNJJ7I3P4m0cIat7+Yj2pa0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771462; c=relaxed/simple;
	bh=+v/OgkLMWKqVsBsGua+0aEe2mdbNsFGqtAeEsXpDpFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5HqDSgUORwuzhk69JKJAKFUJGiIc/GYNAVvhog13p8s8J06TdncWfUY36xkHFhipBhlWPbMD7aczhn1ZD2mt9a7uDRBkaOYPO/lBc3uidtaeQabM6ToRXPCiMNx6D4okdqn/bqoWHS9GORZIVcXj2vqVSp8QjyNGRIoj0kdykE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NeT2eYH1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xrYOg1fH; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGBxaa001340;
	Thu, 17 Jul 2025 16:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dAG89gukQEwo2VOlxn41My9GaXocu3Pj5b39ILPto1Q=; b=
	NeT2eYH1g7TwA9Pl08Dgk8jjS8ATL4N3R64G4udaks/eulH+qBF5Sctl55W3pPGO
	prP4tNqckABTzKSyfnXmzjGMi2mC4bWoWm06uHH529FAVZl5qikM2yWHrrvra4IP
	HKTRzmxeI4hJMn6LPhgpVDDO27fzQbFYClRvkTnKmA+3Zzd0SHSTo020ru/1UPuS
	Qr5ndVbcoGU6pQcrFdHDSZF45rQ4nBguSBqkO4JVr0R0yTqEe5jH1vEYqD2wnKpd
	BuhdcGDw3RiYwoN2dhqr1GVUDGdMMJdC8NQVp2mZjeroJxCMy/T9qkTO1Z79wksI
	VdyMwdJCd6M7l8dbSk9zOQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfc4fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HFedQ7023999;
	Thu, 17 Jul 2025 16:56:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cxysp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3gJFySccqWieOQ+pvhfdGB7h6vci2qYmEWDQlIzg7HictYyDK7eg9+hP1uIfdXnMnsVga+Xtdiv3QG+fBtO6y4AXDTfr9n2V8TROIQSFDn7VdSnCOvmbgZV4IO2tlV81/aDSXjTK46sAel6FabTHoFnimulk7mU82UFGxb5VMfLSglricbo9WoKo+BXXkYHQp4cRg00h8NS1c72g1unApyWvnY7EcC3lNcV6qRZMdSE6K8ruCUJnoooJ9HzkHsMdFYDrCLCx6JSn9vJhVw8bPldV+Z9jLFZ1mEI5ip6kbft8hNyuYX/v9he1rNCpBeAMmNbJdD3lgfbynY7zlrSNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAG89gukQEwo2VOlxn41My9GaXocu3Pj5b39ILPto1Q=;
 b=dG5Ct3a+aR/xH5ENbdE9TiLm0yhDF6/QIXNPYGXMt56nCadelnnhzj52fD1Cu+MVHgdFyh3lUcrlWJ62c/ofw3uLhzZY5Gng/27Fc78H9VsQhZFBV4TWZAbBJqCfYNoXE6ukKkhCsN9cFI3doqsQbsLvoi5yr0f8LRns0eDlZH3ksRzrhuBDip6eZfu56iSEbG8o15xraJQn46VAzZTatAvWORaPgWF7VWs1/wSN19CJayrLY0gcJexjPSiOoRIE8ybsI+YCOT2yanx6yd9BRuBZ+FMPAsTapLPfLk9Nw/PEEG+eQJHNUCAD5ezFJineUvURcFL0RH39IdRtTJrtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAG89gukQEwo2VOlxn41My9GaXocu3Pj5b39ILPto1Q=;
 b=xrYOg1fHg8lZMYq7bQf8I+QXoyMhmUQ3ZkZfn50/AKrbGB7AHZhdkNCkczuKOapnLxf3rIzJ+F2HDpEIQt9Cer23gVqbD1oayjyad74LP1xBBOQcY7UZcpePv9rh/DXQMy6169TZ2YrnhW0TfgvGxYfL7HkYJvkJoaodKeADDHo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:23 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 07/10] mm/mremap: move remap_is_valid() into check_prep_vma()
Date: Thu, 17 Jul 2025 17:55:57 +0100
Message-ID: <4d0669c23531629d8ead42aa701c6237bd6bf012.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0621.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:294::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ed4b9bf-59bf-4338-0389-08ddc552dc58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gHQa6Vqi2vPWdymCkB7/ZsCIbfCds3L7AtoKoLapeKIIeldwKASS3km+REpc?=
 =?us-ascii?Q?RaVcPFUoVdiaCbTBMDNMwTgU9CEo8NmWWw3E/BWbi7khZ3MdcrrfA9uPmFfP?=
 =?us-ascii?Q?LEU3xddQD/zO1+8hxQpWQP1s7VWZvgfBH5YXpiRKELp7qU9HmdBXT0NSkQFx?=
 =?us-ascii?Q?XDTesR+JW9pKwQkUQYmJkOPOKYvK2o8OYVRnpk3Q2Q7+CkvMuFD4qx/7SbK3?=
 =?us-ascii?Q?BCJdldhxijcrRIQE7Z1D2JpcsAXKiU0Zr9TSTlEYWNkXSxNDE3Cbn1Dav5Sg?=
 =?us-ascii?Q?BUAjFYilRJQ5h/BLO0mnmQnuUZeGroPSrAfdljMJzbmTnXDhuLKg+Tsk9aig?=
 =?us-ascii?Q?2+Qr6Zlwjj+kgy2CV5dZOeWhDsDizkxZeMEXsuQlHNWB8PIIAkw1mKVoYCmJ?=
 =?us-ascii?Q?nm1TyBK6S658CSSlBofAoAcjAFuLc8lrNheU/qhORPwG3vKNw4noSb15a1KK?=
 =?us-ascii?Q?lDxjbmY/am5s1KXV6LRNFVgkHmGMdLB/Y/+Mv9g+R73mfh2N7Qt22cpHXL3P?=
 =?us-ascii?Q?b+pZ4xbcQKlOElqJJszXh7477oIL+3mNggrSLeAjCe6Wl1wntWz28oRdU/4E?=
 =?us-ascii?Q?x8q4hGeUPPpaFPyB+D5zrDSouKn7AZFwj4EdD3QHmaTGl4XFwp2f/ElqXFwS?=
 =?us-ascii?Q?1tQ9hZu8q9N8Pi9R12MZf/pLVXtOjJkMBmlSCFZ/pMocLHoKiTE3uO2KmV04?=
 =?us-ascii?Q?xz4MwDv5t/2qvfIqJA5dF8Yv/L9fydSuz9T4K87JoHJ+hmfa0nXKFf1fVYAk?=
 =?us-ascii?Q?+jsHNYNaMqap/32Ic3HOW8gE0rkLMRNhelHtEscoGlY8RSmu80NvBqnTMhWx?=
 =?us-ascii?Q?Mma7Um3sbwAgZlQCAH67lBpOCayaB/cuNXcLcXFFWqaRYErYFCqKPpvKEmSq?=
 =?us-ascii?Q?9noI52qAbjTFbj6SUKRTBZbYB57BicsgXLn6YYLYIfnShplzFQL2A/LA1Jrw?=
 =?us-ascii?Q?yIzPOLTLekmGz+URfhm1SwqvtZ5foQC1HeibxgRRCvRSBC3s2jlVVGaNNHVW?=
 =?us-ascii?Q?VgB0ThPNucuobW4w8qz3AEAkmJB3PeF7ZtIU6AhMHjUKIwnG9qHdGM+8x88D?=
 =?us-ascii?Q?DENAT2QSSsK+PJerua9ir7E/nUYoDhI0O5YLrWdJyD8vsrq2xIruQ6/UgN/J?=
 =?us-ascii?Q?8W8nmzXNH6iasAw/KIEQyZ7AY5fLG5+PP6IXTTSiBAubeeTOlpLnAwEk1XkC?=
 =?us-ascii?Q?TLh+Z1AlXWzgwuntyb0RmgGLR51iu7JeCNuYFX1eMOAUquRzlN60YaQ16dkO?=
 =?us-ascii?Q?HmKmqauGZkLNP3+8qxNlwHl4/hDTtQKtp8rarPDK913DMmV+dvNv8feeQGof?=
 =?us-ascii?Q?cPH53llACniEVFx2tdc91Oa1zrSE2JxfVb3sLBjmmn8OrMFAq181R0kiFUZS?=
 =?us-ascii?Q?GWR6qoT2h+Y69v7JI9uk+hqX37t8u4chDvHlPZanPxZfLwY3asY5D3qfS+cj?=
 =?us-ascii?Q?qf9C2ilM2jQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?41SUjccdHVVOry/Z21lPZdS6BSlion4HTbc/BKlY8VCdJrkjZwaMqnj1uPo9?=
 =?us-ascii?Q?sv6e8skhD5+wISXHs+Sxm2LqFboWuDEU8NWlXq8T4YzlcG4QAyaIonFA8V8v?=
 =?us-ascii?Q?m4Yu9x/SMjHe/ICQr6gtC5q4WLYHQlA/zS5Lyl3U6EioNtVaST02m3xGt2Bu?=
 =?us-ascii?Q?pCmTNRp/gIBP9/xtRvD40hILL3GZlinCQzLoqiPBuS52F/j2dDVQB8EZ378c?=
 =?us-ascii?Q?fSL5Cch5jnOrCx54rb2JlTF6465l/7zXjbHTlafLhkz5DF7xX0MDEuNINBgz?=
 =?us-ascii?Q?3DaDKnYuyRrAj4pVAJ3QnGhQfxfoUjzD2mWwaE64keNvwa1pQ+844e1ZLvKU?=
 =?us-ascii?Q?l3per0srsWzFz6M98Ih/A0yi7Jprq5cWHiHa9rkH52cjJx8A3JBzmnJrsVCQ?=
 =?us-ascii?Q?OFnoRyTS7sAyxa7oFWN6rjdrZb6KLjEXnMPl7LwNqePPEo7KgPw6EFuA/HQ/?=
 =?us-ascii?Q?luek7fK1sA9yuJEhhVizvGSK23amH3CEAn50n8Vw++BkS7W0CLX5I3vieiXj?=
 =?us-ascii?Q?+P+VUOoKEaeGDU5b5pYW0c4h4jMCwKCfEhlFi18HhzfI4XOouRj9AvXLm8j/?=
 =?us-ascii?Q?xa+MgCLXJbKbI+kgNkEKRRHweVMoebJUCgSkfyv5urOZFiTlGxlC8A50OFG9?=
 =?us-ascii?Q?Wdasnp9YTLdyihMZc2v8gyU8q6EyQUfUJ141LDtgda6+gyX+z9sL7WdBuqeg?=
 =?us-ascii?Q?06nd3UGs7I+sSOshg/u/2SeFhpyyJ9a4Apu8xCcNvVKtKEOOwgBk1VO0LxGV?=
 =?us-ascii?Q?FQvuTvcuq/KuDI8fnEn195fu4GYFNZHcFO+0iLJ1CeMAbE+v463rrYRWS53c?=
 =?us-ascii?Q?DP0XfwV/XMhAnQnYT9G9FAPsW1CawKuusQk5ESvuDQNvJFuc4VxBJCXCEffj?=
 =?us-ascii?Q?C+48w7uUGHwMav/szFUxnUHkcmHEBoQ0Xfs/cGVdhVvt7huV077j0xLXhXiQ?=
 =?us-ascii?Q?pcsHXGiltp+2Aq4hzG/SfxqDievujRIJMvXcgXyiOtYArfPr3LccinOMBrwc?=
 =?us-ascii?Q?2vxR9ZiPOuKhIJh51v0RuDu2eK5CKS9NxLqvjxmVsCp3ePyDj53bQOPwuVlB?=
 =?us-ascii?Q?As8ThKLDQQ1DO6iI7f4Y/nyg6FTU2r+YC2AInAVB9YPa1GUOUke8e1QLs7QE?=
 =?us-ascii?Q?eQKMfM8O+I+7DEBKVbbJDzng9hsTesec+ujOVplcbqHjD3f/gMR21Xj2Xg9I?=
 =?us-ascii?Q?s+WQoG9r4oT1/aGpGwR/GeFl971Y+O66ag5hIDPaPjK5QUO3lwneoxZV1Cd9?=
 =?us-ascii?Q?TOeuPoGSaG2DDqenEGal2TRWjNZflgUly2Wk4XWNN/L51wFg7lA8kRWMBJ7n?=
 =?us-ascii?Q?KVpwmw6kVAhhOFYxPhR9MjYnkaqXp1GvZTrBndlOoA8V2e1xxA0bZbvtQVGX?=
 =?us-ascii?Q?W5DlLhp5YM0pZGWwFIilNCZlJZnEeRKxMzXJYv7BuOyLXjbiklJnse7tZ78L?=
 =?us-ascii?Q?MV2A3YPo+pmue/5s8BMCJWyGaNA+nBZzSCxr1p4B18ex0PsC0om1hBSXM6qb?=
 =?us-ascii?Q?atn2Q1MYLO2WvVoNKk2BTu6xJGUxAlnOSHVmpmV3JBc5lBjyhBsYYTmCu/+x?=
 =?us-ascii?Q?qkD1SQs1J26j0S7vtRnw8U41c4fZ0UtxA97EU93UbMn7kuy+SLA/c5ZMsyS8?=
 =?us-ascii?Q?BQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NlAgGMOdIqe2JFLojQ6Z/57s20GAbY4PdxTPnUiAOj2EJprOZwdAq8aOzpOrzI8mypXM3kinqr0XBWdNGypmle9gOIIHcBqIVYOhPJuonXNKGz4CM8MF/xptSZt6akcfr1jQDPmWSNgnPQ22nakxm1GwDBcjy2dy4/BtefL4s4H4w48ESnuMj6pyWMSR+3cI7IdvQUw7P+fkdtc7H+4cVlfCWo6Xv7e/GaKK2vjfGvsw8ePe2AtD8IsLr3jtxP+DPyHxyZoX04EcUGAOjBIZiWdL7iCqeNYmTrlo2i9JMWkbcBtZSXDkbt4VRgCRbDvh01Uyrc3s61rSGkcTohnNaYLMtfoXDboX7uVqxuAQ9Hfn88cHcTnhxHNW144SpwqXWAqqvkGdeLHhfT8oHeP7ryy2Grc7QgiHRWfuqXTqejUAvYTwrXu/Kr77PnIcVL4/MiVclUPzvQTch045cjuHlTPXuHDhVVII90feBH7YDdJiSmOtdyDMrR+ZmNwcO8DQsBhC7p0IABA/lSVISGqPI0WmXseXP+CcOl03FO+CKkYPW8giQ3rHMKrYQOS7q1FbkZ6K4uDlgVrgmnWK5gRXQhBpHEc1dkssfO2qmttZ54c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ed4b9bf-59bf-4338-0389-08ddc552dc58
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:23.3014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y44um9pLyjC4knw7dXyi4483/PN0RvDXcG/e6+fVSlGSHQ57F5D29ycGTVjpchSUUaLFIQF/HlEoDbDzTo7BeTvn/MRjCDfq2S50t+dH5SQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-GUID: YR2rv0KGEvMTrqmELX-smq10i7PiAiRb
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68792b3c b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=D2aI9kDP5h1zwDkvlbUA:9
X-Proofpoint-ORIG-GUID: YR2rv0KGEvMTrqmELX-smq10i7PiAiRb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfX+/NCyZ91BOHZ BZJUJGGoLEBNlo4Po+MORzBzgVyhE8C/mHB+RGVvs+qDc7BTjcthA9D8mu52Jhf/kmI5bL/wMMC RN6BewUg2UkijISqgRThP5qB9nzXqeBs4eOVrlmaR4lwjcJHj114Kl5wwkc6zCXqrPTN4CmPw2+
 LqEngLpym7BoyMraHgZ6SorwZMFW02BUe31dm2L4h7akDMkDCw7io9k6OER/aS2R7poVwtCpD7R p4jsgKOO4WPGkF4YNIndnrJ3+/MNyuRGeBuOR4tD7+kD0+X2Q9Io/nvBfmPWTXAxKITb+mwBo98 x6rS4SBTxGycaL0sv1qZ58Qyfy+i1WdtSVhdbVmszE4k7I4Xzseaj6TX01VWBykey6mt6Px5Vns
 K1ZJbss5FxbsYbfTls9EDjbrdhwgGXJKEg+2BFXhCtr2eYgsDGtugpk27O99uf6FvoOeDIUB

Group parameter check logic together, moving check_mremap_params() next to
it.

This puts all such checks into a single place, and invokes them early so
we can simply bail out as soon as we are aware that a condition is not
met.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 273 +++++++++++++++++++++++++---------------------------
 1 file changed, 131 insertions(+), 142 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 20844fb91755..3678f21c2c36 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1306,64 +1306,6 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	return err ? (unsigned long)err : vrm->new_addr;
 }
 
-/*
- * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
- * at the given address.
- *
- * Return 0 on success, error otherwise.
- */
-static int remap_is_valid(struct vma_remap_struct *vrm)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = vrm->vma;
-	unsigned long addr = vrm->addr;
-	unsigned long old_len = vrm->old_len;
-	unsigned long new_len = vrm->new_len;
-	unsigned long pgoff;
-
-	/*
-	 * !old_len is a special case where an attempt is made to 'duplicate'
-	 * a mapping.  This makes no sense for private mappings as it will
-	 * instead create a fresh/new mapping unrelated to the original.  This
-	 * is contrary to the basic idea of mremap which creates new mappings
-	 * based on the original.  There are no known use cases for this
-	 * behavior.  As a result, fail such attempts.
-	 */
-	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
-		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
-			     current->comm, current->pid);
-		return -EINVAL;
-	}
-
-	if ((vrm->flags & MREMAP_DONTUNMAP) &&
-			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
-		return -EINVAL;
-
-	/* We can't remap across vm area boundaries */
-	if (old_len > vma->vm_end - addr)
-		return -EFAULT;
-
-	if (new_len <= old_len)
-		return 0;
-
-	/* Need to be careful about a growing mapping */
-	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
-	pgoff += vma->vm_pgoff;
-	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
-		return -EINVAL;
-
-	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
-		return -EFAULT;
-
-	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
-		return -EAGAIN;
-
-	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * The user has requested that the VMA be shrunk (i.e., old_len > new_len), so
  * execute this, optionally dropping the mmap lock when we do so.
@@ -1490,77 +1432,6 @@ static bool vrm_can_expand_in_place(struct vma_remap_struct *vrm)
 	return true;
 }
 
-/*
- * Are the parameters passed to mremap() valid? If so return 0, otherwise return
- * error.
- */
-static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
-
-{
-	unsigned long addr = vrm->addr;
-	unsigned long flags = vrm->flags;
-
-	/* Ensure no unexpected flag values. */
-	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
-		return -EINVAL;
-
-	/* Start address must be page-aligned. */
-	if (offset_in_page(addr))
-		return -EINVAL;
-
-	/*
-	 * We allow a zero old-len as a special case
-	 * for DOS-emu "duplicate shm area" thing. But
-	 * a zero new-len is nonsensical.
-	 */
-	if (!vrm->new_len)
-		return -EINVAL;
-
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	/* Remainder of checks are for cases with specific new_addr. */
-	if (!vrm_implies_new_addr(vrm))
-		return 0;
-
-	/* The new address must be page-aligned. */
-	if (offset_in_page(vrm->new_addr))
-		return -EINVAL;
-
-	/* A fixed address implies a move. */
-	if (!(flags & MREMAP_MAYMOVE))
-		return -EINVAL;
-
-	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
-	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
-		return -EINVAL;
-
-	/* Target VMA must not overlap source VMA. */
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
-	/*
-	 * move_vma() need us to stay 4 maps below the threshold, otherwise
-	 * it will bail out at the very beginning.
-	 * That is a problem if we have already unmaped the regions here
-	 * (new_addr, and old_addr), because userspace will not know the
-	 * state of the vma's after it gets -ENOMEM.
-	 * So, to avoid such scenario we can pre-compute if the whole
-	 * operation has high chances to success map-wise.
-	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
-	 * split in 3 before unmapping it.
-	 * That means 2 more maps (1 for each) to the ones we already hold.
-	 * Check whether current map count plus 2 still leads us to 4 maps below
-	 * the threshold, otherwise return -ENOMEM here to be more safe.
-	 */
-	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
-		return -ENOMEM;
-
-	return 0;
-}
-
 /*
  * We know we can expand the VMA in-place by delta pages, so do so.
  *
@@ -1712,9 +1583,26 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+{
+	struct mm_struct *mm = current->mm;
+
+	/* Regardless of success/failure, we always notify of any unmaps. */
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static int check_prep_vma(struct vma_remap_struct *vrm)
 {
 	struct vm_area_struct *vma = vrm->vma;
+	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long old_len, new_len, pgoff;
 
 	if (!vma)
 		return -EFAULT;
@@ -1731,26 +1619,127 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	vrm->remap_type = vrm_remap_type(vrm);
 	/* For convenience, we set new_addr even if VMA won't move. */
 	if (!vrm_implies_new_addr(vrm))
-		vrm->new_addr = vrm->addr;
+		vrm->new_addr = addr;
+
+	/* Below only meaningful if we expand or move a VMA. */
+	if (!vrm_will_map_new(vrm))
+		return 0;
 
-	if (vrm_will_map_new(vrm))
-		return remap_is_valid(vrm);
+	old_len = vrm->old_len;
+	new_len = vrm->new_len;
+
+	/*
+	 * !old_len is a special case where an attempt is made to 'duplicate'
+	 * a mapping.  This makes no sense for private mappings as it will
+	 * instead create a fresh/new mapping unrelated to the original.  This
+	 * is contrary to the basic idea of mremap which creates new mappings
+	 * based on the original.  There are no known use cases for this
+	 * behavior.  As a result, fail such attempts.
+	 */
+	if (!old_len && !(vma->vm_flags & (VM_SHARED | VM_MAYSHARE))) {
+		pr_warn_once("%s (%d): attempted to duplicate a private mapping with mremap.  This is not supported.\n",
+			     current->comm, current->pid);
+		return -EINVAL;
+	}
+
+	if ((vrm->flags & MREMAP_DONTUNMAP) &&
+			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
+		return -EINVAL;
+
+	/* We can't remap across vm area boundaries */
+	if (old_len > vma->vm_end - addr)
+		return -EFAULT;
+
+	if (new_len <= old_len)
+		return 0;
+
+	/* Need to be careful about a growing mapping */
+	pgoff = (addr - vma->vm_start) >> PAGE_SHIFT;
+	pgoff += vma->vm_pgoff;
+	if (pgoff + (new_len >> PAGE_SHIFT) < pgoff)
+		return -EINVAL;
+
+	if (vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP))
+		return -EFAULT;
+
+	if (!mlock_future_ok(mm, vma->vm_flags, vrm->delta))
+		return -EAGAIN;
+
+	if (!may_expand_vm(mm, vma->vm_flags, vrm->delta >> PAGE_SHIFT))
+		return -ENOMEM;
 
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
+/*
+ * Are the parameters passed to mremap() valid? If so return 0, otherwise return
+ * error.
+ */
+static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
+
 {
-	struct mm_struct *mm = current->mm;
+	unsigned long addr = vrm->addr;
+	unsigned long flags = vrm->flags;
 
-	/* Regardless of success/failure, we always notify of any unmaps. */
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	if (failed)
-		mremap_userfaultfd_fail(vrm->uf);
-	else
-		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
-			vrm->new_addr, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	/* Ensure no unexpected flag values. */
+	if (flags & ~(MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP))
+		return -EINVAL;
+
+	/* Start address must be page-aligned. */
+	if (offset_in_page(addr))
+		return -EINVAL;
+
+	/*
+	 * We allow a zero old-len as a special case
+	 * for DOS-emu "duplicate shm area" thing. But
+	 * a zero new-len is nonsensical.
+	 */
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
+		return -EINVAL;
+
+	/* Remainder of checks are for cases with specific new_addr. */
+	if (!vrm_implies_new_addr(vrm))
+		return 0;
+
+	/* The new address must be page-aligned. */
+	if (offset_in_page(vrm->new_addr))
+		return -EINVAL;
+
+	/* A fixed address implies a move. */
+	if (!(flags & MREMAP_MAYMOVE))
+		return -EINVAL;
+
+	/* MREMAP_DONTUNMAP does not allow resizing in the process. */
+	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
+		return -EINVAL;
+
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
+	/*
+	 * move_vma() need us to stay 4 maps below the threshold, otherwise
+	 * it will bail out at the very beginning.
+	 * That is a problem if we have already unmaped the regions here
+	 * (new_addr, and old_addr), because userspace will not know the
+	 * state of the vma's after it gets -ENOMEM.
+	 * So, to avoid such scenario we can pre-compute if the whole
+	 * operation has high chances to success map-wise.
+	 * Worst-scenario case is when both vma's (new_addr and old_addr) get
+	 * split in 3 before unmapping it.
+	 * That means 2 more maps (1 for each) to the ones we already hold.
+	 * Check whether current map count plus 2 still leads us to 4 maps below
+	 * the threshold, otherwise return -ENOMEM here to be more safe.
+	 */
+	if ((current->mm->map_count + 2) >= sysctl_max_map_count - 3)
+		return -ENOMEM;
+
+	return 0;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
-- 
2.50.1


