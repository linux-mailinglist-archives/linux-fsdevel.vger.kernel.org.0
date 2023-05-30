Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6483571706A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 00:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjE3WEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 18:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjE3WEl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 18:04:41 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350BDF7;
        Tue, 30 May 2023 15:04:38 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UKO6T2029837;
        Tue, 30 May 2023 22:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Bmy2pydRqwqZcFRWbiMatHarHwvAMdzHjl/PmxHna+Q=;
 b=ELCsa9cW70ndQyJF+ztcRCWymHTXaH+pp2d2Rvj45FaD8vkor7n/XVIIA+2KEjf9pSCr
 lBoi8WukuqOoFB1o1hPb1+rOA4lWJjhv0No+LEZkA4C4H27eu4ZFltX03VuoHo99p76D
 VxiUhi4D/Awgox1yt6Xq1VUVt/Bu7D0EXd67baazFdZdDUn5O6CwRyrDX+rBMcMZged+
 lDtFMugDP5oHZq6Tctomwonu/UNqDKY+PreyjISQUKvaaejo+RQv91n5BN0V3Z4lAKx3
 UyjD+g4t5HYiskgeZ1UI2nWh3qlYOcEVm4jOMOt94iiWzjQPf2HL6MYuzbnqMTdqrP/U ZQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhd9v5b5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 22:04:33 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ULo5IF030024;
        Tue, 30 May 2023 22:04:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a59ff8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 22:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ujw7A3k8W77fvuculSSMtfX/CJ+jkA4yEdNn/oaYSmDt2uoNEa6N/3AiWyntmSuU6SKUBlG45h83vep6gPrhYnhemdS15fxECXFDdEX2lbm6MFmF78+gaM2W/WsAX8AXqpn4TCemVLnPc77i2SdBoq6Dh02liPicXPaRH6+YEpP8qdnXe0RHIyWsyodIxdE3fvfqklTWrfFG1x0BFwS/7UUbKU4ftLDVz//xHS9zU/OVmkhQJ45RmQh0YM4HFo7DXhCfaHWjuSk42cTZZNX3eq5cTJ9NQ4/d7rEEr9kJYeqPeGsflwZiLpOCaYUtQK7WF2myhP9GQnmIxETqGbCQJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bmy2pydRqwqZcFRWbiMatHarHwvAMdzHjl/PmxHna+Q=;
 b=BfGS9X9hLdmJZ4dF5hyvBY61Iiagwc/ufmc0xm1LYEeyrhDVH8nALGdpyN6xO60XcjLK2NHdDLeOsU6MVjRsgFt+AwloTHvj8jfsPOtnAqqCQH413ikdzWp2WOZeMjRI5qRUzAlqCHqs3UXcKKKNlyLL4kC3QnOJ11WEY4LddB7rjuhtT+SDVsY0Pcjc9DLlNzV7I77iuh4NWwtxF3D3+rsBcKJamxlHSc03IbG23CmYwHNDy72fQKY1q2b06+Hdx/fooBvqjWAPqZiGeW7205OdGTjBa5Xjxi6M//94iXnsakyYeJc5jfuqgDRt/11iffZYkSEwRstNi50KmbO6lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bmy2pydRqwqZcFRWbiMatHarHwvAMdzHjl/PmxHna+Q=;
 b=aIxBG2X5o4l7q9M7G9urRG21yPJMvaSWnmcqH6MpsK6UuqBP03vKNWseecrRLg8cw9Q2wSKHmfIFA4EDK538FS3wkwTT16imMdOHtv1Ctbap9tDkNI4/XwZ/1x9OAkbnGIBH61LJnm9VsyvVu4sFT++wovjcP/nbJ4L1aHP7kaM=
