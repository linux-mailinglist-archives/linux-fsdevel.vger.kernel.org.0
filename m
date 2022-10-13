Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8005FE539
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Oct 2022 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJMW1b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Oct 2022 18:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMW1a (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:27:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8F41382CB;
        Thu, 13 Oct 2022 15:27:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DMLTEC022294;
        Thu, 13 Oct 2022 22:27:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uDJHGT9pBp4rtK41fSZEw5wBG+nPWeMGGtmmygGTfV4=;
 b=YpmzJAO++H+qCLfjh4HEgvKEK5qGfEPXdKf+SgMinFhyZq/qVRTDb7VmanRL8tg+93Lz
 Z83/8JYcd375x+VBt2tTqw58W/amL+Dt1vRg547af//PKBkOO2c7L/M6HIC5L4xBmwc6
 IrOBhUMIv7fo7cYx6UN7t7V9DxtInr1KWAADgb2tUtkHJ2Q4knyTsO/KW/TYdjK7Q/VJ
 Q/pCLwV69p+hnfDLmgmysi4BcsSamYUW/pWEEQ4AN+hJt0bcdhuYupha3ooBnbWWiznu
 VqFXUUNA+RlCPAp+V920fkByDr/2Aen7Ekp/3KmMf9nxtLhc64/WkWQuDToaY5y0dY4r BQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k6mswh8p8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 22:27:24 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29DKsnoc028728;
        Thu, 13 Oct 2022 22:27:23 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn6mm0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Oct 2022 22:27:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OS5rIgWCnBOKX1pLg4mda8/RrWR+nqdmaDjtVVO5PvMDHUxFi/yaiFaXuaSewRcSBCVxllr76CTslnewHkpm//VG2gM0kVy32t85+r2bensmN2ETXRL7/1kSRlNdSMnSoMcTm8pR1H4uA1qPkXbTnRLiiTTRPBLAgHWIVh7BTSs7WSUdIZ1aRp0vHZKninN4p+5rjGqWvN7TFmE10FKLNu+UZinVfID2LzpYswue8weBv21O9coNEW/2O/r7guyhwmrfjDBFPbuE5t99q727VSSc1hXouP3IRXf4PRahXPZ/Ym3J8/AlCRZC8cA8G7dlSBl6jEg4fe4fuf8AZpvvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDJHGT9pBp4rtK41fSZEw5wBG+nPWeMGGtmmygGTfV4=;
 b=g9tB2NbSriLzEoVnVyp20WssLwYodNEvnS2+CVrPdGT4sOQMvJZtxgfD09Kw9uqg8sPwXzfja9MLjOoK3+evf8hos4h/RIfHdPmLqjHxsWU33sMI2VmmrlW71u6YdwwN7iI3bAr9wCgT6gvntWVyc0+0vcmebVvpHwbnmwQ5aGA1zvBCgwUN/LsXleSAlYKTON2Zru4yQzj3QeYrw3uc3juM9lsK/iicmxpX52Ygw4GGPnochtKFWk+8JjI4y0z6RPEnwg4SVEMY10IofLIjvEoJMSY4HbTuOiso0PWnh3OuJpEJi6jcEVL0MHuOW9fieUN+C1SvtJTPef+rdaUXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDJHGT9pBp4rtK41fSZEw5wBG+nPWeMGGtmmygGTfV4=;
 b=m+CLzokPiLKVPYGKD+Pk5ZG29bnXLuAR4btqu/InkV4L2jCsEbvhuEhJRXP0En1E35KevXZLedvQvzgpCGFJ9BTyjzyJYt4+IdxNtjP3BQBwoYwBN6fJ8VMmVc1TkUl8zEZu0W39cmCjh/Wwbm2Zjz5CbQARzdzvlos1mdd4gp8=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BLAPR10MB4916.namprd10.prod.outlook.com (2603:10b6:208:326::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.22; Thu, 13 Oct
 2022 22:27:20 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8828:8ba:8137:c4f7]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::8828:8ba:8137:c4f7%7]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 22:27:19 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>
