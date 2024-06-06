Return-Path: <linux-fsdevel+bounces-21132-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 668B88FF4BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 20:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F341F22410
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2024 18:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180C84AEDF;
	Thu,  6 Jun 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iaHKsNFo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d5RC35XK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D8487BE;
	Thu,  6 Jun 2024 18:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717698759; cv=fail; b=uiurqGmMkBj/jyfyvChXoB1cbzSdkew+eSlPkZIV87p24HD7H1/1YkcwAHYOwVfVgb9qUNAIAdyYWY2KAbsokMjI3Tl4tVqYV7V73ZntnNuYPqI9EBKXVcMWgvwEBg0F7f8ZBQy1tJjslr0qIZi54lXMh+BQJUuwOzpQVFUj1+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717698759; c=relaxed/simple;
	bh=wMakqjEkUSYyLjxjQ0BOSKaymg1ZZ2wssnZqRdvBJRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HEUqm/eaBqdl5imyo9K7p7c/LRAryrN6GAEv3oWs1iFQgFK8PsDlUDD4mzuezHnqj/jy/KKMgXFgC7j+B70E+ZAochOgZEPhMbzRtUihur5EJD/pr8EmEJ7d2HD52V6uPoC8gzcxUCmQHOtLZ/ijk3m8N9Oiv0Ntbek5IwF0zzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iaHKsNFo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d5RC35XK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HxTfF032746;
	Thu, 6 Jun 2024 18:32:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : content-type :
 date : from : in-reply-to : message-id : mime-version : references :
 subject : to; s=corp-2023-11-20;
 bh=1XspzRE/M8yFhU99MQmhQ1sWUsBZgff1FUl9gZ5evAQ=;
 b=iaHKsNFoB18Oi2yBONJfjkeRCr0s25hNSA4IRWcBtaBwQu3qn2f7iinz7ET4NfW28dj0
 0miIQiJVXXPzc2vs8CcjnBTllQjDnJfSCePhqQNvMXSK55JFdgejyDPg6czFHMhlEFS6
 EaAlHdod+HK/B/V0sUmr/Y50W4VoySqQTvBUO7hmlj2BCRXWpFFomtUcvieU8QdYDkKB
 3SonfER3USdoz1HV7CH28yFRvuXot1h3yoGYQs8ZR/zdhm1JgAwssKMEJ+HISUNVSrDs
 FlwSSbQj7hBEQhdDSGLKFvs2xVl1iyXBKd1UN4yHDTHxPx17ja1aWje5VZy3Ye2KfDuC Vg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbqn45mt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:32:26 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456H3YRO024024;
	Thu, 6 Jun 2024 18:32:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr180pd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 18:32:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jz3Ps9l1VCMXniLrS87gJvHSd/hjBA0wOC2TPrgNNSn5TWmsES2AP7FpEY7ZIM5YCDe8YPBGTHTMLV+17Y9M7j+hDDD3Zayoh5gDYpfad5U8xOE+Cyk/E1tS1ripBbecDXYr6msg5Jx5PV7xcVdwG30DpSFTmXn/FJGCNifRhy91CuW0bdTImTv2K6LjF1g2KQCGnuwz4uUazrDum3LLAI+owgebshyFytO4divA/RyeQF6OV70ToQVifaGQR0AAe9y2cqGjdIKVuayBSnPRD6uIu1JkeIlLQjE9s1uxrOc4QmwsU+9H4cIprrmgTkLNschgcBzCQw7uExut5UmqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XspzRE/M8yFhU99MQmhQ1sWUsBZgff1FUl9gZ5evAQ=;
 b=KVe2hP6ZXlR1M1c2xbVwu3wakw2x1zCkcIu62CVXgE1VNx8o53VCo3UCHPKgHUjA2E+QwSQSSePUzZFYG1MBSz5CAklODBz7xhVlzuWNSF02uskfvKfSKxUg2CfPniAvkzLwztSCQdvEFM5lMWTgH2h/AB0Oo58WCBTBKG3o5D5cyJAa/TFlNKAnIg+qJSfPZEiWN9f91IBxZDN0Uv+ns5ROCrzj8w556ZF3zvPRQ/h2fIvkvNcz0HtZMgt0pqxgh8Y1H/r0xHL+/V8WgWgedgFm3IVQoERFYDATSK6zPqXXSSA++1nqxmM2dst9hTJnNmctdkXKXTZJRz9cOClXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XspzRE/M8yFhU99MQmhQ1sWUsBZgff1FUl9gZ5evAQ=;
 b=d5RC35XK+ZlDwNYRdLm+DB6JuVFq4moF9CPIgwwrh+8wfnB8ruzDIQiFCMG2OL3i5ExcXpqHevobgvBlQsXlmuRFBStTypOwj4C2yNDHR26YFmUI9JbbwFMmXxStFunLann1H7XEmcahgBpre02P2wWUfeoQIc0DnrmXwzNUFPA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CO1PR10MB4419.namprd10.prod.outlook.com (2603:10b6:303:95::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.34; Thu, 6 Jun
 2024 18:32:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 18:32:22 +0000
Date: Thu, 6 Jun 2024 14:32:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org,
        brauner@kernel.org, viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-mm@kvack.org, rppt@kernel.org
Subject: Re: [PATCH v3 4/9] fs/procfs: use per-VMA RCU-protected locking in
 PROCMAP_QUERY API
Message-ID: <7rm3izyq2vjp5evdjc7c6z4crdd3oerpiknumdnmmemwyiwx7t@hleldw7iozi3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	viro@zeniv.linux.org.uk, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, gregkh@linuxfoundation.org, linux-mm@kvack.org, rppt@kernel.org
References: <20240605002459.4091285-1-andrii@kernel.org>
 <20240605002459.4091285-5-andrii@kernel.org>
 <CAJuCfpFp38X-tbiRAqS36zXG_ho2wyoRas0hCFLo07pN1noSmg@mail.gmail.com>
 <CAEf4BzYv0Ys+NpMMuXBYEVwAaOow=oBgUhBwen7g=68_5qKznQ@mail.gmail.com>
 <ue44yftirugr6u4ewl5cvgatpqnheuho7rgax3jyg6ox5vruyq@7k6harvobd2q>
 <CAEf4Bzaac0Di+mCfrxRVsZT0sfWWoOJi6ByW0XA5YEh1h7dwuw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzaac0Di+mCfrxRVsZT0sfWWoOJi6ByW0XA5YEh1h7dwuw@mail.gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0479.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d6::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CO1PR10MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: 02fbe869-ee6b-4dab-d2cd-08dc86570188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6BlLXMFV2NfZtjTOZOynnGVk4+GooB0hw9N6NwHBUw5uFpdgYug/ugLGDEZx?=
 =?us-ascii?Q?KX05gh8P/1WMBuuFEy5gqq+ODCRSxhrz2kiSI0DuBgkzdiozo9dufnrfNkTL?=
 =?us-ascii?Q?Kd1d4bUieS+IJGP++DeEw5Zt5pLsdyXgnDLV1cpS/LwK2HcAazZAK0sYw+CB?=
 =?us-ascii?Q?vVOOb3I7GFYgqV2y3LckzNd6OvUuuQEWrg+EUwO2FOaNPAvC2iipX32KK3KR?=
 =?us-ascii?Q?XnigCLyKnT5w6KAWXNjNuDuBhHzjWWvawyf04o9HQwjFllD0dYX5OKqphngh?=
 =?us-ascii?Q?EVYCIKbLysbUArzdoKIvg+rDmE0IWBJDOHr5AunQsxiLfXknbeC25Ahyl2B7?=
 =?us-ascii?Q?1mXlbAO/8Mh1YuUZxKwYjygsYwl5kUIkIpxCoCUilu7FWW+aHxEnauvT5vST?=
 =?us-ascii?Q?QUyTH8bmbvRDP5luKGUsW7hG7s1IQmrK2jUiSxhnMNIS4SoV2ebmgzeQYOwz?=
 =?us-ascii?Q?R9ClNXKbpwjeMtQ5BxUwYe+KQYh+vDaMXukrUYV+F1Vy8VHErAiuJMyIjZMI?=
 =?us-ascii?Q?EJiHazmf9ZG6miB914aIkts7Y/T86uRa1Rd+ttG4iAhTc4tleWqJuOyjK6hR?=
 =?us-ascii?Q?VAI8Z+Vmf82N8VTJa9oDvUCdKYvDUxc+WtEPoWlPBziAxQRs3nK1mD0dbkQr?=
 =?us-ascii?Q?Z4Fhqc1ti5Mo5v1bIu1GLe0P4OeTtSjw1yjNag1dto4GJdnFGbbGYBlThRIB?=
 =?us-ascii?Q?s4icMyQ1UojOwPkUXfdplVmNXuXPnjz/oIwQ67lw30nd4pnLPlJJfrggwVEq?=
 =?us-ascii?Q?dKKhYgMxJbZwa0VcVRLK8TGBiAFSQHWhoxzYwY4hf0mCFljKO2ri+WBm72sg?=
 =?us-ascii?Q?K+jrT1LKjR0qEXOPd87kBGqT7IK7WILZ1jQwermySpvkf3FAyO+WxP2/YzIp?=
 =?us-ascii?Q?IS/Q6ZjZKM5AoFK46U5yFMxvszV/bVIcZlKlbDlw3xZHNJPTk9VYZFRVYnT4?=
 =?us-ascii?Q?XVpuT8Z2+9bO1ys6MbmoD6Gf0W+YN53asOU4hpEQOeU9d36BJHnpT3vDaOis?=
 =?us-ascii?Q?eKmj0HRgOUDTO8fBW/cUQOqqcxHpHZ7kC/wL5Rj/TOzaiV6dPKHlpMM1s+1/?=
 =?us-ascii?Q?I6LRYxSPrCNLQI/np6la5m2I7G3612y5+JeiAE7bj5AqPHVE9hscJBH6RcDR?=
 =?us-ascii?Q?grQM0RBLt3kD7F8l+T4W3+Vup3QBSmqxMb7ADPmySdDmoeiXNn9DsteEiHMr?=
 =?us-ascii?Q?uJ296IJqZiw5H+g+5c021AoXaU2rqWqFo9THjxViOaXrWvSvLn750uaQK93J?=
 =?us-ascii?Q?s33U16XEmb+FDecZCkBsHgIJt9QtA+FexGhX51Frrvw1MCxMFeTcxalRljeO?=
 =?us-ascii?Q?eLpsCiQIHXHbwDFdZlUwMzvz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nLkB++4CCXSaP4Y/ww66KZaLVki18NFBKA2/67B9J3Pz7lOOA9FyROcLmsO+?=
 =?us-ascii?Q?noaG6JIfFdb8D5DKGqWEGCrg3jbcqrC4trmHD1YDNXSXrqSpDkQzbuh6SBUD?=
 =?us-ascii?Q?hmTj3CBRJ7DAdKb3JMxTSwh3/HA8GCgy8tiBhdBnlKI+vw9EsEvmLJerxpBn?=
 =?us-ascii?Q?s91ybXX2CWWVu5FjEHsGbZNUeujsvt4gS5yxqVKR1255mGkPgr24u15gbG4a?=
 =?us-ascii?Q?fPlDVg9NdQ3UyP+m7dnFbyXQvXQGC+WyMh/O+UZ3IDO2zlz3v0RzpTykTB74?=
 =?us-ascii?Q?1K7gPw736MLQPadzFuzQ4INHXZOo6fKc87VwIZQW0YPp2ieAFgOJdaMggD3Z?=
 =?us-ascii?Q?KLL85EdU3tNdTMxhYsSvvd44VKL41v4JnkReYg68BgXDcn/shVef5lTLAqVl?=
 =?us-ascii?Q?WTOWv9qxiN67g3Cpx8ALGGrhitkcxAqyIlBnX78viHCpDVx8WALU//fM9+qa?=
 =?us-ascii?Q?ahCix9ix7OVEdclQdoM+fcT8dDByLsUaZbptAlXWB0CDb3smj1jwUUu6Ar5t?=
 =?us-ascii?Q?cSbfj4FQfz6uEtLVLAWec9bjH/Vv5IzaJTMb65D1OtQx1zcttRmBZAJKOp5B?=
 =?us-ascii?Q?cBdhsYubbfVztGbBgh1ty9kcO+tApBR4AziTfJ8aeexGrl5PAUv+8R6P4rpw?=
 =?us-ascii?Q?jqUpbAlh6jJWfAI+8R5NS5ctpllz71cr/lWCFYTf7aFdl14fUQlijzR0bi0D?=
 =?us-ascii?Q?nJTvU9T+FxF27Ejuj4Tl6LMnhQl3LuLLFu6kUOsG+WxzmEpqm19gfz9UBFQX?=
 =?us-ascii?Q?c3uCm6x4gYiqk+YdSlMfUVxI8biDygwlZl7eIc7xvIcLtqkeJZ0QMgbmRLtP?=
 =?us-ascii?Q?HjbXnTBXcyLPGLI+xF2acyC2/XCWuRMAzN+53HbFL4463fllYrAKzQkESobK?=
 =?us-ascii?Q?oSReE8RjAfoOe0RZ5cWeI1HxiHWIk24Y5mS9AUUVAGmiQaLYBnLjgIL9zwG8?=
 =?us-ascii?Q?ivCqMZQR8Z+R/vG38mM2aVTGqLcAS+XC1UWwJsCi8zYkN4CpcwZu0ZaH0WGT?=
 =?us-ascii?Q?4GH+YCyxKKehzSGfFdbs77xDIpWS1WMsQTc/771PcpT/msjxTw49qqHgkbL1?=
 =?us-ascii?Q?VrCWZcyDB/6GdgOfXOdF3zESPfQtxznGTcVpaSdfYV4M5UUe5Y2S+uBvkpTt?=
 =?us-ascii?Q?xBM0FqdIBpyME1W2ADomidLGqDdpvkKXctyZ7ZwCzhar1MOC1opfhyaSqO6Q?=
 =?us-ascii?Q?AGrgSfS5bOS1JS7jZG17WtyPO4UtHueRGrrXkCH+g1RkY1TQaDElZqKdqMTq?=
 =?us-ascii?Q?Lk6U/4pcrYf3yLcts/WTgbxrvA5XkILUzjuU0k4mHT4jrfE3UTQwOmHWGgKB?=
 =?us-ascii?Q?ohqJecjYpMWC38ZPt9H521Ok9iTsrchFlwUh+M4Fuj8NHq5BiLQmXmaTCCGL?=
 =?us-ascii?Q?VbOYk3+7ITSArWiNBv1rS8yhmrYT234Q6EEzoUhftB34vJj7ww/ABHuIByAo?=
 =?us-ascii?Q?wXaioYPDv8sg3l8NBgWgM6Wgju7qahItpCEHBoyBgdpUl4UN7b5shX5PiUb5?=
 =?us-ascii?Q?o9b2hGcCv7a2xqxK2isOSkVfofkVdEfeL9YnDJQcJLCu8S/Dfkn5hqSzPlkt?=
 =?us-ascii?Q?GUbNE6w/RZVwcStc4I0bSr4TF87kCsefRw0FnM+C?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lA1Wh32qWzSszZwH7CrVlsy0v2uR00Us1JdigxjJLnlF4DX8xnwaSyYyOk9bIr/y2S+VW2Ofywfh6uEKct8HIMTx9drXiOquXfzXcxTrWPUO7DvXHa6uEF+OOnJ0ldCuubTdkTzkWdUlmx7f3pQ6BAGTBplxv6rQUvR6Dy9KfQt9L5ZsgbiCs3IOz+55S5yXeoaqQO6tGCpyGAtOsjKXSDNuctJAW+E7ocML/zY7iaKBYBcQidMPgkdL3oYjpIHvCgEs0ejHUFoFUML7tF2L8Bmf0hUGmwvjx2atw7MIkGHHDmDhhL/CCnlesRXP+U2rXV0bSGjNfnWRKtoejXLqNczAlB85PYznc3sMwBK+SI5CidkSm9pAThgBWWiMMVjXDROgPaMhkvBCT+zk0r8etAX2r5HXfNxPa/eG+cwmZF2/GsGVVKjaoE3NFOwjA1u/mxB9VEWRAfoZYRAbQ+O7aysBH9+knUNYaysD5t0Aq5ahz/kUP9cxTt7+qGKQZvvsxGEVMjsKnVYW9VNQuL+nVmIxfUt8HOuyHmbLACdI7AEE8sHSNV4U7CJ5g17KYqmTOWkPt/FZKJ0z7a6GS0p259L/0CpVbv0tfeytc2GAESg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02fbe869-ee6b-4dab-d2cd-08dc86570188
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:32:22.7097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eeu4XymBhAUfzY9SAedRhxpw+fFoQCFDoufP1ksi34ss7AM7eM+DtpBIglTfmZ9Iifcnyx0oE3eftlHCptvcNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4419
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_14,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060128
X-Proofpoint-ORIG-GUID: SwA5s9mgP81oLeAY5CY00b18BLaOWQCr
X-Proofpoint-GUID: SwA5s9mgP81oLeAY5CY00b18BLaOWQCr

* Andrii Nakryiko <andrii.nakryiko@gmail.com> [240606 14:09]:

...

> > > Liam, any objections to this? The whole point of this patch set is to
> > > add a new API, not all the CONFIG_PER_VMA_LOCK gotchas. My
> > > implementation is structured in a way that should be easily amenable
> > > to CONFIG_PER_VMA_LOCK changes, but if there are a few more subtle
> > > things that need to be figured for existing text-based
> > > /proc/<pid>/maps anyways, I think it would be best to use mmap_lock
> > > for now for this new API, and then adopt the same final
> > > CONFIG_PER_VMA_LOCK-aware solution.
> >
> > The reason I was hoping to have the new interface use the per-vma
> > locking from the start is to ensure the guarantees that we provide to
> > the users would not change.  We'd also avoid shifting to yet another
> > mmap_lock users.
> >
> 
> Yep, it's completely understandable. And you see that I changed the
> structure quite a lot to abstract away mmap_lock vs vm_lock details.
> I'm afraid anon_vma_name() is quite an obstacle, unfortunately, and
> seems like it should be addressed first, but I'm just not qualified
> enough to do this.
> 
> > I also didn't think it would complicate your series too much, so I
> > understand why you want to revert to the old locking semantics.  I'm
> > fine with you continuing with the series on the old lock.  Thanks for
> > trying to make this work.
> >
> 
> I'm happy to keep the existing structure of the code, and
> (intentionally) all the CONFIG_PER_VMA_LOCK logic is in separate
> patches, so it's easy to do. I'd love to help adopt a per-VMA lock
> once all the pieces are figured out. Hopefully anon_vma_name() is the
> last one remaining :) So please keep me cc'ed on relevant patches.
> 
> As I mentioned, I just don't feel like I would be able to solve the
> anon_vma_name() problem, but of course I wouldn't want to be
> completely blocked by it as well.
> 

Absolutely.  Thanks for trying.  To be clear, I'm fine with you dropping
the per-vma locking from this interface as well.

Thanks,
Liam

