Return-Path: <linux-fsdevel+bounces-57977-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF77B2757D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 04:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EC516A2BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 02:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60918280CEA;
	Fri, 15 Aug 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nPB9Kj3J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nEdyxIvY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD924293B;
	Fri, 15 Aug 2025 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223783; cv=fail; b=IWMAqO92u5wlOl9N29I2TSlCOCnuOd7AIbj+iHMrJLXEJuKArhiCieCw87jeNTXGTZwy02MLDWiKqEdkb4titulV8L1AhU9I0vRmlV/3bsjKuOHgvgXbaNRHZuaXogNQxPMey/x5HHKHnEyYtraEcgO8zWadiUztgEIcXEafcmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223783; c=relaxed/simple;
	bh=O6qBo2S39ACpQCWjYQH3eFAUXustJrImSGtb7j8xfuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Rlz56bY2N4zzN2XI44ymk2PVlhAK99+xwi7IXAS8r7ClheiOUe+vVy/NCb2rA0xB6qgYqp4d0Tj5ao1hGe8rkjMv9wMAvH0/M/FzRRsd7eqWxNrFn85RSylT6898fjRhsJr743hNLJG4TcUE1aDT6Jh7y8WEjqRXxCVRxUonqe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nPB9Kj3J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nEdyxIvY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHfr7Z002580;
	Fri, 15 Aug 2025 02:09:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=QyeB87DMbfbsdOoX7/
	RpyacOSxBkhydSCRJdLyF0T7c=; b=nPB9Kj3JRy4eGYYXOtZ77nL+Z9dVSGTXlv
	vph4LlVYzriuYB22DS8OT607rMAqadR2ANwaSBwdRS43b41kWe2LHD/D5Eg1yGqt
	vKPM3REgMaEb3Pte//Ic0jDVIZGGMxKtut8n5B/KFtfikYBzWc8RV6An9ZqRYa1H
	7if6nwmwfcCVFnvK8SmWN+0sG+y12igjhi0loBiSnkJCQYl6BQRP2TiMEX0a+EFD
	lY60+T/P/o+EiCMnuGEu1B0FT3ONwsOcYBXu4rLdgThu0BtX+3wNiuaYGdxGtluZ
	iDxmuiURhqSZsJMl/bJoUbamZ7w1AtWUX4JEWiuIOvl8yp5qMyqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7du3fb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 02:09:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57F1tiHj038674;
	Fri, 15 Aug 2025 02:09:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsm23mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Aug 2025 02:09:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M5yUVfQ6QZsGVqrSwdldlAg7C9ridzhrUWM14pCLugFf5Q1FkzKNl6wySciTHkH9ubs3uEQfwnJfSEcnvqSUpyWNjNuYOe5E/9jnS/As3Co3F6Jt3woma8IrURIwrzwj94QHSIzOoJnQnZ1TYw2MR9TsudocFSPYhwww0+z7BDdwtBN5PYCOrtW0uvEC6MdVrHapf0+GAyrKcoN2q3nyrLDguHtv/nMQfyjo2qgQUkIuUzgRylgbTc5S6AEWhXZZXTjeLSRPEKCdeUywBPRYcg+Q2TH++AXrRhHrQVUll/ng0uhZ00YL8bMwcjud5TM5cl6nDEr5MAxccSmZfnL0tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QyeB87DMbfbsdOoX7/RpyacOSxBkhydSCRJdLyF0T7c=;
 b=gAwzzdbnTQD4z7Aqqg7LaZZ9JzvmtG798atEQHz9KS+rR8bNm1S+RidZwF8Ag7IqDuwiA3to3HRDIVSBwFv5Qda1s5oZpXPcRwAhLeh31ORw7XQM7FslJ3DDy7zb9yg1U1G+UWYkJuvHy2Al4oFqY1POh8AiZtmUU3Cz+zUN/7xY5MotsxPX0ulG/vtUGG+IYJS+lkH33s352YFGuqjurUxqY5WsqlmKLxumZalHTr5jHG8KTHCju6skpGbwOELXRs6iR1NM4TZgWlbdm09Yrab+2ZoQQ5ojbzsn799IA2tsklc+nkkaKHoY3VsQ0137P/1I5eIsfy3cxkG/L1Z6Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QyeB87DMbfbsdOoX7/RpyacOSxBkhydSCRJdLyF0T7c=;
 b=nEdyxIvYiuf6918VTk0QpR14QWGZMSp8DSABcrwah/0TVJm8owGfu7B7kMBa5w4X8Fuu8feMJmiTK/+yzsWwICUGpp5fMc6k/Ui+t+kR6QgsIq0sFNoXq72sQh0PNxUySYWm5IQINJYNTS0k27l3RE+TUYEMhQR9+iBmR9Q7nPY=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA6PR10MB8135.namprd10.prod.outlook.com (2603:10b6:806:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Fri, 15 Aug
 2025 02:09:18 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.014; Fri, 15 Aug 2025
 02:09:18 +0000
Date: Thu, 14 Aug 2025 22:09:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] testing/radix-tree/maple: hack around kfree_rcu not
 existing
