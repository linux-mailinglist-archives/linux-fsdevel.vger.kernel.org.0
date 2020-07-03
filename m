Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942B2214104
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGCVni (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVni (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:43:38 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D521AC061794;
        Fri,  3 Jul 2020 14:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=DSkLdwA8XxSZdlvPiriZ+UIh2jMZmNiuIw4Gi/uxGAg=; b=Xd2zq2HkI3a0FU1VBBjtPJvqTX
        CGXLZmLSDI3L5qG/DVedVDS5awYqCdV1BFqob+4VuvTrTnrUkb0EXjDT64f27cLBrSSCioggLdi3A
        SSaCaup+QndnrggX7aX3O/n6wXHjDe4GAXQWqwduGnAEsJRbhHjtYCo+PErhJukhbXxlgA+uA/tAN
        4NAM3YHXlgfQ7lhOGj0Y7+x2iXQE+CVqXFoDWbfBZeUekvHMK4fMsHG861Tz6daghBjgf8IzcwDJ6
        lLvzSkJTgJEEdKOMP5wAhkXr1GHC1GpjcTM54CtMm0KALo+ln3Y4Tw7A0HwryPVWrfKLvsFgPUrtY
        ZhXUP3TA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTT2-0006uZ-8p; Fri, 03 Jul 2020 21:43:32 +0000
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
Subject: [PATCH 00/10] Documentation: filesystems: eliminate duplicated words
Date:   Fri,  3 Jul 2020 14:43:15 -0700
Message-Id: <20200703214325.31036-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix doubled words in filesystems files.


Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cachefs@redhat.com
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: linux-fscrypt@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org


 Documentation/filesystems/autofs-mount-control.rst |    6 +++---
 Documentation/filesystems/caching/operations.rst   |    2 +-
 Documentation/filesystems/configfs.rst             |    2 +-
 Documentation/filesystems/directory-locking.rst    |    4 ++--
 Documentation/filesystems/fsverity.rst             |    2 +-
 Documentation/filesystems/mount_api.rst            |    4 ++--
 Documentation/filesystems/overlayfs.rst            |    2 +-
 Documentation/filesystems/path-lookup.rst          |    2 +-
 Documentation/filesystems/sysfs-tagging.rst        |    2 +-
 Documentation/filesystems/vfs.rst                  |    4 ++--
 10 files changed, 15 insertions(+), 15 deletions(-)
