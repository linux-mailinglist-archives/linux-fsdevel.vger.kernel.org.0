Return-Path: <linux-fsdevel+bounces-48584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2AEEAB130E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 14:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 151051C03141
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 12:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722B28FFF0;
	Fri,  9 May 2025 12:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pog26V/T";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ngz1Z+UI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06F7A2D;
	Fri,  9 May 2025 12:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792870; cv=fail; b=uUIxtZaIHoqb5y973TZdKFpM2IyP9x7EuzlcDaKniFxIbEfsEoCgRD89KmD0ZqTndsNuvEzGB3Bow9yYjTMZP3whiRJ4dj8DfT83faNgK/LKyMH6X2yqAI8Xc0jBxEkDN7cyEJ036qv8Hoyu56lVk+Z6RrIDgtyxldWDN8RHiDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792870; c=relaxed/simple;
	bh=CfSC8moS/tjPA+gWhZ4OjlPcRIX6q7cdYpg4tWf0GKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luJgh0KCJkOWTO3wUzpoT4qdQpNHTUR50/gkMj0MYXQr33n1FKeAMvrTiXZEWPM+JIOIcI1L+sX0wcX6ZgQ4mR/4pstIksXKf271GUvpucIOuKdqy9E6O4FcQoXb+s5PplqY00Zhq65YK6IhWdiC/zjmeodR1qmGl2VINJ8dNmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pog26V/T; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ngz1Z+UI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549CCcLq015768;
	Fri, 9 May 2025 12:14:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=F/umv6SM8lv90d28JgH5BHVZnf9pM8OMMpbyh9C2mSI=; b=
	Pog26V/TYdZqLsmZccXr+k/Jf2JANA4Kb0cFXEhbIbuPmI95twcQ6e6hc4oGDSpR
	Rmx7wF+BfR9vsOGDe7iZQ0Yqu+pCEs2I3GHxvihN3YtWAdo0cfOZyrogO33KMMwF
	KOP5j3br1WNNPFkKSHjTLFO6431E3S4+Ni73imfuiFKl9oqV5sWAKkojDtUf5HG6
	E8pb/vQexx4HtmNQexmj5jMz8Yl8ETEfPOd9+U2LJl3FmloUlh6ONqDCysX7zII/
	slIeIimPu17gH3S37ZzzBSqtveRsYmx46iLU1K7NKP++ptEUzSX/oqrvN4ReqeNK
	yBkLQ2b2rEpg6+jiVtejlQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46hhgjr03p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 549A1gMc035454;
	Fri, 9 May 2025 12:14:07 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011029.outbound.protection.outlook.com [40.93.6.29])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kcx71v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 May 2025 12:14:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1JdNvkGatKbK+eIotoJfJxmWTRIyCVdNK59MrRCJZfU/2zuwkDdjAPraEKqxfcJGGedYk94T2jPpVQ8Ppn3ny6AK8ykw/BMIORWExcby4IP9HcD45dkjpMqfMGjiSNEo+0sXXOAkLcBIgRKnzPcZR05sJv86w5yyPEA8DEwVx05JiMsp7XnuCUyp8Urx69PVTu6FGgDJpJycx2b+2rt1haQnxHqV9oSGoiNVcfo78anogkB8DCCj2E8oTWDDwUCHz1/xoDRHyoKweUN4otdIZH7wtD3mC+jcT1sE8DDzBhS99AJRP8Ywh5DLlMFXNAdFHY90uDCHb4uR9lhLKqs6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/umv6SM8lv90d28JgH5BHVZnf9pM8OMMpbyh9C2mSI=;
 b=Xn28iH5+fRiEsZ7Q6JS/sPL+oCdFlRKegeWAY4OMdhDG1XeVNVNtp9q2z1FG28zJ/QDwbNQ1AmxMWYthn99hv+xIKz2UB3pYO4Mu/4O4EhgjpGwXGlWX2rG+lmk0+EysH3KXYWM6Eaj5jcLWr5sOZ0GxCSj48Cc2wD3EmyiEiXxX2JQHTgdcZfSTquERw/D3GTQB9KZPjbbcrKOxwKqM2I9d69dnu6Ekh/4Xw886/H/VtWulX5dzj04/AR0irLMqPswgWAUbNS1dcV/lv9bUidE+krJj9A9GMAi7d7LMr4MSEY8uC5I+brqGcu9V2y90b5ZMyB0NdFOzVBI+Kex8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/umv6SM8lv90d28JgH5BHVZnf9pM8OMMpbyh9C2mSI=;
 b=ngz1Z+UIz9hY0lXymoSR9XTFarz5wEQRSwbF/LniVY5froFf8WKFpNngMOImXArVrRB3JFkb4kum9M/NE8pKufZ2HL6Ogw1SPOh0jzNxFZdWmqAlwyQMRBjaNRz9o77UyK3NUtPzbOAbUp5FxYtCf7aGA0J0+HBXaaDYBVExsGY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB4718.namprd10.prod.outlook.com (2603:10b6:a03:2dd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 12:14:04 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8699.022; Fri, 9 May 2025
 12:14:04 +0000
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
Subject: [PATCH v2 1/3] mm: introduce new .mmap_prepare() file callback
Date: Fri,  9 May 2025 13:13:34 +0100
Message-ID: <adb36a7c4affd7393b2fc4b54cc5cfe211e41f71.1746792520.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB4718:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b8ae5f-ac41-4faf-a8a1-08dd8ef2fd4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3/h45/FxonngegXDF3nZ+rKr7pKx1Tlkjq/1iWFZQIZE73JEDzBzjgOrhkoe?=
 =?us-ascii?Q?f6XZGBBMYgNqWbosNjrVS/4ragAYhMEgaLI/61pFR3CnI+M1IP5bRaxz4e03?=
 =?us-ascii?Q?NZoAg+FRWtTimsXyDYVbD8Vc24wvgiSQqwmdZ8GbpDImeOqu6Bz1bwxlCz+N?=
 =?us-ascii?Q?TFzBdqDvO3BnONJK7ye3w1AskXV7zqglDkfPq/igS/X0NN5osVDtuzt22nGq?=
 =?us-ascii?Q?gnYeiK44DNbF/Ef1XgUHgC+OCiaSMj2usS1dbKbpASrXZVOW5a0lJXvk+Z6Z?=
 =?us-ascii?Q?xzY0jIrp7tbR9boEuyL/EzI9ZzKSzG8xt+6/CY5ff67KoLf/ikF5ShDXYOTg?=
 =?us-ascii?Q?6nU+zTW8ShojF2gvJvKnwkraNOVjaVV4S4IUm7I1xif66KGkX9dYg1GHKPIG?=
 =?us-ascii?Q?dOKr36zpe16w2AB63m3TFFoi80hxfCnBIjmSA2ty3E3rfHiEFk9HjgHFDCVp?=
 =?us-ascii?Q?v8vxIIONKqHb0K8E63GccqzFDOFN8gpXTt8Y2OMlzgzBl3xJw8Gq6hnJXcLW?=
 =?us-ascii?Q?gmcNUwfR7YcZmy3+/9iGkWL/6KCfBbzfHUbhYw6ZOycpjRGATaMNHplA5Ifk?=
 =?us-ascii?Q?FjvFb2bkDpS6gYS75yDI4OFNG0hNIk4OaN5u/dJeAGSdciwqeCi1wLiEnRBP?=
 =?us-ascii?Q?cD7HLbFYCZrambSI4ONNoChLbAacRoTf4NqdE50r5/cBDdyIncFnSwzJx6h+?=
 =?us-ascii?Q?32M+0Qt4D1STRykamvoUJ8RKKnT6QsRZ+NttUgKCrmBlN1ZuEc5WQSh0Udz/?=
 =?us-ascii?Q?F/dEWAvHAtAYGDC3tJ+2KAzEGbJyn4q96jme8bCfP5lqlSF/p8fYs3Xvc3GZ?=
 =?us-ascii?Q?9cTJpU8V7kUwdDmW2NC+Qf23acfi3G12XZ163662qGMw258A1+0idaV6doZo?=
 =?us-ascii?Q?GijSFLpgtAcSeR8E6DzM1eyWmf4NDxHA43KBYFGwRRG280QZqX2zikEvgghr?=
 =?us-ascii?Q?y5sSNBV4hH50EZwckXQi4EpezEmZWrbvDQAw8fRCtKg32Nj3RktCT/gL2Vxh?=
 =?us-ascii?Q?Rmi0XcPZZFIYBoNSf1g+Qrk5zVUGZV83OJT1kP+RC2DFIVgnqOdm9SwFYY7N?=
 =?us-ascii?Q?tByTWz4jm2tb9fHGn6awj4/sOvw7YSda7wf+5muRk/RAcPQ4GoE9P/0GjKQg?=
 =?us-ascii?Q?+oeWFBWwkK9/KISOM2vKwVRToCewtlj6p14Y1TbTRGNGNKqV6OO26jCr5nOP?=
 =?us-ascii?Q?QS49d+6tVNwuSPezNq2070H12ccEsIF6i1JtnfJe+aj8BFSLkif2f9jaSGdh?=
 =?us-ascii?Q?QzV27rRKRSdCIlvh71wZkAwr2mkO1aEh/leJEzLfU8LLcKgb7sdcOutmQIg2?=
 =?us-ascii?Q?z4733bNWrg7xxM8VubFqbFqkoQeGsAE7tUXnNSuorkp9njic0Q1ZZFtvzZ52?=
 =?us-ascii?Q?k3q+fn1c6223FTnLprVKHa3GExqyKQMbYoa5JbIc4ny/A168jRTVVlTOrCDN?=
 =?us-ascii?Q?NEgXl9Q5USc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w3o9aPjCNejxINjyaPS0NH4vjw7gntoooOET4q4281vRaAoAKXb9t7QNXLNd?=
 =?us-ascii?Q?z5n7JBDRBZ2HJtg3Qs9grgcAaQYPZaLRrk4v9Y7/TzSljVKCKMDjqHESgALA?=
 =?us-ascii?Q?V5OY6lXZR9deGs5IpVMQtNCuJhpCKOB+KQ8RnkGtwFwdyU48e9Cpq8ijSC9a?=
 =?us-ascii?Q?eUpHsiFIeOSYRMUvWYrRtdu4ja9+M0Oa9A4sQ0zwudH7ToTPr/8UvIlqwvmA?=
 =?us-ascii?Q?A6V8+GnzkNnN+ZCaWln30TcSt4KMOi9oGFVBVmvpYNXMWcr2jk2qAq2lUnME?=
 =?us-ascii?Q?zdN4MuSRKT6OPQcpr9fK5Fk7ZRsAMG1/jvY8slpiMGt09pTJ9H2YtbFUB6aY?=
 =?us-ascii?Q?rRMxq3RR5UVsSP/7Sn2aM7ni18/WL/lia8k8VeDvaVkr+dIqnOL7xi3y9QK8?=
 =?us-ascii?Q?GGUfluzgSboDdopSWGUtQxXsgfG4WjEnPyO7Cn3yIZ0urjkL3JiJ0LbWu+Cf?=
 =?us-ascii?Q?jmF6moIAFqNqBxoVZDnktsontlyeStlSHbNTl/QeQLZl2Y3IzvoHSWoaJ/Xw?=
 =?us-ascii?Q?0QYTxkWxZ9b3LPg888hpcfefAt3yL0DmPr4Qrcr2KmJ0HjcFjnDB6BO22mZD?=
 =?us-ascii?Q?Sr1zlJ3hn+mhbGJDQKiJkd6Nk2P0eUFEzbIjE6C7ZCewPmQpfo3NJDiYwFxq?=
 =?us-ascii?Q?qk/YfoLS1HaV0p8T0JkO5EgYTrxsSCb6sTjMXooq+A87FxoOiM11W2s71Rm4?=
 =?us-ascii?Q?A/imN1/R2BCx4Qi4CTbMdGroYlq4zPf2a5WzDO4jQzbpzTH+sS5QcEml+MWd?=
 =?us-ascii?Q?HD13vJbfU4r2O+zDSr9RG55Eu3sCKnyoCL1M10PC5hYP8kJLaeqmHK29X9BQ?=
 =?us-ascii?Q?e0O+Var0d2vOX8JZv8X3AORPm+ftvOF57bTyXwGB+MQ5hSceixyX5dUSwLDG?=
 =?us-ascii?Q?Aj/1KgevFSMI1BEj6yge7C6blsJmjfrTZngKa3+Jnb5x2Ab4sUKrr2LP9kT6?=
 =?us-ascii?Q?ok81UYZnsR/ev795WPwE5YG4KuPGx1pa4IiYQldiGB8n1mzfPQgmAcWPsP56?=
 =?us-ascii?Q?+PvFDQz9TM9R+g8MLOtUsCO46C6qMTJz+VpAYKtQ+wAgLo08k4qIm27z+z3p?=
 =?us-ascii?Q?sITg9FNKJLse0aHJxBaxPtbCLYqRt5sP4jYF4htR13ADhqklODwkI6rTc5wg?=
 =?us-ascii?Q?DU0kZ1m+sGYa1484jFDQBHhXfbDJVukPKST9RXtAiDT/IYckLZrYoJgUDZyp?=
 =?us-ascii?Q?9qHCQ03mnJKrfgsCLk4X+j3c13HhZAiKZGM3gFD5H5nkfbE8wc2Z1iA8h/dP?=
 =?us-ascii?Q?PqT5FIDlgJkVH3VZ8+mmKh/NL7wWMAeIUBhqD6AivBxD17rhE1HtWtfG3y9a?=
 =?us-ascii?Q?5+sRh61hKwSrP7xQqRQ7q2jWFhlyd5y6for8x2zsCDsANBLWGjSgXdah2qlO?=
 =?us-ascii?Q?PC65GeUOqzv99kZUs4f+4YIqFstajWvO+98JligKSuQVaSUHItRFr9jfuar1?=
 =?us-ascii?Q?XRhCQWudlECk0zncmF3gfodOuXraKGsmKCBPh5Du4RyCJtW3lH77aOXmA0lj?=
 =?us-ascii?Q?FUF8YA2S4Ej0ED/45dp+Bh7/fISgmVlDXN/4f60TEhOlMEBHxgYtubHBbIR1?=
 =?us-ascii?Q?nOrCLPu5SO27thnc2fLS9gOJ9++PhZaGJvLUKRpao5Ph1tOTLDZE/X4d319p?=
 =?us-ascii?Q?hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BAOSZG+LBYWEZT+Y5/umsrmh4t1kWv/K2prdeMRmYAl/HkRXk4ok2rBSBL/itSlGvoFMcNIBi90HKEVK2iSClR8HFMImt8iRalcgZsGjC6d/K1zrhWx7QU4uSahSBil+sEiFmVgWmvaFYGPaGYy71wYCRF2uoCbHwEcg78IZpFBn8keeBoxp2ZUj7ZsCwxq9mrTKSJo9j5ucNEo6ixKTZ55d8nhvqfOgfKGEH5rqKH5xPZn5F5+FnSAWa2urXHJpMJkJX3BqCcOpMRdeNugw7ZfnDuSYepADPtb+p9JKTEgyXQncp65v3PokEg+kO4VkYKSHglnOStTPiwh/1C5HH1N9yafktWjjDHG6bqme4CW+egkZ8e9qyn/v2/QhXTaTDKEvq99XXTF+nPq6KzgTU9M2NpDyUKZSYLnjJkmHf6gMiKNM0dBjgLPKiDsPuHl1HK/HKJ/ME9DbEuDlmTilLVDefH6CoGi4JnrqP6GtQqRpcWY0Zl4eCNiocag2C8Mv8pvCXMTvgP2WJuJ4Aqe+tm8fpvEBI1JvLr7ZlUmWHBeoGWTAv1qz3sSvLtFAGZ1P45iuuPy7UGS+CD0oRmO6C61IAq1f7gurYUVn14ZETcc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b8ae5f-ac41-4faf-a8a1-08dd8ef2fd4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 12:14:04.1182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 449NsqI7lfcaJsbS8wFps3SrGXWAz9WIAla2RIti+PBwUGlUp0I+VpZ+vrVTXUpVXv98waVQASdS+xgJsIJODVYrPFIndPEHo6YED2otMAM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4718
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505090119
X-Authority-Analysis: v=2.4 cv=HOjDFptv c=1 sm=1 tr=0 ts=681df190 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=BnYvykHrKgfMS8ox0bgA:9
X-Proofpoint-GUID: u1rnVcs5m-ZqMZqoWszTXfD9CR5a-X6v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDExOCBTYWx0ZWRfX4fvf5Ti8RQu9 6PFfeJZ0OGy9Vh/zbKGo7PCgI+GdazeI0hCrEwH1PzDKKMW0sW/re2u217dAuCwUX72y3DUIJjo 0+DKxvrh5Fx1nwL/NLei2BwDQKZnhULNAasVkXQhhXpP/TdOjw19yHCwldozW0tUwF9my2Z9cL0
 g0UlQT2b3YX+kKgb24BW8CvM8cfet96wYVmdvQ4KVDX4iKmJB4XE4wSuM9qK0hts9FU4b+zwDYq DUk8GD9+pxPoJHDRLIa7QUyIphqVCNa9RrGW3HamaT4QwIj7S1E0/4rqQs0R2B/MEy1StbB4hJ6 tgDiMnDJly+B9NLqRGHMF++iN9PXbTLd2zwDPux1PeKIPbN8ubASjwi54pV52JYrQqrli1Kkoad
 YekualPrA+svhXFdoDB+NHL6dkWx4+/M/cRtEmnowILG37ZmPR3tIZrQoMkaZKPW/cPsewaT
X-Proofpoint-ORIG-GUID: u1rnVcs5m-ZqMZqoWszTXfD9CR5a-X6v

Provide a means by which drivers can specify which fields of those
permitted to be changed should be altered to prior to mmap()'ing a
range (which may either result from a merge or from mapping an entirely new
VMA).

Doing so is substantially safer than the existing .mmap() calback which
provides unrestricted access to the part-constructed VMA and permits
drivers and file systems to do 'creative' things which makes it hard to
reason about the state of the VMA after the function returns.

The existing .mmap() callback's freedom has caused a great deal of issues,
especially in error handling, as unwinding the mmap() state has proven to
be non-trivial and caused significant issues in the past, for instance
those addressed in commit 5de195060b2e ("mm: resolve faulty mmap_region()
error path behaviour").

It also necessitates a second attempt at merge once the .mmap() callback
has completed, which has caused issues in the past, is awkward, adds
overhead and is difficult to reason about.

The .mmap_prepare() callback eliminates this requirement, as we can update
fields prior to even attempting the first merge. It is safer, as we heavily
restrict what can actually be modified, and being invoked very early in the
mmap() process, error handling can be performed safely with very little
unwinding of state required.

The .mmap_prepare() and deprecated .mmap() callbacks are mutually
exclusive, so we permit only one to be invoked at a time.

Update vma userland test stubs to account for changes.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h               | 25 ++++++++++++
 include/linux/mm_types.h         | 24 +++++++++++
 mm/memory.c                      |  3 +-
 mm/mmap.c                        |  2 +-
 mm/vma.c                         | 68 +++++++++++++++++++++++++++++++-
 tools/testing/vma/vma_internal.h | 66 ++++++++++++++++++++++++++++---
 6 files changed, 180 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..e2721a1ff13d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2169,6 +2169,7 @@ struct file_operations {
 	int (*uring_cmd)(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
 				unsigned int poll_flags);
+	int (*mmap_prepare)(struct vm_area_desc *);
 } __randomize_layout;
 
 /* Supports async buffered reads */
@@ -2238,11 +2239,35 @@ struct inode_operations {
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool file_has_valid_mmap_hooks(struct file *file)
+{
+	bool has_mmap = file->f_op->mmap;
+	bool has_mmap_prepare = file->f_op->mmap_prepare;
+
+	/* Hooks are mutually exclusive. */
+	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
+		return false;
+	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
+		return false;
+
+	return true;
+}
+
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
+		return -EINVAL;
+
 	return file->f_op->mmap(file, vma);
 }
 
+static inline int __call_mmap_prepare(struct file *file,
+		struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index e76bade9ebb1..15808cad2bc1 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -763,6 +763,30 @@ struct vma_numab_state {
 	int prev_scan_seq;
 };
 
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
 /*
  * This struct describes a virtual memory area. There is one of these
  * per VM-area/task. A VM area is any part of the process virtual memory
diff --git a/mm/memory.c b/mm/memory.c
index 68c1d962d0ad..99af83434e7c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -527,10 +527,11 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		dump_page(page, "bad pte");
 	pr_alert("addr:%px vm_flags:%08lx anon_vma:%px mapping:%px index:%lx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
-	pr_alert("file:%pD fault:%ps mmap:%ps read_folio:%ps\n",
+	pr_alert("file:%pD fault:%ps mmap:%ps mmap_prepare: %ps read_folio:%ps\n",
 		 vma->vm_file,
 		 vma->vm_ops ? vma->vm_ops->fault : NULL,
 		 vma->vm_file ? vma->vm_file->f_op->mmap : NULL,
+		 vma->vm_file ? vma->vm_file->f_op->mmap_prepare : NULL,
 		 mapping ? mapping->a_ops->read_folio : NULL);
 	dump_stack();
 	add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
diff --git a/mm/mmap.c b/mm/mmap.c
index 81dd962a1cfc..50f902c08341 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -475,7 +475,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 				vm_flags &= ~VM_MAYEXEC;
 			}
 
-			if (!file->f_op->mmap)
+			if (!file_has_valid_mmap_hooks(file))
 				return -ENODEV;
 			if (vm_flags & (VM_GROWSDOWN|VM_GROWSUP))
 				return -EINVAL;
diff --git a/mm/vma.c b/mm/vma.c
index 1f2634b29568..3f32e04bb6cc 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -17,6 +17,11 @@ struct mmap_state {
 	unsigned long pglen;
 	unsigned long flags;
 	struct file *file;
+	pgprot_t page_prot;
+
+	/* User-defined fields, perhaps updated by .mmap_prepare(). */
+	const struct vm_operations_struct *vm_ops;
+	void *vm_private_data;
 
 	unsigned long charged;
 	bool retry_merge;
@@ -40,6 +45,7 @@ struct mmap_state {
 		.pglen = PHYS_PFN(len_),				\
 		.flags = flags_,					\
 		.file = file_,						\
+		.page_prot = vm_get_page_prot(flags_),			\
 	}
 
 #define VMG_MMAP_STATE(name, map_, vma_)				\
@@ -2385,6 +2391,10 @@ static int __mmap_new_file_vma(struct mmap_state *map,
 	int error;
 
 	vma->vm_file = get_file(map->file);
+
+	if (!map->file->f_op->mmap)
+		return 0;
+
 	error = mmap_file(vma->vm_file, vma);
 	if (error) {
 		fput(vma->vm_file);
@@ -2441,7 +2451,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
 	vma_iter_config(vmi, map->addr, map->end);
 	vma_set_range(vma, map->addr, map->end, map->pgoff);
 	vm_flags_init(vma, map->flags);
-	vma->vm_page_prot = vm_get_page_prot(map->flags);
+	vma->vm_page_prot = map->page_prot;
 
 	if (vma_iter_prealloc(vmi, vma)) {
 		error = -ENOMEM;
@@ -2528,6 +2538,56 @@ static void __mmap_complete(struct mmap_state *map, struct vm_area_struct *vma)
 	vma_set_page_prot(vma);
 }
 
+/*
+ * Invoke the f_op->mmap_prepare() callback for a file-backed mapping that
+ * specifies it.
+ *
+ * This is called prior to any merge attempt, and updates whitelisted fields
+ * that are permitted to be updated by the caller.
+ *
+ * All but user-defined fields will be pre-populated with original values.
+ *
+ * Returns 0 on success, or an error code otherwise.
+ */
+static int call_mmap_prepare(struct mmap_state *map)
+{
+	int err;
+	struct vm_area_desc desc = {
+		.mm = map->mm,
+		.start = map->addr,
+		.end = map->end,
+
+		.pgoff = map->pgoff,
+		.file = map->file,
+		.vm_flags = map->flags,
+		.page_prot = map->page_prot,
+	};
+
+	/* Invoke the hook. */
+	err = __call_mmap_prepare(map->file, &desc);
+	if (err)
+		return err;
+
+	/* Update fields permitted to be changed. */
+	map->pgoff = desc.pgoff;
+	map->file = desc.file;
+	map->flags = desc.vm_flags;
+	map->page_prot = desc.page_prot;
+	/* User-defined fields. */
+	map->vm_ops = desc.vm_ops;
+	map->vm_private_data = desc.private_data;
+
+	return 0;
+}
+
+static void set_vma_user_defined_fields(struct vm_area_struct *vma,
+		struct mmap_state *map)
+{
+	if (map->vm_ops)
+		vma->vm_ops = map->vm_ops;
+	vma->vm_private_data = map->vm_private_data;
+}
+
 static unsigned long __mmap_region(struct file *file, unsigned long addr,
 		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
 		struct list_head *uf)
@@ -2535,10 +2595,13 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = NULL;
 	int error;
+	bool have_mmap_prepare = file && file->f_op->mmap_prepare;
 	VMA_ITERATOR(vmi, mm, addr);
 	MMAP_STATE(map, mm, &vmi, addr, len, pgoff, vm_flags, file);
 
 	error = __mmap_prepare(&map, uf);
+	if (!error && have_mmap_prepare)
+		error = call_mmap_prepare(&map);
 	if (error)
 		goto abort_munmap;
 
@@ -2556,6 +2619,9 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 			goto unacct_error;
 	}
 
+	if (have_mmap_prepare)
+		set_vma_user_defined_fields(vma, &map);
+
 	/* If flags changed, we might be able to merge, so try again. */
 	if (map.retry_merge) {
 		struct vm_area_struct *merged;
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 198abe66de5a..f6e45e62da3a 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -253,8 +253,40 @@ struct mm_struct {
 	unsigned long flags; /* Must use atomic bitops to access */
 };
 
+struct vm_area_struct;
+
+/*
+ * Describes a VMA that is about to be mmap()'ed. Drivers may choose to
+ * manipulate mutable fields which will cause those fields to be updated in the
+ * resultant VMA.
+ *
+ * Helper functions are not required for manipulating any field.
+ */
+struct vm_area_desc {
+	/* Immutable state. */
+	struct mm_struct *mm;
+	unsigned long start;
+	unsigned long end;
+
+	/* Mutable fields. Populated with initial state. */
+	pgoff_t pgoff;
+	struct file *file;
+	vm_flags_t vm_flags;
+	pgprot_t page_prot;
+
+	/* Write-only fields. */
+	const struct vm_operations_struct *vm_ops;
+	void *private_data;
+};
+
+struct file_operations {
+	int (*mmap)(struct file *, struct vm_area_struct *);
+	int (*mmap_prepare)(struct vm_area_desc *);
+};
+
 struct file {
 	struct address_space	*f_mapping;
+	const struct file_operations	*f_op;
 };
 
 #define VMA_LOCK_OFFSET	0x40000000
@@ -1125,11 +1157,6 @@ static inline void vm_flags_clear(struct vm_area_struct *vma,
 	vma->__vm_flags &= ~flags;
 }
 
-static inline int call_mmap(struct file *, struct vm_area_struct *)
-{
-	return 0;
-}
-
 static inline int shmem_zero_setup(struct vm_area_struct *)
 {
 	return 0;
@@ -1405,4 +1432,33 @@ static inline void free_anon_vma_name(struct vm_area_struct *vma)
 	(void)vma;
 }
 
+/* Did the driver provide valid mmap hook configuration? */
+static inline bool file_has_valid_mmap_hooks(struct file *file)
+{
+	bool has_mmap = file->f_op->mmap;
+	bool has_mmap_prepare = file->f_op->mmap_prepare;
+
+	/* Hooks are mutually exclusive. */
+	if (WARN_ON_ONCE(has_mmap && has_mmap_prepare))
+		return false;
+	if (WARN_ON_ONCE(!has_mmap && !has_mmap_prepare))
+		return false;
+
+	return true;
+}
+
+static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	if (WARN_ON_ONCE(file->f_op->mmap_prepare))
+		return -EINVAL;
+
+	return file->f_op->mmap(file, vma);
+}
+
+static inline int __call_mmap_prepare(struct file *file,
+		struct vm_area_desc *desc)
+{
+	return file->f_op->mmap_prepare(desc);
+}
+
 #endif	/* __MM_VMA_INTERNAL_H */
-- 
2.49.0


