Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C17E619D58E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 13:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgDCLLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 07:11:46 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:51838 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727898AbgDCLLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 07:11:46 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 89E27E80689;
        Fri,  3 Apr 2020 13:11:44 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 20B1A1614E3; Fri,  3 Apr 2020 13:11:44 +0200 (CEST)
Date:   Fri, 3 Apr 2020 13:11:44 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, andres@anarazel.de,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200403111144.GB34663@gardel-login>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk>
 <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fr, 03.04.20 09:44, Ian Kent (raven@themaw.net) wrote:

> > Currently the only way to find the mount id from a path is by parsing
> > /proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
> > return it directly from a path.   Also the mount notification queue
> > that David implemented contains the mount ID of the changed mount.

I would love to have the mount ID exposed via statx().

In systemd we generally try name_to_handle_at() to query the mount ID
first. It returns both the actual fhandle and the mount ID after all,
and we then throw the fhandle away. It's not available on all fs
though, but it has the benefit that it works without procfs and on
a number of older kernels that didn't expose the mnt id in fdinfo.

Lennart

--
Lennart Poettering, Berlin
