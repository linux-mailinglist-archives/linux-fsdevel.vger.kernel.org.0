Return-Path: <linux-fsdevel+bounces-23224-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A9928C50
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 18:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE56D1C234D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 16:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9FD14B075;
	Fri,  5 Jul 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pryy//Kd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EBE7meGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B348A16D33E;
	Fri,  5 Jul 2024 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720196789; cv=fail; b=rE/4Qud3XrvNCUr9lpuimh+/UM0hKaqajl5y3MwYU3zqAXDAABeMMO8vy6+byOG+Zeft6EVQ1ZVxAmUS9pPia3NSHssaC6PiAvOdEq2EiHjqiKAK5cyLevb04eN6PDH22C5p7Icfi07rfXvnT56Tf0LSa/xQEzTCg09AMBju68I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720196789; c=relaxed/simple;
	bh=7S8qmgiDZ4KaKnbLnOZATpk2+zaiQRDYh+tIcES/22c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g9U00JADlx3zfYzk97+eRQp1Rp+fI8fSauMXpYjpGptQnw+QSZR6F3We7libkmJwq19dcfB+VLrInsYGNigO1Q3V95c85siucy6+trYoMHepn3rNCSF/Qgvnn2jyfo27JoYrqmDizkSzVaj7bX7uY6SfJc1y86tgigMHJ41vcrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pryy//Kd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EBE7meGt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVtO011033;
	Fri, 5 Jul 2024 16:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9Bh/HevQTPbIuyZoyvW7vcmCWvEJKSjSIzlHv+QMp88=; b=
	Pryy//Kd65Wasw3BAwhvJXGe4QZ0gvkMM7+q6a8Be40sks61XdtmZZk7RPBftr3m
	O9Bx92phOTKbL2y43gU5pzUYe93B+RNqqBbfHjOHQZD9yHHGrdC2/5qTicKYBciA
	4hVbVHMXpXSpJdyvW7AfsSP8tWORpJK59tc/RDerwbq5rnYNs/JRDJbJkks2xWdk
	6fKjlJBzMyE422f9h+0nKM2blsQGXnDMe71jh4JR2P89JJtznW0DCPgm7HRINTfp
	442IjjjSz1XJE0aoL0GAM30/X6PT6ICfh8YbKXd6RxMSRICPkQBoLC+KfE8HO21x
	HYrS1o81I0D8RJ3ka9iB9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0v9dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465GM3Q8024789;
	Fri, 5 Jul 2024 16:25:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qc1c0a-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:25:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHrAjDxAixxnnM70bKmTDTmB1rooEj6DdpOB2DUtFYsVoZROl98vDLZzq8dnwugP8/e3AoN9+u89PNZb3EylwcJmLV7TQW1qWjXiSKX0ByfEV2Xr6t675amhPAysOJg0xfiRK51KJZm6LgdC+dfwTyUR5b2CH0ZveZ2Fc16vRi3l59bjsoqHk0pdsbSNXvD9AMgXxp3en/xUlC7nenQCdWzx7KwxiczuY//rtJOf72gIYgAViM9sDytdLWwF86QDMcrRTdYV4SQxjEA9twQ+wi6uSlRYrMS8DuP7De0TbgrMo8hww3uzZzOypd2mp2y2jZAOgIiUUV9zbJSbLfezDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bh/HevQTPbIuyZoyvW7vcmCWvEJKSjSIzlHv+QMp88=;
 b=OCQNyE+4kXvKaqQAQzY65yiOIh5I0yOUMs85oZ6BTCah0avEaUqm6OvUjjTAPRlpfCp2L4ycKc086E1/r0/7B+0cwGEjjZyPEXOQm6D1C3ZfhAmuu5neJHCsjJ9Fh2zhnRjrd2K+1C84hlwyys+ZgAe98+NkfRYGgTeaoqWW5WJmkSmu6BM60HnfhqbcHlouFrVfwnS29XjWNhs2zmz/VA27fVLMbqecIRrH1G+ae4F6D022Zl/iK6hwQMs0/YzkRKQ4rXUiHPWw/KuR7EXdyQhPHT2dN29Kiv6gC+mSpF648NCsHx/QhcmKj47/fSRLeOP9fn6a/VRKFeEEqiZP8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bh/HevQTPbIuyZoyvW7vcmCWvEJKSjSIzlHv+QMp88=;
 b=EBE7meGt1ycFEcBqiS9HPHeFgcJEXEFR6wkctkt2T9pHwDJfCvncv532uNboXwG+N1kLWqf9wUZCK1155EhKTiRvj/VAOoCH/vVdYNEoGPbHUUmQ/Pt0OC7ESwW/qHA3kVe2GFqW9CfxD0YhlVe3TeylSJ6a51iVAoj7tS8O3Lw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 16:25:16 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:25:16 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 06/13] xfs: align args->minlen for forced allocation alignment
