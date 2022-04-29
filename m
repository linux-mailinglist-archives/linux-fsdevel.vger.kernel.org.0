Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57AF5151C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Apr 2022 19:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349314AbiD2R1r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Apr 2022 13:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235805AbiD2R1p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Apr 2022 13:27:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C033A562C3;
        Fri, 29 Apr 2022 10:24:25 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23TEDjTf032133;
        Fri, 29 Apr 2022 17:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Z1cqq9iZrr+xVKFfza1909nbqVq6BvpfouibgAlT2S0=;
 b=H3z7wCtnCMCtW080ASkHlLmunRXiLFIgcMN74h83s1KfpcaiNOdQA58HH0FJFvsjEm6t
 x/m5/5CoYVa+3sNXXnO6h/qb95dd9CPswKxGrtK4Sy7izJ+4bOJ2d3Q8ENq13qo1PfYk
 fxoK3BIxORLZzbipc8VUB1Cr5HvRyRrYSw3FgZBLbj+Po8z6YmJzJKiQ6ZecK+Su2kae
 dsqz+s/Hik9AWU4Vgg2hWVmcuLQd5Q38Tez/1aeEmXA99nY1NxsVm9JzmQRiV4fAHrPQ
 I3exFdAoUZbeJIVTD/Iz6fqzLMOxd58iO9aEJnj3wSJM8QhuWuq6ZD3zSI55UlCK3VtY JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb106prm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:24:22 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23THGE6r014494;
        Fri, 29 Apr 2022 17:24:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w88rwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Apr 2022 17:24:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOtVDEzEb2eAJw4MJLMjfa9JnDf0jgtKx2n4lXkBUDxFdjK6AoGsg/Muz1li9xLp0zgdHR0AXJgR3b3HlsOXj7R3AqLM64v7JLiYagq/pF+wpb+aVp1jQWEh2vHIYerO4CuFR27fgTx+FW62PIqBD9RR07w42b71c1oqOgleR69Aot3czr76R+yihT4fT8IBzzD/o6xVgxIBQNS2/7wKyX6yyZQJ6j2M/DCBm4vEgJ/7MeS1Sv1tlWeAWoFD3XItTcSq7O45sNB3yRra2QDP/zMM9/TLTuZggnmq2fljqQv+FsbvlcqsuRkhn1Y+WgNX0sOUMzKJ799BIPPv7/ClhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1cqq9iZrr+xVKFfza1909nbqVq6BvpfouibgAlT2S0=;
 b=Trk3d0GdGmgcXpk7S/eBYpAbu5sPZaQ3DiVNPso5tQZHT0qweiqaGzQRn5FRt9ObIWq2DlZteu+oETRxI0Wpsw6jPGmJ2qmqJLzrShIUgA9ZicR1PrBlPXnhvbTNvuDUIHcfrmWlvl7LfJrsFbdkjBQO/F4ul4GAOJTxiF2UTvaIOhmGr6RSkY0t8Ypx7j98dIH62cagdIm2qVjvHDllpP3RULYL5KCMoMdycBCRGrVyTRA2uHtDT/PNfNaF3dx5A0bbkc2beZRmR7neKA6MEcLlAfd040brBRPucwPqrSen+R+G7+lFQaCBjX/223F0lm9XAKbRQEORWLxYlJvleQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1cqq9iZrr+xVKFfza1909nbqVq6BvpfouibgAlT2S0=;
 b=ivqaiJB2W9B5WJqbBSksyHPzv00VUrLG+SeBhyx8YNeS/85PDXT4bitNeHxCvXencP1wwdiz+WoxDVokT8IEjQKoxBf2g/XzSJCnQGHGHzADFQnWZG+BQ3aXW8wMM8QwnAQENidkAsWuPMXudZN/JIRgeX5Jp6QwjBSvZ76hSmU=
