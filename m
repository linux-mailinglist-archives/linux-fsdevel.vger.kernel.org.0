Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9A6BC86
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 14:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQMoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 08:44:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33580 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbfGQMoc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 08:44:32 -0400
Received: by mail-ot1-f65.google.com with SMTP id q20so24824370otl.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jul 2019 05:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33PekZZX1s4b2ZllhlMgDgDyRoxO59g4JGmElbfr7Vw=;
        b=HwKBiNrbnGITLUc+ee7u3PxhekbrS6BcCHaI3D3hEoYxukhNQl+vRi20DR+8K9Y3kj
         jU177ep+yKqGxRAUKLE7Yg9tKM4aRDQfxzl2XXy8zrctZGdWJcSctGtiafAIcdk7vim0
         0v4lRWBcMbyVPpPTKuzBMbavXV4gkCYwwVXU1AD3gxNbST4qCo0swN9cFw60nm9/xVlp
         g0ascT2GhxS9ZMGeQLtW2G0oRIKcP/P/v1MDRKvAAvNDKskMIqpAvEe4NcEMHWuZcmzG
         hmFYmL5uBWHyqOgzsqQ6wxpQuBf6/4C6+S0SPldPqDy92JuL44rP/VRNzCoxzIlfglAg
         gGbA==
X-Gm-Message-State: APjAAAWRDJdUDLCOgb//y7upEQxgrdu6/g5xs4lgPMX5fH+otZPb0toW
        JiCGSnBoN+3/YATYqVDmLdGxDWA9hOl6xZQchLmwXA==
X-Google-Smtp-Source: APXvYqxTboKktRDuhxOsaQEmorwPS3R3wx8c0OouH7uGXFFPrpKfocRMCEVwVcgh6Xhf9YhtXgbqZlv20udAQTRmdNI=
X-Received: by 2002:a9d:2c47:: with SMTP id f65mr29976162otb.185.1563367471220;
 Wed, 17 Jul 2019 05:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
 <156321358581.148361.8774330141606166898.stgit@magnolia> <20190717050118.GD7113@infradead.org>
In-Reply-To: <20190717050118.GD7113@infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 17 Jul 2019 14:44:20 +0200
Message-ID: <CAHc6FU7A3U1FZXwXfvJRL1FazUu=zfJ4=AwpggNG5QWvsywt2A@mail.gmail.com>
Subject: Re: [PATCH 4/9] iomap: move the SEEK_HOLE code into a separate file
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 17 Jul 2019 at 07:01, Christoph Hellwig <hch@infradead.org> wrote:
> > diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
> > new file mode 100644
> > index 000000000000..0c36bef46522
> > --- /dev/null
> > +++ b/fs/iomap/seek.c
> > @@ -0,0 +1,214 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2010 Red Hat, Inc.
> > + * Copyright (c) 2016-2018 Christoph Hellwig.
> > + */
>
> This looks a little odd.  There is nothing in here from Daves original
> iomap prototype.  It did start out with code from Andreas though which
> might or might not be RH copyright.  So we'll need Andreas and/or RH
> legal to chime in.

That code should be Copyright (C) 2017 Red Hat, Inc.

> Otherwise looks good:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,
Andreas
