Return-Path: <linux-fsdevel+bounces-44442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1345A68D64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 14:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C2588080A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Mar 2025 13:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3145254B1F;
	Wed, 19 Mar 2025 13:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XGpxTVwP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YVWwLc/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230B354F8C;
	Wed, 19 Mar 2025 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389474; cv=fail; b=N9l93STOKsrzGgQtCO+6CmKpg8JOvEt8twPTE7Xw493QUfaYiJtLYwskHL0Foj6/6c0+sunEtWn2+XJ6GKdg+Yu2DfQU6EtR3g1Di3ofVjGMvKAywNjoa7LmJUc1/B7svPgLe1idmxpoJ+WeSEI8f8YVzJRWqErPJABxOS/c2e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389474; c=relaxed/simple;
	bh=vAZu8A8bvkW/11poGS7DuBPu4o5gePFw0ZOaMHsd+dU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V5cqX2F4MDthLHimfalNFwrkVim3d47cG8bPGyD+wfl8kYUfdwKR10RJgmaDPAAl/x+NLQD65V7QCBKWUu2PX+gnDCBpzKVWExsa8x214xqHVN6uP3u4c8lqqJTg63xN3ldYUZZOfXuHDPh1OoicOqBD/ZoY73vfOVPCn8mSboI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XGpxTVwP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YVWwLc/m; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52J8hRET031228;
	Wed, 19 Mar 2025 13:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6iI+BG3MU4FQi0cyvnNYmFVLR0ijckXex3DOSRdbIB8=; b=
	XGpxTVwPFieoyRRhsIImF/LKCziylIFXVCQReghSbb7qsgBjtuGoZ8tmesyTVePu
	KJ1K3Hk77yTisIIFKS1TgdepY1fkmt4cn6/P/Wq9es3flpxQT0enWlIaWuSPiNlq
	zvHgpJ5j6dBaKD6/uXyALkCQZAO+dAjebFBGa65rgYONePk6CaunUsOf1OB1hPmQ
	4QNTb9PAiK1E0XuI273WIiv2eGyeHzKSOQqORk1tO5KSgsZkKMTSU+Od0oHobEnl
	doeCJ0LbHo2wPWyZ4LPi49IqwTDjaE94WZPcb51jp2BhU1JWfkY6Lf3nTCKpVZHq
	nQaPUGmQadwjg4PvEquyiw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kbba8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 13:04:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52JD0Vgh018459;
	Wed, 19 Mar 2025 13:04:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdmkb96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 13:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kw9D0/wfGmCTl7mMrJYT1hbQ8DwpNEdiT1iYQPL1uN+YnylAMNzE4MZIds1mXSoKwwK6QJSDPktAZ8jQSrqreL3UGXdTUyPzyt16GjID4Sqauo9YQuAkECjVC/5xRRT9krDGcfJBjITwPuzFyrSBRSjawBEWcvREKePhsX0rZ1Ue1B8iwUActCygx9f/Mo3VpI8T3iHStXMFuLZ1ajutxpiyFYBxngD3dyncVzfhlmR2pLmMzqOBim19xY+Jh18VlWvJ0/RKkCdWH/WskiWfKGwoxlr8C+H1OT7U65JxAwgjWpkokYI5PtskrG86zrZDK3flkBVqjcjRrlT0AtGWxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iI+BG3MU4FQi0cyvnNYmFVLR0ijckXex3DOSRdbIB8=;
 b=E0EHz2wUIiKWvGX6cp7PVGjnvbBod4yNUvlxUqlaCG5cZ8xpK6Xq3DQO//X8pNFTDpN6HomA4RFCiwhx7OBU8tw+/H4rYQW/etM1a+7itGbeYCs4u3VAk0afkvKJRwrHooggFXyHzEn61OMTstEnTFMUKTmIfP9ZtBvuirYs91pm7WYXImAhUZoaGDz/BUetnBj2dUIkXO/WT4IgQuBQvSF+WEGx48kDvHoQZDdJ5oL50QaETqKRrFIbU1k3WRmAHw2Q85kZqrK81mf+bOceCTYC+GIybWt1+PZgdE02LggEyos4EKSj8sEK/2uh0PWEvWxvcDHscVNH5rqhanEPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iI+BG3MU4FQi0cyvnNYmFVLR0ijckXex3DOSRdbIB8=;
 b=YVWwLc/mC4FqRRQRO6OwUHxFmBav/mXZbx2K0Nk58zBYaDtk3gukTtZoVwrIQ29JGiTtBTB5X6xo6ip4o1s0KlRrweNo4qLC06NsjLL/YWb8dmScBWM13sfi4eml/HlWiqQ/pILGFzZaAlQOB1kZLBNhEcnZqYX/TU0HQF0PCZU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 13:04:14 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 13:04:14 +0000
