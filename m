Return-Path: <linux-fsdevel+bounces-47990-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5ADAA84FA
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 11:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2C1E17848F
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 May 2025 09:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C8FE19D07A;
	Sun,  4 May 2025 09:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hlkEYTqL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ikrpgtlo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E3718A6DF;
	Sun,  4 May 2025 09:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746349216; cv=fail; b=a4nfg9uemqeHwHbFO9KlKIzR+dnQBKM0zmnLcN6zJ2aIBiObLu8QC5TpRNSqDjQwBFBNDlBqR/4731G4bQtzKtaMkbljQWpWjTCgNejiXTn2b5PHUkfjmxaaGxoClL4tS/xpIhDsNmGXTHJUlXUC38MWichOiEdDf/YvdvV1LK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746349216; c=relaxed/simple;
	bh=s9umRKRFfgTIQlD4/bOES5+0zQw8uME5kwsNul37vHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmzbrGIxZlbFKVw+Zxi3EnzyqIXDqdPThdQhXeiVLuql1HJYpJnGa4to+bODRSC0oz2sKb4MRvOytAwnQWlFD9FD6Ng84+rPyT7lJgJIR/BNtXWGOfvxz2dymnB8ZgaurL6IKl9h6Y8jK5WHdD7b2EsAodVAp3NjSZZrFYrX3mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hlkEYTqL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ikrpgtlo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5448l9FE004894;
	Sun, 4 May 2025 09:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=; b=
	hlkEYTqLf271AWIZ7Y0Yn7roQOOyeJK1/7YTRxDXBZO9iqJWxpuTB1jlDHO54B8c
	tQaKJBbxO37nS9sX72kOuU5TbaVipCv0+LSvv++nk2gKAAT4L6h1vp+HyegoH+g4
	WhXY6iT1jlada8lf1XCwOHl2dm3yXINt/RzQdrjXmiA/zl914toyGHd7mjmMEmnV
	RCbQaJtR74nzAHUPu4SPrAHLwZqlgnP5FYyLA1LYjWwEhKj9SLXMWBUcYwf7L0Jr
	nrWePKHRU5rwopqlJNm73QMXuxXZ2zABPTCLpTrQ/gA6L0aNLEW5RJb+AwtO7H+0
	R0mCZ9Lzqjm9gUhtqmP7/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46e51bg07s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 09:00:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5443UDQo036077;
	Sun, 4 May 2025 08:59:59 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazlp17012052.outbound.protection.outlook.com [40.93.20.52])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46d9k7ghc9-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 May 2025 08:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Odi6SQBfZTD7/nQrWXi5QbvixvH61Wggb1LYTaXYhf0LtRYPr2oxlQMMNEd/CnioHg0UnIDTjztUbZbJbxFG1GkrUlUM1YJ7NX9HxU/OjAte+CLWqOyabEDwHrT7sqR8i/Hcr6qEj1oPZ4dBTh8fi+Hqc86jQP4KxyCaLnUXt/Bn8Flm4aGeeLArSvn0LYMGyfHe4t3FIU0f+JderjHRILurjAy+BMjx/TEnoVeL8x8hBbQ2AYvmSJhWAYXG/Fz1kgB9iHUW+urLeIY21NRlRDg4F9JZQ00SwCPnk95PytGtRnL8ifPVD2sSSP5QbamRGcc0t2oirvruNC4Vsuo+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=;
 b=RAoAMIX7oQNqoRNESqoJvmSE4b+emKssiUrIw9LygIr3+dOcMujlc/JJT3kc45zzNxMZiMGiXZHoulZ5L7YGEr8PAsFelY3Uv29DFrRRHQwE1hObl9jy9w3SMIXTqR60zo4OqqmFG3sY6hu1TakpOwwNdrMcpTwHaY6xj7e2ZU2tNBSIdz4YYD/uaRIXv/EBZqCxhajUn0g0Pj0P94DozUTf2hL701HS7BbpnRTt8crH4dcO+YgWj8ngUseeV1HawAsvaQFR0QoIKyIGJab9k75ODuulKQsIggiHCEPUppEragrYjYOu0grO+D1kg6NfJ7ZK+c7upTM5ccYZbdEwlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rd6C5ey/l+sEGTPpaZvEmNeGhYfJukcUhgGdg2fVxfg=;
 b=Ikrpgtloy3hn9lV+0b9Y6zc6VuYERZF0QROj70i9Q9+2oORHlJQxECmtaihxeB6v+6IR9fjSfyh/97rbJPsqJMQwso137HURJICCEhlJOKHvXeQOBEDGw5FSSwJozDKjLuwl4+XH7ITPL5jQzgmflZaUWmhtE0YVM3PgK77/t8w=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB7178.namprd10.prod.outlook.com (2603:10b6:8:e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Sun, 4 May
 2025 08:59:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Sun, 4 May 2025
 08:59:57 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v11 01/16] fs: add atomic write unit max opt to statx
