Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506B76B898
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Aug 2023 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjHAPbJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Aug 2023 11:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjHAPbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:31:07 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A32EE
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Aug 2023 08:31:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4C9626732D; Tue,  1 Aug 2023 17:31:01 +0200 (CEST)
Date:   Tue, 1 Aug 2023 17:31:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>, Karel Zak <kzak@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] super: remove get_tree_single_reconf()
Message-ID: <20230801153100.GB12035@lst.de>
References: <20230801-vfs-super-exclusive-v1-0-1a587e56c9f3@kernel.org> <20230801-vfs-super-exclusive-v1-1-1a587e56c9f3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-vfs-super-exclusive-v1-1-1a587e56c9f3@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 01, 2023 at 03:09:00PM +0200, Christian Brauner wrote:
> The get_tree_single_reconf() helper isn't used anywhere. Remote it.

Yeah, I've got pretty much the same patch hiding somewhere in one of
me trees..

> -static int vfs_get_super(struct fs_context *fc, bool reconf,
> -		int (*test)(struct super_block *, struct fs_context *),
> -		int (*fill_super)(struct super_block *sb,
> -				  struct fs_context *fc))
> +static int vfs_get_super(struct fs_context *fc,
> +			 int (*test)(struct super_block *, struct fs_context *),
> +			 int (*fill_super)(struct super_block *sb,
> +					   struct fs_context *fc))

.a althought keeping the existing formatting here seems much more readable
to me.  No idea why the odd align to brace formatting has picked up so
many fans recently given that it is horrible to read and causes tons
of churn when touching the protoptype or function name.

