Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5214651C42F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 May 2022 17:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381396AbiEEPtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 May 2022 11:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348488AbiEEPtl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 May 2022 11:49:41 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFDE44A0A;
        Thu,  5 May 2022 08:46:01 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id DD1ED68AA6; Thu,  5 May 2022 17:45:57 +0200 (CEST)
Date:   Thu, 5 May 2022 17:45:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/5] iomap: add per-iomap_iter private data
Message-ID: <20220505154557.GA22763@lst.de>
References: <20220504162342.573651-1-hch@lst.de> <20220504162342.573651-3-hch@lst.de> <20220505154126.GB27155@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505154126.GB27155@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 05, 2022 at 08:41:26AM -0700, Darrick J. Wong wrote:
> > +	 */
> > +	iomi.private = iocb->private;
> > +	WRITE_ONCE(iocb->private, NULL);
> 
> Do we need to transfer it back after the bio completes?  Or is it a
> feature that iocb->private changes to the bio?

No need to transfer it back.  It ist just a creative way to pass private
data in.  Initially I just added yet another argument to iomap_dio_rw,
and maybe I should just go back to that to make the things easier to
follow.
