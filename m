Return-Path: <linux-fsdevel+bounces-47382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF8A9CE85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEA217B090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E5B1D88AC;
	Fri, 25 Apr 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CO3Xj+ll";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VCpywsK9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE671A840D;
	Fri, 25 Apr 2025 16:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599556; cv=fail; b=rsPwpiFHNbk09TeRWEzxurnPZp0A0GJTppTDH0OGiAuY2K2gIfkkUXbCe3qxFzyVdBejl2thGGNUe9xH4J4DPpGT0IDdm/EvWxNX025Ed4GFjRmXhvS7a4AiYaWShKJsZuZ2A0qNsS+Iiq43Qak13OqWKeJ4io7p8AItaB6aFGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599556; c=relaxed/simple;
	bh=5XMlvNh4Hk2dlAi3SvzQr5+8QV3/mqtmbd02tFFzEAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eAgKjxi9Q/lyaxFCD7ztJ3ichO//PT2G/Uja6G4F8JW55nxVDUIhV7hvS44+LaaMtpn5/YlcMYb+d9BJcpHKpDc551ThkjLzhez+mj7e4UbrfifsTyVnShbATIsteswKGrJWBFrLwARO+thTE5woS4RyaBPOLNNuxPz6mhxfK7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CO3Xj+ll; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VCpywsK9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PF6iQ4030340;
	Fri, 25 Apr 2025 16:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=uA2V9zhnoq8+pJN7Gz2u+6wWV1fHtHVRuujJcRqNXV4=; b=
	CO3Xj+ll2+FJPZRL0ZRGvsSFKXwNysEgDqwvRpxYgdtgYOS8DDfO1fY+UxCmFZKs
	SJU063aBa7zjdBmuqD/Vyo7c+Re6SGMl29hVI1oQvl4adNf5GxTcmkqc0KchXYAe
	1qfyBteVVcrtyPu3aKqSDz8SWPq2YS4X21IOwmsyg773+ClGE1FCe8LPw8I+/5yl
	fKIg5z0UA1jTgLDwhTnmY4g4g63AMDdoMseSLttt2bj6xSWyHPVAP5o9H7AK8Y66
	qFBT75QONockE/uo3jIEsHVmcsksiTWxS8Hexum9GtOLI8DcIzWw6wYw8yKWeIAc
	7H+FI/HBggw97WtDVomoFA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468cr60eav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PGhgwv031173;
	Fri, 25 Apr 2025 16:45:42 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08vew7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ocmV/2p5Sqj/FyBCoy/U4wzIQ9WEKmGk0dOMi8FjjDMkmQa60xe3L5jV8iKscZb3kt9vyAvevX4eo72l7zShGEIWqLXk/cdYyto5JycDVrhBWqcHmfB6IdaDfkS1Wx8KUNVCYGDFr2tBDY0x+u4tyk+sKChDOqzWRhZ+O8/buj9tXdn9E0t8mJzU31OkpmqcpWWUlove44pBLHtVVOpcyZPkSqgbOvgKUfEz9y8K+dQyihvO1uyes7eXvoUqkKf8OVWSMY+pGb+8WDGmFWz15zApX/UsfGL9ASKgvh91GS1OqTVoO63QjVahGSRwPxFQe8qGHZoj0yCCLVJk4MEMdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uA2V9zhnoq8+pJN7Gz2u+6wWV1fHtHVRuujJcRqNXV4=;
 b=ynouwn7N56KuB5pGT+oSb+pLzDtBdt9mGIAN2QbV/apCJtMd0MLQw86hwBDk7q8at46CGCM5120jj8CAr9CCh0P/4dWvzI0BgoAWfozCzWv8pISVvLjD4sHiwP1djNhKchFXGxKUKCQpze5RvkLbE/YJE+LgQJXm/cGx0rtXPP6uLHY6y/prCwA5PDfiU3/xu+asgQWV5h86qbkVbCjFUFW0I6Q5rBXcvOzlWpRWOHPbxAs6t/6sImhXMkDhDZEtAAhvvsuWJhoKR7UABAQp+TdnTc0GVPpIYKAjCQ8OIzudR7lqkpIQPWMZ6cL9QNIyXJdqdnb2B0cRZMEYzljZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA2V9zhnoq8+pJN7Gz2u+6wWV1fHtHVRuujJcRqNXV4=;
 b=VCpywsK9tLoZ8396lxIEkF9mKtwJDpWax9m2QefuY61qyTEJusDgvaQSiFdhOnwFu2UoXK9/bsRvQQxEEZ1qZft75keUZnSf4P/DVvQXJ8inhvBLZly4IgjJI1v8WXrzqAcYr5lqT0f8jMEh6+uACntk6DyXom82nDEh3/wmVWc=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:39 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 05/15] xfs: ignore HW which cannot atomic write a single block
