Return-Path: <linux-fsdevel+bounces-47837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8121FAA61AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 18:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCE9D4A567D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 May 2025 16:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5816721B9F2;
	Thu,  1 May 2025 16:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SSgSqGgq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="x3J8mCOA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0FF211276;
	Thu,  1 May 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746118686; cv=fail; b=GwIoUIJOGpsgA0J/9qDj/+1j6he3BH6+XlDory61uJlQliUZAgzD7cickGpPdj/7RRVCCUkBTSZ2jNc4Dk9mKiuZSbzeI6QBKfaJk7kvBKsRpUJQU0wC1El47Fxr92F5dPdo3kR25OrF9Bsi4mUPd7bTpMJeovsYhAPaWNMjdU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746118686; c=relaxed/simple;
	bh=wm7rSgXjAJHQhi8ehc1aU3KcZ144tJmRrGCHWg7nJCQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xd+kuaJaG7J0wqJ3Ue5BGfGbCYnvyHnzuJ/DGYJw9UKfoFmEMcotCBvqzdaN7JlEgb+thILTY1MASU5lPYCNPKML8FWZqC60Td5V6O/b/MO0fpGSgifPJuShdkxoziObZkjvsrKbWcdWHlqzddRJjqrCuORQDakEJ9OlpU8bh/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SSgSqGgq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=x3J8mCOA; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 541Gk2Im024252;
	Thu, 1 May 2025 16:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=; b=
	SSgSqGgqRMF0iruPpyDlB04A1pMx54883ZtEk+jAqIP6eik9OAhx5AXuKzrhJocm
	1LwjiRx7lu04h83cjk+ow5Htvtd19CFskWYtbq72ElpiPHgzyYbEv+Yd1TkTuj3x
	Anlox3Eqg6AJBrwZfYd4iRwWpABzib6WJCl0HucNNLAWCekROsKscaqZUXkoPHo5
	ivCEke1PM3tjrB+2carARiO450PhfQQbZ/esISTmMaRgtooKAkuFO8OQ0X4qBF9w
	gBXs9bQ4BINQ0OzfUTfUeK9VuRqOO0DUt9vZ2c+OU4CZCKaxSvA454wszZuysJ2c
	5cbJAQU3vIIWt8F4OhLYHw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6utbfac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:57:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 541GG972023752;
	Thu, 1 May 2025 16:57:51 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011024.outbound.protection.outlook.com [40.93.14.24])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxk0qyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 16:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SLHt465iQrTiso5oDR1bB0WS2W8hUDU7P/mDx8o0QCIkUmvaS6fZZxCMtsKnV+3FXMx5chQhD+0pRfoqIQJQ951ZiycNSz/ITL8cCTggteXhy8488e3+DLBq79CFrj2V3S/wC2tpDpE99tjr4OhSfKaClMZrlWfyh+BXYe3y7n/UG0xw9GiT3aRqcDjLLUhO+YbZMOhRIhREBX8dFWCGo+uy+MkEpQfVem8zzEU4sSJsMKDXrK5S/PFaPfBBIySu4fjyE8XIx41x32UWt9X8uDDap+HABdI0lF7lpRfzAIykoSaMYe0YRHs5ymD7Y+ZUWff2ogPTroV5ltmAwNS1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=;
 b=rmZOzf13k+QDQM5OETWvhxNiJe9ZMSKHYrznvRVXPaBOEl4SGU+dhJQP7/eVFiJ8GYGY80EqD/+0hsQa265LqHXrAOILt6X1PuPJhgaI0CclHt3KjJ/APDKCP60iHjylZVLq1e7f4jw8P/u1vjnOvnt3rW6Gzzt0uJI1fathd8zAg+/dlPhvWcRQW+lnTRvkOhTjayE88dxpcBIO7YGEHFyHJhIyoQNNLK/PUolEKby00sxFSmlKLswg+C61QIJhg0R0c6q+pSW+htG2tAYjDhHHOL11N3m/cW3lyMNXNSEguQrUhzKW7iRHZLvrgVPDg4XOvisK4kOiV6XZfhEDTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBdxx6TL6c/ibAyxGBc81pYFfbStco1TPCLf4whYrW4=;
 b=x3J8mCOAVLyZ5SherEx/3Jor4DZG6ndJqpykil+xBf/xXYaGZpPiNKjReMyKlLxL57kPDMIYQuCo0yB0kTS3FAXL6xJp2h7IBI8fTjBoKNimcswhnmEMOocRKqnZqMSVwt8OhzVRImKLVGWWNjQ6PY1wuXRGmhvqIYBEx2KtpKA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6040.namprd10.prod.outlook.com (2603:10b6:8:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.35; Thu, 1 May
 2025 16:57:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8699.022; Thu, 1 May 2025
 16:57:49 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v10 02/15] xfs: add helpers to compute log item overhead
