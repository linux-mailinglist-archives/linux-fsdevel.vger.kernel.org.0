Return-Path: <linux-fsdevel+bounces-47369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3CA9CC1D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5706C9A5585
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 14:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA752586ED;
	Fri, 25 Apr 2025 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z6WMlAyM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZPp4Py7p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1312580EA;
	Fri, 25 Apr 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592927; cv=fail; b=GIjRSP+E0ZNB0F8OfC+UcWKvc0jYw3caDQbPT7450XqFWIYbw0c96jtY6n7VPQ6HbfUfNHm+XjGXQtmE51NrFZ39Ub/PI+UZfmwnUiSE3W2n9+ICFKTMuo2G1x/PlmEsd7j6/hihebZNCgXKvMEtrg5Q5G+GngEg9yVV5FStTgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592927; c=relaxed/simple;
	bh=KK5sPCzxwzw8ir4AsVOZnhup1t1Z5VWgAYT09lqUJRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sm0aP+N2VDz4WnLk/eO4E50bU20cyfVrJWm0xx9XpBHzy0ugiVxgKn32DRXj9xZI0+lEB6rIaVAOKcKXC/a9S68pMvmjB0AjtVqbZ+Q68ed1TQDDprJkqkGxWV/Z8nZz0VQhJmVCchImHaPkTFhB25umCnc2xy2VWxYhBLd93gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z6WMlAyM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZPp4Py7p; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEmQrB014221;
	Fri, 25 Apr 2025 14:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=VzB25wZOPCygNBf1
	waR5TL/ftsWtzwFC3tS4GwXmrl4=; b=Z6WMlAyMZKO1CvkpbB8Ifyc6CADc9uJO
	hw1tDwr/E+kzUk6p+d0uqbWtnPAnQ+cm+34HBFitHzOIhWHpOW35DJYxWf5uXQwL
	Qqu7kGSqYX1gZDm6va7DlquHP+Tk4Mq8ny8M8i/cgpxPWFr6g/WAXzsd3Pli7XpI
	5C94pImiqY/XJA5TKfP6QLyvasQrhBQqj9L6M5KUWlT6FXuRGREv43jaszZEShCO
	9DdEInX1iDg60MxuetXGMFMr1h+eFDKD3CJ36MxNo6JdVPA/tCuNjETDOp09U+Mu
	437TAW/qhtpFdMsc+1l21fWpkVASyTTY5htwz7MaUav66twCMI0few==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468c3br48g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:55:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PEIuaE030939;
	Fri, 25 Apr 2025 14:55:10 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466k08r8ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 14:55:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BG6E8pgg2gFKlezbRbqmBdEp9s30Z9oC55jcJddZ/s0986tqlTqaBhWXB/i+uVf28q6XScq2fF4b1tUATHevqSNC4DirggHrunuHRIzOXQ45vsIN1rmILOl+I1y7WsADsZxePD1+Ex1Jw40rLt6o3dfzrkPFL9uhNm59SZADzrfNWsQDKuPFOcyR5io045yiCxj23Gc3duHBEs4jS6ZJg8CxYENIg5MmteL52j11/15IfEN2Uaqk2vghaWed23YL0oXt9Zy2tyM06t3PoWf2O0OHvoXKdCbJC6P8pUohu96PillBvdDypNMAk/4JbamMSXFK/7n1asalNye4grD6jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzB25wZOPCygNBf1waR5TL/ftsWtzwFC3tS4GwXmrl4=;
 b=q2oXXa7xE4Kc86eG7lEwr829bkMEhvzZl1k/xFK3aklRa8405kV2RGONkto5qrljwpx1ZwrA7GTlN9vxfD18DzTDfathwOd4yBCxNaM0kPwa0ZSCCLWgr5AySPxslnENEjqRPQ0jEd9pFr2Bz8nep4Cz1dehaCIZabQk/OGFEYdMgrqAwvzWabsmsWfCdqgn33tqUURkbL1VJuZuK77E9RkbKlFKhYIFbjY0ox9JjMNhGM+MzXJ3RInFz9UnqUHXIw7xMBldPOgiVHIoKOgaHtfiR3mRgIciYXVN4dqMv90jGebmAAOXLFzIlIW31eNuxJ3CpUgBL3XfUzUJeCRvgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzB25wZOPCygNBf1waR5TL/ftsWtzwFC3tS4GwXmrl4=;
 b=ZPp4Py7pFfXLlLi6ey92MgqWdYeFv1e8IlpvhfwbG0jroqAILlNmKtOYp+z7bbZfCCIeogPP/630OM+7MpTVdyqenhdaGF1TnEkHAAaVkB1hH6jZFlhDaCYzDBoITxf+AHEMZPIPznbgn+nZuJKvGuLgEPLNk5mk5HtzK5bSZYY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6015.namprd10.prod.outlook.com (2603:10b6:8:ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 14:55:02 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 14:55:02 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] move all VMA allocation, freeing and duplication logic to mm
