Return-Path: <linux-fsdevel+bounces-55946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF415B10BE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 298B05A3F94
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE3C2DCF72;
	Thu, 24 Jul 2025 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AitTbmD4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tFiRdxqc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9866D2DC352;
	Thu, 24 Jul 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365011; cv=fail; b=d+7pZVbfB7t5TGDrdAfSeR6coNe9lpj4TqxlPn6APs7GSR3vcuwRUXxy1gCnz7PT1VMlB27izJZ/voDCNKKSKTz1m2+O44WMrLeJWDbQtG1yE82wXn3tvuhV7mlHe6KBYuFgF+qPzlw1dUrmDwzPSYhqCinqke12E4f/0ji88YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365011; c=relaxed/simple;
	bh=55nsvdlPYiP9QbikqseSZ6cisU4H7S/sdsjtCPOb9CU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ddkp40qWDHBl3aD+Mm4YOlDDXL4WC6QKCfwYvUjzVxFgvPzqmZo748beA2sIHuu0VUOTfbgB0xSBhFFC5A7IDDUsgp+4HTuYXPYv4Q6v3ZvnPhhhHZk1cnRzH1HvspuXUWLa5VgBshA2/kz/E7EzaMj/WFQixQeF3q5qmpjEHF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AitTbmD4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tFiRdxqc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODRLMT017789;
	Thu, 24 Jul 2025 13:49:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZdrjMHjBDX5Ne3vSzexYe7uuycDuQ4oU2JMUKViGsIg=; b=
	AitTbmD4+nF10kTpapO2OWzFQTEhPnthomxKb6IAw5khSMN8vaz0ljhCW/AMyS5Y
	Blq1XOabimFRQQl7IkWYVIErOXFfqNOdZclI6lIN1IWknaoxVUYiUcsJbfgJAzGc
	4KS528SwqZiOJ1so7ICJdaXYrQpoZ4wgKMsQFc3RgBIKKG2lQC7YOhNhfqwuRn4p
	XLxhW53YOrEEj7eX0M19l5pDKmLyS4npKs1WLlOIPRroWFpcrVIhMoOF/iBkUWPt
	e6xpM1cVNK5XV64ssQICmEWIylQXfOMP7cEh2+jPZ0GZuOzepasJl21b/RnFBmbI
	HmPWYtVWPSVYmviBenmhtQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48056ehhcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:49:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OD3u3I010429;
	Thu, 24 Jul 2025 13:49:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801tbvcum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 13:49:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RaPfiHPzUNJczAPpAONs7L/HCOu8BN+79y53byzpub9/pz6Ud4OKE4WhWH1C06t9tFID5/Ruu21n6JKL48HAAYJYsQdbqOb7/EtzTRHeRjlXtV3J9k7vOF339+laN2onGC4NqVSvl2p/o+VAZE454E20GiRzTFc/8kdNO73ir6H9hy/eekjnWHXR/ZGXOd4My+TScSEAuXbmDcqJkQ7iHkdwvj9PruotPxnxZbYTaQMcfTk695VOd/Gtws20CEHCvTrQYuVqJL5pQ32084oyyvUobFZysMkR+df8xMVtfG3oECXlE4abeR2/AbTdgzSsQZo6im37jlGYjoRM8i8/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdrjMHjBDX5Ne3vSzexYe7uuycDuQ4oU2JMUKViGsIg=;
 b=M86P3w+Ycj7TLhB22aACVqD7wfiY3PyjFLL3pUpmRNFvptPJdyQc0ImOmvl+D1GU0giVVnxh/h4AN97yaEbe01T9kgVz+GqwgdAHqaxqGPP+LBjKb0jwJw7RUV/T+tYeyUtRXTwgFewMZ5SHAjLxZQFTwZTrDI67RYUHGLOo8jn0f9nH3P46UzfmWaxg/Lb568gufNaF1xccivYEGkMtEuCUAn9a8VvC6BtW89GpQd98F8ROeBwqCJh/5q6Tj3SwVXffcbDjh1ULv/wtF5sfYP8WqE2zRBVL08J97WqSHt3aGV+sz43LrXuZhrFN6uQUWG8qCKd+ZAcg2zbeddGpeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdrjMHjBDX5Ne3vSzexYe7uuycDuQ4oU2JMUKViGsIg=;
 b=tFiRdxqclc8DqIwoATumX4e+/WzNo4OLTgEPyPmct4VYSrO+2wkSp135+yb95sh8epbwSTHIwIMZ9mCbvTcxqSnvu5lvcfaQEqQnKmw4AJFU1TqsCj3bO6Yp3/C8HW4qJgLDZlVgbbZWzfwCyTFGynb+3mQ0rcPKOfJHwWKVBtE=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Thu, 24 Jul
 2025 13:49:48 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.023; Thu, 24 Jul 2025
 13:49:48 +0000