Date: Thu,  1 May 2025 16:57:20 +0000
Message-Id: <20250501165733.1025207-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250501165733.1025207-1-john.g.garry@oracle.com>
References: <20250501165733.1025207-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6040:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9c6dc3-319a-40ef-b000-08dd88d14d9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kSWhr8AJ386CMo91gswcp28VT2ckUOBajJRinmI77cSDnRSfXg4BSv2UfZYF?=
 =?us-ascii?Q?JlCMy730IjRdY8EKnoGBi6GW8+b+ydqjxalAMYO9n8oP4yiYv17duXIa2j2M?=
 =?us-ascii?Q?99WpAlnSpLFXK6NWC3/mdXQp5TCdj1ECc4/Z/uftnPLDkcXxwiRK8EZfTiTl?=
 =?us-ascii?Q?IgjPVkba8Dk7zKgsMhcYtEJV+tJwMW2XwA99tT3JPbUz9e/3xOYRtNXi5G2l?=
 =?us-ascii?Q?s8+dxwvaPukECmDNJWlnUXn4mxMXv9i2gyADHm7eiycQ9JyGRvS68UbAJuIQ?=
 =?us-ascii?Q?A4elwsR2gaAH+c9fFVtcbNSMnPawdkbrSzFcD8vg8dPr4f5t9Op4E+25Nnno?=
 =?us-ascii?Q?VaE8IBGxNIzvpNrnuL5SONSvPEuy4K16NkWRG2BAiBUt3dqJE+oKj/8Gkwjq?=
 =?us-ascii?Q?xosgShFuCvxXU/YA4I1ckdp1Ql2xcA2ExGlebrDoMwuuKf79O28G+tELkDah?=
 =?us-ascii?Q?OPWZf/w2HjBQTYPZaMDq7JVZofcTu6K3fa7uWzwnJLESiAmYDdEBUBXBSyX3?=
 =?us-ascii?Q?qOlWxJGyuiadJqJy4mN0kYZ+7VZJh0QzKrNqzHNap/gMYEtvahhbMElnweFq?=
 =?us-ascii?Q?e0cEkttlgvgIO8UkvRiq/Wqd9z6fQwGr6JxeftOk32TXzF0vYORt9hFDQZgM?=
 =?us-ascii?Q?99ozgQFU7fqJmr23y0Ua1SdSdNDc+slzHiIBf/NPD8r71ilFgXv1pAvOxSvf?=
 =?us-ascii?Q?JMjlfDlFLCbaE/JviETU6QNevVCNrE7Ljo3ZX65sB14GBGGWR7c/ZRGxhZvQ?=
 =?us-ascii?Q?Sb3C5iXKiR1Rt26G6YGhkQjwg/jcTgJBZUZ85H0odgolYlja9csmT4NKmCFE?=
 =?us-ascii?Q?jRHRl2RbxObQfbf1OUtGdmWjkIV5hxgWgXzssGO0olyWUk7UNsO7qBTPEtJV?=
 =?us-ascii?Q?K4/tez340ToWpSHhbtbMdaqXT6ImRXWTiaT8c5e+pmABPQjY/gbu7z35MSjM?=
 =?us-ascii?Q?CENSPb3LPRIITdxCbQgQNC8AVfZX0VNMaHrAbG1Sk5ZatUwT/LMj2fnrRE7W?=
 =?us-ascii?Q?wMndB4k7LB3uLekf7t4a1CrLxdQjWR7DG2M0w2MAruhsiXA9lxstKtHrpudj?=
 =?us-ascii?Q?oUdfJMIalz85uVIdAr+yn0CcT/AXuYjuRmk0jeZ61td6KUFxZ/tY47VHtFih?=
 =?us-ascii?Q?nDp94HaeO30uBzhnj6tsJdhvRcd0bv7eihCah2FTK/JhAlTIGJz/hkTly5tC?=
 =?us-ascii?Q?i8b4KA5H8CxMyPhGD7y4cho3InQdGy31Mb2lEDwgWgXQErRSN7ThFIbd2N5U?=
 =?us-ascii?Q?k/p6UfEAAuCOM+EEnpG5mWoQxFdh7T7cTJxamvi24zd8J3A4Jn73nws96D4e?=
 =?us-ascii?Q?iNZhZfwdT3mwcbVOq3Nstp6ZpEX2tl7HEw2vWbOsZ369vgiVi6IjObeqfaq5?=
 =?us-ascii?Q?HwdBZYJQJLeAtOOHEEMASJPU35+Ght8d4zMyc560hqkoc/b7CTt803ZxSo9m?=
 =?us-ascii?Q?8lnq9b8q9fc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hChoMgfzltUf9scQzB9Gvx40N481We3ZgkO+Ll9DH3q9mBDA8/Iu0PF27tmI?=
 =?us-ascii?Q?g8wPzg/uU4Zip/sO+JofP02E/Ndk2mAOC1I2829O7v2NkWoADhwZgUjl6EWf?=
 =?us-ascii?Q?RjOjnHMle3HQOqTVSL2MagmORDit2cfBhfbAKzXkEzCvy+0pipj2uVAkdoFw?=
 =?us-ascii?Q?BB1HOW7WohIcVhP4e0Zjm/FLmf1VdGFUo6RV2TFOMFIRDmsXEMuWT+WpkG7S?=
 =?us-ascii?Q?KJyBCdCPhF/0OyaF0RLOjUrM+q1fpsaEtGazZL17wIkU4SReDeO0ZpszzEdI?=
 =?us-ascii?Q?4LwO8Bzb1bxVcG9E0heqz+iSuRchlOVhJ27yyQKbEF9GR7LiwIS6hBgkrRJC?=
 =?us-ascii?Q?Kv4hRZG1RgPnCr/DoSooevYwnz0Fu/EMtSG2RRwfekQP1sOmlzlSoVwQrkol?=
 =?us-ascii?Q?WI581ltQsx9GxEdrqK3j2vl327/w7yftvgrv9pG4UerpvDuKWq0jH4j5Z6FU?=
 =?us-ascii?Q?jxqFdnftx00s+QLcycn0nEewLCDIreDye0Sqjpi773gKcC+Lq7l5vRiwRRKA?=
 =?us-ascii?Q?/fJm5FzVhLGU+Az/ss02gPeP5+HxpTp1GWzyNtlzBrmSzPKpC8O8UbX9/gGD?=
 =?us-ascii?Q?x4gsqIA28p3EaD34FLWozfH0xWR0SXbtsKVpFMsI1xp6eZ9mLLTSl+ayp2fu?=
 =?us-ascii?Q?/OPo6lY1edqt2u1TNe3CsAhrCKJRy8wGzFZei2RBgW4SM4AZu+pSvUnFGeIA?=
 =?us-ascii?Q?SvIIhBjWg4BrfQlpGFrTHRx8hYfT7m7yoGBPpHwWYVhhJVeNpxmz61X+49cF?=
 =?us-ascii?Q?E2es31oc3V3UzIx1BBVrI/RFooF0/PQKkqNTFDv4AwMJ1w4w6R5Sq7Lblqbw?=
 =?us-ascii?Q?UnhuVPqLP5v8OHnCFf1OTDLiVzgRKjdiOIdZf8vDU04V+H57NLYVdMDMZdNu?=
 =?us-ascii?Q?rn+O+3Xw5pTX69DRJajjWDzBX3EB/R9csdBe3T955evv07w7Z4+NI7oNYG+o?=
 =?us-ascii?Q?dQBrlFF75r6e9wqcq2q1itsQwKd9WkUHp380visvvVO2K1G5iyxVSx8AfLZC?=
 =?us-ascii?Q?AJaeiB4TBthqPVH7t0fLMziUz7lHHwLFg2zLEdzqTeipcgxE0tfshf6kCwlG?=
 =?us-ascii?Q?7FLR/4CS0GTKwhFuA4gLV6K0EvVbujZXHDHUwHHuDVwT+ZZpG40m07ReQZbo?=
 =?us-ascii?Q?EL3OxqE9H8l2pKrLD5+4cq17E7iAeN5zWH8Fw6O/SyheBhlTA2NPURqwOo5F?=
 =?us-ascii?Q?bzG0FA9WHvoApRsSq+eIhiT9TT04GvM/6cVr1S7RYqoBLeyMNy/5s93tzGkq?=
 =?us-ascii?Q?5SSdDbKv2BZkGRFH789jHm1EnHKvQH62EBLUhxDxdFLzGkVwB/rvtYvc5b9k?=
 =?us-ascii?Q?02b1k8eoAX4HkWkg1nM5R56Dr099mbl8oLjjnApe9ol0fFQL+xvq81Rk9M8i?=
 =?us-ascii?Q?fBywvxfvDewp4h4SyB23M+q9Ei91/lQKLyNX+VxM3n5hiErixVa6a1rMfZ2H?=
 =?us-ascii?Q?Am6n2oxckdpYNVR+6O6QA337WVFhVWvSB+8zMdLjGZzcgQyt0/vuB6lCTKaT?=
 =?us-ascii?Q?jnuB5l7xHP1SbCu1cjk9WOpPT6HnVOHKDSNV6C8VhW2CimpU40L/Rmx3gOkG?=
 =?us-ascii?Q?HOPGivNAZh6mCsc0qVMvcGeBZX39WoP3gYm68KK5qYRAtKxDJLSsqQryhJLu?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S96BLPVFrWOQCeKeJ009yFj6hs8jw93WaCWqaKVoMJUR9oXJ2dg15IQBR18eDjckyYXUxpbDFlKXYI0FIpHzhbQ7dTNV2pbcRM3Iog6ytOOTuF96Ja4ARNhdha+v05IApeh/4ij0b9yxEmbXtd3Hv6Mbhclz/AjUAUZoslz0feDu044dgu3hdUd14+ZOorRzsT+cfH/lLug+PtVu+bMXlhHHnng3gXUmVsR0MAYXBU4XgFywx3Hz4DZ0dYJpzZWw/4Bid5UpUeWM9dL5+kilqxDu9GT/O79LHy3MR4jtjtf1SJ8W+UuQDGpCsxiboEoISvleYYfm9uNVl34rnJzx0C46FkLGM1F7gNEM6ME/PrwN+Bv5Uaa3h987ZpNBHz+m9jQ4R5mqSnfNNeHHmCz+R9MbRZxPFhvBG58fbVhHMEr1/D/jng+ZC569Oqo2e1KYHaFpYVtn+xNaimsTF6E0cppMaJkWeRI/Casx8mR4iqKzdbvx/YBJXmTtDZH8PHBvEEz7USv4D2d0rClKvDaRmLAmVIdrqLn7UW102pf0wNfMCV53oIH6HQjU3K0RMqVyALPYIzTJerwwh+MAjofpjS+jvcv//njdMOTFxL0CCZM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c6dc3-319a-40ef-b000-08dd88d14d9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 16:57:49.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0fImYN/13el1Zk2TkNC7U0b2vx7KWFE+PQ9udQb1zkaQh/M9GDCn5Z0bZNLu5oU1YAMFPvuvRvhBk/s+044KJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6040
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010128
X-Proofpoint-GUID: b0W6u5B-3vVAXg7TB3prT36NzwMWJyF5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDEyOSBTYWx0ZWRfXwFwX9DRrIBM3 /Dll4/7PWeBs7pOWjt+7s9s02fFe2Y92b9LNXD3hiTai7WySh67zrTZOCXKFp39ROlhLgSBTrvk /pt3rTL7QqKJps5PpIBFaqj5s3P4CLgHBrhO/Y+XrfcIydNuddEL8i+R1B0IGcjy4K8VGwyJP24
 0q+DicLsFSeeM8lWEsh8rtbSTGZH1lxqjsqsZmLHdrvzh2pigFtFdZjklD1tjnoyjVhOm5T/fHB PSAR9FQoj6Gp5XbHyL+yks8vcyAX4lJL7E+TE1NeXf3TwwtsfTmil1K7ELtlYEqjGr0eu73N00N U8k+uZCUqVaRQMLOtd+WmVyRR0S7MhGkKIpOFnyFK6J70v0QPm0wfvLq1V0lW5gsJy0yXrQpslW
 Pn5fQZyb7oAT5KdXVVEVONtVtlXULNIcEGMebUpw1IvXsW/rBM+DyCbfzB5fNwU35ojnx31W
