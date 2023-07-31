Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60D9769896
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 15:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjGaN5A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 09:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjGaNzv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:55:51 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204CD2680;
        Mon, 31 Jul 2023 06:53:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D7B2367373; Mon, 31 Jul 2023 15:53:25 +0200 (CEST)
Date:   Mon, 31 Jul 2023 15:53:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        syzbot <syzbot+69c477e882e44ce41ad9@syzkaller.appspotmail.com>,
        chao@kernel.org, huyue2@coolpad.com, jack@suse.cz,
        jefflexu@linux.alibaba.com, linkinjeon@kernel.org,
        linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, sj1557.seo@samsung.com,
        syzkaller-bugs@googlegroups.com, xiang@kernel.org
Subject: Re: [syzbot] [erofs?] [fat?] WARNING in erofs_kill_sb
Message-ID: <20230731135325.GB6016@lst.de>
References: <000000000000f43cab0601c3c902@google.com> <20230731093744.GA1788@lst.de> <9b57e5f7-62b6-fd65-4dac-a71c9dc08abc@linux.alibaba.com> <20230731111622.GA3511@lst.de> <20230731-augapfel-penibel-196c3453f809@brauner> <20230731-unbeirrbar-kochen-761422d57ffc@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-unbeirrbar-kochen-761422d57ffc@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:22:28PM +0200, Christian Brauner wrote:
> Uh, no. I vasty underestimated how sensitive that change would be. Plus
> arguably ->kill_sb() really should be callable once the sb is visible.
> 
> Are you looking into this or do you want me to, Christoph?

I'm planning to look into it, but I won't get to it before tomorrow.
