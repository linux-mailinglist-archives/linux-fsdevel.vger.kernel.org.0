Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F074E381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 03:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGKBhn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 21:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGKBhm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:37:42 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C44DB
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:37:41 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BE2921015E8
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 01:37:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 39A471011E3
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Jul 2023 01:37:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1689039460; a=rsa-sha256;
        cv=none;
        b=L9xliSkHerjJ5RNZtggmRlNa0AzZbKwk7GdTlV29THTJP0DoBcy1VPNXqCUfFaGOoUhJOe
        z77JBo+UlnYNJcEZcZZ2BC7EsDoACrWgpZLvoH0PaWoA8sHxpPkP+xp+/PIhM6663mFkWJ
        TZjwm4i+QFJkp3hbGBWfRZcTqlE1J5ZGHm1mZV30YNemV5ng0PxYt1NJg1sjy3mKAYpjXd
        RHq6P13jV9YfoyPuRDqlB72PEXv2skdUcjg6RJQO0iGA7xbh5CEH8JnSbLE5TfHX8uRUlu
        ZDA3Axr50Xqm2MeVP23mlkyKe6XgFafUZ6DgClHxuI1gwDE/AwcSkZrQIwwUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1689039460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         dkim-signature; bh=DlxuMxmeNwWxu3Lf7j83rKB4Gg+MGbkmGgKoHzaeeao=;
        b=hrI1TFe8+wkhSESGdMSjKEJfoRjapIl48GCUB7qkSe3WImpkkpeGsRip/iuDttVLdYL/K+
        ri/v6T0N9K7PyKnqKgPg0dZDOK0rLULZRBHyUeUR4ipwGqzD1zXEhcMh4fvB92/pMo8r+/
        CVno/mQA5MU4cn8wFRlP9DvoxA2RRZ2Bx88xR1g392tsPY/2nmJf4g4LYcGE3e7f5V0RSy
        mhaEh/4mg/rdE4lO5q+7rRPR3hTo+31nzMiAAVjlwU/QC+EmPgV7x1F2u6pLhHjrGbceiz
        sYW9tsyZz1Cf6nGd0epjP3HJEcfGFaSSy3SN1INh/aAQr+GhOtUagwNw/o57hQ==
ARC-Authentication-Results: i=1;
        rspamd-7d9c4d5c9b-jw2dn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Eight-Coil: 3eee88e205151648_1689039460465_1655277285
X-MC-Loop-Signature: 1689039460465:4216004410
X-MC-Ingress-Time: 1689039460465
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.12 (trex/6.9.1);
        Tue, 11 Jul 2023 01:37:40 +0000
Received: from kmjvbox (unknown [71.198.86.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4R0Nm35p5PzH9
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 18:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1689039459;
        bh=DlxuMxmeNwWxu3Lf7j83rKB4Gg+MGbkmGgKoHzaeeao=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=jSVsqrknew6IDBjzlyvqVYYDLXBKTtuFqe1sJNaJCQkE4HTW0B6v41NnEWV7kmbo+
         8NM7uWE7idDKQ8c4edaMJ3TP2jJb+DG5O0pvjShZaE8EIwMygefW6A0DvXLOQA9DLJ
         /SbVN74YkOme2dQq5IdHDxBF96FnzZv0l/+lKed0=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0085
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 10 Jul 2023 18:37:03 -0700
Date:   Mon, 10 Jul 2023 18:37:03 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        German Maglione <gmaglione@redhat.com>,
        Greg Kurz <groug@kaod.org>, Max Reitz <mreitz@redhat.com>
Subject: [RFC PATCH 0/2] virtiofs submounts forgotten after client memory
 pressure
Message-ID: <cover.1689038902.git.kjlx@templeofstupid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,
I recently ran into a situation where a virtiofs client began
encountering EBADF after the client system had an OOM.  After
reproducing the issue and debugging, it appears that the problem is
caused by a virtiofsd submount being forgotten once the dentry
referencing that submount is killed by the shrinker.  In this particular
case, the submount had been bind mounted into a container's mount
namespace.  The reference count on the original dentry was 0, making it
eligible for eviction.  However, because this dentry was also the last
reference the client knew it had, it sent a forget message to the
server.  This caused all future references to the FUSE node-id from
virtiofsd perspective to become invalid.  Subsequent attempts to used
the node-id received an EBADF from the server.

This pair of patches modifies the virtiofs submount code to perform a
lookup on the nodeid that forms the root of the submount.  The patch
before this pulls the revalidate lookup code into a helper function that
can be used both in revalidate and submount superblock fill.

I'm not enamored with this approach, but was hard pressed to think of a
more clever idea.

In the meantime, it's been tested via:

- fstests for virtiofs
- fstests for fuse (against passthrough_ll)
- manual testing to watch how refcounts change between client and server
  in response to filesytem access, umount, and eviction by the shrinker.

Thanks,

-K

Krister Johansen (2):
  fuse: revalidate: move lookup into a separate function
  fuse: ensure that submounts lookup their root

 fs/fuse/dir.c    | 87 +++++++++++++++++++++++++++++++++---------------
 fs/fuse/fuse_i.h |  6 ++++
 fs/fuse/inode.c  | 32 +++++++++++++++---
 3 files changed, 94 insertions(+), 31 deletions(-)

-- 
2.25.1

