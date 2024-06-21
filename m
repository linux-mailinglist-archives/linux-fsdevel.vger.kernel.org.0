Return-Path: <linux-fsdevel+bounces-22093-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD816912186
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 12:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFE8A1C22231
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 10:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC55171648;
	Fri, 21 Jun 2024 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTHpOcgM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z/kMHyTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E9D84D04;
	Fri, 21 Jun 2024 10:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718964380; cv=fail; b=lDBLOVS7uKT2WY95K4vB0ol0KdA9Oxbk4IrgO7TE7Boie8i71+yhwsVkwK5MWBrxsyiiAhdPeI0iQSeixHmNtl21jGvFcIGk9AE5Coc4VJGtWVP80oXuxf+8ez3vpgpuS18kDIYGNPe6aGSXPYVkg87DoDyIR1LDSEBZZi2ztm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718964380; c=relaxed/simple;
	bh=R5IY8Ul7LJaRUZEYmRTbd8wBnFo8TiDpaRa/agaexN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bs9QMxp5fJ34qiSUvrPQ1bHQAQnXbFfzXqHeMev15rReDjjRuYZovv3uzYQYbfTc3cy0uhYFoI9omvr/BY/ax6J1rSq+vjSKnFpt39pY3l7gncFlZXa890AMI4vTXjBzz5dhoHzjLPH+pgQoEUQVLIbw5Sb2vClUKRNi2qIbgo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MTHpOcgM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z/kMHyTw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45L7gCnf013265;
	Fri, 21 Jun 2024 10:06:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=MjUuXW56GSzvXIpVrRAGoX61qTZTfovOQxGNmcfXok0=; b=
	MTHpOcgMx7zcbMqhz4CNbZ+Nji7SDKyBNsyEGvtIOD5uAn1TUgqqH9bSM2/I+0PB
	Lw5SQ67aE68/Oz2KV/5i94Iho/fQnfafn9vAWJudvgDv/PGB4POuHPoAd/s7dnOi
	+8ZtVU7ERBQ3LAe3Xe7X3gv+oVsOB16cPY5isd5eV9/AdPKwyN37acG0D4hYy03B
	gH03LI/g4ZKCWX34InW5OceJRTjBGcVk6YvKQak8tIixp9ETgUbPmv0HikkArmap
	3iaHGhzZmmUCpmgrIvP0uOOTwbWXsM5tmQcvyRX0XpKok8u02m4tt77V8Yofusoz
	0Ruvt93ni9ExEUV60r4SxA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrka1e83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45L8ZH1N012861;
	Fri, 21 Jun 2024 10:06:05 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn4er1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jun 2024 10:06:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rsl20+uAEJlYjt/9/h80DV8j5PYfi7gMxCRadBKnOPK4+7p77Vkb6JLzWagyEorMxZ6y/foF3db79HSTmME3BteclGaU42VT96emKWFx7HH5RFMqmEDwdiudEkVB6QcxZxg7m6WQVfMlTr+IpuxZL6UiWoT+L+PGE/CIk+6F+HI8VW6osBptQWllVJY4bTK8pqnHXHcSzDBRcGwqV7YXJ7hanIleP+sn2WzQDVs1JmcvZZECvAZoGNXtf5MTPh+1cD8kbH4BXubJn4K7es+hhnAE3I1q0RRBL7ZAf70+0Zt3TCzk59l/jQHjiIh0dBOc+68/rk0faI3R1mN8toXl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjUuXW56GSzvXIpVrRAGoX61qTZTfovOQxGNmcfXok0=;
 b=ardIlGdCTgFBHrBeRoM1bXIlhywttHnqPySIXSTNKoi5yOhj2FdGk8i5hidV0C08qdqniTLGMAtQ9d5iyvKOYK5EcW5/Wnsokq5ZFsm7+95yPSkU/+wiWQI7AM/L7uuVWxSNTbTI5xr2m6LBxHGZ4NPLwqprzAQxbTRX8K0mZsTUvC91iQi3sy/n4zHaEXmQ9Ju2taByXLd66XJv04NZWS3yaZhEFBTavgpGALX/D37qwQYNydBs132FxSV3VexAu/Q7rBA5/ydp8Sv5RDO5un07hbWwdF8hw/rCHqukr0QkejaNBb4PynplfP9Ro1OYz7dbZyaSI3/GgOpi1545dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjUuXW56GSzvXIpVrRAGoX61qTZTfovOQxGNmcfXok0=;
 b=z/kMHyTwcFAYG/ieKbjcgkPdQn05vB5lqU+BmMtNYDK3NMRhpOUkChr6N6Tlwq4loxL+BsA3BjsGfcxd1znY5KKtmuD/FX0xDvW8RBVbZGAchjYMtZm78trUT/VphPQuG4/YGudk8PT1DPu4asVpmiB7/m+dZgilJgCCQUy5fwE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 10:06:03 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 10:06:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 02/13] xfs: always tail align maxlen allocations
