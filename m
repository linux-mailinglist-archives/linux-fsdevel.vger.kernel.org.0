Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B45BCFB9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Sep 2022 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiISO6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Sep 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISO6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:58:16 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6753A19C01;
        Mon, 19 Sep 2022 07:58:15 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id w2so18085709pfb.0;
        Mon, 19 Sep 2022 07:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lnYJozcLUmTPYrU24R8V0lK2TwtYqvaT/IHSXf9uJg0=;
        b=hRmZP+oV1Bl8EjCD8HfT0GqgLngvsP/aBaoWTJ1ML06z73Xew4hyq/urnklLSYH3/q
         dMPY4mFzOip3Hsohb93b7CLrlknDnOe/YktWjjXLDjm6POoYbFn/tds3R2oy1BleZjSd
         ThdYET2VaFoimTq2WMbSzrMwONsyEuf+BbWVFjYn+yHXDGIr5BnnT3vcx7Gh0F0WzY/p
         UyPnLDLeZ+3OLuFYxtytUFI9A9D+YQsIRvdjN4Vbw3aWKFqXeYacSAt2wzSCLCm6BCA1
         Mo9MaxLow+r5p7N7q9QGNHdmyFNlnoiBVMgP+AFPXrq2mqMyaPABJXUP2NQ8TuNOElrQ
         s6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lnYJozcLUmTPYrU24R8V0lK2TwtYqvaT/IHSXf9uJg0=;
        b=Qvr9UNS0APM/OpQtGCVuHQ+L6AQ4+JznjIPhSQX/PBTd6dlaLgBIpyu3hfrCAVPn5f
         WC/jVFLYJ8oy+jo9oCklcpYZCSdQGfNmLCQipsaPg5svwk7/QUP9LKFHvf+XXPeC/Vil
         QiW8x9PSleZHU4tAdXmUm7aEiudbqEiEW98BdhzoYzlUUOhN2xeSyj1SG3VOsxHy0La+
         44OGG7/H33gCLs76oowCTE7PkHfAj5OfpYkK8VSROrKxCHqTCapRXFcn+dOKVWvrJBoQ
         8hOkHjfg5/BllwCHN8nGIopzHIVvpXhq82nB+c+3GDhLV5xjxGLH6C4M0e4jsM2YPGbp
         QPSQ==
X-Gm-Message-State: ACrzQf3GHsgMe/BmfUr0bl8cW7Aw0HPK/dUzqNVG90kdJX0OlFdixW3s
        chqPxuygvu0Vm/yV9yUgfmw=
X-Google-Smtp-Source: AMsMyM5ZYYdFuNeKzgLJKAadbdkw3BGTjlQj6CuVcT73oxkvecA7RXzVRlY7rFhCUdnWPJ2uEHW6bw==
X-Received: by 2002:a05:6a00:3392:b0:547:f861:1fad with SMTP id cm18-20020a056a00339200b00547f8611fadmr19226573pfb.16.1663599494511;
        Mon, 19 Sep 2022 07:58:14 -0700 (PDT)
