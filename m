Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D296DDE08
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjDKOeh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjDKOeg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:34:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069010EF;
        Tue, 11 Apr 2023 07:34:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEF9A61F8E;
        Tue, 11 Apr 2023 14:34:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E95FC433EF;
        Tue, 11 Apr 2023 14:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223674;
        bh=MY2Jh2ITaK90WSjyGrpw+XZfnUrc7i6nbRmq+ixgu40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IeN1E/1X0dvMq0QlS96yiT76N/NHakRk0ac4VX/XbHJN96waYJMzH48pIvAxyVl1d
         susg/zQNz1gsMa5G9MKdOmBu19rVJ2tIn5wD7rDQ5HatAyDV3eNRTeORW2UXF1C2cX
         mVWueDavvFSLGe15SW8YPyllXmIqsHDwRXWI4ZCHYTOqyeGdevy8EbfgztvVvPh28w
         MyYhUrl8g/YuKNEray30HzKAgfK/NSn4LlxM9gVEDpxl8X1dSsbj4qolrZxePBfE03
         Lm3da3rYvWU6uaithuRR9oswFKZjQ0f2kv/ScJ5qFPmgkZulhBsIZMvKbwgUM9XJKk
         iA4ilPw5HjUUQ==
Date:   Tue, 11 Apr 2023 07:34:33 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Subject: Re: [RFCv2 8/8] ext2: Add direct-io trace points
Message-ID: <20230411143433.GE360895@frogsfrogsfrogs>
References: <cover.1681188927.git.ritesh.list@gmail.com>
 <f9825fab612761bee205046ce6e6e4caf25642ee.1681188927.git.ritesh.list@gmail.com>
 <ZDTyXr6EB+pEgS1G@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDTyXr6EB+pEgS1G@infradead.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 10, 2023 at 10:38:38PM -0700, Christoph Hellwig wrote:
> On Tue, Apr 11, 2023 at 10:51:56AM +0530, Ritesh Harjani (IBM) wrote:
> > This patch adds the trace point to ext2 direct-io apis
> > in fs/ext2/file.c
> 
> Wouldn't it make more sense to add this to iomap instead?

Yes please. :)

--D
