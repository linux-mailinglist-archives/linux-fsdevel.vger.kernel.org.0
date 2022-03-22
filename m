Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39384E47D6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 21:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiCVU4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 16:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiCVU4s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:56:48 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1737643
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 13:55:20 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id bp39so3770102qtb.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Mar 2022 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T82JUlUBz+LKhdK6HbRtYv6lWE295vUan/Ko+8fhObw=;
        b=BZXao2MWno+Ei2xOla/xyC3vm46Pp/AhezAHsGhZutgTCBbYphhnH6xY6+vTIs655P
         nQ1fN9vLdKyET/h+kA+vy+p8D5wbjaUllegrR0ds+c0w+S70EBp2QY+7TrHEZ/ksQFUu
         wjvcTOzxd8TupkOaeVhGADf0BMIl8k9r8b54Oc4Irs0pNSKeD1b4fYC0QKOLoXAjnrJ1
         fhyUFkdqui3c1e9FaR73Ltby3k/NvA9I3WUi7vuVp/PlmEZFa/7+abK48wrfWbZH1Da0
         2v4L7hNrbWP90jFOsAD5aWY1GZ1lpFQ/YaF0fdvvmfOUjDRIL4//EfUy/slqFM9Zpez4
         tfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T82JUlUBz+LKhdK6HbRtYv6lWE295vUan/Ko+8fhObw=;
        b=dfaZLbY1GyzeLsE6LzERqNc5NxH9+UtIdyQ3cvfQ1N5NYPEym9j0eoa7u7kYF7I30W
         /tFprt0iFecpeEj720BRVKHtjgvMFLi22u3IQeV9c7VozmN+sZYiyHm2vOdn+XmzjYvM
         ra4Mbfa6WzfwnGO8S/KjlzzIKe/BRjWmapjz1EaWRe90OlwL47Z2ZKcHItmLudPX/y95
         Z6EQ41Tzm0gRX8GqcGle+lK9TyOzBTzyw6R0OInClZPoSuw2ItFzqQiT8PzhY0gG1dF+
         4WPrjk02gYb3aKo/1O/2nL4oNFRdlVXLEmEOzmKLWVtecoa60kCeA2qjj82HGtPobTOz
         rPMg==
X-Gm-Message-State: AOAM531mZS7Jx/uiy922xrS/0HBKg3fQS1HD4j1E3AbfDJcaylH8Fr4l
        wNwTep05kNCMJ1buYitzUWlDrQ==
X-Google-Smtp-Source: ABdhPJzQo6jrn4S1QRw9ZlF5uP7uRywNQyZpvzUEQnZ7zGL4CnlQlP5OMX9f0NmsnraFZu9q6SKcZw==
X-Received: by 2002:ac8:7e8c:0:b0:2e1:d230:e27f with SMTP id w12-20020ac87e8c000000b002e1d230e27fmr21783837qtj.378.1647982519446;
        Tue, 22 Mar 2022 13:55:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w3-20020a05622a190300b002e1f084d84bsm12834060qtc.50.2022.03.22.13.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 13:55:18 -0700 (PDT)
Date:   Tue, 22 Mar 2022 16:55:17 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Sterba <dsterba@suse.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Btrfs updates for 5.18
Message-ID: <Yjo3tQO+fNNlZ4/i@localhost.localdomain>
References: <cover.1647894991.git.dsterba@suse.com>
 <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADWXX-uX74SETx8QNnGDyBGMJHY-6wr8jC9Sjpv4ARqUca0Xw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 22, 2022 at 11:23:21AM -0700, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 2:37 PM David Sterba <dsterba@suse.com> wrote:
> >
> > - allow reflinks/deduplication from two different mounts of the same
> >   filesystem
> 
> So I've pulled this, and it looks ok, but I'm not getting the warm and fuzzies.
> 
> In particular, I'm not seeing any commentary about different
> filesystems for this.
> 
> There are several filesystems that use that ->remap_file_range()
> operation, so these relaxed rules don't just affect btrfs.
> 
> Yes, yes, checking for i_sb matching does seem sensible, but I'd
> *really* have liked some sign that people checked with other
> filesystem maintainers and this is ok for all of them, and they didn't
> make assumptions about "always same mount" rather than "always same
> filesystem".
> 

> This affects at least cifs, nfs, overlayfs and ocfs2.

I had a talk with Darrick Wong about this on IRC, and his Reviewed-by is on the
patch.  This did surprise nfsd when xfstests started failing, but talking with
Bruce he didn't complain once he understood what was going on.  Believe me I
have 0 interest in getting the other maintainers upset with me by sneaking
something by them, I made sure to run it by people first, tho I probably should
have checked with people directly other than Darrick.

> 
> Adding fsdevel, and pointing to that
> 
> -       if (src_file->f_path.mnt != dst_file->f_path.mnt)
> +       if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
> 
> change in commit 9f5710bbfd30 ("fs: allow cross-vfsmount reflink/dedupe")
> 
> And yes, there was already a comment about "Practically, they only
> need to be on the same file system" from before that matches the new
> behavior, but hey, comments have been known to be wrong in the past
> too.
> 
> And yes, I'm also aware that do_clone_file_range() already had that
> exact same i_sb check and it's not new, but since ioctl_file_clone()
> cheched for the mount path, I don't think you could actually reach it
> without being on the same mount.
> 
> And while discussing these sanity checks: wouldn't it make sense to
> check that *both* the source file and the destination file support
> that remap_file_range() op, and it's the same op?
> 
> Yes, yes, it probably always is in practice, but I could imagine some
> type confusion thing. So wouldn't it be nice to also have something
> like
> 
>     if (dst_file->f_op != src_file->f_op)
>           goto out_drop_write;
> 
> in there? I'm thinking "how about dedupe from a directory to a regular
> file" kind of craziness...
>

This more fine-grained checking is handled by generic_remap_file_range_prep() to
make sure we don't try to dedup a directory or pipe or some other nonsense.
Thanks,

Josef 
