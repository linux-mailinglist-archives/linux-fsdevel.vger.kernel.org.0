Return-Path: <linux-fsdevel+bounces-46698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3DA93E72
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 21:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1810D7B1EEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Apr 2025 19:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D63522D7A4;
	Fri, 18 Apr 2025 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QYKgI04v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y3coih3G"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146F021B9CA;
	Fri, 18 Apr 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745006191; cv=fail; b=TySsG+Sotq38r3c8FlbSjA0xoOwl99jMxTaYlb2bS9Ss7PtjAVbvwcBp/RlzEvIr9b2360eRLOKpoKHgn2Z7CKFOyYq1p6GedlWAGvMd42LH88AvHWqkf+dURg4knaxEJ4KiAEIzgzDRAaJRElX/l1JRErwicNAHTEnlIOPHzKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745006191; c=relaxed/simple;
	bh=QPLSEIyXPyQ6urxAdTzRBC3d1CChh2oE1nFPANjeoE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CXYJ4kWuvi7Y+qY6+gDaDGHVXLEah5/ucYnBRHUWZAqS6/SgBQtjTof6eFaQkPu943yaYqbHqQ3zs6dEqT/KBiGrsnzGpiTzjywJiajfpX44/+XpAtbS8RE0Wp0r8Gxp/ivzI2xuJrQHf+bHWwGcDQHpLyuoYvTee0+3qikHl/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QYKgI04v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y3coih3G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53IJfqMU006433;
	Fri, 18 Apr 2025 19:55:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=v0EJhlQUhe1pVDPjbAsrew11MmUpuPyXmYY8LxE9Ugs=; b=
	QYKgI04v9MF/s1AuQ7Z5ZD0+1Yq3r2RV5gyKUPxT3u+rSi/exN81eEhsRzXUUA3y
	RMLEU7ZmPpAOSKID1P9ZzK16wOnr6l4NnMNyV41/ZWkhKtrS2OoEgZm3vFfbxKo3
	Z756dX5D2Ek2Jo1aWD1LjtP6kLx+h2oaNn6AptRw4IZpljoVm+4cVNizEmTegu+1
	kiPz278Bu6nyeWxz2SRaV7Y2Rr9F7ZJMVow8lb+DoVRqXK9zrrtscoEEuTb0pUYo
	Wc8SaRarzXaOD+tBNtJrKVrHBGone8JQ1PJ1UbMNYHx8r/Y0rU+/Kyaooej3BJW2
	50UgOIPnPMXwa6lyP+P6Ww==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46187y0tmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 19:55:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53IJNRpO009207;
	Fri, 18 Apr 2025 19:55:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 460d3q051h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Apr 2025 19:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YjAFH236Q5WElCdM6XRsx+0Tt9r6xA9WY0bBCFxNEHwcUJBW3SZdfv/f+juGMULfy9bJdsVg9DAUzkwXYuuE6tGJ/JHvygFlDoK8CwHcSGLGTS9+inGgaOv2YoIq8yuOafLzFAuFZhtnstJX1oaE+aAjUZrS1iID3spm9zUWkQjIp4GUxfD6CetgU96hAiXpP0xOh9qYpfC+bwZxhRTySeZgoLWOCYWLZLO0cjec8y0VSa5Dw1yXzmgnqx8X/N+MMGr6vT70g4poGd9mBbWCBYiYxN382vAFYdWdSyoMfS827pYjylOKkUGmwwnh2rjLKHpc3zPFvuzzUYHNrVc4xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0EJhlQUhe1pVDPjbAsrew11MmUpuPyXmYY8LxE9Ugs=;
 b=Hj0oGOb4ORUpsCRupupEBx3DiPwcE5cDyAxLWNlaZDkuT4b7PQuVl/UVNoO/8XPkIT34W8MUmexkkgN6veJ3ZxwHKdlFjg65hTi1N5b50CWy+xiXvvMdKwmmUpTVimsLdAjk5yMf3FaFGvbzhvW7fqD0d4LBxrT/9hX243AL/k+wPzrBOS1UxG+MHcMvp33nkbMxrx7iBg2Z+Q2EEc3ODpZZQLrVC5ulHPgtIqSstI6CzxvXSl2scfBhcXgvKDgPYU0YyoHZqyg6eOCHXvkh5YsnO0auzuZEAnagXxR1ImKGmm88YZ/73oG3cwsbXhJ1Cx9NC9sxCsS6A1ZaDUtBvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0EJhlQUhe1pVDPjbAsrew11MmUpuPyXmYY8LxE9Ugs=;
 b=Y3coih3G8LFKqPbnQufWrLn7oliU89pi6UVIMfIiiJTswmo+ksioPV8ciCKXrlPHOwcqZkHa579Q1TtjWKDuIEJoLJ5A1XAyfYV5l2mACsgrHkw2FBL++wm9Bf4kUpXoHkMOaq+jzVRYBNVIixd7MimICIFm0nhVAMBdkCfI+1s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF4A29B3BB2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Fri, 18 Apr
 2025 19:55:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8655.029; Fri, 18 Apr 2025
 19:55:53 +0000
