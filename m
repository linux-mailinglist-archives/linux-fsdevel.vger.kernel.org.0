Return-Path: <linux-fsdevel+bounces-54360-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCC8AFEBB6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 16:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7571D1CA0C37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 14:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16362E0B7C;
	Wed,  9 Jul 2025 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qoLnH+8p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n5TO/kcP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50230258CD3;
	Wed,  9 Jul 2025 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070589; cv=fail; b=gVdrVwJ/uYRNsHwkDoX1PMfkiW08pWXkPrBgBE+M8dhQsI1DcC2fG8SKn5le3t3JmCbbwY+Wsfr4BoMGsx28cF/T1QrjJC23U6YfbM3oYCHWfjVOf1G9COPjj0fzLNTOpcJsd3joerpTV+25QFVELwe6FRjO1jgySAuHlcqa5Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070589; c=relaxed/simple;
	bh=DXCfCMHL3AvhMx0THDLFtDguiaDg04AePYfs+6g16uA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=erfIMse1yyrQiv2pVe2A6NrYZZOg5r7bS5f7FmoSkcqc0sB6sfaaT3zTM0Th5rYamAphg5Qyhy5DuVIw5DXjRpLVBAv9iGkI+GDlmC64b6GPeHJIcxy8WZKgHd6644mPViyNiWW2g9yt+UhTfa5GbvEeDEaDR6YFgiLwi6vjV8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qoLnH+8p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n5TO/kcP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569E6pnj027411;
	Wed, 9 Jul 2025 14:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=9zgIbkVo9mLiVm1Zdw
	SzscPhBXxdWg+YVERS2NOzSEw=; b=qoLnH+8p+ANfMMEmtz/0XeCJII+nQwo8G4
	1cnthdZSb1TF/jlpDYaZt4KJPgHp1QA+kz+qN3/B7jzS3US9+6hXwMp/EikOJ0Ik
	affzUSE7wCA/OjtmY/mHzgwbysMQ1NGQNgf2ZgfeqhTCuimpsxPkAzSLqJSzUGQ/
	Cln2TrZBSWTnUuAXcAvPhIST1JaXktvJ0iIeQ0/HzHLxeGARq64ACTm7MgRDQO2D
	fbKXBifwbmDCMgN1c5zY7LOUy56Rb9sxkI15scYXqFNoBPuYKoLGdTjsNWGCIlwA
	QCsG6uddjtYvb05XG3v5EHb2eAQ+gPULEA35+FFa2LLixp244Mrw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ssw68124-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 14:16:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569E2POa024608;
	Wed, 9 Jul 2025 14:16:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgb9jan-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 14:16:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hvibsN8b31e3/YdtyUuvJLX81qz8VyXTteqhhe9Tn67ptdpkuB7CvMdSR1sFo3tR1Mm2L05M2fDhhW5UGDaMHx6GCk8OzKvNcgVvYoH6jodXO+X6fD7WXqj2wigaI5WExJfzihqY0OI+jqYI4kHlq6IFFEwaMOFRCDKHMmj7BTpdhUakbIKrR+ZtOdimwTkIpT2qI2FIH7RYlUiHxFBmrAGd8aerT1RhflU75bhTqGKFJsAUuOXt4qTuH2VZkx2fWV7IwVMnkElS83khbLmawCr3g/cFjt1UjRNnMPqKl1348AZdW7es6LV+ut0bfdqGmR2Hu3vegkmWl6cdSGsOKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zgIbkVo9mLiVm1ZdwSzscPhBXxdWg+YVERS2NOzSEw=;
 b=f+fwdMfIGO7MQPsFv9+hzfP72iE/Af2B/li0wa08sIZNx+kvSZfpvQbWaqcjTOHABZ6rF0dfx6zp8rzwsflvfjFC7DJVvIPYHG+zq0JUszwa5BYJJ4yGYpvesFHQCfy2Lxy9Evyfb91WEGh1ob3pQS9WgCbW9h3gbW+4VuKeS4Fc0vgvrIbdBrM5b5UyB9Db8TtLYHxqrldYZ+E9vruAvHJXH2xcXZ2xObXflSCXa/piqPwkRFBaGzhXRnj+iOoC7zrmJv+1xlwJt7gVQQFPtSO+aqQ+uo648u+OEsnENk0Umm7W9vVJK5upQHpFqeDSwHfmSi7hBHYlTlJ75368oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zgIbkVo9mLiVm1ZdwSzscPhBXxdWg+YVERS2NOzSEw=;
 b=n5TO/kcPJPUCdzb/XiQrKC0FbVxb57e3CiZxm/dFlr0sscPfXPwJw/yFoz2PLbPVTnGPz9nNobcIHvvtqt8LMJeBOPkJc8tvHxEsOHVaiIe84547fNFh10u8QgNt5nkmYLFUePceaLa4Of1FVc89qlN2h9jwl+ajJ/nPJi+Xr8M=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Wed, 9 Jul
 2025 14:16:11 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 14:16:11 +0000