Date: Fri,  5 Jul 2024 16:24:43 +0000
Message-Id: <20240705162450.3481169-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240705162450.3481169-1-john.g.garry@oracle.com>
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b7c22b-33e8-4bc5-80cd-08dc9d0f0e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?aACK1O9w0VwireFIWktnyBcpFfHUXpgK1/XWft7z7e+euhoC6awxl/2MpdDS?=
 =?us-ascii?Q?OvLMqPM1OF0vJT2Ptg4VGsD0vc1KCl3zDTkB0cuyFV6KE+NmIRMKH6mHF6vT?=
 =?us-ascii?Q?CIpall99IK2yInubuEvVffpDrjc6IT3QsB398AD6NeNUVWZaa/e8gme2tSg6?=
 =?us-ascii?Q?rEX+ceNKpX0YTmwe4CGbbYCHBswSwSSIUYkfIMLRurETBk66OY0FliBUIGUv?=
 =?us-ascii?Q?IJ9esCm4e0wbtpN07Ay7r2u/ZKNqnRQxGlE+yNPgIB6+6LEqJYMKz1u8NOHw?=
 =?us-ascii?Q?rO40mRvYx+M+qGVmCpbdSd9MQHRdWZf+E8Ng3RqXSMBbkIlYG2nxLXrzlF6K?=
 =?us-ascii?Q?wCqzt98hXCtZUi1Z+/BxlCgEIBdCG00sSMCECKQEox9t3vWx3KTT94RNn/Gy?=
 =?us-ascii?Q?8WOLjqBDLadleVUTFF6kCZd50NGIwR5Onolrl15cgZGlLlIwfFe4LnCOJdeC?=
 =?us-ascii?Q?T6J0wVOQU5RgAbDOLKUpvosGlVtY/3kopp9UENXToaInZYWLDv6Wl4Gztwmx?=
 =?us-ascii?Q?dDSfwRR+cVNHfshBYLLiaOontszCCKR9Ro+UVp9ftfmWG1j2dZWDqiq3UCAG?=
 =?us-ascii?Q?7YdVJrwD9VrAfcir9qIUkAJmk2e5DuM8hVJgH/ZsOC0tUgpYXH0u1pGm23ty?=
 =?us-ascii?Q?mC3C/5hNa/bcZiyHJf8AePmIzC8knXGIAOY4botvRE2L6EfLhjDBot6zocqL?=
 =?us-ascii?Q?8Wk9/F2LQuH1xTTgeooinMXal2EQAwnomKMQI0nqdRszRVFLbK30pDXYMyC0?=
 =?us-ascii?Q?DeFXJcAjUMllZT9hMZ8W6sXw7k+IIN3mXsgP7aiods8MJhzTfK/Sm5rE1ime?=
 =?us-ascii?Q?zOLUozJjePKq4NUg3ByN7sPKIzYJWjOQIjUzdZAHMQ/5RqvuUewr8Kc6+E+4?=
 =?us-ascii?Q?GSgfcDGLTwDqYuDC7d56dTegGglPuR0z5gnWj7ZkMzasbhw31YM2tf7VFc+9?=
 =?us-ascii?Q?HFUFToKl0poOMeW0MKXT+ziJ5fHWQTPadDiEOtDwg0beazBdEjzMyj45w2X0?=
 =?us-ascii?Q?BPj9IkqO08ORHYRynjihbkW3LoijyAJhCQN3l7tszUbaK5isqbVQ22veSA8v?=
 =?us-ascii?Q?EjyzcUXfDRaGsDIwJTD7UwLH4PFc/PykKPuvHVMLOhz+ts6rVe9l0cMrKjWb?=
 =?us-ascii?Q?ENHOeI/W+wgct/9jmLW+JARuI4CHiNV7uvtn0yd5T6a1wuIza4pjAcaivD3+?=
 =?us-ascii?Q?Q46JkfQY6B0ovaMLNHcaTky7keyFmMdAaUJ2Wztgt7qovTl04AUGouVs0KyM?=
 =?us-ascii?Q?7/6xWoArI+qmRz+PY67zoE+Ajopr0dlv67KD6GC+Ew/6PaeGXqIjh/QvIV91?=
 =?us-ascii?Q?XOm/7ivmEDkoqdUypgb1i9Ms/2a+1yjNDbMMwCTKcIY6yw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nkl5SJBxXpzoe/UW01aG/K1p1VVNgh/ZyTxq0HgdnzrZlM3Vud/lY1e5c2BA?=
 =?us-ascii?Q?TOndSmlXZ3t3UrjiE82PJOcyzprWI1tMqudIQ30/mgQfEmfpYkQ/QwppaDkg?=
 =?us-ascii?Q?5Q2axhFHLPgn9NfGTMnqaL22KYgzQnNZbuaUE3h/03yKUW7dZ8elqjxL2Dlw?=
 =?us-ascii?Q?dWI27eIBU/mmvt7HYMPoS1I6E9RMCttvYnsiIxAujSEJUCyP8DKcl9RrrQbY?=
 =?us-ascii?Q?IIFRqErrnPLnvht27fNgnIaPetnX1hsDhAhxkk/S8YTzSOI0OkmR89gIbc3t?=
 =?us-ascii?Q?IsIUvdEmrIwo7IgGgWEcWnXd+6Sokkz7ioPp8hiI5KdiT6rehzQkbNM6v1eS?=
 =?us-ascii?Q?SmIpfYO+PCQ9hEnR0cAvgp5ewfzZFuXxjOMHDBk0ttwVlMc+M7MhJy1g1BY2?=
 =?us-ascii?Q?AnBxSPU/nKirZ8cpj4n7WhcznIbhRNS68nzopC2xLqC9bFAksZieQlAVO/Dn?=
 =?us-ascii?Q?u4MVPhOACXqJ4ZMmjmMvDzSE3KYsIWEpjkYTQgezf5qaIZ2NGNuxZ53SGx9H?=
 =?us-ascii?Q?x/cSe4l3fxHzKmMzZGzf2BTmegfQnGGN1XS6EBlVgwyKsT2D/l0RbCttj6FF?=
 =?us-ascii?Q?jVQPcGJlaL6bI8v3JYoWUj0gxdCCYoKLyZkOUr8RhREH7dfiMetnxAeb7t3m?=
 =?us-ascii?Q?ScyyTlF8+sza0h9Zvdc3cqqhfrjgGkmX3oo0Ajgl8m4lVydbYmpq3/bU7LIV?=
 =?us-ascii?Q?A3OtaKXJ+Cp0Qm/7WO8njkf17Lfhh15D6WJznPe3EzqeZwYC5soFx9PdSyJY?=
 =?us-ascii?Q?Ult+nS1EaiphAvP/jgb/GRLCBfx2kCy1aRKAfaVVhQDXCh1U2I1MZQDGJ4hs?=
 =?us-ascii?Q?v0A1LzMeAlmESDfI6W5QTmJEuJLtaujy1evUPKDdxvOxXa6WQTNaW2Ddhoh4?=
 =?us-ascii?Q?Rns1hAQ0MKbBL0MnY87GHZdo3cZpVzQ9/bn6ZqnlIa0tF6/BC/LL0oJibbFH?=
 =?us-ascii?Q?K9qQ7QpKVQdCrMPTq+PwEYplQjtg5nzsoxr8POY3/fg5i1PngW706XxDUvTf?=
 =?us-ascii?Q?Fdh5f2R+tC15qrD5JZUqcU8vuMUI1ZXq4bXPUx4le+g9b//HABTXrA2FH2Ce?=
 =?us-ascii?Q?CjAkVl5eyGccu7b07FwTc8Fi0GR3upuWtMcIaAAH4zACZLzsz/UdUyDt2/x9?=
 =?us-ascii?Q?bBZkWn5EpkeTO9P4xkDdP5Do2wugHzaSQXNnJNjhmyCXolmupiCHvjkVIaCa?=
 =?us-ascii?Q?B8VdNFPMMePIaTrRzjPF7lIualVLUQSeSbrvDG3Fs3FyWjhQFP9gMSgPIWTc?=
 =?us-ascii?Q?iubSbCkvKOwuJLmjd7ApYjqwe3byT3TvvEjkFgkFpaqSp8sRByvBycIQn2yn?=
 =?us-ascii?Q?nMgOX7NfN67zHgQly4T2Iz1x2GOAiKWr0pCzVpFuC2SN/BtxfBnWBCPCNnU7?=
 =?us-ascii?Q?h7/5bz5L6r/wlLhay/pQwYDEf2Z/WLHZaao5PfnbYwZVx+8hbJ0NWBbMCLm8?=
 =?us-ascii?Q?26ZxrAJzbn2QwEIhbIn0kAkD/R11vq2QuUgSvwV91SZ+qL/EbfWpL8pU8XM7?=
 =?us-ascii?Q?B3FnJLJ/eLn1vkUGUeubYOIzIRNSHJi155MYt8Tt+/bSrRp0/DelDIBfBHuG?=
 =?us-ascii?Q?ETOAB9afEFtaR/M5YW/kn4rvSY/Emo9HmdLZyK9Vv+83QOe6Zo2NL5OV5cIr?=
 =?us-ascii?Q?pw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	5l+DjQpsWGfqtZRtZwZTuh7blbOTIfognaYBCnN1oeVYMD5lgVOFzaA0gAxYjmP5GIWUYQHvu07ISpMCvDgDuI14l4RU77CTEAArRc1oyN62P+eZ83ZQ/k9H6SSSBXg/9uAV2utTVyllH2F/CmS1nda+HWZQWyntjnhheinWycjljCHWdiMxgER7dzI1RbxSr/8Ko53NwG7HDqLvanj80HcCSncpEX9JWsKof1BDZi+7k/Sy47wpzmbjJKgyrLFyxGUxyP4+XSU835QxDDD85g3RYpakiEBtKzzbOV3yNSjUCwa0Kvb2hj5mB6xC7gbe/i/MisAH7dEOfBLtyVEwOB8CXY/IzNBkzAmBFimwGPbVyXOEPt4ou0SuFu6sm8AcjqZRv6yY/Mv7xKL0HwZ2K48Y4tLx2rcCENJLHw5cDaTzdLRg+hQJjIYyRjmX8+qNeHR9Rger3vvSRUhcWFq9yahNwtsAhtjMxfNWQTLXiHswy6OEdjs/i6cGymKzu4LziQnXC7mZD0ecRiyEw9/Jmea+V2snnatCrJIK1ziPty5DCUZh4m/VfN7Uge5P/EZNFpRuaBAYzKcGb9OPMAMkRC6KDXmQi1JW3PholP513sI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b7c22b-33e8-4bc5-80cd-08dc9d0f0e06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:25:16.5824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ODTENlADFy+O+XaQxpJRy4MrCiLLCJfxshzm0jb3cUoRMsOBspzG6hoyuAZQyZtql4UcNXFd94k+KpCLOOJFnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050119
