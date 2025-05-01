Return-Path: <linux-fsdevel+bounces-47810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CDEAA5A6E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 07:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B52D1C0194D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 05:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D4231856;
	Thu,  1 May 2025 05:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gMKLG7J2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GvbYckHu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672F02DC781;
	Thu,  1 May 2025 05:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746075642; cv=fail; b=hEvu8Xldle4n19s48BLzFEGwS12XU3NStgfnpaggjFj0jaJqgyoI+plRCAVbQOplPbE0YjuZNOqNHAc8JzVE6drflNALp32IIc+cCS61DyQa9rA3l8c3B0x38W8GIt3z6771c3icIXpYjAhFnRhPNq2rBwg+VHpiyf/sRjp3m4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746075642; c=relaxed/simple;
	bh=hkPrprs8HcBR+n7DACToBrxacnwdxkxZPlllNmyYOUg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jZ8spMSyh+y9yYRUou7eezqcQ62TQ0IOKb+mT4Tcblh9eavfiA/3o6wY8W89Ms7hDuVtcbmWPN44OF4C/EkBjK0OFOEHBzwl0Qv8gzXmlPwdUG+8hfv5Wq2OwJkFOo11rAOZazjvgXUKsix6jqgeUeXizdAY/Iv6wDzUbo9aOl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gMKLG7J2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GvbYckHu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UKwSsv008763;
	Thu, 1 May 2025 05:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UvnnxQzpm5f7xZQ2vLF6boQ89JsFmqQ0jDKHcDNV2QM=; b=
	gMKLG7J2gWtGy+ARMjoZ5A1gb67siF6QawHoaAV/2TnbbPSPubltbVuqyG8lNlne
	pomNoRaT0/RqY9MY5vZPsjp412/Mmi5NO3cpPQheR8Ge0nviEE4AQR09TDMfXzdM
	shUBzI8hNze5pV1NqzuBiecCZrvJSkyefggygjXJfCV75NETIbJOJyw+QS4OK4zY
	6wABTs4OFGUvRplDUu5uJVQ+/DplEnA7jv9yQbko38isPYKk49DIQSYhOYsWbdmd
	SrChMs5i3h+Pte0y2pLPDfAsVBlLg/oovR1wEvf84QZoxxCJ0ON9xMGT7JbDVEfY
	ENku7mD+HR+Nyhb5YagI4Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6uujj7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 05:00:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5413vRRP001354;
	Thu, 1 May 2025 05:00:25 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxc6e1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 05:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqRq2gnAYMbmoQ/71FbJ8dtZFNq4RBmvA8aSNGB4SDh7pNU8HA0Gx8xIsHwthzAV6t7KfyoE/J2rBUkKl0EiRAvKSqjHwfERfj4lJNQ1EK6mCCMDx0gW2WJqfJC7P7bRUzmN6ApjkLEpIBjnXJtbr84JbBraU+JMoOgN5WCB2q007nkSI0T1r3d5uJiZ1x088J9JaPTIzxMnNGSih5yxQ/n3yrFwdeRo4uBD9ELn0xBV6C+qCx1OIIKKoCk0tRyKDeiNeyBeCCI/61g5EwH29q1SKh6VndW+7+EjfHAR3AWKwtZieBVNVovW6U2moqgzn6/0v6pSSCdFvcJQ0In38Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvnnxQzpm5f7xZQ2vLF6boQ89JsFmqQ0jDKHcDNV2QM=;
 b=W0w9Ps3hmvq8iWRFZmNaF7vu1u6th+A9nGc5+NKcj2Gsmv9OQesbvCBPY6T4tyqegqNjbdV0a5nCPqYthSg6/GGAfIbJT8VQG2Mba8UwMU1IGF8V/5CXQGCK1ztP7jNP2qlQTS7q7ZpSI0YgNSG24wej1oiIJUPt7WLJ5oY97B7Lbs3Cf9EblIUbpxFLXIp/pSrGahm4bZJHs7sPyQxYxoGYrQ4xwguQkKZR9aP6B6dyKUc5ZynGGKSxL6AAVa5WhJakCbWFdpRa6rKMA5veTUlkoTm8cfFda/bO3gBonz4rRJKffAwk86VpmcIown8/Bj56+ngUmjHVgPoIqnVs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvnnxQzpm5f7xZQ2vLF6boQ89JsFmqQ0jDKHcDNV2QM=;
 b=GvbYckHutGEPsudaTlBtfiyQe4j16oCUot54bCYRZ5SlUs+DfESfj/GMZ0+2T+HipJS2Gf8fFlvSyDGdEzsqwKsY8OyHIkqpyMKEHStIvy9/NcYJHSGRV1nAyrE1lCwuysBKoqFeZuKLJ+LjHrj4r7zmkxJAsg1YLKJYgN42SwQ=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CH3PR10MB7779.namprd10.prod.outlook.com (2603:10b6:610:1af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 05:00:23 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 05:00:22 +0000
Message-ID: <01f9a1df-859b-4117-8e12-cb06edee9f17@oracle.com>
Date: Thu, 1 May 2025 06:00:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 13/15] xfs: add xfs_compute_atomic_write_unit_max()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
 <20250425164504.3263637-14-john.g.garry@oracle.com>
 <a8ef548a-b83e-4910-9178-7b3fd35bca14@oracle.com>
 <20250501043053.GD1035866@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250501043053.GD1035866@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::15) To MN2PR10MB4318.namprd10.prod.outlook.com
 (2603:10b6:208:1d8::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CH3PR10MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: e016b9c4-c7b0-4aa9-fc1b-08dd886d13cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnBkVDJoVHQ1Wk9HeTBiK002eXRYVHpjS0ZjTk1SaXZyL1V5azZpdG9QU0Y5?=
 =?utf-8?B?K2JKRCtGcldKNlVOaDFFVEJmOHdseDNLTG5tdWs4Y3dpaTNzL2RKcDUwMHJG?=
 =?utf-8?B?bVJBZFhyNWtMTU1ydXYzazl6VUduNEFSVm8rZ3VzdktReTlILzVzVTlEd0Rr?=
 =?utf-8?B?VXZ0MWw5b3JPdThib0lYc0pGZzAvSUVUMVpxdnhnT0RBeEZhTWFRU2t3YTd6?=
 =?utf-8?B?RWZ3eFQ2R2o1bVBsQnVLemg2Z2JlcmJSU0gySlpCZjRwL0lrdTJCQXpXQUh5?=
 =?utf-8?B?QWFoRkRmSEx0bEZ4dkh4SUlia2hTRVVLRVlOSkNhYklCYTFlTlhBcFFoWGdR?=
 =?utf-8?B?cndyN09VdTV4NU9kcWlqSlY5QnFESk1PSE1taExhbzR4MTNJMDUwU1RMeFJ0?=
 =?utf-8?B?MnlCeFhXNHA4Y1VMcUluZ3V1ZzA0SmtlVUtrVjZ1a0t2SE9UOFhWZWZReUU2?=
 =?utf-8?B?V0R0UllNNlJVS0lGNVBjK3BtK2ZYeGZWdVN5TUhFb3dqN2kweG10dnBvWXdm?=
 =?utf-8?B?VXlYRnlObEhBV0JMc1J2UEtkbVZXaVN0c25yQ0k0NlM2RXlWaVkwSGQwMldj?=
 =?utf-8?B?U21aRnUxUEZ2eDhReDVWWk54YnVhUlo3MGtMYmlYcXZYcUNuYWx1YWFFa0ti?=
 =?utf-8?B?M3pVYVp3NlFKcDY1QlloSGNnZnZNbW1sL0YyYXBuVFNOOThUYlBqYjFvc3Nu?=
 =?utf-8?B?cUhYMFFrTEYvcENvQnVySURUaURGdXNnd0dTSGhwVElTaWlPWUtZOCtrMDA4?=
 =?utf-8?B?R2ZnemdaQjZObFdRcmE1OG5QcUNPVzNJTUFIUEtZdmRyR25SbWE5YmhzTXlE?=
 =?utf-8?B?NEZxdUFjMVpnT1FWYjBJY1B0Kyt2RHJQMkU0QnNaMThiRTg3M2lzTDVKb1lL?=
 =?utf-8?B?RktZVnQwalBDWlozdXlPTS9DYUNlUENZbzJ1NXV2T3NIVlplaDRBeDlXWGNJ?=
 =?utf-8?B?Q1cyZnVOeVNhQnExWGk0d3dvbkZjTjV0dFlTU1U3bzZnN3VXa1M2T3VDVjJi?=
 =?utf-8?B?R3NOZVdBSmIrZmZrRkxOKzc2dE15bXBydEVXQTJDcmhvUisremRLNEpjdUtX?=
 =?utf-8?B?WTBFbVJRczBEUnZvTFdOek8zRkpIUDRzV1ozQUdXYURncWJSZCtqS0Z3SUYv?=
 =?utf-8?B?ZTRxMi9CWHVuK011bGxiWWFGOHpqWGkrV3ZMS2dwUEpQYy8rSGxCSEVsU1Nq?=
 =?utf-8?B?SlBrazhEdjZ1bzAzbDVVTk1ScXc1ekIzK1NyVGFtdnV3dDgxaDZwWWUzc0cv?=
 =?utf-8?B?OHg2d25QRnY3NlFjY0dvci9pWG5veW1vbXl3U3Nka240ejlrUnFzdWpFZEk4?=
 =?utf-8?B?MTlHWUxIUm51SlJ0MXJUckZNalVOYjJaOGpyamkveGlmbUhjcHYwK2YyajJL?=
 =?utf-8?B?RFUxajJ0RG56Mlc2MWV3NWZ0UkNyZkY1cVNBeFNyTURPNU9oR0pwUVJHb0lp?=
 =?utf-8?B?b043aWVDaUpOaUd6dEVBc0ZDTjNqUkRSM0VHb1lWUVhybm82c3U1MWIrdFVI?=
 =?utf-8?B?b2ZZMXgzYlJXYlBOeVhwTlEvQTRERlk4K2RjSTlaRXJhd1Z6OXVteHhVenlq?=
 =?utf-8?B?NzFZNUJ0RUl5cUhwM1A0aGFZNUVJQkNROCtxZ3paanNKMWU4VjY2ZE5JYVJi?=
 =?utf-8?B?ckZ4Lzk4Y1Y3eStEdkk3c2RHeVBzei9CSEYvb1k4SzJid2Z2dFc5MnRaUGds?=
 =?utf-8?B?MXIyc3ZHZUh6WUdCemcyUEdtVHAxalJ2UHlsYmlwcU9TZDVqRFRycC95V0Ru?=
 =?utf-8?B?Y25iY3hYR0JiSXBZdUd5WE1iU0NWVEpHQUZUNGpqdXl2M0hNSmczd0dWaW9J?=
 =?utf-8?B?dEl1Zk5tSFZmSVlFQ3JqblE2UjdxcFJiUlg2YkNIb3NoeWtKVVNQcVJBVkt2?=
 =?utf-8?B?UUpSS2pPMDgzWW43aG5OUk80RjZyQXE2b3h5d2tSMlJzTVU2SkRKMjdVWHln?=
 =?utf-8?Q?hixOYmG4B2k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TE9CL1lIQ0YwS21OQkk1ZDJWaUIvaVFxcFM4bFlFclhXVUcwd2t3WGd1MnRL?=
 =?utf-8?B?SGtLbWEwR01sN0h0QUU5dGN3TW1tYXBjNTQ2VkZ3eUVmbkVPaGxnV2RPR1dp?=
 =?utf-8?B?eEEwdzEvQTJVdmkvZzVoZk1PdGpKa090MDY1WkMxMFpCK0prS0NYQVB0SCtn?=
 =?utf-8?B?ODJ5T1EyK3JJVUh5blEzbGNjaE5KcHBJUGpkNGVVNnl2K3lJamhPcUJhQUtp?=
 =?utf-8?B?dm9Zb0hkREFUOGpRaFNyQUlMM1Uyc1BOWlRNSXhSdThPd25IcU5vZTVuVTh2?=
 =?utf-8?B?cUJhcXg5QTlFTVdKM0FNSFJVbmkrb2RtQ0krdC9UN08ybkJPR01iZWJ0S1My?=
 =?utf-8?B?ZUdaL2Z0T2FPd1NrVFR0WGxwSVdEZXZMZTVoT0hsWHRKNkRLRGl0TXBzaXYr?=
 =?utf-8?B?Qk1XVG11SEpZam5sT2xBVm1mR1RQY3NyeHRKQkdrOTBwZ3VLVnZWYk5vYVp5?=
 =?utf-8?B?WkE5OGZKUG1aeVJpditmVWJ3M25XeTZaRHBDSE1pTHZxbUR2cTRYNzdpL3Ew?=
 =?utf-8?B?Ri9UUzU5UkEyMzBNQXJhSkRvazhYaDVla2VXQXZWVFFzQUdnSlR4cXZTY1Z3?=
 =?utf-8?B?KzNyUUp2c2RxQWdQK2dMVUdpUDltVmF1cXBrWjVhaERxNERHcjhPMWR2bHlq?=
 =?utf-8?B?aDhKTmtVSFEzbkZQT0psQXVPaEV2b0dQeUh6RXNGaSt2bHRsNzdveExZcnF3?=
 =?utf-8?B?RVJvRHhMcDBQdms0TGdvQlVaSElVMWdwSUZyY29rTW05NEJIL2JUcFcyQ0da?=
 =?utf-8?B?MTZ2czU1dHRKdDFWZ1ZmQUFYcWxrN1l2NmJUelZpTDVTTnZTRlkwbnowQ0dL?=
 =?utf-8?B?SlhoUkRoWEZKVjA4TTVJdnJMS2RyRkFEMk94VXdRdVlrUmw4NzhHejlSN2d2?=
 =?utf-8?B?YTBLQ2tKRWxzSTVHMS9IRWQzM0ErRFVBbkphOGowTUVGUkwwbUNMNVFqRTd5?=
 =?utf-8?B?TU9PNFV0clRyejBacEs3ZGdvNnNudDlZNEZRdkU5Q2R2WkNaRlRKWGhENXJh?=
 =?utf-8?B?Und0K0pOUTFsLzA3TnV1SUx0YjFSNExsUHhkc3RjWDdTbm1SMWwwbk9EcVVN?=
 =?utf-8?B?NStTekF2dk5ESWZNb0YwUzloQ0doUVIxdVVsbXkwbWhvYkw3bDczWW1UTjBv?=
 =?utf-8?B?MVBXTWhxN0llbFVNYTh2Q1lzMDVCdHB5dFJYdWM0ckdrRDI5WW1pcEU3SC9J?=
 =?utf-8?B?d092eG5HdzZaUVpJVENWcjNZNGlObDRzVGQ1K2RBclVHd2draFVXekRUYXhK?=
 =?utf-8?B?a29qdDByMy9oaTV4Vk0zSzhyMXhQeHBLUXIvTFFTdDJwQk15Z0Y0bDNKZUdt?=
 =?utf-8?B?WG14dXNrckNwU2ovS2pTUWxDVktXMEUvc1J6YW1yZXRWYXVyMDlSVzF0c2wx?=
 =?utf-8?B?aTk5N2o0RUwwWHc0SUZCODVsQ25VNzJ4RVFlOXBIYzhlMjBmcGF5MjNNY0Er?=
 =?utf-8?B?cGdzVzI1ci95dFBpUExWTHZDVkVuWXgrZkpjVEVOVHVRWldxWVVSQzVvOUdM?=
 =?utf-8?B?ZVphMmowdjRqeFJKeTA2eGFFa2YyQmZWRzVkVGRuSVMwdk9WVVhSTHZpT21v?=
 =?utf-8?B?WDV0VUJVYkpsb3dCZzlGYkZEYWFsQjg4Qk9iNklacTJ0YUpSS0tKdHFNVWk3?=
 =?utf-8?B?OG55aVdZZittM0lrMWxxU09NTlVoeGV0eFJSTTh6SXJZazlvVTcxWWZoYUlH?=
 =?utf-8?B?S0tNSjlxbjFJNEo3YythVXZIZ1RqMlBITk5IY0NZbllFYXRSbXE5Yk5LOXB0?=
 =?utf-8?B?VU80TU5FTEo2VjBlMjBVWVJsbjQwdzhOUEVwU214VWRSMVl0YUY1ZXpJOHNQ?=
 =?utf-8?B?ckg0Z3lQbXE4VUdsYnd5SWRnTHBRcUVLQUhoVW9raC9sb21YUmc3WWJpT0Vx?=
 =?utf-8?B?ZnFYRW5QOTJZd0U1TlFMbU5jTUVoRkRLQ3dqUENDN2hCMGJlUVhJT2RBQjVk?=
 =?utf-8?B?UVBUdFFRQ003NlJzdFZObVpSZm5keVVRRHF0aG5pcTRDdGRSU3ZKOFF2NVNL?=
 =?utf-8?B?MzVsY0tZUGRJMHcyQ1pCQWl3Y2hFT0RncW9jZE02bkoySTNzZmNJOW00NDAw?=
 =?utf-8?B?K0kxNEgzcmpzeVZ3dW10ZDdqR05XemRSdHhKNExLRnRaTjB2L21lem1UVHY4?=
 =?utf-8?Q?WZQlQbsiYdezbhzmjini1f+zE?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	E5+LXg5s5fvNwz7Ggy880un2gs1mWe9tyEhYcn0nfqB2keAOMhAt6BgtAIO3yIsboUAbZhjrTPbYoZwNBI1JkfwLGAvWnom50/iPjbDhbCCNNv/CMtLq8nc6L6SHkuffMMp7i/Tm0GH5xpRw9kR3TXXLFDn5Dq/eddU79wDINXNpiYibKg2kBEVd2BI5kIlh23e5TrSN+WcHkwi6P7M4H3/t7AZ3OeV3zYMXTMAR/tzLLJD4py+sIFLyKNlMD9UVZUd0Iszt5pA3YlyQV8dGQwCy3NLdUwYBBRf/qayYfyRw1akyo+RLMGSKXIMkc+EKNK26WfMDzgCCeYkzBParokoNpBtAyYV163ZnhaWpBsfs+lQ3dXuISRG9Ovhxd3MpoLiiKfDOIFduSmdjXU4MhgJLKo2lZj6nzYcx3xKOSpWCHcT/WTRb5N1JKBIWGKtkREa81Nn4N8PyWpsZpEmS8cxQinQcXPnDCjtqbeT1wb40z74LlbeDpHz7IEBpcRzyFntqRtS9S03zR665nz4VTeD9HH32k0OBNSzq++SYszGFJLFf6kf/B59ysONIARYwTdXLVR6VmG+Ex4WBBffOX+z9mzJFxTXwmfQRJgl5BNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e016b9c4-c7b0-4aa9-fc1b-08dd886d13cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4318.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 05:00:22.8081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StLAImBPNPFisvNHgyonf0lkR6IP/vfHR/PCDGpMOu3E7Xfkv36sId9ng3W3Bl0K7VbNjRLqFoYMIDi/vNA4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505010036
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDAzNSBTYWx0ZWRfX9n1LebJUSTuX vHqrT1twordLT+s1C26SKlm5u9UZV4HIhAVVvPBNnZ3tHfLHZZMeAjj8v6wNwaIWpLi2We++H2A QNi2bMYEOM4FhOaM8Xfusli+A86nEW0z04PkAjg/DcfIjn6aS4EdsdYrdi830jhzVFUsGFuNKLS
 SIqJGFtaFxRS0Uor54BqzIgypzyiNgdfoNegFe3ISWLprFisvJPS5dfhEZ8kLw+c0bkeK0yKKpF BHmxH/J/sBv/5UaGoSxR/fjfSVMLBLLsTJ+UY4TlXSaH/YIFeqRr0iTGEY/qkRom0rSewQgih+v OlRQTYFXqTw0xbcpPUmbZg8kK2CRuS3pkhrETxKFbrlFHTdh/bZLPaeBuxyZSRk9c983PMyiUci
 cpPtqmtoZF0A2ddFTJu4tGKImZHX/BNSFynwpax5ZEWV/YLpAGYvkfFvuYsJWvSs2NaISn+H
X-Authority-Analysis: v=2.4 cv=Ve/3PEp9 c=1 sm=1 tr=0 ts=6812ffeb b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=-UcyppK2H4f2PWgk2vkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13129
X-Proofpoint-ORIG-GUID: -YXFOHSUafi7V7My52BPvmLfeBwshxaK
X-Proofpoint-GUID: -YXFOHSUafi7V7My52BPvmLfeBwshxaK

On 01/05/2025 05:30, Darrick J. Wong wrote:
> On Wed, Apr 30, 2025 at 08:52:00AM +0100, John Garry wrote:
>> On 25/04/2025 17:45, John Garry wrote:
>>> +static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
>>> +{
>>> +	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
>>> +		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
>>> +	return mp->m_ag_max_usable;
>> I think that this should be rounddown_pow_of_two(mp->m_ag_max_usable)
>>
>> ditto for rt
>>
>> I will fix (unless disagree).
> I don't think this needs fixing.  If there's no hardware support on the
> device, then we can do any size of atomic write that we want.

Check man pages for statx:

stx_atomic_write_unit_min
stx_atomic_write_unit_max
               ... These values are each guaranteed to be
               a power-of-2.

Same is enforced for size for RWF_ATOMIC.

