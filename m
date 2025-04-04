Return-Path: <linux-fsdevel+bounces-45742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F489A7B9CE
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 11:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 800FC189AEFA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112A1A5BA1;
	Fri,  4 Apr 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GX99jYbJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VU3DdzdW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2C81A2564;
	Fri,  4 Apr 2025 09:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743758610; cv=fail; b=DvvJEI5EAwPnacCEluNbqbuZ5fsE38q7pop//Tf7f0dMM/uTNEp3vUpEhrZJRkXryp+gDrdEu99Cl1z640tmi/0NlYoyMERB4/eOn4GlT2IvZXEjzRGqXppUSLEDmMiDD2AJmhgeVKSpls9QH3Md52t9ltFDanK7P8g/+j4AZdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743758610; c=relaxed/simple;
	bh=9h6mxZn3tN6oVWADeTatghnaoHOSyBET94cYez6vxYI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oP5IbSF60v0navv3g0eir77VvFNSOLOIn2fTjdpdvawNWHzIQTPQI2MDIp3/+F7ypQ9JYjDRMthbvoNQeD8wNrBf6yzEFp5BXUopq+LANKE2vvbygKpHCTke0upFQowhfU9xqeTtmUwz0iw4jn9jFA5jrG732ny6XNHUL8fwqzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GX99jYbJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VU3DdzdW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5348NCR6001448;
	Fri, 4 Apr 2025 09:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=LYqxfvGE8do/VS2rpfrbqEqhK27JGrWa6WTLp1UDJa0=; b=
	GX99jYbJQKoiCekrBaItsJ4a+gNURRcIQSKJ4IAqXWOnf621WctoEl+bZLAt2A54
	fHVohaYENC1z0jrz2RHC0PDykfCzkN1nX8YrOVARjKzlNhA4ajViDBE6osSuQQnS
	SaXukQxiXNLgFeEnBR5GG//WglkTLlJLyFR1OEQCWvwLjRrB94oyTXtOazv5A7iB
	9RcqIpcvBGdEIwdtp6bAiUTrAbBKwsfl53gfvlpUAMKuvJQCI/1oEKdLAP6po40v
	wPsq3Q/AvpH/BHVgKlXPdcdL6jOrtplz138OLCjMwbx/ICcGb8VnOpaf+9qSelxY
	pak3pyISbqbksop3Cdlgjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8r9pc67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:23:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53480NSv017552;
	Fri, 4 Apr 2025 09:23:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2pt2qhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 09:23:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmCnwWnFQdgBn11S//9s9gap/e9XCTPljK/+4R7V7LjPMFgCvXwVfQZkVPMcCsoe3yC+3X9ckuHWwed6K7WvNt/fKeK2fSa7BuH3n8SVyfy84SbMo8+Kb7LuezCSmIWrWt/uN4IRapRLf8ZqyK6NylEUSmMkVhKrdCWWxwbBX7nNFR1WzDVjau+MHP6YRbr1KYjwE8tvQ/6uMKYzwSpiejGdsGEqvhM4Om6OARMAp21KVjktM80sR3uBghp74geuZV0OTQbQf1bhDD5+GYKUfwGzN9vDuYT0+6ZiJdf0bDXfyYSpP6pNJIfSBY/76X1S1EWuP4wkzsZ6AYzBg+bnTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYqxfvGE8do/VS2rpfrbqEqhK27JGrWa6WTLp1UDJa0=;
 b=yiP0fgB41uLL17uK/GUevIF193SJNoWIVSRXbg2Ib7CS9DWsMgoPQSiycW7+DH1kYA7DIJkJeyYqCwTcLfv56T5nBuij7tIQ2KbjgjQD4pfzkfaMV4BSkewmm80sZSVC+ASv+YaK+ygzciaQaOjlMXuFaVkPa7b1WtMiA4Mk4jtXBsE7VKObPuiuOl0f6/BTqdME62MkCPDFWNPZ3i5GfxiPQV1N3g8DnrHU28z/QvNCX5qfm0Yqy0OUStwp74EchukVh83RU7+J3VJD8xQ43T4fmGTFkoWY4BbdzsS7NwPv0duyRMysFE/jwqeWQBOgX+KusiRFnRVZkAtLx6adbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYqxfvGE8do/VS2rpfrbqEqhK27JGrWa6WTLp1UDJa0=;
 b=VU3DdzdWoRRaH56yJFfZ2RAY2qBZT1/b3cqBmsNEbPoc+c/XjXLqxP1+t7mFgdXYH9SLS7y/oQ1pbWGrlmg/QVtO6tOJSzVRITQ0agATBbavowA97chrzVIgvz+wDaD+Oqi3tdp2+dkcMuHQMBq4Puv4JFChqrbZ0Cu7umRCR1o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.42; Fri, 4 Apr
 2025 09:23:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 09:23:13 +0000
