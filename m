Return-Path: <linux-fsdevel+bounces-57709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09E4B24B40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 15:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0414C1695E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC822EAB93;
	Wed, 13 Aug 2025 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2xPY+rR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BOsZ8wmH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E8A212560;
	Wed, 13 Aug 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093081; cv=fail; b=SciQzpK3EWtaXLXRLe7r5ZiOY+nIDC8j6yRSsG4eDXrAUlIN71Nyhtg2LhOSRknuc7sPJPo6vUoQinv5WEvPZJSxN3gEHRvG7wr0UPFnsAz2PeLccWbcmKIxPAVR/EV70YXHtyFRj5Zxv/Y2G5/54rs3DI42HKa6I6KlYFVTCV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093081; c=relaxed/simple;
	bh=lKzeyopd9rcLOqCqvwAZzUPvdSc6MGvGS7u3PrHwf2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZA20yZN98DtdInnfJJQei6XXEaAchtSBJdrNQm+OXTAPkqoRdrQg46plzlnNbRrDphps9sSP04nlIC9JonOsOSAJmMRR5QVd+H4w+0bOMYLTH/pfylatLZKaX1DfeqeZHPxb2rTBqHLjlOtxKa1FJlD/UD+rhmAso58P81dNias=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j2xPY+rR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BOsZ8wmH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNaRW014624;
	Wed, 13 Aug 2025 13:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=hqoiqN4Hme8f2W/t6b
	vusYbwLKPLWys8WVYBgY1rpwA=; b=j2xPY+rR82qVp1ieiOzqgxJmmS4eoNctIZ
	KAyBojIzW5OeCXTUZ0MhYvDMfzzzBvKBCHgkbN/w5z2eXGHXgz6w7FkNaIOwkAmm
	Z7fzg+WCO84P6RYE34zCHAdpxW+y5MhZQuuw7AeR+lsXU4O/7b5X9iTH8Gr3gYyT
	NBodc6DtTJQ38M+PA5wiiyf18MiojfIiCYAF/Vgl2qdzZkAjD2XE24hAzqQWjUiI
	q4p9gbRKt4iKx+qGPyG68Mchy54xb5nJhxfcqYadlaYO7+U13Er81o+ednuaGsSP
	E2Gj8WqyUZl7N7UAnZDFsZ7hr8zsiNYO+pLQP8qYIvYrw0Ij0upg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4fmg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:50:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDmkfc006368;
	Wed, 13 Aug 2025 13:50:42 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsb849e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 13:50:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYd121OAwhddmQ2LIk19vDMIiEyU5+bjmqf695ppXL9U2MDxR/cbznTOJOMh/L8p1hskb1o9h2zupWRNDyI2qIWUUQaDNjJPZ+HX6ifNx0rorj3zX+AYAxQX9LQAaMYDs/YueXF8dkySB4nJwdSTgnfwPYRiOAQm/00ORtzeQvgu61xRUmbGVqAArWUwkakaypjtGzvTUh5HCA/GLRCBWW/un6B8jRghF7hxIy5D2ESMFF2pZb2NQPN/KJI4pAz1S6luq/qgBrz4idwdI4yVBgvfJZH6GcZSlRzdL5zRDn+3ZHWooPFLVu1XUfk+foFzmqpaxMWe1mU+Wda86GvFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqoiqN4Hme8f2W/t6bvusYbwLKPLWys8WVYBgY1rpwA=;
 b=fZd6PtsIgVKtVGaO2rofkURarYkW3s4I9/04JLJVt2OEohyFQmw6gxTpxgJioMyIDk15R7eUbe+Mqk1EfLHVgaw/q+N/wBWpAkseLi0LGdIBbpVgJRAl8AOqDsPIcHx2uU/aj8ZR3V97zIWGKbrp23coGZ+lr4/CNdFWQfBKCzyMg3hrAffZMOdDfoQweDcINsisQ3j9Fo59BGVjcz0PYeQPKzZQ79YRTEjHOW3WoC9qiUhc5TrSuMyxt8QngNauOYU6rVSuSEpijSW+URLmy4U33u5l+h7JVg359yxoDI29OvZjb4bxTQrjSOiE0Kw2snoKQAuk5K8aAa+TEcACng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqoiqN4Hme8f2W/t6bvusYbwLKPLWys8WVYBgY1rpwA=;
 b=BOsZ8wmHRfZh4Iakt9aFSYQ8UyBLhxL+B+J+fxMJfkAG3v0IQN0J7YdYbLWCYZ2m/Xd82oPJ/rdktMEOjst3dPZkui2n/bS9DH5GCfUs0rh7JAkJ7396Cy2oDpWm3rMAN7E6rcBVLfNUrECnmBzcWxgr/2Ii/MYXPSRhA8PLpPA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6226.namprd10.prod.outlook.com (2603:10b6:510:1f1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 13:50:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 13:50:39 +0000
Date: Wed, 13 Aug 2025 14:50:31 +0100
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
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH v4 3/3] fs/proc/task_mmu: execute PROCMAP_QUERY ioctl
 under per-vma locks
