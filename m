Return-Path: <linux-fsdevel+bounces-27941-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AB4964D96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 20:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 846A31F24FF2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972481B86D7;
	Thu, 29 Aug 2024 18:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="im4pB/EU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x1+2vH4w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12677198E75;
	Thu, 29 Aug 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724955672; cv=fail; b=tuWWfWL6JlXWF31hitgUswBNsFXtEoiGZNZYEWyIdRWg4CcBU818Y7KPuM28WDyCOsvdnyQnmCWRoKoY+qiwKArV7TVbgELlXxg0ULXg7q8L3Kcp+WbKSJ4tUIHzQEdVi0wKCnQaIHeMIMZGgDt8Jp/J5I5mQXVq4ftcoT8mbHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724955672; c=relaxed/simple;
	bh=nGT6evaGzDBmswBqOiHfvI9s7byGTPK7vgsQgpBTOYk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=ggIFIMD88lCmhv2M8n5r05XQibe5T8WYWKI+9baPyUOAN+4sYztj8JSLRIwOT3AviAzS4tLcsMxe4M8/YtQLlwzoYnaoooapiVHqkkwvmgEwgn7TkZpsXabXguztqbbwUtuR0L7A8Erz7ZlhfQEckTM1IqESJwnpElRcaC5jBCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=im4pB/EU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x1+2vH4w; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TI8PMC031735;
	Thu, 29 Aug 2024 18:20:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=N1kptjoicoKlEw
	lxz6K7lmP1Wspw+WGC9d1JYaYvUCg=; b=im4pB/EUw6RJi+iFyf8EK8Ehh1jm4K
	gQdujl/20eYgHbFzWZM6cE2k15qeT5r0qyNA4y3vVgMYk/igxHF5kRKlrVAbrwyC
	+m7Gu9aHRqXXam32LIyctlwZQD6YEnd+t75CcOpiSjeTv7FkHEf9WuqOpAhcS7TI
	mWWkS4jAMUZlf2UR6dBrs4TzgXxR6p3ch12/2b0PJQlpoewZklOJH/zK7SAnWz3p
	Di9aeBYpkfTLNu31LkDNeGia2p7PVpkFkEXiIUI5Q6mXpcBmiEbgITnZL/oo4u7N
	2TcQ1CyzZzVMxyzbn4YkKZxqXg3r15VxjjIJeo1YnaWXsSCI6nmaldEA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41ax0hr0vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 18:20:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47THfkse034714;
	Thu, 29 Aug 2024 18:20:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189swc8ce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 18:20:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wuv3j75VxkXUhXPTMSY4VF290UAjAz3mscbqrRGEWpz6Efyu9gYM7XRo5ARDDT32PkOOuls4CBgbq4XsTs3qjwg5rD7dPrm+jPKfsLd6yAYfaQzYCKfMA/ZdSGu5EebpXY3QJKw1D9FXagdwLUb0/B+yroLTt+NYIt/vFfHGdTz06i8wIhJ8cXV67//qnZsAB8mefMGk2EKriJD0YWXFZkKV5WG7WWmK2wDH0A0ioHSJv0cPoW5yoXKLcjD8jbXkEnN4uod6zjGRu1KAmWPkjyQ03mA1zcOhuclbkzoVixqrBr63YYLDb8xj/TWSCP6Nbwys6wz/u8MUJDa1C86ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N1kptjoicoKlEwlxz6K7lmP1Wspw+WGC9d1JYaYvUCg=;
 b=mbcpm8E7tntEcPAz4imFWYfaMSzSxKQdE1PyUf5/0hjLQRZ/f9FCrNLt7Lbi1IOoT9le7u05/tlOcB/01WR76NE7Ms2Qv5gtLO+3WKsmC0y4vkVrUWPRUEgrIf1Qzu8AoXGyy+YyWLzvTZ7i2eC7tEjfIsZD8fjA/JBkmryim5rCveO9G4mRecDz2xh0aA9WT5VpRVcIQOiM3pkr9ju0Ng5w9phLvlIsij7zBu9OBsc803PVyKEQdnCl2QUgHs+mxtchHh1UcEUURSUNJUbCmkyqeNHBE5JdNiCxXwGjiuLzdJnzFx8dnHaIOuw1o0dVdoDF8IIrriyqfhQ88/QZ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N1kptjoicoKlEwlxz6K7lmP1Wspw+WGC9d1JYaYvUCg=;
 b=x1+2vH4w5aZUvsq/qFX/ZvHl6Ql/JLs0vkT73hSFMZi26OmxByzzqsxc2rxvX7NBL03KmwPfHIH1Y5NwaHjIOzDPkKw3OkxNETMBGXy+GrbfsmrNPrHrCWDpvOOCsVga37DNRNJBOEcmNDAq6Nm8tSnbpIEYBZywUhRgv5Jr2jU=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by SJ0PR10MB4637.namprd10.prod.outlook.com (2603:10b6:a03:2d6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Thu, 29 Aug
 2024 18:20:51 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.7918.018; Thu, 29 Aug 2024
 18:20:51 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-debuggers@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] dcache: don't discard dentry_hashtable or d_hash_shift
