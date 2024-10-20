Return-Path: <linux-fsdevel+bounces-32443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1152F9A53B0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 13:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA7CA283341
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Oct 2024 11:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1257D192593;
	Sun, 20 Oct 2024 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RchiKSZG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o315Kwxx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402D158218;
	Sun, 20 Oct 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729423295; cv=fail; b=a9/0bL5Celgzhl5umiol3//xhm3UMStcKWMcr1wnMTAiLGP6Rtf+/hbz4WmN5/AtvPnBJV1LxsjRZEfhJD0MHreSFCS9nfPaBFvWqbFDYT5kUbZzkXm0JQWHdHpjauJVdNI1uSpNeL+pu917iDKKtNdPnG6DO21Fv6QC1y8cKlE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729423295; c=relaxed/simple;
	bh=9cjoyyzmMynYd2TVYw8HP9RxIjmN3GZQuATOgY/b6YI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m3CvqJtsmPRFAt/AruiGUwcyOWxHEck93zQN/clfJ5Q5B+vmI9qQYoGBQ22wXOijM/bWo35lR4aCGOEIC1JFsO8JV88TdTCkM8h9UX8CpJQGqzB9HoprWN3nDrnJ2OSQDkjUWN85PGtz96tinMUKr4I6eEsGFoquDNRRvAvzVsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RchiKSZG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o315Kwxx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KAla14006153;
	Sun, 20 Oct 2024 11:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=BHMIgS9v9OcFiK0iRDqh9Vn+DwzjAPyMYTThFN5Rgz4=; b=
	RchiKSZGN0jSIVoZuyOieCsAKfDn9nf2WUHLdLHUcgGVTWlHMyPXXPYflQvrZDRa
	JuFqe1u6Fh7avwxBU/GLO5QyvWEKrU8c8QM74vstPVhjYcV7BmY/9I414I/VRk+c
	oB4OpBipf11Uwz3WKdgzcS0mboWvgyO3Ub5hC6g50MNSHoPvaNePPW4HE2tdP7Bv
	RWmgEjcRNbPba8ogaN465uzMAbpAhhY7nabI5nzQXam2hIn37mDUmQgPTKYeI8ev
	9yHNkFQreXMHXauQoHehr9lyRsGlpdb3nDutJG8I6sI8VcjmOgH0VpehUigQj9EA
	RlxqzQBiQP2M+qvpba+jEA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5451ebk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 11:21:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49K905oJ019720;
	Sun, 20 Oct 2024 11:21:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2049.outbound.protection.outlook.com [104.47.58.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37bdsdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 11:21:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcAyT1qta+BoA1JX8QicmbSYleT900dslhDAicloZoy+U5a+mnd8KFq6FG2brvJcyFF8fTilXLhIvXSmwQoAZlr1hfIV5dH9L44iozvnDRxckF2fQ7DKj0a1m/RYztLf83QK9eFOwMbG7O3e+1/OOgG1yJrR9c29o29pAfKzw7ycgjD3Lf1BomCvl1AO0MbtuvuAcqrkNETB2d8heA1uCkR4fa0jWxnIygjmJXqUfr31FohHEjnwDUixNnhQgSp7GAQLNKBZN6enZKY3S4Ky0JnkEsXyjzDZWJAAPsIzs9dA5f0Ly25Zzm7zA7pHR4Ec5WQ7+uXfXaEiUskvXelk7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BHMIgS9v9OcFiK0iRDqh9Vn+DwzjAPyMYTThFN5Rgz4=;
 b=hNDJcfmVOQq0M81W0b8XDQVyyr3XRrPJIu+vB9pKlxYagp+CsCeC0jjEhbKdfIrAN6pfCS45Vnt2VujUoxV3Y3pmSRXLTPcnm03OEHN5HdVU5kffUtagzlt8Dhc46eSgP29KeEX9Sc1omSpYraD+HcQl/dTXQ6YvEiEK0pj7W6W3XHregYDn6ABbQv+NXgD0q3PXOOLVXmKTWVUUE+9BiwsmpDKJkV/tIznVPmXf8QXFxdlk3rfPcpkb5rZ44mg4w+tXaHKrvcH4gCD9uVx8Sihn2XWOJbmk6PXk/e5UAwnOOItPkQSUy3epry+RFERA454BcTjwsthXt5DvWnzOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHMIgS9v9OcFiK0iRDqh9Vn+DwzjAPyMYTThFN5Rgz4=;
 b=o315KwxxL+fTNt8Mn1faou+JhEqRHahH4qtn+DeowHEUr2CNhQnUBrmhwKFCebsB0Q9fONLvqyXe88tqNdLPravfoH+ycT5CEuP2QZUKZYjgAXuWzoOEh4BIelvy7pmoe2s1221tO9w13QTUmxfbJR5eHpyIoUlGQ5gVBpvYw2I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6487.namprd10.prod.outlook.com (2603:10b6:303:220::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 11:21:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 11:21:14 +0000
Message-ID: <cec9eab6-8e3b-47af-94c1-56fa1e449e82@oracle.com>
Date: Sun, 20 Oct 2024 12:21:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/8] fs: iomap: Atomic write support
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, axboe@kernel.dk,
        brauner@kernel.org, djwong@kernel.org, viro@zeniv.linux.org.uk,
        jack@suse.cz, dchinner@redhat.com, hch@lst.de, cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ojaswin@linux.ibm.com
References: <20241019125113.369994-1-john.g.garry@oracle.com>
 <20241019125113.369994-6-john.g.garry@oracle.com> <87sesrgp5v.fsf@gmail.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87sesrgp5v.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0529.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6487:EE_
X-MS-Office365-Filtering-Correlation-Id: 7946805a-c366-4106-b0b3-08dcf0f94ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czduN1E3d25aejdnY01vYTFCeUpkc044dzFrYWdzc2t1YWFaYU1vZW5JU3dF?=
 =?utf-8?B?c01ZRDJzdnhJNXdja3Zob3lWTDdVM0huNzhMNmEwTWt0NDAwZ0V6VG9xYnFL?=
 =?utf-8?B?QUU4aTFGVHM3R1F1RjVLUThDeUxMeW1WbzJqdlFJQk14QU5kdFZUaUN2bDBK?=
 =?utf-8?B?Vnl5QWFNRjZKNlVvUWxGN3lLbHdMcDJucW9xWmN3cWRVYWh1OTg4SDVyQ1Bw?=
 =?utf-8?B?Um0rcVNiS0tUZnhrUkFyTkdsUHQ2QUFxMFU4VWRwUUNxRGRBZmpnd0dpZjNM?=
 =?utf-8?B?TmxDUmxNbTRHa0ZvMXcxNllPVm1rZnBiZFlHbmRiVk5MR2hDRVhNdy9qM21S?=
 =?utf-8?B?WWpUL256ZUR0TmIrb3NaVzFjZ2RZSlpDdzBlWEdxUTJEdUhWTExNN2xGUmlP?=
 =?utf-8?B?dDBBNldRdGltMzRhSkZDcXFuRDc2SVR6T296VXFiaXhVZHI1VkI2NlBsOGsz?=
 =?utf-8?B?dHdzVFVSRXNnNXRoc1hWZlg5TkJjbkFLeWZhUjNZcC9rRUdzUzB5UWE5Wkhj?=
 =?utf-8?B?NGx1cWkzdHp0MVFJdUZidkcyckFPZlVVMWpmSlFpQTA0bmNsTmN6S1JYOE9P?=
 =?utf-8?B?N3pKdWt0dnNjdFdIVDE5SUpWMFRHck50QnNKZE5zUTJhTE92S3FkaWptR3pK?=
 =?utf-8?B?YTdXSlNHUmhoOFhVZTY3RjBBVFU2VmptK2RDREpPVzI3UXllbGxyTkV0Z3Q3?=
 =?utf-8?B?RVBBOTZnRUFmait4dS9uQ043eEJrNHBUU3lka1BYQTlCNWtLODdTbkJlbnF2?=
 =?utf-8?B?YnpWd1pCb1M4Rm1JRTFvSGQrRnhxdHlCbzVENnNVQWtqMkRURExLREd4eGRK?=
 =?utf-8?B?RHBxVmxTeFJxd040SVhmWVBRY2tUQ1Y2MDJ1dCtjMk1uZnlqaTdYL2tvZEpM?=
 =?utf-8?B?SGdjUWM2Z0g1K0RTb0Z6YjBMR2lRZHRraWlEWWtBMlZsZStrMjBJSkVGblBC?=
 =?utf-8?B?dEkxcVN1YVZNc0FQaUhzNWhUM041VXd1M0V6VHM5WXl5bWxSSlJUUThkcW5F?=
 =?utf-8?B?ajJqck16YitRd2crTEtOY1JoMzMvQTZEZXMxTnd4RDkwUk9sbjhTRFBodzBX?=
 =?utf-8?B?UE1PWW9UckR0YnU0SitQRkNUb01XUmxyVXl2eFBna05ST0Qvb0dGSGptbGNP?=
 =?utf-8?B?N3Y2c1Z6YmN0dnNiSmFLVVZRK3hUNlg1Yk04NUdPSHhMWnBHc3ZoWDRYcmFF?=
 =?utf-8?B?MTl2OFR3SWFDejV2Y3NzNXpMaWFDdnl1UmtETGlhSFQ2bnAzWWJ0dG5ONGZ5?=
 =?utf-8?B?ZG9kYlpjWHY5M2ZJb1hsM2xqc0xKZnRFWW1iRnhQNC92WHZjbVc2NTZHL2or?=
 =?utf-8?B?OURuaHAvYmUvK3NobzQ1VXN2czJLUHQ4N05xRDdwWEZTUHA4SFdyUVBqd3NS?=
 =?utf-8?B?dTRuUlNaaWpNcFFEMjVkUFJYV1ErRHg5eEVUTnQ4UnQvMGVFdXZDYWlMZ1FD?=
 =?utf-8?B?VDlnQ3F5RXZHSkZzTnl5RVZDL0FNZENNVzdZVElmQkIyQlZyTUx5RWg0c0ti?=
 =?utf-8?B?NzdiQWtWU3VQaDg0MG5ZRUQrZTg4NkV0VFI4M3hXSGhOZmVxbXBXc0g5N3Ri?=
 =?utf-8?B?RXFyUzhZWldyeFZyYlpkZWFySU5vcUtQbk9wYjhldGhsdzhQd1ZjcnE0UkVr?=
 =?utf-8?B?aTQ0VmRBRXJiNFZxSi9xRyt1OUdnNzUyRThtc1dzRm9XL1B3Q3R2akY3Q2Q0?=
 =?utf-8?B?RTlrNnVQU3VYSVJ2Vi9UMVI4c2JpcEN4STRLdUtrU2pvTVZkZW9EYTUrdkJO?=
 =?utf-8?Q?hxYJlilXYDgmsBJoGHZMBR/GBVY+uK4iHvcxUHn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Ti80WTFsd2NLeCtDU3BQMWYwSVZCa3hKbGhmeTlOT0dPOWN0U29EZU0zRDdZ?=
 =?utf-8?B?WDRqU0g4L25jNEN2N3ZRZ2RsY3BDQS9BOHNRUC84SFZuV1hzTWNLNmIyZ1hC?=
 =?utf-8?B?YWUwZGtWUUZlVnFlNXJZRStFejVGVnRWMk13aXJSbEkvYkxlWXM5dlhibmha?=
 =?utf-8?B?SWtXWmMyY04wUVQyY3c1U2NMOWZFd3Y2MUpubkxtS3NVNDQ3RTZSR21SaWxK?=
 =?utf-8?B?Y3EzUjNkSlhSWDlZaklFZ2toNzB4Nm01QWhDWDB1bk9HL2UvVkdFa25xem9n?=
 =?utf-8?B?UEl3YjFGdC8yRGx1ZDdDS1VCU0hUUHRPdDM4YmoxV1E2dkZpUUI5QVh5NGl2?=
 =?utf-8?B?Wnk1N1FkMkU1OWd5cEkwVG4vNkhpWEU3NW9rWE9XWE1IN21MV1BWa0x6V01u?=
 =?utf-8?B?c2VWM1J2U25iSWRYM2ZDRGUzMHIyNXlzS3BocjFMM3ZaQUNXT3VLTDkrdW1n?=
 =?utf-8?B?VlhacVBPcm5IZUV4Sm9zS1k4T1c5bGkyd1d2b0VCNC93NWEwbkNzWDdGYVhW?=
 =?utf-8?B?Z0w5MC9ZRnFrNG54a25aUGtDcTVVdGdIalpsVjBTRFNWUHZFRE4rRy9Vc1ZQ?=
 =?utf-8?B?TnRUeUI5Tkxhd0xiSTFOeGRHVGF6Qkc1SFRqU2RvS2pJK3BiM2J5M0dQV1Nm?=
 =?utf-8?B?Rkdnd09jTkVYZHQ4a1NBakhmbU9PZ1lqUWZxY1FDbDN0dWUxaWZVakdQNk1Q?=
 =?utf-8?B?YTNHNHZqdExINFlWZFdYYzBZdGM2K25WbHhydnRQY2wwVE81T3prUUFJVzR0?=
 =?utf-8?B?dzNQNkg4cC9DQTI3dFRJdENmSFNOTWp6MjliMnpRMU5qYW9xT1pWNldtUVdT?=
 =?utf-8?B?YzR5YXE5enFNZTk2VjdUUnl5TVJWYW9kcytJZ1lkTlAvKzIxM08rVkpIZ2h4?=
 =?utf-8?B?aEtnTzZVK2ZwZG00YXpuUlhiZCtFYXhqOEprU0k0cktiRyttMStBVE9qYWQ4?=
 =?utf-8?B?cjV4bUZkeUFtSzExVDZydURtYmZpRmNQQzJJU2IvNXZqeUNFbHAwSU4yRnhQ?=
 =?utf-8?B?c3Q2SEZnTjJaOFc2K2I5WER6Y0JmZDVIRmFxeXlldGFkL09BbVFPUWJDb2ZE?=
 =?utf-8?B?Q1lJK1RUempYSFY4Z3hlUVBLL0h5WlBmb1RhSDN4OFhLdXUxOUtMeW96NEh0?=
 =?utf-8?B?Tm9HZXZxbTdjZi9qMVhEaG5kZXhiblRBQ2tYOVpyaVh6WG0xcWxKR2wrYXQ4?=
 =?utf-8?B?RWttZk5oSHZJbWdGZ0FSUmdlcnU0ME8vNHloOWZiS20zUTZseWNPbFBHZUFY?=
 =?utf-8?B?eXpSRGZUcGdXMjZ2aGI0b29CSm05VHpwd3JqN25FRnppWkNhQkdBLzhrM05I?=
 =?utf-8?B?QW5PQVVVcG93OUo4U1NLbURZS29DU0dIT3k3a242QmxiN2xydWZNMWp4ZjRZ?=
 =?utf-8?B?S3F5TFI2Kzc5LzJEWlVPTUU5Rk9jZmF4ZXBjeE1yc0hramJDczhnaVJabHF0?=
 =?utf-8?B?RlU4SGJ2UnlqaXY5TXMrZWQrYk15Zi8yU0dXaGs0YWJqbFQzNWVKYlBuUXpa?=
 =?utf-8?B?MUpEZm9zV1FCb2dFWnFGenJPRzBkNEt5VFlYc1M5dEZiWWp2b2lTSGxZTUFn?=
 =?utf-8?B?SWlkNlk2M2N2MW92L0FLSGlwMHpkRmdlbEd0dHhQVmFtdFJ3WktKWTlEcTlt?=
 =?utf-8?B?MXBWb0h4RjJtNUpOS1I4cFlqbVBETVpUbUx6NDBLNUZTTEdCbGdreDh0K1lz?=
 =?utf-8?B?WkkxN29rQ0ZjZkE0aVA5RTJtMlJmL3RQZjcrREQwK1pMQk91bTdpNTJZc0Ru?=
 =?utf-8?B?TzZSM0d1aC9BVXBkSUhndGtKc045Z2V4eE03Y0c5NVdOdngzYm9zdzByekNZ?=
 =?utf-8?B?ZGMxNE4va3QwZjJyZDRYMzN6TTYyOHQwVkU0SDdQUUFZOHo5eDh4U0FPbERY?=
 =?utf-8?B?U3VFd0F0Zkp6b1ZDRElHbnpRZDNqYzNLbUwyeW5PU1pKQml5R1NIcUdXWlI2?=
 =?utf-8?B?eWhPZytPSXhtRDlxYUFGVUE0amlSZDZKZ282c2R4ZVdOMXh3RUczT200MXFL?=
 =?utf-8?B?Yk9FdjgwVkJjVWt5MXpkR0FOU2IzaHFrTDR1N3NrcGVJSW9CWEgrckoyeS9p?=
 =?utf-8?B?UG9zR042Ym1naGYzMWxubzZtd3FmVStsbzhOL3RPcElwZmtwUU8rckdNaEhG?=
 =?utf-8?B?ZUVvaHNMTVNPWFoza1Z3QWdCNEwwZEZPRUY2SEx6WGJoMkdSS0YxU1RTWHgv?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UMKL3NfvFYyYgktp+oLp+ib3bElbhMNff37IBjZf3sqP99Ej6DPhyWzrvO3X3oh/JQaL+J/7Yy97AnqlErKX+gVk92MlSNWe6W4oddxMttOf6LxE1JtLJwMWO2NNA7eYWszPtrM2VQH49ldtvTwxzHGe1D57QRKPvb+cdjD6CUGBXg/NgBpjPFkAoqnq4bRKJNFrblnV9ac3oS8XOrixoQvGzrGDJsQQrvzUVMp7e8tJiyA+To2cULbQ4u5mlt6NXc765KBOyf4KrRZ9F2wRc54Nx9FzAYC6FmoNq7GXPLZ5zaM8/DufrmY/N6PBN3/acPipoB+rf24iD38hSpptrDHB6Qmq6OL9sdBNDE9fCrWetVm9FP9s3gPo0qnbFYeQhJMOlgmnAzNv6Yu2togBaroEmWY2qU0Iq5TDLFOf1A0StpBrQCD5ej/vwq42hi9F/u5yfWVN7LLa4rvZ7pE6f/rCIcuZ2gw/q682X0LV9iClo17tzR5GAgpUlpCcyRz6vKJQqmMNgCTPu8lWpymLDNGFhzFO+BHdMvPO5/TaXheA99/kMgBPRggmAwLfUb3Kewby0ZwtkkkaOiuneFFMfqUGiBkR16SDRCfljbLnYe4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7946805a-c366-4106-b0b3-08dcf0f94ed5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 11:21:14.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WHEOpYOYnAv1MKTOGJR3TTZh4gHl5o2x7lHN+CQVK8ibFPBwJfufl1Tw/iRix2PmVmcbcsxaKPjdEkcVbPKaIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6487
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_08,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410200077
X-Proofpoint-ORIG-GUID: NubULWGhOhXqfTRe3pFwzIjWt-nK8NZ1
X-Proofpoint-GUID: NubULWGhOhXqfTRe3pFwzIjWt-nK8NZ1

On 20/10/2024 09:21, Ritesh Harjani (IBM) wrote:
>>   -293,7 +295,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	const struct iomap *iomap = &iter->iomap;
>>   	struct inode *inode = iter->inode;
>>   	unsigned int fs_block_size = i_blocksize(inode), pad;
>> -	loff_t length = iomap_length(iter);
>> +	const loff_t length = iomap_length(iter);
>> +	bool atomic = iter->flags & IOMAP_ATOMIC;
>>   	loff_t pos = iter->pos;
>>   	blk_opf_t bio_opf;
>>   	struct bio *bio;
>> @@ -303,6 +306,9 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> +	if (atomic && length != fs_block_size)
>> +		return -EINVAL;
> We anyway mandate iov_iter_count() write should be same as sb_blocksize
> in xfs_file_write_iter() for atomic writes.
> This comparison here is not required. I believe we do plan to lift this
> restriction maybe when we are going to add forcealign support right?

Yes, we would lift this restriction if and when forcealign is added. Or 
when bigalloc is leveraged for ext4 atomic writes.

But I think that today it is proper to add this check, as we are saying 
that iomap DIO path does not support anything else than fs_block_size.

For forcealign, we were introducing support for atomic writes spanning 
mixed unwritten and written extents in [0]. We don't have that support 
here, so it is prudent to say that we just support fs_block_size.

[0] 
https://lore.kernel.org/linux-xfs/20240607143919.2622319-4-john.g.garry@oracle.com/

> 
> And similarly this needs to be lifted when ext4 adds support for atomic
> write even with bigalloc. I hope we can do so when we add such support, right?

Right

> 
> (I guess, that is also the reason we haven't mentioned this restriction
> in description of "IOMAP_ATOMIC" in Documentation.)

The documentation does not mention the size, but that is not intentional.

Thanks,
John



