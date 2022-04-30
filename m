Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F339F5160E1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 May 2022 00:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiD3W6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Apr 2022 18:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiD3W6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Apr 2022 18:58:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691D4B6F;
        Sat, 30 Apr 2022 15:54:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23UBDStq029440;
        Sat, 30 Apr 2022 22:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LSad2LC2IJveSN8B6zml9UEJ4TMp216l03MzdFpomTE=;
 b=G4wx2sUL0lQJbcO7gI3YyZnd0McTSVN+nCND3/1RUs1ITb6Eu5x7ci6GcUGr8Ae0jeff
 HsO0VitKRrWBRGgK9h1uklH0mYt/0XrABdHDdmc7zqWhlBZmTJtxdQ7Bl4NgEiK+jIag
 dqs/hlJ9f2IMZKgf9NVN8lKZnj+VgeGGj26KZZDZk0nRtpCmnQHfuGeQZJZK2kE+u7j3
 7XuBD7uNFAk+pquu8/SNOdL4K73Rl/EXvG1bVsbgwM61NCxXyiPKuG6X3XxcKR9p8CSS
 2jkGn3PYPFxMlVu5JKw98JBLWg3uLgvnlhilYO204xYVgAqkKQa0Jsq6girkgNpbts5O +A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq08wv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Apr 2022 22:54:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23UMom6l022039;
        Sat, 30 Apr 2022 22:54:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj6g91q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 30 Apr 2022 22:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcemXqI62F3IZmjnmVzNFymLNd3J9m60P6qVxm2rLGj71YRSFf73sZ81cBYubI/H3vBfnOWiHImfV1dIXRIUDoP8Eh0wtA9X+cLtgi/k72E0OL+ED4z/dtwGX5bteyONHYjTNTuwTz6hiuCoTukSByJmLMmhEF5ynlSLziPt9XXlGQWAAeNKdIBciWuttnZZMQC3ESpS9K4yykJJ+ZqMBgDaeqm6J0m1nIwDHj36tD0dhlde056wVBcw85JXa2enELrEIce+Jh15Acr95M40oB/2q6gGAvWN5JoPu0t7K22t8F/JI+2+qCcWi5DqOblh1gqVFQKFlJjJohiMn8kWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSad2LC2IJveSN8B6zml9UEJ4TMp216l03MzdFpomTE=;
 b=YdOT74YZ/wjGl1NwzqMIw5T3ogKmoyS7nTgUB3qfTAn1Z6FuZUO5mXY6ZjE65rMlvWN14KemfHlNnVRPOV3pVwGaZNYaowSt9SAoXlayifE8ONcq10NqPfBydFMG1c5bYXqbnOK45/5SmiCO5x1oFJXwhW0Su4ddWAEKES1FkiG39ti8TOwiAwrkkgp8+mM1gKui6Gaq4AprAAfm1pHnFl+rzASUlBoHnWv68aj4lKUHLrL4VqtwzjKmXjAS0kReJ5xyy56YNLfUomVG9uWfbd3n7NBaHLdA7QAyeSYW2RDmYmjbhSD+s80lWBiEQ581tl2WZWe6+nHHf4CdIk0vMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSad2LC2IJveSN8B6zml9UEJ4TMp216l03MzdFpomTE=;
 b=XyfE/Zty1fkDUQ8KNlheeyZUOSug3giT8fXjBngO0879G7wd1RZXNQe4aho3NAd7wci9LtBsH+jPT/WGHkJa/uY8HxZ1nB9amRvynwZemD0xyM2AEbVAeWU0zD1k/SBAt+xQBbrDVCTqYJsro2XySVVbLz8uqieiZVtiLQ6jiBs=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by BN6PR10MB2018.namprd10.prod.outlook.com (2603:10b6:404:103::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sat, 30 Apr
 2022 22:54:41 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Sat, 30 Apr 2022
 22:54:41 +0000
Message-ID: <3300ec98-060f-6cbc-504c-981087ea3258@oracle.com>
Date:   Sat, 30 Apr 2022 15:54:39 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v23 5/7] fs/lock: add 2 callbacks to
 lock_manager_operations to resolve conflict
