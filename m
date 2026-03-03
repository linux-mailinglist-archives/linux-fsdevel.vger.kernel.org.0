Return-Path: <linux-fsdevel+bounces-79131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMxHNlGxpmn9SgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79131-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:00:49 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 360371EC384
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 11:00:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9EEA3302FB05
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88497390206;
	Tue,  3 Mar 2026 10:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XoinMWZ4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UDQD1gMz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CC432D0DE;
	Tue,  3 Mar 2026 10:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772532037; cv=fail; b=r2FTY3B6ao1/tZkn2Br5S2oHDBUjfLTQ4eXb5RsHe/ghhZJXl8PZOW+tOVK4yBHBCSjXw8QhsKTsd22ahFaD8lWSY0d7RwS/oyYDdJCtLz5gc93pgeWH68w4qf+jGh82KaSWrYExZ6qQUDU5lom4bR8ZmRbUzsISpzPcG8a21Js=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772532037; c=relaxed/simple;
	bh=X0mlgc5cjYmcBxQyCF1aaLKTx7Fs9atVjxItH2YwMpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SJ4Cn5U95PQ+H9Fc0IYznoLD2A223mz05P/VbnnRdinxFsK1PcWbQrw64qdmaStMJLplcQgkzg3cznNiNMzxFdmaxqC7J8NCiukbiv4WLHURsKW4LAAKWQk+px8vm+00hF29AO1pe3E6BdUv0i93SouqgbGGIbc3pdLkgW0ZYJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XoinMWZ4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UDQD1gMz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62392H3m046360;
	Tue, 3 Mar 2026 09:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rX/wA+t+aHZYu+3/u+
	EOOgDnMcRG/DiOyXTzNVO2sRY=; b=XoinMWZ4O4o4Nz7wxpJwm+a3I2+0bAQYjA
	jRdu3bv3Y9ZCfK/iU4q8cR2v0UoOPyWkooceBmksN3MCkxlnJV6rfr/Z5u23Od1I
	uQHmfQbmAdJMrSVUJ11TUQfdSqxPgQGQ69Hd3O5RTWTMHCW2RhbY4zCCtAAD+nDP
	KpC0rejyi6o1g0lg6+Y3FjbnifZcLTrwLbXFy7yHps9lu31a6pldtqzSCc8mpMii
	maDqZaS055p2D9RCURBCfLPaavSqWqKyn0zlGslx/PsHQ2MuhgCb49dneV/R8fyh
	N0U4/HD22mcmQivQoxPk49zdh60oZ/Oyex4CcwrTABZRjZat9Mbw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cnvnn82yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 09:59:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6237dmQ2029777;
	Tue, 3 Mar 2026 09:59:58 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ckpta47x6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Mar 2026 09:59:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIkfhvf8J4Cxxm4zpgIPm2rb7Hk1PcKHMZ8oPz6tlaKgx+Gb8EKfelk1MXaDN1upm5hD38slIgockhrB1PQqVopHaB5fTF9A3MURjqfRyZxQfyAtnfpfNtj8VmLdaNfCumuE79YXtRKNSBTIWZ42U5wQJG+FrHp/lvEE0Nwwj98HnKmr3MTV91Y4ue7hCSZ+2i2irC9G8HhDkMHdSj5ErFQbyZ8tUXU3PO9TNAUjsauNABCP25pb+QF1gQKqULbXdemHVMYPL/uGeBiOPtsngwQa4DaJry85yXLUMPThQPVy0+fqyT+8ITQ/RLZy1DLrvisNupik/NCP07qt8wCKXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rX/wA+t+aHZYu+3/u+EOOgDnMcRG/DiOyXTzNVO2sRY=;
 b=jTzhWtkcbl1hH0kK3U0ygHrPu5o6moluGBsunORLLoAk9WOvEPJnJLxKUdTmX86+sI0WItJbjrfXJDaAX1Iy0alEC/cBINF5bclYrkZvoCWxDiIEUZ5AMrO3V7UzQJ7XK9IvERuOdZkCtTE+QKuMc/B58EAUFHgYkEH9t1SH4AR/Etw4hZSpPpQwdbvC9j0gEKatCkJVRwFl8HqVP2EnZ8pj3tdjzfwNw1tTGRKFOyf8Eb0d/tep0/f/oM8D5Hc7PESWxC4w5a4I/6Cal5aMDW6MKXtb1/wRD1LA95ept/sZrSauXt0B6ybdSS1Rsx081GPS34ZYYPdHxnC0YK+bGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rX/wA+t+aHZYu+3/u+EOOgDnMcRG/DiOyXTzNVO2sRY=;
 b=UDQD1gMz9tmMlGbvsxLRsjGpboY56kn10GOs6PZrb6BY24ukePshWbwf6nOVr9vwTeRIZ4GjhP2XJkizZmWbtCH1CaNbp206XUbHiKdSn7W4CuvXpFBmfaLkCTtTQ/vUMXblrxc9SKKYNduEzdMyy78GQNM3a2tW8B4AN8sOlPo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB5177.namprd10.prod.outlook.com (2603:10b6:610:df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:59:53 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::f3ea:674e:7f2e:b711%4]) with mapi id 15.20.9632.010; Tue, 3 Mar 2026
 09:59:53 +0000
