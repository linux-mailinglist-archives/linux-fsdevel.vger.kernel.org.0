Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD153D14DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhGUQ3w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 12:29:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45405 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhGUQ3w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626887428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pHIrr2R+m6okqzTEImHOCFTKRL2HTOsLF72rQ2qjio0=;
        b=hpO/uPM9rOwoB0hSq6aXB+7enkOeDEO2BhCp60Tlsqd1h7YrdrkSUkm6qNTzdH7jCRHkS6
        N2zXsFFE+f83VfhfJOJMy/b5+5tAQWhp9pU79KZ0EnA9yEXH6+jgiSmWrbAiP5SRk79Occ
        0lwK3/a5UlHJQUdHKAu2FNKo/53pIQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-MEydbkNIO4KK5-uKnWDkiw-1; Wed, 21 Jul 2021 13:10:27 -0400
X-MC-Unique: MEydbkNIO4KK5-uKnWDkiw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63C72107ACF5;
        Wed, 21 Jul 2021 17:10:25 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B58B62672;
        Wed, 21 Jul 2021 17:10:17 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 16LHAGci011835;
        Wed, 21 Jul 2021 13:10:16 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 16LHAF51011830;
        Wed, 21 Jul 2021 13:10:15 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 21 Jul 2021 13:10:15 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Pintu Agarwal <pintu.ping@gmail.com>
cc:     open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting
 issue
In-Reply-To: <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
Message-ID: <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com> <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com> <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On Wed, 21 Jul 2021, Pintu Agarwal wrote:

> On Tue, 20 Jul 2021 at 17:12, Mikulas Patocka <mpatocka@redhat.com> wrote:
> >
> > Hi
> >
> > Try to set up dm-verity with block size 512 bytes.
> >
> > I don't know what block size does squashfs use, but if the filesystem
> > block size is smaller than dm-verity block size, it doesn't work.
> >
> Okay thank you so much for this clue,
> It seems we are using 65536 as the squashfs block size:

65536 is the compression block size - it is unrelated to I/O block size.

There's a config option SQUASHFS_4K_DEVBLK_SIZE. The documentation says 
that it uses by default 1K block size and if you enable this option, it 
uses 4K block size.

So, try to set it. Or try to reduce dm-verity block size down to 1K.

> ==> mksquashfs [...] - comp xz -Xdict-size 32K -noI -Xbcj arm -b 65536
> -processors 1
> 
> But for dm-verity we are giving block size of 4096
> ==> [    0.000000] Kernel command line:[..] verity="96160 12020
> d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681 0 "
> rootfstype=squashfs root=/dev/mtdblock34 ubi.mtd=30,0,30 [...]
> root=/dev/dm-0 dm="system none ro,0 96160 verity 1 /dev/mtdblock34
> /dev/mtdblock39 4096 4096 12020 8 sha256
> d7b8a7d0c01b9aec888930841313a81603a50a2a7be44631c4c813197a50d681
> aee087a5be3b982978c923f566a94613496b417f2af592639bc80d141e34dfe7"
> 
> Now, we are checking by giving squashfs block size also as 4096
> 
> In case, if this does not work, what else could be the other option ?
> Can we try with initramfs approach ?

Yes - you can try initramfs.

Mikulas

> Thanks,
> Pintu
> 

