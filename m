Return-Path: <linux-fsdevel+bounces-44346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D29DA67B43
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8919C65E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0628212D97;
	Tue, 18 Mar 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fPI7Zmah";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O1CpZRuK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD9211711;
	Tue, 18 Mar 2025 17:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742319912; cv=fail; b=locH6XHA8LXIHXWh9GoZOI9sCjfyT6NgueG4ODHW25CvIKW0JsTKp7/i+X4bAVqkwMTSL5V8kz34l2ELeFV+XWgHdnr8T+io5DnSdTguQOrgJEYFPTuEiGiBMcVea/Ryft9gtrRvxCfdd2woxBtLWFg3mMl/ZNe6w9FlhWSg20M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742319912; c=relaxed/simple;
	bh=YNSZ8U8K1rmVi+7Pvqu7E2B9XThpCPIdyRtFp/tqeK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iriKVs2cClVx1oPXS+GPrXeDfVsRdval0QVrxFO5PP1B2+CIDUD1aPWKat96iitgQxbBuj+h2US/uWKDPHDd0DTrQt3ZSl/9NroM7vREmUaGFocHSECEqLOG7xiEeVmX/sIZIhzhA8T8pvUhyijjbX62rXpg5UjRcESgaeTEaa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fPI7Zmah; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O1CpZRuK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IGfmEf008170;
	Tue, 18 Mar 2025 17:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Jr8yCmiF/CW20GElSVzeCo3FuQ1AigE6eg8SEpoNVr8=; b=
	fPI7Zmahgtik7HJ0yRyQNjUNy97f4OTLQQ6rYFWJ7vcjGJ/G92636+dhVKGDZUAt
	bHo6Vn8qcZX7wg4Dv4OHYC1F7kg5hU7WfZ+0tFih5id4BkLdIG/mZihl6djpFeAM
	nUvmuuOLkb0kCCMrM5hUo0Zd9KwWCIll4jxJP8UsXV4Dv8roNx/MrQX9mco9zxbv
	eIh7250iCKJraLAZ9hYD1vYb/S9r+tBvkXMh+aA4CUABgH71sOR0rJq4KpIYtHIi
	Ojn25EE+c+3T1JJOIrTWwEA3uBDvIY0AJ0Re0GncjPvgn60yzj+WvQMU80FCZOX4
	d8KKxtNUjDF51brsP2R9Hw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45d1kb5uh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 17:44:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52IGd1sS018547;
	Tue, 18 Mar 2025 17:44:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45dxdkedc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 17:44:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DcyFpURDbTRy457vXqoI2ZsKCg84GFEtHsO6od48JfhXjBE5SeVxZ0b5ghOpAcl79LvjC9O6DW/fzrEMv6ztVT/g7av+NxM0QjV2BXXc/Wn2Pw2WP+Sr7ywcfhypoVgUKUmk4B1IskHB3jyfnuyVpvIxLvl3vyqhhI6rMiRbkQ9q6HVpEitiOz0q39cpH7Zt5QgtKVWzKLKdnkx6YZ/DuDN+uP6c6AIcXQo2IvouOgUEGiG1h8PuiqIZVCyBOpahfKcPMHpS9LQ2nzTsrJutK0FRUh20REkNT7bTfWLcgYZ6Lr7mqR0AvU8jZvBlVPCHlNU1RYP1aoOpu+8jSnSUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jr8yCmiF/CW20GElSVzeCo3FuQ1AigE6eg8SEpoNVr8=;
 b=SMQpMZvYpg66sCmW+0g/bKyZVD7BVIPhlrm6hXsfrz71gZCTu/tVvVblQ2mE2Q3c07TNO2KaFG/itM83R2DLPcKyk+U+EwOqnPTdCgtqUeBTmLUZNwqTHl1lLyUrPFIYWVXTLyuUcjQeeinoRlJVbz8ghEtYab5dPqrk0Y6iHLUg0jxnywUAHylHCu45FDM8kUgj5qnAIPWKmOou0nhzst2C27Y75X3ZJEEpcmnpJTyxGHGuV7iV4c64e+sEYcb/pmvYIYZwN/ihsGxVTR4QDwyq+wtFYEjZzyL2oHzCRa6VF3S2N4Ie39GgfVYSAwCB3JK2x4xXt7FZfciHeNUIPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jr8yCmiF/CW20GElSVzeCo3FuQ1AigE6eg8SEpoNVr8=;
 b=O1CpZRuKL83y1i8RqE5NqPTEbNRg/S5GcUoYWB4E4NXGIInI6OpNIT4mKce/xXjTcYC5JkOKSa3RV6t4X8bVVyqc7hmu9ALR7ndouwiON8nMj4mw3W0YzujoqAOoW79FXc4JyIVPk4W/I/Kewz6Wau3WpTMqSPPI7Gl5hUrOj30=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7836.namprd10.prod.outlook.com (2603:10b6:610:1b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Tue, 18 Mar
 2025 17:44:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 17:44:49 +0000
Message-ID: <de3f6e25-851a-4ed7-9511-397270785794@oracle.com>
Date: Tue, 18 Mar 2025 17:44:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/13] xfs: iomap COW-based atomic write support
To: Christoph Hellwig <hch@lst.de>
Cc: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org
References: <20250313171310.1886394-1-john.g.garry@oracle.com>
 <20250313171310.1886394-11-john.g.garry@oracle.com>
 <Z9fOoE3LxcLNcddh@infradead.org>
 <eb7a6175-5637-4ea6-a08c-14776aa67d8b@oracle.com>
 <20250318053906.GD14470@lst.de>
 <eff45548-df5a-469b-a4ee-6d09845c86e2@oracle.com>
 <20250318083203.GA18902@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250318083203.GA18902@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: eedf7520-ed23-4874-ec2d-08dd66449486
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c0FOSE9XN29nNWd2a1RUNWpIbHM0YlQzS3FXYWRFcFhWUTlmTjB4RHpXeFZr?=
 =?utf-8?B?MW8wVXVTbmZqTmdsRU01ZkxkUGcxKzU0Ui9GV3hudDlqYW4yOHk3cFhBdzky?=
 =?utf-8?B?ZW1oNldwU2dpc2ZVWG9rcDhEVTVsbjAwK1lFOWtocTdlZHhFWkRCNUQzSitC?=
 =?utf-8?B?MDd4T1A5dDNreXJJcGtNczViSi85SmVQWmJPRzJpQnVUdDFDUmxhWlVFbjYx?=
 =?utf-8?B?Y1ArSmNVLzM0K0hYNEwzaWg4eWJzWlpKYlloWFJ0SUgrNnExSDk2UU9ncVEy?=
 =?utf-8?B?MWd4dk9TaEJKcTB3SFNScVEra0hkeVV6M3dCTGVRZEl6ejcyZlpGekVjU3B6?=
 =?utf-8?B?MGRIMGczQkJrZGlaeFI3WHZUTE9zZ0VYTmFJdXdkNWIzUDR5akhRSytjblBX?=
 =?utf-8?B?c0o5cE9sdDJpV1cvN3pYaDdHOTJZYTh4TXFrdjZYMWRYUjRXQytqL0VZdmV5?=
 =?utf-8?B?Qnd1RHdjN3MzUUZiVkJCR2JJaERSc3JPVit1SW9YZG9HclR3RDE3RUcvcXlX?=
 =?utf-8?B?czNIai9jM01zZEgzV0VEZHVuN1I1WmRlMjRTajVSbDZuVDM3c3g1T3BwWnFK?=
 =?utf-8?B?cUhZam1jVzY4dlBuSTVpREFlRWRkcmkrVXN6cUVrKzVNMDAza3VtMm1uNVNX?=
 =?utf-8?B?eUYxcHhYNWVmTlpEa2xVL21JOGswdWx0R1BYcjhYYllDbkdNbDJ1MEdlcDNr?=
 =?utf-8?B?UGovdDNHdDNrNGlteDgwTmNkM3Rtc0hpdzViOGUvK05Sa1lxV3owU3BvaXBN?=
 =?utf-8?B?VGRiNnh3ZnViTDUwNFVRdmV5RndCWHdJekNSL241dVJtSXBhZk1kZVdXc1NT?=
 =?utf-8?B?c2VqR0FiOHVKeEdab3JOaUM2bWI5N0tudVlCV2hTSkZPTmRTZ0UvaVk5clVt?=
 =?utf-8?B?VmlFNmc4TlBaT1pMb0FLNWhZem5qTmtvNDh4TEFveXRUdFplUUtpNjlpQWo1?=
 =?utf-8?B?a2gwY0V6SmdxQjgxUGxvZzY1NjBvR0xqVlE4TFczblFnM2RKa2M1aG1EU1U4?=
 =?utf-8?B?S2pONkJQNmdNWnFSUnlQdzlrYStWN2haSklPdUR3U1NHQ2JHbm9ISWVGTHFp?=
 =?utf-8?B?VTVBd1YzanRTdUVTQ1FpZFR0b25rcmJZc3ZxMGdQdGlzMDhDSmJ3STk2RFF3?=
 =?utf-8?B?NzVlcU15b2RLU2xIdnltQkFmSkN5TjIzeUJTVCtSVlNaSVNMYVFNS1FIb1gv?=
 =?utf-8?B?OEFWQS9rM1RXeHVWN0dYalNDNlhJNG9DWUd5dm1PYjlKZVczdFRzQVNHazFr?=
 =?utf-8?B?NWNmMEhLSjU1RVl0aTI0V0lFMTR6Q2plcEpyVWlPWWo5WjB2RDJJaTlBdXg3?=
 =?utf-8?B?L1JUOGk3WDVmY3JHRzI2NndiSkw2cG4ya1ZoQ2lJRmhvVHlTWmdDZDZXTkhv?=
 =?utf-8?B?eVl4bk1ETWduemtlRStuTnlLc3BWNXlGbGpuNHBnU0dBNlRiNjhnV01VRzM2?=
 =?utf-8?B?cjFFV0xvS0JsNmpLUnJ6aTdBNzlmTzFqaGNTR1VWMnovTk1JVEtFek83NVNu?=
 =?utf-8?B?SjRTcXFkVXJreVYyTlFZRkJTcWdpbmpDRlNHL2dNK2RWdEJ6amlJbGZGaXhj?=
 =?utf-8?B?ZlRYNWYrYnpmS0U2dG5BZzlpVENHTGQ0WU1xSE1RMGErY2Y2YXRlTzlHV0dV?=
 =?utf-8?B?ek9EelFMVFlmSStYTWYxbE1WWENVM2VVVjNmc3RTaXR6RDMzdSs2MGN6Y0N6?=
 =?utf-8?B?STBvSW93SlF1em1hRjVzYWRKL1psSytJSjVubGNPUUNDK04wN0x2RHV3U3ZW?=
 =?utf-8?B?U2o3YW9aWG1vOHN3bllOU2pTendIMStodjF6L1d4TnMwdGxBWnhvcUhhZHo5?=
 =?utf-8?B?bktDbWs2NGFaajZMTmJPazNSWXZUM3ExQ0t0TmJhNnRUL0dIdXErSFpBUm9y?=
 =?utf-8?Q?oDuFrjpZ4/6hd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NktkeVhkQ281YXJwNzNvUFFKR0JHU0ZmQUJTR1VhbDU4REk2VUltQ2x1bVQ3?=
 =?utf-8?B?WThtMGFWbThSUmtNUnBIMU1UOStIMy9YQXhjYmtOQVBvaVNXRzZLWCtrd1Fv?=
 =?utf-8?B?QTFVQmdvUXlXcXpTTUVtWHN2bUwwUmZqYmRNMVRTU0g2U2RHdGV4aFI3UXI4?=
 =?utf-8?B?ZkhFUVhoRU03ek9UQk9FbzVMNXRPRTR5a2szaU45UER4T1MxMkloNTlHaE0v?=
 =?utf-8?B?RGZ3bTNZNlJtSTRwRVJERHM1YUY4RXViNGRIYnJPSU5lZmx4Q1ZzMmloQS9G?=
 =?utf-8?B?aDlUMDZPOHB1NDRYeTBVamhVc3dvMi9DeVExajdKd2R3bVpBQVZHS3UzMUZo?=
 =?utf-8?B?WkNuWkZWNExPdHBXL25oY2VpVkFUWldKZ0hpcG9oNEtBUGRRTmVvenZwQmtJ?=
 =?utf-8?B?c3Ntdjl5N29HTlQvclQ4MmJQazQrNFB1SERaZ1VzSVMwRE5lTWQyQXIvSlRr?=
 =?utf-8?B?S2p5SUVZTDJLd0dtWC9XVFhFZjgzRUdrYmNCbDd1OFduL0hJOE4vSHo5VUxW?=
 =?utf-8?B?bVhzUzEvUlVLYmUvSlVaOXhIU0xreWE2TTNScUJkL3lHNDdmNVF5UWgxcXMr?=
 =?utf-8?B?c2lmdjNVRjVNVC9OV2haTTdXeU8zbjBUdkVrVkI1YUd4NklPaXFtczdSTTJD?=
 =?utf-8?B?cGZMRTliMU1Jd2ZmVXFpdkg1dDF3WTV6K0dsVUFES000aHllVis4eHFaZS9Y?=
 =?utf-8?B?TUxuVzlEVlpNeHduYmxqQnBMUjZRWFJOZ0kyRlNQSU5qbE1rckViMkVFVXRr?=
 =?utf-8?B?M2UvS0g3RmxCR1F1K1YwYzRmV05hck0vbkdjb09lVnJ0MnN3NzhSdHpCcnpJ?=
 =?utf-8?B?b0pFQWtoa3I1V0JabkFBQkZBeHdXUlVUai82K3JEYW85KzdEMzVMbUdNdGFG?=
 =?utf-8?B?R2Q4aWVkYUxQNmFocFJHRmJqNVdlS1Qwek5kazlKYkRGb0tMa3NtdkdheHd5?=
 =?utf-8?B?OUpPNEZrYXR6Q2FWYUowTTh6RmpPN2FGazY5anpiY0J5bS9nVDU4VzVMR1lC?=
 =?utf-8?B?MDNaZEF2NHU3eVVvZEhrdUhCVWs3K0ZMem9xdnZtdEJIeWw3MXR2cklETTM0?=
 =?utf-8?B?c3J2WTJzcjJWVXhiNjgwZFVDOUlqRWJKMnRuanJQZ0h1V2RGTDVuaGR4OVFC?=
 =?utf-8?B?cnd1RS9ybi9WNXRNUi9NL0s2QmlkSUZCQUE3Tmg4eWhOYVo5b09EV3BSQjlQ?=
 =?utf-8?B?WkVCdWIvMHhKMFAyc0d1aTVYNUlleDBsUytvSjBHcVlxTXd4d1Y1YldSV3k4?=
 =?utf-8?B?cEVkblpxRFNlKzJPRXlEald5UmZIa1JBemlGcmIxcm1BZ0VaWlJiSzVYc0NV?=
 =?utf-8?B?N1RVU0pkeU9oM1VJbmZWZjRrcStkeC9sODY2OGNuTUZ0RVFNdmdnSTJYb0Vm?=
 =?utf-8?B?bnZMbjVGcmNRM1BmUmZMVWhhYnNXRTEzQnVad3VQK2dXSHNIcTdTQWhKNnFt?=
 =?utf-8?B?akNucjd2TTlyc1AveUdSQzhjWklkNHlOY2NQN2l3eHBuQktaZ0prS29DUDcx?=
 =?utf-8?B?V0pEVXlaRERPS05INTY5SEZhOXc1ZVlLWTBaNnVNV1ZHQW5MOFo4aGpQeEdO?=
 =?utf-8?B?QjBleFc3WVJobmZ6bllrNExSZDFPRk9uRTlVZjBtTGJRaU9pRXlkOTNRaFVX?=
 =?utf-8?B?WmYzNlZtVks3M0VUV2ZGM0l0Rzc5SG1LQ1FFTEJCZDNSNjRPbTd5WEhrSUdp?=
 =?utf-8?B?bC82ck0rQVdBeGEzdUVMeXphdWtjZFhjWkhDYk5NeWtlTTVhQkdkaU9VeURK?=
 =?utf-8?B?ZHRYMFpoMkdBMG5SQ2cyNGhQU0FldVhqTFFQOUxONlh6YWdkM3N5ZG82NjYv?=
 =?utf-8?B?dzJhYXZPVXAzSEV3aElWK1daSWhjT0F1akljankrVkRyZVFYV3BsT2xZZmZh?=
 =?utf-8?B?MTBxcU9EL0c2RzEwM0JhK0dQZkZWZG1EWHRDSUMrU04xdWZuQmRZc0RadElH?=
 =?utf-8?B?S2NCc2psdExxcEVldXNlRmJ5RHZoODJPQjk1ZHZMVFNqVHJJckdrc242Ukt0?=
 =?utf-8?B?M25ub09qM3kwbXZXckVoL0Z2cHBEK2orUDNVZlpaV2RsNHpoRDNTTjI3TzNI?=
 =?utf-8?B?bVZ6OC8yNG5vai9ub1pnSC9udlI0eDRPekYzWG1xVzlrZXV4NHNRanFPMmU2?=
 =?utf-8?B?SmxYb0VUeUptb2NjSDlNLzdvdXZOL1pFbmVjYXN2RTdIdHBuSnR3aWZ2QVV5?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R6YRuRG/HpMG3SpVOi+rw0fJyCQs9FqxkYnAeXmPCn9ZiN+RltEnn7LW1cb5HSjJbVPS4IvaLpfGuUoATWPOOaHjHNcECXvOLR03lWnT4IIRESdXh6yxEgjvQQ3d0d01PtsSHoy1xHo2rmI151dTFyJzMqgxR3s+4E9givBtchmdK6aNSyWLrkhySBzxSka3BFzl1CWVmmRO6j7yY9AT4hmotVTLzs4/1odhLRjovMpjAKjkKZgNbvUMiTm4rgwYN0or3L3Ch/9m3HRXjrxtNWbeg1ymybtkW2AMEpmfHxe2Q6nw2+302YMcNrvZ8Bfm2b2VlL8EmwLQ9hf27/2bRVUgC9P0iGq1dQziiY7ZYwlV5nB1thMRm9si+aS+GX4EM2hx3x66iCKrw8ePX8JOG+LkeP5C/YWP1dnncXrqAXPDX5XG50lrRATcyA3IuyBXm/Aa9U2iVG3rcginJKkak/y9BNyaJMroQhDeburmAQ29SS7JtXMOjG6V449R+837++Yw0VCLYw6k6nIQZ+NEGaMJ6OQYW2oZgk+YiNav+PYwPwYGVRqRlpJO5fmxTaSpLx+/0aUZFtE1qQdfrGzk/WUKZFjB5K+vg4gfOI1Xhmg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf7520-ed23-4874-ec2d-08dd66449486
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 17:44:49.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VE/MJF4wrCAXM1qDQYMw3Ekr5LJSp77++8sobbgX0RTCKtljOZGUq8fRFjawI8v18G9IlDNiNcvsCWHTQqphtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7836
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-18_08,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503180129
X-Proofpoint-GUID: n-1qj244WZ63GWrwMnRRl8XjCUUK0Fg8
X-Proofpoint-ORIG-GUID: n-1qj244WZ63GWrwMnRRl8XjCUUK0Fg8

