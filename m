Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC35EF05A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 10:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235325AbiI2I0J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbiI2IZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:25:59 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86345A5715;
        Thu, 29 Sep 2022 01:25:58 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E213268BFE; Thu, 29 Sep 2022 10:25:55 +0200 (CEST)
Date:   Thu, 29 Sep 2022 10:25:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 29/29] acl: remove a slew of now unused helpers
Message-ID: <20220929082555.GD3699@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-30-brauner@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928160843.382601-30-brauner@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 28, 2022 at 06:08:43PM +0200, Christian Brauner wrote:
> Now that the posix acl api is active we can remove all the hacky helpers
> we had to keep around for all these years and also remove the set and
> get posix acl xattr handler methods as they aren't needed anymore.

I think we can also remove all the xattr handlers for ACLs now, can't we?
