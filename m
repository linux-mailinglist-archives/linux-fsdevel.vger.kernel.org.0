Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9A24F6284
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 17:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbiDFPFc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 11:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiDFPFT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 11:05:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EC92BC556;
        Wed,  6 Apr 2022 04:56:23 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u14so2369033pjj.0;
        Wed, 06 Apr 2022 04:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Mhb5v8ZlAjtIYtRSgbIBYSL5zw8//91EorDOso/oqKM=;
        b=T1igHYq49tyKF1mXnppF0r/g/mOyOn99siFKBxiOHNL9xBP0seeNlEC9YbSNKMtjXo
         nCAWoGmbKX7ZxkOGQVznvzpB3s4vHZ0mUYKArLQkbvaNKJe/u0lRXGMRqYmnKOLM0aNk
         aEPoFyK6TXTcm+ss2ggLqSkdAnRTw8U2nxUFNx7EfecHOUFPd6zsAKzolpTgN5oNjBoq
         tgk8ILd4FwJqe7PajwDnZH74VS6AoLaiXD19/kuqExzGgniT0G+PB/0/Tz87hYmLxoCp
         fXEjGlwNbxVl1o7uAcvfyk8ehK98rF0GOSgeZRbKme3SpV1Dp9x4R5UsDp0WVBwdnhTG
         b6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Mhb5v8ZlAjtIYtRSgbIBYSL5zw8//91EorDOso/oqKM=;
        b=SO5O+WKGmYeko0limcSxTeDVc+fBK987U7miiUh6iapyrQPxS+Zy8GrAL/6s2M4bgy
         JT3Med2Mrskn87EHxZwq865bQOgvOSV96jBmvLHB9XSXWRBqnBC19bbtKrlMFlb0wbk4
         Fncs/O4yD2QG4X78dNTF8Qw0Kp9vsTWUikF24d3nk0ELpt2XYjjH7Ypj6ClhC2gGQY+Z
         1Ph3RxFssX3BbTRMbwOVUtKL3pDRG4hsrRPN3Zy+GyGHiybbETQkujL3lbHCpxj3UrFs
         bgDfXuTQhMZDINJbha/egk+cgYk2iJ8WTSjfp696mkCHy+1m5mc0pt6t5kIzE5cvNgzV
         JtRQ==
X-Gm-Message-State: AOAM530ovTNZPPJfeKBpLIyGU993Vu2NeToKjFRahBF7onq9GXYfiUJG
        J8nJIyG/wyiO+j4xmrLORmU=
X-Google-Smtp-Source: ABdhPJyFqeI4muFCF/W8J1lCNU83TK67ifvbNjJFfcuyNQFjiLcMSWPyOmoXEpPv3EdFqDHCSxAAXQ==
X-Received: by 2002:a17:90a:3b47:b0:1ca:7075:124e with SMTP id t7-20020a17090a3b4700b001ca7075124emr9573106pjf.209.1649245971236;
        Wed, 06 Apr 2022 04:52:51 -0700 (PDT)
Received: from localhost ([2406:7400:63:b4e6:5967:b872:39cd:bdb9])
        by smtp.gmail.com with ESMTPSA id c63-20020a624e42000000b004fa9ee41b7bsm18641751pfb.217.2022.04.06.04.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 04:52:50 -0700 (PDT)
Date:   Wed, 6 Apr 2022 17:22:46 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Dave Chinner <david@fromorbit.com>,
        fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCHv3 1/4] generic/468: Add another falloc test entry
Message-ID: <20220406115246.qzsexi24uvfu3mjp@riteshh-domain>
References: <cover.1648730443.git.ritesh.list@gmail.com>
 <75f4c780e8402a8f993cb987e85a31e4895f13de.1648730443.git.ritesh.list@gmail.com>
 <20220403232823.GS1609613@dread.disaster.area>
 <20220405110603.qqxyivpo4vzj5tlt@riteshh-domain>
 <Yky8DzTNiYovRbHb@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yky8DzTNiYovRbHb@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/04/05 06:00PM, Theodore Ts'o wrote:
> On Tue, Apr 05, 2022 at 04:36:03PM +0530, Ritesh Harjani wrote:
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
> What if the block size is *smaller*?  For example, I run an ext4/1k
> configuration (which is how I test block size > page size on x86 VM's :-).

For 1k bs, this test can still reproduce the problem. Because the given size
will easily overflow the required number of blocks in 1K case.

>
> > But sure, I will add a comment explaining why we have hardcoded it to 4096
> > so that others don't get confused. Larger than this size disk anyway doesn't get
> > tested much right?
>
> At $WORK we use a 100GB disk by default when running xfstests, and I
> wouldn't be surprised if theree are other folks who might use larger
> disk sizes.

Ohk, sure. Thanks for the info.

>
> Maybe test to see whether the scratch disk is too small for the given
> parameters and if so skip the test using _notrun?
>

Yes, I think I got the point. I will make the changes accordingly.

-ritesh
