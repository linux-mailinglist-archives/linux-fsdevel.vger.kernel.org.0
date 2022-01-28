Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946B649FCBD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbiA1PY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 10:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245268AbiA1PY1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 10:24:27 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DAC061714;
        Fri, 28 Jan 2022 07:24:27 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id d188so8121088iof.7;
        Fri, 28 Jan 2022 07:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3f+nKFjcCkx7vPE/hRl6V7lq9dcKuTW80D9yE8CSto=;
        b=DTAFDsIiD03g9kO+vUXAc3AEWeyDlatqfHYEwOuRX4RQ8OLkSFLBGZZQbNVBTrKTal
         P/8jAPiap4R5Tl5MRkP0FRuoE5RjMLaHYMmwOSoPbrmjlxu888P0EH+WAjqtiisAw5+A
         cBquXsaDLrcVJRw8bnIinEgfhreeNbO2XZMEH13zvtlaEybgUmuwzVIigwvolT72DiOE
         mBCmGwUpeH9w1vwayB5QlvSRTIJCW3nXjZCnySyE8Mz09In5/JfEyRdar7dAsKi3BQLe
         WeROjZlY/YRaFhEPb6clA2p4+Ce83AHKqwBk7Px4r5qu9YNXyK4Nn3GOp3BwutyQ6vMh
         kgKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3f+nKFjcCkx7vPE/hRl6V7lq9dcKuTW80D9yE8CSto=;
        b=ImWuutgtcc6CfFFQQ/KQbz1qJB7scsqXW8te+rXL90Wg7BV4r6ChXHOGR8/FUhWH93
         T1kmV9mwgTpQoucFcA0XTH1ye/Kkgl0LKFHYV2CrvggtKMBEQKsBRzq7mnC7vhHUUly2
         2xTBQF36m//CX+johW79gItOo4piqzeu+D9a2s0FDkwRniZTOXhME8JhszGwCMlyseAm
         XYhPywMJzcH7lbFhaOnMNKhPQ2hCCuEJEFRz8l2Fh8F8re+Ebzd4Jq0QJVZC8p8lMrwI
         xYIo850Q4NMDD1pVmYjtZ+zmRj/ILVEDs1bgNBhPb/ZhSjO2DgSrGHdKpWQtknK0Nbik
         dHQQ==
X-Gm-Message-State: AOAM533PIXQoJfi7mVh8aBnBRGgukhQbKP78De4sJkOj2nT7LVFFkH1V
        GkRnJVnDqRJgWozD3EHMqYWR6FpmG7Daswi/XyU=
X-Google-Smtp-Source: ABdhPJw8QSC335yxDSlN+ePXg6XZsLitEpZm5RasLgPviD2XPBI4/C8/6ZvqmHLH2FrXgni+yv9ELxOcF71IaYbMLvs=
X-Received: by 2002:a02:b0c3:: with SMTP id w3mr5129229jah.1.1643383466450;
 Fri, 28 Jan 2022 07:24:26 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com>
 <20220128074731.1623738-1-hch@lst.de> <918225.1643364739@warthog.procyon.org.uk>
 <922909.1643369759@warthog.procyon.org.uk> <YfPs4hpWtFziiO2c@zeniv-ca.linux.org.uk>
In-Reply-To: <YfPs4hpWtFziiO2c@zeniv-ca.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 28 Jan 2022 17:24:15 +0200
Message-ID: <CAOQ4uxhMBZBE1dBZJ6S5MfhCNCZ2NdDpzuQyR7rp4J6gyp6p_Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: rename S_KERNEL_FILE
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 3:17 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Jan 28, 2022 at 11:35:59AM +0000, David Howells wrote:
>
> > > Whether deny rmdir should have its own flag or not I don't know,
> > > but from ovl POV I *think* it should not be a problem to deny rmdir
> > > for the ovl upper/work dirs as long as ovl is mounted(?).
> >
> > What's the consequence of someone rearranging the directories directly in the
> > contributing dirs whilst there's an overlay over them?
>
> "Don't do it, then - presumably the kernel won't panic, but don't expect it to
> try and invent nice semantics for the crap you are trying to pull"

IIUC, I think that is the point Dave was trying to make.
Nothing good can come out of allowing users to manipulate the overlay
upper/work dirs, so denying rmdir on those dirs that are already marked
with the OVL_INUSE flag is probably not a bad idea anyway, so ovl
and cachefiles could potentially use the same flag with same semantics.

Thanks,
Amir.
