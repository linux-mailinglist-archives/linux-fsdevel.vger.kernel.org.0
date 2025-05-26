Return-Path: <linux-fsdevel+bounces-49851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFFDAC417B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 16:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9FE16227C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 May 2025 14:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6E620F089;
	Mon, 26 May 2025 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r6ry1iWo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="j0a6p63D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485D728373;
	Mon, 26 May 2025 14:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748269994; cv=fail; b=SyuCx8Mn5iMorXe01JyGAxkkVkGsFQKzlqqc1btup+Kv7Try1ZFIoWqSPDOIqmeL+BoZ/M4TPqG/MVumQPOMnK+5kGnX2KGJNBdljLHTpOIgegmDOInS9v9Oco1zOB/OtSiiL2+6PVeYEWfvJFLF/KJxpIuoLM+iXis7vAYJrj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748269994; c=relaxed/simple;
	bh=KkID7ovv2oBfUYouhV8MqO8+l3MmKYocE08AmXD2TAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=r0s5ag3rEF+Fl+8E6XYyAdPQDCD1TciW0lg7MW1Ti3n464og+taFdyIkk3O1hq9fLs3TtsAkQPVcPRHPTm1CfrTyM12i6QuJNyDpBD7xx1b/hS66RQvZKBz0fcGFCX2yS6nBHMloltOxqPtZjJuwei052Kfk8yjixKVwPkUWZ9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r6ry1iWo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=j0a6p63D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q8uUa0001090;
	Mon, 26 May 2025 14:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PeAjaeKTRkECO0pTdh
	xpvroy45cvX9n4cT+CEAtOQSw=; b=r6ry1iWoXSCnhmq4VMs3gP0Cjo6IEG1wpc
	IAGGUj4iMWzwSMWrdHsYNtlfPHNLkpbgmpiBZHYt/+ProKP1X/J3fSXiBZzEyTOm
	pikuQjp0z2FwCGmrVl8oviGLuxxU3XkYow/AKejB6npcnNNCxyWoogPYTKwJ7XE1
	Y1R4fXSZmKY9BdIPNXzlrQtG0onD999XhHfpYvfMcDyFVJuGU+dO3NlH/dmSJe38
	FIUfyU8FN8UERBNvMpk/c4KCL2bM6Q0D0rXuhSEb41d+QibeLUyfZZPIE5+tHqfY
	BWcose9nSr1rXWEIrqGGxymJPM3UiR5B0KyusDciqqvrEd4yjr2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0g29ka1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:32:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54QDSv1R023126;
	Mon, 26 May 2025 14:32:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4j7uunq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 14:32:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJCuINrqRvAboyHYrAHfHD8plFLhGwn3CAuysoj0LILksF2CHk38n2EFybo+Etba9XoRvvSUMjNYxXydzxW8wKMxX+DV5G1bD5iRgfl2Q0NRg6VU3oUvV+K5SbMDo0Bp1ce07d0tNa9PIRE5Q1jjs67f72PNdHYJu/ytQcJBqHKrt2LQCn69xBWlG8UfmOwnrUb/rIAU37yFdcB3A028BXKiP956SNP6Gen5Ny9H0lt8VpG5zvd6r3ytNOT4NtGOk331ohmViBTle8dZTIib2AhmzdBWMtzQ8W5YuYHqdoriVEQ/f6YmIVDRpXRnw/K12lbdew7ovHAonpyBsoH5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PeAjaeKTRkECO0pTdhxpvroy45cvX9n4cT+CEAtOQSw=;
 b=CYUIWsWk1X0F6Mxj18TNCvOxxlQSb6cqKLN0pwPUko6lQLdgtsjrljDALUKtfgj+IF8X3CLjB8T6DrZOUNiKmZw+IBhDflTOkyiG4RDV5CLrgRkJzUlGQmcLB8WzT9nByDgFKlbEpZG0vwzJF2nHXan43WEizIu6yOP9cuekRDs5FEbJjfQaEM0QtobJAP6CrsLHf8B2e58ZaQUr+4ItcSYRltj0Ve1yhyVg4Fi3mGDJcsr8LRYzTYuvNLIOjyYAv+Q7Icw9KB7n0uGXo6KAVfquTjBH1RgBGXkgiYwBnFweuQhav6JESXaEcNm+3gMMNeihScHpIZZTqnoUz0EpdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeAjaeKTRkECO0pTdhxpvroy45cvX9n4cT+CEAtOQSw=;
 b=j0a6p63DVrcp1zHSU+h3a9OydML/G3SqGwFwPqJVgU/iVAPDFWdlCuTXz7X2JtTAkdE4fjcpT4jqEM6FXl9VCpjdcNhx+LVFhcrmf7my92AQ+mwb3vhf2/5iO3rX+amqmf07R8uj6pnLFbPZ3I/qE/CN1vJjbgZOQSfUc+h8Yoo=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by CH0PR10MB4985.namprd10.prod.outlook.com (2603:10b6:610:de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Mon, 26 May
 2025 14:32:39 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8746.030; Mon, 26 May 2025
 14:32:39 +0000
Date: Mon, 26 May 2025 10:32:35 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v2 3/4] mm: prevent KSM from completely breaking VMA
 merging
