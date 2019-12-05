Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B49114613
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 18:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbfLERh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 12:37:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:43156 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729598AbfLERh3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=nJFJOkmtsi/GTWjglTSEs6q05nw0kZikwpnQYRuBbZg=; b=pJDl2qKzJp1WH5OUxD8P3z+Ol
        R8HoJbTvX5okyeXHzYm6TNWgqXUdPvKKXLkui2iihWEMkLJ0/fiwo3Rjw6Tr/GnnTav83i4n2LIvb
        Rxpe8Ta9M5oCvpMDwfv4rtZH9H4NJSH0T5Vnw9CR1BW1itzUIAEt4+tLyDOHcbp6mE3nLnrbRFB+9
        Bm/fpY+GjEgdwdV7R6mACLdlVOPVHMaL5PdWkuaId05sIEgm//k7d0ra/0L+3rmH+4wfjBcD6ThCL
        20gYV7FdVgoSNbjvNcACbbsdmsliK/wWoPrlCqCrdx6EKKBatbHCb6Eprf1AYl3E/JkWNvaCVaZhD
        7nTcHASPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1icv4C-0008Qu-Ta; Thu, 05 Dec 2019 17:37:28 +0000
Date:   Thu, 5 Dec 2019 09:37:28 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, fdmanana@kernel.org, nborisov@suse.com,
        dsterba@suse.cz, Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 4/8] btrfs: Switch to iomap_dio_rw() for dio
Message-ID: <20191205173728.GA32341@infradead.org>
References: <20191205155630.28817-1-rgoldwyn@suse.de>
 <20191205155630.28817-5-rgoldwyn@suse.de>
 <20191205171815.GA19670@Johanness-MacBook-Pro.local>
 <20191205171959.GA8586@infradead.org>
 <20191205173242.GB19670@Johanness-MacBook-Pro.local>
 <20191205173346.GA26969@infradead.org>
 <20191205173648.GC19670@Johanness-MacBook-Pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205173648.GC19670@Johanness-MacBook-Pro.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 05, 2019 at 06:36:48PM +0100, Johannes Thumshirn wrote:
> To hide the implementation details and not provoke someone yelling layering
> violation?

The only layering is ->direct_IO, and this is a step to get rid of that
junk..
