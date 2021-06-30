Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AEA3B7F1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Jun 2021 10:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbhF3IiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Jun 2021 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhF3IiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Jun 2021 04:38:13 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A3C061756;
        Wed, 30 Jun 2021 01:35:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id f21so2137846ioh.13;
        Wed, 30 Jun 2021 01:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPbWk5UKVeREy6p3FQJYiNWU+dTvbeJlZPzW911zzKs=;
        b=aVrBE5C4MbAgG0OPgurWIQPM6RIGoe8EB7ZztkOv7m1HNU5bfiZt68yWiP5sAKG/Ei
         z5Zefyz8ibuh3Fb/TovlAV/gJj38/lphWEkG0F9EoUEIpNU5z0mYUuV3PMkNA1fX9EZD
         hN4nUQEgZk8HUQI4Op8T8Kpto1t3569/JRSgymPyupN3xbS50X5F1AGRgMKyP7bW6efm
         cYx9ToY2C8s3k1A8nG6/1g7d2wMHWnCmkY8gJPyqKIIKdtGAJEsBzPJbO0tv7XRFG3j8
         6HqPPKTx5kafxboG5cyM3DqdqrhtdDO8gkWiU+Z9U9p3mwrUKAdI2nBj84Ly4BFw/F+R
         rVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPbWk5UKVeREy6p3FQJYiNWU+dTvbeJlZPzW911zzKs=;
        b=axEu47bkmj9yRnZ+yOGE1DMt8Y+ESIE5xWT5ptMFag48vtc/0tg3KpDsoj1bH48M0u
         /kwXXD4NWhcTYpQCpVEmYy4r7Kz0Zft9CLASdfawLfeGynB7i9PwCtTlMIUUI+OebmKX
         RwaTqr6bQJxP+EeEVQUUEhEKmNM72MfpkbDX+wRXRdggojMxRx/oIPq20DNJ1eIScqE/
         tubkh901/JBMmV1acqUoos5l/OrBDK1XLXZY65iZMC4lNr3UQfu24IDCA+I0PS46Ppj+
         rW4slXoa2D/kmUarnvUxs0UYKICh7S89k6W4uM3meFR2PtNyLZ/LA3wM3pAPnQeJFbcf
         +48Q==
X-Gm-Message-State: AOAM533yQ/7C/fQKuDMGtu9r1ce5nJLX7pXLyqHRp655Vj2TWS7bRi0p
        rVb1wnMJN9SMqKUEv67PhpCZl3WjeEqNt0dFn+c=
X-Google-Smtp-Source: ABdhPJyYgQHI7Bvm42cDSpXF+NmlRZoCgKzoo54LXANxmDl5AMYlsFrQocjfwz/WmVq201Qitgvvf9RZhQ+rxDQpgxQ=
X-Received: by 2002:a5d:8b03:: with SMTP id k3mr6914843ion.203.1625042143695;
 Wed, 30 Jun 2021 01:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210629191035.681913-8-krisman@collabora.com> <202106300707.Xg0LaEwy-lkp@intel.com>
In-Reply-To: <202106300707.Xg0LaEwy-lkp@intel.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jun 2021 11:35:32 +0300
Message-ID: <CAOQ4uxgRbpzo-AvvBxLQ5ARdFuX53RG+JpPOG8CDoEM2MdsWQQ@mail.gmail.com>
Subject: Re: [PATCH v3 07/15] fsnotify: pass arguments of fsnotify() in struct fsnotify_event_info
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        "Darrick J. Wong" <djwong@kernel.org>,
        Theodore Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 30, 2021 at 11:12 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi Gabriel,
