Return-Path: <linux-fsdevel+bounces-22664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E09A91AF06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 20:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B18EE1C211D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 18:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDE719B5AB;
	Thu, 27 Jun 2024 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NsMjqisx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KBoAIAEg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BF619AA5D;
	Thu, 27 Jun 2024 18:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719512758; cv=fail; b=IHOBBtvThBFRrnaMt7mx7mfutNmSOggyrwPz0xCde7PxHugA2xPtFoQZkSRF/95aGFLS5AnDGJ0KwhYraoaMe/yqsKw5kkn5trM8/Q1uPRRtC/JZHC+ZlwXWtaeptLnAFWzT3E/C+UNbaeCLcHFEVlP8R+VfIdrkJuukv3q9Gt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719512758; c=relaxed/simple;
	bh=TJQfgvPlMfHySo3GRausDPl5fAmZYFbgvvFDNiRCOL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dC3y0Jl/6xZ0HINcf7b1OSXMMq9ChmMsqYgKGoqp6YOfqGP/DBe5dLhYk9ZQT2IHtZdvbA5tMv8KXV+g2xvy4KGH/gx8AHkNYN0v6T2zPdvAmIK8O5K2i7EhQh27PVC5u5e+cR9a8NLYDkZTfK9VqDTEUi2HBA1RUFnWm0CQSvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NsMjqisx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KBoAIAEg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RFtYB3016721;
	Thu, 27 Jun 2024 18:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=Y2NtDR1yu3MgIff
	cO/hVs1zwFPy+e+Nf1FhFP7u9Fos=; b=NsMjqisxdFv0h6ENUMMjNpBCjcyXi4r
	czsPvaHJDX5xzM2V6ozuzpeeqiEjTQ3CE9K5xKp4YkfiYA7/0EmokOfvAdh8ReeA
	BHSgvKdCKCIFNCg9C4xDOXWRrmFqV5EUhPgLyhOv8QZV1RretjMrEEq+p+MrjCiw
	VDZ/D5hFAHrvHb+37vLkHlBVhHGUltVUvpsaUwyVNRqH7oytjeMmO1WOxMP8WXiW
	qCkVHWnUfMpD+Z2XyfHAJ7Il4oPLCXODPpUq6HMJy3U2bx8g5aLsWM3U44TCLHtF
	Acy4RRTnbK3yz1im270ABKa0lAFqyRf3x+LYlwaUjSO1244Y+a2meNw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb6s4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 18:25:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RIHGDL001314;
	Thu, 27 Jun 2024 18:25:42 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2177.outbound.protection.outlook.com [104.47.73.177])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2bga9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 18:25:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py6kyTkxO8pa6z/f6MH8xisjU2CEx/b7I66U+5uBwatVwfjKM25TP5dV3dpWnX/H3eSoEmz777lI27FwcC0iDmJbSCQjm14IrhQk78RXuNhCd0DZcYzpv/Epqf+2c28IbPG3DAm02GVjKKaa/+A00Gbpyi5hpAmZzsLUXiy5rFeh/lNCY0EMEtvhSnYdwtYvC+5VLPtuDrZTfHE4qb3w5KvYr0iFhRHQtC8iMLhcK+YiuOv6pdWEOssP+kvxwqL+voGx/zb6fiiQwym0ZMqWzUH3KqKOpvWwddFHGCsAFZVUoXinPTtAa3iSlOfjsShfmVsQWS++qibOvHxkZxxeXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2NtDR1yu3MgIffcO/hVs1zwFPy+e+Nf1FhFP7u9Fos=;
 b=T+g9Q8M8A4db9NRUyK/C3oe3EVOqnKREGnfmox5P/X3fqELgtfte9h2fro7jWEKnjuOtdZiBDc+6j+3p42/SwuQgLlHa52TmMFrB7q9GpgkyfpTpZjUlFpOTei9dt9BAknBSiVo+w6V0p8w1G2ybBnQ2bg2x+utxMR6xBSZI7ZgaP1/SuhlugsxZkhljHhaNwyH3b+59+z7hq2dnwMCiyskLzxNNVJZLVXROeZtQfdeTwTXv0xnCvVu0SXrKxG2YgBhkrwLxaogOKw2siiJBZj1t7j2xh6uRzC1UPwzQwPhLPWa2kOE1Zb/uPZjFJQjfxxdT4NS/xprPHfORdcMKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2NtDR1yu3MgIffcO/hVs1zwFPy+e+Nf1FhFP7u9Fos=;
 b=KBoAIAEgLo+Qo83qDnAdEBjBtAON5ExR7orfffQxVki/gxK2Zp+LJ8JXGWWdpHGqgea67frlQUFve55MTwavwcJics5eczIXiQhnTjmA86StQ8QukwMYqvLxDVl7ilC2QGGL4H+y7fM2NI3xDKTfbRXBidotBk6H56jROaX/ul0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ0PR10MB4765.namprd10.prod.outlook.com (2603:10b6:a03:2af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 18:25:39 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7698.032; Thu, 27 Jun 2024
 18:25:39 +0000
Date: Thu, 27 Jun 2024 14:25:36 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 7/7] tools: add skeleton code for userland testing of
 VMA logic
