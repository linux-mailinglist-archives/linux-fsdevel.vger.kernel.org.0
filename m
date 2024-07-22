Return-Path: <linux-fsdevel+bounces-24063-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F2D938E6A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD41C21265
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E375916D4D6;
	Mon, 22 Jul 2024 11:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ixxGU7v8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VB/qw4Jy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E1316CD32;
	Mon, 22 Jul 2024 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649063; cv=fail; b=SgT5TcVf+G58sLXVxw1tZmmx/4eRg2M05QuKJ0MCCx3TZRUZfo+pY9Vz6Zh46Pm9zksbh3Qj7nVPmhQt0oQOMD7Fo2Em4RVPJn5PayWFU+1L0P5MeEmVMA96ibf8ItZBzSUfBDR/DsTlmKzYkWzJWVexxXjaPB4kgzfYgQ4lQiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649063; c=relaxed/simple;
	bh=e8uP8N6sgYZvZ3z0y5TCl0UqAbukajZFGdZbVy4Xzb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FRxzeypwemgDjfSqFkkiQdwpgw4eiG1UF8thlDbj4uMl4S+ZTYmAD1nsSwD5HOEwZYgnhaq93/AgB85k70aCuZ/TLIzp9jp8j1Zsq4Wi4tuWo1wvduTPMf1f5KnFxTNo3X0YvQSwYjYHFIoJtcsm5W0p1v/AGXPSz2hyjKnlCaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ixxGU7v8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VB/qw4Jy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7cw06002326;
	Mon, 22 Jul 2024 11:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CxPHIgh89TubOfzI4B8398+zyVRpqgpe55CPCbtLQEQ=; b=
	ixxGU7v8RnSsVdJyi4SISJ6YKcRvn3Xei9m8/Cot3JeJ8Q2/jZq8CmhrokFQWI3H
	YpC8P4b+Jv1wysgMSsU06Z7cK4dDLDraOI9TLER64qdPY6i4CVskD5vaZQHklwxq
	CO5GbuzOhPi8U4hK2VKNtLExRBGiNHtUMZQKTnqNkmbWESEdaJGpelIw4SbMJnWF
	SS5woEuixBJRRBkMxosx1IMRE3X/8hKHak2nrJa1gvs1G0szNydnsW7l/UIBaxLU
	lbDapY7/8z50+kkG4OAstKLcksmV91+vg8udwstZ/8pSK4MRg+dpucJJy8moVeun
	CrlG2acYABY3q468ewzDkQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgcr9ex5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MARVoG003147;
	Mon, 22 Jul 2024 11:50:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40h27jvpxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQAq8Jb/if+CZuAXr/3l/mwnEWhFeCD9LhYYGeBPAFVE+A6sbVfv78XrEYl1OcJkDSP8jrJ/dBN2MTZexUKPCzT5MnwPQnyuckjrWU2Ts75+V6UEjIPOBDgFsAmSfj344tJScb52PdqLNrBsOz7vqGkqwcxtSQ4puwDiJYVMbdzuFSekqo389UVEAgc0mVG/P2wE4TqXAt7XhAHtQylVI5eS3QzimXm6U0dR/L9hrV4tnnxecLN2dwivzzvYp7yjX8PLgAaxZVWwr6g5MT1YO2T/hPeMo8xn1g/8cg1edY8T1383RI5tQoVgjhcsBctUK3Fl2rMo0XIhfAUGPdarNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxPHIgh89TubOfzI4B8398+zyVRpqgpe55CPCbtLQEQ=;
 b=q37RiiLadYFlCNDEDVmGGm1c/gfaKtnN0BarT02GPq+EA8uuTuczK12KwGRy8voLajhjGfzqbe/DxTr7WXw8UexUQMVdX6O9EtFH5HP+ojz6cxnCMeU9bKCzv/AunAgmtGF2M6kjXCSJbFESuWolPamsGxQrZJUB2hstmJvrVrKmEPze/bkDDOHcGiAsyhNsMJ/r2EwytgulDKtoLtSDXftfjxlYNCNiZlVjgzsqmaCEqgdDZJXEXyAFHGLFIJJq10Zv5N/dM6UiB+LEKAUWsVm4gbCrtKga+U6GP71jngFtAVOe2gz7rgZPT0xDYI7GK9LTNmbHgds6IqtIYGIHgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxPHIgh89TubOfzI4B8398+zyVRpqgpe55CPCbtLQEQ=;
 b=VB/qw4JyhNeMWyKckDLu8Bk27Mn9PMoCJ5R8PaAVX5f30ZeOFbcsMi13d7m5qKznQm86kcNvDGR9Hd97FIMTkI6euNT54xR6LlUADz8nwc5ZGHI43iU21EBNf1J8o9FlZDFf1taaNPhfLYYJoxvmPVQIZeOHc7k82ayzXOefTX0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 11:50:36 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:50:36 +0000
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
Subject: [PATCH v3 1/7] userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
Date: Mon, 22 Jul 2024 12:50:19 +0100
Message-ID: <5fb6ee4aef94d5c6c78c33de86263b15504bca4c.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0098.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f77a6d-e5bc-493a-3f7a-08dcaa44801a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EdOs7e5vPxVyK63M1D5LnLmvRdEUUD0UOHRnSYUshJ9DT5h4SEXGGgjI4M4Z?=
 =?us-ascii?Q?nfNqDOSSH/0eKe5DnZQrsgP08BPBBQWpZyoVDs1KfoR//ir7ZaUjFMv8VvNU?=
 =?us-ascii?Q?r2wncWXZp0Mx2vBC9wmTKil8dOGRu/9/EqBa5dS5lmPXi/Msa6jWCUb+EHu8?=
 =?us-ascii?Q?WxH8m1qlx1FfGyIeO2I0jB9Rap56b5drvevibTFgjqP+q0vt4xO5aRUFrzLe?=
 =?us-ascii?Q?achVLCHUppX8MUosw6GK+JQmXMQlI6X8Px6GpNj7gKIsTL1eYKhbt6Led8mZ?=
 =?us-ascii?Q?vSgkayEHZlVF261Gat00Y3ka9lBFec4GpCYmXm9nTz1K8RKO4B61+YMNUO0g?=
 =?us-ascii?Q?rtJHu1CyFaO4u6RuD4mAcV2J2p/bTUpnQR3m//ikcivOEkvWD65blOvb7n1K?=
 =?us-ascii?Q?A4Wt64QAvlSaXKPNonwnNPhbMidnyoP3nBJAov40/6YYRbA+r8s3hWibwy55?=
 =?us-ascii?Q?QZFiTWm4jQPAI3iq8TyPoTHXn4W7MFK3NwjhlHe6n+Xh7vbCXrQlSqYArF8g?=
 =?us-ascii?Q?ooRn8cLiwgnyPfl20psKWPoeS87gtlAS/qXcBTek738Sk5l4rAUNvKUB7Cws?=
 =?us-ascii?Q?RGmAeIpAIv/BpsM9hU8R8XDutUaZFhvNGESQkWHNgJERiNeFpizaSAFtpVty?=
 =?us-ascii?Q?d1AKFm4RuQZCz7jsRwoSa5U9SEHldsczxYSPLF1RUa80pE8R8SB1DRw8YquR?=
 =?us-ascii?Q?A1r16wc1tradx28DwOPR27dSnDZ2fbEIX+WBVfP9zsEsB+ZWkSwXmAV0kc09?=
 =?us-ascii?Q?9MOMv/V9xgzZFwvozWmefM8hGP1yvGzXCziqazDxL3vml4+mS3d7fcrpc92V?=
 =?us-ascii?Q?7itG2Vd4PPtnhRfYtemB5KC2T8rSRe8suRJVV8jOig/hStt/iYDPez5nH75+?=
 =?us-ascii?Q?IZfqkUpcwSQjYK1AebCyWY4xTsUvmZn0QZD6ncLEhlwO0o8m8XqMqx2/TJyg?=
 =?us-ascii?Q?NL01wo/HTA4g+M3RMkoT7suNtlO/Uv5KuNFjbLRiflqhlWP0n67StT/ucxVD?=
 =?us-ascii?Q?7qwkY0tvaDBKk2fhXJ3W4OL0TeZE+4qkfHxSb8hzEDN9pahcaky9aCK16BR0?=
 =?us-ascii?Q?d+HBaBa6qXOqh3NvcUJqYZAlCrGBMlClCX51VWOWy8ZCgT42lPHlF5dfnfLF?=
 =?us-ascii?Q?NiOffXAeUjOPHxGUdYa16CBAk0/VaPCAegFaOF8M5iuVFTRNnKl8GAZD1DEt?=
 =?us-ascii?Q?Y6PonuiK3ZMGTtKJIxtPllfqrhtNEeWrK24U7/qLg8lD3b3D0flVVNUbbv3J?=
 =?us-ascii?Q?XiBYEmyMxPEvSMcGPtLwWC5/JHCLQuHgSJWLCYMbT+Knr59LBI6dEHXkY5+t?=
 =?us-ascii?Q?TqS3sXX1h29siQLpiZk0w5YrpvMNRzC6rcxsJtPbKIH5mA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lN/q0t9Mes0bf/nGU70lxOV1bx4NNLXXTXtaro1CVtypkdffqM71gbUw1OB5?=
 =?us-ascii?Q?8s2zxDUYivRIHvNVGd6Xm9Jkosk8KsX9YzYXDoq8Mj0ZpFj2UVVRPb+paFwW?=
 =?us-ascii?Q?e3hmWe7xHeu25DOcxS4yUYltVDW2wGXOJw7jVZOmi88Nc5kFoJqRm+a+x3x/?=
 =?us-ascii?Q?qJqLJJvLhodFAqfD969hTgWRVQlFH8OmrVjLlkTGq/EiKI6DyrOHpcyG/kbt?=
 =?us-ascii?Q?1iAE6ZNT7PY9QfyDt6Yj0GVXE3i9J3XTaQ6wjwhPDLjVJprhzai4e9SXv25x?=
 =?us-ascii?Q?3Z56BnTo2NSpCvtwzl9nrDbg4r8eP6cX5xB0cm9cTxiPN2wwCBxebJJaFmui?=
 =?us-ascii?Q?PB2eeFlUQf99pw39pVzXdJy0C4Jh43em88hGhJlo4HHAVYbRrSXG0AB3TYn8?=
 =?us-ascii?Q?Lgrh+7aL3iChnw4iBs0/rFQvipKv/yzwB9egy+Gpd4icyPuE57+srB17M05x?=
 =?us-ascii?Q?rMPzvqgargRlKOKmts5Jikq2mH2mjDiAChZStiAHr1fpSMFMZnG06TYfvku1?=
 =?us-ascii?Q?Pm3zSrhIx5ZXKzSpm1LPbO/2hNVgqakpIfLq9TcJabH6nVVDX+jekz643Hzm?=
 =?us-ascii?Q?9xJ34JeEE7RCfMVtvAa9ONepVOVUOQn7MAXPaMFjLIhLnq8snQBznOVe3qgQ?=
 =?us-ascii?Q?aZvK2Yp62RzHetITpNgm/1jOi4zk1AImVPl0Lkz4VgNhcyD5MflWMT4FskQh?=
 =?us-ascii?Q?9njBBgMCLX2oQICbx0dUug8XfbKmtXXQkBpCYVcdhd8+ro2MDnu2EwcEpSwB?=
 =?us-ascii?Q?3OQh57menEBpldP8ocTC1KsGFh1EihQW0beT8bwZ1NaBqujU6Rd19eYIYZbJ?=
 =?us-ascii?Q?gz0MTANA6Ix4oZrmurYX8tJ5oId6mLqHSOA7Xw/be66SG+FylsNxY8aI/iBr?=
 =?us-ascii?Q?B/HbJrGAr0YYAs2un/VLWOUpaviZoPuTIec9DIQKZso42pDDKD386osVbukO?=
 =?us-ascii?Q?kVhIq6wz8WmXUoxq7fzqlu4YwzhxC4gsL+zEXVfuNLmvYoYasWQ8OCw1Vf5F?=
 =?us-ascii?Q?V6kdJ1pUIyiNXKbnOB7nCpYJvAmKoQTBeqJxFnClRtSj3PHuvjVT0qfSDnD/?=
 =?us-ascii?Q?p2CWGT3VsKJ1PhcFGTAVko+vk8VkjqtQPdl12rO7OelVyhA3/FqaUbPJVXih?=
 =?us-ascii?Q?nOcUBHAwYGILLndfvIO0pO0OA8nVurY3RxcHGcGCnn8VYd/IHlifCIBfV8tK?=
 =?us-ascii?Q?xsVR5r0OgAg78JUPpn+lFgomCcj6K581iQuhGbSB3kPd60MHE6nW11OCrrZR?=
 =?us-ascii?Q?1OWkKcFqQoxxxUZojsLAzKpfcpLwjX0+KYfYRF90Da97gMZOdVPWL43Oy+0o?=
 =?us-ascii?Q?k2QRuIktvYDzfcSbr5wD/8FMQdAY9Zu9K7U0XWg0LW/HqlV6ER4C3QY31azV?=
 =?us-ascii?Q?mcJFaJh9O/8Lf7sm6MIKreaF43d61/4Zjm2dIrtq05pO/LJwvMHOovJXAOjs?=
 =?us-ascii?Q?/c+eXfi6RY7a9cmZi4i2QA09xBuv2TvbUPC2vFKKgjwcvsDSUcXSJ/ytIJl8?=
 =?us-ascii?Q?214pxzv+QpVjMdKa/k8BJb0pFlkVzYkDUZ4hZGJ9Tg6XwUWguDEj33TVBd5g?=
 =?us-ascii?Q?2dKH/glVqJBZa0WURlV1oKmsmhm8vLUWhHNWWhdOd27G9FVPf7OHKBGEKC6W?=
 =?us-ascii?Q?f0uFtwf5ey5Z/1RJ9db7lvfFfptt/teJkeQHp5kwgH01SaHhuK/8/byfLiZt?=
 =?us-ascii?Q?hi56TA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OjU+Q5YR3hyUXRoGrbQWgCJH5c8pFi+kvgmILdR38oZ630QiFxjY6B/OJoQIIkkpvgjxVVyYMeoML0TJvNXTTrXSW5ySH5CT3ziZH72ZZa9yAxrQeSZt2wp+DqMKRYUZpfx7QQ2IB1dHSB6nZ0NqLiPBhtSickREnYUctmDyduKDy+hxNoQe4TDM0MxXPHDAVjXzCfD5eEIDhX4ILJIc1LeTyv53k0reuALdBj70yhNi9yunW8wR2z5YMA4sHJzb8CsHCN8wlWWTUFVFt+JTrvNM1TS7M0b0CuL1v8n89v6ORbrWhoC3kmAr2rm6d3IiX8f3yJMKrbXkhM+dw9iJilh7Ku4kjqh+rOzQCq1A6uRmhsA8zB9ay+wM2VfFbGanReOTDQbEVx3amKe9BPR5P17g+AylHehIrJhYxbp+BYayDrhKvwngkwxwDussuJv3LmXeLEi1bP9MjnYnr1c6zi662NU7TRzSXDGMlbqqwfXjmGKWUiokx5CXt1En1KBMr1LTGzFI+Wwa8R14fLqOtNtfprOr+yBbHCLwCGIapkX0xF4UC6cKYmuYJt5IksYpjintSYDW2W0an34GNtz3CzPRkzPyGDa255p3Tg5CAXw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f77a6d-e5bc-493a-3f7a-08dcaa44801a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:50:36.4719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llAkzRGTQL7GVA2fuPoN8x8X4QlpHTMPA9khqvBhgOl9ZgzrjAOhSWGIAO8vXqGrj7JCuDOhSaFsumWnVejVFjU7AC3uOnQ2sz+Y4ZuwMig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220090
