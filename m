Return-Path: <linux-fsdevel+bounces-67455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCE5C40D30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 17:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7710F620AFB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F110132B993;
	Fri,  7 Nov 2025 16:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Di9erlAZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M1w0la9f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E830330D54;
	Fri,  7 Nov 2025 16:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531982; cv=fail; b=nPydCBmq9ntdUYN6qL2B22bGSQCu3auCNmpp+67kBPIpDeE66TWUK3rMKaydcL2ij7ERH+fmLqAeGH6bpBq+R83jqvNKeJ77Wz1lITXvb7NJI/TkWAxpscrVebuCVG3tTtV9HdlRR4mFoKLB2YOZFPptIPKTg0F6SdL7rGfwCrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531982; c=relaxed/simple;
	bh=x0iuaP3rDNN6t5Y/3AncVZ7zn6YUT/FIXyg/iEKtZ/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hoI+dId7QJSbFuGtGzpO+CnJOhvvlPsC1cNhdngmWH9csWMkrkHe9sZ5skQt6H9Y525Iief8JXEegbE6atlrLDIunTMFNXT5z4hvayJGDREUlp6pEa0G72mtbHWodEQ5OKeFZapFuhUcusb50KjexlyUSiwVNUhdQ704Kn6wNg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Di9erlAZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M1w0la9f; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FbWbm005403;
	Fri, 7 Nov 2025 16:12:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5n9a4wR+KTYNXrwK/jwgfbiyIdwJgIbDEuB6CfWSY30=; b=
	Di9erlAZhB/bOWBmFO/z7z3cxIGqjZ5XbFHOFMNyIyuSeN+FCQnXcx/0iDhIcYjC
	1knjw3XVUs/2mrb69NMpzGoTREsrUtFpQwJSdLHkpPcgZyI2Dm14k90X1HtoOE1i
	N2eThQLLs/aA0DHDkBzgONCv9yanwDEmAFLFCaHJ/on5kXjteGKl33ddOKf9ZoB3
	dZC1OG1yZ+wbP1ItJHHmukAMW3v4tZeyfrFu4IanWlve7uc/Bq19vyEuk08EHMaz
	EcPqv21rB7vGaD8mNZBFOwxdQPoQigByBVySG+djXxD3sILaOhiLYaVbDrxhWKLT
	f25LCkj3WDsqqGrCmI29SQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9jqmr6nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FKe5L035995;
	Fri, 7 Nov 2025 16:12:21 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010056.outbound.protection.outlook.com [52.101.61.56])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nqt10a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZGwnAK2qHSGvHgpIATptTkTyoSFWaMlqhCRUh+xp2uRaG8yDxGZSrHI7BgPaIzDFoMTuweSHF62Wn05WO/y96XTt1rNMslXETN+SBW4viVNInasnAZ9dUBIMsQAMmTNxMfUoKDw46Wnv9CescXOuSJ2wqhQqQxtyPM7ZEZ5eyksFdRetBccLvZo0cb6UWvwKEyfxxm+E09T7NP5bja4UR+xN3RtTV5/rhH7sicMISKq56yryeyd7bQ/ZA3Wqg5sgghDPLWja3f9Gp3k7TAonq/QdNewAKqtkPBGy9NJxQvfVlYzjmnKNxvcrhteZT6oRnTdDNy7so5/P6hjz9mD/rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5n9a4wR+KTYNXrwK/jwgfbiyIdwJgIbDEuB6CfWSY30=;
 b=rjENKoqv+l+hvU+6Vsslhc1k5xmDbfbf89dNlvjXvJ0I1iv34okCSheM+lLZ1RCL66Z24ilx4QXpj6mwRMp6GQFrdHHhF2/JdxCNOSTPg9FBK/KimcAYkHcHGLxgF8aOLaZja7uzn6cQD606CpU0c2+oHA4kpjS1FJMwjvV0Rs1Wpfd1Fx8x+nx1860zQZZsaN8EIDKaoVD7eASJuyDMLdz3cY+bHEKIafq39PdJX53di9xHNQVqL9luRao65g8Njg9U5YRn/y9CoakUB4eOYVxg3EBQpaE46A/TiMdjkJm90xdKZ2G8bvq9MQSYox1I5Fe4Q8wSrkSJXef/my+C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5n9a4wR+KTYNXrwK/jwgfbiyIdwJgIbDEuB6CfWSY30=;
 b=M1w0la9fKJMpjZyUPlfg2D7gCeUofBJUFXNZ+k2Arm2PCS5Y3zQvo2SPqMYIyN3+H87XvyRaVGU92fl7s1FJc3Nqwv3qOvPToxW8vyWNaIw8FxQWa3QO3wmQQG0+SNVX610RXLEvnNhGFNX+4yPEFfqLhBCb2+Nu5uxbRwg8fBc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA0PR10MB6913.namprd10.prod.outlook.com (2603:10b6:208:433::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 16:12:09 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:12:09 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v3 5/8] mm: set the VM_MAYBE_GUARD flag on guard region install
