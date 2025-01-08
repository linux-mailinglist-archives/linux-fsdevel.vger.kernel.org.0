Return-Path: <linux-fsdevel+bounces-38669-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6245FA0650A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 20:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F143A227F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C320127F;
	Wed,  8 Jan 2025 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KflGT3pI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Qd9cYJ6e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076261E515;
	Wed,  8 Jan 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736363213; cv=fail; b=Un12wQnPLBCuVkqTJKmQnLQJ4ZZCAsipI9BsCU9Xe9zmh9cWr47clnC2Ds9JR21Kv9EZkw0gaVhuIbWG/8k7IDqZlTNnCbMcMvCVjBY4CQAL0mz6gTesKZSiTAxXJuXm1Py7bFi3pF/L3Ragqy+iJ9davKlBtZK1w2LezObjuX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736363213; c=relaxed/simple;
	bh=DmGl8spOD8fmL8h9fTcokNcH/wFL0A8sUGkSa21SpOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tg1TWEZAICf7T4V8+S3afnszut9GjZSASbuqpwHLHBPvPAzyLLBGVWvpH0PFeqNFDbCYCUNkZN4KFNcD5Z9ym5L3hzbJ5x2SHqheiO1b0Tsi4AEf5qYMzI6s3eWHdnUr5aa4ecN5vmUyHPSaXFTVuYRQ7rlzq6DvPZ2iio9HKCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KflGT3pI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Qd9cYJ6e; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508INJ2O007890;
	Wed, 8 Jan 2025 19:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=J3Px4HMWJ/bnRtMGRcoRaJEgqt38cAcqLSVZIN0lmRg=; b=
	KflGT3pIUMdQdFwxxA/4EGteV39YB9j5PLlQGZ5lCHNqsMvRd06YKTLqRz0IEXi3
	zNUqVhyeDGidUl3fww41lCnXFd4Ex+11Y9RufF2p3fCAxUuEgzHzksUqAHkfDGgk
	yOGxPyMfc9fbJ8UlTgfHCa/y+iR9DHO3HE/is/nIrz+Qv6EB7UD90xFyXirFj5fM
	98GuDz9bRm4fvpHqcEengMppIJXRq0JJw3kaKXAnozAvBIdRzgVw1BKPux4n/Zr8
	55QRMb2/AASWcPzt5Dga/A9fo8EtUjS1iUtpnW0FMDQtPeWwjj0Lx77eqJBJpsfH
	MXyWKG7KneGa+BHwGwT8IQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xvv9776w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 19:06:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 508HF7jC027675;
	Wed, 8 Jan 2025 19:06:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43xuead0qm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 19:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtymtfsBRjVKXM8n6kNVIDtLJXylnRLa14k9WuHTKSw/ObdUZf5ype2rjhq7KwlRYv4Dk4h5ehLHdC3V5OsA1sU6wC/dySwWegQDUV45HKlRtrDKlqi1G5nh1Kbk8x/0C9o1L7/UQVsJ77lUZkOSp7Y/uNIjDtJ+ZjRH+FRx7Xux6EOYOEZwFgrV0WtebXH0c4Yd+2c2r1078Kvqwm9nTbUcZA3U/3Ed5QfuY38JtCqCzKPA/1XBd+ABd+R+YOd5BNVPXDVEmS3yso5Adgag3YeffFRoIudhOsS+yoEGhwHaee8+9PBhi7pboGuyW6x4tr4mlKdpARIsRXoR7so07A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Px4HMWJ/bnRtMGRcoRaJEgqt38cAcqLSVZIN0lmRg=;
 b=NJLyzmwgdeLIAb6AFUdOKtUYWdnOGgd3Zlxy1uuFqb7mTSgGOJKa/vTLwxcnwveSD/5os0y6KxjJ/e+dEZI/KHoEXQDbhDhD//xuE0PaMcAuAbPcwQ1Rjd9BxmvXQoyKL65/iBAy+zyUNrsowAfHBCNCQuUYvK0bmQFj4lRBDCuHdtFfqzpI8byXR/K32k9iCEVF7Xv1Cvi7rKRhjgxtRFXGznD0vgpv4ulCO9Yn8PeyArvvgxVKEAu0uQ/LV05daSX1UVeJCqpgO+fQ000JAVLYRRtbUBiStoImQWuOpe3mpWkZTdiSus/PbFlQgTZlEMAhPmjLK7YUnYLmIpmsUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Px4HMWJ/bnRtMGRcoRaJEgqt38cAcqLSVZIN0lmRg=;
 b=Qd9cYJ6eYSW2egM/5KPwWSdlzl/YxSnBG2ubNCc+2zzJjhSepCSpCrsa6e8E3UuzeriJrmMEIZBbeQ5I7dbohsYKfiWkJQ3noSMhJ8Na6tGjENGWE9EO6qZHLReVu9Bh3qvrALrrSZIJCVDKUGAy3y7mWdegTK3dkxDaGL9VzqU=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4971.namprd10.prod.outlook.com (2603:10b6:610:c3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 19:06:16 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%4]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 19:06:16 +0000
