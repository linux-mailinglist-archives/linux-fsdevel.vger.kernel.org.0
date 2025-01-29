Return-Path: <linux-fsdevel+bounces-40311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB62A221DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 17:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CD71621BB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0FD1DED6F;
	Wed, 29 Jan 2025 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Brh+TMsC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="scz4RuL2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449C2FB6;
	Wed, 29 Jan 2025 16:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738168700; cv=fail; b=b0tZAwWQyK+HDZ4EMWpI/fP4q5tt5KB2yxK85uwxe54f6t+eWQRKIVIaWmQtWVXRSs/ma6ryUhuwhsH4tSfIMzXrXKKiye6MfqJGa+pzxEeKqDPIgu9hdiILM5mTSUPum3tQ1EXrfsdMwMzKUAn8KqnsLNRszs2Zp67nAG5Yq1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738168700; c=relaxed/simple;
	bh=AVb2nLWt6MF4HbeFSfIwookYRc4EH44DyXtFnPrUsNM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly3bdcNTpkYGKlquVL9PZQGz9woahesVaP2bIPk2HG21wIJTxbAUxeA3cO5yAORURJC3ydpEyyt1kbpy/uJ+/dJ9mct3Z6FgFyqBH+PUzX57T+p/s3psKa5iDfYCPLrnYPFLoSGj9xjsKx6NdrWwjDln/c89jB2cKBelO1AI/mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Brh+TMsC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=scz4RuL2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TGC0kX026890;
	Wed, 29 Jan 2025 16:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Xnx/hMDsU3TYV5txwjKQ5mCqXkzc22MA0845t1LZ+h4=; b=
	Brh+TMsClH+eVZrLWN12xOLBncDUlpkXzTIrFy1nSJJhfezv5hXAredQqyxXGKAS
	V+SkmER3MSj0OwKODEs1hywmxsK2QiTJKVGB0/TTlN0lt1DxRErs8aAR4MZozZmL
	HMfgMTGv4cP3BAaMpPUWHe0eX6LBkS/0ktVcVwtXzHDzAbTffftpEkvOf2uxpP3y
	CC0I84ZQTbn28HH/rzpxIT3lntoui6iGj8tGtALFKO9kh4PxYXdNbEbYcF/g1gHp
	y8cRODFiXdZoboYgdotCnR0zHdltxUTvTlYkFdx5tjv9KhjkRu1z0o5Enkbaprh2
	9ATa6G0YCZH5VOVAjRN/Aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fqmw01um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:37:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TFetQa036447;
	Wed, 29 Jan 2025 16:37:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44cpd9wwy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 16:37:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uNZJwi8Bfbx/+HO2fKFaPCD7FedQNezDKcX3lCUlXaZOhukJhuAfOorIzea0SBkpxZ0Yk5EXwpxruhdtV0SARPeecm9sJZaD5f0apsuHgQzR+YX/J3pPTkB0o+1RWZpqjkA2o3b4K5OwvH5iAryDhV1X3JjFkAECp831EYbqQHtWZy8OB+63KCsNF32hUHIYecdfRYw/D5eGq64yW/x4qkfIaVu1DTi/uRiuoPosuyw/R8CjzzU7CO0S++ZvMn0aHWtMrURY02+lYN789zpgmwxixrYkB8xKwfOg5AFeaPq2W3OWpfnfu89z5+QzqiptithaTrTXNesKWwqirlHIBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xnx/hMDsU3TYV5txwjKQ5mCqXkzc22MA0845t1LZ+h4=;
 b=MWIry7ljFZEXRYqnsTIImOPJmZhVqk7HRQ2ThVXnuCv5EAwCKnQJV6oTqBrdG9HnULowTRsuhlQCSr/nYJBkQDkparlz1Eo0Q9Mx9vGN6RMn6R4wcJHud0BKXiXnTsCRBVkMLNS5xEYiQXb+mSnVQAZtpQI5SGnMk6wAgBC3MFoBtEHjT6XSzaTJifK+Z2UnPRJt/8F1jhhsitInu0AQiN4NuqHrN4UvyqYtwfLHXxE64gjR6q37QCGCjycFtu8Rf2Q2cnAChArYsJhJTRQJYBqdyrDPqzO3lvuavCc0LR+/Ibnu86eYJnmPWoRMY+5oU2rt8Unko6muBUiMTnH/lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xnx/hMDsU3TYV5txwjKQ5mCqXkzc22MA0845t1LZ+h4=;
 b=scz4RuL29roFiOZ4iWv7K4uoog0iMXFqoiEIamcrEc+eNWNSI9J/pi2Yy39u9YF/0JRbzqLcCXUtVOtc22qakP1ToI7jhOENTv0+1BwnGiCwAXlhd1CU1ObE2hRTo/GUNpuYtMu+1WGtsPedxMZz9XL5o5Bawjx2abFaI5l/YA4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BY5PR10MB4147.namprd10.prod.outlook.com (2603:10b6:a03:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Wed, 29 Jan
 2025 16:37:53 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 16:37:53 +0000
Message-ID: <9130c4f0-ad6b-4b6f-a395-33c7a6b21cbe@oracle.com>
Date: Wed, 29 Jan 2025 11:37:51 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>,
        Andrew Morten
 <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org,
        linux-mm@kvack.org, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250124191946.22308-1-cel@kernel.org>
 <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
 <2025012937-unsaddle-movable-4dae@gregkh>
 <69d8e9dd-59d1-4eb2-be93-1402dba12f34@oracle.com>
 <2025012924-shelter-disk-2fe1@gregkh>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <2025012924-shelter-disk-2fe1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:610:b1::7) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|BY5PR10MB4147:EE_
