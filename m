Return-Path: <linux-fsdevel+bounces-54622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA01B01AB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C38395A2FED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394F728F50F;
	Fri, 11 Jul 2025 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SVLtIJBJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y5CO2VY+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D702528C016;
	Fri, 11 Jul 2025 11:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752233993; cv=fail; b=HGZoAutTEDesC5h+Fp2xnOrDaWSCFRToCe2tQHUMSbZB4K0h4/6rrwsAebFd1OZW/KmEvnjNQrwZSNqqsD3kdafRMbxRSqA4hNqV3fts4t+pkkOBpKg9AS/4saXgzH5ygCUICTznK8+64mi02n+HBMePIQW5YmlAkUcwCwkcjs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752233993; c=relaxed/simple;
	bh=cisWzDU2iFtIt6FUQ1W1YvM+txcg7SRqIjlmvnJPMls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltqoUD8iNthrCmrR9kgqOXrSVAgrvaiRPUT06PfMFa/oe5hA3Q3fuCDmFqZXWXDYrJCiuSea0toXV+xQjp7Cq6lFCHXJZhX86pmuF586eb3Z83Gs18WKuoI+mYz12UpTZn7wU7OKDP9H6WilRDEVtHR4ZCInm+jCDLec+IUqXq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SVLtIJBJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y5CO2VY+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BBbiDT015146;
	Fri, 11 Jul 2025 11:38:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=vUjSEGUcC79WeBi6shJU5SuFdmA3I9hHcZUIsxE30AY=; b=
	SVLtIJBJawrNRzkBwGdkfRwfuksH759dNoq6D5/5Blx2l2rsQmVvDtdgSUHa8vOa
	IpRiy195m4SyxUFoJBHhEdR8SeD0Qut7YJFkE5yxKO5/Qu3V2wL/2XbtcV/JV9Ni
	j6RJRH+g6RPeMnI2u4o79+jRgTyfLSRt8YFxCPwHPUMD8e0VFzKKw3fAP9F9GeC7
	FOkws9XkNL7LoptCNp3+8QhV6Pkak+9xxISn+sPud6Y53IL8T89su0JDIRcpPzW+
	wWLR3c2iQ7ZAr+6s4FTUlZXgG8n7FktxTvjZ3z7+tPfftreqMeNaAVvuRKRcugID
	HuBLXKecAoqz2tNIdhkoKA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1w1g01s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9VEPw040420;
	Fri, 11 Jul 2025 11:38:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdpjtw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWR7A3YuoSz5rcTDyWvADSEq79oS5/GlFp/p7pFFE8lF7o7Om82Wt0rEblzfQI941z/0VL19L6Yl/Z3qZmRwUxv/YxFbttK06NhJll+nIRjZRFi8/BGwUBjvZ7IiSUOzRsTup7LKNkSSuFV1j3v7Hq1YOEYRtG5bW4HmUT/56iVfHOWqmSea1mGjQ4ZOdw/iqEasvnC63OeU92nWlMJ8JIE8Y559TDW2S1dp55egOq9Kup0TyHF/amMZhp45sVDQ4m0N36xqJgVKHC1CVQUVQu5t5l0yijZ9zRkBo/f3PgG3ajxknSwCWG4/q4YWNQdTnIb4ckwvaYLCtD2Kg+LSgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vUjSEGUcC79WeBi6shJU5SuFdmA3I9hHcZUIsxE30AY=;
 b=HFFoppcjBVKDR6bwjtFk2hJwm+CjaQE6fW/9Da4sy0kae3H+8up/My6s9QJJoSVbzQDBTO1qFTm66NOvimZI8l6QWasp0KV3AYsJIVG46SeGemxXXCpu2e+WJq8lXs4enPkkM2IetsxNLWra0WVVUxygFt/qrChPQdXF1cMCcsU1aQVWrb2O0ccntAlziB0haGBDiNKvgIjefc4hOa3YbddrVyXmIK4TM52s3xmPtwtPQhSdkmmYNczF9dnMbY7PJwEBVMBMaV1g/UFNcD97XK2muVu+W4yFp1Hthv6wOWmkRTR851B1u/gBgMjsfq8bhtOOyFhNFfq0hUij+Ek3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vUjSEGUcC79WeBi6shJU5SuFdmA3I9hHcZUIsxE30AY=;
 b=y5CO2VY+QyUdselgUiNdVBzSigBT9L0UT9d+r9eNRg0mXZf8XcZN+z83KWqzZYy++byV6nGZKa7kSLroGhC/bKvAC5PHcPPa9FqH0skDk2HtQKhAFJP4UzayiPC+l0fZMoUILRi20DmHx0IvyL1el8CwbkevqcLPW+NH1lXivGw=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by BN0PR10MB5174.namprd10.prod.outlook.com (2603:10b6:408:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 11:38:34 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:34 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 01/10] mm/mremap: perform some simple cleanups
