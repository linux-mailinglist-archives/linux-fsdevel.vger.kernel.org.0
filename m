Return-Path: <linux-fsdevel+bounces-41656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5E1A34127
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 15:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762CC18902B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04339245007;
	Thu, 13 Feb 2025 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FLsdwLeD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="N3I7eRLO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908C274266;
	Thu, 13 Feb 2025 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455055; cv=fail; b=XzGhYRfrxnoYG9bv3rLWLhv4EB+cQ8dDPtc/8W5SVQaclsfRVX/k9/iM/MrswneeMJouJftytB6poqUPwhHAO9ipAfSXVB6cb+LebABaNn7Uqpp0VEsbqsTg+VaS+PKEXHd60DwCf7MuuKaeCLV7wfC/UaCarlV4+v8sThmIEEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455055; c=relaxed/simple;
	bh=udfSgw0HPGWFcjKpv3qyE7q3gNDV6aAYOhRv+ukV2gc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Oh7krUI0iEy7PhJZDklWd9pvhT43CrY7/MV8CEcBRfS/3V87c0COQH2ts/Kuuk1Z70g7xogG1di23zDnxboCC6KRM3Pz4cXt5oCObH8Yirl6bHzrQJW7Hn6eB5WB8mWZEMrUQf1N8EEY3HcUTziX/3q8XgpabC2ahjDgaea3STk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FLsdwLeD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=N3I7eRLO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fgK7021984;
	Thu, 13 Feb 2025 13:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=KAXcineZukjzC8i4FlaiksfVssNZ1DdMG03wi5ZumPU=; b=
	FLsdwLeDtXXPzJ2VMukDF+IOQvsOlMeXKNJ0lhOhZQ763nZmIkPif7UwKP3QSAuJ
	QqbLgU5dEEmhQxuHCiuUz8VBchPXWkdys9H1AELLPxtsq5HCt9DOGoz4I0C1F7VW
	s4DOEzr3kKTT12o6ckJCsSU+sWNlNK1HSbjKqJV39ddTbVx4JWKjbwMkN0nWYokE
	IN411wZZONii0gBrr7R98l+UONVIFqEkNK4a/yEEc94ZDWepf8IGPECpYe9aouMd
	PCUVIpJdJhkayBDyX+DNKExm/KzcV5CQJcbV6ugnvhkXEWEhFGA+b1M3QW+Qd86s
	X37stUZ2cUT64uebXXQEpQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0t49jhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DDWqms009852;
	Thu, 13 Feb 2025 13:57:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqj1u15-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOlKM1EhPLk9R/AEQZEfhyGSTMMDwe2bhItCEMIQT5SCVaQIQj/Z1W4DLwAC36geTSpiNMa+lgp+NpZl/t2j2L9VYbcqA+FuWJApp1S+gkqtZe5wXruR4zrXdhjwUeAj9r40WS8ZNPKhryG5ggFeL19g7Ae3/unae2br6cuXE/DgxPzGSnZFweudv+RLioc3+mQzXMbCWJ1je9xXRVw1NEWGlb64TZw/K6An84zvFbtW3VUPbbSYSACNxRmeiSI5PkGDaVAGsGesVUEE7BokO7bFIuY+l9DHhUIu0EzDDTixwluLzlpmZJVC3eQgEPwXfYZ6ykFGaqZwm07OPlgkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAXcineZukjzC8i4FlaiksfVssNZ1DdMG03wi5ZumPU=;
 b=Pb1q9jB5UnCvVaJ/KPreG/zGvZOxNd69ZjTdCp2j4LdqOaK0WRF6kbF/w1zFLqHrqjgCkOJeU05MbAQrxlUZZG/xc9wFHo6KBIIaOX4HTG8vOL3w60tKK6095Q3lz6V5v11GtLrnBymvk8WPKooN/XVqraBWmUBR+3K0Wtpvw2Xg3r1lI9KZqOIjlGLnMmxlKhPBKTEfwexyhM5lyZO/8QLDtf3xn0GmXgGIA3SCxChI+DRlJ9GidcJcb5KAZqLQ7UTv+b9AeOISZpEe+hmhAQV97WxLCITFtxfj2LBvnRMQ+7QpZCCc477oFTrNfDPVxPgF21k2jG7JwybQzsndIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAXcineZukjzC8i4FlaiksfVssNZ1DdMG03wi5ZumPU=;
 b=N3I7eRLOkWw/X+/HTPU7l9HLCiWj3s82LyGplonD7vt6S8T3KQCqrXUFqByeL+y/idCZK8O4oUDeVoYJisKrzS1AbAUNPzLcXJdG5V83J6CR5KTDAlvGHXkkNsSAQVV1d0CyQSAoyy+q3mu67RRlXl1/9/zENZawS5nEnP1jYL4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 10/11] xfs: Update atomic write max size
