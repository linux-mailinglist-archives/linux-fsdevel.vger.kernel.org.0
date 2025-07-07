Return-Path: <linux-fsdevel+bounces-54053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB5BAFAAFD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 07:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942F2189D439
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7DE274FD8;
	Mon,  7 Jul 2025 05:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SlGSCWJ7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mN2oXevz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE3A27146F;
	Mon,  7 Jul 2025 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751866214; cv=fail; b=bgnvUOiBtC75GuUa6cOKiITD6jXi5IxLHsy9IAmueke8pi2IG/Acb0k8doq4d6y3PKLIafJWl+ZIiiInPqnWhao0dWdS7K9jFlsDb7iaFbgVwvnGkc4idrmDLXqlZR/hdBkCVwO55Z9UdW5fIeEtE4kDl8WnRaz+0d3wm8yOJzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751866214; c=relaxed/simple;
	bh=GUXkFzPycSKBDyO/GmzJNLG+hBu+XN6WYaek4BENKUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g33uPZHzfUaMvkO+b7M8/B65zn/63v6ZZsJtbBRpALnF/zzn/1ytFlI877/EVIDqxsZdzNvgn0/Cb+/Hh0axVKKdi/kLLSy9i+O7B1uWJeFMkh8azHaGpT+w05cDsXSUhNaBRtZ9049lDw4iPx+4OhKD5vtWujAMjvu7GTKZuII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SlGSCWJ7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mN2oXevz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 566LZ2AV021433;
	Mon, 7 Jul 2025 05:29:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j0/J+S/C3rX2fQKgA5kfxt8UpyRZb7Fu4jzv2Q/Csic=; b=
	SlGSCWJ7Q2BcZS/fHqUUfac27H14e9w3oPJBljCvnkDTpOeBQi3/smKrqTOnNR3p
	mOFLvmFeeYUh1MdKuokdHws6rZV62QCURJr0TSuvUas+iFaUXrI9sromGTNszvH3
	Wmc2TVcmPt//DEKiLsQfR8EbeLiaG557lasPkL8JMZi8w01HRg9ET1+nXDS5glpD
	LoWgIsz72Ud5ABubduwBKZTvg56UZEai7x0FkIt4bBHBFga8YJtpY7o3JgHWNuRM
	ZzGzpyQIKr7cq2Ut8/q8nRIW6TQkbfgflIUzKbH1SxgofZAnuOi4HV0fOWXL8JHi
	KP5RGdGtPR8Z/fNXE/Ir+Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ptyfj0vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5672PVBu024285;
	Mon, 7 Jul 2025 05:29:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg82hd8-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 05:29:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gzhIqqDe7kmt8o+LlRgKyhwG0RltmdLbp2IGTnwxZo6is3O8pzVbCC26Abn1Cz3YQxm1qlmgPb/7Ar+p0dzJBWGAM5J5aqKgcEBBdu2/NhQWu8jRGbzQniznwH380lKkI2ZpBicOXQTys7X6a5Ckgpj9Z68tUMuM3q8gA/7ragXrAQV88aAv+78Q+0CMiBLiAM6BkxZg5mTosUF+GBG+H95IkJfNg2zGH3CZ9R6fiqJtjjr96kx9eH6NFEfzLw7ZLwruQ6nfBDxPvs7oEeIlQwH+OsUbAWXMygtXwL5cgCD+npvANTilrG5O/d/zoxxZsOKjfcZ6Kgxwiznrjy1B6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0/J+S/C3rX2fQKgA5kfxt8UpyRZb7Fu4jzv2Q/Csic=;
 b=yHMCRo0pgeRxaidT7oEgpKOKQGrblkuBPcl/89AxHphsWHqggJHTsbcMYUFFiSMluEajPVsYx1UkC0F4rmi/JABVa4hRy4QEY8FvqbTzMP83E0/rfdrd6IyjzxErenlk0kAxd8/J2xHbXJ7lnr0S8YGnoXM8KwshjnFo1/CDLZB6jkljXWHbIvuKD1Y12txlbRclmSc90+wxRagpJfYwlFpYG7ZZdw+CGM+OEwIl9+Ap8bpYyal5eUlxBwORDs76eKRL+z5km/WAw+RMJRuXjvm9QpIG56GG1k9Y3uhcPj03kNrcxZMo9bPebBxFOzAc+RFhDluOXVFzMCjND6iDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0/J+S/C3rX2fQKgA5kfxt8UpyRZb7Fu4jzv2Q/Csic=;
 b=mN2oXevzzYyto7Drk6+wu9ac0aJo2yGtmazcVmDF+oCV2SVYy/Ze4gpk9lNPP7oFXBZKgjiBI5gR5zkBJ22LAqakmd8wgPjaR4zFvQ6B5pZ7lTT14mgbTtF/EKMX6rd9Ofc4v+e5FlyQE5GnM9YREe6JzlnaoZoi6owoSLmPkI8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF00080FB4B.namprd10.prod.outlook.com (2603:10b6:f:fc00::c04) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 05:28:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 05:28:53 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 09/10] mm/mremap: permit mremap() move of multiple VMAs
