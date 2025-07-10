Return-Path: <linux-fsdevel+bounces-54521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D8B006AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7791C40EC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978312749D1;
	Thu, 10 Jul 2025 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ui6edvhE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e+IiyyUi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568FBBE6C;
	Thu, 10 Jul 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752161379; cv=fail; b=SXAveisvQXwkcV3MAb1p54EK3s0e2/cUW3RSDWwNc68p297LdNT7iPt7i0j6N+d1nJC5sbTq/8Tt1ZE431ful9xTw7VVuJDEgILRfrVxZ6oFaeMT4FDk2R5Wq5ERaAqv+OzWeIEiPd81OIQJwjZg/3s4tPsC2rPf9eTRJ8q6lkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752161379; c=relaxed/simple;
	bh=Yyi3ah+umiH4DApgqGlafVY8aw5nPQFlwLb5D8hW5GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ujmXYF/j4zk1q1sXI9bb6HRmHqWcMq/0qIlPIESLk8yH7Z3MXFxbssXv8cgnqYBwQCTQ4lrEOTAMWcgIKNyNwsbpqObzT7/+vFSMy857aCPEuh7fJqhV6d+djplxXlusgYjAMTWQ4uUuZ2OwyIWLeW5PZDSkz2v6rG63FPinOVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ui6edvhE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e+IiyyUi; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF72sN007427;
	Thu, 10 Jul 2025 15:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AdS0FoiFE7h+W1c6DK
	E8xMUB47yeh00VWPjHa2w6Fdg=; b=Ui6edvhEZI0fWQg3Sk5nlfJOQ2whgFKZhq
	1Xanbk3GDDyjj1YZ9ZvEs2fWSAUVnvJI8Ept5VtAepnKDrTQTBWFyOghRrQUSNJB
	Kk1WjgMrReKBK2nspmAlEvtDtSHdAhthfiUzuJE9YkJoKCnLSbXiU4VwtFvDNThb
	w4Pbk06PqxZjfYc11ZbeMpe0IGBqF6ZCV1ukliB05C/YumCJt/uVQJyelwAS6Bjg
	IADVJNfVCXKpEQWSae6uvsAvdUxj3inEaJUQMqh36suQtuHOSwt0qs7EmNn4xGXq
	L1xCcBjzeK/kRX/x7Uyb7vi+Ud1FQofMJg71mp5+F0c3bl8PCqMg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd01mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:29:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF94SP027452;
	Thu, 10 Jul 2025 15:29:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgce43x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:29:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Za6J0KaGVG94LR0On+YjB8QzxBoNEMo3u+OWlZ+ispiUmbwLZs8RWCA3ybe0sF6LIzHm73ruFwTvWgA27YfxhVQS7FC5tz9B3pLmGKXb1MGh7qU3RSwKYlNSelWdumG8E0MhjLghy0UopD21OiJtxcIR0BMF5k+0h4d4m1uKiCb/Z1Yg4S1KCjYbGv0WTmYtNLixoQDmZjgaU1YAb8XJ1nsTNb2n8iGTDBPa9yRmpLLdWhHnNiEfKADKpj4fkQpF209doTvuY2T2gSQzBzy1dG7r2zP5PuwkImkFPUsgTRcFhTwQIqGyUzp+bCM2nv6Wvo7nKDBHMTl2OhoQsXe7xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AdS0FoiFE7h+W1c6DKE8xMUB47yeh00VWPjHa2w6Fdg=;
 b=ScMDcJHK6q0Wpk5AF8hnREnlnf2Dq0XcgB+2HLbk6h/pW+WHhvrz7oKC994V9lJzeYdL/NXMIlch2lfENnqJkzxW8K2ZPIQxlkhhcDAd0fDK6TUB09QnSHlE6vjBi5vq/3B3yoguKqPtWaNA/28WY1BdAXcoqzGPwUnTG+86/MyYK6uh/1daPuoyUyLUwNFrx2Ok9db3WFCyrw/ERC8/jTirlqhS5HoDVeEqhua+m6hYqeijnwd7PTC+ei3aZOXu8yPJvrvmIZdbXkNMujx9fskxVRW3751Sf2UGp/dFiWzdxq1DWBP3MOtYmbRRUD4EITsU2Ht6TVUQ3q8T9P8ywA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdS0FoiFE7h+W1c6DKE8xMUB47yeh00VWPjHa2w6Fdg=;
 b=e+IiyyUimWKphdNjR++sR8XU/O70y/3EetU8KLbFqm0xo4AuiDSrTmqIJw3jfsIG75TPhYpqoQX22htagUM88OBM/4+cYX2zpXrW6vgC9RLlyzI7oz2w9qfB4orVdJtRkwyn1127LhsRNkOv3sS2Cg55188JPgEgMRTZnnOGemI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ2PR10MB6961.namprd10.prod.outlook.com (2603:10b6:a03:4d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Thu, 10 Jul
 2025 15:28:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:28:59 +0000
Date: Thu, 10 Jul 2025 16:28:58 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Xu <peterx@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 04/10] mm/mremap: cleanup post-processing stage of mremap
Message-ID: <d3facf9d-9a65-401b-880e-4e321b6b4794@lucifer.local>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <d21f091bb617d0ac31b6e541d6c6ce28afe880c1.1751865330.git.lorenzo.stoakes@oracle.com>
 <277aa9f4-ddb7-4f34-ad15-a98888108cb5@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <277aa9f4-ddb7-4f34-ad15-a98888108cb5@suse.cz>
