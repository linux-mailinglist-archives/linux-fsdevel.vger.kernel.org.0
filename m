Return-Path: <linux-fsdevel+bounces-47297-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCDAA9B9C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76899A2C7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A9228F52B;
	Thu, 24 Apr 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ikid5Ntf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Fydk75tB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F0584D34;
	Thu, 24 Apr 2025 21:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529364; cv=fail; b=I3Nu380uHzJ7aw/d/KE5GIFtZPQWxszwDTW5Gi0juX3EnhfFBh5Z/lD4HcWWVr+yNLv3WehtUgHWYiYZQNc5PtI3nMLXWoHq3/7Gvn6wpMKc033QM9F0fMq6Vxr5+istafQP/konbiKA97EXuBxAT9QcO/SFTlNIdqzFrOP7XEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529364; c=relaxed/simple;
	bh=om0YK6ULXuugTQuxY6gGES4mTlXySe8kmyxt9q0+1mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIJlLm8DLLs5dvJ+re6imo1v6tvF50sCGZ7D38NJ3vdUR63MeIeL7/Z0hM88W4YXOkBu45jPan8WjGCePdGOnmrZJXU+A65tO/4XtqAbj6zvmVwQ3Z09HPsZq+BGOG/NtLcsHUeoqCvncmNwl+df3nuRGP8ffx/ZDhTEM/x0aT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ikid5Ntf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Fydk75tB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKvK8W015653;
	Thu, 24 Apr 2025 21:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=WsgagZrdIqTW34FFqI3g0y7LU3FlT1xris5bENdkJ7w=; b=
	ikid5NtfVcFhFOwvrQU9jf/gJG6wfLJpJ8x6x7fEdaOK0VUlOBJ3+HIgssO7RvU3
	tT8qsLpd8Ai77DUA5ss3pmDm71Rc6zs3FYGbE7Xa1b7JBQSTLOJd4hRz3LFooEEj
	oLseYm0fILFCdGWM3jWkVjPzsImntjdFpUSrW/7+XLiomGeCFKiOhnMdH7owgNjR
	Ar60FHedRSvolzuoRSc8HYlYnONKlW8JCn4y55xVs32fjQShbyaMlG0ho/uNMi9P
	DpvQkn41iFONfbDd3Zkw1C3h0ugNnmZb/fFvEuIdjz733E8Hci26p6wPF4meHADQ
	F2xFBAk80sfvPRBp3SYdKQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467vsg815w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKp9eB031703;
	Thu, 24 Apr 2025 21:15:47 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfrxs02-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TawdrTj1iqcGWBms7Z+Qex7kgVVdQR/2VSJ1vU6bHuTIgW99v1EwWbzPc3WxRjydRpBnrSjaRKWY1ceQ9s0zChCZ8KDv+EbxT16dKrXxSXNDpLWgaPIKK/uYap27x8TSbK8VKVZ8d1S7OPo1VmYrSEW3YPN2xD++ShPR8R2J5SFnk3LKNyVf7O+VgJERzVxeCvxE6Z+Wtk6TyKiXqtLpq4nxvZwTvJyJdKxEt5IsmKJFCFuxp+sfUhhI4+/fAz5t8LGDNShUgxPyRtzFbPZpJ4EcgTo23kgv+sgdS5ovf+Wv+LFz4gOzcxBY72Hu06QrFEGrULUQa4z+D9K/6zNbdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsgagZrdIqTW34FFqI3g0y7LU3FlT1xris5bENdkJ7w=;
 b=EOgbF+IbJdDuBq7qq36uXkW6T5/Cmkise0JEZeIWpJj8QRmxc89iPZzJtuL14mQSjpjCVAEDW+qt+IENu7/rxENFa2NWy7DcCHksSCF5ItMe2ri6jNA1DlRB04SwYnh5qFy+TjdKoZr7Ps+LdvKOXAywFZlo/GiTlJtbB1aPsQvT/w/ReoGIkAvzhactv6zgTNlUBYRj5SlDD1oGskDndw8hMGTKR+hpehHRdKH/oNo4Eluc6u9xaYoi0276jZ32Y9f6aQwgW03UNWJstnfU6FsVZ4RJXHA2b6gATOOcS0dLa+L4CXnmBpc/yJG3yKyNX+i8IgqlHhO4S0fx66xuBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsgagZrdIqTW34FFqI3g0y7LU3FlT1xris5bENdkJ7w=;
 b=Fydk75tBoaBmsdQacd1u/AM33r6w0FtklU4cf4UGE4PnQLqcn1NMb05mEPs6yba4u6x0GLEkH0r5P1U5qkYNQYKyPs7zOgmZlDl2Ne8g0/Ct2NIO9eC9AI0x8+Z3OFwJ8ERri0q9Q3+aJWKNGzsBjbOpqS8IQ8tKhsgfH1P+wgM=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Thu, 24 Apr
 2025 21:15:45 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 21:15:45 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mm: move dup_mmap() to mm
