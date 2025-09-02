Return-Path: <linux-fsdevel+bounces-59971-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC62B3FCF8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62FB18967C5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 10:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C39A2F068E;
	Tue,  2 Sep 2025 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GQ83ZmNv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wVRqJP1N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E22F4A18;
	Tue,  2 Sep 2025 10:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809999; cv=fail; b=R7f1rC7IN6UgO/X+Sqbe3VtG/v6x2MKIYRtEPsd9Nu6yXM93T3qbTVv84gcoVMzccNio0v3q2eVtQ/WfbzcVAqUIgKbfvCU9Pu3b/yGOEGNOgOhM+k5AiFCyEi/SBqSui3NWMlq4h+r8sR/2sIcMK+teszxIb+zrF0XLAcl4J6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809999; c=relaxed/simple;
	bh=lMGh5npRANXxbcX0ZpdVdTMzAOmoB63v+b4NQHQVehY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jfk05QbKboCZwe+dCDVcJCPCUdozmkDJSuNVRLdplOYTGnukSrunHV0KGt/JC4QOZTEaj3IQVIFOEJH6dGtcYBLHFbEYwCy9LgxPF/cRkRsiQ3XucQHybOGw7QQt1XYIqIXFYFKBMy7FOmc8CoHHk23YfkR8UUdBe0W8KbOlo9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GQ83ZmNv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wVRqJP1N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ANVm0029971;
	Tue, 2 Sep 2025 10:46:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=nQlbg+4GXPMUEvVd
	Nfrftrespk1rMZRB1pHeEVtpNUg=; b=GQ83ZmNvUNP64Hb35nCQfwOOv7M47IEd
	E3kLR51jNCigUexBOpJrvBFmlSJSTYPRGYj8OVZqWVcFmfdNTbX/kT/gMkFXJn0Z
	/neqR7l9wT4Q8+lKgGwSFXdw/SFj2ZuJyeu/E3P7hlV0X0P/CquSCFJjYqivp6u9
	EUZKwN8ExcHNRLZN13r2dyBLkJ2pYWRZfqIh0q5K9QR/X3gU0x6bjIRJ1GV3nyL6
	nurjdRGlat641XvHv5DKfS0p/Wepaoqqnz6lFIrfxsBvWINUsbRBAG7XLAinUKYB
	7FQkVrncOef8Sp1syq77UUCVh20pEe7D35Yhs97Ed+TzBqg4IpR8mQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnbsrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 10:46:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5829f6wf040016;
	Tue, 2 Sep 2025 10:46:19 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf019p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 10:46:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTgCeckS1YvyxCPWXPXf2TejoHpJ+VkPsCHRVk66boHSx65o/bQw/p+b4fP9pim0eET0LuCBMpD0IOnX/geyi16fa3Z7zt3pwog31aBr3XwI/tCCPlQ2LgZK7JhoaaHqP6MIi45WFaQ5QmejxLTGasoMa3YM4dvFBHrFgAaXWxhWT+MV5y/Ts39mozrnzusFRlTI2godBA1kQrDbegoNVv2xkNohDrndZ2AW01R7PED5VDjGRMnyvSJLqx7D2Yy6pcJanmY4iKL5SxWHip9+D6ffvrTvGixINL3FaJNfAWb3PgiVEKtbLPH3fhgogthM/QQcp51iI7T8ZeUOqMghpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQlbg+4GXPMUEvVdNfrftrespk1rMZRB1pHeEVtpNUg=;
 b=jO2ji1LC39FMtBUei3V7Iz8QLU20OY0NPGQVAZHyfiX59R2gvSbBRSV1kj/o3na6xdGWiOOmjK3aRX822Hxl8hR7CjZlu2NAdaJP6f89eQM9nszez7yNsyT6MfML6e2x87sgz129Z5rPIlpnwZZPpOSPo9Ps8ygkLKctkVf3c+58l2+Y0UZGpvV5WIc3uSIFNa4fz5r9A7SCTXq+Fm2vuYDC1q0PhboWugVeHDirTRbKQwhCO/Ao4t1l90pkxCiXJgvYKVEf5SA4VfOIT1c8M0a5u/TFIeO1qiRyfF3Cct0jRKJZTsg5tFbmdpPz7XTPEmFBV2USga530Vx6HADOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQlbg+4GXPMUEvVdNfrftrespk1rMZRB1pHeEVtpNUg=;
 b=wVRqJP1N6V6GYhA64NfQ/3gbCpfITHBy/s+LJSXv2UFmSWcdwtbEH0EhwOnc6cDNtrty5C2ad+CXRvo29XMmNNY5dlycLaQIqR/+itPgBxNbR6w173jc5qlR8xkQ9JerOKi/RucFj1vAnqBKwMV0N3eKX5Nfi54ub5Rj3Hc1M7I=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB5203.namprd10.prod.outlook.com (2603:10b6:208:30d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.24; Tue, 2 Sep
 2025 10:46:16 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 10:46:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] mm: do not assume file == vma->vm_file in compat_vma_mmap_prepare()
