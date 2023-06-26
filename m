Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE63173E75B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 20:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjFZSOV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 14:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjFZSON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 14:14:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE116130;
        Mon, 26 Jun 2023 11:14:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fb4146e8fcso5064715e9.0;
        Mon, 26 Jun 2023 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687803245; x=1690395245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/hc7Igig2hnS9scknbx0R0/Ks5IqVXjHHneOtwGiGts=;
        b=nGARiJ7oJHkEIyhm/JrTF2Tcsl6mzXkrIVNkHXvBs0elXDCO1h5VTLEsG4CE8iclhB
         f42yDrh3GursluajYlqcVpa5BEzEVD7N0F/cAZhZM/LxM+VkVuSbSM+c7v76vUjnXv3T
         xGObGvqY04UE//V2ImKFtpNYvQjz2WXbgksWzhKeeKNXrxrB+j2i04aloHX6mSIKsEJD
         +T0gL8KMACP+LnNsZWn0TGLHaTpq5/aLt+eUHqEQy1FSzgHu+3KkfpJ4bz0MXX6k/1uk
         PwB/c/HXcmNCplYwE/yzxxei6jFKLPl5MZ1IWDm8HgLXX56zYQ0urqKMbWC3xp/Kg1cX
         QCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687803245; x=1690395245;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/hc7Igig2hnS9scknbx0R0/Ks5IqVXjHHneOtwGiGts=;
        b=QzGgNZIaPnbkyMxPscaqOatA5MR3/pBikEApg42PFeVD3V/JWMwSFjEvJFRIvO4MlT
         j/zQFVtxOuPFsQo1UM8mJQxa0N/6b9UYjae/VC0XcJUrsSq8t85oynfA36VfMQrTLDmQ
         PjmzYmAVVMVCUg2BYQksNDnC9CNZgc5YgRwSadmhN0fyqMuv10sRDpNWs18yMveQKxY3
         cpSzZfSI4DyvoubLFmXw1e1dlh4gDvElIQZjp50dqzczdJ3jz9xAJBrJpcjjWVtXxP9z
         VpfnRZJork8nqa5buOJOlYc3FdAuhzUXE/s2D21jBpqMdwYBiZ75n3n+N2ce1o1bk0S6
         ef+g==
X-Gm-Message-State: AC+VfDycacWZJcUggpQyf5pBJRYJskqvKQKNX9/UdQwZdfQ/jNNwhKLE
        1zzth8NghCoP2r3A3uJ8jBg/dueUuGA=
X-Google-Smtp-Source: ACHHUZ7y6JJ+0zoaNRoC01SVwuWTRfwo+AdiBHMtqP5iGGNv5ExkuoK8H3YMr77QRSCw1q95t4r4eg==
X-Received: by 2002:a7b:cb04:0:b0:3f7:ecdf:ab2d with SMTP id u4-20020a7bcb04000000b003f7ecdfab2dmr28763497wmj.20.1687803244999;
        Mon, 26 Jun 2023 11:14:04 -0700 (PDT)
Received: from localhost ([2a02:168:633b:1:9d6a:15a4:c7d1:a0f0])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bcb98000000b003f727764b10sm8493123wmi.4.2023.06.26.11.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 11:14:04 -0700 (PDT)
Date:   Mon, 26 Jun 2023 20:13:59 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        linux-fsdevel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Simon Brand <simon.brand@postadigitale.de>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: ioctl support
Message-ID: <20230626.0a8f70d4228e@gnoack.org>
References: <20230623144329.136541-1-gnoack@google.com>
 <ZJW4O+HVymf4nB6A@google.com>
 <77ec6e6c-7fb0-01ab-26c5-e9c9da392e2a@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77ec6e6c-7fb0-01ab-26c5-e9c9da392e2a@digikod.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello!

On Fri, Jun 23, 2023 at 06:37:25PM +0200, Mickaël Salaün wrote:
> On 23/06/2023 17:20, Günther Noack wrote:
> > ***Proposal***:
> > 
> >    I am in favor of *disabling* TIOCSTI in all Landlocked processes,
> >    if the Landlock policy handles the LANDLOCK_ACCESS_FS_IOCTL right.
> > 
> > If we want to do it in a backwards-compatible way, now would be the time to add
> > it to the patch set. :)
> 
> What would that not be backward compatible?

What I meant is that disabling TIOCSTI for Landlocked processes would
only be backwards compatible for Landlock users if they did a
conscious step for opting in to that feature, such as specifying that
"ioctl" should be a handled right.


