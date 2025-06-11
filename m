Return-Path: <linux-fsdevel+bounces-51326-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF1AD5866
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 16:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342D7188D94F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 14:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8828A71E;
	Wed, 11 Jun 2025 14:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iLyO+8l5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bkqsw+wl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9776D265608;
	Wed, 11 Jun 2025 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651491; cv=fail; b=IgdaXpCh+ByaG0521FI3j+HOoZCyXlXcXJOKMlvvUl/gPMJtJUIlx9EKWtG7hjaewKoDOoZojU28Not7zAKNqeiYu62WSN+dSddvZviB89sERe+pLfLj91oKyVL8GBYuCJcL7O+3jGtbZ6WTTsQMTB532Tzmk86NTGj7BJUweJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651491; c=relaxed/simple;
	bh=kXqmdEDa2ghYLOKEVgjiAZCBPFmh2iLUNVLKDNznSyg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/txU/UvfpRRdekROiPYAARS0LVXultMyJxnecYt5MzGdRZvC11zJFaDFPeqE9bi1sHhSmFCPdD0ffjz+M+bbQMeHsvogyMtuGkd2zNU6R1uI84+CIZ7HURYqOtwYP0TWOh9Y0ndLUzehMl+rTVIMUFF1un6R9IL2RAcdBxDfgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iLyO+8l5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bkqsw+wl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55BCtfeR029037;
	Wed, 11 Jun 2025 14:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=a2fbrpPradet57nzueo/Csmhob+NpR4Fh4oKIcGNFJk=; b=
	iLyO+8l5YlvaHAcKWftksDPa2y2UnK/crjk020rT9euAHg+iRpw8Iba2DbLuyoFC
	mj3/uSrL3fDznW3VfIwarCUunRBl56IlFck2nA+e+T9DBNdfNp8sGQYyJzBU1zk1
	6Q7tSKc6WdP0kyVt63OAyoo6Uzd7ot5PEGHR/vh9WS6Mfw4J89w47F2p7AqY7rDQ
	c9ygeE9jOGEiEqImyXgywgDs7lAjrLwjFuwkDjtq/Fvqc+Jp6qf0hc/H0uFegjOr
	cFj8mAqwydcOHhBl55Z++T4M1bDuZkrRacgBAsBuTDkI9mToooSxwV1LevBlYCnn
	dof8QL2kkdk5B5cejeREBg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474buf78xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:18:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55BEF89A007375;
	Wed, 11 Jun 2025 14:18:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bva0r03-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 11 Jun 2025 14:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YieEcE2sCR/s0mlEqsv/cKtRpLoBPU3iwN7/DdSgLrmecBOvFPUh1KjrqtwcBaNtkqpL0s6gSnYECTv+8XNAoNUJkuDI+C6E3WVq3aPS4rTI8VHSyRplLBAT6qREv9V6EObXVXcZpTXldgOG9lSIE89PUeeIfe2bKtfxNjCSTtDNwpTo9lwfWRUrXyph8P1oPdIuoMyN+5sD9VQmVR67TQltQCnMJn+MOXfHISjsaRf3lw/J2pbcs8w4ERva1Q2raNDDyfBKymCFP4JLbOloSUJqvIQtuDOdvSwYUPTnx9SmHxRUTDtKVIrsaCdIqv/hU/kJG4HJ7jThVGwAFE8HXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2fbrpPradet57nzueo/Csmhob+NpR4Fh4oKIcGNFJk=;
 b=wZmz5NfpQgo+5/+Rv2TbaP0LdmnQlHH6bf5IrqN3y8IOQiir35uapUKDIvRMrz4AHufesFqbF8cN7OIvQYA0Cp/tzFaRbhN2xXyA4cjp43PWjk8vilWoeNBf4lHi/XMw9jdOeIJ/sb6MDJtdMUpyX9FShGy7X1I4EQdxty6FKk9luHL/9H6Iw+eblMBBMAS+NZdYmWUH9sIeib63L0CiroWTF1ZRjAd6cUJ55PafPovsDEQXcILyO58XorLn4HgMlUThxLGu4U3vEP/yIbaYnc8y8N8EoXRt/7cnaP6a3318aj2WoOyD8SROcYILXp2VSBgCQBU7JfYYd/EpeR1LCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2fbrpPradet57nzueo/Csmhob+NpR4Fh4oKIcGNFJk=;
 b=bkqsw+wlTDcESsGDFxVKGDPSbkLk3DzkZfOGpg/4KTVECAxy0I21oRjdcqUYdy2IuaE7oQ58BBgefkxM+OqOtIshbAK1QWEfXtQrixZmg5XLJCVPLbyxWb39Dg9qoUEtvevaASCF7e7CJS8GG6o8879CZ+EV891dlC2wt7ztTKc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS7PR10MB5999.namprd10.prod.outlook.com (2603:10b6:8:9d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 14:17:58 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 14:17:58 +0000
Message-ID: <8c052438-7dcd-4215-b05c-795227d133d2@oracle.com>
Date: Wed, 11 Jun 2025 10:17:56 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] fs: introduce RWF_DIRECT to allow using O_DIRECT on a
 per-IO basis