Date: Tue, 3 Mar 2026 09:59:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
        Eero Kelly <eero.kelly@dfinity.org>,
        Andrew Battat <andrew.battat@dfinity.org>,
        Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()
Message-ID: <6d329e4d-ab33-480b-b1d8-646cf6aa1fba@lucifer.local>
References: <20260228010614.2536430-1-ziy@nvidia.com>
 <54a4d554-d4cd-47d2-bdc1-8796c5d7d947@lucifer.local>
 <34AA9329-A6F3-48C4-A580-8BE3E4F9A3A0@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34AA9329-A6F3-48C4-A580-8BE3E4F9A3A0@nvidia.com>
X-ClientProxiedBy: LO4P123CA0489.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB5177:EE_
X-MS-Office365-Filtering-Correlation-Id: 2754c8a2-52df-4b4a-39ee-08de790b9de2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	Qz9K640wFr/O0ETJ62Lw9abelOAyxoyU69Ed0c5Hk5h3fGeH56ezLbS4agvzm4UDWZCSK7Kymod+vWNWfbdxeWLl7Q/ZZv8AlUYm6vUPsv3+OEcgfXhkGPAhqz8Ns7MiK153R2n4r94fM+eUop1G8NFsI2m/QxpuSL3OQzxCfHMT1ntcUFhW49loqMQMVXHMPuU54sfaKbU4zeRy9dN+o0gKXpoc9jOizoWf2DrU60zhwnwp0SHEncueAnCs8Z3o6JPi1fMzGqQOBAGtXKWDcHe81GoZ2NKfieSmnpWwzWZtsbvrOHo4Ned36Y1Ig1o3RIyLRaS4Gutn/GignJQJ5L0fdMdLyOtcypILv0wP8TqqcFLNgye/8yuyL1EbLgFosaSP+WugV4YfCtnygE/mBw9+yXYQXfLvoqrJWYAk0Q+0ec9El2o6IQXN4pTlRf43b1dBNWhyvt0e+IlA31BZnvMYJgw+x7HWjIYndWgR+js9XxPd7+W1q2Gv6Rv88ZjSF5iT29ZRpXLnEvjzq8YJaEKcMByLP17D9YH6wn/qOkFcNuuRzLF2mSjC9uDOdrtoxiYLv86Brl4753ZWybwhenKfbniExlSbyqNnad1PlvoeLY4O2I9HLaBKIsf2C8cH7Qebhg5EA7iy7gZlme8IeANu1ywjjxCqxqmNmLh8HhIP+BtW0YXoJQn9iSuD2hyFSVy+sn97dFOvA0dv1loXJO40xS2KO+YbanhSN3n2rO8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?910T/GdER5OES3gqg18nHytarvpGIv6C2g3DhaQesJIbdioNC8IrZ742uo1K?=
 =?us-ascii?Q?EN7pobxRpSd7tksGVStbcOIZlQ2h9XwTqt6oFu619jJcCAHKczqlFVAJHj6l?=
 =?us-ascii?Q?rUhYaxHnu7z12QjLb65R0WmLB/kXxTAwjvpvdgJ+ZjjhXfCSBYcMbX16acY+?=
 =?us-ascii?Q?AYxSeqxeJc33CGh9ZxPkpcLDbgGuF6O/aePSdv8kqgqqe0sZuzdSO1bw1Sxo?=
 =?us-ascii?Q?LpVVwOZqDsAUJH+MrgncRIh49lc+a8wycWveK+dxXZ2safzT0K1O1WxcvLDk?=
 =?us-ascii?Q?IykXt5G15ayh4cLlH3dkK2CeP0riaiEhbHrIUEPEtkSxtjX3uvc0HcsPuxrw?=
 =?us-ascii?Q?zdGJuDCBsvtTL9/AAOS5H3dOhh//iQKx/PtMyfPvxQHQ8eG9o8TYSPViNb37?=
 =?us-ascii?Q?eUp0h+pYJo8tKNOaukKL7D5kQ5/Xj66/yEV8LAhHSgzdo/giqjjAq8wcE/da?=
 =?us-ascii?Q?VHH9Ek6ssvMeyVKERNLxagP2EEFspCWYQwXmSVl95dSP/GGR917O6JsB9Okf?=
 =?us-ascii?Q?28Xyu95MYRwhyWxyF0wRpA+JwCEa3sDxwIdQoQcBLpMRWCIAd5ZczjQeOVnG?=
 =?us-ascii?Q?/o1J6rvFkvwT/QbNdSeZn19J72SKj5qURVPiH7+eLLQnzNKF/7yXwHw0I4B/?=
 =?us-ascii?Q?XY2xN5hBew5vS5i8jS5KdaMQyrTtE+Gx5auLDcCQPL5Ymhd5PDQ6brRenINH?=
 =?us-ascii?Q?c0Zi7PGC0oawzBtuftXYDoDndVssATIWA29ZyF32e71PwjNGicO6pgvfp7td?=
 =?us-ascii?Q?Xw1NAFqJ61arnkUKQOD8prDdNYi4w76UX7SBYYyTlEEKPg7avevdF3wurEwF?=
 =?us-ascii?Q?Xiwo1iatli1DL5eYoOlGPTKXKv0coAzXAeje2DR21G+OZrCw5imoimHp0dQS?=
 =?us-ascii?Q?m3liN3j9lxYMuyxX5Nfh1uk1a/vk4FfeuwHVbmoCtDm3dHN3CwFlZHDDglQq?=
 =?us-ascii?Q?88rksd83T+lMsDpynCLjOf93vo7of2D4ZRHt47oyf2Z/gxvNOxNkMs2RS5z3?=
 =?us-ascii?Q?QQdpQwnIYza6Fu4QNQzCZPZw7LOxyvbNiXCvkred46GbjJVjLSwY9EoDz/Z1?=
 =?us-ascii?Q?gVW09RfXii7OfiTSodVt4dMEn5iys3EzEJHfWiC3/N0UOLn7+XF7JNT+0oqi?=
 =?us-ascii?Q?0wBcV3W/DhJW4OGMuZ+yVnEmx9dq6yj91rpcYT7njw7gZi0hn+LaMbU1GmEV?=
 =?us-ascii?Q?R3Fu6ThRI0T1Cx7QxtIfvxrEjnhBXDkE9irYgePYo44LKXRNRHcyNIdNEV02?=
 =?us-ascii?Q?0gXntJWAba9KcyPi1FF3JMoMppv7H1TpI66nGOhOobFqFvmpVUkvKfTWf4w5?=
 =?us-ascii?Q?YOc6kEOoYURmDauJ5wirp5Q3CxM/yUX0tDaXtOiUDBR+WWsU+jjnHQoRrP3u?=
 =?us-ascii?Q?qEKq7zU0lIkXZr1eZFLJCGlO9oZqLdSgF4YK1kfPkEDjpiQGpzGntXpK8A8w?=
 =?us-ascii?Q?OeCnWSlvl4U9otmqSkNfxuiaJnb8U45SZIQRFSLVLFAeU/5M378P/kwllYJu?=
 =?us-ascii?Q?tAKybxL5RzDK/156usQ6WpRtSH4XpOTGJWvdNnhdzoeTNEAKkRajPZNgNXRD?=
 =?us-ascii?Q?V58LTI1xykVcoUmP5igZtV//jtpcbbDlVRBZhSpWeZINkjfDDm1AnqyCAfRE?=
 =?us-ascii?Q?ofkHtneviqa0koOpPyoNxqFWrAZtOgl5WmJUaonLDf6A0nk/wXX2kBqmgWXT?=
 =?us-ascii?Q?c9Q9tIkZLT4RLUY3XCcEwwiPdyUB4xPK5tgS7G38OQEf9eA/4SEFHUWSo3KU?=
 =?us-ascii?Q?TxrDIn8CUWnbPd10FcvJXWDEs6idIGQ=3D?=
