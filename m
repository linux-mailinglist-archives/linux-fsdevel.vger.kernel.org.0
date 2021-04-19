Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5C364870
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 18:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhDSQmc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 12:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbhDSQmc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 12:42:32 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2049C06174A
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 09:42:02 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e14so5933504ils.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSOWkChQsMG0VuzJn3YBzQKW7KfOzAoROAE9b1/qvX4=;
        b=aHhfi9Y0VH5NamwyPvNEIcK8DHrD7DbIRSZK3kdzzoO7/7CTD7JqU5plsuO+7Bnfyg
         JLQRBB10+JHonK4Zo/7wIniRexpbnuLz1vyv31ICx9rx/wrQoGG6LVdbrO/zRq/AXgdB
         6N4x8PjxKitlg8DazeWi7E8bDSCG0KaYnyYL+tsPMw/2g5Rskdwz6qbW3eQdDm4xw4T6
         YHhyy+aOw8liG4X9ZSxMYUD+uZQ3btXn7LVw8SRPO4wP6hv3ogjRxPThi+HUPAMLiNny
         QEYWeo0Vy/LWeDktoXS17tRNHOxKCCMmLsJa0nu3/IQW2dER0u3WaOFFVLjVeZvyrV5t
         lFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSOWkChQsMG0VuzJn3YBzQKW7KfOzAoROAE9b1/qvX4=;
        b=oUWObpZAJcrJwnzjTu0IbD/wVn0v1RLhe0+oBQ8peue/U2ilRIt7LNvqJGcdca/v5g
         F64YjMI30MUNfTh7smPHgytQZaNT8nnES1oHAvgRpajTDLdHYKQRGCLFzlt6mkRSRGvQ
         Ybbk5jO2vzQ+1inojHdO0uO+dorVMHqQFCNl1W/f0ntgr6vBTx3BUoUle2oa8ifKS5Cw
         FM3h8mkuXK2QjlbFEg5ZFp5jU2Y340sHw6We4AL26NN14vg8sB+J+Q2ohLW5JTZQSPne
         CNRRpYlvOCtNI/skoYG5KJCuCdNg/0mmuR8NyDleLqU93ZdcW1fmNLice7OPkJ/ICTxC
         YKgg==
X-Gm-Message-State: AOAM532VRflkaHDCRWweFOlyLWfVB9sGEwr2mBMTkpF99xusfMI2Hfv6
        7O5DTgc2eyEXhNGGiiqClFnmCoyeLmbRfaanL+U=
X-Google-Smtp-Source: ABdhPJyUidnN5qV14EzicgDp5AHGLPgKUvqojWPw5TS2mqvbutG3cNMy7AxPSaiSFeLC40MAEFj6fL1CWPZ6iamwUiA=
X-Received: by 2002:a92:de0c:: with SMTP id x12mr19085240ilm.275.1618850522170;
 Mon, 19 Apr 2021 09:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 19 Apr 2021 19:41:51 +0300
Message-ID: <CAOQ4uxi3c2xg9eiL41xv51JoGKn0E2KZuK07na0uSNCxU54OMQ@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Hmm, notify_change() is an inconsistent name anyway (for historical
> > reasons). Consistent name would be vfs_setattr(). And
> > vfs_setattr_nonotify() would be a fine name as well. What do you think?
> >
>
> I won't propose to convert all notify_change() callers before getting an
> explicit ACK from Al, but I could still use notify_change() as a wrapper
> around vfs_setattr_nonotify() and maybe also create an alias vfs_setattr()
> and use it in some places.
>

Tried that. It didn't go so well.
Renamed s/notify_change/vfs_setattr and then created a wrapper
vfs_setattr_notify(mnt, ...

First issue is that there are no callers left to vfs_setattr(), so the two
phase conversion becomes: s/notify_change/vfs_setattr_change
which is mostly noise.

The second issue is that fsnotify_change() takes @ia_valid arg, which
may be modified inside notify_change().

Which brings me back to the last resort.

Al,

Would you be willing to make an exception for notify_change()
and pass mnt arg to the helper? and if so, which of the following
is the lesser evil in your opinion:

1. Optional mnt arg
--------------------------
int notify_change(struct vfsmount *mnt,
                 struct user_namespace *mnt_userns,
                 struct dentry *dentry, struct iattr *attr,
                 struct inode **delegated_inode)

@mnt is non-NULL from syscalls and nfsd and NULL from other callers.

2. path instead of dentry
--------------------------------
int notify_change(struct user_namespace *mnt_userns,
                 struct path *path, struct iattr *attr,
                 struct inode **delegated_inode)

This is symmetric with vfs_getattr().
syscalls and nfsd use the actual path.
overlayfs, ecryptfs, cachefiles compose a path from the private mount
(Christian posted patches to make ecryptfs, cachefiles mount private).

3. Mandatory mnt arg
-----------------------------
Like #1, but use some private mount instead of NULL, similar to the
mnt_userns arg.

Any of the above acceptable?

Pushed option #1 (along with rest of the work) to:
https://github.com/amir73il/linux/commits/fsnotify_path_hooks

It's only sanity tested.

Thanks,
Amir.
