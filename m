Return-Path: <linux-fsdevel+bounces-48585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E958AB1311
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2874D4E3E53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DCE290BA8;
	Fri,  9 May 2025 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mx2RZyTL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ExKzX6/u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23A527FD57;
	Fri,  9 May 2025 12:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792880; cv=fail; b=CxwiUyXYYhSCtmm32RhNT1Z7j/dxa9Z7xAWwGaUnXXWvxURd4HWeOCG5HyfdojpLq4xQ0V3AG4jRU4DrSGMpENdmAcHY02tGn/O/RVg3BFUCvOlN65Wij5ni36D80AIOzmxcXEWQlzBHKLFwFY1BnX8AT7dACyjqlGQrk9ArASI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792880; c=relaxed/simple;
	bh=aAiIesE96qmQRPYDCuTa2Jy8MeqcbqXIZ0MO45lldl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oJ92V0a64CXczWb+G6JuOqe9NTPVIZK8niBZFE7aKNiOCBugm2WtQPf0eHdTEzxyl3rB7Q7qokaJ21MwwucswrHHMSKN1qez4YuAyf/Pb+Ivp8P+zNZ9XgBOFZKJzRegYERG4JgkyMIrtqco1tLnSLZhr5NYWzIXKYjdBsvsA1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mx2RZyTL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ExKzX6/u; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549CDCUu016012;
	Fri, 9 May 2025 12:14:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=O2D1hIPsSKXKEaLR8PbL1FmgOm2df+18EtRbXAZxaXI=; b=
	mx2RZyTLSp0nrY2vN/Y/gwCnMNIUHUrNf0YKdXIGqVJTmPQExGCVXdGqT7xbkg0L
	fi6KEwz3CqD36NVwt6hxm+93MPuuh6XkEllg1CYMQhIyAKYe6JgyRnHTHiRH65nb
	A+d4hpVFU+dkjpeGbaTGPveTw78YR5/fmkKhK6rpmwV9feIzlp4RsUkwREqse1+X
	klUlhsYDxs9h1uWnnKzcYmOfjH/lI34H0u2X2QwSPEALSJyx4cmmPe/AKpbVqV/6
	5lRF9MmFI2XMasyZLkBmrtdXv3utQfroiLKaaGwmFoUkvrE5VhFDEkEl274Mi0cK
	1aQlZg1vY8nro7rdqv0vow==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hhgjr04b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549BQ6DT007370;
	Fri, 9 May 2025 12:14:18 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012055.outbound.protection.outlook.com [40.93.20.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46fmsbgtsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MtyWz6OOEHLOSXw08OktKEwuzILtPuot8W3o3Utqwa1eLXwvTEstn+2D4yZfKPDoCtNOH+49RRqNKHBI1d4NdgeimMztv5PExoX2sTWj4qCyUBHecU9kPWeesQpvqTHBoXt08ilRjeV0witV5Wygs0tWHe9Tnry6P/ATLegBm5MgwvM/22/WHftGK8RBBaMM66KqkakxXslgK/foCW5xJDNhtcpEi58gIYZgH/Y22isiVD/DP8amzPxrHWx8pGsu/u4/6IRoi4n7e1p2hHSPt2pR1j8BE1DbmMKNMTsb67iBlUDERdfa2fN1coK94Znb/Ar42lxCdR6ovhiVTaxaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2D1hIPsSKXKEaLR8PbL1FmgOm2df+18EtRbXAZxaXI=;
 b=AfpC+bqTqLIBj81n3Mp3c032rzPyLwRAIbQKRKbyI0A04EwjvrtWty7aadK0tgF/iGdgAMFKJVGs/gLGweSakXvgjVnWLuQjQ+lRPy7la3X4Mu48u58sD4YVeHa8yOs6BTtUwXRxqQSuPfc5ecyRAsfLgLALCnQfjJQ7v9DAv6EKSvLuo4VEMHhBfpU6ErlwNJvd2sw5q9cf/gxnuGysmNveARnZqu4Z2sRMJjtJE+wytoeM/Xvpx04IQXwbkktu1oVa42xJUGvgALbz1QgK17jFrkVlxL/UC020hsIb1IhBc7zUFHH8s3JmoIPIuHirwA5XsMdZIORffTfB0vJjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2D1hIPsSKXKEaLR8PbL1FmgOm2df+18EtRbXAZxaXI=;
 b=ExKzX6/uJ6rgh+8+JEGHuHaDULs8J+DYsB6XfkZuqlGL3upRaM1Chw7wwXUW7xu/N3avn7p6sX6CL3azc25UUxQR+9xSFxUnau/1/ScvA36/mxf8crZGHFnzE/ucZ4miU3jJtGZoLVv2OzKYVy4jwm3QQDcFvdHm6kRz5kWlImg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 12:14:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 12:14:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 3/3] mm/vma: remove mmap() retry merge
