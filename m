Return-Path: <linux-fsdevel+bounces-45839-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A20A7D863
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 10:46:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C85291891A51
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 08:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2C2229B36;
	Mon,  7 Apr 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IMjEwo2N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M3GM+e5f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC8221F35;
	Mon,  7 Apr 2025 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744015520; cv=fail; b=EUJWMNqlivVFyzQ4hOnydYZn8XdFRYBGHMju5+h58DdHsZcjakBqsVYfDsSNCsT0YGtybtBlaeYnmHRfzOV6gYhOQ9IHHkjZHkfRAVtf1oEw+LV0IpB+p6oooNoLV8f6DDBv75eDCO3XoVtvsH7j4d+CCJKBLtZozSRB+QcaZCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744015520; c=relaxed/simple;
	bh=Vxvx6AQR+MjnmXOeNykHt0T60EisfIAZ3FCG8ue3s/Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MwMADUY9PIhsvAAMHUP1qseUksRyKpDbORE99wCtRhj2DcSn3rnqL9qql1i+2AOsohdijbrS/Uy4Q2IwsxN8F0iQLc310CrklhzEFgN7Eq5qg9uyo+vGD59HqO533RYEAKpUR+UAxRq60xmMpQ7ZacJBMWEx3JlpnRVIBzdooUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IMjEwo2N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M3GM+e5f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5376Y2bb027334;
	Mon, 7 Apr 2025 08:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=cL0maHIP4aF5LEKX+s69C7yoOMgOw45+/DsLJRImVkM=; b=
	IMjEwo2NBj19k1Fc7cy5OH7GMhGpMDHIbAMUIN6mYphXtxG+fOtMG7VRmXrDww9B
	l4Xtmh9XigtN2QwVTsAiUsy8Pq4Fxp62rJSkLBRANEYj3iIRUSyRnGWA5ybKtp2u
	qczkUvtVyL7U2skIVfMHf1LM7f8dS5xUpTJJ+cy864ZdcXRG4akhvXoUnRSJg21t
	pZ7O8MlRPW+x+v8+KNWJ2dwk3pNvJ5Ru7EQmoUCcMW8bQqdavQg2Aslr+ldW/lUM
	o+O06gtHeAFDxIAgsFVgqUcwUVoSsyVCPFZwmh1mh0+1o3LbdRrovKZrzocZVUjY
	rpVFZR225LPBuRU5cyrZ7g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45tw2tj27r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 08:45:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5377Yg9W013708;
	Mon, 7 Apr 2025 08:45:08 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45ttydr9j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Apr 2025 08:45:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NCOFMoARmc/73duGxeiIOVSVvoFDOIjSNd/AxiVcKsa4xdNcyRU96LpFe1w+/IHuzumbfo3EcLNxlJBnqzl1gEe74/PsFvuI3OoVWBQGWot4gnj4VLwJp/ksMrjnyDpPYge30ct8ivls3r0OuNXV9l+/XmdZeOotNfKY+Rt8EVqig+RyUL1gVsqhktlPerixlfQex3AHJ0D+gxBu6hw7mEWLXKJOCUbZMYUDTSmKBy5KcxbHapaeAGNjguG3wX8oAiBc9tbXKAytvigLp1V/mEjIFnfdLdNxTNtDEz7qI32PYc2YH+MfWJmXEu9UNrJUCjc2Ur59u41tV4g55MU2Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cL0maHIP4aF5LEKX+s69C7yoOMgOw45+/DsLJRImVkM=;
 b=sSct2KLvamIKzf6FswL1GCtrdnhmfQxgyIN9/6qtVjbZ1D6JDLgb117HevsO73fOXrl/apLys/Vj46dWF+0lca0tB8X064Smk5JUG7xXDlA+dEDcsNYyJB6L0C/pZmLyy5G8+96mxMXs7OM2yczxjPQc/pEPapcvvwZkxcE94Ai+U4kio/khk9JOF63XP6nQuG8cE1E6zHy7Tf3BEiLgeOO+2SE+5FXl3DWZMGF+odYj1wsnrxNkb0QLXuX814213w2Nvo+U/KN/B+BT4Ijrr95whlReAtHnV9nsUljezvM9tkVtoJfyDNz1PvsQVvMnxiJ9AYGcpvDKuleE2Z52LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cL0maHIP4aF5LEKX+s69C7yoOMgOw45+/DsLJRImVkM=;
 b=M3GM+e5fdcDAqcjuyvujji7l8MeAl/VA81M5asbVRMQru7Q66eX6OLYKDqAmrMHnAfMaaLGtyfNCyNgAgP248zRLRLp4ypUs7cdGDGPDfnMItK/hn2UlHOIodY7PWmZGwW7GBO4vqCk5UBGz+wvWvXkhGJ0HLkmD2hcanTvl8R0=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MN2PR10MB4224.namprd10.prod.outlook.com (2603:10b6:208:1d1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 7 Apr
 2025 08:45:06 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 08:45:06 +0000
Message-ID: <9831a558-44a4-41ef-91c9-1dd1994e6c1f@oracle.com>
Date: Mon, 7 Apr 2025 09:45:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Documentation: iomap: Add missing flags description
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, linux-xfs@vger.kernel.org
Cc: djwong@kernel.org, ojaswin@linux.ibm.com, linux-fsdevel@vger.kernel.org
References: <3170ab367b5b350c60564886a72719ccf573d01c.1743691371.git.ritesh.list@gmail.com>
 <cfd156b3-e166-4f2c-9cb2-c3dfd29c7f5b@oracle.com> <87ldsguswz.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ldsguswz.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P123CA0002.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:354::13) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MN2PR10MB4224:EE_
