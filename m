Return-Path: <linux-fsdevel+bounces-47998-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078EBAA8532
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB233AF598
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F192C1E1DF2;
	Sun,  4 May 2025 09:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q5WT+imr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OlgWP5K6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224BE1DDC21;
	Sun,  4 May 2025 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349236; cv=fail; b=X4d12ZAhNbHqURyEO/iUpFexZJ89hHW0hvaR3fVdlPWtBfJ4Q4mwx55fbPDsB6226yhMUODc9o1r3e7bkWlF4Dc8z9fh8dPKshiY4rpugaOBNN6nJVsy80FJODM1u+xZBgiDPw8gsotBzUyz9/RxiZpDi1uCefXb4K4HjlzqYmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349236; c=relaxed/simple;
	bh=/3eHRBqXmpR6yq1epYunkIuXKCmECvtb4laXLCiZWd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULcokdLObVOgjzCp+qjBYcTWFv4fQT3VhkyWNCO09IM33cJka3WvupM9S7bHObteaBmUHqwhyXvScVHacX1c/S9e5ZUZoKv+0DDN1+VmR7H/ReYU8XRx9LQvZv5AKQsqaFLajmKuq+Q4+kxoGFcr4tBhem0paLX73hJkzwOO1hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q5WT+imr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OlgWP5K6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54486VZJ013798;
	Sun, 4 May 2025 09:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kuIG6thDLdvspmYKa5nJC+nv/4MZ8Ohf6Hauv447Apg=; b=
	Q5WT+imrHVDVyC/0HYRaTsvrq5M5oF6KE6FgME2cWj4bwVsblK2sZmhwBE6gjdVa
	YiX8gOJvBCO4G2D+mIZB60DB7DVXsnlhxloZNwMRIGJ2Eosi7Zxxzg8Sb56CNbss
	d55Yrf7b6Q9FEjaMfVgYgbZ6I7BUt8l18rOSv2QZyDeRUcU1c/2KiSc+1UyeH4GT
	Qd+kPY7N32lu9zZjnpZseayVbcUTZLordVlsKJfFjrTnSQ4y5M73lc1QhHfJFvL4
	kx+djWFpmKLDbZS7wubyddTc0R5pSJU2h0pg/MFfupMqS0NloxpUqXkYc7ORgaSc
	SY9gN3YBQtQJL48Qd0OZcA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e3jk03yq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5445T5ud025015;
	Sun, 4 May 2025 09:00:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011026.outbound.protection.outlook.com [40.93.14.26])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kd0ejk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r66CZ6v1saaCx4RcM2HAgJ6ME8pfxTG1cJW1NsEca6bJrdcIULe7jRYH/o3nkstzWvq/E2i3K+Xgb7jqCgYpwiwxzUFRujMp7WBGaZEWwRGZ28ebB9QYO/6XG//dnQZ1fmgvlVeESOvfxfmxORbJaB0liSwFjKRapFEdOF4kCZyIBCgefUYSNt50HT4+MWWQMyY+fnBkpXWiZlGSEMCA6rAKv5KXwxRaw49KWq7xz2NuZjG8jsI9Y5izaDxfpO8moiayqdSnbP4RxRi9HnNN561f/+9UkJCSd+k2B02k4dul4oN5x2f18NoL7KZQotmCm6+TUX7mkFBBP3aA74b85w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuIG6thDLdvspmYKa5nJC+nv/4MZ8Ohf6Hauv447Apg=;
 b=q5pJq8qtxVqB8yXd2Eg9wBdIAerKjHGV5Ug9tCYe7v/Wa5eD/7FNMrGaa7b3E0a+dTvMAW4YinRKu01HOrOULFp4zkPsaf6ExPVs3HTf6/bnVqcyLB9CTiOkstJPoLyzjl6YyhnJ1xoSUrMraDAVhv7uT9vrlPeBw1O760hXmbDwTRqgtiQBxMJXCH2yub9BqI9t7teyeSP/mpf2va+kH5MbBx7Vsd7Z4Zqdv90/4rZEx0PyB6azZYlcWl0WppHkSIQ/D40y6W3cK26VoEHCoqbJDDINVQYdCEbTyH5v+uk2RKlTpsm548Jd/M0oM2XyHqlRQAubrXsUKFZfabUFAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuIG6thDLdvspmYKa5nJC+nv/4MZ8Ohf6Hauv447Apg=;
 b=OlgWP5K6zgruYTpOcxzY8xxiLW0vOMvr4kt50p7EoI3ZOdUTjxntKU2JXbcrO8Cqm11zrEzxE1gI7jsCbkorljUb6UkgNJ3DyFIn64Cs88muI/6Gv6pbFBIbmGmknceJb8+cDzz+YYkyJYRMseArSco6PoBvb5kKNugt/UrIRwA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 09:00:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 09:00:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 14/16] xfs: add xfs_calc_atomic_write_unit_max()
