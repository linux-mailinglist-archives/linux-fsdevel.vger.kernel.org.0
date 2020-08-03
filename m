Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8952F23AC75
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 20:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgHCSgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 14:36:35 -0400
Received: from linux.microsoft.com ([13.77.154.182]:34356 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCSgf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:36:35 -0400
Received: from [192.168.254.32] (unknown [47.187.206.220])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5A65A20B4908;
        Mon,  3 Aug 2020 11:36:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A65A20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596479794;
        bh=k+NMDSjwm5TFPTN2F24vsuQ9bd+RBG4+Qztk9DA9N5w=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DNQfd/jCHwvRYMF2gK893vUrxekiycxCw0OhCzNbUMcGiKSE03vK/bnQsLmcTSru/
         CtasfSm4QG8N9N4kZy69f3Os63Oj8jZa3a7vBD8/vw/IvmURd5dLVfTDYQE1RJ5X5C
         mMYCQph3slcm10L5a4Kvnyc+0DO+POBFk3obO0wY=
Subject: Re: [PATCH v1 0/4] [RFC] Implement Trampoline File Descriptor
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>
References: <20200728131050.24443-1-madvenka@linux.microsoft.com>
 <CALCETrVy5OMuUx04-wWk9FJbSxkrT2vMfN_kANinudrDwC4Cig@mail.gmail.com>
 <3b916198-3a98-bd19-9a1c-f2d8d44febe8@linux.microsoft.com>
 <CALCETrUJ2hBmJujyCtEqx4=pknRvjvi1-Gj9wfRcMMzejjKQsQ@mail.gmail.com>
From:   "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Message-ID: <dbc3bdcf-170c-4ffd-0efc-69495c8df11e@linux.microsoft.com>
Date:   Mon, 3 Aug 2020 13:36:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUJ2hBmJujyCtEqx4=pknRvjvi1-Gj9wfRcMMzejjKQsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 8/2/20 3:00 PM, Andy Lutomirski wrote:
> I feel like trampfd is too poorly defined at this point to evaluate.

Point taken. It is because I wanted to start with something small
and specific and expand it in the future. So, I did not really describe the big
picture - the overall vision, future work, that sort of thing. In retrospect,
may be, I should have done that.

I will take all of the input I have received so far and all of the responses
I have given, refine the definition of trampfd and send it out. Please
review that and let me know if anything is still missing from the
definition.

Thanks.

Madhavan

