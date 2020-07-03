Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BF214107
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGCVnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgGCVnl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:43:41 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA07C061794;
        Fri,  3 Jul 2020 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=PnMFSg5r6SGBqwW7k5DprCUnJT0eOsAtrGNbNi3wI6k=; b=CWmIynj7XkK69bfSe1uY4DZBG/
        legw/0NwX6WbaQmhdpmZQesBgkMnlhDpwyuTwSc9Z4wtBN/gFpLh+LiUpSMAvPp+iRHa50f2LpsgT
        26kll7uu9C7B1sfHoufOQkT17PngiLEZc3EBmD7qArn4W5Q3SoOVSayRftyEOG+68sSks2LYHqOAC
        dIFoQH9p4RSwReN8SatiAsfO4S/YAXelYrpm1C8BMWayf4OeivaHP/+WZmg82AUlOObM+imKfjobI
        xnvWw+Q/55PsV7RLc4PxOVrc8Zstgcz5+sIOXFc/K4/hpya54egjNsBAIZBsIPUyuWcD4zD9T35LQ
        7b9oNTYA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTT7-0006uZ-Sh; Fri, 03 Jul 2020 21:43:38 +0000
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
Subject: [PATCH 01/10] Documentation: filesystems: autofs-mount-control: drop doubled words
Date:   Fri,  3 Jul 2020 14:43:16 -0700
Message-Id: <20200703214325.31036-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled words "the" and "and".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
---
 Documentation/filesystems/autofs-mount-control.rst |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200701.orig/Documentation/filesystems/autofs-mount-control.rst
+++ linux-next-20200701/Documentation/filesystems/autofs-mount-control.rst
@@ -391,7 +391,7 @@ variation uses the path and optionally i
 set to an autofs mount type. The call returns 1 if this is a mount point
 and sets out.devid field to the device number of the mount and out.magic
 field to the relevant super block magic number (described below) or 0 if
-it isn't a mountpoint. In both cases the the device number (as returned
+it isn't a mountpoint. In both cases the device number (as returned
 by new_encode_dev()) is returned in out.devid field.
 
 If supplied with a file descriptor we're looking for a specific mount,
@@ -399,12 +399,12 @@ not necessarily at the top of the mounte
 the descriptor corresponds to is considered a mountpoint if it is itself
 a mountpoint or contains a mount, such as a multi-mount without a root
 mount. In this case we return 1 if the descriptor corresponds to a mount
-point and and also returns the super magic of the covering mount if there
+point and also returns the super magic of the covering mount if there
 is one or 0 if it isn't a mountpoint.
 
 If a path is supplied (and the ioctlfd field is set to -1) then the path
 is looked up and is checked to see if it is the root of a mount. If a
 type is also given we are looking for a particular autofs mount and if
-a match isn't found a fail is returned. If the the located path is the
+a match isn't found a fail is returned. If the located path is the
 root of a mount 1 is returned along with the super magic of the mount
 or 0 otherwise.