Date: Fri,  7 Nov 2025 16:11:50 +0000
Message-ID: <99ce6131e27592c92b43ac866da48b4c2a568298.1762531708.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
References: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0103.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA0PR10MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d0bceea-5f18-4c94-9762-08de1e18672d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lit/3T0gFFSuxSSvrrR/iKsiSM/opVA6jjcGuajTqLz8OJx6CbxBDOjqU9JE?=
 =?us-ascii?Q?GSPhr1C7GI8EWJfK2nMsuDphXGNUWVtFBsYgnbbERGWIg6hPyZ471VZhWK3D?=
 =?us-ascii?Q?CM/2inVfmyV69zHV8s6vUKxmmOKs6lc3T3eFGtI5V4Yh6XAQH1JOn1/ks9wo?=
 =?us-ascii?Q?2TPF4goRhOkjJk7Ht1H7NX4oZ2kYFNCeqTuchX0J8LOcEuaxzj3qy9dXVIbL?=
 =?us-ascii?Q?ul1qmf5Bz2ykwEKLyCq/1IvWRPo0TY8yLsWzjG4T5gDN24qGU6SEy5xJZorA?=
 =?us-ascii?Q?plOtaLm6vJ0FRzUdyQB4ph+eK1vhMm1DY6+RSA06h4mQg79alRjMhVmDvUXz?=
 =?us-ascii?Q?3DnY601LhYJOwXximzRj4qHxOVyZh7u/FPzks+ICdPvU68PqiFEOW1luj/fb?=
 =?us-ascii?Q?AOb7DCHlBq8PyyDoRKxNZgIChpaKmxN5nVbgg3WvpgbXiirc3O/D5VP46RH+?=
 =?us-ascii?Q?MCE2YdBUgmTUedAp1WBqqNsaJw3isE3JIGhyDxeucvN7EQGF0AggwOj19YFe?=
 =?us-ascii?Q?5kvEv0IVAVXOgdPUPkkGPvGkHV0IE8WYtTaGhExBrnH5+IQmw2y5PEDRHpkd?=
 =?us-ascii?Q?pPGBZYeSLdiE8IobyhFnUQfZnhxJyy3eGjHH67prxNvokViKLsJHJZPNDHww?=
 =?us-ascii?Q?BlaLTTwy5RBITtRRmXjASibIcIv54f5/Rjjn+uq+KF5eCngyinDLiPIWXv4D?=
 =?us-ascii?Q?bLFMatByrIDClbxeekHmVFSg937XXSsGewqEgyyT4cBzvrwCh/YYIGwmqIcC?=
 =?us-ascii?Q?Wd+JZ3o8wklv460VRTgPpXSvXhviAIuohcSUWL+nwaTp4iICbkxY+7o4+Hja?=
 =?us-ascii?Q?eP2O7MbMnvKceXTTiMLz/4NQu0lxkSvoxwwHXpsKj9IG/cHo1wE0njACNaRU?=
 =?us-ascii?Q?TTVVoZesBd+nmJPlHdJaB/MsYAXX+3vAQV9L9B25W/XRD8Ud+oHDyvpRfA1L?=
 =?us-ascii?Q?gS1w/5MgkOTChICwaviG+WYnlrbsaSnhC9AzCDCFddN+D1iB96QPdZmsQt8K?=
 =?us-ascii?Q?mihYiVpehjrjkFmy7A5yVQHD8FzLsxKbYnEVCOj/I9Dq6LJpFiL0B9r/ACdP?=
 =?us-ascii?Q?idhmSh2NrgcfkfMO9mxljdVrj2LV5czfV5fXyqgbT4P+Tfcrfqu9WqmEPPWP?=
 =?us-ascii?Q?gy2XW1delCqcPbgw53L8Rj01oTuvM64oTVBktuj8OpoIsejZLUEqyMp7tRVw?=
 =?us-ascii?Q?pcWJvtocLl9Qf4ZAzo6MVKUODomMWGNMANklfQKTLO3wwic5oP+KIVsyLQmE?=
 =?us-ascii?Q?XIxPHdjJSPpf+MJqjmfGZVjSKq559Hovk6lqPi0PqHA1OqHuyG5LtbEUKJal?=
 =?us-ascii?Q?4u07NLdhrY7ycDAjhjUJRyLxobJktD0DD3CZ3zwikBF1y+8Wh7cNciHEnPIQ?=
 =?us-ascii?Q?oedk2OxmlaL4uQJAUgPZnYVVPCx/HNBGHfjzd19sdn89nKnpCTbdEYSAaSXA?=
 =?us-ascii?Q?41dQBbrsGmUv20meDj+NLKqGjXwMqcP8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K5R9HjOF1qRd/cjUFoKKZD7IjufbkFFYzvkWK3m4j/S7FSddXg6kSXGpS4gI?=
 =?us-ascii?Q?NuwzME3OVxu1hr/uC9mHoRZgsGCY3WfKioRp7M7FUz1loS5gRF7aJHdICYAJ?=
 =?us-ascii?Q?Z4cC0d6bRAXiC3BKzuKcv+iBQ9cHLJksDX6nYDmiMRi8MJW6J634PME1hxfi?=
 =?us-ascii?Q?FbP3ckA1WTSz54hG0MECwey3ivaECBcwFoMJsn1nXPBaNlPf3X8viUdG9oLp?=
 =?us-ascii?Q?N6WkTCF/+n4RnEWUJMq+bITWQwV4mxofBxJrGM11i9Aafgra4WMU5l9SaKjc?=
 =?us-ascii?Q?XuTUYatBZeVtZnrXamnHMU0jTK1pw/5C+0/k6xbwKY9IfVdnc7Zcn1w+l4Zq?=
 =?us-ascii?Q?kxtK38R+WUVlcd1tN3ZauinxjK9k6yVhjSrL8EmAQulSkRZrg0xQs0C+fuGv?=
 =?us-ascii?Q?GP3oiEIYQz+4arAE4ofDoEHWcNZSevMpQvZ0Rx3VCq/jLRTRHmIntVYNUXrb?=
 =?us-ascii?Q?bO3hKnWN/gM4KAFc9lcnKc/EVTVs7r4FDTX5uSvuCrvf6YYy2u3Zq3bNHEk6?=
 =?us-ascii?Q?AuQrFY1WeHIcekFBqmp+r3+k6uO9CNGiPDoaYanK3iEQQtjJgtd5CGX+Jglr?=
 =?us-ascii?Q?c6uhKJQIPk1PW/n8/6iVMIzQdebveDMJUb5fEgD0eO/OmugXc6lJqJxpMgBU?=
 =?us-ascii?Q?7FGBdw8IWkRQpTKO2SKuIYPqhCqUHiUWp7TIs90B7gbEWFnMjg7uAzZAAhOZ?=
 =?us-ascii?Q?d2apMFpeGSkQbEFkzpFsscDOrkDA3RsvNRwr5k7eakIuERMqz9l7OODiVemh?=
 =?us-ascii?Q?vAmI2Q99lB1igLYZrSxPaJvmXVzVkqwREmtqdSI3ugK43asBl0sxtmgYamxj?=
 =?us-ascii?Q?HTMqQiYDR/wtoyImR+dgFBXchZ2TwY3rNSdFikII6ajrT3YM/w/Xa5nHntZI?=
 =?us-ascii?Q?x6GdqPsY7gdVL/cc9yZehAPKHJJP7++ZAvxghx9LM0UynRZpfBMAH8smX5vn?=
 =?us-ascii?Q?62IerRi4rXqrKjDfFBjq5pgQcPIhQN2DBzifbhvkqiHdd8ZCUbNw3KeApjB5?=
 =?us-ascii?Q?45b43UimmbYqV1xAuXaEvmxhmMdg+xTZRR+40EbQiyEADPW1Fd51AeH9RvxI?=
 =?us-ascii?Q?XqaOkxXPm6hDQPXejfUCD7PiFenMphovQ0BTakGjcUCNJbUDO5CJPdJOZTz1?=
 =?us-ascii?Q?paeiExsNaeeSWfgzggah0t0xGp5ng3L93nPPMfiSwtTdJJZkUzkJnSJcgWnr?=
 =?us-ascii?Q?CqPtOboueTyAJMbIYMvFhK9wFnJ3+tStgOGd+4Rjadg8UDm56YVPtuxpetfb?=
 =?us-ascii?Q?TPbUge6pcPDJ8ty3mfjMMB1ZVM8lbVNUgP+I+L7qOj+BhJY0XW8SEokxLU5n?=
 =?us-ascii?Q?zqcS/pzxQQPK5DdA28s1FToQSqyWcVNbAtwNHrI8Sako1M4UQb0dOi4SgB+k?=
 =?us-ascii?Q?EZmmn2vMqx8H8XPBbNeCUozhQoxb+8Q4u2+yqwqfmM1nc6st+b/H9opcgiMB?=
 =?us-ascii?Q?lh9+Pxuy6alE1qYegY54+Dd4Fm8lgedwnROb+gXZ22VenSbrm9sJi9Gef7Zw?=
 =?us-ascii?Q?Rjl0OF8o9b32pM3uW3dmRH8wC15WuBWm/LhiGesDqi6FXd6aWrkqGF7YmE68?=
 =?us-ascii?Q?FU8SmLp8Hjb1p/nhjqSZegxldTgh3kKEOETqG3+rjLAowiF4vmcsjMGC7VZI?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aQXvqLG5/w001/XiZlqLlSgrDFBppLziK0+gzyQ2hMfvIP5xKYyFdRho3Qm3Sf8Xf11bJ/LYzLPwbdTCi+zZo6TcpQQwbpM+SzYW6YdM0mxVWT67xA5LD9YvbfemwtE4VlWSY5ijWL1BOylCWpyyRTIedia089lNUPjKo6nIwU8kRWF8KuIVixNg68Niu1Ctw6K2u3y5+5wQ8nTb+8zYe+p1vLAcbNPaxsizdv5uww0263U1OB07IahigaE75x8tfElcnFd6QnWzg52SkYXjswCTCfpjbRzKNpJw7GEGtmaSqKm8LhEgPDC4gddypT6E6P+MpUjtw3unsNeZ3yUkedVLbiVsBFOu4MXc6Z++2EsOaTWwgxbL2CXyG47CUlmbllBJlZbqnTDo0M6yoMr/GnoUUm0vsMeD4QLHHAvLciKvoLfO7X17NMTlWq/Mx4bjyC6LTY1C1FyOIWdALNW3U7thxESID+mDhw/9tLAzxL2B/woAEKR+uOKA7Ov1cIuvz+7uhuUlnvUJ9/Z6GYBxU9irQlsDbof4rYj+1V3bTQzaEeU3q3r1F7XoDmKO60N0swncUiL7y8Y83FVImO7uhYE3kMSYwhmBX6OYjugq3TI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0bceea-5f18-4c94-9762-08de1e18672d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:12:09.3969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYUqrtxnfyrMGpnJ58314ZRFZZDyOalDFMcFjKzhfeb/hfNSbH88WUfXwflAVtAC51NNDMmja8S9qlp4IZt+QrRg6cIH4IZNJr8DMUrgiVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 suspectscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070133
