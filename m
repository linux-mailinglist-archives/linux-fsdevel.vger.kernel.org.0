Return-Path: <linux-fsdevel+bounces-32862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 054A39AFD16
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 10:49:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296321C21181
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 08:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388AA1D2B2A;
	Fri, 25 Oct 2024 08:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O4nYlGml";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j2IVnrd5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048241B6D00;
	Fri, 25 Oct 2024 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729846165; cv=fail; b=pQbW1Su6HfkHNj5qWTB3smgLTZglfmpBGNmNkJjM6rxWxyNivpCAHZ2N582QgqNYvsP+rFY9DjRwMg+PCQn1lBrvdwMVpkLKG/2UM9vtRPhbipKzlBUa9pg+bd1Kyeyj9/YOo5ef8n0ocL53ezs9o/t52rz1iMatfENNS3YlWJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729846165; c=relaxed/simple;
	bh=iafaC11mw68+wD9rgs3crpBZQm7hezY96smVtj2AEj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J0Mc/uMzSHE+DynW/byqpOK7WDceoquV55YfKGR1ofyqfvQ+4G/31Iu60vWtgfStusUxAppW5hDf1ggHZlgIYWabp7O91dlxAnKXFiPUwLtlmxil7QSGcJYg8f459jeaxI5XDMEBS5XPuHJVStsbrxj6HCW4EBimmvNYhFJm1VY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O4nYlGml; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j2IVnrd5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BZFq005836;
	Fri, 25 Oct 2024 08:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=w5+1hfOzoQod4dDhoI5ujq22LJM46xwXNeCchZ7kg9U=; b=
	O4nYlGmlwyaynsne7IRG/NGDxzM5lkV+lxDoBBGiavOpW2wx6ougQifaevo6dMMn
	n0a1OsgvDDHVUbufrdY3k+iRRlKhJlBqmsjWlFLCMoFHLpBU1DFVr+nR94UQW8Rh
	95QIrrg9oPEnuF8hmb0nF5fXMpJHD8oRrcMONQbueCpo5fSy3bCwr8PVp8XQtuUi
	L6gwHGINPWRcRrET2EDTyNds6UYl8Fd7y0ATnwRj/jxuC0milCk3zJQQAtQXWu1a
	zHREK5Kt4yNf4lrtC23eQp6+r9wLDUsFH8ea5p0b+3C+MKkRJIoe0M8j3lOhCYlV
	DeGrbewKRwhptj/BJiux6g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uvfus-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 08:49:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7aGZY039579;
	Fri, 25 Oct 2024 08:49:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhdky9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 08:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BceiCK/57Nnke4ARPTmlp66DzlQNeY6ITQ3mvQwH98ofCppdkyxaVxydMjdr3rofp3lnUc8vWR2pNE5i0ZAEUrOpVIV98E4iMvrl9snwVp3yEKnGQoMlBBakXcza+nHgbU3dN11bchB4NI8BFV4iLmEOyqQX3flc/4m7e3wyt7VbDM6f09LhylVpNFaSjEMryYg12ysNFrJ2O725QdJqsghMukHkTvgEbe0T+C+jondfDsWRkmPcKFKdh9qNBKO2rWWeSubg7LL10+Qhi8Uit8fX3rtP3sXg4pesAOAvz785Gpgh/N0AKDA3hCyCPMQ23zrfElO1UopUiu7/5GGQ5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5+1hfOzoQod4dDhoI5ujq22LJM46xwXNeCchZ7kg9U=;
 b=Ru8Jd8iLWudZ+PrbxUg4OXCCqYkcKoe7htryuyZYNs4qxWyxlvptxWqEHT7GrHtLukWIrO+f/PTIkQ802w/lWuKcURXA+ncRUQzr0FOA3aud50Lb5MUjHkLfKjtjQwtopl4qMOYBASo8Or7uBIzoP4L38vYvrmpHSFe8KAWM8N0ZUImwqLT0lSCye8sErg8fRuD68cYRdzEOhMqLny6/sEDfRMTBoFCw39t59SjUxdZycFNWGIk1QHQ6ZUpDuas8Ca8a1arwrZX1C7qF8xl969JEsP3GQG8KJyPTTm6qp4PS6h2lfhZmyMvbeE0tBRfdLL5vZfWlMBJvS6fWwr5riQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5+1hfOzoQod4dDhoI5ujq22LJM46xwXNeCchZ7kg9U=;
 b=j2IVnrd5kxdA3MPC1o5CY4AWDoWV8SG4VNFP0ZtJ8DxKvYltSs5lBAydSZlL/REfZL7qu+OJsqroa1UcRfhQOZFD21/B3PJzpCA4DqcB4GF6XdgzpneVmDyUmCJpL+YKuGjdqfXvQiC9bOTvXDP6I8u3pAphl7XXXdy3CYrmsgE=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.23; Fri, 25 Oct
 2024 08:48:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 08:48:59 +0000
