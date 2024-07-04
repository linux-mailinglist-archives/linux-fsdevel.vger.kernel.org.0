Return-Path: <linux-fsdevel+bounces-23160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E0927DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 21:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CAB1C234C8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jul 2024 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC5B13C9B8;
	Thu,  4 Jul 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F45mFxL4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dx3V4ZWg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36213C823;
	Thu,  4 Jul 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720121316; cv=fail; b=kxmNclQJuBfIZ+goPjLDsI+X9VnwK03RZopdO0cgBOfUOHhA8Z3MefFhCzuOnrbkS2N6k5hKQHR3MmyEZexvpbXB0MkTPIxVBtzp4fsDbPA/SmZO76zM5SgAc1HlCZv+GLcWlM+o9EKI4yA7wGluyoFHWfMxzFRR6UHn/AV7Zrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720121316; c=relaxed/simple;
	bh=8CFL8oC93zbiO572tyAA4tIkRAd3O7SommS+o9FnQPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ckbyUOu2D+Mi8l3Mj8Q1H+X1xBbF413JLDcPLYbsaAwezXSrvNDScoc3LH/e0oQ7tqDVUiWUkcgQ+sKfP4JAdiy2Q6gRUwoGCDXkNA7YZPR2kyjXOJlwU5gHmy1C/T+OY2CrDzL5EbZVsJpABYSMJapdhIocRyQXhkIN/VO6fM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F45mFxL4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dx3V4ZWg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464Db5Q0016625;
	Thu, 4 Jul 2024 19:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=7yUoHz+y4bBA4WnYst+c6VR5ABPk6RgWVBzoDEOoRHM=; b=
	F45mFxL45bbD53C7JGPnbYZyhqh4eHfw44cITTrhhxIaFiW+vmSUGL2JsM0aMWHu
	LPOgJFYVaDEYby5P8UNnYYJJ00P77V5BnuprJc3kusFUfaX1Mozd2f3cAez3+XsW
	T7yoi63b1//unOznrLMvd4Gu7y9ZiZtGC7RCGfNe2PoDyC//XNcQe/fNVlAKKUk0
	eb4nByi37XicOAotqQL+rs/YU4Fx2Ew7pFJV2fxO4QNqENI2KTeYuk9z4yeKjjFq
	8qa2dsfhI6DK+8AI3kxxQmuyHaYCObjbDxO2kf5zWOSKldbzvIiCIDsizaLOjice
	tw2YTzxzDIdYc9rZFt4lyA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0ts4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464JM40S021502;
	Thu, 4 Jul 2024 19:28:20 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qgrd45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 19:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6mXlmmqFOLNBpc6zKcbHkEO5wIqMk0U1lDnox/EY9/H4qE3o5d3AdZaGROQEHzaN0jjfsVKfZE+NCCPs+qJyOeOa8gRYMRp9eADgRn8fJam9/YiC3almFvJQyuuyoL48CTXShhKC4R3htKw+DOfF/SY9l00QXWm458th3Mf/rZ5aBXmJcG0Ho9/BZgs4EesRdUBsTnvv+tddX8Y7CjTMoFnlWl/OMHDVJ4uskJfbrHaSJMwsuJakbRfjFbR4ogWCxHqTa43WDAFRocABE1SD6SwzeQHG6wcImSn2k++Q1UF/yc5DmpxSDfs+HkqgFMU27akwmH3g82b7L6XwQacIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yUoHz+y4bBA4WnYst+c6VR5ABPk6RgWVBzoDEOoRHM=;
 b=BznmoJAUjpCAT6RqVDQf4ldip99XImr05qkLY82xGB/2YX+ttrghpTgTJ5X8/RY2AmmOaBP1AVf7fkEYIsN0EpQaSlsQVUmKhklaG7zROWq3E7b59QykjS8+k+6P1hAW5IToJyWhBD2gX+8SCeOARqG5YILFaCZYhjkhkynHYXJLjC3lB2o8wm6HwR8o5ItI9HrGpzmv03hN+JHtzgtaMGtnO8oNHK060RWwf9Krjh78b9fda6tLf3OKzKyI/f2T+jLnLhATTzdNodTlEXonxzU0DS6E8RsnarFOeNrVtgce2O63Y1o+YTfyHWu8kMQrg+EalSVLdSfLHMFzuZdxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yUoHz+y4bBA4WnYst+c6VR5ABPk6RgWVBzoDEOoRHM=;
 b=dx3V4ZWg9E5S+Hn9aiCIIQacXcWInrE49j719lRam3lSnuPl9Pm2FIrIFacnXkuQmImk17g/LGAQcsGplaeSKkD24ZlxnPfClU5Cy+9eiGewTAkdw6DHQ+/FvV9+aMTXySA2qyUIiJim1P7dOMNCW6//20k1gqE7YYGeS9Ejwmc=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB7228.namprd10.prod.outlook.com (2603:10b6:8:e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Thu, 4 Jul
 2024 19:28:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Thu, 4 Jul 2024
 19:28:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: [PATCH v2 2/7] mm: move vma_modify() and helpers to internal header
