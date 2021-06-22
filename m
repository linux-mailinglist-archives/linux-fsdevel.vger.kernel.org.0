Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07AB3AFE23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 09:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFVHp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 03:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbhFVHpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:45:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD70C061574;
        Tue, 22 Jun 2021 00:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zS4zqPMi1aCqswyogLoCQ6ZaMxO27oP51/B7V39AxYY=; b=c3AWKksMMk3CsBzKjPriGRAM6D
        wHKzH9Xq4VvY5aKljc92invvI/lHfn4wibLiyRrOWwy6suErXBdEYOXkefTw+E8TmdMEQLoPygNUA
        Esgj4otZElUPeaolLgXYHVvXsP3fgtyVAzsBASJ3K50wxT2IF9ccqT/q+rIFkF3s0Et/IS4tSm+0s
        ZqytPwdybLlukl6voxA/3/yEJYaPJlgiwcRwCVJ51Rv48GBWxvy+8tPK0717vpplY5ppIcPG8RnKe
        7ptDAPfBZ9+KmBcmlvs2bfdC5Le3HhIU2CrUEzXhHzU0Rcatena8SNHsUj2KSasHv9wFcQvva5QEZ
        X7LiIuGg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvb2J-00E15T-DR; Tue, 22 Jun 2021 07:41:53 +0000
Date:   Tue, 22 Jun 2021 08:41:31 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Leif Sahlberg <lsahlber@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        linux-cifsd-devel@lists.sourceforge.net,
        linux-cifs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 14/15] ksmbd: use ksmbd name instead of cifsd
Message-ID: <YNGUKx0oLgeVzYmv@infradead.org>
References: <20210618022645.27307-1-namjae.jeon@samsung.com>
 <CGME20210618023614epcas1p4f33df1322709076c65a63f5013f9c2cc@epcas1p4.samsung.com>
 <20210618022645.27307-14-namjae.jeon@samsung.com>
 <YNBKb2UJQ8D4JhcO@infradead.org>
 <009301d76677$8b52a6b0$a1f7f410$@samsung.com>
 <YNF9JB7PrSOpfWIP@infradead.org>
 <CAGvGhF43zhqkLn0GBjdm28cT_wufJr0CJ4LGZOVV=SFpOr9YyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGvGhF43zhqkLn0GBjdm28cT_wufJr0CJ4LGZOVV=SFpOr9YyA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 22, 2021 at 05:33:50PM +1000, Leif Sahlberg wrote:
> > Understood.
>  In that case, what are your thoughts about renaming the current client
> fs/cifs tree to fs/smb ?

If it was newly added I'd be all in favor.  Renaming an existing
codebase is rather painful, though.  So I'd rather live with the
historic misnaming (and think of the historic smbfs predating the
current cifs driver :))

