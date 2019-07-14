Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7D0867C97
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jul 2019 03:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfGNBRu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jul 2019 21:17:50 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:45286 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfGNBRu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jul 2019 21:17:50 -0400
Received: by mail-lj1-f177.google.com with SMTP id m23so12721935lje.12
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jul 2019 18:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/ZbMKpaeDfR0c6CluIR2RGEThcJc265Nfb8zCnn6MQ=;
        b=JFAS9tE4paeCtL/HDO7+w783I/1T0SiLhmNcOpTVr2Heh5JE7iPzUXsY4VP8KwcaKM
         vJSrnpHsO4JGdgNhGCw7jHJlrdrLuxe4RT9O3WBDvxWv1nJ1lG1Jl8Vaz51tC0c8rjCR
         ewi9P8bFkO1yo+gtxWxrpgluzYMFNaW7/h1r8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/ZbMKpaeDfR0c6CluIR2RGEThcJc265Nfb8zCnn6MQ=;
        b=n2RlWio7CG2A1GggETa82fw2ho2zp6vo/q97kKgAZwcNAm5A9JkyY88vInJcLPLpv6
         rjdB1LKkqckT7q4afFTKdcxKBl1qbq/EJN808ggHuwfoyhZvLe0WlLB2kxSn3IrWmJ0y
         GouvY79TyhpyZfOQFmesPP/ca4Hss1ui3OP3MFqVzreU//VzMuDE6DgcZlLSYTsF7aku
         OGDs2nebT0mYfgDJ32bUzs7wqOVCuVI6dcVCUVO7WDz9xRtwKVI1inHgFxG49bacpHTM
         5Gv17repPoDotRZBMtQOgFirgJvxzh23Ir//HQAgjm9Fw8SHR7MIf8Gt9n3KTC4otLAU
         h9XA==
X-Gm-Message-State: APjAAAV+1eDqickFpGRuL/Pxh1/BYS0LEhkgXwg1anJ+vWV33dnmPaeu
        84IPdRXHPOSkkVAGQQv9OmCzROOpnbQ=
X-Google-Smtp-Source: APXvYqwRb3NreHxZL/uVo5quLF/MJ7LYHvWHN967+8g514n91iC+3y309s0HInMGhxMCzO8nUXln6g==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr10130361ljk.70.1563067067273;
        Sat, 13 Jul 2019 18:17:47 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s24sm2247252lje.58.2019.07.13.18.17.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Jul 2019 18:17:46 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id m8so12752488lji.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jul 2019 18:17:45 -0700 (PDT)
X-Received: by 2002:a2e:9ec9:: with SMTP id h9mr9461591ljk.90.1563067065731;
 Sat, 13 Jul 2019 18:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190712180205.GA5347@magnolia> <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
 <20190713040728.GB5347@magnolia>
In-Reply-To: <20190713040728.GB5347@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jul 2019 18:17:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEsUC1uLdYCX6rxGxRcgzKS64e3Y8h5HVLvnpGSj5pJA@mail.gmail.com>
Message-ID: <CAHk-=wgEsUC1uLdYCX6rxGxRcgzKS64e3Y8h5HVLvnpGSj5pJA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new features for 5.3
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 9:07 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> Doh, it turns out I was merging against the same HEAD as my last two
> pull requests because I forgot to re-pull.  Sorry about that.  It's been
> too long of a week. :/

Heh, no problem, I was just surprised when my merge result didn't
match expectations.

As mentioned, it wasn't like the conflict was complicated, only unexpected.

                     Linus