X-Authority-Analysis: v=2.4 cv=TPlIilla c=1 sm=1 tr=0 ts=690e1a66 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=XKGIyjddN6tvVtJ7z4kA:9 cc=ntf awl=host:12101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDEyMCBTYWx0ZWRfX6WGBSgdOQ1PA
 0bnM/WosADvlb74o7S3G4KiZ5/aEjBExbRVc24MmjjUJrokp7YySZJbYwHKGCGCln+b2nb9EC5T
 EgQ+L1O3qFOsoMjxERiNEZEQtHfVQO2KtKNJa0nOHH6uhjvR+WKxNjlLy1uS3GPQt9uwGEIAWws
 fpDlrl0VsXMrtZyonDPEGfus7aDWJ4o0LA93ImcqomYDqEzwExKN6MI/hpClieZyI3gPu89el0v
 SZhfCks9mcMlDnBYtuAt9KD3NRSjW4+PR+OL1toEoj9jtkjFhuk+qEm7u3FrVQJ+u8z6XPmrnn2
 XSAI7Ax3QtC/SwQuexToFRhqU1Z6Q6tiap6BqZ4pGFHSVYPtbWaaE/cMG/UNw1izx8wBn47TzT8
 WWtTakF1nFNBzJXaykM90cs18q65b5Otpl1lmogxHz5VGlD12o8=
