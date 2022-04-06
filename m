Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB674F62A1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 17:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbiDFPHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235571AbiDFPHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:07:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88E6537782;
        Wed,  6 Apr 2022 05:00:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gt4so2315745pjb.4;
        Wed, 06 Apr 2022 05:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KGic0+TD/qOzfTQcCu/HayvB0cjWqsZOmin9mmy3mFw=;
        b=luPNnM5+sAGkLrogyd3ELTJCIkfu3AcHZ+rumOdIWZN6dkturZ7aBf4yd6uxuQpMwx
         GJek9II8ldcpwS5HKJWPIMEy5zOWfdxrN6c0FBVMfQ8tRXbuFT1V7Q1b8tkmb9D8LAhP
         uT1MsNgkLvjYJtBZLpIbs2uFcIzQrsvCik/Cqqq54cdeC9bnnnPKWIrSc7W62llWG5mQ
         Tln/IZ160BSoUs7AXcOIvHcTtn2xo8l5m1272P0O8nMvqvJpQmARwXfPk8nleUcvzyjS
         ayl9noWSBf6fQcpLBnjUK/nhzk6SCve4gmSHUDvnKwCIGn4TwPTLhVq8Hi7VT8qGHjrC
         z2aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KGic0+TD/qOzfTQcCu/HayvB0cjWqsZOmin9mmy3mFw=;
        b=4oDbF7vgRA86xVMN/Ry6rV1TKL5SJoQ/FZgjEruAIgGEw9xrBPqGbo8yFHME5LfG+t
         7nx19a3vcjNa2/6YutpnU5k9MOLrXwH5T9M+s6k+dGyT/jhneV0G+DPhTiLMR+DNmCIK
         WAGzP+kGFYmMMbzLSj4LQvxX5FSJzx1IB3WrO2nj3AmnhxkqsJ5mIkn5UD9JQktZ6aKX
         RRXdfOLrHawJQjsb5vawt0jF4hWh80PSwA/qAKkgyeNMxDybcq7XEMPr//hgKAEUiu41
         Ds5TQOO+EC3ZxhW72tplpf3z12vFQmfUYqSaYcYSSx+zMYXu6JJrFPIe219LaigLWq/w
         +uNw==
X-Gm-Message-State: AOAM531Rb8TPFuMoSP7TxiO4LSCs4c5Ep1TxFs8I4KJ5tHCDVMGYK4ST
        cH2LuDk7ldKdnpNzlWTfReSPQRQI0YjE7w==
X-Google-Smtp-Source: ABdhPJxN3YRC5NSYbWqRcPJkpW8LPWFVapL007bFLK3IcOb4kTkdBxvbBmVoAy4mijJ87urjEho01A==
X-Received: by 2002:a17:902:7c8c:b0:156:5651:1d51 with SMTP id y12-20020a1709027c8c00b0015656511d51mr8368897pll.107.1649246189591;
        Wed, 06 Apr 2022 04:56:29 -0700 (PDT)
Received: from localhost ([2406:7400:63:b4e6:5967:b872:39cd:bdb9])
        by smtp.gmail.com with ESMTPSA id d16-20020a056a00245000b004f7728a4346sm20072842pfj.79.2022.04.06.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:56:29 -0700 (PDT)
Date:   Wed, 6 Apr 2022 17:26:25 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 1/4] generic/468: Add another falloc test entry
Message-ID: <20220406115625.3a2fzn3je7s43xtt@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
 <20220403232823.GS1609613@dread.disaster.area>
 <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
 <20220406040508.GC1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406040508.GC1609613@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/04/06 02:05PM, Dave Chinner wrote:
> On Tue, Apr 05, 2022 at 04:36:03PM +0530, Ritesh Harjani wrote:
> > On 22/04/04 09:28AM, Dave Chinner wrote:
> > > On Thu, Mar 31, 2022 at 06:24:20PM +0530, Ritesh Harjani wrote:
> > > > From: Ritesh Harjani <riteshh@linux.ibm.com>
> > > >
> > > > Add another falloc test entry which could hit a kernel bug
> > > > with ext4 fast_commit feature w/o below kernel commit [1].
> > > >
> > > > <log>
> > > > [  410.888496][ T2743] BUG: KASAN: use-after-free in ext4_mb_mark_bb+0x26a/0x6c0
> > > > [  410.890432][ T2743] Read of size 8 at addr ffff888171886000 by task mount/2743
> > > >
> > > > This happens when falloc -k size is huge which spans across more than
> > > > 1 flex block group in ext4. This causes a bug in fast_commit replay
> > > > code which is fixed by kernel commit at [1].
> > > >
> > > > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d
> > > >
> > > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > > ---
> > > >  tests/generic/468     | 8 ++++++++
> > > >  tests/generic/468.out | 2 ++
> > > >  2 files changed, 10 insertions(+)
> > > >
> > > > diff --git a/tests/generic/468 b/tests/generic/468
> > > > index 95752d3b..5e73cff9 100755
> > > > --- a/tests/generic/468
> > > > +++ b/tests/generic/468
> > > > @@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1
> > > >  _require_metadata_journaling $SCRATCH_DEV
> > > >  _scratch_mount
> > > >
> > > > +# blocksize and fact are used in the last case of the fsync/fdatasync test.
> > > > +# This is mainly trying to test recovery operation in case where the data
> > > > +# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.
> > > > +blocks=32768
> > > > +blocksize=4096
> > >
> > > Block size can change based on mkfs parameters. You should extract
> > > this dynamically from the filesystem the test is being run on.
> > >
> >
> > Yes, but we still have kept just 4096 because, anything bigger than that like
> > 65536 might require a bigger disk size itself to test. The overall size
> > requirement of the disk will then become ~36G (32768 * 65536 * 18)
> > Hence I went ahead with 4096 which is good enough for testing.
>
> If the test setup doesn't have a disk large enough, then the test
> should be skipped. That's what '_require_scratch_size' is for.
>
> i.e. _require_scratch_size $larger_than_ext4_fg_size
>
> Will do that check once we've calculated the size needed.

Sure.

>
> > But sure, I will add a comment explaining why we have hardcoded it to 4096
> > so that others don't get confused. Larger than this size disk anyway doesn't get
> > tested much right?
>
> You shouldn't be constricting the test based on assumptions about
> test configurations. If someone decides to test 64k block size, then
> they can size their devices appropriately for the configuration they
> want to test.  If a 64kB block size filesystem can overrun the
> on-disk structure and fail, then the test should exercise that and
> fail appropriately.

Sure Dave. Got the point. I will try and make the changes, such that
test doesn't assume any particular user test configuration. And be generic as
much as possible so that we could hit the issue we are aiming via this test.

-ritesh