Date: Fri, 18 Apr 2025 20:55:50 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/8] selftests/proc: extend /proc/pid/maps tearing
 test to include vma remapping
Message-ID: <361e32be-7faa-41e5-a64f-fa95317abdb8@lucifer.local>
References: <20250418174959.1431962-1-surenb@google.com>
 <20250418174959.1431962-4-surenb@google.com>
 <5958fb2d-a2ac-4a24-8595-222d7e298951@lucifer.local>
 <CAJuCfpEwnbKA1y-iMs+ky465-Ok5j_f4ojaZV60yap2QGbfpmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpEwnbKA1y-iMs+ky465-Ok5j_f4ojaZV60yap2QGbfpmQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0493.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF4A29B3BB2:EE_
X-MS-Office365-Filtering-Correlation-Id: 84691df6-502f-4daf-0242-08dd7eb306ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZFpJejlSTWxENmZlS0x3RnVPd0FpZU5SOWZYYVVsQUpoQ2YrVGt4UW1VQzd6?=
 =?utf-8?B?VVdETWEwVFFTMHpPQzRrMEk5YmJVWkhnVFQxaWpuNUwrdjRwL2VKYW1hOTVr?=
 =?utf-8?B?VisyM3VZVHdEMGRicFlZdjU1YS9FRFd2TUE2eldnSFhrS04xK3dlMXB1ZGV6?=
 =?utf-8?B?K08zTDl1RDJtMWpaZXdmRm5ScTVDSGY5YkFqTVNxN3RscFhXdHM0RkhqN1FH?=
 =?utf-8?B?UVBUaXR5dCtTY1ZXRXVCdlhJakpwQVVvdVNiYUZ6ak9SMi9qa3lvQzZPWjYv?=
 =?utf-8?B?RVFKQXcyc1ZzZnQwcHNiZEluelROYTlPVS9Ud3craHNSRDRJVllva09TQWUy?=
 =?utf-8?B?VkI1SjBuWDM4SU14VHIwaUZUdkpobUdoMTF6YWJUYnRYSXh0aUhwaTRvMVJV?=
 =?utf-8?B?b2JIUUNIRHdaRExtNGVQcDBYdkU5T3hPWTRIK1gxVml1UHBacFJpNWtEU0tv?=
 =?utf-8?B?U2ZybHA2RTNXM09wZWMrR0VIdVlEWk9pb3hHMW5KSnc0Z21vNHk3UmpTS0FE?=
 =?utf-8?B?cStNT0xGN1ZUY0FjeEhwcWJtT05ZRFIyYXgyUmNQelBZb2hkK1Q3N0xHSlEx?=
 =?utf-8?B?SzE4VnlOSll3aTRNQmpHeVJoaVpnUjk0Znh4QS9jZmR6dVdrVFlLbURGWXlp?=
 =?utf-8?B?NzRGQkM3YzR1N2NjZ2VoYmxLUzRMTUVRZjRSeUVtU2hENVpjYlBPZ2h5UGF2?=
 =?utf-8?B?YVRXcitLNUxqbklJUlZxbytzcEJuTVdtZXVWaGVjK1RFZ0EyRXh0dXlSZUp3?=
 =?utf-8?B?TWxveUR6cEJqZEoxWkNsOTBMd3pqcG1HZGlFVzdxTWVSM0RpTDYyV21LWXVB?=
 =?utf-8?B?b1hKUnhrWkNEM2tSQUJ5TlArU1Ivd1lCaXR4RWZsUUk2eGpWOFh3MFp2M0ZT?=
 =?utf-8?B?V0o3b0pkTldyeXhnOTNmdG9LU2RQU1VmZEtETjBYcFRIR1kzK1EwQ0ZKcHMw?=
 =?utf-8?B?aXpnNGZSQWd5WnBEbDMwTXVpbkdmUzM4dkpyQnJwaUdzaE8rczhJN3FQQzBX?=
 =?utf-8?B?aTZvOFRYL0JzQjRzdFlVaTNoL2IvU3hmaFJrdlMvZGs1TkNScHE4eTVqRHp3?=
 =?utf-8?B?Slg3MXZORTFaeVFoZU1DNkNjL3RIRGZGQXZtS2lDR2Y5aGdlMnBFOG53aU9K?=
 =?utf-8?B?Y01kQzlIQml6eDl1bGJTVlg5UVNPTGxSQUNHOE4yTGNuWXQvdXhBWHpOa0ZE?=
 =?utf-8?B?VjVkU1V4T0NSL2lLRUpLNVZtbi9ISFRVZkZRSC95a0N4dHluOU1DTUJmendJ?=
 =?utf-8?B?Y1hDaVBNMFYzc0NrbmdXT0RYR3VhMjQ5VnlKNDczTWJnV3hZZkNrd2pXS0NY?=
 =?utf-8?B?b1V4bER1Y2JSdXpFUXoxVm84ZWtaWThxWCsxTXBHRk0zeS90K2xETzNhaGEr?=
 =?utf-8?B?N09URE4yT0RHQVBiMitIME82S0ZLL0ZHVUtDdHU2U2xmd3JQOWVFV0tvb0x4?=
 =?utf-8?B?YnkxQ00raHdRZDhBSmhjdTJ4UmdxQ05DbDdUVENxaVdnZ0lVdHlaWWprYjV5?=
 =?utf-8?B?c0QvVGNGVFNoNkhRd0dDcGR0TDVWdk5rRk54SXBlV0hNMlBjMGRPL2tnSVc5?=
 =?utf-8?B?UnRvOFpuUE5MUHRSZFFMOVVLOExxYTltTjRiODFpWHFaYmRJSEhYY0hDenN5?=
 =?utf-8?B?Y2w0cnR4RkFQYmM3UDloVm5aYWFvY2hWWjBIaWx5amhla3FxUlg1bHJyRDRP?=
 =?utf-8?B?OVJHUjVLQ1ZNZ05zU3pMZXFmUHJ1aXBmL1paYU9tKzJlMTErcUxiVzdVNis1?=
 =?utf-8?B?WkdUNVNzN0pFbFRHWVNKYlFMNFljNUxOOWd4bTFoMlJ5bVZiamE5UFRnM3Vm?=
 =?utf-8?B?UENSWG53c0RKVjJaYldZYXpnKytiTWpZWTdLV2ZnaUNUWG9hdGZ6ajVsOXBj?=
 =?utf-8?B?MElEU1QvdzBlRTdUM29QTERWR2l5Vjd1MFE0TkhvMGVmZnpYN0ZQQzFUNXlI?=
 =?utf-8?Q?0FnjIqUd2y8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RVdVMHB1cUJObG92NVBRbnJWNUpBbWlRTnNSZGJwVjFUK3gyTUNYc2VocmpV?=
 =?utf-8?B?QTE1Wm1neUovVTRSUEhVT2FSSVNjRzg1NTI5OGVtdlh1eDdVblJKYnJMc0VM?=
 =?utf-8?B?c05TcjU1VHRnSEc3cS9oOTJUS3dnOHBCU1laMWlycGRYbHp5NGdJYVlSUDlJ?=
 =?utf-8?B?Y1ZtYkJuZk9tK004NlZjM1JzSW1nSGRYUW0xanFpTElWM3gyV3FNWGdiR3Yr?=
 =?utf-8?B?YnYrMFVTckVLL251eElsaFpucTdpVjdzT0tQS2JINnNjSWZqd1pPVEx3WWU2?=
 =?utf-8?B?c2hYeVN2VzNTN0l4OFhGYzB5cUtHMDdLT25xWnRkalBNYjNDbW81QjVQR3Z3?=
 =?utf-8?B?bkxpaG9YNDBKZktZVmx6L25SRVNMaEk4a1FCcHZFekJVN0pkdVlWTjlma2R0?=
 =?utf-8?B?eXFxSVRkYTE2TFZIclRYajFrTXM3clZOZ21aNjY2ZFV3STduRDNRRlZpYzZp?=
 =?utf-8?B?enpSNk9wTzRITitxZHd2bWtxTExQS2VBS0cva1d6MjAzR1A3Z0xFYjJyNnp2?=
 =?utf-8?B?VnN1RU5zUHdYOUs4WUc4NXk0bXl4dHRRTFhaRytoa2t1WVlIN25VM3lJdFVu?=
 =?utf-8?B?aGRZNWQxSkRqc3Q2L05NMHliOEVKS3pJR1ZBa1ZJQVJaRnRLMy9UbTRMcHFr?=
 =?utf-8?B?Qk1vOUNaUmFLS0xIS1BqN0xwbGI4LytRZm40NTJMUmF6Mis4TVJGSHhBQWE2?=
 =?utf-8?B?RitZWUU0MUxpcTBvUGtaQmUwL0RFTlZ6UlluQ1Jud3FoR0ZIYm9NN0lxMUs5?=
 =?utf-8?B?SElSNmZ0bGZiWHk0UVZKSTVBMGJvdGo4Zkc5YVJHRE9mYk40NlpZckozckhu?=
 =?utf-8?B?bkkrT1psWG1FRHJLamdNVTdnalNaVjMrOUV1di9Cc2hNZnE3elZPcTlUZmp6?=
 =?utf-8?B?bjFJZjNXcmtzSmFUdFVocTZiTGs3M09VRDV3MkNIeU56dHVpcWVJQmIwRGNU?=
 =?utf-8?B?UWFtSXh4dTVJWTZuYXhmdEZmSGQxbGV6VEE4NytHYXJrdFh3c0VuajE1Sng4?=
 =?utf-8?B?WHZzbVl5VHdTKzRXeU1vV09XQlU0Rk1jTTdBNUNidUFQb0xMaDRORlQ2QWg5?=
 =?utf-8?B?RDhCdzRVTEhSc2lGeWZTTVVLNjEyRnBxYnV3c1pJeFdGK1lSN2R3SWdaRnBE?=
 =?utf-8?B?bVd5WTFvczVBdmtqeGZVNWxlUURJSXlDaThOeE13bnlvVEhzNjJMbnpDd1F1?=
 =?utf-8?B?WDhuODg4dzI5QjlWR1doYkpzL05Ua3hvYXo0S25KZGR5d21zM2lRcFlYTWMv?=
 =?utf-8?B?QXhjWEtPM0lLWlRhQlBERXQ4cW9pUE9RUFpOTkxraHppeUk2L1ZWS1c4SkI5?=
 =?utf-8?B?RVQzejZKUjVpSlR3bWp3MEtZRHlsQUVNRmwrVGpUVUFHS3lvUld1SThaVHdR?=
 =?utf-8?B?RTF2VE9xUEtUeDkyK05ZTythUC9keFZZRGhmZTdmQUpvMlluWEV2dUJyZkpB?=
 =?utf-8?B?QVlUTzY3Q2JKNWpwbnYvNTlmbFV2UEZsMlhlWVYwci9QeFlZaXZmSDdoNUIv?=
 =?utf-8?B?VVhONVo1ZGVDLzR3REFBcjBaRFFSY1QyU00zSjB5UFozdmFJdk9XQ01ta1k0?=
 =?utf-8?B?T3hUY0dkU1RpUzNTZ2dnTWhBQjhYKzU5WFJwU2k4cndzYzR3cmdpaXJGaVVo?=
 =?utf-8?B?dHVaWkhiemtRcndDbnpBZ1VzL1VSS1F4cnFVdVZ6TXFSSzV2MFI3STg5Wi9N?=
 =?utf-8?B?QW9oTDF1S0p4VlpuKy9qTnBmVVE4WWV4MFpKaW5pdEVUSkxPNFB6K25ObE13?=
 =?utf-8?B?a1hwMEd1MmRGWUdzSUVwOENMK2xQQ29jK1h5K0p3R1BkZVo0bEdKa2U4bnVl?=
 =?utf-8?B?aEUya01sWDhjbkxqRjRpbGxEVXovZE5tUXhNTlY0K0treUpHaDlTQklINmNy?=
 =?utf-8?B?Wnc0Y1NreDhXNk54WFIwZTVoRWRHcDBGVTJ4OW5zbmtqYWpkbFRzRkJTbVd4?=
 =?utf-8?B?OHpHV3ZsUDE1dlh0UkxSNXYwc3NxNVpWRkdpNzNmcDlOclEvTkg1M1FWNnB4?=
 =?utf-8?B?dVIwcDlxTk04Y01tazFWblVsRDN6Sml3RWJtclJtZzNHWVNON0tPczlzdzUw?=
 =?utf-8?B?Q3YvVDAvK1U4ZFZIZWF5NVYwWWdNenRaK1ZPNVJvRW4vKzA2Qk5qRUVPWnhz?=
 =?utf-8?B?c1RzdVBlYUlHd2h3dGh6elFiN3c5dkZnUHBOdUlOMzR3SW9zd0J0UDhwaDZF?=
 =?utf-8?B?UVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	C7qs6cSOeosFAzBs2anvjdmiDLgO9RWYVOfjQ9AtlZYJ4Fs+CFUzqk2Fje7OwfBqWfYhHhQMZJkqb4uIV8DvyVFt4SuzeBzDS/OYaSqMGytt3Y9+enOM5bJi6V4v70Tr84V6F41TrpJ0RJqC3j37g3pYPoQBET35z+WUcYgnz5niKHvfxPxHDUlAY9lmLtr4smTT4RePtUxa0njM0FBs1WInGYbjWyjk+vswKXEhIwv0f4Si8Im6jA9Wka34leJfswysBOnybWVUBIg963901kidZgAWJoCSHrJfq9zVybcFcBOnTSrK44pPb4o7jZQvCniSGsRd0a+46zcTBVnc3koaXKf4qtF+ZICc3pt+9M9J/LVz8VUFIh0ZOR1KXsmXr4R5CEfMZU+FW9fJ7/MQFQLfy36QnSKOL+YlX8lYHj+dRLfGbXsKlhop7MCOnQd7JsGovtQyPDLnMz9hESN5oB61eGyWiJ1B42C0CdjMjtNQxGlZy55tLJBQC96RexPo8OUFOLh++3vdSWSnoIePSiG+1F+7DCI6ujvHkC1iaeRjQR/XqdMYDVH/jL3wbcqZmfvptr6841zAxf0aziIzh72wQQQZ/Cu3w8+mhv2mG/w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84691df6-502f-4daf-0242-08dd7eb306ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 19:55:53.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TdT2vZNjJdfXkANOIAya1Ac9eSwOIWRjyqLJLDf2BWuOWtUdLnbiSE6gjEew8a7jyqNKoREFvt/PRQsrvW/ny4zS5RQ7KB6ona88BsUOppU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF4A29B3BB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-18_07,2025-04-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504180150
