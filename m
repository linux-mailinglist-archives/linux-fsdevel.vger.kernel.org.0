Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB7FD5C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Nov 2019 07:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbfKOGHW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Nov 2019 01:07:22 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36052 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbfKOGHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:07:22 -0500
Received: by mail-yw1-f68.google.com with SMTP id y64so2757711ywe.3;
        Thu, 14 Nov 2019 22:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfMBzJFnNmUQahUBw0EZwFzmsJYK2Vry1JCE+uhSoXY=;
        b=OkvNCKn5eXLUbf9TC9j+5PVedYDM0u94X6wNnC9tvDDEX4K7y/E6x4q58yihq9+0GV
         eDtcbR7GhLAxWNP2RtzaTyJBygPUx+GmVByopmjqrInxKGHRcvOyPHO0UAy/hc3KJCe6
         UHNKA8wVfY4ocAw0+e36C3A7XHE/bHNErweN646ijHE4TbMqkaR1r5sDEBY7lN9BXEB5
         ZcvfqQ/zkhDi1WRTh0txIFfujo3RKHFfp5HiGB79kyxHtM7ue5LxLtlStcV0ObvmoDfy
         erhUpJkWVuq6bVW6xXsNLDR86nPlt+Q1Qsbot/zxRDG8FPf0c9e411sJjisnpoII2rWW
         wBng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfMBzJFnNmUQahUBw0EZwFzmsJYK2Vry1JCE+uhSoXY=;
        b=HViadxC5IPJ3znZRtYOqfbqOTwnmPCJnsJ8BFBolX+hgnerIM8TLXOKScD5TdeNLmF
         k26bqYHR2QoPawcYeWNFzZHcFJupHuTrQ+eb80DuFPRsSW6PvX2aph+qaUzQf5r/4B5X
         L3xpcvY/Msc0w6MeWJ/Yh7s7VGW7dJBYKDNVPPNhFmbEaAIIC2TissZN0SefHZKBbSXo
         HDkvnc6/W/IUKymHI8guZq4NaDke1SF7ZdFpJyDvfzpTJ1OmWye1ZC0gd1R9xqYE+0O8
         VcuRHo5oTdgbne9hYad50i8pvERovIfOnKv9zMVgdo1N0rCsXbqYMhGOS3LSn40NSWRX
         TJuQ==
X-Gm-Message-State: APjAAAVYxdl9IOxX1VZrPRwoYKLpS6GKQjxGH5CeQ/FcVm05uJmQhEF3
        +2D64zyRsCmpQO3A/i12DuNDoqhlsgwaE9jq9yUHbWLv
X-Google-Smtp-Source: APXvYqzxKU4Ung9pjorO0gKEs5kTUCOUKb+vVy72/qGQwxNiursEmCnn6IWx3Wf9XY+PleNulM37FfrQAodBahlAFBY=
X-Received: by 2002:a81:2f0f:: with SMTP id v15mr8437480ywv.183.1573798039273;
 Thu, 14 Nov 2019 22:07:19 -0800 (PST)
MIME-Version: 1.0
References: <20191114154723.GJ26530@ZenIV.linux.org.uk> <20191114195544.GB5569@miu.piliscsaba.redhat.com>
 <CAOQ4uxhjAwU_V0cUF+VkQbAwXKTJKsZuyysNXMecuM9Y1iuUsw@mail.gmail.com>
 <CAOQ4uxhaw_H0ScTvehHqZVkp5KgBtd_bgcf-0bo_GnUrT8Rwqg@mail.gmail.com> <20191114234905.GL26530@ZenIV.linux.org.uk>
In-Reply-To: <20191114234905.GL26530@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 15 Nov 2019 08:07:08 +0200
Message-ID: <CAOQ4uxi1DCG5voZDXSxvsxMcyHDDc6YsqG=o7x1m6eVM8foTTQ@mail.gmail.com>
Subject: Re: [RFC] is ovl_fh->fid really intended to be misaligned?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 15, 2019 at 1:49 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Nov 15, 2019 at 01:13:15AM +0200, Amir Goldstein wrote:
>
> > See attached.
> > IMHO it looks much easier to verify that these changes are correct
> > compared to your open coded offset shifting all over the place.
> >
> > It even passed the exportfs tests first try.
> > Only some index tests are failing.
> >
> > If you like this version, I can fix up the failures and add Al's
> > suggestions to simplify code with OVL_FH_MAX_SIZE
> > memory allocations.
>
> Huh?  Correct me if I'm wrong, but doesn't that patch make it
> reject all old fhandles just on the type check?  That includes
> anything sent over the wire, or stored in xattrs, or represented
> as names in indexdir...

That's not what the patch does.
It does reject OVL_FILEID_V0 in ovl_fh_to_dentry(), but
that can easily be fixed to convert them on-the-fly.
I just left this part out.

The patch does not change on-disk format, not in xattr
and not in index names - or not intentionally anyway, see:

ovl_get_fh():
...
// reading xattr into aligned buffer at offset 3
        res = vfs_getxattr(dentry, name, fh->buf, res);
        if (res < 0)
                goto fail;
...
// checking old v0 on-disk format
        err = ovl_check_fb_len(&fh->fb, res);
...

ovl_verify_set_fh():
...
// encode correctly aligned buffer
        fh = ovl_encode_real_fh(real, is_upper);
...
// store old format into xattr
                err = ovl_do_setxattr(dentry, name, fh->buf, fh->fb.len, 0);

Similarly in ovl_get_index_name_fh():
// here was a bug
        n = kcalloc(fh->fb.len + OVL_FH_WIRE_OFFSET, 2, GFP_KERNEL);
...
// hex encode the old format
        s  = bin2hex(n, fh->buf, fh->fb.len);

>
> _If_ we can change the fhandle layout at will, everything's
> easy - you can add padding in any way you like.  But fhandles
> are a lot more permanent than this approach would require -
> mere rebooting the server into a new kernel must not make the
> clients see -ESTALE on everything they'd imported from it!
> And then there's implied "you can throw indexdir contents at
> any time", which is also not a good thing to do.
>

I think I understand the confusion.
There is no requirement that the file handles stored on-disk
will be the same format as those exported on wire.
The file handles coming from wire are rarely compared
with those on-disk and vice versa. IIRC, there is a single
place that uses an fh from wire to lookup on-disk:

ovl_lower_fh_to_d():
...
         /* Then lookup indexed upper/whiteout by origin fh */
        if (ofs->indexdir) {
                index = ovl_get_index_fh(ofs, fh);

But that is the exception.
Most of the time, the on-disk fh are used to make sure that
union inode numbers are persistently unique across the overlay.

> Sure, introducing a variant with better layout would be nice,
> and using a new type for it is pretty much required, but
> you can't just discard old-layout fhandles you'd ever issued.
>

In truth, we have ample evidence that ovl nfs export is not
widely in use. We know that docker and such have disabled
index because it exposed mount leak bugs that they have.
And we got too few nfs export bug reports (single reporter
IIRC).
But still, as I said, it is quite easy to respect OVL_FILEID_V0
file handles that were handed out to nfs clients after upgrade.

Unless I am still missing something...

Thanks,
Amir.
