Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F6739DD2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 11:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjFVJzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 05:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjFVJzA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 05:55:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3A84236
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 02:51:28 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-66767d628e2so2923044b3a.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jun 2023 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687427487; x=1690019487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/R3CsCgyC5I5IFTAwGkIo+LTgke09vH4sxQ8OwfMMA=;
        b=lDW8Tmr7YvzYwUjPKXDIkMEibMm5wSGSfYsX93fB1BC6vEPhP+LcJmca6BnQWVWwaz
         axoD5PMkKfNQh6BQCJo8lAkMH3bJdGX0bf5+reGjft2knfQ2Z5V30c0VColb1xMf776h
         kXoNvUvrhbLLK6qsXo7kVuHAoeNwGOQO9VUL2eeZIEyO8W69W7ZzY76z2W5eqG7E9Jaj
         /YPwJ8t+mPfuDa2ZsaANNXui1vUlYhU7XDQr582wpGVa+X0YoBV3aCaa+MRul5kw/7TD
         USEEZy3tKINZEtUw/4hKvoW1OMW9xNDPTFpEZ9JvO2FT5F4P3cYwzuXI3mYYkh4N1+mI
         x9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687427487; x=1690019487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/R3CsCgyC5I5IFTAwGkIo+LTgke09vH4sxQ8OwfMMA=;
        b=aNr9+5e1m4mgtXLVFLjsR5K+UxRtIvkFiLjL47iKVJxnCAJT+HYEC7u7XIuaO6tS18
         dh/7XmxDyfgmddV0dVWwOSPYW192ACvO1r85BfBAj1GTgHQgN8EGkhNbgQOTbrDBZtX4
         vkfMMm5UH0MVcf1gvT0EVFnhUAWvVk+a9lWtYIdxV5l6Txcoy5URDe3IMOGTMxQo1VRj
         GQXgm0NP9/yeI/emqm+bMOUFIvGvPtVYQhIS/lrTdFVbebbrMZL6ZXdJaMFPaT5rpzNd
         MRVSBsLJeR01vuNPR39tGDz2hV7cX9r7PmprVQLsl/AcDumdjEfXDwvHlkapQ5GkBOZD
         Zpcg==
X-Gm-Message-State: AC+VfDwjwG3IPuF1+cZ3r8mZZjOi3yzM9hd74uqHskEFUu1uLVYMny0s
        gXP6hDcUe/oLGHq96prD60jyRQ==
X-Google-Smtp-Source: ACHHUZ6QW4bD2NsuF8Dbb2eiUlzJuhazbkcCQ1wnphTvXqm76A/VVle0TlCNY1IO9YJC0ldtCDxayQ==
X-Received: by 2002:a05:6a00:124f:b0:66a:4dd2:7b38 with SMTP id u15-20020a056a00124f00b0066a4dd27b38mr2992762pfi.0.1687427487510;
        Thu, 22 Jun 2023 02:51:27 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id m2-20020aa79002000000b0064d1d8fd24asm4222621pfo.60.2023.06.22.02.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 02:51:26 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qCGyJ-00Enhc-1G;
        Thu, 22 Jun 2023 19:51:23 +1000
Date:   Thu, 22 Jun 2023 19:51:23 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+510dcbdc6befa1e6b2f6@syzkaller.appspotmail.com>,
        djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] UBSAN: array-index-out-of-bounds in
 xfs_attr3_leaf_add_work
Message-ID: <ZJQZm+UGyJZZNTvN@dread.disaster.area>
References: <0000000000001c8edb05fe518644@google.com>
 <ZI+3QXDHiohgv/Pb@dread.disaster.area>
 <20230621080521.GB56560@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621080521.GB56560@sol.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 21, 2023 at 01:05:21AM -0700, Eric Biggers wrote:
