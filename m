Return-Path: <linux-fsdevel+bounces-54384-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7515AFF0A9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEFF4A7312
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5877237A4F;
	Wed,  9 Jul 2025 18:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ap79z3IF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="znff1UF3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013F21C9FD;
	Wed,  9 Jul 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752084873; cv=fail; b=oadlaq97uEXCb2aaXtGV1LVKoHdi01JgvxyVNbat6/rNFvWnsmLiZdYvInZQEtHEbmpOJE3aQvZpD4E66SUkCS1Asm7uPRapMzctQqq1stsl2rt/pdfRWSek+2RpZznYvhJ3ogIBl21C0jMUAqWSvRbtvAGDzfMMgF+HGcnsrpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752084873; c=relaxed/simple;
	bh=1gb3BodUeNhB17Ehxa1a/UDLQn3QMePbo9pYMHfkBK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tIxEOyeO6cw3uI/7QGk7ac/iry5wo3MNeUe2cC+UYExAKZHc8SoYIWwHuzATtQQqkeT13C+J80oXvm5FD0b8ajYOsUij5FrXz4gf1HdFxl0akmHHgowPHs59ct06xoMotvay9jxpvHCSMVf1SIMg/WVp8zB8ri83SWlDLwa26w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ap79z3IF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=znff1UF3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569Gpxvo017186;
	Wed, 9 Jul 2025 18:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=+7JXB8ZA1Grm5wCwM0
	155hMNXaQPD4xQo8CErhXeBsw=; b=Ap79z3IF5aQvx6sC0SrmPQu6mBaOoXgMAm
	mVmLxDlbWEkMaMt8LgbdcILab8TkUGkCbnyh+S7+Qyh9q0s+mCzTiBvMBANUDPSB
	hnhvu0lX5gftwNudtr4waKe6np+mbPyzG/rvgCqr5mD+kJkK+e/vx6A44wqxswcm
	EajYVXim+x+wLzoXkwWDUIclfQenN8JGJlEsc4MtcxuqQso5kbC8bW3O9vypaOXM
	PZhofqHpGxFOt+irdY+7313Y5JthpdxKQvim9zsrjDe81YKA5bGUYJxYpC2ILZJa
	rnTGT8L77pMUxeXYUIO0m3RGyEh3n0idxWZZQNFovv542AJaJIjQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47svahg4qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 18:13:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569HjhSh013560;
	Wed, 9 Jul 2025 18:13:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgc2t88-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 18:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiJ+LxDWz0wfiLDpu1GO2wrs1PtppKgqv/SKzT0XrHAfpa1MSJpiqTDwnzIeTY7gJE9hZZdGkzdkG45WRNd/SEG/7iVJnGsxsyE8DqQUdjSVeh82VVk0cvWVKR8kXEkmVL8/ILaTObqdBzjcwAfQFi+DAj1oxoQmOVfR4hjlvAkISCfR0FOKt+SBjSHoGT3AsCIwCCLjom79stpF2rAVxzduIFPTpcP+tti06CpdWF49tfbQ1NgVx5jGGdmyZZ/viWA1C975bFtRQu+X8t7k+I+yhTBU4U/zT5DoEblKDJcXGCgeMf08hfQ3SXTRlE684jdM9dSPx6UT0+1CFJ3FVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7JXB8ZA1Grm5wCwM0155hMNXaQPD4xQo8CErhXeBsw=;
 b=TDT7gu0BnRGQZPd1kuew7dMgxEwGZDBn+kL0ILDdpnHD/BUuRDLuzTBD/9yPJ4L69+Ek/b3tp4iMF3xkH9HzSloIl2CfPWKbCwtMxKB4zZzYYZfthxdZkHgpUez3r30eKCywVyqqpzNoHJTt/7dAYQ+LvPt+SrOMenAFqgQIT0NSnzCw02fDSj0p8064tDyM6zdCWv24AzhUCwVRP4QT+dLc+ISybupJGTiuiTjquKGGUApNlGm5QirOkWYLNfxdgh5fWBn4rfE7aOcBqfwQj3g444cOPxs+uDw+XSeUh56u6B7I1U+1yAC0/yZjeVVz/oYmmolBVdf87xP1BAMPhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7JXB8ZA1Grm5wCwM0155hMNXaQPD4xQo8CErhXeBsw=;
 b=znff1UF3GL2s15vQ+1OHckkbpoYe3hsotouXYEKa4ZVkGCuXUdKxssWoZ6Xe5zm9fmFM94zAMrHbeYJvZzLHwtsve3uubR7jnONctkJhc2mXObMtm502rjb2+uESACg2XFvOyZ1G9tMRWXqjunOLDFvtIsLFHZNU2L+KHoJsW80=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by PH8PR10MB6622.namprd10.prod.outlook.com (2603:10b6:510:222::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 18:13:45 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8880.015; Wed, 9 Jul 2025
 18:13:45 +0000
Date: Wed, 9 Jul 2025 14:13:41 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <vn7djxc5cnadmqxsxtd7frgx346fnsvfvlzyh253dxnwn3pe7f@kqci2ing4coj>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Vlastimil Babka <vbabka@suse.cz>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Rik van Riel <riel@surriel.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0033.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::19) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|PH8PR10MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d98555-982b-4d01-ef59-08ddbf1457ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DaQsWgctZmD5Du7tzER+5vMYJdx5D7JZMsdKkVcHBcj6koXzGuh1udkjEOOc?=
 =?us-ascii?Q?ISUMYyXLbudKQj0x83STPcGSRE5S6ZmaHB4N6fvMSn/GVPZxD/j61r8LJSGH?=
 =?us-ascii?Q?2W00Kf+AtRsh63nCEmEY/eQ1AJtiKssus5rT7dqT7NUW2yJqUZ6FE3E1zGhB?=
 =?us-ascii?Q?7HZBmDeuxj3amiQh47Mu+DneA1O2yQCnjOBcSM6ooxH+j5PL6+/cPW4oUSNn?=
 =?us-ascii?Q?5Fbmiu3TDFMq07DX3PNarBeMqqXVWBOHJVKv69GdsmOd1j4ftSOMJ5AB4bw2?=
 =?us-ascii?Q?HFJfxCuY90xrZzmRRgezWhscwBUUR0GR1dnK0opzFrO7WxLtKzA0AQcvWlgz?=
 =?us-ascii?Q?6JDOVm2sjVR2GUHTlWtK1BmVS4kLZcZqaGrGThnMgBHGzlV8wTEZzJGe0hrp?=
 =?us-ascii?Q?frD01y/V9VioEyoTU0v5+2Yaav4DQrDXUfl736mauI6uihPZWiDijGZuTibw?=
 =?us-ascii?Q?UDfyIKgXY4RigUaF5Hcc2ao9swVGCI+Yl3WvUJnS7ZbJWixEhM+U8ovjquKb?=
 =?us-ascii?Q?yVyiQ844BAmUUqkB8j9M+zF1isWF7N43YQqK3thsqWmLWdxrw2sJ6fRgGMBs?=
 =?us-ascii?Q?sjxbSHknx2VUD5MZVYEQaetq1Dl0Rd0DQFH7vtVEATPVgh/huISAkPeCV6Jj?=
 =?us-ascii?Q?OSRP18fXrq7NtUgTMVjVAVQHln0hCc/asmzcJc0iSWKCrrk6u8grijicfsBs?=
 =?us-ascii?Q?XgoS24BNVQf5yNg2m5rDzmzn23Fmh/RNNQz5Qa4hh0P5+du4BweqcnjRjj/2?=
 =?us-ascii?Q?f9k3KUtgVFooUxrUb4nBDe+ev4mcoYyqqSZm8lxr/0GLQcTrTXeejk/HxIal?=
 =?us-ascii?Q?GEhFK/U3o63SKuQSJF8IgqMIZ+Fyl+zxzY3i3Qq64nhsxjA6JRmw/5ES8iGR?=
 =?us-ascii?Q?bVGOFegTx5/9NBgXmhKkI0PztsX9UhOjRiMl/70zGRkfD54uRHUXbsg7aipe?=
 =?us-ascii?Q?nFrOYUXJZ9sw0/l12PymIFuKW9KarhlaJyCDOcm846+DmZhwNso4Hwki7h1u?=
 =?us-ascii?Q?tvof/++6OBHVq7DscAs0/7KlZRQXzizCpTqW1zMP1yYJ1pk6qZJXsvViarCX?=
 =?us-ascii?Q?U2o4AyY7s2YibNivAvH6scI8kt4tsQ/fyZISUNuvGYR6xejvjvDiYC3L9we4?=
 =?us-ascii?Q?4Hjm4NRnXDSd6N7C225ODCfJLhoAbXDi3J3Zr6KVSYnRAaGN4oh9BTkVm3QR?=
 =?us-ascii?Q?iKk9azZuu1Ya9PSBYhNmjkPL8sdLeeuuRDfzksPKwr7X5kc33ZhRKSB86yOS?=
 =?us-ascii?Q?8I5zG63KiNeyHjoNQxuOCT00v2ifu7sLmuDzDKiMbETkuS9y7F4JgAvjT1Pr?=
 =?us-ascii?Q?p6u4KoRuVeCxX2Ny5r1x77zsJNAXdNe+8rKbk94MybZHI02TSOK5z3sQDh+z?=
 =?us-ascii?Q?phgPljKXa5s/n3aSw7z1ldifJcooVdlYVafMHD79znaheFVWXgcugvPBBakj?=
 =?us-ascii?Q?9xgH5rL6fKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gs8xGg2F3xONEu/Vq7egs08L7Dd8cSFhxOwteAb+oTG5dcba4rb7YshTyGXP?=
 =?us-ascii?Q?QFYHB6qzQLJTKZMQVA82meHKLv5cUh09ZAH/0FPgiIqc3Bomfo964r69ZA4i?=
 =?us-ascii?Q?pTqwemgmDbPcu92+KMYu66yNJV2Ad18b6WuZmtJ5U4nudnquiva0m3Wis0LT?=
 =?us-ascii?Q?F4XazcS8nqbMsMHpwhwqSFIDvCJAwfXkk6tuvcI+phBtn57ZXqIHxJ2shu54?=
 =?us-ascii?Q?/iOcnypREONmkMGGZx2yz8SxYJUKHIl0dfQ7ybC3AtlCweK0EhPEs5GKc19Q?=
 =?us-ascii?Q?a4jqr3yOowiYZR+1jzF3fih/Tvmb/nsjsUllyaRAMYYu5EAQy/swbt9Q21OT?=
 =?us-ascii?Q?pUTAJEPTEg332VXbjI8o7vC5uYv048Z0Gn7fvtRfQ/jzCvkg/FTcYClTFBXx?=
 =?us-ascii?Q?gBWlM9z7qZvWT042crucDZNilZLi5hfGH10MKkcdLgcYooAP1wLVR5F1VbeQ?=
 =?us-ascii?Q?COAw0oqUD7Yt7dJQ8loaXSqiRUpWfGrYNiRv3tsSz7Ephvz8W5p3cCeJdJLq?=
 =?us-ascii?Q?R6fPIYJNNxjyNyxC92wbNHom8w28nB+8JS9H8hkWdRY8RZXONWB1okg3HmOk?=
 =?us-ascii?Q?uQz0uTTD5QvXSgNJDtjONqCshr+pfKLcAfya1j4LltavGBfHE1zJdWxqSbRb?=
 =?us-ascii?Q?RdpeWWMDhsAc5jb5sSMaXcWDdk7uJ5Sy38tvBZ9Am7ztqu5i7W+ZTAIHa+S8?=
 =?us-ascii?Q?eTefctCpIExa4QP6GcnVmNPyB02cM1jgOFaHo05fzWfaAtAPyO/R5MtreaA4?=
 =?us-ascii?Q?VVadWPYzFnB1Hug1iS2Ejqzu3MxGKAr2dm346/7ZPks8MG1c6t5IFt/bdyNc?=
 =?us-ascii?Q?jECKmX4Q1AWpZtkIjEA8j/wf82l6kN0DKgcJVBxllsCenyGckm39QT59LPBK?=
 =?us-ascii?Q?jJBSJoXVNLrmo00fHnGjvZNAaxeZnMt0hnQ92bF9UEEx/UDiquP3SOo7e25X?=
 =?us-ascii?Q?ay4qA5z+tWdrmg7S7cJ3MDf+6dEAyd+tAG3CRk9pcH6Du+uPy6dzcMjg5a6r?=
 =?us-ascii?Q?knCdoVpOXHfGVa7PJ+mE5PxrlB/7MB/X0Fi7Mz4NjDGworANodJcWLutPwpp?=
 =?us-ascii?Q?tSWga498ZXqgYYegOXejK46VEfzEEWf3w9IXQjaGErrdgynRqbWARgs7Xaxm?=
 =?us-ascii?Q?2V3dhDoGmnA2W5KyTMXLl2PjiJOKEovMqBCVwY2chbQREFcC8sGiDQVd3TlY?=
 =?us-ascii?Q?vhDojIgiu+M1/lDqCxPRFcc2tzAtrXayiZWFJQOdoKUBkCENURzoSyayHo2h?=
 =?us-ascii?Q?3oRBAb5IDdnDYCB++OGhFEHY3BSP58qMzwy9UGQcBy08i/wl/WBwoLLT/XdZ?=
 =?us-ascii?Q?a0FqNGnkzg6QwGPxUVNrW/xClJa5eaPgyBCuWXgH0fidruQ2XYRojhPpMde2?=
 =?us-ascii?Q?0BNBLtH/ol1pqfchE+dUFFpRtBb+X+xWCGtOaj6k5BXiUOTMIAofJxwIgdrB?=
 =?us-ascii?Q?EViR4V2oPKJCWEzsa+7yrGbREmVqcTQF5g0jxDfmDX+cA0mR7rracqT9R8lr?=
 =?us-ascii?Q?ar+DaaoJ9ZfIyNFuc5RALMxQ8j8Sw5ESVQ5vgaUgge5oblU9S6IATPj0hHso?=
 =?us-ascii?Q?jL8suWNGTjPldJPGR7MjrCLXJMplFusbINc6Q0Ds?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cYEwHo6vCylYYsMGNWJocMHtdwSrzGEkITDRK+oMEm36PsddDXUw21XKMVQhExS5/1fTIgv9YDg0Zl1u6291SSodWMqd2FtqaDr9JZDpGwN4ZTuEjL+beSDHksjNJZN2pDSPtjFZTmK185vJws9QyV/fN14gjDom4Ui5zs7bjM/rfTwDmOtoqGBGW6oohWjNZpQdQREpyfUxpV/O38/ZEkZOQKQVNmPlorjrsPEJHdioeDI+JgbhyXhnJmyQTRJSRT9EsQ4rT3hJT+r94Skg/Up4TpheiiTwKjkUXruSO3BXE5hk7z+vbf2s1CWdbfGKoazDAPf5I0N9CV3LYWMckj1bE/CQRF4Dm6LBTyPiwymEM2oAfrVmXkkj0r7lox3bzr1AMMcjXq99CF6zOOAKvs7SiQHgKcje91ewqeekhDWYsDHRzRcQGAHYphGatieee8eWlQORCZXDxGlhNtUSCTfU80mz/QHK9Htd8I0bZ6V07b8isDbO5IKmpG4xyJW/UJMQi9wkjZp5VeLkhXa6I2TZAkXkrzmkbN0I81UC3xb1+Xe5uZdYRSypY1WbHHlLAtHGywv64AH0DBhL/L0pce4WIBseEjgmJgVi5RyVCzc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d98555-982b-4d01-ef59-08ddbf1457ce
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 18:13:45.2891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHskCQ0hzPQiEoJlmSByTSUb6TTG4+tyIiFSb1nR3xBp0HqxNQfMGXUwLDSTNbTUd6hC84X8iNYd6dG3fdwYWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6622
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090164
X-Proofpoint-GUID: h8ZBqxEk99dwVGZ-DIBCc3TzZFYJE4AI
X-Proofpoint-ORIG-GUID: h8ZBqxEk99dwVGZ-DIBCc3TzZFYJE4AI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDE2MiBTYWx0ZWRfX5lFU/AYAYAFS 0bihJyw8qGiR3s6qrY95WsbRNdKAiUjZ8OpXjKqcgPBaFIZgu8soX3BXY/VTrpoCQzqdNTYtmtF h266OkK+anMoNG/pJ8XMa8Y/foOg9jzqRWetrrJvMyfjHtgM+E9zGjYF1MdayHujL05xaErWbPl
 iF5jT9xf1S1MGle/Xo8cB7e/Ncq4JFSHsEHcIb6GuQ/0fzmGwIxRM0eko2rudkW7ZDYLMpoi7h7 bqCfSa+eETn14qAh37MCdFfK0HIhjn57izoGhYSK0VlqoBA/vQhJrmOgRrxeW+TFi5Z+jNQScdn 95jGeg7JkJhQzu7Zkl+OJvNskrul+dvo8H54NEE+2cqzoNdBnvDYg6vBD2WOjLC0/3mbdj7+lJO
 7JX/ITygbuI1fkmxkHbqmfRYZHegGh42J8lJizfFgwWEvIif7DRHW7VwcIR9Jyf/zj1/Gpbh
