Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A34B49D58B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jan 2022 23:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbiAZWhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 17:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiAZWhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:37:54 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA647C061748
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:37:53 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id h7so1760719ejf.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jan 2022 14:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V1aVCQX9KOZPo5u/xsRU/PTSxGn2oEoP0AX8hOOQy5k=;
        b=PUexGqcIVlaj1EtFvEn2PSWA9vQAteWtUkZ+SBG5roU+D7QWy3SizXM4RLxmiJb4y+
         21mBOEtVAyRn8nb9C4lDXvde8VLxHnfQnZ0on+zhj929ODZS2xaTEugtb5I1SNZ79be5
         8ljRT/rUToeF+GpC+L/8IqXWiHtkcWEEh7ol95oLbGIk8WMtqlVeVFrWEPfAAQoHE/IB
         e5NMOscmd8hztmFpDP6mVt5uWMfQqlmUDFVvZqpggisNdFMHs9yBDlmWWnPV9jU76suv
         Ls0/JoEwllWu9cP+w1FEEyV5Qg/PPmKNA4Y/O8pIlMtBA3LqRX9kVPQhN0mOQmqi42If
         Ss8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V1aVCQX9KOZPo5u/xsRU/PTSxGn2oEoP0AX8hOOQy5k=;
        b=Z366TnfJyrDcEVvzeQhOy9ZNLAgtRQ/0+x78FAmDmZ1N6+yOuFOKtCTvhotEDD4qo9
         F4oLNAeM/PpdzBkSv59723LsCpsZCgk67vNDAxuo6pvk2CBKvpbIDmTKCxKf+a1RiWlN
         E+yCpVltEB0XxpQfA80RDsD/53fepFUW/gKbFfjEGwho9HHjdr95rLC+Nvdyo+medu8s
         8Y7L3kx3LcVUlP3pXg089nmNerkc/C/z4TdgqlQxwuHn/YEadye6Da1+ytQwHz4GQ+Dz
         0CgXEIxiGENVI/fBJgukhP7vybavmNtxFskLjE8n+PNefBzmME+FBattaswuqCgWZR1k
         2VpQ==
X-Gm-Message-State: AOAM531U87GHrVsKOfK6n25HrijIxFz2VwcOZpJP36pO8RmLAYHCg4lZ
        CRrXMeAN5HZjKoi3QyR0CWxq3JFnG9N01BbNT0jp
X-Google-Smtp-Source: ABdhPJz7JLCXZXW6bWn+3igBvUCPp+jJroJkHIyDQb/GW3U8GVaEAHFqw3UaonR9mBekrO2084/k8MAzQj1Z8rint7Y=
X-Received: by 2002:a17:906:2ed0:: with SMTP id s16mr676611eji.327.1643236672195;
 Wed, 26 Jan 2022 14:37:52 -0800 (PST)
MIME-Version: 1.0
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com> <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com> <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
 <20220126072442.he4fjegfqnh72kzp@wittgenstein>
In-Reply-To: <20220126072442.he4fjegfqnh72kzp@wittgenstein>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Jan 2022 17:37:41 -0500
Message-ID: <CAHC9VhRyAxbJKBLXbW-Zj9voC2TMs3ee6jkcbS8gnNo3E0=WDg@mail.gmail.com>
Subject: Re: [PATCH] LSM: general protection fault in legacy_parse_param
To:     Christian Brauner <brauner@kernel.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
        James Morris <jmorris@namei.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 26, 2022 at 2:24 AM Christian Brauner <brauner@kernel.org> wrote:
>
> On Tue, Jan 25, 2022 at 05:18:02PM -0500, Paul Moore wrote:
> > On Tue, Oct 12, 2021 at 10:27 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> > > On 10/12/2021 3:32 AM, Christian Brauner wrote:
> > > > On Mon, Oct 11, 2021 at 03:40:22PM -0700, Casey Schaufler wrote:
> > > >> The usual LSM hook "bail on fail" scheme doesn't work for cases where
> > > >> a security module may return an error code indicating that it does not
> > > >> recognize an input.  In this particular case Smack sees a mount option
> > > >> that it recognizes, and returns 0. A call to a BPF hook follows, which
> > > >> returns -ENOPARAM, which confuses the caller because Smack has processed
> > > >> its data.
> > > >>
> > > >> Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > > >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > >> ---
> > > > Thanks!
> > > > Note, I think that we still have the SELinux issue we discussed in the
> > > > other thread:
> > > >
> > > >       rc = selinux_add_opt(opt, param->string, &fc->security);
> > > >       if (!rc) {
> > > >               param->string = NULL;
> > > >               rc = 1;
> > > >       }
> > > >
> > > > SELinux returns 1 not the expected 0. Not sure if that got fixed or is
> > > > queued-up for -next. In any case, this here seems correct independent of
> > > > that:
> > >
> > > The aforementioned SELinux change depends on this patch. As the SELinux
> > > code is today it blocks the problem seen with Smack, but introduces a
> > > different issue. It prevents the BPF hook from being called.
> > >
> > > So the question becomes whether the SELinux change should be included
> > > here, or done separately. Without the security_fs_context_parse_param()
> > > change the selinux_fs_context_parse_param() change results in messy
> > > failures for SELinux mounts.
> >
> > FWIW, this patch looks good to me, so:
> >
> > Acked-by: Paul Moore <paul@paul-moore.com>
> >
> > ... and with respect to the SELinux hook implementation returning 1 on
> > success, I don't have a good answer and looking through my inbox I see
> > David Howells hasn't responded either.  I see nothing in the original
> > commit explaining why, so I'm going to say let's just change it to
> > zero and be done with it; the good news is that if we do it now we've
>
>
> It was originally supposed to return 1 but then this got changed but - a
> classic - the documentation wasn't.

I'm shocked! :)

Thanks Christian.

-- 
paul-moore.com