Message-ID: <aab0aa19-f279-42b4-9ab7-0cc6e2fa3b9f@oracle.com>
Date: Fri, 4 Apr 2025 10:23:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] statx.2: Add stx_atomic_write_unit_max_opt
To: Christoph Hellwig <hch@lst.de>
Cc: alx@kernel.org, brauner@kernel.org, djwong@kernel.org, dchinner@redhat.com,
        linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-api@vger.kernel.org
References: <20250319114402.3757248-1-john.g.garry@oracle.com>
 <20250320070048.GA14099@lst.de>
 <c656fa4d-eb76-4caa-8a71-a8d8a2ba6206@oracle.com>
 <20250320141200.GC10939@lst.de>
 <7311545c-e169-4875-bc6c-97446eea2c45@oracle.com>
 <20250323064029.GA30848@lst.de>
 <5485c1ad-8a20-40bc-aa75-68b820de5e1c@oracle.com>
 <20250404090601.GA12163@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250404090601.GA12163@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: f6ebbe7f-7b68-4870-e4d0-08dd735a5302
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckVGRjI1QUtGNVMxYUFKZ1RQQjh6ZmF6MHA2cm1ST1VxbTVHTXd3MTBlQjk0?=
 =?utf-8?B?bHA2ek5TRDZZOGRPVGNYcUV1SURqbWYxZ29laUFNTERLVzM1WXdJUTNxaU84?=
 =?utf-8?B?V0hHNEhBTGY0OHJwZmxIcDZVamNJb291dHJ6SlNjeUx3Wk05a2NsaU54bTM1?=
 =?utf-8?B?UGJ6SWUzcVc1ZFpHOUdnWVlrVEVDcW5wYWk1RXJDZnN5d3NROWtQVC9qRENT?=
 =?utf-8?B?eDcvaStFRDFFenROV3prdkZNd2NaeUl6NW5JcDVpVEdPS0lMZHVKZHRQRjZW?=
 =?utf-8?B?MEpHTzRNMDY0Y09mN2orYXZacTB4eTgwQ2hiSVgwMDljZ1JvL2czeldvdkRU?=
 =?utf-8?B?WWU4RmxmeFphdlJ3ai9SaytwR1lFU2M2VXFQdGlZcFRtOGNDaFY5TmZpTExU?=
 =?utf-8?B?aFdRSldaVjk0Vzg3Q2xxZWJDV1NNOEcyQU1PLzJ1Uk55ZXpHSUZUbGloa2tN?=
 =?utf-8?B?aTFTdVVxODdaL016bHV1b2s2cXV5dDkyU0pIWDdsYmtWOEd3dW1SUTZ4TGky?=
 =?utf-8?B?TVA2RVdIdit0VjhSS1pLdnFHb2szcXQvKzlLQlNnRFd5Y0htandkU0svQ2VF?=
 =?utf-8?B?dDg3ZDBvc1M2RUxtblV4bElyNWxSaG9uQ0c0STcwQWNRT01UWFRlOExMeG1S?=
 =?utf-8?B?RzFtZlh0RWwrWUJEdm5IdUNCeTVNWTVmZDBKaWdLNFpITFBmZk5sR3BwdTQz?=
 =?utf-8?B?czJKQjBZRXJWbk95OXErT0k2V24vN244cXFWUlBjS3l1QnZNQlNNSHNVMmE2?=
 =?utf-8?B?Rjg3ck9sS0FwcWVTYTRIKzVVbHo3WjlnMzZKd0dKdkZ6RTBjSzVpcWRQY3Mz?=
 =?utf-8?B?SGJBZzRoUnpzSFdZY0Z6bVROa2ZBcGFKMU9UM0cwdWd3NHRJZjBFUHJDZzNI?=
 =?utf-8?B?cE5NYjhmZXNjaW4xTiszWDJGTmVIV3VjWkdjQzBncXNKVE13Zjc4azZuNFRj?=
 =?utf-8?B?UnRIUm5qT2R3MmUwNXRtOEYzdlR0akZBcENmMDhXZ1QrVDZ6empwOFgvNklO?=
 =?utf-8?B?U0hhK3UwUHBJQ1kxZ2pyTThjT2JadXN1MWc1Q3BTazlpZ0ZROUc4YW9EbFJ3?=
 =?utf-8?B?TXFPSnVScFRvcnc0MEJSRDRCY2hLWWp6VWM2ZnM2MExKcURCbkk2czJTS240?=
 =?utf-8?B?cVRkczgySmpPNmdDOXZIMmJhV1FJbGJyVUJEZ1NJdUUvYzl1VTNLZUVUOEJk?=
 =?utf-8?B?RURBeXE0dzlSc2ZJWXRmRTdmV2lEbWtEeXhQckNoTHhQUlpBVzdFZnBlUElI?=
 =?utf-8?B?allWZTBBYUdQTVNZTjQxRmdmaFk0S2U1OXdqWkc1SkZjREJwdER3YVdWZHJE?=
 =?utf-8?B?S3lkT1Z6MWs3SHZRWTMxS2JqYnNDTVFxM1RSWmJKY29lZEpyWCsxYVUrMFZn?=
 =?utf-8?B?S2FreE8yMnFqMmppM0pLWWxpS2ZUenBjSWdpc2RYN2thRlNOZDVHd0lpYzhE?=
 =?utf-8?B?OHFWSXF2OEJ5clhUem9ESVZWK3hobW1RZVFqbGNDeG5JUGJOVi9CYXpzQktr?=
 =?utf-8?B?dElFYTRaM0VzeS8xRXRNQ0I1eXMzalNKRHBob3M1SkhMMHgzRWdtbU9LRmJk?=
 =?utf-8?B?dCtwSW5oc29hKzZMTk12STMrL25nYUhPOGR0aURKQmVwSVdSaWo5dGZlRTdw?=
 =?utf-8?B?Qi80dWt1MDZyc2Z6NTdMS3VYcHBuVnNkWk51MytmY3d4b01VbU51VytPaklK?=
 =?utf-8?B?dkpkVldXNHEySmNzYlBhWWUxb2NSUkRaKzlEYUxaOTdGR3Ztc1k4dTVoN0Vu?=
 =?utf-8?B?aVpIZ0tWU0xIbFF5aVFnbVV0V3ErVzU1dE1ZVkVranl1bjhiUU1VdkIvYlE5?=
 =?utf-8?B?eld2TEJzVmZrWGttWi9MbDJlZm54TGM3blFzbnF2UEMvbkVUTjliM3Bwck5I?=
 =?utf-8?Q?E1EhEp6q3j62n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clduTENUMlVkeTB1QTNid1FuVnN0cVdEaG4xOE9jcjVzcmJYVDBOUkxhbGRL?=
 =?utf-8?B?TTV2TnNJV0lhdGE4R0M4ejJTU0dodW5RSURxa3lHaWtmRUZodzFSS3ludWxa?=
 =?utf-8?B?Q0xZcWoxdXJsU050N3RFZUFFaHdOM0RhTzRXNHB4ZUdTdExDUC8zZHVPZkVY?=
 =?utf-8?B?VGdiN0toMnphRU1paUpWaUlIemV2QXNJSkdyTENxMUpMbXQrSkVTanRCblZ5?=
 =?utf-8?B?MzhEUjMrejliMmxOcS92WEUxSDZKU0s3dkxyeS8yQWR6dU5JY2c1Tm0rbERw?=
 =?utf-8?B?Y2svZTEza24zNGk0MVRQQUlFV1dJOUlEUDg0Y29VRk5IQy8rSnQ1TW15L2lJ?=
 =?utf-8?B?eVYzeUpLMWhhSlhqamZNYjIzODlTUWNuUVZrNXArSTFFMCtOVFExaTNSOUJL?=
 =?utf-8?B?eUNZeWJqellUelk4dS9HOWV1WFdwRmo5L0diN1M4RTg0MEtVeFhoRENYY3lR?=
 =?utf-8?B?bXRYaStzQXY0Q2xMYzVBNkNhR0RIa05XUTY5bmJJUVhJN3N2dFErZnRXZlJT?=
 =?utf-8?B?bWtmaWN6OFRHdXBLSXNQWGxWa2hIVmhpb3lid1g2blp2bkdwYjdRdEdwMlUr?=
 =?utf-8?B?RjUyYk40akF2eFJHdHN0b1kyYU82RHQvYkFPZCs4T1lJeDBMdng5Qk5NTW1y?=
 =?utf-8?B?WmtKb3ZkYktNMWhnVXVKc0xwOGhqTzhvTGxROHZVcUNZclFzZDRFTFNJTFV0?=
 =?utf-8?B?N3lpTnZsTnlCSjhXQjBuUWN6N0Y2WE5rVVJzdVlZRE5pZGFoR3BoNXJFL2c4?=
 =?utf-8?B?amhkdkZTaVBDQlM0Z3ZkM3VJYmIvTVhKN2o5ekR0RlNpU2xFemhTZEZBK3RW?=
 =?utf-8?B?Z21sb1dXSzBnVndYa1RxeWFuVnR4Y29xa0dVenRkMXRxSlhGU09WcGZVdmZa?=
 =?utf-8?B?Q3NLaDliSm56bmVreDhJZ012cVZwU3UwZS9OZUQ2L3lZVzByTHR4dmVJa0ZJ?=
 =?utf-8?B?S2hMMi9mOE1FTzBEczJCKzlySVBibEhaZjdKc1ZLSVhiRTRldkU4dk1nSmFw?=
 =?utf-8?B?WVVTWWdWRVQ1cDUxV2VZVHpjSUxhbkpMR3NOdWMvYXQxeCtMdVh2a0hMbUFT?=
 =?utf-8?B?eDFCOGRVTUw3UDZ3NHZ2bjh4RHVRUGN1S2J0Z3o2ZnZNdEpUb3Z2Y0VidWdR?=
 =?utf-8?B?TDlCK2xTNFlvTGUxRkdiMzFRcHJQWFAxM0dnQnVxV3UrSGFQWTVWMkcwUVVJ?=
 =?utf-8?B?R1BRQURhUE5zN1E5b0ZTU09aZW16bGxVTk54WVNKaktZRy9Wem8wWmJWcVBL?=
 =?utf-8?B?a29RVkRvQ2FXSlFpamY1dWI1aENkTTNZblFYNUhXSlpac1FOajVFLzJlQ0pp?=
 =?utf-8?B?Y3REMnFqbDdTdlFqSXBCTHV4V2hFWktZOWNCc1BZZENBdlppL2tTMVROUk14?=
 =?utf-8?B?NSt0MmFjQzZselRSZkVqR0JrUHB4TDRPYWtFRm1Gb2JvQmRrUUs1UHBWbW5n?=
 =?utf-8?B?U2ovblBHMjdIQjhXVHBaY056aXNHVWJodDltWnl2QjdWTSswWXpxeGVhODRD?=
 =?utf-8?B?WWVHNFk5c3V0a1BtdGNDcXdYemtoV2dHSS9TY0thTkRWK1QxRXdrTjhSQUFt?=
 =?utf-8?B?ejc4Y2VpVVNmdlE5V2QwUmJHRUR2TjFrWGEzUTRtWG04bHpsL29FeXc1UndH?=
 =?utf-8?B?MmxXSTBGU2ZUWFFDMTJIckNPZnBrZ2dBaHB2d0F1c3BVYllpZjFteVB1U3FB?=
 =?utf-8?B?aEVuYUtnbXBtUzZPWERrdUdRVlB2TEQ2UDJvL3JHaW4vM0tOL251WkV0Q1Rv?=
 =?utf-8?B?bXRCNE9CRS9mUUxRSFRmWmFBYnA2eVVzVlhqeW5uQnQzMU5xdVVyQXFWN2hZ?=
 =?utf-8?B?N3M0VDY3K1p3UmJhR0VaSzZkdkpGRkR3Q2ZoclNMV1g1VndPM2Q3YkVJWEVj?=
 =?utf-8?B?NE10STFXSHNQSHBGSHhybUZGSE1DU2xuZzI2TFRrQkdHS1V0UWdYcUVMS0ta?=
 =?utf-8?B?ZHBTK0R5eCt5dFZTT2FSYUx4SFdFenBBSndJL1hqMHpLL3YzU0gxUmVpcElo?=
 =?utf-8?B?UjgvMEVtYzFOTWo1YlluNXovUmlySzhVZTl3QTFaejdUNWw1c3lwRkVYUUZs?=
 =?utf-8?B?NkUwZlZvcjk2TzVRWmgya2xHWUFCTWxPV25KNjFhNTB2bDJlcERCZHlWZ2hn?=
 =?utf-8?Q?zYfNeT1neBI3yiLpyTspoHWrF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	25+na2zlGjSTiDCXqOuEE8eLhFJ9DUKHscsuQtazfgZ59yDqCBPJh/mkph/+saKzj9ORb4yyHLR+lFIxeN4fkg+lkJXVqUOHKKRLPGlqoDoTvMt0c6WIsmlX96VuCnpWUmqZJ55DfbvjqdRMxy2US/qfO31diQiiLr+jEVgnOXHuLGoG8dzo6t26vuWe28aLM/qjq7KVVEZvTZLS/WInSCM1jPPrM3u549i3tsjNOlaKEHf03MCDC/o7DDMgHOiEOwGQ5yEsLhSl0AWA5ef89GWA0CgRq4bPw2CGpKt5P5DwPtyiJdi8q79v3881ku+AV+MqjCA1IDUODkqRT177a4R7NspfsbG3qroIyk0Y+Pqxzj+cr6OOK1J88Ma52QpYJbBJR+MhuGm0zjB4btghiSkIussXQ9vyd0iVs+MrBycE4Qond6XyTz5njwHnP+0eCRStuiRlQS+JWqT3amj7ZGgSO/0B8VIG+nyqg1cX2AcH8ruFT0iyET5OATZDb0OE5lEsVSYuRko21yI9WH6Rx9G8x2RzxFxywRijwOb2bK4ojXMty4ATmj4jFffgEudlPTBCIb68tpLLrWOf/sTcyTSkHDRcSPkFYfuUrXBcjc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6ebbe7f-7b68-4870-e4d0-08dd735a5302
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 09:23:13.5746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQ4eCsdWpdMRWhQRE2fSWIZ0+dch+a2iHUvffcedE7kWhyTlnaVl6HUkZLsvhEmWjr8DbczOT7ZMiQAAFxGYlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_03,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040063
X-Proofpoint-GUID: BbkFLjxi-TPkMY0puMtdyD0iCLFmOUei
X-Proofpoint-ORIG-GUID: BbkFLjxi-TPkMY0puMtdyD0iCLFmOUei

On 04/04/2025 10:06, Christoph Hellwig wrote:
> On Thu, Apr 03, 2025 at 04:07:04PM +0100, John Garry wrote:
>> So I am thinking one of these:
>> a. stx_atomic_write_unit_max_dev
>> b. stx_atomic_write_unit_max_bdev
>> c. stx_atomic_write_unit_max_align
>> d. stx_atomic_write_unit_max_hw
>>
>> The terms dev (or device) and bdev are already used in the meaning of some
>> members in struct statx, so not too bad. However, when we support large
>> atomic writes for XFS rtvol, the bdev atomic write limit and rtextsize
>> would influence this value (so just bdev might be a bit misleading in the
>> name).
> 
> Don't.  Especially when you have a natively out of write file system
> that optimized case will not involve the usual hardware offload.
> 
> 
stx_atomic_write_unit_max_opt it is then.

Or stx_atomic_write_unit_max_optimal or stx_atomic_write_unit_max_fast. 
Or similar..

cheers,
John

