Return-Path: <linux-fsdevel+bounces-46180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 962F8A83DAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BD1E7AAA49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58FF20CCD9;
	Thu, 10 Apr 2025 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dJE3PYWM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TJt/JVii"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF001EB1B7;
	Thu, 10 Apr 2025 08:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275566; cv=fail; b=eWjZfoF9vwgZygalAWVinklIMPC92pg4xsB1yhtV0O+bRN2Nf4SuuhH482WD0H98EqhJPU7pRjLNUH9cPQmo5SBUmKSt62uWuPH77yJB/HANJczhMGLCgZj2qNfsd+wApar6S3G4mnEevAiG5sI7cxoZqqW0Djg95E9wb1se9bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275566; c=relaxed/simple;
	bh=BOiwRtbs3BPUCL7bvjOLmU8qYPJqrMXMWHLitHJfwY4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qS7IoFRc8+4tMbzMfHsmgILFWLFC4oBQJH6oiqtPEGc+MYqJPKEIwWIZwAMdmaD9lGyJTdLI15yGircckOcgTNkVi6YlRKg/sQCAly++5tnp/h1VU40o4S5ESqJGEh9KJTX4l1YUPrg6A8kBTpEzf62Bo/YFcXU898Oi67zxgpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dJE3PYWM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TJt/JVii; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A8Cp9X024950;
	Thu, 10 Apr 2025 08:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Da2OsozHMAmwn+1QUMML+w00+tuRwYh8zaBMDq37p7A=; b=
	dJE3PYWMFUB8bO9PRcdABYvRItbcGI1GBnoErdjanIfC3qECa5WoSv7Sl2DHtiwJ
	cgpxy2XlFFMsZv0dcJMYIbjztw6TebbDH+X5eo4QJfJJfXznCOrCYpnUfsDrMhTg
	HD+coLJ3hQxp8oi25/hU6XI0Yh3rn1ItUR0Ppqn5YypqESfND12UcmtC9pUc9iuY
	DqSEsOGljz7YVaDPkB9iabDM0nhPr9fQ4Jbe+oh13PyNejd0AbqoWGt57igmf4cP
	HyQhyYaB2azzzx6IfNJAbWt9SPXR1swOMC5Xynat/hqhAg0LXZOdV3Y/CpduI9jr
	7Gk06wNd861Q2DKfD2AY+A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xa96033n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 08:59:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53A8nEYr001648;
	Thu, 10 Apr 2025 08:59:02 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyby6kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 08:59:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhut6KtoIcpZ9nnFDgbhjywCz1fVKjUZq1BFo9zNTGsk1kVcYfSkmC/5cBdR6uqLJ6JmcyTV4nesTiNMyRlUxcZNMkx423NfX5nOuKxdQrofALg9tjdvu0jaAJrr9voFoDd413INKmaNcxv5u97njb7lSqk8X+lu4kAT5R6XMsoRB6ebwve2voRBp5QRWJoNnZ4xm56aZvrcGUdEXWEsvBsH/6lGPGcfXMqx0sFWYISwB6Ryq8sj6d3YdT6Q2EUz4R799/BECK2/qD188UE/0EUJqtoLMcesji5jQGxQPQ9udPONJb9F58jmr47j1r1M9tFGksGwrdJAluhWGwrjew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Da2OsozHMAmwn+1QUMML+w00+tuRwYh8zaBMDq37p7A=;
 b=Pd0NPq7ZoqmiY3GegKQMYNRvtR79BNB95ere8SjNV0i3nMpNSMyu4QI0R4mklfO7sLjYD2DFwyXH+JahgmQeVVoNORpRqs6w1tZBnfafUFFrGTpMX4VI2kL2bgzgcJirXeP2j69/NMQXrV1QAAgIjGKNqGJ3G+u/WbtQAlCS2lYHz1XrTNwGWw5JpPudZvkNkRyktpV8hn1o5bRb9kfwv1weKyVazKLZ6XlgI/Drdivwwc9J1dYmkucVyBFmQRuDt6wHLOHokJKgS8QblkmYiViIgWq2cjiAb5DjKO85Mn3pECY2DGePnFvOH2G6t4e6klkYb3OUtzdHlB/uabYeIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Da2OsozHMAmwn+1QUMML+w00+tuRwYh8zaBMDq37p7A=;
 b=TJt/JViiRy/Gn1HpzcDF6Xsxg7Ik8Y6hZ3ML1WZoXy/vIGa24mpVE2cAIzGI7DpX8hfl7vvY5ItY0vSiv/Vpk3p+uS7pCyKvdlf4VSIGrK+hfyxXnJair2IglPnKc99xtHowzFnSwqi59NLMyeEe7Fa0AqV62vFhKX/ZbCR4C+E=
