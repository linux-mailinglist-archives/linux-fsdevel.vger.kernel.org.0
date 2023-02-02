Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66E2687299
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Feb 2023 01:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjBBAzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 19:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBBAze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 19:55:34 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5244FAE7;
        Wed,  1 Feb 2023 16:55:31 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pNNsa-006ZcC-6G; Thu, 02 Feb 2023 08:55:09 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 02 Feb 2023 08:55:08 +0800
Date:   Thu, 2 Feb 2023 08:55:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, viro@zeniv.linux.org.uk,
        nspmangalore@gmail.com, rohiths.msft@gmail.com, tom@talpey.com,
        metze@samba.org, hch@infradead.org, willy@infradead.org,
        jlayton@kernel.org, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfrench@samba.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 05/12] cifs: Add a function to Hash the contents of an
 iterator
Message-ID: <Y9sJ7Nuubw1U4M6u@gondor.apana.org.au>
References: <Y9ooW52m0Afnhj7Z@gondor.apana.org.au>
 <312908.1675262203@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <312908.1675262203@warthog.procyon.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 01, 2023 at 02:36:43PM +0000, David Howells wrote:
> 
> It's already abusing the shash API, this doesn't change that, except where it
> gets the data from.

Oh OK.  All I saw was this one patch which added shash code.
Were you also deleting shash code in another patch that wasn't
cc'ed to me?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
