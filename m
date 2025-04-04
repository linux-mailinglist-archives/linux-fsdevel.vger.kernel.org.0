Return-Path: <linux-fsdevel+bounces-45785-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C524CA7C236
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 19:13:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 453DA3BB4D4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 17:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32121577D;
	Fri,  4 Apr 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Bwvjtp9F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VuBwdN4N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05459214A76;
	Fri,  4 Apr 2025 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743786759; cv=fail; b=eFfVtt+oPy9abQ9Wu3IHyMcP70GqrJOHElJkkwl0S7s/19m/W07pyNWmm7ZsQc1U9kqurX2gZOJZCdp86b5zjkvErHlXMBjCFsUGRIiWQyYxb4p6RzOuRRrbO0henOK51Nxb6R7uNTwzOa9XjEG4ckkzdp56gJZzQNpk7nPDQN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743786759; c=relaxed/simple;
	bh=3IvZQhMsZtoUpT9pOXL3p+mdUoYSuTxpT/bOC4VzDb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fj0o/ygvghe07U3f7ycralzWmW+U7W1xKC6PhUDvYwbSfIXFF6YCXf4IvH5A7cBUrdRDQAfyWI0IOGiLTyx69UVbjTPefvOOmZxQnCMTWvmBa/zlReZIgyWROnk6P8RRYGlDOaQrQR4ybR5VtsjjpWata/ZnWOn9tkyTlxu5iO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Bwvjtp9F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VuBwdN4N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534Du4Av025527;
	Fri, 4 Apr 2025 17:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=4kqeVMWNjOum2nGnJ6
	WYm5GcIBAeXIlhxnmFxtvtcjg=; b=Bwvjtp9FkGpilsBCp7DYJM9sLjpQYELvPb
	J0FNDX85XlgVinp0EiX1uunKLFdZj739poGGFLymKP+6pK+LOWog9aqO2wPuOaMN
	7WmZAyacygJOTqsrpLPh5PCb87xeYVxi7L8tu/MXuM9CCo7d2nFUZPDYr2tn062z
	xNMJhOgoYs53BV31TYNb1xv13Fn8h47m9XTP5KIUBxQFxtUxSOl1mSsd/kwz/AYC
	OFeRjqTfdMNXQxKb0XMx78Aa+KhHn48uwXHbibYK1M/JgYL7oBKCwThlorZgddI0
	9BTfsUCwJpu0i7xpgPS6qoYdzQJ2kB9YY0OMDe9j9wC0L/G5fVKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7n2fs8g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 17:12:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534H2xmO020723;
	Fri, 4 Apr 2025 17:12:11 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45t31x9dje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Apr 2025 17:12:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jauvxgyyDwAH29RdUgKizi78aNxwKH0G9LPi6QRmnUOib0sCN7vbf8HyhapGoIDbZDZ/avwqcw8W9sZ3TYs7pzPGJwoRtA2IZr3Ptp7uslIAbKOmtLMTj8gEw3J452N/eY1mXsuZpjA3NucvnNAVUne7alPwZ/Tp/PLaJ8uevpt3gwqmCutDsnQ63zZuvBxPMOO6ZHgBkeeZ7CeXx7y4xHaFMsMqnfaq6wR6vETQXt3PLiRHQUuWRNIcFYs/guHsoEBVpdT2AU3ujh3HEzrED9WRzYxibV/RCx4/ztEoiw4BsDBUY21rNVGvpAHTvvVTN0N+nEA/oCtgfu04C3HsJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kqeVMWNjOum2nGnJ6WYm5GcIBAeXIlhxnmFxtvtcjg=;
 b=BF21n1nRaN/zz74Cmn5SJnBP2XEoEGOOGhirkrI+yDBnjorL+fMD0aKJz8xMg1jAgBw5p8SqRvhILkxWJtTPIa043wyeD525A+ZIb0uhOLaA1/3zz1zs9Tj31S4ptnwPHNED+kfEcOTSn+ROso35yiqKoZpueu3p7JTy9Lgyn1ToTgHDnBVpR7xa+XEljorHugKBmq9k448vp9ofT4wNT0T6C6umIfInz+fWPlA2FgavguUhcPP/brOXyKnJ3SnTaHHOsvH4STykobDDYpu0edVrZx6rLvFYOWR1+VfqVXiDZu7oiLSE5S+dxZstGligAWFFeM1+v7JO5QbDkk71GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kqeVMWNjOum2nGnJ6WYm5GcIBAeXIlhxnmFxtvtcjg=;
 b=VuBwdN4Nd9H7EJUSqJT3CqD3O1pfnJDuO9Y3Kb6tJKm31XLOyksuR4fPmmlkCe876oMvSGeFo4MyXSbEA7YE5pFj5ZV47f47qdJKfvcB20oJbUnSX07aSrGn+qrKvVmT+dZdqM+3/7EKlo6NENgldkyDc1mdP6mahN1mnebLL0Q=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MW4PR10MB5728.namprd10.prod.outlook.com (2603:10b6:303:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.41; Fri, 4 Apr
 2025 17:12:08 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%7]) with mapi id 15.20.8583.041; Fri, 4 Apr 2025
 17:12:08 +0000
