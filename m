Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441D549F0AB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 02:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345156AbiA1Bow (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 20:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345147AbiA1Bov (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:44:51 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEB8C061748
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 17:44:51 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m11so6562551edi.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jan 2022 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYXIIUyrLfzJaPeKZf3W/sgGrDvN0wMAV7bAC7WPD3M=;
        b=1KTeQNu1m8qReF3FsqMysxKY1VxJzC4sYVTjAyHhsq+a1vlVLpM2YLsiNMZS0x3wXm
         Y0VJVuyXs9YWnnBcgzbPTYFgF617dw+mg/0Eb3g9Wmao8ObSTU2P1ITppGOx1iXWCCpw
         0DSwoAM6EKzCh3OJQA0PwxS1xJElPjgoBpclzHHZokRNXUmNdMN6JkPqR/Nala+VLtYB
         suqI6XxfkTZARJ+9S/b/C7d0dRPHa6UJ5D2iXTSQBpTd0NDRsxKzGiVG4SZaeKbEonVc
         Phanfy++vHctLte9yA7dBz+90Od82cx10pUo7k7Rz6AUjPn1YAIe5KVF5O17qkw0J7FX
         xj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYXIIUyrLfzJaPeKZf3W/sgGrDvN0wMAV7bAC7WPD3M=;
        b=i2ccdnvQAdDXPr2toVDjQ5NrfOS1Zo0YEIKU8iDENmVJnSLUfo18riE3jadOKLFfoZ
         XpHNm5ZFp0FgXn98c+oD4hdze7u/k7dS4d/B0HhwpdXx1dGg8vh/8uSxyCze66pkYH9I
         Gxj+JIFjUMxWV0QnpWepFMuLDBjrZ7VvP6VOd8bJIB/6AfglWhrBrgsUvRnx4sZtHbmF
         GXnjGpjEKGn/gLgrt+T7BYdtuMZgkCZM0XEndgmRYrkasAgNKWxTwJh6wjFvciDGADoz
         nQ821no4F2betMec3i8GIslvuhTuQmECpEjynKRavL6FJErr2v/AL9pSptxzEf2LtpGo
         dbTQ==
X-Gm-Message-State: AOAM533YRGfS0bMGl7HfBEfDw314ydxohu5jMjQLrcKAb+9X57HL/orl
        uO7M8TlZ0ZWLK0sDtb1xsGErcgS4WEzV6uuG7VT9
X-Google-Smtp-Source: ABdhPJzjF/RplyACj/w8hLgXo1uknB2oGFSxj5v5sDp4f/gCdMO3xDPCBYlF1V1ov4ADLrAbCjCk2M9vJHrSvIe79xk=
X-Received: by 2002:a05:6402:2683:: with SMTP id w3mr6080257edd.405.1643334289633;
 Thu, 27 Jan 2022 17:44:49 -0800 (PST)
MIME-Version: 1.0
References: <018a9bb4-accb-c19a-5b0a-fde22f4bc822.ref@schaufler-ca.com>
 <018a9bb4-accb-c19a-5b0a-fde22f4bc822@schaufler-ca.com> <20211012103243.xumzerhvhklqrovj@wittgenstein>
 <d15f9647-f67e-2d61-d7bd-c364f4288287@schaufler-ca.com> <CAHC9VhT=dZbWzhst0hMLo0n7=UzWC5OYTMY=0x=LZ97HwG0UsA@mail.gmail.com>
 <a19e0338-5240-4a6d-aecf-145539aecbce@schaufler-ca.com> <3daaf037-2e67-e939-805f-57a61d67f7b8@namei.org>
In-Reply-To: <3daaf037-2e67-e939-805f-57a61d67f7b8@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 27 Jan 2022 20:44:38 -0500
Message-ID: <CAHC9VhSt+c6QksHef=kx3dN_ouVZG0_a6FERzXs2-uzKmyE_zg@mail.gmail.com>
Subject: Re: [PATCH v2] LSM: general protection fault in legacy_parse_param
To:     James Morris <jmorris@namei.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Brauner <christian@brauner.io>,
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

On Thu, Jan 27, 2022 at 12:46 PM James Morris <jmorris@namei.org> wrote:
> On Thu, 27 Jan 2022, Casey Schaufler wrote:
>
> > The usual LSM hook "bail on fail" scheme doesn't work for cases where
> > a security module may return an error code indicating that it does not
> > recognize an input.  In this particular case Smack sees a mount option
> > that it recognizes, and returns 0. A call to a BPF hook follows, which
> > returns -ENOPARAM, which confuses the caller because Smack has processed
> > its data.
> >
> > The SELinux hook incorrectly returns 1 on success. There was a time
> > when this was correct, however the current expectation is that it
> > return 0 on success. This is repaired.
> >
> > Reported-by: syzbot+d1e3b1d92d25abf97943@syzkaller.appspotmail.com
> > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
>
>
> Acked-by: James Morris <jamorris@linux.microsoft.com>

Looks good to me too, thanks Casey.  Since James' already ACK'd it, I
went ahead and pulled this into selinux/next.

> > ---
> >  security/security.c      | 17 +++++++++++++++--
> >  security/selinux/hooks.c |  5 ++---
> >  2 files changed, 17 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/security.c b/security/security.c
> > index 3d4eb474f35b..e649c8691be2 100644
> > --- a/security/security.c
> > +++ b/security/security.c
> > @@ -884,9 +884,22 @@ int security_fs_context_dup(struct fs_context *fc, struct
> > fs_context *src_fc)
> >       return call_int_hook(fs_context_dup, 0, fc, src_fc);
> >  }
> >
> > -int security_fs_context_parse_param(struct fs_context *fc, struct
> > fs_parameter *param)
> > +int security_fs_context_parse_param(struct fs_context *fc,
> > +                                 struct fs_parameter *param)
> >  {
> > -     return call_int_hook(fs_context_parse_param, -ENOPARAM, fc, param);
> > +     struct security_hook_list *hp;
> > +     int trc;
> > +     int rc = -ENOPARAM;
> > +
> > +     hlist_for_each_entry(hp, &security_hook_heads.fs_context_parse_param,
> > +                          list) {
> > +             trc = hp->hook.fs_context_parse_param(fc, param);
> > +             if (trc == 0)
> > +                     rc = 0;
> > +             else if (trc != -ENOPARAM)
> > +                     return trc;
> > +     }
> > +     return rc;
> >  }
> >
> >  int security_sb_alloc(struct super_block *sb)
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 5b6895e4fc29..371f67a37f9a 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2860,10 +2860,9 @@ static int selinux_fs_context_parse_param(struct
> > fs_context *fc,
> >               return opt;
> >
> >       rc = selinux_add_opt(opt, param->string, &fc->security);
> > -     if (!rc) {
> > +     if (!rc)
> >               param->string = NULL;
> > -             rc = 1;
> > -     }
> > +
> >       return rc;
> >  }

-- 
paul-moore.com
