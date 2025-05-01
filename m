Return-Path: <linux-fsdevel+bounces-47842-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C4AA61CD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 19:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA261BC29EF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 17:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9232253EC;
	Thu,  1 May 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="affGjGA6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eyxi+WR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE36216392;
	Thu,  1 May 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118727; cv=fail; b=Ng/v20rz0q109ngfi6hr6ny+qQxFpfsuG7mLpHcfseM+UQPGJ+M36xMX90sU528Z2zz2y2Mc2fvICbUPuUOZ8XoH7x/ExdnT7DOOoni17P0dBKMv9y+ZHbHJDtioTFQyReg4JjqR9DZj233GxJwaqw85pxxiJosgy5sm3mFhzHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118727; c=relaxed/simple;
	bh=/3eHRBqXmpR6yq1epYunkIuXKCmECvtb4laXLCiZWd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OW/DujZH1dDrE1xKnGBDawWZXdi4BgtU9yrHegZQ7iNF7oLYxPPZwIT0n52Gb4vjDE3NDmA2HwznIiAOyJNcwYx6ENl/2lp99wqISduY1eouomf7JuZzonmDK0CsnLXozjIM7AactUaBd/V5wGv9DR9KQf2hDPMSDS3D8K/ZSzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=affGjGA6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eyxi+WR1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541GkTJo025336;
	Thu, 1 May 2025 16:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kuIG6thDLdvspmYKa5nJC+nv/4MZ8Ohf6Hauv447Apg=; b=
	affGjGA6dSMbXuSVVH8PC8n/Dz5aiYwjlnKK4iNRSJz8mHrMmae9FOzDmlABi3fr
	Rh7ebzJb39suahRHO21Kjm1ooq9lqT1tDt9xpsG8Ea6bqBRZNaZItrdHTwqHs+8M
	t1xPkP7vJMe1zC5cUKWuI0yVNyVHU02mfF152eR+mRFlG5HydLu2ev15kkkf8SLb
	RmA3EEw379GHP9cBKird58xdNO+cLbRYOviYIiO7aFSmru+1g/Ceu5FyViA1UOqP
	xuNOkQruBv9yx+dSHJo8wKxmqpKZRwL8M9ICNsZxA/oLNxDxwL6xEYOBU+4eJ8+y
	OuxbhmQAvXFcDqdbuOyDcg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukkfsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541FbSq6035440;
	Thu, 1 May 2025 16:58:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxchjk1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rd0yDlH3qHSMQo4+6fRtiwuJpDDKhWhWMLqRXkHHPNHpo1N3ZRVJ/+yAtSj7jzwth/VAiMH/T3d9xxJjXpPHrx5tTfT/tdsqqgoJ8dT2qOgHveirhfOiOhyg8uKkB9KR7FutLgsRjrO6M4xNe5+B+cpOpnYk7gY16JVbbRks+iQRKhRsyjVxt0PZGU2QwFzlKe1mRvwExTuwiuULiPx9pPnNF7ZZm0EArummuKmuXn+WKiM+AjNrHcOKc9YWYmwlx/cAbvoZ+GLIg3cmBs7WCIDRYsWcwAPZTLbXlmr7mZAO8hsYz+0xjmLtMIUJhIv5zJUX7A8BUYPWXAsQGRB4dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuIG6thDLdvspmYKa5nJC+nv/4MZ8Ohf6Hauv447Apg=;
 b=vWbVyicyhpUNpnPYSsa4cQH2a1uJSWTz7Qp0bIJdipgDNOFTSKpwGEUbo7fG8iJ3RvM1Do+sgdfLuMZL6DOMtXPIkGbgD2UjF5BHZ+s29F4Yu3ornatO8RQFrJue2Ua0L/WidYr8t7lMxnj3/HEmMRM9Aq35dQ0Ek7s/CJQ80YTFWnjGBqR4OvHaCord1snMaRyk2cZ6nr6SHwzLSYl8pliAw3h28Cr6v69qElVa4z37OA02+sXaglNj1BoWpQiODzmDzno/K765LWZnY34QeXPWE+Jxy8QCJgDKyKWEpAxWuKqnkoqI23t2Euq2iJTH6r+eXVa37MafpthdK/R1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuIG6thDLdvspmYKa5nJC+nv/4MZ8Ohf6Hauv447Apg=;
 b=eyxi+WR1TZDj7RWo8jSSKAUoyDZKYNbMy/yYyphXyZPBN+0i2e+HfFZjniUO9v1y3ApAsezewpwa8I6zqP6s9Xfy6n3UmE+jmExVP4+ruVu/wZOMNdtECtvZMGI1VW4WaSUtcEWWiij+xn2byjd/5x+DyVQIVNOEpWn8YP3yO5A=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 16:58:06 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:58:06 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 13/15] xfs: add xfs_calc_atomic_write_unit_max()
