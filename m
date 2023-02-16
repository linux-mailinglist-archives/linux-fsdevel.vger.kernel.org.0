Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B00E698986
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 01:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBPAyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Feb 2023 19:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBPAyo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Feb 2023 19:54:44 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0FE2D149
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 16:54:42 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e12so461267plh.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Feb 2023 16:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fPXE0KmNwvE+NSY+3rCK3ijNO5IxWNGEaQtRsv6Af1A=;
        b=KEYiokYkhzlsXe7RhKwvDkI4HLRe0mRzRU+4JX6sUrWv/aP7HXlpys9fLxgq9zcUkH
         IhuQW/W2yId5YikbZKOHVi2jTuKXHd3NqcdG/eiAWx+FEmZS1rnaI6ovhTmU0RvMTpFO
         sc7MDTKviswxdi2dvQfsAFUDQ+Odb/MaNPtTu74Nv0zDmfQhZpTtJqcv6Li9u8R4iJG/
         x96u9kRhEkQpLaWSjb5z7WY1HDxpCs8fVtG/Ftaqg9z9EDfOmP0UjNJGBt5iozDplBhi
         6OXD9PKD2k3S6npzNu0Jk91WyrhbxTwRalI1vgYUaK+50B0/TnB1cUMXR0sYR5sbGki1
         zQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fPXE0KmNwvE+NSY+3rCK3ijNO5IxWNGEaQtRsv6Af1A=;
        b=SO4YASfTYipiEvXG32G+ogoFfTIWbSFWAolIWao+Yz5U/Hs82zFZwgs1YsnuWgsOke
         aMHYRCiRlisnfaGP7tOFw8SZoGUP+vc54Sy9DYLZTX/D0IHuxfNajAVBViZjHD1hC3Bt
         Dqe7lYOyqwJHhnWWK+ZBXEmHKyxH8vY5Y3RhsoZuwVmDC42mpjsVgybAh6YAw2QZShzQ
         KlL6oyMXJ/KK3dKAHvucXyboV5ZEed52kLI6N4UDA4b6nyWruR8uwtreBG8gDXQ2rJWR
         J8goqUWcnuaGdY+rjOi62dA+zuPyLLQQg3knidBQ7QNYv8GC23lrYCqzSYJ0qOpD2cXz
         URXA==
X-Gm-Message-State: AO0yUKUTYP3dg0JL3ijDgZCZarydfOBNSNh4Ar27XWwCPaGPKFboWFwD
        IAEusDAAZfkWUF2hGJYqPmuBJw==
X-Google-Smtp-Source: AK7set/pJJQ2Ta1komCdzeNg+vGLeEe7dpM/TTugLDR17iheN95e3PLC6/aEUkJ8btvSi3VCl/4L2w==
X-Received: by 2002:a17:902:da8d:b0:199:12d5:5b97 with SMTP id j13-20020a170902da8d00b0019912d55b97mr487427plx.12.1676508881345;
        Wed, 15 Feb 2023 16:54:41 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019a95baaaa6sm7613561plj.222.2023.02.15.16.54.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Feb 2023 16:54:40 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <31364B1B-54B5-4048-B71D-C59F2230C353@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_516A95CE-058F-422F-90C3-10422EFF57A2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Backup/restore of fscrypt files and directories
Date:   Wed, 15 Feb 2023 17:54:15 -0700
In-Reply-To: <Y+asUDeRFGpig+wG@mit.edu>
Cc:     Sebastien Buisson <sbuisson.work@gmail.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
To:     Theodore Ts'o <tytso@mit.edu>
References: <03a87391-1b19-de2d-5c18-581c1d0c47ca@gmail.com>
 <Y+P3wumJK/znOKgl@gmail.com> <0eaf08a8-ddec-5158-ab2b-ae7e3e1bab9b@gmail.com>
 <Y+asUDeRFGpig+wG@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_516A95CE-058F-422F-90C3-10422EFF57A2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 10, 2023, at 1:42 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Fri, Feb 10, 2023 at 02:44:22PM +0100, Sebastien Buisson wrote:
>> As for symlinks, you are right I need to dig further. I think at =
least the
>> security.encdata xattr would need an additional field to hold the =
ciphertext
>> symlink target.
>=20
> So I'd caution you against the concept of using the security.encdata
> xattr.  In propose, it's being used in two different ways.  The first
> way is as a system call / ioctl like way, and that's something which
> is very much frowned upon, at least by many in the Kernel community.
> The red flag here is when you say that the xattr isn't actually stored
> on disk, but rather is created on the fly when the xattr is fetched.
> If you need to fetch information from the kernel that's not stored as
> part of the on-disk format, then use an ioctl or a system call.  Don't
> try to turn the xattr interface into a system call / ioctl extension
> like thing.

