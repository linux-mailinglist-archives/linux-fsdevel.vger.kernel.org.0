Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD33E47223C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Dec 2021 09:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhLMIRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Dec 2021 03:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhLMIRt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:17:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEB0C06173F;
        Mon, 13 Dec 2021 00:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=GsX+7u1gIKXcn6ErdVFwQBxDOnac7/QwI2UXr5apgcg=; b=fVwjoYzon9W5GtvQWCQ1G9TVlP
        2J/fZoRQyfjHp4GAMRqnFSV+Jh0YSHFBsz6SQ994GTbeZ7sui0P4+yE8FotbCLdochamBOsxbCUrC
        dgxWFfnuliMRYqLlNDDk1DXw8KoUbXLO99P7gm1WyO4qCz42ZwfAyVj44vgKUM0h5urMGeF+PbJCf
        drKSGX3LBVvZ88ODzBx3fFcKzmovSODPKDIsV2ilxDNKfKIcoTghhAWV1MBLJ4EnPticKN+hucZvb
        OqJ7EeYV72uBLlYXEZqqGH/aq5/4tfxAEuU2hOMcD+kIhadusX+XbC0PjYZr1MhbRmq+9VyN2hiom
        psfvORQA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mwgWq-008GsL-MK; Mon, 13 Dec 2021 08:17:48 +0000
Date:   Mon, 13 Dec 2021 00:17:48 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/36] fscrypt: export fscrypt_base64url_encode and
 fscrypt_base64url_decode
Message-ID: <YbcBrOobbCX/zlSz@infradead.org>
References: <20211209153647.58953-1-jlayton@kernel.org>
 <20211209153647.58953-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209153647.58953-3-jlayton@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Please export these as EXPORT_SYMBOL_GPL like most fscrypt symbols.