Date: Thu, 24 Apr 2025 22:15:28 +0100
Message-ID: <4ee8edd6e54445b8af6077e6961543df6a639418.1745528282.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0395.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::22) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: c191d62b-ca6d-4718-83f0-08dd83752d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/SlhA30JC+yhAjz2XwZLnT9XfkVA2Mxcb002epqWmRi/lA8olP2LZP/PKoL?=
 =?us-ascii?Q?Ryy+lj++q5kmuLELDJ/l/+V4Lb/0PbPsmDQiPKACUsM75cYBdV000BHXjh/6?=
 =?us-ascii?Q?X+QhVqlKuXuj+ALl7VKAVhJI8C+oo8W0WGWL3JUKdintSwHQWdokmvzp6Tq1?=
 =?us-ascii?Q?bGo2fmywESyv9Foe+VI4ZXChqHo9H+xJHjtsiHmRr5Mq63lW2raiSHW5ZZYc?=
 =?us-ascii?Q?O5GAwNSMZM5mZz/JXGBeIaq3Yy0kVAuqCFLzz0lvr2VHcuOSIroGfM2wYv6J?=
 =?us-ascii?Q?8a2Bu7WEPNmDEMmRT5T9uLd62oRZqKJ799E4V3aOplGYg895+b/ax3jsdiK0?=
 =?us-ascii?Q?CbaDdcF6W8Mqq0rDNXuJaKqOkIO9QyM/h3wbGtMYG414K8YykBdhp6cSzz1K?=
 =?us-ascii?Q?w1ifwtDfbxRE3KyuM3Q/hm39CIsxQZjcSMoul+WVnoAoUuN0smkL1JcPOq/d?=
 =?us-ascii?Q?aFu/5f658ywVtz7ombD6ezJbAKv5/RooPh2NzTqUEmFM17f3fR67DKv3i0j0?=
 =?us-ascii?Q?B8DjymLAKa1jbqNE0B8as7rMb8H0e3FV9LW58/PPAVi1zxMt1Ey6ddmE/lUU?=
 =?us-ascii?Q?p2REeJTCmrRClM5Ft+SUQR/XjxZG97u7h05TQvyCY4HULe2tpt8XmQEOgb/u?=
 =?us-ascii?Q?V3n7lLxvCl7Iqq/RzNApw2MInU6ZkNzPLGbfwsbV/QGmZSCXDd8PwziqNf1l?=
 =?us-ascii?Q?clvcOWPwsnnV17tV+A/QKJ8k1CW7PLJe9vyE/I6HpdsO6SpQEtIcS6i51hNN?=
 =?us-ascii?Q?33qFAJIB9IGxYgrVFy6+pf6Zc2k6oBTOMjzzCHDNNpUtrzaAtRUo4krPmq0Q?=
 =?us-ascii?Q?sg+TKSP304JT0XYx7Va0whC+N1vyKbkjBqa1uC+A+NT7m/a6582J3FWAVPvI?=
 =?us-ascii?Q?Waoms8/+YY1ppW+xiVNymGBOOOLRStIQ7pb1FYPWlzfwTrwF8bwGM8IgccSP?=
 =?us-ascii?Q?OPkAJ0LwHNtF6PVJMhgpVx8I68gujRbx2WayS95HI23+lL6YwBRVutN5scFu?=
 =?us-ascii?Q?HG9/VmMGMC+mRcGOg1IqsObZYi+C7BW03n9NH03xOa+HnW83wtgmi63CiHoy?=
 =?us-ascii?Q?mB9mkaGNqStf4qv57du4txNNRmdgllS1djjMOSmbT6D6OqZscTCTU6aEP3Ri?=
 =?us-ascii?Q?R5P777VpSM/ye6BezCy/0sjenGPLG4DyBR36uS5fjsaRbbsMB+Fbw5zZNkfi?=
 =?us-ascii?Q?PHNRtqLcykRVchxs/9wMt86kk9JigoaTfYvGTFgNaHyMjy/wxdjmXqwW0s4z?=
 =?us-ascii?Q?r17H6mzPgjZyaP9qc8DfxVSJq8fuqnH9intLB+DSTD0cUcmqNP8Qpps8iG/9?=
 =?us-ascii?Q?bAImAGqntunGtSs8ZuPfvDDtymIAMfrW0ZP/URj5Xq8juXC/Uiyc5laRcC7l?=
 =?us-ascii?Q?6L68hqKpVZEykWy6SxkG5pRdeMyrxdQpOGMZ8YhzRKhNETZDAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IvRGCwZ6X44rJHkirNBEuFwhQUJGMvtGz2mlvR9FKi+ahuAzzUL+yFLsVGf6?=
 =?us-ascii?Q?MEFBJJkVJmyd0UvaRKXw191geCmT9RTwa1JNdzbKyTusDFtpSf+xpp0hAKb+?=
 =?us-ascii?Q?D8IjYVQGtF7+v5af/3c0zSlBiS8f8CQX3k7YCkScJhWaSiOCaghFxL7Gp3PM?=
 =?us-ascii?Q?umyFuBI0qYOvuGu2enrBqBgIIy9nbKenqgDdglY5zJVfpZ6gZ5v64NDToHR4?=
 =?us-ascii?Q?zWlPnfKBsHFs982YjXq39QSNvV+giJAY0lr6ZxWds2tnq0zSh/fK3P4N1kQK?=
 =?us-ascii?Q?43+dgZGIPAyENAKCIt6HkpHsVaBAfoVae6SKfsoKb/nq1arlDek75kaLNiOS?=
 =?us-ascii?Q?u1OFLB6/DVPtLRdWkoriNkvqFnKe5/xDJ4gTpKaZeZDxCd/gcghW79ktijgB?=
 =?us-ascii?Q?lbb1o/jRp4YwyNWv+6IQXKlhpTDLSXccxR7U2HqjQ14Kp4KgLR37GEoXvRaH?=
 =?us-ascii?Q?ziQDycvGwyvl9GbWUGDI7cgTC3DHja/wGaThTobXEA6TCrqKhX6nvaBoAAA/?=
 =?us-ascii?Q?/svz0Jz8PI9jEEyDqf8CPEvOrffuNmXqFBc8A7QIMa7hcQVqn2urTQHZaWeG?=
 =?us-ascii?Q?snu9MIxmnUA54dJA9I8pbkEUHEvzypS9PjFELbZlMYTLo1Tz90Xb0LnX6O5j?=
 =?us-ascii?Q?VqRHdV+9vDpObAsftGzQtava9V/lceMvDvPTWgouLmgwpdPgCCMiBqQP0XYh?=
 =?us-ascii?Q?GlBgTvo7iPFPwgWNoQ9OeOgi3kpfhcBASsEYtxih5h32Kk30uTpPyOQrcSra?=
 =?us-ascii?Q?V3SeuyryH5hs99O1l5TbPeiSFKAO9x+cTBjw74nuWl8kHxYt1EeGkJAf0uXi?=
 =?us-ascii?Q?X2V+8rlOHZPMj2lcff7kVB9bBVFbtnlZYvcL6QuoTjgjQ1E1cuYp67/ECfBN?=
 =?us-ascii?Q?1RkOsYHGhpbhQQ3oyVH4gtROApbkzYB6ogiWmUET+c5KAlRCsQyvo46gF2wm?=
 =?us-ascii?Q?Tp7iM62VTIrEL1KW8t7pp2TGeG76pm0yF9mFUBDCckuoNUk+W8ix4Q13xqyT?=
 =?us-ascii?Q?IV1AkdKJcw08x7VsgLrVu8aWyrCqoWO7dsMutsyWQDuBRxWRC7uXsNmlO6b4?=
 =?us-ascii?Q?pfUO5BclxHDQ5dLmcXEEihIJOAScd1fQbIZSCsIhGubOEB73LticX8sHtdBI?=
 =?us-ascii?Q?z4GR4+ccVDC/chSxoFNp17J+Mgy3Z/LxHQMHjLnwBEojgKN5pOUSj47SqTfp?=
 =?us-ascii?Q?CoRCiSRC9sruJaTBkK3xPLtpmwbLY851gPm5l/MZCGPN4gQUY9OIwSqzXL5p?=
 =?us-ascii?Q?QKa5/lnBajsP8GtscSAGs03hb1rnBFcAtRuHk+7cd/sldFTAj1eXTxQvdutE?=
 =?us-ascii?Q?B+L1l8gZqpPOMpC+MrhAH0HWNh/MqKhaAaT1HxQJPZEBXXI9oli8UlHhaSV+?=
 =?us-ascii?Q?bIkO1x8wRmcn0faWlArwQCf4MXfIeDUclS77yOAJEgsnH+mD4KtCb9dfEv3m?=
 =?us-ascii?Q?xQSSCtI9/NH5tY4dJbzef1nQENEHJnG010vW8OV22+g7H/rqZMtDi1Dd4KtF?=
 =?us-ascii?Q?XZ0HfuXwLaPGLThH/CpNXcxNVfThkdO1eJjTfCyV1gOp3Uks+kuId1qk4yti?=
 =?us-ascii?Q?Q7E6RR/QQV0IECtvK0kqfGYKQjIfy/nN0JBcKaz/CADhhCwigRPHakMFxVrO?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JDi2SAmfSNCucU/iQie0WHi6Ro4QvLGqaeCB31J1ZQRBlvFPdkr/gGYEuZz94/6exwzjrvOAkIfvIzC17wGyTPS/n434zdikncYnl63ORV7NXF4/dq71zYPL/ajrTPhhisIhWkOWYRgwE1xmG2ckr63IFNHZ7GCZkPT3RsAaEqTuR2sO7Tg8AiXZtpc46y4PcGs2Mlct7uUbDEyFOPHdfrHZ7q9w2RBrRcaHQRwNJhOONE3JoqGHEVhRv1ua5gzYUCJLsEt+rEHt43GI0fFYgg4cNoEg6mXFKJwE/uOW6AWdU6sNPDkReYjrgdhoXsgP4ma4YvwH0im1eHsH4RmvI0xybMORyn4GvHR5wUSbT3gXPhkzsbChsoWNJRnTmEovv79Wfvnm6OSP2WYQIggKh0jxt3XG4F7r45er3d7b796p1zjHffMg1oxZ/+dPb4Ud02HmJQMTjY+sRcZpZpaCLTPBcstQEO5BGHJkrmgQsFd+uh7bkLfZXNYSrw26nyd/bwU38qdL3pJEJ4JhFs1gfq/G+lVTXMSIc2OLmkWEi2iHigJ03eK8BFNBoIS6jYfklXLzYpiuDOfJAs5J50w1dLNU9Y3HTiPy7AWWUdmcrvg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c191d62b-ca6d-4718-83f0-08dd83752d52
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:15:45.3102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZfQDkqg+AnB/2rWqUVLJU/VP82phh66Q76MqKKImRgfSotLMSBL2m1GFEOpyw7MXarTyOUe+j8DEBuluM74zgOArgEu0Ip8N8Uxob9AET1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0OSBTYWx0ZWRfXxW0BVxbpq0e2 7EjzEpKnF1Yh45WwEOlTGstf9zkGilCGb5FLWNoXUDRbJP/UnLD+NJpjTJ849sgv8KyJyYzIMFC Kk6mYomcfWE/fiW2f/FDysa+4hRoGzO2R3FGWqRjBVPeo8AV2XYaTrLm1aHdqVmYTiJOTcOh6ep
 VyfK9alwawuQ40MrloG5T1GBTC3iJ2pKTfu+yH6OgkO36mRqJvbAxELrqtccunmv9hOY6wRBvJ+ GE3LHW76UF6CPfD2xkrlKCk30Uf9mnBbXcz2iCkAlrKCwizoZWUFkFiUlFg9gc1M/0GID/1f3bo LB+DZYoiDWNyLwnDWTW3ptvCckf1Rw+nXgnw8lbv732eHtlyz112tt+rjzGYx/sRVM+u2Bud+qr zLgJ3ykr
