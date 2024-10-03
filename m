Return-Path: <linux-fsdevel+bounces-30909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E728B98F93E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2CB1C2182E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 21:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9B11C6F43;
	Thu,  3 Oct 2024 21:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AZ5foYb/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gvjNDq2D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEA81AF4EF;
	Thu,  3 Oct 2024 21:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727992340; cv=fail; b=by1WEAlrd7NmnLiNTWdxKvKE4MJijwrb7+FIcpBtDtmKpF1dnctI21NXF3JkLNulazj6xgRxzOlsERXJR0lAicNX6ImVhlnZqCsDW2WDOuRR6/ARj7rsd3J8FsGclomYvrSYHrQg22IoOFmmAiRTTpTw3ELitVT7KX4MiwoXcv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727992340; c=relaxed/simple;
	bh=5sTUTmRNm3+Mr+XwYrk2iU+oPLNIp2N2dgVNrzdmC34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ilIUHBSnIDkFBGc9ubabaH9YXh4OUAmZduzdLQ19bu+5JUZtZ19mUqmN1R0giWkemodYZMKOJkIjI+9DBRiZRYY7XVdaATJsf9ZGPKWayF9+h/74axx2r0D7OJHkHVGDEONfASK8AIA1DV4ISn1Vyo7qxEaZYaKMsHrVIfCHvUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AZ5foYb/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gvjNDq2D; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 493Jksp5021481;
	Thu, 3 Oct 2024 21:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=jhuFF1ZutdFFHkg6XnEyyzT8NEsEDjlq2RV3m61oDQM=; b=
	AZ5foYb/7YPgTHXk8ubjDZAshQmS1ib5Nvu0hFOkzrmoLW9P9bwaKykEpB+KOD3+
	gG+V2v/20m9D5oJORZtUP++2meZUcpx54QmNUw4da7Mw5fBwSuLMHwxX9yGBDZy2
	mQkFv0CHWIkZYV289qEHI1vIQjepTpPutZiOLZCvl8uqn98nVFigm+w2As/w0qwd
	uc+ohwj6kb63j65zx0Mzlskn8tbeHX5Jk13hKuIdYmkCvbE6hXyQdbGulJ5mWj1h
	NZ9FaTIA0SJhqghx+EgcKwHhpubXM9h4xkZSAi0BgmFLdA0myacUqw9ke4OOM+CN
	mYlqT3S3mvhliOtS+jGsjw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220498epp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 21:52:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493LiSmd038116;
	Thu, 3 Oct 2024 21:52:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422056ga9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 21:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmxPNWhcSH0CoZ9R/ig2LyjsI8fjm5YcNrDzmOQVBJ2Hqm15Cxqn0PlxC0TJOMtUVDTr06GF6/H40e9VmKa1MtH48R0Emn9taG1NgFVFMiRQ9cnmFfFED1poGUM5b9QHdx5arAgceXNGn0aux2qNS6cCw/i1DEgWWLDwWe5s+fHTrI7innUFf/uKVItFXI6Y+0zhaqqwEYAVLHwEHUuCi9xFShPvv+4D1B/gOFHoPngJznh72qI2MX1XK5YiHz6zGBfDHT/qXlfwius7LMUtHq040xJQp8Tn+BdUbbgOtuM7YDoTstMuoZJ1Ljv/+E/iwn8GkXOEYNEzvCBgfb4AKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhuFF1ZutdFFHkg6XnEyyzT8NEsEDjlq2RV3m61oDQM=;
 b=peuXob3X1wN+Ao8M4qUw+KaMma1jIMGjBF/ZjshRydIP3LeSDkYQ/IsRi1YFYndoAK/psl0MNZl2Rrtxf+vRF5sNdK4nyAZ9DOZQL+pOJG8WZyixc72z8QCt1/8RbqkQjLARorvqk0+0rirGinWeiYplE9b/cg1g7RUUY4gXLAaLmG1fxVh8/v9+NjQItT4V0yj5zFsYyCUfLhzOycSOVXW1uuHf6e+o8BNFyTeltEKqxTiVkwp/GQ3iFT1L9kBF7dk9DkSMsLGhaKNH3cDWi3DJ8SC69n6OhjtrFiYnxbhJdzUzRr/yNhukXP3nSNnRTCWI3nbsEv6E/3UL7JYYRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhuFF1ZutdFFHkg6XnEyyzT8NEsEDjlq2RV3m61oDQM=;
 b=gvjNDq2DcPUJ/WiqBOywVs2JlcxvCZfw4U2WUlTOAyUe/bi0K/aoXmtMpykf5SR8UM3muKiNDkvs6qfMCdOiffpXRxu7mPpM//7kgTiYspEFxZDQDAvL5GDRiomWgWtrB3yy8v2KBFy4A3qUUGsaiCd/YzpAXoAdRw8RmHjEieE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB6344.namprd10.prod.outlook.com (2603:10b6:806:257::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 21:52:07 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 21:52:07 +0000
