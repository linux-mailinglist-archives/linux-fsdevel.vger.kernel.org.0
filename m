Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EB44EABCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 12:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiC2LBa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 07:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbiC2LB3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:01:29 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AA897B94;
        Tue, 29 Mar 2022 03:59:47 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s8so15533828pfk.12;
        Tue, 29 Mar 2022 03:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6qDEoEKf+ZyaX+KW7HvVeEYYlr0OPYjM/YI0YjVcM/Q=;
        b=lGDfN3u/HPZEVWev8tbpoPRKobIp1gADw4i2FplJeo2NxunoMtZHQPkLcgE3eL+Suh
         rA8QUY74iSzkcdewhMuIKsLjQqwrqhwu+5ODFY4ZT962kNb6YDkuNclrGJS0QuX0PAS/
         n0qrcGIzFdcUQ74X2PNh2pUloR8S/ljtKjtKoDQwtcNj06AN1uGyR2ldZOSCIaeSUcVK
         w8mH1fMqmMhVEYTBNGN8StBRW8dDsl0UldS0VWb+B8QH3rd6SBm4W7nJJmjad5rW/V4G
         mnSlJiEHh7+HQyDRmdtyXFCZemFXU4O7vg4uP11UmckCJ0kCTtEPkKeGNKPoW537FqqZ
         duvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6qDEoEKf+ZyaX+KW7HvVeEYYlr0OPYjM/YI0YjVcM/Q=;
        b=AiWRfWXDXn4jwil+7rzAzdH8MMPt9puitnTbmqK+4MbAh4dhDg9NkZDGvj9wfQc4X4
         7TlQpLNYCwxJ8aDOKnwgvlyJ3eRN7H3UjVJDSpUYbmLgpTmpNmTcnkHc3A9TWy41Qh4g
         njHESPLzViUF3v71UNXv1tOmoyV+f6KqH52CtUp1ZAWevM36BtJUk0eg90Dq/h2VFhYo
         bzFKllYvra/Wf4XqlGAD1DqxgxQ8mq+ICFblvAxX3t+0QqA3096NiqwsONN/uhfbmmtb
         bQvfjyGIDXRtGgNr04hTo84YMx7BRvOtsMALg6EoUciLmyTBfa0FBnkFCtOaJGkZgEyh
         A2uA==
X-Gm-Message-State: AOAM533mSsO3iR6IkgXv97S6FwomzRkLH4e1EEpuw2iU6Kj1U4n83hzf
        tEUW6LEgt8gvuHS1D8hXBzQ=
X-Google-Smtp-Source: ABdhPJwL9nOOkOwW8719VgHeQkdOtBcqARQzPMOBznvpH1cgsIi0UYANcSFk1r77Da9jwZONr+sLvw==
X-Received: by 2002:a65:6a8e:0:b0:378:b62d:f397 with SMTP id q14-20020a656a8e000000b00378b62df397mr1642389pgu.239.1648551586397;
        Tue, 29 Mar 2022 03:59:46 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id u15-20020a056a00098f00b004faa58d44eesm20570438pfg.145.2022.03.29.03.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 03:59:45 -0700 (PDT)
Date:   Tue, 29 Mar 2022 16:29:42 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 1/4] generic/468: Add another falloc test entry
Message-ID: <20220329105942.n4grhw2wsvfflu36@riteshh-domain>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <08bd90fa8c291a4ccba2e5d6182a8595b7e6d7ab.1647342932.git.riteshh@linux.ibm.com>
 <20220315165143.GB8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315165143.GB8200@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

First of all thanks Darrick for the review.
And sorry about such a long delay in getting back to this.

On 22/03/15 09:51AM, Darrick J. Wong wrote:
> On Tue, Mar 15, 2022 at 07:58:56PM +0530, Ritesh Harjani wrote:
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
> >  tests/generic/468     | 4 ++++
> >  tests/generic/468.out | 2 ++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/tests/generic/468 b/tests/generic/468
> > index 95752d3b..cbef9746 100755
> > --- a/tests/generic/468
> > +++ b/tests/generic/468
> > @@ -34,6 +34,9 @@ _scratch_mkfs >/dev/null 2>&1
> >  _require_metadata_journaling $SCRATCH_DEV
> >  _scratch_mount
> >
> > +blocksize=4096
>
> What happens if the file blocksize isn't 4k?  Does fastcommit only
> support one block size?  I didn't think it has any such restriction?

It does support other block size too.
Now, for bs < 4096 it is still fine. Yes, it won't trigger for 64K bs.
But that is ok since anyway to trigger this issue with 64K, we will need a much
larger disk size that anyway folks doesn't run fstests with
$((32768*65536*18))


>
> > +fact=18
>
> This needs a bit more explanation -- why 18?  I think the reason is that
> you need the fallocate to cross into another flexbg, and flexbgs (by
> default) are 16bg long, right?

That is right. Sure, I will add a comment explaining this, in the next revision.

>
> If that's the case, then don't you need to detect the flexbg size so
> that this is still an effective test if someone runs fstests with
> MKFS_OPTIONS='-G 32' or something?

We can do that. But it is rare for anyone to test only with '-G 32' and not test
with a default option. 32 might still be ok, but anything bigger then that
might still require the test to not run due to requirement of disk size.

And plus I wanted to keep the test generic enough such that it covers the
regression test with default fast_commit mkfs option.

-ritesh

>
> --D
>
> > +
> >  testfile=$SCRATCH_MNT/testfile
> >
> >  # check inode metadata after shutdown
> > @@ -85,6 +88,7 @@ for i in fsync fdatasync; do
> >  	test_falloc $i "-k " 1024
> >  	test_falloc $i "-k " 4096
> >  	test_falloc $i "-k " 104857600
> > +	test_falloc $i "-k " $((32768*$blocksize*$fact))
> >  done
> >
> >  status=0
> > diff --git a/tests/generic/468.out b/tests/generic/468.out
> > index b3a28d5e..a09cedb8 100644
> > --- a/tests/generic/468.out
> > +++ b/tests/generic/468.out
> > @@ -5,9 +5,11 @@ QA output created by 468
> >  ==== falloc -k 1024 test with fsync ====
> >  ==== falloc -k 4096 test with fsync ====
> >  ==== falloc -k 104857600 test with fsync ====
> > +==== falloc -k 2415919104 test with fsync ====
> >  ==== falloc 1024 test with fdatasync ====
> >  ==== falloc 4096 test with fdatasync ====
> >  ==== falloc 104857600 test with fdatasync ====
> >  ==== falloc -k 1024 test with fdatasync ====
> >  ==== falloc -k 4096 test with fdatasync ====
> >  ==== falloc -k 104857600 test with fdatasync ====
> > +==== falloc -k 2415919104 test with fdatasync ====
> > --
> > 2.31.1
> >
