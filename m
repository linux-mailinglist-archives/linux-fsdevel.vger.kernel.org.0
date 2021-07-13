Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B94F3C77EF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jul 2021 22:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhGMU06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Jul 2021 16:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbhGMU06 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Jul 2021 16:26:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DF5C0613DD;
        Tue, 13 Jul 2021 13:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=5/KBP87pxftrobVJwcPVKbF/bN/LJFwKGUBAPeXS5hE=; b=DEhXLD6vRlQBOF1tVBA1ZlR1iY
        G5R9qtBjFVqD1l4yAewXP7lIB5wFcu2WWkjBcnURj7K/GCaa0WlAw7bqLmyNjZtaPqdcmwa2AXeuu
        OZh7l74BpwEif50/Pa0tMKza/WnalkWjCOjNDuEDNx75MOn1Q8slglyIHOJ8KVppTlEJsaTZhpdFV
        KDf9zx4IURkiuHeEtWio1s6wxGzTjhl940lXWkGiPNGpu+N6ttX3wd+rQ1bss1r6YhTxebX8LQ5To
        3jeTWUZtseI98aptkk/DtnmIG9DvIljdXDhCHRiYszSRCJgNktQqd38x5ZNjEs/pMUx+Yd7iJiaNV
        GRYprOdA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3Owp-00BIzD-8p; Tue, 13 Jul 2021 20:24:07 +0000
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <YO31DWtFMZuqF8tm@zeniv-ca.linux.org.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fac8ca82-8e9e-cbcf-2e68-b2b281ab0127@infradead.org>
Date:   Tue, 13 Jul 2021 13:24:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YO31DWtFMZuqF8tm@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/13/21 1:18 PM, Al Viro wrote:
> On Tue, Jul 13, 2021 at 08:14:04PM +0000, Al Viro wrote:
>> On Tue, Jul 13, 2021 at 12:15:13PM -0700, Linus Torvalds wrote:
>>> On Tue, Jul 13, 2021 at 3:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
...
>>>
>>> (When something then touches the *common* vfs code, that's a different
>>> thing - but something like this vboxsf thing this pull request looks
>>> normal to me).
>>
>> To elaborate a bit - there's one case when I want it to go through
>> vfs.git, and that's when there's an interference between something
>> going on in vfs.git and the work done in filesystem.
> 
> Example: if there's a series changing calling conventions for some method
> brewing in vfs.git and changes to filesystem's instance of that method
> in the filesystem tree.  Then I'd rather it coordinated before either
> gets merged.  It might be an invariant branch in either tree pulled by
> both, it might be a straight pull into vfs.git and sorting the things out
> there - depends upon the situation.
> 

Hi Al,

Where would you prefer for kernel-doc changes in fs/*.[ch] be merged?

E.g., from June 27:

https://lore.kernel.org/linux-fsdevel/20210628014613.11296-1-rdunlap@infradead.org/


thanks.
-- 
~Randy

