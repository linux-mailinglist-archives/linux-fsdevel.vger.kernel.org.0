Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57F3F6A93
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 22:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhHXUlj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 16:41:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58816 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbhHXUli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 16:41:38 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52786220E2;
        Tue, 24 Aug 2021 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629837653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BR4XcKHpdq9KRj9l2XI8jpZBMcwa9vBeDkTUU+ZLdAY=;
        b=T0jFlg3lVEUqGYQb/WAPAawsOOuaP2i4f/HN/+UYrnXp51JuiS1ruwiosvaljPswEpTvgq
        AeVseSDLgE7L894PAr1lzsbPVU+MBn+j9LLFhKrDfMHCWDpunrjzupQtROS5JdZlFlbujX
        KXMpzkAAKMX0xfDFcjIDumgia3AQONE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629837653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BR4XcKHpdq9KRj9l2XI8jpZBMcwa9vBeDkTUU+ZLdAY=;
        b=pfIS8vqzZvbS/YFt6CCW35TW2x9ugI/5t68/nooaKlWIP4PV4/35Vi7JRIFupMySVY8C+4
        Rht0t0XUjctfv0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C3CA13B56;
        Tue, 24 Aug 2021 20:40:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CQxmCVVZJWFUawAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 24 Aug 2021 20:40:53 +0000
Subject: Re: [GIT PULL] Memory folios for v5.15
From:   Vlastimil Babka <vbabka@suse.cz>
To:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <YSVHI9iaamxTGmI7@casper.infradead.org>
 <CAHk-=wjD8i2zJVQ9SfF2t=_0Fkgy-i5Z=mQjCw36AHvbBTGXyg@mail.gmail.com>
 <YSPwmNNuuQhXNToQ@casper.infradead.org> <YSQSkSOWtJCE4g8p@cmpxchg.org>
 <1957060.1629820467@warthog.procyon.org.uk>
 <YSUy2WwO9cuokkW0@casper.infradead.org>
 <CAHk-=wip=366HxkJvTfABuPUxwjGsFK4YYMgXNY9VSkJNp=-XA@mail.gmail.com>
 <YSVCAJDYShQke6Sy@casper.infradead.org>
 <CAHk-=wisF580D_g+wFt0B_uijSX+mCgz6tRRT5KADnO7Y97t-g@mail.gmail.com>
 <1967144.1629833751@warthog.procyon.org.uk>
 <0ab69444-2d39-27bf-4be1-2a5401c16eac@suse.cz>
Message-ID: <793187d4-835f-a67e-392d-0d88e0a3a4fe@suse.cz>
Date:   Tue, 24 Aug 2021 22:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <0ab69444-2d39-27bf-4be1-2a5401c16eac@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/24/21 10:35 PM, Vlastimil Babka wrote:
> On 8/24/21 9:35 PM, David Howells wrote:
>> Matthew Wilcox <willy@infradead.org> wrote:
>>
>>> Sure, but at the time Jeff Bonwick chose it, it had no meaning in
>>> computer science or operating system design.  Whatever name is chosen,
>>> we'll get used to it.  I don't even care what name it is.
>>>
>>> I want "short" because it ends up used everywhere.  I don't want to
>>> be typing
>>> 	lock_hippopotamus(hippopotamus);
>>>
>>> and I want greppable so it's not confused with something somebody else
>>> has already used as an identifier.
>>
>> Can you live with pageset?
> 
> Pagesets already exist in the page allocator internals. Yeah, could be
> renamed as it's not visible outside.

Should have read the rest of thread before replying.

Maybe in the spirit of the discussion we could call it pageshed?

/me hides

>> David
>>
>>
> 
> 

