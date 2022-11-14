Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49796275B4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Nov 2022 07:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiKNGCm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Nov 2022 01:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbiKNGCl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Nov 2022 01:02:41 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811001742F;
        Sun, 13 Nov 2022 22:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=htUX5wXsVqQtfEIzF3R3jTgb9FejL1nSejYDfcLYiAM=; b=eepvBu3sqqhQ0CAKocgxuXXL/9
        nd2dws1R3l0m73KbCd0ttqcgfh4qPI2YMh9ErnvjsTWnKFCbSOpssg9Ffg/8kuEhf4dE900Amdlt0
        bKg6WixEFZmNEWeI5QDJwO6gwOJyWvfQcNH2KuE+Rv0mpACVzMs1Gr2J0vShkvNjYLZVSYfvlK1s/
        iPsKrcEN8+WFkoP575vjnkid26ER/o+8J7OVbE3jZmeF2I5JYh4sbdBH40CMQWAt/SNYFS+HWNmHQ
        YfLLSRaCiEoPTo1NeD1ekUsLvROGaw0bL1ZjNl33pXvlwgkVLoJJ55GL/avtZw18m0SILmQILuOnG
        /WtZrV0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ouSYH-00GAaw-Gk; Mon, 14 Nov 2022 06:02:37 +0000
Date:   Sun, 13 Nov 2022 22:02:37 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Niels de Vos <ndevos@redhat.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo Li <xiubli@redhat.com>,
        Marcel Lauhoff <marcel.lauhoff@suse.com>
Subject: Re: [RFC 0/4] fs: provide per-filesystem options to disable fscrypt
Message-ID: <Y3HZ/To8z76vBqYo@infradead.org>
References: <20221110141225.2308856-1-ndevos@redhat.com>
 <Y20a/akbY8Wcy3qg@mit.edu>
 <Y20rDl45vSmdEo3N@ndevos-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y20rDl45vSmdEo3N@ndevos-x1>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:47:10PM +0100, Niels de Vos wrote:
> And, there actually are options like CONFIG_EXT4_FS_POSIX_ACL and
> CONFIG_EXT4_FS_SECURITY. Because these exist already, I did not expect
> too much concerns with proposing a CONFIG_EXT4_FS_ENCRYPTION...

ext4 is a little weird there as most file systems don't do that.
So I think these should go away for ext4 as well.

> Note that even with the additional options, enabling only
> CONFIG_FS_ENCRYPTION causes all the filesystems that support fscrypt to
> have it enabled. For users there is no change, except that they now have
> an option to disable fscrypt support per filesystem.

But why would you do that anyay?