Message-ID: <wh2wvfa5zt5zoztq3eqvjhicgsf3ywcmr6sto2zynkjlpjqj2b@bt7cdc4f7u3j>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pedro Falcato <pfalcato@suse.de>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250814064927.27345-1-lorenzo.stoakes@oracle.com>
 <kq3y4okddkjpl3yk3ginadnynysukiuxx3wlxk63yhudeuidcc@pu5gysfsrgrb>
 <20250814180217.da2ab57d5b940b52aa45b238@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814180217.da2ab57d5b940b52aa45b238@linux-foundation.org>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:111::26) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA6PR10MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: a1022068-521e-4d9a-8835-08dddba0bdf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/KEnXtSuoHMTZYOltlNnUIzlf0H2/ZmVO0vD5CFZYCuDs91KWnrpZEHM3RQb?=
 =?us-ascii?Q?oqEWIk26NMY4hDHrZlHQ9r5b5xU+UJn2jFyG6SPAh3NQOVp8PZAP90tgCLMR?=
 =?us-ascii?Q?5rZpGkW7KTYL6RGVOJWY4IPZ1emriq8i67p5H0BDB/EhDj7aIbShuvXdyg/d?=
 =?us-ascii?Q?Ukys1Pm3CwY3BdsY2xm8AItI5YQKkTQn1Sx9FStAaAy93vj+BMV7SV7JtfWn?=
 =?us-ascii?Q?1GrJ2JlCx5CqRroUUMGidMkpJG5JnYWv2Lnd598wSQZ4scDiPvQym9E1nPWt?=
 =?us-ascii?Q?MCo0GX9nPStIoXbXi4TVJ7uuSoFmxM2U0AvX2M0QpE6xLEW6v6v5qEY4ZS4l?=
 =?us-ascii?Q?KwRjhuzcVYMcmLX5uIXpcmYO5S9ylXJWx11mXJHVYysvzUsQ0FqCmJgAS5VV?=
 =?us-ascii?Q?tzpGYihHlfaxANnnHUZh54egGZBnBccgqKoBXTl+8SNAvvdeUe+NON5NWO00?=
 =?us-ascii?Q?Rk8719KYBRNfuPfMVPS0MZPYwyBtzL5g5pHOi5pKTRFi5irAOT+4bNq4AZZ0?=
 =?us-ascii?Q?lD/QIQpubrEhncPbdq9sFq2YekXyXP3L87NxtB3Y9qR5+mRpdtXasMaRQ/nQ?=
 =?us-ascii?Q?oK2rr9Vm5yZxwNa0/bcZk8C2gJPRsh7Zi9bZLt+CV0zbHlBkX6+fQ+eEEv/Q?=
 =?us-ascii?Q?bUCRDsoQ8TsSz5OUtwyRkRju8W5BM4dt4WolZ4m2rM/9XqSg7e2MPCeAZyRE?=
 =?us-ascii?Q?odpfBXQktDDFRbmuxL87kAdTQFohLAgLg0gof3vcwkgmZZGL68F9Z65borip?=
 =?us-ascii?Q?38HI1gB9jyEdd8sguDM5KuThpscl3cXfUxHqhvDh+Siy+bGWGEuSmhnu3gvh?=
 =?us-ascii?Q?HQk/+TyeJHIfDHENGtYGkGlwsfMGkR5CDDmqmKTztY153/qQsLUP7Ot4x/QK?=
 =?us-ascii?Q?sHx2rHDezeAn98LkHY1coZ/P3Rz+ca3X2OTi6qhfc87W/T3f4qJJYIR3Vepg?=
 =?us-ascii?Q?kQDOWy2DRVdvGxDPlP5ebyMIZzo9dSK/cQqwLhp0R7TIgTBVZpCnehzueZOY?=
 =?us-ascii?Q?1thG1yDdl9bSW18xWnBIEmfQXaBFTLwk0IVA049KjkTlaoKrNaKfRNjjP3O7?=
 =?us-ascii?Q?udoKp20w9AefJv+z4AJ6ybbf5P6IoUzoRF5qXdwj2kp27QrInaHYV2a+/KQ1?=
 =?us-ascii?Q?46liXWKo7qKBj0ZMrZDtYdBO05cAHeqV6IY507csW0wDonH2dIfbY9VHi729?=
 =?us-ascii?Q?74L0T8gqz3SFV+qHraKcRLyBLNzO+w0rerKi/U9GOASNFWKupQrfJQicBIfI?=
 =?us-ascii?Q?jDxklaQs3s3jCqzF9x+UqbqQ4dBFxEH43LpbDvPexqZBW8KgmqhyoMTxRQ8l?=
 =?us-ascii?Q?A53t1IBvwPaWRlQExCgeGLDP+8d6AQ5XYvXOehrWs65VvldmntFlZ7XYVdlJ?=
 =?us-ascii?Q?RpKJIgDiSisGXGpTx/XhtuI4TDK7ekPFXGsD+bUQdPMy4wTiOztbe16QYkZ6?=
 =?us-ascii?Q?zFswg5+t4aU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2C/EGjAW1KKFCe7vPmbL3lY1oBz0o8z4MnEyHP+oB2Itpc9YCWWm/ztaBZM?=
 =?us-ascii?Q?CzbZuXRuWSqPLuHAMswrExT45T12xcrjCmjv6R94Op9wqz6ELGuMLzq5Nqc7?=
 =?us-ascii?Q?Xok2ijTlIymKCNO8dPsaJIlYZSeLmR/SL7hjRwBzP/iaAkaXroizk/Wz69Ni?=
 =?us-ascii?Q?g5YvGi+fNQiDsJjrCcLkqsHVat0pBzhO7OB1lZbEemm1u4ggRHOKN7mptL89?=
 =?us-ascii?Q?PuAps9Nf0aQDQOtfLPHgVJW0s46TSLWdTJzs2fO3xnqInoUz4nOscZAIKTBq?=
 =?us-ascii?Q?JNSA6O3lpghauGcZ/+K2whiMK6hYZcD+kgb3+V0f0S8+ga8CKb1XnXRxtJ8S?=
 =?us-ascii?Q?2ksI6VuOiOiujQor+F6vbcEQY7SVR6/jQ8J2N9hUpnIv7bR2/bqlKX0SLL6f?=
 =?us-ascii?Q?xs0G2IjWECpN88kbYv10xU4bs0IH4XDqzmNHOenMPI9jRoeiviPLOGeh1WYK?=
 =?us-ascii?Q?xixJZUug/feGzlq1Sle1lLv9b1jF5A6CVDE0+ugvgRRrfrsGbtvMuG3jlqdV?=
 =?us-ascii?Q?cqrexQoCTcGRd6UgaYvevuRSS0584fedcsUrNtDEBX/5DLLe5d1B0lB23JHj?=
 =?us-ascii?Q?TB2NKPm9RUtFvnw+EimqBBLJhw8nylS3zABHIPx3upiDmtFatV54DLUe9m61?=
 =?us-ascii?Q?iMJMdqbWQL3rwC2+jk07lFtOVIHLh0qLQ392IYxJ9jFKtjkmXunHce9awqT7?=
 =?us-ascii?Q?VPC5u1TmId/dsa77g0LiVAs0oukRQK/gcwai4vX4jBDizYx8tlRSCeE9lVVq?=
 =?us-ascii?Q?+T2bf0uekZbW0SxJZeWU9whIvDau8ToE9TwCvMHikrrbrbX7Czvatp8MbFY5?=
 =?us-ascii?Q?A3ib3Pp14vAJu0sqnN5MJrPvXa79Qxy8oN9CGXl2gFTA9qz+jES775AUbsJZ?=
 =?us-ascii?Q?Hl9xm9oH5vxvcKYgHILnQxyKSTQWyV9m9rQGbxGio67Sgnn2FlPKSwglt706?=
 =?us-ascii?Q?zrs5DQ05flz/HXHtCSRyRO1NM1R9aonTGGhglPqiTXfrRAsVcYLghf14POPz?=
 =?us-ascii?Q?8FeB4ggy+WcQUuh3WfrdeZWoTFhCxOEdILd2u/96DmxVZAuU24AzESJQg9px?=
 =?us-ascii?Q?8H3KmfMhUmk9JCtio/iVDK3EkhkqrUVX9Z9sLgYebCOtpigHxKh7hD/OQNEa?=
 =?us-ascii?Q?3fmhgn3Rk/83T4PHk3iTZNNf0qGLjfj4BDTVS3Y+MNpeWE0NVhbmctkxxN8v?=
 =?us-ascii?Q?L74N+MVwRiTBnxyVIHt3C2HEERTjPnjsDW4RyJIOXz6tHViOH0EG2mFnyXU6?=
 =?us-ascii?Q?oD3UNy3IUm7BGNOLC5NweAz3hCByGlWgxXu5PLswN6Mu39xccoSq4GJRJ4TN?=
 =?us-ascii?Q?yjIonoNYYDTiSb5kFjM23zSpYdR9PFl2sdCAARj91iU7ZTWhyT7bEU5s1VvG?=
 =?us-ascii?Q?QElHQkklP1iNl287LICC9bOMOiVOVAViZCzH5YY75r8Xkp5T+KJoRT0/efZI?=
 =?us-ascii?Q?JHTKhY+XKgJRHH5x4S3gkEwz2AJ4TXJm2hzCHRWYi7w1xosrCcspT3TqY54I?=
 =?us-ascii?Q?Nm6NJu5UhthcK7rVMGQWcPvEs304IceRQlVMstBl4EZFQr9IXHX21eqiG4FU?=
 =?us-ascii?Q?KJ9j0Ipa+tDJNdvlGhJT8HFWO9afJ3E52AkdyR58?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ym2YSHKB4YfS6c9igGzl4xoUuHoVYZL28wvKpbP4GVYLu2lX4NqkMvXThGfJhMvUVK1PzX32D4/OrpncpcJHfNZHmi3w/PM3NqSl2hgf+ec7YEZ7QISycUIgSrdfe39si9yn9jtNFC5vhpREmAyFua9tkeQzGkfERBONg2/ErvhzhzhP07AdkG6UWYlRzSdDW4Ay9uN9+EBnEFAk2qs0hXD2AvpFpofYnRM1Z0S+rKXbDm2BQ8pHECI0I6uCiuPJimvWma4T9ysJ/aufx3rmrPsMczo8wnz1/SejleTBMDZ4VR0Ml1wFmKu4Bx+a9H873RvHfC9casO+B7nnarLeXfTxwGVjLK/qFgmsom95Rg96g/mAFccAkNFl898a1ipHHUQyq911cC3M1uHfU+ya2Yf+Ejv36yt/DS30cj3EtmzLjfMauWl8HHAH1HbB97gAMiyh9oiF72of+WetFIuX/WvrKpi+VMA5YkYZs67TYE2+jQ9bLPB5SSXvMlZ4JUXEU1kqcYm62FToKa5IHU5sGzxvUZcO13dxLml5gc7c4VAdVo/SXXVJhRqt353BGwsB4tadv0o/6lHvSYVsgxt1EroQ6OLmodELiiSgzB/xFSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1022068-521e-4d9a-8835-08dddba0bdf2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 02:09:18.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MXuZQTWC+XAqlrso4ePiSLUG/s8BjfWUODt7Wjj+7EW6DXNTATIqG7JaudPpdk0Y7gEpOtrju3jrRdWpMmcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508150015
