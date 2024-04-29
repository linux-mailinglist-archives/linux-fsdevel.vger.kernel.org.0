Return-Path: <linux-fsdevel+bounces-18155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749898B60B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039B81F24F66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 17:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBF212EBF0;
	Mon, 29 Apr 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="likBJE/v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OBytg7q2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A341292DE;
	Mon, 29 Apr 2024 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714413048; cv=fail; b=YZwYMyISpM0wciWtcuiVfz0m1kCrAgqRCEmC/7pfPK9CftkrYPMT3fwa5gb43EQNwtHHcZQHuHuWv1nTpAKK1NRiXXBfujNf3qFHGpsvBkA6Kk5WVSm1TmiSY9v4oPo4yyvl7n5xgj994vn5bk0XuP5zMhyiQUvre6wY5q9e1/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714413048; c=relaxed/simple;
	bh=Lfj7dnv4oK8/tZrWvQrNy4WYdN8nGaWeSFop3om3WsI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fn/ZPOjTEVQIZpoXbzxkuumaUUsIN2QH2zsF8SIhr6oQR3oiWh6v48V1f7dUYGgxz++D9qFcgyvT00Shl6ZDNuTylY1C0q6a3nkYSGqSoUtguRw1Plkltrbpx/34bouyqu4R04m6fr7fg+42Gg61FwZaBEBiMIqgeHSLkBsBGlQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=likBJE/v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OBytg7q2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGwmR9002385;
	Mon, 29 Apr 2024 17:49:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=R5W4dPRDujBA5kLMQBCt7AABRo3nuz6Ha5zCRBAM1Vc=;
 b=likBJE/voF84C/csKKuXZy6kZjap3Ll6yRkZzefpsu2usYWjSYTEN7Q3fsVSEkCTDMJr
 KAbA6Nk+ui6b+RZK3lnu0bu/GcWSYE6I7oQAWYBI3bcL35broeQxH4trNiPk4oR2x1Ul
 2zad6vaERj9Cf0nQ/GTftPgMadWzjUBGqfQ9BB+ZSnQIWhFfvln5emeAbnVXVEaS6CbK
 i6ebIqEdXJH/piONoThO/5JHzHVkspuYROAfiBneGCOu7JQdzapB2QzXWc0BZaOSbEaW
 E5742evpZZEq2fbl9GU351qU8fF480R668iFeCU/BsE3NA5pXsJQ1kcjcxRcsnx7Vkjd 4w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqseu6qp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGRTcs016720;
	Mon, 29 Apr 2024 17:49:04 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtcpxpb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 17:49:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSlZTJnY0MpgoljU7NzMxhHlHQHNo+2nMeiqteuhws/LWZOurzcD3RgUIiqqNfIgwaV/WKkS50YVh6rbW/WoT7YESoJtSutibJoHQA01AsOK8UzWYJmEeh2wpVp5lkjGkjZzbNBrkqXNqUAsSJev/g3hUlQbb8aXaC6J81u/HTafPM+I7H2AaVMf34MX3HqxY+7FU/VI4tHT6xPCtCpG20rwXLNjew8JZyupS+xVvW7z5yGpw4aKcdLQBp+BPftZ14WNxeeMtNgFaXxfy/LpYFZ6FRgjDKywnr0zbX9uXh4ity1D0Mv2FHc48wrMiyeud5KKH5Fy9oS7nrJ8b9qp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R5W4dPRDujBA5kLMQBCt7AABRo3nuz6Ha5zCRBAM1Vc=;
 b=CrPGMZ3DNdfbRxyS/8F+gR8liD+5PA+DuQk9qxHygRj7ptyBZIL29O4+w0313HIncS0uzLPDUWa5bR+wiAgq3ngw+u/IrO4HdDA5H98Fyt782mgsxTAx6jyHhGoPz1e+qT06ZV9Ct52ncJyICFVkenLEDd1DcxZVVYM+HGFfOqNwxsHSGfx7XXLxv/gPDIya7Ov/gGmtuMG/t/T6xA88M+EscNv3bYUDL3W5LWH/BMr1YVXbMiNSVPn9XO8f3tvXVVoDyXkME1gAaFszwXQQp4xuOKaG7iJHNKlfirncDnHkuyaiMgEP5T4mr9giFhDTUYgCQq2EqrhzNUgKLUMJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R5W4dPRDujBA5kLMQBCt7AABRo3nuz6Ha5zCRBAM1Vc=;
 b=OBytg7q2rR8iluTyZjXe3KXyi4aRV1L8q2RSz90CwcKKgfYFAsuvYAD6/XIkqRBmGmDLPn/PGjLQn30xk6YN44w5Jyy9SflvDsMjA6bLUvn4PiHC0wJQGMJ/DaQL1Sfb4t1cjxd4ykJuHmicm2bm6MwjkNfdU2Fs6nZAfum6W28=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6389.namprd10.prod.outlook.com (2603:10b6:806:255::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 17:48:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 17:48:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: david@fromorbit.com, djwong@kernel.org, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v3 12/21] xfs: Only free full extents for forcealign