Date: Fri, 25 Oct 2024 09:48:56 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com,
        Shuah Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <de61ff1f-4d18-471a-af75-5aaf13f3d3f6@lucifer.local>
References: <b9851fa9f87d22f352f960b847d99459ef7d74a1.1729198898.git.lorenzo.stoakes@oracle.com>
 <202410251504.707d78fc-oliver.sang@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202410251504.707d78fc-oliver.sang@intel.com>
X-ClientProxiedBy: LO4P123CA0282.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::17) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e209915-a03d-4985-664c-08dcf4d1dde8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?clMvZ1gyMFNXb0JKaHRHTzhBR1dzRVVEZmZ3cTF4SnlJOUEvZWtkR0tva1FJ?=
 =?utf-8?B?cEV5d1NmVk5jWXhzeUw0QlJsSEdqUkJQbVZYajYybHY0MHdHVVlaUVNZNGJw?=
 =?utf-8?B?NGhqaHhQMmgvek40WnJyZHNKSXJJM2F0VDdMZ1ZRdWtZSVJLb3puckp3QzV0?=
 =?utf-8?B?cUgxNUxNSlFWRVRyYWRhME5SZnZuejhyQ0RZZzRxelluMm9sR2hYTnlVK0dO?=
 =?utf-8?B?MldBNlRrczEwQi9aNzZkZ1J6Mngxb3l5VHhxczVPczgyUk5IYkNGVHZWMVVw?=
 =?utf-8?B?UmFtem92TG16U0JtRjlIQXBuNmRhN0VTVWZ6TUt3akl1WnBkWk5YNDdETnhy?=
 =?utf-8?B?dWYzbm9XSXNqNDFXaUJIUk9Ud01UbmNGeG9vVkZ6OWRWNlFtZEhHTDFJLzhk?=
 =?utf-8?B?SkdjNUdGR2hIaXA1QlJRc2NuaTN1elV0VUs2V29sNnphZnMraFMvTjdGVlJk?=
 =?utf-8?B?QUlnWEFINmZHajdNTzJibkxIV1VZYUxFcVdTazRmQjRLVGVzNXlUTTV2bVZK?=
 =?utf-8?B?clZ4eW92cy94MjF4TnFlbTN1aDluTkFrQmhHSjBkWVBWRUJ4Vkp3Z1V0cjhw?=
 =?utf-8?B?cEg2ditUeFZscXJCeHJwaGwzaUNHN2s5T3diZzRxcjlTKzFIcG9iRmEzMk9W?=
 =?utf-8?B?dGtYQzkyTGxvODgwZ1ZBbU1CWTgwL0E0ZzdVMjVFWkFleGFCVmNhK0pycWpI?=
 =?utf-8?B?VEJ0Z3F5aWRrNGdiKzhjcFNnOFd5YXlFeHlnMUZ2L0FYVVBNbVpsTGRWL1Jh?=
 =?utf-8?B?MlRPRjZ2b1QrZUx6OXYyWGJkVGl2dGlhbG1FS2JjQk8vamdoWHcxb053Vks1?=
 =?utf-8?B?LzRKQ3hIWXI4WEdobCtST1lZdzZKdXhMSlQ3aktEQTIwNHpwRjZtVjgxVnd0?=
 =?utf-8?B?VS9iWlZmcFJpbXJoc1VzTXVYMXE2RlZKT21IeUcwd2FqR1VtWjJqSEo4MWRQ?=
 =?utf-8?B?NnpJak9tWHZKa2RRUktEdFNwTTAwUENPOEZCcUhKVjFTWTFlV2VtRGFrdVk3?=
 =?utf-8?B?ZHZVRmJXNUN5czh6NXVhL2M0Rk9GdlR1Qk82LzZuNnpQQkw0MlFnZWFibUFh?=
 =?utf-8?B?UitGVS9aY3VmK1lXT3NhbE9udE16bUpobzZ2UThkY3hjV2F3b09NMEJ1Ym93?=
 =?utf-8?B?QTF0eEhtQi9Ka09VM0E4U0M5czdhWkxleHFDZlRWSVh4a2VuUitJTm5FWWZ2?=
 =?utf-8?B?N0NLV0RtTmFqT0FNUXBodkRvVFlNWXlyeStmd3Q5ODBsWjd1RUcyNzlOdGNi?=
 =?utf-8?B?TTBPZm81dUZPRXc3aEpydlNmWWhSd00wTDg4RUt6UkEzRzBxS2UzL2NXaDJi?=
 =?utf-8?B?cFNGS1lPQjlKdmJQbCtuWXg0QTZKYklabUF5c3J0L2ZzUktERjF6S2FxVFFa?=
 =?utf-8?B?RUx0ZUhzQit0UmdBV25LTzNXUTJwT0ZOTXJBanZVcFk4cW1pbVRUbDAvcUVr?=
 =?utf-8?B?a2wrNDg4NlpjOENkZjJUbkhrNXpPZW9SYStiNHFCZnE2L3ZFK0tyUjJvU1VN?=
 =?utf-8?B?Qnh6RStFNVlrNWxQbGdEMW96QytDay85dEdWaW5tU0hJVDZxdW41c1hkQTZ0?=
 =?utf-8?B?LytYZGErZzRYZjhtb21sem81NkRmZk01bnZWRnRtRjRxdmRaNmUrcXd5Sk5s?=
 =?utf-8?B?aUJkeE9vVlE2WEdab0c3V3Rmd3o1RVBSV0VYeDNTTS9qY3NJd0l2V1BBR1Rn?=
 =?utf-8?B?N1F1dHI5dDkrbHg4VFpESmtZWS8vS2tLektXbnFlVDlibWxnVWJINmNBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aFFIa2Jwd1VwdU9WM09yYkhjZkpNTlhneXp2QU8rMTN4WFE5K1BvTWJxZFE3?=
 =?utf-8?B?Sll1dlBFOXlybTR5UzdzOC9jbjkwT21nclhTNDM0MEgvSmZpeFFCMklhWVlO?=
 =?utf-8?B?cndwd256UWpyc0NlN1NQSUFzYUI4UnY0VUoxTENFcDZqUEJwSUNyNmNobHVE?=
 =?utf-8?B?dlhkYkFkOXFtay91UnhudXpaOG9IbnFwU2sxcDNFbm52Qm9GcGNqZ1VESEVT?=
 =?utf-8?B?NENHbkZTcFVwTlF4RFJUZDhETEtLcnE2VXFyRTRYTDBnVGZ0M1hWMDNMRkdH?=
 =?utf-8?B?aGlBSjFuQTAxTGVxOGdBbFIrWXM0dFY1MXZjMWVNR0JmcWlITFVPb2N4S2JG?=
 =?utf-8?B?Z0xTYmtuUUtYY3hSN2c5Z21YRlZVNlNCL3lmMmJTYUpNeXQxaVBFdnRLV0Jj?=
 =?utf-8?B?aElid1pVV0dOWmhRNDJZcWZHVUNmUUFENnBYcDZuL2NWZ29zdzhvdW5PQ2FV?=
 =?utf-8?B?S1FvZDVzdXpDSHk5anFNS0x3d2tSTFlSQUVOeGw0T1kzV0FKdVF0Z1hKdUE2?=
 =?utf-8?B?Q0NVNVllc21oY3AyWEFHUXNsZWZ1SEREUVZYckdpNDgzclFQSTltVmNZWXRt?=
 =?utf-8?B?enBNQlY5TzJ2bUVzK0d4dkRtR2lQcENnWDN5NEtFQlB0aEZJTFNSQUQyYUY4?=
 =?utf-8?B?ejR2L2dSS1c3ZWIwS1dScFFva29ZMXQ1OGZLZ0FjRk9DWmdaUlVDckZtdGVJ?=
 =?utf-8?B?MnhVRnk5R3Z0WmN0SDhiZkUrSysrbXdRaTdDbUZ3NnpjS2ZMelhQbXpSWklY?=
 =?utf-8?B?NjJZalg0R1MxbXRsRGRVV0lkTlhBekxyYVBXSHU4eDZOTFhYNzlKbTVZNlpj?=
 =?utf-8?B?MDJkWmYrZXdhZjZZekd3dVZsWC9LRktPTy9HcjluM2ErNE1RL2dkbERqdEhu?=
 =?utf-8?B?eFJvb05YQlAzNWY3Vk5vSytGOHA0azFNTXB4SWY3ME5sSzNGcGpObmxRdkx2?=
 =?utf-8?B?cWYvckxhOXl2bkMvdGNJMmNlWVdSanJKY016bHRMb2o5SVFSOHN1T3VtQzU2?=
 =?utf-8?B?SVZBMk9qRFJ1STZJdk5tc2RsRWRHYy9ZUGFubTFwL3RSS1Q2Ukh4MDRydUdC?=
 =?utf-8?B?dWo1TURDSkF2UWdxMC85WDNKRHpxQ1dxTVloUDNZSUg1VUpHdnE1cHZHUVJL?=
 =?utf-8?B?emFXbkdBeFNpS0owaU9TTXBwang4WWxYNEZhMGI5UkFRbGd5WHU4VHFuYjhw?=
 =?utf-8?B?NC9kRTloRE1yWHpXSGljZlhGeU81S3l1ZjljekpGMWdKOUNyQ3FPWTd6N3ZW?=
 =?utf-8?B?VEpPN0F0TklVWFJhYnpSbXMwN0JDSStHOHQ1WjhtYXBYT1lkWXhVTDJ5dWZG?=
 =?utf-8?B?dWFJK05uMTYvcGEyR2hVUEo4L0dtZXVCditBQzdiSXJhV01HdTBYRzYrbUVK?=
 =?utf-8?B?S2ZLeVVzVStUajNTb3lvMmN1YW94cWZmOEFMeXRlcUp2cEYvRXJ5NkFyMXo1?=
 =?utf-8?B?KzBCdmxkaGdUQzI4aDY2TDhaUHVrZUlnTXBFQkdYNUlZSStFK2FIanI0dXhE?=
 =?utf-8?B?YkpIcm1KTzlzVHY0TlY4YTJnTTFHelVQQnR3VEFkRk90M3lvdlpPSWxPdXZX?=
 =?utf-8?B?ZmFvMFRrUXh1c1JZaXI2elNsUmtmT3JIS2VMNGdLM1p2eUc5QnEwcUd4Tlht?=
 =?utf-8?B?QzFFWktrK29qYUd4RlE2bTBIaXIyWklKcktnMk8ydzU0ZFRGSzNhWkJjUTZG?=
 =?utf-8?B?SUN6VjkrblRCU0ViZ0tsYVZWWWEvWVYyVUhXbWRMcTVSYXBnMEJ6OTVmYWJF?=
 =?utf-8?B?RlVTaldaUVg3dTNQL1N2Q2lZeFRBRVhxWjZmZkpTaU5Cc3F2aFo1cFBNZ1Zx?=
 =?utf-8?B?dm5Ka3NRQm5mRjl3dThrampYVEV6ZEVOanJLUi9LNlRZcHdtS2hjM2ZyczJH?=
 =?utf-8?B?RnFESzNOdFoyNng0cGF4anNZQ3hZQmhGOVNPckJ1RTlTSXhXQWJqRXdtWld6?=
 =?utf-8?B?WVRMcmpCNTZJN1NNdGtNTmZIV2dXeUxZR2p4SHFnaWJMNTFvQjk1Q1IvdjZa?=
 =?utf-8?B?NGIrT3RGeEdvNGpPRUNTWTUrbmZmWkNZVzE3REYrRjBmMjluQTI5T0hzNkIv?=
 =?utf-8?B?Mjc2c0lKUHAya0R0cUpPN0VKREpIYUx6M2JldE92cTJ1MlVTYmNKaGhObTUx?=
 =?utf-8?B?SWhXaU9NWlNHUEltOHdnL2V2MzA4Q1o1bnIyS2JLUjUzYWxLMWhMb1ZxaVlR?=
 =?utf-8?B?VHh6bjdhT0x2Ly9PUDNsNzhESDRZQVlCL0ROZUpkeTFFOTFGeUhGMzVXOHNT?=
 =?utf-8?B?M1RWSE5NamZYcmtlcWVuVFUrUVNRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QCmeTUlaijDw+dKQOC9F06v8NWPess37btvrA0bSXUoxxiZFTiR78wjlVGXHBMDU6PeBnd8CefZSLSumTwJt/GazBtI9hjFTdvof7NfTEfqlYFDvzKGiV/GxfaF+k6Ln009qZSC6aF0vL7R0IbKZQftcaNZFtQuqJYYXwFIvmG2J/Lk0A/xeW9uSNiB7vxt8kSnGslcyNxAHUEZoEVvrn2U5euzNcLdv1GH9DcT/FN4yXqKhVpPAcGJmGuErgGAG9YcOb6c6RDqOEVd1hbvqH07Sanc+wXQHI/a1+xzJaj8jovlQItz/I4ziYxOurHCenHXh+JAYJPEWq20UHV4TXtEO5+46ZSbC3kE7lwxJuTZNKSdkVEq//oX5IAFmpTwONanHQThH3uvU+ijzrPD2XMUehMazr38WxxvSXPLvNd6Iq8rZK3pPLq3qf3pIthfRJFoUhhy9Sy8FWAKsrUJ04tat7yRrR2J1JXR9/5pwjHh4C92MkDFGCKEBzRkjwImASpr64WzuZ1Juiq1++ykwrK0wewPftEwGLUFK9W8hLA6i7p4Gsuwv7Ru84/DH6BmOJ4XXJ+px43fH1GLFk9ZaTYuITLy63JXTzCeo/2CGaPQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e209915-a03d-4985-664c-08dcf4d1dde8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 08:48:59.0538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcwPvsoERPYH5artdZBVENp0TNTgBuUBZPIjmOtC2KpeDl6gTy2WsyfcqEkeRGRuHykSu0NYn1KuBHFSD/FjrchdxnqCC4ldJdWllm9XAtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250067