Message-ID: <5zuowniex4sxy6l7erbsg5fiirf4d4f5fbpz2upay2igiwa2xk@vuezoh2wbqf4>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Kees Cook <kees@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Eric Biederman <ebiederm@xmission.com>, 
	Suren Baghdasaryan <surenb@google.com>
References: <cover.1719481836.git.lstoakes@gmail.com>
 <22777632a0ed9d2dadbc8d7f0689d65281af0f50.1719481836.git.lstoakes@gmail.com>
 <202406270957.C0E5E8057@keescook>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202406270957.C0E5E8057@keescook>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ0PR10MB4765:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2d7876-9c92-4645-b8b6-08dc96d68c02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?T4uq48wPsYk83pWEkKU9ve4CMmIndaZfV9FOzEKL/gfMxrZQRAoDizbca/iO?=
 =?us-ascii?Q?xtZV914+tdYvCQyQ1d1c3m/yCbVXohBPBSafBqhsP6ozgDUTNmtNX1EHHCI3?=
 =?us-ascii?Q?p54uxIdJs4kt5ZXkDr4h6XE+3Iltyjjn0URWQaeo1MTwmDPrjDd/1I7OQOz2?=
 =?us-ascii?Q?MLV8ZQJ9yKY3iaLK+vRhY40A260XMq1uiSlIoLm82/DXUZSZCAhZAef7d/CK?=
 =?us-ascii?Q?Ok+bbMTmo8JJ1eux75GKbZDLKjqJcQ8tXas4HOvccRVnCbNGr8BArEoN4Abm?=
 =?us-ascii?Q?wr4haSrymUjwdACMqoh/kbKqkPWsThhaTLwbN+5MKRH8bjCk49QXCTkzdRmL?=
 =?us-ascii?Q?UhawAQpdAr/w6loPyVklJVTPLCKTiMBqAR5gSJRouvWShAuJ5ie891XWvebE?=
 =?us-ascii?Q?EEZpWZFKqWSwQNHIcLtEkuWdxLOYT3RLoZ+H0Dbaov2597/am/w0Drbm2ktd?=
 =?us-ascii?Q?8F+L3A2Hr67XJk+3Wvp0Crp8nZzQXmHsXJbdoEnOz4gGY99zIb/aeNH0WXXC?=
 =?us-ascii?Q?7rjfztzVEyNsjjLaE6TieAlPOpQ1ksGjbm7sCQ4fFO+vFM/IRuOy8baIJUqb?=
 =?us-ascii?Q?97ST9b/oNQ/CqxEz4Te8058bY5y6rJ4TsCkS8QqlAmbfs9qsFu/HHmi/7B6H?=
 =?us-ascii?Q?EmgKicX9CFwxHWf1S4VscVKzfXhfKjWOj45GLkH8rMrsuE9WjrQPIxgpBu7z?=
 =?us-ascii?Q?OwsaeORoKHuJSmoceNe2VJb96jhIaWVFLw+h0344fubKNJg4zSpHav6Yi4He?=
 =?us-ascii?Q?DYkKWBSrB6LEtUXZay73c9wyUrCL5siIqdJdUD793VzQ2f7f0XmLNIv8+y+v?=
 =?us-ascii?Q?ZTCxEebCLb/nxouEsPTVoYSsLazuoLuA/4f73m/ojzNaajguxHvfaC2P3tXA?=
 =?us-ascii?Q?2TFU95HgNYPrUHrPqSqS8P1VTUvB/gHwlyxkzae1oqYcw04x2rjANBpTz794?=
 =?us-ascii?Q?veij2yHzpk8rVy+NvhXk6md8hfw2mvJ1Da3qGnjxNwUDXMQGDTaKwZ8pVkvA?=
 =?us-ascii?Q?niLFCYDpDKInJ6af6VYGl3IBjAkE8mFWrfoq8PKZd/26msNbxKm/V89M53jy?=
 =?us-ascii?Q?U64qgCOEJOPcTHx2e22ZJYnhPTjAEMQZ0+K1LLUwSZXUbGbyNEXvcdT8pxlX?=
 =?us-ascii?Q?sOPYCCG6OWxS7zyWh7V5Y4D2s/vXIXVWyq2jH1s7/knZp+dn9rrM2fvbCecP?=
 =?us-ascii?Q?XaqsVSqzbBLLwZQP0sQ1HwpHk++E0KxKuk0aKBAKg85fwbEECPZwlV7m1mtX?=
 =?us-ascii?Q?ZTjMXTUTtjPvFndGTiplFsuENOGowzZfkoM2YippOXrkNKA3hILH5WJOyWSA?=
 =?us-ascii?Q?qpc9KuLV5gHjsp8BJhnyeXf4cuCO4nz0gJErVRwp959c5A=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9YoLPx3FNODYSnyxHropSy2g0y0K6Z34jSmqgcTDs3/FMLYzXRI3DoFsIP9r?=
 =?us-ascii?Q?mhm2uwA1cn4q2IfZsMmY9o61NgOygrprtIdpIJVuUzo5B0dd1OYKcWpS3YoA?=
 =?us-ascii?Q?qFbDDpHPuaPgyn/pLsVxHStpuzkXPgDg2T4cm4l7ZCoweX56Mvvr8WGh0lOP?=
 =?us-ascii?Q?UyPdsiVyoEzvdee2/1ffDwPsPmzTXT4cY0YLy13mnP3TmDWR0vF+0DY1UHJt?=
 =?us-ascii?Q?MEoh/AjEQrFlAMHtcKlFhigLsYl5Yg1UKjUyh/OA59rw/8v3BMmXICICp5Q1?=
 =?us-ascii?Q?CCpyCKun77arSxaO213tVV4C0Qj0zRSmCQ+8cJBtHPr9AUkOs3aH5VX5s3gf?=
 =?us-ascii?Q?LSdEGY4Ei9h+hTj457H2H+YiCRYIOFjnCKnR9PfnsyVBWsKAXV1uGxiQ6Oms?=
 =?us-ascii?Q?i5GSu4VO+AFnLccLhzqF+4HaKvhsaPSWsJiYKSUz/Dmnb5v+62RS0QggVZsg?=
 =?us-ascii?Q?fe5G23fpa1LLPypP5ogQ1LdvyzEm40RLJFdIAAdWH5M3JS68nOybmaAwQzRp?=
 =?us-ascii?Q?aWWPTkKITmiJZjwkxhGJEYoNiBzi94kN6FzTVSfbBBYJ3ol4WxNoc59RCWlQ?=
 =?us-ascii?Q?XdNyD77cXvdL7mbrgu2BWMI/OC2VXAKJK0T1xLOVyV+g7jAWGzfZTRFyI34e?=
 =?us-ascii?Q?c9NPLtMXFTLqJD76TKugsVb5DvqxcaAeXQhc7tPvvWavDSwGWCyxqNYl2mch?=
 =?us-ascii?Q?UGNM0jdMt3sUZgBB1B0hL12DsCSG+ej/teFJnIkbkBvAvCIqJO8bCyUp4DKX?=
 =?us-ascii?Q?jSwpUEIfPgph9aZjUw2tC9bMZwX2NMsBiU8UXyg6vz//d+4BIBPwvEo8PXRR?=
 =?us-ascii?Q?Jrgiwk1qoyaLCnTa3bBf+iSmLNFTsj1c08C+AqUrlQZyZyMu77bP03IQGFla?=
 =?us-ascii?Q?CIMFq7J0w7flTqOv+3wKiT5jGcw1cqoy89B8B5ex9n81RQxzULjZ7J3gwiWW?=
 =?us-ascii?Q?Xj81zj6ck0kC6MK6StnzJG99Wg9hhbl8w3q1RG7iHCGHx2dfFuunaU9ckAtH?=
 =?us-ascii?Q?EOxaKSj10378QUSkeCrOCSV/uiFl1WXbKCnPA2eCfrnrwqQGAwb8s7lGmXQk?=
 =?us-ascii?Q?hrVK/No+xQgwVROXFqa5nIKnWEMxg+ct1t+BJC9bfDqxj9bKzNHavifxpbxH?=
 =?us-ascii?Q?Lo7gmH1Bs+mkZ+qFFpXw8zcpKZRxAP65MosgEYEugr2UxfATm9jfwLeiU88l?=
 =?us-ascii?Q?9SMC3pKuaKhQFPoXPgzmvK94jdRAoUQASBLX2xhycYT5pJi21Tgb8kY/zKS1?=
 =?us-ascii?Q?odu/5/fVasmQmHehaPq/zCUDaeA/FV1+aM2X55SpCMuuwu/MbHWoOMWlhX4k?=
 =?us-ascii?Q?O9ZOpGF9I3PDc+UwNfQ+VvH/33XSWxn59fjA11XaODbta2uSOoRDABsHCMl0?=
 =?us-ascii?Q?4fwQNmQmiZri6c7lYjRaXA9gsIyXtBuLd2x+rnrB7AIJ9Tym+pJCpIoO67a+?=
 =?us-ascii?Q?doVdevPFm3IXBbZ3lTmTx5jXLbKf9FYMHOUaATclgSVskCfDTXzY1//kwBzL?=
 =?us-ascii?Q?i/+5YLvnHXV/GrX2xWxA7uLQwHVX4k3RPCHYMVoXhV6aocj33FENtf4rOygA?=
 =?us-ascii?Q?93j7j9LviVMJvwdi05nFl2Kz7CL24s7Zsrhf3H8qRp3LiXunlUidurkwjHcs?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	G3MN4xOCBPmhCMJ6i5V4RUUs3+0FeZpQwUbJ+WMV0YR00laQQfWHyvyV6Tg8gtNuHq1xXDMSe+07K7RZK6TXHm2Ymz3ivRF2wCq+3QumSvK6bAp6P9ZIXkZvnhBDEmQQbj7GqjAuxiMMwGJLnfGCGSw36flXkegvaF4nukkMtoqIJByjMXX/WpZs50gk/f6oi9ND3Cu3EUChHx9fWjPm7msmXtqagTschhtGEjwTtHa5j16t4pk2bPJDf0fSLJUDZKDIlMzpGoLINlv2d01I5U1VbLYLxVct4k0cDny6vhOXTdKPXgBkDbU48x/b/QzKICkiu/m5najXGcf763/7brccb6ZhqFGbTcOArsuQGGw9B+5jVEQ6jhjn9sqDVR+e+GJkfAvoPOCi6tETmJ7wg4oo++xK9Za9WPfkCgBTs+n7No6LQvA7Xu/h1x0kbpK/aWhoXHDg4i3yVlsApDpt57Fw1cOPsKOO8XHyhy4WHeSDmKFz6YlqnLq/CSORMWCFFAa1L1x1CGXpTWxJw76PfznTJOGKhCjsZTZ2sATyl2nmw4MIWZfxhGyuPkMMcDfFpJEOqRILFamW8ibT2Frrs2WzWiZupzLY/82xx425qcA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2d7876-9c92-4645-b8b6-08dc96d68c02
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 18:25:39.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UoN536bLzLGbs43D4vAM47G4T7XDRMl4+zrAMJ7F3QgRva47ObUiH5JgyMvmeJoY3B4teiICALv062NtzLKrHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4765
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=440
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406270138
X-Proofpoint-GUID: uMeqxwgUw_lZ5ZkcxxwpuuZSNOIAtXs9
X-Proofpoint-ORIG-GUID: uMeqxwgUw_lZ5ZkcxxwpuuZSNOIAtXs9

