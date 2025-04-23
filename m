Return-Path: <linux-fsdevel+bounces-47050-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71525A9808C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C73FF16FE73
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC8263F38;
	Wed, 23 Apr 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eckM+xha";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N6+GDgPE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4F21DE4E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 07:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745392887; cv=fail; b=POaqoONHTwXK7VAVLt1GxItbMaG/BZt51eMlhXbIx3LmMVZEXhJ0pc3wVJSqRdh0yOd+RT9jbUFgiKd0eyReJzcFzDdrxtT+3u+FAT/7EpRFmawGTGAEI2oZP0bwq0KXCqfYadOb7zA9QZyGY1Lb/CJLZCydyormJ99YtKnbrLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745392887; c=relaxed/simple;
	bh=Qgxa/UyMOgZy3esq8Frd+BDDJjVQ4ks0KrvQA99M/gY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HpW/Q7AGP/36PKmicR+4i5yLmUm39TkNcbb6Lafhp5pGlbYRNpBSnBajZOMrMRxCXTIblYVrkqkwFiHiWrWSPK6iSF+UJFmB/YwTEIQsGZKHgQePCV6uX7RL/XFG6ZA1eo4jHEsCeAP0pLAjZ9WydS4jdx674+aKapTHIQ21VzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eckM+xha; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N6+GDgPE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0uWKi026360;
	Wed, 23 Apr 2025 07:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=25E8RH+KXrX8Q7+BXe
	sq0ZQGDcqnd7+6gJwOTHLEPlo=; b=eckM+xhaWpjkluk5Tm9e/PWCSzkWuaS/5G
	gvQsBM3K7jGXxXiysT5i+lq9Mh8A1q0T4vuDpt4NFv1LV83a9nzLgUDMc/Jl7DFV
	dGtfGMnN7b5JRiX2gZPUDtsc8FYDHW6Vc2iKAJQR+xaVyM+/1azLYvTz0yFzLtlh
	81DiXvtDZQKfPVlKV4h1nxeLJoc0Ni6T8MsXOcyzQC0yQ5vf5SiqKtN/KA6bmsRH
	7gggcF+XaAsWi5nXfX8ZPfyJQywmQH89OxiYqPw/h6wgc6dZNPtkTSX1/Dkxk7th
	IqmmZYb47IOeLRE4Ony9OQaaugTNBP/ntzA24ncaFZH02w7HMkgg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jkjgm2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:20:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N75qBs025324;
	Wed, 23 Apr 2025 07:20:32 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010004.outbound.protection.outlook.com [40.93.6.4])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 466jbq8gbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5dCTDu6Ey+PdbuuRPJeTAmTvl8IQur1hNipQaDKAz6mF9CK6MBGEFO36O/8nnm2bfSo3sHoOlJg5/Urm63zW8SKJk6x8dThxY3Y0jnS+yDsmSAHurvvC0vUfZ5wtH5SouRE7lcHYrHDiDyYkh9BupuN8/ESt64/+KEggo1JDysxIdzgjrO7FHqj1Nb545A1aeEuIQwN48hjMOpMVZnzyKWyNBHOJO1Hf3PMHj9Z3ijF1RqvqUrPvQHNbDW8EDSkGw6a1+qX+eoWpwD9z+eZsTsbfEle4zV8jFKdlInjqQajRNTyBNL4raFcuOE+afNlnZMCFhaxXDWRRcAzoXfEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25E8RH+KXrX8Q7+BXesq0ZQGDcqnd7+6gJwOTHLEPlo=;
 b=yWSKRiIniWLbOZA03ecznLer4M1AdEwSE1M13XjxuAw4aeJlS96vOYMH6PB7c9Wlhia4zEktumdLH6hXqJs46D/dPr8TcH2swQvNjdpSCq9Wo2VE83a1sbljD8iUvyeGnpmhvMdSE0sAHLCox1OMqdWonf+oE7+E2hZ4FoKZRecsHFl5TiXqUbS2jZIgYR7S1jJT4jnX1hJpQ/YAWSALi7Y+flltRfITZcGl3pbtX/0UXemxwDV4o8J42w+3SwQkPYg+18QhDgNR/Ep/Eh/6wvjAwR4Rvp5BdEqxYJnTNMNZxQ/GLUxpPovCS8ZdrQsbf/DoCGlePJanR05a5IAfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25E8RH+KXrX8Q7+BXesq0ZQGDcqnd7+6gJwOTHLEPlo=;
 b=N6+GDgPE5yml1I7C4o4H8ADpZC4AbillSlgTumaB1oSzARfC6GRPsi2fSJuvmOkxqqeUlyo4kOg0AvvJEl7FeFCyEmLWNC41jYokSn3Zrw5zCnQC87EG3lxk04EpPLPODGV4OlNkjOVM5MlpmVlMCuslPXai96itctf07ly8HjI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA1PR10MB6733.namprd10.prod.outlook.com (2603:10b6:208:42f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:20:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 07:20:29 +0000
Date: Wed, 23 Apr 2025 16:20:20 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dave Chinner <david@fromorbit.com>, Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <aAiUtCKJOdWjYxDZ@harry>
References: <aAZMe21Ic2sDIAtY@harry>
 <aAa-gCSHDFcNS3HS@dread.disaster.area>
 <20250423014732.GC2023217@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423014732.GC2023217@ZenIV>
X-ClientProxiedBy: SL2P216CA0157.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::20) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA1PR10MB6733:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e32ecc-884a-43d0-6293-08dd82375336
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/QliWmr/PTP43kYXo3THsdebIGD/j53b/jo1hhlc/IyDwtImfxz4ImusKDA?=
 =?us-ascii?Q?LzxNjfUcub3KlTTfSCuNLmeJJs5VKC8QEWs2l8H3KvSiRdHMW0cFpNmwQd1M?=
 =?us-ascii?Q?yVM4itBu6Ussl3YIFM/W89/Y0xCCxsGIQxQI3SGkrKMhNlP+7TQJ6I0rjT20?=
 =?us-ascii?Q?Gs9CZkA8P4Jrj30fya91rq/lXLpWhkWToW7jSMvhDccNy67tyPJSLam1zmSE?=
 =?us-ascii?Q?+vWkPa91iQbAxLGiwdF4suI2hYbC1BtLB8lG9iGVW6sGEV908EkMhrbPhPNX?=
 =?us-ascii?Q?DQx17ugSH5Cqn4Pilc3S0sliWh/xNXWX5oODLIx4+C1DfjbiA/NboisZFgX2?=
 =?us-ascii?Q?99ZudcmL7bnGB0DkaMJg8c7/p44G06wqmvYL7qazOZfDH7wkK7LvkbL3j0ox?=
 =?us-ascii?Q?C8p9LkQzwdpCnrBb9hH9PTsafC3+ia2r265DJqVD2Z/OVuQieH+pl/aUT/24?=
 =?us-ascii?Q?2LvHIteAbXCJjd3hNh2R4HgAiYG4UJPbkjwMW5mCbkZm9f6YWwwPU1T3Ke89?=
 =?us-ascii?Q?rbaB1HV6rJ0vRqZWKQDNLSvW9/ESwRpnhiV7GTdqYCNMKtN78V9xYTSr3bxr?=
 =?us-ascii?Q?ziwnL0BzmWMi4vPJ2197umzAZ0/LSdWXRab41KvxFVxP1qNrBZCu9BrCb29j?=
 =?us-ascii?Q?rpuyjpC3w17xcFcPMOQCU/+yCJZh1/6sSx3xxBJw5SaJaeKCexddkntb40Qe?=
 =?us-ascii?Q?cWTINGz2Rj7BWmoCMtZ6/sWTtm1wr0O0GdDrXtCYPLT2uofIgyUXPR/T2ZYx?=
 =?us-ascii?Q?BzbWiTry59i9YglBrTC6wakg73fGWF4rUwgAheWTBdlZ/cXY9nuNdIYXy6Tj?=
 =?us-ascii?Q?cdEGeVoWFkfuFFYM5t3Fwfoopw026+ocijV23PTIR2j3Etesw0howfL4xNvt?=
 =?us-ascii?Q?PkiIg3CoJaCFTZ9fEpSNrQxnDPCeDpZ+F9/wbc32+qx/r5kbbVg4FqFo+Bpl?=
 =?us-ascii?Q?02Ycf9Wjlw8JS3xkpjPlbIf3p+Ff5hHxBSLQ2RMWrlHY96CYvXdhChr42SDm?=
 =?us-ascii?Q?0+Qvqe/4vcGOoYeEfLjnc0z54N36UquBa3m1ZQZPaWfcJ/ZNkVhfaYA308BE?=
 =?us-ascii?Q?+gyJrtNapDNKjXelkPQLYO5qcund/Pbnkv6dSio0eGfW0p9/yXpq50wj0T5E?=
 =?us-ascii?Q?V8sdRXkn+xrsUx5UfGoM+C7nfUS2FL9d8+iAr2fEKuta7FbcGcwdF5U7Bhj/?=
 =?us-ascii?Q?nku7M6/Tk8vZ2xLYyS2KjKgH6gfhA2yb+PFoKTDmSjXqts+msK/g2CRcuzX3?=
 =?us-ascii?Q?AkdDTVx8oyEoKRDJoKgtl5v+EeRXZa8cgDgUje9HKqQYHQKpm0nMfgxeqdq/?=
 =?us-ascii?Q?/K5DStJuIEN99IqZtHcJKAGj3A7Lsm1FE2jafgnROSboPDeJE0YHP1ZKoDta?=
 =?us-ascii?Q?ozaB1bx1rq7xX+jRC9rEHevm8rCJUCdvOnJ2iXPaMeWTkMvHtjeo/MdkD3JX?=
 =?us-ascii?Q?QY6l8HInOTM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M0BSqGdSbK9C5zaIaTJa0y64drItaGwppGMdHb3RZWWfnzWfascoglPbMfSR?=
 =?us-ascii?Q?2ets4uK3SPB/2hxUrXSZPBMofiD2svdVsFx9G2HRKC8PauLtCsFVQqMYMdQ9?=
 =?us-ascii?Q?xkrj7+4vImyrzAStaWQkaUik2TawJL9/MFSxdUeBZWZKqYyLRuGzgT7WZOK1?=
 =?us-ascii?Q?H94w7r6Hp9CCdUhFe5x0XHLzQkXrkMnWXFiK77fJ62mgVCqqdFaYaJAPeZXh?=
 =?us-ascii?Q?yfSkgo5cAaNpsefeLv81EcPxHMBh6mtSlq3Y7HHwU5gWgAXVjDN1UdQ7PN+9?=
 =?us-ascii?Q?mOJgSTEzPfKTnqS4lD5BPCvXT70He2Md453eDFuLZoG9SHCqzxHW+WRQ36ZV?=
 =?us-ascii?Q?OO0bnFEuAZG3c1dcetP0fx0TSR2dILAT1XrLX9O2NMw4HxR+XROhkdpgQT/b?=
 =?us-ascii?Q?VMSSRf/lZO/Ccy/O+JFsvN8WHjY0JYOAHXK1LmHU5QSoKgnlALPhnprkzo8M?=
 =?us-ascii?Q?3XctX9JILawM+fvrA/GOI/skesWHYbq8UbaEJByOsfG8t9WaaXFzPmJMiNZy?=
 =?us-ascii?Q?yZy98asdTudVd6xJLqH0xg5tcHMQ1jCLKsZFfkzxzDEttOSqzsCHfdMwt/BX?=
 =?us-ascii?Q?6w5djybdUa2p0rzovRlxJ56gPiV5L/WHWygyzwfambDjkmR0nR2bmdkZTQLb?=
 =?us-ascii?Q?64J8UiXs5ZgaqO34xid9T35aArdJB3z/v1T3cBtEW1LJ4j9HlGhvUh1BrWeT?=
 =?us-ascii?Q?YgPdwGjt4XtvsAjtUc4IQRnSXDNK3Fs7M+YUjXjcSU/PWk3fYD4t6GZq0Q1w?=
 =?us-ascii?Q?8ndhC1g0iCduuaBjope7LsgiWvmGQ9QZ1hBeBRUZP3/8xPLdkU4xUuIIj+QO?=
 =?us-ascii?Q?l1D4kvA3dYhD1WtT/Rupm+K7IsyR2AO1jiUS5CgNWny1SygH0XBCvneKtOdV?=
 =?us-ascii?Q?GpbWVWNQQLQnea1Qb46Qkorx1/Idv6voqjHtOkhLKd7O5wmYaOfHvvzYH0qN?=
 =?us-ascii?Q?Rs+2n9sBbD78ke/WiSfWkJLhYUcN0gO+WH+yEv5aQXDehR92EXLN8QaUQDXh?=
 =?us-ascii?Q?fEZTY3kba+v1qZNoFtuP78EhPCxhechDN1oLE1+/1hJnAaamnlTj9rRET5rz?=
 =?us-ascii?Q?YIO+mK74jCWJt9BZdok04/AYPy0kupE0SpJHyyKksTXxwkdOLvA+gUcaoHh9?=
 =?us-ascii?Q?vNn5TxxH4EXaKFfRiDBsnPQBAQNTg1csxjTC8hwcr3kwUNL3DrlOiew6S2VM?=
 =?us-ascii?Q?2jJ6rN5OxHwPxEzkR0CY9UsKrgAp1t90VpoXbxdiyk8R2ImieEjLHac+uzcB?=
 =?us-ascii?Q?7pnNzB4ZEcuE2F0hIv9slum+es0qGVcT4Ae1BJ36uFgP0QB0diUFyTWU86Ws?=
 =?us-ascii?Q?OJkOMPQLh0Z96D0zdnHi8TfvU5o3izmR/57QWlvS2gxELKtGAOhYBtrPtFYD?=
 =?us-ascii?Q?gdncLDRdkwyofWMmu829l3pid2O5rcqBi+g8utBjQSdCy3TiTe7nmwSN3z/L?=
 =?us-ascii?Q?C3NoybwkrAj0f5A1JoaMbvzD5dj+xDZ0eYui9JAxLz4y3lby9/hNzh0P3/xU?=
 =?us-ascii?Q?BMEBjJe5pC4btPL3QVVWX0brqIl2BM8GcvTAmjRs/LAt3o8RwNnFLuC1Rma5?=
 =?us-ascii?Q?05z0E256qAKQLjiDYMnWO27ZoMrizXbkxHPIPmXP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0hdNbbRDFPFBlTZICaw8/tYgIIQ27kZfekW+o/KYcpCPtQQSYJ7gX7p+GrqFaABObnjNoWEVsj+A0WKtR3tE37mClZR+NlHT2bltLrXO36zzAV1jfHUmAFlG198SD5LUxhDPOaxyXCKb7Q7GWRXuL5w3t/0gMPJ+n4982gqDRF+dCwP8Vu62rEGl79dCtoCNkv4BGdTY2OP23ekiz3nAsF2KQdA/GsVatClmZ0gvnV5nPpfEI+DrHCYFDKt24yc5hCZA96ZjaxAmdULWw0pUJAU2aknqH33HCTmaqz+xR5C7hsZT92AgnIDALHmrIkRDjZrxG7/Fiwm/tKHxbivyOPpsfGawR8PDObtqczOrkQHgEnHT3kgCyk/QA3IVT89v3oefxDEOazwffsHK75gKKPajJ0D08ZQixqTgbL9DOJczFOfIBUmm7duxd7Da7mZAI86evRiGsjx8hL/UxWU4Vcut4dSrUmDgOyR86F05nlPH4znSI03Uq6sj6XKwLWfIWbaZxdZ4FMTLzy1TtnMPXfJUF/sYSAsX+2vXW+ksCZnbUDP70YuI2SZyYIwIDzyQCWmrFhfX+8gYxSHm6h3/IRiZrH1hm1i9rnQ7DI4qwsQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e32ecc-884a-43d0-6293-08dd82375336
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:20:28.9257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5blrsRcePh/dDiPypHIVup1ok3bQaN/G4Mvyx7Uul4nGtKZI9R6RmPjUB6lNl+P1aV7v5Ce9x/t2jiO2UDsrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6733
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=989
 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504230048
