Return-Path: <linux-fsdevel+bounces-44191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA00A64867
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9CE6188475F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Mar 2025 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B42D722F178;
	Mon, 17 Mar 2025 09:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oggACnRr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TeCl8jDX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF3D22ACEF;
	Mon, 17 Mar 2025 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742205488; cv=fail; b=I5KqXAqWZC77j6446QUxEPXsLcolGTr+M5ubBOsJoVHSfbL5nuht2axmR5N3R+T5GDtLHMgbx71tNzVPCsmlJCKQTKq8+yfCyqw9WL3nMe8NvLTXZfjEnJmDKZtZpeZ61KUvKjGn++vx+VZC6dQms9q/3gu/RPHEUWoQwBjz0LA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742205488; c=relaxed/simple;
	bh=XK4azjwgDBiJUr/z7wQcc79TIJsq9u/Yyfou8o3u+K8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ss3Jj7kFnYkfIMBHn60SCYJW+C1a8f8Ul575DhMJ2V/2kjWWMP1B+by570rZZqHDnLap2P5VQ/ELTFP03JqDhDaBRNP7ki//xpcRUySDIKfxODl3wjMmd0nIke2AhFyjfcIS9arztu7epLe839G6N7aYfWYwt8AVx2xnRsL6bNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oggACnRr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TeCl8jDX; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H7QlH9026903;
	Mon, 17 Mar 2025 09:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=g0kvwUCDKcebgWBXK7alfJGdqLIYriAF64/xj/1f50k=; b=
	oggACnRrQGT6aqzjNSHvzBG1dywL5dqiOoVDP+Fa7Pqu2gCtXKWpyxDYg/ONGOlK
	12pSm091cPzCK9Kivw2B0iB7HKfEGDe+FR5kl0KH/mJWosGTM3jWGZYvHmwm17AK
	F/4jw6gTiHNnyppuq1jtOqhTxhOIDozYNp6uv01b4IaN9cI4eR3Bzeeho3/oJ60q
	AIotCD5Yn5qltxNWetCFfFAH50rXhkVIZu/1nhhuEXm8jHi+xvzZeNeUuqxrcgOe
	EJrnBypUJQLUTyiwHneN9pjBJ3U15a+YerztanF5Jys/yw7dY98k1QiQVPOi2Q2I
	frEv2Uc8Q583GQ4d6UZdwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1n8aayg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:57:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52H9AbLs022414;
	Mon, 17 Mar 2025 09:57:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxedq9sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:57:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7lISbPEugvzp65hSLsXF/easncqQtjT5mSqjNNSNImDH+L321Eb++f+iC8OUSu3A37yt2kCK1t+5P60UAIe4MqczNEieXPiOCzOVGLrPlquEMKPFXAB2TFzW3i7cKFef30S6Nfsz/9M6/av7zkkFSeHWuWZPOG7j0mqwJVcLtMulKwp/+LtJutvqNyQoJmtpC6LJyQ2vpirsn9xfC/pppQu0mJ/KmSM7VTtwty2ISrlPO5u8uH3nw3e6WFHCAjX5nIbla0zgHwYpwPkBmaMj5hWm8irIYRTEEhyaFq33KlY32Uz5U6hx2iOLdJu0f2Ne9//hP23H58qGU95O4h6Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0kvwUCDKcebgWBXK7alfJGdqLIYriAF64/xj/1f50k=;
 b=axOxYdZnlEdD2BsvgMysOzclCk0AuqyQI58iKNMvl/juq7lSvcbMoZaj2vi8iSlid642pZzQa8i/sp+p8ctsY0OHliUEwSrcPmW5njr9gXHTtEtaXbWbEr1Q/AKW7eF/37nkQPrZmtgPMVbyfQY395ZEBaWyfPiKyNYYFrIu1rBR6O3HTCYHwx1O5qHEjBhCRS/+Zsqs4tNQ5uA6rlSugfYmOfsP4IJrxgTqDzqZ8co21KhWgZeyh91ie3Zn63xk4TUWQu1bOo9hR5yrhsEKsswNd814mXrS6YTDxXB69kW782c17RS7QnSZtifg+qJaUM0zzkQr5XYZoAAo7yDN7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0kvwUCDKcebgWBXK7alfJGdqLIYriAF64/xj/1f50k=;
 b=TeCl8jDXhHYDJKf0tnviWLZy7tXEob13MbITrNzekihko/0BSbDyGV+Vf553d+aRaEno34YsuzIlTIB9mh05THqNXQqSeW5NzV2hKz8cmG5kECBYkEwusuLqBlqzemQD+zPYySRWLgqGpba0czcgoBk6eVpkR1Z35LbIODBMUtY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB7527.namprd10.prod.outlook.com (2603:10b6:8:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 09:57:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 09:57:48 +0000
Message-ID: <b85c1818-e5bf-470c-ae0c-6dd2e1525a2f@oracle.com>
Date: Mon, 17 Mar 2025 09:57:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 13/13] xfs: update atomic write max size
To: Christoph Hellwig <hch@infradead.org>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, Carlos Maiolino <cmaiolino@redhat.com>
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-14-john.g.garry@oracle.com>
 <Z9fOcFB5dhpK4Lsw@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9fOcFB5dhpK4Lsw@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 354897f4-3a4b-4528-60cf-08dd653a2c7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZTJ2bWI2blh4bXljb0NGL1dlcVpmUVJKOW5HZ091dUc3ZS94Z2szeC8xNGFB?=
 =?utf-8?B?MmljMWEvUkY0dFhXNUxNMC9Ubzk0VkdLblFKdTdBcEdsVHNxaHJsS1Z0cTZH?=
 =?utf-8?B?T1I4Z1FhNk80MmIwOHZxc1JUT3k2SVc5SG8yQlZDdzZrc0g1NU8yVkFXN245?=
 =?utf-8?B?UkVjQmJjeDhNTFVRcHQ3Mml4VHhnV2tjRU9jMXpzRmhmWGg5c1FRclBVVW5s?=
 =?utf-8?B?SWxBZWdZMlBQOTJOU09PdUhNdHJGcldoc1FOeW9Dai8rdkREcnVmVXNvTkpi?=
 =?utf-8?B?Y1djYmtsenhVZDZ1ckM5UzU2TE40ZE9ZVVpNTzFDV3BJUzUxSFN0eFZmZVRU?=
 =?utf-8?B?N3dDK2kvT3VCRmJvRlpiekdDVVp3MHROZVpuRDQzbFNSNWJlSlBqS2NGNi93?=
 =?utf-8?B?UGhnV3g2MDF1RzNnVXVvL1BoSEI0dlZ1MHY1RTJ5bHFKVW1Yb1JOMlRleUcr?=
 =?utf-8?B?d3pzU0NoOGFkMlhRRHZQQ0Q3V04rbGpCOGxMS1NoYmhZYVBlcXNPMEwvN3oz?=
 =?utf-8?B?NlhyZ01XTEFCaGpzcnowOWdQeUdaZXFzTEQzQUNLRzlpZGFFdnJKRk5wMmNF?=
 =?utf-8?B?WHdOclZzb1lvdzEzeWJFdkk4MXVkOTNZQStwdzl5NlhIV3R1UzhnOVJnV21G?=
 =?utf-8?B?OEZiNUtyZlFFOGwzUXphVFA1cExRMGpPcEZUdzlPQUFwQVdRYWIwQ3pLNDJu?=
 =?utf-8?B?NlNhdFFMWmZxRDhWMHlGeEk2VC9yUXVRS0QvMmNxc01JQjNBUS95bGtaazFW?=
 =?utf-8?B?WXBCajcxMFVRc1NKaXZ4dFBKWlk4LzhaZS9RV2RyNjNIZGpSclY5Um5XN1Zt?=
 =?utf-8?B?WjN2QlkrZkl6ZWR4YzQrS3B5Uk1aRlM1cllNeG1KSW03dmZpVTg5RDlveklS?=
 =?utf-8?B?SEc0ak15cWRERXh0QVBCME9pajRxbTF3TUxBVVFjUXAyTzhEZ3dhOElyUHFu?=
 =?utf-8?B?TEo4TTlNK0wwV2lkdlJzODFBN3dyd2l3WC9XMmtmMEt0NFMwMUZnV012eDhE?=
 =?utf-8?B?cHpqYzZaV2VjTUNIM2d1aENQVjZyNWxhV1VVWXdKdlQ3VzdNUWpuRFo0c1hV?=
 =?utf-8?B?SnpJTjBGUmx6dkdzQ1c0MnkwS0RNanJ3TnhNWWtzbUs0ZDhnN0dSTCs2Mm9F?=
 =?utf-8?B?aFNjWUIrNXVJUThiNFd2djNwaTA5WW9JUldrWk8xcmpQNGRtakZIaE02VFFD?=
 =?utf-8?B?VDdEaWxJaHJGYzNpTEdCU01PdEl4cnJsZUhoVGZ5aTROdHV4c29nM2hDWTMv?=
 =?utf-8?B?ZWg1NnN6VEloWit5WXpXU1RCQTA3U29kK2VnaVZ2cHdXejV6OUlDUUMxSW1M?=
 =?utf-8?B?bXlWREYrd2hzRVRuWWk2V3JJVkpZbG0xZm5JZ3hDWVQrcHV3OXI3ZjVjM0VX?=
 =?utf-8?B?UnYvS1ZyWWVqa3dCb0VyYkJmQmNRZG16YUQxcUczaStTRHNJbTQ3RGQ2WVhy?=
 =?utf-8?B?MDYvSlpzU0NqYWdLdUVDNlFVRzdzYnN0WC85OVZadGJjaytxd2t1SFZhVXB6?=
 =?utf-8?B?N2dtMXNpMzJROGNlWjJWOCtJSEJJenNWT0dnZXJBNDVaRnBlYjl3WVJHZHll?=
 =?utf-8?B?RkJyMmhhM3c4aDE3V2ZaYzQ3SGpRUzFiY0pyRjdhV0E2TFFieFVCL010VVFv?=
 =?utf-8?B?YWZTL2Y4NnZqRkd3RURObXhHbDg4OGl1cFR5ck5tVWV6VnN4YkFLclI1S2Nz?=
 =?utf-8?B?Ny9nV0tzNkRjZGpobFFNMU1BVWxyaHNMUEpIQ3U2RUNZNzROb3RIYW5LVDB5?=
 =?utf-8?B?TzhuYmtCZkpLK0NjMmU0Uks4T1ZVNURLcEtJRjRMVkZ4bjNZdTdUbnpWYW80?=
 =?utf-8?B?bDdXOUNYUEJWNGU3TW1ZaTZXMDBJL0FhL25sVm4wNS93dWIzQlZkdWx6am1m?=
 =?utf-8?Q?KVqp5+tDJ+3Vv?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zklidkc3T2Q1M1A4QzB3OC9XeTM2dDhLUlU3K0JPTnNNQjZERFI4NE9wTWU0?=
 =?utf-8?B?SDNXZE1GQm0rempZNzBwL2hJU0JwbjFjWUl0MEV0ZmR2Q2NoR3BzdFBMN24v?=
 =?utf-8?B?TWMzdk9lVmRpTzlvdjZRL3hQODZuWmQ2SEZjTnppazNBSnVTU0xmU1A3OU1F?=
 =?utf-8?B?SEREeTJKOTZlUDRvVUJCU21odkhPdE1VdFdFUDRGMHdUV3ZTOXpaYkEweXph?=
 =?utf-8?B?K3Yzdy9Uem9TOVY0UklUNzZEcHJuYUR4U3BvdlQ2L3hjbDVaU2dSK0EzU3Iz?=
 =?utf-8?B?RjVNS2Fjdm9qNXZUaEVBV2J1LzFBZk02RU9MNEdmQS8zS1hsRXZzNzVKZnQy?=
 =?utf-8?B?dnA0L2RTbVEvWG1hekd4QVpNcXFOS3NMcWx5eXVlL1M2TndQVUlWTXFqVGVR?=
 =?utf-8?B?dTFTbzBpMXA0ZCtRNVdxS3MyY3NTM1RiZkNRQTJJWkp2Z0s1bmptVHB5K21n?=
 =?utf-8?B?L2FiZjJVbXpHc21FYTdDYjhkUFhTZkJncGJxOERpWmk0OWdmRDVpejI0aW9V?=
 =?utf-8?B?ODJSWGlPMVBZenlqeWNYMUJvY0lCWkpkc0o5VmZuNHRQclNvdGRWc3lkTHhR?=
 =?utf-8?B?UllhQ2lZMXBvWG1FM2xrTWxsS0RiWDFZUnRsRXMwMkpLd3BHWHMxbmJDNEZy?=
 =?utf-8?B?N3NyanlkZzFLdk5vVDNUbXgzckZtNTFRSExuYmxDd0NYbm5YS3d5VTRxUXBx?=
 =?utf-8?B?eXhvOFdrclVaWnlvMWlNREkwK2VVVDRYS3d2a1pjQWtLUEsxTVM0eTRmd0xl?=
 =?utf-8?B?eko1YXc5cE1pNHlGQ0lrbHFReTdlQWt1a2lTWmdveFk2NVg3T0M2NHRlRXBz?=
 =?utf-8?B?SE9Kdk9jSkJNSExPR2dLSCt4UTZZWkptNHFZTEhhZlpCSWRLK0poa2tCM2ZL?=
 =?utf-8?B?TXdSYjMranh2bkNsdC9kS0pCc3kwQ2NpcGtxZlFJYm1VMnpKdHhId3BtVGZs?=
 =?utf-8?B?Y3hiMnN0SlZkOE5KOTNtbmh6OWE4N1cyOE1QanBYRjRTcmpidUgrNUhWWXZW?=
 =?utf-8?B?R2tDYUorUmtpL2xrc0wrcEdzVXZ2bk5UTVZSZ1J4VElSOHZMdjczajFlSURu?=
 =?utf-8?B?K2pVeE82ck1GVElQK1AyaW9yMXA2WHk5eld0SEs0UFJXYmQyTFlYb2t5Y2ZW?=
 =?utf-8?B?SG1ESFVRNEx2SDZvRTNOdkNGMkhkb1c3TS9tYWd3bXVqaWtYVmR4SWk1QTdK?=
 =?utf-8?B?enVTNHJWM0JZdU1ITWUxSEJrZFdXWnRZQmRHbStFTnByR2g0elVxL3FzS2lr?=
 =?utf-8?B?eXh5cWtISWRFZ2VJV044Q3UvSDNhbUVvSkVMQTNKWjZURnEwcThpMUI3R1kw?=
 =?utf-8?B?NlNtYlVCRExEa1NwMENIdHY5TVJYUGpHZFpGMzhsSFV0RXh1TVFqYmgza3Vm?=
 =?utf-8?B?UnF1NUxReGVQUHloZVdyQWtEck5jbXoxNmpQU3BMWW9KcWtNSXp0c2VGa2pR?=
 =?utf-8?B?ckw4OUdvclcwUHJXSVRNc1ZoZ0Vxd2dNVE9tRlNIUUUzS0doTDh6R1o0b0tw?=
 =?utf-8?B?OU9tUVBzZTR4NUFUbCs2QjZpOHZiYmVTYUt4T0dhdFltd0pkbWR2VGcycko1?=
 =?utf-8?B?aC92SHNXa2k3b2VFelo2Mm40U3ZLTlk0dU1US042anpQM2hYeFZFVzVVeWxo?=
 =?utf-8?B?d0NSc0hpaEU1MVIzTDZyK0pSZXZyZW12eDM2MFVYaVptRzY1NTBBRWlxWCsy?=
 =?utf-8?B?b0hQTVRSejg2Zk9QZkp5c0lFTUJqQUp1NDZSdkRwYlBydHZoSTRWc1RGaHZR?=
 =?utf-8?B?c0g1M0prTEhibGk2TjJXSHhnUExqcGEyTVh3SkszQzMvbWZNbkRCOTh6NHlz?=
 =?utf-8?B?S0tSMzRvRU9YVkhHQnFUczBIcmdseDhCd3RhL3YxUHgrM00yVUg2S1h1L050?=
 =?utf-8?B?NHV3MEJ2VDRGNFRxZCtpOW9kMFAydzl6QnIwZnhncjZHenZieDFCUkVGZWw5?=
 =?utf-8?B?UjJ2STZnQUlKUVBqUExFK2NKYTRGbWs1Vjl4dkg2VlRES1pEaEJqOUVBbGhz?=
 =?utf-8?B?L0l0Mm1pdTJFR2xpT2d0Q3F6aWxRWHlaTEZxV0lJclErZFo4U1M1Vkl1Q1pB?=
 =?utf-8?B?L2RFVmRTNEdoZ1Jva2Y0MnlWQXlXcE9FSVRaRUI1U2tKTWM0NmZNWjBxV2pY?=
 =?utf-8?B?VGw5dUJvb01tL00wTERLdUJEdDQrcHZySEVjaWkzWVNydlhNZFNCR0p0UkpJ?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BYYrVPpoP0dp3VY9Sg6k1UWR8fTsMOJPqMaVOV9eK+tij7I3YPDeBQC2TUdDJkTbERKopB7qTBU6RWMWz/RNG7qU37oJhgluSeYTprqcY7k8lAXaJvNXWqhY2qGlBl/7+C7ooFaMELyD85UUaTZG8Z35i06J1gZdHzrlJpBz307esRxn65sK2WGSY8MKo4i93W6glNPwgNgK27RN+nbAOezd1qALSRWwVOp0GS+CWPBDlaG9iXFnJvaiX5XhFfpWFRCqRYlX1MPzAkktIX4mWK8k6G3pgjLuE8AEPNJskS9nu+IaLGwxTS38m+UzI43r729EqwNmIqnRZ4pAr0UL0gQ6wiCfgildV6CEmja/b1c1dKCETpqqOskdFSlu2uEivi9o//kOkAGRMdPIXvnhGDI6b12xeruCL/JKe74R0onXBkuM2n4xglbedQDcCN9+0UNEb+LKVGYM1ElEoM/bd3jVUfRX58ffJ56S2t2MeFl/rvHTk3fSIdukMVRu50X9X+C4whGwgcjGrBI2DJAKQpS1VbGbMPcjvxH/l0LC6RQ/Wk5V3R9RsFQPH3WG/5zZQST7ynJUOaWNI+NpqdXXh7FpKhAG7hrhD5fln0Uvwbs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354897f4-3a4b-4528-60cf-08dd653a2c7c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 09:57:48.7320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCYCdJ/gw+lgTnxq4fLYwvqZ+BT2kwyMLI5Gr9QttJJ6TdiCIvdyG2L9KRMO+lPBQaODiJXp+n3gJiNn5BG1Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7527
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503170072
X-Proofpoint-ORIG-GUID: 9aSQEYQb3QfllTldmHcxiBeu4bZ3Q7is
X-Proofpoint-GUID: 9aSQEYQb3QfllTldmHcxiBeu4bZ3Q7is