Message-ID: <7aa41f3e-caab-412c-ae53-9db4ae512a3a@oracle.com>
Date: Wed, 19 Mar 2025 09:04:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] nfsd: Use lookup_one() rather than lookup_one_len()
To: NeilBrown <neil@brown.name>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, netfs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
References: <20250319031545.2999807-1-neil@brown.name>
 <20250319031545.2999807-3-neil@brown.name>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250319031545.2999807-3-neil@brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0013.namprd14.prod.outlook.com
 (2603:10b6:610:60::23) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ab4004-deca-4957-8ce9-08dd66e68caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bTdZZ29wUFgycXhGSEJwNTFLNitvejVoVFc3L1RuUUZBUVJwaXM0TnRzenVv?=
 =?utf-8?B?dUtiVTM2UlJBdWdYazVuQlB0WHgxTEF3cGFKNVh6MG5NbDlBRmoveWNJWWgy?=
 =?utf-8?B?bXc4bjRxbzltc3ViNWQ4cHZlTHowWDlucFNIejFzanFVMUowYkpwVDF6K3dq?=
 =?utf-8?B?ZFZIZTliZEhZZ1A4eDBZcEsrb0F1NDZaRXpHeU8yUzhZOG96ZU4xdEQvREtt?=
 =?utf-8?B?SDczNnBqZHhQTldWMk1iaUFuK1R2WHAxNTZYQTZsZ2NsWDkrUHlmNDhVcGtX?=
 =?utf-8?B?YnQ5d3M2S1FaY09taVFHMkphYkFYS1I3Sit2WWZDM0J5WmVXVUV5d3UvWkN2?=
 =?utf-8?B?NnFvREdXaUxsUWx6WjVtRS9UeFFtN1lUZGxxbGx1T3RXY2dUUVJHVXlFN01T?=
 =?utf-8?B?dHBpamxJN25lTk1rQkx1aW9LOXl0NXB6V2c3Z2Y3cHZsZytVckRHZjJGMGFX?=
 =?utf-8?B?aEdKdWN6WUZNTEJPSWwvVVhIZ1FxTjFSMzdaRDVwb2pERjRyb1k2QXFtTlNn?=
 =?utf-8?B?cmt6MWhUTUlnekpEWG9laGxyanVzNldZc29oT1pLSUFpZ0J0TjY3aEM1RGUx?=
 =?utf-8?B?RDNKM1FPMlpjdlZXaGM1bkFqUERYQWpZWThtcGFrQ1BvNTJPb2cvN0lLa2dB?=
 =?utf-8?B?UG9xVW5MNzM5UVRTWmdLNWEzOVlBRzVqaDFNVnNndzNqMjhqTFlZNDF4Z2pt?=
 =?utf-8?B?NHZPY3lHQTd4bm8yd1NIeU92Snord0YwSlIyZW5wUi9wZnN3RjVXektUaXM4?=
 =?utf-8?B?ZEVUc3VwRUpWMkV2NmxhSkVPMUE3aDFjUTJ6Nk81ZTRzUHB0UWxDY2RvcmVI?=
 =?utf-8?B?UURCbUpVaWt5RnhEaFNuemE3TGIzY2Fnajltc2c2UXpjWmFGaXBYcG9jVXRQ?=
 =?utf-8?B?ck5OSXBIU093cDRaQVFncDRVWkMyNDJzU0NpOEprMHZOdlhiUmZ1L2oyNkg2?=
 =?utf-8?B?QUdFVUw1Q1loR3lCWTBZSW9zMnJ3SitkSWFleDFwcks3Y0pkT0VHRU14MFVq?=
 =?utf-8?B?U1BLNE5BSzdDeXZEYzdSWmtzUFhZdzhndkpwdGcwTkxpWllib0hyMzhDR0xY?=
 =?utf-8?B?Y3RoL01oM1lCNWdYV2RYQTRxU3V0eWZPV1NtQm5OYksrM2Q1VE85QzcyUWw4?=
 =?utf-8?B?TllLczNUMjBLOW1ML21HczJqUm9SNFZJTHdOczV6Szdnei9FeUtkaHRIS2VE?=
 =?utf-8?B?M1ZOWkV5d3MxVFJHZm9MTzVuYVkyODhseHZNRWFPd2pPdnA3bEF0UklvcnBu?=
 =?utf-8?B?dXNuUUl0d2NKY0RXNStRN1RiSUduR1h2R1ByajJWUTNKSDhKMmVyUmV6Uitw?=
 =?utf-8?B?UGR6WTZMTVYrSFlzKzlJNW4zMmROeTZXd2RFT1BzalZFUkc3ZUJnT3FUQmlw?=
 =?utf-8?B?K2tQckxCZ0tTUzFEOHRVZmRObUh4UG0rbEFjZTdUQk1DMVBiMFd4TElMU3B5?=
 =?utf-8?B?ekFnZjkvb29rM2J3QUtRRjYwNGtOd3l3RVFMdlEyRXlGSng5Y1ZEOXhUWG44?=
 =?utf-8?B?c3FMelo1RHdXL000Yk40SkMvOVJGK0dIakQ3aUN5MFZSWTJ5NTdnYnluV3Bx?=
 =?utf-8?B?blM5RXNhZW43c0xrQUtOTFZkUTJPekt2R24zb2pXaDlVN2orNEtkVUo1TGNW?=
 =?utf-8?B?Ly9NTkhCZndsd3h5eExSZVpuenBiRjVMKzZzc2QyQ0hBbkdCTERYcEJodjhJ?=
 =?utf-8?B?ME4xUWU2Z1BEQVlyemtKdWFZMjhISHVGMHFSMkt0UEVJS2JyOTFkaGxUMUtD?=
 =?utf-8?B?Q2pReDRpZm1sYVFUSkFGZVl2dG05RnhSYXNsR3I5blpzNWQ1QWJYZDMySHRn?=
 =?utf-8?B?TmZxdWkyZkdLaWNBa0dZc3p0eXJzNkdpMldPQjZ6VE1iTEE0VkRtRFNCK3NV?=
 =?utf-8?Q?dG+ee1URnTd6y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWZ1NmNBQXplRVRYL0lXRGpDb1g5Y2psaWNhY1NYN04ra3RPdEROTFlaSG1i?=
 =?utf-8?B?NExPaXZ6RHd0bTRES1FiWUZGZCswNXZ0cUVNSXg4cTh4dXZ6cGVPeThzTHU1?=
 =?utf-8?B?RGdURXkwSjJ5aGVwT3dzOHJ5OVdSeEx4QWpoc1dkaVY0NGVWaGdDMDVhUXBi?=
 =?utf-8?B?QXVJaDZ4bHhqV3ZQSTU5cXBsbDl6S0ZLWktjNmFvdkhzYVZqME1QT0p2dmZx?=
 =?utf-8?B?Wm5wbzRiUnhXMWxpNVJibXE2djVzM0s3ZEVSYXoxdFFtNXNVRCtlamN6bFpx?=
 =?utf-8?B?V2Q0YUl0VUpUeGtTR3U3UUJMK1JxZFNyWHZUSlVxUW5YR0lFSjgzc3ErajZF?=
 =?utf-8?B?WFBITjBZdzAyRnM2NTR0MEM1OExvYTJzZlRaS1hVOGlaZkxQWS8vNjBQdzlS?=
 =?utf-8?B?UU9XbjVweU8xRXhPemhFRlRrd21aNis1NkpqcjMwRktFNUVsTkZKT1pSaWZu?=
 =?utf-8?B?dGVGbUhkRnlLeElNbzF6VXB3OXNLRUxSQmo3S0h3cnBPL1NZSjVzY09kbXVJ?=
 =?utf-8?B?WmxObkp1UXhpRjZmazRJbDBaRDBnaWdFQzZGWHM1ZmlIb25KcUVpWUF6bWtV?=
 =?utf-8?B?SDh3aWs2NlJQS2tmdFRKWXBtWHpoTVlCRmpzOUdtWHRKa3dPcjFNait0R1Nz?=
 =?utf-8?B?UWV6N0lqbjQvOGtaN3dsUHNYeFFoRytQa2Z6Nk1GN1VoOVhiZHJaTzFLTmJq?=
 =?utf-8?B?MHZ5dkovZ2NTTTZTMk5BRlVEdktEOS9YWVVWN29FM1lYbzN1NkpkVHlCYjVY?=
 =?utf-8?B?ZzZQTXFEa1NHRTI1ZTE2V05VUllOT21zaE5zRFV5NmwvY0NocHJ1ZjJjcXRk?=
 =?utf-8?B?YXhONFNhS2ZydmE5L283SmR2dGU2cGFqdmlIQ2F5T3FLSEtsOTlNUWM1c1V0?=
 =?utf-8?B?bTIrSGFWaDVmbEk0Qld3SGUyWXFXOUZTNUZDN29nUGovNDNjVWhqVThPVzNZ?=
 =?utf-8?B?dTJBdUdXbVlFdXEwQkR4M0NjSXBPaldJeVdDZkVFT2ZyTWxtMlpqK00vejJX?=
 =?utf-8?B?eTNOdUZjL1B5ZE9Wa1d0dStsN3RsTnArT2hKamVIenVxaWhjQXB4M2dPQVNV?=
 =?utf-8?B?SVk1WHBwSnRBNjRLTGtNTHI4dngwc3EzcG1FczBHellGRkdiVzNEKzRqUnNB?=
 =?utf-8?B?ZVdtVHJwL3k5UHdLTi9CMDNZZmg2Z2k3cTdJcXAybVQ2S3BaOXVnR3BqNzY4?=
 =?utf-8?B?UE9zTUJYRDU0L25ZUGV6S1NsUG1jd2YyZUNNNVhjZkhaS3dHcUhlSFFsWFZs?=
 =?utf-8?B?czRZR1Z4d25ici9QUmlMK3lDWjQrUW83ZkQyYUpwaVl1ZnJlRGYrM3QwRE9Q?=
 =?utf-8?B?Z2pMVzYvbjBTUkFPdklBYjhYSzZId05HSDhpUFZWWjZjdEw2a05iTlVtelpJ?=
 =?utf-8?B?L0pGTThUU1V0Vkw3L1hPV2FZWU1PS2phcXI4UGdFNytPelBZWGdzank2MG9n?=
 =?utf-8?B?QktZRVJURFlzMmRsOHVDNy9QSE5DeW1kWFpvZVFwMDdqZjhuUGU1d2FOc0ha?=
 =?utf-8?B?TTRHYlR0RzlLWnFOYmZyQ2V1dHBKb2hic1Fkd2xqUHdCQmFqbHNBNm1TNE1v?=
 =?utf-8?B?eDV6UmtCd3lxNjRsVnVEMzB0N3FSbTNCZ2tzT3FMcXFab0VzU2RXZ3Bibm56?=
 =?utf-8?B?TXd5c2RIaVBLZzRsRkFoM1VxeGQ4NTZJZ3BrNkNiL0ZMdWlHOGNpVUlrZlRi?=
 =?utf-8?B?blVSQ0FyVkFYb2lST2VZUVRXcWdIaG1vZjZJMUg4aEdUamVYNGpCaWNvK081?=
 =?utf-8?B?WkpiSnNzVGlvS1JLdFp3WG54RHRBb2dObUUxSTJrRHZxYk1ubUVtWjBJQ1pF?=
 =?utf-8?B?YTFNT05CcUlNamtUMXptamVTU0hxTGs2U1RrUDVySXRsUmZkZlVCVDJNdi82?=
 =?utf-8?B?VmZxYUg3RmpoV2tRTklhYkZxNVVGbS9INUMzNnpUYis3ZkM4OUhZNkd3UWYr?=
 =?utf-8?B?bVFiemw0dDVrbHdRSC9FWlN4NnZIZitUeEZOYXNxNjBHT3VvZytIaVMydzZu?=
 =?utf-8?B?QzVBQzAxbmRWZGdwaXkvQjRuR0Y0QkRQclljUDdZbnVPZ3BSdGI0MmZBTzZT?=
 =?utf-8?B?RWkxMzh0bHArd25USzFlakxFOWdhVmM4QUc5MTNGcGl1M2Q3UDZZeGtPWEIv?=
 =?utf-8?Q?4ZDEBIp/dNLn0wisGhKteOor1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U12dO+z+FzQcSJJNZfCpXjk5qTTyvf6n0EEVCb9dkcrj81w/qzjGKd47TSP9mZnRIYPPL8yvPAnqkR4l6mlKVOX2ZfSeIS9w78ODofLpAidy24MJfHTe+p6mk7dCh6IG1GAXLdMnuu8UzEm0E6oduFKyFpjOxfT7wcZPtFuQjEUV3l6HYFbPmOJgSv43LFAQihKhpFgpsP5gfm0AopMV0iHdJldLsp8BoBu6ENWaIqEBHVnWBh46y8XMNfvnLN69r7kH7Jxsfv1vuay59caXjmH9U3rS2wsfrveAJyVFArlAvgi7DPF3V7EEUijD8oD9NXOipJ93GetUZcezlz1lwLQJ4BIYbg+j3vRmSGPDUkLugEZS88AQL6ire8iC5quaR4QXSyG0zegjgNn5KQItjy9IZKWFnhH0Bn9HnPfO+AW/p+qwHJ/8pDB/eVuq2/a0JNFu+A7oaf0QzxwKX1DbxVi04tAmq6rjq7wrMRPrBlCfVbn0RyJWhFS65k7y71A2Pkx6tGrVKoXdO9b5+e0BZItYW5t3OEv1wq1Q62jO2OJQUvPo2SdHk1oZpvt3hKlBdCz3MeO0kLDugfTZZnMgSMD5EYAMEoNwie0gIcsP4Xc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ab4004-deca-4957-8ce9-08dd66e68caa
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 13:04:14.6852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fFD8mC3EXm3xUa9JDuYlTjWGzq3vEeEwKghNIRH+YPc9pBHXbrIRQABmxZP8ID4HMcmBZu+ph8rsbcbntCKwDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_04,2025-03-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503190089
X-Proofpoint-GUID: yt50lrS_nhGD_nbf1smMB0tsMhxOgptO
X-Proofpoint-ORIG-GUID: yt50lrS_nhGD_nbf1smMB0tsMhxOgptO