X-Proofpoint-GUID: UsUNTBojG4-ctcAob9amp4axOg_RJJtZ
X-Proofpoint-ORIG-GUID: UsUNTBojG4-ctcAob9amp4axOg_RJJtZ

This is a key step in our being able to abstract and isolate VMA allocation
and destruction logic.

This function is the last one where vm_area_free() and vm_area_dup() are
directly referenced outside of mmap, so having this in mm allows us to
isolate these.

We do the same for the nommu version which is substantially simpler.

We place the declaration for dup_mmap() in mm/internal.h and have
kernel/fork.c import this in order to prevent improper use of this
functionality elsewhere in the kernel.

While we're here, we remove the useless #ifdef CONFIG_MMU check around
mmap_read_lock_maybe_expand() in mmap.c, mmap.c is compiled only if
CONFIG_MMU is set.

Suggested-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/fork.c | 189 ++------------------------------------------------
 mm/internal.h |   2 +
 mm/mmap.c     | 181 +++++++++++++++++++++++++++++++++++++++++++++--
 mm/nommu.c    |   8 +++
 4 files changed, 189 insertions(+), 191 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index ebddc51624ec..9e4616dacd82 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -112,6 +112,9 @@
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
 
+/* For dup_mmap(). */
+#include "../mm/internal.h"
+
 #include <trace/events/sched.h>
 
 #define CREATE_TRACE_POINTS