X-ClientProxiedBy: LO2P265CA0290.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ2PR10MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 515aa44a-6832-4a15-c3b9-08ddbfc67e2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C38Ck4N9qYIda3OXdnbuNukjHWnXcfy7K0+A/0/73AsBwZHTEl5EuDLmPoWo?=
 =?us-ascii?Q?8FK4+hDOWQ5Asft9TH1Q9pGLib+O3KN56Yl0A57p4PhVvP7HVCnhEIVFahXs?=
 =?us-ascii?Q?VM1dJZRJep67W+DrDU8jDZYXqE3sa/ZEOXPBX9WfGphsXJ/Fhm6Trua0ZNT4?=
 =?us-ascii?Q?D1mBMDZbUVBUBGtsS9m3NU/cjiyiiqQHXPOn5GZIrsIQqid6E2RVdtXhIDZj?=
 =?us-ascii?Q?EHtL9YsYorvxhz0ygMb+mYyo029ArFZLa/6LLtysgMb6YoMio0yZ2S5D34M/?=
 =?us-ascii?Q?LxwTtnHiSaBfFow29Tic7LyMEizTLIK8RUslHew270sTmg/Sc8Z9UL7wtNka?=
 =?us-ascii?Q?pKUJQ5DYx4cmYzk4rFn0+MqX/TL3cpOGtNSx2zyDldUrFdafJ4iRMdTrDXoG?=
 =?us-ascii?Q?67r9Z9KhOJnLt3p2YKngnLZDkSAytCz/HdFb1vyMbo6qXBdlYSHtVaM2gCJ5?=
 =?us-ascii?Q?kvdVJI6v3ksRMMz7ZGQfwEJOTc+7C/pj3wCy58t54U8K1M5cfqt0FQHNsxvN?=
 =?us-ascii?Q?RazFmPolFGmtnMPhAkQ3CP22bWLhJbCFD5sG5vI8rnRxypoaIkYqfVy1HAkM?=
 =?us-ascii?Q?CblBOKzAyx9kMmp6Spwj3wESR/BtA5UdbC77fhnkUrgsJ+/pwa3iA4Sh9tNw?=
 =?us-ascii?Q?yfjF80p9iztXSNjPljOlY/KsdiPcUu8tunoDmOahcy6y5v2jS4eXEdgPgKgJ?=
 =?us-ascii?Q?tE/vlN3LzV6fJxiP4jC1/U8tcervEmOJ+2tX4k4x+mwLRb792VMgydQ1ZxpI?=
 =?us-ascii?Q?KqbTBMVcf2TOBZbOCDE+yHcMmMc/7UpCvtiWUR+2Jdx4p9dmfRxzkLyNhgbN?=
 =?us-ascii?Q?2hEQDsJxaaHaq1TaO+DVhWJP2OSu5Db8qZDVbdyYULhYkMQzv99PJsTvOtCD?=
 =?us-ascii?Q?Vmay0a/7F9TlHwPDuB2HiDWbD1C7lXeTuwk4W9b0qDsLJsXaKJnAzqhAHL1n?=
 =?us-ascii?Q?ujWhUDBL9URqYHuPqjR+40luB/1HAKoArpu9MYTF9ihmVEKHQy4ve60DKs5R?=
 =?us-ascii?Q?KokevWK550FyxOLD471plIRRn/Uq8DtBM1fR6PyMjnfQq9fpbIdzxnsxwxfl?=
 =?us-ascii?Q?m4VBk2X1NhCHPn5XhUaji2nIazZ2Cl9lVHwDY61is3Zc4FYDovCLZuQQS43k?=
 =?us-ascii?Q?2UJgYfOCy2mfN2+CH5WeuKUByrVgXfTYsJj21Hj5i3wW3IZ+Te49sYOm0YBI?=
 =?us-ascii?Q?m9RQ1KLPnhw7wNB1Ui5iYWxyFVdRzY3SJ+hu9alesE1KI9iM7cl1lblWaDrE?=
 =?us-ascii?Q?Kbwq6Y1GIl1Eofq9bwjXjAAhtSGoEFlNJaMZG5Ev8N8XOxH/xcQU92S0hRdW?=
 =?us-ascii?Q?O5dKBISTV1z5NeVp2fKKX01e87wAEo6ljO2fvxL4RMmuDfaUupJFoFGqyjJy?=
 =?us-ascii?Q?fI7eBC0c3Lwwuz3U7oYA/SP5tMLigTM7cjozOZlr9z7UDRSlXMvGZ1gy08Ek?=
 =?us-ascii?Q?+U5p8R89g0c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pYzaHFFSdHsFgFc1TSjp8h0XN/jTNYUTso+1xNEzSLx+0qTwdoVyTyHIdRoA?=
 =?us-ascii?Q?P5GxSvwoE8L9iNA/qGoWcNHbtfAxhsCqhaxArZ3FEsXXYyNUVwsnGOjVNkpQ?=
 =?us-ascii?Q?sU3KGZ7PUCCx/WuQQ1CSLCLe7E78Wb5kIc+w3mf7YAq1+ZTc3UY3YvR2m3bt?=
 =?us-ascii?Q?olO5OMrhH7NDMs7giLk55pC/tE2JywcP3lQ33Rc6LdmcDp4du3IvzGNak+/Q?=
 =?us-ascii?Q?4reLnNAwDs6rTzJ/aP+4/ziiHb0PcF7+h16VCBX9MYsTZL/Fam9AsyU7HWVK?=
 =?us-ascii?Q?nU6b6KSrMprBvTKx7/DbOXTN7/hUf7Q52IhntoP9T9iF1vIW6fMnQmwJK9an?=
 =?us-ascii?Q?7fmM9OcafNdMHwkWAkGp3anlMcCV20ppo5j7SSH+G5rsZJF/r+TE7/B9AKZT?=
 =?us-ascii?Q?OJW7QCypr15ARM3oPq/1WZePWjA3J+QLaf9hV6ulzTMTcS7UPvNpInFbXG1V?=
 =?us-ascii?Q?5ilLMsP1+wSA3486AIvfeCQBfDq98PtCMbtsplR7ZIYSbyW44aibAXZABa5J?=
 =?us-ascii?Q?QWbo7wyI4SGnsBGF/zdO8j5LNE1NjlJda8aMKGFPm59viBroAIpWbZQn4XCH?=
 =?us-ascii?Q?4NPvv8juS5Cge7mQIXVenlmRRNKZgCnnI4n4566h4c+S/BZO+10D4hG035hK?=
 =?us-ascii?Q?fPn91dkcMnpSAix/4TY+n/Ug398iGueZeRKLIMrnWEjuABeohraUkxrEWpwx?=
 =?us-ascii?Q?CR5FzP7a9p5Ey8J7fUVsmLy8rrlmgu4ai64mwz+Qlxnvjzeecz02KhAnejvc?=
 =?us-ascii?Q?OEa8l9W3pXZS2avRcJAicG2dZZVz09zlFk125Qh34INyEiCyUyTsYyJ5rbio?=
 =?us-ascii?Q?kiCKZX72zjq5kLx8j2RGCQTKCJQLcqvMKSaFRsZp47TPfg85sY1ffQK6mKna?=
 =?us-ascii?Q?ivO60kWEIsQzMO/RpEi48enY1ljt3do7ZixWY37Bq7tSdwVcXisZCXE+GxNT?=
 =?us-ascii?Q?KFnV2f0lI9td5yZbpLtO26nBtGIeVWF11A+aXFg0XUcWFHlZZWDEul8Ar8FB?=
 =?us-ascii?Q?kC2PoOOTuq0YN/36wgqDzwSECWL96vJO+mIdyn6kUiXjrPiVow9Y/OeGCa/a?=
 =?us-ascii?Q?njKThAiMlQdlbmC9Is0oewZJnL2Inj6Et0gwMYUdZsEOrBcAfRhYo3u2p/KB?=
 =?us-ascii?Q?QuICjJjCPPKT82/PjwfWBi7ad8BXac7iPz1DvkzkloTKY0or+QJK9dCfV0B3?=
 =?us-ascii?Q?lm/KByjBgnUXIk67ziD8dk+7x07ZWC7lDKdvwsn8IWskiiKJzwMcxD2E/WGb?=
 =?us-ascii?Q?d4iMGt4Fbjsj4veo7U2ez2R7SXK+580ZtJrm3sadHKzxSx1nj0N+bKn0utKQ?=
 =?us-ascii?Q?pQ90JNqJ6vA29nRLbcioEqaYN4HfBKOU3QfKKXjRqwtGSG6ESisa/XajEZIp?=
 =?us-ascii?Q?C8JWP2bnropcI+/VjRl1mTnDH+tkFWgPfPKoLyDR5GjfHPT4mmQU2ztkbiXq?=
 =?us-ascii?Q?/6UYjca4TuQY0vsmNcBRroSGqCBPJK9WnWnVi1VW4ngkjL9XZTRkSm96zHmz?=
 =?us-ascii?Q?N7jj7gKkl/qf0K0HsTwvrSi0Z4OtBH2ZE51UsANlFJ/3z82KlmDLKvNa3wyO?=
 =?us-ascii?Q?ZVqs0ZoRl7RPKEUJdIs1KK+u/8oxLXLyJvUKKNmRFeuNAw1W0h0/hnE2ZYw3?=
 =?us-ascii?Q?zA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5Rw9wingBBOjTtz9xk4Z5ytu6h5Myprwyq27PV2xMtSmARTRIS4C5js7O/KcRWwHZ5xAQt8f2069ydrjo/8HrEcYZPEdo+jT66VMv9bGsjDy5ptPRb823DhY1LWazh0WxbXLbPIw730NG5NoH1R5ul6yba7gLoZDHvC9Y1VzK6mWPYzY2ucXgKqr406usiSs5nJ6nK2L6q1GtmCXIKOUEgY0Stw3+WWIajb6jC1pCdHyuHpuAVSuMIKvZ0ck/yMq7+YBZdfdYz4NxMjtb5xsDbXISyD4nEsHttl/Yp5reICyiUGdgz9SUUwHMYUkTr7r3aW/ShQLOVnAFFb55I1morSiDyxTKJsioWtisHvdgPlgL17aD6TiDJ0F/m2tUdFA+GEF7h9IBQHdb4QopYD45cUBnMeOuhii4UZD9OhwPQNynZ41wOTimgmqcnDOlYENBLQx5CHow928yz+Xu8Y/baxWTYKoP59NXbbB+OmcYwXA7jC1LIDVu7HIUc5wLSZqngIn0oJhlCHNohhy0VzUSG0tLjqLQSx4MejC6er0m2dPl0gy6Svh1XQhPdos9zt4413BEe9J6PUoden7VTAhb2UYBVQNrDlKvHloiTZWHjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 515aa44a-6832-4a15-c3b9-08ddbfc67e2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:28:59.8816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z10eC8XuyPKlrG8p4EMpS4DFOGW+0qPbxiIq8X/HAS+VlXUSSZvwvrmvtz5Y8tqBnNCIYAudpMnStEqlw1BwhGKM6E3D/eAUs/aHtk2KlHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6961
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100133
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fdc3f b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KRidTj7scGcSAcm3CicA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzMyBTYWx0ZWRfX2H+Heq4niV6p 4f3K6JBew7NelnJF40tvy3G4Zzb8Q0hijfKWGJSuBZ6WGQp0fWp0Kxf3nl6jA3ITCEuE5LNRcEH CJOyI5jr3h62o5QobhBwtBH8yG6jA2vyb1fCXCTHJVkMJXMWkdoYEAirejGYBsJJAzyKCs9RyN5
 qQDlv+zU33UnDF8qYHZu45W/syh8FxM8VL+9I87W1Y3Phn8quir7MfeY7VSb7Rudwz2IpNgo3c+ F/6dRvtyPnIo8zBn26ZROtJEAfX28qIrS7GWjeRMCi4C3Q/80/U5u9kb6sxHGCCJvPXxXrZ0y5G gJzX2dSHC1LRT3/b+JoiqQNuRuV2QL9hTw6Xw7MHgPcjLQrrWvMtLTiB2A0RbI1qoiJawVxW1+n
 irft48+UMyybFkDPvkGVtG5gkn3JOxXwoYWBAKGup09tnuVX0aWCH5D4o1tULKyhT8yVenC5
