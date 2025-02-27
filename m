Return-Path: <linux-fsdevel+bounces-42776-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D38FA48772
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 19:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83E243B19E1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2025 18:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC61D26E962;
	Thu, 27 Feb 2025 18:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EUUMiTPR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BLGrlAv3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB01F583F;
	Thu, 27 Feb 2025 18:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740679738; cv=fail; b=iCyq6IDtif1ze6pwHoo2at1JnOMaxih90GohwgbAEDafrflJRs3PeP+uWOQefG0RZqqZpvfzTDayFIpO+PjZWkVVJwtF5u0K9fqZHoNa+Max/7bYu+XtbBFRpoquzwy70/7CJ0hN8nRRlBmzDYCbiLeAUU+5Rxi4f6nNa/CuAlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740679738; c=relaxed/simple;
	bh=WbNbJC+Jv06o0dJElj5AfpyjU0AaFensUD8vjoIsmZY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PWWzxMvOlbLwNb5EqUKn8jr7mlzSH3bhAgsNsojAZLEUh9751tGPnMbQK5j144/cI89cJ84ZQCzN2mS8bA3fi41QSIcg0mBMy7wdSkYbLx8AvHiXPI2JvDDE3kPxri0ysK+lTHr9HC9J/bEUntMg/XfMzuaUFtd7N2SVmtYJD4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EUUMiTPR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BLGrlAv3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGfkpT005586;
	Thu, 27 Feb 2025 18:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7/Ioky/yfctmoiTBCU0MxkRb0yPFCsEeydZWIa6sxkk=; b=
	EUUMiTPReRj8321Fsn95mnO9FQvYusfhKgvSlScF+AqASLg3FMS02W5iWGaKKEoE
	nZqmT248B7H68Ew+LlRWHR/nookJmxsZdwGKO+YhRW1sfXBcdPsWUSooKybmlXdC
	pntv2IpvV2RCCMyfmALRy9jP3VoVwszsnDSE8f3HNOsd8BnCYccFa9AJU6aqJm6n
	DeIC7FfUQPxG6ukMpyMY22Ry/Sn7WkvT9ptOZprq1A/XxjrqmCMmhMggjodag2u/
	lLVHpMm2ATuDZ0ChclzryF4XN0DKjpVLh4ZiSiviwWrjBxhxQ5fUZIc8rAoSA7Vs
	WY5W1Ae/qwX73ljkaLuF8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 451psf3xr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51RGq8cZ008182;
	Thu, 27 Feb 2025 18:08:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51jhqx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Feb 2025 18:08:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8cKQY5VuDhiibfcxyAk8m6uPlP7pnYyZkJrPbd2kpA/rmkGpArlkPXjdVyE+FkfDCXcrYtQoTvklNune/mYOWO0ui/ArosT5Ev0wVu10/FZRkKBoJ63hizyDWz2qDWa1MNmlWr44j3Q0sRCa/GrMpfcGwhsFFxVQBaA9EHRoDBcwkp6JW7xqNyqhuuQOVieFyqULLlwScDtS9KfETIx0cwPL+rDoG8JJJ+3PomXtGrcbTcjcQuJdqcAbM1mkhEzJC0zpnBvMJsgBWvIsihPg999Yrk+V9BrZxkrvS7l0Mfc6SXYGeIgm7XfcYG2ST+FCQbseSVcoTAqg00hd09J0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7/Ioky/yfctmoiTBCU0MxkRb0yPFCsEeydZWIa6sxkk=;
 b=cYugIPTUeUlMiCDMjjHD2XXQKsFlE4IBA5j3kZDKeN5qkVvV+k7Kaww5cWNBSO5UD7CUJT4+dM3IxaPFOAPiKJpQUrbFxjmD6O5FTT8rYxAvE15z0ZAZ2xFmM5k7VZI4wkdHBi0jfgSS5PHBwr5hPFFCdVzjPkC1J8BGMaq1ryjaxNhy55F9iTdkqCutGFy+Efcq0v33kgBGW+uF6cHj+0h+noyv/hAuYH8+io1ojwjcdWGVV6s7skSqXlfOcXYHn461/b7nTQOUzfXHOJygMRpHAkC4+CMDbITGGyMrwPqj6d7hSy5/2MQBLNl1ukkLiQBZPmDi7Gvc5ny9Fq35bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7/Ioky/yfctmoiTBCU0MxkRb0yPFCsEeydZWIa6sxkk=;
 b=BLGrlAv3rWo8De516zyclFbVZRafIqtIULeGwwoJEg8EOu/SNoszxudhcEAHqW2YoVjOPWurCI7crXNBdOkr49uXFCHq7rfrTwuDECM1q5Nextwv1Le7MgTfFn22LyMp8JHplaZF09eae3AXt25ORalMTULaP7OwPhM/YkLzako=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BN0PR10MB5031.namprd10.prod.outlook.com (2603:10b6:408:117::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 18:08:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 18:08:45 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 10/12] xfs: Commit CoW-based atomic writes atomically
