Return-Path: <linux-fsdevel+bounces-49407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F56ABBEDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 15:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1215E189EB30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 13:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C3F2798F1;
	Mon, 19 May 2025 13:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BpjCOx8R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y+2KeCpb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C9CA55;
	Mon, 19 May 2025 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747660446; cv=fail; b=g6w1LC42Vy+AYm1aFnol40l95l6GZgMtFbGlMVrdkATjnsnrHEfOJqQRDAkaTlL6CPySUQYp2gB5uqdMWO4Kxu4hqcVu54T6c6e7HNPukO3D80baqaPgAMOJEAdJCemHv1tN7tCbaWuSYc23YakFJHpwvLXpbRDxUgbF7vDfspw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747660446; c=relaxed/simple;
	bh=1eIppLYBTm71tyVe1cXIiekJb0Sd21+SKtSsIoqy5V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GHAx3jIXHM4lZirjg31JP6Z3YnjGyqlv3sqjYpJjVWkoetKl7DfD76gQucic5VIefHbOL+jzQcWDp9TkEyDryJL3Cni4dcKO7Vu0PVQ2k+mRAxEu2QaO5W+ZgYxDmjxHtxh3gPL+JBPFAjObAVZJecFv7AYi1m7segEf7V1eDvs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BpjCOx8R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y+2KeCpb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6inNf014394;
	Mon, 19 May 2025 13:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1eIppLYBTm71tyVe1c
	XIiekJb0Sd21+SKtSsIoqy5V0=; b=BpjCOx8RF82XBOz5PSsJR5vFo/GP0Qc1E0
	rUYqq5BW5JcjJT8K4afrn/YrI28W4i2awDIJ0/kaiRW4nxJ1iFDpAPhM5IY13HdT
	zYZYenfCOuADHEjKkNtn2OnFE0C2aKmuP+zRtKEdIvSYc3mOqZp3hFCaCsIJsKHG
	9v+opNghhfND/N8fm+c916P+wuJOl9zPBval96PCEJewg4x5SAFPwxP2OaAleBFL
	EqekRQ7OCHBgvK8oJCA471osoBWt267hBPEo3DcCbKWumq2EKauZ/dHmj8c1aAo5
	uCFTDgqLGY8hv4c8IRFduy4dfm9wov56zTXg5VE9CTSIZYATU6/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84jy72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 13:13:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JBSlum017452;
	Mon, 19 May 2025 13:13:49 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2044.outbound.protection.outlook.com [104.47.57.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw6x40e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 13:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h+lZS9UbVgxIt+7rZk/+TqqSw+7/qwWyhABmhB3/pDeJcIT+V/6JzqqkCy/z8rVssIMeiUwAjHNv7Xbo3CosgraSTLuU0EYpTfAecle1jXdc4CKIaWALAQ39aKJx70VaO/hI2Rp6gtYCNACEgLGfSOCG4605mMwJLCvvDZtcxTJ1AOm0asMuBcpfnjlAYkWC/+dCjQIwY9q4j33HLPxaBqdQwbaqmchfb2kgb/b7q1JfMNohSalJutBb12F/VfQCpuu0gIoTmVA34qqrhKmaSVTQ1br6Ux0jaThokrIjOCF0trwLsoXDx2TaX6uy+w/3livHE3JCGirUZQbs6giogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eIppLYBTm71tyVe1cXIiekJb0Sd21+SKtSsIoqy5V0=;
 b=JpmqhHqerITAETa+1wTBeGVCfDp4IyZMQ1mo9ft7eaymYSRnTWu/P5mEjHdOQyBZjzG9suSneD80/HQcWNoVZLxgrO14hN09t9UBeRHPfQA0SGsIiYkN4xtRIv+F+pVzV+1sVB608kWXDD3nARGUWOvIf7QJeb9I1gu2b1y79LZ/99wmhctSTYAQ0uiNmqAl2IwslBB7cx1T9XvXokx5IK7H/413WMjiJa1qlC0Q9dMxiBMbqM+JlcK7I+IQN1UNAA7/JLAxJ9XEwYVp/e2+Xusd/yIPBelsgDwK0K8xgMhVn8F27x902O6zNAHyIYdTY5Ka4iAUV2riZf3UDOCAQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eIppLYBTm71tyVe1cXIiekJb0Sd21+SKtSsIoqy5V0=;
 b=y+2KeCpbp3asyIT/RoApppYV9qnueY6Qj8uCegUY/29qwK3fHO3vsfkIKtw7JVn0iI8b1nNYfjji3eA1wsOLYE7McecctM7t2XIwUJebiO4W01joKKASjQ+8xCPQRpCvTGK7dHZEPuGueTcurIjFTRVfRvLgquJDo0qGV7/0l6w=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4735.namprd10.prod.outlook.com (2603:10b6:a03:2d1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 13:13:47 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 13:13:46 +0000
Date: Mon, 19 May 2025 14:13:45 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm: prevent KSM from completely breaking VMA merging
Message-ID: <2a438a63-2acb-4a0d-b86c-62bc6eb2bb05@lucifer.local>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
 <418d3edbec3a718a7023f1beed5478f5952fc3df.1747431920.git.lorenzo.stoakes@oracle.com>
 <4be335ac-8b6e-4714-bce3-f62495dbee8d@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4be335ac-8b6e-4714-bce3-f62495dbee8d@linux.dev>
X-ClientProxiedBy: LO4P302CA0023.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4735:EE_
X-MS-Office365-Filtering-Correlation-Id: c7204771-fc86-4b69-6cc5-08dd96d6fd04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3nkjCEkYFmC0wHxUV/OFIEG+rNLXiCFg9VtB+Mor7d3XdqbZQe58K9BW00rA?=
 =?us-ascii?Q?UDMqjgm52rhmIw62HNGBNXHIGFvDY1cGav6iyrjMuaSysM29gjKHqirooKog?=
 =?us-ascii?Q?FW4Bd5invFigX01aPkNNY686dNcN7lvM7CRDmSfili2TtRmw4V92SJKpEdTF?=
 =?us-ascii?Q?ruUObVS0GD12/C5lVeCIPp5SeC3475V0ESliePrMUBbg2XZsW3QZZMaM7awL?=
 =?us-ascii?Q?8lBYcM/azE/U4PSxWrec31XvFWhJsatbNf21o8bpIzsZgnwEUgsCc+E6x2kZ?=
 =?us-ascii?Q?VVE8uQh+O2V7oRgq4M4QWGK2lrNBf6qOyDh+hcDcgKlKV/ypXyjOsYhjlxr7?=
 =?us-ascii?Q?uHcHL5lSe7/p8B235iDsEkkDvEdo7Pbr5QdOn8Y9AoNmSF9C+piUjCNLw3g5?=
 =?us-ascii?Q?HwVXAOlablgB+ELCPeMM4KgaCeaeLY1silRAPhIIKE32arMgPCXYU7XVRDsd?=
 =?us-ascii?Q?8tXDN7eo0hMDSVubSB2XmHyeubXN1TlUtriLJR5C2FJQCcCJkEKIPSxnAfoz?=
 =?us-ascii?Q?fDVoprBtN7z4JRNSMuBQ3bgpVoYy7x3UZG2z7e34muh+kM0dhGIyc/ZLWord?=
 =?us-ascii?Q?/ChI+1WxuAjn2wuHeJAIOqkdnion/XrAp1+wsgZVENK+6UFQc8eH9H76tsv5?=
 =?us-ascii?Q?UxEm57WcMcDSWddM+C2B9netot+plI68t9LVLctS0NAmDQZdA68jm5iNtqfh?=
 =?us-ascii?Q?xFkANCplNA2JWtxMd2ZAom8EWczXUJrrKFkx5LUqYtcUb4o8SLmiiFI9AW1b?=
 =?us-ascii?Q?zOeeTrdE2o94AkNXIZ1FKGCpDfA1/QtVQYo+5BrHaxOezzpy+2FY4J/vUBvw?=
 =?us-ascii?Q?xuQUkIcCn32322gwbSmhYQR1vhiUjmBSm+pPmFvreIGuk+Fyz3+YhLPiiRbd?=
 =?us-ascii?Q?0DKw3DpfYqob1FfOnzRW88m3utIMK0He0LGRp+fA8fdaY4lpg0sWp/exAzAT?=
 =?us-ascii?Q?efHXRo0NzyyJdXLvf57afYzAQH8F3o54aaF/MwL5epBbPXhtsrLvLJOx0nTh?=
 =?us-ascii?Q?FChhdt2GFtNMsbRZWPiA7s/Irg58YFGdq8xgnbH7rzXGzbeIENP0TDacvzED?=
 =?us-ascii?Q?5lCP/HcnGLLf4PnRmME+kJvAehT8EAvE4a4UMfxEARecUHNNy18NQc4uegb2?=
 =?us-ascii?Q?yh0m6O21kFFVilahhS6pvPLZRTU0Yl8nHump0WQpp2Bnb+OclBqqykbnKLod?=
 =?us-ascii?Q?whkkqjJT7u+Z4TlQDeWByFolVQSPCfIdYSjgupxqzy4gbZ41q/zJKPnMi8Kj?=
 =?us-ascii?Q?71mqA+kqqsiM16wp6qeT0T3x5H/lVXHCOobULXuZS7W2+gLIfZEH9/GagQxN?=
 =?us-ascii?Q?1JZDA+L3UjkfpT9nv3nEwo3FBV+7bGvCnQhd+f54q1jyfqbbvewSKpolqMWo?=
 =?us-ascii?Q?Bhe4E+BjodRGrcvF8oBtroeGHQI3kln6otwTuL5byPOh7AgTb47qjDdGe/r6?=
 =?us-ascii?Q?hFOI3nQdVeg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwIdNue7XKHNrBxg0cWrpZpRmU2/ec/GGSIrJMsWiUkpUZUstfpPCTxh93AT?=
 =?us-ascii?Q?gMirDTrzYaaMsH0M/cSi1pTVpPufnOVbqBKziRtbjGWrqdDvwodbq18lN8re?=
 =?us-ascii?Q?OQRNMDqKdo/XPA4ICAnwnfU9C71luWxW5glXuPaf3CK3iQcUExsLdNg6r2Ta?=
 =?us-ascii?Q?Lb1eHIoABuUJ29EZF/kYBWOeaxKvkUnNc8Aqp4WKu9Pex7DAVNjP+WZ7oyVa?=
 =?us-ascii?Q?LBI+sjRu7q1obw0e8zBP8U+1t1LgCps5Y9/YFguWVMgMp2kLOJ2ko3gSHXBj?=
 =?us-ascii?Q?BEESMarlsRaZZbKdJRnUzzqavbTbyNrbu/skyzlUvtsbvKVTRhq3A8qXMrqA?=
 =?us-ascii?Q?UWrFs28z2LbmvzgfYNRg2JWxm1iNluqaGD4wjWT9QfzrWX6ID/msY2RImp5/?=
 =?us-ascii?Q?9zvQ4M7Gg84W00QJUJQ2LiHP8j1CTAxSZzjNh+ILHEqn2Xe3nscOcGyNiW+l?=
 =?us-ascii?Q?oWb9UwnUu+nRVxE74E2koLmrD+G9Cm7smVJtATJvWngn4OaLtkIBs1ll625R?=
 =?us-ascii?Q?lRbQwaafZ/h4MfNEZjqYweb0K/KxaRm5QbB5Wla7ZKkAvt9JmXeqy83X33rq?=
 =?us-ascii?Q?nR87YAYWGfxj6x1dIlqTTRjAwq4aJL+S0Dfh1zvhYyYWuyJrAdid/CfHOulK?=
 =?us-ascii?Q?jFpo5ebrwFoXqlqv/d3QZR+e/2GYWMFPuubEQVb5yVefSNdvmuTv8fDC9nC6?=
 =?us-ascii?Q?lfC5rEWgtPBeG9/Cb66uUPonsPGywbzyY7aqpzMwylJ/7B0Y1jUKlMOrR9FB?=
 =?us-ascii?Q?m1Quqg+zdR9Z22gkp0XAsAH149zrX5zwx/QlI+jL69dECm7nU8mZ+pVizZdy?=
 =?us-ascii?Q?F+RaUJtxDtYXwX1AMBXAr6ywooHAFHXkT8UT79kLdCrQ67hKCXTkf3Wga+AJ?=
 =?us-ascii?Q?qmNvq69uE4N/fsC3sVJMGVtqBZn9iYeTMWOt6Y/rA6VYA4N+i0TrN8e1Ut1t?=
 =?us-ascii?Q?ONSiXe1sdrP8XwQAuPtdB5litFnvD0vUnWUbLTBnkWSa12Jakfr8qvA/rzIC?=
 =?us-ascii?Q?PO2oOS5FLJ2swGH+IuK9ZLyHo7S/b9n/TzGLv3pno1t7Q3LFmLq5ohuZc7/m?=
 =?us-ascii?Q?f8/rwHm0w9Ao+4n/MreD1yEHxJQ+8PQv/6cdnLD6t8RC+wWYxxrxaATbOaPu?=
 =?us-ascii?Q?iT0u9tp4hdXuP++5ONRpA8YI7xT/NDtL37yMtFAQw8VJ5vD0FsbjmywGzdJx?=
 =?us-ascii?Q?VTzkLHRyto3VpD8c9vnlTa9Z6fPMlkmc7UhY0GQHjFDB13oZTTEDtR2Saeqf?=
 =?us-ascii?Q?myOOMqrMgm964p1+MmniYepix4LESbxcs39Uf9gi7sV2fe5RR8UBjtUmQoQb?=
 =?us-ascii?Q?9cgV4qQ+D0PlFXn2WtpQo+XfMtJdgO43fSDF4Wv26/e/+Xn14TX4Px57LPtl?=
 =?us-ascii?Q?rcUxx6K8zuYA40FpTrZpMT6onUXP6p8uczyHGkZF8nFfn6TDZoP86Yb8uXDE?=
 =?us-ascii?Q?mwYWoGhp0JG3bSiJy6gjrNv6J+QXyvwVfQHBkroDCDy7vYrUnDLqXxDQPH+q?=
 =?us-ascii?Q?wTDYgIl6PGnDAL/SqCal6QDSnmTdQnMShcwpiXyzarzPfXaaq2lpbPRHAf2G?=
 =?us-ascii?Q?BDeSth//s59Qt+GjLllAKB+XSM3MB3EQAvVsYBqAOOCSy6GN5jbTy8hWUGl+?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Pl2Ard3+FkIJnfVtVieGfuBTaM0axgazSthjrj9q63DvW/AoY8fQqj9HMbQsaoyuR4QpTi7LUslPZ//TFxB2RH4xLCqBmi0hmPsI3mHZWMJ8fP7NuY17fuvT63xde1ovOZgdfJ0JS0CCZ0120dh9wBMuODkvrUdHO9AaVHXjAj4BuCs+fGKKuKJVS7lyjjG08gcWQsOVL2C39Rj9kiT5cmhNLPwXJiqi5WPie8PNRSb1LU0qABxmIXJJlWyvoYOBxRe/S6VZkgj/mUoq7E4nFFuOcdYrF2qy+R3dls3oGay8E3yltJurnP+9ey/2h033kE2r3foPu7FkhZ7CMw5rrfutPPVu6K60+QhvzlPE50BSBeSOP6hECl/p+JgzXs4+ZIoW0K7OMbjm31GAY0GDib6j1DrlTxb1SizVFc8qTHw+PYEiAEacVnib+r7WoPMJlfQTQl91EMrt4Y167KDZix449GdrrAbXu28EaQUaRN0ey/4jB3aqvaunI6KPfOcX62HSAdnYxksOjDB7DBEJnxjMylNXiiLReh0p+gGYpmYS1Nmrpm1+YwBVDHx9CfyKUbNO81smdCMi2gOmgTV5QKjHOkRDMTZrIyvpCRUEes=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7204771-fc86-4b69-6cc5-08dd96d6fd04
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 13:13:46.9320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3N59oe063O+jiE/OB9rmtVrlFGYh4p7b4d1bGYWoFEPha5REbE70PZiEEhMwnhY7nkaUKS5RezQvew0FkNCGHr9pSANijg8jIKklm3Q/Iuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4735
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505190123
X-Proofpoint-GUID: D756AA27sOYp71lrki6vbsclofcKU0fU
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b2e8e b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=vfvwYJ2EW8LmJe7qqFUA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: D756AA27sOYp71lrki6vbsclofcKU0fU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDEyMyBTYWx0ZWRfXwshAYSTIV0b2 H4rA9Dn41vgfppI1/XbVmXJ3nyi5bxYkQut/Paunng8uygbx/6zzxCSSAC/FvDQ/3xtS69utwz3 rLTpZCPlLZGLNZW0BsLpia2G2eGy3zMKgcdhouV37KXO4zi0B1iyloVswQuuzYF04MgutqG4E9d
 mNAcZl+zxrRwnMKssLOFW8Iqig+oS0ib0NBT5t3IwTDEhoTtM/lM8rhCZCFbKNt52ZCELRY0E65 iL3frh3eI5Vv0e/9ylbiES0DWKi7J21/Wx84ubgDndXqbKB7mmipBsx1SOuqvMt4sEtz2aU37WO sS/Ofzb1ad/js3RqToRgxRvwGy+Q575UaaJh3wfzuUFGVPfMXKGTkvsQPWRdYE26J1LuqoxzOTW
 HndLHAwP8gngFuIJMZ0iQZQOMXz7AB0N26C3EMCZcbOpb0IB9ph3tNI+iwNHzTMJtz6qGINz

On Mon, May 19, 2025 at 09:08:57PM +0800, Chengming Zhou wrote:
> On 2025/5/19 16:51, Lorenzo Stoakes wrote:
> > If a user wishes to enable KSM mergeability for an entire process and all
> > fork/exec'd processes that come after it, they use the prctl()
> > PR_SET_MEMORY_MERGE operation.
> >
> > This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> > (in order to indicate they are KSM mergeable), as well as setting this flag
> > for all existing VMAs.
> >
> > However it also entirely and completely breaks VMA merging for the process
> > and all forked (and fork/exec'd) processes.
> >
> > This is because when a new mapping is proposed, the flags specified will
> > never have VM_MERGEABLE set. However all adjacent VMAs will already have
> > VM_MERGEABLE set, rendering VMAs unmergeable by default.
>
> Great catch!

Thanks! :)

>
> I'm wondering how about fixing the vma_merge_new_range() to make it mergeable
> in this case?

There's no need, we apply the flag before we attempt to merge.

It wouldn't be correct to make any change in the actual merging logic, as we
can't merge VMAs with/without this flag set.

So the approach taken here - to (if appropriate) apply this flag prior to merge
attempt - I think is the correct one.

>
> >
> > To work around this, we try to set the VM_MERGEABLE flag prior to
> > attempting a merge. In the case of brk() this can always be done.
> >
> > However on mmap() things are more complicated - while KSM is not supported
> > for file-backed mappings, it is supported for MAP_PRIVATE file-backed
> > mappings.
>
> So we don't need to set VM_MERGEABLE flag so early, given these corner cases
> that you described below need to consider.

No, we do, just we might miss some corner cases. However this are likely not
very common in practice.

As the .mmap_prepare() hook is more commonly used, this problem will be solved,
and I think that's fine as a way forwards.

>
> >
> > And these mappings may have deprecated .mmap() callbacks specified which
> > could, in theory, adjust flags and thus KSM merge eligiblity.
> >
> > So we check to determine whether this at all possible. If not, we set
> > VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> > previous behaviour.
> >
> > When .mmap_prepare() is more widely used, we can remove this precaution.
>
> Sounds good too.

Thanks!

>
> >
> > While this doesn't quite cover all cases, it covers a great many (all
> > anonymous memory, for instance), meaning we should already see a
> > significant improvement in VMA mergeability.
> >
>
> Agree, it's a very good improvement.
>
> Thanks!

And again thank you :))

