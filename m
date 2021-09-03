Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38113FFAC3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 08:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347504AbhICG53 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 02:57:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44614 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347518AbhICG5W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 02:57:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630652182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CMU0FH7DhLi0oHnmcQCBzsX4HoHYqzZdV2dtgL7VZJc=;
        b=DmxoWER/CtV19WixMQYmzkCPLAtBZH/5mNwAnWTyax6t//tlHdpDS/Jpd5hapVVK1zZuAK
        W13UlDDi4uNL0CP6LbRQnUv8Fto5jZevBxaxxcmMHBfsSJvWshWr2YrJwzgrU9V1Ba4KWk
        pAzqXb5Edn9T2YjGtX7a7Tpb+sMnECM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-88kWxwlJO3qUVGY_AWN5NA-1; Fri, 03 Sep 2021 02:56:21 -0400
X-MC-Unique: 88kWxwlJO3qUVGY_AWN5NA-1
Received: by mail-wm1-f71.google.com with SMTP id c2-20020a7bc8420000b0290238db573ab7so2251851wml.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 23:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMU0FH7DhLi0oHnmcQCBzsX4HoHYqzZdV2dtgL7VZJc=;
        b=hl3zarUyCYSbnyn0xUhYMtTkOM19BeEy09Blyp+kJZ8AZJ8EvjTkn/+IQcKsaPaCjE
         vlgC6dqZCQOh5Gftqr5f+uNCGJHbFjM4Dn0rcbqVncbyHArdFTxJyPpk+1ChuvBVcHGd
         P8STLvBJXDz4dJIsvrKFduIIoBaoL8K0JL7QCht1qombNrAQtSc2uhgY/ysn+ll5FgPs
         KXHh0ocmIPyoJq4km7wBzCV7Hj9riAW8mEx3Z9cAaRYhbfNsfLje0XPVN+XKIsBC6Ujk
         mwYwKhMu46oY+Sfdw6xDLBDq6qWbJzdL4cScnuYRXMZqO4y+P0B8Js4CP6R8YwtJJ/6r
         kaCA==
X-Gm-Message-State: AOAM532it/oTtP7C0Uhf7TdEHR0aAAoLjaDAKfpKqd+rY6yZHGaUHTrz
        pt8DovrwS7vukBSzod9rZwfOvwJ4k9ngr+IRFgBbpFZWALtRyGUYAhhU1Qt/0QyrjUmrW5Ngei+
        XDjcbYrDGyjE/eSTLUwgrJ2IcNhmirqANiyfwwdBCIA==
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1757622wms.27.1630652179740;
        Thu, 02 Sep 2021 23:56:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEMgRhDhAirpF+1BwSzCXJ2JmOX/csrcn3G6xdkU4jNs0c3KyXpXRLPYTJcObTec0xa9Qcz/PI2DFfXbdCfYE=
X-Received: by 2002:a05:600c:1c08:: with SMTP id j8mr1757607wms.27.1630652179603;
 Thu, 02 Sep 2021 23:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210902152228.665959-1-vgoyal@redhat.com> <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
In-Reply-To: <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Fri, 3 Sep 2021 08:56:08 +0200
Message-ID: <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        dwalsh@redhat.com, dgilbert@redhat.com,
        christian.brauner@ubuntu.com, casey.schaufler@intel.com,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>, gscrivan@redhat.com,
        "Fields, Bruce" <bfields@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 3, 2021 at 8:31 AM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> On Thu, Sep 2, 2021 at 5:47 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > xfstests: generic/062: Do not run on newer kernels
> >
> > This test has been written with assumption that setting user.* xattrs will
> > fail on symlink and special files. When newer kernels support setting
> > user.* xattrs on symlink and special files, this test starts failing.
>
> It's actually a good thing that this test case triggers for the kernel
> change you're proposing; that change should never be merged. The
> user.* namespace is meant for data with the same access permissions as
> the file data, and it has been for many years. We may have
> applications that assume the existing behavior. In addition, this
> change would create backwards compatibility problems for things like
> backups.
>
> I'm not convinced that what you're actually proposing (mapping
> security.selinux to a different attribute name) actually makes sense,
> but that's a question for the selinux folks to decide. Mapping it to a
> user.* attribute is definitely wrong though. The modified behavior
> would affect anybody, not only users of selinux and/or virtiofs. If
> mapping attribute names is actually the right approach, then you need
> to look at trusted.* xattrs, which exist specifically for this kind of
> purpose. You've noted that trusted.* xattrs aren't supported over nfs.
> That's unfortunate, but not an acceptable excuse for messing up user.*
> xattrs.

Another possibility would be to make selinux use a different
security.* attribute for this nested selinux case. That way, the
"host" selinux would retain some control over the labels the "guest"
uses.

Thanks,
Andreas

