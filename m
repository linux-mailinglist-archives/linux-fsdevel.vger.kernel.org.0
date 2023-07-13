Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC7D752043
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jul 2023 13:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbjGMLlk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jul 2023 07:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbjGMLlF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:41:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99C62D4C;
        Thu, 13 Jul 2023 04:40:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 908F36732D; Thu, 13 Jul 2023 13:40:29 +0200 (CEST)
Date:   Thu, 13 Jul 2023 13:40:29 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Florian Weimer <fweimer@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] attr: block mode changes of symlinks
Message-ID: <20230713114029.GA23375@lst.de>
References: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712-vfs-chmod-symlinks-v2-1-08cfb92b61dd@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

one minor nitpick below:

>  	if ((ia_valid & ATTR_MODE)) {
> +		if (S_ISLNK(inode->i_mode))
> +			return -EOPNOTSUPP;

Maybe some of the rationale on why we have this check from the commit
log should go here?

