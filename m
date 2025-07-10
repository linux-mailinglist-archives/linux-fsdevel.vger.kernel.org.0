Return-Path: <linux-fsdevel+bounces-54464-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C128BAFFF72
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 12:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A98D483E25
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Jul 2025 10:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CD32D97AC;
	Thu, 10 Jul 2025 10:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KY3P89fa";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aeYZN/+O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3168B1FBEA2;
	Thu, 10 Jul 2025 10:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144165; cv=fail; b=ojL7hLTi2r5DqHXzkv6gmE2xF1G7aKF+JQU5rq39Qa5NyN2s7y2JV5T9DG6m+3uS+DJ5P/7vcmYrtGWwLZWVJ0rWJ7V5HOqkGScm7A5mn/kYd99229nlTsM+gdtymHtoptLNuKNjoYCKTdeLhNAJg/maBlgO+xbIhDWgXoJNo04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144165; c=relaxed/simple;
	bh=GHabBIX6rvUyv2aCdEslwnGhf5GzC4mPjDHkrPIQrI8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XXbqH5Y9sKocCfcFGQorF308TRhQmo5oUJIy7OlNHuT+2H70vS+m0uYIIQBd3qtJ8KwEnxXXXLixwjL6rXzNTe0Aqh5aZntKyzi9ZBdCUJV0M+8ajY5IeBA5MfnWqKXb5g/fSrh2fwXfR06w5eiPAHWUnM+8IvV1ins01HV046s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KY3P89fa; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aeYZN/+O; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9Ysjr026445;
	Thu, 10 Jul 2025 10:42:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=w/62oqtpA9075/l7uY
	0gTdvlXf8QdZQsN8NnQY93OWc=; b=KY3P89fato9AeOjz29RAnebxCFGj3HA4Gt
	lVY7BuhEnO7Dct+T44bB8i9gl2ZoBGO961bHCS6BJuj5PUQOWIqrPtTdOccFdTzy
	+GKTIWIIXJ78Gpaiv60ioIgkPVXKAhcYxaiSKnC+KJFACvQMGS55UPiA066dlUU8
	zEDS++xVhJY4PO7KNDCaenRv5uMo9UlF1/05DapJN19blGyznXARG/DKrSuoT6xR
	IWaHgXoB4NQ+cHUjgH2bEYtzwvFPgqoAf/i0tHzBc3ne1VQOnABjLOeSNcMhA35d
	hel3gOBKFdQH6JQUAVAs/gluNN2FgXNYQz03yImNDGzYFKs9K56Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47takk85jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 10:42:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56AAZ3tq021405;
	Thu, 10 Jul 2025 10:41:59 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgc38uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 10:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aFfC0hTh9RCXg3tVZZcuOoQUoRSbRYuayC4TifI3bcCWxSRKRJhbCcMMG/MR4gre1DRiFYY+sa/nSkbZxnqT0Y56jkOcIblJw2ZUNXB/h7qx76SjsoBn8uMBoGcwFnWbUzZ1+PpIf+uIKK8fTbO9ciMQUSH935YbulKezBcS4ncX0YPezvXPoUWrdbcpBjt54lwSJIAsQRD4EtScMyRbj8SUo0mEFfyr2TtBjvoAy3JiT5JymvN3Wb2GKVZyWSt0Hw63ulehDf49xD/wRnXKZfoEaDz2XEjMOJP06y2Y8Ceky9DQoJYaLv84gbIIFnHrDIrDD7HJpsT/lhrVoP/BMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/62oqtpA9075/l7uY0gTdvlXf8QdZQsN8NnQY93OWc=;
 b=wq2hnHV3NpybOsPSi1bISflx/mFISm/xHG9aNzsmFItX8ji3MmTPxs58ATCcp533+ROm+GI7uugqTIWndrwhxldF/ers3+ywxBiRn2kOEz9cgn5Q6nBJlwq9M3DmQokoJAw2EQX/n2jjv1EA6j+t+CWM/jkv/AxGDcz5G3zrJU1Jgm5SlLN1HSgaSCd1A9qXBpJ3sLsPZn50kjwfbdHDs+5ge2ML/UYr0qtLal6oarFZE+T7QpolG0YhiNNb4uzBU98+BTGbrYzUlEvn6PZMtPH0qDkmroQYb9sqXdyGpQ25it6ILKiXUZCxCBbTGC2htmmYskQYdx0ktmKK0eZFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/62oqtpA9075/l7uY0gTdvlXf8QdZQsN8NnQY93OWc=;
 b=aeYZN/+OPxbb0FVibqK1Ivo/d8IzAUwtBl3t8S/e5UEWeGudD820WzRHLbGMjQzUOEf9wN+Mphq84M/KZCKjFaemyqJGsLX5XgZjRUhTUafzhkqRYmtko5GLCYouPiNMHJ6Ym6UpBhvOU5TNI2Y7x2DrAU+NriAQkCrAKmsCrnA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BN0PR10MB4997.namprd10.prod.outlook.com (2603:10b6:408:12b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 10 Jul
 2025 10:41:54 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 10:41:54 +0000
Date: Thu, 10 Jul 2025 11:41:51 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/10] mm/mremap: permit mremap() move of multiple VMAs
Message-ID: <a8886e8d-b335-45fa-abaa-559c81247e89@lucifer.local>
References: <cover.1751865330.git.lorenzo.stoakes@oracle.com>
 <6797c4613e2b65f64def79acc4621e0fe42ef311.1751865330.git.lorenzo.stoakes@oracle.com>
 <vn7djxc5cnadmqxsxtd7frgx346fnsvfvlzyh253dxnwn3pe7f@kqci2ing4coj>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vn7djxc5cnadmqxsxtd7frgx346fnsvfvlzyh253dxnwn3pe7f@kqci2ing4coj>