Date: Thu, 29 Aug 2024 11:20:49 -0700
Message-ID: <20240829182049.287086-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0379.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::24) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|SJ0PR10MB4637:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d77618d-ff73-4ac7-c66a-08dcc857501f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5jyWZ/HptG/M5AokmKeMOIThOxd0ZH2/UWzCXwQ10O4QWajDxPaBzw5NHD73?=
 =?us-ascii?Q?vLNzGBRhTFp1HWbqxlyvjGFGBbMht+Y4IXRuK7+y3Im/bp3V07TRtdesWRKH?=
 =?us-ascii?Q?8NSpSGKkW+qhFZek4lkLkPqkhaXu5pvCCNzkOkZq48mTHNoBUcnVRxZAMiAE?=
 =?us-ascii?Q?E60H47eyJdVcHHXK4YotuXMPyDqcFTAmZFRBq7xDGZzH9R04b7L0Q+kGng1S?=
 =?us-ascii?Q?jZBl1XzpD8d/vYJlAght9miC1qcc4S9YRIHox9labK+7l/ogI5gEn9HKbKuT?=
 =?us-ascii?Q?u2VQLPd93ak88WtWXoPYwza1QGHiIoCzGyvQYldwCJrnSYWWgMRChR2imgE+?=
 =?us-ascii?Q?jzdSokVhaQ4GSmgDnhzxTSN6bhWNeVA6fFIaFc51fzVmNjTr/7hCH1P+4WIA?=
 =?us-ascii?Q?Plp6oMnCtow8ppLjGVhGnHQUUP32ircBlIui8DPxyaycxS6na4wLzeFajx8M?=
 =?us-ascii?Q?u+8jWFnnJfOR/b4/7odrwu3IyzrhqsCiaYyeOF4DyFA+n+BLOG6eV0dHiCES?=
 =?us-ascii?Q?DXl3WoRnAKlOTMekyYTkWkS4jly35/cB73QIP46JCJOp+hcCzhj5CfIHH2vc?=
 =?us-ascii?Q?c4EtGOjQgss1XAOoP6TAipBohIEilxcYfMRWzxTUIfwrvgpNJkfjaCSwPhbP?=
 =?us-ascii?Q?99xLYYKsuzowiU8lGRCD/d5oiJypb/7W9vBCpUxyS9V91c8NTX4qf6taVaOT?=
 =?us-ascii?Q?r3lxvOAHyeTexFeswBf2KX0Li4mxnakpngDbwmgjPkKv0Z4gs+1jcphjcVlk?=
 =?us-ascii?Q?QmKLxvUbwTuYapfDKmSAu3tjjBUDlpmCeXm9CDZuD1L8wu/vaY8HlLIOkZgL?=
 =?us-ascii?Q?pwkBzyWWup7roLtm5MAK5t43oCkFjMyEzBtgHK4gwAdXsdO1DAQy6y88KFSi?=
 =?us-ascii?Q?TREDon6wqlK7e27cqrmlbAJNPHldA1kPncmOGb24Ild4n7sK4VcJkO7qTDWB?=
 =?us-ascii?Q?EHjJ6NH0x+xorMaRAU+MP4BcNGBg6KXf+ln1VTjvXameDiGHuVV5tjxTP3UA?=
 =?us-ascii?Q?x2O0CxbX2fxH7OVA9RJyjkGQI7dJo35fBIkMALIaQ5Dhb9iBkUqfTGJmw+ro?=
 =?us-ascii?Q?j6uT46r68T9B5vZssFMpzG7CSaeWjIQtKkkFJgBWtS4hoXQkZ2jjxbNJxZKu?=
 =?us-ascii?Q?TDlcw09GHI2hCeLBH7QK9tCor1K2wZ0/Etjfdl6vOgCMwD21y1K9ODM7FTZK?=
 =?us-ascii?Q?AOJqRKKlgAK2Z0WX9bHyKnHUc4zMTOnUI4s7CdMhpdWFhROYe63HBu+czQP5?=
 =?us-ascii?Q?ijO+fJri2f4T5dlOJRTa8oZdErkc+Pc4Fn5sIHc6nwfbUzq6SBrBKiOs9ikN?=
 =?us-ascii?Q?zNA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNiwnRCSMd33NOh9s+AbPvZDA4BTRyjlzPEwKZsZ1Nxt/FqlbMSkyKqdY/V/?=
 =?us-ascii?Q?kQKZQ1Lg8pntWaz0bU5Zyw6yU+Rai6kycdn0Jpseg8Wpeb0/9LtiiLxeNWeD?=
 =?us-ascii?Q?QRtWyJQM4A0VEg0vBzjcO9oxG9V2FKqYI2d2wWXohaEADolUIZ3qHnycnjsj?=
 =?us-ascii?Q?dllY1brPg1UOpYQiJ1s9BJrzoEgjzWfPwiyv3bW0G5xRJ+V77zLQylmV3Js7?=
 =?us-ascii?Q?o3OS5C5d3EvvvWf6k3Jv59U/cwzDNHg9XQp1qvzuP/QGnr7HrF3owTT2DrOG?=
 =?us-ascii?Q?5eXSDXrHhqSTdQzH2zLbkAVAN+duQh4RzW4g1sy9tM+RWEG9scO7kOGN48XI?=
 =?us-ascii?Q?reh7u0N5iQMaG5vs0pzchScKRHbON9N925W73DOk0Q8bOfCw80EYxnrb6qpV?=
 =?us-ascii?Q?a0u3SAsDQkljWo2ImA4k547SuiQ2Rjw37/3HoE1QmepJJkElf3iKCWonX4AF?=
 =?us-ascii?Q?065Y6AjSusz+OKdqd07wPYowAsO9dviogV6CJNgvGHog0VAn5me3MX/RZbY5?=
 =?us-ascii?Q?8DWa6WIDbpLPV3gy/zL/lrlR2K+qa+pMrjh8s9FkoLfsPr/LuZK+PbyYGNVb?=
 =?us-ascii?Q?wW7aBrS40hX5lPnCa+xhD48WM26aXxwPyp4vEYXF0xc5r3qZlL3sXhjn2eq+?=
 =?us-ascii?Q?7qT9aTQLRU+cgrty525Sln6wYWTz8xZf/kRpySNYx122PUGkiXKwgFJMQERq?=
 =?us-ascii?Q?L1I1M6Y9Vi0z/cNSG4OTPK1/0VmaQ0j8JiVWGMF8F6TS/ZO7QuXY8KQYuqs7?=
 =?us-ascii?Q?bSx0a4v3ynZ3mXsPHr/5a03wxCk6NeVr90or/z+d/LHd9lGLGzrBzv6WuF60?=
 =?us-ascii?Q?3FwpNTfF/3G2bp2BtK3alwdKJbfSEjT2HCklel4ETKsIyR39hkUB0O94bIxy?=
 =?us-ascii?Q?uLYTY9HaLL7fHecGRdc7Bhp7htAFlyNKYtpLj3aQ+RwWX0hd/S7gmSXcAj4X?=
 =?us-ascii?Q?MikpxiDlI3cg0OXjLGbf+f612lImz2h2dw2jspO59DDBImziETC9dPtoLfFm?=
 =?us-ascii?Q?BMccOr5vWxj+AzzdKCuxGrGiC1paKaOHTQa6gCNoQYg9vh3r2W99QHq7JgMk?=
 =?us-ascii?Q?iCQLuBeRyi+zQsCV4wYJoaxMUbfis7PZYmswo/qUenGzfWliKmdcGZrlS1gT?=
 =?us-ascii?Q?3ILCRlxOg5FGsf41gsvu1xBnNKuMdVqA6cRb2KrcIIw7RP0SyWC9oCWOqVQr?=
 =?us-ascii?Q?TKIDO1iH2kmeYQxVUXtTWGiJ2NbfzKUou/UFR10KRepyT0diBm4qUuZPJ9iq?=
 =?us-ascii?Q?P1cRtHOJWOX9p5yayn+w7CRnJU/DsMJ+mYJB0OfjT8XrURjKBAdc/WbfP28B?=
 =?us-ascii?Q?O5p5mxHhGm/Pgde3kcEY6ddlUqz0cTJojlMOxchOa45Y0Y48y5bRbTf+b+lk?=
 =?us-ascii?Q?OiHSz+AHT6TdwBXT27q6j4M71n3pEXAZTAWV1E7fFcbj4xWvk/cBE6DYmDeP?=
 =?us-ascii?Q?K+R7TbTjCkM4RjyuKw1eIBsIKwIPos/zcD8C9kVHj4Rz/XWAsmVWzZTxqMbL?=
 =?us-ascii?Q?EZrTUXmtZfoNDG5DzORHGbwWgU0rrkRZ1nqVo8Ya96tXt+0aNREhUuPXUyjV?=
 =?us-ascii?Q?8Ffphdtn5Qf7+vYhYGlR7t3vJqO3My0LuQTkUH7EJuDFBUsfIbTIY49Vz6mo?=
 =?us-ascii?Q?VqLwzqOe0OlFlRhU39+rGQqrDVroxSm+5dQoPrr9PFPQ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RhDH2idlxVDoqCMF6YJHSO7Mg4BJmYOe/ssH6zbrZyI0HNESicyxhz29SFK1VLSmeOcyiskPlcen5ckFoFGjpRAIKlWgSsKG8932Oa34EC3R6JVENK+15CZBGXo39siN6USAeKuf4JDci51ddiGdntjRJXAqRCddJnDKg0kgn5l9x5DpTf8N8DHhYmPGkNbzLXRnK/5+GjupBWUvU4vvmogfden2/FjsJgEcCyqjdaRt4RhxP6TMOg46JrSkQM9CDnS2s55FhL3CFESf5HV8Q2UbsSCmmNQ5gY/8qiCbq6oM9rl4+2pElKisoSuoEUUMCwh3OskMyjhbJk6v/UiMrmRWSDsQqsPikvcIpKbATno5qvdnPw2/bjjT7fNLUFYaF57Pdh+mWf1Zt9vmQkv6Wf9sof56Ny2b9NNj3OvuswcoHWiXtlnEUHzqtZcExlqE3Nepy+k8Da/686urGvqto+URG5PObPwm6CbzP4Yb4XpodMNe3Bdf5iVma2mIbkjM5mmPQT72lOUzbOs0RzPBXIicwCALcG39Qq3/FFxc5Y9FQS3gc9hk3BhoXduJByRT+/pC4F3vZQqZbJF2y809n4WFsmEyuuk94+70ZOi2pGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d77618d-ff73-4ac7-c66a-08dcc857501f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 18:20:51.3577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of7gKVzc12HBc9xBqhJ3V67G+JiwB2GbtZ0bCk/X6VMEebTQNxarG0ThvLceAyfjqGKdVrYHntlZv4IGrh22qWIxeMSqaNtOxBexxV6aupk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4637
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290130
X-Proofpoint-ORIG-GUID: pXDP8q6lJAXvT4-JRqvqNc98MPXszLpq
X-Proofpoint-GUID: pXDP8q6lJAXvT4-JRqvqNc98MPXszLpq

