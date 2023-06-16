Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40BE732864
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 09:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241899AbjFPHHY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 03:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjFPHHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:07:00 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BC35AA;
        Fri, 16 Jun 2023 00:06:42 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7ECC76732D; Fri, 16 Jun 2023 09:06:38 +0200 (CEST)
Date:   Fri, 16 Jun 2023 09:06:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v5 2/5] fs: use a helper for opening kernel internal
 files
Message-ID: <20230616070638.GB29590@lst.de>
References: <20230615112229.2143178-1-amir73il@gmail.com> <20230615112229.2143178-3-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615112229.2143178-3-amir73il@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 15, 2023 at 02:22:26PM +0300, Amir Goldstein wrote:
> +/**
> + * kernel_file_open - open a file for kernel internal use
> + * @path:	path of the file to open
> + * @flags:	open flags
> + * @inode:	the inode
> + * @cred:	credentials for open
> + *
> + * Open a file that is not accounted in nr_files.
> + * This is only for kernel internal use, and must not be installed into
> + * file tables or such.

This reads a litte odd.  How about:

 * Open a file for use by in-kernel consumers.  The file is not accounted
 * against nr_files and must not be installed into the file descriptor table.

With that:

Reviewed-by: Christoph Hellwig <hch@lst.de>