On 3/18/25 11:01 PM, NeilBrown wrote:
> nfsd uses some VFS interfaces (such as vfs_mkdir) which take an explicit
> mnt_idmap, and it passes &nop_mnt_idmap as nfsd doesn't yet support
> idmapped mounts.
> 
> It also uses the lookup_one_len() family of functions which implicitly
> use &nop_mnt_idmap.  This mixture of implicit and explicit could be
> confusing.  When we eventually update nfsd to support idmap mounts it
> would be best if all places which need an idmap determined from the
> mount point were similar and easily found.
> 
> So this patch changes nfsd to use lookup_one(), lookup_one_unlocked(),
> and lookup_one_positive_unlocked(), passing &nop_mnt_idmap.
> 
> This has the benefit of removing some uses of the lookup_one_len
> functions where permission checking is actually needed.  Many callers
> don't care about permission checking and using these function only where
> permission checking is needed is a valuable simplification.
> 
> This change requires passing the name in a qstr.  Currently this is a
> little clumsy, but if nfsd is changed to use qstr more broadly it will
> result in a net improvement.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/nfsd/nfs3proc.c    |  4 +++-
>  fs/nfsd/nfs3xdr.c     |  4 +++-
>  fs/nfsd/nfs4proc.c    |  4 +++-
>  fs/nfsd/nfs4recover.c | 13 +++++++------
>  fs/nfsd/nfs4xdr.c     |  4 +++-
>  fs/nfsd/nfsproc.c     |  6 ++++--
>  fs/nfsd/vfs.c         | 17 +++++++++--------
>  7 files changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> index 372bdcf5e07a..9fa8ad08b1cd 100644
> --- a/fs/nfsd/nfs3proc.c
> +++ b/fs/nfsd/nfs3proc.c
> @@ -284,7 +284,9 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	inode_lock_nested(inode, I_MUTEX_PARENT);
>  
> -	child = lookup_one_len(argp->name, parent, argp->len);
> +	child = lookup_one(&nop_mnt_idmap,
> +			   QSTR_LEN(argp->name, argp->len),
> +			   parent);
>  	if (IS_ERR(child)) {
>  		status = nfserrno(PTR_ERR(child));
>  		goto out;
> diff --git a/fs/nfsd/nfs3xdr.c b/fs/nfsd/nfs3xdr.c
> index a7a07470c1f8..5a626e24a334 100644
> --- a/fs/nfsd/nfs3xdr.c
> +++ b/fs/nfsd/nfs3xdr.c
> @@ -1001,7 +1001,9 @@ compose_entry_fh(struct nfsd3_readdirres *cd, struct svc_fh *fhp,
>  		} else
>  			dchild = dget(dparent);
>  	} else
> -		dchild = lookup_positive_unlocked(name, dparent, namlen);
> +		dchild = lookup_one_positive_unlocked(&nop_mnt_idmap,
> +						      QSTR_LEN(name, namlen),
> +						      dparent);
>  	if (IS_ERR(dchild))
>  		return rv;
>  	if (d_mountpoint(dchild))
> diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
> index f6e06c779d09..5860f3825be2 100644
> --- a/fs/nfsd/nfs4proc.c
> +++ b/fs/nfsd/nfs4proc.c
> @@ -266,7 +266,9 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	inode_lock_nested(inode, I_MUTEX_PARENT);
>  
> -	child = lookup_one_len(open->op_fname, parent, open->op_fnamelen);
> +	child = lookup_one(&nop_mnt_idmap, QSTR_LEN(open->op_fname,
> +						    open->op_fnamelen),
> +			   parent);
>  	if (IS_ERR(child)) {
>  		status = nfserrno(PTR_ERR(child));
>  		goto out;
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index c1d9bd07285f..5c1cb5c3c13e 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -218,7 +218,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
>  	/* lock the parent */
>  	inode_lock(d_inode(dir));
>  
> -	dentry = lookup_one_len(dname, dir, HEXDIR_LEN-1);
> +	dentry = lookup_one(&nop_mnt_idmap, QSTR(dname), dir);
>  	if (IS_ERR(dentry)) {
>  		status = PTR_ERR(dentry);
>  		goto out_unlock;
> @@ -316,7 +316,8 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
>  	list_for_each_entry_safe(entry, tmp, &ctx.names, list) {
>  		if (!status) {
>  			struct dentry *dentry;
> -			dentry = lookup_one_len(entry->name, dir, HEXDIR_LEN-1);
> +			dentry = lookup_one(&nop_mnt_idmap,
> +					    QSTR(entry->name), dir);
>  			if (IS_ERR(dentry)) {
>  				status = PTR_ERR(dentry);
>  				break;
> @@ -339,16 +340,16 @@ nfsd4_list_rec_dir(recdir_func *f, struct nfsd_net *nn)
>  }
>  
>  static int
> -nfsd4_unlink_clid_dir(char *name, int namlen, struct nfsd_net *nn)
> +nfsd4_unlink_clid_dir(char *name, struct nfsd_net *nn)
>  {
>  	struct dentry *dir, *dentry;
>  	int status;
>  
> -	dprintk("NFSD: nfsd4_unlink_clid_dir. name %.*s\n", namlen, name);
> +	dprintk("NFSD: nfsd4_unlink_clid_dir. name %s\n", name);
>  
>  	dir = nn->rec_file->f_path.dentry;
>  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> -	dentry = lookup_one_len(name, dir, namlen);
> +	dentry = lookup_one(&nop_mnt_idmap, QSTR(name), dir);
>  	if (IS_ERR(dentry)) {
>  		status = PTR_ERR(dentry);
>  		goto out_unlock;
> @@ -408,7 +409,7 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
>  	if (status < 0)
>  		goto out_drop_write;
>  
> -	status = nfsd4_unlink_clid_dir(dname, HEXDIR_LEN-1, nn);
> +	status = nfsd4_unlink_clid_dir(dname, nn);
>  	nfs4_reset_creds(original_cred);
>  	if (status == 0) {
>  		vfs_fsync(nn->rec_file, 0);
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index e67420729ecd..16be860b1f79 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -3812,7 +3812,9 @@ nfsd4_encode_entry4_fattr(struct nfsd4_readdir *cd, const char *name,
>  	__be32 nfserr;
>  	int ignore_crossmnt = 0;
>  
> -	dentry = lookup_positive_unlocked(name, cd->rd_fhp->fh_dentry, namlen);
> +	dentry = lookup_one_positive_unlocked(&nop_mnt_idmap,
> +					      QSTR_LEN(name, namlen),
> +					      cd->rd_fhp->fh_dentry);
>  	if (IS_ERR(dentry))
>  		return nfserrno(PTR_ERR(dentry));
>  
> diff --git a/fs/nfsd/nfsproc.c b/fs/nfsd/nfsproc.c
> index 6dda081eb24c..ac7d7f858846 100644
> --- a/fs/nfsd/nfsproc.c
> +++ b/fs/nfsd/nfsproc.c
> @@ -312,7 +312,9 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  	}
>  
>  	inode_lock_nested(dirfhp->fh_dentry->d_inode, I_MUTEX_PARENT);
> -	dchild = lookup_one_len(argp->name, dirfhp->fh_dentry, argp->len);
> +	dchild = lookup_one(&nop_mnt_idmap, QSTR_LEN(argp->name,
> +						     argp->len),
> +			    dirfhp->fh_dentry);
>  	if (IS_ERR(dchild)) {
>  		resp->status = nfserrno(PTR_ERR(dchild));
>  		goto out_unlock;
> @@ -331,7 +333,7 @@ nfsd_proc_create(struct svc_rqst *rqstp)
>  		 */
>  		resp->status = nfserr_acces;
>  		if (!newfhp->fh_dentry) {
> -			printk(KERN_WARNING 
> +			printk(KERN_WARNING
>  				"nfsd_proc_create: file handle not verified\n");
>  			goto out_unlock;
>  		}
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 34d7aa531662..c0c94619af92 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -265,7 +265,8 @@ nfsd_lookup_dentry(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  				goto out_nfserr;
>  		}
>  	} else {
> -		dentry = lookup_one_len_unlocked(name, dparent, len);
> +		dentry = lookup_one_unlocked(&nop_mnt_idmap,
> +					     QSTR_LEN(name, len), dparent);
>  		host_err = PTR_ERR(dentry);
>  		if (IS_ERR(dentry))
>  			goto out_nfserr;
> @@ -923,7 +924,7 @@ nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
>  	 * directories, but we never have and it doesn't seem to have
>  	 * caused anyone a problem.  If we were to change this, note
>  	 * also that our filldir callbacks would need a variant of
> -	 * lookup_one_len that doesn't check permissions.
> +	 * lookup_one_positive_unlocked() that doesn't check permissions.
>  	 */
>  	if (type == S_IFREG)
>  		may_flags |= NFSD_MAY_OWNER_OVERRIDE;
> @@ -1555,7 +1556,7 @@ nfsd_create(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  		return nfserrno(host_err);
>  
>  	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -	dchild = lookup_one_len(fname, dentry, flen);
> +	dchild = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
>  	host_err = PTR_ERR(dchild);
>  	if (IS_ERR(dchild)) {
>  		err = nfserrno(host_err);
> @@ -1660,7 +1661,7 @@ nfsd_symlink(struct svc_rqst *rqstp, struct svc_fh *fhp,
>  
>  	dentry = fhp->fh_dentry;
>  	inode_lock_nested(dentry->d_inode, I_MUTEX_PARENT);
> -	dnew = lookup_one_len(fname, dentry, flen);
> +	dnew = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
>  	if (IS_ERR(dnew)) {
>  		err = nfserrno(PTR_ERR(dnew));
>  		inode_unlock(dentry->d_inode);
> @@ -1726,7 +1727,7 @@ nfsd_link(struct svc_rqst *rqstp, struct svc_fh *ffhp,
>  	dirp = d_inode(ddir);
>  	inode_lock_nested(dirp, I_MUTEX_PARENT);
>  
> -	dnew = lookup_one_len(name, ddir, len);
> +	dnew = lookup_one(&nop_mnt_idmap, QSTR_LEN(name, len), ddir);
>  	if (IS_ERR(dnew)) {
>  		err = nfserrno(PTR_ERR(dnew));
>  		goto out_unlock;
> @@ -1839,7 +1840,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (err != nfs_ok)
>  		goto out_unlock;
>  
> -	odentry = lookup_one_len(fname, fdentry, flen);
> +	odentry = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), fdentry);
>  	host_err = PTR_ERR(odentry);
>  	if (IS_ERR(odentry))
>  		goto out_nfserr;
> @@ -1851,7 +1852,7 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
>  	if (odentry == trap)
>  		goto out_dput_old;
>  
> -	ndentry = lookup_one_len(tname, tdentry, tlen);
> +	ndentry = lookup_one(&nop_mnt_idmap, QSTR_LEN(tname, tlen), tdentry);
>  	host_err = PTR_ERR(ndentry);
>  	if (IS_ERR(ndentry))
>  		goto out_dput_old;
> @@ -1948,7 +1949,7 @@ nfsd_unlink(struct svc_rqst *rqstp, struct svc_fh *fhp, int type,
>  	dirp = d_inode(dentry);
>  	inode_lock_nested(dirp, I_MUTEX_PARENT);
>  
> -	rdentry = lookup_one_len(fname, dentry, flen);
> +	rdentry = lookup_one(&nop_mnt_idmap, QSTR_LEN(fname, flen), dentry);
>  	host_err = PTR_ERR(rdentry);
>  	if (IS_ERR(rdentry))
>  		goto out_unlock;

Acked-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

