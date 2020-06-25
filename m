Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55FE920A28E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 18:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390735AbgFYQDY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 12:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389860AbgFYQDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:03:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EB9C08C5C1;
        Thu, 25 Jun 2020 09:03:23 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m2so5708012otr.12;
        Thu, 25 Jun 2020 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y31utFTR97S8StjNejIYkBJIJzVE2pE1h/mCj/Ut9F0=;
        b=QBlx44bYeR/oLYOOKRc2NBs85jGd+pq3HCuLWxcfye3bMjvzzExio4gjC9FxemCOgP
         A+5BEDZQ2shrcTim9UMWTq8Xv2wVRGj28lWi+guZD985O964lE5cZvQgYFOIehPxkJbb
         H37ze5IyHGbrbUpEECVPgMwaGEhV3Gr2NZ8cBjRsAaZenS13U+5tPyT6W+oalg3EcA7u
         T6tW0V1nS4bxfmpCxdMqDtyCOSH1udApQQ2Ud/7MemLNea9pU//KUk3GiH+68IOqI8dn
         ZMWlGzkfp/snG85vcUW0e5MTh1wghh29TLbE77M4bBc7YIdvQmLoMbBGJieNdBYtL/de
         Mo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y31utFTR97S8StjNejIYkBJIJzVE2pE1h/mCj/Ut9F0=;
        b=mKKbocjVzT8fyQOhFeTq/Krd9Ynm22a9x98YhgNoR7Oem8o2OkMgmJt1QhEXix6FOB
         JwTOmm7j2Ry8dCd9BP6pyxM+D4uuDh7qYby91a18NgSdqbSO9TlCIqb7jEXHcys+TTjQ
         4R9JnF6nApJPUFY0i7ITTfItXglzNJ5yWScvFQ/8+DKq8FUslcwoKCeQpQIbVx3QNd4n
         w7SPUr6HjQeGwhtSIhmSFilBVmDHFMdAGqSxWmBkjmp412AwV9/3s5VXJwjm83JgDZ7i
         WsSadQiifm/1hGPxVApVOiUHqtY3nuWFHBe9qAXi40ZOC2p3mWlQcZJYozr8THLv5FvU
         S6kA==
X-Gm-Message-State: AOAM53030tlANndhqbrHws6f1esqJY9P9qQWq4i597nvudy7ed7tOCVD
        00nZ3vp6pKSqRh4odniEUBpjDOp6HDIj1UBc4Ko=
X-Google-Smtp-Source: ABdhPJzQ4ejK3ltbg/dTGHsl8KtTWtgbLMG5mvQumE2CPbe8K9zLmghJsby64h7eR6b6XMiXbVSf1TV8T25tQsTyhoI=
X-Received: by 2002:a9d:5786:: with SMTP id q6mr13587632oth.135.1593101002707;
 Thu, 25 Jun 2020 09:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org> <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
 <20200625132551.GB3526980@kroah.com> <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
 <a34cf18a-f251-f4f1-ed7c-fb5e100df91d@i-love.sakura.ne.jp>
In-Reply-To: <a34cf18a-f251-f4f1-ed7c-fb5e100df91d@i-love.sakura.ne.jp>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 12:03:11 -0400
Message-ID: <CAEjxPJ5FU1CPrUcBi89-A2+OVN4ueJ5EZcUfBY2-NfyjHnm4+g@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:21 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2020/06/25 23:26, Stephen Smalley wrote:
> > On Thu, Jun 25, 2020 at 9:25 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Thu, Jun 25, 2020 at 08:56:10AM -0400, Stephen Smalley wrote:
> >>> No, because we cannot label the inode based on the program's purpose
> >>> and therefore cannot configure an automatic transition to a suitable
> >>> security context for the process, unlike call_usermodehelper().
> >>
> >> Why, what prevents this?  Can you not just do that based on the "blob
> >> address" or signature of it or something like that?  Right now you all
> >> do this based on inode of a random file on a disk, what's the difference
> >> between a random blob in memory?
> >
> > Given some kind of key to identify the blob and look up a suitable
> > context in policy, I think it would work.  We just don't have that
> > with the current interface.  With /bin/kmod and the like, we have a
> > security xattr assigned to the file when it was created that we can
> > use as the basis for determining the process security context.
>
> My understanding is that fork_usermode_blob() is intended to be able to run
> without filesystems so that usermode blobs can start even before global init
> program (pid=1) starts.
>
> But SELinux's policy is likely stored inside filesystems which would be
> accessible only after global init program (pid=1) started.
>
> Therefore, I wonder whether SELinux can look up a suitable context in policy
> even if "some kind of key to identify the blob" is provided.
> Also, since (at least some of) usermode blob processes started via
> fork_usermode_blob() will remain after SELinux loads policy from filesystems,
> I guess that we will need a method for moving already running usermode blob
> processes to appropriate security contexts.
>
> Is my understanding/concerns correct?

It isn't fundamentally different than the issue of program execution
from a filesystem prior to initial policy load, e.g. executing
programs from the initrd or executing init from the "real" root.
Absent a policy, the process will just remain in the initial
SID/context (kernel SID), which will later be mapped to a context when
policy is loaded.  Typical init programs address this by either
re-exec'ing themselves after policy load or by dynamically switching
contexts via write to /proc/self/attr/current.  The kernel doesn't try
to retroactively transition previously started processes; they are
expected to either exit prior to policy load (ala transient processes
run from initrd) or re-exec or set their contexts after policy load.
