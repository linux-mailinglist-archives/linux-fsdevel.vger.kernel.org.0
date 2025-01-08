Return-Path: <linux-fsdevel+bounces-38649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA00AA057BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 427563A30C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCAA1F8690;
	Wed,  8 Jan 2025 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="biijXKYr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lMgjHaEJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57E11F868A;
	Wed,  8 Jan 2025 10:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736331109; cv=fail; b=ceiiUtGoNbPbzRH3HoKx/ZdZPAW0IUcc8y6drHYedgJAl/HjH4b+VBf7go1tXJulJS0MUBA5cnYceWXrwg8BsregsCs2d6APumadORN4pEQhiwMFFzktTO8fQ0fkwq127tvQCuJGeGhMZvFad0aC+QX76sziOyuXO4pyMhSV2qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736331109; c=relaxed/simple;
	bh=easSRaRq1oWJ0tFb4hmFjOfOKyg7vKEBVOWGVOeweTI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S1b2i0SKfivnltk1Z8+/NlHIl/+cv6smkCCsZEyRlu9fjJO3wL4fjEWdlSpoUpWVPqUsgl43SAovEkFVINzEbDnOiWUctU/svORit5lyS82utiiToh+47oMN5f4TrZViijYtJZIoqva0FDb+Di5Qd+OTgRANpwpI8KsqAZmHAjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=biijXKYr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lMgjHaEJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081trHB015748;
	Wed, 8 Jan 2025 10:11:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=xeVDmedZ/JkXsoamE9UWkK1MLRn1nrbQ7g/gfRIt/5g=; b=
	biijXKYrCMvafnl0cLDsXR2SqqQkKTgqwU9BTvSc01jrFka5biS7JJo5WQPsxWlt
	tqf/bAiYdT71fu70C0xBbjulKf1hGfiQtFWGUGTYIUNfeLewwTbpcGbFXmw7riz0
	Mnbs0+UhusTfcPN2zgpClaHrJdTkbr8kKA1e1XsFpVoDxC8hotCm4DDotHPI5TlK
	x7HibKtlHq0YJvKfi96PUlEgV8IVwisBm1qfnqPIIC1Pr13UsWVxgdOVgXLPzSkH
	BFiaFZ5wu1xRPGad9UpXyJHIw7gQmAraryohnfxcF+KA0vyKcRjKsp7nQXzqK8/p
	3dwlx9wxiJXrWbVcd2S3Pw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xuwb6jqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:11:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5088E7c3011015;
	Wed, 8 Jan 2025 10:11:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9d61d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SklNrjNhMAJSc14oluXQ0NqwJUWVNupsTKX7sKBvTZrZ6uVJ7jprJZrdfJL0aZPwAk5TQW5uCQjr8WK+XhgtJ/DuBJYZlsFcSZ/f9bvzvkkw9Surwfa1djD5fidUksvmYCrzQX0J3oLxfPbLBjWdCRFNIEGlpicV51+f4nb1Aw6UgOUx+FTe8f7EDTvxw9rdtjGV2qJRWKbkz86B6tlN4m76NvWpFJUBl8o8/T1t3wkjKRefZoWrJc5/41nISIW3nXqKgaf6fkoOY1a3oCeSw8dj48c7Elp81z3CEdhl3F42f9WZgwTaL36dG9CxdUp5VYEW4mpMkSVCPbr7tUPAog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeVDmedZ/JkXsoamE9UWkK1MLRn1nrbQ7g/gfRIt/5g=;
 b=WDqJSCOSsehTKIqm/iL6tobc89e6V3O8SnSi8ti50nE+9IC+T0bG1Sjs1XUIjhXsu2/07hzBmAWIFGWu/BUI6Ot/1PBKt3gYo5hfuqgIH4Jzj4dANaO0uKkL0KCpkiN63LZcCnCyAp7L0czDho0YC2QYWRSlRByc+lj+jCeIgRuC8T9YIM+Xe9nQMHBMQyEhc8OUIuFJXj6hYyx7jYSS/igpe7tA0ObeXho7+aphNaEc67Xhp3QCX7j07QW4iNfXrya8SmyXyoWC7Gk/4PCqUsduwABO7+8+9m6sFV0KU9D/3Ul4XdhkwLdEbTTmM/7gk60qrOgLhj85b8dabwUVag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeVDmedZ/JkXsoamE9UWkK1MLRn1nrbQ7g/gfRIt/5g=;
 b=lMgjHaEJkcKc/vJ7fzzsB8xKXGxLwxHNFH4CPP9DFuD+woGhKQA8uuZZaT5oFawdBWxk0ETRuHPcPZyMmExCiH3p0CtOGPihekx9C9uynjU6zdngXjI1uwm4tEUnxhKtlJ2eL+7lHsw/1bwrYjLzk9eUYprMYcP1jaS7z1GTgps=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA2PR10MB4780.namprd10.prod.outlook.com (2603:10b6:806:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 10:11:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:11:31 +0000
Message-ID: <32a8102c-2243-4cc0-b35f-5be2d36ffd98@oracle.com>
Date: Wed, 8 Jan 2025 10:11:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] xfs: report larger dio alignment for COW inodes
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-6-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250108085549.1296733-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR03CA0011.eurprd03.prod.outlook.com
 (2603:10a6:208:14::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA2PR10MB4780:EE_
X-MS-Office365-Filtering-Correlation-Id: 24e6ef1d-a381-4abb-6ba6-08dd2fccd28d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVViZVJMOFNXYTZJUjJVbXdOeUpzSStZd0RwZEo2b29WLzFVdmkrU01aZ2pN?=
 =?utf-8?B?eDBUeDR4ejVUUHlhc1p6QWdkNDhxcE1ZSVd1TDVZOHV4SGpxVFRwbTJjeS9x?=
 =?utf-8?B?Qk5Hcm45QnZOanhKallZdSt6d1JLdG5vMXFKcjFRWVRaK3pmL2tBbFZpeURT?=
 =?utf-8?B?R3RPczNnTkp5TUNyRWpYUjVrdTNUWVhpTXVhSzNDckpWUTRMSUp3UERaakZn?=
 =?utf-8?B?UUlLOHhPZlFaa1VuUUI1TzF1VlU4UDh6VVlzY2RnSUhHS2JlVU5PY0djK2Va?=
 =?utf-8?B?NCtKNGs4VzhkSEk0S3FJWXZUOGpodVowUStGM0E0NEhxQXo2WER1YitrSnBz?=
 =?utf-8?B?d1pkaGZ6MnJhYWJHQjhQVzc1WWprRUhGczVzQk1wY1hTUytNTkFjcVBieDNy?=
 =?utf-8?B?SitFajNVeEVNeG8vbjRaazFpZk40L1lvVW04dVczdTNKOTlrYTRzemxqaUdE?=
 =?utf-8?B?MElTMHJVQXpVVU5vV3JtSm9DT0lXTUMxSU44eWFrY05SUnBIbW9PZE5EQWF5?=
 =?utf-8?B?Q003QWFMZWpML0k5MFJvTEVwWWxNSVB6QURaM1JIQ3RRekoyQW5jVjBGYnVt?=
 =?utf-8?B?eFZORTV3VTEwUGxPeisyallVQnMvNW5lbzduUFBONzR5bGJrNUdmZy9ISngr?=
 =?utf-8?B?cjdyaldHOVFvQVUwRHhBZ2VaNTB0Zm1MMFNGY2RuNDJMdy9vdzBIRDUyWGpX?=
 =?utf-8?B?bEhsM3c3VGRWUFRZZ3BWNlhwRzF6NFIwOTRIN3VPYTl3MnBKRTFwS3BGWDlp?=
 =?utf-8?B?aHExYVFBY3ZHVnBTMVdQRHloQmpRT1NCM2NlT0x1ZVZyVXlrdDhxVmxRNlZX?=
 =?utf-8?B?UG1rNDJCaHdlV09leEpsQUE5S05HMEJaSkJJeWJFQnVnQWl2UmJsWEhUc1hX?=
 =?utf-8?B?ZE94VkovSU5lVW5aNTVyb3ZvRWlyWEhtSUZ4NTRWOHdvT285U0l5SDJPOW5s?=
 =?utf-8?B?dGZxVGpMV3BXUk5rdkRMV1h4UGVsb09UL0R3bjRNQlBsV0w0ck1KL2NuVHJZ?=
 =?utf-8?B?U3ZmcTlXUUpIdDJlTnZzUTljSVJxZjk4Q25WQ0RwYXNMbDFUZmh2OGVQdkdl?=
 =?utf-8?B?Yi9YSWF6V3V2SlV1MjkxWWRKbDV0ODlIMDdhOWVLQzZWRWVNVXEzMVl4UHhU?=
 =?utf-8?B?eDNSNktWUWNaZlVkdVNHQ3ozeWVlWld2a3JvZjNSbGcrTGo2NUtRdWZ2Qlp6?=
 =?utf-8?B?Q3ErV3RoMXNqMlZQa01xQlBETEl2VXVJc2hyWDArdnFPcmxpK0Zyb0tvMW1W?=
 =?utf-8?B?cURHdDRCRDd6dHFVdFdwbkJHSy9ZcWJ2MFZndzFhcW9jRlNQZjR5MDJMQTdu?=
 =?utf-8?B?SUlibjRMMFcrK1k4ZU1YdjhBQjlBZHhDNTlkeWVkdHhZQStOSVkvcGVkOUh1?=
 =?utf-8?B?b3pjdlZrR2NOU254TExOSk5Bdms3dTZoQ1Y5R0Ftc2MvZVJYbDJ4dWY5Vk9t?=
 =?utf-8?B?TzhCOWZtYm9oV2FTeEE5QWM4SFZ1dzlPd0kzWVphNTBYZ20zclpOeDZFTktv?=
 =?utf-8?B?TGdkeFdDc0ZHN1M0d0dZbVRNcHhWUUtTRzdYYy91MDBmWHNTVjE0RlM3akdM?=
 =?utf-8?B?OHdmN1UvMnd6dDNFVzNYY2RCbWVlZG5pL0tmK2QzcWxyZXF5NC90TFpJV2NO?=
 =?utf-8?B?YlV0c2hTaTgrenVraDhpem1uL2w1U3RweGFjNFl1b3NTSVVURUx1eUc1VWFw?=
 =?utf-8?B?UTN5SmlvU09BVTRFaEc5UVFpa21jcGNIYk0wNlZOcmNUTlRFZVhFOTdMT1I5?=
 =?utf-8?B?SDFhY3lNTmxub0pvUFlJa2Y2RVlUQ1U2aXBVNEdUckdwRUgybUVsaHRTMGJX?=
 =?utf-8?B?c2dIUUFqc1RNQ0xDQzhBcWcyeGpWaTUvcVQrYUFYWGpuZlpTWU0vYXhJczlT?=
 =?utf-8?Q?wI7iriczhTYVr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU03dUtQRmN4K2VnZjl6VFZPOXFRT1Zxd3dxeWhrR24zc2lBWmtBWTZwcmdF?=
 =?utf-8?B?QW40QzRYL000cFkyblBBaHJLQ2dKU3hKbmZTbThadGRMWlNtb0d0cElaK0lF?=
 =?utf-8?B?ZTVwVVdwaTltUmNZWnNZcWhqUytZVU9EQ2ttUHc4TXRodWZuZFdPQUw1d0Vx?=
 =?utf-8?B?MzQ3WnVkS1BQd1BEMHJYV0hXQzdMMU0wYWpILytWVDFUQzVVVnVWQ05Scm1U?=
 =?utf-8?B?V1pVdlFEeFJjVUtJNithcUszalBLNHRtb3pYK1R1OHN1ODc0ejhTT29veSt4?=
 =?utf-8?B?bmFKMmoraEFzUFhtaWtGUE56ZWxPOHdma29kNDhncEhZTVNCUGNJWUZnVnVQ?=
 =?utf-8?B?VTRQVVc2MDlvc243Wmttb3dZVFE2dEs0WHFLdUZUcTBrLzBGbEMzR1RDOUFD?=
 =?utf-8?B?WlZoblVVQ2NteXEyT3FYOEdwMnZOemEySnBvdHVIcWtiVEFTTnE1NWsvblRF?=
 =?utf-8?B?OXF4NTlpU3JVSWd5QTRKYzZmYW1uazBOSmJ4U091UXRkamJSQXl2SVM1dXBB?=
 =?utf-8?B?VDNiUUQrZU92Q1pZdmV3aVVHbWVTdlpxVkEwUFE4NnQ0ZmhCenVyRmQxUG1K?=
 =?utf-8?B?MlZmcFFHa2pTa2swb3UxQkU0cklIRXVldCt3MjhjelVjUGd0dDM1REYyekht?=
 =?utf-8?B?NmJUaEZCd3dDcE1nYmE5Y2VtWkJpL3BiOWFSRXBwaXZzUStHdTd6U1lMaFdh?=
 =?utf-8?B?R1M1eERKaEJrQVN2NVRVOUtGOExGQkFFREFOdDZqSjFSczB5TGRLekdtMnRt?=
 =?utf-8?B?cWNtL1VzNEs5dHNPOC9LRnhybjVld25kdTBaKzBiN2Q1andiUjJVZ2h2UE1o?=
 =?utf-8?B?bTZTWWVWSGxHdVFjRno3Qko1Wmljb29KdGY5T3ppbGk3b1FRNElzdThoeWZD?=
 =?utf-8?B?MXphM1MzRFhxTXdMOUhNQmlBMXhNZDlHc3JHUFpCa2hUUjBianF4WE1pN29Y?=
 =?utf-8?B?c1ZxUUF1TjdNeTdIVENONDNCcFp1dERpOXBLYXhYNzMzZ05MZVE0TXFkNXdN?=
 =?utf-8?B?eEtHdDZhRTdabm5XYXIvYml6eW1LdHVsVHNZMjVRRmxKSEJhSVZhUUVqdmt2?=
 =?utf-8?B?TEtlMCtveEJjMG5yOE9wdGprRU5GWWxWTDB5TmRjazdCOGZOT3BpczMycHNi?=
 =?utf-8?B?cGtDVGFTV0pyV1UxNVdHb2gxOVROWWVlNlg4TXg3L0dUQjEyZ1NhcWNBbVVE?=
 =?utf-8?B?c2NsNVorKzZWVkNGQWxXa1UxZFdIVWdTVmZ4TlMrbVRqVzBmWm0ydE1OR0J1?=
 =?utf-8?B?Tzl6VmFmNnhhUzF2NTY3L0xHdGtmT0NiVm1CYnB4V094V3YwWFd1bHc2SFpF?=
 =?utf-8?B?SDhCWmNzbVNvbDkwSDZ4VUZZUkMwT3lVNlZ6d0dqYkpUQ0lWTW9CaWVmWlpF?=
 =?utf-8?B?cXJaOW5ScFgvQnNNV2lQYUV3R01EcFU1SVZYUzJ6NHV1cWU0NkhnSzVFU0hz?=
 =?utf-8?B?NGZmcUFxdnphVHB5VkRPQ3BjYm5jOGFqWTZ3VmV6NFFvUnJ5dU9nS1JkQ3U0?=
 =?utf-8?B?ek9xcGU4SnpnaGh2aFA3ZE1BVzVtWTR6dmpVUlRaOXlhRkVjVGlRWnIza2tM?=
 =?utf-8?B?RXpFckFPa1kyNXE3aG9uVFJHeXhGZXhkWDN3eU43OTV2TVQzcS9GSmpad1E4?=
 =?utf-8?B?ZzJ5cXl6djZYS2JXcHFhaDB0K0g1SVVyZWtLQnNQRHQrWFdtOFo1N2NNT0Vl?=
 =?utf-8?B?aHpqRkhud3dQcUNJZytnUEtId3hZUjdmZlhFZjUyamJnVVR3a2NwS0xLUStF?=
 =?utf-8?B?Vldjck9oaFAzTm9JL3BiUWFVeUVLdm92TWpBMU5OSWMvb0N5Z1Y2di9YUFZo?=
 =?utf-8?B?WlVaSE5aTFhZbDMrYkR6RDU3THFHR3lJekY3OXpXcTM1SmIwMXVicFFwUmNl?=
 =?utf-8?B?UFU1WHlHZmcyUEVrWEhFek5YVDZyNlR5VnpsdnV0RVhoSTM4ZVpCNW13S1Iw?=
 =?utf-8?B?QjlhcDhiYmdtN1pQcmtqdjR4QnhXSFkwOUNpMEhnZjRIN0w4RmpDaEw4RHlr?=
 =?utf-8?B?THJ5TzBSd1MxUWNWRDZsT0JNdkpWOVpMb3VKdnVmTEFhTWVhRmo5b2FjM25S?=
 =?utf-8?B?S1NrV3laQWxuZjZhTlUvLzhpaURHSS9yR3h6S3c4eExvSXMxYmw0eUV0TktR?=
 =?utf-8?B?L3hpWnVYNnZiVGxDOFA5OXBuVXJ2WDJOTnE5RXp6cjNBVktXdFBzL1VSNHZv?=
 =?utf-8?B?Qnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KnitVMMHUtrvEUchbXFAOqWPWRgEK2fRvcqbWYLQzbSyPSsw7qNOlipNwgdGffAqX9HSbaeJ5iDzb/ac8PNQAt0EH1mgN+wFaLlDNATLaZUBnwscTeuzg7/YpHo7TEHIonWQ4963OzcYWysztId+f4lbZOF9AIn/0ROoZiLoGGLj1vFI6WVeTU76HCymZIVJGZtvQEvLS7FlJ0tWQzjqipVfWkmQ8ki/j1uo35jaqt9ekK2zhREcOR0db46nqeQigmu5tqBsrb5r2kueAsvSWL8XPkuqDM3lWAjzYV9diSVnZMDuK/t+8K15HtbxLFkPlHKDYu7gnZfxU4kRSxVvratWDA5+VrV3lzRoyj06yfFAsHj1FZez89i0jsguTUHZXqrVI3xlZzmn9a11hMLFdOxxDZOztFkTUJUybFt/yB7q+SJTZ0SPbYpsvfoF0V10v70JrEqkLhH5ddzW8ubGjrK7/d1n4IjoIM7Ls7CPHUkcdXi/aXFAVNzSc5T916Eo7OvKh3Zs7IaezrGqHoGWbDvRKJv0xMqurFHFOk3jn3hNmCCpn/wkq1KTcJwQKMyn7FVQ/5OXpUkpSRZAHAQVBOpoLI2ntckQcpspu2GDKpM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e6ef1d-a381-4abb-6ba6-08dd2fccd28d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:11:31.0896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mR8kkHmj9eUnQPbODwFZy+Ew2ycehom5GKBvDxnObzKvE8O0YlIp6ZfJ7nfpJPMwDmI3OUpMXwU2rMpTOHHvTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4780
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_01,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080083
X-Proofpoint-GUID: K-caHVN2hqILT3vX4UOzO87rWScKdT5x
X-Proofpoint-ORIG-GUID: K-caHVN2hqILT3vX4UOzO87rWScKdT5x

On 08/01/2025 08:55, Christoph Hellwig wrote:
> For I/O to reflinked blocks we always need to write an entire new file
> system block, and the code enforces the file system block alignment for
> the entire file if it has any reflinked blocks.  Mirror the larger
> value reported in the statx in the dio_offset_align in the xfs-specific
> XFS_IOC_DIOINFO ioctl for the same reason.
> 
> Don't bother adding a new field for the read alignment to this legacy
> ioctl as all new users should use statx instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/xfs/xfs_ioctl.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
> index 0789c18aaa18..20f3cf5391c6 100644
> --- a/fs/xfs/xfs_ioctl.c
> +++ b/fs/xfs/xfs_ioctl.c
> @@ -1204,7 +1204,16 @@ xfs_file_ioctl(
>   		struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
>   		struct dioattr		da;
>   
> -		da.d_mem =  da.d_miniosz = target->bt_logical_sectorsize;
> +		da.d_mem = target->bt_logical_sectorsize;
> +
> +		/*
> +		 * See xfs_report_dioalign() why report a potential larger than
> +		 * sector sizevalue here for COW inodes.

nit: sizevalue

> +		 */
> +		if (xfs_is_cow_inode(ip))
> +			da.d_miniosz = xfs_inode_alloc_unitsize(ip);
> +		else
> +			da.d_miniosz = target->bt_logical_sectorsize;
>   		da.d_maxiosz = INT_MAX & ~(da.d_miniosz - 1);
>   
>   		if (copy_to_user(arg, &da, sizeof(da)))