Subject: [RFC] fsnotify: allow sleepable child dentry flag update
Date:   Thu, 13 Oct 2022 15:27:19 -0700
Message-Id: <20221013222719.277923-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0353.namprd03.prod.outlook.com
 (2603:10b6:8:55::13) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BLAPR10MB4916:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a95577-995b-4c09-dea4-08daad6a172a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 73pe7lPYzUykLQofRI/C0piYrSokuvNSE6qgtge3qyIM3YayWlsir3s1iJXyhunucCw9I7/OAiYH3HfGexau0szq3Ajfhb2POT+2QgX4qpzOuc88+ETMTj6TALw/73sfSs+sRK1V2Mjc2YMCN3CEZ6PE32J55pxhZgXTcznXLOgfPzrZjhzGnIz1POstXbxcjaR2AgPx1wq53sVeUQeGT5MpvJQ1baPmHVa8W7JEzgfCzFfQmtflLTzbFLRSWdlUp4vySZ/mv1leApBD5ijDNsZeXfpwsu7ov6HUlWvSPpwW+f0lCB2dIYlWmTkA7moBfC5+xw3hRR5cEZ/08e0E2YYXD6U0hv+R7tzIxeP5u44cbf3TfbrrJG90KPTwlnPDY11KRS2KN5ZfGZhdQPC1RI6KiMM5Bnq4xLl8Oi7v6jERrABlJAJBvIEyGPqOh4RIKP/FjIH+bOQSMubUhonf3KENk+Z0+DPuS4vjguP2QQLezL9arw9VcJimt7wiZ+/ZPRcIsLzvNJLhDUmrkvVMvaFkJLOK+/QHwin8otEGYaZ7LBI57l268byHLqfeKSb+ljxxlN1EhiZjS9W6WtjUGBoqkSHUo2DfjlEI0fCUUN2vct+J1m+6i7z8yOTGv1gPmo1bIeS5ujFj9stVqegumLwRjl0V2JCRnpDNB46i/sz6dl4uYdI+Pr1+0i3Q+q1FnQuM3EYPxMS2pIreXbHVsxANTPUauO3Ds/zF8pUMDIFmLVSrWbV9zHgLZ+stzL1PV5OqmAB0/8gFsou/xNd9GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(396003)(366004)(451199015)(38100700002)(6512007)(41300700001)(6506007)(4326008)(86362001)(103116003)(36756003)(107886003)(26005)(5660300002)(8936002)(54906003)(66946007)(110136005)(30864003)(478600001)(966005)(66476007)(66556008)(6486002)(15650500001)(8676002)(316002)(2616005)(186003)(1076003)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OLiznSeCvM2j9IyTsDA/lCheWD+hvqBiJXGAhdr78QIgFJBXHdAPdeqG6hql?=
 =?us-ascii?Q?O95wukV8oDdpI06iQCuBTvswtwU4ey9CpSl5r9KIy6m2K8A3Sab2aolxLsKs?=
 =?us-ascii?Q?Gpgm7ZCmIfA74HOVux9WFmu3l41AiNVDAYLYDhNiIqy2Ev9ARG3f0szhvEmA?=
 =?us-ascii?Q?hDeyov5Ixdu/5Kj+tnhtaHCM1uYsple4ElCoMiDONw9Z6WmKnJjuQkrSVjj3?=
 =?us-ascii?Q?A26Wf5ogOkDSy9Epc/NOZ7GQNSRwY3NlN2VOfpnaeKhHC4gaJTfJMtK/zyxf?=
 =?us-ascii?Q?hyurf4inRwjvuYIHve1KNg7qgXKyk366kQTiPMUhi3895hy46Y6oV0vhQ7aG?=
 =?us-ascii?Q?BxL5RH4I5OjIkCkQ20wavpiYASAlJCvqIT/sTtz1snoQ/qVYBE+Gw03hIsMK?=
 =?us-ascii?Q?00ydOAkSjoZUEFIdJqZqxqI83uxnZjPkSQThRjAeCYn6+EF9kwg14TL8SKXr?=
 =?us-ascii?Q?EYdyCA2hEoMIgVTBzO+PZh4iXnyaH1d7dENSBw+c1W4YsZpEwU52KI5r5+ta?=
 =?us-ascii?Q?dp1Psj0b3qyVnQspjHMpBfOMO97q/fyCwdozliBI8/3TLnnwH9hrtOU9YO/5?=
 =?us-ascii?Q?vfsLnvMqvq1zVxVYISw/rTtCHOHEBm+Dpc79OMepi3S0MrC81AudXNLZAQBL?=
 =?us-ascii?Q?cG31YE8ukGb9UkCGlEDkRpo+QhNWqj7S57NMkMTU5gVRz1LMmiR7LLYBvc5J?=
 =?us-ascii?Q?Ak4c22I6znoYT0zGPxhGl/SR/g4KkirhHVgpLCKCVzOKC9iw49Ad+qEI5IE1?=
 =?us-ascii?Q?hOiqHM2NiWBr3SktXpLEIvYm7K9qBThOOwE4ZmplsRvlX2gOAINGeF4bqYgm?=
 =?us-ascii?Q?3bvJlREJOjDKT28xT5EFVj7VO6WotDVANbMAgDm7s4Hw+FZQQ4bQVHbf0yka?=
 =?us-ascii?Q?cFZkjUWgZvEYunypndcE7TH+2WwbuauKzEym+1QP/jFd1XPd2Z/M46P+dYi8?=
 =?us-ascii?Q?qhaZFwWdu5/nmn5oqcsUYsMM3x+GFusAmKWZrhlctPypVVC/5C0n3PeSegKV?=
 =?us-ascii?Q?6bl9YnvdyWrmKBTcSXgR8uApWjhlK/skKAQtsg5mWYdnQswRiHUoCAxmjJgV?=
 =?us-ascii?Q?HgrMaM6g3aKD78Cl7KTKVPp+3CkRUdsPLArIz50A2M0CNFNbeqtRzGzKXly4?=
 =?us-ascii?Q?qIBwsDh89Bjzu79XkWaJs+qIlMKKVivBvfnUp/RRsxuECePo7Ckaaqq84eku?=
 =?us-ascii?Q?4ddB+rKnodDoVtm1vuL6o2SeAZgJF78gxFGq3pOm0VAWb5wsLAk/Y1BUNRnp?=
 =?us-ascii?Q?42W6Dehe/vb/LNZl5gOCHW6zzod7RWvAmrcjKKbiwE2bgj+6gimu+6jorLcL?=
 =?us-ascii?Q?uCQh/z8bjMXxQrqK3gdGWE81Tf0i/8GC47mGrOTEGMw4/0lsxfVTKY+pINrw?=
 =?us-ascii?Q?YOD3gyd3+yUQkN6aQgkIBI1+b15/cMMeXy7gp6ExtBKBHiVnjwf8N2lVsy7O?=
 =?us-ascii?Q?vBCUxr+6o9adLqXKcAjZDLApfE5ytAnlS3MnLec9z3Gm0rV+OfaVDTkCnJkQ?=
 =?us-ascii?Q?XyFpBBqKCxQxDo1I/gr2QKiPmHt8xr2/RYK55kAR5Sdg4eEiVkWe/UaNnFEO?=
 =?us-ascii?Q?H4njhiGrhtBH3avCg8sIoNbSunC40E+Y2+AZOyys/sTk3+iVfA5AoZSSElvx?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a95577-995b-4c09-dea4-08daad6a172a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 22:27:19.5357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAAPUtsWeIRdnJM2PbSez1739E63BOQ/imugPuUk0sMxbzYVtUMsLDFxbJM1ZWzBDNV5Q/wvYszhnlUttH/5SGoJmMbgoQ3JPD9QvdooBUo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4916
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210130124
X-Proofpoint-ORIG-GUID: dwxNxDDG6X_a3ZA6iKkk_6fkRC0BCglP
X-Proofpoint-GUID: dwxNxDDG6X_a3ZA6iKkk_6fkRC0BCglP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan, Amir, Al - this is a quite ugly patch but I want to discuss the idea
behind it, to see whether we can find something workable. I apologize for the
length of text here, but I think it's necessary to give full context and ideas.

