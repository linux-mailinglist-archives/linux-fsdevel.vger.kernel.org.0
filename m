Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72388402761
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 12:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbhIGKuf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 06:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbhIGKue (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:50:34 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7F7C061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 03:49:28 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id m39so5295411uad.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 03:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYG9Fi3z+egdVVaY5+h8K/VQlMvs8aZVEL6ON6ZCKao=;
        b=cct/ZmvR7M05+H1leGas1Rgwc/9+Rs+Kw/FwXTXqhY4zAqxLofL/Y05KJkSECtnGLs
         NYatrmBLYrP6VEcaMwBO/gdxMxhcomIFZ8nbshWDgNG5uR/YegBn4J3hQiQAVpEmU0hO
         x71HJ92Fl/dHbMJTpIApiUuwsQzyllHF6HVOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYG9Fi3z+egdVVaY5+h8K/VQlMvs8aZVEL6ON6ZCKao=;
        b=eBflBiJGHGJgNaUXbIhSu7dQJXUGRlk5EYsy06i6cAUoHUJPtzbL/jszaYqp7HNZ/k
         iFOBJB+LVFexcVknaxo6XjXZcx9ZTRwdL4JpI50VeTCCE58sgdeA9rqCgzpcr7WjYt9K
         aOOn7UOnD4lD2PsEUXzTflbxYrIie2VoroSQG/9Q67m/hncxXEAf5pihUlYENSZK4hrN
         jFqflFJzgnZ8fkzzmOOM7NPrDnZ4PkMhgut5ncfpnDEOLXer2oYYmY+Al/U5tdCwkeem
         g/ScZlFx/ns7HJQRHDbQesg91xHilWb1nqCAUbuFudFeJwmW1aj7FtaR9DsioxYnKYe2
         LurQ==
X-Gm-Message-State: AOAM531kuWOKTEPHHEGYf35h0ihNlsDqAumxV7QVfGsAf3rj3269Q9ou
        d7uu8vGBmwoykhT2+kEd691HfVLXS+zGPZg2gBF8rQ==
X-Google-Smtp-Source: ABdhPJwSz2KZS0aXqrWx8e0hD0uNlbCAisIZ4SaNUIN+0xny1JDy6DzLGtoH9/XVcG11jVJIKEt/l5HblP4t0y8sG0g=
X-Received: by 2002:ab0:3b93:: with SMTP id p19mr2840680uaw.72.1631011768063;
 Tue, 07 Sep 2021 03:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAPm50aLQxAdrWz4PR=fVYJC-eT0pjEp4HEhHxALfaJJT1TH2eQ@mail.gmail.com>
In-Reply-To: <CAPm50aLQxAdrWz4PR=fVYJC-eT0pjEp4HEhHxALfaJJT1TH2eQ@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 7 Sep 2021 12:49:17 +0200
Message-ID: <CAJfpegv_2rBc4g3ykk2m7rNtE3=cEWaNXzA_jRfCMQPa=rBJOg@mail.gmail.com>
Subject: Re: fuse: Delete a slightly redundant code
To:     Hao Peng <flyingpenghao@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 14:32, Hao Peng <flyingpenghao@gmail.com> wrote:
>
> 'ia->io=io' has been set in fuse_io_alloc.
>
> Signed-off-by: Peng Hao <flyingpeng@tencent.com>

Thanks, applied.

But please do note that gmail corrupts patches and if it's not the
trivial variety like this one, fixing that up would be problematic.

See Documentation/process/email-clients.rst for more information.

Thanks,
Miklos
