Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD504E49D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 00:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240709AbiCVX7s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 19:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiCVX7s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:59:48 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 269DF1FA65
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 16:58:19 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-de48295467so138133fac.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 16:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vUVk/dhLiB155bUOvch7vh6le5Az932UZy2a3V1Wso=;
        b=SnVVlXv+vVQWOpu6S8pxeRjqAqL9xosoIjT7GXzkOqKYDdN5+7EHDolhRT7reiVera
         fZUR5oZTnj3wvRBhawomMWcJ4IFwVRMb5J0xluAFekR/5uUFdTvweYcfFQxG5dodKQnU
         mkEqGUOjpJXAo+dAd+gy+sF3KwXZfvJAnQYHV3QhqzGJghnryLWiRCWg9W5tJLIGlIip
         DvtMQ/6/6oVzPQGWNBl0C2IqaCeX2TNLm5wSRvXpMgrkwk9jfGg6qA+Z8JvTs6azn6EU
         q1Ewt9ZaqtnMV8jm09mdntJDy2xwA7AHHBhDMF/2iQSPVSAIMirthY4gjsArDVP2LzUs
         57JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vUVk/dhLiB155bUOvch7vh6le5Az932UZy2a3V1Wso=;
        b=Jy1Q87ySpX2VZNr4J4AZE37cM+vw6TUFnnL6kc4rUaM0UGhgjWDDdeZS8TK9b7VvyH
         qs2Tabt2ZbMo8azQ0AVlUnvM6H3ulu6p3bvRPgXGzgAq/Beczi+QV/1YwsZTK4ceYegy
         jcM33+RziX4BsEaZiPpJpgbE2c9Qtf2hnWQ0fOZN56Q8rGAmjAyrii68pXZX41QILaZC
         1kayDCzhrbdU78KT0V0sCseYxpVVBLkKAoGVfukQZ4dCgacnLaX3yGcw5QQYHAjmhIL9
         0aI81KGSK/JbASQzpFFbwZbkfTgZ4kRi1osL9cVvYsRrpY3MCk7q/eYtMGiNoBGURGzG
         s3Lg==
X-Gm-Message-State: AOAM531fgeHxcebqPWLb+tYxVM390jHdE1memkJLURWvI7TB7EPh8KNN
        WJbvw1+SNlylzKVcb5QiJ7yWK0QvNGp5vJ6W8/htxcsHnI8=
X-Google-Smtp-Source: ABdhPJx1R+hFPdecpLkNdEYr4Pf2lULkUM+icjWjv4HQr+ek9QcLIWnB3CF6tRcTn28F4B2PRa43uCgq9FLttu9kGF4=
X-Received: by 2002:a05:6870:7393:b0:dd:9a31:96d1 with SMTP id
 z19-20020a056870739300b000dd9a3196d1mr2883939oam.98.1647993498406; Tue, 22
 Mar 2022 16:58:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220322222738.182974-1-krisman@collabora.com> <20220322222738.182974-3-krisman@collabora.com>
In-Reply-To: <20220322222738.182974-3-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 23 Mar 2022 01:58:07 +0200
Message-ID: <CAOQ4uxhLQp4ujuR8k16k9EfeOC2TiwwiCeVGYOzpViwRpa5oqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] shmem: Introduce /sys/fs/tmpfs support
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Linux MM <linux-mm@kvack.org>, kernel@collabora.com,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+fsdevel please CC on next versions]

On Wed, Mar 23, 2022 at 12:27 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> In order to expose tmpfs statistics on sysfs, add the boilerplate code
> to create the /sys/fs/tmpfs structure.  Other filesystems usually do
> /sys/fs/<fs>/<disk>, but since this is a nodev filesystem, I'm proposing
> to use fsid as <disk>.

I am proposing st_dev minor.

>
> This takes care of not exposing SB_NOUSER mounts.  I don't think we have
> a usecase for showing them and, since they don't appear elsewhere, they
> might be confusing to users.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  include/linux/shmem_fs.h |  4 +++
>  mm/shmem.c               | 73 +++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 76 insertions(+), 1 deletion(-)
>
[...]

> +static int shmem_register_sysfs(struct super_block *sb)
> +{
> +       int err;
> +       struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
> +       __kernel_fsid_t fsid = uuid_to_fsid(sb->s_uuid.b);
> +
> +       init_completion(&sbinfo->s_kobj_unregister);
> +       err = kobject_init_and_add(&sbinfo->s_kobj, &tmpfs_sb_ktype, shmem_root,
> +                                  "%x%x", fsid.val[0], fsid.val[1]);

uuid (and fsid) try to be unique across tmpfs instances from different times.
You don't need that.
I think you'd rather use s_dev (minor number) which is unique among all tmpfs
instances at a given time and also much easier from user scripts to read from
(e.g. stat or /proc/self/mountinfo).

That's btw the same number is used as an entry in /sys/fs/fuse/connections
(fusectl pseudo fs).

Thanks,
Amir.
