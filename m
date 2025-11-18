Return-Path: <linux-fsdevel+bounces-68931-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD12C68CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id A193D28B97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B4934A78D;
	Tue, 18 Nov 2025 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TgO1qsq3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XoBIg/1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0C934678B;
	Tue, 18 Nov 2025 10:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461193; cv=fail; b=BANs14Fw8BxjrzUnxG9YfshSrOOpROOQuoJETiMWF0q3UVjScCwzOTDkkgebib6qX2o8a6QRZi/xdj5c5nDzC/8sl9Yvzf3djiVmj+RshPiLhxJ61S3e6DMMHC6bExaJ+aEz1lJZaC1fYZPCPGSTsWhRVGhgKngpCU44Wg5w+Rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461193; c=relaxed/simple;
	bh=Wu/wORsVYHxt58HJ5dVJ4XyhgXPLyurcLJfZRxtmtHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qVJgmxeqnDdr2EmQ6iFGYSId4BAgfBPe19Jwh96XAvid+24jeku+t9ocJEJuPI+GuU+wTx561FMxJijdM8Qh+7hOJ1UIEcg+1tGCU+RrFTFFxhC5ryVEqQbQ8//OHYdljwHZPapXd4l09moxNrxNSH2Q0reQ9yyRSQXSs7Ywr4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TgO1qsq3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XoBIg/1m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CYW1024772;
	Tue, 18 Nov 2025 10:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6cjn1Gd945CYCHU2XQyGJUGqveqDQQ5FuRAfWVyr9ho=; b=
	TgO1qsq3WdQqvPkcPVPs1yMXjb2n/kKsAEp9fwZmV3MBpk4EC1JyeJVXli63iqr4
	ixD76fh/6ob5SIWPkJTRS/i64bacZRxsCn/NFBT8Y0Ju4t1P2+5SoLlrfZ39gvQv
	XLbxQLmZOhMhhxk/0LEXnvRSRTmBEqfr459/7JLVRpKLIjLRLln61K8X9HN+ZEBR
	ld/29XUXoVk57rNMoQ4ZEAv9RUSD/cTOqaCAe413YQUxzEb+qRccp1IvM0WJCRQ3
	2hBxS/Y4FyzcCwYUrq75HQeL1qluM7AYN2k6/iYE5keiH5MaYemdq3p0FlXGs2/M
	zHtAvFF3ew1rEYED62oXGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbpvjfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI81Hmn035898;
	Tue, 18 Nov 2025 10:18:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011058.outbound.protection.outlook.com [40.93.194.58])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyk741w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZOO43CUpQcTQxv6AWqJoJqtc2pV222jgly320AEdCpI6QyuTyj+Hl90RqQzp8OFKU1nbOtPATT1nWKL+c4oDqlFr7ttIOrY7LMNYk9rlFtdsWn8wc/pTairnGQ2tN/veQB+s5OThZA039hSZiFFasOVUv2eqNUQVUBggFhlSRa1oxg82lWpjFe4tutnK86QmwW37XeNe1nkt8+erKcJteonm6OVIS7zn4NbJNX8ON93K82hOPKVPr+8wfxHKBp26lmWQX56bDVtOnGW79aDUGhLCz7x6Yk7XIAUM21/mdF4loHHbgovigRMgF4OR6LOs65AbUNomCM5whFN9XEL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cjn1Gd945CYCHU2XQyGJUGqveqDQQ5FuRAfWVyr9ho=;
 b=UyS9Nu7/h4XC/c5nL1xG/oFnTcojPICQBV7JOAyPLiDS/ONQG30nS2oXo8GLExGYB7TrPhIl1VrFoNFV9qmZ6SUNJQl6q0PSAAKiXQKUIt0VM2YncolROLg3gZCFuQToEHrDeeW2EK08Lm+nFVPaBk54RRx3PXwJ5wFlbbqLagECUpE1ngvymezWT38fIFwSzo3LTPvdC+0OPxu+NLwEnWdgfkbWtqHMO8ZrboJwpqS+QUgbM//vtbKouH0PekBvAoDbp25gZLFzDUbTrNK5EEP6vbKVIpyghr3W5VWaO5+2OvMrXZrpiGDiPZq6UKn865jFsVIhpH074aTh4sRMSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cjn1Gd945CYCHU2XQyGJUGqveqDQQ5FuRAfWVyr9ho=;
 b=XoBIg/1mu1de71NY6NfVAv4q4PIhzqUGXXSg6cONqa/M4ylnYAoK5djF1EiGG1Bh6SJRjhXDnL5UwJrQVqDcECZkFh0wEX9V9jCU2bb0jpwnMH6PpgBU3tWOO0NmECKe4B5BkQ1ccubRDWO/9Zg6oYSitnjIwQKyygZM04TT5DA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:41 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:41 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v4 9/9] tools/testing/selftests/mm: add smaps visibility guard region test
