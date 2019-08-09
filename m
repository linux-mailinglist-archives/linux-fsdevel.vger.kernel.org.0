Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A57EE883B0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Aug 2019 22:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfHIULq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 16:11:46 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47026 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfHIULq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 16:11:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so99305924wru.13;
        Fri, 09 Aug 2019 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=33J6hcH2HYc/2SD598sQ3T89Yhn76Qy1ADbBG1GDC0o=;
        b=DnfnsGgcPMmRHKwXnNaf58qgyjzoIuiCLIfMUs66yGXQt8yAQXsUjwGlY/hw/sUMsf
         gygQBRnWCF3QUO/l+3mSuyoDBSG0YdCDL3guXxi3aG4nybUoQz+dt/NPDLthm/dBAt8q
         ARPR12Krx0rcGrElO0Z4WN5p0xT/oBn1dGfALlQiYuCpkFnc95SOUDtIrnYLey4Dqc9h
         14DkLmcnQKFrwsiehpWYujU3Uv/LBSbBDutcQk/AsOwlXyHW8GmmoK8jK5QQ6BywfLec
         hp4zA+4eZXX3GHutPNLO7q1SodMx4QAZQNg3mc8p073+mT0XiiVERMCHuHdBBEfKLXt0
         lSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=33J6hcH2HYc/2SD598sQ3T89Yhn76Qy1ADbBG1GDC0o=;
        b=TWFi5DPEDZ8wIsjAIs0hAULo+uVs0aqM75NLybK5jynomniM7vgvMn5mnWyckAt4Vt
         2gfSGcI6QfHycWINYVUVrauFoWfChrT1Jm9x0a5yqtpEzUYeNjpYlyryGABVGmNU5i6E
         AtqwrFHmhIKJhC3oE3mzWcUj+qYjLgY2mtmFipxY/lsj0Ma8hMJZjGTKeNwhGjjUm8ty
         Z/0zDkJ0OaoOoXdG57b1ze4WyNROjK5r4NfYnLU0fz6p1q/LwjoixOHzykPF1ccp5Fg/
         /KUwc+kEOmzcMPDjpTf+C5uGcnT3L7IROif+ZaUTNV62HWhMYI/nYaNtqUmk9Q3Ar54d
         22mA==
X-Gm-Message-State: APjAAAXWZ0WlkHbwSUggDnfXlPMabu1ficMCpN+3pbZFg1e32TiPSK/X
        ttZFoye2V+zTBjcuCYoWAlRXLXOwtRvyHZBi1/14rtgA+G0=
X-Google-Smtp-Source: APXvYqz0exDywPgcVRqLNQZMypGQRjFJA/Zqg/3boLLQ4hSQlQ0sb7OyAOqZivtVWIt3mA2nHUaqta2NqrbHO7maF+o=
X-Received: by 2002:adf:f54a:: with SMTP id j10mr7271950wrp.220.1565381504029;
 Fri, 09 Aug 2019 13:11:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
 <CAM0jSHP0BZJyJO3JeMqPDK=eYhS-Az6i6fGFz1tUQgaErA7mfA@mail.gmail.com> <156537674371.32306.7527004745489566049@skylake-alporthouse-com>
In-Reply-To: <156537674371.32306.7527004745489566049@skylake-alporthouse-com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Aug 2019 22:11:30 +0200
Message-ID: <CA+icZUVy2P6jm-36jWErJA9q=SX3ORyKnoxhKGB5qz=xZkPrUw@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Matthew Auld <matthew.william.auld@gmail.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Hugh Dickins <hughd@google.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 9, 2019 at 8:52 PM Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Matthew Auld (2019-08-09 19:47:02)
> > On Thu, 8 Aug 2019 at 18:23, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > >
> > > The filesystem reconfigure API is undergoing a transition, breaking our
> > > current code. As we only set the default options, we can simply remove
> > > the call to s_op->remount_fs(). In the future, when HW permits, we can
> > > try re-enabling huge page support, albeit as suggested with new per-file
> > > controls.
> > >
> > > Reported-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > > Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> > > Suggested-by: Hugh Dickins <hughd@google.com>
> > > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > Cc: Hugh Dickins <hughd@google.com>
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
>
> Thanks, picked up with the s/within/within_size/ fix.
> -Chris

For the records and followers:

[1] https://cgit.freedesktop.org/drm-intel/commit/?h=for-linux-next&id=72e67f04637432f91e4cc5e8e4f7eb4e38461e8e
