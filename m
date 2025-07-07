Return-Path: <linux-fsdevel+bounces-54144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56849AFB91F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45750425944
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 16:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0175C2367A9;
	Mon,  7 Jul 2025 16:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xqhzscb/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZLwkh/uB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12535235362;
	Mon,  7 Jul 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751907161; cv=fail; b=m9SkQCR6X75u+pONVT1OAnqTXeK0FQI9yJY+PTvN6EOb9AEcOnq5RhMHdfi8sNHMdBMwBmDSYtPPshlqo5zTbJcSIE68ToG7WYsBpzqj6H6lb1eb8XQBvDaDVD6OrCle+hBWDh7gFp4Rdvkqv0s1c9gbvKRm7ripjwpQVshtIBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751907161; c=relaxed/simple;
	bh=L3+T6tXv1ihr0zf7ZKD8tUV+VgMH1TClIBJ4sbPzsYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jc+eOx3n1O094f4klIV0eBYmcVwmMWLQ/7+f9TZK2G+GxKHypry+US4TpFWCgVHkcH3Gl34Lco+H3XOlJMMb229Kdf+2t58fZ2wjHSvbD0Dwj9w29OMIH6v4TxZ4yOFyj6lmG0teRa1ybSwLTZfTFGE653hUbSJYZrb5FtBsze4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xqhzscb/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZLwkh/uB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567GMNWm000540;
	Mon, 7 Jul 2025 16:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zXccfZl79l2SVqi+4C
	RwmrClr15MVTmj4/ImuILGYUk=; b=Xqhzscb/qtPRBjC5D/u6KydRqHvUV5FRQx
	/GL15n7g5KCIgm6jBbk204T4RHH/mwE0jtw+0FSZlII1E2q4joWXSNTTae3vnr3h
	2RW3WW9q0uuOnT29zixGliudEPLV8NXtpo4fliVcxcI9oTunXMZd/dt5ept8Rc0+
	JG3aMBWhI5Dp9BCtrp1J5kRteE6DUA4Zk1JPQ2y4fvxWoUh/Tcmu0uEraobTyRfJ
	xEt55wufUPDdzw/eSA6FOpS59mpTSoaoPOHGsBUp9OCxpjhHG+qhVqYMvwfs7zIJ
	wHNTzh6GY0hl405M4xLksABo6Kp/FiRtwwLIcn2ceFLRxbCxFm+Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rhpfg1qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 16:52:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567Gaf7r014260;
	Mon, 7 Jul 2025 16:52:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9872s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 16:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCQL3S8RH5lEd3TJ7CCznjhWJuqi3MJ9LcV+nxK4Pyk+woSUrndhmyEf1isj8ANj9po//IE6K9zio3Jip5xYiEmJN60SRDNlCXO3t6lbpXZVpUeoFMK6Vi46e+fuZS9K3c1YRfRG1dVGq5uLoQyN2txNmWPQofJylUZ9XJs6IBXi3HPcw6VVkgSpgqZ7E0dwEkLhc6obk2mE4iXm/1zSB34yh3+2A2WfRHDXeM4fKa+h+GWpsriYhItnLOqju/uNLAyklvONMForsqJW2qj9SkqXACmsiu5FH6ssh2xdmaXJpefiZntekX6nqN+ar0OCmnCLSxbISPOxKfFq/YlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zXccfZl79l2SVqi+4CRwmrClr15MVTmj4/ImuILGYUk=;
 b=ZpNcw2I+vFdKrxc+9y0iyVZYa1WjLiwOV0iIJ4mI/e+Dc8Y64ZvX/Jbi43iO+CMLhRyte46nc5b5zTbZ/0+wCdJTE1FDnbeMsMTqta9lAMZa/3Dis1AqRL/Ko3of+v1w9Vdh/h11xsfGnUWscFIE8KMzP7R8wVmicEOvYbxPZFXLCAoofBtfJ0Q1GZcN0IgninoLsp79WI6BPo0xpMyOtQYdhh6TgRbFk/HRGk9zdCAW7ZJtjo1tl10WDzkdIBHDBbMxEe1i8PVrzSbA2CMVVIrRnTk4sy+A/fqnCBw4i/ymQB6H8rHx2EjtJMGkb0GAd2v3qg2sz4HADOraoaXFQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXccfZl79l2SVqi+4CRwmrClr15MVTmj4/ImuILGYUk=;
 b=ZLwkh/uBqCL21qCk9ezF7EWScJujNU1DSwCTWWoWuY00Urxdc8E+TdxAjVCXwXgVrazxebvSkc7wUMHe/b/wP6sD3HwUERyd4f3h1AxpRfIMPKYXH+Gw2dq8DvYQY7Ezb1/OlYypOweTIZRuboSocfSMAprQaY99dFgq8fHim7Y=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ1PR10MB5929.namprd10.prod.outlook.com (2603:10b6:a03:48c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.22; Mon, 7 Jul
 2025 16:52:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 16:52:01 +0000
Date: Mon, 7 Jul 2025 17:51:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <f532558b-b19a-40ea-b594-94d1ba92188d@lucifer.local>
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-8-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060727.724817-8-surenb@google.com>
X-ClientProxiedBy: LO2P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::27) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ1PR10MB5929:EE_
X-MS-Office365-Filtering-Correlation-Id: 2815d3f9-7a3e-4ba5-8243-08ddbd76981b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MnAYXEWgzsroJ8SmZAUqeVcgL48Z5wKO9jrsw05pLlA5ahFYMQP/dWjz2TXT?=
 =?us-ascii?Q?5Vku3ntxaPkNwmg0oBpphIJYmZVVKbdxLd0pTkQndw68kwZujz/DPJ2D3+vm?=
 =?us-ascii?Q?+lQlAdQ+6QFgRgXCYlDUbTcg4tiGY79oAtPmXYiEzPyjrYFZ/VwvhdQwbMuR?=
 =?us-ascii?Q?di2f5YlDYvZL9LTnXX9uiw280bt96ejRDFufKjezKrQw736yscwptbqBPKIc?=
 =?us-ascii?Q?/wO9TQZHeF/o1XpZ9Od+fb9kQXLXc+72emX0wor3YvqA66w52/YrhtipCmWk?=
 =?us-ascii?Q?6FCpsRLm0+TF+ByHa/fsDsmjXsqmvDeE/O5IpOZ1KFOTBYNS/0+fShp21RL0?=
 =?us-ascii?Q?2mNdSJ73E4fpUsbm/AGIL1NfQWj+8N45BW1jGbSgenYrP+nWxZb+kkXc3Jps?=
 =?us-ascii?Q?D/D65uCNwvmuxihZZuER0A0HptEf1TtGJMEGpu6A+Tbdxe3fn3O53Dxj0dHS?=
 =?us-ascii?Q?m1fdUmdYB7SGch6lW1eOZaMDKnrHfbOV0AvRPmF3aIUPI8SEEbF0fvTiF0Sb?=
 =?us-ascii?Q?mThCjj+QJkNxjhC60ZAzRDTn58J9QHMPIXnsBgV3xwctixcMK754ARlNX1RV?=
 =?us-ascii?Q?4nSa38lri6F/x9c2O5s2iAK81s7MD4jND0I2Bn+uYGo2oE5eFxbeiiw0lXCr?=
 =?us-ascii?Q?bvAVe599irzeYQcVQD9mR7iOEJqWkUVlhSCXZTgV+gpOyxzKG0BzvhX6oYG6?=
 =?us-ascii?Q?gKB6pGjmJsANWrs2BVQ47rp3TEVgQLLr2umtHPVlcj8g8OuM7wdOSP9WLrcx?=
 =?us-ascii?Q?xdr9I7m04rNvo4gqobvr5Q//3FHLfH4oxKDnUCYfI+DASF9qOtQhPpsqioLg?=
 =?us-ascii?Q?IqC36r7O/Aaot9N79M1LS7Nae9ezepoNgs2nuj2aA3aeKatg1/UTsXR+iyjp?=
 =?us-ascii?Q?dv+iI6OKHcjm1zlE2Q7utseNyg+taSyXHeX/6IsLjSk1d/eoyCIhTcfaDIl6?=
 =?us-ascii?Q?YwNa2KYBD9YNs/+sIAGJh3L2k2jeqEjChTBvrhDHvNAiF1gx++EJkG4BV/ui?=
 =?us-ascii?Q?7i+nLG1WrRMhKqBJtkX6NRoX8Q+lBe8cc1xwJ6JOWf4ptm7e61lHmNHvSMZL?=
 =?us-ascii?Q?HGTf6SVdaOCtjvmhMe5xUSzW+UceuRCP/Wj18owBd9x/8bWY8skryhDgkaF7?=
 =?us-ascii?Q?j4ABheJ7LCdCi3qPM8nfqc3bGwe8WtSK3sjjeJdWyXFGfsQ2UO+kW3KIyUzc?=
 =?us-ascii?Q?B250J2S9CtuMQpoVzndMAfkHNogdffK9OmxrzEGWXSV1c+yEwut0/GsGXMUW?=
 =?us-ascii?Q?i7DOff+Z9jXIWCGSrNsvDrc5SFGlLsfgKu+B+EJhmbJMjOdySq+rumsguOol?=
 =?us-ascii?Q?pvoOFtH4LEIaCXAnsDD0Exi0XHuqbTGU5Q8eKurhCNGrpvs2AjKr/c+tXwng?=
 =?us-ascii?Q?pUr0r6ldIjY4m5HfP4d0NrtTr6L1IYc67EgOKIr5VADw3t8OQSOvnJwSn4e4?=
 =?us-ascii?Q?qvGgU6zJOq8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9wk2QX/LR10zXTv0JqyPkBzdG/+7B0RXRkmaLqVgbloJOYYtxvHsY1ZkRqso?=
 =?us-ascii?Q?6zwsUIss5DWSLLADGt+M1nY0JVWP03T1H3qFBciCs5oE0O7hxF2esarDahwb?=
 =?us-ascii?Q?tWOTZvQtaSHNqSsH8cQtzHlj+EcSyj15Qu8Isi1PRHDzs1Y39zIYwtqOy/Fi?=
 =?us-ascii?Q?zf1EQ+XVulslI1sOc4Gv/YR43q1UF/VyfmeeKyn98H7bcVDb2deNWiz2aQq8?=
 =?us-ascii?Q?iMU2gNs4oJvJRtvcpjjoKesm67fOu2oVVj/LCDcLXXbyEKsH8UnnBX8X+Q23?=
 =?us-ascii?Q?//MnCJ4MDPZEptUIRNj9wUyr2UW1kq7fl508+tu2YIXTzUJKlFWvUtmvmSfX?=
 =?us-ascii?Q?H07O8ir/7wLXSv0sh3eOqv7Y8B72w5pn9VxyjJEG9vud/OePg9iuMWW38vHG?=
 =?us-ascii?Q?KNit5yFtsFVW7eXXiallkfa6mGmUxwSlI0rbxgUbCJ6ktzbjKXnGGW1iCxKs?=
 =?us-ascii?Q?8IoIN7j/e2nx6d/XXG6RPrbH86ODLd8sKAAHXqMpDwr+dZPw8PgzNACvbmCl?=
 =?us-ascii?Q?crTE/lzsKs+fA8lBD6zEhCK7Vr7nFgQquWdEqmSXzhnK1PPVd7NqtiYSvfe0?=
 =?us-ascii?Q?vtoCoj6dpEEudAzoCJUSmsaCeMMWq3XO9eqEmh/CgcGT1egJ4OZvAIShIXhy?=
 =?us-ascii?Q?IhpZeXR5NeqMjJiEQzcJF/m84STuz7aDfYN9GkJqVBla6rGfj/Iv3ukFotr+?=
 =?us-ascii?Q?uHlitfWjMOMX23r1RZ/hgy6Xc94sA0+Nxv1Pv4Nuf7n3CtVQGwMqA6MJbNe7?=
 =?us-ascii?Q?M+9mM6Fp7NTuxznA5P8oBesh5ZJ+/K51k9TU0bAhueETgbui51EEAcQwDtwL?=
 =?us-ascii?Q?hPhK5ov4X0Cm7FNm9RiZYDJw/LFW/61aSU2PFhz6hnmfxCsMy8XENNbtdEOE?=
 =?us-ascii?Q?hcmM0bowvbQiHaBcyENwromy/9RhB8YG8kw4Nhl6pOcJDE/tJ6gmvZhomGCt?=
 =?us-ascii?Q?twl8yUNAHBHMsXiVk/XzEDqb/RfB2Jv3o9YxuyOLwmhMy+2W7sAayNrVca3b?=
 =?us-ascii?Q?hZq63Yi9Hw4BMau9tHKbfPqia7d8BFoJZopS3Gyney2y5wDEYumtNCIS1kLU?=
 =?us-ascii?Q?A17QjOkiLyuBApg/o3elxE8sxV1rs2S3BWcUkfcr3NTV6EQ5blWgi3e9+54X?=
 =?us-ascii?Q?qDmqlBZraVZgWQEMJ5DjcNxAvW7yMZvr5YGVE3YOFOU0Lt7k3mI13Q+xnO9y?=
 =?us-ascii?Q?vThqdBzJ/JbKSd6A/rwycjik1NiMAvkTNF/Ko7oBcHrE0C8yjbKUrK4fb36x?=
 =?us-ascii?Q?taYZnOTIW4Vg3eNkUYkcu7OKl9QwGJFxyBvUJtTvMF9D8pNiATcsFV5Xlviz?=
 =?us-ascii?Q?S7jUNoI1uLFqoQAl9E2LmPRwMgvynGgmtZ3ycDIP+Rej1D9YHdiE69MTsMxL?=
 =?us-ascii?Q?YUkAWGPPiUJPHAReDHZzyMV/J2n6T8/MCh0Cfn8XkTSrK3c7WMJDBIEi2/gl?=
 =?us-ascii?Q?ZJ0FPUEHd2eEI2XENYMeScvvhFAN7SEi1fRwo7FJnJHJ4isiGxFyS6GdxXZe?=
 =?us-ascii?Q?nOAPw/Xxj0vjJKb9Ih3JnO9q4FIggHLCprh5TVD+3i72xoqIMj7nFSMoC+/i?=
 =?us-ascii?Q?MsOv6g2kS/6+j3L/B1sXlchek21HcylPlaWxiEsdC6gbVvE6otz+TfVQod3C?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M3W6FvRlyDHeyfvqworQShppffdNQdDwvRlOcA8acsZDSucad6ITPVLt3bYBShIxWSmCre5xU5mUZJ9gZtC8tcuKRBzpx4EdlRRc+QTjoHnkDmxgTdOyqB5XemTiTsHMn+NdF1mbaEho6fGFoQ83hWE7nd12yPicey+bsGoUu093U8TJwntNjMts2FInO8kkBBK899EiRFn+NcJGNG6bJlkAEuqvGj6b5ab9+ZmSR/Eu480NVOAutH/CDCQbDG3s6/D3htlF75/7ha6ZfW5cjYzfDvYUDKatg/AC559uysm+cXO5XdE2nf5tycE15bCQdjdoMFfkulc5nUs5uNqvPEPBmCc3+rhzLtoG7H0D1XydbJNUgVSoJbh5GRW4g8HpBwI2aA393vZRMrMKc8cl3joCwUaiLXw8otXcZPLgoFKKshr4NRw5WFE7/56K8AtOY2jLICjmIXdFj7yA1JBO2dZjQvuJDgpvK8BpVmK+TM7eC4JyDMedeTeHHSKgW/iuSRrkfg3YcItmweAKPBzfI7gYoXq57Ta/q48rEqMgNHcU4n6t2gNVRhQ32Hb7K0kFPdACiUMDdwa9a9Rn4GhaGDSLVvvaUlPw8AuRJYscU8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2815d3f9-7a3e-4ba5-8243-08ddbd76981b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 16:52:01.4289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KaOCMbAr+7RlyZacR3IXvBo/ArDo/PM2PiofEv6hExg3Z8lKIy3kgQlPFgDguA2598wU/995TpOoqxwJ5JuPunqKIzD+scuVLU66n6rxExQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5929
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507070105
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEwNiBTYWx0ZWRfX2+ZSDKM/XwKL y3pa2XLDojuTEcLSDiWSIcvWV201HAUKaQbNHwvHnAlUBqOSBNqijinQ2Wy+48LQ5XRRA8zf7n4 ek1PzF45AxxrbFt9wAWa0iPYzhlGM3vVG6mNYVmJHyev/BSR+nf3KCfgNAxHnffjimgXDA3OIE1
 r1FCBEqUFptskspTUqsjtDq4baqeC2Xm5bMQ04CCXJ+8pZP2rlMrg8+vzbgWR3qp53G5kncFXDs IHnFViLB248X+8Dv/X4VnWHRUqHj70ngIpc2VLl94QXGII5+ClQvC8+yXp76FLAB8FGXtePhAvs PDDsipuxHpysULZmCtVkI2YqJ4SmiClGeCl6sanqdG87R0HuOue0w6nbnrVgyh3SLBPE4E1QOW1
 tc0W/UGbAG8sQMFifwroBXkamKJr6pPsEqmutcW3rRvUIFfbOiarr7z5cvt9nmZjPBCbFlIr