Date: Thu,  4 Jul 2024 20:27:57 +0100
Message-ID: <d247ba767e16973c27e84179a0a52f2597d72254.1720121068.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0008.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::16) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a90efb-ed20-4075-5e15-08dc9c5f74ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?54yqzmlW6UU8T3RqkyItjWB1RO5K8WGtRc11C/L94q035J9oRara9HzpD7Zh?=
 =?us-ascii?Q?GBhy5v6LzgD6IpyPfQEdr9aImtojSSTi1897IHOQU82JyExQfmVD3s6oSBjN?=
 =?us-ascii?Q?ya5aK0zQP5JwzxXkstTQIA4cL7Py7Q9strmL8B6f+KR88sLWPsVEN4QP6+6p?=
 =?us-ascii?Q?7wtF311CG1YzvhLSoNlntRYW4O5yA7sDoyo6Zvz71zH3CkBGJlROV+dmIUQH?=
 =?us-ascii?Q?Wm3bbksEJ/rnbhVF+6597R+QPrpjK1YauozWCrnJBk+vDTbRR/al9+GviR1K?=
 =?us-ascii?Q?/PKldPjFZAXS54pC+Dg0L+FWy88n7cSEWATTYqDsRDQbYca7EXMD/o9inno0?=
 =?us-ascii?Q?xDbzlRFs6VibxR2D0PwkNwAoqBAYptPw+9xUSj0cgfCD+xEFQ52xf3yr35cc?=
 =?us-ascii?Q?9AOw1yE08xPeszUoFZCxxU81JlJBVv0sVsiXFclZ92uJwVliMPvyDekLHxow?=
 =?us-ascii?Q?D4lIrsfo6u5U8LXUIVR2XV+lU8sI/Yd6l+bGU0qTeCI59aQtaTpbFk5I6krV?=
 =?us-ascii?Q?unft3jfK3ohG0DKWN++VImpNNGVwFOG6OYJucKUoCDsmMrfJWvevrT+a1iaL?=
 =?us-ascii?Q?XsKJeWsZ2khq5iaK0vbuTNfdnONKu892FSxwVw11vxynW92Inj5rQSSwcqQb?=
 =?us-ascii?Q?laUFvXyOE8Fk8fsWJOODHNEflSbG35itTAydh8D2p7l/TpjhRiA+lcFIP+Ne?=
 =?us-ascii?Q?3BLUtUpGNBO6wcV8WJgjfp52OzHuKPsrR/qTu8qGFNZctnI0BYldTDFGA2vz?=
 =?us-ascii?Q?IRoQfc3txMMFVtOI3A3jbjIp5MX6PeHPsRPThv3z7JAIZ75vUJzA7m7B839P?=
 =?us-ascii?Q?GUiyr41FHI6otTVHouQee8jqGNrcVvDwrnJwM7MurP0W0nIFRloQ3fSDSuT1?=
 =?us-ascii?Q?U17D00Ovbcd7vezqLuF5GmGOu/Uf81ZG4f6wRJgsYgAqODFiflRIF7zIbJqx?=
 =?us-ascii?Q?lz38nJ4NBmD09GDzaJXpe6qSZg1QdzL8GEs2RLQONaZJv1RiW/oUwhmqoHfs?=
 =?us-ascii?Q?iMBU0s81G7P+B3b2MzEmbRvj7LlNco5cCZQeV6L+ksTC9NY3ywzK0/bC4+r5?=
 =?us-ascii?Q?TJDTRREPjwGF7Y3m8CaBvAb4RSCF1AkSV4MWD4C7sJowozFT3c7CuAP+Dudf?=
 =?us-ascii?Q?XLfnFyT2KH/n9xMLEnW8sHRODiPUWMMfkk+RbxWggv/NMxls6AkkHzn7kOI9?=
 =?us-ascii?Q?m4t0JgoIKH4wJ5JmpE4BHJAgQzEbS8yzzMvWMigrQTAgajVyZN4lPSg7WpBs?=
 =?us-ascii?Q?T71Fvlp9Vy4C8hogbxt9WeB9zCVz2BsiIcTpJa6oRHup3N6gtbx2H2h7j7EK?=
 =?us-ascii?Q?P1WbY30Gg3suSD4bOCmIlt4rccJ7djNTdX1dvZyreHkV2g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?2dhTn7cYXPhCrFL3q/eWd1WlDzXExCDN2LOjGVbAuUtW0wW/eBZKECBC0x7L?=
 =?us-ascii?Q?9GmyZC3P3XYzcqpjvwuwnfn0dXNy2D5cHFt85jEoGq9gB9anwtonf3Zus6/d?=
 =?us-ascii?Q?a6ACsoW3fg35t5FTMYfJt3IloSC9hTLDGvN1rYwtOdEe6Q7Rlq79aXfbKTGf?=
 =?us-ascii?Q?PKXlNHH9hFdIHDBvHUe/AVpE2WaHFzCMDoRg9Fsp8Ww9lL9KAG5QFnwxmGNL?=
 =?us-ascii?Q?+TnKtUIU5frvHwYZcM8TwTRNVPk8ahIqRYOwBXISL3eM7IfELo/uvzUTB3cr?=
 =?us-ascii?Q?WwyKPkHzNcLghpJEEgl0JVif9mxB2iGy6dtDz9Rbu6mIYjYGYhRo/yHVUz11?=
 =?us-ascii?Q?6uLj7X7iZRJ3ugQUpI+qE9uikUdiUAhQz53IzTMpYpXJXJpv0ujy225Jqe44?=
 =?us-ascii?Q?lq1E2JbOGtiK5Ax7yw3t5lY90riqvVrXILzS1/ZiHbhmkXqMTwbabAJTtjcN?=
 =?us-ascii?Q?hsgUoPGaC0mqWg4X+uv2aXu6pWvXjlJGsGSZizJhvtXgkxz9XOLA3/s3nqZU?=
 =?us-ascii?Q?xfK/67uHhiZWlZ0/mnJkSTxuCHWkWRfrs6ktNIpaOHLRMQ4aasg9/o6PeryR?=
 =?us-ascii?Q?MroG9cZFWMs6hSmV4CZ26bIN5PBmq2m7y3NM3NjvrQ4N8sxLhJB7ZqsyKfl0?=
 =?us-ascii?Q?ol2HLY+zgQs17RY+KbZkYCpRnh36Djet1+mzD/p7Y7V3De3B4eQh5iUxbEpX?=
 =?us-ascii?Q?U1K4emWc0Zz3RSm2KckqYhByVNJhjmchXFmaUXG4AFZP9q57sAUoHoJ2FQiR?=
 =?us-ascii?Q?hUer3z1rp9PIx6hVMpxE2wUn09t8szdwRqgwUFuYMi5BFG20aFK2qnYvECEn?=
 =?us-ascii?Q?BvE3iuO4pFtiwWgabPaS1goto+SIbPUOxxgwoghRR6j/jyxz8+/Oz2Y/lqID?=
 =?us-ascii?Q?qL/tERxfLrWW9zBAYzPbG+EzX41IvFOZ4zS8X+Kuu5IZzgz0EuoV8YhTW15q?=
 =?us-ascii?Q?wQJPd3zpyE6AxIgO8WFmEx/DqMx5AwfvbjrQpkztye0eoEB2FHmKWyFt5Sg+?=
 =?us-ascii?Q?dewtslZw9uP3fbYP2A46YIW/xf16YAkPx9UO+URmQZbVWXoM8k9ojT+hN6Ll?=
 =?us-ascii?Q?/aWjimqe5s+TGC3dF0lMi+Jo27PN32gP0WUIF4xuRIsntcrRHZK3o1neZnUo?=
 =?us-ascii?Q?/VxkkARhNos+LHvSI35Ua4zImNtoE+x6U7ZmwF+4Y1jlfpRn3bE7rfQvpU7r?=
 =?us-ascii?Q?l2+oNUzkJCve2Wr+3Njjbj052AGNWyHm/wwYuXSAT80lVWv+izMIyOQWqb2E?=
 =?us-ascii?Q?1N5fVUIfMUdUfVyfKeYWAoeXq2NO6+WAbg6/9D/OjhU2MQkGM0rgJVgL7yzv?=
 =?us-ascii?Q?nNbGLQX6l2o6zrrr1LeJ2r3HUlaiZ+3Qbcdu9QbkQK0rLdKUXh9g/3pa/SZ8?=
 =?us-ascii?Q?KlBcaCB/gT2FJiQzxNPKb5UE+pS22vCmY1ssW76K+t3RFEh9Fv7s7Iehwaw2?=
 =?us-ascii?Q?G29YGmM7epE74754BO53oixdQSz4m+UwlLQXU4OGG7iFe2F/n1eoFyvp7Hw0?=
 =?us-ascii?Q?TrZ0uRwCUhu1p01jh7D6+Ub7+B0GE0Yizs9e60rhBvoKUWZV6UkK1QYHuAU0?=
 =?us-ascii?Q?wTstTL/4xzYFiNX4qLG6IO/CCrTuKYAxx4Ff/NTEPKibeNUhZlRejhnF3jvb?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4GRpH9AbwCb0Rvx9o8/I3B7POpq+R3pQUFpCx+LUoTlqgGsIYQA6IJppBNSmmNjBSOW/yW6GHt+SG4n6jm2TjabO1bwnnitBB5t1EcyMlIGQz4jI5ulmuFsZ9n0vcVXqM9iiog34GyWgFHCDFzUv9cYZFfNl83tq+RcaH67uMuCI9Kb/5WBaW0KpsKRM3URXnwVNs4u4429v+ysoFDC/a7jgvmmvBWZiBxZr/u7fXNibmEO6MBEXyozQS3UVUqNeq/b9PexCkWfA2APOsZBAMjrqzNrJuXI8j3kysSIGpaTCGInpN++U49PV3r116l3WtzaGT6eGjqcVmZRbBqECN/SWeMisHZowHL1MLTHkxYCYoQviOg3CXz0O8rWyA1435aciU5dBrTjqq3F9z4LhsEq8HYpTd9OGiKaOjo/10oNizfL/YXHD/BFHXgLwC30NsYdGgdWnnWQnDDqwjzGFotwLgYzMffjNs+gJQ7RAtX5Y2Bn3/IuOz4U6Se8G2Uwo04YaT+UIi5qnYXjjBCZ/EXq5OtRgZL3TXK0gOyIlt+8prjVUDYWqLODM3RNP5vQfEAMkuK30M2752WFbRhBfnvUC6UqP1b5W/8Vqr9JVZG8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a90efb-ed20-4075-5e15-08dc9c5f74ca
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 19:28:17.7042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z2xiD1FVCYBOSaAFA7eTbwQO9jLNLEgvR6C0tLYR+mhIpuidSqYRmJ0UFXA8PmY11KVOnbMUbCG3Zf6eGBGllLVa7FdqBpm7DSqqUPNknsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_15,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040140
X-Proofpoint-ORIG-GUID: 26jo_-iDfH463KtlcrHMzIllazVgkicm
X-Proofpoint-GUID: 26jo_-iDfH463KtlcrHMzIllazVgkicm