X-Proofpoint-ORIG-GUID: eVgiomMThr1hYGczKNYoJh0RZTMEpind
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689e96d2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=yPCof4ZbAAAA:8
 a=uSKKOXsb4za4dYUGw1oA:9 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: eVgiomMThr1hYGczKNYoJh0RZTMEpind
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE1MDAxNSBTYWx0ZWRfX+eKuujy4zQdj
 FK+bgYKk+aIPDUQdsiU6TV9Gp0FKSyyl0meuRqZG9nshWckLwPSTaZpKYzCouzV+Iw7tWpVhqu6
 HA2S9yvQUi65DIgVhbJvI2cIcY0qtxgYvvTqbkAz0noNMMK9LurvVbGYS7NSzu8PxKblyI+pkWO
 ZcFmt+UE0ek0tnplU9P3MXr+2ptfBE/oEDCZZ9q68CW69CwczI6RmcU227V78PrK0UU0Dv5Keu8
 GWQ0Y23MoDiF7YUfC8MiXlZXb/ZIt413UB959KLmN/e6t8h/lsxwPfE9LPU5Ru0MadLm5uT/Pzr
 1rMCu4Y/oE1FXZqUrKAOXlPAVAcSegM8tJpbe+AhyZ3imL6PbEGSpxcQ3YyBl2kzW61TppQhujN
 H8O5I2kXBHr9KRfMb+L3ObTtNm2a0TfIVFVe7u3CTymAe3OE3F1vakHAd7li+y+8pkkWH5ud