Date: Thu, 3 Oct 2024 22:52:03 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-fsdevel@vger.kernel.org, Liam.Howlett@oracle.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: 6.12/BUG: KASAN: slab-use-after-free in m_next at
 fs/proc/task_mmu.c:187
Message-ID: <7edcb18f-8877-4c95-83a2-1c5090ffd1a3@lucifer.local>
References: <CABXGCsOPwuoNOqSMmAvWO2Fz4TEmPnjFj-b7iF+XFRu1h7-+Dg@mail.gmail.com>
 <CABXGCsOw5_9o1rCweNd6i+P_R3TqaJbMLqEXqRO1NfZAVGyqOg@mail.gmail.com>
 <f6bd472e-43d9-4f66-8fc2-805905b1a8d9@lucifer.local>
 <302fd5b8-e4a4-4748-9a91-413575a54a9a@lucifer.local>
 <CABXGCsOsZ5TyEjSWTk6e=FU30a27N4J0gqNCat65gweyKPtZ_A@mail.gmail.com>
 <CABXGCsPnsZALwJSLtJN2guTfN8b2LcdZ79Gq_VzpwTKUdfY3nw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXGCsPnsZALwJSLtJN2guTfN8b2LcdZ79Gq_VzpwTKUdfY3nw@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB6344:EE_