Date: Fri, 21 Jun 2024 10:05:29 +0000
Message-Id: <20240621100540.2976618-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240621100540.2976618-1-john.g.garry@oracle.com>
References: <20240621100540.2976618-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: dcff29f7-0cf8-4fa6-e230-08dc91d9c239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?SmXw1KS2FX71wcdWwDMx0GbWIp3/hG8NJ5WVDOdHpeO0u/u2ALbUoYSM9W/d?=
 =?us-ascii?Q?MFdppuw6kvXxNZelGxFAAE58AbQbEsH5yKQBfxYKmkimYpdmg3zetnloJZ3l?=
 =?us-ascii?Q?ekS/u8FovTURdBD3b98cZRwdI1f0XCGM9HH9jNj7RDjvuENbQtzKRQZdegpS?=
 =?us-ascii?Q?gNoWBJ5GbhlTFGt2SQ4jdgSZ/0JNQtxKgSB+dgqHy4l+cx6ZEmxgeIdy3m8k?=
 =?us-ascii?Q?VcCkKu3e5/1OgOsQCHkjphLejjAd7GVnU0gxIPJchgf9AuIDw4R8EgfRQy7x?=
 =?us-ascii?Q?ULE8Bcpwx97SsiphPCC6u0csdxiyniKjvbGLjkonnt8jZP3SWheiqCLLiBBM?=
 =?us-ascii?Q?KMkEOJ7g6zvXRSXS7t3mg9Deh2e7lAosTfMpAaoTGTYCxzxoSgA0IjaW5Nyt?=
 =?us-ascii?Q?CcypJ7rNPU1G7tuspupT5sQozRLIXjkeQCzYFzgAMQSI3NhcX0+LBr89sZzJ?=
 =?us-ascii?Q?bbxbuIvFXxag/FSVfrzTHvltHib3h/3nxgtokoP7O+QYgsEw4G6zg1Ak90un?=
 =?us-ascii?Q?3zaAebk5JMlGb871e2cgXpu3P2+vk+pWcBpS6HRVWXLhCpwBDsVQMjqgDZQH?=
 =?us-ascii?Q?4f6sISmG16RvUA5kU1LihPw1alQMaBJmtv8t4/Ya3hjsM0fFsJa4wC0Rn9DR?=
 =?us-ascii?Q?bcbR6YQzrVTzKIX0Q5f5lX+akywJodR8tV7sfao3zx+dg39/s7T5cGAgvkQG?=
 =?us-ascii?Q?H/1Fb6iYBtKi3dwYj/hhOmQwzzZwEKD1peiAIlM6eQKVcFZjfiG9Jvd5Kybi?=
 =?us-ascii?Q?D9atkM8uS4w6coZMOQcRHOFGa5hgF7woMe0vOH2x6TkuaPjSM0zaEgUaWUue?=
 =?us-ascii?Q?6tSyOi4Pl5ratdln6D+yzNVilkx1h63vF1rfQejhfgWZeS90eKa/ZrBojFnG?=
 =?us-ascii?Q?OthTazLcihJryTqpf5d1glZyPzZUcgNx1svqkiDmxlgXOvo8nZVrhdaoDXb/?=
 =?us-ascii?Q?8BPUkfr5cpFZhjKEx1u1eQxVPMbNQqt8a5pzy9tnRdsRadUccne9DbMeANP+?=
 =?us-ascii?Q?2dMdNg+cKPxns3LeeWMhmP5Ql27ISF53Mq8GcWXsLbUHiMv3zUol52KsaKga?=
 =?us-ascii?Q?xmSR3WwrdCQ0/Kkp0/rSar7B9oIEV6+Tn0DVtUuPIhBXP0Mo/1K25qvACKoA?=
 =?us-ascii?Q?n6Me5PHuuGg+V7qSiJ3i410omikTSCb84fgW2Gqs5Ubr+K5tGTQtKDmm6Fel?=
 =?us-ascii?Q?quf86LJ9PvfUSHqZiUqvavtMBSK/uuUKWL4NVEIm+Ep4imaIlHLC/SMkgZQP?=
 =?us-ascii?Q?Sv7IKqKJJ3FuLZa2fhXuI0NvxFUjnq/SPtKzJ9yV4m54ssUuHd0bGgLCwBiX?=
 =?us-ascii?Q?A/iOIIWm4wK3i1UwVvT83qOl?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DJQ06zjfY5OWnYQD+O4p+1xpf/rSjmTX5+xc9BudFAs/7OB8+gqJFQBrVW7w?=
 =?us-ascii?Q?MPHzuoOhwsXak6Y30ELVoVq20zcwPY5wokd7RXEntNbm/BsYcYGKndfUnQms?=
 =?us-ascii?Q?XHizqel3bYVhGAFe2R9MrfOgNI/8qcE5tUw26TQCJ1C1XGuIR8mvcD52XhiZ?=
 =?us-ascii?Q?83Wu4q8wRQyc9FAdGhznwExNAtUFbaYz1C2k25an6Xx5zKY44cfH2AtkQz9L?=
 =?us-ascii?Q?a6viydZRbkt6Woew2FDiLZlyAEg0lDeRP/JaC8FrvIV5TCVrJBVEmFOXeOgd?=
 =?us-ascii?Q?jn0q572GYp+TIGTU5Zq4uQ5gi4XQGeL20zLy6e3IhGfIu0Nomc2YMMLXRT/s?=
 =?us-ascii?Q?8xIUWJpDwT+tLFPJbizcy8R4hzrWNMjAb+6bDup42IOrpdphTUv4dhasjMGg?=
 =?us-ascii?Q?RveqN/Zk0GY7SRIh59PNWAAobqHL+kXg8ZwVk/k529lnZSsf8oyZdcZpxJqu?=
 =?us-ascii?Q?SZwDbVP7ZKGFuhfI+3tBWBzJorvUxm4Sw3hsVc0TQ18HuTah21naz8VeXlvE?=
 =?us-ascii?Q?3v4GZKe6oZQivG+uhZg/zgTbdootMX2fXr8AabSID9qKyoI8Yc+imuvTG9m+?=
 =?us-ascii?Q?C52CQPK+Cchk3tvZSfCDUV2Df5+2wjQeRUveepmWukMr00Et74l4+pDFtR23?=
 =?us-ascii?Q?bO/R0rPsu0d3LhJaXcXry6ycHlZxcwAF0ZPfX3yM44dDdctXbuwUpQ1/djrW?=
 =?us-ascii?Q?/PnQzyvh6QLFoKRrLgvTYR302aArbMQhGlYzkOTQu4492ABcZOv8lu7vjc/e?=
 =?us-ascii?Q?PM+h0Bzqm49HHAppyemcbRGH8YGDMnDzTp3+g8miRMb7xrNozBdXeF3KogFu?=
 =?us-ascii?Q?8c75yAFHjHX4X0JW3cEp4yRIvLKRw0QvHznFeLU3tHVMtbRnfxukyyFfv/5g?=
 =?us-ascii?Q?p4U3QKZjTxMGUSJorPMKHRt+yg5P1z+oZwusC5e11Yun/jqbxO/cTnEOiBg1?=
 =?us-ascii?Q?68XtPFMWHd+lgy9bXlQYfyw42MnyN2YtWXKO9J1hjOZyC7jh20+xD/LhTkQO?=
 =?us-ascii?Q?qLN9xlFRoqo+oIuFSq/ajvF79F/6TjOJ9+3DjqTnGZNl7BSXMos+MivQuMH9?=
 =?us-ascii?Q?NHVX+k2mTX2SO2EBPbsUmctKENSly04vClaV1NcB4PK1MA9NZCKn6w0mzQM6?=
 =?us-ascii?Q?Zh16hoB11eYfGW5ykzJ9SzGgk0+PrW6PTpafxvPUt+eCnvMp8aqfT4a9hp26?=
 =?us-ascii?Q?w/ylY/1/8IAFgVjPJ5qA1ts/9rPIBmM6LhlUPmOD5KguELLS0SnGpR+ZG6gF?=
 =?us-ascii?Q?9BycQnbgVidUraKb1rE66TzL/TfTxmT66CxeR26BZja3+AxgpzkkC8kcsYr2?=
 =?us-ascii?Q?yEld9xG5Y8xMpmOl+O2NAG3i6s55MtfrjgE+atem5gyjz0zU0Z/cE5w2VtjQ?=
 =?us-ascii?Q?ktEUv1oqJzLu68zMNTOIH/4CQUGGzWMJ6/QcpjAmzfiwL8ZMJTgDNTrZnOis?=
 =?us-ascii?Q?YudzVhQq+HoFrb//usZ31xx/Ihv+KB0rCGJNWaOKFny8zvjftREaf6Vf5F3R?=
 =?us-ascii?Q?rLs3wGTedcPpCMyj2uFFvlciBLg9hcMf4pL8T0kNO6X9t/miAXSFN64FrZrr?=
 =?us-ascii?Q?rHk4IsuKRPfNl+r7qy8Q1D/qEj5zqNpREE8ZWhQK6AC18mzvmMY8Wcb+Q+4p?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1USgCHVpUwnX9xXJj/rVMc2Mg1BVcVQa9B1RSgbzJvfaibVf8fy/7/6O7xei+5fBzeKuBYq68BlbfiC07fhGs0lgB5XQKEenEQ4eBbN4MQAMz742drLjG5PSZDLl2Wzl51S+Er9yltYr9F2ITxUqfo33/1PSnMW+Bq8z9dl/UdhjKm4SfJoAqpapA/jfgw1PZA4YSre9/a/8QOv5M4aJEgObiqkLSpYebvWO5jo4TlM6Rz/UySsPOKifO6WNxgBV6gfzDuQXl9uFppgbE3KroaRmxM6CrhX3EKtm9IqKP0wcVrvTwmFLTs5SNQtP+FybB9rwU3i5RFottVWxLpL5UfnOijMe0kMx37Uk2AXVBiMZzCSdmX8goUT0uuEl6IFIOwd8c8L+CY7xsFZXeUxOJTfExH5RGM+jVXPlZscQvWliAKDsk3UNcYElwlljhCi4cOIrB/N6Wkc0tsY7iBTqjjfaSxSHDfOtQXjIFFLsPUbTyHIB2U8yQ6eu/SCy6jHNbcw9Y+Wrq5kpho7jiLB4b2nAfkGud/o6ff4b3Itv/XGHDA06yWPyi0jm5SziROqzKcvdZF3VhPxEYu+1plwop53HNExoe0yfM7IdsRw1uto=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcff29f7-0cf8-4fa6-e230-08dc91d9c239
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 10:06:03.3286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1U77I3I/0/QJ+ypwhb/ELeke9qHCU8XIPYrdgTox8unTM4yPy0eIeoGC4WnfP8qlnZC2tjgy8AEmetfOERBmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-21_04,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406210074
X-Proofpoint-GUID: eqztgK3MUltZmWeYGwZ1k6G3Du6SEl__
X-Proofpoint-ORIG-GUID: eqztgK3MUltZmWeYGwZ1k6G3Du6SEl__