X-Proofpoint-ORIG-GUID: eOimJv3rlVP_YSoPcMlXua-87UxhR8m7
X-Proofpoint-GUID: eOimJv3rlVP_YSoPcMlXua-87UxhR8m7

From: Dave Chinner <dchinner@redhat.com>

If args->minlen is not aligned to the constraints of forced
alignment, we may do minlen allocations that are not aligned when we
approach ENOSPC. Avoid this by always aligning args->minlen
appropriately. If alignment of minlen results in a value smaller
than the alignment constraint, fail the allocation immediately.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 44 ++++++++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 1cc2d812a6e9..db12f006646a 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3278,32 +3278,48 @@ xfs_bmap_longest_free_extent(
 	return 0;
 }
 
-static xfs_extlen_t
+static int
 xfs_bmap_select_minlen(
 	struct xfs_bmalloca	*ap,
 	struct xfs_alloc_arg	*args,
 	xfs_extlen_t		blen)
 {
-
 	/* Adjust best length for extent start alignment. */
 	if (blen > args->alignment)
 		blen -= args->alignment;
 
 	/*
 	 * Since we used XFS_ALLOC_FLAG_TRYLOCK in _longest_free_extent(), it is
-	 * possible that there is enough contiguous free space for this request.
+	 * possible that there is enough contiguous free space for this request
+	 * even if best length is less that the minimum length we need.
+	 *
+	 * If the best length won't satisfy the maximum length we requested,
+	 * then use it as the minimum length so we get as large an allocation
+	 * as possible.
 	 */
 	if (blen < ap->minlen)
-		return ap->minlen;
+		blen = ap->minlen;
+	else if (blen > args->maxlen)
+		blen = args->maxlen;
 
 	/*
-	 * If the best seen length is less than the request length,
-	 * use the best as the minimum, otherwise we've got the maxlen we
-	 * were asked for.
+	 * If we have alignment constraints, round the minlen down to match the
+	 * constraint so that alignment will be attempted. This may reduce the
+	 * allocation to smaller than was requested, so clamp the minimum to
+	 * ap->minlen to allow unaligned allocation to succeed. If we are forced
+	 * to align the allocation, return ENOSPC at this point because we don't
+	 * have enough contiguous free space to guarantee aligned allocation.
 	 */
-	if (blen < args->maxlen)
-		return blen;
-	return args->maxlen;
+	if (args->alignment > 1) {
+		blen = rounddown(blen, args->alignment);
+		if (blen < ap->minlen) {
+			if (args->datatype & XFS_ALLOC_FORCEALIGN)
+				return -ENOSPC;
+			blen = ap->minlen;
+		}
+	}
+	args->minlen = blen;
+	return 0;
 }
 
 static int
@@ -3339,8 +3355,7 @@ xfs_bmap_btalloc_select_lengths(
 	if (pag)
 		xfs_perag_rele(pag);
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
-	return error;
+	return xfs_bmap_select_minlen(ap, args, blen);
 }
 
 /* Update all inode and quota accounting for the allocation we just did. */
@@ -3660,7 +3675,10 @@ xfs_bmap_btalloc_filestreams(
 		goto out_low_space;
 	}
 
-	args->minlen = xfs_bmap_select_minlen(ap, args, blen);
+	error = xfs_bmap_select_minlen(ap, args, blen);
+	if (error)
+		goto out_low_space;
+
 	if (ap->aeof && ap->offset)
 		error = xfs_bmap_btalloc_at_eof(ap, args);
 
-- 
2.31.1