Date: Thu, 13 Feb 2025 13:56:18 +0000
Message-Id: <20250213135619.1148432-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0085.namprd04.prod.outlook.com
 (2603:10b6:408:ea::30) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 230f719e-8afe-48da-c65d-08dd4c3651e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EnNRaYcOSS+nq7feT06dhW9OIBd2yeXw3OQmTWH4JjHwa0qgNJD85SimgBjQ?=
 =?us-ascii?Q?GP3WYfi1wqYmXDB467/j9eUfYG6TRQPvBAA1FDocUKS1rCWG4mOCEz511gTw?=
 =?us-ascii?Q?Lt741k7HR3Ayy4331j5WHlYRoYp7HH/Rtblt3S1diPS0SHVwGNOZWIBwgT4E?=
 =?us-ascii?Q?AIx6fdLOJ1GMQRvWRfpT/nhNuYEZBRRimlZKFav61o8sVPFl/z7rLLh98L8t?=
 =?us-ascii?Q?G4RMKW3bY2/+L1K5B3foxb09aZKNXUcct1oQ8RRR3lpdC3yXP/GsWJbqjmiz?=
 =?us-ascii?Q?lS1ar3OJS3M92pdhJSCLrfappW9IJkSpTQtsyYdkWI/SnryOSHFQrs24g1tL?=
 =?us-ascii?Q?EI3UPkI3ZSWPTM881P1Wl5SvxdNUh58E9hGV+QrUm5f3dzPhD1XZgjPFPQX2?=
 =?us-ascii?Q?DQKOj+geEio2RVvvQZ81cluetX68jfLInFHtbEuFuKPy+hDqVZeQUzoTnkWm?=
 =?us-ascii?Q?fsqPccHWR1O1MPTtIBZ4bqmvSDeS9Wtn0ANDrHBloGK3zObGQRLaP3WQpdCQ?=
 =?us-ascii?Q?iq/61bdiyRREBekV4h83R0hZr9qEbcdqchxI3Q3qryi2xPf2mNbiu1eWdTQu?=
 =?us-ascii?Q?bJ6/S6/GVNZ9ow27PQHOj+FU2iKOxxW7bq6tWdipnS7a5wVZ9G+9NyCPG8Tv?=
 =?us-ascii?Q?+QLhaxtgkGCDilpVO+3l54Heh79Kv7//sAC2rIxKHtI/wuRmgUARbKj2Lge/?=
 =?us-ascii?Q?0FEUaD0U4Kdrjwsa4YFcY1DfTyXu0q1WO9ZdOa7+iBxUQiFtfO4/vU0/3Jlt?=
 =?us-ascii?Q?+4I90nnyQxEog8If4/XlEY1ZZv3nCtWf68swaCOZNKJkYo831xjMPvBGsQ+B?=
 =?us-ascii?Q?DZVgTYqKr1Bq/sX3YLIjciF8S9Mc2M2dAu+rMmfwkCPGQXwet7tkw4rv/xfd?=
 =?us-ascii?Q?0KE8D4n53fHk7F+9WBq+PJZi3TmMnZnd2Y6HWGsnaa66y3UZsTFe+4gxPY4q?=
 =?us-ascii?Q?SfLeqAwEA8bIxoCDu+ZwaKoRGw9MLBNYAOvqQxrCDPck2T/s6vlmrEmhPzHz?=
 =?us-ascii?Q?RVPJHWZhUdstx4H9vMI47ds05fWUQhDAvhoRGyJoFLQIEO5Z/ylpOLdAthlF?=
 =?us-ascii?Q?HSQCNawyMW90FIZDm4rANIvi5sfaQkchr2heRSD2tGuCrb0Gt32vQuREmXIn?=
 =?us-ascii?Q?R48dvmTdDwAXpR8dS0+mvB1zKxwwR8f2y0tee0bO5SR0ny2uwYHxjbetupJ+?=
 =?us-ascii?Q?7rJDt2ur5MLbd424HJD46RaeiKFcGOJwIPtktXSZX3iCJsRSQneEk0NP8Tlg?=
 =?us-ascii?Q?dAFIgI1iKDWZHJCGP/blfT/+F5KASNLqs3lkZmO8Us/s+KeT4K+pXnhZTku4?=
 =?us-ascii?Q?Yv8b2T79E7JokakWUTvP9UeXB2SI9D1uzLfLeMcQee6UFcI4DRSJU7IoG/76?=
 =?us-ascii?Q?urbMU7lX1Ht52wtydzi1V7m870bt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q3q8SPs8TLlruh1Lwa3ocfLmLTUxHuIaEWUVHvVsPl30ShRyKtiFXLEdomRO?=
 =?us-ascii?Q?gF4PEVBA6J77cEykOrJo9AAkqnLnmXxRUtrt3B7iOeJk/093ADOyG0m8Dyob?=
 =?us-ascii?Q?2sYeN/121J+9lBjndZcYBDygCcsLyGmim7y5aZKQLgMcvK0O033GBr/pI+tP?=
 =?us-ascii?Q?FVhAfV3hj/H/TmY93nM2Y+2l4ftNphbd4CxcEm4yeoU2U94pZd2+9TidTPKp?=
 =?us-ascii?Q?ZMmIoEU2K1mzYVtr8URPoSaREY736Wu/UiolK0CQm2Ko2FlzrZlg+euxKX21?=
 =?us-ascii?Q?8Zk+HdMoaQz4Kx9BaQ4sRmf3XwMQB7l6JXP81gLW1IwiDBikNoBAOZlVfGmc?=
 =?us-ascii?Q?gVyNcXYdNC3lDx0+yxfYu48TA9q5vQKY29c0l+YsCxoWQMFRN6/kvD1F74uP?=
 =?us-ascii?Q?rrcXgIPbBVRDskj4/hiQ1OOjzTjq41Sv0c1O/vW9FxWI0X+7XGsiYbtnvz/S?=
 =?us-ascii?Q?d3BKhrge3+5lCmk7k5barKYx4PMj7YrGaLtdvhdhrabuF2Lh5oRKBSKjjBNZ?=
 =?us-ascii?Q?JG4puO9NojsqQQE6RNcoh18XU9IrOz1beBf68pRYoqcsx7hxdoGCn34mt+ad?=
 =?us-ascii?Q?ZAmyAuqFoZjv1Le5SphcvLAEusl0H8CUgqVNVsDBurGmCga5N0ok8LVJiORb?=
 =?us-ascii?Q?2telqOXpLgyUXe9LwG+B7FDgtIV3IHPa77axBoVC3vOjff6zJyTNRHp+5kP2?=
 =?us-ascii?Q?MDFyPdIqdiE1wbfkGsZrCOU/Q2dcYZFklEpJcwJdg9nDyewdPD2SjBxXNg3D?=
 =?us-ascii?Q?mZN9Ku6myXoGinoNpJSVfQz69YHkExl/CUCsu1AZX9Q88VWrkPWqUCYwrpSu?=
 =?us-ascii?Q?LtBLRKNRJyA4BI7udlploldwoxyGTVgaYCWOmbHE/WZJtWvIDA+HKcXkGWOs?=
 =?us-ascii?Q?45RJDyj4bpDdeA+/VAUOQ+hBaOXqZhgTeCTPMkuCjwe7hTBw72w/OQHMA8Ps?=
 =?us-ascii?Q?SkaHkEci5t1crbtCgfCmtV/unj4Mm0+v6z9MYEDn7XkAbgwxKS5S69hU/vus?=
 =?us-ascii?Q?9x8qyR3D4mYGhfWCwxFd3zDq+k7y7xbwnLmuNca+AOCKnps8c7uHwRPt6nDh?=
 =?us-ascii?Q?D/GgQPLAXrMS6UQt1GSaTmwmx7F5H7QucJek3q5ssXn3MQkO13gQtBpcnDxK?=
 =?us-ascii?Q?xSD75vaItpzJgw0lqAMV+/0HAj27a6YS9iRC19utgzUhK45AJA6hM4MY3+A/?=
 =?us-ascii?Q?DR4UqJYRoPp860InSAKq4N9IszXhK+73NFr6bAmk5D9HlvXG44jy0785NuYs?=
 =?us-ascii?Q?ACJ5QDGNfx/bfKeFhlWMjVFse42qMck5w1g6xVy7Yj3FZxYGXOgxCSiTOR8M?=
 =?us-ascii?Q?e6XCT9Mp70LoNXQVePXDibhQXk8+bI5lXqVFbyTakHyJRHxFKAhD0qa40esM?=
 =?us-ascii?Q?F0ly9+yOnJiVXCsLAYfltxzq2uX4dqH3LfAx27I6Sw54PgjqnZJZzW7EuzkV?=
 =?us-ascii?Q?rZm0UXHNoV/gJ6h9ZW8dkVRvwKQ7erWtF7a3nkPE3GTmwYa4PCuijQX90kpI?=
 =?us-ascii?Q?J8VFotfGPi9/WnT5GkoYqQuG2+MgoT+FRR1Nflouk9cYBIGPRM6pUOaMTX4M?=
 =?us-ascii?Q?Kw2DVlxaRclPAxlyhEtjh1pPstUem91UIXLRd8fhJLDGbJfQSYjOeqXNHziM?=
 =?us-ascii?Q?6A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8o+berehSSx9knrDA+oLucPdzUembzYTV/hcy2iKIN4JdWyRSQlWlFgPwXm0m5GA7aMjPpolYZIM8krbotV4fCAahixrj9f+/vdvfvNwGAOFy68Qp2Ilae3hTD5AAITLma1IWuVm9D8oUBMNXULy0WLp9dHjFJa0RmdfC/u3DkKJUnejLG1KU0kAv8dwaPwP+z4wkauaP3JFtIPbshc6rvWU9d90LO/NGg7WmQuXsfdZZvF0XEJvrMbuYKJqXKyAi2DNFS6EHQ1QsufihT+UQ4jYIpZ1RIAC9ijXT4oVw+e89KirRIlnjQmXhow/q/rD3cWRmCOzsVKsOpn2+L08VyTSkax5KtdmCp6mqpKCJzQQzdhmAqZeMJV02Z3apfHxJq84Yz9RdkLXq1dkP04v1riFIaVaUPG7pk300Wap2QB7jAAWgALQeBwljNLeg6FjRcmRCKwr1GNBhe99G9FpVoLAdUx71QfA/zNs5Jj/t7W2G9WqM5kBMD/pVrt/j6ezUsyzCe306/gmLKy14QzI0DGfV6p0XkIiksDpxCbBCdT+0eC5G10TsKHZWd+7FlsQtHMaM9x96kDfS9dn7QajaQU533UAWYYPkhM6ArHLhm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230f719e-8afe-48da-c65d-08dd4c3651e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:14.4265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UsWB7pV+xXr7J56YVCiBoit8RR8QPtatUlXoBfXx9T5sB1SeGP3khqXQMRxuCs2/0bJkMvFgCad/3c+4i9fhpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-ORIG-GUID: EH5wIuRUkuoLImZfL9-1W4xjAfB3xDiO