Date: Fri, 25 Apr 2025 15:54:33 +0100
Message-ID: <cover.1745592303.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d9f452-4b9e-4eab-0c48-08dd8409286f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q2FjhnwHIjj3grTe/QcRBPNwO2NrE5X+kpVgg08zYnNAqUDia9svUkagaJ+v?=
 =?us-ascii?Q?j5IZKuQ8oXDjKToBuzFnaUzXuxuJZU0s01JJ6PN/kSkBA8G/VkiUqAVby6zl?=
 =?us-ascii?Q?YknF7/uwtjsiiH60C5/JlSu+ilAXOw7rZlOhLLsTYo+M2seyZ9x1ITVteS03?=
 =?us-ascii?Q?rP94xecL99dCgu0OBPXWLUySW22dERyq+QaNqyslYNE1sgkICKRk6t1oCPUL?=
 =?us-ascii?Q?MA1gxrR+B1p5GBBN4MWg/Wr9Kcsw2aFYIAiS5gj/9lnnUL4QQqVIwppjvR54?=
 =?us-ascii?Q?xVpknqvzupsEK7vzpGl7PbdijQqlr/gVOO2ZfvOTNMyrdjOEilfIzCz27Z4r?=
 =?us-ascii?Q?s9gKU6levrtt8AN7sn88pdXEpDUIkPTVlbIRPQAJPLgu3iAPAvoPQ+MgEnmr?=
 =?us-ascii?Q?vv64I+HZrYxw8gBdlFbWub7CpRTFSjIKcgR5D5xR1BcDa2uAOzzuV/cMlBO+?=
 =?us-ascii?Q?TeBSdyfa7G9xJKoyIbSB73jL6hVnHSi2vGpH70xD95bXzPhBfseUKsiLu4HI?=
 =?us-ascii?Q?ntWj5EA3zdWIsMOKJ/j5A6uYhtxIBFBnrwsDU+f9IDn4MguhnhHBk4tyiDoa?=
 =?us-ascii?Q?V5gs5i4ezwzx2WNE5plWcRwrIYkuMdiq4KmKNWbMvN53T9Gu5ii57HkI5k6z?=
 =?us-ascii?Q?SH6vDUY33DUqX4m7DZVlDx3C5ZBYeUi+m1w8fDCEJOGy22bmzhRQBHTUoNzk?=
 =?us-ascii?Q?tLJh9P2mY2nuu+TqumbVB+QjEGYzY/vrrth3hDMIxioca0dsr41oiG2WC1Z5?=
 =?us-ascii?Q?DDkGU2z0pmKwCxebWxqJEwFO7vVlS35FlfUr74FovboNPhTSAW22tZbVNo7Z?=
 =?us-ascii?Q?NId88iz+awGcc2JOOFzoez0oWOQofWvFQrGiMMeeqwIqnLYRSaruxQDKmHA2?=
 =?us-ascii?Q?+uA2VqiICg0pjkPThgtq4e3b3FxdRa+Uuzni7jnzgQeauT3/l+cnznqNmvm8?=
 =?us-ascii?Q?xNAgh4k4GtPluJykZAd9amjImKoC3DeBoxPrRWriJFA++f4bXpwF5+ptVLgX?=
 =?us-ascii?Q?H6UENKZp8uyIh/ptAO6/OEURHbTXuvj7Dycu7edyeGR3D/lHmLNmABy9TgCN?=
 =?us-ascii?Q?pVnPqapK4fMf2xNPLaPdCNeMzrX97cEVetJYwWRE9d8/4hCq87ERL4YfhHKd?=
 =?us-ascii?Q?ID1t0QF+nPqTTzUyZVVq6xyG5UEysJJ1fjiYiQ6nhw3mt9DAQNfIjOmMlxzH?=
 =?us-ascii?Q?2ED9zVM/noGsew5ncJpdyBjveN+dhi76y4vdWmrOY7B3i2e0xIIa70wbsxfO?=
 =?us-ascii?Q?s2i9NZe0aPZDKvMVIkFSDhHAL50bUHJDJLPPkjKjK7KVUyHSd8t58GoLLkxE?=
 =?us-ascii?Q?tuDFhl393kaBGcoq2HortEGcmxR8aT1yGpDBVtNmxaBz0q7WhaZE2WdAArDa?=
 =?us-ascii?Q?Fcg3dJbpv65XlSgHBa4GDfdzGXw2h6+O079zQ0nFxtgY3Q9pGRGZLcPSsY07?=
 =?us-ascii?Q?GHhDnk0wkkc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WZl0cQjuqIpAVs7oOHjJ5Pur616EOKUWhSTp6VdJ5TjJB6qnj0snCeYhuvYy?=
 =?us-ascii?Q?OMnv4JdjKY/aNcnXOqktoXgUZqO+XIKV4gpeFYzkK8mHfItuKdudOJmiXXeB?=
 =?us-ascii?Q?cil8rtNQfIOEnhM94qb6N1D6L7WiqL95EV46t0/Oe4e96Bu9D2KN1QGuP0kS?=
 =?us-ascii?Q?hLfsEI3eBHOzYOjofgKWJletn1gxx69vZ8P9pf9PbwrH09OJ6h7gxPquUE3D?=
 =?us-ascii?Q?e+HKwn+YcOeKPGf9R9EDy7bIOWX1W9YnIVKieudKV6gEZKyFWGcT5Q4tUDGu?=
 =?us-ascii?Q?r2UiUv8cDRkBPaN/kbXD7GvCqwi/VkDUObpIzNYMwxwzeJUm13JaFU4OH3tv?=
 =?us-ascii?Q?272ooCOvovOlJHyiy0D5UTCm3+ImKx/3JheR2Ktr5SULC9oEcmbb16EMRPCu?=
 =?us-ascii?Q?UBkaoJyuUkSWWrK1edOFkn/3BFO9/qszopOODak2cbLvkpCZ85dR1G4G3Xmx?=
 =?us-ascii?Q?Y952xIf0/JFpa9XQnqLCFLdW9Wp3U7M+RpyXQe6bifOML/MXlQVyiagJMY2J?=
 =?us-ascii?Q?sGWvcqwqz5HBpsjc/SM3ofvceV3EIiIcF4bnD7HANfwBQAh2wL17D+0QwFxx?=
 =?us-ascii?Q?F7ontJcKnkY6BWwvjiHp4EM0/JtZiD2kv+gb9ErwrGL3Q2Oi9MX6cSkUiNwC?=
 =?us-ascii?Q?fizQfjjB+IvYrh+FSLRBLWNRFUI+qpLRG02ncPFpmLnTynO6HOflWcJ4X41l?=
 =?us-ascii?Q?bKOCLjFqYknHwGwvWabO/NE4cMoVBhcK+uCKRV4nZryV+tMs0hgFRTw7Hbdr?=
 =?us-ascii?Q?iT2k/Q1auvZ8i+DbFm37HeK74umtyXbt1jM56aymrZAlVGFlZ5mhO9MSXNkH?=
 =?us-ascii?Q?M6S1T97711jugZHQ/LFofwJtDYhyIZVp/B7LRRlgqOSEaYlHI6voHBnlHp7G?=
 =?us-ascii?Q?wsDVRnUS2GFQqNO3FRBo/TjLqP5DkHGd1mrwvU+QsvEzFNayONHgTSE5WJCy?=
 =?us-ascii?Q?9XbmpmcVrMc+WsALVtJM6amRK6BCIDs7Y5wI49hK1yMyNOifyRa5YybgVd+/?=
 =?us-ascii?Q?tVxBTqg53FW4Ul9JA3Qih5ADFrkYxXKedZncikY7kVobd/kLYlaLvtSq5iNa?=
 =?us-ascii?Q?cux66eJI81Ra1sEjy1ObB1qnYrjUsMe8RFnVPPDQa9mMPbsFdShrzSiFuKNd?=
 =?us-ascii?Q?/TyrxnxHGMNTzxuOE4bLpqug5id/+GzPbR6RC9FEzC9UM+JU9Rv2iMh3k0sP?=
 =?us-ascii?Q?NRK4o17ARoG5mfZDUjyXEoKHOFrszvYa87Fh0VKzS2FBebDH84pNq5m6M3rj?=
 =?us-ascii?Q?84e6C/CFv6y8HqCogiUQSp+loJOpl0teho2Fan0LnTDJLEQUTHFCcOAW5akf?=
 =?us-ascii?Q?/kOxd84e2rveQ/1OENvLTQ+wqxWdsPrG8WQ+5C4BFVnn8KrQJe3PI7UcXjv4?=
 =?us-ascii?Q?t7Ha3MjGPosWzHiRe9NpA+F/orp9T0jpnfRAFmpZwEmnCzg2f1XSdbMQPMul?=
 =?us-ascii?Q?3TmbG5z+EmuBFbAfNAuj0nxB1sVGgr8izrnuKU1QpcgEG28hPu80alixOaUk?=
 =?us-ascii?Q?79YKuprvQyLy22KN/Zne59TI3Qn0ZRhmoWeLCfW82lkFCHRyREmKpL/Qn7D3?=
 =?us-ascii?Q?y3WtIMWhKC3uUrUJh4JJ8mxMJDPMbRV1ocNwhBxPqdcEqueCKnrEahLXTAKO?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j7cNyMgfl5sf5LWkmID3gQiPTiUeRYRBM8bpWNnXA8YhDTpqjL15eRkXeesJllMZO5Ze7DYwHD0xsJGmMwB+l4zrYQXiPy+oQXIHbchVfDU9mDPSZNXeoNf7fvS7yA/lXs/fRatehaT8NlQUn2cUUD2iFShyTJQLIjqciAqaiMIcI8kxnOtjURjmuOnkWFjE5TcSTRB/o9wo0VNNULpAiqiN4/sLbDABxgcUT9iuDfNlL8v4PU/rrFfRLg899LaQJSlfAIZCkZT7RSRT9taY/KITj81bkEZnGKZhtqRliYI2vzKZSqf6NY9dqCG8nMpGAvmkXxsUKpvIlXwd/TWqJSkLYq0g8oNaj9f5NST5jWgZRU2txA0BPupmKgy5l8jlQj+purX9XycLSrX9DUrqu8HS+5RFKWA3nVwq3P4+Njnj6MuCdOyCHEoHwZI2UXEQGQ/BbZCFemJDHT0uPjw8zf2SKVqNR0LwTMG7emU/XP1ihlKrcVJC9oNbV8DmjykH1hriBwfmDhcV1KGFVcTChE3CmAIOaEZmXqEk3rw5323HAOODUkkORO+NzZh7zOTaTK3Pup+CM6MRcOny/uM6n3IDrxeJK3OU/fi83CdltPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d9f452-4b9e-4eab-0c48-08dd8409286f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 14:55:02.5540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YB4WWkv2AXB0/IkdQ1K8uuPlq3AMAmUrFuFCVpISr1fRyK6/zjnr8e8mu6eLJX4+wylapgAGH5eGrYqGvrUQ2vUvDfrUdeLpaKP7Nqc0B2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250106
