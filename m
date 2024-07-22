Return-Path: <linux-fsdevel+bounces-24064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F285938E6E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8DC4281CA6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C0016D9A6;
	Mon, 22 Jul 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ILcg3fwP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E4GGjxGc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A8616D336;
	Mon, 22 Jul 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721649065; cv=fail; b=JB/yQOCtxAyDuz2yNY3STkbg/8yOUDGMZxG13jyN2ptqiTL9+L8B+cImub8UzYPaqOONyUf0ZhsflPuNnEisxBORE0BuPotoj8tQ4DPk/CsGcEXkmJbggsA5NvZFKlR038IdiokdqaCce114I78CNiWOSsiy4RAImy2hPLo95xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721649065; c=relaxed/simple;
	bh=OF+i6olD38gsYv82kMKX5cK/kmOUvJqZeXQ6mk/bcTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OQyDCdMmgmGdRgfHxqyPNoFn6dSlbUDb1ya4yF7gotzFtVMylXBSO/Gh0Cbzlc5hC/c+1UnUdR3aEjp77jA9zCexkZgSj1hWDmqzzN0OhK0bRi1DI8IJkIe4Q0BHPNV5DYz6e8syzLDg9ICUjx6hwSOcD63PuGNvCqy8cnMoeeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ILcg3fwP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E4GGjxGc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46M7d1o9021211;
	Mon, 22 Jul 2024 11:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=bojfiDE+vLogRuiloJdontKGidCCrH9BI//DCTgUuqQ=; b=
	ILcg3fwP2Eb0Gl034hAQezg+X1qFgUSZr9FONyM00vCBJExvTMgtw8GVayM7D96/
	wzTJxN0yiXbobjD0aItij07YjEgRPFaudrmSbwPdMteQNJdc+9K0/ZLQbY0N/0F4
	DlDWKPgbJheOMAtd//m/7nRABSm1gfBtB3TaHa5AQjBAzkqgc1uQ+y8pdd8JNbGx
	+0uMCiOEiICC4nm7JEOqLDlPwSonkNO9wzCZ8H6XTuP3+VryzBsJbDb+ahugUHHQ
	OW2vVWymdF5DwZLyaTwjyT8LS4j9D8oYtJWBwhNc59bDk9s1ZLProaKiEWWu+PCK
	NsnxYZLYvcNDPAWF98c86Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hgkt1dk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46MARVfm019196;
	Mon, 22 Jul 2024 11:50:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26judj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tAm1FV7NFXbZt6MSPNYQYDTsAXSuR3Ekk1hvkmFMfqm3YNj/S/0L5jqWbGyVVrUQoQczBlrbEaSU6xsQrBpLeFKbWJVjudNk5uyK38HAFgihmY1UACQns44+fK9CAiI3Ec5srQOjA63zxnRSBzZ3m8Y3644H+FytY//KoCX1062yCqwuTmMv0AHGSlPE9KYZ/vSUK5B55zHyMDv8bAjnPPTqmTl0tczDiW/XhNav/QCANEUjyGAbLfK5Qa7UrAm5/OfrCcs696wj8w/Ol7cGmiuWQRE1SVR1Uj5ojVZjwmieRU08C4xEwQE3hpF9w3SdTMtmhcbKciHxD/fiz9lIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bojfiDE+vLogRuiloJdontKGidCCrH9BI//DCTgUuqQ=;
 b=SxB+E8UBSsPhicKmGwpucS5bL8eLyByDe9BrKXAKti4CAKq44G1Fv4/Ntr+cVVDLeQAOLJXpc1/eEXynG2OQ47mWamX6udyvfEmW9pqf0hCAQbyiq8esqiQkmviQcIL5Ua0RV0z4NdAq4g4c+PPL3xyaHGZzliBcb2A224XU5vCf1PP0afZNsunEWWNGuZcsMxYOcrp1w5iSMC/x8itbgQgQkvevMWFme2ppXiin9b3J2KgYMPg7yisaZP8rSiDlQ+1t/4UFwsdaqyVaG+vqdau+PMogE44ToOXGfY/bt1dEc6xZyx9MCDe7JSPtLr6K505rwGxBiH9SKyWMyIL3mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bojfiDE+vLogRuiloJdontKGidCCrH9BI//DCTgUuqQ=;
 b=E4GGjxGcIs5vp2kAeHEMNIXl1OgMZPXy+jgCJut1AtuGuLk92LiK/VfbEdw4g0fsjoM7JEG7vyGoDW9iO+GzJPuFy+ZAsP2W2eb+VAke46YPDRRq0BJRQ0I/6VbQE4JZEo+nfj2VNtx8RrXt8gTdVq2AVGQKjGUOpEsRNv9it7M=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA1PR10MB7358.namprd10.prod.outlook.com (2603:10b6:208:3fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Mon, 22 Jul
 2024 11:50:44 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 11:50:44 +0000
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
Subject: [PATCH v3 3/7] mm: move vma_shrink(), vma_expand() to internal header
Date: Mon, 22 Jul 2024 12:50:21 +0100
Message-ID: <5909552e51936191428c007c4be8628b4d3faf5b.1721648367.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
References: <cover.1721648367.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA1PR10MB7358:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c19032-f9ee-44b1-6c84-08dcaa4484e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wrdo0jAW3J0x1JyDqvAPsMapWjgwhibn6uHPPNHNBovMLZ0CCKeZ43vyKsGO?=
 =?us-ascii?Q?Dvmaheg7XD64g60B3u8ANoV/eUPBGFY2RU7ly4Ozbftq/uK5uxBJr6xJMuTX?=
 =?us-ascii?Q?HjQRX3sXX/76lmEz1iC8N2XnFEREQt42ny8n98kzmUPGTE90WZ7yGulnuEMr?=
 =?us-ascii?Q?KpkplMnY035oC7RkTXs4iNP8mF0z73FuWgqGdgbfs0NZOAjKBxx1w/glZCU3?=
 =?us-ascii?Q?RiLYSSuXMnPCz2EuQ8bg1WgAEAX4S8mYzOgYFfqScUoYhGj+Yt/uvRGk0hSq?=
 =?us-ascii?Q?CPVDs/QlDZhJfagUpFepqSy4xYVQwbyl5vooQhXFxUF5Ayt/jXyzIrm/fHOo?=
 =?us-ascii?Q?njIaQSCzLHc/RDDUVp0gKwBVcrGmdevmSHNqHBoL7J9yErWd9AsbwECH7FYi?=
 =?us-ascii?Q?+60b2jMcHkCCkvkPZYenn3Vj9GGRVTnDMTgGUcIdsJX8fZJOg8yUe07JRRQd?=
 =?us-ascii?Q?WZWApy2BCcsUC1+AhREAmUFUb1+jalAEvdDXIN65FP+swP+fuKLlHCiq/gVM?=
 =?us-ascii?Q?cy6Zc1QqXLMAGsh1n9hjLqRSBSH/OuhnlHRzSIRGtMNIKBzUd9MF+wsykXwZ?=
 =?us-ascii?Q?jkmFxg0EtG5UM/wnuBIoknkhkE0mG3m6zA0OioxudJft6mvX+pUMvF01Rhah?=
 =?us-ascii?Q?X7ILSA2SJtH/AWnOHTjgZZJqEW+jIG4Au5YEAbH0zeeomrNUZZeW21vVNBF8?=
 =?us-ascii?Q?oXEip/sMXZm4T5zuuY7SKRGfDwKvSK0gTTkMgpewRkUvCAQJgHulbwL+49aX?=
 =?us-ascii?Q?nCBSXcJSIIGUa6RhVYOcjKNzF1kuIR7pJttRjnxXAOkKtG9mMttIfqmuyttB?=
 =?us-ascii?Q?rW8qhZzb0rY0R+w339MTunFH/uAkLZVtubQ+J+5yNMO0vyBch/0KM7wcFj9l?=
 =?us-ascii?Q?1TBVLagXsOfVXAwI+9y5APNTsejR2kTbIU6NryocZNKDx+ArJwCx5s4AnjUV?=
 =?us-ascii?Q?MuOAI5F5KFuu59NsSo4Tb2zLuFuuurVEkJs5JS42vK7yvpSzr5f/uqVy/1+z?=
 =?us-ascii?Q?mdASsbkdx9m0O6WwFWCbazhhxVB8azd+voHX2YQYKTVQ8payO6l63ly+06If?=
 =?us-ascii?Q?8xJ3oMzUgP8rTMK1Z6VfmsQKI6DAk302uycTGltYYxLg22tY0wSLePnOQqUe?=
 =?us-ascii?Q?5vi8HVB1rJQDgh2n0YVQnz6Ew0SqWPUqG/Kq55fZDfODMI8lXhC9jdRGIqBb?=
 =?us-ascii?Q?7KdVBDu1PCnaF9QrdwfSdYhgvBZoFrY5b8Cl14j2nxnwajhqkpUkZejQzWk2?=
 =?us-ascii?Q?qwcNWGwsxzA5yd9VJfxgtz9MDMjGn9foM8bIP5vWoH49k1DkJqr0rC30iMiO?=
 =?us-ascii?Q?TtMjTENetv2Ng0y/+BCXgX4b6NCZ3eMh85YjwToz5wC3kQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dt/kPDstDVH39rGS+ATl2JoNpQZ6rUcUpALt+db+9/fD2QXCsH6aaG23nXtW?=
 =?us-ascii?Q?6o4zHM7R3llSYDLNeGlE/XIsM/YECdujG82SKhbOZW2ARPOEyii1baVzQ8NN?=
 =?us-ascii?Q?tl7jBTjhJ7Ik95a/jD2UdIoV4oIEVsnp+8zIOD5PYo3bwE6YFf0G9pFBY59q?=
 =?us-ascii?Q?OCj9OwjOk5S7K/vu+VEsrX9ACN1iv8seCBFaxqPza0TnTPTMHSQXqsOe8iR9?=
 =?us-ascii?Q?Pqhf6gHhEIUV69el5bS/PcrPj4C8Y8hsgoIksFeXXFcIZwA/uS5YktKXUutG?=
 =?us-ascii?Q?ifwzmFP8BNSkKplHU25Gu8ioSv35dk+aLuuVnYd7I6QE75M2lLmEG7Q7oI1l?=
 =?us-ascii?Q?QKZK+BlBfLKXZVtoPBl1qGRH9uorQgyJxeLY0zNFB9pwnGdj3W6HknXOQcsz?=
 =?us-ascii?Q?ntmRM8G2YSDb9t6fCAuGSxW9wOH0Ym2R4iHP7xYu9UBI61SNUGgTB7xjauv/?=
 =?us-ascii?Q?8ssscuZXfEF0xLKB/tIDIFw3AWzWI8ATMMV05zTx7cmtTjnVgsxQRasepAmn?=
 =?us-ascii?Q?sCzJ64WnqLvqk1DxU2gxrzDQFl+e4L95G3ilQY5VwqErXTY8h2bryHgLbCq6?=
 =?us-ascii?Q?rQsptR6ug3iNWcZ9pk+ffvYXudLUjY++B9rgKHV/1uj6b/TEf6ZkQ/4VEND5?=
 =?us-ascii?Q?5EsZrighcY31sYceqb+JM7IiC+6Fl+404xCnfCDETBFMuSeMtlWXHjA2awMm?=
 =?us-ascii?Q?JMHeM/bNcjmAzKcfKblwKkS4PWH7/gr2gqU4vBplFO7e02ExJdm4+KTTRvcj?=
 =?us-ascii?Q?aEaFYI7rFIgAT0zUhuP769Ud7jdM3mH6vwpthqcuwY4GFIHuhGs6XpcK8qZD?=
 =?us-ascii?Q?hj52q0xejrUlQ0l4NWg9JZZpK0X5dAh4WoJtSVWOj0wELGrBdZKvF0RTV9ul?=
 =?us-ascii?Q?LIKJbvsCCFZ889E1+iulKagbIcXxy6gvFOFCAYHwg0gSIHus3vsG9GaVfWdh?=
 =?us-ascii?Q?ci0hbvIZ8w8hwj5RWsDDloWCm1ewWnW9RDTN7ZpiVi0/R90qJhCkgbr/Mcll?=
 =?us-ascii?Q?9ag7AQqM5ouVgWS8E1od35/O9X4rE/7IoV98nuDtBHpGpBSOg639nT7BsVJn?=
 =?us-ascii?Q?Fic31aKQU4qmGQmfaEk1fUzCIHP/QF7ysrSMmjM3aHPmQPnyODoql1g2zuop?=
 =?us-ascii?Q?q7FnR5T+V9hJQ4JBU4T55JNhtduxh8IibCfpTjRLT3Ask5iHvxO1onD2NjuB?=
 =?us-ascii?Q?qPSOoeSaZYSgROWMngDSg5O6Zn3gifiBHz/SChEwiCMeNcGVBi9O/OF6zyIU?=
 =?us-ascii?Q?5Q3+rZOKnbP362Hu7M+lCz4mBKyj1rbbXNW/5/Yyj2km11xM5dAdWTgpY+IL?=
 =?us-ascii?Q?3egQEoK25Vf/92SG+O9LN/4ZRwZoeFn0TByUhXKCw2RDHnZkeKv1mkoTRW9W?=
 =?us-ascii?Q?jlm1ggFEOXiOhKR8cE2v7AQAIgOA+WtwKu0hRkdVcYQbSBNAVPvqiraEQrUk?=
 =?us-ascii?Q?MG9edRlMqIbL7PkMd466m97/odYOQyZN/+M1xNaVhWWP1vc1M+nvCaToKfEj?=
 =?us-ascii?Q?OXW3Obrr8sSok1CGYAf/DzTxfJ8rfPPpZhILHru0Ng9tk+7sEUhrXk0pseqm?=
 =?us-ascii?Q?DCqBQxm11rPcuv1V4nDN3rgJvYqhwTIY3Nxh+Md3mAWH+VtT5c+TI0B9hxO8?=
 =?us-ascii?Q?C/omcAhOKKj8HcQ1QdhN3v5T2ny1Ip89RIjyfwLgSaCsDPgUp5ZC8pAETatK?=
 =?us-ascii?Q?BtCR7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y+LVj36MuVFm+PZOIemLKGVuK3y6F1Pj1OZIlDtck4JaFzmO7JAaKkbu5ZCGBU6aYInFb0wbE5kz2HJjwCGlxodW3tNslhB0EPjESqMLSoetjdmtWUzPF4uBzijxrvFhPaXtfIkPd/8VHx8sjy5NIwnTOFfoRQjnfWXYipFOGUk7H6gV1rkggh2GAocpbYWuXJ8JmnotdD8wR2LP751L5nALu0yILScZlEgU7+BN+Rga1AvuRP0CiN00v6PViWlv5raScZx2grk9SdnlszECkIVi+b6XRHWDOHoZruMy26A/12+QWjx/TXFtqYk8LaorvKtQjqKr7YFGBwknfmJp8k20PQAQ0dYkrxgh6oIEqH7Vnn0yzhR2GmynaOnPTmmtC1RxbVrxJkyRqk8QAS7o8SlVY4E6Wk5QXYUSGAMEd+5N7JHlvre0x1lKXq6q3ZYkgcMNWAQplp0I8X8JImEkUFzlaUbRQ4gNKfgJZ7nE7XSX5avCvPvqSy1NgGSWVze+98eY4uNAxND1dBfOHiyl4ILgjT2zd2zHZTEJdAVc3DBXCb5UGfjYzttKGzxK4CWuuWL+YrLFlD6oQRxQnQzEVT/5VU29SfuTXdYGkU+Xv2A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c19032-f9ee-44b1-6c84-08dcaa4484e7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 11:50:44.6101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ulsz7+utLnZF9fbeUtpuYgL6V2KFO9emhAOH1mkj4yPXgeL5s8t/bEFc3l8dXEUJ4ukdjZ9fx4ut31TmAv1KV5Z4jx+YzVfcGOg/kK5OEBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7358
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-22_08,2024-07-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407220090
X-Proofpoint-GUID: vet1VF7cj619PQdCJn5PmL4zYrsdC3MF
X-Proofpoint-ORIG-GUID: vet1VF7cj619PQdCJn5PmL4zYrsdC3MF

The vma_shrink() and vma_expand() functions are internal VMA manipulation
functions which we ought to abstract for use outside of memory management
code.

To achieve this, we replace shift_arg_pages() in fs/exec.c with an
invocation of a new relocate_vma_down() function implemented in mm/mmap.c,
which enables us to also move move_page_tables() and vma_iter_prev_range()
to internal.h.

The purpose of doing this is to isolate key VMA manipulation functions in
order that we can both abstract them and later render them easily testable.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/exec.c          | 81 ++++------------------------------------------
 include/linux/mm.h | 17 +---------
 mm/internal.h      | 18 +++++++++++
 mm/mmap.c          | 81 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 91 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a47d0e4c54f6..2f67c1481e67 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -711,80 +711,6 @@ static int copy_strings_kernel(int argc, const char *const *argv,
 
 #ifdef CONFIG_MMU
 
-/*
- * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
- * the binfmt code determines where the new stack should reside, we shift it to
- * its final location.  The process proceeds as follows:
- *
- * 1) Use shift to calculate the new vma endpoints.
- * 2) Extend vma to cover both the old and new ranges.  This ensures the
- *    arguments passed to subsequent functions are consistent.
- * 3) Move vma's page tables to the new range.
- * 4) Free up any cleared pgd range.
- * 5) Shrink the vma to cover only the new range.
- */
-static int shift_arg_pages(struct vm_area_struct *vma, unsigned long shift)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	unsigned long old_start = vma->vm_start;
-	unsigned long old_end = vma->vm_end;
-	unsigned long length = old_end - old_start;
-	unsigned long new_start = old_start - shift;
-	unsigned long new_end = old_end - shift;
-	VMA_ITERATOR(vmi, mm, new_start);
-	struct vm_area_struct *next;
-	struct mmu_gather tlb;
-
-	BUG_ON(new_start > new_end);
-
-	/*
-	 * ensure there are no vmas between where we want to go
-	 * and where we are
-	 */
-	if (vma != vma_next(&vmi))
-		return -EFAULT;
-
-	vma_iter_prev_range(&vmi);
-	/*
-	 * cover the whole range: [new_start, old_end)
-	 */
-	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
-		return -ENOMEM;
-
-	/*
-	 * move the page tables downwards, on failure we rely on
-	 * process cleanup to remove whatever mess we made.
-	 */
-	if (length != move_page_tables(vma, old_start,
-				       vma, new_start, length, false, true))
-		return -ENOMEM;
-
-	lru_add_drain();
-	tlb_gather_mmu(&tlb, mm);
-	next = vma_next(&vmi);
-	if (new_end > old_start) {
-		/*
-		 * when the old and new regions overlap clear from new_end.
-		 */
-		free_pgd_range(&tlb, new_end, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	} else {
-		/*
-		 * otherwise, clean from old_start; this is done to not touch
-		 * the address space in [new_end, old_start) some architectures
-		 * have constraints on va-space that make this illegal (IA64) -
-		 * for the others its just a little faster.
-		 */
-		free_pgd_range(&tlb, old_start, old_end, new_end,
-			next ? next->vm_start : USER_PGTABLES_CEILING);
-	}
-	tlb_finish_mmu(&tlb);
-
-	vma_prev(&vmi);
-	/* Shrink the vma to just the new range */
-	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
-}
-
 /*
  * Finalizes the stack vm_area_struct. The flags and permissions are updated,
  * the stack is optionally relocated, and some extra space is added.
@@ -877,7 +803,12 @@ int setup_arg_pages(struct linux_binprm *bprm,
 
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
-		ret = shift_arg_pages(vma, stack_shift);
+		/*
+		 * During bprm_mm_init(), we create a temporary stack at STACK_TOP_MAX.  Once
+		 * the binfmt code determines where the new stack should reside, we shift it to
+		 * its final location.
+		 */
+		ret = relocate_vma_down(vma, stack_shift);
 		if (ret)
 			goto out_unlock;
 	}
diff --git a/include/linux/mm.h b/include/linux/mm.h
index f02532838f42..bb1d9de6fa81 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -998,12 +998,6 @@ static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
 	return mas_prev(&vmi->mas, 0);
 }
 