Date: Mon,  7 Jul 2025 06:27:52 +0100
Message-ID: <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0375.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF00080FB4B:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ba9a5ad-afff-4726-6f89-08ddbd172954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9a7ZcAxchCLIlO1PK0Qxk4/ZulnHEMyYtWaI/0KgRokxrPXSzc/c6BcYrKs?=
 =?us-ascii?Q?+CpVIkGGS9zlpRbCKChUaIXGQhYrBMpyb5KZUgA6PXQjX3qnYISQL14CoICL?=
 =?us-ascii?Q?v/bPqhOsHJxUnszqRnpKK5AJCu+PIDM9aqSxHnWaUBNJA2sghpc8aGOrjUxR?=
 =?us-ascii?Q?7cI8/qty0sAqq3Jc6sDInQqSOhDOBnAKGPE5o9nUdun2/rsub5Lv5TY/5eeH?=
 =?us-ascii?Q?+g5NVvkI+DpW+b+E4BJh3gDMbIXizEZLuEdL7hwhVRu1ogPXnZCZcamgQ4Si?=
 =?us-ascii?Q?nPBgTIKZCzvLjI2+9cfsNqYqswKNwQI3EP+YEwLfUlXzOzjQVIRT3Dvn7Jhv?=
 =?us-ascii?Q?VsXIuGFdD8S++UhCx8SX2jN22IGC6U3W8GyxgO1gn+J1otcutMoGmBySaTV/?=
 =?us-ascii?Q?VbbSraiKGq/6Ej8iCnZWKR6rgnRrlB4BeyA96S1Jv7AZHnm7v5Q4sfPfd79a?=
 =?us-ascii?Q?i+Jj/htqSaGKz2Or+kBJFBSOjBcTtKqDqnEw20bvmu8KlU0Wdbk8X8b+a6G9?=
 =?us-ascii?Q?E7RiLdpysgjFOD2TUPNcHDsKP++2SpRu6L25XodBaDWEpl0SNwQW1zRqXg1L?=
 =?us-ascii?Q?EXy11pxvXB4m8w6Q1OWUIbTfxt02pcy1L9cCv4gkch0Tk3xkQGJfl1EHiw+R?=
 =?us-ascii?Q?RbMKGLEl71BC1BQUd1e4t/v4duGVHhPgUQAE5NmEUXtW6pLnC3J19k3wfRiT?=
 =?us-ascii?Q?QKsahjzKitrVV23gXwbrBrFdWLRvle52Qed5hIAaH2ukuRhp8YN5zz3dEUIB?=
 =?us-ascii?Q?1R2uTd0jj/m37HulRR25hjPouWrkhyDRNPgIi6bUB/kDJlaHJ9NWVgXRIC8c?=
 =?us-ascii?Q?ZWckdhXdTyKZYFS/XrYpih7RE5a2fr8hiAWvnZXgs2zZy8xrqDMpYUhmcfg+?=
 =?us-ascii?Q?wZ+8E87WRWwcT7tUIA2ivGoDwVbNSa1ggXod2fmqtbwoga3n+vCKmuV5pHoy?=
 =?us-ascii?Q?unJqPIkl+sa3OikVUAcD2H3jrM11ulcDYwka1siybQeOAGp64cWNmNs8XMNf?=
 =?us-ascii?Q?mU9IJKO0u61cpJCPKh0scpZts+JQUTvBBOsD3jR7LI5U8/hJBTYKH1r69cM9?=
 =?us-ascii?Q?6M4ZPRORTigGoQ7qASCSbLN9gQUBlKWz9BEOoQKrQcssOlkP6GH9rEjIR3Qm?=
 =?us-ascii?Q?tVY4K+jtIr46fyOdxBo+zvuuXHYGXh25J9ox7Eyi6EiGjZseDbuQldF/VTSI?=
 =?us-ascii?Q?N6Gd9g4O09Y5XlmCx3k608U+uxD0hhp2aJNjZodGl9q2JZXvsb5AJxVxJ+L2?=
 =?us-ascii?Q?aFh0z5roEsc2CTd2qCQ0mNi55TPyjTt/eg/T8uZuOoIDHFaQ1H/sAZoVUAkY?=
 =?us-ascii?Q?e/hIGopZsb7BRdMxkWttHW9QZ4kklXxYUnOPQZ3WlkKsNa06edkImrBZkmX0?=
 =?us-ascii?Q?w2CSXDUv6g8H9vHcolnw2lN4C9jDazpgFyBj8QrNQMNGMLKQLZQe9qGkfdUY?=
 =?us-ascii?Q?YNVwgWQ0zu0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gzw6yDoJaf9SEj5i6qGFftaIXl4gy4M24AMHxBa0Cm/YQ8IL5EiD25AG6n2a?=
 =?us-ascii?Q?Va11IwaS6J5QWNLGZCxF7K5RqVaUjsccLbmvHc9gAf1kFEEL4c78qz/4gYfE?=
 =?us-ascii?Q?0DWEK366cg7Z/WXu4KNhuwOmCRiDWko7CqPNVRiOXGcN9jpkw7aAk95DWzcx?=
 =?us-ascii?Q?OQ243GozWV0gfmuBfyxs5CBVsp6RgdEiqQRf96TUtE9GNbgv48pTfkip9Tu/?=
 =?us-ascii?Q?qsZlKG4PiZJQMhWqFQXUIqFf8QXcB/LpQ7ce9Y3Ttw8NNdDV99Itcd6wp+9W?=
 =?us-ascii?Q?eFo4Uqou2MOLyiepZYIjpiWvgJ5UAaaj9+LvhNmqNjx3YQ2+FMLlAIMZDM4N?=
 =?us-ascii?Q?m78h9Hy4KAYoADb1ZGcnTyPQa04OebzILxMOaQkbhnEYUweA8qBTCynh6l5a?=
 =?us-ascii?Q?wTVmLg8/tMo9CBYVAgUlm+gCTaM8wcjrKLruEfKGnTkLaf2iuGnUxuh8BUKl?=
 =?us-ascii?Q?zLQbPcZvu3dwDSmFFfFWj4snvshTVVcflayzW3GWr+xEyyA+ZQ/y29yTA4aH?=
 =?us-ascii?Q?VJEqh6GEUEVoO6sh2UuedFhL67HpDsOXxo0+6x9afytAbd/Y1g4Wc04XFF7E?=
 =?us-ascii?Q?bIxwAosG0v1RosU3aMs22/ND+IyfqrnzFpjliMJKamNA412IADioVxaA1wzw?=
 =?us-ascii?Q?7C4l0FDXTqfw8Pxp2O8vjf3DKchwjzi6NekPVwNsee/r2sb4VTPhMU1gPqD0?=
 =?us-ascii?Q?blh4NhjYH1xXFInsOUBWkQT/2wLFXviIcKAFJLMmK/Lzgjh6jeodZOa7FdOt?=
 =?us-ascii?Q?r3Z4qZttB1EHUMMW67YwWmv/cb50DCXbQL1ouPhQO42/YGuwnerzUWp11JNs?=
 =?us-ascii?Q?whVU6kIV7MWVknZyVucHaweRlwGantp3EDZ3Q9I2caJAN0+plK8D6MF7CfvI?=
 =?us-ascii?Q?nI6GNkmsfkQHIQrQ/NNoxzMOPy9RwCt8KD37s5/X5uqfeIuefmwr3X5ZmJGq?=
 =?us-ascii?Q?n9eT1gtPjHH8+KUtms5+0O7InjjAkePJIxijTkjhLop1YImAf2M+Ta1JjZkp?=
 =?us-ascii?Q?FdPf9AUxBtqx0FGENVBgNdid0ARQFrt/1K1BJlcgsqI5tgkiMnMgtnpGQPxz?=
 =?us-ascii?Q?/mplGod8uCmh2RilKuYkxpc6avCLU86XY2J9iF0uLM568ewOdYutRfPIUIai?=
 =?us-ascii?Q?uXbFJXIKllrQurJGqh0rawVByfclDpaHGBbhlqFW5ToOHv/sZ40z/4wkMXyQ?=
 =?us-ascii?Q?6h56iII10vWmsqlKhGdsXXPcMqT68mf5AdX8ITAo+ZL//49OqHSNACNZ92Wp?=
 =?us-ascii?Q?VjeFmPvBjqJMwSCayv05dVjm7TxRlZ36X7vaoZyCCvNBTiYvSx+oY1m7oNaX?=
 =?us-ascii?Q?cCErjU/mjalOpqlMho8m3NCAqgmSoz9/OJa8C+fdPoxlBhvxndb70RwNMLG8?=
 =?us-ascii?Q?aFQLT9yfUDaKuOa71K9m0wE158eru8i9B450nYwHB6B4j3B9PBV6vlgA8s+D?=
 =?us-ascii?Q?MrhD6kjsY32nEMZ3bNpB+GD7waWtgWdR0QpXDdPuagvSGi76mlFXZ+NL1k2g?=
 =?us-ascii?Q?ePYY7Lp0wtIec715sKB4z1L8tu8RosKUcS/sRD8+leHYpZTN69Xw+tbREV8e?=
 =?us-ascii?Q?wrYzaxBWLO//SX5FqvXzBnWhE++bfJREsES4+fZNd+LJ9UcLJUWzSmBYp1m1?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4ELXEb2N7jHrC4ETRAJGxcoiDJovLKj8LkzKQ0PX+Lvxu6HMsNPg2jnN7gNRhHBuI6PVz+Y1/7CVCr1yV9jTCUywfgWpYQzX2Un9fB5XsLAw+lX3JryEALF+gYsK5SNOEk28syfHJMzy+sjIl2YbffoOJLznTlQnaoVk122EYLTcVN4JyIYJq7EYP4yH895z3IkkYwUfVN7ZLChxQXfagb5LrjX+skUlbbgLVg27NYZRRXTXFMXE1wwRAQIeJOMvh6nKmkZNYiyLiY4/3+2PKzpv4Rljr6HoziZpFZPKZrXdYhkQTDeEqmSQyaz/PVTuVrzE5IrbFnlmk3QmwvMyDJD2SO+sFygr39rExfVjDmkmWkgDRGOTBb69ClzqPjJ/hOzQjE0m3JNJE3o/yHLdQTv6fDsnBAL4gvsiPvwaHTCqXplGW6+Y8qQScfe+C1zButCqf+UhDt9L4J0f0KM3o8rQJrfOY1pYVTQ/eGdF6PYig5tAAtT/5FpBhdrT1WXnhu0CW89QU4n1nz1rMmHkxAwksV21Prt4s3Ovd3DQXJ2pJN8/59BHoYwnupXeyEcn+T1adY9+BT7v9nsnc+2sDWWTirqHi5OBuBKHOg184/A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ba9a5ad-afff-4726-6f89-08ddbd172954
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 05:28:53.2377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAqoNIOTuI51ZKGuH1YYY/2cd8mZnigJ4HyGEdslX1cnZErHYD+/sxXfznWiqV1a7iZ0RecXS3teyNxC8IHDDhaJqehdWzh7sVlZ2f+XxRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF00080FB4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070030
X-Authority-Analysis: v=2.4 cv=NrbRc9dJ c=1 sm=1 tr=0 ts=686b5b1e b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=0r5cTyXUqGrpW3ZitcIA:9
X-Proofpoint-GUID: PV-Wt5TCpj7dc8Y50wbMdzppKaAxjIcc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDAyOSBTYWx0ZWRfXxlcHcufSU4YN VBb8DPdB66j4diR5AA0gcvIiSiuI27wi1Z1iQ9bFwNFpb4BCMF8883G/KzAdu0dLOQ0aWfFh7Z8 xua/Hc326Lu+N1xaFi5sVN9Sw4otDlO3xyNq55eRj3rJjAkmQlzVNBWy1g9BSPt44UzqPJfBAh4
 NNHRlGC1rMrJJO2X7LogauHf7Queq/kgfWqKf9OMsif9tsL7UmXDKFvXCQDTZSXW2JawDdWvd+L IiyxczL+EonlaxKOhN8gNtPMF4fq7WOdMWVdu8f3jnAW0wCp9TNV7WgFtm6jwMI+wErTEwOrigx HH5L92sg5QUj752bmB09zG2wkXLw5biMrC4nUzcH0DGCVyKOqxc8KRnHi0WA1SsCF/gls54YtIL
 4vl593QyqlnM06Drj73Z45lQIalo5oW9vbXipCDF406S1eIAm+PQglrnU049F63AMa2UcRox
