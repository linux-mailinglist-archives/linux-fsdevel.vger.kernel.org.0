Return-Path: <linux-fsdevel+bounces-54162-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C32CFAFBA97
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 20:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B516C3AAD6D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 18:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C663264615;
	Mon,  7 Jul 2025 18:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvF47Bvs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yor70nss"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4A2620FC;
	Mon,  7 Jul 2025 18:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751912499; cv=fail; b=CAkKkQ7YA54nC8gwMp+1SjyfGhIojE+aEmlu+nvUBYFeV+Gu0YmAGi/q8rSJMqZWQ30AKxteCr3VyPSJ9ExBcbN4u9WJdddnrwS5W14uEHay5fCU0ku0A9546dPh6/rZytNhQD3zazXMffTCwe6oarTLgt0lO0BZ8OVoaQvnVug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751912499; c=relaxed/simple;
	bh=1QYbMJswSZDOenC1x+zoIV3gddrGWh/fw6aGeKH8pzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MRopBshBtSPRjQs69MEeBkm8icitxSRCs4oum8ztOsUaZYdRn3PU7+gvxshFtjnAxo4tNLbMuZvh9URtcMAAoWf+2/Dq80DOHZ8tK9NpzxytPZkm6/7+LTAnntWUAQvBLEU6DRHH1QJghv3PjDXpU2nq9zQKABzAi37xgQ/tVA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JvF47Bvs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yor70nss; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 567FprYq026333;
	Mon, 7 Jul 2025 18:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=8NloWdEdvHMsm8M3tI
	Ee9/PBWmhRvQEXAWANL4NLxtQ=; b=JvF47BvsnLvurfBLUxOUsJmBUdAatuEaDO
	wmc2W/FwC76hmf3X7d+IZhsi3x17COAeRnS9FAsuIScDz2E8vCo3jVTNaFbfdZFS
	P0R8Cp+cAupQE0LDTx8WLrPO7UNh6RLdf1zYczncUZeWWnd+UjWgtV+6iBlNPF2/
	TR5wEkcCSYbkJ+cEZazqlMpYnEvCC7dQ0OFH6Dcr5vT3KGriykRFD36dFJcixbWp
	hHBy45Fm1iGlrZBStqhQul1+Rf9uVGGqxWlQcS9DQmthVRpmLgoS0wUa1fulglD4
	gD6lankOoPwk8CLOA41tNVrLxOH2fE2KMvv/Gu1J0iv8KTe/rkgw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47rh8e8asm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 18:21:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 567GVOFJ013986;
	Mon, 7 Jul 2025 18:20:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2063.outbound.protection.outlook.com [40.107.236.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg8k99h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Jul 2025 18:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HySb4Rt/DkZ25nscGTNTm5tDoywDWKBpwbtGGrYi2rrCx6kx0BpQft8ggLeuu1udK9gD59+GmWN4qkkSZjNkXd6ghOwIqpJwPR2smSKECtpIoy8gKmQyVVE+1M2lHpbgAmj2qls1d3PTp0EX+4BskMRcjGkMdmIq/oyFhy+z8FVBbHDpcsyoAmGwniWXXF62rOJdqFikL5+1KrpVqGFDkbndVchjz5qh8PjLA2rsIWIXee5LwDcjyVKkNI+z7JbTJKHORD1hIgy9WldsWetr6O2aAgvMuLGqwPeG0v/5mNtYQbYOYL+OR0eVoZSUFGlL5TcBMIXI9aLvs75tosq7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8NloWdEdvHMsm8M3tIEe9/PBWmhRvQEXAWANL4NLxtQ=;
 b=tsdeidGRuD2NPcUfmyAgxeX68L0CQmWYWYXEwyXVmU6FAm78lVFnomVPRd32BsbLlmdb9s1+GQ57epJdKCDJ+YwiZgHBCRZUJ5aQPEclaI9psz3Oao6eIas6OBadvUgmYJkIAm0dlXKRkzO3ST6PSM5z7LmPaPh+VIioVF4j7L/58GPfoh8v3qOsVzvdkdVR/BHhbrfvI0uLmK8YQWzm22687OU81SLAsOzhk/sGb24Ei6eZ2Ml4bWKu9BGbj9Qj8r5tUnQUTKb8iW/RkOzFCs+AqyexLdQRFxYZ+GEwDmJSe/ibT1H9mHwqgR8FxJmAM8vvOHd80ZHeHyxb7Gjmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8NloWdEdvHMsm8M3tIEe9/PBWmhRvQEXAWANL4NLxtQ=;
 b=yor70nssM207EJFR2GTxkPTS8QTi18RmyXhW58wwWG7KxUbs/+Areopzj1q1gSywkQuFmFGCMpjASGA7I7fj5tD1ijSQRXhbno/H9wmDk2ANkf2UTpzJ/5thIq1cDD/JCP0F2fXN0AyNyVRFkWkK19ZrM9rWC+z5d+RyLjHa0oA=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM3PPFEC98198CD.namprd10.prod.outlook.com (2603:10b6:f:fc00::c55) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 7 Jul
 2025 18:20:52 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Mon, 7 Jul 2025
 18:20:52 +0000
Date: Mon, 7 Jul 2025 14:20:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, david@redhat.com,
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
Message-ID: <uwbh4yo7x3yjkljibd2uy57qubev2xfmavqxwgjjqontxdle2z@yg2clwpvqzq2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, vbabka@suse.cz, peterx@redhat.com, jannh@google.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org, shuah@kernel.org, 
	adobriyan@gmail.com, brauner@kernel.org, josef@toxicpanda.com, yebin10@huawei.com, 
	linux@weissschuh.net, willy@infradead.org, osalvador@suse.de, andrii@kernel.org, 
	ryan.roberts@arm.com, christophe.leroy@csgroup.eu, tjmercier@google.com, 
	kaleshsingh@google.com, aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250704060727.724817-1-surenb@google.com>
 <20250704060727.724817-8-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704060727.724817-8-surenb@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT4PR01CA0027.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::6) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM3PPFEC98198CD:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c49088d-7439-4855-0dcb-08ddbd83015e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KaQb1E8hCwYlqETr6gXzeAEyHymxK8Ho/WluvCoCnpHZ6ELEgP1NUlP8w+B4?=
 =?us-ascii?Q?2TQaNiXqatTAserJtQ6fNHc8dptAlx29LDqxHIccHymJ/f9dcTILsQ16qT9/?=
 =?us-ascii?Q?alPk1m9wozw/z1oKI5v1kn7/XHzyq93GEuhNgd+IXbRUKVXmdR/eqCXfyLAo?=
 =?us-ascii?Q?vknKFkNHAZD2OSYN02V80gWsmsZn0WisXLeC3rn4ORDo9iFEo7Suqt+1XEsO?=
 =?us-ascii?Q?Wjlyj3ux93H7VQGQaw9LWd4clHhFyUEaW6qZrWFqej0R53MDy8HCmUvSDKJU?=
 =?us-ascii?Q?+m/0rCKBU6bbNvRj2B0kPfGnr8jluWnfWd6LIfhl82zSBfOUFPofgBBTfVjw?=
 =?us-ascii?Q?F+OVCylQpFjGzS6Mp49tmuL37K8k7ewr0my9rssALWweCyvHQxXYHHMBVDwj?=
 =?us-ascii?Q?O+JDdfNCvr0ogN2wTBPhwq/ftIeYlChiEANUNiKT2hW1XEjp2DQvkZp2cLPg?=
 =?us-ascii?Q?czoYWMI9XoclvF4Xr/YtiwMRf8UgK5sHkucD/DuuH3vG3ktuho0BHen+ugVr?=
 =?us-ascii?Q?SQ5qiqgYVKuwNOV5O8O6WcGB1u42W0JmdXW+HbGlS181Zozld+B0GIKCfxob?=
 =?us-ascii?Q?JXEb19fJ8/1avvipcLnQcZB+LBCRd5tEMEjlQCKgUu8nQh90Rrfg2hFsYAwp?=
 =?us-ascii?Q?ScbYwaCTNybS39aUjnQ+L3fP5RsKJeZicjoLJ9lSXOPjhYz1PltzsUd/r3Xa?=
 =?us-ascii?Q?k5izfIhSu7B6WLeBNoZiP06742wRTvdxbXaadY0Q7K1aSLyyHEjdNG53Y+BV?=
 =?us-ascii?Q?l0WAI7ovPg/GL1a+8MzgowDZfADlfzwDe6xXIdE+41qbERtvb5RxEplMay6G?=
 =?us-ascii?Q?6JtjLbslocd8SMkDri9igKuXLtwi/SLXNFRximqLPPFUXJpRaWgErsUKBPq0?=
 =?us-ascii?Q?b4QAjGxNKcb64NLcKQnFzQEN/ZudhbhKPcEUyNzXFcjp0nHz4jcRqaPUlIoh?=
 =?us-ascii?Q?AqI4uNm8PcF5psz+nmqRV+Q7fRDUpi0ZnpsuC/Z2tdDyDDgnTW/omDWZiJRR?=
 =?us-ascii?Q?QXHhuZNmeFuBNmksHnSaxsChk327qFYGXxeYMFaYZGRL79SqxMqRoJSHJhoO?=
 =?us-ascii?Q?Dw2c2zJrd2Kz3hV7lG6fEqqgxkI8lab2pfF80GcmfbHuiEfn3VtA7fD8b898?=
 =?us-ascii?Q?vheFpJh2M28OdjXaqcG/cSYB/jYIFGd887b/Ox5PDrj/UO/Uf9iJc8d8t2wC?=
 =?us-ascii?Q?Te54uYPolgrokowmj/isHoWxEqHrLwVWX+iMpi0rYqkgBJvD+H3tbRyFsGP2?=
 =?us-ascii?Q?Vn/Y1capII8UhOXJJnN8iloFU/jSpqN9KAdRN0XG+9TzpzamBtjFM0Sk7Yyp?=
 =?us-ascii?Q?Zw/6iNE7Mgx84OY6YBEYCgyUrPA0Q3rRsXEq9MCgqMgplhtxtGXYqWW8+v2/?=
 =?us-ascii?Q?VR5Hsrf6NNw6Lqgw8nPtm7xRCHyPbt4CGn1x7qxIgBd7UQyyb9dFLrutVPIa?=
 =?us-ascii?Q?lwz4ZSuVRPc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OaTcG9f4TIdWIaovgAdk6VHQP0AGEaF5j4RyExj2ImwS/aimOekSKhPWeK36?=
 =?us-ascii?Q?e9+JAU952jJutcBn61M+IcipMF04v932SijJXj0b3v2ivb1e1xRgIj8SVFMg?=
 =?us-ascii?Q?0jzHWQJ4GIzkeF3PQtdIHicCI8GulRZjxH8Le5bvPQQdU4i0Er9kA1hGvG5V?=
 =?us-ascii?Q?hKqdAyTMJBIsll3zeW91sOL21vnFJVH2noJDbwfJ560YMLmsJdQUrV9ZHqL2?=
 =?us-ascii?Q?cYlbeCJG4Cc5dk1+spsEAefPDwHOxsQNCx0qk90bjeo2tdg/75S6iJbwLVTq?=
 =?us-ascii?Q?FtwdI7+FOtsEWWwwJR4kfKsNibFDRmE0buk3tgnRD+nWaM9SIrqMTXZeQ6vs?=
 =?us-ascii?Q?pw3MeejDNKXI28XbYY8P3X6HSKdFLohCl9yHqYHBRld1fsMihYyo/jFyWqXi?=
 =?us-ascii?Q?oVuLEm4AoUal+8/tEmPvArFtSMOfi5UshLA49G/+KtlkC9j6Nq5dG0CsLsb4?=
 =?us-ascii?Q?vVJd5fPIntYGkcYiKpvo8eMuH7xyqe4V8Lgkjo1T7d7W4wX298dY+WMvcVck?=
 =?us-ascii?Q?0k+AVvZ3I2KidMJPw2z4xiByAYc2vBrQxISN2qmnx/5cWv4IZOgNKVns/Ye/?=
 =?us-ascii?Q?fX+KZ9v4WHI6P55Nt+/vm6mqwLWk55jwXmreMPm94MAbpxKvjKcupxyygBIo?=
 =?us-ascii?Q?BXgmVv3GCDC7cDoNJe8qpo361+rgi99C24MtrV0wttnleeVmNDFGjusVVnQO?=
 =?us-ascii?Q?L3dH6iTOf/ngQjsQTLYIkxwYeh7WiMQaz2SwIFKmZp1sAwbpY8Y1IbceSktV?=
 =?us-ascii?Q?aPz47kQqDRuApxYl3LGuiyf24fkAehJNhyP6qf+8z7R3UdAqpgzpub9elrmc?=
 =?us-ascii?Q?oVSUprXeAYNEC30bDq85/9pNl8Er83XpeHg4HptmEaP0EUD9WeE6g086ZDW+?=
 =?us-ascii?Q?RxgEDRXWjUtcMJS7JpU3NOZGsyHCoJAhEiGOw4VuwXWgd3fbzH4ZtjNlN//4?=
 =?us-ascii?Q?LQ90TcnQ1XtvXftFFKpdaIZWsEXRrcB2f/O2JaGGTx3HHUZ55l9HKPociGXS?=
 =?us-ascii?Q?zUmP7QEEYVsj+25gYUpnWPeLzgt4McVztPe1EccguMxrGQ8b3cBh5MauKvqu?=
 =?us-ascii?Q?PArMZiFNZEzpIf/XTVFw2Ybxg1RrbBhx/g08RMtyKYbPgm27kVaM+ZbifPHz?=
 =?us-ascii?Q?11YDPAKZhHuElcChhvR8SgnKY3WNIXcEZ49Gk5tx+OpANz20G7IoZHB3TydT?=
 =?us-ascii?Q?xADcKyxLe1pDGpe6O88vkLXEzJK5NFG7t5WPbaEEgiYHk5MiWd4378KF3dWR?=
 =?us-ascii?Q?k9g4NKJvaAmArg2YqvD/LgXr4914b9O5ypvp1oDtlCRtfQPI/bHewUU3r5Dp?=
 =?us-ascii?Q?cXEbWisIW28fA0TiK4nyLgMLwtpHrYD+cV90xH1STpX4Kb/m15DcE/Hkxmql?=
 =?us-ascii?Q?REIgtZsfrML5XjmlPJqeo9lwNipk4Xi8ZDu3ttpWfmuE3GI3iWf7jdSbOMVm?=
 =?us-ascii?Q?8aVegO/gpMQM2aIkvNV8Q4Jb5cJx3dkf8EH1nyoYHgUkCbTlEEUZbs7S0q2J?=
 =?us-ascii?Q?UDUgJ6iKDktMmwr0ZkkdtE8BdasiTpmXWjTy6BSYULmAKs4KIHF1+84lKxnW?=
 =?us-ascii?Q?3FltRo7q1+CSu00n2xabGz+KknkdG0nDTiXQh0Qe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NJYps2KxXqIhyQeV+beYIdRILa/quJxCru/5FE0EEaBE2UppqLl9gmUtRLShK3ZurWgD4Apmxo5O/apmwvuKC6MXq4opKjU4uxDOS5EGWEr2Fmn8vliPX0jwQs3A5knfk1zKzphG/+skiDAuSCJTA84KXpavjpyHAT7B5ObLQCwtIibvkbji0rzB9tt2naxE8gPi4i1aULdBU9sL4/5tonqgwByVeM7AjoYonZXyhdSsQcq1DsQXfscWrHs8TfrZpbdoLdPcZ5Gk2iaEX3SPZvtaocSyQChLNL8GjhukNHu47hBZ3NELs7rxeSv3oxmN+ed8xWXT/PAA/XU7cqMBfOsb+8V4zHc8kX1QUsCw7RoGGcYlX8nNh9N4WmEIPp8VLLcLns2LhZkjksVC6LSXmvUMEhzBN//UHt+Ixwd25fnqPREv+r3JwJvUwrZVKo8evpb8Kmo3geJsUsHdQokyK7I77vGKItEjoSKZvMd9tniiBWIuiWdS06kNXZd846pHnUz2EfrdJhkm7dMqgiBLoGe46GAw7AT6YJ/xVzcx/DiGWoSDVWv+GBJR5IVlC3JE3mxosK/2mwcpl7NF9fuiiXPjhOzzEs2nlq7wToCQ87w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c49088d-7439-4855-0dcb-08ddbd83015e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 18:20:51.9841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLZNCX5GENvLhJWXotgqgpN/HG0XoP+xQLgkHgg3b02UkOQgI1ht+HNk7hbBlLi9odghrSN6MWvZEsXfomsmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFEC98198CD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_04,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507070119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDEyMCBTYWx0ZWRfX5gDdwUw5cUsH rgS6zTL7pO9N2YKfb+dWfzmEOVNuU0AYeifywC3UZ+SL/Pd/zBZXoqOfP3Oz+7hiqSC1BNxLoS2 G0p0p0umXlTkDY7JWezXqqusLt/q4tyUeZvO6iqUTwkl4T8l3QQ2cldK4ZhF61S9DXwQkJmhely
 z9DFPRKm9ORK4nF3Rz7wqRMBFEwRHuWXw0nr398S0v8Jeq6GO6JCz3S8iAOTGEAnW7yZz/z+Kuj 7iXQdZPhX6k5iipSRNEXJh+cTcNwYjOq38S8HXpCBQFX2Gs43diCfNEJP/ilNn5zd8CW4+9D0tf yT9HPBar2+d7UwdnizCfdNm33Y2WMrgVfz/G0bB39jy9qmVPGFIhAdVLgSxaFYnI+/32FunuOsf
 EBaoPTJ+YCrbodUF3IJjHQk1rAjZkTAV8Z0jmDc7EA2L0e63SJgZ4IzCcWsksePS4kkv58Hv