Date: Wed, 9 Jul 2025 15:16:07 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        syzbot+a91fcdbd2698f99db8f4@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] Revert "fs/ntfs3: Replace inode_trylock with
 inode_lock"
Message-ID: <8dcd40e6-5cf3-4886-b91c-e693b38a2d17@lucifer.local>
References: <d18a4aa3-bd7d-4c4b-a34c-48ba7f907ecf@lucifer.local>
 <20250708075709.5688-1-almaz.alexandrovich@paragon-software.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250708075709.5688-1-almaz.alexandrovich@paragon-software.com>
X-ClientProxiedBy: LO4P123CA0519.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: dde968b3-ffa8-4b01-c6b8-08ddbef327b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s6cLyOn7hXueqWOhsEc5IrnHyJxpKzt68n7K4kcK6lLjgv9L0ePWw1/QUxd/?=
 =?us-ascii?Q?JheYk8W4bnO3dPJTuTcL5CtTI0mC4vLDtgQLGb9+rNk1uY11chkXh5HchfkJ?=
 =?us-ascii?Q?PAjkHGdGd2FIT8uKZ1xrcDlEo19/FElbkqTvBbMOVkdxygr1TorZTW9ffQVH?=
 =?us-ascii?Q?xHOSR7XMQt5ECyj2o2zg53oDnRI3AsXUiNVx8zH216AjpCDFFsS8EaS9u+HU?=
 =?us-ascii?Q?YAJjXvyzYoOUs2AW9wo1Ix3lMu5b4RiykE7BuR0/oJ+3QwzK5Sgwlghr8Ix9?=
 =?us-ascii?Q?SLNMppVeu/yEOPoO0qICg/XFpnrDaOo6rK1S8/sY/Aj9gZtFoSsAc+DR4CKe?=
 =?us-ascii?Q?sVl/aTKnWnXCcniSf2LQhMpK8G+hApQluWp9d5VrrCnMawPHklJ8SvofAyyx?=
 =?us-ascii?Q?jja1AgFaHCEMsddNKU8riqgZ5a3tiT5k8ELuX7Yn+lrVfsnCTO8n/gmP/hyP?=
 =?us-ascii?Q?b4BOS98awGtNjUC/h68wQ4wGX37XG/8pvhZLLYlN2DBUFFCQhLzMAbJ6WPqC?=
 =?us-ascii?Q?ZS38qO8Dhu0jUCl2JEVG+ZrKs7GUaRH/pzc4wOMavfStP+EkXDGwYSYDyZ6g?=
 =?us-ascii?Q?YeXxHt7aPu9O+P7fl7Aig43SLE1MmZXUmMx3S0wtOBrLTXTpODdjz0nRbbfa?=
 =?us-ascii?Q?cFVCKaESGw7TQx6V1c1jseCL8IObInfr6QdShxNOylUw3JBmjtaSLZfvjzk9?=
 =?us-ascii?Q?C40M6Ygef8B+kZAUz6ncOgV+WatnFh8LWfzTJ8bMkDgGVWUo5PYf3owqyXxw?=
 =?us-ascii?Q?iH7RUtpMiokOFH5Vns4PXp7oSn621yQNRYHtQeTnf0zswQ2fAQAg6BTtrgFv?=
 =?us-ascii?Q?3QVkpAFh6FAkr5Z/5zfdIgJlHe2x5jyrrFTORl9AXX0SIjMlC8H6OpkFaKQ0?=
 =?us-ascii?Q?8l8ybLqVI6wJ/LhmYxPy1LJwQMZFPulATFH5S9uedyryTORA/o9hLxEi6z7K?=
 =?us-ascii?Q?fV5BxlzM6a2x2OW2yNS4yJOx2Nm3Dm+/KjeXJ1RTBwmj6mqub2GB6e66D6Xk?=
 =?us-ascii?Q?ScfhynBfODDAiLjFkAxACchLECVOH1+ligejW2bhZr3dBjyvf3WJ5DBn1dlo?=
 =?us-ascii?Q?xygyvFSQmqGxPX236mYBTjeWCQCNhWdzlliZucFwT3Szj5zOwvNLcfqC726O?=
 =?us-ascii?Q?qzEYMcYyyScmb34QloRmZmgWrHyj3aWxGUuJv4WCH+T7kgHWK9mFQuSBz0Hu?=
 =?us-ascii?Q?7gWF8UAfr/iudn27XA2OAoRjk2JZg1XuWI4kr28iNeJ+VG91g00s6UFLjQjr?=
 =?us-ascii?Q?LtBbRNSh6TS2qZhGxv7x+BA2U9M77WJREw440Nd1eyT8OMkVKf3LB5cUexU8?=
 =?us-ascii?Q?GcrDPdOEmYFn/vIQSqPpkZTamwAN/tdiGi26D/R4bHAkbifcr+E/2JvenA0r?=
 =?us-ascii?Q?+f5D56hZkbRpsb00Aq2x7zgFvDN5JiTXjD7cW7tENyMRe7AYSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oZ4k99EIV86wZjTMkFcNQzHv/wpdrmVLMNqLv8zjrpfi8D9eFjqluV7Ai0DG?=
 =?us-ascii?Q?a/aZOiERMHzCqZbC2wYMSmRMfdWgkpwFCCeeVYUxMGWPCLRScjK/sRhY/IeX?=
 =?us-ascii?Q?3AJg+DMXl8oUlCqkmERP1XqGPYkzbf/cVytkIpvqFKlQH9Wm81AIcWdobbDv?=
 =?us-ascii?Q?kjSn6CrB4SPVOv+u/wgIlkX8ZfzFFSyVqkKOb4ZtYqUPLETstdt155ER5XCM?=
 =?us-ascii?Q?NAYY2FwMhC1eh6QaS/oPVSxMQICzePKcXhBTsA6ddwlJ5oWnn6Ot4mc/34yo?=
 =?us-ascii?Q?EznyglxDCIAofDdhPKE0Pfxsk7g0gqo69I1j31RJIA+v5Z/0KXtHyBxodeDC?=
 =?us-ascii?Q?m01Zc7BcGk/Q1YUBlMs2lsc5K5pKlM70n26E2w4u+KbcZGSB36Y3gNaajUHn?=
 =?us-ascii?Q?3Yi9ScAO6hSWF370BTkRYGFzmChNchzaNTqFLuk7oOQpSgDkxpM70fd7XDaf?=
 =?us-ascii?Q?CRhUXGnDRwqBNAI49mv4vP5ltMC5j4FxVl7/2HmqBZ2kohQdGg6DBoL3qDU/?=
 =?us-ascii?Q?zQd0IZEau0hCJXCdRQvyRksBH7b3zoV8s+3XBuPLSgt24tGp4nUUF3t9JYII?=
 =?us-ascii?Q?Fq+Kz7x4u9TKC4vtz5YwNoOMTC/9Ww9oBPnkca/1F8mbqO0w6iDGaB22ZVnn?=
 =?us-ascii?Q?IJUmgUt4ml3L7tCEKJn2bIgz+rVK4BAyOel23FjjLKqsCzAlIxz1Dti7NISD?=
 =?us-ascii?Q?2qb36yNW27F8vagG/dfj9nNDNYlA3mG+54aeA4F9IfcrYyNWh1BzTzMD/OgB?=
 =?us-ascii?Q?Zgqf0X7eopQCd2bEUHsyeoNy/iZhZ1tuBrwk7pbe8jt22ktMaQDA3255f59f?=
 =?us-ascii?Q?Oi4ANEcy/MgYutXF9972+LW/I9/E9VXkSAHK9nheUV+5NaaZy7Rrs+wG1OZv?=
 =?us-ascii?Q?pavoUMkYyijbdKTx4foU9h+gpOc/Lj/aI3eVMCc06DAJx4R1vSElyjPqTCrL?=
 =?us-ascii?Q?zsR4PIk0tEPzGOjdRybAJu+aTnBwC1XkVjczQhe5V2Le+IBA2WUcO6bZQzW4?=
 =?us-ascii?Q?AU42FElpvNDyc7uq76hwapfAtP5nssBaGHvVR/uq//6SdXaGADyvH87JWCmH?=
 =?us-ascii?Q?sqdPJSXy/nA8iEhWWbKH/JBzFdlZg4XIUX5uuYUQdDH+GRrxQxI2nDka3IP8?=
 =?us-ascii?Q?8EyerrKQbrkpEggvViY9/RCMCo7SsDv2BEr9OqnwM54onb3uRJQxCY0rDu1g?=
 =?us-ascii?Q?skWLQHDWEHUxDfuW1m27cLVxEx+48M17JizUG8nWplPL8833N10FoQorwDwp?=
 =?us-ascii?Q?dIHr2kAR+LoSFdglCh/sQl+BKwoyUYRxdIlpL9rg5TJPs8awWJyq4sISL4dk?=
 =?us-ascii?Q?NdNdtj+TagwYpGTjA9F+2rqSGlMNWJwWZiQofj92yJeSF37wtT89+IJwp9DU?=
 =?us-ascii?Q?zAvm6aehqmKENL+4lrB8RFgYgzZMyB3/+geZvlZYVz0c2dL3Lzmz/1UaYKKK?=
 =?us-ascii?Q?JaAKXpronpybuXsYJp3T8KF7/1/Utjp90prf12828wHCYAw07dHbfOBIVAyf?=
 =?us-ascii?Q?2IkYRVIM2WjRLIalOqgtpg4rLiJW1KkdFVlRg3rj68qIjGMnzzQoGBmbi3o0?=
 =?us-ascii?Q?BYWKBlAw5XzTjjqEMbdxwYZC9oS3WUGcHVP4LID0+Tmk7QFnu5I9IaKB3sfZ?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qgA2/Bkq+IjH/2kYB81J3M2xZ6dZCCQd9pfTAqt8XMr9M/3Vs7RDYw22qRBLUE1nQ4/wCqSXzYGx7R5D45kBxhUa3W1iHakX5U+GSQgen8aUaGjOMwKWca1YGu+T7QZizPjyfZkABKLYUMUptq919RQ7+tRs5Jd49Nzm4ZG8pCiIKcGacqyHRUg/z9m6yNgMUStNlsXqTIAJyq6iNXcV5S7959e/qlafcsEtXBWJFOF+3aXK/HiJPpiEFzy4jCWSK7Y8+Sc2zQqYadWUQM+JWWpi8itBcRF7Y61nqP2C2QyhZnMGmINlXNdhzZojiH38SSLHAS4CXToEH0dmimgxdatHslmo1dyDtZtTzKX0taOJEDdduAArtlcwQ64tVuAwrcKQ3OqgD6pNBn9X3QzSbcT/2X5nx45jtdbp8Q4fdirZ5bznqvQuAhNym0pwAfqdk7KIpowoiC4xAmv+9b2B1uAhIHVFiuuiSJG3dclmMYz5NCVgFo3V/WhUK1QQYcSV2DlEwWXuawhSx9dMhkhzn8HJct3Y23WuLG+tNMF3EF7LifCOxGJk4MGmFid5vrMNAuTCz6K3xhcelPTHxRNDshn0C+jYOFzMLPIMItaFJYw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde968b3-ffa8-4b01-c6b8-08ddbef327b8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 14:16:11.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gJc75BDPXeELiQG/0HKmNOkCtrV4IeCH4o9BvuUSbcoZj2oPffgu4ioAG9K5mHeLavHvWb3pD0NACAaI1BRix8Q5Mejc69BDEjtH8Lfwns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_03,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507090128
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDEyOSBTYWx0ZWRfXw2pDmO2idQbi 4WOlDeDiX/OuhiMFg9baAtRYGYJKMQPBrB0nNfKThryWIXJ/ujFAOrYc1pQC2ZRuCYNW0eQOPem b+wRxrDUe0nWdz+jnczy2s6xssuT5lvxKTq1hNluK7X0eApRt/UEIT1tmb4bObvcF9RjF9P3bZm
 2/M24UZojXjtXNGhkRInKJoOPvpExZj9pp/rQgZEv77gtAQWtmbzNPpQoEKMcDOx9a1s+xN55za mIsfa9nBLoJaAjbhDhvWYHzQkaKvlm7rasvFZlJC1ZoFJcZ++9u6bS87TrbdCwJKxPRY8KEIeu4 CVEGJcxGEjrBHxbmZxFdsdPt2gcL0DYuRadsdWM0JHeNJr41hQCRN4mSIJ/4qNYkVS1XF5Wkr+F
 PAJyYqoLLGpM1iBYjX32fncShw2zzJyk0pFuXa9dUisd3TLNIuLhcsh0nJvtvukYYsI7WaV+
