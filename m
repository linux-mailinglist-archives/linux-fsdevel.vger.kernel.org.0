Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F77606C7D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Oct 2022 02:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJUAd1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 20:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUAdZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 20:33:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39791E0455;
        Thu, 20 Oct 2022 17:33:24 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L0EC4L012296;
        Fri, 21 Oct 2022 00:33:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=PNP2Mxr86tvitIaE02qeV5zPnllVYucT5dDYb986QkM=;
 b=DAhJ6YOkALxNk152d5+wtQpZ6DY7f717CsfhoE7o1mY9Ikrb+Fj1EkBdm7BixG6XqhpB
 md/EWksvLf6D9qiruiefYlRzlc80/NKo/G6D1k+mo1QSUTn+Ay96cHnQkzQG24SrjYba
 ftHHEL3lzyxTcf339ojEbAXexk0/MsYpRlpkMTWrWRsKZsDUK6BXCQiHVaWX7h1c/uFu
 OZ90+NKaYrpmDYLMFh+/A9JILNHS2TnHZQPsOdBDbz1WA/Ctryc4WFjSMyKCQfcv5uuQ
 6/aj0iUxq9ssSB+iyqUkmp8mwVbdA3RFBZufDeYg9QmhoJFx0jD2RUps/x6GUsVvp3ix qw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9awwaa46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 00:33:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29KL3meu007536;
        Fri, 21 Oct 2022 00:33:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hrdbbh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 00:33:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecrGmGomuA5pZPaRGCKJMHhb1rpQVt3oPPX9CxK4gJeaskjbZM58uoXZK1R7GIs8h77brw0hfJYSkhzzsLYRYB7THSvrZjUwXff1YnJ+2s4xi6qRL6Se5jSOqhtrl+YLeg8eH5NffXK6ScqDsnCm+1SckGMBx1xgKKLofQOdulzc/6tdxinSzCNUSoJwSmwFTJQF9HvuYiUecd1VlCEKdQNj3wQbruYIxl30sEa62Ts5/+VxR4GBqGxPcU9n1kXk/ehft6rQDbSxBWn1VcttebZXktmCtb0yWY4SsvXbAFwO4lHj8Xp7sT//yXgCCFzlIys1ecn9+YO5jZ/0LDotUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PNP2Mxr86tvitIaE02qeV5zPnllVYucT5dDYb986QkM=;
 b=OROgJqV3+6jC1bIzcgZt1LLhutHWGmykUOqJZHJxBn48kqB5MV75q2Ju/CapiGDUHD7xnD4faezROCftJMxQ4vWw2f3lRGYK+VIFHqG7w6Ow1hvivGqrRElXDpncNqE5VwDM4kcX6BR2tbAXbFWcVlDHn3BJHaVWPbB/X2Bz83vhJPDpf0cASTjlC5H15wqhTMj5MJ32qBa2w/pBdCCBhWga8UeveHIRTe+KPOlqjg/Eh5GKhr/5pFZawQQUepQBYLhYLEADLP8t2I8B/ktCEHcPAsFD502KNTnq/AAuP8tcFBYDoFDtVoYr6xIClvVPtHCQX4AXcaRv+ezFldEAxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PNP2Mxr86tvitIaE02qeV5zPnllVYucT5dDYb986QkM=;
 b=mYAAisaLBYwIcEb6DG/dO7y5MfY1KTZdLa+RfnWDkfzpTOMjfHuxvbYdk1iI99dka3/m95Yy1ohMpnmDrAzZgZrEVkUU7vHfX5gp+B0PK85qhuRBN0wCq95sofGvoQJIlhh23GEmz8CdNFhUTnHWDwa4gHmWOCnZGx+e7HKW/CA=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB5339.namprd10.prod.outlook.com (2603:10b6:610:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34; Fri, 21 Oct
 2022 00:33:16 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::5374:25b4:8dea:31dc%7]) with mapi id 15.20.5723.033; Fri, 21 Oct 2022
 00:33:16 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] fsnotify: Protect i_fsnotify_mask and child flags
 with inode rwsem
In-Reply-To: <CAOQ4uxhi27ZZmXMV1JTR1+3-1MVMY3W_R=+7LbOHWXbKOk4hjg@mail.gmail.com>
References: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-1-stephen.s.brennan@oracle.com>
 <20221018041233.376977-2-stephen.s.brennan@oracle.com>
 <CAOQ4uxhi27ZZmXMV1JTR1+3-1MVMY3W_R=+7LbOHWXbKOk4hjg@mail.gmail.com>
