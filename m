Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F65A5698
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Sep 2019 14:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731033AbfIBMqs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Sep 2019 08:46:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50774 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729878AbfIBMqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Sep 2019 08:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jfFRBba+HrXzPtnLLkqdxGZhTr4bv/R0fv80eG1X1wA=; b=UFTnfwfJQ+iKUYHTbB5e9ISAl
        nzFxznuKSHJjQ2mGw+CYJJrE6eQBiBjxDs+JCQfk0yzSZuTn9d8dtta/9tLkL+nfabApfR3WbB8q5
        blms0Zm5b41amefScxmYYBI6JLewHu70DvnuKi8im94sLw4LNeXI2e0LoOHHLcUXSNAiVhSmx5Tzd
        VC+RLhyEdSRMBIEzwPqIUwDdLpJ6Ku0cOqUvJjSTZVCgwy0vtsd29gvEKAXnCmqsFiMdTfbwJJ5Qj
        o38z8aq5HapdS/mW9wEJv/TuNVhLNHmwVUS/vKuhgX37IFRXR5e0mzNwvMQKfpXEOMJdX+CNqJs2f
        iw0lzOPJw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1i4ljJ-0002Vq-8L; Mon, 02 Sep 2019 12:46:45 +0000
Date:   Mon, 2 Sep 2019 05:46:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 00/21] erofs: patchset addressing Christoph's comments
Message-ID: <20190902124645.GA8369@infradead.org>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 01, 2019 at 01:51:09PM +0800, Gao Xiang wrote:
> Hi,
> 
> This patchset is based on the following patch by Pratik Shinde,
> https://lore.kernel.org/linux-erofs/20190830095615.10995-1-pratikshinde320@gmail.com/
> 
> All patches addressing Christoph's comments on v6, which are trivial,
> most deleted code are from erofs specific fault injection, which was
> followed f2fs and previously discussed in earlier topic [1], but
> let's follow what Christoph's said now.

I like where the cleanups are going.  But this is really just basic
code quality stuff.  We're not addressing the issues with large amounts
of functionality duplicating VFS helpers.
