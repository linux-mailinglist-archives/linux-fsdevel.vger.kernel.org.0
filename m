Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109EF2886E6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 12:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgJIK2x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 06:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJIK2w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:28:52 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F1C0613D2;
        Fri,  9 Oct 2020 03:28:52 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q7so8697920ile.8;
        Fri, 09 Oct 2020 03:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=vl6FnDcmMHotO+NlsI4jNXl/ZZeiSghv4APFCf9brEc=;
        b=GzpK03fGAvht97i6dy2iGnaeighAj9C5abdcyRyPgOGoeYaZLedkRSfW9g0ipF9LKX
         Mh9WXoOruyqKeexTE3A9Y5TtpdxMQIQDbiq8GvFPncEf2y+uh5HrHoespBBeYPHJS+et
         pXyMR58UsdV2/dyEFNf/gSI6ABSgizREbS00/uwosl/uU7DxnVHGsrJzKTxn2W1OczSY
         9rCOWWrd5xaCTr0qjnZTvgkzCRbYhX76Faiq88mgMz4REzA5iP8GAjQ0KUXS3j5DL+Do
         Ic9zwGgaNI/m6V0cHnUxhmb9ynlAbYq4x3AF4O5g+HlqYdhIq6rFo/Q5X5+Qv8SdkMD/
         7U/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=vl6FnDcmMHotO+NlsI4jNXl/ZZeiSghv4APFCf9brEc=;
        b=HbQv2L+i7nTW0CvwfcR/YoiZCPrf+RTzAQbva9yceeBR6gqZUgNan6v3CMhrrJfgCT
         b39GNR0Jl3ysiz/TS3Ke3nP0so7W9uUY6nOzUVP+wFF0klCn7wOwUPfI9kqTxfxZbP5G
         3DVn+357Pfrvy3cY75/pMefmVQRahwicHiNeomFi/xgkJYcPouF0vodfBKrIpd4j5GeR
         MQG2OMKoIKCx2kedTop910BwmPX1iQsxygt/pNmcDPJ68DHNrAaWmBkjTiwIepkkUxRO
         /pP/yAOJNntK3OXAdu8ZXC7SwzxfEWvvU2qWoBF2Z45W9L85em6+xlCC28vQz9++738F
         ruRg==
X-Gm-Message-State: AOAM532GInX6PTqxHh5cgbzHI2jqBsDwZmoQ6TZTQ+I+G1yEDWT978pV
        UsZlLWAsOk0vAL0q8UibvtkDbi9uM+4BF5an6jD8Y21q08+Mug==
X-Google-Smtp-Source: ABdhPJy7eg1DPaXz/9mI1i+aZOhwm8pf/MccLsSeFKJ9jM61qfo8Vv86Aa6Rekv36JHJ2AZALBz8kdCUNp0Adp1Aeww=
X-Received: by 2002:a92:3543:: with SMTP id c64mr169470ila.209.1602239331831;
 Fri, 09 Oct 2020 03:28:51 -0700 (PDT)
MIME-Version: 1.0
References: <af902b5db99e8b73980c795d84ad7bb417487e76.1602168865.git.riteshh@linux.ibm.com>
 <CA+icZUVPXFkc7ow5-vF4bxggE63LqQkmaXA6m9cAZVCOnbS1fQ@mail.gmail.com>
 <22e5c5f9-c06b-5c49-d165-8f194aad107b@linux.ibm.com> <CA+icZUXLDGfHVGJXp2dA2JAxP8LUV4EVDNJmz20YjHa5A9oTtQ@mail.gmail.com>
In-Reply-To: <CA+icZUXLDGfHVGJXp2dA2JAxP8LUV4EVDNJmz20YjHa5A9oTtQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 9 Oct 2020 12:28:40 +0200
Message-ID: <CA+icZUW4-NA6vNg4KsGWyUNSEswR39Q4WKsJW-Hg+Vo6jopiEw@mail.gmail.com>
Subject: Re: [PATCH 1/1] ext4: Fix bs < ps issue reported with dioread_nolock
 mount opt
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jack@suse.cz, anju@linux.vnet.ibm.com,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 9, 2020 at 12:18 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Fri, Oct 9, 2020 at 9:19 AM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> >
> >
> >
> > On 10/9/20 12:16 PM, Sedat Dilek wrote:
> > > On Thu, Oct 8, 2020 at 5:56 PM Ritesh Harjani <riteshh@linux.ibm.com> wrote:
> > >>
> > >> left shifting m_lblk by blkbits was causing value overflow and hence
> > >> it was not able to convert unwritten to written extent.
> > >> So, make sure we typecast it to loff_t before do left shift operation.
> > >> Also in func ext4_convert_unwritten_io_end_vec(), make sure to initialize
> > >> ret variable to avoid accidentally returning an uninitialized ret.
> > >>
> > >> This patch fixes the issue reported in ext4 for bs < ps with
> > >> dioread_nolock mount option.
> > >>
> > >> Fixes: c8cc88163f40df39e50c ("ext4: Add support for blocksize < pagesize in dioread_nolock")
> > >
> > > Fixes: tag should be 12 digits (see [1]).
> > > ( Seen while walking through ext-dev Git commits. )
> >
> >
> > Thanks Sedat, I guess it should be minimum 12 chars [1]
> >
> > [1]:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n177
> >
>
> OK.
>
> In my ~/.gitconfig:
>
> [core]
>        abbrev = 12
>
> # Check for 'Fixes:' tag used in the Linux-kernel development process
> (Thanks Kalle Valo).
> # Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst
> # Usage: $ git log --format=fixes | head -5
> [pretty]
>    fixes = Fixes: %h (\"%s\")
>
> Hope this is useful for others.
>

Changed to...

Link: https://www.kernel.org/doc/html/latest/process/submitting-patches.html

- Sedat -
