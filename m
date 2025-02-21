Return-Path: <linux-fsdevel+bounces-42222-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE0AA3F3E0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84980189ED22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 12:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCDB21018F;
	Fri, 21 Feb 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="keYiBV3Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qQ+XZy98"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEAE209F4E;
	Fri, 21 Feb 2025 12:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139549; cv=fail; b=BcdoAUoW+qbyhA5C/Wzx86Hj0Dj9ohnZO/3bPecPRqJ7Tz94dih/geFE+Qmb0O6oWJL6Jn+K7c7Kn6Vf9Xzae6Q+RJjw9eal0NPjlaurJjbLker/zFxEo0JQBfLwRUzm2WxnSInz5rTMKHr5GOZTzxt5jbF76P8MmdAD//Di1uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139549; c=relaxed/simple;
	bh=d4OuJkt9XuuWUE25hYR2j1lLXjWMDR3BEZgTS7PKBP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sVNsn84+dyXh6NyCvA0SJAnmUoiqlWqMxwB1hTXm4PYMGtqDbdG004VYtLliMav6dKO3mbIOIIToyed3yGW+Ovfo/B5+Mtnh3KLugdytcmAhw4zBOWDm4SFpXnwAlc0f1cifTTsPs7z9VGOW4nID2nXDlje4FrDYwFsOSVfOL6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=keYiBV3Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qQ+XZy98; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8feVc016634;
	Fri, 21 Feb 2025 12:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Rv/o8vZpmJ2n7S8Fax3oAANq31qtXOkAgKLHi0T5JBE=; b=
	keYiBV3YRBmzblg4T75TPJ+yQ2nN+pzkBJFbFMN7CoA+EPvJbfZW6zW4IMPYwI7j
	2qBLXby1WHvQCEVLqaWkNUv2f035LIGzlRrqz5HEpG9Vmer/nR0k61UI4tQhe807
	F0SxOFnBkqsTZp/5eUQOfv2JSUSju+CiSbOtuXm4Q1motIZqTYHSFcfr6QdxSfQt
	4LfIg0/2G99eAaciLcS218BROYXbf3Vx/YsZ7CLvb/z4vckWl8H6YasJVdQeowU4
	DQ5AeHNL51X9RNtHVceF+6NGn5zSkbSsv3K5oPXHq44DY7WcodnIQ+G9JPdgvwU0
	9AJ/n849TIGZfhuQx/2uPA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00np3yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 12:05:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LC32gt002136;
	Fri, 21 Feb 2025 12:05:31 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w0tpsew7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 12:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsRjiNP+dDB0RhJWXvSb7l4jtlqtJLI1p6Wu20vEiwenMMJkfAiifiDePWYbg7OOv4yXWWdu+TdWcNmWwpwLopZ7Ua2kWUVlehrXsrbLlanVo/5i9lmtPQk1O7L1WDqkkQ35AdOph3MfIhxn6t7ZaE6oXWHQ/nxpl5AgtSkVJu0LGvOCrsz9vQp3WfHCVKsB1OEo4xW8dsWwLbtyg2Xb8tsjsxfJsgeaGXIEBuhhqxKbUDwfX0jCMO7ZykNCZfM9slv30lBzPRqILtNl1urU0vb4f4KkFW+QLuvz1u6lKOKmVx1+dftvdcHmp+kVSfd6bVkdvYJvBrzWFqvqgTo61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rv/o8vZpmJ2n7S8Fax3oAANq31qtXOkAgKLHi0T5JBE=;
 b=C/BwkXemAssY+H7virHZTMdn+HS66m6ruW0WkMKO8gVqmTdXz31tYVlTcslc9RHOVWusj+dpPSfc+L1JoTvasAuS1sgpMTNa9zslI51zNwdKG6OSv7o8eYrqjhP7GH4oXr2eCeUQrF/5R8r8jTfWISgfDNO2pARLKvk3JzFKKK3St7RaA2YEPBKKVpEXA775De67bAhLKw65AJDpa4hCQYVzDWlM6OO6JVBolBZL3Lygs39h+XV5Emh6USBbeFcWRIYepMHJoB+OEIS5CCEiL+rPkguAyMpnk3sTRaT1Na2htGwvcHSTjzXfuYpDpDHLxA6B841OACirNwPnaZSWEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rv/o8vZpmJ2n7S8Fax3oAANq31qtXOkAgKLHi0T5JBE=;
 b=qQ+XZy9893E1zFj3y8hSE21SWJW4tancF2IJLXKt3exK28+Ov773ohlIdI4Ja+0FCK4k/oWhotIi5jZtXxKQC1xI3prDyh4+7W89iB3bRX2IepqVtOfQC1RnprnFxaJz5Ij367jeQBvfusOu9DphI1H3UMFDdh0eFH9fbgf86yM=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 12:05:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Fri, 21 Feb 2025
 12:05:29 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
