Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E0834E784
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhC3Md5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhC3Mdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:33:35 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0E5C061574;
        Tue, 30 Mar 2021 05:33:35 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r193so16212821ior.9;
        Tue, 30 Mar 2021 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1A0xAyQGsYfTTCx2vwrAA929EEftGO0G2i81sSbvLY=;
        b=Z7L4sXMa20CR6CyFsmZoCNoDMUtYBFKwAV9mUAzB8YKX8KpoSCMYgyaRsCOR9ncHFO
         ExSy23IWj0z7IqF/2LjkS+1vomIBc808Cb5hOkUJ2hz6HIqzqR4ry/C+2F0FCXOlTq1c
         pJuO51kMupBkHBTXp+ktosgjblX4KhQbq6gpI5TljvtSDE4WBivQw7/ttKPUt2Qx0okM
         1FspDd86B6INUSX+jkb+9W4HEAANmacKhfZs8TtMRB3EXwJsKXKSh6FsUFtxzoCHgufL
         Hr/5Tg3QavdqwXV69dLs+XMM9umE5i6+o5/s07FZMxGxBkoqo/NlILHkhssYO7GvjBSF
         kg7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1A0xAyQGsYfTTCx2vwrAA929EEftGO0G2i81sSbvLY=;
        b=o+XPkZ8cfVYSUbmbeJreRtfiSav7cv5uhb4sYDKCUN2BQ9fF1mKGLzE7wikrUjU9s8
         wixb5dLlupK/kf3tqw7tJy904aGiwjCRYNQwVD3iv1Qp+zfxREBK/0/8LOaEmzwosYCt
         Pq/mqzymRLr+59Od8cIbfw0kL/cJzoJGMiNq6J1kWapsJ+m2SVNPcjiKMb3Dgh9UswlB
         7roW9MRBFLLHns7D6xL2pCJ4bfA7bHP5zsNURCNIhIXvWfccduTo1nWFRt+3CSpQK05I
         ngFZbp9CsjwWcOBpofUpzX8gQ6pFX8sXhbTJKnDXQ72ilcyJBD0pcIoCMy305QUFxjjN
         sjdw==
X-Gm-Message-State: AOAM532eaYIoAAb2ZB3eef4rR2XvrcM6qLwtn61eQPUbAIm0zkFx7oEp
        F6I8CgZCO7MFj6Jg3JEC/k527kxe6VKnMIn69fY=
X-Google-Smtp-Source: ABdhPJz0OSoawXQGX8qSqrogfrcGpsTIlSDfcFM+sf8lJ4ogjTEYIg1PmLqjs2k0eslthCbMF1VKJQ64Ts59L6r4c18=
X-Received: by 2002:a5e:8e41:: with SMTP id r1mr24464866ioo.5.1617107614665;
 Tue, 30 Mar 2021 05:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
In-Reply-To: <20210330121204.b7uto3tesqf6m7hb@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Mar 2021 15:33:23 +0300
Message-ID: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 3:12 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > Add a high level hook fsnotify_path_create() which is called from
> > syscall context where mount context is available, so that FAN_CREATE
> > event can be added to a mount mark mask.
> >
> > This high level hook is called in addition to fsnotify_create(),
> > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > context is not available.
> >
> > In the context where fsnotify_path_create() will be called, a dentry flag
> > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > level hooks.
>
> Ok, just to make sure this scheme would also work for overlay-style
> filesystems like ecryptfs where you possible generate two notify events:
> - in the ecryptfs layer
> - in the lower fs layer
> at least when you set a regular inode watch.
>
> If you set a mount watch you ideally would generate two events in both
> layers too, right? But afaict that wouldn't work.
>
> Say, someone creates a new link in ecryptfs the DENTRY_PATH_CREATE
> flag will be set on the new ecryptfs dentry and so no notify event will
> be generated for the ecryptfs layer again. Then ecryptfs calls
> vfs_link() to create a new dentry in the lower layer. The new dentry in
> the lower layer won't have DCACHE_PATH_CREATE set. Ok, that makes sense.
>
> But since vfs_link() doesn't have access to the mnt context itself you
> can't generate a notify event for the mount associated with the lower
> fs. This would cause people who a FAN_MARK_MOUNT watch on that lower fs
> mount to not get notified about creation events going through the
> ecryptfs layer. Is that right?  Seems like this could be a problem.
>

Not sure I follow what the problem might be.

FAN_MARK_MOUNT subscribes to get only events that were
generated via that vfsmount - that has been that way forever.

A listener may subscribe to (say) FAN_CREATE on a certain
mount AND also also on a specific parent directory.

If the listener is watching the entire ecryptfs mount and the
specific lower directory where said vfs_link() happens, both
events will be reported. One from fsnotify_create_path() and
the lower from fsnotify_create().

If one listener is watching the ecryptfs mount and another
listener is watching the specific ecryptfs directory, both
listeners will get a single event each. They will both get
the event that is emitted from fsnotify_path_create().

Besides I am not sure about ecryptfs, but overlayfs uses
private mount clone for accessing lower layer, so by definition
users cannot watch the underlying overlayfs operations using
a mount mark. Also, overlayfs suppresses fsnotify events on
underlying files intentionally with FMODE_NONOTIFY.

Hope that answers your question.

Thanks,
Amir.
