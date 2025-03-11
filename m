Return-Path: <linux-fsdevel+bounces-43710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A5A5C179
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 13:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE8E43ADE99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 12:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21DA2571B1;
	Tue, 11 Mar 2025 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JeYS51Pd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qAYHukkb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2652571A7
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696645; cv=fail; b=Kqs6o/8stEk8L9eansqcCMrVNe5LZilejFeOkgyZIPatZ2kB/w+YSxrUBI0KYFjG75baCFbYuluGtXDQaxttKWp7i1mXIgFaDKwfgmDWO++4Qe8T5STO/OFbW2n8FR8JKXULWDbsRFMXI0pMrk6VWZg3dtCmR98Tn9qaqMiXI3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696645; c=relaxed/simple;
	bh=a4HeS3FrlUXaAS+I1gfLs8pKl+fTWGunBTs031u12e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IYSAhBLencNekRMjUjSzts3yozmKd/K93C3wvAD8vSO96fWYFqFmHt3eN1g59SaebSPok9a4S/cgmZdEq5F/T7faFmeUjB9j94/3BEPHXDw9r9ldvosKBGgXsoYKzkjPkz0xl8YYF1kItCnPqAs8UJ6ZoqYWb4s4TBTgNfxidHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JeYS51Pd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qAYHukkb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B1hMPl008000;
	Tue, 11 Mar 2025 12:37:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=5oTzT96P9x7dKEQYTY
	WNP4yGnm4KFb8N8CbU+8eccc8=; b=JeYS51Pdqvf+Kh6qhwMpBBwltekWjZwPUL
	/HHVUH0aFzt4vhJl1ponO5D1s5M7lz8bF43WaTTQqJ7FIgOhhQGY50wNVic6pPNR
	GkVL7AsitBR0wsiPajDxZwztO3SorBel/jjYCYfFISq/oaU+nZIZZZ5cL/lBVDmT
	GRwYeqX4MLDdC+oRgwdIbAEj3/yxxIZO5qoXOCTxhsdNNChDta/JC2NJPwo8mxFL
	i6AoyK18c7vJBvnL1CXICdkEMGvvTlilo6ln+Ku19mJ+Y/XuDp0y0GBJbaC1gJBs
	BXGd8yF3rBn3GJ3l+dJ1wpDwzDd2OAu2+phONR4xfZJjDyKC6SGQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxcmqm2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:37:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BC37hm016916;
	Tue, 11 Mar 2025 12:37:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbf89x2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 12:37:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4K7P04kkuhFRxgfPbxaWpQT9mgBDlSQX+LrtpOF7vx92/Fpth2sweCeVqjjdeiTXQkHKYhf3SbOqXD49IA/FSXLa4wpmP5vCsAKzrWb1Y+aIAfwGtjwPT8KnYF8OPdfUVb/8DdQRXqEHKtK9BONj06we7YRwcyH1SxZZ0dmEyoKoYEneyo49d9YGsTI9YgR6729S881A3oCxniN7m+dL+Qs+3xqfvdNWb20Vtr8AFYKZMmDWSH4NHmAmzxegHPO4AwI0+MRBv1H0MGA+87ksCC1P1HdaFLAwyC1psxh/euEx1ef91I5/megZaN34LOK0sdpDsH4E7+vedGUdu46Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5oTzT96P9x7dKEQYTYWNP4yGnm4KFb8N8CbU+8eccc8=;
 b=qRVeVHHS0ff4xqkvYV0zvemPBfDdgfGSJrwrUzVqf17s1aSy/UH5n2rV5oHpT2Ge8DcGv1CbL9QCSNHdJGxWAM+3tIAAkSiEXUQgQkiqwdngl8cCTwhzRsgya1KYU+U+xIEXen6MrymnKfMG2z+mNPuqtCxrx57sy2HRxYoQKS2FgcSf6Rij05QkRGmlUXn4blm8V/8XlLv8FukTjJrX8bQRNj6SHQULDl/IduwdrSTEcQqWOkphfsPnvKwa6he7Y/4AW5tQvHvTwh735b4KjzQ6ZXJDdQYZwHz4wMWVL5jQWGvWsr0Qc7NLLvUcus1IU0XFB7wmIvuesiFMSxJEjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oTzT96P9x7dKEQYTYWNP4yGnm4KFb8N8CbU+8eccc8=;
 b=qAYHukkbb/REuC8cxDa6mApLPcvNo36Fftyt/N/21bPDzQsJQY7FLQH/zeUlaxy8N7ga3nwkcA/WiCfPrg7dHe2AHzcX3DSP1++zQCuefvmj2KBVqkghHRQ1DgdcW+jC38bl7WLC1mrTLNxo9GnkuI/CDyPyekPTD9MV5QzoSu4=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by LV3PR10MB8081.namprd10.prod.outlook.com (2603:10b6:408:286::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 12:37:14 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Tue, 11 Mar 2025
 12:37:14 +0000
Date: Tue, 11 Mar 2025 12:37:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Josef Bacik <josef@toxicpanda.com>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsnotify: avoid pre-content events when faulting in
 user pages
Message-ID: <f360f477-8671-4998-86bf-c134648b2c94@lucifer.local>
References: <20250311114153.1763176-1-amir73il@gmail.com>
 <20250311114153.1763176-3-amir73il@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311114153.1763176-3-amir73il@gmail.com>
X-ClientProxiedBy: LO4P123CA0484.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::21) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|LV3PR10MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e1c5294-52bb-47f4-cd9c-08dd60997381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?In4LwipJER+BkFlx94h4Eutln/ImA356e7biS3lltRgNCPa5kMpS6dQ6p59S?=
 =?us-ascii?Q?krq/Do/3E1RQaiNuWNUNXppumYX8bdhzi++tHN0xaSEWupZS19Ng8JdC8U/R?=
 =?us-ascii?Q?H+OcVFDbpVEpudyrWoYbcci5z6E8MkqfDJit1fxxOw1AzAfA2QobrchHGqr0?=
 =?us-ascii?Q?9Y5ZVFn44Dy6ZblpFOgtOUyP0mcWmCjfSAEgQxm5wqRSDnQX6md0zSTDKE03?=
 =?us-ascii?Q?0oSaxPLo0LtL9sfTnyWqpt9JvWhIPwy52KegNyvmGKa9PBjgeXdkQvoh3Ebw?=
 =?us-ascii?Q?66oV+HbG52lOxkxtXsQxtKJMvxfOXOGjgyqAs9Z5jDx09ShlIGo6dyU8eClJ?=
 =?us-ascii?Q?ll2r+oYdda6gbH5EsgVDS+OlZHJx5e/r/sGQgYachpC+uvnuZp48KFAIDvva?=
 =?us-ascii?Q?1y0MWSpD0qdewqPCUnSr7h0ut6ma+wFrhqWhAI4g+BQA/gWz2he71xfSpz3N?=
 =?us-ascii?Q?xBNm5KkrU2EsbWLqEkvy4az9TUIbiUc9m2elFWgQt/9UAyzbjanhcyG5BK51?=
 =?us-ascii?Q?KgqtlGazWd1OxCBx98i0Txwq5wxW6IVCQbOO5jZTEhU2Zv1xs49CovhtrRvi?=
 =?us-ascii?Q?mSnwbYb7mbfejmVuXc7iX51PYV4pf0dfVClzaJOXvthoExYgqrb8+XKkNPZx?=
 =?us-ascii?Q?3NZj426NEFfbrVXe6cn126nlv/D3TMlUzY3BD5Z4yw4FEIpJICTdpjo5rsMh?=
 =?us-ascii?Q?hvd4REvtZRrrsmdt1tys0e1ru1ZstrJ/FT83XIkTXncu7AM6HzTlmElMZVgc?=
 =?us-ascii?Q?90pUGus3P9P15xRwjpwHy+iGFHcU/kqDERrtmhLynikSIDcd1+PEiDemIAN0?=
 =?us-ascii?Q?IZeSCI3D+xXxmE5CCrrd2SJUJpmuJBzdLxje1L7Q3OByJ/88QngHRfLSAIfm?=
 =?us-ascii?Q?mp5Kx2KSNxDuKBCKyXEBsf3Mej4IDmCq4GMCvc5p3hOAE8N5udJToYHYLOy0?=
 =?us-ascii?Q?meiD6Dwd64SsUgH+gT4V45r361dWzWonAm2vsyjsBaiCuL1l0gyKZwS4EWK+?=
 =?us-ascii?Q?gGOvBgPdkDRDR8RfDHcupBa9FjbhuZ/y9jpWuidh1486O7FLo/o1tyF199Q6?=
 =?us-ascii?Q?MaHB+CaDvMdA0jDmMV1YTTLb1DeOQ7a8Imesbe6nsUk5kv61ENZzUG3wwWZQ?=
 =?us-ascii?Q?EoBXm6Sb0+U2L+f1qhqKrZqHjQE6FYq2YX1HQIyo0qioeGNidBj2v6AsdO5h?=
 =?us-ascii?Q?9GV8jDutI9AH9O9o8/uqNeO8s7prDmUDe9YmwAg8J+z7Es1xsQGNYjq3XleZ?=
 =?us-ascii?Q?MVhEaAZUb/PmUI59+J9fjgMbqOqA9GTclfwMjkcH2ftL3Z2bq4HjUMUAZdSa?=
 =?us-ascii?Q?aqW0rLeCYz2vNNKJ4XVhfcreyVPBRI2N5w1RDf15zLV1sazdCbSsoezBlLmb?=
 =?us-ascii?Q?hotDDlhIou95pYWRiPF44LyXHOpp?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YhBQnJwSbyGEGRxnH42WITSr/x4pO/1m5sdGr+IDq7pBRZVRNu1u2qzVAYKq?=
 =?us-ascii?Q?OJxByN7HWwwO0Q4q4ZAyCkJiSfrqzh2KxxHu+UPFz5Hg5S56wunH1iDNRM2D?=
 =?us-ascii?Q?rq/4pc7lXjuyzNMtTQ1iA01izfnNLDU/e6cPnpny2A1fT1o1xQX7gcwb7fXm?=
 =?us-ascii?Q?xysETcOOtmg4hFAoQyfITiu3OZ5si24QjkVNI2HXXgPNXMIOBNvNOsDt5z6l?=
 =?us-ascii?Q?eFDj6jHUB7jXdE1RU/jpRTzvPQC+2QaV/4XXo9zC6iab9n5WZXzMW2FShAQf?=
 =?us-ascii?Q?TfR3Z+jvMvD+yuzlcVmym9bAp2OIiOv4+b+NFjDeWzX07fXmWJ8TP8hP+lDk?=
 =?us-ascii?Q?i60nilNAf5DG3EuyHceqOVvxir+BK7C5zXd5XHpdebeMwlUAxRtI6by/6wrB?=
 =?us-ascii?Q?FcHfmbjndII3S3+RBSocaR9icBTYsus1QQcDLuc+U8XXrIWN4P2Lf/ikrVGb?=
 =?us-ascii?Q?avW2k2RxkXoLXhoVZAjgo15eUZJRSZtCXAiD0eGwBp/UlEhhIawzrpkyRfVp?=
 =?us-ascii?Q?eMr8Jows+yPpIFZ5mXKgNDXEn3fybHEYoVTmDZBE1DZPk3C7wEhNGwEHz7v9?=
 =?us-ascii?Q?PW3PwUS7BwxHmo8KJUsXd8u0rsh247ZN/qO4WAj0DwLw14Mv9gjXHLrYrCsq?=
 =?us-ascii?Q?5zIa80oDIRYzng0Imhsf5L7/w8VWkbnlYu5jCT7e9jCEMf60XaD7rp3TThr0?=
 =?us-ascii?Q?VoMSKip7dfc4xp4UxoZtmrIdyz3wwBmYsnRItC4acbzN9EoSiP6yCjQaFql+?=
 =?us-ascii?Q?11DpZYiCjQzAGQ13/j16fThayupDlbE2s+fagAAQc8uNFFN9aUNk/AIT2d33?=
 =?us-ascii?Q?EUZpzl7QqfIo8fUlScwWCu5QJWu3oVWSYYhGPva39DxhIzBt5xGeXgHhgyIS?=
 =?us-ascii?Q?F+Ew4yw1GvqVjSc9QdjeJdYoJDOGuqe3SaFZF2LV4C70Cg/91mcekg027SNp?=
 =?us-ascii?Q?qzNK+FdFBRjdbEVab68ym48+6D11e7uL+UpEKKBMfPcX5e+doUGiHbwHLqBC?=
 =?us-ascii?Q?r051yCv3wYmnTT/TaMMYaODgzpNWklxk2wCUQ2qXzmMw1tyxdbgxanxsHQYO?=
 =?us-ascii?Q?o+Ej7YbBqpc5UoqzNRhVd9oaXuGOqaP6mtl9ZU4Ejdym7NghIeevzyxkE3cd?=
 =?us-ascii?Q?2emOPVha2lIkoJeW5SMPY64NDRtd5Clc/Hid0ZushobJhvKz98jL7WXjfOHE?=
 =?us-ascii?Q?zIUcYf7rwHZDHk/ov6MLQG60PPhxPnlPwsyrOuruUWh0k4obH/CVmDjM0HfN?=
 =?us-ascii?Q?s4lAZvThyi2wdw9RuWrCqLwaYIvqSKArT1OywtmG+jFQcolpOgY6MGKKXmTc?=
 =?us-ascii?Q?seSQsVJ/bvUioPGFsTz0jxrUMEDAeQTfdOQG7LtyS58UeOYcupm9cm2Ik+RG?=
 =?us-ascii?Q?vMbJm7HkGyndzFWmDbpM4/uCJVQq4eulafj8sitWxNxNy3zQ9zDoAuAMPGqV?=
 =?us-ascii?Q?Y+P7oYQC42aj1xz6swQrcbDpMPMpes/DryDpFJdzKDPEBB7JxY1rWtxPo5ZM?=
 =?us-ascii?Q?UiLeRC8H5zFZRjkgQKINpFiGbS0NTzrEzRkBZa2v7ng1/KJ8bjRdFBcz1lW1?=
 =?us-ascii?Q?qZV0lWHKYfDGUpEmcgc/7f03Pq1dpcSIn292MPpZWuB75cJAFM4/Y7xSCnHX?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sE/6+mwaRDidNfJQvT7QkUX44rp3Ypi8UYzpYqeRJxRglEXjyUluHSStzjjwjznR+4M/x81q4wvwX8peo6L57hYddW4d1VA7GSjpWTKHnPgz34feioBHH+F2jnl4LiEOMwBXMxLu3lPkbsKnlozPWrVEEQ83YtUmjBM3FQik6S05C64P6t+q/mUL2OGgWzDRakgZ3YUUAlD6mKkIDUWVacx/xYfpELce+bLngjueJkQqLSGakLpI++5qaeYSYnMClCzgTX9sG6bevWbQ0kNWzObQ0efFMAqmrKe1qhV1jMxaJkl+Czx/NEWI7XmSThd6lbO/gUpT8chx4xLHQsIcSrA+IWVl9m9GWBVGARcHXnLFn9GaI0SV24mUvSIRaGCWEWWKbCwYSgDDv3QdylgdvowYpKtIhGoNHfUOMyhMazlCyAx56UrvAtZRudiOkSWfn08IvwZqogXxXdT1W+1Xoh1J/UAEZCWKvZpertxfjIe4JPRswhcH+zSw2r3vGUAIBlXGS/+2Dsfs48yf7D6HeiHYnIj3u5CW9VlZ7Mi9Vn/PnHXkeaiV8kgHsoT/7hNosp6VCNOjORQ5OMTpAR28GzJJnkHDQuboLFqimxmt8L0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1c5294-52bb-47f4-cd9c-08dd60997381
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 12:37:14.2021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GCVucRtXoh3N8btSxBfqVswBuLK2GWbCz6jfsZduOG+6e783z21/BNSeOeUMyiRCV6Tcqz2toNywFL7VsJ0mmI0iZd+WeqKJrtGx+gx3+bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_02,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=995 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503110081
X-Proofpoint-ORIG-GUID: sO1VYfoX3mACZtVeZgpDfF-AsNemCAz_
X-Proofpoint-GUID: sO1VYfoX3mACZtVeZgpDfF-AsNemCAz_

