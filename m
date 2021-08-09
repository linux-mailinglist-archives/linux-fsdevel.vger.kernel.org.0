Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7FF13E4A62
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Aug 2021 18:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhHIQ6b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Aug 2021 12:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhHIQ62 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:58:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E965C0613D3;
        Mon,  9 Aug 2021 09:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=XJTL30sAj9E9k7u4K2CujkBqTC4qltRCjV1W7d4ixI0=; b=VNa7eunhb8FFYA2M0yUs99Wmts
        Jdzws2x/kGUFZW0jbjJGB7qUlfxVYWjh8INtddLdfl8vz2QcvaYmq2XTqogGBk7JCD/w3EfyYNNN6
        uUjLi9YkKlD4SiPSAf7DsZmpGEfzJJ++oaxKQYRyGb1mvHgXDtrQBd1MejkXO0rjBjFLXeXJxq2Z9
        u3zscfdQyuiQPv1TrM3XVJXcvdY55qXXaADELqmUPEI+mRv8qRsOHyV6SekSc81Taqy1I2c54meMM
        pfiKrouH3NLFWTK5TacbWUoaxIr8CCIUSeUp3QsZdN6FXQV2nN1XQ7IKDZEpWxXmv+MaAjOMlSMhJ
        1q1Q/Etg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mD8Xh-00BCbx-6t; Mon, 09 Aug 2021 16:54:55 +0000
Subject: Re: [PATCH v27 10/10] fs/ntfs3: Add MAINTAINERS
To:     Kari Argillander <kari.argillander@gmail.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>,
        "linux-ntfs-dev@lists.sourceforge.net" 
        <linux-ntfs-dev@lists.sourceforge.net>,
        "anton@tuxera.com" <anton@tuxera.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "hch@lst.de" <hch@lst.de>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "andy.lavr@gmail.com" <andy.lavr@gmail.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>
References: <20210729134943.778917-1-almaz.alexandrovich@paragon-software.com>
 <20210729134943.778917-11-almaz.alexandrovich@paragon-software.com>
 <20210809105652.GK5047@twin.jikos.cz>
 <918ff89414fa49f8bcb2dfd00a7b0f0b@paragon-software.com>
 <20210809164425.rcxtftvb2dq644k5@kari-VirtualBox>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <305bdb56-d40f-2774-12fe-5113f15df5c6@infradead.org>
Date:   Mon, 9 Aug 2021 09:54:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809164425.rcxtftvb2dq644k5@kari-VirtualBox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/9/21 9:44 AM, Kari Argillander wrote:
> On Mon, Aug 09, 2021 at 04:16:32PM +0000, Konstantin Komarov wrote:
>> From: David Sterba <dsterba@suse.cz>
>> Sent: Monday, August 9, 2021 1:57 PM
>>> On Thu, Jul 29, 2021 at 04:49:43PM +0300, Konstantin Komarov wrote:
>>>> This adds MAINTAINERS
>>>>
>>>> Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>>>> ---
>>>>   MAINTAINERS | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 9c3428380..3b6b48537 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -13279,6 +13279,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
>>>>   F:	Documentation/filesystems/ntfs.rst
>>>>   F:	fs/ntfs/
>>>>
>>>> +NTFS3 FILESYSTEM
>>>> +M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
>>>> +S:	Supported
>>>> +W:	http://www.paragon-software.com/
>>>> +F:	Documentation/filesystems/ntfs3.rst
>>>> +F:	fs/ntfs3/
>>>
>>> Can you please add a git tree and mailing list entries?
> 
>> Hi David, I'll add the git tree link for the sources to MAINTAINERS in the next patch. As for the mailing list,
>> apologies for the newbie question here, but will it possible to have the @vger.kernel.org list for the ntfs3,
>> or it must be external for our case?
>> Thanks!
> 
> Good question and I also do not have absolute truth about it but I try
> to help. It should be possible. I think you can request new list from
> postmaster@vger.kernel.org
> 
> If you need public git tree then kernel.org can maybe provide that. They
> also host ntfs so I think no problem with ntfs3. This way you self
> do not have to worry public list. But I'm not sure how strict is now
> days get account. But if you say that it would be nice that you need
> kernel git then maybe someone can help with that.
> See more info https://www.kernel.org/faq.html

If postmaster@vger.kernel.org isn't helpful or you just want to use
kernel.org (note that vger.kernel.org isn't part of kernel.org),
you can contact: helpdesk@kernel.org  for git tree or mailing list
requests.  Wherever you have a mailing list, you probably should
have it archived at lore.kernel.org (see next URL for that).

Also you may want to read  https://korg.wiki.kernel.org

-- 
~Randy

