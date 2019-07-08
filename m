Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B0C62079
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2019 16:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbfGHO3r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Jul 2019 10:29:47 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34921 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfGHO3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:29:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so11095094lfa.2;
        Mon, 08 Jul 2019 07:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wbaTQs7XVTIjMbPZTFe9Yk64dlMj+blOtmWe+5amVKw=;
        b=QaXBv86g1J8MMEFr8yFlJevmxd5a0pe5FgM5b3a3ryrCvykMRj1vk/hjn3M2pKE62/
         zaxD5Ad7LTUVjD4db3ywyAhgGGjpJ1G1ajhp/Mz6Izfuaw5u1b6QduqQsBOb9PWK2tqE
         qOMpzQN8rGn+2+DWg48I1ykFL7yuw/dlMhsk1EVuYqc16iIdUULVJVgvhRKGKmxbzLVl
         3sm8AMsHRZPI3efdG61dwLhud3jfj/P2p1l2UmtQF31W/+ljOn1Zwt7dLQfnwEMAqZYT
         Ls0VcqrdVkUomekJKO0lZ3TXdW6GbTxh/9Q+rHfxZZMACWRN5Fa6R6GH3+peAF80vPtU
         ca4A==
X-Gm-Message-State: APjAAAX8c7rMEpIlQQn2jfChCTzXlrzrWeeGRbfJunsWxIETlfgKKCmp
        onX7c+NgEzyUKfW8pI2udIyk2MqaVRmTDlQuc3w=
X-Google-Smtp-Source: APXvYqyqi6Z74FgeUmSY/fM6fHVQs+s4VIRWPGZo5CWIqN67oSsfVrFDvhr/it0wDG5JnxulzHk67f7NgX7txaM0q6Y=
X-Received: by 2002:ac2:46ce:: with SMTP id p14mr9177220lfo.148.1562596184914;
 Mon, 08 Jul 2019 07:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190707050058.CO3VsTl8T%akpm@linux-foundation.org>
In-Reply-To: <20190707050058.CO3VsTl8T%akpm@linux-foundation.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 8 Jul 2019 16:29:27 +0200
Message-ID: <CAK8P3a2KVPsX-3VZdVXAa1yAJDevMwQ9VQdx5j8tyMDydb76FQ@mail.gmail.com>
Subject: Re: mmotm 2019-07-06-22-00 uploaded
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 7, 2019 at 7:05 AM <akpm@linux-foundation.org> wrote:

> * mm-move-mem_cgroup_uncharge-out-of-__page_cache_release.patch
> * mm-shrinker-make-shrinker-not-depend-on-memcg-kmem.patch
> * mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix.patch
> * mm-thp-make-deferred-split-shrinker-memcg-aware.patch

mm-shrinker-make-shrinker-not-depend-on-memcg-kmem-fix.patch fixes
the compile-time error when memcg_expand_shrinker_maps() is not
declared, but now we get a linker error instead because the
function is still not built into the kernel:

mm/vmscan.o: In function `prealloc_shrinker':
vmscan.c:(.text+0x328): undefined reference to `memcg_expand_shrinker_maps'

      Arnd