>
> url:    https://github.com/0day-ci/linux/commits/Gabriel-Krisman-Bertazi/File-system-wide-monitoring/20210630-031347
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> config: x86_64-randconfig-m001-20210628 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> fs/notify/fsnotify.c:505 __fsnotify() warn: variable dereferenced before check 'inode' (see line 494)
>
> vim +/inode +505 fs/notify/fsnotify.c
>
> dca640915c7b84 Amir Goldstein         2021-06-29  470  int __fsnotify(__u32 mask, const struct fsnotify_event_info *event_info)
> 90586523eb4b34 Eric Paris             2009-05-21  471  {
> dca640915c7b84 Amir Goldstein         2021-06-29  472   const struct path *path = fsnotify_event_info_path(event_info);
> dca640915c7b84 Amir Goldstein         2021-06-29  473   struct inode *inode = event_info->inode;
> 3427ce71554123 Miklos Szeredi         2017-10-30  474   struct fsnotify_iter_info iter_info = {};
> 40a100d3adc1ad Amir Goldstein         2020-07-22  475   struct super_block *sb;
> 60f7ed8c7c4d06 Amir Goldstein         2018-09-01  476   struct mount *mnt = NULL;
> fecc4559780d52 Amir Goldstein         2020-12-02  477   struct inode *parent = NULL;
> 9385a84d7e1f65 Jan Kara               2016-11-10  478   int ret = 0;
> 71d734103edfa2 Mel Gorman             2020-07-08  479   __u32 test_mask, marks_mask;
> 90586523eb4b34 Eric Paris             2009-05-21  480
> 71d734103edfa2 Mel Gorman             2020-07-08  481   if (path)
> aa93bdc5500cc9 Amir Goldstein         2020-03-19  482           mnt = real_mount(path->mnt);
> 3a9fb89f4cd04c Eric Paris             2009-12-17  483
> 40a100d3adc1ad Amir Goldstein         2020-07-22  484   if (!inode) {
> 40a100d3adc1ad Amir Goldstein         2020-07-22  485           /* Dirent event - report on TYPE_INODE to dir */
> dca640915c7b84 Amir Goldstein         2021-06-29  486           inode = event_info->dir;
>                                                                 ^^^^^^^^^^^^^^^^^^^^^^^
> Presumably this is non-NULL
>
> 40a100d3adc1ad Amir Goldstein         2020-07-22  487   } else if (mask & FS_EVENT_ON_CHILD) {
> 40a100d3adc1ad Amir Goldstein         2020-07-22  488           /*
> fecc4559780d52 Amir Goldstein         2020-12-02  489            * Event on child - report on TYPE_PARENT to dir if it is
> fecc4559780d52 Amir Goldstein         2020-12-02  490            * watching children and on TYPE_INODE to child.
> 40a100d3adc1ad Amir Goldstein         2020-07-22  491            */
> dca640915c7b84 Amir Goldstein         2021-06-29  492           parent = event_info->dir;
> 40a100d3adc1ad Amir Goldstein         2020-07-22  493   }
> 40a100d3adc1ad Amir Goldstein         2020-07-22 @494   sb = inode->i_sb;
>                                                              ^^^^^^^^^^^^
> Dereference
>
> 497b0c5a7c0688 Amir Goldstein         2020-07-16  495
> 7c49b8616460eb Dave Hansen            2015-09-04  496   /*
> 7c49b8616460eb Dave Hansen            2015-09-04  497    * Optimization: srcu_read_lock() has a memory barrier which can
> 7c49b8616460eb Dave Hansen            2015-09-04  498    * be expensive.  It protects walking the *_fsnotify_marks lists.
> 7c49b8616460eb Dave Hansen            2015-09-04  499    * However, if we do not walk the lists, we do not have to do
> 7c49b8616460eb Dave Hansen            2015-09-04  500    * SRCU because we have no references to any objects and do not
> 7c49b8616460eb Dave Hansen            2015-09-04  501    * need SRCU to keep them "alive".
> 7c49b8616460eb Dave Hansen            2015-09-04  502    */
> 9b93f33105f5f9 Amir Goldstein         2020-07-16  503   if (!sb->s_fsnotify_marks &&
> 497b0c5a7c0688 Amir Goldstein         2020-07-16  504       (!mnt || !mnt->mnt_fsnotify_marks) &&
> 9b93f33105f5f9 Amir Goldstein         2020-07-16 @505       (!inode || !inode->i_fsnotify_marks) &&
>                                                              ^^^^^^
> Unnecessary check for NULL
>
> fecc4559780d52 Amir Goldstein         2020-12-02  506       (!parent || !parent->i_fsnotify_marks))
> 7c49b8616460eb Dave Hansen            2015-09-04  507           return 0;
> 71d734103edfa2 Mel Gorman             2020-07-08  508
> 9b93f33105f5f9 Amir Goldstein         2020-07-16  509   marks_mask = sb->s_fsnotify_mask;
> 71d734103edfa2 Mel Gorman             2020-07-08  510   if (mnt)
> 71d734103edfa2 Mel Gorman             2020-07-08  511           marks_mask |= mnt->mnt_fsnotify_mask;
> 9b93f33105f5f9 Amir Goldstein         2020-07-16  512   if (inode)
>                                                             ^^^^^^
>
> 9b93f33105f5f9 Amir Goldstein         2020-07-16  513           marks_mask |= inode->i_fsnotify_mask;
> fecc4559780d52 Amir Goldstein         2020-12-02  514   if (parent)
> fecc4559780d52 Amir Goldstein         2020-12-02  515           marks_mask |= parent->i_fsnotify_mask;
> 497b0c5a7c0688 Amir Goldstein         2020-07-16  516
> 71d734103edfa2 Mel Gorman             2020-07-08  517
> 613a807fe7c793 Eric Paris             2010-07-28  518   /*
> 613a807fe7c793 Eric Paris             2010-07-28  519    * if this is a modify event we may need to clear the ignored masks
> 497b0c5a7c0688 Amir Goldstein         2020-07-16  520    * otherwise return if none of the marks care about this type of event.
> 613a807fe7c793 Eric Paris             2010-07-28  521    */
> 71d734103edfa2 Mel Gorman             2020-07-08  522   test_mask = (mask & ALL_FSNOTIFY_EVENTS);
> 71d734103edfa2 Mel Gorman             2020-07-08  523   if (!(mask & FS_MODIFY) && !(test_mask & marks_mask))
> 613a807fe7c793 Eric Paris             2010-07-28  524           return 0;
> 75c1be487a690d Eric Paris             2010-07-28  525
> 9385a84d7e1f65 Jan Kara               2016-11-10  526   iter_info.srcu_idx = srcu_read_lock(&fsnotify_mark_srcu);
> 75c1be487a690d Eric Paris             2010-07-28  527
> 45a9fb3725d886 Amir Goldstein         2019-01-10  528   iter_info.marks[FSNOTIFY_OBJ_TYPE_SB] =
> 45a9fb3725d886 Amir Goldstein         2019-01-10  529           fsnotify_first_mark(&sb->s_fsnotify_marks);
> 9bdda4e9cf2dce Amir Goldstein         2018-09-01  530   if (mnt) {
> 47d9c7cc457adc Amir Goldstein         2018-04-20  531           iter_info.marks[FSNOTIFY_OBJ_TYPE_VFSMOUNT] =
> 3427ce71554123 Miklos Szeredi         2017-10-30  532                   fsnotify_first_mark(&mnt->mnt_fsnotify_marks);
> 7131485a93679f Eric Paris             2009-12-17  533   }
> 9b93f33105f5f9 Amir Goldstein         2020-07-16  534   if (inode) {
>                                                             ^^^^^
> Lots of checking...  Maybe this is really NULL?

Do you have feeling of dejavu? ;-)
https://lore.kernel.org/linux-fsdevel/20200730192537.GB13525@quack2.suse.cz/

We've been through this.
Maybe you silenced the smach warning on fsnotify() and the rename to
__fsnotifty()
caused this warning to refloat?

Thanks,
Amir.
