Return-Path: <linux-fsdevel+bounces-67450-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E94C40CE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 17:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 888733B216D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 16:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E40932F747;
	Fri,  7 Nov 2025 16:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GsBV7+8L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xDGmh7T6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DC12D781F;
	Fri,  7 Nov 2025 16:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762531952; cv=fail; b=ujfl34oItQjnc0JoyscxkTTeG79SbMcdPc+ivS1IvD398ljxsdjPNgLUGrXvrgzPMbNQjmKjE71uj1b0/gRHmZaNHaLlhVSZvFjh9WQwQBlVQMCz6EVvBgA+CKTdhZHld0mtlHGFUZVVNoMyEzVud6/VF+FU1moD92SGXlU37yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762531952; c=relaxed/simple;
	bh=LhnK4x8kQLbkGe+vQmkeAOLcxtA2tVl6CHv3wgofBVk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rz5nh2vhq0FvygiJYEdPy8IReDHlFmH2RHMZobS6CzhxF+9f7XCl4FzEHaf8YvaPiYPbk4joEoEG5hqPQpjXPRf+nMXd5RNC9fCSNDnp8X7awnKwlDfyZm5wS/cbcFE1xITL2eOKeif6nAMby3NYfGLCGiuhNovckwUV7mkQQXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=GsBV7+8L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xDGmh7T6; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7FVNfO030086;
	Fri, 7 Nov 2025 16:12:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=bj8pJ35ye5RflH1q
	4GuizUeRBhj5B2khRuaYneJsm98=; b=GsBV7+8LnTa7MQgRBEd86nSOi9RLnU1S
	JD9DJmtC21FlMFux7JcP0Xk2dmTI3wEvJy2W2Gzmmf+v8KGQISSo0YuB1+nLk1uH
	7Aneru0v155YtYLP3miN9eiwSSojhWBjTOs7zxp96nDCRXRH3ewCSzYWt+uwxgH4
	CMNBgtDW2+Y2WjRwE+hiMRXiHvuU2T6OEpxeNvhr0GtO8uEBkKbPkPnm5X2/pu3O
	5eutzk+wBwV44gGSZFnNjkY3A88aU9qYd7e3ahOZ3B4r7nlx4C9AQUeF1ckXpuP+
	soIT5mx1eTwRU8B5/9g1jqTPsqwQ+Gyjb3xH8WJVkmWEfjyJTfAKQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a9j7788ek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7Ee2HG039707;
	Fri, 7 Nov 2025 16:12:04 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndpvwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 16:12:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ezNYTHxZDng85wd98z4NcbUoON3l5ubd7oKO8Og5e3dJgqNyKDhfDhfUPAsU3PJJvwwMSIxUV2JXTKJRo2vr5yy+04Ikx9TO6uwbN6I4PcTqZNXmgJ6MV1RbMOBaXfKEMRDqcZw1DmsO04a0DH9gbodpu9TraC86LQWNk2Get5NZmR79XKq1g0lG6Cd24t+Kmh5zfRpyKDsw9sdq0TgpRpaW0xWvbTmENitYdDcNAhcqK7OJ780y3NXIXKtlzNbY6iSvHB5k7zZpAhEIaE4LLekWAPq1XRMOynw6HI+qZEmhpYmnESaDRFvfcL5N+7KU4sEtBmXPZ+oxwHtN44uxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj8pJ35ye5RflH1q4GuizUeRBhj5B2khRuaYneJsm98=;
 b=IXv1Ye08hLfqJ82b9x1vbYKoK5ey+/Y+9Kb3vCK3imfphATDrjpO26OmoMxLxTrO0/QipXwLyQXMN5soSaDsjfoVmCNf9lPisl6oUtdprh5f5wDD9OZqLsjEfEeW4GnSC5GRr8CnJZ7PCCFYvZNID/U6ojkGltnfQ/O4ItmNyLdpu+cW03u9o5IITB/bouGLMA4uZsLZbF49CpljO+Fgn/rY2uD89zHsYhqPpOkrWJuM34/GiNtXBLQQNw3Xxhumh8IoQ/VmviyOK4ycytHPwZ9lUBppeKkdwbnRhCsFbEAzZnhWbIdv0CTspXmFVMhQB/wvweRrgJe6gYePzbzpug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj8pJ35ye5RflH1q4GuizUeRBhj5B2khRuaYneJsm98=;
 b=xDGmh7T6bKTynOUgY3OooYSNyXJS94Xj88xOk0UjJ0PYcsFcQGaQQojEJ2EoHLTKZPDb6HUsTTVswKyupxnypsUAc72lyzNPruMv+8s8wjifywn5WMkqN1m6vKs08rVUNRSTKwlO4jipqd/xuW0K2lfJrM8GuY4eB1iNwlbHGxE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPFADA73EAD2.namprd10.prod.outlook.com (2603:10b6:f:fc00::c42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 16:11:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 16:11:58 +0000
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
Subject: [PATCH v3 0/8] introduce VM_MAYBE_GUARD and make it sticky
Date: Fri,  7 Nov 2025 16:11:45 +0000
Message-ID: <cover.1762531708.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0465.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPFADA73EAD2:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bf6ebe-d675-4ffb-233d-08de1e1860c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCKpK6dNjfvEzBIBmftrd/2JIKI2RsBl6pLKEesRko1Spkdri/JHVV8v8N4F?=
 =?us-ascii?Q?m8sGOBg2DR2X/7MqN1uF/CTNZkxi4L4WYetrhD882iidXLTLU3UfT806mqZf?=
 =?us-ascii?Q?t0+JErBXq3jgH/j4lRPQqlvrnOJXy9Twp2sja3kRdnFvpYLFgB3k1SXLibsc?=
 =?us-ascii?Q?sIX3ZTm/kTkcFib71kcl+CfXTlbB2tBW39Il0tOY0n89keDa4csapIwRqS7E?=
 =?us-ascii?Q?8GGzkAEaJnYSx7t18LoJ5VettNQqy2Ab9Y8/REtj78FGno1DXSuzEUqh+E7R?=
 =?us-ascii?Q?IswlfGxLli+kmCqLW2pXVLSL45V6X1EyQ8jsxT2E0zittKc0Z6iM7Wda5Hrs?=
 =?us-ascii?Q?YBtY42Ght34qI1gSOcVgZP42KjLgxykRO1j08LZdxmOKR/acCvg6uRELEMy/?=
 =?us-ascii?Q?tGfPc6a76kmJSu038cxrMm/fgmQR+PyHg4bJ1e2WG79NmT59Sb65+c86hQcZ?=
 =?us-ascii?Q?Fu3ALjBsfi2AtQqAYJUv5FXdgpInPgWTFiioDLQfDkcsILTs2D884XIPVj03?=
 =?us-ascii?Q?D/mqhcDqwgS1qFn5Fg/1U32VaF75zhSFugGuR8Y05C49wjY3XNPz5Epe5Ohf?=
 =?us-ascii?Q?I7B9Vii5cdH2frk+h4bW2kwsQajimg9n4QjyYcUJNGF+yOeXXlnC34nnYAAo?=
 =?us-ascii?Q?CzL9p017rNYieI+jPH+qVx3lGdWkt9CixwiB53c/LEqmX+9QxFhLGArfNTkK?=
 =?us-ascii?Q?jLELAP4qEmHhNuQ/KE2mPDCwRjl7wD8P1uWQU0nONr7iU4XJP04SJT03v40b?=
 =?us-ascii?Q?51Ijfhh6HURsKZtuxw/28nIN72rbdoHzvml7/FyRfWfExCfUh9lRfNPztFOU?=
 =?us-ascii?Q?4/WAvvYnAP4aIkqV+MP+ueuOAANtL6NfdsTMomfysE1xQeepPuh0mFdjPraZ?=
 =?us-ascii?Q?nGf10Y9v1rbepeJ5SEhBBAnvj6RY8Ktkiplf4U0sVhQENoXMAofwWJJP7fjh?=
 =?us-ascii?Q?NuMRy/KBDbnYAszRvouJxvq/5EVyiZVJLunGEejQw1oobeW1m8B1H2WE6DOi?=
 =?us-ascii?Q?q+x5Ko+t5ki7DwpoXP7/06GGh9jiqrpysPZ+1t/1QmBvdNRCJL//tLvM71+H?=
 =?us-ascii?Q?kXczPAhClv/KA/G8zZALrD3t12bOi8LPDLTc6+LI3nS+sXhpNN6tjiJPSXlg?=
 =?us-ascii?Q?ktUm9olNS4SKf8VTTrwCem+h1Snipg4c4qhfkEF6WhNOf5RmT8OvEnQPpZ3R?=
 =?us-ascii?Q?LdbrullY6htVpJYtNkbAY+xDBY1UVQi4OAgzGCeq3ADlHky8aZNUjbH771o4?=
 =?us-ascii?Q?zzwgnFXur8QMDYRjXVu8dqTDERdPhR3WBRbf6Vl1ge3Kn1e6WNH31SEcGqT+?=
 =?us-ascii?Q?bnHT5ikpqWCemk8ABktC138YrIq3JJrRmMMCl6gr2/RqAiJCcnHd24DH9JkF?=
 =?us-ascii?Q?1t/1u1104Ojouw2jWJ53qim2R8L8zr5dGEKX98JRjoUcEj4ny7z+iKtDmOED?=
 =?us-ascii?Q?YQ64/Kad0ecFTffhSJkSqB08f5BdFJTJJRr8BVzY+lnW94sPbwFkEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I5W4HxXMWKEeDQJj2XPb0kl1SrN1999Sxovu6evdcbfaRw2pYO1esUi1V0cb?=
 =?us-ascii?Q?CUYXRIryigm0B2rCaSBGHC0yIgOGF9KzkfabkHqHkZDqI1j/lNXNB0X290V7?=
 =?us-ascii?Q?xbVIs+aVdvZcVwlbfis/BwUZ98SMyn6kr2cZ1s7X6tj7P+eTl4cDlWyTDiPj?=
 =?us-ascii?Q?3eMHjW8T/rQMafjY+AXgI2IqE3J5AfmbdfWJ+7uyEc73dfXC5g9rwXdcUkSE?=
 =?us-ascii?Q?ydU+nJ9brLVklXyNoSznfDzQXqoKIE1QBuDThFJOqyddvGj8N6uUXMbQoruU?=
 =?us-ascii?Q?Lc4bYHXu7dxSQhwiOor4rsowW4lTQEF9r6ob4rHSjjPCNaeqnt404TEHM+cQ?=
 =?us-ascii?Q?t02U1hJtHZw+MIg8xaEFNO5ocWQESUCfADLw3hGNlKibwW0lo0hl5aJes45p?=
 =?us-ascii?Q?xBGdNjbeBsnKYTh6qPhYHV5Oui/Yiq8YC2TJJ1F1ChruT4htCsf4DBj3E9v9?=
 =?us-ascii?Q?gpK29LUtLRwOSNZzBMDVi6m1k+CNdQwF+H6VlrPJR0A0AvPHz8y80fFAiONe?=
 =?us-ascii?Q?khE+k89TSzgEtszYuh0+Tf1BXasEk7/18PBttyPiIfM5fhlvWtJ53VOKXW0s?=
 =?us-ascii?Q?ZxyUfB0vNNcohLV5Lwu7zU6Me+761tCNqYgWkJF5udS1Qghh5G457TIxj3TD?=
 =?us-ascii?Q?D42GlXdqMLH7b35sKAKG61TXLrptLAD+20O4uNNg1wt1R9DpfcpWH/fXzYYS?=
 =?us-ascii?Q?q9rZducZKDr9a1mnO4vTPzdUYg3rhQLuxHYiDO7WhTph+OTIoWs48tKoTfpW?=
 =?us-ascii?Q?aE9iJv1hFma9vWu/L7sEp6U/iXmpxr6SF2nmKAtRZFLIB3kmsQqRKh0hyNye?=
 =?us-ascii?Q?33nW8Rsafh/rhRWKaVLEtkdYXGytjggeLIgchLsH/OUgxno8uiKUjZhd+pwd?=
 =?us-ascii?Q?B49u0ltlfRoqbnpxeE9f01xYDwIlFU6e/OLsjGeCRAID0vAODG0OiIahzT3g?=
 =?us-ascii?Q?HGy0C0ZEwRjxrlQwB0li1yjghrdw4oD2DPsxUWLkG5dkqCIbs6pc6Va8lHOZ?=
 =?us-ascii?Q?TinW8M86QDAZ/W8CxQX+lRNYzb9aAVHLToc9b0IfboPUvVbriyncI3eCxxFd?=
 =?us-ascii?Q?Ke877a0Zt2zt+2lz4R79UY/2+AUWt0LYyvU5lAbDVR6E/KVqu1kcLdrlPyRR?=
 =?us-ascii?Q?kbd/RWEYoXaqa8ycLjpmpHVvE+Gq5ytT18CiC4BhJgUf29QTkTV15Wxcm72P?=
 =?us-ascii?Q?eHSKR7Q1e2yjed/8aI7EPVYGJFXiPQukSkO1WGCbRtaGFrM58Q5fiGPBMERe?=
 =?us-ascii?Q?pGNVcYgE1sivRGCqfV82fbj6MwkPBYEk3NNGHpKYx9+dKdzlb0yXI+S9z9TP?=
 =?us-ascii?Q?CHOH4mfOD+yeBnb+WPNEjUINewsaRkAQ4IBWyn1hTCuYV4EtjPNJU85E/wRr?=
 =?us-ascii?Q?nBWZTu1q+i5laXCd6u4MIiN2J3z4tMAAiW7tXjjX/LY2K60MZuLS4fTg65ja?=
 =?us-ascii?Q?odEaCmB0y9kaWqoxrqnRJoNqTiq5bF9eMLXIjDNWAEwCRI9/vfHAK2A4OeTB?=
 =?us-ascii?Q?OoQ/adOFXxhcwerT0nZmIBWYsS279huyzQPo0F7cvDNlEiD6ESr+sow+mo1d?=
 =?us-ascii?Q?kWO073qgRuwWdealo++U9VYJU4Knrovgz8QRtuBaseR4Tdv5f9KfiNiMrEZC?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aNTUU+RCQ5UBphiPQiYhJ2+ipoDvrxew/ApmX3+dJ2lJCJmxM9dPgXAEyIym4HmET2xEPDNZwjXCHG35Jv975Iz8iLV76kIMKsaUPecRbuvcB/z8vh2mCFODDF1afH+oEH/JJ3OtIWP8pZBJn0O6u/u5up3WHVkGsnzfXslO4WtA/FkS6YR0cYsIGGfJSJe3KFcPHfCCD9vxA7gIaN3C70wGToXOfXFYOGw6v70nzhf+ZorNxh4sCyXIKXXxz677ZLv8dFkBhm3fKr6Mvndcv1/dhmv5bgS5VK3wvJ6zOvfjaKSqej0G/PnlztB+6uhQxxirchxGi++rE8hIra+hg/7AT9BzRXh2bRi4nABfLQcuDK49ZJYjysm+KM0JJjQFKTqe85WQVqUGEAhXK7xh6+wC5y6YXKw10tU0Ko3JWg0GN/j4p5pXMEfKNix8Dr+qG61hghyz0jSUc2OH04bQvMVM+x6Kx51DufiZf/aftb6AIYGF740NyBbZR3mjoJ2Do0eam757ewZVOYTHWMfxcDBPfhQf0B1fVwaZ0Jnzp7R+90NlfrjrEcpRuJBkv/FPDAZJ7wHHRJv9dwcRFtSIi1tJN7Bh60UclJITXd1E4+c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bf6ebe-d675-4ffb-233d-08de1e1860c4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 16:11:58.5373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgIHUq8WVOhru5ZPYVW8ZKEEu4VhyF0Gxq+rXCMSn4umhxhnfzCcgjWIA/7grlxohQ4ZRMLBCk1rCYu7tDsq9CL0AdDxpcIZ6uN2ARElVTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFADA73EAD2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_04,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070133
X-Authority-Analysis: v=2.4 cv=ENcLElZC c=1 sm=1 tr=0 ts=690e1a55 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=IcRkW2iUbUO3PZho16IA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-GUID: ASvs0fGSTzk5mKsVlWHSAIZ-ZtPebki_
X-Proofpoint-ORIG-GUID: ASvs0fGSTzk5mKsVlWHSAIZ-ZtPebki_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA3MDExNSBTYWx0ZWRfX6sM6BQ/Qsce4
 FarALepbnGWdjpUAcLIjXWlMkbzwexJFamSnW3Qo9HPYtksvCoADwlguGyNYNH4SUOImzYBJkCl
 BJUMZ6wztSJJyF49dLVWRr+5K4CuqfB761imdtxzO3IKNzije5vhJwNAMzCrgCQl/TXoJXdJzTP
 rJMDjB4do7pldYe/85Gco6hLPev/gg9rBIyipktLXFHVogWc9DclhucYOPfWizc/ThjlrWReZTI
 7jvmLYKOl6YiCfj6vZ+OktCsuQ7p5jrwL+dPWKTAzPcT1X6sKgOvuWP62mjKZXHj4U/ASs7PNml
 1QpVOCESZZ5BHMvTZHvUqdNxDm9EtYohv0a+Z8WItM6PbYExnsi+aBQ6VNarg56GIrZ7XcukjCf
 X17NMlnBLEN5DWW47AA32RWAhnAWUw==

Currently, guard regions are not visible to users except through
/proc/$pid/pagemap, with no explicit visibility at the VMA level.

This makes the feature less useful, as it isn't entirely apparent which
VMAs may have these entries present, especially when performing actions
which walk through memory regions such as those performed by CRIU.

This series addresses this issue by introducing the VM_MAYBE_GUARD flag
which fulfils this role, updating the smaps logic to display an entry for
these.

The semantics of this flag are that a guard region MAY be present if set
(we cannot be sure, as we can't efficiently track whether an
MADV_GUARD_REMOVE finally removes all the guard regions in a VMA) - but if
not set the VMA definitely does NOT have any guard regions present.

It's problematic to establish this flag without further action, because
that means that VMAs with guard regions in them become non-mergeable with
adjacent VMAs for no especially good reason.

To work around this, this series also introduces the concept of 'sticky'
VMA flags - that is flags which:

a. if set in one VMA and not in another still permit those VMAs to be
   merged (if otherwise compatible).

b. When they are merged, the resultant VMA must have the flag set.

The VMA logic is updated to propagate these flags correctly.

Additionally, VM_MAYBE_GUARD being an explicit VMA flag allows us to solve
an issue with file-backed guard regions - previously these established an
anon_vma object for file-backed mappings solely to have vma_needs_copy()
correctly propagate guard region mappings to child processes.

We introduce a new flag alias VM_COPY_ON_FORK (which currently only
specifies VM_MAYBE_GUARD) and update vma_needs_copy() to check explicitly
for this flag and to copy page tables if it is present, which resolves this
issue.

Additionally, we add the ability for allow-listed VMA flags to be
atomically writable with only mmap/VMA read locks held.

The only flag we allow so far is VM_MAYBE_GUARD, which we carefully ensure
does not cause any races by being allowed to do so.

This allows us to maintain guard region installation as a read-locked
operation and not endure the overhead of obtaining a write lock here.

Finally we introduce extensive VMA userland tests to assert that the sticky
VMA logic behaves correctly as well as guard region self tests to assert
that smaps visibility is correctly implemented.


v3:
* Propagated tags thanks Vlastimil & Pedro! :)
* Fixed doc nit as per Pedro.
* Added vma_flag_test_atomic() in preparation for fixing
  retract_page_tables() (see below). We make this not require any locks, as
  we serialise on the page table lock in retract_page_tables().
