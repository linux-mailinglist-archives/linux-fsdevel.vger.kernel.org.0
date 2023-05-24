Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB05D70FD2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 19:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEXRtz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236518AbjEXRtv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 13:49:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2201613E;
        Wed, 24 May 2023 10:49:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OHOq0r013442;
        Wed, 24 May 2023 17:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=JMg+Zdizy39Zmtc2cS6TB4dqL/8PObNCVcJpPqBqesw=;
 b=jtnw66eiYExAQcldB9p4YDI1wG3vXPf4j7JFOVdwxjQRMIMeAIxDNSdDqp9Y8wcoukYi
 2eWMcTCkn8ZOIH0lt401qqtrl/k8ueIp/Pz025T/MEy5+kKOzIBsz4awC5zo6lCqfwNg
 gOYTSRCHGDp9m0aDezqBP638bIKtmJjesFN2T/8N28jMaqfNDJ97nhR3PMDpvpbepWR4
 NicpigIDSacdoBgfC+/9++jem64QXxVeCv6lDwuIWvk03UVS03SsCOnjTio41U14TdTK
 Iy6R0jzWNgOxKqIbJI8gmOcOlD9uAx1kGhu8E3+NWVIpaGl/1ti9BgxwX2eRKdfR7xuZ yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qspy102hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:49:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OH3d6R028598;
        Wed, 24 May 2023 17:49:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2stf4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 17:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQOuM+0UUvrjnBF5Gt7QblY2vuQdhJBUNhopU2GwG0MZ5n2YukVQHEYZUFOq01veHDVdnVRvYxn680zLct9vpb7g6XwbkCrHIH/C4QE40RIli/pwMMoOGSySdD3Mo1KGRNpBQV8Igl7Kk9c7FiWp+hT9VDpEE1q1tGMy6lqILSyAz5Y2AsJ9HmxK01BVx0gsUg+lwq3FrdizxgtfoOD7uNWpAdq2ibDV/2hpd6FAndFeD1Gla9wcMmXQ8fMKKIL52LYME+1qPY6Qyl87vowA8DwperWJZNL5cJC1QzGgcUsbWpWaIC+yRl46MLdxWaQT2IbYkycAh2QsRm/34DtLGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMg+Zdizy39Zmtc2cS6TB4dqL/8PObNCVcJpPqBqesw=;
 b=QbTnNIvZKQ52rMWdlDNadsk1S8c47odHx5vz7vCwmGSoP37j+uyYT1aeux68Ij81pkRuuwW4ru8AfVUw48/8B2JKyCqIjIWdshk46wUiOI8c1idcd6Ph8hEk89/6iTeM8JQ+wAMTtOZkvAQN3hXtJPE37ZZpj/dmbM2YBGSuWp951B62HUnUVGJdLOcixoHyzIe8hiKxmyLITgL8o1hmvNMdd+y1ftqY51Q3GLQWEC5rEi/BOCFBPnAUJab8V+ChlsAWdlNP9lWlid6GQnvOKUGHvyBfssCKirQ/JF+Jd4FHRl64hFY/D9FDDFHgvp9Oh6LPhb0BiMPMabx4l0iGow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMg+Zdizy39Zmtc2cS6TB4dqL/8PObNCVcJpPqBqesw=;
 b=jvoh3YHw1UzFlTZmfZWyqUnyod6hyOX2fNXdfRPuiLnn5UGVJrxPR9tjVZdluTcI0KIvFHE0XSiSQbdR6hneU0XxoTQ35XeqG8PjtYrc/Usg1BjkXWdeGYnCx4S+qQ1elo/HLAdDurz1QYveZAOCEztGFkmDja8CUHmL5sS7rkE=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by MN2PR10MB4270.namprd10.prod.outlook.com (2603:10b6:208:1d6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 17:49:37 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::30dd:f82e:6058:a841%7]) with mapi id 15.20.6411.029; Wed, 24 May 2023
 17:49:36 +0000
Message-ID: <58191055-96c8-d693-bbec-2081b1bc5a75@oracle.com>
Date:   Wed, 24 May 2023 10:49:35 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH v5 2/3] NFSD: handle GETATTR conflict with write
 delegation
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com
Cc:     linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <1684799560-31663-1-git-send-email-dai.ngo@oracle.com>
 <1684799560-31663-3-git-send-email-dai.ngo@oracle.com>
 <33ffcd5fd5d794fb642bbabf93f34a61d2f0d4e9.camel@kernel.org>
