Return-Path: <linux-fsdevel+bounces-64433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEE4BE7C9D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B65F96E325D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEC7314B82;
	Fri, 17 Oct 2025 09:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L6h8d8E7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CA0E/VSX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9884F2D8776;
	Fri, 17 Oct 2025 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692900; cv=fail; b=f9XEiTaJPQqZ1djjWqLUoQml2yfvE4JiulWYpqSw8QUjtia880CzCyvjFwr2yUNJ0zJfp59iEEJ2bWCkFHw35MDs7TnvX2bt8Ir/GuCM/DetsHLvILQ6CmO1QzJxzcCPmQbpa+EMmx1III20LuVtywDACVx1WBntz/hDPHAFMT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692900; c=relaxed/simple;
	bh=bgRfHwD1bKZ+2dT5kUDFkYfCa62I91VQzfw1zmCDkTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+I4Nnt2LC9C7a2DiTUWhBg67qUBNM0rTgPimU1QfRlrO4IWTDRRna5I3GlSY2q/xoMEdoYouD15YHD0Ffp8SpkvBTLDXvsDpHOHBlY1C918Qa4uhE3Q4DxX0k1WEbnDXoNU4QC1Qmt6dGYMk/DQOGjdAp86vKj3/WooJxzXRTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L6h8d8E7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CA0E/VSX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uVPl009010;
	Fri, 17 Oct 2025 09:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wDvc3o9bpHVydzdP1o
	u27k8PJLBiGZQzRf+a4zjPMVY=; b=L6h8d8E74tP6K2SX+EvRJsBd+mk5fK7/wm
	Ss0095PEjL99i5bo5O/5o+i5WdOn0OhupkZDp2ZzGulTFaQnjaDsiMdrpOgCrojM
	2cTXVkyC8NsAFVrcvvp2gx+9xUJ9vpB+QDMMURuN8FJIMMeYu71DyPguSP59mP//
	fUUzwopajm+ins/SHOT6nRpccxHnHeFO3A4vgOWqXLWnq8cW5YXSc87Ag2LBZz1E
	j9AGWBQQ3x1PEvJt/F1iIhl4/WvolLPSQ+l1zB4XPDgQ1feb+Wc+uJsZInnSktL1
	5YYeY8tK12RZe9z68stTvIQxVpuNZkbBduLcfJapcOUgCwG85lBg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut2gs3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:20:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8qAit025916;
	Fri, 17 Oct 2025 09:20:58 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpjuqe5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:20:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOpOxhjKk70FZdA6VSRcBswFzYaSbH0mxbgEwGd3mPOzsG1hXRkqWHE3pURIVneGmBa7X1X2JJDLxdCkO8MTaJEbv5Px+AN+V6y0gbflnP1HRE4smUJp4uo3IGs6upUw1IYkY/tbD3bwQqVKeRYyYlgDE9dHJ5c8bSVxX4F33AWS8z79O2SgKBR/3Y1FXSvd0N1WtIXdhuSfnal2A/xvZVxyi0PlE8QvrcgAUV2Iihh9H7KKZm7HNFL5eFfQ6NwL7Oghmc0W2xggJk+qe468Oy0HDcS+vBIRzxhaR/IFNAP6DjmSTPPJgdInSek5NFNnD9H6Kuanv1RqGixsn49+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDvc3o9bpHVydzdP1ou27k8PJLBiGZQzRf+a4zjPMVY=;
 b=wK9UJyKRBRAGWZKYV/4Q9VIpYt1wYbr585DVwvXVkeIBTkkeqJiPWinyfDpwJR24s+GPzY+5OBT83wTWfaXjDlKG3j7EhC3eEFRFdn42n0YUeNIxCGNqT3cU4fPn2HKSl6R7fRN67AXZthpZauTte8aBAki8mkedtQ2RR1nc6NJflK9OowcrrYTXJ1REBovgzycHh2dn/Bj/762KrZ94nYEse0yK37jXzPq0CUkbmzfRw7YTkNMdhPsGwMyhXL5sZ5WppqrkCwodBRPuzJpJoYfSN+2cC+KZf5+aARwkkcn6xGpkZvkzZX6x9pfUIKUuIGJJZakt2mCDPJrvJZHQvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDvc3o9bpHVydzdP1ou27k8PJLBiGZQzRf+a4zjPMVY=;
 b=CA0E/VSXfx0cv7lqQrkqcaa2NYe3l7eip7t6MKwtOUXGZLfb/b6lX5TGYMHTxXg9llSUcL2wH9h23y488cs0eM9RBNWm2tWVI1tSp3i8EIULkRT5Ddb+P9MnRNq1w2d6JXZCoZHL5kQui2zHOJpQJ4/6hizt4sl70HQas1yxOsY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8544.namprd10.prod.outlook.com (2603:10b6:208:56d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:20:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:20:55 +0000
Date: Fri, 17 Oct 2025 10:20:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
        kernel@pankajraghav.com,
        syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, nao.horiguchi@gmail.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Wei Yang <richard.weiyang@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] mm/huge_memory: fix kernel-doc comments for
 folio_split() and related.