Date:   Thu, 20 Oct 2022 17:33:13 -0700
Message-ID: <87y1taggmu.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::10) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB5339:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab3e161-a875-4e33-fe86-08dab2fbd849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4AGBYXoFEcm8ZbEQW/bbDVQ/pPnm5h1DnPFhJa5AebPnGTgZO2dbEDUcMREAewVOKC+wksr4J6kcR9BhzdNy1bw9NPuNvcslXc+tROpAvs5WoSw3kN2KiwLHb0zBaXXy4f4/FMvvNfULwjfh7i00co7NuAgMNR3GpvBh/a6f/K3JRxk1ZDhyuABBmW6TIKkRQj1/4XtEuuRgrXVaRmQDc/DXdY9KKg3xSCdjbEZ2qCh2se7Ec/pc1YoMUw6CeIb0Guq4/ZloCs74zJAYcH2FCz+MpRZcT6bNq94fU591YZ+VucOr7gtC2H88DWpNQ9m15VCjv5jX2Li9kbcu5+wTMnqj3bmUZ7okiFCzow69QWsKy5oYQecSDWsCXp3nR7tv5G26FnFKeaBl9glXvxscsUutqZUs3I0rIQnPWIuIocYP/jcSJ29q8mzF0fbjV4lLFgp4dksl32GmCzQnJzoAFsMrvB6LDXlCHokiSsnEl6Ud/Eyi3G8VLptkffQAXswp6o8zHUmiUFSS6/LdTG/FY/h/kPbujxtUrkV8WuCDXcVMTyWTQq1VukBZvVFMWvQ3bxroB9v1Ox6ujOOwA63tv+IIavD8qVEVWifdioAs/5bTbVyNDisd5zwtRrI8I7ywLtRVWz5zzgpIx345O5RbPnWXSn1soIfOgD6+ecDeJcVgHuk91MkahnJWpt4GCBh7sxPHNTJYkfxlNs5OS5Onow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199015)(186003)(66476007)(66946007)(54906003)(66556008)(41300700001)(36756003)(6916009)(316002)(6506007)(4326008)(8676002)(38100700002)(478600001)(26005)(53546011)(6486002)(6666004)(83380400001)(86362001)(6512007)(2616005)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AFJ2ey0weuf38sgI7yk5x8KCwm5KL8NrdKgI2Tph8tvszV7ToIUdA6v5xFQt?=
 =?us-ascii?Q?W5xuFPFj0FN2T/6oTDvoe6eChEDGs9bnqCJO1MEEcn6hNjXo6PREJwWNEsmP?=
 =?us-ascii?Q?g5ZQwVpsT1tjmTiwapPOiKmM5qu44fe/SF6pyYo6m9XjIR1xKkbhvfArXAW1?=
 =?us-ascii?Q?y2/CJUJw8zB4vcml0T1yJMAgvoYqjKVJ5ARthJQiGx8JJvnF2Lz30dsKvQ+t?=
 =?us-ascii?Q?DxSpWqqvZ6/vbMXXFuXSGHmqsBxe0CXWlifo5tvuh2+YTYXUhVKjYVLsiID2?=
 =?us-ascii?Q?Y272vupfWvSnjQ7JRlhK/W+PvKeIMNZjwyTwU5UpStlqipyMFzxcy3CgSvDP?=
 =?us-ascii?Q?JONRszwjC8R75eCDk/QucF5/qg8LoBPaVuARJf9AeWgKnxRY1GSEdoejeJI1?=
 =?us-ascii?Q?fWfg8EborJKBzoqhFPWqvqOiHKV12UXXvm3BH4i6JUe5eqZEUBM3kwD8LMSA?=
 =?us-ascii?Q?9KgpB5wknDJOPsJSAYkMAulOQDIkJoImi8qt6Jn+JpopS1Im2x1ulb3ghFr1?=
 =?us-ascii?Q?3WkKwzFjJTmym0KutX2ESOKEbdaLg1KeCysExKijpfuzv3nmYkECfYl63aRi?=
 =?us-ascii?Q?MY2ahcHmNKBKAVelQtc3InnCAhqph/pDCcBKNYme53t3iuXNlsKoegqhIPYK?=
 =?us-ascii?Q?zxFEGmVvumw2vSlspfVtmSNnRy/tLID0l9csiPeuEg957hobYkNTy0M9uORv?=
 =?us-ascii?Q?LI954n4Xt0J25jP9QY4KxW8O+II2MDI+NacK30j7l13tM3jUhGt3ABYYmFvp?=
 =?us-ascii?Q?Cuo2jw2T2eRakbtVwIKQSpNZWqzx4xPKL9Q6IYGBcX7S3B4litwTpbQf1Raw?=
 =?us-ascii?Q?KqvtTFeHsENxeL/RhBQgzp8J9uQSgwvAS3f5tCuwKNbBwW7Ct/90IKrTVBIE?=
 =?us-ascii?Q?DpeNWOZnD7OAr8VIBUWuiqggMM3FTQQ727j9SXtvwp1D2sH3oxHqyjnKejp0?=
 =?us-ascii?Q?q4aYg3mX1hK8RTDE+koFN5YccC8W5+u0boT9p1Y3XabIdz+kMT7/YlGfoGW4?=
 =?us-ascii?Q?08cpIWSaKhTj8ketxiTguB/c7MJZ4aV8bSQSI4Hvki9lnpdKFQ9qfXucpAuK?=
 =?us-ascii?Q?4Lav26PiLB5pB9lc0Q4QOuA16w1laEr55Q+R7RtochkPdb4TFIsSE/Ll24WO?=
 =?us-ascii?Q?55ePi6JDLCIXLNGCiiOpdPku7oPx76H2H0iKuJYYIub6oa6cKEK50iWQcmW/?=
 =?us-ascii?Q?yknMbCNffncASTBs0MrdLmzvuAWUXESk2qYlU6K5wa/qaFfC8qAoi3w4Hu0T?=
 =?us-ascii?Q?NsJ4+Z+jCkKeZ+z9leuqV5u+Uiw9Su8Qnnyo2NvEdH75yUDJA2FSmTxlQnWd?=
 =?us-ascii?Q?2cW5apwn7Eog/hD+QEYircxp2L5rrtdLIxlVcZ7nDN9LaCfXqUtdFK1nPStk?=
 =?us-ascii?Q?ud2Y14CKYQYMTT6ehPDjSOwX2y6b9frT8x1q/1KpXX1cXlXS+jAeLV/566CE?=
 =?us-ascii?Q?8udo9BiwoZk6ReK/bZ5cg1g2u0uu23etKbUrhVEotrhsVvIDayFvgwcMJiLS?=
 =?us-ascii?Q?gPL8OucOk2Ho+qmqvTuFfy51J+dZPyRcZvn84DP8HT1Hq2Hln2YEVVplWUqr?=
 =?us-ascii?Q?EwIHwbvrYHjaBBmgP8XPz3EF/QWYQwLbcAmFU9tBFlrQe/FFwXq9b18GgjCm?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab3e161-a875-4e33-fe86-08dab2fbd849
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 00:33:16.5046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYLodGOLxaJk9OHhuirUr0cFBHrLV0At1Pqy4jktwuAM9nEJ7wtNsT7SBKfDZx7hb5x3FNybNw3Q90KLwDCz8FZJaP3Tmo9+P2tcy1CVlzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5339
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_13,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210210001
X-Proofpoint-GUID: 8Lfl4eoF8oohxHBfozhBtuKzaro-LmLS
X-Proofpoint-ORIG-GUID: 8Lfl4eoF8oohxHBfozhBtuKzaro-LmLS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Tue, Oct 18, 2022 at 7:12 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> When an inode is interested in events on its children, it must set
>> DCACHE_FSNOTIFY_PARENT_WATCHED flag on all its children. Currently, when
>> the fsnotify connector is removed and i_fsnotify_mask becomes zero, we
>> lazily allow __fsnotify_parent() to do this the next time we see an
>> event on a child.
>>
>> However, if the list of children is very long (e.g., in the millions),
>> and lots of activity is occurring on the directory, then it's possible
>> for many CPUs to end up blocked on the inode spinlock in
>> __fsnotify_update_child_flags(). Each CPU will then redundantly iterate
>> over the very long list of children. This situation can cause soft
>> lockups.
>>
>> To avoid this, stop lazily updating child flags in __fsnotify_parent().
>> Protect the child flag update with i_rwsem held exclusive, to ensure
>> that we only iterate over the child list when it's absolutely necessary,
>> and even then, only once.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>
>> Notes:
>>
>> It seems that there are two implementation options for this, regarding
>> what i_rwsem protects:
>>
>> 1. Both updates to i_fsnotify_mask, and the child dentry flags, or
>> 2. Only updates to the child dentry flags
>>
>> I wanted to do #1, but it got really tricky with fsnotify_put_mark(). We
>> don't want to hold the inode lock whenever we decrement the refcount,
>> but if we don't, then we're stuck holding a spinlock when the refcount
>> goes to zero, and we need to grab the inode rwsem to synchronize the
>> update to the child flags. I'm sure there's a way around this, but I
>> didn't keep going with it.
>>
>> With #1, as currently implemented, we have the unfortunate effect of
>> that a mark can be added, can see that no update is required, and
>> return, despite the fact that the flag update is still in progress on a
>> different CPU/thread. From our discussion, that seems to be the current
>> status quo, but I wanted to explicitly point that out. If we want to
>> move to #1, it should be possible with some work.
>
> I think the solution may be to store the state of children in conn
> like you suggested.
>
> See fsnotify_update_iref() and conn flag
> FSNOTIFY_CONN_FLAG_HAS_IREF.
>
> You can add a conn flag
> FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN
> that caches the result of the last invocation of update children flags.
>
> For example, fsnotify_update_iref() becomes
> fsnotify_update_inode_conn_flags() and
> returns inode if either inode ref should be dropped
> or if children flags need to be updated (or both)
> maybe use some out argument to differentiate the cases.
> Same for fsnotify_detach_connector_from_object().
>
> Then, where fsnotify_drop_object() is called, for the
> case that inode children need to be updated,
> take inode_lock(), take connector spin lock
> to check if another thread has already done the update
> if not release spin lock, perform the update under inode lock
> and at the end, take spin lock again and set the
> FSNOTIFY_CONN_FLAG_WATCHES_CHILDREN
> connector flag.
>
> Not sure if it all works out... maybe

