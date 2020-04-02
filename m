Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31BC19C667
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 17:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389297AbgDBPvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 11:51:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25745 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388902AbgDBPvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585842695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1HCpqSlzajINZsk0DkaLvB/z3fLDfmMkm60HaIOE1X0=;
        b=BEuc48KfKXUzDnZY4IyaiXJ2ClsugpNBfSP9uDEle9RZ12BM6Kp+EnBRyX7U2NFdHFkVTn
        ome/QynnMA86AaXiMLtOFfWT76x5bmL0jj37hGoQe2SlBs5t3Mhhr7ThM296Zwnb281p2t
        7G+xhhmefCU/2kqBPC318ClYxZl73mg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-TVZFGSG7MIauQmriGk2ZVg-1; Thu, 02 Apr 2020 11:51:33 -0400
X-MC-Unique: TVZFGSG7MIauQmriGk2ZVg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 889508017CE;
        Thu,  2 Apr 2020 15:51:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB8099DFA;
        Thu,  2 Apr 2020 15:51:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200402152831.GA31612@gardel-login>
References: <20200402152831.GA31612@gardel-login> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com> <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net> <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Ian Kent <raven@themaw.net>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3072810.1585842687.1@warthog.procyon.org.uk>
Date:   Thu, 02 Apr 2020 16:51:27 +0100
Message-ID: <3072811.1585842687@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lennart Poettering <mzxreary@0pointer.de> wrote:

> systemd cares about all mount points in PID1's mount namespace.
> 
> The fact that mount tables can grow large is why we want something
> better than constantly reparsing the whole /proc/self/mountinfo. But
> filtering subsets of that is something we don't really care about.

With the notifications stuff I've done, you can do, for example:

	pipe2(pipefd, O_NOTIFICATION_PIPE);
	ioctl(pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, 256);
	watch_mount(AT_FDCWD, "/", 0, pipefd[0], 0x02);

And that will catch all mount object changes in the subtree rooted at the
given path, in this case "/".

If you want to limit it to just the notifications on that mount, you would
need to install a filter:

	struct watch_notification_filter filter = {
		.nr_filters	= 1,
		.filters = {
			[0]	= {
				.type		= WATCH_TYPE_MOUNT_NOTIFY,
				.subtype_filter[0]= UINT_MAX,
				.info_mask	= NOTIFY_MOUNT_IS_RECURSIVE,
				.info_filter	= 0,
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);

Note that this doesn't monitor for superblock changes and events.  They must
be watched individually with something like:

	watch_sb(AT_FDCWD, "/afs", AT_NO_AUTOMOUNT, pipefd[0], 0x27);

David

