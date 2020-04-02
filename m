Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA2919C68E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389309AbgDBP4s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 11:56:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42378 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389325AbgDBP4r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585843006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REwcyHpaosKkRkByGvVIKqyhXGWuC4Yt/J236FEw2Ls=;
        b=iXUr3QoIzuPR4dbeC/o+rleMZK8KsqlUJru0NUwM5b4jnCmfo/S3BsHk5pcVsRBCFZ8tRC
        iSC82X3tE2zUbVX2hTMdXRBUlmhTaBZuoWX14v+b5Q43iKHfGUvqiyeVYX6YPe72t1nmGQ
        6tSxWS3r994Z7VmDZkxIfNG5OUihqlk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-ozDIPbVPMpaD38-kQwEaPQ-1; Thu, 02 Apr 2020 11:56:44 -0400
X-MC-Unique: ozDIPbVPMpaD38-kQwEaPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F14E5800D50;
        Thu,  2 Apr 2020 15:56:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D91E519756;
        Thu,  2 Apr 2020 15:56:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <3072811.1585842687@warthog.procyon.org.uk>
References: <3072811.1585842687@warthog.procyon.org.uk> <20200402152831.GA31612@gardel-login> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com> <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net> <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
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
Content-ID: <3073172.1585842999.1@warthog.procyon.org.uk>
Date:   Thu, 02 Apr 2020 16:56:39 +0100
Message-ID: <3073173.1585842999@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> 				.info_mask	= NOTIFY_MOUNT_IS_RECURSIVE,

Sorry, I meant NOTIFY_MOUNT_IN_SUBTREE; NOTIFY_MOUNT_IS_RECURSIVE indicates
that the operation was recursive in nature.

David

