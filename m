Return-Path: <linux-fsdevel+bounces-47353-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 288B4A9C6BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385D51BC0D96
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FC323F28B;
	Fri, 25 Apr 2025 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EWK8IXrh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N2rHTNwY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD4F23644D
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579436; cv=fail; b=M5yqlGI0/VEGPcQuIU+AUKVzCg6aGRyEaZYP3YprMxIrf/oeYz+/cykoaEYbKTEhEATUY7JQQCRxFVfwIEkgjL4LnTZUSn8QP8z85mUqvQt/jZiQnSAkRqhw0fJj2bNUqsliEIEZRut8J3ZRx6Un7c3rC0fgf4vFTm/W9qfngaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579436; c=relaxed/simple;
	bh=AhtftmwzM7QQmKNkQ/5r0lNqAJLics23Uv/qEIEwMdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hqYWUlsGjFBy1i+XZ7Mwn2V3TGz6/T57/0pW01eGUBteBtNYNDaUpWimOz6JriPYIY9DDh3PTycYGgexGnNbFIj8NwxpPwOysDsLFH2M7TjyLKAYI6wRr8EvzmrRydY+ZGc+T5adiZ0HSe4LAHqenbl0w3fkbdq8j+bL5tY1QgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EWK8IXrh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N2rHTNwY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PAvYs3025716;
	Fri, 25 Apr 2025 11:09:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=63NWNWwgZo0uQ8nb6gWCbIEuO74YOMIsSDIvfKnr4vQ=; b=
	EWK8IXrh0BlKVxSC3ZJHyMfFD1oEwnIXeGzvSZrVTLkYx921ee9a4Ea+MRKV/wlT
	PVkGwO1yjIpsdpm4/dGM+dXde2S28ItEZC/TUejvFBIkbRw8aURQ5Nxgn8kiG7+S
	q6Ucjdai11t9Ot8+PsX4mIOj9t8tPQTV84xGi3kZN9149IJL7yYSArpOK1R2Nvzs
	hyAnmLqF8Roussg5QbKiQludfvUBGjX6rjnTNE4/jAe6MTGlHZcgRnqmxknolaXA
	P8PPuAZaBWspNo65G3W/E1uzonZeUZCwiKMJvIXDg9K5OceNUU27TG8Zq5xeDNFE
	aMVvVoZMYy9fC17dCtHSGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46893ar1b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:09:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53P9QZiF031015;
	Fri, 25 Apr 2025 11:09:33 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08g25g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 11:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AGToQaMjdzPVlNXlA8ADuIr7V5EZv1dfF9Y1Gp6Px3HFvzEJeDUsqYDYYlDsdcLsr52tYAfHDXfxZspfzm+6EQuqXQSHyilVleEb1ptLopYJXK4KTp1YJfGPfbEEJsCBDwamT4wAF8Dx7RU79oIUXP5u+Ct/YJTU7oysS+0D1QvHrtXg/4kAnvdgRp8f9aU/ySidq+QnzjSTx4j5Ljqy5Zf2oy0M7DgOKw/857PUghMhDhJSO10uttlO7dPMdbBcbXv1MoyfvLAeNcrHHBbQJumBaM2v+lI04IpBnigD/DIO+ZY+FKyEL2LUdmro7HK/VUDZ+f+w4hBi7PtQiQzyXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=63NWNWwgZo0uQ8nb6gWCbIEuO74YOMIsSDIvfKnr4vQ=;
 b=IBiWD2RME3Kbo7d7pWv+MuAhRcFzlrhribhRWj2vYT6uEo+GD+RKeURHndqgxF7S1MFWuJL53WChtNvfjVGaUtxN1iPKQ9NSX/5T1kKCV/s3Pf+k6EtAS+Jv60N26yqdn1/7mHxWIMIq9rIs7h7XZ6mKqOh3F7jgxBqDBz6gC5Oiysi+c/BlfDT0IVYxZTRWJypaPCl5hpJp4qekfS1XHm5il/B+XPMJFicZ92HXtALLvE3rgvazMHn4Arxa66EH2GzDw642WtwnvfuvqYuEwLNw7NWStKOSldz5thtj1EwXNC5B4owEfEymgeD4DwbCXoz3YZfUpw/vZlgTn0OVOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=63NWNWwgZo0uQ8nb6gWCbIEuO74YOMIsSDIvfKnr4vQ=;
 b=N2rHTNwYU231XCJdiignusnspVO3nOm38MTvYfqW6qcB4IJ2Ksoym4OeSC4akN5PnnGfX1oV27cXaTm4PIdjLOE/7IPlVFrs2Iddd97c2Fi9WVLVzZ7291vtPkp8I7KqCZ3uncIV91/EG9rWoZF5mFqts/NsIkD/KF2lFQhoulM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA3PR10MB8092.namprd10.prod.outlook.com (2603:10b6:208:50d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 11:09:30 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 11:09:30 +0000
Date: Fri, 25 Apr 2025 20:09:21 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Byungchul Park <byungchul@sk.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [DISCUSSION] Revisiting Slab Movable Objects
Message-ID: <aAttYSQsYc5y1AZO@harry>
References: <aAZMe21Ic2sDIAtY@harry>
 <aAa-gCSHDFcNS3HS@dread.disaster.area>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aAa-gCSHDFcNS3HS@dread.disaster.area>
X-ClientProxiedBy: SL2P216CA0094.KORP216.PROD.OUTLOOK.COM (2603:1096:101:3::9)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA3PR10MB8092:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cf5bd7-37e9-48ef-a4de-08dd83e9a645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVRoT2NJcXoxQmgyYTh6YU1mbVNTcEt3MlV6Zm5QVjZBUW4zTlhPWm9sUEJz?=
 =?utf-8?B?NktLUFlQNk9HSUt4VjVhbGN3QmhYby94K0lWUlpXNS9sMTNCcTZJVE5wRExh?=
 =?utf-8?B?SERMWjNKdjhJOGpCL3VjZzFWaDgxZk5tZGZsZ3M0UjFlWFVpMUoyUnduSzQ5?=
 =?utf-8?B?am9ORU9qa2tBTmEvWE1FYTRXTnE5dnZmOC9ZanpsbVhCdUV2QUYxN2F6eStS?=
 =?utf-8?B?dVVoQit6NXc3WlJCTWVoVWNwNHVjQlZpNGdwV2NOQ0pCaStiS3NLN2tEbVJR?=
 =?utf-8?B?Y1dhdTQzU1YwNk1pRE54Q3VlaUFyZXNaSzFuY0NTQWJZYjVwSlIwUUFQc2Jz?=
 =?utf-8?B?WlNQWnVTVEFqYWdRUXpCSGFxZ2l0b0ZRWG83TEVqc0hCNkxKU2FwUEJjcVMz?=
 =?utf-8?B?TS9uRldFbWxJMDBSa2xTVy9tNENjeldEbHd1cHp3ZnpDTWN5ditCTlFjZGVu?=
 =?utf-8?B?c0FkZTlDQUpGMzdJcUxMUnlDcmhHUy9OWHFFSTlpSlM0Qnk2cmYxOTN5U24y?=
 =?utf-8?B?Skl6MFZDejFTcWRGK3RYWXgxTEpCZGt0MGQrQ1lRak5oT3JxbmxXc2tBb0Ir?=
 =?utf-8?B?UitaL1Y4NW5pb1pkTmpDaS8yZitZVWVNbnlFaHBDOXA1UVdYa0gybGlVMC8w?=
 =?utf-8?B?aXhya09vVUlMVjM4ZlRqT1VzMk1sWTNOOVlzYzNDS3Y0NFZ6UFlaRjAzci9I?=
 =?utf-8?B?K1MzZW16VlQvTGJSSHhyZ2ZGcUlCZWZJNHhubXVmRVRMb29TSmNtbXcwWWlH?=
 =?utf-8?B?UVBHMG54blhiU3BNSUtYYmd4dWNSZS8vU29EYzNCY3FVbUh6aFNxMDVKWkFR?=
 =?utf-8?B?SVZMcGh5ZHdhZnE2S2pjOEJMR1I5aWRWVmZkWlZIOGFwOUgzWWRpL2NDNExY?=
 =?utf-8?B?QjY4ZVQxbmREOWlnaEZTRXNJbm5RSTd3QTF3dkJYVzNLWW9DaFVId05RT2hj?=
 =?utf-8?B?eVRFQk8rbmRYbFBsbDhLV1diOVJOcCtWc2MweFVrdFdzUGhYODFod0hOVHVw?=
 =?utf-8?B?Ky8vNDA3c2VsMG8ybjRlOXMyTWY4Z2FzVXZsYVYzRExxSE83anY4Y0huNGJX?=
 =?utf-8?B?SCtLRzRWY2xIYmdjVnNjcXJQeVhYTlEyVjhuR0tkMVAzY2NFRDB1UDBxNEZt?=
 =?utf-8?B?Z2tReXExcVAwaHlxQTljNjIyUDlVVzg1WVBWNVV0OXN1Ti9tQU5PZk0zbFY3?=
 =?utf-8?B?MmNNZyttYUhYTkpxWEdmOEJRQm1xeE5hd0oxUGtIVVFuTDk5YzBCc2x3WkRk?=
 =?utf-8?B?S2YxMnZ5VFFma2RlVzNPb1ljMms5cmpYbzdzbDA5NGxFOFQvTXREd2gzQzNL?=
 =?utf-8?B?VENGb1FpUzlyQ0M4THlDdXB6NU81K1J4dVppMFhVZElqWG8rZGtXV3RYSExC?=
 =?utf-8?B?M0EvZTU0cXFzall3dk9sMm03QzJLZGhKcVZlbUpqZ1BXWlYyVE04VitUNmZ4?=
 =?utf-8?B?WFhvQXpvM0RjMUNYS1FvWjloeit6WitrcEROMExMRjlwZUhFclc1R1ArUmpn?=
 =?utf-8?B?V2huekpaRXJ6ZjJaa3NIdmxiQ2cwUHlrNWJOSzRVb1BzVDNsYXRVaStKd2pM?=
 =?utf-8?B?VkJrTDFjQ29wdTB6dGM2MlJCZjFuOG1HazZEaGNpUERoMklyenBGZUs2aTVa?=
 =?utf-8?B?NjlHNUY3MUFMRi9VV041V0hFSlRSU3lic09xZG9iYjhic1pFSTkzTEVEcmhh?=
 =?utf-8?B?TFBmU1BkSHlRSk9ROVBPV1ArTEErc3ZzUEZOcXBuT285SG5sZnByY2thOXBr?=
 =?utf-8?B?RDBrNWk3bmlGR2hFQWFGak5MWTRPL3p2WHpWWm1YTVBaeGg1ZENLUk5UcDRZ?=
 =?utf-8?B?TzNEZEIvQnhtU0cxZTBQQ0NuRml1STN1dWdTMXIwSWJEZFNxVEEvTlQ0bVgz?=
 =?utf-8?B?SUlJM25CRGFNN2VrSXJrZHAwL1dxOVhhTCs1Uk05VDcwaGp4SUtoN3F0MnBi?=
 =?utf-8?Q?gEO2Yh4FuQ0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzNsMnRzTmV2VUViUE9xV3RmRTJyTGg3Y1E3dEY2MjAyL2JFNWVYQ3R4akhp?=
 =?utf-8?B?L05uZDFXV1B0WW9lZVVmQU9vMjEyMnVrSGNuQkwvUFV1TkpTdzk1WHd4aWQ4?=
 =?utf-8?B?MEhWa0I1OTIwYm90cFluWTc0SHNYWHpTekxMQ0drTTdhVWFCd2g1WG8zQS9s?=
 =?utf-8?B?cURxZGxYZUh0MDJmL1l5dFBVY2ZCL29Jbm8rY3lhVWYrdzN4U2NQOFBxNE5V?=
 =?utf-8?B?dUttcWdRRFI2b0Q4bXJwVjhNYk5PTG50aUdQbUdGVGJDUlpUVThNdnRTU1Zy?=
 =?utf-8?B?aHpyWHNFSmo5VmNLdDZKNWZkbFBsdUtJdm9XcURKYVBvQXRPMnRFT3Jvc01Y?=
 =?utf-8?B?S2JiUDVRd1FUVFRJaS9meFdJMCtvaWdXZDlQb1BMU1ljZUJCUXl1U2dFamp6?=
 =?utf-8?B?NlFoQ2R5b2ZEbmN0Q2YzanhDTlUrTDFDbGFscGhUQjZCNTl2ajFXZFpPa0g0?=
 =?utf-8?B?M25pbW5rMk9GamJvN3lycGRQWDFJNngrSXZEY29UVzZrVHZhcUx5dzZXWXEw?=
 =?utf-8?B?czAwdkpSYmZBV1k3Wm01S01acnp2elNncnNXQ1B3Vk5VbUlrbEl1NjkwSG11?=
 =?utf-8?B?T1hpd1V3TjJ2aiszWHkxb3AxTGNxZHpNTE5UR1pNNXRVUC9ONE54TkNWdi9m?=
 =?utf-8?B?S0NwOU5CeDNDb0xIVkZXVXl2a3FkbGlaOG1SUDhocnBEZ3dxRGNOeUV3ZkM4?=
 =?utf-8?B?d1NRQmgxSFhCRExBL3JFMHp2VUNvSjhGOVkzUUpkdXVlNWREcHlLdXRML0k0?=
 =?utf-8?B?dEFYRnNnN1BOTDJzRkhHaFp1aFRpdFhwNmxWb3YwR2NtSEZNWEpLQnp1Q1di?=
 =?utf-8?B?QlBSQ2tGMTdTRkZoU1ZZc2xaYkdBUCt6c0g5Rll0TDcrN2trVUJ5d01TdFBY?=
 =?utf-8?B?YXNkWTVFdWYxQUhKSkUxUGhpV0h6Y2hYZVJ6N2Z5dnRaN29WUzVYeXZyT3JV?=
 =?utf-8?B?em9NdGJyM0UxdTVlNVJJYit5ZGRyQXhYQStKc2N6SkFRZ0JRb21SVjAvb1RJ?=
 =?utf-8?B?SCtyTHNpUWNnd1ozeDMrYXhLSkxjbG4zU0kxOVVlMkxMYVB5RFl0b2w0c2s0?=
 =?utf-8?B?YzRJVk9pSXBEVEo2Rkt3eWhEOHlMYkxqK2JHTGZVMzRlVFVqR2VjL3lJZDNH?=
 =?utf-8?B?cnhZbkJCWHRDM1NrY2dHMTZ0Q3JVdlpHRnRXSDdmQ291a2hJeGdVMHlYcnQw?=
 =?utf-8?B?ZG5JWjFsVm9Wa3g5MHV3V0RTQUNjZVZRbjVwNk83WVRSMDI5UU9ZeVB5WWxt?=
 =?utf-8?B?MnY4TVBidWdXNlVFRjNMb1BJTnRtcHVqSHNpU3loTHBiZTFpS1BwMmVwMUk0?=
 =?utf-8?B?Z1BDWEdFSzNNb25xVG5oMXRHNWJoMElqZTR4L3BkRnhhWDBOVXQzNjJmSWth?=
 =?utf-8?B?T2NaY1BJb2NiZE9aK1NRbUJiL1lPNVBYdkdxd25yYWZ4RXptRnNySWc3OXVa?=
 =?utf-8?B?TGNKSWE0MXFSdVBxbE9ENVhYb1gxYmFDditrNEJDbGJ6ZGNzREV2L1lKNGpQ?=
 =?utf-8?B?WEQycHZrWFR3VWQwV2VKYnNzTHN1VlgvQUViM01WNExIUS9SQWE2ckhoQzA3?=
 =?utf-8?B?U1k0WHo3SjRWSHZwZURSSXg2WkwwUmNrTllvQm1JUDdrcWxFSFh3Wk5lYlVz?=
 =?utf-8?B?UEU0MlpFeTlTWTE0YWIyaWpGWnJMcFpuSTdFVjJmU3loTmZhbUsvNFpFT0JD?=
 =?utf-8?B?ZTRBODhYaXRRSHExTzRDR2ZPcU9NNjFoZmJhL05lNkdKQTFobW0ralVWTHcw?=
 =?utf-8?B?MHUwVHlkM2g4SFF3Mm9Rc28rV1E4MzNtME9hVHVYYlg1UFZoY2JtU3ZnbFlo?=
 =?utf-8?B?Qnp1WGRFS3ZJNXVzdnlsNTFacmNWbjdoYndYV2l1MGR0Z1dkT1IrNVVRWjdC?=
 =?utf-8?B?MzhxRE8wNXIvZWlWbGg4dTl3cVcwWHluRnVZc0MrOXVERGFQaFlEYXFOVjhF?=
 =?utf-8?B?TytRV3BWREttTTc1TTBlMHY4NGVtZ3ErMlZFWTI5MmVYVHdwaTJkWFBCaUtO?=
 =?utf-8?B?amVBbDBHOHU2emhaaWJLRkExQ0RobzZLRnUwNzc0UEVKb0xRSWhOWjBNZ21u?=
 =?utf-8?B?YW1BMGsweWk1dlN3TjBnQVdabTN2K3k2SFptTy9rMTFnSDFlVm16bWMvYlVL?=
 =?utf-8?Q?+2haQ/qe0CplWKLf8Tdy9YDXS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1m8Zh6G1wMzeWb051/bNyiMG3jp/L802DsOW97uVslpUsqEEHhiQ+zKiav9P4WtCx1mhqnAG7adh5dnHSDm/zh2aKlajfhOhxYbOOUr3gEGdxrrF2kDzGzbwkUlZZ3mnDwRcIr1dtAjChnS1akqSQjrAjlvOdO7/uvG689T+zMq0uaJ0pBZLIS9h3adX7iINvfgFYmgLe2vVuxQMAe7l55jNnSbux6DC29W/3Xgl2rWdgIi+4xvsCvKYhMCggDoqBo/uTW4ske3PCEWC7H3hOzrG23E6eaLJF8mR+a6S3VBSDnoC/d4vtlrWCZ6EGtph260ekFHJeNYHYJNqpTMDMNnXLbSwMSAqk7/2KfRuU54WOOUNECyPzyBH9PV3Rt/kTyQIIjtm/i1H4hLVGtkPG1s04uLiHRkWgzy2ZolKQBYIYeYxyO1249j/ocRPZ06lI2fT7EOP2dU4sZd4MXPANVfMVDCKeaJlLguSgprjYIJsXG7aiFLnNW2cWznv9n5w2UGwnrjlQocLgsfY259GhIZfdSwmywyubWOR7qxMNzD5tY62XmriteLTk33l18epW9I4V8C7tsTvHB+8Sg5GjsxGwEK+tQAbesY3yuq3Psc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cf5bd7-37e9-48ef-a4de-08dd83e9a645
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 11:09:30.0220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pxPbOiT2qSC1AIlQx8DGhfAI010rwLmBZQkSPG9J7wEUWS+0QgvtuddmmwrxH0Ajc9RxZyYovmEtTterQxmNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8092
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA4MCBTYWx0ZWRfX0MMpZLwuLC/v ZP20ZfGTBSSOgxmo8NRRaUxlt5Lnrt4iXMmgFEOhwx8huw6gnHIU05ZdCRu7gnsWBMoHYs4KiTO iHlcNTWNWeKiLpJhW4A7J9pNt15dTDl7aQQNjhmYhRfNfmhoQJj+HdJ9zJlIcHPCRqjFc9Nb4Yb
 yun1SDNWEbeggQAz1JYHFhYWHlWLV7gDuEGM9FoOXB6mL9sOxfh5MA+0ke+S5xXBOjjteGOpKMW oxFFumMWpNb8pmXLCJ8iZVu0b7wDzHS/bky3iwJztAWsAc608OZwiRHmV1zrJUU+v1WC8uSDrGE DijjCp4YIl5XPb2naccQpN3FuKFT8lNJUhQjx8GwJi1x71O+ZtDFGFIBiXJFdI7iLkKQvhcBlL2 ehkyJvdr
X-Proofpoint-GUID: B3oZR5Pj9oE3l7NLj8MK3cdK3DutlpyE
X-Proofpoint-ORIG-GUID: B3oZR5Pj9oE3l7NLj8MK3cdK3DutlpyE

On Tue, Apr 22, 2025 at 07:54:08AM +1000, Dave Chinner wrote:
> On Mon, Apr 21, 2025 at 10:47:39PM +0900, Harry Yoo wrote:
> > Hi folks,
> > 
> > As a long term project, I'm starting to look into resurrecting
> > Slab Movable Objects. The goal is to make certain types of slab memory
> > movable and thus enable targeted reclamation, migration, and
> > defragmentation.
> > 
> > The main purpose of this posting is to briefly review what's been tried
> > in the past, ask people why prior efforts have stalled (due to lack of
> > time or insufficient justification for additional complexity?),
> > and discuss what's feasible today.
> > 
> > Please add anyone I may have missed to Cc. :)
> 
> Adding -fsdevel because dentry/inode cache discussion needs to be
> visible to all the fs/VFS developers.
> 
> I'm going to cut straight to the chase here, but I'll leave the rest
> of the original email quoted below for -fsdevel readers.
> 
> > Previous Work on Slab Movable Objects
> > =====================================
> 
> <snip>
> 
> Without including any sort of viable proposal for dentry/inode
> relocation (i.e. the showstopper for past attempts), what is the
> point of trying to ressurect this?

