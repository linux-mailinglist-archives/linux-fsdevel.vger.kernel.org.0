Return-Path: <linux-fsdevel+bounces-31669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D4A999EDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 10:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AF5F1C22EEA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 08:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304DB20ADEC;
	Fri, 11 Oct 2024 08:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noHfuk3d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZN8pFbtG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950A81CB334;
	Fri, 11 Oct 2024 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728634863; cv=fail; b=k0CUP1ZwWj5AXBzPLOBmABCstZJMz8AHwDW/lL6l/6a3ZSUpYm8ogMIFv/PxPt+DyYweDG0rCEHcIqGhJBdgoyoP4x+/dNxlOxKI1cOT22csHpBZdQ4HzGN6GPakXVW+3G9U761rw8LvD8m/2CueqWMEObeF2HxXeL2iH0cI2EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728634863; c=relaxed/simple;
	bh=tnYHkwi2KgcxB42vbhsUs516ThI2Ehxm+yzMqWLJLbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UB+8u7X30VwR13d0apMHohps9J9ZDn5TdGUMfUoMi4aCYXtQEAimAIrP8djz6MxBmVPpE4E5rnlU6wLQtZdmTlLI6sxn/TCHEWpnEcz2aVimxmFvRhjIHTTpZ6MhrkXg6VjGSXCII2mq7x/P/KdYSGrCUIKlGyKzk3P7AAUtKRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=noHfuk3d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZN8pFbtG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B8BePn030628;
	Fri, 11 Oct 2024 08:20:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0VMMBnqpKJmrRY6esZ
	2cnbWulZm5GJehcqKffdUXfd8=; b=noHfuk3d643igmQfvlBqm10hIhaLxezhWK
	ryM+82TTYMBZBUw4AIBiPY2q84BHpGmejujV32qqufll/ekS8pagLCuC0gwt8S7o
	eJgxQshqXftfWxft3fQLIoAkVweVu4uEQswZpsXYyvv8J9fSXgusFR/0WS8s9/Mj
	YezAC9LP0TWC+9HKL9QtGrbrqiOQb6+kVTR4rNSEk5madEsletgxCuBkzu+IK+1D
	Di59Cm8PbvMqsnxs8lQqihrHfNLK9RFHsDNoTnIo3FUAIR+L8jFWgtVP8xSFYxLi
	3tSm5fgv5SaESULbCHX2xieA41EzSOdnh60AnKq1O3xLNY7XkcNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303ymc4x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 08:20:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49B6qVls034343;
	Fri, 11 Oct 2024 08:20:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwb26k1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 08:20:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7lWk+R6wx14HHSJcnwMExPtoQhrv6HNf7ncyHHt8QlHLKFrdjheWiTyL9XIwJYcRfs65xiTPJb9UkhlzWdhZ/GLKYR6NfUMUFeyLjvxOTf+ACLxZ50OpRnQE5QYX8xLOC5TY9AwvNqqsDEksmqinz4+/A4NeHfNvdIQWSkYMnQBBmEgFkdSY0GBMuoF+P9cPTrg52xVaA5zQicM+J8JVFjL5TJcSKkCi8xlwtbaZZMHJ4AK3zfN6xk1zVtFWCJQeKlONPF6UOy9wnxALo9uk5VvGas8+GztrOlLjDTbI+ksIVeGxrbM9zcezH+oRr1+MyHsQpszcAUne6hDaslEIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VMMBnqpKJmrRY6esZ2cnbWulZm5GJehcqKffdUXfd8=;
 b=kIBwkIaJlMu6RGTRwWmbN+qkILVT7bnmgr6SlXbP7osIaU32I6TDMKMMofIFEjal1zu/GpqtUMPXVrmw5IpdbntP6m2Dsy7sU48MCNZKQrmDI3q4bj/2bSHJ8nb+Wf6MciSKfL960eRvNTQrMIHwPKkqnJk1+j1vBllBSgdAhgrZpxPcAWBH/wvmG8Hr6G+OA/QFOOcQ0EQaIb6SSYr8+MKwrdxzKCgRqJ3R49Uap6nIYyleGxCmTYGq+dkop2u6ne1yz9R8a6R+x4eWT4Yp8r3d6T3zkaDdgdT8GRVcN/TZ8quI+KRA+r39Tdp92S2J97NQLMV4NGn5yjasF3e6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VMMBnqpKJmrRY6esZ2cnbWulZm5GJehcqKffdUXfd8=;
 b=ZN8pFbtGh6j82ZuMflYCwBpU+FkCG+xK8tcEBVU0htA8MdauDib9MBpBbCylNlBhXvZ6foO833maxnQbZi9UJYGeXphzIfXEs3/Q1OjVra8lMPKuokpscC4mLcVZK1s5f6EsyNA1rqvJHxxhcSNzs3n1g/8Yaki2jRhqyqmyGOA=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN0PR10MB5935.namprd10.prod.outlook.com (2603:10b6:208:3cd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 08:20:39 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 08:20:39 +0000
Date: Fri, 11 Oct 2024 09:20:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: pidfd: add tests for PIDFD_SELF_*
Message-ID: <71221c84-7721-42b7-add4-269a1f25c478@lucifer.local>
References: <cover.1728578231.git.lorenzo.stoakes@oracle.com>
 <8917d809e1509c4e0bce02436a493db29e2115b3.1728578231.git.lorenzo.stoakes@oracle.com>
 <1d1190be-f74f-45ab-ac6c-2251d0bec1bc@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d1190be-f74f-45ab-ac6c-2251d0bec1bc@linuxfoundation.org>
X-ClientProxiedBy: LO4P123CA0462.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN0PR10MB5935:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df5aa56-de5d-44de-93cf-08dce9cd9710
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c2PmllvNDKBuVstKRZ1WG3Kpo+O2qICBr9/sDK/R5XQ0EWB7KubMfGIGej17?=
 =?us-ascii?Q?mpn3JuJGupWZcglWyv1Q/LtN/RXBGARNzKugPk4owz1pOxbtOPDLmww5rdQP?=
 =?us-ascii?Q?zFfxz97a0mKYeYnbpnCgAVddhKPrAYQh2kP2pJMsrCbj93sfZxJyXKbzL3BZ?=
 =?us-ascii?Q?LCkVgwuWtG7dA5ZPqyK6YDhy+e/BeJOjGvp38CpISVegBeGofqZy/DzftRih?=
 =?us-ascii?Q?YGH2DQ7AQUStBJEziJdsvp9tHCE5VBUN6eTyA3x0CcvDO2eG/7xqKdKWiwBE?=
 =?us-ascii?Q?pHuasXNzNoCuw5PhRd0Gzrpy36/vG+pPp+BeGm5h9Kj9t8B1f2HRNtKNmpXH?=
 =?us-ascii?Q?pkcSQg+4r/8QX2iADAeCjj5URvjqfpAH49oexV/OZ7D/s73oBqdQaulPNTkM?=
 =?us-ascii?Q?LptEJj6D1FQJupswinn+pJq+TKYJ5AFC1o0iQF0SCrQ3mp1rxE2J6X3/2MIj?=
 =?us-ascii?Q?QvXPj3bPmtloXBQBxmUU7lxlPm6ylQhvtsj9KzekQjvsqs2SfzjNZ0/m3Ssb?=
 =?us-ascii?Q?uhOgpTkcnE+5HxFgxf4QfHSJ1riDXNXLbuWuKL5DEggsIkDMzClzQtQ3l42N?=
 =?us-ascii?Q?mm5YXJiSgd7lfkU8//tAwxmTUsRz8CkBLyDBr/11LVEDVXSfj+j/j8599eqe?=
 =?us-ascii?Q?26SuWl1uNtOBEdfmo9XBPyDsO9ZL7y39W01YlkUDM0zGlEg3oTCxIbGork1h?=
 =?us-ascii?Q?j4xCXjcsSW2yXN8mYAYmEVXhBgu1cORxZOQSI3sgOcvn//wCPdSawfJOal2N?=
 =?us-ascii?Q?UTK8K700teQvNNrJ+I037IkoaUqwUhzyQhXolCfsSonBdkxT8XF4Zl4LQCiq?=
 =?us-ascii?Q?OJqfx35NLExLYjcedCa8OTMLGAJ1u2IKXt0YYwE41S4YWTBm5TXmBkCp98tB?=
 =?us-ascii?Q?LAS/BceIVL9+C/c+Gz6CwB9dORua6m8BDoSkHuXgypDTOdL0T9JqVnw9lrjX?=
 =?us-ascii?Q?WRU3Y4/KzEBEHXM8fUsBi+YiubcR26iQdTXqTVVePoID+el0h38T1i8TfTfc?=
 =?us-ascii?Q?5reKtlFtr6f8Gcm+RiVCyvkmngDBXxRj+w1JF7tzON9aVIrOpf7Pv7XfTJxV?=
 =?us-ascii?Q?bEjFFmP6QLpKyK+T6XEyrUSDl94hwB9usA3FJQF8I3l6y4/8+KVxwRlqIv0+?=
 =?us-ascii?Q?t6u46XEenY9mHxASGiX46C5ydXeawUXReYCZbz+DFtnoRTtqtk8YcxFObMA+?=
 =?us-ascii?Q?j4JVcxFZd/9JyPCXg/h9pbsTJAremHMkp56vekh9kZIlKh33zrLlIN9BKZUo?=
 =?us-ascii?Q?Cxzpj6SyU4Ar49Ioqwd66WgPd0o6hB5DLwIZCL59/g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6b6MP+cQXXH3RZT6JmN3sEoKxabfqAvcTO9avRFyTigSqs9Cfu7wYIav+Zaf?=
 =?us-ascii?Q?y8VRqptioYMZCT5UhxryEZ36xISb8cw2NhqRSt5oP73gqYPLXBE72mq6FuiB?=
 =?us-ascii?Q?c6BGpxQiYDShv2NC3yWS5wz0BZdrSDPBFLbjqXO50hDvg2TiyORnidAed7VV?=
 =?us-ascii?Q?VX8b1AIgUnDvTwifvAVgx99UZkg6zpD5RuPiGNK5ATTS8fvJlLWD5Fpie3m9?=
 =?us-ascii?Q?CHh2oAK2FayksxTuHla3RiqiRuy0LI6pzZs4Yv+ZTkBuXMde1xzHEz+R3tNi?=
 =?us-ascii?Q?rG/n0O1XJjNV85Ev2kS2k6vtnqXqsWMaqF2g/Bj5gYqa9y9TvOI4UVgX5FDk?=
 =?us-ascii?Q?UV70+qTbS18FpWtr6xFhuHEo40rCDN/SSJT5lmQqj9f3S0LlM5T3Em8nUe7i?=
 =?us-ascii?Q?OPsTXVvbXPqWQsLUmO2U3tx3qMe1lnmJB55YtkjKQ3dxRbHxuW437wJ1iEln?=
 =?us-ascii?Q?9yuJRYN484xeRNk9K63xqQ0UGfOX6mBQMsNNJdDU7TEYskaRb2XeLxTu6mk/?=
 =?us-ascii?Q?DTs3w6EKdiPjzm26k7jYh8uJwotWrd3/tQoWIYsaYRmbMrnzVyOjxAbCr/Bd?=
 =?us-ascii?Q?TaylTMhbvfaVl3TSTvJdsn3Gck3HYkKxxueidT89Styhy9IERQ6p3Q8qJNr8?=
 =?us-ascii?Q?8WuqDQByYBUNI81IxXmesJdVhic5U3dqVYpfhe2HQW2bD3D4QUYhv5bjrPvS?=
 =?us-ascii?Q?aczrlMp6c8N5+YvdF4X5VcuxumR4HGQpkxVy3WkGk1PJbw8nihOoCAcIfVtM?=
 =?us-ascii?Q?l/n/5N9FNwtftdmFOltcqdNhRgNeUTFQ4iPa/tTCT52ty/iRkXtWOiboGHwc?=
 =?us-ascii?Q?0AKUn/xZhA6kjH5d1QAFR11KPXjW/CKukHC2YlQpuESrz+ZxYYDStFFpPr3c?=
 =?us-ascii?Q?bbdBHlRtoy1qLpbidEEJv/HvQD9a/V24abTp+Wt8bfPrT2xJmQb1quP4DP/Z?=
 =?us-ascii?Q?fu7S0oZCawQPo65APplLrocmiIKPsrZMou7T708ShadTpe4hLEb5ZJHC0lGL?=
 =?us-ascii?Q?o5nyVLH4IIqWC9K14dK2FoS5lhhOrvTz/PkLBUzZhrFEcpIW+gAlv4YJohvl?=
 =?us-ascii?Q?zUCyxUSr8j0I0LLAgJl55W+WjwMoCAc3s4IVMFCf64RUDaYSfpBTiyWO9rPm?=
 =?us-ascii?Q?m9q4rTP2c8sjEpYKxn7CiFDUj4xLEWqz8qFJE7AqatNxk0kWQYebcOM+J7h7?=
 =?us-ascii?Q?Bt0RP/rQXYO+FbrpG2BWUjFfLEj+pgmfgqbSBo9jCZSybXzY4arOyK2qkr9j?=
 =?us-ascii?Q?l8r4bLZ/Qd3b31j7lfFfVwhlfLYKHXoqnWmUnPeIx8xBoy4LPiO+I6kKiYwr?=
 =?us-ascii?Q?gkCrL99HKYtWZNVLq0BdHWxe/oLcf1nNqeXezX+BHFnejzZmYKSjFAbrzV4c?=
 =?us-ascii?Q?38WwkXwtUq6g58VcbNS833O+4ozQMyZBUpoVyeZdfEq9fezKPH5njasEgRAg?=
 =?us-ascii?Q?DKZEXEMPtAFOrJnOpCNJfeOWakxtSj4eDvbZ4Q8Vb5bmN+tVaYNVFBISm0cO?=
 =?us-ascii?Q?s21NFTGJ721f8dnji6rCW1DOoDUEXWiqs1hC1shGbQiH+1R0pdVQnIqXQQfh?=
 =?us-ascii?Q?NCtM46RuofR6orekNnXGpO8myc61+V3ysoIPV74pzHMWQGneYHydyJkaenHf?=
 =?us-ascii?Q?IQNEopHgH7vabtffMpqgwdhu9GgjL6v19989iYVByAaxwCjbrN22mN9RD1+3?=
 =?us-ascii?Q?fGaX+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xmGTL0nNif1UOk78kAjalaN8Un5TLO6kjB7qp/5Hcdvn+0BDMa+ste612JGuo0vJ+4ZEscueJPR2zBK5cIMqDfOaXaza/KDfFLuRuO5Xl7jlF9cK1ZOfvTvl4MdxvLsE9mFz4POyP+/NxJGvDzmdRU3zF/UfUVTOvNA1iSektxV00hQAG4W5XBOjqL3FcoyuqO6JJKVw6LB3hHGuY9vv0efMobk7CZYoidrvAtv0lFIhUsXGv+ZAuuPzew93BerX9A8LG0Van5EBwkX8WlHNjrX7dUfo7B7JW6k1AVpNS9kMF0AAweFPLDMJuuluNfRk9F9MFfzrm/AQN/dJAPgP0vIFo2ssemuwIcTzZlIwly1EEhTzecYtmQcOnGROFX8SA54hk4HOzNnPibczPQpQfuvVWDMTxUYiwoXRXa7GZCi0urmvM+jB222n5gjM4iMnMKGT7bXAMyXK5hPpYDKItSmWPMumkvBaYxmiQeIRT5NAUm5b3yRaFH1eCARAe5d+tDO9hs73ETbMra68w/0hpCzvLQlC1xp1owDbFCYHEtBc22obnZ6su3Hn59ZvUXGPgXFzj/PeguiQ+Pt1NuqwnPPaCsVEhOXSwqJksacBOks=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5aa56-de5d-44de-93cf-08dce9cd9710
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 08:20:39.2838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uz0/5uyGoCna1GMT9RpAIsqebhPOFLJvKdkF4Ip5lvUt6G6/QZqo5FjdyhBBLnk5cUTWPQD9oJgSfcOXmTFj0f8ytU5fwJr7kw/xtJ7eYWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5935
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_05,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410110055
X-Proofpoint-ORIG-GUID: rRt3FzlTzpbdFAQXdm4iabYd38GEfnyw
X-Proofpoint-GUID: rRt3FzlTzpbdFAQXdm4iabYd38GEfnyw

On Thu, Oct 10, 2024 at 05:16:22PM -0600, Shuah Khan wrote:
> On 10/10/24 12:15, Lorenzo Stoakes wrote:
> > Add tests to assert that PIDFD_SELF_* correctly refers to the current
> > thread and process.
> >
> > This is only practically meaningful to pidfd_send_signal() and
> > pidfd_getfd(), but also explicitly test that we disallow this feature for
> > setns() where it would make no sense.
> >
> > We cannot reasonably wait on ourself using waitid(P_PIDFD, ...) so while in
> > theory PIDFD_SELF_* would work here, we'd be left blocked if we tried it.
> >
> > We defer testing of mm-specific functionality which uses pidfd, namely
> > process_madvise() and process_mrelease() to mm testing (though note the
> > latter can not be sensibly tested as it would require the testing process
> > to be dying).
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   tools/testing/selftests/pidfd/pidfd.h         |   8 ++
> >   .../selftests/pidfd/pidfd_getfd_test.c        | 136 ++++++++++++++++++
> >   .../selftests/pidfd/pidfd_setns_test.c        |  11 ++
> >   tools/testing/selftests/pidfd/pidfd_test.c    |  67 +++++++--
> >   4 files changed, 213 insertions(+), 9 deletions(-)
> >
> > diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
> > index 88d6830ee004..1640b711889b 100644
> > --- a/tools/testing/selftests/pidfd/pidfd.h
> > +++ b/tools/testing/selftests/pidfd/pidfd.h
> > @@ -50,6 +50,14 @@
> >   #define PIDFD_NONBLOCK O_NONBLOCK
> >   #endif
> > +/* System header file may not have this available. */
> > +#ifndef PIDFD_SELF_THREAD
> > +#define PIDFD_SELF_THREAD -100
> > +#endif
> > +#ifndef PIDFD_SELF_THREAD_GROUP
> > +#define PIDFD_SELF_THREAD_GROUP -200
> > +#endif
> > +
>
> Can't we pick these up from linux/pidfd.h - patch 2/3 adds
> them.

We're running this file in userland and it's not obvious we can correctly
import this header, it'd be some "../../" thing out of the testing root
directory and might not interact well with all scenarios in which this file
is built.

Also the existing tests do not seem to try to import that header, so it
seemed the safest way of doing this.

>
> >   /*
> >    * The kernel reserves 300 pids via RESERVED_PIDS in kernel/pid.c
> >    * That means, when it wraps around any pid < 300 will be skipped.
> > diff --git a/tools/testing/selftests/pidfd/pidfd_getfd_test.c b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> > index cd51d547b751..10793fc845ed 100644
> > --- a/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> > +++ b/tools/testing/selftests/pidfd/pidfd_getfd_test.c
> > @@ -6,6 +6,7 @@
> >   #include <limits.h>
> >   #include <linux/types.h>
> >   #include <poll.h>
> > +#include <pthread.h>
> >   #include <sched.h>
> >   #include <signal.h>
> >   #include <stdio.h>
> > @@ -15,6 +16,7 @@
> >   #include <sys/prctl.h>
> >   #include <sys/wait.h>
> >   #include <unistd.h>
> > +#include <sys/mman.h>
> >   #include <sys/socket.h>
> >   #include <linux/kcmp.h>
> > @@ -114,6 +116,89 @@ static int child(int sk)
> >   	return ret;
> >   }
> > +static int __pidfd_self_thread_worker(unsigned long page_size)
> > +{
> > +	int memfd;
> > +	int newfd;
> > +	char *ptr;
> > +	int ret = 0;
> > +
> > +	/*
> > +	 * Unshare our FDs so we have our own set. This means
> > +	 * PIDFD_SELF_THREAD_GROUP will fail.
> > +	 */
> > +	if (unshare(CLONE_FILES) < 0) {
> > +		ret = -errno;
> > +		goto exit;
> > +	}
> > +
> > +	/* Truncate, map in and write to our memfd. */
> > +	memfd = sys_memfd_create("test_self_child", 0);
>
> Missing eror check.

Ack, I had to rapidly change this code to not use the ASSERT_xxx() stuff
since abstracted out to helper function for pthread() to invoke and clearly
did not do so carefully enough :) thanks for pointing out will fix this +
other issues.