X-Proofpoint-GUID: Fyg4kVAQzeaCni2PJzuXCYxI3ax_YasS
X-Proofpoint-ORIG-GUID: Fyg4kVAQzeaCni2PJzuXCYxI3ax_YasS

On Fri, Oct 25, 2024 at 04:10:37PM +0800, kernel test robot wrote:
>
>
> Hello,
>
> kernel test robot noticed "kernel-selftests.cgroup.make.fail" on:
>
> commit: 930cb1423ee2522760ffde43455b14df5c0d5487 ("[PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*")
> url: https://github.com/intel-lab-lkp/linux/commits/Lorenzo-Stoakes/pidfd-extend-pidfd_get_pid-and-de-duplicate-pid-lookup/20241018-050825

Thanks.

This issue is because, incredibly, the cgroup tests import ../pidfd/pidfd.h
solely to use a helper, but in doing so inadvertently pull in linux/pidfd.h
_without_ the tools wrapper.

Adding a tools wrapper to cgroup fails too because of some other dependency.

I will separate out a header with this helper in it to work around this and
respin.

A gentle point on this - in my view, adding/updating tests shouldn't hold up a
series, rather we should do everything we can to encourage kernel developers to
add/expand tests.

So I'd say, in future, it might be best - if the tests already do something
considered 'bad' - to defer fixing that badness to a dedicated series, rather
than forcing an unrelated one to have to include commits to fixup pre-existing
problems like this.

