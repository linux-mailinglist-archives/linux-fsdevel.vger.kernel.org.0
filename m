Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8D42E9863
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 16:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbhADPW7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 10:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbhADPW7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 10:22:59 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC6C061793;
        Mon,  4 Jan 2021 07:22:19 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id r9so25299637ioo.7;
        Mon, 04 Jan 2021 07:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITJjjgGspK4Ymjoi4jR7CFPSAptFZU7ef58UxVF4dMU=;
        b=VPcNk6lKj+n5ZeEkjc49tG/EqZm+hrAjsWLyzVvdLpam8+/LEHuP1Fa/1AbPF8x7xO
         KC9To3qFWRmLoDa3Cwwx8+eUDZP2BSHWAy8Y7kyNr2UJ47ZrmeojBTzYIHphwyGvfQzb
         2Z9Bo8lX0LhTx0ZRGKZI0l+Iqh6m2Y2nsekS+BLvFkTMV0aidJLKdL/aiczwP5mTrH9M
         8pW+bGGPxY+kUDDi3XcWsq7GSfHt6V15Gk4HIA7Q86sBGOjSDHawmV6hq0BVB+foaCIC
         BV6I+3FvyprqeedXtuGmMZOrFp/QHSQPwYWw43dg8yGPqy3wSAZipENesgtEnKLevwAZ
         szPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITJjjgGspK4Ymjoi4jR7CFPSAptFZU7ef58UxVF4dMU=;
        b=im6Lwfzjj8u7ntIIiM8F2x7vjd3bm/ewwfk/SF3JIa1i8hpigU6MwJqxw6nH9r8yTN
         8XPnDOQHYRXHWmg+uUdnqHHCzqOPrgr8TW+AmrCNs19/uAKgXsdwQouRVTOAcvu2KIvd
         GCJSyuo9AkaZY+ukQHADQwUZFyS9GmtnqqBRsmnQdsqLzHG2JF0cfELNWVm6JKoZ66mr
         5MUkNTNrZSRyL+bakjaiIG6yWxNTsBx0k0Rcry8g+xk3r9jm8AljLJQgi7W2fUWuQ/b2
         rTgKmBB+illl/uV1di2SFwr8o6R8xTKVc4zhPmJwVDrHEPYFG/lEhlGAFnHO6VqLndzf
         Nq4g==
X-Gm-Message-State: AOAM533bIdQ8mzVcoSDQCQGYdhbYbzZyS/pNiV2mwnk11gRoWYU2vXxo
        8yc6NkkCVf5JLIC0XN443wBbHwQi0Pays1hQWOY=
X-Google-Smtp-Source: ABdhPJzNzTAdKo6eNVvLfbs3L1yit3juif7aqnqIiS4HJ5mDLnMJnLzR4H9ClF1fsfuXfZmFOL0gv1ohRI10e8ZXR+4=
X-Received: by 2002:a6b:8e41:: with SMTP id q62mr59297909iod.5.1609773738488;
 Mon, 04 Jan 2021 07:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20201221195055.35295-1-vgoyal@redhat.com> <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223185044.GQ874@casper.infradead.org> <20201223192940.GA11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223200746.GR874@casper.infradead.org> <20201223202140.GB11012@ircssh-2.c.rugged-nimbus-611.internal>
 <20201223204428.GS874@casper.infradead.org> <CAOQ4uxjAeGv8x2hBBzHz5PjSDq0Q+RN-ikgqEvAA+XE_U-U5Nw@mail.gmail.com>
 <20210104151424.GA63879@redhat.com>
In-Reply-To: <20210104151424.GA63879@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Jan 2021 17:22:07 +0200
Message-ID: <CAOQ4uxgiC5Wm+QqD+vbmzkFvEqG6yvKYe_4sR7ZUVfu-=Ys9oQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Sargun Dhillon <sargun@sargun.me>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>,
        NeilBrown <neilb@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > Since Jeff's patch is minimal, I think that it should be the fix applied
> > first and proposed for stable (with adaptations for non-volatile overlay).
>
> Does stable fix has to be same as mainline fix. IOW, I think atleast in
> mainline we should first fix it the right way and then think how to fix
> it for stable. If fixes taken in mainline are not realistic for stable,
> can we push a different small fix just for stable?

We can do a lot of things.
But if we are able to create a series with minimal (and most critical) fixes
followed by other fixes, it would be easier for everyone involved.

>
> IOW, because we have to push a fix in stable, should not determine
> what should be problem solution for mainline, IMHO.
>

I find in this case there is a correlation between the simplest fix and the
most relevant fix for stable.

> The porblem I have with Jeff's fix is that its only works for volatile
> mounts. While I prefer a solution where syncfs() is fixed both for
> volatile as well as non-volatile mount and then there is less confusion.
>

I proposed a variation on Jeff's patch that covers both cases.
Sargun is going to work on it.

Thanks,
Amir.
