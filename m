Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B65A524D5E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 May 2022 14:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbiELMst (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 May 2022 08:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352042AbiELMsr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 May 2022 08:48:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD9124D631
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 05:48:39 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id bq30so8890079lfb.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 May 2022 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zc35pogulMC60n85o7JSl7MYP5a9E2uD++K0T7qDYbg=;
        b=VzdBX1dC99Ss/8QRwvmpetZ3YgLdsHPIWTss0aGICSIJWHB+jpIhv81eeEpM/ri8Pi
         dCVyv70d28C4dudzgOnlgV0CxZbDLLTzVg7R9vN5NVLcPwXr772mS5j/bIaY9Aw+N1T0
         w1XBo2w4F8HDMCXy5FP/uN/p70u5bZmeqUyistkjAG0jvvw7LD4r96tmNHKvFo90QpGP
         nRVCWOKhL/n2By+ZKflDN7sYrayeq376w7TFD7EnMJ3FKgnTxcG5QLQ5OYnoNth3xwJN
         pvEwxT3GxE3f67fImwXLTC8IbBJHWW9RUeSZLotTmlfn7vqkOWC/W0Zv7+I1KMagdvvu
         CisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zc35pogulMC60n85o7JSl7MYP5a9E2uD++K0T7qDYbg=;
        b=wWOseHB2W4zswx959nnUyPKeM/FUe6aqlbODIL0npqNv1O5hmBAI/pF7teOLuizkXq
         8hnJIt6QDVHQj25CVcGPLS6nEs7wzy3uRSLBWc+nm539qd/bmq8HkYi5xUydnA9tcOBG
         pP/b3Yy6Ntj1QRp4K6fliZRxWoaeLA+xSnDi4ESrnHTaboTBK9vpyuKy73/uKNx+KZTp
         x2BocD8xcnB7gC22slEmNlf+/YnxvRKEUrOH1tDoEwK0KmVaa2011lpDanA8601U0iBl
         EMX64G8puKZhFBF46lCmuD1t2LGPZ1i7kPP++lJVORtBzgYIfyFvPFv61K6Olj8BC/pt
         PrRw==
X-Gm-Message-State: AOAM533bW4RoqIqlK5u7QI5d2TMUy2G6FeN21S1lSkWQwPTX6v1WDNwa
        bwCf80zYKa8ICYg8n/HD0SDf51EuqLK9t/svlPPtKg==
X-Google-Smtp-Source: ABdhPJxXl2eFhmpJCUob2K0h3XdKxfTDVDgM7Wluv/tSa3tCP+EK2kphVO+LNgvV5A9N/eK1GMegWFCO3qsWXFyJf5Q=
X-Received: by 2002:ac2:4ac9:0:b0:471:f6da:640d with SMTP id
 m9-20020ac24ac9000000b00471f6da640dmr23484196lfp.286.1652359717248; Thu, 12
 May 2022 05:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220511154503.28365-1-cgxu519@mykernel.net> <YnvbhmRUxPxWU2S3@casper.infradead.org>
 <YnwIDpkIBem+MeeC@gmail.com> <YnwuEt2Xm1iPjW7S@zeniv-ca.linux.org.uk> <CAADnVQ+tcrDQxb769yMYvyzPHcgZXozqYq0uj4QHi+kjzBYTvQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+tcrDQxb769yMYvyzPHcgZXozqYq0uj4QHi+kjzBYTvQ@mail.gmail.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Thu, 12 May 2022 05:48:25 -0700
Message-ID: <CAMzD94Q+L-8YN89QX5_LS2b1oLX2Yq7p+bKVoaRsouaUT34hkA@mail.gmail.com>
Subject: Re: [PATCH] vfs: move fdput() to right place in ksys_sync_file_range()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sure, let me take a look.

On Wed, May 11, 2022 at 7:04 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 2:43 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > [bpf folks Cc'd]
> >
> > On Wed, May 11, 2022 at 07:01:34PM +0000, Eric Biggers wrote:
> > > On Wed, May 11, 2022 at 04:51:34PM +0100, Matthew Wilcox wrote:
> > > > On Wed, May 11, 2022 at 11:45:03AM -0400, Chengguang Xu wrote:
> > > > > Move fdput() to right place in ksys_sync_file_range() to
> > > > > avoid fdput() after failed fdget().
> > > >
> > > > Why?  fdput() is already conditional on FDPUT_FPUT so you're ...
> > > > optimising the failure case?
> > >
> > > "fdput() after failed fdget()" has confused people before, so IMO it's worth
> > > cleaning this up.  But the commit message should make clear that it's a cleanup,
> > > not a bug fix.  Also I recommend using an early return:
> > >
> > >       f = fdget(fd);
> > >       if (!f.file)
> > >               return -EBADF;
> > >       ret = sync_file_range(f.file, offset, nbytes, flags);
> > >       fdput(f);
> > >       return ret;
> >
> > FWIW, fdput() after failed fdget() is rare, but there's no fundamental reasons
> > why it would be wrong.  No objections against that patch, anyway.
> >
> > Out of curiousity, I've just looked at the existing users.  In mainline we have
> > 203 callers of fdput()/fdput_pos(); all but 7 never get reached with NULL ->file.
> >
> > 1) There's ksys_sync_file_range(), kernel_read_file_from_fd() and ksys_readahead() -
> > all with similar pattern.  I'm not sure that for readahead(2) "not opened for
> > read" should yield the same error as "bad descriptor", but since it's been a part
> > of userland ABI for a while...
> >
> > 2) two callers in perf_event_open(2) are playing silly buggers with explicit
> >         struct fd group = {NULL, 0};
> > and rely upon "fdput() is a no-op if we hadn't touched that" (note that if
> > we try to touch it and get NULL ->file from fdget(), we do not hit those fdput()
> > at all).
> >
> > 3) ovl_aio_put() is hard to follow (and some of the callers are poking
> > where they shouldn't), no idea if it's correct.  struct fd is manually
> > constructed there, anyway.
> >
> > 4) bpf generic_map_update_batch() is really asking for trouble.  The comment in
> > there is wrong:
> >         f = fdget(ufd); /* bpf_map_do_batch() guarantees ufd is valid */
> > *NOTHING* we'd done earlier can guarantee that.  We might have a descriptor
> > table shared with another thread, and it might have very well done dup2() since
> > the last time we'd looked things up.  IOW, this fdget() is racy - the function
> > assumes it refers to the same thing that gave us map back in bpf_map_do_batch(),
> > but it's not guaranteed at all.
> >
> > I hadn't put together a reproducer, but that code is very suspicious.  As a general
> > rule, you should treat descriptor table as shared object, modifiable by other
> > threads.  It can be explicitly locked and it can be explicitly unshared, but
> > short of that doing a lookup for the same descriptor twice in a row can yield
> > different results.
> >
> > What's going on there?  Do you really want the same struct file you've got back in
> > bpf_map_do_batch() (i.e. the one you've got the map from)?  What should happen
> > if the descriptor changes its meaning during (or after) the operation?
>
> Interesting.
> If I got this right... in the following:
>
> f = fdget(ufd);
> map = __bpf_map_get(f);
> if (IS_ERR(map))
>    return PTR_ERR(map);
> ...
> f = fdget(ufd);
> here there are no guarantees that 'f' is valid and points
> to the same map.
> Argh. In hindsight that makes sense.
>
> generic_map_update_batch calls bpf_map_update_value.
> That could use 'f' for prog_array, fd_array and hash_of_maps
> types of maps.
> The first two types don't' define .map_update_batch callback.
> So BPF_DO_BATCH(map->ops->map_update_batch); will error out
> with -ENOTSUPP since that callback is NULL for that map type.
>
> The hash_of_maps does seem to support it, but
> that's an odd one to use with batch access.
>
> Anyhow we certainly need to clean this up.
>
> Brian,
> do you mind fixing it up, since you've added that
> secondary fdget() in the first place?
>
> Thanks!
