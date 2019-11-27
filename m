Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 773B110ACCA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2019 10:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbfK0Jod (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Nov 2019 04:44:33 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33990 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfK0Jod (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Nov 2019 04:44:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=IxSIQ26rUhAtDgNrOM63lKcRo
        zmmz2KZXA07dfQvpYQCT1iFwE8RUxnpZe0IeUeK/itnlBhIA1sNVGg7DG3SD4HoczoGEmXxGBYMiv
        NPX7XusTThdDloqEQ7V0Z4LrKto0SZgYzuZLFw4ttMisDAttwu9otuaIRmlbv/s+ecjrCEouJQaQV
        DU5Gfijc1xV6LxwMU7q2bUFil/pSVRFpn+20dd/0m6N6YfAUw2Y4MwAQ8XDhJmzNc4Da/zYbVXYxy
        IT2+5nHWlNdRuGO0EzF/YrF3//OdqHJXKj0W4d+n5XZIHHN5nP4xczhBACRyGsofbyeeDtYSDGzQ0
        6s2ZXvnzg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iZts6-0005U7-4D; Wed, 27 Nov 2019 09:44:30 +0000
Date:   Wed, 27 Nov 2019 01:44:30 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] fs/splice: ignore flag SPLICE_F_GIFT in syscall
 vmsplice
Message-ID: <20191127094430.GA20895@infradead.org>
References: <157374079193.8131.5211902043079599773.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157374079193.8131.5211902043079599773.stgit@buzz>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