Received: from BY5PR10MB4257.namprd10.prod.outlook.com (2603:10b6:a03:211::21)
 by SN6PR10MB3005.namprd10.prod.outlook.com (2603:10b6:805:cc::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Fri, 29 Apr
 2022 17:24:19 +0000
Received: from BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586]) by BY5PR10MB4257.namprd10.prod.outlook.com
 ([fe80::8191:d4f0:b79d:a586%7]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 17:24:19 +0000
Message-ID: <862e6f3c-fb59-33e0-a6ea-7a67c93cfb20@oracle.com>
Date:   Fri, 29 Apr 2022 10:24:11 -0700
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
From:   dai.ngo@oracle.com
In-Reply-To: <20220429151618.GF7107@fieldses.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:610:38::15) To BY5PR10MB4257.namprd10.prod.outlook.com
 (2603:10b6:a03:211::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e32801b-f777-400a-c9ef-08da2a051793
X-MS-TrafficTypeDiagnostic: SN6PR10MB3005:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3005B5E91582D989A4FC4CBB87FC9@SN6PR10MB3005.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vZCN8QXOEGDiny+rvtlLhpVoKvkZDsvGHCKV8bqHGBSjCJk3+KyGFMhuqsMErs/Z/Om+LZ2yeZj356br1VYYLPWQs23bQMvBEOxENb8chceTqHuHgIhu+UqDXPEhpkYra3z6BYX3lu6XdyYTXmuUOUm1SUcaX1S0/pSVlKjfb+R37H9UTPASCHQaJl5t5Hovw44PCKHdYtTFIXAun9cK9gETBmXkux9FNMoUzzJ1oisSCz2uFZMJ1gnWX/2+AEOcRlRU1CLGHBb6hdB02q9LlaS8BdRgk2IDYUDuPuLjrvIisKLUO81O0BWAl8j9Q9ko0/QZkS9RYzk4w5Iy35Fhy4BIDmqNp3MV8YTvonPpQ8/hyHLBGpNiMhuacPqOGsiQHnYCpc+Sm2ZdSTNOc/5tsUel1geGsjbJuV+MG6ktXIJz/NvBTB9Ke/VECI0C65p9GSK3bQTDnaBotXToEry4qHr1zuaBhGSYx421yPlTIQxs5zUfsbijKE7ECHUFC3QYHoNSHWuzKxO8ul536nhAEs6NAzJ9Gv/G2bLHf6ThSJzaYlEjjpWT+IejZfwh7ys1dZYIg34B9vNgvSu2mn6hrXU52IkiDPvU+hl5SKD5vS35JF4fqqZz03FHAAKz49e48PyNoZXhG/RY8DTCxvbybw/+JndpnmFJAAHKHUQ+PmBcTBHERuRMsLHbPTQTbbqBmJhQ4DPsC6Dlk1WTf5/0SQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4257.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6916009)(6666004)(316002)(36756003)(508600001)(31696002)(38100700002)(8936002)(86362001)(31686004)(186003)(6486002)(6506007)(53546011)(5660300002)(26005)(4326008)(66476007)(66946007)(8676002)(2906002)(66556008)(9686003)(2616005)(6512007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWFzTVJIQWZmRmIrcDZESnFsUE1NQVliL01mWVRWak54cXdmVTU2UWF5c09R?=
 =?utf-8?B?T3M4VERSc2xsNFA3K0wyUjR5TWZERHExSHZ2VHJ3UjREaVNGSjd5TXNrNUM4?=
 =?utf-8?B?SkZVczZONnhjZUdWMWVmVTZhRllHb2hlUDA2Z2pwTHdXa2xEeVJ4L25sRGsy?=
 =?utf-8?B?bFRqaEVPODJOcHk4dUhKL3E3SXQwcG1Na0ZFRzYya3JHSjRUb25WQ0ZjS09I?=
 =?utf-8?B?OGpmWE5yUS9pQ2o2aHpYRjVwd1p2RVdWOWNVS1hzRnR2STBXNTlLMnVqQkhZ?=
 =?utf-8?B?T1paVVR6TjRoSzdNY1JENnc5Q2hUZHBZUFh0aEQ2NEJFZ2hUUTFXdXJtVHcx?=
 =?utf-8?B?bkduR0I0RmJ0alE5TE1MNk5iaFlCRVRCbGx6cG9QRmhrWWhOdkFsYnU4OEVP?=
 =?utf-8?B?MG9sK09VM3ZsbTBkNFRZNnVveGtJVDkzK01KWldVUXpkRm5rY05GWHJGWGhU?=
 =?utf-8?B?M3pnT3p2aWsydjFGblpLVTlXS0REZWtZWm0vQW5UUFJkNVlzWGpVdzduck4y?=
 =?utf-8?B?NXk4MHl6TVFEejNBdUJWTlpCMmFaZjM2WmlTKzJpcVVJb1BSdFRKQWQ0MEhI?=
 =?utf-8?B?YUtqY1FZUnBuaHJubEdpZTZmWmt0Y2l5eHMwMXJiVjhlb3hwcXU4eS9qT0Jn?=
 =?utf-8?B?Y0xpamlHang5RU9LdG1ZdWpRcjVQWkZxZnA2Q0hWVjcxYmM1OGxFaGlEeWhJ?=
 =?utf-8?B?ZUd5eWxYWjgzS282dFd3UTFPa29OL25hRExIamk0QTRoUURFZ091Ukk5WGs1?=
 =?utf-8?B?TEJSQTY5N1ZOamVpZ3lPV2h5QlJBRGRhaVlWL1paWHVjVWhNbW1aTXVhdUI0?=
 =?utf-8?B?SDdrRGliRkhEazUzeVlDZXVXa0g0U3lvZ0JibDJFNGhxc3BweDVveC9zMExG?=
 =?utf-8?B?OTN5dzloQlZDYUNYM0IrTzB0aUtzcHd3Y2h1Q2N0M3A1VElpYTZMYitFQ0FD?=
 =?utf-8?B?ZW9lU1VDT3ZyR3BNT0UxNUFhcDZFUWhyZGJsYzNlVWNnc2phSUYwbW5HWlZY?=
 =?utf-8?B?SldQNWZwbTdQTUxrSmJBcHZlbVBVNitRWE1FZ2I4MlY3VlRDOGkzNlFEOHJD?=
 =?utf-8?B?WFNxeWVXb29Nb1F1Z2J3TUpJRExET0IrNG5leDBYRmMvT0NWaWUwM1hUN2tj?=
 =?utf-8?B?ajBwRGtnTUc5NFZjRzhjS1paVXNBYzBpK1ptWGNlUkR2cnZXalNpaEdVVGEz?=
 =?utf-8?B?ZnB6cHRCVVhRMldCM1lZT1JLb2Y3TUdPaDJCVEw5ZXB6eERFbmYwYkxkQWc3?=
 =?utf-8?B?WHhMY05xeU9FMEVuOWdoTU5tUGVEbWUxZW1PWXB0TzYwN1FTNmNCUEVDSFRt?=
 =?utf-8?B?elRMUDMybmcxQm5oM0hJL1ZhMWpJcEg5ZWREVWRYTHgwTC9WdmN3dnY3bEIy?=
 =?utf-8?B?WUIyRWcxa3ZZRVZ1MzZ5bEpxc3JReG1OYXhyRmpVMkdyVFdjZ2kwNnhrVDhK?=
 =?utf-8?B?Ry93a3g2dko5TVZtSFlQSE1jcE1vSUFrQmJrNUpVWFlkSFhaUzhJYXpYdVpR?=
 =?utf-8?B?ejgxQXQxOHpFUGtEUVVCblhGazVZUU8yZDJZeVp2Z0tVVG13NS9xeFFIYWph?=
 =?utf-8?B?Sk02WUJBYUFiRjZ4ZWtldUdHcG1Lc1Q1Q2w5UTN5ck5ULzBsQ0M5dm1KK2Rt?=
 =?utf-8?B?TXNyN0pCT3E4bE9JTmhPK2xHNFNsL21GeGFLOFJ1L0l0R1pJbWJRc2Jhenpi?=
 =?utf-8?B?S0p5UVdHQXQzVUpPOTR3T0ZTY1FGaXdMb2wxZUVQZGhzVU5EVVQ5MmV5YUFH?=
 =?utf-8?B?T0Ezd0NuRS9uakFzWmcwajM5V0VNbmUyRVhtWmJCVlppaHRVNnl2VmdVT0lD?=
 =?utf-8?B?NS80d2owMzB4bXBEb2U2bkc5bVBLLys3aFFIeXVxTEtrYTZzL2d6L1pOclQ4?=
 =?utf-8?B?TXpaSk5MMG12UFptSndyQTRveWRneS9tSVNYVXpYNDdwakJ1VW9DQmN0elJM?=
 =?utf-8?B?amliS2RadFdEa05oeHFYUnQ3OExjOGxzYXRvTkd4d2t1U2RUSlA1Z3VWQms3?=
 =?utf-8?B?cE84M0FuTGh3L25tRGMzRGRXZk1PLy9DL3lsWlFXOEF3Q2tNMml6VkM4cDJZ?=
 =?utf-8?B?MXd6d3d4MTI2MzFMbXVUcjdBczJTVldnVWdHZVNEMnVJWWtJcGI2SjMrNFpi?=
 =?utf-8?B?bzVlQ29RTEF6dXYydnk5bTh5RUZPMFdvUktweUxEMXNnR1krRVFXcDFYTTRZ?=
 =?utf-8?B?bnJxWlBXaVhTMjlEYkZqYjRjUWFYQ3dqUkFhNlBBSmgrbFp5SncvbjNYaHlX?=
 =?utf-8?B?V1d6Z1NwczUvbWVPcVJEK2tVUy84enQ3bnN5Z2VLMU41bjUvR3c0R0doZlJl?=
 =?utf-8?B?WTROODFQSGk2OXlYQjFHU1dZeC9UYk5JUjNBQW5wMnM4enI4cEFOQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e32801b-f777-400a-c9ef-08da2a051793
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4257.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:24:19.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTXfPfUlLMiF+PTfxZlMBanZq+KLg2PyydUQm/2wtvO1Rszo9nugLH1Y4ME+oBcFwjYw2eLwZ2izzF83zRuqFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3005
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-29_06:2022-04-28,2022-04-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204290087
X-Proofpoint-ORIG-GUID: ul_G3EAWZTn8_14CNB0kdra7t_KCO8_7
X-Proofpoint-GUID: ul_G3EAWZTn8_14CNB0kdra7t_KCO8_7
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 4/29/22 8:16 AM, J. Bruce Fields wrote:
> On Thu, Apr 28, 2022 at 12:06:33AM -0700, Dai Ngo wrote:
>> Add 2 new callbacks, lm_lock_expirable and lm_expire_lock, to
>> lock_manager_operations to allow the lock manager to take appropriate
>> action to resolve the lock conflict if possible.
>>
>> A new field, lm_mod_owner, is also added to lock_manager_operations.
>> The lm_mod_owner is used by the fs/lock code to make sure the lock
>> manager module such as nfsd, is not freed while lock conflict is being
>> resolved.
>>
>> lm_lock_expirable checks and returns true to indicate that the lock
>> conflict can be resolved else return false. This callback must be
>> called with the flc_lock held so it can not block.
>>
>> lm_expire_lock is called to resolve the lock conflict if the returned
>> value from lm_lock_expirable is true. This callback is called without
>> the flc_lock held since it's allowed to block. Upon returning from
>> this callback, the lock conflict should be resolved and the caller is
>> expected to restart the conflict check from the beginnning of the list.
>>
>> Lock manager, such as NFSv4 courteous server, uses this callback to
>> resolve conflict by destroying lock owner, or the NFSv4 courtesy client
>> (client that has expired but allowed to maintains its states) that owns
>> the lock.
>>
>> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
>> ---
>>   Documentation/filesystems/locking.rst |  4 ++++
>>   fs/locks.c                            | 45 +++++++++++++++++++++++++++++++----
>>   include/linux/fs.h                    |  3 +++
>>   3 files changed, 48 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
>> index c26d854275a0..0997a258361a 100644
>> --- a/Documentation/filesystems/locking.rst
>> +++ b/Documentation/filesystems/locking.rst
>> @@ -428,6 +428,8 @@ prototypes::
>>   	void (*lm_break)(struct file_lock *); /* break_lease callback */
>>   	int (*lm_change)(struct file_lock **, int);
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +        bool (*lm_lock_expirable)(struct file_lock *);
>> +        void (*lm_expire_lock)(void);
>>   
>>   locking rules:
>>   
>> @@ -439,6 +441,8 @@ lm_grant:		no		no			no
>>   lm_break:		yes		no			no
>>   lm_change		yes		no			no
>>   lm_breaker_owns_lease:	yes     	no			no
>> +lm_lock_expirable	yes		no			no
>> +lm_expire_lock		no		no			yes
>>   ======================	=============	=================	=========
>>   
>>   buffer_head
>> diff --git a/fs/locks.c b/fs/locks.c
>> index c369841ef7d1..d48c3f455657 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -896,6 +896,37 @@ static bool flock_locks_conflict(struct file_lock *caller_fl,
>>   	return locks_conflict(caller_fl, sys_fl);
>>   }
>>   
>> +static bool
>> +resolve_lock_conflict_locked(struct file_lock_context *ctx,
>> +			struct file_lock *cfl, bool rwsem)
>> +{
>> +	void *owner;
>> +	bool ret;
>> +	void (*func)(void);
>> +
>> +	if (cfl->fl_lmops && cfl->fl_lmops->lm_lock_expirable &&
>> +				cfl->fl_lmops->lm_expire_lock) {
>> +		ret = (*cfl->fl_lmops->lm_lock_expirable)(cfl);
>> +		if (!ret)
>> +			return false;
>> +		owner = cfl->fl_lmops->lm_mod_owner;
>> +		if (!owner)
>> +			return false;
>> +		func = cfl->fl_lmops->lm_expire_lock;
>> +		__module_get(owner);
>> +		if (rwsem)
>> +			percpu_up_read(&file_rwsem);
>> +		spin_unlock(&ctx->flc_lock);
> Dropping and reacquiring locks inside a function like this makes me
> nervous.  It means it's not obvious in the caller that the lock isn't
> held throughout.
>
> I know it's more verbose, but let's just open-code this logic in the
> callers.

fix in v24.

>
> (And, thanks for catching the test_lock case, I'd forgotten it.)
>
> Also: do we *really* need to drop the file_rwsem?  Were you seeing it
> that cause problems?  The only possible conflict is with someone trying
> to read /proc/locks, and I'm surprised that it'd be a problem to let
> them wait here.

Yes, apparently file_rwsem is used when the laundromat expires the
COURTESY client client and causes deadlock.

-Dai

>
> --b.
>
>> +		(*func)();
>> +		module_put(owner);
>> +		if (rwsem)
>> +			percpu_down_read(&file_rwsem);
>> +		spin_lock(&ctx->flc_lock);
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   void
>>   posix_test_lock(struct file *filp, struct file_lock *fl)
>>   {
>> @@ -910,11 +941,14 @@ posix_test_lock(struct file *filp, struct file_lock *fl)
>>   	}
>>   
>>   	spin_lock(&ctx->flc_lock);
>> +retry:
>>   	list_for_each_entry(cfl, &ctx->flc_posix, fl_list) {
>> -		if (posix_locks_conflict(fl, cfl)) {
>> -			locks_copy_conflock(fl, cfl);
>> -			goto out;
>> -		}
>> +		if (!posix_locks_conflict(fl, cfl))
>> +			continue;
>> +		if (resolve_lock_conflict_locked(ctx, cfl, false))
>> +			goto retry;
>> +		locks_copy_conflock(fl, cfl);
>> +		goto out;
>>   	}
>>   	fl->fl_type = F_UNLCK;
>>   out:
>> @@ -1108,6 +1142,7 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>   
>>   	percpu_down_read(&file_rwsem);
>>   	spin_lock(&ctx->flc_lock);
>> +retry:
>>   	/*
>>   	 * New lock request. Walk all POSIX locks and look for conflicts. If
>>   	 * there are any, either return error or put the request on the
>> @@ -1117,6 +1152,8 @@ static int posix_lock_inode(struct inode *inode, struct file_lock *request,
>>   		list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>>   			if (!posix_locks_conflict(request, fl))
>>   				continue;
>> +			if (resolve_lock_conflict_locked(ctx, fl, true))
>> +				goto retry;
>>   			if (conflock)
>>   				locks_copy_conflock(conflock, fl);
>>   			error = -EAGAIN;
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index b8ed7f974fb4..aa6c1bbdb8c4 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1029,6 +1029,7 @@ struct file_lock_operations {
>>   };
>>   
>>   struct lock_manager_operations {
>> +	void *lm_mod_owner;
>>   	fl_owner_t (*lm_get_owner)(fl_owner_t);
>>   	void (*lm_put_owner)(fl_owner_t);
>>   	void (*lm_notify)(struct file_lock *);	/* unblock callback */
>> @@ -1037,6 +1038,8 @@ struct lock_manager_operations {
>>   	int (*lm_change)(struct file_lock *, int, struct list_head *);
>>   	void (*lm_setup)(struct file_lock *, void **);
>>   	bool (*lm_breaker_owns_lease)(struct file_lock *);
>> +	bool (*lm_lock_expirable)(struct file_lock *cfl);
>> +	void (*lm_expire_lock)(void);
>>   };
>>   
>>   struct lock_manager {
>> -- 
>> 2.9.5
