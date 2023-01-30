Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF29680611
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jan 2023 07:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbjA3Gij (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Jan 2023 01:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjA3Gig (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Jan 2023 01:38:36 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95BBE1ADE6
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Jan 2023 22:38:10 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8EFCB68BEB; Mon, 30 Jan 2023 07:38:07 +0100 (CET)
Date:   Mon, 30 Jan 2023 07:38:06 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>
Subject: Re: [PATCH 04/12] fs: drop unused posix acl handlers
Message-ID: <20230130063806.GE31145@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org> <20230125-fs-acl-remove-generic-xattr-handlers-v1-4-6cf155b492b6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-4-6cf155b492b6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:28:49PM +0100, Christian Brauner wrote:
> Remove struct posix_acl_{access,default}_handler for all filesystems
> that don't depend on the xattr handler in their inode->i_op->listxattr()
> method in any way. There's nothing more to do than to simply remove the
> handler. It's been effectively unused ever since we introduced the new
> posix acl api.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
