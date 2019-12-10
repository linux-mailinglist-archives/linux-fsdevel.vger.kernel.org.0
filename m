Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0351187DD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 13:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfLJMOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 07:14:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56660 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbfLJMOF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 07:14:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=F0mMCaOeB48CYx+gzJAQm0OX3KEZmwC3GLdDDtsdGeI=; b=gKt+N1udFVuqZkm9Q1WZ3ZTtq
        m6mEP1vzuDG7lRrkUHUk9W5Q25t2lE02ARnkE0GsL6HUxtKVyMVsmD69mBnwxcUjP2Edu9sY+HOzQ
        wp9rknr6v6/StM6PehdiSu8gd9AYCB1GHOQT3B+s3EiKs1vmbuj+pFnExJbFPY3ur26X0lbFGOtxi
        j9EoQWf5wVv+4XnpyPPOSG+WstVGVHqjfFG/AVLC4iZQfdpBj51vljYYo6gk2h6UMDsQFhgEc3Vem
        BIEMkdxpCz94rs5SA0CkuIfFvviiNAYPh55wbdMtUckmgJOjExrqcdhE1KRgqw17dQOr0Cdmp9edZ
        IvyvlHLJA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ieeOc-00009F-9f; Tue, 10 Dec 2019 12:13:42 +0000
Date:   Tue, 10 Dec 2019 04:13:42 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        linux-fsdevel@vger.kernel.org, ecryptfs@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] fs: introduce is_dot_or_dotdot helper for cleanup
Message-ID: <20191210121342.GH32169@bombadil.infradead.org>
References: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1575979801-32569-1-git-send-email-yangtiezhu@loongson.cn>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 10, 2019 at 08:10:01PM +0800, Tiezhu Yang wrote:
> There exists many similar and duplicate codes to check "." and "..",
> so introduce is_dot_or_dotdot helper to make the code more clean.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