-static inline
-struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
-{
-	return mas_prev_range(&vmi->mas, 0);
-}
-
 static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
 {
 	return vmi->mas.index;
@@ -2523,11 +2517,6 @@ int set_page_dirty_lock(struct page *page);
 
 int get_cmdline(struct task_struct *task, char *buffer, int buflen);
 
-extern unsigned long move_page_tables(struct vm_area_struct *vma,
-		unsigned long old_addr, struct vm_area_struct *new_vma,
-		unsigned long new_addr, unsigned long len,
-		bool need_rmap_locks, bool for_stack);
-
 /*
  * Flags used by change_protection().  For now we make it a bitmap so
  * that we can pass in multiple flags just like parameters.  However
@@ -3273,11 +3262,6 @@ void anon_vma_interval_tree_verify(struct anon_vma_chain *node);
 
 /* mmap.c */
 extern int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin);
-extern int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		      unsigned long start, unsigned long end, pgoff_t pgoff,
-		      struct vm_area_struct *next);
-extern int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end, pgoff_t pgoff);
 extern struct anon_vma *find_mergeable_anon_vma(struct vm_area_struct *);
 extern int insert_vm_struct(struct mm_struct *, struct vm_area_struct *);
 extern void unlink_file_vma(struct vm_area_struct *);
