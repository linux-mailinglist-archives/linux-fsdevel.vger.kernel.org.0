Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC397980E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 05:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbjIHDOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Sep 2023 23:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbjIHDOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Sep 2023 23:14:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3B61FDD;
        Thu,  7 Sep 2023 20:13:44 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3882dJdg032553;
        Fri, 8 Sep 2023 03:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6PsbMmi9yWWuDZqAAgD6eq8ECE3kJcun8JGXc0cJ0bI=;
 b=gOPFjp2kTf3YL2Tn3u5es4kWtW8+Nl49p1wIgpUUGcaz+Nw9lxS8ksF2aLCwZdOe75L8
 mv2/EJZKFr3OTdqFjo2FbJaRNtSSka2E8HrCgPck2002jMG1GqRYjBSkR3wRqHC7nkZO
 Vg7eHmwR/mjHEsd41lKVRkygnhEjqS8FS1eQCfX5B+9gVxcsCEkjoTLIgeHogcS3a4YL
 BLGUQ2cu5fjry5kHvLia2jW+pEkHVyWEcb8hKNgUhmB1+uigsMtGcEwdmD0uGrSvblh1
 dfUYAAKcykwLvSamWm1tzFeZRke6xQQgDp8qt1mPLSnBs/9EPfeudKwLZlx3DXBgzSMP Dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3syu12g1t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 03:13:35 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3882CLKZ037651;
        Fri, 8 Sep 2023 03:13:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suugeus4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Sep 2023 03:13:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfu/HwYoK188jMs0DR+GHvhpHQomwwYUTRjGz+hqqdADT47SxWIuMVp6SsAIhLR/d3ClXrc22xLiI5sJv3eO6bBpNzh3oPpBaALQx5X0IG5zpb94YQX+/AJfA4ZbPhzAp7fs5iO8J+YFssgrRzyoP6jdodnAB3jCW077ODblqHZL+uzSrPQsBWHOL5p2Zy5uj2Pwa7JHB0IUbjkh2/dYiBa8Dm1lNQk5ZQoOiNTH7AI+3XUWtiIni8IGlEFoC3cra4oULrDAG7YdbVmYYUIx0h4msikv1MVrw6JYS4jYgLn2i1Yyqvxv0WwnJjHsfUCxyzkPuKCZFUAHXCX5omNraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PsbMmi9yWWuDZqAAgD6eq8ECE3kJcun8JGXc0cJ0bI=;
 b=V15CHPW9qzu6THmppvCEnPeS8NkKGE9lnfIxv+6CDe19cW4v5Y0C5j1hCuuSWKQQHnN6p6RjxOQnmqk9XWK+JH+35kb+ANNWq2j22oE/qxPq7PZunJbRz2ARcxw2r+uHlOPCSbHD9XyRxNReASD8XRfwmybHp6L7sFPeKNCFzU7NZukG33FV3e0+lwD0broH8gxjYn2gtcCX1SJiyiZKN8yV+bHVqxtbtv6EbbW2tHFUAkgUdJ4FfviiFhdK7Wqb1a+ZsDFOxnPeNsYkHPPF57Ov4FbJaCfhvSRKm2zDPx7QxlCVcmJGBNvl3F8f9rzWugDM806/eoGTbsV394I8lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PsbMmi9yWWuDZqAAgD6eq8ECE3kJcun8JGXc0cJ0bI=;
 b=SRShSAskUMjuZCI3y+pPLHeclWCzcaq74IfEwWUI2n8YiIzWFhd017VAZ7ajQ1bM1llYEzN6P0BV1LG9fKsKMEMfImEI9zz2DXOyr2SFEMgD2gCsCy0TXDzAMbVXO4tIQJCsjT30tlPfiVK0/SokRVoXE1GwrwK44Zlvbc1nDlQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6245.namprd10.prod.outlook.com (2603:10b6:8:d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.28; Fri, 8 Sep 2023 03:13:32 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6768.029; Fri, 8 Sep 2023
 03:13:32 +0000
Message-ID: <26d4c3a5-5f38-3a4f-35f4-4742a640830c@oracle.com>
Date:   Fri, 8 Sep 2023 11:13:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] check: add support for --start-after
To:     Luis Chamberlain <mcgrof@kernel.org>, fstests@vger.kernel.org,
        aalbersh@redhat.com, chandan.babu@oracle.com, amir73il@gmail.com,
        djwong@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, patches@lists.linux.dev
