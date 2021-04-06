Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA9355859
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Apr 2021 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345759AbhDFPnl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Apr 2021 11:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239586AbhDFPnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Apr 2021 11:43:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA2C06174A;
        Tue,  6 Apr 2021 08:43:31 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id x17so16057656iog.2;
        Tue, 06 Apr 2021 08:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ECh+8tYfn4hKWUWBsHXDMBiOe0Fu2PWbeWU09osjJks=;
        b=Nq/TEtJIC/JX2DqB60AXoQRpLHJZ5TJ0FfrsqhryoHcBPpG7f1CK0b1Lr7/D6VohpW
         mMLxKWnKhbLnKiWP9tl0/nObKBqLPBVnozObUUZ5RtyE9iMhWL/2eBWX9GHU837AsfPP
         yBkyoOQV4iKmN9mvTZyQmazsnbxSlY07Aq6yVHbXWwE6lTWG7wFD/CX9X11r2FAyaosi
         q/v17+epNWF4OVB9KUWCfrMF4O8i1PflUajcb2JuTpo1cfnHk9iNBhTeytdqvbyTMtMZ
         lWEo4nUARTwGfK8by6X0SqCzDXYQMSYmsZisOMyo6y29hTcquFEePkGVWA+2ESfOYBfU
         hoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ECh+8tYfn4hKWUWBsHXDMBiOe0Fu2PWbeWU09osjJks=;
        b=OnUnmDf9psP+BCcktVCdovsWNH9yhaUWMQahwbimaVFqaEARS+E+btJFDTRjkq78dF
         mzTcLuZhZflK6bedue1ulNBMPkrGvxyI1yr7W13F3lDs9kB7luoEhuP4GECpcjUZ25wr
         1GGeR8Udv9mPy7eAk7BzC4UFIfcJYJDWK0x3jBQ/p4zyeIKO47vs5svnPCh+9NqnIkS2
         ptZ7Quy2d991qp0jfo1boNauIsszdIJ8uUzX5qRF1LDXnqBMr/5262KygDx5M4S8YaxN
         eZ1TBVvafhReyB6612GLmwM++v+Rdln5L7zk00wnialjLZ10+PCZ7phJ6crWJ19OuHpn
         zVMw==
X-Gm-Message-State: AOAM5303DWcQzpdY7V8Sf3XsD6G3x+rQOpqnraTmz4syT2/ROUf7wiaa
        /BUDB/7Tx1/G+/uETjYVda9cADTH7Fq07wjcK0li3upKmAw=
X-Google-Smtp-Source: ABdhPJwNIwsxvh3VNKKkgWpXUrGLYsCdIIPl/c2eSeZd4AwxfIzAQuoNLLX9rdpI6IFnRVOAzE6+myMv5YPwo3QLxF0=
X-Received: by 2002:a05:6602:2596:: with SMTP id p22mr24038732ioo.186.1617723810686;
 Tue, 06 Apr 2021 08:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjVdjLPbkkZd+_1csecDFuHxms3CcSLuAtRbKuozHUqWA@mail.gmail.com>
 <20210330125336.vj2hkgwhyrh5okee@wittgenstein> <CAOQ4uxjPhrY55kJLUr-=2+S4HOqF0qKAAX27h2T1H1uOnxM9pQ@mail.gmail.com>
 <20210330141703.lkttbuflr5z5ia7f@wittgenstein> <CAOQ4uxirMBzcaLeLoBWCMPPr7367qeKjnW3f88bh1VMr_3jv_A@mail.gmail.com>
 <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxgE_bCK_URCe=_4mBq4_72bazM86D859Kzs_ZoWyKJRhw@mail.gmail.com>
 <CAOQ4uxg+82RLt+KZXVLYhuDvrPLE0zaLf3Nw=oCJ=wBY6j6hTw@mail.gmail.com> <4224a40756ca036756493782ece9885967fd5892.camel@linux.ibm.com>
In-Reply-To: <4224a40756ca036756493782ece9885967fd5892.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 6 Apr 2021 18:43:19 +0300
Message-ID: <CAOQ4uxgj0DhzZxpD_YQzJPDE+HWN70xDVyf5=_21_2rp6-ObKQ@mail.gmail.com>
Subject: Re: LSM and setxattr helpers
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Paul Moore <paul@paul-moore.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Tyler Hicks <code@tyhicks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

security_inode_post_setxattr