X-Proofpoint-GUID: Rxj8bO76qOLsqVxYX7ziREJ2ssaZ_gjx
X-Proofpoint-ORIG-GUID: Rxj8bO76qOLsqVxYX7ziREJ2ssaZ_gjx

Now we have established the VM_MAYBE_GUARD flag and added the capacity to
set it atomically, do so upon MADV_GUARD_INSTALL.

The places where this flag is used currently and matter are:

* VMA merge - performed under mmap/VMA write lock, therefore excluding
  racing writes.

* /proc/$pid/smaps - can race the write, however this isn't meaningful as
  the flag write is performed at the point of the guard region being
  established, and thus an smaps reader can't reasonably expect to avoid
  races. Due to atomicity, a reader will observe either the flag being set
  or not. Therefore consistency will be maintained.

In all other cases the flag being set is irrelevant and atomicity
guarantees other flags will be read correctly.

Note that non-atomic updates of unrelated flags do not cause an issue with
this flag being set atomically, as writes of other flags are performed
under mmap/VMA write lock, and these atomic writes are performed under
mmap/VMA read lock, which excludes the write, avoiding RMW races.

Note that we do not encounter issues with KCSAN by adjusting this flag
atomically, as we are only updating a single bit in the flag bitmap and
therefore we do not need to annotate these changes.

