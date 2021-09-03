Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 899F640027F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 17:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349664AbhICPoT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 11:44:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39921 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349658AbhICPoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 11:44:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630683797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rmz5dxCT3Is+5LUh/Dfik2OQKMSHi9rWSjYepBCE0qk=;
        b=CghJ0U4c1uA0TS7OKfKUClp77UUpjgnZ/15wH7lx6ea26jnarCoH99hqMFOzXTBHasrrV0
        /fLYMCTKD2zWMNmuygtu8B+6hpbsCIxvs/TwowD738qtpQj6BXH+bwuD2Wp+DTBBbq33EF
        iQFCUd7U9qLEWHeF3YN6nKdg8+vjJiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-WRLuUvTaPnKLFlvUthyY4g-1; Fri, 03 Sep 2021 11:43:14 -0400
X-MC-Unique: WRLuUvTaPnKLFlvUthyY4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECACC1883527;
        Fri,  3 Sep 2021 15:43:12 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14A091036B3E;
        Fri,  3 Sep 2021 15:43:09 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A454C220257; Fri,  3 Sep 2021 11:43:08 -0400 (EDT)
Date:   Fri, 3 Sep 2021 11:43:08 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
Message-ID: <YTJCjGH0V5yzMnQB@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
 <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
 <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 03, 2021 at 10:42:34AM -0400, Bruce Fields wrote:
> Well, we could also look at supporting trusted.* xattrs over NFS.  I
> don't know much about them, but it looks like it wouldn't be a lot of
> work to specify, especially now that we've already got user xattrs?
> We'd just write a new internet draft that refers to the existing
> user.* xattr draft for most of the details.

Will be nice if we can support trusted.* xattrs on NFS.

Vivek

> 
> --b.
> 
> On Fri, Sep 3, 2021 at 2:56 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > On Fri, Sep 3, 2021 at 8:31 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > xfstests: generic/062: Do not run on newer kernels
> > > >
> > > > This test has been written with assumption that setting user.* xattrs will
> > > > fail on symlink and special files. When newer kernels support setting
> > > > user.* xattrs on symlink and special files, this test starts failing.
> > >
> > > It's actually a good thing that this test case triggers for the kernel
> > > change you're proposing; that change should never be merged. The
> > > user.* namespace is meant for data with the same access permissions as
> > > the file data, and it has been for many years. We may have
> > > applications that assume the existing behavior. In addition, this
> > > change would create backwards compatibility problems for things like
> > > backups.
> > >
> > > I'm not convinced that what you're actually proposing (mapping
> > > security.selinux to a different attribute name) actually makes sense,
> > > but that's a question for the selinux folks to decide. Mapping it to a
> > > user.* attribute is definitely wrong though. The modified behavior
> > > would affect anybody, not only users of selinux and/or virtiofs. If
> > > mapping attribute names is actually the right approach, then you need
> > > to look at trusted.* xattrs, which exist specifically for this kind of
> > > purpose. You've noted that trusted.* xattrs aren't supported over nfs.
> > > That's unfortunate, but not an acceptable excuse for messing up user.*
> > > xattrs.
> >
> > Another possibility would be to make selinux use a different
> > security.* attribute for this nested selinux case. That way, the
> > "host" selinux would retain some control over the labels the "guest"
> > uses.
> >
> > Thanks,
> > Andreas
> >
> 

