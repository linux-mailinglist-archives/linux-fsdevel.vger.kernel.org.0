Return-Path: <linux-fsdevel+bounces-43663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B626A5A345
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8649E188B051
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C31E23A9BE;
	Mon, 10 Mar 2025 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Hv1WtwYM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MvrMnflK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3C823956C;
	Mon, 10 Mar 2025 18:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632024; cv=fail; b=E6f5w0En6BtQSXhtbLOhqPQS843YvI73QuHHghAI0nARplVwPWTGQOUvF1X444Gb0CQqQDd0gCZEDo1LSXyWlH684tvQp8nBotKTjPsT0Jx3SfFiOw/SmnYer+fkyZSCICK77Ev6/O4UC/OlhLnRgIuw1MGwN50vc37eYJG+r3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632024; c=relaxed/simple;
	bh=UArNafHb2FwlqNIxaZWkHyzuV+9r6GMeGuCo5o263lI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=shB+oe9mLsH1XJ2bJpp8UYIjz5IQA6veLh/cMiKpIEGzpLxBObxkuMkZ9WqIpZRt7brykMIvbf36UqVk3ddTMj1lOURdFdBEEkyxBEDWknByaLOIs34WrNx75qyvEP2ZMjbc/UbJpoaJXfCs37ojfTa+VCw8n4QUo+cSwfzYQkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Hv1WtwYM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MvrMnflK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfisx009790;
	Mon, 10 Mar 2025 18:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=p/3cPZaLLFOfTMyh3D/7HpCTw8fW5lYxjcAXbegd5ig=; b=
	Hv1WtwYMvYWVIl2zOXjesNZbU72wd6XDEXZqHM/xfn7jujgJv5QmCOdpwgGlzXu9
	QIEJkAFdq6I3Kmw3I8sxWsbS7Kft98i7dbMAVNZeSA5j/7nraRSWj9WSc3wZBHKY
	VieRgA+kI0YzJv96oyqC5YS4vMHmPmX3PP6jl26o0wyg1EMW3cR2CTwkhlwXo6MV
	ty3J1Il/Kk0LgCbSYPHLnvsQUvpYdopMqGkA4Svxm6OLL3V+ZmM00C8utrQ85KQk
	qyX8FvQBl4YeNg4FtD5Ap4EiZh/kZNgTQNNHvcV80b61HXimpMa/Eub6cTsi7inf
	WA//4Ymq10PFwaEnbzsyew==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt38ar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIFBje026926;
	Mon, 10 Mar 2025 18:40:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb805p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rCdWA9i7SU3wg7Nf4W9WqVqWnXEAx6T9O5+WVnAVm0EpzuboYIlca725v4oxqU3/9KJGjCxxDERwr+fxYr83dxui21f91QO5xp+nrvq0Bcf75DGVB1/xqbB0CFYHTDxuVGjTZYCEPLxairktROyAlTnXdNCyFh7RKz1ajG+Z+A52bA7EaCY6TFJCwD8LaH4UloWQ1kPbkB89fdINZihF8NGXjpe/M400781xUjJtPHfpA30SobEtBxF/fjKCc4W8yC6DuJJHOOb3Hho7Vmmoo6Te7Ad34ixO+s/YQ2g4xc0a0WhpM50+VQ1uiX7xCZVBHqj7G9oaJcCCQJQs/kvcXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/3cPZaLLFOfTMyh3D/7HpCTw8fW5lYxjcAXbegd5ig=;
 b=AQxXFdAo/uHsR9icaYztlmqCsgbJW1rq2Nevh59mGRNZg3eKT4tcZRgVaFdU2NQk3LDGg4V2ZovMLDXozH5WlvqUxkneMHwpiahLxjOlaN0JMOYcpAfkg38aVhSGl+DUdVEdzRn4A1RrQIZ0n/nJlbizs/eVcbRy45/blmcWvsOglgN3d31T7DZnP/3kt5ISnQGpvNF19b4fqCJRN10XA/j6f8NBiK/RLDizuw3R5LkP0SoVlW7oWxAHiE0iCP3UktrTsTAwoYY1PVmU82yI2NQhOBbl9LQPhVB6x7C8SspCQcEXaxOCrRRv//RyvgjXQsyIRyEcVm7PejriHRzXOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/3cPZaLLFOfTMyh3D/7HpCTw8fW5lYxjcAXbegd5ig=;
 b=MvrMnflK8Al8FgCaOgUviRJN2fDGXpS6MLeFzVt4aBB/v8tny+AUcYfqQQO6aHhm3o5jNW00iwG60woEZMMHEyVZ9SqIVhIxOn6xnWreHiSbVwHCMbI6fBUDM8IGztd7m2Q8DMipHaFCEC1v1XLp15xTUwGN3PrMlpmNPTw56Og=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 06/10] xfs: Add xfs_file_dio_write_atomic()