Date: Fri, 25 Apr 2025 16:44:54 +0000
Message-Id: <20250425164504.3263637-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0206.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 624b4838-83ac-40a1-207d-08dd84189c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b8MUNYWXkhC4pGe/nsVFQ7G+y+EWHnu00qSgCDKn4lr9RiDNIS5e3fSQ22s6?=
 =?us-ascii?Q?uTQzA22vQzUhjOYqdwgz3FsYsgKAEj8/2tM3bslhLEgrKLT38L3GZv6BOs5q?=
 =?us-ascii?Q?t7v/nJXn4HoHhTCBCuYm5I8BCx2HZtbsGihObZE903YWhW4YttRZ7m3w0fEd?=
 =?us-ascii?Q?DxzGNK6xiNGwVKBm/cwPg9NIsHoodP41xS5N34D8WKq2n4kCmQDfCLwmC1Da?=
 =?us-ascii?Q?IevSLVid5h/pfdjsogJxSiK3bJjHX3vMsHFWeHRawSoa5P6zitlP/p1vHVxo?=
 =?us-ascii?Q?zBUmjP9PFrSOjjt6YmYLFQxOlMA3RJ210Vi8JscrITXeKNGpgjtbMK0p7FlE?=
 =?us-ascii?Q?j6vy4ZDCyHq4ngF1km9wLwPQtD/5FCZT1OHMQkP+1mz1znPHDEVKQfSoN0iR?=
 =?us-ascii?Q?QVIlm2Q5hPh6EJw1RpHbf4U5V4QSWTand8aUDX+N3soxyvgibIQrvk93K+No?=
 =?us-ascii?Q?fKoRUQNVqlo8gYQvjJmz6NsQBBdX6rSRLTYFipe+1fcyLir6vmS6AwAp2q9h?=
 =?us-ascii?Q?CbUWMq+8QF/SeXm11gNDNmruESrfZLWlyN37pFHojAeMl2Mo58BOrtYmAKNG?=
 =?us-ascii?Q?CziBnErDeZZ/cn//J2FaSnPoRTdqXfyO/wHuTrJBSpsw8b9+6aO/EHKUgoeJ?=
 =?us-ascii?Q?AuImgXFaB0cBr7PXIJFkfp9kWZuAhpfswLHBJjN15+VQXSxqbXuhzhX9DCcC?=
 =?us-ascii?Q?kVY0k/kVq9tLZL3mH762AYIqR69SINxbAveAUq4ZYIvCMJXYg2mzBG8ZBdXk?=
 =?us-ascii?Q?xbw78Vq5jHcMONFuKqb5s5cmt+T1yl6VAS1+/MbGNeLyaf4Nqgr9FjWcrqYQ?=
 =?us-ascii?Q?QKLWnog0gYDA+GjK6KVa0Rb0/LompZ+zA28FCd/DnY8oOFxwZh7MQyK5V5wY?=
 =?us-ascii?Q?1SpWGN7Y5L4PFEJ2QtYAu3vKZDT0mPgxpzRJLrAPjan+8Nw6/q9WqrgkydXt?=
 =?us-ascii?Q?8+PoPt9THdkeZbzgl1sKbL0J3niGcbPJODIwcChexsmT796PFQrxXgYAizuO?=
 =?us-ascii?Q?hmqFGcOxbD8guGshRyPZIw52ndJZQTsNejP/h1eJ9jIkAAJa+vI8u84S2hX3?=
 =?us-ascii?Q?ny7aE36Y04k2484TV/2pkaS8wThbrFl3tc7IVoQndDNOn8gV4m5p41PdwWVG?=
 =?us-ascii?Q?0isqkKrK8ApIGEO+0TY/kpaqs3pA0AMO9RXWj8rKwSBnxRlyhnqdGHWW+c81?=
 =?us-ascii?Q?C1T7kRB5ARnoMP4N/IeUoAG+kL185DkHSsuAJpY6EE9ZRPB5WODUOgid9eV6?=
 =?us-ascii?Q?pWt2OqGd6eOUMgZ5dupgH7f+ya3WOcRiUM30BC0TVE8DoZoGStTJuKWAelnK?=
 =?us-ascii?Q?z+3T7byw50sDQfBZHugAZqC/3dCj8HldMjFGTnr+g3+x+ffVx4eIJ8PhyHip?=
 =?us-ascii?Q?ltN2njOQLFHErDIKEcsjOOHBXaAQQBy+Fbcae7T/AnKzWG9n5oOKqVuUut57?=
 =?us-ascii?Q?7x7j2n6rbVQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pHcfX4n0cA6ZYlqL/wCOd/XFgg64xVeABjjpdC0mvxZtOdOsDKLJMIkh1TXG?=
 =?us-ascii?Q?NQ9nUDKACTVZtODRjcJyHNp49ythkrSzUvl4CLCmicOv57kkSWj5vg2KbkWC?=
 =?us-ascii?Q?LFX5flD72gTNmyXIqUhsDArHOSri79NTP6a7KWB3I4x7mrFwOxN7VNszY2Tq?=
 =?us-ascii?Q?xSixS30v7i1OYoSOJs3xvd0V0wjo48O4rbnogBUt5p0OZ2gsLx7kQNMBxyFv?=
 =?us-ascii?Q?HlBOO7VmnJMQxulb9pAbn4gQRmlPZ2KHpWSVKi81mUQwD/E4jUKRYmjXoO9/?=
 =?us-ascii?Q?1Ug9BhiVye9n38uaEXZhOr3q24MFnuJVLdMNWNR1Q1s7OzNAuwT/ivYZFUFz?=
 =?us-ascii?Q?a62863WoyT10HqSM1+K0mOumEr14269fN1BaSph+8EHK9tDyn36nxMMrmDxf?=
 =?us-ascii?Q?rDTFnjhh4TJXjxzqt4gC+DIQAq+7tqHe34+sA6Ota1Ox9Nnio/EA3MlXlycO?=
 =?us-ascii?Q?Ny49GZQ0axlqWD+73j5eqAEUxVGSh/caF9wtC4z8jZlhsP2ca9qqViAekI8R?=
 =?us-ascii?Q?HAhm9GprPS/IoPLSyvGO3JaYJ4oemKtcj9zTq/CdbCvR4Z3fMeB8QurZAOH1?=
 =?us-ascii?Q?P4CEY8UuaPFQgWebGv/IbrX2uXPZyld3AnfXJtgM+XMu/tfPWW8vpGkJ38By?=
 =?us-ascii?Q?5IqPO7Jenw64oDU8eG/I/CNd1/mAihgvrj6JWCqcUgFZGGl0pLLlwpJNj2/C?=
 =?us-ascii?Q?MZd2LIw99QHNyywdSdP4VXBRH3awUz9wFiCALpZFr+uILio26H5pztIIToZ3?=
 =?us-ascii?Q?+nclNveYacT8jJbR2lld1sp/1iBOMC8SKjKLtobTXdFBtwUzWlq2dInJfJE8?=
 =?us-ascii?Q?fczuYrlsErAsqykSd7JrUziOXsxPZXylu4/SHjTYcwzZr4ePvBatK1SPInl4?=
 =?us-ascii?Q?6enVpiaAmahN9Zn6V0GZdbmDEEGFg9PskfQ3GWkjTGEkoZZj5pF5BZyEsLDf?=
 =?us-ascii?Q?/ZAqTZCsMP9MmIPe/hp1TlwJ73MP56SFU/29CM7Zt0FuEINWXSEFQwMqQoQ5?=
 =?us-ascii?Q?SQbLCwb1PQ8XEdH2qDrRwQUfVQKdpNOY5FAfTOmpzBuL+CjWfUgBMY7vMnsO?=
 =?us-ascii?Q?jlPDYu+/I6iMuwNLTO+XGLvzUofO3iy01htOdLJRjOOjBTXLgMBfjBpagLAH?=
 =?us-ascii?Q?8grNT3r/wWkbd4VVtiR4WZ2loc/2Akr/q6MaJQIUkI0EqjFeubdPXrYZS1rd?=
 =?us-ascii?Q?QovNVkgLhH3S7QiUtS3MFVbRvzGDg4w7zaU6ZXkbKSDcNRWrTB+F2i2GY3yM?=
 =?us-ascii?Q?ujMwFp0i/s3ZZ7qvlwuDj+FSzv0Zy2GhRyGgBRgy/BXI5Nje7N2ALFX+d2X0?=
 =?us-ascii?Q?zJjpqdvigdr/xn87C/cNkQnJuOCEBEQ4noZ8+ik9pueor3Fh4pXxhdVAncFW?=
 =?us-ascii?Q?ys6m0vnIVUiKQ2Xm7CZo9+PbkUDN1HYQO7DA0wi/Ck4pBl9d4tUqMlWkQTfc?=
 =?us-ascii?Q?u06/vq3bgolVAV+kQbmnMQYgHjSkidPdNDgxpPpAi4M4iPirm3q50PxK93h0?=
 =?us-ascii?Q?4r/vYtqgeoPZcHURO0XfrJA+Gtcm2v58LdstWxo/mGrcXg/dI1e95GSGAKZV?=
 =?us-ascii?Q?5ZcCR2vX7uupoitlawlPHD1RitaTBQtSNRo8209J1nEY2hOLKICSzgRNIP9E?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uQCWAjuVJ50jlFur0Y8aXFL8yYeuXuWL0VF6HjorYJXdY3ukAGHZBpPUeVD+8nMKkmDAgWbOfGYgfeqZ8NPeSPz2LY+ZaTnbFIqALoVT5YjqyeSiKga8heaxU6gJpPtOYItj1lYf/5czgQ5kqukraApCehXLB99ItPljpnzQxMTd5t/BftkMWm+FVjAcG0wSnpNVb2xFuLFCVRUHx5UFMbedVjXxF3VQvlM7pGavp2pF9eVaWhLy0GQVSQcZ3l5sU0MPaOQhsm7zOQ4w9ndoC60st8bvZYKDXSyQOdRnYuYvN12/2ZMkX5UmLkEABIyApE2dLRM9jnl5w6cUH3gBZjgEk965AVmBYD06834+HHSycpTUwDT6gjrMlbnqc/ajcatzgyQPjHmrCerbMqWNhdVsoyai8cVN2fU6KxwLYQqt6iCp16LT/cfEjEIOk7b+voMHwKkrCuEteY77R2COhrtRCfDAPJ3esYm/hEdDrPO2So/AX1m+4t3EQXn5d/R2puP674dawOhpY05QraFfcEYsZ3ZQFonMdQhvBrdgiQrCpKnJEUU2MmpUtNP5pKxZG56t4l3YE46+swSs7//+r38BMXrhWb93nd+xkFNj/d8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b4838-83ac-40a1-207d-08dd84189c65
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:39.6541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: STtKkCxrPzMcJxFWLSoHegEqwCqT0iaanYCDBTfkXB8M5t43BgZymoNqnOtRegJc8tJO6T2uk/s2y9REBrznBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250118
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXxmCa8K7DB4vL L95j67DnO8x8FTUE/X5vmovqkUXYggs+ZSgXZq7X2FIwBWyn4fBye0YzVMq8ajY3akbXYbbrzSl tNc7aFFlMQoxAa4cER/+3O1ac6ajTVQVdjpt5M1XOZHBZvFS7OwVTTlty8dt24x9Bj+04b8cNxy
 PGiSS7kweUHXntNkdOrRYZQYSM6Esoc5N3sUxFk02+TpUztmRVJnDCgnM5+535f1J6jG86mzivV gNC6253YleVVJ8z1ALkp7iSUiWaIip2z0ujt1uHr3luAEuaZhpsYFvC3/1q3Nt3eU6D/xkOcWov bJgq840mjdEv/8qZqbVSi7ofL3mQ8zKHa2wcTD6d+YtfcNlJhArRGTsWOSSJM3illfSFCPfwu7q EPVhf4Bh
