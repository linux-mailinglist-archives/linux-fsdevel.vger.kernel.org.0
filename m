Return-Path: <linux-fsdevel+bounces-24237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB1B93BFCE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 12:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46772B20FE0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECFD198A3D;
	Thu, 25 Jul 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ElfG933G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="coXqPsIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEC196C6C;
	Thu, 25 Jul 2024 10:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721902934; cv=fail; b=KwAQSjBHwTCLl3j0+qj6ZMO9SbsA6m1TrTNjMxNcf5jOVYoFtel4KVC+4GL7hFybWFDHdL5ndI40XC9LruG0lddtRHQ+E6hiT3+nkUUW6Gv+4tcdvNe8tVbbPat6f6cimrwx2zsETN27Gt+v13XD4cIJoU2xtSwXASI3q7FnAHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721902934; c=relaxed/simple;
	bh=Y6BRJqyYG+2nGEDxj4zfGsw21aJHqPARYtCshfs5HZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=d3bzU/ZAlQ/JwOgvv2AW5/xhTe5dZ68D8IyzJc9ndtfScN8N3Ggu9ju8JOG0KpKXK7gHXk7jSm7XGAtJ+Ca/PybKvdd6fRo1dWcMII0sPu154lfVS+Dw/KBtMjuyEM52PDT4q7xN+Rm6C8rMRWWIxXmM5q6RTpoxCY98U4spe+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ElfG933G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=coXqPsIC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46P8fTGO009561;
	Thu, 25 Jul 2024 10:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Y6BRJqyYG+2nGED
	xj4zfGsw21aJHqPARYtCshfs5HZg=; b=ElfG933GafP+eUE1be6B3TNee1h8OiM
	OHTh1uX8+5Pf817sIZGKTFs94M5LS3cs9WLB85tYWCUyuGeIWAateOJUh9PQEQcI
	j2Kbyu/T5mg4Wne1BBGh7yarmar4SaiW4ifLCBvQXNmnB9d/n8+uBP4Jozg1JP1s
	UQ8Vdar4Cam1S+7hTBI/T++qJIJMSIPPnkasSEBvX/yA82EROquB5Bd4tskqNZsm
	2ZHuiPsPmR5tHf0Ft5YCcg+D5tcqbQGzZr+GMIfb6vaFv/OMG3iHQwcrKGpyyEkd
	tmof3g+itFOIKulJ233WgFBWMXlh8XL0NV0FnYN1SNaRRRKAhvVAPpA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkr2xka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 10:20:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46P99Jnj010876;
	Thu, 25 Jul 2024 10:20:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h2828wgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jul 2024 10:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGwUUgGEUu/WzIsIBlYxkBxZbUpTKq+K2PqkDZ9Yp9KQxrph2MAhE1DTTP+WIGAIIAyTgna0qU8cFfNWkk2adWGWXFcQDFtHOSrXLQ/V3gX+nHsG7iAM3OAPaaEKT5VMx55+tQsBNdQ82FLF/980EWSS75aBtoqxKh1sND0f2gSOzEzZ+Yn5Q6abggxEtMEbAGmeGgZB0nJurASSW5H2hw6vf7S4CL9nv45+6yCGAVgrVu1vIKyiI93fcYpKDY1j9yx5zCcYqBkaCIy1mOFPoJpCADSkumd89RaQh30fS39BhIzcz89VnYCpryjRrZNviKxZKy7ajJDm64194jRfKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y6BRJqyYG+2nGEDxj4zfGsw21aJHqPARYtCshfs5HZg=;
 b=AKCRPSjWivKBe7MResaxSKBiq/wLpMnDGghH9sVlBXzotw4PQqIqJRDTINiUlFv5hhH7vRbN9ND0dleTeXtk8Q0j7SmcBkXttkU9TtVvjm6+VBPPMYxw4u9Ly5D2ek3Whc3/7f0TxNr+elMrPOecWcMoPaP0QkeHzhPc7rXAk53JGVGwRK67mrpkPonwTTiVjnAoY4cLgbsDU9tAuYr2O3XLxkGCET//MNW84azBpxYh24cAcsX7o2pviNjGvCsX6U+RYvkTJ3BbR2Hj6m8tY+6y6IrUvq7NuaQ0qk19x0782apPvoStxeP/kony1xK8IzPY21N2dlPa/egPEMYmRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y6BRJqyYG+2nGEDxj4zfGsw21aJHqPARYtCshfs5HZg=;
 b=coXqPsICN9Ul+S/8g+mDlc3x8VVbf/bTc2D7GC71iNyDeFmS3AJkaQVDz3duZr0UOL4d/wPbgsmRjRu6FnWgMIxkEzbdjB1ejiy+FH7CrncArmXwz5H5Y/6T46L68756AezDZ+12d+Jz4GnUB4aMX1tTkK1VgDxPytx8P7plQKU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH8PR10MB6671.namprd10.prod.outlook.com (2603:10b6:510:217::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Thu, 25 Jul
 2024 10:20:31 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.017; Thu, 25 Jul 2024
 10:20:30 +0000
Date: Thu, 25 Jul 2024 11:20:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v3 6/7] tools: separate out shared radix-tree components
Message-ID: <7aae7eb2-6170-4ed6-bee5-6a0c35294381@lucifer.local>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
 <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5905fa6f25b159a156a5a6a87c5b1ac25568c5b.1721648367.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO4P123CA0160.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::21) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH8PR10MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa846e7-49e4-42f0-fb92-08dcac936963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?64nVpSB3SfVYWf+gHrUjEiOvECP22QpBWAlFaGWQ436QBrc9TEBtdqEE7I33?=
 =?us-ascii?Q?RBR87cOqDItEYaBgognxiq/OFPAIiAGbfYDz4DK+ENj3r59KdsHkYasS6O5q?=
 =?us-ascii?Q?jVB8LOiAECettgY9B+vvxW8Rylk39Sag2mVRTxMrSCKn80Oxoh9AIDoYg8t9?=
 =?us-ascii?Q?hIYycIufresNcPKjIF776U1TV+KTFWutuXce0Al26oJ282DjJ7hrDRkVRMuD?=
 =?us-ascii?Q?G8dz/EgZPIrEKcTzdXlw9Z3GB7iB6KEjZx19eRF+TRMck6+Hbbk0HgUrYdVw?=
 =?us-ascii?Q?CLCSyRr+vbFVpT3a0n+QPqabsjz2qNwj7Icz+ApkVs0/Bfy6iMY6fG1CEgNc?=
 =?us-ascii?Q?nvPsP51r8h0L9V6JqtzK0K2+ZPOyqaCBcXV66mc0aYMrtI6pDqC8sZzr/Imn?=
 =?us-ascii?Q?AhYnhZI1qLIOLQE35qKlmdk16RLGaa6Y7S+u57UXcG/45jxfJLRCWoGXK5xr?=
 =?us-ascii?Q?cjmv020FyZXC7+D3ZTedupAsEP5hhY1xkyobGiRmoc2WFxfqM5gK3qw/XUZ1?=
 =?us-ascii?Q?ZgXrDFEfXJQvFkLkg1Dy8X6z60PNm2RFZoEXiingEEHWRPzUzUDhLhezXNM7?=
 =?us-ascii?Q?cIxAIn+EnS6Kt3uMil9dyODHQMiC2FBCN+wsj5VhQ1O8sD3XqMN6nXjM4HWV?=
 =?us-ascii?Q?Dcnzn7V3pJANXlW/b1KcuOTd/E9EHgVkMmyBCA7Ma3bi5V4Esw9Dq5UfyYTw?=
 =?us-ascii?Q?oU8MlmuQ/APOiST8B3LM/heDzQcvQBKOFnx3A/5L9mfBM5n4m3e+KsRRHVI3?=
 =?us-ascii?Q?Qkg2JNKrhkE0oRX82aVaqwl8sz2ICXWRQcTSX54suFDDIflI/Pmr8GXBiaXO?=
 =?us-ascii?Q?K45eS5fQuLZZHloOdXGyRAql0bqBZmC061McO7JLO2P4M47anNnuvLfh8cxR?=
 =?us-ascii?Q?Ttn4mye/+2QHlHa6+JoBli6REXiYIFdEFZufzU41WxOEpZUv9U1aXSssMsB7?=
 =?us-ascii?Q?/kECwR1/UbG03UrCS+zRLqHVWJGdMeU3bcA14kb/nQ4yjfo6i1UnNSh6GlBk?=
 =?us-ascii?Q?LvaExKzqtkncT4sqeL5oG6HJcX6iYmHgCKRetpx/sBgeDwpWxc6R6QpPHrO5?=
 =?us-ascii?Q?XZymx6H0KkQe4yPs9H2qT805u7x5c7kB40576sVxBZwhii8KUeFJxJt19//l?=
 =?us-ascii?Q?OwaGhJji2k7OlS/Ab9CtWWMliPH8T1QFPLdlz9iCDFgiQrntu6Fz1+RTgTN0?=
 =?us-ascii?Q?PWkPQBvDjlON8dSwKC+5wC6YEal3hTpSZbDPVMHQ/MxTlDaH9rdhGume/22M?=
 =?us-ascii?Q?pdVS4MTnRlCCXwvFXMafGLzizlSO3AZRo1dXgvMNtDn0Fn50GDO/iLq3mlp+?=
 =?us-ascii?Q?r9h1ATqPTO+dmzew9CKjwGfNWeLru3iNStCgZ2ApAHsRFQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p6ew8dhZj9LE7xHriJYRfut3JqDRlGgWm1nrnCDlflTA2onvglC7v87h4T4e?=
 =?us-ascii?Q?jjr9up2i0p0Y5fymXNqDrtX/BlkOxGut5cbqpjrmKNPK3Dc2bZ4WbL5FngUG?=
 =?us-ascii?Q?lWXpvUwgBQbOyIuwzLXER2fHDe+jJ18xnMslOd3AMoRnBc34cjtc/g53vPK4?=
 =?us-ascii?Q?RiBMDjQ9ZdngK4awokeIcP7/wMNAkXniZzQq8eeXH3FqBbDPN6xubAZrlrgo?=
 =?us-ascii?Q?FjsbXFEwibo4LM5MwknhaC8R/PN4V3hwH02p07FxaPABXDQmmPr7FBH4ZASA?=
 =?us-ascii?Q?I0Lieg/5gA2OgyiFnX9a7nn233jt4J/PMwd+EH5P8M0lAuqcpzy7mMgWPj4a?=
 =?us-ascii?Q?nVSiahLNsj41LlxXRKDSbtKFaEMZgnYd7mTyCtEBMMaXQAWUqP8UrmeKyJ5M?=
 =?us-ascii?Q?AX34fR0bOCOtYTfjPtrGb1cBEbibk99EbNys4XnTe8flrE9P1UlMvAqk633a?=
 =?us-ascii?Q?HxbTzJXCvT83XTdxwE1ycMLSWsaFiHKQKtnZjeuAOpTRC6/MxiGkDJRThD5z?=
 =?us-ascii?Q?rDJup5O/jXe0IYEnn+pYrBLbyWyhh2CO21D3honuSKaXVvDrAfC6atrseU2J?=
 =?us-ascii?Q?vp1tomHalEQqBJxEdDFIVhOBGQJMZ7VEVfNAj1RBAWrohKUZy47kFWJKhbQQ?=
 =?us-ascii?Q?S0pBMek7pmDp9XKvSfyZWguf5FtAQHNtjlTJ7M0FNCWz83n7+nEB8XwkO1eM?=
 =?us-ascii?Q?m9gJjf1t3g9fSQwIPr8+4DPm1zOEg6zWzAfp3lsSC9N3CstN89Vx+6F2fyDM?=
 =?us-ascii?Q?wh0nJrjjNCmB5/pyDmNopr8XRcdPzJWFk1VV8iPFxGhwzHmQ0eFHVGsqaN2e?=
 =?us-ascii?Q?IfM5uXNdSqGLeCZQpcHoYUJvO5R5KauUBcAAlPY55G4AZscJdfuqd7bMFF/Z?=
 =?us-ascii?Q?jzafpNbAiKHKjCCU4L9jY9xR64o/FIgleO7S+Ht6HTP7nar2iRNSzAIWwLVC?=
 =?us-ascii?Q?vDG1TXj5wB8W5zHE6f37W0F1kQJT74bgmkX/+O+7xdzt1kcehPoFnLVCKbgz?=
 =?us-ascii?Q?/7Li85nJ4Z+EqiQQd00iVuivcyQFmQYddMGhCjSlxbvrHGTsk8xR05oaU8Tu?=
 =?us-ascii?Q?HdGDzQfUCB76QW9FLl/aGxHMG1urb9H8jcNcPiHEOEUPvWCUq0ktJA92gfRg?=
 =?us-ascii?Q?JbNwwBDewk4/G5iG+e13VZIHqM1tkZCWCyv/Tm9+iGN0Wt3MJXtUdRKpn3cT?=
 =?us-ascii?Q?mCHqzwSPd61eG9kwYc7NRH5O7hxgSxO8QPEDIW0qQVCWEwg0Vr9WDVebSdl8?=
 =?us-ascii?Q?+Kj/4YTk8nHeEHkxV7dxdXjtg5hOjzDdyNmLbZm9IzCy5PC1mAzPSuhAwIJT?=
 =?us-ascii?Q?hvM/chv4KQKBeiKpSqlv3il2kmrn/Nne71usMxfoGFdoQlO0uWu65uD4RqzW?=
 =?us-ascii?Q?WsHGHyoJ6XGGeaU4ZI8xNbjMbo+EG0s/s8ZtuISrE9FoQvRyx77d+YofVcAm?=
 =?us-ascii?Q?0f3uAa+Z7JT3jgisfebyzKJvlBEqZLaWsH2/Pr29DYRh5e8J0rR6sTDbUnqI?=
 =?us-ascii?Q?hm1i3gqVWjWZxGKRLz+4i1CDEDgjYLzzyoSxkoiV3JWiJNwPw6m9YUS6GaL2?=
 =?us-ascii?Q?wNsMmUZb6p9ZnFDT/g0eSK2LhyUYlcjcmIINZXCkuQAT7yd55oAjXhPQ3vPe?=
 =?us-ascii?Q?+wjj4YW5J8JKE5fdMz1ZnLc3FFxIfkUIQCP/Z7tGPdX1yJywTRnDdlvUque/?=
 =?us-ascii?Q?YgfeIQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ukuXLjEIvcaUgO5abtTAND4UVVzeGFkQxhgAvGsvN1OIdxMnfZ0DvAF5qSg2IA0RbUOREG38hNxj9Ral/RtBoTCoN7bc1/iF0jmLsqyt02GPDTRgrUA4lELTcWT7gGXYVp9/sDwXz/YMJb9+R7tkPN0IihVT26ClMDOBv7mPXdn2JroCtBbjMvDrjwfmxiZRa6EEGpGwnNLeaUbxaYVwRFuElh2Jx9bxA7dyb0oB8BTEVCyzaUNY/kpy4D1APBpRDMHz8rvr4ywhHegLJnjSXWmPIuEc8sd8VWLP3MuYARvgKHiW7fheCTJCe/XvbX0R8G2ib6oi+ZTXS1EDPbqDi3MFVwU42ZG03+Tfc7nTOiEdPae+N6akaeRqc+C5+un40+A9+RXwPaoo7BnWq+LK0TJgFWsvAuIlt0101cvhL0zE1S9+OyV9MPSJZkDJKuM6fh+/EjFXuDnXaXk7qXQM6cRMZf4wqu+EDPF2MtqsEmnFZxu1r7b2UPeLg9s4gDM6T8ZrCKYxylFB8suoT0W/4e8sxHtmsaStmfrwtEq/eh67Xm92RqT8TLNi7Pc8KXh8yiNnM8w2icYcCXuvoaTng6B1Kccv32u+PtocpSTrzQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa846e7-49e4-42f0-fb92-08dcac936963
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 10:20:30.8997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhmfSFoCcMftNVgkNKVR77sUJjhlLotcSd5vdzZ/MU+jtZG5hF4xw/sBFI9HdB0TgetbN12fA74PYPg98wwYsBVUKmk6wEXycN0OFLss1Do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6671
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-25_10,2024-07-25_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407250069
X-Proofpoint-ORIG-GUID: c7Ffrq4CMOEJt8TP-0Ie1x8qXPV6wswL
X-Proofpoint-GUID: c7Ffrq4CMOEJt8TP-0Ie1x8qXPV6wswL

On Mon, Jul 22, 2024 at 12:50:24PM GMT, Lorenzo Stoakes wrote:
> The core components contained within the radix-tree tests which provide
> shims for kernel headers and access to the maple tree are useful for
> testing other things, so separate them out and make the radix tree tests
> dependent on the shared components.
>
> This lays the groundwork for us to add VMA tests of the newly introduced
> vma.c file.
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

[snip]

Andrew - we double-include a header, it has header guards so this has no impact, but
obviously should be fixed for neatness.

----8<----
from 1bbb39c83aaee80b32d7ab0f26caff0def2dd969 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Thu, 25 Jul 2024 10:47:40 +0100
Subject: [PATCH] tools: fix double header include

We already imported the stubbed-out linux/types.h. This has no impact as it
has a header guards but let's clean this up.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/shared/shared.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/shared/shared.h b/tools/testing/shared/shared.h
index 495602e60b65..f08f683812ad 100644
--- a/tools/testing/shared/shared.h
+++ b/tools/testing/shared/shared.h
@@ -6,7 +6,6 @@
 #include <linux/bitops.h>

 #include <linux/gfp.h>
-#include <linux/types.h>
 #include <linux/rcupdate.h>

 #ifndef module_init
--
2.45.2