Date: Tue,  2 Sep 2025 11:45:33 +0100
Message-ID: <20250902104533.222730-1-lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0430.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: 738cdebf-0466-445e-f3fe-08ddea0df132
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5kvngPS9SlglRikQ23CHc+nfPMx8xIr+kXoRv873I+mUmWSLtMQNUc0mQ9U?=
 =?us-ascii?Q?ez49J0mf3uxiPHjVuRER24paPbFC7mlvJ+LXJsiLQTzcfuaOWJuSQC/9vDQ8?=
 =?us-ascii?Q?bTtzz3wo2+EzbCB/OX9wAp+orSgtqDDJZ+4yGfuacomWWyBSuzX/LxpfSbTx?=
 =?us-ascii?Q?DdoJqZLFX6zn4kjfyFJW+8sqMPAhArskezJ4cDVLqkZ3NhQBSPDLY4q6sqyv?=
 =?us-ascii?Q?HXQjVkqmLPtJrQkoWZrENAH+yp6McmQRWtZiLUG+AMRbGIa3clgSdDBQ1gPr?=
 =?us-ascii?Q?LchL0pxAwUneETp+zcYkJGlAiT31M2HfGylqAr9MwZ7dNPurrfntvk+glfnZ?=
 =?us-ascii?Q?sX8lSGonVsGn3ID+5Z4+XAl//5ht0weuSmK6Ah2jYgcHvhqfU+plHSvsCkl4?=
 =?us-ascii?Q?T01y2Q32dvHYnr98BM6qU4gLmvGqAYn4dNLC3Mxzt5NjqjIDqyH73iBiStbH?=
 =?us-ascii?Q?BnN2GxygrzXL8+Uu7476UHuSMJcRq2Z9EUry1PldE/aaRnHbAQXHUkavMV7i?=
 =?us-ascii?Q?eLWZ+pny4FqA/tLQAD0lZbOvExtYQ2+71goASqCDhlPUDZe9Q8Khwo23679s?=
 =?us-ascii?Q?P6KgWJ7+R6I2aaryY/5zKUWE0c69+SThOUqxV05S9ZwGPdcTtkCHUf6RuDt2?=
 =?us-ascii?Q?aVKxFOx7sycF70ni1wH2gYOYyNsLkMIhbJs2+EgkEYKkJuc1mwfZ7yY8nsFU?=
 =?us-ascii?Q?4atGFpo4R0DMx0eR46vglVoZeUsoA9gJI3IovT78uKmTTD0VOR+wBu9LCNS/?=
 =?us-ascii?Q?r0ENC19TWP2JCuMWM4HtdsRgt3x9fW4+9o0H+LsEWjOGXVyQ96dJLZ9v9xrf?=
 =?us-ascii?Q?bQBYOoHzcnwW4QL14zqxRfxjUcx71RIWx09CKiHDhNyI6eiXq6Jq5LCZzdnQ?=
 =?us-ascii?Q?Aq/t1/81fHgdtR1K6zKyVGx0363ZKzR49XDXKG6TNn3aoBXfI15aS3cjePyV?=
 =?us-ascii?Q?FIywY5jI1z+QbJcBNhJ3a3l5BM8vovP59nVZ0VtnwH5CAcQp/hDk7raqTc4J?=
 =?us-ascii?Q?WDZAcJE0+TGcX2rGDnyv7jvUdUnyVVEuguCA+xhJ+Zi/0KNQ9+j4uxvnIUpC?=
 =?us-ascii?Q?f4Fw11ml3eHyXQWc5Px8a7aRqV3GCuNJsuOliyMEWv3s/OhpwQ5H62dY5j8t?=
 =?us-ascii?Q?pAe+PKIq1xfWkIs2j2Q0wkcPxxHfnrXwUh1NL4DBdKilN6+unbwo2XwTBgR0?=
 =?us-ascii?Q?QTRFlo/QBCUYu0J+PF6laxSF35wyMZjrQyVfKDtcXMXTK4fdmlpJutkgd+nW?=
 =?us-ascii?Q?2w6mPqhq1DVloKmWOF6k7Iqp4HN0QJ9V9lfEqYJD9rpkMqMFD3D4Wz+5PsNc?=
 =?us-ascii?Q?QTIRfuoTWzpYN/9NhN40aMPJcv/LSzP8PsnDSb2Jyu53bi0rWLavhCOCB328?=
 =?us-ascii?Q?be8AKMd6MFOnnuLv79J3t9kNdMQZaDQTy97ajfBRnhze2POeWiP/RktebSM2?=
 =?us-ascii?Q?vRE5d2JaGjw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R1BlJUlRh/1uWPo2NZFMifxTkFZgb1gD1+kaWWkA+AQk3aCvLjOWb9yU8eg+?=
 =?us-ascii?Q?oX6M+/DQ5r8bfIeWqZebQohpPQOoEY4GgYOUI7/ue3t1ZvtslTZJETGkX4MS?=
 =?us-ascii?Q?Ivc5PnRprO8KsPPT3NA8megFG6HOwjvBWeWjNyS1N2xAnqsush81Fwq2KkXP?=
 =?us-ascii?Q?426R/bLZTrU+slnjzVfire8fg0d0kskNlqNzofPTf6VQXeVCx1SmwpNzjGSa?=
 =?us-ascii?Q?ssNpeN6T0WFReVRB+3XD2YE8xIWYn9mldw/VRDiJs90Oxai55XyR94ZrhETJ?=
 =?us-ascii?Q?1kAqby1oe4OlJlo01vvEFFNsX3OIV2oALZZcgpZOReOStSrLylZNG2zZmFsB?=
 =?us-ascii?Q?MIEbV9nNhuiyX7J27zsT/Kt1E0Slua+kBq779MyF9qWZCDz5MXp9KfpDT1gZ?=
 =?us-ascii?Q?pmy7WjuA+M22rZmv1/FltUZ1gxYb0kv8PPPP01Ah0aEXxFy14VjPqTcOgHFk?=
 =?us-ascii?Q?4v0knO6xcK/nZRESKY6GX6ub8gGKzRDUL5/NsrEMft3cpFmDoqdNswPUjgzE?=
 =?us-ascii?Q?LBHQJtd94TmnBN5XNYJUWzoebMHFy4fzVIqSVrv12bQFSV8vzRq83Dpl0e7r?=
 =?us-ascii?Q?PqNUy+6TkQl5DRpOECABCB6hx6xn+L8CrQO3Usl8DWxbUZRCUq9hUT8MJpoA?=
 =?us-ascii?Q?1k8ZkjxzLlVHltsr+Tft9UA9OUsdJiEL2BJzlC3bcYPjcxfMMGsCS01J3AIc?=
 =?us-ascii?Q?gguCnfFAYirxi66Spv+BPnaMQu1BY9+hZOniXRlw01Bv273SWnV5PSAM83JO?=
 =?us-ascii?Q?/0GXgj/9zF4LiP7y96p32niTshuOQLLS0AFUUMGXdRpQXirAyrD9cLlTqEul?=
 =?us-ascii?Q?uuLQN+4SiofwhBst/ByBByf7caJwm7ze08t0cZ99CEmumI3icdWS4U971cP1?=
 =?us-ascii?Q?hArdX1E/5PMFqnHhUp5nfBXIheZYKoJCtKSMlNqcQII2VjCktoPTtTiigA3e?=
 =?us-ascii?Q?TImGHLbB40XpremgLDWpsHScSbEYafJGJZZNyP3uFQqeWesPEHSQH+7HhY3I?=
 =?us-ascii?Q?62+1JW4vxUkFsAbVmku4aklD+JrM62XW/IPRNx+A5bxDfFIL+i98vLQc3JFQ?=
 =?us-ascii?Q?cbg1g6wwYg58ayhevr6WCB5R2o4Wu755R9BhnIQF4i7oJ49AF7QNNzc2tWlD?=
 =?us-ascii?Q?ey5qhUCGrJBYLfzEuRdDBGd1lU+z6z2qnT91Sjhg+kosqUBPBIc8j9JD71b3?=
 =?us-ascii?Q?fieLfBxBeQMx6jU+AxZghH+BRb9NwZPD7tOkkvSVvkaCYB8b80+bAXpuXF8r?=
 =?us-ascii?Q?pCMuFyCYbwCDnT71Jj7pTrJzBcdoQ5X+4LSfv0GN5b4lFOLfvRhtJcb+80xG?=
 =?us-ascii?Q?EjTYOC9nLPZuoaQcWc+dH1wn1omKn4n8QsNU0RqXaUS+dsjw1VK++PhMBW+y?=
 =?us-ascii?Q?7BfFDsBtb4oe/NtTPPQWjJtc+mzSsFmrlLJzFJN0useOtXFj7kRpRscCCYl4?=
 =?us-ascii?Q?I14E3mbtaxXk9pklWYn6UMQ/YEsbJeEyEmuIJS+AZRDogfJlVw+VjAkbDe81?=
 =?us-ascii?Q?awy18ZhkVZICjtzOPdaSy2ojqQi50TFi+Y3V0g0oUsMy9qV/Hb23cCUhUofe?=
 =?us-ascii?Q?S72jQJhd4XH1h4DYdZ90UxKKyAzYQrkzaAGR2n+5CjFN28fyq3n8DYqrkD8z?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j8P4HdPMRVS9CzYSfdlWcy+qd+gYucct+fPFC/SdaOoRfuFYFE5IwgBPBc7jIsQlZEHSfwFEwXRjN+F9d5kFHpgSVO1nMmYMuljiHuXPLDFu/tkZaUsmpFyqOCXGAGkjldE+u49q4Zx7dQbaaNj2nfgGvz0Ut4LDiF9MHy5cHCUBRUrS0H7aXZjZOzcpCySQz1CkSjV6yIyOU309ta30ore9C+nbx8Si/LehBJW/MROd2F8FeeNIe0ivc2ZfoFNr7nUwOffdtnMiktLIyIMJgWpn365XSZTLC7ZkqrwKC8rdZyD8jSQStZNwHPcIi7pOJ/RVKBCnKkTcCGwedhFwxzz50cCQJd9NHyt6hPf9zxQsQs7jfZQeGPtaTbJOSxMH39xwHwX125mAp7daSMUVOv8wPkT9AzUoSUIyDwvSyTKyTXn36KE+70H5/pQ17jNtF6ocvs1h6C/yK3Xsmdh7JQy1KP+/od2XuJ//0U6CTWrDbcyXpG66P1mjCCwynlJaeTZHqJ8NB23F+lePW++b8/IbCkbmigS5GUy0hHBE6aiZw4jVRKo0Z6S3yJSB2IlnSNmpn5L010kbckDTZiUCg/5BHqtGG3jtCcnBMzujrZc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 738cdebf-0466-445e-f3fe-08ddea0df132
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 10:46:15.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQhrIlifKoV2aWyxdlwE27tsG0Cg2ZozKeFfoFuRL7xXcmZbgnXpPit3vWG4xo/NPr3bzyOp/8B+l8j+fqlX9A7+PZzSx9icn3dDEkwpwcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020106
X-Proofpoint-GUID: VqaVCQxf0qz8WEXxB6nfPhW22wv7eKTB
X-Proofpoint-ORIG-GUID: VqaVCQxf0qz8WEXxB6nfPhW22wv7eKTB
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b6cafd b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=N1-RtJtvj0_YAhC5OdkA:9 cc=ntf
 awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfXwmS7UNO9Ys31
 uXFj/7/4pzmsz7UEMjNRN2XLFinCTUMHNzOTSF7NWfzp8iqZrnLoM2bxyJITge9N7Wc0x+7VRx3
 ombPJLiQgvOz5cNozhP3Qh4wv1z8G+6rr6R7grFoSP/b1RYNpR/Eb55lfcsaLIeyyaLRwiIh5P7
 38Wo5kpq5F1Ihpqu0y2LlBFSGfGbUYf66j/cvY1WM/4JWM0SH066duNYFQMNR+zPL8Cm4R32YKI
 l209KdTK5Fgg/3qhMQjmiPURSRit0NT0KStfDFlzAA1eqhzVdmSy56HmPE8xmtBeVoe5Sk9QeFr
 D76LsD2JxzNS3XfMCZ+b9u3tIGnBCLjOMc7eSf/Agt/q9vtuYMb6fnNg7etv9rC3pQAl/E/fbfR
 1zbhYJSsiUVWaiFJjbqmwjiEta3W8A==

