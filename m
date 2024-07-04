Return-Path: <linux-fsdevel+bounces-23102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4389392735D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 11:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED74328175A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 09:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8A11AB8E5;
	Thu,  4 Jul 2024 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hhqQg/te";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bj7Nq+V7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB09A1A3BCC;
	Thu,  4 Jul 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720086597; cv=fail; b=PFkx2xldFIke3dQBDUd/ylslimkH4Gykkxoa6c5oTyCfeMb2skQwsef9RI2n0F7986t3CfqHmryaeZ5aFPyzZ4NSSS3FkeJgx7Le6RX0tglwlGqwAl0yneZtlu1WNWQTebhbf+88NsZilnEGGdcCvTAGL65H3udV3DglHCBHlVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720086597; c=relaxed/simple;
	bh=Yb7j8b4jVTw6MB4ZfNo9AAhL3No3MDERHmsstu2mrbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P0+ob89nj0+u93OBZOyn7C26fHOaQSclmRj0FaeqwS7Hgvxw4ibzYMUuItKeNvnC0RvILoGv5cld0xTtlDwBmyFRUZzlflYMD12TdHstXthrBpvPMMUO9lZEi+158mQ8ivyj8UsvVD0SGY422wH8ybTt54d4APetiUIGYUZegiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hhqQg/te; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bj7Nq+V7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4642MbO7032237;
	Thu, 4 Jul 2024 09:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=1RQsJn7tmDs5Jlm
	qIGBJC6H/zS5do1zic1G5duUuqoo=; b=hhqQg/tefLOoT8SMwMkQUfvoMdr1lJl
	MIfiGVjHBJ+3nzI9Vm6iHzrjXM1fNSTULy7OO4cZ9JhvmVTGRTsSBiRLrHod2jtt
	sQBjcAX59qvlrP1b1nNll/AmoaQdKyzDColXvpi2KhtT1C1PUPfe9ZI6bgPFmBNO
	jUAIWW6DX31Fc/6/aHQy4Wb5FtTL6GSGUZHTanrS2heVUm2q417aHUxySmOQ5YAv
	9TtxtIdgqfrxUjimxqteJ8I7iYHSuRYeK39y1XIBQm6gGS2l7K6+snTO8Tidky6c
	evH5SJk9xjxgB6x3gjCSZKL7HPtyMKtAvyq7yrzNM96U0sknkE0yYPA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a599r7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 09:49:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4649bYLH021519;
	Thu, 4 Jul 2024 09:49:30 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qgage2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 09:49:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SG/GIlRJl8z/VUcTaEsFi0yeaF+ookQu78RH0ZXRq6SNyA8WzZhzFPbsnbN6avOON4tmz8Z3XmVZWe/rvYzYJPoFtsIPd0DkphemXfp3I9MlunNqH/Qr7vOn4ILCf/Jm0LIByoNdVHp7108H5B/jGLgxn+95nweUC5pChC/E/+op7SnJMaEZhgIvfrKo0j040GAdACIDc2m2PkF/nQSj0lqm/V3Pa1x6bGT2D6VqMaFsvPrRsSTAyUkjUtwd1Tt7XyoOmUdyPVm1LeWyQ8IgqwYP3AQExjTMHaRcD61eqgqapaMsfZfZRxfkXd05etf7I1wS7+YoHrBKxAoqpQYyPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RQsJn7tmDs5JlmqIGBJC6H/zS5do1zic1G5duUuqoo=;
 b=aDjuA7sRxxKv5oFGWiyZIyzZbYTmI4+DHh+8olDYW3B110ZwrTO8eGWk4Af3aPC5Ffw3ZURthft55G4s9b0gLh27ALbF8WxW7fZycDEj5uo27cj18Bw4ahVXkw/rx3+V5bpgDFKqE+Gfu8aYJQYHjx1ZLcTsPGS+7Bm4gNEdVEKTyEGYX2+pbeW0Sv1UpF2o/PHuqAFQeghsHRLRhpEH6dOqE1hm4NuNZPEi0NnyFdlsATkrnqt2QpZy+5AXgmxHkNWED+hmia78borjbQwt0xMk7F8aErROdUENE76L9dvYAVJxOXS9B0Z7+/DGZASo4RgY5nvsve9rYDkT+sBUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RQsJn7tmDs5JlmqIGBJC6H/zS5do1zic1G5duUuqoo=;
 b=bj7Nq+V72qMhV9g5Ki0DQCBVea49NpbQ4j3Lq7eye6lNk1x5U/aSWetmE15Ht9hokKVnjb+uwMXRRy4Gx/y1KuDHX23+feulQLuWGOQtO8C2sW2cdrAptYEh6qS+d2sfXcNYDB/Z/vEiZW+5WXa5hD97FSKhTYO9C0EtOsok5NY=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SJ0PR10MB6399.namprd10.prod.outlook.com (2603:10b6:a03:44b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.27; Thu, 4 Jul
 2024 09:49:05 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 09:49:05 +0000
Date: Thu, 4 Jul 2024 10:49:01 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH 5/7] MAINTAINERS: Add entry for new VMA files
Message-ID: <f4199b5f-8cfc-46a5-b985-34db03fcf7a9@lucifer.local>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
 <7177e938f13dae3e44fd77d39f1f1b3e935e4908.1720006125.git.lorenzo.stoakes@oracle.com>
 <a2d9d43b-9cc3-4668-8c87-46da90bd8752@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2d9d43b-9cc3-4668-8c87-46da90bd8752@suse.cz>