@@ -510,7 +513,7 @@ void free_task(struct task_struct *tsk)
 }
 EXPORT_SYMBOL(free_task);
 
-static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
+void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 {
 	struct file *exe_file;
 
@@ -525,183 +528,6 @@ static void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm)
 }
 
 #ifdef CONFIG_MMU
-static __latent_entropy int dup_mmap(struct mm_struct *mm,
-					struct mm_struct *oldmm)
-{
-	struct vm_area_struct *mpnt, *tmp;
-	int retval;
-	unsigned long charge = 0;
-	LIST_HEAD(uf);
-	VMA_ITERATOR(vmi, mm, 0);
-
-	if (mmap_write_lock_killable(oldmm))
-		return -EINTR;
-	flush_cache_dup_mm(oldmm);
-	uprobe_dup_mmap(oldmm, mm);
-	/*
-	 * Not linked in yet - no deadlock potential:
-	 */
-	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
-
-	/* No ordering required: file already has been exposed. */
-	dup_mm_exe_file(mm, oldmm);
-
-	mm->total_vm = oldmm->total_vm;
-	mm->data_vm = oldmm->data_vm;
-	mm->exec_vm = oldmm->exec_vm;
-	mm->stack_vm = oldmm->stack_vm;
-
-	/* Use __mt_dup() to efficiently build an identical maple tree. */
-	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
-	if (unlikely(retval))
-		goto out;
-
-	mt_clear_in_rcu(vmi.mas.tree);
-	for_each_vma(vmi, mpnt) {
-		struct file *file;
-
-		vma_start_write(mpnt);
-		if (mpnt->vm_flags & VM_DONTCOPY) {
-			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
-						    mpnt->vm_end, GFP_KERNEL);
-			if (retval)
-				goto loop_out;
-
-			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
-			continue;
-		}
-		charge = 0;
-		/*
-		 * Don't duplicate many vmas if we've been oom-killed (for
-		 * example)
-		 */
-		if (fatal_signal_pending(current)) {
-			retval = -EINTR;
-			goto loop_out;
-		}
-		if (mpnt->vm_flags & VM_ACCOUNT) {
-			unsigned long len = vma_pages(mpnt);
-
-			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
-				goto fail_nomem;
-			charge = len;
-		}
-		tmp = vm_area_dup(mpnt);
-		if (!tmp)
-			goto fail_nomem;
-
-		/* track_pfn_copy() will later take care of copying internal state. */
-		if (unlikely(tmp->vm_flags & VM_PFNMAP))
-			untrack_pfn_clear(tmp);
-
-		retval = vma_dup_policy(mpnt, tmp);
-		if (retval)
-			goto fail_nomem_policy;
-		tmp->vm_mm = mm;
-		retval = dup_userfaultfd(tmp, &uf);
-		if (retval)
-			goto fail_nomem_anon_vma_fork;
-		if (tmp->vm_flags & VM_WIPEONFORK) {
-			/*
-			 * VM_WIPEONFORK gets a clean slate in the child.
-			 * Don't prepare anon_vma until fault since we don't
-			 * copy page for current vma.
-			 */
-			tmp->anon_vma = NULL;
-		} else if (anon_vma_fork(tmp, mpnt))
-			goto fail_nomem_anon_vma_fork;
-		vm_flags_clear(tmp, VM_LOCKED_MASK);
-		/*
-		 * Copy/update hugetlb private vma information.
-		 */
-		if (is_vm_hugetlb_page(tmp))
-			hugetlb_dup_vma_private(tmp);
-
-		/*
-		 * Link the vma into the MT. After using __mt_dup(), memory
-		 * allocation is not necessary here, so it cannot fail.
-		 */
-		vma_iter_bulk_store(&vmi, tmp);
-
-		mm->map_count++;
-
-		if (tmp->vm_ops && tmp->vm_ops->open)
-			tmp->vm_ops->open(tmp);
-
-		file = tmp->vm_file;
-		if (file) {
-			struct address_space *mapping = file->f_mapping;
-
-			get_file(file);
-			i_mmap_lock_write(mapping);
-			if (vma_is_shared_maywrite(tmp))
-				mapping_allow_writable(mapping);
-			flush_dcache_mmap_lock(mapping);
-			/* insert tmp into the share list, just after mpnt */
-			vma_interval_tree_insert_after(tmp, mpnt,
-					&mapping->i_mmap);
-			flush_dcache_mmap_unlock(mapping);
-			i_mmap_unlock_write(mapping);
-		}
-
-		if (!(tmp->vm_flags & VM_WIPEONFORK))
-			retval = copy_page_range(tmp, mpnt);
-
-		if (retval) {
-			mpnt = vma_next(&vmi);
-			goto loop_out;
-		}
-	}
-	/* a new mm has just been created */
-	retval = arch_dup_mmap(oldmm, mm);
-loop_out:
-	vma_iter_free(&vmi);
-	if (!retval) {
-		mt_set_in_rcu(vmi.mas.tree);
-		ksm_fork(mm, oldmm);
-		khugepaged_fork(mm, oldmm);
-	} else {
-
-		/*
-		 * The entire maple tree has already been duplicated. If the
-		 * mmap duplication fails, mark the failure point with
-		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
-		 * stop releasing VMAs that have not been duplicated after this
-		 * point.
-		 */
-		if (mpnt) {
-			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
-			mas_store(&vmi.mas, XA_ZERO_ENTRY);
-			/* Avoid OOM iterating a broken tree */
-			set_bit(MMF_OOM_SKIP, &mm->flags);
-		}
-		/*
-		 * The mm_struct is going to exit, but the locks will be dropped
-		 * first.  Set the mm_struct as unstable is advisable as it is
-		 * not fully initialised.
-		 */
-		set_bit(MMF_UNSTABLE, &mm->flags);
-	}
-out:
-	mmap_write_unlock(mm);
-	flush_tlb_mm(oldmm);
-	mmap_write_unlock(oldmm);
-	if (!retval)
-		dup_userfaultfd_complete(&uf);
-	else
-		dup_userfaultfd_fail(&uf);
-	return retval;
-
-fail_nomem_anon_vma_fork:
-	mpol_put(vma_policy(tmp));
-fail_nomem_policy:
-	vm_area_free(tmp);
-fail_nomem:
-	retval = -ENOMEM;
-	vm_unacct_memory(charge);
-	goto loop_out;
-}
-
 static inline int mm_alloc_pgd(struct mm_struct *mm)
 {
 	mm->pgd = pgd_alloc(mm);
@@ -715,13 +541,6 @@ static inline void mm_free_pgd(struct mm_struct *mm)
 	pgd_free(mm, mm->pgd);
 }
 #else
