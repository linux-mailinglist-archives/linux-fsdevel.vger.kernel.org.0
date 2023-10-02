Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5E57B56A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238066AbjJBPYk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbjJBPYj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:24:39 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC85BA6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 08:24:35 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A27A0801FA6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E73748025AA
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 15:24:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1696260272; a=rsa-sha256;
        cv=none;
        b=kvLtBPjMC9A1AMCThH1OrxdKaMhbPYkCG/jOnqPPFLUJwEmyftEQ439MxmW+ec9ohqM7Jt
        Dk6xtYPN8NHvMg/yhLby83w7O5NVOg9Zoun8qV+PW2g0Mx6rmA7kyiTCFVQ7ZsuVBnWTM+
        MMZJoIpaJNV1dgnV+ZWeWxcHyH/Pu9ax7UCqSzSJj1adagZk1PkOBIyhGxJPJkpfijfhm5
        Sx4Ve8zsZu/tw+wKqeJ2NSVXaxk87tc6nb2M1VqLbWGfl534+80sKyPBNe5UhiRe6mmv5Z
        V+T/FpQ04nVZONXtiRyp22rcsz6PYQkCkSwU7VLMfM4C8KZ25b1Dxugv4iwxlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1696260272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=nVhD2UPHgxkBemzmKTQ0AHvtjWfmOXi8pMLaA3dLqF0=;
        b=Op3pPrA0HMppetUC7jM09R4FEB4RtoWCgZEWOxLX5PT5jbl7aPIx/ntrwandgOjzYjxo8/
        WhIIfQ07EoJEdGOQFIUpobzk5xFOH15kuQ6f7+eHzJCMdS++G5WSf9tbfye8xj9SQbFU+H
        yuqWVo/sXe3Fqpk0KF3AtNq6pl8L58jIu41WLBO/mLQvj2mIw7kaawdNsRHoA9eeEQlYOz
        D3ykV2CpglqrlTgVz05P3GM53VP+7ARgWkOLdvLfMSvlDshJ0H1EON6hPGC5QgsBhJeAF3
        wMIP1uZdLlgprI2rMEifMLKCEOldWrko24QPu7F5E5Budzd9WIrgg1uCuiP9gQ==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-crfzm;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Name-Supply: 77debbd901f39959_1696260273263_1254776567
X-MC-Loop-Signature: 1696260273263:591495243
X-MC-Ingress-Time: 1696260273262
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.112.136 (trex/6.9.1);
        Mon, 02 Oct 2023 15:24:33 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4Rzl9r4r64zDg
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Oct 2023 08:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1696260272;
        bh=nVhD2UPHgxkBemzmKTQ0AHvtjWfmOXi8pMLaA3dLqF0=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=nJRyYdo3GSmfyoQ0ZaNZSkdlMXkf4HuL9C/ZaklMeDU81o5ZFndT6zOYOe9/ASKdd
         mbLmOjlPVjp2WyGm89c6cqqXo+GTm6QvIXGkD1uquLLKN9YktGi3uiyHgWzte01VIN
         lznM9uyASg7tziDQKktrd1932gMofJa2RbF2sjS1ZwiS/hHJ6LYS23IRC6p1o+pKAT
         HI771eQvCCvcqfHf5c2LNt0qr0WiO+B7ExwXnEc9sUo8pkqKJRzLpyAl3Z+spO53fy
         rUyfA79UGv44Fu3ERBHzKMnlA3VLA72mIJ4uNijcvLx/Tg+Wa7XsgIJRUcIrBcX/SG
         WFukYNci0/kag==
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0110
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 02 Oct 2023 08:24:29 -0700
Date:   Mon, 2 Oct 2023 08:24:29 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>,
        Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [resend PATCH v2 0/2] virtiofs submounts that are still in use
 forgotten by shrinker
Message-ID: <cover.1696043833.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_BL_SPAMCOP_NET,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
I recently ran into a situation where a virtiofs client began
encountering EBADF after the client / guest system had an OOM.  After
reproducing the issue and debugging, the problem is caused by a
virtiofsd submount having the nodeid of its root dentry fogotten.  This
occurs because it borrows the reference for this dentry from the parent
that is passed into the function.

In this particular case, the submount had been bind mounted into a
container's mount namespace.  The reference count on the original parent
dentry was 0, making it eligible for eviction.  However, because this
dentry was also the last reference the fuse client knew it had, it sent
a forget message to the server.  This caused all future references to
the FUSE node-id from virtiofsd perspective to become invalid.
Subsequent attempts to use the node-id for operations against the
submount's root received an EBADF from the server.

This pair of patches modifies the virtiofs submount code to perform a
lookup on the nodeid that forms the root of the submount.  The patch
before this pulls the revalidate lookup code into a helper function that
can be used both in revalidate and submount superblock fill.

Tested via:

- fstests for virtiofs
- fstests for fuse (against passthrough_ll)
- manual testing to watch how refcounts change between client and server
  in response to filesytem access, umount, and eviction by the shrinker.

This resend has rebased against the latest tip of fuse/for-next and
massaged the commit messages in the patches, but hasn't made any
functional modifications since the original v2.

There's also been an issue opened with the project that uses this
functionality.  More details on that can be found at [1].

Changes since v1:

- Cleanups to pacify test robot

Changes since RFC:

- Modified fuse_fill_super_submount to always fail if dentry cannot be
  revalidated.  (Feedback from Bernd Schubert)
- Fixed up an edge case where looked up but subsequently declared
  invalid dentries were not correctly tracking nlookup.  (Error was
  introduced in my RFC).

Thanks,

-K

[1] https://github.com/kata-containers/kata-containers/issues/8040

Krister Johansen (2):
  fuse: revalidate: move lookup into a separate function
  fuse: ensure that submounts lookup their parent

 fs/fuse/dir.c    | 85 +++++++++++++++++++++++++++++++++---------------
 fs/fuse/fuse_i.h |  6 ++++
 fs/fuse/inode.c  | 43 ++++++++++++++++++++----
 3 files changed, 101 insertions(+), 33 deletions(-)

-- 
2.25.1