Date: Fri, 21 Feb 2025 12:05:22 +0000
Message-ID: <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0427.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::31) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|LV8PR10MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 234fd4f1-03d7-435e-04a2-08dd52700900
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cI6iqxUAJ+eBoX9MqzLqosETvUEmY9jOdAetYxZ9kvGwo0GZwdIp9e6/RdGa?=
 =?us-ascii?Q?5p9wu+BHd+ImnpnRLc/VkM+8315pSuuSOoXG61sCCukqdTwV+8cpyxw7KooM?=
 =?us-ascii?Q?La+R8Ai5mD60PC0unUvn6IOz590SOZ3BNY06X7RbbMy/dUEOz0zqve6SBdBE?=
 =?us-ascii?Q?lBgFG6qIsiCnrZBINSgvH/+qg9ZZ9oHzXzkHfy93Y2AsGtnC/0SGRHDnpP1N?=
 =?us-ascii?Q?jMvrxGk7yq2ThYL1c1VVXwkLyzdJ+U8RrId5Qh/GSgE+wg19ccoKKtqZvNit?=
 =?us-ascii?Q?qj39NcD9xblpN0CAu6A+JsUCdtPfS/8duXY38fken2RablpybmbkYInjDMis?=
 =?us-ascii?Q?fkgsDyWkI1KuLHQ6f8pSGLtnIGmHbbcKCNbh/i+WJNdBuB1xjAgavbicFDvO?=
 =?us-ascii?Q?MPHZ4Av1d+WhLiu2o/kF+TjHUEs2cp/1bYg8d4lU786FeyyXX4s4Zx33xif8?=
 =?us-ascii?Q?E7xrcG7uFgvhtbbiv+w2pCck0ERgxNLPhyMjqRJJzUEW6qPh7062JX3w68sR?=
 =?us-ascii?Q?0ZY76sbGa8y2x0aG6u8c1gauSXRe4hzMbZiPcfbs2axZgMOYi5K7+JUcaqNm?=
 =?us-ascii?Q?bmTk+x9MznMpWcYfktndVmCyXUclPgNHDzZMM2ndaUeKD1V+s2+NvQHIt7Mo?=
 =?us-ascii?Q?jPeMOKXGJbLtElGGDgImPS5hi8SFFhtGm3TKN6KBlQX7HVoPtr8xAHTrS6Qm?=
 =?us-ascii?Q?anvPp8EgtXydO78dbcAypxZ6V1mQjwPTu+fiu5AWAChqEjk03EqTGSq45ouR?=
 =?us-ascii?Q?LRiuKVlBs96s83/1+QWLFyBAb6uGKQbEDYV9AXOzp8p/2zTdRfCN1Z9Dv2Jd?=
 =?us-ascii?Q?RlvPWpQZWs7rwN51SXIctAQg7neg/uNTdZ0OGaBwsrRCqTMOBTQNcXAQdi9N?=
 =?us-ascii?Q?qaPr2oUDHkJJQVSPnt8ezLPGgjsKHB1Syea6HR6uMoobL1PI9L8O1ppKiVt7?=
 =?us-ascii?Q?gipsRmhFUwf75kzauJwhsjbvsr9jo+Zx5ROZtNrpeRd3bzPWfFdPgIdzXB1e?=
 =?us-ascii?Q?/cp3sb7ckYgGcWVQUsej1ehwlXLplmAuyZv2TVFtPQw0Y8RxMGE3aG2HSOK0?=
 =?us-ascii?Q?6tF41lzQzS1owA2CfZ3KiVsc/GYJ2k4fAbszlOn3RxGJSMUC12O7+i3WgXKE?=
 =?us-ascii?Q?/XfFKoLQVIa3UyNpu4WnQZa7zkNcK6hCLnrlBj19Y6j4/wQwnKiauQz2apXA?=
 =?us-ascii?Q?pEdkmBKppu/jmTZ9cQ0DGHxiYALxUg/fmdw3nN4ZT77zpFR1edShc+doVC8s?=
 =?us-ascii?Q?uQHBGv05wnid/yD8kbZI4Pf5/gcDZHxvE+VCf7J9CHSw+O36RH+ZlL5ifOT8?=
 =?us-ascii?Q?xD8DMRY+iKX2TGJGRouuQovBy4Zt99rgFynZ2q6PP6nyjS2dJhjW7Nd9OVNc?=
 =?us-ascii?Q?P4CfeORrbs4P0toIId2z0U+kcnie?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNIsw91DQZXrIwcx14gNIt+/UVq4P6LdAPh9wHuwJeOkjlJAWRDovyDozLqq?=
 =?us-ascii?Q?mtpwXR7MbhA5/1KLcqjP5VR3UeT5DavxmS9h2Th9jFhMozRAH9q4bApHMtKb?=
 =?us-ascii?Q?CQU1Q8L6JTQbe/aDZkT6llkPBkgBG/9gVDqdbayXK2fk4kdJcilzmM8/tBIX?=
 =?us-ascii?Q?Jl6Z416985EWKh4o3CH8188/E0mAsraDNdeMVGaVMWtrMGsqifCMlxHrwa0G?=
 =?us-ascii?Q?bG1hvAwCvUPR+wvgpOUBb8o3ilZh6ZcvsRAtvdMUvDsPdScESisVDw7S/KIg?=
 =?us-ascii?Q?wk7pS0PA5JH71sqkLd1rMiRbT83ZsN57IRpTu85pqWe9oPb+uGnqv/89+Os3?=
 =?us-ascii?Q?QUe9iBJ/Uz3sAUU8IzbzkoZ5bNMQ8FYP9yvk2yYgp0klGLlqMR96bseJHESu?=
 =?us-ascii?Q?IrmR0l1TDXttkp9M6qPjQA+g5gOjx9hr4RUoJ22xDsaMFGGth7SauOigffgw?=
 =?us-ascii?Q?TfQ2hzZvIv/izbkhM0OhaTVSztY2XTPiimNuMBI62qd57aXt5OobQ1sdbw3i?=
 =?us-ascii?Q?Ame/V7Or/QAR9Eb3f19URPSuGKTRXQd7bK0zAet9bugnpyQ7irs+o+970AFM?=
 =?us-ascii?Q?MtsjsYrpSBE9yuINBn6m8Dp3D2sTjJJDyLJNu5DapU7jj2kHIsfhzO6BF0k+?=
 =?us-ascii?Q?fu+nlI/tFSNvzSvSuR6BV2XK6zlFl9hKPJfcC1zdr0k20KxLu/5ITumvpOwe?=
 =?us-ascii?Q?p+ZcZYgmPgWrKXORv1cuXWESipOi292VO7scDO5Ks6Y0TfA7pxVDvgItl7fQ?=
 =?us-ascii?Q?XdxpcjECIHfsh0WxxEPwRIp7g5B80u/n+rdIxWw8bdRQMeo5pu4KGr4EEJEK?=
 =?us-ascii?Q?j3wND+VCvIv8OlLXbIMtjp3UnjZNt9IDBmuWHWfHuxoM0ZdPqpUwpBq3jxv3?=
 =?us-ascii?Q?8PAIe17dUpKJB0Tqt5sN831bkAldp2Cd5AGU1Do9hKZlZsA4ENIIK9HwzaR+?=
 =?us-ascii?Q?z9Ru+2TXKrfG0wF3E3icbOWPGaOfzoLE5YhKe+GqK1dBrA1uE2TP2mB+vi2e?=
 =?us-ascii?Q?jEdQvlF+as2EQ+ZJqm30GPEPlNUN+F7shQYkXTGcRztGEA2fxz0cSwLuWT26?=
 =?us-ascii?Q?A54icbtj4Z8cKRZvuyi6afUC/pCmt/7UZWa0CMDZTyIjDOKEKHT2+ZkB1wWF?=
 =?us-ascii?Q?AgDJDJeYubv1MDYtQJlS5quhpmGYSAc/TnRcNof8R2LjaHufe2DsU4Kbi0Xi?=
 =?us-ascii?Q?ZzQwM+8etTQxu9YOJY8+IawC2wTfQMeKOYpdGgQk77+tpOo/YnOQfK3plkV1?=
 =?us-ascii?Q?d6wXQROgQQOXbDrke7g7vetkUupITBzpDsa3hpbdsq55nHTwIX/27fluJDkW?=
 =?us-ascii?Q?yZs0MrQp3nlWszmt+ry7q3EuX1cqNx4IKnpnmO1vN38/hLzcVK8RMyMUej1k?=
 =?us-ascii?Q?BCvBp+rQ9bLZJGa9Z+Rcod6IOjeSkdE5VPNB3d7X0vmuWwraEHt2PJ6e7ABg?=
 =?us-ascii?Q?BASZBfcBFrdLSLwJRCvax5XSY2FjRPK7aABhtjJmbMVjXRjIOp7S0kMBKFyC?=
 =?us-ascii?Q?EE1mlgkr4rdGMbvB+pHXl9KrHiUfUWlofS4GKA2s6gCc2HirH2W6/U57o6bW?=
 =?us-ascii?Q?z4VJIwC/hL/DOdKWVuigbbUW8AIcAjJBW+fTXlufshQKLFJ4FHInWMZJtBtL?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sLgK/2RlR9YQjcs0jCNAZIlZ15e5XdngPAHmErE5z18q7xbTr9hlZ7TCfPyew96fhft1Juyl9DrWKcyXaKeBFMr8skSbvn0fpfrzx5oVKihG6EzzIIw+TnFaYOHdw47UHzkwPBnicF/TPDQxtV8Kgmvh9M/qV2EmQSSgVOg0KMQSkfLkA7ZdNgZLCiLcUU9UWTpRO+qSeWFHgFOswtV61OuFDHczVkTtKuTuKFDXs2W5dZBWUk1tdwFeTG3RnAXnoCJnaBUACRdVFFop1OUXjxOMxYfSPDD2JYMPMSfo1aQ8lbKHacwoPHC/vZbrJMSEE8HDJypAlEClxQvsEU1LkDfMwBsxRnH3xL9tw5BwHJdzPB7CVYC1EM2cfX1aLJLeDayfY7VxgWKhCRp1b+zIpzzZsWh4CMC7V+OoTd63M7mG2mlNiRM6xH2mQcL6vxXSEX2xaSqzS7b/ZTSvqb1Vd1fMVrIaT+A6/DPfsosH3lbyGm2Stcs+uP3AA35u/N/V3N2TVwx2curC6AmhxBszdmQa9R75ekJpzavJGXSZzzBvyRCR6u7koOx/WpcdH4dW0x+OyjRc1ev9ZyOfNARqyB2DqW0C7TP37DjYSHeMyQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 234fd4f1-03d7-435e-04a2-08dd52700900
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:05:29.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u3cmYmb5muHDDLY+PF+HZMn6iHRowDxdT4egU2rI6VjsgZf4s8gmhbTdYJL9KK0B9f9i5xFm+VauWPezQoPNjGyRIb+hKaBQ5ITzvYilfhM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7822
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210088
X-Proofpoint-ORIG-GUID: Jtso52RGi36gXqPlfN0qjSh8-dmiQ0p4
X-Proofpoint-GUID: Jtso52RGi36gXqPlfN0qjSh8-dmiQ0p4

