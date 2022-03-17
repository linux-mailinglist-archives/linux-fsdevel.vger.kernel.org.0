Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9698B4DBF4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 07:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiCQGUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 02:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiCQGUL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:20:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77345111777;
        Wed, 16 Mar 2022 23:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=WKhGOsAACM1OV4BTcw0P1QEvmLUUvdDHRLBA83a5pII=; b=JuUbDD8Uhr3l+iB1i38NPYF/B+
        A70rbezTyjtL7z/0OQscS4GGQ1WJ1TgLcjw4wmybUo6Rhqj5Ix+pfDHhB2J2iJX2J0+xOXl0DcWGE
        ZSl8DuBGM/w+rWKsegxl9JNBLRwkwM214dynQ3+C287kWKj8CjDiGOYtk3BCIiDb0Sgu4z4CLXV9O
        Z0RZKVWQG7eMrupLCFdrImhrp/kSQdP1eqV4AWmim+soaVxGObgrSPngtAB7GxPJYBKtrgRdeq5mU
        ZVu2urOAiXpVWxdGBa5neqp0N3vgu+z/FkOQfWBgqEtGxeLsx3eKiS8hxK0aQzwegWAXd6TP8YMtO
        XpNhE20Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUhgf-001mDS-2Z; Thu, 17 Mar 2022 04:24:33 +0000
Message-ID: <16509fb6-e40c-e31b-2c80-264c44b0beb9@infradead.org>
Date:   Wed, 16 Mar 2022 21:24:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: mmotm 2022-03-16-17-42 uploaded (drivers/iio/afe/iio-rescale.o)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Peter Rosin <peda@axentia.se>, linux-iio@vger.kernel.org
References: <20220317004304.95F89C340E9@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220317004304.95F89C340E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 3/16/22 17:43, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-03-16-17-42 has been uploaded to
> 
>    https://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> https://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.
> 
> You will need quilt to apply these patches to the latest Linus release (5.x
> or 5.x-rcY).  The series file is in broken-out.tar.gz and is duplicated in
> https://ozlabs.org/~akpm/mmotm/series


on x86_64:

ERROR: modpost: missing MODULE_LICENSE() in drivers/iio/afe/iio-rescale.o



-- 
~Randy
