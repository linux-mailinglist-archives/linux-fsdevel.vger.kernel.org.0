Return-Path: <linux-fsdevel+bounces-64430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E919BE7AAB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F19D0540542
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470293161B2;
	Fri, 17 Oct 2025 09:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h9tfKfc0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PMYi1R6q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E062D877F;
	Fri, 17 Oct 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692276; cv=fail; b=kiRzl2rjnrS5ae6WU5io0cEeKWXcjhzuCrfCQDJWu+xitn8PF1mk3AaOTQcLtooFx8Uv8JQtEWy/Q9V5hQh7DJzq1QVVeP8RXxldJc8NCMYiQc8Wcu3iD/VX3ByNkbTWuyEkZs8wY/N+h7V4W694jGnJiF1isy/j/1FrArFJGBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692276; c=relaxed/simple;
	bh=A2ARcCDUVO4yKbGW+g0rJOlUNiQltoYBu/XFuvAkuHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZoBDVP9p6aMq7OjnHF+ndTJbgrDvQUCXUyV3rVOiNZ+OIcIlz5XUFAXn7C9/04SC3yPl2uatUNp+4924brqWRw5KcCMmCd6GACB00NP4tIf+ZwXJA+/FF65hOwM1h237E5An+31hnIAL4K0a/YgtNZNnnBojBx2uxLSeovlMsmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h9tfKfc0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PMYi1R6q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uc1T021087;
	Fri, 17 Oct 2025 09:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dAPSVXptXMUJQto8Iz
	GuVXhjgZqArNGT6m3k8qQFaVU=; b=h9tfKfc0SNXvX8smqdnnW2nZrDsZ4zDDhx
	qMDDhOs1eHahV9N2ELA5XbJN+IRdPYJ1OFvcPXFA6nKL56vt0mFTgTTuJlOlXPpA
	pomXrS2iN6+FeEMNagrsxrL6JdU0/Q/xNe/QezvT0RKQGAN0kU5qFq/59DWupX5K
	baO4w7lG8G1/gE8YijSWk55dWEILPmDNeuQxTutgTlu8rnXpJGApYNqjxu3/EZ4+
	vv+spp3O3qXLLP6LE6tLHvhZ7OtzyFeDvKTHfsO/Bl1Qnvr2y1RU5WURXh7p3hKc
	9uHwvFnAEB8+oF8ZUCLDGjcvq5+W1yauPmVHwF9dZ1Dfd8gBXgPg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qhnje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:10:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6wlRD024919;
	Fri, 17 Oct 2025 09:10:10 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013005.outbound.protection.outlook.com [40.107.201.5])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcu5da-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:10:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uGVDjNYOCtgza5lnN8NkMOJpW7DwFbmweU6rtTfZILoe9be9JDsabPiuaRFqQvqJ8H4CcFtXESjrrSBpO3DBZvKAdMixn7m5ICxiBUT4nl64Ai2FKDnmQyE+iz8NolTCRWIeDn/VfzetTtF3GXjlXnxua0hmJy5q1hRfDRWuBq/Bpps594AaFqv89MhpVyTVXG97vB4bd7dAffVikhMm2uWVjz0MWtLjJkOdK3EBwxUPZYyBgqhSPYNMTVnwNRCsT1ipgLR2bha4kJ9uA4tDZylp+J5BqWBxKgTJTkbq/OQw2DRW68vc/nGgP7Jvu29/rPfniNXYEdy2JwyzHseJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAPSVXptXMUJQto8IzGuVXhjgZqArNGT6m3k8qQFaVU=;
 b=ly78xgRRsrWCe8CaTOjW+JU8dL4tdB4y4vUPMA+ebmDcHdjoO6nzqdlT93nYmWbJ/0YWwatuoq3Pxnp/hiMUSEXQQbKR76yus6namXyoKY8gp6cvPpVNUJW6Q6fZWRP3BDgdrHUk+s6tw7SMm1mKrQevs7JPBDeDT1XkUG8P0pjdqFWoAGAfS8Tl5NCB9FU98fet/Anbm/gyhvVJ6SZ84nQy3LFVsoJXiHYGZAcMu/ttEEXPKDdSkpEdO4cbF2ARygNti7IW1IfaCaeF14geX8MKxLELPgxcytcUcwZKq5yagHr1PiKo2Owz2lowGAvRCj8+9IUW9zTySH7Nwl6afw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dAPSVXptXMUJQto8IzGuVXhjgZqArNGT6m3k8qQFaVU=;
 b=PMYi1R6qy47X/Xxk6iSTPuqSYJRPs+o+9oYtZKaJdeh3vvBcpovr3xJTYD6PQYDeHWIQaSq7whcTDPqHXxgmGAv4qDpeTZyfvTgSPOVsPnc8yrW239bdXQQx3/Q1jHmNlTI8+X5h1KrLSdJwcHO06eGNF+wpbCgBKQqzPucWORA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB7351.namprd10.prod.outlook.com (2603:10b6:208:3dd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Fri, 17 Oct
 2025 09:10:06 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:10:06 +0000
Date: Fri, 17 Oct 2025 10:10:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
        david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, mcgrof@kernel.org,
        nao.horiguchi@gmail.com, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <9567b456-5656-4a48-a826-332417d76585@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
 <20251016135924.6390f12b04ead41d977102ec@linux-foundation.org>
 <E88B5579-DE01-4F33-B666-CC29F32EEF70@nvidia.com>
 <16b10383-1d3a-428c-918a-3bbf1f9f495d@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16b10383-1d3a-428c-918a-3bbf1f9f495d@lucifer.local>
X-ClientProxiedBy: LO4P265CA0195.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a453f20-8322-467e-8452-08de0d5cf713
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ESOUzJkiTuQik8SgC25N2tjp++eG2luIBDp+RKzxzS1HT4BlUD9p5T4mOs66?=
 =?us-ascii?Q?hMumqUD40Uh92b8flZ6tzewm9tD+YsySSXivjmesCMHhhXZVshbmwofcOunf?=
 =?us-ascii?Q?WMdlfAlk38us6M6OwPwBiDmVrckW0wnkaMcgfIKWtmhjb43SPgE6rXaQePUt?=
 =?us-ascii?Q?MLQieajplu/NWheEWZ8XSnK/joQ1E+930nIYDgxl4h+LqWSDCeRx75eoYKEJ?=
 =?us-ascii?Q?/zy+esEGKAddvQqXhJbgIqQJXyyIzpPYOKIM9knI7WAo0GugUI7LEz9JQ5Ed?=
 =?us-ascii?Q?6ij/vZ4nqcMQ948JW0ng4vJkEojLaS7vrOyspgs6Tj/RQAJcpuIsrBn2hVn0?=
 =?us-ascii?Q?hQ9TKMZqOD24/YpkSxqJrG+Pk3LuluS+jf/0IXYHGfoLP2F3gIj9PhJDzFYf?=
 =?us-ascii?Q?9WpUhQEUdbqHOmTjJ22CqYrFnQwTwjchD5GHsf0QtiH02i4cOWasvx12/HKG?=
 =?us-ascii?Q?KxwvGdo+eh+9vdbiLjBJSY6nOnDxetB2G8TkzKhZlvRzLaXJqJWOv3gSb1B5?=
 =?us-ascii?Q?wk0xY+UeuBlgtdVQfbgugtDsSg2UcJELkQ20HaJ7vbJ/30DC1mIy1FSBsT3a?=
 =?us-ascii?Q?Uro/6V7mbMztQGRmqqqxbyLNB/KkxJ40ohLeT4BPIEukI5R/6SEV/el00l8R?=
 =?us-ascii?Q?TMhR8IHJ/6S30BG5wF1upg3V/JCe3zX3koHHeScV/pw8EfPOeB+YGqWb3bv9?=
 =?us-ascii?Q?Z0t5837b6TBim8h3HYB32O5SGknhKfnznjjd/zX45ard+SCp2WK2xJ5fe7Mr?=
 =?us-ascii?Q?DpYlsh76xSIR5eNWWgqOPL7+cgIUFueYBm2hYi7gK1BpLbIGmMRemKda4WfS?=
 =?us-ascii?Q?kZ1ZETErWcdtsObv60Y+r8XjYDXbYpyxg40YqhkYBVPbyaD5qNSZvKmuUOFP?=
 =?us-ascii?Q?Cq2ST78YnnwVT98jdDUXuxzBn3XyZc5PY9UlkZUDjkJp7ZQKa/bpUjFaShct?=
 =?us-ascii?Q?pfPvybdB5RpsJE+jnh3qHnxXpMeqceb7eDc1/qsTnH7TWGQTv/kGkTL5DDSG?=
 =?us-ascii?Q?laf2PTUrjix+3iuboBQJnFQAYBEjrKFPGFt0JHIdGVRfWEqJOoAPPyu9u33+?=
 =?us-ascii?Q?o/rX7i0O7k1l1U1YK1F2pAH0ezY2VUlscO7mcbKaY9/koYk+AiIwMRXn+8Md?=
 =?us-ascii?Q?XuXOOQIlXhENm1E31HOp423PhFxkVvxqPsr3opzPpHJxFdl5x+LKA2TDHrlj?=
 =?us-ascii?Q?vjRoQeFZQ7oScHystWkc+NfCPrTpl6Vjs7wQb7XNCMbH8VpbWAX7uXdSBPtV?=
 =?us-ascii?Q?uN2y98Vu0rwGMhnqiRxGYCDmzkAcAWFVjvbn3M8IUlHXWajCmCqwSophhXEp?=
 =?us-ascii?Q?yAOGy/sRC86MljMY9ufc5hgxXrHXZjHQhwBDLGbKUy05iXxfeCQInw6HPXwn?=
 =?us-ascii?Q?rfpSS8n+EgDDP1MTcU/UQ+K2gC50gscwifCksDeJ4g3Hvo/7Q8rzgtUgggu4?=
 =?us-ascii?Q?qCQpnlFGnBo+DhJKDN5lBwIE5uz4bSoD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t4581mQ7a9ybyYZ3wMY3L7DWX3c2tF4Uw7mJc1PS835PPmmkloWt7IQP+tvO?=
 =?us-ascii?Q?aIZn+qiUb3oSZ+FODwKWKIiLn94nPUmziwWz00fcNvDsWNxuVaPpOsI43VkO?=
 =?us-ascii?Q?EsXb/N+O7Ujrxr4UizTPSOtxCi46KivGggOEY4dPiMrAQU8tMJI3j6tZiI+s?=
 =?us-ascii?Q?pjTvIlrf2n55Ya6PGhZzEor5SydZIvCSuRkpKBlLdNtAo1jPYn+omsRdmEQE?=
 =?us-ascii?Q?cAA59jglYE0YQlGpgjMW2Su1vPjCEmSDjnadGvcQhaOCxaV6yWlD6T29rxEa?=
 =?us-ascii?Q?IVfENhKF7ss3LyrneP/5LQRUNSOCZGGNchXvc3pWcWVD9cjIPT9OlWMBGHYq?=
 =?us-ascii?Q?GnLwpAJckNM7qGx3ohBUaklJXImusxORHaf9TwSERmqUTEPua0YQBMpPPOT4?=
 =?us-ascii?Q?6trCjeTZvHDhAQZxyzJoRwcmy/ZU+Cbd9dqcDuxbqI4DqPgViSa/oOtf0JAo?=
 =?us-ascii?Q?elggzoPheLURI/BvyESJ1dvXupRccJ7lHIFg+0LR4RaHYYRwV2WecbPNM3NB?=
 =?us-ascii?Q?sg9M06XrhqgJw0BOymKc/jm0+oJol+keJuMWIXkyuEUOj4+ghV2LvBl6n2kz?=
 =?us-ascii?Q?dXSAwXW3eG0lFp+d70zRfqVb6GZBmie/S9aZGxROyBYtAGqtc6qoPU9QP5Jt?=
 =?us-ascii?Q?/YRa8BvcsOy7ViuS8BZl5gM22L5WlI8IjMcnMvECQiIWx3Ruh3kFXEPB9xVF?=
 =?us-ascii?Q?ehp6F9wNwjy6J9sxLD1ap+6y3dWTlKGmKdyUv21OxSWd/9jMzNnQoicSFvR1?=
 =?us-ascii?Q?1YlQK6cndz7Qrs0Qp6VH6auuoxUTvvKR8AXBVjWDGroBdlEMCnZ5P1J/yR6J?=
 =?us-ascii?Q?ZaEpYhIPdaHV/5qhU/HcanhNm96lhZglawIe4krE1e0QVyNXfvXgsC6SbZyU?=
 =?us-ascii?Q?fbwOXq8Falcwf77PCzLaS7RsgR1WuNRyEj3FmG2OVXMMK4/n3aaeVM1eqoWq?=
 =?us-ascii?Q?paykOVWqJcRELZvxjXEMb0dqB0TABoexzXhswid4tGboqZH1I22t7QA4oyik?=
 =?us-ascii?Q?Oskdt4w20sUVLqKgvuIYFjAAORoU6j3pZMnvsY5zelhjwmwu3NqFhNIAkp6s?=
 =?us-ascii?Q?VuXkKLO2hp0xEAAVTGEP9rPw7SdFMlWSarAxK1ygrCdwwIG0WoP9pNhFVh7J?=
 =?us-ascii?Q?NgD7jqv1V3NtOav2/BuDmo+QFk0oTMxiGBaMonVtIesIat6CViuoGNLAGYO7?=
 =?us-ascii?Q?DtKJHiF7M6JlftQeOVZhiXvbEy27DpJEhkgJYm4g7O5FiYeGXFUOSWZQOdLh?=
 =?us-ascii?Q?7n+WEnJ0jhQ6LWleB0pUADxrCDlV1aN1vmtX64CmgnbZBNLQm1gY5EHZDLWM?=
 =?us-ascii?Q?fqYHYa06JEGeDrflZF9Gk2AWbY9nNNZTvuhjaghBkYNliK0tx1f501XLtxSa?=
 =?us-ascii?Q?8m+i1QB62U8yJdc9LC8g7dAiyR5E9ADv8JLGmxega7UDuotlnsuW4O7sBdGW?=
 =?us-ascii?Q?AZyfudIiM3eib54vJM+ZR+aWr/X2ypa8x+T9abGeNJcUUH9a+tEB/X9BDU/C?=
 =?us-ascii?Q?n7TAaXaTKlgh/E0Gu0N42riVZfvPS2fluaeK0aJMwMQNUGgFPUihmqPg4Gmh?=
 =?us-ascii?Q?qC8zytUYBopUfgGd4sOUTh3ZBHZVGx0ux1aiUb1V7XeJWFMRU49yKlW5hwLa?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0LKI61xUzf3z8Tf28ALj+lWNDRR940UKLUDA3p5wK743v87taLc1+tUV0cqw58ipRDEoy6wuVKlqsLnw3mCIvpT76aT/CihLfEVK3f/44OWKJsUPIorZD1xGdisDgMgTMhRO4Eb5pw6+lkQQf3+H8AfTbeX0WNNNf3JtmgfPDs4/MSMa/HRGapGjYVN4SaIrJ+eh6ITq2zgBe3/xl3q7aEXUSep7GeB50aRXoTgBruVpFP8oxUV2QhZwXrbWTllAGLufYpMgDxs+Nc71Q3urrIW+Df5MOzQ8E7bIUTyzPlQJ/ckrxV/6LmKY8P5TEk0wR8cl3zKV6MrhGAJ4FXhUqJDTFMVCFXsl+//v7DPAkcFw0CdVhEUmEt2Etis+vderNx/MMt823BNY5NfXSVeM2vTEFS9t0ATPephSpcdWV5kmtvbrXPWpBtDHmKSmQuq5M07pzoK5/npHAPIPdVk22e7AuGI8Yir/FKAHpVVjb7D9xnaZpk4RwdxM0qu3e43SO+rghTXliZKqPB1FSCLBPq/P08MoolXhqXXODdER+RmVGccpaisn/32kDv0GL2a1oUuX0LfAi4JZMfbB6XArf9f2iWkx+UeJtfyWOaCUWGc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a453f20-8322-467e-8452-08de0d5cf713
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:10:06.7182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl7otfd6VkW4gXaRvDHFlITZMnZEyQ7RiY7OZkcin8AajTN4QCZKxMLxQucqD19ndo+mnNntMDpgqlIAiFjQBy5iiGQQek8CHM/I4DjxFw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX8ywzuDrPfXV8
 R5hEPAT3/uIFWXI0IAxJ8bIx7xRxStaUePsKOQsf/HpBJzSu5+5KKyX6HT3QtaUxkuqDet8dKRx
 2AnUK9p/wKyiCBGuNFBavty+x73ZOSLdTTdol7znsEsBOn5hIL/FxE3QKUgfeRT48ld4MZtmhM1
 JWrdwZK/j9XWMfPODSPZKBbOOv8cI2mCIFPbakeDn3XrypoM46uPSsrKmC/NvLv9+ZtJwLm+Kpn
 jC5kPhcKoaHWsJGDU+1Y7HuR7oj6yrD2Q8WAfRIJu70hqvgh1+cG7BigAU/HFRXlAujWeJBFvql
 WBLynQ/PhZyAajUbm4ZUOUXl0e57RPBX2RxKvHQ3RxuDXo28Ek4umFHC4SSNXJGYT74kKaILIju
 5ZbuzArB952r+UUQ5etcaMGFKZKwwA==
X-Proofpoint-GUID: GsKsLDt_OKOY-y7pSnHc97Fyrljy-6Lx
X-Proofpoint-ORIG-GUID: GsKsLDt_OKOY-y7pSnHc97Fyrljy-6Lx
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f207f4 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=yslvDyFX3O9xw1xFRTAA:9 a=CjuIK1q_8ugA:10
 a=pnI2m26_WTs5bHz79ivh:22

On Fri, Oct 17, 2025 at 10:06:41AM +0100, Lorenzo Stoakes wrote:
> On Thu, Oct 16, 2025 at 09:03:27PM -0400, Zi Yan wrote:
> > On 16 Oct 2025, at 16:59, Andrew Morton wrote:
> >
> > > On Thu, 16 Oct 2025 10:32:17 -0400 Zi Yan <ziy@nvidia.com> wrote:
> > >
> > >>> Do we want to cc stable?
> > >>
> > >> This only triggers a warning, so I am inclined not to.
> > >> But some config decides to crash on kernel warnings. If anyone thinks
> > >> it is worth ccing stable, please let me know.
> > >
> > > Yes please.  Kernel warnings are pretty serious and I do like to fix
> > > them in -stable when possible.
> > >
> > > That means this patch will have a different routing and priority than
> > > the other two so please split the warning fix out from the series.
> >
> > OK. Let me send this one and cc stable.
>
> You've added a bunch of confusion here, now if I review the rest of this series
> it looks like I'm reviewing it with this stale patch included.
>
> Can you please resend the remainder of the series as a v3 so it's clear? Thanks!

Oh and now this entire series relies on that one landing to work :/

What a mess - Can't we just live with one patch from a series being stable and
the rest not? Seems crazy otherwise.

I guess when you resend you'll need to put explicitly in the cover letter
'relies on patch xxxx'