X-Proofpoint-ORIG-GUID: PV-Wt5TCpj7dc8Y50wbMdzppKaAxjIcc

Historically we've made it a uAPI requirement that mremap() may only
operate on a single VMA at a time.

For instances where VMAs need to be resized, this makes sense, as it
becomes very difficult to determine what a user actually wants should they
indicate a desire to expand or shrink the size of multiple VMAs (truncate?
Adjust sizes individually? Some other strategy?).

However, in instances where a user is moving VMAs, it is restrictive to
disallow this.

This is especially the case when anonymous mapping remap may or may not be
mergeable depending on whether VMAs have or have not been faulted due to
anon_vma assignment and folio index alignment with vma->vm_pgoff.

Often this can result in surprising impact where a moved region is faulted,
then moved back and a user fails to observe a merge from otherwise
compatible, adjacent VMAs.

This change allows such cases to work without the user having to be
cognizant of whether a prior mremap() move or other VMA operations has
resulted in VMA fragmentation.

Having refactored mremap code to aggregate per-VMA and parameter checks, we
are now in a position to permit this kind of move.

We do so by detecting if this is a move-only operation up-front, and then
utilising a separate code path via remap_move() rather than the ordinary
single-VMA path.

There are two tasks that occur outside of the mmap write lock - userfaultfd
notification and population of unmapped regions of expanded VMAs should the
VMA be mlock()'d.

