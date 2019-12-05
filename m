Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0C1113C9D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Dec 2019 08:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfLEHwg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Dec 2019 02:52:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfLEHwg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Dec 2019 02:52:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VkqB7rPgdj4+QPXXic0ulFV3ZFV3kYD2FveH5OtdK0s=; b=XGT8fxfE0uglvMujMvs2m/r6l
        CI+cbvdUz08Wy2itHm3OAexVIYHjacW+PUBot1uzZHHRXgwGLIKWpJ16yqTYEz0FUmrnNEYgjcuH5
        MUMvDx75qB7NruoxnBgWY20zu96LTbrpgS/VJZMczLMBPoqh2NUsa0WM1q9DktDRwocwkriThpELH
        NN4CYzJmYfk4eWgEJsLNwQdf+u8eimEB6StP8NROXGPs9aAYFxNZ2K2qNctr5rtvWWK4n8dk05UUH
        VM6QQSVePKmpYIr81Gk071GlTwaOmEKL0Vog0XIZxUNnPQDWPx0qZhPr+A/bvd3mzvjrNDGsmaBEc
        LQgyEFZ+w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iclwB-0007Fp-W6; Thu, 05 Dec 2019 07:52:35 +0000
Date:   Wed, 4 Dec 2019 23:52:35 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Zorro Lang <zlang@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: stop using ioend after it's been freed in
 iomap_finish_ioend()
Message-ID: <20191205075235.GA21619@infradead.org>
References: <20191205065132.21604-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205065132.21604-1-zlang@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The code changes looks good, although we usually don't do that
style of comment.  Otherwise looksgood:

Reviewed-by: Christoph Hellwig <hch@lst.de>