From: Dave Chinner <dchinner@redhat.com>

When we do a large allocation, the core free space allocation code
assumes that args->maxlen is aligned to args->prod/args->mod. hence
if we get a maximum sized extent allocated, it does not do tail
alignment of the extent.

However, this assumes that nothing modifies args->maxlen between the
original allocation context setup and trimming the selected free
space extent to size. This assumption has recently been found to be
invalid - xfs_alloc_space_available() modifies args->maxlen in low
space situations - and there may be more situations we haven't yet
found like this.

Force aligned allocation introduces the requirement that extents are
correctly tail aligned, resulting in this occasional latent
alignment failure to e reclassified from an unimportant curiousity
to a must-fix bug.

Removing the assumption about args->maxlen allocations always being
tail aligned is trivial, and should not impact anything because
args->maxlen for inodes with extent size hints configured are
already aligned. Hence all this change does it avoid weird corner
cases that would have resulted in unaligned extent sizes by always
trimming the extent down to an aligned size.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/libxfs/xfs_alloc.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_alloc.c b/fs/xfs/libxfs/xfs_alloc.c
index 5855a21d4864..32f72217c126 100644
--- a/fs/xfs/libxfs/xfs_alloc.c
+++ b/fs/xfs/libxfs/xfs_alloc.c
@@ -432,20 +432,18 @@ xfs_alloc_compute_diff(
  * Fix up the length, based on mod and prod.
  * len should be k * prod + mod for some k.
  * If len is too small it is returned unchanged.
- * If len hits maxlen it is left alone.
  */
-STATIC void
+static void
 xfs_alloc_fix_len(
-	xfs_alloc_arg_t	*args)		/* allocation argument structure */
+	struct xfs_alloc_arg	*args)
 {
-	xfs_extlen_t	k;
-	xfs_extlen_t	rlen;
+	xfs_extlen_t		k;
+	xfs_extlen_t		rlen = args->len;
 
 	ASSERT(args->mod < args->prod);
-	rlen = args->len;
 	ASSERT(rlen >= args->minlen);
 	ASSERT(rlen <= args->maxlen);
-	if (args->prod <= 1 || rlen < args->mod || rlen == args->maxlen ||
+	if (args->prod <= 1 || rlen < args->mod ||
 	    (args->mod == 0 && rlen < args->prod))
 		return;
 	k = rlen % args->prod;
-- 
2.31.1


