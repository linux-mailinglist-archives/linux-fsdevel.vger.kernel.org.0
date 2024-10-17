Return-Path: <linux-fsdevel+bounces-32191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3549A21D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 14:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCFA9B22057
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7951DD0EF;
	Thu, 17 Oct 2024 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ChaZOWnY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a1uTOArJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C531D88D7;
	Thu, 17 Oct 2024 12:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166801; cv=fail; b=UGd+JDZ/Rs2L3w97R9eKX3cwPsZ15AfUDP4vA5OWaxchVVMhsXAq1UQBEw3aj7ZPgTZQ54psYvBYPHqnjeubEuNZMAtBRPiRJsAU4YmPOL1kbtvC5erhXkI7VIfMUs4phB0qCjur416hDR0P7DXbVPyhCa2Ngn2RSMBoDERjIvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166801; c=relaxed/simple;
	bh=FwRA7e/6tA7ubXgJmeBilu6Iz4VoUL3c/61ED5XGMSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uMjSmVdI61f0eiyf7VoVkarDEFB7IeN4G0LcdPl6n+AX/WeMWuW8OWpIA/ACsllzeQt+pHkh4CgTLqXMhq/0cUponEoJ8QJMEYgXqliLkVlJCaO/O8thwqCfnexmVR6wvZ4G0D4WIC7N/E8tDcamxNlv/jdPG5aicNNhWPNbVR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ChaZOWnY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a1uTOArJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H9MaVR000606;
	Thu, 17 Oct 2024 12:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=C4npcQQGgsVw+MeoRQ
	kLpFIv10wMUwQoDQxLK8nA5cg=; b=ChaZOWnYtN6NMxAotZr/8TfysuelEr5F5J
	OpfguJUSdhIFyKor9Bc3LwkAhMA4IQBtKqMCiKHkM/jMgL09WIMHmJepRwDt5IXI
	Eu6/Umh8Ux8pF7xMotMu6Mb/Yw+/qbqI3eLksYLUozbw9BpAiMl/3AseBmOdNlFO
	eXElZFrXZ+20efH4bRoh6kV0ioDeZUkxi2lWPLnp8JZfDo39f0cLtUR5jZsGaC+G
	VkPKIeE+JzpwCILyTPoLQdezo9/Q58sh2K4tI23fV3/vFoJqwPBJnQoTNZ3FPKlb
	20+/A5lG13AcMMz0rGlpAudgMTw6a6TzYrvkGhOx9ugJtwsQxI5A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427h5cpgds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 12:06:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HA7Q9E027143;
	Thu, 17 Oct 2024 12:06:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjgq4xx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 12:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHmxR7YhBWBvP/PJdJsjEFHY0OO18OWjrj5OJjExMa0KPbi2UWwBD7FTQak3UrSxiMXrOQrqmYT0IgNDjx9K86/96fUb2G/ZpEiy3GWH7jiI03JlSJDl1n3JycVhVZKGSCskA3vWv1FV8bxSf7dzR8dZcAsHg27nFJaaZ/oK5xvCHNuE/h0+akQCHe2rcuhEQyUWxDCXHNk45Opyym5a9JIb3WIvY0z33bRik6yL2bsqzONmXNS5x2J/HPs81nS4+9m06MdjW/CffCTbDvXrFt8HeRXljySQdZ20GYx6NLB0U8ThpIAvUt5JlPQdDmbUT9ujLaDrcShpura+VjDMAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C4npcQQGgsVw+MeoRQkLpFIv10wMUwQoDQxLK8nA5cg=;
 b=a+YnuOBPByIVZdypIpwYg/J+5HO3IGDmIvB+QHd6p15JVYzNc2UH1NHxcoeWx0AwmrG4p22npf2sjXsXbmdmrVt5TRl3CENj5c0mEx7vForxGwzbiTgygqiHfeUjFu2u5BEVW4dUu9A7Nv/Op0K67uKR/pXaRdkLV2jhNkB6AaiUdC7qIwYHJGXmUINM4NtFjRWB+N1q313QledbBR/gipyk8NuqgsFBzNcOS16nhAtWiz2PCYJ2IB4Lz3AOFbLn+vTmrF9OkiIyWzC8lHgFfsQYpaJY7rYY5JnFUWlIpQlqPzdHzIzpdVI/LVQCvQJkrIKnD6Ru0sDXyX8Sc/YNQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4npcQQGgsVw+MeoRQkLpFIv10wMUwQoDQxLK8nA5cg=;
 b=a1uTOArJyTEM3Kx+SWH0fVRwlbHoEqjrWg7F5D9SXre5ZD0jUTTBgcZIQ/cqUY1YrjWRTrHtYBHsRfRV9EicgX+DZ9ibp60H47Rtof8hPjueD1q443Ozo/cyvqnb7IGHe+rH4pG99siX5GYRrkuB1Z3kIeIUOwcVV1xervZh0YY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CYYPR10MB7628.namprd10.prod.outlook.com (2603:10b6:930:b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Thu, 17 Oct
 2024 12:06:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 12:06:17 +0000
Date: Thu, 17 Oct 2024 13:06:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <6e0bef3a-6667-461a-80f9-791891e11d8d@lucifer.local>
References: <cover.1729073310.git.lorenzo.stoakes@oracle.com>
 <c083817403f98ae45a70e01f3f1873ec1ba6c215.1729073310.git.lorenzo.stoakes@oracle.com>
 <a3778bea-0a1e-41b7-b41c-15b116bcbb32@linuxfoundation.org>
 <a6133831-3fc3-49aa-83c6-f9aeef3713c9@lucifer.local>
 <84c0de17-899e-46fd-8b72-534d8a02c259@linuxfoundation.org>
 <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6080fb15-9073-461c-a87d-80e6daa326e6@lucifer.local>
X-ClientProxiedBy: LO2P265CA0116.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::32) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CYYPR10MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 7684cec9-fe3a-4414-f65a-08dceea41acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qsWanYwxdAKy0iJUYXoML6aCBsCfrUKtc6hOrPVKPcGddeLYuvKYn3xPPt5Q?=
 =?us-ascii?Q?7dkBug3SgrSt+dL+n7Vzxq6IfBMYXrpfGsAhjrf0knJYCIa2pSg154S9+vf9?=
 =?us-ascii?Q?FbCIUvdI6aET70SCjr/mE1sGOjngm0czurEodQ2THUcdu6f6oTpDfx2hbVCB?=
 =?us-ascii?Q?Gh9sGBt5+Qftbd5dhG92E/wKYR/kY2xNHQyJeFDws46JZGYpVGUUHN6mXryJ?=
 =?us-ascii?Q?Jhp2J6Qz02mcDZDx4F3TCV364t9RaN7sG3yn/76Wpj3zjYAGmR9ttSgdVn5l?=
 =?us-ascii?Q?55ooQy+vmSo/fHyFi58q7WqlkYxfumVt3Z0NqausjnBFPSA6phj40vAjuP8F?=
 =?us-ascii?Q?o3Hp4ExSzMiLxc0VZMcKZbXKiVVjxRiMwkQqA17pBBcGE/3ncPwEN0y7J3t6?=
 =?us-ascii?Q?tKRlKBj45uFLJNeHQEt1JFI+Lf1Qyw4CA/2EXSllGpsGcjCblbCJvYVaBujO?=
 =?us-ascii?Q?4mQdpYnmsq1Z1EokgH/0VEu4NSpW4ZPs3kVrnRfAuORAFINP60iG1o5qQv73?=
 =?us-ascii?Q?miLEFDxMIiCGxdOk5U1eshNwu0KoIoTV8F2xfMPVcHU6XYs8Tf3TNRXaVEWn?=
 =?us-ascii?Q?leGsYQUnTpZIbSXiKDgT06g2+TIGoRStal1FkO9zu2MUqXTJqZJUC3AtKoCC?=
 =?us-ascii?Q?gCxt3L6XR+4nrjOlVnhHL+GNijIVTJtd0sk2ds5Mm5DK5KjMX+mjy80dMWB/?=
 =?us-ascii?Q?p0xgj9uo0pgREcLNKpFiQszw89At9TBYFqYGaPAJ9QfY6UIsLnmQDfYltwpw?=
 =?us-ascii?Q?fsK4ntxi8hTUcWZyOGfWG4okYa3P0cgJJIcHB6rEfijKyOd2ZfcuNfx3yiXZ?=
 =?us-ascii?Q?G86Gh3IhemkY+E6VKposSQFdWA46FikG63zEXfC9Y6GrdnMJB787hfMfjrnN?=
 =?us-ascii?Q?hGsPt+2LIfCS0U0jBlNw0H8ZjHqmzVGvpThDo0Bk8xvpMr2e+kukCrOfXkAG?=
 =?us-ascii?Q?C6vt2PURg4PCwXKfMYNzLSmvQQK+uTIzMkSpFyquVemtKLFa/gPYKw29NJdo?=
 =?us-ascii?Q?jtrxj/Um+a+pD9taFTdoTQ7Yru5WQikvwiK/5sCA43B+PGIyhHGOeD3QQsAb?=
 =?us-ascii?Q?US/PNX4RJKhUTVddJ2j6i+Z1t/g3m+cCLkGYoX1lbAeOhBv9Ic/nJnj6pwi2?=
 =?us-ascii?Q?CLgiqq1ImDZcTyNXCevS9XsObunUbZ763vxNF3hCE/80xgNIGXenfTf9Wkgb?=
 =?us-ascii?Q?z/SBAjZELygUq9MAA+5Mm/JpeBxsFi6SC5vLkMqwEe59tztldq97jM0UMgK0?=
 =?us-ascii?Q?f2v5TbPB5hHBpn85EGUJmEckXpMHUndItHwTx7oo+brUvM4u9rELugksDSzV?=
 =?us-ascii?Q?zAtCccY5oKKo68xdgCMrivDA?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FvNLxnYp+xOzZ3XCrS8SFdtzTQP+Zc1ljufGsXvt2cR+vrigj5KHHWxLWP85?=
 =?us-ascii?Q?jvPUrnlPIzKzqUWH/B2mN9p7FdooO4Ls7VNahcaPD6ap3IvB1STcpZbcvYQj?=
 =?us-ascii?Q?nUlrCzH98brLO+WEq5YOuBjc645gV7Az/ssniH34v0i2rmAjYA7Aq5UgSUGn?=
 =?us-ascii?Q?FWo+hQJ5Tve2KQDtGojHCAVqbFlQk4Vfif7Zw57tsQApc4JEM9OFr5zB6xQP?=
 =?us-ascii?Q?uKQUsY6Vtwn5GzSuY8f0iAh7o4t6xppDi3IRdtIiYOF3t+R4a815vkH0Jiz4?=
 =?us-ascii?Q?qbAutXmLLXGbomd4dvvpAUcKF2YvhYnZmT9SSwRyaI1FPYH/QU/5L9YZ9RJg?=
 =?us-ascii?Q?bYNrhjpilMtnXabf4MYYsYaeAgerOyc9FLiPoJf5CfIONrVggIkhNL4qBl8N?=
 =?us-ascii?Q?sv0yKZplieZrIySiI9vJfs7IUUYyEfpJZTWehmrdi3TkS6F6o3l5aZTdJR1X?=
 =?us-ascii?Q?RMxgvyfaLolneNGzv+I0uX/oNTuI8xYlbXk1xX+tK8ztPmkSpRtzsjG2ysbv?=
 =?us-ascii?Q?eAtPmOSqmTujTSg8rlsKsB2dFLkCfUEMHgPQf+7Wo5VBBm0seKFdZsHMZjTq?=
 =?us-ascii?Q?IJ9GjgnzOdBtraZT91jCqBcEhvz8AC1vPhnI+WDijTSgp0GJRcYnh+3N1yPo?=
 =?us-ascii?Q?8D4s+c/KbtZVrXywaIwS/OmQ9IksdFI0BJskwxXzwADuVpm94lmWFuuEY2Hb?=
 =?us-ascii?Q?wQWCBXrNAGMT9h+nUTOqq3B7bfBLoFJDRn0icc3MOUOuelsgQZkek4Hpbbnk?=
 =?us-ascii?Q?RiZeKIIO+bIu8kIse8o4pzlJjvwQg+KoxMwq5JnjEXsd7cc6CXxmcdUD9Nqj?=
 =?us-ascii?Q?VSYJ32pCK4KlHH/E7Jl6jE+xI4HrJQR8MxDYjFKkp+yNqm2FNugyjEpy0NqX?=
 =?us-ascii?Q?D/9q7nyH7xJ06+mUO3S09jeMyFwGxwRgD/tYjgMouhFzr9QcE303IL6b1Vfy?=
 =?us-ascii?Q?tMRsvSBcrUXnvdfV8C7KpCGjFMshyttZ86/GuwA0CUSpKITSpOR9m/cPSgob?=
 =?us-ascii?Q?1+NtqeSXQGJunBFsApM7cgrq2+dQ4rZw7im6/TVlSxRJ3JoaCsnLVlwmXgR6?=
 =?us-ascii?Q?XsFp3rPKsu+2eoWf/tLD1tNailA0glAsbKYx0OLUR+4KTzT21NOY2bKzeK6j?=
 =?us-ascii?Q?H9P6K6yBRaN7ZMfPDX+iJ/5BiK+05uDe/ujnBV+q0ZJgiLdKUDOtEGq/H9Bs?=
 =?us-ascii?Q?bZ2IJCshAk5GsnVd1SRb0Oj+ukxKwPC0leaq6w/UzJE+ElBlQVVikezOOL0r?=
 =?us-ascii?Q?X5HVRS1wERQ8JxEI1lpn4vDeOFoLIujW1J0EBmHMFTY8CTnLz5nlLwOMlO7p?=
 =?us-ascii?Q?kNvN8ayxgf5Vygeat+joOywdojFZ1pjwscKXfydCeLcjkZ8GEOWJEipYPtLL?=
 =?us-ascii?Q?Y5QGjqvDrMjj39MWwXbvvmMi6VyMdVld6yalkh5oDK6+n4Ki92f/EshK+Qrj?=
 =?us-ascii?Q?ST6J1WBTIlUPb1snLLJQmTP14kE1RYqRirnjGTTn7crnIuvO04FI4WMiJUnv?=
 =?us-ascii?Q?tBETzt0a9jxvaZZGPaQ62p3QKOHFI5mAq6YMngkzUPjs5NeR4PkhCUjbhYHt?=
 =?us-ascii?Q?7VV38o5EWBTGpOOXxjnB7RDw4EidcF9QedCF4cRhh8Wk+VODsocUeuYmrLFc?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FuYSwWetJPMce8CR1bND3ujxBOWLfBEh+X2vKXxb6kS9Iyy3Gpcl03Z/L7swPR4bJ/+rauoP1L65wzZwDfKToK1v0G18QCIHeLmP+CwGDsd9uLzOCXpDBL6OFKgDYo7BKoobXYgEWt2kISjjCgp02J3cXKqjuahHhclK2M76sPqGVK42kkGiSny/go/Jz9/7286oCPV4K/WTQnhGWyqfdeQSvZzKro15uPqLR5/UsX+ArQqAuanUAkC6mtdO+fyYGEDFUuDeeFuRRwk3zaBo6oVwDZT7LcLPsL2IkgPT0x6bAtzfRqJtijk81CH9RG1rXu5vbjlxC+97CcainA/t4eCIYoICVRFVSxUpWZgzAvyZ7PjXa9/UNG93AYdVi9HeQTdpXqkPejDHm6F9WGZXMF7ghXAJkRukGYPCvoxo7lFHlayFXkIQuuludH6fGryaoHFhaSNSYXxwX3eI4ZDx/Fhf7vVbmyz0sVeB39szoGAljw7kwJLqrN6MlFE7Tgc5u0aBISQt8dsYsewpLmBYbkm3R7k+mTgLfC75SRA2Yd+yDnbFFb/kaE9gM48nath6IZw28MKdmlv4Txzup5pDxpvvvduQ2tir2j1BUJbU/Z4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7684cec9-fe3a-4414-f65a-08dceea41acc
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 12:06:17.2605
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ynOfDfl5wqS1F4he645TTWxenxtv+JqudJWNINRBP6VQzI2Ks692T7Rj+bfxS0IRqmfLXj4ODVvAuzBBM0BQiV3iytHV5MyaRBpEWgrG5s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7628
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_13,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410170082
X-Proofpoint-ORIG-GUID: ZiCATS1wdd1R9RA0ZITD807Vg1JjNGnp
X-Proofpoint-GUID: ZiCATS1wdd1R9RA0ZITD807Vg1JjNGnp