X-Authority-Analysis: v=2.4 cv=UOrdHDfy c=1 sm=1 tr=0 ts=686eb15c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=_1LO3QovEPMF8vdGvCIA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13565

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250707 01:28]:
> Historically we've made it a uAPI requirement that mremap() may only
> operate on a single VMA at a time.
> 
> For instances where VMAs need to be resized, this makes sense, as it
> becomes very difficult to determine what a user actually wants should they
> indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> Adjust sizes individually? Some other strategy?).
> 
> However, in instances where a user is moving VMAs, it is restrictive to
> disallow this.
> 
> This is especially the case when anonymous mapping remap may or may not be
> mergeable depending on whether VMAs have or have not been faulted due to
> anon_vma assignment and folio index alignment with vma->vm_pgoff.
> 
> Often this can result in surprising impact where a moved region is faulted,
> then moved back and a user fails to observe a merge from otherwise
> compatible, adjacent VMAs.
> 
> This change allows such cases to work without the user having to be
> cognizant of whether a prior mremap() move or other VMA operations has
> resulted in VMA fragmentation.
> 
> Having refactored mremap code to aggregate per-VMA and parameter checks, we
> are now in a position to permit this kind of move.
> 
> We do so by detecting if this is a move-only operation up-front, and then
> utilising a separate code path via remap_move() rather than the ordinary
> single-VMA path.
> 
> There are two tasks that occur outside of the mmap write lock - userfaultfd
> notification and population of unmapped regions of expanded VMAs should the
> VMA be mlock()'d.
> 
> The latter doesn't apply, as this is logic for a move only and thus no
> expansion can take place. In the former case, we explicitly disallow
> multi-VMA operations on uffd-armed VMAs.
> 
> The mmap lock is never dropped in the move-only case, this only occurs on a
> VMA shrink.
> 
> We take care to handle cases where a VMA merge has occurred, by resetting
> the VMA iterator in such instances.
> 
> We needn't worry about self-merges, as in those cases we would, by
> definition, not be spanning multiple VMAs. The overlapping range test is
> performed on the whole range so specifically disallows this.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  mm/mremap.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 99 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 28e776cddc08..2e6005e1d22c 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -69,6 +69,8 @@ struct vma_remap_struct {
>  	enum mremap_type remap_type;	/* expand, shrink, etc. */
>  	bool mmap_locked;		/* Is mm currently write-locked? */
>  	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
> +	bool multi_vma;			/* Is >1 VMA being moved? */
> +	bool vma_reset;			/* Was the VMA merged/unmap occur? */

The name doesn't read well in code.  vmi_reset or reset_iter might be
better, but I don't really mind it like this.

>  };
>  
>  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> @@ -1111,6 +1113,7 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
>  
>  	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
>  	vrm->vma = NULL; /* Invalidated. */
> +	vrm->vma_reset = true;