X-Proofpoint-ORIG-GUID: u0C4hii0g_tHTffJTXgb7UxLPbV7Hx6e
X-Proofpoint-GUID: u0C4hii0g_tHTffJTXgb7UxLPbV7Hx6e

On Thu, Jul 10, 2025 at 03:49:09PM +0200, Vlastimil Babka wrote:
> On 7/7/25 07:27, Lorenzo Stoakes wrote:
> > Separate out the uffd bits so it clear's what's happening.
> >
> > Don't bother setting vrm->mmap_locked after unlocking, because after this
> > we are done anyway.
> >
> > The only time we drop the mmap lock is on VMA shrink, at which point
> > vrm->new_len will be < vrm->old_len and the operation will not be performed
> > anyway, so move this code out of the if (vrm->mmap_locked) block.
> >
> > All addresses returned by mremap() are page-aligned, so the
> > offset_in_page() check on ret seems only to be incorrectly trying to detect
>
> "incorrectly" to me implies there's a bug. But AFAIU there's not, so maybe
> e.g. "inappropriately"?
>
> > whether an error occurred - explicitly check for this.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks! :)

>
> Just a nit:
>
> > ---
> >  mm/mremap.c | 22 +++++++++++++---------
> >  1 file changed, 13 insertions(+), 9 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 60eb0ac8634b..660bdb75e2f9 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -1729,6 +1729,15 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
> >  	return 0;
> >  }
> >
> > +static void notify_uffd(struct vma_remap_struct *vrm, unsigned long ret)
>
> "ret" not "res"? :) Or actually why not name it for what it is,
> mremap_userfaultfd_complete() names the parameter "to". Maybe to_addr or
> new_addr?

Later in the series we eliminate this as you've seen, but still worth fixign up
I think, will do on respin!

>
> > +{
> > +	struct mm_struct *mm = current->mm;
> > +
> > +	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
> > +	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
> > +	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
> > +}
> > +
> >  static unsigned long do_mremap(struct vma_remap_struct *vrm)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > @@ -1754,18 +1763,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
> >  	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> >
> >  out:
> > -	if (vrm->mmap_locked) {
> > +	if (vrm->mmap_locked)
> >  		mmap_write_unlock(mm);
> > -		vrm->mmap_locked = false;
> > -
> > -		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
> > -			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
> > -	}
> >
> > -	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
> > -	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
> > -	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
> > +	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
> > +		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
> >
> > +	notify_uffd(vrm, res);
> >  	return res;
> >  }
> >
>