Date: Fri, 4 Apr 2025 13:12:03 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Nikita Kalyazin <kalyazin@amazon.com>,
        Ackerley Tng <ackerleytng@google.com>,
        Vishal Annapurve <vannapurve@google.com>,
        Fuad Tabba <tabba@google.com>
Cc: akpm@linux-foundation.org, pbonzini@redhat.com, shuah@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, muchun.song@linux.dev,
        hughd@google.com, kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz,
        lorenzo.stoakes@oracle.com, jannh@google.com, ryan.roberts@arm.com,
        david@redhat.com, jthoughton@google.com, peterx@redhat.com,
        graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk,
        derekmn@amazon.com, nsaenz@amazon.es, xmarcalx@amazon.com
Subject: Re: [PATCH v3 0/6] KVM: guest_memfd: support for uffd minor
Message-ID: <2iggdfimgfke5saxs74zmfrswgrxmmsyxzphq4mdfpj54wu4pl@5uiia4pzkxem>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Nikita Kalyazin <kalyazin@amazon.com>, Ackerley Tng <ackerleytng@google.com>, 
	Vishal Annapurve <vannapurve@google.com>, Fuad Tabba <tabba@google.com>, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	muchun.song@linux.dev, hughd@google.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, lorenzo.stoakes@oracle.com, jannh@google.com, 
	ryan.roberts@arm.com, david@redhat.com, jthoughton@google.com, peterx@redhat.com, 
	graf@amazon.de, jgowans@amazon.com, roypat@amazon.co.uk, derekmn@amazon.com, 
	nsaenz@amazon.es, xmarcalx@amazon.com
