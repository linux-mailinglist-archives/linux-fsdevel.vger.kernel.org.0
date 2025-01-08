Return-Path: <linux-fsdevel+bounces-38647-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CD5A057AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E1753A5F5A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 10:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34021F7589;
	Wed,  8 Jan 2025 10:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C0A60X3A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fZfkMFk3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA391EE7D5;
	Wed,  8 Jan 2025 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330971; cv=fail; b=SWsz57sEf4MLWRtws7lHJkIrUOY9fTbVwb+QJNbv5EM7ULZ5ydWz6suHY13k0dWMU4AtjvDD5tkBW7aSWKI+iMTFzGJRBUZlkG0WOOqCL0bzTsZ5/CjQlpb+AecGdH72qpN7St4t/xnidRfRfVWw2hkcR+LW8/hqTTqjoaCdCRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330971; c=relaxed/simple;
	bh=BGaMt/TekTigVbzD+p0YNpKj0JrodpsiHEN2z2U6qUw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sBHLPcrR0Hvz/etEHPRkvj2+mNBudL+/lGIhabDh8bj8y3+JsJaSdBJ2un4kf4ZSznW89Lqtrpk9orSEipKUtiuSV+bGc/JusPBTqkb52j1z9hCntv3q/Wx537ATuRLlZkTExkFoNgAizE+4KfYwoDEmGI4gw8XORgJYiuAw0Sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C0A60X3A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fZfkMFk3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081uWwL023407;
	Wed, 8 Jan 2025 10:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2AxvCZ+aFClL9Z+PE1PKL0tKIhmUcZ0KKyLFZ7Xrm1Q=; b=
	C0A60X3A3eTjmLfJGiKEchsWsBkwLPUf9UNzBz79kRmW3Un1HFmQk5INaUuLmJ61
	D6+x1bMU7pBSqLsitxj7uGE0NZ2F7/2Qgp6oVgJjTrDl0WCV6UyJ6yuHrL3nvKho
	+MqZtrddV3/7RAX8oIN8TU24OtuOCHPP0Dlld1yK0lLwh7XqgLvwCz57ZxAl3d1U
	WfXRYL01x/FTDiEvTXlzh0uf60KCDvPczQUrqnP6yZeVSiJlU4kw6vV37emO9DAv
	V5jDH8T3glpW/TfxhfUt+DioitsiyqTm3LCk42ei/3SD+hpo5VGvgbV60g4QkzQV
	VT6mlcrC9U0caM2GYkBmNA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc6pyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:09:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5088i0Gi022619;
	Wed, 8 Jan 2025 10:09:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9jy2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:09:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hPGmiJMQDa41PoB3LLSS5vp7FepRDE4IEWdnfp5Yq5VdWDMZnoG/f9at+jWEhyEBarT//9dttR52/2OMkTdGO6bT94CkM/V0cq7KHc20ASjgkrqcgZdEXbojjzQjTLbYugehKqFgNlE/nVGqXM8pr5n18tdPlUZQg5qw/P1BL5djO2xVYF/Q5Lfnyb6BgkiCZ/Q40gLU0wEb6zBFi5uoa4JrbLgdS6XXKcor7Nt5fbmqpvF1u5H9XGa6SQl/sLnpwDZosWtKAT+XUC7NnCn5Q6VWn1A2ME1XDdew6asAkGi1AfBCxHHCdA+44G4Kilewk1RGHNQBB/1EdbV4Kcb5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AxvCZ+aFClL9Z+PE1PKL0tKIhmUcZ0KKyLFZ7Xrm1Q=;
 b=yqAx+REBghNqfwwME400iQyIn91dENFd/YrrKbrAavJQrNi97fwQWk+FZT3A6mJsQ+C1uSkgZYs/qnow1m9mZi1rr1xqB7RcRWuD83la60p7f3071WzA2xACqziOGHIw9uO0btbqOhRcgibhn8I61nAUCoAVwWT3Qv09V04D2j6ahg4yKC0EIH9klWGv79eSR8AlfUj2p+tZVh8FL1JUHyM5FdEMD4POhRZH8NQTbSHyBLiXPSH3tQNzvErTlqZhfNH1rF5BEgDrj5v1DuFzzEr497FdhP+kQ7qQd+WVa0q1/iQMsrWYNwLZFMum3uNa3MKtEc0DnJxpSy/NCVKL1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AxvCZ+aFClL9Z+PE1PKL0tKIhmUcZ0KKyLFZ7Xrm1Q=;
 b=fZfkMFk3UcgbETxoKBSFftRFi+cprW6PbS7zmleCiSRGMGJQAkf2Zmhgsc+VwxYsqbZ1R0RJ1qSWKLEdhgjARx61jlBEcCWHxCGe/Xe4K09eAbPjqH3Ebgw6EV5PvYgcXnb0e6+AvFJdPy/P17d6smGxBQ+VxRC2MyvtAlewzGY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8128.namprd10.prod.outlook.com (2603:10b6:8:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 10:09:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:09:11 +0000
Message-ID: <8d8039f4-77ab-47f5-bf55-f2b54ff150f8@oracle.com>
Date: Wed, 8 Jan 2025 10:09:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] fs: add STATX_DIO_READ_ALIGN
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250108085549.1296733-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0010.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::7) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 452685ef-b93d-4e49-a6f4-08dd2fcc7f48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXF3WGZqaVROem5zMzZWK29BdWFNa1BQNWZyRjJtT3pHL3NNcHhKclkvVU1L?=
 =?utf-8?B?N1ltQnd5RG5WK2RHeXFpSnpNZjNWeWFRenF0dDRNWHM1QS9WOTNpV3ovbE9h?=
 =?utf-8?B?b2RMVlM5L0JPLzRPeHkrT0cza3ZpdFBQVFVsb0NMODVJdW93SWVaNENMeGpp?=
 =?utf-8?B?UkF2b0paVHc2bVRjOFhobUZIblRWRTNBMk1ZOWdOYmhuUE1hUklvM0JyZ3Vy?=
 =?utf-8?B?bFd4UXM5VkdBSlc4Z1oxcURaUXBvdkN0Wlh2akJ5cjVEcUtuamZjcGhadTgz?=
 =?utf-8?B?YnVHZEU5bENZU0RDQnE0UVZ1Y0ExOUlreE0rZGV2UmtSUWVSTk1IMGoxbE5J?=
 =?utf-8?B?QVd6WkFtZ0hIaVdaTVRpNnBId29wQjdlSXlEV0xrVnNIYzlvUFFlUzBweTVP?=
 =?utf-8?B?OUJmdFJtc21tRithSFZtRVZnNVZiSjZVcG8rdktvNC84dk5UOWl5eG9nV01v?=
 =?utf-8?B?K0hIdmhqL2wxTmkrRmQxdWFuMnhzMXZFK3Njei9XejdsVGNCNFN3ckZ4RW5V?=
 =?utf-8?B?WG5ZMURjaXJLTm4wSjhlOXRUcG03MEdaZTNrazZlc0JxNXpFa3NQTGdOTDZX?=
 =?utf-8?B?cXpuM1lzUVhZQWtsWW1mc2kzUkRuajZDekp5aldVWHFZWkZ5R3liL2N3WDRj?=
 =?utf-8?B?UlFmaWcrbXo0em1VdmZoODZyUEdhR2VDQmJCVXY1TVdtMGZ1bDdTQ0UrVTQ5?=
 =?utf-8?B?dVdZcm9CT2QrWkkzclFFdk9DekNpY3BLV2JmQzRUN0QvdWx6NmhKYkE1aitl?=
 =?utf-8?B?VTlqcjk4QXV6ZWxzNlJpUk9SSzZQajhOUnBVc1RCQkRVUlMrWFBNSG5Yb2Y0?=
 =?utf-8?B?QkhJSm9yNy83ZG83bTJERWxVSHNHR0xZbzZkYm5haVY3cFI3MWx0bW5hRkw5?=
 =?utf-8?B?TC9ROE1Rck9RaFg0b3g4cXF6NG53Nk54cmZzYzlVKy96RXB1a0dNekxCUUc3?=
 =?utf-8?B?aUg0T1B1NTZiWHZacTFJWWsrNWI0THJtNlMxVitXcC84WnFBcEpWa1VLeWNt?=
 =?utf-8?B?ZTB0Q3kxNTZZekJUTVZCZjRZNDJqRVduUVU2VjVtQkdGeEFMWnlLVmtpdSs3?=
 =?utf-8?B?NGRVWXRhTVI4dFdYTXlnbXhQcmJkM0piVzkxL3cveVowY0dETlgrczdyS1lY?=
 =?utf-8?B?bTRFV1dGOW8wVGl6d1I3M3JNckxhcUdTSk5ZQWxCY1laajdyOUQ0ZHJmcWQ4?=
 =?utf-8?B?OGtlS1A2bkkraTRBbVhDR09TRkNMc0ViVVVJNGl0bWZCQ3RtamtXaWhPaTZh?=
 =?utf-8?B?RW1UYTBtbDN5NGFHdWl2K0kvMXBrR1EzL0dPcnFFKzNoV0QvQ0xxYkJZcjNu?=
 =?utf-8?B?c1dzSm5wTnh4MFBsL0RnKzQxU3lvNFp2c0E3SndpcXpDTzcyQWxXem05RDJT?=
 =?utf-8?B?YWN6V2VuMllETkd6UXVPSmJxeHNjVkxEYzhaeHB0Q2N5RjBMbHhKTldncHU1?=
 =?utf-8?B?Tm0yczVhb2FDcjJWRUdZblN5dG9UM2lWS3lFYjE2bXduK2V5NEd0a2FOVjZG?=
 =?utf-8?B?QVpJSmxRTGhPTUtaVERxNVZoazFETGxVM0RmZ0VsM0NnczM3WXBWOERrM296?=
 =?utf-8?B?ZDA1TExZZ0d0cXhMcHdITy9nTUw1TUhxYTRDdnYwc29SejlLVVFlS1ltZjk2?=
 =?utf-8?B?UngwdGNsLzNzdm9NMlpVaTFzbnRSU0UvV1h3L2gyRk9TUUxGUzlYRWdGRDU0?=
 =?utf-8?B?dnlpMVFYQTlqQ1IwQkxobWNuTmtGK0hab3Erc2hoM0xlN3haU1JSai9JTmRJ?=
 =?utf-8?B?cEpxTDArSUZVdTNDb1hEUUdqNS9FUThZRUtRQkUxZzkyRURmUjFNQ0VZeGZI?=
 =?utf-8?B?RHdhYW5qSDM0cHgvSmRFL09nK2VCZzlGSjUxdnhiZmlqcGZUWTNGd0tGREV5?=
 =?utf-8?Q?McsFrdv14QCtY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXdRQ1ZVejErRnkvNGlkdWY4K3R6dVhQQnBYdmsxcFMxUExUanFTOGw2WFEy?=
 =?utf-8?B?RnBBQVhsck5KVjk4RmkxSzVZWVV3ZTRyV0w2T2FFWHlCdSsrZXlLY2F2b2NC?=
 =?utf-8?B?ZVlNT3d6VVFmTXhOTWJZOUxTVkprcUNwK0IrRkdYSU5oTEZUMGZTdDZhM0w2?=
 =?utf-8?B?SUNDWDF2UGdDeWlBa1UxTGp0SG1ldC83aFNBMGZCbE5QenF0RFJ1QXZCZFh4?=
 =?utf-8?B?a3JJL20zQys1SjRUMWxLWDRzdVd2dUZtTGoyTnZBamE3QUhlVDlJVEp6OW9J?=
 =?utf-8?B?UFd1U3ovdkFDMTkrZmphNWtrazJCMG9LNVUwM2FnNG11S3JtODlNeWZCd3NW?=
 =?utf-8?B?VGRXVkJ0NFM0bUNjbDZrSzFsTlZ0NExlb3ZmTFc5dnNSUDc5VTF6UExtU2x4?=
 =?utf-8?B?NEg4UVIrMlYraCtWUXV0UE9ZUGk2cm1WRVNqeHNTcVVYYnp3NzJpU0NPQXVq?=
 =?utf-8?B?bDdHcFJLd2tnV3RsM0VZdFdaSFZIYmlOWUJBS0RLUnB4MjhNVkVtOTZtL1hx?=
 =?utf-8?B?R0J0QzRyK0YyRUtYSXNXY0Vma2k1VGZhRTcvYzJPSVBxVmFQc2JKbVZJMEtz?=
 =?utf-8?B?QWttdklmNVQyMWdmZ2JyaHpnYjdjajFiOFZqZFpuUXhZNEZ3WEl4NUpEUktR?=
 =?utf-8?B?bGZmOXNJdm0xRUtMYmYvTXVRRDcrSWNCNktzL2tWR2pMcjZjdWdBb1FyVUt0?=
 =?utf-8?B?Vm11cG1DRi8xM2RUYWFwd0FENFNoU2N1R0g3cjYrYkNoK2FUNjlmSS9kOU9u?=
 =?utf-8?B?dDNtYmVUaHZGRFJuUThEK2lsTTJ2ZlRLMXh3aENzZ1l5SFVWdUxWWGZTNUpF?=
 =?utf-8?B?TUlYandad05xMzNpTE11Uy9RdnJYZVpnNjh3eDlpbGh5dGtvbnVKcEJvNUhr?=
 =?utf-8?B?M2VnZjBkWEkwL1hJUGhMV0U0YVl2Y3M5QU1HbTVoc1QrSVBLSEo2WDBLZ3JC?=
 =?utf-8?B?MzVEeU9MMlRIR25tZ2Y1VjE5K3d6MysrOUY2NlBHdUh4MjdyaFQvRTRLTWFo?=
 =?utf-8?B?b3E1eUpENGRnSmRyODFiQXNOTHpZOUpUYllrT3RyWndEby9PN3dFVkMrQ2pU?=
 =?utf-8?B?UFBUQTY5VjhkMUVWRFlnSlpVd3J4YVI4SlBaQkN4SXFVNG5QZDhKbGIrUG02?=
 =?utf-8?B?Z08ycXN5Njc2R3B0eitlbjd3THBtWmZpSjdDRzB2RXJIWHNRYTFPYWJTaVR1?=
 =?utf-8?B?MUhwRmVCbVpxTjZzQ053UThNQVRxbGdNMTdBVElrL3U3V0VTOTlNUG9OSU9J?=
 =?utf-8?B?cTRmUWZIOHlZSEx4WjR3bTFxQ2tkeXpyMGVSc1E0NG8xV2dQeDBIUWRKUVU1?=
 =?utf-8?B?VDQ3aUNNb0dkek9HbmhlcEJkQ2VGUTZQMEtmOWszbTRUSVpTYVJ6Q3lnaWxl?=
 =?utf-8?B?cGZYKytPNG15b0l0cTk4NitqeGtoS0dVU2Z0RWVxRTJCNVVGK3dQTDQrbGdo?=
 =?utf-8?B?OWcwVk43ekg4M0VVU080WGUzd2RDRHlPK0FhZUlISUxCanlzUFIxSlNnRWh1?=
 =?utf-8?B?UXJpYUZkTWF3cTNqWDU0elRudWdsVzZMTzZYZXNNdWo1SHBCTVhHbzd6RkRU?=
 =?utf-8?B?Q3RVeXRsMlpnVTZnT08yMk5ZTHBpWThFOUV3MWIzWHlkRWVOU2Z4KzFMQ2hv?=
 =?utf-8?B?TDNrY1QvditBVmFDRkdIdDRmWWdZVmVUTmc4bVlrYlNLYlVjbWc2b1U1QTlx?=
 =?utf-8?B?OWFnOTNSbHlCa3pCaFo2KzZZOUZwNGovYXd6MkR1a3pkVHRYZnpOV3RZQ0h6?=
 =?utf-8?B?R3RMZGpoUUI3WXR4Um1tT1MwR2lOajArZGVOemlGSFg3OG1RRXZmOXYzVHRL?=
 =?utf-8?B?ZEVpYktySlFOOHlmOGYrU0h3bHhaZDhaVkxTNmMzUlRIdnlVMUNZdWVqUlZH?=
 =?utf-8?B?djBxRVBpdkdMMEJMYjlmdDN0K2xNd0labGc1SEJuQmRaOEl3SFEyeFpnNmky?=
 =?utf-8?B?ZXNqbVptSmZENE8vTk5McE5URlVTZGF3eHRTTElmdWFlbVkwcjdGYzdDVnNw?=
 =?utf-8?B?aDQ5cVRqRCsweWR1NjI3SUFFSXM5Yk5rVUduQ2lWdHFGTmFna1UzcE56bWsx?=
 =?utf-8?B?d00xYlZVM2txUlN3ZUx5TGxnM3gxaUx2QWQwY2xmOVBwcTVheVlaaHpEUTdk?=
 =?utf-8?B?bFdBOStYcmhGNjdzS0lycEZZK3ZZUUpqNVhvVDhaNTN2ZjJQMk5IU0h2OU1L?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J0VKrM70KO0Z5hUrQRA9KVs4aDYfnOhZWoCgypRUMIz9BhBYB+iTuYXZng+utGfABY90aIlGvvWmbUe6x4n1sbkfHmBaoA2or7kOEJHH9g/UP6whBXPBchHNkL0aJTnPD7mEoyVI269nO0qVamuQvT2tXKtysSSIDFfq4WDa14O/BUTARF9ELgBNEJoTkole53moEh9PIKzUK2nDCxhcVAMpb8tlTwFKEzWnDZ6yz/u8lzwmWATMlA5iu4Ya3RKtT33C3P6WP5s77jz4kRtSni/hsA2Lml4D43L8pF9dL9ohiFJgkSxBzbEnBwpiu5DbO6oD03+hThJy6c6BRe4zzbWN+m+EBd5fPpnZtC4X56ZDinydN3fF5+6uwNNSlW6xQ3ZMAbOcIJlwX8JiWNiXy3gAt429F8YNGo/vdn395wjobXwNKsJcRBNfJajKsXJE0wGMmR6zIoJui09/POdq5F45UDmP+bP7LfATV/UYlzaepoNDAsCdKyqyHf5s0XOkqg1jLFZCmxR8InuQPYcVLPUwqze0mEm0ZOEyveYyUAz0+vme5uiuZGICccyQ3tpLBrtJ+aRfbuH6J4NnA1J7rPHK0r19dx8C9y8hPz95404=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452685ef-b93d-4e49-a6f4-08dd2fcc7f48
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:09:11.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SclqjS+HSstZucACtYf2X6VoaeGXRg6l3Wy6ZbQzVrGiRiClCu7GhcHCkt7Tw1Owj+M/1jmTiVEmXIYcYWB4LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_01,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080083
X-Proofpoint-ORIG-GUID: _j97OPe3UsZHkIeS9RYhQpxH1LyxBFrh
X-Proofpoint-GUID: _j97OPe3UsZHkIeS9RYhQpxH1LyxBFrh

On 08/01/2025 08:55, Christoph Hellwig wrote:
> Add a separate dio read align field, as many out of place write
> file systems can easily do reads aligned to the device sector size,
> but require bigger alignment for writes.
> 
> This is usually papered over by falling back to buffered I/O for smaller
> writes and doing read-modify-write cycles, but performance for this
> sucks, so applications benefit from knowing the actual write alignment.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>


FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