We intentionally set this flag in advance of actually updating the page
tables, to ensure that any racing atomic read of this flag will only return
false prior to page tables being updated, to allow for serialisation via
page table locks.

Note that we set vma->anon_vma for anonymous mappings. This is because the
expectation for anonymous mappings is that an anon_vma is established
should they possess any page table mappings. This is also consistent with
what we were doing prior to this patch (unconditionally setting anon_vma on
guard region installation).

We also need to update retract_page_tables() to ensure that madvise(...,
MADV_COLLAPSE) doesn't incorrectly collapse file-backed ranges contain
guard regions.

This was previously guarded by anon_vma being set to catch MAP_PRIVATE
cases, but the introduction of VM_MAYBE_GUARD necessitates that we check
this flag instead.

We utilise vma_flag_test_atomic() to do so - we first perform an optimistic
check, then after the PTE page table lock is held, we can check again
safely, as upon guard marker install the flag is set atomically prior to
the page table lock being taken to actually apply it.

So if the initial check fails either:

* Page table retraction acquires page table lock prior to VM_MAYBE_GUARD
  being set - guard marker installation will be blocked until page table
  retraction is complete.

OR:

* Guard marker installation acquires page table lock after setting
  VM_MAYBE_GUARD, which raced and didn't pick this up in the initial
  optimistic check, blocking page table retraction until the guard regions
  are installed - the second VM_MAYBE_GUARD check will prevent page table
  retraction.

Either way we're safe.

We refactor the retraction checks into a single
file_backed_vma_is_retractable(), there doesn't seem to be any reason that
the checks were separated as before.

Note that VM_MAYBE_GUARD being set atomically remains correct as
vma_needs_copy() is invoked with the mmap and VMA write locks held,
excluding any race with madvise_guard_install().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h |  2 ++
 mm/khugepaged.c    | 72 ++++++++++++++++++++++++++++++----------------
 mm/madvise.c       | 22 ++++++++------
 3 files changed, 64 insertions(+), 32 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7946d01e88ff..f4d70b7fc03e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -955,6 +955,8 @@ static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
 {
 	if (__vma_flag_atomic_valid(vma, bit))
 		return test_bit(bit, &vma->__vm_flags);
+
+	return false;
 }
 
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 1a08673b0d8b..c75afeac4bbb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1711,6 +1711,43 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	return result;
 }
 
