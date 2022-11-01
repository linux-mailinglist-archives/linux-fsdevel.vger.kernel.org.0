Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B7961543B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 22:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiKAV0C (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 17:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiKAV0A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 17:26:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E002D1D67D;
        Tue,  1 Nov 2022 14:25:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KnPS9018757;
        Tue, 1 Nov 2022 21:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=It7IPuJMyIqLwFR4SmczYzJOvcne7+qI99C14ZMH7fM=;
 b=nSVPtXeNBRGhwOIoU8Rc7MSHZdnP8O+ppokvmOkkQv4tpz47Z7jkeD/6uEmyaLLKcZRy
 3+9GYPRZJp5YsQR+P4ZopiTk8k9lfbB2jAkC7TSclYELTRcoPYmRkGkdf6XSx93v7+No
 +XCfgjvuu8P0BjWrTej68mai2RhneQOPc7b1TUJkmYbUbW6lthk2eboG/o0bVG1O9CIk
 TN4mOv+Bqk7cMwaRHKdOUJMsfBHMLKmoPfK7i95FMjIhe7xUSD7P89R3e7rtyhi4qQLa
 EyG1JIef7YfO7cc1lO713WbHzXQ8QqYz2diU3bTit1gJvyLL+VFSWkxjX4OEylI151nH ow== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgts181u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:25:55 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1KYrSo014335;
        Tue, 1 Nov 2022 21:25:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmaww6q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Nov 2022 21:25:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCOMj2ENKQXJ+hulKBvvTrSOE4//HISODPx+g4b+mjhOybBjvENhUQybC4leyVN0ow1EP0EdRMr1nYTyGXCtFrEDlF4yteq1+zm67NBAmXVzWP5JzOJd5gSkAxK4u/oB0y3AsTmYRB9f+y7PFntScLnlH3p2xgzJOOC9hjhLg80T4lgvMxIfW5BJihvUp5m7M/QW8yt7EeGDuy+/zKZz4/3CNgsxUvrE0TuM3xlW65eFk2yPkMO0pOCTBorbnARNl1khd81ht77uRh3cdLIh2nh164hkVLaBmDtsQIArd+mTp2rGq2OyHyiiEaqoOlsjY/ySQwPZSopCrHVTcMiToA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=It7IPuJMyIqLwFR4SmczYzJOvcne7+qI99C14ZMH7fM=;
 b=fAdiHFj09Z6WWQ0Tu/fbGFvxuNrin7nv8zix6bcmFiXo6qO85BfgoUfZZks2vAOQMtEGuvEODW9JsSDVFq9VQyuThZdwAVg2ScRzC3a16HZidehK4X6Jeow/nEs3TALdcf8kbEYnr0OgDIx6Voc8L8kUZS2nEGFVZIjPq0Fqg1hmVWUAQZgqm4lnxMqebjdnzM7XVFW8l9TULXKezI2JrGcSiMi0t7FV7r0RaCaKuN/t9J2AwkOTQjdtBv1GxpYpzcddYTXBWmJVlOAoz2bT1Wl4rytm96VqwEOPC+WiCKc3KXJnopZUzqF8//l1XSSrE4VoEO7sY46X4vsFuomgIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=It7IPuJMyIqLwFR4SmczYzJOvcne7+qI99C14ZMH7fM=;
 b=Ih8dJuIGoMwi3VwG1neAluLbEvEz6VGvlgKg5kdLH5FIEYXvISifQsrOsa/uxs7BM/2eXD/tSVrhpBlXJPkqw71lATW8U74lNIELSrGq8K9BIsGgZtqFf4qiU8Oe1or7IGLnIdHmjz1AJoFDtgb/WvJHSCxUuI53GFPYZ/W9ryM=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by PH7PR10MB6483.namprd10.prod.outlook.com (2603:10b6:510:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Tue, 1 Nov
 2022 21:25:52 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 21:25:52 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3 3/3] fsnotify: allow sleepable child flag update
In-Reply-To: <CAOQ4uxh8c2vbv50p8+rNnoV0H=L=+XRGuFP1dmGrrCrt6EjFYQ@mail.gmail.com>
References: <20221021010310.29521-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-1-stephen.s.brennan@oracle.com>
 <20221028001016.332663-4-stephen.s.brennan@oracle.com>
 <CAOQ4uxh8c2vbv50p8+rNnoV0H=L=+XRGuFP1dmGrrCrt6EjFYQ@mail.gmail.com>
Date:   Tue, 01 Nov 2022 14:25:50 -0700
Message-ID: <874jvigye9.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:a03:54::47) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|PH7PR10MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: c8dde24d-ead2-4d03-ff18-08dabc4fa716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0rSxXunG4J++dBLdJk3zhf+SEtxPmg3r2SWV8tn+SIrkCYoexr6dc6CNH0lo8xuoe7rHyA5FbcytLecQ53/vZPP3uNuTO0A0cjJ9bdGm98zqnZuBJ8ehUnxtfDVIBjW6ngdVpfm23X8BLi3hI4jrCpoHZynXdangAkW9Tid8D56sYUWWGg9Zz2KVgfv9R+hv8wfk24uD0nAglV5y1/PBgXPAeiNWrw+S3blJ8caRbVN2Z9YL/iNUC4PFv0KCjFFQzKp9amrO2N+QDJhbz6+m/2bSjXttu9gnWGctY+csoRnJYzXyLgcEAA8EqaKDaCZCW4PIdJXR6BplDkB+7VMK7DmPK0QCx6HObiHZN9ECTTQCE3gX3tV11DbQ0NyUFH/1Hi9hjZFR7b+Sy42clPTEs5ZAYwi+lYSjNHWnZI1AroWQJl4X5EWMTBiHTgojArT/ed2SSMJ2Gk/1/va5oEPp/wxrG1YWwbtLG+Q1Pkt91YtcWkxoGrdaNcHXW+u95m//Ij26tpSWAatN+fpkBj1Z71LNfCnypBpQ9bt8hpSf80Z2jg8C07sf1jA2iYnsOFyuntabHjAcOH+bTRj/XcxKhh5ZGT2odv/0rcbGvWJZ4n9vsGZuFRcwi7nzEBos3KEvbqsLzrPgR52jSyVZhAAZKEhOkOovOL79D2B1M9ZbQctBSz6GTOfmrG8qOpLCUWl6Piyx89NQRiJNB2L1O1123Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(376002)(366004)(451199015)(83380400001)(86362001)(8936002)(5660300002)(186003)(36756003)(15650500001)(2906002)(2616005)(38100700002)(478600001)(316002)(54906003)(4326008)(41300700001)(6916009)(66946007)(53546011)(6506007)(66556008)(6512007)(66476007)(8676002)(26005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a7wrBZTQC1f28Fl8ue1hKYGVxlYkUl0tWqYWRrf4X3LDHBuPM4Wa+G9tmyq8?=
 =?us-ascii?Q?h+VDbNbx/9c3cJMiIpHodHTZ69/GIF42ZImMykv6sStc09te1VDYAr+Oog9P?=
 =?us-ascii?Q?qvE34sTSHfzoXBHr8NyV64S5xApizMOF0v+EPTkFdFO1jOqpX+vXqHAuo2BO?=
 =?us-ascii?Q?lNiZa2XJn/nMRg2b2I6ACNANqhcXdmxdS6pz2zoBWIQwK57pD6eKz9q5pE84?=
 =?us-ascii?Q?WmL98R63PJNmUkctH14sJ7EFctJNTMac0Igdst/tjtfdrvYzT+vn9EJkmCr5?=
 =?us-ascii?Q?Q+mNT7o5yPslEkwIouF/4Erp50l1D+e3RTOsNB/ldo8wMpcrxflcvmW6HDdS?=
 =?us-ascii?Q?frlp3BlmMYT1Cix2PEdlBSjUwPOjRl2TCqQ9qwid7PEI3ctxvJb2lQBtA0Q7?=
 =?us-ascii?Q?wW+soBbN1x4UjfxbH0AOUM8kOB1sXN+HtrTHl7XFM0+yRoDB3J72ggg6OFGl?=
 =?us-ascii?Q?AQPePtoacKsv++XiqV5j//KFEv3l7t3N0xOrBC/m9kQ3WCyoEMbd3TVeeYUo?=
 =?us-ascii?Q?f4RayEA+LuF0aAKG1lWSFh+HJ3ErRCiEWIqf7OPf1cn7/dhksMU06cv6rlD9?=
 =?us-ascii?Q?GS5XkYn+h4wzgPPiCuJ7BwZ2VHovuk9e5Logn61YloI9wKTLGwR5uUDd5Ch2?=
 =?us-ascii?Q?NBmKzdN+ZDXZ+9lA9gIkq81vb2rWFA9rDJibVPYfqpb+3qZhq9hGPNVOKODG?=
 =?us-ascii?Q?bc4Ij+pG5jFCelsJ3mODxhwAP2XyUBAI1awLlLfOipeAU0R6FTxKfdfv+Pwv?=
 =?us-ascii?Q?1Ho1js4cOLUYBxea4oPH2BBA+8AJkqy+lvS0fiCdD8D7sE/DxI7Kr38VVRJ+?=
 =?us-ascii?Q?aRoCoNBAq6zUw3XLMrQgn9tdBj3LGi9z2AQKs1oyUVNTjI6jtIF1MiEm31Rg?=
 =?us-ascii?Q?f9hxbJYdjnZY6CsyFyBoU9rW1jPSu/saBWkj8XMmC0s3EIN7loc5JDdI3ZHB?=
 =?us-ascii?Q?Mz/r/vRT+sagN7Aix513C8JYDN0WY2fnkRHXnniZcFWolxbHEwQ3tD9HlVDA?=
 =?us-ascii?Q?VXcDhpaf4tFCpo/sThaP9nIPMysBwb/9PWqTXx96hljcPRpJPA0LgSYBwdTz?=
 =?us-ascii?Q?f+kGPrLUQLj7Es3iQdMQ4AmFXQfsUxq19/LNbJi4wNtA1+svxYBw/yFeKxV1?=
 =?us-ascii?Q?9canfI9VUx3ABm0eG/yas3VDSd8/J3kPiI2sdkk7Md0Xh56atmj96iw2wamT?=
 =?us-ascii?Q?gW91dS83Ba6LaK8Sm2V7OD4XULgXaobXnxNd+BDzvWGMI1alrmyE2rEmX6qZ?=
 =?us-ascii?Q?s7QeAEE55n0GPNNaSzFPFpYArSj3P+sZHL80CuPpXvJl4TLKlNLOakaA/Upc?=
 =?us-ascii?Q?92ScrnsosGYBRumwfZfFKnEnQXMDr7Ogk9cZp2V8dzJ0PyChkmkO3tDd/GsD?=
 =?us-ascii?Q?1oXHo31OLwlheOSH5LWNWiwZyG3qQeJA5XLcc41tk0C2cSaYrbAkBK+bYu8+?=
 =?us-ascii?Q?FSCR/0d5vAdzbQs2ktPuLqsO4fsPXEZfQ+rMMdwcd2xTjCM2BMm2m7TMdJ/V?=
 =?us-ascii?Q?IoGgLlrw8GEFOTgsbhZn33fTeOhy8f7lYAA0221heC9ryPSI6EuUkngL+eo7?=
 =?us-ascii?Q?qOUvUUm7rxr3LecmvBh3sGxbCpKdeaQzsQVi88KI7YWPEYzr6ztFqW8cyjVW?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8dde24d-ead2-4d03-ff18-08dabc4fa716
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 21:25:52.0274
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WC54Q7E/SjKPlvvwJN8F4c1U/kXnxEz+Q4L7EnkU3sCuoOX6My+tS7J3MGdQ4gB0UIaPFievv5YIswSmAQpXr1Omp2dSQZcoIM4SyatCvA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_10,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211010148
X-Proofpoint-GUID: 8-bl_W03Cp4ZPHoEriM7w825eyI61x28
X-Proofpoint-ORIG-GUID: 8-bl_W03Cp4ZPHoEriM7w825eyI61x28
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

