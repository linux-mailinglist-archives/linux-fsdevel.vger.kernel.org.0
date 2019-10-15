Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54296D76BA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Oct 2019 14:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfJOMob (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Oct 2019 08:44:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43436 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfJOMob (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Oct 2019 08:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=ky6xwJvQNlAb9208JdyEeUMTR
        72L+LW8hbk/ydEzm8FsYtDVJD0iYsFEKPdWeLr3RoO/jFIQBsMJ80xt+oxOzl/4HVll9Y+fZHLMts
        MNHZaRi+j0pqilYvQ49Zuv7r48JKze2zZgcDgL3OEYnmXYwNLlLuF8ISx/veMJ7KspVSrwXgV8CXg
        CELPlN67YRvGWqiA0KUySJxHfeOSBYZ3zOqlQF4llXcf1yKbrlKnehmaA9OcmRs9HV88uNMsmUm+p
        UaWE60Sb0hfUGPOQxkBJabPYv9jOS9J7uUNv0iTrg7Jn+R/YecmG+Hghjhh6Ln91Ryj0AsqBJeBsQ
        /GR2ae6oA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iKM9c-0007mz-3q; Tue, 15 Oct 2019 12:42:20 +0000
Date:   Tue, 15 Oct 2019 05:42:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-kernel@lists.codethink.co.uk,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/fnctl: fix missing __user in fcntl_rw_hint()
Message-ID: <20191015124220.GB23798@infradead.org>
References: <20191015105049.31412-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015105049.31412-1-ben.dooks@codethink.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
