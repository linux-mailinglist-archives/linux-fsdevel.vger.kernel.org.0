Return-Path: <linux-fsdevel+bounces-45951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DD4A7FC7F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 12:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D220D16772C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Apr 2025 10:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AA82686A1;
	Tue,  8 Apr 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FjUqh0Uc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s0jqmdzE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C026722B8CE;
	Tue,  8 Apr 2025 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108974; cv=fail; b=mhhvh/gA+ssDdQQKnrj9rcud0lXqW9kn87dHyMOiqKXHmY6CVMGuTFTP5xuRfZd9x9Y/j2xLZ8ewyWSg8f85EwhF0U/+IVmO1uNWaZZnJQ5CxsloF7KWfEPoT6Lj321hvYQxtwfmDMiOwEwQS952mUH2bqVgPOw0vYk2+K5rkjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108974; c=relaxed/simple;
	bh=V7KoScuLCdFCDcY0c+qED1khDU3KDbmOfL+3PgdwX5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=as1+PoDkBIWGiAVSFjU6iekr9YYg0g/ML+3bOavwmpz5ZPFQgE/zFfttCMoraW4K6FWdCk6FoZjkR6+QjWVZCnRp06THvDAE37GI/ros1WBxChc4QaXedVIN4IMpapgJbeBNAc8NBUqO/vn0HGbhEE/H+0MnL+6R7FiujD2NLRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FjUqh0Uc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s0jqmdzE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5381uWEO029057;
	Tue, 8 Apr 2025 10:42:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=3dQa+2/HefR0oYX/
	hFWwmsBIAz1Pbhj2wzTz1AoUs78=; b=FjUqh0UcfCJHOgndH2ZkQejZPCfwcW1E
	9HKq1L9LgiJ6+v9cs98uNif8PUwdXn1CyfLj9ghS5P4EK5OWDf9ARM0LovdJPeVi
	1vKoMm6EEMacWp9JVPaouwKZjb4RuAF57LfOY4yce6169ebIZUQWgtftLuRs/M6U
	7YTCTFT573eO4enVrDndzjzh59bKWuOfRIWFn8KUqKZByLL9VSBPAc8ftrqHuriN
	xtZWc4kTYQffO+pyw8Yq58jGcia5ox64XRtGn6Tf/CEfxpAk/mY0m1AEl8K0kDb7
	VJeKR06qJFs9Yhv1+qBDb1A461QclgzSg23FYb1izBT55ugfAX2bhA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45ttxcvf38-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5389gFM9001477;
	Tue, 8 Apr 2025 10:42:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45tty93cxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Apr 2025 10:42:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNMweLtSrHvXfULRefguIXVBrfGS7Ks69siOvaponADSDWt2d0JTOEYxGjibPhX/q8HogwvFGe2rz3ziw84o/hAdIbZ+18z18yZyX+oWEj4nSnuvqwiUeh0w412RbVcgdNPriDgAI/ItPgP4dZsd5pSy87bf4uRfWIS9qO/SoYJSmu3FWzZxbFdgfkd5C46NRmSEalLeiP6UEyhGdzGWrSWyXstqdqY9rC9TuEF0BV63jWCtAgBBLK3OIo49BPASDZNRAXvqYf6YevqWwH6T1bYUJB9OM+vWZZ4JHByrcsAod1pV1XTHRrU0anHEeUzieQ0dE+mfRcarghfu9U3Ciw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dQa+2/HefR0oYX/hFWwmsBIAz1Pbhj2wzTz1AoUs78=;
 b=c2Qn4VlY6/Lw4v92lKPygdOl5qB1qC6sGgZJgZedU6twpldDK6aZLe3xMyzsqij0zvq948XqAq8ELsqAFuWFHuaof9A3i8aWTJkH1zgL9vslhZ2MWXhNRFwW57i2S4QtzCk4b18rul45cZc2OPFq3MbmslHjTtJjmHjGsa7RrswH/WaOyrGfstHVNBXVguAd4KKnF+22OznluukoG1AAQY5uH9LsiraDDziquX9XJSF3O0YCeCfM7Fwa12lYYdAm6TFDb6UE0Lj3+tpywLZPOR+/kFEP8OFBuc14D/C56fyXyQfWfRfNvn92e+HK+Nz2apIkq4+NQztOBRVrThmvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dQa+2/HefR0oYX/hFWwmsBIAz1Pbhj2wzTz1AoUs78=;
 b=s0jqmdzEQdHRssmJDWXWfusdaf5Urq7CvOGzwCbBab1v310St+hEv7o0/wauf3bAJUqIWxh3qyv0jniU7DGOXToYaBdkriHzekiOTWH2T9ENkkX21pppgqo9DI7YZueyUoSEQTCngm1tmXbtwcUDZZhhO3R7NVhZ7qd08eXWVzI=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.27; Tue, 8 Apr
 2025 10:42:31 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8606.027; Tue, 8 Apr 2025
 10:42:31 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 00/12] large atomic writes for xfs