Migrating slabs still makes sense for other objects such as xarray / maple
tree nodes, and VMAs.

Of course, if filesystem folks could enhance it further and make more of
dentry/inode objects that would be very welcome.

> However, I can think of two possible solutions to the untracked
> external inode reference issue.
> 
> The first is that external inode references need to take an active
> reference to the inode (like a dentry does), and this prevents
> inodes from being relocated whilst such external references exist.
> 
> Josef has proposed an active/passive reference counting mechanism
> for all references to inodes recently on -fsdevel here:
>
> https://lore.kernel.org/linux-fsdevel/20250303170029.GA3964340@perftesting/
>
> However, the ability to revoke external references and/or resolve
> internal references atomically has not really been considered at
> this point in time.

...alright, I expect that'll be more tricker part.

> To allow referenced inodes to be relocated, I'd suggest that any
> subsystem that takes an external reference to the inode needs to
> provide something like a SRCU notifier block to allow the external
> reference to be dynamically removed. Once the relocation is done,
> another notifier method can be called allowing the external
> reference to be updated with the new inode address.  Any attempt to
> access the inode whilst it is being relocated through that external
> mechanism should probably block.
> 
> [ Note: this could be leveraged as a general ->revoke mechanism for
> external inode references. Instead of the external access blocking
> after reference recall, it would return an error if access
> revocation has occurred. This mechanism could likely also solve some
> of the current lifetime issues with fsnotify and landlock objects. ]
> 
> This leaves internal (passive) references that can be resolved by
> locking the inode itself. e.g. getting rid of mapping tree
> references (e.g. folio->mapping->host) by invalidating the
> inode page cache.

Thank you so much for such a detailed writeup.

The former approach would allow allocating them from movable areas,
help mm/compaction.c to build high-order folios, and help slab to reduce
fragmentation.

> The other solution is to prevent excessive inode slab cache
> fragmentation in the first place. i.e. *stop caching unreferenced
> inodes*. In this case, the inode LRU goes away and we rely fully on
> the dentry cache pinning inodes to maintain the working set of
> inodes in memory. This works with/without Josef's proposed reference
> counting changes - though Josef's proposed changes make getting rid
> of the inode LRU a lot easier.
> 
> I talk about some of that stuff in the discussion of this superblock
> inode list iteration patchset here:
> 
> https://lore.kernel.org/linux-fsdevel/20241002014017.3801899-1-david@fromorbit.com/

The latter approach, while it does not make them relocatable, will reduce
fragmentation at least.

Unfortunately, as an MM developer, I don’t have enough experience with
filesystems to assess which proposal is more feasible. It would be really
helpful to get consensus from the FS folks before we push this path
forward—whether it's relocating inode entries or avoiding their
fragmentation.

-- 
Cheers,
Harry / Hyeonggon