The latter doesn't apply, as this is logic for a move only and thus no
expansion can take place. In the former case, we explicitly disallow
multi-VMA operations on uffd-armed VMAs.

The mmap lock is never dropped in the move-only case, this only occurs on a
VMA shrink.

We take care to handle cases where a VMA merge has occurred, by resetting
the VMA iterator in such instances.

We needn't worry about self-merges, as in those cases we would, by
definition, not be spanning multiple VMAs. The overlapping range test is
performed on the whole range so specifically disallows this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/mremap.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 28e776cddc08..2e6005e1d22c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -69,6 +69,8 @@ struct vma_remap_struct {
 	enum mremap_type remap_type;	/* expand, shrink, etc. */
 	bool mmap_locked;		/* Is mm currently write-locked? */
 	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
+	bool multi_vma;			/* Is >1 VMA being moved? */
+	bool vma_reset;			/* Was the VMA merged/unmap occur? */
 };
 
 static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
@@ -1111,6 +1113,7 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
 
 	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
 	vrm->vma = NULL; /* Invalidated. */
+	vrm->vma_reset = true;
 	if (err) {
 		/* OOM: unable to split vma, just get accounts right */
 		vm_acct_memory(len >> PAGE_SHIFT);
@@ -1181,6 +1184,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
 
 	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
 			   &pmc.need_rmap_locks);