In commit bb666b7c2707 ("mm: add mmap_prepare() compatibility layer for
nested file systems") we introduced the ability for 'nested' drivers and
file systems to correctly invoke the f_op->mmap_prepare() handler from an
f_op->mmap() handler via a compatibility layer implemented in
compat_vma_mmap_prepare().

This invokes vma_to_desc() to populate vm_area_desc fields according to
those found in the (not yet fully initialised) VMA passed to f_op->mmap().

However this function implicitly assumes that the struct file which we are
operating upon is equal to vma->vm_file. This is not a safe assumption in
all cases.

This is not an issue currently, as so far we have only implemented
f_op->mmap_prepare() handlers for some file systems and internal mm uses,
and the only nested f_op->mmap() operations that can be performed upon
these are those in backing_file_mmap() and coda_file_mmap(), both of which
use vma->vm_file.

However, moving forward, as we convert drivers to using
f_op->mmap_prepare(), this will become a problem.

Resolve this issue by explicitly setting desc->file to the provided file
parameter and update callers accordingly.

We also need to adjust set_vma_from_desc() to account for this fact, and
only update the vma->vm_file field if the f_op->mmap_prepare() caller
reassigns it.

We may in future wish to add a new field to struct vm_area_desc to account
for this 'nested mmap invocation' case, but for now it seems unnecessary.

While we are here, also provide a variant of compat_vma_mmap_prepare() that
operates against a pointer to any file_operations struct and does not
assume that the file_operations struct we are interested in is file->f_op.

This function is __compat_vma_mmap_prepare() and we invoke it from
compat_vma_mmap_prepare() so that we share code between the two functions.

This is important, because some drivers provide hooks in a separate struct,
for instance struct drm_device provides an fops field for this purpose.

Also update the VMA selftests accordingly.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               |  2 ++
 mm/util.c                        | 33 +++++++++++++++++++++++---------
 mm/vma.h                         | 14 ++++++++++----
 tools/testing/vma/vma_internal.h | 19 +++++++++++-------
 4 files changed, 48 insertions(+), 20 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d7ab4f96d705..3e7160415066 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2279,6 +2279,8 @@ static inline bool can_mmap_file(struct file *file)
 	return true;
 }
 
