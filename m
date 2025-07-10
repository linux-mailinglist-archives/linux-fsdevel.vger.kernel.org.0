Return-Path: <linux-fsdevel+bounces-54524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37819B007B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 17:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E39F2189EDF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 15:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08FA278750;
	Thu, 10 Jul 2025 15:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6bmLnnh";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YRxUa4JB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5529B27510A;
	Thu, 10 Jul 2025 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162684; cv=fail; b=XJqWpRuZutLPilO5mT3Y6t61iyx5jEDP0w5VI8IZg6NA5i1pHDiE4O7dXFZtMx13NS6jmPW6DIkfSsahctnyS87OwtT+JPtYC2AF+9tpTN9WAjMjpKKXX6/KKRexdNRGMDk4IfXV/QxgJ8ALQf4qp69DmousLuYY52WrS0rnNgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162684; c=relaxed/simple;
	bh=ELCWTjVUKWu9lWDsxrGyIqbVes+UQrULMHIthnl31p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XlHKNCJn/92YlpJmGj1GDtQfsjqAEI5p84MHhLV+Z3XCbuMYZ8HrcajMUH799GZEglB0QKSR9TwIGDjc46w8gibWyZ5vAyqSsXsS+XeMtsgrTT/7aK8EiQzhYW2S5Do8tmEska5YDr8G1bH7y0VnEfSk1lakH7I8QuwhxXV+PZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6bmLnnh; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YRxUa4JB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56AF73Nm007434;
	Thu, 10 Jul 2025 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/6/5GxZyNlGBOsA1ixk1CmOFmpuMo6iGz4f82q6m2mg=; b=
	f6bmLnnhyMIgdFl6OZ/6sfP+vA/EbJ8gseDCxQwoBV/K0d2EQ4JFddxVW9d8Mg2N
	LSMZjonDzFm+mAUQRrRzxH1629bQJgjTbxtSZLa6UMagO0zHwT8/svUTF7ZZoj5Y
	IFrUiPY5EIVQ9aDP86uIQ442PSWeYUqWSoq4/sCGvdw7AtgEACIMKzRu5dF4seI0
	ZDt2Wyj2k0TuJ4edvOI4P+gw9a5y+F1BCCQYqkjBaERSFxxw10Zmb2gMdOAozyMu
	WOlOixHu1wSkM6j+hhsXlwlphI5zHFUye3BmzLIaIJxMYA9IQ/AgiukDyI7d3Xcr
	RJGVrsFIKPu5iT63DJeoZg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47tfvd038e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AElogq014084;
	Thu, 10 Jul 2025 15:50:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgcfqpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 15:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXPoS9bDCI0J+KuOF3Kt955q/XI/Blh0WKdCuIKofvA1dYGkeQqZuDETixXaPFbQCp59OI4eAULuK5SgX1Z2gnAqTtGsWgsICEjXzNlp/uT7gky9XX4xeyI54iPso+wyoXm8A11LJq3pzTkV8sJOfYcZbxNK0L5w3FkI9goa6l2fM01dsY45tRPNo6oWH7bqpaNS0cwg0RlVPNfPa58rEOCLRxEU2a29luC+rlaZeAft+jXpLkt/YEqu2PZSQAqzAnEOyxMiQKNtc3TDcXg3IBbaqc7ytraJLckTH7qqqBKOiRe/PUxowkGzpmgspO3WJoOvW4XhPuhXvxn367HwGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/6/5GxZyNlGBOsA1ixk1CmOFmpuMo6iGz4f82q6m2mg=;
 b=SArPKOmj6CLP5+ND3YU1DGMbOMIyB+AsHxs8t8eXD4qeSZyKe5Ri1MfBxzQOHPW6g/C6F9AL7csZnIh2s4cgZF2Ilsl9IcHVbrN23c1tHXnR5PNMTRBN9muegDHIQsl6+XkI0qNzCVLEueOu3dLZ70jdutWlTUTeYcHi5766vMDdSfxv+f6VyimIdmvZRaOQAHeCW7x41Zw22a26jTu6KvSfxPwYZZ3zOHHxVqFjubwbbikWoxvoZPWKll8B5iEQenwMQOr9XkqL+mHk/EV6RXElDl8HNqSWOaLt2X305yuRPNVlaSmOrY+ctXGpJzOoLmPSlx2kUvveS5QGrkshgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/6/5GxZyNlGBOsA1ixk1CmOFmpuMo6iGz4f82q6m2mg=;
 b=YRxUa4JBA10CNJ5m+Ry94kaFJV6us072MnioPeWnopycTixJvayVUgE1xkQPWo/XLOUFGLIXBXjL+g7LtjGCOBYLuZSlbSfvuvY4CX1qg65YmiTrrxRS/u72p3D6hZxpYcmRYgg6YoIVPBfEauB7pCG8M54uVrEhPXaW3zY+bFM=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB6691.namprd10.prod.outlook.com (2603:10b6:610:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 15:50:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 15:50:46 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 02/10] mm/mremap: refactor initial parameter sanity checks