+	vrm->vma_reset = vma != vrm->vma;
 	if (!new_vma) {
 		vrm_uncharge(vrm);
 		*new_vma_ptr = NULL;
@@ -1325,6 +1329,7 @@ static unsigned long shrink_vma(struct vma_remap_struct *vrm,
 	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
 			    vrm->uf_unmap, drop_lock);
 	vrm->vma = NULL; /* Invalidated. */
+	vrm->vma_reset = true;
 	if (res)
 		return res;
 
@@ -1362,6 +1367,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
 				vrm->uf_unmap_early);
 		vrm->vma = NULL; /* Invalidated. */
+		vrm->vma_reset = true;
 		if (err)
 			return err;
 
@@ -1581,6 +1587,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
 	return false;
 }
 
+/* Does this remap ONLY move mappings? */
+static bool vrm_move_only(struct vma_remap_struct *vrm)
+{
+	if (!vrm_implies_new_addr(vrm))
+		return false;
+
+	if (vrm->old_len != vrm->new_len)
+		return false;
+
+	return true;
+}
+
 static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
@@ -1644,10 +1662,29 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
 		return -EINVAL;
 
-	/* We can't remap across vm area boundaries */
+	/*
+	 * We can't remap across the end of VMAs, as another VMA may be
+	 * adjacent:
+	 *
+	 *       addr   vma->vm_end
+	 *  |-----.----------|
+	 *  |     .          |
+	 *  |-----.----------|
+	 *        .<--------->xxx>
+	 *            old_len
+	 *
+	 * We also require that vma->vm_start <= addr < vma->vm_end.
+	 */
 	if (old_len > vma->vm_end - addr)
 		return -EFAULT;
 
