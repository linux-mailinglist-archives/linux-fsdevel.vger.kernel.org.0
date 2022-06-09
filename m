Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488E6544234
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 05:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbiFIDyZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 23:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiFIDyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:54:24 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D1C5FDB;
        Wed,  8 Jun 2022 20:54:22 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id AF07268B05; Thu,  9 Jun 2022 05:54:19 +0200 (CEST)
Date:   Thu, 9 Jun 2022 05:54:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net
Subject: Re: [PATCH 1/5] ext2: remove nobh support
Message-ID: <20220609035419.GA31288@lst.de>
References: <20220608150451.1432388-1-hch@lst.de> <20220608150451.1432388-2-hch@lst.de> <YqDQ31eEWR4fRopC@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDQ31eEWR4fRopC@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 08, 2022 at 05:39:59PM +0100, Matthew Wilcox wrote:
> On Wed, Jun 08, 2022 at 05:04:47PM +0200, Christoph Hellwig wrote:
> > @@ -551,7 +548,8 @@ static int parse_options(char *options, struct super_block *sb,
> >  			clear_opt (opts->s_mount_opt, OLDALLOC);
> >  			break;
> >  		case Opt_nobh:
> > -			set_opt (opts->s_mount_opt, NOBH);
> > +			ext2_msg(sb, KERN_INFO,
> > +				"nobh option not supported");
> >  			break;
> 
> This is the only part I wonder about.  Should we just silently accept
> the nobh option instead of emitting a message?

That is how ext2 handles other ignores messages.  Note that it still
accepts the option, it just prints a short line in dmesg.

> Also, is it time to start emitting a message for nfs' intr option?  ;-)

Talk to the nfs folks..
