Return-Path: <linux-fsdevel+bounces-46926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BEA96964
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 14:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BBE17D255
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Apr 2025 12:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3863427F4FE;
	Tue, 22 Apr 2025 12:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JuV4NP6o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iM33A7t0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB327CCF5;
	Tue, 22 Apr 2025 12:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745324922; cv=fail; b=lVZ5xMzzcbBPDVpo4Q2ZEi1+9VkGKgAupQwDg+u2Rk13vWWe/hPnU7Og/Z+dpsqLl/AzR3UnzLDjWQoTdjne8D8KiJzPoB9mQfC3Ra0V82s+dRF6CH2LqxVYfS6nr4ibLjAk0wxKIV8N2QdF/EHJLJtxkztRcsMJy2/jz++34ZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745324922; c=relaxed/simple;
	bh=aBbCgTE+0p+dUqM5/IOXqx+WKdyzVIPaWCYBrY++5Rc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9jnvnCD1ZJyCTPIawiPM26yP8P0FXPE8m1N1NcP2sd/L4lu1g/GSNGJTyWMkFWbw3S25o0Z9Pakb9gBxgIfc/QUbTmuUnrluXQT2RyvbhdcdhEqE/DrszB8SKHSZ6JY7m9Wa/+MRehdzhSRtla7JaPheZ/rOiYl2ZQbHHkPUX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JuV4NP6o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iM33A7t0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MB3StL026435;
	Tue, 22 Apr 2025 12:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=; b=
	JuV4NP6oEkjaWEOTWdfpcYbA2dOsItHUVYt3avauGxYbcNNVTjsprOdbWVSWKWmb
	XKu5NzLrSXPd6HhOkT7HrSpO54AzSyXfFsy3hBiBBblQ5hKonE41orIcIgkexpgg
	fkDm0/THKfQggez1JDaaWlfR1LeI8Xv00qzjxOBnkL4RG4p4c4kqnuXquYFPUQZG
	SiLg2lHsrxs49PFkdeUv0wZSlmIssiyenl40Bz79BLJZObDdQDPOF4DxSAk/QfVU
	WSOvcHVana8Q6RBRQGy/h3JrH840QaOtprrT9bmSZFWDDz9sW8UZN2K3twnVWJic
	a2mHolRIFifLYeR0aDm0Bw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4644csvbsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBidUb033447;
	Tue, 22 Apr 2025 12:28:28 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013061.outbound.protection.outlook.com [40.93.20.61])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4642999rng-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Apr 2025 12:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJ+l2GXMJXM4DGjhKl3lP2sBdq1+svIw6Xi/4hYkQ4qTADiViTHYQUHrkegMOtI8RmgrEarkWFmxTG+6Vx2+DqeHq8YW2VjPy70bGzuWrqjoiWh1GSihFzZjbdEDda0PyCVhDm8s+XCQqMxd8ylknbREOvzvrJoMFO+Sy+EvxA4oIUnMZK75RmQMtWZOi+J8i0tftxG+BPEZ470C8X1/dpObX7ybDawnPh8huWQP4DqxZQOnb35yuaoFl7Zg2pg165OAthv/H3YXZ2ZYZzJaV84IDDi4yoVpeYxsDgKP79K6ueqT9B2lDoiBqx1+LNvvpGQjVzM6I30mngUhJcNSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=;
 b=Gd6dXM4dgZ8MxDm5NkWEC1WwwBBvr2dRg7O/qyA4gn+wFvvodyXcIofP/JpuemTQjTzGxxaoPRuDnLdwJkCVmWcyHn/EZxAvhI0kPVVqMO3zgvJ//lC2cbCeGYq1iT/6OReXZebnIxlpcOL6yMHWKcYg4axnqhX//oW6w0uTwe6hoU0hVhV0TtDOB+I+d0f1fmninLj1dyXYgsWE7x4ljQ3u/2sv6KDrMkZbGpoNLW8+JQ76DX5k+ha/D5HwICqLd74lDvpwQKMlmRrmdkmWqP+tD6ep45cCNL6Uyrkl03TcdZ+/G8HbHZy7k0Pc9/BTV1UnmV/gNmeDvUTNCP6mcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKB77eQW3EJ+VRK6VE2kRFRgX+2VOScnIommq5SSPBk=;
 b=iM33A7t0zOLpENEAjghEfFTTh/0PpbugcDsmK6FIOtEq94XsVl94YTvaqOB0rNkcOJ51V4zzJx7kX53Wbc+EQOmYYNzXYtt2kAe80kiaW8CdkTpB8V9PBN4RuDr3+RSlBtRPF3VP36guuNBDiOJfaTC++4OwCcMgKU/FUDTsY/g=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB4895.namprd10.prod.outlook.com (2603:10b6:5:3a7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.31; Tue, 22 Apr
 2025 12:28:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Tue, 22 Apr 2025
 12:28:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v8 03/15] xfs: add helpers to compute transaction reservation for finishing intent items
