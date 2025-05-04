Return-Path: <linux-fsdevel+bounces-48001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3F7AA8535
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A12179E51
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129661A9B28;
	Sun,  4 May 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mov0lQ7U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iGJz1Knr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8DF1862;
	Sun,  4 May 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349338; cv=fail; b=B5nMuEmjJNW7hP6vYgbRsZwgtWTEeqXDFNgNeLYUF2TbsxM39/NPKjBZ8Ry39qa53HBPFbZwxO0eLKzfzqAjncYV/lALiT5LtLo7+y6h/k9dJTrrh16acNktvGnMjcfopYdv8UdICeqQidLecIxLGP2oY5268V/orBKexdzFNzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349338; c=relaxed/simple;
	bh=PogvYHawQBfcq1w0PK2woXDNT47UrFI/QCVV0ugEp20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=exWkszTE8loXV6TU/IiM6CVa07Xn21pDooHrwHw6ngnW2qyyj2NiARMcljH8JNjKpd/HLdEFDTB9dOZ8qMmg3R/OD4BHX7qDA/P2kGDQK07WnYmgp06Vy1VIzCwWrwCMipb7/NG/rhaWnnBRCWGasmuea4n2AJiD2zFQ744ujfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mov0lQ7U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iGJz1Knr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448tqA6014090;
	Sun, 4 May 2025 09:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/N66Z+mygfpOG1xPjs3YVUzZuLgtqPhoe7wmNBo3mQA=; b=
	mov0lQ7UdKs6IumqM6RJZZBWuPA3+ueQt3uxq+XSvsSt2KvcO1/krgwaFZotahEt
	2w4WuULG60ixBxTxXTkcZMe4f2M176tSv8fD1nukF3XKPn05CDDdyddE0QbmDvsp
	vCyK+NSCYngLR2nu6zAsiN9Vsz5/oQEjAax2oDfAPkiCCLrZXYA6SU7DMx9zcOtl
	d1jFO08phr2mPqyx3NKxSMxUSaaUCbkmKBbUNrYB1TzLVGcUSt06EIpXzz8G/Q7i
	YTcjK2inO48YqsvD9s7n74GMHwllTwopjPvZ+6KloaZg64saAFKUgrPff1EB5HKu
	P11t5sD2UaH0YR6HNgWioQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e53p804h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54483HhT035508;
	Sun, 4 May 2025 09:00:04 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kd072h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G7JgV57vj/F/WSQfyof2/V+uY+G4LVVEKr4LV1IotfWJMG3jYYGHIyWmdaYrudi6UdO+klWTDsngfPoKR5xkdD1UVSdtAcoxzjfrdTvzFbQh2bwWdo6u4TwLyzMvQwRXj6OIp6TckvrBeSU1KQ2uY2KmFnebVT8KqUvUbB2uZcR5QHNm2ArfMGiTwjDAda0yOoyeIUkX/mGkRxXCF4klmGlOJWx3PJAxiosdOhxGfhF9l2WqjHXr9y57qNaAtal3RtgGUDewrSWGHqdhxtFPGZTI95mFkCm1wYU537dAM6VxM1US+UUPOeLE4hbz+sKu9i9ip4xCWZn8EL8Rs1Qx5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/N66Z+mygfpOG1xPjs3YVUzZuLgtqPhoe7wmNBo3mQA=;
 b=V3DVpP3avdTdgAt/boPAjmhW93Imn2djGOyLnKKH18bkSGBpQx6fKLU6Qt5h7cGLRiNSP1zbwwePJx4UuNfUsW0Hap7jQuCDjY40OYPtY7K99GaOPb6if2jp6v+x6w6WJGpy0hD7rUIjMA+pib/QAX7SEoXb10VhoqbXVssiSVihG/wc8xMZ8DJPQEdQqbv2YPqz/o3RjXRhlDfxnmpfPhxnvDaK7se0Fv1hOtmOOUL8+skX+7ZS+CyrsM32Mrz1tuED45eV8t3EtQAvWt9kkGoHlW/ej+Nunh3LTjRrTKs+4Misi/mRa6t5fYP6NcMEIzi2bF3smxfWhPnwcfm/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/N66Z+mygfpOG1xPjs3YVUzZuLgtqPhoe7wmNBo3mQA=;
 b=iGJz1KnrtshKXLDTq5jHggZtiG21hKtSwRCZJb0+MJ33c3UfvGdz3i91KMYR4KVNotURPmQWKhVJVRvcnjYnZGmV+8//r2lM9UqI+OvfpvzWKs//PFcXjlPNP4oRZxP0yBWJPscI8er+m08toNgqyMdpgJDhoa9mCkCMeQsexR0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 05/16] xfs: rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomic_write()
