Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC13D74F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 14:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhG0MYR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 08:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbhG0MYR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 08:24:17 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B152C061757;
        Tue, 27 Jul 2021 05:24:16 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id p21so7962322edi.9;
        Tue, 27 Jul 2021 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6w8a4aUlqk/6itsvXTXV8I4bfSJrS/VN067VgkiYQzU=;
        b=b65EmHbkUA4Dm7YHcfH8c4RNHcwFe9jQ16/WfaPFoGA69TyY3UwrOdrh313bVwkvvR
         pTDAyku+3o5gx3MliME4V+7KLoBIK+T+wJ5gsHD64mI36BhZ/Vs3OP07vjtHpKXXVaQT
         bqbxXh1VpVmXsOX38a/oxsHZQBQOiYhhkugXrXJ2Et1hBLoo98TsSvpvumbDXrJxTG9/
         z5TiQlhpEe2jrTbsOYzzrbnXoSdfYiQ28vQTcaMmHBDH5Kne9+iAeyXjhDTLUp9RDY6t
         b9tY080RuRhLErvMEGU+oXFrW0d497wbXB69lHFqfy8ZRlWnazRTC/uExfwNKD9GQLct
         HTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6w8a4aUlqk/6itsvXTXV8I4bfSJrS/VN067VgkiYQzU=;
        b=LskZClleewPB9lIQRMFZEKq+m4kZxYgks9Sf2snodg0alLrH6+vc0gnCr1yuXoiDuR
         CNWzDvvaTYk6AOUuE74GI5ERZdh2jR7tVCUgA+kEPFzapVFlMJxevjRjLt0yWx5q9SSP
         LMPJb/u7S5WmUIwlHsp/njRSomxczlp7O0GRoCKYqsRyQfmd8lv41VX9kcCOGF7CVMFB
         K6+Ea9HIShs2VW7y/LrGp4S8+l2On7bPCflzPT+yM6B3MzAZajHS5vehny0CgWyfiKB+
         1hwn2z4PciXx/Uso5EBWf2gifbaV2xDafdoA9sJjQAiHe0iEfvaMFxbyR51V+K15m2be
         j/Kw==
X-Gm-Message-State: AOAM533+0fHLbLhgdN3FRkXY9foOYSbdiDNbyXnjrADKmnjfhnLt6aMx
        NMhyTx6D5gw4S76XcG7DSmhLBKTOxFo6Ul8BY94=
X-Google-Smtp-Source: ABdhPJwf4Gn+YhdA0M2GXQ7vPtBi+QSd+Dj4iT+NcPpFwRDMF0DlAxBhsXbDIF34wTXgFQyC7lcQtzsx1h0uF8ezYRs=
X-Received: by 2002:aa7:c804:: with SMTP id a4mr27393572edt.294.1627388655012;
 Tue, 27 Jul 2021 05:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn> <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein> <20210607121524.GB3896@www>
 <20210617035756.GA228302@www> <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
In-Reply-To: <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 27 Jul 2021 20:24:03 +0800
Message-ID: <CADxym3aLQNJaWjdkMVAjuVk_btopv6jHrVjtP+cKwH8x6R7ojQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for initramfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>, pmladek@suse.com,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Christian,

On Thu, Jun 17, 2021 at 10:38 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
[...]
>
> Hey Menglong,
>
> Since we're very close to the next kernel release it's unlikely that
> anything will happen before the merge window has closed.
> Otherwise I think we're close. I haven't had the time to test yet but if
> nothing major comes up I'll pick it up and route it through my tree.
> We need to be sure there's no regressions for anyone using this.
>

Seems that it has been a month, and is it ok to move a little
further? (knock-knock :/)

Thanks!
Menglong Dong
