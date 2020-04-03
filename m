Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 465F219DA4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404368AbgDCPgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 11:36:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42548 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404365AbgDCPgn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585928202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eRgcpWjGjWOGUASD5rRrzWGDQ6lWUmhgv3fzZ/n5jQ4=;
        b=C/cJcTZPA4AS4RTRnZN84WDvN2Z0GYwlJ9U2Y7bqEyx5kdxxqYTG2KOHQ/yXiIBMEiI9dH
        N/gI1j2iM0L98Y7eWkIYGB4aZuERkese8g+D7FpWhIiqF6h1XgV80WbLhFco8FGQBGJUQM
        +Cmzsxg8OzX/qUDIdsS2FZ9cu4sEggo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-BO5Tb7MhMwySkbv35vDEVA-1; Fri, 03 Apr 2020 11:36:38 -0400
X-MC-Unique: BO5Tb7MhMwySkbv35vDEVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 90E3D477;
        Fri,  3 Apr 2020 15:36:36 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94D815C1BE;
        Fri,  3 Apr 2020 15:36:32 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200403151223.GB34800@gardel-login>
References: <20200403151223.GB34800@gardel-login> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com> <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net> <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net> <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
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
Content-ID: <3248808.1585928191.1@warthog.procyon.org.uk>
Date:   Fri, 03 Apr 2020 16:36:31 +0100
Message-ID: <3248809.1585928191@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lennart Poettering <mzxreary@0pointer.de> wrote:

> BTW, while we are at it: one more thing I'd love to see exposed by
> statx() is a simple flag whether the inode is a mount point.

Note that an inode or a dentry might be a mount point in one namespace, but
not in another.  Do you actually mean an inode - or do you actually mean the
(mount,dentry) pair that you're looking at?  (Ie. should it be namespace
specific?)

David

