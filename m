Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2052B43D5F6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 23:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhJ0Vmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 17:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbhJ0Vmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 17:42:45 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5B0C061570;
        Wed, 27 Oct 2021 14:40:19 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id s3so4617878ild.0;
        Wed, 27 Oct 2021 14:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=AzYvw54aB4RsKoRa0Qm/BMsYpxOcUkrjvrL29qm6FXw=;
        b=IuxgtXZ76oydJoP2r1T0WGaEj+blROJYuZNuyep8Kzw4fO0NJShla/Z+Vxzlvc9aGG
         3xU2LQ50wD/zmpsR4ICzGXLJT8MOkXGuXv983XyHL9AiKm4jQ4Z1VG5ehOQD/+ja41/1
         s91VrNvxzO7hlTdglJX98mDMeQx9qA9tV/KHPQ/T81gqurjD6c4pMABha7i+/O0ruLlP
         Jpy4bAhg7z/2GWgvXJD2+YK8p2lk/jxSeOxzshhc72LTn7EmJcbR3rzLIqGzZJfsCxrT
         ci+Y2/AmE4c0L4DJNg/RJDWObKbrbIxqHJb3YK5zFrkIrG0iEJ2QpyH5K24aOUfuRS7/
         m6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=AzYvw54aB4RsKoRa0Qm/BMsYpxOcUkrjvrL29qm6FXw=;
        b=j+tePfGOzRI/dybCsdHKWhUPyrda1GgRR7mT9JSB4K8gRTz+htQqfAndKTDwUFIuns
         g5z9cGNVz+zSB49RhR2Ld1p1y9BerDOQsMwkpKjiwHvBIg4TWYdr26haXI6k9E0TGzz+
         xHUWiVjJnB1JjY9sxRb/LJ54P+96ObnDJaol4wA6V7VwdBKrZ18foPpjU+kwuHMOznCy
         q29hyQSi4gkAc/86YB+sPe5428xbGHxUCfLbSDTNw2mPHy+Pu/MHsR+oUl98XummHOA7
         CsR+u1DFsVL/TxcQzixfDU50DqVE+NowH7RjSRbekEoMfpJ7nFGDCuQYds0cjixt036W
         iBaA==
X-Gm-Message-State: AOAM532beHPjZjzZpfbjl9fUwPdq8TrfwDqJQLMuUaLLXbSMHIRKdiU9
        t0oaUvWI9LJQNGpROYRyqRilnbiQu5IwcRvq2BE=
X-Google-Smtp-Source: ABdhPJyEcjaxr9bHliyhlzzNJ38SD7ZRd2iqQA5ZaxMBlpC/ePRB6aJlA/QFIYz7xDoeIHfnSS8M1exDitOCG2Oiu68=
X-Received: by 2002:a05:6e02:12e4:: with SMTP id l4mr271672iln.25.1635370818069;
 Wed, 27 Oct 2021 14:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211027141857.33657-1-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 27 Oct 2021 23:39:42 +0200
Message-ID: <CA+icZUWXjyZXMUzzKumG0GfHRzpYOXHJFSzvsPwE24B0G_wu=A@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] ext4: new mount API conversion
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 27, 2021 at 11:27 PM Lukas Czerner <lczerner@redhat.com> wrote:
>
> After some time I am once again resurrecting the patchset to convert the
> ext4 to use the new mount API
> (Documentation/filesystems/mount_api.txt).
>
> The series can be applied on top of the current mainline tree and the work
> is based on the patches from David Howells (thank you David). It was built
> and tested with xfstests and a new ext4 mount options regression test that
> was sent to the fstests list. You can check it out on github as well.
>
> https://github.com/lczerner/xfstests/tree/ext4_mount_test
>
> Here is a high level description of the patchset
>
> 1. Prepare the ext4 mount parameters required by the new mount API and use
>    it for parsing, while still using the old API to get the options
>    string.
>
>   fs_parse: allow parameter value to be empty
>   ext4: Add fs parameter specifications for mount options
>   ext4: move option validation to a separate function
>   ext4: Change handle_mount_opt() to use fs_parameter
>
> 2. Remove the use of ext4 super block from all the parsing code, because
>    with the new mount API the parsing is going to be done before we even
>    get the super block.
>
>   ext4: Allow sb to be NULL in ext4_msg()
>   ext4: move quota configuration out of handle_mount_opt()
>   ext4: check ext2/3 compatibility outside handle_mount_opt()
>   ext4: get rid of super block and sbi from handle_mount_ops()
>
> 3. Actually finish the separation of the parsing and super block setup
>    into distinct steps. This is where the new ext4_fill_super() and
>    ext4_remount() functions are created temporarily before the actual
>    transition to the new API.
>
>   ext4: Completely separate options parsing and sb setup
>
> 4. Make some last preparations and actually switch the ext4 to use the
>    new mount API.
>
>   ext4: clean up return values in handle_mount_opt()
>   ext4: change token2str() to use ext4_param_specs
>   ext4: switch to the new mount api
>
> 5. Cleanup the old unused structures and rearrange the parsing function.
>
>   ext4: Remove unused match_table_t tokens
>
> There is still a potential to do some cleanups and perhaps refactoring
> such as using the fsparam_flag_no to remove the separate negative
> options for example. However that can be done later after the conversion
> to the new mount API which is the main purpose of the patchset.
>
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---

Is this the Git branch to pull from...?

https://github.com/lczerner/linux/tree/ext4_mount_api_rebase
https://github.com/lczerner/linux/commits/ext4_mount_api_rebase

Any other requirements or recommendations other than "ext4: ext4 mount
sanity test" (xfstests)?

Thanks.

- Sedat -

> v3 -> v4: Fix some typos, print exact quotafile type in log messages.
>           Remove explicit "Ext4:" from some log messages
> V2 -> V3: Rebase to the newer kernel, including new mount options.
> V1 -> V2: Rebase to the newer kernel
>
> Lukas Czerner (13):
>   fs_parse: allow parameter value to be empty
>   ext4: Add fs parameter specifications for mount options
>   ext4: move option validation to a separate function
>   ext4: Change handle_mount_opt() to use fs_parameter
>   ext4: Allow sb to be NULL in ext4_msg()
>   ext4: move quota configuration out of handle_mount_opt()
>   ext4: check ext2/3 compatibility outside handle_mount_opt()
>   ext4: get rid of super block and sbi from handle_mount_ops()
>   ext4: Completely separate options parsing and sb setup
>   ext4: clean up return values in handle_mount_opt()
>   ext4: change token2str() to use ext4_param_specs
>   ext4: switch to the new mount api
>   ext4: Remove unused match_table_t tokens
>
>  fs/ext4/super.c           | 1848 +++++++++++++++++++++++--------------
>  fs/fs_parser.c            |   31 +-
>  include/linux/fs_parser.h |    2 +-
>  3 files changed, 1189 insertions(+), 692 deletions(-)
>
> --
> 2.31.1
>
