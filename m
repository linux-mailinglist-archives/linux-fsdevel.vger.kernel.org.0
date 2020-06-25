Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8C7220A0EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jun 2020 16:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405389AbgFYOgN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jun 2020 10:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405340AbgFYOgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:36:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13683C08C5C1;
        Thu, 25 Jun 2020 07:36:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d4so5463887otk.2;
        Thu, 25 Jun 2020 07:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nc4o8s2QFMoo8VzOOVgiVSwm5a+lLq3YtSuw6jXUPz8=;
        b=qpEtAa+6Zn6ADEGLEn5ovGYLyyf5vUf9zPHAngSmEVVwAjdkjB85xDnN1ZDxmoVans
         OY2+7jfSDFDXpBtibVva9x8YfoLpXg+tUUsgAnLNbSXqErP0aJonccNPmJ3Ag/gIy4A8
         qn4Q/I+0J2y0ka2sOdhFCLR23u5P5Qu9TWmhayXSw6+EkRyKOKvBRQ4UIILQtz0Uzp3S
         9mYalirRS5fuIWw9vG9isjz44Jlp+ZR7hCJqfYdf4EkNtJFpmEJ3wEK8OGs8J/+5X3bV
         NfB59BY0YFF9p+8HigxCUSDdXUknSGekV33UrG71G28oLH+HCW7u7vpSsC+aNvGM2x6t
         3Q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nc4o8s2QFMoo8VzOOVgiVSwm5a+lLq3YtSuw6jXUPz8=;
        b=C9Vvrn+Fqa9AM0WyXkKNjJdzOLKAyFA9Q1nNXhOfUY2LqaPQWESDyrkYtVRC7qpmsf
         JjU1G4/3xgkQiq74oXD19HjeORHLIla+WzEZG0IEieG1DmViP8R6rtikx2vDMdgZLj2k
         +mcM+g8EAkwqHa08GhhsL+J6IT9cMA3q+YQysDgFFXQFCZ8SQ8/XBCo8D+UBTcr+qVRt
         n3Q8JUCaZDUFv3vAOwLJgYZlE8l37vQehaksW/o0L28vnEnmZuDW1MHg3t7JwJp4U3dT
         S2x6IfbxAAgEkUpUz6FRrW3o2cr9TEwcHbMqeinj7MNxtD87H0f5ji2n21brV0+66RTX
         R4+w==
X-Gm-Message-State: AOAM533pdCZnF2TZ8Lwy7srCQWpJnV5301sNQ5nxOQYcJMxfT7QpfSZU
        bFYgV5CqHSrwD4bSdRnGX+CkDty4r5ZIrngD1GY=
X-Google-Smtp-Source: ABdhPJy0EXOiuUChdhAbM4Pj4BJ3TwBkFjyZdVQvy0E+BUhRSKAJxkHo8bjtzlhFUSlPkOUwWYCNxOcE6ZyFyC8kYn0=
X-Received: by 2002:a4a:9210:: with SMTP id f16mr12249508ooh.13.1593095771370;
 Thu, 25 Jun 2020 07:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <87ftaxd7ky.fsf@x220.int.ebiederm.org> <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
 <87h7v1pskt.fsf@x220.int.ebiederm.org> <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
 <87h7v1mx4z.fsf@x220.int.ebiederm.org> <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
 <878sgck6g0.fsf@x220.int.ebiederm.org> <CAADnVQL8WrfV74v1ChvCKE=pQ_zo+A5EtEBB3CbD=P5ote8_MA@mail.gmail.com>
 <2f55102e-5d11-5569-8248-13618d517e93@i-love.sakura.ne.jp>
 <CAEjxPJ4e9rWWssp0CyM7GM7NP_QKkswHK7URwLZFqo5+wGecQw@mail.gmail.com>
 <20200625132551.GB3526980@kroah.com> <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
In-Reply-To: <CAEjxPJ6MEb--R=zP_wCh-zgCochgcPhy7Fp7ENTYKB2NH9c6PA@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 25 Jun 2020 10:36:00 -0400
Message-ID: <CAEjxPJ5CU18MLp4431j2w5QNy4bHj3BnivGquqwG2_p4JKDC2Q@mail.gmail.com>
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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

On Thu, Jun 25, 2020 at 10:26 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 25, 2020 at 9:25 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jun 25, 2020 at 08:56:10AM -0400, Stephen Smalley wrote:
> > > No, because we cannot label the inode based on the program's purpose
> > > and therefore cannot configure an automatic transition to a suitable
> > > security context for the process, unlike call_usermodehelper().
> >
> > Why, what prevents this?  Can you not just do that based on the "blob
> > address" or signature of it or something like that?  Right now you all
> > do this based on inode of a random file on a disk, what's the difference
> > between a random blob in memory?
>
> Given some kind of key to identify the blob and look up a suitable
> context in policy, I think it would work.  We just don't have that
> with the current interface.  With /bin/kmod and the like, we have a
> security xattr assigned to the file when it was created that we can
> use as the basis for determining the process security context.

Looks like info->cmdline could be used as that key if set; we would
just need a LSM hook to permit setting up the inode's security state
based on that key.  If that were passed to shmem_kernel_file_setup()
as the name argument, then that might also help path-based LSMs
although it seems potentially ambiguous.
