Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD145004D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 05:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiDNDye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 23:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiDNDyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 23:54:33 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A133F1D32B;
        Wed, 13 Apr 2022 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=e2IE6y8upDGME4pq7hb1E5/1es9xH7Kx1EBn5ly2PvM=; b=UB4Z/ZI5nB8gQcPZjqCEIb+ie3
        FrcHSoXOO/tnKcrJBXaIxDGcyvATD3w66R4GdQneAR/u3gtLWOyISGz5DP0KkeJPP6zchZZBQUgew
        DchcO2U8tYJ4ySAnqJfKEeeGv+lF38hN4/8nscpdoWu5BClKFySX7IfL3ZSt2fd12To1mMmLNLHHE
        mXMzKt1mNp5Rc+dATB0pPLgisWuaS8ldhGhmPghcIQr6oyByxkNWxMJQ5SB9wqX95ngpHrm5WBW0A
        mHMWiAxOqNaKRarlZ4drRj4G6f4fCszti8p874Rpjl0Bs4hm15bX01f6WShUoV27z1Sj6L539fybf
        NG5HMZFA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1neqWV-004tNH-Bv; Thu, 14 Apr 2022 03:52:00 +0000
Message-ID: <bc6de555-6fcf-16f3-bdb9-e591b5759e51@infradead.org>
Date:   Wed, 13 Apr 2022 20:51:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: mmotm 2022-04-12-21-05 uploaded (fs/btrfs/raid56.o)
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        linux-btrfs@vger.kernel.org
References: <20220413040610.06AAAC385A4@smtp.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220413040610.06AAAC385A4@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/12/22 21:06, Andrew Morton wrote:
> The mm-of-the-moment snapshot 2022-04-12-21-05 has been uploaded to
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
> 
> The file broken-out.tar.gz contains two datestamp files: .DATE and
> .DATE-yyyy-mm-dd-hh-mm-ss.  Both contain the string yyyy-mm-dd-hh-mm-ss,
> followed by the base kernel version against which this patch series is to
> be applied.

on i386:

ld: fs/btrfs/raid56.o: in function `alloc_rbio':
raid56.c:(.text+0x2778): undefined reference to `__udivdi3'
ld: raid56.c:(.text+0x2798): undefined reference to `__udivdi3'


-- 
~Randy