Date: Mon, 10 Mar 2025 18:39:42 +0000
Message-Id: <20250310183946.932054-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: c5709a3f-7c6a-4351-c492-08dd6002fe4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VFOuA1Wotm5ivVrkGI9g8dcOTaw6ONxOC7WEGIfKkqhsrAZHguVA7RI6i9Ed?=
 =?us-ascii?Q?8FnoX1NxgWh4KcIpQdzxxCYIygu+I+/gYRCzDT0u7TF2LJN9DOovASDuATL7?=
 =?us-ascii?Q?mgonCDCpV7LbWrH0eFbmfvsACOOsUmHqqq2IYeFF//O6jn2asaM4SztOwShG?=
 =?us-ascii?Q?0z766YXZNxG9DXQPXO9HpWkigWgBwmDMGOLA9ecQAboG9TN1vHpy9rq5j5Lg?=
 =?us-ascii?Q?d62SsRjgGlQotp4FCYfGRgWyMXh1XzokoXUU0A12PDS9cF2HFgEviOsR2OlC?=
 =?us-ascii?Q?wBYaiTaLFCPUB/8Hl8f+Kq83d3GjxG0Xuz/8hgX1wTAmPPpocylZhb5Y1Pdq?=
 =?us-ascii?Q?LjaxErxTOU4D3T/Th/hnprDDiU50bkc/q9BAHbBm97WDgc5LTHjAwa/wHmc9?=
 =?us-ascii?Q?pLEZ0vOzJnJMEmj2H7QoSTsOe045pbc5eJ3UrcheXuqqtRx/Ar9KU8la7n7x?=
 =?us-ascii?Q?Psw1qGs6ly74YD9pB6AVetdlaZJdHjCqmpN9HjgZfLXX5XCGDnyL9HCeiOcu?=
 =?us-ascii?Q?qHquSC2/DQihPc6eW6kjinJtq0d7zmCNNUsPHqvMKx4H2/TPbER40/UEZlVI?=
 =?us-ascii?Q?503cq3T7gsrxN4yfCiqgJRuDE2xICEh4ShzOjSVfAgOo2m+UeaWsxcXDyJ4a?=
 =?us-ascii?Q?ea/XvR3edZeG2ZO/GJc/ZU4+CM1rhux7shYgBka119SWfp+g9tAu6tng/B5K?=
 =?us-ascii?Q?4X3AN7z8hGiQBUYv+JEpRCrbK0audCxKT1h1XC2w9gbN6cApbmwI2+2cARJH?=
 =?us-ascii?Q?wPE+McDBO1NCXOHRqy2ZstBzkjxMlHmrW6HlMSes+c6MV+hRMJmvbQKnWCt9?=
 =?us-ascii?Q?IEbJDKMF3I8lF46ZMh3BtrAllPegLWHjlsmM+z7jSnk2pjsTldSJAmQDBW9w?=
 =?us-ascii?Q?J/U1UaZAbLe75N4Kz2Px4gbfRcrZLnxZ3BXj0npOXV5ORrt/kc7922mxNgP4?=
 =?us-ascii?Q?PwbSFTE1tEV/I7SKzSrargv/pFM1fcqEn/naHmrF6egJwMyjJQ09GFqGk6Ac?=
 =?us-ascii?Q?FGznjdtctFTrzndLRZEUeTiqocaAemO8PS03jjIa99GJb54VTj5BVlZJ44Mo?=
 =?us-ascii?Q?hnPZQJdgvw09CvNlQIx6Dvf7POduV/ma7+it1gGlOAy7ad7MNMGYyjWh/ji8?=
 =?us-ascii?Q?sWkryY85NNILpI8OzVOcmQRiaV963Fjp7tZsLcpQFs/dYF7DcGIkZzAm22li?=
 =?us-ascii?Q?OqOtOjKfwTgnFvuxYfNxVi91jS9ckVqwUGoNyGlU3jR0Udx665E68LGkC0tO?=
 =?us-ascii?Q?SNajXasb3qJIN/Mu2ivEgDyW7AlTJP4MSxtkmgOetQn7iCH/milHAo4XU3VN?=
 =?us-ascii?Q?sSZZOnaJ/59RsAh3fu0tIUPzi1eUTVYEIzZ9T6hf4+TrskTMTg8GXlUHd7Uv?=
 =?us-ascii?Q?J9+mhXQi3ZuxehI8X0E9pceygzY4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YGhMno9nv79ddLKGfQsNXFOthSZ4AYCQ+ieowc+Htf+IxCmtbQaudXr5Yieu?=
 =?us-ascii?Q?vcYd9Kc+R6sTGTofEtzIUYQJO5mb8kpqRuJ2peHNQAvcSBWVmnOFf9/wZ9Xh?=
 =?us-ascii?Q?a0l8YQ5xmmBC2Oc7a0gkMyXk+PoQNTQGDOcIzGjFHU4TeqJVM70LvbqzYXJt?=
 =?us-ascii?Q?W94IqxdgGfkAc0wBsR/Tzij125jEjdsbpqUtFyv6O6qAKC4XtZK2+9uKueHs?=
 =?us-ascii?Q?F5iC+ZNm5b/ugCGhwzerX0nsoK7uo/tBWD/rTIGI6EMBKtpk+1Pr/eY7m8Bj?=
 =?us-ascii?Q?l7x7dgxQf6VTy6AlvsPL+mZs9igmdkdgNOTkVmDxcfUy8tbkvro+GSVHUgGo?=
 =?us-ascii?Q?pN+PShLoctLUD5Bq8cdc+2d1HsBTCFHafAOUFgT0ZE4RCTLt24Mn4H3NaCpl?=
 =?us-ascii?Q?tR2riaeA7ar7uKodgP2WuZDwowiU4JjasIVaz0YgdG071+GBM6qjXyo+Umcx?=
 =?us-ascii?Q?Rr61cEVJKUdBUx29te0XF7CcWLCLmgstAoDWQHZOj6yrnLIiKDahcDeiX5Ip?=
 =?us-ascii?Q?adrgyD5P2hwYLa8Dg0be3J5vFDbKfu9Zlukha/yF/AZWnfe5Rx17gmwtQv5b?=
 =?us-ascii?Q?4Z+4ZQ5GFSRduiytpz9ACsLrlRgoLu/U8mrxCsYcNuZ/0pKMCZhZXo6xKIAi?=
 =?us-ascii?Q?ImQSzqoP/kuSOKYFm8R/6NX2yovgOuWqo3O1jBoq2lJU7ryhN1jQSBr75EeC?=
 =?us-ascii?Q?StmE7gvF4g03lALJMRGu9Bi2O3PMNNygPAl8SSMfckUHYzHdGa59j1UKFWPQ?=
 =?us-ascii?Q?GaMDIU5sj3Z5JCoQatk+EIvielrtzXVvub1uZFyna2243Lf7zUGpoDRGlKuu?=
 =?us-ascii?Q?iaHfvGHPln2013hd9vcXgktZdOQfCWVXwMVelLrABNKpweQP452ZLbwX1V+6?=
 =?us-ascii?Q?bClM1BQvoDmHkk/cai9h0egqv+TuPbwYCuVPLiYpuNZJvo4Luh2jNhDxj+RI?=
 =?us-ascii?Q?KFuxxB2dGlr3VfXQ/WCZG5CeVCoogv9D+fo4ehQhMN0lS3jQEBWGnKBXGY9/?=
 =?us-ascii?Q?Baui2K/QNdPqBRreez7EEOHi9phXl/OaR543qwWBRLCET93RgPst1n/acYyq?=
 =?us-ascii?Q?NnwIj8OVNGUo61i4pRO010HAmF4x01GBb7rc5WyBZBkBp3FMZCSi5xuBpLR3?=
 =?us-ascii?Q?RfmQafiRrvTFaFmtMe1lFzS0z+LoAyphaymX9Iqx3ndNg8iLdIX+qgCcgypf?=
 =?us-ascii?Q?ipSWyRfe1q3zKWZsxEgLZ9x/6AWS9ovpW/hRiMHJXxyk1eRX0FWnDs7TEk5M?=
 =?us-ascii?Q?Ssu73/SNZlNZpKn6k67pMmEKVWbqq2qVDR0P/NFCkqA7oFkxtws0c47DV8Ul?=
 =?us-ascii?Q?pMMEgf0ogQXnDWS5ZHDWD6AYtTfzYSJDcDP76C5uNkIne2gwHBcLxNtvICSa?=
 =?us-ascii?Q?CSuKdO8avXRHXu5bId5ekQRbskqbAnN7A488g2p6bLqEGdZrNVhAbY/zlDW0?=
 =?us-ascii?Q?KYRUgRziZVeQQCVnAvRiM+BmMJZ1mYd3hmOquoQOQB1hNzcJZcAAqQQR0Bk2?=
 =?us-ascii?Q?XscYulI13FsJbPTnb5N0v9cYmvGGZLkeHskaiJlFXtUD9o7VFSEoZaUDZI37?=
 =?us-ascii?Q?nX71ImuGAky/X0DvyBb7Yd/m1eggAyPEakrw0nZjVMV8yBVwfOPMeakbdFqE?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Yn0jdE/BTo2EWxGC4s/+q0VcE81Nr8NugcPq77QQY5EtX4YkI+dO+4Pf2t3993UfvHG3Wuc0X8fxVZAlD84VaXB/xNdZdoTsFbmFbVyG96jrfaZhFurFEF5YL0IsoXEsm6uQa28qeWGYNVUCZNRZEkLOC52iE9MyNTviIrcFUkePkeUTl2bkBwr7hUF1jYS21BolGkBhVqCrypJK0wmmkru9O3cqC31BM79U5MUpL0MwpH5T88HhbuypdRodghENv2/gMDoLoPUjnwNwaUeYADPfM273GQmg7YM+GHkDjOIBgwgxpsTHtWQRXGCUymG1d4u6ax5dS7DyfaJVKMOKh8C3yLYABMQIEqnKCGKjBjk991LMhUQR9izhl65tUGUxFr5/bhsSGkROyo0QaUhFY/6C8Pmru/0FvLbuS+kHTxVS6wHHXishqxiCnKF/xum0B4U21whOIwIz+GtIFmcmDH5AoqLE6Ak13tZpz9wOq4h2WHhp92oNTWRER9CXUIlYrBcjA5SPRDcVWVuPo27rCtrj3h9dZyJEa6v9D8DgWEmhUSY+F5qokWr3MNakjYTnSzBXvlp49nYjHtJLTryfHVEyBoYakyva9CfdmCj8EBU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5709a3f-7c6a-4351-c492-08dd6002fe4a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:13.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7xjcMGbX8pOPYPB5npNN1QJXp6/1isc+EKePnKmmQ9ugzbe4pgOLvlKMDoyHtMWEJLbqNWx4ZmpeDXpGzb98Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100145