Date: Thu,  1 May 2025 16:57:31 +0000
Message-Id: <20250501165733.1025207-14-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:408:10c::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6290:EE_
X-MS-Office365-Filtering-Correlation-Id: d72bf7a7-fd85-4f37-af31-08dd88d15832
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dZJvoj45paq5EBUTlSouRWPtLApXxIfqFuC8v548eMDq6O38fEpm2JsRmYLz?=
 =?us-ascii?Q?+3gq3cx2ETewqwkPggTSUENW3SEiYcb6DCvf93PGJGeQFq34asMieG0p6mye?=
 =?us-ascii?Q?slcrwEG5uTAy28hbD1t2DrKPujhUW2r4xgPO+QS2KhUuFLxvkQcO4AEluXLD?=
 =?us-ascii?Q?VJMFbLqTQm4fcg6THiegZhZ1nrSaAHB0B2LfhTRwDclUn+5ng/lF3ORKHEuE?=
 =?us-ascii?Q?ePdiwnWE0u2A3DisubQ7KqFLi/KJsN/stJNdBJfbYx7kqgMO/lRGUG8htcCW?=
 =?us-ascii?Q?Bs4k4QYRUhIX1Z8C5nvPsnyRhh01VRIMLMjl00E77giHRRCgm+XicTCePDWu?=
 =?us-ascii?Q?5eReHxfpbGVp3dGSNQ+l7JNTnyg5f/YYo3kCQ8SLngSCftCZMWwDBxSWgV+2?=
 =?us-ascii?Q?FStnKGr0m28M/7K6QfFVSjVfHZI3GTwcvOff5cVWMSEhGKGfYHAHexSHQ+ym?=
 =?us-ascii?Q?dZ6WEWl3dKS6NMtKaMaXLVRnER0rx+HJSnpqb0o4kC0HQQWSkTJZzY+TWdE/?=
 =?us-ascii?Q?r3XOHGkw7jpkDuKwgs0HeeXdyrRQB0vEpT+bJaYJYGT1oTGq9FazDaaozlLL?=
 =?us-ascii?Q?115bGzTTnVxCfH7NwmAhAUlqfC17qeYWnqJObMYl2ATNkml5OjgPj9nCgQ+R?=
 =?us-ascii?Q?1sHwrxzKF/TBAh/rSulUh216mIvrAJWxSDvF1/MmWOMetHQBsWScRBCaWh5S?=
 =?us-ascii?Q?Vqs1syzk34NAAwruun1QdOEIcfVGOtkQ9e4/NECSJ4nskPu8+8Z7U3VjVBf3?=
 =?us-ascii?Q?iXtRdPnSNQAIpF9o7dogd15WODKmAK0SERO1Ja3xQDxU0ZPoEbJe1fVu+VRd?=
 =?us-ascii?Q?hZdFdHDwBC6JVMvM5NQb+GYCUvLk9vMXBIg07ve3zUMY3znn69hCR/sjGeXB?=
 =?us-ascii?Q?Ts4BZt70XXvpWA0tZYWDNjSbiWiXRDsrUVFnKUjD0wJ8Ww4j+oksGRqEu8OZ?=
 =?us-ascii?Q?G9Rr6uXI/yhSFFaCPBK4v8YH3RGQQWTqo7ztxeHvG/zv6LDVGxF3GQk/fNg6?=
 =?us-ascii?Q?gYCfNBeTNUw3t9lKWcrHsRcZS+OCN0K9H18MHbxD4fzPNr51v6qgbMZYwn+B?=
 =?us-ascii?Q?TOSPTTh7LxBX5wuN+bDnlFO50OptTPfEb6yiq7QtSqPtRjjZ13zLZ1JBSyx5?=
 =?us-ascii?Q?AWGUkimF5fOaFpzDGfGwlYYCv8xmYeXMUevMgX19GJNCS1JsctbDvg2vj9+R?=
 =?us-ascii?Q?VpoIhNbeaPgBoHdqCpl3ycjgvSKCDzUgWMRKYjICtUZ4LSJnNr2jsDwcEfns?=
 =?us-ascii?Q?fCXQr9viG15bMHWCumwecJD+7fnfqQmIxMYzDmyPMscNBifr7FxJEYR4dnAc?=
 =?us-ascii?Q?RLFkQNFr1vZ5AXOcIzN1yIjSQlYVjqJmRYiULArlFU60HkeYoRBEXaRPAEkW?=
 =?us-ascii?Q?HAyKgEGOFCF8ONqMKWkYdAsZMCShh4qLLtYAI/knWIvwPQ4pxZwWOEaS5a0p?=
 =?us-ascii?Q?Y2MQdGRPdvM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z85wsshMgA+/LmE8cCg8PbLZ2utiSdRvErDgc04u72bGT8o1nghoMOEPYL2+?=
 =?us-ascii?Q?OVdnTYhWclch7ODDs8zzvbYnxoG652obibX9WTa4LZt2iJF4W6WrVSU3CDcs?=
 =?us-ascii?Q?/KY3zNDDHgydGUqke+b97iClKvOlZ2RvKqqPEm5EGrYbgChINuwbNaCICkLx?=
 =?us-ascii?Q?Tw33t8bhOkGOfciEKa0LEhPCn9D1k9R7vbODPPt+aPTvzMVVcn8az47FDzZk?=
 =?us-ascii?Q?UECHEQTBxiahEldBzlV+ghPtn3Pvt/kBJ+64G+XVuzGriHdQ64d7hqIHpgsV?=
 =?us-ascii?Q?5jXE4Lfr/QCfixJosXRLRaiLqK6G7yEKxU9pNBpsLia6MMtVRSJer2EL9lcD?=
 =?us-ascii?Q?xNyZQcKbFEcSnxg4Myc+kXHQPWToQdUbZRSHiPYW0UJEO+AcVOdek/ubt6RS?=
 =?us-ascii?Q?OtuOE27HrZ6y1oKf8v+BAYI7RvvpXPhaWUzm6IMsWXxBQeupushAAupnQfIE?=
 =?us-ascii?Q?sy+A/MwbLldS3W85m7DkpH1XK4d1EKFkK/8+5ogDOL2Gs1+7P+m2r2gKJu0c?=
 =?us-ascii?Q?ZM4KBRlj+TJL8J9bDYRYnvinaC+7OlVcQBfUNLU1shT/43JTGwNRNSLQKmYb?=
 =?us-ascii?Q?409gZBFYJfdX6lOATtFgBQBkKBpZKM04C6ni1x+gxIf0p041f0+2200/LLOg?=
 =?us-ascii?Q?cxI9HW8CCTPc/GjBvQDjqkWBY61AQuMO17EirgSh2X5ztUNasbNsyiM5eLfQ?=
 =?us-ascii?Q?L+D15O3UnFQEqiut/8fXltLn5cS5JoG6t5M39x00fBE4tAF0qOSbd8iKKWra?=
 =?us-ascii?Q?KOCTcSEer7ta10LIuUri+pD075fq8kmqsAhBO68u7+T0bbuBXN4pVHOGcFGj?=
 =?us-ascii?Q?raZzVUONtaSalAWPEMd0l+k5S/KsjmidGXbQfoIJgRSKC9OMvtMtbi2pm0aW?=
 =?us-ascii?Q?CWl04zzpFS77JvB5Dk/1cw/3qDLL3C3wrzbSxhJagK/L7zWjlC88HKCP6Y0q?=
 =?us-ascii?Q?p1CENfIr8MGlCCUxyUnY3nKhckaoQNd7rIdfCfuDxSOiXXeeB8dHU8aEZ/DM?=
 =?us-ascii?Q?pWIvcG/ReUYRQQkm6d5F/4sS/y1TIx3GOwcJZ4uJc/RUViGfwOxrGVJ84g2a?=
 =?us-ascii?Q?8pGxbi7l2vHfuS5ia7sVGMjLX7T0qbVjf+prl8GlHXei21Q67x21TWiVzuI5?=
 =?us-ascii?Q?WAvkart7v4XZs95svaBuynruTZyTfYt042Z7PHb6NRpa2b+RxjfOqmUfDpAO?=
 =?us-ascii?Q?qBQux/L/Uhd+5GgvXzLdHKR4XFVcBwvZgGk0dYWbtKId2Rq1suOQRc90DrlC?=
 =?us-ascii?Q?TTch9iPOZMp5tx/joK04Xg3ydWseU8Ki3EEYdviqOV8wrD57E4ujv/w4JarK?=
 =?us-ascii?Q?I4lLVl+/YEerRcoIztS1m+Sh+r6hwDv82aOxpYeBjKIT35XZglvXx8TFiHOG?=
 =?us-ascii?Q?xW1C+T9x5UD6xJ7E3MC60UisYEgu8JhCRQWPs67Bux2q3eQE6ejJdAxpupkC?=
 =?us-ascii?Q?D50DrO+Ij6kSHt3z8Fp00j3RL093XX1/yS9oZ49pqKc0B1SJJWOSdOHDgAgn?=
 =?us-ascii?Q?tcvKLzYVyNuT2rlpoXIEcZ+I2X3DNKBY1oYdDyD/9GpYHb4hjpI8rKZbsB4a?=
 =?us-ascii?Q?4hNlIECRtP7hkAC1IZDh66QU5WO//VOhOhJD+BJjcqTprK4wbGqjxLEQ795T?=
 =?us-ascii?Q?Xg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tkLfXlaXP6uSXk7Gtz75WV+JbKQgmvPH7rbEITUVIX1N5QMD3q5CERe/MfDiEUaWznHEq+ui15Oha5USxMwKZGPBMGo8CsSP79dP84JoCiw1u1TKahzhUBc+fcV00UGJSz5RVIQ15ajInUFMim8eDXHalo2UypeocvMMxmG9UKpue6ClORiv01n75E+bdhkeTLjy1MVaXY3Nsza7PB36HrKQ+nvaSIfhJM+S/9MqXjdsg+PMH0cHFTxBO5Zl1rFITjE50woa3qK/dN7DEtQKVNWpKRh+OnPrAwY3yiEkuyS5YHIJW+DDevgf4ow/dvP5DDvZRAHTdZrAu6r1yra7ZOHWvTfzhgjwlJ9c9/dm2K/S4zHkNw7vtaaQD8y8zosNnvAw8A6M2UgtWTCFYeBe92xfY+JMZyJPHKkOUvnSX4s/6kPSSHBAXVd+oOLOjMbwarLfmSINCCiSNcdXfDXZ9HmAOguQtj/Wadxc0Q/pDkJjnPHzEWUMV1Hs5VER+5VkIBmT7ZYRw4vruwaLr2qATE2Vs4ftFeW7ChXKr/CMmSn3N4o2hywN67DV2ZUoE9H5O/trdhYJxbxGVBHmPaQ3AauG6NARmMB+gPFHphoul4c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72bf7a7-fd85-4f37-af31-08dd88d15832
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:58:06.6701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DB2G53iJLrICBFM6izbboob8C3mOCXtLC0nYKdL2oGM733vOnVfAZ6Y3uiHC9ai5tzQDHnCOYRZchJedMlDgDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010129
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=6813a838 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PHD7Guh85veGlZlmIGYA:9 cc=ntf awl=host:14638
X-Proofpoint-GUID: 6W-wY-ubyzeE9g-fK9PR5zHVzs8LZa3u
X-Proofpoint-ORIG-GUID: 6W-wY-ubyzeE9g-fK9PR5zHVzs8LZa3u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfX9Vf8jXJyqeMO 1vWED2/pWvqaohelWVvjwCYJ8H1k/yGGYnfuGTNgVwS7Kr5r9XB9n1fnTw2e1oL7QWE6FSeVGu1 2FJoKMgkbea5BYl6U7JGvqdh2YZjlnZQgipRXfXkn9m46eR2pUNCaMZUDL8HA7gfJ+C5I8iHE6u
 4S6zfdM/6GT3MvrsPrRa/qUdbqeOTIyJ3lRYOjebmezuDopwYY/0MbvsB21I1oP82fmgpqsXizO oK0UQLLcdhtdx3+C/X0/m8j0iyImbbGAdfvIjBsYUiNzB9iyr0Zxv46OrexXnErTPrOR7jeH4Za okhzJTbIVSp08ZD77SfHi3cvQ4LBDQovohSx2mGxvzxHJdukzREST/OnklVrTjAtWnJs9aBpDUu
 hVy8+rLMuYSNeyTUqgsq7ofsKZGGRWf1PAu0NluhVgKDVpMRRVb0dkwVA4jkT9Q0lgtaLpMo

