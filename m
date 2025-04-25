Return-Path: <linux-fsdevel+bounces-47345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E1A9C58E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 12:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F9959C0670
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 10:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B967242D94;
	Fri, 25 Apr 2025 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d8QXPU/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nM+KozWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1920F23D29E;
	Fri, 25 Apr 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745577099; cv=fail; b=qzLSbk3ld+u3S7W7DYCak1sWjltMQ7bklKTs8Kr8rjUjGOY+fVhS/f4wIsgA/+QwYcae1pVL0ASeLoMzYxblZUWaRTrVxlOvuFIhI544WTGsm4cGHHp7RkMkg5gn3YUW9U7ZxlVLJnHJpnIrlNeuAxP/7QZHbAWoj1FUMWah+w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745577099; c=relaxed/simple;
	bh=eBCLdyFFWM304cqErtqxsWHnZVYdPKnSOZmq2xzTStc=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j1JooYLJsrG7MdLyc+dYSdetGHT0d6ztdc1ctqdN6cTmDf///rJMiYOHZfF9f+/xP1m7BlnOIA398gDincdOdw6IK1MTysJHd+OehGaUrNHbqwBaGySCaypzuqdvYc90iuvI3bTQeHCmjIM+qXFvkhBOsBC03VckWPG9/ma6H+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d8QXPU/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nM+KozWS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9Vx8d012621;
	Fri, 25 Apr 2025 10:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/LR6YknhK958SDIpvWQoxW+LLSWEZtN53SFqjb7m/Rg=; b=
	d8QXPU/5y0slpTJA5x5rzjHOJO4hTpKgLvT6tNJMMKiFOFl1bh/aAr62tiGPs4mX
	JAd2OnXGBXltD7ZYg9KF/8qCOGif36m3gX/oFcszMFBKN30pSFWFvLXWqwEKZFep
	63ayrmOWSnFaaFkO6lV9rKgh4/o8YjYbHRJZ0xBfHYTqUBwId06gj6loqRNRNUY/
	crD6D24pcIRMv9XNF5V9EY2NZyMqp0oeL+ghen4teG6WIUsT1EmPJB383HAoKGoL
	51Y85D0F6icusnouWT9dIF9JtAJ8gSwr0C17YpiXKxo+NMcklh4zXkZWw/9AdPkj
	xSuNiz0uWloB+JZqaOK1dA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4687ud036v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:31:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P8ObGq024805;
	Fri, 25 Apr 2025 10:31:23 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010023.outbound.protection.outlook.com [40.93.12.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467puckqa1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 10:31:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GetBYvHUQJwtMew/aeT5wuACWAj3+0/ZPXaxX2iCViTaTMn9yhWCxGQiIEk5fT2VcCk3W9vP75wrdMDDYdAtxrmGkc1uTs6z3jtNQVKsBNyO2x1rxF0b8R8eZQvPJzNYvYUUgfvhmA31DhxBNK/S0oOj17+RahqNMuMUVDWaX6zFhwzgPxv2YxBzf8fboAjdzFLkQ59Z84/NpDztBM3oPSG6mRY91zHXoLRKTmrl0+vC+h/anZVpyHEs12DlS3vX2unPlAe1bz9voWF0zLTAon+zQwzFnAZbn8wE8rsxH4WjcXaZOUMXQd5ifVyVHWbyi9zofqmAfbkdQdW6BIcWdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LR6YknhK958SDIpvWQoxW+LLSWEZtN53SFqjb7m/Rg=;
 b=Chy9NtO9UmjcC/c444Om67VnDkcmOn6eMS1xwYMJvU8zjSyj7zk/zE1Hm9DOZeeLQvcmGooK8Yg7wXaA+/TsNloAMU+Z7wEoaJVvZQTCaQ0pNnxqt9QBpIhjNbO7Gf2a0ZZRyrkEnnbno4ESsjSFeck0gm73t8bskI6J+q9ukGkAdJdsWeTEJH0OnP6RTN1A8j+QVY5xIkbgLAqfMr5ZIRtAHLGHwCM6dWZ47Vw4Z1KlbGbYal9Nm2GTpxa6b1qyW/5dTtkZc7Zi0zdxd2vzEJxKd/KuAAib9qrykhkclIwd1aCyM/nBdkpucoi09l5B4ULwZraP/72TphD5nFsKtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LR6YknhK958SDIpvWQoxW+LLSWEZtN53SFqjb7m/Rg=;
 b=nM+KozWSKTNsGDp9B6nF1Nfw7IT+X0mQWIpJ9zW8vG7jAq1bOs6Ogyc4/esrPrUedUG4jLcZmN0lz7KdTun17R8sCwUHNFE3K6vjvijDDXzf4+zxNv6fQyyTzj1RCTVhGnHkHWsUvgMsmq+h5FdUKydQam1/t8kl+GbaswC4cKE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFE51A5CB22.namprd10.prod.outlook.com (2603:10b6:f:fc00::c51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 10:31:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 10:31:15 +0000
Date: Fri, 25 Apr 2025 11:31:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Kees Cook <kees@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in
 mm
Message-ID: <14616df5-319c-4602-b7a4-f74f988b91c0@lucifer.local>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
 <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
 <8ff17bd8-5cdd-49cd-ba71-b60abc1c99f6@redhat.com>
 <CAJuCfpG84+795wzWuEi6t18srt436=9ea0dGrYgg-KT8+82Sgw@mail.gmail.com>
 <7b176eaa-3137-42b9-9764-ca4b2b5f6f6b@lucifer.local>
 <ydldfi2bx2zyzi72bmbfu5eadt6xtbxee3fgrdwlituf66vvb4@5mc3jaqlicle>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ydldfi2bx2zyzi72bmbfu5eadt6xtbxee3fgrdwlituf66vvb4@5mc3jaqlicle>
X-ClientProxiedBy: LO0P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFE51A5CB22:EE_
X-MS-Office365-Filtering-Correlation-Id: 2827560f-1e6a-4b02-3a79-08dd83e44ed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzB6QUx4S3FzYkV3NnJTMmRVbFhsRlc5MTN6bEFDazl2SFpJUFhXK1lWVmpC?=
 =?utf-8?B?cC9JbEV6WGxDRVdSVVFETkV2ZjM1a2pKSTEwRUZDUlRJd2ZKL2RKY1JDZzNF?=
 =?utf-8?B?TGtBNC93Z2hTNStML0NybTErWjExd1JzNTZJSHNvQSs4aEU0YW9YUVcwbUxO?=
 =?utf-8?B?aGRvOXRuNE51RWc5cnp4WmgyWU9jR2g2MklwdW0xdjRjMU9KVWZnbHM1T2du?=
 =?utf-8?B?L2RYa0NtTThMTFFzcGR1blZMMlBTTHpiRk9RWGJ5YW8vNTA3K2J0a0dyT0NG?=
 =?utf-8?B?T3pQSnR2YlFsZnVZNjVBU2dmR0FQb1p6N2hkeHRXV0VCZUZaYW91M1k0UnVx?=
 =?utf-8?B?NDQzMXVRZ0JsbElYVmo3SEZOd0Y3T1lpandqKzNFNUxFK1VIM3JGeG95NXBp?=
 =?utf-8?B?WDNOdnJDVE5yeHVpNUVVUnIrVnV5WmtLSXc0ZjNqQ1RRS2NPU2pzRlMxbUtz?=
 =?utf-8?B?YzBwSWtzdUwrcFlTU3RhVzdaeDdXcE4ySjREeUxIUU5MR1JtbTdiYy9QMXhx?=
 =?utf-8?B?TWhod092dWlNckVXZ2hxZllrRHZmSnMxTGkwcG8rZnNRQUZ6YWlWbEw5Z3hu?=
 =?utf-8?B?aVh1ZnhqVmljK1BieDA1MTF5TG9udDNiWWxpU3lzR1htWnV5MGdnL0Z4aEFS?=
 =?utf-8?B?cGJ4cHdMUTdHSk43RU1oWHliQ2pHYzd0SVBOMEVUOVlIQ0NjZm5venluRVpJ?=
 =?utf-8?B?UVRxZ3J6bU5KWVNZZlNMdzVrWHlmNEJmYy9WQ1ZFR0JGLzdCNkRVek9nQkVF?=
 =?utf-8?B?NzJLZ3RPNjM5U2FEWGxEcnBBN1psVlNlTmRiTzRsZXJuTnFCczRzRFVwKzho?=
 =?utf-8?B?Z2U4TFdNMkYvM3kwTmxZUHNPNWRrckdOVmJpZ0gvK3ljaEZhVEdnM2FZTWpU?=
 =?utf-8?B?alh1UEx4L2RqZFl4YlJZZE5nTm9rQlVvVXpEWEQrVHBjZytJMjcva05SbWhQ?=
 =?utf-8?B?b0crMGp3Mk52T1JIaUJFLzdMV2g5UEdTQmtXaVN0bmljazJJYmZoa2FXa21N?=
 =?utf-8?B?S2QxU0s5ei9UTm8xTnA2UUY0a2VsdmE2Unk3bVB0YzZTaERqbFR4SVpMTG1G?=
 =?utf-8?B?Z01YTFJlZjQvb1cwOGlrU2p6Z212ZDk0SGhCOGIrUitiVFJUbGtKZmVvK3Bo?=
 =?utf-8?B?N2x5SUt1RDI5amxMOVFZeDdyMVNjUHl2MXNPUzBwNjNXeEdqK2dsY2xwTmFz?=
 =?utf-8?B?NmVNMExpSXQwZC9oNFllNmdkRXJIUnJYejZnUC9ETWFJY2hFNnR5Q0hMTXd5?=
 =?utf-8?B?ZUtFV01JL1hMTzNNVFowNVZZdFJiZ0cxSWxrSUJuSzZxbS9obzJzc2xLa1RF?=
 =?utf-8?B?OGZFTGFkRGxPSnBsNzQ3bmRvNm5QYTZtemxtaDllMXBzTnBxWThFWUYwa2FI?=
 =?utf-8?B?REJIMEtWK25xUHRuaU0zMTB4N3JYNFArZFd0SVRVdjVTbWtPazFFL3VIQ09w?=
 =?utf-8?B?R2M5c29jWmM3aUlvMm5OY3lsUjFvVkxOaU44cmhoWXN5c2RZWURBcTg5YUNq?=
 =?utf-8?B?dWNXTVFkMmRMbjZwaUsvQytkdVkvdWRTRTkySmludXZXdHNRK0tISXBvWVln?=
 =?utf-8?B?a3NrVDdFL29HZUN1bkFOalMxNDZES0x6L2xpb1RlR2RSeDNQNWNOZXl5c1Fk?=
 =?utf-8?B?T2JXK1lQRU5NMGlMalp0SGdZL3gzKzJ6UnFwZGdMUFcyUkdDTXJRcGNEV0M1?=
 =?utf-8?B?azhSNE5rTEpkaFk0c25HKytTY25mZkZwR3ZDRFhuVmdFUmJFaEtzcUZvMGRl?=
 =?utf-8?B?WlBGallnT2lPY0lLWjNFYjY3K0xqR21ZT2ZzMExhcEhoRXVwSUM3YXRNbENI?=
 =?utf-8?B?NFB1YjRxYXZ0TXhJd3dqRkJFMVA4MjFqYjliNDN0UURMVnpSc0EvZ0RXOXBY?=
 =?utf-8?B?Mi9PS0tFcEZHYlR5akYwcG9yVVl4TkxvcWlpU2o5WWhJS2RRRGltQVoxVXVT?=
 =?utf-8?B?OUUwMzVKYk9Pa3Q2dkthcjRwTVo1ZS9XdmJKaTg3eVRpOWxmRG9mQWNaNFdN?=
 =?utf-8?B?OHdjbjNFa1d3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am53dlhmRmowbUZodFNnTjdoc09lQU1LQ2FMVi8zaHBPSUl5ekZoYXd0TFdw?=
 =?utf-8?B?eERpaHFyandBQ0hjUWYzaUNuZWdGWGdqU2JXak56U1YrdTlIQkJlVkorTGh6?=
 =?utf-8?B?d08rYmNiYkRWM3ZNSkttcWRQczU0Y1JFdklSQjl6VGM4R1hiVXpMOFV0WDk5?=
 =?utf-8?B?d0Z3Z2k1cHB2S293MUZrL3dkTVBSKzR1Q3M0ckM1NVNhUUs0NkhXVkNXamk2?=
 =?utf-8?B?OXo0Zm5zS2oxQ3ZRYmhGQWw0cjQramszZW1vbXY1ZzFyZDVCZFpIcERGZVgy?=
 =?utf-8?B?dkFzZE9GK2FlaHkwUFEvNElFYkV6d2JLRnRKWGErdnpLaTA3VElUbC9Ta2JE?=
 =?utf-8?B?a0FJb05wSk1NaERTR242dmppb3RpSlM2WFU3T005ZDhQNFRITE1xOXVMSjZB?=
 =?utf-8?B?Z0pYL3hET1Z1UysxQm1UZDdwd2Rad0dxaXpIbEdwRkdpeHpwMVE0V1JQVE9p?=
 =?utf-8?B?bnhtbW1hbnpISzNHcnNMcFY4R0JuZTR1ajNXcDBUam9HVVViMzV3a1kwOGJ2?=
 =?utf-8?B?WFhaYW9KVytpYitWM0tHdEx2dEtIdHRKVUFtQTVLWlE3Vk50c0hsZ3ROWGNz?=
 =?utf-8?B?aW5hcFVUMVZjcUVEc3VwTnRmM1JHZzgzbFE1RjhXTVNDZWhveGVNa2FjSHBy?=
 =?utf-8?B?VzlCVlVOREp5TElPVzY4Y2tiK3dwRDN5bUJKbXVqZDhWeklVUjF4eEtTRmtx?=
 =?utf-8?B?Vnp2cmJ0bXpvSnNsckowTlRaMzNZVm9yajduNVpXK3IzcEI4dWVUWUlzVC85?=
 =?utf-8?B?RXMyTVBpbEhPaENjc0RRRWo2aE9KMW53QzRMVG91bktxQ1UxeC9MbklvWkR2?=
 =?utf-8?B?aTB5YXZjejFOT25VWm1tT0RNdm5SOEhkckxUWnhTUVd1MStZTUY3enFtQ0ZV?=
 =?utf-8?B?VHM2ZW8yTmF1Rk9IRmNWaDZrczdOdGhOQkl4dm9yNGgzMUFDQ1crR2tHeGRo?=
 =?utf-8?B?bjJ2amRWZ0loUmdycG9KYnEzd1A4alBtb0d2bDhKVG1qVlpqOVlUaTRzTmRG?=
 =?utf-8?B?Z3JDc2kvbGV6V0FlZjZnczllYVV0M1hxRXlXdnJ3NmNhdWpqVlkwTGoxNm55?=
 =?utf-8?B?QmRPNHA5MFlmVnBxa0pCSDVkcm9UN1kyTXdyTHFLNFcyZER4UkpIZ3Ricko2?=
 =?utf-8?B?YkhBMXNwN0ZiTWZQNFJQTEdwMGFJZkZFNnlBTk9HY2xLN3ZSUWFvWk9UY0lh?=
 =?utf-8?B?MjN6OTJBVmhEMDZTdldoQ3MyLzJtMnVndXB6TU1KeWVBQVMxMVZJclBtTEln?=
 =?utf-8?B?d2JJZXdRekVacmtaQUJqQW1qam9IUzNTNXdsMXlkbFZkZkZpbjl1MzBnL3NZ?=
 =?utf-8?B?SThrQmpDYzIzSnljbCtxTjRJbUxkNnpnS1UzdU10NEc5MmRxaVdmMmFIMWQ0?=
 =?utf-8?B?L3RiZllGaFFYUTBWNWY1ejR2ZVZ5VHZlMFlUK2FKNjdNKzVVWW5ZZ0ZZL21p?=
 =?utf-8?B?T3ZBU0Zka0lnMlhlbzRYSkc3VnBqeW5HWmRKM1ZyNDErdVRaNlVWc1NqbDc5?=
 =?utf-8?B?Z2lobmFwLzBzTUdCa28vZVdwZEJEaWRWazhVUFVnOVk4K3pqYWRacGJtUXVY?=
 =?utf-8?B?YzE1RUJuTk9VZnY2NTVwa1ZvVlAxOU1icWNoeUZWNDh6NU1tT2RqZEh1WTFM?=
 =?utf-8?B?Vy9LdG5xOHpqMUlFK2dQKzExT3RaQSttUkVzTjBybjNMejFlWEtPdXJEakRm?=
 =?utf-8?B?OXQvQldmNTNrejVtdmM0UU1mRnRJZ21YNlpuRXJDRy9iazZHZFE0UnM2RXhw?=
 =?utf-8?B?Rm1Ucndpa3lpZmxKKyt1amxCT0NhV0NTOEphSEp6bUZBbUVpZFBnWVhIQjRS?=
 =?utf-8?B?QWpwNFRVd1hKRDBwYk8wSkhBamVKWXY1THVTWHFVNzQwWVorT3RSSUxHN2kr?=
 =?utf-8?B?YzBWM1pCVXZ3WXB2STFLYkRGWjhzK3Iya0xZbGlKeEMzQ2dGaGFqMzJKWmRG?=
 =?utf-8?B?Q0hFNjFqL2lHVEpBSCtTTkJMdXZad2FaaC9TOWFDR2k0TkpsdTBEM1RHSUhi?=
 =?utf-8?B?c1JQVCtURXZ5blBGVFN1bnF5dzVsZCtkdjhVeHF1U3d2a1NGSm0zTDFsR0RG?=
 =?utf-8?B?N2tKTEFUQmcrUkJFQ1puUVdjakF5eERsNHRRUHFDOFJJNXRaTjY0VURvVVZx?=
 =?utf-8?B?bjFuenhjL3Y2eklDd0xFNEZyajdKZ2xNWmluRE11TW9BQUFZZ1o3cGp3aXhh?=
 =?utf-8?B?OGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jDsIUw07ie+NsCccWjADSAyyUQA9BOHXhnbFoSH0SHdnWPyBCwqmHa8GWEl1vRv+rXsdu6RG2GlV/+/K9r4Gld3mEJKxauJbdCbXynxQN90EiYu4q9elskCxoz0aXUuwDWFog/+PXsdoTUwHRD4zdqTMBsIRO9WD7zAZZMYwGpNQvipnfE3T/SNxfgA16fKHrlVRZesnmYsM3+LWUM41YDQAglqOANG7T0Z6g1EzNDA7ig4JMAqpqyYVZNf2ivPbpEZ9Uc6TTFUrEvB/hEW03k5DXP4XhwkzwHUxGrvZHo3l8zirJ66XHV9VutFzqIsLXajys3ItFpYXw3wXph9VmHV4N4wsbzkMeyTMMg71H7k+mXiGS49QSmqFYcHRCY65Wd+HMNVnmTzAYZs1y8j65mXCMtc2x8pP5pcpHAj5eAebAu67Jm/8qWBRWwHaTOvbXCxp94GQ0Q4MY6hOCnLcv6i9Vhhd6S8+CZGqkBBbfFuic5ybua1CyaWjUgfey+c/ZgPeL2a+fsoxqbb2GsHpXdQYs+QiR4aAOexyak2WLG3QGwQbFhZc28bIQ3VgzgwmYRXS0pYl5jYgAMzLbeOL8T0QguTn55/kPZ6t5fVBGWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2827560f-1e6a-4b02-3a79-08dd83e44ed9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 10:31:15.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NDKFed05z7Pvvq+o/RI2i0QCcaOofIYUybewjXzAnADi2nZhXMF+3Xvm8rxdU/JjBLdKrHcFlMPlPjk+pU+Mly+pgkRYITUEYOiYs4GaSxU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE51A5CB22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_02,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250076
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA3NiBTYWx0ZWRfX8tsOhnJqiAYs jQzR1eXIxONHsypiXg8lrNNcE23gPAlsaBlyC4qV53Gd15REcumr71E2L03udkJnv7Y2LjNY/te 29TRrbKtJpjKGJ+xN7yhQHgkKJ9w9RC2/WmP7choWhpxcsgRWm53wXnIF271sNXSsCd1lVx1dVE
 5b3OyuPgaHU2RsFTehcuBJgnHd0dO6HfgVxqeSyvRDfRq5WW4l3Csp8lB+xsE3ZvjtDoP4YxtP3 0rntFVL/SR0NGEM1myMypnr3N70q8YFS4oNA2Y/k/kJOnjJNjQh8HmMysih8xyWeC3Wh7AywugK onggau+f4FW1p5caf1hfLEsgI2OMnbtENTcY0WL9lRaOT/w3SVL4dquaFIPBiTLWtK7QShsfqzy NV7QuM4Q
X-Proofpoint-GUID: 8_ZhNZQP3p70kicN8fYydqEhLHqJ6orN
X-Proofpoint-ORIG-GUID: 8_ZhNZQP3p70kicN8fYydqEhLHqJ6orN

On Fri, Apr 25, 2025 at 06:26:00AM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250425 06:09]:
> > On Thu, Apr 24, 2025 at 06:22:30PM -0700, Suren Baghdasaryan wrote:
> > > On Thu, Apr 24, 2025 at 2:22 PM David Hildenbrand <david@redhat.com> wrote:
> > > >
> > > > On 24.04.25 23:15, Lorenzo Stoakes wrote:
> > > > > Right now these are performed in kernel/fork.c which is odd and a violation
> > > > > of separation of concerns, as well as preventing us from integrating this
> > > > > and related logic into userland VMA testing going forward, and perhaps more
> > > > > importantly - enabling us to, in a subsequent commit, make VMA
> > > > > allocation/freeing a purely internal mm operation.
> > > > >
> > > > > There is a fly in the ointment - nommu - mmap.c is not compiled if
> > > > > CONFIG_MMU is not set, and there is no sensible place to put these outside
> > > > > of that, so we are put in the position of having to duplication some logic
> > >
> > > s/to duplication/to duplicate
> >
> > Ack will fix!
> >
> > >
> > > > > here.
> > > > >
> > > > > This isn't ideal, but since nommu is a niche use-case, already duplicates a
> > > > > great deal of mmu logic by its nature and we can eliminate code that is not
> > > > > applicable to nommu, it seems a worthwhile trade-off.
> > > > >
> > > > > The intent is to move all this logic to vma.c in a subsequent commit,
> > > > > rendering VMA allocation, freeing and duplication mm-internal-only and
> > > > > userland testable.
> > > >
> > > > I'm pretty sure you tried it, but what's the big blocker to have patch
> > > > #3 first, so we can avoid the temporary move of the code to mmap.c ?
> > >
> > > Completely agree with David.
> >
> > Ack! Yes this was a little bit of a silly one :P
> >
> > > I peeked into 4/4 and it seems you want to keep vma.c completely
> > > CONFIG_MMU-centric. I know we treat NOMMU as an unwanted child but
> > > IMHO it would be much cleaner to move these functions into vma.c from
> > > the beginning and have an #ifdef CONFIG_MMU there like this:
> > >
> > > mm/vma.c
> >
> > This isn't really workable, as the _entire file_ basically contains
> > CONFIG_MMU-specific stuff. so it'd be one huge #ifdef CONFIG_MMU block with
> > one small #else block. It'd also be asking for bugs and issues in nommu.
> >
> > I think doing it this way fits the patterns we have established for
> > nommu/mmap separation, and I would say nommu is enough of a niche edge case
> > for us to really not want to have to go to great lengths to find ways of
> > sharing code.
> >
> > I am quite concerned about us having to consider it and deal with issues
> > around it so often, so want to try to avoid that as much as we can,
> > ideally.
>
> I think you're asking for more issues the way you have it now.  It could
> be a very long time until someone sees that nommu isn't working,
> probably an entire stable kernel cycle.  Basically the longest time it
> can go before being deemed unnecessary to fix.
>
> It could also be worse, it could end up like the arch code with bugs
> over a decade old not being noticed because it was forked off into
> another file.
>
> Could we create another file for the small section of common code and
> achieve your goals?

That'd completely defeat the purpose of isolating core functions to vma.c.

Again, I don't believe that bending over backwards to support this niche
use is appropriate.

And if you're making a change to vm_area_alloc(), vm_area_free(),
vm_area_init_from(), vm_area_dup() it'd seem like an oversight not to check
nommu right?

There's already a large amount of duplicated logic there specific to nommu
for which precisely the same could be said, including entirely parallel
brk(), mmap() implementations.

So this isn't a change in how we handle nommu.

>
> Thanks,
> Liam
>
>