Message-ID: <cc0bc182-8147-42ed-9c2e-d3f4b99bbac2@lucifer.local>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-4-ziy@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016033452.125479-4-ziy@nvidia.com>
X-ClientProxiedBy: LO2P265CA0443.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9d8ac4-b800-4087-3819-08de0d5e797e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QmyruEpAoo8KM4NQN1QaFAIvU2n/8V03Ft4nihxaiIoQlHkVbKV4nxdLo4PW?=
 =?us-ascii?Q?XBeeCYtc9I6SPuRlfgsbdEwLhEJz7vEsSB/HDqJJAEEsz/3JK3ENIQTuBHm1?=
 =?us-ascii?Q?FFJIQ530in2p7K0akSWC4uQndf+980BnnT+IiCYmkKW8Nc7qS184uG/lHXoG?=
 =?us-ascii?Q?gtRCujpv9bXBi1icZG6vEQ7sgWSiT2pp3IZVNv994zrOuypBlLJmI8U+4vgP?=
 =?us-ascii?Q?9EItMKhYc2p7rJGDzBmA6Ke+sIdfnxDpoXu8TmGgIb8JJ7T9thKp9HIEav3G?=
 =?us-ascii?Q?rE9Ut5VrlmxcowU5HIOKF+8fVl8qVqHU/TG+IG7ok3YHVGeroeJSvrigh0UV?=
 =?us-ascii?Q?lG+B6E6tLlFDa6OHSvI0owSEzT3j+ZEWyKLYqnAGgPzz9k5zvL2Dihfxa9HA?=
 =?us-ascii?Q?6byTG4gBK4gbjeQyxIf+2ZULYh9xI+p0w5jnnj6U3kO+rn/dA4OGbdKLa0YG?=
 =?us-ascii?Q?BepuRFmzdH/MAHVLX3tlXx7sZC1uy3tdlGw6CuoSVP7H+OmyxPF3OI3E08vo?=
 =?us-ascii?Q?Jj+0rfDDIelGDuBvO287+tfzdwI7toklSRAQoC+aeJid6CX7X6DcWOsC2+sx?=
 =?us-ascii?Q?2nZObkN0CWoMXeWEkn2w5GeD0xIHrV49We2nr4HY7T8dYRap2mWsz3z7TUdx?=
 =?us-ascii?Q?thnboMWlVML0mNGeyj14p58dxFipo+prNIq2+HB5HaoLgrwB3RN9G13leQZV?=
 =?us-ascii?Q?jfMq86GB4/Zi1qdVnCMsYhsyJBVQExVmrJYiik5D/LCCBjBLYGDO9tZuZoXB?=
 =?us-ascii?Q?Glkg+BzTEdHSTASebuScVWp5tbZoPyFFoCMk1jyqZfhX0Pymr2gEJkswVVmb?=
 =?us-ascii?Q?W2w4fdIAovFR/Hr8mfmquHCQhAoB1g2aDxxYsOpdOY6f5N2shKlfFQ/En5/F?=
 =?us-ascii?Q?5KWTWr3MW1qIGn16Ii33PnCWfBzPpq9c1LbADXWw0kquIYnLXe09KeusUXgJ?=
 =?us-ascii?Q?ND53VWOOzCHONezBAR0ExJG6vV083Ys9m0d4C3uKJu6nPLFsVsPVJlh73fX8?=
 =?us-ascii?Q?ZFksd0EMupTwc18/sWj0xMCejVUsakhMzgcyWZ9XgKcWtJ9IE2vJarknTw0Q?=
 =?us-ascii?Q?VSWwdkDEmv5Ph71abm4ebZdhbv5Bg3VMXyhFkib+bY0gL1uvYALAMi/gJtV8?=
 =?us-ascii?Q?RzE/6FeISFePVpFhwqKTUun6Cx0xSpqjcF5Kg+irAK5UQQHr8A7y5eptiNRK?=
 =?us-ascii?Q?84YZK82dzJCwIvLpWKNEpIKJ8AW+pgJujHv3jPMxixphsBS8o20B8yIGfg1d?=
 =?us-ascii?Q?itnNSXWqBKcjATKFs4uS5vcbsAQaHURj5jZU0uyaEX0YOSYW7EiikYjh8d63?=
 =?us-ascii?Q?P88OVJzVs2DX0jIOpiEmfZ5WjL0jWOZ23oRYrEK+LIa6prolCAlZU4MpN0mV?=
 =?us-ascii?Q?8lDk67B3b5yWWByU2nT9OOFxba+1CbmRNG1N3Y0qpMvMcLXrOwH+viJYlZdG?=
 =?us-ascii?Q?7Y43EtsgIdMmAP7nnr90oJqgJVFwtAqh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALjfMaSAIXy+CrrHDEC9fSYMQtuQG6Q6ZT7cySJJiFUkn2fPDHlQxLDYizzx?=
 =?us-ascii?Q?22ypN6ayZFhU1lIJagHzSC85VSRSmjvolI17NbgdgWPDUjUjhveKHNOJdK1e?=
 =?us-ascii?Q?KHTWQ7c06bQg10X4CSp9lF10BOis2/ufpSdIoUK1I66UFtJ9ZywTaeU736DA?=
 =?us-ascii?Q?gX3TzA99qQqbL4Z7l96XRNaX9qJe7BLeDNP70CJryAO08DN3Pa5GvF3/lXPM?=
 =?us-ascii?Q?jR6c5iSKtpiSbtNCvafS+XuU1HINVukG3KbPv50wCYXamiR1aOXdDzWvU6EV?=
 =?us-ascii?Q?P+VoNIX94thMbS4wcIMMdkFFzhouLT2Doqy3Z/s0917ygeFjE3huppzKBuGr?=
 =?us-ascii?Q?i/1nRP00tlK6LlwRnk7MTZRLvl0nJhmRbiLRZMSlu/twM+CJlGauOnUU5FPZ?=
 =?us-ascii?Q?/a5ISLXCaGoG31egzESYUGj39nYWRFBKJJndid5vxGEbL1CRUzAUbviU3X5V?=
 =?us-ascii?Q?63bLhj8oJAN1jYL20hplF39QmyT0HNspUuAEtvAPxgZw7WttEHTSvnVNJZsi?=
 =?us-ascii?Q?N5j3BgPLzrS0/PGAmePIe+qtzkAZTbjgykuRFMSzTamsIag6i8rjoR6ioaDJ?=
 =?us-ascii?Q?WHmIAOR2qbRrypm/PdHn+E9hX3gxljvPPAEgtOcMTGzB58VApvCYZQxu8wmL?=
 =?us-ascii?Q?SbezgCc7iowBp4ksaUFBIds9JZiJAhiOZFCBU7SnAaHV8HcMlYV7Ss/Vhf1L?=
 =?us-ascii?Q?hiGi/VFw6uqpCx5iHU2xEOHv4XiWg74u4wyYuNcbC6YTyvtbBndrRdLeFXnS?=
 =?us-ascii?Q?+gk0o3Y6IT4/0GOkIVNwvqGO+1UgysFKBF3MFAi3FLMQqepp9vxqJbvaO7uJ?=
 =?us-ascii?Q?sL4rScLLu6ENfRC1mFfyIE9mhqgIvp5SXg3Nlb/0Z/qJUmEp/wNCu8hZr8xK?=
 =?us-ascii?Q?b025v668U3fGduujxPP3PFfC69nS+Nof5MXzrGCLqHlawBhebA8qPwly0C5k?=
 =?us-ascii?Q?A3vEWrl677cjzq5ibQGX48wHuw88SPuPjBbgjMymbjbAr1+Iaz3Pcv4X13fq?=
 =?us-ascii?Q?+hucbBWbBpxtRMv1bKyHsvJM5hyNN/16+25CvGbMwL+59udIyOt3G5UZGIUu?=
 =?us-ascii?Q?QZfLhk+KR4KkSA1liFrVEOXgF6UqzfD+CQ2Hveq/h+eB8jP+aMDdamOb8cgZ?=
 =?us-ascii?Q?mU3jtd40RhrzUATih5SCeJW4HeG8pzvmdG3aNcwxnSW9j4Pjfcxzx+AiUnSu?=
 =?us-ascii?Q?8AKuFY+fR1n5H99Ota6fsP7R560Rsi8HdA9ObWXzahbMGtnIg28jjDM06Dky?=
 =?us-ascii?Q?jCvUeY/GdSN4C01avT7AYi7jm/r8dogy47T9tj7hMzpDHdv0R/KneoCF22Ws?=
 =?us-ascii?Q?AeXBgWR1T0HjYpSjC6leYb2hb3QCnr8WwslCPK7vmJL39C3qt3yfE4kXSXV4?=
 =?us-ascii?Q?jGBjWAbLpcXS+r/tDwjdHm5H3V2mYy4/Wmgh8OPdKhLJ/l4ShB4T2kzaGqoC?=
 =?us-ascii?Q?mg/kdTRC8W0mGmhYcN59sbQycGj74jZdxgYk9aka5uZMW6IEqZ5XHuDgfVFJ?=
 =?us-ascii?Q?NxcCuHJ8wzEHcwFHZ51lb9IPhR7E9L6tQdhLrHAOTGs/H88XxgSCz6CCh1f9?=
 =?us-ascii?Q?V+mVVrSS6Za9nQ9NNiTe7/Y0kQBsztupmErWtJeTRTTYNhO6dUoQPmo+BfNV?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kubR5IOMZKd0pHr8cvveG9OZdVakjAe942JYYvYPj4wKv5axPUK3Zd1++AMTP+5HE7i5VpAeoNN1IhrDpc9z6HzSppA/V0IQgDLPPVNhE+469vXQCuRzxwiK7abVWSiffSYwZhlQkfs2OQy8Ikof1BBS/eeRDNl9CaDorxFFqvk/GYSU5PgZ8PRjT7suO111qpEie6CwV+Y+x7Q8AEnBYpGn70eJqSebDUSGavzD3GZzkZKe5M0PRISfhNDalCZCLxuVAH61uat1C+hL5KBVjegm6v/dTj2PUOPNRAnvXF8/7WlUAL5abCoFKFgBwRz0FETNltFIHiI5pNvy3nLHN55Lm6b/W2KixOo7Fj038QYzUk2mFiJraoyTXSOC0TqNetFYjYTGOsjCzId4C37DCiJBOZCZMxkEzVg2hR/4W63JApEJCXXr4aIy4DWezRWlqPvVHOISlOjLb03IfOT3l0IJGd25DvN2PNSY4oRfIN56ANiikX+G6PMNi7qmC9Y/9xLzcCAU3bCdcKRefdl81r/zS3UWoPwi3za/35MFA6DSGHAQGcCxOkukQ09Wfp3tbzpGtK1qvCfTaujvQGSE+TVpCUoGZpG1HE98GEDRXEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9d8ac4-b800-4087-3819-08de0d5e797e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:20:55.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MSbokw9gCLrNYAsd02h7AXVcPrCA8qpyyUa9MAfeIgc6Qth0qlTC3zqyKQr0BCtbzJjfiBG1dsoEuYpRlL5QzGha2OS1mLBnfAXYAZ8cdzU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8544
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170068
X-Proofpoint-ORIG-GUID: ROs7xjnHTTZyX4ItT0aeA-5kcWIFDO_3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXyc4bBrCL2Myn
 582R68uImh9GjiSUmwPjU354PJ3ebcnx1Ow/gvuPig67p0wrohsQWLsKnSD5lZPz4nt2m0aK7+Z
 1bYuKjvVrz/O5gK+y7/eeB4Wj2mPZvOUFkX7Pgg2XNNIfKKae0tcJI71M++4JtPrdNoLrX8kaiF
 KBQev3thpWTyyI8sumrUWsSbV5z6SrcW43CxI3UJPGvUbsnZsuSJYi7ArBa8s+MnNS2J8S2x+1B
 WCvhdLPHURnnyMb84HyDePDg7bZVAMzphP8X9SNT6YNKWVclguQb0QccNeYALJPZlD4K7e3U9I5
 Y+xo4IBNNwvDJ4ZjO62cyZd8kTsPZs8Kz5vOsG6WLGF9rJJKbB5TstByUp+Z5vA3e/eKv4W/q4U
 YL0l9N1bFRZExaRWkbEO43CKM6Z5WCP6g08iZSqrhi7PNasQGMQ=
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f20a7a b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Ikd4Dj_1AAAA:8 a=yPCof4ZbAAAA:8 a=x-QnC0IdEcVr2PzZWUUA:9 a=CjuIK1q_8ugA:10
 cc=ntf awl=host:12091