Now that CoW-based atomic writes are supported, update the max size of an
atomic write for the data device.

The limit of a CoW-based atomic write will be the limit of the number of
logitems which can fit into a single transaction.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

Function xfs_atomic_write_logitems() is added to find the limit the number
of log items which can fit in a single transaction.

Amend the max atomic write computation to create a new transaction
reservation type, and compute the maximum size of an atomic write
completion (in fsblocks) based on this new transaction reservation.
Initially, tr_atomic_write is a clone of tr_itruncate, which provides a
reasonable level of parallelism.  In the next patch, we'll add a mount
option so that sysadmins can configure their own limits.

[djwong: use a new reservation type for atomic write ioends, refactor
group limit calculations]

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
[jpg: rounddown power-of-2 always]
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_trans_resv.c | 94 ++++++++++++++++++++++++++++++++++
 fs/xfs/libxfs/xfs_trans_resv.h |  2 +
 fs/xfs/xfs_mount.c             | 81 +++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h             |  6 +++
 fs/xfs/xfs_reflink.c           | 16 ++++++
 fs/xfs/xfs_reflink.h           |  2 +
 fs/xfs/xfs_trace.h             | 60 ++++++++++++++++++++++
 7 files changed, 261 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_trans_resv.c b/fs/xfs/libxfs/xfs_trans_resv.c