Date: Sun,  4 May 2025 08:59:08 +0000
Message-Id: <20250504085923.1895402-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250504085923.1895402-1-john.g.garry@oracle.com>
References: <20250504085923.1895402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0276.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: ec20a1b1-e1c5-42e0-dc34-08dd8aea0b27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8Tqt2ePendC80wwlpXMwzaSb7f+JB0BfLSaqebeJzmpjC0r8Jq6Nkf4O3FN?=
 =?us-ascii?Q?SAh3ChADXpyJXUpzmSW3QjNtQs1mn1o4zMf/QJLIakFuQn6zIlc6EQqxIzfU?=
 =?us-ascii?Q?4NwI1tWvSt4Irel/mooI6mU+LqTIzpGTDr2G4npyW8syyr1Jk7HYYec158wY?=
 =?us-ascii?Q?vyCiYMnDLXOmZayL91eEuH1E3XxGSaGKQM//1jaRvURsFJ8oN03Ezj8+cJ4e?=
 =?us-ascii?Q?m6y5nbKvwMKstFvAbYGyHR2nBGvIhAuMuiHNcFIeMjI8PeFRtqX14+divz0w?=
 =?us-ascii?Q?XiRw1UrEtsWUCQm9aQcjBgtEJZCLxHFWGlM8MfkFbCUix3/Ge0fEOmrRRS3y?=
 =?us-ascii?Q?xtrIC49Oectqoe/N1aUpB93bElHWMAk1qcwKSzJWl3i3BGTtsu2lxYuSgqmB?=
 =?us-ascii?Q?SIU1Hd8cGV61lCMo48Q0xk1AW7cmT9Z0HsQEFBu5EbVfSDqwkLLc6jZjs6cb?=
 =?us-ascii?Q?wcBYXimIOjcdwhVBjznMmGRvcaWq5CCDLuwWJdEoLd3E54WqumYjczYqslNG?=
 =?us-ascii?Q?KA1+o+VsXoeSz9E60G6aSc64ZBbfiVvdkraT6c/LryWn+rqTtsPvlA/3z0ia?=
 =?us-ascii?Q?aQgtt7ChuXGCOll7SRnlWlNmkkOZ1I8PyugtezdjQd9ZGLWsCS5yf2rZLQNA?=
 =?us-ascii?Q?U+hZIDh0/rYb7mS3GYhYMjyU0tnYGfpTMnoWu4p4rs3F7T2dhLsCfSWas/OB?=
 =?us-ascii?Q?H4gXjfDwH9Kc7q3Jx0l+I+mnP7vu4fcD3xg6vw57tsUPfK5jGGWqAC7m4GKp?=
 =?us-ascii?Q?lTVn1Bq7Ub7gSOqpj3X1E5q056XA1EfycD6v3zVzaWLC3mOwIq7GR8Ic70GQ?=
 =?us-ascii?Q?NdRRCiMBPplU+0YV9u82vISG/tg42SBOT3CiPkEz7GqhekG7QZMuOyfjJ4s9?=
 =?us-ascii?Q?5kpDeDR0lqCD5kJg/77pEsHCWJGAFK2umhj5fbwjab2tMIi5gvisfQWbGdJF?=
 =?us-ascii?Q?EQgPsSixzfR+RwT90O4v71erkI0E9tYb7chSEBfqP/9uL+smFzPP55udTFVo?=
 =?us-ascii?Q?Wdb3ZnLvEVc4fN3Kl3aBVfBhugD97UTKJjF/vv+mPI6jTH/LmfOppefG9PRr?=
 =?us-ascii?Q?8uO05dz5+5mY8r3/E++PLq0NDdeNK8+UruG0IjUtR80g+d2ioBLr4H7f0aCN?=
 =?us-ascii?Q?WVzNnwcecBfxhfhEoL9EOrNgp+LJDQm0O2nf+PQiiZQYN0oaiQN7b3PTir5U?=
 =?us-ascii?Q?dwxL9eaQS5p0FzSnwOMpMiK4raZjZXSAeSzRxgspulB0Sq4IBrnBAMvaYE3D?=
 =?us-ascii?Q?p8kFSzlEBCIZ4iQ9bESOJ03dazxNWYjyZnpd4D3q7eIAViFAsoIYA8OssnQp?=
 =?us-ascii?Q?4MvS9EujdrOuToQOeIj7Ra/Euxc1SQKsI0z/HiXwvQxFZlTP1OcC1UMumKyX?=
 =?us-ascii?Q?DR15FrtnE+NWKAZaaLPhAjqjpjKK+8CHIEKpGQpiYdBpNvVdAvBCKLCzs1Gl?=
 =?us-ascii?Q?nybcFxpKl7o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jFTRw/CcfmIlH8eqYcyMamkq36HJyJ6V+k7nGeLvKXLi4YG+wKCdJzV7U0Mj?=
 =?us-ascii?Q?LD8/EiiM04/7zRvyEL84ml3g6pyX/RxdVprKSKtW8sTynbiOr/oFBGPOz+Ie?=
 =?us-ascii?Q?tsN8BPgGW7zea8wkNYvEmVFw1waY07a041PqL9KeeAf+u7/fabtovXkarwDi?=
 =?us-ascii?Q?zk+HHbO3eJ8efVceHsYo9Qb1nu1xu0gFn+GTUYX0sizeGv1UWxfmIuCEwldX?=
 =?us-ascii?Q?aZcFf2In4ek3F52Z38laSsWQn+99clEQ6eDOh85lQT4+/UWOFZKxkHXUvwwQ?=
 =?us-ascii?Q?Bbm9MLgCQmzG+J+RgB/g0887/wAlNHBj7UAsL3DkLtFXak7x0zj86rSY/qaE?=
 =?us-ascii?Q?zrA7WJPArH7KrMC9VrC4MKzzKesMul7ldLXOE7qZuZPcklqCzrr65KlRUJMt?=
 =?us-ascii?Q?vSWWWKjkHU/4mSWZ2pkP2/KWequjYEhYlk+00BvJ5fvqm0wyXERVFDp5+QGi?=
 =?us-ascii?Q?Wdb+XuKQBfLZMZZrJldlUBecZ4chCB/h208tWfkKHWtROSU/dJ3ORmPW6lk/?=
 =?us-ascii?Q?rmi7A6LMKMwmqaeViA56FOvec9uLqTgKdOYV5FjopvBMApxpBMp4Q1+asKzl?=
 =?us-ascii?Q?jqfjukhWtv9rnPiMrVEvAm5xM5H0nLtYGD/kvhNgcd+F2oa+Lh19pSUCSTnu?=
 =?us-ascii?Q?C7mYctf+hL0G+jUDv/fEjlrxsh1eWRY8rUtSaW0ECyGFyCiy+TRf90JGjx/I?=
 =?us-ascii?Q?vi7Zvr1NmuiotZQ52AKdPSbX0fRh5u4bH7HxnoWiqpS1ZXE+Q7SagaVhP2I1?=
 =?us-ascii?Q?C0bL/DCoD/KsA2r4zsJFMdaDl5zlPo3pSn29odtBqfhmgGgoB9bmZsURi3n6?=
 =?us-ascii?Q?6hTau0FmxUh6SHSlEWNP656NF+MJyw4EvAr7CcMw5DbZe3z1/9b8pNfPy0PE?=
 =?us-ascii?Q?Px7NOdDN/2trdrZbb51VE1BG6o1GJJD3blgDl66ntoSuPKab5R5jWEYf6pvk?=
 =?us-ascii?Q?6H4KW3d0tAEg9TnJ5oTSu4wLyDII+DE9OLOi0jOqM7y0+mXyejW3XWiBOYbo?=
 =?us-ascii?Q?AMk/Uf9uLxJ6AQZHEJO+RdOwpkbPH4G5z89pI3uuZoK8s6OqKxGGNUu1z2CM?=
 =?us-ascii?Q?3yZ1bpRpTmFYZZP6QKXu9k39AksA8J9t9kFO/92sgI/P4h34VLTaynNwU26z?=
 =?us-ascii?Q?1ZbJZDGJWqFzlORuSdENVKup4nMoAE4q6KIb/YmdIOGNGhgOLfE/Bh+l9JDR?=
 =?us-ascii?Q?Jik0CR44XnR0N810Hl/tw6kcu9QW3mHM2nWwR8aPfr5ooYqP0Hp7GLmZcvsN?=
 =?us-ascii?Q?S3KMq04TY3X+5L5Fw7HKMDu/btvG2a56C49EsHhHeoYKkiRtyYF6inDDhNHN?=
 =?us-ascii?Q?uQ1M8jq3nCpmD/t7pLOuTnV0H5HDY6/x2OOImtKImaxjHwaHyrRssOSm8oY1?=
 =?us-ascii?Q?1kA9NLgOrkFyn5jiqMfrxFhTerkivFjxgnIdAMgcSeO4S3vQp9clYBTYcoiu?=
 =?us-ascii?Q?W34d4X3MTk2HJe+xaz0rGT3f1LZ9TjbpTCJvrPtf/LR1VCOM0Px7mlGjTWyM?=
 =?us-ascii?Q?3dwgIg8jHZ1sNwFJuuPiBJMRNXX+lQWVfqxN6zl2Xi0zYXqh1JjpMLISjwGk?=
 =?us-ascii?Q?P5PvkvvDLclNnKg8p7U5R94fjUNy1FkVUpilpxkEWZZKjckwmGNfytPGhU+c?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qi/9JzKwQF9YPlstp1DbtJjX9xOGjh/MDktcDW177xbF8KDNwCBijILn+VaprdHOHQqoexXhMPP1NjKiHHX1JAb2HEAh/7Ws5r8vWQ6Ht2lFLPRWrom9x7nsvo+ROhLsjOZOjniaO1u2Kn4NAIIrEItsF34/UMI085BkR1xUSPIZveFy/VljdUcGUUrCp7yAxts5UyUxR+qNHUhFKKiOxyfBcbd4QjtXy/voX+ywWMBImx3EqYDKzR/d0rVM3bDoMB325oYL/n+W16nKi/PmSZsdBjStiYx5UsPsvRzng9JVXI7esJWIk4qQHCkFvBaIXvRS2EyHm8UC6PAj8O1S6+To0oTFtB5ccb9BTL0ugBGHP2jsOB+t2+ssWk03ZIJL53yGKjoljKTmtxlxoiBHG5N1RyKj4bGYKwvJkU8s5AKCvcrWGjhFBN2yFkGzkOiP5fRhIDAWMnHLVYH2QiF7jHALwqOhaYsEGJNRDz1Ep39u8CpPlj7kbdoOzdBmEfOqMRLrpkO/dtm4V0NWxrbH4mfLCFjZdg/bXNDgulSJYIfFDRj+QmY0lW/o/cdPcuFxd3b//LYbLCAHeapDUt60cBVBtHBqQfnMAXiuNjC1qEc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec20a1b1-e1c5-42e0-dc34-08dd8aea0b27
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 08:59:57.1896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3GYih//ti8HbaFRxulGx/WnSyT7fz0fJ8oub/ATKceAvhraDuVzLn/Tk/pNpCST/fUuUpGSGg00cTamanLsktw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7178
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_03,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505040081
X-Authority-Analysis: v=2.4 cv=C8LpyRP+ c=1 sm=1 tr=0 ts=68172c90 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=ihQL3A0VzzIQ68P4lnIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDA4MSBTYWx0ZWRfXxMq2Xah69NC1 VyHY46C6ZtyZydpiNxuT9snx0YCBzJFmzf13qUctf96gVMRrpxtmxY4EuiXV7MKB2Y1y7oWEnow XA1MaBaqWn3qJCSJ/aHaFn+uLPJcgXTzjxASAnG7hBtzHq/ITNJntJJkjL9dsohw8NU/ybdEmIn
 YiDBNfT/GTWZHDpbBpeQsHSC4SRLy5DfXurDgW5IXzFYnTUkmnFkZSN9fB/CUOr2kEbUiTIelNk z/f7MGPshBh4lU3GBVQC1ynMuO21s7hgewfKTlZTaQ8hlrtBOZK9xKQ/4qeZl+8Sw4jvn8RfLGL wh+6DGTv1cDE1pyqhgbPTfdcNuxL9yqBtsNZaHwkj+ObvhdVy62e2xEfu7Q0O3jEoEhYshmPoQu
 GuQHMxlxgcuLUG/E1+hFAlMVz7pKZNAwoAGWcqbY6OUIU8Rh6RxSNx9AmmuRVvQawVYv6PHv
