Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4293177217
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 10:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgCCJND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 04:13:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54709 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727798AbgCCJND (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:13:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583226783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMP4Yyr6RpOE+LNq0HWY7JfUV3/6ReV0xC+ZidKNJgU=;
        b=CgZP405/WZRTwns8NWSJYEMlJLTgh63riPIRebPrXnArszTGYMYJ8cd9OlgaR1WTYBKVlO
        Z4qTqp41f/K8iUAoDKkZzWZ6ZFrEKoe2RNtr7JfOgjiUXYZseet1FahgfOc4DEaGiMGjUm
        1mzxO8KUAVNh5EFxpf0Cw4bzMLin85U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-Y08eRkhaPm2zAg6y2Z84lg-1; Tue, 03 Mar 2020 04:12:59 -0500
X-MC-Unique: Y08eRkhaPm2zAg6y2Z84lg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 65E301005F83;
        Tue,  3 Mar 2020 09:12:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6012C91D74;
        Tue,  3 Mar 2020 09:12:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
References: <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com> <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk> <1582316494.3376.45.camel@HansenPartnership.com> <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com> <1582556135.3384.4.camel@HansenPartnership.com> <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com> <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com> <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> <107666.1582907766@warthog.procyon.org.uk> <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com> <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Ian Kent <raven@themaw.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1509947.1583226773.1@warthog.procyon.org.uk>
Date:   Tue, 03 Mar 2020 09:12:53 +0000
Message-ID: <1509948.1583226773@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> I'm doing a patch.   Let's see how it fares in the face of all these
> preconceptions.

Don't forget the efficiency criterion.  One reason for going with fsinfo(2) is
that scanning /proc/mounts when there are a lot of mounts in the system is
slow (not to mention the global lock that is held during the read).

Now, going with sysfs files on top of procfs links might avoid the global
lock, and you can avoid rereading the options string if you export a change
notification, but you're going to end up injecting a whole lot of pathwalk
latency into the system.

On top of that, it isn't going to help with the case that I'm working towards
implementing where a container manager can monitor for mounts taking place
inside the container and supervise them.  What I'm proposing is that during
the action phase (eg. FSCONFIG_CMD_CREATE), fsconfig() would hand an fd
referring to the context under construction to the manager, which would then
be able to call fsinfo() to query it and fsconfig() to adjust it, reject it or
permit it.  Something like:

	fd = receive_context_to_supervise();
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	= FSINFO_ATTR_SB_OPTIONS,
	};
	fsinfo(fd, NULL, &params, sizeof(params), buffer, sizeof(buffer));
	supervise_parameters(buffer);
	fsconfig(fd, FSCONFIG_SET_FLAG, "hard", NULL, 0);
	fsconfig(fd, FSCONFIG_SET_STRING, "vers", "4.2", 0);
	fsconfig(fd, FSCONFIG_CMD_SUPERVISE_CREATE, NULL, NULL, 0);
	struct fsinfo_params params = {
		.flags		= FSINFO_FLAGS_QUERY_FSCONTEXT,
		.request	= FSINFO_ATTR_SB_NOTIFICATIONS,
	};
	struct fsinfo_sb_notifications sbnotify;
	fsinfo(fd, NULL, &params, sizeof(params), &sbnotify, sizeof(sbnotify));
	watch_super(fd, "", AT_EMPTY_PATH, watch_fd, 0x03);
	fsconfig(fd, FSCONFIG_CMD_SUPERVISE_PERMIT, NULL, NULL, 0);
	close(fd);

However, the supervised mount may be happening in a completely different set
of namespaces, in which case the supervisor presumably wouldn't be able to see
the links in procfs and the relevant portions of sysfs.

David

