Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53F4727823
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 09:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjFHHFk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 03:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjFHHFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:05:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7889E;
        Thu,  8 Jun 2023 00:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g2/hQXZg2qB5kM3tDsD/tthCg60uglJHUq1JT2NLINM=; b=2ilSKYuZyu0HI7WQ/qxaNqUIqH
        iYyy2h0fdKx6dlwDcQfQvb+7uyJfUVK3m4MacMBc2We/iuv+g6dm3yQA2HqNnnBOZeRKLkzu5fLQk
        +h6kcvh72XPZOpFzSzA7gXHKqgj0N9TLxnIkvSgzTLGCRICafIUwlMLiN6Q/YFFJbusI/RUWXtS/i
        9KdWG9DMKGzFUNLwAZ86C8TcWfDeLo0NSEevrxfUhcqJvBTUqf7IG5+qgO5ZcKrQQ4u1H3LVqMnSW
        Un74UVUC46dR0geMAsiBYl8uYq744aT3rCboQzp7928dJ5wem8wfF5Aa11MjKRg8hYGXcHIDvtD2l
        R4+PiY0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q79iB-008Lbl-10;
        Thu, 08 Jun 2023 07:05:35 +0000
Date:   Thu, 8 Jun 2023 00:05:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+ee90502d5c8fd1d0dd93@syzkaller.appspotmail.com>
Cc:     clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING in btrfs_split_ordered_extent
Message-ID: <ZIF9v+qcdhhuYsMr@infradead.org>
References: <00000000000009ee1005fc425b4b@google.com>
 <00000000000071812e05fd92bcef@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000071812e05fd92bcef@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_NONE,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

#syz test: git://git.infradead.org/users/hch/misc.git btrfs-dio-nocow-fix