Date: Fri, 11 Jul 2025 12:38:15 +0100
Message-ID: <e123452fec4eca6592d97f55f37af30416e46e38.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|BN0PR10MB5174:EE_
X-MS-Office365-Filtering-Correlation-Id: 50eb3ce5-f387-4df0-8343-08ddc06f77bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MjONIqqwwb+tYcLNXvjrLl/kOOTfvQWp5FAn7PAUTft+q6Of3sYS+4pIrvCt?=
 =?us-ascii?Q?LS/dTWjC4lzBJepLOtDwlersjwr+uuCsB2C/g6NB3v45SbT+qOxOxvKIelQE?=
 =?us-ascii?Q?/HRi7Bwl9wy85b61TvwVAEBeucKVfvQl/0pdIzhBDf0RnP3X8D0DfXQb/2GR?=
 =?us-ascii?Q?Qb1oNEEn+ijwWrVW7Ldtrwlas9uZxinYiBVuZicLMJMf5pkt94VxK215jes2?=
 =?us-ascii?Q?X+7vVAq95FdMDcV9tmspUrsydRBJZGrUtlLB+UERxv24U2QcZM7o3JdicwIt?=
 =?us-ascii?Q?mE5CoQTXRfxjLbvpxorqTlgjknbnnWSF5mqPmNbq2Aw32O4/994cFLMX4SwW?=
 =?us-ascii?Q?ms2mJ9QWO075TFGeAQkLkTZQEW9uey5+Af2rIBlEcHunDAavfAgTKqk/7pNa?=
 =?us-ascii?Q?2N1sAP4Y5jGS1jXzRdB9fVgSB9qU+4Nn1mUXePJTB7A/Wc5oH0UcrSKigNO/?=
 =?us-ascii?Q?dKs1QFS19X9On9hnSscvA9qSB4BwYKpr/+1BaKV948hxRYpE9pguZjJrIqQU?=
 =?us-ascii?Q?K4Vm136I1cAQRzqWI0eh94G25IcN1m3t5eUag2suA8E3CzYvnr8M+iJ50AD5?=
 =?us-ascii?Q?EHbvF4vMoL6P+dj9MKGDj4KcgKbiYg/yeM9/UWpZ5UH6DZiX+R3HiHXS6s3J?=
 =?us-ascii?Q?64UgUNu2V+upQ9zrGRqXjIWqP9t9AdMfGBgGbBQxdZ/HH+IyZvfR/46RRgS4?=
 =?us-ascii?Q?KZx+c9tYR14YoCrcnnaHmWq4I14o85M0lM4py+xAp2jJOyonTn1SzuPi8e0a?=
 =?us-ascii?Q?W4+wmjHVF2C8CdUpwynhWYcEdVR583O39PmfoM8NFzE16J5MI8wnlGG0Y1C8?=
 =?us-ascii?Q?mfDmmb0238o6FpCXwcfSmERLFHi4S40+38eA3dKlTaNXkQPXMcO6ZKzOS6Bw?=
 =?us-ascii?Q?yYRRVc8bIlACvA6RTi4QO2dWMpKzA9Mu/hGkjnhQlkA5W0HGszcSfYKj0wZ8?=
 =?us-ascii?Q?nqIzVB4mT6eAqfDc9vAfRlOtbFTRGd6z721Xm6gv09xQZd/AYvpVdJVJg4iG?=
 =?us-ascii?Q?PEdi4xdbhR4iS2K0ntp7oC/zHH0UjvqAxzW88UPJ0Tgh+sv7Hd0v7ec3a7yq?=
 =?us-ascii?Q?kdNlNNH+prt/W64I2cSS5XWkHWRt0YJfRJApuDp+irLDhHPDpFIpSRbg/r9p?=
 =?us-ascii?Q?5ACmRLK2qDmFVi5T8W/mImLHoZp7fg1Q10wjaSuVb8XFKq3pa1BsUu8p111q?=
 =?us-ascii?Q?rm/5IMevMxi6nrJDJfLROpYI22AQeVKBdgpaOZHLOS+lVC9VO5F4mR7rFmGl?=
 =?us-ascii?Q?nl3M7HqVNWOQWJu0tFCh5bhfrzfT2+8YqE16kcQpDDHJmluNWH+LqOi/dvFe?=
 =?us-ascii?Q?klt+MJg/84nc3phjc+AfJPTeTuTluED7Z8GJtetxag6Il/WjQOg2NFCIyNDh?=
 =?us-ascii?Q?30SpeZerOg8vkb5RDNbT/POZDgflI03Y+HXqCNprcJWl5xHWQ5XJ1SP5n9Ho?=
 =?us-ascii?Q?aah2cWiM3hM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LZfZg5Mki8zvdaUK1SQ1+gE/efkY0O+cypwdOSFCPvXAhpv/0B98RhnL2dXn?=
 =?us-ascii?Q?9gGdmQnC8v0cBNhsPr0eKtYJuNES7+EE7LXMn04jSlKRbD/FW47TMdX4PLUP?=
 =?us-ascii?Q?YSSXBabLTwb1HT5oeBHzH6czCwARpPMMKrQSD5ENqGG/VYN74LXM/2JCh02S?=
 =?us-ascii?Q?brziGnPKDZQsGcRkoZM1h9vC/D9RFc0Pwk4gsTb9Yt5iJZ9YSUMRoQL3DcdJ?=
 =?us-ascii?Q?jPiSamKRoSUFQLCIw3ofcpW5860rqW6rf2rgGd7E7lUs5wq7CxvQfjf8w+Py?=
 =?us-ascii?Q?GajVkFSjfW+MhlX1azNT7NLizdR1lzZIegY/iP5iZfX+cbNwFG6eY4IQV7D5?=
 =?us-ascii?Q?IESuUiC+U41OfuVb3EtNSELJ7flSFSJ/1XSrVqoQb2I5vZ7IZ1Topffaa0ZN?=
 =?us-ascii?Q?05wjW6MYkXaj6mHpKY5DxP2CauWi+LdUijUOrgFq47UD3Bjx69/X7NYfFImV?=
 =?us-ascii?Q?/FwkM32Wkyqojyjg8k2OH3bdfdfnpDuFv+gDWg2mq5QyQk4lANKH09EzEQjA?=
 =?us-ascii?Q?Dywaz3+6RpbdRU2jtQ+rwL6PeX13YhXuUpJcuvluFvjSKv2iz++38SqQPNmt?=
 =?us-ascii?Q?FAk9w6mXMCEsATTLxoGw3GRwNTqx5xVTDJ1Bw/p4qtEef5gN8bqe+8Hfdrrw?=
 =?us-ascii?Q?AM+fWWekB5zTcRxR4boX958emgMKMAJE1VRAG6HrYbHaV+RyADmXI2+f0xxF?=
 =?us-ascii?Q?V0rvJo7EbrZEsBEo/jBrBdvRX1fBCJgvhDF/3bIJYec9/ypaQ3+oCHLm3Z7T?=
 =?us-ascii?Q?/ZXmMkU0MsXPsYzJFAHQs9RP6HZAomRLhY8NHz7kMIOlpA95T+Hj4qC9++HM?=
 =?us-ascii?Q?W12MZljqUnzLOpZMfRnKQVlUtfIeDGTAk4pYe457+mJ9GxohaTKLmWYahi0d?=
 =?us-ascii?Q?87264XIlEepntXPchyvVBWEy5SUV5621AopTzA3ejfNgWi5CLEieVpX1SSkY?=
 =?us-ascii?Q?ZfwLIKaDEF2TCzaIhuee7/UzpZKEJ+167vZYW9qMn3eJGqz5cNDxIAruKysd?=
 =?us-ascii?Q?lcL3qBBlei+KEX5y9DkcojM6nQnJngrZD23gDvyc0KvE4CilIbU3GUOXxCJZ?=
 =?us-ascii?Q?D+D9rzj2lHWrt062I2bKU3zt+DwOh1aKMaNZb8iP3MXMZPI26LjKLipUw6rh?=
 =?us-ascii?Q?RdoY6Se5t5nnLjdl5uAP4qSW1VN1WrKvfVIT4GZWqdaUqbw5lXVmyQGMabpg?=
 =?us-ascii?Q?/5+zt2FaSNhixSytVAVKiZ0XELevDGzotKiBTfz4fS3jJ4QqIk4rL5JIPxme?=
 =?us-ascii?Q?WSxTL5q/bhYhOBiUQ4KPxOhXamS1fHftOW6RLcGF1KeJgqz2tiyDds6CS1KJ?=
 =?us-ascii?Q?vqdmXWDY1bUoDuvu7Er7l3fCpjRa5LhIiI4v4NUHVpP1kCKylTipJ/OtkrUd?=
 =?us-ascii?Q?DjvbgKWVwY2jVyTaTHItfgJwblUgRnqEt4CvxSBLHg7DWjMNVdjirhuc2ffI?=
 =?us-ascii?Q?77v4boPdT0fUgQ6FTP9hSV1vL3gh+y3MfHidNNfpI9zqh5/WQBYamWdq8NQp?=
 =?us-ascii?Q?NPJT6XNtVYP5+hMLuCylbpt0Q+yd8nRde/HhZGQ6k8lbH6rnAwmOSQmsA/xT?=
 =?us-ascii?Q?BeO8cXttxSsqXR18GzE6mdnouxZSu3NsUDFEQeHiOfjLIIipIBq6ODRfDXD8?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xiRh69dbkICCfmyRSaOVXLeywgZm+DtwqFlTqCeIUQ86bs/MubbArazojaVCob2V9P4kwqXOv75yCTtR6zOkLSDz03r09bFeyBPucwrGMq8BkG3K+4cVle6s5IOyUu8P6lNZmeLQOPkg0wMbaJNJTLzi0AL211FA28N4PHPa7nBd2n8lxt1SYv1zFZ+1FdydJWFsKRe/fCi/Vr2qKkW5jdYbNRYzFWvP2AdPwdmvyv2Mg3pleCXij3Do4OdBpEODrozXKQHcrLMK9uFwhMpIQZB0VN6dRfC8TOvV9t2qjD2nkkfIOeRooxwQde7GnQFTA+TJWDM/mZXVSOJLIMqCvlqu7WjAvi01WyG5sMNxlp6fY9XZKLiw0koS6wMvvfutcxXbWee9SGPa6GfrBI0akkz6WET+cIyGnACCqe3xeKO8glLDv88FsL2ZYsKtv4a77WrtukBjRKdttEbDFyV+tbPWTFZzgDh+5jDgimw+xckghXK08VGC7GmtO/Jbg36+KU960nyni6J2qCSoTac/w7jstr5swM5U0dMn9scG0EOr907hh4NKAYNxdd8wE5MvsWPYvPy+nEUrabFzfvDkwjhqvmKuYhdXbPSlTxpzcxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50eb3ce5-f387-4df0-8343-08ddc06f77bf
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:33.9902
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x+kqLchUEJFb9lVtzGegjfDgayMbavGyJQz279G4UFOLKzQpzAmkWlEOJHetdN6MtoAERTay2fIx2hLdXKxgpL7TPNdz0b/zHtGieYRJljA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfXx+2EnxQ0TyVK YVf+3lXYD6NFLUMxkwEAJ8zh1m2b/0lad+USWgTRj2Lv6g2StP/qYOTmEbYXLAxkNJjWZiffP0g pZbbAdHOLgvKBbB3GfV0o4Mp+2JZ6UFaaQmI1wffFonZInPndRDPN1JGKzjGVIGPnEW6KcMyzuB
 rp2TMSHhyh3KJp5vgBbNRpFSaKpbeTZCJocgiHiFT3X0iETA19j53n0CHH2ZWIBugLExsGOmEet SwlLo/8HkP1PpXU7Eu8nGb8EWfe8neGfqT6QXCQdyNwD0iDoVoaQXvL7d0R6kSO7vg5SV4bjlGH /nc1eRViQEGC0Dhkuv9N621Q4sgFWb0BHwCc04k0Qkdiyi7eIA/C0HABdXKUnMXYmtGKqpru9L6
 sYeesTJtZDaMDCww93XjOnAZJFzpOavcLUGi0Eztr+XzGZe81MMtFUynOXca/CLZWCXAL+e3
