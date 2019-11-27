Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4110010B477
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 18:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfK0RaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 12:30:12 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43849 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfK0RaH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:30:07 -0500
Received: by mail-lj1-f194.google.com with SMTP id a13so2203761ljm.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 09:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHYvN6viznScLuFMhHh+plwLnzseinfGUfKYa/O5B9E=;
        b=d/o6EltX2tOPVh+pCIPqROyyLmufd3KKhy4ZzU5rMuRlVV5+ZhuGOopgQYX4213Ruf
         3geslrmCVOTUtkpnd80sPLQIxoMXA66iMjoQwR0w+MhfrWHNS9BTxZtIJ4r9oDphfitZ
         kSpLWposwiLF5+WA/vvyqLaAjNYels5rKVBPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHYvN6viznScLuFMhHh+plwLnzseinfGUfKYa/O5B9E=;
        b=YIy75NEGvw3k5VVqI/nhLYg+XILCk2nzVs661SEI3opToYgKFoJD1LRcNYO7+rWu+N
         OkQoqrvMw5wGnLu188UKdD/zXjnFe7WGfdi0ZpQ3M6FEZSJrT4UupJhgSAQs3oO68UU1
         2lZXzOnND6MHHJjdHWfwq12DnNqJH0eU13dRwxVj0Zz6ARQ06AdfF0wdWtUMKg9aKOyY
         Gvnf/wKzlP3PQswDG5FPK9oYEZH+J4LktKKyPpMLUSAVVUuK8CV3XO7PVcC709y8aGUj
         iizRJL++Lg4yYH6gijrZe+TO98YqAZnwD6n/a3Ex6Hxuvv7VS+2jbVzoIHDfhCAof7iA
         RqJQ==
X-Gm-Message-State: APjAAAV7EQdhSba3b8M+ohsGfBkjm+YgNTKM4dQ3QttXsM87l9GYsBxJ
        u0LdnJI5tFNoyVEY81Bn7e61/KbSRL0=
X-Google-Smtp-Source: APXvYqyJAaKs1LZnBmE4JQvY7NjlYWE66EodP+Lp0uUXZ33tGE/dWbf1rhsZz1kBUKV675iB+9q0qg==
X-Received: by 2002:a05:651c:1049:: with SMTP id x9mr10822164ljm.233.1574875804935;
        Wed, 27 Nov 2019 09:30:04 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id r4sm7380292ljn.64.2019.11.27.09.30.01
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 09:30:01 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id e28so1183821ljo.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2019 09:30:01 -0800 (PST)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr17881292ljj.97.1574875800695;
 Wed, 27 Nov 2019 09:30:00 -0800 (PST)
MIME-Version: 1.0
References: <157225677483.3442.4227193290486305330.stgit@buzz>
 <20191028124222.ld6u3dhhujfqcn7w@box> <CAHk-=wgQ-Dcs2keNJPovTb4gG33M81yANH6KZM9d5NLUb-cJ1g@mail.gmail.com>
 <20191028125702.xdfbs7rqhm3wer5t@box> <ac83fee6-9bcd-8c66-3596-2c0fbe6bcf96@yandex-team.ru>
 <CAHk-=who0HS=NT8U7vFDT7er_CD7+ZreRJMxjYrRXs5G6dbpyw@mail.gmail.com>
 <f0140b13-cca2-af9e-eb4b-82eda134eb8f@redhat.com> <CAHk-=wh4SKRxKQf5LawRMSijtjRVQevaFioBK+tOZAVPt7ek0Q@mail.gmail.com>
 <640bbe51-706b-8d9f-4abc-5f184de6a701@redhat.com> <CAHpGcM+o2OwXdrj+A2_OqRg6YokfauFNiBJF-BQp0dJFvq_BrQ@mail.gmail.com>
 <22f04f02-86e4-b379-81c8-08c002a648f0@redhat.com> <CAHk-=whRuPkm7zFUiGe_BXkLvEdShZGngkb=uRufgU65ogCxfg@mail.gmail.com>
 <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
In-Reply-To: <cdd48a4d-42a4-dd15-2701-e08e26fef17f@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Nov 2019 09:29:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5yeAj47x5EAuec7NCgFyYV1VtB9A+nBq+bVP9HmeepQ@mail.gmail.com>
Message-ID: <CAHk-=wh5yeAj47x5EAuec7NCgFyYV1VtB9A+nBq+bVP9HmeepQ@mail.gmail.com>
Subject: Re: [PATCH] mm/filemap: do not allocate cache pages beyond end of
 file at read
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "cluster-devel@redhat.com" <cluster-devel@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 27, 2019 at 7:42 AM Steven Whitehouse <swhiteho@redhat.com> wrote:
>
> I'll leave the finer details to Andreas here, since it is his patch, and
> hopefully we can figure out a good path forward.

As mentioned, I don't _hate_ that patch (ok, I seem to have typoed it
and said that I don't "gate" it ;), so if that's what you guys really
want to do, I'm ok with it. But..

I do think you already get the data with the current case, from the
"short read" thing. So just changing the current generic read function
to check against the size first:

  --- a/mm/filemap.c
  +++ b/mm/filemap.c
  @@ -2021,9 +2021,9 @@ static ssize_t
generic_file_buffered_read(struct kiocb *iocb,
        unsigned int prev_offset;
        int error = 0;

  -     if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
  +     if (unlikely(*ppos >= inode->i_size))
                return 0;
  -     iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
  +     iov_iter_truncate(iter, inode->i_size);

        index = *ppos >> PAGE_SHIFT;
        prev_index = ra->prev_pos >> PAGE_SHIFT;

and you're done. Nice and clean.

Then in gfs2 you just notice the short read, and check at that point.
Sure, you'll also cut read-ahead to the old size boundary, but does
anybody _seriously_ believe that read-ahead matters when you hit the
"some other node write more data, we're reading past the old end"
case? I don't think that's the case.

But I _can_ live with the patch that adds the extra "cached only" bit.
It just honestly feels pointless.

               Linus
