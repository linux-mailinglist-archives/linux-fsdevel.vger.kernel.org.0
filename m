Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DB2512A31
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 05:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbiD1Duc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 23:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242562AbiD1Dua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:50:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E9A98F70;
        Wed, 27 Apr 2022 20:47:16 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23S2hZ69015405;
        Thu, 28 Apr 2022 03:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZsH2/0gXTQvTrhH2nwypYBvKadKadDLmgR2GAkqUf28=;
 b=RjcMHp6nRMRsgew1Clf+EqYSNzJ1Szchu0hgkaPqKgm2S2Xyae/rxW1OFTdjqQ/49DN/
 5G4OFe7p8YL9bLpscQmPSs+UcEzQ3Xemxs3/X8FzcoUYGN1CMtrUXX3iy0Ys5NVkUnx1
 Tq3/tvA0nRvXgwI5qK/MkXcXNrSUbfVIcrInf31jiI3IMnMTzKuuTmYUaDqzkvaYWrYc
 aF03UwFTHKwexJCbUft/Fka8ixkvHyc4meeHqT8NFa+FFNd3WA9V1W4UTN69oKhes84x
 hihfgJn4Nw7c/XFq9lAZioTnuahpKlQJchc+/4RbCwRGDz35iB/WpWFwmDMg8M4q2Vyr Xw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9atr0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 03:47:13 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S3ebQI027192;
        Thu, 28 Apr 2022 03:47:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yn1ftt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 03:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AS3fCUIA+IlpB2ZATEpMUXwAKkxcs7lBAD7hCOYplPZR6qPT9egmeSkQ73aHGJ7uVBuFQUiG9MDujBqwuAAu4xfcWqKKx61RTdNIZx3n3ZISDxa/oEAz94Zj8eDhHqUg2lhirRGZxLczDiO3PkaeCLHVRLLWOep8LErLebm6fe+3cL5P4UhvPIi24gEZhCOFgMRvEyTtux10pt0fn6Eqc/pxp6NVOAJaeAGAcjE0DcdxPD1UGfUNWwYpGcBuu7TJOuBnDUntbAC2F5zBfLgNJKonY58FRitGBYKNooGjHxKC8gP+uiQV9gObO7TTlnbeAm9sgR1nd6RPxEj8lLVBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsH2/0gXTQvTrhH2nwypYBvKadKadDLmgR2GAkqUf28=;
 b=IXqkpvA6nCenSkLSbH4WGKu+GxJ9Mk1J0aRLnPksQ3Utxmn5NJeLwSOlBJX7BOKiMK0vvZpMKxrFWf1G/e3Awf20lwhDd94dSpneaZiITm2Q9nWAHlSvYzBTMg7RWG/Y7M1JOLSbLG+KJNQ1FJIehVkAoOCS2aWZxnq/yJc1o87SqSC++w7LFfRWLN9M35DMFETXje8e3l8aLB5LK+cV5Epxr0WQrtGT+ac0gfC0AWAR7aIF0yZCoXIhwyU9J8KOfC4Bdqp2aOxNcfZ2UhdkZBalWxHM6p29WSzW89ALNbPj8+Tmf/5JEuczYRdZtqNEq39Pep3MMJof3gXnUkr7fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsH2/0gXTQvTrhH2nwypYBvKadKadDLmgR2GAkqUf28=;
 b=ZrudXXv9GFCjcpn4pE8djG1u90C9az6i9QqudVakZ9aOzaQntWiAxIS41lnBLiSUFdVq6xElbXClg1UAk8z33uBIFszR005jsjplDgySAoV2DxfkWwIJkbGicfN6tqn6gVUfEuKIXL5Oqc7cwX5qvN6OdJOul8J+vDnjSSYMHsk=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 03:47:10 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 03:47:10 +0000
Message-ID: <9fb9a58b-2790-70cb-e8db-f443566911d0@oracle.com>
Date:   Wed, 27 Apr 2022 20:47:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v22 6/7] NFSD: add support for lock conflict to
 courteous server
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651049573-29552-1-git-send-email-dai.ngo@oracle.com>
 <1651049573-29552-7-git-send-email-dai.ngo@oracle.com>
 <20220428020511.GK13471@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220428020511.GK13471@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:5:335::26) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54bb0b11-ebdb-4dfe-61c6-08da28c9c5e3
