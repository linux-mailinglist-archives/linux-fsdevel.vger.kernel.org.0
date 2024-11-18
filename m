Return-Path: <linux-fsdevel+bounces-35079-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E39D0F51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 12:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A95F283487
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Nov 2024 11:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C5F198A1A;
	Mon, 18 Nov 2024 11:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i0o5UrxD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ykvy36jn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA617E01B;
	Mon, 18 Nov 2024 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731928351; cv=fail; b=FQaYGwNUjDDA/DQuz7gdqbVMlRV2kEjP2Uk0V9Lpgxw9+D8aN9KToLatZlzxA+ZFNzZEj26AahRqoEw425+4/GWALY9jl8zM6++PYKQ8Zd5k2rW/goT2KS77Y1YlDflVbV9N5omZZMRXKc01wzvvMmrrd0ifKCS/fRIx9Cf93lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731928351; c=relaxed/simple;
	bh=GuTB4m13EFXggCiu9Fh7pGT2978MQZk/BKqIY0Pamrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=deDvMpeEyGAkr2G23IEB9oyjZcXgGw5KQzf4hcakJOiIhUnWjxWcxzAAWL+zjTo6PB8sC1eYMKqA/ab381uNwNd+OShMzIZTYbZEkhErML7ijIBofycWAjkOLpGlr+xGApTyLhlZYh3gLp3VRsRQYj43SaPgTm9uxG4smMA+o4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i0o5UrxD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ykvy36jn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI8QaZ3004695;
	Mon, 18 Nov 2024 11:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Rwh/ntAw8kR4F6al/Y
	q7OmAz2rmJtAs2les/Wgj/xhc=; b=i0o5UrxD+wtYnivUHDrT2u5+yc21/zbfrr
	vDSZzh76DFIARdDREeN5QBwbbwB16mEfxEXRLAqRqEp+fh5QlmqEZE6AF4lk7dcY
	tBX5P82rbbBQuzSrTuABWHo4zINODpls5FcpmFSb+IsKXT6/5tbfe3YZwMxMRTmm
	6ZbpzAU4Q4YlejLNEfEIwWxijwje/HyXAhUclSoX8P9BFc7winsFtsHz7ZCzuSiD
	oRtrE5iHDtJAd4NOpfGt+lqkIzXeAf2sMtqVwIaRfBopH4N7bUOeIiO+mEsjEdOu
	jqSfbGXCYMlpUvALXVKozrIPahz1x9iLOkEeVOaRkw5UgpOEJ8Zw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xkebte2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 11:11:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AI9q4WY007832;
	Mon, 18 Nov 2024 11:11:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu6xmt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Nov 2024 11:11:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=esQW1KhFwkF8Bkm168kokKkhleYwJjs6FXNmg3FvhZTGeThESLd/f52qLpiSGceJxcQxul7WY5FGNd+2aB9mez/BZ8+sVAYWzFUvMfz7U7hmcpOI3eU9rM4utUeYkLPqWPE3AWB8pc9dFLcMRV+SyzqrdVFuY0Xd9dmlKrfkv3zS/mOyyyCXAU2xy+5Ox/ZCH822Twve5SsNKIvW3qwa8jUxZRkPrLARXsIGYSzqxScyLVqXjfGGxT0lXUz0hf3csVkz+KaQXc0gnFDGZ8Ckov2au39j6pKlhSNpfWfAnbAufr+CIU9ZyiUAv21nmw3k2mkaMMQGcz4tqF/QQDFl9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rwh/ntAw8kR4F6al/Yq7OmAz2rmJtAs2les/Wgj/xhc=;
 b=hnE9g21UIGpxj0dlQS8wPC4FNlFtz9gOc5q1S6E/7+izNxGcZw51ic0e8EonlcjW4Obq2JoGvihjsi6ZDmPIPUwC3Z2dacgdLtJ/y8O+KMGsBq/R4F7V58QxxIoDwBYMSZmEgYddp7MGTwE3oNp0a9Y85gmu/jpLRIXI1qRGNAax7+93LSqhvqVC3u7wAsTQBdcGbH7dOOqHv4H5Z/2MXTAJCmQt1Puf57of8uWZ+YZi091H4krkE4Ygl7QY4/Fg9bk+qPqr3rOkJrwkqlV5AH/VaO3d46I0bVBXdaEqNhp8F22tztMWj2/aZHpL1LwVYcD/ogT63jayMmvtlffXag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rwh/ntAw8kR4F6al/Yq7OmAz2rmJtAs2les/Wgj/xhc=;
 b=ykvy36jnY5W+6kY+7sa2OvdFryUpSGdnRfC5GzhaglaN3L0ZFW0E0Dckny3ILVD0rBc9ZDxYbeWeJQlbuKD7XaEx1QV+Nx8B4rwc/pyfase6Dqvjog7YzV8BhBgQKi02c2XDx564BQkSXUlLNLmg9coJ9AhDSl6/9H0MTeqFE2A=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH8PR10MB6359.namprd10.prod.outlook.com (2603:10b6:510:1be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 11:11:41 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.021; Mon, 18 Nov 2024
 11:11:40 +0000
Date: Mon, 18 Nov 2024 11:11:37 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
        akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        tj@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeel.butt@linux.dev,
        muchun.song@linux.dev, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com,
        vattunuru@marvell.com, schalla@marvell.com, david@redhat.com,
        willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com,
        andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com,
        oleg@redhat.com, tandersen@netflix.com, rientjes@google.com,
        gthelen@google.com
Subject: Re: [RFCv1 4/6] misc/page_detective: Introduce Page Detective
Message-ID: <a43f2369-c6b6-4207-a962-c8089d294809@lucifer.local>
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <20241116175922.3265872-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241116175922.3265872-5-pasha.tatashin@soleen.com>
X-ClientProxiedBy: LO4P123CA0411.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::20) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH8PR10MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: ee64ac7f-b5c2-41b1-e57e-08dd07c1c70b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IvJjpqg/hMkr6mndg/u7cPlWqdKdARfPSLLeBiWgx75utV6GHZErTknWWUlv?=
 =?us-ascii?Q?GSkZ6OV1W9hXJgvWbO7gmL8tqbGbuAZPSgMbwp4fbejJ2Mcf9p79liPxmtrn?=
 =?us-ascii?Q?QQZxa1gxmoVdOZRzI33Z8EdbHeKBeivdN99LNMrxLtW5d9Na37E18BBhb8jB?=
 =?us-ascii?Q?sSJQBHwa2E6kWE7KCvOOtDIu+sTvvVWKmJTBHZZ5AFYdLbqmL5foHppT8DAG?=
 =?us-ascii?Q?i9DjneGmF3JnTQsI3teVn9sIblv5nNAa9u4JmxY/IfytY7w0L/s6vsF3v1OU?=
 =?us-ascii?Q?T4VHyLAea6JGxnkZlvHyTw3A38HL5fI0PGAqWr1cpO2PnqMjmrsXFMmvt2z7?=
 =?us-ascii?Q?OG/Sj+1lL2x3VkQnMSDgSZMGbFQzEuO+HgC/gOro+nUhLD4g7NcO/w4lA0lS?=
 =?us-ascii?Q?YYyMqfFtTTwBh4ULxWk8gh3ChepM+L41lcuo+Z2xcfNaDljW6ZTZ6YGXIGbH?=
 =?us-ascii?Q?VMEtcvbczCwerIVQh4eMLlXzdpxZ6Dgtkn1Z/mug2mZrWePgUyxEdSuu5D0b?=
 =?us-ascii?Q?TN8uSTsb2tFruaUjGuSgkFRWcY2oUCqx94P9s82x0+LN0JxCR6NK48mxeOgs?=
 =?us-ascii?Q?YoAbfFROIwEqzLT8lCGxWUvyswhMo0ZaD+n1mHzftlkqY7AdcxvCEh2si6UW?=
 =?us-ascii?Q?RLPirvXKQltxLfUJQUiwohouuKcXQCmw+bUOtjocMFoCNMyefJqS528pOAwj?=
 =?us-ascii?Q?vxt/8op2BMe0Ct8FUkpA/dByzyE9VkvzlLwQx0j2xHoG91gJgx6Avh1zpOC1?=
 =?us-ascii?Q?alErcSYdwjRkumxnfJfejsH1a8UT4jwkikzBSDCl8DCaV8LM4pm+6fhEdUJI?=
 =?us-ascii?Q?MREP790cwrLm9GomypZrOLwCKOUmmUXcYbGuOhH3Zt0oRMejGUDTV/QIOdWh?=
 =?us-ascii?Q?8ASCrVtgHzNamnA8h12uCCXuFIXmmkqwu+mJe8m8LFfXROsLVLBFWfPbUJ+C?=
 =?us-ascii?Q?RAZ9MMgOWSSwkpivrP4M0WgQzxugb8QcKdMaig6YPNVVyhuEAl4CS4SfwQdD?=
 =?us-ascii?Q?NBWbu6/JF8cKmyXb9UOXSTn3Iiv1jvNB5/9cN/xSbshK8D+JCZZBSApCj8fc?=
 =?us-ascii?Q?qJWUHeyc30aI/6tITqLAML0qHtODj/HGv8x8OYyOTM4lV7hXAjlcVpMiF25S?=
 =?us-ascii?Q?gnfY0F1bsKX59WQWabJYXloKj0emEJjhQxjB7K90T+hcfUuUW5+0WtQ884V7?=
 =?us-ascii?Q?5Yxvyf0U+Gh7glJ02KeTTgsxCqOjHUOALbPcD/OFEpXPxJABktvYiFK7UHjN?=
 =?us-ascii?Q?GTzJ8Aqw/3a6+HdoLkoSRp5BsLdAxt/PDEL9II04A+vLurWB0v+suZ7ucHyG?=
 =?us-ascii?Q?F6zU6LJEkz2IoufjDCcGYCPC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tXNyVkxCeOEoGbMQpW2qxmcyNM3o1UTVGvoX/wsWaD+2oaoFLbsqJUCAxLX2?=
 =?us-ascii?Q?rOvyVhlfZNtag/KAl7cdM9NrFiA41KwiPu1+6X8XDlAYicU0TAHP86iclMDQ?=
 =?us-ascii?Q?NO7SWpAwGeG5WJnx2g7AHaEll2OLOaBKi6UMa0kXrxzcqiMaoYfhl+Eyy2+B?=
 =?us-ascii?Q?z0iZCSrcz+MgmxIhlMfDKONg3ALsbgB+Ot6sEjZPICZNySFzmp2qfOSRrvWL?=
 =?us-ascii?Q?2ZGHuJpqOjPCs2/ryzFXhRV//cse+XYgk49EH4h1uZzR2Vjs9INCXhP5SztW?=
 =?us-ascii?Q?4OS6Vi+sgbtnS8xUyCVlW2AyrFKvd7uEAE7jVhzycvw7zwPbE63GMzb/Icid?=
 =?us-ascii?Q?pNwl8TzYzxfnqs37zIPfZhyiABniWafPHlrhMYujTW6Ys3Jzt5EVdMtxU6OL?=
 =?us-ascii?Q?8dtehs0ANRNaMlQZtW880Lm1aR+WDWXDGB7osGklS/pd/1Va8tANwuQ4F69f?=
 =?us-ascii?Q?Zwi0d86kS55NurLXu2MbMMgwGn+ECmYsE9kuaTi/c3rZVhzfvJnP1T827CMF?=
 =?us-ascii?Q?yU+mIcCug1I9/sGD96DugH7flRXH/yds+8ZQRDZ7CBOjqHZgsl8eV/fAejzC?=
 =?us-ascii?Q?c39ojpKhNUMOxQTNH1acd9BM6lVmazOsJRTH0dyR2jr4H9OUBJystZZc+jIf?=
 =?us-ascii?Q?f7uqQCj8CZ5rkUdwXjvCe6cIcqebkL6cE1t31MtviPaPNWQafuArqRno0/5f?=
 =?us-ascii?Q?Gp4PvMPCMuXFZ8cASKZFzcYTvFk6I2rYqFrC6BVxaXRdF5u184IZSjkKgif8?=
 =?us-ascii?Q?O725XYvb6oADG5/FAXeEo93z1L9ZdwF/0N+lCfJY9PUhSPTwON7g/eooLI78?=
 =?us-ascii?Q?ESqndKFY/qek3CciEswliumyRFALlk2KaYFFF0GBFVSsuITTsFJQj6REyQHp?=
 =?us-ascii?Q?89/UiEaaltjxSlVOsqS7JI/ionX47LEe4Nlhr2TLnTy1aTzO7ckxJ3lAWMaM?=
 =?us-ascii?Q?nEk6SQqompteJ095BXsbedQapxKL40dWIeA5DNn5yz2o4Y4cYoPLY7Hm1xBl?=
 =?us-ascii?Q?YhDM/kqEphKTLbPqXxnondc97N8+yGdazPShOJp9OBXibALRTxM8sD0iofPu?=
 =?us-ascii?Q?C9PcVz/gsUUDliQfKtnaBZ8eMOVEqfwUruCJtwFS2lF1UrEsI8w34ckYuNfT?=
 =?us-ascii?Q?DYKq9Fiha3TalYolJnGf9WWHrIuZsG+QgqhKzXrVj2ioRwOqCjBBBNAYOnTS?=
 =?us-ascii?Q?Z+8IHCh88CC2w+Xe8c/hY3pQBnpj+fnwSdSCUy1CXabswCsOZ1cobmaf/Lnh?=
 =?us-ascii?Q?NLR4I3sY0coMix6kVLpp7Qq6SrBrMWX23zUlssXsG8FEU7upGt7w+x4PRx8o?=
 =?us-ascii?Q?r7goXMwuz0SLNTiV9BhsUySYKf0FkUNhopeHOxoOlhkPG23+oBvgiZnh5Glw?=
 =?us-ascii?Q?9poN02pKC1J4Q7gMT4w3nxHuMCQ2dFpQ9S7OBrF0E+oNIxVoQcUOlcZ/AQUN?=
 =?us-ascii?Q?ID6DpxxULuSA3WvJSSXAYSymWq5bZUx53jcT/NOOpqWjZ1QLNlh8nD8Q4JvI?=
 =?us-ascii?Q?Nj8PmvqapnfFR6YiLVMmesHZ9KxH5z4u9KC5yKsTT8z87PNYlIGQkOMKi4AP?=
 =?us-ascii?Q?gRQKrKPfDuuG9ElnSAdF6/UaJMv1jgxgC7rEhmJ5awHELMIO2Gdc6TsSObRP?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QNSb1U77awqGSP22jgy0RBSKTQrS+BqB89jUz2MEsyY3fJOl/I6HDA/19m5ytcpEqFvW8cF+ixA7iygJso/Bwv8evTDTd6GIeoOZwQUv/OTDcWVZRroG5WJiWykWcb5CBqKI0cLx8bDABzOpBNDNhZX+hI8WiNv9zWgV2vJpuNAs18CAFAAbP1m90pey7xCr4ENk1E3BIUBzLQZbSZ15lyBKyuicGY4sRkkhVGapvuid+sWJe5cDR0BksdY/JkeZ0CdU4MQ6DuGvPJ3Ya8B0EfUCBhefBJKIINU+CQlKWVLgTzRZq7O2reAkbr+ehiryPBeef2OvP3pHhGVCD0Ul8Q4bHy4QoPGwsORqcgZlyaXgdxpps7e/B9/whaWrjeaPtQ6qNDkiDNouglRTC9QkBRhSJzl7ZUo2OcTn0Tx6MuoQbimV1RtaJ1Qjr+vHJFcf9GuXSB/dAHMc55EbUQKzbOF5gvHX58GISnq8rTtKE3b9FbK5ytx0vGrOlPAGNHZrHfxGRZ9lG/J7GW9gMWUuA6463LEk+IKQTmtpEPV33SPg1oOdKlWj5HXasibjgrUbbPjgRC08nQ/dTMiJdaQHC1KqqSys6GmWA+CHMDktI3g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee64ac7f-b5c2-41b1-e57e-08dd07c1c70b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 11:11:40.8916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: beg8FJJuX+TLz4YqQ07O+q+j1TrgL8MNU7AMwChE6f/46jIp8w//PWrX+aFE3JgnMseaD3FFTrlMjpwjBh1rZO5HGhf1VOiamif+iestXQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6359
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-18_07,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411180093
X-Proofpoint-GUID: iQzZlVnUPQncuAGmLoWmLO1H-GYqOG0E
X-Proofpoint-ORIG-GUID: iQzZlVnUPQncuAGmLoWmLO1H-GYqOG0E

