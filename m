Return-Path: <linux-fsdevel+bounces-57794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D12C1B25548
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 23:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E79AA9A59F9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 21:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3785C2FF14A;
	Wed, 13 Aug 2025 21:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KDAVhjXq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XkHMqurA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1A2BF009;
	Wed, 13 Aug 2025 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120243; cv=fail; b=mNXGt9huiPqMv2pSAZFIFioJL08d8bp8YgaI7uzIaz+y3N24GfwmtBHfHiMawBTSEMxW9B7pbS/j6peaOxXwQq/aMU1nHQ3NncC9TSr3iNe8xX4Nj0dI8YpVsHT6xrnu2AYuDSKYYPVRFp5QDRfmzbNiEvMggruDb1jQltDJ5Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120243; c=relaxed/simple;
	bh=yCURNksoLuvdEIE40B5z7clMgG2Ht8alPHHMdNQfC10=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=iV5yx8knp4YH5ylpJfWBdy+KIE6kA73o50tB4lrBeXqkhH5TxsyNINvy6S2nwN8ZIeJUnBNCMsOQP1pwOKM6w8RSeAeMl6SLJKMgCXVMACir1xJwqOhgH5b+fdbnrvCI152dfVPPLwgZOARk9DibQyFoB+GAe70LJtRNh6zw29A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KDAVhjXq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XkHMqurA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DINEtV014501;
	Wed, 13 Aug 2025 21:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=NOvdPw/lgrLj/0F9X9
	1JhxMGbke/EtHfuT2nkr78j3c=; b=KDAVhjXq9UGPBDBTd4f/fR8VLk9Ypfj97s
	uYPL6ztAOv4+kzPbInALCY6QDPoQKPGhS3tQ8i9cTkpU3mJ+XKFGuXKK5dzT7yOh
	liXU45EvhERj81jr0gun7MEQRLpPdtX1WwIQJo7h5knSeRQavlI4GFA5ZzKw4hHz
	PTu2e11rN29EX7bEFSiJjdJa15k9iP2NbaBdNHsSM4FA/62GLbAaTktnd6ugVseT
	KllIHb+ST2GCH3pgy5MIFAUb9fkGeFKxFYcYhf0BPT7Lj7guf0aH5xZ9ueixUs7K
	ht3jSk/o3jeItMygkEXb1+TZu1S4Fvdf7M1rNkywoDQjbe1Eso4Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvx0dh9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 21:23:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DKuguZ030057;
	Wed, 13 Aug 2025 21:23:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbxd4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 21:23:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h33OiWdui1Juud4nG5Zm7OszM9cU8M5/NKBEVdfkDb5aYvFqnF2cIfBUYsDCPsorpw5lGPH3bNgILRY6V7ibMBO0GdHTM2w1anlS+da7BrVJwjuaKEM1C416CCoSv9JbR07CN3Tzzn46RooThDgalTCmurTkF0lhf3Fu5svp3a4grE3YpdUmaO4X1GXwJ9ZkNx+6l0PuLyi/p35u4+txEgytUuOIgGVnk7Otqy0DfeF51Sj6PLWdLGSIYovDdHH52aetBgGdmetv5a9iDxIzCPKK09JkXVtw5jN0og0uHdIZAeQOVIDkZY4iglVywRKo284wug1tMr9eTnKE0CjBIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOvdPw/lgrLj/0F9X91JhxMGbke/EtHfuT2nkr78j3c=;
 b=awJUkgboPjAnCdw7YHcyhkmfVUqYxgH4czhC8wE2dBKPV89XlaqKHvFW18iCuZgp6/tlhKaYi289LTfKnSvjEsugATk0Emyeaw9VNkRq4ZKeSox36pblytMhqlUkNFlt5yriegWamnBGIJAHKj0ZE66NIUzu+q8G+XVWaQ1gQzbcrPOxs+s6Rl60/kR25YDNH4V2uP3L+w43Pw1x3kwnUhuxhs9TQucZb2xUEhMBEeTnngHkABi/WLhuOLrBYCfs2ACY2YHwwQYAy+buxD6z1oyuM+QIDIfjRecBdcfFSIz+UMzjJn6EpgQ+Ld48Ji6xzgXWOmDR0nIuGyA3GHM0ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOvdPw/lgrLj/0F9X91JhxMGbke/EtHfuT2nkr78j3c=;
 b=XkHMqurAV5AAC2UatsSHoc6l28slDksyB9Kji1R/Rmj7Ri21rICoPG8O3WhladWV6oVvPVGmk1OBZ1lvYUR5V0Dsa96dDk2IaSCNOmtrt7uoE5ZpB+Q85exT8dE6uvfJsXbzcJTciyeWKk0t7ewqBsk2ndHWhdEYl7Hphrqp8t8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA1PR10MB7662.namprd10.prod.outlook.com (2603:10b6:806:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 21:23:50 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 21:23:50 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        snitzer@kernel.org, axboe@kernel.dk, dw@davidwei.uk,
        brauner@kernel.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aJzwO9dYeBQAHnCC@kbusch-mbp> (Keith Busch's message of "Wed, 13
	Aug 2025 14:06:19 -0600")
Organization: Oracle Corporation
Message-ID: <yq11ppf2bnf.fsf@ca-mkp.ca.oracle.com>
References: <20250805141123.332298-1-kbusch@meta.com>
	<20250805141123.332298-2-kbusch@meta.com>
	<aJzwO9dYeBQAHnCC@kbusch-mbp>
Date: Wed, 13 Aug 2025 17:23:47 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR07CA0023.namprd07.prod.outlook.com
 (2603:10b6:510:2cd::11) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA1PR10MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f2bada-e646-48ee-2f9b-08dddaafb215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MxgDHPluNByKGbhMa3czKuzPkVw9L/QptWI6Y8i2sPS550ArhjWYQ7pr61Y8?=
 =?us-ascii?Q?gvpRTszXVr6+2v2M60yMKifMRR6JzQjtqAoYwwkEijsaMhzjUZ+nYR7bemGA?=
 =?us-ascii?Q?d4/o1gW2JiG7QdpCiPosDGM5pteUSiLFkT1fHreo9CA1NdUnTFHc8vUosWyQ?=
 =?us-ascii?Q?T9un63Fsp2WIwR3lF2MDVVm/kWz5u91mv8aioRDFWnoNS/SVMBgQPrCocgMN?=
 =?us-ascii?Q?xs0b0jMHilZlaL251tBHdCZAtgObJ22i7LLtXZZ9GXelo9Se6NSdC17tM2lB?=
 =?us-ascii?Q?Kq7eLS0z21yqO70gq2pdkQaRzfQ/uzlPLprp5DF5Ny+TGSxz0uL2J18pOmWP?=
 =?us-ascii?Q?ziiBs08/iOh5yBEbu8T8GZ3lUKTk1gdWXKIPwfNxa04jKQh2OIxqtrbxNti8?=
 =?us-ascii?Q?HFfYEwFWbfrAgJ3055vD04zYL2KKHfUSNzJzI8H46LrNxabhQx6ojmAWwtHr?=
 =?us-ascii?Q?1a3D/XmZm0K1S5FT95UMDljegN7oX4LmmNNPgQ/3SjNVmQs5pohIh4TPEB9X?=
 =?us-ascii?Q?4hUKgHFOlsEn8YhVagW88m6LvBPI1T+JVRWhUuyMlwGkTEsen2F886L4817A?=
 =?us-ascii?Q?0falSmTzOqSBm5z/Hphgn8bJCdTFJg5PRhcRwlLd8wLlF+zuYHovS9c34XWH?=
 =?us-ascii?Q?Wz+QOTbGG0kzd4sgRojgU9WsilMab4Mf+4CxA6Bvn+apQBsoJugWvRuCfuCs?=
 =?us-ascii?Q?pNmguAnqtHS5L+cLtP0cLKQThlTac9vcur/gB2K6uj8sxbRn0XADPge6DpGC?=
 =?us-ascii?Q?QLX5R3v8P4gHWCKJ6Xp/+8xmWEsOI4NqvK2EnouqVpXr4VuZIcz2qc9xvyXq?=
 =?us-ascii?Q?t01hi31Ugsh6WaSLX7LZisXq+O47WAcI0LR0EtyEoVPUk2U9s5YvPcaEbtLa?=
 =?us-ascii?Q?JmD+A5iTXeoLZ7Gs7/WErFz9MPikMRwNW1eiBdZtXp3jsfz8aKFuuJhGpTSw?=
 =?us-ascii?Q?qxMmM+QfXKmelhWgjppGS53YfifvCtNBTF4enmqtG7cdkXSQ1XsQezGWOJjG?=
 =?us-ascii?Q?VaJJvZqLh06+XbgknvBzPJP0lWcHVOA/0bsZfARtz5YHrUxo0tREWNtMDZPr?=
 =?us-ascii?Q?oRudmfzLtRdcFsAQdp/JB5rpqn0Qlw6JgfhsZb7rI7cnhq9aZdL6VuiKmCo/?=
 =?us-ascii?Q?qDwShTUVDNV34WkXtG4TigN8EQ8FTBcx/eMtp2q82DfNGFSxS5YEMELlnLA6?=
 =?us-ascii?Q?aOWODaDIahPXRX3raWqkIHqlcaPgfxlNzIP/4pfYho8heaz3qqU8NDSYhh+n?=
 =?us-ascii?Q?6rbsX0QywsL1HpNQ21e86tgQmjtfYQ9FmDPZH811lipqlcXjLZpcxoWplxGx?=
 =?us-ascii?Q?/REi1kQ0d8xU1XUEJV0+e2OGszZ/3pzbkktfNGsSKtRN9K/EsIYNbm3xgKZp?=
 =?us-ascii?Q?EkZ1TJD+dG3BwDwXbqCyTi5QHAS3fBk1aCxyj+/gXYdFSRraebdb1az8ZXO7?=
 =?us-ascii?Q?ZF+qt3/vDvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?G9cciJf5o+8d5SYkuDp4wrmaQGKGBuUZWHqvmClLDpSyr4ac8+iqpHkJ76gF?=
 =?us-ascii?Q?8HZSbPO185tnE2ljv5vGC1is3BLAeGUrx2/MGOf8+p2DyoQE8oJdz12I8/O4?=
 =?us-ascii?Q?hvqlq2uvLfcuL+AIklKosesy5aiP461xkRYgmlm6SqJKc2tKAV6pZJUJdFML?=
 =?us-ascii?Q?gXNpLCaMknTGzsf1ZBuiwFmasLiyO6PDzde3W4f4Mw2mWXrIMCPOnsG/ylXR?=
 =?us-ascii?Q?70Yf7gz6VzGeHL1dGsgRgK0MQDq71mZXIZ2qeHmDIrGLtBwPrZPRJfcIxELS?=
 =?us-ascii?Q?K2p6shPnle1D6KU/qKTrYG7a51k1VzUlOcT90N2melFo1wo9RrsP4cPhq97R?=
 =?us-ascii?Q?FG75igWtZjHRqMWLH5IqTMqox0Fe8GXDNl0utcsAaU9CZsmQ7qzllSb1Jduh?=
 =?us-ascii?Q?QekZLpiTtaouD1gwRaI0hWbFdKbRzBb024gpARu7GB5+qQUQoJlXK/sBlDXC?=
 =?us-ascii?Q?ozp7Y/n8kuhoXZ5YK/oliHuzRMzWasDMemsqXj5WK9HapNmM+O0QO+bj7Z+9?=
 =?us-ascii?Q?VCFhlWnOj0eMrlNhMwEXgymdlwnLYuDbnMYkSgk/vexS90dORtpmJ64n+cK+?=
 =?us-ascii?Q?WVnl3A7ZMO3uZf5Jqgowxl0teHJQZ55XAkA1k8pJKfqF172GeycrEr215vf7?=
 =?us-ascii?Q?gywizQl1Y/0/8E1a5gIcNPjM/YLsZbsy6XGu2+aWES3v7g1RtnG/3JX0cj33?=
 =?us-ascii?Q?F2b2oSkrnvr8Gjf0Bo+WDJr7etIP00LuKR6rHNtVDMZ3FrLUG5s+win6gSfL?=
 =?us-ascii?Q?cphdfpAvLbdG1AF/pKXE5zxDJ+7ft7CMax2VZw32j+mS9YI1UeDF0naV1p3J?=
 =?us-ascii?Q?VZV5DIglyj5udNJIIE4GE1C4HXKCpkyKf5njrbXt9cbtDz+7vDRBb036SAJB?=
 =?us-ascii?Q?WgdsuZLqfsc7x0ZiFCht6aFGNUjv7CRSsJ985k0olKFeL2Wof9ONcbQkfe6o?=
 =?us-ascii?Q?HQIZ5S2AfH6L/HkmlAJCG9CQciEpw1ePL6RAYoCbi6Ic1N05eZMfcFpLfjGc?=
 =?us-ascii?Q?3VP5GFWHci5HcdlLATlceY090EkVithe2ZLY400efXPG8cpbwIe9Ssz+RrSF?=
 =?us-ascii?Q?fzyQe3b8dYV/glG9QD/lqx/2DXbu4t0JaWOx0ak+5WNNe/fOw/xlMoihduE+?=
 =?us-ascii?Q?PIXO+x0alVOpO1UFK3nY2MxDrLaExZ6zuF26zP/a/KEvl0upalj0t0kbqtCh?=
 =?us-ascii?Q?mNRYp3VOa4N7GK5gWyoqUnOyMe/W15wPVv1ZDveNLyhA++qoWsFkLCPtED6g?=
 =?us-ascii?Q?ATuan1brdGT4xxbsur6QjsP+/C4P9Ej4ZQZ5dFSWSJI1BIQJbtV3X8qZKhMa?=
 =?us-ascii?Q?Ah7UR9CSX/A2Uyu4JW0Lhf4TBMET03ISLlGKchwBaRr9Fr/Gf58WhwO/mW6/?=
 =?us-ascii?Q?rlgAgs/e1eggXEH/tmNKd+D0zeHgyFhXloq7SMCyCVTI8DeFCMAgdGg8Rtq7?=
 =?us-ascii?Q?bx2m973u3GlCuYoj6Ow1u6dEruZYtbPUGWifZlNyuxbV3aMcdKxPIpqgO8XW?=
 =?us-ascii?Q?8/GTf+dc8zXCOVp7T9VfX4F3vo6Z/jjmNPEljPsFQWBKtjRxg7Wk+O3nQL9e?=
 =?us-ascii?Q?Xsw2327tvkGWEKIQtUyyOd7fDS7qrOYTARkGy7Dy3aeR0s9Y15WWSXs4iRgM?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	McO7LdjrE6TChAG6b5U7nUEa9qjykTFCRi6N/XWB0ZM6IzabyGpINsiI5TXrRQ1flHeUbDlvbJ/Ks6Q+AgeZlDZ3JImAvWpn13ahCrBEXF6kEw50jRJ0Krk2vCibAoxa6Zh8pJWtetgkqdHQuKkna6b6EyMy/8DtlYR4owzMW2IrIU93fEa4QJwlJGZRjFqxU3qwyTaS3C47CXmSGe+gSu9m6o6LQGhDXFUY7mpNRTLKuj2eb3f0twDxkHeySyh1VzlN/BNxJnmfcDZEENs9wUVq+LYaHAyuUrv+/7EUx734/q1Mr+1QyQeIY5mP5fqL+gdeDyrlgEAjuS9OoDZCVV9Xm6V/gvNxxU1pYUzqMCeCuGsWXJmM6DQbQnZjybctyXyt6jmhwEOHU9aJGozHwb4QOyB1SHgfaXXrNIEi5mNpB+jI9EMbDiTpxSS4V3T6les6ez6Pzrqy5rXhdTq0I5IubC1AJiAVpFIAl9VSX0QI+fs4O22DwDRXOzx8Gm/i7pHqncdayWweksF7VChLQkDP3LKt99JoREIum5k3RiZN1cLxTVG6Ibhl9pFNzL01ZE9rONHGf8P+zTnuxobbw72WpKaeIuWgkLh5Cwgizr0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f2bada-e646-48ee-2f9b-08dddaafb215
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 21:23:49.9462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N0aB9ZivYU8486q2XbOuRBfH3ysCJrImBlh86HLGJsgvI298lfqDKr5aFX26iaxdgn8JHuqVI8pXk6T8CylWhzQ1WOmzOad3FjPoZCUiOxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=969 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508130199
X-Proofpoint-GUID: oKn34vB179KhUeWmTJav9Tyt6vAB1BvX
X-Proofpoint-ORIG-GUID: oKn34vB179KhUeWmTJav9Tyt6vAB1BvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE5OSBTYWx0ZWRfX0eQARCV97ldT
 Hz/X2W+vZumFpqLx3NSY/BkqXe3BkO5PYrKIvPFKCageH4BVosbCcjzuMNFjVG0oCkgxKtO7h9S
 HC5fbfV7KnPjYRNZA5LRk1eMux/MaHUan5ElwSvVS9a0i/g9dMrgSZzH4O8X1Sc401vCbaE9lsb
 bTZ3UvR3qP1xswlg7G0GStNEZQWNuibvTshS4lcawXjYkxQYCFF+xFwnXDssdZyxHfLcIvV1WId
 2C3/tWakdiYbFQip2MLYdDcGHWDlPxTugO0FUnIQDAuGqMrndqU+d8kNrh+9uz6p64kfG7KjRoW
 tJcw5M168xstJfUn7H9P5pGfKBhmmQfsIcl0OtpqW9sJy29u9fkJsJEY0U8kI2o7vV8GT8zv8mz
 MJCAAqBbs/vkQLpnLW1rz64US7Oq3OyEQUvXwuQHWUpi+BnIzj1qqfiCoWJfRS2hlPVDf6xL
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689d0269 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=QA1YN5b2vGsZc-6Za60A:9 a=ZXulRonScM0A:10


Hi Keith!

> NVMe wants this check to actually be this:
>
> 		if ((bv.bv_offset | bv.bv_len) & lim->dma_alignment)
>
> because the dma alignment defines not only the starting address offset,
> but also the length. NVMe's default alignment is 4 bytes.

dma_alignment defines the alignment of the DMA starting address. We
don't have a dedicated queue limit for the transfer length granularity
described by NVMe.

-- 
Martin K. Petersen

