Return-Path: <linux-fsdevel+bounces-25292-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186494A76F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 14:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9900F1F255C3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B783F1E4EF7;
	Wed,  7 Aug 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nzpPaqGx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BUgx6UyX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD01E4EF9;
	Wed,  7 Aug 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032264; cv=fail; b=UNooSF31Pjd78Jn4mLTvfkJtRvKv9DHV9sQfnYPjljdJ6eSmKnUGNWUIQAeKZ5hXf3FueG5PzF4Yea2NGxVA9Sc6dhhNMbx4CVMgsOwf+LqAOkpVJNRaiGepkjftuVozJHqHv7rV4H1/EFRwAbK69mbfw+k2YJVXB0pOZbwLjQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032264; c=relaxed/simple;
	bh=fma3GbSOT1xU+giYxJl/Pyq2S1IMoRywH51dz1qi1QU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NMC6GILjgCjnq/MVJHh5UCyyrgU06RZZrd6udfhfW20gheQi6fKlmyQTw2F+13RqVdgGjvSlTjJz4yfWeovzwbkFceRRIg4wJfajW2LaXRGYEqvGsvRFJVCsstM2zhtLRWeNL/99JX47B91w5AqZeHLIAdiSnh9u+pOCFoQj5z4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nzpPaqGx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BUgx6UyX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477AU0de021001;
	Wed, 7 Aug 2024 12:04:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Bd9kj9ZnU/Uwd2R
	N7dXCPaotQOh1Pf+FaUVQ1CLpxBI=; b=nzpPaqGxZQ9Nun/s7llDCZCMlT6SVI3
	3j8JEBKC0rJ9LworYEO9ol+97+nobCUq+MFjGAOVlzNEIBykrPU1jF9yfzGMMbNP
	Rozcw4Wj/IMIRYHTFa9WSwoOEFg4ty+OwHhyO/bB56e6WgeS9Vm6i6n8OCwqUB/f
	6cg1wRXNmzp0X500HAHzZFWA3zefr13+leUTxNDLAzu9WKfmHDEp27gULayUTaaR
	Nwt0+3Tu8/At+cV4ekqgTgQw1UHzbmYjCoBoOsc/2uTbOePKcGVxFWfO6pMLazMq
	WdUXqTDN7KcSohvE8qKvIo5aoPDmLs+WSdyNgaKyBSSOvb+6LF+tZVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbb2qebr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 12:04:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477BNHRb018280;
	Wed, 7 Aug 2024 12:03:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb09wt3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 12:03:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFKodVn0YnbOpX/WHIVbudHD2NWMvb6nYp1SWi6GKr7BDRUSaCFC/CQnFDBb1+lGcN/zVt3oClaZRrIzXXQ6sQ7+/VELMwGipLqW8+XdO7541eo6yYroDI/u/Cw14XQYTIuJkJtA1JF8FBGweJxjEnrY9S/1Zl3Nxnq8OhVOw9rYkzDeBwkDCP43OE/sTeab9DbXu5/y6YVEXOifDEjHLgoh/+IE1I0sYYnl0rGLErmoRgiBjshTgjDE4fLZoClUIDdc66GU7D+xAi1/vcN+E+4tyQcXIF88Fz7WKRfDq+awTozUMtvTDAHIUvJh+5244leNA/J3kgqJQjHr/22gNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd9kj9ZnU/Uwd2RN7dXCPaotQOh1Pf+FaUVQ1CLpxBI=;
 b=FBU2tOwDuTukfg9/+94gLO7Hh7e0Q8bLgqKgJb4UfaXETbL3P2p+981+OfQI/BVhhO5N44BaVnM5wgLhWr0d3srsSjXfAbJu0fLHJYKWr5+RgiHFIUPG3J/OqFxHVkqTdVLk8dQMI94h0XsXy2jjPa0W5KHanGFwjMD91FH8DoMRwS4gf2xqM2jh7ZtVYLmbSsFSBudzI/XM/UD4LqmOyZT5wSftPiLQ5zKmZE/vt8KiznqdCV66JAvD2aT9jjRZDBthznXLxiXRMkJbO+VjUnF+tGlL0HGfJjC9vb1QLLeM8rM8XHgUfUh3z8uW/LFmNTuKYmRRM+gGDtpovsjDtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd9kj9ZnU/Uwd2RN7dXCPaotQOh1Pf+FaUVQ1CLpxBI=;
 b=BUgx6UyXLnQ4adIFnnr4KECqUyjaOKB0CNZo2VOxZkcq3Tlt+if98JN7ppCIKUhV96LrOfnsZoiIWRfII+uUebJQUf05DNjlNt8f90i6E0AEwrSyXb2J0Pa6fKBjtdwHjLQxlu5uxXCxHDM2Y5IgCJ6Li70YyENVkqNJIyhHIHU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BY5PR10MB4146.namprd10.prod.outlook.com (2603:10b6:a03:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Wed, 7 Aug
 2024 12:03:56 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 12:03:56 +0000
Date: Wed, 7 Aug 2024 13:03:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pengfei Xu <pengfei.xu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH v4 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <3c947ddc-b804-49b7-8fe9-3ea3ca13def5@lucifer.local>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
 <50c3ed995fd81c45876c86304c8a00bf3e396cfd.1722251717.git.lorenzo.stoakes@oracle.com>
 <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrLt9HIxV9QiZotn@xpf.sh.intel.com>
X-ClientProxiedBy: LO4P123CA0558.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BY5PR10MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: aca7addf-f33a-4ef3-167f-08dcb6d90355
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9f6j8k3juuQAUpji6xywWx1XH7cSwYw8P0sQiWkezXSOtLx3DtT2oSQwVd8?=
 =?us-ascii?Q?FZLuROLwf8TbW+Q37XA2OD08DJkGFwzJRsiPRu5oqlBVLjUaxTCSYrB/Xc+q?=
 =?us-ascii?Q?0kle+z1B7y3DfvHWZklVa6nrAI7tmxazsZXSdToKYzYNSOSVilnpN9bdAwV/?=
 =?us-ascii?Q?AZHD+4Xr3tJdtMoCp6aXTF94/8g5Dppbbh5ml7WQ9Co9ywhHslvjdwHshDm4?=
 =?us-ascii?Q?z9HWXCcLoDzeRmPxTX6rvCIIxZjcPbNGOkCoYGo66BA8+CAA7C+o3M/vYsYm?=
 =?us-ascii?Q?XkydshxL1XZsx1u8DcaCc9A4PY3wZIc6jBsMnwLZjbWSXjkOz2s5q47ckcgQ?=
 =?us-ascii?Q?3vB4OWa3xe/2qNW4Os/yAEfpe5+Q1USVu4P4yPRODrRZg9KDeffCK4O0weaG?=
 =?us-ascii?Q?RX61XirQWXQ/WeT3qmb+FNcuswcLk3/rdEIYdHrGQ4llj8OA1MMbCzbw0+UC?=
 =?us-ascii?Q?ikJy1b+t7eU54lej8jN8DXT7oxTj/fwpZ9nt5GykSDW0Srd+z8CYF1xOK1Nt?=
 =?us-ascii?Q?cOG/ff6AeVDobn95YO3Ix0uXTPrWPSS35K7T6SkHTmtsUi0gYwb3b6Z0nZVz?=
 =?us-ascii?Q?4HFh5NppvVyop4miSGT7P8JaFZY7qhVxtSjqKKMBAxVLi8lg5U73QBB75/zj?=
 =?us-ascii?Q?bob07as8tUejYmli0ZKSQldXR5K/iQ2u/IW+D7DuUhJtrnaXQybNKGy2HxyE?=
 =?us-ascii?Q?FabSYEsRbZBYzrYCbYhF/+UKMJo+FCGCzpd7FB0zmOzeqaGcYcdlnBZ4jxKF?=
 =?us-ascii?Q?1vQKXsz1mICjWGl44/WIgtd+vsYD0MAAuUl5zbgcBduGkXpEaQqC/UBDYKrF?=
 =?us-ascii?Q?fnW31arl5RXiHGthquey8vNcMcfh0+xfswu54vbiYySTj/W3c/dJCuYyxwQL?=
 =?us-ascii?Q?68zNjcOCg6iHw4jGbqKJqDoAAiPrKIWx9LfEsJrjELQp9t11l93bd4B7uGcz?=
 =?us-ascii?Q?pxDbJvODvXNiQFNN1CtcpY18/wUSp/NGVUUvZV2eIVcUvUXJJvSzKoAYCIz6?=
 =?us-ascii?Q?Y/XN9YSr/7lYx2ByU95s/7sC98cWjjOZv0ss4XuT8Z9L0Ec80YCRedscUOqn?=
 =?us-ascii?Q?uEmPvdnf15HtJdzbdEXePUvDxlCKbQ2wrnzpJ8WYVmy9p8WHdwYUVNw9sw4J?=
 =?us-ascii?Q?ZOplCvNviicviW4kWOI8qbs4wqmr69tItIj/oFDOxs3qlHGZWZQbZViSLWVy?=
 =?us-ascii?Q?XLJC14DQlp8Yiyuo8/B0C9u8xM2jbUM+/n3G4nNb7+JV2WeaWFuqNWX8B8Wi?=
 =?us-ascii?Q?TBEYuGYmwxZPlgfiKxsaf/6AznbmfaWCZeHFxqdqBmhrDGx8pkF9v8o5JxYl?=
 =?us-ascii?Q?NGL5z39e0uTBVCxNmhXlRY7d?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9Wmxz1xxZtXvEoKJyeqIyZsIzxSXKmXFgTAl46O6idf+tQ2Sy10Dm9sTFHJr?=
 =?us-ascii?Q?G501Z9h9l7BTk6Ud//7zPtfkjm+ANgJhmsn1/afr0ymcuYVyA1J8jzA+Y134?=
 =?us-ascii?Q?6kdblf2iSGMVGoDJlJsHzxAu/2VX598foTotGhCRKWYU24Ol6GQMPY6li8gv?=
 =?us-ascii?Q?0dUOdpoFBVvamjbFnqbUTzHqbWZsxFZPMLE5a/LwjKi6v9x65ggITW6j0sFo?=
 =?us-ascii?Q?WsEuq54ZFRF8d3DhS9s3PVTRvFve2kLwB0StNFzn2dHfsKDUdS1QGI+FawiR?=
 =?us-ascii?Q?NZGk/Up6VCeoGG2Uez1M0UvKEqzCpuAyRkqGD3ChRNzNZAJFJraoo1GBlIK1?=
 =?us-ascii?Q?iGgeuY1MkFadUtaug3f4WCJMrp2bBpbNR99/g3YtDgrS7ZncylxPgiFUAVO8?=
 =?us-ascii?Q?kaqk7k8UAIH1h6uC0mDU46O59HrsE3lZI7YAtq9PQDMxmZWljw6LP4ET3FLz?=
 =?us-ascii?Q?6FxRY4rww68wsYfioAH07jArz8KXNjlyXs2miTdwg0ElypsuhvWe1LDvu50M?=
 =?us-ascii?Q?DogVwPNoOqdm4bIYnk4IuPAv6kcHldGI4yZUvpKWi3wW9qbQwYz18DcPNezp?=
 =?us-ascii?Q?/mDTTiLnrCB80nKMASi7kC2lssWQCztBAIL8ex/vaOL6X+z6J2RPTBugTnFJ?=
 =?us-ascii?Q?6iEwStivamN2k3cCwwZQQEoWjQCvKzLAoOUvOTTUxbqB6fb8i1MqjFzGb298?=
 =?us-ascii?Q?ire5Jw+I0TchJKPB2YkqFC92DpkdjMV4+STj/JCSWjmalUa5dpvAdNsy0t6R?=
 =?us-ascii?Q?lVoRLa1GdMZJLrTL08tOSrnRPmwg1ZkeQ5CaYFYqf3SxQLGQ6Vxq8HPJeqMN?=
 =?us-ascii?Q?UoS2aL3/5v5gBB4ggAI19K+tRwDIH8RqA9VbjTxtWerd6c93qE57deiPWcDt?=
 =?us-ascii?Q?VrIzrXmM2+21v0nHeiOLXXhHDa9IFRd4Vrnf6jfmAwhHpID2AzcnJODB+qDK?=
 =?us-ascii?Q?7pNW1oZDB0br9XHGEI3YGLNGEx07G7RaNt/vq0gyj61g65xjS9jq6gXV0GIf?=
 =?us-ascii?Q?oEHmgmWBti/ep9+xAmal3pMi8IJH34s3tTUeksdGakOxBq39VM3GSZp7NRco?=
 =?us-ascii?Q?QfSs1Ks1mn2eJOMC8URSvetc41ng32y4vUTNvDw8lcUbzHxF+x/7CL4XXRhf?=
 =?us-ascii?Q?0kvV68Q53BgZz3PrOQDohvqYdozgDGzpzrZt+LXVOgHNK1e+o1vNIYAEifuI?=
 =?us-ascii?Q?NFjgOb0WMt2jKP/9TCXkEIzQQMgVzw9zdFEDlR4FXKUxjaZFAeAWWBPZYlV5?=
 =?us-ascii?Q?ems63KvekH29sfcTwd14NL85hWoY2/4vwCN//dmNRlhQxQ0RIgXrmG/1G1bA?=
 =?us-ascii?Q?pGYDPr2sPpJS2ibrhcnbAcwCsDQynd5Sp+2232492zXwq4kCHt+yBIloOlNU?=
 =?us-ascii?Q?UK3B/TgmK/OZKQ1gsd03sPol/gaAN5mzmvpVRV6yUcjcoontzj2qMT0/aID7?=
 =?us-ascii?Q?qid+hIWYVQvVVW7CnP+4vuXo/2TNP+FwGEBEb/M+2SZad15GezmikL0EpJGh?=
 =?us-ascii?Q?HLrT8A7t6asJBUDMRldlcuYtnZ3W2bGQRYBZEEKzPcZeToH5FhH09VQLITQQ?=
 =?us-ascii?Q?4OdjdD8xbVMkB1NXp2rnhdnvoDFgE5lSdIGS28HZi8Jjcc+bD8mbCdHVHdVF?=
 =?us-ascii?Q?19V6+MrwpEH14xqFUusuWi1oARbgtqoFfKB7SU+1ccDgn7lZsxubjsjR4Exc?=
 =?us-ascii?Q?7SS3Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6q5s1dO+y2YAV5TmwUTY0wz4BpKA0bYDDmtuhFt3xFdFljocq4iPsTSB2EnDDj9UbsBC22/AbzxO4OeCgk9MSgGtPCvM9rQ9ZZNIMzQIutzBCUo9rTFMnXZF3whJzjeaDqoHCXd/qYsVvzWnzZDhSk3wHPxpNjKZ1zJotgh136NlXRjBs8JPiLqyR5a5t8PhP5ujA2khEup1FDsrL4sYJSvwOB+r2wJkvaSeHpQo49c2dTKyxP1dLpna43nSh91A//vDBp1yyPEFzlbchZSoKGCKvDLTT6N/xJSpVHpUf82R8Uv4dPjWCloMi6iAsN/fQucOk/eBSmlPP2Ik0oCe3iQA2NC9sl0O2hc/yof9XcKLTMFEFvJg4CxzHmEyyVy/QWcNsXa2V2+BS/5rBy6IpJlkKia5Jj40DjS0M1FCFT5aMecM5ZBdZlyzsU6Ad3sypGfDK0nkVG7LSWqj1UT/06c/05bnoWWX83DEaHO3m7XsebnmGYEjFZEnDagzew16+GJKZpV74gRvQNIbRwEnMwbA4df89KDAJsLzL3MAi1b7DPxXYjyxrqcc3tTu/LU6kSiUJw1kN8udRx1aIIPsPlO0TkxluJ0fnoD28tuA+hQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca7addf-f33a-4ef3-167f-08dcb6d90355
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 12:03:56.1228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtARxgoO9dlFYMp2t8X4WzHHDtykEkKG+e49KAco4A6kKihOx3gbKQtlm3TP83b2YJxgPvlxtIFMIXejC7a0peuGD1MKik7UK7lrLUBZ0xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4146
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_08,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070083
X-Proofpoint-GUID: 4-KeB6jRPaRJBgAudDidy-d3i7OndyUc
X-Proofpoint-ORIG-GUID: 4-KeB6jRPaRJBgAudDidy-d3i7OndyUc

On Wed, Aug 07, 2024 at 11:45:56AM GMT, Pengfei Xu wrote:
> Hi Lorenzo Stoakes,
>
> Greetings!
>
> I used syzkaller and found
> KASAN: slab-use-after-free Read in userfaultfd_set_ctx in next-20240805.
>
> Bisected the first bad commit:
> 4651ba8201cf userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
>
> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240806_122723_userfaultfd_set_ct

[snip]

Andrew - As this is so small, could you take this as a fix-patch? The fix
is enclosed below.


Pengfei - Sorry for the delay on getting this resolved, I was struggling to
repro with my usual dev setup, after trying a lot of things I ended up
using the supplied repro env and was able to do so there.

(I suspect that VMAs are laid out slightly differently in my usual arch base
image perhaps based on tunables, and this was the delta on that!)

Regardless, I was able to identify the cause - we incorrectly pass a stale
pointer to userfaultfd_reset_ctx() if a merge is performed in
userfaultfd_clear_vma().

This was a subtle mistake on my part, I don't see any other instances like
this in the patch.

Syzkaller managed to get this merge to happen and kasan picked up on it, so
thank you very much for supplying the infra!

The fix itself is very simple, a one-liner, enclosed below.

----8<----
From 193abd1c3a51e6bf1d85ddfe01845e9713336970 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 7 Aug 2024 12:44:27 +0100
Subject: [PATCH] mm: userfaultfd: fix user-after-free in
 userfaultfd_clear_vma()

After invoking vma_modify_flags_uffd() in userfaultfd_clear_vma(), we may
have merged the vma, and depending on the kind of merge, deleted the vma,
rendering the vma pointer invalid.

The code incorrectly referenced this now possibly invalid vma pointer when
invoking userfaultfd_reset_ctx().

If no merge is possible, vma_modify_flags_uffd() performs a split and
returns the original vma. Therefore the correct approach is to simply pass
the ret pointer to userfaultfd_ret_ctx().

Reported-by: Pengfei Xu <pengfei.xu@intel.com>
Fixes: e310f2b78a77 ("userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c")
Closes: https://lore.kernel.org/all/ZrLt9HIxV9QiZotn@xpf.sh.intel.com/
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 3b7715ecf292..966e6c81a685 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1813,7 +1813,7 @@ struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
 	 * the current one has not been updated yet.
 	 */
 	if (!IS_ERR(ret))
-		userfaultfd_reset_ctx(vma);
+		userfaultfd_reset_ctx(ret);

 	return ret;
 }
--
2.45.2