X-ClientProxiedBy: LO4P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BN0PR10MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: 04738d90-1e9c-4d57-6f9b-08ddbf9e62b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLzErYrnzaC6PaGPD5MPUvZ3aZwsEa0X26vpLFMNyr1pWOHmqvIwsGpAIfcc?=
 =?us-ascii?Q?N6kKoaAEpG6ufQxHrv7RKGlQ7kURuV9dvTMCHJALozbtPrjXe088EJUHiRqO?=
 =?us-ascii?Q?rT1Amt66nUcK2r/lmlrrdqJ41qTWM7+YdX3cC69xZmOAB7BnViYi8PkpQkmp?=
 =?us-ascii?Q?406Jr+QOS0qqDKQrb9vtSwf6wSxKaW4QVkOjtv0PCInA3dQob9MMfUQVuSq7?=
 =?us-ascii?Q?v6BzFLoUa6EMYk8pm7k1c2O2XVXFGxe3yvNMS6N4YQEMSKy7r+1D6UmaAbI1?=
 =?us-ascii?Q?CoEer71CPAlkl0DhF7jEl87UUP1Q57cOg4cuGkvhXzxYkRiXafmk8ToGQwKk?=
 =?us-ascii?Q?XnmXz8dQcOSwojFi2LqLMXZNY+gFwUjiywNbKfGsejwASCKd7KPpEmeAmgdt?=
 =?us-ascii?Q?7S1h+EAmrozY3kD/ySoC/m8NrDXjhLVLli4iFb3E9W4ET/6N7cYG4VXFRehl?=
 =?us-ascii?Q?wpr8KG1rl0Dhh1tpEKzySMh6wvlFQQfR3YmcnpDBAPwo0ftaw6C/YzydEb0c?=
 =?us-ascii?Q?efZnAn254Z6ZNj6PNeQW7iH0svIC/FPKLtRbYxvytD59MSYcICzkaAAFs6eu?=
 =?us-ascii?Q?xb7yt4pwf3HE8PbZydR3vNmv6g1Wii+NLi84erWbEs0KrJkVHZg43wZVP4YM?=
 =?us-ascii?Q?qJ8graydtqJr+Xl+53y8D+BrD/EyRksQPLUCoXP2kTpXqu9q+0fFp1SmuXxe?=
 =?us-ascii?Q?Dh3DkNub2ay3pcLLIaPwUKz1Pz74hhJnUQIhxKV+ZlGv15cWa1yBv8TLR/pR?=
 =?us-ascii?Q?NUTogUTF/0GP5o4jaZ9i8Yj6OHE42ud2BpYBFCHxTHZ13d11cv++kGhs4bNo?=
 =?us-ascii?Q?r9YNs1va2Cjp7lxKPl+8AndugSLlfndwcyF24IlDncFMU/AtFbukU5xzTi9O?=
 =?us-ascii?Q?9k3j8zFVkUz1Pm8hDS3qTiadN3YLgqK7pfl2unsRUM5T5A9p1FvR2DZZuRdd?=
 =?us-ascii?Q?LtuCZYio0wDd+Bhl7oBoceLq1WSnktKrzlRNtKjDEm1BO5DZ1zbhbt/WiMGe?=
 =?us-ascii?Q?7OTGtTIV2MIXh04VnU2PDTppUsnQLvErHiVf5wx2Q5/9eU4pH7r7wl3isHGe?=
 =?us-ascii?Q?HcRofTQnrzkR0B5VHwHhWT8YV+Phtpu2atJfrVYoeO7Q0F9y7F9ndhEpD3gJ?=
 =?us-ascii?Q?RBebETm0mbxoZX+L8zdFE7YQIp6q1+HVUCJNNPkL/sQCGIc5Qc7OlqSz7R2/?=
 =?us-ascii?Q?iamiluqT8vIE80Pgkjq4uMNLQG8vb6Q4QApk/drZsEMHaXeGUb65UrVyeyz2?=
 =?us-ascii?Q?aRLT/RO3wLc4PXtMt9draf3ihuYv3bCGhZqI6/0T5DR/OfRH405B3L7w7VhQ?=
 =?us-ascii?Q?RNb8vFj4YHYYm19SueW+mZs6bt0EwX+OdKB7kjfy6N3HhagrXOkze/9LXmeH?=
 =?us-ascii?Q?vzajjcDoHdcmw2iccxIPilTLm1rOkTQyz2aHzM7wVnt/BtUJGlGve/l7C/gG?=
 =?us-ascii?Q?M1G1SukPgy/HPjQMEV7sJ9j78Q7OMOlvMLFzts1TfsqggR7O5jwV7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o0NRPM64Ms12dEs7l7OPr2Lo+CEl2m/UeN1/NeVRwJ2Y6ywHp0Lv5PbmfA4t?=
 =?us-ascii?Q?kH5fedPlcDQf7aCKSLymyLQGOAYhlGHchJN9dyjBjRUQ5Y3VgoajXJUExd08?=
 =?us-ascii?Q?UKSlEvw0mtfoflePpnkb9UGVZw/RbIJqtHllT6xnoJgEUkaiSvz+RD/Er49j?=
 =?us-ascii?Q?jxsUSlrzM+DqopXQIUCUHwQ4hq7WiAiao0tAEFFef3CnKxpk8Lk9MMbMlSx6?=
 =?us-ascii?Q?27IZE3HA98DPx4s4G5RUD7jHYOhYBMBRi/OrORn6nFzws1RQrDOrqhMeFs3u?=
 =?us-ascii?Q?fEbLxPdhgDNU4nimDUxDOEZwzqL6+eAgoLZWtvb2SMNRzCrm94corewoiFrO?=
 =?us-ascii?Q?ztvexzWdNsL98X6K8xSp2hsUkSW9kDgvmRNRTh9bfHJw+tqmJGBAJJApXbIP?=
 =?us-ascii?Q?8ex+5M+ujT0+vd+7EQoYN3UvD7mn3rqIpjyrZIoi8Gk0WIoOK8N8mUAQFFLD?=
 =?us-ascii?Q?4v4xGasOLUDPD04cp4bv1xGM8Gv/4hFNi9ccLoGf34XKHshq6WyEOv6QS4Sb?=
 =?us-ascii?Q?XXWQLXUdaIbsB5a0Of472+qTpl6WtHeV52JDBjuZOCQhj4slf1aOy9VvBTUa?=
 =?us-ascii?Q?U4X0OA/S1EXqLyvvrIJbYVCt1Nv4QmYI9K2K0/zFj2z0OrfCJZm3mzEuBGCM?=
 =?us-ascii?Q?BzkstQh0ubntZqAI36ZNzJpdKs5MMiMQVQGWvja53cZoza4QT4evbbKYOCFX?=
 =?us-ascii?Q?LgWCnzYLpzUk3swNzyCMsfDsODThcXswrM32p7pS8z2XmqcupYjOQSEXSJJi?=
 =?us-ascii?Q?2jW2nQfDtp1KeWMCrR5bX0SogqN+dLhztcqAHvr0MS0cp7SVoSrz2i6TMUdF?=
 =?us-ascii?Q?A6bXtMBSy+x0MZf1X/kH5Rj6j8ppvwe1oZZ38XBtqDd3tjq0GOSb02ZRc+ST?=
 =?us-ascii?Q?9eb7rlujwvW0O9gzGxqFby8s2BZt73lGTfJSUkzLCQFUIcB00qoT9U+bYT1u?=
 =?us-ascii?Q?9baMlxWU3qzf0JMRJJZmqq/iF1NbL67dQodTq5hKbATMXPwQvoQr13TexAuU?=
 =?us-ascii?Q?L6xqqjZt3rcalvu2eXe2mltKK6WRUoe7bwVzfpGc4EUPvfrwfMXBoeNbePgZ?=
 =?us-ascii?Q?N9ynyvivwNcz0mxMufsMKJ+CF3pn6252gudcPxL1VkB3gi87JrjowqLK9lFQ?=
 =?us-ascii?Q?cAxxeX1eWsZI8pQVd4mpGmdedCdOZeDtiM4j7iJZQrkcq+cR3gmxFKnWlraH?=
 =?us-ascii?Q?Zu6DvElm7Vzu9g5V0yMaCtUnePmgNFWaEAw9USVwstO/Mxzj55a1WBYE+p5E?=
 =?us-ascii?Q?1GYW7eqQqyU+NrQv80BT6WqnT/JEKUGks7icbrQofhs3Sl5txJ30V6aPb1gA?=
 =?us-ascii?Q?LPjQIuDGBl0UBZ8FJVjnnEkheQwyQdzuMosxL3NWtHjG7oUSZRZGKpTcsaJW?=
 =?us-ascii?Q?nuwfV4gSfcwd0pjLmoux0pXo5If2Irk3URNRqfTqliyZdBW2sSqqM0gfkzrO?=
 =?us-ascii?Q?eWLdERFNj/azaMP6WRzlmE+cIAnJKF66Z47FoMzn494DGtlGW+3zQafYAGtN?=
 =?us-ascii?Q?aAsVtGStbpD3dZFHcP6q1cNDRXBp/MT34DJzpByi5BY0msEAgLwEyd1ssHWT?=
 =?us-ascii?Q?ty2q0UnZ8+zCyjopln+F86WnliW6y8n7Rsl49+6GnAzxHVjdG+wEuS8RzbGk?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	49i1Tx5L2wIjahpxpMZGJ6IoShEE1hEgymoOeE77joP8Pn7HNsFL2We2tT1T/4Sd/wZUFIP8EJ7uC4vDIldMPB68HJQPjH/EU8vgJkvtkjO6OUsRCOOeYobEt9LYEeKVAUj/7rA8uSGR2eWZngTslG2o0RiJD8j+sy8BIj2B378HeAorFInlv5OEDOWNEzRJhRIL96hQJa+eGzygIBHLxYuovTK4ZhObGTmfRvvnZEocSNPTMeMj+48ICsZ66GSEZg0iPRQCNuDslytkhACpuZEduqfD4YuqC7jb7kynxe51B2JVbsrbnx3tgo7M5pRCFkg1HEtJNCktzNRJj9MnVYlZwbarDiIt6w5GS+lGJ/C8f3IRRbZKaN/eFDkTmxU5jhdwA42Ry3cSiSwfRkIYFTgjlbmnV74Sik5cvmIDGNumxkmW1wLZcbs0Ogof4/HfTnH6jFdKh3phVHHKGfelaziBspyBZsZjhPkpVsYBjaJJH2tYVBG3KkbRM5De9KhATE9aIC2RM2YXqQ6putohCubYZ2xSv+zg7zgpo1ByXMD6i8qT2P/OEFWJW/FP6m0AO6w+zuyCIAftBEGn1/qD/uFs+bbwNBFV5bzRqy+xR2I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04738d90-1e9c-4d57-6f9b-08ddbf9e62b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:41:54.0193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byGK3i+LJNAjLDUneYycsl5sWSVpTWvu3aWKM2FN1lQb39Edg/rYlEkRL4G/jXl2s4Owoknf5AvsmotfEkzycZYvv0dRbWZITBIWUomKc3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4997
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507100091
X-Proofpoint-ORIG-GUID: TR4YAE3ZJRRVdjiHbQZ3n9RQc1CN0hOk
X-Authority-Analysis: v=2.4 cv=SM9CVPvH c=1 sm=1 tr=0 ts=686f98f8 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=kEiDSiyQGU_OC-y9kSoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDA5MSBTYWx0ZWRfX2Zjixrr2GaKX xlG3xl6M3LRexgZXnL4sStSChrY+vLyM2Ejlp2obBY5SvmY59LM+yFnsEVKo7/jmYItcwHbbbc5 CKjPT+IhaXR7310y/ID+yVih75mF+zElgX6h8cTqi1cgFZOjuuZ49ARA5Xp32kaLRjYZoChvjR4
 NF6ZS43OQQ/TxlBtcnPD0ob2QtNs/BpKLekaELugpNCHb0ate+ICO7EwtxQbobHgEmJJGFiAqdv kNrK10BOincFz+kUkMhDdJra5OliJFWhrmjS3hmnLQfDlmAWzI2Qxf6A2BFubs57LX9hTv4ZfEw JzWmdy60Or4jEz5ZDWmHMEhUlJC7l1sIONK1u/+jswAtgvcGxtX1cKUmXMtJ4or1L3NLEvURZ+6
 rFrLfXKNOLVNx8FhWbpnPL7uMy8N2kD2esvtvlLKTm+yCx7+H/IM6in5+/W4531aexFMCMif
