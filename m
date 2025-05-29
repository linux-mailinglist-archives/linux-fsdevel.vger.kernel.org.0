Return-Path: <linux-fsdevel+bounces-50078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6A3AC806E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA592A227D0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547A222D4C6;
	Thu, 29 May 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RmIzjZie";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eCjLOCeI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1022CBEF;
	Thu, 29 May 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748533185; cv=fail; b=jo/SCnVxyzsjtX3/aqGXuaqDz/9YP+U23NBu1AE4BzJRkWqUfcbt21St1Gu4sp+6mngNp4XLVR4O0a4mKooveTGajsDRviVi75v3NSYQyhmsivscw/tv8LI/mt0apgAP3Y51X+gVbii89ypwd+iVbMrKB/HBALneZXUOme0ZCZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748533185; c=relaxed/simple;
	bh=o/D0Fu0uwH+r1yeH5RRVz4udmlf8yU2sSlqsjT1Gyi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gx2u2EnX89z+Y149dLkTtBa86BPl5P8LXss16W/OQCGZc9nZvjofzVCT/rXP7j83rB4CPgBybcAMd8bDV1u5tACatsQSzX+MaM6Bm2jLlcRQ5zwa2AX/W21ADt73Qjv+TiVL/umPCgRMOguFIszo4o+69H+7OLCndUmGzcOSg8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RmIzjZie; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eCjLOCeI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFN9ZH004264;
	Thu, 29 May 2025 15:39:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xLcJQXZNl90i1YsnOX
	OBimpzWIS137wnGha1BYA3qo4=; b=RmIzjZieOqC3YX26yBN0lAPcJF4aZEfzb+
	CV3ZuuW1rgMfPA+2iYkjRWRoWbUQm2uVCvOsazo8LlWV1uNGop0vC1qw1Cfq1H1W
	BYR8Gb45PrPHWFTqK3iFWuwLOhJtaEqdCgTZbgfh6XSp55rO3pUracBWWh/7Wp0s
	skbmthvgC2dNUtOzP4bB92Iun8TLYasbIfP91iINwTx4TjG27aMIgda7+0M6rp1+
	16NfMXunkql5cIM6QSxI/wowa/Qa9aY5mSO5gxAv4e0KNYeXgLs52HhfKUMLXLcu
	ILDA7gCz5pQ4lTmTJAgowHhvu+GGBOtvvaEhaoVI37K/9ZdloX0w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v3pd8a4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 15:39:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TEGNmx008213;
	Thu, 29 May 2025 15:39:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jcv07x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 15:39:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=boKePEsw1TIZeA6h/k6rts4VTwAHHkeq1ApYa7PwRSCPlUA5vpcHGiYrNi076lx/AsLqEX3x0c4MD0U/bmPjW1HV89laFp5JJyiQuFZf+rdLMmKs8SQ1qoui0D+B4WwQexOR09/G/Zcs9df4suviK8HK7j7auTHuqqHx6nNwzEVbDVk42PofPiBQ78MZd16CDkWzYFzFCkNptai01Tlr95fiyqQssy1NXL/R2aeba4K2TgycmowvgfEUqILf8mSi1Gm/Ub93dY65rTFBMfBKMOToHbqkAGIGisUhj1jUh4ThXnN4DnP0O+UdAZOYJu+CsEofjgX6GhbiXCPvBbAAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLcJQXZNl90i1YsnOXOBimpzWIS137wnGha1BYA3qo4=;
 b=h24fWyaEvy5IL05zst7JFSXElnJmPt1lpCETySzyDXrp5CeWiNGbvAYJTMIQD31CwiSzvks+/KrzFk77rG4ys/XRY9qh+PyjHctD+162yx5p7XbPNali0hOUjwVbcwr9B0CpvAvE1X+9mkP/oPJQh8UQb7eVv5rsVEuOxgfseAUFZBAR8hu+FciUIbdWQfjB91xD2TVV8QKXJxwTTPkCmLaRWFG7fUUOYlmndfNcMji2wx8SxHUTZqbqJ80BKrYIQl8FJA6LH1BD/Ve+CHxACCmffLxhNVZHI7eXshGfUgKNYHKUKcyT4Ul8qtgstR919eScWsG6UZ8cSp/7r0NKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLcJQXZNl90i1YsnOXOBimpzWIS137wnGha1BYA3qo4=;
 b=eCjLOCeI654iS5UPPZThgSMUqFGS3XzIAVwgEEMWUCpe8T2FXBmBrvLJ2vc3PetTpOmdoCx99tr2xK5u5xwNtu9g3nY2O4vIMeQJfHCNZbf2UKMku/P1RrNwhHJl88lLwZZYzOoLw9mlwk0Y+4kyD20cysce5u6KfiPDy7TUF1U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW4PR10MB5839.namprd10.prod.outlook.com (2603:10b6:303:18f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.33; Thu, 29 May
 2025 15:39:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 15:39:11 +0000
Date: Thu, 29 May 2025 16:39:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v2 3/4] mm: prevent KSM from completely breaking VMA
 merging
