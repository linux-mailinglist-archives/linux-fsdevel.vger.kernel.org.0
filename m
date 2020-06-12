Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676491F7D18
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 20:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFLSrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 14:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgFLSrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:47:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82EC03E96F;
        Fri, 12 Jun 2020 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M0XBJfmj5g8OJJK5rxLSCulz9dzgt9BdEfOunG21ngo=; b=s/fgYIdONJS4GCDdvwRhAF5jzW
        upm5xZgPDmZJeteqcu71CEpHpf9RpVCDk0XWLJIOVkNiywX/wNV+1Pf4LifGNTCyyj0qhnlUrjSRj
        xP3x1ifhkugQFbKW0i+o8WJ05hBJrtq7nkVhxB3lIOctDoOPEqOkH9bZwAwe5lO4UjvmxYHaPPlpl
        V3Pbcb5QMpAU1V+Mem8LelY/ZHIt0Sq+vGIFFwjZPbToDMNAved65dI8HGKB1KHUTANIYqkHka9hd
        OuEXtYmoIhBMy0Q8XiEMd5cwalnqHr4ApISoreZzm8QaiFvkbly0B99aUdFRKBFHS0bRBZOPbFTBf
        dH4PdCbQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjohh-0002hB-PJ; Fri, 12 Jun 2020 18:47:01 +0000
Date:   Fri, 12 Jun 2020 11:47:01 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
Message-ID: <20200612184701.GI8681@bombadil.infradead.org>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
 <20200612182811.GH8681@bombadil.infradead.org>
 <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3d13ca7-754d-cf52-8f2c-9b82b8cc301f@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 08:43:41PM +0200, Markus Elfring wrote:
> >> The presented suggestions trigger different views by involved contributors.
> >
> > Most of the views I've heard are "Markus, go away".
> > Do you not hear these views?
> 
> I notice also this kind of feedback.
> The clarification is still evolving for these concerns and communication difficulties.
> 
> I suggest to take another look at published software development activities.

Do you collateral evolution in the twenty?

> I got also used to some communication styles.
> I am curious to find the differences out which hinder to achieve a better
> common understanding.

My quantum tunnelling eases the mind.

> > For example, instead of saying something weird about "collateral evolution"
> > you could say "I think there's a similar bug here".
> 
> * Why do you repeat this topic here?

* Can communication be achieved?
* Will you twice the program?

> >> How do you think about further function design alternatives?
> >
> > Could you repeat that in German?  I don't know what you mean.
> 
> I imagine that you could know affected software aspects better.

Murph had other ideas.
