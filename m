Return-Path: <linux-fsdevel+bounces-79760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHJbIDWmrmkFHQIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:51:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D761C237608
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 11:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48EAC306817F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 10:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6257392C59;
	Mon,  9 Mar 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L7uF6hJU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="A7gCiPhc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D2AD5A;
	Mon,  9 Mar 2026 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773053247; cv=fail; b=qqvVd8NeuMDO/+HNTSbHIxvu0U7hkRbusXdm1xKsQWpOPpr5nvhhKVOZuB85wvrTgwjkdW7Qdsj9Wh7I3OkuMyp53SPeOxfgTLh3YEtwmKWgd8Eir6ByqBnNUlypr81KjQVywTYED2HDu1gOX3YxCaa3baaMBJqw6V1FchasjXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773053247; c=relaxed/simple;
	bh=/EmZiJsGWoGX7mJzXKlQC0O8e/rwzcnv0T3YguCmsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F8j99iOTsysoNm4y2cASZJHws8RpXA4DuI2IM6zc+AIe7qHPJzlBVHoxzjWt1A2LWLVNEgZJ6KjfdLS4s0eCruSQ7pI/OmrlqpBWOGbr6JO4HULHRxbhMzLOlTiV32MVnudcBv2Pi9zjrLX9CqGQfoOymSprBwftefvUE6YRYRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L7uF6hJU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=A7gCiPhc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6298uxxt733487;
	Mon, 9 Mar 2026 10:46:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=BPjKBbwnduBfNX4OTf
	qgITmBAL01c22nCT2e0qdG82c=; b=L7uF6hJUzARBTBONoBY7Nw7CTtDgmjwarc
	Iwaekd6p+8lb56aCzLDI5VaNzQkl3JASRx56sLY63RPNPK9LLRZQKO9Yeii3T+Uy
	VmKYN5ILZMSUrqSdm5swy7PnqRxKteNfXv8WRmvetJbfQ1WE9Qz3kacRRe6Ukd0g
	4zJn3e6oemVOuFMAh80s24m20ig/FZBChZPQPrShV1FasSi9XAEN8D6HDMDO2eYj
	j10hBTrRxSmuTfbDBxnXVzACO53rIUF1rq2gnBSdsyw+ca+EjSehpb8IY1yuEytP
	9MW2bRbHjajN+VIn1lBoHYK+MKaIGr4p4eMbJJ9TLGISs98YgbeA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cskyp0jfj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 10:46:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6298UWjH007745;
	Mon, 9 Mar 2026 10:46:40 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013063.outbound.protection.outlook.com [40.93.196.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4craf8g162-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Mar 2026 10:46:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULF+7R5yJ4jiAz6mm8rO2jp9rMJU7n6BifXrviMpbeUkXplYqyGxsBsiaLofKvBbuq4BxQV97fUmH0dWUJHL4BstV8Mn5WqqA6EMBH2i9h6xqoVpXVHYPYK8xRD2FV7YaOB3k9IYIBv12YGCA65laPt9gDttJgFzT0jzvghOijVhDZXyS4TIjyMOnqSW32V4WRJynxc856d7/ovHfnEzh7CQft5JRFRJqDw9DNSYiU2BaYElffGWUVICaxRrHTRKtyfMjO3/FFiUSPhZwcU5VDVr7NLkZFmcpdI616B8/jtzMzHI4Zam2XcjSXzHUfBE1T+j4V9kfpvH54OMSYVLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPjKBbwnduBfNX4OTfqgITmBAL01c22nCT2e0qdG82c=;
 b=c675BsSl40qCYor3MZxBvXYl9ApWW2C2KpMOIAVkk+jyp9pKqsBmhk4FBAMVa/CTILJtBmojUz1HPvdARS75Jm86zdzTBjIYJViiESgzQPKDuya6dIWPENbhxK0eK+ngQRLtb39kuz7ikyE6bSZ4ejHCIUQdsVgDMRIUfUSlpLRlnnrSJizNUiLn35prc9Ifpu1ewtaYGNUfOmuFTju0ogf79TymOxoykc/4K9hCOlPnsEKNmlC65cWcyKSvEJjghJ3kpSS7882S9tksQO9pm/zgoHYhzVaOCWfVLyEW48EdHcSvHF18Tm1N8BpUb3YuZIExEWE8AA++lyDtySgMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPjKBbwnduBfNX4OTfqgITmBAL01c22nCT2e0qdG82c=;
 b=A7gCiPhc6BwHFw6iGfL+epGJj2PzNhzMUEBYbwfLOHNvkryL/JyaOJLZ8d1DIvlxc+9jFquuCkgR7E9pKwWgrOpXe0OMgzo3Z/M4BWsUjmT+tMiZhjGKCcNri3sbNqq5qRRtLyIvVRW0KXLc7d8Yi+QnQIBIRkdM+FC2b3UEFEg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DM3PPF5F5663669.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 10:46:37 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 10:46:37 +0000
Date: Mon, 9 Mar 2026 19:46:29 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
        Qing Wang <wangqing7171@gmail.com>,
        syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com,
        Liam.Howlett@oracle.com, akpm@linux-foundation.org, chao@kernel.org,
        jaegeuk@kernel.org, jannh@google.com, linkinjeon@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, pfalcato@suse.de, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz,
        Hao Li <hao.li@linux.dev>
Subject: Re: [syzbot] [mm?] [f2fs?] [exfat?] memory leak in __kfree_rcu_sheaf
Message-ID: <aa6lBQDAVnqjz_lk@hyeyoo>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
 <20260302034102.3145719-1-wangqing7171@gmail.com>
 <20df8dd1-a32c-489d-8345-085d424a2f12@kernel.org>
 <aaeLT8mnMMj_kPJc@hyeyoo>
 <925a916a-6dfb-48c0-985c-0bdfb96ebd26@kernel.org>
 <aassZV5PjgFx8dSI@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aassZV5PjgFx8dSI@arm.com>
X-ClientProxiedBy: SE2P216CA0171.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2cb::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DM3PPF5F5663669:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aea4060-47f7-419d-6120-08de7dc92367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	THB9urLJwb9oJ3Phj8nCXR7aU/XIftD44Ch8UGpYSGBx4NLJhdh0BGqBBONnakB14kAI3dHL+FKhmWcqyUsc6Z2XmE9TbqMYmAqWxflSjTM8BNkc9tITeJlvRVzjTbELYFTAVWaPNVRNp2mKEvI3b+ZNZOj6YqaV7Cg0yRewUGe0/O+KDvpdcXyIoRLpLeC/zvswpVEvL3MZOosVil3lT2nIoClHeu3gkbDYTbe3RyFd24q0O49VnB6syYlTHxsHbQxeZIkdUTXDZ5xMVQ4TFbO9NURSTzxkQJBDllWrNwofDmx+WiEvhRCjaUcBxVN0saLiBHIN8XqAlC42L6ym9ydOIPOHOqhvPQvUT7E+iUWhLFh3Cdq4zYUGf4vgj2zVd733MaqMIa8v64HZZ5rW+epeKxMGyeZR6ERfvT/ljJxToLDf3unRZU0kLu1ONaTF8L/ni0eOjuNeqEqgCLUvRS1PeJMgiYtTbMSamtxw51AU5efWGzAmB9dQhHgX6I58vPb+4mrt4kyBN1shjHdaWLXO5IOiuUbUOXfL3z8UIZoKWZV0g9LdFKrZkeZVoidwMy59h8t4K7KIZFMh+PI8e5piZNRdNUrRkBb+wDW6CXbznd691qCAUHkAKrcZH1NDYyuXfNwk/ENx/jZBdIfOUcIeJqi4AByP99H2KgVjD9hrqE7BxMZF/J1TDB4VkJlDJrEq2l6CNoIo+5Oc2Iq4wYofMi2tDh75gS7tS/Gulas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t71rmHzwpUoHx6jjfvTvumQqpaO2BTTxUor87fBFzJfuameSsVTwVDKRox3w?=
 =?us-ascii?Q?DhqEDOmnDHdaJW1Jat4ooQw1UDxsrcxNf/3D+HUS5dpKEd5dtcL7PGqVVIyo?=
 =?us-ascii?Q?wMLT46b/Z6GJA4beiWfJ9oLHOoBHZi+AA9WhnD7nd9PY4skrcKQZOVeAJcpV?=
 =?us-ascii?Q?t3vdyvh05zm7+fxIh8Ohs9aesulF+98efBLoe8zHXzckSv4m1oHKcLoE6P69?=
 =?us-ascii?Q?VjPGyWF6+0/h4UexZDF2PnXki4KYjcK1iJzvOzPmaSCfn/EAROZNrcdQKmLl?=
 =?us-ascii?Q?+0G/MWZUi37nastm4CErvjkdUdUypuKTH9c+qq14Bo1W5M2jnmCeog6fsbUg?=
 =?us-ascii?Q?rNCaK38bi27nqlucMuzajX4Pk/oVQptVIS7y2xwOJU6YfEt/PY9VbqsxHYZd?=
 =?us-ascii?Q?iFTi92bMNA9fcJwydfyetekOOHeszJ4LQ2QEeERutNa4C8qy44XyabDSMjcF?=
 =?us-ascii?Q?kf06YTwz5sfyrBib/QXitc3UQkG4RuTc+RnMAD1eCSLoaAZbym9skJqNaFse?=
 =?us-ascii?Q?fY0fCErXpU+VZk1HemXEOJxbDpk0ZkKCiQB5gw7b7wJCWH0JxB5Fz5j/uPAg?=
 =?us-ascii?Q?p6ozc18yYb1D3xFQ5TaUWTJ1zhvVRxkmitvtiF+DXWi2fOK2cLfx4gnyN3ND?=
 =?us-ascii?Q?iJCr+89hAhPPf30qG6DpZrvqyOR1YNCsT5qMNm9FiLjzNnHjy1PfSuS6OI5N?=
 =?us-ascii?Q?sbtSfidxSc9fAFn+b5Y4kG+2sS3Xp7kKkwjuxZW489byKzkKFLTVwQG5zFNi?=
 =?us-ascii?Q?QUQfjCxW7bpkXYIzIh0KvkZ3m63I6HyTXDcnDueNzUOyiZue0CsssE0BlnsB?=
 =?us-ascii?Q?Dwl0GFXO09yfU/znI2Nog/4nlefCPGX1e2tvli6Blk4FnavxuzUl5+4hm2rH?=
 =?us-ascii?Q?LODk37A0oj46iCE3YagFlE7X+Fex8UiZN6vnZ8ysNgeWT4Ep4fvHy6/eivbj?=
 =?us-ascii?Q?2+egqRaDrLK1CClBefWIyLnwoS+tqMyvem+rPdSUtC1Qu/tXa/QUk69ol4yP?=
 =?us-ascii?Q?g3VtLQv3I0IwWhBBtb6HiaTHauTO0LIrwSNyTtJOxqQVuyIjPakEw+166etJ?=
 =?us-ascii?Q?XXj46Gcfrwf03zdDoyVKSqS68QpFMQ9EELcp1npU+jwt3rjs81ca6qJOQkpw?=
 =?us-ascii?Q?VhlbJtYLATp0FVrlSp2Yc76w9zNSAMxWYU0e0KaMNp82y6ACTTOBdxFG+bVy?=
 =?us-ascii?Q?UjXKG3JOwu3+xwoo48AghK+T3LaTkzl6sU+rQD/Q94jaPH7ePeGuK6sbKM0u?=
 =?us-ascii?Q?MvDp36ZaT8NJLrzMTl9434RBUQavVCj3On6f3hsIlqAZ/fy+LyWcEKKWPHXP?=
 =?us-ascii?Q?zG6n12jg3xM3cBIo2le15uYU/id7Vbs/Fpm/pLuZSCrTsabIa2bSKIBVVUsa?=
 =?us-ascii?Q?UcZKTBypSptX551+psEPrTDR7Baj86Fb8RGAXWn/mJf1zeP842vd4St0S64i?=
 =?us-ascii?Q?EE/EYoSA9kDP6KRkL6iRbN79clPNaGDKRQpkSRPyc6Cf024B5Zy8BcnzxwsG?=
 =?us-ascii?Q?H7Wao/hbb/8sp3Lpsfzl3S+jNBFGcyQ/olqnhbbj8v0i0TRUIT6JwBHNBsQC?=
 =?us-ascii?Q?wmzf/cKkcJAWPVHGhL6h64zrC0ytxlDxjLij4fQ0gB+YQDiBGX1c9ng7m6k4?=
 =?us-ascii?Q?qqSMlKztgARJCosHvbVTRbbNuoetrUvSwtO+Spcl2MwE/LLhE7cxYdhkUUMP?=
 =?us-ascii?Q?Or96l4iCdt7t2G14+y8H1r5xVRYVD85r6qF0GyFn7FDmaEOgMBO2bsT5JD74?=
 =?us-ascii?Q?UXAwzO5pMA=3D=3D?=
X-Exchange-RoutingPolicyChecked:
	hVFFPnMOmP/hSjMbhrMSx5fZgPMuQ0NDkXdmaCCU2kLgomnuEKLEeK7SMFG3VzQH8mIE8NcQ+Ar7BRjpRmN1jGcN8Dq+jXx3Sm8SpWfgFR37Zrwt5Qpk8xX9rXqUY7QVCSjgUa0nwe/IpatSCQnGJuPSJh3hJEGyKEIo/VLMJE8cxvm7iYIWXe2+mt16xgK+AdzlnloybOfzm/F8accXIXiM1EgI4295nkBemwpodbaHAvQI6wEPUSNQcWo2rTZmW6cBvTFivryt+2Bg6XC/9TBhGVCTytGr7O0Xp3czIeP7dfXz8idvKWlGtx3L/hX47lXb/soCOOe8JfXe8c9aOg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kfMIfAiFOM4SKjv9QFhCAdMnBoIsIG1f4WQSNllfVVUCZNc/EF0o7CyadMGP3Urb6UOxTrok8ycTat0ocExqlvNpVp7lYrq8TP/L0FJW5reWuswa15OEy2Y8ZeEspRg9ACRzkGdPYNZ4hFWQUOvhchGshPIdHCGTPX9I9YpuFGhTaI5U1++XErdJ+vk+QYOOByoCM3as0uzFo50L0LFS9XDUQtuQDfXGn/OJlG2O75Hi+Zc18BjsdrQodpleMfohlpeACRYVc9d2R503QZ1o41usNn6PyxlKeqbE+9Xv6dn+RvLtFemyNX3D5g7dV8aP/0xzNmdYMfWAL/4L1glRt+GZ50NqG9iGqFd3sE603aR0U87Jz4bAbXdgVQr5pfxxaMgKwcoHgjE9paZU//AX7wLj6kyxwiBnZ/JPVK668CJAypLFl25fVM/HeqoCOZcFfyZnd+8BIM04duuJL1jLLiHnsh6xDIA9dRzClK3vUDPLArAcL2BRRtdSVs/Y2fn3Z+eCygvHPIlwLAgwTmg+GrKAjuW9Q4guK0q0kzxMUsT75vsN5/q912GgAwCVULxNZ193UeeU00d/NWxx5mBC0EHhs/ORQn/Ggpegspdgv+s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aea4060-47f7-419d-6120-08de7dc92367
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 10:46:37.1763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tjC1cOG7DLc+fF4ojhPrPeQaZRj/7OCWJ89n29CRkrKiRw9maVNVASVo5eCaAqwlu7xK5xov1Oe8bue3Wf6cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5F5663669
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603090099
X-Proofpoint-GUID: VdPUR0djJFG1ykNV7D-4BuDVkBbQ6_o7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA5OSBTYWx0ZWRfXz2q/5bXjDCuD
 7fao8yG1n/VvCjFpNHdUPoyjS/XuYtQWKfcJ7c5FXP64+tRW+mEANXDyhNYdE5RqwUj9/ZFgv8r
 cQ/94pyJ357CDMZd8fs53KYDrar8EB7PTU+1bAxks7Z9Ps8/IAI/klTRAUn4h8+6JGb9rW/lWoR
 rpJyEk7kw3KGaFSDoEG05G9knFm3Y65b4CCDlvmzs2UeOLl/EDoj3aMaqKTxx7XnYrA1SIVQaj6
 IRmduV4n6Fg4w6m57RtbwpUNGRAi5x2cH510KAaKGrJeZyO1UDjWSHqfSdkUq1g0ey0NvuWr7Hw
 Q9oS3H7vCnFm3fF1cFx2k5f7BXqaG0KyZEMv3sGxJraeKHaBIEBVRGCScRnvQ2XTTs3QJPyc3Cr
 qiqO4UvRERggGR9wXkHLjc3H+3ovwfSc3TiRx7K2i3E4Xh56stO7DsXpyxU4f36f0tont6dSUIy
 kk1l8IJy/KNZRw2/l6g==
X-Proofpoint-ORIG-GUID: VdPUR0djJFG1ykNV7D-4BuDVkBbQ6_o7
X-Authority-Analysis: v=2.4 cv=XP89iAhE c=1 sm=1 tr=0 ts=69aea511 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=CLLFTE2cTOy5wMrOj_gA:9
 a=CjuIK1q_8ugA:10
X-Rspamd-Queue-Id: D761C237608
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,syzkaller.appspotmail.com,oracle.com,linux-foundation.org,google.com,lists.sourceforge.net,vger.kernel.org,kvack.org,suse.de,samsung.com,googlegroups.com,suse.cz,linux.dev];
	TAGGED_FROM(0.00)[bounces-79760-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harry.yoo@oracle.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oracle.com:dkim,oracle.onmicrosoft.com:dkim];
	TAGGED_RCPT(0.00)[linux-fsdevel,cae7809e9dc1459e4e63];
	NEURAL_HAM(-0.00)[-0.999];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

