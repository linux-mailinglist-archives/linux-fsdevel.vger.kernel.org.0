Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC76C889F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Mar 2023 23:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjCXWx2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Mar 2023 18:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCXWx1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:53:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C1CA12;
        Fri, 24 Mar 2023 15:53:25 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6AB053200970;
        Fri, 24 Mar 2023 18:53:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 24 Mar 2023 18:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tyhicks.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679698404; x=1679784804; bh=NiD6aJpoSXj9vZ4xbh3Rf/ZnmvdFvHoaH7R
        HSUgzMYg=; b=KlSfjjWYLalub9anJ6/nSWgX8RTccw9DzYMYo2SH/VH8JX4Av8q
        U9bWSHGzwOqLe7PECg9UO8pAFkR8G70RrkyJdlLCJRY6pkyOtv2snvMhIYc2uvwE
        ebMPiIEjv0pAn0B+4HBqGuK/F4wKMoSILy9XckiptamJHJFgvLNYNcZdhTtKY03U
        eOGzzSINOEcSPTwTXroTdFu0wXkJs8b6X5QrdM4CYoaWrCdbLCZPv8XXwLMaM/Yp
        lTp+wqTOk8tBbO90+Z+YUBW5CqvP3AOkSHxnry6onJej9u/rRl7ko2Rs0wdV1iaF
        BDO5QxY55qhzdjv2NrurR3VLeSIsjmEpAQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679698404; x=1679784804; bh=NiD6aJpoSXj9vZ4xbh3Rf/ZnmvdFvHoaH7R
        HSUgzMYg=; b=P0yz2+sJZ9B8SyMZMYeqsjGTTFp7ULTHcPLxUiio9on2MYvyTr+
        op1KCVPpN0/zufQ0U4TWCWBlcXZNY+mUvj/p8NmEY8Sdqi1GbRD4fX9rCbwutAA1
        LJVif/Fik/NBUMMkQ+YdhhZoTQ1kjke1jd75xKl3ccBf+nQVUsNivKA6fudjvwUu
        mmLZMAhREwWSqebA4cUXGe7COiZaMCQN4YaGE1o/hz6ecHQI1mzKuq6T0vYlOURd
        dgHEGtjsMYUDWAEDJ7cnNRHso0ELdyXKTY3DDQEis5mQQhyoIeHgbD7PtDg5AH8Q
        rLgOhvb02P8wLyQ5zBt0yGn5wO459jgq5ww==
X-ME-Sender: <xms:4ykeZPk0z1CAZne7IQrdl5mDc-ipJz8IpUFo-v76_OV7zL3mTFduDQ>
    <xme:4ykeZC1gU52rfcwZ8ZkQQeibwHnpnqSb9wBnP5tO58rXt_NtJrLUnZo3jfjjWZsm1
    ekGi6q6aSAFW3n40qg>
X-ME-Received: <xmr:4ykeZFq5xIsZX8dggniEAbWpr5hRMqSCTBpin_6FEHf6sEJL7mKNifRbh3GIGQ569BLLhhIiNDndAjYp_sozewI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegjedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpefvhihl
    vghrucfjihgtkhhsuceotghouggvsehthihhihgtkhhsrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddttdeglefgfeevjeevteduiedtveekfeeugefhffehudfhhfeuffevteeg
    leenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtoh
    guvgesthihhhhitghkshdrtghomh
X-ME-Proxy: <xmx:4ykeZHkzJXEVmKFsS5u1iLwyH4E48vT9hbB3Rmg5JNFwIAqnZevNjg>
    <xmx:4ykeZN1k5TbUb1gif32_vHYChFbXsPPqMA1owSVQE5rohFz0cFru6g>
    <xmx:4ykeZGsc7Zqi7h7BitQVE6W34EaozKMwmkqcFTb2haVG5Nwr6oDJCA>
    <xmx:5CkeZF-bAJaNQcoG1IjUkKa89aQNtiPorYOWeSWh2Tlpv8EVkDCPUw>