+/* Can we retract page tables for this file-backed VMA? */
+static bool file_backed_vma_is_retractable(struct vm_area_struct *vma)
+{
+	/*
+	 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
+	 * got written to. These VMAs are likely not worth removing
+	 * page tables from, as PMD-mapping is likely to be split later.
+	 */
+	if (READ_ONCE(vma->anon_vma))
+		return false;
+
+	/*
+	 * When a vma is registered with uffd-wp, we cannot recycle
+	 * the page table because there may be pte markers installed.
+	 * Other vmas can still have the same file mapped hugely, but
+	 * skip this one: it will always be mapped in small page size
+	 * for uffd-wp registered ranges.
+	 */
+	if (userfaultfd_wp(vma))
+		return false;
+
+	/*
+	 * If the VMA contains guard regions then we can't collapse it.
+	 *
+	 * This is set atomically on guard marker installation under mmap/VMA
+	 * read lock, and here we may not hold any VMA or mmap lock at all.
+	 *
+	 * This is therefore serialised on the PTE page table lock, which is
+	 * obtained on guard region installation after the flag is set, so this
+	 * check being performed under this lock excludes races.
+	 */
+	if (vma_flag_test_atomic(vma, VM_MAYBE_GUARD_BIT))
+		return false;
+
+	return true;
+}
+
 static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 {
 	struct vm_area_struct *vma;
@@ -1725,14 +1762,6 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *ptl;
 		bool success = false;
 
-		/*
-		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
-		 * got written to. These VMAs are likely not worth removing
-		 * page tables from, as PMD-mapping is likely to be split later.
-		 */
-		if (READ_ONCE(vma->anon_vma))
-			continue;
-
 		addr = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 		if (addr & ~HPAGE_PMD_MASK ||
 		    vma->vm_end < addr + HPAGE_PMD_SIZE)
@@ -1744,14 +1773,8 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 
 		if (hpage_collapse_test_exit(mm))
 			continue;
-		/*
-		 * When a vma is registered with uffd-wp, we cannot recycle
-		 * the page table because there may be pte markers installed.
-		 * Other vmas can still have the same file mapped hugely, but
-		 * skip this one: it will always be mapped in small page size
-		 * for uffd-wp registered ranges.
-		 */
-		if (userfaultfd_wp(vma))
+
+		if (!file_backed_vma_is_retractable(vma))
 			continue;
 
 		/* PTEs were notified when unmapped; but now for the PMD? */
@@ -1778,15 +1801,16 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
 		/*
-		 * Huge page lock is still held, so normally the page table
-		 * must remain empty; and we have already skipped anon_vma
-		 * and userfaultfd_wp() vmas.  But since the mmap_lock is not
-		 * held, it is still possible for a racing userfaultfd_ioctl()
-		 * to have inserted ptes or markers.  Now that we hold ptlock,
-		 * repeating the anon_vma check protects from one category,
-		 * and repeating the userfaultfd_wp() check from another.
+		 * Huge page lock is still held, so normally the page table must
+		 * remain empty; and we have already skipped anon_vma and
+		 * userfaultfd_wp() vmas.  But since the mmap_lock is not held,
+		 * it is still possible for a racing userfaultfd_ioctl() or
+		 * madvise() to have inserted ptes or markers.  Now that we hold
+		 * ptlock, repeating the anon_vma check protects from one
+		 * category, and repeating the userfaultfd_wp() check from
+		 * another.
 		 */
-		if (likely(!vma->anon_vma && !userfaultfd_wp(vma))) {
+		if (likely(file_backed_vma_is_retractable(vma))) {
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
 			success = true;
diff --git a/mm/madvise.c b/mm/madvise.c
index 67bdfcb315b3..de918b107cfc 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1139,15 +1139,21 @@ static long madvise_guard_install(struct madvise_behavior *madv_behavior)
 		return -EINVAL;
 
 	/*
-	 * If we install guard markers, then the range is no longer
-	 * empty from a page table perspective and therefore it's
-	 * appropriate to have an anon_vma.
-	 *
-	 * This ensures that on fork, we copy page tables correctly.
+	 * Set atomically under read lock. All pertinent readers will need to
+	 * acquire an mmap/VMA write lock to read it. All remaining readers may
+	 * or may not see the flag set, but we don't care.
+	 */
+	vma_flag_set_atomic(vma, VM_MAYBE_GUARD_BIT);
+
+	/*
+	 * If anonymous and we are establishing page tables the VMA ought to
+	 * have an anon_vma associated with it.
 	 */
-	err = anon_vma_prepare(vma);
-	if (err)
-		return err;
+	if (vma_is_anonymous(vma)) {
+		err = anon_vma_prepare(vma);
+		if (err)
+			return err;
+	}
 
 	/*
 	 * Optimistically try to install the guard marker pages first. If any
-- 
2.51.0


