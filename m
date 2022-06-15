Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C11454C9A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 15:21:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346806AbiFONVx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 09:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiFONVw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:21:52 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43F3B02F;
        Wed, 15 Jun 2022 06:21:52 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A075B68AA6; Wed, 15 Jun 2022 15:21:47 +0200 (CEST)
Date:   Wed, 15 Jun 2022 15:21:47 +0200
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
Message-ID: <20220615132147.GA18252@lst.de>
References: <0000000000003ce9d105e0db53c8@google.com> <00000000000085068105e112a117@google.com> <20220613193912.GI20633@twin.jikos.cz> <20220614071757.GA1207@lst.de> <2cc67037-cf90-cca2-1655-46b92b43eba8@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cc67037-cf90-cca2-1655-46b92b43eba8@gmx.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 14, 2022 at 04:50:22PM +0800, Qu Wenruo wrote:
> The same way as data?
>
> map-logical to find the location of a mirror, write 4 bytes of zero into
> the location, then call it a day.
>
> Although for metadata, you may want to choose a metadata that would
> definitely get read.
> Thus tree root is a good candidate.

And how do I find out the logic address of the tree root?
