Return-Path: <linux-fsdevel+bounces-36827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E71719E99DF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 16:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F41188953A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2024 15:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2161B0431;
	Mon,  9 Dec 2024 15:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VXf1vVWc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YhOCYP5o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F77A233132
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Dec 2024 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756482; cv=fail; b=NA3NxPwb4YyrSTgnGXlAe9gopXACt74un+YAZ6iCYhJajoVa8oeiC5t2BPP7nhUE+mgGVEsUuTxdeMnkj3YmmMM9afHQBEUNJyH+INsGoIAvluCEuK4NFhcKbBuI0uZfBNEhYlADg6s8FlBd75Nor1Q3VgDD7hDBeaddEO165lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756482; c=relaxed/simple;
	bh=5yiAvvj2GIcz2/OQgmGbPTrgT77VLU700Be8ZY0AIPA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hZEQsQw7rs0jSRcckt5vKsnpMKIsj7tvRsKLuTaRtzvmlvXOBh9BDPU3h1hb7AhVkYJWpc8KQkcfR3H7xnIlh3SogXGZh0tNXKvXvWC9ay/ckp7cP54nB/fTfRzi7gAvzbaO/Y3p/G5FZnAwIDu+o1w2eqCtpkZ/673DMbISypU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VXf1vVWc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YhOCYP5o; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B99hEBQ004465;
	Mon, 9 Dec 2024 15:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2uqPcAAoFalxiamziUHsP82bb1jc8IkxAdlR/F9wZtE=; b=
	VXf1vVWcv3bZqYYz/BiS/K8CRxv5/Z/Z1/h7Iaticw3JEcl+xHtIX7N+PxeVgrXd
	/ud5d4yRtCPGaMQrTrEYMET0U/OEWR6hauFeUtuBx9rTSRq+lHGT2fLlJgO18o64
	42kBCPqa/4BZiIFaT3MSfZ2oTsXEPyZyZbc9VqRIUq56iGMpRLCQFM6G9mGhsdYA
	jlYJiXLBckdCJ+tntWMRd1tJUtCL6FcU4QUZQYkAGru4+CY/VyAoqAZMlrlyl75n
	AZIII97rZ+rBhm6nioal21/hbPl5ErngfIX8lWpqVJYXlIQkg7xFArKGQmhtOTag
	dzufC++lpHtFO9z0mWaARA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43dx5s0k7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:01:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9DtkLN008679;
	Mon, 9 Dec 2024 15:01:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct74h8e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:01:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F+HNhGLwFKpFO9hkh5VzKWP7XThXRRpCl3GIysohGKDh5bH9dd88r068RTmxUVbr9C2YTrJ3DadC//AuBSza4h1QuP83R1l77rLbZQE1sjGPu5jMTEKRpU5BgDulj6WMLijPFYf0/aw9cHuNd8BoHfH1twAdiIoFm3UNWW5K1CJxaTwM1kuamWNvTYmSnTCkNR4TUfu+SiFRbHHvNVjAsO0m+elI+2pp8oDRkBTY6wp0B1VMLBmMJwS1/gL8t7VfV3nqXaqs3IZ9y+R9gaHAQDDpirbOktXTGC44tYT6YiMzbIXEGfqw3M3MMz0eicGo7VSSEJ4+yp6D6hcOEl2BKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uqPcAAoFalxiamziUHsP82bb1jc8IkxAdlR/F9wZtE=;
 b=dSJ0yQhLbyCe1IY/RhiGOJDCRtsCe3U6F7cvxSnHJqHLt6GsOw6S/0592UQ0JsRlpsE1ZG1b8EcJRZYkRf0SaXUX/oQY3L1McDr4clfJmYXScEMjSs7PBwaByXmV0aqocSHM+JaKdXnUA7ndJIHGO+dzgzr9e2XBMew+RRGPxvXQQQsrs7MTbaDN3UYMFpepeghltekhipPP3yVsgFTFTp6eRXsGBQVr7v55looreTj1r3Q1WY2gOaNVjw5X0Zo/X8oBFvQPudOG/uT6B6Q/dKxcfVZ3Y5WJZfSYDQ6Vmb6Sc038PmTJj9UAL0Vgmd/kXgIiiOVIqvwRTmxh8SrsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uqPcAAoFalxiamziUHsP82bb1jc8IkxAdlR/F9wZtE=;
 b=YhOCYP5oVM2aeViBqhZjsw9CcsmVbMSzhSOzbrKLC50HD+J0hZfWYxXfKWJicia4PRzmshjwpU3ui6YuA6EPc5qtGbywVZek1e3Fg7bUP7cgwqSoj0dKrN8a32dQ7d6hZB1POrpKEM+yPqkF7hC67LK8xj3vVkUX6fW4dDaki/g=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CO1PR10MB4433.namprd10.prod.outlook.com (2603:10b6:303:6e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:01:00 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%7]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 15:01:00 +0000
