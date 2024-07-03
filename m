Return-Path: <linux-fsdevel+bounces-23016-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B170B925864
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 12:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0F88B2305C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 10:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F8D15B54E;
	Wed,  3 Jul 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WJIPu6FI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wJiEcpxE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C88155A39;
	Wed,  3 Jul 2024 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002255; cv=fail; b=F6RlgVhi3Ps46XT7uYScWMdzt4BV/7hSvNm/8k7Hj6oV5E33RaXrqn/RMiLxGIvDEJTlyC5W33F8vxkL2Vb9VuIf6Su0P+/OdqXG8t+nz9+IyhLNklwFA2y0223oYDXR3SYtmS6TsRWE/hv1Ptfo4x9q5Wb8ksWQ5PP9GFfQlCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002255; c=relaxed/simple;
	bh=HTrTvoPJIuoU5/9skxKUvlYFbFtZZBfLiRIUOJQqBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dHb1Z/E69dHi17UEDRHesZlK2lRqmKTQiXcG4bHIzV5PyIQJ/FzkUhAmY/ym/fSvkQosrat9nK8RLXXa7VNMhMVyZwm0zJ5i/FRIoQJPb2JaFH+3xr7E3c0YWtE4XwZLj1n2QC7aIfmzLqQISwyumHshMlv/gD4rmdCdAkrMdoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WJIPu6FI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wJiEcpxE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638O7a3012491;
	Wed, 3 Jul 2024 10:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=v7sFsizZCd+VN2f
	0rFfL0BDwOJkc+L74Aec6GJu3J+k=; b=WJIPu6FIHho1sqYglE7rpMyfN/Y29is
	ZQBwj2LUtX4ezVI/JKs0MJ3+4G+ePRehmbFEuusrZKLXny5UBZXtIJ4T60FQDJXH
	H9/WpS1a6ddpIuHc5kLKpshlj1C5WON0/soS13KymUlizabTRCOOlDIw7D6Iy0AM
	rg7n0rstkPuXuWtDEM6tqlSw8j9mjl4/J1ia7oivMot+mzNZsMjae/bc/wyvbmcB
	5QKS4Ikj1xCPmeXe+8NckKjAdepiIYD9l9SilCuNlNKwcD5fVlinUmMicx4B4isU
	Cqo3ikJR+9EuXrP06SCLS83ILdc3uZN1LO4EBFzrF0hKNdSqlOA4RPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402922yt81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:23:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463ANXNT021487;
	Wed, 3 Jul 2024 10:23:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qf2p6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 10:23:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4FMtv1o51dcNnDgokFHWnlBXsrytbJHiJTSi+oZWUPcPgPPCRuZ5zWIdRfyqf/DpB4/TrL77wJZzO5vSEKG647dmwn4wBcqlJgjx8teNIuMhptnSiKlT8hib/qxmnszm+9wdJIRFB5rdX+/488B8gMXgmsrVSgeKrahIX0Wj8L3TnDGvOaAvPJg03Y9uutaiQJtLSnT//cyhO4gLF0qv2bJv5HrPurcN9FIENPlFIPeoqf3ibdDkHbZIGMehit7427T/ah+vp+EUTLpYWEZ99Cxg6p+07XtT8vNmevPFPQvvPdqVeq4pQRanOVmBhEX+pFjmFVMnHllGT/3gxaj0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7sFsizZCd+VN2f0rFfL0BDwOJkc+L74Aec6GJu3J+k=;
 b=Jgmi3DfHgxvrbecjEwdDE/mWz5c/01xlxfQxotCBoJf0Efplngjw2OkkamBmKMmCGMwZhN1K5gKUF9B0jXbC5VjSENzBK2YGdPkVdUsoaMBEnqiPs8QgIeNEZATk3v11dAsj4mWd4ulPDgjGbwdVb1r7Ubo+FmzBNw5LGnP+DxO/zHiuSmMphVixqKYKUbGTrrSBww34oCVrageLi7oIVKDjlKS/mjlzlKTI+F5zKgJcmOUx1JK6FWNovSDRfJ1RrNtTheQ2y0aWftKQhQzQLOCF1J1bdZbbN3bKVHaHAnGy/S8Wt8kPwFZVYmUxLJsEgKvxbieTg46gltQCF8HrGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7sFsizZCd+VN2f0rFfL0BDwOJkc+L74Aec6GJu3J+k=;
 b=wJiEcpxE1gQBydLmv9BLmZkw7N68WzL6P8QvO833FqbFKtDVRuPKmZYHklcaY0s6+wgiou27+LCFK/m9zHsOrPpH7JXmbDlAtbz7L57rpkHMbZQEIYmNc/M2VqSZf3tkDCf15e75zW/A6ueZu5YNmEWO8PYRqKhIX8To/n7rqUI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5180.namprd10.prod.outlook.com (2603:10b6:610:db::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Wed, 3 Jul
 2024 10:23:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 10:23:56 +0000
Date: Wed, 3 Jul 2024 11:23:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH v2 7/7] tools: add skeleton code for userland testing
 of VMA logic
