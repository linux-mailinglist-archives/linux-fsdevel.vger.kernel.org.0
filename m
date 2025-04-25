Return-Path: <linux-fsdevel+bounces-47371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D96FA9CC64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D8A1C027A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 15:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF66274671;
	Fri, 25 Apr 2025 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hBh9v36I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VuaVXxOt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E89267F42;
	Fri, 25 Apr 2025 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745593356; cv=fail; b=kSfxKRyvio8piebbo0E7CNHXWbPG4ToNVw7JEaT9PilYPMia3zhYJKdzeDCuu0MkstYoIbPR63+rSFaqJAT/yT9oOtqc48IjSpQ3AliWUaTnuMHx8MeqPxu9WzN1T1tE7Uk1ZMQtPlIlp7UMtUXQMM5xxVMEwgqk9RiFAuOXSp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745593356; c=relaxed/simple;
	bh=0NaqT+48Hn74Ymwy9pkGuO6dpi73dtLf9npt1wHypmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMebSVDu77EHsTKIecNoFD1hTSZhSvbaQ6yfyeVcnPWKq71PxwCOmtoRJoNd0IgjiZ+AaEqmltzfXj4Nu7+V1qMrqWP4ZKo1E4jcehAaLEGQj9M6BRrmUs8xItREJsxRdDEnNfB+wKqT0FmwdRWCQppJBye567LzLanclLWW+uQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hBh9v36I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VuaVXxOt; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtr6S026501;
	Fri, 25 Apr 2025 15:02:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uue9dnjDnucZ0k8a+q7dV6i2WUwY+yhnFcXuxQ83DZs=; b=
	hBh9v36ISQY8iaBjCLbS82lsy90dISKsqD3AJ7yY+tnEG2grAWnNIgze9OVgkIL3
	afyWNSzeZslItB+vE2aVBdsWRUIDKDAzi9dX3Um48T136Ylf3CI7cjqgeUBBrHaC
	Fq2icsesbm9er7pqaJjXc1hr6wkh9GPcjYNfd8V7fgiiHqfR8JhuNLYsqr7ZGXJY
	jKc6Cb5/a4ZdlG6KNaRyxJtsTB7OhlxfrIxJOY+SbaQ65q5QJ7oD6kuJX+N/q917
	KHalHyoGvG4dTlALf7juBH5GSgFJ98tLOnhIe7cYseOnm4nKjGsXSZ/AC6hratq9
	cqlq5Ou+9+6MrOCSD4+ATw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468bs185sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 15:02:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEtB1f024802;
	Fri, 25 Apr 2025 14:55:14 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010004.outbound.protection.outlook.com [40.93.20.4])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 467pucw37r-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:55:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JugETxghUKz6fgu2Yb8EF8BVpjApeNSLrCJBMm4kmKjmFCGw4vtMtZ5trZN5VEtLVCMMDT/zmSgMA3z1cCW6Mzn0YgPnZCyXNowIUrDPACxZmX6NIl7WnNegCKOs+DYxfT+9DB+rkNZGzfGsa3nEIfnaV3rlNpEMA8PI2lL7QvCij4CakXa6VSV2uu5zp8UpbfXqhSJg/f4XoD41tf9wrwXi27yvu73y2Y2cZjHdY3VCXf8M3v3xT0grH2Vc/uJSRY/vREP5kbhSVM2RaceTm+ldwECDy7FK7NPCW3TPqNsGjrUt10dh4s2VeHIyswVoCDng0aJcrbp9JWP9lqUHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uue9dnjDnucZ0k8a+q7dV6i2WUwY+yhnFcXuxQ83DZs=;
 b=FzGbvvyqIfh14foskgFxCu/VGMaVf2jz2jvJfijaBOy2iW4OVyB/XyUf3OZanNbG/qkpwEbXP6HwBE09raAWepLLNyj+KK0XNw15KQSz3FYG3bqKqVXj8kTHO9MUtY0XgV98GOcp5Etgaxc/vVj0bSOZpWDb5O5T3hjlSWAMRtFbmR9IKRva20hEryGsS7XKdbKCMTudvL53K4nRtr3GDpHH5ag0RQ4HM9lsud9S81N5BUg8aGzwxJ37BGXFliv/S4GbCCkXsEm1cfA9CWshzvVGjkvuzTdLx0zuOZmExzgfwrNfeE/8VASzwZzcgbygYRp7HNAceqk+roIE6HcNkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uue9dnjDnucZ0k8a+q7dV6i2WUwY+yhnFcXuxQ83DZs=;
 b=VuaVXxOtLWyEIkIBhprX5VWDRUmSlQXbjwLkzw8gy5BX4n3irGtDoFmAlKCZLGVnRbl0OeE+fJnk7CzJ9cPJ5aLye0JiCrzr1q67bKYQMJLoFPlHyF6sefK4NCy1tLXs8SDZcESkboTw8LaDQqmQMQCb7II6ankOs/CyuhtUCbw=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH2PR10MB4133.namprd10.prod.outlook.com (2603:10b6:610:a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 14:55:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 14:55:12 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mm: perform VMA allocation, freeing, duplication in mm
Date: Fri, 25 Apr 2025 15:54:36 +0100
Message-ID: <eb578074010f0b449e9cec3ae9dade7330d90813.1745592303.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
References: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0504.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH2PR10MB4133:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1ca4e3-fee5-4668-d140-08dd84092e10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bDqUR4igDZvZkYMZxtnfo++p7iLakc4ExtOr6M5XZhDs6X47CD5KwNX6ZTWq?=
 =?us-ascii?Q?dn9ogvG2NfofP/YP1tegSTQs/Ws2KDy//i2dTuhS+bSiOD6H5TnkDJa6RgdI?=
 =?us-ascii?Q?XjUhs8Syw4ZovnU6LgFhjzpr5dn/IPoMGOxQ4PxlwRCFNtyyqZ5WzUw3pKpE?=
 =?us-ascii?Q?FgGQdQCzY3UMzLQ0cT4bmF8cfS1jb3DI+jm+dSaMkc9JFxLkHIQoSvOBqPrB?=
 =?us-ascii?Q?x3h1oHeETB/e7wYtpPOm+MsrlA4uov0D2pBCbCigBAqqlCEQd3pMDmXpsGWL?=
 =?us-ascii?Q?WhUVOC2WvS1LhePkapSf5ooYdhA+iXaBuanMig4/nEj6bCozhKRmv+THxSty?=
 =?us-ascii?Q?V7e4xW5tWSRrrnSDlTSddaHT/a59lLwBDT4V2vY5UtWsUNXd+vTaItEXdL77?=
 =?us-ascii?Q?idCLPV1SOu25SjpaXUYNr3PDM8feBOzFNsxaXCq1KHfL/LSY/FBdQ7nP2tyB?=
 =?us-ascii?Q?PE5MLjkqQpGvYgG8+82QiCdQazU28DKyk9mhjeKVgx3N0IMM+3ttt6DmqYAD?=
 =?us-ascii?Q?TZSkbno7ow41tEhi91r/nzz4RcfPeJ6yGtBWMTbDhpbniY5EVsXSUVsJ0Crv?=
 =?us-ascii?Q?bzXd3K0jFX+bnihlVxcF3KP4d31E2yeztLSpi0ncrfJncagf2L1G8nGPhDkV?=
 =?us-ascii?Q?EG9d1oT9JqC+oUlxupbqxe+0kvrTfqLImkiPbn7Y2+0vi8CjtZyJKED9hBGc?=
 =?us-ascii?Q?4tibDCVqVBFVOYQGesGv+T1tzpC+fE+hlXyQeqLOjxU+sisZy0BlrZup0rcV?=
 =?us-ascii?Q?kZfxoYjiXS/ZBbhJyPOCbSCChkZIZt7IH3xOr061MJ43tvLzzwvNDzcDOzLU?=
 =?us-ascii?Q?U8mREigSj0RCDf7iYFXi9WeO1WS2QQPo0KZjPZnp41As9EPfoQUKOyVMc68/?=
 =?us-ascii?Q?/cgx53zt4NMVtcQGqhID3yd9UYHNOCfy8JuycqU62ABoR46qui7NBiPRn1+W?=
 =?us-ascii?Q?3wB7MkBfzB2R5nGWRIVQG5JVVSF3eEahVbFlYdMlPORpYa0dlUymQfKd31zo?=
 =?us-ascii?Q?z03hjORQxN7YKxbfr/Uxoj+Byghtqlpe8ZuKbQpWDUy5Ap4KXJbsNyfYDIoi?=
 =?us-ascii?Q?fUfpFY68WzbJze9r8YfXWdY1YLDjjq8qcmI06AftGR8g3ztZN2g0sXslkHxZ?=
 =?us-ascii?Q?jfUpEm7ab+CBRKJFF9+1uu6z9+9dwnr6mGG89oblU60KwyxrroGLRY5/M66t?=
 =?us-ascii?Q?P1Jc8ZaWaVjFnQbZ1rhqC0moycW/og1G8x3gE1lyuiLokQ72tw6aAMoSj72O?=
 =?us-ascii?Q?lduI1k5CsS+v/S5+Mt+6wmVfaBdM91fx2vPXYWQnHAi1kZhZdCWj88qCzwSQ?=
 =?us-ascii?Q?dG3kYhRyxEBVzV3WjLhSeXT1JsbMD6ypx1YFi1cx7BZEJKJr106HCIEPBHVk?=
 =?us-ascii?Q?wBmRcSrQYRs8hS0PMsLgAohuD3ZRF52gKUSBekLKrFyR3UHq7oE4NCDEojvZ?=
 =?us-ascii?Q?wNDy3s16SIw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gsjIE1674tmuM1Y5nSnKcR8Sfg/1AeedmQq7vQhFl9pnvw0kALMtIVTRBwIC?=
 =?us-ascii?Q?ja8RAeW5R2J7q9YLDQ/soj+RhPdLw38bf+U2GHO9actHRU1nulG+jdRgzzLo?=
 =?us-ascii?Q?tHcEETFTdb5h4ancDYtLPmChZ7Ev1XrUnqwjqK5QlEHTdA96bx1d0nDkpX5d?=
 =?us-ascii?Q?jNph35xIvMWb/Q+E5cZFA8E+OLbfJ3Llwhh6ZIqervEKBCUJmLyAooh3qyHI?=
 =?us-ascii?Q?oCuCVjrClaapI21bKhZ1nB8BPl10gx2gQNzUupEakXcI/EWuiZvGz1Jxw2bq?=
 =?us-ascii?Q?Kl+L46Zn5Sy+672Y8cYSysBQqI0UoFJ39/PDr+WlG6zqyvx5xaGKXV4kNcB5?=
 =?us-ascii?Q?SSCDYW66bjjc1UZ8uakwHC1a99zhNK2RxUIj5WI1knfng+iU+CPeHqxdsWrP?=
 =?us-ascii?Q?etmCFxYRKEeIPNBdQ+ee55PLlxy+1sTiW/nOXbD4RvYImVrQvbp3XgJ4ZFyj?=
 =?us-ascii?Q?qW3azNzfJ1y74cpguXFLe2DsPUv+BKPgWhcamjFzDqXVDwzPFq72wpZHMHmq?=
 =?us-ascii?Q?Ls+B+/jNvMAknQ4LMOdvCy3Z5r7xBfz9Rixp9vGW18QCIBqDXr4A4sjMj1lP?=
 =?us-ascii?Q?ZHQdfreMx+FyYoQRDjbPt/52D/m9x3VGk/a7X9tsK3zUJevBduyR+oNEOhqN?=
 =?us-ascii?Q?hjo0UTJy799jzHJTqcAMrMYFRUJvg1yOVwGlvj+XRW1RqzPmaxekiuuvO59y?=
 =?us-ascii?Q?hMKOt2PsCpsF5IjsAyXkH3S3AgEUls1ZYWKalBv4zHIrYDme4v4YmSglCeeR?=
 =?us-ascii?Q?LovbG8rFJeoJmKyoRiLbkB6e1+7M0UChMhPCbCqiRMTdJPS56hVaATrgiYn6?=
 =?us-ascii?Q?65s/4uP4XROP9R3FPt4SFhUuZS2WiUeXPBTe9fHb+vo0ATUwFy12EdDoj5jh?=
 =?us-ascii?Q?TwtPsoLh0AcD2k8chBSGsDHf8J/ARcHp+0L/+s11r69auPm51k+YLAYnubNj?=
 =?us-ascii?Q?2HHqRtQl0T3WIImwJgXTLH4dCxU6e0tkC11Yexjb6w+KrFE7DQ7qf/OUat7A?=
 =?us-ascii?Q?sv/2ht3xOWWIh6laB4RfvFBBK36Gr7fC1NrfFNkE9ZY1/drBsmet2AH6y7EL?=
 =?us-ascii?Q?5pSfzzIpUiFZEX00nK0mmwIo814FLWzo5DVazZB+lg7IzOrZ0YXN8mjq8xBT?=
 =?us-ascii?Q?yYde7+43B9bon0RtKg2w0o13VDNpBHy69RzuslffoCWfLk9R7B7ui/PehU+9?=
 =?us-ascii?Q?waVpSsu6vg8dh9GJrKyxuKJfDoF4XGJJpCz8XJhK0rKH89thl51xugx1DnG4?=
 =?us-ascii?Q?u2hJfKNwBWohPDkq586L2uhcVTom0Zg79+6/VdW513PPj1Rx8Y+2PEZzCzyU?=
 =?us-ascii?Q?k6Usk379lmGqDGOB/n4dGaYogopg1q0YnT52rz5gvvJ3AQbTbC9P/k8H/9DV?=
 =?us-ascii?Q?/35PCm1bD5FHieeUmhBiGfPY64EKT/HilRkFL9kzZ+q5c4sJPyp2Mxk9NvE1?=
 =?us-ascii?Q?Eu4sEmeny4xcOrPaLUW8JFoUwIrK2eFK7OGoJGPyS5mLiVBRtvI4Tvmvl1je?=
 =?us-ascii?Q?8RQJe44a5IWNfwFDZpXDGe6UbdnPPRtiibTI9azMCh0hp1787d97mH/j6PVU?=
 =?us-ascii?Q?LtBZIcRopt72T7lqr2Ru7SuakfuNmXOOTzpLf3OCfqmua9DYa1880XKf2rOH?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yObRPxnwdnjYn7D4oXGv2rjx2O42ivJSVkTA0Xey9/DU9JOgKPWrX4BZkVlYHfMELpRl5RYb84QM0I48rGkGv10Jj4Q2MPrNb1Q5Bb3BmbMtlJK2w/UIC0ENSCiAPSb30k81g16Bu5P7F9MPw7udIkZNaKJXy4yEskp4LFqe7YLaIMuBNtU5QUgQlfcd5bSHDkSXmlYUIJMhDEmeCEk56DCvC1kPvXtcfzkXg7y+GzJuypSAaZLi6UZgfBQukXIM3kfuaZzsBtouDIfL63r07fCcyYgtOw4Y5DET4OGqoYezpW0D7V41A9xRruDblVCMdILQVc76nZbYUNa2WBCjAiLjMyF4R+prTkx5Wq88bho2u7X2hEnu5QO5mj9ThRukFJOuPz3f8FfmY3w+3UEguuDnx+uHFtRBSG1gEncXKGiw8pLOgN1e7/0XzI/NNLk5uB0yMTaPFF/VR4NFSpFtK2x4Ra0OFOs5EEJpg/W0GxdZWqsRfOEvz9p6/JsKtKR9zaOonTHePVSs2Z5XCMCAPsjPtCc/dP8TzB/NpotLknbD+tULDd6hlaU+ig1gk+JNBUsxUpWvLRu5z1WB5wbXfKM68pj6853N+RyxKHPHX+U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1ca4e3-fee5-4668-d140-08dd84092e10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:55:12.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kW/aKCFTBbhNdb0l79jXH5/qshE92KRVMfoZroN3wSA4yMGCRlfw0IC5k3qFMDCfhNGmVg+T34LBK21IRB+AqDGvMAdP+ZvbGPiJW74SmCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4133
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504250106
X-Proofpoint-GUID: 5W1bnpJmmNfwR8o7ylL89G5rUNblTDb3
X-Proofpoint-ORIG-GUID: 5W1bnpJmmNfwR8o7ylL89G5rUNblTDb3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNyBTYWx0ZWRfXzrGm6koG54yN R75rqyGNfST5iaxj9XIg96PgNVfUVZyDnbZ+qwgfMS2HXxWhbub5dTk49LVaSTpdCNBYWHYQNVJ V1uKGj2LHgTot7tQZMABOhKUOarO6UTL+TlWHN9qLPzKyyb99UhOjWBclpQwIF6rZrsmhreVckk
 MDAW9GH9mrdUlUxh4Fq9mcM7VH0madfhc91dDO6RhwG7ATMyBanhQRLMTZg2uoV3e1+OAGLxnSQ TA9qb66Ij0UTw5zFwe7A7grfDDk0lTjJLGUHepyDfi0pAy8iZcvt7a+9SS7s8guedkOMkKb5yRY aUPJbatP2x88MQ/rUmqbcudt1uSPeoLuyNNfz+gFNliprDywYgY8mb+2rwXxZyX9A/DzoL6xIPk i/jdgm5A

Right now these are performed in kernel/fork.c which is odd and a violation
of separation of concerns, as well as preventing us from integrating this
and related logic into userland VMA testing going forward, and perhaps more
importantly - enabling us to, in a subsequent commit, make VMA
allocation/freeing a purely internal mm operation.

There is a fly in the ointment - nommu - mmap.c is not compiled if
CONFIG_MMU not set, and neither is vma.c.

To square the circle, let's add a new file - vma_init.c. This will be
compiled for both CONFIG_MMU and nommu builds, and will also form part of
the VMA userland testing.

This allows us to de-duplicate code, while maintaining separation of
concerns and the ability for us to userland test this logic.

Update the VMA userland tests accordingly, additionally adding a
detach_free_vma() helper function to correctly detach VMAs before freeing
them in test code, as this change was triggering the assert for this.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 MAINTAINERS                      |   1 +
 kernel/fork.c                    |  88 -------------------
 mm/Makefile                      |   2 +-
 mm/mmap.c                        |   3 +-
 mm/nommu.c                       |   4 +-
 mm/vma.h                         |   6 ++
 mm/vma_init.c                    | 101 ++++++++++++++++++++++
 tools/testing/vma/Makefile       |   2 +-
 tools/testing/vma/vma.c          |  26 ++++--
 tools/testing/vma/vma_internal.h | 143 +++++++++++++++++++++++++------
 10 files changed, 250 insertions(+), 126 deletions(-)
 create mode 100644 mm/vma_init.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4015227645cc..ce422b268cb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15608,6 +15608,7 @@ F:	mm/mremap.c
 F:	mm/mseal.c
 F:	mm/vma.c
 F:	mm/vma.h
+F:	mm/vma_init.c
 F:	mm/vma_internal.h
 F:	tools/testing/selftests/mm/merge.c
 F:	tools/testing/vma/
diff --git a/kernel/fork.c b/kernel/fork.c
index ac9f9267a473..9e4616dacd82 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -431,88 +431,9 @@ struct kmem_cache *files_cachep;
 /* SLAB cache for fs_struct structures (tsk->fs) */
 struct kmem_cache *fs_cachep;
 
-/* SLAB cache for vm_area_struct structures */
-static struct kmem_cache *vm_area_cachep;
-
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
-struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!vma)
-		return NULL;
-
-	vma_init(vma, mm);
-
-	return vma;
-}
-
-static void vm_area_init_from(const struct vm_area_struct *src,
-			      struct vm_area_struct *dest)
-{
-	dest->vm_mm = src->vm_mm;
-	dest->vm_ops = src->vm_ops;
-	dest->vm_start = src->vm_start;
-	dest->vm_end = src->vm_end;
-	dest->anon_vma = src->anon_vma;
-	dest->vm_pgoff = src->vm_pgoff;
-	dest->vm_file = src->vm_file;
-	dest->vm_private_data = src->vm_private_data;
-	vm_flags_init(dest, src->vm_flags);
-	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
-	       sizeof(dest->vm_page_prot));
-	/*
-	 * src->shared.rb may be modified concurrently when called from
-	 * dup_mmap(), but the clone will reinitialize it.
-	 */
-	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
-	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
-	       sizeof(dest->vm_userfaultfd_ctx));
-#ifdef CONFIG_ANON_VMA_NAME
-	dest->anon_name = src->anon_name;
-#endif
-#ifdef CONFIG_SWAP
-	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
-	       sizeof(dest->swap_readahead_info));
-#endif
-#ifndef CONFIG_MMU
-	dest->vm_region = src->vm_region;
-#endif
-#ifdef CONFIG_NUMA
-	dest->vm_policy = src->vm_policy;
-#endif
-}
-
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-	vm_area_init_from(orig, new);
-	vma_lock_init(new, true);
-	INIT_LIST_HEAD(&new->anon_vma_chain);
-	vma_numab_state_init(new);
-	dup_anon_vma_name(orig, new);
-
-	return new;
-}
-
-void vm_area_free(struct vm_area_struct *vma)
-{
-	/* The vma should be detached while being destroyed. */
-	vma_assert_detached(vma);
-	vma_numab_state_free(vma);
-	free_anon_vma_name(vma);
-	kmem_cache_free(vm_area_cachep, vma);
-}
-
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -3033,11 +2954,6 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
-	struct kmem_cache_args args = {
-		.use_freeptr_offset = true,
-		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
-	};
-
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3054,10 +2970,6 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = kmem_cache_create("vm_area_struct",
-			sizeof(struct vm_area_struct), &args,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
-			SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/Makefile b/mm/Makefile
index 9d7e5b5bb694..88e80df4b539 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -55,7 +55,7 @@ obj-y			:= filemap.o mempool.o oom_kill.o fadvise.o \
 			   mm_init.o percpu.o slab_common.o \
 			   compaction.o show_mem.o \
 			   interval_tree.o list_lru.o workingset.o \
-			   debug.o gup.o mmap_lock.o $(mmu-y)
+			   debug.o gup.o mmap_lock.o vma_init.o $(mmu-y)
 
 # Give 'page_alloc' its own module-parameter namespace
 page-alloc-y := page_alloc.o
diff --git a/mm/mmap.c b/mm/mmap.c
index 5ba12aa8be59..99e51d82ac0b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1596,7 +1596,7 @@ static const struct ctl_table mmap_table[] = {
 #endif /* CONFIG_SYSCTL */
 
 /*
- * initialise the percpu counter for VM
+ * initialise the percpu counter for VM, initialise VMA state.
  */
 void __init mmap_init(void)
 {
@@ -1607,6 +1607,7 @@ void __init mmap_init(void)
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", mmap_table);
 #endif
+	vma_state_init();
 }
 
 /*
diff --git a/mm/nommu.c b/mm/nommu.c
index a142fc258d39..0bf4849b8204 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -399,7 +399,8 @@ static const struct ctl_table nommu_table[] = {
 };
 
 /*
- * initialise the percpu counter for VM and region record slabs
+ * initialise the percpu counter for VM and region record slabs, initialise VMA
+ * state.
  */
 void __init mmap_init(void)
 {
@@ -409,6 +410,7 @@ void __init mmap_init(void)
 	VM_BUG_ON(ret);
 	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
 	register_sysctl_init("vm", nommu_table);
+	vma_state_init();
 }
 
 /*
diff --git a/mm/vma.h b/mm/vma.h
index 149926e8a6d1..7f476ca3d52e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -548,4 +548,10 @@ int expand_downwards(struct vm_area_struct *vma, unsigned long address);
 
 int __vm_munmap(unsigned long start, size_t len, bool unlock);
 
+/* vma_init.h, shared between CONFIG_MMU and nommu. */
+void __init vma_state_init(void);
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm);
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig);
+void vm_area_free(struct vm_area_struct *vma);
+
 #endif	/* __MM_VMA_H */