Date: Sun,  4 May 2025 08:59:12 +0000
Message-Id: <20250504085923.1895402-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0271.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ffe7a08-4532-469e-2d77-08dd8aea0de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WH9UiWkhFDx79pG0CPRPpzFB4rdAhXWbcVxYqLSyI7YuvJNq3DTLGYJ6VIVq?=
 =?us-ascii?Q?eD3Oz33aGuHX+P53PohEkFlF0o2P/zsKQjND+I1/siAd5Z4H+YloS/MSEpwb?=
 =?us-ascii?Q?Gr6C9Ea4M7mK6LQcvq7s6Cs31oxAs60xrb9LSLhskfZWYnNFCxBLNGXeOXyI?=
 =?us-ascii?Q?TcpaUL4ixCz9XF4zpguNv79ZRNHZvNvEyOIgxxKGmTzlG8vrcDR0gKgNj0Bl?=
 =?us-ascii?Q?QpsDQMwK0dRKgQwf3TTO+ZD3d2jdVbaLGRlM7VwGT1xnzPwBzRd/tOXiJz7r?=
 =?us-ascii?Q?+rg4xU8XLYmslQCbJ9L5/HOEgMQel0nqrOjR7x8JbR2WkBO806lAUIAUVbpy?=
 =?us-ascii?Q?n9wR3weJFxjg+D+s9rMB6pvP7cob6+iPOy5O+PwxXhwkS3tahfyEq3Yp+pvJ?=
 =?us-ascii?Q?Y5AMifv1Y84rzonVA7OHr08tn3sVzEG3x3Rz5oSGj1JajVYn76zF207YNbae?=
 =?us-ascii?Q?UJoKNBp/1OGMM7eLeNKiP58D8fDZkFFky2UB9LFd2da6DOM5sZdLFEAfE9/G?=
 =?us-ascii?Q?8KrkVQNQf2v38iKfgVikUl/Ujvl8x5pkMi+U0m0BXu0vI1/w218juabcTLX7?=
 =?us-ascii?Q?DNuTlVMa1X54w+mSfDil7EDmuiQ8+gmubPLjREZKwVDRZb2ppJoWV7GoP+HF?=
 =?us-ascii?Q?W52OWKtFO3dJvH2L1ImrVOImB1e6BWmMwXOL6HW/vm6pKB9sA5BZSCvFvzLc?=
 =?us-ascii?Q?SUuRrSgtiFcpQTSCMikGtTbFbVp3gZyze9GZVBHEaafqlCA/Hm+h4nx0U3CU?=
 =?us-ascii?Q?ISyIyohex5U2C6U/cWRNFj8PmFVOQ3RkUFLN3+WI+TJMYibFgny6xGmILgkz?=
 =?us-ascii?Q?J7eagbb2Fl4qH7cRWjZeGJ6BbS4qeGSV37gWKYzQWSi6f/xLg1TSHTxCn43Y?=
 =?us-ascii?Q?BnOiToMvIzkRcZtmbiGUlflIbXFV0Ir3n4lVEGDNLg3voO8SUpOHeN5s+zlo?=
 =?us-ascii?Q?EiBW6Tog5QRDVfj4aJtH0WDBhVvFg7eW0GKQUkZ7v84OtvijijENkk4ROGXu?=
 =?us-ascii?Q?tQGxWOsOUuXQdz/HoqrDagn34J3uc/vHb3hgl/ly1b1CoGpCqUwXjQNy0ccB?=
 =?us-ascii?Q?Ur8l+U/OH3I+6uDbDdvmjiCsqM0D89PBci+hi4senfGL6bjKLkPQShXT8Ihc?=
 =?us-ascii?Q?00GlQ4GWtzb507SCNjjRE7m2lbnWsdEcyKL/ZUJjbxufiQxLDCTJXs21Gry8?=
 =?us-ascii?Q?XP7UJ2Q7Yc+Jr0wrsq+wUfFRlduMfnxhZ5r6lXF2cWX2AHSgK8iiD107USXj?=
 =?us-ascii?Q?uAEOgWTt2bgwLrsRkjsMn/hqoZhzSGFgmG0htDMbZyNhNa6Rovy3nqZEE2a6?=
 =?us-ascii?Q?0zT+xDDyGoWJabux0UTuoTkhp0ROFQNacMWYN3FlEiLQiard1iKBjLfjf7pC?=
 =?us-ascii?Q?Lqbz69QutCmkALhZabypM3PAhOxZRqt4aFZv3R4gV3ymfIdfgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C7KbkW+iVrVOJo2b/nHe2bQAEGPubumJukaYCNWmwzdFkDdJjTbS3KTws8SV?=
 =?us-ascii?Q?D+Z6N4FhDZAVp2TPSu3p8estr9pYptA7REzuChuIsUr537Q7xb85tRnzqWBX?=
 =?us-ascii?Q?vN/cn1xqjogTYBxQTU8t34onF3CRxu0Rhss+Qy0nsFACGKt+S4VuPYRZNbWX?=
 =?us-ascii?Q?R34/q6BZoCzaIbgMm4Rg3vQQBGdgUJRCkEauatG+KKGprzj7nJBuBwk6h3et?=
 =?us-ascii?Q?fq75cvxyV4mmeHYJVqs9O7dXexbtOSyY7VlAOXPoqDL0nahpLQljTp70SbDR?=
 =?us-ascii?Q?eGzowxpDHopcndQBAU1/IWvoZiD3pZB1Ugc4jHeJU6MZ4g/aCavcCyU2tL1z?=
 =?us-ascii?Q?hN3leMXg2dBQ2LJriZcCW2VqffWnc9B5MPnTMp4MdSJbtq7JVzd+VpDPr/F6?=
 =?us-ascii?Q?UE1cXLOmJ3yAzoqF2RSpwvStzGm3i3NsOE2nrmfuHv+ajfj5xF1gBJabQHKo?=
 =?us-ascii?Q?EwinSHp3YKWGNtaVQjxfHmP0JdhmZSUSerpGHMFroXcqqU4V1JOyTdHS2K68?=
 =?us-ascii?Q?z/zBFfh4ik9t6NXl2DgtVlqIBTZLgEEK4GT5Jwo64Cz3PX3qWHvVs2V043pb?=
 =?us-ascii?Q?hMgT5WpSNPQC9sBqaj4JuyzbD8gUzihjOPqVO/XW2E608ydsV29u89BsSo7M?=
 =?us-ascii?Q?ttH8OmYl9nmW03VkR5bnf1IMc8vOd/PR4gw4RSGlZUTy7v7qzUZgJT9HJOg6?=
 =?us-ascii?Q?PIBur9SjAgUgIr+ZP2K6lN5fHbmCLf5rzOzAEbRTnM4EuLXC0ywCmF8nTEKD?=
 =?us-ascii?Q?qIPLGy4Iwkg9agQqKpjsXeyJcCRMOwKmjl/bf3kJ6CAFaZtqV7mw9KrcWgfs?=
 =?us-ascii?Q?8sgP8TH5JYeCqRV+2pAhTAGm/TK39NVspBB5K3Rog1Zv2tBldRHrKYqphjfT?=
 =?us-ascii?Q?W0VpifwJQfX7a/nk1P4tDzJzBivzoOizhbMGrodlZFn1liGvVGR1pRgvlLml?=
 =?us-ascii?Q?BxNfcvhoLVjYLuZ0dhOFtbWBHIQfHffFyYoHr6+ca9Lsa7L4QmBdi8Q3fRq0?=
 =?us-ascii?Q?1uvIdS8BTexRnu1Gx8COyETb4vSEBI38xbPk8accbFkaG8QWikf4aQy3PkVx?=
 =?us-ascii?Q?hnTuJI+6WNfjYR/vVHEjFpg5s5IQdZ5fp8WZbqG/6ESuzGA5/HsgjlTTff0M?=
 =?us-ascii?Q?fIoyAx8AVVACc/4yTv4FM8eHy2XRUKCWRAtATPO7wDFuutqYslJPSKoXpm2h?=
 =?us-ascii?Q?gmfMWWnehZWUhthf3gorrAnuFGpRwUWzXmZyrMHcYUnJDBTFjrEMEiGfXKaj?=
 =?us-ascii?Q?V+0FmsYkZCBGfEM5kqjqDnZgJXud4fzi9YzDVS2gY5QhRxG0fUeP9Uat2eKu?=
 =?us-ascii?Q?85H9y6GIzWRQkbGg9J09NdOdmbAZEZG17jm5rT62ToJY9zudDgJikSLeoH80?=
 =?us-ascii?Q?tFntAXvq3R5Q78yiEO/oitE8RYH3ctwFE/pcfWK3nA8X+K7NKZvC9z+8PABw?=
 =?us-ascii?Q?3dqc/Lfxz8n0lth3s8dzQUiVX4JBsOz6fVSCnPNBRTgWdr5qWAoT/wOJGGwJ?=
 =?us-ascii?Q?CTJo3LrS+6hjtACPiogXG9Ui2fMLYPOFX2XWX+8bZnRyXXR/65XEpPUmpBCm?=
 =?us-ascii?Q?rvgGmN60QAXNIeyFRGzrKMsuuQ1AFOf05QqZrjgVpFOZWRBJFP0aVCnOWLPH?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xSFV8c6qfnuuW4FSyiIRF3aUuGo/NKkSBLi3RNi3uyXaJCnwUwtR1yspAh/1eYEvQ9/IseZGdT0y5+qu4Padkj+qRND7dvHeSze4iPLTeqhI+jZy/9M7NF0kP3M5vr5hCNsiVhiZTylDowCUKoJYSVs55UmUjU+CFRNNcNpJYmzHK+FJR4KqTCPX7zS48N2qSAHUSvaq+AOl+xs67FaB66mzhraDh+/QD3/G3qvguVd1nj3/h7uqoxIOjQv0/10LdJNKFQw/WSzcafjB6Bw4QpI7e+yOeZyxToxaJvZShmDkKxkcNZJH/VeCLZGro6S+HyzbkgbrW93vz+Jx1FLXQq4W9ON9w0UJgvIkJgxlV1pmYtlwhG3uIL2tvgEuhWegELARLXw+FFkE/3xB4/nJaVbprS5x/6wlEY6aKs5RHyAd59Td1B46GVC5kmpYYiTH/yFmHsKeUGYY7AQ8W8zLHGuGOOnlPBcGHgKY+Im+kFgA/U3Rj5O0yis5aAv474PX/Lm/RuKOwqQ4w/UqXclXPNI/+AchDlRRSMsvIkJENedJNXktyc2vk54kBXn6r56iKcu167Ncu200mDQzpVfrfTE+F/jEFUDXBGHBpgdQDSg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ffe7a08-4532-469e-2d77-08dd8aea0de4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:01.7946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNH72Rq9dseyXyEbcDMqvOxBCQtjWykdheJHL6ev2N14Xw5GPEC/Xsul6RlatYSVP7zYY2uTmvoT5CBlicwtdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: MSOsQXcfT0yUgqIioc1PkbQzs2JK7xRJ
