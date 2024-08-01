Return-Path: <linux-fsdevel+bounces-24807-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C36E94509F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 18:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EEC51C22FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 16:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5B1B9B24;
	Thu,  1 Aug 2024 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VGwklavn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UD86mU1F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20981EB496;
	Thu,  1 Aug 2024 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529918; cv=fail; b=QAfw9YvVVnwoHovmniR7+AL3CclfHdJspHpuuC0pbG3xgtXDmhKdUc+RIGVrGqVfkzJ1suOJDagpyIZF5B0iS/VXb23jo1acnrs0y79Esr+qPtDVBi5Evl4eNoHewCxi8AHAS7F4owE4xB0LU/0cocK8A0v7QmAUDA9r5X/3IwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529918; c=relaxed/simple;
	bh=3d0NAqismK1oHxyZsbPGHkoTG01Z3JS438mo/jksfq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufC3gvDtnZ7qZbQEdHvP7CcxhI9sQ84vvi7dh6Q6vxd1MVVq6PaalCEJp+H79L9GetK6j1IbDiqV0htuNWECyP2qnsEqroHP0B7FMNSR1FPKwKdu7QTeuTdR9gMW5lsYtOQxSt9RsXdeOXqJCm57moIYlp70AKjMJUjgUdng2Qk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VGwklavn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UD86mU1F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471FtXPZ011506;
	Thu, 1 Aug 2024 16:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=DVAFJDnrzrSAvCrZzveWH0484OJH9pv30i1p8PpGPbw=; b=
	VGwklavn8Zwr6ahg2NOnjKPb4WoUnhEUjWVAMY9fZyHpCaLvZXJnnPghrdklpFii
	BVB76Nd7DKKGlynvlyZga+X3Sr/Yy6nIjqfgbSuOUxp7XZrkqLhjX0dx3e4Qb6vc
	GuOM5MT179bUfvGw7LS9VdiM/CQoopAs/jj40FLYAIcIUQZNwVRgiUQVPQTEVVYY
	JrpLpWiwZZWOu5qKXWjBPKWy7GUt7m3Hx8IAKP1DZW9zi3nMeuWwRKavCNv3Av6U
	S8JdpWyeMw1GGpbdPQEEmtdtwyzY9WxOZioJ+DqYo3/d2hE2fxCm2dtHuTGhkSR8
	hk5tDOR5hB+7oC970CcdIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqact5fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 471G4CBp029016;
	Thu, 1 Aug 2024 16:31:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40qmpt8g7u-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 16:31:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dr2GvMzi/hcer/VcIE7U3vTHWMMbWh7dauz3jB37oIy9EY5bVocvo0ah6Qcja36LgXi0Z1/1IWwvj437goAEWFb5WLe26GJnV+HpMTToT/nKn+JdI94G4FSW8sSL59DuWldO81PoTOskJMv/XMOq0MU9LaPGDQFdo5/VohM2iExVbDGif0OWx25VABTpKHoIJYMnSaYAakSqkJFhXW6bsKb/uCmih9mRUb5uaawaPy4K4297eCgLNqQrL4CHB83NxcaAsL8DrAIcBJwctcXrjO0O9grZhfwv758aMy5cPAMEeRqiBBqrvXAUw0NKjT5QsrpaUPfVAxBo9L6y7lgaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVAFJDnrzrSAvCrZzveWH0484OJH9pv30i1p8PpGPbw=;
 b=b2MkzZeYIarNZq0L8in5fw069H5WesRboEgkGxdkpEC06oo7GHXV48OR1OfEzk72mDL3wHKUgp2ap6zqpVcnBgUdM5eDLt+ugT4P9XTEhDuihRjDHpAxGvEPYbW3A4wPj+CdtvYxxbnwW2R3IpTsgp40uwLktlUjR+wCSOMvEFibKXN398RlPUQ5YR/q0K9TlZkph1N+xa9II5nOkErGb2Yr9+5rQwOQ8gRQnJkoAauIRifo2jEeLG1LMRUK3TyDIXSMyxDOaCFO3lBGexWNEcHdoMLJocPEUDMV9AAh1714JYNC/4Lq1raYYMS+5hIZoHAYMRtNJ6NZKecBD6MnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DVAFJDnrzrSAvCrZzveWH0484OJH9pv30i1p8PpGPbw=;
 b=UD86mU1F76SOW2YDEkPatRtG0Ptb0opLFCbxLOjp6neH8a+2SRa+cUCUtmMVmxPHfiLdjlvs6vL08qaAWFRK5MELXXAHBXTzISu3VYWHHKnqAd18krXO46Bzun8u/bwXXwXXNxGVFLbbidxuWg8CVP6KZ4utgUH9t8fTP9jc//E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6081.namprd10.prod.outlook.com (2603:10b6:510:1fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:31:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.7828.021; Thu, 1 Aug 2024
 16:31:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 01/14] xfs: only allow minlen allocations when near ENOSPC