X-MS-TrafficTypeDiagnostic: MN2PR10MB4256:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB42564D3B450E7AC24598856087FD9@MN2PR10MB4256.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N2IzRlaRbIFhZj+QV/IZSxpfNdKkr5rSAwGjpyl2a17NnR74xyZCtEc1Z7YukRX+Zc0Ss+90cZjPiaAYPmvt3ngov8qMduO2kWhgFpVoGI8wB5ffdjk0mNaVvjQ7wtaxVarpMq2TpSh3w5Zhhu9my0MgsMyfJyrjk5k5HidZVhdJ2Sm8sduPxXlY54sZfZMnE79djrbTYiLaYK+3TGcFIY5I7PCnLDGm4sM+A096VJL5VlJ9wb9J0JYoJNvC/onchuk1pnsiEzC2cvmWhWwR5kuLXYn56ZZkyletuxYtewIdii9J6XbJMXQW4SJ0PQtmnqEBBo9qYh2eJ+HrjwwAWbWtpYz9zTEDOyAIfI0QfBKv7ZrxCasEz90szUsynPlCORrn0yb9p16BiTYzz0gxYAmV2b5ziOxe5QTVaacketFOGE23njFgQStg8oFJQcxK1Ix0vixc43PjkCf10sSiYfps1aFrlpKe+2UZs8/o+IJdP1akJgjFx3+SBcWIfCEXRZyuJzEBhRztZvCqPk7RhnNpNcWufXc2AVBRNuW9W1F7DMbaDVvRTqevc146/kpaGHy2BXI6Y0Iy6E/eVlROycc6PBSeIPJY+aJo6Hn2qr3Tarao0jJ+kilQAEkyEEaOqMmuT+ah69RxbiNndokiMnB8TSRnvn6DMNeTaYvuB1B9uCoPRC/1nvT7GNAyJtC1YlNM+MOfvFzq3rrsZ6sPaJXTEnEKamcFksELmRMpao1tR25T89JXkoOHrUdhgUguDIf82VOV3oTbNDhfPJZZHGctte8ilCzpS88DOkZCkiQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38100700002)(186003)(36756003)(4326008)(8936002)(8676002)(5660300002)(2906002)(31686004)(6486002)(9686003)(966005)(6512007)(6506007)(6666004)(66476007)(2616005)(66946007)(66556008)(53546011)(26005)(6916009)(86362001)(316002)(31696002)(508600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zy9IclM3bjNLN1FGV2Q5alRpYTdTRDhRYUkySmRxL2lnVjk1UFc2RXZPL1VF?=
 =?utf-8?B?cTdWa2FoNGthUnZaY1p5NEIzM0NFVk12RnVyYWh4MW14eVIyZ0VQSktEZ0hB?=
 =?utf-8?B?aDR2d1g0LzF3djNFU0hNalc5b201eFlwcitYZWM0SVpFdjVFc0VGRlQvbVJa?=
 =?utf-8?B?YWpFY2hGRkl3ckJrUTUvb1JDTndXSlQ5NTBPVW5US0pVKzFXcC8zcDJ0aTFa?=
 =?utf-8?B?L2FpYzdudWdLTFZ5MEhIK2grcUJDVTBnc2dyR3Y0RzJIU2VodEdvS1hlVkph?=
 =?utf-8?B?ZHRPaUJTNnRoTGR4TFlsb1hxSnhCVit0ZWVJK0RPOVdMSWpZbjB1M1N4YVQ5?=
 =?utf-8?B?cDQvSktHNkRVZzRTZzlhQ3ZpaGYvbG8zTXpYcnAwTkdIZ0E3YUpyLzY5K3kz?=
 =?utf-8?B?WlFSTUxYRENydzBldWFPUFdvUFVIT2RIZXVUQ0UrVDRPZXBVMXFMd01IRExZ?=
 =?utf-8?B?d2JOVmNiRGp1ZDUxeUpPa3ErNVRYaU5saUp1MDMvZ2NoU0MwN0dBbzlodTlK?=
 =?utf-8?B?ZmtJMTNiME5tL1NuNlJQUmpvRUM2emdjVkZVRG5rMTl5cVRmK3RscG5Md2lR?=
 =?utf-8?B?N0gveXUxZUo2WGRYbS92ZHp5c3RwVG5vbnV0c3lWMGVCVk51dld6MkVWNXlQ?=
 =?utf-8?B?NDhLYzNwSUtoTTZoMHpkMlBoanE0eUtRR0REdGl1bTZjcW4vM3IrT09WYVJD?=
 =?utf-8?B?a0F5Mytvb1RnSjNjRU8xdXB2c3NLZHg4dEF4djJXVjc3R2dPemM5OXBCOWkv?=
 =?utf-8?B?dE96ZGt4cTRVcXBibWVMY0R2MFlpM3pJWUhLTjR3QW1OWG43bUsvZlFGbVlj?=
 =?utf-8?B?Z0NLWS9tN3RqRVdkc1hiY2hGajVNVk4wOVBPYnYxN0dlUlNIOHZyUWs3K3F0?=
 =?utf-8?B?ZnFNUlhGV0w4STMrdkptamgzV1JFZStkckNISXR5cmJ1YzRFQndIa1Jhak1k?=
 =?utf-8?B?bW9qTVR3cUora2tUVWVmWXRQaXMxdktBQ2h2TzNLaVoxUDFSaG5ocGVub1VE?=
 =?utf-8?B?dWNKeS95TUhpa1YzUkJMa0RwYzdNWjEwb1crcUdwaHdsU2cxdUhaT3gzZGRD?=
 =?utf-8?B?M0ZwOXJiTjM5UWh6Q1UzTEtuaWozZE13THM3NGRkdTIyaFNZZUp4YjA5MVg5?=
 =?utf-8?B?Vjl0RzJrQTBCcGU2TkRZVkJHUEZrL3JOb3dUL0xEcTIrMUtYTVV3WEF1Z3Z0?=
 =?utf-8?B?QWhaLzhTeXhzOENpa0ZBUkJMUmw5ajJjM25NaEowRHZzbnUxUnhIMlhpbzZK?=
 =?utf-8?B?RFh6TXZSYnhERm0zb2o4WEVmVTFtUG9rUyszTHJYOEhCbWt5VUVLZkV5SnVM?=
 =?utf-8?B?UHlGZHlzYzc0d2hGTGZMb3VTZ2VHVTZtczNCMGZiVUMwWjN4emxFcTNGRGNx?=
 =?utf-8?B?QlNPSE52R0ozZWkvei9pMGhmanpPVHNDTEQ1UWZncUQ0VUdLN0tEYlpyU1ZG?=
 =?utf-8?B?VlU2LzJ0WEE5N1JWQXM0UHZCY0hSTmJsSml4dWFuVDZ2T3RzaFU1N0Q5TUhN?=
 =?utf-8?B?U251cUdmbEtxM0JSVkxNZWU2QktYdG4zeDJmMm15MEI0amlVZjFZZjVXSFZS?=
 =?utf-8?B?em50OSs1Y2JNUjBGMDlldnZ2TytiWE8zRlljUUhEUVdNemlLS3lzcVBsc0J0?=
 =?utf-8?B?UzgzRlJsbGh1Z2xZdWN1TkVHbDVzQTJndEs3ajlNNzFtZy9SQWlQblFKdjlD?=
 =?utf-8?B?azdYV0x0RlBBZk9KaVMyOXdta0FaU2dVdk9udzl4SUkxejJwS2xGZWk5SlVs?=
 =?utf-8?B?ekJHa1dGTUpaOVh5TXA2Sk56Q2toeFhZSWJaRTl1SEx4blc4dHVUaDV6MFFM?=
 =?utf-8?B?Y1BRMnA4ODF4RHZNdmY5a09lYVhEVGw0eDJHMjRpNVhBOTRPNUZoTEhsVDl4?=
 =?utf-8?B?aitpN0JaSEdvWHIvMDJXQUV3dlNNblE1UVV5RDQyeWduQ0xLeWpudEVBVlY3?=
 =?utf-8?B?bGU3SGtOcFRSR0lPSlNXRUhNMjJxeE0rVDNlT3UvRTNPbWtOaTZFZ3gySU92?=
 =?utf-8?B?Ni9tY3pEQ1hxdE9yeTBET2RFZlB5MlJZVldrV2tNMVUzZFFUS3N6c3pGRThz?=
 =?utf-8?B?bUY3TVd4QjFtTEdUejFnYkgvYXNxNlVPSmEwci9kSDlaem1RTGhZNVVkYTM1?=
 =?utf-8?B?d3FlMTI0VkxZQkxYcUR5L3FiSmJlYzA1Zzl4ektRMElrQklnaVI5UnVQWWJr?=
 =?utf-8?B?V0xWWFplY2xNMTloY1RPRkROUk1Va2lSczloQ1BERG9lSGF2Vld4azBsSnc1?=
 =?utf-8?B?amhNMWFqYTA4V1Rxb1RKRTJKb1p1Y29JemJPd2h6aEhlajFIVFpjWHpoVEhE?=
 =?utf-8?B?QVZRMFVHdmJQeG0ydDNEYVM5QnZ2NGNkMEhwZGJxalZZbUZ0NzZKdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54bb0b11-ebdb-4dfe-61c6-08da28c9c5e3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 03:47:10.0834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dePC9+LbSm3rY0bKwx/9Hg9UTc6s0nkf1dwt/qTm7sR5h1umH2dLe1rMlVh1py8zjZ22g5+OuVE7SsjMCEkAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204280020
X-Proofpoint-ORIG-GUID: 4cbkzlqvjOpucRMIQCRdaYUv4us0y8YS
X-Proofpoint-GUID: 4cbkzlqvjOpucRMIQCRdaYUv4us0y8YS
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/27/22 7:05 PM, J. Bruce Fields wrote:
> On Wed, Apr 27, 2022 at 01:52:52AM -0700, Dai Ngo wrote:
>> This patch allows expired client with lock state to be in COURTESY
>> state. Lock conflict with COURTESY client is resolved by the fs/lock
>> code using the lm_lock_expirable and lm_expire_lock callback in the
>> struct lock_manager_operations.
>>
>> If conflict client is in COURTESY state, set it to EXPIRABLE and
>> schedule the laundromat to run immediately to expire the client. The
>> callback lm_expire_lock waits for the laundromat to flush its work
>> queue before returning to caller.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 82 +++++++++++++++++++++++++++++++++--------------------
>>   1 file changed, 52 insertions(+), 30 deletions(-)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index 55ecf5da25fe..9b1134d823bb 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5705,11 +5705,31 @@ static void nfsd4_ssc_expire_umount(struct nfsd_net *nn)
>>   }
>>   #endif
>>   
>> +/* Check if any lock belonging to this lockowner has any blockers */
>>   static bool
>> -nfs4_has_any_locks(struct nfs4_client *clp)
>> +nfs4_lockowner_has_blockers(struct nfs4_lockowner *lo)
>> +{
>> +	struct file_lock_context *ctx;
>> +	struct nfs4_ol_stateid *stp;
>> +	struct nfs4_file *nf;
>> +
>> +	list_for_each_entry(stp, &lo->lo_owner.so_stateids, st_perstateowner) {
>> +		nf = stp->st_stid.sc_file;
>> +		ctx = nf->fi_inode->i_flctx;
>> +		if (!ctx)
>> +			continue;
>> +		if (locks_owner_has_blockers(ctx, lo))
>> +			return true;
>> +	}
>> +	return false;
>> +}
>> +
>> +static bool
>> +nfs4_anylock_blockers(struct nfs4_client *clp)
>>   {
>>   	int i;
>>   	struct nfs4_stateowner *so;
>> +	struct nfs4_lockowner *lo;
>>   
>>   	spin_lock(&clp->cl_lock);
>>   	for (i = 0; i < OWNER_HASH_SIZE; i++) {
>> @@ -5717,40 +5737,17 @@ nfs4_has_any_locks(struct nfs4_client *clp)
>>   				so_strhash) {
>>   			if (so->so_is_open_owner)
>>   				continue;
>> -			spin_unlock(&clp->cl_lock);
>> -			return true;
>> +			lo = lockowner(so);
>> +			if (nfs4_lockowner_has_blockers(lo)) {
>> +				spin_unlock(&clp->cl_lock);
>> +				return true;
>> +			}
>>   		}
>>   	}
>>   	spin_unlock(&clp->cl_lock);
>>   	return false;
>>   }
>>   
>> -/*
>> - * place holder for now, no check for lock blockers yet
>> - */
>> -static bool
>> -nfs4_anylock_blockers(struct nfs4_client *clp)
>> -{
>> -	/* not allow locks yet */
>> -	if (nfs4_has_any_locks(clp))
>> -		return true;
>> -	/*
>> -	 * don't want to check for delegation conflict here since
>> -	 * we need the state_lock for it. The laundromat willexpire
>> -	 * COURTESY later when checking for delegation recall timeout.
>> -	 */
>> -	return false;
>> -}
>> -
>> -static bool client_has_state_tmp(struct nfs4_client *clp)
>> -{
>> -	if (((!list_empty(&clp->cl_delegations)) ||
>> -			client_has_openowners(clp)) &&
>> -			list_empty(&clp->async_copies))
>> -		return true;
>> -	return false;
>> -}
>> -
>>   static void
>>   nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   				struct laundry_time *lt)
>> @@ -5767,7 +5764,7 @@ nfs4_get_client_reaplist(struct nfsd_net *nn, struct list_head *reaplist,
>>   			goto exp_client;
>>   		if (!state_expired(lt, clp->cl_time))
>>   			break;
>> -		if (!client_has_state_tmp(clp))
>> +		if (!client_has_state(clp))
>>   			goto exp_client;
>>   		cour = (clp->cl_state == NFSD4_COURTESY);
>>   		if (cour && ktime_get_boottime_seconds() >=
>> @@ -6722,6 +6719,28 @@ nfsd4_lm_put_owner(fl_owner_t owner)
>>   		nfs4_put_stateowner(&lo->lo_owner);
>>   }
>>   
>> +/* return pointer to struct nfs4_client if client is expirable */
>> +static void *
>> +nfsd4_lm_lock_expirable(struct file_lock *cfl)
>> +{
>> +	struct nfs4_lockowner *lo = (struct nfs4_lockowner *)cfl->fl_owner;
>> +	struct nfs4_client *clp = lo->lo_owner.so_client;
>> +
>> +	if (!try_to_expire_client(clp))
>> +		return clp;
>> +	return NULL;
>> +}
>> +
>> +/* schedule laundromat to run immediately and wait for it to complete */
>> +static void
>> +nfsd4_lm_expire_lock(void *data)
>> +{
>> +	struct nfs4_client *clp = (struct nfs4_client *)data;
>> +	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
>> +
>> +	flush_workqueue(laundry_wq);
> Note we don't actually end up using the nfsd_net, or the argument to
> lm_lock_expirable.  This was a mistake in my original sketch.  See
>
> 	https://lore.kernel.org/linux-nfs/20220417190727.GA18120@fieldses.org/
>
> 	"Correction: I forgot that the laundromat is global, not
> 	per-net.  So, we can skip the put_net/get_net.  Also,
> 	lm_lock_expirable can just return bool instead of void *, and
> 	lm_expire_lock needs no arguments."

ok. I'll make the adjustment.

-Dai

>
> --b.
>
>> +}
>> +
>>   static void
>>   nfsd4_lm_notify(struct file_lock *fl)
>>   {
>> @@ -6748,9 +6767,12 @@ nfsd4_lm_notify(struct file_lock *fl)
>>   }
>>   
>>   static const struct lock_manager_operations nfsd_posix_mng_ops  = {
>> +	.lm_mod_owner = THIS_MODULE,
>>   	.lm_notify = nfsd4_lm_notify,
>>   	.lm_get_owner = nfsd4_lm_get_owner,
>>   	.lm_put_owner = nfsd4_lm_put_owner,
>> +	.lm_lock_expirable = nfsd4_lm_lock_expirable,
>> +	.lm_expire_lock = nfsd4_lm_expire_lock,
>>   };
>>   
>>   static inline void
>> -- 
>> 2.9.5
