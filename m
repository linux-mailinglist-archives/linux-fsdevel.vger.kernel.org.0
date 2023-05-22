Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F339270B36B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 04:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjEVC4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 May 2023 22:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjEVC4W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 May 2023 22:56:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B671A0;
        Sun, 21 May 2023 19:56:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMLni1030167;
        Mon, 22 May 2023 02:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Zi+HQ/+0PffcbSqlW0VHnLMTYCPRpjdLrejuFWMz38M=;
 b=Cr56Kp6/Sn8ckiXJtt6p2Vnb8qqBbSX4v+vpj1gT+9LaGnkuV/eVxiVbZEVpwfkG4GmE
 pQPCDQzmzd3J5j+IPt2Rw/+bD7LKm3cR4jSyyOkBHcAYZU7QeN758a/VsENpT7kjnGa6
 HyKvLLPxcmua69IVJKN1r2sDX1O99x/Rwe/jlK9msgzRwZtyua3BsNOSSstPEzmJY+4z
 gN9NhugYr3ExUEIwIkssFJ1AusUUsJ1aAOy1xx28cZm6RG2Eo4Fy2dQJ3IuOagVu1HpU
 1mjkXStAR2H5ItVRKksTy/0h9gBLvzyZYvfvzFee6ursN5IWffQ22EAg9ZxjND9Q++xV Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44hqba-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:56:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34LMkxB0015820;
        Mon, 22 May 2023 02:56:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk6gckpu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 02:56:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HK2zdWKv0W1Razr/zUt49ZMjQJbnEXdweBBV4hTBiiDZSjHmq2lqL54Ev4WLQyIr7CfKCgdFB4p8cM7qLNLUpzct4X/FLCCghs+9Di/Pa4Sp8DzF1poBSne96BR9dgAMQM+/gu9VfpYwOAB0nAte8yNdW2eF3Q0dEEV3BDNx3xivW0b+R7g+K8wxijxOegE7p+xGk3XJcauohW2wLyQHDW0d4gmoZaAiPdOjjHLG9WnBkNOjZUt/5R9g7P+AJo80aFbHpQnRla5fGYCONBu+PbfCb5IliNT8NYqyFDpuBQQUs4b7rj4hGlvSu6Qz1bRaM+S9UoGVlNm1ZCRUhWEzrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi+HQ/+0PffcbSqlW0VHnLMTYCPRpjdLrejuFWMz38M=;
 b=WM4c65f7uAy8TGglEBqWS8g9z6juOiGIJgHxorBU18OOZ3OnN2gQhX6Kwqk1UZxul6aokloG9IwwOqvoCrZHLfzMySlK/HmA8oc1gQqEtJo/LCiWSZ6gamaBWlNsPnP5cvxZML6j1iH/P730w3nWBh4PlOACdbVRt5FZxeJQRzihlk/iAcxo/UcTb0gqh2l6CJVQa5L94T/MU4dRP4l+rfpl2DGlh9VjZIU7TTjbiJRt6bRD5GK5SJ9oFt0yxIb6OBC5UaI80CPqvK8+KC3MO7qtl6qsnuoGrzovPlH6xV7/yeYqoRS3vn+hCK86FXMR2bLNHDlfZFP2WyUKGx8g2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi+HQ/+0PffcbSqlW0VHnLMTYCPRpjdLrejuFWMz38M=;
 b=VebCAIU/dXFHbOy13tGacYLeDp43xqJOSwQ1+ltgzgctBrT6VLxL897dH5u8vJahu9WHchbLVU+Hj7fbfKGxTXHrK+UB03lonLLO6sKWxJu/v4/TJ1lAbdnkNLxnAwYdjTAC++JeHc5uVlv6ENVRoX8qlAgi1tMv31y043yxnCk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by CO1PR10MB4706.namprd10.prod.outlook.com (2603:10b6:303:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 02:56:12 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 02:56:12 +0000
Message-ID: <546eb88d-85dc-1cd5-9a3f-b11f3eb144ea@oracle.com>
Date:   Sun, 21 May 2023 19:56:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684618595-4178-1-git-send-email-dai.ngo@oracle.com>
 <1684618595-4178-4-git-send-email-dai.ngo@oracle.com>
 <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <d3ae1575dcdc44d1822a5b6a4ffd09b12c600374.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0047.namprd05.prod.outlook.com
 (2603:10b6:5:335::16) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|CO1PR10MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b115b55-5578-4116-8dc0-08db5a7019bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W/CH0XSPblJUlSAXVUGTs0KR6opmur+3D9+JhFzgy1rVDKaEffmi8GQ2lw0c2478l7cjHqo+PLNIm49Q+4fFtpJ4tpnERt7s7Q0lTl2VRxzqM4JSkWQ/iwom3P5WP8KVUfuLhqpYDEFnCg71AyVzJXlUW3aYPr0sw2dLz0A/JOvekA84J9d5ktwHunpcm7wQ5cDxl/7KknuBlcAjTOY42jGUYR18BO4x+xcuoX3V5uHQi32toE7m/15LmN2fKIm2kl8Odfci+HS8btoc+oR0Mvs44EXsp/SEWsyFmReHYtmfNWJZevv8punMUvq8ZkMxwhN4z+8pnpLZYW2omnHNEUTqh4Bdr22ch6UbbOuNI5UXiABJiXQXhmKhKEmbQeB0fc8MdatXDEsbnybuPVrQ/mMT5JVzvhm01AoeG2EdeRPetBHs8degKMxlbyWsALTOB9LPNukqqXVml29E3eRwhiaYbcdRev1kkHkQbqf2wGvhfZxkuq3e0m1zC1oNQbgbYPKluJSMLRi8XrbIE9U8jzuWSfkjE8mlnR246fLsQlg3QhL3BFMZthO3WcT1+DjoJEoW5mILKWvwIhPmxGx3aS2xA2BJoH+dS5FaN9tcw9FrQGBKzKlGsiBwrAtaBVO+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(136003)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(5660300002)(186003)(26005)(53546011)(9686003)(6512007)(6506007)(83380400001)(86362001)(2616005)(31696002)(38100700002)(41300700001)(6666004)(6486002)(66476007)(66556008)(66946007)(316002)(36756003)(4326008)(478600001)(2906002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWJQc1hqZ0dEdkdqNERZS3dhekxST3UzQjZTdjVsc1NPMXBLUUFlUkt5dzhm?=
 =?utf-8?B?WVZQNnhtUWFqU0xSUWpVcTRPUEFUYllLcEYvRHdSZWYrUUxEUGhtTFpSRkJw?=
 =?utf-8?B?WFU5eGg4cWxtNmsyWVFETkcwQUlWZ25USExBUUNRcEg0WTV0UElOd0dMMnoy?=
 =?utf-8?B?VUdzV1RZY2dVanNRV1VvSEJoK2NNSzBuNUpOeDQ0MWQ4TXRadGpyZjlGU2ZE?=
 =?utf-8?B?K3FFVm5MMkFPREdVSU5ieWUwWm9YNWFCcnZ5d2JSVG5kOE83WnhqRGFjbGJD?=
 =?utf-8?B?OEszV1N1OUlKcXNHSGtiRGlVS1g4M1FXaG42R0ZaTGlNTlNUeCtTb3Z0Mzl6?=
 =?utf-8?B?KzArNFlReFAvRXlFVlM0SVBrRVc0blllSjRzUHVjWE1SY0djUzVzMTJDMEtD?=
 =?utf-8?B?V3dBc2JBREMwcWU5b0VBOTBVeFd6TjdseEFrRmdZclpYV2s4bnF2Ni9VYWZF?=
 =?utf-8?B?cW5XRkF2dW5JMS9FVzdGMWFuYlE4QzRyczlNMTRpN0JITzNHVElpbkNZNkFt?=
 =?utf-8?B?aDdiRHpPK1hmQ1RmQy9DOFZFUnIzTk1ZZzEwT3d1NS9aV3RLKzFDeWZnblE3?=
 =?utf-8?B?eFdsN2xWbnVhalFHME5rM0FzYnFRMit2cEt0Nk51cEY3RjVxeUJwclhxTU53?=
 =?utf-8?B?d2srT0JHYkhxbEpSLzZ3ODQ5b3dHTWE1c05jN2w2VlFlQzhTYldwN3p0eTlC?=
 =?utf-8?B?ZCsvZ3VXZUdYamZPTjg3TW1vTVJPV21FTXFEcG8vUFVhSEtqTEVXVWFHQmdL?=
 =?utf-8?B?UGFkZTJnZm5mZEdZSHYrWFJWTW1FYVZmRFVQR0ZqWlJ1ZlllWjlqNElNYlhn?=
 =?utf-8?B?NGhYQXFKS0k3YXh5VkhlSGpDM2h4aHdtSEIxbEk4aDRJZjM3NTRmUnVqTDhK?=
 =?utf-8?B?YmtNNk8xTnZxNUo2NVlBTzhPMjNOY09CWXhibGRsVHhCU2JIWE5HWnVNUDcy?=
 =?utf-8?B?NHdpb3ZzaHRlK2lZaWplUmEzMmpiRGNyR0tsT20xb2o0b1ZzTzR5N1UvZmhY?=
 =?utf-8?B?NDVEVGNuL25pTzZaU1BROVkzN2prMmNRZkQ0c1VORkJBRDl6TnFXajE4SzZU?=
 =?utf-8?B?a3kwT3RqcFl6SmV0OFNoL1NDeGg1TGJLc3NaakI0aURSUTdSWUZPc0ZXWnow?=
 =?utf-8?B?cHMzbjZsVDJOKy9uOFZKNURoL3VENmFKN0hLOERhaGJnaWw3a1F5ejF2OEM2?=
 =?utf-8?B?OEFKSzkxd3YwSHBFWUwwckNtYmJ5YUdvakhPdXUyUnEzcTYwQ3NOcldxMXRt?=
 =?utf-8?B?MWxTWjRCOVUwbnl3WWtoSG4weU5TeFJmRmFGdGxQcUJRNFFxSU5ZTDA5bElX?=
 =?utf-8?B?R05GSG1WUHZ2NFdrQ1UxOGhqRDlJOHJMYitLbFlsN2VveENZRS9jSGJHRmx0?=
 =?utf-8?B?TlpQVmhDbWVtelhiM1JzUlZkb2FkT1lqcnl4NDlsaSsvZm94YW5xeEU2RW8w?=
 =?utf-8?B?cy95Q2lxOWF0QnBlN1dGbUpzdVNMTkV5a2lxNUhCcTUrYTV3Y0MxL2llQUM1?=
 =?utf-8?B?ZWV5MU9CSzlZRDh6NysvM0tTamVKNlNLVGRHTzZwOGcvQ0hYUjlJYWM5NGZJ?=
 =?utf-8?B?VmE4TGRUOGFQWGFrTi80a1ZBOW5ML2JKYW5COG5xZW5ybHlyQWJSOTdvYlh3?=
 =?utf-8?B?MWdacnlzaGVOdW40UUNMR1JpMjZkT3IxVTh5RHhTbktLWVl4VThSbUtOdHQ1?=
 =?utf-8?B?ZDB1RStTWmpvT213cUJrcGpIeUhudXRvZ3lOd3FaaEVYRy9FVmNRM2x0Z3lN?=
 =?utf-8?B?Vy9hbUVMZXN4SlZOb3M4VCtTeUV2ZkFCRzk0UXd4VkEzQXBHNU5POWx0VC9O?=
 =?utf-8?B?Y29CcnAwNGpaSUFOUWtiVW9jZFlOcjBIOXJvWWdzM25WazY4OVRZSlc3QTRN?=
 =?utf-8?B?VVlHUkpobGY2NkF6WXFsZUVtTm90MFo1RzdGeGFzWXBxNlR2eG5rS1hTdzhl?=
 =?utf-8?B?RFlnY3Y3dnFJd1g1T2htcDlEdnovcmN6WEpFdTRjUTFMVmZ3b2NMU3NlSmJL?=
 =?utf-8?B?RkQvYktjZjNQTnd1bThRcHJocC9MY2NTYTdWeDJ0czhxQlptR3NYbTZsU3Vt?=
 =?utf-8?B?K1NibzRxekd5ZTR1SFU4RXFXd281dW0vcGdvWnJvdkN2Wm9QM1BIb2h4UnRi?=
 =?utf-8?Q?h/d7IF8nSv9hkTVdP3kP8yvYy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g+awspKrLS2He8tA+4qB1YmX/A45g6Uocj40htOd/Q8mHfEHxE5Cx/PotCZers43AxlMVgmY80UTAF/KGRmN3lHSD1uNkbpV8dS2nTiqGY56cqugvmbl+xKulIXMlM58mIaNAKmT3j+i6PSvjB4/Em+9B6rwK6bAuhVhU5IkPcY2dtaRVMN7GcqL13KoIDXxsyhRQvt6guhsLSk9djLo2+q0d0WI+mw6dHzW2kvfreg+opShHT181f+Rt94M61Akv+Gk9qN5RU7SgmVo6eGKqmRElFzPn9evO6ogOWauE1474aDG4mf6JGPsRl+/zf69+eXh8rX3I/I/Keu3Rgut2dJ3M74X7nh8KEoJOZpEVA3K0QdFX4DLUevt+g/dAcP3+bIbEAe9gBrGTb8rZ6TScqY/Ek6mUyY1Cy/tyWgEmXAa12CIZ8yETEeli1pfAf3NafBBprI+h2paRvBf56Y9HIiLhN1ApJxAHeVUXReg1wBuEgmA/iciB9+9jMPyzETd3JMaaYUY4iKoH5PynmClb1jQlzEXADMtO0EvuTcCEuuQ7NiN8kzAGRvEmanqLvSXoXvL1Fe7Rlctsum0yn8Zhb3EOguRnlSjee+EnplEOVVsijVALA1P2K+ZlU09u7HunIvBc1hEDXdbzOcL14xOjD2HLKSNVzIR7YvjEWxnnuL9Dj9LfRsJEC8kvfshaqnj4/8JG/rqi+WHussJYkTyer1SZFwfOJ2+VELrM8jEes+wAbkeLv26uwVwoIKCwiQMEmeGf72t9CGKmCB3+FoFP8CRvwPyae0j43ITZYv9Tws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b115b55-5578-4116-8dc0-08db5a7019bb
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 02:56:12.0989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz5EHEdFssrcEFyVvNcQDCuZ3A23lk+9MjNb2Qu47SS6xtCsTi7i6oI51XzXoqWWyP5ewEUbx8oIOWiVqTU4Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4706
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-21_18,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220023
X-Proofpoint-GUID: fPfYMc7YHrGEAd3o5KXMJ3lwQyHZ7FiF
X-Proofpoint-ORIG-GUID: fPfYMc7YHrGEAd3o5KXMJ3lwQyHZ7FiF
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/21/23 4:08 PM, Jeff Layton wrote:
> On Sat, 2023-05-20 at 14:36 -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>> for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4xdr.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 45 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..e069b970f136 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2920,6 +2920,46 @@ nfsd4_encode_bitmap(struct xdr_stream *xdr, u32 bmval0, u32 bmval1, u32 bmval2)
>>   	return nfserr_resource;
>>   }
>>   
>> +static struct file_lock *
>> +nfs4_wrdeleg_filelock(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +
>> +	ctx = locks_inode_context(inode);
>> +	if (!ctx)
>> +		return NULL;
>> +	spin_lock(&ctx->flc_lock);
>> +	if (!list_empty(&ctx->flc_lease)) {
>> +		fl = list_first_entry(&ctx->flc_lease,
>> +					struct file_lock, fl_list);
>> +		if (fl->fl_type == F_WRLCK) {
>> +			spin_unlock(&ctx->flc_lock);
>> +			return fl;
>> +		}
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return NULL;
>> +}
>> +
>> +static __be32
>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	__be32 status;
>> +	struct file_lock *fl;
>> +	struct nfs4_delegation *dp;
>> +
>> +	fl = nfs4_wrdeleg_filelock(rqstp, inode);
>> +	if (!fl)
>> +		return 0;
>> +	dp = fl->fl_owner;
>> +	if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker))
>> +		return 0;
>> +	refcount_inc(&dp->dl_stid.sc_count);
> Another question: Why are you taking a reference here at all?

This is same as in nfsd_break_one_deleg and revoke_delegation.
I think it is to prevent the delegation to be freed while delegation
is being recalled.

>   AFAICT,
> you don't even look at the delegation again after that point, so it's
> not clear to me who's responsible for putting that reference.

In v2, the sc_count is decrement by nfs4_put_stid. I forgot to do that
in V4. I'll add it back in v5.

Thanks,
-Dai

>
>> +	status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +	return status;
>> +}
>> +
>>   /*
>>    * Note: @fhp can be NULL; in this case, we might have to compose the filehandle
>>    * ourselves.
>> @@ -2966,6 +3006,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		if (status)
>>   			goto out;
>>   	}
>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +		status = nfs4_handle_wrdeleg_conflict(rqstp, d_inode(dentry));
>> +		if (status)
>> +			goto out;
>> +	}
>>   
>>   	err = vfs_getattr(&path, &stat,
>>   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
