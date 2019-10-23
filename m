Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC1FCE2525
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 23:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407358AbfJWVV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 17:21:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37811 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406354AbfJWVV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:21:58 -0400
Received: by mail-wr1-f67.google.com with SMTP id e11so14932150wrv.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 14:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uWXqyVdZG3xij4IRJ1MV+cjGYgJRv84wocdAvFPyUGw=;
        b=btkMdlhcqiLL4QXkhs5YlI6F1v2oSHe4zZEcCDgSr1zsOnF35f4loM98ynwo9iQHwA
         j30kC7oazzysTW4ie+aqnZvwYagYItN/V24x/0SjmQmf8nmiyJmzXOlvw6INR3nnd/lA
         42VFBHun7lAe1o8HPaqZQitdWU5EBlH8kf78hQTHhn/YLjsBbYPOgZDf9eTP6BIfdcTa
         f4ONIzsrvqFlaRqWtniHSNSbL9vfdwcitBtfl1BRlTm79ipqTjALXMxh4f2Ji24d6e9m
         6ZCsFOJL2wzty8pJ65ESJzFVuujXGEuODNRLKriYZNGgliA4BipvFq3A7S1CPYHLeQ5V
         NJxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uWXqyVdZG3xij4IRJ1MV+cjGYgJRv84wocdAvFPyUGw=;
        b=s9W2M5gwP2SHGUZvXEUD2kJdq8R+FRZwqfCQC6q4cxWqC9nAT8qLJBh9yX/jAzidYN
         T56aLTty8I2NF5cJEy6aogcBPty1D2HRh7uc5bTtfNH9sHio7UqkxTwdT5AzFrB4cl0K
         ZBxZDrEGzBE8m0Puw+LiZVaBhLVFy/knsqx/9/AtMd4L/1FuS7Mn6g+s459cp0QS80m9
         Kmr+RZDT7B0jaTzVZloTc47wig0j6QvvI6fBPgzhBs1LKDets4gEZI7pTnSMkDaZ8GVs
         GOd+YTyTtH1ohHwi71p5XwSsys5KQR6sUsRbjwUWcSI9oFAUdY6Qy4CINVi9DB46I8dg
         O1DQ==
X-Gm-Message-State: APjAAAX6r76N/P0wYl01t16NAW7JhSOVl/GSS4AkM4/4V6vklkTurMoR
        e5M7GsPF1SZwRQXjqvV4PW3MQZdFt12oB+QBczU=
X-Google-Smtp-Source: APXvYqwU6pJOfcoBg13Lj1J6h3Lbj5xdKyqv4RTt/8QXaqFogbCJ0dK/BHQhFmzQSi6mG0lkfC41KzjRhYzHxUHUpSc=
X-Received: by 2002:a5d:498a:: with SMTP id r10mr673495wrq.129.1571865716507;
 Wed, 23 Oct 2019 14:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali>
In-Reply-To: <20191023171611.qfcwfce2roe3k3qw@pali>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 23 Oct 2019 23:21:44 +0200
Message-ID: <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 7:16 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> wrot=
e:
> On Wednesday 23 October 2019 16:21:19 Chris Murphy wrote:
> > On Wed, Oct 23, 2019 at 1:50 PM Pali Roh=C3=A1r <pali.rohar@gmail.com> =
wrote:
> > > I do not think that kernel guarantee for any filesystem that rename
> > > operation would be atomic on underlying disk storage.
> > >
> > > But somebody else should confirm it.
> >
> > I don't know either or how to confirm it.
>
> Somebody who is watching linuxfs-devel and has deep knowledge in this
> area... could provide more information.

This is filesystem specific.
For example on UBIFS we make sure that the rename operation is atomic.
Changing multiple directory entries is one journal commit, so either it hap=
pened
completely or not at all.
On JFFS2, on the other hand, rename can degrade to a hard link.

I'd go so far and claim that any modern Linux filesystem guarantees
that rename is atomic.
But bugs still happen, crashmonkey found some interesting issues in
this area[0].

[0] http://www.cs.utexas.edu/~vijay/papers/osdi18-crashmonkey.pdf

--=20
Thanks,
//richard
