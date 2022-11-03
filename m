Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80A53617330
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 01:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiKCAEQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 20:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiKCAEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 20:04:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD972678;
        Wed,  2 Nov 2022 17:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=laEgCvWeF14HgMGYzXP7ifDEMuDZ19cGQjHseb3yC3A=; b=W+ebfc+8XwqXpdnDAUHllfBvJx
        iBwlGDmLmXCfPZcUX+rGDYI5o/ypW3sw6Wf64LvJZLcLmx6R0wbMFQDFW7NuLifTQVzfw9t8w9n9P
        jitQ+vzxjf9BX7V1PpjQaGXWeiZpaS71pguxgbzhDjl0t6ZuJY6LEH3kX7UJm0NG9E/zbzmRJHYCy
        R03l3UO1Qzm7CmUpEQSSbg7I2lRYL74trSCwLEpcVnYWfCgShnrN1GV4DXwhBDI7s47W3lc/QisAQ
        pPNS7FtIuIiCGQmoQAe5jcAdoKIyY8dIuncqAGjdGzEnBkg3xGvjpHF0etxZfNPcSPT4GtCpvyIJG
        8H6Cl3ZA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqNiN-00FGOU-VU; Thu, 03 Nov 2022 00:04:11 +0000
Date:   Wed, 2 Nov 2022 17:04:11 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: fs: layered device driver to write to evdev
Message-ID: <Y2MFe1pRdH35fxU8@bombadil.infradead.org>
References: <CABDcava8ADBNrVNh+7A2jG-LgEipcapU8dVh8p+jX-D4kgfzRg@mail.gmail.com>
 <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 02:14:24PM +0100, Guillermo Rodriguez Garcia wrote:
> I understand that device drivers should implement ->write_iter if they
> need to be written from kernel space, but evdev does not support this.
> What is the recommended way to have a layered device driver that can
> talk to evdev ?

Shouldn't just writing write_iter support make this work?

  Luis