Date: Wed, 8 Jan 2025 19:06:13 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kees Cook <kees@kernel.org>
Cc: Jeff Xu <jeffxu@chromium.org>, Jann Horn <jannh@google.com>,
        "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        John Stultz <jstultz@google.com>
Subject: Re: [RFC PATCH v1 1/2] mm/memfd: Add support for F_SEAL_FUTURE_EXEC
 to memfd
Message-ID: <e8d21f15-56c6-43c3-9009-3de74cccdf3a@lucifer.local>
References: <20241206010930.3871336-1-isaacmanjarres@google.com>
 <20241206010930.3871336-2-isaacmanjarres@google.com>
 <0ff1c9d9-85f0-489e-a3f7-fa4cef5bb7e5@lucifer.local>
 <CAG48ez1gnURo_DVSfNk0RLWNbpdbMefNcQXu3as9z2AkNgKaqg@mail.gmail.com>
 <CABi2SkUuz=qGvoW1-qrgxiDg1meRdmq3bN5f89XPR39itqtmUg@mail.gmail.com>
 <202501061643.986D9453@keescook>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501061643.986D9453@keescook>
X-ClientProxiedBy: LO4P123CA0353.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4971:EE_
X-MS-Office365-Filtering-Correlation-Id: 53924d93-0925-46f7-7489-08dd301786e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UlpZQzdWT1NrdEtmK0RVOTJDZWUxaFV6VEFPdE5xQWgrakE0UjFSSGUvUi9B?=
 =?utf-8?B?YXFhTFJKWERMRGM1WUFTaXlNZVJCbFpNMENaazcra0s4WmJBcnYwaDVhMTZK?=
 =?utf-8?B?Z0R3bGRLS0VSL0o3NFAyd0oyakJoNUowMGRvM3FKblI2N1FOQ29QOG9LL0FH?=
 =?utf-8?B?ZVlZc1NYTG1lWlhQaUc3aFVSd00rc1FRYk96dUcrSkkyaENDN1Q4NjkzTzg1?=
 =?utf-8?B?cVlodTdKcTUxR0NNTGR3MmZOWTZGbmJybU1iOUQydzBtNUhxbFRxNzVKRlUx?=
 =?utf-8?B?UGt3OG5TNWplc3pWU2ROak5reGh1U0x4OTRSc1p4ekdONkNRWENFQzMvYzQy?=
 =?utf-8?B?VEQ5TUREb3RRN1hpdldoa1FTWUFHaHZKMFNEMllNZmwwVElPRUFzZTJtWkUx?=
 =?utf-8?B?N1lHZGJBbTB0VWI4K0VvRTJ1dUZvczRnakFaU1Q5Z3lXaHpnejBVd3BOSE04?=
 =?utf-8?B?MURqVmRORFVlV3VXUDVBTlQ2QWpRUUxCS1VhL2hxSlp2S1pLUm9XZnRvWlZx?=
 =?utf-8?B?VEc5SDhESHBaZVdMd1V3U25mVGdRanV0bkdSUm9FRWZ2bzlUKzNMZGlZQ3or?=
 =?utf-8?B?dlJLci9ZNVplQ3pNb1FSSkk0VU1jbGVPdVIrWlFEYURRanVoTEtLejg2S0tk?=
 =?utf-8?B?a3RHWS84Qld2TU55amJkeWd2M0JhTFRhYjBGVjRra1FXVDZ5eG16MlVUNkNH?=
 =?utf-8?B?dEVPSWl4UldLWXF2NnFDVDBvQUs4MGxOcnRnRGRlN3hBL3Q2TXhtM1pKMDdH?=
 =?utf-8?B?ZE8xelB4OTZmUkFYb1EwS0g5WEl2MlZoK3VpM2YrV1lHelBnbjZjTHAwZkVw?=
 =?utf-8?B?djA1d2VaT2tlK29SdHdrcUNMbjUwYW13UDVTcmhJWWltdVdDb1BITGRmSG1N?=
 =?utf-8?B?Z0s4Nk9lNnphYkJTK1dtRUtKVHpnV0FkMVRRZGRjNEdBWWk2TWVIK1RwZmlU?=
 =?utf-8?B?NG53QmNDVjVjNDlFcHRocDBnL3p1TzFsOTF6Q2NzNnRERGFhYXpJMUdUMHJB?=
 =?utf-8?B?N21DS2Q2V3ZGNXRIVjNxKzhrTkpMV0I5S1Ruekt6UWd5UjZUb2Y5R0c3dXB0?=
 =?utf-8?B?UFZCVEZ0QThubmZ6VlBscjBJQkJnK2Nxd29KZ1N2ZHB5MmZNWlB4ak1RWFg2?=
 =?utf-8?B?RDJxOXh6R29hd1U1dHBwQkVDRGcxWFROREtYSGREUlgzODN0aVFja3JYL3hk?=
 =?utf-8?B?OHBKMzJzU1VkOGcyOEtDTDA2d0JBdDVnYXVRL3B0MUhWMlpCejFJYlpGaFBZ?=
 =?utf-8?B?TlVRQ3gyUWZKc0pWeWJYa3k5cE5sMVlmNFh0WXBURTBQTUp4VUZneVNxUnht?=
 =?utf-8?B?dmROaDErTWt1U29GdVQ1bVNFOVcyOFROZEJJVFNtOXJ1TDFEUWJmNS8zOS9o?=
 =?utf-8?B?R3pJN3p3ZlV5OVNNMTgzd0E3ZTAzTzNvYmpNRE9Gd2UxTVNhS05zVStncDVH?=
 =?utf-8?B?Y1pEbjJ5R3ZHRHBsY3FPSktBL1RkUFk2clZTSVM0UVFlYTVXc0dSMG9KcUV2?=
 =?utf-8?B?dlErYTMzQUVMM01hK1A3Vk5McXEyS20xSUw4WnNuVzRMVVFnQm1sek1PaGRT?=
 =?utf-8?B?a0E1RHp5R2ZLZkRuTFBWbUJmbXRKaW5QYUVQRERwMFF3R01WMXVBSXJpdkxD?=
 =?utf-8?B?OWFhMFlyWUphMm1iWlF3bUFxdTJiZ2VoRXBXWHNTWTlYb1ZELy9UcDg4b1hV?=
 =?utf-8?B?OUNrTzJyZG4wRjVzKzVxYjdLZnIzckgvSFZ5R3V2eTFZc3owZlF1YUZoUk41?=
 =?utf-8?B?QUg3QnpURUNrY2NJdm83SWpsVU84ZStteVhFcG56MjhnZzdsSFh2ZDdNbEV0?=
 =?utf-8?B?c0h0ZGlweTh2Y3RqQjNySWFOMW5rcXFMMVFqai82VDZWZ2V3ZXhQUW14U2RJ?=
 =?utf-8?Q?hO00HYiaqBlen?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUJrYkhoa0IrWXZtOUpWSW92Y0FvUExZMGc2UURVT1JFZk5kL0hKRGV6QmZk?=
 =?utf-8?B?bi9ScEVnYjh4WGRoemZzcmZDRWZvd1JuUHFDcnZaYksvWXFZYTV4NjV3Mk11?=
 =?utf-8?B?eFM3aENWenBWNHdmQ0xXOThNTXRqR1l6M25HcjV6Mkh1OGkxOUhsWXIxSFps?=
 =?utf-8?B?VE5kQ0E1ZEJMVndXSEp6UjlQVDI1alBEWkw2Q01URU5YVWtXSG5BcGt5SVJa?=
 =?utf-8?B?bTVwNEFxcVgwUHRWUFAvbngzSHU1RjNrQ21ua2o3M3EyQlNGSnVUK01OMlZ4?=
 =?utf-8?B?ZFdveVVkdmJkRm02cnY3NnpreTcwRFJJVVcxTEdQWjVHYm9WM1V1eGJKMUFx?=
 =?utf-8?B?eHdzOUpuOVFCbWQ1cSthQk1Jc0ZlUHR3TlJpb3ZlVFdIRWtGOGxjZk9JZGJx?=
 =?utf-8?B?WGEwdy9TSkJVZWNkaXorR1JsSXpkMCsxLzIzL21XQ0tYY0VySzBDdjNSOXJs?=
 =?utf-8?B?TGwrTXJlb29wRWdmbWFTekszM1BQbkxSOWhxdysxRkpsNlFSVVVxclh0OGRh?=
 =?utf-8?B?OFB6amsxL1NvYlltR0hVc29FN1p6RW1ZMzhRUjJoQXVyK2JOdTFwRzBnTERX?=
 =?utf-8?B?TU1GOG5VLzN0UTZObk5vbmw1L0diY2dPTE5YbXJyYnpMRVRqUDZTc3NyZDBx?=
 =?utf-8?B?Q0RpdFFrQldXdXYwUCtJTXA5OGFUdXBtNDZFdHJvRHBCeTdCK2p6TWY1Zk9G?=
 =?utf-8?B?MXJnVTRTaGhFR2dEbFZaam1TaGhtR292M2VqTzZzNEhCSGswSkxBYXVGaSs1?=
 =?utf-8?B?bjVGQU53ejdYWHZpWDVGR1E3Y3AxMjhjSS92eFpyT3Y3d3Q4aVRQV1FvRzRh?=
 =?utf-8?B?VGZ0QTZjM2JKRDM1YWNDRmY1VFp4eUloTlZiM1ZhbkNEaG9zWjZ5TXBqQ2w0?=
 =?utf-8?B?dGFuaEdjNU04Nkg2bjVGV2MwWi9FeFNkN1ZGNDREbW4wb1ZYd2ZTeXlXN1ow?=
 =?utf-8?B?QWwvNitWQm5SVmh1K3o5WDUzT3JBdTJYbDVVbjlsNmxPdUEvMVgvUmdsYXJH?=
 =?utf-8?B?NFR5Ny9xQldMWnlYbURLbGVQdDNSWTRWcitqUVlONXQ4WkR3OE5kcEJ3YUVB?=
 =?utf-8?B?WFlUM3hBYVRHdVJ4dk1YclZ4aHhXTUJxNzU2MGZrUHN3b1NiWHZzcGF2YldL?=
 =?utf-8?B?TWFiQm1BZkJ0ZXQ4MlJJZ2dtT0pNd2ZFQnpuZ0FoOHlOd0FCYjRjMUhFNEYx?=
 =?utf-8?B?TDVmZGVJUUxNbkdsZTBoa1JpNXp6eXJLdG5iTjZrYU0yWlFJbEpKWEFaRzQ5?=
 =?utf-8?B?LzdNWUJhZzVaVnBkR3M0V0RRLzVodE51ZlFNMjhFeHA4SlpqbUV0WGl6YmVn?=
 =?utf-8?B?TUNLY0VteVNWekhJM0VEYTZvRzRtVWJJb1hrbG9ER1NxcXhDUXVkalRiYnhM?=
 =?utf-8?B?d0ltR1JYbjlJeEhnM3VZVkcvV2lqV293Z054a2dGRTZjRC9SdXNWZjBDcXE5?=
 =?utf-8?B?VE41anBsSG9TOW5EeGFYcFFDWEJ0VHl4U05FU0xzTXpsMmxWa2JIVEh4Qlhl?=
 =?utf-8?B?OTRmbngrM296REdlKzlCSGZsaXhLaThpenJkQ2RJOFRyaGxhYlYxRG1NZm1N?=
 =?utf-8?B?L3NieWRzWFJOaVpZVUdsTEVJeHRhMGVDbzhuYi9mc0F6SjlKblpZazRYdk94?=
 =?utf-8?B?SUNtWVUxdTVuM256QW5JQWhQc3Q0MUxmOHZ5b0JzMTV5WXZyTndoQkN0TEs3?=
 =?utf-8?B?eDMveWo4VUpXY29wVjhuRG1xWEFZQUhFbGs5cjBGVzVUS1JialZTMlhMRXVl?=
 =?utf-8?B?NnFUdkN0UHhNb3d4aExQSU9zU01Rek5KZW9yc3g1dVNPeVVGdWhPdFk0dkdL?=
 =?utf-8?B?dFkzeDZtRnFac0d6QXZ4b0x5b0RzRkhzVUVGTEV4cFcrWmo0VWNRNG9tZjkv?=
 =?utf-8?B?Nk1SNEVwOVZTSlIzWmlpM0ZJZTgzaXZ4Q2pIbldZa0hFcE5CVWZlQXJocEp4?=
 =?utf-8?B?ZElvakJYUEV6dHoweU5nTVZickhOVmRFNmZHOGNXcTh6bEpGOVJ2bVVjMmpY?=
 =?utf-8?B?QlJBdUZZT2lzL25tZ2Z3em1JTlJhdEtyWWFUZ05lY2UxYzFrOVVOaGdXQ3Qw?=
 =?utf-8?B?QllxeG96VkM0TDA1MjhQZjE1UnNQTGxNQXBVNStTNCtRT0pZcjhycEpsTmI3?=
 =?utf-8?B?cVZkdG5GNFBzNW9wR00xcURKdlJxeVZ0cWRNNENOQmgxRlhUZkcxR2d2UFRH?=
 =?utf-8?B?b2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IM8H9/Y2rmMl9MnFxagM4WK01/u7Dm2ds8GqmbGqGRd+lr+64H1V1ncnnexdpUR+RboFZ81StOtOOMoYuXUIEkj4cFZo3J3aOAC3YNGwWU8PErVUYQottK8AzMxe8kubX/XoBuQvDOP+wOlO1KRIXfbhDI/xhr2BOP+54DTSm9299BJZfG9TGR7jl2m2hbI7nRGN227nrZYJZGY2zwBrHclwFTW7Wi9ah2iy4qTH0VtW80Owtyn5Q1UaRcXcRl3Mf2bOwIZBdD325j41mfcWP4Va1LGgG1gMrZHeO/zNK8Sb8/bwDMbygZ6zr1NvZMADtexUUIQdZTxTF1NpGMDxyc7he4EzTYdtW7Ho99KGqQt60aVHzVFDkyYVvCAjoYNzYaHTg6avwJJXlEfR29aiaPt2yQx4DpBfQcpY9pUGyic8J9HcXSpMnf+TVbIuBCXAsAIPfqhvVBuHRLJzcM5rEz7tinhlWaTS/W5V80fsFsx6x5GqRLAAQg9RagUJY+dxaqLovL/7jWonCTzH/3fcqIpvXQQ8ZTL0Roa+H/hKHxvO+x/UCqz2GXR0yXH7lpyl66in59et3KjM6Ce1W6v78mNLLecA14Qrx8hOYcjMsro=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53924d93-0925-46f7-7489-08dd301786e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 19:06:16.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: alhvnZmWGCobeiAYnZNaRGmAg9BtuRxIipyAl1N3sigSE0YUaqKHlq5gzZxzdJR5cYIN/WFoN2Y0raIqz09CgFoBFMOUrslNQrpeEwK8qXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4971
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_05,2025-01-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080156
X-Proofpoint-GUID: LjPyGBsB8tx0Uxd20zVKvp2aOnoeTzYu
X-Proofpoint-ORIG-GUID: LjPyGBsB8tx0Uxd20zVKvp2aOnoeTzYu