References: <20230907221030.3037715-1-mcgrof@kernel.org>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230907221030.3037715-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: c7d9487b-b6e0-481b-f345-08dbb01994e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vV+4JZv1FtdIBVlZu0DE2HbHgRvie9I+zv0A3ncPkTW7QVEoLnxnUyS7c5jkh8ymSS/iR/UFR0GX5wkeoTVFfzAAXDwJpPC/JYCgPEWLv8VtslrPdMSXUgDbnXrugX7+nETVMVRTg/zQE0mfl6rIU13hgn8EKb1RcTfCyH201yTx+Il3b/SHdnsnR+C12omlCJSmvZQjxfDtKBd7reJ1qFcEgsmMvX3OIZi0o3f8xNAduYZofsawuyF5MUI/6tNKcNK//ypFOrn0BK/I1eMZBG57gSIHxHdrAkSIccdOH+zYRhf21fW38CMLkS8gSpJ2HXLfstVlHfSoRblJr1MwIg4cHPkSIYfzGjsDHuXcxq3wCnAFDsrRkrcW5YCG7/i50M65k6mBUUY5GuzFYsjxuo80AcOVLsx6MuPwQWpruRJdwktdee8Wz95SIN2a2tm01As9zOGhA1KfXMbiHLBC+daWmdJjl94fqjrcEIa5kah0mHMytTtF4D3dMmqQRdlH7j+RpH7Aw1BeuJA2lQAIt+BUMi5fIGVPqWO9ApoFKnhms6ptf+kAjVBlwlxAj2SJYBJqZ7woH6cQ5jt+vxCUZcr18z8dz2OZ/NaZUYJafcS9GMVkA1MSMo1DMHTwiNTHGRTlxKE5WJB4F448M4f6fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(2616005)(44832011)(31686004)(26005)(4326008)(6666004)(8936002)(8676002)(83380400001)(5660300002)(6512007)(53546011)(6486002)(6506007)(36756003)(41300700001)(66946007)(66476007)(66556008)(316002)(31696002)(38100700002)(86362001)(2906002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YiszUmtLa2hSbVBkOHY4dVQxanphU2h2bWtkTk5wT3puY1NUYWozcDlDRVJI?=
 =?utf-8?B?ZXg1T2Q2MTJPZVdNM1pIMEloN05GNnYzdjRUUHEwTG0xSVdLZitQenFoalhO?=
 =?utf-8?B?bE8zR3J3YnYydUdLVGUxcXNvQjVWMGtnY2JLNGNwMHBibzkycy9QakFwMWgy?=
 =?utf-8?B?bnBOYjNDdnk3UEw4aHB3eWdud3pZbWVlSHFQaVhNREpyNFZXT0Z5SzNPOE13?=
 =?utf-8?B?UW9sQTByM0hZUWY1dmNSRnpjNWI2dVpoU0UwZVoyb1dsc0VvSUhvVUxSSmgz?=
 =?utf-8?B?WVJoNzBXSmgvMEJRdFRNUHRZcUZBbkhDaUprYjZMRnJjMXRmZ1BGNityLzNT?=
 =?utf-8?B?M2F5dDJmL1hYcjdzZWVnZEJDYzZkNW5CNEVwT2g0MFM2YW9DMzhtTDAyTVEy?=
 =?utf-8?B?SmE3blltTDg4V2FkWVY3VDRybnB5Yi9uTm5uNG9UTU1CS1JaMVVCTE5rdUFJ?=
 =?utf-8?B?TzlGTDR4NC9ET3FvZGQ3dUJXS3VEV21ISDBEY3Q1T3I2bWh1UDAvam9ZU1Np?=
 =?utf-8?B?YjhWY1RFQ3BseHVHL01ZSkRNcEt0cEo0MStSTDBDY0llL1ZsK3d4SGRTb3M5?=
 =?utf-8?B?MitraU56MDM2azdhN1RSeS8rOEVPTEoyc0d0dWZpT1pnZlRseVJMNjVEeHZS?=
 =?utf-8?B?Sjhsd1ZmZGF6TzdsejR1Q2kwRlZLeUFGOVEwUFlRNUpJZXc4K2dPcEZxRnpD?=
 =?utf-8?B?MlNXQXRVVGJUdGI1dWN5WUdzeTZYQmpwbEx3cEZVdUlUY3FlV0NXWXlFUW43?=
 =?utf-8?B?M0J0U21pSnozVDVqUkRtU0grNFJ2bi9DSWg5dDhzQkd6OWExcGZWbytLQU5m?=
 =?utf-8?B?ZDVpNEViOU9WTEJ5aG81aHovc2xGNEt0VWpzZ2l6QitIeE9ORTNkVW00TEgz?=
 =?utf-8?B?cnlqaHhnL0xPRURteHR0UEx1aExML01hNXZXSy8yRzgrdFo1eS9KZHBYSy9C?=
 =?utf-8?B?UVFGV2ZFb2pKeWZJSHI1Tm9RRGRWL2lhLzNzY2w5MVNTY2FqVGpMQWU5NFJw?=
 =?utf-8?B?bjY3Mnc1QTg3dG9sUUNOUGJGV3NrSllvSVBCVm1UdmNvb2hIUTZkZGlLSWhp?=
 =?utf-8?B?cXdpRFV3QUFDcE9rSHFrUDB6WllmcDVWblJrOERDWFJ6eVpXOE9GZCtHNEE2?=
 =?utf-8?B?ZmFYNGJPVWp6T0hkdWpYYjR5YjJkZ3lETmpBM2JGWkFzc3Z6YVZOcG03NGF4?=
 =?utf-8?B?dyt6TUltbndNVjdzcFJBWUoxQXdic0lvT3dVY0g2WURiVGJBa0J2VDRVTnl0?=
 =?utf-8?B?Nm1xaDVCUjJFT3lNUFB3NWVRSnJNNFl4V2dRZUpIWTFtdkFwQkZkZlU0MmJS?=
 =?utf-8?B?ZE9ONzFJWllMSSttL2tiZHNheW8vR1ptODBaSFdDbGxuK3hGNHh4RVp6T244?=
 =?utf-8?B?ZG8xVVJvUG4yR0RFYjhaelRkN0Jla3UyWG14b21JMG56WWg5N3pHdnRPbXZ5?=
 =?utf-8?B?bStiNmRKVnZjQjlDSHFzRnlncHAzdVA5S1o4a2VuNzNOYTQvV0p6RVhnVUFm?=
 =?utf-8?B?Z3BxSlp2Ulh4cWZUeXJwdFVPV1pBOXNCQ2swOHpDYmF5emZmTEpvODFFaXRt?=
 =?utf-8?B?N0VNWjRzbFovN0Q2L3dBM2ZlcmJEUUNLeXBEUWVxNk16RnliKzRkTytWUWRZ?=
 =?utf-8?B?ZDhnanErVWQxQThmYzR5SUJmWWNOSlptS0dBeHpjd012dlBtY3pyR3JOdTV2?=
 =?utf-8?B?T0FqM3VUZExYMW1CL0EweEM5cTd3UTRsaHlEcHc2OXhObE9BUDRsN2RlZ3Rh?=
 =?utf-8?B?TWljSXk4T01DT0VyNFN2QzdDcElESFZqenFINjUwT2ZJc1dwcDRJUStPZzZ5?=
 =?utf-8?B?ekZpWXFQbXlkQ2Q5NWZBSERueDlUdklGMGVzbTRJYmNIL1hXZkhYY2oySkRJ?=
 =?utf-8?B?cGFOMzlvQ1M3L3UyTG9RRUN0cjVNcXJDSDhIaC9URkp4SDBiRUpnWVJmajBN?=
 =?utf-8?B?ZzdaYk1wejM2cHdtZzZ4cWdkTC9hSlc0Y2RCUzlDQWhDbnUvQ2swTGorOGl4?=
 =?utf-8?B?TXp5SDFzYnMrR2dwTGlnY3BxVFZCRW8wRWZVT1RuSzZPdWFRTGR6dWtPVzNM?=
 =?utf-8?B?anNMMkFmMWNIUTlxSGkxMkc4dW5YdS9iRjdiOWZrcDZ3akl0V2hYUEhEb3JK?=
 =?utf-8?Q?JnD6Qv/X9xE4lOFfbyElt/vWJ?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: dflZ4IIKHcDQDYI0fsuMm3cc/9bmqqIpJgg9cAfZN0cluF2nr+gqQjPNvt63yXa/7ZFTG6fZjGWYJUylRQldLM4c6qPUn6cwn0Qcn/oZ0TwGBUfUjJXqA/0vsXyxYQZ8ISB34dWZY/mgY26vLeJgUI6f0Z1ZGEzigDw3arNpkGu52JwFutlhrUa/uZR/lJH32C0Voosf8CpH+9yxQN4Pp45TVmkQEj3/Ir33vKrd21eEX0XDxVzTqEDNJXhy8Eo3mmWQYKniz4X19NGwxcNmh4c5RM4kC/4kJw/uJiH+L4umM1ah0UYMWUIEQk/siixVUAYBHwTkhLQ05HQpozWUQiW2sJmQygL/De3LLIv7My2nhR7VFymVdSAdbwJqSVC2xM/VYqB22RyTjClxTqUzb+AO50ACzB3DQtzWmNfhctP5dzh+r/PGH0eReCSUw9tvbJGywf3eHPAcp/eEniYstfU3KV6FKnRBLNx5Ea+8sfMTgfzU2v8Ggb2r3UatLCuG1KY8PWghZ0xcMca7gR7KPMTv6LJW8lggfaEd0Kmy2r4ePRk9tAkJHY6rTiFC7b4uraDidkZhMaOXIf7z26CLee+S2MP+Jc/pfMwjE14matL1xgLkQo6krV7Uh7dMII3hM+ljNRg8pxlUseadClDparie2H0CtKsmn2grP1KglP0xbZmHdyA7JROq8nhWWm0qIHi/TxAg8GzARmfo4ytiEYdRTf5QYpIzO+p/N+8v+/fvynkqsBiintCvFiOJniC5QXBDxxx4HJcSePnd54lsTYnNw7iHn6gZz+bXzb/WtVfRgTL7hyZQJShN+9M5IKj6+kMJnvoTAArOvkSVYN4/keFYnaod+aJTbMLsBleiHrwrb23aYKUAu6wXQlwt38n2
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d9487b-b6e0-481b-f345-08dbb01994e8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 03:13:32.4889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g+v/4p/dJvzAtLF0VSET1S+FmDwt/4oYgi7GfTNZTsykmd3zln9TKtNkdxXGTffpq25iuo6uvjwcTMeIYj0QQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_15,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309080028
X-Proofpoint-GUID: FQuu7Pc4qsNGjySz7tgp5s_W-2WG2V-2
X-Proofpoint-ORIG-GUID: FQuu7Pc4qsNGjySz7tgp5s_W-2WG2V-2
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08/09/2023 06:10, Luis Chamberlain wrote:
> Often times one is running a new test baseline we want to continue to
> start testing where we left off if the last test was a crash. To do
> this the first thing that occurred to me was to use the check.time
> file as an expunge file but that doesn't work so well if you crashed
> as the file turns out empty.
> 
> So instead add super simple argument --start-after which let's you
> skip all tests until the test infrastructure has "seen" the test
> you want to skip. This does obviously work best if you are not using
> a random order, but that is rather implied.
> 


Please consider adding an example in the usage() function.

'./check --start-after btrfs/010 -g btrfs/quick' didn't work because 
'010' isn't part of 'btrfs/quick'.

Since the tests are sorted before running, why not skip all tests that 
come before the 'start_after_test'?

Thanks, Anand

> @@ -591,6 +599,15 @@ _expunge_test()
>   {
>   	local TEST_ID="$1"
>   
> +	if $start_after; then
> +		if [[ "$start_after_test" == ${TEST_ID}* ]]; then



> +			start_after=false
> +		fi
> +		echo "       [skipped]"
> +		return 0
> +
> +	fi
> +
>   	for f in "${exclude_tests[@]}"; do
>   		# $f may contain traling spaces and comments
>   		local id_regex="^${TEST_ID}\b"

