Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29CE2589F25
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 18:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbiHDQKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 12:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHDQKQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 12:10:16 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78902E07;
        Thu,  4 Aug 2022 09:10:14 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j8so118993ejx.9;
        Thu, 04 Aug 2022 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LpzN6/8VML3eXmBMdJ8lJV7yB/qMpEBzyelbQWPVaHI=;
        b=JVNLM63FFCeWhStk+UNkPrxRpCxWGdqEE1AV3Kg9hb+nOBvk4Nj6O3QGv+mHc+fudn
         p4lHOQ30pG3zBC0fQVhE6b3O6k0R87qRoFE1bi0b/zSiSvKQcqqkBOo1jYV6CwQ0P2Bj
         UIHEEKlIz07AijULYGFpk6D4uiMhHp0Ka6h15EjByF+MASW3lH+5AJClBrjlaEt+zhGY
         fz3mEB305zcVE3/QPbDQKI3ZQm1wTwFsV8oRlfTOHkN0ekXorRrdphDpxP42oqcEUr+H
         Yf4iMI/whjB4NJ5Vtz36zXhByXxtaZVWi8qBcda1Rn+Iv5xOWjJV5AiD2Ynk3cn9L9la
         sDeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LpzN6/8VML3eXmBMdJ8lJV7yB/qMpEBzyelbQWPVaHI=;
        b=xytnSL4dUz+9t1gVaaQNaruFvGoDK7B3w0F7lepesciUWG3ER/Kaj0XMfdNNBSeuQU
         0kIqleBfSaT+PlFZgx8z/w1atJtfUXrVhRMhT25zeNOtWtmSvTCmYY3xtvsh+oZt5iFI
         hIFQoWlcdKVpsnr7U9ofwawq411P51pgxsstgtu/5EB7qO0s8GjU0vrPTVStg8gienDN
         dIycWndDhnjHytTOTznK25N0Tj+soVfCvGXy/iPdHcSOkEDfOkKHwnu6dPOVstIzk8TQ
         GmEuGBpMvFzbvQt0/ZeHjb5fzB2rRFYPbg0qGhsEEkeL6noYa8n1xukSzRLgs3TbOopB
         1BKA==
X-Gm-Message-State: ACgBeo2yWfjzLl3M71N4a7v1OdzSmZsO+ujVWmbny2UqkNGASi5ArPhc
        pTl92K2vuRKnBRw8PF4Wx2U=
X-Google-Smtp-Source: AA6agR6eZ726TRa+v1E5si8RuGP1qKkywRmoBb3bexTGJftPD5lDyWiEOpCCPGPQoAx4dCK2BgwMcg==
X-Received: by 2002:a17:907:72c6:b0:72f:b01:2723 with SMTP id du6-20020a17090772c600b0072f0b012723mr1943653ejc.439.1659629412744;
        Thu, 04 Aug 2022 09:10:12 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id t5-20020aa7db05000000b0043b986751a7sm856014eds.41.2022.08.04.09.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 09:10:08 -0700 (PDT)
Date:   Thu, 4 Aug 2022 18:10:04 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Subject: Re: [PATCH 0/2] landlock: truncate(2) support
Message-ID: <YuvvXI5Y2azqiQyU@nuc>
References: <20220707200612.132705-1-gnoack3000@gmail.com>
 <dbb0cd04-72a8-b014-b442-a85075314464@digikod.net>
 <YsqihF0387fBeiVa@nuc>
 <b7ee2d01-2e33-bf9c-3b56-b649e2fde0fb@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7ee2d01-2e33-bf9c-3b56-b649e2fde0fb@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 29, 2022 at 01:58:17PM +0200, Mickaël Salaün wrote:
>
> On 10/07/2022 11:57, Günther Noack wrote:
> > Hello Mickaël!
> >
> > Thank you for the fast feedback! I'm looking into your comments from
> > this mail and the rest of the thread and am working on an updated
> > patch set.
> >
> > On Fri, Jul 08, 2022 at 01:16:29PM +0200, Mickaël Salaün wrote:
> > > Hi Günther, this looks good!
> > >
> > > Added linux-fsdevel@vger.kernel.org
> > >
> > > On 07/07/2022 22:06, Günther Noack wrote:
> > > > The goal of these patches is to work towards a more complete coverage
> > > > of file system operations that are restrictable with Landlock.
> > > >
> > > > The known set of currently unsupported file system operations in
> > > > Landlock is described at [1]. Out of the operations listed there,
> > > > truncate is the only one that modifies file contents, so these patches
> > > > should make it possible to prevent the direct modification of file
> > > > contents with Landlock.
> > > >
> > > > The patch introduces the truncate(2) restriction feature as an
> > > > additional bit in the access_mask_t bitmap, in line with the existing
> > > > supported operations.
> > > >
> > > > Apart from Landlock, the truncate(2) and ftruncate(2) family of system
> > > > calls can also be restricted using seccomp-bpf, but it is a
> > > > complicated mechanism (requires BPF, requires keeping up-to-date
> > > > syscall lists) and it also is not configurable by file hierarchy, as
> > > > Landlock is. The simplicity and flexibility of the Landlock approach
> > > > makes it worthwhile adding.
> > > >
> > > > I am aware that the documentation and samples/landlock/sandboxer.c
> > > > tool still need corresponding updates; I'm hoping to get some early
> > > > feedback this way.
> > > Yes, that's a good approach.
> > >
> > > Extending the sandboxer should be straightforward, you can just extend the
> > > scope of LL_FS_RW, taking into account the system Landlock ABI because there
> > > is no "contract" for this sample.
> >
> > Sounds good, I'll extend the sample tool like this for the updated patch set.
> >
> > (On the side, as you know from the discussion on the go-landlock
> > library, I have some suspicion that the "best effort"
> > backwards-compatibility approach in the sample tool is not the right
> > one for the "refer" right, but that might be better suited for a
> > separate patch. Maybe it'll be simpler to just not support a
> > best-effort downgrade in the sample tool.)
>
> Please share your though about the "refer" right.

The sample tool implements a "best effort" approach by removing the
access rights from all bitmasks passed to the kernel -- but this means
different things for the refer right than it does for other rights
like truncate:

* In the case of truncate, removing the truncate right from the
  handled rights means that truncate *will* be permitted after
  enforcement.

* In the case of "refer", removing the refer right from the handled
  rights means that the "refer" operations *will not* be permitted
  after enforcement.

Consequently, the approach of downgrading these needs to be different.

If the caller *asks* for the "refer" right to be permitted for a file
hierarchy, this cannot be done with Landlock ABI v1. Therefore, the
"best effort" downgrade will have to fall back to "doing nothing".

I've described this previously in this document:
https://docs.google.com/document/d/1SkFpl_Xxyl4E6G2uYIlzL0gY2PFo-Nl8ikblLvnpvlU/edit

Admittedly, this line of reasoning is more relevant to the proper
Landlock libraries than it is to the sample tool. However, the sample
tool is the place that people look at to understand the API... maybe
there should at least be a comment about it.

But as I said, this problem existed before the truncate patch already,
so it's probably best discussed separately; I'm happy to send a
separate patch if you agree with this line of reasoning.

