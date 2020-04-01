Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E219E19AF11
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Apr 2020 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733044AbgDAPvz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 11:51:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732929AbgDAPvz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585756314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Hue9l1/UJQF2U4lKyhSbPFzaMnHT5K5mJD7PcBNrM4=;
        b=c2ypOqQpiZB+D9K0IxvRsf2huk/tx7a+qg27vupMRMBFb0oSk0TFcMeyo6+LLabjXxEEkz
        gt27cysjL68cE7KsZUYdOdTfEINfktwxA+Oq/IBQYE21ZGXqQRyIQXebJ4WTS+Xozg24FX
        KYt7exPiHq3QvK+/3ZLn9u1gSkv5veA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-W2iZb2t4MKawS3j31oos7A-1; Wed, 01 Apr 2020 11:51:53 -0400
X-MC-Unique: W2iZb2t4MKawS3j31oos7A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1338113F7;
        Wed,  1 Apr 2020 15:51:48 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-114-243.ams2.redhat.com [10.36.114.243])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D631696B87;
        Wed,  1 Apr 2020 15:51:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAJfpeguxACC68bMhS-mNm4m6ytrKgs1--jbF5X3tBiPf_iG1jg@mail.gmail.com>
References: <CAJfpeguxACC68bMhS-mNm4m6ytrKgs1--jbF5X3tBiPf_iG1jg@mail.gmail.com> <158454408854.2864823.5910520544515668590.stgit@warthog.procyon.org.uk> <CAJfpeguaiicjS2StY5m=8H7BCjq6PLxMsWE3Mx_jYR1foDWVTg@mail.gmail.com> <50caf93782ba1d66bd6acf098fb8dcb0ecc98610.camel@themaw.net> <CAJfpegvvMVoNp1QeXEZiNucCeuUeDP4tKqVfq2F4koQKzjKmvw@mail.gmail.com> <2465266.1585729649@warthog.procyon.org.uk> <CAJfpegsyeJmH3zJuseaAAY06fzgavSzpOtYr-1Mw8GR0cLcQbA@mail.gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     dhowells@redhat.com, Ian Kent <raven@themaw.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux NFS list <linux-nfs@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux API <linux-api@vger.kernel.org>,
        linux-ext4@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/13] VFS: Filesystem information [ver #19]
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2583799.1585756303.1@warthog.procyon.org.uk>
Date:   Wed, 01 Apr 2020 16:51:43 +0100
Message-ID: <2583800.1585756303@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> For   30000 mounts, f=    146400us f2=    136766us p=   1406569us p2=
>   221669us; p=9.6*f p=10.3*f2 p=6.3*p2

	f =    146400us
	f2=    136766us
	p =   1406569us  <--- Order of magnitude slower
	p2=    221669us

And more memory used because it's added a whole bunch of inodes and dentries
to the cache.  For each mount that's a pair for each dir and a pair for each
file within the dir.  So for the two files my test is reading, for 30000
mounts, that's 90000 dentries and 90000 inodes in mountfs alone.

	(gdb) p sizeof(struct dentry)
	$1 = 216
	(gdb) p sizeof(struct inode)
	$2 = 696
	(gdb) p (216*696)*30000*3/1024/1024
	$3 = 615

so 615 MiB of RAM added to the caches in an extreme case.

We're seeing customers with 10000+ mounts - that would be 205 MiB, just to
read two values from each mount.

I presume you're not going through /proc/fdinfo each time as that would add
another d+i - for >1GiB added to the caches for 30000 mounts.

David

