Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6C19A167
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 23:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731483AbgCaV4e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 17:56:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22719 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727955AbgCaV4e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 17:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585691793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JBMA6jXiru2mPeg8fq1WPRUiBwr+Arv7dJnUuWmimoc=;
        b=CHR44EVn6mBMQiyrVJHWg51D7cvsI3NW9vmRNo3ETb92lIDRkocf30C/9zb5HO8egjQSUM
        OWDy8aG8lboMCu2D6k6rZ4ngsN6GvDqtvSkxeyICK5cZTg3bjP7gl2ycEJYwDbIY0swI8T
        22JGMHaqj3DkEfHs0Kd5Jo/eMh34beI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-MUdl86boN4K15gh8KATflA-1; Tue, 31 Mar 2020 17:56:32 -0400
X-MC-Unique: MUdl86boN4K15gh8KATflA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F7A78017CE;
        Tue, 31 Mar 2020 21:56:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21B941A269;
        Tue, 31 Mar 2020 21:56:26 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20200331122554.GA27469@gardel-login>
References: <20200331122554.GA27469@gardel-login> <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com> <20200331083430.kserp35qabnxvths@ws.net.home> <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
To:     Lennart Poettering <mzxreary@0pointer.de>
Cc:     dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>,
        Karel Zak <kzak@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2418580.1585691786.1@warthog.procyon.org.uk>
Date:   Tue, 31 Mar 2020 22:56:26 +0100
Message-ID: <2418581.1585691786@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Lennart Poettering <mzxreary@0pointer.de> wrote:

> - We also have code that needs to check if /dev/ is plain tmpfs or
>   devtmpfs. We cannot use statfs for that, since in both cases
>   TMPFS_MAGIC is reported, hence we currently parse
>   /proc/self/mountinfo for that to find the fstype string there, which
>   is different for both cases.

btw, fsinfo(FSINFO_ATTR_IDS) gets you the name of the filesystem type in
addition to the magic number.

David

