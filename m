Return-Path: <linux-fsdevel+bounces-42774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C51FA4876A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C15188D66C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1042E26E16F;
	Thu, 27 Feb 2025 18:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZSiIf6vm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eHL+HbWl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E4B26BDBA;
	Thu, 27 Feb 2025 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679734; cv=fail; b=ooBybVVwmC2HFKcqv22wCTV0t4En+Diko5BMsAn/COSbSd35S1DsF86L067zXCp17GLUFgXUXo+zCtke8U5olLgztfEXaDSgHUPB85NzLs5Ox6AdaScnt80t1UKq/gQh4k1ZYLfsAcAwEOLCA5Im2MzlCzPtqr/P353ma+Nc/bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679734; c=relaxed/simple;
	bh=IuMzCqyBJrm7FFhkNxr4QlcsicZX1Q8oyjS9x1MwZWg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n6HgjU7u6q1NcpIstIB/PTQEe+XGbTV0rBxd42uPhYGsVDq+z1+HdlMiWngtjcSZesBijjDimR7yOELYQslGrtqzXwZDo7KytZtNRoMi3uZHTTXKTEex2sa74SMcdvVPKWQNQBAZs2WMnBlWmPKo3T3uDIuywEvJzKI74yvCt38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZSiIf6vm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eHL+HbWl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfhw4022896;
	Thu, 27 Feb 2025 18:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=ertBSWJn4JQRyQQTuCIhXXQ1MGBn7QCqwt6lYQGslLQ=; b=
	ZSiIf6vmsaRyNTZpntBNuixODYnyxR66r0AXCO9JNA88Uj/JKnC/qS3YxeTupP0v
	WTAD/3eoYblrn5FNtFnOEYE4vpqayY+ed3vEZ34FoNiwndUG4/DgxoUJMMpJ/DmL
	/9ip8T7E24f8avLhIBim/ZuLta3bP9QcdJdIum+4kplUgUYYOP387Sa3sM0CL3ZQ
	31MUCK+xFs81uE3fK3lvSHsllX9jsVmX4td+jbLqOiDHGbiXsdRU+oouYurJWWBR
	krv+cmVgGWoxlnVMKZ2Qq77530/sJPXOYWpm8J/9KMZ0hPhRN94MLTwnXvvZpVRv
	raYXoiZeng6jPl5YW/0Zrw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psfuyqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGoJJh002784;
	Thu, 27 Feb 2025 18:08:40 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51cq1wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wud2gHot+DWj1J0RrHwaCqLOJd5BrD9ILDyKx3fTHrjHVP0rCBdYFGmw9cl+Yyx1RVVcC7C/wGV//bVZ9GqD8XEPf3+q83NMp1eTQjj8Cyg0jYd59vtzUhEx27nnxdqpSwpkKNu3zcrMhYb+ED3pLKu4rUD0sxSh9nporMJcTRqEDs5ADbvWRlwKQ+dXKClF26gkBWku3NBAgPJPZ5T/LzYSjOWgU/Z6AxjBnPyQVfB2TACBDoZAaJafppei1y/mcEte9ZfehuWGjOCEQGnlwPpJqSirqhjJc6yZoo+2BBSmJkVMzHfqraZeFB2VtySGdX5XGTeRiv0F+R5CP5Ti7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ertBSWJn4JQRyQQTuCIhXXQ1MGBn7QCqwt6lYQGslLQ=;
 b=Fv2OhHj8IzNbD3jb9lMB8wBkCjKpHsfFA8+3DpQx3XE82pZ+kW4Ltt+uy0P7EZ2A9Sle6JG2Z1f1DDB0HUgXlpi/EnCuEvPUcJho+WH6+scJhgC5Kr4wx2gRQNGROCbXJFPVKpJjLaJMO0AKHi/7HxuSpECo8N3eB7flud3WBYN1/BwbqxzgnY40sOg+tbH6chDuTzwzw3MfKAF7nA1Hzaa4YBsReroYPkQ85rIKms67Be85d9V0TjaaZqoFuPn14fpzV+YIifHo63BFOQjYP9sM2tnIXiSz6hrdXdn8H2tflUbQFEykybrkaGnm9scBMp4TgS1WWRBmvpguYm5Jkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ertBSWJn4JQRyQQTuCIhXXQ1MGBn7QCqwt6lYQGslLQ=;
 b=eHL+HbWlFGh7b2BFg1pBgorjSRQ717wfKqnEr8Gl3OUbOl8FkwRYo5vaDuggB8/smsYlZxyXyIhbxN+nJfg/6gBRtXy20q8rIkinX6HdYu5e7hEADL8X8KAf0G22f/nzl/PGEFPGqN5TQ0X9qCEEN2AtRmH0U28ji/90wuPUcT4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:37 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:37 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 06/12] iomap: Lift blocksize restriction on atomic writes