>
>
> >
> > > You'll need to remove the warning about truncate(2) in the documentation,
> > > and maybe to move it to the "previous limitations" section, with the
> > > LANDLOCK_ACCESS_TRUNCATE doc pointing to it. I think it would be nice to
> > > extend the LANDLOCK_ACCESS_FS_WRITE documentation to point to
> > > LANDLOCK_ACCESS_FS_TRUNCATE because this distinction could be disturbing for
> > > users. Indeed, all inode-based LSMs (SELinux and Smack) deny such action if
> > > the inode is not writable (with the inode_permission check), which is not
> > > the case for path-based LSMs (AppArmor and Tomoyo).
> >
> > This makes a lot of sense, I'll work on the documentation to point this out.
> >
> > I suspect that for many common use cases, the
> > LANDLOCK_ACCESS_FS_TRUNCATE right will anyway only be used together
> > with LANDLOCK_ACCESS_FS_FILE_WRITE in practice. (See below for more
> > detail.)
>
> Agree
>
>
> >
> > > While we may question whether a dedicated access right should be added for
> > > the Landlock use case, two arguments are in favor of this approach:
> > > - For compatibility reasons, the kernel must follow the semantic of a
> > > specific Landlock ABI, otherwise it could break user space. We could still
> > > backport this patch and merge it with the ABI 1 and treat it as a bug, but
> > > the initial version of Landlock was meant to be an MVP, hence this lack of
> > > access right.
> > > - There is a specific access right for Capsicum (CAP_FTRUNCATE) that could
> > > makes more sense in the future.
> > >
> > > Following the Capsicum semantic, I think it would be a good idea to also
> > > check for the O_TRUNC open flag:
> > > https://www.freebsd.org/cgi/man.cgi?query=rights
> >
> > open() with O_TRUNC was indeed a case I had not thought about - thanks
> > for pointing it out.
> >
> > I started adding some tests for it, and found to my surprise that
> > open() *is* already checking security_path_truncate() when it is
> > truncating files. So there is a chance that we can get away without a
> > special check for O_TRUNC in the security_file_open hook.
> >
> > The exact semantics might be slightly different to Capsicum though -
> > in particular, the creat() call (= open with O_TRUNC|O_CREAT|O_WRONLY)
> > will require the Landlock truncate right when it's overwriting an
> > existing regular file, but it will not require the Landlock truncate
> > right when it's creating a new file.
>
> Is the creat() check really different from what is done by Capsicum?

TBH, I'm not sure, it might also do the same thing. I don't have a
FreeBSD machine at hand and am not familiar with Capsicum in detail.
Let me know if you think we should go to the effort of ensuring the
compatibility down to that level.

> > I'm not fully sure how this is done in Capsicum. I assume that the
> > Comparison with Capsicum is mostly for inspiration, but there is no
> > goal of being fully compatible with that model?
>
> I think Landlock has all the technical requirements to implement a
> Capsicum-like on Linux: unprivileged access control (which implies scoped
> access control, policies composition, only new restrictions, nesting,
> dedicated syscalls…). The main difference with the actual Landlock
> sandboxing would be that restrictions would apply to all processes doing
> actions on a specific kind of file descriptor (i.e. capability). Instead of
> checking the current thread's domain, Landlock could check the "file
> descriptor's domain". We're definitely not there yet but let's keep this in
> mind. ;)

Acknowledged.

>
>
> >
> > The creat() behaviour is non-intuitive from userspace, I think:
> > creat() is a pretty common way to create new files, and it might come
> > as a surprise to people that this can require the truncate right,
> > because:
> >
> > - The function creat() doesn't have "truncate" in its name, and you
> >    might be tempted to think that the LANDLOCK_ACCESS_FS_MAKE_REG is
> >    sufficient for calling it.
> >
> > - Users can work around the need for the truncate right by unlinking
> >    the existing regular file with the same name and creating a new one.
> >    So for the most common use case (where users do not care about the
> >    file's inode identity or race conditions), it is surprising that
> >    the truncate right is required.
>
> These are useful information to put in the documentation. Explaining why it
> is required should help users. From my point of view, the logic behind is
> that replacing a file modifies its content (i.e. shrink it to zero), while
> unlinking a file doesn't change its content but makes it unreachable
> (removes it) from a directory (and it might not be deleted if linked
> elsewhere).

Added it to the documentation with some rewording.

>
>
> >
> > Summarizing this, I also think that the truncate right needs to be a
> > separate flag, even if just for backwards compatibility reasons.
> >
> > But at the same time, I suspect that in practice, the truncate right
> > will probably have to usually go together with the file_write right,
> > so that the very common creat() use case (and possibly others) does
> > not yield surprising behaviour.
>
> Agree. User space libraries might (and probably should) have a different
> interface than the raw syscalls. The Landlock syscalls are meant to provide
> a flexible interface for different use cases. We should keep in mind that
> the goal of libraries is to help developers. ;)

--
