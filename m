Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70CBAFB47E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 17:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbfKMQAr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 11:00:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40399 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728199AbfKMQAr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 11:00:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id 22so2222615oip.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2019 08:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GcxXz/hy0yD4Dv/1aRup6B2d7cDG6vSzxW491ZecOnY=;
        b=IkbtOt20hldM/bTM0mBSZl/lLqhj4os3wESjTi8qxWbG3L81gb5wKmTMIXPKKUGmJK
         NNgkdbCScyvuJFDjMLFTdTsvkPUUGcyzZ5LAzlR2NI2iYw2KbA09cuEKLSaSZnMVrGzx
         T/YO7QC4Q2XXwU+K6ElpD1LWMIflls/i19bT4v7D7mepGI1+BVABmGM/KFIb2HiMtf5V
         VYGFnpcXMIBPgH3YGcbfVQit3z9aHZRd4455Xrn65g5X4mtB9J+a1ARi8O63tOSrydOc
         tHE82uxnEeOpFrB7WM55hx/eR9Pz/5VeIDKJUAxwkdw3FHvbSEgMaabxRtI1ejn6g6H6
         cNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GcxXz/hy0yD4Dv/1aRup6B2d7cDG6vSzxW491ZecOnY=;
        b=FYVUB3dvoxaXt0tT/eQ0abWOzumXhzNsWrh/LCKpY42auwHgxFk07Ah3Zcj7wobFB/
         YPjsxcbZkSqb8rVeTjjxINHX140O2PeXw6NaCNj10g90r0WsP0XWYdCsFKkj0t7FPJQv
         TYKG6EJxeNCdrkkJtLlBMIVwEZYB/ufU97us8Zqv7hA8uRVQd77hw0HXxZxZR2g2LK1t
         7ldVlh6eOd9/pDjMfyuAi+nGYP7JIBxboxLvyUCfl1a8jl01VbkCLkMZ2n+ir0muxCWK
         18PJhQ9mXkTk3E3kxUJ66G6XsMF3788IqSqSunsLvWZ1O3AeDZkqxhEQijMS2vB3dol/
         2/yA==
X-Gm-Message-State: APjAAAWAioIrnXsLAeCECbQo0eP+ZAFKNxDWQL7TSZXeSWGJFESSO8o/
        it8r7mWqx2hO/b3ZkqBz13mDKXEPvwOdUCDRwLUY3g==
X-Google-Smtp-Source: APXvYqx6LdgXxfOfErKByXfyOGZGi4ldWQzJ/kKriqc83ob1MBYgGQ3TZUA+L19NJgdsNKPAT47WF1DzoyGAlam7mec=
X-Received: by 2002:aca:ccd1:: with SMTP id c200mr4406127oig.157.1573660845922;
 Wed, 13 Nov 2019 08:00:45 -0800 (PST)
MIME-Version: 1.0
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com> <20191112232239.yevpeemgxz4wy32b@wittgenstein>
In-Reply-To: <20191112232239.yevpeemgxz4wy32b@wittgenstein>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 13 Nov 2019 17:00:19 +0100
Message-ID: <CAG48ez0j_7NyCyvGn8U8NS2p=CQQb=me-5KTa7k5E6xpHJphaA@mail.gmail.com>
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:22 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
> On Sun, Nov 03, 2019 at 04:55:48PM +0200, Topi Miettinen wrote:
> > Several items in /proc/sys need not be accessible to unprivileged
> > tasks. Let the system administrator change the permissions, but only
> > to more restrictive modes than what the sysctl tables allow.
> >
> > Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> > ---
> >  fs/proc/proc_sysctl.c | 41 +++++++++++++++++++++++++++++++----------
> >  1 file changed, 31 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> > index d80989b6c344..88c4ca7d2782 100644
> > --- a/fs/proc/proc_sysctl.c
> > +++ b/fs/proc/proc_sysctl.c
> > @@ -818,6 +818,10 @@ static int proc_sys_permission(struct inode *inode, int
> > mask)
> >         if ((mask & MAY_EXEC) && S_ISREG(inode->i_mode))
> >                 return -EACCES;
> >
> > +       error = generic_permission(inode, mask);
> > +       if (error)
> > +               return error;

In kernel/ucount.c, the ->permissions handler set_permissions() grants
access based on whether the caller has CAP_SYS_RESOURCE. And in
net/sysctl_net.c, the handler net_ctl_permissions() grants access
based on whether the caller has CAP_NET_ADMIN. This added check is
going to break those, right?
