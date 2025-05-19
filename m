Return-Path: <linux-fsdevel+bounces-49334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8BB5ABB7E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9ECA1188A376
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A06926A1B1;
	Mon, 19 May 2025 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F9cVF2Wu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="g7F8JYmc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF0269CFA;
	Mon, 19 May 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644742; cv=fail; b=fJnB4YRKSHACSpPv2HgdXjvX5/ASgul6HrqNc/sgd/Wc1GorvlR5PAVB8QH/z7+lzTStmzYjiLV/9twoKnq8aw3g4Hsp0SOIW1cnuKb725eiPUuc22ZrAwwiZr0aj8K9K2vEIfoQfqV6cboJTBmqWoYPavUt4mywY+h9HmNoPrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644742; c=relaxed/simple;
	bh=LlumqDS1X64BsB9WZszh9wkGe3/u3pDj2jOFnF8WEck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HV/8irCGrcMPslKLeUM3GaEaYauP+Xaz6Eka7zu4wXYIukzuxd3dUq6Zh8VAS1GyQcnHmROEwD4ixfHy3mBkbbrv6LtBRsl1omqRj8Ooauc/7/FBqPw/9x7twBW31MppV+5NVrLvAGR2Jo9qojma1J7Gj5wBbK252PQLfJzanZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F9cVF2Wu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=g7F8JYmc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6inq1014394;
	Mon, 19 May 2025 08:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=b3WwCx9vIC+oWToFcblKf853GaMK1ks7LA+u+ZNeV78=; b=
	F9cVF2WuFIPIsDhMPHnvcvm+IRjyC8ejb2PUXl8JYshr4dK6T0TZGKIVxv5S4KyN
	jWiz+Hk69Kru2m+zvj/Sn2dp9kUb2bOPSmVjOIpMrX+YWsUBZkJiGvnO7LfCJ/fL
	4Pm+alH7YXJteO1jkVVExwpq2LRhb5L4dGpdchQePplGemFURqzXv+PT5Kb92xsK
	QsEIgrmc2VlRt8ZdLeYgJsOLFabCCIS1+6A1ng57eD7pSS8yLg9+NypMdoyNvLfE
	VACucKEorVXG3pkMv1IiavFkelZ/wcAaAdZQk+7GkAyFfpV3+gcBzIXUVKu3KcoX
	PY6Hb8mQeKGAyGI/ryjD4g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84jfqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:51:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54J6tH1x029255;
	Mon, 19 May 2025 08:51:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw66861-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 08:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnHV0rOFFRhYpST9JRbX3X/y5MUNJOrI/CVKib8M4WVp/+kZ1540MVNj1sMjLKC065hoLBWsWmfUAsAretp8heAfDOx7DyjXyu5GujnSRz95k8VxRhF6zmw9Q9y+eLIC8bpy1eD3Kk3I9SD4nP4d6wQOjuyciil4hijPjMcyV25+pg3bNZSX/5OHcIymPpnwjrZGiP/Ifn69tNXxj0o7HOTiGwAGFT+nXt1eK48j+uQFJvHspY3C2N+4z+4gm7puBkRxUyx4OidJArWTBSMWUmAMJ2tWCctt4j2WaboupvIZYEuM3ZV+ixgBMT/njv0fE2MNfAoA980wJ5JKfBRZEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3WwCx9vIC+oWToFcblKf853GaMK1ks7LA+u+ZNeV78=;
 b=aKYaIke8blklOeRL4DPgzrnt9OTd18fv7k6/j8WHAxigV/5Geq4lQogMdMRgtVqvtmBbDMgiGCO7A1FKiUqOu/glTjgtQfIEuWrlE2qtVA+Nl3+wB+NcnGF+jC31iBFr03ME6cCxM49SwBII1svZHm157OG5NqgajGH5dXczj7HQxrI/TTLvmBYhwj+5ktn3MQW4m7CTV+uyg3rVrd0MrsNUvhcXsNHutipn/shSGod4J+Knl+7wlHcnRTYIKBVxyrsQZd4PS4LqYcb9u+zPMNTPme65t/k86u6e3D7njnvHMVqfy0TbVQ5dc19c5+kMU8KOQDK1iF2XyI7U927q3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3WwCx9vIC+oWToFcblKf853GaMK1ks7LA+u+ZNeV78=;
 b=g7F8JYmcC5cZtiltww7fnPzRf44J2D5PDLtZZTIZOGoPwbxg0JK4xOQhXD+pDR0R7IoiZ6jmGwOAxu1r65/G55GY/WmE6eawUaqvjXTPQEKkY8X6aTRmt2/4FQlyt2gBxs7BEx0kFjkaoXLyEMwYUak2jIt9/hBhbiRU2FoSL8U=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:51:55 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:51:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] mm: ksm: have KSM VMA checks not require a VMA pointer
