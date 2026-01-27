Return-Path: <linux-fsdevel+bounces-75607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCHTOQHMeGmNtQEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75607-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:30:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5954095B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 15:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF319307AB62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jan 2026 14:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B135B137;
	Tue, 27 Jan 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C51T/3U6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mnvebGdb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41FB2350285;
	Tue, 27 Jan 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523896; cv=fail; b=ta7bUCLlVS+va9LZ8cRl6HX3+mWDY0DFyGMeVZ1oGthNYb5edSGN7531f6HrQDORP6KvKNxDbpjZytZZXx8mUBxG/MXe1aS28qwGh7xkZYIIMSbWX2hMiunpLwkLWzOFTBywGiPjzbls7DqWYH+Jf0wEFnfqXwh6F3AWtxQ5oLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523896; c=relaxed/simple;
	bh=yWMiWqcnwm265/n0zkGoNnsYwctcJJ+MJGiQWRWJa6Y=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=O4z1DxAhWwikN+WahwGw//hRh8KGpgpCV3PeD2C95MhJI80v4OM2izCBdTgx/OuN/fEUzvYvsVGhqVfv99MHLcSZEmn17E74RpJhLJ9ayqnc3gLpsF/bu1+SGBZ5gtp4FXiB8dAT2Y42AJVf6YxEdWqbWg3h2vdkCFUUOZGwgBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C51T/3U6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mnvebGdb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBEQWA4055942;
	Tue, 27 Jan 2026 14:24:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t2gpnNbBiyICTWFJcN
	7qJHN5ULPZEghD+/D8M3HIFIQ=; b=C51T/3U6BdI6lTu38OCFBdxRTCwLY7kAgi
	BjnxjYyIlo+oYe3TN70CmdQiDSB9bOZRrz+NE57aBhfgEbVTFwTAi+Egyd+iY7yR
	NTL6vIsv1KUosbD6Wsoizl/ld17G9tTPSYSxycauvu3C2ACKjRijjuTGrZ1iTwJK
	KExuTfWNeXr7BRzS9WkRNB+tsTWdeAtANie/JmFHvzG1b/2qPM4OBW2gNzf+M5eU
	CON7WljmJgo8HCngX81XN1vAYotA27F9F3+mkBeQDwHc6+azjo1UUNGwKFM9wOnW
	ksMFkKbn78MNtkX+ov/rb/7TaKButlrFoApGe+aVDGV60t94hgmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvnpsc2jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:24:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60RCnF5g020046;
	Tue, 27 Jan 2026 14:24:38 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011060.outbound.protection.outlook.com [40.93.194.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhervmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 14:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nQiJe8JAKke1Xkzo0WUWp4Fxhjgx90j0SqmOKZcRMXPkQO8N6m3jCdAq8l2pS4G3lmj68mb5Q3J6LZJWif413nbAl0U/ujBdrUmAX3XHC64T9hvJiOsgOxPSPvzh8SkCGhm3vaSTK8nQZUJ3zEXVeDQSmVNIv/poyM/g757cswmbZxEveuzWvcM2GWS/QLoBCssU+Wtt5Wgo75dkJwIshKfgUuefgKyLB6MNK1sLuxN5ZDckZM8gG3x0HztRnARCvbfahfJ4D1GvuN2FRyRNJjKQUT41m1RmNbCPc1lf5umzdJtC0d1TdHW5MLZwNO4zdrzvaTC4sJSJW4F/j7cx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2gpnNbBiyICTWFJcN7qJHN5ULPZEghD+/D8M3HIFIQ=;
 b=AQkBXGIo9oTMX5k74BxJYTnlkbYkimQIdrwt7AKuEY7FPXOnCLt2QJbjCOgBn6uJB4rHBKb/4t+8RzYiM2TzWlplj6vytrbkojVclrOGg3FnSjjvHcD4pMlV2CVJfVFGuA0yJGNONPQzWSvP+Mg2uFvF8MHxBKBrfxBP4UlTwkyD0Zjp4l1YcGQ1M+PIxXsUQ3Op/XMwtGf/9LwHLFns1lzyHVSl9Wr5y7o8msFSKrpulp5uRxcao1pUbAQv+hCpEA/pur9RgjsG/6uwvqfGmkQ7gdN4wrdgH8Hf27l683pYoWR4OfdREGaXz39qNL6kHSB2Du+Ln0yaN/DK3xO1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2gpnNbBiyICTWFJcN7qJHN5ULPZEghD+/D8M3HIFIQ=;
 b=mnvebGdbp9q1evnnNe6r3pdHqbQr/arpGdk1Ipdq6nyVD3Z0a7IVScbgyMnhYH4cHxBS0xCj9A0rLqznCr1R/VAMpkMcaof2oHgqRvxSjrVLsMXeb3q1YJOjVPjFFukfDDA6DdIH/sVZo+HMVLgy4+FtTWEnmM36UoQeE3eSqJk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA2PR10MB4809.namprd10.prod.outlook.com (2603:10b6:806:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 14:24:34 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 14:24:34 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Anuj Gupta
 <anuj20.g@samsung.com>
Subject: Re: [PATCH 02/15] block: refactor get_contig_folio_len
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260126055406.1421026-3-hch@lst.de> (Christoph Hellwig's
	message of "Mon, 26 Jan 2026 06:53:33 +0100")
Organization: Oracle Corporation
Message-ID: <yq14io7uo9z.fsf@ca-mkp.ca.oracle.com>
References: <20260126055406.1421026-1-hch@lst.de>
	<20260126055406.1421026-3-hch@lst.de>
Date: Tue, 27 Jan 2026 09:24:32 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0159.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::32) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA2PR10MB4809:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc0ba65-4471-44d3-a776-08de5dafcb27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h38cEOka/H12/iAS2OpttHMMI98+WFhOeymUMg9fQ4ftNj5507EgPHgor3cz?=
 =?us-ascii?Q?u0Svo4HEOQ7dts5gh36r3o5I3r44hPLf0ni3b9UIPcrADDbePvSwO/UKnU7l?=
 =?us-ascii?Q?+83O1z7Mv9d0BysvIzls9ENIuunmtluRceKqJcsoQS/HH/Vx6K8T9TvFbwEY?=
 =?us-ascii?Q?0e8ET7LPs23L+X6vYzx9w90OH/BmX/UMm99RYki84VIFrbjBb5kB38Mwh8fw?=
 =?us-ascii?Q?UoHF974/2+zMKanaDpLOBG6fqUbgblWcvtPAw5i7BOH3ehbvHhifuKnxpf6+?=
 =?us-ascii?Q?Pg8dmsR/sdm+NIsq9b/pRAzYgETzel9SCXzR2A+t7vetYdmXyZ/TjCjvm56u?=
 =?us-ascii?Q?t73C6R1JH/hD6X5XkXg+NXcEEa8RLA98vmzmK5Hz/Mzq9DFYbTGN7Lv2hKt6?=
 =?us-ascii?Q?NpkhhLiKlmlgKDNCxIY5SoFcUH7NB3InT5HptTHB1SiaKCsRe2GmWz/r3/Kx?=
 =?us-ascii?Q?AXEqBoMh+Qh3JcfvfB57h/S4grzAvD7w7OpEcq1N1R22P7UUhOnlhkSZpfNu?=
 =?us-ascii?Q?hhi6MMT/NKlQjah5MifmzbjZBn1SKVt5ouORYw3DnKiPSBvi51TCN/mFhKPr?=
 =?us-ascii?Q?oX8p3BoRqvH50UoYQG0fURX5Fg5dYXNovD9yqqrafsTYGIzUMoLKpVkua5hv?=
 =?us-ascii?Q?34H0ggvk3ws+csfCnC1lmVy02YtikTzTOcfdBjxvATLtJnt2H14LuyQt+Vwv?=
 =?us-ascii?Q?6g0aedeytelkT5QHNKs4EGAgac0S7j2k/2bFSdanJAIxoZ8o4+Z+Cs+f6yQe?=
 =?us-ascii?Q?xNhntXi7S+HqWJe3DNYMYKqC3ckPnkGeke2vlKEb2a6Gg8d/XAIWfkxhOjZ1?=
 =?us-ascii?Q?XMpt8qZ43F2e9WeuKgGyCCbztUONjhgAMKqRXZXq7PVayNohwWmCtaFy4SLU?=
 =?us-ascii?Q?kjZcwpv6uIoj7C1KJpuDIajQvcpIAa6xv3nIF0QQy7a+VB0H1jexYJ8v47ZA?=
 =?us-ascii?Q?fMcGbrMtq7SbQZWQOyl0oHIJi/kq128MFoN4SPtFbVrN7oSPYRAu94IBguQ6?=
 =?us-ascii?Q?JY+YewdQiZe8tGe9L4CcBnJALhtcYfIifR2EL5cK+We3vxWaf6iVvTcZmUV3?=
 =?us-ascii?Q?Wu6qOv9cMagJbsoxQIj/2Oq5VOUT0vr+rqUn8c5EWg7oKX10FQ6ySCmHI2rV?=
 =?us-ascii?Q?M1fchnm8Nv25NfUGVIdvlc/mgljNUob6VyrW9/C5dXfvUkeDHlNjHslv4Skp?=
 =?us-ascii?Q?3ZSHGfkVnF9wn1dnkp3klg/NTu9LljHSZ6CWW3Pa2wVEAbMtRwwRc3YgBIU1?=
 =?us-ascii?Q?C7NjfwXV5sYGNi9v7x44O8HoiLBWmMSUI5U82tMhDS+z8TwHJI0lOgehroEG?=
 =?us-ascii?Q?m3b2gpNrc8y21uqOk1S6QLp5ydPXquP9Gf9FzuiJSYG8p6IGNX+EvK64YsXw?=
 =?us-ascii?Q?ggJaB9Nnfu6WZoYqYZsCwvIvQ29A7bCY9XdwebpmUcTNPS+gi4dw8od7O5Hr?=
 =?us-ascii?Q?37/zoYZ3pSkvoaHBrN0ZR+Tt/jCII+/kiLtr4aoz3suayy6unNxckhkMF7nG?=
 =?us-ascii?Q?LF5VT5EmmTw4005OejnpsRiRBqTYbWrlI5jNlv8Ln3pEux7lPjf2YVJtq4XU?=
 =?us-ascii?Q?hfeVuTZpwa2pkbMDk3A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IH1MnLPu/6GCkhumC+KPXOwghALKnV39wHDzGTS7bhlF+47p4eaSGnXmFoHF?=
 =?us-ascii?Q?CYMn3pgNqY/7bEICUO8FOumLT1ZQaFG+5jKu97hQp3q4gNyqb2giAQlr7MqR?=
 =?us-ascii?Q?YjUCbzrGVaXTnKLnIbgMKNM9squzQaVEp+zicJZZGPwFzKG1Ww9F7lTXdP3C?=
 =?us-ascii?Q?qZ0Gy3R58j44dzWRQ9BHrcgZwPINDO0TwT3sTeCFAG+3KfdukB1JjwUKaBNL?=
 =?us-ascii?Q?80UXiKAYA/XHg4pnIs92EGmB6RDboHEXQVvH2PcPQgUziYMCAf2cwhe2iDq7?=
 =?us-ascii?Q?lSmjJFQ7yLUjdvRnSHPIfP/O6ti4UZ6DCx5ntql1G0VGTyAFikF5B4gGuQPb?=
 =?us-ascii?Q?wXapwwFObg2DQ4CyHp/6kX+OypBCV/9H2L4wD9ns4Q6AOmSWp2ul9vCNR2Ia?=
 =?us-ascii?Q?nDOXEvb5y3FljY7bd/OxfAcehgHhiISwPOwKwTpQLvLuSbbmgYcRZtBLmNgj?=
 =?us-ascii?Q?oKkCNHe3yjg1NeZo1GnCemx0DU2PZIHFuL3Llz2H1sspvPPnEjS851vuVvM7?=
 =?us-ascii?Q?1yLd9be+1huj1z6zGvroaf3HGf2n1tIstI7Ik5i+mrJS1L5AYWjH7kobjQb6?=
 =?us-ascii?Q?ySqVOEiQ0zom1G71biiwnbFPagqE5VP6gi2CSmlDkf1EUicFqmIy05IM0aFs?=
 =?us-ascii?Q?pMORJZ4Y0VdSi1M8ezHA7VLMxJNJb2oh2oNDCCN1LYf13vJH/FNNbILLbBST?=
 =?us-ascii?Q?EFIM2ZHJBpj7+pSjiRSQlxIXPQg8fraSRHic0egrltoDsnQThtYK+Pw3hWuG?=
 =?us-ascii?Q?5/GvT2la0Cy36tF+IsKQspdIzIrrgVK9SaQv8ML+6YTUtgBoFXRkvNA4hUa+?=
 =?us-ascii?Q?xCX20h/wzF5Uk63KD2yp7+uppFRAXDeFr8SLU3+g/hinS+0fHNR6TEuXVZc5?=
 =?us-ascii?Q?5D5mEjo/0TkGQNnW9pkM/qJ9i6/Qs69X1ybdqre/WLpLpA8AbnB7AB+gpJZu?=
 =?us-ascii?Q?UqCtUCatzrAYHV0c6ZrteNpEJamA0Ji9/b2SxgdRN025JRc804Qk20cfwJe1?=
 =?us-ascii?Q?vck0vZnkvtEVe9jp9Z++2Ky64FiaffOevtMNPPW7iA9uFBHPO+SEW0q/SzZJ?=
 =?us-ascii?Q?/WKiWnlM7If8rszW57gidMps5UWv/f5wpfmCoeGl7OVQEfkf0dadxNLeuWPA?=
 =?us-ascii?Q?UgLO1BJGaMip4vFZVB4Z5C7RYS2zs6ZWN/mhUQPrk7e3qtX8+NpBrVOSSoiU?=
 =?us-ascii?Q?21kxZ9+W91vFz4EA7MOcb7cHlJfaNoBOEP1/bNPP1IKUel1JacBXenSAbHp4?=
 =?us-ascii?Q?7nI9c5v9NAOL8JktjBd9AxJBJWlcRqGbA7oFCRydznrh9+cdKM8Cb/RrPFfa?=
 =?us-ascii?Q?2iGx0Lqpl9JaxbXpjmDcbV8jtmfiAlD6d8aDg+8cFbbyvar162CRfxV71I2d?=
 =?us-ascii?Q?o3n/TKHlXaRb5JWGESWcYDif6qCh8G+XER5gC9yoFGWAM1aH/faUsxLLM1k3?=
 =?us-ascii?Q?Gq1+cHeNH8m1IP3Fyd5bEwlu6wbYtnrQKhoDMGeaWUXV/aCSLzYQmKV7XD8y?=
 =?us-ascii?Q?UV5i9eGkMaHw3DOSsq161I5Ig48yBw/ujgMJEXLPF8+7O63NAS91q0x24G12?=
 =?us-ascii?Q?4nKAXk5bG7CqE38dLR6SJGOKKMJDSCOAGIvNbBRCNnccU6/dNDYeWi9AwxxY?=
 =?us-ascii?Q?N8vlKHC/FEZ9Vk/41SAk6bkoHm3yJMJ/IW4zwbH3gVaoJRh4zXdVISN6DjaZ?=
 =?us-ascii?Q?Khd4qExDS7zg/CHIPUa5AvOGOuBGbyna1tzf1yZmEGn7G02RrUCjarkNSVs2?=
 =?us-ascii?Q?/RP3RkpN/6g/w/pBS6R+5r8b/kjgMcw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bmtvM8d7KnDnOmnayCUOScF6yajsfNxS7ijVSR0XVvaLW65B8r/pOFN+n/CPWBNh5tJUDCC3GaSEv/vzlgIvdioDP3GBR7TUtNgz94l1DqFyQkDQLwFo6u6/A3VSjK0KZ8YwGr4GESXmMEXFe3Mn44QTX4YHVCf2h/AqP6ZcFZTrR+sgMOaQBFG6giOZLg3Cl5dAtSQATzhe08FgM9fxXDw7pJZOV0awjfDfBV7tevgxDSdRlZ7eA3xZVdESYm6xhsbUPQL+eIYjlpLnBa5N+7XtDRtqaA5sb8DKi+94mjWpcI1xvoQ4c0S4Bp4YsTO0leX8qd29XgtLVp14/zOekxotGhjq8w+Vj/XcxB7X7QgiUo/gHssnoqlUCgB9kaG1jqbIm86q7YlnMNJ4u37tljDRR5MthAgLZSJeRZkC/ggqy/gzXopiLjqSN7iDDdpDHQGP96rL6OX4mxKpwcSy1aQGKHNScjtAiTfkVjCDeBbeqtrXKLfNZcjFSYKJq56hezBMiUcT+GiPAEGAO4bieVSq7YRjYgLXofMyI8b5Tm8QSDo37UQaWnAZJoMPOBv6Evd51JOvveISuQzpJsCrPD8C9Y0N5LZ37C2/AGFZW6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc0ba65-4471-44d3-a776-08de5dafcb27
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 14:24:34.3402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKADkkek7/nnu+ZUW6ReH875ROmIAZxvgxv2jja45MtmPtpgg9Tyw3qcoLjuFblJUcEKHjhfCOgpCtkbUXxOBvlIotwI9glYUYJHQbQkNqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4809
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601270118
X-Authority-Analysis: v=2.4 cv=dY2NHHXe c=1 sm=1 tr=0 ts=6978caa9 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=8UaOfvKcbODBgupGU4gA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12103
X-Proofpoint-GUID: LgFjFytW9-afhHcAt-o-FtqyWLN8vFdA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDExNyBTYWx0ZWRfX+ynw4NXVrjRI
 diHO5mMN22k51GUwhTEprE20N1w2fxudrmTD7a90+JIpbzT2CVwCai/6YmaoRmmuZV7DhCOcxHo
 F0hWq7EXSIv4PqG6WMNNu+wPInyejMXic/eS8uXvhmGgRC//6VH8XlxZ7busQ1BcBxLdTRpFdnZ
 bb41qjgQw8avHzWZV2RUyEAE+D/S8Pq/NAYEZXsNiJWKn7f+IlGnA0+V4luFFIRSkvj6vDUJok4
 gv6UVmBCIA15X8FHv81joff2c3bCvCEclNkY8SntuRJD+4Zj5E7j9Akiv3TwdjWSThh9DyNNOys
 vqkd6PGLTV6vf3KvtuRNbOCj4k2a+q5PWyKZYukRwgmxqqAOIQ8etsmq5gn7QtqGSvzea/OZpiz
 tD2usW4uagbC3UkKf0OraINSlIe2MbC/ttA79Xli/FlDshEtOAyuPldI++M5Q8D5TQDeQro8Eof
 WcHbgjzH1Fmu/AAR8S/k8PcnJubZODkTO1v9wEvM=
X-Proofpoint-ORIG-GUID: LgFjFytW9-afhHcAt-o-FtqyWLN8vFdA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75607-lists,linux-fsdevel=lfdr.de];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.petersen@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,oracle.com:dkim,oracle.onmicrosoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ca-mkp.ca.oracle.com:mid];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 5954095B66
X-Rspamd-Action: no action


Christoph,

> Move all of the logic to find the contigous length inside a folio into
> get_contig_folio_len instead of keeping some of it in the caller.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

