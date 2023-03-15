Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3808E6BBBB3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjCOSJE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCOSJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 14:09:02 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FD61B578;
        Wed, 15 Mar 2023 11:09:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so1607242wmb.5;
        Wed, 15 Mar 2023 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678903739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qBCF9cqRw4//6g0u+mI/EVuBZjaNX/B1r61yKNDclCs=;
        b=qpQ1v2gyXUCH71U7z2QzOW3U6u4Blf+RAcEIYyql4uAAgr6XUT+/PiWeKmioyWONo3
         uX+PBqBzOVo64H2ZRV67FZOchfuqosVisOPSEActmD9IECcArStURK0iGUnHhoXJecb3
         EAZIK7NvZyMrg0AW3ABD+ZCFrCsamfKiPUV1yv7zy+LZyD21gjxYHDVHJCTC/4po4YRr
         aQeNrNUObp4qI2dclVofqfij6m/e3MatKMXCrHI06EJu/TOGlzVXhXIMhyISnSi/WrBs
         ghTEvf7J40MkAPWhFwaCZ7OvQozmDljjjy1+O/2YyDPWJa6cFWmh3d8b9hRLRNlW5JIn
         c5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678903739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBCF9cqRw4//6g0u+mI/EVuBZjaNX/B1r61yKNDclCs=;
        b=txkOE4Rlbgk/KcxQpr9ZS/mvEDUxG3ymAFuIG9wCcvGvgwlIUjQ3xZ6Og9wD05dsoi
         WW4oiYcye7EuXiy7vGknuo5zwvdOuCaL1X0qHeoD9y01OMNDRU8AA5bOEUyQb1lnY7bv
         w6YiWsun8rkAONySKcppcqMbUkEG3R0oRsWm4I7FJHg75HBURDFZdCuJEjjldA4JAlkf
         bs7T3h8Pwv6eAjPHdxj1ZC5dvEFnKC95aUqKDR2A17Pyx3+qmkgK/yfaw/7Tm5vxI1QF
         5gol4c+IMbJuNGsvunl0V0whwy+Mr5/YFuMVGOvClnLgdTUkYGp0AJQYvi3vyxqSVnaL
         wF2Q==
X-Gm-Message-State: AO0yUKVzT9xRDrP+NTQArUmGtk79NzEXJWfn9LTmTgSgMgJklLxSTEuL
        f8IKnCg99apT6KxlAAjD0ho=
X-Google-Smtp-Source: AK7set9FZx+p7o40TkVE4eWZX5rluRX08y33bd+HqnyMbHx5qtRZKpex0WkoI0ytCvJ1Q+K9tId6ag==
X-Received: by 2002:a05:600c:4753:b0:3dd:1c46:b92 with SMTP id w19-20020a05600c475300b003dd1c460b92mr20772979wmo.16.1678903739013;
        Wed, 15 Mar 2023 11:08:59 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c240c00b003dc521f336esm2567770wmp.14.2023.03.15.11.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 11:08:58 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jan Kara <jack@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [git pull] vfs.git sysv pile
Date:   Wed, 15 Mar 2023 19:08:57 +0100
Message-ID: <3019063.4lk9UinFSI@suse>
In-Reply-To: <Y/9duET0Mt5hPu2L@ZenIV>
References: <Y/gugbqq858QXJBY@ZenIV> <20230301130018.yqds5yvqj7q26f7e@quack3>
 <Y/9duET0Mt5hPu2L@ZenIV>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On mercoled=EC 1 marzo 2023 15:14:16 CET Al Viro wrote:
> On Wed, Mar 01, 2023 at 02:00:18PM +0100, Jan Kara wrote:
> > On Wed 01-03-23 12:20:56, Fabio M. De Francesco wrote:
> > > On venerd=EC 24 febbraio 2023 04:26:57 CET Al Viro wrote:
> > > > 	Fabio's "switch to kmap_local_page()" patchset (originally after t=
he
> > > >=20
> > > > ext2 counterpart, with a lot of cleaning up done to it; as the matt=
er=20
of
> > > > fact, ext2 side is in need of similar cleanups - calling conventions
> > > > there
> > > > are bloody awful).
> > >=20

[snip]

>=20
> I think I've pushed a demo patchset to vfs.git at some point back in
> January... Yep - see #work.ext2 in there; completely untested, though.

The following commits from the VFS tree, #work.ext2 look good to me.

f5b399373756 ("ext2: use offset_in_page() instead of open-coding it as=20
subtraction")
c7248e221fb5 ("ext2_get_page(): saner type")
470e54a09898 ("ext2_put_page(): accept any pointer within the page")
15abcc147cf7 ("ext2_{set_link,delete_entry}(): don't bother with page_addr")
16a5ee2027b7 ("ext2_find_entry()/ext2_dotdot(): callers don't need page_add=
r=20
anymore")

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

I could only read the code but I could not test it in the same QEMU/KVM x86=
_32=20
VM where I test all my HIGHMEM related work.=20

Btrfs as well as all the other filesystems I converted to kmap_local_page()=
=20
don't make the processes in the VM to crash, whereas the xfstests on ext2 =
=20
trigger the OOM killer at random tests (only sometimes they exit gracefully=
).

=46YI, I tried to run the tests with 6GB of RAM, booting a kernel with=20
HIGHMEM64GB enabled. I cannot add my "Tested-by" tag.

=46abio