References: <20250404154352.23078-1-kalyazin@amazon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404154352.23078-1-kalyazin@amazon.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0279.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::17) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MW4PR10MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: d65d3789-d71a-4971-6d04-08dd739bd46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oIuHBlFwStP8wV8rSHEOLk5XRkkS4BAx4N05hf7rzfzFwpnDbbbykrFXDf80?=
 =?us-ascii?Q?X5kBOu7OTtbkl2i4Gj8unWl2etBrzHGcw0HgaDncNITN6B7UWoKdsB9MN8KZ?=
 =?us-ascii?Q?gTEVam4Lcj/rdU0cczwtguP0keX2iG+wGAF7k7rjfwdhNrkzq8eSgc0yo4s0?=
 =?us-ascii?Q?KuwCI/0f//YgZ04mD0gMySj8AGYI1259EQ2jgSJewcJOunmOBSCUhVthiOHC?=
 =?us-ascii?Q?xrAFSaBF30fOoRaJ3AlaocgUyejZOwpZxz0e4lCBrDJCxOLllA5vYKJOkJh5?=
 =?us-ascii?Q?2g0WdpXc8WuzVT07VlKOkmxYYV5tYTVQVJ7dpHYxdmbIn8sA+o2WCKjzXAXC?=
 =?us-ascii?Q?b1Sjvkz2d4XzElBMgeus8jyLuB4L31tkE23VzZV3qKcqBDDT7cYFeQysoL7k?=
 =?us-ascii?Q?sJXoe/6no6eN/rOXgzv6NnH33Ww7vBNBvy2aIEOQFjay6HXZDnAu4ugcUkRb?=
 =?us-ascii?Q?QjE4Se2JWU3BcT0/C87voagTHn0uGxFnYfnnM5bgxfnGLFAgcuvdTdrW5VoC?=
 =?us-ascii?Q?lhKoedOqNq5xYr46RM+iUZpTVRboqXVQojj+bGdPEqRLZrS0Pzx8T7UFfJnt?=
 =?us-ascii?Q?fnM5SYkckk0S1SNzleo5i2fDNNR3harxlOuFODZLqDzTR6uYNdBtDD8Ko3VY?=
 =?us-ascii?Q?0J5in1R0QiNttSlRmCpiKsRHqktypf4NB8auedlM370oH1wjWiykSvHYeRox?=
 =?us-ascii?Q?IC9E7h/yt5taEOwPoV7k3pkxP2yJcmAKLwUbUzyTr4NH41qitmNP/SGc3fU6?=
 =?us-ascii?Q?mMTqu/1pHVqUKHlIfVf9GQiRHmYIyRvM79J7gTTfFpiyglrgjsDLf2Uq6pC+?=
 =?us-ascii?Q?t94nJFhNNp9iDVMwo0ojwxBGFxXdL1PAAFVaUOki4KN3Hk7peg2mc2QmfYYY?=
 =?us-ascii?Q?zfOMdN1cKh5DafbK9oTpKMvq+1CeVYmrBXXnAytRxOFG7Gvr8tV5xFdj+g+f?=
 =?us-ascii?Q?oyXHlZGi4GkgHCVXVrGVtVl8mGopkzdSi5nsaw02Ep4gDIa9l8soawnVxWzM?=
 =?us-ascii?Q?812U3QF7AX9SbXYLNM/60wHHa8zvdkUmtdnkbTp/7RwCWuINuAP/uctOJypu?=
 =?us-ascii?Q?EE2hwkjDiGVYFGBkHULuk8uHzd0sMkWRTY1DgByJ/BmurguDltpa0NTTqbM8?=
 =?us-ascii?Q?OpSjQOIR4B7jgWvvc8nKVbv7LZCd/dKUgQgG3siZxknIFg1445e++MS0xtbC?=
 =?us-ascii?Q?CmCNuYmf9NGEDDRYlZ+Cjcp4aV3vzUUx5sbivAj0uqp96VwJTN4dVAxMjj2y?=
 =?us-ascii?Q?aVa/c9y4WGuQxWcWpariAEs0hlysl8Kgqh8dL6MxBQNaphBI8Ye5aXjzAVcH?=
 =?us-ascii?Q?ArkvTPf7ej+b+lfGJ+hw3psnvHs+y0oVrk2HHFBe0IIJOg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JlfpgnOxwPHCAZ+bgOlfZcnQVqHP5AsXDX5XCzYXitofd4h03E88f6pY0A2Z?=
 =?us-ascii?Q?CTzDJUgsiFDEJdctMTfK3RRZW5FtRiRTLqupxeI5Od6IOe54JIbXVUDyzV6D?=
 =?us-ascii?Q?yjzbyQfqltprcqZc03+u7C4dz8ClQuI5GnvN9SohZEkAaCDvLnpw9vqlrgeI?=
 =?us-ascii?Q?AoaVHnfiMzSC/84GiceF3UTVeWVEOe5Cb5r3QDA+nZ1EBX1IYcTwc445cpn6?=
 =?us-ascii?Q?/bV8XvLQkY+ByPDC359Wy9ErXMWr/pOIb5SJQ+AH9kyjmp3NZ5oKoWp/Uhu1?=
 =?us-ascii?Q?YVnL9SKPREfY26KbuOMOBZrvsYsSCZxaEGE+mSKOV1vIqjoQKxjK0H05NHjJ?=
 =?us-ascii?Q?bQJsHrtuAsev0g8UxOjHK/zFLkv07xFQgnw+Gxlq2cJ3L5G9WVkuFB9T7iDz?=
 =?us-ascii?Q?vz9XavqWa2R0sOuxdhvgAm1DoKk6eQ1rb491Hq25nYJaYFnG6HlS/Pk8FPr5?=
 =?us-ascii?Q?75/hBbT6JGqHlKnaVhLfWVoG+e2urNwr/0DcniWRL7tAdAqsGnqcoWXspKud?=
 =?us-ascii?Q?XxQZcyP6jhCq/6vvzJ3vPeGVrKvrH/TJ+GFt3D6dmmOIJ+GwvJ+TO6QOMX0z?=
 =?us-ascii?Q?6zkIYgkUJSHkv8QslL2MppvGuLx+HWXhyUR5AuQKlHJObrB8xyYLHusGm7Hb?=
 =?us-ascii?Q?aBl43wMvO+KHmXzVHHNYRXu/IQfz7KXF7RRwB36bja9QzquS7lOmXcOwOXVn?=
 =?us-ascii?Q?97pKoS7xuWGMiSSzcvANHXAS0C+NPkY+NwyKFR4t7cySjCM37NcAKfigriIy?=
 =?us-ascii?Q?jxayz716kRkeErch//GnC+bo7tRFOTxlqFO7ljm4QO1RTkp22eemUaVRlQoZ?=
 =?us-ascii?Q?qJx6WXnSQDQLT0ZGE64YyBMVK+zS7odAXMxQ3Lqb7DgzH+Q0oKbg7g1u903Z?=
 =?us-ascii?Q?Yw2FOUtqvGLSS3tgQgylD17OX/Y6qtRX7xHko/YxHtYyUildna0w4yisMueR?=
 =?us-ascii?Q?VbuFXQE5Bt4y1wrJSlrjb7z1+2H5TaHuGmpKxhlql0YNJ27rzjdoLDYqL4S4?=
 =?us-ascii?Q?f4UBF99/85sJ5k/QM3mhAJQQLp6GdhlfozHjJdi3QfGu0lDQEMebGn3ra0VI?=
 =?us-ascii?Q?EMc9EFC1dnvP/dJcuKCB7LxhHRn4Du5GzHP31oSgsUViCcsmkygYNrIrfhEP?=
 =?us-ascii?Q?ioJ0vR0GWFvrdLa0j6yTLS5P5NiM9Ax+igV6hDdwQ7x5X58hWfFcWVioyEt5?=
 =?us-ascii?Q?QdsvMPmg+vqS/lJboY/SpPPpMp2IfenF2Fexdh3Pt+pCLD9n40e4W606rRGV?=
 =?us-ascii?Q?VOop2VEkCOwO2dQhva8qn88J8lSGQoGdyXre7U7OZcMDDdEfi5OBKbuhSjvC?=
 =?us-ascii?Q?cNPw5R72HchYu04Wv0KBI1ZHkiFMTEvnLcm6qGJ9FKVtph1FgSChtSbSNrrG?=
 =?us-ascii?Q?PsJYOJamzs2OFOiik4yIKcW8jygN+BzIBU+vozVgT5ivRBKNg1MKppwWHijf?=
 =?us-ascii?Q?VkCA8BLe6B1LPfCK3Ale3ySuZFFq6kTxp9ebYHVzMNAoNtMuPD6TBDkRzGBv?=
 =?us-ascii?Q?aX2pPSE7QQ0behEjWjgrW53uJyLIWZGruwTygN0o1LyWWyWsNY1e+8iy2hwP?=
 =?us-ascii?Q?b0fXwVlDofdya0kCBzFjty08AcigowvzCU4Au4/Z?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nE8SHnTDBHT6vJAGEBLAikH2dyj78fugbVmqgAx4z4KfAeM3xnJCsqwbgip0ECKHV96LoTJAjIqIb2UWBthAcjdhqhdxY6HLjZrABbm1NYMXKMEm5BfHMNAqvP8CbMtEc2cP+O8EmRGCXQcgxm5beYpTEbAuCF+vV59fhrBOnijC6xU/fw81JzE9j7hlbwVbOQ5g5dik6XtYBlPZLSu/cOG5GqaMFU/F1BlHs5wMBUwgc8bUs8uMvE7m7zbYi38mOT6OE3vLT98allTSm3nXzWXtD6/YjY0mhiiRdrU9iLGd0hQdZP+/bDF0Dc8NL6gk9Dq8u4pB1WgQ4iXog/djwdM0Zr9QKWEiC69RpUtqd9Klg3dSw/hHqqkZ4YnE5vYVerYXeZK3+jvtqrU0wfP5u2dsD6iTXkyRm1fYL2P3ds3JM62pX7FCD+zf84Xo1v2YHClu/Ozdzo8cQ1JHS3kAYtqGEUod4m0QswvAF2+2pStuvxK51tkLSW3tH6WRXApGFUR036wzRqXWVJMJsplGY5XzCF5zsrkmlMY952hERz6ms8t8PuvTLIwHTYeLMoWJSmbxPKDpLbFbY1JOUZ8+ejH1dt5ug6z44RyRZd4s+Dw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d65d3789-d71a-4971-6d04-08dd739bd46e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 17:12:07.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JOPPSyCCP0eLx9cdA9dU3mPrfc4GXriVG1Jwngyhv89YKinCU42wrPmp2smCGjtcUMRVMpuOrndtwQaO3ivteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5728
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_07,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504040118
X-Proofpoint-ORIG-GUID: MrB6wFm4PKddB7A8-Arup455AnKXNWhq
X-Proofpoint-GUID: MrB6wFm4PKddB7A8-Arup455AnKXNWhq

