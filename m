Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B018D45DB2B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Nov 2021 14:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345435AbhKYNh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Nov 2021 08:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354973AbhKYNfz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:35:55 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C21FC0613FA;
        Thu, 25 Nov 2021 05:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yhVxFenIgPub/w/35qpJsH+EleYVEBaF1uzR5/OHDEM=; b=nMuZ5q02ftuZdEXrib8QaEHK/K
        NnfP+itfJuQyqIjVI7AmefG1L1r52syNdNFoYXB4lEfnc1oKrUxPfIRJpxOPELHp14ksnn5rl4noV
        W59zMB/A77wXgelkO2dg0jPl7mJFbCqfrd13V8PZPV9kzdAa8w1H3CIWxlqLm2cbVlNxx3Itd4c4F
        ej8SlPj8Pi21rg1DVmfsAgvTqHfs/OVjnTYGPdbuwNyI6M/BNbaSGYBlORxhVrGGvaVbX96ZuQHl1
        22OEyr8FoeLeziUyjm+IoaYBpcLVaOq1061+B7oob/smkZvW15j4j9mfEhz5KkaBImatEApExMqYo
        VX90oSYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mqEjG-007e8A-Ih; Thu, 25 Nov 2021 13:23:58 +0000
Date:   Thu, 25 Nov 2021 05:23:58 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/iomap: Fix write path page prefaulting
Message-ID: <YZ+Obqig1hwB0HPB@infradead.org>
References: <20211123151812.361624-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123151812.361624-1-agruenba@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
