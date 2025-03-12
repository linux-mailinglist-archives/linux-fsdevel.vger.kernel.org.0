Return-Path: <linux-fsdevel+bounces-43780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B61FA5D7E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 09:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8066F3A505F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Mar 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073B0232377;
	Wed, 12 Mar 2025 08:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YTAvmg1N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mO0lgKBP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991CD230D11;
	Wed, 12 Mar 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767008; cv=fail; b=uCzwTZdoR/NUN0If+aSkGw2RvZ0lPrD8VYp1aAYJYGUUKpmX8miJK7hpttmJ26snx4+fq4FoWn4o6Y7A8pZ4Fgw8BSru5gMPBAvrS4nF5WFXcCQ37FnnILhfu7cANXhEuKoAo3tQ88dqEXOOT8LrcL17VStmeJz0+Q15PUQhcSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767008; c=relaxed/simple;
	bh=DCPm+qOWdaN8262u/Iv+awH+6/ZeogCtRcPhzSSr1e4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpSvFP1ucVETd67zmaSwx+IeDJSKTmbzgLHcIS3DH/eyKG+Nwj39PO64hlaSNvCSRLXz0kehDd5nkjViIagvVTthMkq2PGbjzV09qPZvIJAO8oQgDDXwyCAWSh0AzczwqrAKv5u2V8Minpxsqj5zAb9FgiPMBgZGTVGSZ5+iMiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YTAvmg1N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mO0lgKBP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52C1gdLP022618;
	Wed, 12 Mar 2025 08:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CcoTP9c96g3b8WOS2WVBUwOg+FtoWTfqJLFYUdm7LXA=; b=
	YTAvmg1NcwJWUAivW/W+5QjntWRsi//9Ru+Y5Mn10zdJUu7pF3N/hmENbG9E9BLq
	Zyd76FOJBkVz9vJhzk9jiuNXmUVPMdk50l6bHFtzJgHblDFmWuHQaJoA2LCi86qr
	XEUI5ZS9+HImAfILweQw02jYGCIfomEPcoH2Shy8X0PppVuYncUDjDe2klNwstTU
	5BYjGeUP0qeVjP+wUkti2qOAXsPwUK53nV9Bf9B31YaJDutZEQ7P47xZYu8zDrp4
	UwBm5H9FFPBhPl4V0aEFEBlmeMXbVbzcolS9/N7yul2nhzO9Z/LY+Ch3qdTtNIle
	CGbbGQEa1jBYU9B1G+SPtQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h145p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:09:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52C7DUXp022277;
	Wed, 12 Mar 2025 08:09:53 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmuxavp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 08:09:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fy2LBF79f1YyJ5WuCY9ykDg9HaK3vJY7sF8W9hzNoak6O8Kz4zwvenM4pVVFiq4lprFU6dJsrW6aSB6nrIKStVcP2iBUnYweo45IihBmXn/wU3n2KTPSUoKDCKWv3OmfACWqCpEbmMXwpcRkC7PiXP8W5uWNhUCL0Xp0BOTQgH/+xpmzdDHnzNHbjHSAGJI/clxFaBo9dWoHAOqSIfciUNes1ozbn+l3VJ+y+SV5JjTlcZKI8i9VZ04vOsNxGlbIOTIoAr4sj1BeIOXyIWRhpdI3kHgssMSE4Q8MSMxupH1pVJA3MUVszOvGf2A0D5tgk8BFTEm/pr+JzdpZmoLewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcoTP9c96g3b8WOS2WVBUwOg+FtoWTfqJLFYUdm7LXA=;
 b=H9O75id09GJxrDXnvgLwpSM16OuG7OMFHEYMTBjRuJ3DRe9YB3R39JW3f4pffxNeUGIK5Ir2NLllrEtJMB4Blxy3A8oIjYqvlPZTCUQaIG6tYDXsg5hxuKwzBmGr7hPjahkGzDMSdAGCdWS9vpFb0gIyI9l5/ch6oSfulfuT4J22hiGWgidWUyi/li1w9lcA6+gHRv7s+1Bp2C1aaKWae/xyK1fPfhVeM7dAfPwQ4+CC3GRhtnlJYuDuwdhG5gLFb55njHgS4ULJXJBSC3YCUIrUy2LHHW/ZrP6vO0CRCbD7TYbxd1Rpf8rY/hDxHyk1WL95OTLh0zcw/pTxL8dGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcoTP9c96g3b8WOS2WVBUwOg+FtoWTfqJLFYUdm7LXA=;
 b=mO0lgKBPPZ6UaoC1mqLPL2HFYesEdCKxYw01HiBioAhUGd6qz0s0fnpxew9gTdneC0JioJpkznAguTKivNAUhhXN2z96y91M/A0VYEW0SNn3ly4UjpFEXREOm0fIfX4umgf5GOiSqoahL1+dYPcCEajvL0e5L6h8f6pWJT5nYbg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6726.namprd10.prod.outlook.com (2603:10b6:8:139::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 08:09:51 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 08:09:51 +0000
Message-ID: <fb6f286d-19b5-4f30-ac0d-799311980521@oracle.com>
Date: Wed, 12 Mar 2025 08:09:47 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] xfs: Update atomic write max size
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-9-john.g.garry@oracle.com>
 <Z9E6oMABchnZIBfm@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9E6oMABchnZIBfm@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0067.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: fac89e71-b00b-41fc-addf-08dd613d4371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHNvajJQQXZyaU1TbGJPaUNpWk1lQUJONEVhT0hHV0hBNmpqUHFVSnhmUkRB?=
 =?utf-8?B?ekJnT013L2l5QWJJS0NBTTZEUzZPSE9ZWmozRHFiL3lsVHFKaGpROVQ1Mmd6?=
 =?utf-8?B?TFFnRHZpZjhMclRwMmVwRThoekJPandxLzFVSll2Wmh6eGJOeVNHWERJQ3dw?=
 =?utf-8?B?VVpaN3pkMXIzbmtUVm90OGJVcERTUU81R0JEbjNTcGt2cDFwTG02YUV3Vi9I?=
 =?utf-8?B?ZnZWbEZzMGh2OVRlSlVmbEwyVFZWSkZucktaei82aW9nWisvaEF3VGlRdVRR?=
 =?utf-8?B?aXVsRmI4N3h0aUhpMnRHZGR0ZUNDQWZULy9zZTBLOW5nNTViN3hjQWhJaDFZ?=
 =?utf-8?B?L1FTVzhyY1NNekRzbXE5TEVBb056MnJPRWtoQSt2RnM2a294aU4vR3llVzhW?=
 =?utf-8?B?b3A5WDBNTnNyOVZCem1oTDJUR2YvYWpUMDQ3M01mTm9SQmloWGVWMThCNXkw?=
 =?utf-8?B?WndkWjJpK0pzbkZoQk10YmcwWHgwMVo1VHZxVmNPUWJmMURQVnRjRVNjN0h6?=
 =?utf-8?B?N0JBWmpaZ2pBbEx5OS9ZcFhXT2piazltcTNsTTZiQ0FVQlJNK0JEL2RrejBm?=
 =?utf-8?B?LzNwUHUzNktUb05FRkpwUGovdEs2S0ZPc2J1aXZPWHNrRmRseE12UDB3QW9l?=
 =?utf-8?B?UVZtRDJkSTZyNjVuSStYdlNXd2ljcVhVVVZoWlFjWTAyT0FHKzRlNVkyMTNh?=
 =?utf-8?B?Z0l1djlDR01nM1E4Z1J6S1NQUTN0Q1BGS2lYcUcyY0krRDA5MzZsZkRKblBv?=
 =?utf-8?B?ZEtLVGdyWFkvV2YrYWNSK1F4dFpoVGxla0toWkd1azBIZHpWZDRMV2VJN3dz?=
 =?utf-8?B?MWFpcTR6cVE5NlNQRUx0N2JGVlpVTWhaUHJOWjZVSlNDQnExdGg4LzJTVkl4?=
 =?utf-8?B?UjFoKzNoOVhzRHZTdXR0TkZ0MURGQVNZVVM3VkdGRDZnL2lFV2FrR0xKVldk?=
 =?utf-8?B?NktTdFZjM2hHZVFLY3V6T2FneGFwaU5FbjUyOW9taGV2UHJQS0RMSysxVEhn?=
 =?utf-8?B?UUVKSGhxWHRTZDdmVXNiVEZ0NmdYanpSS0pBWllDZ1NsL1kwM1BxOFBML1Jh?=
 =?utf-8?B?YVl5Zk1RTEt3eHpxYjFSOTE0T3FEK0lSYWJsOXdYaTFxdGJPTWRCaXRBM3pu?=
 =?utf-8?B?WjVXTFF5SXdRVjNONmdwTitGNVRxaUtHTm0vNGllb3o5RHhrYXY5Uy9OdTNT?=
 =?utf-8?B?eW5TdFQ5VThaYm50MmgrSTBYMzRFWXgxNGpIUFZvNEVhN1JaNlZNdzBJNmFn?=
 =?utf-8?B?by8vd3JZWEJiUXhYRHcwc25GZHdkeDNFWDVOTjBtakgvdkFXY1hwRXRER2xs?=
 =?utf-8?B?d3J3RStkN1JUcGJCNThWZUZ4eEtiZ0QzNzFBTXI4NVoyZjJsc0FYR2JQKzdT?=
 =?utf-8?B?UDlvc0FxME5mOGJ4UDNmcWljREZ1enNyY013OG96Q1g4WTJ2RE1SaWVUMzNP?=
 =?utf-8?B?TWRBL0hocGVaRjJ1MEpuQTBhNHpFNkVmY2RyVHFkV1V5VGFTR1pwL3QydXNM?=
 =?utf-8?B?b0JCRkp1aG9uYU5UaGZ1S1BKWjlhUjkyRlVnU0VsNnQ3Mk1hRmU1Q2Y1Qy92?=
 =?utf-8?B?VDZLR1NlWG96TDlhSUxvSnRGYnhwNnR5T0hZMkNSbXk4cHhWTlI2R2tjU1Fa?=
 =?utf-8?B?RWo2UHVpUk9HMURCbnlHY0FXTG1EQVQ3TzNLMDBWUG1TUmhucmxDZ2tGeStK?=
 =?utf-8?B?UFlBWkFSelZGNFBaL1FlQVJBQkFBVHdwZWMvTTNhMlNwUlN1citMNVN1bWFH?=
 =?utf-8?B?RVI4NE5HQ1ZwV09WK09jcGNwK2xyaG1uSUFicEdwbnljN1l3K0syL0o3SHhT?=
 =?utf-8?B?cXJSV25DbnlWakYzVEU4b0VSTzJsYU9mSDBGNTBIeXJrV05TNm53RUFWbTBI?=
 =?utf-8?Q?TL6Le697wDGID?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXFCL0w3V3RyWXIraWUrWnhXVjN0YUMxdHM4Yk5udFZhTDI3Z1cyK0xrRVNn?=
 =?utf-8?B?UnJvZDhRcnphQjhDM00zelArV0UvUEsrc0hoZmpFcmJRN1VFcmxBRlg0ZW4x?=
 =?utf-8?B?dTkxdHFIaFRvRTdKRUlLMW8zeU1uRzNseU1kOXRzNGhBenBPU0JCc1dyakJj?=
 =?utf-8?B?SHUzcjJOenkxZVhlVUVFUXZHNXNTOWRDUm9hT0YxcW4yRWRDN0MweXJxdVVD?=
 =?utf-8?B?SjQ5czNxbldhRmYzb25scGwxdDhISTFqV3Y2U2R5M0hENFBjYmFQM3FHblFB?=
 =?utf-8?B?cEdJbEdXQmVnNEgyYis3QnpseVA3Mm1aSnBNQmErTENIOXpCTlZEWjVxRnRi?=
 =?utf-8?B?aUFDb3h0bGNJV1gyNFh6NWcxU0w1bzhBOXdpc0daNjZSTG52UjFyUFY4U1hX?=
 =?utf-8?B?ckgvZWxydzhYRzQ0c1Rnd0l1U3U5QXlFUnNodTcycC9kZ0xQbG5kNXBudlF2?=
 =?utf-8?B?WjFId1RPVGNKTlN0ZWI5ajd2RzZKU0M2aTRYZVRUd2c4cUdkNHpGTGYwVWJm?=
 =?utf-8?B?NWplYTU3bUtoaTlBUGxROElXTGNHSXRkbzNDVjl4U3ppc3lxWGZScVV0bUo5?=
 =?utf-8?B?WDZyYkE5WlFUd1BiMC9sN2dUNXVIVFZqTDJBSEtLYk5HRDI4MFBKRVJzV3Vz?=
 =?utf-8?B?em55SUpjSTA5WS8vQ0NGeHNIcDhKUU9HZjVTSVpRQ3JmWXVVVEdOcy9sdDcw?=
 =?utf-8?B?eFl3KzlQTUtiL3VUUzZFZmE0eWM4dFpjdDdYRzRvR0tIU29NaGxqTFl5THdw?=
 =?utf-8?B?Y2VyV2dDK09lYmRkZzFyQVB4NWgzNjJDSUxsYmtjN2VqMmpvMHJXNzZxOEk2?=
 =?utf-8?B?emRweERyYTNoQmQreGYySjUxbUduMUR3Z3B5SENhbmUvQ2dGSm9zakpWRDJq?=
 =?utf-8?B?L2pPSEJMbXR4VDR0WFJmTWpLZE85SnZNdkhUZkcvTmRUMjhHalM4OVhXVFY2?=
 =?utf-8?B?QzRyb2VmUVJCWDBvR1hUeW84RktpZWhKMXo5akQwaDRZTy84ZUNZR21LZFlH?=
 =?utf-8?B?Q1pjMWJHb0xPeDlUbmpoNDEyM01CS041MW1hSGFKSlNZR1BlcFhhNGNDbStG?=
 =?utf-8?B?MmlzOFBHVFpRUDRmY0JwRHh3elJsaXBlalJJOWtReWVEV0MzMisvQlNhZ1lu?=
 =?utf-8?B?UVRPNTBvS20xQ1ByWGlLZ0htWU5jMnpMN2NKZmduTlNwOG41ZXdXL0FIQm0v?=
 =?utf-8?B?T3RzSUU5cGVxNEYzeG5rQVBPaWpmZER6Q3hObVBLQm9uMlZTalhwQTZtOU9X?=
 =?utf-8?B?NVFTY01HMkNFaHFaWlNHTTBtWVpHM2lzaWJoanErRmx0YkNyM093L1Zxc0p3?=
 =?utf-8?B?cy9zSXh3NlROd0t2bmRrUXdpVURoYVdOYlRlZ29GYSswNFN3VUFnWUhYWUor?=
 =?utf-8?B?bWdOK3grTmZGZ0tvOXBJcHA0MHlWYWtXK0ExZ2VwUW95bjM3TXZlNGFPRm5Y?=
 =?utf-8?B?Nlg4bFFIM2ZJYmFuNTZGYlpvS1lhbG90NGtNQ0RXM1hROThKL1pySzBJSkdU?=
 =?utf-8?B?YzF6bVpaR0tTWG50TExOTjdieXIzMVExSlhPY2xvaUpQMmZZK1ZmWEtPa3Ay?=
 =?utf-8?B?anJkaUZtMmpCemkxdUFuYkI3ZlZzc0krU1BscC9pQVR3Q2ZidGQzdnVXQXNI?=
 =?utf-8?B?ODJ4Wlpyd1RGRE5VaWtUTFdLTGo3Y3A2YXBBVUwxNk12NDJwSWFQU05NbUd1?=
 =?utf-8?B?bFBlekRDcHdHZWlpUHZEV2d4MlZuWDV1VnVUdVpJU0ljVHcxUGIwNnAxTmZr?=
 =?utf-8?B?VUNxd3NiNVlBYUxadU9HQSsrakxnUys0TmZIS1JrV0tkQm1zSHVDcHNyaEIx?=
 =?utf-8?B?TTA1YnRxSjFKeHlOOEV1eUdUM1J4TzdNb2JMbTZKSkFvSklPZXRQYitpamd4?=
 =?utf-8?B?TkIzWkg1NlJzZnQyOWkvcXhYR3ZjMHkzV3FGZUwwSnVUOVNnTHAxSjg1RU1T?=
 =?utf-8?B?bmNwUG1ldFZoVDIvS3pUa2JucXZGV1Z0ajd0a2l4OXQwc1JCblJrMnhGMHJJ?=
 =?utf-8?B?QjVZOEtEdnM5SUEwQVFjK1g5QjRvVTM0VEVmNnk2NHI5QjJ3U0xhdnFuc2xv?=
 =?utf-8?B?dTJKQks5dFpaL2NVVDRTUFBDTnBkU0I4VFNVN0oyTlhNYlIwS0pEVDBYT3Z5?=
 =?utf-8?B?blVaMGVBa253UTIzN2NLaWE2akgxRlhuT1l0aWVYMTRNYXA4bE40OTN3STIv?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gVS0vHSkzTVyY2J2tSvC6mZy3a8TWId4lBmY546TAO7A135OMYA8ajnJYgTTpvDoL0farRBinxXcLBT5aEmov/d3MS4BzcRk4/CTO+Cif8REaAaWy+NZT4g+rtOJwT7XA9jmA8NI+4g13GwjECa/hG9YR7OZwAoWwyE4nDBYSD3Bl2Y6Xku3iI9esYJ1CELiFmn9Naw6f/LBNRfLlvtoaELRoWPidkMF/TlFP1sAXpLhHQF9SP4cFREMuQPHfytvbVAdOVdAmyfiGJs+p/bwW2dQW05CdCtM1CWNRQK/T2JT3G/abmupab+J2SgTiZ5UO0Jj+n8wkNqaD3sd9efyGmurfgRBoB6FfO2Do13SqBnooYWH+q63nkjKpLDdMcxMF2GQJxLGiG4M3q7K72ZO1rwFNgUMbD3jqSot8OxKC4PBozzoe2PZOpYVauWJ7S6LlSsKrtjWAvoSOfYxNuCOL2fAhWEid+PZ1OZNbshBb9nhI3lA70tlVVHjnoWC0JP+U6pRpaCD2I+XSBlwV+rQ/w/tAnYDydtzY5b+MUBnaEUO4MT9e/GH8e6lXYBDN2MDt4Kb2Pe/bmsYPn73qoQfnXdsrFUfegnuNrODccQlihE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac89e71-b00b-41fc-addf-08dd613d4371
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 08:09:51.1124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPtz8F8lWpDjOqV4mDlYl39r6aYCwlsYlOCwH2IOYui0M078IyqbdZd5kiwNqueFQL1gLC1FFf2Ip4lBWvV2HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120054
X-Proofpoint-ORIG-GUID: dc-BDOXIM6nNeUEo3xCupySvizA6MT97
X-Proofpoint-GUID: dc-BDOXIM6nNeUEo3xCupySvizA6MT97

On 12/03/2025 07:41, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 06:39:44PM +0000, John Garry wrote:
>> For RT inode, just limit to 1x block, even though larger can be supported
>> in future.
> 
> Why?

Adding RT support adds even more complexity upfront, and RT is 
uncommonly used.

In addition, it will be limited to using power-of-2 rtextsize, so a 
slightly restricted feature.

> 
>> +	if (XFS_IS_REALTIME_INODE(ip)) {
>> +		/* For now, set limit at 1x block */
> 
> Why?  It' clearly obvious that you do that from the code, but comments
> are supposed to explain why something non-obvious is done.

ok

> 
>> +		*unit_max = ip->i_mount->m_sb.sb_blocksize;
>> +	} else {
>> +		*unit_max =  min_t(unsigned int,
> 
> double whitespace before the min.

will fix

> 
>> +++ b/fs/xfs/xfs_mount.c
>> @@ -665,6 +665,32 @@ xfs_agbtree_compute_maxlevels(
>>   	levels = max(levels, mp->m_rmap_maxlevels);
>>   	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
>>   }
>> +static inline void
> 
> Missing empty line after the previous function.

Will fix.

Thanks,
John


