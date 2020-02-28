Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBBD173D41
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgB1Qmi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 11:42:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59037 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726846AbgB1Qmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582908157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SDgKBpn0a2kyKpdeNQbhT4JKfw2dNRrDMjGLH2Nskjk=;
        b=he9+4O9GrrPHqIm7VjErNjAP+tuFFENxc8/CBbYa2/Nc6YebvsT3gUpp2xcfmUh14l6IgB
        AYRRfUQGcq0FsWDoGuWATruT8iS812TySSFKDWJskJuBW+ThBka9z/BVwo336f1pJGCPpB
        bAmb4+T8lHhgaMSEut/ptFTTkGcwPow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-FMOomAvRO-WI5jDj2BH7ZQ-1; Fri, 28 Feb 2020 11:42:35 -0500
X-MC-Unique: FMOomAvRO-WI5jDj2BH7ZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC74418FF687;
        Fri, 28 Feb 2020 16:42:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-120-182.rdu2.redhat.com [10.10.120.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8278526368;
        Fri, 28 Feb 2020 16:42:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com>
References: <CAJfpegsGgjnyZiB+ionfnnk+_e+5oaC-5nmGq+mLxWs1RcwsPw@mail.gmail.com> <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com> <1582644535.3361.8.camel@HansenPartnership.com> <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com> <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net> <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com> <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net> <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com> <20200227151421.3u74ijhqt6ekbiss@ws.net.home> <ba2b44cc1382c62be3ac896a5476c8e1dc7c0230.camel@themaw.net> <CAJfpeguXPmw+PfZJFOscGLm0oe7dUQY4CYXazx9=x020Fbe86A@mail.gmail.com> <20200228122712.GA3013026@kroah.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Kent <raven@themaw.net>, Karel Zak <kzak@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications [ver #17]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <108164.1582908148.1@warthog.procyon.org.uk>
Date:   Fri, 28 Feb 2020 16:42:28 +0000
Message-ID: <108165.1582908148@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

>   children/$CHILD_ID -> ../../$CHILD_ID

This would really suck.  This bit would particularly affect rescanning time.

You also really want to read the entire child set atomically and, ideally,
include notification counters.

>  supers/$SUPER_ID/
>    type: fstype
>    source: mount source (devname)
>    options: csv of mount options

There's a lot more to fsinfo() than just this lot - and there's the
possibility that some of the values may change depending on exactly which file
you're looking at.

David

