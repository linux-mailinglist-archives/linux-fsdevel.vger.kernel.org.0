Return-Path: <linux-fsdevel+bounces-47392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ABF1A9CEC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C9E84C6750
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4C3205AA1;
	Fri, 25 Apr 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5lZCcmB";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jBocRY35"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BF11F3B96;
	Fri, 25 Apr 2025 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599703; cv=fail; b=QxdQRGi/AV6+nIcdRHjrbswxjJExrBxVrzhMEDwqG7Qna9/Vj3OQzTsTATQBpXastjdI8JlEE6UKw1IUtPV2acsMq7SPYV7B+rnOUJUEDSUSxxHJRXkE7f8QlF3Xj+MJGRyax84cwAMR0MXogmZ2geNBO52gOVkhgNJz8fWQyJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599703; c=relaxed/simple;
	bh=jkt2dTvqDA+7XgFA8CqtXya3FsSR9oDjqwMU/9d6xLk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KCtkFF/nNq/70IUNcO6q37s/D4jup69CgMCfnBVCVdyVz/6NsKuhnNqNI+5zZEg/1BA9HtbJv/KaFP+JrkF7nhPa/pfpgMlC+ThmT0FPS2jFuVSwj1lEQIpGblSbd/KTNXq+hfe6hXYASL5jnz4PPG9EaCTW2+lVXJ+Q6aEF15o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5lZCcmB; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jBocRY35; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFqV5j008417;
	Fri, 25 Apr 2025 16:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=oB+7chQgRjKC1yB1GLnWgsuYB+a971GfEcdhyhMqGeQ=; b=
	O5lZCcmBSrDzbDjU0D4cQOkYCVm8f/r5LEfHMJGviXzuV/MN8FbZEm72ae7gri4M
	8nPc9Qpihk2HcsDR8ipGtx1KEq/LZSSYou8rOUp+zm14hN5nirNcWEjN8aQzk0Bk
	DbAr3nAUVXhNCmfBUmpJD1esYRYoYupCBxf966toxTsLItX5XJIcYKOS5kY+Mka0
	wJbvBL1zdFQeKHS1m606FPH/1tNzdefrjqfyOBtEkvckD1CC/PfgClko6i9UqXTD
	nWYMs/iLWUBW8pblWI+zyL8N/SHpkwyiHsRaIfoLdTkEgizgHe3elFngvcROqSin
	v49rRJtt/HsGG7cQj9+/nw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468d45r9f8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PF4l1h013866;
	Fri, 25 Apr 2025 16:45:46 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxrvd9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJAflL1u1mZVcEZYL68ZwBA6OD8mewUgyakVizOegwtnJuLySsqxUVAbZyBMt4FpXOlD32kh/zzUrLsyiuv+m0dGJeO95ETvtgAR19c2GjLvFodFkNivgOa8CRNO9cbIpUczxHKmITJ5JTyIfB5Wx3ifvm2VOETjyEdv7GVqaOiLxsKF5+tBrx/6PYhOaoREo0IHN1cujeQNvKIUBdlB9lDx8XouAlHN3jtWj7/eEtBcSyBIs3rNXXi95G8Ow3D2QoADFudcIQcUCizLt3pdxjtpMY8A8YkdjgIzlAI97rxb685Kxhj0epWrqlEGVKSMlLDrZxSfhurLDd7axJmj6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oB+7chQgRjKC1yB1GLnWgsuYB+a971GfEcdhyhMqGeQ=;
 b=vuvnY/WPiRkJev+7DiPeDn47XIoF5vhMRhunqzCOpJOuH3731W1HL9B+CNlUoVWD4Bi2KQBpYWkfsc251SPpuImLJfIyvq9vR/wH/dnuMwnAt7wjoqKJqfxSdf23MjoYBycCkxhXw7A/SuGOongfCxdqsRBRgRGwlbAaZa0qNTEFBfZwmmKi5x6XTf5mddvPEKsttpIywfZE5+4R9xhV9DpEV42IYNBcW7SVR4rb+QB5dIRgxgdii5+onQRw862mapFFXYvR2i1dSMuSGhbt/Mr7avBuCGkUQIvtbkyQQXYzLlZT9jkWbWXeDFed1f/bgCMkr6+pqGaBbITkKBE2DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oB+7chQgRjKC1yB1GLnWgsuYB+a971GfEcdhyhMqGeQ=;
 b=jBocRY35M5U8Z5es9KSKg6lAJPa50x5QQ+ogciicjnPUC8ZB2Dy3xK3B2w9J5Mt16OEqYDwonyiNMQjFEIDVfq2Lb5qBTQbKcUuLPKe93sz2v0cMiNCMji9kaESkvnPuN//Dv68eNdRjp2JBYSmDS2fkEtwithXCj2RtVPfymSw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 07/15] xfs: refactor xfs_reflink_end_cow_extent()