Date: Tue,  8 Apr 2025 10:41:57 +0000
Message-Id: <20250408104209.1852036-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0319.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::18) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|PH0PR10MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: 90ecec14-9fe5-4d61-3117-08dd768a107e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vxBkJvdW0wVK/fgdIEO8XNIlnAcijrO6vbNffa/4ZjYr0MdzDnCp0Xv2/1kl?=
 =?us-ascii?Q?956hpdKVIJOYxi4Vg+vrL2NAdZFDQ24697Lo8dulAsXWDFigNIVRMJK4+JRi?=
 =?us-ascii?Q?SGfgscCOwRyZDrWf170tSXl9NnSCgQezw1Qb8JlPAvBIvLEodRQHNRZ+Kpip?=
 =?us-ascii?Q?fXslL7VYbG/Uds/+eESGefKzHCBPx5y77hPLpzrN7NbKYqruHe3TdvElY5Hv?=
 =?us-ascii?Q?eg+3FudN2c0/4gyRlnhQZCZrcjsQY1CGq07dgoZHxpuDGfcKSMkAx11Qhaf5?=
 =?us-ascii?Q?6EXzu+1Aj7z1Co5k20dkgLpe8HaeabduYg2ExbvNjtps83HrU1YsvqMNxkFD?=
 =?us-ascii?Q?uSgD2BTdeQuNbn+ermVNcC73ZP5VusgSujMoWtoMufMz/vCcq3M3i5KoBdEo?=
 =?us-ascii?Q?MzKBDPg/F3V2lV/4o8RIN0NkCWG8MOT2X9gAg/PROm42NtstWl5QU1Lj44ZM?=
 =?us-ascii?Q?OwoQQEZfiOTF28p/LySZOsYHH+gZLXzmI4sAbbMA3B+NOTkFCTLmT/xNoj/m?=
 =?us-ascii?Q?+xwft2lIcAE7/yK4HXtdOlZ2vqOObaDwwGuYYdDM/TSPqX8HPjkf5bHpLLdp?=
 =?us-ascii?Q?pkBeiffujGv5QUCIeNpsG9mLU7rZzus98H/t5YAvgCEkJ1yGpN+/arE4y3ao?=
 =?us-ascii?Q?DS6cRxzyjjmfNg7rPpcyAK0R5XijmU24hzL8n2Vwy49OD+7dt1fTUWK6I4ve?=
 =?us-ascii?Q?uxHVdhdGGCxvwhOJqcV4rRBTPCuDVmj3tPLnQmliRxOzogRv7Y4oPtgC6gkT?=
 =?us-ascii?Q?chKI0GPGRyAxy+xbd6jJjTD9EX5AcfM2ngcMbjHJZm+Q5QW8BuCCMB2NFjvr?=
 =?us-ascii?Q?REt3/EmVENfFRsRGZ9i9GvAiDeM8oSXdsCtD/BKg4qguyHvtpIKj3C2hif6k?=
 =?us-ascii?Q?u7PU5orSIvn1G1FmsgGa6ILbZEzRH8Ecn6eA0mxg2eAnOurk53wh7mlHbQBA?=
 =?us-ascii?Q?KfSL2VQl0W/Q4miGZ79plyD/wbdeRqu5tgkCSz/HpBr7yc1ZHjD6fWcRUpN2?=
 =?us-ascii?Q?nLrAL4qqM97MtzLrGBQAH+hSRzsH4jYjPGAMLgK9KYfgSzo2GAN/4jtSTxlu?=
 =?us-ascii?Q?QSu0+YntluZ5vMGHW/ZKV5UlpiU/DCusBujNyt5qOLe7z3IyOHOEm3+PpFmQ?=
 =?us-ascii?Q?QI1BE8omDCQ1thFsMrn45bExlLz+eTvNori8EAx3aa+rrNWD8CXx6V+8pufB?=
 =?us-ascii?Q?bBJW0B97eCeHHrUABDW2LNXnNrRobheqPoi4xJH5bXEqi3xNzyiy667oAaY2?=
 =?us-ascii?Q?yP5MVFzNdkJRelUn9PX21Hzl2PW+kAWjjzr3a5OThIUsa2F86/VBCzaNYaw+?=
 =?us-ascii?Q?97RIScEZ2JT1KG/V6/qrmcleNcfSxjF6KhhoPm3BdOCuqv8nNtJPVoIhhBjI?=
 =?us-ascii?Q?cA4Wiyebv/BzHsPYYCKxYQ8P6ZJP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1UfBu020n7Vts00AYlOy9hsSdYkBzS+HInokhRfGYBwiUmKeU5OOu3vLKC/o?=
 =?us-ascii?Q?OeWB8BGqHGnYG/TTBxj4b9qJlM5Kvo11aCxj70BCPOoNprmzB+hRXmb/+buC?=
 =?us-ascii?Q?QJ+YEX/hESInbe+pMR4VCLapzg7gXMkC+A7PTMYM1G+2CK7SxhQ5oJQnW4TS?=
 =?us-ascii?Q?3efdZo/ZmTCemk2M+tAilbq2JZwddj43d9wRbOmfbhjSx88KkOQ3NGevDXj7?=
 =?us-ascii?Q?w1u/IzuxQNxtbT3cHMcWIEZqNBTO4hW0UR+jy90JworqKHmv09OyKejgAU9o?=
 =?us-ascii?Q?GnkevouNpKP4aIWCGPpVFU/4TGz7Wq6yG/L3/7IkQUlj6UCbQ5lvMb3+2d+c?=
 =?us-ascii?Q?FTBcR/Ot4KMFY9Srre8xUQoPBXJWoiwD9ZS2yGiWmYcYwknpAIwmsfYy0z+r?=
 =?us-ascii?Q?+YRyDB7+76ANB27UDDfmn+dpr+mY3g97zO9eBu25TPj40BJibtXD8i019N5E?=
 =?us-ascii?Q?eW79/sMcAYHzfNW1DIe279IcyQL6KKq91UisztckCvcoHqzxSnflAEKAYfeO?=
 =?us-ascii?Q?FK5NRPsJr4G8gZAB0lkNVjSUilGkYLdSMhz4HXhStJIyRfV8iA0GPTxWAitS?=
 =?us-ascii?Q?dJfXQu1/kOFCEPo5hoSTHM6UfNkdyWioUV/NgkdX68YPBrsxitV3+hfk9XzC?=
 =?us-ascii?Q?uoPstasC2xD/R5Cv74tosXXSy9PmWrem+js0wdwjPgAn6CcFQ8rVvMyATzjt?=
 =?us-ascii?Q?Twz/rxU3nMADg2Br8n1fL5mq4qPxcmz0ifeVQHrqB0EOOMt4LVV8EAevZe5V?=
 =?us-ascii?Q?Lp8bWT9JxQEkrdeBtgQz43ygLf6thCObWQ4yOpuhWFQmyMmNa7DrhAqT/Xls?=
 =?us-ascii?Q?GfMQK0N/LZmPOgxSbV/ds6cTCaGwKJDN8R08XKPdxC2HIxsuWOdR0hNOSsDl?=
 =?us-ascii?Q?NaPQtwySltUkWwKPkQJiUsiTgQL1oWxWAIXbWw5zdIwgeb9ZYnz7yjIR49ck?=
 =?us-ascii?Q?N1/778xF8XuoS0VMQ++WcmdFv7AyF0w94Wutwv5UdekVtN0YZcRjzlrxU53k?=
 =?us-ascii?Q?TEtwkVEMWXOUUDuUeP9slM4/EL5PXkWrTF5XRyBCtzlpepbO8XlF/bAT5iRJ?=
 =?us-ascii?Q?fs8YBpuowNsF/QToWX4A6alW1msVG5FX5rcNVvKETwKQD9Cb21fADRN3N5HM?=
 =?us-ascii?Q?ZfQxeVXxPWx9t1qN2BpIqJ6HnTltK+4smZKeCYFjjt2Djjx47mHIxuKvQolj?=
 =?us-ascii?Q?XVdPJhCpQ0AiDHerGDllIQ8KWbk6+psGXkE/nozdM86m4IkPgjKF1Jkbu2Ct?=
 =?us-ascii?Q?7Kk252AHquE08NRN4CWZ5zkiiRPlCB8wijjg0DR2DhG5KBeiH6bfvEG/Ug5a?=
 =?us-ascii?Q?GMoMXfgtbfO+TBIotqvgElFHet0B4+0xj+EVh6jxV95gGsdlK9VyjUqZIxrf?=
 =?us-ascii?Q?rDqqq5FPbdGPPm2MpQ+ZLH/xrVA3qh3w61/ENTz1n4AB++cMPLgj7XZZmVHJ?=
 =?us-ascii?Q?SbAaXX/8HFFpOKxkEkkSu+kK7r7UbhxwB43hKNOaG7iy0e5HhDDaN/DQqjeu?=
 =?us-ascii?Q?m8nLkSRJj93S0GAlJrChWpDVxivM0CWRdn2eLc24gXdqoRr0fWbjJHrX3Uur?=
 =?us-ascii?Q?O/4SjSnhX/m132uQMyOTDxDXyLTEnzw0qXDpevmLQWPfza9i+SlfL7DJ5y+p?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6lziD4qIACKMtKpkBI073fSJTo8VvdJcfFJ9fEVTP6N6gXMHMVDpf5Ve4OACU8CbiOSIseSGMeR11Z5z28UZMy48WjsrRgJXugho2f0YkJR6koSk8KN+DYcgUMjbtfltm+HRUxbnozwO5lB+h8QQWAiSVQhSmGIP5uKfymJ4q6RDciS34y3rjHUtyVmnMpP0j4I/7Hcx9SKAuyFg3yPVcyzyyJ0QNFTZb5UO+WZNNYEZsqIX6pXQsv+hxDKb5AtLtzSLGEm5LxMrc9s+I55zDhx57+Q+dl6KVg/6c+VPasYs5rfKS+rqwC+cQJ2QYcoJFGSHJx40d8MfQ+tQWmm64RHkDPLmusoRwuIs/zSKKk6KQ0aCO1a+Fop+4SeUiPN1OjER0yes5ALabgw4BZ6OxH+lHcc1GfEQfey7nhRoLMhk6aCbIvKCqLVy0YEDb9nsrJHbG7lsVT+TFFEDcEcGWDEHRogCsdnyPm//Wu4AtxG+AAN0huV7ZUnbB3XLoDaz48brr8e1aBIQfhpdMB2zC8Z7TwihnmIpOiv7Zap0fKClzV0DX3gyvWmbdFAznQ2QoLYFnmhpKsgKaBy928MRWJNuhP173X0IoYWCLx/wrAE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ecec14-9fe5-4d61-3117-08dd768a107e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 10:42:31.3500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFdQ/3iN3Tawh27CUJV/cV4rLOlmG37RFSSRuIOZ9mwNky9TlXA4FzA3cAq1u8ujpApY8io99obpl99pJh5auw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-08_03,2025-04-08_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504080076
