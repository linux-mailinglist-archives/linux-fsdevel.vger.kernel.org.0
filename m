Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B829E216
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 03:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgJ2CFu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 22:05:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727066AbgJ1ViF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603921084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fkWfC7xHRg1lPmbvoyIGn22t41mdB4f5tgL/7eVd4rM=;
        b=UxvNdOaEKNqnVqL2NAC2VnLXkxf2+qJ5wRsdkVS0oqUPyBLk3qnv/mRytj7d3frKtoZ5xL
        Ji1n0p9PJX8ZzQmi3doDL/plDYjLDpLw7i5rEn+T0VUw9K5y4row5K9lnnxRlG8AOfCIcB
        j9+CZfxVGJ8jysa+KlaOhRxt6zz4+4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-_uhFhELPM_WVyShU7iOP6Q-1; Wed, 28 Oct 2020 12:34:29 -0400
X-MC-Unique: _uhFhELPM_WVyShU7iOP6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2472E8EBA0A;
        Wed, 28 Oct 2020 16:34:28 +0000 (UTC)
Received: from [10.10.115.31] (ovpn-115-31.rdu2.redhat.com [10.10.115.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EE8056EF4A;
        Wed, 28 Oct 2020 16:34:26 +0000 (UTC)
Subject: Re: [PATCH] dcookies: Make dcookies depend on CONFIG_OPROFILE
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        anmar.oueja@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <51a9a594a38ae6e0982e78976cf046fb55b63a8e.1603191669.git.viresh.kumar@linaro.org>
 <20201027085152.GB10053@infradead.org>
 <CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com>
From:   William Cohen <wcohen@redhat.com>
Message-ID: <b3a8e2e8-350f-65af-9707-a6d847352f8e@redhat.com>
Date:   Wed, 28 Oct 2020 12:34:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=whw9t3ZtV8iA2SJWYQS1VOJuS14P_qhj3v5-9PCBmGQww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/27/20 12:54 PM, Linus Torvalds wrote:
> On Tue, Oct 27, 2020 at 1:52 AM Christoph Hellwig <hch@infradead.org> wrote:
>>
>> Is it time to deprecate and eventually remove oprofile while we're at
>> it?
> 
> I think it's well past time.
> 
> I think the user-space "oprofile" program doesn't actually use the
> legacy kernel code any more, and hasn't for a long time.
> 
> But I might be wrong. Adding William Cohen to the cc, since he seems
> to still maintain it to make sure it builds etc.
> 
>              Linus
> 

Hi,

Yes, current OProfile code uses the existing linux perf infrastructure and doesn't use the old oprofile kernel code.  I have thought about removing that old oprofile driver code from kernel, but have not submitted patches for it. I would be fine with eliminating that code from the kernel.

-Will

