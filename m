Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 386DB223314
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 07:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgGQFtP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 01:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgGQFtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 01:49:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F5FC061755;
        Thu, 16 Jul 2020 22:49:14 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id f23so9275872iof.6;
        Thu, 16 Jul 2020 22:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=jRkz34kzHFPJP/YTtWgR3dxC6hqrBlvuag30CVq0UoQ=;
        b=iI/+5rrkFI4dnPFFL/L9iw7HH0VcWjZdoGZaaLuBlmQLDJBqtgojCpPaS3yo+FxkxR
         QnsmJXspT3A6FdmPPRQi1kCxZI3LL4vXUOxU9+4MTQFH8ebFhEC6t9sSPUzTHryU2S9P
         wA4jU47UYjRo8kflfSBSCbrZn1YjpOsYYvNfxjL+8oSiE/dp8lXc4Ieoe3wd/ezx+p6X
         Y23br8KsxQoPQ8wl8rvcmJ3qSQ4E8lZjIC7NzYhOtXZR6nkY8+XsUhqu94AC0nRBLKkf
         wbjb8wv4lIfPYwBANTy2DmUI/ncQ0uDt5kIhcoBMNekF+PvbzBgB7lsW37mcntgP1ZDg
         fV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=jRkz34kzHFPJP/YTtWgR3dxC6hqrBlvuag30CVq0UoQ=;
        b=OoGVshz3SCffiY5Hctbq15Zb/iYxrkW8s7K29oHjaNdOZbrkJEoa201dg80eSdnt/K
         ydqAJJ3P5NHZQT5rI2D0qjaXEZ85Xy7qaAYTBWxa4iNpypvZN96hmvWEu15HWPr4BI6j
         EovtwB5Xy3F65cTEIZYEMhjnTrGlHDllJDeeI4WMHsVeiVwKG6YySzqiXL39hIzAsRpx
         lyz5fWgiWOr0KapdfDT6SBRAR9z/UEQ+b2fA5W1R5K91O6Z9zvBgwhV/0bxXAw1/sZw4
         U41cyAoZL9kXiiaebu/Qj1i8lOJ2nOmX6Dfd4Xe54PL0sa4UO2MDSdQYjnO1m+YzQqYp
         Cg9w==
X-Gm-Message-State: AOAM5337XQ2up79OdCBHIIYSwg1PIw9n7uLxZo69YZwMOPzpXohV+aXR
        z+lqU1B3V40s6qiDm2PhOOpVJIvb1FuNvvvxmXk=
X-Google-Smtp-Source: ABdhPJwJ///MEyrS1OLVdgShQV62SL/Jv9Vfiv4k/9Hxb86brLgF/WS6Lsx3au+bsCH1wKjhDxJ9MhMotr+Lz82o9EU=
X-Received: by 2002:a5e:c91a:: with SMTP id z26mr8188202iol.70.1594964954143;
 Thu, 16 Jul 2020 22:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200717044427.68747-1-ebiggers@kernel.org>
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 17 Jul 2020 07:49:02 +0200
Message-ID: <CA+icZUVztkBRBhs_NQpTOg7rc34VkBQ1GCr5iXgw+P9XORwd9A@mail.gmail.com>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 17, 2020 at 6:48 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
...
> This is motivated by the discussion at
> https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
...
> +In where cases where taking the mutex in the "already initialized" case

"In cases where..." (drop first "where")

> +presents scalability concerns, the implementation can be optimized to
> +check the 'inited' flag outside the mutex.  Unfortunately, this
> +optimization is often implemented incorrectly by using a plain load.
> +That violates the memory model and may result in unpredictable behavior.

- Sedat -
