Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D315DC8B8C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfJBOmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Oct 2019 10:42:49 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:46202 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfJBOmt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Oct 2019 10:42:49 -0400
Received: by mail-oi1-f177.google.com with SMTP id k25so17799957oiw.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Oct 2019 07:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WJkfTYs+RJHqlRCG5+voZIWghaTW3DWy3TWxalsTTLU=;
        b=lQDQkuJCFLd7G8d59mOU5kHY+A5GTiAgSmhuWBNxxAD3ODBoKoIBBmMTZ72HOEnWEX
         c1vCstn1WWXctPQ+7JPiD3KoP1xLI1WUzdl19UwGvdI7mNqKm5Scq/cftYfT9CGwLKhh
         ds6c9IffC+I1wwSmkmcVPcE3n9K8UoeDmjbdSh98Dl8evMrdEVdVU9nAfNGdpNT/5FAc
         cC5TdU5N1B71Sk8TX5jlgzQIsH61ZZCc1T4NBvKP68bTrZkz2+uJN053caU7SRKWSbKD
         UDydA7c9MnCuL+rtHV5brlPPpHTNJWDBuhSDLWajcGbYHP4csuqF0VUssT5a3Wc0mwvv
         OJTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WJkfTYs+RJHqlRCG5+voZIWghaTW3DWy3TWxalsTTLU=;
        b=GNBgwuMkHFFIGwr2bZ3PY5J/dgNSutMuEUGvXUjHk7Ir6+cVELJb3SybWNIOK+DZph
         t8OL2HqeJNlEynD3i757EUNbb29zL7cALTdUzvaBjEekgBovHfmlVYsthHfEE32U9bcz
         VCzMe2ETWsanLwEafYxvcR3VKvs6+jBbnelY5qYFhG0hguZouiMUd7wPCfJMvoKon9MP
         jDGj7vOYSiwHXIAJwhDGWtQm6J04OTaPlth0YpZ4Dh02BLBscMumZNIWiGtOgM4YJwRs
         OtErWbuNDMbdiP2fB4GNW+wrXbvBLzocwfiYZXdzuPR2b5PK8ItGhNkUDZRXhHqxGC/w
         DoGg==
X-Gm-Message-State: APjAAAWmiY29PlmHfYeXhOErKOLMqM9DGGufS4SG0SCKJSgxrYHzTDrB
        NlAEyhBR7Zt3Qt670U13/zaSvRy1hyoCPfKLr5V6OLUpE5M=
X-Google-Smtp-Source: APXvYqwGLKMXrmuqZlm/q58CUBATQWQ1RRCtp9kdJuZKvkODbhXJP5sYjiq8r5Adf/3nNta6b74v/4/xQ4BCESYBGJ4=
X-Received: by 2002:aca:5856:: with SMTP id m83mr2949665oib.90.1570027368346;
 Wed, 02 Oct 2019 07:42:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:17c2:0:0:0:0:0 with HTTP; Wed, 2 Oct 2019 07:42:47 -0700 (PDT)
In-Reply-To: <20191002124651.GC13880@mit.edu>
References: <CA+i3KrYpvd4X7uD_GMAp8UZMbR_DhmWvgzw2bHuSQ7iBvpsJQg@mail.gmail.com>
 <20191002124651.GC13880@mit.edu>
From:   Daegyu Han <dgswsk@gmail.com>
Date:   Wed, 2 Oct 2019 23:42:47 +0900
Message-ID: <CA+i3KrYvp1pXbpCb_WJDCRx0COU2KCFT_Nfsgcn1mLGrVzErvA@mail.gmail.com>
Subject: Re: How can I completely evict(remove) the inode from memory and
 access the disk next time?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thank you for your consideration.

Okay, I will check ocfs2 out.

By the way, is there any possibility to implement this functionality
in the vfs layer?

I looked at the dcache.c, inode.c, and mm/vmscan.c code and looked at
several functions,
and as you said, they seem to have way complex logic.

The logic I thought was to release the desired dentry, dentry_kill()
the negative dentry, and break the inodes of the file that had that
dentry.

Can you tell me the detailed logic of the dentry and inode caches that
I'm curious about?
If not, can you give me a reference paper or book?

Best regards,
Daegyu

2019-10-02 21:46 GMT+09:00, Theodore Y. Ts'o <tytso@mit.edu>:
> On Wed, Oct 02, 2019 at 05:30:21PM +0900, Daegyu Han wrote:
>> Hi linux file system experts,
>>
>> I'm so sorry that I've asked again the general question about Linux
>> file systems.
>>
>> For example, if there is a file a.txt in the path /foo/ bar,
>> what should I do to completely evict(remove) the inode of bar
>> directory from memory and read the inode via disk access?
>
> There is no API to do this from userspace.  The only way to do this is
> to unmount the entire file system.
>
> From the kernel, it's *way* more complicated than this.  Making a
> shared-disk file system requires a lot more changes to the kernel
> code.  You might want to take a look at ocfs2.  This was a file system
> that started using the ext3 file system code, and **extensive**
> kernel-level code changes were made to make it be a shared-disk file
> system.
>
> 						- Ted
> 						
>