These are core VMA manipulation functions which invoke VMA splitting and
merging and should not be directly accessed from outside of mm/.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm.h | 60 ---------------------------------------------
 mm/internal.h      | 61 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 60 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 5f1075d19600..4d2b5538925b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3285,66 +3285,6 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
-struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
-				  struct vm_area_struct *prev,
-				  struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  unsigned long vm_flags,
-				  struct mempolicy *policy,
-				  struct vm_userfaultfd_ctx uffd_ctx,
-				  struct anon_vma_name *anon_name);
-
-/* We are about to modify the VMA's flags. */
-static inline struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
-		  struct vm_area_struct *prev,
-		  struct vm_area_struct *vma,
-		  unsigned long start, unsigned long end,
-		  unsigned long new_flags)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx,
-			  anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or anon_name. */
-static inline struct vm_area_struct
-*vma_modify_flags_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned long new_flags,
-		       struct anon_vma_name *new_name)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
-}
-
-/* We are about to modify the VMA's memory policy. */
-static inline struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
-{
-	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
-			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
-}
-
-/* We are about to modify the VMA's flags and/or uffd context. */
-static inline struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       unsigned long new_flags,
-		       struct vm_userfaultfd_ctx new_ctx)
-{
-	return vma_modify(vmi, prev, vma, start, end, new_flags,
-			  vma_policy(vma), new_ctx, anon_vma_name(vma));
-}
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index b4d86436565b..81564ce0f9e2 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1244,6 +1244,67 @@ struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
 					struct vm_area_struct *vma,
 					unsigned long delta);
 