X-Proofpoint-GUID: 6xL-jnrINkKq673TbDXLC-UEoe7692WK
X-Proofpoint-ORIG-GUID: 6xL-jnrINkKq673TbDXLC-UEoe7692WK

Add xfs_file_dio_write_atomic() for dedicated handling of atomic writes.

In case of -EAGAIN being returned from iomap_dio_rw(), reissue the write
in CoW-based atomic write mode.

For CoW-based mode, ensure that we have no outstanding IOs which we
may trample on.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_file.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 75a6d7e75bf8..ddcf95ce741e 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -725,6 +725,46 @@ xfs_file_dio_write_zoned(
 	return ret;
 }
 
+static noinline ssize_t
+xfs_file_dio_write_atomic(
+	struct xfs_inode	*ip,
+	struct kiocb		*iocb,
+	struct iov_iter		*from)
+{
+	unsigned int		iolock = XFS_IOLOCK_SHARED;
+	unsigned int		dio_flags = 0;
+	ssize_t			ret;
+
+retry:
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
+	if (ret)
+		return ret;
+
+	ret = xfs_file_write_checks(iocb, from, &iolock, NULL);
+	if (ret)
+		goto out_unlock;
+
+	if (dio_flags & IOMAP_DIO_FORCE_WAIT)
+		inode_dio_wait(VFS_I(ip));
+
+	trace_xfs_file_direct_write(iocb, from);
+	ret = iomap_dio_rw(iocb, from, &xfs_atomic_write_iomap_ops,
+			&xfs_dio_write_ops, dio_flags, NULL, 0);
+
+	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
+	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
+		xfs_iunlock(ip, iolock);
+		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
+		iolock = XFS_IOLOCK_EXCL;
+		goto retry;
+	}
+
+out_unlock:
+	if (iolock)
+		xfs_iunlock(ip, iolock);
+	return ret;
+}
+
 /*
  * Handle block unaligned direct I/O writes
  *
@@ -840,6 +880,10 @@ xfs_file_dio_write(
 		return xfs_file_dio_write_unaligned(ip, iocb, from);
 	if (xfs_is_zoned_inode(ip))
 		return xfs_file_dio_write_zoned(ip, iocb, from);
+
+	if (iocb->ki_flags & IOCB_ATOMIC)
+		return xfs_file_dio_write_atomic(ip, iocb, from);
+
 	return xfs_file_dio_write_aligned(ip, iocb, from,
 			&xfs_direct_write_iomap_ops, &xfs_dio_write_ops, NULL);
 }
-- 
2.31.1