X-Proofpoint-GUID: TR4YAE3ZJRRVdjiHbQZ3n9RQc1CN0hOk

On Wed, Jul 09, 2025 at 02:13:41PM -0400, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250707 01:28]:
> > Historically we've made it a uAPI requirement that mremap() may only
> > operate on a single VMA at a time.
> >
> > For instances where VMAs need to be resized, this makes sense, as it
> > becomes very difficult to determine what a user actually wants should they
> > indicate a desire to expand or shrink the size of multiple VMAs (truncate?
> > Adjust sizes individually? Some other strategy?).
> >
> > However, in instances where a user is moving VMAs, it is restrictive to
> > disallow this.
> >
> > This is especially the case when anonymous mapping remap may or may not be
> > mergeable depending on whether VMAs have or have not been faulted due to
> > anon_vma assignment and folio index alignment with vma->vm_pgoff.
> >
> > Often this can result in surprising impact where a moved region is faulted,
> > then moved back and a user fails to observe a merge from otherwise
> > compatible, adjacent VMAs.
> >
> > This change allows such cases to work without the user having to be
> > cognizant of whether a prior mremap() move or other VMA operations has
> > resulted in VMA fragmentation.
> >
> > Having refactored mremap code to aggregate per-VMA and parameter checks, we
> > are now in a position to permit this kind of move.
> >
> > We do so by detecting if this is a move-only operation up-front, and then
> > utilising a separate code path via remap_move() rather than the ordinary
> > single-VMA path.
> >
> > There are two tasks that occur outside of the mmap write lock - userfaultfd
> > notification and population of unmapped regions of expanded VMAs should the
> > VMA be mlock()'d.
> >
> > The latter doesn't apply, as this is logic for a move only and thus no
> > expansion can take place. In the former case, we explicitly disallow
> > multi-VMA operations on uffd-armed VMAs.
> >
> > The mmap lock is never dropped in the move-only case, this only occurs on a
> > VMA shrink.
> >
> > We take care to handle cases where a VMA merge has occurred, by resetting
> > the VMA iterator in such instances.
> >
> > We needn't worry about self-merges, as in those cases we would, by
> > definition, not be spanning multiple VMAs. The overlapping range test is
> > performed on the whole range so specifically disallows this.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/mremap.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++----
> >  1 file changed, 99 insertions(+), 7 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 28e776cddc08..2e6005e1d22c 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -69,6 +69,8 @@ struct vma_remap_struct {
> >  	enum mremap_type remap_type;	/* expand, shrink, etc. */
> >  	bool mmap_locked;		/* Is mm currently write-locked? */
> >  	unsigned long charged;		/* If VM_ACCOUNT, # pages to account. */
> > +	bool multi_vma;			/* Is >1 VMA being moved? */
> > +	bool vma_reset;			/* Was the VMA merged/unmap occur? */
>
> The name doesn't read well in code.  vmi_reset or reset_iter might be
> better, but I don't really mind it like this.

Yeah it is a bit odd I agree.

>
> >  };
> >
> >  static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
> > @@ -1111,6 +1113,7 @@ static void unmap_source_vma(struct vma_remap_struct *vrm)
> >
> >  	err = do_vmi_munmap(&vmi, mm, addr, len, vrm->uf_unmap, /* unlock= */false);
> >  	vrm->vma = NULL; /* Invalidated. */
> > +	vrm->vma_reset = true;
>
> I believe the munmap() operation leaves the vmi in the correct position
> to reuse, so this is cautious that costs an extra walk of the tree.  I
> don't think it's critical to performance, but if it is we can look here.
> It would have to be passed through which might be a pain.

