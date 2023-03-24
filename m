Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C75F6C888A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 23:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjCXWpb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 18:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjCXWpa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:45:30 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A59A8E;
        Fri, 24 Mar 2023 15:45:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7EC383200977;
        Fri, 24 Mar 2023 18:45:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Mar 2023 18:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679697926; x=1679784326; bh=7YaECwlWAb2rNWL4oDYUcOdn3UHmJY1t4LZ
        axuY9iyU=; b=f8LifDK0wPtGXdGHdfS2+RnKTFCP2SBVGWXFIH9wBoqJPzX+VTh
        C8tIsqkJJY+BCuDAbLG2T1Pa0FwaAGSqv4uPqEl10Rp3SuI20MlnyikhrVHtU3v8
        sdym5fEfeonTbifHo9hbcLQPUWIWImnFTITE8l8NOMXrKewlPLzyzIQ0Gg4itDx0
        wRHR/zRGLvPkfuEzcZ8XAZC5mHK6/xhgPV3PqkqTKcCkN7r8FoZKGeNxdrhpsqPX
        b8VQpcvFpPVrTvO6i2iJIxH4GlFnolGC2xpOzWfxsMaISOjZWEikeKaGiYmItKwV
        ppTUTFRuFIP3IB0Z1hjIHUvIJdBozhVbJ5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679697926; x=1679784326; bh=7YaECwlWAb2rNWL4oDYUcOdn3UHmJY1t4LZ
        axuY9iyU=; b=SgQxgdZujV/YbtVZtVxNlDD6vj3RhbwB8KOpRmBSGEx5WD0nerM
        jF1FTGDnPJh1RVy2E9O8JvBQ6dgjNTVoomX4WoyJU2F6GPjXjeUQ5hOC3pf0jSCg
        3S3QqqSs8LdDBrWnviCXiRPY3ZyDI3Y4O194R2CamVbvlMGJ0fycXFZ4p8rFkHEt
        P/QO2nx0pVs2uCIQsWDb/Y7atpyD6es+eKEeaIl7WhC4nkBlZunzIkls+sgqkIpc
        ME/mvSBNo7v1drT6cxLNak0CoAyvqPE3nrz26KieWAijcm/e5KeOIlewnJhQKaEX
        MZIVWhGsZYta8ivExMVJbsRAaHCzvcOfosA==
X-ME-Sender: <xms:BSgeZA__YHNiNizpO9CJ2q99uttqtPMWb1BrQFg_sD6pkr6U6ITJrQ>
    <xme:BSgeZIsvPrHcr4YJ1oZsZ-Cq4Mr30ZVn5GsIN-FCCrGQmMllz1JeKuB4TJVIlERa4
    EApCtB1yXTXlpTl5DQ>
X-ME-Received: <xmr:BSgeZGB4tauHZQ2OJo2jTpm6_stXlkHgSJzuvKe_S4715mGeQAo66RsJSnf8xogdlCSd3paryueowzWXVwsUZ0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpedfvfih
    lhgvrhcujfhitghkshculdfoihgtrhhoshhofhhtmddfuceotghouggvsehthihhihgtkh
    hsrdgtohhmqeenucggtffrrghtthgvrhhnpeeguddtjeekleekuddtjedvleegvddtveev
    keegleehhfekheejveehfeekfeduieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpd
    husghunhhtuhdrtghomhdprghskhhusghunhhtuhdrtghomhenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgesthihhhhitghkshdrtg
    homh
X-ME-Proxy: <xmx:BSgeZAftzaPtzPLrABVysrBpxcFqgG1uuCbBJcoNU4EEGI4jS40iuA>
    <xmx:BSgeZFP6WZKD0wj7hd-bNnpFDIQhj8FzPmCSew_veOZXWy4nORfVXg>
    <xmx:BSgeZKnDoGaGfKJAtarHqRHt3Yv_u2YtaEa78D-z-g4nbi9tFThLaw>
    <xmx:BigeZBBG2OtW8G1ez4f65viFBI07LZRqVcu8wDpZyoNJ4__VV8vxGQ>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 18:45:24 -0400 (EDT)
Date:   Fri, 24 Mar 2023 17:45:23 -0500
From:   "Tyler Hicks (Microsoft)" <code@tyhicks.com>
To:     =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        Christian Brauner <brauner@kernel.org>,
        landlock@lists.linux.dev,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        eCryptfs <ecryptfs@vger.kernel.org>
