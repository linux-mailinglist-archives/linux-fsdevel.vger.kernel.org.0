Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A5276922D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 11:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjGaJrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 05:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjGaJrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:47:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994431FEE;
        Mon, 31 Jul 2023 02:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LFWu3GhIVYxTt3/DQYqycVt4qUBKEDLP9wXynzT3Bis=; b=4fcN+AQCGPO4EbumgV+MpLVVc8
        W2quamb7yQgvGgmYh7bOdTPdfRYNG+UslaI5iNQqqUmGh6E4rGyfgfYtzUp4WWActwAePa8iDxWxu
        M2ZRQojSLwUO2o9VgtlbqRWKxBes0jdZK8GRdMEFo12kIv3hEk4QvGIKUXkRZNwC+hkh2xGez5Jcb
        hxvcr9tBmUYCzX2WZBahYVrOo9/kTteKykAaiAApVJbA91tIZ0fJu5OBGOzn29AY9YqHWDqEsMkRz
        itHipUHriHvjjznd62X5UTYR2Ep576MI5Zbq2kpDrVfabNL77tyGH4CmbVgArcIbSol5JmKZlqHlJ
        r2VMBlFw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQPTk-00Eopt-2M;
        Mon, 31 Jul 2023 09:46:16 +0000
Date:   Mon, 31 Jul 2023 02:46:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+ae97a827ae1c3336bbb4@syzkaller.appspotmail.com>,
        clm@fb.com, dsterba@suse.com, johannes.thumshirn@wdc.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in prepare_to_merge
Message-ID: <ZMeC6BPCBT/5NR+S@infradead.org>
References: <000000000000a3d67705ff730522@google.com>
 <000000000000f2ca8f0601bef9ca@google.com>
 <20230731073707.GA31980@lst.de>
 <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <358fab94-4eaa-4977-dd69-fc39810f18e0@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks.  I've not been able to reproduce it on the apparent bisection
commit for more than half an hour, but running it on the originally
reported commit reproduces it after a few minutes.  I'll see if I
can come up with a better bisection.

