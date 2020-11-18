Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412B32B7BAA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 11:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgKRKrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 05:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKRKrE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 05:47:04 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D479C0613D4;
        Wed, 18 Nov 2020 02:47:04 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id s10so1512036ioe.1;
        Wed, 18 Nov 2020 02:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LMBLLgynecbbMD9Rn0bZLsWto4x1x56DJrEAN5S/G0Y=;
        b=IfCWZBkXSBBv9iUUJGRLnh6FlUu5rmrpkEo7JVdfdxYbuGS235gTQ1FMnj5vjX7+UO
         mstJ8V51rxozUq0x+j7/1kb6CdJZZZTFXO75xUPEN1PyW/dZDNNSAfwWXqFBGI8786zA
         +pYgE8qV2G/FGhhWrKSuYVKyNmDA0oxY9Wa9H4stm587Oxva/1RGQERYzMuEFnjfNGzp
         2iMmog8N+nUK43EwdzDVFgpnOTUDTE0P4G3V46S8FseBCq+X0WY7Rz1qzMh7jt8b0Zyo
         cO/vaq1k7j8IzjBlJBMidNzypTp/yORzpU6woUHyyc8+12OXbUXc3O/a0/TDCiGd9295
         g3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LMBLLgynecbbMD9Rn0bZLsWto4x1x56DJrEAN5S/G0Y=;
        b=LGYEiM9oRLZjdlcyAin2elY7QCRivIHisiDcYqhFORC1WOF30kKtLcIP4GGiUVjMbh
         BIlltlypgKTrbuNOThCOnU68HSbziIEYPlhX6RUzNmH/bw4zbFQT4JDx45GreiNilXod
         Yuplx98wfrXJEIEhVz66zHfD0KnjPPzDvSdKjkBUr4IWCbu5c5Up1zF88te+jGv/8c4d
         YHwCNfHfzoZh8nlGss/i/0w01uv6ZSCeORs/dPsBvEU4t+0vvRg3amfyneIxY+Op4kVb
         8QFC4eQhcO/QiTO7KJYo/rJbtlBA0+kBUZ6pH+VrgZp6qE/Oh8whEhLF4+09s0lhGcNU
         cERQ==
X-Gm-Message-State: AOAM530SY+mK5eFKUoCOK7y++HbpQHFfVDfHrKvPdGBWzE7D1p1toscf
        8rHW8U2oSa2t0LEQhdGOSpsGaxtXpYbn/Pohhqg=
X-Google-Smtp-Source: ABdhPJzhnGmEocleFqD/Dg+OJggFFrlTMN2SpXkVeMfav2oYaVjZO6espQSQMcnVP2fqKRd+D3Z43CuEumIZRXntrto=
X-Received: by 2002:a02:9f16:: with SMTP id z22mr7423108jal.123.1605696423526;
 Wed, 18 Nov 2020 02:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20201116163615.GA17680@redhat.com> <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com> <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com> <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
 <20201117164600.GC78221@redhat.com> <CAOQ4uxgi-8sn4S3pRr0NQC5sjp9fLmVsfno1nSa2ugfM2KQLLQ@mail.gmail.com>
 <20201117182940.GA91497@redhat.com> <CAOQ4uxjkmooYY-NAVrSZOU9BDP0azmbrrmkKNKgyQOURR6eqEg@mail.gmail.com>
 <20201118082707.GA15687@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201118082707.GA15687@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 18 Nov 2020 12:46:52 +0200
Message-ID: <CAOQ4uxiQy9-jv5nVEcT10yNd+O1jG9cwXsch0SS3XzqFDRafEw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:27 AM Sargun Dhillon <sargun@sargun.me> wrote:
>
> On Wed, Nov 18, 2020 at 09:24:04AM +0200, Amir Goldstein wrote:
> > On Tue, Nov 17, 2020 at 8:29 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Nov 17, 2020 at 08:03:16PM +0200, Amir Goldstein wrote:
> > > > > > C. "shutdown" the filesystem if writeback errors happened and return
> > > > > >      EIO from any read, like some blockdev filesystems will do in face
> > > > > >      of metadata write errors
> > > > > >
> > > > > > I happen to have a branch ready for that ;-)
> > > > > > https://github.com/amir73il/linux/commits/ovl-shutdown
> > > > >
> > > > >
> > > > > This branch seems to implement shutdown ioctl. So it will still need
> > > > > glue code to detect writeback failure in upper/ and trigger shutdown
> > > > > internally?
> > > > >
> > > >
> > > > Yes.
> > > > ovl_get_acess() can check both the administrative ofs->goingdown
> > > > command and the upper writeback error condition for volatile ovl
> > > > or something like that.
> > >
> > > This approach will not help mmaped() pages though, if I do.
> > >
> > > - Store to addr
> > > - msync
> > > - Load from addr
> > >
> > > There is a chance that I can still read back old data.
> > >
> >
> > msync does not go through overlay. It goes directly to upper fs,
> > so it will sync pages and return error on volatile overlay as well.
> >
> > Maybe there will still be weird corner cases, but the shutdown approach
> > should cover most or all of the interesting cases.
> When would we check the errseq_t of the upperdir? Only when the user
> calls fsync, or upon close? Periodically?
>

Ideally, if it is not too costly, on every "access".

The ovl-shutdown branch adds a ovl_get_access() call before access to any
overlay object.

> >
> > Thanks,
> > Amir.
>
> We can tackle this later, but I suggest the following semantics, which
> follow how ext4 works:
>
> https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
> errors=remount-ro       Remount the filesystem read-only on an error.
> errors=continue         Keep going on a filesystem error.
> [Sargun: We probably don't want this one]
> errors=panic            Panic and halt the machine if an error occurs.
>                         (These mount options override the errors behavior
>                         specified in the superblock, which can be configured
>                         using tune2fs)

None of these modes seem relevant to volatile overlay IMO.

>
> ----
> We can potentially add a fourth option, which is shutdown -- that would
> return something like EIO or ESHUTDOWN for all calls.
>

FWIW, that's the only mode XFS supports.

> In addition to that, we should pass through the right errseqs to make
> the errseq helpers work:
> int filemap_check_wb_err(struct address_space *mapping, errseq_t since) [1]
> errseq_t filemap_sample_wb_err(struct address_space *mapping) [2]
> errseq_t file_sample_sb_err(struct file *file)
>

Are you referring to volatile or non-valatile overlayfs?

For fsync, because every overlay file has a "shadow" real file,
I think errseq of overlayfs file should already reflect the correct state
of the errseq of the real file.

For syncfs, we should record the errseq of upper fs on mount, as your
patch did.

For volatile overlay, syncfs should fail permanently if there was a writeback
error since mount, not only once, so there is no reason to update the
errseq on the overlay sb? It is not like one syncfs can observe an error and
in the next it will be gone.

For non-volatile overlay, we probably need to report syncfs error once if
upper fs errseq is bigger than ovl sb errseq and advance ovl sb errseq.

Thanks,
Amir.
