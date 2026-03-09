Return-Path: <linux-fsdevel+bounces-79728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFU/Is1NrmlpCAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 05:34:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4624233B1D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 05:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01BF53023DD4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 04:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0930F286413;
	Mon,  9 Mar 2026 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V8pEgAnR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nTQ7sRWx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D813915A86D;
	Mon,  9 Mar 2026 04:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773030846; cv=fail; b=tRKBIoaYHoEbyTUdVuWsc5DfF/sjWxAR+tYnD6O02ZNwepAE/dj2AlRLEmNQjlrZqvRDZfSnT7xunMkqjFEiUg5tD9zqm++4E1PS0/SSZfqt4wa2+lYTaZywBGb9YVyFtNwD2W7Ma+Zvo2AYHEBI+ybzCByJ9SFuz02WRTDAyCI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773030846; c=relaxed/simple;
	bh=4XAoCCWIZBqz5xBcFyR+rcRsGTEsrdCsh+M4YtjWomQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SGOOHRThpiQyqjWYNDGO2GaFj6Sax4+YddmNvlp1V1mjbHrxxTaGoiXdW9CRfWagHCgmtlOjLcUK2NRQosEl+FbevCnOyGujsxy3u6MJD3//Sp12MaYpAhU4HmCUH6RLh9NEyyBI7TIp5gvIU0q7NSOuo86xw1mRaY6i06k1o3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V8pEgAnR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nTQ7sRWx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 628Nt1TO919841;
	Mon, 9 Mar 2026 04:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ncwKmqm8QRWmA+ExekKPwrnAasYkjZc8P80yMVkdKGk=; b=
	V8pEgAnRVaBpR/PccUb6dOAzI7PUllpsRE0Y3FK/yHy5yahpva+qp1nyNgM1oHbv
	du+4kXJK8lUOeik4yT38a5fOZz/GrPwVvvp8A9LNj3TNGiVM1nXzqa6s7vDqQs2z
	C6bPtPmmJSlxlUcYBOhMutj/kvedgCe3RkNfmhgouFWbNaHAth/b8usQW/wxgH+0
	9suR+PEXKg0Dp3/2XJyWiqnFKme42WE+dEHwoZMFYbF7wbdRxZSJ2e7ZaMMAH0Fx
	ib7AW0PVnIVe3CjYKBVXP3V8nTcQf/rSLFBFqb0VcWPnfBd0JdyzcwBBKt3m6vW6
	prKOYI8D2etShkDOTZnR1Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4csjnug5t5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 04:33:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6292P6qk039578;
	Mon, 9 Mar 2026 04:33:41 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf87208-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 04:33:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY2kzj5RZr3CsVcrRQBcHVU6QZhE8QOfXRi+to5iGqNAsgacJKBIbxFfzLa1SjT8XLSMh5UYwuB2nwCJ642ovd26bd5J8JCBUUyz/4t7WdxeRmRmRZtWJyVtall+zCKq0U/eO1Otq9HnF1Ko48fjO2Fm61HN2lDHMcBrVhdCsKNWKCNd4zLx2d/qZMrot9I6x60UBIKER1riZ2SANHKgpOoc+F9FutSOmF7eaHpePenOGA9GAEob/Jl09PBUXAIUAlO345fFDwijbMTG0sGbssBtmHzw6207zO5l1iI0CzPnC55mCIGHkrErWaNsC01MTTN0pgBmy+lNB2F/334VUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncwKmqm8QRWmA+ExekKPwrnAasYkjZc8P80yMVkdKGk=;
 b=SRCPjhJMEsnhbPorH9npqupuQtrnkhNE/9GL800uV9bByAnf6tKoQihUThYdd9Qkb3J8UGt2JSlLiE82mIH0YRDyOfP22pe1L3YHhQfrwu9dtFfRKZJBfPsGrNbKZCmO9tijGPMI74LuG+6J/DXKU5Q9Us7New4VKu8LmtknV7dGfbBv+ChPuc6GaOLrKr0bvVdzItmwe9aXA2iQXU7pFksvzltt+dVI71ABy8ztAEaqxk7xRQZI3bBUU4uZybq1iZW1teE9QZtJuLTnmyEEEl0AJVw6jKtTSXSArY0QdZvFh46Oh06JNVs9d2TfL5HqzjJjnDRRTPMhYFQITvKupA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncwKmqm8QRWmA+ExekKPwrnAasYkjZc8P80yMVkdKGk=;
 b=nTQ7sRWxm/6rNKX2a6Jtt8u6TX7foNgTYSiO8WF4aXh8NEp/GQopS5Yit41OrzC47136k4qaQ5i9LJCdzVzKR+ucYszlElFsJsLcEcqDYGAOf5k8ak83VTO7Irnu9kyoLugRGe5DkGgnCUIFNOilgurON/NtcqLDIRoLwq6KwmQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Mon, 9 Mar
 2026 04:33:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 04:33:36 +0000
