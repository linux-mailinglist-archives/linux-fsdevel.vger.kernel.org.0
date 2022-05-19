Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9AA52CD53
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 May 2022 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbiESHl0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 May 2022 03:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234502AbiESHlT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 May 2022 03:41:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7184F2983E;
        Thu, 19 May 2022 00:41:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 94ACD68AFE; Thu, 19 May 2022 09:41:14 +0200 (CEST)
Date:   Thu, 19 May 2022 09:41:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Eric Biggers <ebiggers@kernel.org>, Keith Busch <kbusch@fb.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com
Subject: Re: [PATCHv2 3/3] block: relax direct io memory alignment
Message-ID: <20220519074114.GG22301@lst.de>
References: <20220518171131.3525293-1-kbusch@fb.com> <20220518171131.3525293-4-kbusch@fb.com> <YoWL+T8JiIO5Ln3h@sol.localdomain> <YoWWtwsiKGqoTbVU@kbusch-mbp.dhcp.thefacebook.com> <YoWjBxmKDQC1mCIz@sol.localdomain> <YoWkiCdduzyQxHR+@kbusch-mbp.dhcp.thefacebook.com> <YoWmi0mvoIk3CfQN@sol.localdomain> <YoWqlqIzBcYGkcnu@kbusch-mbp.dhcp.thefacebook.com> <YoW5Iy+Vbk4Rv3zT@sol.localdomain> <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoXN5CpSGGe7+OJs@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 18, 2022 at 10:56:04PM -0600, Keith Busch wrote:
> I'm surely missing something here. I know the bvecs are not necessarily lbs
> aligned, but why does that matter? Is there some driver that can only take
> exactly 1 bvec, but allows it to be unaligned? If so, we could take the segment
> queue limit into account, but I am not sure that we need to.

At least stacking drivers had all kinds of interesting limitations in
this area.  How much testing did this series get with all kinds of
interesting dm targets and md pesonalities?