X-Proofpoint-ORIG-GUID: MSOsQXcfT0yUgqIioc1PkbQzs2JK7xRJ
X-Authority-Analysis: v=2.4 cv=eMcTjGp1 c=1 sm=1 tr=0 ts=68172c94 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=zTysb3kGxGKvEiGebP0A:9 cc=ntf awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX2Fj+8uidabbz VNoPzKjT+dURuS4FXyCd5/Lf5Re0FgO3sw61xcKddQUZPV5P0Nl/WO+6i7CfIghmtMLE/E5owWm 519rnMLa7wZNQitJTXzhzonUEFsASQcoiuQZx5RWRFYbbuHutPk//AAtxP4WDXoQfBnKAnl+6fK
 +HR4KIb2z5/fmDs0yWwgjNPRPibJxjyxGoNXcV5EO66LhgSdaoZCUvrmn3ARIN5j1s7CCiKbmk4 0fDho9XHwam9RJNFl/emtQ8xE/Re9k49oXGXUBbU4moOVipaNClypdqWhRoj+DvzL+DDykrk15O AwyqedwgEIDAupsO8tE1/mPVB7Xr97EoNmL5cIURigd4jAuLsuQwuwNyY8ipS7i11bsJRD+UiAL
 r63xKO3AbZ6vsh054NwLlLU5cX2LuzYKrelsUu+5b3nXR2XYcBnqsPzjx+eTdW/RCOae6Ghs

