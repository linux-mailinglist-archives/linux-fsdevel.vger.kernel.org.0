Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888B36177EC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Nov 2022 08:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKCHrc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Nov 2022 03:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiKCHr3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:47:29 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3395A2ACB;
        Thu,  3 Nov 2022 00:47:28 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3149E68AA6; Thu,  3 Nov 2022 08:47:24 +0100 (CET)
Date:   Thu, 3 Nov 2022 08:47:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Guillermo Rodriguez Garcia <guille.rodriguez@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Subject: Re: fs: layered device driver to write to evdev
Message-ID: <20221103074724.GA2685@lst.de>
References: <CABDcava8ADBNrVNh+7A2jG-LgEipcapU8dVh8p+jX-D4kgfzRg@mail.gmail.com> <CABDcava_0n2-WdyW6xO-18hTPNLpdnGVGoMY4QtPhnEVYT90-w@mail.gmail.com> <Y2MFe1pRdH35fxU8@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2MFe1pRdH35fxU8@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 02, 2022 at 05:04:11PM -0700, Luis Chamberlain wrote:
> On Wed, Nov 02, 2022 at 02:14:24PM +0100, Guillermo Rodriguez Garcia wrote:
> > I understand that device drivers should implement ->write_iter if they
> > need to be written from kernel space, but evdev does not support this.
> > What is the recommended way to have a layered device driver that can
> > talk to evdev ?
> 
> Shouldn't just writing write_iter support make this work?

Writing to evdev just sound like a lot of troble.  evdev is a tiny
wrapper to expose the in-kernel input API to userspace.  Anything
in-kernel should just directly interact with the input subsystem.