+	/*
+	 * We can't support moving multiple uffd VMAs as notify requires mmap
+	 * lock to be dropped.
+	 */
+	if (vrm->multi_vma && userfaultfd_armed(vma))
+		return -EINVAL;
+
 	if (new_len <= old_len)
 		return 0;
 
@@ -1744,6 +1781,57 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static unsigned long remap_move(struct vma_remap_struct *vrm)
+{
+	struct vm_area_struct *vma;
+	unsigned long start = vrm->addr;
+	unsigned long end = vrm->addr + vrm->old_len;
+	unsigned long new_addr = vrm->new_addr;
+	unsigned long prev_addr = start;
+	VMA_ITERATOR(vmi, current->mm, start);
+
+	/*
+	 * When moving VMAs we allow for batched moves across multiple VMAs,
+	 * with all VMAs in the input range [addr, addr + old_len) being moved
+	 * (and split as necessary).
+	 */
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long addr = max(vma->vm_start, start);
+		unsigned long len = min(end, vma->vm_end) - addr;
+		unsigned long offset = addr - start;
+		unsigned long res;
+
+		/* Merged with self, move on. */
+		if (vrm->multi_vma && prev_addr == addr)
+			continue;
+
+		vrm->vma = vma;
+		vrm->addr = addr;
+		vrm->new_addr = new_addr + offset;
+		vrm->old_len = vrm->new_len = len;
+
+		res = check_prep_vma(vrm);
+		if (!res)
+			res = mremap_to(vrm);
+		if (IS_ERR_VALUE(res))
+			return res;
+
+		/* mmap lock is only dropped on shrink. */
+		VM_WARN_ON_ONCE(!vrm->mmap_locked);
+		/* This is a move, no expand should occur. */
+		VM_WARN_ON_ONCE(vrm->populate_expand);
+
+		if (vrm->vma_reset) {
+			vma_iter_reset(&vmi);
+			vrm->vma_reset = false;
+		}
+		vrm->multi_vma = true;
+		prev_addr = addr;
+	}
+
+	return new_addr;
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1761,13 +1849,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		return -EINTR;
 	vrm->mmap_locked = true;
 
-	vrm->vma = vma_lookup(current->mm, vrm->addr);
-	res = check_prep_vma(vrm);
-	if (res)
-		goto out;
+	if (vrm_move_only(vrm)) {
+		res = remap_move(vrm);
+	} else {
+		vrm->vma = vma_lookup(current->mm, vrm->addr);
+		res = check_prep_vma(vrm);
+		if (res)
+			goto out;
 
-	/* Actually execute mremap. */
-	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+		/* Actually execute mremap. */
+		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	}
 
 out:
 	failed = IS_ERR_VALUE(res);
-- 
2.50.0