X-Authority-Analysis: v=2.4 cv=ZuHtK87G c=1 sm=1 tr=0 ts=6813a811 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=6KFWBsMsv8NWCX33yDQA:9 cc=ntf awl=host:13130
X-Proofpoint-ORIG-GUID: b0W6u5B-3vVAXg7TB3prT36NzwMWJyF5

From: "Darrick J. Wong" <djwong@kernel.org>

Add selected helpers to estimate the transaction reservation required to
write various log intent and buffer items to the log.  These helpers
will be used by the online repair code for more precise estimations of
how much work can be done in a single transaction.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_bmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_bmap_item.h     |  3 +++
 fs/xfs/xfs_buf_item.c      | 19 +++++++++++++++++++
 fs/xfs/xfs_buf_item.h      |  3 +++
 fs/xfs/xfs_extfree_item.c  | 10 ++++++++++
 fs/xfs/xfs_extfree_item.h  |  3 +++
 fs/xfs/xfs_log_cil.c       |  4 +---
 fs/xfs/xfs_log_priv.h      | 13 +++++++++++++
 fs/xfs/xfs_refcount_item.c | 10 ++++++++++
 fs/xfs/xfs_refcount_item.h |  3 +++
 fs/xfs/xfs_rmap_item.c     | 10 ++++++++++
 fs/xfs/xfs_rmap_item.h     |  3 +++
 12 files changed, 88 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_bmap_item.c b/fs/xfs/xfs_bmap_item.c