Date: Tue, 18 Nov 2025 10:17:51 +0000
Message-ID: <059e62b8c67e55e6d849878206a95ea1d7c1e885.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0026.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 81db302a-ad58-4324-86b5-08de268bd87a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ft0QFR8U1n6NBEnSzV1JdvJdOPv3PSc4o7tCKIVOFzyfEjJqq2mAO+6s49dI?=
 =?us-ascii?Q?Q6GfRxOC0BHpozBtOQT0g4TrLu/TswTVJ5WMdl8n+KKttflaYUcIfdougdm3?=
 =?us-ascii?Q?jhuCzCoMYlybWoDaczwd+l1AMkxNfhuRp8JNX0yvOt8tbP2Syo3PFbKuNeqA?=
 =?us-ascii?Q?Dq1xW2sasRMRj+rcHTJAaZwVPMNjlLlN8W43G8f/RZIqOucw7nlv80WLe85U?=
 =?us-ascii?Q?VQprQtRhGPakwHoq6dcYfdGY6hS7EPdZ1oBQmCAPid9XmipLpCUMQQ3B9b2/?=
 =?us-ascii?Q?gKnyxxnwfAqGEmp7k0pk+gzBDDK7odlDTKhWhbRkVGLzOkPXrtJNBZlQ6r0F?=
 =?us-ascii?Q?17xm9BXY8m5kqs4C68YGwNsgEubAnP8jGRf2vf1b/7AkNbH9zXiEbJwUFtVI?=
 =?us-ascii?Q?HmGzObsrZiFRGmLpUM1IO+WJgQR6FWftTXXYU85D1alzfgDrYRHFD/kgZBw3?=
 =?us-ascii?Q?zEFsjpmC2A14t/wn/Qn3lGP/R5M8S3CVGf+0E7AEUVVC8qIVh2LwIWn5pc9T?=
 =?us-ascii?Q?kT+WxjXdHFi3kQO5HEwEE2jYImY3eaSMBSFhVTSAL2Q9JCMHlDQXpvyScINC?=
 =?us-ascii?Q?us44+w1kZ7O/TmfAYtIvbQ5hTeX/tMBSgDxH9DCxEx9xF13+hdC9W7GtxNnz?=
 =?us-ascii?Q?rnZs5/yDCRCP9ILyCkebpNvwTkrguTtS8buJL7yM92vTI47Ysv/glClPcN/L?=
 =?us-ascii?Q?ixcl2RCvAEfgbz8w010NAarpJ31sQulR6P6Xj1vsZgJjHaPWdH5pyqwQ+i/O?=
 =?us-ascii?Q?WuHSxaaDz4fL2Z44WbaW+UvNBY/qH67YCGM3mLW2bslv2VYA6rmhqUzfUovb?=
 =?us-ascii?Q?PUxUfTS52xayFzq8IsWcalCbnx9s3VHksTNFaqrmDOBGCFVzBbOBoYZKphNc?=
 =?us-ascii?Q?q0uI6nhT6m6ZzU3yDe6hyra0OIsRCosYxequg/X6H1hq6YZ8EyZJGl9imU07?=
 =?us-ascii?Q?vKo6LAjfoddpwvEvX9xOmod4PP/EAohUpkUqKvra1Ex8pzIUX8+RHM7+HvhK?=
 =?us-ascii?Q?5thI0jtF1YYZkD003ftSKCx+3p6VWv7DL7evEpsK0a6H0ufNKl++OlLBBsLh?=
 =?us-ascii?Q?03PF0z/0Mlb/8lcmwwoCVVZrcNFFY5ftXDzNKbsZnIqVbpsp5TaRdKpbzbww?=
 =?us-ascii?Q?1Rx3MMAyn8w0mRaCzshlow/DbNMWoSjl0HVC4QSG1XY/VilTjsJerQI3Pvdw?=
 =?us-ascii?Q?WsE7QGRRaQMUVHSJbaUh95yCHlXnwWoqss5tNDXTfXtLwS5PMLvSUc38oXw8?=
 =?us-ascii?Q?vmqg7vPHNZcFHh9+8fHov9vAELPp1/tjWrZBXxJabC7iDYu5z11P21t6fRsP?=
 =?us-ascii?Q?Eezsn50wi2AqKu5VlfXqDYnBabCsuxdglIVH0LnmfdDuG96GjpnJ7zJJdyyU?=
 =?us-ascii?Q?S5WeEFVNOL9cEz/Lvw5YCZz4o8YrGHyR3Ti2xVBwNMXdu+qyvdGkRQDlObuk?=
 =?us-ascii?Q?pY8ZKDCPVYL/uAGM2V+l9UlV2+9u3ZA+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8Wj4IJxuKp6TBx86wgtJhs8XLTu1dRn+jlcWWy7ZhJZNTZp32rkgrwlX/jEo?=
 =?us-ascii?Q?zPCmhxmLFmwCXcb5v2YSPUIQRZO/KD8VqlikvDkwNHdCWdXa/2cDZMhbJJV/?=
 =?us-ascii?Q?wG/iOISjwI9Y4m543/wJDUvnKR0Q66AuQAzKyrjSwqXJ70/SO3oSJ2hsWlnW?=
 =?us-ascii?Q?JarRfUy3zeMGCbqfvcO4GL40Q+xJsQXnXAzqZWabWZSyg5x0zJLyZnZmcwzD?=
 =?us-ascii?Q?C2wMsajkv/v+c5l17NWqJVtoT+HJQzRNzNIHVjTRSIeiHAqLqJABonIoog1V?=
 =?us-ascii?Q?sp8/MR19b0pKtpYGGp6m8B6nm4tSv1Mg4utvGxrZxRgCaF7lguodKURkzHPW?=
 =?us-ascii?Q?hb8BqKylaN+fg0K4VToT6pLWZCJ4VrliNlPrEBX6v8IQ7Sn1nOQ14voVHZHE?=
 =?us-ascii?Q?4HaO7yBcoRXsgWk/oey9a++A+pMxVsY+C54hptvCvYMSoe6VfCB/S6LINhID?=
 =?us-ascii?Q?LJ+9m5NgXFld4H0Y5UCESl0Xrsgz8uHGsM3UGZnkV6vLEjC6WY7Elu5v56a2?=
 =?us-ascii?Q?EO7lE5A418RWPlSCDXkvuaBKQsWY7GmGrpo3MMrm1gevrMZLKeTsTV/1c5ce?=
 =?us-ascii?Q?lVKwLpVe5LI0RJecNhVEsd5P5eNPh3LoENontXzRvWno7+mrAUrPnasi8y4B?=
 =?us-ascii?Q?qlwzmyI4OCpOu4rBBpUvwc0IE/MLauQN500QEIIwphqwzIVp3A1+CU5wwiUQ?=
 =?us-ascii?Q?TNq8TEZY2J+vHFGh8VbbOK3hdzbVZR5hxTe+sAcIkUGI9B/dw4cMsZbAfBkr?=
 =?us-ascii?Q?xxkqm5oGLvWks7GyUfqZFXWTl3B36nyuCw3CJUIEcmCyhxEGw+Hjd21BJWyy?=
 =?us-ascii?Q?+4aahGMzK86frBe+l56mw88daDpOl9y6YJJZAerLfExibsnWY9tR9I6OBTUL?=
 =?us-ascii?Q?jH+OLPlW9UKb/vsLabGPmcV1bSrUM9lgu+mtBZtZpx36geKi+fOzhs7o2Rj1?=
 =?us-ascii?Q?dIJKff0O447ct0PbPbpXVAXqraBBzwVGsz+HbiJ/mvjXeQKSATGf8DirByjx?=
 =?us-ascii?Q?QEumCkXTTbSwVGNcJPtavyQZKnIRIuwXEG5N93RLM6TcO5T6L4fyz7jy0Gr6?=
 =?us-ascii?Q?hCXrZkMcgXmK/usFyDwZaa5/pbDfrIQGOD3NroSIcOdUDhoR3AlhsHhR3gtM?=
 =?us-ascii?Q?XlhKEQbptQUhATIwxHZCBUcVWKF0zF81UU8cNCOb6g/Ix3U4lt+vsCo4AZfg?=
 =?us-ascii?Q?cDbe+qxgibks79fibfBJtKk39LNM1q3b9G2FUme7zmpDu9+Lr1kds+/3IyGN?=
 =?us-ascii?Q?Hl4aX+JG4t3bjabYWdnxdyAyE7hT5jSGcjC5Qm91RRPcaeS9ajBgA2KZpuHn?=
 =?us-ascii?Q?ATNujfTlSrDiQb6lyDwKP3jwD9v3v7zmwvmUS4/TRJApXKZNVNaw8zRrWUUC?=
 =?us-ascii?Q?5j0G986nrFV4qPGs/PlBW7wF2CVvVUdqmdNR2H/ANNgzplop0vJb2atk5BJd?=
 =?us-ascii?Q?nK5JOC7FNNfKb/PpWu5BZAwiPZWhyJBdxexyJQzWeNzGQknBWER2V/qNvEiz?=
 =?us-ascii?Q?r/hydX4a99LJRALEy2zL8djTBscL9Dmi0uwVbk+wepZTal+t1cUcsTF5PyYe?=
 =?us-ascii?Q?BCYf/Jm3OU+553pJIvTB2lo2gDCgBh5FnyTSx9BYwgOfIaxoHMdNzW+6dmKW?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NH3T18zeZ5HUo7uUrBMhud+qKMie8UsRDc2yGAwZJtkXpvJHXGk9MCW7tgHl0m3EeDa8AD66sKNjyIC+xyCdiLxV1WPFIHhaaHLlfCYpy/WwNrcY+++qydyzdzgo2wqjqLo0WDwZOQudyRToTHwsyrKXOazN5Fu5QNhoGEIAidB58QJ0opaSBW51as7IApvIrx4v5nnJkMwXp/oyptn6yMDlVOdvGAbKgj+5r+cGUh64NOh4moP7m92vOVWnct5BjCRtdeAhcgyguPp3trOv9TcvImmbcs7Bzc4g77l0XHGc+Zv0JFWa/XQoaK8XXIxuZAp4H4nE6f3hysPR3S5hw0bTPJ83mwG/VL/5EJ99NCmR/aXEpy3mcRzBWDrrFeIwwZ+Mrs+wj7kwjewdBswheHLOwj75870slUzWGWYvyUnDJl92BminZoirnh7DoScTIwFPoLMJJHer9VaNDHDiZP1dsONXgIoZrSA6diw4JWxtJc4WSowq6WoEvnCZ9kjUgqmJzKwG16mKBiCdeUl0bDaszyAeDNaB8s3PFonlTOmy96c2giU9DyPxXMCdYrtEvrCg4FvwReEKTNSW3w0Z3W2te6aAMvbR4b3MGjMY4f4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81db302a-ad58-4324-86b5-08de268bd87a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:41.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esbvyNyYAM5nX4r4k9rtOz7OPlFAQYZK9Yi3vQLnuPmAH3kKvd+go9dmPSIegybBFj32XLHF4At3Y0ay0Y65hzJMF8ELj8jbmzhXd9buppE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX3zbjY7tHSy2m
 EAodRXTbL22fsXDZ6n5gJrQE+QbEPA/b4wR+K98D3dV5GoiqwAEkTjSu4tazlJ58Tg3aJNI4AoG
 geLyamwJOUud2SCtW+82xDi7qz54biBCU7Fvosy6ZYXiVAc0FtffWpeGR9F6K9u4ntY4X7plD1K
 I1d6b8N0igWYGxGRCuCkfTVUF3IVGSlTVEKpuPTvk3fG3eo6yREFqO9exFugHeZ3589wuQjFB5A
 VY2fL4o5qpHb8x++OCGgGIAbeGB67/T4DKi0oDmJJYGmy1Aw8keBpz7KveC3VniaMc2zZVz9GM7
 /eqf6+NFX6rFxUwgM2LBZrubgulSdo25I+9nW2tPbZlsPC6Y0f3ikE9oHjtC0zyEOOWw2mIuDP2
 /W5TQQRFbzPA5NnPTpPxG7dFT6QJVszUmZSS6bg7xSYfaJ7+FkY=
