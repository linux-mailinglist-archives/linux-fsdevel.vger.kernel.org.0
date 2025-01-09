Return-Path: <linux-fsdevel+bounces-38730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00174A075CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 13:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE2F1657CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 12:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035D8217727;
	Thu,  9 Jan 2025 12:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LXysSQFY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jPZhH++a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B43217718
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 12:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426050; cv=fail; b=RyqdZQBtpyM6DDRHmB7NRJDkoZtZQi4IeUOM0p7BzKIxI4mnyR3tm1Y7HgdKuAxsJgJ7Gi8XBJtUsh7eb3JnuFB+i93l+G53RKG2bVLr2hLtZBd4jHEAqOpBEvjy5cqW7TRVRt+Vet5j93QAD6NWX4wbuyBjxeBtrw3jOWTffbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426050; c=relaxed/simple;
	bh=aXZlQddcOh7FpwrX9UPXYlvx3x3YExnHjsE4Hxc6pbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qHMZ3S+igcwTYH++BMQ6YfB+O9k95kBLmslCRcyQHLhlvwv2RUYZz4kNtVc26zZ4j+7N27uHvyBLEdHl45mv58bB2NEizI2/2XZdK+J8ROzAygfF7mZpe0272HTb8tMPqSNE/MRlwJI5ERgIR9je6H2MSgnbkiRnHuN48mbhsyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LXysSQFY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jPZhH++a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509CBmIS027669;
	Thu, 9 Jan 2025 12:33:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=OscbseinIRJ1KVYNZ/
	LVwe9/lwcV4i10ddKC373p0xo=; b=LXysSQFY848YhgUYfH7jkpWYuc23HZ66ht
	N/rbB4hB/uCL7EqWsHHd1IHIKTt4ihH5ShjXgwhy+0mlTi1v2nBvy+LIScJMnFc5
	znUP8T218iP5nqjrSesn7UzbU4hAHaCjWZyFKOfVv/bH3DOyALOj73vGevK8J/QY
	Rht3vx73gHe6DTUJFY2plPpxdRwYm8CY7/I/2TiGLJnY9uEs3iGScf+Gtbzh+NEB
	ueqw8H34mzkEj9gKsNKpeAWhLFy4DI5GgZo2CRaosiJE2WSLuwHYgFSDlT4OxLpX
	P5Tf7Yq85+6VL2pPf6XkWKzCXq2eM0DRbU7MJyxDGsR+8v9OlGhw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xwhsrmtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 12:33:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 509C3ZwS011166;
	Thu, 9 Jan 2025 12:33:58 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xueav51b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 Jan 2025 12:33:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8uIza1Tikwhy1m5KGRsTcrLYCn1ANpcZjdvkAk7fxYUkqkmKepktEFGEvDeQxG2I+cXVrszrSodzH/4PcfuETvSqLB7Ke+tG6adZjE3gVXdfh+3Kt1sNiIDz6QFedv5YwdIJz9o+UId/tETr318BWsYfx3Bjjqee8WqTpmPK1c+Q+oys00mRh3uQS5WtQ/OFLlYPLC9QBrm+VNWNLdC0QOwcMR5LAnp7HXDW/eYbaGpWENCBbEh6ANxWo0qCZLWSVJb58DMwgXal3aGJ3bW28zZDmB4yUpMbaUp71KNSftZoyDOT/P90vAqxqS0QYx4VpuoeSht7EFbmjRJPj4d+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OscbseinIRJ1KVYNZ/LVwe9/lwcV4i10ddKC373p0xo=;
 b=oaiBRggDBM6P4wQnHdZywJsMGzqC/i7HwcztENbTvfcXUeRgavVQMRYuEVs15coL4s/Q9nL9PfQBy3dncuIjQ8rJKzairox+bP2sTIieMEFpy4H3Ibz4Cuih7zqgOYJZ5kEJLFnYeIZhITBMD9/opTipWiqi1jIU6KTj7vkBBQR/CeBXNbZszEU7oUyayxBJcqBr71QLwq1G+bGsectCbtLvvoOUCFPugqp37LLTPBv9FM/8598Qkf93RWmghrbiWIFRFbl+ZJ0S4TLVut8CS27bi38VSDEA1XSlCHlIXHB7+XVGjx2i8BDu3sDNLrrd+ib6BqP3oB10SUstsw8qRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OscbseinIRJ1KVYNZ/LVwe9/lwcV4i10ddKC373p0xo=;
 b=jPZhH++a0KlfeImAmsCCzmm0OAWolb+/HAQqarlyBcllBncvRa97PZBCNu4IsglE/LhhKFxf6TcGFjSM/IoYtAFujOZf9CaoFvz+QuMwHGhO+cO2e96NUTNH2YAb3mPaxzwTofQpRUizhVQMXTW3Od9hlHoubYydBOVUIG/bYgY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4634.namprd10.prod.outlook.com (2603:10b6:806:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 12:33:56 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Thu, 9 Jan 2025
 12:33:55 +0000
Date: Thu, 9 Jan 2025 12:33:52 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Jan Kara <jack@suse.cz>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <29ad6455-cabb-4ae9-b2d6-db1c09c0009a@lucifer.local>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
 <zh2hu4fzaqrhw5qdbpcspcsvmnczjo7v5q4b65uq7eaz7exanz@ihsk5oa5njfn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <zh2hu4fzaqrhw5qdbpcspcsvmnczjo7v5q4b65uq7eaz7exanz@ihsk5oa5njfn>
X-ClientProxiedBy: LO4P265CA0250.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::12) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4634:EE_
X-MS-Office365-Filtering-Correlation-Id: 84b3041c-0b37-49f3-c90f-08dd30a9e227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SVhtHpyYUEuODGleFUiJfpSll5diq0JtpWon5nWfGsMO/UL6lk2zDKtJ3J/5?=
 =?us-ascii?Q?i5PC0jf4Rs+jZTzBJV8+RtDpHsTHW+VouLjlP9TyeYYiNMPrH55XlREfQvuR?=
 =?us-ascii?Q?wuP7Wyt7Ayt+bQW3pxhXsN6ckUc+vmtn8XkUrvAHRBDct1kRycskcS66k88h?=
 =?us-ascii?Q?6C3g0vyV198hC6oZNWsWVj/doZuLLg9s6hJLW2HF/+SO2T+ltfA+Sx1oqRc6?=
 =?us-ascii?Q?bCoz4WcATjl/iOSMyAfLdcA6Et+03pm6nIIsAvsBTtOLf6UjdToTNKhzQMQL?=
 =?us-ascii?Q?PLhgRCZtqRIaLUoBANm4zLz3TRvyX8w7dbgOE/tMOaW6SZiyetayIEHxQO/6?=
 =?us-ascii?Q?z+Gq4IbQFL38AZuFVYT7fQzvIBr1aU4i3WpPZNYBQnUpt5+G+by92vUOQl2Y?=
 =?us-ascii?Q?USJeiR++5iIdWEeWCOcs+afNyj9e/VKlfNO7dacos/6LQJFwhk8vM2Mgccys?=
 =?us-ascii?Q?LLmARxJMN4YO7Nt+ZYPHeUN8b77f8zZihl0b9M+kL6WLn0J//EjSPt80SEP8?=
 =?us-ascii?Q?7Md1ozHFXXrVU48+FGOEnJ06YW2m3avFLJvUl/Gp4nwOonxI+MuW1D1Ia39J?=
 =?us-ascii?Q?D2BJ7FspB3U15S+ClVeIc2jjRx6jSTLwRhTAb8nc1oXkqCBAF8PGh4Ni8Sli?=
 =?us-ascii?Q?QTnWaommXqk5evdkoCv13R54/J8/+tilD+YJsT+eMohG5bDG8CLcjxIQ+2NV?=
 =?us-ascii?Q?S+IXmugFMSjJnqzIk38R4TyJNjzQIKwQqQ3REpYjhHJcr+hG5nSo+uTueqE8?=
 =?us-ascii?Q?Hw0R5V4fD0kx+VWhqaNukAnCu9elV8t0mOiljNg5Z29evUIPad7sYXlTB1SG?=
 =?us-ascii?Q?CzM5SjDHuwMnZxwm6pUiWEPCQtFv6YP7aRg15wMj+/AKyU56VIW/gI+FNV9q?=
 =?us-ascii?Q?BSpjIu6P6CvoKzyGv4N8f5b1aP1mj1OKnKLnRmD+zLyVyzgI1Zn2HFu79QYq?=
 =?us-ascii?Q?yC1bXKPOMlwIKzdnoYwO6sLHwR1EsOqB2BxVK/qEYEjUoUJ6AskDqxyedfx9?=
 =?us-ascii?Q?RfkWQ4tr20YGJm3XKqlUzbuDOpzgywr9CXgHHH6tO2dQRnSLlLFuq3BHt+sB?=
 =?us-ascii?Q?nLySP/rTHEKiuIxLtUUUrswSi9++48+qHE8yb/dqmp0qyEdkIwbNVBHm7gBa?=
 =?us-ascii?Q?+lrW5mN9g0cLTLq2BiOddwC7yTkuuFUFFCkExyJ5YqBhymDBoT1HAYRukA0I?=
 =?us-ascii?Q?FRH9us3qcO+Jm8wiSMNpq0jaH8VuhioxW8SBkiKAUzXflvzwewXPi/7Qk+vs?=
 =?us-ascii?Q?RG0Va9r2ZTNUYsXlPW13zWrjihuJWj/hhTt9IIHdRrGt8yjIpYmgqZWegWFC?=
 =?us-ascii?Q?PqdFOCn1UB4ZCAov+bDyQFOYD0S5WK9wTwuxy5ixdC/SaA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YuMR5qWqzlinfq6VY+lzBPoSRdrf0NxuWRPq1KY6kLBtcFrTCKEyP/idPaSF?=
 =?us-ascii?Q?ffqUsjupt4e5/wEjv6u/h0KWUaC5lRwVj0lwL3YJrHsEr8+hQ/BUH9oja5gj?=
 =?us-ascii?Q?aGHTohc7EgcGNbY0eT8Qp+keLYNc1T0ZnxGWLto8RYJe2JQ9zLOkwl1Fdpy2?=
 =?us-ascii?Q?H00nB9KJWqvmxRZ02SEW+IIL9xS/zaM4v1LZPmbDYx8qYSCsn4nKvf/0LLwn?=
 =?us-ascii?Q?Cz1soHlcKtC9hgZ0XSE2w3l4o7WAT8zYOr1GzRwclCXenpa2540TSTgEtuDv?=
 =?us-ascii?Q?ZaDdzhP/1g5IAAD1Yrp0J8qoO8EiC/I5+l0bUyOsfCSKZFgF82qyGg6vb9QX?=
 =?us-ascii?Q?iofuH++OIkkLXgKFCtQde0RHuzGN23uWfYMsQksCEFp199U2REHLN7mVXvPX?=
 =?us-ascii?Q?elIr1JsTBUlIzHpjGwbtaoH0r8i5ijVarBPIeRmlGmJEvTwSf54OOL7P78rN?=
 =?us-ascii?Q?HflZX6BQjbbksEWRIgdFW2hIJdVxFOpddRegUX/7M/NT5/WOQFIAExNXKHB9?=
 =?us-ascii?Q?r/Nr/aHn/o1q6D7w8G/9zWhb96lBq2xtrbL5HuHwk9kfwgIpHNvQSV0S9X0k?=
 =?us-ascii?Q?XXP0Efa7zodWUjhjD6qQ4O+RNid7JH1VSbgLVbhsXo0pU93368alHHdaT9Wn?=
 =?us-ascii?Q?m1KtrFIfdOu5QOqJG+osHd9C0CMhVnmDYLJPU8rgHqBBKVMfSJYyvAI2VWNp?=
 =?us-ascii?Q?85bqg81aODHgTS4vjrliKaYbeEGeCzxmTAEfD1CwRld0XonFzB2B/k8Swek1?=
 =?us-ascii?Q?BSARJ/MdeHG2cKImmu4y8T0vC/IcOnj+NQ1ppeuCzl7L4g1IyEFZsyoBEytS?=
 =?us-ascii?Q?kKK7mxrvq/4IiwB6ls8qnulBK8ftIA4rvB0W8GoqBOgaBA6kCtfN2L7tKnfI?=
 =?us-ascii?Q?Z+qb9fcaIWT2T3hKEIntd1bsOAVgE4v2+6uaq9fTD+T5lXk3eLsX0E3SuN0I?=
 =?us-ascii?Q?ZSGqRmIfm3q6gg9FYfFDpjtA8/J7u1oBldXzffni3x54lBx4g430525CKmYU?=
 =?us-ascii?Q?g+yQfSIROXOuiqhh98ZNivS94GCPmHqkGzOVpbukm/+gRXj2zgG39/z2JbrW?=
 =?us-ascii?Q?plhCkJr4F8Yde1whG7Yd8veo7cQSyq2lsjmuOi8qlI94LYlKMLSa7nOzBayu?=
 =?us-ascii?Q?mf/GG4y+ITse9qfQD6iAYYvgLj6zNvZ3n4tHdr88wRWdYj7gjR330QeIr4pM?=
 =?us-ascii?Q?8noPkaB9qYWZzSiYIvW9jdnxXx4AlREEPVc2z3M3/VnjyNsqWkIqhk0gFp3T?=
 =?us-ascii?Q?vhUZySn3XMEyzDsiqhgGbLsjr89S+QTnR2RtqOjeTNk6Qqwb+LVYU2lcyZmn?=
 =?us-ascii?Q?E3cV3+zg5EKCPSCfL1gEbZLAaBlVlYuN1Vn41dTqJyUXxQ3mllr42BRNvCld?=
 =?us-ascii?Q?acLP5y/gCfJUtNc38YoTGA84Ttj+qsIJ5OJmJsGZUYb5AqM3e72v2kglE4+N?=
 =?us-ascii?Q?uugU8UKC20KvfjuJWZYIWlrYlUkMvULwd0F5txhHSNmpUFv/sDtvO3s9rfSF?=
 =?us-ascii?Q?4q59BxkYHci5D9BA+oT8X4dMVUUA+96TTfSTUKeRjIZXb92L55Kjh4/lp+82?=
 =?us-ascii?Q?UAU7vFEwQ3uirigaaHRRvJuc7EVHrqJEzbDHnKkZdO9DDHTDZMaxNTIlpYSu?=
 =?us-ascii?Q?CQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0ofwHT6VQyLXX0KgVLlWhnXGkuk+0ToKCdpj4cO19G+Zgit7/SKo5MuD7TMSvhQJEanZOwncDJOXIVdplOaiarkLUqzvVq01sXQA16PvLmJ7Ypmh7h82n2Oy8Z3A6olW20MAu58Smh1uZTuXBS+KZk7HjUQGWtWzJOdTK5IXY8GGAdUdCZ6JCIPJIbTI9zXDld0p0fTaJ+gP/VItsdrhVoD3Eha2E3h/uTjCKzg0hpgXnuygXzfnnN1uo1oE9oRf3UC0/rzCy8eUPnhPUiRge6hARVbABF3xzGpR8WfPmm1JiOUas6uTrRROaEO9clS7xFmygj6SPvdfp8asP+meoutijd8q6RVuF4pIz/FdNP4a3b+xJjn2hGo1Xvt6J192w0layw4U4uqC2bKkREDG1LyLr7uiZn1P0M5YCLWD884T1Jaur5Gb4gWkovSOQR40xYRUoDerjq0s/Tb8pu/BvUnWAvYL5GfO+p3JSt3D7WhMIF3oFvh1Mx66wYFLTbmlGG2MQtiSLUkg5vKh1bB5dYIG0tEfiZmgwPGFOiqkKf4HaBowCkWuJJWT5FhWENVnSF4AbWIAvyzwBjc4hDBxxwgPDzGIvOyaqayU5dKeh8k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b3041c-0b37-49f3-c90f-08dd30a9e227
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 12:33:55.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jJvvo86JTU9KvXsLQZbsATcdp5X9owNS1A1w2rZ4WNkQ5QlXwLz8Sv0Ki/TP1kOCBSaUvmhOcxfLsid1dxp4frL9Z63ljPs7p6oU9eFxK7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-09_05,2025-01-09_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=944 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501090100
X-Proofpoint-GUID: t7LC6dLskK1klOuSVw4mIFZvTa4OK-Jw
X-Proofpoint-ORIG-GUID: t7LC6dLskK1klOuSVw4mIFZvTa4OK-Jw

