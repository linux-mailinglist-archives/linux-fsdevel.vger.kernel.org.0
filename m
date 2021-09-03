Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5163FFA23
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 08:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343773AbhICGLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 02:11:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53950 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243831AbhICGLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630649435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GtHmaUO+0GEq+rNeAQMdkCRow+2wFofi089GURVjj/Q=;
        b=gQJDmi0ZU8d3SG75mSPC/Q3TRbN0HRcUjpw24ZTASDi5wUQGEh13rmgDgAkSnmZdSFyLyb
        7fD/utn1niZR2t5TqJ260091TCFE2duQ/wlhXWljTdakcVMWoRFVXcQPzkob7dnOHQH6cP
        PHeqTfG8Da0OUaprAhzOu1gvCfEx3nw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-Z2wm7CtUPEynnIcjOoY5Dw-1; Fri, 03 Sep 2021 02:10:34 -0400
X-MC-Unique: Z2wm7CtUPEynnIcjOoY5Dw-1
Received: by mail-pl1-f198.google.com with SMTP id z10-20020a170903018a00b00134def0a883so1757032plg.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 23:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=GtHmaUO+0GEq+rNeAQMdkCRow+2wFofi089GURVjj/Q=;
        b=OAL3YtI1R/HaU8RwXBJYg9VTBE8Xf6fBzYzKKRVeIm/n0CkR2s2IDDgKwI4ucBYiLx
         nzF2wTyAiSG92lgDHwvM69CTSg6Pe3w79vamm8w3NfV3GQWRnDNWDOxI54iQJopdVFS0
         1/HYGBLqHJzTnFlnpoFKRT19CRYdk6bmDkVYI7NxfPPHg9zFAoF/9qb7cdL4lhYil5Qp
         oelKpesYrlpV+NxFN45FYjrzIjh4DPjBwJas24Q0wZ87ifgQaxdUTVJudo0GEMCUWfJX
         q6xZ0l2V+Lz7uLwd9Q+PulmqbuLEBHeQ1nwWWzYnWy4Ub/KMWGSHdF5H7zpeeQPb5Bqg
         cEwQ==
X-Gm-Message-State: AOAM531l7h6zM7YeD0zUwhWwYvF6/JCQYW95AXUMO4PHCK+jWvDSRbDH
        fN5xX7JR6t9hULxkzattEQinLI4X/Qe0TcJcri6rdiAeyqVrykc0jhqJosGef8s6WoZeJ7lFCOm
        F76n8cPyMBhV+s0mqdw1tkxO1pA==
X-Received: by 2002:a63:a4c:: with SMTP id z12mr2137198pgk.185.1630649433430;
        Thu, 02 Sep 2021 23:10:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJDGjsGTZPA4QMV/Zc6Gjp8iEfZR3XXkoNHMRJnENkybg32Bvzp9DhO/6VKy815DeLZNwpbQ==
X-Received: by 2002:a63:a4c:: with SMTP id z12mr2137158pgk.185.1630649433049;
        Thu, 02 Sep 2021 23:10:33 -0700 (PDT)
Received: from fedora ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h4sm3393427pjs.2.2021.09.02.23.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 23:10:32 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:31:33 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
Message-ID: <20210903063133.ld2benxs3vxemgnb@fedora>
Mail-Followup-To: Vivek Goyal <vgoyal@redhat.com>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtio-fs@redhat.com, dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        tytso@mit.edu, miklos@szeredi.hu, gscrivan@redhat.com,
        bfields@redhat.com, stephen.smalley.work@gmail.com,
        agruenba@redhat.com, david@fromorbit.com, viro@zeniv.linux.org.uk
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <YTDyE9wVQQBxS77r@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTDyE9wVQQBxS77r@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:47:31AM -0400, Vivek Goyal wrote:
> 
> xfstests: generic/062: Do not run on newer kernels
> 
> This test has been written with assumption that setting user.* xattrs will
> fail on symlink and special files. When newer kernels support setting
> user.* xattrs on symlink and special files, this test starts failing.
> 
> Found it hard to change test in such a way that it works on both type of
> kernels. Primary problem is 062.out file which hardcodes the output and
> output will be different on old and new kernels.
> 
> So instead, do not run this test if kernel is new and is expected to
> exhibit new behavior. Next patch will create a new test and run that
> test on new kernel.
> 
> IOW, on old kernels run 062 and on new kernels run new test.
> 
> This is a proposed patch. Will need to be fixed if corresponding
> kernel changes are merged upstream.
> 
> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
> ---
>  tests/generic/062 |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> Index: xfstests-dev/tests/generic/062
> ===================================================================
> --- xfstests-dev.orig/tests/generic/062	2021-08-31 15:51:08.160307982 -0400
> +++ xfstests-dev/tests/generic/062	2021-08-31 16:27:41.678307982 -0400
> @@ -55,6 +55,26 @@ _require_attrs
>  _require_symlinks
>  _require_mknod
>  
> +user_xattr_allowed()
> +{
> +	local kernel_version kernel_patchlevel
> +
> +	kernel_version=`uname -r | awk -F. '{print $1}'`
> +	kernel_patchlevel=`uname -r | awk -F. '{print $2}'`
> +
> +	# Kernel version 5.14 onwards allow user xattr on symlink/special files.
> +	[ $kernel_version -lt 5 ] && return 1
> +	[ $kernel_patchlevel -lt 14 ] && return 1
> +	return 0;
> +}

I don't think this's a good way to judge if run or notrun a test. Many downstream
kernels always backport upstream features. I can't say what's the best way to
deal with this thing, I only can provide two optional methods:

1) Add new requre_* helpers to check if current kernel support to set xattr on
symlink and special files, then let this case only run on support/unsupport
condition.

2) Use _link_out_file() to link the .out file to different golden images (refer to
generic/050 etc), according to different feature implementation.

If anyone has a better method, feel free to talk :)

Thanks,
Zorro

> +
> +
> +# Kernel version 5.14 onwards allow user xattr on symlink/special files.
> +# Do not run this test on newer kernels. Instead run the new test
> +# which has been written with the assumption that user.* xattr
> +# will succeed on symlink and special files.
> +user_xattr_allowed && _notrun "Kernel allows user.* xattrs on symlinks and special files. Skipping this test. Run newer test instead."
> +
>  rm -f $tmp.backup1 $tmp.backup2 $seqres.full
>  
>  # real QA test starts here
> 

