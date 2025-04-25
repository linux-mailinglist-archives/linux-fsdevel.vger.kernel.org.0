Return-Path: <linux-fsdevel+bounces-47370-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B81DA9CC1F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615984C5F98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088A1258CE5;
	Fri, 25 Apr 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q0yOF2Ys";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vMwtme7X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7DA2580F7;
	Fri, 25 Apr 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592928; cv=fail; b=Ge4tZfPfwZQGzg1umLOf/p/m5x8MQRE14DMe3GchzMf9zpd0f7/hhr8rM0q3GwyWruM7ilYy+P/wVlXhdkSXD84Wt/pUtuyPcSfXLyucxt75HkSSdZ/aCPdtIiQsuDs/EyO02ViYlrxfFZvKXbFzQT2IaKknp/pqlhBtQKTGE7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592928; c=relaxed/simple;
	bh=/TkIqNNO5ttpypkpoN6+dnrvPa3oVkuoEb/DpDeM7aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ogGsUgl7+k836W0XHzGCrMTCnJXjBz83d7pLAypiZogdH4/jVv273XX+PdOINxoJIFrodtV+R6DL2OPPQRjZoG5y7nVqyESXYl7teR12q+ZddITiMOs1emhTUkc/rKOwgjXaqjeGaFnaoDbLrQBit6h/D5n/r8w7mq6BhYcNKe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q0yOF2Ys; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vMwtme7X; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEmGsb007472;
	Fri, 25 Apr 2025 14:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=RaqMO7+3oD1/F4oBmH4sOwtfLFx5iMNd57DSP0Xx1hA=; b=
	Q0yOF2Yslqee9BK3g7qUoMR4hel8dy+n5YaAe0rJTu3psN25YEdApuHAT0+sB4aO
	7HYJ0eaPLt+v5DdHUPsRQsoZUYiGAyZN+hdabBSlq0tNUTbTSaKmcymdrAiT/Dlg
	VdRCt+WdNMZSosHZJwEg1LwJSRhSn6sOxaGu1dyNMuMvnr1BkKY61FmIpW9bYw6O
	WmOae859pwMNeiXXfuRGmhBNHxipFTXLb8g50gld0S3BHL+f6PVB65QS1aOCQ3ov
	hGib031mSt3LYm4+MH9+wtrLUeiCCodlaocrExj8oWtZbxIQc3y0gA8i+9T/oQkS
	sLKCS+nXxAfXMAuL3hY8pg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468c84r3tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:55:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PDQ31X031609;
	Fri, 25 Apr 2025 14:55:07 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfsum04-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sQaEdcWKyvPqkY1Vb6B3oAhcWo7AkvnEHvYzuLReykm1sb6bFAZ+/3EHpNdInXYyLvejXn75UW6kwA44gLAIl+2EC/FFguvlBx63aUVAWLoK92Y8oeVEp5sRz/fFeGR+b9jeLnkof4tfldYwwtwzADBjrFlNcQBxf0pJFn15gAp4aV65jbb1A/kbRxbovVSud3rEJPV0ajJcmU8zidkKYWPdyQRvvEE/geIEUVAqIYMnseRlXtuJhdQmelM8EjY0RlybA4dsY1OIu1i9O/LTic5Z+PzPHUQkxyu04KG1xo7K4AUkl5Qygy6ASDIffvtSLZINRYLCgLP2R8y/lVG97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaqMO7+3oD1/F4oBmH4sOwtfLFx5iMNd57DSP0Xx1hA=;
 b=n6Z+zxJzsiQa+ANQE/0NHVmdXt8XPV+PwTIuTbfdcVYJ+Fua7aVbjcGetKLH7tnuI9soKLgkB2lkexD1niQVGzVduUaUCsMeLCfLU+krHrWQu5I+I0wSdq15Ib49yaLqGbwg7S5H2tOo7zwsQ2HsgzOYwY79Fk4XoWTOhTmGlf89WS3UkyFks9Jw2Q2koqFJdzhNQNPiHlFx+hnwoN8fvCjELfRI1ur/sLOHHBHyv45zSRDHpLzmzK52SQEXDJSl9XmbA7f3dT0Ooe77yfJT+hclDh9gHtL2AZsIihA7ss+smZ4B+yhUWF2Bl2X8FiijGWGFCYBzctZfiDRPfh/F8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaqMO7+3oD1/F4oBmH4sOwtfLFx5iMNd57DSP0Xx1hA=;
 b=vMwtme7XJtfJTa6tRQP6cGVsLyQHJVw7RMXFrdlOD+5vdOa3eqo0CTZPox5CKEUK3cGTIS0QQC2srlH7JJZZr5aSEi0QdDyuZP6MG89T5+Kbz2ctS4VhePDbiM7nsAvjck+oViVovSytzkKnfrWHBREUV2oWyBRvWEI6ng9XYXI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:55:05 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 14:55:05 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] mm: abstract initial stack setup to mm subsystem
