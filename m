Return-Path: <linux-fsdevel+bounces-11329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14BD4852B5D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7481C22474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 08:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0A1B273;
	Tue, 13 Feb 2024 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MHewuE4Y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ih76zbRR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F84182A1;
	Tue, 13 Feb 2024 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813692; cv=fail; b=d1W4h5/u/60MoUpH0jrXj/2/vFev0hRqS5DTQBv1ZwU9eiA7BLXb3AAR35nQnrliBE4e+n61wDnMjfXmArxIO+Mo8PPQn/E9WCcaH44ndn8e5ifj8DJgoynE+fFKpeUZ8W2StvB8qV0HIith51lfX+NsQjtrlhF2keu475UsovA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813692; c=relaxed/simple;
	bh=BWujETQ8ld5m+xSKJJtpY3eroDNCu5kNcMv0cD/at0I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a0pyIoODdPUaGRYdrNr1QvayfqiDb2AJ/YsYCrvVdkHQr6w/BLhy+irvYtpEhyu/xA3R2LRvtXohB/A5zSiXWwUlCLWD8F370YIvh23KFE7WzBXmc4KQScNgpMlyX2/zXgrDDe0zmufQVi/K3RxgbuVKrwCZZ4yI+lGzxfWOOpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MHewuE4Y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ih76zbRR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D7xMnM006255;
	Tue, 13 Feb 2024 08:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ae/E7RZp2xYEPFoOcgMz3zXV7qZeyoULMD5X9PgxkgE=;
 b=MHewuE4Y8OKEU4zpgwHieFfONfZ4RaiUgxWgDwmr6MHOdsrm9sGIStf1Be0WZENUr2aU
 uerQUAc+cy17Y4GN8+GkM/04BBC54VRuFutF7MW3odEwdEPd0tCBkiVONuuGBW8Hr44F
 WUHlxZ+cYyDn2oFqjVFVe2cgpeyM99UDwXa1IjPT3QjB72qe2YdQ7dBE3vgYJPK66COk
 nGyuBfFYKIpfc6N8y8aT+MOXHkqbGgDnUEdOsRphcCsxggO6bxNJpU7jzct8zKYCQeSn
 zhgKRZjrxB+5AgovN4akFb8PC+Z9ny23jty88/eTKcBE9A3FHHhrSv6LOXk+kQEahfeO 8w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w84gx82b2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:41:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41D8b5I3024567;
	Tue, 13 Feb 2024 08:41:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w5ykd97cy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 08:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZE8YB7S1b86mCqLE8EHYepo7wugWZh4TWxWMKMoUfspFwmDZu0JxSM/WrODDb6FpoigdOY23JRjqxCYGwaCJBUcL3cy/cbDA20gBCidA1fkkFp8dOr2jrmYpr7evOaGijEs86LJ5U/CiboWrQs15LtBOxzuEVph9NB/nvNLxwTu9N9p9m/I8dOM3nlKakNt0u4MI2tCuUx6XG2OfMw8fJ8fC4vNON43CiSWVzrBCDb7bu7uQHChP3cLwuDMWR4bIplyt/jDxshvOmkaRBFEa+bMcdJPdmn9g+/RAZ/LJMv7HZ8xNDI8B3Z7gSgG51k37cXxRX9qhebazdVtI56B0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ae/E7RZp2xYEPFoOcgMz3zXV7qZeyoULMD5X9PgxkgE=;
 b=X6j8bBuAGu6BJbsQaaljeoJh3IgAukYH6KgRLrQJmwPlTQbDnxhqiNgXxbkL2lzHt3cwB9SpET+pNryolSY5N1iDkRLOPyjCtPtmHlE75iyy/ZOPVxQCues5LZ+cgNHnPx0nLWQZF6NJFSnDJz22WCaB6qaYvmXlk3493YHU4RQba+pqC+3GMUBV8qt8zcJLv2wOZs2mvoLPlGcQXrM94w1jptfvPZ9dJ3s8ZKTpiPLVFKEVfHFcsWUGl8GF9l2kTGUFCeK5MBiHjxArjWT5MgHtWqi5JwjIxFye32No4PArGrtc/T5vLYaqPsh/8Ho/QfMVrp6QcV4/M6zbBJKD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ae/E7RZp2xYEPFoOcgMz3zXV7qZeyoULMD5X9PgxkgE=;
 b=ih76zbRRretUQAgN9ZuYQo9XGKmpIc/KhmkTbpyE+d6/yV3XltStZqhAV1r1WGCx4TEMr5cigyQS6ybcDrPqUsCLReB3BNZRkz8Osavk58f/6J/WX+dSMbtWOuGR7KbxrK+VmZYxzGnZ3VT3DQ4GH+A4HAHbmJeFLsCPSCqsT/8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM3PR10MB7926.namprd10.prod.outlook.com (2603:10b6:0:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.35; Tue, 13 Feb
 2024 08:41:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7270.033; Tue, 13 Feb 2024
 08:41:14 +0000
Message-ID: <875feb7e-7e2e-4f91-9b9b-ce4f74854648@oracle.com>
Date: Tue, 13 Feb 2024 08:41:10 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] block atomic writes for XFS
Content-Language: en-US
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, hch@lst.de,
        djwong@kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        dchinner@redhat.com, jack@suse.cz, chandan.babu@oracle.com