Date: Thu, 27 Feb 2025 18:08:07 +0000
Message-Id: <20250227180813.1553404-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0144.namprd04.prod.outlook.com
 (2603:10b6:408:ed::29) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: adcbba36-d1d0-4ef9-63b1-08dd5759c212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8YB4+ph3F4aoeN8shBrIkciqx9P3Aw8uDOMLBhOyrHUc62195pLqY6wpVRx?=
 =?us-ascii?Q?clslUMRAYaDUClvNqJqBjzivtMaJ0euEediExuxLSK6mZ2D8lY10y3Q0nusC?=
 =?us-ascii?Q?NSHb6is85b52I/ISUvYNDsCwd0SixtOSPGbtat1/BOhkUSaUfppxWXb+6C3+?=
 =?us-ascii?Q?yhf9MJkWn+llxAWYqx+t4edNxWKs4JoUPhQpuY0gs4wDxFYX+1Phs7hxajB2?=
 =?us-ascii?Q?LLxkHClturTZNj0jAvoAcYElUFpPw0n/hRiGdUq0ZHGc0uWFAprquq6ukZLq?=
 =?us-ascii?Q?qNw+Z1JCsVsBgHJ5SkgGCt7K6DH/ZGtmjzHZ5e3C4GO8exJd8QoNXz8yDWDD?=
 =?us-ascii?Q?GjwDlj9D+OzyZjMfPOTTuK23jLMeunypLkJO62d8svG5MPn99jayoepyTPLg?=
 =?us-ascii?Q?xed0C0xM0ye7x29yIfUPJgA8orXU1OG1jDyRAzHBeZd4Vf/oUFPGILmRH4kQ?=
 =?us-ascii?Q?36pH5Sp/KAngMstUZxJXr3dYJq0BKfcaUN9QGDQEs4UhotkRfMs2Zv7gadxF?=
 =?us-ascii?Q?cro5CQyJFL1yTU3KEgd3D6GzbshHI4dcRxZ1v5DbdSW9pNQP7CQCzDLPHNNi?=
 =?us-ascii?Q?U6vPrmlj7Yu71td0b/iRUhvfm3F6Ar1GJ0e22DK887cmAIoYuN3nFnvmnuA0?=
 =?us-ascii?Q?ujr9veJhtiPMd3vvlZNGiK48WEB22HKnl4rsnl0eV4mYCrtzxxkUoarGmJ0D?=
 =?us-ascii?Q?baYyBOPh7FIR4L/Xv+5bOtbSVbVAm1VPtmkCCbWd+4RYJBFwmKILy/BaxO0J?=
 =?us-ascii?Q?ZX3xI044F5CtBorDNJY35AJ1L9RKaKl5pq9AGJmCSolMGxmGhS4FwunZSCuC?=
 =?us-ascii?Q?ITNkGwgBOy453j0WGCZhkkXCwKfSgZxgGJ31xvDUxgf1u8hUIZ+qh80GtFwY?=
 =?us-ascii?Q?F6whMAtalxawEsxq9rhdQrtEoOznGzaaLARcsNHemUueFNL0s+/pixSTDeS1?=
 =?us-ascii?Q?Ccoy+ndKOKkpDbjzCDxgPh24kvOl3seOCu4PT9p9vl+aEqPQeM6DACz2B7XN?=
 =?us-ascii?Q?vBh0fGWb1aaZmMO/jDHRelK9i1aK1KlSgZCfougdL4wEDiBH2uFMAeg/5xUg?=
 =?us-ascii?Q?ST+vgZkoltpVrfMmslIbkQ3HTqkf/VOJCcVrezy3XhbdurCcErweGDdU6fPx?=
 =?us-ascii?Q?wy7ox6XZMBRqSG2UGAdali0/R35yRMuUs+H4HOwV3A4//tvJRwvw4csT3TB/?=
 =?us-ascii?Q?akPsThHUQf2fRjpm9t9nFKW2XBNuJ4XrLRNSLT4f93u64mLuWIgGhf0p1kbm?=
 =?us-ascii?Q?eGiyU8MKmIqhX+FBW6IvRdUUvuy5hzaWdTY53feZUsXyWTq25pLNo10wuvzc?=
 =?us-ascii?Q?0RNUNvC/NMRCUUe5eOGqucsNrMfUsd1I2541xtjhFlUq7pJcCyh2GIScaCqG?=
 =?us-ascii?Q?+1Yf0fxzsV+IlfbCWiNPbKIVNMj5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BKWYX6jvf+y7j2AgaZoIjr/aVuZGrgaZzBwyeZAckJkyIYkMijKnXVnTksrI?=
 =?us-ascii?Q?Eo8cnJvLXeL6wndi8mMsYs6HCFgxWSWCx/s4zG6FNbJDh+By4iWfGqYKIeqs?=
 =?us-ascii?Q?weLFQjGDvT7o4lmC1FQ5JtVNratG5TaF8LOWRkbIZSK0XK5tx4ayIhoJvR6k?=
 =?us-ascii?Q?jYIEVyxJvs0dE/4ckRwPjWphwxOi20SIfxwsc+ZBhIasvDSVivH5Me4XsTQz?=
 =?us-ascii?Q?Qu5yDxyUyhJa4I8ImmjIRXBQIaxIxM/YNXxCRoHu4R0Ww0B21xF0qYbAqcRJ?=
 =?us-ascii?Q?hLBibU6W9ZRxM3YtK+7blwWcVO/LVVvhPwqo0kE+gKYmZzs7zB4ohS9v9nMH?=
 =?us-ascii?Q?zx6Ai7pIZ7B3BewS9zjmooqNLvbYfQzlKG8RjJFToBDbeTt0SF3i8WU0Gw9C?=
 =?us-ascii?Q?fXYBOxByZGRqucgkdO2QRyokenI3A4eXlKrmT7J4sF2Js78TXEKJxs3I4Yp8?=
 =?us-ascii?Q?BqUd1OwO5xAUwaHJ8y0PzH4gzmlGRS30+zv7U/5Fm9VuI90OI0FxKFz05rAq?=
 =?us-ascii?Q?nqSS+2Obc8XPXsw46GRXKIiYSG9pk9C3VIUrSp0/medZhd5gndgwzaONfF+9?=
 =?us-ascii?Q?c3pkBxUfW7o7eDfc1gS35xYDFFZBck2VMC1/8i66OeH3TJTGW9ifDKapnGQC?=
 =?us-ascii?Q?j6fUJrObKcArUrtuEPqhyIk62+cn77rvtrSVg4xZrosqCeuaUPdmuTPgC19b?=
 =?us-ascii?Q?oZmHqgzrryKJQNmLBV5+N3TtxcksnfqCA7/UIOyKfOsxFVdGOeVWNnVnTbJS?=
 =?us-ascii?Q?lib9Z5Y9brm05BPC+i+XYRSdcl1A5PCRu5JDhZkrTAVaO59Dy+SSomaT50jE?=
 =?us-ascii?Q?iILb7mBr6YEV/zajCf9hzoq4c2Nv1aJ00rpTYfBuHTLWwANskkneUUlWNDQa?=
 =?us-ascii?Q?AXm3usKISq0p6E41jmYFQGmR6SFbcNWFYgTyqAbBnCQUKTJ0U1bc/N39le7c?=
 =?us-ascii?Q?9ZKqzWhgd3wHRcA/XbYgWZzbg0Ry4yxYFq36aRAPPU3e6z/IawiRHhC9+6yF?=
 =?us-ascii?Q?RG3kIHSsaVMyrpmmBcFTx++HGsEiJ1Dni5SGuNpESCeToYmAmW5DHU9qBZOr?=
 =?us-ascii?Q?6i2Lo58MH0xToTM9tu+VFDLpWIfzHnxfsuGFbVjWE+FM5Vzx3YBHy/f10Dxj?=
 =?us-ascii?Q?Uv5mrMMrUG4oXcWRaKbm60MxA9rtvrus0ddenK0XadQnkQDFXnv2WTGX/zrZ?=
 =?us-ascii?Q?GPtorYaRw/9elEUGQpQRUfPbwO2k7jXKnI5rU41rAJLyhKBJMVO3zzleoQMx?=
 =?us-ascii?Q?or/evyZOsGSxPRwqasX35zbDeqwlZWWzgQyqPvRheUzSRlAT4ygLGQ9xjiDi?=
 =?us-ascii?Q?lgQkc/HJ1FR54t806uOdu4Y1VdcJFmzkyfA0y5oGcko4LoLTy7qyE5Vbx7wZ?=
 =?us-ascii?Q?8iYPwnoAz68wFVAVPL7aJEIFzxUHNcS5bQBDCqchePJO2YhY0dR4tt5xuprG?=
 =?us-ascii?Q?EZO1ALFYxCTYM1DBCx2DEltALrr/vxun3YePW4aQmvCsBsICYXl4eOHvgi4X?=
 =?us-ascii?Q?quJU8owO9BibG8lDQTO7l72sublGRVYuYMVSd/iVwVrkMWKQcADz56UY7hpy?=
 =?us-ascii?Q?NszjtLyvDXF5Z5LkoG7OJR23REx9GjqdNfUkdCdryx9keD4ZFH3XO96wbmVT?=
 =?us-ascii?Q?YQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HX0JqGC4gpglX7fhq2m83Z5eLsNwZqYZvRKo2mWgqUx65bhmDkXFM4RdfBysQSU7va5W51C7gbR9UTy2ErptvxoTHNo7kv2pATvVg3nJfKO+o8pMAaQ1NaMyHbj94cWyGyrMn5gqya5Cjn5qVNPmoTVmoauy4JaBetlh0jHZN6W8FWWWMp7x2NkoxeS/4hAa9iOr//dhDxJq6o4K8lIfHufnw+98FiGp7kGiYSgOcRU54V053wDrxKiGfjvAmM+M24KUhPQR+lFaxJWmQZbwPbjZ9zzcpTo9inhOVVRdDjVk1yKAnn2hBdT5fJhY/eriYOs6Fnr7qGpF2f59/y/IuZRYMBXR20ccb9oQE6liDnu4E1eNYgRGXNSRVQKhSlrESLBUA4SQbdAROK9DDqJjDwVce3l8LVTWwJksca0rT5FyHUeer7L2jJJkq1s6pA9BWNlL7wsppdpP0H3CL3MfH4bnEqY3qvgT/UU6EPzoJ8srCC+AyLWoyXbfAqAa28mA7bXzJLRVAKUjUZyjXt9AoXZaBlZknPUgHbXtvkaos63eTH25Pmrht7Hww9EkWuDBbJ2TAH95oW6KdBbjOjTFPPEAhN2zn0rjj8ST+fULAbA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adcbba36-d1d0-4ef9-63b1-08dd5759c212
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:37.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6+9J+tX5oFhmg8oU837iResgFFg6yar/3jTv7PhbV+b+uJJwzxTUmUXdX0nvbjphDfBdac2r21x135II6jegw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: 66g5x8U6e2UWBoG9C__zYSGPGKXqKG8L
X-Proofpoint-GUID: 66g5x8U6e2UWBoG9C__zYSGPGKXqKG8L

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Filesystems like ext4 can submit writes in multiples of blocksizes.
But we still can't allow the writes to be split. Hence let's check if
the iomap_length() is same as iter->len or not.

It is the role of the FS to ensure that a single mapping may be created
for an atomic write. The FS will also continue to check size and alignment
legality.

Signed-off-by: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
jpg: Tweak commit message
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 575bb69db00e..96520a38b427 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -306,7 +306,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != fs_block_size)
+	if (atomic_hw && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
-- 
2.31.1


