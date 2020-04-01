Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A03E19B343
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbgDAQuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 12:50:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44614 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389316AbgDAQk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:40:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id i16so641333edy.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2020 09:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+fmUVquH/4ooUsn9dJwsSnQu0YfOphD9t1TiLdVwAyA=;
        b=j8+qBqjWDU65AzKOeRCDMK5UMUySdIHq9VSThcPc+0cJacfTp0iwPWJ0tPmJRlx9CK
         g29vk14anmuLxLrzFgsPKgLWGV1AoK2KSBWRwcKrOLRY+TWkmJk3BfXTohf0E7sApTXz
         j5YK7xbSDCBUCUpuR+58jZm8/JSS2lAZojDXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+fmUVquH/4ooUsn9dJwsSnQu0YfOphD9t1TiLdVwAyA=;
        b=mvL3DE1pLjvGeK3keJOoCzb4VeWsiOHbUP9jsAl0viqTrZqZNJzafRyc+kWgLHWXAJ
         cIwOIYhjH7edjOGqQnDMucNOdCa2mppCchmD2ZWKQCRBQDCBR0rsm1/wS2weRZ8Wfqhz
         0haefYzztE/PCJ0tXLBnfXMjQRoWo1pA2QEhGNQaTep0DX4yS7tqaDjDhbGs6mPcLpkA
         ZZ0YIm5uCBN2Y+YdQc/qcAWnCHoniePVCRfX7OL2U3UUk2+Vjvi68W1WEYOn9u9TxGt8
         azClEi1bZQp1b3wnfyVDKkpKtUnwmrCkPMX5aQ1Rnhu8C4D050tMp509zf6ZrN+KLnIZ
         lT/g==
X-Gm-Message-State: ANhLgQ1fip7Ol4zXgp1i5W59QbxOnxhVQrs97dGp2e+V1KEtiwMkjsQO
        Fdh8In+w0Cz7Kip7ABXlgY/Cq2oAcaRjoIRGluDEfQ==
X-Google-Smtp-Source: ADFU+vuFhviIpWMZWEBTgfJWS7ePu07l9AQSyMf1NQJacKvxD3vVb6oEPToYimLpSN1xJFpQbicsOlDEmkUP00hj82A=
X-Received: by 2002:a17:906:848d:: with SMTP id m13mr21390474ejx.348.1585759225278;
 Wed, 01 Apr 2020 09:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk>
In-Reply-To: <2590640.1585757211@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 1 Apr 2020 18:40:13 +0200
Message-ID: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
To:     David Howells <dhowells@redhat.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
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

On Wed, Apr 1, 2020 at 6:07 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > I've still not heard a convincing argument in favor of a syscall.
>
> From your own results, scanning 10000 mounts through mountfs and reading just
> two values from each is an order of magnitude slower without the effect of the
> dentry/inode caches.  It gets faster on the second run because the mountfs
> dentries and inodes are cached - but at a cost of >205MiB of RAM.  And it's
> *still* slower than fsinfo().

Already told you that we can just delete the dentry on dput_final, so
the memory argument is immaterial.

And the speed argument also, because there's no use case where that
would make a difference.  You keep bringing up the notification queue
overrun when watching a subtree, but that's going to be painful with
fsinfo(2) as well.   If that's a relevant use case (not saying it's
true), might as well add a /mnt/MNT_ID/subtree_info (trivial again)
that contains all information for the subtree.  Have fun implementing
that with fsinfo(2).

Thanks,
Miklos
