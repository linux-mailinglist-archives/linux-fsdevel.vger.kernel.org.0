Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A443C6E3028
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Apr 2023 11:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDOJva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Apr 2023 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDOJv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Apr 2023 05:51:29 -0400
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1297030FA;
        Sat, 15 Apr 2023 02:51:28 -0700 (PDT)
Received: by mail-ua1-x934.google.com with SMTP id v18so2980427uak.8;
        Sat, 15 Apr 2023 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681552287; x=1684144287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQSrMitubAa5dm92J1EU6dgGqf9jY7pOt+TO9UehZvw=;
        b=JmErCpU4HA2Yb+ZG4TsNQQ7yE7MYLLifsaHW+rEUtFSFSPUYGpu+7+46oxp+CYhVbF
         lGu/lLSyoIL/bwr2vJBKjqYHQOS6OmUYR6Y2UjuqilTNMJIf4rfLoVcNhDbCU81Gw5gl
         Nup4TSCsPAKsymphEm9BLnj8UyDmskEC1XxkACingum/qRHRVU2hGpyiszx6VBV8c1mb
         bHkSq/SYp5qk+EcDPnsXNF9fsqyQFzUCbW6Gq8On3pPs3r014kBgiZLXziHDnlADZY7Y
         EhHKK/wwuXtYvtalvK5Kqt1hDvdHEX4h5sU1qsYYkzEB9Nbrnr83UZ3QRo5j1zxoyryC
         xDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681552287; x=1684144287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pQSrMitubAa5dm92J1EU6dgGqf9jY7pOt+TO9UehZvw=;
        b=ONqkJgyKZ1ubiNoNEPaD5PBlkCEx9MH6i5FhmWlztp+l/8yAUKRMkGjqnsIfTOnvO6
         C6HuLj8pwSXxqbeqUbW2iV7nzTTcR5hfyc9qB7ODqevG3iA8zu9TDpWAkWCTmleb8TCX
         xKVcbNdITDfNYWDLbgvddnCIFxzdqhmaGJh1UMMTH7UoOvHpf4M8aqYOfmt4ay3TKMwr
         uAohxPp1yNUWFMEwyZHIsArUaYn12rdY1yF8Ilt9FLMJdhngPRZ/KbCbYqm0ivOzBliX
         CL1KgSADiHvxtuqbbEDXMyCY3A2tN4owLb9WwTznct4HEkw247BLHdLqAcLtJWZr0StK
         fyPg==
X-Gm-Message-State: AAQBX9eyc604/C9KOF3g/uqmSm/gOPTBbIwgGe4FkIrQ1TSUs75xERo2
        sOgfBkq+2h2RYhr/EFcUZsqOg5hLuxnLVBQKwOc=
X-Google-Smtp-Source: AKy350Z5nVrufCwZKNEMVH1sYWilmflndlpOE0yJT8bBLf2aQzDs1QMIvi5XItWJYHiiJa2hSiVMrgrRrEceoYYP4Hs=
X-Received: by 2002:a1f:2957:0:b0:440:380f:fc20 with SMTP id
 p84-20020a1f2957000000b00440380ffc20mr4635002vkp.0.1681552286971; Sat, 15 Apr
 2023 02:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <95ee689c76bf034fa2fe9fade0bccdb311f3a04f.camel@kernel.org>
 <168142566371.24821.15867603327393356000@noble.neil.brown.name>
 <20230414024312.GF3390869@ZenIV> <8EC5C625-ACD6-4BA0-A190-21A73CCBAC34@hammerspace.com>
 <20230414035104.GH3390869@ZenIV> <20230414-leihgabe-eisig-71fb7bb44d49@brauner>
 <3492fa76339672ccc48995ccf934744c63db4b80.camel@kernel.org>
In-Reply-To: <3492fa76339672ccc48995ccf934744c63db4b80.camel@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 15 Apr 2023 12:51:15 +0300
Message-ID: <CAOQ4uxig=vXv_V1dvXoFb2gFECjOhZSg4yNCidxYO+PYzGihtQ@mail.gmail.com>
Subject: Re: allowing for a completely cached umount(2) pathwalk
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Neil Brown <neilb@suse.de>,
        Dave Wysochanski <dwysocha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 14, 2023 at 1:13=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Fri, 2023-04-14 at 11:41 +0200, Christian Brauner wrote:
> > On Fri, Apr 14, 2023 at 04:51:04AM +0100, Al Viro wrote:
> > > On Fri, Apr 14, 2023 at 03:28:45AM +0000, Trond Myklebust wrote:
> > >
> > > > We already have support for directory file descriptors when mountin=
g with move_mount(). Why not add a umountat() with similar support for the =
unmount side?
> > > > Then add a syscall to allow users with (e.g.) the CAP_DAC_OVERRIDE =
privilege to convert the mount-id into an O_PATH file descriptor.
> > >
> > > You can already do umount -l /proc/self/fd/69 if you have a descripto=
r.
> >
> > Way back when we put together stuff for [2] we had umountat() as an ite=
m
> > but decided against it because it's mostely useful when used as AT_EMPT=
Y_PATH.
> >
> > umount("/proc/self/fd/<nr>", ...) is useful when you don't trust the
> > path and you need to resolve it with lookup restrictions. Then path
> > resolution restrictions of openat2() can be used to get an fd. Which ca=
n
> > be passed to umount().
> >
> > I need to step outside so this is a halfway-out-the-door thought but
> > given your description of the problem Jeff, why doesn't the following
> > work (Just sketching this, you can't call openat2() like that.):
> >
> >         fd_mnt =3D openat2("/my/funky/nfs/share/mount", RESOLVE_CACHED)
> >         umount("/proc/self/fd/fd_mnt", MNT_DETACH)
>
> Something like that might work. A RESOLVE_CACHED flag is something that
> would involve more than just umount(2) though. That said, it could be
> useful in other situations.
>
> >
> > > Converting mount-id to O_PATH... might be an interesting idea.
> >
> > I think using mount-ids would be nice and fwiw, something we considered
> > as an alternative to umountat(). Not just can they be gotten from
> > /proc/<pid>/mountinfo but we also do expose the mount id to userspace
> > nowadays through:
> >
> >         STATX_MNT_ID
> >         __u64 stx_mnt_id;
> >
> > which also came out of [2]. And it should be safe to do via
> > AT_STATX_DONT_SYNC:
> >
> >         statx(my_cached_fd, AT_NO_AUTOMOUNT|AT_SYMLINK_NOFOLLOW|AT_STAT=
X_DONT_SYNC)
> >
> > using STATX_ATTR_MOUNT_ROOT to identify a potential mountpoint. Then
> > pass that mount-id to the new system call.
> >
> > [2]: https://github.com/uapi-group/kernel-features
>
> This is generating a lot of good ideas! Maybe we should plan to discuss
> this further at LSF/MM?
>

Hi Jeff,

I am trying to collect the topics for LSF/MM FS sessions, but it is somewha=
t
hard to do without an official [TOPIC] suggestion.

Not sure if this specific thread has anything left to discuss in a session
or if the original SUBJECT still describes the wider topic accurately.

Could you please follow up with a [TOPIC] proposal or just let me know
1. That you are interested to lead the session
2. Descriptive title for the session to put in the schedule
3. lore link to put in the schedule

While at it, please provide me with this info regarding
"i_version improvements".

Thanks,
Amir.