-static int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
-{
-	mmap_write_lock(oldmm);
-	dup_mm_exe_file(mm, oldmm);
-	mmap_write_unlock(oldmm);
-	return 0;
-}
 #define mm_alloc_pgd(mm)	(0)
 #define mm_free_pgd(mm)
 #endif /* CONFIG_MMU */
diff --git a/mm/internal.h b/mm/internal.h
index 838f840ded83..39067b3117a4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1630,5 +1630,7 @@ static inline bool reclaim_pt_is_enabled(unsigned long start, unsigned long end,
 }
 #endif /* CONFIG_PT_RECLAIM */
 
+void dup_mm_exe_file(struct mm_struct *mm, struct mm_struct *oldmm);
+int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm);
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index fbddcd082a93..31d2aa690fcc 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1955,7 +1955,6 @@ int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
 	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
 }
 
-#ifdef CONFIG_MMU
 /*
  * Obtain a read lock on mm->mmap_lock, if the specified address is below the
  * start of the VMA, the intent is to perform a write, and it is a
@@ -1999,10 +1998,180 @@ bool mmap_read_lock_maybe_expand(struct mm_struct *mm,
 	mmap_write_downgrade(mm);
 	return true;
 }
-#else
-bool mmap_read_lock_maybe_expand(struct mm_struct *mm, struct vm_area_struct *vma,
-				 unsigned long addr, bool write)
+
+__latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
 {
-	return false;
+	struct vm_area_struct *mpnt, *tmp;
+	int retval;
+	unsigned long charge = 0;
+	LIST_HEAD(uf);
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (mmap_write_lock_killable(oldmm))
+		return -EINTR;
+	flush_cache_dup_mm(oldmm);
+	uprobe_dup_mmap(oldmm, mm);
+	/*
+	 * Not linked in yet - no deadlock potential:
+	 */
+	mmap_write_lock_nested(mm, SINGLE_DEPTH_NESTING);
+
+	/* No ordering required: file already has been exposed. */
+	dup_mm_exe_file(mm, oldmm);
+
+	mm->total_vm = oldmm->total_vm;
+	mm->data_vm = oldmm->data_vm;
+	mm->exec_vm = oldmm->exec_vm;
+	mm->stack_vm = oldmm->stack_vm;
+
+	/* Use __mt_dup() to efficiently build an identical maple tree. */
+	retval = __mt_dup(&oldmm->mm_mt, &mm->mm_mt, GFP_KERNEL);
+	if (unlikely(retval))
+		goto out;
+
+	mt_clear_in_rcu(vmi.mas.tree);
+	for_each_vma(vmi, mpnt) {
+		struct file *file;
+
+		vma_start_write(mpnt);
+		if (mpnt->vm_flags & VM_DONTCOPY) {
+			retval = vma_iter_clear_gfp(&vmi, mpnt->vm_start,
+						    mpnt->vm_end, GFP_KERNEL);
+			if (retval)
+				goto loop_out;
+
+			vm_stat_account(mm, mpnt->vm_flags, -vma_pages(mpnt));
+			continue;
+		}
+		charge = 0;
+		/*
+		 * Don't duplicate many vmas if we've been oom-killed (for
+		 * example)
+		 */
+		if (fatal_signal_pending(current)) {
+			retval = -EINTR;
+			goto loop_out;
+		}
+		if (mpnt->vm_flags & VM_ACCOUNT) {
+			unsigned long len = vma_pages(mpnt);
+
+			if (security_vm_enough_memory_mm(oldmm, len)) /* sic */
+				goto fail_nomem;
+			charge = len;
+		}
+
+		tmp = vm_area_dup(mpnt);
+		if (!tmp)
+			goto fail_nomem;
+
+		/* track_pfn_copy() will later take care of copying internal state. */
+		if (unlikely(tmp->vm_flags & VM_PFNMAP))
+			untrack_pfn_clear(tmp);
+
+		retval = vma_dup_policy(mpnt, tmp);
+		if (retval)
+			goto fail_nomem_policy;
+		tmp->vm_mm = mm;
+		retval = dup_userfaultfd(tmp, &uf);
+		if (retval)
+			goto fail_nomem_anon_vma_fork;
+		if (tmp->vm_flags & VM_WIPEONFORK) {
+			/*
+			 * VM_WIPEONFORK gets a clean slate in the child.
+			 * Don't prepare anon_vma until fault since we don't
+			 * copy page for current vma.
+			 */
+			tmp->anon_vma = NULL;
+		} else if (anon_vma_fork(tmp, mpnt))
+			goto fail_nomem_anon_vma_fork;
+		vm_flags_clear(tmp, VM_LOCKED_MASK);
+		/*
+		 * Copy/update hugetlb private vma information.
+		 */
+		if (is_vm_hugetlb_page(tmp))
+			hugetlb_dup_vma_private(tmp);
+
+		/*
+		 * Link the vma into the MT. After using __mt_dup(), memory
+		 * allocation is not necessary here, so it cannot fail.
+		 */
+		vma_iter_bulk_store(&vmi, tmp);
+
+		mm->map_count++;
+
+		if (tmp->vm_ops && tmp->vm_ops->open)
+			tmp->vm_ops->open(tmp);
+
+		file = tmp->vm_file;
+		if (file) {
+			struct address_space *mapping = file->f_mapping;
+
+			get_file(file);
+			i_mmap_lock_write(mapping);
+			if (vma_is_shared_maywrite(tmp))
+				mapping_allow_writable(mapping);
+			flush_dcache_mmap_lock(mapping);
+			/* insert tmp into the share list, just after mpnt */
+			vma_interval_tree_insert_after(tmp, mpnt,
+					&mapping->i_mmap);
+			flush_dcache_mmap_unlock(mapping);
+			i_mmap_unlock_write(mapping);
+		}
+
+		if (!(tmp->vm_flags & VM_WIPEONFORK))
+			retval = copy_page_range(tmp, mpnt);
+
+		if (retval) {
+			mpnt = vma_next(&vmi);
+			goto loop_out;
+		}
+	}
+	/* a new mm has just been created */
+	retval = arch_dup_mmap(oldmm, mm);
+loop_out:
+	vma_iter_free(&vmi);
+	if (!retval) {
+		mt_set_in_rcu(vmi.mas.tree);
+		ksm_fork(mm, oldmm);
+		khugepaged_fork(mm, oldmm);
+	} else {
+
+		/*
+		 * The entire maple tree has already been duplicated. If the
+		 * mmap duplication fails, mark the failure point with
+		 * XA_ZERO_ENTRY. In exit_mmap(), if this marker is encountered,
+		 * stop releasing VMAs that have not been duplicated after this
+		 * point.
+		 */
+		if (mpnt) {
+			mas_set_range(&vmi.mas, mpnt->vm_start, mpnt->vm_end - 1);
+			mas_store(&vmi.mas, XA_ZERO_ENTRY);
+			/* Avoid OOM iterating a broken tree */
+			set_bit(MMF_OOM_SKIP, &mm->flags);
+		}
+		/*
+		 * The mm_struct is going to exit, but the locks will be dropped
+		 * first.  Set the mm_struct as unstable is advisable as it is
+		 * not fully initialised.
+		 */
+		set_bit(MMF_UNSTABLE, &mm->flags);
+	}
+out:
+	mmap_write_unlock(mm);
+	flush_tlb_mm(oldmm);
+	mmap_write_unlock(oldmm);
+	if (!retval)
+		dup_userfaultfd_complete(&uf);
+	else
+		dup_userfaultfd_fail(&uf);
+	return retval;
+
+fail_nomem_anon_vma_fork:
+	mpol_put(vma_policy(tmp));
+fail_nomem_policy:
+	vm_area_free(tmp);
+fail_nomem:
+	retval = -ENOMEM;
+	vm_unacct_memory(charge);
+	goto loop_out;
 }
-#endif
diff --git a/mm/nommu.c b/mm/nommu.c
index 2b3722266222..79a6b0460622 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1941,3 +1941,11 @@ static int __meminit init_admin_reserve(void)
 	return 0;
 }
 subsys_initcall(init_admin_reserve);
+
+int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
+{
+	mmap_write_lock(oldmm);
+	dup_mm_exe_file(mm, oldmm);
+	mmap_write_unlock(oldmm);
+	return 0;
+}
-- 
2.49.0