Date: Thu, 10 Jul 2025 16:50:26 +0100
Message-ID: <d6614e35931246cbc68e9d6250552966a407ab45.1752162066.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
References: <cover.1752162066.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0069.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c49fb5-2806-47bd-e713-08ddbfc988db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S7Wo0gWGtZCbrWkAHLXKbm+luB9ey8WQEHn+dI4+/IN7rIumUiX9Myt36AOL?=
 =?us-ascii?Q?0LqPGe+4QlDjDVjK/XEqUkkTueVCoGBOGvy+ndUT4/SAewL4xAEU3Av2ZAEq?=
 =?us-ascii?Q?TXVjNleNZMsLfkKsIOfhe2ZvdxjcNU67ku1/VEk0USek55/nGUGvlV/dl7Pg?=
 =?us-ascii?Q?Pjtjb7dHPomGwBPTm8kxitDaZvL4/X+xh7j4YJYbX3t3hi6CamiNU/1+f/jv?=
 =?us-ascii?Q?v4f8WamydKztsntbeXkpy9Gqvd1hN4RatC7ghjqKa1Vnc84V2usl3e08evYW?=
 =?us-ascii?Q?mJy/3CKfAheX3oCRspbXDtAal8Stb3CV0SruXAbq28DZ3BWPvQ0SdtQ/SXQC?=
 =?us-ascii?Q?7ugayRZwthwXcBPLuQsuQAAURwvGKsaiMDfD0AkFSEYQKlBEpOwB/pw2eIdc?=
 =?us-ascii?Q?jJvriStGSvFZZqUKGnYI2aRt3XyGQK2a0943Zw81N/LdlutysPEkz/t7NTrJ?=
 =?us-ascii?Q?6MrJJfhv75uH4F6+zLaKwCUFEjkNzIybg18rnNfHvfjE9IAr8vtYBfEPgRxA?=
 =?us-ascii?Q?DAHfN57unzsSxPEzOwBfYF0rScR1V00zmkVi5lu8Zg4+9i8EL5wtkHKDRQ+Y?=
 =?us-ascii?Q?SNazUkk3/8EfiuomyIfw1TunbJLTmk2xMZplhJbS97Fz/o2kTrlSvbjQiwF7?=
 =?us-ascii?Q?6C16cFfA9GmvCDqbSPTsm84tEjwxqn3+3FZ/PqVtdrWiHmMzfNAd3LLaOiz5?=
 =?us-ascii?Q?9kv0iSfJwxAy2oWMOjQHlA/mSUpxtBCyyQzAOWyRWqU9TAmV4oBW/JU0/AqE?=
 =?us-ascii?Q?fNoZZDmJafK3AkMHSKXA60yQtLn87rDKP8GBPOvd+fq0onjG4dq/EPEi2KXA?=
 =?us-ascii?Q?IJgWQHQvhzsFTtZngVMQ7sRrXzYM+Ys4RBF892Aaoq9ZewNXVbLStoBYtNJZ?=
 =?us-ascii?Q?Wb3cC589Tz5X4oOF9ewX9TtVJrH5V7Ce1IZ/D8/196dw105Cuup/BOWrpEg4?=
 =?us-ascii?Q?gb+s8cj9Kf/3kCJbncJ6Zii5QxgRAEoUtEB7b8A+5BvcbtQYJbB0FlbEGn11?=
 =?us-ascii?Q?pDTTdEnIKXTt1WxBbjEoXurGRaSWrhS82TXq7V4E5yD7l+EZKqH9hgDBMe22?=
 =?us-ascii?Q?BSz+P/2bxUVnJmJlrtLmtId4n0R0JVl9kWBmEx/TQ9Y6Kfc3K0YWiXokbuap?=
 =?us-ascii?Q?aHHWHcsMjaBSZrRN/kLMcw1t7gS7f8TTund+LHn0wMKSHA/DwihKSPgD6qkD?=
 =?us-ascii?Q?9Hx9hUvqyghnwBzU6JLMRSLv/7cCJBPFpM5sN2As8ARvi9P5pk6jkipxPe3w?=
 =?us-ascii?Q?JL6aMsCrAKGyZmydGXDzT/lOumoAUy+t+IDIyiCYRXzajX8PyTkxKmcLoMQJ?=
 =?us-ascii?Q?PYYNB75X1znaV0i1FBMfhEMqNoAdUHoJL10hXZO8ONMqzHzrK2PV2UCYF5bD?=
 =?us-ascii?Q?LSyGlhXT8kpRDX5aCJUT1kRHqCbv7VMd8X0kFf6XX4oMM8j5d6Uyao1k3qqY?=
 =?us-ascii?Q?s7zYqgMBSqQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mUMdwU581nA8c0smJQMSn5NQseVeQrPnQZ3gwpd6Lo5EfjJwE9C7wb5RfaH?=
 =?us-ascii?Q?MoG+WyAcLVfmXYvQjM2Ue6n9E15SkAC6iTSSVuq0OsVATetf8tMNHLU0tHOg?=
 =?us-ascii?Q?RYLrYwfFIb/EHhXqMLixA94pzcovFVQOl+9dWBntPhLEA3lY+VwbPvTNXjY4?=
 =?us-ascii?Q?YQIKItrg/s6WTD0ChgRrIHrnmKqV5r1LAjhuPRyPklm4IghM9smo/N0idzca?=
 =?us-ascii?Q?fcbQiLmnaUE6r3D+FQ8enF1OQHB/mB2S8kuLId2+ckfynRuhVqlFc54AEjAe?=
 =?us-ascii?Q?vY73HBH2xNb6fjSPuJE0DwFD2cSRSgHcUqu5oK6dz57zkczMZsuNN08XuKGM?=
 =?us-ascii?Q?RpRnQSLUmQMvcNOGFTwbjToU0vuSDlwjnQypACUMwgoPie2BuDwb7FfvWeT1?=
 =?us-ascii?Q?JvIrPesLXfFyOU2Ej4FDOS0GcnHU8ZOJr+tu4MIP+YVARWpek1yb6F2n+nKK?=
 =?us-ascii?Q?nqxr02xcNIJHZttQ0mb5HUcChyhhHIjkrjx+gPhm7IzEEA6HB62Siz/uPyiv?=
 =?us-ascii?Q?sCB3bmcCE+0pdrnF43UUojxvrpofJVFJpYRhu3TrU8Akhg/ayQrEbqpTQoUl?=
 =?us-ascii?Q?WaFr2riiFpIrYlL9X/eCDXQcd+laifA9di/W1IvoPC9iab4q/aI+PpFWLO5B?=
 =?us-ascii?Q?R7oXtP711oFFA+AYv6NVEv0sQL3DGjcwD07ZEXPd+adrVfntpzuP1/TBWoXY?=
 =?us-ascii?Q?oXUSc5DjbSgGrjnu+WVUCbxyLFHpDj2lUySe7Nf3y9k8nzzVg3OJnYGBjI9c?=
 =?us-ascii?Q?dNxJGd1fgJ936Hu09V4SpxB+ZjvcnuMEuaSwbUyrr7l3PJNkG+bMC9mFsx/8?=
 =?us-ascii?Q?8mn1LIhTKkppulMcnqNKri7EjtgcfGc1hme2yXHAn0uQqYJ4qVow0l5VN7aJ?=
 =?us-ascii?Q?8ieTQTwM4uwCisqtphId4ewqHig7py6LCuDnItw3aVhSuahWrltIHr7gnFIC?=
 =?us-ascii?Q?imm1GV7PBtYVW7FKkUNSMlKdhjWGjCY3JIHD2JbkbvMt8Y5pQrtfDS2j2FD6?=
 =?us-ascii?Q?X9D2amVxphwYCcMzVfQ84xKrGvWA9ukEW2bHYswACOqJA7tWAV1jPPUeRoC8?=
 =?us-ascii?Q?Ggtu82EeqQlIlAP76tJs1cC8hBZTKgDwsn5eyMxSMTarw/6UBnp5LniYryg1?=
 =?us-ascii?Q?sCLAz+Wc9Pyn1ZdcL43fNVNGC1k1Kw+8T38+IEo6i9UrU4g/aNBfPMsG65dc?=
 =?us-ascii?Q?JBUYh3QqMG14ThdpBHoJcR6/5/H0gNe5w+eFp0ohi0MJQF/FRz5j18Jg2sTQ?=
 =?us-ascii?Q?OER4Hgyo76QKpWGh0AI5xbLC4Oc8py9Si2OqaECohMwepeTrafa6kMcDaXbM?=
 =?us-ascii?Q?QpfU/hrb9KoK967zjZ3qFyyXcHPe/nquv9lIVxYPm88ub1oc1KPNVx1IS5NF?=
 =?us-ascii?Q?J5UCM+273J1sG0qzK5KUMh+uJl7Gstawp+FciY1TtS7rp41JZ673x45v6aHE?=
 =?us-ascii?Q?vD5H1GiVIRXn1Yzimj3HpAcMtVRl3hVmW+y7NCmm6JnMn0iqXmdhOVWGQRsW?=
 =?us-ascii?Q?4BL1KEr8FGSgHCyOTGMi+nftkPdznzp2+6jf1Ivmg2Igj5tG4MI/KSer4kXr?=
 =?us-ascii?Q?2t8QkBw9DbR1S8ECsyZaFtmq6VmNgz9JKgGU58FnenK2eZ4FxBX/ueGnAtQ9?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	M4i73HRnrN/IHJBxSquemZhEwWIsUMY8OVprHVJhwJB4zrfOdTaNZHTPsrb33Pyjikv8sNw8alI2BK/OEADnDz6BiZBnsz5lml7MsCjlFSi2EaDa/azQkmSPn5K2XXdgvGckJSZUGOM8ctlM0VnsyEdi5ZxvooYA60GqEfc4zhTQl4a+X0y00/7N6pEYC3SsGvo669Au0ZVjlAixJKY3QNPeS5LNHTaxlK0dI23T1l9QHW27CX8RSjgqvHmLWOYRzwtQXD622guvVx6tM+rYkvbQ9IgNuTYLvW49UPd9VHMK2H/MNEp9coAhuFANicN0I6xmGj8Kz1V1DGEvTHt4ug0v437I1jznF+Ib4tyisAwVOgIi7AASyeJgGbmKXX/Q7n/Sn8/7Vb3k9CSgne+ijeanT0PapUGBBVC6Zu3l3/WjsX3BZcRDv8Ny/NDO2qnrXKjH0ir80uASkExlsxneZC6N0B9GFsHMKBmXx0ViZoFHwVg98kBwf8Gzl4bQtKfaDIMxfM6yainFKkHuzz5Znvvg06L0xuwirhTUASoPY7jMRX8QgcKHkf4zFzgr6XW6uOx44+spCMcy42fXMy3rwslEo2lB7l4/tFg9CZPHixg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c49fb5-2806-47bd-e713-08ddbfc988db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 15:50:46.2531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEHzbTTHPn50Rxvo9LBrEkAn6A2ky+hgt8FI9YbD7djNq5M2DftrOz5HyyBQT0R5TR6j+omy63hAJPvqRJIzRdftvIwjptbr4vSeXIdJ/1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6691
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507100136
X-Authority-Analysis: v=2.4 cv=Ydi95xRf c=1 sm=1 tr=0 ts=686fe15a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=44BLHjD3IfhdABlFFWYA:9 cc=ntf awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDEzNiBTYWx0ZWRfX4rnUwVnDzUAh JBiZvAtRRmLmTS0U2aDwc6kVRYeeaNT2E6yu+xktm9TTvvO7d7zckwCbqbAr+YgBGEwm1iAKXHC jYX+d+JBXEjTmRJRKz2OKH+g06ULQOqttSQBIlEAqNet9WEgw4X3DjDgYPx/QNNWvm2yRtCEO/t
 oSPXRHXPhlzuuxkvzYPh/Oupp2iGnEGYsmdNZKti++pBO7IZ45mWx+JP8vHJ3QL0bVekbsapf97 0r5wSiGA+Xw+4JuL7yqWfKd8+iqIYWVVAbxo40Ug0+4s3W+AluSepJe96BWj4BHf17NYoDCPeuW +2iir6zRIA1IZR2F7PXndbzzGJqv96tlekLspvPzg6jRnmZuO87w/pfXAEBKExxAkqE/8m6ULIS
 mAuTaitUoqZy98y8PPMWR08HXx7YC7ZIs7lbcSTqEOwNGf7pdRYVW9iQANC9ku8Vaod3qq/b
