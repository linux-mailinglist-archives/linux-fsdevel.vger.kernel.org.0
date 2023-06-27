Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9873F390
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjF0Ekm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjF0EkL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:40:11 -0400
Received: from out-36.mta1.migadu.com (out-36.mta1.migadu.com [IPv6:2001:41d0:203:375::24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399F4198D
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:37:49 -0700 (PDT)
Date:   Tue, 27 Jun 2023 00:36:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687840607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x5FDsvw0WZ1RuklE0mA7Ohbc/9CED1mk7/g7Gfk/gpo=;
        b=BGDtJjtuRlPsT50Tbop4Z4x4tAkH24fbVNH5/y5eu2DFsLmWv9N45km7uOJLi5mVOuNfit
        hVahFNOQEypKrKd4+ud2hEE7msfQjSUCIPypLNvVKoUZUU/VbbUKv6Aw3gQO9B4Ew5FZgA
        8IKUKNctqko+MJ6uBJIPgVS3FbBiMlI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <20230627043642.u6oj4f5ujn3kh74l@moria.home.lan>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
 <ZJpdB5dsngEcN7fG@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJpdB5dsngEcN7fG@infradead.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:52:39PM -0700, Christoph Hellwig wrote:
> 
> Nacked-by: Christoph Hellwig <hch@lst.de>
> 
> Kent,
> 
> you really need to feed your prep patches through the maintainers
> instead of just starting fights everywhere.  And you really need
> someone else than your vouch for the code in the form of a co-maintainer
> or reviewer.

If there's a patch that you think is at issue, then I invite you to
point it out. Just please deliver your explanation with more technical
precision and less vitriol - thanks.
