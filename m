Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 348AA19DA59
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 17:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404257AbgDCPlm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 11:41:42 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:52094 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgDCPlm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:41:42 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id E771BE807B5;
        Fri,  3 Apr 2020 17:41:39 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 7B7C41614E3; Fri,  3 Apr 2020 17:41:39 +0200 (CEST)
Date:   Fri, 3 Apr 2020 17:41:39 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>,
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
Message-ID: <20200403154139.GA34867@gardel-login>
References: <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <3248809.1585928191@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3248809.1585928191@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fr, 03.04.20 16:36, David Howells (dhowells@redhat.com) wrote:

> Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> > BTW, while we are at it: one more thing I'd love to see exposed by
> > statx() is a simple flag whether the inode is a mount point.
>
> Note that an inode or a dentry might be a mount point in one namespace, but
> not in another.  Do you actually mean an inode - or do you actually mean the
> (mount,dentry) pair that you're looking at?  (Ie. should it be namespace
> specific?)

yes, it should be specific to the mount hierarchy in the current namespace.

Lennart

--
Lennart Poettering, Berlin
