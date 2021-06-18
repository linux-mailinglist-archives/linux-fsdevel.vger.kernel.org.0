Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B827B3AD42F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 23:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234457AbhFRVNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Jun 2021 17:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhFRVNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Jun 2021 17:13:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4046C06175F
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 14:10:55 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id p7so18694701lfg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IggsOVtZWaDfaAjVQj4i9sjHXM/g9u+SuRPy3G5buhU=;
        b=IdCDb8XLNd4gSRp6kXJhby/ljjp+PXKky4uW7qFCR1/rkcVRP08toOusxumJVYjA6X
         kUQdieqI0aumZ0iOyCbaZQ+jH9t0sOwuxFGVbSA2DavBqJkBHAM5Sz5MMTfl4icGYGrK
         jR9+83dk7r+H/+jzIxFclci70l2r7nrmDRCcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IggsOVtZWaDfaAjVQj4i9sjHXM/g9u+SuRPy3G5buhU=;
        b=DngshTrvnece4RS83qtMp4RxTq+GQDIDd/k7MUashoJuTFJpLGqWv1y0CIC9p0Dzr6
         UFyfPxibhncio8qnSoFlVsgJHTRP6DS0p9xPs1uRqniNyskbjgUpBZn90RQfnUaFq7p9
         pNkZuJlDUpYfZdnboiiay5Cg+YkykapPR/NGqFy64fF1exwE0qluhWBacRrJkoTtlSof
         v20kRXDb6m9/Q0iZUso4zY3X5QJj+1A/UWqNPXYePbuUj39rmEd0GKe689B36bdt02jw
         y6X9RaSDBsZd2N/mGKuoJBOY3Z2CSXJwspgxeKmsafO9d4wIIy2GbxPRgWZyEXhJokiu
         KuRQ==
X-Gm-Message-State: AOAM533pYqbyBPRpaoFAt8j/0H3p7onqn7Zh4n+M8cC/4B/KB6KRZL7R
        lrWHSyq6ZA1STrjBUgDjakopOFedmS+PgK6r
X-Google-Smtp-Source: ABdhPJxGrq+GysvwcycMmNQGdowu4Iv49trN+15ga/7AxBzuGr13PP8BXg9CTeGDRcXdcqEzn0tw9g==
X-Received: by 2002:a19:4949:: with SMTP id l9mr4527240lfj.642.1624050654042;
        Fri, 18 Jun 2021 14:10:54 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v2sm45767lfd.224.2021.06.18.14.10.52
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jun 2021 14:10:53 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id h15so214615lfv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 18 Jun 2021 14:10:52 -0700 (PDT)
X-Received: by 2002:a05:6512:baa:: with SMTP id b42mr4514578lfv.487.1624050652225;
 Fri, 18 Jun 2021 14:10:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623972518.git.osandov@fb.com> <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
 <CAHk-=whRA=54dtO3ha-C2-fV4XQ2nry99BmfancW-16EFGTHVg@mail.gmail.com>
 <YMz3MfgmbtTSQljy@zeniv-ca.linux.org.uk> <YM0C2mZfTE0uz3dq@relinquished.localdomain>
 <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
In-Reply-To: <YM0I3aQpam7wfDxI@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Jun 2021 14:10:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
Message-ID: <CAHk-=wgiO+jG7yFEpL5=cW9AQSV0v1N6MhtfavmGEHwrXHz9pA@mail.gmail.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Omar Sandoval <osandov@osandov.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 18, 2021 at 1:58 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jun 18, 2021 at 01:32:26PM -0700, Omar Sandoval wrote:
>
> > RWF_ENCODED is intended to be used like this:
> >
> >       struct encoded_iov encoded_iov = {
> >               /* compression metadata */ ...
> >       };
> >       char compressed_data[] = ...;
> >       struct iovec iov[] = {
> >               { &encoded_iov, sizeof(encoded_iov) },
> >               { compressed_data, sizeof(compressed_data) },
> >       };
> >       pwritev2(fd, iov, 2, -1, RWF_ENCODED);
> >
> > Basically, we squirrel away the compression metadata in the first
> > element of the iovec array, and we use iov[0].iov_len so that we can
> > support future extensions of struct encoded_iov in the style of
> > copy_struct_from_user().
>
> Yecchhh...

Al, this has been true since the beginning, and was the whole point of the set.

> Just put the size of the encoded part first and be done with that.
> Magical effect of the iovec sizes is a bloody bad idea.

That makes everything uglier and more complicated, honestly. Then
you'd have to do it in _two_ operations ("get the size, then get the
rest"), *AND* you'd have to worry about all the corner-cases (ie
people putting the structure in pieces across multiple iov entries.

So it would be slower, more complex, and much more likely to have bugs.

So no. Not acceptable. The "in the first iov" is simple, efficient,
and avoids all the problems.

The size *is* encoded already - in the iov itself. Encoding it
anywhere else is much worse.

The only issue I have is that the issue itself is kind of ugly -
regardless of any iov issues. And the "encryption" side of it doesn't
actually seem to be relevant or solvable using this model anyway, so
that side is questionable.

The alternative would be to have an ioctl rather than make this be
about the IO operations (and then that encoded data would be
explicitly separate).

Which I suggested originally, but apparently people who want to use
this had some real reasons not to.

But encoding the structure without having the rule of "first iov only"
is entirely unacceptable to me. See above. It's objectively much much
worse.

             Linus
