Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B652712D8A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 21:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243601AbjEZTec (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 15:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237652AbjEZTeb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708C1189;
        Fri, 26 May 2023 12:34:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QJ4eDp028719;
        Fri, 26 May 2023 19:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rjAq6IUiRFwCx4bCSO/+FwmIAZEVPgMphwiRayd2VUs=;
 b=OPtcz4M+FjEUnbWwd2/cYFz5zRMzOOgKiXgSC89OewyOvejJNyDRicyAtgARofjzbwHe
 S5wTPw6eO/thjXtzw0LIspT5hd3O7iXifch4ql4SOBQi0gSW/Wtj/GLvDf10T3qWopFy
 ISSvUi/WVGvD5SVWLAantnyuMD/gSeJ05J1t0S07qaBbw46vyJWq8jxgURn7oH2Gm3po
 EO4L2y7iOstZc4fokn2iG0Alf+xYj2tVEqLuQ2Qaj4H4D0cLRYaqJA5ohyLbtynGAKu+
 o5DJgbjbgL/smCK+2I6n/PutjsrsCufgOE47DSkl6S10kO0B6rIr4bXS9rHcbekhyR1T 7w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qu2kug1mt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 19:34:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QIkl3G023725;
        Fri, 26 May 2023 19:34:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8yvs3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 19:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUsvnwPbupKeS3hpuBdI537CfDy+yvGVrxtLEryYbNoKHQOjUkAOjJ/XdONIB7qUrk/HWHE28+4FePZHS35eY+xP6h8nM9TP7BVcQcTNPgIOZ53xinlPAIt3T/O99xPADraee9awCCSiX0TAqMaZCsKINP25bNsgAymlacjk543Dmwm0+ExSYJa8OYScxZkUDIxszrhIqowEW5qLe6oILwEgvFzB9mKtiyp0Nb1yA9t9sw9j6PTBDvBEWo45DUCJp9OkVYEZkNlGkAvk7GsKCKjRVUXG8wxIIM+m0VeGJbnb2iF31/t/2S/gR88W0C2YMbTiOdaEr48tIkkXpqT8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjAq6IUiRFwCx4bCSO/+FwmIAZEVPgMphwiRayd2VUs=;
 b=NS8ICUghmTL5jqSt1LWHFeWDC7ZtB9fpZgd0x4ctWsEF2/eAEruyzgqBey1BhcZ9QSOnDXNWqIM13NLUOhrISvhwBYXhn3a5aDNHuAQNKsE8VvHhvvevw+Iq1YPk6HCgxEQqEPmXuNnu3Ar5vFbQALMOePRoIwyrzM+Mxk1BvyOgCpFWDujO5Tfj5BlZvLZxy66XkWDaP6HxKcxmZ3lzYJjmuXJjiBkUZhMow1+9l5lESOf2XkokgNqze4CZaSWHjgtb23DQ3m9MMXGkOXIpLlL45zIIdyzqLdOIcJFpyDvPNE90f7e8aYSf9Vo8HP5wZOhaIkb79xj2ddaGPyMmSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rjAq6IUiRFwCx4bCSO/+FwmIAZEVPgMphwiRayd2VUs=;
 b=lL1sqBz87DQTRuAN7WV89we9Uc1wu1dwHpqulKrJDrlVzhuyNI5QR+yGVd1lT1JurAB9ClgJVfL7HLOQ+us5MHjRmFftshrKrM5BcOGDim8wFeodpJVeR4ADA4MpsaILgV54n3Atwaucz9SOEPBebB9UsS5J7q3ZDty9/YkRtSo=
Received: from CH2PR10MB4264.namprd10.prod.outlook.com (2603:10b6:610:aa::24)
 by MW4PR10MB6348.namprd10.prod.outlook.com (2603:10b6:303:1ea::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Fri, 26 May
 2023 19:34:21 +0000
Received: from CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::8027:bbf6:31e5:2a80]) by CH2PR10MB4264.namprd10.prod.outlook.com
 ([fe80::8027:bbf6:31e5:2a80%6]) with mapi id 15.20.6433.016; Fri, 26 May 2023
 19:34:21 +0000
Message-ID: <85bc3a7b-7db0-1d83-44d9-c4d4c9640a37@oracle.com>
Date:   Fri, 26 May 2023 12:34:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] NFSD: handle GETATTR conflict with write delegation
Content-Language: en-US
To:     Chuck Lever <cel@kernel.org>
Cc:     chuck.lever@oracle.com, jlayton@kernel.org,
        linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1685122722-18287-1-git-send-email-dai.ngo@oracle.com>
 <1685122722-18287-2-git-send-email-dai.ngo@oracle.com>
 <ZHD8lDQADV6wUO4V@manet.1015granger.net>
