Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA302B6A6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2019 20:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbfIRSWU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Sep 2019 14:22:20 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:45771 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388409AbfIRSWT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Sep 2019 14:22:19 -0400
Received: by mail-io1-f66.google.com with SMTP id f12so1356206iog.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Sep 2019 11:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrWrP6LppcfpzzkLfQpAbWDzJ4JoIoBDTe7nuYc1/2s=;
        b=aAZFU9OkAaH528RJZNBBCcNOrWve2s1cRZncvoNJ3N9Od8IfptE/DzqBGiJ6NCRMHV
         xfN6ge8T5o+E4twP0kpzOsVesGsH24f3OImqTx9SMVzalvC7lXhp5pCe+Rv7neE1BWRM
         DHXsKcTsN2Fj8gONQITZ4oSZAt1nVUz4gLJ7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrWrP6LppcfpzzkLfQpAbWDzJ4JoIoBDTe7nuYc1/2s=;
        b=I9QaYilcCrW+HTpoyy1i41ubsS6otYasBhYUVaJQGmbn8NlInHyl0SY7d3G7UwV0qa
         //rizCtYP5FWf54EuVFzTndh85FlABRj+pKU5FgkyG9jiUCrGaC6fErShmBiL9Em2/1x
         X252VYKIXjQ6EAiZCP9Lm11qdfqmR1Aryd7zvZ9Eho43Kt9llNBlX3rjPx69c+nccObL
         T6orZD62verL2m0Hsgx2iXpxRrdLnurPdhxV6WWyTEE9WBg9dmnVOQUKB4ZDAJWaV5le
         7iHjGxgCyvzYoxFoPk7/3HQMprHfraiFWA+J7EbjgKUHOmz1SV2DlFnL9OxmOqTbK2kE
         /8HA==
X-Gm-Message-State: APjAAAWuGEimCgsJ+29YrGBZ4IRU2tAMdOuTRFZnGcJA0aMO7FsYAl50
        l2Bcoev1XVVtICiVvQ0EcYoDqt0JUfa3115lSupBh8nO
X-Google-Smtp-Source: APXvYqzl6sY7kahrt8zQTpnaGKy6Iq1dMXSfSuFPW5/OYjlThDXZxIdSoT7yLyBdSCuzs9znZyGCAn/SXP/rANTy2+U=
X-Received: by 2002:a02:9f02:: with SMTP id z2mr6234916jal.78.1568830937842;
 Wed, 18 Sep 2019 11:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190917114457.886-1-stefanha@redhat.com> <20190918164832.GH2947@work-vm>
In-Reply-To: <20190918164832.GH2947@work-vm>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 18 Sep 2019 20:22:06 +0200
Message-ID: <CAJfpeguDfn=3fnYoAj78H7fEvZ1bSt0dtEQ9J1Gk3mJDVA-YxQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-fs: rename num_queues to num_request_queues
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 18, 2019 at 6:48 PM Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > The final version of the virtio-fs device specification renamed the
> > num_queues field to num_request_queues.  The semantics are unchanged but
> > this name is clearer.
> >
> > Use the new name in the code.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Consistent with the latest version that's just passed the voting;
> (see
> https://lists.oasis-open.org/archives/virtio-dev/201908/msg00113.html )
> so:
>
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> > ---
> > Feel free to squash this patch.

Thanks, folded this one as well.

Miklos