The runtime constant feature removes all the users of these variables,
allowing the compiler to optimize them away. It's quite difficult to
extract their values from the kernel text, and the memory saved by
removing them is tiny, and it was never the point of this optimization.

Since the dentry_hashtable is a core data structure, it's valuable for
debugging tools to be able to read it easily. For instance, scripts built
on drgn, like the dentrycache script[1], rely on it to be able to perform
diagnostics on the contents of the dcache. Annotate it as used, so the
compiler doesn't discard it.

[1]: https://github.com/oracle-samples/drgn-tools/blob/3afc56146f54d09dfd1f6d3c1b7436eda7e638be/drgn_tools/dentry.py#L325-L355

Fixes: e3c92e81711d ("runtime constants: add x86 architecture support")
Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---

Hi Christian, Al, Linus,

I know this "fix" may seem a bit silly, but reading out the dentry
hashtable contents from a core dump or live system has been a real life
saver when debugging dentry cache bloat issues. Could we do something
like this (even making it opt-in would be great) for v6.11?

Thanks,
Stephen

 fs/dcache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3d8daaecb6d1a..69404b4d87546 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -96,11 +96,16 @@ EXPORT_SYMBOL(dotdot_name);
  *
  * This hash-function tries to avoid losing too many bits of hash
  * information, yet avoid using a prime hash-size or similar.
+ *
+ * Marking the variables "used" ensures that the compiler doesn't
+ * optimize them away completely on architectures with runtime
+ * constant infrastructure, this allows debuggers to see their
+ * values. But updating these values has no on those arches.
  */
 
-static unsigned int d_hash_shift __ro_after_init;
+static unsigned int d_hash_shift __ro_after_init __used;
 
-static struct hlist_bl_head *dentry_hashtable __ro_after_init;
+static struct hlist_bl_head *dentry_hashtable __ro_after_init __used;
 
 static inline struct hlist_bl_head *d_hash(unsigned long hashlen)
 {
-- 
2.43.5


