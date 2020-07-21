Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4BE228984
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 21:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730639AbgGUTxe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 15:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgGUTxe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:53:34 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31792C061794
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 12:53:34 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so22855087eje.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 12:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2aZrKVuHDqzp/6/afoPT5Qs7CpE30a6L99Z/Un6I84=;
        b=ayTKHcDSCpiaNGmYVNtgwj9ueSrIFcBwXg0ubOzfyGztVsEhB6PhS2XNOblKELmtzI
         WINWFpIxZbgE1Xm55V4YcuekUNWPuvcwsb6i1Dg2ZWopqukflpWGRwjs9HJZ1V53EUB6
         BsldDfIXHzbgnMd4lj9ZbA5WYvJVLryzGNa8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2aZrKVuHDqzp/6/afoPT5Qs7CpE30a6L99Z/Un6I84=;
        b=RXjZzz8Q9zzkUkHld29xr0HQPvVpOoc5qep5CGL0yKXtFTi+Pat9SblosqIlqMuKbB
         1OUPcTfrnF2EUMiJlBrfXG41aFOnJzncYBlNs+100LhgR8Jo65mOkAg7B0919LrQnm2A
         j90yco739zbvKVmdUtuoBg/j6/j3D6OD8/z1cN+2czrYca8g+h8rZw9EzsqFUtgZ4+mi
         AIU6c6/TBqRxNoUR/2SCKVZAcYtXxjk/i2eaBAQdsYmosdxUIsj9mg+WA/uEHKc7/QWu
         vqx8MbUz69ogf3XHcfsentFcjnkT16zotm1SdlSl70dUP98hyAREyc9mOE4F66QpYFhs
         IwCw==
X-Gm-Message-State: AOAM5329/1lsmIkwx+LeQJ4gy9d8e4m7HaAEXundSV4f0K8ArXhVLqV2
        yvYBkKtAXcn/IPbOn1Ral6105Ubu6E4pzmqHJ45q8g==
X-Google-Smtp-Source: ABdhPJxdNXMAvrVkg+cXy2SL0lBNmAfyXcvFF627FJRxM0N37MSPVmDezagbU5IaoDXihGe0ubfQw9Ix9JYjt+4VLm4=
X-Received: by 2002:a17:906:824c:: with SMTP id f12mr23824828ejx.443.1595361212872;
 Tue, 21 Jul 2020 12:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200716144032.GC422759@redhat.com> <20200716181828.GE422759@redhat.com>
 <CAJfpegt-v6sjm2WyjXMWkObqLdL6TSAi=rjra4KK5sNy6hhhmA@mail.gmail.com>
 <20200720154112.GC502563@redhat.com> <CAJfpegtked-aUq0zbTQjmspG04LG3ar-j_BRsb88kR+cnHNO_w@mail.gmail.com>
 <20200721151655.GB551452@redhat.com> <CAJfpegtiSNVhnH_FF8qyd2+NO8EJyXoJhPzRVsus8qm4d6UABQ@mail.gmail.com>
 <20200721155503.GC551452@redhat.com>
In-Reply-To: <20200721155503.GC551452@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 21 Jul 2020 21:53:21 +0200
Message-ID: <CAJfpegsUsZ1DLW6rzR4PQ=M2MxCY1r87eu2rP0Nac4Li_VEm7Q@mail.gmail.com>
Subject: Re: [PATCH] virtiofs: Enable SB_NOSEC flag to improve small write performance
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        virtio-fs-list <virtio-fs@redhat.com>,
        ganesh.mahalingam@intel.com
