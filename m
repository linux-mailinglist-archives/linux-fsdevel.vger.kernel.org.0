Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E7857E460
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jul 2022 18:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235699AbiGVQaK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jul 2022 12:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235627AbiGVQaD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:30:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B61692854;
        Fri, 22 Jul 2022 09:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=rSECiOLEGBlvE2WTO5CHndncsAeIAvbvizD2cc+Nr8U=; b=Js2WwYV/jaCg+8Z2sPKjo8aXK5
        cwLzycbqzhe83ZRIMU0ipmsYHzorP4S/eQoCPI49kYdW1D4Rbheydx6IfwQ+J2ZaxKazDlT1uvOTQ
        6Po64ptbnu8oZB1vlIxcPO3bJIOwiNNKEn5qMN410f2m1DzqT+R1824bgoEKzGbth7hv6Pt2EV4nX
        rBzs+QA+ljkXb6zL5FdhLT3p2w2A/f8Vtf9wEgPval9K66f9abpdwdfS0ww+V7Eq1yPLhCIJQWBd1
        qReELijBf6kyUTEZYkNyrZ1MCyPT7Wc27TRmcfrXznZWXm1idu+Okg48KoXqW2VE9E5Wrl0s1IRmu
        CCvOGPUA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oEvX1-007vOf-As; Fri, 22 Jul 2022 16:29:39 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, corbet@lwn.net, keescook@chromium.org,
        yzaikin@google.com
Cc:     songmuchun@bytedance.com, zhangyuchen.lcr@bytedance.com,
        dhowells@redhat.com, deepa.kernel@gmail.com, hch@lst.de,
        mcgrof@kernel.org, linux-doc@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] Documentation/filesystems/proc.rst: remove ancient boiler plate
Date:   Fri, 22 Jul 2022 09:29:33 -0700
Message-Id: <20220722162934.1888835-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220722162934.1888835-1-mcgrof@kernel.org>
References: <20220722162934.1888835-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The proc.rst has some ancient verbiage which dates back to 1999
which is simply just creating noise at this point for documentation.
Remove that cruft.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Documentation/filesystems/proc.rst | 55 ------------------------------
 1 file changed, 55 deletions(-)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 47e95dbc820d..9fd5249f1a5f 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -4,22 +4,8 @@
 The /proc Filesystem
 ====================
 
-=====================  =======================================  ================
-/proc/sys              Terrehon Bowden <terrehon@pacbell.net>,  October 7 1999
-                       Bodo Bauer <bb@ricochet.net>
-2.4.x update	       Jorge Nerin <comandante@zaralinux.com>   November 14 2000
-move /proc/sys	       Shen Feng <shen@cn.fujitsu.com>	        April 1 2009
-fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
-=====================  =======================================  ================
-
-
-
 .. Table of Contents
 
-  0     Preface
-  0.1	Introduction/Credits
-  0.2	Legal Stuff
-
   1	Collecting System Information
   1.1	Process-Specific Subdirectories
   1.2	Kernel data
@@ -56,47 +42,6 @@ fixes/update part 1.1  Stefani Seibold <stefani@seibold.net>    June 9 2009
 Preface
 =======
 
-0.1 Introduction/Credits
-------------------------
-
-This documentation is  part of a soon (or  so we hope) to be  released book on
-the SuSE  Linux distribution. As  there is  no complete documentation  for the
-/proc file system and we've used  many freely available sources to write these
-chapters, it  seems only fair  to give the work  back to the  Linux community.
-This work is  based on the 2.2.*  kernel version and the  upcoming 2.4.*. I'm
-afraid it's still far from complete, but we  hope it will be useful. As far as
-we know, it is the first 'all-in-one' document about the /proc file system. It
-is focused  on the Intel  x86 hardware,  so if you  are looking for  PPC, ARM,
-SPARC, AXP, etc., features, you probably  won't find what you are looking for.
-It also only covers IPv4 networking, not IPv6 nor other protocols - sorry. But
-additions and patches  are welcome and will  be added to this  document if you
-mail them to Bodo.
-
-We'd like  to  thank Alan Cox, Rik van Riel, and Alexey Kuznetsov and a lot of
-other people for help compiling this documentation. We'd also like to extend a
-special thank  you to Andi Kleen for documentation, which we relied on heavily
-to create  this  document,  as well as the additional information he provided.
-Thanks to  everybody  else  who contributed source or docs to the Linux kernel
-and helped create a great piece of software... :)
-
-If you  have  any comments, corrections or additions, please don't hesitate to
-contact Bodo  Bauer  at  bb@ricochet.net.  We'll  be happy to add them to this
-document.
-
-The   latest   version    of   this   document   is    available   online   at
-http://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html
-
-If  the above  direction does  not works  for you,  you could  try the  kernel
-mailing  list  at  linux-kernel@vger.kernel.org  and/or try  to  reach  me  at
-comandante@zaralinux.com.
-
-0.2 Legal Stuff
----------------
-
-We don't  guarantee  the  correctness  of this document, and if you come to us
-complaining about  how  you  screwed  up  your  system  because  of  incorrect
-documentation, we won't feel responsible...
-
 Chapter 1: Collecting System Information
 ========================================
 
-- 
2.35.1

