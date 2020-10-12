Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE1428C43A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Oct 2020 23:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgJLVnZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 17:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgJLVnY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 17:43:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897ADC0613D0;
        Mon, 12 Oct 2020 14:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ZI0Kdum38xI6uGs3y2Dg7AaEs3YQjEOBKT9911THbyU=; b=D+Wm1k2eypHkVHYf7ZCEzBtaqm
        GBe8TbPGD+fLHBo2kifrmhmXBlqmo+XaNDTSR0RhSUeyKhbUzZovIa7dQuGqkXxHAIznesk/nJX6X
        qVVs5FPRycE/B2MJUbFXS0au51AgoyHMY/iwsdEcplb7zvpPjK67EGfQPo9ca/eqvh2zOiXRxWrDk
        E3JODh21n5PqqQ/iDQCRUlcR9tekx0M8QHoSLKAkPOQVBVDHH30/8p+JzHkpwmrene0Do2Bo+x7Wr
        Mi87DAyK0BCuCLUCNXObEqAJt0gt7jOM4xInSu/R3Av9iX8CGyL6KPrjuruxkNIrpishX0+1EHtzm
        2xzO4MMg==;
Received: from [2601:1c0:6280:3f0::507c]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kS5bD-0007m8-3m; Mon, 12 Oct 2020 21:43:19 +0000
Subject: Re: Regression: epoll edge-triggered (EPOLLET) for pipes/FIFOs
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Alexander Viro <aviro@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Ian Kent <raven@themaw.net>,
        Christian Brauner <christian@brauner.io>,
        keyrings@vger.kernel.org,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Davide Libenzi <davidel@xmailserver.org>
References: <CAKgNAkjMBGeAwF=2MKK758BhxvW58wYTgYKB2V-gY1PwXxrH+Q@mail.gmail.com>
 <CAHk-=wig1HDZzkDEOxsxUjr7jMU_R5Z1s+v_JnFBv4HtBfP7QQ@mail.gmail.com>
 <81229415-fb97-51f7-332c-d5e468bcbf2a@gmail.com>
 <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <22d3e535-564e-ebb9-991b-b328f9f806ed@infradead.org>
Date:   Mon, 12 Oct 2020 14:43:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgjR7Nd4CyDoi3SH9kPJp_Td9S-hhFJZMqvp6GS1Ww8eg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/12/20 1:52 PM, Linus Torvalds wrote:
> On Mon, Oct 12, 2020 at 1:30 PM Michael Kerrisk (man-pages)
> 
> I'm busy merging, mind testing this odd patch out? It is _entirely_
> untested, but from the symptoms I think it's the obvious fix.
> 
> I did the same thing for the "reader starting out from a full pipe" case too.
> 
>                Linus
> 

and if that patch tests good, then fix this typo, please:

+	 * Epoll nonsensically wants a wakeup wheher the pipe was

	                                      whether

thanks.
-- 
~Randy

