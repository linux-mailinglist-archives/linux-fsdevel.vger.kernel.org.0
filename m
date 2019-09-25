Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC7FBE010
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Sep 2019 16:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437372AbfIYObg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Sep 2019 10:31:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44144 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437362AbfIYObe (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Sep 2019 10:31:34 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C52CE51EE8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 14:31:34 +0000 (UTC)
Received: by mail-io1-f70.google.com with SMTP id o11so9691218iop.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Sep 2019 07:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LzQwOh10SaHDPi9QjnvbbUCCKW6+It1C79s76PrjIHs=;
        b=NNP1SFCqTwdXRZ5gNwONwwoQDyHOt7ancPSSyNvFYxF7hAfxK93aZgygh5At8m0iMa
         pGfKjczucsX/PMf6sLxGJ3OZ4qBB2POz5HqgO5/MeIh9vtQfxct5G5kK/TH7NxU9jynQ
         nM3PJhhMspNkH9z0PXJeOobsgvL4XT72HHGG66Q18zM09CyJDg0AohCZ5YFz5CHl6xAR
         5tEq+nk2wodokEy3iY07gQ32foYAuZ8yE5/bbNlcRRj2C9WIRm6Odw7CMr4uyo1KLSll
         nKagtX8ThTm3i1C3qtc/f7Fi157+Lvbig4lGednk0Cm+NEVyo09toXnXHbZ0545of8kf
         m8uA==
X-Gm-Message-State: APjAAAUFJ85vShRjVilafNCxfH6Ev/Jtzq5JP9WBmSRsIM5tHm52XEJ0
        4DoYz95NGCKqQqQZ3PO4geUwoSG+me4okLOZ1GRtLfGdSmkpAcU5kpP5G3AgSyKC0RuHJ/LNnqc
        8vuXck+wqMqKZ+muWxlV2K3bIGqNVwnk7eccTYFzo1w==
X-Received: by 2002:a02:94e5:: with SMTP id x92mr5228019jah.11.1569421894152;
        Wed, 25 Sep 2019 07:31:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwm7s/EFaFwM5ub9m6+EEyJ+6nSNs5MVj2tBXbWsimC8xPIffiHo/j9Tdnq33Ui7JWgoTAaR+nmP6UoNzIBPOM=
X-Received: by 2002:a02:94e5:: with SMTP id x92mr5227999jah.11.1569421893882;
 Wed, 25 Sep 2019 07:31:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190917114457.886-1-stefanha@redhat.com> <20190918164832.GH2947@work-vm>
 <CAJfpeguDfn=3fnYoAj78H7fEvZ1bSt0dtEQ9J1Gk3mJDVA-YxQ@mail.gmail.com> <20190925102255-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190925102255-mutt-send-email-mst@kernel.org>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 25 Sep 2019 16:31:22 +0200
Message-ID: <CAOssrKeF+5GOSvUN3F+OcxYGBLHu3rM4tmzRJW9-oDuxtb2mTg@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: rename num_queues to num_request_queues
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 25, 2019 at 4:23 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
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

It should be.

Sent pull request for fuse update today; this includes changes
required for virtio-fs.  Planning to send pull request for virtio-fs
itself tomorrow.

Thanks,
Miklos