* Split the atomic flag enablement and actually setting the flag for guard
  install into two separate commits so we clearly separate the various VMA
  flag implementation details and us enabling this feature.
* Mentioned setting anon_vma for anonymous mappings in commit message as
  per Vlastimil.
* Fixed an issue with retract_page_tables() whereby madvise(...,
  MADV_COLLAPSE) relies upon file-backed VMAs not being collapsed due to
  the UFFD WP VMA flag being set or the VMA having vma->anon_vma set
  (i.e. being a MAP_PRIVATE file-backed VMA). This was updated to also
  check for VM_MAYBE_GUARD.
* Introduced MADV_COLLAPSE self test to assert that the behaviour is
  correct. I first reproduced the issue locally and then adapted the test
  to assert that this no longer occurs.
* Mentioned KCSAN permissiveness in commit message as per Pedro.
* Mentioned mmap/VMA read lock excluding mmap/VMA write lock and thus
  avoiding meaningful RMW races in commit message as per Vlastimil.
* Mentioned previous unconditional vma->anon_vma installation on guard
  region installation as per Vlastimil.
* Avoided having merging compromised by reordering patches such that the
  sticky VMA functionality is implemented prior to VM_MAYBE_GUARD being
  utilised upon guard region installation, rendering Vlastimil's request to
  mention this in a commit message unnecessary.
