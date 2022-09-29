Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4518C5EF47C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Sep 2022 13:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiI2Lkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Sep 2022 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbiI2Lkt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Sep 2022 07:40:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85010F72A;
        Thu, 29 Sep 2022 04:40:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6D46268BFE; Thu, 29 Sep 2022 13:40:44 +0200 (CEST)
Date:   Thu, 29 Sep 2022 13:40:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 29/29] acl: remove a slew of now unused helpers
Message-ID: <20220929114044.GA19911@lst.de>
References: <20220928160843.382601-1-brauner@kernel.org> <20220928160843.382601-30-brauner@kernel.org> <20220929082555.GD3699@lst.de> <20220929082822.yhy7szlt3gpbqh34@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929082822.yhy7szlt3gpbqh34@wittgenstein>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 29, 2022 at 10:28:22AM +0200, Christian Brauner wrote:
> I would like to do this in a follow-up series because afaict we need to
> massage how the ->list() handler is currently used to infer xattrs
> support. I think adressing this in a follow-up series would be better.
> There'll be more cleanups possibly anyway, I think.

True, the weird list handling complicates things a bit.  But it is a lot
of dead wood now and we should clean it up rather sooner than later.
