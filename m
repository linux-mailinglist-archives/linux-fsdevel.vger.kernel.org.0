Return-Path: <linux-fsdevel+bounces-54629-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01497B01ACD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449ED5A7B7A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B628DEEC;
	Fri, 11 Jul 2025 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="prLZEr9L";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WLzmri/z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125D2C3273;
	Fri, 11 Jul 2025 11:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234009; cv=fail; b=qqDLWdIHrdcolI4LZkf9zPisjo91zF5HD0e5SApj1knAxqlODS+2P+oBewv1ituT15+JBQAtQm7hTfvERweDvQlHhOVun2MpQ1aviwND9Ga1HBz3H5fFalBsB+TmqOG2waSu8AE5vf9tCUsyR8BS0cFapf5PrMU+opkcJnDptVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234009; c=relaxed/simple;
	bh=rubp4EBrQsLX31k+bTmrsLo8VzGijXlxPXgX2LPCJpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e2GEO+4vQfLS9UpngEBtHInQb4chWcewDSKw3l4JPOthOWozEBdNg5TGF/09SeZ9znslPPGcgDyZ6wWTQT4l/IfXFhAKTXYjF4gaoTS1Abioaj4wa0b/pydJEzQ00AUQ/eUmDXoHlfe1SalydWbt2ygMvnRBXGSDMhAtSIZrJEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=prLZEr9L; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WLzmri/z; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBbCVm018542;
	Fri, 11 Jul 2025 11:38:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4kr+QnoNSM9F5XY1TkuPv/psT11/S1/R0O/NyaF1dYg=; b=
	prLZEr9Lp/kCiw0mElao7deRwCFq/O9b/atTuebCWTlm24mXFY/u64RcbwJqthnP
	o6fg19MQidB6Xx9g5mTBUvnzWPTV5In1C0dEJxZHk/YWNBaWW5/dTbeXuIQ11pWu
	5z2UwSgcekm9Cn2Oj0plc2ZDv3sn6nN+5eIXufBRZi+TIrUGo+XBB/E3KPhFetnU
	cXn9Hvhb/+xtBaHf2wJdt96uF6QIEz40moh0/5G2GYKIcjlEW41YHioFa/IzWboz
	q3zNsoZYQz5eYObC6H/Rh4yL5mayA5QzxhHMqh4l4ucVeQcHQnHQ2+KCf7WTAhY2
	ukxrh4INZH7BO/l+lsFcBA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1w2g03b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9RBYZ014057;
	Fri, 11 Jul 2025 11:38:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdfupy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm9QJ94mLdfSJZlc2aOsgn0QvGNa/PtinvHHqhRJ7MMY+YbKxUF57PSbkppMNOO2bnLDwj1LfAfNjjJLX2zjZM3WEw0MmtFRKPuSx/UEKp1153MfhqTEk8X+NCLDry9oWWQPgiZOlhaFkJU14iboMk4cb/oMxRIxJV97yHNo4h4DLdiBeOqg1prPzP7x6j9KBt2pNKQHxSd9aQO8lzAmn2VX9DjyBTYTnZt6AcGe5lI/ItMhUMTQzE3dWTZCFrHaBhAd7tAy/K4szZ3Tn3Lu3SbIad7tD+TYWMwBUBUwHyXFU9iDQE8qqIaYjirAPyUMgvKRx0z0xzPWDvGkP6xB2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kr+QnoNSM9F5XY1TkuPv/psT11/S1/R0O/NyaF1dYg=;
 b=xYvmoWHCzS3jSljnAacpsq5XKQuIvN62gO6XFaypHrukwy+ckoTgenfwVaPW+YUEo1iQ6FOxOmQcUP1Dwpg8S2IFfSMQ/LeViIDC7IqBAfvwFWohdrnkvzEF4eSZrqaaqbW3blxffZosak49i0yWpHnSpGlUVTY8cIvovup8heQgCduIIl15JFaWzYSkywu684ETXwDrcSCe6b46S9C1IB8Xicy5v844ZaWq0yO6ZueePX+uD0ZGX4YtbedGfs6bqtNTtgnV1RYG5APWyIPXIpc73CFAkouNwXLuzQop5OEKCxFg6LrJReJuxx4ENkBBTxCK+jqszD7UAJHFj7Do+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kr+QnoNSM9F5XY1TkuPv/psT11/S1/R0O/NyaF1dYg=;
 b=WLzmri/zpI7mI73rNOlkTtEwuhSrtww4xacLwn/20FCCr8TNZTtRu2HiMKe0g3U1B9tFfxLR/YWujrovPHK9qkGkJKmMcN2POl8iirV8h9VK/4wQxMHMbFnuqAq1dfoHeNTvwmnNEAZ2/Y7QRTeoeWX+eFcVqB8mtSHvtIQoGG8=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA1PR10MB7285.namprd10.prod.outlook.com (2603:10b6:208:3fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:40 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:40 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 05/10] mm/mremap: use an explicit uffd failure path for mremap