Date: Mon, 9 Mar 2026 13:33:28 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Zw Tang <shicenci@gmail.com>
Cc: Vlastimil Babka <vbabka@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>, Hao Li <hao.li@linux.dev>
Subject: Re: [BUG] WARNING in alloc_slab_obj_exts triggered by __d_alloc
Message-ID: <aa5NmA25QsFDMhof@hyeyoo>
References: <CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPHJ_VKuMKSke8b11AZQw1PTSFN4n2C0gFxC6xGOG0ZLHgPmnA@mail.gmail.com>
X-ClientProxiedBy: SE2P216CA0142.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c8::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 78acf538-9052-4ee9-9dd1-08de7d9507b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|14052099004;
X-Microsoft-Antispam-Message-Info:
	c/DaA4uSH/xPoAipJCLezYC7uXOh9faksgoslH9u11accIbvNBYi2XuGw89X72eqnh1HUUN0oKGEsE3ra4jbIClVlHmxnwI+E0gWYljoHjiomQtf/0w8rL0BDSwq3KfSKpFeJoK4lOawhamGmMl7B7Wxkzzn15AiRGq+q6OmPfZdkaWz6M29eN85YAVdjahvrt5TzvtXoAy84qjnKTYQu6In9szRmN0x8ztce4h0SCqz3KwOldO5Eh+S2q+ZR2cU3whVrBShB/cAY8lOBdxntG+0vvRRdTfaicOOMDKI97TExBH55c0sZ/bRuvHpeyE1sKqkBovipCIgCCRx0p3MZ2wm3JWKHF6SLAuJiOi49ygyDRDNJHW7AuI8cyN4OmEJN28dUuwZNlGyQQTd9ipWH+LOnqfHbxla6aFDqW3vb6Z9cBJ6hsWqRhY3Pb4Cve42iUxKJrjgawUwWz5sJr4mrK41C4kzE6MfE6UuXp2Y3PcGsPDhKW5k8i7BtRmGG/i1sMt+t/rjhQj3osxcqAF3CUl/hhuw5EhAhXNaiBiFNQtux5zYjp3ZrHNWD05n83wSJo5bsnUjYoUKjsujKKCohqOnkQFb7luxpD3F9dcRBqoNNt0CmRSvb/kFabt5QA3qFjiz/Ce+t1rIYTfIoKidvwgydqeZ32LDu2ayKYvLInzMitrEccCS5iG9tmyepVAn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(14052099004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGxLbS9ZMXhPejd0UFBCbWN0ekhhbnJMUkh3TDF4VUVBRmJ3VjN3OTdyN2Rh?=
 =?utf-8?B?Y3VXa3RCQlEwbVMxV2ZBTDlOSGUrcXhqcnVkSUthUGNxbnhiZy9hVXdhRWJa?=
 =?utf-8?B?WlN0ODJYNUZzVEQyc1pWY3doZzM4UlBmeWdyRUR5bWIrNzQxSDB4THlSemFU?=
 =?utf-8?B?OGdKNEZHK1JqOXdGdGYrLzZuNlV1d3RJZDl5dmdRK2NOMHlHM3dhWUE0ZDJG?=
 =?utf-8?B?U0c0MUlxRzVCMStkVW03aDNRTjk1WXR6bjdrc2xXcDZDOEFSMCs3S2lJcGR1?=
 =?utf-8?B?RWNBQlRRNTZFN0VnbXpjc1VEL1RJQnFCSlJVVWl3K0JUNEU4MHdJdnVldFpS?=
 =?utf-8?B?QnpsdS9CYjJpOHlwa083QURBTHhIWWdsa3QxSnBlczdnQk5GVFVmU3YwSE9q?=
 =?utf-8?B?cHM4NzZNSkZGU29KYk56dmdQMytPVTVqTUs3RnpjL09mOEFzcVU1VCtkd3kw?=
 =?utf-8?B?M1ZJeXlQeG1YUWUxOHBmdm92VnNCVUdjYWJCSlNPSEZRNWNMcFFZT1VqMlpv?=
 =?utf-8?B?c1pwcUNSQ3lDeUR2c2FncEdNWTB1Y01pK3BkYnA1ZzZ4QiszcFpaWE1hWDh6?=
 =?utf-8?B?REZvbUN4Zm9JVnVRekFSRUIzUStqODlqNnByS2hqL01UWnpmMHZiL3NNWFVI?=
 =?utf-8?B?WXlZYnlDd1dCRjljV1AyQ3I1Sm9wMi80UUszaDN3UlprOXpuVnBENVFWekVO?=
 =?utf-8?B?c1o2aEhvditJeEZ1Q3RtcmRmNGowd1JvaEtveS9FdW42QnkxVXIyU1o1dURY?=
 =?utf-8?B?VVFsN3dvWWtnYVpSZXhkbDJyZzJNU2xxYVdqY2F1dFJQUHBPeUt5NmFOYVJJ?=
 =?utf-8?B?TjRtdm83WXFKWk5sWHVWWm9DU0g0eVQyVGZmc1BSTVA4Mlk4NFZTU1o0OXA4?=
 =?utf-8?B?dEVPalRqeW1ncUdNMlIxeDRhNzZUWnlIREk2bnNNQlJtNko1NW56bkwvVlVR?=
 =?utf-8?B?dnA0bkd4M2xXc3hGbXJBODlQcFpoN0hBZGtCMDRHUlhBY2NnRXBoOE1tS3pU?=
 =?utf-8?B?TUtTbWlYTnZoNTNJVnVBUTNHZnVJYXhMUmxCRTk2MlJBWmZtM0lEYmVxa3ZV?=
 =?utf-8?B?MWEzc0V2MStsNmNaWjhpcFU4ckFDRTY5SWkvRG1RSUV4bnQrNHdMMUtQK0hp?=
 =?utf-8?B?L2dpSE9rdnhtZjZJUlQrdGtSZTZaNjZWSTJ6cU1iN0xZeDFudmpDdXE1ZHNG?=
 =?utf-8?B?ZkYxTXNJbVJJaWs1eXdjczJqZFF1NGtDMWZDeDhRQXljejhmVHZUVVNlVWpY?=
 =?utf-8?B?VGd2WXBwZ1huU3haSzRqWWt6WlFhdlBrNjkwOXMzYktHdU1RRTRrdW5xTy96?=
 =?utf-8?B?bWg1ZEQveXJ5TFVGYWZWQ2sreXpCZEtNWWJHd2M5ZnJMWmdObmpNV09ScVNW?=
 =?utf-8?B?dG1xYlpXMzhadFR3VUNCMURYT1ZLUVBKSG5CZTVqR0tqMVRXdGxiTTRtRm42?=
 =?utf-8?B?eVBNbWJpbnN1N2xPOEhYNjBQU09LOHpzM1NwQThFRXlHKzQzK1JXQWsza29Z?=
 =?utf-8?B?eHVtbHA5WFIvNnNhQXJrN09EdmE1cUtpWE15dnZFTElkeXhybEdUaS9teW55?=
 =?utf-8?B?UEN2eTRoK1NvTzhCRGNGelQ1M3hMRytreHROMFNyWnhGRiszU0VEdkpSQk5s?=
 =?utf-8?B?VXpoQmV5MXZrQ2tBUS9WeEtFZWFIcVpzbTNvRnJoaDJQdGd4RTBqS0hKUFN0?=
 =?utf-8?B?dmFZNkpZVThSZWxkNldvejQxL0l4OTAxZllualM4WjdyZHhMVnQ4ZW85ZHJ1?=
 =?utf-8?B?bDM3cG8rTXlUS0Q4bFh3L2szeHFrR3pjSWFybVRVTk1WZms5L3NPMUhGT0xG?=
 =?utf-8?B?RXVEMUxYSkxYR2sxUUFpYjBML21EQVBaL1Y2WWZJbFB1WkxkTkxBVGZVTml3?=
 =?utf-8?B?S29YRHFVK05HaklJbGVPK3BKckVwRG43SnVBemMrcmxZb1dndVliYlhDU0U2?=
 =?utf-8?B?YnhsQlpqb2ExSzk4WVJLQkhsdWFKSW1uRXpHbjhmWE1KMkN6REZXdTlIeU41?=
 =?utf-8?B?dXJYdDduNUNFOWgycU4vMnZSOWVsMDYzMHBMb1RNNlgrc25RM3ZnUzR4aDBL?=
 =?utf-8?B?TmdnMmd2ZlhoNjBoR0lFNDB5M2lsQXRuQ2xNaHhCY09DNHhJMmVodXNjRHJs?=
 =?utf-8?B?ZXB2Z1lOUWVhV1l4OWNQdE02b1hLOGM0c0ZicmpqVTYrQjljV2NxZnEyUHl3?=
 =?utf-8?B?RlJwVTdHN2NjRk5Eb2V4azVGZWk5d2tibEJIeTBybHpMb2dTRlY2aUxYMi9j?=
 =?utf-8?B?UW9qR2l4T240N1pxZ3EzVnJoOS9iWjdIc2JtNnE2QXg2U2RNRml1R29MZmE5?=
 =?utf-8?B?c0lBeG1xbFpxZm9jLzVkWTNCdWxFVGw3TTlhMzQ2ZE1LMjlVb0Jsdz09?=
X-Exchange-RoutingPolicyChecked:
	QhrYF+T2xoknen47jMydUbxUaGiNLiLLAUKnjhbbtrfF8wVKHP+xeOxOo/AkEqT0W2z/pkvAyuSbh/Vyjo5kfgDSnTybS9SczgO5DknrMdyg62uP0UWVUXROh7fPBe1ajlpoPVxcf5iWas4XitlkEkHp/wa81qsmdY5+n2nebYzxyjPviJ/tiC+LTCQZI1OtY/Y4myXgIJXP2jCj2HGsbjV5u7aq77EPp5+huTORkuCcMY8meSahtwc7hzwNikqaCe1wJ8E+pzwAyGAeFkLu0xJuZmzKYjW40Xv03wZpLv/YR84uaW+whCxBHZfnJAnYVY2n3KBkTO5uHmHhaZK1lQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H70pPCfmqdl+MKdiMTq0wvM6LZHEKzo4GVNskGft9jv4zjuJmEDds54Xvd43dd7MiyL7b30D89JSwyF+2qWNnsou8TgMcSXuHeTndIpjCfiOe0bbgEs8IrUxKbrSO04r3KEuCUxrubvOdT+g0c+XlwMTO8aXHD7ZBfsMk/6EdT2G/KjQ1XymXe9KcPo4nLHuzt/9ueP+0ZLy4CRpUssd+aTxogwYcCwqkClrQhCTYL4otLMR2Uu+Nu/f73uXNWwHC3JUd3vgepK6rBKRz1zceCflBburhKbYOdeQ8qb8Df1nqhEtYNzArrZqTNaYnN2gVwfJEWw1DQotkp/tCxHp/WBjFRcw3Tmr69WugR0KrYvmuTXHsRNn82oi9cGcmV+fYR9JYwZRYnYTs9EMtAG6kYB2KunNC4OkcR6qVBeiEtC/EGg/RjzqGX36XeuJJq7TcHJdljRjcrliCALgMaUy+GIlba4+9ouH2acQTnSVeQeAT74zemmK4K/8tscwC57BK/EVgOSxtR8ODfZdltFWN/40qPC1cx2l6nYACzNiDdwW7N5jq0dEBkFGWzrpF6kBugP50lEI4BIYg1U2/b5d9tUPdz8s9AILJc5kVIA19kw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78acf538-9052-4ee9-9dd1-08de7d9507b0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 04:33:36.7230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IOq7Z6frke6LG8KIqLc78navcxi3TTYct2Gsn6kpUxc5w0hoGUAVe2OmBu9RmSRTCBoi09aNAPFwoWBSqcfK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_01,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090040
X-Proofpoint-GUID: wUgAYn8yuiKIvsD7Mr1LO8qQv8u2oS92
X-Authority-Analysis: v=2.4 cv=c7WmgB9l c=1 sm=1 tr=0 ts=69ae4da6 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=L2YNdeTNRC4H0Xt-:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22
 a=fGO4tVQLAAAA:8 a=DnvfMoujX6-V84MCrxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDAzOSBTYWx0ZWRfX/3D2cfOaojPc
 NHVg7+5VEkrxMvlf+9fNxRIkYdtf+qEFn3VMUc7rqHO2pvVFA4uBnBfOp4s6zy+8YT4UX0JxKz5
 mmBcPzWrfJ5w31OXVBb0ajCnUbGe2bN9SVx2/IUbFxW45lQrbo24/sch5aoa4QK2F/KErsfp1UN
 YG/zYPXOfOGu53pOpjVaD07nr1T7M5FvSktK5hYSjg/Btiu8p0pdob/0tGfMNxFspyfLujLU1fM
 qEfjoSXrM0O70SBYVHjYOraBjjbFaLZEyYaOfKbN9dikzLmNB/YqpxLX73E4tE3BaOaom9tAdRJ
 oNencPowpnUEvH7TIOfd6CrDT763C1SmIjPSMEOVRYsFdeGQySUGzai+p4PqV6yrkXxtka93EjT
 5RPpweshs3UT5MLk3F1B4IlDPRYliWsgMtIsEuQzBDokiqk+z9lR2REMRGqkmYqmozaMPzguZyw
 XqxSVyZNm73sJim1BLw==
X-Proofpoint-ORIG-GUID: wUgAYn8yuiKIvsD7Mr1LO8qQv8u2oS92
X-Rspamd-Queue-Id: E4624233B1D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79728-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pastebin.com:url,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.946];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 11:14:58AM +0800, Zw Tang wrote:
> Hi,
> 
> I encountered a WARNING in alloc_slab_obj_exts() while running a
> syzkaller-generated reproducer on Linux 7.0-rc2.
> 
> The warning is triggered during dentry allocation (__d_alloc) after
> mounting a crafted ext4 filesystem image.
> 
> Kernel
> git tree: torvalds/linux
> commit： 0031c06807cfa8aa51a759ff8aa09e1aa48149af
> kernel version:Linux 7.0.0-rc2-00057-g0031c06807cf
> hardware: QEMU Ubuntu 24.10
> 
> I was able to reproduce this issue reliably using the attached
> reproducer.