Content-Type: multipart/mixed; boundary="00000000000061eee205aaf8fa6b"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--00000000000061eee205aaf8fa6b
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 21, 2020 at 5:55 PM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Tue, Jul 21, 2020 at 05:44:14PM +0200, Miklos Szeredi wrote:
> > On Tue, Jul 21, 2020 at 5:17 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > >
> > > On Tue, Jul 21, 2020 at 02:33:41PM +0200, Miklos Szeredi wrote:
> > > > On Mon, Jul 20, 2020 at 5:41 PM Vivek Goyal <vgoyal@redhat.com> wrote:
> > > > >
> > > > > On Fri, Jul 17, 2020 at 10:53:07AM +0200, Miklos Szeredi wrote:
> > > >
> > > > > I see in VFS that chown() always kills suid/sgid. While truncate() and
> > > > > write(), will suid/sgid only if caller does not have CAP_FSETID.
> > > > >
> > > > > How does this work with FUSE_HANDLE_KILLPRIV. IIUC, file server does not
> > > > > know if caller has CAP_FSETID or not. That means file server will be
> > > > > forced to kill suid/sgid on every write and truncate. And that will fail
> > > > > some of the tests.
> > > > >
> > > > > For WRITE requests now we do have the notion of setting
> > > > > FUSE_WRITE_KILL_PRIV flag to tell server explicitly to kill suid/sgid.
> > > > > Probably we could use that in cached write path as well to figure out
> > > > > whether to kill suid/sgid or not. But truncate() will still continue
> > > > > to be an issue.
> > > >
> > > > Yes, not doing the same for truncate seems to be an oversight.
> > > > Unfortunate, since we'll need another INIT flag to enable selective
> > > > clearing of suid/sgid on truncate.
> > > >
> > > > >
> > > > > >
> > > > > > Even writeback_cache could be handled by this addition, since we call
> > > > > > fuse_update_attributes() before generic_file_write_iter() :
> > > > > >
> > > > > > --- a/fs/fuse/dir.c
> > > > > > +++ b/fs/fuse/dir.c
> > > > > > @@ -985,6 +985,7 @@ static int fuse_update_get_attr(struct inode
> > > > > > *inode, struct file *file,
> > > > > >
> > > > > >         if (sync) {
> > > > > >                 forget_all_cached_acls(inode);
> > > > > > +               inode->i_flags &= ~S_NOSEC;
> > > > >
> > > > > Ok, So I was clearing S_NOSEC only if server reports that file has
> > > > > suid/sgid bit set. This change will clear S_NOSEC whenever we fetch
> > > > > attrs from host and will force getxattr() when we call file_remove_privs()
> > > > > and will increase overhead for non cache writeback mode. We probably
> > > > > could keep both. For cache writeback mode, clear it undonditionally
> > > > > otherwise not.
> > > >
> > > > We clear S_NOSEC because the attribute timeout has expired.  This
> > > > means we need to refresh all metadata, including cached xattr (which
> > > > is what S_NOSEC effectively is).
> > > >
> > > > > What I don't understand is though that how this change will clear
> > > > > suid/sgid on host in cache=writeback mode. I see fuse_setattr()
> > > > > will not set ATTR_MODE and clear S_ISUID and S_ISGID if
> > > > > fc->handle_killpriv is set. So when server receives setattr request
> > > > > (if it does), then how will it know it is supposed to kill suid/sgid
> > > > > bit. (its not chown, truncate and its not write).
> > > >
> > > > Depends.  If the attribute timeout is infinity, then that means the
> > > > cache is always up to date.  In that case we only need to clear
> > > > suid/sgid if set in i_mode.  Similarly, the security.capability will
> > > > only be cleared if it was set in the first place (which would clear
> > > > S_NOSEC).
> > > >
> > > > If the timeout is finite, then that means we need to check if the
> > > > metadata changed after a timeout.  That's the purpose of the
> > > > fuse_update_attributes() call before generic_file_write_iter().
> > > >
> > > > Does that make it clear?
> > >
> > > I understood it partly but one thing is still bothering me. What
> > > happens when cache writeback is set as well as fc->handle_killpriv=1.
> > >
> > > When handle_killpriv is set, how suid/sgid will be cleared by
> > > server. Given cache=writeback, write probably got cached in
> > > guest and server probably will not not see a WRITE immideately.
> > > (I am assuming we are relying on a WRITE to clear setuid/setgid when
> > >  handle_killpriv is set). And that means server will not clear
> > >  setuid/setgid till inode is written back at some point of time
> > >  later.
> > >
> > > IOW, cache=writeback and fc->handle_killpriv don't seem to go
> > > together (atleast given the current code).
> >
> > fuse_cache_write_iter()
> >   -> fuse_update_attributes()   * this will refresh i_mode
> >   -> generic_file_write_iter()
> >       ->__generic_file_write_iter()
> >           ->file_remove_privs()    * this will check i_mode
> >               ->__remove_privs()
> >                   -> notify_change()
> >                      -> fuse_setattr()   * this will clear suid/sgit bits
>
> And fuse_setattr() has following.
>
>                 if (!fc->handle_killpriv) {
>                         /*
>                          * ia_mode calculation may have used stale i_mode.
>                          * Refresh and recalculate.
>                          */
>                         ret = fuse_do_getattr(inode, NULL, file);
>                         if (ret)
>                                 return ret;
>
>                         attr->ia_mode = inode->i_mode;
>                         if (inode->i_mode & S_ISUID) {
>                                 attr->ia_valid |= ATTR_MODE;
>                                 attr->ia_mode &= ~S_ISUID;
>                         }
>                         if ((inode->i_mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
>                                 attr->ia_valid |= ATTR_MODE;
>                                 attr->ia_mode &= ~S_ISGID;
>                         }
>                 }
>         }
>         if (!attr->ia_valid)
>                 return 0;
>
> So if fc->handle_killpriv is set, we might not even send setattr
> request if attr->ia_valid turns out to be zero.

Ah, right you are.  The writeback_cache case is indeed special.

The way that can be properly solved, I think, is to check if any
security bits need to be removed before calling into
generic_file_write_iter() and if yes, fall back to unbuffered write.

Something like the attached?

Thanks,
Miklos

--00000000000061eee205aaf8fa6b
Content-Type: text/x-patch; charset="US-ASCII"; name="t.patch"
Content-Disposition: attachment; filename="t.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kcwcufj30>
X-Attachment-Id: f_kcwcufj30

ZGlmZiAtLWdpdCBhL2ZzL2Z1c2UvZmlsZS5jIGIvZnMvZnVzZS9maWxlLmMKaW5kZXggODNkOTE3
ZjdlNTQyLi5mNjdjNmY0NmRhZTkgMTAwNjQ0Ci0tLSBhL2ZzL2Z1c2UvZmlsZS5jCisrKyBiL2Zz
L2Z1c2UvZmlsZS5jCkBAIC0xMjQ1LDE2ICsxMjQ1LDIxIEBAIHN0YXRpYyBzc2l6ZV90IGZ1c2Vf
Y2FjaGVfd3JpdGVfaXRlcihzdHJ1Y3Qga2lvY2IgKmlvY2IsIHN0cnVjdCBpb3ZfaXRlciAqZnJv
bSkKIAlzc2l6ZV90IHdyaXR0ZW4gPSAwOwogCXNzaXplX3Qgd3JpdHRlbl9idWZmZXJlZCA9IDA7
CiAJc3RydWN0IGlub2RlICppbm9kZSA9IG1hcHBpbmctPmhvc3Q7CisJc3RydWN0IGZ1c2VfY29u
biAqZmMgPSBnZXRfZnVzZV9jb25uKGlub2RlKTsKIAlzc2l6ZV90IGVycjsKIAlsb2ZmX3QgZW5k
Ynl0ZSA9IDA7CiAKLQlpZiAoZ2V0X2Z1c2VfY29ubihpbm9kZSktPndyaXRlYmFja19jYWNoZSkg
eworCWlmIChmYy0+d3JpdGViYWNrX2NhY2hlKSB7CiAJCS8qIFVwZGF0ZSBzaXplIChFT0Ygb3B0
aW1pemF0aW9uKSBhbmQgbW9kZSAoU1VJRCBjbGVhcmluZykgKi8KIAkJZXJyID0gZnVzZV91cGRh
dGVfYXR0cmlidXRlcyhtYXBwaW5nLT5ob3N0LCBmaWxlKTsKIAkJaWYgKGVycikKIAkJCXJldHVy
biBlcnI7CiAKLQkJcmV0dXJuIGdlbmVyaWNfZmlsZV93cml0ZV9pdGVyKGlvY2IsIGZyb20pOwor
CQlpZiAoIWZjLT5oYW5kbGVfa2lsbHByaXYgfHwKKwkJICAgICFzaG91bGRfcmVtb3ZlX3N1aWQo
ZmlsZS0+Zl9wYXRoLmRlbnRyeSkpCisJCQlyZXR1cm4gZ2VuZXJpY19maWxlX3dyaXRlX2l0ZXIo
aW9jYiwgZnJvbSk7CisKKwkJLyogRmFsbCBiYWNrIHRvIHVuYnVmZmVyZWQgd3JpdGUgdG8gcmVt
b3ZlIFNVSUQvU0dJRCBiaXRzICovCiAJfQogCiAJaW5vZGVfbG9jayhpbm9kZSk7Cg==
--00000000000061eee205aaf8fa6b--