X-Proofpoint-GUID: VaCQvGuJyHkYjy9p79FkAQ6GPP0RVPQL
X-Proofpoint-ORIG-GUID: VaCQvGuJyHkYjy9p79FkAQ6GPP0RVPQL

This patch forms part of a patch series intending to separate out VMA logic
and render it testable from userspace, which requires that core
manipulation functions be exposed in an mm/-internal header file.

In order to do this, we must abstract APIs we wish to test, in this
instance functions which ultimately invoke vma_modify().

This patch therefore moves all logic which ultimately invokes vma_modify()
to mm/userfaultfd.c, trying to transfer code at a functional granularity
where possible.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 160 +++-----------------------------
 include/linux/userfaultfd_k.h |  18 ++++
 mm/userfaultfd.c              | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 197 insertions(+), 149 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..b3ed7207df7e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -104,21 +104,6 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
 }
 
-static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
-				     vm_flags_t flags)
-{
-	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
-
-	vm_flags_reset(vma, flags);
-	/*
-	 * For shared mappings, we want to enable writenotify while
-	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
-	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
-	 */
-	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
-		vma_set_page_prot(vma);
-}
-
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
@@ -615,22 +600,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	spin_unlock_irq(&ctx->event_wqh.lock);
 
 	if (release_new_ctx) {
-		struct vm_area_struct *vma;
-		struct mm_struct *mm = release_new_ctx->mm;
-		VMA_ITERATOR(vmi, mm, 0);
-
-		/* the various vma->vm_userfaultfd_ctx still points to it */
-		mmap_write_lock(mm);
-		for_each_vma(vmi, vma) {
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
-				vma_start_write(vma);
-				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-				userfaultfd_set_vm_flags(vma,
-							 vma->vm_flags & ~__VM_UFFD_FLAGS);
-			}
-		}
-		mmap_write_unlock(mm);
-
+		userfaultfd_release_new(release_new_ctx);
 		userfaultfd_ctx_put(release_new_ctx);
 	}
 
