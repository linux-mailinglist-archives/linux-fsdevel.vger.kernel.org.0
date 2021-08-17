Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4ED3EE7FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 10:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbhHQIHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 04:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbhHQIHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 04:07:38 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1F6C061764
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 01:07:05 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id b26so6437153uam.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CeT7/CgVvEfQsAhRqPkoAVPoIIWJXiZlPWeu07uodXc=;
        b=g88CnCFFPOXT/19Ud163ryRrpOrBR+Hl81zf2AY3pqDq/ZNX8KP0ecWQtiMTl8M7mK
         nzft7IyzCcBoJ1qQIY1h3H0kUryG3f+3EKuea03JxjuUvKc+4hiUFX0cdt+eeEKSYIk7
         UOUGgeCRY+Y1U+Y8vFJrnCJfJmwfChTjl87mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CeT7/CgVvEfQsAhRqPkoAVPoIIWJXiZlPWeu07uodXc=;
        b=bZs3kPH2fg9etN5+Bn8zkiy7OWTo7duxsSIQvAtk/xSoLx875oEoO7JRMnqFdZzOL7
         Haa3goWmz4mufZt9E8nOgQmF6MLlf5P3dIZ3iEaVfPm2HRqfbWZBbZZwcAEmGByllaxf
         B498OS95AW9xx2+ax5ohIz3jUgYEpJNAy74Op7zZ4tWzQUqC0XZj+B7mpcitLb30I+vl
         RhclTWSB8GyX/7JCHzY1bYKdS8ovffLErMOGYj1Gtzv/3i2ZoeNlcd6vd5BtWhGO8baA
         Y1Z+j+IT3UFgGQVLq6bGMZ1iWOxp+TkgL2mVm0pziWxMnmia+/sUIgGz2UMNhY24DGjX
         PhhQ==
X-Gm-Message-State: AOAM5331Xe8KO5fUCLH1W6gDoPo/sC1nZCteMvZ62lmZrzWrVByrXTT0
        z/uq9eZKmqbnRmm/X8lcJoIDDvgKK0u1P22nF6WJLg==
X-Google-Smtp-Source: ABdhPJykt8oCzcvvJjQbvrLkP2n3MDy7yGcwWFGAQ1by1xX/HdIgGAQ7G1VOJpi3lRkoegCF2LcE/BkhBEZdIZDMvsE=
X-Received: by 2002:ab0:3757:: with SMTP id i23mr1250024uat.72.1629187624677;
 Tue, 17 Aug 2021 01:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
In-Reply-To: <20210817022220.17574-1-jefflexu@linux.alibaba.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Aug 2021 10:06:53 +0200
Message-ID: <CAJfpeguw1hMOaxpDmjmijhf=-JEW95aEjxfVo_=D_LyWx8LDgw@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] fuse,virtiofs: support per-file DAX
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Liu Bo <bo.liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 17 Aug 2021 at 04:22, Jeffle Xu <jefflexu@linux.alibaba.com> wrote:
>
> This patchset adds support of per-file DAX for virtiofs, which is
> inspired by Ira Weiny's work on ext4[1] and xfs[2].

Can you please explain the background of this change in detail?

Why would an admin want to enable DAX for a particular virtiofs file
and not for others?

Thanks,
Miklos
