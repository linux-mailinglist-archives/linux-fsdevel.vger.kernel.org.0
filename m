Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1C14D69BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Mar 2022 21:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiCKUzm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Mar 2022 15:55:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCKUzk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Mar 2022 15:55:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4059D200CFD
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Mar 2022 12:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+7lS1XG0leuLJmPsTmtaomhth58UEh03yT5mvzudFUY=; b=dmkcsYKSP81srQawC9bG8RAgif
        yGP6yT+N+5TU5aK+1QMp22CttQX/zut/ZXMCq6RjDyn4LbknY0oCfk9KXJlA1mmc5SzLxH50Kurqw
        ghSKm1Z2HlihbICKmjgDGP2f6H3KcKsQDLe3yP1ps/h+/7omGFb55kgFl3h9BxKrjmu06CB5ki/WK
        ICXdQkAu40K5HteoI5eDkEF5VmRQN81HlneGzCFVcGku/5JauCtRjbKEOXHC3ijH18vrzaH6AO/ql
        qxyOaLthNexsBCD0Tw4mrrPxNQYa5+FEnctgL8d5Z6VAHB4kqZV2SC20m2DDLw44o/GlsKzIjX1OF
        n6qyQd5g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSmHE-000FqH-W8; Fri, 11 Mar 2022 20:54:20 +0000
Date:   Fri, 11 Mar 2022 12:54:20 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve French <smfrench@gmail.com>, Sasha Levin <sashal@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        lsf-pc <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Darrick Wong <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
Message-ID: <Yiu2/O7FK0T7e8R1@bombadil.infradead.org>
References: <20190212170012.GF69686@sasha-vm>
 <CAOQ4uxjysufPUtwepPGNZDhoC_HdsnkHx7--kso_OXWPyPkw_A@mail.gmail.com>
 <YicrMCidylefTC3n@kroah.com>
 <CAOQ4uxjjdFgdMxEOq7aW-nLZFf-S99CC93Ycg1CcMUBiRAYTQQ@mail.gmail.com>
 <YiepUS/bDKTNA5El@sashalap>
 <CAH2r5msh55UBczN=DZHx15f7hHrnOpdMUj+jFunR5E4S3sy=wQ@mail.gmail.com>
 <1669255B-007F-4304-9C2F-F0DF6C3E207D@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669255B-007F-4304-9C2F-F0DF6C3E207D@oracle.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 11, 2022 at 12:36:23AM +0000, Chuck Lever III wrote:
> It deserves mention that network file systems like Steve's and mine
> have a slightly heavier lift because two systems at a time are needed
> to test with -- client and server.

Should be super easy with kdevops.

> I've found that requires more
> infrastructure around Jenkins or whatever framework you like to drive
> testing. Having a discussion about that and comparing notes about how
> this particular issue can be resolved would be of interest to me.

It sounds like this conversation has been a lot more about testing
than stable. So maybe testing should be its own topic at LSFMM.

  Luis