Date: Fri, 25 Apr 2025 16:44:56 +0000
Message-Id: <20250425164504.3263637-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::39) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: 3414a83b-a206-4b7b-48f7-08dd84189eff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Pv6y2zpYQiGknCGXH4cFneyqGTknJGD9YcYrgR7kJk7YC5E9kiGIewyXk+nE?=
 =?us-ascii?Q?lO5/rxCG+2fiTC8qBL7rRmkGmYtP2zbz/EK83zIk8uMBL+j66wLNNbQRcx+8?=
 =?us-ascii?Q?L7OEMCl9+Bm/p7JCxPitUJzEc7aZyZVEOUQRM5y7P28Jd3Q9u2ndthh+p3jE?=
 =?us-ascii?Q?Ty/7x/JanduC+7FReRAsvanDMIiTxmSteAyer9A9L+o2Gx4xJ4YdLVS0bXkq?=
 =?us-ascii?Q?4WRDYOE7jNYbrbTlcNr3lmcUHnyHapObqdRBIOb394UWfKgDvlVzmw+66mAe?=
 =?us-ascii?Q?TpqVtjXLlxAcdYv3UOT6fhDSpc3G4kBjtDmJMbxEC+qwe9SN7VcvVI6k7fDu?=
 =?us-ascii?Q?KSY5gti7w8GuJHOn+bh6sBEjC/ihnDXMmfeZnoGN8ilNqN4BfXFkOr32LNlX?=
 =?us-ascii?Q?N824mXtrejHtY6PPbSovJjoXHrdD0/GQ+I7trdO/ku7fdFSy6WSRz/VTQk44?=
 =?us-ascii?Q?SH33sC7R+JsOiUCy3kTpiXz28zpaFad3GpQMfUfqXdrUjrApYvahIAkmYK1g?=
 =?us-ascii?Q?baVvMBSyDsbLVfhAcGEz2wNnNt1rox2Yzm0rQlnWCoVMMhmjeGVjAAv9LQP7?=
 =?us-ascii?Q?mSoWeEyaU2zkdWZawfrvO28xmcikvNfog3vNUaLW/h5IZlKOWpYvT15+dOEz?=
 =?us-ascii?Q?77AcoCsD9DWHAKuVVuWswPc2WVPkFoQBZ9bCCUFIjDM+YbzUyoiJCBzIfEv7?=
 =?us-ascii?Q?UgiZuCh+yFWh1SooEVo1cYBEDgnh4WBeM/QbUvggTQOzQm5w3JQHNi6WJq46?=
 =?us-ascii?Q?UJJjJqQctQI6G304gxdjxE5fMVUCBm6fMHUiFd+xc5rXlDoMsPW7o04Tm5s3?=
 =?us-ascii?Q?pJngnmv/ytquOs4ldFGu8OGwFoo4EOZMUGNnv7rl76FG8SAHeO/5w066C65H?=
 =?us-ascii?Q?YyNzx2j6D6SZmuSfcJLG8o35pxqOHUPQFHtSMcRQx6qrZzfYbsmLZiSaQDnz?=
 =?us-ascii?Q?OceUV97nentwqzBE9Kalyx8m3ga8kFMdTdif/udbDwlu3xgvGTjFKtn2XngJ?=
 =?us-ascii?Q?YPNt1K1pIEqzT+ecLX/OIZn7olw6Y2iYRu5gAWwRR7lDYAS8/1LwKrAlk/41?=
 =?us-ascii?Q?rltJFqWQVDdEqp07UshMQ7gRnN+2WGKGVrzLzdsfY2VEy1ISUdJEEB2em9Ui?=
 =?us-ascii?Q?mV5xq+FZfiCI68RrUMQM5zzxU+wpY21w4CpeuYqy91LXH2ghq5WhDGbie9fD?=
 =?us-ascii?Q?RLa3wNxTUeTW73b1CLht82PY9ya/2OMF+TFrW9lr1F6f4kaqUiDcOE0U+ex+?=
 =?us-ascii?Q?YHpH2FKCO7R07oR6MbzSGtmFYpgMHVVuVGZeC7Vo32QdFF5LHbfS8VSrIAGU?=
 =?us-ascii?Q?HTUw4V8vrpb+P+yfQWIZqEJeSd3LeY4n9UFDo2/Lz9fBTHHb7fJmIGbXtNQf?=
 =?us-ascii?Q?C9t/1eoMH+g7DSw3atx/dzI1/LeS1B50MfzKEtlrTxvWEOS2sVQzle8y+GW2?=
 =?us-ascii?Q?Ir48otyykbc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ex9QCdQGdvNxWaLdAkpDF2H0smQtImazeDaQkt3fyBdebTFfQZnmK2xI4vXu?=
 =?us-ascii?Q?PSluxrFn+2f6us4ahENXMKRvvlLTpJyPY90YX940onbRQYOZ+nZprYuVxpJ7?=
 =?us-ascii?Q?LMrXFgu5Ye5qCq//fwI3X2w8nfoRY7ntvs4x7XbgfspGLB4OcFlZEd3mTeFg?=
 =?us-ascii?Q?ZiR5qizNj+7PArSnYwlyJq547SirdjrbhxP9JKXZJMFTLQq2Ue9hyCL9iWqf?=
 =?us-ascii?Q?KCNDgrM9Mo9gllHyXvNEFGUMAscNkGGs0Txb4XA3pOZfUh6RXb7gdxiEU2o/?=
 =?us-ascii?Q?QFOalcOuNNVcxnQ3sGZh+0UgFmlg0rsnjclWSs+1FcJhQirxUd8cH3cRX+bx?=
 =?us-ascii?Q?xjKXRXPVuzx4fMWHWAs9+3iw75vCAaZ/C5Omu38BagJYFPHOB4VaQYoXVgTw?=
 =?us-ascii?Q?iI3yJ6iYx51ZxdePditWUE/yhEEJOjANJbRbrqm4pv/iwyJwPj2xuLvPUfiS?=
 =?us-ascii?Q?UeX7xHK3bsx1WJYf0MAFwUlG/Ughy6L2Vhc8lAKU81lNIoGi0xafHSAupUDv?=
 =?us-ascii?Q?mOi1faJpE7JW1QBNgxjgM6sIZcSI7EFcl7eCvynvBYzj0dIprwvlYPYYuPED?=
 =?us-ascii?Q?2UEi6O3njio5CIO08d51By5qplg0dJngw+6/W7awrZQUp4b1x/XEbt9OnuRC?=
 =?us-ascii?Q?SrztFY6H5fCdhFLWHReDIvT4T4tAbkr2oNnuIzs0OVkRtA7jQn0bOltX2Vb8?=
 =?us-ascii?Q?3k6guk4xuL2kucwk4Vj8Og21NINURbOrr/beU7GsmfRIV3PDvoA2qAhBefUY?=
 =?us-ascii?Q?lZ2T52C/BwAIzQJvhPf2MUBZw7k32WymEa+qbRqtKyqTI7g3nvFyWB4Arlih?=
 =?us-ascii?Q?/prb6sYR9B4vj55+aC8qVNM56u4DbSMosa5HHI8iAdJig9LWWaU16EDKCAOC?=
 =?us-ascii?Q?oCCPhxomYD8nd2xz5vnNciDVay8ybYvAK+DBSVHL0r6bGpsvLjrJBZtcnYde?=
 =?us-ascii?Q?njrLdJOUUWs9Kn2rj83KBpcLTe0j5ZvzldfvoLzzTNZFtvjJuUP5rLFpxW7m?=
 =?us-ascii?Q?Q/pT1ZJqZOv/gO9pYeywc4ruulyeOnjGmxMo1gwX2pDOyhLfb4BzlQX2b/49?=
 =?us-ascii?Q?S6+sWdkFluWbMA+IkYsgCA4ucVkBPZmwgeOkzKZP++45RAb3oH9W2iMsvoob?=
 =?us-ascii?Q?9acddIGyPZZtN5NusINbrS+CdZkmXod3iT8A7cjA3MWLjdr13hqB5sme3GD/?=
 =?us-ascii?Q?kuUIwQ+QI2qnqOWfi7Uqqh8CpbkMGQ+dTsjWaafW4UGLIM6rqggeqqmE7Rt7?=
 =?us-ascii?Q?LX2S5s3yIdDhj7V7fYOGos5l6hodmOBxs7eqAwI9TBCqVGpmBOXL/dHUJakG?=
 =?us-ascii?Q?Kr+8QvrxzsbtrLMmoF8yTsdHk359qrIoiCvu2fHgCsJVp0r66ceCWoep90fq?=
 =?us-ascii?Q?SGTMYnv76Mh3N4wmEJNFRcGWMVoqlSAYb1oPOqggXZmIhM1akSO2IXccLmKz?=
 =?us-ascii?Q?P462gQKJ9NsiF5ZDSejdOqmj/yuatEblCoSJStEkPtZxOf4skEQ+zM8Hezmc?=
 =?us-ascii?Q?xKiDpwhHpSirVkFZXB/5IMCjqureZyj3Am7yv9vQ/3K0XyLsemiwiQb2aEjf?=
 =?us-ascii?Q?vRM6lOfvXy7WjNEbqGcUgrb2ZNvmmz79ntmY206/PzlUBko12xuz2Ag6H3/D?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	o6ozrqlxOCXkWvr3LvLahuQGollxzqdhVUVIe50uik9QVIZ/jghjQtZN8P2LUweoMwGRTDG3Z1hXT3e0JiIctKFfzrB1HdqR5vYTe2Yd579UjTMzkxgPE6O/cQFpMigDeJ0NHZ8QAZnxuU9FHP6nAlm2OmCNk8QjtI1nVVV3kdvZsUJB7Zp1kuTL9KDIxxDgMQdOEYYGzY6szW0upfCK1YmgDuUiYmvO1ym3e2q8NTegQ+0CRVl9e1grZ09lCLbMgsNTBE+HPFQb2ceB8VyLtEqE/HowTmq6vNyOsuc9MGI6XwheqmcXnab8Hf0UXOCgAYTnoFxy5+qAbUhUOoRv458GpgahP6pSei7lc9Z8n93olJEXZbYLq88W7uqFh+ypAf0/BK8DTICuAmrGIOBcM/kveT4oL1/qjjymKIc9e3xAMtmeluSfSmhWeFK8clOJY+qbLVMpRyL2b4hnR0nbe02p6cQjFnwuGhR4jUzwpQheebt0KYwZpGlz+wPYJ+aTehijlr6l4eqpa2Rw/wkZvByRnLqBUoBD24ipBkBaoK4p9tA4Xc5HlrWtIh7sgsWtIiPjmN3oqZpJqAKWLsN/Nn37bF402sftnkSHYLkjUnU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3414a83b-a206-4b7b-48f7-08dd84189eff
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:43.9157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2+Oz3jgNp8OzBQQSPIcKC+67IL/G1ahcN39wlJghdIMbEFQivNxsRYZKQcVWmmEr0u7KNigL9WQ8fTnnPs+zRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250118
X-Proofpoint-GUID: EPARE-KbidrNN3b0OsDu2EjLqaXypyMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXzrwUC7cR3qio UQ12PRgdYbbjHP3PbyAqwt2Og5kJ3ugm3XlfqN+T9W/1u98xAIejKwnX0p51JA9yMtEl5GxertA YOTPSGN8LW1mxoAZYdHKKiR97LX/OXEquRHpMk2jpT/CJxPBF8dcZ990uUoxqBJ68aScJ7Jq/yL
 +Nsj3NkGhoDAS2FeqZgxaEoK7BvsmGomE2wvnEq1bx3YjDIs2RvU2bBXGafTpqbaqa2Gv368Usi t33TldBciro4TcMOyVfTIJbjVKOxWlg9+AiIjlpBqbmtdYxoQXvX/zYhjr8vxgM069RzD3p4uwZ hvc1wJ1zGgdiRfk+V6pxuuRh+/J5KYiAhP3rUHTSjEY6SEAI5g/FAzKWHVPdUDTVFnMavLraMIU L5AhG34t
