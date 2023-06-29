Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04532741D6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 03:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjF2BAo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 21:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjF2BAm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 21:00:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC99D2132
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 18:00:40 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b801e6ce85so832225ad.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 18:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1688000440; x=1690592440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YFSh4UQMxigzwwvL8diZTzDsQNOBblrcP22N90L84Vs=;
        b=kCcBmQYr8egVuJFSES59uunr/I5DWWW/oVY38mczGq9tVtawHM54hG6vXq0XMkcXvw
         Walcv4qUS5C/tNKmiS0r2O02x49/+QmbVMQZm5lmGrJS6+S8fr3vDTCceDeigPa4wze7
         wNMdtjOvk6TNdR5NGk95jN8A19ZSo6zHnyLY7VSOBE8Q3fdqQwr+DZ3IZfKncZ87eNKR
         8fVvodAsY9k+EaQ823GLrU4al1j6bu8T9+NVSHRAaMjRngyvx/6bqNYOQroUGh2F0QWc
         LMvARJ/xA5WAVQYxU624wwuV3w8GYPQ2TUiiCmyK/f3fVn/u9ZEPXXvdgC6CjYDf6H8Q
         gerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688000440; x=1690592440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFSh4UQMxigzwwvL8diZTzDsQNOBblrcP22N90L84Vs=;
        b=IGQQRBZsEoaQt2NHWMKTZAt+w7jneQwTLHluWrUCs4woAccQahNeLRdqs6rhcz0+TM
         t3NJKtgl0/M7wG+/pd8QOG+1WpHw3msRvpHsOX+y67Tmdhx7F1e5hXgfApoIz7ff/Pij
         R2W9iTBto4UGk1vVm9PYG392Yn1t6uwU4kir+u/ckbL+y/NFsjbKPf0s1w5v9kdOjPes
         7jkOETD5uLUCnr06MZHeIyUWmGRYq0ejvpobqU0xvW6EaBB2VwRhc0+esU7IS9cW+p+O
         70D1hox8ScaVczwPajzwuhq+t/T9omxTdNuepStp8KONivPDyIuCgpH+DBsQiBS3X1f4
         w5PQ==
X-Gm-Message-State: AC+VfDxE0Pg+EcwPaIxTeG/o6gn2cCK/SvvcAo3c5aTpZpKAid97c3Nm
        bUYLTgXWdokIensXb5BViz/kCQ==
X-Google-Smtp-Source: ACHHUZ7qSZvmo9NUERFxGeAPqZFDi+YuhlJdqnu8fHjovL+tHuyu4rUYhLvJ904+Q1hbaS+67nP7ag==
X-Received: by 2002:a17:902:e551:b0:1b8:3936:7b64 with SMTP id n17-20020a170902e55100b001b839367b64mr4104977plf.1.1688000439787;
        Wed, 28 Jun 2023 18:00:39 -0700 (PDT)
Received: from dread.disaster.area (pa49-186-94-37.pa.vic.optusnet.com.au. [49.186.94.37])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709028c8700b001b03842ab78sm8224744plo.89.2023.06.28.18.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 18:00:38 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qEg1T-00HR8i-1z;
        Thu, 29 Jun 2023 11:00:35 +1000
Date:   Thu, 29 Jun 2023 11:00:35 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Jens Axboe <axboe@kernel.dk>, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZJzXs6C8G2SL10vq@dread.disaster.area>
References: <b02657af-5bbb-b46b-cea0-ee89f385f3c1@kernel.dk>
 <4b863e62-4406-53e4-f96a-f4d1daf098ab@kernel.dk>
 <20230628175204.oeek4nnqx7ltlqmg@moria.home.lan>
 <e1570c46-68da-22b7-5322-f34f3c2958d9@kernel.dk>
 <2e635579-37ba-ddfc-a2ab-e6c080ab4971@kernel.dk>
 <20230628221342.4j3gr3zscnsu366p@moria.home.lan>
 <d697ec27-8008-2eb6-0950-f612a602dcf5@kernel.dk>
 <20230628225514.n3xtlgmjkgapgnrd@moria.home.lan>
 <1e2134f1-f48b-1459-a38e-eac9597cd64a@kernel.dk>
 <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628235018.ttvtzpfe42fri4yq@moria.home.lan>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 28, 2023 at 07:50:18PM -0400, Kent Overstreet wrote:
> On Wed, Jun 28, 2023 at 05:14:09PM -0600, Jens Axboe wrote:
> > On 6/28/23 4:55?PM, Kent Overstreet wrote:
> > >> But it's not aio (or io_uring or whatever), it's simply the fact that
> > >> doing an fput() from an exiting task (for example) will end up being
> > >> done async. And hence waiting for task exits is NOT enough to ensure
> > >> that all file references have been released.
> > >>
> > >> Since there are a variety of other reasons why a mount may be pinned and
> > >> fail to umount, perhaps it's worth considering that changing this
> > >> behavior won't buy us that much. Especially since it's been around for
> > >> more than 10 years:
> > > 
> > > Because it seems that before io_uring the race was quite a bit harder to
> > > hit - I only started seeing it when things started switching over to
> > > io_uring. generic/388 used to pass reliably for me (pre backpointers),
> > > now it doesn't.
> > 
> > I literally just pasted a script that hits it in one second with aio. So
> > maybe generic/388 doesn't hit it as easily, but it's surely TRIVIAL to
> > hit with aio. As demonstrated. The io_uring is not hard to bring into
> > parity on that front, here's one I posted earlier today for 6.5:
> > 
> > https://lore.kernel.org/io-uring/20230628170953.952923-4-axboe@kernel.dk/
> > 
> > Doesn't change the fact that you can easily hit this with io_uring or
> > aio, and probably more things too (didn't look any further). Is it a
> > realistic thing outside of funky tests? Probably not really, or at least
> > if those guys hit it they'd probably have the work-around hack in place
> > in their script already.
> > 
> > But the fact is that it's been around for a decade. It's somehow a lot
> > easier to hit with bcachefs than XFS, which may just be because the
> > former has a bunch of workers and this may be deferring the delayed fput
> > work more. Just hand waving.
> 
> Not sure what you're arguing here...?
> 
> We've had a long standing bug, it's recently become much easier to hit
> (for multiple reasons); we seem to be in agreement on all that. All I'm
> saying is that the existence of that bug previously is not reason to fix
> it now.

I agree with Kent here  - the kernel bug needs to be fixed
regardless of how long it has been around. Blaming the messenger
(userspace, fstests, etc) and saying it should work around a
spurious, unpredictable, undesirable and user-undebuggable kernel
behaviour is not an acceptible solution here...

I don't care how the kernel bug gets fixed, I just want the spurious
unmount failures when there are no userspace processes actively
using the filesytsem to go away forever.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