X-Proofpoint-GUID: HEaPUbU6c33VxHQuf9B_enGQdzhzZ5SI
X-Authority-Analysis: v=2.4 cv=FsIF/3rq c=1 sm=1 tr=0 ts=6870f7bc cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=-y-8OK93jEFqfRmHsx8A:9
X-Proofpoint-ORIG-GUID: HEaPUbU6c33VxHQuf9B_enGQdzhzZ5SI

We const-ify the vrm flags parameter to indicate this will never change.

We rename resize_is_valid() to remap_is_valid(), as this function does not
only apply to cases where we resize, so it's simply confusing to refer to
that here.

We remove the BUG() from mremap_at(), as we should not BUG() unless we are
certain it'll result in system instability.

We rename vrm_charge() to vrm_calc_charge() to make it clear this simply
calculates the charged number of pages rather than actually adjusting any
state.

We update the comment for vrm_implies_new_addr() to explain that
MREMAP_DONTUNMAP does not require a set address, but will always be moved.

Additionally consistently use 'res' rather than 'ret' for result values.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 55 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 23 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 36585041c760..1815095c4bca 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -52,7 +52,7 @@ struct vma_remap_struct {
 	unsigned long addr;	/* User-specified address from which we remap. */
 	unsigned long old_len;	/* Length of range being remapped. */
 	unsigned long new_len;	/* Desired new length of mapping. */
-	unsigned long flags;	/* user-specified MREMAP_* flags. */
+	const unsigned long flags; /* user-specified MREMAP_* flags. */
 	unsigned long new_addr;	/* Optionally, desired new address. */
 
 	/* uffd state. */
@@ -911,7 +911,11 @@ static bool vrm_overlaps(struct vma_remap_struct *vrm)
 	return false;
 }
 
