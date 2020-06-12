Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C61F7CDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 20:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLS2T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 14:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLS2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 14:28:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74963C03E96F;
        Fri, 12 Jun 2020 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=fMK1eYp0u+euxgVOHw3duKdBcD5DBcCm6cJKZJ/S5Ew=; b=K0LoFKfReLadDNKAZKp1+itnoH
        v8A8dgGBIgan1mqcohgDbHer/ZNOHIwRT7uW5XbU/ERBTKINqAE/pMHlES0Sf+xxWDthJp9FnLFC/
        ggMyycSwdgbQ3d78716YqH5Ut7Bw+PikAXz7vj9bpYjd7GJY3vOx6lwKoN3TENTuj0mt/ok9L3xrn
        6ctNZfK+IU96OwH6aCg2kk6gblFozL0R2I9Ri4TUrp3pewmLjG1mP9esGujSEaanv73UjT/zJVqRn
        QquSt5sNP4Fc+J14oyiTQPa+R+vyfhmAfCebIisd6ZLWzx7dEJ3rJ3xClwOf198NEy6Y0AECywjq5
        stCWouag==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjoPU-0007Ua-0T; Fri, 12 Jun 2020 18:28:12 +0000
Date:   Fri, 12 Jun 2020 11:28:11 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [v2] proc/fd: Remove unnecessary variable initialisations in
 seq_show()
Message-ID: <20200612182811.GH8681@bombadil.infradead.org>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
 <20200612170033.GF8681@bombadil.infradead.org>
 <80794080-138f-d015-39df-36832e9ab5d4@web.de>
 <20200612170431.GG8681@bombadil.infradead.org>
 <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8f10b2-ffbd-e10f-4921-82d75d1760f4@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 08:22:43PM +0200, Markus Elfring wrote:
> >> Would you like to clarify concrete software development ideas?
> >
> > Yes.  Learn something deeply, then your opinion will have value.
> 
> The presented suggestions trigger different views by involved contributors.

Most of the views I've heard are "Markus, go away".  Do you not hear these
views?

> In which directions can the desired clarification evolve?

You could try communicating in a way that the rest of us do.  For
example, instead of saying something weird about "collateral evolution"
you could say "I think there's a similar bug here".

> How do you think about further function design alternatives?

Could you repeat that in German?  I don't know what you mean.
