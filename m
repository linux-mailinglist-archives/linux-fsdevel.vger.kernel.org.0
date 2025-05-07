Return-Path: <linux-fsdevel+bounces-48345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE299AADCDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 13:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50985461921
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504E921A436;
	Wed,  7 May 2025 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZvhRGheV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C9EwmNVs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06650215F49;
	Wed,  7 May 2025 11:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746615883; cv=fail; b=JMcwVaREoA85HgyfuTW3AHspHDLQmFjqgF0L5JgydSa9Wo2Y01ESUOjAAoKc9vAjNiBIUHWTV1B4Kw5G7eQTfr0e+uWxqmUMcv5w+LT1xSWlD2H36JOeD7du8bcfdZnonLNY1n8Fdxhd+hvKJPxx76JULpYZuRERgisI0gzKZkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746615883; c=relaxed/simple;
	bh=K9T/wVVLV8cNRXHBSr/FaW5aLK5Geea7NU3v8/pRCio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sZs0flL5OGMHeFVXKLunWfbX4QvC+5x6F+7A67jG/Mq/1y3Ejq5BQ+Lr96+I14gPQSz2dEBxFRgIE8gChJBU7heOFm36kJOaJbFt9M7oo2Mbfpf9Ym2zsvf8FmN5qqILNw8hmy0wyYXDBAPqS54TKw9nwBt8S54GaH+ewkabxRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZvhRGheV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C9EwmNVs; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547A77UV016464;
	Wed, 7 May 2025 11:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rahkyNLXBWHQwG9Mnt5zLDF/RjGw1PYJNiw9Os1ziUE=; b=
	ZvhRGheVmvoBF0kayaqf+/9t4LMjLoqUCd/m45ZI/jq2/84FsGrusxA1d8RVPrFn
	FbdDF0cYYbdKR0wzpZVUPfVU+fkwO9hv+mAPy2afU1HB2jG7esX3kDjAVKxV7EZW
	BZqIMcslOgQ739fqlQ6wMERlELmdp1GbjeQs32GFrYH/XTYzDnnlxI4E+gnUpgVn
	wxvfiJhhoACnmwLFxAwcmPs2KS3Obx0g7SzC93Dp7vqKuT9UQk/2/1m6AilD4npm
	Y4NzhTOcxPtJFpACgeKNfNSOZuzeV2VuYKKCa+q2rRT914WEoClM3wClkUgGybzD
	oNF7K1FND9JvakhP4Uagsw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46g5fy03wd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547AAeAQ035527;
	Wed, 7 May 2025 11:04:13 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010005.outbound.protection.outlook.com [40.93.13.5])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kggjqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 11:04:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vfIFcwO/uzC1dWLdm+3IyI7ay4RjM9rYmZQAKzNCjST6s2JAMX4shqcPPr9/Vi3w4JuGrBJR1R0vZ6Tc1mw302mX7YID8WEcvXOl4oE2jF1aHfxTyeqxVvJMD+MIJCMVFK/6ooBfGlOgTb+yCw7TUimKYB/lnvRGfyV+rNLv02edbhuf6FY6YABMa1QchiOH6bE9pank1+Om/grB5hANCi0JU0zmWaFyO1E5sEz7Ba8SfuBXE02JcGg4fd0V0j7stiZP6x9KUOzu9uwwKWeMlLjjpfxh+jFSBfdhuvgSWT5ee027IcIpZQj9qY66TOW3pYrrNHcI2mW30hQ5Ngba/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rahkyNLXBWHQwG9Mnt5zLDF/RjGw1PYJNiw9Os1ziUE=;
 b=YXPxeTv+4GwPNYwmcRzHfPCH+m3X3r5+q2v5+cfM6vqTrMQOlxiHivUzX75lPJkZdKJm18GX2BO3R+2G04WU90Pvg3Pv4JtEjq72/7eD2N5WsNKMPKKm5XHLyQtR2B1aA7BVhDwRjLKZq8PGWwWQvpzJGwIPg/MMJnQTUbkjTM75Kc3MJN6ckQmucunJiUFOLsv+4E/+t5o/tNkYxOKzTp903husJtwn/EmadVKlS3GQ2EZTe4SDlUu8ZpY6Dt2Ern7/rHfiuxGIn2n1ax+GLmohBaVhp6t30cv27vz//UcmAJ6TMnY/0wKZA5jH5ILwIhUXIw/wnOsp3fZUQX/42g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rahkyNLXBWHQwG9Mnt5zLDF/RjGw1PYJNiw9Os1ziUE=;
 b=C9EwmNVsEUBLzyJ3ZvoPDtXRQlFIq7M89wGRZUkCf5qJpGC6xsT+6XzWi8lerdsKT9GVpsd/w43sez7sj0cDyprvt1RxkiLiZCeOeaHI71va+2pyNtOexW0btjXpBBVqbuxOZ26/i2P0tNSvKcsY/4vIDSutKZAESGr8fB9O2Uc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 11:04:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Wed, 7 May 2025
 11:04:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 3/3] mm/vma: remove mmap() retry merge
