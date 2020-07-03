Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00B0214138
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgGCVoX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGCVoX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:44:23 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D6C061794;
        Fri,  3 Jul 2020 14:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=l2BgVRrhoOdfEaISQXm1bK19K/APf6om9UNXwiHsPO0=; b=TJaW7ulgeNqNF0cPjPw4MsUVNF
        yfdL+Lxhuges+yTUAWuLc9NuC0ZoUj3AZU+sSEZAOXgwOOFenIKOjVDGkGh/bySX10kZptjVCyi6L
        mcU5jDslUFp7G0rwVl3FgIUAZsRWub40wbEOqSHFCj+DVwprEX9yrb18SquoqM4IUPJkan9+4lKcy
        aadqYoyKqMOlXYaqjzuYz/6m+J7AWmfAZo20FStZX+R+DmPr9Ro06+NzHU7IaicKmU7XEtT+DmqLE
        7nA643wa8bca5oaky7wMg9PLQ+oU0PyNKqplDdhonPLEnba5V+62izf71qr1tUg+wZfpcOueM0EYT
        mBRBfj6w==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTo-0006uZ-1P; Fri, 03 Jul 2020 21:44:20 +0000
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
Subject: [PATCH 09/10] Documentation: filesystems: sysfs-tagging: drop doubled word
Date:   Fri,  3 Jul 2020 14:43:24 -0700
Message-Id: <20200703214325.31036-10-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/sysfs-tagging.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/sysfs-tagging.rst
+++ linux-next-20200701/Documentation/filesystems/sysfs-tagging.rst
@@ -15,7 +15,7 @@ To avoid that problem and allow existing
 namespaces to see the same interface that is currently presented in
 sysfs, sysfs now has tagging directory support.
 
-By using the network namespace pointers as tags to separate out the
+By using the network namespace pointers as tags to separate out
 the sysfs directory entries we ensure that we don't have conflicts
 in the directories and applications only see a limited set of
 the network devices.