I believe the munmap() operation leaves the vmi in the correct position
to reuse, so this is cautious that costs an extra walk of the tree.  I
don't think it's critical to performance, but if it is we can look here.
It would have to be passed through which might be a pain.

>  	if (err) {
>  		/* OOM: unable to split vma, just get accounts right */
>  		vm_acct_memory(len >> PAGE_SHIFT);
> @@ -1181,6 +1184,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
>  
>  	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
>  			   &pmc.need_rmap_locks);
> +	vrm->vma_reset = vma != vrm->vma;
>  	if (!new_vma) {
>  		vrm_uncharge(vrm);
>  		*new_vma_ptr = NULL;
> @@ -1325,6 +1329,7 @@ static unsigned long shrink_vma(struct vma_remap_struct *vrm,
>  	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
>  			    vrm->uf_unmap, drop_lock);
>  	vrm->vma = NULL; /* Invalidated. */
> +	vrm->vma_reset = true;

Ditto here, lock depending..

>  	if (res)
>  		return res;
>  
> @@ -1362,6 +1367,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
>  		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
>  				vrm->uf_unmap_early);
>  		vrm->vma = NULL; /* Invalidated. */
> +		vrm->vma_reset = true;

Pretty sure this one is needed, regardless of passing through (and
updating this call).

