Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 076E57924FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Sep 2023 18:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjIEQAm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Sep 2023 12:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353735AbjIEHpH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:45:07 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8F11A8;
        Tue,  5 Sep 2023 00:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I2yPyO8KwTzZJAloQMQFXyE6w4H4gDLyPF/VUjujH9w=; b=D6ocNZPrq6CZLc+BgM93gNO0a8
        +mhp354GNUvRRmHjR/LyrZO531zXKlzD3Ut94MIzFGnbvX5Rlr8ukph2bMJ9ooyR1kRg0twVcIlpU
        XTK6YQRP8yN5ZBbRekcLCOt2ohx7zIzlu93T6I2YuGx7h8RV4Ycjf+ZJPe0vbE6HHK5QrxDwvy0Ww
        i6WF8aTlk/rV/ksu1KK6BWJhaGeFm1bQrspk9AFYQuq7t/P4tpXygb1Qpioqh00uet/Yq9qTt50XU
        V+Zu+DVfx9y1VVyhiaEAtxuH+az+MJnaMptBB28lZU4LWGd0FgqlIHM2POmpv8YLObDxEBufjNjiO
        7Fo2FXFg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qdQk1-005SWK-33;
        Tue, 05 Sep 2023 07:44:53 +0000
Date:   Tue, 5 Sep 2023 00:44:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yukuai3@huawei.com, zhang_shurong@foxmail.com
Subject: Re: [syzbot] [xfs?] [ext4?] kernel BUG in __block_write_begin_int
Message-ID: <ZPbcdagjHgbBE6A8@infradead.org>
References: <000000000000e76944060483798d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e76944060483798d@google.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syz test: git://git.infradead.org/users/hch/misc.git bdev-iomap-fix