X-Proofpoint-ORIG-GUID: IL3ihgbvXh7bBNedjvbQN-xRwU7r1vlm
X-Proofpoint-GUID: IL3ihgbvXh7bBNedjvbQN-xRwU7r1vlm
X-Authority-Analysis: v=2.4 cv=a+o9NESF c=1 sm=1 tr=0 ts=691c4806 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=7oKVWYA_E11v4TV8rOgA:9 cc=ntf awl=host:12098

Assert that we observe guard regions appearing in /proc/$pid/smaps as
expected, and when split/merge is performed too (with expected sticky
behaviour).

Also add handling for file systems which don't sanely handle mmap() VMA
merging so we don't incorrectly encounter a test failure in this
situation.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/guard-regions.c | 120 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c       |   5 +
 tools/testing/selftests/mm/vm_util.h       |   1 +
 3 files changed, 126 insertions(+)

diff --git a/tools/testing/selftests/mm/guard-regions.c b/tools/testing/selftests/mm/guard-regions.c
index c549bcd6160b..795bf3f39f44 100644
--- a/tools/testing/selftests/mm/guard-regions.c
+++ b/tools/testing/selftests/mm/guard-regions.c
@@ -94,6 +94,7 @@ static void *mmap_(FIXTURE_DATA(guard_regions) * self,
 	case ANON_BACKED:
 		flags |= MAP_PRIVATE | MAP_ANON;
 		fd = -1;
+		offset = 0;
 		break;
 	case SHMEM_BACKED:
 	case LOCAL_FILE_BACKED:
@@ -260,6 +261,54 @@ static bool is_buf_eq(char *buf, size_t size, char chr)
 	return true;
 }
 