>  		if (err)
>  			return err;
>  
> @@ -1581,6 +1587,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
>  	return false;
>  }
>  
> +/* Does this remap ONLY move mappings? */
> +static bool vrm_move_only(struct vma_remap_struct *vrm)
> +{
> +	if (!vrm_implies_new_addr(vrm))
> +		return false;
> +
> +	if (vrm->old_len != vrm->new_len)
> +		return false;
> +
> +	return true;
> +}
> +
>  static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1644,10 +1662,29 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
>  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
>  		return -EINVAL;
>  
> -	/* We can't remap across vm area boundaries */
> +	/*
> +	 * We can't remap across the end of VMAs, as another VMA may be
> +	 * adjacent:
> +	 *
> +	 *       addr   vma->vm_end
> +	 *  |-----.----------|
> +	 *  |     .          |
> +	 *  |-----.----------|
> +	 *        .<--------->xxx>
> +	 *            old_len
> +	 *
> +	 * We also require that vma->vm_start <= addr < vma->vm_end.
> +	 */
>  	if (old_len > vma->vm_end - addr)
>  		return -EFAULT;
>  
> +	/*
> +	 * We can't support moving multiple uffd VMAs as notify requires mmap
> +	 * lock to be dropped.
> +	 */
> +	if (vrm->multi_vma && userfaultfd_armed(vma))
> +		return -EINVAL;
> +
>  	if (new_len <= old_len)
>  		return 0;
>  
> @@ -1744,6 +1781,57 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
>  	return 0;
>  }
>  
> +static unsigned long remap_move(struct vma_remap_struct *vrm)
> +{
> +	struct vm_area_struct *vma;
> +	unsigned long start = vrm->addr;
> +	unsigned long end = vrm->addr + vrm->old_len;
> +	unsigned long new_addr = vrm->new_addr;
> +	unsigned long prev_addr = start;
> +	VMA_ITERATOR(vmi, current->mm, start);
> +
> +	/*
> +	 * When moving VMAs we allow for batched moves across multiple VMAs,
> +	 * with all VMAs in the input range [addr, addr + old_len) being moved
> +	 * (and split as necessary).
> +	 */
> +	for_each_vma_range(vmi, vma, end) {
> +		unsigned long addr = max(vma->vm_start, start);
> +		unsigned long len = min(end, vma->vm_end) - addr;
> +		unsigned long offset = addr - start;
> +		unsigned long res;
> +
> +		/* Merged with self, move on. */
> +		if (vrm->multi_vma && prev_addr == addr)
> +			continue;
> +
> +		vrm->vma = vma;
> +		vrm->addr = addr;
> +		vrm->new_addr = new_addr + offset;
> +		vrm->old_len = vrm->new_len = len;
> +
> +		res = check_prep_vma(vrm);
> +		if (!res)
> +			res = mremap_to(vrm);
> +		if (IS_ERR_VALUE(res))
> +			return res;
> +
> +		/* mmap lock is only dropped on shrink. */
> +		VM_WARN_ON_ONCE(!vrm->mmap_locked);
> +		/* This is a move, no expand should occur. */
> +		VM_WARN_ON_ONCE(vrm->populate_expand);
> +
> +		if (vrm->vma_reset) {
> +			vma_iter_reset(&vmi);
> +			vrm->vma_reset = false;
> +		}

What code path results in vma_reset == false here?

> +		vrm->multi_vma = true;
> +		prev_addr = addr;
> +	}
> +
> +	return new_addr;
> +}

The iterator use looks good.

> +
>  static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  {
>  	struct mm_struct *mm = current->mm;
> @@ -1761,13 +1849,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
>  		return -EINTR;
>  	vrm->mmap_locked = true;
>  
> -	vrm->vma = vma_lookup(current->mm, vrm->addr);
> -	res = check_prep_vma(vrm);
> -	if (res)
> -		goto out;
> +	if (vrm_move_only(vrm)) {
> +		res = remap_move(vrm);
> +	} else {
> +		vrm->vma = vma_lookup(current->mm, vrm->addr);
> +		res = check_prep_vma(vrm);
> +		if (res)
> +			goto out;
>  
> -	/* Actually execute mremap. */
> -	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> +		/* Actually execute mremap. */
> +		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> +	}
>  
>  out:
>  	failed = IS_ERR_VALUE(res);
> -- 
> 2.50.0
> 

