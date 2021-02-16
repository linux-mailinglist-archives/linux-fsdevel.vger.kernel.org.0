Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7A831C5F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 05:31:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbhBPEa2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Feb 2021 23:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhBPEa1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Feb 2021 23:30:27 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAD8C061756;
        Mon, 15 Feb 2021 20:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mt2j/t8v7/BZIta1sgcbrICjqe7SztTC8D9I62vs2Uw=; b=IktuSPpve6nhxlvvHBxJA0cNs8
        ZlzjnJI74jd8xDJLbgWi5A5SVj5ehKH/iiqSmAi7oGm4jiervoXOq32ZVkyDQROKmCktSOk6IRi+m
        CRQrIF2F/EvzfSgwu67NEk3xaS0XVREZtSlZkPvY0uDUc9Qw1izj8fRjHnXPsCAaUohVqULgQcnHV
        zcFPtE3EtkvpcRr0QtBu1tvalvnLUyM8TIVPhHkBxSjoxklQp7DQe087F9vpqpJEfocEv5WGTNjan
        7/pfwQlLkLhOB+FiSt6cCjmmdgJDRALOF3+MT2+Ou6td3PiKiUnIkJ+9CThs3n211ZoBYmQyZrOGv
        dDq1L4DA==;
Received: from [2601:1c0:6280:3f0::b669] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lBrzX-0002nO-7U; Tue, 16 Feb 2021 04:29:39 +0000
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
Subject: [PATCH -next] fs: libfs: fix kernel-doc for mnt_userns
Date:   Mon, 15 Feb 2021 20:29:27 -0800
Message-Id: <20210216042929.8931-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210216042929.8931-1-rdunlap@infradead.org>
References: <20210216042929.8931-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix kernel-doc warning in libfs.c.

../fs/libfs.c:498: warning: Function parameter or member 'mnt_userns' not described in 'simple_setattr'

Fixes: 549c7297717c ("fs: make helpers idmap mount aware")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <christian.brauner@ubuntu.com>
---
 fs/libfs.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20210215.orig/fs/libfs.c
+++ linux-next-20210215/fs/libfs.c
@@ -481,6 +481,7 @@ EXPORT_SYMBOL(simple_rename);
 
 /**
  * simple_setattr - setattr for simple filesystem
+ * @mnt_userns: user namespace of the target mount
  * @dentry: dentry
  * @iattr: iattr structure
  *