Message-ID: <633aa356-b905-483e-b6c3-866f9ea4a894@lucifer.local>
References: <73c7a094524bdb21e25d8c436c9059820ad82cb5.1719584707.git.lstoakes@gmail.com>
 <20240702232516.78977-1-sj@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702232516.78977-1-sj@kernel.org>
X-ClientProxiedBy: LO0P265CA0003.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5180:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ea5a1a-fc2e-48d3-1bb4-08dc9b4a3e7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2y7ugtVpv/umM33ZYzh2WB4VfsbQV3reQTTG5RFA058C0+HvoKF5ROUbzcMJ?=
 =?us-ascii?Q?GnOI1i4gTPoCVLSzeO/S9Lla8WHAm8q4o+KokipOeE576GffP/zKQizU4HRB?=
 =?us-ascii?Q?jFchHNgqwo5PQe3PKyCQcOdsXG/xfOf0vb6Pa5kP1VyhsU79Ynot8xC5vCKp?=
 =?us-ascii?Q?Df2T/lo652E6MAuGUEeDQq4/o5VRiGeVs6SBqV0pDpBN911i28CrKQHqJZ5o?=
 =?us-ascii?Q?xqBaK+1AI08WU6wdNrczbAq1bYrfJhW2rtS1FlDBN6DxtKwDTwu7N/UVdXhp?=
 =?us-ascii?Q?HnlSlhH4YD5TNCgAI6O4ornw1tU0xl7zCGtzUH1/B8aR/HvNJuPgKXNhVAop?=
 =?us-ascii?Q?ocvP90Vol+o1pEUYi6WQ0sOr9asTQCte3kLlPACYZT3N1X3lyGTD6eK9gY73?=
 =?us-ascii?Q?Q9hAExLJ8yztKU9j7dZj83YjTt3WCnmAnvgUJd4VVqfuJYF3MwN0k3J3pEGf?=
 =?us-ascii?Q?QQ82C5jp0RUDLTeKZUhJJ/oU1ZrTJo5D4n5QWKWRGU8rLqcQr4QyeIBcbUCQ?=
 =?us-ascii?Q?NGri6h5HiXrb4/VtMlMBSrVLOem+ArlSM0l4flLNR0CSNn+WChK2bR7hi8QV?=
 =?us-ascii?Q?T6oUR9TiGn98b1RLyHhhc40BMHgvvOj3gnCufWSHnUJrgXtjHvqlyKaj7Lst?=
 =?us-ascii?Q?qYoUKx312ppQzGy+ELDTDOZTQOAf6Qs6gjdnMgETAoScZWtCu5APtvppXAeB?=
 =?us-ascii?Q?kg6qAJ+w5c8JYlOJOjeQLM321y9jQH2JeFSKoOTnPqI3oXfPvufBH3nyuR83?=
 =?us-ascii?Q?kcbo/UYkWsz1ADvKRakaT44KnCoTmwtkjUgaLJkhyj75EWyztTg6xdEgms8B?=
 =?us-ascii?Q?SWH7qdlicvmQkqTgHPy4O+EXYAMeIl9k+tM5TtAw0dm4l6H/Jq0Jjf+m7BUo?=
 =?us-ascii?Q?ngHYFTaIDp3M8wNF6GWd/KflTac/oX6Jo7rjTLX8rSKGAP8e39ezSQRnoDLn?=
 =?us-ascii?Q?7K6Ks3jfTF7olCGKvt5NaUc2z/79MwNvKFHH2U/55+LRppiNm9rBRu/2qaOk?=
 =?us-ascii?Q?33y9IMfIgPFxpHUtD2+eXx7L1Y3n3DthCaD/b/SBJn/OfVhlj98/qL8kXXSY?=
 =?us-ascii?Q?mUOr/72sgMce+a67fCGTRmYM/isTkkikMoDaAWXBOJJzOh7Ia6i8LBSaEYXg?=
 =?us-ascii?Q?VsozTtiKQmXD3VaWvVUZPuW/NEFLnDTBexgvXC/R3jAtv/nrx90kP+5UvoJ6?=
 =?us-ascii?Q?wRy6IEpF91VnurTA3y5ZmVrCL7X6QlwS2VCULPUhL8/CHvWbJ4ufyd8hGZOK?=
 =?us-ascii?Q?uwlcW00aiECA08+TV0YZ/DMIE/yb6nId75oJKgAuVspY7D6Fsb4mXnj1zIZE?=
 =?us-ascii?Q?9WUrjvm3VuxRMDaOqL8UZbbopCfA5sUhoe1RCJw0orHcnA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vTO9WWEkSqtiKx0nZ4ppQu8Rv9NZg7pMrSgbRcdJtN3jbIX9uTo09Dd4ewpz?=
 =?us-ascii?Q?vRIzp/yFcXkZlwgeOKsC1L9b9SFo7KgciucmbZLnB7BLAK/kiFnj3M7h5ygg?=
 =?us-ascii?Q?HhH1662zvbBLnUeMs6uzVQCOI7HKKCj1uyITp0AMvkaedMfgzW23PxeumHl8?=
 =?us-ascii?Q?H1a+Z1oVgcd+WR6xNAeK8pKxQc4LEWAlqKT+MUT3CZB8f9JV1e/AWr1oaQUQ?=
 =?us-ascii?Q?ojKlXBbnfW9a2+5GVsIiw0qatPyYRHijj8gV8HnOU2s6JqOCDdr6Tfd1a5QP?=
 =?us-ascii?Q?khusPZcskDrIVQziSQs7754ZZPwixS4F5fCwvoAkvDYRG8zETbn56xT258R6?=
 =?us-ascii?Q?VL2kMbQfmOIe84rVJFxHiWmqTIYmuBhV7aikn/Bs3iLzoxCXKDoa3/0z5UPx?=
 =?us-ascii?Q?EQLnUr/7WnRBrkK0jPsXzKG6I43RiYOZuQ2Ql0QG6us3EuJW5/18h6wyaFm6?=
 =?us-ascii?Q?l//Ye1P9uwyS97X+gW4IpWDNWOV0tRhWuI8m1b8/akReCAfeIlieFJ1Hy28B?=
 =?us-ascii?Q?yLP+Td6cCGxXvdief7FgR0BM73S7Zn3hxBH2U67Z4nowBP8M4es7/0ze0qtJ?=
 =?us-ascii?Q?CLtWVVIG1Yob2/OtMUf2L4okmKZavVHdzv7Kv691yOLYT2NbbmQvUt9Cz11e?=
 =?us-ascii?Q?IUVq7Wyku3RMW+QCXljjMXcFp2UIyZNF83q3yClz9UXRPa+nxiy/UNM3U1o1?=
 =?us-ascii?Q?lUjO5up9OUf2QYF1mBYFNrRBKLJeUfohZX3uEWnRxuOzrZEZ2up7hdryma6b?=
 =?us-ascii?Q?v8sVc6/NURBG9n8g26/sUWM5ubV8618zx6y6i9cOtrsLfRbyotrrfpFIlY1t?=
 =?us-ascii?Q?nczQTO2IFlmYOG/zkFajHyr++O467j+7h/GEEUU7NsG3rlMpBg0HD7Jl1vFy?=
 =?us-ascii?Q?jEHIaR2bXWijm9b9s86W5AiGRtqrue4uMrg9n7Ebtz/008lxaFfGQagCBIjL?=
 =?us-ascii?Q?/DquT5/VuMM9mioP/MA9J0PUba+p0ZZOc1w80akhFZatnJLjLexx3pjwakQr?=
 =?us-ascii?Q?Jppr9qtpeXJv4HKPfP7HdpUj7nRW5vvo5qtAXBNMkVaHcg6N6s+lmhaZ+fKN?=
 =?us-ascii?Q?kcrs9I3t213B0k5csLBhecBVHDJomAO6PKKwe4135SEzSY5upQOHyeUiU/kC?=
 =?us-ascii?Q?LlekOw9iZ5Wqg3v5fSo2QjYIRv7UNtlQ4CpVlB59VUFI17zea58A6A48r/02?=
 =?us-ascii?Q?fGE7o6XZeMz1DOMG+2d2W8BWTMM41WmR9KbVAmQuIq/e9VhjmSUhfJ3pjCYp?=
 =?us-ascii?Q?MGdAlkrn/ajN9WHkxCqyiS5RMWy/5cxF5NOrVlJKuXavsUY2fdG/P51h0uBw?=
 =?us-ascii?Q?PjwHacqugW2HNMHB8ErCsa0lCTiCj3EnBOyhMkoySdbCPnUaaodhSiKnU9O6?=
 =?us-ascii?Q?bv8lzttUNbuONPELFq/OyCZYN3ybBMrN1+82U8jwdUWCRAa4FhsTYHumowyq?=
 =?us-ascii?Q?3LXZwf1ti+iX+kQhVwW6qknkvtzHfqFmgOG/aVkfgRyFeZXlWQgzYbUvsgoP?=
 =?us-ascii?Q?CNTZb7vftW7jIupyGpWtQdjphxPXuB47JjDy+CFum+FKAithG5gLkx/QEGZf?=
 =?us-ascii?Q?sSwb+v9q4p60T/wN/aR4eXE7/O4VEd5DXq084DzuKbCGegLk3wBMyxbbuwZ5?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Ey+ACzTgLZgfZwaXXTDu7k6AR7OvL/Mlo7VTw0QzyLjmUk/ETRMkZzxf0NvrKgD0zUItRPXsMR/B9BNxwTcJh8fotoAs+KiGIedAzBnW13WPnTj/VDUbk+0jK9o27HvdjBGMC1AtRePbkuMBHO5w+C8t55b8tzNSU0QPl8dVWkVkVsh8xvVdNciCT3N2fpLYENhZCsDXsJz3P3z+mfqmw7C5O4vzG1vnSTH0wiJFzTUVyZXxrBK/XqXYGA9FkG96KGeRgm097BuDKub1Soh5v0LVfpLg57oGn9F6haxV9JjvCTXr/kfbB1xUUgiLV4Wo6JRFyWPJMd7zPPo5RjEUktuh1iJMMiCK1HYoTgFcVYToh3Qpowb4gd+d8tBauwxw1MGjzgABvFfxUn5QQpjxbc/Sx2rmyPu/cJJXJqjz9C/yGce3dwVlzEtBoht02H7X2Qx46LeIO1223hFMrYdvCB4BAFixG2a0Ikk2kaQflMfwcmeLjyPiime5W+i+lR+NrmtCCM1GmKw8t9l7BEHvJlJE2EvgrjD3HDZmqYg2Pa/4/sFgK1jZyaY6rOlUGdGUT6dRfXTe/tyyiv/gLFoPrLGuFu9NsqSrLxNBLyQysJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ea5a1a-fc2e-48d3-1bb4-08dc9b4a3e7d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:23:56.0340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzMd3M9y7EeudkpihzEplYqJCtLSkSMiD/3wiqEUzLJVHCqTlg/4imTBWt/Fb9thtdpb9caorbe8q3MI9PQMfUAk4Ub5cdJBqP34nEhXKmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_06,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=703 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407030077
