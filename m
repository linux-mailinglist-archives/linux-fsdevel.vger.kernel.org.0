Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2FDD31D089
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 19:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhBPSzN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 13:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbhBPSzJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 13:55:09 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522B9C061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 10:54:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id l18so6534618pji.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 10:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=LSS7VeTFf1sWhJY5fyJQl0KheTd9K60JF6FeH3GCxrg=;
        b=bDyDPQV7jxm9AC9Kbej44nUyO7e9ikQAVBWHWuCf6m4SsjoZkV9pWHXIsx06dO+ak6
         8aSM2SymVDyYuub9YyXC8OmIBO5oFcqGvwGNepwlZ7ccyJfhcO8QIBql9JI3pqiX2Fuw
         j1klif/eeC82LALv7vbfEOF36jgpMBTsgIysLtIYOy5/V/AMnw+vobQiVIkTJp1UWc9w
         DBJpDEAjqFxxbKednKjcTl1kcQJ9o42fsCnjttKtraIjnebn0Gpj+GPYsAe4P1dvBQTx
         +Yu/ej7/HAC1/mff1R/7rpIBIU7G2uz6/1mHBZKRW2iyUUsEXYKiqiR/s+gFdY9x4S4k
         7DDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=LSS7VeTFf1sWhJY5fyJQl0KheTd9K60JF6FeH3GCxrg=;
        b=lGgnDDBZTkf5rd44jzdy74iYjZc1PD0NKc3r27fZvQiri7L3WG1QnYRQvIw5m8RlO3
         2I3TwIvuf8eYYUEr494YuL6cIA0z7Bgkc+/lqm5KTXN/qRZGQt/CrHbvroC5PwTO0UWe
         twVgJ8v7WOvUjPaACMERhLc9fZ0qJ4VZYm0t1yifd11hPjRPiNgwwcL2N6rmQOE9U4KH
         WGcKxNGO8PXWr6yrsnHAk8LnhudBJOkYpGPuewshZFd7uAz9wo5eMaPEJtjr4ICeBYM8
         64sJZoKJzcT3OFhKH5HJRgRLp/I7FwJBrXDNMGGlNnNxB0jhuo5KzV/RI6OtD0tgSABF
         Ys/A==
X-Gm-Message-State: AOAM533eQAxnn4Y1ioQ3cLWzkGMyOppZ9h8Pa+TMIdgjiouelPVuNr3L
        JF6SD70iKmbOzDWT/8uatevKyQ==
X-Google-Smtp-Source: ABdhPJxyRsttVKac8oS/Pd9KoKHSh+xsMkH7Er01IU3KQLXF2h+YHf7b4VIqO16SNNmhxdX/VS2yig==
X-Received: by 2002:a17:90b:46cd:: with SMTP id jx13mr5383279pjb.217.1613501652606;
        Tue, 16 Feb 2021 10:54:12 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id g8sm3820005pjj.41.2021.02.16.10.54.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Feb 2021 10:54:11 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <13583117-59D4-4294-BB23-9D4802E4B8A3@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E4D2691F-0BAD-4906-899A-C3AF7AC4FEB5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] vfs: prevent copy_file_range to copy across devices
Date:   Tue, 16 Feb 2021 11:54:07 -0700
In-Reply-To: <CAOQ4uxgucdN8hi=wkcvnFhBoZ=L5=ZDc7-6SwKVHYaRODdcFkg@mail.gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "drinkcat@chromium.org" <drinkcat@chromium.org>,
        "iant@google.com" <iant@google.com>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "llozano@chromium.org" <llozano@chromium.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "miklos@szeredi.hu" <miklos@szeredi.hu>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dchinner@redhat.com" <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "sfrench@samba.org" <sfrench@samba.org>,
        James Simmons <jsimmons@infradead.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
References: <CAOQ4uxiFGjdvX2-zh5o46pn7RZhvbGHH0wpzLPuPOom91FwWeQ@mail.gmail.com>
 <20210215154317.8590-1-lhenriques@suse.de>
 <CAOQ4uxgjcCrzDkj-0ukhvHRgQ-D+A3zU5EAe0A=s1Gw2dnTJSA@mail.gmail.com>
 <73ab4951f48d69f0183548c7a82f7ae37e286d1c.camel@hammerspace.com>
 <CAOQ4uxgPtqG6eTi2AnAV4jTAaNDbeez+Xi2858mz1KLGMFntfg@mail.gmail.com>
 <92d27397479984b95883197d90318ee76995b42e.camel@hammerspace.com>
 <CAOQ4uxjUf15fDjz11pCzT3GkFmw=2ySXR_6XF-Bf-TfUwpj77Q@mail.gmail.com>
 <87r1lgjm7l.fsf@suse.de>
 <CAOQ4uxgucdN8hi=wkcvnFhBoZ=L5=ZDc7-6SwKVHYaRODdcFkg@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_E4D2691F-0BAD-4906-899A-C3AF7AC4FEB5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 16, 2021, at 6:51 AM, Amir Goldstein <amir73il@gmail.com> wrote:
>>=20
>>> This is easy to solve with a flag COPY_FILE_SPLICE (or something) =
that
>>> is internal to kernel users.
>>>=20
>>> FWIW, you may want to look at the loop in ovl_copy_up_data()
>>> for improvements to nfsd_copy_file_range().
>>>=20
>>> We can move the check out to copy_file_range syscall:
>>>=20
>>>        if (flags !=3D 0)
>>>                return -EINVAL;
>>>=20
>>> Leave the fallback from all filesystems and check for the
>>> COPY_FILE_SPLICE flag inside generic_copy_file_range().
>>=20
>> Ok, the diff bellow is just to make sure I understood your =
suggestion.
>>=20
>> The patch will also need to:
>>=20
>> - change nfs and overlayfs calls to vfs_copy_file_range() so that =
they
>>   use the new flag.
>>=20
>> - check flags in generic_copy_file_checks() to make sure only valid =
flags
>>   are used (COPY_FILE_SPLICE at the moment).
>>=20
>> Also, where should this flag be defined?  include/uapi/linux/fs.h?
>>=20
>> Cheers,
>> --
>> Luis
>>=20
>> diff --git a/fs/read_write.c b/fs/read_write.c
>> index 75f764b43418..341d315d2a96 100644
>> --- a/fs/read_write.c
>> +++ b/fs/read_write.c
>> @@ -1383,6 +1383,13 @@ ssize_t generic_copy_file_range(struct file =
*file_in, loff_t pos_in,
>>                                struct file *file_out, loff_t pos_out,
>>                                size_t len, unsigned int flags)
>> {
>> +       if (!(flags & COPY_FILE_SPLICE)) {
>> +               if (!file_out->f_op->copy_file_range)
>> +                       return -EOPNOTSUPP;
>> +               else if (file_out->f_op->copy_file_range !=3D
>> +                        file_in->f_op->copy_file_range)
>> +                       return -EXDEV;
>> +       }
>=20
> That looks strange, because you are duplicating the logic in
> do_copy_file_range(). Maybe better:
>=20
> if (WARN_ON_ONCE(flags & ~COPY_FILE_SPLICE))
>        return -EINVAL;
> if (flags & COPY_FILE_SPLICE)
>       return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
>                                 len > MAX_RW_COUNT ? MAX_RW_COUNT : =
len, 0);
> if (!file_out->f_op->copy_file_range)
>        return -EOPNOTSUPP;
> return -EXDEV;

This shouldn't return -EINVAL to userspace if the flag is not set.

That implies there *is* some valid way for userspace to call this
function, which is AFAICS not possible if COPY_FILE_SPLICE is only
available to in-kernel callers.  Instead, it should continue
to return -EOPNOTSUPP to userspace if copy_file_range() is not valid
for this combination of file descriptors, so that applications will
fall back to the non-CFR implementation.

The WARN_ON_ONCE(ret =3D=3D -EOPNOTSUPP) in vfs_copy_file_range() would
also need to be removed if this will be triggered from userspace.


Cheers, Andreas






--Apple-Mail=_E4D2691F-0BAD-4906-899A-C3AF7AC4FEB5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAsFM8ACgkQcqXauRfM
H+DISQ//Xk8r1HWGp6aO3uH6f50bZtArBkbhRdX1p7E8ijkTPN+2mMwXY8F8Ac0N
K7wowllKCKlCS3puz1g22oidllG07sA84OAzYvj+keWgxmcdr8LiT1+FmVrlwAJW
yl7uwuVty3n0hVX3V1uP6k48l+6kNKHfLgEv0pryuKxsSJwgxK0lU7f/kxw3TBBx
cLl2b126NjEeWasNilay55SGX6XlbecnhTg6sTqH4aSjYJrCOAeSe0owrB9pC1ks
g2TyCDarbyGHgTiO9WqSQqF7rCzZ1DWaI9iivJgM7UCUO5WfYHKfNUWteiMr7i/7
wZF4DYBawPFGYuv1mCbel/PuXN3/HQZ2r2UK3mHazf3jbTAgYEmoG9f4keebeGZb
llGyvrvH9xKAjExhrmJbk/9ztbmwBlWl5QFpmpQRfUZmp92eXhdBJ1/yleXw9syJ
SCy60rPj38mFYGpprUDF0j1nP4JJGKFz2uSAzgOHdh+ggXA8gLXWmHuM6eCFG3/j
2CWcXAhFj4DKWvJxFFlcH1tsNuCjlyxo5I/ITpDDGlFNxUG9ebroVuOP3LWt+7uY
RWKvH6dr2ImHuiN/9s0iL03HHULOvCPYNvfMIrLw1XWcBENBWZVDyWOOxYUu1a5O
KHIHuK4OEiDJcKXchTH4pZ0MhzeTBL7dYXsHp21XzPRZMRA0+Kw=
=ExqG
-----END PGP SIGNATURE-----

--Apple-Mail=_E4D2691F-0BAD-4906-899A-C3AF7AC4FEB5--
