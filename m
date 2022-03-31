Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEFC4ED746
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 11:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiCaJva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 31 Mar 2022 05:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234292AbiCaJv3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:51:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB02200370;
        Thu, 31 Mar 2022 02:49:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cm17so3569378pjb.2;
        Thu, 31 Mar 2022 02:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hOW8z8DeUWQcKkytwxGZaY19zSaaGqWYqnEYzq0375k=;
        b=FiTRgfd09+EKB/9xeLe2RuTU8NrMVLm5dJeDr8BpiqpI8cWTMOJwndq8rDwpt/BiFP
         1xrX8gCARGKZK1Dd+DXA+qddw0OAqY68xsudL85mrYIz1T0wA3c1l9bONZqpymtgQcXU
         3lc0/FxzE1Utd1TCSqxx+yYlYNh0ha4P3KJrwKpdWuaEV5TPxtT8dW7A7QLQb5ThuUxz
         dzvozYUc4ysZtP1TWoWaH0o7V3M/ubf8N8SMPUk3Cfz5Wx+woi9VXvh7oGqwlaskFQG4
         zOpibnPw9zWH+V5v7j3AciMsYgJ+5Rbp3mHmKd13J5XgYK0YY2y2lRnVX4BMz6wV+ga+
         Xgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hOW8z8DeUWQcKkytwxGZaY19zSaaGqWYqnEYzq0375k=;
        b=u4et6tg80BwvrdBAiXbBwomZh3TFWoEJIc/700guKQ4T/582YXHYo+OcEDc14d2H8g
         Tdvsz49+O56UBwTBImy/DRPkP38Bqhh3ULui8LwjvjV+2nqgE2KuM0NpamcktpLBJO+A
         81wbYmj287Jm28OKVWYOpeDGAtfIJatFvphMCZ89ladjn+nnP7kw+QYOr/RonVUsAgJB
         R7bU6swn1lkyC1tXZzGUqTFRMCerAsJExGtDL0i4gbcas8dsLlIo3LlyoifrXONHxq3U
         mdyoIFvx5fPuYs0rxI7/vrJlZxoticK7xY29/Q/oOlH3U97hPoZbY5Gf7uuf/n1Qidct
         qnwg==
X-Gm-Message-State: AOAM532YFZfCC3+KL4oPg1fk+Rkq0N7kEVRv2PPV1Ymu3n8/sLsSAyJE
        0aEE5JGES3Lfr5BM0RA3pHw=
X-Google-Smtp-Source: ABdhPJy/r0hXSVvcWFxyAwE9S945j4x7CaM2K3Ihok3GWKo2XIlI1/U/7Cu6072LoEKaSSh24sVz0A==
X-Received: by 2002:a17:903:40c4:b0:154:c9ef:609f with SMTP id t4-20020a17090340c400b00154c9ef609fmr4282063pld.30.1648720182164;
        Thu, 31 Mar 2022 02:49:42 -0700 (PDT)
Received: from localhost ([122.179.46.149])
        by smtp.gmail.com with ESMTPSA id bh3-20020a056a02020300b00378b62df320sm21532510pgb.73.2022.03.31.02.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 02:49:41 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:19:38 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 3/4] generic/676: Add a new shutdown recovery test
Message-ID: <20220331094938.vcvrehdm2azoiy75@riteshh-domain>
References: <cover.1647342932.git.riteshh@linux.ibm.com>
 <3d8c4f7374e97ccee285474efd04b093afe3ee16.1647342932.git.riteshh@linux.ibm.com>
 <20220315165514.GC8200@magnolia>
 <20220329113227.ig3cmfwzs7y6oywj@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329113227.ig3cmfwzs7y6oywj@riteshh-domain>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/03/29 05:02PM, Ritesh Harjani wrote:
> On 22/03/15 09:55AM, Darrick J. Wong wrote:
> > On Tue, Mar 15, 2022 at 07:58:58PM +0530, Ritesh Harjani wrote:
> > > In certain cases (it is noted with ext4 fast_commit feature) that, replay phase
> > > may not delete the right range of blocks (after sudden FS shutdown)
> > > due to some operations which depends on inode->i_size (which during replay of
> > > an inode with fast_commit could be 0 for sometime).
> > > This fstest is added to test for such scenarios for all generic fs.
> > >
> > > This test case is based on the test case shared via Xin Yin.
> > >
> > > Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> > > ---
> > >  tests/generic/676     | 72 +++++++++++++++++++++++++++++++++++++++++++
> > >  tests/generic/676.out |  7 +++++
> > >  2 files changed, 79 insertions(+)
> > >  create mode 100755 tests/generic/676
> > >  create mode 100644 tests/generic/676.out
> > >
> > > diff --git a/tests/generic/676 b/tests/generic/676
> > > new file mode 100755
> > > index 00000000..315edcdf
> > > --- /dev/null
> > > +++ b/tests/generic/676
> > > @@ -0,0 +1,72 @@
> > > +#! /bin/bash
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +# Copyright (c) 2022 IBM Corporation.  All Rights Reserved.
> > > +#
> > > +# FS QA Test 676
> > > +#
> > > +# This test with ext4 fast_commit feature w/o below patch missed to delete the right
> > > +# range during replay phase, since it depends upon inode->i_size (which might not be
> > > +# stable during replay phase, at least for ext4).
> > > +# 0b5b5a62b945a141: ext4: use ext4_ext_remove_space() for fast commit replay delete range
> > > +# (Based on test case shared by Xin Yin <yinxin.x@bytedance.com>)
> > > +#
> > > +
> > > +. ./common/preamble
> > > +_begin_fstest auto shutdown quick log recoveryloop
> >
> > This isn't a looping recovery test.  Maybe we should create a 'recovery'
> > group for tests that only run once?  I think we already have a few
> > fstests like that.
>
> I gave it a thought, but I feel it might be unncessary.
> From a developer/tester perspective who wanted to test anything related to
> recovery would then have to use both recovery and recoveryloop.
> Thoughts?
>
> >
> > > +
> > > +# Override the default cleanup function.
> > > +_cleanup()
> > > +{
> > > +	cd /
> > > +	rm -r -f $tmp.*
> > > +   _scratch_unmount > /dev/null 2>&1
> >
> > I think the test harness does this for you already, right?

Ok, I agree with this. I will remove _scratch_unmount operation
from these two new tests in v3.

-ritesh
