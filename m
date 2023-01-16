Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 520E266B7C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jan 2023 08:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjAPHFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 02:05:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjAPHFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 02:05:18 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770367EEB
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Jan 2023 23:05:17 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 61BC168AFE; Mon, 16 Jan 2023 08:05:14 +0100 (CET)
Date:   Mon, 16 Jan 2023 08:05:14 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org,
        "Seth Forshee (Digital Ocean)" <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 03/25] fs: port ->setattr() to pass mnt_idmap
Message-ID: <20230116070514.GB15498@lst.de>
References: <20230113-fs-idmapped-mnt_idmap-conversion-v1-0-fc84fa7eba67@kernel.org> <20230113-fs-idmapped-mnt_idmap-conversion-v1-3-fc84fa7eba67@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113-fs-idmapped-mnt_idmap-conversion-v1-3-fc84fa7eba67@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 13, 2023 at 12:49:11PM +0100, Christian Brauner wrote:
> +extern int			 affs_notify_change(struct mnt_idmap *idmap,
>  					struct dentry *dentry, struct iattr *attr);

Please drop the pointless externs for anything you touch in the
series.

> +extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);

I'd also fix up the very odd opening brace formatting in ext2 while
you're at it, which is only used inconsistently anyway.