Date: Tue, 22 Apr 2025 12:27:27 +0000
Message-Id: <20250422122739.2230121-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250422122739.2230121-1-john.g.garry@oracle.com>
References: <20250422122739.2230121-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0131.namprd03.prod.outlook.com
 (2603:10b6:208:32e::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB4895:EE_
X-MS-Office365-Filtering-Correlation-Id: 56025390-2e76-4711-f5e6-08dd81992e01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DGYtF27lqYa2pcOIs0KsBZoRp7HykNmiyCag/62ClWnDF+l1lt8sfwGMJluy?=
 =?us-ascii?Q?0/qZ03m1Z5e80ipmYuO8qoWP33eoXzrJohOilqHPDyTyXWH3qZ86wF//Zqrq?=
 =?us-ascii?Q?ufkxr1IxwxEFUibJtyU29Ych0vJoNVmZkYU5WvzpXhOIZX7YHZPnJqWEWFnc?=
 =?us-ascii?Q?1z+XUOOqHN/PuyUoQNX//E6oEEMeDQeoAtuxYpgmJPYESfk4tBnFxkZpR95G?=
 =?us-ascii?Q?xRnRlDSnexdUljZlLWhC4xZjby3d6eIFR4/ZHMKDQReZDetOb/rsjwpPSIG0?=
 =?us-ascii?Q?W3Fy0uC+Zm4XjgEJfUjPe+irmt2EUIWV3IZw39Mdy7dr8CNQ6wzOGh+/oVyT?=
 =?us-ascii?Q?rFBZ9zNkO1vdRuktjChkyCEC7HORIR1ILdsoPtcvRygwSdiiUSV+xB78k1Ky?=
 =?us-ascii?Q?A2UM3wCEbYLrD0/AALRHVGtXmAKAbl5EdIdrTfvJ0aw6fwTBsYB8Hiinyv0T?=
 =?us-ascii?Q?1bbV51Jor5OFxFzZBGqgBznZ3MSV9FjITH2Ls1BpGFiVAc9l2QToGAGoEnRv?=
 =?us-ascii?Q?cI6XSSJQ6GwYZlv7l9kVWnBAwCLz2k+tNtrbeBcaqJiy87xjalQeAr3uzn2j?=
 =?us-ascii?Q?7t61af0L3CUOEste2qoy7eSnPTLqBZaQ8eAyRsGiizfS5HTjfVjMerTOnV8M?=
 =?us-ascii?Q?ywoXZVV12SWUe0P6GO1Gn2mPdQ1EvHOpCGZJMR8fuVZ+oOESVf6UdX78v8i2?=
 =?us-ascii?Q?EufwiJKU3SRAzWPzPUEYzx0JnNuc+GqdSXVXH87BUf/+OYJNuAw6cKbST77+?=
 =?us-ascii?Q?hxkSLIbSO+0D2pz4AKBrUR/i5Es+tNrAu9UAoHdlm6HfEC47gBm+0sPET7b6?=
 =?us-ascii?Q?vEyf5ZiArU3N3F9yzOxKDjQmh0zJgHGJ1hPThc7S+iNoUDkkNNqo/z8am3be?=
 =?us-ascii?Q?Mh6e3frKSpAmV8t24KJ0F4QRhsi4/mHhxSHnl5ER1pf3FE+9bu7sQaZYJNMQ?=
 =?us-ascii?Q?6OHW/4C8vgs83vkpJHc4HD5rkP30XykYml/Zm9Z29AxyBKsfo4BYPKWqOGjk?=
 =?us-ascii?Q?NBWDGOUfJSQircWmBi8kuwolSp4/YbMs8Da2kABMztIJIvRXifBg60NItVXl?=
 =?us-ascii?Q?J6Q+kz0/VIBhyH65DOBQUMiqc8TMjFtAlVhKvxtQ49QL5yF6MLPMooVK6zVm?=
 =?us-ascii?Q?qYDAtBpNJVK2lpdB9P7fqY7P7IL8MvLzdtUsCnTJwsPIDNrg5Uc6rOB44SgG?=
 =?us-ascii?Q?Cc42ckyKNiZClSd1AMxG3xVKBJ8EBO7gNZ/DHUyQYdnnxSeVEn3hsikFW6qD?=
 =?us-ascii?Q?x3R2Cpfmy0ArwT7t0bfUlwdcK1aom/TRUuF7oUJaLpN3jmXILZ5ZFqPwMyWf?=
 =?us-ascii?Q?1YQGTMeEfa4RiObRcttCg9et5hdWxvwMf6QjEkIWHnT1h8tDfGQzdCmVIHc6?=
 =?us-ascii?Q?cUK1c6tMDqJujA0IR/QaboiJlyYfcjN+Lf08pFmfjQe/tOgSRKEJECJUaDZp?=
 =?us-ascii?Q?zana7vozlrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sqng66U2X/W02wDXkl4bjFZOLZ4YQiZaHCXndaN8G22i2Un9yV3MqRtuBUZp?=
 =?us-ascii?Q?xWwg3gbiFiBTSDI9WfEp2HmCWQaaSm6oNWBBEu8Rst7jAoXYe3YjegyHE9X7?=
 =?us-ascii?Q?liJspQuahplmmXd1r6slymoswWsgCUmmXgH9XlgwM/cVxd88Hri6DndKu74s?=
 =?us-ascii?Q?mW0kZgHPSgBDjf6NCzVGKzUofHVDoPxYeitXAYtsZMXp6Ur35/MBeclU9gp2?=
 =?us-ascii?Q?CpVuKq6T/4Jfcdvq/0SJFsa1btYVvuDiwS+hB1+OaSLYpUG438ebaBCtMM8s?=
 =?us-ascii?Q?eK6fQY7+JrT1SlDZbvAmhhBEW8UFmLpvp1cVvZh7aiokEl+RGtLPakw8Is0G?=
 =?us-ascii?Q?N/PtqXN25U4jSf6h5tZ/y3H5ugajnLh3/sEpVJtCC3vngjdKXbyYm3uwwDvn?=
 =?us-ascii?Q?0s5eMRv+kwWTgT3dKUUrj5uF+y7LRO7xyiX97GnzPwVEsWW0QaeRMlkW8Fh8?=
 =?us-ascii?Q?/vR8nFY6UZC3CLiuPXKvySZhbzqHoRYHN4e/TYQhwyYBN2JxAIml1EhnmIwQ?=
 =?us-ascii?Q?pVOaA5gbBPCgG9veccdhKQEdBnEUL343vUIUNXdMPhWDSbHcft9nMP0wAW5F?=
 =?us-ascii?Q?ySnHctAD+XgBv+5KCJPii89z8KByLE3pXzqvdvEHjRPzHVXdBbe/VIkSjfg1?=
 =?us-ascii?Q?i2vegLd5s1xXaoswqTiiqZaQxIiyNIvPKOoaAIsGXkvOvf0Ydvv+kwoEF+kE?=
 =?us-ascii?Q?TOiMH14Jty/StYPSbMNNzr7MpyHMQ4TRKY5eL0hJ5lvqDlB4ivLGSWATfy/n?=
 =?us-ascii?Q?Nz/2vSYV/yroTPoUa4ClCM/dJfHwFPpCtAL8xyDV3mxE6UHTHDDTfBlzTsdi?=
 =?us-ascii?Q?GVslcLPnMM9wwN+2hNKQLPT8TYvmDGXweN/zJV+LhXBrqc1sX1wd9EmBSMK3?=
 =?us-ascii?Q?qE2AHJbwwUv8mqe0RiDzGR4ASnsM83xrpVRnwVHYmbk0fh1aavv0Zw4LI9vv?=
 =?us-ascii?Q?+EVntaHKgTPXXE1Vk0JNSv7NmiKjzhZ7bDWB0YVLvacGJfSi2X9MB1myzG49?=
 =?us-ascii?Q?2dJjILgfqjpf1p5D97nCjyF2yK8Dc8yqNy82MGuxH4PJhm4AuYGuPlKQFsbs?=
 =?us-ascii?Q?JOgXhfsmsLXj7IiGTuLo0VBuw+iD64yfdQgYQucaGWesZWVUBDPcw279Hug1?=
 =?us-ascii?Q?3RvASgXOSu4KWF2E7gDp+aMeDfLou58qodVH0LAyPGR7jUE1JOY3NsOW4235?=
 =?us-ascii?Q?EKAzTUp6BGX0hAPiZWVuvkqWEnI1L0al1w0BtUsYFxrHoU7z5DS7JJtgoUEC?=
 =?us-ascii?Q?zDyVxxAa/KqK/GT97qXlqH58iV0tnXJMpG6XMjWctbar2tmptRPd/YXubKTY?=
 =?us-ascii?Q?0bLruZbfXsFWpzNAfZrLt2dxzy1yNFT1FoW2ToO7wiDcUI1U1NBoBMhoIki3?=
 =?us-ascii?Q?u1gJYoD15Nokce1ju8sJ2py+VaDgqzhCSvnrbH8H2aB1Tm3m8FMLrrf9C0Z4?=
 =?us-ascii?Q?jJmb5x5YQhX5uWWy2fRbY/c05jZqd8JsThwNC+r8c9RWZCTyOa8IxFFO+bX7?=
 =?us-ascii?Q?VZe2g5mjWl28p6p8QPN+tuwTLqo0k6dhJO+LhtoSeJHOtpPujK+zf2+2ncvi?=
 =?us-ascii?Q?1k2zm9FJHS+ljeqFOVCnvPA7juXxS4UT+1JyktE08GJAOGMVOKlNGUXmAHKw?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o1BayntMLQLf0uhojFyYfbokBmS7xhp/9pGTgIagjUhCeuTmoy0Leg8KyvxmyOTmEgP226EDiEjE7jdowt7EsVuwEp3U2BzILjZH2xd1PVEiebGn0n8X98JTi1qCz31PYRuA+iaLhXqix2HF/lIVUYkMEKeXdhgLWA7qKtg1rs5AAQXORYYp0CBTEE48LmXRrSpOSuTnLAzGREU/a1PLzuhzc0ivDH8Ah5fcvNreBQlzQBFtiJJkuZu8LgV9pUbs3cIVpmfE1lyCZss/KjDDdcTlbogJyBFTBG9TwK1vknkpHjul2cno3EMbVBQQwdO0UK00qCUjgUIZJJZ7fH1bBa98XhQjKR9dh6D4JT8yGPVAs6PDXXGglvRPfI71BTyDRoLEPKYfVoUfbFdnqfOpZf4qWaIzqlNW9uKcGMiOpQuAFNSX8fcZ+XjCto8E/EzDKwplKc6aH6gBTUQV/d5NBZi8VyDMrt8K6H9IDhTQiHlvHaRSNnw0noCqKtw7XXKdfQzYYYt39I1SkUoibUV2w16L3Cxqx6B9GjfvUwcmKHW9Dz33Fj2cd1IJVJHwth7tqXJTtWTcUDa71y9l+W2TQK1tIomF5A6wb8LfazQFra4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56025390-2e76-4711-f5e6-08dd81992e01
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 12:28:25.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZxoTHo4zGnWjpk6Mp9yxEUnG93Pk29KSNtjoKKAarHVjAbl7GGEhLSGRjX/bNdxdRDM6OZjdzDTswg9DZwY9jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_06,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504220094
X-Proofpoint-ORIG-GUID: YIWKS6jtb4bw4N7HeFUgr1_RsuPyffDL
X-Proofpoint-GUID: YIWKS6jtb4bw4N7HeFUgr1_RsuPyffDL

From: "Darrick J. Wong" <djwong@kernel.org>

In the transaction reservation code, hoist the logic that computes the
reservation needed to finish one log intent item into separate helper
functions.  These will be used in subsequent patches to estimate the
number of blocks that an online repair can commit to reaping in the same
transaction as the change committing the new data structure.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 165 ++++++++++++++++++++++++++-------
 fs/xfs/libxfs/xfs_trans_resv.h |  18 ++++
 2 files changed, 152 insertions(+), 31 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index 13d00c7166e1..580d00ae2857 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -263,6 +263,42 @@ xfs_rtalloc_block_count(
  * register overflow from temporaries in the calculations.
  */
 
+/*
+ * Finishing a data device refcount updates (t1):
+ *    the agfs of the ags containing the blocks: nr_ops * sector size
+ *    the refcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_reflink(mp))
+		return 0;
+
+	return xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Realtime refcount updates (t2);
+ *    the rt refcount inode
+ *    the rtrefcount btrees: nr_ops * 1 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_cui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr_ops)
+{
+	if (!xfs_has_rtreflink(mp))
+		return 0;
+
+	return xfs_calc_inode_res(mp, 1) +
+	       xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
+				     mp->m_sb.sb_blocksize);
+}
+
 /*
  * Compute the log reservation required to handle the refcount update
  * transaction.  Refcount updates are always done via deferred log items.
@@ -280,19 +316,10 @@ xfs_calc_refcountbt_reservation(
 	struct xfs_mount	*mp,
 	unsigned int		nr_ops)
 {
-	unsigned int		blksz = XFS_FSB_TO_B(mp, 1);
-	unsigned int		t1, t2 = 0;
+	unsigned int		t1, t2;
 
-	if (!xfs_has_reflink(mp))
-		return 0;
-
-	t1 = xfs_calc_buf_res(nr_ops, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_refcountbt_block_count(mp, nr_ops), blksz);
-
-	if (xfs_has_realtime(mp))
-		t2 = xfs_calc_inode_res(mp, 1) +
-		     xfs_calc_buf_res(xfs_rtrefcountbt_block_count(mp, nr_ops),
-				     blksz);
+	t1 = xfs_calc_finish_cui_reservation(mp, nr_ops);
+	t2 = xfs_calc_finish_rt_cui_reservation(mp, nr_ops);
 
 	return max(t1, t2);
 }
@@ -379,6 +406,96 @@ xfs_calc_write_reservation_minlogsize(
 	return xfs_calc_write_reservation(mp, true);
 }
 
+/*
+ * Finishing an EFI can free the blocks and bmap blocks (t2):
+ *    the agf for each of the ags: nr * sector size
+ *    the agfl for each of the ags: nr * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    worst case split in allocation btrees per extent assuming nr extents:
+ *		nr exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Or, if it's a realtime file (t3):
+ *    the agf for each of the ags: 2 * sector size
+ *    the agfl for each of the ags: 2 * sector size
+ *    the super block to reflect the freed blocks: sector size
+ *    the realtime bitmap:
+ *		2 exts * ((XFS_BMBT_MAX_EXTLEN / rtextsize) / NBBY) bytes
+ *    the realtime summary: 2 exts * 1 block
+ *    worst case split in allocation btrees per extent assuming 2 extents:
+ *		2 exts * 2 trees * (2 * max depth - 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_rt_efi_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_realtime(mp))
+		return 0;
+
+	return xfs_calc_buf_res((2 * nr) + 1, mp->m_sb.sb_sectsize) +
+	       xfs_calc_buf_res(xfs_rtalloc_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize) +
+	       xfs_calc_buf_res(xfs_allocfree_block_count(mp, nr),
+			       mp->m_sb.sb_blocksize);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rmapbt(mp))
+		return 0;
+	return xfs_calc_finish_efi_reservation(mp, nr);
+}
+
+/*
+ * Finishing an RUI is the same as an EFI.  We can split the rmap btree twice
+ * on each end of the record, and that can cause the AGFL to be refilled or
+ * emptied out.
+ */
+inline unsigned int
+xfs_calc_finish_rt_rui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	if (!xfs_has_rtrmapbt(mp))
+		return 0;
+	return xfs_calc_finish_rt_efi_reservation(mp, nr);
+}
+
+/*
+ * In finishing a BUI, we can modify:
+ *    the inode being truncated: inode size
+ *    dquots
+ *    the inode's bmap btree: (max depth + 1) * block size
+ */
+inline unsigned int
+xfs_calc_finish_bui_reservation(
+	struct xfs_mount	*mp,
+	unsigned int		nr)
+{
+	return xfs_calc_inode_res(mp, 1) + XFS_DQUOT_LOGRES +
+	       xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1,
+			       mp->m_sb.sb_blocksize);
+}
+
 /*
  * In truncating a file we free up to two extents at once.  We can modify (t1):
  *    the inode being truncated: inode size
@@ -411,16 +528,8 @@ xfs_calc_itruncate_reservation(
 	t1 = xfs_calc_inode_res(mp, 1) +
 	     xfs_calc_buf_res(XFS_BM_MAXLEVELS(mp, XFS_DATA_FORK) + 1, blksz);
 
-	t2 = xfs_calc_buf_res(9, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 4), blksz);
-
-	if (xfs_has_realtime(mp)) {
-		t3 = xfs_calc_buf_res(5, mp->m_sb.sb_sectsize) +
-		     xfs_calc_buf_res(xfs_rtalloc_block_count(mp, 2), blksz) +
-		     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2), blksz);
-	} else {
-		t3 = 0;
-	}
+	t2 = xfs_calc_finish_efi_reservation(mp, 4);
+	t3 = xfs_calc_finish_rt_efi_reservation(mp, 2);
 
 	/*
 	 * In the early days of reflink, we included enough reservation to log
@@ -501,9 +610,7 @@ xfs_calc_rename_reservation(
 	     xfs_calc_buf_res(2 * XFS_DIROP_LOG_COUNT(mp),
 			XFS_FSB_TO_B(mp, 1));
 
-	t2 = xfs_calc_buf_res(7, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 3),
-			XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 3);
 
 	if (xfs_has_parent(mp)) {
 		unsigned int	rename_overhead, exchange_overhead;
@@ -611,9 +718,7 @@ xfs_calc_link_reservation(
 	overhead += xfs_calc_iunlink_remove_reservation(mp);
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(3, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 1),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 1);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrsetm.tr_logres;
@@ -676,9 +781,7 @@ xfs_calc_remove_reservation(
 
 	t1 = xfs_calc_inode_res(mp, 2) +
 	     xfs_calc_buf_res(XFS_DIROP_LOG_COUNT(mp), XFS_FSB_TO_B(mp, 1));
-	t2 = xfs_calc_buf_res(4, mp->m_sb.sb_sectsize) +
-	     xfs_calc_buf_res(xfs_allocfree_block_count(mp, 2),
-			      XFS_FSB_TO_B(mp, 1));
+	t2 = xfs_calc_finish_efi_reservation(mp, 2);
 
 	if (xfs_has_parent(mp)) {
 		t3 = resp->tr_attrrm.tr_logres;
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 0554b9d775d2..d9d0032cbbc5 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -98,6 +98,24 @@ struct xfs_trans_resv {
 void xfs_trans_resv_calc(struct xfs_mount *mp, struct xfs_trans_resv *resp);
 uint xfs_allocfree_block_count(struct xfs_mount *mp, uint num_ops);
 
+unsigned int xfs_calc_finish_bui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_efi_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_rui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
+unsigned int xfs_calc_finish_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+unsigned int xfs_calc_finish_rt_cui_reservation(struct xfs_mount *mp,
+		unsigned int nr_ops);
+
 unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
-- 
2.31.1


