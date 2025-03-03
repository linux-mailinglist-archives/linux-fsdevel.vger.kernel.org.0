Return-Path: <linux-fsdevel+bounces-42974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78BA4C99B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 18:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3B93A2958
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Mar 2025 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8C251780;
	Mon,  3 Mar 2025 17:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V1TPsqAE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XwFy+b54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A68522D4E9;
	Mon,  3 Mar 2025 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741021901; cv=fail; b=A8LV1TcboKLHnCjdpg9lCY/xJtTI5jCxhjjVb2fOsNzJQ5+6NfTK98Bj3nQVXesK3yPMO+MuqOgx/XjnSeHZdIcVDY41eaPmnFu2ieFWC1nD/izdNJN3dm/1/RAXryzKjViJXNgIlvfl1fgFGuDV8CwofmzfEr3gUVkgA2bdOOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741021901; c=relaxed/simple;
	bh=Jd0g25mYSS7M32KreQr/tdGyZb0Xs4r9Q+Apa209CrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lsCfDRXeJ0rVgl1FPdrO+1hJoUFC8LDQva1NhswlejeIoAxeGKng1a/Ksxc/VCM04WOx1pNuOG5kfvFyzo0rrifASJbLeaHaKUFDvbtMTHEZ0goUWqAgdbKnkSf1J4rZq1i0urr06Rj/U0f10OCOfMZiqRdFfBGe8xePIbUgz8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V1TPsqAE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XwFy+b54; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523G9KgZ008103;
	Mon, 3 Mar 2025 17:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=XKPWcgaW9jrmnhZt
	BwvQQVwSbxP1FM/ObQHrbczEzRk=; b=V1TPsqAEkXF8jnEhdnBWIbFWMvBSAlD1
	H6DcwVbYt3jGHP8ebsQMewpm1oQE4osXwDjAZjVaH6LFjJOD61bJPs2Lr8mj1sZN
	4xgDvU0i0fEq2K7LW8UjYHmd4YAEHlhVb5GJP1zRheigAHOgKzRWy808xhmCHXth
	ZyI5Xc1wdNRWkhDqlxtYKpah2WPVSvJDU6HFyCnINpkvDig0J2blR11MmrQ9SYOn
	4H6cj9cQhw2piHydBBFyyRincya/W0tG1Ww47aW1PC1eTV8oYByUu8MQOdwEtOCZ
	zyv+QlqiU6KHWYR9jVkZYeeYQ3lfD9udGx7WtZ2V7Agiool4TMz87w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub735w8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523FojXt038255;
	Mon, 3 Mar 2025 17:11:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2047.outbound.protection.outlook.com [104.47.51.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpe1eqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 17:11:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qfv12xbBY6enCrMiqSQNIKCVjYONnrO9o0Sg98guIdpGNDy/Bg4Ats1ljf/UMPAEJDPZFCE3hKO8cCPkiILxO6XfTl9uYrewGvHoje24dHTFU6OMFi1i6Xtb7vegSFqF0vJsPUBh5QbYf4dCxRva0v+V0QYjaxGqLxs4PmfPdOjemvQw2x/q2NyB4YcSDAWdmoIrAHNO0UOkdnTPGl0SROHPjbiBJhFnOj9iu6St0atMOw2WSX8lenWiEK75+aYTVVi9KTSgaqRTkTvoL1qG4VX6x2JZT+pxMhrRRNSF9c4dpRMQgVkPSSjEBReWj+fslhzBKY0EefYRS/IYO0ApZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XKPWcgaW9jrmnhZtBwvQQVwSbxP1FM/ObQHrbczEzRk=;
 b=U9xcD/3RZpP7mT1SSvuZdrOG3ZJodKT9qm6q4ryaxVO5dApTgZMxJ54eIoFoeyuEkXikmoHRt8FkWBPfY8Sms5Uhxm2t5wkkgg/nb8J30txnRnc/fbxHoSiCbIm2uUfXWZ8OaPqUBr7rDGRKnWngM88YKgppHmwQLb02WrappIpey2s7FmJIDNur8q/kj+2Ej13qftZL/ZEaPkAylNcJAOrH6echINGM8n11+6tJJ+Rls9biLbOQ38tscmBILle1Ndd5uanVLuR/35LLbo2WUZi6HDM0qIb+e62Zz3c/RsmdsHGSdNW7G4G/RWMPNE+fiuhlCUyIZJdGBaqlRFo30A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XKPWcgaW9jrmnhZtBwvQQVwSbxP1FM/ObQHrbczEzRk=;
 b=XwFy+b54H+mgMivJ16QaY0IM+ozTxBMbNixVqUFikFsV3nmyLv0V7fq+++cc/aaDvN38v9Epnm6NeqFRWYV3RajsVZEZnnvkWJ63NY6vsgc+m+9DwE2Pwi4Oln1QlgRkjbYjiTBFSG3POMbTk4pog8MswnLyxwOII/1HnAQlI+I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6251.namprd10.prod.outlook.com (2603:10b6:510:211::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Mon, 3 Mar
 2025 17:11:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8489.028; Mon, 3 Mar 2025
 17:11:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 00/12] large atomic writes for xfs with CoW
Date: Mon,  3 Mar 2025 17:11:08 +0000
Message-Id: <20250303171120.2837067-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0013.namprd10.prod.outlook.com
 (2603:10b6:408:e0::18) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: f931f37d-efb3-4c32-6078-08dd5a766fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rPXpPhnwiJ2tIPAQ9XuSF0G0TX5+Mbnr0r1F6gnwm0mtUo1oVQ5UHyCVHjzA?=
 =?us-ascii?Q?go2O6EbHkB/htoGJIzgjp/7IXWvXcE4FDD04tKfsmCUVO6npdMDTHc7owHPJ?=
 =?us-ascii?Q?PlPUUA2pVY69MAfxIypqieeCqh3awHL4EizNm9dAJE0QYNj9i8Y6UVLGZZRY?=
 =?us-ascii?Q?oPLAzpPHXhv87ppYmRhM7ENX4uT91qVWNWTxZ7WLx2krWtvbpJ7KdDFp0LIK?=
 =?us-ascii?Q?Cwbs1F/6VrkSvrQKHGBYkduU9OUOZ8jpEd1wbB4u5CsLSIa+PrE9OwYOmW0H?=
 =?us-ascii?Q?s0Kx8x+rRyqWqR+KOeh43Qjafz/IvRCjj54WggKx1PgYpCzv4l3w0C5M09cF?=
 =?us-ascii?Q?UYL8C2Hdqk+C48tXb3Xp54Bd8O8S5SXJyEm6AXUZFuUi7lt+zwwOXgfBN6XV?=
 =?us-ascii?Q?rOMTRNZlrslPGhvi6gHIsMpU133QRaw/WXdU0KsVDUXtI152DgCv8dM3CLEO?=
 =?us-ascii?Q?exPlaeUZ929+bdz9pzEDMauUXszmTrQ9roi6dTJiAnjHU84UfX39eECZXHzu?=
 =?us-ascii?Q?RRow46r00epk8Y8qpu1aHwB3QMPMRezV8nduoV/dcUnZYR0LtpH2dFlsuS8F?=
 =?us-ascii?Q?meqV6hYMk7jtRfyBGYXo6jYatKqqdjRN13AJXESGCAf9cW4krNLdFJH0hrtj?=
 =?us-ascii?Q?Xirxu2Z2RO1sqaWrLlAgQLwoM8MV55o+sxjTWGkefUa3fQ7Wj0fdERLPqgsZ?=
 =?us-ascii?Q?B2DveL4J5GHbYv9ET6CHCm7m++X2vrN/sE7qoM7doWJcWOS7WHE6s1E9q+7X?=
 =?us-ascii?Q?fb1cnmv27oUNibBB24AAUzpxPgxTmKboF28fjZrCxJvSiHvzD6eZzt+MRCJQ?=
 =?us-ascii?Q?v9jZzlMGb95D2HqHe2OSFZmHPhhFokQ5UISAmlJn/oYRI/ydZnXjhT5+6Uec?=
 =?us-ascii?Q?EGLEWQ29jDn5MvRT/A9qs/RT+f1ocN5Iu4o0sOB9gtYRrPkUgzzpuqSKE97/?=
 =?us-ascii?Q?7JMqFZrbC9q/7m0CSiMtApc+I7TnBz/ozWEDBxyZfn+vJxQqfrWZ0vJdIySr?=
 =?us-ascii?Q?4lnpghmnOnH+0tcxr8/gZDkuQuHQptP4nyKWCBhUv0I4GHaGYAlajtO5K2cL?=
 =?us-ascii?Q?3EwuCAF0Vnoicf7UfxkKCxesozhzK4aXH0LTvJ5vuz0kFtJXfbwUDCuYrGAu?=
 =?us-ascii?Q?6uNxaitjjnczxuHQtV2QBk9U2FIMOeQE+L1lwHoQ2hbXLC5ODJN7nc62TsJ2?=
 =?us-ascii?Q?Ppgiy3RgxsNobJ2NMnq7hUbnj9c7ZsKrvMQueh8TznZB6Dx++EAy9SKCFto+?=
 =?us-ascii?Q?i4TImzqsWsrjawz3cHMVX5utNI7MYnOJk/RQ8mvboxNvGMGeGBuVhyHZLW4B?=
 =?us-ascii?Q?/MFSAdGhjp2scFgbV3Sz3Y+zTexoRb9ZkdlggNUJ4Jo0T66cl9nxzFPg3kw1?=
 =?us-ascii?Q?iZLzHzbDyM/58cIZwqtun7PzunyG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DrWvv42C984LejycdYqDGxu8vsDmaYAv/vK0YDV6R14SMjGf2UosZw7IdtZB?=
 =?us-ascii?Q?6PbdbvAWkM6OhXu19egsdTBsAN3k7AaiUHbdDdMVaJEebUnKCRzyxE/7Y1OQ?=
 =?us-ascii?Q?5Gln6QcWnqHsQIeG9/RROey2Tn5NjuhlJ1nquPlg5MgQx1iChtgEuQKb/Jnk?=
 =?us-ascii?Q?Ku5SjjsvhFPWIJeONevzh5JAZiDa1xx24sklsxnpxg/L4+zkzvfxm8TKlJ0i?=
 =?us-ascii?Q?CCKOQL1IOEYwgF6EjLdyn3TFFSF46jQombhtZ2rLosVM/f6De6HPJ0VMPN4w?=
 =?us-ascii?Q?E7Kdzj+9C4rpWK+HP5tmdFRT2ErHD/jMWlsXxGRHuZKQYyXihnCARxKsPXu/?=
 =?us-ascii?Q?DiPVR1qwfexvGfwG6dnB1GolrktO/e1TQrM0/7ZLdOiKLWiL6AQrBbpkBvQ9?=
 =?us-ascii?Q?7c7tvaw5jpzL1OX8X3kiU/TX63a9o3eGbruUi+Sa6FZMtAvJ0V96FXtuTRsz?=
 =?us-ascii?Q?TVJ0q/9etx4G+TYSTI/HJ1B4ueJgh7BTkf9UF35vyIX5Kzk5JZRS++JfvDHS?=
 =?us-ascii?Q?oO1lTyE6hQee09v6Z/pDkMc96ZQ+EkJvHGFtnpdlIDM/2Q9UNwkpB5EDstch?=
 =?us-ascii?Q?1rg8pcL0LkGDbyb9O5ppJMFgvqpSWzACo2duBv7aERsd4DbZoUv8BzGd1R5u?=
 =?us-ascii?Q?06cqCwi0GxBkT3yZm2HX9XBzLkMFxU+EpL3N1QGR84X3YQYDLaOgK4ycaFQF?=
 =?us-ascii?Q?QrtnwvO1F/ZrRR56eCGh4kyXm9PBMZOaaeBApAkPk2aRgRs3bySN+W6sejo7?=
 =?us-ascii?Q?iCriWB2f3odXrlgQWcuKIh567g24LAYCai7KDjA/yUrFz1M37Ub06Jm590HX?=
 =?us-ascii?Q?j1Qj8g6nfP177BZ+Q2CZal4U2/2CidDjUUQIsiHJc6dZ9eUD0XFKstGjK0kX?=
 =?us-ascii?Q?TynixkZ+USaDa6tCu4Me62IjMTib/SykGtgP8BN3dyIm/Evdddb/XzNulyA3?=
 =?us-ascii?Q?WuBhDvokzKBk3nu0hVEnXNXYOyKHyX3ZTq+MuR13yM2rvFw67UiHa66TG+AO?=
 =?us-ascii?Q?aD9h2vgPrJ0sP6PYikvDRUF3OoukI9mUAIdqgjgV/vApZl+MwQaXB8se5RDF?=
 =?us-ascii?Q?MFi98uAh/G5bEXW4avussgD5O7L3J+V51az+NsRtS9rat6d615FH0kqY/Fj8?=
 =?us-ascii?Q?T1beobunBoVNgx4gfagiawAsob9iHbzvL7js9p4B5p/HfNs5N+RZlIbXb5cY?=
 =?us-ascii?Q?rWfVPimU5Z4+eWTEQ73GuQYdZBeh/eiR301UDzlZzPf+amlZEI85d9Z1wAL3?=
 =?us-ascii?Q?N6uBhR/xRa0TASURUjfOI64DDyGfrRIpKfUerHTKiCh63HZtOcganioghC5J?=
 =?us-ascii?Q?LA+gdvkd+dLygCr5csXk63zEvJmg+ITMdRbXpbBKE5bpcd5ejn3dgG0SJw0/?=
 =?us-ascii?Q?iadpnQ8un1EpFQaFn/ahzWmLDi1ieTFgJb3wEAgZ6abXRuolKLWYmeT2xwas?=
 =?us-ascii?Q?FffGB3W+c+yrO8U2OTYFrKi3faPqq5d2ddL4UYaIfSV8QtYdoq4I5Penxszy?=
 =?us-ascii?Q?Xt6LeeW5DN1RMggIPATlR3VF1j2Yi5RsF5eKcObFGhQVnGV9iSErCEQ4GbKO?=
 =?us-ascii?Q?leCTl5rnBh+fN5brgoK65ctzqJbUzRshVFflyXd0MjfS8FIyKDue1grcmn9N?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PTBGZKe45FQ1Smkkgci7iss6onnZtN6zRHzRGYoxzOTHkKI9DOF7upgOQCj9QYalFRseSeq0w/PVObPQc+RAzfUmaBaaLGHsQYIi420Le0g0BS22j3DpnC2MCBEB9Bt5hxchu+/BYIwE5aSZ+Pk8pj+A5qDiWVTeeVExZUOlHC8J/tMy50CI38ldKcKPzOqxxCv4t6eOg/8CdY5fRqsz+//wCJ3kVq89/Ruq2BiAnBdm9e48KXlh5IHefSWin+WCe6a/td15Df9vsECp6LS7Mp/EyTq4CNG27u/vru7MgT2JgEKjGM795ZK2HsAQEClg8Q5MQIZaAKX9aK6xpZY6VV3ywwAlsgRGpHx+66IC0TgfbGmInEP5QM04jfRFlcb79q5Ipmsba3/dCMfWa1ApWby/N86s4g1mQiOvdSICcHbU4TU+JFIjdFJ1Z8reJ0qDlYn2gu3SIE5uaF3qEKvnrJHzYJ4UegSUg0HoLSNkuugvQ5XG5juvEmgkalh0nrxh1IF6gQeYpqgMR9oV7aJEisDgRMBKRMTelhJb363tFEjYjRznzpLQkqgNWAtLmixdRxy9Jb0yXuxBDlTC6FNAKyx4+/MNmGubaZImA2WaQNA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f931f37d-efb3-4c32-6078-08dd5a766fa9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 17:11:28.4018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a97LFwWxO0i7hT5zuPBeAr3jy74by+TZIdDnrKO1gZALCPTfn8w4NOCg37PKIHy5zFnKJwuBgmYWxrA6rzRkLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_08,2025-03-03_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030131
X-Proofpoint-GUID: zJxf5nqVETBa2pCbbVCab41V_7J240jj
X-Proofpoint-ORIG-GUID: zJxf5nqVETBa2pCbbVCab41V_7J240jj

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a software
emulated method.

The software emulated method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For XFS, this support is based on CoW.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Based on 0a1fd78080c8 (xfs/xfs-6.15-merge) Merge branch
'vfs-6.15.iomap' of
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs into
xfs-6.15-merge

[0] https://lore.kernel.org/linux-xfs/20250102140411.14617-1-john.g.garry@oracle.com/

Differences to v3:
- Error !reflink in xfs_atomic_write_sw_iomap_begin() (Darrick)
- Fix unused variable (kbuild bot)
- Add RB tags from Darrick (Thanks!)

Differences to v2:
(all from Darrick)
- Add dedicated function for xfs iomap sw-based atomic write
- Don't ignore xfs_reflink_end_atomic_cow() -> xfs_trans_commit() return
  value
- Pass flags for reflink alloc functions
- Rename IOMAP_ATOMIC_COW -> IOMAP_ATOMIC_SW
- Coding style corrections and comment improvements
- Add RB tags (thanks!)

Differences to RFC:
- Rework CoW alloc method
- Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
- Rework transaction commit func args
- Chaneg resblks size for transaction commit
- Rename BMAPI extszhint align flag

John Garry (11):
  xfs: Pass flags to xfs_reflink_allocate_cow()
  iomap: Rename IOMAP_ATOMIC -> IOMAP_ATOMIC_HW
  xfs: Switch atomic write size check in xfs_file_write_iter()
  xfs: Refactor xfs_reflink_end_cow_extent()
  iomap: Support SW-based atomic writes
  xfs: Reflink CoW-based atomic write support
  xfs: Iomap SW-based atomic write support
  xfs: Add xfs_file_dio_write_atomic()
  xfs: Commit CoW-based atomic writes atomically
  xfs: Update atomic write max size
  xfs: Allow block allocator to take an alignment hint

Ritesh Harjani (IBM) (1):
  iomap: Lift blocksize restriction on atomic writes

 .../filesystems/iomap/operations.rst          |  20 ++-
 fs/ext4/inode.c                               |   2 +-
 fs/iomap/direct-io.c                          |  20 +--
 fs/iomap/trace.h                              |   2 +-
 fs/xfs/libxfs/xfs_bmap.c                      |   7 +-
 fs/xfs/libxfs/xfs_bmap.h                      |   6 +-
 fs/xfs/xfs_file.c                             |  59 ++++++-
 fs/xfs/xfs_iomap.c                            | 144 ++++++++++++++++-
 fs/xfs/xfs_iomap.h                            |   1 +
 fs/xfs/xfs_iops.c                             |  31 +++-
 fs/xfs/xfs_iops.h                             |   2 +
 fs/xfs/xfs_mount.c                            |  28 ++++
 fs/xfs/xfs_mount.h                            |   1 +
 fs/xfs/xfs_reflink.c                          | 145 +++++++++++++-----
 fs/xfs/xfs_reflink.h                          |  11 +-
 include/linux/iomap.h                         |   8 +-
 16 files changed, 415 insertions(+), 72 deletions(-)

-- 
2.31.1


