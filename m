Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F652CD62
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234965AbiESHmn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiESHmk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:42:40 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE3EAE25E;
        Thu, 19 May 2022 00:42:27 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CF9168AFE; Thu, 19 May 2022 09:42:25 +0200 (CEST)
Date:   Thu, 19 May 2022 09:42:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@fb.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Kernel Team <Kernel-team@fb.com>,
        hch@lst.de, bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 0/3] direct io alignment relax
Message-ID: <20220519074225.GH22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <dc8e7b85-fba1-b45e-231e-9c8054aea505@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc8e7b85-fba1-b45e-231e-9c8054aea505@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 04:45:10PM -0600, Jens Axboe wrote:
> On 5/18/22 11:11 AM, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Including the fs list this time.
> > 
> > I am still working on a better interface to report the dio alignment to
> > an application. The most recent suggestion of using statx is proving to
> > be less straight forward than I thought, but I don't want to hold this
> > series up for that.
> 
> This looks good to me. Anyone object to queueing this one up?

Yes.  I really do like this feature, but I don't think it is ready to
rush it in.  In addition to the ongoing discussions in this thread
we absolutely need proper statx support for the alignments to avoid
userspace growing all kinds of sysfs growling crap to make use of it.