To: Christoph Hellwig <hch@infradead.org>, Mike Snitzer <snitzer@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-5-snitzer@kernel.org> <aEkpEXIpr8aYNZ4k@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <aEkpEXIpr8aYNZ4k@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0037.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::12) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS7PR10MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d6f433-17df-4acf-8e10-08dda8f2c416
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?K0dIV0t1bVQxTGNnZVlaajlyaUtVT2hPNU96Ui9kRjArV2owZDRBYlVxc2J0?=
 =?utf-8?B?akJnQXFqVGluN2dSS0Uza01EUmlZUXRwNSswck54QVJSdlByNGpOUXZZdmpU?=
 =?utf-8?B?OGxhZS8wREM1S0xkTHRyc0FhQTFMUkU2NUQrZkdMZlJTY0g4K2gzREdlZzBR?=
 =?utf-8?B?MS8zNDh2VDkvK1dTQkdUbzg1a3FyNjhtN3dCS3pWcUdENUtMd0pNTCsvK0hx?=
 =?utf-8?B?YkRUZ3NQdUNYVWVEbVN1d3l2TlhxdXd1MEI0TkZMa242alphWDhXd3NPcVdx?=
 =?utf-8?B?aU5LUXpUUHNyZm0vWnJnR3lnV2pmdEpod2FNNmlucFNFS1RBUjBlYlBGTGwy?=
 =?utf-8?B?OCs5ZkcwY2FkTS9lam5wZGI1bUgxVG5CbTR3Wmd0a3hMV1IyMnhpQTVldjJD?=
 =?utf-8?B?RVo2MjkrcEtFZ09tVTFqNGdqcmpjalhTUGxhRXlZdEVXQkJwbEJWWkpiL3hi?=
 =?utf-8?B?UG1MUWZkK21wTjlwUldUd3N5YkpsZjgwbUxmNzcrNkc3dlZmK3pjb3hWQ1o5?=
 =?utf-8?B?cjdaU2xQUG9DRkllcVRHczlZaG5KS2M4Uk9XeVR6MHM3SlhaWWgyYzg3Q2to?=
 =?utf-8?B?aEd5N212U3BVQk9iYis1OFFLWlQvbzhVb0pNSXN3R3VDaXJuOXk0VmpJYld0?=
 =?utf-8?B?UDJRQnRhLzVnRXRlOE9EaHN5NVRQMEVBNGthUEQra3lYY3FtU0tPUjB1cmIr?=
 =?utf-8?B?cVpjRmZlalRuWVYzcnZ3MWI0Z2JYZTR0enF3dFZwUW1pTTIvQ1NZM0tucnRR?=
 =?utf-8?B?L2lmYUZxTWJsUkViQWU1OURTbmtSaGpPK3ZIQXBMVWlzL1hGS2VDVjRxY01E?=
 =?utf-8?B?a1EvZ21sMFVLNlhvekR4amhPUEtSWmN6bDR6Qk5qUUw0aG1rQ3RBWHEzZ28z?=
 =?utf-8?B?cC94elNpTlpGUWFkU2YzbGNZajZQRHhNcnhMQmNVSzFCdXVtV2x0cmhPaVRq?=
 =?utf-8?B?c3QxaTRTYXdlRWJwVzNFTkhJbzI4TklwTnZFRDhETG9GU3prQ1dNbGxEUWxE?=
 =?utf-8?B?OERGYVNHYTRQWlNkRUdrbnhobUM3VWFKUks3T0lFZEVZMkJQNlFpQTgzbXpX?=
 =?utf-8?B?b1lMaUdnNEd5VFV2WldVQ2NXaUQzTHcvYmFJaTZSd3p6SzdZc0JkV3JCQ2ZC?=
 =?utf-8?B?SEhoQXptSmc1SU5MSG02YkR1blpkRm4yOTd1bGl1ckljU1FrSk5IblNRbnhT?=
 =?utf-8?B?bnBWVHFiN2FwZW96amg3OWpONXhyRnR5eVIvbERKNk1NUjdpaC8wZS96RG1O?=
 =?utf-8?B?Zmg3TkUzVkhhWTBwdkJPSFJsUVcyQXN4RTRIWFZQN2NVa1NEdnZERDdZWDdT?=
 =?utf-8?B?Q0JCRVVmbDE3YkwxSkxoU2RZUVJDQ3NuRFpjMElLcnFkS2J6dHBHc1lZWW45?=
 =?utf-8?B?aFFtUlFvYUgrckFBSytVY3FlUndwckxXV0c2a0dzRG5aZnJiTlYwYjlMU29Z?=
 =?utf-8?B?SnByczNPY2JBeThjanJmYnR4ZWc2Um1LMmZHR2YrNnloTDExMlZvMm9ZbGJ1?=
 =?utf-8?B?Ym12TTQrekZyTmtlNWNOWXliUmRYOWEwbGhpcG94SlJKTWtiRzZnc0FLdGc2?=
 =?utf-8?B?YnBUZlJLUlZTblIwbmZVZW9meHNSbTV6Z1FFcDVtaHRyWHdmcVFIWUhnV1Rw?=
 =?utf-8?B?elhneXV1b3R0NDQ4aWJ3MXpoMkIxR0lBck9JcWRIRkczdkZ4cUpvTmNzQmVI?=
 =?utf-8?B?WW05Q3pNamxoUFVzYVQ4MTNqWmxWVWNONVZiS1VrODNmMVN6cXYyRVQxZkJQ?=
 =?utf-8?B?blpQcjFucFFBa2FBeW1sd2hEWkZVR042d29CMzhSZE9rUDNSTTRlUkpMWDY0?=
 =?utf-8?B?NVRxSWJWbjFONk9hRnRpcUU1VCtBNS9ESXVMR0xmQnNRZW5VY2VOd25iREoy?=
 =?utf-8?B?Vy9WS1MzVE8zVFR4TU53Q2x5c1FmWFprZkErOTh6VWVuQ0E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cE9YK1ZUT0h5Z3FscHBUVFcyckFNT3N6a2N1V1lxZGZlWGVJcnBMYm53Yjc2?=
 =?utf-8?B?RWkxVmVlS05taTk2N3dBM0NYc2N4ZHloSnZPZ0tIc1g5aHhkYzUvVFBsZEQ2?=
 =?utf-8?B?djZrR1l5djhGZFlYU1AxaEF1N1B4VEFKalNkRWk1WDU2VlphenF1RjJaQVV0?=
 =?utf-8?B?NjVkVVdmYlBKN082TmtSVFFuYkdzK0NPT2ltOTZZYkRjY2VacXdVN0J0VXdW?=
 =?utf-8?B?RFdLYTViREZzWG1BK3NvVUV1NFRoenFwajY5dzE5QVNFMHJ6UDYzczVMUHI0?=
 =?utf-8?B?ejVBWWQ0VW44MTM2N0lYcFNOemZUWFZiSGlWbWs3eTJoNjZpV09FeTVmQ1Vv?=
 =?utf-8?B?UDRPKzI1QmJhTlhoSk9hYjJCSmJoTnNYbHVZbTBrV0VrL0Fvd2FlclpFTVFB?=
 =?utf-8?B?VGFHYW5mTllsc0gxSUpUTVhyL0ZSNFl2QXEvUFZURXFEcURoSkN6MWtldGhn?=
 =?utf-8?B?aTVOVmRQYTA2YlRXY3prbFV1aUNiYWxPWVIvbjRKMW5hT29obkhlMlpxL0hx?=
 =?utf-8?B?MDA4RHVrS3BLOVZIbmFDUWxxZWFNc3pMUlVpUWcvMXdWYWoxWUlOZlNZQkM3?=
 =?utf-8?B?WFNJdHI1MU0zZ0xzNlpiVkJycXZRWWJYeTZNTGRWVjRJSU1wcndEZU9zYkhI?=
 =?utf-8?B?azM3Z2hnSVlVS2pMdzVjUDg5T2VkMzlRWENjaG9jdURFSzdrd00wVnlmem1S?=
 =?utf-8?B?VG5rYzNTNHVaZ0Q1c3l0cTVYUVFNNEIxQXVoMzZhZ1h2Nm9HWWN6UUxNVlhU?=
 =?utf-8?B?dW9md0orR0dzNy84MHNjQ1VBSXFjajNEUnJrcy9ucjV4Wno0OHdTN0ZQVUR5?=
 =?utf-8?B?ZlN3Z1BYcjNoNmRLWkpWTW9NOWlvcGQzcTAvbUJOYXhNRXErRTBmbFZvb2pK?=
 =?utf-8?B?dnJUeE5GTlZGd1V6bk1jZnhtY3RzQzd0dnpwVDN0T216cGZoNEJpQlMxTC8r?=
 =?utf-8?B?VHFsbThiSTBsVDgwcTRpVC9IZmM3Vy9mYWpIQnJ3NThEY0U2bU9MWHZRVmVo?=
 =?utf-8?B?RHlRTitzeXhyODgydjFEellaQXA0UlVDWEtsd2VGUHVBZ2JhNlBCZlkwcTIw?=
 =?utf-8?B?aElNQVpWSkp1cEdQVDVielJlU0RmUkY2ME5DR2xVTG9uWGVNbVhsNE1qUUtU?=
 =?utf-8?B?S0dJSElnUE5LTElEWk1aWGxJQ2hqMzlDa2hFd2RReEkvaW13ZitHNnhTVEJy?=
 =?utf-8?B?REMyVHF1a0wxUHBQcjVLaHJyanRKTXY0RDByRUJ6RXVNL0dKQ3lyQ1hFaW5i?=
 =?utf-8?B?UW0xN0t5bG8wVnJJRy83Wm53dWdoKzV1R01xWkxjODZ1ODdJL2U1dXRWaTRz?=
 =?utf-8?B?WU1nZEJJVWU0MWppTFprb1ZVYUs0OHdHbW9wN3lzOXFnb3BucFVKdFJyWUlU?=
 =?utf-8?B?RDFKVlhkRjQrZU1lbG05M2d6ZWpqM1pCYXFwMFFHakpPMGFsbkR2ZG95eklm?=
 =?utf-8?B?dGhKd0FXSFh3MlpOdUxNNDZGMEwyRUlqZmVLUFl6dnA2NlNYNEFINlRDNDAz?=
 =?utf-8?B?RjNFaGVQaEtzVys4Q0xhdW1qVVNNQUc1ZEhZL3V4NkpsS3A3cStPMEhXOW1j?=
 =?utf-8?B?YTVncmk3Qy94RmpiZXdRYUZzTXE5OTZoMGpiQk8xUU42Zkh3cDVOSXI2Ukls?=
 =?utf-8?B?VGlZZGpNU1diTTA3WW96QXc3VndWVmo5K2ltSDdCM1pQWUU4aHZRK0ZHaDJW?=
 =?utf-8?B?bkM5MDVzVFhLb0x4SytVWGdUUTVNb0RYdlB0NDV0Wk9WZXJhQ1hBWTFiUzgr?=
 =?utf-8?B?c0RTaUhLaGhXYW8rOVltNmVEcU1IeWY1bnV6Z0ZWTXVSanFhQTBZZi84OTNV?=
 =?utf-8?B?M0NIRFFzRmZ4c2FPRDBFRnVwTUw5cVgzWDJzSmVabVNnRjBQMTUzbWd0NDIv?=
 =?utf-8?B?blV3UElheHlwaWdFOTBKL3owWDVNZXNub3EyVDZxYmhvd3VRNUhiRUJQMytp?=
 =?utf-8?B?Q1ZMM3pDV1drb0ZBOGFQNzB2Y29ta01NczZMdFBPaXZRMEJDYm4yTGR1bThl?=
 =?utf-8?B?RjJ0WDFmTWkxT0MrazNxcllnOGYzdTlnKzJGT252blhwM3dsTDJkUit2cnd6?=
 =?utf-8?B?ekdlQ1FLRUk3VG50RFZLekFzMDErRFNtY3NGNU03QTB4Y25Kd0ZCdWlWWjdt?=
 =?utf-8?B?THdxd1ZCemdCclpZQmNJS2I0SWNPMU1BM0RMOC9YS2sreng0dVVMMGh5OW03?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JxBXCnQK8UwK+cuZBSoqDzbj5iZ5NgB/sEb/QxJTvPNejycobYG+Pm0QAK47zYd5jkHrTfLI6HSr0wy6RF1nCpqc+NoG6o8WUM9D6IwNFGLPzLmUHyZa3+bb1FpYgBjq2xFmQoPEldFYGl0CGcAnwpdajjmQIOx1vdMPfEdydVDmdBK+bY5Ib9KS1WNcTLUDz9wbD2bKUh6+chYTCw+HoJWDGRVwa6iJLQ2kaJ6xy7nieQVDXaK78YAAQb6eIIhn3sGOgukzsf0V9zS0AefQzMYF06lRZ3lrjzGbE4gLLXXdTZYdwV5jcVLXdC0SQ2WUZKBtgJsehLjDokoBhf+5gwfWL9h6PI6jDHCs0lDJQK2yDNFiAq/rrymmtUbLJ7lWWDxOP9Y3DxDwJyVftpG75EpPm2zcITrer0yyZIoaAc4EQq63+QEcWofx89b/dJIJWrTHcI0YcD+7JbAdAb1y5yZaPvRiTTp/tD8tUr9DkkVMr8FtxF6WW2nrhs5qpg49QvLoGr6Cy2NB/NleGkqWSTmqGTsa1Wj+sKsQ7gEMlGgZpmaYxwUq1QtN9MMAs8JvdsANnu59c+RTt4YUuvEB3ZUakdGTECijBqHqrkuArkQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d6f433-17df-4acf-8e10-08dda8f2c416
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 14:17:58.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWGPcdnwxuE9FKOX1zCgUjSUySovORCalCWie+1asTZGKbxzM5x6WhDRW2uPE1hHplKp+Ed3PFa33aBuxoCVFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_05,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=985 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506110119
X-Authority-Analysis: v=2.4 cv=RZGQC0tv c=1 sm=1 tr=0 ts=6849901b cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=dxARpheuVvzF51IcQ3sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: RlhPLIgdsqz5IfKZhJNG0weEfN9wRDbW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDExOSBTYWx0ZWRfX7B3dgoZsSvy3 bRzB7FdseM9G2JjwvCufExETnZlWPSRrmYSPF8BVzLkI4Z5TZ172ugb7wIrpNzw4qyUrvQvTqC8 Ld6dRmJOXNE8nBFm1sWpbXQ7/DKtF6UcyF3rrgysIeFZ7+zI8cI0B8aDLwT5ss6E7GXGDHBz9KI
 aFkSazdNR0mRoUcPsGouCmAcSGQE4hT9xXwCEYMIxcqMQGFDXfsXzFE4ZqtStBx4hjSfKXVT9gN C9VN6tYgIEaIyIWn9k3wzpXDitT3XeD0NrkJBLTQlLtjnZvHxhlCPNRA2I1unm0VP0Z2OFCS+QV gtEkolQJ07bjHh/QHcANzT7X2Zj0fH0d9SrBR4qvw3wK/fUjlV82gSD5uSpP4xgIQptYUBDaQuF
 pftEZwDt3anzOiYvno8t3eXak+kJPSupV+lDn3emEihV9CSicBCOPpzDsZJPQZeWE90SGpwQ
X-Proofpoint-ORIG-GUID: RlhPLIgdsqz5IfKZhJNG0weEfN9wRDbW

On 6/11/25 2:58 AM, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 04:57:35PM -0400, Mike Snitzer wrote:
>> Avoids the need to open code do_iter_readv_writev() purely to request
>> that a sync iocb make use of IOCB_DIRECT.
>>
>> Care was taken to preserve the long-established value for IOCB_DIRECT
>> (1 << 17) when introducing RWF_DIRECT.
> 
> What is the problem with using vfs_iocb_iter_read instead of
> vfs_iter_read and passing the iocb directly?

Christoph, are you suggesting that nfsd_iter_read() should always
call vfs_iocb_iter_read() instead of vfs_iter_read()? That might be
a nice clean up in general.

-- 
Chuck Lever

