Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D44454297
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 09:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbhKQI1s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 03:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbhKQI1s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 03:27:48 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A549C061570
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 00:24:50 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id q74so5045219ybq.11
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 00:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+dwLMWwu2Sg6Zp6UBhanSJhQWX+9Ri/lE7Vz/ZzVQW8=;
        b=KEd38Wn7TzD3I3/2UFVRny4FBayUkc4zOIqRwirdxOvtJbh68KYi4Dwor3Rr4gYaZ4
         TCKkY4lEI/isRi8POMt6NdUlOrn3BV5OjCU5rABCJLuJs/MeK18g+hSoapeInRiUQTZS
         2Rkz6dPgn//ebUyRv96jQnVZ6dQLJejuPzaonL/4CWAwl2ldG+Js/BFbCNJwP7r9zn5n
         UjKBFYeh42Tloizcn3tswp2r7hv+6rY8dnJ2FNl20h57jfdhaiuLFD6/45Xy7KO7N/kx
         o+IPi0QrJIC7XKGkZJeYiYlEi169lRYd9xq2NK0z36M5MdZFIsqYlkKdW3el/H1T/sXZ
         KfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+dwLMWwu2Sg6Zp6UBhanSJhQWX+9Ri/lE7Vz/ZzVQW8=;
        b=pify1r7ht3aUb4rBhc35vnaTmwLP3FaFG4brE0Qo34PJSGvf7TLwDpJ0kdTiCGDn1V
         iQ7ZIItygXx4L4uU913Zou1B/IorakXAE5JtbJy+9hkpfaFx9Kf/qo9tIeXX1s6H3AKy
         AsGIkT33zkkmAcnQSSkAfSxbc9MxnXJbdh5hJ2dNn4jVetRdczGFsaaHcfY7N+O5ZDPa
         MfToaYocWO04PxanqD71pTsguadeKYPgvfqoXlIEq3ZrkvVIK6p7HMO4KtNMV58JqK9+
         A2MLRgTIaDxzEI4OIJ40PL0zeor1dI8AhlC1/TANf1u+TM0nidiLY0Tz9i1kNWQUZgf9
         s/AQ==
X-Gm-Message-State: AOAM530uyVp0tqy1zW4eX5XQCBjnlKgqrsFScshlHypy0dndShNC2D9q
        ZRS41sHKmgPRSgxuwdw/F1a/Cnu/owtDsD4htYbytA==
X-Google-Smtp-Source: ABdhPJwGJbbxTf6Disa8MHoyMDjfXsaOHQj50AZDsVTHLxfNBX/W1iLb8oDmjtVG3srUA3wmNoCScUe6NSE8AHKMeww=
X-Received: by 2002:a5b:648:: with SMTP id o8mr16436713ybq.208.1637137489382;
 Wed, 17 Nov 2021 00:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20211101093518.86845-1-songmuchun@bytedance.com>
 <20211115210917.96f681f0a75dfe6e1772dc6d@linux-foundation.org>
 <CAMZfGtX+GkVf_7D8G+Ss32+wYy1bcMgDpT5FJDA=a9gdjW36-w@mail.gmail.com> <20211116120104.f96b7f21a333c2c8d140e015@linux-foundation.org>
In-Reply-To: <20211116120104.f96b7f21a333c2c8d140e015@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Wed, 17 Nov 2021 16:24:10 +0800
Message-ID: <CAMZfGtWQRHFWAyrfoZ3tV67FFLJH7T=Wi2QVoiO=S9w=s0S7Kg@mail.gmail.com>
Subject: Re: [PATCH 0/4] remove PDE_DATA()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, gladkov.alexey@gmail.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 4:01 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 16 Nov 2021 16:26:12 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
>
> > >
> > > because new instances are sure to turn up during the development cycle.
> > >
> > > But I can handle that by staging the patch series after linux-next and
> > > reminding myself to grep for new PDE_DATA instances prior to
> > > upstreaming.
> >
> > I'd be happy if you could replace PDE_DATA() with inode->i_private.
> > In this case, should I still introduce pde_data() and perform the above
> > things to make this series smaller?
>
> I do tend to think that pde_data() would be better than open-coding
> inode->i_private everywhere.  More explanatory, easier if we decide to
> change it again in the future.
>

Got it. I'll do that in the next version. Thanks.