X-Proofpoint-GUID: Es5Zlrl0kcxy2BqnRITeRGpkAaXHfwTg
X-Proofpoint-ORIG-GUID: Es5Zlrl0kcxy2BqnRITeRGpkAaXHfwTg
X-Authority-Analysis: v=2.4 cv=etXfzppX c=1 sm=1 tr=0 ts=686bfb35 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=SXESB-UcASZSMqNc_ywA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13565

Sorry I know it's annoying, but some petty commit msg nits:

On Thu, Jul 03, 2025 at 11:07:25PM -0700, Suren Baghdasaryan wrote:
> With maple_tree supporting vma tree traversal under RCU and per-vma
> locks, /proc/pid/maps can be read while holding individual vma locks
> instead of locking the entire address space.
> Completely lockless approach (walking vma tree under RCU) would be quite

Completely lockless approach -> A completely lockless approach

> complex with the main issue being get_vma_name() using callbacks which
> might not work correctly with a stable vma copy, requiring original
> (unstable) vma - see special_mapping_name() for an example.

NIT: for an example -> for example

> When per-vma lock acquisition fails, we take the mmap_lock for reading,
> lock the vma, release the mmap_lock and continue. This fallback to mmap
> read lock guarantees the reader to make forward progress even during
> lock contention. This will interfere with the writer but for a very
> short time while we are acquiring the per-vma lock and only when there
> was contention on the vma reader is interested in. We shouldn't see a

