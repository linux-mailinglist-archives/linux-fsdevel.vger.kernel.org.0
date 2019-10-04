Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA7CC3A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 21:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbfJDTff (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 15:35:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTfe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 15:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WXjztPWzGgFGCyc8y7Q02mVHbbrTIiT+1WgTYEKzNhQ=; b=J5OqbKhcUEKgOGNEWxXXtW78k
        FQ57i5pb3V+YCkWgT7CybyuYryVfEWLGt8gwtsgs+GF/WWexT227mt/Z7P/n+QUzKSBlOFifG7EgG
        ft9HiJp8T4jAMO06oKV0IvUDDcAT6mMYTvh9Y+fiEFrHXeJEXMl7Vdm2Ghpk48HBkXu1d4lkPJeZP
        Kr1p/icG0AJp+U+jwFQPGglfmBTWGm/OeZwXvhJxTg3I2lidKi0dR5CjZQjzgV17SKrytnZv6WsD2
        utYWVXRQaRIJ/PTGV4BSsgZUyWLwoqo9fWU4dusX7gUOJQFFntGOOq9CCod5mrYxwYJDWAb4Yzvqu
        MU9adDddg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iGTMU-0007Vr-2C; Fri, 04 Oct 2019 19:35:34 +0000
Date:   Fri, 4 Oct 2019 12:35:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/15] xfs: Pass a page to xfs_finish_page_writeback
Message-ID: <20191004193533.GN32665@bombadil.infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
 <20191003040846.17604-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191003040846.17604-1-hdanton@sina.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:08:46PM +0800, Hillf Danton wrote:
> 
> On Tue, 24 Sep 2019 17:52:02 -0700 From: Matthew Wilcox (Oracle)
> > 
> > The only part of the bvec we were accessing was the bv_page, so just
> > pass that instead of the whole bvec.
> 
> Change is added in ABI without a bit of win.
> Changes like this are not needed.

ABI?  This is a static function.  The original recommendation to do this
came from Christoph, who I would trust over you as a referee of what
changes to make to XFS.
