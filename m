Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB89C9659
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2019 03:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbfJCBm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 21:42:28 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43853 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJCBm2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 21:42:28 -0400
Received: by mail-ot1-f53.google.com with SMTP id o44so880526ota.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2019 18:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+6URiGNBLoCB6r5WiJX3vBK2jXLusDEDYcZ0JdvUCUY=;
        b=O43JXqUF4xtbJybLYvmBF46AJh75a6zDfyGAjGHPqFG3NM4pabxnDoUh36oW03c9a7
         /4ZoVh145HZtvPkrpkd4N34tQKVwUalxFThv+5MmMiGbMGuFK4I4sBuzl/+ABlaXIkZZ
         h/Pv8/6wdaDQVCf9GjaI5b3JfZaHoRCcFW4jn4GQDBVXl7WNCKfZTn72hUooDiE0onAL
         U2Nu6HVsZMNTpkNwzWD7j9HXwE5y8q1O7tgh40TWgrgIOGi4Fhgu7dO0FTMc0nQmQPTN
         Q9G0BbwJuc4NfDYyFV1qBN5QMH3abHXc7C/JgLEzGSTImYHhUVs0Zfydi+2xyXEO0HDX
         pQ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+6URiGNBLoCB6r5WiJX3vBK2jXLusDEDYcZ0JdvUCUY=;
        b=Cnes5mo2UtPyOz6QG9rgClnBxbEOQib1+TuCjJGCn1p/T+P9NGUWxifDKrpS7GcBpb
         vcnKJsB/zBOKIRYcEe63hYFQWb8o5VBVHYzFQhGI3H4HaNMYwB6touMhjT9Te3eJcr5E
         f5QSEXi8n+aKgRHEJcypaWrIXl8S6oQeCWFStoNx6amhIzJnuxDp2w0V/Ck/IHWERswC
         mwphCCL9+5tfABCCm9EF5gcmIGNn15S+/4gOUGghFI6Wop4UKCh4O+//UHjE+SSZyqiz
         BgsE1RH+ySAoM+GvPjRs5yd3OnepT8DkpyvrCeZsMsjbnBJHY4VxgexCwZpmYy5WD+Iy
         6BcQ==
X-Gm-Message-State: APjAAAW6ac+32hFjLqEBicPZ/82d9rKdvv6qQk2uKqiUvKeZOn/JhiX8
        iTVnWt6lhwt+FAE1tOmaueCSzQuQDRlsY3qgNGG4Z//6
X-Google-Smtp-Source: APXvYqzsyV930nzq9WV2o1pt7MRUTDY6U+/7gMiKYQ05MbdlxWMlZGfjRFlEC45+acltU0d+VSjKTH7bCm2UblRuEqI=
X-Received: by 2002:a9d:7b54:: with SMTP id f20mr5034956oto.34.1570066946947;
 Wed, 02 Oct 2019 18:42:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:17c2:0:0:0:0:0 with HTTP; Wed, 2 Oct 2019 18:42:26 -0700 (PDT)
In-Reply-To: <20191002193953.GA777@mit.edu>
References: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
 <20191002124651.GC13880@mit.edu> <CA+i3KrYvp1pXbpCb_WJDCRx0COU2KCFT_Nfsgcn1mLGrVzErvA@mail.gmail.com>
 <20191002193953.GA777@mit.edu>
From:   Daegyu Han <dgswsk@gmail.com>
Date:   Thu, 3 Oct 2019 10:42:26 +0900
Message-ID: <CA+i3KrZ0oks8mw772L-J9MqZ0eafKJzk=Mk0D7GypCmvzt1oTg@mail.gmail.com>
Subject: Re: How can I completely evict(remove) the inode from memory and
 access the disk next time?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your answer.

I'm so sorry I asked my personal project question here.
Yes, I will use a shared disk file system.

Best regards,
Daegyu

2019-10-03 4:39 GMT+09:00, Theodore Y. Ts'o <tytso@mit.edu>:
> On Wed, Oct 02, 2019 at 11:42:47PM +0900, Daegyu Han wrote:
>> Thank you for your consideration.
>>
>> Okay, I will check ocfs2 out.
>>
>> By the way, is there any possibility to implement this functionality
>> in the vfs layer?
>>
>> I looked at the dcache.c, inode.c, and mm/vmscan.c code and looked at
>> several functions,
>> and as you said, they seem to have way complex logic.
>>
>> The logic I thought was to release the desired dentry, dentry_kill()
>> the negative dentry, and break the inodes of the file that had that
>> dentry.
>
> The short version is that objects have dependencies on other objects.
> For example, a file descriptor object has a reference to the dentry of
> the file which is open.  A file dentry or directory dentry object
> references its parent directory's dentry object, etc.  You can not
> evict an object when other objects have references on it --- otherwise
> those references become dangling pointers, Which Would Be Bad.
>
> There are solutions for remote file systems (network, clustered, and
> shared disk file systems).  So the VFS layer can support these file
> systems quite well.  Look at ceph, nfs, ofs2, and gfs for examples for
> that.  But it's *complicated* because doing it in a way which is
> highly performant, both for remote file systems, and as well as
> supporting high-performance local disk file systems, is a lot more
> than your very simple-minded, "just kill the dentry/inode structures
> and reread them from disk".
>
> Are you trying to do this for a university class project or some such?
> If so, we're not here to do your homework for you.  If you want a
> practical solution, please use an existing shared-disk or networked
> file system.
>
> Best regards,
>
> 					- Ted
>
