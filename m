Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4A917470F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 08:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfGYGVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 02:21:51 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:42849 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbfGYGVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 02:21:51 -0400
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9BA7EE0008;
        Thu, 25 Jul 2019 06:21:46 +0000 (UTC)
Subject: Re: [EXTERNAL][PATCH REBASE v4 00/14] Provide generic top-down mmap
 layout functions
To:     Paul Burton <paul.burton@mips.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20190724055850.6232-1-alex@ghiti.fr>
 <20190724201819.6bhvyugquhfrldfa@pburton-laptop>
From:   Alexandre Ghiti <alex@ghiti.fr>
Message-ID: <9019120e-fc69-22a3-6733-cba27f8eab4c@ghiti.fr>
Date:   Thu, 25 Jul 2019 08:21:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190724201819.6bhvyugquhfrldfa@pburton-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: fr
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 7/24/19 10:18 PM, Paul Burton wrote:
> Hi Alexandre,
>
> On Wed, Jul 24, 2019 at 01:58:36AM -0400, Alexandre Ghiti wrote:
>> Hi Andrew,
>>
>> This is simply a rebase on top of next-20190719, where I added various
>> Acked/Reviewed-by from Kees and Catalin and a note on commit 08/14 suggested
>> by Kees regarding the removal of STACK_RND_MASK that is safe doing.
>>
>> I would have appreciated a feedback from a mips maintainer but failed to get
>> it: can you consider this series for inclusion anyway ? Mips parts have been
>> reviewed-by Kees.
> Whilst skimming email on vacation I hadn't spotted how extensive the
> changes in v4 were after acking v3... In any case, for patches 11-13:
>
>      Acked-by: Paul Burton <paul.burton@mips.com>


Great, thanks Paul ! I have just noticed there is an error in patch 11/14,
but without much incidence since it gets fixed in patch 13/14. I'll see with
Andrew if he wants a new version or not.


Thanks for your time,


Alex


>
> Thanks,
>      Paul
>