>
> > +	if (ftruncate(memfd, page_size)) {
> > +		ret = -errno;
> > +		goto exit;
>
> Hmm. you probably need scoped cleanup paths. "exit" closes
> memfd and newfd which isn't open yet and sys_memfd_create()
> could fail and memfd doesn't need closing?

Yes... oops! Will fix.

>
> > +	}
> > +
> > +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_SHARED, memfd, 0);
> > +	if (ptr == MAP_FAILED) {
> > +		ret = -errno;
> > +		goto exit;
> > +	}
> > +	ptr[0] = 'y';
> > +	if (munmap(ptr, page_size)) {
> > +		ret = -errno;
> > +		goto exit;
> > +	}
> > +
> > +	/* Get a thread-local duplicate of our memfd. */
> > +	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD, memfd, 0);
> > +	if (newfd < 0) {
> > +		ret = -errno;
> > +		goto exit;
>
> Same comment here - "exit" closes newfd

Ack will fix.

>
> > +	}
> > +
> > +	if (memfd == newfd) {
> > +		ret = -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	/* Map in new fd and make sure that the data is as expected. */
> > +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_SHARED, newfd, 0);
> > +	if (ptr == MAP_FAILED) {
> > +		ret = -errno;
> > +		goto exit;
> > +	}
> > +
> > +	if (ptr[0] != 'y') {
> > +		ret = -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	if (munmap(ptr, page_size)) {
> > +		ret = -errno;
> > +		goto exit;
> > +	}
> > +
> > +exit:
> > +	/* Cleanup. */
> > +	close(newfd);
> > +	close(memfd);
> > +
> > +	return ret;
> > +}
> > +
> > +static void *pidfd_self_thread_worker(void *arg)
> > +{
> > +	unsigned long page_size = (unsigned long)arg;
> > +	int ret;
> > +
> > +	ret = __pidfd_self_thread_worker(page_size);
>
> Don't you want to check error here?

We check it from callers, and it is passed to them we can't assert here as
we're not in a test.

>
> > +
> > +	return (void *)(intptr_t)ret;
> > +}
> > +
> >   FIXTURE(child)
> >   {
> >   	/*
> > @@ -264,6 +349,57 @@ TEST_F(child, no_strange_EBADF)
> >   	EXPECT_EQ(errno, ESRCH);
> >   }
> > +TEST(pidfd_self)
> > +{
> > +	int memfd = sys_memfd_create("test_self", 0);
> > +	unsigned long page_size = sysconf(_SC_PAGESIZE);
> > +	int newfd;
> > +	char *ptr;
> > +	pthread_t thread;
> > +	void *res;
> > +	int err;
> > +
> > +	ASSERT_GE(memfd, 0);
> > +	ASSERT_EQ(ftruncate(memfd, page_size), 0);
> > +
> > +	/*
> > +	 * Map so we can assert that the duplicated fd references the same
> > +	 * memory.
> > +	 */
> > +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_SHARED, memfd, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +	ptr[0] = 'x';
> > +	ASSERT_EQ(munmap(ptr, page_size), 0);
> > +
> > +	/* Now get a duplicate of our memfd. */
> > +	newfd = sys_pidfd_getfd(PIDFD_SELF_THREAD_GROUP, memfd, 0);
> > +	ASSERT_GE(newfd, 0);
> > +	ASSERT_NE(memfd, newfd);
> > +
> > +	/* Now map duplicate fd and make sure it references the same memory. */
> > +	ptr = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> > +		   MAP_SHARED, newfd, 0);
> > +	ASSERT_NE(ptr, MAP_FAILED);
> > +	ASSERT_EQ(ptr[0], 'x');
> > +	ASSERT_EQ(munmap(ptr, page_size), 0);
> > +
> > +	/* Cleanup. */
> > +	close(memfd);
> > +	close(newfd);
> > +
> > +	/*
> > +	 * Fire up the thread and assert that we can lookup the thread-specific
> > +	 * PIDFD_SELF_THREAD (also aliased by PIDFD_SELF).
> > +	 */
> > +	ASSERT_EQ(pthread_create(&thread, NULL, pidfd_self_thread_worker,
> > +				 (void *)page_size), 0);
> > +	ASSERT_EQ(pthread_join(thread, &res), 0);
> > +	err = (int)(intptr_t)res;
> > +
> > +	ASSERT_EQ(err, 0);
> > +}
> > +
> >   #if __NR_pidfd_getfd == -1
> >   int main(void)
> >   {
> > diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> > index 7c2a4349170a..bbd39dc5ceb7 100644
> > --- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
> > +++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
> > @@ -752,4 +752,15 @@ TEST(setns_einval)
> >   	close(fd);
> >   }
> > +TEST(setns_pidfd_self_disallowed)
> > +{
> > +	ASSERT_EQ(setns(PIDFD_SELF_THREAD, 0), -1);
> > +	EXPECT_EQ(errno, EBADF);
> > +
> > +	errno = 0;
> > +
> > +	ASSERT_EQ(setns(PIDFD_SELF_THREAD_GROUP, 0), -1);
> > +	EXPECT_EQ(errno, EBADF);
> > +}
> > +
> >   TEST_HARNESS_MAIN
> > diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> > index 9faa686f90e4..ab5caa0368a1 100644
> > --- a/tools/testing/selftests/pidfd/pidfd_test.c
> > +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> > @@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
> >   #endif
> >   }
> > -static int signal_received;
> > +static pthread_t signal_received;
> >   static void set_signal_received_on_sigusr1(int sig)
> >   {
> >   	if (sig == SIGUSR1)
> > -		signal_received = 1;
> > +		signal_received = pthread_self();
> > +}
> > +
> > +static int send_signal(int pidfd)
> > +{
> > +	int ret = 0;
> > +
> > +	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
> > +		ret = -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +	if (signal_received != pthread_self()) {
> > +		ret = -EINVAL;
> > +		goto exit;
> > +	}
> > +
> > +exit:
> > +	signal_received = 0;
> > +	return ret;
> > +}
> > +
> > +static void *send_signal_worker(void *arg)
> > +{
> > +	int pidfd = (int)(intptr_t)arg;
> > +	int ret;
> > +
> > +	ret = send_signal(pidfd);
> > +
>
> Same here - don't you have to check ret?

As in the other case, we check that in the caller rather than here. I will
add a comment to both to make it clear that we intentionally forward the
error.

>
> > +	return (void *)(intptr_t)ret;
> >   }
> >   /*
> > @@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
> >    */
> >   static int test_pidfd_send_signal_simple_success(void)
> >   {
> > -	int pidfd, ret;
> > +	int pidfd;
> >   	const char *test_name = "pidfd_send_signal send SIGUSR1";
> > +	pthread_t thread;
> > +	void *thread_res;
> > +	int res;
> >   	if (!have_pidfd_send_signal) {
> >   		ksft_test_result_skip(
> > @@ -74,17 +106,34 @@ static int test_pidfd_send_signal_simple_success(void)
> >   	signal(SIGUSR1, set_signal_received_on_sigusr1);
> > -	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
> > +	send_signal(pidfd);
> >   	close(pidfd);
> > -	if (ret < 0)
> > -		ksft_exit_fail_msg("%s test: Failed to send signal\n",
> > +
> > +	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
> > +	res = send_signal(PIDFD_SELF_THREAD_GROUP);
> > +	if (res)
> > +		ksft_exit_fail_msg(
> > +			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
> > +			test_name, res);
> > +
> > +	/*
> > +	 * Now try the same thing in a thread and assert thread ID is equal to
> > +	 * worker thread ID.
> > +	 */
> > +	if (pthread_create(&thread, NULL, send_signal_worker,
> > +			   (void *)(intptr_t)PIDFD_SELF_THREAD))
> > +		ksft_exit_fail_msg("%s test: Failed to create thread\n",
> >   				   test_name);
> > -	if (signal_received != 1)
> > -		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
> > +	if (pthread_join(thread, &thread_res))
> > +		ksft_exit_fail_msg("%s test: Failed to join thread\n",
> >   				   test_name);
> > +	res = (int)(intptr_t)thread_res;
> > +	if (res)
> > +		ksft_exit_fail_msg(
> > +			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
> > +			test_name, res);
> > -	signal_received = 0;
> >   	ksft_test_result_pass("%s test: Sent signal\n", test_name);
> >   	return 0;
> >   }
>
> thanks,
> -- Shuah

Thanks for the review!

