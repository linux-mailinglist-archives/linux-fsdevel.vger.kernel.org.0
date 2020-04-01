Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDE3C19AEC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732917AbgDAPeK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 11:34:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44428 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732789AbgDAPeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:34:10 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so369459edy.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PknMOjO0aVK6+Mbr46jA4uNoXU0DCDMitbN9TCuKpYU=;
        b=p5QzZMqB/vMQwg0fm6pTCPUxV1A84gb+EbDz8bFwLIYFbNP9FnvyYhjSFYadmD92gb
         mRFyGUNcatWLbDeKB3pVtLlqOSoBYBt/rdV98tORxMQw0g+6QIHkhXIzbYrVkopEy81C
         VW95LobYq1gT/TNOY+qN/8qCYjeVcjpE8eBU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PknMOjO0aVK6+Mbr46jA4uNoXU0DCDMitbN9TCuKpYU=;
        b=IuYs/HJYZHer5lCDYBfl2FMjV4qNiKhflGMw3wXe2Nu2AdHtwG9bHkK1DGHXAv5T7C
         1Ibz3vUMRJFK7WNtCyc+CI3E+uGeIC8oLGnP4sZevnK8/YDKYy5C8TNlAWS2M37z+2Fl
         4nQkP49uggTSmeP0jcZLs/hgi0U6eDhZgo8SeY8ySYaLTUxb/ey9BrMn0KQXbP9trrVm
         hquwldycTsjGE6ZEzeLANevMQ+jzSvCfciT+Iwu6k5UxDhAPTFn8a2l1YdU3w9wLmb82
         4nh/VQIuM55YVyzK+lmKzTteTivttP8BtZvpKAVyWCjAU+jguuj/japqQOnKRvyQWCZe
         asrA==
X-Gm-Message-State: ANhLgQ2YCY976Pj4kxDxtrBZHZHxosAP6ZybLeC8ERRSihhIvs+DDjBs
        DBFxyDhG1bolhrFKvHw8+JTsTaXw2fBqD9/pN0PdaQ==
X-Google-Smtp-Source: ADFU+vs4NvhCMrvCrJhNiFJktWHH/mqCFDfkFAflywuZUDLeQconO4+bbarWMrnDJQm+JW/SHBg/UTtmPThSySe23DY=
X-Received: by 2002:a05:6402:44e:: with SMTP id p14mr21764199edw.356.1585755249047;
 Wed, 01 Apr 2020 08:34:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
In-Reply-To: <20200401144109.GA29945@gardel-login>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 17:33:57 +0200
Message-ID: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 1, 2020 at 4:41 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Di, 31.03.20 22:52, David Howells (dhowells@redhat.com) wrote:
>
> > Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >
> > > querying all properties of a mount atomically all-at-once,
> >
> > I don't actually offer that, per se.
> >
> > Having an atomic all-at-once query for a single mount is actually quite a
> > burden on the system.  There's potentially a lot of state involved, much of
> > which you don't necessarily need.
>
> Hmm, do it like with statx() and specify a mask for the fields userspace
> wants? Then it would be as lightweight as it possibly could be?

Yes, however binary structures mixed with variable length fields are
not going to be pretty.

Again, if we want something even halfway sane for a syscall interface,
go with a string key/value vector.

If that's really needed.  I've still not heard a convincing argument
in favor of a syscall.

Thanks,
Miklos
