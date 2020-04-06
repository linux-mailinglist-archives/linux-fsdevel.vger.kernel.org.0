Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB2619FD59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 20:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgDFSmY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 14:42:24 -0400
Received: from nautica.notk.org ([91.121.71.147]:58684 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgDFSmY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:42:24 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id F03BAC01A; Mon,  6 Apr 2020 20:42:21 +0200 (CEST)
Date:   Mon, 6 Apr 2020 20:42:06 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200406184206.GA19275@nautica>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
 <20200406164641.GF21484@bombadil.infradead.org>
 <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
 <20200406173957.GI21484@bombadil.infradead.org>
 <CAHk-=wjh0szm+btaHptV1_XMMih=c1zP5wU8MQmREVKmJSYUcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjh0szm+btaHptV1_XMMih=c1zP5wU8MQmREVKmJSYUcA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds wrote on Mon, Apr 06, 2020:
> I think the O_NONBLOCK difference is one of the more benign ones.
> 
> I just think it should be documented more.

Hadn't explicitely added you in Ccs, but I did post something to
document it:
http://lkml.kernel.org/r/1586193572-1375-1-git-send-email-asmadeus@codewreck.org

(small enough to just quote:)
--------------
diff --git a/Documentation/filesystems/9p.txt b/Documentation/filesystems/9p.txt
index fec7144e817c..3fb780ffdf23 100644
--- a/Documentation/filesystems/9p.txt
+++ b/Documentation/filesystems/9p.txt
@@ -133,6 +133,16 @@ OPTIONS
 		cache tags for existing cache sessions can be listed at
 		/sys/fs/9p/caches. (applies only to cache=fscache)
 
+BEHAVIOR
+========
+
+This section aims at describing 9p 'quirks' that can be different
+from a local filesystem behaviors.
+
+ - Setting O_NONBLOCK on a file will make client reads return as early
+   as the server returns some data instead of trying to fill the read
+   buffer with the requested amount of bytes or end of file is reached.
+
 RESOURCES
 =========

--------------

Will submit the pull request again with that in a couple of days unless
anything bad happens.

Thanks,
-- 
Dominique
