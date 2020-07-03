Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BB7214130
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGCVoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgGCVoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:44:17 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C936C061794;
        Fri,  3 Jul 2020 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=iC52qoRmLcwFciCkqPwzA3sza3CsSIpvy4KRurXO10U=; b=EvFYgB3HkAOfgpEW7n7DPinnpX
        GB+9PIK2jY6Yw9kFEB0QxKEI/gUDO+bLzbVPabFSUUrZQ/gx5dkP0MjBLxM9U8s1qc9xsXcor7/GK
        f2MsQZ8QMUI7+A1REYGNfbtH/cRbnZB9TSh80Y8kFSjIMPQQam2sbBt0p9kB4h6MuOeWDg8wkccxH
        hoGLlNQNlOiJ94RizOjbZZEXglwOTyUMEYAl5Q1uHGMReVFoDS0azqtvwwDfLZQOR2F7QkBsJC6g1
        bLNFIdD8TkDKf2unNALJzzVJyRYJLLOlObcy/XKj8yYJVULZrBQUFRRkBHlrv2vaBOIn6Uganrj0M
        dSlXFhgA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTi-0006uZ-Sl; Fri, 03 Jul 2020 21:44:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 08/10] Documentation: filesystems: path-lookup: drop doubled word
Date:   Fri,  3 Jul 2020 14:43:23 -0700
Message-Id: <20200703214325.31036-9-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "to".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/path-lookup.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/path-lookup.rst
+++ linux-next-20200701/Documentation/filesystems/path-lookup.rst
@@ -1365,7 +1365,7 @@ as well as blocking ".." if it would jum
 resolution of "..". Magic-links are also blocked.
 
 ``LOOKUP_IN_ROOT`` resolves all path components as though the starting point
-were the filesystem root. ``nd_jump_root()`` brings the resolution back to to
+were the filesystem root. ``nd_jump_root()`` brings the resolution back to
 the starting point, and ".." at the starting point will act as a no-op. As with
 ``LOOKUP_BENEATH``, ``rename_lock`` and ``mount_lock`` are used to detect
 attacks against ".." resolution. Magic-links are also blocked.
