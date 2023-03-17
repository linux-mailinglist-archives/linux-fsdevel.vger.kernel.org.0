Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0106F6BE0A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Mar 2023 06:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCQFbl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Mar 2023 01:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjCQFbj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Mar 2023 01:31:39 -0400
Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59424B6D30
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 22:31:38 -0700 (PDT)
Received: from pps.filterd (m0167068.ppops.net [127.0.0.1])
        by mx0a-00364e01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H4I4gk026354
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 01:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=mime-version : from
 : date : message-id : subject : to : content-type; s=pps01;
 bh=IxkmKhaJDEi9pHOd6bV7QzpeZvgtsPK67wGFrUhFWBI=;
 b=AnOLjsXM287ajpCtjKDnNVauqi2xZr5VWDQtIwq+QN+MZXbzqQfBMR4qMm+6JmYETAHn
 MZiynj7H1YIOaZkQ4RjdvxO3nuNYcyduXhau5W5aeJSCn5EkH2Vmp1voeo1KPvJKcmOH
 9dq2yUARqAKjGlCvK33BBBzgIFsXLne8TcC4pymahcZigajuYtcddbMSZhvzVlbTnrF2
 4YRhmzXa9J8ySb2zWzo22C2EWyaVgwqbG5OdYngyS8RKOMBUEdXeaMsSNMgEmnQfvY4W
 I+jCzcwgGTj6O9aPLYQ+RhdYwXNPO8MTwmhaQuOH7rTHTJiLTFc4V/m8puDlYxZRc+h0 Ew== 
Received: from sendprdmail22.cc.columbia.edu (sendprdmail22.cc.columbia.edu [128.59.72.24])
        by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 3pcbr3spum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 01:31:37 -0400
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
        by sendprdmail22.cc.columbia.edu (8.14.7/8.14.4) with ESMTP id 32H5VaDv092089
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Mar 2023 01:31:36 -0400
Received: by mail-pl1-f200.google.com with SMTP id bh9-20020a170902a98900b0019e506b80d0so2186533plb.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Mar 2023 22:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679031096;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IxkmKhaJDEi9pHOd6bV7QzpeZvgtsPK67wGFrUhFWBI=;
        b=XxJ2e/lwHhl4oJCreyrICp8MVll1/wqj7y4GMQ+62Juwo4QvcLL42PlRyJumnOkC5j
         0UeOlaAlXDr9VSwSpQHL1mSwKWRhpcFFlu22RYcXOCdJaJNnCZjqnhR4zzkD9INqoSe6
         +2q7OUCbdRvqROHfnFEzm2pCWhF/E8gppTyMvv72tqpiGrEugzfpZn9kSlbLf90xNTo5
         xteqkokNKnVzf3eHtKEjfrSzaQ8RGfYeunaij5qBCCZ/+D0mL4RCz3jAhqZVGMf2tqaW
         POWDVvklcFi6ziLl6NYRCX3RpC4Edmo3D9YJAUIKVB50+I5UA7gwBXGXrrzpWHT/4jQb
         DGQg==
X-Gm-Message-State: AO0yUKVM4yJn5WDH1bN4mFeo2iDGAa6R9TOWplJmAH9L8xaJ6lWPmoJZ
        JztuDrdXIE/3zqaQbv9TgIkpCx86P5Gd+UnbzX+wyebxJTwDYUzXHO5XrN3oD2vpz3JvAXo+P9U
        fJ4eNaGcwHRHFwRUuY6JvNcsd4tp7qBQI2/7zkxKWnhAew9AEnyxvM8zW6Fkl
X-Received: by 2002:a65:618c:0:b0:503:2663:5c9f with SMTP id c12-20020a65618c000000b0050326635c9fmr1568859pgv.8.1679031095824;
        Thu, 16 Mar 2023 22:31:35 -0700 (PDT)
