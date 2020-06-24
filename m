Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D382078FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 18:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404939AbgFXQYg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 12:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404855AbgFXQYf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:24:35 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF5CC061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 09:24:35 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i18so2608065ilk.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 09:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6buIo9Jnsstx74sRPnjGkHWYkoKstInMg6mYq7lTcg=;
        b=OcdXdqu1NtF/cm2BMdIUuBe7cEjSptV3am9fb4CygLOEWi2boWB6QtFZR0f02d5xn7
         G3hLlpW+fwnfLluXIJ2FODPehLN6YQtfDjILE0z305YBkHZOVH9sdZRC408s1Vwbkyhu
         p5h7Yta4CZI9S9IP9GaNk5io16hmVG1wImcQOzlQQx91DvhGQz2zQsD4Y23E6e0VTfb8
         lRB5RygB+vGK9FehZVnpgkmEQx38uuMiSAtC+WxFXj/OHPKZRVYtBee8jlARbju+BNbM
         QpepebXqTPO6EMUxwLUgVts+UfzDyfwOApM11U+5r4uF3Md+CQdyC70U/Ka/f6I9wzTv
         7smQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6buIo9Jnsstx74sRPnjGkHWYkoKstInMg6mYq7lTcg=;
        b=dQ3/GbrMRi0PoQkc8UrbdOFtEoU9r126LYdC+qJe2VvyvRtQJUBJF1MWQ1RxhYVlQN
         cjrrimbCI9H+tx3nmF32hvYg81GWu510SYrAWqcjF/H2ZSg5hOjXREuu63gTuJ52YWNS
         KvfcYKFN5USUjHzHpOLMsNMxw6jbstdt6lFpPwayzLw8szhUb1YM+GhveDRaB5Einn5Z
         ckjmO0hfRm0M8wwMpab42oawmkEouPOfpTqzrWbnXRbRkvMV43PEjH73siN5rnKLZlgc
         2YMo4Fu9QX263E0x2oNqZuA0AXMR624ymoLErRxN3yESv69JHvySZ+u4U3TvkLQe4Yp0
         ugOw==
X-Gm-Message-State: AOAM532IAFPs0pkkG6pBz0eR6O+Wbns0gNMQGfaLSmAOviNSMNErPvHa
        jtc81RmbA13UCC1pmDw0ffT9HjDNfAzWbeNgAO39yA==
X-Google-Smtp-Source: ABdhPJwyMaxMjx+GN+OA1NPTEC0pg+ttS2j3ABUqA6MlzuEmfXLcgRhSzsseO+tAPmHs6j2Ix+oMaA3KKEhzgFwBs5w=
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr28795634ilq.250.1593015875349;
 Wed, 24 Jun 2020 09:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200624144846.jtpolkxiqmery3uy@wittgenstein> <CAOQ4uxhkiWKt2As5kMWt6PNrRwY8QbqXKiHkz_1UFb0Za+BEuw@mail.gmail.com>
 <20200624153545.ixamvyahayzuokl7@wittgenstein>
In-Reply-To: <20200624153545.ixamvyahayzuokl7@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Jun 2020 19:24:24 +0300
Message-ID: <CAOQ4uxjgBRMMB03XEeQvtYO1poGsKwUEO4VpF7uMy8Mkur2vzw@mail.gmail.com>
Subject: Re: overlayfs regression
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 6:35 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Wed, Jun 24, 2020 at 06:25:55PM +0300, Amir Goldstein wrote:
> > On Wed, Jun 24, 2020 at 5:48 PM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > >
> > > Hey Miklosz,
> > > hey Amir,
> > >
> > > We've been observing regressions in our containers test-suite with
> > > commit:
> > >
> > > Author: Miklos Szeredi <mszeredi@redhat.com>
> > > Date:   Tue Mar 17 15:04:22 2020 +0100
> > >
> > >     ovl: separate detection of remote upper layer from stacked overlay
> > >
> > >     Following patch will allow remote as upper layer, but not overlay stacked
> > >     on upper layer.  Separate the two concepts.
> > >
> > >     This patch is doesn't change behavior.
> > >
> > >     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > >
> >
> > Are you sure this is the offending commit?
> > Look at it. It is really moving a bit of code around and should not
> > change logic.
> > There are several other commits in 5.7 that could have gone wrong...
>
> Yeah, most likely. I can do a bisect but it might take a little until I
> get around to it. Is that ok?
>

ok.
I thought you pointed to a commit that you bisected the regression to.
I guess not.

Thanks,
Amir.
