Return-Path: <linux-fsdevel+bounces-42601-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D27E6A449B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 19:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2395E880D4D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 18:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8F207E13;
	Tue, 25 Feb 2025 18:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J5YWQ2Kd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HqvhCuJr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61981D63C6;
	Tue, 25 Feb 2025 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740506556; cv=fail; b=Lm3lnqf2TZOsN3VhR8bDHGGiNG9FVbK64SfJsskoIbYp/CrwXJRsYD/t2J8gb01INFSyjUlqZk3pLgtHMccEsSfAPmWQWu7reFXLEZBp3u/B+8EE+vjpYyjge9klQhPBSTCUMgxK1wgpoW8MeUZT/acGVbFz0mnk5/4TIns6fIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740506556; c=relaxed/simple;
	bh=gn0N92qIjaHfp7vMvfF7YcAiFf9A2X7WnNPY1AEJUns=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VMQhiacH4+/Q0u1tR2lYj4veluS/ER7XwK4JmBkT+RHqtHpIQsN9o4DK92B6NRCTrbmWOCdTQax+EqXeqI06j7LPgXtnfbBFFtyTYvMwO7lEOGvAPDyMnc+H6cOlYhC2Wy3Oz44/jS+n8oQuyooP1aW6UUm46rOsKpX8lAlPQVg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J5YWQ2Kd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HqvhCuJr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHtc7b011227;
	Tue, 25 Feb 2025 18:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/U9Gd7JwKqSH/U8sJkkW1LbOIVwP1+4qwFRLFcDDKJ0=; b=
	J5YWQ2KdyV7B4egTyUG8WdKXtSSUcWQetUuFtTyR7M89in4r2Nd0LdW0qa1SLiRL
	LSTz9+IgcsTZN9NZ90m+xRv3TAvS/EiZw4Ld+TMUJp7m0XynIo3c8qOIwiMM3GtQ
	04dQjLmDJQcwO2SfmnRNnsABUSnsqiO4mLD/W8FZwZ+Uja0excDxs8/LUeg/yKEq
	dzYGzmr4rI7cIWELOx9xp1YMBtpncl2Z+qZiPGhUpznN/5D7zzqiaR41DmxpeI2R
	RJj/dwWho2+fZ44B6xioqbYrp7pVqjlxgKQAZQ9QaTv1040ig4vvCbJ/iH1W+cEs
	8xllDYJDOM2oFUgw1lA60g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y74t5xsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:02:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PHCfDG010032;
	Tue, 25 Feb 2025 18:02:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y519b8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 18:02:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbpY/FQxkHD9ufgfBZ+xW+A+nb9/pvYrcfhAXRpBcIeeYt4bgYT4FTbwW6tsduG2/aZdHekfklmBaZeWSXC6UlZdWLurufIR4IKlkuBuLjO+OWwGYClZtKt1j1Ps8BdKg1rLdJIXXkVhhpa8u+uWzhuV2Ml5vf5CJu6Ro+OLXnUdLT8sE35a02eVvHjh6GigKH5ngGJ6JUcBJ3TD9ztgNdfwO4UZJExQ73acvPHyyuXT01DlGBzHA9V5iVprCE/2J3MqP1Kth7mYmrJKdM7O9IfNwRInBjMd2m6jZ8KJiRkHEbrHPu6RjqGzTOho8r6Gq6E1dqRNrrysX9S1fxWrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/U9Gd7JwKqSH/U8sJkkW1LbOIVwP1+4qwFRLFcDDKJ0=;
 b=lfpnjKb1B2oHN6IqtXoNCny90c+m5z5XNNsGamFBQtf/GMhoe9+/QI9w1IQvzJhMbZZ/qw0v8+1/DT6AML0KY8enk9rhjTockCcsUNvOsR2+fI36jlbxLe0xwUz87j73t3IK5Vx53mjLPS+Op4bN8P9ihjG2jVM7SeruDWql6Fa8a2gmH8BStyZzhHjrFhd6KhFlzuWYwtQ8cLWdWZ0jIKAOl8rqWEQ2aR3b/pW6Xi6Q7VCMALTYGrW+9jo4xaZaF6lR7Q2B9nO9P3j0H76k8FZtxAD7vynGpAYDGsiDzx2auuyl6m7gemxVfYpPAHMY9hY9P9iK3Wxe7/Gt+3qT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/U9Gd7JwKqSH/U8sJkkW1LbOIVwP1+4qwFRLFcDDKJ0=;
 b=HqvhCuJrRCIMT5jsIJO4lK/y67bSUMyv5MAEqbBu18qmZOUQn2V+HgirdVAxhSd/vs8Hn+sl8dalaG01fjkQADf/+XwhUsDZ/UVZLPCHNvQm/O7+IZBhOVojSnwd64zyoJPgfQTnw5gAucdySo1PXbPnYrHeXrt9klZCV89T9oE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5652.namprd10.prod.outlook.com (2603:10b6:303:135::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 18:02:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 18:02:17 +0000
Message-ID: <306b49d9-f2a9-410d-b6df-ae0ba17eee7f@oracle.com>
Date: Tue, 25 Feb 2025 18:02:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] xfs: Reflink CoW-based atomic write support
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
 <20250213135619.1148432-7-john.g.garry@oracle.com>
 <20250224203228.GI21808@frogsfrogsfrogs>
 <e1aa10da-046b-48a8-bb49-f494a5a2b383@oracle.com>
 <20250225173750.GE6242@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250225173750.GE6242@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0ac0f3-1e33-4602-c5ac-08dd55c68a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emxrQm9RYTBBZjJkVEh1VlI1ZnlqaDZ3NmQrWC9VdHRWcWFaZFJDU09Ha0ph?=
 =?utf-8?B?WVdKMllFaHc0bHJwWE80Z2pwc3l6SjdFMXFKVDQveExRc2tFWm5DWlVDWUdN?=
 =?utf-8?B?My9ObXFBcUFBOXpwTkRWTEpySjBvNEtkdmYvN3lUOTJZSXUrakRaZDIyZWJK?=
 =?utf-8?B?Ny83d1VFSnVTVkpkNFNvbGM0UldrTWJmMzNiUUszc1VJR01PVEJ1KzZtZ2wv?=
 =?utf-8?B?TGdvRWdEMnowdVl5eG1EVitiMEZkL0xycldWNnlMSFpKMEF1OFk0VUNwOXRG?=
 =?utf-8?B?c1BjWk0zeDJTUmtOeU9jUW9tc2J4KzN6VUtlU2JJa2g2RG9reVBSNVIyakIy?=
 =?utf-8?B?VDByOUU2NFgwRGtmdG9jSy95WXJsQTJYTG4raFFsWWRCQTNqbTNyVXYxV2ZW?=
 =?utf-8?B?aGEzZkdndWZSRFRqdmtaLytiRmM4V2hub0w5WXBNNkxyTlVnSXpZNzNSaHhP?=
 =?utf-8?B?YjkvM2tKTXNEMUFON1k2aHlJMHc5N3hQNlBqR3ZIZUo5anp0Nnp0cW5zMzkz?=
 =?utf-8?B?clBEVEpLVUZSNmYvanRGaGt1Y3hWMnN1YnRJdyt0b3RxTURHdzExbWx5TFY2?=
 =?utf-8?B?YlY1UkpnTDBmNmNOR3RDZ1JBampzaXI0SnFnaFRLTDFFVG13SG5JbXF4VHRF?=
 =?utf-8?B?dXNxNzgrZlBqdC9sSVI5TzhxbDFsNXJLOEJiZ016dVI4cjZpK3pqeUQvTDNy?=
 =?utf-8?B?cXJXbk0yTFhjT1hLYnV3dndERUZIVTVDaUdTMG1vV01meStwT0hsMFUrckp3?=
 =?utf-8?B?WUFBeDd6QTAycUZIa0t1Ni81ZTBoMjVjWFRyQ1VSbXJyaTlLbEhOZkZrcWsv?=
 =?utf-8?B?bm0wOFpnNjJZVlJTaUttT3J1V3FRcG9VUG5rKzJ5WlJMTzZQbjdCZ3AreXAy?=
 =?utf-8?B?ZHB5SjhnbWFIYnpvS0VFTGhRbjMxKzlvckRuNGhlSTlsWUJISnhnMGtOWWJN?=
 =?utf-8?B?MXBuS2JxbFVucnBRMjRqVU82aUlobkxDSWUyYmtDUHFLRG9jMTlOVnRCc1hD?=
 =?utf-8?B?WFN3cWxralFZSEZNVFpITzgvZndBSGxsYm5hUmpSN1FXK1JxVks3Sm9OQ3Jp?=
 =?utf-8?B?NTFxT0piS0c1Z1NLTTZES1EyNWZQTGpYMWdzQ0NROS9YVmFPMVhlWlRvaVhQ?=
 =?utf-8?B?cUc5Z2NodWhMaEZxalorZWxDNlR5RjlDNkpkRmZGQ1ZSR3IyQ3VaYVB5Tjdj?=
 =?utf-8?B?eUJOZUlkS0dwcUtqNEd6VlZ4Z3lQMllzSjVQT3dNcGVBbThNQXRqcmRsck1r?=
 =?utf-8?B?U2RpLzg2cjBCZ3FvSUpNSlVIeUVtVGpTV3F1UGttWnY0Z0hRK29LZnFCWUN0?=
 =?utf-8?B?eEZxeHR3cFlLSlg3M0tqaWluL3UrL1VFaW9aNkl3bkZ0ejV4QjlxQWk5eld6?=
 =?utf-8?B?TUROci9INWZNTTlydFhjcjdaR1NPdmZlRllKTHlpRmM3d3BOcVpSWVF3UlAv?=
 =?utf-8?B?TS9XN3pIMUpPQnV2bFJoOVVIR1lpczJ4T1RWck5MUGd1Y3lUTlk3ZEhhZFRx?=
 =?utf-8?B?U3cvUUhSTWhkNC9uQ2RpajJYTUxJekNLZlIwK0VldENCeml1cW5kRTJOcTBi?=
 =?utf-8?B?OUlwbVVtejRHWFpHaHlYTktJeWlpN3FkYkRuQitKamJZNXRLRDRHWUNCRjB5?=
 =?utf-8?B?WENwbEJ1NEZXdkt3K1cwNUxvYVhyL2xnNnljeEFEZ2JyaHZGelZXaFZWeUpW?=
 =?utf-8?B?clJ2T1I2ZGNPTTIyNFBoM3JFTFNiZkJBTG5Vc2xPMmFUcFpUamNnVUlYdmNX?=
 =?utf-8?B?YXU0L1FwQ3lOQVZucUxUcEVRYytreE5GRkdIZnREVWFqSTkvUTc2cENMeU0w?=
 =?utf-8?B?ajRJWmtJK2dMb1N4bHlYaDdLMW1ORDJBaEpjUURHNkpscjA2SkZrR1FxUkho?=
 =?utf-8?Q?TW25QRzCPUyw9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1pvbFV3SmE5MUlWSGp1NmpNd2ZTSFE4WTBKTy9salFsc1Q0ZzhCYUR5S3Q0?=
 =?utf-8?B?Y052cmVubzZ2eXhCZi8rSGRJYmVqejFPWWlIV05saWYrN0lyOTJudUdSc2ZI?=
 =?utf-8?B?WEZ0R0NlTWJvT3h5cjhhOTIxVVQwc0tvS0hBTVFEbXdzM1loRDhBU1dlaTZi?=
 =?utf-8?B?bmFBRlhmRUZkK0p2d2dUMGIvT1FMNUZkdVVrcXBDdStoQXBiaGdVUmRFVE5Q?=
 =?utf-8?B?Rldkdzd6Q0xVMUhQQmpmdmZYSzRhanpEbE0zSkhPMWdwSjJCU1RDYkxoK1hB?=
 =?utf-8?B?U0NQeC9oOXJGVG9NVUV0UUJscnR2Y1dnK1F1cWZKUnVndkZVL1YwK0xGU3Jk?=
 =?utf-8?B?c3pPZWJvQnl3ZjFVTGZaNitDdVp5RElxS2Iwd2orYWxTN2tYM04zRDFWcER0?=
 =?utf-8?B?Z0Rza2psMmlzOFRMWHR1Q2x0Z0Nla2JWWXB0T1hhV1M1Tm1ZeDNUTmxjcU5V?=
 =?utf-8?B?UjZMZmlQYTlFMTM3STdURWtrTDVueXF0QkVqRzdXYUIvNmt0dmJvZ3pONzY1?=
 =?utf-8?B?WitHYU5WTFg0dlludHlpVmx5VHBublhGZXNDUFg1cTgrYUhpRXhrcVNNS1VP?=
 =?utf-8?B?WUtKZm1yT3lFeU9nRFpxRkxYUHFCd24wUXhVOFJlQy9idFJDcDZTNXBLbml3?=
 =?utf-8?B?U041V3V5SjlQY3V3ZzBNQUh3T1gvWE10czM5cGZOdEZSWmZ5TFRCeVVQc0FS?=
 =?utf-8?B?aUJsZFhCZkRLNko4Nk1PWVlxWFE3UXgva1p1T3czV24zaUFIalhrekZ1Q1NS?=
 =?utf-8?B?S1FtZExKQnlEdnpzWHVVTE5wWFpEVk9QRHNRTVRpZERsckM0VjdrVXEyRnFG?=
 =?utf-8?B?ZFY5VUV0aExSbzFzRWQ3RjJMY3pObmZ0MnUxT2lGVkMyVzVBUGtGK1ZLd08v?=
 =?utf-8?B?anlRWlk3ZzR0VFpVa1RUT096WGxqcy9welB1OG05cmwyTzZnSmZRdnk1OWoz?=
 =?utf-8?B?Q2F4ZEZuSVREMVI3V0d5KzhKT2NjQ3Q2SVptU2x3U1Q1a2FuNU1uRGo1dldQ?=
 =?utf-8?B?QzFTV01YMXN1K0VHL0pHSi93bGZUMUNnYXpVQ3lXLzlQeXJvcWRicDhyb2gz?=
 =?utf-8?B?cFYwekU3aEFCOGhWN3pjMFY2a0R1YkkvSmtVQXhXWXpxZHFJNVJ3WXBxSUY2?=
 =?utf-8?B?QzNZcFRiV1BZZTI3cVAyT2FFemtOdUhvZUVmSzc3UUZHazNudW9jS2JuZlBm?=
 =?utf-8?B?a3N3dVpuSjFSS1ZLTURZMW5SUThIWk1JQXl3bHBXenh0MHU2QktqcTdsbUdV?=
 =?utf-8?B?Vlp1VmZ6eUYrL0FySW1aeWw4ZDhCdEp3V1hiU0VheUs5OXhTT2hqL2UzRk93?=
 =?utf-8?B?MXRJWTI4dVE4SkJDNVJRSC9xUUJtS1M4UStTTzN3MzlTVXJkb3pjdTZ2cFR6?=
 =?utf-8?B?L3hKTmRCazFqc3RFVWxhQUlYNk9qVmhnVmo5aTJZVlNwdXlvUkllZ0x0VVZD?=
 =?utf-8?B?RkFMVWlBNWlWWEVDelFOYXVrY0Z1NWM5Tk9LUm5CNlBDNVNyZm54OTF4Z25r?=
 =?utf-8?B?amV1TnZBL2xtNDhIZmlENWFYS3gwTHhXcG91dk5ZeGxTWDI0V1BzNk1wK1FJ?=
 =?utf-8?B?QmZMN2pIRUxIODZaSW13THV1d2JVNGxKczJXSFdtaGt5bjFxSGdyV1FrcDhJ?=
 =?utf-8?B?ejNWaGt4NWhZZ3dBNnh2NjE0UnNaYXUxN0kranBaUHFBV1BrQzlEZEdiRkZj?=
 =?utf-8?B?ZVV6VGViRDJnVmRsMW5uV2V0bkVvWXMwUW9KQlR3TE02STlCUWkreFEyYnlC?=
 =?utf-8?B?bFNJRVRpekhFZmRmNWhRY2Q4ZCtrU3FZSUxxN3F1Tk9RaWZZRkppSkhSaUFl?=
 =?utf-8?B?RWp6WHhEWGJ4YzBCb2Q2Z0Q3eGE2MFluVTNWNFQ3a2RwYXZoRFdlTGN5QU15?=
 =?utf-8?B?Tk94NklRU21nMGVjL1JFQXRVazJqZXllNnhseGh2Yzk5OUc1S1cyTkFOZHJ2?=
 =?utf-8?B?M24vdzVkRTIwcitRTU0yRzFLOEl6TTN1NE5XVEFmSnFJTi84THFpRWlhcElB?=
 =?utf-8?B?WFJaS0NET2lBQTJXT3Zya2NlblJEVkpmKzFFSnlidUY5MDBvR3h3UXkvdERF?=
 =?utf-8?B?Qy9UVGhyOE85VTNNVU5HSzVIVkJpY3JNYXRvaVpxSkdNVlFrdGxKWmxzaTQ2?=
 =?utf-8?Q?zmCjQW9xACe3kipCsPgPhY6XU?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gr2I3nj6CrsA6CGt8fDL3baGCJyT+1x6oXLSEvL0xH5KdJapeWbnYoawBLVHSoZv93/Ga2Ua0hRWMs2V2xzsPNxsqNlamM2iQ8YlaoKnJaSJhT1LhFnNT/8ffLlKXo8WCiiWMdkek/Nidx5g/MNK682UzZv9HZdhefJh5acByTZCZlGdNMnlNve8xX37CcBYnq6nsKURif9ogK973s+It/Bnok/rJhFGHOKnHZrhw88epMns3ja0Yciu9Fo/FgTiQ+eP4hG3Ejzte/XSbhdtrCL2JfyAV9d5Knrm2uAPol51iDBx5R67Ocw3lA4IEerQsmWv/CYrb9jm5udxVU7wv+38Q2Y7dVqDf9VBClONbL2vkz9fIMFaO48ZpKIGLJvFB56epbIG2yEY3Rq9u/oDMUutgYSyd0NsOtWtpFfnflKsm20iU4AOCJL7sD6pEloeh3/RlgaxvtlNK4C6uGIONVkeEb4YCOPrmytpFytO0orcHSqidWpVBtHAQXWjKY/pFPoqkKmhZ7NiV+RZ+9L05X811u3dhnjcItIk+P61QfOJTf2sfQqgEORKAIyyJ0NRzq7MDUou3ZqNmnECFMYK5QJeiOOodNsIRoMOGhdqrKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0ac0f3-1e33-4602-c5ac-08dd55c68a56
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 18:02:17.2527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JyTUl95O8w7v3Nx6I2aKM/OpMOmsErj6sV0CeRsRzGVapssgKf1xMPBnqQZrA6QOj1IJbUnZHCu707qZlz3zKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502250113
X-Proofpoint-GUID: iCGQy1lJ8jXThWq8zix4v6LbNweemsb8
X-Proofpoint-ORIG-GUID: iCGQy1lJ8jXThWq8zix4v6LbNweemsb8

