Return-Path: <linux-fsdevel+bounces-9438-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A486F841469
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 21:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D09A2882E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jan 2024 20:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0C9153BC4;
	Mon, 29 Jan 2024 20:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jARGvkVu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yvDUuStq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD06354278;
	Mon, 29 Jan 2024 20:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560623; cv=fail; b=K6KhAxqooICTMIZ9r26APMibvqAcNPLC+SSY1vmh1ekKkGawcXRJruxXHeGwZbXTs6+lernDy5sU5RwGKD3C4IjQVTwSRe2OAQwdkGxjvrG1L6PLKh7gpxXAkpjxNIShf6doH3poTOESs77gVFNRJTsvhHuwYO5EfFnRXzWqtyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560623; c=relaxed/simple;
	bh=5fdOFcSRh6IYU9nBTbHLmT2sf0lcKc74pJ2RohMySfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i33nRx2Yx5v1k7xniUXY0tVK4Bb4/vzuNUpg1ExMNYJWhWlROw+oqWplR7oNYMHUuR8RCfqe3dgNq6cjlSHAUGJU/a8VJJTKzr+sSwPvasUS66JG9wfAbwkFl+aQyphK76iKdt2EeSa96B0WZ9qWXfuxihPxB/P8mo5w2rN8hsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jARGvkVu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yvDUuStq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=Oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJiRBR004393;
	Mon, 29 Jan 2024 20:36:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=Fn6SXIzsZearuhTwENRepj1LjkbrfyAiH9V0OdqhtCc=;
 b=jARGvkVu+uYZUdL6iP/J+QN0Pk4qrgvp/a8Vtr6f/I32cm+QyObp7CrHPbPESLJq2bbO
 KPTpNv2oD6XBYw3D6ywo2Ebr1xCb9KTJ5KcTPHzWR/enQEGsnmsCCklbgbT6RebeIEsn
 BrcVWYiHRuEGYBHlt5sUsesCq7cKevE+2m1FNHDSKPj9WI6T0cbBtfS92e7vqRhr0EqS
 3HfzYOq9WuWSaLlvlGKad5TYP9+jgik0uzDtG4QvXLep33F+MY1Ht59oFRwrB0nuK0bh
 CQHS+JC4+9GicAwWJjRyzYGofmiRiInbauHTmeJXQ3jwdUHKmhOPa1yuG8oso0t+2zT8 dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvsqavwa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 20:36:35 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40TJ1rdD035346;
	Mon, 29 Jan 2024 20:36:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9c6gfr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jan 2024 20:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=koknyzsfg1PynBuYRPCJfpaekzlFqAPHuCpB7GMcXFm/5ikNUZcjMfOFI275BvRztt7ezpvQdXZh6kgFM4f/ixbOWmOUVsoQ/7fRcgEWVDKIcdm4l5Jrir9kg0SpEzICCdxsO64abC8N8/MLDkNICgtJrLumt1B7CQmBGKOu4pPRtIKEm+exM86h0Tqc8bVuNNxT0oPMc/IgSY+ftsIVxsyY5wZwaPOpAifoQLe0dby2h/ui+ZxL4MgEXI1giOmFd8BXyvXOV2Wz0lCbwSrpe689S51Vzafk3YLVUec50dcqJeBgUqFZ4hRHhjES1ohCgJGHEkA9AG80OFaW3qrTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fn6SXIzsZearuhTwENRepj1LjkbrfyAiH9V0OdqhtCc=;
 b=VNsPelaPWyRKcF7FTth2+9jZZDryLohUSO3pCn/5+Vd0eOjUXNbyd05VNBR+UNTWS4qvRSRgmICxzR4qOy2+rmozoC2uNp3S8L3kBLuVKWmQnoH8zAL8WX6EIwzeouLxG7V0BPdcUG4DXwpx6sgiESsFc7jcu5W7zALul9xQo+9OrUnVSX2E/lw2oDRwO1gaTLU66/z5DkwKXH4gRhxQUzb+LK4yydIK/pL0lJjtGRa2e3mtRfi3aB/VDwl1pTAfDjtHeAbtxOk5mQBpPNjYRED9f0J/NEZbkujbDrmKL24Uk3bkF9VyJuxZ1xnwSAMA2nWTTAkdAor2yn/2bk1esw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fn6SXIzsZearuhTwENRepj1LjkbrfyAiH9V0OdqhtCc=;
 b=yvDUuStqFS8a9tYItFaXlfagHDsbVENVU/ci4kSPs6xqvQxgKcgdQDhXibfOwLT6tVpYBuNp5gz5GmX22GV1CorXjVfxwCHGhhopNewvmNHqgOfCaubFvQLA0ceaYUv0i3ffT6oZGq7lU6XFktDzgSJAlDhGuQlqPkTSnMPXJdY=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SA2PR10MB4700.namprd10.prod.outlook.com (2603:10b6:806:11c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 20:36:29 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::20c8:7efa:f9a8:7606%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 20:36:29 +0000
Date: Mon, 29 Jan 2024 15:36:26 -0500
From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        selinux@vger.kernel.org, surenb@google.com, kernel-team@android.com,
        aarcange@redhat.com, peterx@redhat.com, david@redhat.com,
        axelrasmussen@google.com, bgeffon@google.com, willy@infradead.org,
        jannh@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        timmurray@google.com, rppt@kernel.org
Subject: Re: [PATCH v2 3/3] userfaultfd: use per-vma locks in userfaultfd
 operations
Message-ID: <20240129203626.uq5tdic4z5qua5qy@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	Lokesh Gidra <lokeshgidra@google.com>, akpm@linux-foundation.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org,
	surenb@google.com, kernel-team@android.com, aarcange@redhat.com,
	peterx@redhat.com, david@redhat.com, axelrasmussen@google.com,
	bgeffon@google.com, willy@infradead.org, jannh@google.com,
	kaleshsingh@google.com, ngeoffray@google.com, timmurray@google.com,
	rppt@kernel.org
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-4-lokeshgidra@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129193512.123145-4-lokeshgidra@google.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SA2PR10MB4700:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a8e1cc5-bede-478f-8e0f-08dc2109f89f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oDv6YsYgRcIYTlHlXwDvlM202gl3Jj1yBkYbMNABY5eoiyammljqgwvVj/fv9FCJXmLVNf/yA+TlxpOOkXdoUhLzWFAx+axUfN1VA7QpCPW0twPZSNUXSwLqFz1ojLWokHaxJeASDX1yQ/mlSiyUNljo4wdGFWAOJTAfY0T+MIc+T1fCWyJuvF2jMFx2R4J9wvJvgpNCRwafnQTICjO+G7lmJ1Dr9Ndv6YBy+/8ktJeb8wghwGKTSWUxXBR9/zDLXoCHOLfZFjPw50YowxmdNz4fKKs16jaVNcFQzYUuo0ad1ub2G+BNvp910rcEBBpiL3Dg3KyW9GeM03qtNKdxMwGsGGa2kYR2ktlfWs4iPZr2eJXb7oBOpt7z0YdZMhG+3iKM8H/SwgABb10gS7LTJ5jrQ4CPxTW8X5Gm4VIyyOuGmqPY3WUvbRuip8iHfUXP0xiuptOBHYny5LNLJYUWRIe4ZgikTLTdHnF62L75ZQRqF0sX0WooJtov7L1MBljdMmYm61uttkQICtocdYzmWsy2tnTt/I/UlUqMm7co3dPkjlqYt5BEqUsEbzWOpol+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(4326008)(6512007)(30864003)(2906002)(6506007)(9686003)(5660300002)(7416002)(6666004)(66946007)(66556008)(316002)(6916009)(26005)(1076003)(66476007)(8676002)(83380400001)(38100700002)(6486002)(8936002)(33716001)(86362001)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cCa8MFM4YUHvOPQSJYl0Pre+eYcMWquSYZ5vrK0vHp0bHhvujXTMjEIYYJia?=
 =?us-ascii?Q?1ifbZR8I+vTySjtcRxbkXG84EeoRi3tlrmYnFrDjcmVu+fF6Ob+aakYX/yw6?=
 =?us-ascii?Q?Y4Xbg4tln//6J33ed/qWQ+W1YZMxoAVBkn1N/UnH7/R2apfGdbLOLzsrx7xv?=
 =?us-ascii?Q?lzCnBeLWIzk2uxmgEX/w7F4CTzAmeUSrQeVSzAcTKqGUXLA8MQoRLoZNuJ2Q?=
 =?us-ascii?Q?2YO7D02uUoY3/d2Wmx2uMnY0c7QSMSE+mDBq2bBmFMvQiZ+AjpUmSAmRgW6n?=
 =?us-ascii?Q?d6wawFmgzk8+Qh6G9Z3HZvgzpbXUXQuxd9a+w4oWj9o4WdXIVsN6RIYq2a8y?=
 =?us-ascii?Q?fHlF3/gnI/OHM7Mp5wbIYEBf1msEfqNed2EpC5k4iw0pSDld4faY/n1D0HJ+?=
 =?us-ascii?Q?GZDqENVwJqDm0l9XSTMCVHzOMEfiLe9sg00CZqNTERx7+3tcPESHSrvqvh5g?=
 =?us-ascii?Q?BLdSpTF+lmDljU0GxovgrnDvySs+/dwUykEy7fl2Xauu1f29Xe8kD4xTMxDu?=
 =?us-ascii?Q?nI0JNVDu+NF9jJi7nYb9sV7H55R2jp4Pnom+OHkHmTVCyrOB+WElS+FPfEhp?=
 =?us-ascii?Q?ajQqSMqBjJGJ+iQ/uO0bx/ptuGIldD8Jz9jPzrjJZQNXLIliZTz4r5Q/eG3W?=
 =?us-ascii?Q?KzIE1Mzzmyshi/7kc7IxRSNlwtU3TGbTQxYV8rHkmZSMO31gQyTwlxDCIi46?=
 =?us-ascii?Q?ABSXnGlaV1zeU4oeIOmq9+Tufm+yfkU4Luk6x3fuEJJl57kad4hS7w6SvF82?=
 =?us-ascii?Q?qsIqcyRuPOw0ZbpVCFcV2FMGBxF23CXMWLL9t0W6Au6TZLhaTpGno2mqqCWB?=
 =?us-ascii?Q?cSxT1b0ZgG0j+IJU5rFhUzdm7tuMe8M4YIzk8nWa2n4G1Hj3guRQQYfq0ww4?=
 =?us-ascii?Q?l5CuglkTc7U+zawKlQH+Eerl7m9vLXlf5wAkUzDr3ZB36pp8+D52yg/8iejV?=
 =?us-ascii?Q?DSRF7AL6Pk28RHTaIlmpwcGVUo9yq+CbcJQiXiHDo1n57yJLXi4fWtBWIxgd?=
 =?us-ascii?Q?xBXyycuu2/VKZR/V3rTKtBL8gf50nOOM2NNutIlHGNYOb3+oGwYvmnHTqaX/?=
 =?us-ascii?Q?gu8G12J5rg/LeYfdwvTwn7pXi+4lv7JYsQm6DEBdkHQepe7LcFzt7gH6jaVj?=
 =?us-ascii?Q?cESw8jDwsdcOvLbZcj0J7eyxi7L3OGIohX+mPVOaDYX64O/2CoGsWd6l1x5t?=
 =?us-ascii?Q?ADZrO3IwNapJN17qYgOpGWNDlzactKOcYIpCskTV2zlDYWngIK5QmGz/FaZz?=
 =?us-ascii?Q?4tPCuF7QN10yNMModGEKxOlxrl6BjwwmF5USuwO9MlskUbd9KBz7sW1Uo26+?=
 =?us-ascii?Q?ZxbccJJl5czZWo5EMwwWL6V70MRyn15sJktiDjbxkQmyLo5IvvSsj9K9TS1M?=
 =?us-ascii?Q?sgxD7jQo3PIT5cZeO/bu5TDUKzFHZ6O7nv7B66MBy9XlYDtClKWr8lSmdTEH?=
 =?us-ascii?Q?QK2BK1m1FU3UvBXTU1AE37YOlsLXt0sYIOMK2shOFp6oBKkv3URP5qYB88wq?=
 =?us-ascii?Q?3SYFoaqcvx1QZRm85X5a+oqmpRYwp1ZInnc9GV2j3NWaPN1Mu0RDoxfWYFks?=
 =?us-ascii?Q?SO7G8xmYYn9nu7yditATTQsogDLbO4ijWjK6T3YI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	0fjxozsJFwmlUNJxCKA2sdMHudT5WQA/+J7bTRvPNSuWEwFApIprM4tsQJAw7iMXNixXd3wX/BC2Q8+sA+S7t/kOLOaV/1Pxv1Hk8r+3oQopShWSIgPG783C/8jEkCH5Oi0Xd0Zmiso2RF+VZHxHmaeBNVnP4u4iKYrO4kq846yhm353ShzEp8PiPv2Ia59FWX9iobc8bdnAjJM3S5V3sKpx0Q8LjKi+hISWvIrAc5H9jFG5sEdpqjOX7nmlRTLdDxHtuTKDADiB0s9oEPky0X6ERfw0M8XocShbJXjjcbAopOvRifUvhfJi04EmTeG76x63T3NB2A0KQYnE2AOYDWrUJ8NQ+6HBGej00iagIJZYnC0u6Es/eoGflsT4ztM2sBF0i3YArITMUEkbl+p1JNaFyzCrp3AJddy2jVg4AFphqqwmIqjGVeItClbwZwBhz7fFKOyRlSPbIOWWW2Je2JvNGmApFBXhUh1UzawMjUeonFWn2B8BIHDKSJNH9lGmWG8M//IiGcYB+OCktv/ngKU6qg8Cid0X3O80BRFn39Ww5y+UbV22wGNJFvGr6nKOghZZpRd//3mVUy2n8YnbsXXTZ6PJ9uNKtlcsYiSS7Xc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a8e1cc5-bede-478f-8e0f-08dc2109f89f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 20:36:29.1199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3YLb8Tc8ARYdKSC0uhtFt64c6b8GK+3mnUkA5WQ2tDCECDRDb0/ylNGvJkzxghMZo+lCIYaBujbfDwKQXZdkLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_13,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401290151
X-Proofpoint-GUID: JvEfJT2WCp03RL5ogfCmbw-3ajR3NP-0
X-Proofpoint-ORIG-GUID: JvEfJT2WCp03RL5ogfCmbw-3ajR3NP-0

* Lokesh Gidra <lokeshgidra@google.com> [240129 14:35]:
> All userfaultfd operations, except write-protect, opportunistically use
> per-vma locks to lock vmas. If we fail then fall back to locking
> mmap-lock in read-mode.
> 
> Write-protect operation requires mmap_lock as it iterates over multiple vmas.
> 
> Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
> ---
>  fs/userfaultfd.c              |  13 +--
>  include/linux/userfaultfd_k.h |   5 +-
>  mm/userfaultfd.c              | 175 +++++++++++++++++++++++-----------
>  3 files changed, 122 insertions(+), 71 deletions(-)
> 
> diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> index c00a021bcce4..60dcfafdc11a 100644
> --- a/fs/userfaultfd.c
> +++ b/fs/userfaultfd.c
> @@ -2005,17 +2005,8 @@ static int userfaultfd_move(struct userfaultfd_ctx *ctx,
>  		return -EINVAL;
>  
>  	if (mmget_not_zero(mm)) {
> -		mmap_read_lock(mm);
> -
> -		/* Re-check after taking map_changing_lock */
> -		down_read(&ctx->map_changing_lock);
> -		if (likely(!atomic_read(&ctx->mmap_changing)))
> -			ret = move_pages(ctx, mm, uffdio_move.dst, uffdio_move.src,
> -					 uffdio_move.len, uffdio_move.mode);
> -		else
> -			ret = -EAGAIN;
> -		up_read(&ctx->map_changing_lock);
> -		mmap_read_unlock(mm);
> +		ret = move_pages(ctx, uffdio_move.dst, uffdio_move.src,
> +				 uffdio_move.len, uffdio_move.mode);
>  		mmput(mm);
>  	} else {
>  		return -ESRCH;
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index 3210c3552976..05d59f74fc88 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -138,9 +138,8 @@ extern long uffd_wp_range(struct vm_area_struct *vma,
>  /* move_pages */
>  void double_pt_lock(spinlock_t *ptl1, spinlock_t *ptl2);
>  void double_pt_unlock(spinlock_t *ptl1, spinlock_t *ptl2);
> -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> -		   unsigned long dst_start, unsigned long src_start,
> -		   unsigned long len, __u64 flags);
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +		   unsigned long src_start, unsigned long len, __u64 flags);
>  int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pmd_t dst_pmdval,
>  			struct vm_area_struct *dst_vma,
>  			struct vm_area_struct *src_vma,
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 6e2ca04ab04d..d55bf18b80db 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -19,20 +19,39 @@
>  #include <asm/tlb.h>
>  #include "internal.h"
>  
> -static __always_inline
> -struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
> -				    unsigned long dst_start,
> -				    unsigned long len)
> +void unpin_vma(struct mm_struct *mm, struct vm_area_struct *vma, bool *mmap_locked)
> +{
> +	BUG_ON(!vma && !*mmap_locked);
> +
> +	if (*mmap_locked) {
> +		mmap_read_unlock(mm);
> +		*mmap_locked = false;
> +	} else
> +		vma_end_read(vma);

You are missing braces here.

This function is small so it could be inline, although I hope the
compiler would get that right for us.

I don't think this small helper is worth it, considering you are
altering a pointer in here, which makes things harder to follow (not to
mention the locking).  The only code that depends on this update is a
single place, which already assigns a custom variable after the function
return.

> +}
> +
> +/*
> + * Search for VMA and make sure it is stable either by locking it or taking
> + * mmap_lock.

This function returns something that isn't documented and also sets a
boolean which is passed in as a pointer which also is lacking from the
documentation.

> + */
> +struct vm_area_struct *find_and_pin_dst_vma(struct mm_struct *dst_mm,
> +					    unsigned long dst_start,
> +					    unsigned long len,
> +					    bool *mmap_locked)
>  {
> +	struct vm_area_struct *dst_vma = lock_vma_under_rcu(dst_mm, dst_start);

lock_vma_under_rcu() calls mas_walk(), which goes to dst_start for the
VMA.  It is not possible for dst_start to be outside the range.

> +	if (!dst_vma) {

BUG_ON(mmap_locked) ?

> +		mmap_read_lock(dst_mm);
> +		*mmap_locked = true;
> +		dst_vma = find_vma(dst_mm, dst_start);

find_vma() walks to dst_start and searches upwards from that address.
This is functionally different than what you have asked for above.  You
will not see an issue as you have coded it - but it may be suboptimal
since a start address lower than the VMA you are looking for can be
found... however, later you check the range falls between the dst_start
and dst_start + len.

If you expect the dst_start to always be within the VMA range and not
lower, then you should use vma_lookup().

If you want to search upwards from dst_start for a VMA then you should
move the range check below into this brace.

> +	}
> +
>  	/*
>  	 * Make sure that the dst range is both valid and fully within a
>  	 * single existing vma.
>  	 */
> -	struct vm_area_struct *dst_vma;
> -
> -	dst_vma = find_vma(dst_mm, dst_start);
>  	if (!range_in_vma(dst_vma, dst_start, dst_start + len))
> -		return NULL;
> +		goto unpin;
>  
>  	/*
>  	 * Check the vma is registered in uffd, this is required to
> @@ -40,9 +59,13 @@ struct vm_area_struct *find_dst_vma(struct mm_struct *dst_mm,
>  	 * time.
>  	 */
>  	if (!dst_vma->vm_userfaultfd_ctx.ctx)
> -		return NULL;
> +		goto unpin;
>  
>  	return dst_vma;
> +
> +unpin:
> +	unpin_vma(dst_mm, dst_vma, mmap_locked);
> +	return NULL;
>  }
>  
>  /* Check if dst_addr is outside of file's size. Must be called with ptl held. */
> @@ -350,7 +373,8 @@ static pmd_t *mm_alloc_pmd(struct mm_struct *mm, unsigned long address)
>  #ifdef CONFIG_HUGETLB_PAGE
>  /*
>   * mfill_atomic processing for HUGETLB vmas.  Note that this routine is
> - * called with mmap_lock held, it will release mmap_lock before returning.
> + * called with either vma-lock or mmap_lock held, it will release the lock
> + * before returning.
>   */
>  static __always_inline ssize_t mfill_atomic_hugetlb(
>  					      struct userfaultfd_ctx *ctx,
> @@ -358,7 +382,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  					      unsigned long dst_start,
>  					      unsigned long src_start,
>  					      unsigned long len,
> -					      uffd_flags_t flags)
> +					      uffd_flags_t flags,
> +					      bool *mmap_locked)
>  {
>  	struct mm_struct *dst_mm = dst_vma->vm_mm;
>  	int vm_shared = dst_vma->vm_flags & VM_SHARED;
> @@ -380,7 +405,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 */
>  	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
>  		up_read(&ctx->map_changing_lock);
> -		mmap_read_unlock(dst_mm);
> +		unpin_vma(dst_mm, dst_vma, mmap_locked);
>  		return -EINVAL;
>  	}
>  
> @@ -404,12 +429,25 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  	 */
>  	if (!dst_vma) {
>  		err = -ENOENT;
> -		dst_vma = find_dst_vma(dst_mm, dst_start, len);
> -		if (!dst_vma || !is_vm_hugetlb_page(dst_vma))
> -			goto out_unlock;
> +		dst_vma = find_and_pin_dst_vma(dst_mm, dst_start,
> +					       len, mmap_locked);
> +		if (!dst_vma)
> +			goto out;
> +		if (!is_vm_hugetlb_page(dst_vma))
> +			goto out_unlock_vma;
>  
>  		err = -EINVAL;
>  		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
> +			goto out_unlock_vma;
> +
> +		/*
> +		 * If memory mappings are changing because of non-cooperative
> +		 * operation (e.g. mremap) running in parallel, bail out and
> +		 * request the user to retry later
> +		 */
> +		down_read(&ctx->map_changing_lock);
> +		err = -EAGAIN;
> +		if (atomic_read(&ctx->mmap_changing))
>  			goto out_unlock;
>  
>  		vm_shared = dst_vma->vm_flags & VM_SHARED;
> @@ -465,7 +503,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  
>  		if (unlikely(err == -ENOENT)) {
>  			up_read(&ctx->map_changing_lock);
> -			mmap_read_unlock(dst_mm);
> +			unpin_vma(dst_mm, dst_vma, mmap_locked);
>  			BUG_ON(!folio);
>  
>  			err = copy_folio_from_user(folio,
> @@ -474,17 +512,6 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  				err = -EFAULT;
>  				goto out;
>  			}
> -			mmap_read_lock(dst_mm);
> -			down_read(&ctx->map_changing_lock);
> -			/*
> -			 * If memory mappings are changing because of non-cooperative
> -			 * operation (e.g. mremap) running in parallel, bail out and
> -			 * request the user to retry later
> -			 */
> -			if (atomic_read(ctx->mmap_changing)) {
> -				err = -EAGAIN;
> -				break;
> -			}

... Okay, this is where things get confusing.

How about this: Don't do this locking/boolean dance.

Instead, do something like this:
In mm/memory.c, below lock_vma_under_rcu(), but something like this

struct vm_area_struct *lock_vma(struct mm_struct *mm,
	unsigned long addr))	/* or some better name.. */
{
	struct vm_area_struct *vma;

	vma = lock_vma_under_rcu(mm, addr);

	if (vma)
		return vma;

	mmap_read_lock(mm);
	vma = lookup_vma(mm, addr);
	if (vma)
		vma_start_read(vma); /* Won't fail */

	mmap_read_unlock(mm);
	return vma;
}

Now, we know we have a vma that's vma locked if there is a vma.  The vma
won't go away - you have it locked.  The mmap lock is held for even
less time for your worse case, and the code gets easier to follow.

Once you are done with the vma do a vma_end_read(vma).  Don't forget to
do this!

Now the comment above such a function should state that the vma needs to
be vma_end_read(vma), or that could go undetected..  It might be worth
adding a unlock_vma() counterpart to vma_end_read(vma) even.


>  
>  			dst_vma = NULL;
>  			goto retry;
> @@ -505,7 +532,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
>  
>  out_unlock:
>  	up_read(&ctx->map_changing_lock);
> -	mmap_read_unlock(dst_mm);
> +out_unlock_vma:
> +	unpin_vma(dst_mm, dst_vma, mmap_locked);
>  out:
>  	if (folio)
>  		folio_put(folio);
> @@ -521,7 +549,8 @@ extern ssize_t mfill_atomic_hugetlb(struct userfaultfd_ctx *ctx,
>  				    unsigned long dst_start,
>  				    unsigned long src_start,
>  				    unsigned long len,
> -				    uffd_flags_t flags);
> +				    uffd_flags_t flags,
> +				    bool *mmap_locked);

