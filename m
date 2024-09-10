Return-Path: <linux-fsdevel+bounces-29056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7A8974417
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 22:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3A32834A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Sep 2024 20:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0FC1A7074;
	Tue, 10 Sep 2024 20:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gE1QIQww";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mtaXVr9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25D519412D;
	Tue, 10 Sep 2024 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000300; cv=fail; b=FuDDcuMekaLpwPcyFZ00cLuFs/5q0pT1dpYpjiMND0CO6t/fKUoFLBGRJu7WIIf54Nkrr40/v9AiVqFtvCqdfQv4l0Rv5YbmtX43itKgkLLo510joT1ACNmAUuYz5Ph1UYbjAlC6vW5UODEwzfoX1ZUxzNmPlBpTPU9+uhWMx18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000300; c=relaxed/simple;
	bh=7d6hCK8n5zzaIgQHiip/lJvohjvmvOY3G6kL8TPWTOE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YRp0j1mPitAO4t+9k852KCfjqB58lx3/7ft0uJXl91ml/4cuA9OGkbGh5hjqYnKyE2+83fk16hwlMwsCtvznMpqyUdITeQisyc37d9gGADg7QhHONz/TQexTZiZkRoyKaGPYe7pxNHg9ExsUyxBPtxQ7bWn7WHY6hPN6IX2Y5VQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gE1QIQww; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mtaXVr9B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNsL2032740;
	Tue, 10 Sep 2024 20:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=7BA9Q3nxiJbuSoASbNGuH7JCDy1ZyP2BT80N7QRNufg=; b=
	gE1QIQww+zIRlmgv+c2ZwKCDSoPL8krSOqRWTKcCaYwhkZCKBYvGejlJgfGXxGh3
	MN1SbcNEvmbQqtng/zE4j9WvSIcRq9FRKZWnD8jcJw/q4yw4qax9rkn6BzxSZxkU
	FX0nyqeb6nA3mRg0mtogcUVY4gDi+Y0JPx3j+KH1ZuPc2MLMeLmQ4aWwLckNdyOd
	zbFiibZAmJLLgA5YSUvcC+3op0Xuk9D7D+nTIGtQb3Bq/mIry8xTH9FoSML9Px4z
	C8/NwcYIGI/wJsmroZEfDRw7Lpbrebs2kZ705Xwy6i2Uo4igbgvFEYR4AbUJgNWJ
	PgKVzba4DwKdrAa+fC/Y5w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9pk6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 20:31:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AJZxYt031666;
	Tue, 10 Sep 2024 20:31:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd99kkms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 20:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBh7ntCSujZcMpc6Mbxum2T8EmFO+KTjrWyaz/dC1EuWv/MsWPR9uvRex/Z57kcWIv27aBfOoKzdJWXQo8Qlkx//cAX0nNSKv2MZddw3+bx0yFilx5ao2+hS1lnTSeTx25uQ6uyqbjd4RbnfF9U60PjXfFxHz10QxF9wsxwEE2FbFtTBT4JGEpZIMssBGB9CmPlyW2N7/bf5sknma4v1mHfuwD031C5X5MSa3qqo7JtTDrTK17mUs6VI2INGCk9feb+7/WpQ0YpUIi54fnU+bshgymSgJrUF7nF4BlSBFk+DNr0VicngUKl5/Ne/QfzU4bKnYy4Oql/xTCkRz/sKOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BA9Q3nxiJbuSoASbNGuH7JCDy1ZyP2BT80N7QRNufg=;
 b=jlORTmxxlix91EmOCLm6xUU1tVHdAZJAyI2ryRJuGQaAOTnAkBDk4OVSe5Hc1mL+ebp3bjXsDHqDIQabYgjQEFed6RMbdM0TyvvIQlfO4eqo9jD+gwCG1db8cfre5nWcvWoLzs2mj+So43zKVsTUCFeHvXPSGk82islrDJCQeY63q6iTI2Cjdj0uTgUfdW6xjgoGQi+JS+9hQCqspypYQa40BFX1xR9j7T0umaS7Lq3NMyG0MJKAJajj8FHzKqsJXRKJMlw7cgXt22Dqm3ugaTRNhAXjhFZrBTXDbl/s/OUnUZxjD8aDR17yYSC0+0OIdOUzi1bsUtciFx96qxRPQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BA9Q3nxiJbuSoASbNGuH7JCDy1ZyP2BT80N7QRNufg=;
 b=mtaXVr9BK/VRcgSvIETc9kcOOST7VW57ORlRz6nEDX5pmxUJOeeOfjFUOwWCfqBgKptvE0y1cANPbJxPLlwoYKWy9aMI4RRyt1hyk1DxRjXSxJgLqMOc5fq41enOHSM4fR75gIyNM+SInv0lu8dFJ1BBBDs2/Pp/uFcXelJ7624=