Date: Fri, 25 Apr 2025 15:54:34 +0100
Message-ID: <92a8e5ef7d5ce31a3b3cf631cb65c6311374c866.1745592303.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0580.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::16) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b16eb02-6706-4f5f-9ccb-08dd84092a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u4xBuyrn5UTY+kb3hqfHu0YWQpJVbnauDI1kLLZpduIsaeRF8zzJfzYL6OcK?=
 =?us-ascii?Q?sXonTOONL+8nl9ImtueHyejyzM5qPO9BB7flMAfv62TXUX33HvkQ4eqOesvf?=
 =?us-ascii?Q?+irZruuY9jPbc78sKAgHakwGUCgfXBcUCZEkuGdAeSjWj7SqinaCF1pAGsJG?=
 =?us-ascii?Q?JRI54E5Es0VE5LlfoDsPZJF+VxWvMziCyD0qwsuiAOPCkahxucT6x/Ial0lC?=
 =?us-ascii?Q?1lW0cQHOW2VE9AD4uwvNl9tjHVCY+SO0Fj+c4mmXN1qW40P6Y3owOo8DBLwg?=
 =?us-ascii?Q?Sr2/jCH+BhEn8XtXN6sQruyHetCibXoBuuY8o4+Rk1JyrGa7UKeIMwBHNoW5?=
 =?us-ascii?Q?g5jjP4kHpKIW80lHVYtk+F6DeX/0CVm0lK5vciOo+tLgSC1W9ZX2CI7RXpZ7?=
 =?us-ascii?Q?FRixdZgRBsrXyqzeK6VMYzDKZdIXygdHiAItO3/K0hTqQd01Ety+/3zSy3C4?=
 =?us-ascii?Q?ZPP8LdByDofjODv+qVherLhHOpV/02YGvWgx+TB8rcNtGwh5DkgGFb6jmr1H?=
 =?us-ascii?Q?fT7VL3gGsN12nuDp5uDw4+b5LSus8r6Yt/G28ntcPbAajmofqLj/X5zM5yPA?=
 =?us-ascii?Q?RS/qEHE7Zv6DWF2E/HTvo8TbJ920LTjvTBjhqtHW2qkd2Fnk2l2x/V4mFPQL?=
 =?us-ascii?Q?Ce03WWweu2riH7upOc1HuuEGsGXMoQXwaeprxKDjOKFoATKnNm7CYt5h2MfW?=
 =?us-ascii?Q?BIAoHttoDx9SNkW4Ah75eLkBiw9UXjRvqRE7lNoT9KBmjLvv6Kf+K6+X8GVH?=
 =?us-ascii?Q?7P/DJXdVAkd8vmW12tO4BCJXfxugA0ehLbI/p//MnJNN4Co/CkH39AFIU8s0?=
 =?us-ascii?Q?9WtbEfuszv/F0ZQMouy/UY6bNLDAUm3aH0Gb9bQ4eTK77fCivR75/wQTnvJ0?=
 =?us-ascii?Q?QvkPpNaZ/qNDgmOwpy2VcI4XszDhUHF18cGA7Xm/YzSBy6bCeuA6NfME3Dg3?=
 =?us-ascii?Q?C2PFVUgX4Anx+hUwuVAkDWGsSmxP0s7OaN7JO+QB7ElKG9tqllcQK2XgnQih?=
 =?us-ascii?Q?R6vY0uDvoJil1GhW5jwuLsMvzZN5avamJIZaBJz7kzUcxpCiDgC/DdwTKUqE?=
 =?us-ascii?Q?9qvSAQo01PuOBDq1bKHh9baHkVfHz0Ef3SnzzSaxKxyVpQGdpzC7umRLllqG?=
 =?us-ascii?Q?EI1KIYVxYC9WmgUA2f2AP0YPQRuPVj/SwFYHW6514odh2NhrWX1j1qCSPMAW?=
 =?us-ascii?Q?NklY8Pqm7ijCVhTb0vm9ruSio6NmS8zwZHVsnrvqmgzFcY45CThVHgi8+cCu?=
 =?us-ascii?Q?tZantvOSX2Kt0GJ8XqkT4K6loPtnVQayDySOKSnzgsuSJhBd5DblJo+egTIU?=
 =?us-ascii?Q?e6dWSK0Jq5WO55hjJpRtB4SA/LnJkdMGKQcR6kUh3bbJPjM5QUJz9TfxkSi5?=
 =?us-ascii?Q?SCBFyd92ZSVf4EIpzDXjSMXtX70pNoaPmx4EFiGhgEmfT7O5doaxHQb3D0mi?=
 =?us-ascii?Q?1tRuT3xqs7A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D5qTm+kMdFrtB5vtVSEOLSPPj9GDZWZmvPCWUrpDHg9bvMCjTulpNpljSL62?=
 =?us-ascii?Q?5PyDRoXUK1/NNqtk3PTzDdfIhi7OT56EP2qe+ykMJ9yszwmllFhG2DyCOl+h?=
 =?us-ascii?Q?HgBzoJT5WjNmlRQAZYV/jYKkNFlPSaffW0iE0EvhOGvdAOj0tL7a9WaE89Yk?=
 =?us-ascii?Q?2K1RKQyc4CqvvcGyBXSRPElbycssjX9ZyTDA6JbThFNKvE6Y+0n8ttBON0RA?=
 =?us-ascii?Q?6RBwDnKLvDurekbAHb/iJPLVgibGk0xySmxQSUrkJghfdwMALNEANpfvG7wI?=
 =?us-ascii?Q?H7HexT4dfvGmWKuLw8erEw4CK414PlaHqmrP7NypXh2kBr4xBtcJXaE4R99H?=
 =?us-ascii?Q?qiTg6bJUS9kC6O2hvsUiXPKD3DXRqpR+HMxN4j3Al7IrVwBRYHXctDnlLz/f?=
 =?us-ascii?Q?kmVUY5X71Mc0Ku3YtngOM+QrPubch9V9zSwyxH0Yyvvrn0rNlwI3oM9SpGKd?=
 =?us-ascii?Q?IQi8Ct3rrma+hlt80Mt7mG8jljKV1SaHPE/j+dapyk6sJ+IYljoM0FxhwDTA?=
 =?us-ascii?Q?Fv00XxEvRI8sxGJOh+a2ohzRcbL4R7svU4ytBJHw4pYRsSiPmeaAY2+fw55B?=
 =?us-ascii?Q?W108IqZpmVbsj+cgaLMdl6K9oqgzmXLVsEOmgftm6YAqSKSHFJ7kaONKvW+s?=
 =?us-ascii?Q?+fpl5s7U6c6ahr3N4GSnQouiR4CDBYNPL4vzt6TqX6zCx8plPe73tTw/dYnc?=
 =?us-ascii?Q?OOfY4Ty2oBD2NLepPghtJdswjD6Dl/ZE76A4JFNBJmZwRW4rDXu0ZxP4VKjU?=
 =?us-ascii?Q?Ly3RXdIQ/nklmZsqe5kpOYswoURTrVkO1B0CMFmcicfPfTh/5yVTWxoKUjYZ?=
 =?us-ascii?Q?UZ/T15tV+oxX60dDsdmFkxZnCzRTpqBAPVeVMYwu8R5/gGVzkTdREjNjwckk?=
 =?us-ascii?Q?+wBAN043SZiwySlb6MHo41zOa3/nCvFpAWd6VDyubzQ/pIqVLORme3Pk3/OS?=
 =?us-ascii?Q?8AQF2KOrxyoFBjPzJR2Jl2Ggqwjrfg+bsH9YUMrlfE5Agj5hP64OjBxCtq7h?=
 =?us-ascii?Q?gs2+UfySLTUFy8jXA30iZFo2nb4i1frTjrWwWWYFWEoUw/bm/4a3CN3TwEjV?=
 =?us-ascii?Q?/lbbPVwmU/Y5vxn8uXtletJj0xtdFtxtAmKrF2xT9hMIRsZqgB2soDMwOAA1?=
 =?us-ascii?Q?ECfoOqDOnvnCJCp6C2W1u1cV722njgSQejB3ZDgDicYCla9uT1CUZYPT17Uq?=
 =?us-ascii?Q?ACEf7c+PqhlQ+z4IJnJtIXTklqyCE3SteK2M5s4wUgQ+aM7ivQIpZjr7jb/g?=
 =?us-ascii?Q?UhqOGuQZ+gkyWi/SxDvNRqCTXB2XeQFSl8WPG69421n2DF9mJVHY4G66+J6B?=
 =?us-ascii?Q?W6hFBqUSNM9JQXZsXGK1cSMlsfIzYkN2X139d/2fpIKrClRgqVI85h0dkwKy?=
 =?us-ascii?Q?MdQMkM49toXGhAXF/H5bgzQTcZWh6CFcCvpOSadVZxT2XGTgdy1QnQwjt4V9?=
 =?us-ascii?Q?1o+cgVyeVpMt2vJ6AUNEYtRatK4ONU5MqfN3aB0BX/nA1/ve2dT1SYCCAuzn?=
 =?us-ascii?Q?AL/M4ZdUV1VfRbkk/telp2EgLDPkBjVUnDtIoMkp8WYNx9GjFLY2U2JbBI6D?=
 =?us-ascii?Q?tI20ycp3CdcNgqsMG4PYniNtg8OJR/65mMDlzFxKZbUEg57VMcYz/PC2Qp1Y?=
 =?us-ascii?Q?sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QYkWn1vghjwPHm8x4X3Y0uZV5FMmQB2mWy4CUOEv5TRmGTyuMba/XFOpVkRnA4S6rti9hD/ouokh6A22cRakL2DSo8+jkeHuEE9n5BU80Iuyn38N4S/pwsl9f0oQe9lifuX5/aaBS3vau5rb/MEl2KoZ+RNQv50e3nQyodljNHEQpfM+6+j101Trx27KkC/1e3qWeYg7vGv8i8F9quqfj78Rou9SqFMOrWSdYC/QDZTCWdYf7/IN2XW/y2T8ySulX4LkYmh1vuOGcj7VEulnWWGFgFUaxSNE0jTQQ9tKp4utzJ+SL4ImEUOctG2I/IzI+m8PeyTN+shi+AosWMjWKrHW5OSb0HtTO4goFrEYhh03TY37OlkGaK4R0DM6l1wlgsgxcBl6JVR3O7ymVl7RklevopDORAzKE1EmwjIu4SsRo7p3KjNlRnIejGoFmZ3mfFQ1Au+klF6oD+tKpnri5pL21Uy03mvItJ/FeZBsEProm6A9MhljWqY2W+3fu+lA0i3GfmwlWSlEGzcrDvPR7ZUT4EZwx8ShK+pUzIR7/OOGJPa0hUvnJXGafjO8cVFaTUU13Tg7qoCI6xqz7NGtf0+NGYkqw69vDrCl4u+jsv0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b16eb02-6706-4f5f-9ccb-08dd84092a46
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:55:05.6080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wRKbiSoMXIAHMripYYiIm50MbxDwjjpxHJw9Sz12NYurQg17xomUbZoKDXSTx+XpYdzH9t5chJW7OxBAep1nbOGk8I0HFev4GqaW0hKxo2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250106
X-Proofpoint-GUID: mgXoRP2l8AAfA7tVlv73gwCgaRiQE66o
X-Proofpoint-ORIG-GUID: mgXoRP2l8AAfA7tVlv73gwCgaRiQE66o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNCBTYWx0ZWRfXzJeovKxgh9M7 hVMXtFyiG9/zhV3CIAK6BcefSjsLUJzhLHcGGjMXoXnZ86xzahhV7n+aj1qdYy49UpPJ2A7cURc Y0o+n1MxZORdu4ypiCIQED1HuwsEzsVfCo68N+yv9rBCJ5TYlRT6/UgM1e7WUFoyZA7JV6D9xeW
 hbyrLQf1dB+ZOrUblfqELQP2jwsFmnGRaCNxUN1qVGNt8GIO8SbrJ8lhPPYRVkLW118MqW40Lmk 7DlOYEy1TlJe+cNqVVygcU9rp5OfGGQtITisw9vi6ltpaxgo+lbrBXw8hBgg8YA+b6rN3jF0LNI RmclwBWeZ2n4Tk0KiYYvmqTaHIWCXBfxogzCBlwfOCwprExcNalAM8zw3x6dqqNyqXM5cYAW7OH jxpYVDOD

