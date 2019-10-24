Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E06DE2840
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 04:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406463AbfJXCgI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 22:36:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50726 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391468AbfJXCgI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 22:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Fj9mHRF3mevdCZVhB7KKO9UNPbwjnvX89JMWBIzhco=; b=o+3jGmAqn0XHHr5GOXSJrA0oc
        shld319a6f6WtdzX9apf3HCHkkWxFIFvwfqb0yjN5VRW6deoAw04ZNe0ZCkPfy7eBFenlcN9RhOT6
        BTFxpLhy4E1hnVi6ZcuGjchtN1kNNgWOhClLWFZYDZh9ihdxRvewI17ri0YLZpTVAs/iEp1Wjroql
        ZWc9Dcga4AUhAll8gI8PzOAUYPzqhjPOvkrO1ztPsc01XrcZGaqB3PWXplDxB/qxFAPpTvyh8lJsN
        aOFFoNjRz8K90j07uU5/DKv7m/ptYEVTNun+vXQTyFCy7B5/G6K5SpWBzMHS/4JRkaCkIy7wV0Vn/
        SvJiFTAFQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSys-0001uQ-Pm; Thu, 24 Oct 2019 02:36:06 +0000
Date:   Wed, 23 Oct 2019 19:36:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Boaz Harrosh <boaz@plexistor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Please add the zuf tree to linux-next
Message-ID: <20191024023606.GA1884@infradead.org>
References: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b192a85-e1da-0925-ef26-178b93d0aa45@plexistor.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 24, 2019 at 03:34:29AM +0300, Boaz Harrosh wrote:
> Hello Stephen
> 
> Please add the zuf tree below to the linux-next tree.
> 	[https://github.com/NetApp/zufs-zuf zuf]

I don't remember us coming to the conclusion that this actually is
useful doesn't just badly duplicate the fuse functionality.