Date: Mon, 19 May 2025 09:51:39 +0100
Message-ID: <daf12021354ce7302ad90b42790d8776173b3a81.1747431920.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
References: <cover.1747431920.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a47726-9fdc-419b-034c-08dd96b267f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Txe+Z4cDIv69/fY+qSA+NfUvrpEq63pEiorhnuv15051cRBKsnDZzm5UrZK4?=
 =?us-ascii?Q?IM95R5Gtu20lC7nwVJ1sV5A6JRthW3SmDToaZo6BqpRGJAnDfLTiS+QQJcGH?=
 =?us-ascii?Q?kTB9vnTKSAr/n9NHV8GSoGebylBel77dvWMT7Vm49hUfE0pSE10ksJBh7bJK?=
 =?us-ascii?Q?dseTfrl47zqkSdrKywuA8SX+ZGQZfpVwW2Stm8FzPsooIrTPc2HxPC8QWYqP?=
 =?us-ascii?Q?cApf0rsS4PXOkAFXin9czp/NIyKKvg3i/k12+byqu4dtrTsXxq0xnnmH+mkv?=
 =?us-ascii?Q?r3ZLLFjjTsiMWiw4ymJB9F+Ic81mRCR8NFQOjYQCRpx1b/tywqW9kBuPFpgB?=
 =?us-ascii?Q?ZeNnqZ6DJqwWb7tY0t2d8UkAspBQPzUK3u3fM+xB2NE0gCzVOBtiZFvky+i/?=
 =?us-ascii?Q?UU5h0oYu42NTdnhpLvAZqWN5De/Im/dmujAFWkpuiZvxvbcXWQ3Bz0VrUUsA?=
 =?us-ascii?Q?l0RXksrv7oZTqQ2KKb7o6csJZ+FiSA/AD5RGV9lRNIuRktnXaTrV0oy8xGru?=
 =?us-ascii?Q?Doi1MC2uSsksrbZIYSPJ7J+7+mxScM03xZEt7H577VhhOAtZZtuwGOcCCp4N?=
 =?us-ascii?Q?CCOjY2aWExR+hEqFHMVkBnJguOm/HoLmU8Xut/W+0DHhvSnsE9e2Q6+znD48?=
 =?us-ascii?Q?srIkaTAl7A6Co/E2qv/de6PQcnyDbyB5Gvg95MwfV4Pd4gTrm0hioeZfg288?=
 =?us-ascii?Q?/xtHAPDxX0Ydqpko6VPS6hKfQ5T9qODXNoK8V/xZhFyM3351Bcl+5IZ9TFvm?=
 =?us-ascii?Q?Iypcl6I5WkTlScCSOi3WwL5mNvxSXOHOr33kGB4Yz8lcAybiEViYXyobeunG?=
 =?us-ascii?Q?nr+55rO7qEj5BRAPSBNgrh1V4qTVzoGe8ofDwiClAe+VfJY+rW0wYOP53l23?=
 =?us-ascii?Q?PM0kzh7LXmTv1F7TYPsk5FT/JCPJu6BPIRpFO1o+YFmNCW8PRMbhKumKfDSk?=
 =?us-ascii?Q?5VbNm5aADkJBWqSISzXyPk7lKoJ0n9CkNoUXfXkjVZvHgcP9KqogEwgOP+mC?=
 =?us-ascii?Q?yL4icyQNbmay7pjJ/+SnprWQTD+HX4BNCKG/IaLDtPUlpS4VynEasfirCJb0?=
 =?us-ascii?Q?56LKBVClWNPZBzQIAQ2aqo5/8UtOR/aU0ewcwvhH0m7Cb13PrsUfHI6Dj+hm?=
 =?us-ascii?Q?lPsuNtoMWaS3/dxWBaKJ7MtNcvOjlpvFuo2BxokWoGvhF/pDMfcqtcvNhALk?=
 =?us-ascii?Q?uW3+qiicxKXKkYDCM2eFI6j6WwVMqPiHS8ShZxttm315b17pXK5ypJxR1QN2?=
 =?us-ascii?Q?oNWqOX6HkejqIy0utATlWjhU1R4sTxQGcjznHb5simIxbDuM94AQKTD367pp?=
 =?us-ascii?Q?CvuZSSR/P+PpvSBde8nH7ag2kmf8gq+rF3AIg1wcihLqtk1w8+vtnidhC45F?=
 =?us-ascii?Q?B1cNZ+rCBaJiyDSbh81TOzcfVALbtH0QCAYvj/RlhvSzmNh3WumRX80HMS3t?=
 =?us-ascii?Q?w2nQPiyoZ48=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WafnMrx/4nf/flgdnDoTl2xdjFK6AFWEsbkNAig401g65bgjTWXSjwh0LMbp?=
 =?us-ascii?Q?B8lyYxYUjgyrTCr4TxWKG4CftN/bhOqYWcrsXys8aSFBsdeUvoOmSM1POjE4?=
 =?us-ascii?Q?BP6HW2wa2a8UHXsYeJXQbaXOI6HV0r50xJPtSROzlaIjYErNu8Pu1gmKSwgy?=
 =?us-ascii?Q?E4kNCJfvwzsN56Q+pKHQA5xg9ORHb6eC5H4pZBYEZ8vMY3aLrQS2qXBFuhi4?=
 =?us-ascii?Q?BGyZB6JUiKuy0t8dMSJO+PZ/HGGEjqJwOXWZPDfuziHn2LvngBEUiAXNLnRA?=
 =?us-ascii?Q?dZ1shMLrGSzUlWbLzrb4LKVHWpvTmVY/ZfFUBDuJo286/ebEUC1sa/FInd9N?=
 =?us-ascii?Q?pYiXOH7NSQVhyqj4GDApeJJMUayJsKukQI+BnWYejPxJwvV+pAJ4G6sb89QY?=
 =?us-ascii?Q?uqpWiCaaErgaPZ52U5oeEp/D9hg7z5f2vx+DDpqF9fzO6n6dPYpGNriofyYT?=
 =?us-ascii?Q?8yj7QryDStKY+HpgyyQwpVmA+ck3mizYlitwuDvIIN92IiH+23/sl1cybrzg?=
 =?us-ascii?Q?JzC2Nx2ngc2vyp3KqN3CKw0ErlscE0lpqiJmOXqN8wSI4qNJDR21Jdksw9IY?=
 =?us-ascii?Q?vMx2CwjQfL9aWAaYovav3I4XxyPVyL8glHqpznjVWFecF2s9zakrBU/Z4gyS?=
 =?us-ascii?Q?CjAPTnyfKpGm2cEvwFnr6FlMsnhx439QztImz5LiaNHsro3s43pIKHku7ji6?=
 =?us-ascii?Q?Gk3GV9MUGXkPeN/25ZxS/7/XWZNsWI1ZUmXgNwS5GrrPVCXqjGBQm993OHsN?=
 =?us-ascii?Q?kDsYiRoJFBg0dLgUetolzrsDzln6dQ9ITc/idYWeiEHX+d4RqiV2KHtlh05W?=
 =?us-ascii?Q?5n5whgScv15iwmrvsOEcl6Z0GP5FaG3KKQVlf71W2esiR4l/s32npdyweeHS?=
 =?us-ascii?Q?ESUyQobM2tNUh90flhUywxE1X9nQ6ibOy/T1m73Wr4MK5juh9Y2P5CuGIq0z?=
 =?us-ascii?Q?h5fFhxsbeqRUU7cAmY7NxyzSU+82b1zrXMq3C7McMNDDX70IIzsJXlLr9gtq?=
 =?us-ascii?Q?Iu8AMWNTTfI8qALRwCsVoSPSxCuInA7AeCcAz7efDxa96rEpfwaW7nlZ12Dg?=
 =?us-ascii?Q?GMwGAjnKQQecuCthzjOE+oOWlgljGRTqu24cp//xir/rBthdQ2VYynVSyEme?=
 =?us-ascii?Q?2zS8367ODhbPS+2OfqWac+wkqKV7g0SU/4cX5aBvNlVYBSnAUkjnoCTIIFlU?=
 =?us-ascii?Q?6GppkpkQP3KkkRjfCHor/hZ1oeHHN35Hj+f4YCmBNnipqYo/X/qsaRlu7HAq?=
 =?us-ascii?Q?26J8fx4QQDP+bIS2vMbt3IHcuMtErG0fYWdiS11yYnXK8G3xxH9Koz9qB+wt?=
 =?us-ascii?Q?4EktcBN4CHhMv0H4J27S58b+f6d7EKUn6WPEOSrT+Xxinb9Ml8GAOMOnXygJ?=
 =?us-ascii?Q?igxjkUgL9+5YBPf6GZBkd0N4x/FgzSBEaWQeDMEgHYfLSWSS1EzlHz9Mg4VH?=
 =?us-ascii?Q?22PNjmJ3qt/4hdMIrah1EXkcQgcIeas+N4vKsgCYRL0YZvO55klrhKRWFIXe?=
 =?us-ascii?Q?uZMsgPFrFFRW/slAlcidDGPDuOryMPSU5Fr9MjyECTwlgx5QCPb7UMoK+arX?=
 =?us-ascii?Q?oBhXGNKtH07YJbl0eu7E6vl/I3LxigBfQDk1Qg5kbid7mejcWFx5agM0+WPh?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/eFr13yyK634mm0KzOaHBnyKNkj8+AmgHiUd1fUnh+jJW79Z20jQLNsU7iGdWxQkEz9S1hlYVDUaBEzmu4y4YeujsrYm6dxrr79KIRKhms/E8LUXd5vzoFra0RXyk5KvVnGn1c4nZqQI/yW9Q20pxNh08aLLhXsnqYaZZSjaFY2nkmcIJikyOAipzsxcf+yd8DISKoYdQgsmvRmwtAf8tyw7Gs8W6KjU19ksxl5tZ6Bp8KaWd/FDwNxgByB3NwmI6dqLNKzeVOr7ete33ULJMeSrDjc8Qwz3Pm2avLHCs2N6JsZWhI1UE++i/oBNTtwY/W8R8e/Xot7QOU0deJentp7tKvtO8W3IMdYSeS4PJSpL/4dPS0zM0rDb/kN3dWfRvkY3RSet4hHwwWbrL4FWkGj3DFtjSzTGkDtNKazGSRg35zUDZ/02Vvd1i6WU/09EfdfC67bbzWLP25tMsyWhHAvUc8yN+ljSum/tASHhXPlZbUX43OLbnJlSojTOrYgN8yh1fGG7B+l1UcvuBLSGrU/dtYOgaxp5S6l9uCSEl7Uqcp6tb3KiP+AMMLj3xyadzf+E8SmA9GSn/p7Vz0U7TVfy3cYtrc6n9IeyT0+TPhU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a47726-9fdc-419b-034c-08dd96b267f5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 08:51:54.9551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LVeEy27y74p02pmWjxu2kIq53BXzJp0JBocsFokgeJIAZx29Gfrpj1/bgdhN4R1GHsrCLRIjsKYKXuagZFgNIHpIVA0IeP+a8osZIlD5nFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_03,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190083
