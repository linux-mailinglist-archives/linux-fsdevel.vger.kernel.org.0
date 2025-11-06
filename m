Return-Path: <linux-fsdevel+bounces-67318-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C630C3B8DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 15:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1320188E429
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 14:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D3F339718;
	Thu,  6 Nov 2025 14:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSIyBflE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b0XFPw0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232C303CAC;
	Thu,  6 Nov 2025 14:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762437860; cv=fail; b=R4k9uVE6fQa6/zWZLP1BrmHi9gdQxAv/FIrfvHrf0lH2M055URyrG1v5g1Byj08cLETqnwaHgrHLKhCwPI8e3vUZtgnEyawhkH7l+lmtKpWb5rz5A46otkz3tARYPSilgT044XhV5ksqOZRkA3o7AJAnMB2CErpcSMcdD2K9UAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762437860; c=relaxed/simple;
	bh=NHtKwTw0Q5p1wpeI5QR9OEKaxx1zNqUYL44w1LTC5ts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=INfJYEJfE32YgKNGzmY6fKZ8vLSK6wyYf+7AvCJlL1FJdfU9KYgcGTLQhQZLZcMw55QfMcLqDSn4+H7VFQj0ssUQltyKUN3nun2PE4MIJLQ3wtS9iFLkgbjOj/qKfyV4tNatyToieNrOqKiy9gjxR65GCI0mXkK2BjerWme0liE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZSIyBflE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b0XFPw0k; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6B9T6r000639;
	Thu, 6 Nov 2025 14:03:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=AB+uvM38F3WUKTztYZ
	y8k0ikCXUiNsQ8Bjj8dTh3AZ8=; b=ZSIyBflEgHcG98HskYAYsE0zHt8inysjjQ
	BjLUoiqeJasbDXJOjuzCSJ6TN4fKT9IsA7JntOtv+tjujKJdJT1nUHbPNJp5B72a
	WKz0zoB5DKLmCacV92oa5B5mom7qSwquAYewFr4Ywz7g31LQJSMMbNAbX/knGk//
	XXKzbgWFCMQ9csykJXgVGfg4VyDYGMRXE59PzniFblToLmMZ2l3SGSV2jkwDYNC2
	KC7K0kmcrTNvPYMzKgfA3+gW8a/Vb4BOSYVP3KqyPy5ugpfakZqylCf2/xGlT08L
	wIyKfDVpTaDRjS5bSJUgbBkeRrcsFFGJBAOWyuoSvLi2OjZ1PNcg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8at922ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:03:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6C3Ka4039430;
	Thu, 6 Nov 2025 14:03:57 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010065.outbound.protection.outlook.com [52.101.61.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nc6a0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 14:03:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dffIaS+Kk+D718in4URZvi53ifusqdDaw1odxUpxmpxb+MQSo+26ajKd7C6UPXQjxN01AGl8KgzsAiRkSsB9ytOvGqjZFBA/BFrcOr2Fqr0E0utFqEpymm1rHT6v1RvPQtCWMA1lIxcQiFaYLWgI9roCWYSRom/lN136xUZjuoSx4QCdFHOB3Fhveu9fzuDqV5UQR8wwxGXuiUB2IiUDupwOk5O9NAyCtJnggL9/wprnugCHRBWF5teNKF2br+zclavcWiCDNLggcLSSznhiVUT9vA+yqcsDTizsiVz927iTj1k/fyOF8UUl+ghnKj+C0nZo77NA9IL46oZ5bTl5kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AB+uvM38F3WUKTztYZy8k0ikCXUiNsQ8Bjj8dTh3AZ8=;
 b=j5XOlfErd6S0TA6jYv4XloAPxrsek5QB8WQ/wUZ5u4n8kikDRVbsrC5rZEAapsoX7EhSuqnD7TVFoYXW5pVVlcOJPhE5PISZmeUUeHpJC2LMARRGmZ2NdyXuuve6W/iheFODOSaYne1lqOi92JPslE2roiSAWhnQ2zIkrYOk+vmhlHDK1R5FRu+XgUtjYSCVTonkXoE0WYVc/OHyrD+2KvTHyIsTzMlWwV7qZTM9rwMgeg9GxNCYqsAtsVb0RS20mXT1Wvd0TvbRSvYk8zBFelXum2GB+b73RAZrcbhgIZvNGMKKiFDih1V2Ln76m++MSBvF1bD0+Ec27ZjdztjrgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AB+uvM38F3WUKTztYZy8k0ikCXUiNsQ8Bjj8dTh3AZ8=;
 b=b0XFPw0k+CLyuE0l6jdc+DXUu6Xo+PpMux7Xni6/kfv/eQz2trxzk8mgbSrT9dh6UWD/7MZiRHB6zwoA1pCCR2Wt63HpJyOITZiYsxuHCIDjp/vaJMYpwz2VLCi3iBliA6Oyikh9eW9pkCLKC7N8eDLamu4ZQ5TxCHQfH2aVy58=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6761.namprd10.prod.outlook.com (2603:10b6:610:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 14:03:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Thu, 6 Nov 2025
 14:03:54 +0000
Date: Thu, 6 Nov 2025 14:03:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH v2 2/5] mm: add atomic VMA flags, use VM_MAYBE_GUARD as
 such
Message-ID: <4822cf8d-a871-4e8d-99cd-bb31463149fa@lucifer.local>
References: <cover.1762422915.git.lorenzo.stoakes@oracle.com>
 <94935cf140e3279c234b39e0d976c4718c547c73.1762422915.git.lorenzo.stoakes@oracle.com>
 <c68fe71a-d46b-4fe0-a2ce-57f443a43499@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c68fe71a-d46b-4fe0-a2ce-57f443a43499@suse.cz>
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6761:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1e64f6-8adf-4d3c-90e3-08de1d3d5243
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qjwMqSF4GuUMMcZOAbfQrX4D9p8A+2A9HU6mEQvRZbQSrQtPBf9xsX/7tCoT?=
 =?us-ascii?Q?DfophPzwFL3Z5+OUg2Q1C/zQs7Y0eoQnOIjVw9gEkPst89wzm01XdkqCeuin?=
 =?us-ascii?Q?38N8hWZZSapGPp8Dd5ww8l54RQw1RpaQdZmwBTSDdo/hMb8XiFuyzQtsbhdz?=
 =?us-ascii?Q?/K3tnEex77jDi0ByZTvn7k5+m0mc0+LoeBowEK+vGSelShSTAxH8p/g9J/CA?=
 =?us-ascii?Q?WCPf1WqvAVaQH7+jszdZ+2MlHCqSjh3Etaz2dXUlIhf2bCWpSIqaojJOgIJo?=
 =?us-ascii?Q?40fwjXLSLJOAVMhjJ5mKVbb0tm1orUrOgDprofxVAcvlZ9sGjZZjBDlmqCtj?=
 =?us-ascii?Q?JaK392rBPhKhqmJUp2xWbnDjR++0UcRCu8CeEkBQMBD1T4XcOn9bQnQ4aeUJ?=
 =?us-ascii?Q?v6MFiQMPcl8UMU+xRZBEzNfolzLJwKKwtDkm7iMXkTe+3lCI2hPDwa2eZEb1?=
 =?us-ascii?Q?RJ5ED3U0tl/dsCFbFAd34dGyd6Bcj779euyq+Z3IA/B8JA4jg8KpcfDLUQS+?=
 =?us-ascii?Q?zFURD5s5mrK5Tnm16D0eNX2SSnxnh33Ii9CwQ0aQp/ac71rT9dzXpaZ8uY9n?=
 =?us-ascii?Q?wpmRSniAI1V0piZpiUSGFEtzb6KXEThkU8WW6npDQU8mqFYHHt/5xGp3vIrc?=
 =?us-ascii?Q?y95MajorrB9drm+d7xVbPWf6Wsv9bwBht4jOfcKHvdM6BzXK8nFdHqhPLPT9?=
 =?us-ascii?Q?Zzyuk8Atkc3fLS8kV3UzAPTreBynU8ZPpSN57H36/VqaQjUb0rs7v5YA28Qv?=
 =?us-ascii?Q?mGiWLU8Q/7RD16/jLUkrXnmEbhWl6nsG5uR7lMCROUigCTZLzbFIPOn4CvlF?=
 =?us-ascii?Q?RIXU19sunmCNL+vXCpyf5DF9FsSk4T8ek8YaQrWlH3ateGp1uwXC6eDwy0Z/?=
 =?us-ascii?Q?QPdeIz9A0kWMDQ/7BscPC2FAvwdksQZXX59pY/f0KlXr4giwcCxUlFVeohkj?=
 =?us-ascii?Q?qrlw7LFrQjXlBP/vJkZFg0oGEfkbMsyV/MTk/RClHyeZzy1GbJk/c0kQDo9v?=
 =?us-ascii?Q?WSaNid+GPwn8YIz9CvoWvcJUMORA3WVWJ+BXxAicIukuK/EgE59/btQlgo9n?=
 =?us-ascii?Q?5bjrchMWX3yIwjZFAIoyzF8vZePOAMoy9ACFvZjRnH+144pr0P+YKBSfKubC?=
 =?us-ascii?Q?0MFzx9jiyIsVCvgIt/v46JgvuUI0eon4wZsTdv1aSRzrqSw6OoaWvO6N8SPB?=
 =?us-ascii?Q?XMUpu/yTTA0BuB5sjD3H2hmLdOhba1p49SSGjX1PLjrgu6W2npDBCFrnetrM?=
 =?us-ascii?Q?3ik3rTSRfmainvCNlS2zay2RKUEmpccJFtS5hWxZOZE+FoVTnFepw2xsPDx9?=
 =?us-ascii?Q?Qbnl8QltvBu/HxG9rCjRmvKn8jKSluSPNjKy48iYNh16sAUWBI15f06FSTnS?=
 =?us-ascii?Q?P6NOE49lkMrRGeNN/1xdqdHNEkdnaXt0Bfa3hu/yAkTjx7Nw4rL5ApY8sE/J?=
 =?us-ascii?Q?XQ0AeYHf9U+KZnN5xDoe+B8mvEXr3EQ/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rsk+6pMWCYNDHznpKt1D8RxIJBeSXiEN+Pu1WMP+RkNDP+ePm6dbtOAi+Cej?=
 =?us-ascii?Q?0gcF+rG6FHZmYD3oG/yAbXnZla7rgkNXbEmWanV8ad2pQ9gQ4k8mG9c4/lIj?=
 =?us-ascii?Q?oKEvr7PIHW9c3slIcwgkqZSPvrq9+Ex2ysRR9nY2OxrFD1RWREMqVe1uN9+7?=
 =?us-ascii?Q?evL/n5XXPtt7g+kAOXOHrhX/17ZH9zmyaLOPE4HgrsoXj3DnQ+9avZABZe48?=
 =?us-ascii?Q?UBgDg+3WAcDnSaitg+vKNVS6Dud54uOO5yXvZynGSQb3lDGDxgrSJnTzoDsr?=
 =?us-ascii?Q?Rc1YP50L1rnwL1qyZe1/8Q1zaTtq3mjaZyAveqm7X1NRjQFqSISBryMZaCiQ?=
 =?us-ascii?Q?oy8J3zqpu1IXdmcrPt1XAMVkOklQxH5TsEKx9nw/iGLq3ZBBng0a/Q09k3CE?=
 =?us-ascii?Q?kqMFUPUW99/ZDkNorTpBA8NcCV3XA5dK50XH8lpep1zyYyi2E0MUJGzqZUhc?=
 =?us-ascii?Q?8AHwTGthZ5Pmv36/6sgVdmxjZ0gzE9XL1EwmQ7T8UWzdcShzqnQKQ8qOUOMA?=
 =?us-ascii?Q?rKTjaXLKFLijbnvSIugD7MUvZ8B+bUR/dQh7NCmBd1wivyhrAGxv0kYOKCXe?=
 =?us-ascii?Q?9X5atif0lpAph9UqOSU6msZm0xLhWvZEcTqI4wWcOeJ6oNdQdtnA1rQyjOR5?=
 =?us-ascii?Q?x6l72CwovRP7us132WBfovfr+AFI0b/2YT1OBI2rrmSxK087ZRZmYbQhIdNy?=
 =?us-ascii?Q?BQXKkplSG2N+70mI0VblRhOK9rKUxpfr8VaXHZg/cI/L37r1frT1Mz7BXKBF?=
 =?us-ascii?Q?Afi6KrNbIetoGS3LsMLDGA+1TLlg6bfYgXSmHGlWt1IMA+PGOazMJkn5szrp?=
 =?us-ascii?Q?RGu6VwnZkvzWNHkWHIlnQ3tqbT/f56kNCePjDl2L2PtCH8+kfboIfRolHvf3?=
 =?us-ascii?Q?agVfv7otlI5LWfPSW68YELLsXWz0/84rxZvn7i7qkU9iuYnksZPqe1QsFcnM?=
 =?us-ascii?Q?daRkSb2vilqULc668BydT2fwhG1BioYrGdtIso2KFuBii2VmATeqaHzk8iAf?=
 =?us-ascii?Q?ojMjSD9I0H9PG2sjbQTArFESeKt7TNwbc+N05y6tpCEYip8Y8692mwEXzNdU?=
 =?us-ascii?Q?NkVj5BotyLD7bsjXYx5BMBpqbh3V/JOpNuUR/SjBuBcr0YKGwsn37D4h99MO?=
 =?us-ascii?Q?/VacJYEvKHs83Kd/2fStqmOj6+ZNKKGmbji4uTK4keXDFczkD20sMbIT+/KK?=
 =?us-ascii?Q?JuG2JVuxyhrxqdlgLyqdsKX1wdKBOoYVtLnJ3u/sYXtyi8u5k2dzUSlg8/bO?=
 =?us-ascii?Q?oxIstmDzXFwpaZg5OD2ZExkEGBUT3q+59TS3CnQjd+rmTNeU0uk8m8i2XOLp?=
 =?us-ascii?Q?xHTMzUYdY+HoQ/TXGhiQr+Eg9G1Vg7inyUeES4i5NLWFfflDH7rJAOomLn4g?=
 =?us-ascii?Q?+lsJZxPfikWA0mCqq+LwA4q4fsRCfWgDXVxBycvzG1X6PjE49NOMmT2H1AsD?=
 =?us-ascii?Q?1M/SefXBaR+GeWjS72cXxorV6aZMCTFXJs0DC2rgkOtR2KsvqMUp/7fjcf2l?=
 =?us-ascii?Q?/A+1YC3uGrzvaKspCCb7DQ+CWfCNcmFhtlJHYoQDD7M6ngvioaKu7fvZZ76j?=
 =?us-ascii?Q?DkdTqa0pOicpV6xgjzf5hZvQE6bmSihSyrqAGthSPEGap1DilyLVcuVRfeLe?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gVYRdaJISwu3VXAE4YOlNP/+GHDgrYNnLRQD6o7D3sPrvQYTcZVJpaxtkX5pennVRq76+uuC4wS3qWQ7by8HiFeKLvZ8gjMyACqPcfR33HOTtMmuW8vN54L3yDJZgWyIzjSuuJ43UjpHq8+two+wzTR/uQ2jK0tEloB0ogZFZJGdCUaESAfptWSHpmdAdUyFNJAlCkb/s3LyVWVuKcEAoJwenP1j12UIe4Syau097weQdS3ZTW8w8tpG7vzYerwErFW6aSP1Rxs4hZhboeLSyt+xmLqTh+Pfb89LBi5VzXgar2AYKIp3lDBT64vTWLTmM9rm1OpNIfZne8Z7gYYrdScrFwMAVSaRHOnZrneDaSNIf5k3lxCGDyPH3GD4kn9LzE1sHAG8su5LwnhHL+XI1xTjSI7hXUH/WmpcB6nFZVgx8OYpcPJdJRm3pJpSJplqShN2FUNV8/W1YRRGJXEGCf5qUptIzRZt1WsiJKNSX/39h25kjU87HRPG4d6jt2YZd8dWJOfRARJQJXI4yrh7kj1/Z8jtWS1hThaHwIy66jwVfa/Zz3E9JxISnSKwIvBIR8ft3tBeP9clGeOMMCtDZ2Z5H8O6mvHV++Ser0OdGQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1e64f6-8adf-4d3c-90e3-08de1d3d5243
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 14:03:54.5223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UTIC1dqTwFOPco00ca0tN7wFVtWmWZXudsiCJL20k3C6zZD5FSGolHhkSyISYY+bzwju3wX9/3AzT98kc+UT26H7CFhT8L+/lSSw+iyXG8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060111
X-Authority-Analysis: v=2.4 cv=HPPO14tv c=1 sm=1 tr=0 ts=690caace cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=xjBYunNH0RLHUwQ1JPoA:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: qSZ4kJjd28gHVr5AySX2Ss_yHV1eLpX1
X-Proofpoint-ORIG-GUID: qSZ4kJjd28gHVr5AySX2Ss_yHV1eLpX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzNCBTYWx0ZWRfX/fCDfEp8BUFp
 rAcM/VzN02fduvy2dy9+4ESUtwus0b9PR6tgzVpmB/2l6pclmdHDhFAymj6sJx+X/mBYQR0CJeJ
 uEdr2Wu/ceirH1hDlfzQ9sjFIy0Y4S53ALBsU3Ddi8iU71jqrd40+HbXGRJ9xaxqhMKiKaFZqjz
 PLXB8D2Q73Ay/XtPIfg4dtGkak/JN5jaRQDTpo+9kA7Gr5HJjgVfMthRN5VQldG3xWh1qrEHFhR
 MtR1IcrTvD169sJGb65zuxKyEZG9CnEsZpHfXNV8L+QsjkWUhAQbBuWzcMDU1yUFrebV2wXI6iQ
 BLnoiUvUXzWMPnUH78QoLqK3G998ENWYJrEdETWtOqc+KoNM+FVkDYPby/nXjyJCX8ZhHV87kr4
 fPOvQXPuFV3KG0PXZEg29B4bis/4hQ==

On Thu, Nov 06, 2025 at 12:31:29PM +0100, Vlastimil Babka wrote:
> On 11/6/25 11:46, Lorenzo Stoakes wrote:
> > This patch adds the ability to atomically set VMA flags with only the mmap
> > read/VMA read lock held.
> >
> > As this could be hugely problematic for VMA flags in general given that all
> > other accesses are non-atomic and serialised by the mmap/VMA locks, we
> > implement this with a strict allow-list - that is, only designated flags
> > are allowed to do this.
> >
> > We make VM_MAYBE_GUARD one of these flags, and then set it under the mmap
> > read flag upon guard region installation.
> >
> > The places where this flag is used currently and matter are:
> >
> > * VMA merge - performed under mmap/VMA write lock, therefore excluding
> >   racing writes.
> >
> > * /proc/$pid/smaps - can race the write, however this isn't meaningful as
> >   the flag write is performed at the point of the guard region being
> >   established, and thus an smaps reader can't reasonably expect to avoid
> >   races. Due to atomicity, a reader will observe either the flag being set
> >   or not. Therefore consistency will be maintained.
> >
> > In all other cases the flag being set is irrelevant and atomicity
> > guarantees other flags will be read correctly.
>
> Could we maybe also spell out that we rely on the read mmap/VMA lock to
> exclude with writers that have write lock and then use non-atomic updates to
> update completely different flags than VM_MAYBE_GUARD? Those non-atomic
> updates could cause RMW races when only our side uses an atomic update, but
> the trick is that the read lock excludes with the write lock.

I thought this was implicit, I guess I can spell that out.

>
> > We additionally update madvise_guard_install() to ensure that
> > anon_vma_prepare() is set for anonymous VMAs to maintain consistency with
> > the assumption that any anonymous VMA with page tables will have an
> > anon_vma set, and any with an anon_vma unset will not have page tables
> > established.
>
> Could we more obviously say that we did anon_vma_prepare() unconditionally
> before this patch to trigger the page table copying in fork, but it's not
> needed anymore because fork now checks also VM_MAYBE_GUARD that we're
> setting here. Maybe it would be even more obvious to move that
> vma_needs_copy() hunk from previous patch to this one, but doesn't matter
> that much.

I thought that was covered between the comment, the previous patch and this but
I can spell it out also.

>
> Also we could mention that this patch alone will prevent merging of VMAs in
> some situations, but that's addressed next. I don't think it's such a bisect
> hazard to need reordering or combining changes, just mention perhaps.

A little pedantic but sure :)

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Otherwise LGTM.
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>

Thanks!