@@ -3285,6 +3269,7 @@ extern struct vm_area_struct *copy_vma(struct vm_area_struct **,
 	unsigned long addr, unsigned long len, pgoff_t pgoff,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift);
 
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
diff --git a/mm/internal.h b/mm/internal.h
index 81564ce0f9e2..a4d0e98ccb97 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1305,6 +1305,12 @@ static inline struct vm_area_struct
 			  vma_policy(vma), new_ctx, anon_vma_name(vma));
 }
 
+int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	      unsigned long start, unsigned long end, pgoff_t pgoff,
+	      struct vm_area_struct *next);
+int vma_shrink(struct vma_iterator *vmi, struct vm_area_struct *vma,
+	       unsigned long start, unsigned long end, pgoff_t pgoff);
+
 enum {
 	/* mark page accessed */
 	FOLL_TOUCH = 1 << 16,
@@ -1528,6 +1534,12 @@ static inline int vma_iter_store_gfp(struct vma_iterator *vmi,
 	return 0;
 }
 
+static inline
+struct vm_area_struct *vma_iter_prev_range(struct vma_iterator *vmi)
+{
+	return mas_prev_range(&vmi->mas, 0);
+}
+
 /*
  * VMA lock generalization
  */
@@ -1639,4 +1651,10 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 
+/* mremap.c */
+unsigned long move_page_tables(struct vm_area_struct *vma,
+	unsigned long old_addr, struct vm_area_struct *new_vma,
+	unsigned long new_addr, unsigned long len,
+	bool need_rmap_locks, bool for_stack);
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/mmap.c b/mm/mmap.c
index e42d89f98071..c1567b8b2a0a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -4058,3 +4058,84 @@ static int __meminit init_reserve_notifier(void)
 	return 0;
 }
 subsys_initcall(init_reserve_notifier);