X-Proofpoint-GUID: S8cKqEfXkaVv1eb5TvQ4jh2Qmg9Sz_Cx
X-Proofpoint-ORIG-GUID: S8cKqEfXkaVv1eb5TvQ4jh2Qmg9Sz_Cx

From: "Darrick J. Wong" <djwong@kernel.org>

Currently only HW which can write at least 1x block is supported.

For supporting atomic writes > 1x block, a CoW-based method will also be
used and this will not be resticted to using HW which can write >= 1x
block.

However for deciding if HW-based atomic writes can be used, we need to
start adding checks for write length < HW min, which complicates the
code.  Indeed, a statx field similar to unit_max_opt should also be
added for this minimum, which is undesirable.

HW which can only write > 1x blocks would be uncommon and quite weird,
so let's just not support it.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_buf.c   | 41 ++++++++++++++++++++++++++++++++++-------
 fs/xfs/xfs_buf.h   |  3 ++-
 fs/xfs/xfs_inode.h | 14 ++------------
 fs/xfs/xfs_mount.c |  7 +++++++
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 1a2b3f06fa71..f165446a082c 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1772,6 +1772,40 @@ xfs_init_buftarg(
 	return -ENOMEM;
 }
 
+/*
+ * Configure this buffer target for hardware-assisted atomic writes if the
+ * underlying block device supports is congruent with the filesystem geometry.
+ */
+void
+xfs_buftarg_config_atomic_writes(
+	struct xfs_buftarg	*btp)
+{
+	struct xfs_mount	*mp = btp->bt_mount;
+	unsigned int		min_bytes, max_bytes;
+
+	ASSERT(btp->bt_bdev != NULL);
+
+	if (!bdev_can_atomic_write(btp->bt_bdev))
+		return;
+
+	min_bytes = bdev_atomic_write_unit_min_bytes(btp->bt_bdev);
+	max_bytes = bdev_atomic_write_unit_max_bytes(btp->bt_bdev);
+
+	/*
+	 * Ignore atomic write geometry that is nonsense or doesn't even cover
+	 * a single fsblock.
+	 */
+	if (min_bytes > max_bytes ||
+	    min_bytes > mp->m_sb.sb_blocksize ||
+	    max_bytes < mp->m_sb.sb_blocksize) {
+		min_bytes = 0;
+		max_bytes = 0;
+	}
+
+	btp->bt_bdev_awu_min = min_bytes;
+	btp->bt_bdev_awu_max = max_bytes;
+}
+
 struct xfs_buftarg *
 xfs_alloc_buftarg(
 	struct xfs_mount	*mp,
@@ -1792,13 +1826,6 @@ xfs_alloc_buftarg(
 	btp->bt_daxdev = fs_dax_get_by_bdev(btp->bt_bdev, &btp->bt_dax_part_off,
 					    mp, ops);
 
-	if (bdev_can_atomic_write(btp->bt_bdev)) {
-		btp->bt_bdev_awu_min = bdev_atomic_write_unit_min_bytes(
-						btp->bt_bdev);
-		btp->bt_bdev_awu_max = bdev_atomic_write_unit_max_bytes(
-						btp->bt_bdev);
-	}
-
 	/*
 	 * When allocating the buftargs we have not yet read the super block and
 	 * thus don't know the file system sector size yet.
diff --git a/fs/xfs/xfs_buf.h b/fs/xfs/xfs_buf.h
index d0b065a9a9f0..6f691779887f 100644
--- a/fs/xfs/xfs_buf.h
+++ b/fs/xfs/xfs_buf.h
@@ -112,7 +112,7 @@ struct xfs_buftarg {
 	struct percpu_counter	bt_readahead_count;
 	struct ratelimit_state	bt_ioerror_rl;
 
-	/* Atomic write unit values */
+	/* Atomic write unit values, bytes */
 	unsigned int		bt_bdev_awu_min;
 	unsigned int		bt_bdev_awu_max;
 
@@ -375,6 +375,7 @@ extern void xfs_free_buftarg(struct xfs_buftarg *);
 extern void xfs_buftarg_wait(struct xfs_buftarg *);
 extern void xfs_buftarg_drain(struct xfs_buftarg *);
 extern int xfs_setsize_buftarg(struct xfs_buftarg *, unsigned int);
+void xfs_buftarg_config_atomic_writes(struct xfs_buftarg *btp);
 
 #define xfs_getsize_buftarg(buftarg)	block_size((buftarg)->bt_bdev)
 #define xfs_readonly_buftarg(buftarg)	bdev_read_only((buftarg)->bt_bdev)
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index bdbbff0d8d99..d7e2b902ef5c 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -356,19 +356,9 @@ static inline bool xfs_inode_has_bigrtalloc(const struct xfs_inode *ip)
 	(XFS_IS_REALTIME_INODE(ip) ? \
 		(ip)->i_mount->m_rtdev_targp : (ip)->i_mount->m_ddev_targp)
 
-static inline bool
-xfs_inode_can_hw_atomic_write(
-	struct xfs_inode	*ip)
+static inline bool xfs_inode_can_hw_atomic_write(const struct xfs_inode *ip)
 {
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
-
-	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
-		return false;
-	if (mp->m_sb.sb_blocksize > target->bt_bdev_awu_max)
-		return false;
-
-	return true;
+	return xfs_inode_buftarg(ip)->bt_bdev_awu_max > 0;
 }
 
 /*
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 00b53f479ece..1082b322e6d6 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -1082,6 +1082,13 @@ xfs_mountfs(
 		xfs_zone_gc_start(mp);
 	}
 
+	/* Configure hardware atomic write geometry */
+	xfs_buftarg_config_atomic_writes(mp->m_ddev_targp);
+	if (mp->m_logdev_targp && mp->m_logdev_targp != mp->m_ddev_targp)
+		xfs_buftarg_config_atomic_writes(mp->m_logdev_targp);
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp != mp->m_ddev_targp)
+		xfs_buftarg_config_atomic_writes(mp->m_rtdev_targp);
+
 	return 0;
 
  out_agresv:
-- 
2.31.1


