Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FC077695F4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 14:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGaMTA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 08:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjGaMS7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:18:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01ED11D;
        Mon, 31 Jul 2023 05:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jSyYjhYdZcUtB7zIWOVgg0QSfWsSomOTfr1276ffkoM=; b=kXfq3lYFapXPWhONRjbU2/a1vN
        gEeZaakU1dr57DQfxQpFhHNCwAeoSNE1V/BnHLr8Q8i5ByF411ulJh2ItegDVfY3IFz+Jtyk+LjiD
        jbKXwFmdpCtWXvDVdPRw1lXgHBi9AI4VSnmlwjnvssNPkYRqRhFvBVop4TXonPxiSD/EBA4PJ9sUG
        q1VPCA+PJYcdr14UvM0VjFXNqh26h4BZ2uL9We3v4TgNHX2Tk0cMaL71WMT8thY7dzcQ45/bcG/Vd
        tH9rPmu8mrlWrnYrpRXGIHMjNLM66qEE6qSt7ItW83nt8tR5umD48b5ALkPjQJ+8tQqpd8co+O6RS
        OesBheew==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qQRrT-001Z9R-6x; Mon, 31 Jul 2023 12:18:55 +0000
Date:   Mon, 31 Jul 2023 13:18:55 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] fs: fix request_mask variable in generic_fillattr
 kerneldoc comment
Message-ID: <ZMemr1EzBCRrvv3g@casper.infradead.org>
References: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731-mgctime-v1-1-1aa1177841ed@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 31, 2023 at 06:37:10AM -0400, Jeff Layton wrote:
>  /**
>   * generic_fillattr - Fill in the basic attributes from the inode struct
> - * @idmap:	idmap of the mount the inode was found from
> - * @req_mask	statx request_mask
> - * @inode:	Inode to use as the source
> - * @stat:	Where to fill in the attributes
> + * @idmap:		idmap of the mount the inode was found from
> + * @request_mask	statx request_mask

Missing the colon after request_mask.

> + * @inode:		Inode to use as the source
> + * @stat:		Where to fill in the attributes
