Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38727C1E6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Sep 2019 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730593AbfI3Js7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Sep 2019 05:48:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13409 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728581AbfI3Js7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Sep 2019 05:48:59 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C2AA58;
        Mon, 30 Sep 2019 09:48:59 +0000 (UTC)
Received: from work-vm (ovpn-117-232.ams2.redhat.com [10.36.117.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B74D60A9D;
        Mon, 30 Sep 2019 09:48:52 +0000 (UTC)
Date:   Mon, 30 Sep 2019 10:48:50 +0100
From:   "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] virtio-fs: rename num_queues to num_request_queues
Message-ID: <20190930094850.GC2759@work-vm>
References: <20190917114457.886-1-stefanha@redhat.com>
 <20190918164832.GH2947@work-vm>
 <CAJfpeguDfn=3fnYoAj78H7fEvZ1bSt0dtEQ9J1Gk3mJDVA-YxQ@mail.gmail.com>
 <20190925102255-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925102255-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 30 Sep 2019 09:48:59 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* Michael S. Tsirkin (mst@redhat.com) wrote:
> On Wed, Sep 18, 2019 at 08:22:06PM +0200, Miklos Szeredi wrote:
> > On Wed, Sep 18, 2019 at 6:48 PM Dr. David Alan Gilbert
> > <dgilbert@redhat.com> wrote:
> > >
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > The final version of the virtio-fs device specification renamed the
> > > > num_queues field to num_request_queues.  The semantics are unchanged but
> > > > this name is clearer.
> > > >
> > > > Use the new name in the code.
> > > >
> > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >
> > > Consistent with the latest version that's just passed the voting;
> > > (see
> > > https://lists.oasis-open.org/archives/virtio-dev/201908/msg00113.html )
> > > so:
> > >
> > >
> > > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > >
> > > > ---
> > > > Feel free to squash this patch.
> > 
> > Thanks, folded this one as well.
> > 
> > Miklos
> 
> So what's the plan for merging all this?
> Doesn't look like it was sent in the merge window, nor is
> it in linux-next.

It's in the version that got merged upstream over the weekend.

Dave

> -- 
> MST
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
