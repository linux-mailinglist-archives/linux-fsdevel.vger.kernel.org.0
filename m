Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82BBD6A6F39
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Mar 2023 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCAPVC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Mar 2023 10:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjCAPVA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:21:00 -0500
X-Greylist: delayed 578 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Mar 2023 07:20:59 PST
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB91E3D935
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Mar 2023 07:20:59 -0800 (PST)
Message-ID: <07171afd91dbd05b425d92e54f9832f9.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1677683475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ge2gMeYn/mxNyuWT6pZVfv5JaD2Ja3qS2UXGK5k2/sQ=;
        b=c3uFwkApM8GO/wRLbzV7nnacYkqtuPAsPK4oOnsDnFRb0bDLU8o1KEZq+3ROhl5J2QJUq+
        w8vsRg8MbTCT6LBl35lsEfT2cNYZqcXeAyS0oVh7faBjn3JeoO2//vlkmmnvuB7k/nujJw
        FYesVDqpJW+bdQ+gYqEHRz2mJO0JrJou+cUJYbcimDkbvev0XQ6QpdjiIt2YWAuwqo4G3s
        ujVwEX05bns0B+uYn6kuB4mz1QQK1kcJu+yRsHRL6kxQAGiW5w2OUO7BHJ/vDPIcdNp+Zd
        t7hA7O3jcyn0MdSrJvRaONkWm7BQ6NmSguyfA6AVeLrwJltMkQPvjnjo1ucZ5w==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1677683475; a=rsa-sha256;
        cv=none;
        b=UOfQz57WT91XfZUEU8ctR5DD/gXmULunIN8kpCHlMbHkKXkii/tpAqv2XJb8fAIWlDrAL3
        QeoZ+ohwfOnVInHufzK0nbRjKC5JoB2ywnolPm0BHpGIIkIYHxSqKfKAXijEPxTqK/qjK4
        PfQjVhuUXG0dfFSL2VR03NT14Xx4lZ9JZ1iVMLIVDJS41zikvvcPLxfiYJH9ofEZrPEw1G
        17sLKVmKxuXVCV4tuXJCjNh3v5j40iqo2JdarYbJqk+wtJq7ln/DRrdQi8vHGyOZlupw1+
        VQsZ513lB4c8m5b25eVP6reHA2Zop3+vaetVxmX8MWbcz7IJqd51ViSpsTcW6Q==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1677683475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ge2gMeYn/mxNyuWT6pZVfv5JaD2Ja3qS2UXGK5k2/sQ=;
        b=JVYtmjZKG8lWAgsGP5AI2ykDB10Nvp+NtRGVppMAB5hpDsLYT7VLdmDsQizmrZqXQqF2Fo
        WDRWs9RGA35Ywd+JEQr9BwnuhdRhcqG0YDSG0m49Ria5HfUkEXpnn71MPc1pRdUhvIsd2O
        /YHMLZ+i66KNyngyCfLkexqu5tSMONZPJZyBVHWiUvbkxHAxUOg/rrSHICcHOJuElGcqS2
        Ylv0UVkza3Eel5lZ+Vn/QLqRVc8B1OUB6k6tEouQkHPNL9oYXMlHL7WbOOB+BAZDar5t1B
        6Zl5ZDA9mI3/TJhHH7qUCmgsjh3jPCY2EECGYhHF6JQLCos9DNvAEB/I6uDHpw==
From:   Paulo Alcantara <pc@manguebit.com>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Steve French <sfrench@samba.org>
Subject: Re: [PATCH 1/1] cifs: Fix memory leak in direct I/O
In-Reply-To: <20230228223838.3794807-2-dhowells@redhat.com>
References: <20230228223838.3794807-1-dhowells@redhat.com>
 <20230228223838.3794807-2-dhowells@redhat.com>
Date:   Wed, 01 Mar 2023 12:11:09 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Howells <dhowells@redhat.com> writes:

> When __cifs_readv() and __cifs_writev() extract pages from a user-backed
> iterator into a BVEC-type iterator, they set ->bv_need_unpin to note
> whether they need to unpin the pages later.  However, in both cases they
> examine the BVEC-type iterator and not the source iterator - and so
> bv_need_unpin doesn't get set and the pages are leaked.
>
> I think this may be responsible for the generic/208 xfstest failing
> occasionally with:
>
> 	WARNING: CPU: 0 PID: 3064 at mm/gup.c:218 try_grab_page+0x65/0x100
> 	RIP: 0010:try_grab_page+0x65/0x100
> 	follow_page_pte+0x1a7/0x570
> 	__get_user_pages+0x1a2/0x650
> 	__gup_longterm_locked+0xdc/0xb50
> 	internal_get_user_pages_fast+0x17f/0x310
> 	pin_user_pages_fast+0x46/0x60
> 	iov_iter_extract_pages+0xc9/0x510
> 	? __kmalloc_large_node+0xb1/0x120
> 	? __kmalloc_node+0xbe/0x130
> 	netfs_extract_user_iter+0xbf/0x200 [netfs]
> 	__cifs_writev+0x150/0x330 [cifs]
> 	vfs_write+0x2a8/0x3c0
> 	ksys_pwrite64+0x65/0xa0
>
> with the page refcount going negative.  This is less unlikely than it seems
> because the page is being pinned, not simply got, and so the refcount
> increased by 1024 each time, and so only needs to be called around ~2097152
> for the refcount to go negative.
>
> Further, the test program (aio-dio-invalidate-failure) uses a 32MiB static
> buffer and all the PTEs covering it refer to the same page because it's
> never written to.
>
> The warning in try_grab_page():
>
> 	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
> 		return -ENOMEM;
>
> then trips and prevents us ever using the page again for DIO at least.
>
> Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Link: https://lore.kernel.org/r/CAH2r5mvaTsJ---n=265a4zqRA7pP+o4MJ36WCQUS6oPrOij8cw@mail.gmail.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Shyam Prasad N <nspmangalore@gmail.com>
> cc: Rohith Surabattula <rohiths.msft@gmail.com>
> cc: Paulo Alcantara <pc@cjr.nz>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cifs@vger.kernel.org
> ---
>  fs/cifs/file.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
