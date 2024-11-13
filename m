Return-Path: <linux-fsdevel+bounces-34666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 448659C7802
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 16:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2B47B3D344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DEE1531D8;
	Wed, 13 Nov 2024 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oZ46QwCJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sEokY4WP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976A145B3F;
	Wed, 13 Nov 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511184; cv=fail; b=iIha3M+wzdXtq2KmLCbUdgEeYJZD3zWv72Lo58YiM0mJgV8KNJeFJM4VByjzp4/y/QljflsDfgjW0Z4PDXrU0Vi5iroBVHWJwQxLDbfVGXTWvhztMwRC4tpcXQMbD74lMer9nqR4yfyIkjTP2typvv0HeDPPVk/NNPGwW32AiA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511184; c=relaxed/simple;
	bh=OQH+Y8jBZ1fOXlclkElY8LU0WRf54rGLl/S598o37XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qqNOdJ1KouY4MRbXLcSL0+tzYW8qU/GcFo8GIBSLfAv+fCz6IJ8eU5iQQYu721EVwj4TR36DZsokWF6Ob0esUWDBxDso5MGSb1UV/5V1mtRSC0/jkENFpXdK64JF9M4C924gq5kFgV9hSiumxiZrSV6O4qefaOYw5xRK4VpjymM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oZ46QwCJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sEokY4WP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXX3G013710;
	Wed, 13 Nov 2024 15:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1k5/jnxLOdjTh3tuycySAmK8NNGVK0tRyKEakg6iASU=; b=
	oZ46QwCJh+wPaInzzKfhUSo58KrS1rD8+TFr5z3o84L9A2/c/uTf4YiBBDu6A48v
	HBNWznC0kMoz3KbmtrXs86P7UuBgDEvTQH9spf6HTMBhzYZ4ejjsx/4Hj1Lil01H
	+J83EPOVhC4DOR3P8+GsCaZkYwPeG48BkmI5i9TXXuvLLJALjd1DIXOHlalf7QND
	BEvSG2lwYKfkMQgA/N+XURsPRReMZWj8NCQTa5Mnwrc4g64rPPmYY9VNaGeJRod2
	g23I5MPheFwFh+Uw58shkvZPiWitWwehj/msaxtzdntTQu+S0Fs27Y68hXHB4cHg
	GWMfMCI7QSsqKxS0i3dJTw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbf5n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:17:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDshl9025962;
	Wed, 13 Nov 2024 15:17:48 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69f37k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:17:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVw8PrXFqLD3Blc5C5ihO6spZroQBJ1emW+vi0WhvSQd0CH1Q6LJlcU2+tsP5qcgCLGPNEGd796Bchk7jXtVydeux6mHGxzLp9jwTvIoSaO/gfXEAPfPH7El/op/E3MNRmoBcZHp8Y3fnfU+/aTipcQFva1anxeqIo8D+UTXDlLQmladfA66VSBAD2Tf23Dnl4DzIm4ONMugOk654OCpXtj4HR4+9YFofWaV5I066LdnX55H+jrfROUzggHw9SoaqqXV6+N6dPcqC+dlOY+oFcpD6e3QiYERsVHe8spdYDIRRWBRm9dH7cVEP0GMtHnEWfcuN7GkfLR/ab81ceRHTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1k5/jnxLOdjTh3tuycySAmK8NNGVK0tRyKEakg6iASU=;
 b=Fvt1cpT3hFZ1YflpzmR91au3KoUqSSI5GdqF12y2eEMMQLg6/OdxBKvTXhqSYjENQnDRPRfExeKpCnG24tuk6Je3i4r6I+0jj7mBjUf8v+PdfuY7Y7D7g9wy5SUePXKvnEnokNi0d3LoK5LAs3ii2LL3C1aa0xEowZoUZtfIK5iOS0jwpiy0Ox2bf4RRBmNZNy/MPNEbv7azXFIf2d9zeyNnuDVXxqZSN4t0GlXpS5Arz7/5ZxNlX6AumZV55A4TXc0XnTjDFStUkqw0tGsLBdS6/pnnQRy9QunXoxrVGoSLJwbvMEzHoZ6Zy+hq7nnJ5fenWnbdZRvyyw75dOXkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1k5/jnxLOdjTh3tuycySAmK8NNGVK0tRyKEakg6iASU=;
 b=sEokY4WPgMw9D2mDBEsGFfWE/ITsiddXjdqz+tzFKo6CyhDYHb83ERLNXB/VQvUuyWQxBLtq4p+uGKGeOvoaesu2xhzUepN7y+a6s6cvAqpOumuldJbSeZIoGBlxJPXdGEXvpnXNcnW7klYz9jqAmlxZ066ACfvnHBhkyEjh3/c=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SA2PR10MB4713.namprd10.prod.outlook.com (2603:10b6:806:11d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.29; Wed, 13 Nov
 2024 15:17:44 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 15:17:44 +0000
Date: Wed, 13 Nov 2024 10:17:39 -0500
From: Chuck Lever <chuck.lever@oracle.com>
To: yangerkun <yangerkun@huaweicloud.com>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, Chuck Lever <cel@kernel.org>,
        linux-stable <stable@vger.kernel.org>,
        "harry.wentland@amd.com" <harry.wentland@amd.com>,
        "sunpeng.li@amd.com" <sunpeng.li@amd.com>,
        "Rodrigo.Siqueira@amd.com" <Rodrigo.Siqueira@amd.com>,
        "alexander.deucher@amd.com" <alexander.deucher@amd.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "Xinhui.Pan@amd.com" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>,
        "srinivasan.shanmugam@amd.com" <srinivasan.shanmugam@amd.com>,
        "chiahsuan.chung@amd.com" <chiahsuan.chung@amd.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "chengming.zhou@linux.dev" <chengming.zhou@linux.dev>,
        "zhangpeng.00@bytedance.com" <zhangpeng.00@bytedance.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        "yi.zhang@huawei.com" <yi.zhang@huawei.com>,
        "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [RFC PATCH 6/6 6.6] libfs: fix infinite directory reads for
 offset dir
Message-ID: <ZzTDE+RN5d/mwUXl@tissot.1015granger.net>
References: <20241111005242.34654-1-cel@kernel.org>
 <20241111005242.34654-7-cel@kernel.org>
 <278433c2-611c-6c8e-7964-5c11977b68b7@huaweicloud.com>
 <96A93064-8DCE-4B78-9F2A-CF6E7EEABEB1@oracle.com>
 <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73a05cb9-569c-9b3c-3359-824e76b14461@huaweicloud.com>
X-ClientProxiedBy: CH2PR19CA0004.namprd19.prod.outlook.com
 (2603:10b6:610:4d::14) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SA2PR10MB4713:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fbeb35-0976-4106-9a01-08dd03f652e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXd3d21ITUU2VUFWTUFvZ2VKMTZBTDlTVHZHUFcrekF1b3A5S1o3bXF2M0tq?=
 =?utf-8?B?SFk4YkIxcWRtS3RLY2NHUVdzdUV2c2RVd2dNSEY5ZXpVb0pDRUo5eEdDQTNj?=
 =?utf-8?B?QkEzV2N6aStTdVd6eC8zdW9DSTl2WVFFM1Uyb2o0WVZzN0lKUXdtTFIzYkQx?=
 =?utf-8?B?NjJFdVd5ZTA0QnFjeC9uMGI1am04M0hib0lkRWdmUnpVd1VqRkJRdTRQREJW?=
 =?utf-8?B?djZoam9sckxBYUV1eEMvdFVKNlFJS3Y0Y3NYT0FYUzB1UlpldGY2RVJ0Yjc1?=
 =?utf-8?B?Z3phZHg4MlREYk1VSWpIbTlINUVMSkJpYzBNMjFsdEdEL0w4bEgyalBRTVU3?=
 =?utf-8?B?dzBXelNSMzFzUXozTVNId1dEb2ZnZEJtMnkrd2t0VkhhMkdyRnpZS0t0RFdH?=
 =?utf-8?B?WVRtZG5YMUN6ayt2SDA5UVN3ODRZWGZ3V3N3WjlydVhuQ1B1SGlxd0REMTR2?=
 =?utf-8?B?eVpwS3JKL1BQcC9oblkyK1pLelZCYkZ4Qkh2VkNXVGpYZVc3cFNKQVNNZVYx?=
 =?utf-8?B?S3FkVnhRR1BPTDFJSmc4dG1QcVprTFBJVHlsdnRNb0IxVC9KNFV4c2E5ajBh?=
 =?utf-8?B?UmFyTHY0Nkd4MDh5YnJrWU9KaDJDamJLTFRKZ0J1TGQ3UDN4dmxRZ2IrUjB5?=
 =?utf-8?B?c2dZbGdyLzZkMVB5aUc4Sm9pL1Z6SFRYR2djbjZWd1k4ejBEZnYveFJLbHZF?=
 =?utf-8?B?VkYwbERHdDRGby9ZWDA4K0YySXBBUm1WNzArd3RlM2JmNGEydnFRU0dUaURS?=
 =?utf-8?B?cis0TzZwQTBoZlZlYjAwRFJSZGQ2RFBhSkg5NmZhOUFTeW45ZXg0WTZ3d2Qy?=
 =?utf-8?B?bWJDTnlWVUR5RGpxQXhNaFZwdnl4UVlYbnVxUEJlUmVsUVVuZ0ZBSWk1SzVL?=
 =?utf-8?B?eG85dmcwS25GTEZCNlVxdS82TnZ4cGs1cTNha3lWNXhBa01QZjFjRGFQRU1w?=
 =?utf-8?B?cjNuOFc5M1VOZ2hLVHZhQjZMOHRKU01Ca1RiblJrMmhVM3Y4OEFWQXRqT0lq?=
 =?utf-8?B?V3gzZ1NjSW1abkd5Rjdva3phcmxVc1JCUXA1Q0hIaHMvVCtmRTBmVVkzZWl3?=
 =?utf-8?B?R3Y3RW1PRVY4cnhDLzlMRWM5VUp0VmoyQnlIa0ZUOGRoaU5jc0pPREQvakVY?=
 =?utf-8?B?NFNYVTJBVkZFS3BUYXFRd0NvK2NqWUROZ3FtejRCKzBtN0s2Ym9RZHk1VmhD?=
 =?utf-8?B?ek84OEVpc29tcEtXdWYvV0dUdWROS2kwWWp3MENFVjFBQlo2WFE4TXR5QWd0?=
 =?utf-8?B?dC9icnBtU1JqenlCZ1FtaUdSVXFyTmg1eDdNRU53aXMwYXhFOWRLR1dkMHd4?=
 =?utf-8?B?cXFhaGFDcnRhQ2RsVVEvVTE3YkNvSlZOazNsMW9XV25GaGlXWHI2b0hlVy9r?=
 =?utf-8?B?cW5TQVIwMG4reElsVDVScGJoWlpnVjRrdlFhZVp6ZGNGU1BrdVBLMTcvdVd6?=
 =?utf-8?B?UFhzR3Zlc1ZIQTVhd3J0V2pRdDd1WWdxQ2J5NmNDdjNDbmhsYzRpSzJSZ1Qr?=
 =?utf-8?B?Ym9zSVdQc3FLR1lJWW8rQWY4dzltejJ0NXNnY0gyMCtpU3dHa1laTmRYNUdW?=
 =?utf-8?B?ZkxvN1R6M2gzY3FodWpxc2UrSlRmcW1DcnNPclozdVdEa3hYL0l3Vkt4QmJM?=
 =?utf-8?B?bk5ZSUZQMGNCekZadTBuSzJkS3hYMkM1OGU4aURjQzZDS3FDd1FFRHNyY2NR?=
 =?utf-8?B?cDFHc2pHd3g1aE5nNURxV1pjdUg5K0h2Ukl4SnIyeDFvRWhUWGVSbjBYY1BB?=
 =?utf-8?Q?J+Cd7tpgzcPz5mEo3QSq4L3hbfsUNEiJdeAYiww?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3lDOVo4QnJidE9QS21BYU5hYjd4T1psNjFkTnlRc2JubkMzZm4xWTdNTmts?=
 =?utf-8?B?d2JwL1RxNGhnQ29VRUZPa29DdEJmMHVNU05oSlE3cjNQd1BmVzZ0cWxLMHVL?=
 =?utf-8?B?bW5Hdm85U0gxQXBZcVlJK2hRMDg4VG5aMVNJT1Rob3E2bzJxcktGZUt2MTFZ?=
 =?utf-8?B?SU5Bc3FoNlM0YTJqc0lqcklXUDhLSXY1dmphanlUZGJNcWhYNXBLMHhOajI4?=
 =?utf-8?B?TVR3UDh5bXdsM2dsSVpEVGVDOXdLQlliM3VMYTVQYkluMmpTSEFPMDRlazl4?=
 =?utf-8?B?RWNqcmM3ejdMNlc2c0RlemxaY3FoN0d5b0Z0RElqV0ZHYkZ0Tk9tcjRxNnR3?=
 =?utf-8?B?NXhmelNscFJySkxLNDVIYk0zY2tOT3IvRGJpT0VVbXUrVXNLWXRXRytCU2xL?=
 =?utf-8?B?dThkWkJZdy9yNXRlNWVrZlFWelRJcUhpeFJIV29PclVnR29SMGtmQS9pSnlZ?=
 =?utf-8?B?MklPVnNSNDJlaE5aN2Jpa291bzA3NDVWdEs0NDJEZUR2QmlvSG9jWHl4RUhW?=
 =?utf-8?B?SHRpbDVJcElWbXd6MDQ0WWYyMDdIODU5ditGdDdPcmpGVVkybHJ3VXdkcjJr?=
 =?utf-8?B?VXROYjI5VXpOSkl2allwRFF1L1c3R1MxR2lzWWF1UWFpbCtSZmJZajJnOFVS?=
 =?utf-8?B?R0g4dHRFUzU1VUV0NllCTENVU1BieG11eUhZWWJMQm9zZ3FkN3BROStnMzBX?=
 =?utf-8?B?OEZvb3Nxd1hJMGF1OGtsTGovV2x1eWZoSmlrWUY3TDhKQXZoS0VrZjJWYjAy?=
 =?utf-8?B?OHZSRTNUb0lRWFU3Nmd3R0lHeDg2K0oraHJDVUlUa2F6Mnh5QWxIb04wQ25I?=
 =?utf-8?B?a3dXVEs0cEJNTTBPdEdsSzF3WWd2Uks2dDhlbmV2WTYwcnp2Z05uOXNvTU9O?=
 =?utf-8?B?ejQvRGh0RUFYcmYxMjBXa1RJdUE5VW9yenhlM2RXQzc2T24yejM0MGk3eEhJ?=
 =?utf-8?B?dXlUdGFNa3BlMnRXWnhqdm5mREZFeVdJejg1OGJyTzhLV3lqdmMwdTJvajR1?=
 =?utf-8?B?bjE5OWhoWkpPSkwwbVhQb1BqMUFlOU9sRDEzeEVmOEhMNTZ0cytVM0xMdVZz?=
 =?utf-8?B?UzRqSWcvWGJYRXkxS2Uxek9KK0pSQVlEOFc4TDFhUjRQRVcvM2Rqb3JGalRt?=
 =?utf-8?B?UHBLRGNvOHg5YXBXNkEvZ2Rhd1ljTXBkbng1TGt1VklNTXowdmJyY3o1TVNS?=
 =?utf-8?B?OWZHZTNJK2xyeGZTWFFXaGhqMkdaSHRJd0plTDVXVVAxNy9aYjE5NkNOcGFF?=
 =?utf-8?B?UnNWWWlmdmFJNjhTYmRXTWVBWGxQMFJDMER0dks3cUtJNEpnTWxqdHBsVWNY?=
 =?utf-8?B?ZTEyL1lEL3FFbEF1cXN4YTFjeHFDSkxpaVFiSXNhTEVvVWkvMElreXp3K3dW?=
 =?utf-8?B?anBCeWIzYWhXMC82VVRFbUNHaVJ6N09VTlgrSU9tb081bUdHY1BIb05keDVF?=
 =?utf-8?B?b2NpL3djaXhDY3VSTHVTSW5abEpyNXAzN1hMbGllU2pWQVRjMFBUT1N4NGFo?=
 =?utf-8?B?SmcycmpJQkZMTmR2bXVhckZ2ZnhadXZNejhMaGU4OWwxTmUrcDdlVnJ6WDl3?=
 =?utf-8?B?SFphV0hQL3hma0dYWkVDWHlnV1prUmhlYytuMG1uL2pWN1ZPZytFdlpsOGxx?=
 =?utf-8?B?RVVBWTFmWmhaTGNxS0Y1ZUprd2FsL3pNMUhWMU91aFdYRXN3ZWREaHNab0pw?=
 =?utf-8?B?MXRpUi9ZNC81MElsUmhiTXZIamVuOXdaQ3Qzdnp1UGNoSUhmRThHSjVqNzEw?=
 =?utf-8?B?cFNZdjkveE1qYVBISlVpT0R3aVFDVWwrZlNzc0VpS0kyMU9JbE81WjdMR3F0?=
 =?utf-8?B?d3dNcGJ1U3hGRkVYTC9rMnFjZGlVT3BheDk4ckZQUHhSY3FnVjdqMlNEUTd6?=
 =?utf-8?B?MVZsdndLMWY5SERRSVdlbDRIOXRZb3VodUZXdUpFRCtPNzNnSVRnTE5HdytO?=
 =?utf-8?B?aTNNK1pQK1R2YzlCdXllMnlJOEZRVDNKWEhFR0R3cXdjeElpRE9iU2JIMm1k?=
 =?utf-8?B?YlhNSGxkZWRJZlBHc1ROSDYrLy9nS1NsWW5jQkVCL2JQYVVxTVFnMmFaSnhF?=
 =?utf-8?B?aDlSWlp5cVNWeURrOFhaUXZiTWFjSHF5d2J5aGN1cGtpNU9NdE8zcU1sU3du?=
 =?utf-8?Q?vB0Y4TCaKlRh0kxNa2CyZxT6e?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HrYMJ7I5H7jm8f+Zm3LLq5AWd+3KaFO/0C9GqzWF8O4CbUoVzzwTLkz97CbkBUzty91IfVO4eXQBaOjpUHCiduFADuQHW2yltGur83ux6YsZydRi4/8gHgEqNE9YozH9FKq8SQhHDUDb6YPLpaFSLfzehTD1g6AUl7UpAWzADGdmBoLqMVAsnZKIKUGhvq8ufw0w+6Y8C/QWWp5RmD3jEQZJfk6sJ+lDx+rS9Y5L5eXzOjKBAHpyeafu7TNrPBOauiw6TYDd+NnhaCXYLtEheE8xs/F4OcoPy23YmB39l5pp1fsthpncK51wLw5LNpOTir9tphhAUO+P6G3mA9CpsaGwgYZ/cE7cuS4DVnhlLpb+G7cIhaiR042HtzdkNREOVKbs/Gg7fiHF+9Q49rDDVp4S2GxFj22rFSp+db0A2TcLWXeIIAO7hHvWOy1WQYX0iv40gdHAjChw0BsFVvJKAu/YWaEe08CuY9qaRwJN1G+rFkgbPhRW6joPObCjhuKt3Wf2OXQAv8dAJ9kEamAyU+b20VE5/6a1rNmYz7+/avn2Cw0+MYG+O9xJib83qB7CDQ9dWmClJ4DNYovpuBUSrR+/a87uDhaAFkPEZUWkc60=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fbeb35-0976-4106-9a01-08dd03f652e4
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:17:44.6086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: poDxpFQj/5nUL5R9zz6f2uw0WYLg5D+boH/OFGVPXRdN4cAOyqszkHMagzzlspAArTDU/3yRml1liErOXNq1DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4713
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130128
X-Proofpoint-GUID: UffP-ALRoxTWXl12vYHXLpca5mBwUW2l
X-Proofpoint-ORIG-GUID: UffP-ALRoxTWXl12vYHXLpca5mBwUW2l

On Mon, Nov 11, 2024 at 11:20:17PM +0800, yangerkun wrote:
> 
> 
> 在 2024/11/11 22:39, Chuck Lever III 写道:
> > 
> > 
> > > On Nov 10, 2024, at 9:36 PM, Yu Kuai <yukuai1@huaweicloud.com> wrote:
> > > I'm in the cc list ,so I assume you saw my set, then I don't know why
> > > you're ignoring my concerns.
> > > 1) next_offset is 32-bit and can overflow in a long-time running
> > > machine.
> > > 2) Once next_offset overflows, readdir will skip the files that offset
> > > is bigger.
> 
> I'm sorry, I'm a little busy these days, so I haven't responded to this
> series of emails.
> 
> > In that case, that entry won't be visible via getdents(3)
> > until the directory is re-opened or the process does an
> > lseek(fd, 0, SEEK_SET).
> 
> Yes.
> 
> > 
> > That is the proper and expected behavior. I suspect you
> > will see exactly that behavior with ext4 and 32-bit
> > directory offsets, for example.
> 
> Emm...
> 
> For this case like this:
> 
> 1. mkdir /tmp/dir and touch /tmp/dir/file1 /tmp/dir/file2
> 2. open /tmp/dir with fd1
> 3. readdir and get /tmp/dir/file1
> 4. rm /tmp/dir/file2
> 5. touch /tmp/dir/file2
> 4. loop 4~5 for 2^32 times
> 5. readdir /tmp/dir with fd1
> 
> For tmpfs now, we may see no /tmp/dir/file2, since the offset has been
> overflow, for ext4 it is ok... So we think this will be a problem.

