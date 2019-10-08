Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D073CF009
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Oct 2019 02:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfJHAuu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Oct 2019 20:50:50 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39570 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbfJHAuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:50:50 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so7677478plp.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Oct 2019 17:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=axeGqpfr6+WBOJhK9o80hxtWSzlwNphv8qzRJ2eavqQ=;
        b=qVmPJN76V7+IyYv7ojUmBLD30Dm2ha0LRJQd6sJpxtBmoUhbUJR6rhRwoW+qo1SQNW
         HemeuvA6y3d2XEOQV7rqf8Kq3UjftHoWArb7rENjbAkM0JI2Whde7+U/piSSkoJ09i24
         UZMy7sigYFhmCfHkBIAdKEmi4WwtdpfZRx6VygLJQYvD1vdXZJQmvxl+4YhoMJLq8Edp
         WUdYqpDf6KnhjTOEE8IlcG2hc7/5IPmcqI+CLjXE1sT37Oq/H4rVvQ7JC9bVkkz7L9dP
         u711EW+OYDgdsMXAui2gSEKSxs1sjK8amOQv9z2m9rSq5Ww+fKbf5PHhD5brBDWwY6w+
         yCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=axeGqpfr6+WBOJhK9o80hxtWSzlwNphv8qzRJ2eavqQ=;
        b=qCrl+D+A0UtpEZL2ZYboX+FIdc9PeeggtTyOyLWvRyoewW5yeN4T5s5VrubHweLC+k
         QGgONXqW/vpJmpNLvUdrZJD6sR7toZ1BA2En/RTKdvnGoCjSQEI2TrhXGEpHqKdZh9mv
         36FM6COsC6el5bL7WYUIagV4IWbnREACjpygrsCDgscTBjA3oV69eHTAHGYJ+5QbOmLz
         NzkHSH4V4IFnEXsTaHLg8K1/DitCWv7FN9IvVctyc9ks2GOLvSD5py0zFV6rhYzASx3d
         uD7e+ZHrDqIQjDTUgXE7T7OgQ/9if2wRP918NQlW2Dtu0tKlpYEr2k7TuDZLbOuZtZhg
         Zz7Q==
X-Gm-Message-State: APjAAAUuFLLHJcsNTOkvkpw81ElI+PteGUqJE8zGHLOjOvXd8Hi6v/0D
        h1983scIyqzgobmZfTE55cJtMA==
X-Google-Smtp-Source: APXvYqyWK6wIFQTZoeOQY+viUZxjZToqVGdL8HVPYQTIrKN/LxfR5KtyDW1lfIqPOFd+SsAV8GkQAg==
X-Received: by 2002:a17:902:524:: with SMTP id 33mr32812268plf.123.1570495848323;
        Mon, 07 Oct 2019 17:50:48 -0700 (PDT)
Received: from [100.112.81.222] ([104.133.9.110])
        by smtp.gmail.com with ESMTPSA id d76sm16582383pfd.185.2019.10.07.17.50.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Oct 2019 17:50:47 -0700 (PDT)
