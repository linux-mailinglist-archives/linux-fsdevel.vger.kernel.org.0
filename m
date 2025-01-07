Return-Path: <linux-fsdevel+bounces-38551-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1ABA039DC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5897A1F6A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 08:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D2B1E0DBD;
	Tue,  7 Jan 2025 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a3Sfxp+G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="k8VSI27f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C313B58D;
	Tue,  7 Jan 2025 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238847; cv=fail; b=E2pGnS1Suf/urZYdPO/WqvIM6F7DuVstDoum3XL7H3/YYejadpmmFiqRe/X1jwC79dQ+y03EmeiYhgm08FLs+Ph4xpYT+Kywb1Fd8UvLuMBVDy3l4qFtsKruM8SoRuS/od8jo/6wmSJIKAcw2bPJopegcO9TynA9y7jWxB7tNmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238847; c=relaxed/simple;
	bh=kBpoqVBKH96DuDPc6LxoEvJB/G5fuGyY0SK1gIvkd00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EGMPCpCL/T/IIyExBA8nyCih4kp/sSDsdQntaREGuinbDLSHEe5N24A76T7G6c9ZcATMOCSLZ8mA5aBfUFiHbwmEfN1A3CTeKYivX9gi2zAmaL9oA8F+TofnwtBLIsfxvpeP7Me0HTPNqxkU5Fd7dDfJQLkhSrRYl0kN+yUpGNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a3Sfxp+G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=k8VSI27f; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5072tpJu020484;
	Tue, 7 Jan 2025 08:33:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kBpoqVBKH96DuDPc6L
	xoEvJB/G5fuGyY0SK1gIvkd00=; b=a3Sfxp+GuvDSS3vxu0qrK36EFGR+S9xMxH
	+M2YkzuvNttjTJpQf/if4XMMbaXYyhTHWdM32x5pNLmHcoCUEpG8QvE+rUDm7lls
	eX8xQwAsb8W0+EIoMuK1up72LpSmNOhoAEk+zQVI4xsUjb46k+n9c75lijKiuUg8
	lNUDsCrsp18CYpUuD+dqRwfVhptnO+Vdzc8W1JJ6pPmYKZS9SIy5IjY4ZtDHLz5f
	IaDl1eFJOjftQ2ohLhfpDCGvSPAyDEvSWQU/RKxTzi+n/PdYdxiZKcxzaWrW5oed
	h7PX4Keho560XrtnCvM4qJ734xpjTitK768qPnTBMV+Zd/+bQcPg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuk04d07-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 08:33:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50765GE6023426;
	Tue, 7 Jan 2025 08:33:25 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xue87yxt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Jan 2025 08:33:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFToKRTboaTup582lQiMqsM7jQkvV7v+lCHkqm37zQJx5SYIG+7ceP9cosVaMUYM8hm8y2s2n0H8xCuOyMtaE3bbeizN1jsQ1io8Bt3WGhjz5a+uAjkMhPNbkPHMYCVVFWAxNqQ02/Eru3fxeevteJ2P3OXZIk3vJneyd/nkTPtAzI3PeNXf1PQHsTArDvrAkRvm+wr7AxkXlV9jhpVPE1LGzFzEFn5/NyNO1m/lK/cUBURtOkRN4ALBu7tsRJxcyzq5teeOGxjP5GGEX0e9enNDTGX5pfiLAVsY0pYLz3MUVKxZlx2pYT1LmCYehxRXetp6n1XLANXHepYZGM/0aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBpoqVBKH96DuDPc6LxoEvJB/G5fuGyY0SK1gIvkd00=;
 b=fBap4WOkle0ulYRGbFsYcR7qlatTfm8FgGiHRg7gOPIUst+Aw8+vs1uzuF2ZEpSYx/ZQ0o+C8XdtcrhuXjceSdv6oTwn5yZm+b/ulr4BHfzOBhcoCxLBetiFeoxj80zHQT3P9edCzfna9uPh14qcwBZYBzfhlrtrP2va02U3/DJ1Sx5YdiNYPxjjt7iJgH+QDxnD2ruiqTdHOGzb67t3byBTgnjW4KaHXiVViV7N5IbZodwEU/GR+kGVra+NZsmeUOB7qjEpflV7f3SwoSQmQkpSjU0CY7xiDJdI2vTYhxQwu6lZzyb9hIW4NuWjPITfebs1N26Gf08B/PgvbQnMmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBpoqVBKH96DuDPc6LxoEvJB/G5fuGyY0SK1gIvkd00=;
 b=k8VSI27f9fkDUiapj5USx5Pf9Xce5rvzyp39xHppRawQ2ryoAEQex130D1EDiw8hX2epn8tWOS1Otrc0DNFfa8vNi/dx96FIU9n/faPRXMnUt7IydclnbiGMcVzMNK2f/cKZTbYSAjqNLya5jn5M2G3I2aS7LDml9YoojCBw04Y=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB7309.namprd10.prod.outlook.com (2603:10b6:208:3fe::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 08:32:58 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 08:32:58 +0000
Date: Tue, 7 Jan 2025 08:32:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Christian Brauner <brauner@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <7b80b532-e2a4-4086-9bc0-33df75ade608@lucifer.local>
References: <cover.1729926229.git.lorenzo.stoakes@oracle.com>
 <8eceec08eb64b744b24bf2aa09d4535e77e1ba47.1729926229.git.lorenzo.stoakes@oracle.com>
 <20241028-gesoffen-drehmoment-5314faba9731@brauner>
 <c96df57a-fa1b-4301-9556-94a6b8c93a31@lucifer.local>
 <b8f4664c-b8f0-46ca-b9a3-8d73e398b5ca@lucifer.local>
 <55764300-1b53-4d14-99cc-e735d3704713@lucifer.local>
 <fbcea328-9545-4f3e-9f99-2e2057ce32df@lucifer.local>
 <wvwahrb5yxd4dzfy6an7dpefiswtbc5uutckltbtx5p7hv4pxg@4n6tds6cmjx3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wvwahrb5yxd4dzfy6an7dpefiswtbc5uutckltbtx5p7hv4pxg@4n6tds6cmjx3>
X-ClientProxiedBy: LO4P123CA0295.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: 22467def-c59e-4b7b-3e5e-08dd2ef5e41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BAle3urETsGVuiy4AvU0VzjLy+++aUlTBYTHWgtE/ZNB7zszHPN2HM8ZR70k?=
 =?us-ascii?Q?qVu9kqZxCmoV6I6vSpU8nag1kdRDAR/PJzsxQC2lutQXNyn/SIILW009UPwi?=
 =?us-ascii?Q?QYg7gUBfB+AyKSxLMjbQ9ztM/HrUS+1o1IJvEvHS5rhiyDE6EieozQINgbVy?=
 =?us-ascii?Q?uZG/Uwz6y9INdkRH0ERVLRCZXHu3LzHeE3XUTUr/g7Ml62Tx5cZnQaesks1z?=
 =?us-ascii?Q?5lmRygteIfic0qoWxXnyQU+u4kgKL+nHiWoLGtQk2O5CialFjA3ry4MasWrP?=
 =?us-ascii?Q?1IodoR01/YGEPl6DkkOhy1t/xAjApjb620r+eNc2Ibphd9cpGy4xn7uaDjPb?=
 =?us-ascii?Q?QUnrQYKgDbYIaBSGTM2CSgKc1maR+edaVLcUUqmiYH0DOofm7g4R7Toh4t3r?=
 =?us-ascii?Q?9XieGAYjrjBSHQEOW+Tzu9MrqsWBX1RJnKGcuN9T3WNszCliTzrt8NpqC/eB?=
 =?us-ascii?Q?S5WZCwahNKVheuLHuIOX4m8wCOMzzWPP1LRMyEFZRFZYSW9DFkeTYDtlKtxl?=
 =?us-ascii?Q?6RHSLRCda+Jegj5b6KeNyXcKIS/MJDp6sd9NeyITxkWrNNY1l3zPYjjYxi7m?=
 =?us-ascii?Q?qEB09OQgD6+M6fyIn19EBFeppVQQHBDiw06V8hPXCt7fUNAASve68AE7uOj6?=
 =?us-ascii?Q?f2xj8Q0WtGrQUcgLdIINA1CDtQiPxdLliuGlRvLL5c83+8MAToRBf8BtAlCz?=
 =?us-ascii?Q?AxQE/giPYkf6VGdvGScbuLFQONpw80bC5HCCd9BVAfDe3tFW3qZKGzdanoGL?=
 =?us-ascii?Q?BEQmq+IMAW7B4+LmWz8lkEoXVCftOHrSkoDfebirk2Ei9OwbX6qpfbjsFLKd?=
 =?us-ascii?Q?v40Px706dxQ0MYcYZw7sPWIIft1zFDwdOMdCJDcVHVHDUYNKyY93ZAc7lpZT?=
 =?us-ascii?Q?1PbiYdKyBs1okN17TArr58ehwJYWQmbj2zVeF1hUhpWyolkdd61mL31ZB0qA?=
 =?us-ascii?Q?iHGbjAoDJBfkCLpCwQL0QBxbrW1omAY1l8BxeTRTTAxoe8JZ66GYgx9IrwCy?=
 =?us-ascii?Q?MhjiYZdiV/xH/DXavz7XWWynBu8UMmFDpRPEK51iO+NoAKWdemKP0/uNXV8g?=
 =?us-ascii?Q?g/wneQb5D4BLF735S6OH0zoTKxyum7MX8Pq5QuwG/R98asIBipz+LwCQ8tkF?=
 =?us-ascii?Q?WosLcbSR96WezDdABmRLfeNqdvgr2oHh2kDYYtIvQ7lTu+76OQVkB/Cc77UU?=
 =?us-ascii?Q?0nJA4XHgMUQ8Vddecqx5aFwd3RZe9sweGWIm5IYqQMf3j2kmJiObIsigpxSv?=
 =?us-ascii?Q?3N3yh0yTEb2srg+YBUWJef7YM0sJUyxgyuvQ4/tOu60jO7FnV2z6lXhLjJbF?=
 =?us-ascii?Q?unf7LGKNqV4PoyTMwHVl4Q3K9PBNOBSUG42/PuwpzSqFQUTuGr4yk5wkx5mx?=
 =?us-ascii?Q?+hPJ3IzYUQVMCU/7zSjHEViO1cZy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5uExagbJ4XiBBzWNwwq/9aIqskgpS4VPtWbc4ar8kFtN2rxVBzaKO/9nSoWo?=
 =?us-ascii?Q?DX3dgG98+ANyLni1/deDcTcp5ZEZoZhUPhwsEwrROzL+e4FWsic1KJwUXodt?=
 =?us-ascii?Q?/7/sTuWmFTDp0dNCefCiqQ6kQZmYyfpnxDkyAH/mWNffAlbWkL9uktOsAtt6?=
 =?us-ascii?Q?B2OF4n07nLXas3YpLjSp3nbmkbcf/9k2C38qlRPxS7p3QzsTtSghYstkmgUz?=
 =?us-ascii?Q?rPBLTHykEaLHISosIttumL5g6FyHMhaNQCjzEEYJNiTq6+sJUdlMFJ+4MqJt?=
 =?us-ascii?Q?9qnMcqP/T694lkHQYivZlHzZZzcTqeM/2r6K6JhLW7rxSgXM9l5gLt1fb8O9?=
 =?us-ascii?Q?D/UNVEEJuMJ/iTkEOZNLTgCO/QHL+43o5GRprHOpPZj11svunlT3raiK2wo0?=
 =?us-ascii?Q?nmWAg02Qu/GlvZdlCsPrW91m9kJI3A1v39kwG40JMt5FARhKjaBUnFm+K570?=
 =?us-ascii?Q?Py+lk42afvhq6MnqZVBgpvKl5jRlBGa5QGgdrABIrnX7demC6bEgoeErPV44?=
 =?us-ascii?Q?/MR8KXTKYPbr/Vy3pswTkcRUjUnKmalzQViAaZX4byLS/g4E1vKjuY/3sEhR?=
 =?us-ascii?Q?F+NBcq4OhsOD0PcvTehB43MQzqK9ZxdiBVG9/24lUJEYSC7d0J/vq/4G58Nb?=
 =?us-ascii?Q?qIgnrN5mv8Eybr7KvlRITco08iJA5sQUgyYpi6kGZIgv1WQ3rxGC4v6fX2f6?=
 =?us-ascii?Q?WDN9saiEcf6KarKHQfNzF48TRhggaQCkRd0sGRi/oEIIkfuUmr/G/LceOrss?=
 =?us-ascii?Q?pXPLEnV2C4I2DRxDLwOgzgYJF8FPxNyzLKVBrH6r2m+HfszD1h+aXTwNfw8q?=
 =?us-ascii?Q?yFWtP/arUAbjbLr4vJeNcJ6zmZFPPqFjVxAT/v3RF/jAPT9N+iIEimBPq1Gt?=
 =?us-ascii?Q?Kjv4lVYxelB0JOYiIuNTnRUDv69O8yOn85S0QuDoiAoI8pF+i+20VFKX3SU4?=
 =?us-ascii?Q?8DxPFHyM9Wm0YNSUdrg1Xk+INcZW8YKic6qF2xlz/bWex+Re/brGEewU+QFN?=
 =?us-ascii?Q?CwmPkR1CMmgQ7NX25QiOIfBpA0bjYUXKLkQ45R5YIed/zbubAKtLGbGh9k9t?=
 =?us-ascii?Q?reFE7chyXgJtKF2koHHepjd8cb3bekVrxufjUvlWYqlwtgf8Mvqz2REAuJ7w?=
 =?us-ascii?Q?VypRlQO401U9lr3C3xUO9PjxdwL5fFEeoaT5HJnIjDKDjjRgMqDhrFIK1yQ4?=
 =?us-ascii?Q?/NLSlcVmitpXnQm42/x1BgctFZKdxxwwWVSCITnzaF3X1A+2Vy2C2YkcEEQf?=
 =?us-ascii?Q?ev8RUEWGSQNuCVnThXRD7Q6j7aom1mfqOLkB2BSyLfegueGYsGQsR75l/Ncl?=
 =?us-ascii?Q?MRPw2tMbQDg0AhUcTIX8sWUypoDGaMoSXDzj736jUJQwhfEEFtjGfH+luhMw?=
 =?us-ascii?Q?9/K42GhSHRkMpxZsUtwRSn3IqMFokHK7w3ihYVVz8Cw/iCGCWNSzIMwlweAH?=
 =?us-ascii?Q?Rl/X+ol6usZ8xyFIhnr7ZrLfkzxUQYdnJeu3zXzuXoLxG0yIJfnyIvzStdly?=
 =?us-ascii?Q?U0mAuqUmNaPHlcHh1E3HM5NQIIU03g4/Xfyn49jxAKW412THyMW4JMdLrRMJ?=
 =?us-ascii?Q?F+Sn2GCaA9AsDnOjvdU61bjpP+PdHa68okJg0Omcs5HKBN/Jnd/B2zFn9Kek?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YPXgvTVCtwJh+03OnISwbbZKR6AGyC9wFTtdLegRKVnM1YjOt12utPe0N4HO7CPwse8y7QHZ0eddRLOBsyHscjIrQOB1oJ1LzXHoz86ao3hTC69DkW69F1s643ZplTfor+Iq8kusPZF/0T8LYayjLVeSHNp5rua0CVzZZcKOCqVzklS2nnOW7oX5aS7l4m+gNj3o6RDTDwPLEGzCXW1Ek9JRi6Kdbe1qd5HRfMMztmASj3ug9BURgsYA+w5uAMKjmAkF3zItrpo1E0om+yVIoEph9nfeMsBGDdNHZLzl+txIPjtSDc71WCtBhuU0TTaB+hcibX5zhvTwtobKAV4h1/eTJpGy/utn6R7eJoxY4oyIj7tTn80/uhOqYsUYJHwrkfVoHwwOqk5jaRZimJiX2qFxD0M9xCXa2nBmoW6i4flKNM9vUzDNTtdaWdmTA5J24MtVr1HczNVKtlQFX2VZz5j9/RER0dkgPNad/d2mTz8+Qvdh5K5Ee6esuuexURwcqorpsd45FE3ajbicp9vheavS2gOCJ4TdrbRD5ecLPAMMqlz3y4YQUNYI5wRQ/s/JpS9wRT/GShCkqJA9UniQKzRv+7t/Zj7vDh8skh5dZhQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22467def-c59e-4b7b-3e5e-08dd2ef5e41f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 08:32:58.7442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RbezS7RG/HhSbt/Bo12RPBZCVptEY3rRvoxT2FR0bhsMF66021/MxL+RgzaY4v5Dx9l1Y1rumkDGUxVQ+TSm3IiRe97VBcBtA0bNzfqWdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7309
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501070071
X-Proofpoint-ORIG-GUID: E8JpFi5InIPNU-zDEF91K9yvueXyu3CT
X-Proofpoint-GUID: E8JpFi5InIPNU-zDEF91K9yvueXyu3CT

On Mon, Jan 06, 2025 at 01:03:31PM -0800, Shakeel Butt wrote:
> Hey Lorenzo & Christian, what's the latest here? I see Christian has
> code suggestions at [1] which just needs to be addressed. Any thing
> else? I am hoping we can get this merged in the coming open window.

This is on my radar don't worry :) I will get to it as soon as I can.

Cheers, Lorenzo