Date: Fri, 11 Jul 2025 12:38:19 +0100
Message-ID: <255f9604d3973f85b7d7fbcca396cbb6841a676a.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::11) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA1PR10MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 395fd152-840a-4645-1f85-08ddc06f7bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CuOlQyhQZGKI+Z28S84mxy253sEghBOdno28T5HP9tC67wIab4zVMKcWmJlW?=
 =?us-ascii?Q?ELlOeEbD0NryJKdBeTIFkXBb3c1EC548LVfhy6x64WHuoCMxQNRJ2jn2HF/0?=
 =?us-ascii?Q?jQhdf7sKpMW16yWE/kmREK+pGXPwrr9eaEPuhgeg5Q/Mw7pJUHyGsuwIpwEb?=
 =?us-ascii?Q?0mdclb34KXZBAnsMqMcow6BOVEFD3OchTHrLuxf28kzbhOrQ+2CAaF4MbWXY?=
 =?us-ascii?Q?I/kgpOhqCSQKc+AKB5bWYjHSTYnrCc6Fp4ISFy8zTHMhTPpgap2hGhtVW+j5?=
 =?us-ascii?Q?hjsjftNbJDAg/6QUhU1z/5PvDpYf2lu8ihxrWex1z/qZx47C4+cb1lnNAAFF?=
 =?us-ascii?Q?ebEbt2wimBZmdhbp0ef16yToXCnp0gLqRf5ZuLT5MMKtQVCQ4zsEI/i1DUkB?=
 =?us-ascii?Q?atcA9gMoRL8aUi41c/W4CHQnZwmwk9K4WfUOTygGf29gPK29NgEbMHDntqlJ?=
 =?us-ascii?Q?VEOxH9ODNhNX4ZxhVy/BkXwZ2FeJzz8H//nNQiOkVMPoj0CVrgNR+7BoDYUq?=
 =?us-ascii?Q?xZY4821TUKmBUawdJndI9XUdfLIORuVDl2VUsg6R8QfH7t1TnlvgN5aMIjVZ?=
 =?us-ascii?Q?QvDIcFuoeHy5JwrfkcSNWM/nFsEtJ6/75tn+CPpMkjvCWb0OwnFrJTp8TRpl?=
 =?us-ascii?Q?lbmuSKqo7YYGd7wV8/ccia9pIhLK+9CW2iDE2juEXIDj4ulyauW9PA6heKqM?=
 =?us-ascii?Q?PDvFCwdgtjnSL73mAYJKqVExOaQUGxFXirgwDRg14TFehWsQvKdELIKkO6t9?=
 =?us-ascii?Q?+60jsDzOvAZtNr9suOX5C3Gnu+ndOQlA8g5xn3bnOxxpSR0zfFObD8hsT8pO?=
 =?us-ascii?Q?mdpofj/Bg+LKA8WrHCa0OsnpOuRtOlerlaMo/ZshmwCXbpX2i4lmtwaKG8i5?=
 =?us-ascii?Q?NKj48trg/G9hYB6Ij/S/hOonhtFXGg+1n3T0WAnRhia6S/cU6ZAY61iSeHPn?=
 =?us-ascii?Q?bZhPfAJteR+ENCKPPf89QNwRbp7DZpwX31w+gcnCxrZ0g6RrVGMvas1u6nrE?=
 =?us-ascii?Q?OPP3RMsJ4X5/xaOMczwZkWIoGgi6C4ZT25hii2jRYfi7GdcfKBpP7yyCzeqz?=
 =?us-ascii?Q?Re6wOCHd2XjdIXDJApXsoyU62LgZOVCYZxBz1lFlqVIc2EIBK0xxecZe3f6Z?=
 =?us-ascii?Q?XXn4YBSSX12MK287SlmetcdekdmprQT/w60959v/MXP682PbBrp/44zv6TK/?=
 =?us-ascii?Q?GOdNtxtFXdch8wrXs9WlTkSbzVmScHjQ7NIyCSjpcU7ZYjblOd6YuwUIyvSE?=
 =?us-ascii?Q?V14M+O0A+taLxUWckApDjbRnDnzj853Q8Y0fUsSbjTJ6B6WuGAUvADmDwYQ8?=
 =?us-ascii?Q?gOrN2PHikjJs21Q//2U105oBwjeT9qner+CrEYuMb967LkiBIJdsf1Z7Uwue?=
 =?us-ascii?Q?QeL9sbpQ2piyW7odq6/i4STjaWqKy2NKR+ZY/YcVMM+kEcM1kwKzI3hGXeKG?=
 =?us-ascii?Q?NjHe8GAJCaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o2qAlBvDIfXJeFyHTZ9KO8p/uoaHVjESrT0c92M/FtLH5ybDKWw+qNf65rtM?=
 =?us-ascii?Q?jvSmiacSA276onbMsRBD6BlFRRtgDK/cLSdfc8yHsh255jKt47fLiD65ezn6?=
 =?us-ascii?Q?r8j186ZDMyXr4JeEEHCcGFo4u0XEysdUpjZuATyIkXHOPGOXnbv6UShAA+ef?=
 =?us-ascii?Q?P4U6+7KIKykmZaHrOt2Dma/SPQ53ryKe8FmhlALGMkUP64zrmy9CCgTpYqc7?=
 =?us-ascii?Q?TwhE6SHicVUQPiSI3dCQwJmpwM2ptHFg3tiTmRE+dPPIyDxtney1o+qeNCH5?=
 =?us-ascii?Q?MKM0/Xf223V+P2EkoBk9qPfE5/IgqALDwxAobBDUbaPOh54yYISAvvTuhhRq?=
 =?us-ascii?Q?OpRFman5AYdQhd2rqvwmnPUWrjUex/MeQ9uFWrIJgCCk9zQR8k/WrCu+tv2m?=
 =?us-ascii?Q?bCBlK8UC0AwIbjgQF7sCmPbYCcjn5KvifAJzamnqw6iUj0H8riBuDtJaszTI?=
 =?us-ascii?Q?Kv3DTVDOsY3EG/zajLuP0e5Oo+vjU/DioHlO7CumY2WQA9Yw/WuBTSyJ6gl5?=
 =?us-ascii?Q?fDgaxSyoB6eAY81YwyW/UBvEj0DhdjAK7ySqVyhldZ6OpbSwbchdvVOkMA3i?=
 =?us-ascii?Q?vfz0F6eBQgJxwEtsE4oEKq0eueluJ7mIhSf2ivoKX2HejjAnQR5CMEQ0wn0i?=
 =?us-ascii?Q?/B6eY+y8Lfl0KR0l8E6X1l2rQ9mbhgEu4+ilLO6+nVJFvAfjkDokMDcCpH88?=
 =?us-ascii?Q?QLCdDkcRyJKteg0RZLfDRhFd0HtIrf/cSq7yfxkTLjxn4N/95nYB2dxVOpD3?=
 =?us-ascii?Q?z0U86oaFqDO+ZyAoqaxqAj3dXupzpY2xoDK85W1gBPLgr/4ZeMLoe666SsP+?=
 =?us-ascii?Q?rPOPbD/HxWMvXOLA6Kq9B/wT8sXsq8mWyMMUsLYoX9saAl8PUL6e/lDQKt/8?=
 =?us-ascii?Q?JHRFP0ALd+uaFtIkk+yrDtdnjdpKZKKlkKlBem/XMMiDQs3mCgSZvniQl/CO?=
 =?us-ascii?Q?4bAjjkdM2Vz1YKzdxdedCDX8D9lh3GBqxBgu5wte2Jif+zL1kPPwL+/m0eG4?=
 =?us-ascii?Q?wFIF7OnmdWBX6V85dFDD/Qkhnb/DAwLo6dc6rT7HBEkjjuqmrn+Ce4qa/0CV?=
 =?us-ascii?Q?oAj6mMEARUdWZ304L8WhbcNCbnaKdYEv1I+m9uzqo39T2PwB9NqwKsZvtu1a?=
 =?us-ascii?Q?8QDWCMzvJORs5NEsKEME/8kcLuf7JJxwP6TAtqpdqrt3Mr1MsZ+eauLG3V4+?=
 =?us-ascii?Q?Gk+NdfJwAJla8pdbau0QA1hJf5Tyqa3i12dsbHdj1CmMUHrHXtmT6XzTr0Aw?=
 =?us-ascii?Q?abggtvtsOllbDzrjs/OKLXbfao6K7RpPflggNiV1nm5u0EYi6vwfjQ9JVe+R?=
 =?us-ascii?Q?34q6WPulRt3YJsFLVrJXUKKHCvVRzHB8WQreBB1Ypsze+bIUmgmTibzr1fLx?=
 =?us-ascii?Q?Ui7MABIUCBZTaclbhORJ5LYiKScWoz4gDoBgST5q61YtsDB976Y7V04pnC3F?=
 =?us-ascii?Q?cJ2boxd56mFm707j+qdqvsVSlvwjf4uc2uH+/ImYZSkPOTxezT74Y+FdeUOK?=
 =?us-ascii?Q?0U0dVUMoXe07H4ZzH7gEmGOc/6BHFlg0dXRz9XREOuJ0uWm1XpkldRBFg/SX?=
 =?us-ascii?Q?2dbqaGnhjPkTkR0ypbX1LT0phdMAyqdu5f/aBCPXQLxXZjI1pUodGtzm0H3P?=
 =?us-ascii?Q?fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rPBSJZZpWpTOt+lz4m8WZY0Z+XtsZcqwM6yr0mmmmynW0bqKiPiOhn+z3jrCagZxUpzbUGKxoL4D22GcqK42dQRZbf6UF1eUxhBKy2Za0dzj8X1LgMu9+5EFYOcbCkMxLWHabZJ6OK2KGn4Ik1BGk9pbxLmwYdXEW1YT1r9KwuYDbBVIVyyR36QrplHPSJQg/wtazGPOI32xihmxtlO6speTN72j7WR5rWXr6fPnWctGLOjGxtaeSUeWSmEB5cQk34O+vE/EqeVwVSGvhpJbjTUj+KnO2cCsq8HwiuFgOH1zbiFj4J7AfcUU2PETs+rbGhbut89r7B3AyIleMxCMUGRhNp8RBgvIJFcls9CqHU894+y4HrhR7TxnWoXWm/fXE1UtNOHK6rAATVeFU41+c15RcW8/AOVKDCvk1N5uGxM8FnGgBArvVDPrPpV1U9vYnMEaEixSHMUFQQ1jOr3hGQ7bBiBk91oCofSiZzPVmiw5/uKLRjoCWJT4xE5xMGoOem6EWH17xrkqauFnXcosZ4hhEPrS44DM38Gg2CR3q7nZe3/GjCEvNObMij0j3AXA8/pT0//u+nF79OrelcFFHl6kMcdUab3z3u9/7PeuWNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 395fd152-840a-4645-1f85-08ddc06f7bd3
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:40.8297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezHcXS4BePQecTfNS69DcFqVgUvkrbcTVa0J/TMxTJJWTpQY8enqvptVBMKas57tDnPF1mXEb9tvs03IhjGuxRU+rOu4vJ7VWxvIaM0ObGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7285
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507110082
X-Authority-Analysis: v=2.4 cv=X95SKHTe c=1 sm=1 tr=0 ts=6870f7cc b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=D44BCz6ssmwAkLLrWzgA:9 cc=ntf awl=host:12062
X-Proofpoint-GUID: TA1HNTrcV7OV4QAVn8Gz1ik-4Jnluxd-
X-Proofpoint-ORIG-GUID: TA1HNTrcV7OV4QAVn8Gz1ik-4Jnluxd-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX1k72Nyez3ywW FVd1jsOF8+Pwir23qjESk4Uz+FFxd1MtlnZUjmAwMSUS0keDoFihSWegGUaRJdrQ0mA33eoESi/ kQNT5JUOMCCD3hjnnOQ2fPO/+D29jlZgKW+jtsEUdCpSWDnRPdpnpyby+mRWQgQpg4XXxNn003o
 sM3NwB0neYe+ehc4PrBNWK1YULkA+vg01WqRKqySG4EDDjxSk4TwpVF6eUGS7rANvuiuSz6Xqbb Ucvwp4IWkCvXGbd8lnNqg7iZ8SYCPY/rpU+EWijPc7R7slQkjqHtPt4eEfpTUslU63OX7eyb40E N2A1jssNUJTNwbU9F/ynsyWIyfcJDgZvClQ53ttxI5knqjwL3hFoLMD5hUWjmBgYWDYi6vfUw7K
 1EEkiTmggybL88ZsqufvvPmK1dkS5zBfEeI+oAgNW0sbeBTH33im78VzBDKTYKYRpO/g2GhG