On Mon, Jan 06, 2025 at 04:44:33PM -0800, Kees Cook wrote:
> On Mon, Jan 06, 2025 at 10:26:27AM -0800, Jeff Xu wrote:
> > + Kees because this is related to W^X memfd and security.
> >
> > On Fri, Jan 3, 2025 at 7:14 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Fri, Dec 6, 2024 at 7:19 PM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > On Thu, Dec 05, 2024 at 05:09:22PM -0800, Isaac J. Manjarres wrote:
> > > > > +             if (is_exec_sealed(seals)) {
> > > >
> > > > Are we intentionally disallowing a MAP_PRIVATE memfd's mapping's execution?
> > > > I've not tested this scenario so don't know if we somehow disallow this in
> > > > another way but note on write checks we only care about shared mappings.
> > > >
> > > > I mean one could argue that a MAP_PRIVATE situation is the same as copying
> > > > the data into an anon buffer and doing what you want with it, here you
> > > > could argue the same...
> > > >
> > > > So probably we should only care about VM_SHARED?
> > >
> > > FWIW I think it doesn't make sense to distinguish between
> > > shared/private mappings here - in the scenario described in the cover
> > > letter, it wouldn't matter that much to an attacker whether the
> > > mapping is shared or private (as long as the VMA contents haven't been
> > > CoWed already).
> > +1 on this.
> > The concept of blocking this for only shared mapping is questionable.
>
> Right -- why does sharedness matter? It seems more robust to me to not
> create a corner case but rather apply the flag/behavior universally?
>

I'm struggling to understand what you are protecting against, if I can receive a
buffer '-not executable-'. But then copy it into another buffer I mapped, and
execute it?

I mean am I missing something? It's very possible :)

The cost is complexity. And the difference between mappings which are shared and
those which are private and moreso MAP_PRIVATE of an fd are actually quite a lot
internally (go look at anon_vma code if you have the great benefit of not yet
doing so to see the deepest, darkest, 9th circle of complexity hell :>).

Again, I may be missing the point here or misunderstanding the apparent attack
vector, but this is where I'm coming from.

> --
> Kees Cook