Message-ID: <eobqsr6hzy33r2w5qouc3qapbkidzbz45lsfa4vx5urjkgw5au@bnkiscpxgxsz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
	Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Stefan Roesch <shr@devkernel.io>
References: <cover.1747844463.git.lorenzo.stoakes@oracle.com>
 <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6057647abfceb672fa932ad7fb1b5b69bdab0fc7.1747844463.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YQBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01::13)
 To PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|CH0PR10MB4985:EE_
X-MS-Office365-Filtering-Correlation-Id: e3bee0c9-3b49-410f-4ab4-08dd9c622ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XRREWf8AIhCoeU7TufdRWa+RDUO/NPuDoA7JZUXJ6ITTONySgXDPzsNBzmMh?=
 =?us-ascii?Q?QdCkZoABU4DMsMjyjBuMvWIyv3sU7+abmhFLP0lIliEXUZUA6K6C5k3gdyQC?=
 =?us-ascii?Q?OxZi1Ln/+TXSmDf4WGvPYaoFHjrgt7SIY9esAQydBblDaBYM2dSNZWnOg/BN?=
 =?us-ascii?Q?gHuPU+f8hiMhi2Xx1Nt8y6wU29INiR5D/hY0ChwYxkN70+J5R6aKqHm28czn?=
 =?us-ascii?Q?wjO8Q5M+wwLxNvdm2Mq8520AGcZGlwvag6bRXyxN9arkZX/uhOEihC393k5d?=
 =?us-ascii?Q?u8SWzYpzpt6bYFr9HwuHfcFvSlDD/aooDfFSknOqac/2C+mgXkZac6N8Xyu2?=
 =?us-ascii?Q?phJcHNtdJJCIVvRTPb20NSN0f7MgoADqkbYUB4ls1WG59WV3/euwF0COgmTB?=
 =?us-ascii?Q?JLCBb62OiVSwE2uyo5duwZfGqIGSfEF8ztS11E9ixhn37nHDiWlAC35I76HG?=
 =?us-ascii?Q?BpiHOP6SvAIrbDdPOz3JzFfa+zbKhQvd6Ab6vuQ//n8huSFZ0JgTO9uFlpN7?=
 =?us-ascii?Q?RVK0zoKdLVdAad2zMTk2Ad7XCiQ3TOCQh4mHSiJUK2RcVlcmxUyiOZN+uFwz?=
 =?us-ascii?Q?CzW+3V+J4xzdamRvwgGOlphfSvYVWAnyfHBLKDSmwKmI6RRYYEumz3kvR5uM?=
 =?us-ascii?Q?axCB+DnzUPm81UNSwIs6fwTf4YYAyM4M8HOr1vZd7/eCPUB2A/BHOvE2jZhq?=
 =?us-ascii?Q?wb2T7xy6BfVa2zk5HMLECh1VZXrocOg142PITd1f/iYzksiWkkYeVAxEYkWN?=
 =?us-ascii?Q?ZbxhmfDJRooGRgZuheTpftrrkTmWAX0vCjw4lxtNsPbtfEsdmoNMVuQR6jqB?=
 =?us-ascii?Q?IqrXkBWnGd1T2D5D7nm0EEwSOzgYfvqwgBIvoFFARcdVhZsKQhFkJv2uGTod?=
 =?us-ascii?Q?D2JF106yJyL7p4D25u38NsfblkJ3e6DgTfvBdXOsh1cBxOiMhvXVWX08F6JM?=
 =?us-ascii?Q?fV1A7n4ZRhyQxRJbDQ/SvYrOHi3ii8j+3aYJ3v6m1wPgF3ekZWnM6edno2Zl?=
 =?us-ascii?Q?SdOC+qM4/L2hfsDy55PQG1vyZAyJJr76pNFr/uHHuZbHZUQ9L0st71cthCcd?=
 =?us-ascii?Q?CblPrCD4myMFY+xTFg1G9xrVYVDUt3Dr/NGayNYibz3N/hiT/tXozSAzhupx?=
 =?us-ascii?Q?1Nj1uTnckbcStQAqNvlXuD32+Mzyi059aViq6kkgaItKzVDf5cCPCEuU9Mb+?=
 =?us-ascii?Q?EUiX3IJD3L7dtAEgubASWrWWG77djUk2KpfyJVMYejPR8ebOUig1gJrlf3eE?=
 =?us-ascii?Q?m6ZyZ8fqPCPHtrpg+PNwFUR8rLqkEg4tpX9q2kJeyPkDIQEVww7RIuxWHWBe?=
 =?us-ascii?Q?9ZAD4QcqYhiIdtqPV6UKO9Anxt0URrt9PCN/DD2Zcu8f2R7QPkMrhTwBM2R5?=
 =?us-ascii?Q?G4aE2TBrFkXoBN8+E1xDABJEUuDffA6cCtEjPPlPMuoDfSloyXkKIdspXkzL?=
 =?us-ascii?Q?hQJMFsj1uAI1FUTZg6wk+bVpmuSZyEY2hfDLo0LN26oOd9a3aU23gQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yv5Gef5xEliF4XG0rZJbso+Su1jVKnvP4Ohcc08/loVJ7gwJCcSU7FNhcL2G?=
 =?us-ascii?Q?2CTA7E2LHGbrGle0g9Vy1rjRBIU3YItwyAtoMYBHH0Bxh4+6yhKHc1Tz4CfV?=
 =?us-ascii?Q?pIt8CC7iIj14WLpMAIdpN5FMZ8CLyzy2v6O/vhzkGdsTzOvN21yILJdphJ/o?=
 =?us-ascii?Q?lGgejtaC7N4yikMTCR5DlF0jGMaWnPB/qYHAAa7go5UEKZXGY+hDfGBflcQy?=
 =?us-ascii?Q?goeoECnWO8LjPgxK4Se/Y6MDxlc8tOFJLL4gvCBKbbxd4kDJ49qk5bD1lQeh?=
 =?us-ascii?Q?q8KyIBM0STGlJprdzzm5PFga3JY6Vb9fevI+v6lMVlNGWuuQJqJmDHLOdpGK?=
 =?us-ascii?Q?48pz2cgYm3xJp4C8kCueNRBetfGcT4ATlaXc3Y54hUJoSPv0D4Uok3IRXaqv?=
 =?us-ascii?Q?p9/q3mAkSAFPyv9rYM2fjmTBE0jzoEmQ6vc2NdJOgZVyTOr3mmj3z6RB6mmt?=
 =?us-ascii?Q?Hrb7A9ynbjqdeLJtNlEW9Lzc2hIT9XeVE3Ny5lZoXjh8YSik5DBWDT5tpW/c?=
 =?us-ascii?Q?4W/Kn+gxucb4+jfWpcM35UO5z89jXLKTsnZKE4uRHyyTjRQqs9ALQ1XP3hEJ?=
 =?us-ascii?Q?7/+JgAKQDkSWDJnfbOz0Y49woH6KXUOhPB87oSR67LXNe9+VRQhXXdAFxmCS?=
 =?us-ascii?Q?wUeq1B+F2sSKFW487E9Bq+3aUuM5HgyaBBsy8Ny7VRVF8vj3n1rX2KftxTYZ?=
 =?us-ascii?Q?QIk9qHwkSkt+HWUuKMRpXESGBTTB+4mVBACvxH1pqQ1uZIEnMdvcJdA60jjw?=
 =?us-ascii?Q?v5FHvFPD6Zm1pFrJE72OIhXnhOcaAeB6UB+hx5leOrDLp+UwrD91nYJEJT9d?=
 =?us-ascii?Q?Eed6EWx/MTcXjR3+W6A+l4Xrvtcv3+EPYHz4uciBin3k1unMG6nxEVmkc5Mi?=
 =?us-ascii?Q?/7sWlPn4HVyLxFVjhHkEsNKtwKakIXAVNxP1ebR/pBbJbECx12aco95g2y0Q?=
 =?us-ascii?Q?dqCr7U+spK9uBmcEhiB5guxwLjglkTeC5LeaWX963Tch2GhB/SNaUrG4lwin?=
 =?us-ascii?Q?GuparAv+lHcNMi8CfnfDNMLc1e/SYZoxts9COVWIJWbbmMQBHH1Kzb4Nc5BS?=
 =?us-ascii?Q?BGlOS09+c9MeEKQWlTdSy1JatG6n1a/YMqS7iyVvY6voCEZ/j20wDJ7fYVke?=
 =?us-ascii?Q?f2bqYpcl2t+ij6kbXxS5631asWhIvoGNqdgx7ZgO6LV828JwIS4fF1VTRlvl?=
 =?us-ascii?Q?yChqjrNPNri33q4ul64X2Y3qnQftgY88LQ2GWVNzdjIEOMvYD0tz7t5HE3i/?=
 =?us-ascii?Q?qJUvX5HVn6zOxh41SbIDdmIQVmZmXjEEr+gNIEbHnIf9FCaep0+ZIndhg80v?=
 =?us-ascii?Q?1GJ4kOcOi+npDagyCj5iCdmQWMpZyeIvrzYg8QVKJNVLNPpMq+GWQat7P+km?=
 =?us-ascii?Q?9LuyE7iGnXei0xEGPuMghKbukZxM0zIfEMKDXQ8JCOvWk9+jfoqPEFgPEqJe?=
 =?us-ascii?Q?uBSUG/zFqZebiJA4+7X6ryvc4Z5AFKhEsoDeP2CYfSRUzhjmvIKGXReIhJoA?=
 =?us-ascii?Q?w8MF7L84n+O/OWeiQnAI09qVOM8hV6Tu3koPtviEZdbxs3OxunOKyxcUVAWX?=
 =?us-ascii?Q?UbpUxxl5gcFk6qdrSaCu69O29sxgYehmjJBFLMYl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rPQeAVpffqLRgrAvm/QVS12q+mimYgg5fgLGRIsHkkVFcRxqbQGD4JOgllKr2Yxs8cg4xCN3QIGlYWL0B3iY5Y5mOM1qbc+Q/Zh6CZDfcVE47SVJgPmUbmdaeHoydSKOzF7px7uFzQtg5GDPggULiFQb8ZFrSklZJ8FabU8WtYJIMaJtSuzkD1dmHrqlZzIJHRM953JN4T1aU3G2OVw2bh/gKFBTPQUSu85k6JgBs+JVOXTddJWZVxNMGUkgnAvXmxePM+RCVynwnZPHRe29J+qMlYwKDug0CAF6mBj4zyi4gjbsHn9przjqU342T1nZ3vAzp5IOtN5lwecHflyo5hUntaE3RQ29pbE2REn4tKkkSVmT+8cO/wXc6l9RaeLv8rgV08SFl48tUQJURDyZIr0Qy0g4p2ZSyh6o1gqYIQFrbRg5PrJMNlx2QJwwY5IO7gKssdVIitPLaOg6Jh4QV3vrizUOiO7bNWLfH/C3AYE2aJHEqbm3d58QN4HF0O3t7OmaQzoAArG6/wdoeT1pOXX5OwkrAhWHjJZBhp4gh7I8ii68Ll8qohizFCOfWhfAA9UJ++FnnZRaR/UqRsKmE55g/sfUiJ7xLDRG/COnRu8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3bee0c9-3b49-410f-4ab4-08dd9c622ac7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2025 14:32:39.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vIzOqSojHbfpgFx6Xi+W/CjYaqXa+w+sEWN6H3r37aftuo5vBqvK6h28/jfh7bRnmuahyb/UKjCp+UlITV3FXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_07,2025-05-26_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505260123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDEyNCBTYWx0ZWRfX0CW04C38uErL VJlqUmX1wJPuGBUX+eE2FIPh5SElbRBokmVkuOLCF1LI94BT3AfPnCBjzBqpP88rTyFBfIkbYvr RzYFg0hzSBfs4+Dz7zNf2lQOedprTE7WrU+3mgtpEx5ZjlyGnMBzFwQ8j1Aw82kNTfhYzTEsbw7
 kcgnd5q+Ysjl+hw6oZPUkX0LKUGySOASKo5HIixBHuY+gWMGABMB3VSER6N9FlnfZSvrsDgmq4C ybaS+i/kpmq1Iw84wRaM2zUvVTNODOClrPnNLstC59K4myBA6IDOflAIHcNp4aAS6PjMJ8iq10C +TQBAvn5FPEbdS6f6xzkgMi9kfzaHS4H3mqBVudJVlLWWOrI9m1QCZAJhlru92lZERl7h7nn+JF
 2PJ7/14d9pLkxI6fDAofGDj1G0zGHExh8d8p48uTREBB4TW2J5C7cfgSjGQ8/AHYLyLRWW0w