Just a thought, tabbing in twice for each argument would make this more
compact.


>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  static __always_inline ssize_t mfill_atomic_pte(pmd_t *dst_pmd,
> @@ -581,6 +610,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	unsigned long src_addr, dst_addr;
>  	long copied;
>  	struct folio *folio;
> +	bool mmap_locked = false;
>  
>  	/*
>  	 * Sanitize the command parameters:
> @@ -597,7 +627,14 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	copied = 0;
>  	folio = NULL;
>  retry:
> -	mmap_read_lock(dst_mm);
> +	/*
> +	 * Make sure the vma is not shared, that the dst range is
> +	 * both valid and fully within a single existing vma.
> +	 */
> +	err = -ENOENT;
> +	dst_vma = find_and_pin_dst_vma(dst_mm, dst_start, len, &mmap_locked);
> +	if (!dst_vma)
> +		goto out;
>  
>  	/*
>  	 * If memory mappings are changing because of non-cooperative
> @@ -609,15 +646,6 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	if (atomic_read(&ctx->mmap_changing))
>  		goto out_unlock;
>  
> -	/*
> -	 * Make sure the vma is not shared, that the dst range is
> -	 * both valid and fully within a single existing vma.
> -	 */
> -	err = -ENOENT;
> -	dst_vma = find_dst_vma(dst_mm, dst_start, len);
> -	if (!dst_vma)
> -		goto out_unlock;
> -
>  	err = -EINVAL;
>  	/*
>  	 * shmem_zero_setup is invoked in mmap for MAP_ANONYMOUS|MAP_SHARED but
> @@ -638,8 +666,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  	 * If this is a HUGETLB vma, pass off to appropriate routine
>  	 */
>  	if (is_vm_hugetlb_page(dst_vma))
> -		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start,
> -					     src_start, len, flags);
> +		return  mfill_atomic_hugetlb(ctx, dst_vma, dst_start, src_start
> +					     len, flags, &mmap_locked);
>  
>  	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
>  		goto out_unlock;
> @@ -699,7 +727,8 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  			void *kaddr;
>  
>  			up_read(&ctx->map_changing_lock);
> -			mmap_read_unlock(dst_mm);
> +			unpin_vma(dst_mm, dst_vma, &mmap_locked);
> +
>  			BUG_ON(!folio);
>  
>  			kaddr = kmap_local_folio(folio, 0);
> @@ -730,7 +759,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
>  
>  out_unlock:
>  	up_read(&ctx->map_changing_lock);
> -	mmap_read_unlock(dst_mm);
> +	unpin_vma(dst_mm, dst_vma, &mmap_locked);
>  out:
>  	if (folio)
>  		folio_put(folio);
> @@ -1285,8 +1314,6 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
>   * @len: length of the virtual memory range
>   * @mode: flags from uffdio_move.mode
>   *
> - * Must be called with mmap_lock held for read.
> - *
>   * move_pages() remaps arbitrary anonymous pages atomically in zero
>   * copy. It only works on non shared anonymous pages because those can
>   * be relocated without generating non linear anon_vmas in the rmap
> @@ -1353,15 +1380,16 @@ static int validate_move_areas(struct userfaultfd_ctx *ctx,
>   * could be obtained. This is the only additional complexity added to
>   * the rmap code to provide this anonymous page remapping functionality.
>   */
> -ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
> -		   unsigned long dst_start, unsigned long src_start,
> -		   unsigned long len, __u64 mode)
> +ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
> +		   unsigned long src_start, unsigned long len, __u64 mode)
>  {
> +	struct mm_struct *mm = ctx->mm;
>  	struct vm_area_struct *src_vma, *dst_vma;
>  	unsigned long src_addr, dst_addr;
>  	pmd_t *src_pmd, *dst_pmd;
>  	long err = -EINVAL;
>  	ssize_t moved = 0;
> +	bool mmap_locked = false;
>  
>  	/* Sanitize the command parameters. */
>  	if (WARN_ON_ONCE(src_start & ~PAGE_MASK) ||
> @@ -1374,28 +1402,52 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
>  	    WARN_ON_ONCE(dst_start + len <= dst_start))
>  		goto out;

Ah, is this safe for rmap?  I think you need to leave this read lock.

>  
> +	dst_vma = NULL;
> +	src_vma = lock_vma_under_rcu(mm, src_start);
> +	if (src_vma) {
> +		dst_vma = lock_vma_under_rcu(mm, dst_start);
> +		if (!dst_vma)
> +			vma_end_read(src_vma);
> +	}
> +
> +	/* If we failed to lock both VMAs, fall back to mmap_lock */
> +	if (!dst_vma) {
> +		mmap_read_lock(mm);
> +		mmap_locked = true;
> +		src_vma = find_vma(mm, src_start);
> +		if (!src_vma)
> +			goto out_unlock_mmap;
> +		dst_vma = find_vma(mm, dst_start);

Again, there is a difference in how find_vma and lock_vam_under_rcu
works.

> +		if (!dst_vma)
> +			goto out_unlock_mmap;
> +	}
> +
> +	/* Re-check after taking map_changing_lock */
> +	down_read(&ctx->map_changing_lock);
> +	if (likely(atomic_read(&ctx->mmap_changing))) {
> +		err = -EAGAIN;
> +		goto out_unlock;
> +	}
>  	/*
>  	 * Make sure the vma is not shared, that the src and dst remap
>  	 * ranges are both valid and fully within a single existing
>  	 * vma.
>  	 */
> -	src_vma = find_vma(mm, src_start);
> -	if (!src_vma || (src_vma->vm_flags & VM_SHARED))
> -		goto out;
> +	if (src_vma->vm_flags & VM_SHARED)
> +		goto out_unlock;
>  	if (src_start < src_vma->vm_start ||
>  	    src_start + len > src_vma->vm_end)
> -		goto out;
> +		goto out_unlock;
>  
> -	dst_vma = find_vma(mm, dst_start);
> -	if (!dst_vma || (dst_vma->vm_flags & VM_SHARED))
> -		goto out;
> +	if (dst_vma->vm_flags & VM_SHARED)
> +		goto out_unlock;
>  	if (dst_start < dst_vma->vm_start ||
>  	    dst_start + len > dst_vma->vm_end)
> -		goto out;
> +		goto out_unlock;
>  
>  	err = validate_move_areas(ctx, src_vma, dst_vma);
>  	if (err)
> -		goto out;
> +		goto out_unlock;
>  
>  	for (src_addr = src_start, dst_addr = dst_start;
>  	     src_addr < src_start + len;) {
> @@ -1512,6 +1564,15 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, struct mm_struct *mm,
>  		moved += step_size;
>  	}
>  
> +out_unlock:
> +	up_read(&ctx->map_changing_lock);
> +out_unlock_mmap:
> +	if (mmap_locked)
> +		mmap_read_unlock(mm);
> +	else {
> +		vma_end_read(dst_vma);
> +		vma_end_read(src_vma);
> +	}
>  out:
>  	VM_WARN_ON(moved < 0);
>  	VM_WARN_ON(err > 0);
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 
> 

