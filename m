Return-Path: <linux-fsdevel+bounces-28675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D0E96D0D4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58D80B2527B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 07:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09668193432;
	Thu,  5 Sep 2024 07:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S34LbMis";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hy3JhqR5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04D21925B5;
	Thu,  5 Sep 2024 07:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725522722; cv=fail; b=GiyUEMYCPoZa/0O1frEo68MLJKbZDuOzeParniy0f8Ebx3nOtUShbHNoXj9fEWgSZoT9ThNdiMMHEOCADb6b8jWuhet+UwKfNXkhKb1+A+2V5kgOWZKFW5p4rLrfSeS5ttwXBgPI6iCtEwiCB+RMfaIAQojk2djVEPHk2bYgjEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725522722; c=relaxed/simple;
	bh=g4BKpsaPh4ZgDNIfEsItDUaitMIDJhIRBEmEpahapbc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MNNE2c+5slO+bJzvv9x43UcC4iJjtWTOjLzAEdoT3j7ZImNRg6k1KGZxVRDIUIJFPw0Xl2adHn2+GmU1V/shwF4x9i7SkCaJL1ZoudQbP3QiDntyODWVJ+AyceeMXwUSBDAEdA9VB8BH2ryXaBzIzBmfuN03cxziU/OO/FSypvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S34LbMis; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hy3JhqR5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4853uFrW032439;
	Thu, 5 Sep 2024 07:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=M4lCHuiH5JtGxb9Sp4wXaXi+Yr6h3U+5zIPlD93Wmkw=; b=
	S34LbMisIHGTOMAd5T/abDgWIuyact8sj+xhjSHb3iUPgmkbYJgZ/8B1kmAZuakL
	2TMytvcAObfFTasdn0gKqRkTnqwe2FjF6haRVopC/poU2ByWU25/w56gkec/jztJ
	yPausTAnUbFBjgikGcP8bdOiByI9sVy4PnORx5sm4uQmT0nVlQECRVLDx7kSCnUR
	mrUxAIzvuEop13GwhrjZ+5urUOOBM8kdcKpVJZVuQpMqPXD47l4ATQ90NDcg4LQH
	ZbEopZGqcVIj3mY/6kMyikQMqXlhj4IhOvZ7oEmFYTOMyb9lZP8Zz/R6exLMABCa
	F7XsIfBKQlUpQKGxF0Uh8A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41dr0jwnre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 07:51:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4857iYMa023558;
	Thu, 5 Sep 2024 07:51:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41bsmam3nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Sep 2024 07:51:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQqw7ZmlFCtM6xSutOwCZP8/Fwp9cax0d84WxtityWQnjNkA9TZRa8eZmM1ZJQt5kHLEzjIgXAUiNx7At9tA+datwC2urVThr5g/pZwRPyLcuo/lkU4x9FCufGNWJEBe9Vv6MnrvECqXOKCXob6duMAsDi/HQpK0QRjgjFobYdZyzDsw8PWttuJQQ4ygIO93ZmfVR/O5PAZ/JAmV3mmjDKVf8CKnCMvxw9jBF3F3OUv1CDRPhwnevX6JVX153uNDiGWfjSlC4MY4jEhbE9xQzsFs2Acmb+1bfR9jjNKzeXlt4Dpl/nV2szw72UmsGr6ZajLHGJ3ISQaOj4sLXq7UlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4lCHuiH5JtGxb9Sp4wXaXi+Yr6h3U+5zIPlD93Wmkw=;
 b=YfrQy84KKS6AwI2NdaxpO0TFOAmILlKh5lKzWIZJnQFI1KSsXDdD8Kjc59H+tQUIFe97Bjkpwtqh97hHZ924BQWKMFTFM0Ph/UZL3J5rwwBoftKiEnflxf293gHVvPy+k7RtJdeCGabEWg0rYWusSCbFucpXiRKTFqS+qQgMaWdg3GNN76LbLjhKF2VJ2nfhRtENV1nFZ03lDC9Rfy1Hh0JRTCRLh2u1YqecM32LBmTTKoM91LZsbGn/Ma0mmmNXaIqMJIBCauozJqTzlwI2pkN+z97RlgK8W0/XBOZ2evS0qmiqjo611xo4bIQU81SD6QGQ6+voat2dmJVegYAIgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4lCHuiH5JtGxb9Sp4wXaXi+Yr6h3U+5zIPlD93Wmkw=;
 b=hy3JhqR5OvuQpuMplR19ZgOzNM7gi08uj8lc0WMUMyzjR+2oyOOTW7ZudLqnMj1lELv7oim8OahzNMdnE6JN+TjDK+omgOJegR8EhMEUho6OMyGqrGwbk1vJsiAq8KqJ9G/co9LbfjGMm4ABHhKJAs47QLwCWc6LYo5KJ4EfuLA=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Thu, 5 Sep
 2024 07:51:43 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%3]) with mapi id 15.20.7918.012; Thu, 5 Sep 2024
 07:51:43 +0000