On Sat, Nov 16, 2024 at 05:59:20PM +0000, Pasha Tatashin wrote:
> Page Detective is a kernel debugging tool that provides detailed
> information about the usage and mapping of physical memory pages.
>
> It operates through the Linux debugfs interface, providing access
> to both virtual and physical address inquiries. The output, presented
> via kernel log messages (accessible with dmesg), will help
> administrators and developers understand how specific pages are
> utilized by the system.
>
> This tool can be used to investigate various memory-related issues,
> such as checksum failures during live migration, filesystem journal
> failures, general segfaults, or other corruptions.
>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  Documentation/misc-devices/index.rst          |   1 +
>  Documentation/misc-devices/page_detective.rst |  78 ++
>  MAINTAINERS                                   |   7 +
>  drivers/misc/Kconfig                          |  11 +
>  drivers/misc/Makefile                         |   1 +
>  drivers/misc/page_detective.c                 | 808 ++++++++++++++++++
>  6 files changed, 906 insertions(+)
>  create mode 100644 Documentation/misc-devices/page_detective.rst
>  create mode 100644 drivers/misc/page_detective.c
>
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
> index 8c5b226d8313..d64723f20804 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -23,6 +23,7 @@ fit into other categories.
>     max6875
>     mrvl_cn10k_dpi
>     oxsemi-tornado
> +   page_detective
>     pci-endpoint-test
>     spear-pcie-gadget
>     tps6594-pfsm
> diff --git a/Documentation/misc-devices/page_detective.rst b/Documentation/misc-devices/page_detective.rst
> new file mode 100644
> index 000000000000..06f666d5b3a9
> --- /dev/null
> +++ b/Documentation/misc-devices/page_detective.rst

