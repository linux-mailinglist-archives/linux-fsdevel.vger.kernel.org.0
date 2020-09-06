Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0006625F103
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Sep 2020 01:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgIFXHQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Sep 2020 19:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgIFXHP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Sep 2020 19:07:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA816C061573
        for <linux-fsdevel@vger.kernel.org>; Sun,  6 Sep 2020 16:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=U7K+1vhGgZ1+z6ubWjit5Ez1RXRmKgqQ0rZSsK2XVpI=; b=tvZnwH9kaaXlPFpv2FoLV7zPzG
        fq8nbId3szzmfSPQSoMSMeLV+4MQqwE8U0kxNksWk7vWrHhZFs6el1NPsoapLwlGnVD+6jVFCPXkL
        02tcUvtoGXbn2N5eef18R75/mdktPupdmbv8sg7siZIj5lYOC0lEQkbnYBDQgOclgMIjVscU8Hp7G
        8TRkMWtQ83Rj67eAYvp8UFMREFGt3963uC3PtaQHfhOfBPC5VBWhhQ0AQVfQrH8T+cgf3W7t//S3j
        9rdAX1FmuWpiVZOwoDuBtKliLajffXGlXQTmJfVuexAcEYVvgJFqba6OgJvxK4thVyCEYkJwct8Ti
        m7ZoKJ4w==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kF3kX-0000WM-GZ; Sun, 06 Sep 2020 23:07:05 +0000
Date:   Mon, 7 Sep 2020 00:07:05 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] fs: Remove duplicated flag O_NDELAY occurring twice
 in VALID_OPEN_FLAGS
Message-ID: <20200906230705.GA27537@casper.infradead.org>
References: <20200906223949.62771-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200906223949.62771-1-kw@linux.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Sep 06, 2020 at 10:39:49PM +0000, Krzysztof Wilczyński wrote:
> The O_NDELAY flag occurs twice in the VALID_OPEN_FLAGS definition, this
> change removes the duplicate.  There is no change to the functionality.
> 
> Note, that the flags O_NONBLOCK and O_NDELAY are not duplicates, as
> values of these flags are platform dependent, and on platforms like
> Sparc O_NONBLOCK and O_NDELAY are not the same.
> 
> This has been done that way to maintain the ABI compatibility with
> Solaris since the Sparc port was first introduced.
> 
> This change resolves the following Coccinelle warning:
> 
>   include/linux/fcntl.h:11:13-21: duplicated argument to & or |
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