index 3d52e9d7ad57..646c515ee355 100644
--- a/fs/xfs/xfs_bmap_item.c
+++ b/fs/xfs/xfs_bmap_item.c
@@ -77,6 +77,11 @@ xfs_bui_item_size(
 	*nbytes += xfs_bui_log_format_sizeof(buip->bui_format.bui_nextents);
 }
 
+unsigned int xfs_bui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_bui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bui log item. We use only 1 iovec, and we point that
@@ -168,6 +173,11 @@ xfs_bud_item_size(
 	*nbytes += sizeof(struct xfs_bud_log_format);
 }
 
+unsigned int xfs_bud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_bud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given bud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_bmap_item.h b/fs/xfs/xfs_bmap_item.h
index 6fee6a508343..b42fee06899d 100644
--- a/fs/xfs/xfs_bmap_item.h
+++ b/fs/xfs/xfs_bmap_item.h
@@ -72,4 +72,7 @@ struct xfs_bmap_intent;
 
 void xfs_bmap_defer_add(struct xfs_trans *tp, struct xfs_bmap_intent *bi);
 
+unsigned int xfs_bui_log_space(unsigned int nr);
+unsigned int xfs_bud_log_space(void);
+
 #endif	/* __XFS_BMAP_ITEM_H__ */
diff --git a/fs/xfs/xfs_buf_item.c b/fs/xfs/xfs_buf_item.c
index 19eb0b7a3e58..90139e0f3271 100644
--- a/fs/xfs/xfs_buf_item.c
+++ b/fs/xfs/xfs_buf_item.c
@@ -103,6 +103,25 @@ xfs_buf_item_size_segment(
 	return;
 }
 
