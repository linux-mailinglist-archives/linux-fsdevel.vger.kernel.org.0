Return-Path: <linux-fsdevel+bounces-51610-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C71FAD9587
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25DE13BD5EF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46792367D3;
	Fri, 13 Jun 2025 19:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rfJyG9qu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CfMtrjyY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C80A2E11BB;
	Fri, 13 Jun 2025 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749842838; cv=fail; b=jzYqI0jogydgLvAXk3SUDGHXshkFh7wJnCgCq4erAcsJVi15DtRjaPFX9PKsQHFOTmZd414hDdLBEYHn9HhSXinpNGwg0wO27rjtc630RQj4ETgLfmAMOVlOoBGhB37di6EYcqe9x9ZmHDI7heBP3bJuTppOflHKdg57CW8SLNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749842838; c=relaxed/simple;
	bh=MU9nnh07NLb2SbkWaeq0NShzi1KaQ81ndfO9FrPgF5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KDj3jQl8+MJ1BuL3hH2vrQQmEk9/6tGkLIdM+YLj6Wvrf6Vmj6cEt9rQp3hd3dPqep6SAlHqbMq1BKxmAdNYe29lIQv5f8fVzA/Gr0K+EKpzDAUe36e6qG9K76IyUck6Hzlg3RpQ5T1e0xYGgvKyqNv696NgjHUVQU/9mzk8jL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rfJyG9qu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CfMtrjyY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtdj8007807;
	Fri, 13 Jun 2025 19:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=o5j8h3EDdB6UMMXwlOxGUlnBGbO63voh1TZc/Mqkknw=; b=
	rfJyG9quuzjbRfEb/OycDQjBgT0gJjrzjF1L4HGn52MCJslVJAHRYHv3vMla5w07
	U5NHPf+YlGtv22ZdTHA2Tg9wGjsdrUfXFpk04QJb59r+FvUT9ewoTBOGckVZyWH/
	gl+Lqpcfn2Grd8Xp/AcCaOTDuPeeH3kCwx6ypvpn9UMBG+KiqpcGCJ4EnwHX++GY
	+08UDVyqdjZWOoYJOui6vIKHcNR0gS0hGOHafZAMZL8oy2+8cJ83jqhNUgOjHdup
	+Ndot3NKOMQxD8edXAjFqMf+Dj3z4hsF2kQzl4JTlckN4RfUjJTaYDae1K44goYQ
	IHFft/e+LR4S5MD30FDxmg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dyx49k8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 19:26:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DI2tlT009143;
	Fri, 13 Jun 2025 19:26:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bve00hn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 19:26:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ilhB8mpBjhk3j04Plj9VUlaZRvkYci35KCnjUpSgYhRFhvH+e8gRo8wVjbviFUKOqu1QoqnPjPhWdjRdwq1QGXsDvN6syZ9/BW4vVG092PPkW4hWXrQsxlhzrxebTdtjCK9/Q+0ayTCL1LmZcAeXX28uskleqzw6GSoQcnahqT8OczRU7YaftBFCNxRzHthPq1E/SCFxP6HwD+D+8XxzVJxI738uCYq8SCwfqNDwq7hMHBar1FaQ+kVloqiXzvgfB2LtyoFtLIF1Ede1QAqJ+YpnOJhjK0belwVY/yaKnEYEQmX1CF09TneiUJJzn1py0ZpXgD1d1UyNsbhRlgb0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o5j8h3EDdB6UMMXwlOxGUlnBGbO63voh1TZc/Mqkknw=;
 b=hRYL1JpF9fuoXaaIUrjiJNGz3NZnC/Zd4ZBuMvWqlMweWsvVM4a8fBKhb8gJa8uN6cqAokA2nJW4baZ3GHo2ve0BZSA91UXNeKqcdalAwsu+JT1Y6JsjV9caFPREIRValG3Ge+gRMbmXDyl5ll4bODsytptk0KjRvfa3Lco7057lgA/WV6N6muDjKU9rIk21x+fR/FdxFnLUANQfYs98sZ8qB3JIE5T2Fp09VyKRhNEKQf+AZ+b/yEkpjOCu93CL+V3v86AmRlNnrlZsn/FhH4cqtRc639twO/l8eFvEoNW/Cy/xwMeh1GVKgzhh6IZC6IvVtEu8ylv4KJz+oY4aNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5j8h3EDdB6UMMXwlOxGUlnBGbO63voh1TZc/Mqkknw=;
 b=CfMtrjyYzw/UKHJO6e66DeUSc6BqsBea1NQVa4PwnvOsfsAIBh54A6gSrYvMRK11uKuQ5isFZpb4pYaMHjuhJvdL+wUNwXK/m+QBXz2gvE8Wlqpi9Hj0WpXVe2wcTy4kgoeRRdAAHeQDzXR0fqXHB1DuoLzwgJAssCYpi1/Y+5M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.25; Fri, 13 Jun
 2025 19:26:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Fri, 13 Jun 2025
 19:26:40 +0000