X-Proofpoint-ORIG-GUID: _AiMWzkN1yMMLCYjddBPvlAm4RXKLso0
X-Proofpoint-GUID: _AiMWzkN1yMMLCYjddBPvlAm4RXKLso0

XFS will be able to support large atomic writes (atomic write > 1x block)
in future. This will be achieved by using different operating methods,
depending on the size of the write.

Specifically a new method of operation based in FS atomic extent remapping
will be supported in addition to the current HW offload-based method.

The FS method will generally be appreciably slower performing than the
HW-offload method. However the FS method will be typically able to
contribute to achieving a larger atomic write unit max limit.

XFS will support a hybrid mode, where HW offload method will be used when
possible, i.e. HW offload is used when the length of the write is
supported, and for other times FS-based atomic writes will be used.

As such, there is an atomic write length at which the user may experience
appreciably slower performance.

Advertise this limit in a new statx field, stx_atomic_write_unit_max_opt.

When zero, it means that there is no such performance boundary.

Masks STATX{_ATTR}_WRITE_ATOMIC can be used to get this new field. This is
ok for older kernels which don't support this new field, as they would
report 0 in this field (from zeroing in cp_statx()) already. Furthermore
those older kernels don't support large atomic writes - apart from block
fops, but there would be consistent performance there for atomic writes
in range [unit min, unit max].

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c              | 3 ++-
 fs/ext4/inode.c           | 2 +-
 fs/stat.c                 | 6 +++++-
 fs/xfs/xfs_iops.c         | 2 +-
 include/linux/fs.h        | 3 ++-
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 8 ++++++--
 7 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 520515e4e64e..9f321fb94bac 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1336,7 +1336,8 @@ void bdev_statx(struct path *path, struct kstat *stat,
 
 		generic_fill_statx_atomic_writes(stat,
 			queue_atomic_write_unit_min_bytes(bd_queue),
-			queue_atomic_write_unit_max_bytes(bd_queue));
+			queue_atomic_write_unit_max_bytes(bd_queue),
+			0);
 	}
 
 	stat->blksize = bdev_io_min(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..cdf01e60fa6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5692,7 +5692,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 			awu_max = sbi->s_awu_max;
 		}
 