Cc: martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com
References: <87cyt0vmcm.fsf@doe.com>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <87cyt0vmcm.fsf@doe.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM3PR10MB7926:EE_
X-MS-Office365-Filtering-Correlation-Id: a862ee4b-a3d8-4c41-8837-08dc2c6f897a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DwQMZFO76GPARkca/+O0b31h/evZvJ6MXCRAxOXuxokKOUA85AhawJbjZuUWF7ScoI07a9dTcjYOf7F2BJ8ZTmfDVRVwShvJzprDnudOHLcUDhFsKZHDkd/VJCg19PtUaMxkSe4vTfaqgmWhS1IiWaf5oS+WzaEvv+sHyW7aRG4ZQIVPTpICqKfhlQEVapBVzTtL5OuUHkGGyS9IUruQIaijP5fuQf+DfhG4vOYoudQBuLca0v60w9fLLtLwGPXcogpYjG89Ht2bxFm0iM5Yb9ZR1IhtPIczH1Cq2D6DKZPuLyghtgjrM0MjKmaQxIaVmSk2c2hnlgfZrCwBShClZGEalN/q2yLRYu249ElgkzlGEY+0wa7CIa1HAYI1Ejrb6OdtrZS5fTddgWVD94jq3uAkCNFpGLio1n7j1mQu2MiR5fHiFDdVuv5RsFvQjHPWFYDyWLqAEVijBBUui1Xb/nFlR1EAG08WSKbaSfmViZTPb+Pre2kNNhDbHSKuRvOBTS1PLkBxWNuET4WHw8OklrVliuIjwKWItPRQfhLcfVDaouvnILWQApWdzNcBFPwwVGZ5zEWH41iCOs4dijBWFg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(36756003)(6486002)(966005)(6506007)(6512007)(6636002)(53546011)(6666004)(478600001)(36916002)(2616005)(41300700001)(83380400001)(4326008)(66476007)(5660300002)(8936002)(8676002)(26005)(316002)(31696002)(66946007)(86362001)(7416002)(38100700002)(66556008)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U2JoNlNXVjkzRE53UmRJaTYyR2d6S2d6bWpNcEFvZUsvS0VlVFI3bkdNa200?=
 =?utf-8?B?R2RkQlljdlJFK0R2UTdnZkVQbVlWdU9ISEY4ckYrbzNPMjIyVWVMOVoxK3p0?=
 =?utf-8?B?NkR4Y0JXQVg4ckNNaFFEcENkQm9SeTlMQmtaYlI5eWZJMUVzTHcxVEx4Qkkw?=
 =?utf-8?B?TFh1ZytoanJZVTZENzd3UnFpQktYcGR1anVWQlA2UkNybDc1cVBVSGt4WUdn?=
 =?utf-8?B?ZXRzUmRtZWZ0b2ViY0FzUWVIVk1ybjBSU3Fkc2VjU3FtRlMycTl6RHQrdE5D?=
 =?utf-8?B?ZFNTRDJCdTBxUUZaV2ZFekFsU3ZlSDNseHgxRmVaTTU5SENUNktXT25BMXpG?=
 =?utf-8?B?aXlJenVHb1dSU2VUWW5pZS9SaDNjVTlZaGZJaHRGWitQaWJKWGoxQzMzRi94?=
 =?utf-8?B?VjdtSUozSVBKaEJ0aGhZU2VhdStpTFJFb1lDSkpKZkpheEc3Rk1tQTdlRzhP?=
 =?utf-8?B?cWNHMSs2QklUQmNFdi9HVWxLNmhSeU1vTEE5YVVNcHRFakZlSGhzOU1EU1JL?=
 =?utf-8?B?Z3ZSU1lyNUdCUjJWV0JlalJaOHEyRnNuSEtTQkJwMS9HMTJXeWV1MitickFk?=
 =?utf-8?B?bUxaQnlaRWl5ZG42UzZDTEprUmVVcDRGeGtBa3RJL2tVd0xmYVdrY1AxMk92?=
 =?utf-8?B?ZEszNmhLejU2aWpETW5BaXVodUxFOHMyNjhPOWR6cGJNQWpQYndNaVRoYy9j?=
 =?utf-8?B?SldVd3VLQUswTXU1Vm5IZkZqZWljR1dyeS9JMFRmdGFhaUF1d3JtUEwzdjV4?=
 =?utf-8?B?WGdvbkNEbnc4MEFmQnNnZmN6bUNVUTVoY2hDU2JFSE1tWVdJTkVYNFBsZVJ5?=
 =?utf-8?B?VC9xYUhVMVpMNVpaSTRNRnR4SGVPM3pNcTd0aGl0TzUwM2U1TmU2cktMSVU4?=
 =?utf-8?B?VU1SeThGTTcxcngxOGY0S21XTFpNRkR5WnRQeXY2QUVPSzJwOEc5ZC8vbTdY?=
 =?utf-8?B?K2lkVWxVZ1pqSWhDUWtKdUFWL2lLTkJmU0hERDZuMVNTZUJEaTlHK3pORFE3?=
 =?utf-8?B?QW9ZeUlqRGV3QlMrN0JxSmFiUkErN0xuNmppRTRkSUsyaU5acjBWZE1Jc0lp?=
 =?utf-8?B?SWJuSkpDUGVOOFVsaVYrSWJHVFgxSmd2cHVqMitESFptd3grR3hJR0lML0pG?=
 =?utf-8?B?MmY1QW50KzM2RTRoOHRzTWpmcGRJZWg2TzBsandIS3pRZHBNNjNERmhEMUt6?=
 =?utf-8?B?M05oNlJobGZyTXV2SStCYm9IY2FwdHJScFhvaUNHaktSTWROR3R1ZndBZzFi?=
 =?utf-8?B?ajBicTF3VEJ0YlRXQ2QxNXc5ZDAzUUYxRCtFU1Y3NS9oeXZSVFRLR1BFVmRs?=
 =?utf-8?B?OUxzWmkwNkhwQzFtSlBoVjRDZTJiY1U2cXVyK2tiVUF3Y2tQVWNDTVcrdzQ4?=
 =?utf-8?B?NVhaaE4yZHNiNzh0VzZuaFhHQkZFZUtLbElmZVY1RXZOYm5QQzZFN3VvUThH?=
 =?utf-8?B?Rk5DYWNRS09MeHgwQk91SjhLQjRuaFV6WDg2MVliclRqeFhiSzlYWHNtbUJB?=
 =?utf-8?B?dnNuUTM3QmVZb1l1VkdWL0dheDVja29IanRvS3cxWnYwRk5sSUdJVkFzb0l0?=
 =?utf-8?B?SWFlVDBjUXpXWFNkbldGeW1Pam85R2tLZTR1R1MwN0Fzb1hvcDRCcndwL0FH?=
 =?utf-8?B?ekt2U0dWejZFdzRoVVBlRHFaY1dNNWkxRHhQeXFEbGNMeHZSYVlacit3K2RE?=
 =?utf-8?B?ZlRCQnd0bVAyazJsWThtWUViTFpFenRPaVB0QVFFd3JxYTJhcXR1TzFRS1g0?=
 =?utf-8?B?eWczNWZ5eG54NWFiUm5rWFBTTEptQUo0ektFRlQxS2ZvaS96RnQ2Tit4blJB?=
 =?utf-8?B?UUtaakN5aEt0M0wrUk1CTDVSeVVONTI5YXl2d2VKRTlyZTgvUUh4RFYvazRO?=
 =?utf-8?B?bEFNSmdtalZ1SGpWdUxDMGFLUCtjWXF6OStuMGlpTmRwTG5FV2VTa1M3Unlo?=
 =?utf-8?B?MkNCb0k1VVE0dGNHOTNoZjdWclFpOWJkd3ZIanFENTJSY0oreW9XeGJHcUJS?=
 =?utf-8?B?OVNyOU4wYmhvWWJKV0w0RTl0c1U5eGxjUHNHWjB5MUc3eUFIdnl2bGFQV1Nu?=
 =?utf-8?B?Y3k2MitZTXE3M0VkcS9IK0wvRDBReDRhUDNNUk1hcVZLTnV3WFZKWjc2UWZQ?=
 =?utf-8?Q?q6JY9vrBbX0N4qEYXU8LcXToc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	mH+A792gvcOS3cEImdulq8pJBdxsjwExCT/38LEBXVh65Sqk08YoRylLpF/sbGo6n7PHPYBHyh7f6l7T6d9nBoDQSiPjA6wwMMpzS9SWbzA4BGuRDAfq2q9ZEMi+WiX+hxKHtFtXfCnOfRY+5Sesz6ojkRDgEKIgIwGiKGGGHoYcrVpFO7NupXZMsFYv/UfQ6YSoIz6ZCA8gcROOvhO5Xevm0Ckshfe1FSieEyAaOGsEVgxyhrx4qEYkONEGbJL9+JAlpfrBq30B4MFEY+/m0curbI+E/PoAYLswgjHJb162M+rClTqnLVix7gcCE+Xphk2U51MOt43O/JEBujpEZg8PIKI12g3bxK8UmtGl5u+PndhFPGd5rCdqxH4FgToV3GrdrR4sY166T++b4kPDpzIdfjYTy1eXm8JoE2Axo3eBY2czobm+lyqwOTV0xTzNMckznIAOn9YNGIj8vO9Ni/OADB2Lf+Zm9YkqrMOk8sdONJwiTkEnyfa7Ia+OKExfHwVzjJ7z7wJCe10XerOu38zRhZUyD+O55itP0xct7X97G22KoLDGjs/sE55LVL8lAcT7LDOzu/Aa1S92atpJVx75nKyjWeI3SbHYXIPrrVQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a862ee4b-a3d8-4c41-8837-08dc2c6f897a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 08:41:14.1106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/3iPOSb+WZCmCMhoNE2voBvu5+qkfu1PEUD951P032/ACHPb9xSC48QHhIZoeDQgBDQD7mBzmoFZmfwbAFs7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7926
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_04,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130067
X-Proofpoint-GUID: fLSAWOLoWkteesGPPlotmtbwMLpYcjRN
X-Proofpoint-ORIG-GUID: fLSAWOLoWkteesGPPlotmtbwMLpYcjRN