On Tue, Mar 11, 2025 at 12:41:53PM +0100, Amir Goldstein wrote:
> In the use case of buffered write whose input buffer is mmapped file on a
> filesystem with a pre-content mark, the prefaulting of the buffer can
> happen under the filesystem freeze protection (obtained in vfs_write())
> which breaks assumptions of pre-content hook and introduces potential
> deadlock of HSM handler in userspace with filesystem freezing.
>
> Now that we have pre-content hooks at file mmap() time, disable the
> pre-content event hooks on page fault to avoid the potential deadlock.
>
> Leave the code of pre-content hooks in page fault because we may want
> to re-enable them on executables or user mapped files under certain
> conditions after resolving the potential deadlocks.
>

Will leave the fs bits to fs people but not hugely comfortable with the
concept of 'leaving code in place just in case'.

Often things end up not being the case :)

> Reported-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-fsdevel/7ehxrhbvehlrjwvrduoxsao5k3x4aw275patsb3krkwuq573yv@o2hskrfawbnc/
> Fixes: 8392bc2ff8c8b ("fsnotify: generate pre-content permission event on page fault")
> Suggested-by: Josef Bacik <josef@toxicpanda.com>
> Tested-by: syzbot+7229071b47908b19d5b7@syzkaller.appspotmail.com
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  include/linux/fsnotify.h | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
> index 6a33288bd6a1f..796dacceec488 100644
> --- a/include/linux/fsnotify.h
> +++ b/include/linux/fsnotify.h
> @@ -137,6 +137,14 @@ void file_set_fsnotify_mode_from_watchers(struct file *file);
>  static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
>  					  const loff_t *ppos, size_t count)
>  {
> +	/*
> +	 * Temporarily disable pre-content hooks from page faults (MAY_ACCESS).
> +	 * We may bring them back later either only to executables or to user
> +	 * mapped files under some conditions.
> +	 */
> +	if (!(perm_mask & (MAY_READ | MAY_WRITE)))
> +		return 0;
> +
>  	/*
>  	 * filesystem may be modified in the context of permission events
>  	 * (e.g. by HSM filling a file on access), so sb freeze protection
> @@ -144,9 +152,6 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
>  	 */
>  	lockdep_assert_once(file_write_not_started(file));
>
> -	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
> -		return 0;
> -
>  	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
>  		return 0;
>
> --
> 2.34.1
>