In future we will want to be able to check if specifically HW offload-based
atomic writes are possible, so rename xfs_inode_can_atomicwrite() ->
xfs_inode_can_hw_atomicwrite().

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
[djwong: add an underscore to be consistent with everything else]
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c  | 2 +-
 fs/xfs/xfs_inode.h | 2 +-
 fs/xfs/xfs_iops.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 84f08c976ac4..55bdae44e42a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1488,7 +1488,7 @@ xfs_file_open(
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_CAN_ODIRECT;
-	if (xfs_inode_can_atomicwrite(XFS_I(inode)))
+	if (xfs_inode_can_hw_atomic_write(XFS_I(inode)))
 		file->f_mode |= FMODE_CAN_ATOMIC_WRITE;
 	return generic_file_open(inode, file);
 }
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index eae0159983ca..bdbbff0d8d99 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -357,7 +357,7 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
 static inline bool
-xfs_inode_can_atomicwrite(
+xfs_inode_can_hw_atomic_write(
 	struct xfs_inode	*ip)
 {
 	struct xfs_mount	*mp = ip->i_mount;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index f0e5d83195df..22432c300fd7 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -608,7 +608,7 @@ xfs_report_atomic_write(
 {
 	unsigned int		unit_min = 0, unit_max = 0;
 
-	if (xfs_inode_can_atomicwrite(ip))
+	if (xfs_inode_can_hw_atomic_write(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
 	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
-- 
2.31.1