+To authors of v7 series referenced in [1]

* Nikita Kalyazin <kalyazin@amazon.com> [250404 11:44]:
> This series is built on top of the Fuad's v7 "mapping guest_memfd backed
> memory at the host" [1].

I didn't see their addresses in the to/cc, so I added them to my
response as I reference the v7 patch set below.

> 
> With James's KVM userfault [2], it is possible to handle stage-2 faults
> in guest_memfd in userspace.  However, KVM itself also triggers faults
> in guest_memfd in some cases, for example: PV interfaces like kvmclock,
> PV EOI and page table walking code when fetching the MMIO instruction on
> x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
> that KVM would be accessing those pages via userspace page tables.

Thanks for being open about the technical call, but it would be better
to capture the reasons and not the call date.  I explain why in the
linking section as well.

>In
> order for such faults to be handled in userspace, guest_memfd needs to
> support userfaultfd.
> 
> Changes since v2 [4]:
>  - James: Fix sgp type when calling shmem_get_folio_gfp
>  - James: Improved vm_ops->fault() error handling
>  - James: Add and make use of the can_userfault() VMA operation
>  - James: Add UFFD_FEATURE_MINOR_GUEST_MEMFD feature flag
>  - James: Fix typos and add more checks in the test
> 
> Nikita

Please slow down...