Date: Mon, 29 Apr 2024 17:47:37 +0000
Message-Id: <20240429174746.2132161-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240429174746.2132161-1-john.g.garry@oracle.com>
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a16b780-9eff-40c4-bd3a-08dc68749577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?BgpTXzLStBBymoN2URJi//MLVrQaNewGIoUmWEOV6BOIbEE3KrT0DMTNnnO1?=
 =?us-ascii?Q?ow7q9js6YXgEN6ZsbipKjBpmdQXXH+IRO3DxdAlRwKm9+qLTon+tpimwzAmh?=
 =?us-ascii?Q?XizKEX7wYu8uycmMkPcD6DYN82L+P/WoGT1RLpxlp4LGFLR3iDepHClt28iT?=
 =?us-ascii?Q?MvwNBjjB4G+h46Y38luyvprRs45nPFZfV87oGkJ0Uv57jq3nuAHhmYL2ZftW?=
 =?us-ascii?Q?w8jpCGS+MBYVXobZXmr4fH3VVQfLvdsoSZILpUX+oXndNFFTp3QoAGZ2tN1Q?=
 =?us-ascii?Q?cWccmeLeiPcR1CFnAMoiXPH893jMO9DfqR8IeU+jvfC/t/AGfxC5h6829b+X?=
 =?us-ascii?Q?k4Vend2LeBak5vvzR9exY+FaWA0NIJ7Z6qmrGblcIXAiQqsse8A4KH2NHyC8?=
 =?us-ascii?Q?wSOcMsng2sbapsYo0XEs/GdASPf3ux9bQVT6QwQxKxK/RPPCsUJvRxITjWdK?=
 =?us-ascii?Q?9g03W09ROERINW/munuZAnnM6ZRXCiWPc3ledE2phTXPJKIUdjGPfsfkzVe6?=
 =?us-ascii?Q?ugGstJFs1xzGW/MuXf+RBgUDuMyBHGngSnGw78AYNdOJ2eGQ+TInm0aLtnu9?=
 =?us-ascii?Q?EjgYifFqQzm+Fz9L+C49sd4daaBdUUhEluI2w7ZyGAnI4Nr9UGX9nvXYd5kX?=
 =?us-ascii?Q?0fwHvcve2KMQppJYVBYV+xoL69t04marqEzm/MiM5nB1C+GaU5AQcJD7JklY?=
 =?us-ascii?Q?00Ue9sTU1VTSvO4zdwpLdc5U7md4rune/p+DPUcxxP9cluinP/uU6ZFZrJWn?=
 =?us-ascii?Q?smnegKl3tc2uF60PxXWE+snwS2we2BPd55OZc58+nxsO4ToCIwVPulYmukFS?=
 =?us-ascii?Q?uu3+l4qmILXo7lFZLnkWZVrGuJNNeosg7jCt6nsec5JkZsO/a5X8uOvg61oh?=
 =?us-ascii?Q?nIfBp6Invy7aL6Wx4+tluyjzJ86wNDTJ2qwpiU2Hbnb3wRr6Va0hnL99YwJM?=
 =?us-ascii?Q?Ae+iNg80s1kfxX4MUnMJHZo1aGkjM4iCoehIgIYW50BKHTbo8FjDvZgLxu84?=
 =?us-ascii?Q?mN0hKMCAa2C3ap+ktXI6In4jMbDIDIqfc2di7okO2mQ6MHf09X4Yb5Tzb9QK?=
 =?us-ascii?Q?aSprFmHkEN0GZjOvHQDR6MBbyyp+ANS4SVNBhykKGoMdLiO+x1+TDx2ssA8N?=
 =?us-ascii?Q?g7JfLpkOlB5861CxGhxzrrpNILl3/d1SeDdzEYuWnIJ9O42LjQWtAbVbn/ZE?=
 =?us-ascii?Q?DkqznESdWobRQ7UmAq+b23pnndOBRq0K34n90GDlp4TZ/Bw2i9mY70lN1XoB?=
 =?us-ascii?Q?dvylNwwPQFgyoslvbc7z1JgYmg29TlfdCy39nNGuFw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UP3KRZPJfLY9H8J3XhlSS/jBiZkb9xIznhOTDUQyzXdD6RtW1fYUN59cBlnk?=
 =?us-ascii?Q?Z3aPJzw43L3Fu32SMBxVUZS+Kn0OPzOfbMz0ONR4Uvq0jiJ3ne6asz5OiuSm?=
 =?us-ascii?Q?LJvdnHFE0kfZWLLplBahLHtSDjtP+Mw+YRbg5z5njP+i5BiIWJWrKcGFKk8K?=
 =?us-ascii?Q?BOtR7OZfCmK90nH0mKkPEXek6Y6K8R2sm0qEACBZD5y83NY3+C3SPPvzCSHD?=
 =?us-ascii?Q?gsucCRMw3Z4w2PrGMYWRoKvUVP5uiPDYshovorIKMyH2y3DkamxBVRetF/wc?=
 =?us-ascii?Q?YrSNiXc8Xuzg7bKUTGUhFFB8KSTaK7NArn9YeQ11m+09L3auW5zNNeV10/G1?=
 =?us-ascii?Q?bJZyuILVt/sILkTyCnUsn8PA73wCbzB6b+U0XBhpk/zDrKsRGYvnybGQ9zs2?=
 =?us-ascii?Q?b4Z+Xr0Q28RFANdAAOHX5HkLIfCBZk3hzF1k5FWlfPITy+scLa6SRLFb1yt+?=
 =?us-ascii?Q?gyOWl3KElnG2H96+xR/EIKbsCCcURBWXeoAoDrloxIag5oAb0GjVDz3sKm5L?=
 =?us-ascii?Q?zstukkQQJd7aqhhpZLG37HJbvZWOT/2IeWl5LN1hEAb/NdsNQejoUEcrSigg?=
 =?us-ascii?Q?4HnLzFJZsI1df46urI5dbSHdqpJBTwoJnvOG2qPgw1TnX2kkSsdmW2tpVUSK?=
 =?us-ascii?Q?My5LxSaxi5p0z54yBAhydY/wNw4Ike8I/RDDE0zJrhUb4R2NaIgQ+0ztjo8a?=
 =?us-ascii?Q?l4uVEsrRvJhVLYaThAkAZYfARwvimtZFuwPB6uLXaJDytuor6To8aGWQTrQ4?=
 =?us-ascii?Q?FkdwYeEH6PDPdi7W2amb0JfrhumnU8Y8A6twB9RUnlmcAz5v7PI5gAxXGO+c?=
 =?us-ascii?Q?LAhdxd0ptc3dDE254m5TY6tMyUyJ5mjRTwzOBWLXv5R99uevHFxHBvxVXR9e?=
 =?us-ascii?Q?driGZf7Yn6v8kAx+bUenHL41iIOebxPmDhsvgVdPMpnQ15tWp8eC2cQXKfSU?=
 =?us-ascii?Q?IamwG+v/NbIgQRlXgpLxoF/oWs9yoV4o6K9XkmzGcH7Q+X+lPnHUguIwZcPY?=
 =?us-ascii?Q?iu+Tsl1kDncwpoae6pRUV07OMTCH0KOM6t28C6KHSiWviJCeK/cbnkDjCBtG?=
 =?us-ascii?Q?tYA1+kMZ9Ia1dyq1CF4y5VXPMogwlBu6BSGrYT6a0gUbLEnoRac+jwKdcFkf?=
 =?us-ascii?Q?PRHhrGEnFx3MI6LZeTeBc9+ZocdGGx8Cr86r+YddmeyZcZlGhJyTP1RDqHGq?=
 =?us-ascii?Q?N46fFQDt7u9D/v12U+EvKKbf9aj4rzCrZ5RRk2a65D/GDg/FhjT44eiU4e5Z?=
 =?us-ascii?Q?v2eCT5c8qODkUeyeKUybcgd9IPINjIfMizoqO8SDT4jijb7J5Q3ljBcpEnUF?=
 =?us-ascii?Q?mG44Zv7iIrhKMNPn0QUDc+A/pEjq6KI5N+YiyitoulzfKBH8wzhagxA9kyWb?=
 =?us-ascii?Q?QcgqScPGs1Q6ytddmQ07RMzmTHDuzZ04N/WBX0NC4mZ5SHYBDLkgpRvFMyiM?=
 =?us-ascii?Q?JuieBcQpuhyFxhDA96VG3f69HSiCujPwxMdPJLozbFC37FJevWJ1dCJstEqf?=
 =?us-ascii?Q?3z0Adit3hLsQpvIKJDyYJHDoUpHHMqAiHRyD6VGCOdrmPBZQzof4AUjK7yXO?=
 =?us-ascii?Q?JzkvxAwCUTVbdWFTa4rBEhgazFK4KIWTT5ivygKhIe+5R9nnrDTiZITh2AEn?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xSxwIh9YK3mFtWbxtdTqu/brVDSEvDxUTU0fZRrjT+VGWbbpuRyKEpGX7oCoVZUqC9DoRri3zFGIzihRAcCHh4hnc0W5PrpN2C/0OtsSwqLFgrU8OXPDaY59qu5i/0eyEvTMMJCqaxotwaG8eawN7DJm+kecV/1EXCV4uNgs0VUn4OU8BIwm/5/8hmemI3an9+qBeKfTfmeu6GB+7dBYAjDE2zLFtylpo0jcLgznhhfGeY7ubhyFtVvd+KDOL1X9TMbVAN9Plnt4CNq6H7tED7qm/n3mYq3fhd3aEHVDF2BOveV7HUWZwPmxwuLe6FIkynx4mCxeqOVekBfyBxVKYOTC562fz/E1vGV49+7zeW+dRMrs8A7gpLcpRKwWga7kDNaCuaVq0NQR5duhYFXe6Rp0L+6eYb5Dvd28ZbyXhr1dzAf/3dVWB/hw+OZwDSbzai++UPYNi38mvKzupvMHPNWKmzQO9UNiuqRU68mkablfZ5iEXHlgzyKyMk2q98vQM7JuBbk8pp9kF7jNk1KQ3NQFQo6atlcICKW3fjpwzWVTUACCiP/jNWgnyzOQTuxtMg4fzxZ1QP4CwaLkjTGQ/CeRIsx0/vtxKG2ImcUXHyU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a16b780-9eff-40c4-bd3a-08dc68749577
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 17:48:31.4206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: casGE9bpcE9Gp7Ptcs7713NE1YykhwxthcxUs3JbnvQeynd2nj96Ki4YgCYL0KX726dUVAM4G9N7ce2JXQ9kpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6389
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_15,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290115
X-Proofpoint-ORIG-GUID: UADoqFf8zx7YVw6YBSeZQm5wU0rBvb4p
X-Proofpoint-GUID: UADoqFf8zx7YVw6YBSeZQm5wU0rBvb4p

Like we already do for rtvol, only free full extents for forcealign in
xfs_free_file_space().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_util.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index f26d1570b9bd..1dd45dfb2811 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -847,8 +847,11 @@ xfs_free_file_space(
 	startoffset_fsb = XFS_B_TO_FSB(mp, offset);
 	endoffset_fsb = XFS_B_TO_FSBT(mp, offset + len);
 
-	/* We can only free complete realtime extents. */
-	if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
+	/* Free only complete extents. */
+	if (xfs_inode_has_forcealign(ip) && ip->i_extsize > 1) {
+		startoffset_fsb = roundup_64(startoffset_fsb, ip->i_extsize);
+		endoffset_fsb = rounddown_64(endoffset_fsb, ip->i_extsize);
+	} else if (XFS_IS_REALTIME_INODE(ip) && mp->m_sb.sb_rextsize > 1) {
 		startoffset_fsb = xfs_rtb_roundup_rtx(mp, startoffset_fsb);
 		endoffset_fsb = xfs_rtb_rounddown_rtx(mp, endoffset_fsb);
 	}
-- 
2.31.1


