Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 239DA19A7A0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731608AbgDAIn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 04:43:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41809 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731343AbgDAIn6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:43:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585730637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ghf5BEjuQ0VVHQ+GDvKrov7j0WF8psl/+NBJNRKsHsA=;
        b=V1Qe5HQtjm2dq4zWCUTLur75dkJKgPKJj7hSi/Dza5pcA56TEcss2vDrM/hp4pA9ajtV31
        94/xtex4jqPFHEwooiR5o8BObk/5jKljfEmxqrCo8eu1mRfdgnTRXQ9zZjDY81OcVEgBkr
        EOMk8odtPs3HiSaxD1Z0FPk+LeEb9f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-1z9lJwfaMpqepY7Q8IadMQ-1; Wed, 01 Apr 2020 04:43:55 -0400
X-MC-Unique: 1z9lJwfaMpqepY7Q8IadMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86CCF800D53;
        Wed,  1 Apr 2020 08:43:53 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 989B819C6A;
        Wed,  1 Apr 2020 08:43:49 +0000 (UTC)
Date:   Wed, 1 Apr 2020 10:43:46 +0200
From:   Karel Zak <kzak@redhat.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com,
        Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de, keyrings@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        Aleksa Sarai <cyphar@cyphar.com>
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-ID: <20200401084346.kety7m2dwo7okeuk@ws.net.home>
References: <20200331083430.kserp35qabnxvths@ws.net.home>
 <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <2418416.1585691663@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2418416.1585691663@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 31, 2020 at 10:54:23PM +0100, David Howells wrote:
> Karel Zak <kzak@redhat.com> wrote:
> 
> > - improve fsinfo() to provide set (list) of the attributes by one call
> 
> That would be my preferred way.  I wouldn't want to let the user pin copies of
> state, and I wouldn't want to make open(O_PATH) do it automatically.

You can create cow object on first fsinfo() call, ideally add some
flags to control this behavior -- but you're right, this way is
complicated to implement and possibly dangerous.

I guess return some vector of attributes in one fsinfo() will be good
enough.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