Message-ID: <949e71aa-0393-4e6e-b102-33a9eff1e5a4@lucifer.local>
References: <20250808152850.2580887-1-surenb@google.com>
 <20250808152850.2580887-4-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808152850.2580887-4-surenb@google.com>
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6226:EE_
X-MS-Office365-Filtering-Correlation-Id: 992bbf38-0a99-4fb8-04a8-08ddda70630b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WvFHIDXUB3fwnP0YqT9zX0tUoyaq3OXz10mYvtBMLwbG2Ito7l0uvIqZiMBC?=
 =?us-ascii?Q?79m9ZyevVHstW6WZO1IhYHquXkMJtGz8/ltWFmSA38I7E2qSjNfs9pBLRRS1?=
 =?us-ascii?Q?UwZUf4gS/u2NxJ4gh14JFL9x8T7vFSg/sztK4parxZRg9XzGG+OxbmThhpgp?=
 =?us-ascii?Q?bDOOEPkNyWq4zfiuYeK6znfBt0ZcDxv5KHUbEAVJ9iiIBIGuO3uV+lOD0F8y?=
 =?us-ascii?Q?sR4vXJIOde5Cd0FykimFltT/SKO6uoIRCa0DNAfCPMYpRT8QJtTuQsNxOkes?=
 =?us-ascii?Q?t21aAlGs6bPKf3Jjpd9nRkpz4LdzS6l3KOEpoN6so/aFaOawxVqRtK/RUFiN?=
 =?us-ascii?Q?NrtgEg3HRpSsBUkwjmB3UibWt5MKVS3Q1Q2D/9dvJFJU7eSsfTeigf8PrSDl?=
 =?us-ascii?Q?hv9bk1DY1u4KcgOvYsqTnP68SqNz1hf4L7I0qD6xDDOhncKWZUhLWpw35U/R?=
 =?us-ascii?Q?AbgKrcGjmays28AYqrvwDqPsmQUm3ECmma7t+UdJ34iTeA2QSipZY6lS4/Zz?=
 =?us-ascii?Q?dD5/0egQJEoCnKmH87Wq8bXhdo6o4/l1qMab6S9QmCTXNBK4hIOFdcWghA/G?=
 =?us-ascii?Q?gAGtafmdMm+93ZCmh+wp4ixAQHlTbOn/ywtsGiSH+bU+AUELezfMQtlAOb2R?=
 =?us-ascii?Q?cUBYg+e88bqNqVpoZy6CTu2+tkiAjPx7X2JEeMPujUM4Al6u2PvvpvNy/2I/?=
 =?us-ascii?Q?3MKZNloGUI77jStpQjtmwNCFsdglE/BDfz5YBNuu/CCNdoTwi9+yc5hZh76S?=
 =?us-ascii?Q?FJfGqv0jgFP8svfgxPA3znGmTTpO6VvPhh+tZ85tIXTtGPiIHjr5No/3fF9t?=
 =?us-ascii?Q?UYgQ99KLjFQQA9ng8PrBBljgiiz70LrteZd+W+4d3d48wy71tSyQ6Uubu+3R?=
 =?us-ascii?Q?shbI9Wiy3fvM1eZPVxvpzkWbNtFr1bydvLTxFu02qf4DfVMR9nwxi3DZvGOd?=
 =?us-ascii?Q?fWGuRlKO/0b2Q6s6jahxnrr/cQCOHtf23k1p/cNxETEQReskbFeGBV6BgeM0?=
 =?us-ascii?Q?qCdLEI5JeuvNNxuPv1b6aF7+qOO4SDUI8ibBPn1rZzpeftWdQw5S+gAl6wS0?=
 =?us-ascii?Q?DnZ0oUjzYsAShC1AbH7GUda43Vpjd8CFc/nkCB0DEJI//GqDNrthOfmWUx1Z?=
 =?us-ascii?Q?v6MEP2R6XEEgchPCT4WSB5DqzCxi67IkbanI+DunMzCK/7iQLddeqIGTp4vS?=
 =?us-ascii?Q?ZSMoT1NZv3F8Jtvkw2WkbeHAeB48R+x7h/RR09oRvhv2Tq7I8txjLCZXQ5Za?=
 =?us-ascii?Q?bHmwh+F6xKFw9jA8HtI6Za9eL+KUrxLwsCV9EZJgXVJguQhkAwQCH1Duyq4a?=
 =?us-ascii?Q?qfmdsUel9MvrJ3Yh9sgNXR1thDBxfQGUAUImISEIbEsk0Ql8UwrMH39c4TVJ?=
 =?us-ascii?Q?+MD2qNw3F9GvxFUdSaqzeS+hktIO9VGO3ZrHike9OIorkFFACsO7dbEOV+3P?=
 =?us-ascii?Q?RwHUTnqMOP0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pOKQy77u98JRuyLvR0j1b/u80xndKP9x02fY30Avn2ZhBy0n3RDaKOmQFv5p?=
 =?us-ascii?Q?7qHeSRUvPd7BWDSyq8VTLeT+sg7c/tWU7NUDDdCaZg0NYqFJn+aKpsqleAtO?=
 =?us-ascii?Q?pbznCWpopp3oFQhYtUJ0rXGyuwWPf2uzPiy80eZ633YM5j19DWE99x0/xcCs?=
 =?us-ascii?Q?X8BHlEAcIu2vHaC+dmYueQNBw4v5WcLATpXDEpEUkpYdbfybfy7oesG/QdY3?=
 =?us-ascii?Q?VDu6HxUBiTvt+TDQdZL4a9LM3KCQdrgTeQs5+Po8ZRjOxVu4cazSXuOf/zZb?=
 =?us-ascii?Q?xdCf/9DSRgYdPyCUd8cFMTZEa/gYsJA0pmKa2pceOpI099ZdeQoPeCTMhW2X?=
 =?us-ascii?Q?0mb/F4nfDwW2NmNNCrC0K2YYHgfEve0Vl9nyFdgfjPCURw8fQM8Nd9oSvZer?=
 =?us-ascii?Q?qIbgz5nL1yIyLmlDz0E+yXMcEf3MvD8qo4MqdoudaXGWXrPafjiBwLWqKff8?=
 =?us-ascii?Q?QerH/qR1Gl0kKuGUgTO+7MwwVyL/Xj5DI2dhygg/FPAwWjlxYYGRrkjTKf+O?=
 =?us-ascii?Q?wIe1yARLppPNdAIaJ9i9t3eOZY23ccI6RUm/pk71Mmdpm1DtRzIH0jVfJ3Wu?=
 =?us-ascii?Q?8E8ApfYj6/ocXNj5pUUu5jJ+MCoiwr13GtQWMa+ya9Ha/8bZzhbmMSwQCmaY?=
 =?us-ascii?Q?Rx0ibajH0Ykn8GhEiW9LGBWxamTRU+30CUkBdUzDgaxfM/plk9X+B/AU/I7O?=
 =?us-ascii?Q?Vl7gDCo4FgcNKrIcE9U6WeNfNSBPBAMz/71Y1aw0Vuh4ku2oQQZ54VHeo4Au?=
 =?us-ascii?Q?bErb+dDpAmejsLrqOnydyy3f2o6UWgA5ikjy0GvDUYd+PxPtgbodUy/NFRYL?=
 =?us-ascii?Q?+HN8wIpYb6KJyrrVh80jTj+vrk/QYJ4njaTluqNj3Yi/xS7vB3KSsGGhaVCA?=
 =?us-ascii?Q?H/kCSMljkp8y3a46SsG4p7QbsZs288eCYOK6KQKhRmthE6oEagXAZdYEM1GD?=
 =?us-ascii?Q?HAutZS7glB/4A5nQ1hTYCvW7diTDJ432+S3p06tQxKH+7An/5FhY7VF40w8G?=
 =?us-ascii?Q?DLVK3Fvou6nv9m28lzGVLpOWjO+A1TAN4HReltJZrUncsNYdq/Wx3Yj6xbPG?=
 =?us-ascii?Q?cNHE4QrjUtukZ4H5wTUEwchTMrmLI+pN1+MXLemQNCLAZVpj5LOEGc+cOO7/?=
 =?us-ascii?Q?pw8AfWjLZv414ZdkhIb+3re5AMQBbdYXpoDB2G6P818huc1QWOBADmliH6w4?=
 =?us-ascii?Q?eEbQOnZiFVuCJQeTKxG/dkvC78fE/E/qFw21YUMC0l2pXtBuq1fFsEf1KulV?=
 =?us-ascii?Q?T0R63NLUIxbDq4ruwrbBnOUe870YJfNgPJheru6LPP5Z7fKPNCXhLbLbbqo9?=
 =?us-ascii?Q?dUi2WFlCBQVrHPHoNpFJVidSW8GEPDlOXF1KGHfRk4s7untwlNLXYu6J/D6e?=
 =?us-ascii?Q?ei849rUgGtQilC1fmAA38k2I4ZJXxl/kbIuMnS+IyozZrhSa0A8mJwOQStbZ?=
 =?us-ascii?Q?C4xqQG9FqxQcrI9rWLKl8Y8a3WRl8D8l5QvZSiVrwIJDDRD+Ge9kxcSyExRb?=
 =?us-ascii?Q?Y8gNb59hu3VATv4qRSzcB3V7cSMzM7meltdL3Iw7/W5D4Dnk52EIJ7t9pnbc?=
 =?us-ascii?Q?FzDowmRcaEtOg0lmVelC101E75O+ai8O8WSaY4sna70DMCRGXLnbXt3stZYw?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MmXfXdU4d++8gug2LPIu3Dtji2oDcjwl+vD3/0jqMsf/E2XFsiDV9NQRugnZC7od385RWeMg2lsBgn1cob5JHRXroTYGjMM1J21NNQ15p9w8cHm5xWIKAe2TUIiwERvaHawm9nigWP1pwHzcbnRSSS6EQ9UMt+sj1iUFU49XMKs4rsL+L+1dwxAKVvCFb3VhHKjHXqieNDSgx06q0DrCjjCGF8gufpHqhQQSV9OsH4lukCa9+tpZFATby1NPCtxNmfdkGEp+ZWT4IJB2lYPcRget5cEVAARJo+pVlkdm/4oedZu0D65zWc5CFqw5xYofZcz3BHZ3J+J8NjfY21dPAmFySlP69qBw3H4+bLwSQgL74FrqOJbTncfoAX2OP9hiGJNa6Xh2Gw5oVvbFWzngYGEIgEHpb+48r2cVpdZmR99hyGQWeK1PffNvyExUCbltgwCoNVw2MGk55ORVJ+GwEJfr9bG1MJu94dXzVR27B4MUJKFeRIJnQso6fNyvHxR3Pq8VtKIRqeyM3R2IPyS8G8RYCKgcDtwnSVsOjkfzIXYACwVf9kDUSSbuLlDfxNY75KLBMLF8MlWEy6YfUVQ1sbDw6OQ1uFxLwif8nhpruxI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 992bbf38-0a99-4fb8-04a8-08ddda70630b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:50:39.0082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hXUtFr+ykGbWyWacLuhtWGWiNpdPZXWbixT2S7ZHM7cpTCPIs1DWPoNkRA9Zn+fxvGxI8uFX+nHgkSRHwDTMgaMfdLkMMm7LprDRGSi8QO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6226
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDEzMCBTYWx0ZWRfX7rGwYy4Pn85c
 zTjuM+xJLGk4yJeVpMbslKZBRZf9PwKgFLW30Wgqs34vWcz885F1EQ2/sfTA9cNrdhvo7zWCqiT
 jDJfj9TKPBC7PpUN99Xjw5fm6PJJTw4BsURh1Jm82uvWb3cCWCC95tk4KNYHgoloIw1Ap8yGUnH
 XCHyvIna4BnFZ0lvTIOOqu7AyATkWBShY4ZjxDcJotsseC7ClPdiV5xj0KG9MFeLiJsSltIgx6G
 aPxW813ILsxjYZ5yU776z3I9jcahMEH2G8+vuN37BT4aM5Yq0srisLBIN/vlhTw0spXp2tv1sL0
 IE8CDJ9hI4ehrC4/Bsv7DKLhGGdT04HXH4tmslgNOU8+HuOx1l5csF5P4IDjCUjxqurSF8yV/8q
 yeHBAiI0mySKyandvRUvbfgTwV7T/fZ3cIuQkMkx+3geKnCyFWfwdSVk/bp7puFJ+PoB1369
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689c9834 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=3bAQ_Mzfqky2x6q3tYcA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: 7iGDZJOXF8yra6Kg8ChyviCq-1UkoVlg
X-Proofpoint-ORIG-GUID: 7iGDZJOXF8yra6Kg8ChyviCq-1UkoVlg