Message-ID: <d63d00f2-2302-44ca-a6b1-b25d6d163628@lucifer.local>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
 <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
 <924e2e84-fe37-4fc3-9c76-11ce008f0ac4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <924e2e84-fe37-4fc3-9c76-11ce008f0ac4@suse.cz>
X-ClientProxiedBy: LO4P123CA0445.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW4PR10MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e13675d-8872-4599-6472-08dd9ec6f593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?giIoLkHvA+cH3gcIB7j+i9zIfSOrKLVNQdZ5YAZDY2/AkxViBVq/KWNc0mHp?=
 =?us-ascii?Q?VBRaSrnI1CzE/Eyg6LN6Qil/mFM2kNDA7vfLTwMCHcHtqPiRswgO3YPU5VX/?=
 =?us-ascii?Q?msca9KKA8fQzKXjMGTBXFjpJ3pv00fgKmgoBzfU+y8LKIXA8d99JrDJXz654?=
 =?us-ascii?Q?BqMuM9SnxeVh5Q9jFKsyzyc5TkjlZVbjnLjqUfFNWG3yOgUQrIqej58fgQDl?=
 =?us-ascii?Q?4PYcgFEOp2vdNYOa/nwwDqMpmzv768ModZK1SNZ/DOuzr0p7neHMQZqqEsCa?=
 =?us-ascii?Q?v+hRE4iovys543mLxk5Z02Bl6940a+su/rfyoAj/+3P69CItjy38ux9wLIxm?=
 =?us-ascii?Q?hOZdKFHAUM0N/qEADyxgdnAGaDaMlymuFuLgDxBsL11+5M/8HqfW9GfnLI63?=
 =?us-ascii?Q?2f37AMIYCXck0L4PNQ+F+NgstWSrlBQhQMismO7lnwRIDgO1EzekJCoUnJ3a?=
 =?us-ascii?Q?9aoZGrEbQfn5FPL1CjLCvgpraVgr5xJI6JxkkUpx37jHhIS0snbh+EVDTOf0?=
 =?us-ascii?Q?p/7MjeIazgLyhptbqNbA84Au4alyqe8Ui9EOHMGC/cNBJPWfWl/a8t2+A/iD?=
 =?us-ascii?Q?2EQagH7tdYFAnpdUwvOoGSTkgMXPh184vRs2FUPv4JrFLCFkeeRr5tuGOlKR?=
 =?us-ascii?Q?z9rPNT83a5f73Fpv3yF/SbJUU64zm8L5BsKzjD6WahbanNUS98yVbipBbmTg?=
 =?us-ascii?Q?SefI3vTcisDq4cKuDtuFOzGGhvx/wS2nlL/RFHP3OmBQ+nm5c9AqNS8kRlND?=
 =?us-ascii?Q?Fu2NRt1Bl+hJ+rAAoYJiJE6xEQ2E5hznuHfzn72XF9yfcgYdVHMKEEs+UWLf?=
 =?us-ascii?Q?tdbLEoiWCQ6YZf8CUZokjMfl0n8JR4FbRd871JlrSymSWsp3y8wknoccWaCd?=
 =?us-ascii?Q?pl743448YisNh34J2pHQc5avZt3smGl77HQFA0JqjUzSgsSicfXC1tBvz6gO?=
 =?us-ascii?Q?hWsMskRL94Ik/iWrnYyFmb1wC+JMo/H7Ag1hBGAF726zdW3tpMoLZfbXUoQ5?=
 =?us-ascii?Q?tADBglSJ+Vti8cBeX3yJcblkPoh6oA5WqAlY/px+0BdJaYH47Q8HVJb9EJo6?=
 =?us-ascii?Q?oxWPva0NuHeNdGmkcKlloexz8yn/43O7MuJOQJHN85ZDksOvmnSQ4/8XWBRS?=
 =?us-ascii?Q?cr3G4gWBTlYPwqtKMrCTWCoJt+fvHiMQA6LI5lvYDuodoMWhy9YezQfh2FfL?=
 =?us-ascii?Q?DGJxxJY0zy73wzxxN8rSk+U04tKWqKLsjdxRFDaaOTTJff/AF1xk12CF57lG?=
 =?us-ascii?Q?f7qMredWuA09X54DJ2yCkoGxDWDFEUU6wXIK5QSl6OAUzZFvlBITKiOjsIcP?=
 =?us-ascii?Q?BHEdLsI4qo+vvufX/O0gdLkIbuUpodo2nILBAi9rz1LDjnziQ27gB6Lq3Neu?=
 =?us-ascii?Q?oeYx0nl1lAibd0mLzLiRuV51kflzz25NC/Y7Iw4v9t8ppnWVIDIF33xMD+QP?=
 =?us-ascii?Q?d4+Y2xIfl/c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4HZcQp6Q5wLyER6LT2PO02KqpJBP7TZ7kGpVQ4G+yjsThhLKrfvF35KLmBAb?=
 =?us-ascii?Q?WBTHm4GctuZqpwCcaalWmMHHTy6IYLKBnYXU6c6+dKk+r3tjgvQmsXCm3QCH?=
 =?us-ascii?Q?xTtEBm501G+W0MnSYgloFCt1t1bjEnENVelnm92xP8L5wzgcw1cmJkm5aMnE?=
 =?us-ascii?Q?7etF9sjJR2DtyQQkQ8zqAaEaXavzaNglcF3i5IpNxcLSwP+7G+BRPiyq9qx5?=
 =?us-ascii?Q?rlEEocxNBeyorv1m+pQyFlGeoeKRWXugoRB7NC1x0phBvymiqpsE/cS0xIDO?=
 =?us-ascii?Q?JBXzurwV8f9Td/EOF/+2ouCeeK3klYmvI1ybTjIj8uPAZNZnD1qeX/PDOfA3?=
 =?us-ascii?Q?3JabkvLcNBQG60qpo39BD9lHd5rHLcWK7iG3yj4Tg/xkGxC+pgcWgFX6HphB?=
 =?us-ascii?Q?IoMtnhbDMovL4++ZTFAVKE5etG+161evEnuakfif6WXSa66KhxSI+LKlAivr?=
 =?us-ascii?Q?mQBHhEa4fhfUjLLdns+l+nf/un6R9KENAy5461iOqR+jLlGiAINmj5Xz97Fz?=
 =?us-ascii?Q?WvuvDVBAQzF7QnnMPrHTbaBdW1PpI3A82lJA5lbubX+woJLTR+6oD9mqSl2q?=
 =?us-ascii?Q?diuax0Xdj0zQ41r5d8OW97IfgID81TKJJ6X+OnbUW5FngqY6F2cvai+aEVJh?=
 =?us-ascii?Q?Unwd2nP6dVCx83Tm09BsCzEgFg7GgKQyYkhE2vQS0VfcEgJqh2cBF0CRT7pT?=
 =?us-ascii?Q?wNyqr7DBoC8pca7vh26uFFsgMk99TCrN2qoRn/PLqQwLDY5BwpEsKrTTI9Ag?=
 =?us-ascii?Q?6IazPta1J/kPhGHr6jDWAcvObWQD3nokOYSrq4WKLJehsD+Oet2qT3XMibRv?=
 =?us-ascii?Q?SauT11dMQWgLsechCDo1N/I0Dyj4pR1ypm1VqsNlDTNc8cX7QBpTaBBGmZUd?=
 =?us-ascii?Q?aUUnX2UzQ8OfDnrHYq5HCDxKgRgcpM89a+9hSH3pTnsy6wzEF3S9xIIBM3yp?=
 =?us-ascii?Q?YdMm9c2QSocrkF31iH0xKmF4PELeU3UiHqmxJE5anr1Lf+cUgWHl6+3OEtHD?=
 =?us-ascii?Q?M131gc+yk6oGLsnuilvdJ8aRC8GIteAlkwXy34o9bn/ZCti2EtzI29dZ3H89?=
 =?us-ascii?Q?treVN5zTZ/Ghg+Txo+FTOZeMZxFQ1C3heUrqQCFYpFcErxCHcEBTwCkEx9lu?=
 =?us-ascii?Q?Fw7K8Vz+9gPi8cQ0AVYZuQ2gMHLZMoY4Vd1tMJpCLVjMdhxM/YZDOYkPU7eW?=
 =?us-ascii?Q?IihPOe3cTAvcqfwevT6zEXlUAbqXNam6T2Za9oztHRHgbclwMu6HfnA1mBxt?=
 =?us-ascii?Q?SBLLyqdi9m2/yvk0D0lUNxMoQfGg7qKJCFxQ1/jXj5jHk00CE/XAA+cLbT9q?=
 =?us-ascii?Q?RYbUGjSFmc7cVNwWCcrmG6/20TSlG2BNcZkCf8faOF5LWXCDDBB8UarZ4LBV?=
 =?us-ascii?Q?+L1Ue6dCOvKrBDxbSYFih9LXNKo91F/WBzK/X7Flo0/01WXhc0RKmZo1BK3N?=
 =?us-ascii?Q?WUXIY56NJPrpekoURsKn/JJt7Zq27sxUKV5qQKZce6WIH3ryhQ3kheYAZOki?=
 =?us-ascii?Q?jfSYNe7qRp8hNY8vjoIx+0dXNCil6GtWNh+7LPXW4jjSFi13+SuvUy+iiDu/?=
 =?us-ascii?Q?1yLmUGqiJ7EUr6Ll4TZMaz1wUdnUYCweMN+66O/3hMf7BwWsByKwGLhYlfXL?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bz/ujY/7Kok2nmsKaM4rAc4dmSIZV3Rxpph6fsW4p/wI9Ad52H8ZvOh69GQd/W74InXkhyb6F2ToKMO2LI+jWlchQ8dMH98OdD0H7s6yn7P0VHGUjrslvJ9L6Yed3wxvtTQWxgdZ84EPPntRX7Ziazj4rvXGTAX5mKFr1fj1+3xkDZx4WzruaRjEhmKyqT0opGixdHB60MsmrXGSW3XBqxzKpKNFGrlTtVLWozqwRfGSTPru0qUaJSqkdvhMokoH2EtS6eLynNOLlfbHOGngkFhJP4tR25kqe49qJ28OX2SJfAK2n9Dxrm9HgJywOehXHafcnbrgDt5E1CtITeW8t2kzB0NMZ01rvGfttE1ZSDYr917IxM+ymVbqx5GYLuc9gk8mmqxmDG0G/7tzsDxzKM47fnUYJba6DDH1RrTN8RhLgk2mSL6/xCmMHV8R0xSlFKDhWR50TGye01qOTpfxyLDaQZOxtxLZjL2QFNNiEWTWsszjHJwBzMJz6xsYhnWiiiquerEVFNERUnBjmX8lCwadoyRGROTJqRR85lB8cpBaL+Y2xINKTF6KnNj+OLFHiEaZZY3dWhtcR7dRwH85+u31C2XhDteiVdyJc8qoGcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e13675d-8872-4599-6472-08dd9ec6f593
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 15:39:11.8231
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZefPWxLcis3oQD1WebY21/fB22rhN9QZUImnSZMB+JgrkrAc4CmDAyZ4+rFCatdCmqsJNWMFxzJUzPph18Yr3fK7XvqyoroKX+RZjy199M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505290152
X-Proofpoint-ORIG-GUID: ZXHbHDlmKl7QQHYT4kHvxtyHfcrznHqm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE1MCBTYWx0ZWRfX8OsTTtEeF2Iv NGdrFqt7G1koCH2MuOuHSQnSSOMkoM5iKbJJg1Turyk77NkEacoPE2Al38v7Vnh3NBaUoIGFu40 UcqmWaCLV8yH5810n1LK9l5BA3WATzy2+0By+I6S6gJKF1EPuG6rAzgR5ydwJvD54KzcM+ZMMSU
 EMXRxMUsu3W7yrqFs3W8nh0ObDjDZeOr0jvXaGSxjhIFtjxkDRnhex+oY46Er3J0iZO+CeHAdpM Hmi79i/30M5ZCJWkq+1jBXYAagR5oDcP1gKfUTR9Y0xWiAVEVopOcba2mEH4DRKfhAgj4Rpbkju fLNbjdI5Z44fTdW46oiERFfiO94qPcmoXCEVsxy1X9iyIECNt9urKUQtRosXA4ctroXTj0xIpZ9
 vTR73/O03ZspZDMGoQG4UZKLxvBlddgTnEGDFVT2mbQ1OuHvATnbM+arkgr6A9XHslwkoA8T