Currently there is no means by which users can determine whether a given
page in memory is in fact a guard region, that is having had the
MADV_GUARD_INSTALL madvise() flag applied to it.

This is intentional, as to provide this information in VMA metadata would
contradict the intent of the feature (providing a means to change fault
behaviour at a page table level rather than a VMA level), and would require
VMA metadata operations to scan page tables, which is unacceptable.

In many cases, users have no need to reflect and determine what regions
have been designated guard regions, as it is the user who has established
them in the first place.

But in some instances, such as monitoring software, or software that relies
upon being able to ascertain the nature of mappings within a remote process
for instance, it becomes useful to be able to determine which pages have
the guard region marker applied.

This patch makes use of an unused pagemap bit (58) to provide this
information.

This patch updates the documentation at the same time as making the change
such that the implementation of the feature and the documentation of it are
tied together.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 Documentation/admin-guide/mm/pagemap.rst | 3 ++-
 fs/proc/task_mmu.c                       | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
index caba0f52dd36..a297e824f990 100644
--- a/Documentation/admin-guide/mm/pagemap.rst
+++ b/Documentation/admin-guide/mm/pagemap.rst
@@ -21,7 +21,8 @@ There are four components to pagemap:
     * Bit  56    page exclusively mapped (since 4.2)
     * Bit  57    pte is uffd-wp write-protected (since 5.13) (see
       Documentation/admin-guide/mm/userfaultfd.rst)