X-Proofpoint-GUID: YscQUSrg-R7TBM7agVK8ew3wm640hFex
X-Proofpoint-ORIG-GUID: YscQUSrg-R7TBM7agVK8ew3wm640hFex

Currently atomic write support for xfs is limited to writing a single
block as we have no way to guarantee alignment and that the write covers
a single extent.

This series introduces a method to issue atomic writes via a
software-based method.

The software-based method is used as a fallback for when attempting to
issue an atomic write over misaligned or multiple extents.

For xfs, this support is based on reflink CoW support.

The basic idea of this CoW method is to alloc a range in the CoW fork,
write the data, and atomically update the mapping.

Initial mysql performance testing has shown this method to perform ok.
However, there we are only using 16K atomic writes (and 4K block size),
so typically - and thankfully - this software fallback method won't be
used often.

For other FSes which want large atomics writes and don't support CoW, I
think that they can follow the example in [0].

Catherine is currently working on further xfstests for this feature,
which we hope to share soon.

Based on v6.15-rc1

[0] https://lore.kernel.org/linux-xfs/20250310183946.932054-1-john.g.garry@oracle.com/

Differences to v5:
- Add statx unit_max_opt (Christoph, me)
- Add xfs_atomic_write_cow_iomap_begin() (Christoph)
- drop old mechanical changes
- limit atomic write max according to CoW-based atomic write max (Christoph)
- Add xfs_compute_atomic_write_unit_max()
- this contains changes for limiting awu max according to max
  transaction log items (Darrick)
