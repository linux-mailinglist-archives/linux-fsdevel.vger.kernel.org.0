Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F2173F304
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 05:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjF0Dwo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 23:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjF0Dwm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 23:52:42 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AE9D7;
        Mon, 26 Jun 2023 20:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TKSoOmqj1EAANzs2OdZF0iO6dL5Bi2w/E8Nz8eMSDxo=; b=pyDpY9vbvnNy4Mf/ml1PIK+Ob9
        1208C2TwuJ5k+FoS68gusP++AuS2XUDA9C8//8M1xAMTsE4wPmDE2tX0E9mGMhQzfaOcjVd4rknLu
        tva8g915dMgAFUKIM6P72qyq8v99czSss6mdnTMtSeOK9vvpr96GqwcxsShz1aM0Cs/RERCcfBXmF
        sN0KENyC4imijg6VCwSOBwP+16bOko7gzRHcj3WyZcndzK3lflyUQNN0lrFP5X9j6YouoS2o0KThE
        YxNhrFJvD9I5rI1+kajuVCrDTm8YF5rkLCuzMriemNK1heyFiX06hmIzjaRZMrWEA5aMwn88whrGe
        oZUbJB1A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qDzkt-00BdCL-2t;
        Tue, 27 Jun 2023 03:52:39 +0000
Date:   Mon, 26 Jun 2023 20:52:39 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs
Message-ID: <ZJpdB5dsngEcN7fG@infradead.org>
References: <20230626214656.hcp4puionmtoloat@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230626214656.hcp4puionmtoloat@moria.home.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Nacked-by: Christoph Hellwig <hch@lst.de>

Kent,

you really need to feed your prep patches through the maintainers
instead of just starting fights everywhere.  And you really need
someone else than your vouch for the code in the form of a co-maintainer
or reviewer.
