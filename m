Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437A46E354E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Apr 2023 08:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDPF77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Apr 2023 01:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDPF76 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Apr 2023 01:59:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44762681;
        Sat, 15 Apr 2023 22:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D1Ny97r9Y3cjcJeTg3thWBrN3BXrElakiqz0kq71xrA=; b=Necb7aklV81Cw78Ub8q5Ctf1uv
        fALPm24TJjpAzrikDLpdZfrYQ7qNdPOcuiAwtnkCk0+5NSBGfVGOcTfFzfEH5nZ/4INYk5pbkFMOT
        QHYjXwjUIbuJSRXb2gTJvJGtZ4Kmos6UYnLI4OZrpxqeCux4uJ/Mw00U99A17Cy5EiUHOtRnrpHVT
        O3h28EdCBjQwCx18fkjbQpcA6LYaDcTO8FOXEs7duuxonEB0jyr8J88iZ/caKf7HEtEMMRgeCu54D
        t33tof84RhdOobm4wxHFYyNAqBpAXlI+X3B8LYHD8/v9NVOD6bLhjciOWp5tMf4aoVgcdrsA7ZDp+
        tuZZPclw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pnvQa-00DCFp-25;
        Sun, 16 Apr 2023 05:59:56 +0000
Date:   Sat, 15 Apr 2023 22:59:56 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Disha Goel <disgoel@linux.ibm.com>
Subject: Re: [RFCv4 5/9] ext2: Move direct-io to use iomap
Message-ID: <ZDuO3OfYPwzzjAou@infradead.org>
References: <cover.1681544352.git.ritesh.list@gmail.com>
 <78fed3db1cd6889b2c26866b9ce3c2538c7a77f7.1681544352.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78fed3db1cd6889b2c26866b9ce3c2538c7a77f7.1681544352.git.ritesh.list@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good based on my limited ext2 knowledge:

Reviewed-by: Christoph Hellwig <hch@lst.de>