Date: Fri, 13 Jun 2025 20:26:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, david@redhat.com,
        vbabka@suse.cz, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 0/7] use per-vma locks for /proc/pid/maps reads and
 PROCMAP_QUERY
Message-ID: <354bd0ae-d3bf-4a6b-b2e2-3da64ab921ba@lucifer.local>
References: <20250604231151.799834-1-surenb@google.com>
 <e1863f40-39ab-4e5b-984a-c48765ffde1c@lucifer.local>
 <CAJuCfpFCucv9+-MBtaqbA3=omb8rT2jJ5_vjdtX7DZLzN3xG6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFCucv9+-MBtaqbA3=omb8rT2jJ5_vjdtX7DZLzN3xG6A@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b986dc2-9869-4ddb-e968-08ddaab03929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?elQ1U1R2UWRuUVNvL1BiVTN0djNGQzdDYkFhOVU3WUFwNnY1OUZtUmlHaExV?=
 =?utf-8?B?MGZ1NmNUemNhM1JFbzVqbHFhR0pXbjJkL0wzeWNVV3ZxQzJxanhadjVqK1Zx?=
 =?utf-8?B?ZURrbDYyaTFUMkFoOU5GWjdnaHlkS3EyTnhIWDFITENMMU94TnBEdis1TGVS?=
 =?utf-8?B?YXhEUzBGNnhyNmpLMVhkRlJTbHg4R3lGZElMczF1bmZIKzJVSStZenFQcXZT?=
 =?utf-8?B?T3hLQjlnZVFENlBUR0tseFI5dStFM1hCS3ZkSk1CZ0ZBR0lwemUxMSt0K1lO?=
 =?utf-8?B?VFdBMG13STBicHVVUm1oLzNGNXVoMVFaWXAwMHZwUHdkU0lvZlVxY3Bza0h6?=
 =?utf-8?B?RGFDN2R4T3ZMNmtBU3ZlYjNsNEtpWDRqVzBuOVhXL1lYTVorR2V2WTN1UG9P?=
 =?utf-8?B?RGxHRzJtcGplaC9Nbi9Tb2JKeE83TmZ2NE1IY2xud08yT3NDVU1ZcytFRGhD?=
 =?utf-8?B?K25qcU9mY1hTUmZuVTlkaWVRTFBEeG9KZHV4Ulp3ZFp1ZkVhMzVXZGFQYmRa?=
 =?utf-8?B?d01WMmgwL3NQalpNL1hwSjB2S1NpM3c1eFVrNWdKVW5HTHBSZzR2bXhjTkg4?=
 =?utf-8?B?QmNrRXBaRmxGQXN0MHJQVXZ6SU9Qc3R6dU1yT0ZQaWplTEtNa0daOHFJVUE4?=
 =?utf-8?B?NklHM0tBUWsyUko3WlZhd3NKV29hN2tLbXpsdy9iWUtIbDd6Kzk2cmFJSWJz?=
 =?utf-8?B?d1p1aTVTSG1VNkFvU3dJeXdOU3poR2xzdkgyVEwyQlBMUTdJaUZxYUY2eTYy?=
 =?utf-8?B?Wlh5bjlnM0cyWituQmxkSlZQRCtjUWxQeGN4Y2xXU2Y2Vy9vZzhpRzFFN3Np?=
 =?utf-8?B?d3B2bkFMWjByR2pUTENOLzFMZDMxNy9YTEUzeUdTaFNSaUptZ2J0aDF5MW1C?=
 =?utf-8?B?U1dOTWJTTjRldlVkRWdzejVaQTIvNFk5dXQzNStjK1czODdVRXR0VWx5aTJ3?=
 =?utf-8?B?TzgyRS9lcUMzNExKWklGRFpSQUFwRVd2ZWgyV1FuSVFka2FmVUpDcVJuL0xX?=
 =?utf-8?B?SDJoUEZmUjZwZFJKdTFjM3g0MWljNVNndXAzT3VFYWUzUDBjRjFobk1pZ09R?=
 =?utf-8?B?d3B5emZnRndUMVpwVmk3d0pUZEFyZHh6dGJnTUxxVCtDb2J3MXZNZTM1OWgy?=
 =?utf-8?B?ODlkU0Y4TjNQQ1ZaWkpEcUJJMFBkWnVibkV6eERIYU5DKzdJakRwSTl6eWZE?=
 =?utf-8?B?cFNpMi9hQmVwUnJOV0k0YTNNQ0lHMXdWbFRpSHhtUU5vclNVZ0VBSXpZeU8w?=
 =?utf-8?B?eUFLVjN6bWJGaVJBQzJFTlNPbWQybkFVSURHbEQ3M3FVbllIOGd0akZPUHl0?=
 =?utf-8?B?cGdUZmRRUFN6ZDE2c3g4ZG9FMWJ0clFuQXFWTEZabUZtSm1pWW51Ym1zcWlx?=
 =?utf-8?B?aDJTdEJxUGlOY2p6ODhTdEkrREJRK05xbUNuUUxpQzJselhDOFdEYWhvb291?=
 =?utf-8?B?c2FROFpyNmVMNWM2TVI3SmtRcDdkNmFXMmdEcGN4OGlvRFVXZ0pRS0ZEWmRQ?=
 =?utf-8?B?dk5NbjB5SjZwQ0d6QXRvK2pSZVh3MUlyVTlOV0w4NzFjbmdzK1RjaVh4OVRC?=
 =?utf-8?B?VGpIYWFJSUt1UFpxUGpTbUxDQmF3QnMzeUh3TU0renorWlMrdmw0YkN6RFpC?=
 =?utf-8?B?dkV4UzBZL0RUVE4rOGxjZjF4TjN0aVNYc0JsSit3bE90L3lLR0hBczVjR0pX?=
 =?utf-8?B?U0cvUVY1Y2lkZlZvN3JqYjhvc0tnUFJGR0c2YjNhb1YyVDdIeWdJQkpFMyto?=
 =?utf-8?B?Qy9XWmZaSEZKUE9ldDUwc2hPajErVklETnFFVVRTODB3eVVDcU5SK1kxNmth?=
 =?utf-8?B?ZXpBOXFMRkJCMk4rN0RFTUpxU1JnMkVnenJmdmYxSEtUUnNST2NkZDJsYm5x?=
 =?utf-8?B?WnJKSDZkSE1LSFlZVGZxSXQ1QnBaN2xqTUFYQXdEN1NES05mWCtGT09zbXY4?=
 =?utf-8?Q?abqVeJtUZtM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWhqR1QwNjBkNG5hNGQvbktvZko1dzdOWlJ6dXd2TzVjSkxDYTZ1ZXhvQ1hw?=
 =?utf-8?B?UHdRTGxVNCt5RFFYd084SUZlL3dPa01KVjF4NjlKbDFBbERtV2RrNzVhWVZq?=
 =?utf-8?B?MzY4UmUwV3YyZG1LU3AzeFV3Q0FJVjdCdnpjVkdid0lNYjB5Z2NUbUw2VFp0?=
 =?utf-8?B?ZzJ1Uk5wdWhwT1E3MTduTS9zN08raDJ4dkw1RHZ4TmdsNE91WmdmM0orTHJl?=
 =?utf-8?B?ODlzc2tXQVBTc1R1RkpCZ0ExcU5ZMFRiazFmZWo0QytUM3Nxakpnay96cXRB?=
 =?utf-8?B?N3NldndaZnFFVng2REo3ZEE3MElVOFhncGc5YlFnUmhWcXdXMFdISm5OLzh0?=
 =?utf-8?B?Skp1dEpQRnVnL09zclBUd2VuYnlZSU90Qmo4YXJFM2Q5Vmw5NHlhNG91cnNt?=
 =?utf-8?B?SUM5Rnk0bU5YS3B1VmRBdTFoODFRRjBkUDk0bWlxYUJhMldHdDNkUldZZWdJ?=
 =?utf-8?B?RFJ0TzdqWkRrY2EwRDBXREIrcEZmMFpXTlFZbVhBbHk0bTRUZERTN3dHMU9J?=
 =?utf-8?B?N056M21aZ3V2OVRWRzMyK1UwTFVLazl5OU9Ua0xXWTUvUVNteDhiOHpha3ZI?=
 =?utf-8?B?eU82UExOM3hvVWREMU1kYVRVMU5wbkhva0ZTVDJEU1FPU0lKRnZPeHlrbHQw?=
 =?utf-8?B?d2FBeEZ2cDhzWWQ1eFhJUVJ5L3dqN1ZLQk9yNHRORGZuKzBPRWUyVDZaSEpz?=
 =?utf-8?B?MkJGUG9POXZsWUVuV2RmeHJHOVlabHh3aXlqUlpULzd2enpIK0gwUldzcHVU?=
 =?utf-8?B?dzFBYmZBcjZLdGFjUFZ0VURVcVJNeHZvNUMvdis1Zy9MQ0U4ZUtic2RhSm4w?=
 =?utf-8?B?cVZESXBpVGxwN1YzVXVwMnNzQXJWdEJJeWpySW4wcmlCRmQ4ZFVIV1FpbVdj?=
 =?utf-8?B?VklyOG1GVWFmMFphaW5oc0JDeXB6NzNrakxKNGk1S1dmUFpPRlF5N3NPVEVi?=
 =?utf-8?B?ZC8vQ0k1eHphNkpPWnBHeVZHL29ZakFpN3hXREhpbzlqQTNBT3pZanhLbEtj?=
 =?utf-8?B?Q2FVVzhZN3BWZ1FBNlNPNW9FaC9JZlNvKzdZWXh2bElJeFRwYXBpY29JdkhN?=
 =?utf-8?B?SEhWKzlXR0xRUTgrMUkzL0NRVkYrSldNNjF6OEo3dzhjVTJRRk5rTlJxYjgv?=
 =?utf-8?B?bHhtcEZvTlF5Y2F2eEFCYnVmdWdMcHhIQThQeUlQam0xSFlnRUpEbTFPV3BS?=
 =?utf-8?B?ZDFUbG1NUWdlYklxM3dHY0JqSkNmTUJZdHNaQ1g2MXFZY0hwNXlwSmJLT0dF?=
 =?utf-8?B?VFFraE9UdFVnZm9HRjZldUpsVEhoaFk0andBU2F0cVBacmc2MVhLeW9aZ3Rx?=
 =?utf-8?B?NXc1dEpEN1ZCQ3dETmNFT2lCcG5zY1Q4SlE1UUtVazI1aEkyaFJnZ1ptV0NY?=
 =?utf-8?B?TjZ5R2NFME5UbjNVNmMyRmltNThGT3RkTjltb0FZTTBRakJzSkdQeWhRTG1w?=
 =?utf-8?B?K0plV1hDL1hjQXliUzQ5ajRVMTZhaHFVR2NBMkN2TXpjbUZ1VG1SWmNiZ1VX?=
 =?utf-8?B?eG1ibENvMVJRV2ZuaGVkblAzWHd4YTNLcDRqaStMK0JKTWh3QTA3OGhOdlR6?=
 =?utf-8?B?RWF1aXhCTnhXbkR1alRJN29vSVR4QWM5cWprVyt2ZGNOaGNLU2d3ajJoVU96?=
 =?utf-8?B?YVFLemllb1lnS04zZFlndmREOVN5aDNCUjRwT2VnTWlYTEp1M1BXQWVSMEs3?=
 =?utf-8?B?YUpUMU05eWpWM3NqRDFMaDVWRjZtWmQ2WDd4d0JVMGFoUHNZR0tWa2p4YmNj?=
 =?utf-8?B?TDFXRjEwZC9TZ3AybWcxS21NbDFBdnZxdjRnelBxMi9uMHlUQWNudFRzODRp?=
 =?utf-8?B?VlpPOFp2ZGdsWmowTy9iQThraDZhemZCUXVvZC9ma1NENWZiT3cvd3JkdCth?=
 =?utf-8?B?bFh1ZUp2ZS9hSHpOMWtyWjU4VlJVdXhaRHBXTFhUR3JFTDdZTStWSlhxQlN1?=
 =?utf-8?B?TGtPVm5YSlBycVd0ZSt4cC96U2Fmd0NpMHRXR09BdjJXNGRzaXV6b3VsY0Zs?=
 =?utf-8?B?VmI4Tzk4enZvUWEwd0hYbDJtWjNkOGIvcjhPVjJQcjI0Sko3OVp0REcvYmZU?=
 =?utf-8?B?WmJ6NWFVMGk2SzFnZzNRQkVyaDRiclZ6K3dSb0NaNU9BV3hVYWpFRVRsdHV4?=
 =?utf-8?B?SmFrQlhZZFFkS1M2SWxlU3R0ZHJuWHNTTEgvTVplOCsvdmVxMW9oWS9KVVlJ?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HqLC6UwaW9ZDRMOTEWC1fQSklT8qV3InIGwDMrqRYyhZXiJPedyb7df/haxRitF1ngli8cGVpz86RlzGm1uzrlHsnRmtXOUApq6JJhCotP+a3Ur2GoR8hQRbKvaINqDwm8RnF6yPzqfJxLCE0S9fwAiD4Hoq46S1NHrGyaqVQ2jeq2LjqiUXqw980hv7Q9sJsNOYsAkcty2sUWyvldV3SrSrZiWYGqPgKsAj/3pfJDmca+Mf190eaofHpti88q1XNIFnJmCHk4DdeY7VXQ/KBZBBLQgejuT7M1IDR0S21e5DzLDWtgK9+g5w5U2yyrEFWwT+RNtqP8VehNn/tUhhfH7oWGauWyvO5IbsE+0mK/amU/yns/qWVQdl5aiKNERRyaIEaHZtIoe6kRuyV67TWW3zD7DEz8yZxvAzpo7+E36wD1+xQAc4rpwFBPhoS5Dx4/aSKCIXiPzExAOF14Br2RZQqECZ60Af8P0aO6GsL6BamlLC/xiPHxL7GrF+neQEiCnV8cGTToM/V24p9aB/dV6z2s7Nw4wBBpqhHHctwAK7wmlbqkNTWHg27cTnz4oNROxS4ipX+3HYl72lNgQERRGdXLv5SYsfvhw9H+iTcPw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b986dc2-9869-4ddb-e968-08ddaab03929
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 19:26:40.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZOsEiuMl3fF3YQddv1uoAeH6hNCkslUbXmAzA21fXxSSzix9mPOiUZYC60mGnOGtGUlxQ2lfQVrxaU1wY9d5REyMoPVP9CTTH7cA36anGps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_02,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130134
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=684c7b75 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=gFByTg6iKWpDhtMB6LMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13206
X-Proofpoint-ORIG-GUID: tQrZVse2a3JkVGvV-qUWjGMb_ojNJV4u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDEzNCBTYWx0ZWRfX9CIdHisl0cQO EsGJzvuPB7WBQH4MPSwd2eK4R2QYDQHqBVuOkERp+qn3HMYUNQ9KFSuqr8uZ1iat0bjbMNxRihe a7MSscmcaJO38ujMooFZhK0kXUe0RHcjhYdGPE1lssg/vG28ycFsYiaZxt6qkzPJ6GYVEIRNudV
 LNDAXVHmMZhSOI8BpXlzmo50/iETSrnD+Wd/ADhL6m/mrx1tPX7cTaIfwfCXKhSXbismJBldARt /PtGQzHLPk5Pp9qvrel+W4ScQ6qyc2B7geRD3HF7vCsYNmIglID18K/7XaaC9N3795JX4oWnuFY eiA6jifx3ACLh0/IkRzevkfBxc01ancwrD0XufQha6ym9uV2HEtKW3Bdc6D/9BIoduiulnW6idy
 Ig4+yYaJyLG9gkr5n40fkqQdYHIpSHceOBm2runINxGALO62x/6x6vwk9l4CW4/qW89FYcT8