index a841432abf83..e73c09fbd24c 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.c
+++ b/fs/xfs/libxfs/xfs_trans_resv.c
@@ -22,6 +22,12 @@
 #include "xfs_rtbitmap.h"
 #include "xfs_attr_item.h"
 #include "xfs_log.h"
+#include "xfs_defer.h"
+#include "xfs_bmap_item.h"
+#include "xfs_extfree_item.h"
+#include "xfs_rmap_item.h"
+#include "xfs_refcount_item.h"
+#include "xfs_trace.h"
 
 #define _ALLOC	true
 #define _FREE	false
@@ -1394,3 +1400,91 @@ xfs_trans_resv_calc(
 	 */
 	xfs_calc_default_atomic_ioend_reservation(mp, resp);
 }
+
+/*
+ * Return the per-extent and fixed transaction reservation sizes needed to
+ * complete an atomic write.
+ */
+STATIC unsigned int
+xfs_calc_atomic_write_ioend_geometry(
+	struct xfs_mount	*mp,
+	unsigned int		*step_size)
+{
+	const unsigned int	efi = xfs_efi_log_space(1);
+	const unsigned int	efd = xfs_efd_log_space(1);
+	const unsigned int	rui = xfs_rui_log_space(1);
+	const unsigned int	rud = xfs_rud_log_space();
+	const unsigned int	cui = xfs_cui_log_space(1);
+	const unsigned int	cud = xfs_cud_log_space();
+	const unsigned int	bui = xfs_bui_log_space(1);
+	const unsigned int	bud = xfs_bud_log_space();
+
+	/*
+	 * Maximum overhead to complete an atomic write ioend in software:
+	 * remove data fork extent + remove cow fork extent + map extent into
+	 * data fork.
+	 *
+	 * tx0: Creates a BUI and a CUI and that's all it needs.
+	 *
+	 * tx1: Roll to finish the BUI.  Need space for the BUD, an RUI, and
+	 * enough space to relog the CUI (== CUI + CUD).
+	 *
+	 * tx2: Roll again to finish the RUI.  Need space for the RUD and space
+	 * to relog the CUI.
+	 *
+	 * tx3: Roll again, need space for the CUD and possibly a new EFI.
+	 *
+	 * tx4: Roll again, need space for an EFD.
+	 *
+	 * If the extent referenced by the pair of BUI/CUI items is not the one
+	 * being currently processed, then we need to reserve space to relog
+	 * both items.
+	 */
+	const unsigned int	tx0 = bui + cui;
+	const unsigned int	tx1 = bud + rui + cui + cud;
+	const unsigned int	tx2 = rud + cui + cud;
+	const unsigned int	tx3 = cud + efi;
+	const unsigned int	tx4 = efd;
+	const unsigned int	relog = bui + bud + cui + cud;
+
+	const unsigned int	per_intent = max(max3(tx0, tx1, tx2),
+						 max3(tx3, tx4, relog));
+
+	/* Overhead to finish one step of each intent item type */
+	const unsigned int	f1 = xfs_calc_finish_efi_reservation(mp, 1);
+	const unsigned int	f2 = xfs_calc_finish_rui_reservation(mp, 1);
+	const unsigned int	f3 = xfs_calc_finish_cui_reservation(mp, 1);
+	const unsigned int	f4 = xfs_calc_finish_bui_reservation(mp, 1);
+
+	/* We only finish one item per transaction in a chain */
+	*step_size = max(f4, max3(f1, f2, f3));
+
+	return per_intent;
+}
+
+/*
+ * Compute the maximum size (in fsblocks) of atomic writes that we can complete
+ * given the existing log reservations.
+ */
+xfs_extlen_t
+xfs_calc_max_atomic_write_fsblocks(
+	struct xfs_mount		*mp)
+{
+	const struct xfs_trans_res	*resv = &M_RES(mp)->tr_atomic_ioend;
+	unsigned int			per_intent = 0;
+	unsigned int			step_size = 0;
+	unsigned int			ret = 0;
+
+	if (resv->tr_logres > 0) {
+		per_intent = xfs_calc_atomic_write_ioend_geometry(mp,
+				&step_size);
+
+		if (resv->tr_logres >= step_size)
+			ret = (resv->tr_logres - step_size) / per_intent;
+	}
+
+	trace_xfs_calc_max_atomic_write_fsblocks(mp, per_intent, step_size,
+			resv->tr_logres, ret);
+
+	return ret;
+}
diff --git a/fs/xfs/libxfs/xfs_trans_resv.h b/fs/xfs/libxfs/xfs_trans_resv.h
index 670045d417a6..a6d303b83688 100644
--- a/fs/xfs/libxfs/xfs_trans_resv.h
+++ b/fs/xfs/libxfs/xfs_trans_resv.h
@@ -121,4 +121,6 @@ unsigned int xfs_calc_itruncate_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_write_reservation_minlogsize(struct xfs_mount *mp);
 unsigned int xfs_calc_qm_dqalloc_reservation_minlogsize(struct xfs_mount *mp);
 