Content-Language: en-US
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     chuck.lever@oracle.com, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <1651129595-6904-1-git-send-email-dai.ngo@oracle.com>
 <1651129595-6904-6-git-send-email-dai.ngo@oracle.com>
 <20220429151618.GF7107@fieldses.org>
 <862e6f3c-fb59-33e0-a6ea-7a67c93cfb20@oracle.com>
 <20220429195819.GI7107@fieldses.org> <20220430011826.GA14842@fieldses.org>
From:   dai.ngo@oracle.com
In-Reply-To: <20220430011826.GA14842@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0248.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::13) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccba6273-8b84-4020-3e32-08da2afc6922
X-MS-TrafficTypeDiagnostic: BN6PR10MB2018:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB2018215CBE891E305E01400F87FF9@BN6PR10MB2018.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyTKBSyCoSzeidnvw+E0lvG75EJe1N5Tk8vFFSPwg95yoI85ahN8qHwl2VFRpRuHDOOccV4xjJGj+lLUAzqCphKvwBSnNoDKatXz2p5m6Q0fgKtEowi3biumg9+o7duwOfKWOQZPVTnFKHtCQrGKE5d+4fC7JyktkRb8SPObf1rq1wwWnOWtba7njX/YmUveYf7B13QP0QSrI4oy1MhIb37usQLNNWL4w+40R3zP0YhLyrWnVnOWU1+TCcUmSLoG0B36usAYOaRKj5LXUMqo88xSn2mQaRA3ZOyVoTlI7RPT4cOgVheHE5IWCpTWcK1stCo+rM/AJMTqO0deOvovw5bwknQfNxCxslvsi2sR9qVWe3y85F++rmgHwsL3okM6te+ghUrtZbcUT7Z/LTZmK7h05ltl4azVB3s5fWE3AmU83w0QcjKLWj8nEyrJma4sJv5oSFp1DwM/90Lva7V+ZuKGqFjc5HBWa7z2dbfSIUpDxzSQDfEbM0hKCae2tub6GIJVtQ4bs8Bcj6Qu+uCqPpGoPQVzlgzbJzJYpM4h078mKHFBf39MUutcD9S9MfDshOWOkdkQyL7sUwY5XEciRtVfUXyab8W6uVBspN3S34Cv/Ea39gQJOjTG2+kvJvDQ7HoLWUjqR0M9B1QvWv0LjR0bQzLIPaNx2aRM2VVbGu/hoXKBjPTb6Kyv21WmtZ3Z05fDPN/kD2Kxw1+vccKg4K4+UaeiZAuOs2MRSiG49HLEMmYvnpa+6JNZXkJcyM3RUxlyFiaHCYIKS/c0pCMxwt1SoX1WOB7+UTYb2upO6Wo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(9686003)(6486002)(966005)(6506007)(30864003)(8676002)(4326008)(6512007)(6916009)(508600001)(86362001)(316002)(26005)(36756003)(2616005)(2906002)(31696002)(83380400001)(31686004)(66556008)(66476007)(5660300002)(66946007)(8936002)(38100700002)(186003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0dRcHREd1JjNnlzNXpoUEFzTWV6cmFJUTlKQXlOZmdVMWxCMWpnNUNibnB2?=
 =?utf-8?B?SHFhZmwvSFFpVlhTUW43K0FaSFhDZDFPOXJpMGdWc0k5ZjF6RUlHYlQwOGNL?=
 =?utf-8?B?dkJBS25CTzlxMy9VcHhsdWJMT3lJajRMR0hLQ3R1YVZsUmJTMGV1M1B2ZThm?=
 =?utf-8?B?Z3p6V2M3QlFEd0xkK0U2Q0Nha0VXeU9RNUtiOUtqTCtnQmRJQ2hGbjNDNGtL?=
 =?utf-8?B?YkZqRW5wSGpYK3dma05rRE5MUXgyYit6S2pGUU9BcUhLTlFwR1BZbnZDNUV1?=
 =?utf-8?B?NkQxQzR5Mzd4L29DVlFpcnNwZUJaeDh4QmVJTHUwbURmcWFScWdTMGxIRDBr?=
 =?utf-8?B?Tkgyc0Z1cjVBd2o4Y2F1ZnlEaXNreVBCdFZVN0RHcXNGYkFKdFNFeW5IMUNp?=
 =?utf-8?B?cWRFTEN5dmlCYnp1clJrcnU4V2VtTW9mWjlRK0NBYVdodGNyeHBtSWVvWHdF?=
 =?utf-8?B?VmxTQlEvc09Jb1JIdDQ4OGgzUmtwalNoVFRlTnQ1ajVXVVVwNnZKR2lUR2k4?=
 =?utf-8?B?bkptWEs1THNHbGNYUXFBLzU5dnFLQ3RDc2wxank1MlpUMVFNeXVCTUVadEZV?=
 =?utf-8?B?NmljeTZHaGpLVjJkK2hrQmJKeDVaY0EwdmZLMENPazlJblNFSlBLVW00dlVv?=
 =?utf-8?B?THRIcFdHcTJ1OVIxQ1RTWWRDY1NxTXFhQzArRHhvcGNVY3U1YThGMjhHSHNT?=
 =?utf-8?B?VXFRWWkyaUNQdmRSTVNFeENlNHcrbnVxbVdMTlFBNFVWclROVU8xV28rbm5F?=
 =?utf-8?B?STZlZHZYdlQ5RzZuY29GSEZ2Q094R3oxSFMxZ2l4QlU2anhjeXRHUUYycURt?=
 =?utf-8?B?YUROWVFQNnZmdXppNjRMNnVGRjh2dTR0SHR2N0VNcDV5akhvZXJrZFVZcFJN?=
 =?utf-8?B?N1NZMkNpMG5sZTQ4aGUwMFF1ZEV0TlJqdFUxOEJRL25QZmRsYVJrZm11WnFD?=
 =?utf-8?B?SUVucXJjcG9zRDNzbUFNYlA2Y0haMUNydEFaZkQ0UXo2VXFCNEhoQ0cwQ3py?=
 =?utf-8?B?ZkZ1Zi9zMFh1dXJ4d0MrQjRYMWs5SHlVaERqb3B1L2x5SEtuTklTZXJDWEd3?=
 =?utf-8?B?YnRQZHh2dzg2UWt2Q09HdUkvKzdDYys3M00wNDRQTUZYWWpGWEFqMVViSlNO?=
 =?utf-8?B?NjU3b2JRbGhVNGp2UWFZOHQrZlo1UUEyTzh4TXJVOEpJUjIzcFgyQUhOUlFD?=
 =?utf-8?B?NFBLaStJa2dxY1lvaThXVVEvMUtMbXg5c2lRZzYvMjlCWHdkZTBlem1RbGhk?=
 =?utf-8?B?RVdaNEttTUlXRlNmRjU5dGNaN2xxcEFHSmJMTVQvb0hPTFNjZTkzdGZ6SDJB?=
 =?utf-8?B?Ry9RQ2k5cGF5ZEVPQnduNDRSRHFtaWtRYmNJQ0JCdVNvUnBWR1A1Uk5CWmNx?=
 =?utf-8?B?VE9rN2FncTFqdFF3NnowWnJSODRSUW5OcWRWUk9lclFKOFpMRXZiZzlmZTRo?=
 =?utf-8?B?VTRrYndUTTVRWmNVbHRmbWxVb2VrR0tYWWp5RWNaZ0l4d0lsSTRzNlBOdUpi?=
 =?utf-8?B?OEwrZTc2V2dRQXNuZHc4ODdvRndqWW11b2R1ZG1jUWhJdVYrdHl6QXJVQTFJ?=
 =?utf-8?B?YkNaUzN1TGxPa2I4Wk9ROFVhVDNTMUd4MlNmMTZCS1JjZUtsMnZqdEFROWhs?=
 =?utf-8?B?Sy9MeEdVeUptMEsyK1dUME9PWExRVjhSZVhWeUZvWXpBdHJrekpvcGViZjNI?=
 =?utf-8?B?Q3RweExna0NjVVkvb2E4MXlaWjBMSGJYdFdhdWRuRjdUYVRLcFl6dGJHRGYx?=
 =?utf-8?B?SDc1UzNtRlJGMnUwdG9BZkNxRlBETEFyZUp5QW0vTkdMcU1OS2V4RTFOSm1C?=
 =?utf-8?B?Y2pNYmxVRGRES0l4ZEgzRWxIRmpObjJLWVpqL2p6TkZDUjlPaU5ab3BCUmVr?=
 =?utf-8?B?Y3k5emg3em5RMlg5V3BBMUVSR2Rld2FBV3dNenNpNkdoQjNlUmszSkZBaHB6?=
 =?utf-8?B?Qm45Y2tsNzRTRyswWFpqbVdqMTBnRDFRVlkrUG92MHZFYUJrMjN5MzBtRjBV?=
 =?utf-8?B?Uk9VSktCQjBuOVVBbTB0b2drdG5kS3RaU0pqQlVKK3p0bXJPSlp1ejRQanFr?=
 =?utf-8?B?YXlQN1A0RldIZEtOU2MxNFVoaDhFc3ZwSW5QVW1mTytlZXJ0Mld1T2wrc0dY?=
 =?utf-8?B?T3ZydkEra0lrZXBUbTVQUi9Fb2RuWjlBL2Rwbjd2YXBsNWpSMWdtZDdyRit2?=
 =?utf-8?B?MVJHVWlpNVV4Q1NTbmd2elcwd0x1c0RqR3g1a3BTKzJZNHl5S1JmK0N1QzBo?=
 =?utf-8?B?ajRhS3VQalI0dUoxQ29Kc1pvcHdYWHFweFU2WUxXQzBaQlZwOWwzQ3Vya2Zk?=
 =?utf-8?B?dGtJSCs4cHZ0MDFCcmFzdndUL0R5V3hzaDN1MmhZSjZnTVpXdldLdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccba6273-8b84-4020-3e32-08da2afc6922
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2022 22:54:41.1742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZrSaxy9rf60XpDhpo2dERSXQjKJZB4grLcZj/tKPjIvx3z3yTePENdGAKm7Mmx+I5bsxR//7K0oY3Xob9CR2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2018
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-30_08:2022-04-28,2022-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204300180
X-Proofpoint-ORIG-GUID: oxfOnCKPQk5wTy27qIf7AODui_G9eFy0
X-Proofpoint-GUID: oxfOnCKPQk5wTy27qIf7AODui_G9eFy0
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/29/22 6:18 PM, J. Bruce Fields wrote:
> On Fri, Apr 29, 2022 at 03:58:19PM -0400, J. Bruce Fields wrote:
>> On Fri, Apr 29, 2022 at 10:24:11AM -0700, dai.ngo@oracle.com wrote:
>>> On 4/29/22 8:16 AM, J. Bruce Fields wrote:
>>>> On Thu, Apr 28, 2022 at 12:06:33AM -0700, Dai Ngo wrote:
>>>>> Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
>>>>> lock_manager_operations to allow the lock manager to take appropriate
>>>>> action to resolve the lock conflict if possible.
>>>>>
>>>>> A new field, lm_mod_owner, is also added to lock_manager_operations.
>>>>> The lm_mod_owner is used by the fs/lock code to make sure the lock
>>>>> manager module such as nfsd, is not freed while lock conflict is being
>>>>> resolved.
>>>>>
>>>>> lm_lock_expirable checks and returns true to indicate that the lock
>>>>> conflict can be resolved else return false. This callback must be
>>>>> called with the flc_lock held so it can not block.
>>>>>
>>>>> lm_expire_lock is called to resolve the lock conflict if the returned
>>>>> value from lm_lock_expirable is true. This callback is called without
>>>>> the flc_lock held since it's allowed to block. Upon returning from
>>>>> this callback, the lock conflict should be resolved and the caller is
>>>>> expected to restart the conflict check from the beginnning of the list.
>>>>>
>>>>> Lock manager, such as NFSv4 courteous server, uses this callback to
>>>>> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
>>>>> (client that has expired but allowed to maintains its states) that owns
>>>>> the lock.
>>>>>
>>>>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>>>>> ---
>>>>>   Documentation/filesystems/locking.rst |  4 ++++
>>>>>   fs/locks.c                            | 45 +++++++++++++++++++++++++++++++----
>>>>>   include/linux/fs.h                    |  3 +++
>>>>>   3 files changed, 48 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>>>>> index c26d854275a0..0997a258361a 100644
>>>>> --- a/Documentation/filesystems/locking.rst
>>>>> +++ b/Documentation/filesystems/locking.rst
>>>>> @@ -428,6 +428,8 @@ prototypes::
>>>>>   	void (*lm_break)(struct file_lock *); /* break_lease callback */
>>>>>   	int (*lm_change)(struct file_lock **, int);
>>>>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>>>>> +        bool (*lm_lock_expirable)(struct file_lock *);
>>>>> +        void (*lm_expire_lock)(void);
>>>>>   locking rules:
>>>>> @@ -439,6 +441,8 @@ lm_grant:		no		no			no
>>>>>   lm_break:		yes		no			no
>>>>>   lm_change		yes		no			no
>>>>>   lm_breaker_owns_lease:	yes     	no			no
>>>>> +lm_lock_expirable	yes		no			no
>>>>> +lm_expire_lock		no		no			yes
>>>>>   ======================	=============	=================	=========
>>>>>   buffer_head
>>>>> diff --git a/fs/locks.c b/fs/locks.c
>>>>> index c369841ef7d1..d48c3f455657 100644
>>>>> --- a/fs/locks.c
>>>>> +++ b/fs/locks.c
>>>>> @@ -896,6 +896,37 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
>>>>>   	return locks_conflict(caller_fl, sys_fl);
>>>>>   }
>>>>> +static bool
>>>>> +resolve_lock_conflict_locked(struct file_lock_context *ctx,
>>>>> +			struct file_lock *cfl, bool rwsem)
>>>>> +{
>>>>> +	void *owner;
>>>>> +	bool ret;
>>>>> +	void (*func)(void);
>>>>> +
>>>>> +	if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable &&
>>>>> +				cfl->fl_lmops->lm_expire_lock) {
>>>>> +		ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
>>>>> +		if (!ret)
>>>>> +			return false;
>>>>> +		owner = cfl->fl_lmops->lm_mod_owner;
>>>>> +		if (!owner)
>>>>> +			return false;
>>>>> +		func = cfl->fl_lmops->lm_expire_lock;
>>>>> +		__module_get(owner);
>>>>> +		if (rwsem)
>>>>> +			percpu_up_read(&file_rwsem);
>>>>> +		spin_unlock(&ctx->flc_lock);
>>>> Dropping and reacquiring locks inside a function like this makes me
>>>> nervous.  It means it's not obvious in the caller that the lock isn't
>>>> held throughout.
>>>>
>>>> I know it's more verbose, but let's just open-code this logic in the
>>>> callers.
>>> fix in v24.
>>>
>>>> (And, thanks for catching the test_lock case, I'd forgotten it.)
>>>>
>>>> Also: do we *really* need to drop the file_rwsem?  Were you seeing it
>>>> that cause problems?  The only possible conflict is with someone trying
>>>> to read /proc/locks, and I'm surprised that it'd be a problem to let
>>>> them wait here.
>>> Yes, apparently file_rwsem is used when the laundromat expires the
>>> COURTESY client client and causes deadlock.
>> It's taken, but only for read.  I'm rather surprised that would cause a
>> deadlock.  Do you have any kind of trace showing what happened?
>>
>> Oh well, it's not a big deal to just open code this and set the "retry:"
>> before both lock acquisitions, that's probably best in fact.  I'm just
>> curious.
> I remember running across this:
>
> 	https://lore.kernel.org/linux-nfs/20210927201433.GA1704@fieldses.org/
>
> though that didn't involve the laundromat.  Were you seeing an actual
> deadlock with these new patches?  Or a lockdep warning like that one?

Here is the stack traces of the deadlock with the latest patches that
do not release file_rwsem before calling flush_workqueue:

Apr 30 15:12:15 nfsvmf24 kernel:
Apr 30 15:12:15 nfsvmf24 kernel: ======================================================
Apr 30 15:12:15 nfsvmf24 kernel: WARNING: possible circular locking dependency detected
Apr 30 15:12:15 nfsvmf24 kernel: 5.18.0-rc4_bf1+ #1 Not tainted
Apr 30 15:12:15 nfsvmf24 kernel: ------------------------------------------------------
Apr 30 15:12:15 nfsvmf24 kernel: kworker/u2:6/9099 is trying to acquire lock:
Apr 30 15:12:15 nfsvmf24 kernel: ffffffff991a8a50 (file_rwsem){.+.+}-{0:0}, at: locks_remove_posix+0x1af/0x3b0
Apr 30 15:12:15 nfsvmf24 kernel: #012but task is already holding lock:
Apr 30 15:12:15 nfsvmf24 kernel: ffff888115e37de0 ((work_completion)(&(&nn->laundromat_work)->work)){+.+.}-{0:0}, at: process_one_work+0x72d/0x12f0
Apr 30 15:12:15 nfsvmf24 kernel: #012which lock already depends on the new lock.
Apr 30 15:12:15 nfsvmf24 kernel: #012the existing dependency chain (in reverse order) is:
Apr 30 15:12:15 nfsvmf24 kernel: #012-> #2 ((work_completion)(&(&nn->laundromat_work)->work)){+.+.}-{0:0}:
Apr 30 15:12:15 nfsvmf24 kernel:       process_one_work+0x77f/0x12f0
Apr 30 15:12:15 nfsvmf24 kernel:       worker_thread+0x55d/0xe80
Apr 30 15:12:15 nfsvmf24 kernel:       kthread+0x29f/0x340
Apr 30 15:12:15 nfsvmf24 kernel:       ret_from_fork+0x22/0x30
Apr 30 15:12:15 nfsvmf24 kernel: #012-> #1 ((wq_completion)nfsd4){+.+.}-{0:0}:
Apr 30 15:12:15 nfsvmf24 kernel:       flush_workqueue+0xf2/0x1350
Apr 30 15:12:15 nfsvmf24 kernel:       posix_lock_inode+0x13b5/0x15e0
Apr 30 15:12:15 nfsvmf24 kernel:       nfsd4_lock+0xf28/0x3de0 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       nfsd4_proc_compound+0xd15/0x25a0 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       nfsd_dispatch+0x4ed/0xc30 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       svc_process_common+0xd8e/0x1b20 [sunrpc]
Apr 30 15:12:15 nfsvmf24 kernel:       svc_process+0x361/0x4f0 [sunrpc]
Apr 30 15:12:15 nfsvmf24 kernel:       nfsd+0x2d6/0x570 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       kthread+0x29f/0x340
Apr 30 15:12:15 nfsvmf24 kernel:       ret_from_fork+0x22/0x30
Apr 30 15:12:15 nfsvmf24 kernel: #012-> #0 (file_rwsem){.+.+}-{0:0}:
Apr 30 15:12:15 nfsvmf24 kernel:       __lock_acquire+0x318d/0x7830
Apr 30 15:12:15 nfsvmf24 kernel:       lock_acquire+0x1b0/0x490
Apr 30 15:12:15 nfsvmf24 kernel:       posix_lock_inode+0x136/0x15e0
Apr 30 15:12:15 nfsvmf24 kernel:       locks_remove_posix+0x1af/0x3b0
Apr 30 15:12:15 nfsvmf24 kernel:       filp_close+0xe7/0x120
Apr 30 15:12:15 nfsvmf24 kernel:       nfs4_free_lock_stateid+0xc0/0x100 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       free_ol_stateid_reaplist+0x131/0x210 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       release_openowner+0xf7/0x160 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       __destroy_client+0x3cc/0x740 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       laundromat_main+0x483/0x1cd0 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel:       process_one_work+0x7f6/0x12f0
Apr 30 15:12:15 nfsvmf24 kernel:       worker_thread+0x55d/0xe80
Apr 30 15:12:15 nfsvmf24 kernel:       kthread+0x29f/0x340
Apr 30 15:12:15 nfsvmf24 kernel:       ret_from_fork+0x22/0x30
Apr 30 15:12:15 nfsvmf24 kernel: #012other info that might help us debug this:
Apr 30 15:12:15 nfsvmf24 kernel: Chain exists of:#012  file_rwsem --> (wq_completion)nfsd4 --> (work_completion)(&(&nn->laundromat_work)->work)
Apr 30 15:12:15 nfsvmf24 kernel: Possible unsafe locking scenario:
Apr 30 15:12:15 nfsvmf24 kernel:       CPU0                    CPU1
Apr 30 15:12:15 nfsvmf24 kernel:       ----                    ----
Apr 30 15:12:15 nfsvmf24 kernel:  lock((work_completion)(&(&nn->laundromat_work)->work));
Apr 30 15:12:15 nfsvmf24 kernel:                               lock((wq_completion)nfsd4);
Apr 30 15:12:15 nfsvmf24 kernel:                               lock((work_completion)(&(&nn->laundromat_work)->work));
Apr 30 15:12:15 nfsvmf24 kernel:  lock(file_rwsem);
Apr 30 15:12:15 nfsvmf24 kernel: #012 *** DEADLOCK ***
Apr 30 15:12:15 nfsvmf24 kernel: 2 locks held by kworker/u2:6/9099:
Apr 30 15:12:15 nfsvmf24 kernel: #0: ffff888108cc6938 ((wq_completion)nfsd4){+.+.}-{0:0}, at: process_one_work+0x6ff/0x12f0
Apr 30 15:12:15 nfsvmf24 kernel: #1: ffff888115e37de0 ((work_completion)(&(&nn->laundromat_work)->work)){+.+.}-{0:0}, at: process_one_work+0x72d/0x12f0
Apr 30 15:12:15 nfsvmf24 kernel: #012stack backtrace:
Apr 30 15:12:15 nfsvmf24 kernel: CPU: 0 PID: 9099 Comm: kworker/u2:6 Kdump: loaded Not tainted 5.18.0-rc4_bf1+ #1
Apr 30 15:12:15 nfsvmf24 kernel: Hardware name: innotek GmbH VirtualBox/VirtualBox, BIOS VirtualBox 12/01/2006
Apr 30 15:12:15 nfsvmf24 kernel: Workqueue: nfsd4 laundromat_main [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel: Call Trace:
Apr 30 15:12:15 nfsvmf24 kernel: <TASK>
Apr 30 15:12:15 nfsvmf24 kernel: dump_stack_lvl+0x57/0x7d
Apr 30 15:12:15 nfsvmf24 kernel: check_noncircular+0x262/0x300
Apr 30 15:12:15 nfsvmf24 kernel: __lock_acquire+0x318d/0x7830
Apr 30 15:12:15 nfsvmf24 kernel: lock_acquire+0x1b0/0x490
Apr 30 15:12:15 nfsvmf24 kernel: posix_lock_inode+0x136/0x15e0
Apr 30 15:12:15 nfsvmf24 kernel: locks_remove_posix+0x1af/0x3b0
Apr 30 15:12:15 nfsvmf24 kernel: filp_close+0xe7/0x120
Apr 30 15:12:15 nfsvmf24 kernel: nfs4_free_lock_stateid+0xc0/0x100 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel: free_ol_stateid_reaplist+0x131/0x210 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel: release_openowner+0xf7/0x160 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel: __destroy_client+0x3cc/0x740 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel: laundromat_main+0x483/0x1cd0 [nfsd]
Apr 30 15:12:15 nfsvmf24 kernel: process_one_work+0x7f6/0x12f0
Apr 30 15:12:15 nfsvmf24 kernel: worker_thread+0x55d/0xe80
Apr 30 15:12:15 nfsvmf24 kernel: kthread+0x29f/0x340
Apr 30 15:12:15 nfsvmf24 kernel: ret_from_fork+0x22/0x30
Apr 30 15:12:15 nfsvmf24 kernel: </TASK>


I think the problem is lock ordering of file_rwsem and a lock in the
work queue (not sure which one). The posix_lock_inode thread acquires
file_rwsem and the lock in the work queue. The laundromat thread
acquires the lock in the work queue then try to acquire file_rwsem in
locks_remove_posix.

-Dai

>
> --b.