This is _explicitly_ mm functionality. I find it odd that you are trying so hard
to act as if it isn't.

> @@ -0,0 +1,78 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +==============
> +Page Detective
> +==============
> +
> +Author:
> +Pasha Tatashin <pasha.tatashin@soleen.com>
> +
> +Overview
> +--------
> +
> +Page Detective is a kernel debugging tool designed to provide in-depth
> +information about the usage and mapping of physical memory pages within the
> +Linux kernel. By leveraging the debugfs interface, it enables administrators
> +and developers to investigate the status and allocation of memory pages.
> +
> +This tool is valuable for diagnosing memory-related issues such as checksum
> +errors during live migration, filesystem journal failures, segmentation faults,
> +and other forms of corruption.
> +
> +Functionality
> +-------------
> +
> +Page Detective operates by accepting input through its debugfs interface files
> +located in ``/sys/kernel/debug/page_detective`` directory:
> +
> + * virt: Takes input in the format <pid> <virtual address>. It resolves the
> +   provided virtual address within the specified process's address space and
> +   outputs comprehensive information about the corresponding physical page's
> +   mapping and usage.
> +
> + * phys: Takes a raw physical address as input. It directly investigates the
> +   usage of the specified physical page and outputs relevant information.
> +
> +The output generated by Page Detective is delivered through kernel log messages
> +(accessible using dmesg).

Everything is entirely racey and anything you output might only be partially
populated at any given time due to racing page faults. You definitely need to
mention this.