X-MS-Office365-Filtering-Correlation-Id: cddb9e7d-57b6-4eb5-2e56-08dd408346bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUkrVFBDV2xFSmVpa21WdkFoZFFvZUhyeG1HOFNTV0NBdHY1NjV0R1NaQ29h?=
 =?utf-8?B?b1BjdkVJZXFYOXBpQmpjMkxwVWwrWDEreHkyZjQzWjYzLy9ILzljZ1krS0Zz?=
 =?utf-8?B?R1JwcVIyR1g5cC9hcXJtbHExZWd4NWVvV1FscG52UlFuM3dBVXBwYjBTanp5?=
 =?utf-8?B?T0VJMHd0Q1dhVFhYa3FGVmV0N0pEaTM1N05TSW9hWmdmaHhKS1U4MU1vT0ZY?=
 =?utf-8?B?ZXlWZmE2cVRxVmQrYThscEJMT0kvWkVtSEw0aXJSa0hFME5BZFZvRnFrZDdF?=
 =?utf-8?B?Vy9aVTNJT0FOcGJ0RlRMeUg0Zlc3cVluTVdhb0U2bUpBcFFkdzI2aEdKdVdt?=
 =?utf-8?B?bkUvK0laS1ZnTVdaMXBDVkhJMDA0cWc5ZVN1eVozOGtXMlRMVXZ3T3ErelVz?=
 =?utf-8?B?Y0dxa2lIODlCRGp2TnpjYm5YQm1aWkI4QjdaUUpCMzVRWU9wNFA5T3NyS1NB?=
 =?utf-8?B?ZU01L3VHTlVwcThJR0l0WEZDdUxHRTNTTXdnbEZhUGsyY3dvanJKWE9VUkRu?=
 =?utf-8?B?cVZkcTBUZjV4TDNrUXA2MjZGajZlenRoUlJDend3clYwNHV4NFBORHFMMHRn?=
 =?utf-8?B?ZEJIQ3BpZEp4QVVXdVg5M0FFTXVpOWx6WHA5YjlKc0k0S0tjaUFVTk1MdGZt?=
 =?utf-8?B?Y1NLS045dUhFUE0vUXpGbXhvRjZGNTVsTnpWWm5nNENjSDNxdlkrazZHV0hv?=
 =?utf-8?B?OHY3WGVRQmp1eGxMRXg2WGNKYi9BSk9HT1E5dGh3SnRSWCtMeGNkRU5Bb2lk?=
 =?utf-8?B?Wjdydjd5TGhDdGFINkJWL0lBZFQ2amZ4cXQ0SDNJa1NDZE1YbG54N1NGNm00?=
 =?utf-8?B?dFdhQWFSRWo3TEptQmJQOUx4dEg4QkhUWTBybUMvY0lxeE5mek5lR0VDeWFq?=
 =?utf-8?B?cU1Nd0hjUzlPbTNOYTVYdVNiRVJTOXpoRlh3NHlFZU90MmRxcTZjYU9KcWlE?=
 =?utf-8?B?NVRSWHg1NkNZczdLcFhncm9rak85dzd6NWNxSnIydllRR1RMT25lVW1OYStw?=
 =?utf-8?B?bHJJVzFLZ1k3VmtzQXdlUjdXT0t5M1JxdGFkbDNoUytRU2VnbjNJRGZNL2Z4?=
 =?utf-8?B?bHVkT2hkVzlWOEJuMkV6WWVpZmZOL29TbzVPL09yOTZ3ZkVtRlFrNm9SaUlM?=
 =?utf-8?B?anR0enRHR1UweWN6TkhYTDFma3VQY2FMVGNpektsYlorcy9zejI1djdwN0h0?=
 =?utf-8?B?YXBSQXlLRlhnZHVmQ0hGN0M4TnRnU0xxTnBDWkZ0dkdPbzI3YS94NUw4N0dz?=
 =?utf-8?B?WE1BUnN3cDBKeVJlS0dMWjhNVUxKOS9IWkt2L0VmaXhPekY4d2Z3MThnUjlD?=
 =?utf-8?B?WG93dlBwVHo2bFJHU2V2UFQwMWhSRHc5V1ZvMko1bmNMSEZQZWlyMzFzTXNC?=
 =?utf-8?B?Qlg0aVIrRHE1UGpSclVxTlpYZXdxdk13ZG15ZXFiakxJTndOWGJLWE9xTU82?=
 =?utf-8?B?MkgxY1JMZW1mYXJrQ2MwNktHRTVNUE1Cd0hvcW5EN29IdENBQm5reWZSNURl?=
 =?utf-8?B?SGZCdVBWK0N1ejJsamR4NW50dm1CQnNvam5QUHlER1RBR283VDl1bFQvSENr?=
 =?utf-8?B?bnNJWFNuTXEvaU5UUnNVeGk4VzlZYU0yV0V5TU9GRlRtMHVCb0pvaFVrMFZQ?=
 =?utf-8?B?NlpNZ2hBWC9UbzVlV05kZ2JkRTF6cWk1d05CZTlqdThNWkl0TG1ZcnhDUmRj?=
 =?utf-8?B?WjhuUWx5K1JiTGdhNXdCeEU3Q3dudWRnL0Jjd1I1bkphNmxXa1N1VkI3emx5?=
 =?utf-8?B?TUU0QzZIU3d5YkkyNzdnMnlqMmtFTFFMNFN6cjczZWJZc2RtQWJsRkkyTzhS?=
 =?utf-8?B?WnJuYmQwWFlRVndnaWtKZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0tKV0xjVU1qTGdjYXJVRHhGWUlmbVAyNVpMZGxhbnRXeGtkejJ6VjI0UnZB?=
 =?utf-8?B?cHhWZDZhQjYzck5hT05pOGhJbWpIVjFSSENlMkpyN2ZPcmhTYjRHTndUMzhM?=
 =?utf-8?B?VmF0UVZxb1BVT0RQYUsyNkdRL3pUanFMNGxUd3RHZ1NhQm1Sb0JOV2hReTRo?=
 =?utf-8?B?UzlyQWlUQXY5eGswY1RUZjNoY3JHZEhuWlE0UDJ1ejJsOEFoaTNJRUZkV0Rm?=
 =?utf-8?B?QlBpbjM4dUJHTElNWFQxNm5tMWxNckFKTnFmSERjODcwL2V4d2pMRVcyMWdk?=
 =?utf-8?B?Q045QnpMUjZSTW9Ya2VCMkowZ2I2TDljL3FCd21JZDdIcFlBQkg1Y3IzTThp?=
 =?utf-8?B?NGhHM0w4UldTVm1NY2NLMHBEWHpxRnVwd3FGVUZUK3BZQzJKTm10cEYwWEZF?=
 =?utf-8?B?bkp6WHI3RlBRdEMxTjJYMmFGVDVZY0wwQVhWc255K2pBdE9JK243TDRFVnZY?=
 =?utf-8?B?N3FqSDEzQWk1SU1VV0xOMm1xUlNyODJnVEYwdmhqemczWlFCRkJCV0RWZk1U?=
 =?utf-8?B?QjFmWWFRdFV0UUJMUmVObVZ0clJEQ3JsaE5kU0M3ZmFWeW5sMFRvcVg0UkhU?=
 =?utf-8?B?a0NJMHlLYWgvUmFvc2szeEhqOGRBampSVWtZUWN3OVVtZFJFa0dSbVU3L1lO?=
 =?utf-8?B?cjM0Y1pCT2RlSlVLeWdCWGJHTmRMK3JRSy9PNmRDMS9QSWZaZWM0eEdEdkJC?=
 =?utf-8?B?c0VCU2ozcnBoNlpXTXhDQVdrRkE2VGJkU1VSVVUxUFp2TXREZjRXZFhYWlBw?=
 =?utf-8?B?djhad2FUZGNYZDRKakJKRTVsUnR4cDE0UWg0UlpEcEJKK3pwU0g0OEJBbEp5?=
 =?utf-8?B?M2IwSE5XY2Y1OFd6SjNxWnlhZkJOZUQ0R3ZObzJldUJLQjFHWWNBcGNLNmhv?=
 =?utf-8?B?TXUzQTI1QnlZMGdMTFhSMC9BNmFNSTg2aUE5T2V0T0hITmxWWW0wTXZqbXpQ?=
 =?utf-8?B?RHRoTXdZbnRZczVPd3lRYWdnNkdHZHpETnluVnNBVGppTEFydEhWT1ZVZWp2?=
 =?utf-8?B?SFpnNzREcHVzVldyVGRzdU5QQTRjUjkwWHdBcVpMcm5KRVdtV0l6ZmpLVXYv?=
 =?utf-8?B?S1FQL3VhaytXRE9wcE9EV0ZzRzFobG9pU0t2WHM4OWV5aWFWR0pIekcrMlYw?=
 =?utf-8?B?T05QNXIySVVoQU84RHV4K1VCdzRaQjlkbmQ0TjRJcVpuVCtNcXJXYlZZSkNG?=
 =?utf-8?B?Y1dUWDk0K04veHk2NlBJRWMrQTlrVTFiYzdBditBTmY5Q0lvblZsUHZDbWwy?=
 =?utf-8?B?RkNtRDZmS1lVeDZuQ1ZWbWJ2b3VLWUFCUUNEbG4wMmowdk5EOW5tY3Ryc3JE?=
 =?utf-8?B?UWpvMDNTMjRKUVRSMk1xNUtmWVBnMk5vS2tYVXNFUTdKdnpPZjlGVEQ4b2tO?=
 =?utf-8?B?LzIwQjJmOWlBSHFVVCtJMlhxUnBBMXJGSjV4S2xMM2wzOFNDaGV6T2kzTzhL?=
 =?utf-8?B?MkcvUklBbGpMZ0x4Qnpud2llMVRvd0d3WWhGZmxxa1JDUXZSN0FzeU91aVM0?=
 =?utf-8?B?bDZwSGxGd25ld2c0UjFXVG1uRHJGNy9iZHpDTU9Ja0NiY3ZBY2FWd01kMXFZ?=
 =?utf-8?B?aVJsTEpTeWxVcTFqRVVxRmZvZlI3WWRPcTZENzRRTGxQNU9jTGNQS0pURzRq?=
 =?utf-8?B?a1p5L0NjYVo0bHZNQzkvb3hOb3k3b3FwSzB2bFg4bFpCMVhEakZZVHRpS1Jr?=
 =?utf-8?B?cU5TcWRQaXV5Q1MyUTJMeFNXWGdtdlY4a1JsMzVUOFAxQU5rc3dKcG1nQzBS?=
 =?utf-8?B?OGhKQkxmcXdMckd2V2RBZFBaeHc5ekxMNjAvWFhzWTJnU2RwbDZ3azFpYTIz?=
 =?utf-8?B?VkxDZC82QzBNSTBoWVNaMzRXWnJCRlBwVzQvMHZWMUlBLzgzYzNVK0dBcnJl?=
 =?utf-8?B?TFJ4VWRCTzZHajZpaXVMQUJnQzJ0MStUMG96L1ZNM1pWQXgvR0lFR3d1S01P?=
 =?utf-8?B?YVllYjY1Z1hTY0dmWm5BbnEzYWlpQ1FVL0IxZ3ZpQnRoMFJOQjJQcHZUVmo0?=
 =?utf-8?B?OXNGZ0dPcjk2ZXNOU0V2aHhtdWZ4eUVuYktyNnF4ZHdUYnNIdlE5WVQ4VlpC?=
 =?utf-8?B?L3VKWkxFNVZ3RmpYNm5kVkVZMGlueENUS3pJSUVxNW4zb1pRR0pmNzB1d25R?=
 =?utf-8?B?Mm1tcXFPbXRkbkZBNGdtb2hhZVg3RUtub0RzaWZtdWU0S1lhT2s5VXhwU1d0?=
 =?utf-8?B?NGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XnOSPbN6pjkGkQurt40fQAoQMQAkaTYWra4IOw5OPev3kaczlq4PdJUsZMGHvFe8hcb02VLUBMVLDCpAQtraOmrqGeKv8jH6Yqz7iUgdSFSK6zDL7Hw/juyTCiui/krn0VuigdfqnsBOOt0GgTKXEREeNZdKMMFcjuGf3kUQ5n2J/OMUDB4Jk7TFrt/80RojY8jPfCbRls7mt5+4QAYIp0xh6UV8H2ZCyG6qiisRWLl6m9zJ4I6ZJgx4ygQxPakJ1Sjd3HQYqI3GxlFL62cNyU7BEBBHA55hyocLrlpI97MhCHoVXfm/zHXvM9swaXRHDuwlfAT7i9bvPhCzck/ufsqhJMucQ/GbAhqF1KU0Fd89vkMRr+HmQwWsu49DJt5E6BO+3dA8RF2MOWaZJ/FKvpXJq2spJFkEQqTxbhs3t6uhy/Ikq8QktgSzZ7nqSKnemzcSzu6w+0SitOwhvjWkuBusegRITx4eLkmcb6MyV98pQq+9iJcpSNHJHMjaCS/ns+YkHrVEfXPvzgQMPQMVW0vTb7nV4zvdcLnGm4c7VpGj8pYPHqtuUqgoaUVY4ScL7shuhHPPye8Wi231EnmaU3Stqt6XpdmoyyPe62jP0+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cddb9e7d-57b6-4eb5-2e56-08dd408346bc
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:37:52.9395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f9dImK0mAMJOsBxsmalYbvxrxo84SiEuRGws5ZitSHMdX1JpOCOaWsSx+gDeCehVTem9d6VUjYdPGgIbs67O+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_03,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290133
X-Proofpoint-GUID: VO9VjhFFZJqRl45QIbKTuhrpRrrhW7gT
X-Proofpoint-ORIG-GUID: VO9VjhFFZJqRl45QIbKTuhrpRrrhW7gT