Received: from BL0PR10MB2947.namprd10.prod.outlook.com (2603:10b6:208:30::27)
 by PH7PR10MB6131.namprd10.prod.outlook.com (2603:10b6:510:1f5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.14; Tue, 10 Sep
 2024 20:31:26 +0000
Received: from BL0PR10MB2947.namprd10.prod.outlook.com
 ([fe80::8ad0:1f2a:6f02:635d]) by BL0PR10MB2947.namprd10.prod.outlook.com
 ([fe80::8ad0:1f2a:6f02:635d%3]) with mapi id 15.20.7962.008; Tue, 10 Sep 2024
 20:31:25 +0000
Message-ID: <686b4118-0505-4ea5-a2bb-2b16acc33c51@oracle.com>
Date: Tue, 10 Sep 2024 16:31:23 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/26] nfs/nfsd: add support for LOCALIO
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
References: <20240831223755.8569-1-snitzer@kernel.org>
 <66ab4e72-2d6e-4b78-a0ea-168e1617c049@oracle.com>
 <ZttnSndjMaU1oObp@kernel.org> <ZuB3l71L_Gu1Xsrn@kernel.org>
 <ZuCasKhlB4-eGyg0@kernel.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZuCasKhlB4-eGyg0@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:610:77::35) To BL0PR10MB2947.namprd10.prod.outlook.com
 (2603:10b6:208:30::27)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB2947:EE_|PH7PR10MB6131:EE_