Date: Thu,  1 Aug 2024 16:30:44 +0000
Message-Id: <20240801163057.3981192-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240801163057.3981192-1-john.g.garry@oracle.com>
References: <20240801163057.3981192-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:208:32f::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6081:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ca4426-8c41-461a-324d-08dcb24769ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rTxZTz/hOppwnVUXV+Ks0+er82EfeEGz3R3J6PI3IYcKyOb6qBtBoX0mwayh?=
 =?us-ascii?Q?AKmed06YllXY1KQqVQfWqkMb0Klw/xLlIv8wAlNW0X1Pgfz30UBIsM7LPKhC?=
 =?us-ascii?Q?VXVg34PFkq1GmifwZFyEjvi1M2yN+15oG355MWoEPP6k660kZ4F3sgfh4Ygj?=
 =?us-ascii?Q?DY+LwabdLUyABp2P6GrlP223cQ3EstsJDXiPaHzOpiGDE6gi31smvwO1iSMv?=
 =?us-ascii?Q?y0J9VF+6V1kt+N5nEnD2oR7pfVltRdapyQVijQLX7RJCq99+IB8HAUV2LSmr?=
 =?us-ascii?Q?8vT968D3RovyJHNbVwzdVz2lLYyKzf02DV+vI18yvPA4ioZVh7p3zCazAfrV?=
 =?us-ascii?Q?CroHmbuvWS4gJ0ylwma21rb8sd5rEZHA6UFRo68lNv8myyqb0yTRcdxiPDuY?=
 =?us-ascii?Q?Uu2KX5XX5+qPkzEMUgp8QS3fAKbX5Pb5D9+YTrMTsdVqu5cWN6Nn/raTOLfe?=
 =?us-ascii?Q?bO7tP8tafL+7j3Z8ygA+rlCD9Zpj33DKw+b5eGy+xieGZ8gCWjUJI1EgSOHb?=
 =?us-ascii?Q?euTZTK1BT7SryTBvg8NSz/S7jPRvHOOW7Mw/GG08c8sDAujt6B5aaL9Rr6YE?=
 =?us-ascii?Q?qmB4Uqj0+ehVpEOkjxuLWLLOM8Srz0lgCX8PnIgt4tUivaj+6hxW2sYjSzCk?=
 =?us-ascii?Q?a3YSWk6sMnhGBn0eVj5Vjaugm4f/+hb8CqgJAYR9cgLnWE5sK7FoZwyQoMS7?=
 =?us-ascii?Q?XQ0GBo5WuoBM7oZEOWl/QBmcxlDqPpJth2+Bw9+dhY7KIuxUvRXYlexYXXsP?=
 =?us-ascii?Q?VauYxLm7kPMgO7d83NjcfmQMNDZ5B/fMiOhqzaZ+sRk6Hid+Pgam2eDFHN1o?=
 =?us-ascii?Q?iFZ7mdFwS1pDKWNAUCzdtDYjZpaq4Fm4SvGY4ddrS3QqwjsvWr4ox7+EXU0G?=
 =?us-ascii?Q?HThnWR3SFkI9VNHm3AMlcCZE1JGMDzZRmC7jU8aLHcleEBDexBZ0+SLHzc0D?=
 =?us-ascii?Q?/tVKZXDrb5xPZk3qJO5Upi3vSpBPl6UIcTSCmNeIpNS7b6ximAwBh20nWaD8?=
 =?us-ascii?Q?sAjNvW7gwN/ah8mYLRqcyrnOTbV+/5KvRRyjIUmwzGSRoX5BM2NkhE7VwvRN?=
 =?us-ascii?Q?N47L1FBtAiirWWYJY8gto2APDDqLBpaRmjrdOb5dcmvkvyTV1JSIUWLMl/Wy?=
 =?us-ascii?Q?8raYBQeO5gyXCcC/dvuihE4VbbpbxYDQdcyDJJItkC8anc9c//IUls9FWFnN?=
 =?us-ascii?Q?Rz8FEaxI2x7/UrFn+D1r5oqgrxCtufCVRL14cn2tnKvzd9VodFUZ0fkpKw2V?=
 =?us-ascii?Q?0Sl/dSHdg33Pe9x/dFT16/6pJJGJk2pz/IRQLtEJVZZD88sq8I+i2UZ1aW7L?=
 =?us-ascii?Q?MnnGwX9m/engAMk6OGwi9kQH6LLAHXZ+Ek2Va8sIzYAaIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NRp2SZGYQgne7GTgUG+0ZnoErWZLzG6woKyMn7BfD9jmpNSTgtY9RIi4xCdr?=
 =?us-ascii?Q?BolUeWs7iUobEFztalIfhoCL48ZzkqB3NuSxURTfI3240eOf2OWggHxONuEP?=
 =?us-ascii?Q?D3QbCaGQXnKZ5KN3rDRwC4kOg8pgVQ4I/PhtxT/rXHgmrZzvC9DiPBVBB9kK?=
 =?us-ascii?Q?qLye8LbkDPX7U3UbxRiicS2dvGlbnbZ4dRvtruBHebvY6+/Oy80RKUqmeDzD?=
 =?us-ascii?Q?+GJ8fwQuhip3gBCi0IptKES531ylEAWe/HyzkcWA8ux47xHhx+MIPkd1nGcR?=
 =?us-ascii?Q?H6PzUekd4uKFcFvFjJdvoXGg/ujcBdQpS0teRSSO8xIbvoINKjie3zy/Q1cO?=
 =?us-ascii?Q?H2qV04M6vrrRb/Uizh1KqyitE3RUvibhY0qrYX4ZlfI0gij+52556dM+Mncm?=
 =?us-ascii?Q?75WOmbjaMz54I2LsPzDnHNOWLB9/l1snk08LNji1x6nxUqX5CTyxIohq3LSv?=
 =?us-ascii?Q?qQwue/3vk4jHMFCCz3bUCETIRs9XODa1uYeRNShD+NrdAxmJ2apr/W0wKnVb?=
 =?us-ascii?Q?bPOeY8fx1/y9Jlp6tznytUz7j++O/1inaRFEoKAKcwpu6bNDdLFTSwBDA+Fv?=
 =?us-ascii?Q?Pax0opz76Pp7swzb2BwRfrK9K5mYfdn8ELt0NuaRGsfqqD52BZg2aBkXB2po?=
 =?us-ascii?Q?HdxBUYrNn048jfoMmK1NijzKotFe2n2/NNT1YmFk7xrmZAPMH/tNRbZMFy9t?=
 =?us-ascii?Q?FtOoLobNxmR7r5oRRynwMGSrtzCs2ree9kofRkUj0eeGr6r+NY0zWaIDLCXH?=
 =?us-ascii?Q?Ijo1IrL8CX9OdeAakTY69FpSyqnSRiK+u1JMKZHdiqXZmCivgd1rteY5bgR3?=
 =?us-ascii?Q?ljk9/0EDUNUtkg7/b67epf1YoEb4lNC6XNcKyFD3JGD4M1MafPU6Mw8Cp+gJ?=
 =?us-ascii?Q?bSi5pfNtQr/1s9a+CMYiYTezvpF4w7XG2lIvgxQ/NPPI5bY1UEsPXYJa42iy?=
 =?us-ascii?Q?nycXn5OkeoEm3IKOkoruwviHqXr7l9N+jc4BGRYkWkS1OthK8atFlUma0o4O?=
 =?us-ascii?Q?lfmaUZMgm7tsACENASSegL7Egr6JuikpFksH5ZH4E4uN4HGCvVrj0HfGUrTT?=
 =?us-ascii?Q?Crq+KGur3V7Km0qU183EtIyOGm82vlzwNLlVIjbT5ZKwdI6vM1m0z4rRXm0q?=
 =?us-ascii?Q?5VPPC2VMM2Qk2uf440cot1hz5DPgXdGMUazf+Ldm3WQqakEooW3UPi74U1ib?=
 =?us-ascii?Q?C2LI/3RauJ5HLOIe9vQJhAnCbqNoB4GpPQXwlEPq9Uovzsx4yNrgoE96hsMH?=
 =?us-ascii?Q?8zpGSCFNSe856wHSJvHE1EnnghlqFnoRlZd+CCcwwK8fbb9Ld/K5kabMrVkW?=
 =?us-ascii?Q?Onkapa2doEjXkTFSoYlOJPrMzXEJWpg2uY4HD5zbYo9VlxPNFpS0AhTt+tIO?=
 =?us-ascii?Q?q9ARQtBM9asKOJS2l3cf6xn4T6dAfp1PVkmntArFOvggeO5JLsE23xl7LUm+?=
 =?us-ascii?Q?N7Gmz1nXUbnAHEVARSfcmiLWhRdPFh+zR3ygs7xTVcKTcoDhYSrSDcW3FGkn?=
 =?us-ascii?Q?2qBKt1DFalUWtstO6fPP9zvYAGdwj3RkVoUvc7fPqmiqsjRZEp0zpKaduQLm?=
 =?us-ascii?Q?W6fNg85z9d4DXe/+Dz6DAb7H7g7s4ZXW0QxO+T55w5hp4y9b/5rB/GFGoRqT?=
 =?us-ascii?Q?ug=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Pui7xhxCGqCqLiLWxciLGqPxThGOHaUPb4vqzqYUU8LT8GaXjHXYphOnMzkTh6JWLjB/jZABc9dMSw9HnbMbsadu/nw5C8t5MWk9l10Z5oqfUlolg6dpPyKiqz+ArzX9rOrkbplAukt9BREPaA/sX+/1C5jEkEEEnKDtti46YCGnc9cbN4bdwRy9O2mLLKQJtXa26hj29zpixdMzHNRitcjwMfThvv6ktgZzhR/IIorUSnAKoMNusUupBWStY54ABaytF5tP8p4UldxqWh/sxQU0n24Q4sQZPCcC7wzFpdu+vM+fg3VsYEeHyPcKNRe81mX26adVqkjkv5nS+Pgt5UnGzaLc9VTAnvZmB7e2YSlyrF2ozGjjZYkcZJ/6K1rtlBmpxw8I46+IXhA3ERkhdbt10RNHYXtrwO6eG18s+d7/dRjhfjzn5LA1kjTVYwhxOz0KkL/7Fzm8J8Uz8YAw5CTnUKbgQnh0j8+v02B2yikZ4aWVn+WjdSj+JefUY1X/5bD3IWkmkdw8vMkU5DjCGG4pdlvPGcwAi63K0kLQLXou5DQEdoGMi++lWonmWIt/fUWBj6WqSrg0PYWazA9BxtruKK3xwoyiu2/lYiSmyv8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ca4426-8c41-461a-324d-08dcb24769ae
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:31:36.6820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC4jQCzrNe6wGfEBCCGs+YYn/BoZcr3I7gpUKAbmvov+jIvn0pQmSAeTX5ODPpOlK+FADdeoZe7tc5wU5b/nqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_15,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010108
X-Proofpoint-ORIG-GUID: ie_dUltIEFf1ZQKZqMFESsH0v-gzyJch
X-Proofpoint-GUID: ie_dUltIEFf1ZQKZqMFESsH0v-gzyJch

