Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7742028C736
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 04:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgJMCp0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Oct 2020 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgJMCpZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Oct 2020 22:45:25 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C476FC0613D0;
        Mon, 12 Oct 2020 19:45:25 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l85so20889260oih.10;
        Mon, 12 Oct 2020 19:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vZTbY4ShhrUv//2VK29yAWGy/g3LO64/rb+sQCyegOQ=;
        b=VBUKIfL8soO6/VWyli861iToCaYbpd+QOyNJbE+8U5PLnX9wGz2xXhYmNSouy4f0Md
         iig+kLaS/LdoCnY5iiTjitLUKUHg6SeXJpnJuG+zruwehAtH10ksY2mEMVihvo7ygVQ4
         nFyyt3X+FY/FSftH5/xKqAAnYz1pACXmPOu5VnxsySouxk3nf/a3McUZyYS50bHTjwM7
         eexOBDVEKDpkbdE84sIEUboP3yXcxahKdz7Td96ur7WcgbcXFyxSXxg5TjSr+YhD2I9k
         o+jq9+WS8g4VPaML2qqldtmAvLY/AYFtFr7Bxl3ydKjdFHYx0AD+HXTcGqaEmmRh1cyM
         4LWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vZTbY4ShhrUv//2VK29yAWGy/g3LO64/rb+sQCyegOQ=;
        b=axT9EPk3SSbHzHPx7fMk5XjRNKb5d3S63H2jkxSCYq/6RFUFfX0qBzyueNszQBpqXN
         tr4BvIL2+AIrnPMzOFveJ1W8KdoziAukrWgVwg1x4Iloii6NjVj2v8gblYy5XLAKGIyG
         cqAN7NOy2MozmUtuQFoosD02f3AyHxCshAx9mNeZZbk9lR4/8gASCLFBRJj+p9L030Fe
         w2L+eCvpHBBo6ds8UXCH3TqwNp0u8UY8oIuAD1seoFUISzrFqjD4iRWOt5e3wkeZS90O
         MsayvRsuOMoobdGdabZfiUbJFaugj1f4O4h66CowlBcHQbj5mgK5EqkcWqrdLbagTJ34
         uX4g==
X-Gm-Message-State: AOAM531FJglwylS8LXKkhlBmQ6VqWbH5Hf9xEPPF5suJ6kkXvZb83uAa
        B7pQKtnLurkVgqGJIKMx0NPBRH6qeXysvGXegOg=
X-Google-Smtp-Source: ABdhPJzXv8XjFlSJhZQcHJtIqnVcHRwWkhQpDEv50RxyifDLE0hGnMIkdx5eZHJ0yf+Ul5ig1if0+P9WDPQt+UvXks4=
X-Received: by 2002:aca:f455:: with SMTP id s82mr13204747oih.40.1602557125107;
 Mon, 12 Oct 2020 19:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602093760.git.yuleixzhang@tencent.com> <678F3D1BB717D949B966B68EAEB446ED49E01801@dggemm526-mbx.china.huawei.com>
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED49E01801@dggemm526-mbx.china.huawei.com>
From:   yulei zhang <yulei.kernel@gmail.com>
Date:   Tue, 13 Oct 2020 10:45:14 +0800
Message-ID: <CACZOiM2UbA-1hTVQkA4sjX+PVduCdjycFdenR2QxPqkG8kYxpg@mail.gmail.com>
Subject: Re: [PATCH 00/35] Enhance memory utilization with DMEMFS
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xiaoguangrong.eric@gmail.com" <xiaoguangrong.eric@gmail.com>,
        "kernellwp@gmail.com" <kernellwp@gmail.com>,
        "lihaiwei.kernel@gmail.com" <lihaiwei.kernel@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 12, 2020 at 7:57 PM Zengtao (B) <prime.zeng@hisilicon.com> wrote:
>
>
> > -----Original Message-----
> > From: yulei.kernel@gmail.com [mailto:yulei.kernel@gmail.com]
> > Sent: Thursday, October 08, 2020 3:54 PM
> > To: akpm@linux-foundation.org; naoya.horiguchi@nec.com;
> > viro@zeniv.linux.org.uk; pbonzini@redhat.com
> > Cc: linux-fsdevel@vger.kernel.org; kvm@vger.kernel.org;
> > linux-kernel@vger.kernel.org; xiaoguangrong.eric@gmail.com;
> > kernellwp@gmail.com; lihaiwei.kernel@gmail.com; Yulei Zhang
> > Subject: [PATCH 00/35] Enhance memory utilization with DMEMFS
> >
> > From: Yulei Zhang <yuleixzhang@tencent.com>
> >
> > In current system each physical memory page is assocaited with
> > a page structure which is used to track the usage of this page.
> > But due to the memory usage rapidly growing in cloud environment,
> > we find the resource consuming for page structure storage becomes
> > highly remarkable. So is it an expense that we could spare?
> >
> > This patchset introduces an idea about how to save the extra
> > memory through a new virtual filesystem -- dmemfs.
> >
> > Dmemfs (Direct Memory filesystem) is device memory or reserved
> > memory based filesystem. This kind of memory is special as it
> > is not managed by kernel and most important it is without 'struct page'.
> > Therefore we can leverage the extra memory from the host system
> > to support more tenants in our cloud service.
> >
> > We uses a kernel boot parameter 'dmem=' to reserve the system
> > memory when the host system boots up, the details can be checked
> > in /Documentation/admin-guide/kernel-parameters.txt.
> >
> > Theoretically for each 4k physical page it can save 64 bytes if
> > we drop the 'struct page', so for guest memory with 320G it can
> > save about 5G physical memory totally.
>
> Sounds interesting, but seems your patch only support x86, have you
>  considered aarch64?
>
> Regards
> Zengtao

Thanks, so far we only verify it on x86 server, may extend to arm platform
in the future.
