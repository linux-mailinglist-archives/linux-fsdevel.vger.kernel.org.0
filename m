Return-Path: <linux-fsdevel+bounces-41670-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4507AA347EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E81CC7A1104
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F811FF7DD;
	Thu, 13 Feb 2025 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b3uEEWhV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QHk09oac"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296DE194080;
	Thu, 13 Feb 2025 15:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739461185; cv=fail; b=TPCAwx4ShXzfA7QS5DbuHp3PqSVzG5HcGZ4Cyee+ZbMesPZ2bk6imtOt0Rpbg6ZgYnLlFDEUL4FDNScMouKYfLGpvX4TbYXkkzJDIndY+DuJYOg9XZKp/IH3k2SxmxKp7YmEbaTdGVqAe+xIQ1pSRckWvnbmq1M0Px9TD2r7EN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739461185; c=relaxed/simple;
	bh=YrAU00xo0FbJD4SyggCHqyLJENpWbnzj9Ndn+Io27hQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXKyN+r1nHW9J6LvSlHhwEVRvU+MuHb6WXOlJKMucKjJ5pSVBSWVGEVlBh4nqeN/8YwhZdVah+hV1myRL+7ZK9H7kj65QcrNDaCYHjOPOQ72csKR0/k6FVc3EGr5FI59dmSJFON3V8Z1BZLrM7iOnmvl72aQU6A+a7Qd7AjtctQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b3uEEWhV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QHk09oac; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fnrb015201;
	Thu, 13 Feb 2025 15:39:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=anlcyzXEt6cf94HKqGzJgfMMtUs1dpPghVxMlUfUcZA=; b=
	b3uEEWhVGzZdqeHUwxWl2PDhOqRi+eZhwEvmIiyyn9538NcuIV8EasN2Yaojmyas
	WSO+lhjlBZTVAdpEKiFJhC2rzPMVIz93YhOMXHa2Ta0xQYQVQbY/0i/64aLzB5u+
	jNdYOs/Y2sPW5nXK5L3Z49g9G7o8PaiBp910zw3MheN6Ym9pi+qjon346X+3KY+U
	0Ob2WnwODkcPiWqPKlkkXs38zkCAortZyP2sFukdJfVleXWlOKKSf9Y+LIuxOgHX
	rk6Aujhdi8omx7A0ifdlN7aiyfb8XTyOR8HsicWwJMRnIjH5f1iLbIXtAo75b4NF
	yzDDkrpWoGvOeDkp0zFjVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0q2hv98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:39:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DEOr3n016264;
	Thu, 13 Feb 2025 15:39:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbw7j5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 15:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ILbsWE4DUPVzQ83C2BSf7s1FzaTRFydaK/EtJToJf56piqOwNwB582XBNromW2f7Mr7P+3msTVd9wcQjvBoYiRh3zbLSCpJRn39+dhY4ziAguMmoPPChUZuEN6kaXEk6dOJDVaaSCLXjoAEurmnuRMHkyOaDCCmgpsFaCMea0PmdnkFiryWSk/uCqOMXvJtAlSCK+H660GA2GX5HV+JjqPjcbcXszOnsX2v8ZZnYRlkrlCQk9YE0YzhZvqc1rQPxe2DOhE46xGUWg+Jtwbp6k7kl2Jp/gayxL5QnAhDwlFlWEqGPlrWq9cKzH+8IidFOKD2sZDV8Nksa98DGCu7Uvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=anlcyzXEt6cf94HKqGzJgfMMtUs1dpPghVxMlUfUcZA=;
 b=BPzis6VyxbgwI+wNycibLmUWsFKf8CK0/P4bFcFAX2MIpTIaKtM+Xk7v5wdJnz1VcUY2bfGRXHBRUSzNsfNP6SnZeT4nGGsD0Rm7g6OAh0uSzKlJLnbYL2cgkF85IjyIf8IeUge1ZGWFgJEIHZod8X9srJudR1iaeNHgC+mjjXrpOmqd5zd8uAgjytuL2zqN7Alaf53Wev36Z0elDyeKjdg1xvfbtu5hQDEqFfKvyFT9kPdNtXINA5DIJQdmL0KNdBQRk0OCwL6B342GeJLuvFdNktY7coEeBcYZJ3fatr+vrS14+7ArJDeccNZNxX5jr7kSui80e+Qluf8/hCO5QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=anlcyzXEt6cf94HKqGzJgfMMtUs1dpPghVxMlUfUcZA=;
 b=QHk09oacNDQZXFC0rXylRMJdyiYCRWT3PcWBjwIQxN7XWKq+P5Ttvewf5CKY96Ug+OcYJH+ZOSRy/msSuSI1b8Zcjvr+8oxN6pRgi+1aT+BZPUCBC5WNTAg5sU14b60t4EL6mBvAQysSmsNstuOhCTPqlE1kCI5VZX5hNWiw30E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA0PR10MB7231.namprd10.prod.outlook.com (2603:10b6:208:409::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Thu, 13 Feb
 2025 15:39:37 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 15:39:36 +0000
Message-ID: <3540acb6-0fe0-4c90-906b-def22aeffade@oracle.com>
Date: Thu, 13 Feb 2025 10:39:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: 6.14/regression/bisected - commit b9b588f22a0c somehow broke HW
 acceleration in the Google Chrome
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: brauner@kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org, chromium-dev@chromium.org
References: <CABXGCsMnkng1vqZ_8ODeFrynL1sskce1SWGskHtrHLmGo5qfDA@mail.gmail.com>
 <9f3ad2da-3a85-4b1e-94b5-968a34ee7a7a@oracle.com>
 <CABXGCsP9vPxu=hN5CO5MPJ5QVNJURKsBbbeb-NLoq60=M=CN3Q@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CABXGCsP9vPxu=hN5CO5MPJ5QVNJURKsBbbeb-NLoq60=M=CN3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:610:52::25) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA0PR10MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: de8e9b77-be45-4e6a-b1dc-08dd4c449f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFRpdzgzeHJtRDdXWFdoNVJtS3VyVzQ2YkpRc05rTmdFVTUwekphRzBvTFlM?=
 =?utf-8?B?T3lCaVJ5akNkVzA1UlVpUkpmMGtMbWFHOWFWYUxKbGoxdUMwbHhhc2N1UHo1?=
 =?utf-8?B?aEFXTlZnank2M294WWZkNG9EUTAwN2RWVG1hNjJFYjl4RWFISWVNcm01alM2?=
 =?utf-8?B?aWtYOTZmYTRGWjZCV1JCTHRLbVFpaVFyK0J1aFkwVFFkL01icWMyZG1Ya3Ns?=
 =?utf-8?B?RUdUb0RGQituWEdyV3pmSTlBMnM2MTVJbHpuNkMzWVBrM2NwcGx6WVUxY3Fp?=
 =?utf-8?B?UzhuUnNpaEIyMDJ5N0JaTCtXMFNxbEREK3BJYkN3TzIyZStHZVNzLzc3STgw?=
 =?utf-8?B?NUpUWkhPUEtsbEowQ3RDeW5TTE1lQjRaamFQK09BM0RrWUVqbzErVlg4bG05?=
 =?utf-8?B?eEFtSk9tL043YjV0OXZaOEFqcUtLVWpTMDRWRlVhNG1iTHR2ejltZHN1YjRQ?=
 =?utf-8?B?Ymw0ZnFSTURQU1BPOFRmdElmbWRCemVId2R5ZS9uTGcyQWFSdCsyT3RxdzJt?=
 =?utf-8?B?eGZUMFJTM1RvOG5pOXc4dWsxck44UjlQSjcvUFBzeVJYTmZzaWhXOFhZeTA1?=
 =?utf-8?B?SzlTc2czTXdMRXBnWkQ1WmhpZ1JkVVRVakY4SWJoTkFRWFluRisyYllFQ1Zk?=
 =?utf-8?B?bHJLUHplT3pMNHdmZ2duV2hBVjhKbXVnYzA2RTAxL3dYejF0c1U2S1pOOG9W?=
 =?utf-8?B?amJScjNLTE9RSnFxZ3M4OHV2cncrOVpRbWNPZFhHNjFia3hBTXBqOTdKVVAz?=
 =?utf-8?B?bHJubC9RM2pVTHlzRlRLdVpET1dLa3FHZnB3enNyMmhKVGsrV3FUOWtaR1JN?=
 =?utf-8?B?Nk9YZUNzTURvdFJoSmZIZlAxeTlGcHZDYWN4bUNyV0IxUlA5VVZXamdhd0cy?=
 =?utf-8?B?a0Q0d3FpZWxTWmlwQW5oenowRXZyVUg1SHRpTGF6SlVRaTNjY1dkeW8yQ1pm?=
 =?utf-8?B?ZC90WXRRME9WdFZsSnpxZmVpTzlqejVjdnJGOUszQnF2ZjNkTDhEaVFETDJo?=
 =?utf-8?B?a2RUNHFkTDRGdll5RHlNbUpJUDF2UG9zTEZTYXRRcmxkcU5RVTJZMjk2cEtr?=
 =?utf-8?B?c21yOEx1NWZBZVdjcUVvYkVzK0QxVHE3UERvNHlsRDFnUkF2aXQybmZxVUNk?=
 =?utf-8?B?blJBYzFjT3Q5MmtOa0owYVArWHp5YnlnWjJKaWlqREtvdzMvVkUyeFRWalNa?=
 =?utf-8?B?NEhTTy9JbzU2M3BCMzN3OC9lTlR2dU12Y09IajlxNk1KbHgyMWovYk5OUmh0?=
 =?utf-8?B?a2Rmb09aOTd5OW4zQm1iaUd5R2M0SUYxZzQ3azEvVWY5RHdpQXM2b1R1czBV?=
 =?utf-8?B?L2t4dUFjYXVXV1hGZGh5MlVLaFNqaUc1ZWxYaW4xQmVnay80NDVlV1lReFFS?=
 =?utf-8?B?RngrM3plSHNrNGdkd1VRWS9qK2ttYTdPMC9Xb284eDg4SnlvWWVrQXp5a3VN?=
 =?utf-8?B?TlRmNnlLTnJacDV4Y29jQlhxbmkwcFRJV2oyUklqdGdiM0hCNWZqK2xOc0Jv?=
 =?utf-8?B?ZDBnSHNYMi9uNWg3QTJNVFdvSzVYVGd5bUFmTkZZL2hnZ2dCYlhidG9xbnYv?=
 =?utf-8?B?dFVPbDNRTHFHZi9BUnBYMUZIRmRyNTBUTlFhZXBxaVM4cmw2cit2RmNNNWtR?=
 =?utf-8?B?dlcrWjFSVGlpbWlpL01PN01EdjJQeEFPWkdtZGtIQjJsb0dKZXhDVWZ3djd0?=
 =?utf-8?B?MktXZ0VIcDdQVUlab1FFMTBTL043Tm1lWU4zajFOWEVKRnQ1TGM4RmoxWE14?=
 =?utf-8?B?RlZSUWdWSEFiUG45dHZxcGJmMWVnMUhzdVJxRDZzZ25oczZOSGhmU2U1cyt1?=
 =?utf-8?B?NU9BcTV0T2VUVFhvMFV5bUx4N3JyL2NWcEJSRWtxNVNlMmpqeVpuT3ozTUpy?=
 =?utf-8?Q?wUEm1GfEub0Di?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVY0L1FRM3NNNzBLVUFzQWdXWkhTWS9abG9FdW5mVkdlUnQwbW4xa1lkZzdz?=
 =?utf-8?B?S2s3eEZmbTc2MU81c2RLcFU2aVA2MzJkdmNEOG1GYy82WWdmdENZTFUxKzZ5?=
 =?utf-8?B?UUljY1lyb3BpeTRwUk40Ty9XZm1MTjlrdTRHSTJINkVKditQQldZUHpTM1Ay?=
 =?utf-8?B?OEt5aElpU080MnI1TnhVRjd1RXZpQVNKUlpkUVdwU1dJVU02WHZ5cVhIUEhD?=
 =?utf-8?B?UTVlSG1HTHJjVFZuRjVPeUJ4emkvWGMxb2VMZHZKVUc1Tm8yN214d3Z1NFc4?=
 =?utf-8?B?MXlOcjlxTU1qakZQQU0wYTA1WXVhWUw5WEdBT1pGWUhhcFRWcUlaWm9LcXU4?=
 =?utf-8?B?eTBkRlFtRE9JZFZRVjExMkZPYmNYbnB2WjVaOUREY1R0ZFhjdnpsa0ZhNm50?=
 =?utf-8?B?bmZKMFY0Q3I4RmxoQVdsU0JzVmRMYnphZStsWm1VakU4b2ZRMEVVaWRnVU5R?=
 =?utf-8?B?bFNRWjYrVHk0dzNQOW9PVEpEdnVHb1ZEWVBDTElLMDh0eUYxVDgrc0ZsYk9k?=
 =?utf-8?B?c3hNdEdvZ0JVUHhtbmZXWll0RFI2bHppRnh5ZEtOekNJNGh4RTlvQUNSTjA3?=
 =?utf-8?B?eWFxdk1LeEtBVnZnQTU0N0RCUUl3c1VobUFnSTZLcG5wSUtVVTdJcmpMLzNC?=
 =?utf-8?B?TDRqNDJ0QWJhbEQ1Y2xxTndSY1hIc2NHeUV1U1VxVHlQbnRscE9ycHNKTXNz?=
 =?utf-8?B?Um9JZHdjdnFaeUl2R0tVMUxUdXhqN1V0WXowbm9DNWVMRVpuSlluU0E3UzBt?=
 =?utf-8?B?QkJ0bHhFUE1mcGcrUEdOanNNdFNJZ0RCdWN3Tlp5UW5namNSb09DSklxdzFX?=
 =?utf-8?B?a0xCQjlRSmxNbHk3bUlGRC9YL2NQQjREaUpuNFozMTFjdHM4c3V6S1FnMVJp?=
 =?utf-8?B?MXdCTnVaZHdkRnd3Z0t6Z1crVGZYN294MHlSSzZyd2dId0RNcFpNSG1Gc2w3?=
 =?utf-8?B?TUF6a3NBSmlMUDV1VElFOVJ3OG04bEpoeGRrenoxdERTMW5YSm9OQ0tBU25L?=
 =?utf-8?B?ejF1UGpYRVc2L1IwSGFGVW8wTUNOVDFibnpja245TnVMMU9HcEdyRDBkSHpo?=
 =?utf-8?B?YWJHbXNOSFNuazdqbldPVm4xYlEwL0RtVVpPZWNmMFFkQ21sTFlNQnVlUVVy?=
 =?utf-8?B?S2NzZEJJMUN0V2srdjBuRUMvck1ZUFRMTmdweG9VNzlpc2pFVlhoVHZqM0Er?=
 =?utf-8?B?MFMvMGtzaUowMXBFKzNHNVUvdVdyd3o4UG82LzZWS2plY1cyYmtQV2M3eWlV?=
 =?utf-8?B?dTkwVEExWStFNnVLSTJ5c01LeDZDcGNaZVlKT091d1lqclVRdFRyZU4xdjRQ?=
 =?utf-8?B?ZGEzU29rNUl3MzM0MEh6Qzg2Mk1JVXpMQVc0cXFSNnR5eGtYZUcwRnhLN2Na?=
 =?utf-8?B?UWk2d1NLV2dIWHBJTC92SEozanI4YUNJMGVVZW4zZ0xGTDYzMG9ITGJwdC9V?=
 =?utf-8?B?bW0vQnkvZkVzQjdsUVRKQUhqcGp2TUlpMHpuSkI4L3Z6S3dPTUNmUkVja1dO?=
 =?utf-8?B?MWtoZ2hUVWNBdGZvZS9yUDEyV014WVBnbWIxMXdaa0ZDTXhCOTRma3lXYjNi?=
 =?utf-8?B?ZDg0WHkvS3l6VTdFcnpDLzZnWEdVK29wU0U5cXdGWkJ6d0xSbkJvMGs0NVV3?=
 =?utf-8?B?aWxFckNEcWRXbG5QdEhOZERUOGo4d1ZLbnZVb3NXMzdna2QzNFg1enl0SG1p?=
 =?utf-8?B?Q1NEbi9RR3J3RHN0L1N1cmZvYXVvakhCN2lMN2NtV25NWk9EN2lVelFOenZF?=
 =?utf-8?B?QUVGZzJHOXdLQ25hbjZOQXgzalRUbE91UWQxZ2hYd1JnT0orK0N2QTdoeE9V?=
 =?utf-8?B?NlFtV3FTaTVBbmVHNncyeU5lR1lnZTBJOVMxaXFGcjZwQjBTQU9CWkd6VVpR?=
 =?utf-8?B?by9rdzJuNDRoS05IN2plS3hpditFMG1rYUExZEp0WXhmb0ppYnMwOUozYysv?=
 =?utf-8?B?N2lJZlMzUzVWN2U1QjVxUU1QUDBFMWpyZk9mMVpuVEpWNnZ4aVRhdVpHTlBO?=
 =?utf-8?B?aU4wUEZaRlh6VDg3S2xGRXNuaGZuSkpBOTlrMHFKS293RGhyczh3eStLOS9U?=
 =?utf-8?B?R0cwY21wM1Z4b3dXNWdjSHpSMHlEV29BRjh3dXp4U1MvU1VRak9jb0J1eUpX?=
 =?utf-8?B?bUVTd0ZKbFFoN2dlK1dlUGJqTDlLa0I0aEllL0taSHFwT1NydDJzaUdVV3JE?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kmHZf+wN1uET2Ou7PKUiDeTfJcdR62aTAjeUPavFLZK7tKA5d2aPvo10+bYEKDj+vc+P8xPBAiY+S6BO5ySKXE1USHBMKY+mLIBh7OTQo5OTbxnX0D0Y3eVPIym1oeF4EjkgcK7ocIGzWay2WlJegr+kmnttydEhdLvBip/8wJx69yesFC4i5SzGN714Q70D3Cf0KiZo4XaQu+m8p4kKrt2aDEhGv9yZhRiDOIaO4XBjPSDX0PVh0Gio5LweV7Kvt2juq5EuC7cjwWuviwgDGjMvufZSe2fi9rnUIX1bH5sJFuccH7LdlzgRBTijhSv/ukqV9Z+v3SG8nULbrJxLn8X9FodnvClM+S+msm5atjOx99/gCIqCWdmKXPkU3fgXfDs3bAX5z38CJZ3RbZBPnk7/NtjjDFVUnIU8Os3boZBssKvKLRmg2RBJ50yUF7x5fLXxIb+WuW+BTO1RQiAO96LjgkbnyXgYo56ock23poay2CxP/q1oJgriF37dnnaD4IH5+i6j1Aqs28KwnOsyVUF5xv+rTq3KrW1TX72SmrKEySGIvHLKv8fCj+SdWs7kLdCHzWZJt4S/0q0b4yKUmx9iVocLF1xA3AVhAvekTEk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de8e9b77-be45-4e6a-b1dc-08dd4c449f02
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 15:39:36.7078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hpoi4lQeSjcVDBQqDhS6mjfkKQyyOxaZiiRN6hJn0K5Nst83VTggjBNX5RKrwIBvK6E+eORWQs8H8smeB1WQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_07,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502130115
X-Proofpoint-GUID: MiFXhYDvVX-GWCZTwVyqA11OlXq9mAcz
X-Proofpoint-ORIG-GUID: MiFXhYDvVX-GWCZTwVyqA11OlXq9mAcz

On 2/13/25 10:27 AM, Mikhail Gavrilov wrote:
> On Thu, Feb 13, 2025 at 7:18 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>> I need a simpler reproducer, please. "Chrome stopped working" doesn't
>> give me anything actionable.
>>
> 
> After applying commit b9b588f22a0c, the internal page chrome://gpu/ in
> Google Chrome indicates that GPU acceleration is no longer functional.

The connection between tmpfs and GPU acceleration is ... mysterious ;-)


> I apologize, but as I am not a Google Chrome engineer, I have no idea
> how to create more clean reproducer code.
> I only noticed as a Web browser user that when I scrolled through
> pages with a lot of images, Google Chrome got substantially sluggish.
> Hopefully, someone from chromium-dev will read my message and help us.

Understood. Maybe a better place to start would be for you to file a bug
against Chrome/Chromium, report the same information that you reported
here, and let them dig into it first. I'll still be here waiting for
details... if their issue tracker permits, add me to the Cc list of the
bug report.


-- 
Chuck Lever