+struct vm_area_struct *vma_modify(struct vma_iterator *vmi,
+				  struct vm_area_struct *prev,
+				  struct vm_area_struct *vma,
+				  unsigned long start, unsigned long end,
+				  unsigned long vm_flags,
+				  struct mempolicy *policy,
+				  struct vm_userfaultfd_ctx uffd_ctx,
+				  struct anon_vma_name *anon_name);
+
+/* We are about to modify the VMA's flags. */
+static inline struct vm_area_struct
+*vma_modify_flags(struct vma_iterator *vmi,
+		  struct vm_area_struct *prev,
+		  struct vm_area_struct *vma,
+		  unsigned long start, unsigned long end,
+		  unsigned long new_flags)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx,
+			  anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or anon_name. */
+static inline struct vm_area_struct
+*vma_modify_flags_name(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start,
+		       unsigned long end,
+		       unsigned long new_flags,
+		       struct anon_vma_name *new_name)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), vma->vm_userfaultfd_ctx, new_name);
+}
+
+/* We are about to modify the VMA's memory policy. */
+static inline struct vm_area_struct
+*vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev,
+		   struct vm_area_struct *vma,
+		   unsigned long start, unsigned long end,
+		   struct mempolicy *new_pol)
+{
+	return vma_modify(vmi, prev, vma, start, end, vma->vm_flags,
+			  new_pol, vma->vm_userfaultfd_ctx, anon_vma_name(vma));
+}
+
+/* We are about to modify the VMA's flags and/or uffd context. */
+static inline struct vm_area_struct
+*vma_modify_flags_uffd(struct vma_iterator *vmi,
+		       struct vm_area_struct *prev,
+		       struct vm_area_struct *vma,
+		       unsigned long start, unsigned long end,
+		       unsigned long new_flags,
+		       struct vm_userfaultfd_ctx new_ctx)
+{
+	return vma_modify(vmi, prev, vma, start, end, new_flags,
+			  vma_policy(vma), new_ctx, anon_vma_name(vma));
+}
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
-- 
2.45.2


