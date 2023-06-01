Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8033171A2AF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 17:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjFAP2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbjFAP20 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:28:26 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4572E10CC;
        Thu,  1 Jun 2023 08:28:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0600468AA6; Thu,  1 Jun 2023 17:27:41 +0200 (CEST)
Date:   Thu, 1 Jun 2023 17:27:40 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230601152740.GA31938@lst.de>
References: <20230601094224.1350253-1-hch@lst.de> <20230601094224.1350253-2-hch@lst.de> <20230601152536.GA16856@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601152536.GA16856@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 08:25:36AM -0700, Darrick J. Wong wrote:
> > +_require_scsi_debug
> > +
> > +physical=`blockdev --getpbsz $SCRATCH_DEV`
> > +logical=`blockdev --getss $SCRATCH_DEV`
> 
> These two tests need to _notrun if SCRATCH_DEV is not a blockdev or if
> SCRATCH_MNT is not a directory.  Normally _require_scratch_nocheck takes
> care of that.
> 
> Other than that they look ok.

Can SCRATCH_MNT be not a directory?

But yeah, these tests should simply grow a

_require_block_device $SCRATCH_DEV