X-Google-Smtp-Source: AK7set96M+x+xD9aoWRz9J1lkhziz9wjtMqVFmT6b0+cGdAdBUyMzY98ZvoJl3shEuqzXnB8vG+9BfMUBcEr+m7u5Os=
X-Received: by 2002:a65:618c:0:b0:503:2663:5c9f with SMTP id
 c12-20020a65618c000000b0050326635c9fmr1568855pgv.8.1679031095555; Thu, 16 Mar
 2023 22:31:35 -0700 (PDT)
MIME-Version: 1.0
From:   Ioannis Zarkadas <iz2175@columbia.edu>
Date:   Fri, 17 Mar 2023 01:31:24 -0400
Message-ID: <CADjSRtSFavkO4W7wbWiqmiyef82NZ=33e7rx=yGWt+ja830TPQ@mail.gmail.com>
Subject: fsnotify: Question on proper use
To:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-ORIG-GUID: k2yWIRJiHQYyU1rkMjDYCJWavWStzkl-
X-Proofpoint-GUID: k2yWIRJiHQYyU1rkMjDYCJWavWStzkl-
X-CU-OB: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_02,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=10 phishscore=0
 clxscore=1015 mlxlogscore=477 impostorscore=10 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=10 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170032
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi everyone!

I'm developing a kernel module and trying to setup a directory watch
with fsnotify.
I mainly copied existing code paths in the kernel that I found,
because I couldn't
find any usage documentation.

My issue is the following:
- Setting up the watch works initially.
- If I remove and reinsert the kernel module, fsnotify_add_inode_mark
fails with EEXIST.

So I must be doing something wrong. I am using the put/destroy methods
for the mark
and the put method for the group when unloading the module.

Here is how I setup the watch:

> static struct fsnotify_group *group;
> static struct fsnotify_mark mark;
>
> static int setup_sync_dir_watch(char *sync_dir) {
>     int ret;
>     struct fsnotify_mark *old_mark;
>     struct path sync_dir_path;
>
>     pr_info("%s: Syncing extents for files under '%s'\n", MODULE_NAME,
>             sync_dir);
>
>     group = fsnotify_alloc_group(&nvmeof_xrp_fsnotify_ops);
>     if (IS_ERR(group)) {
>         pr_err("%s: Error allocating fsnotify group!\n", MODULE_NAME);
>         return -1;
>     }
>     ret = kern_path(sync_dir, LOOKUP_FOLLOW, &sync_dir_path);
>     if (ret) {
>         pr_err("%s: Error getting kernel path: %d!\n", MODULE_NAME, ret);
>         goto release_group;
>     }
>     fsnotify_init_mark(&mark, group);
>     mark.mask = FS_CREATE | FS_DELETE | FS_MODIFY |
>                                  FS_CLOSE_WRITE | FS_EVENT_ON_CHILD;
>     ret = fsnotify_add_inode_mark(&mark,
>                                   sync_dir_path.dentry->d_inode, 0);
>     path_put(&sync_dir_path);
>     if (ret) {
>         pr_err("%s: Error adding fsnotify mark! Error code: %d\n", MODULE_NAME,
>                ret);
>         goto release_mark;
>     }
>     return 0;
> release_mark:
>     fsnotify_destroy_mark(&mark, group);
>     fsnotify_put_mark(&mark);
> release_group:
>     fsnotify_put_group(group);
>     return ret;
> }

And here is how I clear it when exiting the module:

> static void __exit module_exit(void) {
>     fsnotify_destroy_mark(&mark, group);
>     fsnotify_put_mark(&mark);
>     fsnotify_put_group(group);

I also tried to find the mark and delete it, but it returns NULL even though
fsnotify_add_inode_mark returns EEXISTS:

> mutex_lock(&group->mark_mutex);
> old_mark = fsnotify_find_mark(
>     &sync_dir_path.dentry->d_inode->i_fsnotify_marks,
>     group);
> if (old_mark != NULL) {
>     pr_info("%s: Found old mark, destroying it...\n", MODULE_NAME);
>     fsnotify_destroy_mark(old_mark, group);
>     fsnotify_put_mark(old_mark);
> }
> mutex_unlock(&group->mark_mutex);

Thanks in advance,
Yannis