I did this for v2 and I think it has worked well, all threads seem to
block until the flags are updated on all dentries.

>>
>>  fs/notify/fsnotify.c | 12 ++++++++--
>>  fs/notify/mark.c     | 55 ++++++++++++++++++++++++++++++++++----------
>>  2 files changed, 53 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
>> index 7974e91ffe13..e887a195983b 100644
>> --- a/fs/notify/fsnotify.c
>> +++ b/fs/notify/fsnotify.c
>> @@ -207,8 +207,16 @@ int __fsnotify_parent(struct dentry *dentry, __u32 mask, const void *data,
>>         parent = dget_parent(dentry);
>>         p_inode = parent->d_inode;
>>         p_mask = fsnotify_inode_watches_children(p_inode);
>> -       if (unlikely(parent_watched && !p_mask))
>> -               __fsnotify_update_child_dentry_flags(p_inode);
>> +       if (unlikely(parent_watched && !p_mask)) {
>> +               /*
>> +                * Flag would be cleared soon by
>> +                * __fsnotify_update_child_dentry_flags(), but as an
>> +                * optimization, clear it now.
>> +                */
>
> I think that we need to also take p_inode spin_lock here and
> check  fsnotify_inode_watches_children() under lock
> otherwise, we could be clearing the WATCHED flag
> *after* __fsnotify_update_child_dentry_flags() had
> already set it, because you we not observe the change to
> p_inode mask.

I'm not sure I follow. The i_fsnotify_mask field isn't protected by the
p_inode spinlock. It isn't really protected at all, though it mainly
gets modified with the conn->lock held.

Wouldn't it be sufficient to do in a new helper:

spin_lock(&dentry->d_lock);
if (!fsnotify_inode_watches_children(p_inode))
    dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
spin_unlock(&dentry->d_lock);

I'm sure I'm missing something about your comment. For the moment I left
it as is in the second version of the patch, we can discuss it more and
I can update it for a v3.

>
> I would consider renaming __fsnotify_update_child_dentry_flags()
> to __fsnotify_update_children_dentry_flags(struct inode *dir)
>
> and creating another inline helper for this call site called:
> fsnotify_update_child_dentry_flags(struct inode *dir, struct dentry *child)
>
>
>> +               spin_lock(&dentry->d_lock);
>> +               dentry->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
>> +               spin_unlock(&dentry->d_lock);
>> +       }
>>
>>         /*
>>          * Include parent/name in notification either if some notification
>> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
>> index c74ef947447d..da9f944fcbbb 100644
>> --- a/fs/notify/mark.c
>> +++ b/fs/notify/mark.c
>> @@ -184,15 +184,36 @@ static void *__fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>>   */
>>  void fsnotify_recalc_mask(struct fsnotify_mark_connector *conn)
>>  {
>> +       struct inode *inode = NULL;
>> +       int watched_before, watched_after;
>> +
>>         if (!conn)
>>                 return;
>>
>> -       spin_lock(&conn->lock);
>> -       __fsnotify_recalc_mask(conn);
>> -       spin_unlock(&conn->lock);
>> -       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE)
>> -               __fsnotify_update_child_dentry_flags(
>> -                                       fsnotify_conn_inode(conn));
>> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
>> +               /*
>> +                * For inodes, we may need to update flags on the child
>> +                * dentries. To ensure these updates occur exactly once,
>> +                * synchronize the recalculation with the inode mutex.
>> +                */
>> +               inode = fsnotify_conn_inode(conn);
>> +               spin_lock(&conn->lock);
>> +               watched_before = fsnotify_inode_watches_children(inode);
>> +               __fsnotify_recalc_mask(conn);
>> +               watched_after = fsnotify_inode_watches_children(inode);
>> +               spin_unlock(&conn->lock);
>> +
>> +               inode_lock(inode);
>
> With the pattern that I suggested above, this if / else would
> be unified to code that looks something like this:
>
> spin_lock(&conn->lock);
> inode =  __fsnotify_recalc_mask(conn);
> spin_unlock(&conn->lock);
>
> if (inode)
>     fsnotify_update_children_dentry_flags(conn, inode);
>
> Where fsnotify_update_children_dentry_flags()
> takes inode lock around entire update and conn spin lock
> only around check and update of conn flags.
>
> FYI, at this time in the code, adding  a mark or updating
> existing mark mask cannot result in the need to drop iref.
> That is the reason that return value of __fsnotify_recalc_mask()
> is not checked here.

For v3 I tried this with a new "flags" out variable and two flags - one
for requiring an iput(), and one for calling
fsnotify_update_children_dentry_flags(). As a result, I did stick a
WARN_ON_ONCE here, but it more or less looks just like this code :)

