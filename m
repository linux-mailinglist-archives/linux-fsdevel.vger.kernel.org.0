Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52D64EAC62
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 13:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiC2LgC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 07:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbiC2LgB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:36:01 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014B27CED;
        Tue, 29 Mar 2022 04:34:14 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so1754691pjb.3;
        Tue, 29 Mar 2022 04:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xJxDL1SNTaKnpVlTXGlfkqsJg1j05V/c8caKh7MyTzc=;
        b=erLq8z3hz7HGoGBev359f2q+e7U2gr6L+kklmARvKRjQheIINCWiRuhZKkpYNps42n
         9SjECMP0G46mJnNRt0sLYxpUbtJnYzde8fKpKacmVeFCYNvZ7vfL/odEf9gkxEyKhwDF
         /6Qvle4mQ5Op1/kgkydkvfwxJCU29mvqAuUYf3oDI8Q40rBxqQ4OBHyyIQ4e00imXIDY
         jdZbIID6ftYlr82O8sRL7UnuxlCpDoolsvgYg6pFmcZ+WosLSuVwrVFs2LfSgcCd8lRL
         kfuMaE/t4wwSajfHNheZz63pfv0Xc45VAR4y6y3GDczV2DiQ0mKJtt3c39lNXlEGuaug
         bg4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xJxDL1SNTaKnpVlTXGlfkqsJg1j05V/c8caKh7MyTzc=;
        b=OsK0l1/gmTF7iDo64S7BdSVVTrqMaivuSEpq5k/s/V2KAH/BkDTzzMnrarJ5HCvXqh
         i2Dv9a9GA0/A0jp+88UDczC7SP3qKb7bbS6rbrkSO9RlmmiJI0n/jHcujqyVQOtRj/Cc
         0WZRoQfmvnocH76AOHDKkwnwBTFzg8TXiyuXrJ8MuyUZMNbN1ZmT/Jd2ThDeUTCXf8er
         xn6Op1KOuDpxl2tZgZ2aEaf7mvcwedaeA+muxPfvDx6xKrCkY7zXzY6kICsdc+mJpQro
         hZu9jhLUwCivUVCNqUT6vgLbzIQrS7lF9+c/GNkAwH0/KaX8TK0BliGZvUWyjs1SeQbi
         +/1w==
X-Gm-Message-State: AOAM533/0RXaFsCSZnnPOvo5WDKITdh40tVdybDp9+sLBXomlolU1d1z
        VGC+sVWbYSnUvhlO4xGMCII=
X-Google-Smtp-Source: ABdhPJx2J2LYEPEANmokpjnwVxL0LJByJY/4p/IcAzKhusLMbMW468vj/8WLD4vwS8kuj13BKPpodw==
X-Received: by 2002:a17:90a:9f0b:b0:1c6:a876:4157 with SMTP id n11-20020a17090a9f0b00b001c6a8764157mr4058159pjp.173.1648553654183;
        Tue, 29 Mar 2022 04:34:14 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id p13-20020a056a000b4d00b004faecee6e89sm18987908pfo.208.2022.03.29.04.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 04:34:13 -0700 (PDT)
Date:   Tue, 29 Mar 2022 17:04:11 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 4/4] generic/677: Add a test to check unwritten extents
 tracking
Message-ID: <20220329113411.ov6efsdyvbfa4xul@riteshh-domain>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <37d65f1026f2fc1f2d13ab54980de93f4fa34c46.1647342932.git.riteshh@linux.ibm.com>
 <20220315165607.GD8200@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315165607.GD8200@magnolia>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/15 09:56AM, Darrick J. Wong wrote:
> On Tue, Mar 15, 2022 at 07:58:59PM +0530, Ritesh Harjani wrote:
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
> >  tests/generic/677     | 64 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/677.out |  6 ++++
> >  2 files changed, 70 insertions(+)
> >  create mode 100755 tests/generic/677
> >  create mode 100644 tests/generic/677.out
> >
> > diff --git a/tests/generic/677 b/tests/generic/677
> > new file mode 100755
> > index 00000000..e316763a
> > --- /dev/null
> > +++ b/tests/generic/677
> > @@ -0,0 +1,64 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test 677
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
> > +
> > +t1=$SCRATCH_MNT/t1
> > +
> > +_scratch_mkfs > $seqres.full 2>&1
> > +
> > +_scratch_mount >> $seqres.full 2>&1
> > +
> > +bs=$(_get_block_size $SCRATCH_MNT)
>
> Same comments about blocksize, group names, and
> _require_scratch_shutdown as the last patch.

Sure, I will fix blocksize and _require_scratch_shutdown part.
I have added my thoughts above group names in previous patch.

Thanks for reviewing this.

-ritesh
