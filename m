Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40DD6B127D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 20:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjCHT6U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Mar 2023 14:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjCHT6S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Mar 2023 14:58:18 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9645E3E608;
        Wed,  8 Mar 2023 11:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PcPBY0lRw+N6fGKRquKbxW/xzrTA2S4vqATUY6U1xTA=; b=YujoIn8cagHguF6SKbLxZ3CnO4
        FiGGFveDJEwut/QJNWJipXUDjskpK5OAOJzqD8F/9fzifJXETUIeNkUPzZ6HqpIFyjuJ6CfwBMfn7
        uZ7+hWq1JCrBa2TQ8tB2vBk0AkaHCK9OeeJil8Zz6IVI1zpBFnHxRI5QcZ1Gqd8UkiDwqtBZ6Gl/H
        sf5qE5PudZ3Wtw6pgDhJme87gBGiYheQGdP1Sw+ywYdJE51x1faJ/5CzBw5m1m9I2QaEuVrEQgmN4
        66UrAXZAhRokLLrVBHtjKHydAG6Xv6EoSubfNG7XphrgPMLo3Z4shw3WamdTZ9mRAxTUb9cyYHxPs
        N+wcGkyA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZzvM-006buQ-Il; Wed, 08 Mar 2023 19:58:08 +0000
Date:   Wed, 8 Mar 2023 11:58:08 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     ye.xingchen@zte.com.cn, keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linmiaohe@huawei.com,
        chi.minghao@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH V2 1/2] sysctl: Limit the value of interface
 compact_memory
Message-ID: <ZAjo0HaUTCzQtN1Q@bombadil.infradead.org>
References: <202303061407332798543@zte.com.cn>
 <83344b3d-1de1-f3c2-913c-a8c54ce7a99f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83344b3d-1de1-f3c2-913c-a8c54ce7a99f@suse.cz>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 08, 2023 at 11:21:36AM +0100, Vlastimil Babka wrote:
> 
> 
> On 3/6/23 07:07, ye.xingchen@zte.com.cn wrote:
> > From: Minghao Chi <chi.minghao@zte.com.cn>
> > 
> > In Documentation/admin-guide/sysctl/vm.rst:109 say: when 1 is written
> > to the file, all zones are compacted such that free memory is available
> > in contiguous blocks where possible.
> > So limit the value of interface compact_memory to 1.
> > 
> > Link: https://lore.kernel.org/all/ZAJwoXJCzfk1WIBx@bombadil.infradead.org/
> 
> I don't think the split to two patches you did, achieves Luis' request.
> 
> IIUC his request was to move the compaction entries out of sysctl.c?

Yes, thanks Vlastimil, just git log kernel/sysctl.c and you'll see tons
of examples.

  Luis
