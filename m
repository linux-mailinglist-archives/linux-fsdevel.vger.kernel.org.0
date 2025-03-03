Return-Path: <linux-fsdevel+bounces-42985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC48A4C9CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FAF3B9BAB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25022F17B;
	Mon,  3 Mar 2025 17:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hKC7ntAs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CxlrrNxK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE825CC8F;
	Mon,  3 Mar 2025 17:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021947; cv=fail; b=aXKFxMZTOt2AFH/S0ROthzRps15tjsmnfsL2urIkMy4oJ9veFUZa86nUP4bqED6XlLPoHkB8I9+/KQuSiy9FsoEo6ryQUjanePWBhvLsyuJlf8bDIZwEwomhbrX/HlYbf54DWKN/lQ67pC2sSybFlwYo4WfXogz54T786WWSDqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021947; c=relaxed/simple;
	bh=Ew5mmVK8Q58H3hyOE3GF/xUDrrAIp6SiKFKY0WOHiKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxttwbjWqKKGd4ZenSpIRf6TpLSXIWEvs6RHH1vgcBBjtsdrJzgxORT7+jX3ndz8nXscH3Rpi8N97nh31hQVBq/FvYWeWAUqfxGlwYB0h2ElhbMER1sedWiK9wVLOZo1IO/1qt8aEzg1Qlm77maK9bO79h7P0M00FN+twfeuRdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hKC7ntAs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CxlrrNxK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523G2WPk030312;
	Mon, 3 Mar 2025 17:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=NyicfsSOcVUe3XC4hGKHkWG7h23c6u9MWAkfr3bmx6E=; b=
	hKC7ntAs7b9Oe8zRiIuibLxniNVL6mdJmo+oSP+zPiNzjeiacCE+lt9uuKOzTgOD
	gNe++lPRUEejqumYOidA/SYccnYcqz4ihUEcVRDRaap4hHoip128RIXePQJcnxBT
	CtysWKbdUoAZCtbot8JeFavv3647fLuxIztYYJNT3pWOvo0+yfs3+mAJq/XgSQLq
	/y4bLHKd9EqiNDUJCULupNx+ouS/V4Pdx3xhFyQ9OIgMjYDCCjvz67dYMT0fPCJu
	fQl2AZHS/b0EALQVy8ssBPiaVNK0hzJ2Fj3BOHUGmV6Ws8Mn0CANk270H36B8VcR
	hLjctYFogXW5NW8X9mMUzg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86k61x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523GmEkY039110;
	Mon, 3 Mar 2025 17:12:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8g9xv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:12:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpIrLhV1y6fezkTOiu6nUD4lIy2wyy4ODRWeRRMlHkCu2HAi7SeoIHxEamBus79eE4iCD06r5WkxiefsBWOSojYOO73BC+yD5/HBJkLNIRivulMO8C0sFuiDetVl1pXJdL5RiVdHnkB9n3pGMixiJasqzu91md2v/5fAzRMKDFOykyIa+JCRg9Axm0pDTml9FXIASe0jNuXy58z/kBJZYMAXUyF65ST/7vm0bNGTASiTcesqcsVsfXLzvmT5/76aFP9i2LM10zbovp4h/Df6qTvAdFg5WmtAkDnt0sbd2JPvaX9v8WrNPdegoT2IrTQHDwvvafwcDupVG+5spmewyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyicfsSOcVUe3XC4hGKHkWG7h23c6u9MWAkfr3bmx6E=;
 b=dPvdRczlLkiOgWyzCAXDGkJXccmrJu7gEcfxy7xrkC0KQ7yS+pxL3f9a7CN7782w4Mmocs0Hj/AhKBMCD/9Qpm9X0pwdjEUiGhZBT/y6/IoklBaWMHIrTZIKym2GMLGcsJQYigdZYfd2rJYXdOu5SQ7kfuDOCU1+j6PBvup+A6zBeagqxOuefqnjsyFpTGhaqNQReMtV5d2Q+erJSlcwTaaXCEga+1glIZndaaFSeZPPdWhVkM5TN2FkvOKGeBS3YsAXxeGWN3ro5Nd0FFeYdlrT84ukVH7I9bKz/O50CGsA3eBmlqbFN2Ychn/nbefrE99R8fqD07WJJbLa2XY4uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NyicfsSOcVUe3XC4hGKHkWG7h23c6u9MWAkfr3bmx6E=;
 b=CxlrrNxKCpGlzq/X5zLV3aBN/+bcy5hgiDLtSGgOv/ZQq0T5ZE8++wc+RrmLl8u9s1EOEkoODksiOhUg+5QyH5XnDqCltRe6WHyQpxErcSZlzYZXxqV9+v6b+Bo/nB/KGNNvsQsAoI0KtbsVQN4tAyk5wjGuLB7FSKR3pHtSL/M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4696.namprd10.prod.outlook.com (2603:10b6:510:3d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 3 Mar
 2025 17:12:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:12:15 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 12/12] xfs: Allow block allocator to take an alignment hint