X-Authority-Analysis: v=2.4 cv=UZNRSLSN c=1 sm=1 tr=0 ts=68387fa3 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Oq0780OTBeYr30fW-lAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: ZXHbHDlmKl7QQHYT4kHvxtyHfcrznHqm

On Thu, May 29, 2025 at 04:50:16PM +0200, Vlastimil Babka wrote:
> On 5/21/25 20:20, Lorenzo Stoakes wrote:
> > If a user wishes to enable KSM mergeability for an entire process and all
> > fork/exec'd processes that come after it, they use the prctl()
> > PR_SET_MEMORY_MERGE operation.
> >
> > This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> > (in order to indicate they are KSM mergeable), as well as setting this flag
> > for all existing VMAs.
> >
> > However it also entirely and completely breaks VMA merging for the process
> > and all forked (and fork/exec'd) processes.
>
> I think merging due to e.g. mprotect() should still work, but for new VMAs,
> yeah.

Yes for new VMAs. I'll update the cover letter subject line + commit
messages accordingly... I may have over-egged the pudding, but it's still
really serious.

But you're right, this is misleading, it's not _all_ merging, it's just
_all merging of new mappings, ever_. Which is still you know. Not great :)

>
> > This is because when a new mapping is proposed, the flags specified will
> > never have VM_MERGEABLE set. However all adjacent VMAs will already have
> > VM_MERGEABLE set, rendering VMAs unmergeable by default.
> >
> > To work around this, we try to set the VM_MERGEABLE flag prior to
> > attempting a merge. In the case of brk() this can always be done.
> >
> > However on mmap() things are more complicated - while KSM is not supported
> > for file-backed mappings, it is supported for MAP_PRIVATE file-backed
>
>      ^ insert "shared" to make it obvious?

