Return-Path: <linux-fsdevel+bounces-48002-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5B0AA8537
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3299A7A61C4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B37891B0F11;
	Sun,  4 May 2025 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Fkdt7nx8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bghKNqyG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF6018C91F;
	Sun,  4 May 2025 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349339; cv=fail; b=bw9tAXXN68hie0Xtc/W7NwzQKwMlo8f+qRQxHsaqT9IOVdF83q1IuSD/Tjz0SnYl6jgynem5v1wuiTiP4GOrF1FO/0VdXD4vaPNAkrbmxUeavW/fUrjjQeKkCUZXKA/2RHZM8UBPgmQgrrOT+qveovlBXFGlSHOk0F7gm/oo3ZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349339; c=relaxed/simple;
	bh=ojbL9ETQY9oFRhSdUJ0ncgTmZcoEGxx/N41SjSyeLlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PYjKmpgmnAPMv9fQfatS4PXoWvh8pBKcvGovL4oVghlXUO0whjnXMQ8g3uTAQetr5iQmQZhkW9YhVV63FHPHDMfWISuZBC1sQ8TTgLFKwHwu31nvVb3/WEY6beAJeROgmwceryW9ThxwiMTYJjC/WA14Kk18RXXvLiu4fs1SFJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Fkdt7nx8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bghKNqyG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448mxsg007178;
	Sun, 4 May 2025 09:00:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=; b=
	Fkdt7nx83aRa7KS7DGYX+6jLNN3e+Ad/LzWkKM2EE7rn6WV1TO8OvNXMK/hwokHU
	WKPyuhv5PpETbDzzl1Zk5uDQbWa88umE2fQ4TKd3yE579s6y3Yul3nMzlXntNNy0
	C9lxGVM97GX386XXkB5Ahb5MYEviB7mK/qWFedu9AEm9eCeH6lDYju8/HuA3Lqrp
	UN59Zo8+FomJ6V+mb6yGYgZPuTnTc/b/PXXuCzX9F6SMtPIz/EV6Pdvq5PaC71S7
	4misZ570eVM28/H3vtJLFxd2hCudg3gh4Pa63k+V41g4aOaJLYXnxCdyY5JCCrA+
	uMHghQY6tffDRKGC5ZnbgA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e51bg081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5444fLMM036209;
	Sun, 4 May 2025 09:00:06 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012054.outbound.protection.outlook.com [40.93.20.54])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghfj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eXQDgejNUHhK/VnjNHBMdVWmwGk+4fU09n60TiKB1SnhzmQpq0xY70MTtoitXd4T9g/B8Z53pk+cejSnKzPFldqTQZvEPXbLAf4IpFUMQPkUHlBU56TZ/4aclUEg3r7YaU91EguQ4OTwO1w0rmUz5yyJVsR+vlvIt5xqciqm/26jvDbp5VVlGGv9DLBGbuLFSitnKfSFLbty/0/a8A2uP1A+3DXANtl9r09g/f76kBSoMbn3DCHzvZ/XY5fQxInlk1K2RpMXL4xTsItZT2rqLtB62oYyfZAsdAtY87eFolP6px56gu7BRxjw4H2DozJhxTbwOxQ6Lq9YGSmPq87TCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=;
 b=frB+WZLrhg6IW/PZYyv88g1i6FzfVsMLAGPS4tDU8omPUpTHCZzkRAlEG++XR5ohNYCCXpKi/y+fD7Ll9wCgChyNHRtjoRGo3o+I1Xa9V0ueyBJ9mrSL2lkClKyOHEx4CKfdwJhOaBgLdg5tHp8tzydrL9JXhCAj67msjgguYvrE5CUFVsbT245X6j/uC7sdUrINNP4nlSjFXK/4oVRfPdFb6a5C+ARrIYh6bI+0BD8HY4yzdd48xwpJPfcDjh6zsRoOUEzvquQHN/cLQ1USWlEuFdw4koIxBE0u4gR13M1YJnR7++GdU3cenempjNZwvCOcqiJ0REd11bWmQ8NAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZCudiUxfsEHIobBWzcPozzioirBNDfaP6h9ncSziu4=;
 b=bghKNqyGh0Nt13YyJSC6Ed/NOBBwYVUIgeRQ8pT33OVdCwj6jJ2C7fHLyi+nwIp9hucm8iQrbZoKs9DeFul7hfbJRZ9rUTap3ZkrHvgj76h1c0cSOgjSp0YDvX8oUaQNbD9A7fWebWLRhz6T1KHwPBSuIgoHOQGX0dQs6rjVIwM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 07/16] xfs: allow block allocator to take an alignment hint
