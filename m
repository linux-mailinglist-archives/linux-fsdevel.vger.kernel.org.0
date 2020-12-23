Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984E92E2097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 19:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbgLWSva (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Dec 2020 13:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgLWSva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Dec 2020 13:51:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CD7C061794;
        Wed, 23 Dec 2020 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KlQqVABxLbNILRv0NGDx6eVfUShT0JRDanNn1n1jfDE=; b=TQQAiTLyezaZFrL6XaF5ThouWU
        5aitGbmq3XND46x8/Xi6YsBBox6sSdi/lNbK8JbkYT6wBBo3wByKMq9wlzJ/ZhtRQ2z/dPgqFXyvj
        CWXv0EEdjJsyi86O93TZ3AEaNofsEYvSEnkQ67e2wkU5U6Tc4ZhX1orYR3SVd5ycY28dkMZpA1Qrq
        WEauczzL/9p0lZMUs+szdcgefgZqV3cw3Lg6etn38u+y6LPogaXid93409aKksu078b7Ze1X5mOKR
        RgN81cnL6MZwBORXf4FPKK0QXkukNae6fGP3SOhQusGaqU65F2A0W3wyuNU+V53u6pk1CFdKueVsD
        4i3WtKFA==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ks9Dg-00048r-Qt; Wed, 23 Dec 2020 18:50:44 +0000
Date:   Wed, 23 Dec 2020 18:50:44 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        jlayton@kernel.org, amir73il@gmail.com, miklos@szeredi.hu,
        jack@suse.cz, neilb@suse.com, viro@zeniv.linux.org.uk, hch@lst.de
Subject: Re: [PATCH 3/3] overlayfs: Report writeback errors on upper
Message-ID: <20201223185044.GQ874@casper.infradead.org>
References: <20201221195055.35295-1-vgoyal@redhat.com>
 <20201221195055.35295-4-vgoyal@redhat.com>
 <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201223182026.GA9935@ircssh-2.c.rugged-nimbus-611.internal>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 23, 2020 at 06:20:27PM +0000, Sargun Dhillon wrote:
> I fail to see why this is neccessary if you incorporate error reporting into the 
> sync_fs callback. Why is this separate from that callback? If you pickup Jeff's
> patch that adds the 2nd flag to errseq for "observed", you should be able to
> stash the first errseq seen in the ovl_fs struct, and do the check-and-return
> in there instead instead of adding this new infrastructure.

You still haven't explained why you want to add the "observed" flag.