Good spot, this is confusing as-is, will fixup on respin.

>
> > mappings.
> >
> > And these mappings may have deprecated .mmap() callbacks specified which
> > could, in theory, adjust flags and thus KSM eligiblity.
>
> Right, however your can_set_ksm_flags_early() isn't testing exactly that?
> More on that there.

It's testing to see whether we are in a known case where you can go ahead
and set VM_MERGEABLE because either you know .mmap can't change _KSM_
mergabe eligibility, or it won't be invoked so can't hurt us.

Realistically almost certainly the only cases where this applies are ones
where VM_PFNMAP + friends are set, which a bunch of drivers do.

David actually proposes to stop disallowing this for KSM, at which point we
can drop this function anyway.

But that's best done as a follow-up.

>
> > This is unlikely to cause an issue on merge, as any adjacent file-backed
> > mappings would already have the same post-.mmap() callback attributes, and
> > thus would naturally not be merged.
>
> I'm getting a bit lost as two kinds of merging have to be discussed. If the
> vma's around have the same afftributes, they would be VMA-merged, no?

The overloading of this term is very annoying.

But yeah I need to drop this bit, the VMA mergeability isn't really
applicable - I'll explain why...

My concern was that you'd set VM_MERGEABLE then attempt mergeability then
get merged with an adjacent VMA.

