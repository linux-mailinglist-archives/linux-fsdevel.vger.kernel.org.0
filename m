Return-Path: <linux-fsdevel+bounces-23472-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC2B92CEE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 12:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF991F25299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 10:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC5F18FC74;
	Wed, 10 Jul 2024 10:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FVOeFZOW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oxrfz658"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B18FA12;
	Wed, 10 Jul 2024 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720606316; cv=fail; b=cDh+rv2mAAY7hIa7AKCG3yif+gJ/7EExktBAWbfNvqHkgy8s5U7q45ThJncIvzYX7SXprJsGjZlK+cIO3nLFLASnQ0QLUNaTTC2XemWF2VetPymi3/8HTUc38UQHQgDmNJVQJiU07ny6plWKwTHDshMFLMfNTxg3sPpOlThoqRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720606316; c=relaxed/simple;
	bh=2jPuNr/m4XN4p+v/Z42/JW4mKYkhOw/JQjOaUVAsyLY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t0ZfboXAOthQkFsQrumN+XiG+xI1H8N3pIw8GZoEDC6QW0va8otStpQ2dv4C0KmYYQMzBPJbk4+oraT8Vby4+xtYA9RfI6/D876ODxnvb1kMsEtR6oU1jDhumz7GFqbs/IZnF72vKJ4sdtMMaMvPDyu0B1q4DRxwa4ERZx0sbm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FVOeFZOW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oxrfz658; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fTNV012014;
	Wed, 10 Jul 2024 10:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=B3y6/vwaAk6atUNqgDpifHGypqtsDNTQchSs+QJ5yK8=; b=
	FVOeFZOWKdNjrpuFtPV+NrCqFCfFvHMxqyZ5XEPSxaB3OvTRC4D5xH3GciAq/a7X
	Mv25Kn228qDPQ7ULeUutMxPbEeg4p4BpB7ZO+BoNhwHLBOMZhwSb0hlfmEMp6vql
	28m6WcPwT278FYP5+QtGsOvX0YmCuWZpIJO155MTSV8ivd/k0WIF6bVjKCVKRJju
	EKKxH923SlLsuui7elS0O0Zxl4rMUgILXnh0dkFTK+T+4O+OfqGn6cHJ2moj2yYM
	NY35zosPvTCB8gddsZgrnWiqSExns81zHvmHDYyCf4l1cDYa/xZ/xlJlrQoa8K2R
	oWeBkuVj+v08XS8W0Bi39w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcewmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 10:11:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46A8l8Jt004476;
	Wed, 10 Jul 2024 10:11:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvf0313-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jul 2024 10:11:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdViXKEZYg+rR9Cvw5gLpv72P08jzfacgK7ji+XYmj0omP50uHuvjdi20XPMygBwgzObPZyww/IFq00eIrW+UzMkmiMmyAzbrOl4ovga5eTy6Q5BKUuZ5lUv7R19OYAkq06whyudjwrF5ks8APwK7honDLizA9n06fE+2+cLopmmfRDTr1tFTZkOsCqhm7Np2SmtoAmGuRkHxC9ZaLZB6H81tUBqYy/+6tfD4Ze5jqFSZkAR3+3M640q7Hf1nLikQ73Yd7VoN/H6suyQZQPLf4oelyAZhKmLBOr1XCg4c2LTGs5OQ80UONoqSSVDcPZJNt+uCkX3HZTfpW8mSZGD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B3y6/vwaAk6atUNqgDpifHGypqtsDNTQchSs+QJ5yK8=;
 b=WuFZG5MMewReqKk9GOt4QmLSUVxU2+zOe5OSptzUHzkOVim5WcGV9qmlKdz43p3F5frXYwlffHIKPh8hYgVsrb3ETrZCXPhPF4FmstnkUA1XMbOGazFPp4ygcAIQOZeS5OdrERKBj0c0/iFtC4z3xk+WN7ktQ1VRot2aYmJf3+ZsYw8BX7nNiiWEor6xvwpONdM9sCQBQSwpqMUgUWG4lTpj7C+gl9ltOHflsvJURefzCqvYQRsan0IWFJUvNf6DBxmQClkt8SBE99B5uHVZClvS22nxuhinDK++WYxy4DJodTi5EDXxb5wlsneI4o9jTY/zJAErNS1b1ptzTCRDlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B3y6/vwaAk6atUNqgDpifHGypqtsDNTQchSs+QJ5yK8=;
 b=Oxrfz658TJeXtg3H7saeHwmcKlKKxP/dsldDCAAhlJHZFDtxX2rg3AyOp0rlHlvTD3t9F5OVJn4EeFmqGC36oY+7bbSNQJzxK6a8OrGVRomu2exANJb86ycSLFSJI38EU3OAXHEBt9n3ppwB8elVa5qyCnF56QS2d/+18kW/eHc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4567.namprd10.prod.outlook.com (2603:10b6:510:33::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 10:11:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 10:11:37 +0000
Message-ID: <8b3ce0be-779a-4649-ba6b-d78dabb7cbfc@oracle.com>
Date: Wed, 10 Jul 2024 11:11:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] statx.2: Document STATX_WRITE_ATOMIC
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com,
        Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
 <20240708114227.211195-2-john.g.garry@oracle.com>
 <udwezmj36we4bkvlnbxpuvrrikh5yejaf6yetxd2ig3ssgksrw@fi5hsutb7mmu>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <udwezmj36we4bkvlnbxpuvrrikh5yejaf6yetxd2ig3ssgksrw@fi5hsutb7mmu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0027.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bfe144-922e-46a6-4aab-08dca0c8af52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ckxlTjUrL0lLbGxRSWZ3cUU3NDRHVk1BZnZyWnM4aktDMDlEdUE4Z0lUcEs3?=
 =?utf-8?B?allRK3d6TjYwSnNhSzdjVnY5YUhSNWdyMThMbWd3TmQxMTJmZVJidU9iZVIr?=
 =?utf-8?B?dlVHNlNtaHY3eG55ZmFoUHhZYTNYWnpPSjJXV3k3eVNVNldoL04vd2pnaUs4?=
 =?utf-8?B?Nkx5R3RvOFhTcHF0SXlFZmYzT1dBU1gxQnU2aDhpV3NDN1VNZzlaVnhoYWJz?=
 =?utf-8?B?VU9lamlNQmJKeGozTFp3aFhXUlljd0hVd1hyNkhleVFTeXB6eUd5RkJlcjlz?=
 =?utf-8?B?a1IyalFxVHRyT1RHelduMnc2YnRQRVVQSmtUQkFqSlZJNUFDV2U3YUdGRUhi?=
 =?utf-8?B?TWFFSUs4UEVJUnJyMFQ0ZVJXNnV3QmFwTTc2UXhsdFBiWit4QXJxVzVGU2V3?=
 =?utf-8?B?WXRqa3FDUkk3NzhJRTdEZ3dKZmdlNlFGOTRlK213aEFzR1hJRkt6SjNRdHdJ?=
 =?utf-8?B?cjI2L3FGZVZJQ2lkWkpmS2Z2WHdjYzBXTUFoSUdKTk50QlBCNTI1OWY2STln?=
 =?utf-8?B?anBMYm5WK0VUdmxSQnFuUnNIRHdOeGtTbC9UUkc1eExFV1pLRHhKS1pMZE56?=
 =?utf-8?B?SEFFMndEY2lIY0tocG10cVRnYXZmMGZzbVkvOXRFbDJpaW51ejRZVXV5ODJH?=
 =?utf-8?B?NkZQcHJUNDR3SmMxcDlEUGZ1MGU4R1UyMXNSaC9helBsVldCeldtVFRmbXgx?=
 =?utf-8?B?aFRzWGRhcWpXQjdXSGl1OUZ3SW1kNG1PWXJ0cXdCTGdQb09rZUxWQlNveENB?=
 =?utf-8?B?MzhybExBN2tTeS9ienRmR3BObG5Ecm1YeitIT1RDMDE1dUhxdEJ6dXhDSzdx?=
 =?utf-8?B?ZVdEc0lrOTVuNmY5UEgreWNQOStjeWhSejlTdENMdEl4dFVNSEt2UDVXd1U0?=
 =?utf-8?B?ekdOUytwa1RkV3JyZlR4bUdMTkgvQzRXOTBXeUxwdVhtTGY2dG0yUVlqai9M?=
 =?utf-8?B?VDVBM1RZSlN1czN2N1RMcGtnT1d5L21xc2pJNTY1QVRQbjRZSE5rV1JxUmdv?=
 =?utf-8?B?eEJlem5IM2FyWHlBZk5LZWRnOHQrVE84T2dBUENHQzJEYklEWHFLWklhUy9u?=
 =?utf-8?B?OFU2Q0hCQ1d2K211Z2dsRFJ3UEZ6M3ZiZ0dta0Qrc2JQUHp1Q1VtMU9qWmZF?=
 =?utf-8?B?SzBVVzNMbDI2MFJFcFYrR1BWTjRucVQxRURGN1NaQ2dqNXdwMUwyeUM4Zk1h?=
 =?utf-8?B?Vkh0aTRWN0JubWlnTFBvU2Q5dHhOc3NqdW9UM2lXbExPaUNhWjd5TmM2N1gr?=
 =?utf-8?B?bVRubFhtVDZseEc5Y0NGUHh5c1ZoNW8xMFpscHBScFZGYjliYlRyQlNJNDZE?=
 =?utf-8?B?ZEx0bzZ4eEVIclZBZDBieU81akE5RkRrUlNQeXdURGgyMDI3clg0SlhPczZB?=
 =?utf-8?B?N3Npb0lsWkdiam9KT2tpUXNpUEpxY21ZNFAzRGVoSXJaczY0UENycXlubFpH?=
 =?utf-8?B?czZ0QjBMUm56ajZkU056TUxtNGxZWDRndlRvci8wNTJFNk1qcUIzOHNQVExr?=
 =?utf-8?B?bklOZFl1N3c0M3R0eXlXdkxFSDJSbHNVVnEvK0dweFA2Ym9icjQwSnVVZVFa?=
 =?utf-8?B?Vzdzc3A5VTZPTm1CR3V3Q09VOGtNaTRWajBkajM0d2tDZ05EY0JNSWM4bXVC?=
 =?utf-8?B?RWVzd1hFWEpMR1FIaXRFYUd2YlJLeG9sNElONHRYcFQ2Z3BwL0Q2ZTg5VVNL?=
 =?utf-8?B?eGg4ZmRUMGJ3MFNBZlViVW1jSlQ5dzhvWmpQSStkMEc5dDNqRTNrMFNUYW51?=
 =?utf-8?B?MGtyZ0dyRUU4eXI2T2IwVmxaOU5oQmJnZGdsd25INE93QWswdXI4UXNZSkpU?=
 =?utf-8?B?b1dFMFpVZEJzVWRkT0lGQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmltWHZiR1YvZ3RiY25jUGtySWlXalRjYjRiY0d2dlQ3WXk2cWhUUnhtNW9L?=
 =?utf-8?B?VlIwbWVxS0FjNzZXMFZONGcrWTBzMytGQ202ZzQzaWZVQ0tXTFRCc0x6OHd0?=
 =?utf-8?B?YXQ5UkxxY0JVbDZMK29zRWk1ZlgvZmQ0azZKVkpNS01LYzNiUXp5YkpEOUls?=
 =?utf-8?B?dUtFN2ZqRXY4OTNHYWtFaWNUZEtLMlBBSXV4MkQ2YzM4RXpUa3MybEZuT1k2?=
 =?utf-8?B?SG1JZGVwc2ZBU1lLSDk5WThPcmVMdUdjS0FEdlFyZHFnSmU5Q3ZLZmxNbUpT?=
 =?utf-8?B?dFo4aGZQRFp3U1VzdElDbmRkTUNKTnNwaDhOZ3Z4a1RxZ044TkcwTTZqajRw?=
 =?utf-8?B?VUZlSUNrY2xJYmR5dWltTGYzbHpvSjcxcURacnRtMGV3TzNoUXJtTHQ4WUZB?=
 =?utf-8?B?QWlyWk9PWkY4MURNa2MrSlZXOWFSMzBjM0lyYkxoQWVNS1V6dUk3UXRMdkkv?=
 =?utf-8?B?cmpYZG9YMW16UjRKMlg5N2dNR3hscXlnMUd4RERGNzROcGhsRStadVpJVWNX?=
 =?utf-8?B?Qnp3TUcvd0ZnSEZ2bVpnYmRlWFFDcDEvbVRuQXVadTkxK2pweWZRWk9EVlhS?=
 =?utf-8?B?ZjdVUWxDSTFpdmsrTjJvOHNMYUR1Y2U0ZnZHa25wbGJjUmwrb21rSk9TaGds?=
 =?utf-8?B?TExIRzhGaUVJVHF3S2RwQVRGREJ2cENORzZ4M3ZrKzRNNm9VWmxhdzh0Tzdk?=
 =?utf-8?B?eGlkMmhvQ3R3QUQrWUpVTXJ1dkNpcFpDdGF6M1lLS2xMK0loZXhDM1pnSzVk?=
 =?utf-8?B?R3d4QjdhL0FWZ1h6WFdCR3JqeDc0RTdOVkY1dEIwOWJialUwY2JqYmJVekR4?=
 =?utf-8?B?cWM0aEhMdEtqaVdRVHJNeVF3Z3BUNW4vYXFGTzVxOUxhL1h5eVVaakZHUEw5?=
 =?utf-8?B?NmZ3a2prVDdkV1BRMUYwcUE5QXZmUDNrRUIrb3JXZXFsaTFsSkNDRWtEaUNo?=
 =?utf-8?B?R3Q3TFZJcG9zUDdjTzJCK2habVZBOWxGTVBuSDcrcUZwVXhRRytJbG1xRWdW?=
 =?utf-8?B?L1N2NlYxQkVpL2Zzd0VocU5wK2MvQzZiSjlkdmVmc2VuWk0vbk9raFArUkFS?=
 =?utf-8?B?eDZiVXpqZDR3c2hTejE0MWZHUmcwazh0L2NVMzJPYVdFY1RsZ0dLUHNRVVla?=
 =?utf-8?B?elYrRHl2M2tJajd3djRic0dNV1JJOGpVdXExR0ZTV1NrdFkrUWJBSEUzSjE1?=
 =?utf-8?B?UW5CNGJpb0hicFFvOGlZQmh3WVVvNCs0K3pldVc3ZU5sdmFueUlMTEp4OFEv?=
 =?utf-8?B?Rnh3d1VTU0hXd1pNMk1mbTVYdFd2cVFxYUxhcS8yVjlpVDgycmxzcVV5YWZ2?=
 =?utf-8?B?cm9VV2xMeVUrcTlHaFhZUVo4Q2lXSHlhVzhvZHVpRzhEOWQyQUo5azM0RjdN?=
 =?utf-8?B?Q2JQT25uZUNDUnFhS0xXZklnTmU5YjQvaWFlOEw4R2cwVGhNRVRDZjRRWHl6?=
 =?utf-8?B?OElYaUpPek16WHlHMXFGSjAvZ1BPd0x4ekFjOFhXMS9BWVZpUEprU3NCck40?=
 =?utf-8?B?VTlzelhDb3QrYU00dFRtSkFZNW5aeTJTc3V4NnQxUTc2ZFA5cjBVWHdqbzUw?=
 =?utf-8?B?ZnhVYW0zQ05ZWm45S2YydVJqcjFHTTJTdXBkWk5PN1J6d1ZlN2U4V3FaRW1a?=
 =?utf-8?B?Wk80WWdZbUJhM0RhN0ZnbjZRYWtFaWJiZ09KbWNreUVncER3ZFIxTW0xMzhu?=
 =?utf-8?B?Ym9vWjFYQnlZVVNSSmJmYlJQZFlEejlsV2UxYVdJT1k0K3dTRGQvSTZxdFJu?=
 =?utf-8?B?Wm1RZUgyZWo2RXdGZzBuNUVzT1N5N2tndktWb2JWcm1DZnF3aEsxR0ZBZ2JE?=
 =?utf-8?B?bEUwYXpLU1B5aE1jQms3MnBCK1d6QnBzWHk1dmFmOTFNRWhmbEdIZmw5am9u?=
 =?utf-8?B?Z2p5VmE4dFRTQm1QVTFIOVVqUmtaOEFPSW8zWkNHbE5DVW1HUE9SWE1yY3FW?=
 =?utf-8?B?bGRLMnFRRlB6R2xXMnFrK3BuNHRtd1pWUCtURGY0RmQ0WXc0YnJyaE1KSTR4?=
 =?utf-8?B?YXcybHdiMTZyeStpMU9NUmF1eFdORk1qNkJKSEFBVnFFTmZrYzFCdHQ2MUEv?=
 =?utf-8?B?NWEwSDJ0TUsyL1lYK0RWT0hOQmoxR2tyUlFIUkpaRkx4UjVJam0vU0pIbWVY?=
 =?utf-8?B?Z1phR2F6TVlFdk50dE8vWE9hM1VYc0djKytwSkJPSXNTMkRUdERKMjcxYWFz?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	JBjQDGw0ELnBE7vykvwY4+Ke8llYxhGR+BwG7T6vXe2pCW4q8ixJeAL+V7kXojXbqC8nGmpATzRfKFmQEvA0jv/VnpRImg9PtUaPRrz2GDKCcJpn9K2NXQFxq8cDmY3Hh6jybU2YvtPgOdz4C0VVj6HWv2E5qJCPiXfNv1tjkSg+E28S5s72zezEGxHGrKZudVv2JtwcgJm60CQBpt+NwA6G+2T3xksjPjSW3KJvLkp61h7c8HlRMMLdnjmNrImalapOEz8nE8h4UsC6k8yDFJToeQkAbaF2JGRTCn/s8V0/bCpPACOJP6mM36CDcfsu1Gaj5a0kYRa4ZWptvHUmXJeYLikKL4GUocRrOdPFnkXdcKW1tojGpVap+qUTeWxYCyDrQW4uf1/TMUaevJisHq7i/DD2VUFhuIzmINr17zEDUm04R1Q04TfKT0tZgg1oQdJkG3Ls9rhYRF/ymV2W8Wr0oZxSIdcuQGzgUfxg58mQvqgIum6vc8i/YpjdrpHLU6CfaHA3nJwp+gAMPH1PsgSUbRMJAj3AkahjtsrWPD/bCN4C4JQjl4L5tj9dBb35034qDV59TipM17ynm2rWh3hxHnWxPkptxWmYZqzyfZU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bfe144-922e-46a6-4aab-08dca0c8af52
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 10:11:37.7079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAe/ViNI9Z2+BmtuPjhEMCrXGXx3fULz/BPWmRdxBYsLYL/K7cvhVBZRo8OoBxMuB3VDwV/KA+CNrCoVHeOKpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100069
X-Proofpoint-ORIG-GUID: BgR_uw6iM3Qz12Q271HX-7QFlT5ejfiO
X-Proofpoint-GUID: BgR_uw6iM3Qz12Q271HX-7QFlT5ejfiO