I don't think the actual xattr format is critical to the process, it
is a blob saved into the archive from the filesystem and restored later.
That seems like the textbook definition of an extended attribute.

> The other way you're using the encdata is that you're presuming that
> this is how you'd store the information in the tar format.  And how we
> fetch information from the kernel, and how it is stored as an exchange
> format, should be decoupled as much as possible.

I think using an xattr to do backup/restore of the internal encryption
state makes sense, both as the interface for getting these attributes
from the kernel, and for storing them to the archive.  It seems prudent
to make the userspace interface as "generic" as possible, and handling
of fscrypt files should be in the filesystem that cares about it.

Avoiding the need for the encryption keys makes life *much* simpler for
the sysadmin (no need to contact users for backup/restore), and is also
*much* more secure from the data POV (no need to store keys in a central
site or anywhere, and data is never in plaintext even in memory on the
backup machine), as well as a lot faster (no need to both =
decrypt/encrypt
the data for both backup and restore).


In some regards the proposed text-based format is already somewhat
decoupled from how it is stored internally, and allows abstraction
from the internal details.  That seems more for the benefit of ext4 to
be able to (potentially) process older backups in case more/different
information needs to be stored in the xattr.

Storing the real file size in the xattr, but exposing the "encrypted
chunk size" via st_size would allow userspace to read/write the full
encrypted data size without any modification, and then setting the
xattr restores the real file size and fscrypt context to the inode.

tar, rsync, and commercial backup programs are already able to backup =
and
restore xattrs today, so no changes there.  Making as small changes as
possible to userspace to handle fscrypt files (e.g. use =
open(O_CIPHERTEXT)
flag if ENOKEY is returned, and then save/restore of an extra xattr) is
IMHO a lot easier sell than adding in multiple fs-specific ioctl calls,
and then still having to develop some *other* way to save/restore binary
fscrypt context in the archive.

> In the case of a tar archive, the symlink target is normally stored in
> the data block of the tar archive.  In the case where the symlink is
> encrypted, why should that change?  We aren't storing the encrypted
> data in a different location, such as the encdata xattr; why should
> that be different in the case of the symlink target?

Sure, it seems reasonable to save the symlink target as "file data"
rather than as part of the security.encdata xattr if that is "more =
normal"
for how tar handles this.  I haven't looked into the tar code/format to
see how symlinks or hardlinks are handled.

> Now, how you *fetch* the encrypted symlink target might be different,
> such as how we fetch the contents of an unencrypted data file (via the
> read system call) and how we fetch an unencrypted symlink target (via
> the readlink system call) are different.

>=20
>>> A description of the use cases of this feature would also be =
helpful.
>>> Historically, people have said they needed this feature when they =
really didn't.
>>=20
>> There is really a need for backup/restore at the file system level. =
For
>> instance, in case of storage failure, we would want to restore files =
to a
>> newly formatted device, in a finner granularity that cannot be =
achieved with
>> a backup/restore at the device level, or because that would allow =
changing
>> formatting options. Also, it particularly makes sense to have =
per-directory
>> backups, as the block devices are getting larger and larger.
>>=20
>> The ability to backup and restore encrypted files is interesting in =
annother
>> use case: moving files between file systems and systems without the =
need to
>> decrypt then re-encrypt.
>=20
> The use case of being able to restore files without needing to decrypt
> and re-encrypt is quite different from the use case where you want to
> be able to backup the files without needing encryption keys present,
> but the encryption keys *are* needed at restore time is quite =
different
> --- and the latter is quite a bit easier.

It might be easier on the kernel side, but I can't imagine how requiring
the user keys at restore time would simplify the life of a sysadmin =
trying
to recover from failed storage in the middle of the night and having to
contact each user in turn to enter their crypto keys as the backup is
being extracted...

> For example, some of encryption modes which use the inode number as
> part of the IV, could be handled if keys are needed at restore time;
> but it would be quite a bit harder, if not impossible, if you want to
> be able restore the ecrypted files without doing a decrypt/re-encrypt
> pass.

[snip]

>      Special cases are often much simpler and easier, and sometimes
>      the special cases are all you actually want.

The mention of strange encryption modes and general-purpose archive
formats argues for *more* complexity and special cases, but that
contradicts the Linus quote...

I don't think this would need to handle *all* different encryption types
before it is useful to have.  The "inode number is part of IV" seems
fragile/non-portable for a few reasons (e.g. it also breaks resize2fs,
e4defrag, and possibly other tools), so I would say "don't do that if
you want to be able to backup your data".

This seems to target the most common use case where the underlying
backup/restore filesystem are both suitably enhanced ext4 (or maybe
other fscrypt filesystems with equivalent changes).  IMHO that solves
the critical issue of doing automated backup/restore without the key(s).