X-Exchange-RoutingPolicyChecked:
	baOvBotKvaL5HloTGNBV53KEEU+9tRNbULmdIx45elbdRL8+rYPOPp+Ug8moOpOsK2pBU7P48XbIUkRecEJF0x/4pYRhOBU07enxmus9Z4HeV+uk4z3mdj9a+yUarAyifkM1rw8m3C5A9T4bfBq6co3IWeEBnZv6Xqq684ozSL2C9xUHl7IkyHKVQSVQTzIghXWvp0OznhzYg+vkSRFWAyp6r3ZjgSkRG2Pf6iMk8gCjjKemllJrQYfhnJJ8/HFXdpieCrzTyE3ZgfpE5YQF7CTzI4dp1S+gHbGejIgnnIM4KIPxHh33gjcXztfNREY/8hDTatwyrp4ibbuhYT4R5w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XeC/gbLv3MlYnmhkbchw+6Cd+L+mKRZBko+brRdAblsepcLPutiZc8v1kdvPMdlhTa/Gw7vzJhlIFnR/Ls+LxzK8O6k667k+c0k5V2bjWYg0bASK/P61JZ0RLzywtWInsNgGE8teVihIYjeGEl6frHBz32QYqSCp3vk5oHYh/W1+AT377QKNhKCY2UZ87jHwULoesKesDI0fRuoNWulJc0aTWv6EMLzcJlN2A4P9iHtGkr/AGRx12bikBharDIJVwoL8AHi9iHL9/YIwUacA5EKfHw84Fa6kmcuCmBhfmupbfSOMBtipCdGWvhDDGKNy8KRLeYhWf4rKjaufuGTR/js1+AaWIcqJkzPtEmPazg0isdBWbtP6GIv09gzFwcyCsIzAoDybyzkAn9zOGv9DSP0L8VYxKroePWmy2szaz3pv5tyg6AVs7DYnDo09GlWH8fcBItMc+uvEYqah0i/prBLV/xawIqD/WAKFypNiAxozonYnSK0Nu6IOBj0ynJwE12MNLlGPWAwYQ3vkfZKRU5TfskKZLfqVUFRhOLR9820LfZ4QIjxyhxdBvQwm5c2HphaJ/6CKPY7jtMhLghmDIj/uIo+OyKvbnaAoYwLWAHg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2754c8a2-52df-4b4a-39ee-08de790b9de2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:59:53.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IDhPIrWD76qhHQ7GIyo1bVEe7UW9Y+af6ctGjb7jSrVy3SObjWm/qT1UKNXt7HNGJkqw4STWJQvRbLv/ujntRrdngDP9Rupd3O7TOcknhK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2603030075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA3NiBTYWx0ZWRfX08FNV1EBxkUZ
 OdgPq4gUkoqxLw5MLc5DIKhNMN8I2oKKnt+h01gnf9y2ydxMe9lIS6sO4AYtZjKcPajlNa07ZsY
 xN9AMSiMOzvjLwoSH/iBnaKaQeS1CvRGHH+gRW9RLe6c7ah7sX45owsNWv35A9CpnilXSGNjBIM
 RgRzYB7KKNGIIlCQ7a8uikeFTRfgNjf9zyfaFHfidrQrl23lYp/r8Q9KRQ3rH1R5ipkDbFv+cPN
 zlMhwJljoWPiuXPjfMaxv1pAV8431r3m/LMtSzcF6BZMuxBamb2TWF7e0ejBW7v9ii9Qoec7Sn8
 VBCQcDybBJ5s0oc2l/fshh2PdDAMbZupxpOZa9t/qBpE/3DuWEZOzR/DXIVOCGqwiqXVX2/B8ax
 I6r/mBi8QRy6hDQnYD1M6obLs1IF1jms4N6Sg5aZKZ3+UHZLB2s15RQciD/9EHvo8ooI2BXb80Z
 umTEBaeRw8zwQ/2Nqew==
