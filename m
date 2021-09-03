Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 754E9400547
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Sep 2021 20:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350656AbhICSsj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Sep 2021 14:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350802AbhICSsd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:48:33 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C438C0613C1
        for <linux-fsdevel@vger.kernel.org>; Fri,  3 Sep 2021 11:47:33 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d16so285842ljq.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 11:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxQ+Qr7YPaLGE685i8Qhsb70C5/CP3uq+dG10rbYZ70=;
        b=aeAOf1HhD/MVvJF7n6CgbrcTB3IqvXzZ7V9Bso2CuLxbnXtu5olMXAQM4VeDrdy8Il
         Z8RH0YAw/8fqOzLfZTyVHjhoHWLsbs/W4ZXj9+gKfNOL7/w6NZJj3tUns7Sw1uoKMP32
         3b3KouBf10B7N3ZLkloX1nWHTqjSNyQJPy528=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxQ+Qr7YPaLGE685i8Qhsb70C5/CP3uq+dG10rbYZ70=;
        b=NptPPDhvyFWIlrcyKgz1NDXXZmORbIdSDxNfX6R0VKSh8phy1ZoKwgVeNNPCvRUeE6
         ujNcYC4gpVKeZPE6TWsen/AtrY90S21QgB2Fw4oK+MPvhHDR8qljtHRtf8EcHS/+FQkk
         vDeaoc+1PW2MriPTNnNo4sQd+0V48eCpoN2VafNnUxYczI7J4+WbtQTQ4O7xDsvCyb0R
         A5AtoFIe4bkgIFvjGlHkwnyV7CnyGWGbXqDplJutFL2zIo9836LRzkHCAy5OMISiLm58
         R3Z6BygXMX/KhCCvDE5X+ndjOQytNjf4RO+dQ+g/wWWQNElthzW3RD/1lB9B+YfPB6Fh
         mzdQ==
X-Gm-Message-State: AOAM533kTBkIuSxwMDdK1G5Ro7edpl5+8N2THlSTJ+ux1/3FF71JwZR9
        PXxaGBEpMZJxju6KovhxEr8oGWqsVo22+BZMZc8=
X-Google-Smtp-Source: ABdhPJz8JmR/8O0u3StucWXcFc9YGGsJOi1ZbJgLt+nSEIVbO8DFaym2ydBkOSEvKHooIg4FBRfDXw==
X-Received: by 2002:a2e:b014:: with SMTP id y20mr300585ljk.311.1630694850780;
        Fri, 03 Sep 2021 11:47:30 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id x7sm23727lfe.61.2021.09.03.11.47.29
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Sep 2021 11:47:29 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id t12so119357lfg.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Sep 2021 11:47:29 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr269355lfu.280.1630694848707;
 Fri, 03 Sep 2021 11:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210827164926.1726765-1-agruenba@redhat.com> <CAHk-=wiUtyoTWuzroNJQwQDM9GHRXvq4974VL=y8T_3tUxDbkA@mail.gmail.com>
 <CAHc6FU7K0Ho=nH6fCK+Amc7zEg2G31v+gE3920ric3NE4MfH=A@mail.gmail.com>
 <CAHk-=wjUs8qy3hTEy-7QX4L=SyS85jF58eiT2Yq2YMUdTFAgvA@mail.gmail.com> <YTJoqq0fVB+xAB7w@zeniv-ca.linux.org.uk>
In-Reply-To: <YTJoqq0fVB+xAB7w@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Sep 2021 11:47:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVNs=67KdMg21wxQdKuOJNg2p3d9t6dX-u3Jw+tzxjoQ@mail.gmail.com>
Message-ID: <CAHk-=whVNs=67KdMg21wxQdKuOJNg2p3d9t6dX-u3Jw+tzxjoQ@mail.gmail.com>
Subject: Re: [PATCH v7 00/19] gfs2: Fix mmap + page fault deadlocks
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        cluster-devel <cluster-devel@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ocfs2-devel@oss.oracle.com, kvm-ppc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 3, 2021 at 11:28 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> FWIW, my objections regarding the calling conventions are still there.

So I'm happy to further change the calling conventions, but by now
_that_ part is most definitely a "not this merge window". The need for
that ternary state is still there.

It might go away in the future, but I think that's literally that: a
future cleanup. Not really related to the problem at hand.

              Linus
