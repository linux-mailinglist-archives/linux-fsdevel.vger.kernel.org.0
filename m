Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14616770EE5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Aug 2023 10:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHEItB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Aug 2023 04:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjHEItA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Aug 2023 04:49:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6B4496;
        Sat,  5 Aug 2023 01:48:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4F83868AA6; Sat,  5 Aug 2023 10:48:55 +0200 (CEST)
Date:   Sat, 5 Aug 2023 10:48:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        syzbot <syzbot+2faac0423fdc9692822b@syzkaller.appspotmail.com>,
        jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] KASAN: slab-use-after-free Read in
 test_bdev_super_fc
Message-ID: <20230805084855.GA30135@lst.de>
References: <00000000000058d58e06020c1cab@google.com> <20230804101408.GA23274@lst.de> <20230804-abstieg-behilflich-eda2ce9c2c0f@brauner> <20230804140201.GA27600@lst.de> <20230804-allheilmittel-teleobjektiv-a0351a653d31@brauner> <20230804144343.GA28230@lst.de> <20230804-kurvigen-uninteressant-09d451db7458@brauner> <20230805084316.1699-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805084316.1699-1-hdanton@sina.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 05, 2023 at 04:43:16PM +0800, Hillf Danton wrote:
> Feel free to take a look at the approach [1] to the uaf.
> 
> [1] https://yhbt.net/lore/lkml/000000000000b08a42060221da36@google.com/

This doesn't make any sense whatsover.