+/*
+ * Compute the worst case log item overhead for an invalidated buffer with the
+ * given map count and block size.
+ */
+unsigned int
+xfs_buf_inval_log_space(
+	unsigned int	map_count,
+	unsigned int	blocksize)
+{
+	unsigned int	chunks = DIV_ROUND_UP(blocksize, XFS_BLF_CHUNK);
+	unsigned int	bitmap_size = DIV_ROUND_UP(chunks, NBWORD);
+	unsigned int	ret =
+		offsetof(struct xfs_buf_log_format, blf_data_map) +
+			(bitmap_size * sizeof_field(struct xfs_buf_log_format,
+						    blf_data_map[0]));
+
+	return ret * map_count;
+}
+
 /*
  * Return the number of log iovecs and space needed to log the given buf log
  * item.
diff --git a/fs/xfs/xfs_buf_item.h b/fs/xfs/xfs_buf_item.h
index 8cde85259a58..e10e324cd245 100644
--- a/fs/xfs/xfs_buf_item.h
+++ b/fs/xfs/xfs_buf_item.h
@@ -64,6 +64,9 @@ static inline void xfs_buf_dquot_iodone(struct xfs_buf *bp)
 void	xfs_buf_iodone(struct xfs_buf *);
 bool	xfs_buf_log_check_iovec(struct xfs_log_iovec *iovec);
 
+unsigned int xfs_buf_inval_log_space(unsigned int map_count,
+		unsigned int blocksize);
+
 extern struct kmem_cache	*xfs_buf_item_cache;
 
 #endif	/* __XFS_BUF_ITEM_H__ */