Date: Thu, 27 Feb 2025 18:08:11 +0000
Message-Id: <20250227180813.1553404-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250227180813.1553404-1-john.g.garry@oracle.com>
References: <20250227180813.1553404-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR03CA0056.namprd03.prod.outlook.com
 (2603:10b6:408:e7::31) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BN0PR10MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0ec751-1d1c-440f-3c74-08dd5759c6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?shc5ZAFMNTqk+1ea2drL3FWXVG0z0GFwE8y7npf8ca3Hx11NAnhnT9i21t01?=
 =?us-ascii?Q?udYAyTc28XwqMnZVGrkTu/F4S/idZxsgUpmG4fRolYCJ1y0jqHGxd5N2MyMr?=
 =?us-ascii?Q?7E7G9h8CFvvD6L/feKJGS6nbGcpSgJIirqQYsF99HF22ve/niaabeC1xiSJt?=
 =?us-ascii?Q?FnegQOPz3tRQ4T/ofdbAAQP/84/wMBdFnMFddW/ZOkb1k0ugWTEeXhCnSB9d?=
 =?us-ascii?Q?k+IaZqSiLWUVYaEM2rvg2eeRzNGnjn3zi8x27hazI3dZZ3WscLgmdDV0PK9x?=
 =?us-ascii?Q?bOpekihPnqmxs3knkkw1xIWbcFN7zRxmfuqq0h/IVH920ELgO86Wnn+BgPCm?=
 =?us-ascii?Q?8GDtBPIYEYgBRWqxdJaaXMtNpr9J7SA04ldZk+2xFUl8EOa2FIuc/Tb6xQNw?=
 =?us-ascii?Q?wyc3gTV+rWReoZdpiYurNAzJ5jw6QJVvl0OoVdmcLLCNe9bYvP//1kHjjHMI?=
 =?us-ascii?Q?kFQ1uf6KHYBtxddPi/JRdvQwZuHzu/P73j28KuWAYCGzK3A4jcDpiqur6c87?=
 =?us-ascii?Q?oeMYatV27uzLVmh33iFSWQFtyrsr50ZGgCiCGVU5LioT8iGxCaGqR8cu4dhf?=
 =?us-ascii?Q?OcgSzaccY7Qk8lJrmukHNYqWByACgU9bNXeDTa/yArEhXhQGoxvAdmNSImsX?=
 =?us-ascii?Q?NVOzozjmtCLXMcqVAbwFHYGmTI88w0ry7LU7flGaFUaX1n0ATCzZlKvqGJYq?=
 =?us-ascii?Q?NWGGmQTDgTab6/htuc23fBpivjaMxkPXpTpvTr7LQF+iIhN3AN3Ox25O95vA?=
 =?us-ascii?Q?VqfR1/MpzXvb0wlH0GMVEzqj3LAVWkPp5sS1cl2fRVmNA/xl1KOn56WNsC7q?=
 =?us-ascii?Q?5bOrurD9LIJzokZQUijetN/E/8CXWL9PF2oU5FS0p/spZGKAL5qpD0RreNVQ?=
 =?us-ascii?Q?bLDA3+JG93qybNiAWiT9xKxhp50I6lxZBy8U4xlkPVq8CXyZg0LqFNAne1bM?=
 =?us-ascii?Q?JQsO9w++GxXBbe+2qXDrvzp962/EWJUmXe0t66jyzMMSljWHvNiQTmZerjox?=
 =?us-ascii?Q?P7NWdp05YbIlzLwa3RU9BeaZQ4F7clOJxipbHgUiIt2VJBaJQhlyI/x03dUI?=
 =?us-ascii?Q?OlTLY593sYQHth63Ns5zKtKMdksC+7i20TSDPVzwMxRG8cf3ri0cgqejiEEo?=
 =?us-ascii?Q?ScoW+oGIbOJyx7E/+DfixIzzwc17o1GR3gsouYurvOBHLgmRSpwfcAhhxt1s?=
 =?us-ascii?Q?MWkI+/NzIU4QyW1NV2BfBjxNySKV8fS1CtmIWzEQQGQ9pmbNSxErsVUiyViE?=
 =?us-ascii?Q?cESpl7HcxP7qtGQgy6sclEyi6mzfpNNEyDZ0KVyZPCmMbQoHvjFsbiLtsBS6?=
 =?us-ascii?Q?J3H0OYwyTcV9jrBFa2qudhuGKc1Tcfq7vON6FpAkkdZuqh1ctxCBwm1t1ABw?=
 =?us-ascii?Q?aIazLopE+M9ku5nM/kk7Ty3US31b?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AVonkEBbEBLn6Vw6EKtQLAL2KQyiDWS/SJESuhFZsYxKInOEoxH+jTBg+976?=
 =?us-ascii?Q?MPh6gdWFR16gzW1ZKyqkiwyv5C53a24nea+N6mGVBw1clcYgSElhCjCsI4h1?=
 =?us-ascii?Q?YbxqfoHQTvBwodWbumjT9JheH4Zrwx1t8bUSd3JcsEf7+sbjVbN8XRqeOxDZ?=
 =?us-ascii?Q?04voP2NwPa5cAQYyCP1oO2DsBKFmDM/FH0bfDmdw7YH5nor/3EUEchPRvoFQ?=
 =?us-ascii?Q?xJyA4c13JaVUColT4JBQryDO9kZT8vWsQFQzFz0chl/vSeliRsRcFqRqBAFC?=
 =?us-ascii?Q?GxnItNdPSZXJIul2F/RtuP7NmMk29uOf+Eh2kQNhOfWsQPX0MzbZ8+UoBgir?=
 =?us-ascii?Q?tIWIaTRUwoIHgNuzSzT5zVQMbC06NiMjqwnR/5hMy7QE3aVp/B1OIYNKVvhM?=
 =?us-ascii?Q?UwEeE1alBMXjKdPzsKWrTr7ZHi8zHyIKzbyeqyPhldO3HBHqcYN1yslOOPJH?=
 =?us-ascii?Q?20Q9ofZ2LbtEcKcOB3bk8Jz7LCGQDohPJ//4DCIngqu3sJ2wQ6JJOB+eXuPt?=
 =?us-ascii?Q?fBQReVIyezvyUyuMVZOgKSIW/bPN0pBIwa1HGNzlfoYWl9p3DwvmUlcelQdX?=
 =?us-ascii?Q?FQDewP9ddbWIKIuEaOkUeLpHuD47zC/VjO/Q4qHy5UhhSlhJGdPAvgMjAyZ8?=
 =?us-ascii?Q?IGP+T6Z/CmquYO5271LJbu+tRLLCOw8gjxIvPcYbj90BRNAgdfYzaWEmqbFm?=
 =?us-ascii?Q?Iz5pBxuoSEkzMlhNsQLNPMdnU09KyxE0UJRqPhgQeK7Ghke4iI3MevCUtWnj?=
 =?us-ascii?Q?PDispL6eTID7Z8O9DPfQy+sCMLw59Mliaq1024of7/8NhKVruUw9B6/5k/h/?=
 =?us-ascii?Q?rc+C7tyXXVl2uO/dXaAFwOtlipztAGOmdvZlHsVKI0uunp2xlXDieZMq7FoT?=
 =?us-ascii?Q?E5Quf9YzbM0Mv0O1yDSqLiHrdOfSFGaR0rQ0akvMNugy1Oq6MGou0VqRIx5A?=
 =?us-ascii?Q?k7TBdqq3hTD0uY/1FQWM7gO+DLrurZpqf4WHrF2SNdU/PcSFOKTdwIb6WGNO?=
 =?us-ascii?Q?zRkh5xgY41OPWQEO/i629C0NpSUJ2NmS5UZV9A/FfSaImkdMjxTqt9R/IUV8?=
 =?us-ascii?Q?k26JqB2XMxAsNw9cAw0im58DB3z2vYCtHWX4UUgebO+8Au3bqjsC+jaq1WGr?=
 =?us-ascii?Q?ILC8el2Owxj7on2ddC0voPFXClhjjSZj9Cv19sN81jAGfTjbTl+DXl1tw+HI?=
 =?us-ascii?Q?rjGuljLG5OE9xtCSdRBRDp3953vE79R4Aje56YnyFCMQTYxbs8unVkLwsPtN?=
 =?us-ascii?Q?BbRGHnKy8Bv7z5C6zWkRpnbPVTEJMEu3to9YiMlcLOs/2hFzUCWLKYdJd04/?=
 =?us-ascii?Q?+7/Og81aTYId9lIK3r6KK5U+N5kWOUttSwW7lcpvgbIvBLtZdlRjXIcULnCt?=
 =?us-ascii?Q?2MxL0PnjBblFs2k9PUFK2+quUL7VlQ6xnQVmEGaEx2G7MoP/QQydIx+4kXvX?=
 =?us-ascii?Q?91EjfxvtoAWCAuYMR4T7kw0/BM1+q9+hzRNQQcaXlnPO0rADdOkxYDXMckkF?=
 =?us-ascii?Q?qf6N4vM5uyxMxCY/4OR8eNOjcgnlmcifQ5rldd7orPC7xupYt/T/FvvnygCJ?=
 =?us-ascii?Q?QgN8Hkuyi25xOsF4NkpcygjtK1Z2DwkgnS1vHdJlkNkvtF2zG0/E31pcs41L?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iAyPX2dV7ntTzwXsez652cecGcYQkCKNKuW7E0yeU5/q1OFPSsZHhkPtym1AA3o2LA0ogRXtsT35Bhu5CZerSVlrhZ6xTcMcTP7rCfJUuyoZDq8atBwK3HldTm5iTlIN6aHJqzRt8EgUpfBSKdnt94NtO020ZZEVNIUVGOm2ThxZ1lTeZAdUzbfGEAEG/nHeNKl7/A+nmVSEgJSrmDTo7jyX/36qJkUVPRrumpSuaVz1S+WQGTOBmH5AYgMdqGirYyCOkNjzj+UObTTmpjwgwN36eTP1MEsLDTR3i/Gy+qlV26X0cezKs5e0Df3ThoLlYxuDPDVw1vNeigBgYVw2qt3uQSQAWpK1M2mDxGsTuBO8xejr/M8pZV9imz7TCN0+tInpAV34j7pX2UQ0qTIHqrVXDWVb16/OYNg143fFTMDwrBTK4fi/w2d7uv+MsDpTLjTPXEiBrXow/FOF2yWN0L4aEm2ceip2r98efB7SqPBL7ZP8xKJCsFrrOCHl+t+VhQ7L+vvYkzKxwC9FLZZX0rSRnzTwBNmeGNzE0Hm+V8XAA4plRKU8CVLVaUvEJ7G4iKKPIEbV8AFxy9lNA4exFGl75iyjZIFZlILYDCLVTSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0ec751-1d1c-440f-3c74-08dd5759c6ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:08:45.8739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cVldH+DMoJ0pxs6ig0N1m1y6gsYH9po6L2htwMmqzqVQ80p7EC+PvDn+jvKTh8iiJCEgWgqKSO4y/zVoT+VsfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5031
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_06,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502270134
X-Proofpoint-ORIG-GUID: nmpzOX-lUVIg7AW-53yjiNaJL4RnKtH7
X-Proofpoint-GUID: nmpzOX-lUVIg7AW-53yjiNaJL4RnKtH7

