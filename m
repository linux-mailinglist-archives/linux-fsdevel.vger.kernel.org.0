Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBC5224825
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jul 2020 04:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbgGRCyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 22:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgGRCyq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:54:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72373C0619D2;
        Fri, 17 Jul 2020 19:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Q9NZ4VS0Tkgc6xAaH+4+rvYNPMxXO74kaCIC3MVBWYo=; b=hMR9rqTu03WJqzgN7B1dY0Cpk2
        9L+twrL+DjELSLdi/xxwlWBT8c5ZLIfT661/QDEP9IPyVyGhBnQsc/J30dsBW+bpSGpzrzBvOk4mE
        u3TQZKU7+/xL1yJH+TBPkmVA6T/2mXx17kh8hBcJHbmtoMOzfulMC4FBCGr3Iu4RGDTiixjseTkcw
        IlYlk5Htwbjrb8qnPy8JMmTvRYdEheUEMKa+GFVSZk1hXiA60ICfG4Nffx6DI0xgocD6m9+T/ecSn
        P28xM0uSfuLgB467TbSoUyvPIut8XMSyj/q3X6Og0CJwG7S96uMIfojYnso2we6ob8e0Z/xt2wziz
        6GGSUshQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwczs-0006nV-ET; Sat, 18 Jul 2020 02:54:44 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] linux/exportfs.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Message-ID: <c61b707a-8fd8-5b1b-aab0-679122881543@infradead.org>
Date:   Fri, 17 Jul 2020 19:54:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "a" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/exportfs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/exportfs.h
+++ linux-next-20200714/include/linux/exportfs.h
@@ -178,7 +178,7 @@ struct fid {
  * get_name:
  *    @get_name should find a name for the given @child in the given @parent
  *    directory.  The name should be stored in the @name (with the
- *    understanding that it is already pointing to a a %NAME_MAX+1 sized
+ *    understanding that it is already pointing to a %NAME_MAX+1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
  *    or error.  @get_name will be called without @parent->i_mutex held.
  *