Date:   Mon, 7 Oct 2019 17:50:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Laura Abbott <labbott@redhat.com>
cc:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: mount on tmpfs failing to parse context option
In-Reply-To: <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
Message-ID: <alpine.LSU.2.11.1910071655060.4431@eggly.anvils>
References: <d5b67332-57b7-c19a-0462-f84d07ef1a16@redhat.com> <d7f83334-d731-b892-ee49-1065d64a4887@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 7 Oct 2019, Laura Abbott wrote:
> On 9/30/19 12:07 PM, Laura Abbott wrote:
> > Hi,
> > 
> > Fedora got a bug report https://bugzilla.redhat.com/show_bug.cgi?id=1757104
> > of a failure to parse options with the context mount option. From the
> > reporter:
> > 
> > 
> > $ unshare -rm mount -t tmpfs tmpfs /tmp -o
> > 'context="system_u:object_r:container_file_t:s0:c475,c690"'
> > mount: /tmp: wrong fs type, bad option, bad superblock on tmpfs, missing
> > codepage or helper program, or other error.
> > 
> > 
> > Sep 30 16:50:42 kernel: tmpfs: Unknown parameter 'c690"'
> > 
> > I haven't asked the reporter to bisect yet but I'm suspecting one of the
> > conversion to the new mount API:
> > 
> > $ git log --oneline v5.3..origin/master mm/shmem.c
> > edf445ad7c8d Merge branch 'hugepage-fallbacks' (hugepatch patches from
> > David Rientjes)
> > 19deb7695e07 Revert "Revert "Revert "mm, thp: consolidate THP gfp handling
> > into alloc_hugepage_direct_gfpmask""
> > 28eb3c808719 shmem: fix obsolete comment in shmem_getpage_gfp()
> > 4101196b19d7 mm: page cache: store only head pages in i_pages
> > d8c6546b1aea mm: introduce compound_nr()
> > f32356261d44 vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the
> > new mount API
> > 626c3920aeb4 shmem_parse_one(): switch to use of fs_parse()
> > e04dc423ae2c shmem_parse_options(): take handling a single option into a
> > helper
> > f6490b7fbb82 shmem_parse_options(): don't bother with mpol in separate
> > variable
> > 0b5071dd323d shmem_parse_options(): use a separate structure to keep the
> > results
> > 7e30d2a5eb0b make shmem_fill_super() static
> > 
> > 
> > I didn't find another report or a fix yet. Is it worth asking the reporter
> > to bisect?
> > 
> > Thanks,
> > Laura
> 
> Ping again, I never heard anything back and I didn't see anything come in
> with -rc2

Sorry for not responding sooner, Laura, I was travelling: and dearly
hoping that David or Al would take it.  I'm afraid this is rather beyond
my capability (can I admit that it's the first time I even heard of the
"context" mount option? and grepping for "context" has not yet shown me
at what level it is handled; and I've no idea of what a valid "context"
is for my own tmpfs mounts, to start playing around with its parsing).

Yes, I think we can assume that this bug comes from f32356261d44 ("vfs:
Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API")
or one of shmem_parse ones associated with it; but I'm pretty sure that
it's not worth troubling the reporter to bisect.  I expect David and Al
are familiar with "context", and can go straight to where it's handled,
and see what's up.

(tmpfs, very tiresomely, supports a NUMA "mpol" mount option which can
have commas in it e.g "mpol=bind:0,2": which makes all its comma parsing
awkward.  I assume that where the new mount API commits bend over to
accommodate that peculiarity, they end up mishandling the comma in
the context string above.)

And since we're on the subject of new mount API breakage in tmpfs, I'll
take the liberty of repeating this different case, reported earlier and
still broken in rc2: again something that I'd be hard-pressed to fix
myself, without endangering some other filesystem's mount parsing:-

My /etc/fstab has a line in for one of my test mounts:
tmpfs                /tlo                 tmpfs      size=4G               0 0
and that "size=4G" is what causes the problem: because each time
shmem_parse_options(fc, data) is called for a remount, data (that is,
options) points to a string starting with "size=4G,", followed by
what's actually been asked for in the remount options.

So if I try
mount -o remount,size=0 /tlo
that succeeds, setting the filesystem size to 0 meaning unlimited.
So if then as a test I try
mount -o remount,size=1M /tlo
that correctly fails with "Cannot retroactively limit size".
But then when I try
mount -o remount,nr_inodes=0 /tlo
I again get "Cannot retroactively limit size",
when it should have succeeded (again, 0 here meaning unlimited).

That's because the options in shmem_parse_options() are
"size=4G,nr_inodes=0", which indeed looks like an attempt to
retroactively limit size; but the user never asked "size=4G" there.

Hugh