Can we separate out into a new paragraph?

> repeated fallback to mmap read locks in practice, as this require a
> very unlikely series of lock contentions (for instance due to repeated
> vma split operations). However even if this did somehow happen, we would
> still progress.
> One case requiring special handling is when vma changes between the

when vma changes -> when a vma chnages

> time it was found and the time it got locked. A problematic case would
> be if vma got shrunk so that it's start moved higher in the address

vma -> a vma

it's start moved higher -> its vm_start moved higher

> space and a new vma was installed at the beginning:
>
> reader found:               |--------VMA A--------|
> VMA is modified:            |-VMA B-|----VMA A----|
> reader locks modified VMA A
> reader reports VMA A:       |  gap  |----VMA A----|
>
> This would result in reporting a gap in the address space that does not
> exist. To prevent this we retry the lookup after locking the vma, however
> we do that only when we identify a gap and detect that the address space
> was changed after we found the vma.

Can we separate out into a new paragraph?

> This change is designed to reduce mmap_lock contention and prevent a
> process reading /proc/pid/maps files (often a low priority task, such
> as monitoring/data collection services) from blocking address space
> updates. Note that this change has a userspace visible disadvantage:
> it allows for sub-page data tearing as opposed to the previous mechanism
> where data tearing could happen only between pages of generated output
> data. Since current userspace considers data tearing between pages to be
> acceptable, we assume is will be able to handle sub-page data tearing
> as well.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