There are peculiarities within the kernel where what is very clearly mm
code is performed elsewhere arbitrarily.

This violates separation of concerns and makes it harder to refactor code
to make changes to how fundamental initialisation and operation of mm logic
is performed.

One such case is the creation of the VMA containing the initial stack upon
execve()'ing a new process. This is currently performed in __bprm_mm_init()
in fs/exec.c.

Abstract this operation to create_init_stack_vma(). This allows us to limit
use of vma allocation and free code to fork and mm only.

We previously did the same for the step at which we relocate the initial
stack VMA downwards via relocate_vma_down(), now we move the initial VMA
establishment too.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
---
 fs/exec.c          | 51 +---------------------------------
 include/linux/mm.h |  2 ++
 mm/mmap.c          | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 8e4ea5f1e64c..ef34a68ef825 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -244,56 +244,7 @@ static void flush_arg_page(struct linux_binprm *bprm, unsigned long pos,
 
 static int __bprm_mm_init(struct linux_binprm *bprm)
 {
-	int err;
-	struct vm_area_struct *vma = NULL;
-	struct mm_struct *mm = bprm->mm;
-
-	bprm->vma = vma = vm_area_alloc(mm);
-	if (!vma)
-		return -ENOMEM;
-	vma_set_anonymous(vma);
-
-	if (mmap_write_lock_killable(mm)) {
-		err = -EINTR;
-		goto err_free;
-	}
-
-	/*
-	 * Need to be called with mmap write lock
-	 * held, to avoid race with ksmd.
-	 */
-	err = ksm_execve(mm);
-	if (err)
-		goto err_ksm;
-
-	/*
-	 * Place the stack at the largest stack address the architecture
-	 * supports. Later, we'll move this to an appropriate place. We don't
-	 * use STACK_TOP because that can depend on attributes which aren't
-	 * configured yet.
-	 */
-	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
-	vma->vm_end = STACK_TOP_MAX;
-	vma->vm_start = vma->vm_end - PAGE_SIZE;
-	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-
-	err = insert_vm_struct(mm, vma);
-	if (err)
-		goto err;
-
-	mm->stack_vm = mm->total_vm = 1;
-	mmap_write_unlock(mm);
-	bprm->p = vma->vm_end - sizeof(void *);
-	return 0;
-err:
-	ksm_exit(mm);
-err_ksm:
-	mmap_write_unlock(mm);
-err_free:
-	bprm->vma = NULL;
-	vm_area_free(vma);
-	return err;
+	return create_init_stack_vma(bprm->mm, &bprm->vma, &bprm->p);
 }
 
 static bool valid_arg_len(struct linux_binprm *bprm, long len)
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b701cfbef22..fa84e59a99bb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3223,6 +3223,8 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void exit_mmap(struct mm_struct *);
+int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
+			  unsigned long *top_mem_p);
 int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
 				 unsigned long addr, bool write);