Date: Fri,  9 May 2025 13:13:36 +0100
Message-ID: <d5d8fc74f02b89d6bec5ae8bc0e36d7853b65cda.1746792520.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0699.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a070e33-7271-41bf-5b83-08dd8ef30442
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UtK6e/69+qm4tt6+7BlTJYuWmgoMiN+K/nDUopoHTzXcA5ThLln3hNlD89lm?=
 =?us-ascii?Q?3sgfX8nXDYFaJmf9k8BD+WMLLOljETuDDZXHActfLaMC5n4u5slfcyzAYdOm?=
 =?us-ascii?Q?0/sSIT4Ak43z1lD4nuKfTyxE8z0rdxLbALF5a/zxghMGH4AHcIbPuDa3whNS?=
 =?us-ascii?Q?ruMyxU/KZgeZDjhnYmlegwODuDJHjzQPa4FaFWuIxM55dEBj4Id4dpNKn67/?=
 =?us-ascii?Q?7B8nA3RhamYwAWM0WxUtCu3ghYce8QMg4SAdQzBYYpR+k93Cnjs+oZ0NVsM9?=
 =?us-ascii?Q?ILGngXSJtPfBIedOuxGYs+ZvfrvWIMtIEE0lrqnRHz+GbwkC3np1WeobyjH4?=
 =?us-ascii?Q?ka4OXanmkrM8mZ0DNn2g2vVmXeuDdUwmVYQrKGHGvq+F5Xghmo2f7ADhQz1W?=
 =?us-ascii?Q?rPE7kkNehuT+/+P/WqRSsA/WiVGuuLjAoWL+zzoc4BiTAWxrCgwiGD4Ug9lM?=
 =?us-ascii?Q?/9bnFr4eUBLLmU6gs9rnj6sW+yKjx/uwCi48HpxEYZam0X9dX3s4myzHSNHG?=
 =?us-ascii?Q?Rl70ojWvSfKjU6tjh2pr5MjjP7h00Y8br0AI8K+BrZ5usrBTEHxodKIvKmM4?=
 =?us-ascii?Q?w9KzYYnG1iF05s4Igu52AT47+S6udQ/448jTWK4QY9bkrMid8ADFZn3q7/QH?=
 =?us-ascii?Q?9OZLBqAg10MIxbhpk390s1tohdnftgMwkQ15I+L9KH9y7oH3WK8OKaU5o2Hj?=
 =?us-ascii?Q?Pk+tqGBK+y/gMI064GhG9AyBkY2yZa7QaI/8uZCKVzjiN42teA3qrNPliO9m?=
 =?us-ascii?Q?UMjxYHMXL/PlIqcczhdKJMWwcyZJY1kJDj3OLoICCcIIu+Jjg8Jne5x1poyb?=
 =?us-ascii?Q?QeH2NMCEVqWHPn9660YaYaF72KWVI1XkKjaSRXKplNnHUKU7NChuDBlafjqL?=
 =?us-ascii?Q?gUja89eKkzUTPlIrqFeDsHOPT9I0TzsFQXkS+d/mH81wcBKfa7m+SjXb9Die?=
 =?us-ascii?Q?t/PcBepvcal1NHsUqP6cdmYsg7VvelOi9tQAXDBcaessOUQY0G8ceJxksgTi?=
 =?us-ascii?Q?yWHkgILYkxI2TtkXOa65smMHf7CVwgp0eHHJ4qoseGEe74pSWSWj4IaFPQtj?=
 =?us-ascii?Q?32MDMXZYP/tywbRLdJfdk4pq/y9irOZ/YbcOWAi5zLfADp6BIAQ88xlyWu5M?=
 =?us-ascii?Q?GMTD1fkuGSysOAHAyoVL4ILEcm1GkH20tnjPSvxClQQ5Hx2qaZ2fSBZxV2sM?=
 =?us-ascii?Q?2zGwG5J9b1rSXHc0P1I2QTQggtIFSrtPMzNoVJDtU4zQngKx4KJdGD2hoFQY?=
 =?us-ascii?Q?HabFdxYXXfR5qzCNHQDyTHtWHEJghMy1n0v4E7nz2e1My75L+4F4FEGTTfgW?=
 =?us-ascii?Q?yZ62RYbGuONGDJyPPTilfbXKoPjvQN7aCx+cKiFIy7N25sPiITLE3lprdA2/?=
 =?us-ascii?Q?2HrWARxzGuGVCMdSHqiP9XdP/BZZxG+JF8xOYHyC9hf/FMQMDV8B+voL2GxL?=
 =?us-ascii?Q?/mongpYCYOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m3UEnfqvuYUTtyE9DqeuT378V5NToZFJ8HZCasaZzV8016FPb1foHgvx83cn?=
 =?us-ascii?Q?uI6+Qw7nXk7Yl81PAUUvelQYlXdNcHHEnr+wTL8VNfkuVTbUcF5AV9bI486C?=
 =?us-ascii?Q?gEIjy8V427OvdCfwaSZNzBjoPuC6+7sgE2cVzL3xgyucN3o5g6ZjkbHcCRW6?=
 =?us-ascii?Q?N66F/KRZ3NIu3pXEhrRm9pxgzBXqtq20VGNKgQA9C0N2JARPU892Tj+yVKyj?=
 =?us-ascii?Q?6nJQim8tXKe5OGQBEwCxoxvnOEgJ878pQTLD3gxUssNTSaozTYT9OmOWRQeM?=
 =?us-ascii?Q?xvL0KkRu3NLBjvdlhsSwRxmnKIUV4gNlrZyDFdY5rpbKauOORiHoMrAsMpB6?=
 =?us-ascii?Q?nA2DjULuVA/k3KqiZNxUykF2bV3ru4YOEh8ozY6q5a9sAnZG3ZE8kG1L2VbC?=
 =?us-ascii?Q?8j6q9dPzSvESAXIs+5jtTFHvJ1nsRXn+6bKu3qGMdiz+Y/Q7TQO0jzM++duy?=
 =?us-ascii?Q?u2BB4VcvoGPWfcGWkZIm20xZ3Cg4sqrnqQzZDafqSHtibU1vtGB4ZV/jgadA?=
 =?us-ascii?Q?kEDHy0vuJLpTGKnbUnu/flFO9ErQD5SfNsfIbYULiKBbrBRgtQesJf45Abh0?=
 =?us-ascii?Q?/4IWxnM3o63y7ze4oFEhtmBJRouaFqiLBjAbvbTDAbh1QaFkfR8M5Qt6Yc2B?=
 =?us-ascii?Q?Mx8Sqa5Wn5N+hpsYRkoXE6XO6Grp+cERLMHtoMsq8DjMAhGXr899wAIHUAC4?=
 =?us-ascii?Q?3A0yq/SrJer4wQwUm9eNEHiNopBbJ1v2YqeFkqrVngM+4b5vo4pVYc2p8qZe?=
 =?us-ascii?Q?om9WNqA0ZQa7SS517oqrFXXSc5z1pTflLwabym1STgGwu4nKy9PVyVLvvQly?=
 =?us-ascii?Q?Zbuom6f2Q43VQ8WSVwiAAuqJv3fggvdeXNLoDVz8V6ZmurrPSCAt7XgVmTHY?=
 =?us-ascii?Q?UoWARPLpAJ/F8k1HSQKD6nBecaHurT2/kXmTWjZAaATwldUMPUcAVo45y/yM?=
 =?us-ascii?Q?LM+9Gk9GDlt5cCVl2O1QtzckXKHz8kyUXvyCgf8hNTdL5WJIZ8o6NVaTXRKM?=
 =?us-ascii?Q?bQQMizDBGE1MuUP3tLIp8nfxBoXcBIRwkD0/+MHzKSuz1xsMekzEKXhw9SAr?=
 =?us-ascii?Q?CAZ7SOe78FE9pFsdNBB8vMYrKwpabaJK96R9QdORePs4TgxOBtVYwBoecAW0?=
 =?us-ascii?Q?jjosqTtZdz01ZHtKdiDDigmvPZclmmn9Bar7oxtxLmhaOmkDRknAEr1Grnl6?=
 =?us-ascii?Q?SJqfWfpZS8ndsy12BDkrohNyUuIcwWnL7247paU+l2YzkTHW3I/r6E7RKZDb?=
 =?us-ascii?Q?lDGf0aNQDN+9uK4lBVq6YpiQZf5roUpowD656zbB+tT656ia/SeKtvpEUBlt?=
 =?us-ascii?Q?mi9el7bZ9yQd0Yism3KF6OskfAgzlr1SYNfjKngmVtU/WLaBy5cwpRFFWb/5?=
 =?us-ascii?Q?B6QWVzzkib553BsGSln6z8Nqz7dDQRlbevtUxh6/rnCE+ZLgyF/4ASUI9QbU?=
 =?us-ascii?Q?KpOMVVPTzSnRlR37EQLsz9eK7iF0PXyvBi0fYLTLvNKjL15JJgXRstBb3QpK?=
 =?us-ascii?Q?WgqCr9rc33kZr63MT5sg3jjUaVksRwAPgy7inaS8XZqkC6/v8OhBl3AOw6K2?=
 =?us-ascii?Q?EGGstyd7yQvGS0E9tJHumjckB1Eqn45RCKqlZlc9bgd7Ap1ElKnlDFD5S5+n?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/XZ2s6NMFXco0gfoJG59NxQJ8P4ti5QoNhAYFcYxQF3NS20Rf3xvWtTOzcEZ1gJpzY2ZVS2+l0BkngQiNRMbHeq08pLzaYVEAD4aT5wgVrguJs8MeCVvGXfIRJkrHDQ2IMRb9BT69m1iep/Lw2OMh7iUieqar6W2DtEBkXXQz4IV6SlINPchqzt+jV6/YdP6SrFJr991vBlc1AF076mDhIhrzbGa3riOTBmbBpShkJUb9PmH6L7j43EgQzGMWtOGHkpUDxS2MNqPHK0E6a5Qh67DFb38p0tPFHdAX+15tkFNN19xT8wK2uckQ4nROIfeyNbTdqlcEuhVp+s6uYR8vw2qblcQP4OECc5VAlMCX/J0cc6nw+tM2lQqgrbnusD2M+pLou2bQ14lnnKv27+gbbEINgco6ul87l/izSG+Ng+RG9Yc10LG2JJdbRDU7dXhV5HxOBp7cq/6xMEPBq4SHDnmwZfpknU0LnwBodcWs0w6mEa+krMOUbOznnCYvfzLuvGRw7Ji9MwhLMi5nmC8THrsePZ4jXkD6goYjFysvZJvCvJnvToGjjdtdFvplGw7YNgXcTuV0etPueh4k1M5ZeohDuFRXZ7suj5XZXSuVvQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a070e33-7271-41bf-5b83-08dd8ef30442
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:14:15.6879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYLAlm65biQdeFtQ7O5dmN9dZGmAfsJfDI7e3JaGD6Fro+QRs+yjE9zEWBfm4QAn+dLZCeHv8UaIH0LRmjjqttvgc2mDbCtvjMOWEjsikQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505090119
X-Authority-Analysis: v=2.4 cv=HOjDFptv c=1 sm=1 tr=0 ts=681df19b b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=KWrF3PiNL9PbMbJVJAMA:9 cc=ntf awl=host:14694
X-Proofpoint-GUID: G_ayZX7oU0OPlVP4HNueKPEEfo1pfV9s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOCBTYWx0ZWRfX4qyYHUqsziFU CmozkbcOhiynrB+/LHgqfAJcxmoEQ6QZNr7Msux5Fp/hTtaOOeBuq0UtRE+oC84eUMa4AR5NJyy Sa5SRxq5cm1jbpVIDOCEpxz6bl9hEsr6BBlJ8eQCJTIs2vw9+/01644wsN88aUHIs+vgOBLTTux
 Zz/Ip/SVFwcIShjtAKFu3OlKQ07rwFp9ZVEVlkWiu58dkeOsUq1nPPTsIXEm4ouemUMrYn7lDGn NbtU1m95k/cBS4OXJEndWrsuqqmI7mrrsfuj44wcfd8SDizlMMgLi0SM0e8VpcUfkZKx84ZII4W mmgJS1B6UaGNPD6/S/G6vap8VMnQoZgWZxmqA6YUsfdFXufRJMke/grtYqFWdZSxYET8wAVn4Js
 C/Ts4twYDUGYGI7J0UTaeVCf7zCLqjwb9O/uymBKZZHUxCJWt8QKmkmr1AZ6bYRV2gicxwN7