X-MS-Office365-Filtering-Correlation-Id: 6074c2ea-5a33-4916-0666-08dce3f5a02c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXhxTHNmS2ZmRmpFS0J5UVhOamluNmxYYUFkZ0RBY0hTK2RwQW83QytWVklr?=
 =?utf-8?B?enEzTE9uSTY1NnBJUlB0aitleVprbUFGWU9aVUw0SlUyQkpCNEVqZTM1Q0pm?=
 =?utf-8?B?WE5Pa3c5WXB0WVlKV0FkNk9JNmdrWXdjN3NrbHV1VEtDdnVCZCttMk5yeEt4?=
 =?utf-8?B?bHFJcE8zMnVhRTQydTBhWE9QUVlPUm9WYTBSaWhVWWNaOUVxZVBXNUp5NzhS?=
 =?utf-8?B?MkVORXBKZGR6c2syYi9nc1ZDWkhtM0FnazQ5VmhIaHBlMWNlMzlWbmdUdEhJ?=
 =?utf-8?B?VWtIRExaSXNqemYyOFdVWS8zZDdVYjBNemVudzREajdYa2lVUWlqTVhsYVBk?=
 =?utf-8?B?bllqTWFORUhnWVlHem1CNzJXNEkza1hiY2o5NlMwdjVydklVSHp6OUwraThC?=
 =?utf-8?B?eE5VK1VvZkVSd2huUFNZcTE3SFB3MEwrN2VFRTN0V3llbWJVVUFvVVpCQ0dz?=
 =?utf-8?B?Q2NGcEF4ek9PUDZYVFJabndjNGM5M2J1NS9qOVFGZ0F2Q1hNMnNuSWtsSWZq?=
 =?utf-8?B?TG5vdEdTRzVmOUFBQ3d2NUh5NEtDZVRhdnNnRkRaR2c4SjlNS1dYZnRTc3A0?=
 =?utf-8?B?eTdDTkNlc0hzbURLS0VRSEh1SUZBSlFLd1RaNVNMUU1jTGZleEl6YUFFU3pC?=
 =?utf-8?B?bldSdDhuVFloZE1kdmRGSmI4eHBoT09TWFFBZWFMQ0VYV1BvU1VCZDV3Znll?=
 =?utf-8?B?MjVlemZUWWtBbUhyKzd5N1VVS3BkYWx1L082VktONFEzQWN1V2IrOTZ3OTA0?=
 =?utf-8?B?UlJHSkZxNzU0bVRFeENPYXdCQlRpZmFrRzA5SWp3dHRIWmtQWURXYlhDbGJ3?=
 =?utf-8?B?Ky9SbEpZUEdyc2pSbHA5Mk9sbmw0WTM4R3ZKbzlTVllmYnJZUkViT01PTEZW?=
 =?utf-8?B?RHJqSVFMaElrY0lUbU1CaGtWZmx6aE0yaDlmVVVWQ3FYTUdHbFk2NGNGeXF1?=
 =?utf-8?B?ZGNDbXUvdGwzcnFiSlo3UDB1QVFiTzRhMm0vS3pBOUhRc1hpWEUyejkrKytv?=
 =?utf-8?B?eHdqRmp0ckRUOU8wQTZwQ29VbGgzMjhRYk1NdUJPR2s3YTRvVnZvR2NYTUxK?=
 =?utf-8?B?alJhTnVRTnh0YTdNOEZrcFRqd2s1SERoQ1ViWUMrL2FnQ0FtbUVoZysxRVpl?=
 =?utf-8?B?Lzl6ajR3VUt0aFFoa2xGaDdJdGNBcmt4ZkFoUHlWd0pvWGdRbUpjNlVBVVJG?=
 =?utf-8?B?YUN5M05PMGRDNXlnRlc5N1MzMFpqMHdheDBRMS82R2RJUjh6R2l2RnhHN05E?=
 =?utf-8?B?aFVyYms3WXhWb0JXa2NzN2VnaVU0cGZkckdhUUw0S0w4cEV0djMyMUlqYnBD?=
 =?utf-8?B?NmFkME1rUGZJMzdLUWpnME5rU0FYenozYVEzZzE1WU5DMnBZZ2s5SVI3WExj?=
 =?utf-8?B?dGJGMnU4cUd6SGUyZENJblZRTXU5RFpDeS8rWnhHTDZZbC82M3pHdGR0aTVL?=
 =?utf-8?B?QXJxOHlHKzVCVDl6OGpVcVEvcHBqT1ZFV0pRdkRqaHIwejlnb0crdGJIV1pC?=
 =?utf-8?B?OVBYSFhXM21kS3M1WVJ3aGttVlJJeGRvaTdDVzlCNnFsSjJVKzN3bW9iUUdF?=
 =?utf-8?B?dVJlU2IrZG5mUDVSY0FGY3NPalBwNGtHRjEwNkdNNDRQNVAwTHljN1NvTzVW?=
 =?utf-8?B?WWVRNGxTcmNxYzh0U1JOMnhlZ0pvSDQzN1Zxa3ZHZGgwSG9CbGk3T3BTYzBn?=
 =?utf-8?B?dWZSLzBaYS9LSzlJQkM2VStQak1ianNIb2VNTllrclNUTTBYZTdCT1Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MElJT2tFK3FyRVI5SHYwN3BrbDlnTGxLcnZuYm5UK0tRSnZwMTFxb21lbCtw?=
 =?utf-8?B?M2pFVEN2S0ZySVVlcjJhRUE4THRuWWN0Z01GZ25hRmhMbUFENU14Y25jSUN5?=
 =?utf-8?B?a0VNMjFkMmREbGR5bHl6a3VVcDJjbXFVQXpFNkxZS1p5dUVkamNCN3lGcVoz?=
 =?utf-8?B?RDkxR1NyOFNXWGlOSVgrbWhTaWRKRjJJNk92dVE4amRkNnpIQ05ySG55QmFk?=
 =?utf-8?B?SVJvaUFGQThvbHZjREtqdUlTeXRqRmc2aDdtc1NtUkFray85ZkhVVWUrd3NV?=
 =?utf-8?B?eDhMT3Bjb25TcDlUSXFTNFRCTXYyQnNuMWtGSlF4TndJOFp0aUYyYVZEWFM0?=
 =?utf-8?B?Nm1xRFZHOEdrenN1RWtGaHBDbUVDNFFVSWMvYVdrTTZWclpnb0JEdUZnMSsz?=
 =?utf-8?B?UThhd01ZbFB4VFJBYjN4SlljM3ZoZytNU1lMdUZXYU1VaEJ2QkVVRE0vaVox?=
 =?utf-8?B?eEVWb1VoNm9lbFdPKzkydjZUQ1pjMWFPcExxMWs4Skw5c2NCVDBiN05ubmNL?=
 =?utf-8?B?THRLYlhWSlpOQm0xVkwwZGxheXd4S1gzVW4yOWJDeHNmZlY3ZVVqOXNZMmZk?=
 =?utf-8?B?VXBpN0s5SmlGeWU4amZuU0MzQmdib09Vc1lTR0FnLzBkV1NNbzVDQXFycTh1?=
 =?utf-8?B?ZjhrNkVva1VKaEpIQUZsRjVVVjd2VmpVM1ZpL1dEQ0hLbGRhZExxNkVwd2FW?=
 =?utf-8?B?YW4yc2dCMENrQ0JRUEpjQXBXdVB1Q0hoZDJucmJPMVlOU1VDTHgzZEplRWpV?=
 =?utf-8?B?UnFqUURCSk53ZHVtOWRLU294VmR1T1NPeXl0NlZBSEdydGwrSjc1Z3RTT3pN?=
 =?utf-8?B?M0pCSDZyMWhLUGkvTnpvVXhCZXdtSDdsL2x2ZVozN050cnR1bWtZVFNtUDlV?=
 =?utf-8?B?OHdMSzVFeE5wRkxlL3UrTzZWOUdoSmJsRzFEN2w5VDJlQ1VTM3lLc3lyUVV3?=
 =?utf-8?B?NWlkNTZqQkcwQndLM3RRR1hpNzNocURzcG1zZmlHQ3EvM1FhWGkxUStaRThN?=
 =?utf-8?B?T0ErWlkzZUl3T09UUGk1RXdEcHpRYURuWXhHdjFNcEEyb2dXRENXWWlIUjk4?=
 =?utf-8?B?K0cxdWR0bzQwYWJyN2d0TTVRdS9hOHRaK1hBWWtPa0gzYU9sUDltVmZRU2JT?=
 =?utf-8?B?MnVIWDQxSWQwYWpZSkNRckFhNG1aSEpZWHk0YzQza0dOWXpKOUFpRnVCckli?=
 =?utf-8?B?dGp0eGlZbWRweTlEL3B0bXJzZzJIZnVaM2V3VTE1U2lzSDI0NHpDcXNWMlY4?=
 =?utf-8?B?Wi9Wd3VHL0FBNHlqSllhMFpWSE5LL0UxR25UN2lZdTJuV0R0cmFrWlRQWnhD?=
 =?utf-8?B?UTdhOVUrL1k4TGEyY0gwQlFuUm43ZFpPVW5ZWDV5dTlZUDN4citrRWNkbi91?=
 =?utf-8?B?UjFFQVpJK0MxYTNiTEJIZGVKa3dtaEt3MDZrV3dsT1dwbElhcFloS0NzUFFF?=
 =?utf-8?B?Zk12NHRVaStxd2c4dmlVMnI2T1NLYlYvazN1L01DbW9PemExT3JPVEo2dG94?=
 =?utf-8?B?bTkrYXpkdlB2V2ZRSDY0RUYyOGdRZHMyR0pUTjZXMHJ6UExORTBEV204TFJ0?=
 =?utf-8?B?cXUxWEJvUFM0NWU3U3R6WUtGYTQwdytBbmFhOUtnS0NnV09rRUtIS0l6RzVm?=
 =?utf-8?B?RGVzU21HQjgvQnVNR21JTFBqd1NWSXJESTJHbFIwNVI4d2Q4cGQ3cUlMUkdQ?=
 =?utf-8?B?QjZqOUJGM2pMWTA2ZWgwZ0lzM3htTDI4Tzh1ZW5TUHc5eWtFV3RYaFQySnZ4?=
 =?utf-8?B?UVBBdmNYNXN3SGw5RXprOU4vU2hsbGNHWTkwOHdpSCttNC9vUU40YlhOUGJV?=
 =?utf-8?B?TStyTi81TjdPUDZ0OGNyc1JldHg3WFVaZlNqUk4yTUVHZFVLVnBQbzdieUE4?=
 =?utf-8?B?TFFsdnU1a3FGRmQwZ0ljN2dxQkhzR2JWWmc0NzRUS2NCYXdMUXFHODdZUkZG?=
 =?utf-8?B?Snd0dEN6Zk1hRkE1Mmt3emtnOHQwR1Z0dmVYeHRRUktCS1Q3ajRNZC9xSkd2?=
 =?utf-8?B?eTBwY1hUYmE5K2xOOVRRT1ozMHhhVmxMY0hhWHV2d2FUOFdkQTIrVlNySXZ6?=
 =?utf-8?B?Vmc2QVNJRlRYNlpZUUM5eER1ZmxQVVVyT3lFL0h2R2pPRzBHMnlPeHBlZDMv?=
 =?utf-8?B?bUQwZUZCalA0M3lLczhVVW43enFPejR0ZU9QUTkydUZZbGZxZTF2UmxoWjZL?=
 =?utf-8?B?N1loSnd2QTliY090N1c1WFFFYnFKc2lIakxXbjRpM29MUmtzRHR2NFhTcWcw?=
 =?utf-8?B?ZGVoY0U5enA0WDRjeGFHQTZLVUFRPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MJuutulTOJHNNEkFO+dDBNuQP8/XbKX5V9zT/1eB1Qu/byvnc8bkj2HaaAfb6212VRwx0R/yBCf4FUclMtvEOOrEi/nJLT6IbdmyrhddeeBc/wb5gfDFgpHlHPVWuv1fsC7xn9LS5P538UkhHjVf3UYf7jmkQVXs+QO/Jw/a/+FArju0ZaAlL6SP9cV0tIxfo2elfvem4NG6Fyma8ouu46LYal8tACE+4PWI5V4s0IQ8RIkmfss9ExskJ8g8wGODr/oavZt7/vQRDXMx5cn3ee6HwQb3dQzefA/nuaTSIRzO9JD9HlQMTcStiBNA+J4pB/PbqfOWzNaW7eUIW0Il+q8LWgMk/xspOfwEMIuxIK/Y10LNsybe8N+cG5atcB4+xS10mECbae3iJ/5853gYA7xjSz5rMeD4oMhNVsnZXvqBdmW/WGHsgqxo9eWvslJxP3kUZaO/fw7Is77ZEBWiBVGznvFtHXoJ6eJrBfAyhOqGiAKMwbbFeLnd/cU1SMIs09LOekVD+h5ptpV8Og+IfmbYvKD1OExQ+9ljle0qDxivLsD71hdr3IAas9ozhklBG9rg0rmtWkHy5zlNtiGIhaGCFPgI2I/HUS/2suszY/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6074c2ea-5a33-4916-0666-08dce3f5a02c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 21:52:07.6010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGDyLawy4gLXlQRRfNy3gLvTxizDFzCKDjU+VEJZ8KWCA/pni6kTplxDgfp6mnYcubzQW7/NjsSp16/ffcytysUZDWOJaRfgxcVWo/62lPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6344
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_19,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410030155
X-Proofpoint-ORIG-GUID: sP2-RcFM0z7oowlsFVpvMwHGi_ClOwMU
X-Proofpoint-GUID: sP2-RcFM0z7oowlsFVpvMwHGi_ClOwMU