Message-ID: <67a40fd8-be26-478f-b8ec-0dc89dc0b140@oracle.com>
Date: Thu, 24 Jul 2025 09:49:45 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfs: add tracepoints in inode_set_ctime_deleg
To: Jeff Layton <jlayton@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20250722-nfsd-testing-v1-0-31321c7fc97f@kernel.org>
 <20250722-nfsd-testing-v1-1-31321c7fc97f@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250722-nfsd-testing-v1-1-31321c7fc97f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:610:1f0::17) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|MN2PR10MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ec5061-e28c-4666-9c7e-08ddcab8f431
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?YnRBYVRnQUdGSnVFRWF6d1Y1Y2RvZmV4MkxpUEpnN2Q4QklpSzNxVjVUK1VK?=
 =?utf-8?B?S3JUSExmdXNiWVNRcnRwNHlvUVkxejNGWWNZaUpRemtRN0MzYVR0eVF0MENG?=
 =?utf-8?B?R3R0cGUvWUVQR3ZFUjVkUnhpWEtjSmNiK3BvaGJzZHlqTno0MEtPbURCQ0Ir?=
 =?utf-8?B?RDBmYnBBenhWNU5vaGhRL084dkt2QmgveWcyelhHSDBNNnk5Wmt3bW1sL3R4?=
 =?utf-8?B?RGxXWVdHR2ZxcU5GaXB5KzRHci9SaVFPTXpDdHBtUDhwcEY0YUI0MGFEeUtS?=
 =?utf-8?B?MEJ4OWZrL25YZnY5eHJMKzI5a1puYXdlcmg1aEVEbXVNWFJvRXZMWTdnbEtF?=
 =?utf-8?B?cEFwSXd3Ulo0SEVPc0grci83NTk2L3FyZDZVTzU4aTVkQUM0QldzNnVzNXdE?=
 =?utf-8?B?RkNwVm9xWThhMm9BenYxeUo3RzJtVU9mWUx6THV6bTByYVBjdkI4UnlYWGRJ?=
 =?utf-8?B?SXVjcGVGK1FCMVlaWE1PV0RTNHlYdkl5Q3BDaWd6TkFHZXFhSjI1alpwdnZz?=
 =?utf-8?B?Uk0rY1ZSdkVsbXpicVR4QS92cHljR1o5dVhvQ0czYW5iQTVaWXFBVUFmWVk5?=
 =?utf-8?B?SXhsTGJlR3B3N2FrOC9QQ1JmdzY5eHdHUTZuQkVtRk1yS1IzR0pQUWZTWXVD?=
 =?utf-8?B?QnowVjEzL2hSeHh3NjZKWlg1RWsrc3FtNUZMd0NZd0tLRjZzeTU3NU5kR1Uw?=
 =?utf-8?B?Vkw2ZU4rNFMxRkloSjJkZTRScU56Qjg3a2d4MFY1M2ZNbmRvV2pHZGZIVHZ6?=
 =?utf-8?B?OEU5SVM5UXZwRU5oK1FzQmNFNzlqMWJ1dzQ3VU9BUnB0NFBhSklCeU9BMmVT?=
 =?utf-8?B?c3FhbGFaL0RKODdjYmhIcDJLWjVoTlp6WHdoVEhFc2Z5ZkFIaTVsbDM0SkZa?=
 =?utf-8?B?dEJWa3FSZnVJVzdDUjJiNm12cTBBZW9KLzJxMWg3YmNUQ1pRVDFhMVltbUVN?=
 =?utf-8?B?Z0NWRWs5amlFaFRRRkV1VTYxSG9BVW1XR1hsS0FSbVVtSTc5cktwN2daQ2po?=
 =?utf-8?B?MytCN3NmYms0dHZ0TUpwQi9EblcwcUxpM1NKaDlveEd2eUoxeVMyK2hWQlFV?=
 =?utf-8?B?UDZrY3p5QTJEaythSzBuWlBqUFNyTldoUkV1dWdYTEdxb1BET1d5d042S2lC?=
 =?utf-8?B?YlFpWEhUeUZtRDhIYTJwdkJ6eWJ6akg0L0kwK05zb2JFYnkyYmkvVzlUVGYz?=
 =?utf-8?B?WlJqY1ZIVEFSZ28rZFFlRFZacWJnT3JBVUZReGxaSFJlelQ3eUlndzBCbzgy?=
 =?utf-8?B?ZzAvbDdCcm9aRTZ4eGo4Tld4RXZhUEU5WHgvamxib1RQNWUxWDY2dVkyb0gz?=
 =?utf-8?B?NHZQTFljT0xFWnFkaWgrRGdSRlFpMEx5VFpGR2tJSlJWaUZvcmxNQkY1SVVH?=
 =?utf-8?B?WkFWemx6VWhBSHdXczRLaXFDcUNCc0dSa094SXVybWc4U00yQUdoL3hySkU3?=
 =?utf-8?B?K1M0bXNleWxPaWNVa1YyU0JlL0ZUdUNRZ2lFWVVkUldhTFdHY2J2QWxqWkRC?=
 =?utf-8?B?UFY2UG9lRVd5UTZ2YndIZStKbW9OUm1rZi8vN1pldDZ5TS9YaE12R3ovSWlC?=
 =?utf-8?B?TWRNdnFJbkFUWWJaVEJEaW5xUGR4dE9ITkpvUko5RzdJcVM5ZXFMQ29KNzhu?=
 =?utf-8?B?T3JHRWU1U29wOW9yQ2JpSHZxR3FvUzdkcGpETEtnRGExS2tTWk1HTUJwczA1?=
 =?utf-8?B?KzZDaUtKRzRKN3duVmlxNFZMb2lxMExCYXh4VlA5TnJrbmxBSGYvUDZHK0wy?=
 =?utf-8?B?aEFJNFpsNGRJUityUVdqeFduNFlOblpmQm5xczRIZ0c5MVVHeS9oczVRTGYw?=
 =?utf-8?B?WWV1SzFvQm1IVUp3anVoQ1IxdE9QTXFNN1hXUWJHNDgvTUltdWhNclkxanlJ?=
 =?utf-8?B?MGVJN0FUQ2FrdEJkUlpBdzBLbjcraWtsZm9IYWlNVEhFQ3crYUdnNmFYOThx?=
 =?utf-8?B?ODVLQXU1UXdKTDRKVG5wMmUxMmdKOE10NklDNjM1ZEpSU1lPU25TTHpWcnR3?=
 =?utf-8?B?NjNmdzM5VmZnPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VElEc0tCL1J0eFIwSzhtRFRzZW9OS0loM2s1Ty96WC9kNnJUVVhnOVFLRHB5?=
 =?utf-8?B?b1lCSTE3UFZBSE02dGdzQ3YrdTROTmRXVENiMFV0WlM5MTRKVmN0endlejRN?=
 =?utf-8?B?Y0FQU3FUa1IzTmxpSzhmUnNYbnR5ckdJK2FvSVZtNkd0VlhsL2dNMnBXbVJU?=
 =?utf-8?B?VlFxNDFGb3BRRFNLN05YaTBoSStqN1ZiOTdwZzcxc3lMNHA5alR3Zy8vUXJN?=
 =?utf-8?B?Ni9mL0llWXk4ekUvckNHQ3Z5MW1pcEp2NDkvVWdnSWg5Q0ZBL2R6dmx2amxs?=
 =?utf-8?B?a1B1c2IyQU5Bd3V0ZzZpNlAzYzhFaVFRUHlIS2dxVDkxRGkrRWNWTmR4MU1z?=
 =?utf-8?B?WGxjd01FSGREMzFUUWFtREJtZUsvUTBWM1dFTUFNVXdZbU1JRHdnQ2hRVzhB?=
 =?utf-8?B?R21wOVZYUm9TVzg3bE9mdjhYdjhqMmVxeFJkUjJFalo4dURyNDh3aXcwZU1P?=
 =?utf-8?B?L25rVXVONlA5R1lwa054U0tSVmJmdFQ1UjBXa2l5K2Joa25RVGNnNUR0K3h6?=
 =?utf-8?B?M1JWOE5sYWh5Y2RpMWxSZTVmajk1Y0dNbXk4RjU5S080dmlaWEh1TjRhbmMx?=
 =?utf-8?B?Tk1BMW9VQ0NPam1UbzBDcFRDRlBhY2pyTVFJZUdvYmFNZlMzbElMRkxNUndx?=
 =?utf-8?B?a3FhT1ZYc3hEcnV6blcvNHgzT0h1MW5WcTI1d1ZIVlFwR3Vuemw3VGZ2cTVX?=
 =?utf-8?B?WDROb1pIWmlCQXd2Z2JvTzJrMzJMZS9sY0htb0VOQVdFa1BoVjRDd3EyaU9G?=
 =?utf-8?B?RmNwQ3VVVFNDVVYxNXk5SnVuUXNlY3VVMklhbWFUVlFhWGk3ZUt5dHdSKzZY?=
 =?utf-8?B?cEM5ZTVtczRRQ3FOalU5eXd4N2pLMlJ6dExtbURPRlYyNms5NGl5VFM0bWxw?=
 =?utf-8?B?aTBGSDFZOXl5V3VqdDJRUVFQMnE2Wjl2cG90by9CRWJHQ3orTnZ6di9KVzZs?=
 =?utf-8?B?WENXU1ZiUDFkMDVTOHMxQVV4MVVmOFhuZnE1UjdJendGL2JmcUcvelNka3lm?=
 =?utf-8?B?UjI0QzFkYzk3WlVXUkJiV3I4V1ZabkxmcTVPdm5GNnBWcktiRDJzdU5mRVVs?=
 =?utf-8?B?STFXMm1wWFJsRHJqdjNxczRTbUt5aDlGRVlGbW1MRkNVbEljd0JwSE0rekky?=
 =?utf-8?B?TEV6Ynk5Y3MwbW5tQlBVME5FQlg5MmU4QUJzOHhNTEFoQ1BnVUhvZnZtN0hK?=
 =?utf-8?B?Q1R2cE4rMnFEK3djUkd4cDlpbm9pTVkzakkySWREWnBVZExRY0J0ZlVWOFNT?=
 =?utf-8?B?SlV5MmtUcFRFc0VuRGdyQThzZTBVRFNxTE5RUmFtMWd2d0ZzSnp5MGd5N2Rz?=
 =?utf-8?B?aC9SOE1OMFZmVU5TaXNSblVocjF0ckxIMDlSQ1JZUEJKdlFPc2FRU2dnWDNo?=
 =?utf-8?B?M0xaK25Ib25xeDhnbm5RS09kMHZNc0dqNTZ3dzE2YVJVRkpuTVJNZ3RuZHo5?=
 =?utf-8?B?cHpIdnBLMkFIM2tTNDBpRmRFRUlFY2lsR2w4WVphZXFWYVl0QXVUWWZtMlRP?=
 =?utf-8?B?TkR2SEsyNjdTV1RjWGY0VSs2TWw1RE5ISStHQUpBNUJMZDZrSFRrZEJ0UUxT?=
 =?utf-8?B?TGdYTXNKdWoxMGF0SHcwUEZlNXorb2hZcm1ka2dVVEtEanBNU1REMGFHc2xG?=
 =?utf-8?B?bkwxTG1TZmtiL2ZIaytZK1NWSVJqR3NZVHZqZ3dwcEY4Qzc0MDlxdDl1Wlgr?=
 =?utf-8?B?dVRqTDVtK25LRE5Gb1VyK3BEcTVabW5ZVUxxOUF3NGVwb2hxczhvenBGYnJL?=
 =?utf-8?B?c3UyNEU2ZjliaStXMEFraUxWYUxRTjJEd3ZnbldOVVZVNTVyYjlueCswdU9m?=
 =?utf-8?B?dFhCTTIvRGU1WlFzUzBkdWV0Wm1LRnVBL0pudmlrZzNrYnk1Nk1oNzZjNmN4?=
 =?utf-8?B?YTlyYkF3RjNTdVFSR1dJc1g5Q2xNSmFKRkNpbk1QRXJSbC9LZFpKZ25Wd1c0?=
 =?utf-8?B?cHNqL09qcUMvelBGOFdWWTdBOVBud3NsSXZxa1REbFJNTmlIV0o3YktGWDkr?=
 =?utf-8?B?Nmd6dkJIRk5FdFh2NWV4OUNRZUkzRjJYTSs4aEFRQnN5eTd6WDJsLzdRR3dT?=
 =?utf-8?B?eVBnZi9ZT1dQbWZLOUcxMXlyYUEzQzR0c2NsZnY0bHd0MkxVN3c1N2cvZVh1?=
 =?utf-8?B?Z2xnK2FoQ0lES0tmaUQ1bXN3aEZJUndKbXdqODQrdUFiTlhEQVovWGlDcFBw?=
 =?utf-8?B?c1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IJXeBAT9jrgZeHKWRS2XN0u/ju1lm90XVIVQ+VRfh2dGJVMDN5Dr1c9dOBi3gam/7JBiT1/AAZ1lq+WhkItZqrAGYVBj7kBOj/wUxpvxw4+jZRTM0a/YeM9WlN95jcx8XBFew1Scs/s2TJ9LXW0DD6aI7lZMXXVj+uAE7uAX3k8eOdACwK3agB7riT2M2gmXx7yYrpCwa9A3HyEsHT8arQKysP5O4XLOrr3XrCtw8EZCyTMJUF4lsRfcCkwCy7dKSNNv8Xe5seQevH5J9eUuJxbyNmfgi9f49XkQhZLuNqU0to5AkWk2KnJ9Z6XorHJaP+HXqt6CyOzN2PoMvrfiOnlKnsjlJmYcv2bcKMu/DJEp/Hk4q9fOx6ijPybLReSUIR7562tYGAC2HgKduj3LIg/NdI0F6Kb92dcg/jLrif1+uRlnRDfZ4E0V8cGg8m4khMglKrP9haIf74zDijxcUNPY7EGEUOAhc8p80mfN1+8zUmKe6ITDOZJLkLfd7dM2cZbxrFrcEgGP4yNMShGRDsQv4VmepOji/KBFV1+Sccf19nVQH2dIvU5YYSM9PTo0Maano0GWEYVbEdoRun2F6IeUGSnW6u7XHW5vlJV9VNM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ec5061-e28c-4666-9c7e-08ddcab8f431
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 13:49:48.1037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AUVS12j39KDOEBxWrxu7dEUQ0lGEYpasIQdNzdloj6eHGBrot+D3uUohTcJajvTuBOEK6tY+WqRBuWggaAh9Bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4320
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240105
X-Proofpoint-ORIG-GUID: Klty_fBwD3BXtXfpoSoCotk6hwhx3XhB
X-Proofpoint-GUID: Klty_fBwD3BXtXfpoSoCotk6hwhx3XhB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEwNCBTYWx0ZWRfXxAXd86D03eBu
 wj8TDpHcbUus2OEmkuAngUQKHuP0Fb7NPPNmCc+5VdH01qLwHGyTHRNbVU+VTGWW0drj6vQDp5K
 oIqPGD/vtt19c+PsjI6WUpyHAL35vsS9uF0fbq5PxP9XPU1vYEXI93Kpkbos+EwnZAJ309w3oVE
 pblLzIe2P1V9fG2RrmenE1Zsddsp+X8OjlEFi9ycygska2FHAfbaFZDcWsuIr80Xq4R1RHub3pa
 +YcRNOh1nvLf17ZM/LQ1GNDnJMdPCLKXvb1CbmxwEnZMBBLgXQL6qaSsLP7IIdxxmwjjflRb8rp
 DHLhSUZou6+W3qxlg1FoFnZpIV2rm0/SYWEeCyjW7n/wOVNPlHSuJHqZXgkUb7KwrfILi0Cctk9
 4NOEul7wEYoEKfg5TdhHDyTUGNcSTYWZj5fybiG1mISoTrMM0ozb87mqODCIE3wR2VkqP6xu
