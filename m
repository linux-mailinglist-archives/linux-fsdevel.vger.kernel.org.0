Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9F71F92D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 06:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbjFBENy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 00:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbjFBENr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 00:13:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DA1A8;
        Thu,  1 Jun 2023 21:13:45 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0602968AA6; Fri,  2 Jun 2023 06:13:42 +0200 (CEST)
Date:   Fri, 2 Jun 2023 06:13:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] generic: add a test for device removal with dirty
 data
Message-ID: <20230602041341.GA19603@lst.de>
References: <20230601094224.1350253-1-hch@lst.de> <20230601094224.1350253-2-hch@lst.de> <20230601152536.GA16856@frogsfrogsfrogs> <20230601152740.GA31938@lst.de> <20230601160450.GB16856@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601160450.GB16856@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 01, 2023 at 09:04:50AM -0700, Darrick J. Wong wrote:
> Good question.  AFAICT the only checks on it are in
> _require_scratch_nocheck itself...
> 
> > But yeah, these tests should simply grow a
> > 
> > _require_block_device $SCRATCH_DEV
> 
> ...but you could set up the scsi_debug device and mount it on
> $TEST_DIR/foo which would avoid the issue of checking SCRATCH_*
> entirely.

I thought about that as we really don't need a SCRATCH_DEV, but
how do we ensure we are testing a block based file system then?
