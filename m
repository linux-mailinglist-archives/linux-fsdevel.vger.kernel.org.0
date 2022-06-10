Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C471B546DED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347704AbiFJUCD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 16:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243403AbiFJUCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 16:02:01 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F404E1D684B;
        Fri, 10 Jun 2022 13:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0Meosg3lX9flrP9hYlrxrfXhTag0CE4ZvWEx4YYw4Do=; b=O2tqntMKqPoTwqNOZHH5F7J60L
        38/yWRUzPqNSndZK59frPwgOX9WNjVnCpT2D9ObebXD18kSDUG3+lQd4y+Jyw3nwfhSKNevLQdRwv
        NQodCulSDsGHXmSnp+6IeaFv44lAIffWf/5e2n7DspyVLMgtfSbFIt3hXrwLC6+paC8BQJ0FOcFs4
        oyClM2K84KuJmxtvcfIq3lPQvycioHLh86927Jy25Xv5mbQ4ptu3tGZGdk+ldGGYUEMwPl6VBTn1k
        XGfwCmm7D7MsvJgRJXQOfANV3/nITEi3AzX25kVQLaAJV2MMvjHCKfcgErEP+q5f9WnPwdH7qNq4W
        EtLrYGsw==;
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzkpO-005re9-Df; Fri, 10 Jun 2022 20:01:54 +0000
Date:   Fri, 10 Jun 2022 20:01:54 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>
Subject: [git pull] iov_iter fix
Message-ID: <YqOjMvUlZKpeYg76@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to 6c77676645ad42993e0a8bdb8dafa517851a352a:

  iov_iter: Fix iter_xarray_get_pages{,_alloc}() (2022-06-10 15:56:32 -0400)

----------------------------------------------------------------
ITER_XARRAY get_pages fix; now the return value is a lot saner
(and more similar to logics for other flavours)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

----------------------------------------------------------------
David Howells (1):
      iov_iter: Fix iter_xarray_get_pages{,_alloc}()

 lib/iov_iter.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)
