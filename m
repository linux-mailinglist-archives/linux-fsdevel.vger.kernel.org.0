Return-Path: <linux-fsdevel+bounces-56879-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D62BFB1CC44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 21:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0879D56199C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83329B782;
	Wed,  6 Aug 2025 19:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZrEk/Ht+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Rs6gZK/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A07B1C1F22;
	Wed,  6 Aug 2025 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754507048; cv=fail; b=U1OHnOQv1XHeFwC7L0JUYxGaDXbQU7RIttb1wXdP++5rnoiqxzMg8LC/17MD9WuXIZ6CoTL6C+O0WMj0cgEN8fDcaVvktRKNeNoXjCM82GdR3Xz/ZoPbWAFqspoFyHcYAdpkONeLjFLJg8v5BykD1crr2ZSPs+x9tRdSyvF+buQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754507048; c=relaxed/simple;
	bh=rgevKxkiv4cOo9KC0DmhJsuEWDapdmgP3XSE1K9VyPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PrZ74Lq3u2/d6vySnBQ8z1Z28wAGYwekJpvsQVzulz5Y1qqK/AuWAIkSdaYaQp6jfdTT/l0b5RXU5QeDi4YYpUPEtCl07NEcrOVR71GAkQKgm2RNd7KZX3l+bOTKBEEFkzqC/2aUoGByECp/wYgBFaBzcgpj58MqGfmD09V7dss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZrEk/Ht+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Rs6gZK/J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 576GRQKZ026062;
	Wed, 6 Aug 2025 19:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ZwGMKc/0jQQYol4tn5
	miS58z4LofX1f5D26iapJFycs=; b=ZrEk/Ht+Zig8NnH4DbGIgzspvfHoaPDooN
	cU1AX5p3stczMwXNdZu1zeLpou7HVBA8inAsOtiaq10fhVp8MuT32iX9LyOaTY5Y
	j/MikowmDze9i/Ozlt6k5apYlMB3atIQlAQUwTB/sjan8UozbZ/4m3pVVxOcQWst
	k/WNtsGZxAmZl8B0x3duL4y3wbvjh68w07gCMdnJXNR2lxvhUCMqRX6UPkSUf1rq
	YwhXKursggvcKdzPmnlzJAYInhpPnhqnNbErn/D1YhKbNRi1tLbYpnEYLHXfi3SK
	ntQfG1gvhWZYOr6BetgNhDiQTLhM9nljllH1Zo8laOmr3+PMnb2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48bpvg2f5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 19:03:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 576HYO5q005770;
	Wed, 6 Aug 2025 19:03:31 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48bpwxenny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Aug 2025 19:03:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcChY7AwaQzKlzeN4nJ40gIdwMfVol62ouAEzGeMjl7muYxaauH8oOMqcaII/B0BR7QrvNalvlYUSSNyhy/pTrZ+6LejcG7KXHreV8aCjgYoEEN0nEX6MMmolcOE8fTRXUwgThfBphPXcQ9scRlixFArpdYMyQUrimd1406HV8hbXnQy5r0PFxuOUUd17eZ6ecT5d7GdBnhqYXZFvlKEwNAaP+L7XURPxsEp0uduhfLgQXiOzLKQNn2j3coLUXsHF+hSkY+aFcsSGoJ+XSG9vf53Ioha0KclJIP8DZS4hR2rwI2jmciUJnVI8TdKwazACd08iJu+iOPTBFVWy2b4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwGMKc/0jQQYol4tn5miS58z4LofX1f5D26iapJFycs=;
 b=yW1ciKKL771gyhYK9ArWUNzG3tyAda+1j73Rt9gmRmyZZiK6gArtNRzqhlhdFpnPfrDpUDcC3h14Zpg13WiwR5q4GDF25y9nu/g5GybBJoBCnPEk2KQx5ghr/QvXp4xmAeZVRpxozOr1EkJjo22lv1qPcGEgHtk2BuVD/1k7Jn8/udeOujhaVF0b7f0E+1VEOD9Y1/tkgjioSACY+Ps+e07MEVePIMReuQXwfFQWGxOscZpR3ZM+JAAD2Ex85jHJaCk2+myJ/jPHsFFO+fZ9tApP33Ee4+n0yDOvf7RQLb5rfBfGHkrGDGXajdZnMwuYYLQNtlgAaKolSL1908nEKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwGMKc/0jQQYol4tn5miS58z4LofX1f5D26iapJFycs=;
 b=Rs6gZK/JVoy/WSDKT4svSraooIV6UXxkBKM5Rhacnap3kB4ESfDI1h9DhvBkFCznIr5U0M0CILLge6gB0jPohvhowTqfdIEEwf36MUeE2zKKrznzzNnFhZEcKqFBe7LAuhwDUtJ5aaw61/lifgJXaNDUn5XBGYxzzZCuWaKvIK8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MN6PR10MB8072.namprd10.prod.outlook.com (2603:10b6:208:4ff::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 19:03:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 19:03:02 +0000
Date: Wed, 6 Aug 2025 20:02:59 +0100
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
Subject: Re: [PATCH v3 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
Message-ID: <8ddff47d-3059-42ea-b022-6151da513049@lucifer.local>
References: <20250806155905.824388-1-surenb@google.com>
 <20250806155905.824388-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806155905.824388-4-surenb@google.com>
X-ClientProxiedBy: GV2PEPF0000457C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::41b) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MN6PR10MB8072:EE_
X-MS-Office365-Filtering-Correlation-Id: ffa2675b-dee1-4b89-2a26-08ddd51bde28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cf76u8V/aRQqhk8jYaB24QgGWcP1/qENe4U6Zdbp4euEXMUe55xtvG+TxPIW?=
 =?us-ascii?Q?ftITs3mmlNlXSAUJ2wDtn/qcf7SL6EwX7oQG/AMemkzqToUGMY4A0YL3uWVw?=
 =?us-ascii?Q?ckwqWy6Gp4TNlfwvScEVg4YZJQHa4we1tpZRTNP60zgPuhIPv0ta02rQjzcR?=
 =?us-ascii?Q?7N3f1om4Y7I+jCz23zthquPVKG4dlsjCPxutIriC4S9nnr0m+B+TY0Hb9Hvs?=
 =?us-ascii?Q?vBNs2hh2SaqzMUgpsRqkKp/8WrQk5AGmpz5PH4TuHcyQsEIHmQx6Aq0Ie1JI?=
 =?us-ascii?Q?HGkVUQNTv+bhDXXn8I8LYaZ2TQLK+4VkF33ONF/XWIIr2Zd7ny1tMw6VBQIl?=
 =?us-ascii?Q?khEB1dlTEe9NedYiDeo3aDcn5rkdjz4Z8Bn4xTYmrRyLGfmKJEDI05Ae7B9k?=
 =?us-ascii?Q?sF3qhDmX8IxwcdqfEG6anpnDKJHaZmv+ShhxYaKoUL96JEHPt8/Wiol3sww3?=
 =?us-ascii?Q?U79f0CuLn+msofR2SAVOZn1AyixGema4P/hTa2+oLZ1wEU9j0Ij3HMGToev2?=
 =?us-ascii?Q?TbexyEoNlCTNi/7mRNEFAztLdAXInRHlPS98CXW0x8B0CiEogt2uhBdOLG6d?=
 =?us-ascii?Q?MDBV6+fC2K1yFx12DEMaUBxRXkMQHCGMLw28pu8FYy/O1fWy0i8bzUZ9nSCA?=
 =?us-ascii?Q?iaN982F/rLx57XTQnX3GogaVNl/IrZv22XnlWTdouVkG5nmkQF0kh5ilV2Po?=
 =?us-ascii?Q?wmJUHuevfbQnQUnCjmrQqN1PIdrHbWbFiLSgtazVmjofoXYmZvJBNJEcZ9qk?=
 =?us-ascii?Q?Z9TFd6viHLLMUb+CrBIPrCx4YS0BZlixKj6yz7yyhfz7wisN1H9DKuU7d1tR?=
 =?us-ascii?Q?2A4g63yWErsEqigaiEoUJcZ3+x8LRuRto/tfb9O5ZsyZmB6mWxuooGdxABzc?=
 =?us-ascii?Q?pcZKryjduyjmHxR+Vb/JaefEn7SLU6DTQu4wkmU6QHDnTzpxeHEGIxcw7YdF?=
 =?us-ascii?Q?IgpedtQRX9v9pm5juu0chehRAu7u6mjwivUMN2TeqsPhhTo63QgohRIdX28r?=
 =?us-ascii?Q?0c5KkabZvuk4/wkaa3FQYgIjx83dWQQNM4S9TtP0hqXo5Iwc+4fgEnSQLL4J?=
 =?us-ascii?Q?ADtE/khcLfZ4XJj4Ed2JOib+yrPFr5DtIuFB2Mt2rL/bc8wF1oqHGfK6XkxN?=
 =?us-ascii?Q?eklQZbwUwK9GftJE0drtY9x5utR2zoAxEMoeOGT57UN8iwKyD8iYQeLk1t6W?=
 =?us-ascii?Q?hbBsHNDl4jbqhS9VjrvW3TUqVkP0i1bvrRQgc4/koIwyOcnRPkcO1lHuhnqG?=
 =?us-ascii?Q?mOXc1Q7j3Z2QwE+R1fm22jRTRTBZKxbN3Kv9cYSnvC3yPA8Z6541vz/3THcW?=
 =?us-ascii?Q?Ig579y48cP88Qyysf5prk0Td6eFT8gNumtDmSSfZ7fgwPx2JErAAP5cP6pgW?=
 =?us-ascii?Q?1G+jhwGj+/txRIqCPDu948Oimo3OSOW1slLFQmW5K20GlvAe77bTfCD5OLjV?=
 =?us-ascii?Q?N03rAY/w1w4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?akFCsfGRZGYEMyPoCoNm3i40injbo/F4EIsw9iuEoc2ZY/giXRr7weWUkCtn?=
 =?us-ascii?Q?VYmM2mx8JGTaXZVyPhRlDxeNdpAr6mt1fTm0yKNGPHdrMw932K3yj7ynQ83Q?=
 =?us-ascii?Q?YVPxKop9dFJMovqd9d80RfW6fs/If5mS1lJnNhReFzIJ1VjMc7T/VDolN0O5?=
 =?us-ascii?Q?2tatH/IapHQ0oJ9X1DIcaiE9queoSWCAB5cCVjQexu/gkgyhzU1xMrKHOtpy?=
 =?us-ascii?Q?xRNzxWSjWyXAVqDfu76i2IIW5m5iaLLCZkCN9qS77YW5+thBaUqcKNYQJlQR?=
 =?us-ascii?Q?bhyy2s40er2fIO1ymElZ7Ey4bi3l4EihhjqkbvdWhNpdDRhr6R1+XoY1KIwu?=
 =?us-ascii?Q?dfTbfzELx6efWBTE83TP3YMtpwfl1HQTtGNDO04drqDPG6a6Cdon5Cwy7jl8?=
 =?us-ascii?Q?DxJKvzqNd15KegTjQJSP7kuXdlrz+tt+uKIfJbxKLhahUt3QObpDy/+g9tg7?=
 =?us-ascii?Q?CPFFkEwhLwQKJW2mJyJL9/m/+p7uyv9BLq4H3FXZEia3/dLWJNwcd+Q/ETaM?=
 =?us-ascii?Q?1jVH7QkfhD5X0/nhgq7DKqOKpU/UGOz1k1rxPPG6E8faKIzsJER+I7FNcu3U?=
 =?us-ascii?Q?fI+WWeZSwP7X7XSITy8qX9hS+PCB/Ompvml1CoNLylPe8uIOV6r4AScIcSsg?=
 =?us-ascii?Q?a4OhtJQgbM9tf3MZCuIpqIOPr7svAUMa/2z9Ly43pzQJSL9TYFxFG3VeX4J3?=
 =?us-ascii?Q?2dScg/VLAQejtjJXVIwVOk4qSQTDdLDuHgohGEZD6D0HAFwM+X+ddopmTkf7?=
 =?us-ascii?Q?Rta4G3YCH66GxW+MWM35pFmw7MHDYjb4HsF4wDR6+APsBmfFqEjMfMepbqUm?=
 =?us-ascii?Q?VmVBsaOMiJjOQRpjLc/f9yA7BF6yTytIMscg8gsUwRXz5FcGXP3O5NiXnF7/?=
 =?us-ascii?Q?qPhnUTC/l9onc3oR6yBNcndq72mZKo4Ys8x9rjtMLdmi5wJfFKzIjpmNw8+w?=
 =?us-ascii?Q?+uO3FnQ1C+0Jh0KED5/P0vcgzO/vl9DX992tCFFK5uoWbTD+3C3FeP7LQOW4?=
 =?us-ascii?Q?09XmRwOpBrJTb2rd/lV/9C6tl21NF19PMlVEbw5g7JEOiafqJUPQBMvRLQC4?=
 =?us-ascii?Q?Jg7SxnMkluTH0j5eTbWZBEskLSHxqecHcALuKwRkjis+VHp8FeJIMHFitrih?=
 =?us-ascii?Q?96/dX+c9SK7w70BgsEJyaye0vSvdwe2AIh1E6Dwpyja6BFzeVhttoKjocg2A?=
 =?us-ascii?Q?yWPywOSwjKxIQ3kzWNiDht1h5bMVIsIrTHfhHt9VZ7WbmNWCEwd3KRT0bokb?=
 =?us-ascii?Q?EPuNmiiD7CPc3zJ2RtVi56umJGPOMISLNP4hlSfH6NPWxnam2IlUDNbxLHIt?=
 =?us-ascii?Q?P4NM3zMEmxxXE9AlGtJSoJp7wce0qhLOKEep9wCGc5LgsrOkspKb2ZVN2V5m?=
 =?us-ascii?Q?PBifCCLBMwluJ4ilYS9xgYMy2qbhYSMeMBKW7AFeuwVmAX8aXueIq4ldFx2t?=
 =?us-ascii?Q?nejcygF5K4oiJAuo35gUJ9B0kj9E7hF+8UpVEc8e1TTN5E2S3BCHEY6pDl4A?=
 =?us-ascii?Q?EbXiQ2eaV6X2KhGDDIwlKRgDDpMcjGrCFXargo7Yd5ksy/a5laG5TMyVn318?=
 =?us-ascii?Q?D11Sj/mWtK4Q8YLAmll+gKFxAcxxa6lwqGY/v9izGG1zoKLKCtjGMq2MZydO?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wRG8rtQq/TprMu4PCyHN4f3XMWPMWjlyzSKYfbLDaCNyKRwIynKD7ckqPgYp/8FcDnWvkcmgSZn77tiNo6CtuOMmpG5IYpS8BrctEf6TrZGZPy8Y9eXaiAGcK1sBEYiMFlezRj+L8zP4TnVHtP+Ghzkv/fu0snZ7UsfA7DvP+sfO6oOcSOk/7Nx1rnVRvlVXO2gFqqdyrPp+N9X7zyB2Qp2YUNRO7upzAcI2m2kMiVsPAqtsiQEcI+E63OBJniRz2XEJH3gIorgU3x/Z9KpwAb8Vqfc/063sX0SwYcgfa4Fq6HRA8Y87QNFE8Rvd6a7NYj27TucQ2RVdXL6D4lzA83rAEIrWxOxQmlM1qqL3wilgvYGrJsNa/c26ifj8j9sTmkwsfDqsKbGfSKMEQyfu+oL7oYIai1uf0YdMJo3H/tdRDP14d16CIxpzUv3v628A3C1fn6NVYn3oZihmVo9XzJNiHdRLwTgVBws2pnuVSfzQH60kcNHTBuvqSmxekHnvGbDoJp35ui+QybX8sBCCiXGs/O4qPiyWvolJFmBDARbL/zLEo8IPyrxuI31n9yZUDF6X82XmkwIlrWQ3lg+eH2gmlh2QXXIY9QBW6zuhTew=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffa2675b-dee1-4b89-2a26-08ddd51bde28
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 19:03:02.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GMrfGLFgso584SrUNEAbSJr5NGX4L6LXAiYhH0JZIR+YN6Y7nbbCiydOdPOl57Hk8byfHQZ2Q4ww8iaQen5SkKwgoleQENkKML6lJNkyBtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-06_04,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508060127
X-Proofpoint-ORIG-GUID: -aA29D6Q63CmjRv6HoP1GiwRVwaD2FhG
X-Proofpoint-GUID: -aA29D6Q63CmjRv6HoP1GiwRVwaD2FhG
X-Authority-Analysis: v=2.4 cv=QORoRhLL c=1 sm=1 tr=0 ts=6893a705 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=TnhByqftUVB7tIxIOcEA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDEyNyBTYWx0ZWRfX5qzvdLSwaiZt
 Tn9lhSAhIl1KjiUHZUcg2x3SHxYrSpsYDpUj5AJQtFflqujldZhS57oC0jkOIZhIEN5ezesU6s0
 iiNKUFq26FlY/aPGVr84HIkoYgY/esYJGUQiAS9F7fiyi5bptdhKfzG385mumyZ0pf/owwfssG2
 Rymzanwcmc9l+kJR2NOS/5tf7xl2FO1Np7cWI1n/RUi9rOCWXXfrv1JiT5SLzrYtNrNnWBcPrhD
 jDOaQ/HZC6ykTOVuvAbXWNOtqF3bXKYxX873rJopMQeHfSSH26upEpBI73tGw9LR2UdaY9hoDzA
 uXtUsH9By3MRgAgm44oAmlVHPHokyc8c6PrwkYu2pb/wEqN4NlU6QQiwhZ2PTGwF9fsbso0oRpE
 hcVYDibHoPc6Wo0h46++Rbu2wGAj3PRHwBIw6aHLr9OvpC0hwmuu14u/UDE6Rzn2KlowlK4w

On Wed, Aug 06, 2025 at 08:59:04AM -0700, Suren Baghdasaryan wrote:
> Utilize per-vma locks to stabilize vma after lookup without taking
> mmap_lock during PROCMAP_QUERY ioctl execution. If vma lock is
> contended, we fall back to mmap_lock but take it only momentarily
> to lock the vma and release the mmap_lock. In a very unlikely case
> of vm_refcnt overflow, this fall back path will fail and ioctl is
> done under mmap_lock protection.
>
> This change is designed to reduce mmap_lock contention and prevent
> PROCMAP_QUERY ioctl calls from blocking address space updates.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

A lot of nits but nothing's really standing out as broken, AFAICT...

> ---
>  fs/proc/task_mmu.c | 84 +++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 68 insertions(+), 16 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 45134335e086..0396315dfaee 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -517,28 +517,81 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  		PROCMAP_QUERY_VMA_FLAGS				\
>  )
>
> -static int query_vma_setup(struct mm_struct *mm)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	return mmap_read_lock_killable(mm);
> +	lock_ctx->locked_vma = NULL;
> +	lock_ctx->mmap_locked = false;