#syz test

diff --git a/mm/slab_common.c b/mm/slab_common.c
index d5a70a831a2a..73f4668d870d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1954,8 +1954,14 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 	if (!head)
 		might_sleep();

-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr))
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && kfree_rcu_sheaf(ptr)) {
+		/*
+		 * The object is now queued for deferred freeing via an RCU
+		 * sheaf. Tell kmemleak to ignore it.
+		 */
+		kmemleak_ignore(ptr);
 		return;
+	}

 	// Queue the object but don't yet schedule the batch.
 	if (debug_rcu_head_queue(ptr)) {
diff --git a/mm/slub.c b/mm/slub.c
index 20cb4f3b636d..9e34a9458162 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3014,8 +3014,10 @@ static void pcs_flush_all(struct kmem_cache *s)
 		free_empty_sheaf(s, spare);
 	}

-	if (rcu_free)
+	if (rcu_free) {
+		kmemleak_ignore(rcu_free);
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+	}

 	sheaf_flush_main(s);
 }
@@ -3035,6 +3037,7 @@ static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
 	}

 	if (pcs->rcu_free) {
+		kmemleak_ignore(pcs->rcu_free);
 		call_rcu(&pcs->rcu_free->rcu_head, rcu_free_sheaf_nobarn);
 		pcs->rcu_free = NULL;
 	}
@@ -4031,8 +4034,10 @@ static void flush_rcu_sheaf(struct work_struct *w)

 	local_unlock(&s->cpu_sheaves->lock);

-	if (rcu_free)
+	if (rcu_free) {
+		kmemleak_ignore(rcu_free);
 		call_rcu(&rcu_free->rcu_head, rcu_free_sheaf_nobarn);
+	}
 }


@@ -5948,8 +5953,15 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 	 * we flush before local_unlock to make sure a racing
 	 * flush_all_rcu_sheaves() doesn't miss this sheaf
 	 */
-	if (rcu_sheaf)
+	if (rcu_sheaf) {
+		/*
+		 * TODO: Ideally this should be undone in rcu_free_sheaf,
+		 * when the sheaf is returned to a barn to avoid generating
+		 * false negatives.
+		 */
+		kmemleak_ignore(rcu_sheaf);
 		call_rcu(&rcu_sheaf->rcu_head, rcu_free_sheaf);
+	}

 	local_unlock(&s->cpu_sheaves->lock);


base-commit: c23719abc3308df7ed3ad35650ad211fb2d2003d
--
2.43.0