Date: Mon,  3 Mar 2025 17:11:20 +0000
Message-Id: <20250303171120.2837067-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250303171120.2837067-1-john.g.garry@oracle.com>
References: <20250303171120.2837067-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0007.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4696:EE_
X-MS-Office365-Filtering-Correlation-Id: 349b54dc-a83a-43d3-e3f5-08dd5a768b71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUPkx25fZEvWYMb5oHv2g9hteBaKrzzIgWhNhQdbskK1MNV42+iUbHlgOob7?=
 =?us-ascii?Q?Lm0DpooeJPobN2uPGKW5nRysdPa6+Xjt6Ao8/bMMlCYAwyMNeauXYX/9h4Se?=
 =?us-ascii?Q?ZU1Jappa7F3q2YN66D/G+nBYpt3r2QmU0kng8Qi09niwNk/xY0YUK5oDMluK?=
 =?us-ascii?Q?Vtw5PIkLG/vAssLG3x2jj84fDbkY+yDtrcTMbNNx6RzD4cYMcwhYU596+30l?=
 =?us-ascii?Q?Qf50VbDQch5uD6xeDpGiFH654VcE8DXuNnuRLSXZizqePri3If1WwIUGkuGw?=
 =?us-ascii?Q?GMxukCV6Wk81EdYKneTprbEJ/07AHyZaTer13BfcFNxTeSbuqpUVpYFZY9Kk?=
 =?us-ascii?Q?WixE9eDs83P0gR9sUnhIo84NNOf5V/fA+0xlhCpr6pGqxlScnk8LE45ZGIw5?=
 =?us-ascii?Q?MAv2pZMbTECov6qoXG7qqjrVYGbH59IykX387FlDG4+xogCNGE7OpqsQTX4d?=
 =?us-ascii?Q?dPyADjj8HFXVB3ILJYjuxmcyTLZwfcibNprXNoVfpEcSBUSh+5au2cA/ItnZ?=
 =?us-ascii?Q?K/rXy5cPRJlO+WlUcNWpGS4S1LclfBWjjcYVqnh4KTw7kjjWtKtp3ld8nrDa?=
 =?us-ascii?Q?1H3HT0dsvEhC6H/B+egOeJBlKAnFMMeKjkb1Udj+UxJ0OTGPIASLyPXDjnT6?=
 =?us-ascii?Q?pnQXrSEtvQ5opsTwQoP2nUzwPglanqvxAyNcWiyGj8Ep+aclamJlMVy/O4hQ?=
 =?us-ascii?Q?if9TRi9rcOA7p0n/tV2oENMn7EcPYNo5EvYgOhtivnNA8M0qsFVbGGnpQOEC?=
 =?us-ascii?Q?B733uefDQ+xkpHp4dWHx+ZRDVFOEFwwyGKONoL1I94xCukpoTzJhTgaWrngW?=
 =?us-ascii?Q?i4OUAlweQ/K6LEbuuIXNBQbAkzfsV5n05jno9zf+zChAq6e/5gwBTZk8D1iL?=
 =?us-ascii?Q?28yI0oFftkRxtr4txwTQ54ly+5HrtgCWuxAzTJl5U25wox6oOH0uOFD76QTN?=
 =?us-ascii?Q?E9WNSeXGP+Y4Tz9Hw3FAbMbbkOT5IHcYEpV0VJAjl4fHGyVb/b0hlc5FmThK?=
 =?us-ascii?Q?4BVY9BTSFaLI/KPZHL5nwmGGw06Fav5n19PrWeKE1EtctcOHv0p+Creybud2?=
 =?us-ascii?Q?ACKi4sn5d30+HaCIK6jYclACIFl9OhnIVG+hPs/NJ+Ds33+SuG8kW6PL6kW6?=
 =?us-ascii?Q?n61qWtAEOXlB+YFL6/egr/d3gz6ebiVrUJL0e42sr3Jk2qH/Iq9Qg9dSQIOu?=
 =?us-ascii?Q?AmTwrwy/4Q+xa7kRUCemVEjRZCeWVieC4IYdUDQ0cBoYB4YE7NfwQ1ZWOOXq?=
 =?us-ascii?Q?rcU6IJoJlJFP4z90xNNSV7NrebHCvo+ikj73LfAV9kAvq3w5H8zUetcxmMkH?=
 =?us-ascii?Q?4nfxENl2gPSfbhYy4jnFSqzfBvXXxfceZDigML/L5qY4lLTOCei8v5Zak5is?=
 =?us-ascii?Q?qLZALrKU6s98T+I53M5P8OvhJvBg?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ALcMha15tVYbGZBCNQLzQTmAv+SFlhvDvxoUWEaQoK6fS77meYEH8c3E/r2E?=
 =?us-ascii?Q?Bb/DRXgiBCbxJXKnBjEJFFwsdy38+WiKXl0yORwOGjtTE4eEjtcFvKWXLX21?=
 =?us-ascii?Q?1OEJ9OYE8csfnFWQZmCCoOU6B8qaZN4KEkRm31sQtqVkRb0FBGd2fTPLOSnl?=
 =?us-ascii?Q?RBQJ1Zka77pO7dOkqxspHD4rOcdyao8pg1pHRVZp19nTKkZVx/FmdlU1WDNR?=
 =?us-ascii?Q?IgbRrtIfgndweps/B44FT5eBMtBwlljW4RX+1zzV+vkixvyMU2K9LH7KeJCf?=
 =?us-ascii?Q?5Ji1hmCmFealbw1qWZEwNytXsofuRIIzx3FJuMAkHSAk+I3zr040Xmprd2K8?=
 =?us-ascii?Q?dQJOuj9VZG0vbuha7S9U7dEnuoTr3GxYonof/7EI2ifOt10+lh/5kt0se4rB?=
 =?us-ascii?Q?rF/zW/3oHj7TiU0NkJSN2S2aVtZdY36T89Rbh8wa1VqegObVyD46l9doI+M1?=
 =?us-ascii?Q?xINuAcvm6cC18bJPeQSCckz91HAuTxTpbwI0+QeWzX0t/Q/ttb1sYTqh5WY5?=
 =?us-ascii?Q?XFtRppDMmOqAhMlhuC0zSbA5E5TUzfYGx3CO8KomdbEFmQLrvrl0NHjURPb6?=
 =?us-ascii?Q?QJhn7jWxUmFtqYtBDJLg+Xto0XS+MxvLvJwBE3xAirvV6iK9OwPN4C8NjxWb?=
 =?us-ascii?Q?AN/Pqha6t6z55WvxxX/HZJZcGAqooiK3QRj5Yfh8h2ccrKRgA2MiEtZ+ooKM?=
 =?us-ascii?Q?uZKkI8wu/VomHgeJ86codIWLF7Ih4FySiqHJt45DxMYtYydhbHHy4bNLwisV?=
 =?us-ascii?Q?YzLztQupvaVS7r45SCmXT0JH/sFaNZB6sIm9JicMnYK1akpZjCvgkkH7C8Jj?=
 =?us-ascii?Q?u3amN7EvMwO8vM1ATHdDYjU0pWKnz1IuPpMIbhl1Rt+DiRQl13E7LjDsnBhY?=
 =?us-ascii?Q?UKH/ItmCYN69vduuNf+rHFOPQP0lssBcmXlYUXjmiO4HIlKMfS+OLCY+ysDN?=
 =?us-ascii?Q?vGJ5mHvTPfQHCQrDLObk1o2RE1i13BRvn8TRf3xC0fOF1AtaCtUsDbP39QUZ?=
 =?us-ascii?Q?OhQ4E56blr4BKX7pDuZt+8RhFFzbJRtf+kHMiaHKkVlJTW7ouJGWyQ4FAXF9?=
 =?us-ascii?Q?IUVtcHgAmk7iCJqkphU/Gaoh07En5VyZuQbLAIfYXAxx2goF2q8xzVoSL1/w?=
 =?us-ascii?Q?VdozqigbnNES8qjvvD3uUE4U3GMWT2Z9pzFVslDUUHs5COAq4PuuutYMKNTi?=
 =?us-ascii?Q?4y7LNuM4jc/yhpfZKGEOuQcwzfkW5n3kAeA1U+rn7jbvZ23/7ez6PlOjyCKh?=
 =?us-ascii?Q?jpAc7KH5Riv4I6kADarGvgePpLgHS+qWNl9gLqAG4xVJGX4u9qu078Xnzed7?=
 =?us-ascii?Q?5Z70W7/GGbdcSWEuvIjdRCd/eSjMMC6+joU1+cMfyTjI77umY8u1io+ZXIq8?=
 =?us-ascii?Q?kwT1qqqQLzvQ6L7XzHhteOwcpecKhl+65fVYYjUqYIMHwWPSNUG2BTzZ8FC2?=
 =?us-ascii?Q?9Tb6cuD6iM6+OzU9K0TQe61eRqof4TlSwvWgJltA5yooKnCWuVnId6oRJ8g4?=
 =?us-ascii?Q?wI9UD1QPg9kfgvlvJSCtsoUEjY7Xe01sjrjqqawCjQLr4jL4HgPnbwqceVPT?=
 =?us-ascii?Q?U2THfhR11n30qfSZ9Vy1ksWdA1sQdiWzeeYtEyDk57LHEA7v6hGFdC0/k1EU?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CVSKpfCwEy1i53Lw33QV5o4pNg9PghY5hnZa+dxKAIa/NezYLZjkd+MKD2FnwqoT1iHsO/qsTZ86aIUTiib5c+rQNoZ9OeRL5JXB5g4LRo4VSCn43RQFv9iteiemcRa+477EqQFuy8yjRXuOjjgCUsVmQ8C0EEdQ7kqKD2qLn48l96UhnQ32FUDLXTDPB/AyZW5RohpSzXEin6SQhAMB7AUxLx7tyT9Vrr88lHiPO9C/FECd42lDJKl8x9VldRLr3QbNN27P7SAKCJjuzNLkpF3GoHRd3T9m6MpbEqgGsWKMR7yQ/EDRtzttmbPz3mMW6LFzFHJ4kRHtKMUjt9fdHDhydjdnPgIMu7FItzkOLe/K1h0FPuzDi4mzh/AyT8N8TPLFTNnLxWLpuwSE2Nn/IFdNHz1clPdIiYsAu0pzDFciW2nh1BmSt7X7rqXXSSHgWolIh7Fdw2NCbwzi8uHDtJzgFYFoDrpxhheRLWlwvJ7ACZhToZnxCB2ftUSIU9yQDSJS1a1A8+xlh/fiDVQMEGZxRCsErRyhCluaLEyFgYqg4L2hxQXKqCotoix2SnhrN8rct57ZUR+ZSOX0JrMcPTrf2NARFQsh2SrY0Gm0NmY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 349b54dc-a83a-43d3-e3f5-08dd5a768b71
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:12:15.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xHOSGEBn6f7Pl5NwHCKiwibLejHM5bv81Z3bKn7VjIjdcKNZxObpZ1gcYDlTwCgN1j+JKXLXL13FaQOyjFpxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-ORIG-GUID: uY8M5dGTeK4OXk8qhK5uJ-X6gasGUid1
X-Proofpoint-GUID: uY8M5dGTeK4OXk8qhK5uJ-X6gasGUid1

