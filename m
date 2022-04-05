Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824A94F4304
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Apr 2022 23:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiDENej (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 09:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379606AbiDELlV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:41:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF191A83D;
        Tue,  5 Apr 2022 03:58:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gt4so5626026pjb.4;
        Tue, 05 Apr 2022 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R8IULujGKfKonsOqt0l6F1QhjeImLnG30rhujYuW3bA=;
        b=JaOt6y5gH6eFofXE/DLVCOiKvPdjp8faWjgNtczB9r48Kjn194WtQRovOZP/oJPoVf
         vC4PuSbhSdck2yAD9rhULsiU7k+sru4W04HvZgi5zkoBaxNUdvSbs2vgT4PH7h+72Rwl
         1yV9oya2pt8Ze41EeGpDxAbaVvj+E1ZSAHgmUPef4DAub/cfs/mT+DD5OsF+sNLzVTFd
         Swdtpl41DiMoLbx1P9e6zM331hpv+fbDnZYZnsmIbIJXlFOQywRUlTO/tq3I7Y0+kN+A
         SiZ2QjPfYqQysIZY1fKI1qB1kDvZH1tDd4J8xsuG262FRuj6Ie8Khmv6jhrPEoAny9N4
         4fMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R8IULujGKfKonsOqt0l6F1QhjeImLnG30rhujYuW3bA=;
        b=4Keuv+ikYQ/RCUSzH4Ub0AuEkLm68fDK7R6JmEiwXjXAoXIOknNwIqQwSq044jNuFm
         /RYq64uz6ietWbJ59WYNILm2Du69j0EHn6dyqYDzo1femRnF8VMU4dMSbiPdPl89i4GS
         IDA+npm9UPBQIiI/iHUWn3v4poycP12VkcjOqMDIHdNx1FP4ccreLJXorA7xbRBMUkbx
         L/UhtDpsYHLZfPAComIuQ0jlbP+ulOdEWaeXk6AHq/aRUAcXnEFoXJUqYwcDSg7CFqhf
         ew5E6wNTqEpv81jmkQZvBQGkDTWxfDPkmBPrvyFzzb7VB8VNKSTxtdI8c1TTDHyOSAJ+
         sD3A==
X-Gm-Message-State: AOAM533ZJ3D+UlafzkeCi/1eQt6oFBN+0MPmVOHF0ZZcUF13k0G99GY8
        aj5lY8n1NB0vmmb3LxUpt58=
X-Google-Smtp-Source: ABdhPJwUvvG5uO/xlsdhsV12TGIpBG35lyEqyNd1MLLvtmBpoHxLbWEG8wNysezLGf9DSVGrooWCaQ==
X-Received: by 2002:a17:903:213:b0:156:7efe:4783 with SMTP id r19-20020a170903021300b001567efe4783mr2811890plh.126.1649156281127;
        Tue, 05 Apr 2022 03:58:01 -0700 (PDT)
Received: from localhost ([2406:7400:63:792d:bde9:ddd5:53e9:ed83])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a000b8600b004faa49add69sm15328321pfj.107.2022.04.05.03.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 03:58:00 -0700 (PDT)
Date:   Tue, 5 Apr 2022 16:27:56 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Dave Chinner <david@fromorbit.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 3/4] generic/678: Add a new shutdown recovery test
Message-ID: <20220405105756.t3knmfhefrtdaisg@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <2df6ee0680b5d2a6fad945e4936749f22abe72dd.1648730443.git.ritesh.list@gmail.com>
 <20220403233845.GT1609613@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220403233845.GT1609613@dread.disaster.area>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/04/04 09:38AM, Dave Chinner wrote:
> On Thu, Mar 31, 2022 at 06:24:22PM +0530, Ritesh Harjani wrote:
> > From: Ritesh Harjani <riteshh@linux.ibm.com>
> >
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
> >  tests/generic/678     | 72 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/678.out |  7 +++++
> >  2 files changed, 79 insertions(+)
> >  create mode 100755 tests/generic/678
> >  create mode 100644 tests/generic/678.out
> >
> > diff --git a/tests/generic/678 b/tests/generic/678
> > new file mode 100755
> > index 00000000..46a7be6c
> > --- /dev/null
> > +++ b/tests/generic/678
> > @@ -0,0 +1,72 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test 678
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
> > +
> > +# Override the default cleanup function.
> > +_cleanup()
> > +{
> > +	cd /
> > +	rm -r -f $tmp.*
> > +}
>
> It's the same as the default cleanup function.
>

Sure, will remove this definition from here in next revision.
Since it is available in common/preamble now.

-ritesh

> Cheers,
>
> Dave.
>
> --
> Dave Chinner
> david@fromorbit.com