@@ -662,9 +632,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 		return 0;
 
 	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 		return 0;
 	}
 
@@ -749,9 +717,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 	}
 }
 
@@ -870,53 +836,13 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 {
 	struct userfaultfd_ctx *ctx = file->private_data;
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev;
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
-	unsigned long new_flags;
-	VMA_ITERATOR(vmi, mm, 0);
 
 	WRITE_ONCE(ctx->released, true);
 
-	if (!mmget_not_zero(mm))
-		goto wakeup;
-
-	/*
-	 * Flush page faults out of all CPUs. NOTE: all page faults
-	 * must be retried without returning VM_FAULT_SIGBUS if
-	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
-	 * changes while handle_userfault released the mmap_lock. So
-	 * it's critical that released is set to true (above), before
-	 * taking the mmap_lock for writing.
-	 */
-	mmap_write_lock(mm);
-	prev = NULL;
-	for_each_vma(vmi, vma) {
-		cond_resched();
-		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
-		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
-		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
-			prev = vma;
-			continue;
-		}
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, vma->vm_start,
-				      vma->vm_end - vma->vm_start, false);
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
-					    vma->vm_end, new_flags,
-					    NULL_VM_UFFD_CTX);
-
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+	userfaultfd_release_all(mm, ctx);
 
-		prev = vma;
-	}
-	mmap_write_unlock(mm);
-	mmput(mm);
-wakeup:
 	/*
 	 * After no new page faults can wait on this fault_*wqh, flush
 	 * the last page faults that may have been already waiting on
@@ -1293,14 +1219,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev, *cur;
+	struct vm_area_struct *vma, *cur;
 	int ret;
 	struct uffdio_register uffdio_register;
 	struct uffdio_register __user *user_uffdio_register;
-	unsigned long vm_flags, new_flags;
+	unsigned long vm_flags;
 	bool found;
 	bool basic_ioctls;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);
 
@@ -1428,57 +1354,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);
 
-	vma_iter_set(&vmi, start);
-	prev = vma_prev(&vmi);
-	if (vma->vm_start < start)
-		prev = vma;
-
-	ret = 0;
-	for_each_vma_range(vmi, vma, end) {
-		cond_resched();
-
-		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
-		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
-		       vma->vm_userfaultfd_ctx.ctx != ctx);
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
-
-		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
-		 */
-		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
-			goto skip;
-
-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
-
-		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
-		if (IS_ERR(vma)) {
-			ret = PTR_ERR(vma);
-			break;
-		}
-
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx.ctx = ctx;
-
-		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
-			hugetlb_unshare_all_pmds(vma);
-
-	skip:
-		prev = vma;
-		start = vma->vm_end;
-	}
+	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
+					 wp_async);
 
 out_unlock:
 	mmap_write_unlock(mm);