X-Authority-Analysis: v=2.4 cv=Ef3IQOmC c=1 sm=1 tr=0 ts=68823a02 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=n1Z2fqEB5H9PwLWSOz8A:9 a=QEXdDO2ut3YA:10

On 7/22/25 2:52 PM, Jeff Layton wrote:
> Add tracepoints in inode_set_ctime_deleg() that show the existing ctime,
> the requested ctime and the current_time().
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/inode.c                       |  5 ++++-
>  include/trace/events/timestamp.h | 40 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 99318b157a9a13b3dd8dad0f5f90951f08ef64de..6a8bf57d649aa0909b85f09e3b5b0fbc81efe303 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2811,10 +2811,13 @@ struct timespec64 inode_set_ctime_deleg(struct inode *inode, struct timespec64 u
>  	cur_ts.tv_sec = inode->i_ctime_sec;
>  
>  	/* If the update is older than the existing value, skip it. */
> -	if (timespec64_compare(&update, &cur_ts) <= 0)
> +	if (timespec64_compare(&update, &cur_ts) <= 0) {
> +		trace_inode_set_ctime_deleg(inode, &cur_ts, &update, NULL);
>  		return cur_ts;
> +	}
>  
>  	ktime_get_coarse_real_ts64_mg(&now);
> +	trace_inode_set_ctime_deleg(inode, &cur_ts, &update, &now);
>  
>  	/* Clamp the update to "now" if it's in the future */
>  	if (timespec64_compare(&update, &now) > 0)
> diff --git a/include/trace/events/timestamp.h b/include/trace/events/timestamp.h
> index c9e5ec930054887a6a7bae8e487611b5ded33d71..e66161d8e14d9b74b0c875f0b324d24895403c18 100644
> --- a/include/trace/events/timestamp.h
> +++ b/include/trace/events/timestamp.h
> @@ -118,6 +118,46 @@ TRACE_EVENT(fill_mg_cmtime,
>  		__entry->mtime_s, __entry->mtime_ns
>  	)
>  );
> +
> +TRACE_EVENT(inode_set_ctime_deleg,
> +	TP_PROTO(struct inode *inode,
> +		 struct timespec64 *old,
> +		 struct timespec64 *req,
> +		 struct timespec64 *now),
> +
> +	TP_ARGS(inode, old, req, now),
> +
> +	TP_STRUCT__entry(
> +		__field(dev_t,		dev)
> +		__field(ino_t,		ino)
> +		__field(time64_t,	old_s)
> +		__field(time64_t,	req_s)
> +		__field(time64_t,	now_s)
> +		__field(u32,		old_ns)
> +		__field(u32,		req_ns)
> +		__field(u32,		now_ns)
> +		__field(u32,		gen)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->dev		= inode->i_sb->s_dev;
> +		__entry->ino		= inode->i_ino;
> +		__entry->gen		= inode->i_generation;
> +		__entry->old_s		= old->tv_sec;
> +		__entry->req_s		= req->tv_sec;
> +		__entry->now_s		= now ? now->tv_sec : 0;
> +		__entry->old_ns		= old->tv_nsec;
> +		__entry->req_ns		= req->tv_nsec;
> +		__entry->now_ns		= now ? now->tv_nsec : 0;
> +	),
> +
> +	TP_printk("ino=%d:%d:%ld:%u old=%lld.%u req=%lld.%u now=%lld.%u",
> +		MAJOR(__entry->dev), MINOR(__entry->dev), __entry->ino, __entry->gen,
> +		__entry->old_s, __entry->old_ns,
> +		__entry->req_s, __entry->req_ns,
> +		__entry->now_s, __entry->now_ns
> +	)
> +);
>  #endif /* _TRACE_TIMESTAMP_H */
>  
>  /* This part must be outside protection */
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>


-- 
Chuck Lever