+/*
+ * Some file systems have issues with merging due to changing merge-sensitive
+ * parameters in the .mmap callback, and prior to .mmap_prepare being
+ * implemented everywhere this will now result in an unexpected failure to
+ * merge (e.g. - overlayfs).
+ *
+ * Perform a simple test to see if the local file system suffers from this, if
+ * it does then we can skip test logic that assumes local file system merging is
+ * sane.
+ */
+static bool local_fs_has_sane_mmap(FIXTURE_DATA(guard_regions) * self,
+				   const FIXTURE_VARIANT(guard_regions) * variant)
+{
+	const unsigned long page_size = self->page_size;
+	char *ptr, *ptr2;
+	struct procmap_fd procmap;
+
+	if (variant->backing != LOCAL_FILE_BACKED)
+		return true;
+
+	/* Map 10 pages. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	if (ptr == MAP_FAILED)
+		return false;
+	/* Unmap the middle. */
+	munmap(&ptr[5 * page_size], page_size);
+
+	/* Map again. */
+	ptr2 = mmap_(self, variant, &ptr[5 * page_size], page_size, PROT_READ | PROT_WRITE,
+		     MAP_FIXED, 5 * page_size);
+
+	if (ptr2 == MAP_FAILED)
+		return false;
+
+	/* Now make sure they all merged. */
+	if (open_self_procmap(&procmap) != 0)
+		return false;
+	if (!find_vma_procmap(&procmap, ptr))
+		return false;
+	if (procmap.query.vma_start != (unsigned long)ptr)
+		return false;
+	if (procmap.query.vma_end != (unsigned long)ptr + 10 * page_size)
+		return false;
+	close_procmap(&procmap);
+
+	return true;
+}
+
 FIXTURE_SETUP(guard_regions)
 {
 	self->page_size = (unsigned long)sysconf(_SC_PAGESIZE);
@@ -2203,4 +2252,75 @@ TEST_F(guard_regions, collapse)
 	}
 }
 