On 13/02/2024 07:45, Ritesh Harjani (IBM) wrote:
> John Garry <john.g.garry@oracle.com> writes:
> 
>> This series expands atomic write support to filesystems, specifically
>> XFS. Since XFS rtvol supports extent alignment already, support will
>> initially be added there. When XFS forcealign feature is merged, then we
>> can similarly support atomic writes for a non-rtvol filesystem.
>>
>> Flag FS_XFLAG_ATOMICWRITES is added as an enabling flag for atomic writes.
>>
>> For XFS rtvol, support can be enabled through xfs_io command:
>> $xfs_io -c "chattr +W" filename
>> $xfs_io -c "lsattr -v" filename
>> [realtime, atomic-writes] filename
> 
> Hi John,
> 
> I first took your block atomic write patch series [1] and then applied this
> series on top. I also compiled xfsprogs with chattr atomic write support from [2].
> 
> [1]: https://lore.kernel.org/linux-nvme/20240124113841.31824-1-john.g.garry@oracle.com/T/#m4ad28b480a8e12eb51467e17208d98ca50041ff2
> [2]: https://github.com/johnpgarry/xfsprogs-dev/commits/atomicwrites/
> 
> 
> But while setting +W attr, I see an Invalid argument error. Is there
> anything I need to do first?
> 
> root@ubuntu:~# /root/xt/xfsprogs-dev/io/xfs_io -c "chattr +W" /mnt1/test/f1
> xfs_io: cannot set flags on /mnt1/test/f1: Invalid argument
> 
> root@ubuntu:~# /root/xt/xfsprogs-dev/io/xfs_io -c "lsattr -v" /mnt1/test/f1
> [realtime] /mnt1/test/f1