For background, on machines with lots of memory and weird workloads,
__fsnotify_update_child_dentry_flags() has been a real thorn in our side. It
grabs a couple spinlocks and iterates over the whole d_subdirs list. If that
list is long, this can take a while. The list can be long due to lots of
negative dentries (which can easily number in the hundreds of millions if you
have a process that's relatively frequently looking up nonexisting files). But
the list can also be long due to *positive* dentries. I've seen directories with
~7 million positive dentry children falling victim to this function before (XFS
allows lots of files per dir)! Positive dentries take longer to process in this
function (since they're actually locked and written to), so you don't need as
many for them to be a problem.

Anyway, if you have a huge d_subdirs list, then you can have problems with soft
lockups. From my measurements with ftrace, 100 million negative dentries means
that the function takes about 6 seconds to complete (varies wildly by CPU and
kernel config/version). That's bad, but it can get *much worse*. Imagine that
there are many frequently accessed files in such a directory, and you have an
inotify watch. As soon as that watch is removed, the last fsnotify connector
goes away, and i_fsnotify_mask becomes 0. System calls accessing dentries still
see DCACHE_FSNOTIFY_PARENT_WATCHED, so they fall into __fsnotify_parent and will
try to update the dentry flags. In my experience, a thundering herd of CPUs race
to __fsnotify_update_child_dentry_flags(). The winner begins updating and the
rest spin waiting for the parent inode's i_lock. Many CPUs make it to that
point, and they *all* will proceed to iterate through d_subdirs, regardless of
how long the list is, even though only the first CPU needed to do it. So now
your 6 second spin gets multiplied by 5-10. And since the directory is
frequently accessed, all the dget/dputs from other CPUs will all spin for this
long time. This amounts to a nearly unusable system.

Previously I've tried to generally limit or manage the number of negative
dentries in the dcache, which as a general problem is very difficult to get
concensus on. I've also tried the patches to reorder dentries in d_subdirs so
negative dentries are at the end, which has some difficult issues interacting
with d_walk. Neither of those ideas would help for a directory full of positive
dentries either.

So I have two more narrowly scoped strategies to improve the situation. Both are
included in the hacky, awful patch below.

First, is to let __fsnotify_update_child_dentry_flags() sleep. This means nobody
is holding the spinlock for several seconds at a time. We can actually achieve
this via a cursor, the same way that simple_readdir() is implemented. I think
this might require moving the declaration of d_alloc_cursor() and maybe
exporting it. I had to #include fs/internal.h which is not ok.

On its own, that actually makes problems worse, because it allows several tasks
to update at the same time, and they're constantly locking/unlocking, which
makes contention worse.

So second is to add an inode flag saying that
__fsnotify_update_child_dentry_flags() is already in progress. This prevents
concurrent execution, and it allows the caller to skip updating since they know
it's being handled, so it eliminates the thundering herd problem.

The patch works great! It eliminates the chances of soft lockups and makes the
system responsive under those weird loads. But now, I know I've added a new
issue. Updating dentry flags is no longer atomic, and we've lost the guarantee
that after fsnotify_recalc_mask(), child dentries are all flagged when
necessary. It's possible that after __fsnotify_update_child_dentry_flags() will
skip executing since it sees it's already happening, and inotify_add_watch()
would return without the watch being fully ready.

I think the approach can still be salvaged, we just need a way to resolve this.
EG a wait queue or mutex in the connector would allow us to preserve the
guarantee that the child dentries are flagged when necessary. But I know that's
a big addition, so I wanted to get some feedback from you as the maintainers. Is
the strategy here stupid? Am I missing an easier option? Is some added
synchronization in the connector workable?

Thanks!
Stephen

---

You may find it useful to create negative dentries with [1] while using this
patch. Create 100 million dentries as follows. Then use [2] to create userspace
load that's accessing files in the same directory. Finally, inotifywait will
setup a watch, terminate after one event, and tear it down. Without the patch,
the thundering herd of userspace tasks all line up to update the flags, and
lockup the system.

  ./negdentcreate -p /tmp/dir -c 100000000 -t 4
  touch /tmp/dir/file{1..10}
  for i in {1..10}; do ./openclose /tmp/dir/file$i & done
  inotifywait /tmp/dir

[1] https://github.com/brenns10/kernel_stuff/tree/master/negdentcreate
[2] https://github.com/brenns10/kernel_stuff/tree/master/openclose

 fs/notify/fsnotify.c | 96 ++++++++++++++++++++++++++++++++++----------
 include/linux/fs.h   |  4 ++
 2 files changed, 78 insertions(+), 22 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 7974e91ffe13..d74949c01a29 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -13,6 +13,7 @@
 
 #include <linux/fsnotify_backend.h>
 #include "fsnotify.h"
+#include "../internal.h"
 
 /*
  * Clear all of the marks on an inode when it is being evicted from core
@@ -102,42 +103,93 @@ void fsnotify_sb_delete(struct super_block *sb)
  * on a child we run all of our children and set a dentry flag saying that the
  * parent cares.  Thus when an event happens on a child it can quickly tell
  * if there is a need to find a parent and send the event to the parent.
+ *
+ * Some directories may contain too many entries, making iterating through the
+ * parent list slow enough to cause soft lockups. So, we use a cursor -- just as
+ * simple_readdir() does -- which allows us to drop the locks, sleep, and pick
+ * up where we left off. To maintain mutual exclusion we set an inode state
+ * flag.
  */
 void __fsnotify_update_child_dentry_flags(struct inode *inode)
 {
-	struct dentry *alias;
-	int watched;
+	struct dentry *alias, *child, *cursor = NULL;
+	const int BATCH_SIZE = 50000;
+	int watched, prev_watched, batch_remaining = BATCH_SIZE;
+	struct list_head *p;
 
 	if (!S_ISDIR(inode->i_mode))
 		return;
 
-	/* determine if the children should tell inode about their events */
-	watched = fsnotify_inode_watches_children(inode);
+	/* Do a quick check while inode is unlocked. This avoids unnecessary
+	 * contention on i_lock.  */
+	if (inode->i_state & I_FSNOTIFY_UPDATING)
+		return;
 
 	spin_lock(&inode->i_lock);
+
+	if (inode->i_state & I_FSNOTIFY_UPDATING) {
+		spin_unlock(&inode->i_lock);
+		return;
+	} else {
+		inode->i_state |= I_FSNOTIFY_UPDATING;
+	}
+
 	/* run all of the dentries associated with this inode.  Since this is a
-	 * directory, there damn well better only be one item on this list */
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
-		struct dentry *child;
-
-		/* run all of the children of the original inode and fix their
-		 * d_flags to indicate parental interest (their parent is the
-		 * original inode) */
-		spin_lock(&alias->d_lock);
-		list_for_each_entry(child, &alias->d_subdirs, d_child) {
-			if (!child->d_inode)
-				continue;
+	 * directory, there damn well better be exactly one item on this list */
+	BUG_ON(!inode->i_dentry.first);
+	BUG_ON(inode->i_dentry.first->next);
+	alias = container_of(inode->i_dentry.first, struct dentry, d_u.d_alias);
+
+	cursor = d_alloc_cursor(alias);
+	if (!cursor) {
+		inode->i_state &= ~I_FSNOTIFY_UPDATING;
+		spin_unlock(&inode->i_lock);
+		return; // TODO -ENOMEM
+	}
 
-			spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
-			if (watched)
-				child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
-			else
-				child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
-			spin_unlock(&child->d_lock);
+	/* determine if the children should tell inode about their events */
+	watched = fsnotify_inode_watches_children(inode);
+	spin_lock(&alias->d_lock);
+	p = alias->d_subdirs.next;
+
+	while (p != &alias->d_subdirs) {
+		if (batch_remaining-- <= 0 && need_resched()) {
+			batch_remaining = BATCH_SIZE;
+			list_move(&cursor->d_child, p);
+			p = &cursor->d_child;
+			spin_unlock(&alias->d_lock);
+			spin_unlock(&inode->i_lock);
+			cond_resched();
+			spin_lock(&inode->i_lock);
+			spin_lock(&alias->d_lock);
+			prev_watched = watched;
+			watched = fsnotify_inode_watches_children(inode);
+			if (watched != prev_watched) {
+				/* Somebody else is messing with the flags,
+				 * bail and let them handle it. */
+				goto out;
+			}
+			/* TODO: is it possible that i_dentry list is changed? */
 		}
-		spin_unlock(&alias->d_lock);
+		child = list_entry(p, struct dentry, d_child);
+		p = p->next;
+
+		if (!child->d_inode || child->d_flags & DCACHE_DENTRY_CURSOR)
+			continue;
+
+		spin_lock_nested(&child->d_lock, DENTRY_D_LOCK_NESTED);
+		if (watched)
+			child->d_flags |= DCACHE_FSNOTIFY_PARENT_WATCHED;
+		else
+			child->d_flags &= ~DCACHE_FSNOTIFY_PARENT_WATCHED;
+		spin_unlock(&child->d_lock);
 	}
+
+out:
+	inode->i_state &= ~I_FSNOTIFY_UPDATING;
+	spin_unlock(&alias->d_lock);
 	spin_unlock(&inode->i_lock);
+	dput(cursor);
 }
 
 /* Are inode/sb/mount interested in parent and name info with this event? */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e654435f1651..f66aab9f792a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2433,6 +2433,9 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
  *
  * I_PINNING_FSCACHE_WB	Inode is pinning an fscache object for writeback.
  *
+ * I_FSNOTIFY_UPDATING	Used by fsnotify to avoid duplicated work when updating
+ * 			child dentry flag DCACHE_FSNOTIFY_PARENT_WATCHED.
+ *
  * Q: What is the difference between I_WILL_FREE and I_FREEING?
  */
 #define I_DIRTY_SYNC		(1 << 0)
@@ -2456,6 +2459,7 @@ static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 #define I_DONTCACHE		(1 << 16)
 #define I_SYNC_QUEUED		(1 << 17)
 #define I_PINNING_FSCACHE_WB	(1 << 18)
+#define I_FSNOTIFY_UPDATING	(1 << 19)
 
 #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
 #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
-- 
2.34.1

