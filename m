Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86D42C4F2D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 08:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388329AbgKZHMb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 02:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388325AbgKZHMb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 02:12:31 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50366C0617A7
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 23:12:30 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id j19so955984pgg.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Nov 2020 23:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:mime-version:subject:message-id:date:cc:to;
        bh=KLAUlAgivmC6G1ULXN0tUHyasPVivqaVUD9plYEEGJA=;
        b=0cm7kC4vJO0YyH7Tm7uzlNrmtxLFV6/4Czpt8Fyq80HuCfMJb7EbtlldyZSlL5JMEc
         n5po5LPqSsjB5bfyYqGWpC1VXIJ3ow2Y3Bsnf0cQ1pGwdBRqaydzH3GbAYB09XV/TF2g
         xyrJmheTxkoFg/pyoiGKmjuSvD9ucuZEO0ll7f6LGTsT5mH1zlFHSXo+7RXZcur5vhee
         IwgIV6nZIBr1Kopgm0lYY1MG2dDI4C0Zibp0cs9bxqsXu4Z+j76JiZaQQyjQ6gGvepSP
         eUdxIEXYby/0wy+OPPQWQ6JHIzIZoOAgQvpGF6PYNBGdH9z/8azaVXchzNdsNZJmfD8/
         VGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:message-id:date:cc:to;
        bh=KLAUlAgivmC6G1ULXN0tUHyasPVivqaVUD9plYEEGJA=;
        b=Wjw3apSc0x2HkRhEBIZ2zeNQyRfDrlRXnvqNo8bOpKLoM9sGR57nvnoUz9MRRwsVlH
         rW8ZgS2Sy7lRc+kCQ5LkpY9VeB/4yQYM9R4kaE8pxXzlME4j9lN2Q8Rkz+LTv3AtXRei
         Xsb/BEG7j9NvC7ybeCfwfmXpNfL8WntIxH83w7EmVTRdXJR8VmXHAxfcUJecfbV1CoFx
         cfuaSh1WTvEj2FSwqFeq4DSXqDtQVhk3qImNyxQ/+6k8MEHydwgS2znLLf/AfczVhB/g
         Xp84lwDKnNTMcaOlFyQQ5Bk3sUHdbvdoep73vO2RyawfSXIGCO+yA2Mvk4A8aRxMxMca
         3g9w==
X-Gm-Message-State: AOAM531b3x8WDV5YD95B2UVy/0engIWByqoy0p4w6RUzrucbOcr69/B2
        hiPWWA0z9vNA9/STtpCQeP+mVQ==
X-Google-Smtp-Source: ABdhPJzFqThqyGJEY9MPOFuq1BNsBSrtfdW2W5JvjwZprT2j7jVPKsrQF+7B7frm3ea432fpe9G0HQ==
X-Received: by 2002:a17:90a:578f:: with SMTP id g15mr1350163pji.3.1606374749264;
        Wed, 25 Nov 2020 23:12:29 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id b80sm3767904pfb.40.2020.11.25.23.12.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Nov 2020 23:12:28 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_09D24D27-AFDD-4A32-9FC0-2980A2FDE36E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: backup/restore of fscrypt files
Message-Id: <D1AD7D55-94D6-4C19-96B4-BAD0FD33CF49@dilger.ca>
Date:   Thu, 26 Nov 2020 00:12:26 -0700
Cc:     linux-fscrypt@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Sebastien Buisson <sbuisson@ddn.com>
To:     Eric Biggers <ebiggers@kernel.org>, Theodore Ts'o <tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_09D24D27-AFDD-4A32-9FC0-2980A2FDE36E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Currently it is not possible to do backup/restore of fscrypted files =
without the
encryption key for a number of reasons.  However, it is desirable to be =
able to
backup/restore filesystems with encrypted files for numerous reasons.

My understanding is that there are two significant obstacles for this to =
work:
- the file size reported to userspace for an encrypted file is the =
"real" file size,
  but there is data stored beyond "i_size" that is required for =
decrypting the file
- the per-inode 16-byte nonce that would need to be backed up and =
restored for
  later decryption to be possible

I'm wondering if it makes sense for stat() to report the size rounded up =
to the end
of the encryption block for encrypted files, and then report the "real" =
size and
nonce in virtual xattrs (e.g. "trusted.fscrypt_size" and =
"trusted.fscrypt_nonce")
so that encrypted files can be backed up and restored using normal =
utilities like
tar and rsync if the xattrs are also copied.

A (small) added benefit of rounding the size of encrypted files up to =
the end of the
encryption block is that it makes fingerprinting of files by their size =
a bit harder.
Changing the size returned by stat() is not (IMHO) problematic, since it =
is not
currently possible to directly read encrypted files without the key =
anyway.


The use of "trusted" xattrs would limit the backup/restore of encrypted =
files to
privileged users.  We could use "user" xattrs to allow backup by =
non-root users, but
that would re-expose the real file size to userspace (not worse than =
today), and
would corrupt the file if the size or nonce xattrs were modified by the =
user.

It isn't clear whether there is a huge benefit of users to be able to =
backup/restore
their own files while encrypted.  For single-user systems, the user will =
have root
access anyway, while administrators of multi-user systems need =
privileged access for
shared filesystems backup/restore anyway.

I'm probably missing some issues here, but hopefully this isn't an =
intractable problem.

Cheers, Andreas






--Apple-Mail=_09D24D27-AFDD-4A32-9FC0-2980A2FDE36E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+/VVoACgkQcqXauRfM
H+D+0xAAgZACUffyWgI92gwzdcYsOgbfZZt5RzrCimEFRGoEVTc67Do8LlkC3RIG
P3kR/93yCGw+elltSznDndSCCSFqqXcATLC81MuILVdnyrGKio7WA4nALStg0gC5
w3Guxb5LTRDhLFqDMRpfnQiOrkmekvdRLW1DZWDn71pbiXwGyMW3kuySl6R29YXA
HMRomIdq9Q7bdYUmL0xg7HrCFb4QN701AriXHZ5yv+RXWLZ0WNxVAS7z74MtBzGf
EKT4PBGjT8w1DXvfeJD7pkcQHDjirrQdHsSHWV9gYFbV+RznmD+Do/5D1ljnptYH
QYlcjqx5dKSI0WBwrPDnmLXSe3xH5FxpheKFFMZvL2VpT3h1PPrEQbL3EoCuwADd
Xd7BOhHbDNPwX5I+VM0L9cC7vUrIPJzdu9rtnAi0IpyfCv04TFJWqoZuRXvxmuAM
IQCC8M0o/acHMoh3hqMcWF0/iot7/oMoAvYu6eG9iKCO9nmLit6U3eVo8HGMacdd
X3xGNH4LiH7Fjydp2VUHFmG9vnpHpoK4shvFC0TkLfHXfT4hqfI5N19alzEV5Wm7
WSwlzewROM7Hdf5NYH9JL64yDuw6ecz+qisuZTX9gToQYvxIjb4MsKm7wH8DCtrh
lcOnRc3fo0qv4OPbZQpzIY638fKWDHG/r4hRN1beAjz48u3i87g=
=BaeX
-----END PGP SIGNATURE-----

--Apple-Mail=_09D24D27-AFDD-4A32-9FC0-2980A2FDE36E--