Can you provide your full steps?

I'm doing something like:

# /mkfs.xfs -r rtdev=/dev/sdb,extsize=16k -d rtinherit=1 /dev/sda
meta-data=/dev/sda               isize=512    agcount=4, agsize=22400 blks
          =                       sectsz=512   attr=2, projid32bit=1
          =                       crc=1        finobt=1, sparse=1, rmapbt=0
          =                       reflink=0    bigtime=1 inobtcount=1 
nrext64=0
data     =                       bsize=4096   blocks=89600, imaxpct=25
          =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =internal log           bsize=4096   blocks=16384, version=2
          =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =/dev/sdb               extsz=16384  blocks=89600, rtextents=22400
# mount /dev/sda mnt -o rtdev=/dev/sdb
[    5.553482] XFS (sda): EXPERIMENTAL atomic writes feature in use. Use 
at your own risk!
[    5.556752] XFS (sda): Mounting V5 Filesystem 
6e0820e6-4d44-4c3e-89f2-21b4d4480f88
[    5.602315] XFS (sda): Ending clean mount
#
# touch mnt/file
# /xfs_io -c "lsattr -v" mnt/file
[realtime] mnt/file
#
#
# /xfs_io -c "chattr +W" mnt/file
# /xfs_io -c "lsattr -v" mnt/file
[realtime, atomic-writes] mnt/file

And then we can check limits:

# /test-statx -a /root/mnt/file
dump_statx results=9fff
   Size: 0               Blocks: 0          IO Block: 16384   regular file
Device: 08:00           Inode: 131         Links: 1
Access: (0644/-rw-r--r--)  Uid:     0   Gid:     0
Access: 2024-02-13 08:31:51.962900974+0000
Modify: 2024-02-13 08:31:51.962900974+0000
Change: 2024-02-13 08:31:51.969900974+0000
  Birth: 2024-02-13 08:31:51.962900974+0000
stx_attributes_mask=0x603070
         STATX_ATTR_WRITE_ATOMIC set
         unit min: 4096
         unit max: 16384
         segments max: 1
Attributes: 0000000000400000 (........ ........ ........ ........ 
........ .?-..... ..--.... .---....)
#
#

Does xfs_io have a statx function? If so, I can add support for atomic 
writes for statx there. In the meantime, that test-statx code is also on 
my branch, and can be run on the block device file (to sanity check that 
the rtvol device supports atomic writes).

Thanks,
John