X-Authority-Analysis: v=2.4 cv=NJLV+16g c=1 sm=1 tr=0 ts=68347b97 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=wBejt1P6u6kvEc33VUkA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: EN9p0P99e1olHAJ1msvNrwycj0EknxrZ
X-Proofpoint-GUID: EN9p0P99e1olHAJ1msvNrwycj0EknxrZ

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250521 14:20]:
> If a user wishes to enable KSM mergeability for an entire process and all
> fork/exec'd processes that come after it, they use the prctl()
> PR_SET_MEMORY_MERGE operation.
> 
> This defaults all newly mapped VMAs to have the VM_MERGEABLE VMA flag set
> (in order to indicate they are KSM mergeable), as well as setting this flag
> for all existing VMAs.
> 
> However it also entirely and completely breaks VMA merging for the process
> and all forked (and fork/exec'd) processes.
> 
> This is because when a new mapping is proposed, the flags specified will
> never have VM_MERGEABLE set. However all adjacent VMAs will already have
> VM_MERGEABLE set, rendering VMAs unmergeable by default.
> 
> To work around this, we try to set the VM_MERGEABLE flag prior to
> attempting a merge. In the case of brk() this can always be done.
> 
> However on mmap() things are more complicated - while KSM is not supported
> for file-backed mappings, it is supported for MAP_PRIVATE file-backed
> mappings.
> 
> And these mappings may have deprecated .mmap() callbacks specified which
> could, in theory, adjust flags and thus KSM eligiblity.
> 
> This is unlikely to cause an issue on merge, as any adjacent file-backed
> mappings would already have the same post-.mmap() callback attributes, and
> thus would naturally not be merged.
> 
> But for the purposes of establishing a VMA as KSM-eligible (as well as
> initially scanning the VMA), this is potentially very problematic.
> 
> So we check to determine whether this at all possible. If not, we set
> VM_MERGEABLE prior to the merge attempt on mmap(), otherwise we retain the
> previous behaviour.
> 
> When .mmap_prepare() is more widely used, we can remove this precaution.
> 
> While this doesn't quite cover all cases, it covers a great many (all
> anonymous memory, for instance), meaning we should already see a
> significant improvement in VMA mergeability.
> 
> Since, when it comes to file-backed mappings (other than shmem) we are
> really only interested in MAP_PRIVATE mappings which have an available anon
> page by default. Therefore, the VM_SPECIAL restriction makes less sense for
> KSM.
> 
> In a future series we therefore intend to remove this limitation, which
> ought to simplify this implementation. However it makes sense to defer
> doing so until a later stage so we can first address this mergeability
> issue.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process") # please no backport!
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/ksm.h |  8 +++++---
>  mm/ksm.c            | 18 +++++++++++------
>  mm/vma.c            | 49 +++++++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 64 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/ksm.h b/include/linux/ksm.h
> index d73095b5cd96..51787f0b0208 100644
> --- a/include/linux/ksm.h
> +++ b/include/linux/ksm.h
> @@ -17,8 +17,8 @@
>  #ifdef CONFIG_KSM
>  int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
>  		unsigned long end, int advice, unsigned long *vm_flags);
> -
> -void ksm_add_vma(struct vm_area_struct *vma);
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags);
>  int ksm_enable_merge_any(struct mm_struct *mm);
>  int ksm_disable_merge_any(struct mm_struct *mm);
>  int ksm_disable(struct mm_struct *mm);
> @@ -97,8 +97,10 @@ bool ksm_process_mergeable(struct mm_struct *mm);
> 
>  #else  /* !CONFIG_KSM */
> 
> -static inline void ksm_add_vma(struct vm_area_struct *vma)
> +static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
> +		const struct file *file, vm_flags_t vm_flags)
>  {
> +	return vm_flags;
>  }
> 
>  static inline int ksm_disable(struct mm_struct *mm)
> diff --git a/mm/ksm.c b/mm/ksm.c
> index d0c763abd499..18b3690bb69a 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2731,16 +2731,22 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
>  	return 0;
>  }
>  /**
> - * ksm_add_vma - Mark vma as mergeable if compatible
> + * ksm_vma_flags - Update VMA flags to mark as mergeable if compatible
>   *
> - * @vma:  Pointer to vma
> + * @mm:       Proposed VMA's mm_struct
> + * @file:     Proposed VMA's file-backed mapping, if any.
> + * @vm_flags: Proposed VMA"s flags.
> + *
> + * Returns: @vm_flags possibly updated to mark mergeable.
>   */
> -void ksm_add_vma(struct vm_area_struct *vma)
> +vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
> +			 vm_flags_t vm_flags)
>  {
> -	struct mm_struct *mm = vma->vm_mm;
> +	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags) &&
> +	    __ksm_should_add_vma(file, vm_flags))
> +		vm_flags |= VM_MERGEABLE;
> 
> -	if (test_bit(MMF_VM_MERGE_ANY, &mm->flags))
> -		__ksm_add_vma(vma);
> +	return vm_flags;
>  }
> 
>  static void ksm_add_vmas(struct mm_struct *mm)
> diff --git a/mm/vma.c b/mm/vma.c
> index 3ff6cfbe3338..5bebe55ea737 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -2482,7 +2482,6 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	 */
>  	if (!vma_is_anonymous(vma))
>  		khugepaged_enter_vma(vma, map->flags);
> -	ksm_add_vma(vma);
>  	*vmap = vma;
>  	return 0;
> 
> @@ -2585,6 +2584,45 @@ static void set_vma_user_defined_fields(struct vm_area_struct *vma,
>  	vma->vm_private_data = map->vm_private_data;
>  }
> 
> +static void update_ksm_flags(struct mmap_state *map)
> +{
> +	map->flags = ksm_vma_flags(map->mm, map->file, map->flags);
> +}
> +
> +/*
> + * Are we guaranteed no driver can change state such as to preclude KSM merging?
> + * If so, let's set the KSM mergeable flag early so we don't break VMA merging.
> + *
> + * This is applicable when PR_SET_MEMORY_MERGE has been set on the mm_struct via
> + * prctl() causing newly mapped VMAs to have the KSM mergeable VMA flag set.
> + *
> + * If this is not the case, then we set the flag after considering mergeability,
> + * which will prevent mergeability as, when PR_SET_MEMORY_MERGE is set, a new
> + * VMA will not have the KSM mergeability VMA flag set, but all other VMAs will,
> + * preventing any merge.
> + */
> +static bool can_set_ksm_flags_early(struct mmap_state *map)
> +{
> +	struct file *file = map->file;
> +
> +	/* Anonymous mappings have no driver which can change them. */
> +	if (!file)
> +		return true;
> +
> +	/* shmem is safe. */
> +	if (shmem_file(file))
> +		return true;
> +
> +	/*
> +	 * If .mmap_prepare() is specified, then the driver will have already
> +	 * manipulated state prior to updating KSM flags.
> +	 */
> +	if (file->f_op->mmap_prepare)
> +		return true;
> +
> +	return false;
> +}
> +
>  static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>  		struct list_head *uf)
> @@ -2595,6 +2633,7 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
>  	VMA_ITERATOR(vmi, mm, addr);
>  	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
> +	bool check_ksm_early = can_set_ksm_flags_early(&map);
> 
>  	error = __mmap_prepare(&map, uf);
>  	if (!error && have_mmap_prepare)
> @@ -2602,6 +2641,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
>  	if (error)
>  		goto abort_munmap;
> 
> +	if (check_ksm_early)
> +		update_ksm_flags(&map);
> +
>  	/* Attempt to merge with adjacent VMAs... */
>  	if (map.prev || map.next) {
>  		VMG_MMAP_STATE(vmg, &map, /* vma = */ NULL);
> @@ -2611,6 +2653,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
> 
>  	/* ...but if we can't, allocate a new VMA. */
>  	if (!vma) {
> +		if (!check_ksm_early)
> +			update_ksm_flags(&map);
> +
>  		error = __mmap_new_vma(&map, &vma);
>  		if (error)
>  			goto unacct_error;
> @@ -2713,6 +2758,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	 * Note: This happens *after* clearing old mappings in some code paths.
>  	 */
>  	flags |= VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> +	flags = ksm_vma_flags(mm, NULL, flags);
>  	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
>  		return -ENOMEM;
> 
> @@ -2756,7 +2802,6 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> 
>  	mm->map_count++;
>  	validate_mm(mm);
> -	ksm_add_vma(vma);

Well, that was in the wrong place.

>  out:
>  	perf_event_mmap(vma);
>  	mm->total_vm += len >> PAGE_SHIFT;
> --
> 2.49.0