On Mon, Apr 5, 2021 at 5:47 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Hi Amir,
>
> On Sun, 2021-04-04 at 13:27 +0300, Amir Goldstein wrote:
> > [forking question about security modules]
> >
> > >
> > > Nice thing about vfs_{set,remove}xattr() is that they already have
> > > several levels of __vfs_ helpers and nfsd already calls those, so
> > > we can hoist fsnotify_xattr() hooks hooks up from the __vfs_xxx
> > > helpers to the common vfs_xxx helpers and add fsnotify hooks to
> > > the very few callers of __vfs_ helpers.
> > >
> > > nfsd is consistently calling __vfs_{set,remove}xattr_locked() which
> > > do generate events, but ecryptfs mixes __vfs_setxattr_locked() with
> > > __vfs_removexattr(), which does not generate event and does not
> > > check permissions - it looks like an oversight.
> > >
> > > The thing is, right now __vfs_setxattr_noperm() generates events,
> > > but looking at all the security/* callers, it feels to me like those are
> > > very internal operations and that "noperm" should also imply "nonotify".
> > >
> > > To prove my point, all those callers call __vfs_removexattr() which
> > > does NOT generate an event.
> > >
> > > Also, I *think* the EVM setxattr is something that usually follows
> > > another file data/metadata change, so some event would have been
> > > generated by the original change anyway.
> > >
> > > Mimi,
> > >
> > > Do you have an opinion on that?
>
> Right, EVM is re-calculating the EVM HMAC, which is based on other LSM
> xattrs and includes some misc file metadata (e.g. ino, generation, uid,
> gid, mode).
>

That explains why EVM registers to security_inode_post_setxattr() hook in
__vfs_setxattr_noperm() and which is the helper that selinux and smack call.

> > >
> > > The question is if you think it is important for an inotify/fanotify watcher
> > > that subscribed to IN_ATTRIB/FAN_ATTRIB events on a file to get an
> > > event when the IMA security blob changes.
>
> Probably not.  Programs could open files R/W, but never modify the
> file.  Perhaps to detect mutable file changes, but I'm not aware of
> anyone doing so.
>
> >
> > Guys,
> >
> > I was doing some re-factoring of the __vfs_setxattr helpers
> > and noticed some strange things.
> >
> > The wider context is fsnotify_xattr() hooks inside internal
> > setxattr,removexattr calls. I would like to move those hooks
> > to the common vfs_{set,remove}xattr() helpers.
> >
> > SMACK & SELINUX:
> > For the callers of __vfs_setxattr_noperm(),
> > smack_inode_setsecctx() and selinux_inode_setsecctx()
> > It seems that the only user is nfsd4_set_nfs4_label(), so it
> > makes sense for me to add the fsnotify_xattr() in nfsd context,
> > same as I did with other fsnotify_ hooks.
> >
> > Are there any other expected callers of security_inode_setsecctx()
> > except nfsd in the future? If so they would need to also add the
> > fsnotify_xattr() hook, if at all the user visible FS_ATTRIB event is
> > considered desirable.
> >
> > SMACK:
> > Just to be sure, is the call to __vfs_setxattr() from smack_d_instantiate()
> > guaranteed to be called for an inode whose S_NOSEC flag is already
> > cleared? Because the flag is being cleared by __vfs_setxattr_noperm().
> >
> > EVM:
> > I couldn't find what's stopping this recursion:
> > evm_update_evmxattr() => __vfs_setxattr_noperm() =>
> > security_inode_post_setxattr() => evm_inode_post_removexattr() =>
> > evm_update_evmxattr()
>
> EVM is triggered when file metadata changes, causing the EVM HMAC to be
> re-calculated. Before updating security.evm, EVM first verifies, on the
> evm_inode_setattr/setxattr/removexattr() hooks, that the existing
> security.evm value is correct.
>
> On the _post hooks, security.evm is updated or removed, if no LSM xattr
> exists.
>

I'm not sure I understand why evm_update_evmxattr() calls
__vfs_setxattr_noperm() and not __vfs_setxattr(), but it's not really important
for my needs to understand this. Neither helper will generate an fsnotify event.

> > It looks like the S_NOSEC should already be clear when
> > evm_update_evmxattr() is called(?), so it seems more logical to me to
> > call __vfs_setxattr() as there is no ->inode_setsecurity() hook for EVM.
> > Am I missing something?
>
> EVM is triggered when an LSM updates/removes its xattr.   The LSM is
> responsible for taking the inode lock.   Thus it is calling
> __vfs_setxattr_noperm.
>

Surely you need to call a variant that is __vfs_setxattr_locked() or
below it. I just did not understand why that variant is not  __vfs_setxattr().

> >
> > It seems to me that updating the EVM hmac should not generate
> > a visible FS_ATTRIB event to listeners, because it is an internal
> > implementation detail and because update EVM hmac happens
> > following another change to the inode which anyway reports a
> > visible event to listeners.
>
> Ok
>


OK. It looks like there is a consensus about losing those events.
That's what I thought, but wanted to check with you security guys.

Thanks,
Amir.