X-Proofpoint-GUID: WllLmh4Cabg--BPJ1Hk25PMBQ4CJOyWJ
X-Proofpoint-ORIG-GUID: WllLmh4Cabg--BPJ1Hk25PMBQ4CJOyWJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0OCBTYWx0ZWRfXweiu9t0QXubf KhBQbE8ZNpoD+V4nts7Wg27W3s/n2srrI1Ib72pubzIrX1lqmzzuJ/iqkWrPwp1HBLgRHvTw+/O L1sK99tIpkWnhhHls4VKqn0sPSrG/OLtKceG5WOF9kfdFagHfm0YHOZe6NvJjAOmdmtLSG8iDio
 YtL1SK38E9MF7Rc5ZZWFY/t6KNQ87cDLCj6Usc8Mscc9eSg5R0YASRPMH2pfrTp4VMXIp7vz7ZW eN0a76sXfBlT8UgrqT4/XEQ505gdk0qkSPHQ8xELvcCeQTSPzx9JIX4eof+fQTwjMjt+0iE5rE5 MQ0oKeXrynJrX/gTLjvDIH3hzVNgyIpH+ejVlrY67iZ1W6EqYWRSGHh8gHylbVa0sXc4jnuB148 TgA7NsQA

On Wed, Apr 23, 2025 at 02:47:32AM +0100, Al Viro wrote:
> On Tue, Apr 22, 2025 at 07:54:08AM +1000, Dave Chinner wrote:
> 
> > I don't have a solution for the dentry cache reference issues - the
> > dentry cache maintains the working set of files, so anything that
> > randomly shoots down unused dentries for compaction is likely to
> > have negative performance implications for dentry cache intensive
> > workloads.
> 
> Just to restate the obvious: _relocation_ of dentries is hopeless for
> many, many reasons - starting with "hash of dentry depends upon
> the address of its parent dentry".