From:   dai.ngo@oracle.com
In-Reply-To: <ZHD8lDQADV6wUO4V@manet.1015granger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0244.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::9) To CH2PR10MB4264.namprd10.prod.outlook.com
 (2603:10b6:610:aa::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4264:EE_|MW4PR10MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: d6f160eb-597c-4316-cc62-08db5e203423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GC9RY6DKFeoN9et5FEyaLCc0oL3n989m1Fcutk+FTDuW+oIOxd7V7trwkL7kUspnI2+asSns1QvDxjlyjG9r/wwgADLsfar1DzvEefT6SZS9enB6xUCi4GxzhospbETycbdMRJodFdhQ7XiKTe6ndTf+QeBA1HhyFQ1wLBpHpid1XaiZf7+NDWHcECrSjmsK95TSjksJp07wZYHwft9rFhfozJ0+OEo5TaDVz93tlo1yVrYxuIKrwmumzz6Mip8ABSKG6xmJUHRS4kTLnrAfw0KObALMkwmnNGnm95CQRQp/6qSEZpXSCsqivVARMZaarMwWfKH0LlPF8fafntLbk3rwbCxx+TR1AXulLE5D2p1A7gaifLIu4sBhzTeaRbP2mkTRxL5zUWOyZFBnodDwvFGVXE5jKx72UvMoXh3Zx2jH9Q4DfsEgLXszJ54ZASPic5jGrUJhPvXc8axxWdFEQFModBzllfJEWc5ZI2dcgtbTMFmuYTd8HhPBolgPfa0wGKlHkuNKqBjVCFXujCnlZMBP/aF/hFm2wTTlF02xKN+zTzq7lBys8pZAi++48Y0PjPhjFeyRJ1giHfzQBQoj4l9I/KrJfyfA9y8pffOIdhMuKy5dWcxfikHypRzdvTqI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4264.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(396003)(136003)(451199021)(6666004)(6486002)(53546011)(478600001)(9686003)(6506007)(26005)(2906002)(6512007)(6916009)(4326008)(186003)(8936002)(5660300002)(41300700001)(66946007)(8676002)(316002)(66476007)(38100700002)(36756003)(86362001)(31696002)(2616005)(83380400001)(66556008)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVpYUm5ITXh0NDZ6QmxjRmNXQURCcjhONGtWR2V4TEx1ekpYdTNLbmo4NlFF?=
 =?utf-8?B?cHN4T3prd0Zsbi9mOUVKbjdmSmo3Qy9Dd0Z3bndQNW9Nbk9ycTcwQlFmdE5J?=
 =?utf-8?B?ZVNHazYreDZsTFJwZFVhNWtiUWVTMHB3QUowSUxNWmoxN0F0SmNhVTZmOVRC?=
 =?utf-8?B?YVhrWWJEa3NPRzRRQTVKd2gvcXRPNklpbTZHcDlDc212ZWY4eStlUTBldnlm?=
 =?utf-8?B?MUUyNXREL29MZzdrZkRSYjNzejB0bjRnMU5VVFVJRStnbU44ZHVMRnUwYy9i?=
 =?utf-8?B?VE55aXpHbDR3T2lNNVpDOFk3K0plbHpkdCszTWNKb0RTc0h5SHV5UDJrenFO?=
 =?utf-8?B?cXhqVjBkU2hoZDNiQmEyTyt4T1R3eUVnRnlTMGh6VU8wYXkrcXpVeUZkdWg2?=
 =?utf-8?B?b3pEczZDTUlnbTgrNTU0UVFFUFoxT2hMSmZpTk1BTUxpOEMxVXFIUUxXVmI0?=
 =?utf-8?B?a1greklqWWF0OTlnT2FidXMwSWJHZngxQW9zbkluaVZiZEE3NEx6THdPVWox?=
 =?utf-8?B?NTZFQzE1dTZwbHpXc2pBaDFPODdHTmgxK2xQV2dXemlvb3JtMWdXcW5VNnNQ?=
 =?utf-8?B?VnBYOVQ1d0JWU1k3dURSWWNla0JjSjROUU9UV2VGTkcwb3lZQS9DQ3FoWE5r?=
 =?utf-8?B?NGRuUm4xckhLOUFwbU1jVWRxcGg1ZkNhNFpGaFIxOURlSjFzcE9hUFJ4L3RX?=
 =?utf-8?B?dWpRMkdJVXhzYTFsZ0JKNFlzMkkrNXVJV2preFc0ZHE5NHhncUVKRWR3UTl1?=
 =?utf-8?B?NzhpZ2JleFNhT045TG10K2hORi9hTzM4MGNUbG1ubmtKb2VuNTdyVXFPV2RD?=
 =?utf-8?B?OUYwTUhLeDB5T1JlaU9Ya2xDMGFxSEE0QnpuWWhoZGdrS0c0WGljZTc4a2hu?=
 =?utf-8?B?eGhUM1BjUm4wU0U4V0x2cnZuRlZFVWg2aVJObk5YbDk5eE1pZStIYmRVZTdY?=
 =?utf-8?B?TlREVUFBaU5aSjFuWlZvcHZxczNHNnJlUldzZWpYaFhVU2FnVlIva1MzWXFo?=
 =?utf-8?B?ZUtFTWtiZW9jNHpYUk5NVlBBd3VzS2lXM1I2cUpiOUQ1amRIQ3FISWV2U1ZT?=
 =?utf-8?B?cTF5YTVVdlZiaytDYld2S0JCSFVMRGFPNVF6N2JQN3Y0VU9ZYlFwenAzY2Vk?=
 =?utf-8?B?QmFMMjdZVitwZ2djYjFCMzhqVS9tbXRIcklPazl5TythT05jc0pEREFzZUVu?=
 =?utf-8?B?V2x0SHN5QUZEa3BROTF3VzVmcE9ZMU1DRDFXNFJvNTYxMmhadEkvNFhtNUFo?=
 =?utf-8?B?QWJZOTJETkFDUFFyTms0Tkg0eDJFYmEyUy96NVZPaGZteXZsQjhldUFKWE9L?=
 =?utf-8?B?dyt1MjByajF2N1JNTW1RWlQ1eTRmVXN2dkFGWUczUzY3aWVGczhtWU8yYUtq?=
 =?utf-8?B?NXNrTVdJTkw2bExFUVR5VUo1UnRlSllSbTZ6Q09hMHlFK2hUWTJyWjIySzIy?=
 =?utf-8?B?THRaVHhJYW9rZ3Z2RTF0SGZBQnRzb29zVEQ1TDBvMXpTZlJmbWJOTy8veGZG?=
 =?utf-8?B?MFhjK0FaaXI1emRsSmROVisydzJnVlNvbkpLbXViNmkvN2taZkk5WkorQjhF?=
 =?utf-8?B?ZCszUG1vaFVZQ2cydmJwSjZoSWthVmU2LzZpVXBITG1QOGI4eXcyZGtxdW5E?=
 =?utf-8?B?blBPUG5xc3J3M2FIWWNpMHhsN3hBMUxVYjQvbk14bjd6cDIvcUxCbXV3bjlo?=
 =?utf-8?B?eGxiR29BdzcrR3Nud2FpZEVNWVk4ckdnUTFoM0hDekxWUjVJbnUvRDVnNjQ4?=
 =?utf-8?B?VExuVXJJM0Z2Q0k4UnZNZGZ0UThkMGdCM09CbElndFM4c25uQTRmdWwxWTEz?=
 =?utf-8?B?ZVd2dnRCdVlhZ1BPd1Y5Q0Y5b0tycEJSNTl3N25lcDRSNmRMdVJ2dWFOVnFB?=
 =?utf-8?B?OHZmUGxVcitUL1Z1dzEvWDZ1S0U4NHpsM0JnNHRpRnRYMEFjaDhrQU5FaWFE?=
 =?utf-8?B?V2NoOExFTWlOOFQ2WFpnKy9CMXQ3YnBadTRYbXVZd1B0RXBXRWRGd3hSOHpP?=
 =?utf-8?B?cjRvUFhYRHdkMkVZUXdTcFhacmR5V21aWmxqa0c5elo5SS9NT3ZFZzhIQm1j?=
 =?utf-8?B?Ylc4SDVuRXUrSi8rRjFYa3RlTyszSHBCaUFXV0YrVDFWMXdmYTNONTIzSkxo?=
 =?utf-8?Q?/H6hLfR5lQnv/0jxG55ZN8YG2?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tS+5wjcoOtuPrEHOnGXKSc/ep89LnHLPNZMTtRbqKLJWQyVY3dw3S3m4kfJuemoWxW+y0ftPrnkraIWhlceLV3ogmaTlqLOi0tQDXA/T1k4LF0dCVn/xRM/LLmGUOZyjuaBzQEMLgDTmAaTidvA7B60sG8110Uf8DqJXif5Lcb0+49ytTXeoGqR7G6/dWkAnG2Xili6a08bY1993mJ7REtxg31JYW4MmFqWco2C7m3LoZVCW+HpsxHNYmV7txU35J+zxZB390RKgSq92lMbb4Reknr/fF1gZSFEv4PSbheJYC6iibZZ3nhD8cWZotjzBnF5R3JXx5OHefojF5FH7yshnEk6PbIa2549GammlzFDnfXIlhRqaPz9RliQtD3k9YzJIZ9GzGu3tAWm8tU4xQYyFP3P88hTjiO5zYOlcjM06uu90nhHlSwt+/dEGDxR8RfW7GgeLDnpYpbN5UTIrKkZz0FMPgX/SErxO00hVxLemCwlMcddMFdTkN+cTkjBIjIBAlxsrDcSVi3h6GBBgjLrX+aV5N6hMCEA/uQPXUbDJd9/PWkWvh82+TokVD99GPzS5LG/MciTD9debrTmOYoq04QhwSvyOmwBhU5julC+t9k8O0CcTw//Jfm9Hv6WcdJaKdaK+fL3xN3KgpfdrNFDy56fhPMl/xXCeFgZSjlpSoNUcx2hBCehnKISrKR8GboGYZm7uBM6CKGcE00KyRZjwBqzvIaLprNjG2tuwPzhhgOhNUDfAegvl2h6qF2ic9NrYllKIG7uSg7FHDhu50ydwUVeg8h9ZM751c5c2K0w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f160eb-597c-4316-cc62-08db5e203423
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4264.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 19:34:21.2106
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: utas6sVhEJiHEnbqwnDFIDe0LmrzHVj+b+jw5D9d6iEr0kWdh0fK9Hwl9i5PMCGa0kPM7kxlCkd07n0wYb7+4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6348
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_09,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260167
X-Proofpoint-GUID: -mQPstFKARk8-p2Qp60rdWmd3Yh3LASv
X-Proofpoint-ORIG-GUID: -mQPstFKARk8-p2Qp60rdWmd3Yh3LASv
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/26/23 11:38 AM, Chuck Lever wrote:
> On Fri, May 26, 2023 at 10:38:41AM -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the write delegation is recalled. The server waits a maximum of
>> 90ms for the delegation to be returned before replying NFS4ERR_DELAY
>> for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  5 +++++
>>   fs/nfsd/state.h     |  3 +++
>>   3 files changed, 56 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b90b74a5e66e..9f551dbf50d6 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8353,3 +8353,51 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   {
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>> +
>> +/**
>> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
>> + * @rqstp: RPC transaction context
>> + * @inode: file to be checked for a conflict
>> + *
> Let's have this comment explain why this is necessary. At the least,
> it needs to cite RFC 8881 Section 18.7.4, which REQUIREs a conflicting
> write delegation to be gone before the server can respond to a
> change/size GETATTR request.

ok, will add the comment.

>
>
>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>> + * code is returned.
>> + */
>> +__be32
>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	__be32 status;
>> +	int cnt;
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl;
>> +	struct nfs4_delegation *dp;
>> +
>> +	ctx = locks_inode_context(inode);
>> +	if (!ctx)
>> +		return 0;
>> +	spin_lock(&ctx->flc_lock);
>> +	list_for_each_entry(fl, &ctx->flc_lease, fl_list) {
>> +		if (fl->fl_flags == FL_LAYOUT ||
>> +				fl->fl_lmops != &nfsd_lease_mng_ops)
>> +			continue;
>> +		if (fl->fl_type == F_WRLCK) {
>> +			dp = fl->fl_owner;
>> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker)) {
>> +				spin_unlock(&ctx->flc_lock);
>> +				return 0;
>> +			}
>> +			spin_unlock(&ctx->flc_lock);
>> +			status = nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +			if (status != nfserr_jukebox)
>> +				return status;
>> +			for (cnt = 3; cnt > 0; --cnt) {
>> +				if (!nfsd_wait_for_delegreturn(rqstp, inode))
>> +					continue;
>> +				return 0;
>> +			}
> I'd rather not retry here. Can you can say why a 30ms wait is not
> sufficient for this case?

on my VMs, it takes about 80ms for the the delegation return to complete.

-Dai

>
>
>> +			return status;
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return 0;
>> +}
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index b83954fc57e3..4590b893dbc8 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2970,6 +2970,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
>>   		if (status)
>>   			goto out;
>>   	}
>> +	if (bmval0 & (FATTR4_WORD0_CHANGE | FATTR4_WORD0_SIZE)) {
>> +		status = nfsd4_deleg_getattr_conflict(rqstp, d_inode(dentry));
>> +		if (status)
>> +			goto out;
>> +	}
>>   
>>   	err = vfs_getattr(&path, &stat,
>>   			  STATX_BASIC_STATS | STATX_BTIME | STATX_CHANGE_COOKIE,
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index d49d3060ed4f..cbddcf484dba 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>   	return clp->cl_state == NFSD4_EXPIRABLE;
>>   }
>> +
>> +extern __be32 nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp,
>> +				struct inode *inode);
>>   #endif   /* NFSD4_STATE_H */
>> -- 
>> 2.9.5
>>