X-Proofpoint-ORIG-GUID: EPARE-KbidrNN3b0OsDu2EjLqaXypyMA

Refactor xfs_reflink_end_cow_extent() into separate parts which process
the CoW range and commit the transaction.

This refactoring will be used in future for when it is required to commit
a range of extents as a single transaction, similar to how it was done
pre-commit d6f215f359637.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/xfs_reflink.c | 72 ++++++++++++++++++++++++++------------------
 1 file changed, 42 insertions(+), 30 deletions(-)

diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index cc3b4df88110..bd711c5bb6bb 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -786,35 +786,19 @@ xfs_reflink_update_quota(
  * requirements as low as possible.
  */
 STATIC int
-xfs_reflink_end_cow_extent(
+xfs_reflink_end_cow_extent_locked(
+	struct xfs_trans	*tp,
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		*offset_fsb,
 	xfs_fileoff_t		end_fsb)
 {
 	struct xfs_iext_cursor	icur;
 	struct xfs_bmbt_irec	got, del, data;
-	struct xfs_mount	*mp = ip->i_mount;
-	struct xfs_trans	*tp;
 	struct xfs_ifork	*ifp = xfs_ifork_ptr(ip, XFS_COW_FORK);
-	unsigned int		resblks;
 	int			nmaps;
 	bool			isrt = XFS_IS_REALTIME_INODE(ip);
 	int			error;
 
-	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
-	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
-			XFS_TRANS_RESERVE, &tp);
-	if (error)
-		return error;
-
-	/*
-	 * Lock the inode.  We have to ijoin without automatic unlock because
-	 * the lead transaction is the refcountbt record deletion; the data
-	 * fork update follows as a deferred log item.
-	 */
-	xfs_ilock(ip, XFS_ILOCK_EXCL);
-	xfs_trans_ijoin(tp, ip, 0);
-
 	/*
 	 * In case of racing, overlapping AIO writes no COW extents might be
 	 * left by the time I/O completes for the loser of the race.  In that
@@ -823,7 +807,7 @@ xfs_reflink_end_cow_extent(
 	if (!xfs_iext_lookup_extent(ip, ifp, *offset_fsb, &icur, &got) ||
 	    got.br_startoff >= end_fsb) {
 		*offset_fsb = end_fsb;
-		goto out_cancel;
+		return 0;
 	}
 
 	/*
@@ -837,7 +821,7 @@ xfs_reflink_end_cow_extent(
 		if (!xfs_iext_next_extent(ifp, &icur, &got) ||
 		    got.br_startoff >= end_fsb) {
 			*offset_fsb = end_fsb;
-			goto out_cancel;
+			return 0;
 		}
 	}
 	del = got;
@@ -846,14 +830,14 @@ xfs_reflink_end_cow_extent(
 	error = xfs_iext_count_extend(tp, ip, XFS_DATA_FORK,
 			XFS_IEXT_REFLINK_END_COW_CNT);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* Grab the corresponding mapping in the data fork. */
 	nmaps = 1;
 	error = xfs_bmapi_read(ip, del.br_startoff, del.br_blockcount, &data,
 			&nmaps, 0);
 	if (error)
-		goto out_cancel;
+		return error;
 
 	/* We can only remap the smaller of the two extent sizes. */
 	data.br_blockcount = min(data.br_blockcount, del.br_blockcount);
@@ -882,7 +866,7 @@ xfs_reflink_end_cow_extent(
 		error = xfs_bunmapi(NULL, ip, data.br_startoff,
 				data.br_blockcount, 0, 1, &done);
 		if (error)
-			goto out_cancel;
+			return error;
 		ASSERT(done);
 	}
 
@@ -899,17 +883,45 @@ xfs_reflink_end_cow_extent(
 	/* Remove the mapping from the CoW fork. */
 	xfs_bmap_del_extent_cow(ip, &icur, &got, &del);
 
-	error = xfs_trans_commit(tp);
-	xfs_iunlock(ip, XFS_ILOCK_EXCL);
-	if (error)
-		return error;
-
 	/* Update the caller about how much progress we made. */
 	*offset_fsb = del.br_startoff + del.br_blockcount;
 	return 0;
+}
 
-out_cancel:
-	xfs_trans_cancel(tp);
+/*
+ * Remap part of the CoW fork into the data fork.
+ *
+ * We aim to remap the range starting at @offset_fsb and ending at @end_fsb
+ * into the data fork; this function will remap what it can (at the end of the
+ * range) and update @end_fsb appropriately.  Each remap gets its own
+ * transaction because we can end up merging and splitting bmbt blocks for
+ * every remap operation and we'd like to keep the block reservation
+ * requirements as low as possible.
+ */
+STATIC int
+xfs_reflink_end_cow_extent(
+	struct xfs_inode	*ip,
+	xfs_fileoff_t		*offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	struct xfs_mount	*mp = ip->i_mount;
+	struct xfs_trans	*tp;
+	unsigned int		resblks;
+	int			error;
+
+	resblks = XFS_EXTENTADD_SPACE_RES(mp, XFS_DATA_FORK);
+	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
+			XFS_TRANS_RESERVE, &tp);
+	if (error)
+		return error;
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+	xfs_trans_ijoin(tp, ip, 0);
+
+	error = xfs_reflink_end_cow_extent_locked(tp, ip, offset_fsb, end_fsb);
+	if (error)
+		xfs_trans_cancel(tp);
+	else
+		error = xfs_trans_commit(tp);
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 	return error;
 }
-- 
2.31.1


