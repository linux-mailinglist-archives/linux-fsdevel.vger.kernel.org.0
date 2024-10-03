Return-Path: <linux-fsdevel+bounces-30872-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A3C98EFAD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5101F2165A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8B519343D;
	Thu,  3 Oct 2024 12:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YLytmvO9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qLcjBv/j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0E13AD22;
	Thu,  3 Oct 2024 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727959758; cv=fail; b=UFePIl1v59yrWoqKMkEjw5TekgHI0NQ9uaoj0mFrxM5k1CFcIz9iSt67OslEbylvqL1sOnq2NydsIFRKqfQqinH/K8B0gW3Kh/9vnx8l8Tipe8saNZmoApeTNUaSCwm2WPiigBj0Di6zgEgvsUvW15DgsZUyVXklB4bQKRYhQCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727959758; c=relaxed/simple;
	bh=IU9XHPIl59/Lz7132VMr6nbOM1/CG7G9zZytMjwvW9E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=neOZDB9Eb2HeNYoxl0joUtyW7liznQXTCZz6jYsxLYibtvl7uxIqJy7tRTnZm2R7fBHH8LHB3clSXHbegZ3m5mgxCJ987qs2jHJg1IRJbegv3yHt5Rs/qQKsl0BR65a0so/dI4BghsrfZTXgRaA51a95t8OJ99o9QhlL/uZc7Is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YLytmvO9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qLcjBv/j; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4938tdpY024134;
	Thu, 3 Oct 2024 12:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=8uV6UNOK7D99K4Eip0LJ0kc4XwfhI8ZCIWN6BCxyRLI=; b=
	YLytmvO9QTO9ZBezSA0jf894fiZ9B6NCW5pdVEpC/Pa3o2wI7IJefUy++NYyGdHT
	hFk+knfiatKAtI0ljtOaw569fWdnJIRWfam0KX8Jseon7lgQ2JZ5hUYg6aCQvMl6
	Bc8KIrZyBaIMIvk4oa7cTxXfJW7KlI/y4kjP2ehdjlVdqQnKJthT+pwcCx2WLO3y
	Gl/Fbbrlmz+QP6Dz7+yY+LRccM3Uo72rhq4PbMHCkjg9OSSDmw+fIf+DfjqmocKK
	6XCbcKhB1GVuzJUeAbB+049CF2HxR4c5pBe/ujVVtHNN8VtNq3p9JwUWaxNkiu7E
	YosAnSTztJkUGSSn5IViug==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8qbc019-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 12:48:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 493BQQAV026202;
	Thu, 3 Oct 2024 12:48:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2045.outbound.protection.outlook.com [104.47.70.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x88a7h81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 12:48:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9IbJS7YaTTnfOT6KkdPOwHO2tY8oesQLjh97O56+e5lqajKfKDRidD2YUYeG+PQAxVqH4kNWb4TZ54xdkbwspgaJIIOugFfqTVsL6YbHfk6507VZpPZbyq9MkK9b4OYbogCnDln6GQJpT9Ue5+I0iHpZtcwzjeWVK2iZcq/WHFlUNzO1OroG6mBNi7mdoQJ2g/KU/rLmpU1ek+YWQblcv6PXV2yHA0GU0WbiuC5glL2Lx9k6uRytLT7kL7thtDxyfW7MF5Nsx1D+8gNuPRKP60kE4ExVeCmbXnWNGuGzfpS092xzo4DvTm+NiGMFKrgNrVHi62TMFScYCXZpO1/Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uV6UNOK7D99K4Eip0LJ0kc4XwfhI8ZCIWN6BCxyRLI=;
 b=PYVdhN6rweZdJH0tg4aetJjHo2AhvN58vAocmzcolNgnQqQcDXMa4xvxld/w43JA64OicdD9Il4mB0ez/KOpYYehqHWS7R1SLEfCskHdGKmLTn0OWgzsLyc/KSkWB8oA+rRGgGMDz2x5j6VsSZEDGz7jx6mMltBmNxeh/B5yYY2Je4XlhzMknuL55asX6smVdQX26o7qZ40d0Ojp4ezEaeGvMkPhkWoLva0YUiubpPBY/osvW2+lYw29FwRjIMVnJ/p8p7a/Ud0wIjB+1zcg/i4TCONa3kADTmqBM47M31bhj1yXytTyx33grcHETUGlD1ZWYe8d6INEIS7Pqf5KHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uV6UNOK7D99K4Eip0LJ0kc4XwfhI8ZCIWN6BCxyRLI=;
 b=qLcjBv/j6/k52bSQcGpMsXIF6j2t21YeGXKNQwfkXyG7AGF66nb+NxSITuhNvI7/QVMHCLtph22kfoKCetsjSHfyMJ5jpgYx0GdQ/cXyggQrj0obtf+sE3/hyaaaix/7ZenZU9dUYVhHozPMRyl1e9AMeFjeTFcy3WlK+hEtgvQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5904.namprd10.prod.outlook.com (2603:10b6:8:84::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 12:48:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 12:48:45 +0000
Message-ID: <06344e9f-a625-4f6e-8b23-329ee8ebf67f@oracle.com>
Date: Thu, 3 Oct 2024 13:48:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/7] xfs: Support FS_XFLAG_ATOMICWRITES
To: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, dchinner@redhat.com, hch@lst.de,
        cem@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        mcgrof@kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com
References: <20240930125438.2501050-1-john.g.garry@oracle.com>
 <20240930125438.2501050-5-john.g.garry@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240930125438.2501050-5-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0480.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::36) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: 37efe419-f0da-4767-865f-08dce3a9b7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cFZhdXNoVUJ1LzIxcGJONmdzcTBMbi9iSjRPWXJXNlg3TDY2K2V4YWJoNTRw?=
 =?utf-8?B?QUs5MUs5RkgwME16aVROb1B6QkZ2bmtBMEFsL2trWGVqWXBIK2Rqd1lpbHNn?=
 =?utf-8?B?QUcrMlQ3OEMrMzExV1pEUkJZWjRxNFFhSy9nQlU2WERUK3YyT2lLZDdqandY?=
 =?utf-8?B?V1ZLSTBFcFFLR0F1aVVZbVpLb2tFcHl1T2ZVSXY0SldTSnRXbHE5eHJFYldy?=
 =?utf-8?B?Ui9LdWZDbERUazlpY3ZrRFYwYzBzdURsUzQxVEFqOXBwWHdRN3pHYWdDZnpn?=
 =?utf-8?B?dUhBV3NiV3IzNjFzZFk5ZnpST2wrQUlyRG5iWUtoc2szUmNDaGk3Y3BqQktk?=
 =?utf-8?B?Q3I2aGRjV1FiSm94SzVuYmNkdmxpRFVKdjV1dVRHV2s3OGxsTTY4bFJXaUFX?=
 =?utf-8?B?ZFZtUThzbllXT2R6Q29ubkU1VDQvaTZHWE9SY2RKWHRoKzNmaHBOd0xrdFRX?=
 =?utf-8?B?amtrZUkxSHlyUStjNzcwM0JZNnBSR2tmMWtQc2lITm81QWpTL1RDSitmeE1L?=
 =?utf-8?B?dHlUeU9hN21GeWtsNkVRUWE3NEM3ak5NRVp4R0pUb3k2czdwVm5ZdXFOYnlz?=
 =?utf-8?B?cWt3anIxTXNuNGpyN3c1T01LY05jL1VOaWdVMVVVWVR4TXJQZTg2dm05Vi9I?=
 =?utf-8?B?SWttU0lPV1IyU2JWTnR4dUZZbWlsRERGM0IrQWZYK1Y3QlBITC9hTmZrd0lY?=
 =?utf-8?B?a1VzOTBHeXUzaVRzcUpzR2E5bjBpYVJqcFlWdXdIMkdXNTBHdWR1bUNUUHBT?=
 =?utf-8?B?d1lqblM5Qmx4WmRKQ0t2KzkzRU1yU0pKNlg0UHNkS1pOMHd3S05hVngrYSt4?=
 =?utf-8?B?SDY5R3F3M244L3dxOXIrdG9rVGYrTm1wZEtFeGNpTG1PRUR1SG1qRDRwcTBh?=
 =?utf-8?B?d00wM21jNFFLUVVSZUN6dUQ5VmVhQVMxK2l0MjBXU29CMTRCTTE4anhJQzBF?=
 =?utf-8?B?alljTmErVERvanNBQ29pemRGanVXNStoOTErVXdtT2Zlb3VINUQ2L2RvRmFB?=
 =?utf-8?B?R0EyeVFMalZYeEt0UEl4R0lWdHJRV1VENjF4OFoxeTVxL0J1UnRDMEtkU083?=
 =?utf-8?B?RnJNUElraDl4Y2pSRWhrYU9BZFFhcElkNWdtbG0yZ2tOdnZTZFQ4bDBsT3Y5?=
 =?utf-8?B?VERVTFF1MGdxVjVHbnlUWVlIOCsyYlAySWRxdWRRanJTbFJ3TzBVUVUxRkpK?=
 =?utf-8?B?TytaOWFKZFU2bU1IYWoraDJYeXZWeithUFRCejdNR0l1VnpJWWJYcUJVaU9x?=
 =?utf-8?B?UjY3RysvSDJTTy9QcWd1YWFIRjk1NUhJU1pZZnFDdVVPNGlvaC9IK0dWZURi?=
 =?utf-8?B?ZlgzWHpieHhXVnMvTE11blJzTWZhbjUxWS92dTQrdy9ETEFpUXVaZkEzbW80?=
 =?utf-8?B?Vlp5Ymkwak1ySno3Zy9kaWYvN1ZnWEFpSHhMQUZxRVhRQkhiNE5xRm5qQmEy?=
 =?utf-8?B?KzlxdHFHeDZzQ2tRZUUyQ0dicXBoKzRRNStxbXlza3IzU3ZsQ1g5dGN2WmxH?=
 =?utf-8?B?RmJxUnVIZm1tZ0wrQkcvS3dRV3pDQllyWnU3WjZmNmI5Tzl5ZUVkRHFFT1pa?=
 =?utf-8?B?SGRMaFFoRVhrRjh6ZVdXMmZIY2ZlaVNHNXdRWDhydzZkVkZFUzUrMmtLVXN1?=
 =?utf-8?B?a0V3dXJzb0JUZENPQklNMFlvQnVFck41S2NpOFd2Nkc3bmN1QWxJdE9NMFVR?=
 =?utf-8?B?bXhLTUN2NnRTM1FOQTAvajdZeU13b2crVmtyWDZQaDhQakI0dlhobWx3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGtieDI4YzV4QWRGMnh0QXVBZ01mRWtzQk1kcEJyZVE5MW1BQVFhdmM5blU3?=
 =?utf-8?B?UDdET0Jic3BhY3M1M3pFYkxzOW1iSDRGTGt1MUhMWGRvRFB3QzBYejRNYmtx?=
 =?utf-8?B?ZTNzbjVEdmwyblhMMWx4TUlLUldtZ3dZLzFZUytsRlpBdE56WGZNeG5TZnI2?=
 =?utf-8?B?V2NKa3dtMHF5cTFGTnQ3dXlpajNkU1JIL0p1Vm9DOXluQ0c4THRpWm1nbklU?=
 =?utf-8?B?b0hKT3pQQVRoRTl5QUxxb202d05VS2dhenoxWmpUNDhPRmVPdVRFTncrV2dw?=
 =?utf-8?B?MlIvMDFPc3g4OHNkU0xSTG5RWW5EMzJYaVR2TEt5NDhWZHFGdmNlR3JjZSts?=
 =?utf-8?B?THBlTGplelFiNm53UTdXNVFDMFN6eVNMTkRlaWxQenlhVjBqUVBybVFlQ1Q1?=
 =?utf-8?B?ZUhhSjFzQ01NK1MrckV0WUpjeWRJdENmYlJIRXVJV0lEWUdJSGxhNi8yUU9S?=
 =?utf-8?B?U2F0Mk9qSzJBYkVlQUdDMkNEQnl4Z3g1eE1UbUowN085S2JsTSs4VHhzRTU2?=
 =?utf-8?B?SkllRVVhaWlka2Y2WkFIV25Ud3pjUktuWXpIOHh2akpyVlhPYVdQZS9LeXVW?=
 =?utf-8?B?MjY1c1p1TUlMMkhVVVQ2cVgxTnltN3BQaVJteE5sUzJnTGE4S2NscHpmVCtG?=
 =?utf-8?B?UTk5bmsycWJnajhEYXdlc2kwem9GK1NwQzlrV0p3UWJPN2NjYkdWL0hIcm45?=
 =?utf-8?B?MGwrVlRaa0tDeWZQQXRFRGpOWnREVnNUUzR2VnprQTJDcVM1a1gwbUd6Zktu?=
 =?utf-8?B?MjA4RUhQVUF4Rkc4V1ZWMWYzNi9VZmlPSHV5K0lyYU1BVW4wVE5sWDJIUVBG?=
 =?utf-8?B?eHZjZWxQUXJteXlTcncwZ01FUHNEMjBUZC9pSzFrQnRwVDQzLzZOY0JXMHU1?=
 =?utf-8?B?ejRKYzFod2RhUUZDWVRQRGZua2NZd01VakcwTkJBUnpIVG1kY2k2YUxGQ2xX?=
 =?utf-8?B?QWJBc1dkaG05emZ1QXFxU014ZUhIQkt4Qi80NG9OelduL3ZPenBYYWpEcWdi?=
 =?utf-8?B?NUVLRkt3YnkzRVVCZE5CZ3AxdS9mWGZTcG51bGlTeW9hVnR0QW5nYUpOaW9Z?=
 =?utf-8?B?dG9lZHpsR1BmbHMzcXRoQXBBd3dueWpWYTlrNlkzS0R5U3ZTSUIvVmxNbXQ0?=
 =?utf-8?B?N3hwZWJieVU1SFNHaDlzbUdqKytOVVpoZFY2bElBaVI4VDZwTnBuRStYc1Zx?=
 =?utf-8?B?VTJidzgyN2MxTHp3YWUyUnZjbmNkc0Z6b1VnS21WNUVRd2M5TTIvSG1uc05q?=
 =?utf-8?B?L0QzU0xiMjBTdnU1VUdOVCtGRE16bStGNlplT25mNUxGOThJL1dEdGNoY05O?=
 =?utf-8?B?emJ2Rkx4VEMrS2FmTEUyQ2NDc1V4RzZ1VjE0SXE3dXNrdHhqTitTVk9FdE9J?=
 =?utf-8?B?QjZQckF3N1pLN0NYTEV0YmZudVUvaGEwSzV3Y3l2SjB4OTdIUGROYkRXbXVs?=
 =?utf-8?B?Rjg4WGRTM013NElhVnVibnlVR2wvRGdOVHRlcUFGbGpRY3ErRzJZbGtBTktk?=
 =?utf-8?B?cmpkSkR6UXNVZThwd1pGRHVyWno5WnQwVTZjTEpOSWVWYjFCVG50SUNvL0VS?=
 =?utf-8?B?Ui9KTEJORko3bzQ0TEtpTTd6V1BwRXFtWG14cUdoRnRKb0FJbEV2Q1Jqb1pD?=
 =?utf-8?B?NEJlRHQ5KzFobHNyQmU3cU9RcWFjRmRSdWppS0ZUMEd1cTJnajZlcUFsWC9J?=
 =?utf-8?B?di82M1BFdTBZSmZoUVIrN1h4dGxYemJKL2JPd0J2azNYbW13bnlKMWxrMmlr?=
 =?utf-8?B?b2FEaG1lbWJuMjRZYlBGcW01cTNFTEIyWUxpWk0rU3pvOFJLdUhnVTluSjU4?=
 =?utf-8?B?bGlTdVpsWERVZVgvbDZRWXltVVBXeXZTb0p3cnc0Y2NlU1NlMi9jV3ZqLzRR?=
 =?utf-8?B?eDFvY2NRQnA2ZFNNdGZBRkFuempJOUYwZVhNVDVJSFh0VVZxcDFrV3hPWHJ6?=
 =?utf-8?B?WVFLbm42YTlYem03V21hZEVlSE5LOHh5TUhsaGpXek90Zm4wMDBnMXB6Unow?=
 =?utf-8?B?blRQRWtvZDYzeVhiWFlkYjd2cjZRcWtzeTMrQ1JveENpTjZFY3hxenV5QlB5?=
 =?utf-8?B?VzdSQmo3SUc2cXZyR29ibkVoOVFqTlZzVGJvOVVoeXNKQXJDRHBVUjBxVUZ5?=
 =?utf-8?Q?DE2O4hD7Wqu5QoOBW8/TmbJvR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	w/ZvlFOz/Ea5MY3PajVZYz8Cw3ZgA6M+bH4hGvxowWqRDvJ+xivo5Dn1/hOKASH4qqH/zrkHphhsfveZZqUBc4bgk9qj8Dx+Wko3P1XvqTD5aCqJ+DZfAMkYTcsIUxHRTMxfGJWvbfJyQQajqumeXhufXaONOKnmDOAOSsfYYpe2N5wnFZCbSEulIqVmtG9mmC9YJpPYaARx6yb/EpH+bWhRmtohtQVFov5JgE8IrtdhO2wohETvsHLHEG5XyALjyOVWq6c1GFw8QYk5Bxe+XtBb2zu7XXFQ+tYGyDpxPik26FOzKFDZTdnFYDExTIjZ9aYocDlJF5xow4lH2iCgTirQQWKx6Sl7yc6scZBKmph2JdetY1CT/h8F+UjGoplb2SE6vYUP7ti70DsPaQGveWOe24xAgGgcsWclBFOo6wlmQq7CpdokpEf4Sk0jnZ1R9VRvJqLlCBiD0eUucIxcKnLD0E+DoZoY0EzE5JU4+5Og1LMyCoXEicFWYIprZRJ0coJTxAOOnMl+WuCAFjxOLfbfHZyMPVxMUThFZjth1kfAHGCxMin1ECyMRQiHnGHTTMueY819rezvrWrtPU+KRqW4iZGzCcAxnDKp0hoe7dM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37efe419-f0da-4767-865f-08dce3a9b7c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 12:48:45.4774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1X1KlHrLbyzG1i2Ol0PqXZ/TRWBNAdMgYy2w5IxGL+3w2jQ2P4j71/6qj2xFD/W8AipAtReXNDlCPdfwRdjJkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030093
X-Proofpoint-GUID: egVd0QtfIIH7whOkS_DeR1nGrqFbsE4J
X-Proofpoint-ORIG-GUID: egVd0QtfIIH7whOkS_DeR1nGrqFbsE4J

On 30/09/2024 13:54, John Garry wrote:
> @@ -352,11 +352,15 @@ xfs_sb_has_compat_feature(
>   #define XFS_SB_FEAT_RO_COMPAT_RMAPBT   (1 << 1)		/* reverse map btree */
>   #define XFS_SB_FEAT_RO_COMPAT_REFLINK  (1 << 2)		/* reflinked files */
>   #define XFS_SB_FEAT_RO_COMPAT_INOBTCNT (1 << 3)		/* inobt block counts */
> +#define XFS_SB_FEAT_RO_COMPAT_ATOMICWRITES (1 << 31)	/* atomicwrites enabled */
> +

BTW, Darrick, as you questioned previously, this does make xfs/270 
fail... until the change to a not use the top bit.

Thanks,
John

