Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6C250F9F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 12:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348666AbiDZKRd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 06:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348680AbiDZKRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:17:04 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A46D3BF;
        Tue, 26 Apr 2022 02:40:37 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1njHg0-006xZ5-JA; Tue, 26 Apr 2022 19:40:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 26 Apr 2022 17:40:08 +0800
Date:   Tue, 26 Apr 2022 17:40:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Conor.Dooley@microchip.com
Cc:     rdunlap@infradead.org, sfr@canb.auug.org.au,
        akpm@linux-foundation.org, mhocko@suse.cz,
        linux-crypto@vger.kernel.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-next@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: mmotm 2022-04-25-17-59 uploaded
 (drivers/char/hw_random/mpfs-rng.c)
Message-ID: <Yme9+HuB2N3KOMf+@gondor.apana.org.au>
References: <20220426005932.848CBC385A4@smtp.kernel.org>
 <6ff380c5-4f2c-44ea-2541-b32733e45ac3@infradead.org>
 <191e32d7-efde-327e-b112-000d8f778996@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191e32d7-efde-327e-b112-000d8f778996@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 06:36:27AM +0000, Conor.Dooley@microchip.com wrote:
>
> @Herbert, would you rather revert the part of 6a71277ce91e that enables
> compile test or I can send a patch for the stubbed versions now that
> there is a user for them? (My preference would be to keep COMPILE_TEST)

I'll just revert that patch because it turns out the underlying
option already supports COMPILE_TEST so this is redundant.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