X-Proofpoint-GUID: EH5wIuRUkuoLImZfL9-1W4xjAfB3xDiO

Now that CoW-based atomic writes are supported, update the max size of an
atomic write.

For simplicity, limit at the max of what the mounted bdev can support in
terms of atomic write limits. Maybe in future we will have a better way
to advertise this optimised limit.

In addition, the max atomic write size needs to be aligned to the agsize.
Limit the size of atomic writes to the greatest power-of-two factor of the
agsize so that allocations for an atomic write will always be aligned
compatibly with the alignment requirements of the storage.

For RT inode, just limit to 1x block, even though larger can be supported
in future.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iops.c  | 13 ++++++++++++-
 fs/xfs/xfs_iops.h  |  1 -
 fs/xfs/xfs_mount.c | 28 ++++++++++++++++++++++++++++
 fs/xfs/xfs_mount.h |  1 +
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ea79fb246e33..d0a537696514 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -606,12 +606,23 @@ xfs_get_atomic_write_attr(
 	unsigned int		*unit_min,
 	unsigned int		*unit_max)
 {
+	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
+	struct xfs_mount	*mp = ip->i_mount;
+
 	if (!xfs_inode_can_atomicwrite(ip)) {
 		*unit_min = *unit_max = 0;
 		return;
 	}
 
-	*unit_min = *unit_max = ip->i_mount->m_sb.sb_blocksize;
+	*unit_min = ip->i_mount->m_sb.sb_blocksize;
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		/* For now, set limit at 1x block */
+		*unit_max = ip->i_mount->m_sb.sb_blocksize;
+	} else {
+		*unit_max =  min_t(unsigned int, XFS_FSB_TO_B(mp, mp->awu_max),
+					target->bt_bdev_awu_max);
+	}
 }
 
 static void