On 18/03/2025 08:32, Christoph Hellwig wrote:
> On Tue, Mar 18, 2025 at 08:22:53AM +0000, John Garry wrote:
>>> Is xfs_reflink_allocate_cow even the right helper to use?  We know we
>>> absolutely want a a COW fork extent, we know there can't be delalloc
>>> extent to convert as we flushed dirty data, so most of the logic in it
>>> is pointless.
>>
>> Well xfs_reflink_allocate_cow gives us what we want when we set some flag
>> (XFS_REFLINK_FORCE_COW).
>>
>> Are you hinting at a dedicated helper? Note that
>> xfs_reflink_fill_cow_hole() also handles the XFS_REFLINK_FORCE_COW flag.
> 
> We might not even need much of a helper.  This all comes from my
> experience with the zoned code that always writes out of place as well.
> I initially tried to reuse the existing iomap_begin methods and all
> these helpers, but in the end it turned out to much, much simpler to
> just open code the logic.  Now the atomic cow code will be a little
> more complex in some aspect (unwritten extents, speculative
> preallocations), but also simpler in others (no need to support buffered
> I/O including zeroing and sub-block writes that require the ugly
> srcmap based read-modify-write), but I suspect the overall trade-off
> will be similar.
> 
> After all the high-level logic for the atomic COW iomap_begin really
> should just be:
> 
>   - take the ilock
>   - check the COW fork if there is an extent for the start of the range.
>   - If yes:
>       - if the extent is unwritten, convert the part overlapping with
>         the range to written