On 25/02/2025 17:37, Darrick J. Wong wrote:
> On Tue, Feb 25, 2025 at 10:58:56AM +0000, John Garry wrote:
>> On 24/02/2025 20:32, Darrick J. Wong wrote:
>>> On Thu, Feb 13, 2025 at 01:56:14PM +0000, John Garry wrote:
>>>> For CoW-based atomic write support, always allocate a cow hole in
>>>> xfs_reflink_allocate_cow() to write the new data.
>>>>
>>>> The semantics is that if @atomic is set, we will be passed a CoW fork
>>>> extent mapping for no error returned.
>>>>
>>>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>>>> ---
>>>>    fs/xfs/xfs_iomap.c   |  2 +-
>>>>    fs/xfs/xfs_reflink.c | 12 +++++++-----
>>>>    fs/xfs/xfs_reflink.h |  2 +-
>>>>    3 files changed, 9 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
>>>> index d61460309a78..ab79f0080288 100644
>>>> --- a/fs/xfs/xfs_iomap.c
>>>> +++ b/fs/xfs/xfs_iomap.c
>>>> @@ -865,7 +865,7 @@ xfs_direct_write_iomap_begin(
>>>>    		/* may drop and re-acquire the ilock */
>>>>    		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
>>>>    				&lockmode,
>>>> -				(flags & IOMAP_DIRECT) || IS_DAX(inode));
>>>> +				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
>>>
>>> Now I'm /really/ think it's time for some reflink allocation flags,
>>> because the function signature now involves two booleans...
>>
>> ok, but the @convert_now arg is passed to other functions from
>> xfs_reflink_allocate_cow() - so would you prefer to create a bool
>> @convert_now inside xfs_reflink_allocate_cow() and pass that bool as before?
>> Or pass the flags all the way down to end users of @convert_now?
>>
>>>
>>>>    		if (error)
>>>>    			goto out_unlock;
>>>>    		if (shared)
>>>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>>>> index 8428f7b26ee6..3dab3ba900a3 100644
>>>> --- a/fs/xfs/xfs_reflink.c
>>>> +++ b/fs/xfs/xfs_reflink.c
>>>> @@ -435,7 +435,8 @@ xfs_reflink_fill_cow_hole(
>>>>    	struct xfs_bmbt_irec	*cmap,
>>>>    	bool			*shared,
>>>>    	uint			*lockmode,
>>>> -	bool			convert_now)
>>>> +	bool			convert_now,
>>>> +	bool			atomic)
>>>
>>> ...but this can come later.
>>
>> Do you mean that this would just be a new flag to set?
> 
> Sorry, I meant that the double booleans -> flags conversion could be a
> cleanup patch at the end of the series.  But first we'd have to figure
> out where we want the flags boundaries to be -- do we just pass the
> IOMAP_{DIRECT,DAX,ATOMIC_*} flags directly to the reflink code and let
> it figure out what to do? 

We have the odd case of @convert_now being set from IS_DAX(inode) in 
xfs_direct_write_iomap_begin() -> xfs_reflink_allocate_cow(), so that 
thwarts the idea of passing the IOMAP flags directly. BTW, it may be 
possible to clear up that IS_DAX() usage - I'm not sure, so I'll check 
again.

> Or do we make the xfs_iomap.c code translate
> that into XFS_REFLINK_ALLOC_* flags?

That is what I was thinking of doing. But, as mentioned, it needs to be 
decided if we pass XFS_REFLINK_ALLOC_* to callees of 
xfs_reflink_allocate_cow(). I'm thinking 'no', as it will only create churn.

> 
> Either way, that is not something that needs to be done in this patch.

Sure


Thanks,
John