Right now it appears that the code is relying upon the returned destination
address having bits outside PAGE_MASK to indicate whether an error value is
specified, and decrementing the increased refcount on the uffd ctx if so.

This is not a safe means of determining an error value, so instead, be
specific. It makes far more sense to do so in a dedicated error path, so
add mremap_userfaultfd_fail() for this purpose and use this when an error
arises.

A vm_userfaultfd_ctx is not established until we are at the point where
mremap_userfaultfd_prep() is invoked in copy_vma_and_data(), so this is a
no-op until this happens.

That is - uffd remap notification only occurs if the VMA is actually moved
- at which point a UFFD_EVENT_REMAP event is raised.

No errors can occur after this point currently, though it's certainly not
guaranteed this will always remain the case, and we mustn't rely on this.

However, the reason for needing to handle this case is that, when an error
arises on a VMA move at the point of adjusting page tables, we revert this
operation, and propagate the error.

At this point, it is not correct to raise a uffd remap event, and we must
handle it.

This refactoring makes it abundantly clear what we are doing.

We assume vrm->new_addr is always valid, which a prior change made the case
even for mremap() invocations which don't move the VMA, however given no
uffd context would be set up in this case it's immaterial to this change
anyway.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/userfaultfd.c              | 15 ++++++++++-----
 include/linux/userfaultfd_k.h |  5 +++++
 mm/mremap.c                   | 16 ++++++++++++----
 3 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 2a644aa1a510..54c6cc7fe9c6 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -750,11 +750,6 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	if (!ctx)
 		return;
 