- use -ENOPROTOOPT for fallback (Christoph)
- rename xfs_inode_can_atomicwrite() -> xfs_inode_can_hw_atomicwrite()
- rework varoious code comments (Christoph)
- limit CoW-based atomic write to log size and add helpers (Darrick)
- drop IOMAP_DIO_FORCE_WAIT usage in xfs_file_dio_write_atomic()
- Add RB tags from Christoph (thanks!)

Differences to v4:
- Omit iomap patches which have already been queued
- Add () in xfs_bmap_compute_alignments() (Dave)
- Rename awu_max -> m_awu_max (Carlos)
- Add RFC to change IOMAP flag names
- Rebase

Darrick J. Wong (1):
  xfs: add helpers to compute log item overhead

John Garry (11):
  fs: add atomic write unit max opt to statx
  xfs: rename xfs_inode_can_atomicwrite() ->
    xfs_inode_can_hw_atomicwrite()
  xfs: allow block allocator to take an alignment hint
  xfs: refactor xfs_reflink_end_cow_extent()
  xfs: refine atomic write size check in xfs_file_write_iter()
  xfs: add xfs_atomic_write_cow_iomap_begin()
  xfs: add large atomic writes checks in xfs_direct_write_iomap_begin()
  xfs: commit CoW-based atomic writes atomically
  xfs: add xfs_file_dio_write_atomic()
  xfs: add xfs_compute_atomic_write_unit_max()
  xfs: update atomic write limits

 block/bdev.c                   |   3 +-
 fs/ext4/inode.c                |   2 +-
 fs/stat.c                      |   6 +-
 fs/xfs/libxfs/xfs_bmap.c       |   5 +
 fs/xfs/libxfs/xfs_bmap.h       |   6 +-
 fs/xfs/libxfs/xfs_trans_resv.c |   6 +-
 fs/xfs/libxfs/xfs_trans_resv.h |   4 +
 fs/xfs/xfs_bmap_item.c         |  10 ++
 fs/xfs/xfs_bmap_item.h         |   3 +
 fs/xfs/xfs_buf_item.c          |  19 ++++
 fs/xfs/xfs_buf_item.h          |   3 +
 fs/xfs/xfs_extfree_item.c      |  10 ++
 fs/xfs/xfs_extfree_item.h      |   3 +
 fs/xfs/xfs_file.c              |  87 ++++++++++++++--
 fs/xfs/xfs_inode.h             |   2 +-
 fs/xfs/xfs_iomap.c             | 183 ++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_iomap.h             |   1 +
 fs/xfs/xfs_iops.c              |  61 ++++++++++-
 fs/xfs/xfs_iops.h              |   3 +
 fs/xfs/xfs_log_cil.c           |   4 +-
 fs/xfs/xfs_log_priv.h          |  13 +++
 fs/xfs/xfs_mount.c             |  36 +++++++
 fs/xfs/xfs_mount.h             |   5 +
 fs/xfs/xfs_refcount_item.c     |  10 ++
 fs/xfs/xfs_refcount_item.h     |   3 +
 fs/xfs/xfs_reflink.c           | 130 +++++++++++++++++------
 fs/xfs/xfs_reflink.h           |   4 +
 fs/xfs/xfs_rmap_item.c         |  10 ++
 fs/xfs/xfs_rmap_item.h         |   3 +
 fs/xfs/xfs_super.c             |  22 ++++
 fs/xfs/xfs_super.h             |   1 +
 fs/xfs/xfs_trace.h             |  22 ++++
 include/linux/fs.h             |   3 +-
 include/linux/stat.h           |   1 +
 include/uapi/linux/stat.h      |   8 +-
 35 files changed, 631 insertions(+), 61 deletions(-)

-- 
2.31.1


