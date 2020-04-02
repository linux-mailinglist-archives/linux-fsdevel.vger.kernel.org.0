Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C5319C3BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 16:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388264AbgDBOOo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Apr 2020 10:14:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35384 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732687AbgDBOOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Apr 2020 10:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585836882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jHomtIlfVWCjz0uqN5tmjf5fA1sQAGrA5th4ZK/FkAU=;
        b=cuX86C/a120lvfm63jNnZRIB4mcW1LHqbj7OC1tbBMk6dxVYNYzk4jsONk97naTx363Wxh
        XGKQnK7c090YpVWMi5wNXLerWGfPOQ2aIU5fKg76MPrKjNvsD6UbQCq051pHKP3j6JmIMo
        E2+iyNeUCgMaqIWSA/3J7pcnIFqX/LQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-1BusTZ8oOt2-QFfQoMK6lw-1; Thu, 02 Apr 2020 10:14:38 -0400
X-MC-Unique: 1BusTZ8oOt2-QFfQoMK6lw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFCDC800D50;
        Thu,  2 Apr 2020 14:14:34 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39C1899E16;
        Thu,  2 Apr 2020 14:14:27 +0000 (UTC)
Date:   Thu, 2 Apr 2020 16:14:24 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Ian Kent <raven@themaw.net>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
Message-ID: <20200402141424.3zyphot2kjf5vaoo@ws.net.home>
References: <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk>
 <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com>
 <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net>
 <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com>
 <2465266.1585729649@warthog.procyon.org.uk>
 <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
 <459876eceda4bc68212faf4ed3d4bcb8570aa105.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459876eceda4bc68212faf4ed3d4bcb8570aa105.camel@themaw.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 02, 2020 at 09:38:20AM +0800, Ian Kent wrote:
> I prefer the system call interface and I'm not offering justification
> for that other than a general dislike (and on occasion outright
> frustration) of pretty much every proc implementation I have had to
> look at.

Frankly, I'm modest, what about to have both interfaces in kernel --
fsinfo() as well mountfs? It's nothing unusual for example for block
devices to have attribute accessible by /sys as well as by ioctl().

I can imagine that for complex task or performance sensitive tasks
it's better to use fsinfo(), but in another simple use-cases (for
example to convert mountpoint to device name in shell) is better to
read /proc/.../<atrtr>.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