When completing a CoW-based write, each extent range mapping update is
covered by a separate transaction.

For a CoW-based atomic write, all mappings must be changed at once, so
change to use a single transaction.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c    |  5 ++++-
 fs/xfs/xfs_reflink.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.h |  3 +++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 76ea59c638c3..44e11c433569 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -527,7 +527,10 @@ xfs_dio_write_end_io(
 	nofs_flag = memalloc_nofs_save();
 
 	if (flags & IOMAP_DIO_COW) {
-		error = xfs_reflink_end_cow(ip, offset, size);
+		if (iocb->ki_flags & IOCB_ATOMIC)
+			error = xfs_reflink_end_atomic_cow(ip, offset, size);
+		else
+			error = xfs_reflink_end_cow(ip, offset, size);
 		if (error)
 			goto out;
 	}
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 97dc38841063..844e2b43357b 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -987,6 +987,55 @@ xfs_reflink_end_cow(
 		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
 	return error;
 }
+int
+xfs_reflink_end_atomic_cow(
+	struct xfs_inode		*ip,
+	xfs_off_t			offset,
+	xfs_off_t			count)
+{
+	xfs_fileoff_t			offset_fsb;
+	xfs_fileoff_t			end_fsb;
+	int				error = 0;
+	struct xfs_mount		*mp = ip->i_mount;
+	struct xfs_trans		*tp;
+	unsigned int			resblks;
+
+	trace_xfs_reflink_end_cow(ip, offset, count);
+
+	offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	end_fsb = XFS_B_TO_FSB(mp, offset + count);
+
+	/*
+	 * Each remapping operation could cause a btree split, so in the worst
+	 * case that's one for each block.
+	 */
+	resblks = (end_fsb - offset_fsb) *
+			XFS_NEXTENTADD_SPACE_RES(mp, 1, XFS_DATA_FORK);
+
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	while (end_fsb > offset_fsb && !error) {
+		error = xfs_reflink_end_cow_extent_locked(tp, ip, &offset_fsb,
+				end_fsb);
+	}
+	if (error) {
+		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
+		goto out_cancel;
+	}
+	error = xfs_trans_commit(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+out_cancel:
+	xfs_trans_cancel(tp);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
 
 /*
  * Free all CoW staging blocks that are still referenced by the ondisk refcount
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index dfd94e51e2b4..4cb2ee53cd8d 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -49,6 +49,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count, bool cancel_real);
 extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+		int
+xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
+		xfs_off_t count);
 extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
 extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
 		struct file *file_out, loff_t pos_out, loff_t len,
-- 
2.31.1