diff --git a/fs/xfs/xfs_iops.h b/fs/xfs/xfs_iops.h
index ce7bdeb9a79c..d95a543f3ab0 100644
--- a/fs/xfs/xfs_iops.h
+++ b/fs/xfs/xfs_iops.h
@@ -22,5 +22,4 @@ extern void xfs_diflags_to_iflags(struct xfs_inode *ip, bool init);
 void xfs_get_atomic_write_attr(struct xfs_inode *ip,
 		unsigned int *unit_min, unsigned int *unit_max);
 
-
 #endif /* __XFS_IOPS_H__ */
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 477c5262cf91..af3ed135be4d 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -651,6 +651,32 @@ xfs_agbtree_compute_maxlevels(
 	levels = max(levels, mp->m_rmap_maxlevels);
 	mp->m_agbtree_maxlevels = max(levels, mp->m_refc_maxlevels);
 }
+static inline void
+xfs_compute_awu_max(
+	struct xfs_mount	*mp)
+{
+	xfs_agblock_t		agsize = mp->m_sb.sb_agblocks;
+	xfs_agblock_t		awu_max;
+
+	if (!xfs_has_reflink(mp)) {
+		mp->awu_max = 1;
+		return;
+	}
+
+	/*
+	 * Find highest power-of-2 evenly divisible into agsize and which
+	 * also fits into an unsigned int field.
+	 */
+	awu_max = 1;
+	while (1) {
+		if (agsize % (awu_max * 2))
+			break;
+		if (XFS_FSB_TO_B(mp, awu_max * 2) > UINT_MAX)
+			break;
+		awu_max *= 2;
+	}
+	mp->awu_max = awu_max;
+}
 
 /* Compute maximum possible height for realtime btree types for this fs. */
 static inline void
@@ -736,6 +762,8 @@ xfs_mountfs(
 	xfs_agbtree_compute_maxlevels(mp);
 	xfs_rtbtree_compute_maxlevels(mp);
 
+	xfs_compute_awu_max(mp);
+
 	/*
 	 * Check if sb_agblocks is aligned at stripe boundary.  If sb_agblocks
 	 * is NOT aligned turn off m_dalign since allocator alignment is within
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index fbed172d6770..34286c87ac4a 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -198,6 +198,7 @@ typedef struct xfs_mount {
 	bool			m_fail_unmount;
 	bool			m_finobt_nores; /* no per-AG finobt resv. */
 	bool			m_update_sb;	/* sb needs update in mount */
+	xfs_extlen_t		awu_max;	/* max atomic write */
 
 	/*
 	 * Bitsets of per-fs metadata that have been checked and/or are sick.
-- 
2.31.1