In theory, the same O_CIPHERTEXT flag could be used by other filesystems
to do backup/restore *to the same target fstype* since the xattr(s) are
not processed in userspace other than to restore them later.  Even the
*presence* of the security.encdata xattr (or multiple xattrs) could be
conditional upon the O_CIPHERTEXT flag at open time.  It would be up to
the underlying filesystem to interpret the xattr contents as needed.

> Can you give more details about why you are interested in implementing
> this?  Does your company have a more specific business justification
> for wanting to invest in this work?  If so, can you say more about it?

I would think an being able to automate backup/restore of a multi-user
filesystem seems reasonable?  fscrypt is well suited to multi-user data
encryption (each directory can have a different master key managed by
the end user), but having a master key is both a single point of failure
(i.e. it could compromise all of the users' data, assuming the security
policy allowed this at all), and having to enter the master key (or
dozens or hundreds of separate user keys) for backup and restore (or
saving it persistently for automation) is problematic to say the least.

> The reason why I ask is because very often fscrypt gets used in
> integrated solutions, where the encryption/decryption engine is done
> in-line between the general purpose CPU and the storage device.

[snip stuff related to Android/ChromeOS fscrypt special case usage]

This relates more to "normal" ext4 filesystems using fscrypt with no
embedded/hardware/ecosystem. I've been thinking about using fscrypt
for my home file server for a while, but not being able to make a backup
of that data seems like a show stopper.

This is good for both personal filesystems that might have an encrypted
subdirectory, or for file servers that use ext4 for multi-user storage.

>> In the case of hard links, I do not know how tar for instance handles =
this
>> for normal files. Do you have any ideas?
>=20
>   "Tar stores hardlinks in the tarball by storing the first file (of
>   a group of hardlinked files); the subsequent hard links to it are
>   indicated by a special record. When untarring, encountering this
>   record causes tar to create a hard link in the destination
>   filesystem." [3]
>=20
> [3] https://forums.whirlpool.net.au/archive/2787890
>=20
> Why are you assuming that tar is the best format to use for storing
> encrypted files?  It's going to require special extensions to the tar
> format, which means it won't necessarily be interoperable across
> different tar implementations.  (For example, the hard link support is
> specific to GNU tar.)

I would think that GNU tar is probably the most common backup tool for
Linux and it already supports all the modern filesystem features =
(xattrs,
symlinks, hardlinks, sparse files, etc.) so it seems like a reasonable
place to start.  Once that is working then adding support to other tools
can be done on an as-needed basis (ideally with minimal changes to those
tools).  Like you quoted Linus earlier, the solution doesn't need to
solve *every* problem, just enough to have a working single-filesystem
backup and restore.

Cheers, Andreas






--Apple-Mail=_516A95CE-058F-422F-90C3-10422EFF57A2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPtfrgACgkQcqXauRfM
H+A89hAAm/2GOXxplbAkfBldEnb9N7LI6NosOmV58g4dpSgVg1uNZSpSdTIg5kUn
lMQLn6wN8NrSP3EUmlAbr3Gbp/FZtNGzP3K4DaPNHMObLUqVu7f9pRUIChGE/8Lz
9M4vTfExWtMnSoFECGMScea6djf+BK/HudqYxQJeHpUIPovprFJ06EOlQ7Ys1LIw
H2v+lFoeRW9xy+qH81qT/WWMmtOt/pUFSHbnIQQGot7Y3QaDciMGeajvsQaJ3hIE
pBFBjE5b0JUbFvD5J2SifFqVt++BUgIoe7zsvOED3YqFXeOFxiUBelKIZVLvtN/u
DgbVeG60tcKtwg+HrL9P87VrhaMGqg/QMCv7+owJ4hRckmj3PlbAYe7Z5YOw/yH+
3npTdRz9PJ0AtpRoByl0Xm43t/Y47HEirM+nT3uC1f4pqgSFEPWDo1pb1GZ+do7/
o+dZWMY7C9IswtiOek4tzaoWGwpWieBi/YZANQmyLTNGboI7LHn2xfgYXDertr4O
cls31xSJlT5D4q4VrFB2K61wYGNSodV0Dkt6SGUQ/IEopLfq0DVY6jGIYjoROHNZ
2M99LzF1o1oshKNI8fEUVnIgQkJFCcAX8QLpFNYmJm4Bx0ZCQ9MUohXn7a+Ol0gp
ZDT5iwN4JVfRXAz594sylHVWOLSyNopB97LHLaVdJzLdGUzN5s0=
=qIIE
-----END PGP SIGNATURE-----

--Apple-Mail=_516A95CE-058F-422F-90C3-10422EFF57A2--
