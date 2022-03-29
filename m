Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A3A4EAC5E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 13:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbiC2LeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 07:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235501AbiC2LeN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:34:13 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6FD249C7E;
        Tue, 29 Mar 2022 04:32:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g9-20020a17090ace8900b001c7cce3c0aeso1767428pju.2;
        Tue, 29 Mar 2022 04:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AfDbny6u/L+j/y3hE90n33pQkTnHbTDK6e2Yz12o79s=;
        b=WagXLbOYo9AF93N8+UD7WpOzf2QxK+6rH/yROSi2V7SLh2azETByEGKN0IxMQ2iJrh
         cCJn1HODiro4+Tm1PJuLyASh1NFh8399v3/9aP2bMM3ju2RgxPpmlKDKMvlud2bO/F6y
         qyJkBdMmUecVJ7mCcpQDqFJKjBmSP/lUymswu4dp48CFuv8PfY52Ggz3liZYB838Krlt
         AppgIlVhyrk4lBO9HsZTN+rFgv9mT6+gPKCkaIfZ6ttvWFsPdrpZb7b1Jr+ftimu1UIl
         kN3FPmmh3ZHuS9hUQS2/NMn36LL3/2of7bEZR8oqtEeFlQ193PPe1AQ+vVDvBdZqQ/uf
         yOnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AfDbny6u/L+j/y3hE90n33pQkTnHbTDK6e2Yz12o79s=;
        b=bhLthlY19ThfXUURF1L3PLfWT0zo3BVdwj3UKIBVSyw/UpgDWcmFVYFSJr9LsG/Euj
         ytebe4+Sii3wvlBbq79hU2pAywHE30BQSEFDmHHN3ftOxSB4I6cOa/Nrk2cQQXeBCzHq
         ogO7bbR5i7Weg5iPv2lysdDwl691X7PViorpYrLZcrZUhTRZcVTxE//3MnzTq03XNhP2
         TDpRu0XYHaXpb5i0L6d1BymN84xvHdOqRGPQCX8x74OaKOMn5A0f+bdonfFih+/UUcKX
         3bo36/fculy89zY+nEB6xmx/eBzHPZ5w79QuY1TCS3LOuh8GvSmr3A5mSqN3laQhohc8
         t/WQ==
X-Gm-Message-State: AOAM533FZj89vOZXpV81I1ufl7KiDSe4MgoctjWIuDGT//BPHi/CkXUl
        RJzLXuXL0et8cybwrbKjF/E=
X-Google-Smtp-Source: ABdhPJxq72U5sp7bd/9mEeEbu1RbKNwfMbSC726t7DQLsQNFsA3eqzUQG/6GuqnhT+6Wu4oe1LwH8A==
X-Received: by 2002:a17:902:a415:b0:153:a1b6:729f with SMTP id p21-20020a170902a41500b00153a1b6729fmr30167919plq.52.1648553550566;
        Tue, 29 Mar 2022 04:32:30 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id np8-20020a17090b4c4800b001c70aeab380sm2952943pjb.41.2022.03.29.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:32:30 -0700 (PDT)
Date:   Tue, 29 Mar 2022 17:02:27 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/4] generic/676: Add a new shutdown recovery test
Message-ID: <20220329113227.ig3cmfwzs7y6oywj@riteshh-domain>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <3d8c4f7374e97ccee285474efd04b093afe3ee16.1647342932.git.riteshh@linux.ibm.com>
 <20220315165514.GC8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315165514.GC8200@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/15 09:55AM, Darrick J. Wong wrote:
> On Tue, Mar 15, 2022 at 07:58:58PM +0530, Ritesh Harjani wrote:
> > In certain cases (it is noted with ext4 fast_commit feature) that, replay phase
> > may not delete the right range of blocks (after sudden FS shutdown)
> > due to some operations which depends on inode->i_size (which during replay of
> > an inode with fast_commit could be 0 for sometime).
> > This fstest is added to test for such scenarios for all generic fs.
> >
> > This test case is based on the test case shared via Xin Yin.
> >
> > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > ---
> >  tests/generic/676     | 72 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/676.out |  7 +++++
> >  2 files changed, 79 insertions(+)
> >  create mode 100755 tests/generic/676
> >  create mode 100644 tests/generic/676.out
> >
> > diff --git a/tests/generic/676 b/tests/generic/676
> > new file mode 100755
> > index 00000000..315edcdf
> > --- /dev/null
> > +++ b/tests/generic/676
> > @@ -0,0 +1,72 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test 676
> > +#
> > +# This test with ext4 fast_commit feature w/o below patch missed to delete the right
> > +# range during replay phase, since it depends upon inode->i_size (which might not be
> > +# stable during replay phase, at least for ext4).
> > +# 0b5b5a62b945a141: ext4: use ext4_ext_remove_space() for fast commit replay delete range
> > +# (Based on test case shared by Xin Yin <yinxin.x@bytedance.com>)
> > +#
> > +
> > +. ./common/preamble
> > +_begin_fstest auto shutdown quick log recoveryloop
>
> This isn't a looping recovery test.  Maybe we should create a 'recovery'
> group for tests that only run once?  I think we already have a few
> fstests like that.

I gave it a thought, but I feel it might be unncessary.
From a developer/tester perspective who wanted to test anything related to
recovery would then have to use both recovery and recoveryloop.
Thoughts?

>
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -r -f $tmp.*
> > +   _scratch_unmount > /dev/null 2>&1
>
> I think the test harness does this for you already, right?

Although, it looks like after running the test by default the run_section() in
check script, will do _test_unmount and _scratch_unmount.
But I still feel it's better if the individual test cleans up whatever it did
while running the test in it's cleanup routine, before exiting.

>
> > +}
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
> > +_require_xfs_io_command "fpunch"
> > +_require_xfs_io_command "fzero"
> > +_require_xfs_io_command "fiemap"
>
> _require_scratch_shutdown
>
> > +
> > +t1=$SCRATCH_MNT/foo
> > +t2=$SCRATCH_MNT/bar
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +
> > +_scratch_mount >> $seqres.full 2>&1
> > +
> > +bs=$(_get_block_size $SCRATCH_MNT)
>
> _get_file_block_size, in case the file allocation unit isn't the same as
> the fs blocksize?  (e.g. bigalloc, xfs realtime, etc.)

Sure. Agreed. Will make the change.

Thanks
-ritesh
