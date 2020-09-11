Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32986266724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 19:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgIKRiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgIKMpx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:45:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C8DC061573;
        Fri, 11 Sep 2020 05:44:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m12so8243877otr.0;
        Fri, 11 Sep 2020 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nj6ebQ1LelO8tJiVip6k1rVrHkVeMlZ4zIMMoXNlsek=;
        b=kox2nOM5Vx8QiGrZU9+tMK1b8MvwNRGG8itgc1QVjK3pwmHR6je1TvzdIPsyiREIWM
         ikGCzLVhGlYgMVlLcj517cXSxozvRGeRTJO97ZpJDIaHzZfaMAabzq0Gd2ONDPJOdrWD
         i0kDIwMmU5Mliy8zicz80Rs8NW7c2u+SrgCAVXTCFcRWnub1E/IuEziwZlJ5haexf//W
         g3gZ3UHHSmlHOfjPx0mMxEIP2dvqkPnLSWCiN/ooqi8XUpP6wPAKwNOjeL/4UvTr9X9/
         9+bPlg4b9kz9DUZCSK/owoUFNsFKF/kWqVe9FBPcCxNA4iYzOYFg0+438BZ1o7ATcmV4
         BcTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nj6ebQ1LelO8tJiVip6k1rVrHkVeMlZ4zIMMoXNlsek=;
        b=efe6rBAtsz9viULN7AvexnUDAD4I39M6dSVfKsSrfrXniCRyf91R+e7YuYWk9enQwT
         PSjvVfq83+sDiF8xwHmYTIvhKpRB8DJ2pjLG337ghbj9uZyTrD9l/w2VesunDyf6MLJ0
         x379B3PmgoT0AdUSnMPZCkKPdJKqyWF4JtmOvEasUkWtXRNYlFKPbnjk8IlokzBW5tMg
         WxjleTS/pComPtriynKxejntoRJwGGg2FENmn1m3NM5131bCgUSQ9sO2mYuzInG881kY
         YMwGFuzCmqmkyN+ZhMJrKVg7baj0RAP6xH3Q9kfCnF/U5L2rWjhDdCq0sESdMQbLoOeW
         atNQ==
X-Gm-Message-State: AOAM532tekXXyVyP9Ohe30l+0znAvnEZucS3NnsOFV0W3zx+phCDfdWZ
        pjOLYv99rhq6X/yr8yGXFJgXEMh+HzpAgKeC/J0=
X-Google-Smtp-Source: ABdhPJy9smo79lDaJbFYlXf+SK4TUVokeX1B7e4jY2L84PaTnKK4hDfODNKlWttxoZ4ywTuul1Ow3+rp5TkOZp6H4kU=
X-Received: by 2002:a9d:a2b:: with SMTP id 40mr1134118otg.308.1599828254741;
 Fri, 11 Sep 2020 05:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <159827188271.306468.16962617119460123110.stgit@warthog.procyon.org.uk>
 <159827190508.306468.12755090833140558156.stgit@warthog.procyon.org.uk>
 <CAKgNAkho1WSOsxvCYQOs7vDxpfyeJ9JGdTL-Y0UEZtO3jVfmKw@mail.gmail.com>
 <667616.1599063270@warthog.procyon.org.uk> <CAKgNAkhjDB9bvQ0h5b13fkbhuP9tYrkBQe7w1cbeOH8gM--D0g@mail.gmail.com>
In-Reply-To: <CAKgNAkhjDB9bvQ0h5b13fkbhuP9tYrkBQe7w1cbeOH8gM--D0g@mail.gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Fri, 11 Sep 2020 14:44:03 +0200
Message-ID: <CAKgNAkh9h3aA1hiYownT2O=xg5JmZwmJUCvQ1Z4f85MTq-26Fw@mail.gmail.com>
Subject: Re: [PATCH 4/5] Add manpage for fsopen(2) and fsmount(2)
To:     David Howells <dhowells@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

A ping for these five patches please!

Cheers,

Michael

On Wed, 2 Sep 2020 at 22:14, Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> On Wed, 2 Sep 2020 at 18:14, David Howells <dhowells@redhat.com> wrote:
> >
> > Michael Kerrisk (man-pages) <mtk.manpages@gmail.com> wrote:
> >
> > > The term "filesystem configuration context" is introduced, but never
> > > really explained. I think it would be very helpful to have a sentence
> > > or three that explains this concept at the start of the page.
> >
> > Does that need a .7 manpage?
>
> I was hoping a sentence or a paragraph in this page might suffice. Do
> you think more is required?
>
> Cheers,
>
> Michael
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
