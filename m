Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3432D54DABE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jun 2022 08:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359144AbiFPGfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jun 2022 02:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiFPGfP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:35:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0729F56770;
        Wed, 15 Jun 2022 23:35:15 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CDB3E68AA6; Thu, 16 Jun 2022 08:35:10 +0200 (CEST)
Date:   Thu, 16 Jun 2022 08:35:10 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@lst.de>, dsterba@suse.cz,
        syzbot <syzbot+d2dd123304b4ae59f1bd@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, clm@fb.com, dsterba@suse.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        willy@infradead.org
Subject: Re: [syzbot] KASAN: use-after-free Read in
 copy_page_from_iter_atomic (2)
Message-ID: <20220616063510.GA5608@lst.de>
References: <0000000000003ce9d105e0db53c8@google.com> <00000000000085068105e112a117@google.com> <20220613193912.GI20633@twin.jikos.cz> <20220614071757.GA1207@lst.de> <2cc67037-cf90-cca2-1655-46b92b43eba8@gmx.com> <20220615132147.GA18252@lst.de> <00bbda63-dc00-05c0-4244-343352591d98@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00bbda63-dc00-05c0-4244-343352591d98@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 16, 2022 at 05:27:04AM +0800, Qu Wenruo wrote:
>> And how do I find out the logic address of the tree root?
>
> For tree root, "btrfs ins dump-super <dev> | grep '^root\s'.
>
> For other tree blocks, "btrfs ins dump-tree <dev>" then with other other
> keywords to grab.

Thanks a lot !