+int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma);
 int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma);
 
 static inline int vfs_mmap(struct file *file, struct vm_area_struct *vma)
diff --git a/mm/util.c b/mm/util.c
index bb4b47cd6709..83fe15e4483a 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1133,6 +1133,29 @@ void flush_dcache_folio(struct folio *folio)
 EXPORT_SYMBOL(flush_dcache_folio);
 #endif
 
+/**
+ * __compat_vma_mmap_prepare() - See description for compat_vma_mmap_prepare()
+ * for details. This is the same operation, only with a specific file operations
+ * struct which may or may not be the same as vma->vm_file->f_op.
+ * @f_op - The file operations whose .mmap_prepare() hook is specified.
+ * @vma: The VMA to apply the .mmap_prepare() hook to.
+ * Returns: 0 on success or error.
+ */
+int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma)
+{
+	struct vm_area_desc desc;
+	int err;
+
+	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
+	if (err)
+		return err;
+	set_vma_from_desc(vma, file, &desc);
+
+	return 0;
+}
+EXPORT_SYMBOL(__compat_vma_mmap_prepare);
+
 /**
  * compat_vma_mmap_prepare() - Apply the file's .mmap_prepare() hook to an
  * existing VMA
@@ -1161,15 +1184,7 @@ EXPORT_SYMBOL(flush_dcache_folio);
  */
 int compat_vma_mmap_prepare(struct file *file, struct vm_area_struct *vma)
 {
-	struct vm_area_desc desc;
-	int err;
-
-	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
-	if (err)
-		return err;
-	set_vma_from_desc(vma, &desc);
-
-	return 0;
+	return __compat_vma_mmap_prepare(file->f_op, file, vma);
 }
 EXPORT_SYMBOL(compat_vma_mmap_prepare);
 