X-Proofpoint-GUID: HaVB_NowgGbC_7ujD_rVb6nlUtCXE0Hf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDEwNiBTYWx0ZWRfX9FCTqRHlU0yK JehpGLRDajEVjD3jukGqbZqgcyXLL7cySgx/IIyNOvmMGB5PWKPdHQVF+GzwqD6WLcS3VpwH4Hu n9q0CluiCjCdKAT5vmHBOjqpT3Pez5DhA+XvtKnYCubruSo7hrQi1nrwv4nX687+iFCavGgZR4t
 P9QfM1rOReezWkqNT1ayvbQg6D7Bi0aK6TT/s3iCiG/oFG8gRKzE6NAG0v2RyMibbPHxgcRF0pT NTUlKs6rd+x36Q18mlKHNn47DzfzbN0AYgnMoTd3Brx2pAMDULa2SqcDPWtkM3+C2lTewLjc8ON 6c6gXnpEtHggNrXntLmlneWo+gB0pw7Ff7U8XQJMOGGbxe8chqzd1yiRxtZWeDNAADDrQTNegWv YzeS+g8V
X-Proofpoint-ORIG-GUID: HaVB_NowgGbC_7ujD_rVb6nlUtCXE0Hf

Currently VMA allocation, freeing and duplication exist in kernel/fork.c,
which is a violation of separation of concerns, and leaves these functions
exposed to the rest of the kernel when they are in fact internal
implementation details.