X-Proofpoint-GUID: ROs7xjnHTTZyX4ItT0aeA-5kcWIFDO_3

On Wed, Oct 15, 2025 at 11:34:52PM -0400, Zi Yan wrote:
> try_folio_split_to_order(), folio_split, __folio_split(), and
> __split_unmapped_folio() do not have correct kernel-doc comment format.
> Fix them.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Thanks for doing this! LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/huge_mm.h | 10 ++++++----
>  mm/huge_memory.c        | 27 +++++++++++++++------------
>  2 files changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 3d9587f40c0b..1a1b9ed50acc 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -382,9 +382,9 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
>  	return __split_huge_page_to_list_to_order(page, list, new_order, false);
>  }
>
> -/*
> - * try_folio_split_to_order - try to split a @folio at @page to @new_order using
> - * non uniform split.
> +/**
> + * try_folio_split_to_order() - try to split a @folio at @page to @new_order
> + * using non uniform split.
>   * @folio: folio to be split
>   * @page: split to @order at the given page
>   * @new_order: the target split order
> @@ -394,7 +394,7 @@ static inline int split_huge_page_to_list_to_order(struct page *page, struct lis
>   * folios are put back to LRU list. Use min_order_for_split() to get the lower
>   * bound of @new_order.
>   *
> - * Return: 0: split is successful, otherwise split failed.
> + * Return: 0 - split is successful, otherwise split failed.
>   */
>  static inline int try_folio_split_to_order(struct folio *folio,
>  		struct page *page, unsigned int new_order)
> @@ -483,6 +483,8 @@ static inline spinlock_t *pud_trans_huge_lock(pud_t *pud,
>  /**
>   * folio_test_pmd_mappable - Can we map this folio with a PMD?
>   * @folio: The folio to test
> + *
> + * Return: true - @folio can be mapped, false - @folio cannot be mapped.
>   */
>  static inline bool folio_test_pmd_mappable(struct folio *folio)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f308f11dc72f..89179711539e 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3552,8 +3552,9 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>  		ClearPageCompound(&folio->page);
>  }
>
> -/*
> - * It splits an unmapped @folio to lower order smaller folios in two ways.
> +/**
> + * __split_unmapped_folio() - splits an unmapped @folio to lower order folios in
> + * two ways: uniform split or non-uniform split.
>   * @folio: the to-be-split folio
>   * @new_order: the smallest order of the after split folios (since buddy
>   *             allocator like split generates folios with orders from @folio's
> @@ -3588,8 +3589,8 @@ static void __split_folio_to_order(struct folio *folio, int old_order,
>   * folio containing @page. The caller needs to unlock and/or free after-split
>   * folios if necessary.
>   *
> - * For !uniform_split, when -ENOMEM is returned, the original folio might be
> - * split. The caller needs to check the input folio.
> + * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
> + * split but not to @new_order, the caller needs to check)
>   */
>  static int __split_unmapped_folio(struct folio *folio, int new_order,
>  		struct page *split_at, struct xa_state *xas,
> @@ -3703,8 +3704,8 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>  	return true;
>  }
>
> -/*
> - * __folio_split: split a folio at @split_at to a @new_order folio
> +/**
> + * __folio_split() - split a folio at @split_at to a @new_order folio
>   * @folio: folio to split
>   * @new_order: the order of the new folio
>   * @split_at: a page within the new folio
> @@ -3722,7 +3723,7 @@ bool uniform_split_supported(struct folio *folio, unsigned int new_order,
>   * 1. for uniform split, @lock_at points to one of @folio's subpages;
>   * 2. for buddy allocator like (non-uniform) split, @lock_at points to @folio.
>   *
> - * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
> + * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
>   * split but not to @new_order, the caller needs to check)
>   */
>  static int __folio_split(struct folio *folio, unsigned int new_order,
> @@ -4111,14 +4112,13 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
>  				unmapped);
>  }
>
> -/*
> - * folio_split: split a folio at @split_at to a @new_order folio
> +/**
> + * folio_split() - split a folio at @split_at to a @new_order folio
>   * @folio: folio to split
>   * @new_order: the order of the new folio
>   * @split_at: a page within the new folio
> - *
> - * return: 0: successful, <0 failed (if -ENOMEM is returned, @folio might be
> - * split but not to @new_order, the caller needs to check)
> + * @list: after-split folios are added to @list if not null, otherwise to LRU
> + *        list
>   *
>   * It has the same prerequisites and returns as
>   * split_huge_page_to_list_to_order().
> @@ -4132,6 +4132,9 @@ int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list
>   * [order-4, {order-3}, order-3, order-5, order-6, order-7, order-8].
>   *
>   * After split, folio is left locked for caller.
> + *
> + * Return: 0 - successful, <0 - failed (if -ENOMEM is returned, @folio might be
> + * split but not to @new_order, the caller needs to check)
>   */
>  int folio_split(struct folio *folio, unsigned int new_order,
>  		struct page *split_at, struct list_head *list)
> --
> 2.51.0
>

