Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC6D3F2E4C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 16:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240923AbhHTOo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 10:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240917AbhHTOo0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:44:26 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28629C061575;
        Fri, 20 Aug 2021 07:43:48 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id f6so5021491iox.0;
        Fri, 20 Aug 2021 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zWMM/5S4dFOu/WD5ECEAYdeBKl4z45VntP0JWXoYfUw=;
        b=FcY9F6mThjv6P21NVpAA2nO7PZ1ZAbFoCSKj0EfH+o/JnlPsRcMCwgPyWR2GbwhZFx
         cZkbDh0SGZEEILF99+knsIeT274XPns+Qqsgc0PoiYb84bhD0bzv/NdFqH83Z8h7klB5
         keniLNka/oelkgg3vqZckEF5gEXiRgtkmQ9gUv4rv6FPXRElrxU40gRndRMH5cH8yA9M
         oGny7FmfP+BhA86feZ9Nc2fFXsh/6hZoVsBZfV2EaVcoYU3ZPCdAduVZR76UnPSFBzyv
         3TDc8lVrF1gsEKSXND2OdIoi5wjPQ1G0u8rVRsyZ7dB0eWjCcZWSKeeA/3BM+I/G7+v/
         EEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zWMM/5S4dFOu/WD5ECEAYdeBKl4z45VntP0JWXoYfUw=;
        b=GN9klDoed/+bJBu2QD1se9hEKtD2AqU3YzlKmeNzVDOJOtdo9Gm8ZAYwcGCBqLcB55
         cY0rXKNSSMvkdPjXw8YvjXptenzu2bUUR7KvlbtVBm6GHWCG/Wm+cFduVGwJ7GaikP7n
         oKxQfEssYoB8ZAKs/yALX0z/7IndU6vseLAzUR/SxKhqjk+iiScfxLqE1Fx/AN3Fd/BJ
         jPvan65qtHNjWYEPYGyEVyVR9j3Wnfzsq0oGGWiZ8QGjGFqq7OYCZsVUKUkDSSfL0uEM
         pfLFS8IyD3SrPDQZN1ffRU9hG5FccEWFz+u2ireuozuCJ2fbjrjfVhEjSwQsf7RMp4IW
         8zDQ==
X-Gm-Message-State: AOAM533jzrd81oAX8+W1quDhbeMu8nZmf32P8hJqFanlxx/gL8ZLBqUT
        AbJh3eiAkU48fxQ1VghfYUj4O20fmBRw73O3a6c=
X-Google-Smtp-Source: ABdhPJzOk9dUXsN4s4KGdaDemx/wIgj5uCLKt6CfKvzXNaaMS+7QqZjwN6w29MmItaj9l67c72f3RtIl+DIu84YdWEM=
X-Received: by 2002:a02:7a15:: with SMTP id a21mr14609694jac.128.1629470627371;
 Fri, 20 Aug 2021 07:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210819194102.1491495-1-agruenba@redhat.com> <20210819194102.1491495-11-agruenba@redhat.com>
 <5e8a20a8d45043e88013c6004636eae5dadc9be3.camel@redhat.com>
 <CAHc6FU7jz9z9FEu3gY0S2A2Rv6cQJzp7p_5NOnU3b8Zpz+QsVg@mail.gmail.com> <d5fbfeff64cee4a2045e4e53abbd205618888044.camel@redhat.com>
In-Reply-To: <d5fbfeff64cee4a2045e4e53abbd205618888044.camel@redhat.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Fri, 20 Aug 2021 16:43:34 +0200
Message-ID: <CAHpGcMJTPfJ3M8SjMgv88xkbJLy8mhXTGEkWy8WjXM0NBcsZ1A@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v6 10/19] gfs2: Introduce flag for glock
 holder auto-demotion
To:     Steven Whitehouse <swhiteho@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Fr., 20. Aug. 2021 um 15:49 Uhr schrieb Steven Whitehouse
<swhiteho@redhat.com>:
> We always used to manage to avoid holding fs locks when copying to/from userspace
> to avoid these complications.

I realize the intent, but that goal has never actually been achieved.
Direct I/O has *always* been calling get_user_pages() while holding
the inode glock in deferred mode.

The situation is slightly different for buffered I/O, but we have the
same problem there at least since switching to iomap. (And it's a
fundamental property of iomap that we want to hold the inode glock
across multi-page mappings, not an implementation deficit.)

Here's a slightly outdated version of a test case that makes all
versions of gfs2 prior to this patch queue unhappy:
https://lore.kernel.org/fstests/20210531152604.240462-1-agruenba@redhat.com/

Thanks,
Andreas