* Andrew Morton <akpm@linux-foundation.org> [250814 21:02]:
> On Thu, 14 Aug 2025 13:40:03 +0100 Pedro Falcato <pfalcato@suse.de> wrote:
> 
> > On Thu, Aug 14, 2025 at 07:49:27AM +0100, Lorenzo Stoakes wrote:
> > > From: Pedro Falcato <pfalcato@suse.de>
> > > 
> > > liburcu doesn't have kfree_rcu (or anything similar). Despite that, we can
> > > hack around it in a trivial fashion, by adding a wrapper.
> > > 
> > > This wrapper only works for maple_nodes, and not anything else (due to us
> > > not being able to know rcu_head offsets in any way), and thus we take
> > > advantage of the type checking to avoid future silent breakage.
> > > 
> > > This fixes the build for the VMA userland tests.
> > > 
> > > Additionally remove the existing implementation in maple.c, and have
> > > maple.c include the maple-shared.c header.
> > > 
> > > Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > Tested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > > 
> > > Andrew - please attribute this as Pedro's patch (Pedro - please mail to
> > > confirm), as this is simply an updated version of [0], pulled out to fix the
> > > VMA tests which remain broken.
> > >
> > 
> > ACK, this is fine. The future of the series is still unclear, so if this fixes
> > the build then all good from my end :)
> 
> Well, can we have this as a standalone thing, rather than as a
> modification to a patch whose future is uncertain?
> 
> Then we can just drop "testing/radix-tree/maple: hack around kfree_rcu
> not existing", yes?
> 
> Some expansion of "fixes the build for the VMA userland tests" would be
> helpful.

Ah, this is somewhat messy.

Pedro removed unnecessary rcu calls with the newer slab reality as you
can directly call kfree instead of specifying the kmem_cache.

But the patch is partially already in Vlastimil's sheaves work and we'd
like his work to go through his branch, so the future of this particular
patch is a bit messy.

Maybe we should just drop the related patches that caused the issue from
the mm-new branch?  That way we don't need a fix at all.

And when Vlastimil is around, we can get him to pick up the set
including the fix.

Doing things this way will allow Vlastimil the avoid conflicts on
rebase, and restore the userspace testing in mm-new.

Does that make sense to everyone?

Thanks,
Liam