> On Fri, Oct 28, 2022 at 3:10 AM Stephen Brennan
> <stephen.s.brennan@oracle.com> wrote:
>>
>> With very large d_subdirs lists, iteration can take a long time. Since
>> iteration needs to hold parent->d_lock, this can trigger soft lockups.
>> It would be best to make this iteration sleepable. Since we have the
>> inode locked exclusive, we can drop the parent->d_lock and sleep,
>> holding a reference to a child dentry, and continue iteration once we
>> wake.
>>
>> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
>> ---
>>
>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
>
> some comment nits and one fortify suggestion
>
>> Notes:
>>     v3:
>>     - removed if statements around dput()
>>     v2:
>>     - added a check for child->d_parent != alias and retry logic
>>
>>  fs/notify/fsnotify.c | 36 ++++++++++++++++++++++++++++++++----
>>  1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
>> index ccb8a3a6c522..34e5d18235a7 100644
>> --- a/fs/notify/fsnotify.c
>> +++ b/fs/notify/fsnotify.c
>> @@ -102,10 +102,12 @@ void fsnotify_sb_delete(struct super_block *sb)
>>   * on a child we run all of our children and set a dentry flag saying that the
>>   * parent cares.  Thus when an event happens on a child it can quickly tell
>>   * if there is a need to find a parent and send the event to the parent.
>> + *
>> + * Context: inode locked exclusive
>>   */
>>  static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
>>  {
>> -       struct dentry *alias, *child;
>> +       struct dentry *child, *alias, *last_ref = NULL;
>>         int watched;
>>
>>         if (!S_ISDIR(inode->i_mode))
>> @@ -120,12 +122,37 @@ static bool __fsnotify_update_children_dentry_flags(struct inode *inode)
>>         alias = d_find_any_alias(inode);
>>
>>         /*
>> -        * run all of the children of the original inode and fix their
>> -        * d_flags to indicate parental interest (their parent is the
>> -        * original inode)
>> +        * These lists can get very long, so we may need to sleep during
>> +        * iteration. Normally this would be impossible without a cursor,
>> +        * but since we have the inode locked exclusive, we're guaranteed
>> +        * that the directory won't be modified, so whichever dentry we
>> +        * pick to sleep on won't get moved. So, start a manual iteration
>> +        * over d_subdirs which will allow us to sleep.
>>          */
>>         spin_lock(&alias->d_lock);
>> +retry:
>>         list_for_each_entry(child, &alias->d_subdirs, d_child) {
>> +               if (need_resched()) {
>> +                       /*
>> +                        * We need to hold a reference while we sleep. But when
>> +                        * we wake, dput() could free the dentry, invalidating
>> +                        * the list pointers. We can't look at the list pointers
>> +                        * until we re-lock the parent, and we can't dput() once
>> +                        * we have the parent locked. So the solution is to hold
>> +                        * onto our reference and free it the *next* time we drop
>> +                        * alias->d_lock: either at the end of the function, or
>> +                        * at the time of the next sleep.
>> +                        */
>
> My personal preference would be to move this above if (needed_reschd())
> it is not any less clear when this comment is above the condition
> and less indented will read nicer.

Definitely.

>> +                       dget(child);
>> +                       spin_unlock(&alias->d_lock);
>> +                       dput(last_ref);
>> +                       last_ref = child;
>> +                       cond_resched();
>> +                       spin_lock(&alias->d_lock);
>> +                       if (child->d_parent != alias)
>> +                               goto retry;
>
> Is this expected? If not, then we need a WARN_ON_ONCE().
> Also, I wonder if it would be better to break out and leave
> dentry flags as they are instead of risking some endless
> or very long retry loop?
>
> And how about asserting on unexpected !list_empty(&child->d_child)
> to avoid an endless loop in list_for_each_entry()?

I was trying to think this through as I prepared v3, and ended I up
leaving it as-is, out of a hope that it was doing something helpful. But
I'm pretty sure Al would ask why I believe that this could happen (e.g.
what scenario am I guarding against happening?). I didn't have a clear
idea of what I was guarding against here when I wrote it, which is my
fault. What's necessary is an audit of the places where d_child is
modified, so we can understand the risky places.

What we're doing here is dropping parent->d_lock and going to sleep,
while still having parent->d_inode->i_rwsem held in write mode. The risk
we have is that this particular dentry is removed from this list while
we slept. Checking d_parent seems particularly unhelpful for that, since
what we care far more about is the d_child list pointers. I did a code
audit of all locations where d_child is modified. Here's all I could
identify:

1. dentry_unlist() in fs/dcache.c
2. __d_move() in fs/dcache.c
3. Initialization code in d_alloc() family
4. Cursor code in fs/libfs.c for dcache_readdir()

For case #1, dentry_unlist() is a helper of dentry_kill(). The real guts
of dentry_kill() must happen with parent->d_lock held. Since we get a
reference to the child with parent->d_lock held, we can be confident
that any dentry_kill() which could have been happening concurrently will
bail out after seeing that we got a reference. At least, that's my
reading of the code.

For case #2, __d_move() can (should?) NOT happen, because the caller
must hold the i_mutex (read i_rwsem in write mode), but we are holding
that ourselves.

For case #3, it doesn't matter... it's initialization time, and we
couldn't have gotten a reference to the dentry until the dentry is put
into the tree.

For case #4, the simple_readdir() code should hold the inode rwsem in
read mode, so we have mutual exclusion from this code too. While it's
possible that we could go to sleep holding a reference to a cursor, I
believe that the cursor could not move without holding i_rwsem in read
mode. So we could never wake up to find we've skipped part of the list.

So to summarize, I don't think there's a case where we could actually
expect that d_child pointers get updated while we sleep with a reference
held and the parent i_rwsem held exclusive. Consequently, no place where
d_parent would change from under our feet. So I will remove this check
form the patch.

Thanks,
Stephen
