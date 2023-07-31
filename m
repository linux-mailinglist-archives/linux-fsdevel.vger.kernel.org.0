Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D215B7691E6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 11:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjGaJiQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGaJhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:37:54 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC92E5;
        Mon, 31 Jul 2023 02:37:48 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C14EF67373; Mon, 31 Jul 2023 11:37:44 +0200 (CEST)
Date:   Mon, 31 Jul 2023 11:37:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>
Cc:     brauner@kernel.org, chao@kernel.org, hch@lst.de,
        huyue2@coolpad.com, jack@suse.cz, jefflexu@linux.alibaba.com,
        linkinjeon@kernel.org, linux-erofs@lists.ozlabs.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com,
        xiang@kernel.org
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731093744.GA1788@lst.de>
References: <000000000000f43cab0601c3c902@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f43cab0601c3c902@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:57:58AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    d7b3af5a77e8 Add linux-next specific files for 20230728

Hmm, the current linux-next tree does not seem to have that commit ID
any more, and the line numbers don't match up.  I think it is the
WARN_ON for the magic, which could probably be just removed.  I'll
try the reproducers when I find a bit more time.