* Separated out sticky and copy on fork patches as per Pedro.
* Added VM_PFNMAP, VM_MIXEDMAP, VM_UFFD_WP to VM_COPY_ON_FORK to make
  things more consistent and clean.
* Added mention of why generally VM_STICKY should be VM_COPY_ON_FORK in
  copy on fork patch.

v2:
* Separated out userland VMA tests for sticky behaviour as per Suren.
* Added the concept of atomic writable VMA flags as per Pedro and Vlastimil.
* Made VM_MAYBE_GUARD an atomic writable flag so we don't have to take a VMA
  write lock in madvise() as per Pedro and Vlastimil.
https://lore.kernel.org/all/cover.1762422915.git.lorenzo.stoakes@oracle.com/

v1:
https://lore.kernel.org/all/cover.1761756437.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (8):
  mm: introduce VM_MAYBE_GUARD and make visible in /proc/$pid/smaps
  mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
  mm: implement sticky VMA flags
  mm: introduce copy-on-fork VMAs and make VM_MAYBE_GUARD one
  mm: set the VM_MAYBE_GUARD flag on guard region install
  tools/testing/vma: add VMA sticky userland tests
  tools/testing/selftests/mm: add MADV_COLLAPSE test case
  tools/testing/selftests/mm: add smaps visibility guard region test

 Documentation/filesystems/proc.rst         |   5 +-
 fs/proc/task_mmu.c                         |   1 +
 include/linux/mm.h                         | 102 ++++++++++++
 include/trace/events/mmflags.h             |   1 +
 mm/khugepaged.c                            |  72 +++++---
 mm/madvise.c                               |  22 ++-
 mm/memory.c                                |  14 +-
 mm/vma.c                                   |  22 +--
 tools/testing/selftests/mm/guard-regions.c | 185 +++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c       |   5 +
 tools/testing/selftests/mm/vm_util.h       |   1 +
 tools/testing/vma/vma.c                    |  89 ++++++++--
 tools/testing/vma/vma_internal.h           |  56 +++++++
 13 files changed, 511 insertions(+), 64 deletions(-)

--
2.51.0