> +
> +Usage
> +-----
> +
> +- Enable Page Detective: Ensure the CONFIG_PAGE_DETECTIVE kernel configuration
> +  option is enabled.
> +
> +- Access debugfs: Mount the debugfs filesystem (if not already mounted):
> +  ``mount -t debugfs nodev /sys/kernel/debug``
> +
> +- Interact with Page Detective through one of two interfaces:
> +  ``echo "<pid> <virtual address>" > /sys/kernel/debug/page_detective/virt``
> +  ``echo "<physical address>" > /sys/kernel/debug/page_detective/phys``
> +
> +- The file page detective interface is accessible only to users with
> +  CAP_SYS_ADMIN.
> +
> +Example
> +-------
> +
> +```
> +# echo 0x1078fb000 > /sys/kernel/debug/page_detective/phys
> +Page Detective: Investigating physical[105bafc50] pfn[105baf]
> +Page Detective: metadata for Small Page pfn[105baf] folio[ffffea000416ebc0] order [0]
> +Page Detective: page: refcount:1 mapcount:1 mapping:0000000000000000 index:0x7fffffffb pfn:0x105baf
> +Page Detective: memcg:ffff888106189000
> +Page Detective: anon flags: 0x200000000020828(uptodate|lru|owner_2|swapbacked|node=0|zone=2)
> +Page Detective: raw: 0200000000020828 ffffea000416ec08 ffffea000416e7c8 ffff888106382bc9
> +Page Detective: raw: 00000007fffffffb 0000000000000000 0000000100000000 ffff888106189000
> +Page Detective: memcg: [/system.slice/system-serial\x2dgetty.slice/serial-getty@ttyS0.service ] [/system.slice/system-serial\x2dgetty.slice ] [/system.slice ] [/ ]
> +Page Detective: The page is direct mapped addr[ffff888105baf000] pmd entry[8000000105a001e3]
> +Page Detective: The page is not mapped into kernel vmalloc area
> +Page Detective: The page mapped into kernel page table: 1 times
> +Page Detective: Scanned kernel page table in [0.003353799s]
> +Page Detective: The page contains some data
> +Page Detective: mapped by PID[377] cmd[page_detective_] mm[ffff888101778000] pgd[ffff888100894000] at addr[7ffea333b000] pte[8000000105baf067]
> +Page Detective: vma[ffff888101701aa0] start[7ffea331e000] end[7ffea333f000] flags[0000000000100173] name: [stack]
> +Page Detective: Scanned [16] user page tables in [0.000297744s]
> +Page Detective: The page mapped into user page tables: 1 times
> +Page Detective: Finished investigation of physical[105bafc50]
> +```
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 21fdaa19229a..654d4650670d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17450,6 +17450,13 @@ F:	mm/page-writeback.c
>  F:	mm/readahead.c
>  F:	mm/truncate.c
>
> +PAGE DETECTIVE
> +M:	Pasha Tatashin <pasha.tatashin@soleen.com>
> +L:	linux-kernel@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/misc-devices/page_detective.rst
> +F:	drivers/misc/page_detective.c
> +
>  PAGE POOL
>  M:	Jesper Dangaard Brouer <hawk@kernel.org>
>  M:	Ilias Apalodimas <ilias.apalodimas@linaro.org>
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 3fe7e2a9bd29..2965c3c7cdef 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -492,6 +492,17 @@ config MISC_RTSX
>  	tristate
>  	default MISC_RTSX_PCI || MISC_RTSX_USB
>
> +config PAGE_DETECTIVE
> +	depends on PAGE_TABLE_CHECK
> +	depends on MEMCG
> +	bool "Page Detective"
> +	help
> +	  A debugging tool designed to provide detailed information about the
> +	  usage and mapping of physical memory pages. This tool operates through
> +	  the Linux debugfs interface, providing access to both virtual and
> +	  physical address inquiries. The output is presented via kernel log
> +	  messages.
> +
>  config HISI_HIKEY_USB
>  	tristate "USB GPIO Hub on HiSilicon Hikey 960/970 Platform"
>  	depends on (OF && GPIOLIB) || COMPILE_TEST
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index a9f94525e181..411f17fcde6b 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
>  obj-$(CONFIG_OCXL)		+= ocxl/
>  obj-$(CONFIG_BCM_VK)		+= bcm-vk/
>  obj-y				+= cardreader/
> +obj-$(CONFIG_PAGE_DETECTIVE)	+= page_detective.o
>  obj-$(CONFIG_PVPANIC)   	+= pvpanic/
>  obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> diff --git a/drivers/misc/page_detective.c b/drivers/misc/page_detective.c
> new file mode 100644
> index 000000000000..300064d83dd3
> --- /dev/null
> +++ b/drivers/misc/page_detective.c
> @@ -0,0 +1,808 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +
> +/*
> + * Copyright (c) 2024, Google LLC.
> + * Pasha Tatashin <pasha.tatashin@soleen.com>
> + */
> +#include <linux/ctype.h>
> +#include <linux/debugfs.h>
> +#include <linux/module.h>
> +#include <linux/mm.h>
> +#include <linux/mm_inline.h>
> +#include <linux/slab.h>
> +#include <linux/sched/mm.h>
> +#include <linux/hugetlb.h>
> +#include <linux/pagewalk.h>
> +#include <linux/sched/clock.h>
> +#include <linux/oom.h>
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "Page Detective: " fmt
> +
> +/*
> + * Walk 4T of VA space at a time, in order to periodically release the mmap
> + * lock
> + */
> +#define PD_WALK_MAX_RANGE	BIT(42)

Seems rather arbitrary?