I constructed a simple test program using the above steps:

/*
 * 1. mkdir /tmp/dir and touch /tmp/dir/file1 /tmp/dir/file2
 * 2. open /tmp/dir with fd1
 * 3. readdir and get /tmp/dir/file1
 * 4. rm /tmp/dir/file2
 * 5. touch /tmp/dir/file2
 * 6. loop 4~5 for 2^32 times
 * 7. readdir /tmp/dir with fd1
 */

#include <sys/types.h>
#include <sys/stat.h>

#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>

static void list_directory(DIR *dirp)
{
	struct dirent *de;

	errno = 0;
	do {
		de = readdir(dirp);
		if (!de)
			break;

		printf("d_off:  %lld\n", de->d_off);
		printf("d_name: %s\n", de->d_name);
	} while (true);

	if (errno)
		perror("readdir");
	else
		printf("EOD\n");
}

int main(int argc, char **argv)
{
	unsigned long i;
	DIR *dirp;
	int ret;

	/* 1. */
	ret = mkdir("/tmp/dir", 0755);
	if (ret < 0) {
		perror("mkdir");
		return 1;
	}

	ret = creat("/tmp/dir/file1", 0644);
	if (ret < 0) {
		perror("creat");
		return 1;
	}
	close(ret);

	ret = creat("/tmp/dir/file2", 0644);
	if (ret < 0) {
		perror("creat");
		return 1;
	}
	close(ret);

	/* 2. */
	errno = 0;
	dirp = opendir("/tmp/dir");
	if (!dirp) {
		if (errno)
			perror("opendir");
		else
			fprintf(stderr, "EOD\n");
		closedir(dirp);
		return 1;
	}

	/* 3. */
	errno = 0;
	do {
		struct dirent *de;

		de = readdir(dirp);
		if (!de) {
			if (errno) {
				perror("readdir");
				closedir(dirp);
				return 1;
			}
			break;
		}
		if (strcmp(de->d_name, "file1") == 0) {
			printf("Found 'file1'\n");
			break;
		}
	} while (true);

	/* run the test. */
	for (i = 0; i < 10000; i++) {
		/* 4. */
		ret = unlink("/tmp/dir/file2");
		if (ret < 0) {
			perror("unlink");
			closedir(dirp);
			return 1;
		}

		/* 5. */
		ret = creat("/tmp/dir/file2", 0644);
		if (ret < 0) {
			perror("creat");
			fprintf(stderr, "i = %lu\n", i);
			closedir(dirp);
			return 1;
		}
		close(ret);
	}

	/* 7. */
	printf("\ndirectory after test:\n");
	list_directory(dirp);

	/* cel. */
	rewinddir(dirp);
	printf("\ndirectory after rewind:\n");
	list_directory(dirp);

	closedir(dirp);
	return 0;
}


> > Does that not directly address your concern? Or do you
> > mean that Erkun's patch introduces a new issue?
> 
> Yes, to be honest, my personal feeling is a problem. But for 64bit, it may
> never been trigger.

I ran the test program above on this kernel:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/log/?h=nfsd-testing

Note that it has a patch to restrict the range of directory offset
values for tmpfs to 2..4096.

I did not observe any unexpected behavior after the offset values
wrapped. At step 7, I can always see file2, and its offset is always
4. At step "cel" I can see all expected directory entries.

I tested on v6.12-rc7 with the same range restriction but using
Maple tree and 64-bit offsets. No unexpected behavior there either.

So either we're still missing something, or there is no problem. My
only theory is maybe it's an issue with an implicit integer sign
conversion, and we should restrict the offset range to 2..S32_MAX.

I can try testing with a range of (U32_MAX - 4096)..(U32_MAX).


> > If there is a problem here, please construct a reproducer
> > against this patch set and post it.

Invitation still stands: if you have a solid reproducer, please post
it.


-- 
Chuck Lever

