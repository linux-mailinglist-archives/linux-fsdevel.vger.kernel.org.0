Return-Path: <linux-fsdevel+bounces-51535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 477D1AD808E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 03:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FEAF3B56BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 01:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E2B1E1E16;
	Fri, 13 Jun 2025 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gx7q4SFm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qi5vfJrV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9927D1E1E19;
	Fri, 13 Jun 2025 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779521; cv=fail; b=XnpgB0sCwoez/KEe1QUPQuBwLrUVVfyFpuA3qnV2IFt95zvwQPMYc6DUNSCngAao+f6T/3N9zBvvinqV4C8oZtXYnDihGrLm2yohp6Ho3UDelBK2ypD3OYx/wbURQfmjJJuWwTb4XSb3mDE2tQg1smZdhEEi4xtFiWI6QZ4RkQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779521; c=relaxed/simple;
	bh=s7+gj/DFE6ZC6mZcS8Ix120qs0cxfA6vN6FSAiQxXIg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=MRvNjDuIon2AQ5mZaK3RFOAiOd9BrdBUGdRbL8RrHcwSQKNylOx2JdQe0TkMY6awAC8ZmPUz7Z3GeBbCqrXyQVNu+43s1UWO4ng1AEvvTaWPOd6TMTiy2isbGHYgXwb0TIGAyi6sBKi7pCqHzK9sD3DdjK8sCT6Oi9Y6y5Tj70s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gx7q4SFm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qi5vfJrV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55CMCE9Q006182;
	Fri, 13 Jun 2025 01:51:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Dk/ALYYV9JApK8rX6j
	tTDhCEha8btmDqVquQMSuIOyQ=; b=gx7q4SFmp8pl8Tmo+6yAau2hBQLhFHxsWa
	xoSiwvu0Cg5YCBnJ3du3d8u2MWuOsa76Sf8Mif+yACGutmgORWjjgd9OIzFwaU0F
	nmBKzUwTZnTrw6m/PEljN5Gkiu1sS6f6dKEK8Ta573GNxjqLObuA//JMRtA8M8rr
	6jcXtzDkolOaP8aTF0fhLjb62VfhZ+7qYN7Oz+lPRbntjmKaB2fQXKRxNuqTR9dt
	y66OLXw8aotKbx4P6gPULYaqDFOS3znJe+/smRRdKFwD5VTsw8rp1EZ+tFIoVbJy
	uKx3/nouJC9/gXDZcEiigjzsFGZotCo4qMlB7POVFgYcBTNr7wVQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx2vmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 01:51:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55D0SuX3009270;
	Fri, 13 Jun 2025 01:51:41 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013031.outbound.protection.outlook.com [40.107.201.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvd1vgs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 01:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgpIgv9wO7F3RicLnFAaztHfUE9Co+InvnbhOmKxf1dHh9DCFecK9DuRz+TntsArhfeaJFXYxkUR0QXj2CIUzbuuZv46uIQkUWmpUhq5XkVlNlABeWlnFstxbFdT90yoheh3j7r0Wm9tKNPfxICyIjiYvbem+EHZslW6MFRHSxHyniE5Ie+ggdyMuYRuOUbnoQqZjiSyN9vcjsfFIPgHrgoYxGMPu8Iub8RyvCD61GQqQ7LDiA7XATvSJ6UZxTa4bsiM6viL3rOVnJ+H4gWmBNYe67vNkTtU8bqhyeyKHNv7kBBBBJcvOnHDLq+CmMPw8RUSqCw8B2zfoexXtNarWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dk/ALYYV9JApK8rX6jtTDhCEha8btmDqVquQMSuIOyQ=;
 b=UG+mlUtfskZ49kdfalR+SO9fILTzoVPH+GIf7EBlHYQzPpl02PTHVO8DmqRX0rI6BFXl4EpYUzdigygDps/4H8qZV5taCXD1SNF+E6cprVL4L06LGTAWiHLZMAmPQtEWy4HoBy4q4i9Zg1Ri8pZMH0UGGxUTEyYtBpjvl8Tv8KXgHkosTmrH6ByzalpMWlJPtYQ/T11alxkuD1RYq0hTWHm2drSQwTUwhuA2LHMC0zzZECphgGfFIavucbpRQEBFNifejiq1yyT1FVNALS1yAMiumOe5UlBfudriG5g7bE0D3IKBYR/rBkNXTVLXeIHQB5YGiOC9iHSYqgIkj5l2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dk/ALYYV9JApK8rX6jtTDhCEha8btmDqVquQMSuIOyQ=;
 b=Qi5vfJrVL4QZrsuhakwmGi1iZZZRDBOn5mBEfbXA+g/nuYL+eTaguJoOApgvXmxEDi03MbYzE7FnNidDplCbBIsvCCanQvujaqZBUX3CWngPzf/zISd3bRmSinPr2u1cl/oiXZQJA9Qz+M6DLBAYhxwFlq7+h9HtAR5gtAIuL5k=
Received: from DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) by
 SA1PR10MB6448.namprd10.prod.outlook.com (2603:10b6:806:29e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.22; Fri, 13 Jun
 2025 01:51:38 +0000
Received: from DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::b527:ca1f:1129:a680]) by DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::b527:ca1f:1129:a680%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 01:51:38 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
        adilger@dilger.ca, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
        Christoph Hellwig
 <hch@lst.de>
