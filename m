Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088823FE9DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 09:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhIBHSR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 03:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbhIBHSP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:18:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C5BC061575;
        Thu,  2 Sep 2021 00:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ClXCMkYCppEl6bfYfK41euQx4F2YdEHk6mWG/p90Tv0=; b=A9L3b4iimfPMbdilkRg86VELvU
        tBC23/i8VvVAIHJ6m8OrxxLQipR6r5Tm+fX7RpIeyXCpNb6PjqpDxDd2zFrvZq71feFbE5ueI7qcn
        6njt1mLugnZxnqCAQumDTWOB27W8FPzrWhQTkb8ToxCcmMu4e0dcBkrgChfMwpQTbefPWbyumHnGt
        Qj2MZ63Ag8RUXn+h2tCLbMvHodQumXBVOuPtGH5xPJRVuKHbewCbvEGdhqTaBituMFz//bjX67XaN
        reo69RJ8b+q1L6F13Ds7LPtC2iKIf9jt9S4h5hIpXapsAbKHpd1liATYpDThX8EGzZyA1c1AqVhT1
        eZVWDtsQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLgxB-003DAJ-F8; Thu, 02 Sep 2021 07:16:14 +0000
Date:   Thu, 2 Sep 2021 08:16:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] BTRFS/NFSD: provide more unique inode number for
 btrfs export
Message-ID: <YTB6NacU9bIOz2vf@infradead.org>
References: <162995209561.7591.4202079352301963089@noble.neil.brown.name>
 <162995778427.7591.11743795294299207756@noble.neil.brown.name>
 <YSkQ31UTVDtBavOO@infradead.org>
 <163010550851.7591.9342822614202739406@noble.neil.brown.name>
 <YSnhHl0HDOgg07U5@infradead.org>
 <163038594541.7591.11109978693705593957@noble.neil.brown.name>
 <YS8ppl6SYsCC0cql@infradead.org>
 <163055561473.24419.12486186372497472066@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163055561473.24419.12486186372497472066@noble.neil.brown.name>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 02, 2021 at 02:06:54PM +1000, NeilBrown wrote:
> Hi Christoph,
>  I have to say that I struggle with some of these conversations with
>  you.
>  I don't know if it is deliberate on your part, or inadvertent, or
>  purely in my imagination, but your attitude often seems combative.  I
>  find that to be a disincentive to continuing to engage, which I need to
>  work hard to overcome.  If I'm misunderstanding you, I apologise and
>  simply ask that you do what you can to compensate for my apparent
>  sensitivity.

I would not call it combative.  It is sticking to the points and the red
lines.

>  Your attitude seems to be that this is a btrfs problem and must be
>  fixed in btrfs.

Yes.
