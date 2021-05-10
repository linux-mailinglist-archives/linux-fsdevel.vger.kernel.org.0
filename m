Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADEA377EFC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 May 2021 11:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhEJJKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 05:10:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36912 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJJKF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 05:10:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04DFBB02E;
        Mon, 10 May 2021 09:09:00 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id abe4f275;
        Mon, 10 May 2021 09:10:32 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dave Chinner <dchinner@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Ian Lance Taylor <iant@golang.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Subject: Re: [PATCH v8] vfs: fix copy_file_range regression in cross-fs copies
References: <20210221195833.23828-1-lhenriques@suse.de>
        <20210222102456.6692-1-lhenriques@suse.de>
        <CAN-5tyELMY7b7CKO-+an47ydq8r_4+SOyhuvdH0qE0-JmdZ44Q@mail.gmail.com>
        <YDYpHccgM7agpdTQ@suse.de>
        <CANMq1KBgwEXFh8AxpPW2t1SA0NVsyR45m0paLEU4D4w80dc_fA@mail.gmail.com>
        <CANMq1KDTgnGtNxWj2XxAT3mdsNjc551uUCg6EWnh=Hd0KcVQKQ@mail.gmail.com>
        <8735vzfugn.fsf@suse.de>
        <CAOQ4uxjdVZywBi6=D1eRfBhRk+nobTz4N87jcejDtvzBMMMKXQ@mail.gmail.com>
        <CANMq1KAOwj9dJenwF2NadQ73ytfccuPuahBJE7ak6S7XP6nCjg@mail.gmail.com>
        <8735v4tcye.fsf@suse.de>
        <CAOQ4uxh6PegaOtMXQ9WmU=05bhQfYTeweGjFWR7T+XVAbuR09A@mail.gmail.com>
Date:   Mon, 10 May 2021 10:10:32 +0100
In-Reply-To: <CAOQ4uxh6PegaOtMXQ9WmU=05bhQfYTeweGjFWR7T+XVAbuR09A@mail.gmail.com>
        (Amir Goldstein's message of "Mon, 10 May 2021 07:59:09 +0300")
Message-ID: <87fsyv0x9z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Amir Goldstein <amir73il@gmail.com> writes:

> On Mon, May 3, 2021 at 11:52 AM Luis Henriques <lhenriques@suse.de> wrote:
<...>
> Luis,
>
> I suggest that you post v9 with my Reviewed-by and Olga's Tested-by
> and address your patch to the VFS maintainer and fsdevel list without
> the entire world and LKML in CC.

Ok, v9 sent out according to your proposal:

https://lore.kernel.org/linux-fsdevel/20210510090806.8988-1-lhenriques@suse.de/

Thanks, Amir.

Cheers,
-- 
Luis

>
> Al,
>
> Would you mind picking this patch?
>
> Linus,
>
> There have been some voices on the discussion saying maybe this is not
> a kernel regression that needs to be fixed, but a UAPI that is not being used
> correctly by userspace.
>
> The proposed change reminds me a bit of recent changes to splice() from
> special files. Since this specific UAPI discussion is a bit subtle and because
> we got this UAPI wrong at least two times already, it would be great to get
> your ACK on this proposed UAPI change.
>
> Thanks,
> Amir.
>
> Latest v8 tested and reviewed by several developers on CC list:
> https://lore.kernel.org/linux-fsdevel/20210222102456.6692-1-lhenriques@suse.de/
>
> Proposed man page update:
> https://lore.kernel.org/linux-fsdevel/20210509213930.94120-12-alx.manpages@gmail.com/