Subject: Re: [PATCH for-next v3 1/2] block: introduce pi_size field in
 blk_integrity
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250610132254.6152-2-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Tue, 10 Jun 2025 18:52:53 +0530")
Organization: Oracle Corporation
Message-ID: <yq1jz5g2z3u.fsf@ca-mkp.ca.oracle.com>
References: <20250610132254.6152-1-anuj20.g@samsung.com>
	<CGME20250610132312epcas5p20cdd1a3119df8ffc68770f06745e8481@epcas5p2.samsung.com>
	<20250610132254.6152-2-anuj20.g@samsung.com>
Date: Thu, 12 Jun 2025 21:51:35 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::22) To DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_|SA1PR10MB6448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e96b1d1-07fe-462f-bfd3-08ddaa1cd5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7uWLFbVWmRz4DiSwOLCfodV9bs37blq3LmeVO0r8IhxKPdDs9gkas2k3O+np?=
 =?us-ascii?Q?N1jILHQXAVxhpbKDcUpqVfuvZz7V1x9K03IpEqVxsLV5bzfQKuVv6N1Hshg4?=
 =?us-ascii?Q?21dFLXXFGGnBB87iyl3tmjV1x+U8FdDl2CuLWV+YcmU2hRuRarXessCGYbjn?=
 =?us-ascii?Q?1f8r46WR8E0RLP8gYT7q0CD2YJtopmGOiCWTiSJ1pCr1SP4woT6iVY5Iaxva?=
 =?us-ascii?Q?lXF4ESFbtlVZkvpEAcrCWEE+snPFF/5hogvWy4T+CqT1l7iL2TC8AgQEjsj/?=
 =?us-ascii?Q?i4mrA2wACL6roalWcYs9sxCDs3LmVcUrtjXaq9nVGi0KXuSdQzgU942FUUYM?=
 =?us-ascii?Q?I5/m4HxWI3GdSzZn0725Xhi1j6M6MMrES7o1iKs9G1oNpQwRBUPjaNcEZD5B?=
 =?us-ascii?Q?GkJ1jnJrDeNa25h53z2W3pUZ79p7AQC4k2U6lOnYEOugo+eknqWoJZCXuziM?=
 =?us-ascii?Q?UuUAAAR2GISjDMXMzMhTstQIbb29EfISK5c7Xd/YcVHJP/e1PF8B/x6NMwX5?=
 =?us-ascii?Q?f0iod2L6O2QDJOPtYMI0Amz/FUpkBVx0p78chLGWsw8DgEJkX6US8nWmt76d?=
 =?us-ascii?Q?NwXShZO/DEcs6S3hI26MkJHgihEYWYXr1dL1rpq7Zna5tS7ZUMbdZGRU2Owc?=
 =?us-ascii?Q?7xglV5GbVWUMFq40iSmXfNLf3IhfkrS9iny7G5Y5LRvCLgNQv8ELWYbcwSkf?=
 =?us-ascii?Q?sDgg8mEQ9BUlCtZ6ikLm1jqJJ042+8Xd9e7Dn2doQUPonZaSMMFXV2gN33xY?=
 =?us-ascii?Q?eC7QRAUGjFBE5ZYeLXGI0x6QM/TpOvMcbxt7/SnmJ/EHw43EqEVX9F3iBsQm?=
 =?us-ascii?Q?W2DBdAEbNeG19inPAswzIXPmx8Bof9Nyhgdtskyj/NLYup2ai+R7NSG+wm+5?=
 =?us-ascii?Q?cJjUdO1GFFtBwMpqjnnlTSOhHmj1/D2zFDJQnLPf26XSYN8CxdfuTqM/CFud?=
 =?us-ascii?Q?g4caJCK8JwO3WkGDdpKV8ffknkHf6xWdkLUDmPD7EIoUkbSy7Ylgq8RXyG3T?=
 =?us-ascii?Q?aIfBbydMe+FrP35JojRtjPnQRQ/B1Af7tSKMWIty4oUOTHk7oFJ4b2swpU3i?=
 =?us-ascii?Q?bbtVl3LBWrKBL1TvU6QphUkTVJi2W97zzPKNtphGTVqfiQAbqNlwom03tjrk?=
 =?us-ascii?Q?30AB4cAjx2UuGtcNJU2kzCjUZRZpesAyF4fW3jAL8Ac1U4nvhLRvPRTOCuK+?=
 =?us-ascii?Q?EJSIsgOsOvn64KVK4Jpzz2mqDk+by9LGWRziBP/LaL73+dYYQ1cQaGzki08S?=
 =?us-ascii?Q?RaSM+7jziJ/Lnk9Ufdtg0vmtGNgiSDa9txoTtnZMojI+MMQWgjcJgs3UkqHt?=
 =?us-ascii?Q?gy5xWwbouy+T0ypTFgJ6vjhQUzTYAhTXZXad7XeoHgP0FdCs7xoyQHojp6Bf?=
 =?us-ascii?Q?x5Co9qjQeTEZ1xxtgsQ0U6IdtRdJxbVivDLQU4+8jr9XDNZqpfZDjV3dBMLs?=
 =?us-ascii?Q?96NoSDQ2M5Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YfMhz4EZFtpDEhahQIMDdvA8x8Sm2WRvHHOkg3r4n3tHixO+Wia4Fk6bD2CI?=
 =?us-ascii?Q?W7tXUkZqsavgv9V0fo64edpo6pd4nTMOICl4rHpH26QX5oWoHylncxk40Fxm?=
 =?us-ascii?Q?+n4yhE+IumaMt8yIxcik9+GqWAPD4b7a8FIVn7i41oFcERx54kyFE5ZgeTjn?=
 =?us-ascii?Q?mF7n0C2BtIYIjqQzDmwIxqGPeUe+Uj7M8Eg3YhvRwMs4fXV7xS8r/16HZS7b?=
 =?us-ascii?Q?bfCYyFcvk2D6LOrskfnNAJlxQm8VoXg9IwzYsM0XZ26u+eiW4TbXDAZ+uXTL?=
 =?us-ascii?Q?Evp4hSMC5UkkIKhtQjPhzRyAfgO58NJ0cHOpXhB0TP/CrCdIoRJosHk9EmVL?=
 =?us-ascii?Q?wUXK1jiq6gZDRKpfjkc4/uytvFMR2v5cavzNR3BrWvVuQ8e30hUckN6yhvry?=
 =?us-ascii?Q?C9FGK1qBG9mn3PV/Yb2RSvSlyJI9jz3DBKZLrhdpeAFFsaXtEez99Vz/0hB4?=
 =?us-ascii?Q?7RvrEunHmc3v4A02ipFY3HLqpsOFJMxPV7xnEeWLVS74iM0dIzrygRDC1cUo?=
 =?us-ascii?Q?zJlVVaQ8z1+nCI49aVUff4kk4SixybJ+gp9s98g1pWyhrF9uaVjHoy3/LmOz?=
 =?us-ascii?Q?YaeZbupAJuRG1Og3zrGPnIX6z9JA6HZ8EnwlFZW7rRH6jyZvLiSnIPRn9cCD?=
 =?us-ascii?Q?xYIirqO5WuLmGPsxGkEFy/eR5L+OEGOE3RCTtGgnUM8CAJVBYKKuQpkU87jT?=
 =?us-ascii?Q?S1J97SzVzIAnTUsvgm+9vMtjYP7VJ7eAVehJzhDGLPriAHVkEzvwEyLhV2a9?=
 =?us-ascii?Q?5qOEliUncm+G3r/gVPbbebPs38ASTmYgfLqlLhZC7TbakLT+FicgXyP1RHxj?=
 =?us-ascii?Q?9yHR5LgpDM2ArvDQcaZyYFhcWFbdCkxbqTAPZhBk4Uq8OnVhB39L6HpdOnHT?=
 =?us-ascii?Q?fkGdXUyp0sfmoKtxQ3ngfRmKlMlqGjRq0tzxiVI2ZbSbsI1xtiD6Yfi23V92?=
 =?us-ascii?Q?yCnN6pwzWM0kzywoue6LxaRzq8sBG9Xi3TloG186U3ItflTmG56A94rVkmOF?=
 =?us-ascii?Q?u6xMLiv0WLjw+jPSb/ghKd5cMJ95QHSJ8utL1ghZVswo+FEMGYXp1Rksc5LI?=
 =?us-ascii?Q?TXns4sSGbgS/ROrkcKnXSV+nzvliz7nlZmcgnfzCiYHkB+eegERiiNn0Bofl?=
 =?us-ascii?Q?29T4gWjCTJKeC+IZotrimRmzNXP4WfqkIrguaTomeHbZyErzfgKhNqjZOrZB?=
 =?us-ascii?Q?vOlsxu0u5HgL3sCTt70uoi7KkKdlvkQhRV+1lU6nUW1EjIywJLEGvFteRhhy?=
 =?us-ascii?Q?9wq1YcXbgegXknDasc2yrRdcY4vlNwDVOcXnCfr1v0FREfDfRVBW1sC4nO2/?=
 =?us-ascii?Q?ajqnqu4D3msHh6biewuD3ZWnRdTZy1mUaEvu5YhCbTD8xA1/Ulq0KNk7XRr6?=
 =?us-ascii?Q?2WcTjKEDc3s+M2ahrn6F3TPxkQ25epYMMV+z+TCvvgR3bqQ6HX9hY5pzcYlP?=
 =?us-ascii?Q?/UyljNlamzkr2B8bRt/0MwsZb9UXYY7eQgJ1gm6U9xHNceiWGjznNnfNtG26?=
 =?us-ascii?Q?vPWLjkw2Oc47NE+9ci+GMvEfqBOlBIurgnk+6UK39RXOBgFwBXwtE/IuneZ7?=
 =?us-ascii?Q?z/E31R/FAebYOx8zsAEdHyyvBcPg2fxj6igzaxBnbTjcRtS/4KzvPVjDYqSd?=
 =?us-ascii?Q?HQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dNuRKebnNChIuDQawsjA1Cm8bmoT963SNbwZETL8C5ixjITyh7kAFHP9lrzy1QGFc13XdnlDJxxzK575tvDEz7MufQAH8JpD/gOzjyxLopUv1JEvWq0UmT0o8G4OhVnSRYe4JlzS8yhMXOwDb2a0Isu29RTiL3GhkZQT/L1krj37nIpPVwFkVZzzMjOswQO+bLwTcyavgVj6ONhGGxBJFFLN5ZtRF0y5zg4+NFJMrN2P7/ZRyeyFyJq6QJ0noC//a3slzHV2OpWoh4PUj1ilJa5cFshYTTQ3FiD/Im4FSPUf3zjLoXap65oSJ01kbrL6tZm/Hzs0/VzAzPjrbLU1UklSbLTRS1BafFm/6d/nL9JCntC1NwueIkpiREytUU8nHySSmvUohaUrjTv27gpeooKRvHRiC+bYAUUo6lu97ARH3yq0jAQzkifmmH9Qk8ZOJawf0QQUydt76jmG3uOHpIcQXrz9CIELLPHIUbxpyHKRQU+Pzx3+S4OMQ/EaNKrDAX8asgkjP0m/Rb5BYMXZ0CPILz6mxUrx93IqI6rchPYtnOowt5iiAaLJDt9eYs1dGSqZT/DALSGUx1+yVEyE/TyN85GI5FmIk+bUnaTMEec=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e96b1d1-07fe-462f-bfd3-08ddaa1cd5b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 01:51:37.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TuxtkHuy62VAHCBs5fCB+0RuNeVtZh7HsH/SilzfY6MBuVFGsYTUCBiCYWqh2yedp99HI/Ft6GJg4/SV/E/nimvd3N0VtBGIoemYo5sgVE4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6448
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=897 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130013
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684b842e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=H6_HBJHk608_68Q0peMA:9 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: LUzcp1alU8QjN1d7kAI5OhNlEItJbWN8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDAxMyBTYWx0ZWRfXxbdW/+zlRzxs HnG0mGi89ZAGiln7Rbw1/UB7hzBJQQExDdMRqftRYOrcSLHSKTTopjugpJ/dKhzHC10XrRdXcDL gc2th+wIHJPApQC5tyyIlWKzRJMYj6q3xmbc5jdl6RjlxCYIE233h/hufq3Mp5nE9jDBmY2SRxe
 PBLhXZw5uWP9jZgvaNT7gffDvMMTmZXIAXPlmoZzT/28iloQA1iFvx8jWFBDNHo5BkS/t1NBpac ODCgnZ9/jakqsL1DovePNSOOj1Ck/yOYGkI0mqHyuQ6sChwlAOAy3uTvPAzQNajqTG+SGJVvJp4 agynSPTt09a/D1+H5wA3gKi23cUI4uZoj8vtoisvV4n7f5RluARRaWnHJOcDdm2R2XNzX+XiMFn
 D+PMJbA1g+1/iqOMIB61EwWP9GbppCRh8H5BLv8x4DKzRpBawo4QPIs6H/GpCz2u4bEnyIus
X-Proofpoint-GUID: LUzcp1alU8QjN1d7kAI5OhNlEItJbWN8


Hi Anuj!

> Introduce a new pi_size field in struct blk_integrity to explicitly
> represent the size (in bytes) of the protection information (PI)
> tuple. This is a prep patch.

Instead of introducing a new thing which means what the old thing was
supposed to mean, I'd prefer to change the existing tuple_size to
metadata_size. There aren't that many occurrences in the code so it
would be a largely mechanical change.

This patch would then become the second in the series introducing a
pi_tuple_size member to explicitly define the size of the PI tuple (if
any).

-- 
Martin K. Petersen