Received: from MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
 by SN7PR10MB6382.namprd10.prod.outlook.com (2603:10b6:806:26e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Tue, 30 May
 2023 22:04:30 +0000
Received: from MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::8116:747a:ad20:6e8f]) by MN2PR10MB4270.namprd10.prod.outlook.com
 ([fe80::8116:747a:ad20:6e8f%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 22:04:30 +0000
Message-ID: <a566e41a-8f38-83dd-d477-cd7409a256e4@oracle.com>
Date:   Tue, 30 May 2023 15:04:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] NFSD: handle GETATTR conflict with write
 delegation
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1685429537-11855-1-git-send-email-dai.ngo@oracle.com>
 <1685429537-11855-2-git-send-email-dai.ngo@oracle.com>
 <283915f369b99b88b2a335034a11cddf7b93fcff.camel@kernel.org>
Content-Language: en-US
From:   dai.ngo@oracle.com
In-Reply-To: <283915f369b99b88b2a335034a11cddf7b93fcff.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0035.namprd06.prod.outlook.com (2603:10b6:8:54::9)
 To MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4270:EE_|SN7PR10MB6382:EE_
X-MS-Office365-Filtering-Correlation-Id: 680f5b3c-4ea5-4ae7-226a-08db6159d78f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vq+dqRnOQLvlmsNXTwRtwG58FKqv6qVaoRog3Kus+Itf+s4lS+jqNq/8NiPSO0vs4sruEhf+pJU77xe3HGoG4t9AOT1xQhkxlbQcOPJW8hBM8XNvOT9jvt7Fxj4t9qPyi9GiXs5qazKkHrI8COacLIN1uwPUd5ksVYyUmtLL6thQW5zqKnTJjhQWWai74M3dNobrs5N2uicUJW5qK6ptjAbFQGGtRQUitmmpB35RKcoWbyu3yAMzIfmE9agjJgJTov8gx0yNXpn7LqtOXEP27sD+SDncQKtZQp0G8Xlo/uFQm1HEDOFxVowo+tYqPEKRyMLwtA7gOfVDFlIclmfvoqh/r397db2pP4QvQ/r7E4wFcDigLxrA+ihnTyFxGAcD/BlTAHZ5VnexIBpMgigHESbScGUt8GRBG/JShaFsveyXzR5V/FvC0Elv5/UDGaj1TVaKnQod1KfsGRFDiRq8z4zKbruE6frnlKPgphErcwKXaVsRQE9frD/ukibUC6ivx4lHwqLP01JRgl4NWwFFPruibaxE/mTe14/FeE4Ng+ut9uxqfgl85nA2Oyp1nRwp2LicOIazf08dsYnYp6PdXODbDeZ1xf7cpmIH7lTNqhU4muX4jl22p0GZps/Mzc4T
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4270.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(136003)(39860400002)(396003)(451199021)(31686004)(2616005)(83380400001)(86362001)(66946007)(66556008)(66476007)(41300700001)(186003)(4326008)(36756003)(2906002)(31696002)(53546011)(6506007)(6512007)(26005)(9686003)(8676002)(8936002)(5660300002)(6486002)(478600001)(316002)(6666004)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zm5TUDZYcHgrQ1k3ektNeE5sNThoM05tbW9qQ2dYSEx2TWRhdGtYMGFDVmR6?=
 =?utf-8?B?L0xUamNMQThRaHp4TUEybFdwZ01xL0dPQzVBZjBqQ3pZc2RucHlXUUNrc3Mv?=
 =?utf-8?B?VzNhQkg3enlMRzhGcDJmeUluU1dUQ0RxZ0VHaUlqdTZYOTkwSnJsczh5cW1q?=
 =?utf-8?B?aWZlOEY0UzM3bVpoUkVWeHQydGZiZTVmWXYwQnE5TzlzNldjR1laT1UvWG9P?=
 =?utf-8?B?UGFwSm9CaEcvamtzZTFYUWFUOHpFdzdkaEVIMG11L2tVR1RZMzNOb0N0MGlv?=
 =?utf-8?B?NmNMd3lSUlY0bks0YXA2MytuQlNMTHdCZUcxOXNDNFdsa0V6ZU05dXoxOHo3?=
 =?utf-8?B?dmY2VnZBd2xnY2RacWJjZzdFNlM0bG5nNFU2ellIdDRnWnFNdUJ1QXpaNGV0?=
 =?utf-8?B?czZsZ2VMRkNCa1BscFRiRDkzQnhyd0ZIOUpmOEZNYVNIMzBVOCtQUnZwbHF6?=
 =?utf-8?B?bzU0bWp4cXhpaGdvZzRsanhxeThucnRuREpsOFZDdUlkNXN2OEZhTmgvMGcz?=
 =?utf-8?B?azhwLzlqSGxYbHJUd2Q1bS9jWGxKQmxmWEJXUTVoOG42OFFnVTg5YUFIWFVj?=
 =?utf-8?B?ZERrOWhDUldDVVhyUXFYNHAzSHJvcWdtV2puclc2bkljb3lSNEZHeVF1ZWt6?=
 =?utf-8?B?aXc3Yy8rRVJrczUrWXlmdHB3REQ0V2s3Z3ZDM1Y0bXptQzB3YWRFaFVHeGJS?=
 =?utf-8?B?QzI3M1hSK3VHRTk4YlVoK3dxQTFLQXVublhCQ2pKZE9va1dGTHBhRlg5c3h4?=
 =?utf-8?B?akFmZ3ZUejZNdWhCR1J2aStQWG93OC9HdGpyYmdCOUx4YzFSeVUvYUxJTVkw?=
 =?utf-8?B?b3FaTnBzZ29aQWNCaC9LYTN6SWQraVVIUHEwbXRLNlZCQ3I3dnB0UHJnUkQ5?=
 =?utf-8?B?Mkc2ZWNsVVpBSEZQT01HTXVncURzTzJKd3BJODdoaEdvbTI4QUZybzRCSTVU?=
 =?utf-8?B?NzlSVUxERldZQTNGdjVFdGtySGd3ZGlySGZCZXo3bHlhb1ZMa1cwcWZvOVhh?=
 =?utf-8?B?WEQrcDNwVlozNHlVK0ZqYTlsdEMrbC9pZGxWTVZ0VzNiSlUyMTJwUi9YUFVo?=
 =?utf-8?B?cVI4cHZBR25oRmJTclFxaTVNVW9zeGk0d2NhNFVidWRxK0U0eE9uTnhkaHdG?=
 =?utf-8?B?N3RrMm1HdFFEcllHWlJPK2hZL1lVaW8yUTY0bDQvL0NCMHpHZDhIcHZESkpZ?=
 =?utf-8?B?OEp0Sm5yUDYwY0VTOENEV010N1UyNlMzNjdpRzB5RzhUOWw4cWY4dVpLYzRF?=
 =?utf-8?B?NXhGa3JoL1RKSENYeUlFeUswL3Rxak14b0hGVXlBd2VkZjRUZ3EybUs4VWpP?=
 =?utf-8?B?TnJqcDQrWm1ES2xYdFBkdytKaHJSMmdTaG1palpuZTZnN0dxSm54R2VvZ3pp?=
 =?utf-8?B?SWkxc3JxTGJnVUl1UiszdFh1QmlXNTJxd0lYUCtDaEdtcFVQaEROVmRvZWNV?=
 =?utf-8?B?bTdhbUZMQWZ0eFNLaFcwTEkrdXpscFhWdjk3M0Y4ZmNZcDFFaENRQnVrUlI3?=
 =?utf-8?B?dDFRSUVHZlZ0ZUNBRzEwSmdMZUhUUGE1SG1vdkN5YnZ1MzhNUXhVQmc2T1gr?=
 =?utf-8?B?RDNmYTlrWCtPT0c1NmRSayt3dWxDVUZxTTZOUTdNZlRQcnpNRHgzOGNIbWZI?=
 =?utf-8?B?c2FmOTBza2p3QmlzQURDZ0pmaHFHR2hRV0thSmx1enpVOXlubjFwdWlKS2pX?=
 =?utf-8?B?Z1Awb0tMQmprSWIzV1JSRnQ4UVh6dFpKYTZXK0V6OVJubVJ0MXo4S0I2bFJw?=
 =?utf-8?B?VDYrLy85MjduK3lOSnRTMzV5eEtyMkJaTVc0UmpTT3hsUVJ0QmhuZ3NLT2lJ?=
 =?utf-8?B?R3ZxTzhnVkRKZ3BIZjhPYThWK2xaNlU1RmJvU0FQRkF6YkJDNkw4eXJId0RJ?=
 =?utf-8?B?Y1B2WWJCRWs2RW8vSVlvcnhrQ3BObDBRb2dEdDM5NnBiYlRGZzErV0R3S0VU?=
 =?utf-8?B?OEJFTzhhRTN1WFhOcWY3cnZaSFE3TUczT242dFZkTDRZZ05JdzdPUzhZK0N1?=
 =?utf-8?B?NEQ0WktaUEgwTmdlY2J2M29DekIxVVJpMStCU1hmR1RjdVFVb3djQTNCWGEx?=
 =?utf-8?B?SWlSbmpsOTlCVTJQYnFFUlc4MXcxc1pQS3BZVHQ1eVF6TGQ5OXZUcGMwY1U2?=
 =?utf-8?Q?LqnrgepSk8TumMggXIbT8w4oC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7pN2X/qmob04Fy8LoP9NfGb7iG+tdLXQcecvXBlHT4UQ139NRApFyImxesCkCPum9ba8suAtPhiFO4RNfDCkR8li5IjmAcmWV2wuOkJdm4D2rLz++Gcam0UYP5yU6GVTygZeqs2zFeRetL+FjaRAetLX20m89fCnZuCJyaITFdsKgcyn/J0FQuNmJvgSE/QtqHIkYhQH7U4OVHhsL+5IlARGHGXSDPXFJCcbGjpITWfUjXoVRQvG6j5MVsDc2DA7Xdk+C/+EzxLO/VRk3t6YxhaSiL3n6GIWfXoz6UlCrPmm0LRrDzfaYf/6Z8DvH1PDKZWLUtVI4Xqcb5HH1qCUEhsco5VIILES/NoD5zKWa6OmA3im83te6MuFnJ0EHL7sl0vsfItBhgTMt0/ZQzvMIhojQSWq9jiOXW9GMzObg+YE91pB5CM1lXoOeW5ska3IVmqVAMwFE0rF8t+4ELAioJ8sVxM/L0gmsyIIbr6J0e3ekWqsllf5B5GQUepD6SSzI5cgC11oiTXNwado/CDW+06+SOuWd0FHhUhrGHlaWCQjI/pcuy3oSsPHC14+69l2x1zLjdEBLQNJPqAi31Gj4g0vySa/EL+XqhnM0YXZF2pBE95QT4TGJC5w4L6hJv4lYp0sKloA4DKWZzxLgWIEjZmKswsi5WSwTuCo3oWL2SvvxAOm0I6TyLALp9YHPlZr3J56CMeSqZyo/Ba13aSlIHuC2sYfl8skzhiLI66uMxzG0J9QZTJTaBKrbE8/59cd5xpl/1qkJ9gtpZ4N7CQfSddXV4dv2QcNQp8lJ61zbcs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 680f5b3c-4ea5-4ae7-226a-08db6159d78f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4270.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 22:04:30.0997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zG6RYOCUJqYRe5fCUyPPBA/l7fE0y8TgonXQaNrJm/LQ70qSIxbCHEhpgOyNcnNucAZDqOAOJzMP+5W13CKmkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6382
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_16,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305300179
X-Proofpoint-GUID: LMB5OotkQQiqOOXDjWO8mREvJMpZyYgm
X-Proofpoint-ORIG-GUID: LMB5OotkQQiqOOXDjWO8mREvJMpZyYgm
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/30/23 3:29 AM, Jeff Layton wrote:
> On Mon, 2023-05-29 at 23:52 -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the write delegation is recalled. If the delegation is returned
>> within 30ms then the GETATTR is serviced as normal otherwise the
>> NFS4ERR_DELAY error is returned for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  5 +++++
>>   fs/nfsd/state.h     |  3 +++
>>   3 files changed, 58 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b90b74a5e66e..7826483e8421 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8353,3 +8353,53 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   {
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>> +
>> +/**
>> + * nfsd4_deleg_getattr_conflict - Trigger recall if GETATTR causes conflict
>> + * @rqstp: RPC transaction context
>> + * @inode: file to be checked for a conflict
>> + *
>> + * This function is called when there is a conflict between a write
>> + * delegation and a change/size GETATR from another client. The server
>> + * must either use the CB_GETATTR to get the current values of the
>> + * attributes from the client that hold the delegation or recall the
>> + * delegation before replying to the GETATTR. See RFC 8881 section
>> + * 18.7.4.
>> + *
>> + * Returns 0 if there is no conflict; otherwise an nfs_stat
>> + * code is returned.
>> + */
>> +__be32
>> +nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +{
>> +	__be32 status;
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
>> +			if (status != nfserr_jukebox ||
>> +					!nfsd_wait_for_delegreturn(rqstp, inode))
>> +				return status;
>> +			return 0;
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return 0;
>> +}
>
> If there is a lease held by a userland program (e.g. Samba), why don't
> you want to break it here? Shouldn't it also be broken in this case?

okay, I will make the change to also break non-nfs lease with F_WRLCK.

>
> I think this logic may be wrong. ISTM that you want to basically always
> call nfsd_open_break_lease, unless it's a delegation held by the same
> client.

I don't think we need to break any lease with F_RDLCK.

-Dai

>
>
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