OK this is looking pretty great now, I make a bunch of points below, but I
don't think anything is holding this up from being OK, so with those
addressed:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/proc/internal.h        |   5 ++
>  fs/proc/task_mmu.c        | 118 ++++++++++++++++++++++++++++++++++----
>  include/linux/mmap_lock.h |  11 ++++
>  mm/madvise.c              |   3 +-
>  mm/mmap_lock.c            |  88 ++++++++++++++++++++++++++++
>  5 files changed, 214 insertions(+), 11 deletions(-)
>
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 3d48ffe72583..7c235451c5ea 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -384,6 +384,11 @@ struct proc_maps_private {
>  	struct task_struct *task;
>  	struct mm_struct *mm;
>  	struct vma_iterator iter;
> +	loff_t last_pos;
> +#ifdef CONFIG_PER_VMA_LOCK
> +	bool mmap_locked;
> +	struct vm_area_struct *locked_vma;
> +#endif
>  #ifdef CONFIG_NUMA
>  	struct mempolicy *task_mempolicy;
>  #endif
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index b8bc06d05a72..ff3fe488ce51 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -127,15 +127,107 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>  }
>  #endif
>
> -static struct vm_area_struct *proc_get_vma(struct proc_maps_private *priv,
> -						loff_t *ppos)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static void unlock_vma(struct proc_maps_private *priv)
> +{
> +	if (priv->locked_vma) {
> +		vma_end_read(priv->locked_vma);
> +		priv->locked_vma = NULL;
> +	}
> +}
> +
> +static const struct seq_operations proc_pid_maps_op;
> +
> +static inline bool lock_vma_range(struct seq_file *m,
> +				  struct proc_maps_private *priv)