X-Proofpoint-GUID: 6DyrqAqxmUnXm2FFQA_edAxpPh-1hBo_
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682af12f cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lOzPg2vIf24U1BXouUEA:9
X-Proofpoint-ORIG-GUID: 6DyrqAqxmUnXm2FFQA_edAxpPh-1hBo_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA4NCBTYWx0ZWRfX1gVfF4PX94fh OEQeso2rk5Fm7f/uEUFrJKjdhfhZPjjey2LdhqgOwNSYbMiTqiUwWHi6iD/g6417vQZvi3RXpCS iRiyblPu97RFePAcXnX/V+RezjdKbE2WDa+rsmwSCyTLoMdI7bQS8OkB2ETNsd7ZhuX8mI03RzY
 ZxSm5L9AxFqdAlm/22TXK6k0jMp0+9Pi4bxsvTGGX4MLqVqCpA9rLxCM9WylSa1R5+fQQi1Zmh0 bJadlQQpKj3H5E3Vomp7TLOmRRFMTSqZz4RzuMyXNYPEBorKCGKMkZ3xV90MXHi2LrgSJEqvnDN H0asUHqlawJmRVFmLOuaoCkhfegK6kAINDH4+5BDM+bGfznM5VK5BtyQTitSzWJniNqOkp7Y9O4
 UbvMX8V1zkixHBnTqjPoRbPmRyUrH0fzKuDInwlZRNLg0/yxSjA8dKwBsjafoKgsMmdXSlNC

