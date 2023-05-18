Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5192D70843C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 16:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjEROuK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 10:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjEROuJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 10:50:09 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FABFE0;
        Thu, 18 May 2023 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wgyvfj/jsHauTSVkFWCdlZsyu0yRuGoOltsJC9yLWc0=; b=Bl5GL1wnx/BfcSb7ef3hzdvCWv
        qnhejbynxGrXtHLBc4AFKkKj2fUJ/esjBHx5dBzGbWaptcGsDDCqKTVuWlYDqTjRfB9BTDSi6kh7b
        yEViXja1JN43498QRa6RCpeYNzlQ6nU1Ndjx7DnN0tuy4l7e02qg4XU8kK5EUj5CP1emgEIK8Npub
        BKIiLwvNZ7/WT/AWPvlrbhpQNzDICP1b4k/zoyEf9zozg4Mfqt27FqxP8na6yZzLScLe5dN1df5fv
        uyzxrjX3PY86xvWD5T1ngPrQAMhVb/CIdzHuPrSiWqJO0FVS4qNHCGbA7P3AUAOMWOeu/Vn7KcQyE
        4aqP7Eag==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pzex9-00DEJv-21;
        Thu, 18 May 2023 14:50:03 +0000
Date:   Thu, 18 May 2023 07:50:03 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     corbet@lwn.net, jake@lwn.net, djwong@kernel.org,
        dchinner@redhat.com, ritesh.list@gmail.com, rgoldwyn@suse.com,
        jack@suse.cz, linux-doc@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        p.raghav@samsung.com, da.gomez@samsung.com, rohan.puri@samsung.com
Subject: Re: [PATCH] Documentation: add initial iomap kdoc
Message-ID: <ZGY7G8gIvWCi0ONT@bombadil.infradead.org>
References: <20230518144037.3149361-1-mcgrof@kernel.org>
 <ZGY61jQfExQc2j71@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGY61jQfExQc2j71@infradead.org>
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

On Thu, May 18, 2023 at 07:48:54AM -0700, Christoph Hellwig wrote:
> > +**iomap** allows filesystems to query storage media for data using *byte ranges*. Since block
> > +mapping are provided for a *byte ranges* for cache data in memory, in the page cache, naturally
> 
> Without fixing your line length I can't even read this mess..

I thought we are at 100?

  Luis