On 17/03/2025 07:25, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 05:13:10PM +0000, John Garry wrote:
>> For simplicity, limit at the max of what the mounted bdev can support in
>> terms of atomic write limits. Maybe in future we will have a better way
>> to advertise this optimised limit.
> 
> You'll still need to cover limit this by the amount that can
> be commited in a single transactions. 

yeah ... I'll revisit that

> And handle the case where there
> is no hardware support at all.

So xfs_get_atomic_write_max_attr() -> xfs_inode_can_atomicwrite() covers 
no HW support.

The point of this function is just to calc atomic write limits according 
to mount point geometry and features.

Do you think that it is necessary to call xfs_inode_can_atomicwrite() 
here also? [And remove the xfs_get_atomic_write_max_attr() -> 
xfs_inode_can_atomicwrite()?]

> 
>>   xfs_get_atomic_write_max_attr(
> 
> I missed it in the previous version, but can be drop the
> pointless _attr for these two helpers?

ok, fine

> 
>> +static inline void
>> +xfs_compute_awu_max(
> 
> And use a more descriptive name than AWU, wich really just is a
> nvme field name.

I am just trying to be concise to limit spilling lines.

Maybe atomicwrite_unit_max is preferred

> 
>> +	awu_max = 1;
>> +	while (1) {
>> +		if (agsize % (awu_max * 2))
>> +			break;
> 
> 	while ((agsize % (awu_max * 2) == 0)) {
> 
> ?
> 
>> +	xfs_extlen_t		m_awu_max;	/* data device max atomic write */
> 
> overly long line.

there are a few overly long lines here (so following that example), but 
since there is a request to change the name, I'll be definitely using a 
newline for the comment

Thanks,
John

> 