Feedback-ID: i78e14604:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 18:53:22 -0400 (EDT)
Date:   Fri, 24 Mar 2023 17:53:20 -0500
From:   Tyler Hicks <code@tyhicks.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     Christian Brauner <brauner@kernel.org>,
        =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
        landlock@lists.linux.dev,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Does Landlock not work with eCryptfs?
Message-ID: <ZB4p4DXwgByYCt5O@sequoia>
References: <20230319.2139b35f996f@gnoack.org>
 <c1c9c688-c64d-adf2-cc96-dc2aaaae5944@digikod.net>
 <20230320.c6b83047622f@gnoack.org>
 <5d415985-d6ac-2312-3475-9d117f3be30f@digikod.net>
 <e70f7926-21b6-fbce-c5d6-7b3899555535@digikod.net>
 <20230321172450.crwyhiulcal6jvvk@wittgenstein>
 <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42ffeef4-e71f-dd2b-6332-c805d1db2e3f@digikod.net>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023-03-21 19:16:28, Mickaël Salaün wrote:
> 
> On 21/03/2023 18:24, Christian Brauner wrote:
> > On Tue, Mar 21, 2023 at 05:36:19PM +0100, Mickaël Salaün wrote:
> > > There is an inconsistency between ecryptfs_dir_open() and ecryptfs_open().
> > > ecryptfs_dir_open() actually checks access right to the lower directory,
> > > which is why landlocked processes may not access the upper directory when
> > > reading its content. ecryptfs_open() uses a cache for upper files (which
> > > could be a problem on its own). The execution flow is:
> > > 
> > > ecryptfs_open() -> ecryptfs_get_lower_file() -> ecryptfs_init_lower_file()
> > > -> ecryptfs_privileged_open()
> > > 
> > > In ecryptfs_privileged_open(), the dentry_open() call failed if access to
> > > the lower file is not allowed by Landlock (or other access-control systems).
> > > Then wait_for_completion(&req.done) waits for a kernel's thread executing
> > > ecryptfs_threadfn(), which uses the kernel's credential to access the lower
> > > file.
> > > 
> > > I think there are two main solutions to fix this consistency issue:
> > > - store the mounter credentials and uses them instead of the kernel's
> > > credentials for lower file and directory access checks (ecryptfs_dir_open
> > > and ecryptfs_threadfn changes);
> > > - use the kernel's credentials for all lower file/dir access check,
> > > especially in ecryptfs_dir_open().
> > > 
> > > I think using the mounter credentials makes more sense, is much safer, and
> > > fits with overlayfs. It may not work in cases where the mounter doesn't have
> > > access to the lower file hierarchy though.
> > > 
> > > File creation calls vfs_*() helpers (lower directory) and there is not path
> > > nor file security hook calls for those, so it works unconditionally.
> > > 
> > >  From Landlock end users point of view, it makes more sense to grants access
> > > to a file hierarchy (where access is already allowed) and be allowed to
> > > access this file hierarchy, whatever it belongs to a specific filesystem
> > > (and whatever the potential lower file hierarchy, which may be unknown to
> > > users). This is how it works for overlayfs and I'd like to have the same
> > > behavior for ecryptfs.
> > 
> > So given that ecryptfs is marked as "Odd Fixes" who is realistically
> > going to do the work of switching it to a mounter's credentials model,
> > making sure this doesn't regress anything, and dealing with any
> > potential bugs caused by this. It might be potentially better to just
> > refuse to combine Landlock with ecryptfs if that's possible.
> 
> If Tyler is OK with the proposed solutions, I'll get a closer look at it in
> a few months. If anyone is interested to work on that, I'd be happy to
> review and test (the Landlock part).

I am alright with using the mounter creds but eCryptfs is typically
mounted as root using a PAM module so the mounter is typically going to
be more privileged than the user accessing the eCryptfs mount (in the
common case of an encrypted home directory).

But, as Christian points out, I think it might be better to make
Landlock refuse to work with eCryptfs. Would you be at ease with that
decision if we marked eCryptfs as deprecated with a planned removal
date?

Tyler