Message-ID: <6dc5c09f-e1a2-4296-93d7-b2cda471a73f@oracle.com>
Date: Mon, 9 Dec 2024 10:00:58 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: disable generic duperemove tests for NFS and
 others
To: Christoph Hellwig <hch@infradead.org>, cel@kernel.org
Cc: Zorro Lang <zlang@redhat.com>, linux-fsdevel@vger.kernel.org
References: <20241208180718.930987-1-cel@kernel.org>
 <Z1b1d3AXTxNhunYj@infradead.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Z1b1d3AXTxNhunYj@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0059.namprd18.prod.outlook.com
 (2603:10b6:610:55::39) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CO1PR10MB4433:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a0cc759-f413-468a-ad4b-08dd18624aef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TzV0Zjh0RkhnOHFQcWVqV3NGQ2h1Q0pmcXF2L0xuVmhtcURiZ296U0pLTGEy?=
 =?utf-8?B?b0FLSUNjNUY2amo5aHkvYkxJRXhBQ3gvek1xMEtPQm1HOEhwUUs5VHVjOU4y?=
 =?utf-8?B?cVc1RDlWNFlJVzlXREVMSENYbmpHOXl5bXEyeWliajFScXMxb0xIZHhIeTRR?=
 =?utf-8?B?ZlJTdzRzdGZzODdacHEvVEpJaFpjaUtoT0hPZWl3MENkTXJLRGFnWWoyUEZz?=
 =?utf-8?B?dW5oQmJ6QVdpUEIwUWw2NGFGVUNHdTdTN0NyWTVGS21ScW1qdmk0dlNjbWNi?=
 =?utf-8?B?bHFHazhCZnloaERiQ2puUkxGSUJHWjllUXdjREVwR0JLYlkrcEYwQlRNSlRl?=
 =?utf-8?B?anpxbHVPZ0JkWjVXcUhRWUFBTFJ4cVd2MTdYRkpXWVFGY1dBSVlDaE9nVk8r?=
 =?utf-8?B?bHhUMHU3YjhvTVlxbmdhMENLaGd0NzZyVGpHYzdSLytLakVkS0lnNEpIZDlx?=
 =?utf-8?B?cXNoSmRWdnprTlVGSWhYbk8ybVdRYUFFdDVHWnFlV0tMK3ZXSUs5cUQyc3ps?=
 =?utf-8?B?a0VsK0ZkMVZHYlhwOFo3UllBeHEybVRBdnJEanFPZ0hmUnBiRDFPTHphM1BW?=
 =?utf-8?B?WThORTFvTExQY3poaEx1YTlmcVdmUjhUdzJ3aUdvUE92OWNUbCtlbThtb0ZG?=
 =?utf-8?B?T0ZXSW10MURIWFZ6dUoraUtMQ3VCL3NOM1RPcmNyZyswK0UxU1gvcm9COXBi?=
 =?utf-8?B?TzBqSEZ6M3oyYlVWaHhkdjk1a0Q4OTFxT2N1U3RIMkRiWGdxdDlMU3JlRFI0?=
 =?utf-8?B?TVBxWWxmVitXNnkrdUtYVTMyOXhkaU1UMFltQ0pkSDdhMkNvTk5kZGN0bk1J?=
 =?utf-8?B?S2FZenBRN0VRQ1dzV3V4VkUxZ3ZlbzViNG1ZNnpuclZxSXJpdi9GWjFGNm1W?=
 =?utf-8?B?TmtZSkorZmpSVVY2NE93QTk4emdzZWk0akFsWlQ5bVJlYURkU09uZlh0cWsr?=
 =?utf-8?B?WUgvSkNuL0k5RGp6NWR4TXFpZSsvc0lQQVA5U3BibXAyeHJQVnpYS3U4VnBR?=
 =?utf-8?B?eHA0dHJRZ1pNbkVvMFI2UjlxL0tHOTVFS1FpVjVsM2RvcVJyd2ljRENKbVV3?=
 =?utf-8?B?Mm1NL0lDVkkzWVVSY00vd2hMYi80M2xNZWVtWGVxRWk1MFlwdkh6cE8xQVUx?=
 =?utf-8?B?bDF2Z1pDeWt5WkNMajF6dG9PVEVHMHlUNUk0WjZkUk5mSVB3SVlBb0dNMnBM?=
 =?utf-8?B?MVAxeHJyM1FqSGZTQmZVQ3BxZ3licWdPenBlbHVCRzI2UjhnU0Y5MnpHTTlO?=
 =?utf-8?B?bEhsUDFXRThIT25xQ1RMYWlYSW1iT01JUWdnM0JleUNBb1RDRjR3bmhybERO?=
 =?utf-8?B?ZlZ6NGoxM3pmamhqaVViYXI0OVNTRnUyano1SVpYbjJ0RVVWT05yRkNEQUlT?=
 =?utf-8?B?dlF5Rm9sWXh3MUNUY2ZoQ1B1dmhMY01LbUUvTU1UUFV4bS9aNTZ3TVM4aDdt?=
 =?utf-8?B?dEhZbGRYRkQ0aFFWK3BlUjhSNk05bkNlelJTM3hNcnc2bEQ5YjM5YkdrQ2Fo?=
 =?utf-8?B?UW5xY0U4QTNpa2F0ZG9GUGN4RXVZaktyZm9KaUs3Q2xtZDU2YnBibWQvMlM4?=
 =?utf-8?B?eTNUUkd1aUtXc2c3alp5U2VvRVFwZ082eUpHSm9kZzNqOXJvd3dJRXpwT2c1?=
 =?utf-8?B?SXNtZXdvVyt2Rm1lVmZmb3AwY3RZQ21GWnFGd3NkUzRZdXdWejB3NzRkd0k3?=
 =?utf-8?B?elY0Zk9pckEyRTBkUUNGbzRRRGlqbU5RRTlldE5CUXpIZlB2cm4zdUdMejA3?=
 =?utf-8?B?OGE0WnVBait4TU0zK3AwWitiYndhL0M1YTdCT1h1bnREV2p1QmI1dklvWDA5?=
 =?utf-8?B?eHB4bDVaM3ByQzZKb2hkdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eHIwRUJJRUZqM1o4WXBPYmhUWkloRlM2QWd5L0hoN3BHbjVnUGpGSy8yREZW?=
 =?utf-8?B?ejQ3Sk10UktsNUt2VkhLU2dFbWxnTGxvTmJ5d3RvdDR4Y3dwV2xhRU95bHFz?=
 =?utf-8?B?WmZmSmhjQU43TkRXdGRhUXVzUmNYQzRCMW9TUFgzVlN6cll3aFhSK2puVWR5?=
 =?utf-8?B?S1gxbUNnVGYwR3FEa1JvTmtmYitINmx5SEtHZGdtSWk0eHg1TWFtM2RFZkNB?=
 =?utf-8?B?Sm9oU3dQOUhyNVRyNFRSRVBnWnBjUFZrdUd1R0llK1ZEOW81WXkwZDVvU2Zm?=
 =?utf-8?B?WXhzTzF4c3A0TnMyK1lRKzFwRElZUGhWV2h6Z2g0RkloamJlbCtXVTVJc1Bn?=
 =?utf-8?B?UTFWQWJXMDBkNmxFSGdrVHh0Q054RWxyak1oMTZZb1FwWFpDRGhIRHh5bmE2?=
 =?utf-8?B?MnVLS0JLU2hKU3d2WG45QndmOVhNeXo2UWZ2TWIwd2FFaHhpVVl4Y3gycTBO?=
 =?utf-8?B?WXl0RFNROUp0clNlUDZ3Y2FzTCtkc3VqWmVtUVJ1MW9xMUpGa1BLdjJWelpE?=
 =?utf-8?B?QVQ0TDZaODJlNXNXdGRMWk5pMm9FOFVwYUlXTHd3NGJjZjNJTk1xTUJEblBK?=
 =?utf-8?B?OERveS9najZ4QzVRVnpmYzBleWxMMktYTW91MWNOOGtIcVVKeDlSSjFVb01W?=
 =?utf-8?B?dUZEMjFGSjJCWTE4V0h1NUZxLzZmb2EvbU1UbVdwTllUblVvd3lRSGlPbXJ2?=
 =?utf-8?B?STJ3ZlVDSytPb2ZPTjhUcHExRGVaaHAyODlranZFc2pxT1JCMGU0cGVPV0hu?=
 =?utf-8?B?WnRSeGN4WFZneEpHZnBoOE1zN2VZb3d6ak03enMvTVdVNE00OHBUOGZPZ2R3?=
 =?utf-8?B?eTNYZSsrU3ppTmZHUFZxV0F2TXQ5dUk2czdDSFduVkh5U2pVczVjR003cFNi?=
 =?utf-8?B?MEgvaEdTeWE1UUVtWU5zc3k1ZVNYOUdnWkY0NUJLWSszNkNFSzk4WU43L3Mr?=
 =?utf-8?B?Yy8rTnI3d1JHQ3FFNnR1S1VsWG95RkN3aHJHOUxTcVh1ZStnU3U1VjhYK0M4?=
 =?utf-8?B?ZUNjVmRiemZweGJTejhMaFB4WXZZYUVhRWJPQlFGc1lpcm5sODFZWDdzSnY4?=
 =?utf-8?B?ZExQSlZuQkFUTFYrTEZzbWNzVENTMEM0RGZwd2JRR0FFeElRK3JSSlBtMGVJ?=
 =?utf-8?B?ekEvQWRMTS9uRXkxd1p6bUlYZC9EL1NXcnVYVHFiVERlSlluOHlDejJvdmZ1?=
 =?utf-8?B?c1ZGeDBnbzc4Z3lFcUVESjFLa1hJMjlWdHFLNndCSFJmay9PdzBmNzcrbTFu?=
 =?utf-8?B?NFJYWUxFZkF3bllIaU51bTRQam9aYnUybUtUN2hwbDF4OVB4aGtKRDFZbHV4?=
 =?utf-8?B?dHY4ekpoSCtUMnZhNWFRUGM3M0JCSlphU1R3RXhQVVZBM3Z5VkowNEJZVTJD?=
 =?utf-8?B?Qlpnb0FJS3kvbXhiODMyRHJ6eGUzU0lVdkJIUTB1WFZ2S0JHQnI3amdWSFpo?=
 =?utf-8?B?TVZ4T2NiOGxiRkx3MkZKYTdWZEVGanJEMGxiYkZEWUFmdXdXZTk0UmQyenFt?=
 =?utf-8?B?L1BMNGRPbU43SkVWSC8ycmpsVnc0M2FIU01MaStYRm1mWXlhaVhtek9VMXJq?=
 =?utf-8?B?QTJYL2doVFhaUDZWNWgvMGpkdWg0Z1plMkQ4V3VHWlJTRjQ5eUEwODR1cyt0?=
 =?utf-8?B?YW8wTHUweUVhZlRKeU14RWlmTUlxNmsrY3ZKTXJsa0prSWV5aFBVUzUraXc1?=
 =?utf-8?B?MkxIYzF3TGU0blhHQXhqOHNZYU55YVM1cC9xT2twdHZ2dE5BOVMzanlLQ1VQ?=
 =?utf-8?B?UVBpZzFYMHI2SFdqbzBFTkZDWTRoSHRXbCt2Wk5WNFk4UldBRXBMUDZZY0RN?=
 =?utf-8?B?T0M0MlNzbk9tSTZqZHNHUi9iby8vRDZlYnNZaDQ2STBCbW53cmt0QUFCSW8w?=
 =?utf-8?B?VHZHeGFGeWxKNlpzZjFKMDQrclkvZ3pCV2pkTVp2VjQzK3N4bVNrNlJUUFBT?=
 =?utf-8?B?d05seWMzZCtJODBxcHZBUWJmTFNremQyT1ZCdGh0Lzh0Wjg5VDRNc2E0Uysv?=
 =?utf-8?B?Lzl4LzNjb2Fuam5OekYrYTRmaTdjNHY3cVozbC8vcTdxREVDMU9oVmdGbGVs?=
 =?utf-8?B?MjlaNXdva2FXQXgyU3pnZmFKeU5XRGZCcTRINE4rb2VxY0liN0I4ZWlnNFE4?=
 =?utf-8?Q?P4SzfiH5t1CeWztRrfqfOA6fl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aiIlEw31ibjEn9sWE7siXB5VpuPfbW4N3EnZL3+rahORkYWKDlXbnwGN6iqOg49GrMH80bdkpUodA4TDddIYmew8MPqWD1jnjKVZdsCR5BgWZFu2Ki6iwpKNdNKQlApBWnpXwtKN3Y/xd2tnrDglFWPqLz/EWfH+4XthAIXXDfdDo4wrAKqT5Gy+iC7xjFJLXBAg4KIk8CKv9iYVJS4vF6ivnWAvtl17+xaNZRg2AfV0TcRvkMeFCWrC1o7tv8iS3OOZU448a33mZ734Rk1K3WASx+k9Xb+tfUqn0vMSDVwn+OcbGmB+p7nABXInjrrzlAGrTTFyyAIpavotEE9V+NWMHjqObqLoKDoc7EdMDKnrRTN4czVeb1hMyJq13kiCiQo1GssOYD954kj66wmee0vmoze7cELIFxmb1x8noKiWqqjuZB8mN9iSBwgp0CZx1bqdPAQFlmGexZFB1cb8QaAxO7wfVtA9QFDWhy7oKZ1AFv1ekf8UAXpzv0rCC7d3FFziNcvMQ4bf8J7hplVEbyiwrPnioDrsqrLOPeWJnXS63Y4517+QVEi1Tfw5i1/Rrua3jCuILuj+TnG2KtcP8rdMtyyH+650pwnLGEYwkss=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0cc759-f413-468a-ad4b-08dd18624aef
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:01:00.1030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DWtKe0hhFD/9+GqxV7APrBEIbaI474+Hm37EI5gfX6LiX6ygFbcRnj8LqqykvgyyLk17cDaZSNCmMdw4L9wuDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_11,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=935 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090117
X-Proofpoint-ORIG-GUID: QaIyrV7O7rGav9hmQNjzw5bPWbJnNgYx
X-Proofpoint-GUID: QaIyrV7O7rGav9hmQNjzw5bPWbJnNgYx

On 12/9/24 8:49 AM, Christoph Hellwig wrote:
>> +_supported_fs btrfs xfs
> 
> This is not how generic tests works.   They need a helper in common
> to check if a feature is present or not, which then probes for the
> feature.

Someone who has knowledge of the interfaces and facilities that
duperemove depends on will need to construct such a helper. I can
only guess.


> We should figure out what the issue is here first before
> doing hacks like that as well.

To be clear, there are two issues:

1. Dave's report of unreliability on filesystems where it still makes
sense to use duperemove, and

2. How to disable this test on filesystems (like NFS) where duperemove
is not supported or where the test is not meaningful. The current check
for the presence of the duperemove executable is IMO inadequate.

For now I've expunged these three tests from the NFSD CI workflow.


-- 
Chuck Lever

