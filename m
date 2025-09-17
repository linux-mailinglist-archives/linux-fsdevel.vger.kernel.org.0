Return-Path: <linux-fsdevel+bounces-61876-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD76B7DA45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 14:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442BA1BC5CCD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Sep 2025 05:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DD1C5F23;
	Wed, 17 Sep 2025 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lVILmbS0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KpCiw/vV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0DB1D7E4A;
	Wed, 17 Sep 2025 05:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758086482; cv=fail; b=QZ1zbZOuxAIoo4ohUzJhJIMLXy7+CmDPyI69Jf73vLfURHWwH3n4WMQXRjnxTWnBKPDvdjC9BptcQ7tUSolKNNp/7I3Hi9VxtyT73v+brQrSo//Ob0DMMgmnRVY4YEZZhCF5Xk1uCCcUq8Gc3nBUAwYKQ3jiaj47HEEnXtsP87w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758086482; c=relaxed/simple;
	bh=+GAm3iKUBUUa82mL+kb35azMwpOx6Ahgl99B9pUZl1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r8L1JBq2q1XBnxrTawaAp6Obxra36+e/DHeyWRUA4cMXaPCjctUBDgZ2Taluq1xeIbAeS5ouptyAMEeFa3BEIn7MlPq8BrE2AVW/fpUwGXQyQ9qk/SqwaZqGCuyKAuzdbK9yukPepVn9CtIZ4iKYDsp4QI10b1nsoSwGmKi6QAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lVILmbS0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KpCiw/vV; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GLdVmv024707;
	Wed, 17 Sep 2025 05:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=YeHQ++qmunjNnUHiKB6bTh5iKeWrW83y7P19MD2knR8=; b=
	lVILmbS0oOocDfgN+QTx7nNg8X9rEaStyBOmieWrvulDd4l7/e1pDfWoT6ZT/nvS
	OorR6M4r9NFRDe1uFsFVFBOLxp92DtsZUiVUWVmMmRgPgfIqrGFl5UM3GSuNJ9FY
	INp1BBekKh3VQ3D1jbMCiQUBK+BxeMuM56jyxcY89K+OHurAN3TX+dQHr9n+bv3f
	f03jHh93aI+Rp2rAbEYHpIFNLYxkB7bOT7Bh14P83BG4aFrxinlzBULjVYCZGr/6
	4uOBjxG4IFip+xHE2wXHDroc+W2ZLU3tzGxK+Hi9Ejry+Y7s7os2rqDbRH61OIp5
	5cxQZEkQarWd3qEV1UnZ1A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0k8dru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 05:20:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58H3Vu3l036766;
	Wed, 17 Sep 2025 05:20:32 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010061.outbound.protection.outlook.com [40.93.198.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2daays-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 05:20:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTOEv7CtaH/p+I+q9CSoKJXol+uNbfLPDFEwpi34B3FO6datDTACAOvs2oZDe9FrHV8y9EM5KsEzSJgbbmyiF5E4jNxfXEHlNW2gAiMJIjMEcca1u6XerqFub7CUaOl74U1AMFOsrx06LsKFg0WKCOC5Hdd/pEw52MNx85N9XIu3RrdsCugBMEnioiOqXfPlcIQl/i/+YNcF6fXW8Qo4VRRYmtLGYuYsQ0JAOWlOM9QpNGVtJ7hCBn44rf2+YZZkuFet301/ygknUtis7UEwxwaRDm5D7oH9cLDFBK+u16M6obOIulg4ts0gyAK3Ezz335uRfeKIp8SJVkEJ5FZWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeHQ++qmunjNnUHiKB6bTh5iKeWrW83y7P19MD2knR8=;
 b=jjWmHQSI4GyIUik6rcN908C3oNgRRDb0H7PEHCMsSqZ3sAhQawWIrtIgYoM2OVTk3nP5iecTlX+nSAHUl0KfilX+0c6pgWC66xYg0qACXyqkSkWrWnxEUEpSxveIPXEAVhuo3TqMLd+7SSo9RtcpWzMvTzgNjLi+xILqAprs4DT8GLtTg3uVfn79tFIintasA8uwjUPX9MwpgSHZFkruRUDmDtWuGne/R2S/6fvs5z7mqnNOz6BC4JQZfYqCXz1BFastWA7WqFhFDkImdrPYAcjzOxT05qheMlLVr5CfE6CbEw3qpVu041MPWLFiy0MMc/XArPaesDkZlHV7dCL7Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeHQ++qmunjNnUHiKB6bTh5iKeWrW83y7P19MD2knR8=;
 b=KpCiw/vVwBetU7f3ysbWORa2GX1JqhRRxw1FYxB+N6tPHxLS+pjaeajIGGszdoTT7xuOnChkWdX987HdVKIIjFrKTU8bnbaLrprZuCdFjo7JpuOMlGAWjjMbXNrkRbcpT84AMR9udk+VQTVDrboygH83uHvZGPZxnQTiXLd0JO8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4908.namprd10.prod.outlook.com (2603:10b6:610:cb::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 17 Sep
 2025 05:20:28 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9115.022; Wed, 17 Sep 2025
 05:20:27 +0000
Date: Wed, 17 Sep 2025 06:20:25 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Chris Mason <clm@meta.com>, Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-ID: <36fc538c-4e25-409d-b718-437fe97201ac@lucifer.local>
References: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250916194915.1395712-1-clm@meta.com>
 <CAGudoHE1GfgM-fX9pE-McqXH3dowPRoSPU9yHiGi+a3mk1hwnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGudoHE1GfgM-fX9pE-McqXH3dowPRoSPU9yHiGi+a3mk1hwnw@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 7181ae72-1ff7-4f1f-0084-08ddf5a9e9e0
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?KzBuNlVJRjBUU1dFY0h6bzhtSytsQlhCYVo3ZnRrNDNEVjBDS1VUL2plaTF1?=
 =?utf-8?B?akF4cjMxbk5QclAzVWpoTFNjTTdLZEhaOUU4RGU0N2t0RExnM3E1Qm9xV3BE?=
 =?utf-8?B?MUE1YzNCVU5SNjAzaEtHT1NUVVRlYXZyQTFiM1RIZnBhdGN3S1E5Q3E5R09F?=
 =?utf-8?B?RGdJMjJGTmZwSGQ2YWFOTGpQdDc5RlUrVUdpVW5yZGxCWC9JT0xmb2hmc3JO?=
 =?utf-8?B?N3krSm5lenI0cEsyWG5uNFRPYlpSWEJzdjEzWEMyWUtFZSt6cWJMNUJ6c3la?=
 =?utf-8?B?b0VKaHRVMVY1NDhMZkZOTHJYQXcwOXB1QTZ6S3dWWE1ZVEozdW5EcHo1RTZO?=
 =?utf-8?B?LzdMNlEzWWdIVU1iYVljdW5JR0taUG5CRlZWS1N2b0xZbUtkZFNQRjJZMGRy?=
 =?utf-8?B?TmNjYWxnenZTbFoyMlVTYWZtSHRxUG9SeGFyNFRYcHNmUHVNRkdqTk9DNWNC?=
 =?utf-8?B?bDVOWmNDNHNuU1F5M1lnK2tBbVRIbVk1VVc1YjB2bFZoVFhMY0poV09xdXZu?=
 =?utf-8?B?NUsrelVVd1NzUUJzUzltUXdFL3ptVnltT0plZzYyOTc5ODJwNkpTeUV0QXV4?=
 =?utf-8?B?VHgyNllibld4SmswOWVtVjVYS1ZiTGswRi9JV0pUVlQxNTFTTDd0UmVLdlIz?=
 =?utf-8?B?VVk3ek9FVGtyV0pEZkFXN29BU0UvOXUrQmZJdUpYakVHZ2hZdGR4RmFIOXYx?=
 =?utf-8?B?R2xoWGtsL3I4bEdtcVF3RHBXeW5ISmtyQnVNTFFFRUpaYXlOL2RCZEtBQjYr?=
 =?utf-8?B?Mm54blNldWZGSFRpNmZqQWVpcXBYeHhjeTNYVmFuVkdMdXpSOVNudHdIaEV1?=
 =?utf-8?B?VjRGWkp2WG9kcGU2VDVQZlV5OWtoMHMwQmh3QlN0NVVqR1p2OGVvdVM5OHp0?=
 =?utf-8?B?QXVwQ0JOd3dOTVBmL1c5UkorZ1FUUE5la1ZITHBLUTlCZ3dmdHdScjdCVHd1?=
 =?utf-8?B?KzA5YjE5enJ6RlZFQ0RUYTFnK29RV3RCRlMxWHpOYXBaem1nWFQ5Z1lpQkdz?=
 =?utf-8?B?VUlzMy9DQTdZakRpcTE3YUdBa0JVcFN3d3VZN1NuYm5WeTcrcE9zbXEwckRS?=
 =?utf-8?B?MWYyTjEyN2V4NndxRVhEbUlsSzB4dkR6YjA2eTc3cWNLT1dWT2t6U3RIKzJV?=
 =?utf-8?B?L1NKOXN0YnFXVER4QitOR3hHZE9MR3JSS0NsRUVBT05DK1dxdXl4MWV0cTdp?=
 =?utf-8?B?VkZQQ2QxZjNGYm1rRDhjSjFsc0ZrUU9tZmxaSFpzcnJLS2hlSERqQkNIWEND?=
 =?utf-8?B?VU9SaU0vcnNkbm5mVDkyVGdaS0c1V09lVXNaTUVtVDlHbFFVb1RNQmEwQmNE?=
 =?utf-8?B?YlM1dFZ1TTVZMFc0aC9RdUtyaTRSNTFBY243SmY0N1IxcXJOZlNzZ1RvRE1n?=
 =?utf-8?B?VitWVk9oYUhncTZ6ZklIcTMvTDBDK3JrbkVYRHFMeGo0YUtPeDlEclNocUlI?=
 =?utf-8?B?MXdycExHNW0xOTJVcHJjdWY5SFd2QU5EL093c0MvRHBLY29yT0pDbUZjQWNi?=
 =?utf-8?B?UDNMeVhOcnB5MGw5NW9vbWtGRDljWDk4TmFDN1BHeWxIS21NT1M4Ri9TU2hS?=
 =?utf-8?B?dFBqaHBGNXlCYXJiOGQ1WXhqUFBBMSs2WjliZGlzSE1vMUMvU0dobnVlTTB2?=
 =?utf-8?B?aDNJaDIzMFMycWVvekFrdzlkSHZWVkYxV2xFcmVubW9HclRYdW9nTDRLMm02?=
 =?utf-8?B?OTQyZHh6aXl1SlpXSXhwTUVhSWQ3RW1RK0NOOVFmczh1WmVhcTF4Y2Y0RE5H?=
 =?utf-8?B?blRlVjE4TUFSQnVIT096MnUwOXZiZkViYnhWOEtwSGIwcjBuZC9wUkpiV3o5?=
 =?utf-8?B?Y1NWVVM5cEh4bWNUUVQ0QW5HT05Mdit5N3psMk56S0srU1poM3hRa1dKMVU5?=
 =?utf-8?B?Nm5CZjhYWVo1UFdBZzAraHk1U3dVQ0NwNEJVVjJRVFBDcTFjbFlQaEJrMTlT?=
 =?utf-8?Q?TUw5ml241o4=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?b1ZMK2NnTUdoOEM3bGRhNXU1OHpPS1Z2SVFZbFY5R21hVXRFZG1pWEFZQ1I0?=
 =?utf-8?B?OWsrZU9BVk5OZDVKbzZNSmhZMTJFUlcvcmR3Sk85VkY2ZHkyV0hEL3BNYXVL?=
 =?utf-8?B?enlhY0JsN1YzQ3kwOEhIMzNwUjZ6YmhxL1VoVnBLYldMSGdWWWE5Z1c3SGJK?=
 =?utf-8?B?d2pIZDZGd2x5ZWlmaWUwTGtqQ2F2dnJZSld6Vk9uVkVuZ0dMSVJERVliMUx0?=
 =?utf-8?B?QnU3QzE1MzVxQVk3WXRVVTY4M1FpQk4rWFdlejNaSW92d1RZOGlJUlVqRENM?=
 =?utf-8?B?azdrWkljbllwaERuMHR4TUFpK1c0L0JWVmZNeVczbUV0NmFHNm1LdzkrL2p0?=
 =?utf-8?B?OGR4dlR0UERyVmFrMkVyVDVaT0xwVVJ0aTRaS3hDdlJuWHVBRHpKWHZiYmQ3?=
 =?utf-8?B?QmhRdDRXL1IxS1VQUEpDc01oa2xiQ3BSMmtmd2dtN1JqaFVmVUdMWUMrTEtt?=
 =?utf-8?B?ZExTQ3lZQUhwSkNHUzg5aDg3V2tEdjJDNFFvbHA2LzBWQTJsMVZRWlFyTktv?=
 =?utf-8?B?NzNZbkwzQ1pSRGhPOHRaZmVCbEJWTU43Mld6akhyeDMyNkJOOUNFamp5VmNP?=
 =?utf-8?B?ODVlNWl5WmF4WkxHZGFjQzV0MHd6UFhnWjlsVllVbEVOVVdmRVFXbXQ5WTRE?=
 =?utf-8?B?dU56QVBhZm05VHRvNGdZWDJocFhDdElPNFk4dkNhTU5rRExkd2tBczRhNFYz?=
 =?utf-8?B?aDMrbjB1Y0ZLRG5kNUxUNXcvNzBjb1E1MGEzd1ZDbW5UY2RLUjdPQUptNHZT?=
 =?utf-8?B?TDA0RHdoV3FtUWUySEpaL25GTmpQMmE3SFg4TThJNFBSMlVieU4vRUx1cjEy?=
 =?utf-8?B?MGdBbVkvTVVjYzBnMWZweUtHdG1LbEUzV0JlbWZQTmxwdEtiRWVRVFlqamJC?=
 =?utf-8?B?UVZkMHRjYzNRdWNiS0k2K2t0cTgxMWljb0F4Z0hFZWFhQm4vZ0tFV0JVT09W?=
 =?utf-8?B?UjE4czVLS3E1cmNzWjlwVUJPRG5hcGlEN1Fvb3crYjdEZTE3Y29OZGdlSjZu?=
 =?utf-8?B?czhOeE1SZDlpaDRjTGhEc3lPanBWeGJOcVNiQ2RsSy9LU3pacVI2UC9zOXJM?=
 =?utf-8?B?c2N4djdsMStwTTdVL1BVdVR1b05vVEpjSHlxMURlZTIzREtTSWZKRS92d2VO?=
 =?utf-8?B?ZGFIb3RFZk1tMS9sT3ZYSkU0U2JjOUdoeEJmWTJZNWlrTGNMVXduRW5zNXRm?=
 =?utf-8?B?Z3ZKK0ZodTRQdlU4RFVTQnVVWDB0Sm9pNkdVR2JtWE5oR2FicnBBUzFnS3Ny?=
 =?utf-8?B?VjkzaDRmdUpkc2ppQm93a00rcW1OWHJ1UW5IYStWTlNXYmZ3SFkrc0g5aFVv?=
 =?utf-8?B?K0k5bkxGQnFMcnF0dlRRd2dHQ0dtWU5oU3BZKzE2MnZ4bUFrT1NWRk03ak92?=
 =?utf-8?B?SGUvdndkdWRDb1c4eWNFdXI3R2pvSSt5MmF4WTB4VzRNTXhsVVNFTnFWVUh1?=
 =?utf-8?B?YmNOZnRJZUhtVWZmenErZzdUQ0p1OEgveWlyOHNZQ0Q4dzFWTCtTb09EYVc2?=
 =?utf-8?B?NVg2bHp1dWlHQ0xlTGUxMDVXRjFXTzE1dHZLRkk4cmFSWHRuaythSWYzSm9I?=
 =?utf-8?B?YTNRR0NSM3VmU1VaaWNtZUtsZllQSVllL1daSW82QUFlN0FQb2NXaGI4STg0?=
 =?utf-8?B?NjhwV0pEclBoTU9OckpPRDBqWVZRTmpnZzRKK3Zyc3ZmeFNuZkRCanlpUTJ4?=
 =?utf-8?B?dGsvbDl4cnc0b1R0VlgzUGJsbWZpbm0vcXZNK1U1bG1SeE9wWjhhQ3U4enpn?=
 =?utf-8?B?K0llbkoxZW9nVTdLaGphR1g4eWgwOWNtZEhsc0REaFFMN2crb3dqTDhNdzhi?=
 =?utf-8?B?QjNSUm1oZWI4ajEycGVGZ213dGFxeThxMk1seTU3RW5GR08zVVFuSmJEdHBY?=
 =?utf-8?B?N3Jpa09OTGE1TjNybWNhaEdYL2FzYVk4d1J4UVM5c1h6MkpDNitOTGVhd1dP?=
 =?utf-8?B?Qys5a0pPcXJWQ2QraHk2WVhINnVhMzd3RlJ6cDViaStIdldpblJrcTVIRFRZ?=
 =?utf-8?B?ZjMwZEVUWVh2Yjl1Y1NEUTNEREVlRkM3WEIwQ2Z2Mmx2aEVsUTEvYmpFSVlL?=
 =?utf-8?B?VUh4TU1OZVFXbzZpMUNid1ROc1pBU0duWWZYMHpvbUJ2RHlMMzFySHk3K1BJ?=
 =?utf-8?B?YUQyVDh2VC8ra0s0U0s0a210UmRLaW9PZ3RiNUJyWTBTdzU5ZTRGZ1BjRENo?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M4L219LxMPCt4X7FYiuP0kz0FcRPdJx63TQBuu618Bb10IoKTXgQsqwo9JEsuySNCnu/T1RSQbajldWi3oECsLNEjuQ8wfFZO0Rta+GlxfHOyYBITGD0jMzBA7QulukYPsGOD7/OaMzRvPmNTBvucv6mTPlCpM0CZYPVu62xTb/vk5drJ1idq7CZk1iI2GrVastx4QdROt6psa8u4sTX23o7SNTm8WdhVpw9/3MHqLTavWGtDJ47hrYUnQ4IAoD0/+YOmDtvaC7P21HZIC1r1H3mdYL7Qc+A4d5AIPubLVSGa2iQnSG81bOdYTEN+tOwRA+KSMGt/Ahopt4Xv/2agck87+dvXBlFB5dcjxCn7Rmln0rYuCbRrQzUppi2RdQwa0kwZFPlcqfSuvC4toncgVJQc9X9v5qPOPOxoEW+IwFzkmTrXIsH7hg1Te8P+nMKYNO+bzlvl5fj+0AmmhtcnP0j7TFnvosTiQHbuekcGsBpUnKdpxe2L0b5+lT8bY++fvR1SB57QjeldhoalbjjG31og8IOosQq+rRibkYvHakaKiaV92KT1nfFNB7E/QLTlImB7uvpCfExjjuHgo9lDYS4TBHsPF2meaXteELSm4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7181ae72-1ff7-4f1f-0084-08ddf5a9e9e0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 05:20:27.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H+M9MgLyoaTqMi+cb7iTgVdM532OEQPCTdkUcwoVfMbXaZS3LIR+YhIrpvCyU7NH/psYngeQKc/vZnFJ6gOSZS1TuaBYaz3R2HZDbfSvmts=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509170050
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68ca4521 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VabnemYjAAAA:8 a=yPCof4ZbAAAA:8
 a=QXECTrqsWQhBFdpvQ2MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gKebqoRLp9LExxC7YDUY:22 cc=ntf awl=host:12084
X-Proofpoint-GUID: M23Ee3jdukBe_K4k_ip0sUhcjYf73lRI
X-Proofpoint-ORIG-GUID: M23Ee3jdukBe_K4k_ip0sUhcjYf73lRI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX5DkN5L+EJjiK
 z6zsBik2d9qoIO+PA5hXfEyRxp4U0AjBYPbLgcKpQWrSCkn2clmwgPc6ukkxH0t4TFQMcAFuHfO
 cHD1KmfSsihov5lnLHyGtvbmI/Lmuo7VfC9HGh6nPSRQAjQd6Cl7mhWTwnjJA7EB/5hyLGEr6IL
 8h7TW4Y5UGJ8YOtGXwVprUjtf06LaTUBLEXGGGvzCw2QsSDIK0Gx4ODFKog71+5JmjKE2JyVjrP
 BWs220Af9iBEpRHQbJUsvI0YvDl94N6aSP5kfyu0kNpJym0+cYlI2lQg3IULW7XD6PVYuu84hyv
 JoK8e+pQ24lVOjt3NZxmb4/h3gZ1qq5ylssf1qADNkhX4YsfIz7cXrGB2wsGCxWeRxFO1w57UDn
 8AWpdXZoJPnkZ72A9fv5nOooYu4C+g==

On Wed, Sep 17, 2025 at 02:16:54AM +0200, Mateusz Guzik wrote:
> On Wed, Sep 17, 2025 at 1:57 AM Chris Mason <clm@meta.com> wrote:
> >
> > On Tue, 12 Aug 2025 16:44:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> >
> > > As part of the effort to move to mm->flags becoming a bitmap field, convert
> > > existing users to making use of the mm_flags_*() accessors which will, when
> > > the conversion is complete, be the only means of accessing mm_struct flags.
> > >
> > > This will result in the debug output being that of a bitmap output, which
> > > will result in a minor change here, but since this is for debug only, this
> > > should have no bearing.
> > >
> > > Otherwise, no functional changes intended.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> >
> > [ ... ]
> >
> > > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > > index 25923cfec9c6..17650f0b516e 100644
> > > --- a/mm/oom_kill.c
> > > +++ b/mm/oom_kill.c
> >
> > [ ... ]
> >
> > > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
> > >        * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
> > >        * possible change in exit_mmap is seen
> > >        */
> > > -     if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> > > +     if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
> > >               ret = -EAGAIN;
> > >       mmap_read_unlock(mm);
> > >
> >
> > Hi Lorzeno, I think we lost a ! here.
> >
> > claude found enough inverted logic in moved code that I did a new run with
> > a more explicit prompt for it, but this was the only new hit.
> >
>
> I presume conversion was done mostly manually?

Actually largely via sed/emacs find-replace. I'm not sure why this case
happened. But maybe it's one of the not 'largely' changes...

Human-in-the-middle is obviously subject to errors :)

>
> The way(tm) is to use coccinelle.
>
> I whipped out the following real quick and results look good:
>
> @@
> expression mm, bit;
> @@
>
> - test_bit(bit, &mm->flags)
> + mm_flags_test(bit, mm)

Thanks. Not sure it'd hit every case. But that's useful to know, could
presumably expand to hit others.

I will be changing VMA flags when my review load finally allows me to so knowing
this is useful...

Cheers, Lorenzo

>
> $ spatch --sp-file mmbit.cocci mm/oom_kill.c
> [snip]
> @@ -892,7 +892,7 @@ static bool task_will_free_mem(struct ta
>          * This task has already been drained by the oom reaper so there are
>          * only small chances it will free some more
>          */
> -       if (test_bit(MMF_OOM_SKIP, &mm->flags))
> +       if (mm_flags_test(MMF_OOM_SKIP, mm))
>                 return false;
>
>         if (atomic_read(&mm->mm_users) <= 1)
> @@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
>                 reap = true;
>         else {
>                 /* Error only if the work has not been done already */
> -               if (!test_bit(MMF_OOM_SKIP, &mm->flags))
> +               if (!mm_flags_test(MMF_OOM_SKIP, mm))
>                         ret = -EINVAL;
>         }
>         task_unlock(p);
> @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
>          * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensure
>          * possible change in exit_mmap is seen
>          */
> -       if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
> +       if (!mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
>                 ret = -EAGAIN;
>         mmap_read_unlock(mm);