Date: Wed,  7 May 2025 12:03:36 +0100
Message-ID: <e18be1070e9fcd7a43cd72ac45f19cf1080e73b5.1746615512.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
References: <cover.1746615512.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0070.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::34) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: fe4fa9be-bab8-4cb8-0da8-08dd8d56e164
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8ksNl/uiMCxykmdN5m4Kf/+1s3RclTsJ/5/r9Tc6640eXlTcCVf1YZVDicn?=
 =?us-ascii?Q?Uxw+jx8fSdEQj4E0sA3jg1z56YoOpJe4zGxawMI2s8KogFAVcvV3LjvyV4HW?=
 =?us-ascii?Q?2Hw4y3v0v5TpCjSzZtBx55HGmnmgFnf+pHX0e79mYuqJfyL2T3TUi1FrBkCd?=
 =?us-ascii?Q?uOajuX+F/YnyEmy1sAWTG40snuhuPHuVe0ecegouZSpxueo8z7FIog/epgLN?=
 =?us-ascii?Q?9L22ORHTQzhgRu3RAeBS/ORezaCAMzYY8vMACOmZZ+uGhSxR8c8ZoSfQtmT9?=
 =?us-ascii?Q?T2B6GiG5FzKFYHXiCaTjFy9Se1NSCgLvEJssCgCn7+D5os70FDAeJz1/lR1N?=
 =?us-ascii?Q?r5eb0wid0+dwJcOZ+E2c5YkZAjMiGRhH9JSx+0fVLpfbJn48ZTtMRU+wC1uP?=
 =?us-ascii?Q?vGKWyEo/bggIde0N15CzrmNdtiJhhp983pBEMl/BxbBXnWc0bgNeRUJ7Vole?=
 =?us-ascii?Q?LwpyeT5JaRCXelEdpR0ih9T2aSEeYhSuNnNayQ9DyFbx9jisFWPwJk4Lyl1o?=
 =?us-ascii?Q?vJ0HXvEy/c2JY0u88Bnb6lzgyE1mp5/VXlUs6lWamiYBmhK0HZEmpIENq/SR?=
 =?us-ascii?Q?/wSYPGIBLws65UFaWL8o+BnaNwY27GtHp0g+TZFAIf0PPVK2CSeFeZ35dx5g?=
 =?us-ascii?Q?5kmLeNjFzM26J5aKzcGPyETtFI27RV6aX2MdVFHHaCEFUKM3LGv+5ifZOL13?=
 =?us-ascii?Q?8ZwOtFYD5BcpMxrWqpuCCsfjdYDaqrNjNE0eAOZnpWUoA4oQORuE8QxaKMg3?=
 =?us-ascii?Q?siYCPQZeqXg57Rey5uyJq3KnXy+9zVQsRzfv+4bpyCG8jSGqbYmMIYPvCXbr?=
 =?us-ascii?Q?y5/6GkTk82QrZnll+SC6DP9Wvnrq40YG/3PPUM2j8Wqbv5K1JzPxp/aOtQpB?=
 =?us-ascii?Q?rXhfECwQM0k3EcN/g69peSgwNzwwAuTiEfyPwIeoemIQksUk3Bjkago2nROJ?=
 =?us-ascii?Q?Qq0GWkYHFVNYMj1AAWjBxUHI4KQtA4TTkDiZq9A3Lphml0iVHJO+QqMGL4KW?=
 =?us-ascii?Q?1BhCMPnbZsxYHPFdGQ8k2kriHvWklOq4Vo5Qm/lre9JzUlWLkLY66dPwzrrm?=
 =?us-ascii?Q?lQOB2eosdUsHX/C9Ajj0M/pgNeejQEaLk3Egr7B6qAcPzxHUdYELOTVjGlDy?=
 =?us-ascii?Q?fXdYsZI+HE6uHCwlCx3CvZQOpiRSNLZgcRXZaiDdtMnW3a3vDY6hsY+MBUTZ?=
 =?us-ascii?Q?nBkCCNqjoyTfXKFWe0CKicPLXRW2UKSL0Sxp+PDWStRBRR61HYBVuj6wAOza?=
 =?us-ascii?Q?fWXbm9cy3yjvMnAM8tNFPrt4Xw+2vKoSeeQBD9pZrhMHAJxcdhdxX2Ia7LiE?=
 =?us-ascii?Q?VVghMVYDM8ywk1DRmwMftcTDT5JdjdCS+ik/gYthcI5f+ncws9i1DZYyVA5L?=
 =?us-ascii?Q?x79LFgooUK/MdxiORlHXVYoOpGdH6QzyNYozxTBYKKWYqFimDyKBTCE9YFbs?=
 =?us-ascii?Q?O1nPJfwvF3k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y//GAES3/vj4yrSVSybjOKPo5D16AD0m58AeVdyXJ3BYhXrRIFuZAAwuX1ZH?=
 =?us-ascii?Q?SfI9NbQYokfesTJJXhV56VefsZ9FbpdMa13LyAfp7q6/Nu8NQXgzKQzilIwL?=
 =?us-ascii?Q?JB/VsWPx3uoZvcC6yge4s/uQgqoVgXSMikJr5xiDBYnQTGBn2tYebzgxwhmo?=
 =?us-ascii?Q?RXq7xk17GTsfwA0M4rVbqzsEbg7VlSvMDx/LU5trTmySH8e5rL1q+Lw6QaSZ?=
 =?us-ascii?Q?qorek8/T9VD36Sycvk19EjImPdrV9IVcT5tNQgbj3lcFZg5Zb2qq7UvAx2ov?=
 =?us-ascii?Q?Bl0yMedan7PDa8NSOfs75HSssnJBq0lfyWVZFvmXWhAcy1/UrXMGwYN9syQt?=
 =?us-ascii?Q?W4mRAKvRtTpZ/aCRP2RR9bPK5glrzvF11EwDZN1VARQvxphqkF8r00hqWfwn?=
 =?us-ascii?Q?LtDoDTQQba2dkMp0mH/bJmsIxn5T8isCtJPndSH6V8SPWM0v9Ko//HCCnhKW?=
 =?us-ascii?Q?KxmjsT4Xs7JvlHCFCe1cmuBsGLSo0oo2d/uPvwV7zqVThSMLi42ObfThQJtS?=
 =?us-ascii?Q?z8c+UfV7qH8w/Kkfl8tWlI057B/DLrPVAGJk2juTd/g+W1XKgDRalCt2/qVP?=
 =?us-ascii?Q?QYRcMQtYzMefjCnspcJ7YhjXVkHzCpEOGcXm5zF+sfDye8IlUBy+B9HP07/U?=
 =?us-ascii?Q?2xF3QdOfkoX2I2qI/L2t/cvTyWWcOrOPVs3Id4hsI3187yz3CC7yhwj+A56c?=
 =?us-ascii?Q?EQYkl5FHOKz19/HBujI/h2F4QaFgBEQESKbUs5ARk555v/uWiNYXLsRiIVxw?=
 =?us-ascii?Q?yXnrwbJ03JXDHcjupHIo844S46D8PcNyuTgS+Lm5SetwUtkyFhjL7aMNWFwp?=
 =?us-ascii?Q?i5uNTRRh/YCCQltjbStZF9j47kq3Vzg2rDTpJp0mDgTorW7XhF0jWlL0mXe2?=
 =?us-ascii?Q?BveMj1S6t0rGgFyPdTjjbJeZPMsBwkJB0OuQ4MZBnTuTXNeMQNGwU6PWOC3x?=
 =?us-ascii?Q?VrpyrTTww0D4o5rR0CwDORLZXB51TaCp+Vu/CYWJmeRwEQC3UgD4FjDQs26B?=
 =?us-ascii?Q?2UAmvN+UvNkBCCFYQXmyQsmhgR4mx1W1s0SJsRePagrDA/kWk8XnqLf+Eb6M?=
 =?us-ascii?Q?npqqTEPWi/sTFI/PDxMgye4JgjUH4xw6960p8EMa0dT0gNz9IGX9KJ/BrYRT?=
 =?us-ascii?Q?LINlQlLGn9kPpwZ6PXWSsRLbPYfXnexQ86LxBUaJNFQ7MrokcIUYeWtwwaUK?=
 =?us-ascii?Q?XOzA9OM+uMQJjw7kmMCcZGzf3sVTbHPpG0BPbNiP4L9G2M7wX66sYLq6i4wj?=
 =?us-ascii?Q?n6Dlc3O6/L/MU8fD4FOkrXDmJ0yTM7pFaCROc/+YKLIYDrSE67nFgdnrubPK?=
 =?us-ascii?Q?I1F8wjVN1PUz9B/WUqwckY/+SqEUG49zOda2UDn60TNd7pz9dbHm631XZ5qT?=
 =?us-ascii?Q?OStJKp9VRA17wE2pEOjMLUZLG/78QcGh2rSFp3gm6+mTySD+RE5RqBTyB9/9?=
 =?us-ascii?Q?NLBPxbhEbGzjKKMjec5rOcRk0OFXKHO5D2LAihWckcf59tx6TY+s0FPiZRsy?=
 =?us-ascii?Q?+oMorAm8JXi88m1M1f2odB3+Wsm/sHh5CTaDw1cut2eQFvc/f0v35LZ8weUx?=
 =?us-ascii?Q?iyW+a5OnQuX6Y7DCHOVOlfrTOKimPPCI+MfzOJqSOudfsTG0BdiJlUoF8/HX?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T2vyZDofi/3QN1wrLxTtNN4vAx22zkLYIWh2V0Ccweyrvw85bWtB0f95TMbgcMB/q8vtXUhkoB90xHMoNIrK4dUhBBYAFnYKetso0ZBLA7Xt18myFeddh13O2fYpdSu8sQH4QZsYjytHImYYu0rgwSJDZ2ZmyeTULcZ7umvH5qpalUJghYKDL9GRia2o3JRrw5ZkXauHpYpfP2uwBaE9TwqA1vWqTx5MPaz7guP3r59JWCIs/UUqFzijPkosZFlO/Ub3cGiYwQMxKRPH9kpy+XuAcHv7Jvah3C9Jpsr+utZ1AfpgljiLRrOV5S0Yh02MjJurDmu33zk9zpN62e3xlKBuZqs7U9ycR3YF7c3ymWAU/LoFOV0hrwVnsU+gQVWWRBQC20L2ZLRHEARH8S2L7gVaK7y8bQHPxGW3kwtCC3i4Haqe3pUKZPP3KLmjOCMMa5M9HBzXfv6A1vdPoJOvT9hkgVhMgnC2oF/RRhEKnetQuOIoxS7oFVogqmMoLW9hCe7nWrEhFEWOrlKU8JCh0dvY3FZFOgzR0XSxMQpS5xOqBppqvuzNbcvktvc3IvpvNIomaauM7r1C9pc9xPGSWULTkKrZmo+NAT8cn00whFo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe4fa9be-bab8-4cb8-0da8-08dd8d56e164
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 11:04:04.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tA1X+jK5NmclsrWORlkC7ZnxvypuB4M+FOkYJIs9RkQUOA6rXH7xZQqm5zpLa82oO+euvwj9RtFW9357bZJTfXAc1cGFeBjlFjpErbpjGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_03,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDEwMyBTYWx0ZWRfX0xYCRm9/xduC GA8vkQ60zd04o0vDyh0fQwB2UaoQCBU+erfUhvkP9XpNBBuErjLiRqJ+7A02FS8jNy43Byhl6C9 yqPm++nBOy+E7blyL0h72FYfXh2TIF0TM+CrAEXXejTH0UGbeZgQW2QtXkCwB9W67XUrl4ZkK2V
 AWGZ4ReLBZM6RuFBboRbRmOeZeOYU1TK78M4uS2gZEt8mr85Vbyo4EtxdoSAvGTbrVocFs5ZsqM e8MxwCmJeyL5Cb84Ikp45m5/O8El8LNidl7O6ztueUsDJfBSzKUpqAE1J/+qYoXUOQO6GOCGHwl YcFwMNzflpJIdTMiaK3pSKe9KWbqQFEqEkx8dPZcwe0iGx8yhlXNi6P/wpnp9t59TiByq0q88Rm
 d0+Z6pnxj8bPdfhMWi6DKt1D6ChwKDz7B5TRj0hkNsneWm/gMBOWf8uN9xzsCLdxvXRWwJ6m
