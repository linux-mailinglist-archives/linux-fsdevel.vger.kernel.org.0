Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B43415482D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 16:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgBFPfZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 10:35:25 -0500
Received: from mail-vs1-f45.google.com ([209.85.217.45]:39882 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFPfZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:35:25 -0500
Received: by mail-vs1-f45.google.com with SMTP id p14so4031588vsq.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 06 Feb 2020 07:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CTYvh4/2DVv7Fth9DqQXmsOx8BmhbRQSRexdWwOw5NY=;
        b=Bs+JAuUIVQiMmzgN1ouuEUuJi7qsSYKAwBln/X6V/HG7f37kHuWNUQNVjNL52BhsAL
         j1Ng2G+9om7UYltk4OfW3C8h37+8nYiXixISOTawNHmCZ2kYY5vCm6eZ2xAt6qLu3O7l
         lS/x522Obb1W0z6U13ePdE75kIus1FHkLPFt0KiNCQJpR/ddEr0fJ5iblDORTH6YLPvH
         byYKzONEwSQFy7ul9ss2GnFKfdy0ntcSVVNh+/H3Qj5rbwhdBxGXV9oP/vnt13CCcHDP
         aA6HJtHQhAf4ucqe+moxCPPelhnZ/YFrLjvcm/mu91TxuS9rkHYAJQ7BF0kK/h3Wo4gU
         K3dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CTYvh4/2DVv7Fth9DqQXmsOx8BmhbRQSRexdWwOw5NY=;
        b=SA97jVoT9nzhctLM+G++jbfCIugJE6CTzTHCkK3kPoYGG4/ypUaKa4gyLHKDvz1QAY
         K40s8qMLVphJAGnBbUJFjgO9JK2lhv4zsjYRXjhFl5IFFKF1VM6i5sLpgUQdhtVmUpLt
         L07dbgWAOVP32tuBnDo5N5jPUnnI807C3gAeXIaHuptgZnoszKwyubrap4GUZpHDYnXB
         1RdamWZyvQ/V/oyfSPbXVL5R8tzuzDfLG7OVLAealdYeMhOqGV0AxZKDBsnIJtTRW7Vi
         gJbU3Jr9cwwpI8xWNmXixTH61Ovz0ld1SIV0WvTejZD+0TJxST39XrWB/A9Xj445qE0I
         U9qA==
X-Gm-Message-State: APjAAAUIaRmM78P96TYVQugiCHW6c9hKefiMtDVKxbLhwwteiJtfMriW
        GixuxF1dA2Fdd361DNpj9mN2I8GK7WjEFT+ZffJRzQ==
X-Google-Smtp-Source: APXvYqyhB2jydUtxQr6f2fSi4+22mnYOP6fjrRVNNgfeX6V4iJ+WmO/t1+9pj1ExxRbPGWkPgOvjtLiQtJUSx9fg1Fw=
X-Received: by 2002:a67:e3c3:: with SMTP id k3mr1907805vsm.137.1581003323681;
 Thu, 06 Feb 2020 07:35:23 -0800 (PST)
MIME-Version: 1.0
References: <20200201005639.GG23230@ZenIV.linux.org.uk>
In-Reply-To: <20200201005639.GG23230@ZenIV.linux.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 6 Feb 2020 10:35:12 -0500
Message-ID: <CAOg9mSSBG7tWQ2+yZDwixCHe5GayyCgZO26D2CCrPCRHxjp4mg@mail.gmail.com>
Subject: Re: [confused] can orangefs ACLs be removed at all?
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Mike Marshall <hubcap@omnibond.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        devel@lists.orangefs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al...

I've been out of the loop for over a week, I only saw
your questions yesterday... I have one small debugfs
patch on linux-next I will submit for the merge window
today, and will have to go back out of the loop for a
few more days (temps will drop, I'm insulating the plumbing
on my house).

When I was writing and testing 4bef69000d93, as I remember,
I used getfacl and setfacl to see that things worked as
I expected them to.

I looked at my code while thinking about your questions, and
they seem like good ones. I have a couple of questions that will
help me when I return to this in a few days:

>> it used to be possible to do
>> orangefs_set_acl(inode, NULL, ACL_TYPE_ACCESS)

The way I tested (which maybe misses important stuff?) usually
caused posix_acl_xattr_set -> set_posix_acl -> orangefs_set_acl ...
Is there a simple userspace command that would send a NULL? When
would there be a NULL?

>> How is one supposed to remove ACLs there?

setfacl -m and setfacl -x both seem to work. I also have a userspace
test program I wrote that uses the internal orangefs api (not through
the kernel) to manipulate xattrs on orangefs files. Going through the
kernel with setfacl and looking at the results with my test program
seems as expected (I can make acls come and go).

>> Moreover, if you change an existing ACL to something
>> that is expressible by pure mode...

I don't remember having trouble before, but now when I try to set
an acl (on orangefs or ext4) that I think is expressible in pure mode,
the mode doesn't change, rather the acl is still set... can you
suggest a simple setfacl (or other) example I can use to test?

I will get back to this in a few days and work to get the code
into a condition that you think is reasonable.

Thanks!

-Mike

On Fri, Jan 31, 2020 at 7:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Prior to 4bef69000d93 (orangefs: react properly to
> posix_acl_update_mode's aftermath.) it used to be possible
> to do orangefs_set_acl(inode, NULL, ACL_TYPE_ACCESS) -
> it would've removed the corresponding xattr and that would
> be it.  Now it fails with -EINVAL without having done
> anything.  How is one supposed to remove ACLs there?
>
>         Moreover, if you change an existing ACL to something
> that is expressible by pure mode, you end up calling
> __orangefs_setattr(), which will call posix_acl_chmod().
> And AFAICS that will happen with *old* ACL still cached,
> so you'll get ACL_MASK/ACL_OTHER updated in the old ACL.
>
>         How can that possibly work?  Sure, you want to
> propagate the updated mode to server - after you've
> done the actual update (possibly removal) of ACL-encoding
> xattr there...
