Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C17E6866F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjBANbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232280AbjBANbY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:31:24 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225AE65EF8;
        Wed,  1 Feb 2023 05:30:51 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A80D468AA6; Wed,  1 Feb 2023 14:30:20 +0100 (CET)
Date:   Wed, 1 Feb 2023 14:30:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org,
        linux-mtd@lists.infradead.org, reiserfs-devel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v3 00/10] acl: drop posix acl handlers from xattr
 handlers
Message-ID: <20230201133020.GA31902@lst.de>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This version looks good to me, but I'd really prefer if a reiserfs
insider could look over the reiserfs patches.