I don't think anyone is really going to understand why a PIDFD_SELF series is
touching a cgroup test at this point.

Thanks!

> base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> patch link: https://lore.kernel.org/all/b9851fa9f87d22f352f960b847d99459ef7d74a1.1729198898.git.lorenzo.stoakes@oracle.com/
> patch subject: [PATCH v4 4/4] selftests: pidfd: add tests for PIDFD_SELF_*
>
> in testcase: kernel-selftests
> version: kernel-selftests-x86_64-977d51cf-1_20240508
> with following parameters:
>
> 	group: cgroup
>
>
>
> config: x86_64-rhel-8.3-kselftests
> compiler: gcc-12
> test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory
>
> (please refer to attached dmesg/kmsg for entire log/backtrace)
>
>
>
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202410251504.707d78fc-oliver.sang@intel.com
>
> KERNEL SELFTESTS: linux_headers_dir is /usr/src/linux-headers-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487
> '/usr/sbin/iptables' -> '/usr/sbin/iptables-nft'
> '/usr/sbin/iptables-restore' -> '/usr/sbin/iptables-nft-restore'
> '/usr/sbin/iptables-save' -> '/usr/sbin/iptables-nft-save'
> '/usr/sbin/ip6tables' -> '/usr/sbin/ip6tables-nft'
> '/usr/sbin/ip6tables-restore' -> '/usr/sbin/ip6tables-nft-restore'
> '/usr/sbin/ip6tables-save' -> '/usr/sbin/ip6tables-nft-save'
> 2024-10-23 12:53:55 sed -i s/default_timeout=45/default_timeout=300/ kselftest/runner.sh
> 2024-10-23 12:53:55 make -j36 -C cgroup
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
>   CC       test_core
>   CC       test_cpu
>   CC       test_cpuset
>   CC       test_freezer
>   CC       test_hugetlb_memcg
>   CC       test_kill
>   CC       test_kmem
>   CC       test_memcontrol
>   CC       test_pids
>   CC       test_zswap
>   CC       wait_inotify
> In file included from /usr/x86_64-linux-gnu/include/asm/fcntl.h:1,
>                  from /usr/x86_64-linux-gnu/include/linux/fcntl.h:5,
>                  from /usr/x86_64-linux-gnu/include/linux/pidfd.h:7,
>                  from ../pidfd/pidfd.h:19,
>                  from test_kill.c:13:
> /usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:156:8: error: redefinition of ‘struct f_owner_ex’
>   156 | struct f_owner_ex {
>       |        ^~~~~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/bits/fcntl.h:61,
>                  from /usr/include/fcntl.h:35,
>                  from ../pidfd/pidfd.h:8:
> /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h:274:8: note: originally defined here
>   274 | struct f_owner_ex
>       |        ^~~~~~~~~~
> /usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:196:8: error: redefinition of ‘struct flock’
>   196 | struct flock {
>       |        ^~~~~
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:35:8: note: originally defined here
>    35 | struct flock
>       |        ^~~~~
> /usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:210:8: error: redefinition of ‘struct flock64’
>   210 | struct flock64 {
>       |        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:50:8: note: originally defined here
>    50 | struct flock64
>       |        ^~~~~~~
> make: *** [../lib.mk:221: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup/test_kill] Error 1
> make: *** Waiting for unfinished jobs....
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
> 2024-10-23 12:53:56 make quicktest=1 run_tests -C cgroup
> make: Entering directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
>   CC       test_kill
> In file included from /usr/x86_64-linux-gnu/include/asm/fcntl.h:1,
>                  from /usr/x86_64-linux-gnu/include/linux/fcntl.h:5,
>                  from /usr/x86_64-linux-gnu/include/linux/pidfd.h:7,
>                  from ../pidfd/pidfd.h:19,
>                  from test_kill.c:13:
> /usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:156:8: error: redefinition of ‘struct f_owner_ex’
>   156 | struct f_owner_ex {
>       |        ^~~~~~~~~~
> In file included from /usr/include/x86_64-linux-gnu/bits/fcntl.h:61,
>                  from /usr/include/fcntl.h:35,
>                  from ../pidfd/pidfd.h:8:
> /usr/include/x86_64-linux-gnu/bits/fcntl-linux.h:274:8: note: originally defined here
>   274 | struct f_owner_ex
>       |        ^~~~~~~~~~
> /usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:196:8: error: redefinition of ‘struct flock’
>   196 | struct flock {
>       |        ^~~~~
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:35:8: note: originally defined here
>    35 | struct flock
>       |        ^~~~~
> /usr/x86_64-linux-gnu/include/asm-generic/fcntl.h:210:8: error: redefinition of ‘struct flock64’
>   210 | struct flock64 {
>       |        ^~~~~~~
> /usr/include/x86_64-linux-gnu/bits/fcntl.h:50:8: note: originally defined here
>    50 | struct flock64
>       |        ^~~~~~~
> make: *** [../lib.mk:222: /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup/test_kill] Error 1
> make: Leaving directory '/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-930cb1423ee2522760ffde43455b14df5c0d5487/tools/testing/selftests/cgroup'
>
>
>
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20241025/202410251504.707d78fc-oliver.sang@intel.com
>
>
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