+cc John, sorry I forgot to cc you on other replies!!

On Thu, Oct 17, 2024 at 09:08:19AM +0100, Lorenzo Stoakes wrote:
[snip]
>
> In any case I think copying the header to the tools/ directory with this
> linux/fcntl.h in some way stubbed out (we could even stub out fcntl.h
> there?) is the sensible way forward.
>
> A 'just include the header' is simply not an option as it breaks the tests.

Ohhh ok I think maybe we could have a good compromise that should (hopefully!)
satisfy both you and John.

I can introduce tools/include/linux/pidfd.h that is a stub wrapper around
the pidfd.h file.

So it can be something like:


	#ifndef __TOOLS_LINUX_PIDFD_H
	#define __TOOLS_LINUX_PIDFD_H

	/*
	 * Some systems have issues with the linux/fcntl.h import in linux/pidfd.h, so
	 * work around this by setting the header guard.
	 */
	#define _LINUX_FCNTL_H
	#include "../../../include/uapi/linux/pidfd.h"
	#undef _LINUX_FCNTL_H

	#endif /* __TOOLS_LINUX_PIDFD_H */


Then the test code needs only to update the pidfd.h file to #include
<linux/pidfd.h> and add a simple $(TOOLS_INCLUDES) to the CFLAGS += line in
the pidfd self tests Makefile and we should be all good.

That way we always import everything in this header correctly, we directly
document this issue, we include the header as you would in userland and we
should cover off all the issues?

