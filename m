Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2100870B3F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 05:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjEVD4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 23:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjEVD4b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 23:56:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873D6CA;
        Sun, 21 May 2023 20:56:30 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M0tulm002364;
        Mon, 22 May 2023 03:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=99mgxVw32OQKefupnHs9pHaboh7o+miDf3DucLWaBP4=;
 b=vjpGY2XPFmt/SzX+8h4+A34zLc8ji8mHGFaLW8CpzM5BU8d3P2MZ4vdMRsAc9IfH4DIk
 wI4YX1JmFTobbLk9zpBHxjg3xmnDBeK6PKv75fmn1J7S4jnxzqpVMeKwTraaUUlgrYVS
 a+Rs3xzxTuWDPyIUNiEybsshrpno9xNvJ4TXMsGPNfMddhtqiRc2SIKSeicEIDQe1c17
 k1OdyEXE2nmL4rPyx/2yN7CglfLC2vqTmdjl0WEJHMM0kG08uR7LEsJqotDoYcM8loJD
 vR0+bgkzJN4A45kKSdMYwYuVY4bi/UnbrX8JY4DTw1LRWeriegX+OBSkHEyWZjmU9lnU OQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bhse6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 03:56:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34M3ZuGG028512;
        Mon, 22 May 2023 03:56:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2p5nux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 03:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krq721RV08Nij0CoRjG3WXKHFjgylQxmL1UZwhTic10Rn+Gt98dyT+w5mua6m6JQ0zg/P1rm6u7wnudRerG7Mql69f8bQdheMNQc98B4OhsFl0vzY4Ag5/BMcEWwlV/l+UTa4IDUSJM5o67tIerOccXjDAZVMIyILMFkXFPcjNx4XiFdpJtiwyFd/j7rFq1WMxcrMcGlHvEizH1L4Pw5OEoLw1PkEXE+ZEtUCvMpHLOa87lYw+aVj7ZaUk/7ESALIDDEBKon35NcvrkwHeQCYnei5J7Obb+Z6cWwDh+paIoYfDXcBf4qXSfEZlMGKLVfY0lliwf3l+fNAh5Hzq2SPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99mgxVw32OQKefupnHs9pHaboh7o+miDf3DucLWaBP4=;
 b=BNronUupmBP4z7cUXqQxbzIPzaD4G25Pc7IrJEzmvPR2gnLb9B/VD2w5+OxLEepczo2pdAQh+TWMXQSO4ZEarNAjyneD11H39rF5FmCUfUWLE820IB9QC5vK4j1Jv9NI20EUclkdh19TD4A1ORQ5Lrbs5UIQo20ZeqZ+yPKf6HgYLBuA4MpBw8ekxrYpKyFVQ6XozgTRk0gy3ccC1PwLnFFCkW5cO1fxKxoQSSaMQMbD5ry3Jb025RMHxApvMlDrEf0djr/e3m98qG4H+g7fDHQUsfZj3YsGGv8A7B+GtX6YLOFsL6X67/5mn4cZBLvzWBZHa1I3EwWHkab4zTI7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99mgxVw32OQKefupnHs9pHaboh7o+miDf3DucLWaBP4=;
 b=dMKrD2SEQcS2kV1jklCLo6AJlkvnmrFIHyVGUbjfnQ8tCuT9LNEbnaySODI4VUFl7oFGx/+puNMab5DZXITHcE6tCAhQPNeIa5R8fujXEXpbFOsXeg0+YlXbJwe62XU3d4cNnnKUQUxosDSJWnkmypSM2QSiCTCItFUmxU1EOrM=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 03:56:17 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 03:56:17 +0000
Message-ID: <2eed123d-66fb-44a6-ba1a-c365b8bbd0be@oracle.com>
Date:   Sun, 21 May 2023 20:56:13 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
From:   dai.ngo@oracle.com
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
 <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
 <546eb88d-85dc-1cd5-9a3f-b11f3eb144ea@oracle.com>