Resolve this by moving this logic to mm, and making it internal to vma.c,
vma.h.

This also allows us, in future, to provide userland testing around this
functionality.

We additionally abstract dup_mmap() to mm, being careful to ensure
kernel/fork.c acceses this via the mm internal header so it is not exposed
elsewhere in the kernel.

As part of this change, also abstract initial stack allocation performed in
__bprm_mm_init() out of fs code into mm via the create_init_stack_vma(), as
this code uses vm_area_alloc() and vm_area_free().

In order to allow for this, we must add code shared between nommu and
mmu-enabled configurations in order to share VMA allocation, freeing and
duplication code correctly while also keeping these functions available in
userland VMA testing.

This is achieved by adding a vma_init.c file which is also compiled by the
userland tests.

v2:
* Moved vma init, alloc, free, dup functions to newly created vma_init.c
  function as per Suren, Liam.
* Added MAINTAINERS entry for vma_init.c, added to Makefile.
* Updated mmap_init() comment.
* Propagated tags (thanks everyone!)
* Added detach_free_vma() helper and correctly detached vmas in userland VMA
  test code.
* Updated userland test code to also compile the vma_init.c file.
* Corrected create_init_stack_vma() comment as per Suren.
* Updated commit message as per Suren.

v1:
https://lore.kernel.org/all/cover.1745528282.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (3):
  mm: abstract initial stack setup to mm subsystem
  mm: move dup_mmap() to mm
  mm: perform VMA allocation, freeing, duplication in mm

 MAINTAINERS                      |   1 +
 fs/exec.c                        |  51 +-----
 include/linux/mm.h               |   2 +
 kernel/fork.c                    | 277 +------------------------------
 mm/Makefile                      |   2 +-
 mm/internal.h                    |   2 +
 mm/mmap.c                        | 253 +++++++++++++++++++++++++++-
 mm/nommu.c                       |  12 +-
 mm/vma.h                         |   6 +
 mm/vma_init.c                    | 101 +++++++++++
 tools/testing/vma/Makefile       |   2 +-
 tools/testing/vma/vma.c          |  26 ++-
 tools/testing/vma/vma_internal.h | 143 +++++++++++++---
 13 files changed, 511 insertions(+), 367 deletions(-)
 create mode 100644 mm/vma_init.c

--
2.49.0