On Fri, Aug 08, 2025 at 08:28:49AM -0700, Suren Baghdasaryan wrote:
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
> Acked-by: SeongJae Park <sj@kernel.org>

All LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/proc/task_mmu.c | 103 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 85 insertions(+), 18 deletions(-)
>
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index c0968d293b61..e64cf40ce9c4 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -132,6 +132,12 @@ static void release_task_mempolicy(struct proc_maps_private *priv)
>
>  #ifdef CONFIG_PER_VMA_LOCK
>
> +static void reset_lock_ctx(struct proc_maps_locking_ctx *lock_ctx)
> +{
> +	lock_ctx->locked_vma = NULL;
> +	lock_ctx->mmap_locked = false;
> +}

Thanks!

> +
>  static void unlock_ctx_vma(struct proc_maps_locking_ctx *lock_ctx)
>  {
>  	if (lock_ctx->locked_vma) {
> @@ -157,8 +163,7 @@ static inline bool lock_vma_range(struct seq_file *m,
>  		lock_ctx->mmap_locked = true;
>  	} else {
>  		rcu_read_lock();
> -		lock_ctx->locked_vma = NULL;
> -		lock_ctx->mmap_locked = false;
> +		reset_lock_ctx(lock_ctx);
>  	}
>
>  	return true;
> @@ -522,28 +527,90 @@ static int pid_maps_open(struct inode *inode, struct file *file)
>  		PROCMAP_QUERY_VMA_FLAGS				\
>  )
>
> -static int query_vma_setup(struct mm_struct *mm)
> +#ifdef CONFIG_PER_VMA_LOCK
> +
> +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	return mmap_read_lock_killable(mm);
> +	reset_lock_ctx(lock_ctx);
> +
> +	return 0;
>  }
>
> -static void query_vma_teardown(struct mm_struct *mm, struct vm_area_struct *vma)
> +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
>  {
> -	mmap_read_unlock(mm);
> +	if (lock_ctx->mmap_locked) {
> +		mmap_read_unlock(lock_ctx->mm);
> +		lock_ctx->mmap_locked = false;
> +	} else {
> +		unlock_ctx_vma(lock_ctx);
> +	}
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> +						     unsigned long addr)
> +{
> +	struct mm_struct *mm = lock_ctx->mm;
> +	struct vm_area_struct *vma;
> +	struct vma_iterator vmi;
> +
> +	if (lock_ctx->mmap_locked)
> +		return find_vma(mm, addr);
> +
> +	/* Unlock previously locked VMA and find the next one under RCU */
> +	unlock_ctx_vma(lock_ctx);
> +	rcu_read_lock();
> +	vma_iter_init(&vmi, mm, addr);
> +	vma = lock_next_vma(mm, &vmi, addr);
> +	rcu_read_unlock();
> +
> +	if (!vma)
> +		return NULL;
> +
> +	if (!IS_ERR(vma)) {
> +		lock_ctx->locked_vma = vma;
> +		return vma;
> +	}
> +
> +	if (PTR_ERR(vma) == -EAGAIN) {
> +		/* Fallback to mmap_lock on vma->vm_refcnt overflow */
> +		mmap_read_lock(mm);
> +		vma = find_vma(mm, addr);
> +		lock_ctx->mmap_locked = true;
> +	}

Thanks this is great!

> +
> +	return vma;
>  }
>
> -static struct vm_area_struct *query_vma_find_by_addr(struct mm_struct *mm, unsigned long addr)
> +#else /* CONFIG_PER_VMA_LOCK */
> +
> +static int query_vma_setup(struct proc_maps_locking_ctx *lock_ctx)
> +{
> +	return mmap_read_lock_killable(lock_ctx->mm);
> +}
> +
> +static void query_vma_teardown(struct proc_maps_locking_ctx *lock_ctx)
> +{
> +	mmap_read_unlock(lock_ctx->mm);
> +}
> +
> +static struct vm_area_struct *query_vma_find_by_addr(struct proc_maps_locking_ctx *lock_ctx,
> +						     unsigned long addr)
>  {
> -	return find_vma(mm, addr);
> +	return find_vma(lock_ctx->mm, addr);
>  }
>
> -static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
> @@ -584,11 +651,11 @@ static struct vm_area_struct *query_matching_vma(struct mm_struct *mm,
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
> @@ -615,17 +682,16 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
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
> @@ -710,7 +776,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	}
>
>  	/* unlock vma or mmap_lock, and put mm_struct before copying data to user */
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(&lock_ctx);
>  	mmput(mm);
>
>  	if (karg.vma_name_size && copy_to_user(u64_to_user_ptr(karg.vma_name_addr),
> @@ -730,7 +796,7 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  	return 0;
>
>  out:
> -	query_vma_teardown(mm, vma);
> +	query_vma_teardown(&lock_ctx);
>  	mmput(mm);
>  	kfree(name_buf);
>  	return err;
> @@ -743,7 +809,8 @@ static long procfs_procmap_ioctl(struct file *file, unsigned int cmd, unsigned l
>
>  	switch (cmd) {
>  	case PROCMAP_QUERY:
> -		return do_procmap_query(priv, (void __user *)arg);
> +		/* priv->lock_ctx.mm is set during file open operation */

Thanks!

> +		return do_procmap_query(priv->lock_ctx.mm, (void __user *)arg);
>  	default:
>  		return -ENOIOCTLCMD;
>  	}
> --
> 2.50.1.703.g449372360f-goog
>

