Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA7D5EBBBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Sep 2022 09:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiI0HlH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Sep 2022 03:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiI0HlG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:41:06 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7C9726AA;
        Tue, 27 Sep 2022 00:41:05 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A92C468AA6; Tue, 27 Sep 2022 09:41:01 +0200 (CEST)
Date:   Tue, 27 Sep 2022 09:41:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        v9fs-developer@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 00/30] acl: add vfs posix acl api
Message-ID: <20220927074101.GA17464@lst.de>
References: <20220926140827.142806-1-brauner@kernel.org> <99173046-ab2e-14de-7252-50cac1f05d27@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99173046-ab2e-14de-7252-50cac1f05d27@schaufler-ca.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 26, 2022 at 05:22:45PM -0700, Casey Schaufler wrote:
> I suggest that you might focus on the acl/evm interface rather than the entire
> LSM interface. Unless there's a serious plan to make ima/evm into a proper LSM
> I don't see how the breadth of this patch set is appropriate.

Umm. The problem is the historically the Linux xattr interface was
intended for unstructured data, while some of it is very much structured
and requires interpretation by the VFS and associated entities.  So
splitting these out and add proper interface is absolutely the right
thing to do and long overdue (also for other thing like capabilities).
It might make things a little more verbose for LSM, but it fixes a very
real problem.