X-MS-Office365-Filtering-Correlation-Id: 3603042a-2f69-4d96-f0b8-08dcd1d78adf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NEV5NU04ZVE2bGx3MGttSmZYa2NpMmt2Tm54bFpLcHRCVTNVeUNQRXRSZHkv?=
 =?utf-8?B?RjU2SHhXdms3WWlraHVNa0lWVng4UEs1U1ZvbWRKa2d0RUFDZldKdTJxS2gx?=
 =?utf-8?B?ZlhZbE95V2luWmxwbHBoNDM4YkpKWURQY3JRaENtc2FlQ3dTem04ZkdkRnE3?=
 =?utf-8?B?NSt3WGlXQkFaYmdWN0lTdThEN3V2WU91OWEyY00yRzZxeitITTg4ZlBXNm9G?=
 =?utf-8?B?bTM5Q2cyK2xtNzgzT3crWGJvZC9EcnJsUnppalRPNUU0azM1VGlyNHJTK3pW?=
 =?utf-8?B?eWdkTGZORHRRZFp6QzN5Tyt0WkpXV241cHQ3UFBFc1ZPQVlqR0xaVFQwT0E3?=
 =?utf-8?B?WDM3SGY4cEVQbDcyOXJqUUxNNXppRTNwOHVWNE9QZWxjVGE5S0NKanJnU3Zr?=
 =?utf-8?B?cHc1RDVCSEZ1cld2ME9ENEkyQ0U0T3JObXlNVkJlSEF2RlRDRXRSRStoYS9i?=
 =?utf-8?B?YytwSkhQVkxQTWNBUXZqb1BCa3UwWjYralNpbmRFaXN5eWk3ZzVVWGZaUUNx?=
 =?utf-8?B?dmZXZFdMQzFiL2FPMHJoN0szd1o3WHhhMDBxN1pidXl5bzBiWFJtSlk0QnZl?=
 =?utf-8?B?NmtqWUNTeWd4L2JNdWlkbG84NG5rQUxwbUZlSjZsUEVaMUJDVEhoY1Ixa0c1?=
 =?utf-8?B?Vk4weSswenMySWtOcndOMnhRSHJPVDI5KzNzOXpYMnBVMzNvbUhZM0JNY2J3?=
 =?utf-8?B?SXZrUURUci8xaTVudnZzdkczbkJmbkFLeFFTRDd0bXJWNjRMcndpTXlKRmIy?=
 =?utf-8?B?WisyMVZ2cHhCT2tRNTJ3UU9DaFZvemdKVmpJcnRnM2VwOUdsb2RhVnRrdlJi?=
 =?utf-8?B?d2xVekxIVUJNeHIvYVhGODlmVTN0eHhrZjVYTVZOR2loTjJ3RUZiTGs0OWhE?=
 =?utf-8?B?UE1oL2dtYUduczZLbWpOZGl4ZnR2OUFnRmE3VWJubHRKQjlHQmN0dnhoRHlP?=
 =?utf-8?B?RzNhRG92K2V5YWh5bDUyOVRMZlJwQU1wTWZQdTVLTHFDWHMxR1FtSVpJNURV?=
 =?utf-8?B?dDJTaFFVWHpFdzZBaVgzcWFrdXh4SDlLd1BzWk5TdGNxVHhDcVJ6K0cvM0RR?=
 =?utf-8?B?R01razZEbi9ScUIwdlZWTmFVckR3RmR1OVdEVEFRMEVHSE5MQTNjRElvbHFn?=
 =?utf-8?B?VWVsUUJJVnlIaG5KRkM5ZG5aU0NQTGFUTnR2YVVPYWlKa3A0UDhzeU5QRkJL?=
 =?utf-8?B?enAwSWFKYWE5Qm8zNURrTzNVd1IrT2lLZWZySytaaVV6NGRjb000MGpUNnJm?=
 =?utf-8?B?LzB6bHNrUHIvV0pXYmVmRkUvU01wZnU4QkJ0Y3V2MHZsRHlrYUxsYnBvS3pt?=
 =?utf-8?B?cWdrdElMOW85T0JiNWl0Y2YzRURQelRNZ2p6N2N4TExSczBpZEM2Ykx2dnBn?=
 =?utf-8?B?eXh1eGpoY2xyRUxSY0dlVzB3b3dUbWJvazF3dUlUK3pxZmFHMndOb1ZxdVdB?=
 =?utf-8?B?TEp1ZkEySENKNUc2ZkZ6ajhUT2RuVkZrbUh6M1FxUnhGVTFSQ0l6UnpiL256?=
 =?utf-8?B?Q1N6Q3c0VGxiZEZXdDl5Wlh0Tk1Ib2JNS0J0ekRLQUlrSkc1RVpWODNiMlhr?=
 =?utf-8?B?VStPNXp3bmI1ME5uZTdtZjhMalEvbFhXcmJ0ZS9jR2pPb1pEQ0NCcWlTZm5S?=
 =?utf-8?B?dFVNcHY4b01JcUJ4dXhtK3ppN2dYc2ZuVndaL3ZVeUMzTTdOVTF0allWRjBl?=
 =?utf-8?B?OUJSaHF4dnU1a2NTSXBueGxCK3ZMeGR5Smh5NXVMWFNXREFvclg3RERWL1pK?=
 =?utf-8?Q?v6C8RqPiHV0iActvgc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB2947.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0Q3VUtyelptRzFKV0FudGdTS3RsazQ4UmFnMS8xNjg1ZTFNcmZucVlLTFc0?=
 =?utf-8?B?ekJXUVZ2elhaN0VIR0RmaU1Rak85QTNDK2ErVUFkYzkrbTgwU0o2K2RLSEFw?=
 =?utf-8?B?YVRpbUdmQ205MWcrRWdhN0syYzZ2UDczU0pPOVVmZGxZV1FzUHVwT2ZtRVd3?=
 =?utf-8?B?eDlod1RFYjVQY1o4aGVCQXA1OWhhYXdJNDR4R3dxYnB2Y1hoZ09BL2ZUdTZE?=
 =?utf-8?B?Sjg5MjNBV2V0di9aS0NaU05URGRKZ001UEpRNXFvQndmaVYxWjVVWEIyNWxR?=
 =?utf-8?B?cGZSdmdEUGlwNTN5Tnlwanl2c0ljTnRuUTdNOGhtVXFHYVo4YjhYbitZd2cz?=
 =?utf-8?B?UGpMSmljSllZdnNqc05PYnpaMEJSWVZ5NGwyaThXWnlLbTZGODdyYk5GR1pM?=
 =?utf-8?B?SkZ0bmcxbnVxWDBVOC85UUV6WTRidkQrS3FoNjV1UXRYbTI0MUZIZ2F1SXFr?=
 =?utf-8?B?ZUk4Z25pY2NMNnVpM0tvQ1Z0dWZ1dWEyY1pUNzlFK1R2RTdkZmZ2N0xDb2pL?=
 =?utf-8?B?OVcwSVlWc0M2RklnWjZFa255N2EycTJaK2lmWk4vNVhTKysvQzBwVnJxOXhM?=
 =?utf-8?B?VytPUU9RRGZCaXcxSHJYY3dzb25GbjhXQm11VWhVSzhuU1djNW85K0NVUXhu?=
 =?utf-8?B?Y25xbmVjVThmVzdRSHo2VVc1aFl2dmtnbVVDa0ZsTi8zWnF1RFJleWZ1eFRk?=
 =?utf-8?B?R3VpaHN0aWx1Z0JRaVJMOVFaZnQ2VlM2UkRjTWlXMUxtQ0hCMGU1QWRNWFBz?=
 =?utf-8?B?S2NjRG1oV0l6SDZTSzZONnhhR1g2NzkwUWlGQ0RBb1UwMFZyQVUvc3hyaExS?=
 =?utf-8?B?WlJFVzF5dTBuYjdvTnYwMzRoYkJGNTNQamFWS1NOaGV2QjloTmJwbUxFUmFP?=
 =?utf-8?B?ZERXOFFNU2RiQmpmVlZnbU5RT3FuNnpDdXd6cHhqUnhaY09Mci9QM0JjNGdh?=
 =?utf-8?B?c1FvK3o2Z3NjZjZLbnJnZWNJSzhnMFNGMXAyUzJyalpSMUdJQXl5ejV5TFI0?=
 =?utf-8?B?K25HNWlsdGZHcEp0c0NiTVQwd3lpWG5KWHlnRDF2R3pTRVBNQ1ZQZTBCbU8r?=
 =?utf-8?B?cFVlbU8yejJ5OFN1NFZ1Nzc0UkhuUVdmTGkwcmRLT29XTFgyU3IxWDNSd3Zh?=
 =?utf-8?B?OFhGL05wcktQU2t6QjlqeTZkcExmZHVORzJOYXBVVVFFV0MvdlBPeXlMKzVU?=
 =?utf-8?B?RlkxUTZ3dUJTRGtwU1BKc01XdTlVNWdNM3Q0aHo4L1J1bjJ2a0RjczRkQkxy?=
 =?utf-8?B?MnVCWGxCQTRyeWtHYWlaUE95dW5GblVCeGJ5YmFEQ2RlU24wL2ZGUmRVTWdy?=
 =?utf-8?B?a3BqN0F1aTk1eGZIaU5kbVdZNG9IMWgrTThHek5oaEk2WFVONEs3TXVmcU9F?=
 =?utf-8?B?MjBMZE1wQXMrbG1qVG9JZitDMkRFK3FzTWh6eEJ2Um9aSkluSEg2c3dTVnV5?=
 =?utf-8?B?V0dYMUVTUVJGVDlETWZRRnBhalo2Qk1TSlJxT2Yra0JaQkFIVHFKYVcvYjFs?=
 =?utf-8?B?Sk9Vc0F1d3IzajdZTjFaY1RoV1RuWUQwOUNKdnVBR1ZVQ05TLzhGNDdyemFU?=
 =?utf-8?B?dkh5OU9aS1FRWTAyMlhZUGwxM3hSemZ1MDdSSGEyb2dpeG40K3VQVzNpUXQy?=
 =?utf-8?B?aFZhdDh1aGtDa214eEw2dnhDMzJYMzg4YkErLzRJd0VnNVE1alRqZzVNYXlO?=
 =?utf-8?B?UFhSdUw4WWttbzI4bjducUk0NktML295SWFqZHgxMUR3WDBvTi90Z0dsTHlq?=
 =?utf-8?B?R0h6TzMwbmR6dnBkaTE0ZjMyd2IwZVlSK2gzK0lGTG9IVStkUTgvQ3FaT015?=
 =?utf-8?B?cllsTzcrdjJhd1NjMUx6UEg4OGJCYzN1bWRGM2hWSlhqQkV6NUFMakdMUE43?=
 =?utf-8?B?Kys2WEZZRjk4ZDhOb0dZTmNUaGovMUdjNEpEOUNYUWdRWGRKWU9scFRNV21k?=
 =?utf-8?B?TS9IME5kRWVpVzEzcWpDdkRmTmk4QTc0TnJPaDZCdkhYYm5RMzFtektEd0Ns?=
 =?utf-8?B?TlhITDBFTlJMODBJSVl5Uzh0YnRRa2ovTDFXVXhLWWhSMUd6WHBzU3Y3ZXRJ?=
 =?utf-8?B?LzA3SjhtUzZOdHduaWppOVh2RXpaNzc2Mkxzc2tXN2pJV0ZHUjdWWEtzMExZ?=
 =?utf-8?B?cHhwaHJhWE9qYmthQ2ozWi9OMW9DdWJPWHljR3RPd0I5bEZMNFdsckdjTTJo?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ncEJpnRUNnMT7OUI/9gLkRstVZtklg6isrBnFLSPN4RqwsYknsx5Qbxgp1XNU9DJ2vbR0hYRFgng8VNvnBzrTyQnKCaNKd0pnKgf6Rj94WE7uPVFm2xGmGmfLfLYdblXCqtb1i5gbI7qf8AVRJSpXDGVkjrR7mKClog3WIbc9bGENV1Puqut8e9umq2iB/5LZkypUkLWdZNcFNuA4lZ0QdWITni1zLa3QhJLD+u+5VfZ2nXaw3uX64usq78UotqwBmoaQVF3m5KYdVoCLRnBFHnxwv7JGIksv5jqTfm3Tp7sqoilaWIK02EDFDkAVbg8RgMNA8yJq/uEj8Anb00PyrnPQ0ErdDpwfQjgEnO6w/NEGhTJo40oleVeR/Bo33JiX2ANStV/K2T5nYnLYHd3OdUsisRKK+xxPr8YR0OS0OWkbKWjVbPDu/1757Di20N4Xbh03EB+3+uJru9o1uMYM/ZeAULqHbyH7/Vvf3TDuEJhYLCESkxYF4KgtTEmstEbt0NbiwXP/anbAnotCc7eIb79B5gGqzW3JLerZfpVCfAWQBOTFwHg8EiT4uOr9diyTWwM3c541awaRMyi8AguGrktGZpY00n81w+BKIJaMBc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3603042a-2f69-4d96-f0b8-08dcd1d78adf
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB2947.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 20:31:25.9315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGQ+lSp2fGKyZ4P8EGWE5/zYnE67lAaUltZ5rv04Jd0qg7kfbmv2edu0NhI82z0nz6cYOYBcIqafRyiyoRoVzdByEp2umsh2g8bFC/oLciQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6131
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_08,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409100152
X-Proofpoint-ORIG-GUID: sRj8boGqWyRl6YREvVWrcrd9juf-6LhC
X-Proofpoint-GUID: sRj8boGqWyRl6YREvVWrcrd9juf-6LhC

