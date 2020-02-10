Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89E13157033
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2020 09:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJIE4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Feb 2020 03:04:56 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45502 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgBJIE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:04:56 -0500
Received: by mail-lj1-f194.google.com with SMTP id f25so5982211ljg.12;
        Mon, 10 Feb 2020 00:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4A3TMLKRGhyPkPgiJ1U8mlnA1xT8oI0F78huS9wa9CU=;
        b=pawlTy63fbpdEBYkv0CmRGyPqkZ8dqJQl4Aj79L8VP9AENrF7OfLO41WMjN4HCw2ZT
         TjfUpxO5q6ucBK5/rvHkSecgrx48lkta+ZP5YVv2BgL1I0km8Vr4h2O/ux1+XdnCykPE
         BkZOWVMl9ab+KUsALRf7dVvUNdFinjcWQYXEofq7aa1SONM6z9fPODpNcPQ2LqwJPtn8
         2CToKALcN1IzvFMIa5BQOE/masPDovHJpejgEqFcQQ7N7yaDptXG+2KFqneOki5tHW10
         nNU8lzz6W/nBpiuoP1Fvzs7H8RY5zEkVW4955Fa82jlC8pRfSp/9yZ9jbk1CspU9n6eu
         qc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4A3TMLKRGhyPkPgiJ1U8mlnA1xT8oI0F78huS9wa9CU=;
        b=mRvbxQObNN6ONCYpn8mx4kgkuX+Zj/SGb4WhyBtnss8o8JueXRgBdyUTEJEo5nVwR2
         giyQzpLN5zu3yUPnuHGso0XOrn7492UMSot9ZdRJFuZRkd7kSq+xiY6ToP5X0cNIJdjP
         biB3u2KHCf7tbvQ2lXZPzRO+pNLIQPKULRyTnyOz1KesNVWAuUkuJuoZOUE6d84tasmr
         nppZ1wbldKa573SBP4OaQkdkzwRFqAUHLRdZAM6llNTL1pyPf5MRxDz0yeD9sMr5d95n
         jXGWEIYJND893RgOoadMxiZaKrneGuihnEymJTnT8pybh/T/gdZp0lZ4Dn5OceXhQp1a
         KwqA==
X-Gm-Message-State: APjAAAV++e87Xkr3gKWb3gHSBou+knExFK/nLuEqg7JmNlSS+wUytPd8
        zGChhTHjdXVnE5CojoCunmoJIgntB1AXkG9Yv/M=
X-Google-Smtp-Source: APXvYqxKYRfBdy1b8G3zgeigkBLLmIXOGUi3cZulxhpZITWH3+AT9urS6u3fQ+t/PjZxEM0Yoqhsm61H4Nnu/Wtc4ZE=
X-Received: by 2002:a2e:8e95:: with SMTP id z21mr93361ljk.119.1581321893578;
 Mon, 10 Feb 2020 00:04:53 -0800 (PST)
MIME-Version: 1.0
References: <20200108111743.23393-1-janne.karhunen@gmail.com>
 <CAE=NcrZrbRinOAbB+k1rjhcae3nqfJ8snC_EnY8njMDioM7=vg@mail.gmail.com> <1580998432.5585.411.camel@linux.ibm.com>
In-Reply-To: <1580998432.5585.411.camel@linux.ibm.com>
From:   Janne Karhunen <janne.karhunen@gmail.com>
Date:   Mon, 10 Feb 2020 10:04:42 +0200
Message-ID: <CAE=NcrYhz7zrhxZoVDSvfs+Cd-vNX30gGXU9Xu4K7ft-1ozN2g@mail.gmail.com>
Subject: Re: [PATCH v2] ima: export the measurement list when needed
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Ken Goldman <kgold@linux.ibm.com>, david.safford@gmail.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 6, 2020 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:

> The implications of exporting and removing records from the IMA-
> measurement list needs to be considered carefully.  Verifying a TPM
> quote will become dependent on knowing where the measurements are
> stored.  The existing measurement list is stored in kernel memory and,
> barring a kernel memory attack, is protected from modification.
>  Before upstreaming this or a similar patch, there needs to be a
> discussion as to how the measurement list will be protected once is it
> exported to userspace.
>
> This patch now attempts to address two very different scenarios.  The
> first scenario is where userspace is requesting exporting and removing
> of the measurement list records.  The other scenario is the kernel
> exporting and removing of the measurement list records.  Conflating
> these two different use cases might not be the right solution, as we
> originally thought.
>
> The kernel already exports the IMA measurement list to userspace via a
> securityfs file.  From a userspace perspective, missing is the ability
> of removing N number of records.  In this scenario, userspace would be
> responsible for safely storing the measurements (e.g. blockchain).
>  The kernel would only be responsible for limiting permission, perhaps
> based on a capability, before removing records from the measurement
> list.

This is a good point. I will adapt the patch to this.


> In the kernel usecase, somehow the kernel would need to safely export
> the measurement list, or some portion of the measurement list, to a
> file and then delete that portion.  What protects the exported records
> stored in a file from modification?

Are we looking at protecting this file from a root exploit and the
potential DOS it might cause? In the original patch the file was root
writable only. As far as further limitations go, the easiest would
probably be to use the file immutable bit. If the kernel opens the
file and sets the immutable bit, it is the only entity that can ever
write to it - not even another root task could directly write to it.
The kernel could, as long as it keeps the file open.


> Instead of exporting the measurement records, one option as suggested
> by Amir Goldstein, would be to use a vfs_tmpfile() to get an anonymous
> file for backing store.  The existing securityfs measurement lists
> would then read from this private copy of the anonymous file.
>
> I've Cc'ed fsdevel for additional comments/suggestions.

I didn't quickly see what the actual problem is that the vfs_tmpfile
solves in this context, will check.


--
Janne