X-Proofpoint-GUID: -Fn3yeD78huVjlVoYMwYYKHNbTX2SfBe
X-Proofpoint-ORIG-GUID: -Fn3yeD78huVjlVoYMwYYKHNbTX2SfBe

On Tue, Jul 02, 2024 at 04:25:16PM GMT, SeongJae Park wrote:
> Hi Lorenzo,
>
> On Fri, 28 Jun 2024 15:35:28 +0100 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
>
> > Establish a new userland VMA unit testing implementation under
> > tools/testing which utilises existing logic providing maple tree support in
> > userland utilising the now-shared code previously exclusive to radix tree
> > testing.
> >
> > This provides fundamental VMA operations whose API is defined in mm/vma.h,
> > while stubbing out superfluous functionality.
> >
> > This exists as a proof-of-concept, with the test implementation functional
> > and sufficient to allow userland compilation of vma.c, but containing only
> > cursory tests to demonstrate basic functionality.
> >
> > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> > ---
> >  MAINTAINERS                            |   1 +
> >  include/linux/atomic.h                 |   2 +-
> >  include/linux/mmzone.h                 |   3 +-
> >  tools/testing/vma/.gitignore           |   6 +
> >  tools/testing/vma/Makefile             |  15 +
> >  tools/testing/vma/errors.txt           |   0
> >  tools/testing/vma/generated/autoconf.h |   2 +
> >  tools/testing/vma/linux/atomic.h       |  12 +
> >  tools/testing/vma/linux/mmzone.h       |  38 ++
> >  tools/testing/vma/vma.c                | 207 ++++++
> >  tools/testing/vma/vma_internal.h       | 882 +++++++++++++++++++++++++
> >  11 files changed, 1166 insertions(+), 2 deletions(-)
> >  create mode 100644 tools/testing/vma/.gitignore
> >  create mode 100644 tools/testing/vma/Makefile
> >  create mode 100644 tools/testing/vma/errors.txt
> >  create mode 100644 tools/testing/vma/generated/autoconf.h
> >  create mode 100644 tools/testing/vma/linux/atomic.h
> >  create mode 100644 tools/testing/vma/linux/mmzone.h
> >  create mode 100644 tools/testing/vma/vma.c
> >  create mode 100644 tools/testing/vma/vma_internal.h
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0847cb5903ab..410062bd8e21 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23983,6 +23983,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> >  F:	mm/vma.c
> >  F:	mm/vma.h
> >  F:	mm/vma_internal.h
> > +F:	tools/testing/vma
>
> According to the description of 'F:' section description at the beginning of
> this file (quoting below), I think adding a trailing slash to the above line
> would be nice?
>
>         F: *Files* and directories wildcard patterns.
>            A trailing slash includes all files and subdirectory files.
>            F:   drivers/net/    all files in and below drivers/net
>
>

Ack will update.

> Thanks,
> SJ
>
> [...]