X-Proofpoint-GUID: bzEqVNHGYyDzX9Y6nkdqJlLoSceOPp6q
X-Proofpoint-ORIG-GUID: bzEqVNHGYyDzX9Y6nkdqJlLoSceOPp6q
X-Authority-Analysis: v=2.4 cv=IdqHWXqa c=1 sm=1 tr=0 ts=686c1012 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=BJkD3Kgfl6ix8kXtqGwA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058

* Suren Baghdasaryan <surenb@google.com> [250704 02:07]:
> With maple_tree supporting vma tree traversal under RCU and per-vma
> locks, /proc/pid/maps can be read while holding individual vma locks
> instead of locking the entire address space.
> Completely lockless approach (walking vma tree under RCU) would be quite
> complex with the main issue being get_vma_name() using callbacks which
> might not work correctly with a stable vma copy, requiring original
> (unstable) vma - see special_mapping_name() for an example.
> When per-vma lock acquisition fails, we take the mmap_lock for reading,
> lock the vma, release the mmap_lock and continue. This fallback to mmap
> read lock guarantees the reader to make forward progress even during
> lock contention. This will interfere with the writer but for a very
> short time while we are acquiring the per-vma lock and only when there
> was contention on the vma reader is interested in. We shouldn't see a
> repeated fallback to mmap read locks in practice, as this require a
> very unlikely series of lock contentions (for instance due to repeated
> vma split operations). However even if this did somehow happen, we would
> still progress.
> One case requiring special handling is when vma changes between the
> time it was found and the time it got locked. A problematic case would
> be if vma got shrunk so that it's start moved higher in the address
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

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

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
> +{
> +	/*
> +	 * smaps and numa_maps perform page table walk, therefore require
> +	 * mmap_lock but maps can be read with locking just the vma.
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
> +						       unsigned long address)
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
> +	if (IS_ERR_OR_NULL(vma)) {
> +		/*
> +		 * Retry immediately if the vma gets detached from under us.
> +		 * Infinite loop should not happen because the vma we find will
> +		 * have to be constantly knocked out from under us.
> +		 */
> +		if (PTR_ERR(vma) == -EAGAIN) {
> +			vma_iter_init(iter, mm, address);
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
> +	rcu_read_unlock();
> +	vma = lock_vma_under_mmap_lock(mm, iter, address);
> +	rcu_read_lock();
> +
> +	return vma;
> +}
>  #endif /* CONFIG_PER_VMA_LOCK */
>  
>  #ifdef CONFIG_LOCK_MM_AND_FIND_VMA
> -- 
> 2.50.0.727.gbf7dc18ff4-goog
> 