Date: Sun,  4 May 2025 08:59:21 +0000
Message-Id: <20250504085923.1895402-15-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:408:ff::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: f5da1553-63e8-49c2-7b36-08dd8aea151a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YYADH8eLnFcegFr5OBMUEr/NlEWMANRSjdRZpWQ4sg7EdafNkS9T6vUL424U?=
 =?us-ascii?Q?h95eBxdwewxJ4d7DA4Xghkz9u/vV1UFaou7Ol971KJRPnQ0//EUM+d5V/6fJ?=
 =?us-ascii?Q?phP9RyWWIgnaHuh3UfaQ5HSs10KD8EQAqNiWZiQ56aiV70VADWpwyvniphmr?=
 =?us-ascii?Q?Vf1LXXqmoJwZD3ZRDx4SmppNJDOozxbRV+mYnd+gAP/N7iQyzhoV8vRNbZmq?=
 =?us-ascii?Q?P31nWmXiNmzUFr6ayuwVLY3r2g2blrO/4eWgg3amXbWae+Kdi0MqA2yVzapF?=
 =?us-ascii?Q?TUJzsuLOF9D3OIDJ0YKuWDQXOlkn4bkrVTf5oBrxOcwrnd0wWs2slmma0IQj?=
 =?us-ascii?Q?M35mYXJQLq+PLVGuua2NAjJYJ4fa0+hLYcw6uDRi0t38IKlDtDXefI7egX3m?=
 =?us-ascii?Q?gwouywdK9dSuOfKmwe+OKGSEEctsGfu4plsIbS7mR1GKiBNvpjIuDM1XLDI7?=
 =?us-ascii?Q?YcaZ2uzuNxmxXuRJMyO7A06wtQr9TCjbufFGLyBSWD2xZNpCT5xFhk5xBfXB?=
 =?us-ascii?Q?jTn343j+hTZCjua4iwJub1l92Cobj4kKL+EgJdxO+ZslnFLm0forlcaBUteI?=
 =?us-ascii?Q?2Xy7Lr5FrpbJLbV9s2n/H7SFMmyTca5+tKKosAp2HZOUSgVer7qnloTxKL5f?=
 =?us-ascii?Q?Xw6HmIpI0BrYTcJV0hRyiy7UNKhfusVk8PjtmKZFDYUNb801tyBjQ/zKzYZA?=
 =?us-ascii?Q?Y7Ore5AtduPpbLMloJ8nndlGP/3ZB9BRTisbm+mE/3NETd08bPw5yaUM/tr2?=
 =?us-ascii?Q?hpmBQ5aO4BDI9wNXnJTH3VsmozxK5D9sAI4v0jrwGr03NzBb+uFEQiW2wKkR?=
 =?us-ascii?Q?5MUaJgL85Jj5OnCA+41OTAPaDpgU4r9SQQh1CAkfQryHcjHkUiKCBsc3yL53?=
 =?us-ascii?Q?CZXmu2maVmKK/LQkZfSQvcHX9Lo0CabPKlRKHx33y7Q+E+FKqCLJ5Zw2ysqq?=
 =?us-ascii?Q?HhdIQFMeUEfxeiJSg6iILot/w+RjqTGXzvh+8I68MBONfGBLaKKEfjNmziUY?=
 =?us-ascii?Q?BD9IzN/u8d3G7rG9wLJq7yJ+hUr93t2v0l44p6BN180G+4Mknkj3PY1+Z2t0?=
 =?us-ascii?Q?KA5aBdkNPMA889LOrOGd+nGhAapgLrR5pQgzPPHBu/630FpPIq59K6Tm0guC?=
 =?us-ascii?Q?JMFcrF/yPRp+s8wbJnKgCDghT/tbwmiGQzBo9SmkIFLq5ZyoozV+fQGS6nEl?=
 =?us-ascii?Q?b6f1yENq7/UXMtvcpbaRZFryMQzqgXQPcG3sUvPRnwfqXXzJ0/22PFL9b9si?=
 =?us-ascii?Q?cCTdcI3h/SvM5GAF/4xrSIBjQfSwbc+corcpxh9mKSUUyEToI1FbuV9MfUMy?=
 =?us-ascii?Q?+Qnh3IrGKmpZ8bhHMa6KqIckL8QUoPvSINK9To1cmxhBnBKIaYJpOrnI3HyJ?=
 =?us-ascii?Q?Lq+eGjYJmkMkVMI1YZktld1ePHIq/2KQBJ/ZVWZiCc4V+nJ5vkQIbnD23spi?=
 =?us-ascii?Q?Z8ZHjxv1AWA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YG20JzMTjj+tXjYtpp7cNJ46eHr0uROWVviH7vCbRgqQBwo+qyuG0A/xUTiv?=
 =?us-ascii?Q?VV6ftssxC5hZQoeEiUHUgZP0kK0iM3+/yDKIA1FqoDONvW3PaoCHfwXI6tox?=
 =?us-ascii?Q?LeLed5OIudMbJKUmXBaXCKfJp7L7bWOl9GexudIotDBqBkU8hFqIz5eFVtP2?=
 =?us-ascii?Q?IvqJ8bwrIKfBxheJcAXxSeO7RJxqdA4Dq8Wc8xAiHKcz2mDSlbRTbtF7gnhN?=
 =?us-ascii?Q?nLIdlNa4YRb5ENjemV9hoSq5UHBGsDi99M5MGiK3KmqB24pP2NdF+O2Tee3w?=
 =?us-ascii?Q?Pw3+DBoORn7qm8h4hbCOlLJuwd6uimwAPc6v2LYHpbiKYJmAar7OdUbEFg//?=
 =?us-ascii?Q?UA08xCEms7jIa8DQXjcD8VJ6NSAQ/xDghY1uOtpGt/8/9+ieMWDgFSqlN8TW?=
 =?us-ascii?Q?kHTNEW+ozCPAGw3WJ0YoGf87Xg4i2hJs2XYVjTb35k5UK2UF8k3RNHL7EAhu?=
 =?us-ascii?Q?D+CKjpylQFz+BoKaZEVZ2zz14nbuSgCCIJ+M0njES51BpHsjqMVIRmCbD6JQ?=
 =?us-ascii?Q?JFI8SMuUZZKh0ovhnoRvxZI3N6iUM0RJ+hyELXb9r6U5PDcnWubcYzzhUMCe?=
 =?us-ascii?Q?UDjb9gC5xVnHR4LcB/IFaOELZpS9Ly15KW+IkxVo8bj3oEquxboMNn2Xi7j7?=
 =?us-ascii?Q?KR15K3vXSMPWWM+sCJsmRtjTLg2cR4FtHy7Z2Jj/RTPMIlvQP+JJIH/xbDBt?=
 =?us-ascii?Q?9Xbcffxv7C7ljOt0SG9M2XsGtVwMX1NWjyl2n/oybBiqwRXKrFkCVHRgHIjF?=
 =?us-ascii?Q?NzCtEFNHzVvE4MeOxAxMlrfEagbtH0EwnBoWPhZXuVrS1dOBAu7XWobMhRlB?=
 =?us-ascii?Q?h+RdkDvnhyMQSfrgerTehq2fKxn1zqYRP8SyksZBrNd2q50wQw8725LjDW51?=
 =?us-ascii?Q?4rc9jT1GqKk1kOzk19Fd/p/YV2682hYfwK2kQSiSd8k2aHH1QouIQUbEh4+d?=
 =?us-ascii?Q?CMbD4AnmFG5UNAoCkFhCJmhRLZKY2TUfQjQxHHpsd/UwHb56RStH3FDLlpqa?=
 =?us-ascii?Q?VO9Xo5FsH+Tj/BhaYC0Rds2nu3sGpG3O6QJARTeM9OkfetmoDTUbAp29g1wA?=
 =?us-ascii?Q?yynj9vt5dy0WMtfu5IMILZO45rMnZgInH4nQInEMTedAu3k9y7UfKOSdADfI?=
 =?us-ascii?Q?UsYw9r/hOIITzTy9LQ+dGArTYiopXKr3xQWirD8Rvgfzjvsqsi6bU2bqClC4?=
 =?us-ascii?Q?jWMr9+k4s3F/uKCzZ+g8f1R2+qdQOcyJZ2Mdl6jMS+LwIVfaWTfhdLelHPlx?=
 =?us-ascii?Q?I9iT3XPByOnW4TsQ4QtbYSH+pqVbne1lP/5dB50zx88pPr6onOK8QcDlmIp3?=
 =?us-ascii?Q?YshkaJtXsEYpNnKP+InCAvwxZ0DlONpqRsM2cNwmTZViQOOYqMHQAbsO3Csb?=
 =?us-ascii?Q?ZtLL7XJPKRh4kW0ZvkK4RFj/zr+d8+FB5bnt3p0jwhc5nTPnV29yZT0f8rZO?=
 =?us-ascii?Q?KoX+j479IBOVE8nZUNFvKNaHo7uV4dLjs9Ay1MyVMxeOR4Ub6q3sBbPtO8g8?=
 =?us-ascii?Q?mcgx2B3ZpzvFxBlB7/zWuvbazzt0Zz2MrWCbX5tL+f9XxaCUTOU7F8Qoy87f?=
 =?us-ascii?Q?5HIRaHI3Fj/DaIdfayJP7Z9jPe2QBYnaL7VlolkzLg7ZcV3p9EnZC6e+JRjy?=
 =?us-ascii?Q?dQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rAT8/w0r3RItXlKyKeetCDlxrOspMQOHCGSCOgTOvWSwDN6x8Ool8CH5VZAaN6pORIDCyEF3riKjbyEeJSQi7yDYHF0ilsL4uJ096lVAhy+NA4829pPkvpCI9kd+Jiv+3TVsFz6fiCQb0GdklIFE0Sgf8jHmrMXeGa1lMUGrdNVIdh4Nqb12If9CB6Im96/znjrvE89GU4skMNu5N8yc1tqpa8tnFnXIo7cI+8t4FUZXk66JY/0AcoQHGMiLJ84s0Ao3g16wE3A+V1FBa1Z0hrE+PhHyomSt4h9WaqGLulCNWapIOUdSP/v2llx0haJ9XEtGDfRhoCCmt5fHK8rLdIzMcPZbt7jatyA40ULVC2533LLGuMSzPbs1q0W/IaAenI28W5uQZkRalihGudp6Xm15KuAWm4d5OvDOgsJCTXCRmGFgeNuuC2YRLzCBQhv/SLPTQ6x2GVD0i55fnxh1wsbeYDaWBlToOqOsosq372Bq47o322MFmj5m57WY7UyEM1As1rdzkNjpgd9lBbSzB9EagTEYSXgiro6GESYY6J8Z+P0K5Cpi5o6hRWAnKDkneOvu8w+9r25ydQkbgYgj9/saCchOhKwvVMct6cartUo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5da1553-63e8-49c2-7b36-08dd8aea151a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 09:00:13.8512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2HIt+R8Q/MMMkmsuqbpx8aFjfL681dw6KxlSFfbqLWubClfmV8QmxPzQ2v/0RqwpHsTG8iej3rGkqxIXFBF1iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Proofpoint-GUID: m4E93e1KQucv_TojbB-bzFY1JUyqMd2Z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfX3YXxoQ7SKlBp 4iq6zRJ2/iuH9B+JKCDN8/ZB4Q5V0EPHKj4jlOspUa/773qlYK4IardaQ3zIh9YGWwCyRZrBUJY xfc9RC8Tox70PMqzsY6yDisv/t1+9tzPI9xmJi/WMmlaXzvEHiVe9DfK0B7d5rE3N6RMC3ti6BF
 rfgBfajiLo4R4amv9WSoM61hG3OJ+5lHxsRlSAF2KAkCoW0ZyQtN/vZ6Lb/I1cj+bfERX6QeXia GX+nuEtT7BM6Q2PLjw5jJ+OJbVmA2Mn7u8KfmFVH4YkzbIaJ8Hgab1WgvbYZ3HYJ8KQnunNYxAX vfAJh3fJS2VPy6fa28HWorvLSX3JjiBXOPgofVRQM9b/rurzu75IEZoBNzoPf7wP9k7RYQjru7v
 4UH9WnDBt7VC6OL3qoAr/rafBJgpsyg45tMdof+RMwvm8ZebbLdeNOOhdIPr13AH+jUzONwU
X-Proofpoint-ORIG-GUID: m4E93e1KQucv_TojbB-bzFY1JUyqMd2Z
X-Authority-Analysis: v=2.4 cv=IaeHWXqa c=1 sm=1 tr=0 ts=68172ca4 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=PHD7Guh85veGlZlmIGYA:9 cc=ntf awl=host:13129

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