X-Authority-Analysis: v=2.4 cv=P+k3RyAu c=1 sm=1 tr=0 ts=69a6b11f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=m6ntEmJwAAAA:8 a=Ikd4Dj_1AAAA:8 a=v3cXGCnmPIo0xfcPsPMA:9
 a=CjuIK1q_8ugA:10 a=-07UcHROD-JCDqjaZ46G:22
X-Proofpoint-GUID: Z4-mck-robyNzmTshZxppXdUD7uh0WnV
X-Proofpoint-ORIG-GUID: Z4-mck-robyNzmTshZxppXdUD7uh0WnV
X-Rspamd-Queue-Id: 360371EC384
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79131-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.onmicrosoft.com:dkim,lucifer.local:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oracle.com:dkim,nvidia.com:email];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo.stoakes@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 11:30:39AM -0500, Zi Yan wrote:
> On 2 Mar 2026, at 8:30, Lorenzo Stoakes wrote:
>
> > On Fri, Feb 27, 2026 at 08:06:14PM -0500, Zi Yan wrote:
> >> During a pagecache folio split, the values in the related xarray should not
> >> be changed from the original folio at xarray split time until all
> >> after-split folios are well formed and stored in the xarray. Current use
> >> of xas_try_split() in __split_unmapped_folio() lets some after-split folios
> >> show up at wrong indices in the xarray. When these misplaced after-split
> >> folios are unfrozen, before correct folios are stored via __xa_store(), and
> >> grabbed by folio_try_get(), they are returned to userspace at wrong file
> >> indices, causing data corruption.
> >>
> >> Fix it by using the original folio in xas_try_split() calls, so that
> >> folio_try_get() can get the right after-split folios after the original
> >> folio is unfrozen.
> >>
> >> Uniform split, split_huge_page*(), is not affected, since it uses
> >> xas_split_alloc() and xas_split() only once and stores the original folio
> >> in the xarray.
> >>
> >> Fixes below points to the commit introduces the code, but folio_split() is
> >> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
> >> truncate operation").
> >>
> >> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
> >> Reported-by: Bas van Dijk <bas@dfinity.org>
> >> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
> >> Signed-off-by: Zi Yan <ziy@nvidia.com>
> >> Cc: <stable@vger.kernel.org>
> >> ---
> >>  mm/huge_memory.c | 9 ++++++++-
> >>  1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> >> index 56db54fa48181..e4ed0404e8b55 100644
> >> --- a/mm/huge_memory.c
> >> +++ b/mm/huge_memory.c
> >> @@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
> >>  	const bool is_anon = folio_test_anon(folio);
> >>  	int old_order = folio_order(folio);
> >>  	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
> >> +	struct folio *origin_folio = folio;
> >
> > NIT: 'origin' folio is a bit ambigious, maybe old_folio, since it is of order old_order?
>
> OK, will rename it.