-	if (to & ~PAGE_MASK) {
-		userfaultfd_ctx_put(ctx);
-		return;
-	}
-
 	msg_init(&ewq.msg);
 
 	ewq.msg.event = UFFD_EVENT_REMAP;
@@ -765,6 +760,16 @@ void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *vm_ctx,
 	userfaultfd_event_wait_completion(ctx, &ewq);
 }
 
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *vm_ctx)
+{
+	struct userfaultfd_ctx *ctx = vm_ctx->ctx;
+
+	if (!ctx)
+		return;
+
+	userfaultfd_ctx_put(ctx);
+}
+
 bool userfaultfd_remove(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index df85330bcfa6..c0e716aec26a 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -259,6 +259,7 @@ extern void mremap_userfaultfd_prep(struct vm_area_struct *,
 extern void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *,
 					unsigned long from, unsigned long to,
 					unsigned long len);
+void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *);
 
 extern bool userfaultfd_remove(struct vm_area_struct *vma,
 			       unsigned long start,
@@ -371,6 +372,10 @@ static inline void mremap_userfaultfd_complete(struct vm_userfaultfd_ctx *ctx,
 {
 }
 
+static inline void mremap_userfaultfd_fail(struct vm_userfaultfd_ctx *ctx)
+{
+}
+
 static inline bool userfaultfd_remove(struct vm_area_struct *vma,
 				      unsigned long start,
 				      unsigned long end)
diff --git a/mm/mremap.c b/mm/mremap.c
index 87cab223f2bb..b2ee95182b36 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1731,12 +1731,17 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
-static void notify_uffd(struct vma_remap_struct *vrm, unsigned long to)
+static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
 {
 	struct mm_struct *mm = current->mm;
 
+	/* Regardless of success/failure, we always notify of any unmaps. */
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, to, vrm->old_len);
+	if (failed)
+		mremap_userfaultfd_fail(vrm->uf);
+	else
+		mremap_userfaultfd_complete(vrm->uf, vrm->addr,
+			vrm->new_addr, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 }
 
@@ -1744,6 +1749,7 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long res;
+	bool failed;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1765,13 +1771,15 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
+	failed = IS_ERR_VALUE(res);
+
 	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
 
-	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+	if (!failed && vrm->mlocked && vrm->new_len > vrm->old_len)
 		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
-	notify_uffd(vrm, res);
+	notify_uffd(vrm, failed);
 	return res;
 }
 
-- 
2.50.0


