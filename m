Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE303348A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 21:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbhCJUHn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 15:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbhCJUHS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 15:07:18 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F80DC061574;
        Wed, 10 Mar 2021 12:07:18 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u14so24737559wri.3;
        Wed, 10 Mar 2021 12:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wOgAelLZHWumRUZs21CTsS2zD3FZVsziPeto0jg+ZCE=;
        b=Zhg+3XhgV6ITD4zuHBLaBmmqu/Z4JKzJbm0coqwLukLYblSBSSp/WCkVm8LkMTQNOR
         Vj0myKVkgiOaHwpkAD5hKcBLmyaQWEYaU7rcBaFeDW/8pyHl+ePYLshU5rQM/EIvkDTm
         9OiVlEgLERsreqh8cZrLk2HfMOoGvAyfCZ9xLo/02KC9ttdIa6z/zU4DIfzCFANyw760
         mV4yDz4l2plcY8TtkAtiW41TpzMQlGtEHofIl5K8FiDKCX2M4ZILr+kDW3VEw8Id6UsN
         QNi/pTVSPKd0oDFlzkdw8ZSKBGV5TW+/+WQm8twF2GN/cuY1DznkRNtSkgq05fJdfWNM
         fdHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wOgAelLZHWumRUZs21CTsS2zD3FZVsziPeto0jg+ZCE=;
        b=fW9oGvh6mvhIJsLFiqhPX/D//TzCfn6eILZZBOf/mDpzJBV9TFzio8WoF9p7FCmIcb
         UyQFevvmgJpGb7P4+eF580GvgX28mtZr6N9ogg55mM6d1Rw4cBD3knnfeBJVy9/yJhiO
         73gR5bsONqmlQc441j1nzMLraTu+1Y29oZqW9vksjILZXlT+iI08rzILL6Ysw3yq2F6w
         M+AJYcWxeAcfCTo5rpZzCCLh20Ujgm9LBVgmrY1TDsMPjIARhKr5SZ8EAPs8O0PC5kbB
         35QbhgLAB9gtSuJ1IQwGGiaf3rncqD4CFva/6nO8hZljodA+yifXqXuryBB4e8chAkTi
         7GTg==
X-Gm-Message-State: AOAM533c0lB9+JUKkv987oWx/NfNFFl2cXjX2DdScnINa+wO294ux9aX
        iblBaUFgssUsWNyk7OTxhel9wiziJkmJpg==
X-Google-Smtp-Source: ABdhPJwsH5QdZwvtuJJ0km8xhhnO57ZDdDl4ikE88zYJPHafhhROslLpWIbYqemy6BRU1UUjjbJOqQ==
X-Received: by 2002:adf:e548:: with SMTP id z8mr5387658wrm.246.1615406837234;
        Wed, 10 Mar 2021 12:07:17 -0800 (PST)
Received: from example.org (ip-94-113-225-162.net.upcbroadband.cz. [94.113.225.162])
        by smtp.gmail.com with ESMTPSA id g16sm415804wrs.76.2021.03.10.12.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 12:07:16 -0800 (PST)
Date:   Wed, 10 Mar 2021 21:07:12 +0100
From:   Alexey Gladkov <gladkov.alexey@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 0/5] proc: Relax check of mount visibility
Message-ID: <20210310200712.z5yuedjmbz42n2jr@example.org>
References: <cover.1615400395.git.gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615400395.git.gladkov.alexey@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 10, 2021 at 07:19:55PM +0100, Alexey Gladkov wrote:
> If only the dynamic part of procfs is mounted (subset=pid), then there is no
> need to check if procfs is fully visible to the user in the new user namespace.

I'm sorry about that unfinished patch set. Please ignore it.

> Changelog
> ---------
> v4:
> * Set SB_I_DYNAMIC only if pidonly is set.
> * Add an error message if subset=pid is canceled during remount.
> 
> v3:
> * Add 'const' to struct cred *mounter_cred (fix kernel test robot warning).
> 
> v2:
> * cache the mounters credentials and make access to the net directories
>   contingent of the permissions of the mounter of procfs.
> 
> --
> 
> Alexey Gladkov (5):
>   docs: proc: add documentation about mount restrictions
>   proc: Show /proc/self/net only for CAP_NET_ADMIN
>   proc: Disable cancellation of subset=pid option
>   proc: Relax check of mount visibility
>   docs: proc: add documentation about relaxing visibility restrictions
> 
>  Documentation/filesystems/proc.rst | 18 ++++++++++++++++++
>  fs/namespace.c                     | 27 ++++++++++++++++-----------
>  fs/proc/proc_net.c                 |  8 ++++++++
>  fs/proc/root.c                     | 25 +++++++++++++++++++------
>  include/linux/fs.h                 |  1 +
>  include/linux/proc_fs.h            |  1 +
>  6 files changed, 63 insertions(+), 17 deletions(-)
> 
> -- 
> 2.29.2
> 

-- 
Rgrds, legion