Received: from gmail.com ([2601:600:8500:5f14:d627:c51e:516e:a105])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b00177324a7862sm21108171plf.45.2022.09.19.07.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 07:58:13 -0700 (PDT)
Date:   Mon, 19 Sep 2022 07:58:11 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 0/4] Implement IOCTL to get and clear soft dirty PTE
Message-ID: <YyiDg79flhWoMDZB@gmail.com>
References: <20220826064535.1941190-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20220826064535.1941190-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 11:45:31AM +0500, Muhammad Usama Anjum wrote:
> 
> Hello,
> 
> This patch series implements a new ioctl on the pagemap proc fs file to
> get, clear and perform both get and clear at the same time atomically on
> the specified range of the memory.
> 
> Soft-dirty PTE bit of the memory pages can be viewed by using pagemap
> procfs file. The soft-dirty PTE bit for the whole memory range of the
> process can be cleared by writing to the clear_refs file. This series
> adds features that weren't present earlier.
> - There is no atomic get soft-dirty PTE bit status and clear operation
>   present.
> - The soft-dirty PTE bit of only a part of memory cannot be cleared.
> 
> Historically, soft-dirty PTE bit tracking has been used in the CRIU
> project. The proc fs interface is enough for that as I think the process
> is frozen. We have the use case where we need to track the soft-dirty
> PTE bit for the running processes. We need this tracking and clear
> mechanism of a region of memory while the process is running to emulate
> the getWriteWatch() syscall of Windows. This syscall is used by games to
> keep track of dirty pages and keep processing only the dirty pages. This
> new ioctl can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information.
> 
> As in the current kernel there is no way to clear a part of memory (instead
> of clearing the Soft-Dirty bits for the entire process) and get+clear
> operation cannot be performed atomically, there are other methods to mimic
> this information entirely in userspace with poor performance:
> - The mprotect syscall and SIGSEGV handler for bookkeeping
> - The userfaultfd syscall with the handler for bookkeeping
> Some benchmarks can be seen [1].
> 
> This ioctl can be used by the CRIU project and other applications which
> require soft-dirty PTE bit information. The following operations are
> supported in this ioctl:
> - Get the pages that are soft-dirty.

I think this interface doesn't have to be limited by the soft-dirty
bits only. For example, CRIU needs to know whether file, present and swap bits
are set or not.

I mean we should be able to specify for what pages we need to get info
for. An ioctl argument can have these four fields:
* required bits (rmask & mask == mask) - all bits from this mask have to be set.
* any of these bits (amask & mask != 0) - any of these bits is set.
* exclude masks (emask & mask == 0) = none of these bits are set.
* return mask - bits that have to be reported to user.

> - Clear the pages which are soft-dirty.
> - The optional flag to ignore the VM_SOFTDIRTY and only track per page
> soft-dirty PTE bit
> 
> There are two decisions which have been taken about how to get the output
> from the syscall.
> - Return offsets of the pages from the start in the vec

We can conside to return regions that contains pages with the same set
of bits.

struct page_region {
	void *start;
	long size;
	u64 bitmap;
}

And ioctl returns arrays of page_region-s. I believe it will be more
compact form for many cases.

> - Stop execution when vec is filled with dirty pages
> These two arguments doesn't follow the mincore() philosophy where the
> output array corresponds to the address range in one to one fashion, hence
> the output buffer length isn't passed and only a flag is set if the page
> is present. This makes mincore() easy to use with less control. We are
> passing the size of the output array and putting return data consecutively
> which is offset of dirty pages from the start. The user can convert these
> offsets back into the dirty page addresses easily. Suppose, the user want
> to get first 10 dirty pages from a total memory of 100 pages. He'll
> allocate output buffer of size 10 and the ioctl will abort after finding the
> 10 pages. This behaviour is needed to support Windows' getWriteWatch(). The
> behaviour like mincore() can be achieved by passing output buffer of 100
> size. This interface can be used for any desired behaviour.
> 
> [1] https://lore.kernel.org/lkml/54d4c322-cd6e-eefd-b161-2af2b56aae24@collabora.com/
> 
> Regards,
> Muhammad Usama Anjum
> 
> Muhammad Usama Anjum (4):
>   fs/proc/task_mmu: update functions to clear the soft-dirty PTE bit
>   fs/proc/task_mmu: Implement IOCTL to get and clear soft dirty PTE bit
>   selftests: vm: add pagemap ioctl tests
>   mm: add documentation of the new ioctl on pagemap
> 
>  Documentation/admin-guide/mm/soft-dirty.rst |  42 +-
>  fs/proc/task_mmu.c                          | 342 ++++++++++-
>  include/uapi/linux/fs.h                     |  23 +
>  tools/include/uapi/linux/fs.h               |  23 +
>  tools/testing/selftests/vm/.gitignore       |   1 +
>  tools/testing/selftests/vm/Makefile         |   2 +
>  tools/testing/selftests/vm/pagemap_ioctl.c  | 649 ++++++++++++++++++++
>  7 files changed, 1050 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/vm/pagemap_ioctl.c
> 
> -- 
> 2.30.2
> 
