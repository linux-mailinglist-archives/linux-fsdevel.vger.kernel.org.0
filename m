Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8F31C5F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbhBPEa3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhBPEa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:30:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C23C061574;
        Mon, 15 Feb 2021 20:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=H9OY+z/54FV5plu95Fpred7mYKFXTJiBUPnPnPb9ZTA=; b=ICHVoaC6XY053T2fL06UKCxFei
        hO+4jG+OXo67yjX5hVM/Jo8oNLDCyv5+4B6SLkiZ7wBALXcS36uqV1kz3H6m1QOYLGgrPDZU0YsSz
        K6vxDVYZz9Gx+M/YhVXRa610lMleB9SjxeyIFn+uCL6PKZ+eFqbnaXD8g633IYe7T0iDXlejBUpnN
        4q2ztqmnEmR6aElmsBan6qlmtzHryAuw6vXBrQkT7YYoJRr9t8ECwgnnftDbVr56gmemY2Z4YRbVr
        nOBEUazUJ5QRLX2mjQWvHS8SbJDxxOHSf9Ti5+r8oPpxNi6YJJKB38n/SWhI6sarLTAclFIJkIZvv
        zop+K2CA==;
Received: from [2601:1c0:6280:3f0::b669] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBrzT-0002nO-K7; Tue, 16 Feb 2021 04:29:36 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        "David P . Quigley" <dpquigl@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
Subject: [PATCH -next] fs: fix new and older kernel-doc warnings in fs/
Date:   Mon, 15 Feb 2021 20:29:26 -0800
Message-Id: <20210216042929.8931-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

 [PATCH -next] fs: libfs: fix kernel-doc for mnt_userns
 [PATCH -next] fs: namei: fix kernel-doc for struct renamedata and more
 [PATCH -next] fs: xattr: fix kernel-doc for mnt_userns and vfs xattr helpers

Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: David P. Quigley <dpquigl@tycho.nsa.gov>
Cc: James Morris <jmorris@namei.org>

 fs/libfs.c |    1 +
 fs/namei.c |   14 +++-----------
 fs/xattr.c |   14 ++++++++------
 3 files changed, 12 insertions(+), 17 deletions(-)