OK this is a nice abstraction.

> +{
> +	/*
> +	 * smaps and numa_maps perform page table walk, therefore require
> +	 * mmap_lock but maps can be read with locking just the vma.

Probably worth mentioning that you hold the RCU read lock for the operation
also.

> +	 */
> +	if (m->op != &proc_pid_maps_op) {
> +		if (mmap_read_lock_killable(priv->mm))
> +			return false;
> +
> +		priv->mmap_locked = true;
> +	} else {
> +		rcu_read_lock();
> +		priv->locked_vma = NULL;
> +		priv->mmap_locked = false;
> +	}
> +
> +	return true;
> +}
> +
> +static inline void unlock_vma_range(struct proc_maps_private *priv)

I guess the 'range' is either - the whole thing in case of mmap read
locked, or single VMA in case of per-VMA locks.

> +{
> +	if (priv->mmap_locked) {
> +		mmap_read_unlock(priv->mm);
> +	} else {
> +		unlock_vma(priv);
> +		rcu_read_unlock();
> +	}
> +}
> +
> +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> +					   loff_t last_pos)
> +{
> +	struct vm_area_struct *vma;
> +
> +	if (priv->mmap_locked)
> +		return vma_next(&priv->iter);
> +
> +	unlock_vma(priv);
> +	vma = lock_next_vma(priv->mm, &priv->iter, last_pos);
> +	if (!IS_ERR_OR_NULL(vma))
> +		priv->locked_vma = vma;
> +
> +	return vma;
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static inline bool lock_vma_range(struct seq_file *m,
> +				  struct proc_maps_private *priv)
>  {
> -	struct vm_area_struct *vma = vma_next(&priv->iter);
> +	return mmap_read_lock_killable(priv->mm) == 0;
> +}
> +
> +static inline void unlock_vma_range(struct proc_maps_private *priv)
> +{
> +	mmap_read_unlock(priv->mm);
> +}
> +
> +static struct vm_area_struct *get_next_vma(struct proc_maps_private *priv,
> +					   loff_t last_pos)
> +{
> +	return vma_next(&priv->iter);
> +}
>
> +#endif /* CONFIG_PER_VMA_LOCK */
> +
> +static struct vm_area_struct *proc_get_vma(struct seq_file *m, loff_t *ppos)
> +{
> +	struct proc_maps_private *priv = m->private;
> +	struct vm_area_struct *vma;
> +
> +	vma = get_next_vma(priv, *ppos);
> +	/* EINTR is possible */
> +	if (IS_ERR(vma))
> +		return vma;
> +
> +	/* Store previous position to be able to restart if needed */
> +	priv->last_pos = *ppos;
>  	if (vma) {
> -		*ppos = vma->vm_start;
> +		/*
> +		 * Track the end of the reported vma to ensure position changes
> +		 * even if previous vma was merged with the next vma and we
> +		 * found the extended vma with the same vm_start.
> +		 */
> +		*ppos = vma->vm_end;
>  	} else {
> -		*ppos = -2;
> +		*ppos = -2; /* -2 indicates gate vma */
>  		vma = get_gate_vma(priv->mm);
>  	}
>
> @@ -163,28 +255,34 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  		return NULL;
>  	}
>
> -	if (mmap_read_lock_killable(mm)) {
> +	if (!lock_vma_range(m, priv)) {
>  		mmput(mm);
>  		put_task_struct(priv->task);
>  		priv->task = NULL;
>  		return ERR_PTR(-EINTR);
>  	}
>
> +	/*
> +	 * Reset current position if last_addr was set before
> +	 * and it's not a sentinel.
> +	 */
> +	if (last_addr > 0)
> +		*ppos = last_addr = priv->last_pos;
>  	vma_iter_init(&priv->iter, mm, (unsigned long)last_addr);
>  	hold_task_mempolicy(priv);
>  	if (last_addr == -2)
>  		return get_gate_vma(mm);
>
> -	return proc_get_vma(priv, ppos);
> +	return proc_get_vma(m, ppos);
>  }
>
>  static void *m_next(struct seq_file *m, void *v, loff_t *ppos)
>  {
>  	if (*ppos == -2) {
> -		*ppos = -1;
> +		*ppos = -1; /* -1 indicates no more vmas */
>  		return NULL;
>  	}
> -	return proc_get_vma(m->private, ppos);
> +	return proc_get_vma(m, ppos);
>  }
>
>  static void m_stop(struct seq_file *m, void *v)
> @@ -196,7 +294,7 @@ static void m_stop(struct seq_file *m, void *v)
>  		return;
>
>  	release_task_mempolicy(priv);
> -	mmap_read_unlock(mm);
> +	unlock_vma_range(priv);
>  	mmput(mm);
>  	put_task_struct(priv->task);
>  	priv->task = NULL;
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index 5da384bd0a26..1f4f44951abe 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -309,6 +309,17 @@ void vma_mark_detached(struct vm_area_struct *vma);
>  struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  					  unsigned long address);
>
> +/*
> + * Locks next vma pointed by the iterator. Confirms the locked vma has not
> + * been modified and will retry under mmap_lock protection if modification
> + * was detected. Should be called from read RCU section.
> + * Returns either a valid locked VMA, NULL if no more VMAs or -EINTR if the
> + * process was interrupted.
> + */
> +struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> +				     struct vma_iterator *iter,
> +				     unsigned long address);
> +
>  #else /* CONFIG_PER_VMA_LOCK */
>
>  static inline void mm_lock_seqcount_init(struct mm_struct *mm) {}
> diff --git a/mm/madvise.c b/mm/madvise.c
> index a34c2c89a53b..e61e32b2cd91 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -108,7 +108,8 @@ void anon_vma_name_free(struct kref *kref)
>
>  struct anon_vma_name *anon_vma_name(struct vm_area_struct *vma)
>  {
> -	mmap_assert_locked(vma->vm_mm);
> +	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
> +		vma_assert_locked(vma);

This looks familiar ;)