diff --git a/mm/mmap.c b/mm/mmap.c
index bd210aaf7ebd..ec8572a93418 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1717,6 +1717,75 @@ static int __meminit init_reserve_notifier(void)
 }
 subsys_initcall(init_reserve_notifier);
 
+/*
+ * Establish the stack VMA in an execve'd process, located temporarily at the
+ * maximum stack address provided by the architecture.
+ *
+ * We later relocate this downwards in relocate_vma_down().
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable initialisation.
+ *
+ * On success, returns 0 and sets *vmap to the stack VMA and *top_mem_p to the
+ * maximum addressable location in the stack (that is capable of storing a
+ * system word of data).
+ */
+int create_init_stack_vma(struct mm_struct *mm, struct vm_area_struct **vmap,
+			  unsigned long *top_mem_p)
+{
+	int err;
+	struct vm_area_struct *vma = vm_area_alloc(mm);
+
+	if (!vma)
+		return -ENOMEM;
+
+	vma_set_anonymous(vma);
+
+	if (mmap_write_lock_killable(mm)) {
+		err = -EINTR;
+		goto err_free;
+	}
+
+	/*
+	 * Need to be called with mmap write lock
+	 * held, to avoid race with ksmd.
+	 */
+	err = ksm_execve(mm);
+	if (err)
+		goto err_ksm;
+
+	/*
+	 * Place the stack at the largest stack address the architecture
+	 * supports. Later, we'll move this to an appropriate place. We don't
+	 * use STACK_TOP because that can depend on attributes which aren't
+	 * configured yet.
+	 */
+	BUILD_BUG_ON(VM_STACK_FLAGS & VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_end = STACK_TOP_MAX;
+	vma->vm_start = vma->vm_end - PAGE_SIZE;
+	vm_flags_init(vma, VM_SOFTDIRTY | VM_STACK_FLAGS | VM_STACK_INCOMPLETE_SETUP);
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
+
+	err = insert_vm_struct(mm, vma);
+	if (err)
+		goto err;
+
+	mm->stack_vm = mm->total_vm = 1;
+	mmap_write_unlock(mm);
+	*vmap = vma;
+	*top_mem_p = vma->vm_end - sizeof(void *);
+	return 0;
+
+err:
+	ksm_exit(mm);
+err_ksm:
+	mmap_write_unlock(mm);
+err_free:
+	*vmap = NULL;
+	vm_area_free(vma);
+	return err;
+}
+
 /*
  * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
  * this VMA and its relocated range, which will now reside at [vma->vm_start -
-- 
2.49.0