> +
> +/* Synchronizes writes to virt and phys files */
> +static DEFINE_MUTEX(page_detective_mutex);
> +static struct dentry *page_detective_debugfs_dir;
> +
> +static void page_detective_memcg(struct folio *folio)
> +{
> +	struct mem_cgroup *memcg;
> +
> +	if (!folio_try_get(folio))
> +		return;
> +
> +	memcg = get_mem_cgroup_from_folio(folio);
> +	if (memcg) {
> +		pr_info("memcg:");
> +		do {
> +			pr_cont(" [");
> +			pr_cont_cgroup_path(memcg->css.cgroup);
> +			pr_cont(" ]");
> +		} while ((memcg = parent_mem_cgroup(memcg)));
> +		mem_cgroup_put(memcg);
> +		pr_cont("\n");
> +	}
> +	folio_put(folio);
> +}
> +
> +static void page_detective_metadata(unsigned long pfn)
> +{
> +	struct folio *folio = pfn_folio(pfn);
> +	bool hugetlb, trans;
> +	unsigned int order;
> +
> +	if (!folio) {
> +		pr_info("metadata for pfn[%lx] not found\n", pfn);
> +		return;
> +	}
> +
> +	trans = folio_test_large(folio) && folio_test_large_rmappable(folio);
> +	hugetlb = folio_test_hugetlb(folio);
> +	order = folio_order(folio);
> +
> +	pr_info("metadata for %s pfn[%lx] folio[%px] order [%u]\n",
> +		(trans) ? "Transparent Huge Page" : (hugetlb) ? "HugeTLB" :
> +		"Small Page", pfn, folio, order);
> +	dump_page_lvl(KERN_INFO pr_fmt(""), &folio->page);
> +	page_detective_memcg(folio);
> +}
> +
> +struct pd_private_kernel {
> +	unsigned long pfn;
> +	unsigned long direct_map_addr;
> +	bool direct_map;
> +	unsigned long vmalloc_maps;
> +	long maps;
> +};
> +
> +#define ENTRY_NAME(entry_page_size) ({					\
> +	unsigned long __entry_page_size = (entry_page_size);		\
> +									\
> +	(__entry_page_size == PUD_SIZE) ? "pud" :			\
> +	(__entry_page_size == PMD_SIZE) ? "pmd" : "pte";		\
> +})
> +
> +static void pd_print_entry_kernel(struct pd_private_kernel *pr,
> +				  unsigned long pfn_current,
> +				  unsigned long addr,
> +				  unsigned long entry_page_size,
> +				  unsigned long entry)
> +{
> +	unsigned long pfn = pr->pfn;
> +
> +	if (pfn_current <= pfn &&
> +	    pfn < (pfn_current + (entry_page_size >> PAGE_SHIFT))) {
> +		bool v, d;
> +
> +		addr += ((pfn << PAGE_SHIFT) & (entry_page_size - 1));
> +		v = (addr >= VMALLOC_START && addr < VMALLOC_END);
> +		d = (pr->direct_map_addr == addr);
> +
> +		if (v) {
> +			pr_info("The page is mapped in vmalloc addr[%lx] %s entry[%lx]\n",
> +				addr, ENTRY_NAME(entry_page_size), entry);
> +			pr->vmalloc_maps++;
> +		} else if (d) {
> +			pr_info("The page is direct mapped addr[%lx] %s entry[%lx]\n",
> +				addr, ENTRY_NAME(entry_page_size), entry);
> +			pr->direct_map = true;
> +		} else {
> +			pr_info("The page is mapped into kernel addr[%lx] %s entry[%lx]\n",
> +				addr, ENTRY_NAME(entry_page_size), entry);
> +		}
> +
> +		pr->maps++;
> +	}
> +}
> +
> +static int pd_pud_entry_kernel(pud_t *pud, unsigned long addr,
> +			       unsigned long next,
> +			       struct mm_walk *walk)
> +{
> +	pud_t pudval = READ_ONCE(*pud);
> +
> +	cond_resched();
> +	if (!pud_leaf(pudval))
> +		return 0;
> +
> +	pd_print_entry_kernel(walk->private, pud_pfn(pudval), addr,
> +			      PUD_SIZE, pud_val(pudval));
> +
> +	return 0;
> +}
> +
> +static int pd_pmd_entry_kernel(pmd_t *pmd, unsigned long addr,
> +			       unsigned long next,
> +			       struct mm_walk *walk)
> +{
> +	pmd_t pmdval = READ_ONCE(*pmd);
> +
> +	cond_resched();
> +	if (!pmd_leaf(pmdval))
> +		return 0;
> +
> +	pd_print_entry_kernel(walk->private, pmd_pfn(pmdval), addr,
> +			      PMD_SIZE, pmd_val(pmdval));
> +
> +	return 0;
> +}
> +
> +static int pd_pte_entry_kernel(pte_t *pte, unsigned long addr,
> +			       unsigned long next,
> +			       struct mm_walk *walk)
> +{
> +	pte_t pteval = READ_ONCE(*pte);
> +
> +	pd_print_entry_kernel(walk->private, pte_pfn(pteval), addr,
> +			      PAGE_SIZE, pte_val(pteval));
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops pd_kernel_ops = {
> +	.pud_entry = pd_pud_entry_kernel,
> +	.pmd_entry = pd_pmd_entry_kernel,
> +	.pte_entry = pd_pte_entry_kernel,
> +	.walk_lock = PGWALK_RDLOCK
> +};
> +
> +/*
> + * Walk kernel page table, and print all mappings to this pfn, return 1 if
> + * pfn is mapped in direct map, return 0 if not mapped in direct map, and
> + * return -1 if operation canceled by user.
> + */
> +static int page_detective_kernel_map_info(unsigned long pfn,
> +					  unsigned long direct_map_addr)
> +{
> +	struct pd_private_kernel pr = {0};
> +	unsigned long s, e;
> +
> +	pr.direct_map_addr = direct_map_addr;
> +	pr.pfn = pfn;
> +
> +	for (s = PAGE_OFFSET; s != ~0ul; ) {
> +		e = s + PD_WALK_MAX_RANGE;
> +		if (e < s)
> +			e = ~0ul;
> +
> +		if (walk_page_range_kernel(s, e, &pd_kernel_ops, &pr)) {
> +			pr_info("Received a cancel signal from user, while scanning kernel mappings\n");
> +			return -1;
> +		}
> +		cond_resched();
> +		s = e;
> +	}
> +
> +	if (!pr.vmalloc_maps) {
> +		pr_info("The page is not mapped into kernel vmalloc area\n");
> +	} else if (pr.vmalloc_maps > 1) {
> +		pr_info("The page is mapped into vmalloc area: %ld times\n",
> +			pr.vmalloc_maps);
> +	}
> +
> +	if (!pr.direct_map)
> +		pr_info("The page is not mapped into kernel direct map\n");
> +
> +	pr_info("The page mapped into kernel page table: %ld times\n", pr.maps);
> +
> +	return pr.direct_map ? 1 : 0;
> +}
> +
> +/* Print kernel information about the pfn, return -1 if canceled by user */
> +static int page_detective_kernel(unsigned long pfn)
> +{
> +	unsigned long *mem = __va((pfn) << PAGE_SHIFT);
> +	unsigned long sum = 0;
> +	int direct_map;
> +	u64 s, e;
> +	int i;
> +
> +	s = sched_clock();
> +	direct_map = page_detective_kernel_map_info(pfn, (unsigned long)mem);
> +	e = sched_clock() - s;
> +	pr_info("Scanned kernel page table in [%llu.%09llus]\n",
> +		e / NSEC_PER_SEC, e % NSEC_PER_SEC);
> +
> +	/* Canceled by user or no direct map */
> +	if (direct_map < 1)
> +		return direct_map;
> +
> +	for (i = 0; i < PAGE_SIZE / sizeof(unsigned long); i++)
> +		sum |= mem[i];
> +
> +	if (sum == 0)
> +		pr_info("The page contains only zeroes\n");
> +	else
> +		pr_info("The page contains some data\n");
> +
> +	return 0;
> +}
> +
> +static char __vma_name[PATH_MAX];

Having this as an arbitrary static variable at compilation unit scope here is
kind of horrible.

> +static const char *vma_name(struct vm_area_struct *vma)
> +{
> +	const struct path *path;
> +	const char *name_fmt, *name;
> +
> +	get_vma_name(vma, &path, &name, &name_fmt);
> +
> +	if (path) {
> +		name = d_path(path, __vma_name, PATH_MAX);
> +		if (IS_ERR(name)) {
> +			strscpy(__vma_name, "[???]", PATH_MAX);
> +			goto out;
> +		}
> +	} else if (name || name_fmt) {
> +		snprintf(__vma_name, PATH_MAX, name_fmt ?: "%s", name);
> +	} else {
> +		if (vma_is_anonymous(vma))
> +			strscpy(__vma_name, "[anon]", PATH_MAX);
> +		else if (vma_is_fsdax(vma))
> +			strscpy(__vma_name, "[fsdax]", PATH_MAX);
> +		else if (vma_is_dax(vma))
> +			strscpy(__vma_name, "[dax]", PATH_MAX);
> +		else
> +			strscpy(__vma_name, "[other]", PATH_MAX);
> +	}
> +
> +out:
> +	return __vma_name;
> +}

Yeah this is sort of weird, you're establishing a new protocol as to what the
'VMA name' means vs. what we see in /proc/$pid/maps, making a Frakenstein out of
that logic and your own.

I'd prefer we keep this in _one place_ and consistent.

> +
> +static void pd_show_vma_info(struct mm_struct *mm, unsigned long addr)
> +{
> +	struct vm_area_struct *vma = find_vma(mm, addr);
> +
> +	if (!vma) {
> +		pr_info("vma not found for this mapping\n");
> +		return;
> +	}
> +
> +	pr_info("vma[%px] start[%lx] end[%lx] flags[%016lx] name: %s\n",
> +		vma, vma->vm_start, vma->vm_end, vma->vm_flags, vma_name(vma));
> +}
> +
> +static void pd_get_comm_pid(struct mm_struct *mm, char *comm, int *pid)
> +{
> +	struct task_struct *task;
> +
> +	rcu_read_lock();
> +	task = rcu_dereference(mm->owner);
> +	if (task) {
> +		strscpy(comm, task->comm, TASK_COMM_LEN);
> +		*pid = task->pid;
> +	} else {
> +		strscpy(comm, "__ exited __", TASK_COMM_LEN);
> +		*pid = -1;
> +	}
> +	rcu_read_unlock();
> +}
> +
> +struct pd_private_user {
> +	struct mm_struct *mm;
> +	unsigned long pfn;
> +	long maps;
> +};
> +
> +static void pd_print_entry_user(struct pd_private_user *pr,
> +				unsigned long pfn_current,
> +				unsigned long addr,
> +				unsigned long entry_page_size,
> +				unsigned long entry,
> +				bool is_hugetlb)
> +{
> +	unsigned long pfn = pr->pfn;
> +
> +	if (pfn_current <= pfn &&
> +	    pfn < (pfn_current + (entry_page_size >> PAGE_SHIFT))) {
> +		char comm[TASK_COMM_LEN];
> +		int pid;
> +
> +		pd_get_comm_pid(pr->mm, comm, &pid);
> +		addr += ((pfn << PAGE_SHIFT) & (entry_page_size - 1));
> +		pr_info("%smapped by PID[%d] cmd[%s] mm[%px] pgd[%px] at addr[%lx] %s[%lx]\n",
> +			is_hugetlb ? "hugetlb " : "",
> +			pid, comm, pr->mm, pr->mm->pgd, addr,
> +			ENTRY_NAME(entry_page_size), entry);
> +		pd_show_vma_info(pr->mm, addr);
> +		pr->maps++;
> +	}
> +}
> +
> +static int pd_pud_entry_user(pud_t *pud, unsigned long addr, unsigned long next,
> +			     struct mm_walk *walk)
> +{
> +	pud_t pudval = READ_ONCE(*pud);

This should be pudp_get().

> +
> +	cond_resched();
> +	if (!pud_user_accessible_page(pudval))
> +		return 0;
> +
> +	pd_print_entry_user(walk->private, pud_pfn(pudval), addr, PUD_SIZE,
> +			    pud_val(pudval), false);
> +	walk->action = ACTION_CONTINUE;
> +
> +	return 0;
> +}
> +
> +static int pd_pmd_entry_user(pmd_t *pmd, unsigned long addr, unsigned long next,
> +			     struct mm_walk *walk)
> +{
> +	pmd_t pmdval = READ_ONCE(*pmd);

This should be pmdp_get().

> +
> +	cond_resched();
> +	if (!pmd_user_accessible_page(pmdval))
> +		return 0;
> +
> +	pd_print_entry_user(walk->private, pmd_pfn(pmdval), addr, PMD_SIZE,
> +			    pmd_val(pmdval), false);
> +	walk->action = ACTION_CONTINUE;
> +
> +	return 0;
> +}
> +
> +static int pd_pte_entry_user(pte_t *pte, unsigned long addr, unsigned long next,
> +			     struct mm_walk *walk)
> +{
> +	pte_t pteval = READ_ONCE(*pte);

This should be ptep_get().

> +
> +	if (!pte_user_accessible_page(pteval))
> +		return 0;
> +
> +	pd_print_entry_user(walk->private, pte_pfn(pteval), addr, PAGE_SIZE,
> +			    pte_val(pteval), false);
> +	walk->action = ACTION_CONTINUE;
> +
> +	return 0;
> +}
> +
> +static int pd_hugetlb_entry(pte_t *pte, unsigned long hmask, unsigned long addr,
> +			    unsigned long next, struct mm_walk *walk)
> +{
> +	pte_t pteval = READ_ONCE(*pte);

This should be ptep_get().

> +
> +	cond_resched();

Do we really want to cond_resched() with mmap lock held on possibly every single
process in the system?

> +	pd_print_entry_user(walk->private, pte_pfn(pteval), addr, next - addr,
> +			    pte_val(pteval), true);
> +	walk->action = ACTION_CONTINUE;
> +
> +	return 0;
> +}
> +
> +static const struct mm_walk_ops pd_user_ops = {
> +	.pud_entry = pd_pud_entry_user,
> +	.pmd_entry = pd_pmd_entry_user,
> +	.pte_entry = pd_pte_entry_user,
> +	.hugetlb_entry = pd_hugetlb_entry,
> +	.walk_lock = PGWALK_RDLOCK
> +};
> +
> +/*
> + * print information about mappings of pfn by mm, return -1 if canceled
> + * return number of mappings found.
> + */
> +static long page_detective_user_mm_info(struct mm_struct *mm, unsigned long pfn)
> +{
> +	struct pd_private_user pr = {0};
> +	unsigned long s, e;

These variables names are really terrible. I have no idea what 's' or 'e' are
supposed to be.

> +
> +	pr.pfn = pfn;
> +	pr.mm = mm;
> +
> +	for (s = 0; s != TASK_SIZE; ) {
> +		e = s + PD_WALK_MAX_RANGE;
> +		if (e > TASK_SIZE || e < s)
> +			e = TASK_SIZE;
> +
> +		if (mmap_read_lock_killable(mm)) {
> +			pr_info("Received a cancel signal from user, while scanning user mappings\n");
> +			return -1;
> +		}
> +		walk_page_range(mm, s, e, &pd_user_ops, &pr);
> +		mmap_read_unlock(mm);
> +		cond_resched();
> +		s = e;
> +	}
> +	return pr.maps;
> +}
> +
> +/*
> + * Report where/if PFN is mapped in user page tables, return -1 if canceled
> + * by user.
> + */
> +static int page_detective_usermaps(unsigned long pfn)
> +{
> +	struct task_struct *task, *t;
> +	struct mm_struct **mm_table, *mm;
> +	unsigned long proc_nr, mm_nr, i;
> +	bool canceled_by_user;
> +	long maps, ret;
> +	u64 s, e;
> +
> +	s = sched_clock();
> +	/* Get the number of processes currently running */
> +	proc_nr = 0;
> +	rcu_read_lock();
> +	for_each_process(task)
> +		proc_nr++;
> +	rcu_read_unlock();

Was going to say is this racy, but I see you expect races below...

> +
> +	/* Allocate mm_table to fit mm from every running process */
> +	mm_table = kvmalloc_array(proc_nr, sizeof(struct mm_struct *),
> +				  GFP_KERNEL);
> +
> +	if (!mm_table) {
> +		pr_info("No memory to traverse though user mappings\n");
> +		return 0;
> +	}
> +
> +	/* get mm from every processes and copy its pointer into mm_table */

Typo but also this seems a bit crazy...

> +	mm_nr = 0;
> +	rcu_read_lock();
> +	for_each_process(task) {

Including kernel threads?

> +		if (mm_nr == proc_nr) {
> +			pr_info("Number of processes increased while scanning, some will be skipped\n");
> +			break;
> +		}

Hmmm... is this even useful? Surely you'd want to try again or give up after a while?

> +
> +		t = find_lock_task_mm(task);
> +		if (!t)
> +			continue;

We just give if this fails?

> +
> +		mm = task->mm;
> +		if (!mm || !mmget_not_zero(mm)) {
> +			task_unlock(t);
> +			continue;
> +		}
> +		task_unlock(t);
> +
> +		mm_table[mm_nr++] = mm;

OK wait, so we get a reference on the mm of _every task_ in the system? What??

This seems pretty unwise...

> +	}
> +	rcu_read_unlock();
> +
> +	/* Walk through every user page table,release mm reference afterwards */
> +	canceled_by_user = false;
> +	maps = 0;
> +	for (i = 0; i < mm_nr; i++) {
> +		if (!canceled_by_user) {
> +			ret = page_detective_user_mm_info(mm_table[i], pfn);
> +			if (ret == -1)
> +				canceled_by_user = true;
> +			else
> +				maps += ret;
> +		}
> +		mmput(mm_table[i]);
> +		cond_resched();
> +	}
> +
> +	kvfree(mm_table);
> +
> +	e = sched_clock() - s;
> +	pr_info("Scanned [%ld] user page tables in [%llu.%09llus]\n",
> +		mm_nr, e / NSEC_PER_SEC, e % NSEC_PER_SEC);
> +	pr_info("The page mapped into user page tables: %ld times\n", maps);
> +
> +	return canceled_by_user ? -1 : 0;
> +}
> +
> +static void page_detective_iommu(unsigned long pfn)
> +{
> +}
> +
> +static void page_detective_tdp(unsigned long pfn)
> +{
> +}

Not sure it's really meaningful to just have empty placeholders like this?

> +
> +static void page_detective(unsigned long pfn)
> +{
> +	if (!pfn_valid(pfn)) {
> +		pr_info("pfn[%lx] is invalid\n", pfn);
> +		return;
> +	}
> +
> +	if (pfn == 0) {
> +		pr_info("Skipping look-up for pfn[0] mapped many times into kernel page table\n");
> +		return;
> +	}
> +
> +	/* Report metadata information */
> +	page_detective_metadata(pfn);
> +
> +	/*
> +	 * Report information about kernel mappings, and basic content
> +	 * information: i.e. all zero or not.
> +	 */
> +	if (page_detective_kernel(pfn) < 0)
> +		return;
> +
> +	/* Report where/if PFN is mapped in user page tables */
> +	if (page_detective_usermaps(pfn) < 0)
> +		return;
> +
> +	/* Report where/if PFN is mapped in IOMMU page tables */
> +	page_detective_iommu(pfn);
> +
> +	/* Report where/if PFN is mapped in 2 dimensional paging */
> +	page_detective_tdp(pfn);
> +}
> +
> +static u64 pid_virt_to_phys(unsigned int pid, unsigned long virt_addr)
> +{

I mean no no no no. NO.

Not another page table walker. Please. We HAVE SO MANY ALREADY. Let alone one
outside of mm.

This just feels like going to enormous lengths to put mm logic in a driver, for
some reason.

> +	unsigned long phys_addr = -1;
> +	struct task_struct *task;
> +	struct mm_struct *mm;
> +	pgd_t *pgd, pgdval;
> +	p4d_t *p4d, p4dval;
> +	pud_t *pud, pudval;
> +	pmd_t *pmd, pmdval;
> +	pte_t *pte, pteval;
> +
> +	if (virt_addr >= TASK_SIZE) {
> +		pr_err("%s: virt_addr[%lx] is above TASK_SIZE[%lx]\n",
> +		       __func__, virt_addr, TASK_SIZE);
> +		return -1;
> +	}
> +
> +	/* Find the task_struct using the PID */
> +	task = find_get_task_by_vpid(pid);
> +	if (!task) {
> +		pr_err("%s: Task not found for PID %d\n", __func__, pid);
> +		return -1;
> +	}
> +
> +	mm = get_task_mm(task);
> +	put_task_struct(task);
> +	if (!mm) {
> +		pr_err("%s: PID %d, can't get mm reference\n", __func__, pid);
> +		return -1;
> +	}
> +
> +	if (mmap_read_lock_killable(mm)) {
> +		pr_info("Received a cancel signal from user, while convirting virt to phys\n");
> +		mmput(mm);
> +		return -1;
> +	}
> +
> +	pgd = pgd_offset(mm, virt_addr);
> +	pgdval = READ_ONCE(*pgd);
> +	if (!pgd_present(pgdval) || unlikely(pgd_bad(pgdval))) {
> +		pr_err("%s: pgd[%llx] present[%d] bad[%d]\n", __func__,
> +		       (u64)pgd_val(pgdval), pgd_present(pgdval),
> +		       pgd_bad(pgdval));
> +		goto putmm_exit;
> +	}
> +
> +	p4d = p4d_offset(pgd, virt_addr);
> +	p4dval = READ_ONCE(*p4d);
> +	if (!p4d_present(p4dval) || unlikely(p4d_bad(p4dval))) {
> +		pr_err("%s: p4d[%llx] present[%d] bad[%d]\n", __func__,
> +		       (u64)p4d_val(p4dval), p4d_present(p4dval),
> +		       p4d_bad(p4dval));
> +		goto putmm_exit;
> +	}
> +
> +	pud = pud_offset(p4d, virt_addr);
> +	pudval = READ_ONCE(*pud);
> +	if (!pud_present(pudval)) {
> +		pr_err("%s: pud[%llx] present[%d]\n", __func__,
> +		       (u64)pud_val(pudval), pud_present(pudval));
> +		goto putmm_exit;
> +	}
> +
> +	if (pud_leaf(pudval)) {
> +		phys_addr = (pud_pfn(pudval) << PAGE_SHIFT)
> +			| (virt_addr & ~PUD_MASK);
> +		goto putmm_exit;
> +	}
> +
> +	pmd = pmd_offset(pud, virt_addr);
> +	pmdval = READ_ONCE(*pmd);
> +	if (!pmd_present(pmdval)) {
> +		pr_err("%s: pmd[%llx] present[%d]\n", __func__,
> +		       (u64)pmd_val(pmdval), pmd_present(pmdval));
> +		goto putmm_exit;
> +	}
> +
> +	if (pmd_leaf(pmdval)) {
> +		phys_addr = (pmd_pfn(pmdval) << PAGE_SHIFT)
> +			| (virt_addr & ~PMD_MASK);
> +		goto putmm_exit;
> +	}
> +
> +	pte = pte_offset_kernel(pmd, virt_addr);
> +	pteval = READ_ONCE(*pte);
> +	if (!pte_present(pteval)) {
> +		pr_err("%s: pte[%llx] present[%d]\n", __func__,
> +		       (u64)pte_val(pteval), pte_present(pteval));
> +		goto putmm_exit;
> +	}
> +
> +	phys_addr = pte_pfn(*pte) << PAGE_SHIFT;
> +
> +putmm_exit:
> +	mmap_read_unlock(mm);
> +	mmput(mm);
> +	return phys_addr;
> +}
> +
> +static ssize_t page_detective_virt_write(struct file *file,
> +					 const char __user *data,
> +					 size_t count, loff_t *ppos)
> +{
> +	char *input_str, *pid_str, *virt_str;
> +	unsigned int pid, err, i;
> +	unsigned long virt_addr;
> +	u64 phys_addr;
> +
> +	/* If canceled by user simply return without printing anything */
> +	err = mutex_lock_killable(&page_detective_mutex);
> +	if (err)
> +		return count;
> +
> +	input_str = kzalloc(count + 1, GFP_KERNEL);
> +	if (!input_str) {
> +		pr_err("%s: Unable to allocate input_str buffer\n",
> +		       __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return -EAGAIN;

Feels like you could do with some good old fashioned C goto error handling since
you duplicate this mutex unlock repeatedly...

> +	}
> +
> +	if (copy_from_user(input_str, data, count)) {
> +		kfree(input_str);
> +		pr_err("%s: Unable to copy user input into virt file\n",
> +		       __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return -EFAULT;
> +	}
> +
> +	virt_str = NULL;
> +	pid_str = input_str;
> +	for (i = 0; i < count - 1; i++) {
> +		if (isspace(input_str[i])) {
> +			input_str[i] = '\0';
> +			virt_str = &input_str[i + 1];
> +			break;
> +		}
> +	}
> +
> +	if (!virt_str) {
> +		kfree(input_str);
> +		pr_err("%s: Invalid virt file input, should be: '<pid> <virtual address>'\n",
> +		       __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return -EINVAL;
> +	}
> +
> +	err = kstrtouint(pid_str, 0, &pid);
> +	if (err) {
> +		kfree(input_str);
> +		pr_err("%s: Failed to parse pid\n", __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return err;
> +	}
> +
> +	err = kstrtoul(virt_str, 0, &virt_addr);
> +	if (err) {
> +		kfree(input_str);
> +		pr_err("%s: Failed to parse virtual address\n", __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return err;
> +	}
> +
> +	kfree(input_str);
> +
> +	phys_addr = pid_virt_to_phys(pid, virt_addr);
> +	if (phys_addr == -1) {
> +		pr_err("%s: Can't translate virtual to physical address\n",
> +		       __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return -EINVAL;
> +	}
> +
> +	pr_info("Investigating pid[%u] virtual[%lx] physical[%llx] pfn[%lx]\n",
> +		pid, virt_addr, phys_addr, PHYS_PFN(phys_addr));
> +	page_detective(PHYS_PFN(phys_addr));
> +	pr_info("Finished investigation of virtual[%lx]\n", virt_addr);
> +	mutex_unlock(&page_detective_mutex);
> +
> +	return count;
> +}
> +
> +static ssize_t page_detective_phys_write(struct file *file,
> +					 const char __user *data,
> +					 size_t count, loff_t *ppos)
> +{
> +	u64 phys_addr;
> +	int err;
> +
> +	/* If canceled by user simply return without printing anything */
> +	err = mutex_lock_killable(&page_detective_mutex);
> +	if (err)
> +		return count;
> +
> +	err = kstrtou64_from_user(data, count, 0, &phys_addr);
> +
> +	if (err) {
> +		pr_err("%s: Failed to parse physical address\n", __func__);
> +		mutex_unlock(&page_detective_mutex);
> +		return err;
> +	}
> +
> +	pr_info("Investigating physical[%llx] pfn[%lx]\n", phys_addr,
> +		PHYS_PFN(phys_addr));
> +	page_detective(PHYS_PFN(phys_addr));
> +	pr_info("Finished investigation of physical[%llx]\n", phys_addr);
> +	mutex_unlock(&page_detective_mutex);
> +
> +	return count;
> +}
> +
> +static int page_detective_open(struct inode *inode, struct file *file)
> +{
> +	/* Deny access if not CAP_SYS_ADMIN */
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	return simple_open(inode, file);
> +}
> +
> +static const struct file_operations page_detective_virt_fops = {
> +	.owner = THIS_MODULE,
> +	.open = page_detective_open,
> +	.write = page_detective_virt_write,
> +};
> +
> +static const struct file_operations page_detective_phys_fops = {
> +	.owner = THIS_MODULE,
> +	.open = page_detective_open,
> +	.write = page_detective_phys_write,
> +};
> +
> +static int __init page_detective_init(void)
> +{
> +	page_detective_debugfs_dir = debugfs_create_dir("page_detective", NULL);
> +
> +	debugfs_create_file("virt", 0200, page_detective_debugfs_dir, NULL,
> +			    &page_detective_virt_fops);
> +	debugfs_create_file("phys", 0200, page_detective_debugfs_dir, NULL,
> +			    &page_detective_phys_fops);
> +
> +	return 0;
> +}
> +module_init(page_detective_init);
> +
> +static void page_detective_exit(void)
> +{
> +	debugfs_remove_recursive(page_detective_debugfs_dir);
> +}
> +module_exit(page_detective_exit);
> +
> +MODULE_DESCRIPTION("Page Detective");
> +MODULE_VERSION("1.0");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Pasha Tatashin <pasha.tatashin@soleen.com>");
> --
> 2.47.0.338.g60cca15819-goog
>