Message-ID: <b9bcc708-ec17-47a6-92cd-2347de23fccd@oracle.com>
Date: Thu, 5 Sep 2024 08:51:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] xfs: make EOF allocation simpler
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240813163638.3751939-1-john.g.garry@oracle.com>
 <20240813163638.3751939-5-john.g.garry@oracle.com> <87ed5z2s5a.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87ed5z2s5a.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB4774:EE_
X-MS-Office365-Filtering-Correlation-Id: 0675800c-5a06-4015-aba6-08dccd7f9579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0R6YUY0eFQzNG5PdnBTeHo4eDNrZXJ3TlR0K0RtMS9Gb1ZBTTJEMk1HaytH?=
 =?utf-8?B?MVN1MkdPS3hZNk55eVUrdENGYkc1c09KbkJyWGJuOHlveFExQll1dWlHYUk4?=
 =?utf-8?B?QWcvNXAwUzdrNStJbFVvckZISDl6a1hLSzJxR1JoOXpjdEhQbDZHeUl1RmRF?=
 =?utf-8?B?N3pST1IyZ09LK0ZDcUczQjlRYW02NTV6aXBEOEJwK2NFU2VFak1XdUF2Y202?=
 =?utf-8?B?TFYrcnNqWDVsYnBvMjAzN25GeW9LQ2t5c09VRWtJMnJjS2x3ZnBxVjYxUmFa?=
 =?utf-8?B?T2lHZmV4b3QrMXVYSUEzdnk4eWVuL0k3TzlOaTUvekN1dmFrSCtrK1RJcGUz?=
 =?utf-8?B?RFFLdWFVQmNnejlHUys0UkdtT1Q0TFQvamtUY0FiZXh0MzJNSkZBWVVGVlc1?=
 =?utf-8?B?b0JtYkR0cFBhQ0cvS2JkcG81UEM3cC9qSVJmSmlpSlg2RmhtaVAwN3lEQ3JZ?=
 =?utf-8?B?WTVJTzVwelFmbVc5RjI3VjFQNURNaUJkVllUKzVMVHNoeGdLL0I0MW1VRnRW?=
 =?utf-8?B?U0dSRkprcE80Q0huZW40YjlGT1dGOW5XOHBSUEdZTVdtNDFKVk1QKzdzVUJN?=
 =?utf-8?B?aHZHNXEvSVM4NkF3TURjNTdHM0JRWWlhajRvMWh5TTFsOFVQL1dFWTBvb1Qw?=
 =?utf-8?B?Z2dpRS9ZQ3NhcHloQjdsS25SNzdIVkhBYkgxSXpLRUtMd2F0TDI3eGEzbGFG?=
 =?utf-8?B?dmRVaHZoQmRqQ2g0NTI5aThVbzdIMDlIaGRWNlhlWW9GWG5MNi9oanowTGtu?=
 =?utf-8?B?bk9vU0ttc09tY3p6dm00WDVpZkZqWVNlcVdJUG5Yd200anFqWW1TdWl5a1RP?=
 =?utf-8?B?ZUE2VGduRHYvbXZocm04eXhlSlN3REdCQ0hKamVZLzZEVjQyY1M2aUJ6K0t6?=
 =?utf-8?B?eGNzTW5jVnZIem55QWxLNGdBUEh6bkNYcWtreitHTW91c28xUCtSUXhqTkp0?=
 =?utf-8?B?MkcwMUdrWTdJZ2QzZWVFOVYvOVJpcDBGVXEzTzlMYS93anBFeHd3VkVEQjlh?=
 =?utf-8?B?QVdxYkdtU1JOb1FwMG12ZnkrUVJzV0x4d1NNaWora2NmMDdQeGRTU3djcUJh?=
 =?utf-8?B?VSt3aldBVGRtZFJadGRPSFoxN2oza0NORFBSbXJ0bTA2cStFbWcwci9rb3N1?=
 =?utf-8?B?alg2aFBia0tDZlQraUxuRDR3U3dCNzlZOGkzVnRJcEIyTGRTclk1RGxJSTFs?=
 =?utf-8?B?bnRDVVZoa1FWZENvbFNBRzgwaVgvN0pTQklITU5oWTZ0UEdsRkVZM1YveGJt?=
 =?utf-8?B?bmhlZmdaalJaTysvdWk1ZVc0M1dKZm9rVGRTeXNTb3YvdnhrbXlOa092M3k5?=
 =?utf-8?B?SWt4eS9qK2dUZWhnMWxmeDRXVFlBWE50SG92ZDd3ejBBUkZPbjVrdzNNRGgv?=
 =?utf-8?B?bm5GWGZkQUYwUS9FMGZYWEpoMmtUeW9PeWFuQnlGSFptM0ZhQWMzTUFvRi9V?=
 =?utf-8?B?anJmWGUzRjJ6Z1JEcjNqQWNpekFBS2tvdGF0dzZLcUhPUzROdlBPcTFLMnVs?=
 =?utf-8?B?RUowUlM4d0hVL0NzQ0VQSGU0RG16QzVCcU1JU0tveVJqaGF1WUhsMDNid2pm?=
 =?utf-8?B?WUtvMEVNSWNVejhoMUFqMlhmeU5QeVIzaytwdFpRSjJFM2l1Z2FVRkxBVWFz?=
 =?utf-8?B?MTVKbFpYZHcvWWV2RWVMdGFLZUNvUTkzUGRXRHN3RitvVGVldDV5S2tkaXhW?=
 =?utf-8?B?N2lRZjBNQXlHc0VkUk12WS9hQS9NQ2szVHlxVThBaWFKTzVTSnp5R2ZhdVpO?=
 =?utf-8?B?dEZOM2xXeGlhTVdQUnNiZVhmMnF6OGxBeGVvVW9EUW14dDNXY1JDVGNqamJO?=
 =?utf-8?B?VWovM2RUUVFDc2FRbUMrdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmZGYmp5SjU0U2tiZFA0Y1UvT2tjSW9zYWs4Zi9VblpwdWlFVFluL01PK2hD?=
 =?utf-8?B?di9TbGFFSEFpQUZrUG1HN1JKMk5BSVNxa1ZlUmJnbUoxcjlKWVltcnFnd1di?=
 =?utf-8?B?SlZNeEtSTk1NeS9uZkdqWXF5bVNnRFZvcExuYUJwTUhhZWxJR0NEM05ib1Q5?=
 =?utf-8?B?a1pCRFJjL0lxMituVnlRODhrUGVpYXBEd2cwcE5GZWp2ajlldzNpeHV4aHhE?=
 =?utf-8?B?MHFJSEtsWGVSSjVBdUd6WkM1WVgzdDJBN2FhMld1NCtWTmxBMjRJcEJyUjBS?=
 =?utf-8?B?TnVBcEVaU1FiTlN3SXB5T1dXcVlZUzgvUWtLd21IcEhSalJ6dzFLMjVoa25P?=
 =?utf-8?B?VWFnQzU5Zll1cEFDaS9WZWNrRzJKbVA5RE5qQjJVWmZJaVJDS0NPR2NaY0hu?=
 =?utf-8?B?d1J0LzlHa3pNU0VIdEUyZDczK2hJMlU2VTJxalRSNXFBVW9Cai9PZUFianFi?=
 =?utf-8?B?aGtydWRGRGorV2JYdEM5SWhialdBbmJHKytQVzJDWGFGWXVLY0lUVW9PbXUv?=
 =?utf-8?B?WVpCSFppZmlZb1JPSWJieFNWRm5kcTAvYnZzK0lKcHFMZjdxVEgvUGhNRHFh?=
 =?utf-8?B?b05KcEpxamMyZVM1VjRZNlY4SlVtNWZVSm9MeVh6M0xoSlhFaE1INm8yMkVz?=
 =?utf-8?B?aDZqL1NhQUo4YVNwSnNpSDFjeTBEaHZ4WlI3U01RZHJ2T2ZpYjdyS0IvZTJq?=
 =?utf-8?B?WEVFQ25nS0IwNS9oZy9GbzhWem5pdWZ2UkFzSUUvK2pDRUI2Y3lXdzVvRytm?=
 =?utf-8?B?MzFHc3Z2aWUxT0RtalhNK1I4WFBkczFhTDhTLzNxQ2FaSHlMRXdhVnY1WFFC?=
 =?utf-8?B?K3RkY1hVZVZKS1NFTjcxNVNYQ2tMTlZiVnVRWkZyOW9mclJZaHArUkJBZG5S?=
 =?utf-8?B?NmNBOVBnR013eUxsWmIwcnprTy9DL3cxeUJIVE9aWFd4N0dEaHY4Z2JhM2p1?=
 =?utf-8?B?MDZCRnlkbkUrYVE2ckU5T0tZQnF0ZEVGWUFQOE9CaForbCs0Sjhpa0Mwc1dm?=
 =?utf-8?B?TjdzRUNjczdIQjRaMGRiU0RQc0NaTXcrakNVQnF1YWxrT3lyMmxQQjZMb00w?=
 =?utf-8?B?Mkd5WDhaa2VTSlpmM2xYZHdndmZkWFE0Nm9DOU5aN2V1R2VuQ1NJWC9kT1NM?=
 =?utf-8?B?alRvcVhDTU5vc3hTUlQ3Q3NHaDcwUHZWalRSQk1uZ1JsQWl0S3Rad1ZBWS9h?=
 =?utf-8?B?eXNJYmx6NjlqeHZTRlN5bVUzamJjZlZrdytSbzFJcFNGM1YwTHBDRzJnVGJF?=
 =?utf-8?B?QmVBYlFLamFFMUd6YVNjYmVtbXVnb3ZZYUFHeHNTN1RHKzNpa2NVNmhiMVNi?=
 =?utf-8?B?cXJIQituK09aczkySXdjMTc4R2c4N2VCdGZXbHZyaDY1Q2hIcDUyczVZMy83?=
 =?utf-8?B?azlKOEFGSmJQMXpySVRabUZPUGlJdGxRbDZvQkRHRHl1QVlFd0Nsa1RMQlE0?=
 =?utf-8?B?ak45anYzTTAzQUR2S0tVNjdOZUt0UmhHMHFyMEcvc2t3TzJyTUlDN1RxY2xF?=
 =?utf-8?B?R2V5YjVqNXJEamVUWDI5U0ptYm5BZUpmM1ZxTFZ1THlYOXZaTkJPU1VqYlVm?=
 =?utf-8?B?U1h1U3BoQVJDa0VDYUdwNmNIM1lNM0RxRHE3aHZMZ3NxZHNZWEJFdTRnNDZQ?=
 =?utf-8?B?U2w4cnFhVG85K2dUWFNZYi9VZTZVeWsvT1ZDUHNZZVhmYTBBblR4d0lMOEJC?=
 =?utf-8?B?elJvYno0bzZiaVhzVjlMYVJJRWJuVGNwTDYxaG91QzJBWEs0bUZDSkM1TzNn?=
 =?utf-8?B?Q0JCTHhic3RHWnZ0OFpUblhVbHRjT2lzL01ScUhabmVwMXJIWVZGUW9KSiti?=
 =?utf-8?B?Q3JsdkVrSmZtcm9LSVRLN2xIVUcyd3QrR2lHUFlTZDR6Z2xlUU01TEhKRldN?=
 =?utf-8?B?Y01EU2RZU3c4Rm9HMkMzVzBVSVBQbHZRTk14RHVmRDE4ZEE3UElqSzl3N2JT?=
 =?utf-8?B?OHQ2SFk4cGQ5MmF6bVUwMU5IbFI1WFNHcjhLOWlhdkNXc1pVbUtUVVZsNzY3?=
 =?utf-8?B?Vi9KOWdJTXY1L2s1RWVIKzIzYnpYSU80ZEhlS0RFbWprT0c5dEp1NzFObUly?=
 =?utf-8?B?Ylo4b2l2eTJGS3NBRGNaK3pXcG5JSEh0a2lXRjA3SWxPd2JMMGtYOWp5OVdL?=
 =?utf-8?Q?h4loZy1L7EeJXtN+gEtfzlQoj?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RAQvy5oXbkATTy6rwT5jrkJv+UOod1zlmeRApS1oTnyqqh8Cd6UHm2/PcF7l1031puaOGjujjmC5u0ujp7Dp7DBAvuerep9GHXPN/EWC6zi5bQLArbEijFeEStMCfQ/vO84yqSO6yU1eSGEsBYNdF5bhnYxzrqiw52NGSDK0qM+Tuo4bC0bISvVL0L3Ff3F26skBl0tcQHgtl0cKhb8j6dAQ3ENQLZiQA5d9J/665hneIpdlMzeJWdl5ATrQOLqGuGnMdLy1LQ0MHksORfXp1CuFW4Gu5IQgiXIRuydfhec14pRPHrU1IkJ55dcG1heJobvd0Cu7chKvqFLgTqzWG/4O+MG3mgYP8hTw+Qlr613HsQBlH7MfnnZSVWTu7jrVQpeqZBIAV9Ub6ZIkLtM8k8n3sA2SDeY0pkub6ar44KPC1nY4zNfVAVc2GoRqRPV3ogqCXWZ57UvZ2Ty1cQgt8s80bv6z8HA0653C3Aj0I5vPev6+9hfjCfdTPNhK89e/7n/Wnqvz+DlyMKse4e5NzxioeMvwhzPpCT3WS5V+xq94vAngQ69W2dPxVa8KF/Il1s0H8iNN8juQOY+/xzEw7tPWwYOPFSaO7xxsbjKm4N4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0675800c-5a06-4015-aba6-08dccd7f9579
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:51:43.4850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4idZwmUbBwGoDnrv1b0FFxcXxjDzceNy8vqzTSwABhKlIDIpSsPaIybFVgvUz8ivUL0NdeC5FJcS1sDgRxJvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=917 suspectscore=0
 mlxscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2409050056