> > As far as I can tell, there are no good legitimate use cases for TIOCSTI, and it
> > would fix the aforementioned sandbox escaping trick for a Landlocked process.
> > With the patch set as it is now, the only way to prevent that sandbox escape is
> > unfortunately to either (1) close the TTY file descriptors when enabling
> > Landlock, or (2) rely on an outside process to pass something else than a TTY
> > for FDs 0, 1 and 2.
> 
> What about calling setsid()?
> 
> Alternatively, seccomp could be used, even if it could block overlapping
> IOCTLs as well…

The possible approaches that I have seen kicked around are:

setsid()

  This does not work reliably from all processes, unfortunately.
  In particular, it does not work in the common case where a process
  gets started from a shell, without pipes or other bells and
  whistles.
  
  From the man page:

    setsid() creates a new session if the calling process is not a
    process group leader.

  Shells run subprocesses in their own process groups and if it is
  only one, it is its own process group leader (see credentials(7)).

  Such a process *could* of course run a subprocess and do it there,
  but it would potentially require architectural changes in some
  programs to do that, which de

seccomp-bpf

  That's a fallback solution, yes, although I am still hoping in the
  long run that we can get away without it.  The problem of tracking
  the available syscall numbers as I previously discussed it at [1]
  still exists: If the compiled program runs on a new kernel with a
  new syscall number, and is linked against a new version of glibc,
  that program might start doing this syscall but it can't tell apart
  in the seccomp filter whether this is to be blocked or not.

  It's a fundamentally flawed approach when linking against shared
  objects and running on unknown (future) Linux versions.

  [1] https://blog.gnoack.org/post/pledge-on-linux/

creating a new pseudo-terminal

  The cleaner solution suggested by Alan Cox in [2] is to create a new
  pseudo terminal and run the program within that pseudo terminal.

  This is also the technique used by programs like su (with the --pty
  flag) and sudo.  The man pages of both programs talk about it.

  Implementing this approach unfortunately also requires some
  architectural changes to the program doing that - it would also
  involve two processes again, one which keeps a reference to the tty
  which shovels data between the old and new terminal, and one which
  is sandboxed which only sees the pseudo-terminal.  The details are
  described in "Advanced Programming in the UNIX Environment", Chapter
  11.

  [2] https://lore.kernel.org/all/20170510212920.7f6bc5e6@alans-desktop/


I dislike all three of them for the Landlock use case:

 - Involving additional processes is a bigger change that the programs
   using Landlock would have to deal with.

 - Seccomp-BPF is a hack as well, due to the problem of having to
   track syscall numbers across platforms.

It might not be worth doing these things just to bridge the gap until
we have a more proper solution in Landlock.

For more entertaining/scary background reading, this search query in
the CVE database has links where you can see how the issue has been
dealt with in the past:

https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=TIOCSTI

The most recent one of these is in opendoas, the discussion in that
thread also has some interesting pointers (and the team ended up stuck
with the same three potential fixes which have similar problems for
them and which they have not implemented so far):
https://github.com/Duncaen/OpenDoas/issues/106



> > Does that sound reasonable?  If yes, I'd send an update to this patch set which
> > forbids TIOCSTI.
> 
> I agree that TIOCSTI is dangerous, but I don't see the rationale to add an
> exception for this specific IOCTL. I'm sure there are a lot of potentially
> dangerous IOCTLs out there, but from a kernel point of view, why should
> Landlock handle this one in a specific way?
> 
> Landlock should not define specific policies itself but let users manage
> that. Landlock should only restrict kernel features that *directly* enable
> to bypass its own restrictions (e.g. ptrace scope, FS topology changes when
> FS restrictions are in place).
> 
> I think we should instead focus on adding something like a
> landlock_inode_attr rule type to restrict IOCTLs defined by
> users/developers, and then extend it to make it possible to restrict already
> opened FDs as well.

After researching all the stuff above, I believe you are right - it's
better to leave this up to userspace and let them define the ioctls
that they actually need with an allow-listing approach, to reduce the
risk from obscure TTY ioctls.

Another point that also came up in the mail thread in [2] above was:
TIOCSTI is not the only way to do harm through the tty FD.  Another
one is TIOCLINUX (ioctl_console(2)) through its cut&paste
functionality, and who knows what other ioctls there might be.

So in that sense, I'm coming around to your approach of letting the
user define it in the next iteration of this ioctl patch set -- but
it will really be necessary to do that. o_O

–Günther
