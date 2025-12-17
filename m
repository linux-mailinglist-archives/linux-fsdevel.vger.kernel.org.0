Return-Path: <linux-fsdevel+bounces-71572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C11CC8426
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 15:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 023B83042486
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Dec 2025 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6347D34C80C;
	Wed, 17 Dec 2025 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J8oCJVQ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hJzXWtdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FA34BA56;
	Wed, 17 Dec 2025 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981490; cv=fail; b=sX6DaYJsA/cU8cJ3DwLUNg1ymu1afSKPdVi5O2z09Ah5iUrE8rLnFRP3Yq3geqmvap60V+ZHUP46KXajoiXNaB93bu90z2cICHX014FLaouLFqqo2qh+w6OCKIi7fpamlmAWS7tiepfz1AQEGXMWN5RKV3eXyG/MjPTRe9Cxd10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981490; c=relaxed/simple;
	bh=ahLgNxyK/YX1Hp7iANcLGdPUq4uRjxeyOtw3YPvI4E0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OX2YMlsH0PnFQl7gDNJaPgbj2EnR/PODTSPqXflhFv3AbWftn/fbTilHaQkBX+V5wLGp9WLBmeCb2COKDV5aLMbese4IU5+Z7EzMlM8/+2C6z6P+ZI1SabjqtIiCspJI3B2lhxLyYVSrlGL9tW+H5kisnpWrDwM3ZY51kXWfqOM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J8oCJVQ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hJzXWtdE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BH6O9vC2184117;
	Wed, 17 Dec 2025 14:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=dBxmcHb/R/2AZZvasTxMjMf9jKhD+2uE/GBIuxf9tQU=; b=
	J8oCJVQ+TyUuq6TL4oQ7WFrK+6szANqEDaxqEk/wif+7yVJ5mr0lr6dqNPAeoBcO
	NjY2tPK13FZu14moPkn8hzd0QL9VugSbd5JpOQx5QaAxjQiL297dgQMavsAMlegn
	NcY4062SEFXrMkklmrwHeisW2Cm4ahAFNdnAvsYjVFjvkJ2oqFh3BqcOdXk0sMwf
	pcWF3Ol8WUSMou/cy8+f3Jt899Uz2XxameS+qjpU/2mHWLqiwjWGTfxKnE3aRjc2
	sXp5etyHNzeGrbA1HJX4LQqKx7bBdX1k1lCzuTAi6gNIO3UR+YsbaDUgPe9y3fZc
	O5mWUN0hnSOwVt2gnQ1vXA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b1015wxbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 14:24:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BHDZSNu005928;
	Wed, 17 Dec 2025 14:24:22 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkeku1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Dec 2025 14:24:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1XGcgl4rXmLCvWmpNSvFmeIcfGXuThKxPiTb0B8joSu3evtN10clVj19NaS/zF5RmmleEiwh5wQ/yNPHFUk4XG3tzED61sqGt+4Hvv5ea/ozDtqEF188Nt5qqzHdo8E//hm0R7U0VyxirTGanzDi4PvYP4JMaIHAJUQDxph1nffRIs/4U7UIimf4ix5ou3hBqH2WCsmdFRzlJJmtT0vm1GKmWAxLKGBoxcPrG0mmPcZrzyAGl3tsuImoMyxHHvb8c0dsMatj75cSMG1ummbHM1+5us7RYcjLdBAM54iouIwUlM7YophH4FCCke5DGt724fKMLlYK1ycrxYXNY/sWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dBxmcHb/R/2AZZvasTxMjMf9jKhD+2uE/GBIuxf9tQU=;
 b=pP2AuNbl6AdQp2WYV6iLqhARMG04WocQ3nGazb2J0NMt09rPFjwzrRUoVg97N0oYEKhqB2zj8X4OVjekAPEv73r/rARri01ZHfsld6eKI0OBN31G5aRsImCjujqZU8vpfDa9KWLu0rjXz5HkpiMjPs25CrloKYv9aiai4+ak+gJnJM4sPnUC2f1JYDNm6pMRO/91juYe29YsgksNOnBn0vpFAoipkDEohne2CdlFZfdlK1iHV7U6z9t+TPL7sQMKOedRV90XjURLSan/0tmfZiuNgOSMJdQJtVII+SfuDZSNKdzO9r9hmFf5rk4jSddbGdcl2f9/umDcS2oqolkPqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dBxmcHb/R/2AZZvasTxMjMf9jKhD+2uE/GBIuxf9tQU=;
 b=hJzXWtdEbQ1yAi4sS9LQZx93HJjHyL6KRA2Tf78LSuL4OCfXgLZyOvgXlvBcQSZw7ycBU7QuS+Y6FhKETH5JPmJPCOiOSHqO505dqXLmK/Nw/V2yhrYq73X+wNoWKMvQ5v3YuUviPdJnbjz6NifCn1Zi9kMv6UnzttsUVRMxV78=
