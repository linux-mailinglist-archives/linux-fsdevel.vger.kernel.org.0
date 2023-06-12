Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE58F72B667
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 06:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjFLE1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 00:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjFLE1Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 00:27:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBCF1B7;
        Sun, 11 Jun 2023 21:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SvvBhms63kNurd94ej/lxYj7AVptZuo0Ra1wIfIIJzs=; b=seV9bZkybnM0E+tbiMGuypryTg
        wFD3hROGFeoCnsGCDIHbu/TR/kQSnJgyRisfCume7SC85WPjIP+J+ld+Vb9mmSmcn/jXlQw7atC0p
        j8dKY/ShU+rknIORFYV0BBMOhEM5e6KdUpCRQ2KGvTJ5v+SXvr5pDsDQBiKSm3SOobiNL4vgpuajW
        Nu/WI8+B9W5sYIvCMiTgc27dNU1sqANztIZjx1Z7Vgec2TzzyfdQPNw1OJKDoom8A5KCpDmwD/mI5
        uvsabcQfNgFRUiCfP6AWemECjA/eRF36vZQniEiXwQyqVKCMR+LMQ4S40H2LmCageim16pLxxn49f
        9RiblWLg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q8Z8v-002WlT-0p;
        Mon, 12 Jun 2023 04:27:01 +0000
Date:   Sun, 11 Jun 2023 21:27:01 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] fs: rename FMODE_NOACCOUNT to FMODE_INTERNAL
Message-ID: <ZIaelQAs0EjPw4TR@infradead.org>
References: <20230611132732.1502040-1-amir73il@gmail.com>
 <20230611132732.1502040-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230611132732.1502040-2-amir73il@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jun 11, 2023 at 04:27:30PM +0300, Amir Goldstein wrote:
> Rename the flag FMODE_NOACCOUNT that is used to mark internal files of
> overlayfs and cachefiles to the more generic name FMODE_INTERNAL, which
> also indicates that the file's f_path is possibly "fake".

FMODE_INTERNAL is completely meaningless.  Plase come up with a name
that actually explain what is special about these files. 