X-Proofpoint-GUID: IYCK1rEJFvLBMZ1cNz6PwF3isma23vXp
X-Proofpoint-ORIG-GUID: IYCK1rEJFvLBMZ1cNz6PwF3isma23vXp

On Fri, Apr 18, 2025 at 12:31:29PM -0700, Suren Baghdasaryan wrote:
> On Fri, Apr 18, 2025 at 11:30 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > On Fri, Apr 18, 2025 at 10:49:54AM -0700, Suren Baghdasaryan wrote:
> > > Test that /proc/pid/maps does not report unexpected holes in the address
> > > space when we concurrently remap a part of a vma into the middle of
> > > another vma. This remapping results in the destination vma being split
> > > into three parts and the part in the middle being patched back from,
> > > all done concurrently from under the reader. We should always see either
> > > original vma or the split one with no holes.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Umm, but we haven't fixed this in the mremap code right? :) So isn't this test
> > failing right now? :P
> >
> > My understanding from meeting was you'd drop this commit/mark it skipped
> > for now or something like this?
>
> After you pointed out the issue in mremap_to() I spent some time
> investigating that code. IIUC the fact that mremap_to() does
> do_munmap() and move_vma() as two separate operations should not
> affect lockless reading because both those operations are done under
> mmap_write_lock() without dropping it in between. Since my lockless
> mechanism uses mmap_lock_speculate_xxx API to detect address space
> modifications and retry if concurrent update happen, it should be able
> to handle this case. The vma it reports should be either the version
> before mmap_write_lock was taken (before the mremap()) or after it got
> dropped (after mremap() is complete). Did I miss something more
> subtle?