On Thu, Jan 09, 2025 at 11:21:02AM +0100, Jan Kara wrote:
> Hi!
>
> On Wed 08-01-25 22:23:16, Lorenzo Stoakes via Lsf-pc wrote:
> > A future where we unify anonymous and file-backed memory mappings would be
> > one in which a reflinks were implemented at a general level rather than, as
> > they are now, implemented individually within file systems.
> >
> > I'd like to discuss how feasible doing so might be, whether this is a sane
> > line of thought at all, and how a roadmap for working towards the
> > elimination of anon_vma as it stands might look.
>
> As you can imagine this has been discussed in the past and some folks are
> very interested in saving page cache memory for some heavily reflinked
> container setups or for various FUSE filesystems. So if someone manages to
> come up with a feasible design, the usecases are there. I think reading
> e.g. [1] and comments below it is a good preparation for the session to get
> some idea what challenges are there :).

Oh I certainly imagined that it had :) Perhaps you are volunteering to
assist me from an fs point of view on this Jan? ;)

Thanks for the link, I will have a read!

I am certainly aware of just how huge a topic this is, as LSF is all about
discussion it's really one I wanted to reignite and to see where we stand
and how we might move forward.

It's a bug bear of mine for various reasons (mostly around the locking,
memory consumption and complexity concerns with anon_vma), and something I
certainly hope to do something on - but over the very long term I suspect -
should work on this be feasible.

>
> 								Honza
>
> [1] https://lwn.net/Articles/717950/
>
>
>
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

Thanks!