On Fri, Oct 04, 2024 at 02:25:07AM +0500, Mikhail Gavrilov wrote:
> On Thu, Oct 3, 2024 at 1:45 AM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > On Wed, Oct 2, 2024 at 10:56 PM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > > We can reliably repro it with CONFIG_DEBUG_VM_MAPLE_TREE, CONFIG_DEBUG_VM, and
> > > CONFIG_DEBUG_MAPLE_TREE set, if you set these you should see a report more
> > > quickly (let us know if you do).
> >
> > mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_VM_MAPLE_TREE'
> > # CONFIG_DEBUG_VM_MAPLE_TREE is not set
> > mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_VM'
> > CONFIG_DEBUG_VM_IRQSOFF=y
> > CONFIG_DEBUG_VM=y
> > # CONFIG_DEBUG_VM_MAPLE_TREE is not set
> > # CONFIG_DEBUG_VM_RB is not set
> > CONFIG_DEBUG_VM_PGFLAGS=y
> > CONFIG_DEBUG_VM_PGTABLE=y
> > mikhail@primary-ws ~/dmesg> cat .config | grep 'CONFIG_DEBUG_MAPLE_TREE'
> > # CONFIG_DEBUG_MAPLE_TREE is not set
> >
> > Fedora's kernel build uses only CONFIG_DEBUG_VM and it's enough for
> > reproducing this issue.
> > Anyway I enabled all three options. I'll try to live for a day without
> > steam launching. In a day I'll write whether it is reproducing without
> > steam or not.
>
> A day passed, and as expected, the problem did not occur until I launch Steam.
> But with suggested options the stacktrace looks different.
> Instead of "KASAN: slab-use-after-free in m_next+0x13b" I see this:
>
> [88841.586167] node00000000b4c54d84: data_end 9 != the last slot offset 8