From: Dave Chinner <dchinner@redhat.com>

When we are near ENOSPC and don't have enough free
space for an args->maxlen allocation, xfs_alloc_space_available()
will trim args->maxlen to equal the available space. However, this
function has only checked that there is enough contiguous free space
for an aligned args->minlen allocation to succeed. Hence there is no
guarantee that an args->maxlen allocation will succeed, nor that the
available space will allow for correct alignment of an args->maxlen
allocation.

Further, by trimming args->maxlen arbitrarily, it breaks an
assumption made in xfs_alloc_fix_len() that if the caller wants
aligned allocation, then args->maxlen will be set to an aligned
value. It then skips the tail alignment and so we end up with
extents that aren't aligned to extent size hint boundaries as we
approach ENOSPC.

To avoid this problem, don't reduce args->maxlen by some random,
arbitrary amount. If args->maxlen is too large for the available
space, reduce the allocation to a minlen allocation as we know we
have contiguous free space available for this to succeed and always
be correctly aligned.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 59326f84f6a5..d559d992c6ef 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -2524,14 +2524,23 @@ xfs_alloc_space_available(
 	if (available < (int)max(args->total, alloc_len))
 		return false;
 
+	if (flags & XFS_ALLOC_FLAG_CHECK)
+		return true;
+
 	/*
-	 * Clamp maxlen to the amount of free space available for the actual
-	 * extent allocation.
+	 * If we can't do a maxlen allocation, then we must reduce the size of
+	 * the allocation to match the available free space. We know how big
+	 * the largest contiguous free space we can allocate is, so that's our
+	 * upper bound. However, we don't exaclty know what alignment/size
+	 * constraints have been placed on the allocation, so we can't
+	 * arbitrarily select some new max size. Hence make this a minlen
+	 * allocation as we know that will definitely succeed and match the
+	 * callers alignment constraints.
 	 */
-	if (available < (int)args->maxlen && !(flags & XFS_ALLOC_FLAG_CHECK)) {
-		args->maxlen = available;
+	alloc_len = args->maxlen + (args->alignment - 1) + args->minalignslop;
+	if (longest < alloc_len) {
+		args->maxlen = args->minlen;
 		ASSERT(args->maxlen > 0);
-		ASSERT(args->maxlen >= args->minlen);
 	}
 
 	return true;
-- 
2.31.1