X-MS-Office365-Filtering-Correlation-Id: a71593db-81b4-45ba-8dfd-08dd75b07f16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VFVwTnlYaHJheTV5b0hXbFlyZUhieGJoS2ZLampwS2wrem5yeUFCSkRxamc3?=
 =?utf-8?B?OWk1R1U5VWlIS2xzNWs3VWFCUEhmZjJmUnRTY2UwWVN1ajJTZjcrQzhwR2pj?=
 =?utf-8?B?R2I5WkNoQTRaWkt6MVBlbC9qanoyQlMvNmhtWkhaWWtNbVlvUk5uL3M0SVg5?=
 =?utf-8?B?N3puaFdDc1V3NzJ5a2Y1RFZQL1BPMnp0L1c2ejRvbUpCTS96Zy9mTnJJbVZw?=
 =?utf-8?B?QytFbTZ3VExVcVVCaStNZWpLR09xY1o3Wlo3R1NqQzcyWWxIVzlzakk5Y0Mv?=
 =?utf-8?B?T0oyamZ1c3ZaZzdhNllURk9YWlk0aFgyUkZBdUM2bXlOa0FzYzJ4UGhRSHBF?=
 =?utf-8?B?SC82RGVtMWxrbURsdTBOV3Z5c3R2STR2Nkozb3M1UUF2eEx5WlVudjJQWkdI?=
 =?utf-8?B?b0JTTkVrRjVhS3h1ckdnVHpzRFdIOEJHVGJraGdHM2ljd2RXR251bU9MK2xl?=
 =?utf-8?B?T1h1RDZKd1diY2srN0hTbjhaTkRPVzZnWFUveG1nd005TUx4b0tnRzlYTStQ?=
 =?utf-8?B?cVdSRnJVRUcwWHhsMEZDTU5pWG9yMld2TE01bU5keE9yYTJnWVlHbGtOQ2oz?=
 =?utf-8?B?NUo4T2cyUmMvZ1BUc0dWUUFpMHA3dkt0QTZ3ajZLZ0JGMVRFd1ZwbVFQTnMy?=
 =?utf-8?B?OXlZcDB6RldJdGFGYVFQNUYvTVNXMHpDSjhCRy8vWFZVb2NzR3JJQmhjME5C?=
 =?utf-8?B?enY5TE1qM3dHVDQycUg1UnlTRkE4eitNdTJUcUd5NnAyOFhMd1AwY3UvcVVX?=
 =?utf-8?B?OEdzaFhGR1JrOERWdjhFSFlFVnA0SFNNZWhnQVF1MlBhOW5BMCtKcTZJZ0tr?=
 =?utf-8?B?dXhvSFRFUW9kUi9XSTZQQXhOcUU5TFVUZEpaQW9PUTkyVXhMNk11RUtjMUFD?=
 =?utf-8?B?NEpraVlUL2w0cVRJWEpNRG5qTXdhQzJySUw2SEJDeEFteEdEUkpHVGloeENR?=
 =?utf-8?B?RHlHSGxFeE5QZVpsSC85UHBFeDBVV0QrSWRLRDd2eC9HZXZtaUk5d2lQbm01?=
 =?utf-8?B?aDNvZjh5NFlWc1VGSHVPUlFTZTMwUVRIZFN6RGQzaktLNzlvcEJtSUxkTjRH?=
 =?utf-8?B?c0xxNXpFV2VrcFl5RFpFMWlSV2hpTmV1eWdteHhocS9ncGlkM1RiQmNIUDhk?=
 =?utf-8?B?R09Vd2U2Yi9aOFRiVTcrRWcvYzFqaG9YSUh4ZlhLWThQdDhENmlQRmxnbmx1?=
 =?utf-8?B?Y1BwODZvWTc2dUpkdjkzRkNiNTZaTk1sVkVzQlpJQzB3SE9YcTd6b0N1RnU2?=
 =?utf-8?B?ZU8ycXRQZnRYVkgremM1dWRMdXUzV0g0YllZT2dHMGNyYmp6N0xEenFoWEE0?=
 =?utf-8?B?cU11bVBmcVdSczdET3l6NEsvWmhVZkQ3TGx3RjlGZ3FWbjc2ZzYzZU95bzUr?=
 =?utf-8?B?WGYxL21TLzdvbkN1WFlJVHNJTXQ1bHFNQWl4T3JJQ3kyZC8vOFVhM2o4NjBJ?=
 =?utf-8?B?ZEZyeFFRVTRTN2k5VldhTm44bG9oZ1JXazV0K3pTM0VLMUlraTVlZnpCeEJO?=
 =?utf-8?B?QlpLVjkxQ3lYVnJDamxIUnNBYkxPS29Zd0ZEMExYT0l0ZklPQ0sycDFqaHhP?=
 =?utf-8?B?MnlLaUorTmFyeU1pVXp6VS9yOHJaVUpqamNaQ0VjTWhCYzBJYmtOZm1LYjdo?=
 =?utf-8?B?V3g1d25KQzFMUzQzcDdxSyt4Ri9RVVlldUVDOEVnRnVjZy9wR20vTGdTOUd0?=
 =?utf-8?B?MUJVUTd3aWF0NW10Yk1ZNlIvWGlGZ0JvdkZkTWFMdDlSU3VpdDY2aDlsbi84?=
 =?utf-8?B?VmM3c2k3angvWDl4VVc2WitMV3ZCRGFlVlRKcEZheDQ3TDNtejYzTVNDV2Jy?=
 =?utf-8?B?SjNGUlMyTjVaeThMMkIzUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkFhTmRXQ1U4UysxMkd0Mzk2STRCem1oRy93dlhQeFEwSkRQbzFXZXhQK2dO?=
 =?utf-8?B?UzhnRWsxMUsvWDBTRXdZNzFPVEhOaTVuSnl6a28yR2FmY0hIZjA5am8rcVl6?=
 =?utf-8?B?Q0wxMmlnWTEyS2hqcDJNbTYzRHlKTS9OMVhaWHFSN0Y4MHd2SklpYzJhUXZR?=
 =?utf-8?B?TnRXNmZEK1RLL0RmOE1PT0hHZ2JIQ3JQOUwrcmpSaU8rQWg4LzhacmVRalZB?=
 =?utf-8?B?SWhtRS9sbXhMTHNLTmttY0cyT0tzazh6N3RXY2RVK0RoSEZtMXpoVjlsT1hS?=
 =?utf-8?B?SUN6eEZCQ0wxbTBWQ3NLSWFsTnBpcFk5SmJRSlFCSUdWQVRvRG1OQkFFUHVX?=
 =?utf-8?B?WW5jN09aYnR3TWwyNmdDNjZqR2ZtVEZEUkh6cjNTb3VmYkE1RkwydXpYd2hO?=
 =?utf-8?B?bStCZm9RUENpdDhtYU4yU2FCZk9JdE9KWDlGZzV6VElPL1VnQllXdjREN052?=
 =?utf-8?B?Qzg5UnkvUUQvV1ZUZEY2aWg5eWJDSmh3L3dHMHVpK05aaE1EOUlYWDJQODVy?=
 =?utf-8?B?VzZCTVF1OElrbFFTOHlnWk1scnkzMDZweEpoWmg4dk9oNFN2VGxkMUNXZmtN?=
 =?utf-8?B?TlVzNnpaYTFJaWg1NW9LWFhyUFBqUmVZcGdnNzRlWG1IMTZxK1FpTTdiRkZH?=
 =?utf-8?B?M01PV00rNjg4bStzeGNpbFlmQnYzZnJVaEhZR2NjemNTbjAxdEE0RnBvZnh4?=
 =?utf-8?B?YTVJV0VjZWpyYTVZd3gxRk9ObW1WTXJWZXRqeGNadTdnQWlGcC9aRkNNYmh2?=
 =?utf-8?B?ZVVRQVhNMW5IMmR4ZlFuQUxrdlYxM2Z1QXFaY3BKV2RtMFN4NXdmUGJwVFp3?=
 =?utf-8?B?TU9Bc2E2MjRqSmExa0hpdXV3MEhMQ1ArbEU5TWk0bk56amVIZTZzSkdLTnRV?=
 =?utf-8?B?dDN6VkNQUUJpR2t3NlRpMytmSWVuZDNBR213R1RVdWdENWhmL1U4OXZjS05U?=
 =?utf-8?B?bURSSlhaZFQ2M3lFQ0NoYXVjMzR2RWFBc1c4MVp4SlNrRlRSWlJGem5OQnZF?=
 =?utf-8?B?NVJsQ3EvK1lXTDErY3FzSWJURnVuQmEyaFJoaGd4Rjh1TGFmSGFXanNYb2N2?=
 =?utf-8?B?N2ZxR3hIVXVpWjNreTRYWHUyaW14QXdZZEl5K2xKeUZtR2dUWWp3TjlDd0Ro?=
 =?utf-8?B?ajQzVndQVFVNQTM0dUxDNWtEYm1uUXREcXhnNFY4dDBsQm9MRUtCbExySEw4?=
 =?utf-8?B?Y0FVOEYyOFBlMER2MXU2TDVmeDZLSXpXa0V5b05BNFhUMDdBR3BOVzdtWW9Z?=
 =?utf-8?B?KzI1V1hiN3pqQlVTcmFWVFhPSk9XeUIwTGplcWtHNi9HcmVmb1ppWEJRc1Z1?=
 =?utf-8?B?anVtcXUrRC9CbEpXM2FFemZlM2k1bGxBdURXMEE2SHlNRkZnaThuVU5XOHhx?=
 =?utf-8?B?eUpHMjlCZVlURGNDdHZIUFhiOU4rNU5lUHpUM2lIQmdrT1JOTTNJalNIelVv?=
 =?utf-8?B?ZDluQVltV0k2cXF4eDBrd2JCWFlzOUw0RHg1a0dhcjBraGJZOFlxQVVCV21B?=
 =?utf-8?B?RWwyazRUQjdFZ1orVFlOOE43T0MyNzB6N0MrZXdtOCtycEhzSHpBSkJyVzZD?=
 =?utf-8?B?ZndtZ1FLcDF6OHg0emxNWWxBb1B0T3p2a2NweUx6ZDJiZXQyTElYQWhQRlNB?=
 =?utf-8?B?ZWtzb3ZLSFNWQ1krTThLWHB5TGdKVE9aOVZBb0N6V0g1SDdoZXo1VWpjaW5h?=
 =?utf-8?B?UGRMdVhjZ09jYnJZUGZVNVNHY3Z5ZzRQbHZjZ0ZhYzNwREJieXFxaUthNDJG?=
 =?utf-8?B?dE1BRFUwMk9GT05POURBdFZiT0tPTlNQSVExSG1wZGxqUlMxb0pCUXJ3bGpX?=
 =?utf-8?B?VVBBcit6SkpHNmFmVGJlRTEwWkJCTmNlY00wMDNNR0lGNEFOZ1ZISkxRY0h6?=
 =?utf-8?B?OXoxVDdIbnd5NE5YT1JzUkFXYS8yVFJ4Yi9tUUVrM1I1TmFjNHE4ZlljU3VE?=
 =?utf-8?B?SkhybS9XTEJxTEl5OXhLMWQ3eHdUME8vaFhKVnZxVzZhd3pPT1V5cHFxZlI1?=
 =?utf-8?B?TTZHNTRVVmhVenpocllteVNnYW8xcTlKd0V1TW82RXFrMkVjVkZRNjFwcVdt?=
 =?utf-8?B?RHRlbG1NUHg4bGFsQ0RnNTdWYU5hM0tYbm1TR3lhWHNuaW1BVkV4ZmJROHVP?=
 =?utf-8?Q?vBb31/AojXNVeRG1P1V416yRf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Nb1rQhF7NVh7Fph9n8KJSXUPodZj41xu4ttsob6Js5pw8+dvJI3LTkBEG/RLNZIBvUzID+h8ctudx/SppEv21mpW3JgV4x8lhva2iYDTUXzzR2l8pLtO6B9GxSiESygD0SnisSYx47vd1KTprIKLHCiPiKpK6xe8FYsySkHVV0aJkK3zdEmLWc7Fvd3osrwmYrsgu4JGqRdfpu2x/M29dac3Z7xTya0h7Z2dPLsdfouqWQTiHVkJbj9a2dVxfXe3Kdk9LQLvA8/iEo1TG5co5T7UqIKsgBhz/kW2HXaXKarRVZetcmmJohbWQHFD9hv7Rr/36ns2D0urZUZ3vdrOonRs6CmjgW6WLb1xpO2gqIqClRwJqRtqNHL6YbFA4OPQnatjed3VfgxpTJT2V+m/iZ2RWem4xJqKJNtoxkwa1tB+70vborQQ5mHPzJMnqLc1ENROpMuozVX753xsMfxsPVU/ZEaBfcrAuIPmG6GopVNrPzK+2qWsql1qsGQMYSfZCcj5RO47iHKEI0wU5pG8QwsyIR9YF1qWeFg1CPtZttrjlcJA+0Nrjdjj+wnv1YQ/2DhCy+LLnPyU9HxgYg4HPZckJu43hYulnRV0FBmil9I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71593db-81b4-45ba-8dfd-08dd75b07f16
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 08:45:06.5392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CVW/U35wwkxcwGUi2Ceo0rXW/QrgdQ12iGmL6muN0WqBSuUGHSd+IceTCyv1W0j1Ras7Q7WjUtEEyl/4bd4ilA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_02,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504070062
X-Proofpoint-ORIG-GUID: zbAQZTkxikvDJWKJdk0pdKVTwmlRg5oG
X-Proofpoint-GUID: zbAQZTkxikvDJWKJdk0pdKVTwmlRg5oG