diff --git a/mm/vma_init.c b/mm/vma_init.c
new file mode 100644
index 000000000000..967ca8517986
--- /dev/null
+++ b/mm/vma_init.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+/*
+ * Functions for initialisaing, allocating, freeing and duplicating VMAs. Shared
+ * between CONFIG_MMU and non-CONFIG_MMU kernel configurations.
+ */
+
+#include "vma_internal.h"
+#include "vma.h"
+
+/* SLAB cache for vm_area_struct structures */
+static struct kmem_cache *vm_area_cachep;
+
+void __init vma_state_init(void)
+{
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
+
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT);
+}
+
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+
+	return vma;
+}
+
+static void vm_area_init_from(const struct vm_area_struct *src,
+			      struct vm_area_struct *dest)
+{
+	dest->vm_mm = src->vm_mm;
+	dest->vm_ops = src->vm_ops;
+	dest->vm_start = src->vm_start;
+	dest->vm_end = src->vm_end;
+	dest->anon_vma = src->anon_vma;
+	dest->vm_pgoff = src->vm_pgoff;
+	dest->vm_file = src->vm_file;
+	dest->vm_private_data = src->vm_private_data;
+	vm_flags_init(dest, src->vm_flags);
+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
+	       sizeof(dest->vm_page_prot));
+	/*
+	 * src->shared.rb may be modified concurrently when called from
+	 * dup_mmap(), but the clone will reinitialize it.
+	 */
+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
+	       sizeof(dest->vm_userfaultfd_ctx));
+#ifdef CONFIG_ANON_VMA_NAME
+	dest->anon_name = src->anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
+	       sizeof(dest->swap_readahead_info));
+#endif
+#ifndef CONFIG_MMU
+	dest->vm_region = src->vm_region;
+#endif
+#ifdef CONFIG_NUMA
+	dest->vm_policy = src->vm_policy;
+#endif
+}
+
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	vm_area_init_from(orig, new);
+	vma_lock_init(new, true);
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+	vma_numab_state_init(new);
+	dup_anon_vma_name(orig, new);
+
+	return new;
+}
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	/* The vma should be detached while being destroyed. */
+	vma_assert_detached(vma);
+	vma_numab_state_free(vma);
+	free_anon_vma_name(vma);
+	kmem_cache_free(vm_area_cachep, vma);
+}
diff --git a/tools/testing/vma/Makefile b/tools/testing/vma/Makefile
index 860fd2311dcc..4fa5a371e277 100644
--- a/tools/testing/vma/Makefile
+++ b/tools/testing/vma/Makefile
@@ -9,7 +9,7 @@ include ../shared/shared.mk
 OFILES = $(SHARED_OFILES) vma.o maple-shim.o
 TARGETS = vma
 
-vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma.h
+vma.o: vma.c vma_internal.h ../../../mm/vma.c ../../../mm/vma_init.c ../../../mm/vma.h
 
 vma:	$(OFILES)
 	$(CC) $(CFLAGS) -o $@ $(OFILES) $(LDLIBS)
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 7cfd6e31db10..98a1a0390583 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -28,6 +28,7 @@ unsigned long stack_guard_gap = 256UL<<PAGE_SHIFT;
  * Directly import the VMA implementation here. Our vma_internal.h wrapper
  * provides userland-equivalent functionality for everything vma.c uses.
  */
+#include "../../../mm/vma_init.c"
 #include "../../../mm/vma.c"
 
 const struct vm_operations_struct vma_dummy_vm_ops;
@@ -90,6 +91,12 @@ static int attach_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 	return res;
 }
 
+static void detach_free_vma(struct vm_area_struct *vma)
+{
+	vma_mark_detached(vma);
+	vm_area_free(vma);
+}
+
 /* Helper function to allocate a VMA and link it to the tree. */
 static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 						 unsigned long start,
@@ -103,7 +110,7 @@ static struct vm_area_struct *alloc_and_link_vma(struct mm_struct *mm,
 		return NULL;
 
 	if (attach_vma(mm, vma)) {
-		vm_area_free(vma);
+		detach_free_vma(vma);
 		return NULL;
 	}
 
@@ -248,7 +255,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
 
 	vma_iter_set(vmi, 0);
 	for_each_vma(*vmi, vma) {
-		vm_area_free(vma);
+		detach_free_vma(vma);
 		count++;
 	}
 
@@ -318,7 +325,7 @@ static bool test_simple_merge(void)
 	ASSERT_EQ(vma->vm_pgoff, 0);
 	ASSERT_EQ(vma->vm_flags, flags);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -360,7 +367,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
 
 	vma = vma_next(&vmi);
@@ -369,7 +376,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_end, 0x2000);
 	ASSERT_EQ(vma->vm_pgoff, 1);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	vma_iter_clear(&vmi);
 
 	vma = vma_next(&vmi);