Received: from DM6SPR01MB0118.namprd10.prod.outlook.com (2603:10b6:5:295::18)
 by PH7PR10MB7783.namprd10.prod.outlook.com (2603:10b6:510:2ff::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 08:58:59 +0000
Received: from DM6SPR01MB0118.namprd10.prod.outlook.com
 ([fe80::c04c:7e64:6721:98a2]) by DM6SPR01MB0118.namprd10.prod.outlook.com
 ([fe80::c04c:7e64:6721:98a2%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 08:58:58 +0000
Message-ID: <6793c64b-ba1b-4633-9161-6fe4662c4947@oracle.com>
Date: Thu, 10 Apr 2025 09:58:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/12] xfs: add xfs_compute_atomic_write_unit_max()
To: Dave Chinner <david@fromorbit.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, brauner@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, jack@suse.cz, cem@kernel.org,
        linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com
References: <20250408104209.1852036-1-john.g.garry@oracle.com>
 <20250408104209.1852036-12-john.g.garry@oracle.com>
 <Z_WnbfRhKR6RQsSA@dread.disaster.area>
 <20250409004156.GL6307@frogsfrogsfrogs>
 <Z_YF9HpdbkJDLeuR@dread.disaster.area>
 <ed53dc33-c811-4c20-8713-8d2d32cb81d7@oracle.com>
 <Z_b5ZK8H0pK0Saga@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z_b5ZK8H0pK0Saga@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0115.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::31) To DM6SPR01MB0118.namprd10.prod.outlook.com
 (2603:10b6:5:295::18)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0118:EE_|PH7PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: f84e5924-eb80-434f-9c45-08dd780dee5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YW9EdG1rNEYrL1h2RWJ3ZTJRQlFadkhwS0ZHVC81UTJuY2NPdGtHZXpWZnFx?=
 =?utf-8?B?dm9BTUdEdjQ4bVU2K3Rrb1BwMXpPdzJORjVCMUwzdkdJWTlLV3Q3MmNkSVFW?=
 =?utf-8?B?OE1mWjJyNzFzcytJRlI0eEdBajQzNFhWdHZzcmJBSDYvTVF2ZkFwdDBwKzBR?=
 =?utf-8?B?amZBdHBRUGh6NmgxNlFVVjFoYjhuT1kzUmdJdHNyenBmemkwQzRCbHVkT1cz?=
 =?utf-8?B?U09HVzRYZVVMOHl6dG5yMCtLRkMvclh2VXMrbkNVNFV4ZUd4cE00M3I2cnlE?=
 =?utf-8?B?cElsc0s0dmR5V3hZR0l2T1d5UzdKQ2VaS0pXYVR1czdvTHVRSmlQMktTL1FP?=
 =?utf-8?B?WFdYQ2puWThQbGZTMjlsWDJLNWloMll6eU8wNEY0RVF6MnpQOER5ejlISW5r?=
 =?utf-8?B?WDlTN1I0UzdBc012c0poWkNkbUkxTEJBZWs1QXJQUStnMHlEbFcyNnFYK2No?=
 =?utf-8?B?NmluUUVzc3F0dWpXd09iL3JoMGs2aTk0dmxFc1N5NHNqR3NoUCtEVWJRRXFB?=
 =?utf-8?B?eDdCbTJiTnFjR0NsMTloc2xGa0t6Zi9IV1VET0s0ekVSNFZoR0pqQnZGMUZv?=
 =?utf-8?B?SXZZK1JTcTlxb2RsTlBVYmFGdlJOSVVlUUNHSXhoUVN5cjFrVG1LOVpQSHRa?=
 =?utf-8?B?SFNhZFVISVZLZGdlYTVPQ05wbzlBLzBuc1RvYVVhWCtKVFAxYlo5Mjl6dm9Q?=
 =?utf-8?B?U29wakVSdTBJTGFyV0VIRDJ3NWhXc05VZjJuMXgxZzRmdnVmNW5vV2M1cFNS?=
 =?utf-8?B?TnBzekNrSksxR0F1L3BRRFp4dkNYTGV4dUo4Q1RuV0FwK1NDYVhkQlJ6UEJH?=
 =?utf-8?B?VUxad1Fkc3FQdS80emR2YUhpcWFkdzdhend1ZnhUbFczald3YUxhZWg4Z2Fj?=
 =?utf-8?B?RGNTN2IyQVRWZXdXa3Z2M0NrcFF3c0JoTkRBZDBCelozbkFyVERTaFRoVXBn?=
 =?utf-8?B?djNHbFVxVXB0M1hUMWZzakdkVU8zdWpnL2w3U00raVlwVjBLbEptM1VsY2Ju?=
 =?utf-8?B?QjEwbEV0Mk5MUjBPbG85QkdBR2F5V3oyeWl5RXdYZzlCQmJwUUtMRFlnT1ds?=
 =?utf-8?B?dHl5aDVxNk1yTXRQRk9iYU9lZnRnWGpRdktrbnBiTXVlQmY4cCttaVN5TDd2?=
 =?utf-8?B?Qm15WTRORVBCUWpkOFpvc1IwaDBLRW1sSmxoaTZzTmo1UjVTOVE4YUJ3QzhR?=
 =?utf-8?B?TkRoejlBZzZqckd3bnR2N0FOdkVuOUNsd0dxQVNUOElITWo4eW5Ha29LcktO?=
 =?utf-8?B?UlNBV29nazdUelpHS1ltQmI4VHJuKzcyV2JUWmNaUzR0aitOZnltRmVDU2lt?=
 =?utf-8?B?WWlkS3p4SExES1YwemFWMGFxUTJvcGFMbzBPZ1UzR1Y3WlJsc3VScWNPbmJn?=
 =?utf-8?B?TW5vcU5tTGUxaHJXVEVmcHJDRUszK0MrNERsMXQ5VG4zTkJFOFk3bUNhbDNQ?=
 =?utf-8?B?Q0twbytZV0J4K0RTdmpOdjE5dDFHSk14MWVJSzJmYnh0TXpBQ3FHblBjeVRQ?=
 =?utf-8?B?SFpCT1FVckVnY2VFWWE3NGNNTGk5OWFQMzdaQ0o2YkxGWnFuWW43WVVJUFlB?=
 =?utf-8?B?b3NZczhnQnRMeHFLTHBCelVQUUNmYUhXdVNUQTBEZjdDc0dSMy91ZGJEb2J6?=
 =?utf-8?B?c1hwUUNzY09RMVp6ZEtrY21JS3c1b0o2ZnZEckVzY0w2d3M1VERSWlFUMzdI?=
 =?utf-8?B?MStrakZsMzZOeHd2M1ZGVXI1NWVXT0NJeFJ6U05FSHZYbG9uRXliN2NSVlZr?=
 =?utf-8?B?WnlObzhZZFNEZG5ETVM5T0xiaVErN2pCSk8xbHBoSEJ4NGw3b3BpWXMva2t3?=
 =?utf-8?B?Zk5aOHpyMjM4aWo5c0VQSXNnUEJnNzdSYkRTMHAwdWJpQi9Mb2JUbSsyUTNQ?=
 =?utf-8?B?d3Z5eUk3WjhnM1dqd3YyOW1Jd3pRcGtqYlBKSWh1akFPNDRpNVQyaXMvSzg1?=
 =?utf-8?Q?JiBefYQWEOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6SPR01MB0118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YW1YSjNndkNORVgvZUh1ZFhlc3MxaUNxVU9xNVpDYURWWE1lSGlvOENrTSth?=
 =?utf-8?B?MUxoeC96Ukh5QVFrdi9EaW5jMDh2dkdFaWdYMXhjTGpVcUMwWDh2VUZLQm5T?=
 =?utf-8?B?OHRRVWxIT29SeHFCa2pFTzB0NzBRQWExdXRHam9nTmI1QkFDdHFJem9RWFBq?=
 =?utf-8?B?YzlLYWxsTEZCRmlQOWc1K3lNV2JBR2FxRHVpZXlYdWl1M21KNXY0ZmlwY2VO?=
 =?utf-8?B?ZHJTYkMyejFHdkplanhmR1BpU2Z6UGR0Sm9WOHZvZVJGQ29yTUUxUXM4TnpC?=
 =?utf-8?B?RCtmT0RGVlhGaFY1UjR3TWdoSnlUQjNJS01mcjVlZGo2SHZjbHh1cWcwRFlm?=
 =?utf-8?B?a0p6T3JwdXVxT2RLRVhoa3V5Q2hUUHRUaXpXTS9tRktjS0E1TDFWbm9wejgy?=
 =?utf-8?B?Q1ptVFMrV0JnMmdtbVZxVkhzbFkwUmF6N0dPUUhhRE5VYU9vdzFlSEN4V2ZG?=
 =?utf-8?B?ZVhKc2RmMEwva0EwT1BrM001MjNTZHpoVTZpRnowNEs3ZzdvazBYZHdPRjR6?=
 =?utf-8?B?U2l3ZXplNUVDUzZsOXNtdUd5KzBwMHRablhpK2tZZzR4Q2RIdHMvWkl6WTZ0?=
 =?utf-8?B?a21VQTM1QmNEbTFseTMrZFB6d2FoNW0zd3ZFdFczYTlVNjN0VEc2bGZ1NXRx?=
 =?utf-8?B?R1Y3c2VZWlJSSnI2eXhsMjB6c1RIc3R1UFJwWCtyRHhOMVdCVkFENHBYeU1C?=
 =?utf-8?B?SlBSUTNMK1UyTXRHNkpQQWJxS1piT0pvMElYSm1rSHAyZm11RklvNHlZdGY1?=
 =?utf-8?B?S3ppRHJJdzVKVnZZbktyRitzYXdycXNjbENXaGgwU0pUaW1oUWplL25EdG93?=
 =?utf-8?B?Rm4wVU9DQTBTc1I0QU45M3FIcWxpcm9uSmpza1hrV2hheGZWdVNuUmYvRmRP?=
 =?utf-8?B?ZG1Yb3dRRUNyZkgwaWd5SzdxL3RRZndpZG5aV1hPVGQrQ20wUW9hWUF3THpm?=
 =?utf-8?B?V3UrUnAxNzM3WGZ5M1gwMGNXMGZsQ2RPTEtCRUNIRzFuNUxWVGQzaUVBSTVp?=
 =?utf-8?B?TjFlWjAzdmZKNnRzaGZMeDNPZ3VXQUY0Uks0ZmJTdlNvMS9adUl2OUt1Sjlh?=
 =?utf-8?B?VHBxUStmT0dUZVhnUHBXMG02K1FNNEZDUVR4NUYrUmNwZXJKUXVZbFgydWlC?=
 =?utf-8?B?N2ZhbU52YTNheGhteUhqUkF6MnJUN2NXSTdHV3dsSEx1UTdCV2h2NDdFdDdK?=
 =?utf-8?B?dWh1TjhVTVVaM2k3VjVnalZDY3JJdzFEbWEzRDJaQnNKajdLOWp0TEI1RmY5?=
 =?utf-8?B?cGtYZ0x3MkFncURMVGpJcDhGeGptU3JiaTZ0ZDhia2RoelBTMVhId0h6UUQ4?=
 =?utf-8?B?QnU2L0prUVZ5RUExcWZIUlFhTUtoeWxxSHRVL2ZoajE4Q3FZSE9EU2cwU2Vx?=
 =?utf-8?B?ZENsUGtvL2xuUm1FOWJ3MDNlOWRUL1hWNVliUEJBLzNCZUk4blBHekF6Zzgz?=
 =?utf-8?B?SkRIdzkxcGV0R2hwT3o0SjFuamV0V0FNRjRnR1dUSVpsbGlKblJEcUk0eTF3?=
 =?utf-8?B?clVXMkx5emJNaFJ2anU3NFJUdzBrRTF6S3pKSUE2TDJjSVlFY2tGWnJDMkx3?=
 =?utf-8?B?am1BUjI4Sk9XR1huNGZyb1h1ajlyUnNYREpKUm1FRWpReTVqMzdvZVFWU21Q?=
 =?utf-8?B?S04rcnJxdHk2ODBKVjkvWWo1dHZBYUFNbjNNUXZKZFVqNFNTWERZR2psV2Nh?=
 =?utf-8?B?RDErR3h2ekFvejk4RkhsTmlFYnVkZ1phR2U5REUzTmJZTWNLNWRpMVBUOTJi?=
 =?utf-8?B?dlczZkdBYmJ3YjJHdzhLZFNOZ3RyS2Y2VTBBVkRZWENubHRxSHI1YWxvei9q?=
 =?utf-8?B?VXdlQmFORHFPZGdDdDgvb3BRa2NlVnJIeWgwclo4cGJyZ3JvMmtXbWFWbWpk?=
 =?utf-8?B?bTZDWnJROXM1NzFySGNIT29maWpjdHhWaUtpZnMvMHdHbXlpY2pwSkFUdGUr?=
 =?utf-8?B?UGZhYkw3L0pCQXJQY2FTOERubmx6MXVOMlNVc2dEOWg1anZOM2lpVk5KWGEz?=
 =?utf-8?B?bFg2aXYrOXZyYjBUT2V0Wi9OdENBU0tFVThoZTZFUFlJWXRUdERqRVd0N25D?=
 =?utf-8?B?QWd1ZGJQVUVxa2xZNVFOL0Z6dDNmVHFuVnBKeVhjSGdOa1RRcWROSGJJbERD?=
 =?utf-8?B?b0lqZEp6cENua244SmJkdzdwTnF3TEtYSStLK3gzUmZtajhibStPOXJGNjRN?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	N6g+UEJBLfopFF5tuXIvK5uoT+LNakdR4NArvmWjYr6cDepOU6YUa9J89IZeV+M9XX6T2BRbGbP/omsES+P7lFyNNVuUTSRG/EP3LOmQdZz/ysXLDKWSldmIuHwuyFnaacZB/rlSPKRf47Vm1qGZKJwWgm6XNiLSdt9UIpBbDtxEoeI8wJ5awQNflbX5ifkkfdLILaYHUW1gsi0AIGQUOna/NkJBwM6vgeRyPtWvriyj4v+Ug6o9eN/ruNPy5RTD2ucBb5+Fkt9A577OakUAZI6Ac4iVWGGbDko57WGeTGl5UO5Wc+S21eamByJyHQN03lvwifL2aSOCVBDf6xmcWppg9QH8/2fbI9pJC/UPag5CoKq9Yv9OZhndRxS7zee0zRXC1CAZ+gad/dJkCZJg38GAJH9NdZSOlfHVFNQjTRP1LqIQ9k26B3slitqadaRDFb+vgaN7JyiFEfrCENkCUM/r+BKoukMswxgV2nyvUJmDh5c6iCzH4d6HfITCZKsmkfh8gIqnk+GSztnlRFC8XovlzR5JmRRNifI/3Ph+uW38gQIwM2ThM8P5xEL+fchc8W9AsbEW+ec9mgAjRf5yIeOPSC8wlOY7XcctV37ceEg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84e5924-eb80-434f-9c45-08dd780dee5f
X-MS-Exchange-CrossTenant-AuthSource: DM6SPR01MB0118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 08:58:58.6817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71y5dAmGrWKvYeg+WrjcHtvjqAR4xnB8+jwd/Ww1StuvBvZa5LQnx94a2dL/V+iuEDh4ElYVHnUK6+iCpJivuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100067
X-Proofpoint-ORIG-GUID: w_YMExMOSS4dlmPM1CeelSJNuQxut1D_
X-Proofpoint-GUID: w_YMExMOSS4dlmPM1CeelSJNuQxut1D_

On 09/04/2025 23:49, Dave Chinner wrote:
>> You did provide a relatively large value in 16MB. When I say relative, I
>> mean relative to what can be achieved with HW offload today.
>>
>> The target user we see for this feature is DBs, and they want to do writes
>> in the 16/32/64KB size range. Indeed, these are the sort of sizes we see
>> supported in terms of disk atomic write support today.
> The target user I see for RWF_ATOMIC write is applications
> overwriting files safely (e.g. config files, documents, etc).
> 
> This requires an atomic write operation that is large enough to
> overwrite the file entirely in one go.
> 
> i.e. we need to think about how RWF_ATOMIC is applicable to the
> entire userspace ecosystem, not just a narrow database specific
> niche. Databases really want atomic writes to avoid the need for
> WAL, whereas application developers that keep asking us for safe
> file overwrite without fsync() for arbitrary sized files and IO.

If they want to use this API, then arbitrary-sized files will need to be 
power-of-2 sized files (if the user is happy to atomic update all of the 
file).

I would have thought that the work Christoph did with O_ATOMIC a few 
years ago for atomic file updates would be more suited for scenario 
which you mention.

Anyway, back to the main topic..

What is the method you propose that the admin can use to fix this upper 
atomic write limit? Is this an mkfs and/or mount option?

I appreciate that I am asking the same question as Darrick did in his 
follow up mail.

John


