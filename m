Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B36B8E1E09
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Oct 2019 16:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391143AbfJWOYb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 10:24:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34217 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWOYa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 10:24:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id v3so6455094wmh.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Oct 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gjQulNA4uezTUyxG45ojQXHopyPKahKB0v4ovhLJy4=;
        b=cjke8X+5KUmTlZ71+jZqgOxdcwSW/I5R+0kbGOz+7hhz/ZYJX7AZYHXKGW/6kYqdYO
         g2UWHkAySueGfLcMbv2JrS8zTj3h1HhLYdRzwT2+BkYdafRO/1/2Aw1iir6dm97iH8J4
         Bku4435+tdtULoWY0Phl0HcuYa4/8LjFVcFpraJvW+6eIFp7RnHcPh5OWM57kuGgWtqe
         W2B3Ha+w4l3jRX8aiIlprc/ELopaO2OzR0YvypcowSH67AzUYfh8Ge5agKIxeUGnduII
         4ug4gR81W460gmUp+Ehrg4G64bnQjOYtl+G6G/TY7W70SpU03XxaC540+rMXzXSjZquG
         j25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gjQulNA4uezTUyxG45ojQXHopyPKahKB0v4ovhLJy4=;
        b=OJl0YlOpCn2abs0Un7RyOJvCaM5NyJdSK/N39Rd6YAMqJHoEvGhi844BH8t8yXX8Bc
         mSMpkLOsXi2TrOS8fVp3GZmZsz5V37ujUDZS1+Y86ztzIMtDV1x/M/487QkiUEoIEF0T
         zO+qSHe9nH3rq2OTiFuDE1TNoKaO2yMgherUo7a0zuet4EgM7C/oplXin7qLazuxHHVt
         ohIu88mcAtgYwZWAV6QyvHc63r8Zu1KQQeC69JxqKGDnReLMu98w3fdqFVyJfKRDCNc5
         PF8ibLLGa5ZAj89RoXb8d2dhS5e1TPV/g84p5qWSLoit2XGw0ksr2lHmqyp3O2UcSJaJ
         xuqA==
X-Gm-Message-State: APjAAAWFTcC059XLMyvEvz5Q9nsjqfjb2HJWuoPSRaUxPeoLMzh4iI58
        REG900YrdFcKmae+gyMlkdpNmh7F9zyLtBw90CI48Q==
X-Google-Smtp-Source: APXvYqxqBR+yyBUrYJlrzRKKLUgI/0QTDYQFSom60/wyeQRqKElBqbVGPasydsJzx7F6zazqsYeoEE6kH9voVyPhBdU=
X-Received: by 2002:a05:600c:2295:: with SMTP id 21mr173145wmf.106.1571840668623;
 Wed, 23 Oct 2019 07:24:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <CAFLxGvxdPQdzBz1rc3ZC+q1gLNCs9sbn8FOS6G-E1XxXeybyog@mail.gmail.com>
 <20191022105413.pj6i3ydetnfgnkzh@pali> <CAJCQCtToPc5sZTzdxjoF305VBzuzAQ6K=RTpDtG6UjgbWp5E8g@mail.gmail.com>
 <521a5d27-dae9-44a3-bb90-43793bbde7d5@www.fastmail.com>
In-Reply-To: <521a5d27-dae9-44a3-bb90-43793bbde7d5@www.fastmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 23 Oct 2019 16:24:09 +0200
Message-ID: <CAJCQCtSPkcrNfP89SNJzkaVuAL3FehUQLL9ZhU0ouhNdcOu+Yw@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Colin Walters <walters@verbum.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 23, 2019 at 2:53 PM Colin Walters <walters@verbum.org> wrote:
>
>
>
> On Tue, Oct 22, 2019, at 8:10 PM, Chris Murphy wrote:
> >
> > For multiple kernels,  it doesn't matter if a crash happens anywhere
> > from new kernel being written to FAT, through initramfs, because the
> > old bootloader configuration still points to old kernel + initramfs.
> > But in multiple kernel distros, the bootloader configuration needs
> > modification or a new drop in scriptlet to point to the new
> > kernel+initramfs pair. And that needs to be completely atomic: write
> > new files to a tmp location, that way a crash won't matter. The tricky
> > part is to write out the bootloader configuration change such that it
> > can be an atomic operation.
>
> Related: https://github.com/ostreedev/ostree/issues/1951
> There I'm proposing there to not try to fix this at the kernel/filesystem
> level (since we can't do much on FAT, and even on real filesystems we
> have the journaling-vs-bootloader issues), but instead create a protocol
> between things writing bootloader data and the bootloaders to help
> verify integrity.

The symlink method now being used, you describe as an OSTree-specific
invention. How is the new method you're proposing more generic such
that it's not also an OSTree-specific invention?

-- 
Chris Murphy