>> +               if ((watched_before && !watched_after) ||
>> +                   (!watched_before && watched_after)) {
>> +                       __fsnotify_update_child_dentry_flags(inode);
>> +               }
>> +               inode_unlock(inode);
>> +       } else {
>> +               spin_lock(&conn->lock);
>> +               __fsnotify_recalc_mask(conn);
>> +               spin_unlock(&conn->lock);
>> +       }
>>  }
>>
>>  /* Free all connectors queued for freeing once SRCU period ends */
>> @@ -295,6 +316,8 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>>         struct fsnotify_mark_connector *conn = READ_ONCE(mark->connector);
>>         void *objp = NULL;
>>         unsigned int type = FSNOTIFY_OBJ_TYPE_DETACHED;
>> +       struct inode *inode = NULL;
>> +       int watched_before, watched_after;
>>         bool free_conn = false;
>>
>>         /* Catch marks that were actually never attached to object */
>> @@ -311,17 +334,31 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
>>         if (!refcount_dec_and_lock(&mark->refcnt, &conn->lock))
>>                 return;
>>
>> +       if (conn->type == FSNOTIFY_OBJ_TYPE_INODE) {
>> +               inode = fsnotify_conn_inode(conn);
>> +               watched_before = fsnotify_inode_watches_children(inode);
>> +       }
>> +
>>         hlist_del_init_rcu(&mark->obj_list);
>>         if (hlist_empty(&conn->list)) {
>>                 objp = fsnotify_detach_connector_from_object(conn, &type);
>>                 free_conn = true;
>> +               watched_after = 0;
>>         } else {
>>                 objp = __fsnotify_recalc_mask(conn);
>>                 type = conn->type;
>> +               watched_after = fsnotify_inode_watches_children(inode);
>>         }
>>         WRITE_ONCE(mark->connector, NULL);
>>         spin_unlock(&conn->lock);
>>
>> +       if (inode) {
>> +               inode_lock(inode);
>> +               if (watched_before && !watched_after)
>> +                       __fsnotify_update_child_dentry_flags(inode);
>> +               inode_unlock(inode);
>> +       }
>> +
>>         fsnotify_drop_object(type, objp);
>>
>
> Here as well something like:
> if (objp)
>     fsnotify_update_children_dentry_flags(conn, obj);
>
> But need to distinguish when inode ref needs to be dropped
> children flags updates or both.

With a flags out-param, it works well. I actually was able to stuff this
into fsnotify_drop_object, which was good because I had missed a whole
other function that can detach a connector from an inode
(fsnotify_destroy_marks()).

> Hope that this suggestion direction turns out to be useful and not
> a complete waste of time...
>
> Thanks,
> Amir.