I was wondering when it could be written, and then I figured it could be 
if we had this sort of scenario:
- initially we have a mixed of shared and unshared file, like:

mnt/file:
EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
   0: [0..7]:          192..199          0 (192..199)           8 100000
   1: [8..15]:         32840..32847      0 (32840..32847)       8 000000
   2: [16..20479]:     208..20671        0 (208..20671)     20464 100000
FLAG Values:
    0100000 Shared extent
    0010000 Unwritten preallocated extent
    0001000 Doesn't begin on stripe unit
    0000100 Doesn't end   on stripe unit
    0000010 Doesn't begin on stripe width
    0000001 Doesn't end   on stripe width

- try atomic write of size 32K @ offset 0
  	- we first try HW atomics method and call 
xfs_direct_write_iomap_begin() -> xfs_reflink_allocate_cow()
	- CoW fork mapping is no good for atomics (too short), so try CoW 
atomic method
- in CoW atomic method, we find that pre-alloc'ed CoW fork extent (which 
was converted to written already)

>       - return the extent
>   - If no:
>       - allocate a new extent covering the range in the COW fork
> 
> Doing this without going down multiple levels of helpers designed for
> an entirely different use case will probably simplify things
> significantly.

Please suggest any further modifications to the following attempt. I 
have XFS_REFLINK_FORCE_COW still being passed to 
xfs_reflink_fill_cow_hole(), but xfs_reflink_fill_cow_hole() is quite a 
large function and I am not sure if I want to duplicate lots of it.

