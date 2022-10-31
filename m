Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8ED613163
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Oct 2022 08:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiJaHzq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Oct 2022 03:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaHzp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Oct 2022 03:55:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B9DB7E2;
        Mon, 31 Oct 2022 00:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OyNNa9TQ/Nvv7yzw0knkkNhrlMTQLY+yXoINj/cJH1I=; b=x0TJGwr2qmLzttyF8V90aXvwKm
        65b4z/flrsP6tUJq1aaO5j6wLFktUtgKE2Hy/V4omwP7L8l9GYWj4zOEML/oF9SP8m96I+Vqdx7Mc
        XsxuO63n+75wgfsI1cwLDiUenNjHnzBnKfEYHmgdEXEfxRQTEflO8Jl/OGEp1GmmN+c9z4nYyOYHu
        lHCPZ8Uc5Y226pZvzKyP+tTvllk5vlVFM/R82yQcI8jUyu0BGuWE2Jj8N9HyIrQsxkI5rCuNhNyW4
        tuu7mY88iNBYdSbxoCMLST+Mx+nbspBYSLx4DlcPj501Kwt7mHfGGrRqmrCSXNMzcLkAxR0FzjbTp
        bGgz75Gg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1opPdx-009LuH-R8; Mon, 31 Oct 2022 07:55:37 +0000
Date:   Mon, 31 Oct 2022 00:55:37 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dawei Li <set_pte_at@outlook.com>, brauner@kernel.org,
        neilb@suse.de, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vfs: Make vfs_get_super() internal
Message-ID: <Y19/eSFnrSpnTHDf@infradead.org>
References: <TYCP286MB23233CC984811CFD38F69BC1CA349@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <Y17edxOrW81EBh1v@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y17edxOrW81EBh1v@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 30, 2022 at 08:28:39PM +0000, Al Viro wrote:
> I would rather kill the "keying" thing completely.

And I replied with a patch doing just that to his v1.  Guess it's time
to resend it formally.