If we can't migrate or reclaim dentries with a nonzero refcount,
can we at least prevent slab pages from containing a mix of dentries
with zero and nonzero refcounts?

An idea: "Migrate a dentry (and inode?) _before_ it becomes unrelocatable"
This is somewhat similar to "Migrate a page out of the movable area before
pinning it" in MM.

For example, suppose we have two slab caches for dentry:
dentry_cache_unref and dentry_cache_ref.

When a dentry with a zero refcount is about to have its refcount
incremented, the VFS allocates a new object from dentry_cache_ref, copies
the dentry into it, frees the original dentry back to
dentry_cache_unref, and returns the newly allocated object.

Similarly when a dentry with a nonzero refcount drops to zero,
it is migrated to dentry_cache_unref. This should be handled on the VFS
side rather than by the slab allocator.

This approach could, at least, help reduce fragmentation.

> Freeing anything with zero refcount...
> sure, no problem - assuming that you are holding rcu_read_lock(),
> 	if (READ_ONCE(dentry->d_count) == 0) {
> 		spin_lock(&dentry->d_lock);
> 		if (dentry->d_count == 0)
> 			to_shrink_list(dentry, list);
> 		spin_unlock(&dentry->d_lock);
> 	}
> followed by rcu_read_unlock() and shrink_dentry_list(&list) once you
> are done collecting the candidates.  If you want to wait for them to
> actually freed, synchronize_rcu() after rcu_read_unlock() (freeing is
> RCU-delayed).
> 
> Performance implications are separate story - it really depends upon
> a lot of details.  But simple "I want all unused dentries in this
> page kicked out" is doable.  And in-use dentries are no-go, no matter
> what.

Thank you for the detailed guidance and confirming that it's doable!
It will be very helpful when implementing this.

-- 
Cheers,
Harry / Hyeonggon