>
>  	return vma->anon_name;
>  }
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 5f725cc67334..ed0e5e2171cd 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -178,6 +178,94 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>  	count_vm_vma_lock_event(VMA_LOCK_ABORT);
>  	return NULL;
>  }
> +
> +static struct vm_area_struct *lock_vma_under_mmap_lock(struct mm_struct *mm,
> +						       struct vma_iterator *iter,

Nit, but we tend to call this vmi (yes Liam and I are addicted to 3 letter
abbreviations, we are evil beings)

> +						       unsigned long address)

I swear we already had a helper for this? Maybe misremembering

> +{
> +	struct vm_area_struct *vma;
> +	int ret;
> +
> +	ret = mmap_read_lock_killable(mm);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	/* Lookup the vma at the last position again under mmap_read_lock */
> +	vma_iter_init(iter, mm, address);
> +	vma = vma_next(iter);

Maybe worth calling this lock_next_under_mmap_lock() as we are grabbing the
next VMA here??

> +	if (vma)
> +		vma_start_read_locked(vma);
> +
> +	mmap_read_unlock(mm);
> +
> +	return vma;
> +}
> +
> +struct vm_area_struct *lock_next_vma(struct mm_struct *mm,
> +				     struct vma_iterator *iter,
> +				     unsigned long address)