Thanks

>
> >
> >>  	int split_order;
> >>
> >>  	/*
> >> @@ -3672,7 +3673,13 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
> >>  				xas_split(xas, folio, old_order);
> >
> > Aside, but this 'if (foo) bar(); else { ... }' pattern is horrible, think it's
> > justifiable to put both in {}... :)
>
> I can fix it along with this. It should not cause much trouble during backport.

Thanks!

>
> >
> >>  			else {
> >>  				xas_set_order(xas, folio->index, split_order);
> >> -				xas_try_split(xas, folio, old_order);
> >> +				/*
> >> +				 * use the original folio, so that a parallel
> >> +				 * folio_try_get() waits on it until xarray is
> >> +				 * updated with after-split folios and
> >> +				 * the original one is unfrozen.
> >> +				 */
> >> +				xas_try_split(xas, origin_folio, old_order);
> >
> > Hmm, but won't we have already split the original folio by now? So is
> > origin_folio/old_folio a pointer to what was the original folio but now is
> > that but with weird tail page setup? :) like:
> >
> > |------------------------|
> > |           f            |
> > |------------------------|
> > ^old_folio  ^ split_at
> >
> > |-----------|------------|
> > |     f     |     f2     |
> > |-----------|------------|
> > ^old_folio
> >
> > |-----------|-----|------|
> > |     f     |  f3 |  f4  |
> > |-----------|-----|------|
> > ^old_folio
>
> This should be:
>
> |-----------|-----|------|
> |     f     |  f2 |  f3  |
> |-----------|-----|------|
> ^old_folio
>
> after split, the head page of f2 does not change,
> so f2 becomes f2,f3, where f3 is the tail page
> in the middle.