@@ -1519,7 +1396,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct vm_area_struct *vma, *prev, *cur;
 	int ret;
 	struct uffdio_range uffdio_unregister;
-	unsigned long new_flags;
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
@@ -1622,27 +1498,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}
 
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, start, vma_end - start, false);
-
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags, NULL_VM_UFFD_CTX);
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    start, vma_end);
 		if (IS_ERR(vma)) {
 			ret = PTR_ERR(vma);
 			break;
 		}
 
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 05d59f74fc88..680d935f01c7 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -264,6 +264,24 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);
 
+void userfaultfd_reset_ctx(struct vm_area_struct *vma);
+
+struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end);
+
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async);
+
+void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
+
+void userfaultfd_release_all(struct mm_struct *mm, struct userfaultfd_ctx *ctx);
+
 #else /* CONFIG_USERFAULTFD */
 
 /* mm helpers */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..3b7715ecf292 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1760,3 +1760,171 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	VM_WARN_ON(!moved && !err);
 	return moved ? moved : err;
 }
+
+static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
+				     vm_flags_t flags)
+{
+	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
+
+	vm_flags_reset(vma, flags);
+	/*
+	 * For shared mappings, we want to enable writenotify while
+	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
+	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
+		vma_set_page_prot(vma);
+}
+
+static void userfaultfd_set_ctx(struct vm_area_struct *vma,
+				struct userfaultfd_ctx *ctx,
+				unsigned long flags)
+{
+	vma_start_write(vma);
+	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
+	userfaultfd_set_vm_flags(vma,
+				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
+}
+
+void userfaultfd_reset_ctx(struct vm_area_struct *vma)
+{
+	userfaultfd_set_ctx(vma, NULL, 0);
+}
+
+struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end)
+{
+	struct vm_area_struct *ret;
+
+	/* Reset ptes for the whole vma range if wr-protected */
+	if (userfaultfd_wp(vma))
+		uffd_wp_range(vma, start, end - start, false);
+
+	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
+				    vma->vm_flags & ~__VM_UFFD_FLAGS,
+				    NULL_VM_UFFD_CTX);
+
+	/*
+	 * In the vma_merge() successful mprotect-like case 8:
+	 * the next vma was merged into the current one and
+	 * the current one has not been updated yet.
+	 */
+	if (!IS_ERR(ret))
+		userfaultfd_reset_ctx(vma);
+
+	return ret;
+}
+
+/* Assumes mmap write lock taken, and mm_struct pinned. */
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async)
+{
+	VMA_ITERATOR(vmi, ctx->mm, start);
+	struct vm_area_struct *prev = vma_prev(&vmi);
+	unsigned long vma_end;
+	unsigned long new_flags;
+
+	if (vma->vm_start < start)
+		prev = vma;
+
+	for_each_vma_range(vmi, vma, end) {
+		cond_resched();
+
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
+		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
+		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
+		/*
+		 * Nothing to do: this vma is already registered into this
+		 * userfaultfd and with the right tracking mode too.
+		 */
+		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
+		    (vma->vm_flags & vm_flags) == vm_flags)
+			goto skip;
+
+		if (vma->vm_start > start)
+			start = vma->vm_start;
+		vma_end = min(end, vma->vm_end);
+
+		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					    new_flags,
+					    (struct vm_userfaultfd_ctx){ctx});
+		if (IS_ERR(vma))
+			return PTR_ERR(vma);
+
+		/*
+		 * In the vma_merge() successful mprotect-like case 8:
+		 * the next vma was merged into the current one and
+		 * the current one has not been updated yet.
+		 */
+		userfaultfd_set_ctx(vma, ctx, vm_flags);
+
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
+skip:
+		prev = vma;
+		start = vma->vm_end;
+	}
+
+	return 0;
+}
+
+void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
+{
+	struct mm_struct *mm = ctx->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	/* the various vma->vm_userfaultfd_ctx still points to it */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_userfaultfd_ctx.ctx == ctx)
+			userfaultfd_reset_ctx(vma);
+	}
+	mmap_write_unlock(mm);
+}
+
+void userfaultfd_release_all(struct mm_struct *mm,
+			     struct userfaultfd_ctx *ctx)
+{
+	struct vm_area_struct *vma, *prev;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (!mmget_not_zero(mm))
+		return;
+
+	/*
+	 * Flush page faults out of all CPUs. NOTE: all page faults
+	 * must be retried without returning VM_FAULT_SIGBUS if
+	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
+	 * changes while handle_userfault released the mmap_lock. So
+	 * it's critical that released is set to true (above), before
+	 * taking the mmap_lock for writing.
+	 */
+	mmap_write_lock(mm);
+	prev = NULL;
+	for_each_vma(vmi, vma) {
+		cond_resched();
+		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
+		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
+		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
+			prev = vma;
+			continue;
+		}
+
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    vma->vm_start, vma->vm_end);
+		prev = vma;
+	}
+	mmap_write_unlock(mm);
+	mmput(mm);
+}
-- 
2.45.2