Slightly confusing this, I think last_pos would be better? Or last_address?

Otherwise it's not clear it's the address of the next VMA or the end of the
previous.

> +{
> +	struct vm_area_struct *vma;
> +	unsigned int mm_wr_seq;
> +	bool mmap_unlocked;
> +
> +	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "no rcu read lock held");
> +retry:
> +	/* Start mmap_lock speculation in case we need to verify the vma later */
> +	mmap_unlocked = mmap_lock_speculate_try_begin(mm, &mm_wr_seq);
> +	vma = vma_next(iter);
> +	if (!vma)
> +		return NULL;
> +
> +	vma = vma_start_read(mm, vma);
> +

Nit, but myabe erase this newline.

> +	if (IS_ERR_OR_NULL(vma)) {
> +		/*
> +		 * Retry immediately if the vma gets detached from under us.
> +		 * Infinite loop should not happen because the vma we find will
> +		 * have to be constantly knocked out from under us.
> +		 */
> +		if (PTR_ERR(vma) == -EAGAIN) {

Maybe worth a comment here stating that we intentionally retry getting the
next VMA, and therefore must reset to the last visited adress each time.

> +			vma_iter_init(iter, mm, address);

Maybe Liam can confirm this is the best approach? Seems correct though.

> +			goto retry;
> +		}
> +
> +		goto out;
> +	}
> +
> +	/*
> +	 * Verify the vma we locked belongs to the same address space and it's
> +	 * not behind of the last search position.
> +	 */
> +	if (unlikely(vma->vm_mm != mm || address >= vma->vm_end))
> +		goto out_unlock;
> +
> +	/*
> +	 * vma can be ahead of the last search position but we need to verify
> +	 * it was not shrunk after we found it and another vma has not been
> +	 * installed ahead of it. Otherwise we might observe a gap that should
> +	 * not be there.
> +	 */
> +	if (address < vma->vm_start) {
> +		/* Verify only if the address space might have changed since vma lookup. */
> +		if (!mmap_unlocked || mmap_lock_speculate_retry(mm, mm_wr_seq)) {
> +			vma_iter_init(iter, mm, address);
> +			if (vma != vma_next(iter))
> +				goto out_unlock;
> +		}
> +	}
> +
> +	return vma;
> +
> +out_unlock:
> +	vma_end_read(vma);
> +out:

Maybe these labels should reflect the fact this is a fallback case?

Like fallback_unlock + fallback?

> +	rcu_read_unlock();
> +	vma = lock_vma_under_mmap_lock(mm, iter, address);
> +	rcu_read_lock();

OK I guess we hold the RCU lock _the whole time_ as we traverse except when
we lock under mmap lock.

> +
> +	return vma;
> +}
>  #endif /* CONFIG_PER_VMA_LOCK */
>
>  #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> --
> 2.50.0.727.gbf7dc18ff4-goog
>

