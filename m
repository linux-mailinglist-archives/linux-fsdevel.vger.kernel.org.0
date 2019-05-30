Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCB6304DE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbfE3Wp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 May 2019 18:45:56 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:34980 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbfE3Wp4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 May 2019 18:45:56 -0400
Received: by mail-lj1-f178.google.com with SMTP id h11so7702446ljb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 May 2019 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z/mhNnTAOsJLEZHyKQjw/9NCHJUOEGHQw19Cx/4jcO4=;
        b=rDK7wvSro0FEjQwKzXFAZoXU+zA7CQ8tauuAidU1OyJdpvDQmgQQg2QoL0I+7hABEB
         zWhWhjniUI2ciyRj37qwz23E9nH52zdwtzjRbNFL1XNrGxpcSOvDXsl+9YZ0zZmpr2hO
         Izuco+oTW90piH7FY4aay8XKDGLVuP0jR1pypSKab6kTqOKvf1J64RQ1gwopC4MFY8wH
         VcNakrYC8zZDSGhSftU/Ye6YCML+jLFw3X/a0Rb2YNeRrGG0QRyuCbH/2TEUkqfUpxJ+
         /kYiIMgcbpGOiY2aiV29lgE9nvPgQZPyZ/ZtOWoar6Rmhc/a935aKvBV8k6dXuarMIgF
         2rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z/mhNnTAOsJLEZHyKQjw/9NCHJUOEGHQw19Cx/4jcO4=;
        b=fxfuJyQPENzXphAHeFD6M347E9c0Ff66cLoRa11cnie0sJ5FrwOZYbUshUt7bJbUbt
         ahSfxf6jxycbEb0G4oP0JV7V2VkOVeQu2NU8M9pOEGZ678phARkeWkAQEORoTt+DIPCq
         Xz7FnsHZAPXSFYUvdug3mnV2CzcH4W/LUHmeJCWEkPmXY4QPSPL9T7d9+AW2apj/NHRJ
         vnX1KPL1JioKpqx+5aUw0XYTZAaja+vMriEZkc2o6LIkVlTkba8Gp4CM7Nw/+GkMxIC2
         BMS0DKIPFLUlSSeIIU1voIHnxQ74LP2FNqCLnMB2HjGYVKYCjAV5R5UFNuMUCj+wO0Oc
         1KcQ==
X-Gm-Message-State: APjAAAVH2R59Ku38yNidFKqUWAriJEwxhQiQm/iwbynVs2knP0Z2mZQB
        hNBmKsF8qwmrSrkYY8L8tB/d5h3ZnpQgX0gDI8tUbQ==
X-Google-Smtp-Source: APXvYqx16U5v6+bC1bWyWxdock3D0aaJh8w5cK3wMUydhh8SE4UIUyh0jp6Z+IHGm2TxDyfSMeT/uDgU8yqKvygWkzo=
X-Received: by 2002:a2e:5d9c:: with SMTP id v28mr3643226lje.32.1559256353596;
 Thu, 30 May 2019 15:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
 <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
 <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
 <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com>
 <CAJfpegs=4jMo20Wp8NEjREQpqYjqJ22vc680w1E-w6o-dU1brg@mail.gmail.com>
 <CAJeUaNBn0gA6eApgOu=n2uoy+6PbOR_xjTdVvc+StvOKGA-i=Q@mail.gmail.com> <CAJfpeguys2P9q5EpE3GzKHcOS9GVLO9Fj9HB3JBLw36eax+NkQ@mail.gmail.com>
In-Reply-To: <CAJfpeguys2P9q5EpE3GzKHcOS9GVLO9Fj9HB3JBLw36eax+NkQ@mail.gmail.com>
From:   Yurii Zubrytskyi <zyy@google.com>
Date:   Thu, 30 May 2019 15:45:42 -0700
Message-ID: <CAJeUaNAcZXfX-7Ws0q7SnaWrD+nzK3hxPwoW-NYvjAL0b=8M9g@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> With the proposed FUSE solution the following sequences would occur:
>
> kernel: if index for given block is missing, send MAP message
>   userspace: if data/hash is missing for given block then download data/hash
>   userspace: send MAP reply
> kernel: decompress data and verify hash based on index
>
> The kernel would not be involved in either streaming data or hash, it
> would only work with data/hash that has already been downloaded.
> Right?
>
> Or is your implementation doing streamed decompress/hash or partial blocks?
> ...
> Why does the kernel have to know the on-disk format to be able to load
> and discard parts of the index on-demand?  It only needs to know which
> blocks were accessed recently and which not so recently.
>
(1) You're correct, only the userspace deals with all streaming.
Kernel then sees full blocks of data (usually LZ4-compressed) and
blocks of hashes
We'd need to give the location of the hash tree instead of the
individual hash here though - verification has to go all the way to
the top and even check the signature there. And the same 5 GB file
would have over 40 MB of hashes (32 bytes of SHA2 for each 4K block),
so those have to be read from disk as well.
Overall, let's just imagine a phone with 100 apps, 100MB each,
installed this way. That ends up being ~10GB of data, so we'd need _at
least_ 40 MB for the index and 80 MB for hashes *in kernel*. Android
now fights for each megabyte of RAM used in the system services, so
FUSE won't be able to cache that, going back to the user mode for
almost all reads again.
(1 and 2) ... If FUSE were to know the on-disk format it would be able
to simply parse and read it when needed, with as little memory
footprint as it can. Requesting this data from the usermode every time
with little caching defeats the whole purpose of the change.

> BTW, which interface does your fuse filesystem use?  Libfuse?  Raw device?
Yes, our code interacts with the raw FUSE fd via poll/read/write
calls. We have tried the multithreaded approach via duping the control
fd and FUSE_DEV_IOC_CLONE, but it didn't give much improvement -
Android apps aren't usually use multithreaded, so there's at most two
pending reads at once. I've seen 10 once, but that was some kind of
miractle

And again, we have not even looked at the directory structure and stat
caching yet, neither interface nor memory usage. For a general case we
have to make direct disk reads from kernel and this forces even bigger
part of the disk format to be defined there. The end result is what
we've got when researching FUSE - a huge chunk of FUSE gets
overspecialized to handle our own way of using it end to end, with no
real configurability (because making it configurable makes that code
even bigger and more complex)

--
Thanks, Yurii
