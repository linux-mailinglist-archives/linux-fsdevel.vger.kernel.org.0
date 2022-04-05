Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC44F4642
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 01:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345702AbiDENer (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 09:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380307AbiDELm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:42:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434B010856B;
        Tue,  5 Apr 2022 04:06:08 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id n6-20020a17090a670600b001caa71a9c4aso2283625pjj.1;
        Tue, 05 Apr 2022 04:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+wdwc12qZE95ySH1HQbeXjyc++REo1b0Qnn4+adVIU=;
        b=oyqGsBmX4L/1uWroip4K3nOnUsttJQZgmtBBEVFGABLA0uy540SVJnya8J+/ZQlD9v
         2psG8zgbaY0B/n6IZ+umEj0I++63NRbRO2W7c5G07Utd+0AeREqW0YoB1CtZRRKtdIwA
         8+3ZQiwGjXXw0Ox3pPmA89oE6JPeMuMPlMSM3RO68s1+NN761Pb2eISCgM8HFq8pZnoZ
         JP5/qMDP6eWVJ1d0ZkWjb1wl1j3Ut5RV+KT7BqDk9VTvkyeKIdFjZdlUV1tLZ207P7fe
         LHLmb6ZfequP++myGlAWLGaY6x0uXWow4ARM9xDCe3FeRwVlMCSLP0Cnt8AVISx5vAgx
         8CSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j+wdwc12qZE95ySH1HQbeXjyc++REo1b0Qnn4+adVIU=;
        b=XGo8jUjIacCdoH9PW5ZZdRigZE4LHaBvsL/N/iHhRbPjl3wo7zcLSaE5nlL2IxGrJk
         3vm0IVSuuueQ70jqlwqOi1COpDzwpdu7pyowh/llWa8k6A7Wh44Zj7DRuRmFx572DilT
         1/piVftky467DPeT/DBbzc9m1SgNumFlbvRa2UZgrv0ySQqxdf2Kur846113vBrIISXZ
         HrUHVDF4hIGnqgTPqop3hdxa4jn9xVYxKqu6V4IfWVwX22+C/r84IuWoanmcSTOMp717
         B8Ejm2mLbbgBpBWk7aj8QGpVBCbR90YxtLt34SQ0vybdlSZn1UOE4PMj56L7qWTQnPav
         MhAw==
X-Gm-Message-State: AOAM5339/H2qR7gCSGo6gVFIuvyXmTYWleW8pF2ZwUnZK7RxPQ+OXnVj
        wlHANaKhu508QEkkW+drr+g=
X-Google-Smtp-Source: ABdhPJwk0WLNGCgMfjAwxXQM/T9tlq11D27bsR0ixlddFb/2PsrH4Bo2ARZ0+4WnC1xPSuP1iE/JnQ==
X-Received: by 2002:a17:90b:4a88:b0:1c7:9bc:a72e with SMTP id lp8-20020a17090b4a8800b001c709bca72emr3375196pjb.112.1649156767474;
        Tue, 05 Apr 2022 04:06:07 -0700 (PDT)
Received: from localhost ([2406:7400:63:792d:bde9:ddd5:53e9:ed83])
        by smtp.gmail.com with ESMTPSA id bt18-20020a056a00439200b004faad3ae59esm15040322pfb.95.2022.04.05.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 04:06:07 -0700 (PDT)
Date:   Tue, 5 Apr 2022 16:36:03 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 1/4] generic/468: Add another falloc test entry
Message-ID: <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
 <20220403232823.GS1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403232823.GS1609613@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/04/04 09:28AM, Dave Chinner wrote:
> On Thu, Mar 31, 2022 at 06:24:20PM +0530, Ritesh Harjani wrote:
> > From: Ritesh Harjani <riteshh@linux.ibm.com>
> >
> > Add another falloc test entry which could hit a kernel bug
> > with ext4 fast_commit feature w/o below kernel commit [1].
> >
> > <log>
> > [  410.888496][ T2743] BUG: KASAN: use-after-free in ext4_mb_mark_bb+0x26a/0x6c0
> > [  410.890432][ T2743] Read of size 8 at addr ffff888171886000 by task mount/2743
> >
> > This happens when falloc -k size is huge which spans across more than
> > 1 flex block group in ext4. This causes a bug in fast_commit replay
> > code which is fixed by kernel commit at [1].
> >
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=bfdc502a4a4c058bf4cbb1df0c297761d528f54d
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  tests/generic/468     | 8 ++++++++
> >  tests/generic/468.out | 2 ++
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/tests/generic/468 b/tests/generic/468
> > index 95752d3b..5e73cff9 100755
> > --- a/tests/generic/468
> > +++ b/tests/generic/468
> > @@ -34,6 +34,13 @@ _scratch_mkfs >/dev/null 2>&1
> >  _require_metadata_journaling $SCRATCH_DEV
> >  _scratch_mount
> >
> > +# blocksize and fact are used in the last case of the fsync/fdatasync test.
> > +# This is mainly trying to test recovery operation in case where the data
> > +# blocks written, exceeds the default flex group size (32768*4096*16) in ext4.
> > +blocks=32768
> > +blocksize=4096
>
> Block size can change based on mkfs parameters. You should extract
> this dynamically from the filesystem the test is being run on.
>

Yes, but we still have kept just 4096 because, anything bigger than that like
65536 might require a bigger disk size itself to test. The overall size
requirement of the disk will then become ~36G (32768 * 65536 * 18)
Hence I went ahead with 4096 which is good enough for testing.

But sure, I will add a comment explaining why we have hardcoded it to 4096
so that others don't get confused. Larger than this size disk anyway doesn't get
tested much right?


> > +fact=18
>
> What is "fact" supposed to mean?
>
> Indeed, wouldn't this simply be better as something like:
>
> larger_than_ext4_fg_size=$((32768 * $blksize * 18))
>
> And then
>
> >  testfile=$SCRATCH_MNT/testfile
> >
> >  # check inode metadata after shutdown
> > @@ -85,6 +92,7 @@ for i in fsync fdatasync; do
> >  	test_falloc $i "-k " 1024
> >  	test_falloc $i "-k " 4096
> >  	test_falloc $i "-k " 104857600
> > +	test_falloc $i "-k " $(($blocks*$blocksize*$fact))
>
> 	test_falloc $i "-k " $larger_than_ext4_fg_size
>

Yes, looks good to me. Thanks for suggestion.


> And just scrub all the sizes from the golden output?
>

This won't be needed since I still would like to go with 4096 blocksize,
to avoid a large disk size requirement which anyway won't be tested much.

If this sounds good to you, I will fix rest of the changes as discussed in
the next revision.

-ritesh
