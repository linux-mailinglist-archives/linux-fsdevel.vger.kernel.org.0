Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197BB4F42E2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 23:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbiDEN0M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 09:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379544AbiDELlQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:41:16 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C581A393;
        Tue,  5 Apr 2022 03:56:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id p17so10565307plo.9;
        Tue, 05 Apr 2022 03:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CL+rlW0biTGcQRMHFXRgRIiZX1fnXH3A57TaaOiS5iI=;
        b=f+MOtNqsZYHhQEI/ixNsW/LpZsv10Ao8YHcSUwq4UTfBcns2KVa3dzlrUIWPSmD3QR
         X76YALvaGtpMIheiK64LgIL/14oFaaCcTqVSuzt3C7/bdwbgZ5MdYKSOvWP+/whxq3DA
         /mWy1b25VPzQe2iASlXLT2ix1vUc7jnweNadgQf89WXEiZRkE+Gj48t+qdGV06Y8a52g
         Rl60Jn4Jw3RXBmN7f2fRp82K+QW3Q8UMlndLGWcScBUHiDx0oRWthwzwtWgIcYg64ZMu
         v7yaSLGQCuuafHmjAWNnoMmkLIm15JY9aeQOHy98b37hYuy2gci+by2dzP3AZ+9CS0S9
         VZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CL+rlW0biTGcQRMHFXRgRIiZX1fnXH3A57TaaOiS5iI=;
        b=gcn+pp5cWjEoC6Ht1yUy8RfGPqJxxUAgPxzguann/FdrpClyYCpTu4kH4q/Ov/6Yrb
         4QGUsNpJ6khO2omXpclL2AogMFuOLfDLOsLtIDdWa8PnJTYjX1hCn1rOwIGgBcwDFmhO
         y6c4eiTwBnAHSpguL6j00o+RNQOfyPaS1is6oV/VfrE+8/CITIOvK/+NnqKPmexYr0pN
         qgsHP/j3miULjn4i2PPCGwIH+c9qJAVVppjtYRuLrgBY8YEYCoM1FI6ZtD8uK7uOTkw0
         mWWaRWPqb3Bq9Rh/gsSMXwHn4RLEyRc2K3md5HHbRHAc7WZVDGnVYPJUzrf//3E+aa27
         d9Ww==
X-Gm-Message-State: AOAM532oyVMCwvSj8D74NJjIJZnr1bUEUN1IOZjNJixoBQ2Hi7DftdKX
        7+4fGaGIKRbJ2d+hmEr7V5CKMdQhBfU=
X-Google-Smtp-Source: ABdhPJzjuM4MJCB4f+Fpd/ScvvqsWePzNdt6A57DWFkSxVo6jh91MYFnZwZz49o3Rk7bAGpGCHys4w==
X-Received: by 2002:a17:902:f149:b0:156:87ad:4698 with SMTP id d9-20020a170902f14900b0015687ad4698mr2997661plb.5.1649156215372;
        Tue, 05 Apr 2022 03:56:55 -0700 (PDT)
Received: from localhost ([2406:7400:63:792d:bde9:ddd5:53e9:ed83])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm16057911pfu.197.2022.04.05.03.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:56:55 -0700 (PDT)
Date:   Tue, 5 Apr 2022 16:26:50 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 4/4] generic/679: Add a test to check unwritten extents
 tracking
Message-ID: <20220405105650.laibodfotwssnine@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <c9a40292799a83e52924b7b748701b3b0aa31c46.1648730443.git.ritesh.list@gmail.com>
 <20220403234318.GU1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403234318.GU1609613@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/04/04 09:43AM, Dave Chinner wrote:
> On Thu, Mar 31, 2022 at 06:24:23PM +0530, Ritesh Harjani wrote:
> > From: Ritesh Harjani <riteshh@linux.ibm.com>
> >
> > With these sequence of operation (in certain cases like with ext4 fast_commit)
> > could miss to track unwritten extents during replay phase
> > (after sudden FS shutdown).
> >
> > This fstest adds a test case to test this.
> >
> > 5e4d0eba1ccaf19f
> > ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  tests/generic/679     | 65 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/679.out |  6 ++++
> >  2 files changed, 71 insertions(+)
> >  create mode 100755 tests/generic/679
> >  create mode 100644 tests/generic/679.out
> >
> > diff --git a/tests/generic/679 b/tests/generic/679
> > new file mode 100755
> > index 00000000..4f35a9cd
> > --- /dev/null
> > +++ b/tests/generic/679
> > @@ -0,0 +1,65 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test 679
> > +#
> > +# Test below sequence of operation which (w/o below kernel patch) in case of
> > +# ext4 with fast_commit may misss to track unwritten extents.
> > +# commit 5e4d0eba1ccaf19f
> > +# ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto quick log shutdown recoveryloop
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -r -f $tmp.*
> > +}
>
> Same as default.

ohk. So the same _cleanup() function definition is available in common/preamble
now. So I guess, we can just remove this definition from here completely.

Got it. Thanks for pointing out.

>
> > +
> > +# Import common functions.
> > +. ./common/filter
> > +. ./common/punch
> > +
> > +# real QA test starts here
> > +
> > +# Modify as appropriate.
> > +_supported_fs generic
> > +_require_scratch
> > +_require_xfs_io_command "fzero"
> > +_require_xfs_io_command "fiemap"
> > +_require_scratch_shutdown
> > +
> > +t1=$SCRATCH_MNT/t1
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +
> > +_scratch_mount >> $seqres.full 2>&1
> > +
> > +bs=$(_get_file_block_size $SCRATCH_MNT)
> > +
> > +# create and write data to t1
> > +$XFS_IO_PROG -f -c "pwrite 0 $((100*$bs))" $t1 | _filter_xfs_io_numbers
> > +
> > +# fsync t1
> > +$XFS_IO_PROG -c "fsync" $t1
> > +
> > +# fzero certain range in between
> > +$XFS_IO_PROG -c "fzero -k  $((40*$bs)) $((20*$bs))" $t1
> > +
> > +# fsync t1
> > +$XFS_IO_PROG -c "fsync" $t1
> > +
> > +# shutdown FS now for replay of journal to kick during next mount
> > +_scratch_shutdown -v >> $seqres.full 2>&1
> > +
> > +_scratch_cycle_mount
> > +
> > +# check fiemap reported is valid or not
> > +$XFS_IO_PROG -c "fiemap -v" $t1 | _filter_fiemap_flags $bs
> > +
> > +# success, all done
> > +status=0
> > +exit
> > diff --git a/tests/generic/679.out b/tests/generic/679.out
> > new file mode 100644
> > index 00000000..4d3c3377
> > --- /dev/null
> > +++ b/tests/generic/679.out
> > @@ -0,0 +1,6 @@
> > +QA output created by 679
> > +wrote XXXX/XXXX bytes at offset XXXX
> > +XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> > +0: [0..39]: none
> > +1: [40..59]: unwritten
> > +2: [60..99]: nonelast
>
> This is a subset of the the previous test, and looks like it should
> be tested first before adding the second file and punch operation
> the previous test adds to this write/zero operations. IOWs, they
> look like they could easily be combined into a single test without
> losing anything except having an extra test that has to be run...

Sure, will look into combining the two in one common generic fstest.

Thanks for the review
-ritesh
