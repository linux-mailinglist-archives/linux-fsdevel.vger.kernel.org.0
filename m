Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4375237BC93
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 May 2021 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhELMfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 May 2021 08:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbhELMfO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 May 2021 08:35:14 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052C3C061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 05:34:07 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id j128so11891758vsc.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 May 2021 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZBUeXfO+LRlpyyMFiXZ2tFKvXStq4CdL44LCdzf+0+A=;
        b=oFV5D+PvFVTlaBpOnZ0vKlB7Y86tD87iFJB64z6UkoHaY3oQbRWy5qxSbsWli7wPHf
         qIZUV/LrS43YtRkWn7p+kxL6PHmgL0QjnyzU3p/1bq1Q472PjErm6+Y3lOG2NNY5SOD2
         4YFu6VgpgZoamyAh/ln7Lkg7lA3xso4ecL3xY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZBUeXfO+LRlpyyMFiXZ2tFKvXStq4CdL44LCdzf+0+A=;
        b=X8MIDoEaqe+WANEOj5rHbGbYsSQ2+bugfD6Dw+MyhaFKvOZYCa92OA3f3h2ZGQz3v4
         MvM6N/zfaZRlsVzyq+i2V15jR4R9E1GyhHpnyRbE95Nra6b0X3zKQCpA68qAATPL/0/8
         RvG2GlzX/4sAw7i1vgSItxp9g/YNNG4DIKCOMOavMv+CkcguA/fEC6Cjk57/TpLxDPIU
         +ikAPQBjigUYqtgDctcV6Z/M0zxgOWU/zchPQXvsOlS+DkHESRJteMgaqrGCv3GrLIzh
         H3joXipgEcI1JIyf6eA6JtB20Y+c/QfDNqGIYVuOv79ksNl4sxc24/QoATm8NxWi7Mqs
         xG9g==
X-Gm-Message-State: AOAM530dIN3m6ztVqRsbUsahyQVGFECfO3yvdo8PjbMKmN5xd2X64O8Q
        yLHoChUbzz6/iP9Waepee7MEwqqqDRz6TBIlU4Sl0UTMR7s=
X-Google-Smtp-Source: ABdhPJwcQUmTsDZe1tlKKxQ0k2DFQZ0d/Y5Ani8NgRrgP15I6gd3bi9EJAIz9kIzmlvPHOtZ5oH87GpMj42FwwujpPs=
X-Received: by 2002:a67:68c5:: with SMTP id d188mr32088562vsc.0.1620822846262;
 Wed, 12 May 2021 05:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <000301d74329$149c0b90$3dd422b0$@vivo.com> <000d01d74657$d73590f0$85a0b2d0$@vivo.com>
In-Reply-To: <000d01d74657$d73590f0$85a0b2d0$@vivo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 12 May 2021 14:33:55 +0200
Message-ID: <CAJfpegvGZh1EfYv4=nweKjZO9c36iWGnJCYM3g+=bs0cqAKZMw@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: use newer inode info when writeback cache is enabled
To:     changfengnan@vivo.com
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 11, 2021 at 1:21 PM <changfengnan@vivo.com> wrote:
>
> Hi Miklos=EF=BC=9A
>
> Did you get a chance to review this patch? looking forward to your commen=
ts.

Hi,

The patch looks correct, but this is a complex issue and I want to
make sure I understand it fully before applying.

I've not forgotten about it, it's queued for review.

Thanks,
Miklos