-    * Bits 58-60 zero
+    * Bit  58    pte is a guard region (since 6.15) (see madvise (2) man page)
+    * Bits 59-60 zero
     * Bit  61    page is file-page or shared-anon (since 3.5)
     * Bit  62    page swapped
     * Bit  63    page present
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index f02cd362309a..c17615e21a5d 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1632,6 +1632,7 @@ struct pagemapread {
 #define PM_SOFT_DIRTY		BIT_ULL(55)
 #define PM_MMAP_EXCLUSIVE	BIT_ULL(56)
 #define PM_UFFD_WP		BIT_ULL(57)
+#define PM_GUARD_REGION		BIT_ULL(58)
 #define PM_FILE			BIT_ULL(61)
 #define PM_SWAP			BIT_ULL(62)
 #define PM_PRESENT		BIT_ULL(63)
@@ -1732,6 +1733,8 @@ static pagemap_entry_t pte_to_pagemap_entry(struct pagemapread *pm,
 			page = pfn_swap_entry_to_page(entry);
 		if (pte_marker_entry_uffd_wp(entry))
 			flags |= PM_UFFD_WP;
+		if (is_guard_swp_entry(entry))
+			flags |=  PM_GUARD_REGION;
 	}
 
 	if (page) {
@@ -1931,7 +1934,8 @@ static const struct mm_walk_ops pagemap_ops = {
  * Bit  55    pte is soft-dirty (see Documentation/admin-guide/mm/soft-dirty.rst)
  * Bit  56    page exclusively mapped
  * Bit  57    pte is uffd-wp write-protected
- * Bits 58-60 zero
+ * Bit  58    pte is a guard region
+ * Bits 59-60 zero
  * Bit  61    page is file-page or shared-anon
  * Bit  62    page swapped
  * Bit  63    page present
-- 
2.48.1