In-Reply-To: <546eb88d-85dc-1cd5-9a3f-b11f3eb144ea@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:5:335::18) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|SJ0PR10MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c874d8b-8ef1-46ca-868d-08db5a787ee0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U6qFd0bLS5qVArlkPXgF9gSkQhRFcuxko20CEvMeWuoGXiP5T5Q0m1RFLVZtrVtX0MkkBRyj4w8Aj6sDJQ4cw9owrOjmT07+od9e5z/UrcuwUNPP+qQcNYqaEauhAPaDGqbK6bZZdpCZVEg8i41xpfVStJznGGus0Uf0LfhfJ/0saNpMxvn1BhjzB71NfNpGfK7YsLPR3zJvv+wmLJ//ITFN1EFEzrvspam6t1OLLPmBw6faG5rqh+taPveTXUjz5PDe5zD3m0fZKXnPdejLHH7DAm3pe5mcYH0zEl+IwWI60MzztrFo2KwGkC5GXtz6lYT9/S87fI9RGrb6Rhug5SrNtHhQ2zYpVo5PfEpbtmwFjMX2L95q8h1JRcD2D9lv5kM+5DVabIwIsRrFMlvBTB6LEp855YtEwdzUE5A2owOXkQh+hnXk3R6NhIc9wQ+iI4mzQvbfjTRq2hYgdU/wpIxvHOtr7JWH+jk8PyUta6FcZC3S54KSMuMjg7Dp5Mccg+NxZWFnJNOswfKQMXeOgI2ut8wrwVVkaAUX7/RcOPT+O8XN7cE6oOhzH5hBLOy1aqGq+0Onfr/rQIKcQWI85PdvB5xnKEE/PnCHmytXR4JhgMmpTMumyRPEd2JClw3Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(8676002)(8936002)(5660300002)(83380400001)(186003)(26005)(53546011)(9686003)(6512007)(6506007)(2616005)(31696002)(86362001)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(4326008)(36756003)(478600001)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TE1IKytyZUNwUHRrZGZETm9Vb3Frazhtb1BndWdJc0R2SDdJL0U2QjR0eUhs?=
 =?utf-8?B?ZXdxWTVRN0V2QVhBMVlCME52bnFvSHJvL2NKYW9WVGxacjN1MWZsWFE0U2RT?=
 =?utf-8?B?WmRVemdvMDZJTDZpbHgyQjZxQzNKaCt5VUFpbWtMeWR2Z0hpTFV5NnY0K3ov?=
 =?utf-8?B?TUxuQ2RJSTdwUzFqWUFJaFVoZWFSZDNRUFEyUlRtQkJvczk1SHg2Mi9KNHJB?=
 =?utf-8?B?cm1wNWYyRFZ6R0Y3MUZCaEVFSmxDSC9SMWNiVTFubzhvY3NNa1lwMUN2cVRQ?=
 =?utf-8?B?Vi9VN0l3T2VacTBpUGpiM1ZWRzR6M2tGbnZrS1FCbGJWcXVVNXA0OThtTlh3?=
 =?utf-8?B?ck5XbWZvam9xR0JCOW5BdkIyWnBmWUNWM2Y1bHZZV0oweXVFQkQ1RWN6bXZr?=
 =?utf-8?B?QWFhMDNXMmJQdnJVeDVWQllxbDdDaTBrUXUxSllwd0Z1UjhYV3ZZTzZvbTgz?=
 =?utf-8?B?TkFsNnc5Q3VVRklndkVEcTVoVnhKQkRtaGthYVlKMFpjWjZkN21IWU9XbkVm?=
 =?utf-8?B?SndHSXMxZjdJcENUd3lEZEo5TTVKVTI0T2RzR2dxcmZnWmVGNXVuZ1pNUWtw?=
 =?utf-8?B?eTAzRzBtMCs2RjNWRXRWaVREaUpIdDN3bzlaUFAxUmk1SHh3ZFZzOVhCakhM?=
 =?utf-8?B?eGRtUHJaSTJXeHdjTDRvRXZoTXdLbWdSZkt3WDZVbnFsd3VadCsvQVZZcXB6?=
 =?utf-8?B?anNteFc0NzVHOTVzZURqakJnNGFQdGlGM2tXZG5UTmsyb0VWS25vK3RuNk1W?=
 =?utf-8?B?UDZJMFdNSGFPL21hU1JxdVNacUMyYXkxUTdlMGU2emZEVVRHTURldmNQaktD?=
 =?utf-8?B?M1NvTnBleDBOZHBVZHRvWVRrUkl5cGRpQnc0SkJYbnF5MlIrUmlxa21YWjha?=
 =?utf-8?B?cnN5cFB1SDBSdGlaZW9ieExzQldORWR2dFhwRXZ6RExibnVIdElRN0dDSjl2?=
 =?utf-8?B?cFhGRkRFUm1jbTZlWDZycWw4end6RzB3anVtZnhtdVN4c2VldHdlRjZxRTda?=
 =?utf-8?B?dXFoZlNBd0F1dTJIWEllRjJhdGJ3OCsyN3o4bUtJaU0rTHhnOGpmaG82N0sv?=
 =?utf-8?B?eGlzYkdod21HaFVtdDlvR3FuVUJUb0RKeTJCOTRpSkxaamZuTGt1eC96Vzhz?=
 =?utf-8?B?Ti9RbGhLc3g3aWNaaGFVQklKcTd6ZWsvTkYyUFdjeE9YK2hkSVh2dGRxVDds?=
 =?utf-8?B?K2FYS3F2b2R2YTNQRnh5blVyL1hQbHBHdnVRdEN6dTQ2clZRSTdiUjJNd2ND?=
 =?utf-8?B?blNYbklURUlqWVRWcHdKaEJQdlJtMEh3cG5OaW9NUFJZTnREeDJ3dHZleUZV?=
 =?utf-8?B?M3dmdGIrR1gxeFlVZzVKSUtHWndhWlZIUVJFVlNiTEVwWlFKcnhlNm04YVpK?=
 =?utf-8?B?MDFPSFRaUHVWSGY1SUUxYWFubmJMN25ZaC9TYmdQMHp4QUR1UGhybHhIeHVT?=
 =?utf-8?B?NUlyZTcvM1hPSlJhZnJQbExIbGJPNlpCeThhVlgzYkcvV0E5SU9WV3Zac0pD?=
 =?utf-8?B?emlhYkZ1ejluNXlWU3l4THVzK3ljaXYycFZ6NnJhRXRTNzJyc0JlUGJLeGRW?=
 =?utf-8?B?SzZ2cmg2ZWpMUzdhcHY2K3N4K1NBT3NvaDBZZk1FbHczQUVSR1NicDZXUmVm?=
 =?utf-8?B?VTdBRWFKb1hGRDZLaTlUdGQwSHh5Sk1vVmpDeGZyd0NCUWN0LzFBQnFVK1pQ?=
 =?utf-8?B?ODFMNG1QbVZPUEVQVUdPNGoyVzhpRlo4d1hxZHo0TFFMbDJQUzhmYnlraCtm?=
 =?utf-8?B?aU5kZFJCR0xpOHJWR1N6RWpoVVJPR3FlaHlCR1BvZFc4RkFqY01ISkh4Vlhr?=
 =?utf-8?B?NVRkVzBWQ0UydnprT3p3T1VkTFRzUTVJYUNjZGtmRzlsa1kyY2gzcjJBTmU5?=
 =?utf-8?B?dngvTFlYbzBCRTc0VUJhUER6ZFlYbTF3OEtYZmN1MkRZZGJPQnQ0YU5iT3dM?=
 =?utf-8?B?NEpLYk1CRDhyRTg4K3JRakNyQmM3cGJrZGxob2RkNjZLVWNsOW0xdGs5eFFM?=
 =?utf-8?B?QllvVkJRTmxaM0tDOVhSMmVhdjhUem1IZFRiOGNvUUx1VWdkMW1CRGs0ZGFl?=
 =?utf-8?B?QXVVaGc0YnZ1YUJXQkQrbm1rbmtSQWxrZnRuN01aVVZUeE1vemp5TGVFQjQ0?=
 =?utf-8?Q?abAt9mFT1O/Qw7kdKh5olQOPr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: peoHFblBheVUoD5NhIhaQkWdydczQvjAcBphAS3LFqZ5nxpXx7dzWt+EOT5cgKMOUfdxZGI+vzvVF6tru6ZESMRsVX3LJcsH6d3fQvv9w0IGz88QnST6Du1dmmMuUw7KdILg7GfVPS0ET8efAwve4ljD4AtSnIk6JezhDgxv1yarOA6YBL3VT3oN6LTYEPf3qBBBLD6rWfa7qrgFcQkw1IBHMvQzf3gH5X7YKnDBf+pJWoZjdwR2z0mB3HZisLjLlFudFTiv9PE3V8AZgaGRfHP5oCOd5vGDp3SuRW0OxlnsTZINAEohBCUOFIltb2+ByJ1VAlRtNCr4JH7m3v6YMt8MubNFrJCM5cIlHCn3tb9xbVtcG2x0eS6lde/0XwznqUqD+Xk18/Ot8EKgDf8ncDMyLOk6I25uBDgfkL7Bhms4JC495y4xdTEDbkMoIDBj6L6aPXAHpzhGNlDOXhHle7Yc17Pixy+4KxtFWGbm+yXn7uRGGc6Bc4xgeDvZxxzKkZSd4L1D6sIfBnUaSXOTjnzG/owigVu6UVrfWM9b6Bsu3XjEDl/7kNhHmMvb2pzoWqMAMo2c6vNtII1Fs3V0GyTy3S3KSADIZje6qVT1aHLlME89uYns5Ter+DrYXUD4GcIevGCf2nLtBAk+d2kUFg9d8J+DAH6YZcnsIWlWc0vRYgIhhDlX1iS8K76Wq5b+4NF2R7HWHAhY3ZQ0xmQO8QnzDOIpxLWEHdr2RzgVwDAjS8/JHS5qwXiHBeYiOYuuBSftW1FwUhVCW4XFTvCwTZDTXJWMkG1z2zhNhZs8HMY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c874d8b-8ef1-46ca-868d-08db5a787ee0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 03:56:17.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8q+yHoRMhRtiJndSauWghKNeQ/b28vk+lNVc0hjvcJczJSUHfPdFrOKjuwuoJtTPLiBCMTLYDozCS/9aei+OgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_01,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220031