But _later_ the .mmap() hook, had the merge not occurred, would have set
some flags that would have made the prior merge invalid (oopsy!)

However this isn't correct.

The vma->vm_file would need to be the same for both, and therefore any
adjacent VMA would already have had .mmap() called and had their VMA flags
changed.

And therefore TL;DR I should drop this bit from the commit message...

>
> > But for the purposes of establishing a VMA as KSM-eligible (as well as
> > initially scanning the VMA), this is potentially very problematic.
>
> This part I understand as we have to check if we can add VM_MERGEABLE after
> mmap() has adjusted the flags, as it might have an effect on the result of
> ksm_compatible()?

Yes.

>
> > So we check to determine whether this at all possible. If not, we set
> > VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> > previous behaviour.
> >
> > When .mmap_prepare() is more widely used, we can remove this precaution.
> >
> > While this doesn't quite cover all cases, it covers a great many (all
> > anonymous memory, for instance), meaning we should already see a
> > significant improvement in VMA mergeability.
> >
> > Since, when it comes to file-backed mappings (other than shmem) we are
> > really only interested in MAP_PRIVATE mappings which have an available anon
> > page by default. Therefore, the VM_SPECIAL restriction makes less sense for
> > KSM.
> >
> > In a future series we therefore intend to remove this limitation, which
> > ought to simplify this implementation. However it makes sense to defer
> > doing so until a later stage so we can first address this mergeability
> > issue.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process") # please no backport!
> > Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
>
> <snip>
>
> > +/*
> > + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> > + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> > + *
> > + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> > + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> > + *
> > + * If this is not the case, then we set the flag after considering mergeability,
>
> 								     ^ "VMA"
>
> > + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
>
> 			^ "VMA"
>
> > + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> > + * preventing any merge.
>
> 		    ^ "VMA"
>
> tedious I know, but more obvious, IMHO

Ack will fixup.

>
> > + */
> > +static bool can_set_ksm_flags_early(struct mmap_state *map)
> > +{
> > +	struct file *file = map->file;
> > +
> > +	/* Anonymous mappings have no driver which can change them. */
> > +	if (!file)
> > +		return true;
> > +
> > +	/* shmem is safe. */
> > +	if (shmem_file(file))
> > +		return true;
> > +
> > +	/*
> > +	 * If .mmap_prepare() is specified, then the driver will have already
> > +	 * manipulated state prior to updating KSM flags.
> > +	 */
> > +	if (file->f_op->mmap_prepare)
> > +		return true;
> > +
> > +	return false;
>
> So back to my reply in the commit log, why test for mmap_prepare and
> otherwise assume false, and not instead test for f_op->mmap which would
> result in false, and otherwise return true? Or am I assuming wrong that
> there are f_ops that have neither of those two callbacks?

Because shmem has .mmap() set but we know it's safe.

I mean, we should probably put the mmap_prepare check before shmem_file()
to make things clearer.

We plan to drop this function soon (see above) anyway. Just being mighty
cautious.

>
> > +}
> > +
> >  static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
> >  		struct list_head *uf)
> > @@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> > +	bool check_ksm_early = can_set_ksm_flags_early(&map);
> >
> >  	error = __mmap_prepare(&map, uf);
> >  	if (!error && have_mmap_prepare)
> > @@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >  	if (error)
> >  		goto abort_munmap;
> >
> > +	if (check_ksm_early)
> > +		update_ksm_flags(&map);
> > +
> >  	/* Attempt to merge with adjacent VMAs... */
> >  	if (map.prev || map.next) {
> >  		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
> > @@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> >
> >  	/* ...but if we can't, allocate a new VMA. */
> >  	if (!vma) {
> > +		if (!check_ksm_early)
> > +			update_ksm_flags(&map);
> > +
> >  		error = __mmap_new_vma(&map, &vma);
> >  		if (error)
> >  			goto unacct_error;
> > @@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	 * Note: This happens *after* clearing old mappings in some code paths.
> >  	 */
> >  	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> > +	flags = ksm_vma_flags(mm, NULL, flags);
> >  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
> >  		return -ENOMEM;
> >
> > @@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >
> >  	mm->map_count++;
> >  	validate_mm(mm);
> > -	ksm_add_vma(vma);
> >  out:
> >  	perf_event_mmap(vma);
> >  	mm->total_vm += len >> PAGE_SHIFT;
> > --
> > 2.49.0
>

