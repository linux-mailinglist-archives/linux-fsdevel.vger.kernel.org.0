Return-Path: <linux-fsdevel+bounces-66724-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A6FC2AA62
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 09:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED96C4EAE86
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B492E718F;
	Mon,  3 Nov 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cxeiPRdh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aU8tv+r0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4C42E5B2A;
	Mon,  3 Nov 2025 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762160065; cv=fail; b=svPpKKKJOyNH1kqM/kqPGd+QK8fw0Q1VXbNI5oCVqSifCu6iSWhJIxUudkg9yd2d4KbWuJpVrZRata9AE/nJ+upHNKfcOHHLetVkSmDf/nPnCu6pfGs+2OQJx9ZM2jyP46+y2fLozEfwNxcoa68Q9JYS2NoMkDZjXPgq83cxMCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762160065; c=relaxed/simple;
	bh=SALxTjWohZ/bpmZYBUphfvVy2hcwM6JaxCt0H/GtAz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=at5k5PYAQxWI5ESuNz3/PSzLSZCi7yLC617KQNT3tyYgf+7XG/uG5+50Y+5nL5icqxcu1C0gXhjq1UE+6UBiSU1HMRdw0PWGWEt+BbKFDmwjoFkB5/gljUW2cIhMYBvjhuMSQWjiQdin+mrw7nc60Z4cbWdn9ILmvm+KG9fAkN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cxeiPRdh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aU8tv+r0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A38pAEO003905;
	Mon, 3 Nov 2025 08:53:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3wWj+us6YpSCVhuquLrRHV2Qy4otFiOTJtlCUc0OaHk=; b=
	cxeiPRdheCVVBgvCUSHaypRe1T7f52d6magPTOpojNrrLoYSdUvlvrqLw0x0VU+h
	Q4tIQca9XoBoM4xo3NPBHeYJcn11oul0nwBg8bVfu27fuBGBp0Ko4OpfnmLaglZG
	dt5yeB7v0VCYRtRrAeb+cnn9Cd0Ae3Lu8Mj/xFONuvIHhjTncXi3C/EsafUkvh/c
	DX3S08EcJAZOUEY4gRJ24syR5Exa6DcGJgwVB8a0WwzpvigV94uZms1e2Xvh5FjF
	/331bqrB2Y5yCvRdG53L0/fyMtbE/gIHHvuRRF3bIdK8lbg6eAAw9CWRZ1lPZ/TO
	EGhh5tR/isRoSs5UYd/0DQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a6rut01wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 08:53:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A36vd8p010274;
	Mon, 3 Nov 2025 08:53:46 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013045.outbound.protection.outlook.com [40.93.201.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nbcdd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Nov 2025 08:53:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmX7xV7MIF8hzL3AANfAMhxS3RV0sC1hi09grPWt2xSUkKKgdbZw1YEq5d2i/NNfxX44Kcp2IgMOhYNOFuifV+TFUT17WXImJrYIm6K/UnnQWWbjBuWwggZXSTZrWWyxXm1N3aghFEhNWJCcAdCw+lW6YqmFqtMaFSeCnpecm74SJfeU2Okvm6Q7C9s5F+zSI2UKKH56yBh1xzPmP2pPuh3Z7GJZ6kB30CZpsG6+UnzlFhKuu+e7Zyw1iSD5J3uGbDREC0wr4GTnbXBVw3B8UjmjAPKZl1209apU0SPADwzUf9MF9crQF5A7pY+RYP4Rl46TBIb/95BYpXjRjzHUzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wWj+us6YpSCVhuquLrRHV2Qy4otFiOTJtlCUc0OaHk=;
 b=NT8b21lSpEdh0QF1yx1J3BmKq4JcqQyLHxHEghUOLbvOy/J5DSlAl4JTvbKF4AQaGFMmOH2sKb8Pvj1qArYtQVFC1XXOXQ9yjSORldYdQrmdkPACZeZS2Rs9lz5EO5XIk94lIb7pY0VsJExqY+vjRkFWjhsLyeux+VMMgB/Lm85EZ0l89NzdhzrOY+7PvCPg6P+Sqa1Shwk2l7tgIlTqYrynwdSdTE1AXBWnz1Y3pn8XM6JlXhDLE0u/W+kdpNAWkIkwM8qCKcVH1aFEGtAX+zQkdFBupsondShcqoJ4MNfN6ErIeNPkiVIK/Yikvd+A7st7YBhVdwFt8eW01L3ITw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wWj+us6YpSCVhuquLrRHV2Qy4otFiOTJtlCUc0OaHk=;
 b=aU8tv+r0W4FI71SoqK/Wbqrnw7udVBz3JZMkMeB04MBSRYuLwdq6cMGONrLXtj7bUVu3o88ctrPhidWIXgYnz5aOm/aDFR01Q5ZqXqfrh1T5y/io64mytJqj253moePmZsH1EFf1bifos0ijCXzKFQirG6H2M7bJwjR4FgltGdI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 08:53:43 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9275.015; Mon, 3 Nov 2025
 08:53:43 +0000
Date: Mon, 3 Nov 2025 17:53:31 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
        =?utf-8?Q?=E2=80=9CWilliam?= Roche <william.roche@oracle.com>,
        Ackerley Tng <ackerleytng@google.com>, jgg@nvidia.com,
        akpm@linux-foundation.org, ankita@nvidia.com,
        dave.hansen@linux.intel.com, david@redhat.com, duenwen@google.com,
        jane.chu@oracle.com, jthoughton@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, muchun.song@linux.dev, nao.horiguchi@gmail.com,
        osalvador@suse.de, peterx@redhat.com, rientjes@google.com,
        sidhartha.kumar@oracle.com, tony.luck@intel.com,
        wangkefeng.wang@huawei.com, willy@infradead.org, vbabka@suse.cz,
        surenb@google.com, mhocko@suse.com, jackmanb@google.com,
        hannes@cmpxchg.org, ziy@nvidia.com
Subject: Re: [RFC PATCH v1 0/3] Userspace MFR Policy via memfd
Message-ID: <aQhti7Dt_34Yx2jO@harry>
References: <20250118231549.1652825-1-jiaqiyan@google.com>
 <20250919155832.1084091-1-william.roche@oracle.com>
 <CACw3F521fi5HWhCKi_KrkNLXkw668HO4h8+DjkP2+vBuK-=org@mail.gmail.com>
 <aPjXdP63T1yYtvkq@hyeyoo>
 <CACw3F50As2jPzy1rRjzpm3uKOALjX_9WmKxMPGnQcok96OfQkA@mail.gmail.com>
 <aQBqGupCN_v8ysMX@hyeyoo>
 <d3d35586-c63f-c1be-c95e-fbd7aafd43f3@huawei.com>
 <CACw3F51qaug5aWFNcjB54dVEc8yH+_A7zrkGcQyKXKJs6uVvgA@mail.gmail.com>
 <aQhk4WtDSaQmFFFo@harry>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQhk4WtDSaQmFFFo@harry>
X-ClientProxiedBy: SE2P216CA0077.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c6::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB5598:EE_
X-MS-Office365-Filtering-Correlation-Id: 400a60b8-4266-4572-fc68-08de1ab67d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3ErUUFVUXh5VXN2V2wvRlNVVUZxRUVENGduQWRsaGpRai90citjQkNqUXpp?=
 =?utf-8?B?VFB3VlpBV3ZjbWlBSXRLZm1hajlPWjVVVVFkTzRvdnhtWnpyNlI3Q3ZnVURm?=
 =?utf-8?B?NXNKYnNpL0JHQkNmQk9nY0xES1MyZWF0OHJZN0xWdnF2L0g4eGRhMXNSN0FK?=
 =?utf-8?B?RVlwYzc3OHF2bDBZUkhtTG9nSjBvZnhmY09iT2d6eHlKYW81WUg3SHdFQzN2?=
 =?utf-8?B?dWJYRGJJS0VtZUhwMHdtMEtORm5kVldpbWJxTERwZkVYZnIzejJFb0FrUkk2?=
 =?utf-8?B?djV5R0IrLzBrQjdqVkYyczJNS091VlpRTk13Q3kxTS81amFBOWlUZFkxYWVF?=
 =?utf-8?B?RG5Md0IvVXNBc1NrSVVqYmljNnpaeFBFV0xYL3ZCZkRwbEx4M3FmMjRVeXpO?=
 =?utf-8?B?OU1Lb3llZEwzNm4rTkpPc0hYd0pvT3JQM3dVeU1QQWhIME9PYVZobHM4Z01J?=
 =?utf-8?B?MnVXU0NlbHpZdll2S3lJZVBSSlg4cFVsclcrZllsUDI4bGxGSldUQmlVcDNh?=
 =?utf-8?B?cFNIMVd5dHpuUWNPVERHbks1bENQTFB4Z1NvNnpJbjkza3IxQzNKYThNN0Uz?=
 =?utf-8?B?MVNOV3ZXVkthWXBxMUg1UEFua1V1elVCdU1yWmFmU2dOZHVXQUR5TFdVQTFk?=
 =?utf-8?B?bVN3bVVYbVhNdUlzNGU1YVlFcE8rUHpYWEI3eU5NckJsdWU5QVBZV0xJVFAx?=
 =?utf-8?B?aXk1V2dCUUMrREhxSG9RTFcrUWRhRGlkS0NhTFJXY1J0b0pJa0Y1MkVNdHVi?=
 =?utf-8?B?RVpOWkxFbWtkS2h0QTVNdFB5UUhObW1PU25tanErTlVmSGFSYXVnUjBraytW?=
 =?utf-8?B?d3E2eHlPdFZlVTd0anYzc1F0WDlWRnZ4S295M0hKVkx4VEJrekpZN1dmVXBw?=
 =?utf-8?B?eS83QmUzbVFLRm1NcGJodUNrMW9aTEJEQllROEQ5d2hVUFBsYmRoYnp4UUVw?=
 =?utf-8?B?YWxWcDFvUWNXbmtZNllqYW9ycU9Fb29TNWVmVSt5T3BKUTFoRUVlWlZRSjRo?=
 =?utf-8?B?M2x0V21PclQ4ME9ULzVsMUlKSHlBek8zRngwQ1ZpNW9YbzVHWEhvNFRLbC8z?=
 =?utf-8?B?TVY0N0F5ekxuUkFmOSs1eW9aV0Jzai9xOWg5NSs0SGo0ZU5KUkwyYnJnZ3p0?=
 =?utf-8?B?eDNnOTRwL24xWk81a3NVRStTVDVVVTdibG0vRk1uTjNIaVRLWG1NdXovR3FY?=
 =?utf-8?B?OGtlQ1IzOU8rSyt2OUQxMzdVYmVjSHNscjVSZVVXRHAxUkxmdWZXM0NhaTZn?=
 =?utf-8?B?elorb25LSHFqci92UStvdVlPakVINy9hWnpYekY5TVp1OHk2TXBsNThRMUU2?=
 =?utf-8?B?MHByMnhsVHhTWTdvdGtPOG5weUtPYXdFdDZ5TUtJSnZMeWNGa243RnA2NWlH?=
 =?utf-8?B?ZmdvUlU1SHdBYXl2YTREaEdlNitSbzI3SERCNEFOOUxBL0NHNHRYQnRuUjRR?=
 =?utf-8?B?S0hRZG1OOVJMUU5PZE53WWdiTm1neU1GQ04zR0RSSVJNa1lWdkozcU9DZEpL?=
 =?utf-8?B?alRTUFVzanhVK05FcnBHWFk2RVJSZy8vb0czMVBUUCtZUlNrSmhyYjJGNlV3?=
 =?utf-8?B?QTdmRUsvY3hzaWNhSzBvdkVKN3FxNVBQTStmU0hXL0drcWFOazdKY2pUK2RZ?=
 =?utf-8?B?UmRldFlnTEdDZVR6b0VhVHFZZzh4UDNNMFFKRjBuekxmbnN1QzdUUUFXaUJH?=
 =?utf-8?B?cWRqMWdPVU1PWEcySVVDc2RjNmg1K2lhUGdPbXR4VFVzOTRQbG1qODJPc3JV?=
 =?utf-8?B?Nk1pa1owN3I0d0JsYVFHWHRxWmdGa1Ixb01qNWdqcENScTRleGZ6R0VTYVBO?=
 =?utf-8?B?S2ZSbExYcXIraFY5NVo0N1djWDlwYUVPV0h2U1FibStISWhVUEtDbnhyM0VY?=
 =?utf-8?B?U0lxMThKaU93UEh6d0hVcXNiTmNuMTVMcWZyRXd6UWF6TU9TRWxsaTNKNWd1?=
 =?utf-8?B?VzBLWndxOHBmenBHbnMrTEt6V1VSd3llZEdDZnMzNkxmUVZWQ0lUQklZM3dJ?=
 =?utf-8?B?L0RYdUN2TkJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHhldWJhejM5VXhJREI1N1VnaFBaSmdyNHp6cnNZTHJzd25mK2g0UlgveUll?=
 =?utf-8?B?MTZPamRLZUtSd0JiNnlpSkZ3dXhnRmxldUVVcENXS0ZNSXRHQUZOOGVWV3My?=
 =?utf-8?B?MUpqYy8zNlRtb25LQ2s1Q2RoZ3JKanA1bS80T0lmMHJJcEZXQkhvdEFnWlhi?=
 =?utf-8?B?UFdvQ2Y2aFg2R2NzVmROZWFnNUsxY3J5cHpRdUVSV1dNTVFPMzcwRkNwTllx?=
 =?utf-8?B?aWpEdzJhNWliQWgwNkwvaEl1ZUczN0V6S3RUUDBKMURkeEpIWFJ4dVU0R3Jx?=
 =?utf-8?B?YnUrMTFrMFFSMVI1Q1duRU4rdGk2aE1UOEk3b0pnREZMOEo0UTVZOENlVTBa?=
 =?utf-8?B?VVhlcmpZMFZoRDlTOVR3SEFiN0w2NXBBU0F2aUZlbnd2cXZoR3dsYWI4Tkc1?=
 =?utf-8?B?UW4rN2o5Tlg0dkM1NTFKYzk2VlF1SkQ2b3c4QmZoZWQ2QmtoNDF2SE1CZnBu?=
 =?utf-8?B?cUdmeDd4TkowVEhtZTlHUmExWU9yYm0vL2lBNm15MGpQUDlSVmJMN2J2ZUdp?=
 =?utf-8?B?ajVQWGY3Mjg1L0YvQlpQZ01paHU4RSsrSmZVOXYxT2wwcGVEQXN0bTJBbytr?=
 =?utf-8?B?QlRLbmpLazBFMWRKTjV5V2Y5bkVKbjFRdmpld1J6UGladnV5R1hoSFRGdW9U?=
 =?utf-8?B?SmRYQ0FFdmdJenBQa2JhMWJhVXE5VFgwaXQ4RHdCL3liSXliLzdadzFDdEZY?=
 =?utf-8?B?T2NTNTMvdXI3cHBxMjNBZFpUWVhKOEZyKytHZVFicnRhREVVTDJML05scE04?=
 =?utf-8?B?WmNIVUFYY01sN0hhSTNoUFlBN1NoZjU1N1ozVXJyeEVJTjR4S0d2RVUxdzRs?=
 =?utf-8?B?RlFUYXdhWDh0Y1N5RnJOQnFNbUlUYktWQlFyell4MytSa2RhUE5VaFlERldN?=
 =?utf-8?B?aGtEZ1lKWkxNUHdRNEZGZ2dORTR5cnZxNE9GUXA3Wk5mWjUxb2E0ditGUW9l?=
 =?utf-8?B?WmROWlJvbGRMNTJVbHMrSkhMNjFrelhFM0ZrWlY4NXJpY0owaFNROVZub0U3?=
 =?utf-8?B?OHlpTWpiQklPM3I5NHFNaTQ1aEkxVGFjNjVEb1lGWCtmdTJkVUx0aXkrdUxM?=
 =?utf-8?B?d3hQdjNWcDgwVEc4L0Z6VlJyL2d3WDRTV3FTQzB6eGJqRVlMNzIxMGViWUpQ?=
 =?utf-8?B?aGNRVHNyWEFscTVialgxLzBaL0kvMy9aV09QVEZ5bVlWQ3hzK0dFVVRncE12?=
 =?utf-8?B?TFVMb1NIZVl2ODE2NkZqVGtmVnYyYW5aRnFONVgrWnd2WGdpbHRBTFVXU2tu?=
 =?utf-8?B?ajE0QXhyU1FkeTlUSC9ZVmFqdTk5WjdHY1J4TWFvWWpmRkQxU0FqQ3haV2ti?=
 =?utf-8?B?dy8zdlN6a3c4NXhGV0dnY2h5TThZOUlnT0NhRFY2dXpjK2dDd1BCSFhyb3VW?=
 =?utf-8?B?a2hFNVc4RVVud1ZnOEQwcHV6a0FjaCs0ME12MHQza1ExeEFwN2F5M2EvRnEz?=
 =?utf-8?B?U0VHVmYxeFFlTElna3lHMlhqMFNXaHJoUUVHTkMwNXcwSVBZMGIyYkdQaFIz?=
 =?utf-8?B?dVhlS1ZUZXIwM2o0RUJIaGlVM2UrY0lNQjJ2bkdYMFdkSEIwRWExNkVuWWZH?=
 =?utf-8?B?Q0IwamoyQ01oVjl2SmFtVU1TZFVoOThWcUREM0E5M045VGx2cnkzWU5yVHZP?=
 =?utf-8?B?aW5jdWxmUE1mcS9hQnF0UDM4enZrYnNpMnNKVlhHWEs4QlZoZzliMDNtYnNv?=
 =?utf-8?B?UU1Wd1VnMUpMdTZ4VXJMZ1pUdFBrL01adzROSklZMHNQV3o3V1ZNbzNyM3Y1?=
 =?utf-8?B?bUN1MjJ4Z0tUanpzZ29iVGtzcWd5Q1FySnlMKzRiRHI1eGxQaks1L1lsZE52?=
 =?utf-8?B?TkpyNmxyWFRodGJwd0x4YkdDcFVZMWlVRGxxVUtKWTNLSFlqK1RTRUlwL2tZ?=
 =?utf-8?B?Q3FoZmFzbmtLRTlzTCtLN1NYa2hoYXN3K3J2QktCRG50eENQK29xam42TnRx?=
 =?utf-8?B?OEpneFpTOEVDMDZYVlhkU0wra0FXNHJ3WnpveGZOdEIrYm1NVGpRVDZhZDN2?=
 =?utf-8?B?c2xSSVZSQ2xqY3hmMWRlcGdSb3FQUGpRN2pVVm92S0c1UkxtNGMvUFBFR29S?=
 =?utf-8?B?dDVzZGc3dDVhNDlEcHl5ejVpcm5QL1ZvMExLSEpXY25mOGhtSGhaSFVLUmNw?=
 =?utf-8?Q?k6gWp//7rmfNF+kZ8wpA7/iHJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SPCfNnHlHd/B3PjhXGywJ1KyrXbB8IpYR+QktpaScyEJ3fYkJPYDuhHloVfs7WYZfxzvjGP3HESNFICqHI7FhwYtSKIWwj3Lug3G7eOHtIBIC8VWKHjNkJrreaAJea+poDfLv9QEkmUXZlAnHUx8sIlScHisoZG7kRwDuYqZslJLFGxCmefiQQQ4E26XcPmsbRGcFnDyMd1P7+q6IaEqC0JkurSOcWcRInxEYrSc/KbMnXvVLaxPMsJcGM2fS6MWQhRFTN0jcaP7WmUTsDKoRs2wcGnI91OyaRzFILj5PSCepaF17vD2C3MXWRO1NCzceC+ObzyLvUsUJ5vRKVLVhEDkUwNLS1HA1iEcHk9shxeurtcb3EVDSeXvsN7SyJ5YCkVR6IxfYfmirykFDqF0B73SEb6K3KoNdKRIclZfPVXtXPGImh+bhk57xadtBK+txSQckbW0fpG1/o5cv29eQkwMyAoXaX6nYUS5cZ7O1imCMe/Rnz4RXxAs6COtERnJaeEjZjXCa6Xk5kYyUdYYC55Q2EuMf+C5sxBzQyBe2crGCowX070VLJ3gEd+2OBrsdFeMtZI9UVVoJE3yvU12fo3fEufbaO7GHI2YyRmeX2M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400a60b8-4266-4572-fc68-08de1ab67d9e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 08:53:43.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iw20VZMXTuUxHQtEHYVNcQ12FHT8UEo7PhTszId+K4vXw3f+IpMXRcRG5Z3oaSPsp1lfnpVkbKkVhfyzgmfNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511030081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDA3NyBTYWx0ZWRfXzf+FPCCle1K0
 S7RcWYN81rjMFdwB94K65+KcjF6dTepay20fD9o9LT4hmcwh9cT0dewPpbgA2BAOyjKN6OszvuD
 dI0XPlqDAmPTN4CmHeHCVAYBk5LQ/2vhG8HP0QCTqAFlL6p5GOt44URRXYwAnr9LFkx1L0wqf+K
 nGGjos3hB/55QyegaQZwqXWZ2ui02HyA/teO2BCyToH/DSjz4dp/78pOfs4rEetw5yk0LbmrJ6+
 FYTjGXdEFXJnoC5dyoQwnrD1z94VPDrWZCTvCs/0fogMY24oyUV7xM8YU2uK0UICFaJN/NgBp1d
 4mt94V/ClQcxgbdVKjMsakh/DQLRVK/a5xj8zot8LcVBFwTk6SzYnLB+sc5/xrRmkkkv0C+P3zS
 OiFgbGsWFJiJHmgDysC/Zt40cfyqrZuAEsC4XsGqA/I80NAVd0k=
X-Proofpoint-ORIG-GUID: ulWbCrHK6t9k7LfFot7w_4Mh6LQYq-ek
X-Proofpoint-GUID: ulWbCrHK6t9k7LfFot7w_4Mh6LQYq-ek
X-Authority-Analysis: v=2.4 cv=ILoPywvG c=1 sm=1 tr=0 ts=69086d9b b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=R_Myd5XaAAAA:8 a=i0EeH86SAAAA:8 a=yPCof4ZbAAAA:8
 a=4HG66o4IoF7Gk3z3rhwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=L2g4Dz8VuBQ37YGmWQah:22 cc=ntf awl=host:13657

On Mon, Nov 03, 2025 at 05:16:33PM +0900, Harry Yoo wrote:
> On Thu, Oct 30, 2025 at 10:28:48AM -0700, Jiaqi Yan wrote:
> > On Thu, Oct 30, 2025 at 4:51 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> > > On 2025/10/28 15:00, Harry Yoo wrote:
> > > > On Mon, Oct 27, 2025 at 09:17:31PM -0700, Jiaqi Yan wrote:
> > > >> On Wed, Oct 22, 2025 at 6:09 AM Harry Yoo <harry.yoo@oracle.com> wrote:
> > > >>> On Mon, Oct 13, 2025 at 03:14:32PM -0700, Jiaqi Yan wrote:
> > > >>>> On Fri, Sep 19, 2025 at 8:58 AM “William Roche <william.roche@oracle.com> wrote:
> > > >>> But even after fixing that we need to fix the race condition.
> > > >>
> > > >> What exactly is the race condition you are referring to?
> > > >
> > > > When you free a high-order page, the buddy allocator doesn't not check
> > > > PageHWPoison() on the page and its subpages. It checks PageHWPoison()
> > > > only when you free a base (order-0) page, see free_pages_prepare().
> > >
> > > I think we might could check PageHWPoison() for subpages as what free_page_is_bad()
> > > does. If any subpage has HWPoisoned flag set, simply drop the folio. Even we could
> >
> > Agree, I think as a starter I could try to, for example, let
> > free_pages_prepare scan HWPoison-ed subpages if the base page is high
> > order. In the optimal case, HugeTLB does move PageHWPoison flag from
> > head page to the raw error pages.
> 
> [+Cc page allocator folks]
>
> AFAICT enabling page sanity check in page alloc/free path would be against
> past efforts to reduce sanity check overhead.
> 
> [1] https://lore.kernel.org/linux-mm/1460711275-1130-15-git-send-email-mgorman@techsingularity.net/
> [2] https://lore.kernel.org/linux-mm/1460711275-1130-16-git-send-email-mgorman@techsingularity.net/
> [3] https://lore.kernel.org/all/20230216095131.17336-1-vbabka@suse.cz
> 
> I'd recommend to check hwpoison flag before freeing it to the buddy
> when we know a memory error has occurred (I guess that's also what Miaohe
> suggested).
> 
> > > do it better -- Split the folio and let healthy subpages join the buddy while reject
> > > the hwpoisoned one.
> > >
> > > >
> > > > AFAICT there is nothing that prevents the poisoned page to be
> > > > allocated back to users because the buddy doesn't check PageHWPoison()
> > > > on allocation as well (by default).
> > > >
> > > > So rather than freeing the high-order page as-is in
> > > > dissolve_free_hugetlb_folio(), I think we have to split it to base pages
> > > > and then free them one by one.
> > >
> > > It might not be worth to do that as this would significantly increase the overhead
> > > of the function while memory failure event is really rare.
> > 
> > IIUC, Harry's idea is to do the split in dissolve_free_hugetlb_folio
> > only if folio is HWPoison-ed, similar to what Miaohe suggested
> > earlier.
> 
> Yes, and if we do the check before moving HWPoison flag to raw pages,
> it'll be just a single folio_test_hwpoison() call.
> 
> > BTW, I believe this race condition already exists today when
> > memory_failure handles HWPoison-ed free hugetlb page; it is not
> > something introduced via this patchset. I will fix or improve this in
> > a separate patchset.
> 
> That makes sense.

Wait, without this patchset, do we even free the hugetlb folio when
its subpage is hwpoisoned? I don't think we do, but I'm not expert at MFR...

If we don't, the mainline kernel should not be affected by this yet?

> Thanks for working on this!
> 
> > > > That way, free_pages_prepare() will catch that it's poisoned and won't
> > > > add it back to the freelist. Otherwise there will always be a window
> > > > where the poisoned page can be allocated to users - before it's taken
> > > > off from the buddy.

-- 
Cheers,
Harry / Hyeonggon