+
+/*
+ * Relocate a VMA downwards by shift bytes. There cannot be any VMAs between
+ * this VMA and its relocated range, which will now reside at [vma->vm_start -
+ * shift, vma->vm_end - shift).
+ *
+ * This function is almost certainly NOT what you want for anything other than
+ * early executable temporary stack relocation.
+ */
+int relocate_vma_down(struct vm_area_struct *vma, unsigned long shift)
+{
+	/*
+	 * The process proceeds as follows:
+	 *
+	 * 1) Use shift to calculate the new vma endpoints.
+	 * 2) Extend vma to cover both the old and new ranges.  This ensures the
+	 *    arguments passed to subsequent functions are consistent.
+	 * 3) Move vma's page tables to the new range.
+	 * 4) Free up any cleared pgd range.
+	 * 5) Shrink the vma to cover only the new range.
+	 */
+
+	struct mm_struct *mm = vma->vm_mm;
+	unsigned long old_start = vma->vm_start;
+	unsigned long old_end = vma->vm_end;
+	unsigned long length = old_end - old_start;
+	unsigned long new_start = old_start - shift;
+	unsigned long new_end = old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
+	struct mmu_gather tlb;
+
+	BUG_ON(new_start > new_end);
+
+	/*
+	 * ensure there are no vmas between where we want to go
+	 * and where we are
+	 */
+	if (vma != vma_next(&vmi))
+		return -EFAULT;
+
+	vma_iter_prev_range(&vmi);
+	/*
+	 * cover the whole range: [new_start, old_end)
+	 */
+	if (vma_expand(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
+		return -ENOMEM;
+
+	/*
+	 * move the page tables downwards, on failure we rely on
+	 * process cleanup to remove whatever mess we made.
+	 */
+	if (length != move_page_tables(vma, old_start,
+				       vma, new_start, length, false, true))
+		return -ENOMEM;
+
+	lru_add_drain();
+	tlb_gather_mmu(&tlb, mm);
+	next = vma_next(&vmi);
+	if (new_end > old_start) {
+		/*
+		 * when the old and new regions overlap clear from new_end.
+		 */
+		free_pgd_range(&tlb, new_end, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	} else {
+		/*
+		 * otherwise, clean from old_start; this is done to not touch
+		 * the address space in [new_end, old_start) some architectures
+		 * have constraints on va-space that make this illegal (IA64) -
+		 * for the others its just a little faster.
+		 */
+		free_pgd_range(&tlb, old_start, old_end, new_end,
+			next ? next->vm_start : USER_PGTABLES_CEILING);
+	}
+	tlb_finish_mmu(&tlb);
+
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_shrink(&vmi, vma, new_start, new_end, vma->vm_pgoff);
+}
-- 
2.45.2


