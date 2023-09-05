Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF217924F8
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbjIEQA1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354667AbjIENYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:24:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF7219B;
        Tue,  5 Sep 2023 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2vn5XzjfQDcWzDLzrmQFA42UoCE2sIZWa4+FNI+mFbc=; b=fkUSasaVNhoNIK5qi7FZYBxcOb
        tF7fYVKbMdiAUt4ohs+KDLajQnW0vRNZlsd9t1l3QW8T7LqDEpUI3ZwzglHbB9NbB+QroWlY8YAQQ
        2vFB9JcHrnNbPzgxbgkaeg2N/U4xk/2FL3oLn+yFewbp2X2M8guA0HQXc/7tZJ/cBI+LDw/WPDYu5
        O3DwDmNdV4yHhH8V0MwmVo9pjEpb9aXC6vKi2y3eI+yi8vMArRLnpTWY3qxU5f6jViHrSYYQb484a
        8+F8dtbHrj2H3xWT9wPeKl3AOsbV3n1HZWsBo5L88zhvDDv6XOtQsinyxhzIEu91y+pxg5el5oRRN
        j193bTiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qdW2x-0065cZ-3D;
        Tue, 05 Sep 2023 13:24:48 +0000
Date:   Tue, 5 Sep 2023 06:24:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Christian Brauner <christian@brauner.io>
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZPcsHyWOHGJid82J@infradead.org>
References: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903032555.np6lu5mouv5tw4ff@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Kent,

I thought you'd follow Christians proposal to actually work with
people to try to use common APIs (i.e. to use iomap once it's been
even more iter-like, for which I'm still waiting for suggestions),
and make your new APIs used more widely if they are a good idea
(which also requires explaining them better) and aim for 6.7 once
that is done.

But without that, and without being in linux-next and the VFS maintainer
ACK required for I think this is a very bad idea.