-/* Do the mremap() flags require that the new_addr parameter be specified? */
+/*
+ * Will a new address definitely be assigned? This either if the user specifies
+ * it via MREMAP_FIXED, or if MREMAP_DONTUNMAP is used, indicating we will
+ * always detemrine a target address.
+ */
 static bool vrm_implies_new_addr(struct vma_remap_struct *vrm)
 {
 	return vrm->flags & (MREMAP_FIXED | MREMAP_DONTUNMAP);
@@ -957,7 +961,7 @@ static unsigned long vrm_set_new_addr(struct vma_remap_struct *vrm)
  *
  * Returns true on success, false if insufficient memory to charge.
  */
-static bool vrm_charge(struct vma_remap_struct *vrm)
+static bool vrm_calc_charge(struct vma_remap_struct *vrm)
 {
 	unsigned long charged;
 
@@ -1262,8 +1266,11 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 	if (err)
 		return err;
 
-	/* If accounted, charge the number of bytes the operation will use. */
-	if (!vrm_charge(vrm))
+	/*
+	 * If accounted, determine the number of bytes the operation will
+	 * charge.
+	 */
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/* We don't want racing faults. */
@@ -1302,12 +1309,12 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
 }
 
 /*
- * resize_is_valid() - Ensure the vma can be resized to the new length at the give
- * address.
+ * remap_is_valid() - Ensure the VMA can be moved or resized to the new length,
+ * at the given address.
  *
  * Return 0 on success, error otherwise.
  */
-static int resize_is_valid(struct vma_remap_struct *vrm)
+static int remap_is_valid(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = vrm->vma;
@@ -1446,7 +1453,7 @@ static unsigned long mremap_to(struct vma_remap_struct *vrm)
 		vrm->old_len = vrm->new_len;
 	}
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1571,7 +1578,7 @@ static unsigned long expand_vma_in_place(struct vma_remap_struct *vrm)
 	struct vm_area_struct *vma = vrm->vma;
 	VMA_ITERATOR(vmi, mm, vma->vm_end);
 
-	if (!vrm_charge(vrm))
+	if (!vrm_calc_charge(vrm))
 		return -ENOMEM;
 
 	/*
@@ -1632,7 +1639,7 @@ static unsigned long expand_vma(struct vma_remap_struct *vrm)
 	unsigned long err;
 	unsigned long addr = vrm->addr;
 
-	err = resize_is_valid(vrm);
+	err = remap_is_valid(vrm);
 	if (err)
 		return err;
 
@@ -1705,18 +1712,20 @@ static unsigned long mremap_at(struct vma_remap_struct *vrm)
 		return expand_vma(vrm);
 	}
 
-	BUG();
+	/* Should not be possible. */
+	WARN_ON_ONCE(1);
+	return -EINVAL;
 }
 
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long ret;
+	unsigned long res;
 
