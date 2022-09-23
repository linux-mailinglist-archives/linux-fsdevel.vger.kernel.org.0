Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C829F5E7450
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Sep 2022 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiIWGoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Sep 2022 02:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiIWGop (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:44:45 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FCE20BD7
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 23:44:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 372D268AFE; Fri, 23 Sep 2022 08:44:39 +0200 (CEST)
Date:   Fri, 23 Sep 2022 08:44:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 02/29] fs: rename current get acl method
Message-ID: <20220923064438.GB16489@lst.de>
References: <20220922151728.1557914-1-brauner@kernel.org> <20220922151728.1557914-3-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922151728.1557914-3-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>   * Filesystems that store POSIX ACLs in the unaltered uapi format should use
>   * posix_acl_from_xattr() when reading them from the backing store and
>   * converting them into the struct posix_acl VFS format. The helper is
> - * specifically intended to be called from the ->get_acl() inode operation.
> + * specifically intended to be called from the ->get_inode_acl() inode operation.

Please avoid the overly long lines in the otherwise nicely formatted
block comments.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