> On Mon, Jun 19, 2023 at 12:02:41PM +1000, 'Dave Chinner' via syzkaller-bugs wrote:
> > > XFS (loop0): Mounting V4 Filesystem 5e6273b8-2167-42bb-911b-418aa14a1261
> > > XFS (loop0): Ending clean mount
> > > xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
> > > ================================================================================
> > > UBSAN: array-index-out-of-bounds in fs/xfs/libxfs/xfs_attr_leaf.c:1560:3
> > > index 14 is out of range for type '__u8 [1]'
> > > CPU: 1 PID: 5021 Comm: syz-executor198 Not tainted 6.4.0-rc6-next-20230613-syzkaller #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/25/2023
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:88 [inline]
> > >  dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
> > >  ubsan_epilogue lib/ubsan.c:217 [inline]
> > >  __ubsan_handle_out_of_bounds+0xd5/0x140 lib/ubsan.c:348
> > >  xfs_attr3_leaf_add_work+0x1528/0x1730 fs/xfs/libxfs/xfs_attr_leaf.c:1560
> > >  xfs_attr3_leaf_add+0x750/0x880 fs/xfs/libxfs/xfs_attr_leaf.c:1438
> > >  xfs_attr_leaf_try_add+0x1b7/0x660 fs/xfs/libxfs/xfs_attr.c:1242
> > >  xfs_attr_leaf_addname fs/xfs/libxfs/xfs_attr.c:444 [inline]
> > >  xfs_attr_set_iter+0x16c4/0x2f90 fs/xfs/libxfs/xfs_attr.c:721
> > >  xfs_xattri_finish_update+0x3c/0x140 fs/xfs/xfs_attr_item.c:332
> > 
> > The on disk format for this field is defined as:
> > 
> > typedef struct xfs_attr_leaf_name_local {
> >         __be16  valuelen;               /* number of bytes in value */
> >         __u8    namelen;                /* length of name bytes */
> >         __u8    nameval[1];             /* name/value bytes */
> > } xfs_attr_leaf_name_local_t
> > 
> > If someone wants to do change the on-disk format definition to use
> > "kernel proper" flex arrays in both the kernel code and user space,
> > update all the documentation and do all the validation work that
> > on-disk format changes require for all XFS disk structures that are
> > defined this way, then we'll fix this.
> > 
> > But as it stands, these structures have been defined this way for 25
> > years and the code accessing them has been around for just as long.
> > The code is not broken and it does not need fixing. We have way more
> > important things to be doing that fiddling with on disk format
> > definitions and long standing, working code just to shut up UBSAN
> > and/or syzbot.
> > 
> > WONTFIX, NOTABUG.
> 
> My understanding is that the main motivation for the conversions to flex arrays
> is kernel hardening, as it allows bounds checking to be enabled.

<sigh>

Do you think we don't know this?

We can't actually rely on the compiler checking here. We *must* to
do runtime verification of these on-disk format structures because
we are parsing dynamic structures, not fixed size arrays.  IOWs, we
already bounds check these arrays (in multiple ways!) before we do
the memcpy(), and have done so for many, many years.

*This code is safe* no matter what the compiler says.

Last time this came up in a FORTIFY_SOURCE context, Darrick proposed
to change this to use unsafe_memcpy() to switch off the compile time
checking because we *must* do runtime checking of the array lengths
provided in the structure itself.

Kees pretty much knocked that down by instead proposing some
"flex_cpy()" API he was working on that never went anywhere. So
kernel security people essentially said "no, we don't want you to
fix it that way, but then failed to provide the new infrastructure
they said we should use for this purpose.

Damned if we do, damned if we don't.

So until someone from the security side of the fence ponies up the
resources to fix this in a way that is acceptible to the security
people and they do all the testing and validation we require for
such an on-disk format change, the status quo is unlikely to change.

> You can probably get away with not fixing this for a little while longer, as
> that stuff is still a work in progress.  But I would suggest you be careful
> about potentially getting yourself into a position where XFS is blocking
> enabling security mitigations for the whole kernel...

<sigh>

I'm really getting tired of all these "you'll do what we say or
else" threats that have been made over the past few months.

As I said: if this is a priority, then the entities who have given
it priority need to provide resources to fix it, not demand that
others do the work they want done right now for free. If anyone
wants work done for free, then they'll just have to wait in line
until we've got time to address it.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