In subsequent commits we are going to determine KSM eligibility prior to a
VMA being constructed, at which point we will of course not yet have access
to a VMA pointer.

It is trivial to boil down the check logic to be parameterised on
mm_struct, file and VMA flags, so do so.

As a part of this change, additionally expose and use file_is_dax() to
determine whether a file is being mapped under a DAX inode.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/fs.h |  7 ++++++-
 mm/ksm.c           | 32 ++++++++++++++++++++------------
 2 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 09c8495dacdb..e1397e2b55ea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3691,9 +3691,14 @@ void setattr_copy(struct mnt_idmap *, struct inode *inode,
 
 extern int file_update_time(struct file *file);
 
+static inline bool file_is_dax(const struct file *file)
+{
+	return file && IS_DAX(file->f_mapping->host);
+}
+
 static inline bool vma_is_dax(const struct vm_area_struct *vma)
 {
-	return vma->vm_file && IS_DAX(vma->vm_file->f_mapping->host);
+	return file_is_dax(vma->vm_file);
 }
 
 static inline bool vma_is_fsdax(struct vm_area_struct *vma)
diff --git a/mm/ksm.c b/mm/ksm.c
index 8583fb91ef13..08d486f188ff 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -677,28 +677,33 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
 }
 
-static bool vma_ksm_compatible(struct vm_area_struct *vma)
+static bool ksm_compatible(const struct file *file, vm_flags_t vm_flags)
 {
-	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
-			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
-			     VM_MIXEDMAP| VM_DROPPABLE))
+	if (vm_flags & (VM_SHARED   | VM_MAYSHARE   | VM_PFNMAP  |
+			VM_IO       | VM_DONTEXPAND | VM_HUGETLB |
+			VM_MIXEDMAP | VM_DROPPABLE))
 		return false;		/* just ignore the advice */
 