X-Proofpoint-GUID: oQfAsyE6enlIFKKNNexIq_YdLhdE1ulP
X-Proofpoint-ORIG-GUID: oQfAsyE6enlIFKKNNexIq_YdLhdE1ulP
X-Authority-Analysis: v=2.4 cv=BOGzrEQG c=1 sm=1 tr=0 ts=681b3e30 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KWrF3PiNL9PbMbJVJAMA:9 cc=ntf awl=host:13186

We have now introduced a mechanism that obviates the need for a reattempted
merge via the mmap_prepare() file hook, so eliminate this functionality
altogether.

The retry merge logic has been the cause of a great deal of complexity in
the past and required a great deal of careful manoeuvring of code to ensure
its continued and correct functionality.

It has also recently been involved in an issue surrounding maple tree
state, which again points to its problematic nature.

We make it much easier to reason about mmap() logic by eliminating this and
simply writing a VMA once. This also opens the doors to future optimisation
and improvement in the mmap() logic.

For any device or file system which encounters unwanted VMA fragmentation
as a result of this change (that is, having not implemented .mmap_prepare
hooks), the issue is easily resolvable by doing so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/vma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index acd5b98fe087..95696eb44365 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -24,7 +24,6 @@ struct mmap_state {
 	void *vm_private_data;
 
 	unsigned long charged;
-	bool retry_merge;
 
 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2417,8 +2416,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	/* If the flags change (and are mergeable), let's retry later. */
-	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 	map->flags = vma->vm_flags;
 
 	return 0;
@@ -2624,17 +2621,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (have_mmap_prepare)
 		set_vma_user_defined_fields(vma, &map);
 
-	/* If flags changed, we might be able to merge, so try again. */
-	if (map.retry_merge) {
-		struct vm_area_struct *merged;
-		VMG_MMAP_STATE(vmg, &map, vma);
-
-		vma_iter_config(map.vmi, map.addr, map.end);
-		merged = vma_merge_existing_range(&vmg);
-		if (merged)
-			vma = merged;
-	}
-
 	__mmap_complete(&map, vma);
 
 	return addr;
-- 
2.49.0