When issuing an atomic write by the CoW method, give the block allocator a
hint to align to the extszhint.

This means that we have a better chance to issuing the atomic write via
HW offload next time.

It does mean that the inode extszhint should be set appropriately for the
expected atomic write size.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 7 ++++++-
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 fs/xfs/xfs_reflink.c     | 8 ++++++--
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 0ef19f1469ec..9bfdfb7cdcae 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3454,6 +3454,12 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	if (align > 1 && ap->flags & XFS_BMAPI_EXTSZALIGN)
+		args->alignment = align;
+	else
+		args->alignment = 1;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
@@ -3782,7 +3788,6 @@ xfs_bmap_btalloc(
 		.wasdel		= ap->wasdel,
 		.resv		= XFS_AG_RESV_NONE,
 		.datatype	= ap->datatype,
-		.alignment	= 1,
 		.minalignslop	= 0,
 	};
 	xfs_fileoff_t		orig_offset;
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index 4b721d935994..e6baa81e20d8 100644
--- a/fs/xfs/libxfs/xfs_bmap.h
+++ b/fs/xfs/libxfs/xfs_bmap.h
@@ -87,6 +87,9 @@ struct xfs_bmalloca {
 /* Do not update the rmap btree.  Used for reconstructing bmbt from rmapbt. */
 #define XFS_BMAPI_NORMAP	(1u << 10)
 
+/* Try to align allocations to the extent size hint */
+#define XFS_BMAPI_EXTSZALIGN	(1u << 11)
+
 #define XFS_BMAPI_FLAGS \
 	{ XFS_BMAPI_ENTIRE,	"ENTIRE" }, \
 	{ XFS_BMAPI_METADATA,	"METADATA" }, \
@@ -98,7 +101,8 @@ struct xfs_bmalloca {
 	{ XFS_BMAPI_REMAP,	"REMAP" }, \
 	{ XFS_BMAPI_COWFORK,	"COWFORK" }, \
 	{ XFS_BMAPI_NODISCARD,	"NODISCARD" }, \
-	{ XFS_BMAPI_NORMAP,	"NORMAP" }
+	{ XFS_BMAPI_NORMAP,	"NORMAP" },\
+	{ XFS_BMAPI_EXTSZALIGN,	"EXTSZALIGN" }
 
 
 static inline int xfs_bmapi_aflag(int w)
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 844e2b43357b..72fb60df9a53 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -445,6 +445,11 @@ xfs_reflink_fill_cow_hole(
 	int			error;
 	bool			found;
 	bool			atomic_sw = flags & XFS_REFLINK_ATOMIC_SW;
+	uint32_t		bmapi_flags = XFS_BMAPI_COWFORK |
+					      XFS_BMAPI_PREALLOC;
+
+	if (atomic_sw)
+		bmapi_flags |= XFS_BMAPI_EXTSZALIGN;
 
 	resaligned = xfs_aligned_fsb_count(imap->br_startoff,
 		imap->br_blockcount, xfs_get_cowextsz_hint(ip));
@@ -478,8 +483,7 @@ xfs_reflink_fill_cow_hole(
 	/* Allocate the entire reservation as unwritten blocks. */
 	nimaps = 1;
 	error = xfs_bmapi_write(tp, ip, imap->br_startoff, imap->br_blockcount,
-			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC, 0, cmap,
-			&nimaps);
+			bmapi_flags, 0, cmap, &nimaps);
 	if (error)
 		goto out_trans_cancel;
 
-- 
2.31.1