X-Proofpoint-ORIG-GUID: G_ayZX7oU0OPlVP4HNueKPEEfo1pfV9s

We have now introduced a mechanism that obviates the need for a reattempted
merge via the mmap_prepare() file hook, so eliminate this functionality
altogether.

The retry merge logic has been the cause of a great deal of complexity in
the past and required a great deal of careful manoeuvring of code to ensure
its continued and correct functionality.

It has also recently been involved in an issue surrounding maple tree
state, which again points to its problematic nature.

We make it much easier to reason about mmap() logic by eliminating this and
simply writing a VMA once. This also opens the doors to future optimisation
and improvement in the mmap() logic.

For any device or file system which encounters unwanted VMA fragmentation
as a result of this change (that is, having not implemented .mmap_prepare
hooks), the issue is easily resolvable by doing so.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/vma.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 3f32e04bb6cc..3ff6cfbe3338 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -24,7 +24,6 @@ struct mmap_state {
 	void *vm_private_data;
 
 	unsigned long charged;
-	bool retry_merge;
 
 	struct vm_area_struct *prev;
 	struct vm_area_struct *next;
@@ -2417,8 +2416,6 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 			!(map->flags & VM_MAYWRITE) &&
 			(vma->vm_flags & VM_MAYWRITE));
 
-	/* If the flags change (and are mergeable), let's retry later. */
-	map->retry_merge = vma->vm_flags != map->flags && !(vma->vm_flags & VM_SPECIAL);
 	map->flags = vma->vm_flags;
 
 	return 0;
@@ -2622,17 +2619,6 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	if (have_mmap_prepare)
 		set_vma_user_defined_fields(vma, &map);
 
-	/* If flags changed, we might be able to merge, so try again. */
-	if (map.retry_merge) {
-		struct vm_area_struct *merged;
-		VMG_MMAP_STATE(vmg, &map, vma);
-
-		vma_iter_config(map.vmi, map.addr, map.end);
-		merged = vma_merge_existing_range(&vmg);
-		if (merged)
-			vma = merged;
-	}
-
 	__mmap_complete(&map, vma);
 
 	return addr;
-- 
2.49.0


