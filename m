Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A992315A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jul 2020 00:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgG1Wjb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 18:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1Wjb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:39:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB18CC061794;
        Tue, 28 Jul 2020 15:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=mgrOVNsJExTMhqYMtbX6J4NO2gZpZZrUvirpcTa6IUQ=; b=GnWABv9Ve99mPJ0ZOctgpp9DYG
        GDkXrxCqFXfJ52gWp1pgJ0CrubNg01A8tpszwokUc8qaCygHpozaywsQ779TCs1pEWedw3Rmmr5QJ
        MFJG6sl6iF8JLfSH7e+VEo+gF607okXXGb/MZ+vefvPBcld7UOa/3fK4nrQzxOW4/jU12GSMaYjNN
        N8iEAzeZoPjZ49eh//DvboX8KXUg3Dnf4DFr2GQ+Km+GT1EhOvmeBQzCVhFjLbNPZG8/wEVuNxzkV
        mIAyLWPxqQUWpyGawODST/ahQtwdcKsRDnUCZ4/bKEK3NrYTNNEMJA9ExxeA45QpxNJbmdR3CH6Co
        wlSOKeYQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0YFo-0008VE-Dw; Tue, 28 Jul 2020 22:39:28 +0000
Subject: Re: mmotm 2020-07-27-18-18 uploaded (mm/page_alloc.c)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au
References: <20200728011914.S-8vAYUK0%akpm@linux-foundation.org>
 <ae87385b-f830-dbdf-ebc7-1afb82a7fed0@infradead.org>
 <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <048cef07-ad4b-8788-94a4-e144de731ab6@infradead.org>
Date:   Tue, 28 Jul 2020 15:39:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728145553.2a69fa2080de01922b3a74e0@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/28/20 2:55 PM, Andrew Morton wrote:
> On Tue, 28 Jul 2020 05:33:58 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 7/27/20 6:19 PM, Andrew Morton wrote:
>>> The mm-of-the-moment snapshot 2020-07-27-18-18 has been uploaded to
>>>
>>>    http://www.ozlabs.org/~akpm/mmotm/


>> on x86_64:
>>
>> ../mm/page_alloc.c:8355:48: warning: ‘struct compact_control’ declared inside parameter list will not be visible outside of this definition or declaration
>>  static int __alloc_contig_migrate_range(struct compact_control *cc,
>>                                                 ^~~~~~~~~~~~~~~
> 
> As is usually the case with your reports, I can't figure out how to
> reproduce it.  I copy then .config, run `make oldconfig' (need to hit
> enter a zillion times because the .config is whacky) then the build
> succeeds.  What's the secret?

I was not aware that there was a problem. cp .config and make oldconfig
should be sufficient -- and I don't understand why you would need to hit
enter many times.

I repeated this on my system without having to answer any oldconfig prompts
and still got build errors.

There is no secret that I know of, but it would be good to get to the
bottom of this problem.

-- 
~Randy

