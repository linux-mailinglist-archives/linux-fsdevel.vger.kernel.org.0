Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E998D12BC85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2019 05:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfL1EVL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Dec 2019 23:21:11 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:40574 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfL1EVK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Dec 2019 23:21:10 -0500
Received: by mail-il1-f196.google.com with SMTP id c4so23809845ilo.7;
        Fri, 27 Dec 2019 20:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Y+1cix94haqo0ZsZpC+lfYx5UlPd+44CRyWPMgim+0=;
        b=uvMc8L18MtYcpMksUMB7qhdt6ta+8pxxwRf4JRQ4MRrEtatg2hwCRYSyxP9ezg4zsn
         xl0DF/XJh4iA6g3yDLdElfMLQ/nyonnvf34uP8qT7EpBUqlgFGEhEjbx2v6FLMnEHXRx
         YconIRzpP6cIeAS6kLWmuLxIfuZ5udQlE500TIzlXt16SG+kILLlu6CyjurHhQkiK7jg
         wEDG77Y6hZn13dVyQ+r8AnpEwQOteqoa3vbbn3jAgKCps5gjzE5ZQbxd2kRzRyTfV/sw
         k12uysvvEko81MtPac+ojvQkcHguHz0jBRBDj6XOzbXZdfJ2JXmgUTOKVcLFN4FwjOfs
         Y8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Y+1cix94haqo0ZsZpC+lfYx5UlPd+44CRyWPMgim+0=;
        b=C2SRjX/TqxPv3oXaR9/vwII3bzhfULsbaT0OlnbCA8ah/YtRG8K0wEYk8U0k5Nxzl/
         sgveLO1VWvTZYNYpzWmFWxwtcW+9kuwyMKa9v79gl+VF5fRt5Hh+v6AS8MheHCaJ6oEE
         N5/g4ptAm0avpYBOJwDVl8Y3lxqbmZwinj4MZRpAz6mzpmAQaeyzB0SUM7O7UJ0zZebg
         ZU5Jr8i2JGYlpoOtouTXQVVhQJ0htQ4olhfD6iNHjqYLK4hzd111ndQf+w5Fj9putQI9
         uID2nqm6sF+UtXPXlr2Djlxn6moKg4DKqrhxni/+IKxe0YCYEIL2+Nj6CrJfyZ2Ipgt4
         /F5Q==
X-Gm-Message-State: APjAAAUrucoKMpa4s2qHyErjbht72vwQ92IL1HEUhm05d39lez+Mp7+q
        b1pqe/MaOAgprebTYgRSdTyB8lNEufHzndH04qko4WlM
X-Google-Smtp-Source: APXvYqyJ5lGmc9fwagJ2Q+v1MFvZ6h3lqArYA5dPe3QObYiTL3r4Sr7jSW2ovhBI1d06meQczKPjuOljWWRS0YGBD80=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr50009161ilg.137.1577506870039;
 Fri, 27 Dec 2019 20:21:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577456898.git.chris@chrisdown.name> <533d188802d292fa9f7c9e66f26068000346d6c1.1577456898.git.chris@chrisdown.name>
 <CAOQ4uxhaMjn2Kusv6o6mJ36RhF7PAdmgW3kncgfov5uys=6VHw@mail.gmail.com> <20191227163536.GC442424@chrisdown.name>
In-Reply-To: <20191227163536.GC442424@chrisdown.name>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 28 Dec 2019 06:20:58 +0200
Message-ID: <CAOQ4uxjfqAtFL3N0-qJzO4OCuo0iExoO1-oG+41YrCF-4ch7NA@mail.gmail.com>
Subject: Re: [PATCH 3/3] shmem: Add support for using full width of ino_t
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        Hugh Dickins <hughd@google.com>,
        "zhengbin (A)" <zhengbin13@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 27, 2019 at 6:35 PM Chris Down <chris@chrisdown.name> wrote:
>
> Amir Goldstein writes:
> >On Fri, Dec 27, 2019 at 4:30 PM Chris Down <chris@chrisdown.name> wrote:
> >>
> >> The new inode64 option now uses get_next_ino_full, which always uses the
> >> full width of ino_t (as opposed to get_next_ino, which always uses
> >> unsigned int).
> >>
> >> Using inode64 makes inode number wraparound significantly less likely,
> >> at the cost of making some features that rely on the underlying
> >> filesystem not setting any of the highest 32 bits (eg. overlayfs' xino)
> >> not usable.
> >
> >That's not an accurate statement. overlayfs xino just needs some high
> >bits available. Therefore I never had any objection to having tmpfs use
> >64bit ino values (from overlayfs perspective). My only objection is to
> >use the same pool "irresponsibly" instead of per-sb pool for the heavy
> >users.
>
> Per-sb get_next_ino is fine, but seems less important if inode64 is used. Or is
> your point about people who would still be using inode32?
>
> I think things have become quite unclear in previous discussions, so I want to
> make sure we're all on the same page here. Are you saying you would
> theoretically ack the following series?
>
> 1. Recycle volatile slabs in tmpfs/hugetlbfs
> 2. Make get_next_ino per-sb
> 3. Make get_next_ino_full (which is also per-sb)
> 4. Add inode{32,64} to tmpfs

Not what I meant. On the contrary:
1. Recycle ino from slab is a nice idea, but it is not applicable
    along with per-sb ino allocator, so you can't use it for tmpfs
2. Leave get_next_ino() alone - it is used by things like pipe(2)
    that you don't want to mess with
3. Don't create another global ino allocator
4. inode{32,64} option to tmpfs is the only thing you need

We've made quite a big mess of a problem that is not really that big.

In this thread on zhenbin's patch you have the simple solution that
Google are using to your problem:
https://patchwork.kernel.org/patch/11254001/#23014383

The only thing keeping this solution away from upstream according to
tmpfs maintainer is the concern of breaking legacy 32bit apps.

If you make the high ino bits exposed opt-in by mount and/or Kconfig
option, then this concern would be mitigated and Google's private
solution to tmpfs ino could go upstream.

Hugh did not specify if sbinfo->next_ino is incremented under
sbinfo->stat_lock or some other lock (maybe he can share a link to
the actual patch?), but shmem_reserve_inode() already takes that
lock anyway, so I don't see the need to any further micro optimizations.

Chris, I hope the solution I am proposing is clear now and I hope I am
not leading you by mistake into another trap...

To be clear, solution should be dead simple and contained to tmpfs.
If you like, you could clone exact same solution to hugetlbfs, but no
new vfs helpers please.

Thanks,
Amir.