+xfs_extlen_t xfs_calc_max_atomic_write_fsblocks(struct xfs_mount *mp);
+
 #endif	/* __XFS_TRANS_RESV_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 00b53f479ece..9c40914afabd 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -666,6 +666,80 @@ xfs_agbtree_compute_maxlevels(
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
 
+/* Maximum atomic write IO size that the kernel allows. */
+static inline xfs_extlen_t xfs_calc_atomic_write_max(struct xfs_mount *mp)
+{
+	return rounddown_pow_of_two(XFS_B_TO_FSB(mp, MAX_RW_COUNT));
+}
+
+static inline unsigned int max_pow_of_two_factor(const unsigned int nr)
+{
+	return 1 << (ffs(nr) - 1);
+}
+
+/*
+ * If the data device advertises atomic write support, limit the size of data
+ * device atomic writes to the greatest power-of-two factor of the AG size so
+ * that every atomic write unit aligns with the start of every AG.  This is
+ * required so that the per-AG allocations for an atomic write will always be
+ * aligned compatibly with the alignment requirements of the storage.
+ *
+ * If the data device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any AG.
+ */
+static inline xfs_extlen_t xfs_calc_perag_awu_max(struct xfs_mount *mp)
+{
+	if (mp->m_ddev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(mp->m_sb.sb_agblocks);
+	return rounddown_pow_of_two(mp->m_ag_max_usable);
+}
+
+/*
+ * Reflink on the realtime device requires rtgroups, and atomic writes require
+ * reflink.
+ *
+ * If the realtime device advertises atomic write support, limit the size of
+ * data device atomic writes to the greatest power-of-two factor of the rtgroup
+ * size so that every atomic write unit aligns with the start of every rtgroup.
+ * This is required so that the per-rtgroup allocations for an atomic write
+ * will always be aligned compatibly with the alignment requirements of the
+ * storage.
+ *
+ * If the rt device doesn't advertise atomic writes, then there are no
+ * alignment restrictions and the largest out-of-place write we can do
+ * ourselves is the number of blocks that user files can allocate from any
+ * rtgroup.
+ */
+static inline xfs_extlen_t xfs_calc_rtgroup_awu_max(struct xfs_mount *mp)
+{
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev_awu_min > 0)
+		return max_pow_of_two_factor(rgs->blocks);
+	return rounddown_pow_of_two(rgs->blocks);
+}
+
+/* Compute the maximum atomic write unit size for each section. */
+static inline void
+xfs_calc_atomic_write_unit_max(
+	struct xfs_mount	*mp)
+{
+	struct xfs_groups	*ags = &mp->m_groups[XG_TYPE_AG];
+	struct xfs_groups	*rgs = &mp->m_groups[XG_TYPE_RTG];
+
+	const xfs_extlen_t	max_write = xfs_calc_atomic_write_max(mp);
+	const xfs_extlen_t	max_ioend = xfs_reflink_max_atomic_cow(mp);
+	const xfs_extlen_t	max_agsize = xfs_calc_perag_awu_max(mp);
+	const xfs_extlen_t	max_rgsize = xfs_calc_rtgroup_awu_max(mp);
+
+	ags->awu_max = min3(max_write, max_ioend, max_agsize);
+	rgs->awu_max = min3(max_write, max_ioend, max_rgsize);
+
+	trace_xfs_calc_atomic_write_unit_max(mp, max_write, max_ioend,
+			max_agsize, max_rgsize);
+}
+
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
 xfs_rtbtree_compute_maxlevels(
@@ -1082,6 +1156,13 @@ xfs_mountfs(
 		xfs_zone_gc_start(mp);
 	}
 
+	/*
+	 * Pre-calculate atomic write unit max.  This involves computations
+	 * derived from transaction reservations, so we must do this after the
+	 * log is fully initialized.
+	 */
+	xfs_calc_atomic_write_unit_max(mp);
+
 	return 0;
 
  out_agresv:
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e67bc3e91f98..e2abf31438e0 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -119,6 +119,12 @@ struct xfs_groups {
 	 * SMR hard drives.
 	 */
 	xfs_fsblock_t		start_fsb;
+
+	/*
+	 * Maximum length of an atomic write for files stored in this
+	 * collection of allocation groups, in fsblocks.
+	 */
+	xfs_extlen_t		awu_max;
 };
 
 struct xfs_freecounter {
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 218dee76768b..ad3bcb76d805 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1040,6 +1040,22 @@ xfs_reflink_end_atomic_cow(
 	return error;
 }
 
+/* Compute the largest atomic write that we can complete through software. */
+xfs_extlen_t
+xfs_reflink_max_atomic_cow(
+	struct xfs_mount	*mp)
+{
+	/* We cannot do any atomic writes without out of place writes. */
+	if (!xfs_can_sw_atomic_write(mp))
+		return 0;
+
+	/*
+	 * Atomic write limits must always be a power-of-2, according to
+	 * generic_atomic_write_valid.
+	 */
+	return rounddown_pow_of_two(xfs_calc_max_atomic_write_fsblocks(mp));
+}
+
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
  * metadata.  The ondisk metadata does not track which inode created the
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index 412e9b6f2082..36cda724da89 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -68,4 +68,6 @@ extern int xfs_reflink_update_dest(struct xfs_inode *dest, xfs_off_t newlen,
 
 bool xfs_reflink_supports_rextsize(struct xfs_mount *mp, unsigned int rextsize);
 
+xfs_extlen_t xfs_reflink_max_atomic_cow(struct xfs_mount *mp);
+
 #endif /* __XFS_REFLINK_H */
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index 9554578c6da4..d5ae00f8e04c 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -170,6 +170,66 @@ DEFINE_ATTR_LIST_EVENT(xfs_attr_list_notfound);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_leaf_list);
 DEFINE_ATTR_LIST_EVENT(xfs_attr_node_list);
 
+TRACE_EVENT(xfs_calc_atomic_write_unit_max,
+	TP_PROTO(struct xfs_mount *mp, unsigned int max_write,
+		 unsigned int max_ioend, unsigned int max_agsize,
+		 unsigned int max_rgsize),
+	TP_ARGS(mp, max_write, max_ioend, max_agsize, max_rgsize),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, max_write)
+		__field(unsigned int, max_ioend)
+		__field(unsigned int, max_agsize)
+		__field(unsigned int, max_rgsize)
+		__field(unsigned int, data_awu_max)
+		__field(unsigned int, rt_awu_max)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->max_write = max_write;
+		__entry->max_ioend = max_ioend;
+		__entry->max_agsize = max_agsize;
+		__entry->max_rgsize = max_rgsize;
+		__entry->data_awu_max = mp->m_groups[XG_TYPE_AG].awu_max;
+		__entry->rt_awu_max = mp->m_groups[XG_TYPE_RTG].awu_max;
+	),
+	TP_printk("dev %d:%d max_write %u max_ioend %u max_agsize %u max_rgsize %u data_awu_max %u rt_awu_max %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->max_write,
+		  __entry->max_ioend,
+		  __entry->max_agsize,
+		  __entry->max_rgsize,
+		  __entry->data_awu_max,
+		  __entry->rt_awu_max)
+);
+
+TRACE_EVENT(xfs_calc_max_atomic_write_fsblocks,
+	TP_PROTO(struct xfs_mount *mp, unsigned int per_intent,
+		 unsigned int step_size, unsigned int logres,
+		 unsigned int blockcount),
+	TP_ARGS(mp, per_intent, step_size, logres, blockcount),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, per_intent)
+		__field(unsigned int, step_size)
+		__field(unsigned int, logres)
+		__field(unsigned int, blockcount)
+	),
+	TP_fast_assign(
+		__entry->dev = mp->m_super->s_dev;
+		__entry->per_intent = per_intent;
+		__entry->step_size = step_size;
+		__entry->logres = logres;
+		__entry->blockcount = blockcount;
+	),
+	TP_printk("dev %d:%d per_intent %u step_size %u logres %u blockcount %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->per_intent,
+		  __entry->step_size,
+		  __entry->logres,
+		  __entry->blockcount)
+);
+
 TRACE_EVENT(xlog_intent_recovery_failed,
 	TP_PROTO(struct xfs_mount *mp, const struct xfs_defer_op_type *ops,
 		 int error),
-- 
2.31.1


