Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30D47DFA9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346856AbhLWHkN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbhLWHkM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:40:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F5C061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=OxdKmHACsR9NUSop753eyK07SV
        nNGqK4vRcoN1K9Uo5WuUcFuyRyV0vcEebfxpwXEyQYCNP2DWG70gOajPcVf3N07CL+Nlpk/go/noE
        9LbidVQWYDJp+MaE+LNro6Ydv/dbtlt5GEAB+QCpg4CrcldSLn/EM9VBfFTeYk7IKBaUmD2jStidM
        fVRjA2RiIumUVCK4DI7Nbed9LI/0/5Msa+UN9ohDuOUyfkn8p2J1IYn65OJZjse42VkPc5jUkh5f3
        AFKnIyMzJtaui24h8Oefsv9J+2m8JeJGFvTkYlNcERMJVpobRwAXTS4XPRW0FhmUsm1ZH3T/WIoTr
        LTNQv1/A==;
Received: from 089144214178.atnat0023.highway.a1.net ([89.144.214.178] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0Ihu-00Bz40-U2; Thu, 23 Dec 2021 07:40:11 +0000
Date:   Thu, 23 Dec 2021 08:40:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 26/48] filemap: Convert filemap_get_pages to use folios
Message-ID: <YcQlj3anY9ptxt3c@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-27-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-27-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