Yeah I think this means we _always_ reset the VMI as you mention below, unless
MREMAP_DONT_UNMAP | MREMAP_FIXED is used.

It's right to invalidate the vrm->vma here, as this is the source VMA so is now
a dangling pointer.

I think the problem I was worried about here was a partial unmap causing a
split, and keep in mind we might be moving things backwards also.

But I don't think the _iterator_ should be invalidated by this actually right?
We'd still be in the correct position.

So yeah, I'll drop this.

>
> >  	if (err) {
> >  		/* OOM: unable to split vma, just get accounts right */
> >  		vm_acct_memory(len >> PAGE_SHIFT);
> > @@ -1181,6 +1184,7 @@ static int copy_vma_and_data(struct vma_remap_struct *vrm,
> >
> >  	new_vma = copy_vma(&vma, vrm->new_addr, vrm->new_len, new_pgoff,
> >  			   &pmc.need_rmap_locks);
> > +	vrm->vma_reset = vma != vrm->vma;
> >  	if (!new_vma) {
> >  		vrm_uncharge(vrm);
> >  		*new_vma_ptr = NULL;
> > @@ -1325,6 +1329,7 @@ static unsigned long shrink_vma(struct vma_remap_struct *vrm,
> >  	res = do_vmi_munmap(&vmi, mm, unmap_start, unmap_bytes,
> >  			    vrm->uf_unmap, drop_lock);
> >  	vrm->vma = NULL; /* Invalidated. */
> > +	vrm->vma_reset = true;
>
> Ditto here, lock depending..

We won't ever drop the lock in a move path to be clear. Only on shrink, which is
disallowed for multi VMA move (as is expand).

So probably this is overcautious and I'll drop it.

>
> >  	if (res)
> >  		return res;
> >
> > @@ -1362,6 +1367,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
> >  		err = do_munmap(mm, vrm->new_addr, vrm->new_len,
> >  				vrm->uf_unmap_early);
> >  		vrm->vma = NULL; /* Invalidated. */
> > +		vrm->vma_reset = true;
>
> Pretty sure this one is needed, regardless of passing through (and
> updating this call).

Yes this one for sure.

>
> >  		if (err)
> >  			return err;
> >
> > @@ -1581,6 +1587,18 @@ static bool vrm_will_map_new(struct vma_remap_struct *vrm)
> >  	return false;
> >  }
> >
> > +/* Does this remap ONLY move mappings? */
> > +static bool vrm_move_only(struct vma_remap_struct *vrm)
> > +{
> > +	if (!vrm_implies_new_addr(vrm))
> > +		return false;
> > +
> > +	if (vrm->old_len != vrm->new_len)
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static void notify_uffd(struct vma_remap_struct *vrm, bool failed)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > @@ -1644,10 +1662,29 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
> >  			(vma->vm_flags & (VM_DONTEXPAND | VM_PFNMAP)))
> >  		return -EINVAL;
> >
> > -	/* We can't remap across vm area boundaries */
> > +	/*
> > +	 * We can't remap across the end of VMAs, as another VMA may be
> > +	 * adjacent:
> > +	 *
> > +	 *       addr   vma->vm_end
> > +	 *  |-----.----------|
> > +	 *  |     .          |
> > +	 *  |-----.----------|
> > +	 *        .<--------->xxx>
> > +	 *            old_len
> > +	 *
> > +	 * We also require that vma->vm_start <= addr < vma->vm_end.
> > +	 */
> >  	if (old_len > vma->vm_end - addr)
> >  		return -EFAULT;
> >
> > +	/*
> > +	 * We can't support moving multiple uffd VMAs as notify requires mmap
> > +	 * lock to be dropped.
> > +	 */
> > +	if (vrm->multi_vma && userfaultfd_armed(vma))
> > +		return -EINVAL;
> > +
> >  	if (new_len <= old_len)
> >  		return 0;
> >
> > @@ -1744,6 +1781,57 @@ static unsigned long check_mremap_params(struct vma_remap_struct *vrm)
> >  	return 0;
> >  }
> >
> > +static unsigned long remap_move(struct vma_remap_struct *vrm)
> > +{
> > +	struct vm_area_struct *vma;
> > +	unsigned long start = vrm->addr;
> > +	unsigned long end = vrm->addr + vrm->old_len;
> > +	unsigned long new_addr = vrm->new_addr;
> > +	unsigned long prev_addr = start;
> > +	VMA_ITERATOR(vmi, current->mm, start);
> > +
> > +	/*
> > +	 * When moving VMAs we allow for batched moves across multiple VMAs,
> > +	 * with all VMAs in the input range [addr, addr + old_len) being moved
> > +	 * (and split as necessary).
> > +	 */
> > +	for_each_vma_range(vmi, vma, end) {
> > +		unsigned long addr = max(vma->vm_start, start);
> > +		unsigned long len = min(end, vma->vm_end) - addr;
> > +		unsigned long offset = addr - start;
> > +		unsigned long res;
> > +
> > +		/* Merged with self, move on. */
> > +		if (vrm->multi_vma && prev_addr == addr)
> > +			continue;
> > +
> > +		vrm->vma = vma;
> > +		vrm->addr = addr;
> > +		vrm->new_addr = new_addr + offset;
> > +		vrm->old_len = vrm->new_len = len;
> > +
> > +		res = check_prep_vma(vrm);
> > +		if (!res)
> > +			res = mremap_to(vrm);
> > +		if (IS_ERR_VALUE(res))
> > +			return res;
> > +
> > +		/* mmap lock is only dropped on shrink. */
> > +		VM_WARN_ON_ONCE(!vrm->mmap_locked);
> > +		/* This is a move, no expand should occur. */
> > +		VM_WARN_ON_ONCE(vrm->populate_expand);
> > +
> > +		if (vrm->vma_reset) {
> > +			vma_iter_reset(&vmi);
> > +			vrm->vma_reset = false;
> > +		}
>
> What code path results in vma_reset == false here?

Yeah that's a good point, only MREMAP_DONT_UNMAP | MREMAP_FIXED will fail to hit
it, so let's drop for unmaps.

I will test this is all good too.

>
> > +		vrm->multi_vma = true;
> > +		prev_addr = addr;
> > +	}
> > +
> > +	return new_addr;
> > +}
>
> The iterator use looks good.

Thanks!

>
> > +
> >  static unsigned long do_mremap(struct vma_remap_struct *vrm)
> >  {
> >  	struct mm_struct *mm = current->mm;
> > @@ -1761,13 +1849,17 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
> >  		return -EINTR;
> >  	vrm->mmap_locked = true;
> >
> > -	vrm->vma = vma_lookup(current->mm, vrm->addr);
> > -	res = check_prep_vma(vrm);
> > -	if (res)
> > -		goto out;
> > +	if (vrm_move_only(vrm)) {
> > +		res = remap_move(vrm);
> > +	} else {
> > +		vrm->vma = vma_lookup(current->mm, vrm->addr);
> > +		res = check_prep_vma(vrm);
> > +		if (res)
> > +			goto out;
> >
> > -	/* Actually execute mremap. */
> > -	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> > +		/* Actually execute mremap. */
> > +		res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
> > +	}
> >
> >  out:
> >  	failed = IS_ERR_VALUE(res);
> > --
> > 2.50.0
> >