On 09/07/2024 17:48, Alejandro Colomar wrote:
> On Mon, Jul 08, 2024 at 11:42:25AM GMT, John Garry wrote:
>> From: Himanshu Madhani<himanshu.madhani@oracle.com>
>>
>> Add the text to the statx man page.
>>
>> Signed-off-by: Himanshu Madhani<himanshu.madhani@oracle.com>
>> Signed-off-by: John Garry<john.g.garry@oracle.com>
>> ---
>>   man/man2/statx.2 | 29 +++++++++++++++++++++++++++++
>>   1 file changed, 29 insertions(+)
>>
>> diff --git a/man/man2/statx.2 b/man/man2/statx.2
>> index 3d47319c6..36ecc8360 100644
>> --- a/man/man2/statx.2
>> +++ b/man/man2/statx.2
>> @@ -70,6 +70,11 @@ struct statx {
>>       __u32 stx_dio_offset_align;
>>   \&
>>       __u64 stx_subvol;      /* Subvolume identifier */
>> +\&
>> +    /* Direct I/O atomic write limits */
>> +    __u32 stx_atomic_write_unit_min;
>> +    __u32 stx_atomic_write_unit_max;
>> +    __u32 stx_atomic_write_segments_max;
>>   };
>>   .EE
>>   .in
>> @@ -259,6 +264,9 @@ STATX_DIOALIGN	Want stx_dio_mem_align and stx_dio_offset_align
>>   STATX_MNT_ID_UNIQUE	Want unique stx_mnt_id (since Linux 6.8)
>>   STATX_SUBVOL	Want stx_subvol
>>   	(since Linux 6.10; support varies by filesystem)
>> +STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min, stx_atomic_write_unit_max,
>> +	and stx_atomic_write_segments_max.
>> +	(since Linux 6.11; support varies by filesystem)
>>   .TE
>>   .in
>>   .P
>> @@ -463,6 +471,24 @@ Subvolumes are fancy directories,
>>   i.e. they form a tree structure that may be walked recursively.
>>   Support varies by filesystem;
>>   it is supported by bcachefs and btrfs since Linux 6.10.
> .TP

ok

> 
>> +.I stx_atomic_write_unit_min
>> +The minimum size (in bytes) supported for direct I/O
>> +.RB ( O_DIRECT )
>> +on the file to be written with torn-write protection. This value is guaranteed
> Please use semantic newlines.  See man-pages(7):
> 
> $ MANWIDTH=72 man man-pages | sed -n '/Use semantic newlines/,/^$/p';
>     Use semantic newlines
>       In the source of a manual page, new sentences should be started on
>       new lines, long sentences should be split  into  lines  at  clause
>       breaks  (commas,  semicolons, colons, and so on), and long clauses
>       should be split at phrase boundaries.  This convention,  sometimes
>       known as "semantic newlines", makes it easier to see the effect of
>       patches, which often operate at the level of individual sentences,
>       clauses, or phrases.
> 

ok

>> +to be a power-of-2.
>> +.TP
>> +.I stx_atomic_write_unit_max
> You should probably merge both fields with a single paragraph.  See for
> example 'stx_dev_major' and 'stx_dev_minor'.

ok, I'll try to merge. I do note that we then will still have 
stx_atomic_write_segments_max in a separate paragraph.

Thanks,
John