+TEST_F(guard_regions, smaps)
+{
+	const unsigned long page_size = self->page_size;
+	struct procmap_fd procmap;
+	char *ptr, *ptr2;
+	int i;
+
+	/* Map a region. */
+	ptr = mmap_(self, variant, NULL, 10 * page_size, PROT_READ | PROT_WRITE, 0, 0);
+	ASSERT_NE(ptr, MAP_FAILED);
+
+	/* We shouldn't yet see a guard flag. */
+	ASSERT_FALSE(check_vmflag_guard(ptr));
+
+	/* Install a single guard region. */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_INSTALL), 0);
+
+	/* Now we should see a guard flag. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+
+	/*
+	 * Removing the guard region should not change things because we simply
+	 * cannot accurately track whether a given VMA has had all of its guard
+	 * regions removed.
+	 */
+	ASSERT_EQ(madvise(ptr, page_size, MADV_GUARD_REMOVE), 0);
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+
+	/* Install guard regions throughout. */
+	for (i = 0; i < 10; i++) {
+		ASSERT_EQ(madvise(&ptr[i * page_size], page_size, MADV_GUARD_INSTALL), 0);
+		/* We should always see the guard region flag. */
+		ASSERT_TRUE(check_vmflag_guard(ptr));
+	}
+
+	/* Split into two VMAs. */
+	ASSERT_EQ(munmap(&ptr[4 * page_size], page_size), 0);
+
+	/* Both VMAs should have the guard flag set. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+	ASSERT_TRUE(check_vmflag_guard(&ptr[5 * page_size]));
+
+	/*
+	 * If the local file system is unable to merge VMAs due to having
+	 * unusual characteristics, there is no point in asserting merge
+	 * behaviour.
+	 */
+	if (!local_fs_has_sane_mmap(self, variant)) {
+		TH_LOG("local filesystem does not support sane merging skipping merge test");
+		return;
+	}
+
+	/* Map a fresh VMA between the two split VMAs. */
+	ptr2 = mmap_(self, variant, &ptr[4 * page_size], page_size,
+		     PROT_READ | PROT_WRITE, MAP_FIXED, 4 * page_size);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	/*
+	 * Check the procmap to ensure that this VMA merged with the adjacent
+	 * two. The guard region flag is 'sticky' so should not preclude
+	 * merging.
+	 */
+	ASSERT_EQ(open_self_procmap(&procmap), 0);
+	ASSERT_TRUE(find_vma_procmap(&procmap, ptr));
+	ASSERT_EQ(procmap.query.vma_start, (unsigned long)ptr);
+	ASSERT_EQ(procmap.query.vma_end, (unsigned long)ptr + 10 * page_size);
+	ASSERT_EQ(close_procmap(&procmap), 0);
+	/* And, of course, this VMA should have the guard flag set. */
+	ASSERT_TRUE(check_vmflag_guard(ptr));
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index e33cda301dad..605cb58ea5c3 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,11 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool check_vmflag_guard(void *addr)
+{
+	return check_vmflag(addr, "gu");
+}
+
 bool softdirty_supported(void)
 {
 	char *addr;
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 26c30fdc0241..a8abdf414d46 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -98,6 +98,7 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
 bool check_vmflag_pfnmap(void *addr);
+bool check_vmflag_guard(void *addr);
 int open_procmap(pid_t pid, struct procmap_fd *procmap_out);
 int query_procmap(struct procmap_fd *procmap);
 bool find_vma_procmap(struct procmap_fd *procmap, void *address);
-- 
2.51.2