X-ClientProxiedBy: LO4P123CA0048.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SJ0PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 10f836dc-9ecc-4ccb-2152-08dc9c0e8b0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Q35AEexZrDC/VcuYD4SovjzwICVJyCz6ZuH8MTdlwG1fh+y5JM0j0ewWTeIY?=
 =?us-ascii?Q?Cx38ejw93XkPDQi8d1xVfSZUGgH4DwA8y6WHDkEtQ+H0h2AlUbEwWK2BwZeQ?=
 =?us-ascii?Q?QDmoRxHf7K+msIMAlOSXrA0/0q0IUk6pqZLtY05hGfOonIS53BBZ02B/ySh3?=
 =?us-ascii?Q?TQ40U7Ppcvrd33OCg4lHWN5wcB708h0HJzKCxTEkdsSVvdbByy4eFFbplH+N?=
 =?us-ascii?Q?ev5gY2L1kdFj/iT0UHrMWSnMtLGYcg+yooVhazaz68saQlwxZfCEXr3Yvy/3?=
 =?us-ascii?Q?1u8IUak4/vNg3uJ0j/SpHaZikH5W8LPNwHBrixdJPDvi8058cxwqzurTX7Qb?=
 =?us-ascii?Q?czyR84DAIzSEYsY3WJSKrNwxMNhpBLNkCaiWoK8rX0WWguLCpLfpE0eDos06?=
 =?us-ascii?Q?zqhCAHI8vizY0S/QpMhnana+EvEM3mtG8COs1cuWK+QHrsaxga0TEmXoEiCq?=
 =?us-ascii?Q?p4WF2S3Z1WpnxhhC/DRNcFPohlsWUJE83mVoLkiihpCOu1VA1Brp4faeDdsW?=
 =?us-ascii?Q?UhO6FArrIErVGCpf9P76I3pQIrndBVjzrxjAt1b5DDR8q4LfWH2WTQNaUBi1?=
 =?us-ascii?Q?7KS71CNz3WqFeaJ/7FnyHYf2VwxoviekXVcOtyieCXqi5Y+Qj88ls6h2Qa7a?=
 =?us-ascii?Q?BhQv5JjPz5gGlJrgc37Uziq1G0io2t6gJvv8KZh9v5lIBSjHdGxDmOAHnM3N?=
 =?us-ascii?Q?hCJHRv5bVGJxEZh1U9lKhz3NIYEyIfGGNELxh40puN2LUvucTqdvhvR7XpPa?=
 =?us-ascii?Q?qNLjonRYo1KOXJBzOZU14suqge26U7h7Ni/Y/p64F7uaGejqLIPeW306y5ia?=
 =?us-ascii?Q?lRjs+VFm+/ys3QAV7jXe4Vdf/gzM96WiJj6zFVpp8DbeJOpOscgx5j8VH8cs?=
 =?us-ascii?Q?n/cYUaww1KtIJ46FlEVIVS0MMzCeOtnXrpConWbm34Ez+Ksxw2ehr3jD4/u4?=
 =?us-ascii?Q?AeA3XaWd7pGBExiqxVaXN3RQmaVJxlAVVl2XTp0t4F4GQbIw0C2wEecnm7O2?=
 =?us-ascii?Q?xFu+C1UYtOVzSHHEIFiq0F1xIxPar25QnmXyqc0Y5XPyNI7kmzZNAaH2TxCT?=
 =?us-ascii?Q?P0qRVvEE7e2qRvHweZeaPU8xoUzwrGig2zgmtf+rhBGM5TiqsKfjg/xYx8eB?=
 =?us-ascii?Q?UyKP4pPlBojWsy8Ydl/k4mqe9GfpRVH34cKdaGfVo3tV+sDiClUn0ynuIQXi?=
 =?us-ascii?Q?5cF1cFTIbyKAdGfsHx0h0FXe75NSWQkIAjyrryHYMUhFdwYF2fGPh9sB8Ejo?=
 =?us-ascii?Q?dT6xi8zMNKtl1THxHI3ZEXeIT7BZGzGN5G0OBYlW8VBnO28R9HZDjcQM/FEc?=
 =?us-ascii?Q?s+c=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?QSfNabOIwky3Zs6qdHdUHMHGDnWkpmtqK2iQ1F1WPu1Cy2n5HM5rLyVLLRd7?=
 =?us-ascii?Q?W7NiW1JWhHkWpcRFLv5jn1iTDFo2LnwEU5aZnPNp07c9x+r0F0+WBk+w0et5?=
 =?us-ascii?Q?JdKISo8YJyD/QTkFRTejfj3WUafe2ITUurGCV3qKw1VItXK1tUYllTcwhPhr?=
 =?us-ascii?Q?cyJX1UVnOZQQ3SNNjtDJ8k1LeL8f2YXNVO7sp8q4rFbtSErkdnnCXGqmfaPh?=
 =?us-ascii?Q?K8UUrskNnsnMtpBhLvoupax2U/MpBE53cqD9oBqeLDNqquLQI54Y/3fiZLFT?=
 =?us-ascii?Q?Viwk9MlRb2x4Wik+jpFzJ2dj9ODj+WFBK7fBydumD5m1qqZe+257k2z4ADFi?=
 =?us-ascii?Q?7dZNIOJmdoVtv098IXyHj50AWEu220uWGRZQqGPisSAZmekNB5Kq+UegZZp9?=
 =?us-ascii?Q?s5W6zVw9c8Ul/T1pSoEeQMHyOSfY/GRMjFq4WoLzjCY78Fj8x5MSzZIAkCZH?=
 =?us-ascii?Q?fTCm5jqlmnQ9gTjTWgPukq3ju/FxgRyPUpogmcZOkB9nhVUwDD3ehqMoeCy8?=
 =?us-ascii?Q?p30yhc+nCXah4BYLeWIEHnNi6FclyeKOZyscE39LHN3+F+Rd+yPfSdT8R0dY?=
 =?us-ascii?Q?+DqlM+iwjnj8QnIM6J/KXQfkr6Hun3bYAxxL4VDFUihGDsDh9/QhPEgrko++?=
 =?us-ascii?Q?NovWTGa26jbKGAjH5JkakhUh737N9fsFC4mrgj24lWvND42sbnxBkIEMVKwn?=
 =?us-ascii?Q?CnCYSRaMI5a19Oi0Wo70ZdfhdHIt5DTFCzROYuddKMxlYTigzFJZMSMNtSsW?=
 =?us-ascii?Q?8pSCzZE99er1yEjrR9ySXCWYNyFojIZnBQsdBk18ZJ9yWbVjhGpEpMB7SkIP?=
 =?us-ascii?Q?Ix+w3BpZmTqeSElfSeeNpB4fbBMDpq5ElmUsSe8GUr06RqZqeeQe7Mz7oVOt?=
 =?us-ascii?Q?r+qVKpsxHJovasuYyHxp92wbrHBbS23HFu8iyFIQTqmjBbnpNABsTEUjpEUJ?=
 =?us-ascii?Q?0WdS0+8432TW2Bxu0tyn3ANlHvfwW4oYqPg4gnPC4qqoXWTkhCLIMsgSOhMv?=
 =?us-ascii?Q?RQDD5dF/GYMLvLznOafGA9pnAhOJ3l1qGf35TxuphRskkM+U5UdI3yA7AIX1?=
 =?us-ascii?Q?pjYItw9gNdx8bAbjVyvPjJWPne884z794Bu+DkPf+hgwQMOYjXT4gyGq+OV0?=
 =?us-ascii?Q?7/N6/McBsadw+dvx+6FL0nUQXQAUdP4tZniWJXOdcO1U8IzM6POtyGvOvmPE?=
 =?us-ascii?Q?zotP7dsmR/yKBaEIRjBQkjUMcK2jNGvlRAR8Et7kSdVf3vR+Yta28q7bNl8b?=
 =?us-ascii?Q?cpom4vKMUjU2asAdKpDnBDm4sWPOZCdhQWkz8A+Neu0ji9LUjsFCrFEWwngK?=
 =?us-ascii?Q?eM/X6ns4SCQMfLh9FGKbXqrEO8OJKV75iileRF+pSJiya3Mg0dhAsr5LVa8d?=
 =?us-ascii?Q?hbNV/Zk2YP5XWlzftTO0ju75T5Z0n57o9hojH/F27zup/Vd2Z6Oa6Oq1cZDf?=
 =?us-ascii?Q?LDjPJhVZj0fWVvwoNxfwG6EmT5r24YZLe6HrDGF+hzcJXa1PNFnuNxsAWR9u?=
 =?us-ascii?Q?KfbitK0CFfeSjg15nlLEvJzrhIORj+QUboeNNTEA+9iCd2MG2MUT0zoZFeWo?=
 =?us-ascii?Q?vI2CeFqTUV+7sJ0oirk0rJF4VVdxMl/oPNsTC6T1pdhZ+mciQWNPYEN4p9KL?=
 =?us-ascii?Q?2w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	PaowfDb6pJXkQuRD50wnY3sZKmaHgIHVJfqNLD43pAjc+16CTLuvmgWYsxMjEmVaXjTvpghTfFA3XUEsi0S0Pp4U4A0Ac7W9Jim8yBtXzLpMoORkcLYUxa6lQDmz7IIy6odrnFsvvPA4HglamA32xmgNbdjlxn7vG2W3VEzOqsfNCN/6/A8spsgnEelWJdwwwiR2q27hQ1GOIbAZrSrTCMhENN4DYFU87/hL6bg/uLbJpxSuhobgcsFVAc+7xBo9JGuqrV0H8o7hzY4TxCaJ+AqaNLI8zgVElpRIh90yy1ZqGACYl55NLkY2+GD2YNa1VhZiVOteZkEFNWkXTIVbpTUQT9eAM0cUXt+lMzxs/oNL671mE45ubYLD4xWFNa4eN+0LEitu9BRZ4Nn4DecSCwEKOOQvDrbm/tQon6PVzeUTvrjlu3YXM/o/WjKWzSxr2GN350XSkEx4hyKwG2bDQ2b3juYVkT/TpkntSPuoylVSSXAASwOB0MMMu4iPsfX/HZ4NeYAQDOnRcsJj5psovaPUhJ05hfLBRjTe9krLxq+qBqoZACIjj5R5/mTQUUPuSy1+Ku0FU1zX2YECOrKxW1kAZzrv7lt0jXnZoJ5opz8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f836dc-9ecc-4ccb-2152-08dc9c0e8b0b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 09:49:05.6922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KCn6V1QddY1DIld6aXDyBHz35EHCYcr6aCPbYYPWx8F54NSJ8wFsrDBm4Zj1qDg/N4ApwPgfhODT6PQ5CFFIZzD38PKONglbbyVKZU5hr0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_06,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040068