X-Proofpoint-GUID: 5DHx40JU2kJnfkS0o6TVoNwtEbgNk9MZ
X-Proofpoint-ORIG-GUID: 5DHx40JU2kJnfkS0o6TVoNwtEbgNk9MZ

On 04/09/2024 19:25, Ritesh Harjani (IBM) wrote:
>> diff --git a/fs/xfs/libxfs/xfs_ialloc.c b/fs/xfs/libxfs/xfs_ialloc.c
>> index 2fa29d2f004e..c5d220d51757 100644
>> --- a/fs/xfs/libxfs/xfs_ialloc.c
>> +++ b/fs/xfs/libxfs/xfs_ialloc.c
>> @@ -780,7 +780,7 @@ xfs_ialloc_ag_alloc(
>>   		 * the exact agbno requirement and increase the alignment
>>   		 * instead. It is critical that the total size of the request
>>   		 * (len + alignment + slop) does not increase from this point
>> -		 * on, so reset minalignslop to ensure it is not included in
>> +		 * on, so reset alignslop to ensure it is not included in
>>   		 * subsequent requests.
>>   		 */
>>   		args.alignslop = 0;
> minor comment: Looks like this diff got leftover from previous patch
> where we cleanup minalignslop/alignslop.

Right, that comment modification belongs in the previous patch - I will 
relocate.

Thanks,
John