Subject: Re: Does Landlock not work with eCryptfs?
Message-ID: <ZB4oA1Q2Q8tq6POc@sequoia>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
 <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
 <20230321172450.crwyhiulcal6jvvk@wittgenstein>
 <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net>
 <ZByG4u1L6yF5kfeD@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZByG4u1L6yF5kfeD@nuc>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-23 18:05:38, Günther Noack wrote:
> +ecryptfs mailing list FYI
> 
> Just some additional data points on the Landlock/eCryptfs issues.
> 
> On Tue, Mar 21, 2023 at 07:16:28PM +0100, Mickaël Salaün wrote:
> > On 21/03/2023 18:24, Christian Brauner wrote:
> > > On Tue, Mar 21, 2023 at 05:36:19PM +0100, Mickaël Salaün wrote:
> > > > There is an inconsistency between ecryptfs_dir_open() and ecryptfs_open().
> > > > ecryptfs_dir_open() actually checks access right to the lower directory,
> > > > which is why landlocked processes may not access the upper directory when
> > > > reading its content. ecryptfs_open() uses a cache for upper files (which
> > > > could be a problem on its own). The execution flow is:
> > > > 
> > > > ecryptfs_open() -> ecryptfs_get_lower_file() -> ecryptfs_init_lower_file()
> > > > -> ecryptfs_privileged_open()
> > > > 
> > > > In ecryptfs_privileged_open(), the dentry_open() call failed if access to
> > > > the lower file is not allowed by Landlock (or other access-control systems).
> > > > Then wait_for_completion(&req.done) waits for a kernel's thread executing
> > > > ecryptfs_threadfn(), which uses the kernel's credential to access the lower
> > > > file.
> > > > 
> > > > I think there are two main solutions to fix this consistency issue:
> > > > - store the mounter credentials and uses them instead of the kernel's
> > > > credentials for lower file and directory access checks (ecryptfs_dir_open
> > > > and ecryptfs_threadfn changes);
> > > > - use the kernel's credentials for all lower file/dir access check,
> > > > especially in ecryptfs_dir_open().
> > > > 
> > > > I think using the mounter credentials makes more sense, is much safer, and
> > > > fits with overlayfs. It may not work in cases where the mounter doesn't have
> > > > access to the lower file hierarchy though.
> > > > 
> > > > File creation calls vfs_*() helpers (lower directory) and there is not path
> > > > nor file security hook calls for those, so it works unconditionally.
> > > > 
> > > >  From Landlock end users point of view, it makes more sense to grants access
> > > > to a file hierarchy (where access is already allowed) and be allowed to
> > > > access this file hierarchy, whatever it belongs to a specific filesystem
> > > > (and whatever the potential lower file hierarchy, which may be unknown to
> > > > users). This is how it works for overlayfs and I'd like to have the same
> > > > behavior for ecryptfs.
> > > 
> > > So given that ecryptfs is marked as "Odd Fixes" who is realistically
> > > going to do the work of switching it to a mounter's credentials model,
> > > making sure this doesn't regress anything, and dealing with any
> > > potential bugs caused by this. It might be potentially better to just
> > > refuse to combine Landlock with ecryptfs if that's possible.
> 
> There is now a patch to mark it orphaned (independent of this thread):
> https://lore.kernel.org/all/20230320182103.46350-1-frank.li@vivo.com/

I have little time to devote to eCryptfs these days. I'm not sure it
needs to be fully orphaned but I think deprecation and marking for
removal is the responsible thing to do.

> > If Tyler is OK with the proposed solutions, I'll get a closer look at it in
> > a few months. If anyone is interested to work on that, I'd be happy to
> > review and test (the Landlock part).
> 
> I wonder whether this problem of calling security hooks for the
> underlying directory might have been affecting AppArmor and SELinux as
> well?  There seem to be reports on the web, but it's possible that I
> am misinterpreting some of them:

Yes, this eCryptfs design problem is common for other LSMs, as well.

Tyler

> 
> https://wiki.ubuntu.com/SecurityTeam/Roadmap
>   mentions this "unscheduled wishlist item":
>   "eCryptfs + SELinux/AppArmor integration, to protect encrypted data from root"
> 
> https://askubuntu.com/a/1195430
>   reports that AppArmor does not work on an eCryptfs mount for their use case
>   "i tried adding the [eCryptfs] source folder as an alias in apparmor and it now works."
> 
> —Günther
> 
> -- 