X-Proofpoint-ORIG-GUID: yOAG9qU7KKx-jDl0HesvfDgTVv4nEDBS
X-Proofpoint-GUID: yOAG9qU7KKx-jDl0HesvfDgTVv4nEDBS

We are currently checking some things later, and some things
immediately. Aggregate the checks and avoid ones that need not be made.

Simplify things by aligning lengths immediately. Defer setting the delta
parameter until later, which removes some duplicate code in the hugetlb
case.

We can safely perform the checks moved from mremap_to() to
check_mremap_params() because:

* If we set a new address via vrm_set_new_addr(), then this is guaranteed
  to not overlap nor to position the new VMA past TASK_SIZE, so there's no
  need to check these later.

* We can simply page align lengths immediately. We do not need to check for
  overlap nor TASK_SIZE sanity after hugetlb alignment as this asserts
  addresses are huge-aligned, then huge-aligns lengths, rounding down. This
  means any existing overlap would have already been caught.

Moving things around like this lays the groundwork for subsequent changes
to permit operations on batches of VMAs.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 1815095c4bca..a00da0288c37 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1415,14 +1415,6 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 	struct mm_struct *mm = current->mm;
 	unsigned long err;
 
-	/* Is the new length or address silly? */
-	if (vrm->new_len > TASK_SIZE ||
-	    vrm->new_addr > TASK_SIZE - vrm->new_len)
-		return -EINVAL;
-
-	if (vrm_overlaps(vrm))
-		return -EINVAL;
-
 	if (vrm->flags & MREMAP_FIXED) {
 		/*
 		 * In mremap_to().
@@ -1527,7 +1519,12 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	 * for DOS-emu "duplicate shm area" thing. But
 	 * a zero new-len is nonsensical.
 	 */
-	if (!PAGE_ALIGN(vrm->new_len))
+	if (!vrm->new_len)
+		return -EINVAL;
+
+	/* Is the new length or address silly? */
+	if (vrm->new_len > TASK_SIZE ||
+	    vrm->new_addr > TASK_SIZE - vrm->new_len)
 		return -EINVAL;
 
 	/* Remainder of checks are for cases with specific new_addr. */
@@ -1546,6 +1543,10 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
 	if (flags & MREMAP_DONTUNMAP && vrm->old_len != vrm->new_len)
 		return -EINVAL;
 
+	/* Target VMA must not overlap source VMA. */
+	if (vrm_overlaps(vrm))
+		return -EINVAL;
+
 	/*
 	 * move_vma() need us to stay 4 maps below the threshold, otherwise
 	 * it will bail out at the very beginning.
@@ -1622,8 +1623,6 @@ static bool align_hugetlb(struct vma_remap_struct *vrm)
 	if (vrm->new_len > vrm->old_len)
 		return false;
 
-	vrm_set_delta(vrm);
-
 	return true;
 }
 
@@ -1723,14 +1722,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma;
 	unsigned long res;
 
+	vrm->old_len = PAGE_ALIGN(vrm->old_len);
+	vrm->new_len = PAGE_ALIGN(vrm->new_len);
+
 	res = check_mremap_params(vrm);
 	if (res)
 		return res;
 
-	vrm->old_len = PAGE_ALIGN(vrm->old_len);
-	vrm->new_len = PAGE_ALIGN(vrm->new_len);
-	vrm_set_delta(vrm);
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 	vrm->mmap_locked = true;
@@ -1753,6 +1751,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 		goto out;
 	}
 
+	vrm_set_delta(vrm);
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-- 
2.50.0