On 1/29/25 10:21 AM, Greg Kroah-Hartman wrote:
> On Wed, Jan 29, 2025 at 10:06:49AM -0500, Chuck Lever wrote:
>> On 1/29/25 9:50 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Jan 29, 2025 at 08:55:15AM -0500, Chuck Lever wrote:
>>>> On 1/24/25 2:19 PM, cel@kernel.org wrote:
>>>>> From: Chuck Lever <chuck.lever@oracle.com>
>>>>>
>>>>> This series backports several upstream fixes to origin/linux-6.6.y
>>>>> in order to address CVE-2024-46701:
>>>>>
>>>>>      https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>
>>>>> As applied to origin/linux-6.6.y, this series passes fstests and the
>>>>> git regression suite.
>>>>>
>>>>> Before officially requesting that stable@ merge this series, I'd
>>>>> like to provide an opportunity for community review of the backport
>>>>> patches.
>>>>>
>>>>> You can also find them them in the "nfsd-6.6.y" branch in
>>>>>
>>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>>>>>
>>>>> Chuck Lever (10):
>>>>>      libfs: Re-arrange locking in offset_iterate_dir()
>>>>>      libfs: Define a minimum directory offset
>>>>>      libfs: Add simple_offset_empty()
>>>>>      libfs: Fix simple_offset_rename_exchange()
>>>>>      libfs: Add simple_offset_rename() API
>>>>>      shmem: Fix shmem_rename2()
>>>>>      libfs: Return ENOSPC when the directory offset range is exhausted
>>>>>      Revert "libfs: Add simple_offset_empty()"
>>>>>      libfs: Replace simple_offset end-of-directory detection
>>>>>      libfs: Use d_children list to iterate simple_offset directories
>>>>>
>>>>>     fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
>>>>>     include/linux/fs.h |   2 +
>>>>>     mm/shmem.c         |   3 +-
>>>>>     3 files changed, 134 insertions(+), 48 deletions(-)
>>>>>
>>>>
>>>> I've heard no objections or other comments. Greg, Sasha, shall we
>>>> proceed with merging this patch series into v6.6 ?
>>>
>>> Um, but not all of these are in a released kernel yet, so we can't take
>>> them all yet.
>>
>> Hi Greg -
>>
>> The new patches are in v6.14 now. I'm asking stable to take these
>> whenever you are ready. Would that be v6.14-rc1? I can send a reminder
>> if you like.
> 
> Yes, we have to wait until changes are in a -rc release unless there are
> "real reasons to take it now" :)
> 
>>> Also what about 6.12.y and 6.13.y for those commits that
>>> will be showing up in 6.14-rc1?  We can't have regressions for people
>>> moving to those releases from 6.6.y, right?
>>
>> The upstream commits have Fixes tags. I assumed that your automation
>> will find those and apply them to those kernels -- the upstream versions
>> of these patches I expect will apply cleanly to recent LTS.
> 
> "Fixes:" are never guaranteed to show up in stable kernels, they are
> only a "maybe when we get some spare cycles and get around to it we
> might do a simple pass to see what works or doesn't."
> 
> If you KNOW a change is a bugfix for stable kernels, please mark it as
> such!  "Fixes:" is NOT how to do that, and never has been.  It's only
> additional meta-data that helps us out.
> 
> So please send us a list of the commits that need to go to 6.12.y and
> 6.13.y, we have to have that before we could take the 6.6.y changes.

903dc9c43a15 ("libfs: Return ENOSPC when the directory offset range is 
exhausted")
d7bde4f27cee ("Revert "libfs: Add simple_offset_empty()"")
b662d858131d ("Revert "libfs: fix infinite directory reads for offset dir"")
68a3a6500314 ("libfs: Replace simple_offset end-of-directory detection")
b9b588f22a0c ("libfs: Use d_children list to iterate simple_offset 
directories")

-- 
Chuck Lever