X-Proofpoint-GUID: qlvX2tZnLIjrnWGQmG0KgpU1rC6YKr2h
X-Proofpoint-ORIG-GUID: qlvX2tZnLIjrnWGQmG0KgpU1rC6YKr2h
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/21/23 7:56 PM, dai.ngo@oracle.com wrote:
>
> On 5/21/23 4:08 PM, Jeff Layton wrote:
>> On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
>>> If the GETATTR request on a file that has write delegation in effect
>>> and the request attributes include the change info and size attribute
>>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>>> for the GETATTR.
>>>
>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>> ---
>>>   fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 45 insertions(+)
>>>
>>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>>> index 76db2fe29624..e069b970f136 100644
>>> --- a/fs/nfsd/nfs4xdr.c
>>> +++ b/fs/nfsd/nfs4xdr.c
>>> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, 
>>> u32 bmval0, u32 bmval1, u32 bmval2)
>>>       return nfserr_resource;
>>>   }
>>>   +static struct file_lock *
>>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>>> +{
>>> +    struct file_lock_context *ctx;
>>> +    struct file_lock *fl;
>>> +
>>> +    ctx = locks_inode_context(inode);
>>> +    if (!ctx)
>>> +        return NULL;
>>> +    spin_lock(&ctx->flc_lock);
>>> +    if (!list_empty(&ctx->flc_lease)) {
>>> +        fl = list_first_entry(&ctx->flc_lease,
>>> +                    struct file_lock, fl_list);
>>> +        if (fl->fl_type == F_WRLCK) {
>>> +            spin_unlock(&ctx->flc_lock);
>>> +            return fl;
>>> +        }
>>> +    }
>>> +    spin_unlock(&ctx->flc_lock);
>>> +    return NULL;
>>> +}
>>> +
>>> +static __be32
>>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode 
>>> *inode)
>>> +{
>>> +    __be32 status;
>>> +    struct file_lock *fl;
>>> +    struct nfs4_delegation *dp;
>>> +
>>> +    fl = nfs4_wrdeleg_filelock(rqstp, inode);
>>> +    if (!fl)
>>> +        return 0;
>>> +    dp = fl->fl_owner;
>>> +    if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>>> +        return 0;
>>> +    refcount_inc(&dp->dl_stid.sc_count);
>> Another question: Why are you taking a reference here at all?
>
> This is same as in nfsd_break_one_deleg and revoke_delegation.
> I think it is to prevent the delegation to be freed while delegation
> is being recalled.
>
>>   AFAICT,
>> you don't even look at the delegation again after that point, so it's
>> not clear to me who's responsible for putting that reference.
>
> In v2, the sc_count is decrement by nfs4_put_stid. I forgot to do that
> in V4. I'll add it back in v5.

Actually the refcount is decremented after the CB_RECALL is done
by nfs4_put_stid in nfsd4_cb_recall_release. So we don't have to
decrement it here. This is to prevent the delegation to be free
while the recall is being sent.

-Dai

>
> Thanks,
> -Dai
>
>>
>>> +    status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>>> +    return status;
>>> +}
>>> +
>>>   /*
>>>    * Note: @fhp can be NULL; in this case, we might have to compose 
>>> the filehandle
>>>    * ourselves.
>>> @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, 
>>> struct svc_fh *fhp,
>>>           if (status)
>>>               goto out;
>>>       }
>>> +    if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>>> +        status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
>>> +        if (status)
>>> +            goto out;
>>> +    }
>>>         err = vfs_getattr(&path, &stat,
>>>                 STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