This patch is at v3, the v7 patch that you are building off has lockdep
issues [1] reported by one of the authors, and (sorry for sounding harsh
about the v7 of that patch) the cover letter reads a bit more like an
RFC than a set ready to go into linux-mm.

Maybe the lockdep issue is just a patch ordering thing or removed in a
later patch set, but that's not mentioned in the discovery email?

What exactly is the goal here and the path forward for the rest of us
trying to build on this once it's in mm-new/mm-unstable?

Note that mm-unstable is shared with a lot of other people through
linux-next, and we are really trying to stop breaking stuff on them.

Obviously v7 cannot go in until it works with lockdep - otherwise none
of us can use lockdep which is not okay.

Also, I am concerned about the amount of testing in the v7 and v3 patch
sets that did not bring up a lockdep issue..

> 
> [1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
> [2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
> [3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3

If there is anything we need to know about the decisions in the call and
that document, can you please pull it into this change log?

I don't think anyone can ensure google will not rename docs to some
other office theme tomorrow - as they famously ditch basically every
name and application.

Also, most of the community does not want to go to a 17 page (and
growing) spreadsheet to hunt down the facts when there is an acceptable
and ideal place to document them in git.  It's another barrier of entry
on reviewing your code as well.

But please, don't take this suggestion as carte blanche for copying a
conversation from the doc, just give us the technical reasons for your
decisions as briefly as possible.


> [4] https://lore.kernel.org/kvm/20250402160721.97596-1-kalyazin@amazon.com/T/

[1]. https://lore.kernel.org/all/diqz1puanquh.fsf@ackerleytng-ctop.c.googlers.com/

Thanks,
Liam