Received: from DS7PR10MB4847.namprd10.prod.outlook.com (2603:10b6:5:3aa::5) by
 DS7PR10MB4959.namprd10.prod.outlook.com (2603:10b6:5:3a0::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 14:24:19 +0000
Received: from DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed]) by DS7PR10MB4847.namprd10.prod.outlook.com
 ([fe80::f8b0:7eee:d29e:35ed%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 14:24:19 +0000
Message-ID: <d272dc63-a157-4dea-966f-003cefa28d2d@oracle.com>
Date: Wed, 17 Dec 2025 09:23:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: NFS dentry caching regression? was Re: [GIT
 PULL] Please pull NFS client updates for Linux 6.19
To: Christoph Hellwig <hch@infradead.org>,
        Trond Myklebust <trondmy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <36d449e22bf28df97c7717ab4dfb30f100f159a4.camel@kernel.org>
 <aUJ4rjyAOW3EWC-k@infradead.org> <aUJ9hliJJarv23Uj@infradead.org>
Content-Language: en-US
From: Anna Schumaker <anna.schumaker@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <aUJ9hliJJarv23Uj@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:610:e4::16) To DS7PR10MB4847.namprd10.prod.outlook.com
 (2603:10b6:5:3aa::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB4847:EE_|DS7PR10MB4959:EE_
X-MS-Office365-Filtering-Correlation-Id: 37a689f9-3eae-4277-6de8-08de3d77f71b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THBTRERKT2NUbVc2cEJXblhkWkV6VGpPTTZ5NDJBY3lFbnlpSVRwamJIWmlr?=
 =?utf-8?B?TjRqZlBkdHllMVJkREg0TmVVMks5RGkwTUpEdXB4MHRSWUdqQ0FBbFUwNytx?=
 =?utf-8?B?Wm1jVTV4UEg3ZWxGWG5yRkJ1M1J6b0FnY3M1WFhyemN3QXNUNGdER0FnM0Ri?=
 =?utf-8?B?SDRmU1B6bDdTT3M1V3h1UGdibWduS0xLNlI4K0Uyek03LzdldHhnei9UZFBk?=
 =?utf-8?B?VWpTOWVwZGlIc0UvNi9YdlVrVlMrb2JEZnI1VFJxSStGUXE2MTFpbGtuZ1NO?=
 =?utf-8?B?L3lRKy9pNndzZEI3RkZkdkRvWjlHbk01NnN2SHVCTmJLQjdtblhWMDdLOWJq?=
 =?utf-8?B?aGVtNUpvY2NUdlhaMSs4UFBGeHRhK1VVRHRZMExHOG4zRU1GeXBiaFZyM1F3?=
 =?utf-8?B?T3Z2dFZjRmJVQ3pFRkl2QlBqdjNFTGFsQ01uVEY5VzFsTlRZcnE4Z1pOL1o1?=
 =?utf-8?B?eUw4U0tTemNTMmwvODhGSWVOVlBONHcrK1RKVG1XZmhUYldMOVZoUUJob2o0?=
 =?utf-8?B?M1FYNEtlSTN6V1hJZVg5QTNjaW9BdDQwQThYQmJtNXhRZlQwWVhmb3FUbzVZ?=
 =?utf-8?B?b3BMTVZqMmlvNHQ2ajNBR2NmbHZsNCt3RUN3WFo4dVhmM3FPVGRpZ2c3NmdI?=
 =?utf-8?B?SFp2REFIRGxJaGY3UU9ra29iTWRtTGdSZCt1c0xNWlEwbXpUaGxjZmtEZHZh?=
 =?utf-8?B?RlZwYXlvY3dOKzFkS1RFU0RYK2FuOWFJWXpGUG9rOVlCbmhtQnJYQjRpOGFh?=
 =?utf-8?B?UXVwVGJRalhpSkZNVkRIbE9yY21zb1BPdmVtelVRRlBJSTd3WTQyNFpjUG1N?=
 =?utf-8?B?RXFYelMzbDhNWlBtMUpOcm85RkpCZlp2Mzd1VGZOdS9raUt3UjJEeGhpOTg3?=
 =?utf-8?B?VmlaZ1pwZGJ2SVRJU3hwcUoxRFNCR2QyWGJxL21WQlcwSExpSk11eUd3UU4z?=
 =?utf-8?B?RlhveXpBSGo5K3VSazJ5dHZUUDhUa3RsZkhmNEsyNTB4bzROa2lEUFl5S3lw?=
 =?utf-8?B?ekYwRXgzbUs0Nk9sVTlWbjljVmptazJjSzh3MW5qWFhUZ0IyemlwdlR6RnQr?=
 =?utf-8?B?cjgvSVhnMmpmWUliZDhpQjRSTy9nbSsxRUdlU2dwNXp2a3BHUmYvLzFUL2dN?=
 =?utf-8?B?alJEY2NhUXF1NnN1WTRsYzFQeVNsRGVXMnNBY1FlREJjWEJ1MFpnamNBY2NR?=
 =?utf-8?B?OVBLNmhjUE81Qll4WkZsU1lsUXMxK0FIK3oweGFodjBBTnpXYUlESWtlcTBH?=
 =?utf-8?B?TERURW9ONUtFQjYvR3dxSHdRcXdJcE1JeU9mOHd5d3hsTFYyU1VYZVpWdEZs?=
 =?utf-8?B?SWRVMHZoYTM1RGpRMW9rSGg3QkRRcmVlZjRsWmRabzZZVjE1R3k1OUx3TFBV?=
 =?utf-8?B?bzNoTnlTVFpOOW9rREZjSFVYVlMzQTlXRWh2aFJJcWRBcU5uclNEL3prL0NP?=
 =?utf-8?B?WTBmOHg0akdxQnljMUNoVWNDbUVyc3lTdmNhNWFITVA0ZElOWHZkZTUyK2wz?=
 =?utf-8?B?N0M2TDJjaGRjb1ovRmUrcFdRaEoyaW40ZnRUalEwN1lRRW5QdFpwTkdzOFhM?=
 =?utf-8?B?ZXRiKy9JMnVVMkt1RGYwSGlZbUM4amN3NWtId29HbGo4b1JkaUlkVkV6VWYr?=
 =?utf-8?B?UDRuOXZjNTVBZzQrejZpS2ZyNjlOSU9TdjgxT3FQWWwzeDdqUlMvZHl5WEhr?=
 =?utf-8?B?eFc4TGNTdWYwbVpVd0tSRWkrL1ZESmk0MGw4aW02Z1A1eWlnUEpQRUloVVlH?=
 =?utf-8?B?ME1oY0RHdVcxSUxSVTdNVUtIMEE3bGpFdVEvZlFtSHJaOWpZUkZ3bGlZT2wx?=
 =?utf-8?B?TDdYL3RTV0Myb3QzcVVlR1UrZUJYWlFGdjA2SW1xYS82ZTJ1WEJ1SjVGbzBP?=
 =?utf-8?B?cmVFV1RzUG9uUDhhRnRPYldtQUdTc1dkdTZFMUNPN29OQmpKY0Yzdkk0REZu?=
 =?utf-8?Q?P2TNTNulOZoWsdtjlvKxMbUfcbhhDv7F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4847.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OS9PT1ZOM0hTQnRlOU94TVVmMmhrYm5iajI1ejBTZ09yM0lUeEI4Q0h0V1dK?=
 =?utf-8?B?TDRBUzFCWWVzR0V6dXZqZ09uREFPdUg1dGwyOFBFNDRSeTJNSElJQ3l6eDlu?=
 =?utf-8?B?NjRUeHhUNlY3aEFvT1c0RmpjWTZJcnZuaXdhaDVLUDF0dm5UMU9hQVRoMHhJ?=
 =?utf-8?B?ZkR5K3VlWlZnSTNBNFFlQ3I1NW1GKzlaUUFCT0IrcFYzOUw4ZzVJU1FHaFlu?=
 =?utf-8?B?K1J2eE1GUS8ydHVrZ1Fmc1hOQVlQajcyRVArWjdWVDFQOVR5TitvMm1TeUxJ?=
 =?utf-8?B?Uno3ejQ0OEJzTkc2NG1KY1Zqb0k1WnU2OHVOUDk2M3JlVGJ5aVIwejZPMFBS?=
 =?utf-8?B?ZHhKK09INGpWT255N2ZBNGFUcG1ZREllL1dVdld5VDNXRm1wNm5sSDk1dlZv?=
 =?utf-8?B?VVlkZ1BMRkhhbDVwdHQ4REZDNDJSUmNBZ0N2UGhUS1gvTEVjVkxIanFlUm5N?=
 =?utf-8?B?TDlQd1M5UWgrb3RqQms4T1JNSGZqUmFWdGRKSWxTa1lULzdwL0kwREk0clYw?=
 =?utf-8?B?bjI2MFNIQmc0TkNia2FPOXRjbkYwNCt3K0hIS05CVXlJakIwMmFDNTJXc2Fq?=
 =?utf-8?B?TlU0MUFlZTNqOW1HSStteUhUN0ZURXFqSGMzNTZyaEpDZ3RlKzAzZGkxdnJm?=
 =?utf-8?B?K3E4RjhadEh2Y3EvTk9lcmZPNWFNekcxWkViSEk2OENTUVkycEtQQmZJb2kx?=
 =?utf-8?B?aXNSVXpMdXNidnpsdi9hRzdmLzRJNHVWTG5BQmV2c05neVkyc01ZaCtITW5H?=
 =?utf-8?B?Rk1QM0ozbnRTTHlBblprLzNyT3ZZdHlBK0dFcS83bGk5NUpvaGRCUkxVQkM3?=
 =?utf-8?B?MHlqYitLSU1sVW4yWGsxRDlJSXpFOW9qbnVURkVsY3MxMkFPYkUzQzZuWkRC?=
 =?utf-8?B?TWhYUjZRRlVGS0N5aXRQVFlhanQxWVBhU1oxY2dMSjdjVEx6VzlsbTlKNU5B?=
 =?utf-8?B?ZElRajIxcitLRlRRUDFkcGp2Syt6TUNNMkRkVkJUY3NFZlVDTXIwK1JTUEhG?=
 =?utf-8?B?OXZuN1RwdTdOdmFHWXU1ampwdzNrc2VoTEtkREZ1L2ZMRlgxbG44aC84NDVD?=
 =?utf-8?B?ZE1DM1laS1pTcmdDM002YTVVa0U5aFVjV2NGZmNXdGdJc2Y1czRxZ2FjYVl6?=
 =?utf-8?B?VGJtTWlXck9Rb3drWkxGUUVFaC9ZOUlDa1c2dlRwQ2ROTHVPenkwdWxSbUVz?=
 =?utf-8?B?Q2IvdnRuSU5kbFlvaTJjVDlnTUpHc2NWeWtGSEYrcXNUV0pPcTFwdHZ0d1E0?=
 =?utf-8?B?Q2lrRjE4ZFRvS3hlK0k0Y2p0VzR3U1FUVWxwcHkxMXE4YnZ4M3h2L2hXbmRx?=
 =?utf-8?B?bk9oM0JPRm5jSWNJSHhzNUx1OFljdCtDR2tMdHRpMEpmQ2E0THA2b0R0TTRI?=
 =?utf-8?B?YnAwV09WZnF5bzdiaTF6Qittck4zbzlmTVVmT1l6RURLazJua1FsU0srZ294?=
 =?utf-8?B?NEZXNGk1SkdURUNzK1FOV3RoRHZBOHN2UXd3VlJNTVlaRmlRNHJXWWVZSjFX?=
 =?utf-8?B?S3FrdVBnb21STjBLL2dRc3RjQ3RvNnIzMlRvcHpMSmc1Qkw3eTR1Z0Q3RDdr?=
 =?utf-8?B?cmNHQzF4VWV1UGlORDJKZ0dibUp2WE01RE5nbDh2Z25qeFRFTksvVW1ENU5X?=
 =?utf-8?B?RmMxenBPWjJ3UHN6UlY3SDh2aWhhdW1IM2FGYkNReUJUYUVBYS8rNy91OG1J?=
 =?utf-8?B?c01BSHpac21IbkN3ZEVRdzF2TmlpYnA4SzI4NWtXbmZveGdvb2lyazVmVlpU?=
 =?utf-8?B?b29xYnkzekE1K3pDSW9tdGdkK2lPNUQxbjBhWVJPTDJyd3JlWklUNWZPT1FM?=
 =?utf-8?B?ckk0Zk1Xb0Urd2NlQTlNQW41Yk9ycFlXSmoreTJMYXJnMk1hRVlmdUxXZ3Ri?=
 =?utf-8?B?eXVMbkJSQ0k5TjR2elFEK3g3YjZNcW8yQ0oxdGlVZU0rb2FRVGk2anpUREVO?=
 =?utf-8?B?UGxmcTFtb3pYWHFMdzlHSk9YeWlhK0pBRE5mdnhIdm5Ld2VES0NOazNuOVpE?=
 =?utf-8?B?UDVMMGpRcy9DTTBQYldwRWlYQ1lUanB1Zk5WWnE2UnZqTkhXaUI0VHFoSGZj?=
 =?utf-8?B?dG5MRzE2YjZJUEhiK3hpQ1IyMmU0QmpiazBZUllhdHlpcVZtQVBEVHVEWVBC?=
 =?utf-8?B?WHFHYkxoSXM4S0QrYWtoR3AySzNNOHpnTVVWNzJscmRvcERvOFYzMDZoSkhY?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZhCdIHKM5blWWR/iOn8PReZ2KcrduB8bWoheLXkif3I1Eq8mIuLZDXjt1wHCa0rxCoJTg5zOY38o1dD/wkFy5k3I4XsDaJumgE9dn0F8xEUOXmaij6k1k6uPagNGdxHl5HKAQvNc1QZydSVan0I7hldeM8x5/jSPd7Ffmqjftu8abpO4+6icKYYE6/ndyOdunPx7vuJgB6GDZspw+o3dj0W7KgPeSuGAf0ZY7VDu2HNuiS5QWRcdVWBQx5iSaT+UaLAqscpOqCUvt6ubtQ87La94SwAvhs3F6GIeBDJiMATAemGup6TlDg1dmftoWafauMiUKjlbQWAck0uDx+qFal4qyOnQk3yaKs7WedGbRvJDoZzxM3a35Rw2V6qjqv4MKoKqH3noVF8BklrzaS97m1Zt0eVrSQP4ZIvps0hHX6tRIpSaQsdncZYN8FAP/0retqDejilD/DHh9wrhmC3L79FrHSd90SdX9J6BuAjB5XssdK5IqoQXVFTaG7T8XqQl4WGiPBMaMsN/CdZ//6MIS+E2HKckByYSfI6c7ZGHsjcjmL0tBeOuLjFOox1qEGc86/7JrHUG4EXLrevoDfebshkqiDGHooERN2T8lEkXVBg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a689f9-3eae-4277-6de8-08de3d77f71b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4847.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 14:24:19.1295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbo/Cop06x9JyK0wb9t6mpqnJZTOso8XPtl2hClt0DiSX53I2h3ewGe6jC4cELxEZBX2OkGsaWwGBw7j/MrWusL6vlDEww38GKaCLr8rOUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4959
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-17_01,2025-12-16_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512170112
X-Proofpoint-GUID: vFHNGkzNuUGsnxW2Vrq4zjdzTqvOdS-c
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE3MDExMiBTYWx0ZWRfX9mNK6wabncPl
 nZ2eLMD039LO69WlmI8tbm7w2K2rtXslXFGZmPPGd0qUy1ivUbsVRLSuGYQSMHlIihPLwICu8bq
 +tQAnBH3mUoQLutrndkkhEbM9kQ2ySLYJ3jCC7n6TxvDQWWLtIOPWcL8Ex8eKhuua5uQKQDky8C
 39LbTTxApDuXqKngERS8plUch02R6Vmzezs95U2hlk7EV9qYIkvJu3jHLVlVl4drVee985zWM5j
 EcWp/gaTyrjBaU/XkSNYDX1+HZosd4YfYaS5YgDsA0d15B1NfyMO7Zs8A5OLU0Vm5i1CYUzjr2i
 fI+E+oxFZ+2S6G+ZpRclOE4Eg1zU9jFOoc3DL79JOzOqhOsGilEE4DzUVaZSJXlWtQLX5HsYkWy
 eb7t3aqBlBsTB4/MfQKVRLoWaOgWDs5tf1kyNOuCxJRISxoL4sk=
X-Authority-Analysis: v=2.4 cv=GbUaXAXL c=1 sm=1 tr=0 ts=6942bd17 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=dSKWXZCsGpzTyduC:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=L_Lz2tcOO-TRAkzKAYYA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12109
X-Proofpoint-ORIG-GUID: vFHNGkzNuUGsnxW2Vrq4zjdzTqvOdS-c

Hi Christoph,

On 12/17/25 4:53 AM, Christoph Hellwig wrote:
> On Wed, Dec 17, 2025 at 01:32:30AM -0800, Christoph Hellwig wrote:
>> Hi all,
>>
>> the merge of this branch causes NFS lookup operation to shoot up a lot
>> for me.  And with merge I mean merge - both parent of the merge on their
>> own are fine.
>>
>> With the script below that simulates running python scripts with lots
>> of imports that was created to benchmark delegation performance, the
>> number of lookups in the measurement period shoots up from 4 to about
>> 410000, which is a bit suboptimal.  I have no idea how this could
>> happen, but it must be related to some sort of pathname lookup changes
>> I guess.  Other operations looks roughly the same.
> 
> To further pin this down, I rebased the patches from the NFS pull request
> on top of the baseline (d358e5254674b70f34c847715ca509e46eb81e6f) and
> bisected that.  This ends up in:

Thanks for reporting this, and for the reproducer script. I'll dig into this
today and try to fix what I broke!

Anna

> 
> NFS: Shortcut lookup revalidations if we have a directory delegation
> 