@@ -378,7 +385,7 @@ static bool test_simple_modify(void)
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma->vm_pgoff, 2);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -406,7 +413,7 @@ static bool test_simple_expand(void)
 	ASSERT_EQ(vma->vm_end, 0x3000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -427,7 +434,7 @@ static bool test_simple_shrink(void)
 	ASSERT_EQ(vma->vm_end, 0x1000);
 	ASSERT_EQ(vma->vm_pgoff, 0);
 
-	vm_area_free(vma);
+	detach_free_vma(vma);
 	mtree_destroy(&mm.mm_mt);
 
 	return true;
@@ -618,7 +625,7 @@ static bool test_merge_new(void)
 		ASSERT_EQ(vma->vm_pgoff, 0);
 		ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
 
-		vm_area_free(vma);
+		detach_free_vma(vma);
 		count++;
 	}
 
@@ -1667,6 +1674,7 @@ int main(void)
 	int num_tests = 0, num_fail = 0;
 
 	maple_tree_init();
+	vma_state_init();
 
 #define TEST(name)							\
 	do {								\
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 572ab2cea763..28f778818d3f 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -135,6 +135,10 @@ typedef __bitwise unsigned int vm_fault_t;
  */
 #define pr_warn_once pr_err
 
+#define data_race(expr) expr
+
+#define ASSERT_EXCLUSIVE_WRITER(x)
+
 struct kref {
 	refcount_t refcount;
 };
@@ -235,6 +239,8 @@ struct file {
 
 #define VMA_LOCK_OFFSET	0x40000000
 
+typedef struct { unsigned long v; } freeptr_t;
+
 struct vm_area_struct {
 	/* The first cache line has the info for VMA tree walking. */
 
@@ -244,9 +250,7 @@ struct vm_area_struct {
 			unsigned long vm_start;
 			unsigned long vm_end;
 		};
-#ifdef CONFIG_PER_VMA_LOCK
-		struct rcu_head vm_rcu;	/* Used for deferred freeing. */
-#endif
+		freeptr_t vm_freeptr; /* Pointer used by SLAB_TYPESAFE_BY_RCU */
 	};
 
 	struct mm_struct *vm_mm;	/* The address space we belong to. */
@@ -421,6 +425,65 @@ struct vm_unmapped_area_info {
 	unsigned long start_gap;
 };
 
+struct kmem_cache_args {
+	/**
+	 * @align: The required alignment for the objects.
+	 *
+	 * %0 means no specific alignment is requested.
+	 */
+	unsigned int align;
+	/**
+	 * @useroffset: Usercopy region offset.
+	 *
+	 * %0 is a valid offset, when @usersize is non-%0
+	 */
+	unsigned int useroffset;
+	/**
+	 * @usersize: Usercopy region size.
+	 *
+	 * %0 means no usercopy region is specified.
+	 */
+	unsigned int usersize;
+	/**
+	 * @freeptr_offset: Custom offset for the free pointer
+	 * in &SLAB_TYPESAFE_BY_RCU caches
+	 *
+	 * By default &SLAB_TYPESAFE_BY_RCU caches place the free pointer
+	 * outside of the object. This might cause the object to grow in size.
+	 * Cache creators that have a reason to avoid this can specify a custom
+	 * free pointer offset in their struct where the free pointer will be
+	 * placed.
+	 *
+	 * Note that placing the free pointer inside the object requires the
+	 * caller to ensure that no fields are invalidated that are required to
+	 * guard against object recycling (See &SLAB_TYPESAFE_BY_RCU for
+	 * details).
+	 *
+	 * Using %0 as a value for @freeptr_offset is valid. If @freeptr_offset
+	 * is specified, %use_freeptr_offset must be set %true.
+	 *
+	 * Note that @ctor currently isn't supported with custom free pointers
+	 * as a @ctor requires an external free pointer.
+	 */
+	unsigned int freeptr_offset;
+	/**
+	 * @use_freeptr_offset: Whether a @freeptr_offset is used.
+	 */
+	bool use_freeptr_offset;
+	/**
+	 * @ctor: A constructor for the objects.
+	 *
+	 * The constructor is invoked for each object in a newly allocated slab
+	 * page. It is the cache user's responsibility to free object in the
+	 * same state as after calling the constructor, or deal appropriately
+	 * with any differences between a freshly constructed and a reallocated
+	 * object.
+	 *
+	 * %NULL means no constructor.
+	 */
+	void (*ctor)(void *);
+};
+
 static inline void vma_iter_invalidate(struct vma_iterator *vmi)
 {
 	mas_pause(&vmi->mas);
@@ -505,31 +568,38 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
 	vma->vm_lock_seq = UINT_MAX;
 }
 
-static inline struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma = calloc(1, sizeof(struct vm_area_struct));
+struct kmem_cache {
+	const char *name;
+	size_t object_size;
+	struct kmem_cache_args *args;
+};
 
-	if (!vma)
-		return NULL;
+static inline struct kmem_cache *__kmem_cache_create(const char *name,
+						     size_t object_size,
+						     struct kmem_cache_args *args)
+{
+	struct kmem_cache *ret = malloc(sizeof(struct kmem_cache));
 
-	vma_init(vma, mm);
+	ret->name = name;
+	ret->object_size = object_size;
+	ret->args = args;
 
-	return vma;
+	return ret;
 }
 
-static inline struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = calloc(1, sizeof(struct vm_area_struct));
+#define kmem_cache_create(__name, __object_size, __args, ...)           \
+	__kmem_cache_create((__name), (__object_size), (__args))
 
-	if (!new)
-		return NULL;
+static inline void *kmem_cache_alloc(struct kmem_cache *s, gfp_t gfpflags)
+{
+	(void)gfpflags;
 
-	memcpy(new, orig, sizeof(*new));
-	refcount_set(&new->vm_refcnt, 0);
-	new->vm_lock_seq = UINT_MAX;
-	INIT_LIST_HEAD(&new->anon_vma_chain);
+	return calloc(s->object_size, 1);
+}
 
-	return new;
+static inline void kmem_cache_free(struct kmem_cache *s, void *x)
+{
+	free(x);
 }
 
 /*
@@ -696,11 +766,6 @@ static inline void mpol_put(struct mempolicy *)
 {
 }
 
-static inline void vm_area_free(struct vm_area_struct *vma)
-{
-	free(vma);
-}
-
 static inline void lru_add_drain(void)
 {
 }
@@ -1240,4 +1305,32 @@ static inline int mapping_map_writable(struct address_space *mapping)
 	return 0;
 }
 
+static inline void vma_lock_init(struct vm_area_struct *vma, bool reset_refcnt)
+{
+	(void)vma;
+	(void)reset_refcnt;
+}
+
+static inline void vma_numab_state_init(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
+static inline void vma_numab_state_free(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
+static inline void dup_anon_vma_name(struct vm_area_struct *orig_vma,
+				     struct vm_area_struct *new_vma)
+{
+	(void)orig_vma;
+	(void)new_vma;
+}
+
+static inline void free_anon_vma_name(struct vm_area_struct *vma)
+{
+	(void)vma;
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


