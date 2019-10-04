Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF29CC39B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 21:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfJDTeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 15:34:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36048 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTeT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=39rzJJ0pdXke/IjdtbOOLtjMx1KRjEjgc91/jPrJdjE=; b=Jv4aGSdj/INomnpjZjbcPzSF2
        jQFL6+DwaKYE3GYNY4BJ/wFAdZqFc55EkTtjTpJQPc+CVVKEU2evXOqAl8tQQPHh8T8ktui+93Y4s
        ztyOAT1p1Hz00vjM7dV2i+ZK1ePjleXmBeVpg7ZG3pv2I9YNvqbz61mmZMJ06aPXkjxnq1+1Pd1t6
        aWpH0QFRZBjubmfzXMUryWLXWidFtfy3WMVtiBseWMuzNJeaDJdt+1nKLScDJM98xq7D1hDB+KNKj
        hYbV+XFIykk/efdsO33Z+621sCIPh0wXhYWecp7p1b27vWslz6ktQwFpqOoxIQRtDK8Aj2wl5kMRg
        0/ftWBi3g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGTLG-0006AG-8z; Fri, 04 Oct 2019 19:34:18 +0000
Date:   Fri, 4 Oct 2019 12:34:18 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] iomap: Support large pages
Message-ID: <20191004193418.GM32665@bombadil.infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
 <20191002133211.15696-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002133211.15696-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 02, 2019 at 09:32:11PM +0800, Hillf Danton wrote:
> 
> On Tue, 24 Sep 2019 17:52:02 -0700 From: Matthew Wilcox (Oracle)
> > 
> > @@ -1415,6 +1415,8 @@ static inline void clear_page_pfmemalloc(struct page *page)
> >  extern void pagefault_out_of_memory(void);
> >  
> >  #define offset_in_page(p)	((unsigned long)(p) & ~PAGE_MASK)
> 
> With the above define, the page_offset function is not named as badly
> as 03/15 claims.

Just because there exists a function that does the job, does not mean that
the other function is correctly named.

> > +#define offset_in_this_page(page, p)	\
> > +	((unsigned long)(p) & (page_size(page) - 1))
> 
> What if Ted will post a rfc with offset_in_that_page defined next week?

Are you trying to be funny?