static int
xfs_atomic_write_cow_iomap_begin(
	struct inode		*inode,
	loff_t			offset,
	loff_t			length,
	unsigned		flags,
	struct iomap		*iomap,
	struct iomap		*srcmap)
{
	ASSERT(flags & IOMAP_WRITE);
	ASSERT(flags & IOMAP_DIRECT);

	struct xfs_inode	*ip = XFS_I(inode);
	struct xfs_mount	*mp = ip->i_mount;
	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
	xfs_fileoff_t		count_fsb = end_fsb - offset_fsb;
	struct xfs_bmbt_irec	imap = {
		.br_startoff = offset_fsb,
		.br_startblock = HOLESTARTBLOCK,
		.br_blockcount = end_fsb - offset_fsb,
		.br_state = XFS_EXT_UNWRITTEN,
	};
	struct xfs_bmbt_irec	cmap;
	bool			shared = false;
	unsigned int		lockmode = XFS_ILOCK_EXCL;
	u64			seq;
	struct xfs_iext_cursor	icur;

	if (xfs_is_shutdown(mp))
		return -EIO;

	if (!xfs_has_reflink(mp))
		return -EINVAL;

	if (!ip->i_cowfp) {
		ASSERT(!xfs_is_reflink_inode(ip));
		xfs_ifork_init_cow(ip);
	}

	error = xfs_ilock_for_iomap(ip, flags, &lockmode);
	if (error)
		return error;

	if (xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap) 
&& cmap.br_startoff <= offset_fsb) {
		if (cmap.br_state == XFS_EXT_UNWRITTEN) {
			xfs_trim_extent(&cmap, offset_fsb, count_fsb);
			
			error = xfs_reflink_convert_unwritten(ip, &imap, &cmap, 
XFS_REFLINK_CONVERT_UNWRITTEN);
			if (error)
				goto out_unlock;
		}
	} else {
		error = xfs_reflink_fill_cow_hole(ip, &imap, &cmap, &shared,
				&lockmode, XFS_REFLINK_CONVERT_UNWRITTEN |
				XFS_REFLINK_FORCE_COW | XFS_REFLINK_ALLOC_EXTSZALIGN);
		if (error)
			goto out_unlock;
	}

finish:
	... // as before
}

xfs_reflink_convert_unwritten() and others are private to reflink.c, so 
this function should also prob live there.

thanks