We also do this in lock_vma_range(), seems sensible to factor out? E.g.:

static void ctx_clear_vma(struct proc_maps_locking_ctx *lock_ctx)
{
	lock_ctx->locked_vma = NULL;
	lock_ctx->mmap_locked = false;
}

> +
> +	return 0;
>  }
>
> -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
> +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	mmap_read_unlock(mm);
> +	if (lock_ctx->mmap_locked)
> +		mmap_read_unlock(lock_ctx->mm);

Maybe worth a comment as to why we leave lock_ctx->mmap_locked set here?

> +	else
> +		unlock_vma(lock_ctx);

Should have said on 2/3, but I wonder if we should prefix with ctx_, as
'unlock_vma()' and 'lock_vma()' seem like core functions... esp. since we
have vma_start_read/write() rather than functions that reference locking.

So - ctx_unlock_vma() and ctx_lock_vma() or unlock_ctx_vma() /
lock_ctx_vma()?

> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> +						     unsigned long addr)
> +{
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +
> +	if (lock_ctx->mmap_locked)
> +		return find_vma(lock_ctx->mm, addr);
> +
> +	unlock_vma(lock_ctx);
> +	rcu_read_lock();
> +	vma_iter_init(&vmi, lock_ctx->mm, addr);
> +	vma = lock_next_vma(lock_ctx->mm, &vmi, addr);
> +	rcu_read_unlock();

I think a comment at the top of this block would be useful, something like
'We unlock any previously locked VMA and find the next under RCU'.

> +
> +	if (!IS_ERR_OR_NULL(vma)) {

Is the NULL bit here really necessary? presumably lock_ctx->locked_vma is
expected to be NULL already, so we're not overwriting anything here.

In fact we could get rid of the horrid if/else here with a guard clause like:

	if (!IS_ERR(vma) || PTR_ERR(vma) != -EAGAIN)
		return vma;

(the !IS_ERR() bit is probably a bit redundant but makes things clearer
vs. just the PTR_ERR() thing)

Then do the rest below.


> +		lock_ctx->locked_vma = vma;
> +	} else if (PTR_ERR(vma) == -EAGAIN) {
> +		/* Fallback to mmap_lock on vma->vm_refcnt overflow */
> +		mmap_read_lock(lock_ctx->mm);
> +		vma = find_vma(lock_ctx->mm, addr);
> +		lock_ctx->mmap_locked = true;

Kinda sucks we have two separate ways of doing fallback now, this
open-coded thing and fallback_to_mmap_lock().

Sort of hard to combine since we have subtly diffrent semantics - the RCU
read lock is being held in the /proc/$pid/maps case, but here we've
released it already.

> +	}
> +
> +	return vma;
> +}
> +
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> +{
> +	return mmap_read_lock_killable(lock_ctx->mm);
>  }
>
> -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
> +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	return find_vma(mm, addr);
> +	mmap_read_unlock(lock_ctx->mm);
>  }
>
> -static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> +						     unsigned long addr)
> +{
> +	return find_vma(lock_ctx->mm, addr);
> +}
> +
> +#endif  /* CONFIG_PER_VMA_LOCK */
> +
> +static struct vm_area_struct *query_matching_vma(struct proc_maps_locking_ctx *lock_ctx,
>  						 unsigned long addr, u32 flags)
>  {
>  	struct vm_area_struct *vma;
>
>  next_vma:
> -	vma = query_vma_find_by_addr(mm, addr);
> +	vma = query_vma_find_by_addr(lock_ctx, addr);
> +	if (IS_ERR(vma))
> +		return vma;
> +
>  	if (!vma)
>  		goto no_vma;
>
> @@ -579,11 +632,11 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
>  	return ERR_PTR(-ENOENT);
>  }
>
> -static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
> +static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
>  {
> +	struct proc_maps_locking_ctx lock_ctx = { .mm = mm };

>  	struct procmap_query karg;
>  	struct vm_area_struct *vma;
> -	struct mm_struct *mm;
>  	const char *name = NULL;
>  	char build_id_buf[BUILD_ID_SIZE_MAX], *name_buf = NULL;
>  	__u64 usize;
> @@ -610,17 +663,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	if (!!karg.build_id_size != !!karg.build_id_addr)
>  		return -EINVAL;
>
> -	mm = priv->lock_ctx.mm;
>  	if (!mm || !mmget_not_zero(mm))
>  		return -ESRCH;
>
> -	err = query_vma_setup(mm);
> +	err = query_vma_setup(&lock_ctx);
>  	if (err) {
>  		mmput(mm);
>  		return err;
>  	}
>
> -	vma = query_matching_vma(mm, karg.query_addr, karg.query_flags);
> +	vma = query_matching_vma(&lock_ctx, karg.query_addr, karg.query_flags);
>  	if (IS_ERR(vma)) {
>  		err = PTR_ERR(vma);
>  		vma = NULL;
> @@ -705,7 +757,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	}
>
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(&lock_ctx);
>  	mmput(mm);
>
>  	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> @@ -725,7 +777,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	return 0;
>
>  out:
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(&lock_ctx);
>  	mmput(mm);
>  	kfree(name_buf);
>  	return err;
> @@ -738,7 +790,7 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
>
>  	switch (cmd) {
>  	case PROCMAP_QUERY:
> -		return do_procmap_query(priv, (void __user *)arg);
> +		return do_procmap_query(priv->lock_ctx.mm, (void __user *)arg);

OK this confused me until I worked it through.

We set priv->lock_ctx.mm in:

pid_maps_open() -> do_maps_open() -> proc_maps_open()

Which it gets from proc_mem_open() which figures out the mm.

Maybe one for 2/3, but it'd be nice to have a comment saying something
about how this is set, since it being part of lock_ctx makes it seem like
it's something that would be set elsewhere.

Since we have fallback stuff and want to thread through this new lokc
context type I guess it makes sense to put it here but given that's the
case, let's maybe just add a comment here to clarify.

>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> --
> 2.50.1.565.gc32cd1483b-goog
>

Cheers, Lorenzo