On 04/04/2025 11:23, Ritesh Harjani (IBM) wrote:
> John Garry<john.g.garry@oracle.com> writes:
> 
>> On 03/04/2025 19:22, Ritesh Harjani (IBM) wrote:
>>
>> IMHO, This document seems to be updated a lot, to the point where I
>> think that it has too much detail.
>>
> Perhaps this [1] can change your mind? Just the second paragraph of this
> article might be good reason to keep the design doc updated with latest
> changes in the iomap code.
> 
> [1]:https://urldefense.com/v3/__https://lwn.net/Articles/935934/__;!! 
> ACWV5N9M2RV99hQ! 
> M5YtnH5eBpf0C629QX_zsHZjxSMfWBW8svEup_qNhkg2ie5uqB81lAEO_3DR2pKKSYqUZgLGXiUyQUqi_mjMeZc$ 

I am happy to see documentation, but I think that there is too much 
fine-grained detail in this case.

For my large atomic writes support for XFS series, I am looking at this 
document and thinking that I need to update it again as I am introducing 
a new error code for iomap_dio_rw(). I don't want to have to update the 
document every time I touch iomap or related code.

>>>       * **IOMAP_F_PRIVATE**: Starting with this value, the upper bits can
>>>         be set by the filesystem for its own purposes.
>> Is this comment now out of date according to your change in 923936efeb74?
>>
> Yup. Thanks for catching that. I am thinking we can update this to:
> 
>     * **IOMAP_F_PRIVATE**: This flag is reserved for filesystem private use.
>       Currently only gfs2 uses this for implementing buffer head metadata
>       boundary. 