Thanks, looking into the attached dmesg this looks to be identical to the
issue that Bert reported in the other thread.

The nature of it is that once the corruption happens 'weird stuff' will
happen after this, luckily this debug mode lets us pick up on the original
corruption.

Bert is somehow luckily is able to reproduce very repeatably, so we have
been able to get a lot more information, but it's taking time to truly
narrow it down.

Am working flat out to try to resolve the issue, we have before/after maple
trees and it seems like a certain operation is resulting in a corrupted
maple tree (duplicate 0x67ffffff entry).

It is proving very very stubborn to be able to reproduce locally even in a
controlled environment where the maple tree is manually set up, but am
continuing my efforts to try to do so as best I can! :)

Will respond here once we have a viable fix.

Thanks again for taking the time to report and to grab the debug maple
tree, it's very useful!

Cheers, Lorenzo

> [88841.586315] BUG at mas_validate_limits:7523 (1)
> [88841.586320] maple_tree(0000000067811125) flags 30F, height 3 root
> 0000000040e0c786
> [88841.586324] 0-ffffffffffffffff: node 000000009b462d47 depth 0 type
> 3 parent 00000000db18456d contents: 10000 11400000 1e000 1f000 1f000
> 75e15000 0 0 0 ffffffff00283000 | 09 09| 000000005518cec0 67FFFFFF
> 0000000085840a0a 79970FFF 00000000975349aa 79F50FFF 00000000afe6ddd8
> 7B140FFF 0000000083c903b1 7BB96FFF 00000000335e109c F605AFFF
> 000000007e7333d1 F6570FFF 00000000d8e9900e F6C92FFF 00000000250ada8a
> F76E1FFF 00000000e567baed
> [88841.586357]   0-67ffffff: node 000000005c64e204 depth 1 type 3
> parent 0000000069e1180e contents: 10000 0 0 0 0 0 0 0 0 0 | 05 00|
> 000000000cfac463 16FFFF 00000000f0522fec 400FFF 00000000cd8938b8
> 94FFFF 00000000d2bcb2e3 E9FFFF 00000000ed8d307e 173FFFF
> 0000000056285bf1 67FFFFFF 0000000000000000 0 0000000000000000 0
> 0000000000000000 0 0000000000000000
> [88841.586388]     0-16ffff: node 0000000037648f62 depth 2 type 1
> parent 00000000978387fd contents: 0000000000000000 FFFF
> 000000000bc2e123 10FFFF 0000000049345b43 11FFFF 000000008940e7cb
> 126FFF 000000007c2365c0 12FFFF 00000000cfc1c890 142FFF
> 00000000b64ae6ea 14FFFF 00000000f8f8f6c9 165FFF 000000008460c3ec
> 16FFFF 0000000000000000 0 0000000000000000 0 0000000000000000 0
> 0000000000000000 0 0000000000000000 0 0000000000000000 0
> 000000009d394510
> [88841.586413]       0-ffff: 0000000000000000
> [88841.586417]       10000-10ffff: 000000000bc2e123
> [88841.586420]       110000-11ffff: 0000000049345b43
> [88841.586424]       120000-126fff: 000000008940e7cb
> [88841.586428]       127000-12ffff: 000000007c2365c0
> [88841.586431]       130000-142fff: 00000000cfc1c890
> [88841.586435]       143000-14ffff: 00000000b64ae6ea
> [88841.586438]       150000-165fff: 00000000f8f8f6c9
> [88841.586442]       166000-16ffff: 000000008460c3ec
> [88841.586445]     170000-400fff: node 0000000030a5de34 depth 2 type 1
> parent 00000000161b9281 contents: 0000000090f8ff7b 171FFF
> 00000000a90cdf09 17FFFF 00000000ad657f59 190FFF 0000000026397ca7
> 19FFFF 000000003413c0f4 1B0FFF 000000000ca6dd7d 1BFFFF
> 00000000cf83b99b 1CEFFF 0000000096a06890 1CFFFF 00000000ed96cdbd
> 1E5FFF 00000000e6e9d2cb 1EFFFF 00000000bc54b9f4 1FFFFF
> 000000006e42b324 3DFFFF 00000000afd4728b 3FFFFF 0000000082572c0c
> 400FFF 0000000000000000 0 00000000e89e29fc
> [88841.586471]       170000-171fff: 0000000090f8ff7b
> [88841.586474]       172000-17ffff: 00000000a90cdf09
> [88841.586478]       180000-190fff: 00000000ad657f59
> [88841.586481]       191000-19ffff: 0000000026397ca7
> [88841.586485]       1a0000-1b0fff: 000000003413c0f4
> [88841.586511]       1b1000-1bffff: 000000000ca6dd7d
> [88841.586515]       1c0000-1cefff: 00000000cf83b99b
> [88841.586519]       1cf000-1cffff: 0000000096a06890
> [88841.586522]       1d0000-1e5fff: 00000000ed96cdbd
> [88841.586526]       1e6000-1effff: 00000000e6e9d2cb
> [88841.586529]       1f0000-1fffff: 00000000bc54b9f4
> [88841.586533]       200000-3dffff: 000000006e42b324
> [88841.586537]       3e0000-3fffff: 00000000afd4728b
> [88841.586540]       400000-400fff: 0000000082572c0c
> [88841.586544]     401000-94ffff: node 00000000f4ffb374 depth 2 type 1
> parent 000000005fb58d4e contents: 000000004eafabe6 403FFF
> 00000000104e2e73 404FFF 000000004dbe1ca9 406FFF 00000000ffb92c1b
> 407FFF 00000000cffd3517 409FFF 000000009ef45250 40FFFF
> 00000000373dd145 410FFF 00000000eaff67b3 50FFFF 000000002e632fe1
> 511FFF 000000001839285f 60FFFF 0000000043d54299 611FFF
> 00000000da2961ba 80FFFF 00000000155e68ba 8C9FFF 0000000010bfe63e
> 8CFFFF 00000000a4834cd3 94FFFF 000000000e628eae
> [88841.586569]       401000-403fff: 000000004eafabe6
> [88841.586572]       404000-404fff: 00000000104e2e73
> [88841.586576]       405000-406fff: 000000004dbe1ca9
> [88841.586579]       407000-407fff: 00000000ffb92c1b
> [88841.586583]       408000-409fff: 00000000cffd3517
> [88841.586586]       40a000-40ffff: 000000009ef45250
> [88841.586590]       410000-410fff: 00000000373dd145
> [88841.586594]       411000-50ffff: 00000000eaff67b3
> [88841.586597]       510000-511fff: 000000002e632fe1
> [88841.586601]       512000-60ffff: 000000001839285f
> [88841.586604]       610000-611fff: 0000000043d54299
> [88841.586608]       612000-80ffff: 00000000da2961ba
> [88841.586611]       810000-8c9fff: 00000000155e68ba
> [88841.586615]       8ca000-8cffff: 0000000010bfe63e
> [88841.586618]       8d0000-94ffff: 00000000a4834cd3
> ***
> [88841.592355] Pass: 3886705433 Run:3886705434
> [88841.592359] CPU: 22 UID: 1000 PID: 273842 Comm: rundll32.exe
> Tainted: G        W    L
> 6.11.0-rc6-13b-f8d112a4e657c65c888e6b8a8435ef61a66e4ab8+ #720
> [88841.592364] Tainted: [W]=WARN, [L]=SOFTLOCKUP
> [88841.592366] Hardware name: ASUS System Product Name/ROG STRIX
> B650E-I GAMING WIFI, BIOS 3040 09/12/2024
> [88841.592369] Call Trace:
> [88841.592372]  <TASK>
> [88841.592376]  dump_stack_lvl+0x84/0xd0
> [88841.592384]  mt_validate+0x2932/0x2980
> [88841.592397]  ? __pfx_mt_validate+0x10/0x10
> [88841.592408]  validate_mm+0xa5/0x310
> [88841.592414]  ? __pfx_validate_mm+0x10/0x10
> [88841.592427]  vms_complete_munmap_vmas+0x572/0x9b0
> [88841.592431]  ? __pfx_mas_prev+0x10/0x10
> [88841.592438]  mmap_region+0x10f9/0x24a0
> [88841.592447]  ? __pfx_mmap_region+0x10/0x10
> [88841.592450]  ? __pfx_mark_lock+0x10/0x10
> [88841.592459]  ? mark_lock+0xf5/0x16d0
> [88841.592474]  ? mm_get_unmapped_area_vmflags+0x48/0xc0
> [88841.592482]  ? security_mmap_addr+0x57/0x90
> [88841.592487]  ? __get_unmapped_area+0x191/0x2c0
> [88841.592492]  do_mmap+0x8cf/0xff0
> [88841.592500]  ? __pfx_do_mmap+0x10/0x10
> [88841.592503]  ? down_write_killable+0x19d/0x280
> [88841.592506]  ? __pfx_down_write_killable+0x10/0x10
> [88841.592513]  vm_mmap_pgoff+0x178/0x2f0
> [88841.592521]  ? __pfx_vm_mmap_pgoff+0x10/0x10
> [88841.592524]  ? lockdep_hardirqs_on+0x7c/0x100
> [88841.592528]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> [88841.592537]  __do_fast_syscall_32+0x86/0x110
> [88841.592540]  ? kfree+0x257/0x3a0
> [88841.592547]  ? audit_reset_context+0x8c5/0xee0
> [88841.592555]  ? lockdep_hardirqs_on_prepare+0x171/0x400
> [88841.592558]  ? __do_fast_syscall_32+0x92/0x110
> [88841.592561]  ? lockdep_hardirqs_on+0x7c/0x100
> [88841.592564]  ? __do_fast_syscall_32+0x92/0x110
> [88841.592571]  ? lockdep_hardirqs_on_prepare+0x171/0x400
> [88841.592574]  ? __do_fast_syscall_32+0x92/0x110
> [88841.592577]  ? lockdep_hardirqs_on+0x7c/0x100
> [88841.592580]  ? __do_fast_syscall_32+0x92/0x110
> [88841.592583]  ? audit_reset_context+0x8c5/0xee0
> [88841.592590]  ? lockdep_hardirqs_on_prepare+0x171/0x400
> [88841.592593]  ? __do_fast_syscall_32+0x92/0x110
> [88841.592596]  ? lockdep_hardirqs_on+0x7c/0x100
> [88841.592600]  ? rcu_is_watching+0x12/0xc0
> [88841.592603]  ? trace_irq_disable.constprop.0+0xce/0x110
> [88841.592609]  do_fast_syscall_32+0x32/0x80
> [88841.592612]  entry_SYSCALL_compat_after_hwframe+0x75/0x75
> [88841.592616] RIP: 0023:0xf7f3e5a9
> [88841.592632] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08
> 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 cd 0f
> 05 cd 80 <5d> 5a 59 c3 cc 90 90 90 2e 8d b4 26 00 00 00 00 8d b4 26 00
> 00 00
> [88841.592635] RSP: 002b:000000000050f450 EFLAGS: 00000256 ORIG_RAX:
> 00000000000000c0
> [88841.592639] RAX: ffffffffffffffda RBX: 0000000001b90000 RCX: 000000000001f000
> [88841.592641] RDX: 0000000000000000 RSI: 0000000000004032 RDI: 00000000ffffffff
> [88841.592644] RBP: 0000000000000000 R08: 000000000050f450 R09: 0000000000000000
> [88841.592646] R10: 0000000000000000 R11: 0000000000000256 R12: 0000000000000000
> [88841.592648] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [88841.592658]  </TASK>
> [88841.592668] 00000000b4c54d84[9] should not have entry 00000000f0273bd5
>
> Full kernel log attached here below as archive.
>
> --
> Best Regards,
> Mike Gavrilov.