-	if (vma_is_dax(vma))
+	if (file_is_dax(file))
 		return false;
 
 #ifdef VM_SAO
-	if (vma->vm_flags & VM_SAO)
+	if (vm_flags & VM_SAO)
 		return false;
 #endif
 #ifdef VM_SPARC_ADI
-	if (vma->vm_flags & VM_SPARC_ADI)
+	if (vm_flags & VM_SPARC_ADI)
 		return false;
 #endif
 
 	return true;
 }
 
+static bool vma_ksm_compatible(struct vm_area_struct *vma)
+{
+	return ksm_compatible(vma->vm_file, vma->vm_flags);
+}
+
 static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 		unsigned long addr)
 {
@@ -2696,14 +2701,17 @@ static int ksm_scan_thread(void *nothing)
 	return 0;
 }
 
-static void __ksm_add_vma(struct vm_area_struct *vma)
+static bool __ksm_should_add_vma(const struct file *file, vm_flags_t vm_flags)
 {
-	unsigned long vm_flags = vma->vm_flags;
-
 	if (vm_flags & VM_MERGEABLE)
-		return;
+		return false;
+
+	return ksm_compatible(file, vm_flags);
+}
 
-	if (vma_ksm_compatible(vma))
+static void __ksm_add_vma(struct vm_area_struct *vma)
+{
+	if (__ksm_should_add_vma(vma->vm_file, vma->vm_flags))
 		vm_flags_set(vma, VM_MERGEABLE);
 }
 
-- 
2.49.0