do we really want to update the doc (or even the iomap.h) if some other 
FS uses this flag? I don't think so.

> This is done by gfs2 to avoid fetching the next mapping as
>       otherwise it could likely incur an additional I/O to fetch the
>       indirect metadata block.
> 
> If this looks good to others too I will update this in the v2.
> 
> Though, I now wonder whether gfs2 can also just use the IOMAP_F_BOUNDARY
> flag instead of using IOMAP_F_PRIVATE?

I'm not sure

> 
>>>    
>>> @@ -250,6 +255,11 @@ The fields are as follows:
>>>         block assigned to it yet and the file system will do that in the bio
>>>         submission handler, splitting the I/O as needed.
>>>    
>>> +   * **IOMAP_F_ATOMIC_BIO**: Indicates that write I/O must be submitted
>>> +     with the ``REQ_ATOMIC`` flag set in the bio.
>> This is effectively the same comment as iomap.h
>>
>>> Filesystems need to set
>>> +     this flag to inform iomap that the write I/O operation requires
>>> +     torn-write protection based on HW-offload mechanism.
>> Personally I think that this is obvious. If not, the reader should check
>> the xfs and ext4 example in the code.
>>
> It's just my opinion, but sometimes including examples of how such flags
> are used in the code - within the design document, can help the reader
> better understand their context and purpose.

Sure, but you need to consider the burden of maintaining this document 
and whether it is even 100% accurate always.

