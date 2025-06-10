Return-Path: <linux-fsdevel+bounces-51152-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB6AD338F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 12:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E033ADD54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B328C5B8;
	Tue, 10 Jun 2025 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OyZHXk/j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GX6y7zU7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EC125A62B;
	Tue, 10 Jun 2025 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749551232; cv=fail; b=VL5PDvYwnXICDZXZqikO9FkuRVgqFDs2zX2aOakvrfV1m8pg4erTxGj41a43lTgk2ZD+YJ6buPTpYt7InDwatZk+PdE1xypqUtwftDcjCWyTeTuTdg3xQdR6qbCG5KISoc2K8BToTchHqqq2hNX/GPvowf2bBq/np7NBUV7L1N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749551232; c=relaxed/simple;
	bh=PA69UH3/u2b+x4VcBySDl54CDAPsYB7A1g+zu6ReZhM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=susSiMXJqjxBG8gKPJUHLjURnaWxjaYlRl0xa3+qWSKaWYUXbTPnt9K607mcnevYe+mzDSEkCJO7ykCRnovxlwh+NqcuuFMDlEsEiVDRxZlXs53wVTMYq0yOHW+9PTCMpA08vjDB6z3ZXlQEKYjE+Iz67BfCgkGYc8k4Ad/FN3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OyZHXk/j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GX6y7zU7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A2fYnR021468;
	Tue, 10 Jun 2025 10:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=YfAnbbb5rc1VM6AULB
	jj7qCAN/bbHjo9qtB0rnTmE0w=; b=OyZHXk/j39lYGFglL7jzhB7mz+RHl8j+OP
	f7XLGk7/VDliQe41ZbWbTh+FMeBjxC65BzplzKP+ZYjChNPiSh9TB4TvzaEWXnvV
	VHEJIWI5DcWmx4HPrhfTiR8QcuY5WuiQJVkvFZBJbhvz15FhockGvyBvfl1+0Fx5
	Fsoep1nmkk1RUCcnH+ggx78OX3hk1J0d0PELYs9FJFpP1bW1xVD2B3vMxp/4N9KM
	CE3f/LelqKvcdlu3qgxgbkBabPaTwMFLMEaJntqrSNJXyh5LcHoSiOGxrjPMyQw4
	HCn6bVIqB+MpYjqTGKwvAPZMoVEJ6viwm/hsLRCka/U0pStlCLSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4752xjuadq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 10:26:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55A9e7WA011859;
	Tue, 10 Jun 2025 10:26:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv9hgaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 10:26:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qmt5rWhfKSScJnEyRVIL9QyMCXYj15uiFTeP5HGB9fEFn63WC6kgtL9SaEjfZOUpC0TT76vc9vemab+0M2ohOpTptsxyVA5fZSmZIhxelcFsiH1qm1tC+kBsYnhI3oRaLdH0uOd7IXXEpiAH+gFOS4cziRP0CdlqdeT1w6d7hXfWfSYYCyLI7Qrm3H+Rv5KUigcKzo/gFmunZeHT+QRNT0UvL/WRyKG8LPGP1J28pnM+++nPbSE4kpFtgmyB3cWC+QfLvY8tyCO6BSo4BQPOGY5IkF6Cdliz8PCZo9iqSueqGSwrVMBYjauBZueg388cYlXxn2+EmBx+pziCiiTNGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YfAnbbb5rc1VM6AULBjj7qCAN/bbHjo9qtB0rnTmE0w=;
 b=ytXV+n1Ppu89YGLMQ2tinxVNt38/NOWlCFKtkGhVFauSDrRq5vicEyO3AdF+JevE/yqfD9RIqUJqdebdIyVJNp/V1+y88QCtaeIr5O8UDRmuSwweXJDHGjO0PEhykKHveuUUD+VcmhYJR3uilhFp2eoFpFUdo4f2ZlQwF8lZdlnQ6xnT/vjpQxa1W3PX4GLXDRVvXse6kimoV9zcWoFn1ytNDOYFDS1KZ8vHpES9+5hO0a/xAE7RekqPRSXcPxjqjF6o0wPRLy3PI4byxLJb+QfPkooiTPkQsiWP5SHUgQ03GXNukQJca4T+DZaVSKeXuvjykS7K064UA7FDDP30rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YfAnbbb5rc1VM6AULBjj7qCAN/bbHjo9qtB0rnTmE0w=;
 b=GX6y7zU7BySz7l0eHw1ZTOUQV65w6Kk/5yoyW9bxATOukYRko0apNGejv1rNUwcNRSYQyQnpA+gzACerhcn4OYgLu/7cUy/3co65Pg3Nyw61rp5P0bjgsCJBzVU8PJc0S42jXIXA+YmKtjTgZsEn7+M1SWHROArhouoWdAAQzts=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA0PR10MB6820.namprd10.prod.outlook.com (2603:10b6:208:437::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.29; Tue, 10 Jun
 2025 10:26:55 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 10:26:55 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
        ebiggers@kernel.org, adilger@dilger.ca, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH for-next v2 2/2] fs: add ioctl to query protection info
 capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aEfDOfnSq7AtiFI5@infradead.org> (Christoph Hellwig's message of
	"Mon, 9 Jun 2025 22:31:37 -0700")