Hi Mike,

On 9/10/24 3:14 PM, Mike Snitzer wrote:
> On Tue, Sep 10, 2024 at 12:45:11PM -0400, Mike Snitzer wrote:
>> On Fri, Sep 06, 2024 at 04:34:18PM -0400, Mike Snitzer wrote:
>>> On Fri, Sep 06, 2024 at 03:31:41PM -0400, Anna Schumaker wrote:
>>>> Hi Mike,
>>>>
>>>> I've been running tests on localio this afternoon after finishing up going through v15 of the patches (I was most of the way through when you posted v16, so I haven't updated yet!). Cthon tests passed on all NFS versions, and xfstests passed on NFS v4.x. However, I saw this crash from xfstests with NFS v3:
>>>>
>>>> [ 1502.440896] run fstests generic/633 at 2024-09-06 14:04:17
>>>> [ 1502.694356] process 'vfstest' launched '/dev/fd/4/file1' with NULL argv: empty string added
>>>> [ 1502.699514] Oops: general protection fault, probably for non-canonical address 0x6c616e69665f6140: 0000 [#1] PREEMPT SMP NOPTI
>>>> [ 1502.700970] CPU: 3 UID: 0 PID: 513 Comm: nfsd Not tainted 6.11.0-rc6-g0c79a48cd64d-dirty+ #42323 70d41673e6cbf8e3437eb227e0a9c3c46ed3b289
>>>> [ 1502.702506] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
>>>> [ 1502.703593] RIP: 0010:nfsd_cache_lookup+0x2b3/0x840 [nfsd]
> 
> <snip>
> 
>>>>
>>>> Please let me know if there are any other details you need about my setup to help debug this!
>>>
>>> Hmm, I haven't seen this issue, my runs of xfstests with LOCALIO
>>> enabled look solid:
>>> https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next&test=^fs.nfs.fstests.generic.633$
>>>
>>> And I know Chuck has been testing xfstests and more with the patches
>>> applied but LOCALIO disabled in his kernel config.
>>>
>>> The stack seems to indicate nfsd is just handling a request (so it
>>> isn't using LOCALIO, at least not for this op).
>>>
>>> Probably best if you do try v16.  v15 has issues v16 addressed.  If
>>> you can reproduce with v16 please share your kernel .config and
>>> xfstests config. 
>>>
>>> Note that I've only really tested my changes against v6.11-rc4.  But I
>>> can rebase on v6.11-rc6 if you find v16 still fails for you.
>>
>> Hi Anna,
>>
>> Just checking back, how is LOCALIO for you at this point?  Anything
>> you're continuing to see as an issue or need from me?
> 
> In case it helps, I did just rebase LOCALIO (v16 + 1 fix) ontop of
> cel/nfsd-next (v6.11-rc6 based), and I've pushed the result here:
> https://git.kernel.org/pub/scm/linux/kernel/git/snitzer/linux.git/log/?h=nfs-localio-for-next

I'm seeing the same hang on generic/525 with your latest branch.

Anna

> 
> ktest is running xfstests against it (LOCALIO enabled and in use):
> https://evilpiepirate.org/~testdashboard/ci?user=snitzer&branch=snitm-nfs-next
> 
> And Chuck's kdevops testing should test it tomorrow morning.