From:   dai.ngo@oracle.com
In-Reply-To: <33ffcd5fd5d794fb642bbabf93f34a61d2f0d4e9.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0102.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::17) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4257:EE_|MN2PR10MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: c79fc22b-15b4-4448-42c3-08db5c7f3d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3EDMT/B4wf4JM1HH3xlfishowGd55A256cLoptv8CwedG1KiWNCvfaBbkqqfAu80IVcl2Ny8hq3LbGF2LWzwuznZho+d8q4LSVND1gzLZwqEB5s0LNvIEGtqdCV894fusH49yb93XouqAtELhZQWNOVfnOldCR5cife4ffDpyP2IpyMpH4uQzBwhQO0V2dZDO51BsXGQP22kS7BWGAWIuP1C0D0hxwu9D+S7j4i8K8pJqolMOx3R+rcxB0HIW89BWa7NNf4LdKSMx3Ldwtoo/0pYlBqn5uU36T5DSr+kB7Z79b8dXHwB1j0rT1epDpP+zxd52LmFliUS4Xd+brNoAgszzLZy0atScoTDnahtWajDg+OmVAS8/Ff5WVnVDMqeP4JP03incaWSJZDr11hYor1vuI1NKem9pxhAIKKJ9sLKkzbrdiw58DN6JJmzeRgIomDpDXNPVfEfIHNxnkg718PmFykFLprC0R4x1uREuOPxbx65fDCBf1Hm0acWxnEiX2k3zcLy6ZInbaOIZLX0zr3pfaihUH87lFMvJsCbk1vNYxTYNj2Vc+EWkGIvIXHNF/AiMwqIf0u/QMU4I5eb7e6ThnBbYzRuPYDbuebt3THXcTtPA/5E3mP66KXfsrCV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(136003)(396003)(451199021)(41300700001)(66556008)(66476007)(66946007)(2906002)(26005)(186003)(478600001)(4326008)(316002)(6486002)(31686004)(5660300002)(6512007)(8676002)(8936002)(53546011)(9686003)(36756003)(2616005)(6506007)(83380400001)(86362001)(31696002)(38100700002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2NSZzgrRHRLMFk2RHp1MEg1bjNxNmFvU2ZaNEZVeE83VStWVmc1SWpwNXRQ?=
 =?utf-8?B?SEFoUU5qRVlwSFRrL1Z5cE42THFldk52ZUt4ZmhGdXQ2VjgzN25LRkowSHZE?=
 =?utf-8?B?NVFLRHZsUm9raVo5Q05iTmgyNjRtcnhiM3VaM3lTT1FCUmF5QTRSUlY0YTNr?=
 =?utf-8?B?TmUxcXRvOE9MV1p5U3FqNXRmOXIxNUsyQURvalUvUko5SkdmdUw2aWdwNk14?=
 =?utf-8?B?VTBCNUhyTjhxQlRIbnNZNXV0SmVBeUovdWdRR1ZwbWZqRnNIUTZCYWw1cjFy?=
 =?utf-8?B?TG9qQlg1aXg4U081WjhmaU53N2g0NzBMbTl6NHhhcTc3b0JPOW5ZNDRuOG0r?=
 =?utf-8?B?eHZ0aS9MdGtOU0J4ME9kU08zRG9zTDhlZ0pPUDJnbHpYeDN3Rk1GV3lONEkr?=
 =?utf-8?B?M0FoUnNBU2JBb3ZxcVhydHRqVXlrbUZ6NDJ5bWlPYTQ4ckNmbzNuNW5NNE1Q?=
 =?utf-8?B?RmFDb3ArTGJXdUxLckg1ZVdXVjRyOXBxUlhzcm4zUTg5QkJROHM3cGM4NnZn?=
 =?utf-8?B?blFmcWdhUTBpOXVYQS9vKzNsSGFqWHJWNnMxVXZKUlhQQWwrZkE0dTVWS3gr?=
 =?utf-8?B?R2FPNTRMM1doVWpjcTYzdERMeEt0RUswZzg3UE9PQ1FQZnltNjlEQUVCMHh2?=
 =?utf-8?B?Q0ZpNEhKVUp3WFI3TEdrdW5pQVI0S1V0M2FCZFJRUlltY2xuT3RMcmV1Zitj?=
 =?utf-8?B?am1rOG43czNDMVNuRmYzbHZva0ZCTFp4Tzd5U0Q2TlBsN1JUTHF2TnhTK2pQ?=
 =?utf-8?B?U0NpczhPcThLeTgvdlJOY3RnYWZvMFdHbWt5VGNOMmVPTlVBZkx4QmtMYnFo?=
 =?utf-8?B?NEdRcm8yRDdhV0RkSkg2Z0lhNTFpZnYzbHNPbE5kaGRVSlM2VGxEUkVVa2xo?=
 =?utf-8?B?b1RvWnRvSktWZnA3dmQ1MFNRUDNtanFWUUlXN2lHZjQ2eEIyVkI5U3hralYx?=
 =?utf-8?B?YWVzc0t0SFZoM1ZITFpSenNISzg4ZTNPUVh5ZVBxOERLQ28vVEFpbjVSK2tX?=
 =?utf-8?B?eTJhVXFtcGhZQUZad2dOamJheitqSkwzZWRoK0lMWDVSM21ocUV5bGFiZlVq?=
 =?utf-8?B?TVhuR2V1K1JGaktHblQyeUpzMzNOZmJtanN1bXVHMG1DNU1obWxlZDNXRURa?=
 =?utf-8?B?TllIazc1VzdwbW5uTHJ5QWpsdS9iSUI1R0QvY3IrZjEwcDFSUGxaNlpsQUxG?=
 =?utf-8?B?cmltQXBOOWxHd3V1N1lGOVgvaG4yNCs3SXNaVDFCbFoybDVNSjhnbXBhQkxX?=
 =?utf-8?B?Z0puTkhUOFkzYTVac1diSXZLUVV1eTREQ2RKaENYbysvOHFnN20vc3ZxeHE3?=
 =?utf-8?B?Q2M2QnIzRTFHYURqdVJlc1cwdkVxbXZHTHNhU2RaMUpmZVNzZVgrRy9QZUhI?=
 =?utf-8?B?SFVUTk5BUFFxWmIzRmNOWXJhZ2t3WFhIRjFhRHJZcEpuNXc2MjNpUW44MFl3?=
 =?utf-8?B?RW1CODRLelo1eWhtN3pVeW9RdDRNTzZjUTlOR2lYcHFDMFIrOVZQQXh3TTFr?=
 =?utf-8?B?dGVZZVlBQ1piU2VVL0pLTTl4cjFoS2JYdytQMFZ5NFNwSTBYVjdPTkIrN2o5?=
 =?utf-8?B?RVJid1dUbDJVdUtCVnUwRUVRSTcrc3BKdmtMSTIyaUR2RE5mYnkwemJZQzdE?=
 =?utf-8?B?dUVXVC9pS25UaDNZRndKK1NvMFA5T29SQ2wyUEoxUU55d1NINUU5YXV3SFdG?=
 =?utf-8?B?QU52TDlBSXh1N3RUbW15WGRxSnViM1JmdUpnTVJCWXV2SU9xRGNha3JDTXli?=
 =?utf-8?B?ZzZWZ3RUTDM2SU5IRFVta2ppcG80WE5HcW9ORnR4WWZXdlNEZ0NVTUJBSVp3?=
 =?utf-8?B?dGpVeExNTUhyS1V0aDl6U1ZISXcxUjBNTm80NmVabkhJQmF3ZWNtZFd5QUZ2?=
 =?utf-8?B?akhuWnlCbTJvTUc2cWtxTHJ6N0haV0F3Rkg4MjFKVGNidW0yZXNnRENISHZE?=
 =?utf-8?B?ZXZGdkZNZ3FRMmJCYTBDSXRoU0Q5R1VrSTZaM1YzcHhydnJoWnZTNXJHUVIy?=
 =?utf-8?B?b3UyZEZDQ2dPZmZJMXUvejRLMnF5N0xJd2c5aWlkZFNxeTBHL2xJVkhWSnhR?=
 =?utf-8?B?cTFnYXBMVkExdGNKN25vR2ovWjdQWGJoZGxuUjVrVkQ3YXI0TmNOOWRpRm1n?=
 =?utf-8?Q?bo3raS0qM3OwYypeoYhg6VPeo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CYKdGSHKD42Hs4DTulPsVV2eWR6k85m9L7ypBev6iITGqx7ckSLLIf6EeadGZpemED9Hh3/MXD+uqCjfXXiUWgCuzLbylJ4OBQSFy3nbi18N8XsE9dcWWn0rYxjRrEVX2Mk2p+gy9OGR0ofOaEVT3T4m85TrWQgGRK0/rfGnTMyYQ79l1+9Kh/wysOIEl/8tauqjKrbG5fnBS9HLtUJv+6DgXONAQbUO9THBrZXFaJgqIrkChIY3v8m535T88khzZa8LIV6aFgtLDmRnrNa3wy0NZD9zV20dKqmFobzRV1BJSun/NVUK6GvZm/l+aRc23p4KqcXg172nbL5oeStn5dhpdcA6H3VjHWhjeFDn3a+YJffzzgcVGVpeinJtbKkVsAYSfuBVpV9oQmPmPx9Rv2QjQGbg6LdZOZ0225LbhSCaBMRrnorNrHhkTnYS2QY2NEzqiFSUN6x1QSWVCnd8oa0IYOTbHtonZ4TPxxzJUpL8pkzlJLF4SSdPImmYMV070epAACc0H0ExeFr0164AeDaOs2TV+lD2T+Fs735D/miAfqFaMfzVYUVWuZA8cTzdqpIymn15TZP3TF+bqDraaVUU8xFE83+Si+bsKe2BslEC5ElTTS6EgV/03Pfb0974sQvr5c/FjOCf74Jlp19xA1EWydu0/qcoy/UgPDp5bcqglz3pifwyWxqaG5neVgSvxOXERyF8mZtZyML8w9AFkD2mph/WxMFb7cfhTtIN18423vq+h6DIU5sGCOLk3dCTCx60n1dSepWdLFKAGYx+yRwk/yJxnL5SBTPIwU6sgB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c79fc22b-15b4-4448-42c3-08db5c7f3d8a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 17:49:36.8315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0k1Shr69IHPuVMd9HVbKbHqC6HRwbGW9gRTUBz1dWnYHXzLTicGUje+lvf2UQl80NsgBiffiisweavbglOCUbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4270
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_13,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240147
X-Proofpoint-GUID: AcyeXy01rEpz6_zk6hEh8mXXA7XA6Wp2
X-Proofpoint-ORIG-GUID: AcyeXy01rEpz6_zk6hEh8mXXA7XA6Wp2
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 5/24/23 8:07 AM, Jeff Layton wrote:
> On Mon, 2023-05-22 at 16:52 -0700, Dai Ngo wrote:
>> If the GETATTR request on a file that has write delegation in effect
>> and the request attributes include the change info and size attribute
>> then the write delegation is recalled and NFS4ERR_DELAY is returned
>> for the GETATTR.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   fs/nfsd/nfs4state.c | 37 +++++++++++++++++++++++++++++++++++++
>>   fs/nfsd/nfs4xdr.c   |  5 +++++
>>   fs/nfsd/state.h     |  3 +++
>>   3 files changed, 45 insertions(+)
>>
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index b90b74a5e66e..ea9cd781db5f 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -8353,3 +8353,40 @@ nfsd4_get_writestateid(struct nfsd4_compound_state *cstate,
>>   {
>>   	get_stateid(cstate, &u->write.wr_stateid);
>>   }
>> +
>> +__be32
>> +nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp, struct inode *inode)
>> +{
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
>> +			/*
>> +			 * increment the sc_count to prevent the delegation to
>> +			 * be freed while sending the CB_RECALL. The refcount is
>> +			 * decremented by nfs4_put_stid in nfsd4_cb_recall_release
>> +			 * after the request was sent.
>> +			 */
>> +			if (dp->dl_recall.cb_clp == *(rqstp->rq_lease_breaker) ||
>> +					!refcount_inc_not_zero(&dp->dl_stid.sc_count)) {
> I still don't get why you're incrementing the refcount of this stateid.
> At this point, you know that this stateid is owned by a different client
> altogether,  and breaking its lease doesn't require a reference to the
> stateid.

You're right, the intention was to make sure the delegation does not go
away when the recall is being sent. However, this was already done in
nfsd_break_one_deleg where the sc_count is incremented. Incrementing the
sc_count refcount would be needed here if we do the CB_GETATTR. I'll remove
this in next version.

But should we drop the this patch altogether? since there is no value in
recall the write delegation when there is an GETATTR from another client
as I mentioned in the previous email.

-Dai

>
> I think this will cause a refcount leak.
>
>> +				spin_unlock(&ctx->flc_lock);
>> +				return 0;
>> +			}
>> +			spin_unlock(&ctx->flc_lock);
>> +			return nfserrno(nfsd_open_break_lease(inode, NFSD_MAY_READ));
>> +		}
>> +		break;
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	return 0;
>> +}
>> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
>> index 76db2fe29624..ed09b575afac 100644
>> --- a/fs/nfsd/nfs4xdr.c
>> +++ b/fs/nfsd/nfs4xdr.c
>> @@ -2966,6 +2966,11 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
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
>> diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
>> index d49d3060ed4f..64727a39f0db 100644
>> --- a/fs/nfsd/state.h
>> +++ b/fs/nfsd/state.h
>> @@ -732,4 +732,7 @@ static inline bool try_to_expire_client(struct nfs4_client *clp)
>>   	cmpxchg(&clp->cl_state, NFSD4_COURTESY, NFSD4_EXPIRABLE);
>>   	return clp->cl_state == NFSD4_EXPIRABLE;
>>   }
>> +
>> +extern __be32 nfs4_handle_wrdeleg_conflict(struct svc_rqst *rqstp,
>> +				struct inode *inode);
>>   #endif   /* NFSD4_STATE_H */
