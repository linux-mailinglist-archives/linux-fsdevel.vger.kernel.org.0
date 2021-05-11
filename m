Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82EC379DCF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 May 2021 05:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229465AbhEKDbg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 May 2021 23:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEKDbf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 May 2021 23:31:35 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31639C061574;
        Mon, 10 May 2021 20:30:29 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z9so26482742lfu.8;
        Mon, 10 May 2021 20:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3C7fFNhnTXuSTSUif3G3U+Ps41gUdqPvKoJBdyO2gKY=;
        b=OycmJoJELTYsZz0Bxg10upBlKAv2xPIXvQ11ZGsJSmiNNM7rjXQ6q/oSxj5EgxXkaq
         mLcFildLqCf9J16YqDqUYD3zwZ2beQ6eWDuLcvnMA0HFRzhdUmwYTiKHIrDKTYqgRtS1
         L7zYBuirTCrAuAXnxlAXygzTrqOiRNtIU4P6Y41///2gCpqqMS+D8PFgKA/GDJpvyQg9
         DtAz2BVXYb7sIcGY4Aq/6ymsbHc2rwrC1++xMrK0PUVNQi37pJhCNgjS5znQqMEJE60F
         GzVoozHScH/rT+0YB2OtU01picS+Ci/GowUDmzcUSSxm94yyXpjZpx3I+twzqP+uG26x
         Y2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3C7fFNhnTXuSTSUif3G3U+Ps41gUdqPvKoJBdyO2gKY=;
        b=IHWL+OdtUqfWWbocc9pDPgg1qoH0Y7VVaOgNmrUm4+O6AEVUxZ4iI2xpDgEfB9yOJr
         wynQHh8MD8aP6VZV2NZ+fWkVGFP8+itmWnqJQHhSMTCkPN/Uva1w1Cu4tBjwwK8dF9EP
         baqFUADULSvOkmPOwl2qPvkpBZOfMuqN3apQK7O5F3ZKcn0RSLM/RPXMPn9/8znu8hu/
         64ztdOR7ufAdhYJt+ejVdT3xBfA0E8IzZrSA/bOicrnQ9AM5yoZdNNNtFthB+lECyLse
         so0WaHi9AGr18iaPbq0ppeNc4oBaBZBiMGXyiHUJMXSFQckmLnlf/XBsH495ICjaBs6m
         Y/Mg==
X-Gm-Message-State: AOAM531/DF2Sb0aI1qqycr6oWJVeGYNxhuW01vlW1SuAyB7P9sIT+VDr
        RtJrqZr647kBn0AJaDEH84HH0mZGaboUfrsE4PwFJOFlw9w=
X-Google-Smtp-Source: ABdhPJxd4DUkWbNLaav5EIAWQZ1O5Puq3inIyD4+yUHmiwTrFO4HQu03JWI4T8HZlBY3UXXZnsmG3oTWL6XJC0SjgH8=
X-Received: by 2002:a05:6512:142:: with SMTP id m2mr19686940lfo.313.1620703827640;
 Mon, 10 May 2021 20:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5ms+NL=J2Wa=wY2doV450qL8S97gnJW_4eSCp1aiz1SEZA@mail.gmail.com>
In-Reply-To: <CAH2r5ms+NL=J2Wa=wY2doV450qL8S97gnJW_4eSCp1aiz1SEZA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 10 May 2021 22:30:16 -0500
Message-ID: <CAH2r5mtLY6CRT2CYR--ETq4zPT87+3Eqmk-2=q7eqP+i6BoCLQ@mail.gmail.com>
Subject: Re: Compile warning with current kernel and netfs
To:     David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

And forgot to mention that this is on very recent distro, has recent
libraries etc., I had to move to Ubuntu 21.04 due to dependencies of
eBPF and other pieces on newer libc, pahole etc

On Mon, May 10, 2021 at 9:01 PM Steve French <smfrench@gmail.com> wrote:
>
> Noticed the following netfs related new warning when compiling cifs.ko
> with the current 5.13-rc1
>
>   CC [M]  /home/smfrench/cifs-2.6/fs/cifs/fscache.o
>   CHECK   /home/smfrench/cifs-2.6/fs/cifs/fscache.c
> /home/smfrench/cifs-2.6/fs/cifs/fscache.c: note: in included file
> (through include/linux/fscache.h,
> /home/smfrench/cifs-2.6/fs/cifs/fscache.h):
> ./include/linux/netfs.h:93:15: error: don't know how to apply mode to
> unsigned int enum netfs_read_source
>   CC [M]  /home/smfrench/cifs-2.6/fs/cifs/cache.o
>   CHECK   /home/smfrench/cifs-2.6/fs/cifs/cache.c
> /home/smfrench/cifs-2.6/fs/cifs/cache.c: note: in included file
> (through include/linux/fscache.h,
> /home/smfrench/cifs-2.6/fs/cifs/fscache.h):
> ./include/linux/netfs.h:93:15: error: don't know how to apply mode to
> unsigned int enum netfs_read_source
>
> It doesn't like this enum in include/linux/netfs.h:
>
> enum netfs_read_source {
>         NETFS_FILL_WITH_ZEROES,
>         NETFS_DOWNLOAD_FROM_SERVER,
>         NETFS_READ_FROM_CACHE,
>         NETFS_INVALID_READ,
> } __mode(byte);
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