X-Proofpoint-GUID: tQrZVse2a3JkVGvV-qUWjGMb_ojNJV4u

On Fri, Jun 13, 2025 at 12:11:43PM -0700, Suren Baghdasaryan wrote:
> On Fri, Jun 13, 2025 at 8:01 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > Hi Suren,
> >
> > I promised I'd share VMA merging scenarios so we can be absolutely sure we have
> > all cases covered, I share that below. I also included information on split.
>
> Thanks Lorenzo! This is great and very helpful.

No problem! I do intend to look at the tests here too, but I just didn't
have time to get to that this week.

I don't think this should block the respin should it? Anyway hopefully I'll
be able to take a look next week.

>
> >
> > Hopefully this is useful! And maybe we can somehow put in a comment or commit
> > msg or something somewhere? Not sure if a bit much for that though :)
>
> I'll see if I can add a short version into my next cover letter.

Thanks!

Liam suggested somehow integrating this into our VMA userland testing or at
least as documentation there, I will put on my todo :)

Your replies below honestly make me feel more relaxed about this change
overall - it helps us really identify the known cases (Donald Rumsfeld of
course would tell us to fear the unknown unknowns but we do what we can) -
and if they are clearly thought out and confirmed to be safe then happy
days.

I wonder if we ought to have the tests explicitly try to trigger each case?
I'm not sure how practical/useful that would be however.