-		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max, 0);
 	}
 
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
diff --git a/fs/stat.c b/fs/stat.c
index f13308bfdc98..c41855f62d22 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -136,13 +136,15 @@ EXPORT_SYMBOL(generic_fill_statx_attr);
  * @stat:	Where to fill in the attribute flags
  * @unit_min:	Minimum supported atomic write length in bytes
  * @unit_max:	Maximum supported atomic write length in bytes
+ * @unit_max_opt: Optimised maximum supported atomic write length in bytes
  *
  * Fill in the STATX{_ATTR}_WRITE_ATOMIC flags in the kstat structure from
  * atomic write unit_min and unit_max values.
  */
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max)
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt)
 {
 	/* Confirm that the request type is known */
 	stat->result_mask |= STATX_WRITE_ATOMIC;
@@ -153,6 +155,7 @@ void generic_fill_statx_atomic_writes(struct kstat *stat,
 	if (unit_min) {
 		stat->atomic_write_unit_min = unit_min;
 		stat->atomic_write_unit_max = unit_max;
+		stat->atomic_write_unit_max_opt = unit_max_opt;
 		/* Initially only allow 1x segment */
 		stat->atomic_write_segments_max = 1;
 
@@ -732,6 +735,7 @@ cp_statx(const struct kstat *stat, struct statx __user *buffer)
 	tmp.stx_atomic_write_unit_min = stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max = stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max = stat->atomic_write_segments_max;
+	tmp.stx_atomic_write_unit_max_opt = stat->atomic_write_unit_max_opt;
 
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 756bd3ca8e00..f0e5d83195df 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -610,7 +610,7 @@ xfs_report_atomic_write(
 
 	if (xfs_inode_can_atomicwrite(ip))
 		unit_min = unit_max = ip->i_mount->m_sb.sb_blocksize;
-	generic_fill_statx_atomic_writes(stat, unit_min, unit_max);
+	generic_fill_statx_atomic_writes(stat, unit_min, unit_max, 0);
 }
 
 STATIC int
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 016b0fe1536e..7b19d8f99aff 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3475,7 +3475,8 @@ void generic_fillattr(struct mnt_idmap *, u32, struct inode *, struct kstat *);
 void generic_fill_statx_attr(struct inode *inode, struct kstat *stat);
 void generic_fill_statx_atomic_writes(struct kstat *stat,
 				      unsigned int unit_min,
-				      unsigned int unit_max);
+				      unsigned int unit_max,
+				      unsigned int unit_max_opt);
 extern int vfs_getattr_nosec(const struct path *, struct kstat *, u32, unsigned int);
 extern int vfs_getattr(const struct path *, struct kstat *, u32, unsigned int);
 void __inode_add_bytes(struct inode *inode, loff_t bytes);
diff --git a/include/linux/stat.h b/include/linux/stat.h
index be7496a6a0dd..e3d00e7bb26d 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		dio_read_offset_align;
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
+	u32		atomic_write_unit_max_opt;
 	u32		atomic_write_segments_max;
 };
 
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..1686861aae20 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -182,8 +182,12 @@ struct statx {
 	/* File offset alignment for direct I/O reads */
 	__u32	stx_dio_read_offset_align;
 
-	/* 0xb8 */
-	__u64	__spare3[9];	/* Spare space for future expansion */
+	/* Optimised max atomic write unit in bytes */
+	__u32	stx_atomic_write_unit_max_opt;
+	__u32	__spare2[1];
+
+	/* 0xc0 */
+	__u64	__spare3[8];	/* Spare space for future expansion */
 
 	/* 0x100 */
 };
-- 
2.31.1