X-Proofpoint-GUID: uHTmC_2HGHg9UdiTxLq09_Slu-v792ti
X-Proofpoint-ORIG-GUID: uHTmC_2HGHg9UdiTxLq09_Slu-v792ti

On Thu, Jul 04, 2024 at 09:39:14AM GMT, Vlastimil Babka wrote:
> On 7/3/24 1:57 PM, Lorenzo Stoakes wrote:
> > The vma files contain logic split from mmap.c for the most part and are all
> > relevant to VMA logic, so maintain the same reviewers for both.
>
> But it's still related to mmap.c a lot, so why not just rename that existing
> "MEMORY MAPPING" appropriately (how? haha) and expand it with the new files?

Yeah it's debatable, but I think going forward we may wish to to further
separate the concept of memory mapping logic and VMA manipulation in which
case it makes sense to keep them separated :)

>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  MAINTAINERS | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 098d214f78d9..ff3e113ed081 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23971,6 +23971,19 @@ F:	include/uapi/linux/vsockmon.h
> >  F:	net/vmw_vsock/
> >  F:	tools/testing/vsock/
> >
> > +VMA
> > +M:	Andrew Morton <akpm@linux-foundation.org>
> > +R:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > +R:	Vlastimil Babka <vbabka@suse.cz>
> > +R:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > +L:	linux-mm@kvack.org
> > +S:	Maintained
> > +W:	https://www.linux-mm.org
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > +F:	mm/vma.c
> > +F:	mm/vma.h
> > +F:	mm/vma_internal.h
> > +
> >  VMALLOC
> >  M:	Andrew Morton <akpm@linux-foundation.org>
> >  R:	Uladzislau Rezki <urezki@gmail.com>
> > --
> > 2.45.2
>