Right, I mean from the perspective of looking at f we'd only see f + some weird
stuff in tail pages, until order is updated?

>
> >
> > etc.
> >
> > So the xarray would contain:
> >
> > |-----------|-----|------|
> > |    f      |  f  |   f  |
> > |-----------|-----|------|
>
> This is the expected xarray state.
>
> >
> > Wouldn't it after this?
> >
> > Oh I guess before it'd contain:
> >
> > |-----------|-----|------|
> > |     f     |  f4 |  f4  |
> > |-----------|-----|------|
> >
> > Right?
>
> You got the gist of it. The reality (see the fix above) is
>
> |-----------|-----|------|
> |     f     |  f2 |  f3  |
> |-----------|-----|------|
>
> But another split comes at f3, the xarray becomes
>
> |-----------|-----|---|---|
> |     f     |  f2 |f3 | f3|
> |-----------|-----|---|---|
>
> due to how xas_try_split() works. Yeah, feel free to
> blame me, since when I wrote xas_try_split(), I did
> not get into all the details. I am planning to
> change xas_try_split() so that the xarray will become
>
> |-----------|-----|---|---|
> |     f     |  f2 |f3 | f4|
> |-----------|-----|---|---|

Ah ok I see :)

>
>
> >
> >
> > You saying you'll later put the correct xas entries in post-split. Where does
> > that happen?
>
> After __split_unmmaped_folio(), when __xa_store() is performed.

Thanks!

>
> >
> > And why was it a problem when these new folios were unfrozen?
> >
> > (Since the folio is a pointer to an offset in the vmemmap)
> >
> > I guess if you update that later in the xas, it's ok, and everything waits on
> > the right thing so this is probably fine, and the f4 f4 above is probably not
> > fine...
> >
> > I'm guessing the original folio is kept frozen during the operation?
>
> Right. f is kept frozen until the entire xarray is updated. But if the xarray
> is like (before the fix)
>
> |-----------|-----|---|---|
> |     f     |  f2 |f3 | f3|
> |-----------|-----|---|---|
>
> the code after __split_unmmaped_folio()
> 1. unfreezes f2, __xa_store(f2)
> 2. unfreezes f3, __xa_store(f3)
> 3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4,
>
> and a parallel folio_try_get() that looks at the second f3 at step 2
> sees f3 is unfrozen, then gives f3 to user but should have given
> f4. It only happens when the split is at the second half of the old
> folio.

Nasty...!

Great thanks for having the patience to explain it to me :)

>
> >
> > Anyway please help my confusion not so familiar with this code :)
> >
>
> Let me know if you have any more questions.

Perfect, appreciated :) I think we're good.

>
> >
> >>  				if (xas_error(xas))
> >>  					return xas_error(xas);
> >>  			}
> >> --
> >> 2.51.0
> >>
> >
> > Thanks, Lorenzo
>
>
> Best Regards,
> Yan, Zi

Cheers, Lorenzo