Hi, thanks for the report!

> Reproducer：
> C reproducer: https://pastebin.com/raw/eHjm2Aw6
> console output: https://pastebin.com/raw/FQAhquTy
> kernel config: pastebin.com/raw/CnHdTQNm

a few notable config options:

CONFIG_SLUB_TINY=y (which implies KMALLOC_RECLAIM = KMALLOC_NORMAL)
# CONFIG_MEM_ALLOC_PROFILING is not set
CONFIG_MEMCG=y

and also random kmalloc cache feature is not enabled.

> The warning originates from:
> 
> mm/slub.c:2189
>
> Call trace:
> 
> WARNING: mm/slub.c:2189 at alloc_slab_obj_exts+0x132/0x180
> CPU: 0 UID: 0 PID: 699 Comm: syz.0.118

The triggered warning is:

VM_WARN_ON_ONCE(virt_to_slab(vec) != NULL &&
		virt_to_slab(vec)->slab_cache == s);

which means we may be creating a never-freed slab due to recursion.

obj_exts_alloc_size() is supposed to prevent this but it didn't.
Let's see why.

> Call Trace:
>  <TASK>
>  __memcg_slab_post_alloc_hook+0x130/0x460 mm/memcontrol.c:3234
>  memcg_slab_post_alloc_hook mm/slub.c:2464 [inline]
>  slab_post_alloc_hook.constprop.0+0x9c/0xf0 mm/slub.c:4526
>  slab_alloc_node.constprop.0+0xaa/0x160 mm/slub.c:4844
>  __do_kmalloc_node mm/slub.c:5237 [inline]
>  __kmalloc_noprof+0x82/0x200 mm/slub.c:5250
>  kmalloc_noprof include/linux/slab.h:954 [inline]
>  __d_alloc+0x235/0x2f0 fs/dcache.c:1757

