Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16074770268
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 15:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjHDN7Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 09:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbjHDN7O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:59:14 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E784C11B;
        Fri,  4 Aug 2023 06:59:13 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2B0CE68B05; Fri,  4 Aug 2023 15:59:09 +0200 (CEST)
Date:   Fri, 4 Aug 2023 15:59:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] file: always lock position
Message-ID: <20230804135908.GA27513@lst.de>
References: <20230724-vfs-fdget_pos-v1-1-a4abfd7103f3@kernel.org> <CAHk-=whfJhag+iEscftpVq=dHTeL7rQopCvH+Pcs8vJHCGNvXQ@mail.gmail.com> <20230724-pyjama-papier-9e4cdf5359cb@brauner> <CAHk-=wj2XZqex6kzz7SbdVHwP9fFoOvHSzHj--0KuxyrVO+3-w@mail.gmail.com> <20230803095311.ijpvhx3fyrbkasul@f> <CAHk-=whQ51+rKrnUYeuw3EgJMv2RJrwd7UO9qCgOkUdJzcirWw@mail.gmail.com> <20230803-libellen-klebrig-0a9e19dfa7dd@brauner> <CAHk-=wi97khTatMKCvJD4tBkf6rMKTP=fLQDnok7MGEEewSz9g@mail.gmail.com> <20230804-turnverein-misswirtschaft-ef07a4d7bbec@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804-turnverein-misswirtschaft-ef07a4d7bbec@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 04, 2023 at 03:43:20PM +0200, Christian Brauner wrote:
> > I don't think we have any free flags, but I didn't check. The ugly
> 
> We do. Christoph freed up 3 last cycle. I think I mentioned it in one my
> prs. (And btw, we should probably try to get rid of a few more.)

I have a half-backed series to move all the static capabilities into
a new field in struct file_operations.  That gives us almost half a dozen
back.  I wanted to finish it for this merge window, but there are too
many conflicting other things going on, so it will have to wait a bit
longer.

