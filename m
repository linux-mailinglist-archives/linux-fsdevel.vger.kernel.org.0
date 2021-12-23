Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2A247DF74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 08:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242510AbhLWHSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 02:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235223AbhLWHSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 02:18:43 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EEEC061401
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Dec 2021 23:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cxX84lO9YP6mf7DfB39Df6hlV5yjKBt9IKjMxiN1aZA=; b=yq4oVThxOTrV/a1QlhL3cgAarI
        6/cTym42EPHArQQI7MZTTePkrdyHIylNEFfxHn1M+q9wdpYrDWLEQXUGB6SbzyLLHPDJv6d8v8slr
        QapYhxgBFLsa3DiWpUxs0FbJXbLV+zyLomZyGhOUijDhGk8SqrkuFtDUPt5u13u+m1TRIJdY4ATrB
        430PqRCn4fO0cInhPzJ6CFob3v8Dz7U5QK+uOPc/JvTVlPP9Ew7KPnAxFqw0gLiV3Dra0YVr979mk
        5dI7v9aVC1V6hHRloQoT/UYaN+BWsqKlwR5+ltGHqx0CHrMJECnPZV0deJ+g/IHaUHcpRMFKFblIk
        QDClFMXA==;
Received: from 089144208226.atnat0017.highway.a1.net ([89.144.208.226] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n0IN8-00Bxp7-Fd; Thu, 23 Dec 2021 07:18:43 +0000
Date:   Thu, 23 Dec 2021 08:18:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 20/48] filemap: Convert filemap_range_uptodate to folios
Message-ID: <YcQiz/JTvI24rCMd@infradead.org>
References: <20211208042256.1923824-1-willy@infradead.org>
 <20211208042256.1923824-21-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208042256.1923824-21-willy@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:22:28AM +0000, Matthew Wilcox (Oracle) wrote:
> The only caller was already passing a head page, so this simply avoids
> a call to compound_head().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