-	ret = check_mremap_params(vrm);
-	if (ret)
-		return ret;
+	res = check_mremap_params(vrm);
+	if (res)
+		return res;
 
 	vrm->old_len = PAGE_ALIGN(vrm->old_len);
 	vrm->new_len = PAGE_ALIGN(vrm->new_len);
@@ -1728,41 +1737,41 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 
 	vma = vrm->vma = vma_lookup(mm, vrm->addr);
 	if (!vma) {
-		ret = -EFAULT;
+		res = -EFAULT;
 		goto out;
 	}
 
 	/* If mseal()'d, mremap() is prohibited. */
 	if (!can_modify_vma(vma)) {
-		ret = -EPERM;
+		res = -EPERM;
 		goto out;
 	}
 
 	/* Align to hugetlb page size, if required. */
 	if (is_vm_hugetlb_page(vma) && !align_hugetlb(vrm)) {
-		ret = -EINVAL;
+		res = -EINVAL;
 		goto out;
 	}
 
 	vrm->remap_type = vrm_remap_type(vrm);
 
 	/* Actually execute mremap. */
-	ret = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
+	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
 	if (vrm->mmap_locked) {
 		mmap_write_unlock(mm);
 		vrm->mmap_locked = false;
 
-		if (!offset_in_page(ret) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
 			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 	}
 
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, ret, vrm->old_len);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
 	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
 
-	return ret;
+	return res;
 }
 
 /*
-- 
2.50.0


