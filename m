Return-Path: <linux-fsdevel+bounces-24433-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D160B93F47E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 13:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C96E1F229A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7731465A0;
	Mon, 29 Jul 2024 11:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BC07gggk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cQJByGXQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4E1448DD;
	Mon, 29 Jul 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722253886; cv=fail; b=S9wY3c2/MPxZFtRipYA77cya6zpxdELOc3slRG5HCwdcv5mhnPnOkoJuOm3+TbCYrQhX7p7B1MyGgIiF7RTuRoSumy1LfZnpRBQiAnI+pqn6jXN3f7nHZ6mo1SC8SN7QpZyWy8Pihz34dDmX76ih26H1RmS3cQ47x83I1zMDUC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722253886; c=relaxed/simple;
	bh=p4h+dW3R+CucWpNkuKSI30/V92nLGygkozcDURGQNwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nD3gamcD3NyOeiGpdUPqjcaHMphuf7ScPxxgipSyC4sVfT1mWc7eXWZOrml1qLktK4/enQ1ML6k2Y1YDzosphY3mG2k8gTQozloNknOAZhMNLt156xR4GHpnaBvIKccANLKhG5wj2o63t2K8V+GfRlI3RP3coaJEkZDgQE2mggE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BC07gggk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cQJByGXQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46T8MaCJ031626;
	Mon, 29 Jul 2024 11:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bCGB4cbvYKZKvzaKlCgplmHcT2xJiVG546dxnLnY9nw=; b=
	BC07gggkSeNaOcQtJrDCFn630YjiQAxqDsGXdkQB7LHsfzcHgSEJl2W6up0sXaqJ
	j+1ukojLATOnr0j5xoVlHA81vppJkGyS89ADQ2UM0ucO1VvLjcRhDW0bBItV6x4G
	avjSBpbIsSRwh1D1Pp6CS8nyYyIZlO2lRxL59Ld9/IqH3cvN9e2p0AtApjTeCjYP
	Ii79CSdjjwTxES4xhPZGK2k8h2ezxyoWj0G0f2oRkECBBjUjiMHESYUUg6ydNYMF
	7soaWM88Kinl1IEuEGMHv24EzoVzhk3MXgZVW1Cn8uCat+kFM/wuXwtrbPp6BLp7
	wbq25+Qf99/2fCG6K+fr4Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqacjcbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46TAf61g010104;
	Mon, 29 Jul 2024 11:51:01 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nrn5q3py-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Jul 2024 11:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAIJes9tWSznYvWEX3QmJLpr8rvGb/e7U4gZawATq67HdGbQksbn27S8j6b2+Mew5m5zZiTOqsQXWIObbOzB2pDGbuB54v3YU6EaLu4KjC80+0KQpj8KgHTTlwDK5DXIygtDip9p4dUC7yc35ErHH9/yOHKAsl/NJXGjKZIEva0cZtIs/UB8hhC2jqp+d8T3o84CN2sOtiAAHP70PLds+iYySllhuHQXQwFC1G0ZPbxWFrB8tX7WSSgA5L1IBjxAexudeUISbRWJpnmXpPNpWdWdK8lFVaS35JmVaRf67mlKtpGJnJvaW8lTpZPFsm++/s704y3H80BiaUMBagpzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCGB4cbvYKZKvzaKlCgplmHcT2xJiVG546dxnLnY9nw=;
 b=Kgwuq+L7Z+3L0NtEQUMSA0RKbgLLMSS2Jm6AYi8hv1iHYfBFUuiWj4EfDMW1Z1EtkfWnnWy1OVOwuNm3onlkmIIAq7bDCqFkFGxis4phOOdwapCx/2bBP0rUdyMg6HScR39qRDbnkNEuvn9Ld57O1jFJFLWVruHRnWF283JeYyIDNduYP1hNhSR/7b0LjEG8XdMpSFEmF16LRynygLpI5k93ZJFA7s0dN2CWYBZbh1Aog4f71j7H0PgIxwYYFVOrjoYkxHW7+nUzQXWSPDHeHlf/LebspjoNvLmoCV5RpriB4YKzHYyUa9Ci2kSNLAUrafqITaj7iEfolTiAreldbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCGB4cbvYKZKvzaKlCgplmHcT2xJiVG546dxnLnY9nw=;
 b=cQJByGXQwywW0BtKJ5L8RssFZVwfcQAM0Rw6tU9hl0huFfbKmVsxmhBA9kr2kUxszfi5DudIJPzK2201wxY5wEkM6KeyE7FtzwXZe76qp+j6nMy3kmF3yOXnq4hFmuvwtQH0gnJh3HfFEy1icsW6OQ/pIL/3Z2l/1hMGl8AAyjI=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB4543.namprd10.prod.outlook.com (2603:10b6:a03:2d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 11:50:59 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 11:50:58 +0000
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
Subject: [PATCH v4 2/7] mm: move vma_modify() and helpers to internal header
Date: Mon, 29 Jul 2024 12:50:36 +0100
Message-ID: <5efde0c6342a8860d5ffc90b415f3989fd8ed0b2.1722251717.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
References: <cover.1722251717.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0229.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB4543:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f214b83-c4bb-467f-6129-08dcafc4b643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2I93gE+4bzVjbBGkjetexkQZ/0ppJ7d7nfXTupN1HcfQqD3kg4bGMl430/hc?=
 =?us-ascii?Q?q91hdHdt07S6vM0KTAyMvNkBvR/KAc2xVk1+pXRhIxMRkZcaJWiJ/82FXDoZ?=
 =?us-ascii?Q?LR+RYLgVquoBp7xKK+YdLA+n2FHZiBVILoOcHJDAI5uLPucaifOVNRObBRS7?=
 =?us-ascii?Q?wRq04JlVmtkgx5m2LNG8CvkUtUWuwShJ8ZqixexNVf5KXM6l/L9aiqOyGd0o?=
 =?us-ascii?Q?+pSakO9j0s8cUKbjV2bN8FAufmq+keHTOwy+zMhjxX2lInQ0eynlJmI3kd9C?=
 =?us-ascii?Q?8L47HCFEYeYvPo7mtvx1Xmrljwzv0iEBIEueNzUyjVHYT8h8+NcUYrr9wivj?=
 =?us-ascii?Q?LHDIZOnmKpjZHb74a7IDPSjPwwjRB8BR66hbii2uyAoeQ/CbvuV6nXJ1GWnK?=
 =?us-ascii?Q?8omDovxJQeyzJHSRwkFrZ/NY0VUP4RMwRD85bEAfWbX5AhiDfF8PrCj5C4UD?=
 =?us-ascii?Q?XEtRL1MU0no7OAwfabeNFOJ7z/PIcxec75rikFtKvXRJQejUj4FMUFEIrkCH?=
 =?us-ascii?Q?XtXm/iyx2Rjk+lI2yJx6HxzfaF7S79pHlKlZ5jJyG1LJdqPvQ97Nvryukk+5?=
 =?us-ascii?Q?fmE1wXzM0olF7m7mFJ0xJzbbULHXjriIQZVBHP4MdjFxb9A8L3zgy/KKMe9w?=
 =?us-ascii?Q?dWGE9fEMN5SBeqf8RucZu0igl2piblfBeUn/YwtJoiXRAgJ/WWVhWinp/VwU?=
 =?us-ascii?Q?3hU2ykRWmZu9QCuTd3H36DPBxP5S/IqXXdiirF3M/F3udcy0ghxVl/mXCCcC?=
 =?us-ascii?Q?H6evd/dMbRuNB1JiF0TcY/u+MQQaftMp8luVHfk1ud1wuRhxxFU983GhD8fB?=
 =?us-ascii?Q?BOtw3GFNeBkMLI68qTxKP9inu6xfnJDuAgZFRh8uOz0y//gNEYL4G9GgCufB?=
 =?us-ascii?Q?t9HPVIXq6oKvfV0FEpTwT0Z5drBWlFXMiLO6wp6+/pZC6jTRZkCX8Z7Rdwnu?=
 =?us-ascii?Q?BXxECTG+pzbB77D1x94y90XLsf/vc1/tXbtnpEOcPCjMDdE4vpEXHWtKlNTk?=
 =?us-ascii?Q?P2tGaZ/oJULnE+1qhZUkHlx4GDrp4orR0yVPhCuzB7PfAlMX7rZxbKCLWL8i?=
 =?us-ascii?Q?zud3mkvtYN0UoNXJAgwr6KoOjVEBZXoxzrtxBLrvjFRVlEtee7CQI73/x9Hf?=
 =?us-ascii?Q?Wzi9BHEBRG7QcEVjCXm/xPF7KlFJuMbBQGjAr1rPEgL7xlAH4FKC3me3SzEI?=
 =?us-ascii?Q?SSgCBt4ZALJomJncKJVRIr9JCavHEaxLLCK/JtnN2LTg2O5PtElGAMtmJaXv?=
 =?us-ascii?Q?7sZFlGQaasANJxrmp5ZVYaDCVTxgNir7GEEIgcQJ2O7xlaTfKilecwyBAfr2?=
 =?us-ascii?Q?6l9wiAQ1r+2LNCvSQ7G5/Js6te3uRcEvoaX/9XkfZBmEBQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sDwiEhhzwRn9307MhA7R2Nnq8JxfXJqSkqsnfBIk/06uUVXfSLoQgGG/j61j?=
 =?us-ascii?Q?jAmEUi2Z+fgWqPg2lzBAXVz/TLkrrPTTeBIi2e+iiHzCHqNhDzg5mtixyDTW?=
 =?us-ascii?Q?uN765oukdh5fGn44cOEJSgBj5OXsCXhSNTj0cug013TG3Nhq/nOeBHA96yZ/?=
 =?us-ascii?Q?x4WFdaPLfEXnH1ulL96KB5ssOO76XfR5Zix0fn8XSatWxMR49VwrBgNHts8S?=
 =?us-ascii?Q?wamSrGEhyvrgK9FWIdU/fUZgFesA5jVdA9BW5HHZVnh9twXVTZnlfuEDrLqU?=
 =?us-ascii?Q?QjlMJ97dFIoYnghBn1cmdNe4aNMpkW3tueyjW1cXDNHiwDuNU791ttf7X198?=
 =?us-ascii?Q?TtA2HjSsZTr8f2ahD2YCZTfDadTqLkJ/w0+/xm+Iyydw9Cjrg9dJSqOpmp+x?=
 =?us-ascii?Q?nNuxyGLjKSkVrwIP4XnqL97o5MnNBYHAnildCPgDHUv3mV1j/isHEWE2qF+T?=
 =?us-ascii?Q?BKC0TKbo7ykxQJIo6n5RK4hn7drwQA5E6z8KFl5h/yl0SLOl1U07y4NutYDA?=
 =?us-ascii?Q?i54gH2BAJzjk9Ej4QrfJyZHGK2MdR/iPsHG1U93XoPSsOp3SBa3bpCWxYlC9?=
 =?us-ascii?Q?jmxbVMtRMmc3JGqDr0BfZ3cuZtJCE5V2OuPA4Q2iSlj2uNQDzvxMPTpiwKsT?=
 =?us-ascii?Q?iz3UTrumv+1eFMC6+6Lbd0U3sFBKsEzJllkz4lQ+7CHmG3Gqdh06MzoNjD/K?=
 =?us-ascii?Q?tpT1VgBA0dlYFLs/potCR/FcSgP76uHyPgtkvMMBJ7FKZHuhXvJJFUP9Xd7j?=
 =?us-ascii?Q?QuB/OPUa0jbAIodk85k1laGCeI3nBVAhJ67qamzLkc63vHzEvKFoaKT0jNR6?=
 =?us-ascii?Q?6s/KFdJt5mghLU/oIuy9JX4Z+j6Xzq1Y6eyZgUvHvWi6jnozO1vn+cVe9OQW?=
 =?us-ascii?Q?Y+aQ0Qx4+IYRG7V2bgoaXg/xia90fK6G5Qa4/4s1TePc/u3qdUyNSGhDGM3m?=
 =?us-ascii?Q?VbHqRswyijuniryqNZamm6wRNrci5c88NcbCuKiGIA/nTKL49U+b2DO/xza5?=
 =?us-ascii?Q?FptE2jBmFRHu/mMzaCRzYRW02Y7i2J5KVeloOyA2jwvRhxQYgyTZSVubZwAH?=
 =?us-ascii?Q?4sLjFYiykzGH/vqqoWZSVegO6R0f68eecpmtxgUuEHj307hr7LjebbSq0DKy?=
 =?us-ascii?Q?bdUMV+HB5hzJQ3IDk19fWRbWbxLLojp/MErfZ9c0zLp5tfAknbGBKz9Et56E?=
 =?us-ascii?Q?cyOGxm/8G31SxcvXidrb1BCN9B4tVarqroA11PNCPgyhYX4Mbyro6uwmpds0?=
 =?us-ascii?Q?1X7o8fgktaQI89ir4Jo4oHXt/2XWVTpHH5kqM42kBk0DHkWlH5UYGWptTZrw?=
 =?us-ascii?Q?mjc3q9OPreOBnsfFNAttcgS0qaLwEg8xY+yKAoZ9CYKNmf3sKG3U0JWaxvvf?=
 =?us-ascii?Q?vlnxkuQvGtdACYFttG7sRtHBD3ZBXlauuCtW/y0sm/KszptG9TGHWjskvDhz?=
 =?us-ascii?Q?xqI5J8A4CEqYxMPRvpDdiSAmJCz46xtQdX4HvThTkgM7JfNRjYB2T7Z0Lbli?=
 =?us-ascii?Q?e+MpkTadYUKVR7eunhZXw+W5oY0PElzCYM4Ew6dZIyN5CCm7YSggk4lj+WqX?=
 =?us-ascii?Q?u3u8ZBv1p8pZZ9pWVTunSGbn0rED1GQokhRKD28LXdgeW6zQNpqIJ4rOBflG?=
 =?us-ascii?Q?Mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iC/O/m0U/UW/1lNQtVKaQN84fLb3dLEK9pW8nfZ/NW9f5//Q4v4YbHiQhhIzDygNpIwDN0xIe3KOcA8Ae1lA4j/7RuWZxmzqLev/Aep5HVIlYO3i6w+8psG6/MPqaWzfOUOPWnzwMgTg0Q9u+tduw0qm0ptz6/K+FptIktdXLq1T2y5mxbwbz9MwlZiRX8rw7DeSxS8M8G2ZxxI5QFcv7xSxre8HIM+hIL0PM6OHUHKg8HyRbtkVwNVriqDTJlhcOB3n8Ts3oT22bFJT6wrDb0idqi42uwPr+WjrZM9OX9bGC1GTXiUlb3q8W8PIW4W8RqBNhD48d/yYyr3Paan0N1EaELC/gZJOkXcq9pFTnJd1GKEVMNzAo5oipNwu8js6Rlpm3RHCbc+TsbmZXq882mNsKNs1Vvb1u34FX4ramkQp5igFM1vGMWbU3NLvDyx8VLUVHoGIbaWhmUEgxRi9RSx7pGivOc20IMTvdg16CYowh8QIfCqxlCnCBmBTXVJakjaGWEX9gnUFdz+m6w05bmx8uQdmwgyV1jsCu2NOtGQV1fbOeKUf+Ex3PCm+ONpMCKODUMPHS3lzZsjvNZjckGIBQaLeXuaNN0NvBxWKdIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f214b83-c4bb-467f-6129-08dcafc4b643
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 11:50:58.6862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPhh/CWH7Q/MMLr0cILYuiC4d0qtb2t55ZEEuCRWUiNPbv0QWKl+A9birYLIJZ7XKdZhY0PKox4sKVM8dR97xcrXIvnbF0HhqyuaYnKQY7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_10,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 phishscore=0 adultscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407290080
X-Proofpoint-ORIG-GUID: LKyVgv6RPcShMT321Cgj8e3hElCvlGL-
X-Proofpoint-GUID: LKyVgv6RPcShMT321Cgj8e3hElCvlGL-

These are core VMA manipulation functions which invoke VMA splitting and
merging and should not be directly accessed from outside of mm/.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 60 ---------------------------------------------
 mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index c4b238a20b76..2d519975e9b6 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3278,66 +3278,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
-
-/* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
-
-/* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..81564ce0f9e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta);
 
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
-- 
2.45.2


