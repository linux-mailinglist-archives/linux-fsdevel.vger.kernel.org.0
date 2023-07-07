Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A06C74AFD7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 13:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjGGLbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 07:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGLbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 07:31:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174D21FF7;
        Fri,  7 Jul 2023 04:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KpSpXs9rtc8KwTa+oS0VvDtRGTMNvkl1rRk7t5RvaaM=; b=lMkIRH8IGSGjDup/13hfZVuoke
        LUJt/K8OovVETbtxg8qSlZ1A6gFYfvjzU+lTYEH8sN0xjNGiwYhW7pnRg0vxP8ovk4kyhO31SApF9
        nB1DGQTJ5szVWDFLpyCPXpi8evPUy282UTud9QRGXTJWY6IG4+28rO/jFh3F4ea9ol5SyRL0RbOHx
        nxI1rZry/wVn5Nh6zJSSayyfv0bmALwr398ToWuslRCrJgEDpSCHSalk+43PHALQGxCZLRWagcIeQ
        FedTbA4//e5LJQxEZc2vWrC6IMKUr/A2eTdb7e19szgqzY5lCK6IIpBDcn6BLeGTQ0dmd79Q+HadW
        lr9r4lkQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qHjg3-004WGE-1Q;
        Fri, 07 Jul 2023 11:31:07 +0000
Date:   Fri, 7 Jul 2023 04:31:07 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Kees Cook <keescook@google.com>,
        Ted Tso <tytso@mit.edu>,
        syzkaller <syzkaller@googlegroups.com>,
        Alexander Popov <alex.popov@linux.com>,
        Eric Biggers <ebiggers@google.com>, linux-xfs@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH 6/6] fs: Make bind mounts work with
 bdev_allow_write_mounted=n
Message-ID: <ZKf3ezb4/XMwg+3a@infradead.org>
References: <20230704122727.17096-1-jack@suse.cz>
 <20230704125702.23180-6-jack@suse.cz>
 <ZKbj5v4VKroW7cFp@infradead.org>
 <20230706161255.t33v2yb3qrg4swcm@quack3>
 <20230707-mitangeklagt-erdumlaufbahn-688d4f493451@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707-mitangeklagt-erdumlaufbahn-688d4f493451@brauner>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 07, 2023 at 09:39:05AM +0200, Christian Brauner wrote:
> Can you do this rework independent of the bdev_handle work that you're
> doing so this series doesn't depend on the other work and we can get
> the VFS bits merged for this?

It really should be before it.  I have a few other things related to
it, so if Jan doesn't mind I'd be happy to take it over and post a
series with a version of this and some sget and get_super rework.