diff --git a/mm/vma.h b/mm/vma.h
index bcdc261c5b15..9b21d47ba630 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -230,14 +230,14 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
  */
 
 static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc)
+		struct file *file, struct vm_area_desc *desc)
 {
 	desc->mm = vma->vm_mm;
 	desc->start = vma->vm_start;
 	desc->end = vma->vm_end;
 
 	desc->pgoff = vma->vm_pgoff;
-	desc->file = vma->vm_file;
+	desc->file = file;
 	desc->vm_flags = vma->vm_flags;
 	desc->page_prot = vma->vm_page_prot;
 
@@ -248,7 +248,7 @@ static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
 }
 
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc)
+		struct file *orig_file, struct vm_area_desc *desc)
 {
 	/*
 	 * Since we're invoking .mmap_prepare() despite having a partially
@@ -258,7 +258,13 @@ static inline void set_vma_from_desc(struct vm_area_struct *vma,
 
 	/* Mutable fields. Populated with initial state. */
 	vma->vm_pgoff = desc->pgoff;
-	if (vma->vm_file != desc->file)
+	/*
+	 * The desc->file may not be the same as vma->vm_file, but if the
+	 * f_op->mmap_prepare() handler is setting this parameter to something
+	 * different, it indicates that it wishes the VMA to have its file
+	 * assigned to this.
+	 */
+	if (orig_file != desc->file && vma->vm_file != desc->file)
 		vma_set_file(vma, desc->file);
 	if (vma->vm_flags != desc->vm_flags)
 		vm_flags_set(vma, desc->vm_flags);
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 6f95ec14974f..4ceb4284b6b9 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1411,25 +1411,30 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 
 /* Declared in vma.h. */
 static inline void set_vma_from_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc);
-
+		struct file *orig_file, struct vm_area_desc *desc);
 static inline struct vm_area_desc *vma_to_desc(struct vm_area_struct *vma,
-		struct vm_area_desc *desc);
+		struct file *file, struct vm_area_desc *desc);
 
-static int compat_vma_mmap_prepare(struct file *file,
-		struct vm_area_struct *vma)
+static inline int __compat_vma_mmap_prepare(const struct file_operations *f_op,
+		struct file *file, struct vm_area_struct *vma)
 {
 	struct vm_area_desc desc;
 	int err;
 
-	err = file->f_op->mmap_prepare(vma_to_desc(vma, &desc));
+	err = f_op->mmap_prepare(vma_to_desc(vma, file, &desc));
 	if (err)
 		return err;
-	set_vma_from_desc(vma, &desc);
+	set_vma_from_desc(vma, file, &desc);
 
 	return 0;
 }
 
+static inline int compat_vma_mmap_prepare(struct file *file,
+		struct vm_area_struct *vma)
+{
+	return __compat_vma_mmap_prepare(file->f_op, file, vma);
+}
+
 /* Did the driver provide valid mmap hook configuration? */
 static inline bool can_mmap_file(struct file *file)
 {
-- 
2.50.1


