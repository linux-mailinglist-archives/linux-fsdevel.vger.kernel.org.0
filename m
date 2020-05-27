Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134881E3BA3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 10:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388045AbgE0IOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 04:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388041AbgE0IOW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 04:14:22 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC4AC03E97A
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 01:14:21 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z6so27763492ljm.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 01:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/zzZtT7KW7sYELS+x9P5gFRYxRCfWQakAeOdFpPLtsA=;
        b=n+U1wbC11tvcVxQlHXWV9nn3KwP1+ePp9m9shXT05yfmWjfN5kBIOqCYsW86q1QDJs
         TWbnR77mQ7t5eJRdy/82kUGdgY7X9jhWMRWSHOOLt/T0raPsQDVlsThMGleAMh0yWhEr
         fZj67VmYf5a1Lp0QiHCvybHuR1S3pU51x0pOytBk9Rk3HL48i9fymYRL12nJ6rVw2o5d
         AAgwJGYPrvVdIvbuX7Z+XmxvChkhRfcaOlzLuOkzJCDh4veOjuxP/2aOOS1QanH8z2Ja
         CK12D3ZIn8CZlry1JEgxI8a1AAtlgwgy/FQtGwW44wx8VYAJMBlx2zbIIaZN54xiLlwl
         N0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/zzZtT7KW7sYELS+x9P5gFRYxRCfWQakAeOdFpPLtsA=;
        b=fY7HZjB7cRrYSY3CoSQnp3dOnpph6RH8YOrX2PdTFvnGrw91Oo3stY1h5OJ6cArSjr
         l+3n7Fif8lvCHkDPRtwGQV0egoBYBOzP4R1UciV7jpDq4VPUPil2K854101dtgz8a4YM
         SJcty1dIR8YsqHd1iFEPTDcKzmef1YwUejNeEJzBMRNBPrKbXqp3/tqV6MumYlyacPts
         BGNnL68X/7dp+Ntsx+yvNoGJq1H5MEnIbZOR+ulU8Rg3ovLSphtoZSLBhmzi09w9jGR8
         ygcJd5Ix3nPoWf6SvPaNA/AdPmwZDariw2UU1xsRFD3H50AIb4gtvDbDAPPNKDZ04FYT
         cLPw==
X-Gm-Message-State: AOAM533L8EGrzfIrc1Cd35bXQXPnnF0bkLdcP6AhtrL9O8Op+8/zopOn
        jMrv5zBuyQfBNLxe9rKI/jZC687noT43/2GqkpKojg==
X-Google-Smtp-Source: ABdhPJzUJ6PUKWE4CS8AO2wzYW1rnO8yE1O6Sl9F6DxNY0ivQj69wqaQu7Xcdvo4njCx9xLdp9661fYvBnTP5lZlUAI=
X-Received: by 2002:a2e:b178:: with SMTP id a24mr2497864ljm.268.1590567260182;
 Wed, 27 May 2020 01:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAB0TPYGCOZmixbzrV80132X=V5TcyQwD6V7x-8PKg_BqCva8Og@mail.gmail.com>
 <20200522144100.GE14199@quack2.suse.cz> <CAB0TPYF+Nqd63Xf_JkuepSJV7CzndBw6_MUqcnjusy4ztX24hQ@mail.gmail.com>
 <20200522153615.GF14199@quack2.suse.cz> <CAB0TPYGJ6WkaKLoqQhsxa2FQ4s-jYKkDe1BDJ89CE_QUM_aBVw@mail.gmail.com>
 <20200525073140.GI14199@quack2.suse.cz>
In-Reply-To: <20200525073140.GI14199@quack2.suse.cz>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 27 May 2020 10:14:09 +0200
Message-ID: <CAB0TPYHVfkYyFYqp96-PfcP60PKRX6VqrfMHJPkG=UT2956EqQ@mail.gmail.com>
Subject: Re: Writeback bug causing writeback stalls
To:     Jan Kara <jack@suse.cz>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, miklos@szeredi.hu, tj@kernel.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jan,

On Mon, May 25, 2020 at 9:31 AM Jan Kara <jack@suse.cz> wrote:
> Well, most importantly filesystems like ext4, xfs, btrfs don't hold i_rwsem
> when writing back inode and that's deliberate because of performance. We
> don't want to block writes (or event reads in case of XFS) for the inode
> during writeback.

Thanks for clarifying, that makes sense. By the way, do you have an
ETA for your fix? We are under some time pressure to get this fixed in
our downstream kernels, but I'd much rather take a fix from upstream
from somebody who knows this code well. Alternatively, I can take a
stab at the idea you proposed and send a patch to LKML for review this
week.

Thanks,
Martijn


>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