The gfp flag used by __d_alloc() is
GFP_KERNEL_ACCOUNT | __GFP_RECLAIMABLE.

Looking at kmalloc_type(), when both __GFP_RECLAIMABLE and __GFP_ACCOUNT
flags are specified, __GFP_RECLAIMABLE has a higher priority.

That said, obj_exts_alloc_size() needs to handle CONFIG_SLUB_TINY
(KMALLOC_RECLAIM = KMALLOC_NORMAL) properly.

in obj_exts_alloc_size():
>        /*
>         * slabobj_ext array for KMALLOC_CGROUP allocations
>         * are served from KMALLOC_NORMAL caches.
>         */
>        if (!mem_alloc_profiling_enabled())
>                return sz;

I added this just to make sure we're not pessimizing when memory
profiling is not enabled. It turns out this part is incorrect,
and actually, redundant.

When memcg requested allocation, the snippet assumes that it would be
KMALLOC_CGROUP, but it turns out there is an exception:
SLUB_TINY with __GFP_ACCOUNT and __GFP_RECLAIMABLE specified.

This should be properly handled by:

>        if (!is_kmalloc_normal(s))
>                return sz;

I think this should work:

diff --git a/mm/slub.c b/mm/slub.c
index 0c906fefc31b..4759fe6aa60e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2119,13 +2119,6 @@ static inline size_t obj_exts_alloc_size(struct kmem_cache *s,
 	size_t sz = sizeof(struct slabobj_ext) * slab->objects;
 	struct kmem_cache *obj_exts_cache;

-	/*
-	 * slabobj_ext array for KMALLOC_CGROUP allocations
-	 * are served from KMALLOC_NORMAL caches.
-	 */
-	if (!mem_alloc_profiling_enabled())
-		return sz;
-
 	if (sz > KMALLOC_MAX_CACHE_SIZE)
 		return sz;



>  d_alloc_pseudo+0x1d/0x70 fs/dcache.c:1871
>  alloc_path_pseudo fs/file_table.c:364 [inline]
>  alloc_file_pseudo+0x64/0x140 fs/file_table.c:380
>  __shmem_file_setup+0x136/0x270 mm/shmem.c:5863
>  memfd_alloc_file+0x81/0x240 mm/memfd.c:471
>  __do_sys_memfd_create mm/memfd.c:522 [inline]
>  __se_sys_memfd_create mm/memfd.c:505 [inline]
>  __x64_sys_memfd_create+0x205/0x440 mm/memfd.c:505
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x11d/0x5a0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> 
> The issue happens after mounting an ext4 filesystem image via a loop
> device created from a compressed image in the reproducer.
> 
> Relevant kernel messages:
> 
> EXT4-fs (loop0): mounted filesystem
> 00000000-0000-0000-0000-000000000000 r/w without journal.
> EXT4-fs (loop3): Delayed block allocation failed for inode 18 at
> logical offset 768 with max blocks 2 with error 28
> EXT4-fs (loop3): This should not happen!! Data will be lost
> 
> The WARNING occurs in alloc_slab_obj_exts(), which is related to slab
> object extension allocation.
> 
> This may indicate a slab metadata inconsistency triggered by the
> filesystem state.
> 
> Please let me know if additional debugging information would help.
> 
> Thanks.
> Zw Tang

-- 
Cheers,
Harry / Hyeonggon

