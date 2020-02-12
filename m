Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9C7715A218
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBLHdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:33:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35036 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbgBLHdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=INswDW5zsWlhkjkAHTUowJA6lFKXaQvgekj3BIywAjI=; b=kGdvi9ZxnBpte6YNv9i7UByEgc
        yyC9wvVvMHLdOjLJDre//fu6ES/afmFPFTgLW0tXGlI9G9ZSRFFrxkHuAukMjJ1CElchsUKxhZ76A
        pLXBRB2JIk5Ms1M4QIA13ajANxOQecK9eOjO8O18G8Mm4yJ1bD19RhO0AuHeBApu8Tq5gF4UC7VrJ
        pro8fJaqI4yktJwkpVKOnwU+ARuzzxN9D8W+L3ENs6WhCLVqy73QHl2+EJWArkAH9DRzf82G+HUao
        xAdFPNpl3HNwyUBqxAJtUXXVSuQ4AOynRhCz/vI3ruiWRGC1Sp44UU1XIVvteiazmwrsF8KOQTTWq
        psGlYJlg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1mWw-0003sd-Ep; Wed, 12 Feb 2020 07:33:54 +0000
Date:   Tue, 11 Feb 2020 23:33:54 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Bob Peterson <rpeterso@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH] fs: clean up __block_commit_write
Message-ID: <20200212073354.GA7068@infradead.org>
References: <1527244171.7695063.1581449058353.JavaMail.zimbra@redhat.com>
 <1350360444.7695146.1581449194730.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1350360444.7695146.1581449194730.JavaMail.zimbra@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> -	__block_commit_write(inode, page, start, start+copied);
> +	__block_commit_write(page, start, start+copied);

Please throew in the missing whitespaces around the + here.

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>