diff --git a/fs/xfs/xfs_extfree_item.c b/fs/xfs/xfs_extfree_item.c
index 777438b853da..d574f5f639fa 100644
--- a/fs/xfs/xfs_extfree_item.c
+++ b/fs/xfs/xfs_extfree_item.c
@@ -83,6 +83,11 @@ xfs_efi_item_size(
 	*nbytes += xfs_efi_log_format_sizeof(efip->efi_format.efi_nextents);
 }
 
+unsigned int xfs_efi_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efi_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efi log item. We use only 1 iovec, and we point that
@@ -254,6 +259,11 @@ xfs_efd_item_size(
 	*nbytes += xfs_efd_log_format_sizeof(efdp->efd_format.efd_nextents);
 }
 
+unsigned int xfs_efd_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_efd_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given efd log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_extfree_item.h b/fs/xfs/xfs_extfree_item.h
index 41b7c4306079..c8402040410b 100644
--- a/fs/xfs/xfs_extfree_item.h
+++ b/fs/xfs/xfs_extfree_item.h
@@ -94,4 +94,7 @@ void xfs_extent_free_defer_add(struct xfs_trans *tp,
 		struct xfs_extent_free_item *xefi,
 		struct xfs_defer_pending **dfpp);
 
+unsigned int xfs_efi_log_space(unsigned int nr);
+unsigned int xfs_efd_log_space(unsigned int nr);
+
 #endif	/* __XFS_EXTFREE_ITEM_H__ */
diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 1ca406ec1b40..f66d2d430e4f 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -309,9 +309,7 @@ xlog_cil_alloc_shadow_bufs(
 		 * Then round nbytes up to 64-bit alignment so that the initial
 		 * buffer alignment is easy to calculate and verify.
 		 */
-		nbytes += niovecs *
-			(sizeof(uint64_t) + sizeof(struct xlog_op_header));
-		nbytes = round_up(nbytes, sizeof(uint64_t));
+		nbytes = xlog_item_space(niovecs, nbytes);
 
 		/*
 		 * The data buffer needs to start 64-bit aligned, so round up
diff --git a/fs/xfs/xfs_log_priv.h b/fs/xfs/xfs_log_priv.h
index f3d78869e5e5..39a102cc1b43 100644
--- a/fs/xfs/xfs_log_priv.h
+++ b/fs/xfs/xfs_log_priv.h
@@ -698,4 +698,17 @@ xlog_kvmalloc(
 	return p;
 }
 
+/*
+ * Given a count of iovecs and space for a log item, compute the space we need
+ * in the log to store that data plus the log headers.
+ */
+static inline unsigned int
+xlog_item_space(
+	unsigned int	niovecs,
+	unsigned int	nbytes)
+{
+	nbytes += niovecs * (sizeof(uint64_t) + sizeof(struct xlog_op_header));
+	return round_up(nbytes, sizeof(uint64_t));
+}
+
 #endif	/* __XFS_LOG_PRIV_H__ */
diff --git a/fs/xfs/xfs_refcount_item.c b/fs/xfs/xfs_refcount_item.c
index fe2d7aab8554..076501123d89 100644
--- a/fs/xfs/xfs_refcount_item.c
+++ b/fs/xfs/xfs_refcount_item.c
@@ -78,6 +78,11 @@ xfs_cui_item_size(
 	*nbytes += xfs_cui_log_format_sizeof(cuip->cui_format.cui_nextents);
 }
 
+unsigned int xfs_cui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_cui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cui log item. We use only 1 iovec, and we point that
@@ -179,6 +184,11 @@ xfs_cud_item_size(
 	*nbytes += sizeof(struct xfs_cud_log_format);
 }
 
+unsigned int xfs_cud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_cud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given cud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_refcount_item.h b/fs/xfs/xfs_refcount_item.h
index bfee8f30c63c..0fc3f493342b 100644
--- a/fs/xfs/xfs_refcount_item.h
+++ b/fs/xfs/xfs_refcount_item.h
@@ -76,4 +76,7 @@ struct xfs_refcount_intent;
 void xfs_refcount_defer_add(struct xfs_trans *tp,
 		struct xfs_refcount_intent *ri);
 
+unsigned int xfs_cui_log_space(unsigned int nr);
+unsigned int xfs_cud_log_space(void);
+
 #endif	/* __XFS_REFCOUNT_ITEM_H__ */
diff --git a/fs/xfs/xfs_rmap_item.c b/fs/xfs/xfs_rmap_item.c
index 89decffe76c8..c99700318ec2 100644
--- a/fs/xfs/xfs_rmap_item.c
+++ b/fs/xfs/xfs_rmap_item.c
@@ -77,6 +77,11 @@ xfs_rui_item_size(
 	*nbytes += xfs_rui_log_format_sizeof(ruip->rui_format.rui_nextents);
 }
 
+unsigned int xfs_rui_log_space(unsigned int nr)
+{
+	return xlog_item_space(1, xfs_rui_log_format_sizeof(nr));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rui log item. We use only 1 iovec, and we point that
@@ -180,6 +185,11 @@ xfs_rud_item_size(
 	*nbytes += sizeof(struct xfs_rud_log_format);
 }
 
+unsigned int xfs_rud_log_space(void)
+{
+	return xlog_item_space(1, sizeof(struct xfs_rud_log_format));
+}
+
 /*
  * This is called to fill in the vector of log iovecs for the
  * given rud log item. We use only 1 iovec, and we point that
diff --git a/fs/xfs/xfs_rmap_item.h b/fs/xfs/xfs_rmap_item.h
index 40d331555675..3a99f0117f2d 100644
--- a/fs/xfs/xfs_rmap_item.h
+++ b/fs/xfs/xfs_rmap_item.h
@@ -75,4 +75,7 @@ struct xfs_rmap_intent;
 
 void xfs_rmap_defer_add(struct xfs_trans *tp, struct xfs_rmap_intent *ri);
 
+unsigned int xfs_rui_log_space(unsigned int nr);
+unsigned int xfs_rud_log_space(void);
+
 #endif	/* __XFS_RMAP_ITEM_H__ */
-- 
2.31.1


