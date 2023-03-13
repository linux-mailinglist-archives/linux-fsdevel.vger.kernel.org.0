Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB426B7BDC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Mar 2023 16:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjCMPX5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Mar 2023 11:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjCMPX4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Mar 2023 11:23:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D965D56539;
        Mon, 13 Mar 2023 08:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gPzArcwVntemOsc46KgP5+C+CRC7rzSCypZ0jj9/iY0=; b=VTKd6GT6V6w43N3sJAv9+E8IVp
        cSe6fz7vQYWyb0jb8fGfPX9dc45WoEa2z++Mf2rhUbwRudJRi0LVY0vGoitKb1CANzWNEN5sT+CXu
        tREGSl27M2SyPlkcITh3V1XziwiMVX2r5mLoT91fspOXgEWS4Q3RH2h/h38t1PTFTR4IfD+4ZZmu5
        /mHm8znnIhiWu6SgrsdXyt/aKgvZyvijqlE3augJp2pm0eISa31EA/EYjc2s2Ujwt/7cs0TyHNnrS
        Q5xTB1fZhuFKRlxo/uQgqaexOAk/WAjGO48e6AETfNkPTYe22XRNN3O6fkjiO34e58ZNh7QtO2WkF
        P8a5GccQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbk1d-006PrD-HL; Mon, 13 Mar 2023 15:23:49 +0000
Date:   Mon, 13 Mar 2023 08:23:49 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfs: use vfs setgid helper
Message-ID: <ZA9ABbNzoxScYpzI@infradead.org>
References: <20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313-fs-nfs-setgid-v1-1-5b1fa599f186@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:25:34PM +0100, Christian Brauner wrote:
> +#include "../internal.h"

> +		if (setattr_should_drop_sgid(&nop_mnt_idmap, inode))

It setattr_should_drop_sgid is used by file systems, it should not be in
internal.h.

