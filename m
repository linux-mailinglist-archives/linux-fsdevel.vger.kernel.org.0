Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DDE1D765A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 13:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgERLNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgERLM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 07:12:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F3BC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 04:12:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b91so8123911edf.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 May 2020 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCv2ZdCkY0qCMhbqU1FXB8Pdv4mOdNVdXKMY2xRHask=;
        b=HQzjzokgi4lY9NYMTDDWBnXLzsdgSdzg0fwgxvoGbCjB/wGQGnntdVBl/4A7CgVANm
         t3RUM/EjHKkPSlqHctqbr2W5sp+MBsczfHXSRCjcs6P89C6emJ0hte/tS14gz7/RIsxZ
         YycgIpnRwaXsSRc2T3Kp4LrhTaaSiLX11dq5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCv2ZdCkY0qCMhbqU1FXB8Pdv4mOdNVdXKMY2xRHask=;
        b=TqTlqjJhgEZVmxXV/vBmIbw9H41k3cRXFi+w1G7IlVhyHlMi7iTU8codSsMy0ddKIu
         y8y+QA5DcpO3hctM/Yl6Vy29poYLKq+3c55QSmwV/zknHTdzHouxuge+ITIPC+nRfoBr
         UrGMN+bNK1LdBRpRWHDtiBHPmGaaiw99ubYM0u99VPPQ5mvRxH0QcMUmK6eC6xcgnSEG
         DxNWqSSYLtAujKKB6+GuQgWI1wJLYUBqxML9bGUKelOxGyfterfktVGUicKptg3WX3+M
         RToi19oHSfPOi7XCrFNjenaDWma00Gv0mKW69DOUeDs6Uw5m8Kewpt1dnnYnYTu48FJN
         FH9w==
X-Gm-Message-State: AOAM531iqkLxstiw+Raazux2LWcT4R4q2q1z6rm9CCXA0qVBCOoo4liX
        R9GOhHK8y8pOXXNGItTAsHAfYqrbQv07T1T2iqs2/Q==
X-Google-Smtp-Source: ABdhPJxZ4VLvkgQkfYrdQPEgUccy2Gxq4UWk/GGJdjdM3rE6rYi+Thc9+WMOfS0GZAYv4rW6bvgBCMU2bphOkyRNkG4=
X-Received: by 2002:a50:d785:: with SMTP id w5mr12551406edi.212.1589800378320;
 Mon, 18 May 2020 04:12:58 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b4684e05a2968ca6@google.com> <aa7812b8-60ae-8578-40db-e71ad766b4d3@oracle.com>
 <CAJfpegtVca6H1JPW00OF-7sCwpomMCo=A2qr5K=9uGKEGjEp3w@mail.gmail.com>
 <d32b8579-04a3-2a9b-cd54-1d581c63332e@oracle.com> <86c504b3-52c9-55f6-13db-ab55b2f6980e@oracle.com>
In-Reply-To: <86c504b3-52c9-55f6-13db-ab55b2f6980e@oracle.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 May 2020 13:12:47 +0200
Message-ID: <CAJfpegsy5vzO5e3DJGTrpXoGRTzjegoLaDdzheDeQhw+uokYnQ@mail.gmail.com>
Subject: Re: kernel BUG at mm/hugetlb.c:LINE!
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     syzbot <syzbot+d6ec23007e951dadf3de@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miklos Szeredi <mszeredi@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 16, 2020 at 12:15 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:

> I started going down the path of creating a get_unmapped_area f_op for
> overlayfs.  That is pretty straight forward and works well.  But that
> did not take care of the is_file_hugepages() routine.  Recall that
> is_file_hugepages simply does if (file->f_op == &hugetlbfs_file_operations).
>
> I suppose I could add a specific overlayfs check like real_file here.  But,
> that does not seem like a clean solution.
>
> I also discovered other routines doing comparisons like
> if (file->f_op == <expected_fops>), they are:
> is_dma_buf_file()
> is_file_shm_hugepages()
> get_pipe_info()
> is_file_epoll()
>
> So, it seems that these routines are also impacted if operating on files
> in an overlayfs?

Those are non-filesystems, with the exception of
is_file_shm_hugepages(), the only caller of which is
is_file_hugepages().

> Any suggestions on how to move forward?  It seems like there may be the
> need for a real_file() routine?  I see a d_real dentry_op was added to
> deal with this issue for dentries.  Might we need something similiar for
> files (f_real)?
>
> Looking for suggestions as I do not normally work with this code.

And I'm not so familiar with hugepages code.  I'd suggest moving
length alignment into f_op->get_unmapped_area() and cleaning up other
special casing of hugetlb mappings, but it's probably far from
trivial...

So yeah, that leaves a real_file() helper or something similar.
Unlike the example I gave first it actually needs to be recursive:

static inline struct file *real_file(struct file *file)
{
    whole (unlikely(file->f_op == ovl_file_operations))
        file = file->private_data;
    return file;
}

Thanks,
Miklos
