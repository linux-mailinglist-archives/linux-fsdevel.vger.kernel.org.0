Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F47B1F1C71
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jun 2020 17:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730359AbgFHPwr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jun 2020 11:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgFHPwq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jun 2020 11:52:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F28C08C5C2;
        Mon,  8 Jun 2020 08:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=7YZ+NEpUkUU01S+Ul8fTEjP7uNZSOxcsEbJYlol5Gxs=; b=elzwh9ujcAt3twEQf4TkbxU4HP
        wBCpKh63dAQ0/re1iUHWxOjOP9gSySekqlUiiHVkQfePH1as9TdP8l5/6lXlnNo1F4wyaQHcRQoaf
        ZPLn9GbYvD/1yrqg+Rk6uu0TfYaRzA/Q9qHC7EoaM4qsnUb7+alp8PLPsy2CAQJBkgb3DmsdPD9ih
        bVK3uZHqBvWa1Cd2dzPtxEQMNHMP8NlqFg4NU9Q+/ZZrfzJqTscIztyijSHJJPIdTG3GOx3JfdCet
        Lk7nKDiKL45GPFwFSLD2HPY/YlcSAwAbKJmgycFoJFidpMzGgeS0Je/5i1jXoZKKKnFEXeESFEdD8
        CBeJYGyA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiK4p-0005YC-MB; Mon, 08 Jun 2020 15:52:43 +0000
Date:   Mon, 8 Jun 2020 08:52:43 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        Tetsuhiro Kohada <kohada.t2@gmail.com>
Subject: Re: [PATCH] exfat: Fix use after free in exfat_load_upcase_table()
Message-ID: <20200608155243.GX19604@bombadil.infradead.org>
References: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b9272fb-b265-010b-0696-4c0579abd841@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 08, 2020 at 05:07:33PM +0200, Markus Elfring wrote:
> > This code calls brelse(bh) and then dereferences "bh" on the next line
> > resulting in a possible use after free.
> 
> There is an unfortunate function call sequence.
> 
> 
> > The brelse() should just be moved down a line.
> 
> How do you think about a wording variant like the following?
> 
>    Thus move a call of the function “brelse” one line down.
> 
> 
> Would you like to omit a word from the patch subject so that
> a typo will be avoided there?

Markus, please go away.  This comment is entirely unhelpful.