Organization: Oracle Corporation
Message-ID: <yq1jz5j6ggv.fsf@ca-mkp.ca.oracle.com>
References: <20250605150729.2730-1-anuj20.g@samsung.com>
	<CGME20250605150746epcas5p1cf96907472d8a27b0d926b9e2f943e70@epcas5p1.samsung.com>
	<20250605150729.2730-3-anuj20.g@samsung.com>
	<yq1a56lbpsc.fsf@ca-mkp.ca.oracle.com>
	<aEZe79nes2fmJs6N@infradead.org>
	<e044bbcf-bfd6-48da-a7cf-e5993287f288@samsung.com>
	<aEfDOfnSq7AtiFI5@infradead.org>
Date: Tue, 10 Jun 2025 06:26:52 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0032.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::45) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA0PR10MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: c605b8dc-f7df-41c1-ae38-08dda8095294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V4vqDNGmqRIbN7pylxxWlTpFIN8rplK2YG/SlIIJpZzUVnoH/D3Y89p/0okt?=
 =?us-ascii?Q?Y7JLq0uXMcXnmhWFtQw3I1q0XUP2U57ZKF5zJkoKa23Oe7V8CTWVF+doz9a9?=
 =?us-ascii?Q?4Sh86gHwGQ+YfiBxpkdFGHuqxdGYeWDI4lXqvGHwgFr441bBvaIV4xdSuFgX?=
 =?us-ascii?Q?RBBxoi9k4W0opAYyUDBv8d0Gg2KRFoMFXQ79xD9klL4IJs4vxalrZhX1ipg4?=
 =?us-ascii?Q?MLK6M+4N0l2trGKitLdMLoXc4qdlLxPwiW0x9kuDQ1jlxwmJ+b0ySqPrvZmp?=
 =?us-ascii?Q?C9/94Wyxb2vHfK71GM1fCpC44QVb4JI29scl5s79kAcQvMekqgDTSow6xIMO?=
 =?us-ascii?Q?Dkc5/Ng4ZBKTeZou4YINsFY9moPCWjHnhg+ur7YEy5CLKbvldOJo32cSCnBK?=
 =?us-ascii?Q?pMARxtItqBpp+MUQvr0ejwP9CFPOjd8cuRBsDN4fU9WuQ7hLz/Rsx7rV4ohQ?=
 =?us-ascii?Q?vtZ2ahheYXNzHDnFZpvsxkNPVdjhpqiL0P/kfs22Q3R2h5WGsQuHno47U02p?=
 =?us-ascii?Q?HThlrex68CQ2NiN6E0N9iedfzFkGkIR16Sbmt14oBxRSQeBpYtZSqgmv5ilw?=
 =?us-ascii?Q?SOh8+xSfg0SUzFPDkuGRx4CKqSG3KArG6HkNgIcBFhVlj9KEyBm94orxVuj0?=
 =?us-ascii?Q?HfDrFZkdSZe7L5ij27fWTc6RbnGk+hhRhdSEgPw766VkvSnyGjx3tyzkJ2dt?=
 =?us-ascii?Q?nvEzVQNh6Q9ucsvqYLeTX1dPDUpIjv5rX6wW5klitlJVrROZNKvPgn3VJ8Cq?=
 =?us-ascii?Q?oC4bNolOeOfzMXUchDhbM/xDg0VJayfI1Pdi6DTZCsthKvb3A8gFRvW+HoxB?=
 =?us-ascii?Q?fw0BsibvEIFiVWNzK2v4jQvFTeuuw3f6ySO0hD9i+l+Cs0NiccFdrrjmb8fI?=
 =?us-ascii?Q?8Y4tvxuFg5Yzt/VNk/s8PEiGPgm2xHbBahtk4bWr2GZeFV+odB5OZ1e5wKcI?=
 =?us-ascii?Q?rwYlJ7tCx+I7ufswqHas5f3Sd47B9rT/Qx099iZgRCyv/bPLP14ZHD91uThD?=
 =?us-ascii?Q?XAhOt6Tw6m9lzIh4JvxquDORp4Ah/OC29jOtboE0aMYsHTGQDwKLXggPe0mj?=
 =?us-ascii?Q?fv3Nqr3Jb1Or7ROvs1f+x35K+WiYo3z9ylajOZZCoq7ejF3+lyJHo26yUJ9b?=
 =?us-ascii?Q?ioxUoe8fjh2c+qJJquGsN+ltcMwaLpicg0KnHjqeUu85qYQi6HlFp+/QCWRk?=
 =?us-ascii?Q?BLcgQ6EMeN3SeSO2UA1vNvVg0JWXP2JbzrYKEKq+KAQCjko1v8vRAykhSoRb?=
 =?us-ascii?Q?e1eSDHED/j9KEA7O5ZSaRb/UWTLNOrJCJ/p3cKxE1GgrzQIN0Br7Q/daBOHD?=
 =?us-ascii?Q?D9PEYYRsZOKHzx/m3/AurueAlLA+M6wCSaEcFFtGCX5QgNaUgKZloez5Aubw?=
 =?us-ascii?Q?eV8kYar+l3pr4e+QNXbf+yuqHx1cC0fTW+8HrvCLsEaPzMExwCiV7ij9jUlP?=
 =?us-ascii?Q?rWS02d2RPtk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/u5+5Nvu+KcQkC+9y/tnHy0ncgPkZA/gpZhVW5YFm8OaCJdxSLWHiUnRqzfU?=
 =?us-ascii?Q?eOaBU/DJULq7g+2qu4+T5eO6twPZ9JU+8koIX8E6tJ/QnvzlZF8Pgk6IL84o?=
 =?us-ascii?Q?KWDTBzNcMnqYjVqIDN/+10wu4Od6MlYVNOtDQn+ep6NEpqUP/NvTfuUdZ7TA?=
 =?us-ascii?Q?H7Rgbegvb7xNl81kLl8KDFGFEvbCeuFyNMYnyrGznhqgK8rz2KMiEcxLJ59N?=
 =?us-ascii?Q?JIorrp+DvxtRGgNdnQA++HfomI8XBui3oCz4enUuKYDPvDB0uAEtYqyQWYIl?=
 =?us-ascii?Q?UsRAQv3HLmiCuQfKbQsL7LpSq9WFm0N4M4IoHYEzrfr+CPPjuQkRlHKdIXbf?=
 =?us-ascii?Q?OB9ofjPq1LvQdRdjRhnOnPins7WyBzHc1XDhuJAmvD4MdSa7tvb3N4VEEMcf?=
 =?us-ascii?Q?bcTF5CIcnUpn/25Lpp7d2iNqO34jX/MrZh5L3W3T6dTvZeZ4PLRFuTJiykZE?=
 =?us-ascii?Q?KMeC5Xr4g4+75j4B00RQIzTA4YG2/1Ap5BTUC/MNYFYZQakg0pxjvS6RvTdj?=
 =?us-ascii?Q?kVz2/OLi2CtNNNuiA21Bx9MOhqmGj4ShZuQY5929U5mA4EdIazAfdWpZvvEr?=
 =?us-ascii?Q?4IK24ydhyHJ1go7giqYUgdtGaBHL4T4wdN9nGD9Zubu6h3xUO3SWYTs2kDkx?=
 =?us-ascii?Q?VW+yub7b0zSnOGHyy8Qoz2gVlORbUEOQX9MEvA5MJH3CjODHvFwHf9xzsZ+R?=
 =?us-ascii?Q?rWNEifJw5l0nEoiDed5CFBzI0l/G+z5F52zgmhrBiY9uTHaEiRmWaev3LjHl?=
 =?us-ascii?Q?J8G2aiTNV3HIRK8rA/C38fsyIVzXM9f0Efal5+hAAldwSOtyyN8/30ITHRwT?=
 =?us-ascii?Q?vrK7aGP0Mx1MPT+FMyoQGIjKZyNLb1Is2GCPHqGjhQqhWR7Wtq6DVieT8SFi?=
 =?us-ascii?Q?KgqM94H8doFrduEqkRBN+qoLugYnxXJxxw773r1qDOeSck8/iRxr20OERe4k?=
 =?us-ascii?Q?B8FaxSgZj8VMKpyiMGOTMnASxT5RNe2H+OPz+RzDboM+1sOPfZKu7uVhqkPE?=
 =?us-ascii?Q?EfyIcF3J3E/I0l+FnQIJlpoTFsOoHm6AzjPOS4rCHubOxJkT26L+WmF7edSR?=
 =?us-ascii?Q?s0dcRVdUVZ2bbKG5CC4n7GWwtw358xIBqRXp3w3DMPhgBxOkrFUKJXt8HMIK?=
 =?us-ascii?Q?jcBo1Gx0ScSHZt1fzC3bx0ODbqMmY75bzh4fhmMSJvsXER1nreF0X9injREt?=
 =?us-ascii?Q?PQN86qBrqv7oiAirQ73hCvR1+kbrgHFkh+mgk6sZzkS2fZj9lH+2t2+xaolv?=
 =?us-ascii?Q?iCvndlFcTzDHhNv1O6QY3q/mWQDR8nkhGzMAePUe+EPURMZwf2qMMnNR0rdq?=
 =?us-ascii?Q?G4isRFFFBsnGcGRdUzMsOvDpwDouk5hxEPe2WtaYCgxZbT6Zw7XfCVvXiNur?=
 =?us-ascii?Q?kEW/du/4lkxGNQgw4NGPT7guCjjDXGet2b8+Oyx7gHQgbvpjfZBMGF0hQhrS?=
 =?us-ascii?Q?5c4atxlup1jdhVs2vbWCKWp60JYOHbuYiI2PvNXquFui93NFgGKJ88KIx1zI?=
 =?us-ascii?Q?K2PqtGPcQDgHuBV4KeblkR/+u9v6VmAE/GBwn6/YcVmWYuQH2Fk2d1Cxa9xA?=
 =?us-ascii?Q?c5EMv0jFSiVatdbIdTtsyM84sTHEGbeY+eo4/Jrecxuow2l++GtEnC4JUj7r?=
 =?us-ascii?Q?Jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9zaBczvPysSQ1D6mlUvMjcmVT6ENWjTL3oCVDcAafqnOwn7ab98MnvmGx3DlhAMVYu8mlYCptK4HZs8AtUFBewnFvWKjnpXs7l+lFU1OpoSgXR/qyY2gKjKuJAVrgxhjg9CXY/Zv7GWGF+1R+WS/tuefMdvqTpEMQxVZdtAF/DEqW5yMDTeZtq074kxig+Yuv7XE0tO/gN7yMiB3EOFSeMrD8EBfAX8Z64kujLLMheqZizOsQXPHaSAB33zezBEkfS4OgJgKPGck98oi8ft0NVWG6hIoCXKZjnNS1gzbcp2bW9dCI9+7yV5EsgiP2bLKWAKUBawSrgklt7vA5bOZN5Vf5ris1KppoUbFRAsXLW23JOW2wwobe5gMl5Xs+T90Xqz+yNba2mKkyZ7TKm9vUKWqNSQIjRplPbYoRF89vTSUMbT1LyOSavPzdhBnnQd4T9YPG2mTsJg/LjfRuXrTMJ9q/2apjgeWBhWOFGfh4oBHu9PjGt7v2686Nz8/XFdQ9xwqEBoh0HLi5Wd+f+f4mJXE5Y0qEN+IYxXffSoB0lkL7xu71FiaVumwAhYMtG8cuQZOKV3AH8P4FcB/sJpCz4yrasLpp7vztNcBvonRFvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c605b8dc-f7df-41c1-ae38-08dda8095294
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 10:26:55.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bz8d/WWsji4GvkEskx6O1GU+oB7zRn7Eu3TvM/bXgOCxubcLvl6Yj2CeesBCLPA2sKS/i3pllGhXS9wOjQ8hLgvnyICTYD15JuazsfUv5VI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_04,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=968 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506100080
X-Authority-Analysis: v=2.4 cv=K4AiHzWI c=1 sm=1 tr=0 ts=68480873 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=Uvtlj3AoKLEsxByVg3gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA3OSBTYWx0ZWRfX55aVBc4HmPb4 FftGJsw4yofQn8pG2PL862jFHIEeix0ylpISixkILjxKmi9rDETupX9pJlF9TDx7ke7fsk2wBuv qh4ZG6I47Cor4TiPHQw0lhs7b1ruUkfG0eGH6ZVOzalkkiAWMMZjUE/4aCJ9v0L63hgYIQ14VX+
 hbG7T1HTeC/k4dU9S+MYrQOpkocAjKTAeANx6J2gL6/IEcpUo0ZRtqx0aVcQZ4zCdykzC0hnBqU N2j/cY7PANmL4ZSRLjilLhumuhfWVj4I9CV0vsvPipgteo5y0Tnf4SZCBfvzHvhyA6LLg4fQxiB Wb2HdxBEcAfaxrfbZ7ITjb41PXSBPSPjQ5puOWbW27ZYStGaShU5EoilDgGz5VQ32Cw+xF7Wc2H
 5+KL2nYqq1/kMmcPWNPS4Jzu4agWssROfa7fSCsMOTWmAFWyQqvEHG7rgMgu52ZEGaa/mdwE
X-Proofpoint-ORIG-GUID: MM-GilN5WCj5yu6rIxolbY1vlDMGEV3f
X-Proofpoint-GUID: MM-GilN5WCj5yu6rIxolbY1vlDMGEV3f


Christoph,

>> Based on the recent discussion and suggestion from Martin [1] I was
>> planning to use logical_block_metadata_cap instead. Does that idea sound
>> fine to you?
>
> It's okay.  I find the name a little long, but at least it describes
> what is going on.

We could drop the _cap.

-- 
Martin K. Petersen

