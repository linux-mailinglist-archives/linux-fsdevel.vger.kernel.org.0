Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EBD4C7FB0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 01:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiCAAsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 19:48:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbiCAAsf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:48:35 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207A4338B5;
        Mon, 28 Feb 2022 16:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ISMOAKiy7A2BJqPXfGDMRWuQfILk8ZDRVifw6hgMiPM=; b=OqPdf84nmoM+CQ7JjB27z8kE0L
        SSlnHvlQi3pdFm9qHzD/lzPzy8ZCIK2fdEic2B4tyghC3zl7G0vBGpuFpn4SEbIDt7o8Di6p3TJHd
        P7YsFDDKmbCxYVhy7XmQyyLHY1LU00JOEyyzO8VHdyEyTppFxkHHR2yxrU/QCutr2FfwVjxuR3qcw
        Mi1xxz3bNYLgEPFZ6q6XBwj+29mKqa/AeocrT1y5kZTHgx9Lw66GlRokify54EEA9y4//CCsu9ABd
        5gtXFj+TXHnDLE/SI1GsFo/kZ5Qks12ARqxxUsonHuoWcbqBkirZBvOoO3ZBHSjF37+rLpy6VLy3q
        EZjorv3Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOqg2-00EWuu-8V; Tue, 01 Mar 2022 00:47:42 +0000
Date:   Mon, 28 Feb 2022 16:47:42 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh1tLmmgEEd3XOx3@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
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

On Tue, Feb 01, 2022 at 08:43:47AM -0500, James Bottomley wrote:
> https://lore.kernel.org/all/20200215153609.23797-1-James.Bottomley@HansenPartnership.com/
> 
> The point, though, is that configfd can configure pretty much anything;
> it wouldn't just be limited to filesystem objects.  It takes the
> fsconfig idea of using a file descriptor to carry configuration
> information, which could be built up over many config calls and makes
> it general enough to apply to anything.  One of the ideas of configfd
> is that the data could be made fully introspectable ... as in not just
> per item description, but the ability to get from the receiver what it
> is expecting in terms of configuration options (this part was an idea
> not present in the above patch series).
> 
> If the ioctl debate goes against ioctls, I think configfd would present
> a more palatable alternative to netlink everywhere.

FWIW it seems more grounded on the fs world for sure. And I didn't want to
barf when doing a cursory review.

  Luis