Speaking to Liam, seems perhaps the implementation has changed since we first
started looking at this?

I guess it's this speculation stuff that keeps you safe then, yeah we hold the
write lock over both.

So actually ideal if we can avoid having to fix up the mremap implementation!

If you're sure that the speculation combined with mmap write lock keeps us safe
then we should be ok I'd say.

>
> >
> > > ---
> > >  tools/testing/selftests/proc/proc-pid-vm.c | 92 ++++++++++++++++++++++
> > >  1 file changed, 92 insertions(+)
> > >
> > > diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> > > index 39842e4ec45f..1aef2db7e893 100644
> > > --- a/tools/testing/selftests/proc/proc-pid-vm.c
> > > +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> > > @@ -663,6 +663,95 @@ static void test_maps_tearing_from_resize(int maps_fd,
> > >       signal_state(mod_info, TEST_DONE);
> > >  }
> > >
> > > +static inline void remap_vma(const struct vma_modifier_info *mod_info)
> > > +{
> > > +     /*
> > > +      * Remap the last page of the next vma into the middle of the vma.
> > > +      * This splits the current vma and the first and middle parts (the
> > > +      * parts at lower addresses) become the last vma objserved in the
> > > +      * first page and the first vma observed in the last page.
> > > +      */
> > > +     assert(mremap(mod_info->next_addr + page_size * 2, page_size,
> > > +                   page_size, MREMAP_FIXED | MREMAP_MAYMOVE | MREMAP_DONTUNMAP,
> > > +                   mod_info->addr + page_size) != MAP_FAILED);
> > > +}
> > > +
> > > +static inline void patch_vma(const struct vma_modifier_info *mod_info)
> > > +{
> > > +     assert(!mprotect(mod_info->addr + page_size, page_size,
> > > +                      mod_info->prot));
> > > +}
> > > +
> > > +static inline void check_remap_result(struct line_content *mod_last_line,
> > > +                                   struct line_content *mod_first_line,
> > > +                                   struct line_content *restored_last_line,
> > > +                                   struct line_content *restored_first_line)
> > > +{
> > > +     /* Make sure vmas at the boundaries are changing */
> > > +     assert(strcmp(mod_last_line->text, restored_last_line->text) != 0);
> > > +     assert(strcmp(mod_first_line->text, restored_first_line->text) != 0);
> > > +}
> > > +
> > > +static void test_maps_tearing_from_remap(int maps_fd,
> > > +                             struct vma_modifier_info *mod_info,
> > > +                             struct page_content *page1,
> > > +                             struct page_content *page2,
> > > +                             struct line_content *last_line,
> > > +                             struct line_content *first_line)
> > > +{
> > > +     struct line_content remapped_last_line;
> > > +     struct line_content remapped_first_line;
> > > +     struct line_content restored_last_line;
> > > +     struct line_content restored_first_line;
> > > +
> > > +     wait_for_state(mod_info, SETUP_READY);
> > > +
> > > +     /* re-read the file to avoid using stale data from previous test */
> > > +     read_boundary_lines(maps_fd, page1, page2, last_line, first_line);
> > > +
> > > +     mod_info->vma_modify = remap_vma;
> > > +     mod_info->vma_restore = patch_vma;
> > > +     mod_info->vma_mod_check = check_remap_result;
> > > +
> > > +     capture_mod_pattern(maps_fd, mod_info, page1, page2, last_line, first_line,
> > > +                         &remapped_last_line, &remapped_first_line,
> > > +                         &restored_last_line, &restored_first_line);
> > > +
> > > +     /* Now start concurrent modifications for test_duration_sec */
> > > +     signal_state(mod_info, TEST_READY);
> > > +
> > > +     struct line_content new_last_line;
> > > +     struct line_content new_first_line;
> > > +     struct timespec start_ts, end_ts;
> > > +
> > > +     clock_gettime(CLOCK_MONOTONIC_COARSE, &start_ts);
> > > +     do {
> > > +             read_boundary_lines(maps_fd, page1, page2, &new_last_line, &new_first_line);
> > > +
> > > +             /* Check if we read vmas after remapping it */
> > > +             if (!strcmp(new_last_line.text, remapped_last_line.text)) {
> > > +                     /*
> > > +                      * The vmas should be consistent with remap results,
> > > +                      * however if the vma was concurrently restored, it
> > > +                      * can be reported twice (first as split one, then
> > > +                      * as restored one) because we found it as the next vma
> > > +                      * again. In that case new first line will be the same
> > > +                      * as the last restored line.
> > > +                      */
> > > +                     assert(!strcmp(new_first_line.text, remapped_first_line.text) ||
> > > +                            !strcmp(new_first_line.text, restored_last_line.text));
> > > +             } else {
> > > +                     /* The vmas should be consistent with the original/resored state */
> > > +                     assert(!strcmp(new_last_line.text, restored_last_line.text) &&
> > > +                            !strcmp(new_first_line.text, restored_first_line.text));
> > > +             }
> > > +             clock_gettime(CLOCK_MONOTONIC_COARSE, &end_ts);
> > > +     } while (end_ts.tv_sec - start_ts.tv_sec < test_duration_sec);
> > > +
> > > +     /* Signal the modifyer thread to stop and wait until it exits */
> > > +     signal_state(mod_info, TEST_DONE);
> > > +}
> > > +
> > >  static int test_maps_tearing(void)
> > >  {
> > >       struct vma_modifier_info *mod_info;
> > > @@ -757,6 +846,9 @@ static int test_maps_tearing(void)
> > >       test_maps_tearing_from_resize(maps_fd, mod_info, &page1, &page2,
> > >                                     &last_line, &first_line);
> > >
> > > +     test_maps_tearing_from_remap(maps_fd, mod_info, &page1, &page2,
> > > +                                  &last_line, &first_line);
> > > +
> > >       stop_vma_modifier(mod_info);
> > >
> > >       free(page2.data);
> > > --
> > > 2.49.0.805.g082f7c87e0-goog
> > >

