Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3B319FAF4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Apr 2020 19:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgDFREc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Apr 2020 13:04:32 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34716 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728902AbgDFREb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:04:31 -0400
Received: by mail-lj1-f193.google.com with SMTP id p10so512480ljn.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 10:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ar7jflrkNXaeWaLLNE+J/V0wCb3y07I41Vn1cDNa1H0=;
        b=iAyiGuOhg1NBw6xntWOjfjlwN9HPSP5nDSdo7Jp3I/fwBUQ0KJFRRQOcR/HKfmVC7o
         qnHtvHaPJgAGeNdQfEkNAtbjCg1eAhwAJJRKbDQ3v/rLuR8aMVuXHQIiAZrb4at4+sBj
         MTvWffSqk+SyA3JRUrj2Z2o42xS9DNGcGc5MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ar7jflrkNXaeWaLLNE+J/V0wCb3y07I41Vn1cDNa1H0=;
        b=RGQwDq5hFDeomsSJyo/UuA5A7HVHOtEBUNjvyLjFac33eLMZVC1h2lKRHR8MzzfTpW
         SphW+GScFIkBhIoXk3YORk40J9yPMYqtlhqfSjZ/qEUIAIf2vPxtGdoEZ9aUn++5fBrN
         GIviKc/seM67Xf8O8a99+KJ3Mo/WWNgsbyIGJeeliMZTtBLTU0xm7fbMX6anayLSCpF0
         uXatYicfEJ66U9t0Hs1pPdy7azIPK2NTErQ3PgE3tfGi1xhyLme3yuBDaDDV9U7HVN+q
         0TUXDVHspbEmjYRw7DZ3D2F8xoZ/lMJuDVBK7fOejpplNau3rE4uMWXtJI+qG9k5E//o
         fTOA==
X-Gm-Message-State: AGi0PuaUnpwLoYHsCmyJXWO0Ifyo5PjZU81c5Upv2jDnsVbN5yJd2sp2
        sbeAtBJBCB7VjKwLSllh4mRwi3BR9KA=
X-Google-Smtp-Source: APiQypLOXOBsrKF/1kumu5TpAclSWsdW41JnZj484LUDIuPW4aq+BJtSZwX+fJt3brrEX//Y5XSrqg==
X-Received: by 2002:a2e:9681:: with SMTP id q1mr130194lji.179.1586192669209;
        Mon, 06 Apr 2020 10:04:29 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 64sm10198321ljj.41.2020.04.06.10.04.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 10:04:28 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id r17so98110lff.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Apr 2020 10:04:28 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr9430308lfo.152.1586192667631;
 Mon, 06 Apr 2020 10:04:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica> <20200406164641.GF21484@bombadil.infradead.org>
In-Reply-To: <20200406164641.GF21484@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 10:04:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
Message-ID: <CAHk-=wiAiGMH=bw5N1nOVWYkE9=Pcx+mxyMwjYfGEt+14hFOVQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 6, 2020 at 9:46 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> POSIX may well "allow" short reads, but userspace programmers basically
> never check the return value from read().  Short reads aren't actually
> allowed.  That's why signals are only allowed to interrupt syscalls if
> they're fatal (and the application will never see the returned value
> because it's already dead).

Well, that's true for some applications.

But look at anybody who ever worked more with NFS mounts, and they got
used to having the 'intr' mount flag set and incomplete reads and
-EAGAIN as a result.

So a lot of normal applications are actually used to partial reads
even from file reads.

Are there apps that react badly? I'm sure - but they also wouldn't
have O_NONBLOCK set on a regular file. The only reason to set
O_NONBLOCK is because you think the fd might be a pipe or something,
and you _are_ ready to get partial reads.

So the 9p behavior certainly isn't outrageously out of line for a
network filesystem. In fact, because of O_NONBLOCK rather than a mount
option, I think it's a lot safer than a fairly standard NFS option.

               Linus