>
> >
> > Note that in all of the below we hold exclusive mmap, vma + rmap write locks.
> >
> > ## Merge with change to EXISTING VMA
> >
> > ### Merge both
> >
> >                       start    end
> >                          |<---->|
> >                  |-------********-------|
> >                    prev   middle   next
> >                   extend  delete  delete
> >
> > 1. Set prev VMA range [prev->vm_start, next->vmend)
> > 2. Overwrite prev, middle, next nodes in maple tree with prev
> > 3. Detach middle VMA
> > 4. Free middle VMA
> > 5. Detach next VMA
> > 6. Free next VMA
>
> This case should be fine with per-vma locks while reading
> /proc/pid/maps. In the worst case we will report some of the original
> vmas before the merge and then the final merged vma, so prev might be
> seen twice but no gaps should be observed.
>
> >
> > ### Merge left full
> >
> >                        start        end
> >                          |<--------->|
> >                  |-------*************
> >                    prev     middle
> >                   extend    delete
> >
> > 1. Set prev VMA range [prev->vm_start, end)
> > 2. Overwrite prev, middle nodes in maple tree with prev
> > 3. Detach middle VMA
> > 4. Free middle VMA
>
> Same as the previous case. Worst case we report prev twice - once
> before the merge, once after the merge.
>
> >
> > ### Merge left partial
> >
> >                        start   end
> >                          |<---->|
> >                  |-------*************
> >                    prev     middle
> >                   extend  partial overwrite
> >
> > 1. Set prev VMA range [prev->vm_start, end)
> > 2. Set middle range [end, middle->vm_end)
> > 3. Overwrite prev, middle (partial) nodes in maple tree with prev
>
> We might report prev twice here and this might cause us to retry if we
> see a temporary gap between old prev and new middle vma. But retry
> should handle this case, so I think we are good here.
>
> >
> > ### Merge right full
> >
> >                start        end
> >                  |<--------->|
> >                  *************-------|
> >                     middle     next
> >                     delete    extend
> >
> > 1. Set next range [start, next->vm_end)
> > 2. Overwrite middle, next nodes in maple tree with next
> > 3. Detach middle VMA
> > 4. Free middle VMA
>
> Worst case we report middle twice.
>
> >
> > ### Merge right partial
> >
> >                    start    end
> >                      |<----->|
> >                  *************-------|
> >                     middle     next
> >                     shrink    extend
> >
> > 1. Set middle range [middle->vm_start, start)
> > 2. Set next range [start, next->vm_end)
> > 3. Overwrite middle (partial), next nodes in maple tree with next
>
> Worse case we retry and report middle twice.
>
> >
> > ## Merge due to introduction of proposed NEW VMA
> >
> > These cases are easier as there's no existing VMA to either remove or partially
> > adjust.
> >
> > ### Merge both
> >
> >                        start     end
> >                          |<------>|
> >                  |-------..........-------|
> >                    prev  (proposed)  next
> >                   extend            delete
> >
> > 1. Set prev VMA range [prev->vm_start, next->vm_end)
> > 2. Overwrite prev, next nodes in maple tree with prev
> > 3. Detach next VMA
> > 4. Delete next VMA
>
> Worst case we report prev twice after retry.
>
> >
> > ### Merge left
> >
> >                        start     end
> >                          |<------>|
> >                  |-------..........
> >                    prev  (proposed)
> >                   extend
> >
> > 1. Set prev VMA range [prev->vm_start, end)
> > 2. Overwrite prev node in maple tree with newly extended prev
>
> Worst case we report prev twice.
>
> >
> > (This is what's used for brk() and bprm_mm_init() stack relocation in
> > relocate_vma_down() too)
> >
> > ### Merge right
> >
> >                        start     end
> >                          |<------>|
> >                          ..........-------|
> >                          (proposed)  next
> >                                     extend
> >
> > 1. Set next VMA range [start, next->vm_end)
> > 2. Overwrite next node in maple tree with newly extended next
>
> This will show either a legit gap + original next or the extended next
> with no gap. Both ways we are fine.
>
> >
> > ## Split VMA
> >
> > If new below:
> >
> >                     addr
> >                 |-----.-----|
> >                 | new .     |
> >                 |-----.-----|
> >                      vma
> > Otherwise:
> >
> >                     addr
> >                 |-----.-----|
> >                 |     . new |
> >                 |-----.-----|
> >                      vma
> >
> > 1. Duplicate vma
> > 2. If new below, set new range to [vma-vm_start, addr)
> > 3. Otherwise, set new range to [addr, vma->vm_end)
> > 4. If new below, Set vma range to [addr, vma->vm_end)
> > 5. Otherwise, set vma range to [vma->vm_start, addr)
> > 6. Partially overwrite vma node in maple tree with new
>
> These are fine too. We will either report before-split view or after-split view.
> Thanks,
> Suren.
>
> >
> > Cheers, Lorenzo