Date: Sun,  4 May 2025 08:59:14 +0000
Message-Id: <20250504085923.1895402-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0460.namprd03.prod.outlook.com
 (2603:10b6:408:139::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: e50c6cce-2d5d-43b9-8915-08dd8aea0f9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0+YyLjgcnNVjppirn+VCriiOTK3h2Lgkvl+iBxCzaaXrh9GcsfeytS5TV61i?=
 =?us-ascii?Q?Kon/3IP+9SW3hZiTMbr1Rkl054X+M1DOK9EkEopcRjitVStc7j7MfYFzWt3Y?=
 =?us-ascii?Q?kMCbRTLORxkAwwc25bUvgg7VY/vxn8LJAnWDY8DsQdeBJtZBqMWFeYLipYBH?=
 =?us-ascii?Q?LHcdfGavcTnqgyCXeKVMgnt/zjKq2zAYjpgcPFIrryZaKI9MYnn7rWTc9S+T?=
 =?us-ascii?Q?DNXJNrYwOdWR/uYBHJPzr94THXqgWzDL0AUYlb5zDSNDO4eo/ZtChKIwISBY?=
 =?us-ascii?Q?Tn3IJNK7MvD0M/eK3vLP4EYHEOnlbWX4bvCsPzLxbND/B9a0sSmFo46Kuu64?=
 =?us-ascii?Q?yJNyPqPfpDUwHohEx8VtyXKdC5cmDsFzIF1t/j6haq0F0pxE7L9uiGSOgprC?=
 =?us-ascii?Q?j4euDR0xAawQIAMEwsIy3/h8CleQHe+94q+kf+AnC4VTF7ED0L7uS7qJNrG7?=
 =?us-ascii?Q?wi0nwaGXJfO91e1GS+j3MkllDECuvE2ATngqkWL704u7g+RLo0WRoof+E+d7?=
 =?us-ascii?Q?v5p3r4mOWJ/LY2Tvdd2Ntx1at3VquAQMVvjhtitkDDZ7AkCTWn5n/I6hE7jF?=
 =?us-ascii?Q?KP9yKV4e2Cd8OVGVAvyO+ZyWqaVX5Vb8QvTaIrJFrXoD2y+EaEr1VuNyzR9X?=
 =?us-ascii?Q?CFWabNFlh2aCUYJfD6fQKpN12Bi7S30L1a1HPgu21eYSQacqRSIFyrz1p4tu?=
 =?us-ascii?Q?gTqNuRWqTvIKFvfsIY8YlHXzvZfL861vstp6qRN3qt/Cu/OkpKR+0Y6yviV5?=
 =?us-ascii?Q?soNKP8OvRWTbnCWm9uwMdOFnJxAGSxCcV7GEot0yo+jdJF9kl9lR7Swmo9E1?=
 =?us-ascii?Q?IuYGMV+xHtj//QpMoCUqXXCWeGFe2RJeqtGyKL9Gs1R2q//t3NQJ6T0paEe+?=
 =?us-ascii?Q?fEdlrR7RGq+URFc1YMx0GnRiNFcop7dHhf3JHdJs/dTo+wCdzhotYldK28U2?=
 =?us-ascii?Q?pFpE8vgVB+PjQYFczZXWW25SGBk63UL2jpwANnJyJeyACvoO4aMuUDC/sOxA?=
 =?us-ascii?Q?GBq3ZVRMnuk1fbm8SsDtF/VdjDXu/FIU2tAwThnbc3SL3z318mcC/Yt/LPst?=
 =?us-ascii?Q?AGQfVHcLvZflbWfsJCnSRz6Ml9ZBEo5Vy0rxvPSZbQyPkxo28hkmhLKhMsDd?=
 =?us-ascii?Q?8riz4swrpoznNKC4OesXICKwQBanpOusiMLud7PnJgI340piAeJ3rZl3B4zJ?=
 =?us-ascii?Q?aFT0sj76PNOjicmZXK2nUG8j0iP0uZKWn57C6Obg9EYLEVfJBPHi1SrtL4HR?=
 =?us-ascii?Q?fz499SZUqNUr7HvErVdCnw/3wkPOOZuWsfi8+AqZVE/3MMzQBxAHBaxO5Bu4?=
 =?us-ascii?Q?h8NpB1skDfcg8F1oZ3uDNNOZ9glweoBdnUF+Nmwb3U1ht1zCUTWQ43Mzheyh?=
 =?us-ascii?Q?Z72+PqyWf50hl/0IaSFxk/Yd/JyWUxCupJuS/44hr69WwDnphI1DiyW6L03c?=
 =?us-ascii?Q?GhrALQeUCfY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?laemntYsIcgKSDuWFPPtKODl+2SAChPUcMLv//hw8YLx4bBvejdhrvESEwdA?=
 =?us-ascii?Q?Ui2bVzhBzupw8WW9ihyhDblUxosLzAG9Ijps0wFSlcptbp35g9OZvjqJbDhO?=
 =?us-ascii?Q?rz+Nn/mk6Mr59fVJhB0AAye4qFXu717Z/WKKfC906CnparADaNSmBMjIprzB?=
 =?us-ascii?Q?YVDuBiTICVXLaExBQcy4G5OgMzHYmYMOayJYNWBdzleSLnnFWk3vyD/zoPtB?=
 =?us-ascii?Q?2K+1ekJ7QcakPQdRGVrqr7CXRc9jlbR1as2UE2pxGCwoM2Iux3W9MfPGyB7+?=
 =?us-ascii?Q?qGvOyJU8ESRwgPN6Um7jJrq7g1MpbMVj/yAnWNMmvLm/WGvbeQ0Kz3NBGT9n?=
 =?us-ascii?Q?k1tzt8NqUbLIvujaIVlsEPbVClbZ88pGFgMdT+DisHWwBxnIDid6D8ac0+6d?=
 =?us-ascii?Q?2rO0PPBw0ip6xOJntGMi46ODZUoBZeqy4NvvdH9FrjWsoDL4s8oL+66ybunj?=
 =?us-ascii?Q?XlCFDXzVXfaqM9yvy5oe2iQSwHev44nDGWjYoZGv4PsacvKRaAzbb7Q8XbID?=
 =?us-ascii?Q?ZJTODCtMJteBRug1i6f39JI3e5kXoN6Z5SdICsNbMFQNGBA9yzKpzEiL78AM?=
 =?us-ascii?Q?xv7OXHVEeB/4jNxsY4LCFqZspm4POF2hZZHKRIKSuMVzfEW2KEztUxwgm94L?=
 =?us-ascii?Q?VcwrPd05eHqf2Hzlon0E1/gtWIo7IjUKmnTMbjl0TIfJo7m05eX2bOBDTmNP?=
 =?us-ascii?Q?tuMk4sCBEfRSmrKmy5fgyFO9Ot9NUk/SaYDn4dpW/gCbPLr6GqAYdD2XoehF?=
 =?us-ascii?Q?REYrBPM23LvZUcInCzpcIC+3tijloyCGZ3ogtJKX1DmseoZfr/oFMdq9vBqy?=
 =?us-ascii?Q?BST7X5Py9Sex2UsQl+SS2nkN51dRnrv8l1af1wx1p2X1tZtacdeQqfTiB+/K?=
 =?us-ascii?Q?AssTwcq+Ywi8QaqqIz4G+C3xSKikgXKCYGio9ezUh+Tf9CD+LFDhP02feb2t?=
 =?us-ascii?Q?9oEBZNNG/Rql8ecVtuZZ6VxmP7DI4W4oULTqv2ucNbJ+tB2exoQtZ+6Z+Om5?=
 =?us-ascii?Q?EIZkBZLE3Ixm5sSGX9JdBYy4gCdyVOYhOibcxBUj25KnqSbr5ou/Y8AD7xCD?=
 =?us-ascii?Q?OGls6zOr1THRvqxRem6yVelWp1qoL+19sSLHdXkJwO7JDBDSJNYu4D1oOInG?=
 =?us-ascii?Q?OYPgsO8QyJeTbt+i/RQHZxjrpxEc96+Jf7/6ZKGGPrc/NeK4An1w5NFmXMBN?=
 =?us-ascii?Q?qi9FYNZHEkUbvnYjfrJdj6XId64ZvSk2hY0hXyblLWMZKXr6TSVwhH69T8xX?=
 =?us-ascii?Q?YZBLagRksk/pqXXT+NcRaSXhZ1JwJURxX6RizAkRq80UoGEuRCpHWsIBsXHA?=
 =?us-ascii?Q?OcKhLDQwXkDww049ZhMDB3Gl6MjiNUDqBeSXU5S+4fAzLmFO8dLLnTRIzT6K?=
 =?us-ascii?Q?v+SSgO1mmyEQRw0pLbQ8nfUjNsLYXb3ohObNmprYA1IP9ugYXaKL8W8FAgPk?=
 =?us-ascii?Q?YD88UcvDe7/pMiZ0hGU6RS5CzUYY4Zgg/kMhBVkJFzDglbIFm4q1pFWe2Z6V?=
 =?us-ascii?Q?BayoZwhEOdQImW4E7PIvN6ff2wd0k/C9fwQZ3BJX+SDrxNf7ptppvug7CgN6?=
 =?us-ascii?Q?7okPV1v8gjQmCZXJXiG1+a1nWKOUafjXKdhRl/r/VWnenxaDqWsWSvqlhK07?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2XlNVow95v/EWCOQU+VnvqjZ4W88UxgV2PNrb8IihZZq4EuazD4KuAxBEyf5kvBF47OsE38UDPL8n9PD1L3AESYMTuvz/yaVzPAEKNQLcsfsD/ugpMVDWIoOuekzQrQdXI+zWKCn/ggk1R/a/R0UlDBSJguw8RwZrJ+MEni19af+kMhy1xM7msVquL51NgmRR6rQOtKZNZArDm8lznj9Fl4gNQSqz3NVXrjB0lEChRvQovrai2ds5uFj55ZZH9nxc6QA6Mpof3gBRmtV5CZKvYUwUajNreFZ0FBZH8fal3JH6gMOvt5EJOz/Iz1y7ts2MLIV5LwtTwGfcmgusB9IAMdM5SjJj7FvJcsM2pzsgIhPdhEcEdVeFAKj6c7PSgp1EwwlbHDVbOUskEn1lB0Z+J6BcXHsvmR5G4xFcxhak0BF8iYLw/hSlIpnx8hCgxRcHtrhWp33N2DQQ5VFlodxEeL0NAY/8lDFy1e7imB/mRXx5SxjlN6KL3JpKXF4XNtpaHiv/uQarXXR2KzyKYruci65SHGbcnTqmDYWGpz4LcWc9BisLUALa1Ct/vuKOPOt07/llW3vHwhC4CNtUZ21ZqmNVij2zPHDQjGAItut93o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e50c6cce-2d5d-43b9-8915-08dd8aea0f9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:04.7010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpEZfieKKch7DpHISaIsBsb6MwL3zERKuDszG6lM7cM2fiwtmMiWsxIHKcfGfWzBvGkKoUrzjGVU4O44rtLQ2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Authority-Analysis: v=2.4 cv=C8LpyRP+ c=1 sm=1 tr=0 ts=68172c97 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=BdfLSKS78uDQwj0SyGAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX3RL1fVj9mf7B rpT0voIFERXtt+W+8sjE86ouztpg2YSpFh/fqZ9VWcMbAKHT7caOPS9MjsX5JTBmUpr91e4iBnb JfjSwDa3MjyIRezCprLWng+QysQ/lmwLo/w0sRlPuqjrEw9B0BO1EbF2vF8cQNrQRMaZ6CTcmQG
 FflFpe1Eb4kgBflbO0ujMpkpdKMm3iUXkfD0c6N4NeGjH9naFCs+s8A78dcYQGRdDS59g1MoaqM 0IEyzNWWHBPXaDA4iIVg/Ewthcjwpr9BJyV4Ut7lkk0A1NgHoX7Ez5C0Uw/sIlPpli47FNVG21/ f2eB12QBhV+d9BihzvvHyU4n8GjAaG7a+4acbppWT5UIXJTTZye/DaEHfC5v8rqAOW+fSEsyKk0
 ZMbKtkwDgCeCoJzXv7Hjqo+iWK1ZMT3Yun0nIFet3BjWWYYbp0TkrFJt04oezLC5aZlf7MUW
X-Proofpoint-ORIG-GUID: F6RT-MsXx_m0bg_NSRTFBlTx_Z4rlXIC
X-Proofpoint-GUID: F6RT-MsXx_m0bg_NSRTFBlTx_Z4rlXIC

Add a BMAPI flag to provide a hint to the block allocator to align extents
according to the extszhint.

This will be useful for atomic writes to ensure that we are not being
allocated extents which are not suitable (for atomic writes).

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_bmap.c | 5 +++++
 fs/xfs/libxfs/xfs_bmap.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 63255820b58a..d954f9b8071f 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -3312,6 +3312,11 @@ xfs_bmap_compute_alignments(
 		align = xfs_get_cowextsz_hint(ap->ip);
 	else if (ap->datatype & XFS_ALLOC_USERDATA)
 		align = xfs_get_extsz_hint(ap->ip);
+
+	/* Try to align start block to any minimum allocation alignment */
+	if (align > 1 && (ap->flags & XFS_BMAPI_EXTSZALIGN))
+		args->alignment = align;
+
 	if (align) {
 		if (xfs_bmap_extsize_align(mp, &ap->got, &ap->prev, align, 0,
 					ap->eof, 0, ap->conv, &ap->offset,
diff --git a/fs/xfs/libxfs/xfs_bmap.h b/fs/xfs/libxfs/xfs_bmap.h
index b4d9c6e0f3f9..d5f2729305fa 100644
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
-- 
2.31.1


