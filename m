Return-Path: <linux-fsdevel+bounces-50084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9CAAC818D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 19:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7FEF189644E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 May 2025 17:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C9922E00A;
	Thu, 29 May 2025 17:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V9h64E8N";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EynzZip0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1221632C8;
	Thu, 29 May 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748538992; cv=fail; b=rA/tR65ebRuTKq7xDboPPpPTe9iS7CRsP+M5ZuRC5V5pPxItQvRQQCi5hmF8ONwVGQjeRorG6WNd/QOaLUzmqDiIYtu+j1TZMNxc4s6zVCg5vtKU1BSGP/+6A4G5HnjYGl7koFDzmyrpHwYRhbJQq3ZBa69sIwt4CvubFUgewpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748538992; c=relaxed/simple;
	bh=mKSBi8X2TE0DUWs4CGp394x7Q9ZJuY8QmK6u6DNOwOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RJHeDdJEbudnydFC9+5xZUiUMg48vcZb3E3kK4QbdKrDs+0jzwh8hPIPPGx9ghL3M44CKspJPiYF/BMcPK8qcfVlV99YrMAmumVp9xRINCIl2CG+nMdorbUB+9Q25g0BBG/ilhVgajlA8f1lor4mAzZbJEN3vzTcCMEXVTch6iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V9h64E8N; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EynzZip0; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54TGfsvJ031400;
	Thu, 29 May 2025 17:16:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BgOpRU6e+0oVayprSXgd3xQ5Q5gaHzFLy9ha93hCD6k=; b=
	V9h64E8NAN+dpk5KxtIwUoyu8/NmNtRBh8n1ouzlqZKu/PoWOupV0p8xkCmsY9FN
	WXqto9h9jMxXKPficW8FfHhga+aBiekn/maEOjUL5RhL43XXXq8+tPrGcOF50bmk
	p2RUP++DrQxvB4UAa4jVj/zM91uEHCyudogLF2Ta6xx4SCzRNZ7jfLPDp6XKwC4Z
	OtRUYvQnIJbRJabwGbGsV2earo3q8hkJ6zBqthASg3k18EwEPtLb19s0Va/uzhX7
	bZdaPLoJMqDB3BIR30pkJWxZVbcX8J+C+Kp3DJbK3TMH9KMYu0KUnDZSD9v8fPI5
	5Xhv0JoSZLhNqJ7ktP5u0Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v33n0qn5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:09 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54TFr56S025467;
	Thu, 29 May 2025 17:16:07 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010021.outbound.protection.outlook.com [52.101.56.21])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46u4jjfrtc-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 17:16:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXPSKNyqd/pYEYQO4rU5VKXyyB4XslO5EXjJb44iiInaf2D1B9DigLjlUuYd5UdA58ISdMrh7DrQHxYrw6uBgEW17Xidd5m4pWq+QbC4Nh2AmukwigBJCYBsc1r1Xn60BIAHNXKXsUrHhf7w3qCchsWl6vVAE14c6EmqlYHDmPviD7yWbxYImh3telHpsOz35DVz1bwMatF8hHEeuyFWuOTDGapkWjBQqmf2bpa1KhHcIJl9u+WEyD5imA1o/I0eZKySYnPvCLN0ciBGwHLqfkhQ9IhLPGlglPcHAVIi87G2iQYl4+TIqizHNvh+MQEuKEMCGY6wZpvcB1fmbQrHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgOpRU6e+0oVayprSXgd3xQ5Q5gaHzFLy9ha93hCD6k=;
 b=kYigB0H0lcUsqbi2e/KV5Har8NwWS6bapNz3ZZI4IyV7/z/iyaIqB0fbRDCK4uo9H64FleFZU180OB++xZ2dxb+xFzt8B/c/EA/6tLLFj/0RUh4UdkA3TvloUsjIhQtNMpFwnGhBLw28STdJxL1UegVoQzIGPs/2nZYDKkrt/Fnfw1qhx68Ra0pudIPfRmMRiUMr8NSDVHbCCXIllngyo2PP+WbrxMvpF4xAxk3x4d9tsobmi1MYDHRZXtcA9UbZS3Sjmwu8OeYH7yOrkNPgjE3hjRxRY/UDprqbVtbFtfwj3oM7MHK+o4Dn91db5kdAfpKAnhyMB6oK9mnyfFKvvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgOpRU6e+0oVayprSXgd3xQ5Q5gaHzFLy9ha93hCD6k=;
 b=EynzZip0iCt+IV8AbtPNCbZjwe/DOIc5SVa3NV3O+cq2Gh87W7aAasNDksWCdCquG75KGyQTfeGwsLjjCeYhS5CBoluLRu0gKI/H84jBO/RQXWHzZYMkZ2RYd7tTOL3UapVPO6OSQhSQE0VRsHgq17m62mxMgyZJPVAtDtGzjeQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV8PR10MB7991.namprd10.prod.outlook.com (2603:10b6:408:1f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.35; Thu, 29 May
 2025 17:16:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Thu, 29 May 2025
 17:16:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: [PATCH v3 2/4] mm: ksm: refer to special VMAs via VM_SPECIAL in ksm_compatible()
Date: Thu, 29 May 2025 18:15:46 +0100
Message-ID: <c8be5b055163b164c8824020164076ee3b9389bd.1748537921.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV8PR10MB7991:EE_
X-MS-Office365-Filtering-Correlation-Id: fee3d41c-2a01-4010-f630-08dd9ed47c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CDBemeCP3uA6oPSftiW+to+Lveeocgxa7f0+mbKAFDT4qYmVNiQsqfn0jmOg?=
 =?us-ascii?Q?y7Wgh54E2uiF4xExbdqhbkk7Ztn64Na2oN9XHiLa3ZZlCcyxaDfGlKS+qAOL?=
 =?us-ascii?Q?zKsYyNbglGachaBUtFIKedB9kT+SCrHC1BEgd6OK2g78/9IMKorsGzKEdg9Q?=
 =?us-ascii?Q?l0HqR0+b/x2HWzm3uoWc93cEmzNPyuexEWfojygnzeWc4tPAvavdqFwQYZ6v?=
 =?us-ascii?Q?Qqc+l4SvVLYtP0bGn/6qRettHIMOAWjdDVFE6zTI+qDqTLk5ZghjynQan5L8?=
 =?us-ascii?Q?vjQrp/Sou1Z3/FB33xm8ZqRUWXqwalWyfnRXxMCrXuWEp5Y4vMuO8ZYOhs9S?=
 =?us-ascii?Q?Fk90dfGmCzk84ZPYwweCtIc00QBwK6uiG8EPSasLYvTbfDzqDdPV1HnX1CQj?=
 =?us-ascii?Q?hRpnQOm805S7LNkn9AfHxA+TpfdcCNN2vGdpUYeft0VCffUVv5+pURauPmZD?=
 =?us-ascii?Q?uw3oYMj76JjZ597JgbRWX/3L0iu36Soph+CLn7wv75E18CP4jOOi39tjUnxM?=
 =?us-ascii?Q?Ei8sT/hEDnqdNz7pHY3E15vWAS+WfXeM2xr6bYUm/Es/0ZNGcp6CZ+6+GvaY?=
 =?us-ascii?Q?EIgquc5c2xd4bmAhEL6x0GQjJC7+7MLOKiwZoB/JrAGuWXcy2KY4JptIIS6z?=
 =?us-ascii?Q?78U01NztcMv2eYXwKlvo/q0qUISFvrEuAYn0S/fpkJix8ueEhrq1FWP3SSBa?=
 =?us-ascii?Q?dHJdTF5HIGnOicY53uWlamNXUIDz2O8ttgyE6Fpndk7Smg74T5Lynsg6YpNn?=
 =?us-ascii?Q?38kh5+l2rkOhDApUJYaHeKqgxSdLtrbcZXNb9JxiYMv+gV5D9CXq8kDpg/Ux?=
 =?us-ascii?Q?QyCRX6OyqST9FvIM19TpavoBVAfK6tVVHwiBcyvUE8PAlxPmU36ctl8vFOYH?=
 =?us-ascii?Q?aC8eDx6DXYY65+17yap6wbmYnDEGjNfeLTpEGfgf52CL2Z2wBezJbd16w7M4?=
 =?us-ascii?Q?jTv0GbLgyiql29GHBOGIU+GbFoop6dATmUQ8qbe2kkX7KQ1PvU9UbMBmaQeX?=
 =?us-ascii?Q?6l7MqFukrlFbflZ32e1qD10c/EAW67p7x71iq7H/QufkuewXjWUfjU9RyTon?=
 =?us-ascii?Q?G7v5h91EChkcgbdO5WObypg3Ofa3fKabyv1YRPrhl+vZvuQMeVBf+cQ9cmNu?=
 =?us-ascii?Q?3GhYpBNr3n0dwzHi6GNNBxt06rMGBQo8iltQYNx7PSWAGg5HDFeLp+4/JYop?=
 =?us-ascii?Q?SiU7I2wMZX6kY4JlXgRQD1JAGQXxalqMDLC9p2/LNPeRzr2W2UJK0PntX7S/?=
 =?us-ascii?Q?KKLStk4+P/QTKsFol2OGr83dSX/+k5a1ibDa+z5Fmz/GYzvFOqEheo5NCYtA?=
 =?us-ascii?Q?1RxG2huxECQbQe8qcAndNanp+RDa9ALYdcULNGdfrJMI+IT4J9q3V+TeIymr?=
 =?us-ascii?Q?ppbGkzmqAXbf/sBRrNqGh89JTOIaRuiU9mqG4G99Rsi5Vp5eQ/g2PPk3T/Vv?=
 =?us-ascii?Q?liVYYSUTFEk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5wpoZh+PWF5smRPnOvFT3SKy6Ed45fkfOV+JJ3oVKclQ0Aml6DQ2yyDW0nGS?=
 =?us-ascii?Q?zYw7CwyAz7Lnb5JTHOYIKKJhfZ9balZcEPgaBvllu3SZiTh7WSqjZmjxVoxq?=
 =?us-ascii?Q?COYWmrOudmDlBq2QC/1RKwx6XD0GPp5iiOa+6Yy8gsIXkugK39L92t4zVLBU?=
 =?us-ascii?Q?y3LF2w40AAKgNiTNqn5PM3IDrw1qwbZPwW5HmHgS0tQar4dKhTm4OmAcDUQA?=
 =?us-ascii?Q?XDtLkyEFz5RqWI+tOLXvwVEbLcBvVNc1ZH5x2Nnixz3zwwtTfWYmOeKi8g+G?=
 =?us-ascii?Q?OmchPz133s7H15XWf6TWT89xoSwx2RmjNum9mDo4BfzBB4lTw7nnzacClrFt?=
 =?us-ascii?Q?19Xf+30A5G7lgzzvevdwE9B5yDDCXpGgus4FMBbG6GyXCbhMdePRxBcJuVcE?=
 =?us-ascii?Q?BBpkCAIrnDmcH4iYT1nM9VaamdNNO0MZuSLfKReV9sJV8Xy+1d9tcdbcwqI8?=
 =?us-ascii?Q?5GcAJRhX66/4IzxVe7drYAZVDlZo8eoMDp8/WIqFal1C3UCICxHIK3newhQO?=
 =?us-ascii?Q?KqOiXIH0wzhNGQVl98oZVFuLyoJR17EY6XLlsigpp+MyrqhhjmJFHWSmRujk?=
 =?us-ascii?Q?0cdxDn64eMI/LxFaKyFANAdP5Xnn/bTbNlVIz70tG6CFDxkqSkqT2oVFUpk0?=
 =?us-ascii?Q?EEYRBhhsqDkWmqgfcx8GwRFNpU8eBHfX038TbSVJu2ZfxUYzbwPcQi1FweeI?=
 =?us-ascii?Q?/jHxJYHmXmt635P31PrkwmoakurGqPLC75MxDqAQL0xSmwru3/bXM/r+BhOr?=
 =?us-ascii?Q?k2c2EDXiAUgxPQqtgX1o4yTdPsIkqd5sSA8OnAAcaECPKgYGJQWwdVsqDnpp?=
 =?us-ascii?Q?81mTvo1GyH9K5VymMVebbhQtPAV18bFa/L5jPo35TpwVB62b6b6VOK5JiRn1?=
 =?us-ascii?Q?J6qh5+JLn59/qFtqf07LEYQJirM6ORPBcm1BbBJks3l1U1dsO7wkVeWSRjQY?=
 =?us-ascii?Q?oIhXaH/ifvaDNA70KwXAG5AZe3dTqrJGNLDDAFy3GTBJrIsYbKOYxchkGiKW?=
 =?us-ascii?Q?ttfnUuefLX2+Wj1GZtJEhLiZLqN/ut8fZiYr6b2sdhgDHe2E6kPf9GO65Wmx?=
 =?us-ascii?Q?GzsFor6hVjs+OMSey9Io7YeIbE9vOsdABQmJAlNXE43/uU6RH/6A48hEDlf5?=
 =?us-ascii?Q?icXoB1ZufWZyK/gaAdkTKOnnS5C5rF4lai33VjkuR/9Keoi3tHI1Jg/gKDg3?=
 =?us-ascii?Q?VOMj+UjMbG3O9I2oQS/8ct0wk9j9CqrCI+sTubpfnMhWG12h/UrifL03MMse?=
 =?us-ascii?Q?eKQR1bF4vmbu2+/Cc8OxQGoZ3Z1u44RcvY4ZjFOqX9xNITuMrfIkst0cVDwb?=
 =?us-ascii?Q?6X4sMyUdiY+qXOMfL/E/o++N+9xK6pSN2xr1r67+VSrZHJKnV2WwdNxkHtdt?=
 =?us-ascii?Q?Gwyn8Uurahi/EqZ6H7aHhVvcb9Km5Ty/KSlRFl+TEAdUen0txPzr2tV0gLFL?=
 =?us-ascii?Q?ApICN/6RDjaNLiVMdWvfoHslR68jj6qd//Q2BdNEjD58VLS7sHIqDhbu0TRC?=
 =?us-ascii?Q?bv63tBiSeamIycvOVpEx1/2mt8WPWKa3zF6qalmih5aIWNhYwzxVscfJONc4?=
 =?us-ascii?Q?ZylaflmvZW1dp7Y17+dxW6K1NmbjP/cc51kbAotyTGY/S0/07acc9i9qXOyI?=
 =?us-ascii?Q?jA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Xmh8KiyRMFG1eWt/94mDnD/Y2pN/htHtofNyFadXMl6NB+qnMm+mpEHQ1mlYAM6xVrmT0f1EascjVJOg54MKtfF1o3/wRvxADyiNDvllu7qbxsp9RkGvK5yMx9QUpF1sZytiv31xjUZ/+sWdCrdDYB8+mOfx38tk4Ce8NmoO3kR5igwazwDB1y84jSF8eIyaJVp+FzCBpIrb32GHYcZMEnld9LG4ahvsKUE5BnXUQFGKfHnn8sL0ieLZJ1wuZ4ZBbON6hQ60/Wim7Dv5niZgmA50Lm5R4sJx9g2MEeUCFmN5/2B0wXwXpXL3XvxSlOtW7jDO7avjuHhm7kJ56321COinPRady55GA27r2igFgibvKuIvx2wYyd4FywHuI6uxwrPuQ/vmQ4niUSvyNdQOFYOI77SOWdQKBhisWQqcVyIcp63etIDaOzsEo+XbDKXxkRphZTmH19RUcGxoCsAQeV6eWJCcMdGLki93IBVvb/XmmsxqCdkJ1FjZJagmceZq6x05318PMABVpD0FLfL3quaa6GjscUsaBmsvdN9l5K6Tqn090S6wuWJgazNr9B3AoM+7NTqDKBbL8KH+co5QEhaeFV1JCa+Ep2qr0o2WDcQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee3d41c-2a01-4010-f630-08dd9ed47c9d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 17:16:01.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brWjZWBO85icQ+D6TeuGRA13R/t97gMzJVeAV+3YYEWb2GEwOISTo6NDGuNZnlKhitfotyfEpx2qL/t6Hy4FZFRKixp82vN6qjltJ44Hb6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7991
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-29_08,2025-05-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505290167
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI5MDE2NyBTYWx0ZWRfX/79jz7lyxwYc alpBUAgk60vDWq+Eiusd7o2JV8G1SLJumfwNI8CEMlrMz3SHAhQWK723MrGpL9GyWMe3HKnO9tH +iLn/lqk7Civ4Eyx+ac718JiY1E8lefn/iAOdBYqmBEdaq8xNI8Wn2niQ8DGdt6KA3abxRyF6yq
 qlzxt2bf4vxoPSAwdX1hdbPGdiPNj8cOXL8xJvKPx3Mrh2mOThP122Vqb0ti0tuM1WqLaGKTON7 YfqkbGoIqH4ILXeDnR2tb4h4KkbIxpvUVF531K6vj/Ih0CLWi0COx+JSpVtikhq1DIx4362Pf+Z /Sx2d3+YTpkYtCbZvGwqaD97WbJR2n2KgkLyCGOP0tWmRXmpXV7GMagSYUhDug6r8ybWYhJXSvg
 qe9Td8tiZ87SU3eddLlGQoh7F2hBN5Gjyo0JG1vr7nRq/EkjhTwHAgHUOoETd+35z/jv2ZrN
X-Proofpoint-GUID: wKXaKuvc2dfOKkLNUwf3F_Ozlx2WFr8F
X-Authority-Analysis: v=2.4 cv=aO/wqa9m c=1 sm=1 tr=0 ts=68389659 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=1RTuLK3dAAAA:8 a=1_DYgKdPc6LgM0FaWyUA:9 a=kRpfLKi8w9umh8uBmg1i:22 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: wKXaKuvc2dfOKkLNUwf3F_Ozlx2WFr8F

There's no need to spell out all the special cases, also doing it this way
makes it absolutely clear that we preclude unmergeable VMAs in general, and
puts the other excluded flags in stark and clear contrast.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/ksm.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 08d486f188ff..d0c763abd499 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -679,9 +679,8 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 
 static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
 {
-	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
-			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
-			VM_MIXEDMAP | VM_DROPPABLE))
+	if (vm_flags & (VM_SHARED  | VM_MAYSHARE | VM_SPECIAL |
+			VM_HUGETLB | VM_DROPPABLE))
 		return false;		/* just ignore the advice */
 
 	if (file_is_dax(file))
-- 
2.49.0


