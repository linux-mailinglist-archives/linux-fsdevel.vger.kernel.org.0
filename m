Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9ABDFF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 16:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbfIYOXo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 10:23:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59174 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfIYOXn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:23:43 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8527463704
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 14:23:43 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id w198so6245455qka.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 07:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gp43JAdBW9GQP97LIz0qTVA7HNaPCirdDASjXtiyJ7c=;
        b=Yx4wOFpvO79l/Ga3ricysAfi/5HW3aZJaYRZtgdZ5iMrbxDA06LPWNHSDYBa3Zzoqk
         03gHV4Zy87L/tA9OUbRjHGddVzI/yrtv1vcH2y++8U3EpONwgS8+lxC6yPTjR+qBp79f
         /F/B7+AdZVBmFL0i5xrBFQ/fFig4xV9MiPZKczvc3ACpkBcfqIT5oqQtsa83/tkzh/CP
         2xWwfu2mY67DNiPXyNyNgJTT9klg9ha6UrHnMGy/k3u5WLs6xEMWd3G6xxzvppcmP/Rw
         0Rb3xNbUatUVT9fgxuVMHC6Kvujj4jEHMHPOQLTCr6SxjUWM4Z3Ak7dbEH4Qkyz4nFHc
         YDHA==
X-Gm-Message-State: APjAAAWFbxdQXNaj+6nJHCTjwKKKOjR1KIUrk49bXTMBgJo+Gh4xsj6m
        9Z/m1OcO4hvyTWxrDwPdNixDEBVyjzwto46Q/W3O29Jsc/CC/sBsaBW2G+3gLwl9l+8hbJzd2Xd
        VuC0QZzJky3jdwoquxtQmjqf3Yw==
X-Received: by 2002:aed:2259:: with SMTP id o25mr9283450qtc.55.1569421422369;
        Wed, 25 Sep 2019 07:23:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwj2esoW10/6yBoeXySerKcEcO6P3pSHv/cmP9S/7gMOa+dN0o7DfeQATIjNe8iQMKc2sYb9w==
X-Received: by 2002:aed:2259:: with SMTP id o25mr9283429qtc.55.1569421422114;
        Wed, 25 Sep 2019 07:23:42 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
        by smtp.gmail.com with ESMTPSA id 14sm2792703qtb.54.2019.09.25.07.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 07:23:41 -0700 (PDT)
Date:   Wed, 25 Sep 2019 10:23:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtio-fs: rename num_queues to num_request_queues
Message-ID: <20190925102255-mutt-send-email-mst@kernel.org>
References: <20190917114457.886-1-stefanha@redhat.com>
 <20190918164832.GH2947@work-vm>
 <CAJfpeguDfn=3fnYoAj78H7fEvZ1bSt0dtEQ9J1Gk3mJDVA-YxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpeguDfn=3fnYoAj78H7fEvZ1bSt0dtEQ9J1Gk3mJDVA-YxQ@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 08:22:06PM +0200, Miklos Szeredi wrote:
> On Wed, Sep 18, 2019 at 6:48 PM Dr. David Alan Gilbert
> <dgilbert@redhat.com> wrote:
> >
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > The final version of the virtio-fs device specification renamed the
> > > num_queues field to num_request_queues.  The semantics are unchanged but
> > > this name is clearer.
> > >
> > > Use the new name in the code.
> > >
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> >
> > Consistent with the latest version that's just passed the voting;
> > (see
> > https://lists.oasis-open.org/archives/virtio-dev/201908/msg00113.html )
> > so:
> >
> >
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > > ---
> > > Feel free to squash this patch.
> 
> Thanks, folded this one as well.
> 
> Miklos

So what's the plan for merging all this?
Doesn't look like it was sent in the merge window, nor is
it in linux-next.

-- 
MST