X-Proofpoint-GUID: m_hVDlgAY0nriKzujyNH5cUmkKF3_pU2
X-Authority-Analysis: v=2.4 cv=KZrSsRYD c=1 sm=1 tr=0 ts=686e79b5 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hSkVLCK3AAAA:8 a=yPCof4ZbAAAA:8 a=GFCt93a2AAAA:8 a=dr-cWorOyDwCWFR40oMA:9 a=CjuIK1q_8ugA:10 a=cQPPKAXgyycSBL8etih5:22 a=0UNspqPZPZo5crgNHNjb:22
X-Proofpoint-ORIG-GUID: m_hVDlgAY0nriKzujyNH5cUmkKF3_pU2

On Tue, Jul 08, 2025 at 09:57:09AM +0200, Konstantin Komarov wrote:
> This reverts commit 69505fe98f198ee813898cbcaf6770949636430b.
>
> Initially, conditional lock acquisition was removed to fix an xfstest bug
> that was observed during internal testing. The deadlock reported by syzbot
> is resolved by reintroducing conditional acquisition. The xfstest bug no
> longer occurs on kernel version 6.16-rc1 during internal testing. I
> assume that changes in other modules may have contributed to this.

Great to have additional info about xfstest there.

>
> Fixes: 69505fe98f19 ("fs/ntfs3: Replace inode_trylock with inode_lock")
> Reported-by: syzbot+a91fcdbd2698f99db8f4@syzkaller.appspotmail.com

Thanks for swapping out the reported-by!

> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  fs/ntfs3/file.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index 65fb27d1e17c..2e321b84a1ed 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -322,7 +322,10 @@ static int ntfs_file_mmap(struct file *file, struct vm_area_struct *vma)
>  		}
>
>  		if (ni->i_valid < to) {
> -			inode_lock(inode);
> +			if (!inode_trylock(inode)) {
> +				err = -EAGAIN;
> +				goto out;
> +			}
>  			err = ntfs_extend_initialized_size(file, ni,
>  							   ni->i_valid, to);
>  			inode_unlock(inode);
> --
> 2.43.0
>