* Kees Cook <kees@kernel.org> [240627 12:58]:
> On Thu, Jun 27, 2024 at 11:39:32AM +0100, Lorenzo Stoakes wrote:
> > Establish a new userland VMA unit testing implementation under
> > tools/testing which utilises existing logic providing maple tree support in
> > userland utilising the now-shared code previously exclusive to radix tree
> > testing.
> > 
> > This provides fundamental VMA operations whose API is defined in mm/vma.h,
> > while stubbing out superfluous functionality.
> > 
> > This exists as a proof-of-concept, with the test implementation functional
> > and sufficient to allow userland compilation of vma.c, but containing only
> > cursory tests to demonstrate basic functionality.
> 
> Interesting! Why do you want to have this in userspace instead of just
> wiring up what you have here to KUnit so testing can be performed by
> existing CI systems that are running all the KUnit tests?

The primary reason we did the maple tree testing in userspace was for
speed of testing.  We don't need to build the kernel, but a subset of
APIs.  Debugging problems is also much quicker since we can instrument
and rebuild, iterate down faster.  Tracing every call to the maple tree
on boot alone is massive.

It is also difficult to verify the vma correctness without exposing APIs
we don't want exported (or, I guess, parse proc files..).  On my side, I
have a module for testing the overall interface while I have more tests
on the userspace side that poke and prod on internal states, and
userspace rcu testing is possible.  I expect the same issues on the vma
side.

Adding tests can also be made very efficient with tracepoints dumping
something to add to an array, for example.

Finally, you have ultimate control on what other functions return (or
do) - so you can fail allocations to test error paths, for example.  Or
set the external function to fail after N allocations.  This comes in
handy when a syzbot reports a failed allocation at line X caused a
crash.

This has worked out phenomenally on the maple tree side.  I've been able
to record boot failures and import them, syzbot tests, and fuzzer tests.
The result is a huge list of tests that allowed me to rewrite my node
replacement algorithm and have it just work, once it passed the
collected tests.

I haven't used kunit as much as I have userspace testing, so I cannot
say if all of these points are not possible, but I didn't see a way to
test races like I do with rcu in userspace.

Thanks,
Liam

