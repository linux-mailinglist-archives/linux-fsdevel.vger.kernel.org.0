Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A890311350A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 19:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbfLDScB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 13:32:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38192 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbfLDScA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:32:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id o8so77882pls.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 10:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=xKr4sE6dEN+r+0kQ3EZBQMimlSGfH5cfmp2nYCABRlc=;
        b=E0M3GOomCYtZmEJ82tRl5Js7fdBtuFlFdMq/KX+ceyYzlpr6jRnd7tROzghqefxgAJ
         D7BR5Mu+zflyGgem81vPw6TCr5uW2AKuHficePOa6RpGdhy+H8H3wpJ+EurUQGZDDDUY
         M4UOjtS65FFdZRjnVxZ/vg+bVNn+UI+TM2oTnzmHBnTo44nt47L5HuTqUYnEjlETFoku
         YILAbKqYY3eFmj49YvpSxJMT5GY6Ac7hx+FcABepR3ubunnDp1EVdgK95O6NeGGauAS2
         KHGHzNTxNdnRf8pc+oI+2uu2iBcBgN9CifY6qa7xw2KK/SS8U/C5BjXRxVDn28/o9ek8
         4mEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=xKr4sE6dEN+r+0kQ3EZBQMimlSGfH5cfmp2nYCABRlc=;
        b=irKpYtOn2/tBNaEMblq+zFjlhORxb7TGmwG0HHyzC4O7++ZxXHgv+MyYdpYOwko5MJ
         GNW1vAlRxCYeY4cvl4Nw5qW8jn2BwJek7Sz2RuufGUKFwn1CGw0xYv0F2fFZamx9NNdW
         m7ib0AOfcWGLtNk0xK3HtWVht2pu20D51iKRPWdLaOKZVSfI2ANwmU0JyUhn3uSxYogh
         CtySCewHW+wH83+6GbohCS7weVgOPd+r2/EW6B7WfZlBPyXLpOyi8Y4X/e/aIGw2cM3n
         KhXyEcSL8IE/IH1IPSNxmXGP+eVf2EioTxgfYcJ72I6RbEAQDGB3z2oNYZxFGjamY2CQ
         oGsw==
X-Gm-Message-State: APjAAAXn//xoqY06e4mkrC+kT4f5Wi+KENoFW9C6Km8uJnSM1Wn4PMCD
        NOU7J6JS3rno2GDo+QVx/behug==
X-Google-Smtp-Source: APXvYqxSKfBQOnG76aGXKyB6X52I6K4bMHdueAby/SHJUCxV9Al6Z2HVRDrHLKVsVYHWZzazlhHCTQ==
X-Received: by 2002:a17:90a:f005:: with SMTP id bt5mr4788603pjb.16.1575484319602;
        Wed, 04 Dec 2019 10:31:59 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id u24sm8641357pfh.48.2019.12.04.10.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:31:57 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <23F33101-065E-445A-AE5C-D05E35E2B78B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_444EEA50-3065-49C0-A153-021AF493BF2F";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Date:   Wed, 4 Dec 2019 11:31:50 -0700
In-Reply-To: <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Daniel Phillips <daniel@phunq.net>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <c3636a43-6ae9-25d4-9483-34770b6929d0@phunq.net>
 <20191128022817.GE22921@mit.edu>
 <3b5f28e5-2b88-47bb-1b32-5c2fed989f0b@phunq.net>
 <20191130175046.GA6655@mit.edu>
 <76ddbdba-55ba-3426-2e29-0fa17db9b6d8@phunq.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_444EEA50-3065-49C0-A153-021AF493BF2F
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 1, 2019, at 1:21 AM, Daniel Phillips <daniel@phunq.net> wrote:
>>> Important example: how is atomic directory commit going to work for
>>> Ext4?
>>=20
>> The same way all metadata updates work in ext4.  Which is to say, you
>> need to declare the maximum number of 4k metadata blocks that an
>> operation might need to change when calling ext4_journal_start() to
>> create a handle; and before modifying a 4k block, you need to call
>> ext4_journal_get_write_access(), passing in the handle and the =
block's
>> buffer_head.  After modifying the block, you must call
>> ext4_handle_dirty_metadata() on the buffer_head.  And when you are
>> doing with the changes in an atomic metadata operation, you call
>> ext4_journal_stop() on the handle.
>>=20
>> This hasn't changed since the days of ext3 and htree.
>=20
> OK good. And I presume that directory updates are prevented until
> the journal transaction is at least fully written to buffers. Maybe
> delayed until the journal transaction is actually committed?
>=20
> In Tux3 we don't block directory updates during backend commit, and I
> just assumed that Ext4 and others also do that now, so thanks for the
> correction. As far I can see, there will be no new issue with =
Shardmap,
> as you say. My current plan is that user space mmap will become kmap =
in
> kernel. I am starting on this part for Tux3 right now. My goal is to
> refine the current Shardmap data access api to hide the fact that mmap
> is used in user space but kmap in kernel. Again, I wish we actually =
had
> mmap in kernel and maybe we should consider properly supporting it in
> the future, perhaps by improving kmalloc.
>=20
> One thing we do a bit differently frou our traditional fs is, in the
> common, unfragmented case, mass inserts go into the same block until
> the block is full. So we get a significant speedup by avoiding a page
> cache lookup and kmap per insert. Borrowing a bit of mechanism from
> the persistent memory version of Shardmap, we create the new entries
> in a separate cache page. Then, on commit, copy this "front buffer" to
> the page cache. I think that will translate pretty well to Ext4 also.

One important use case that we have for Lustre that is not yet in the
upstream ext4[*] is the ability to do parallel directory operations.
This means we can create, lookup, and/or unlink entries in the same
directory concurrently, to increase parallelism for large directories.

This is implemented by progressively locking the htree root and index
blocks (typically read-only), then leaf blocks (read-only for lookup,
read-write for insert/delete).  This provides improved parallelism
as the directory grows in size.

Will there be some similar ability in Shardmap to have parallel ops?
Also, does Shardmap have the ability to shrink as entries are removed?

Cheers, Andreas

[*] we've tried to submit the pdirops patch a couple of times, but the
main blocker is that the VFS has a single directory mutex and couldn't
use the added functionality without significant VFS changes.
Patch at =
https://git.whamcloud.com/?p=3Dfs/lustre-release.git;f=3Dldiskfs/kernel_pa=
tches/patches/rhel8/ext4-pdirop.patch;hb=3DHEAD


--Apple-Mail=_444EEA50-3065-49C0-A153-021AF493BF2F
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3n+5cACgkQcqXauRfM
H+A/DQ//WqdN82NF1pjjP1M2v8Zb0W4X2lctDcL9xqIXRh1wzu1EpiKzTn754OWs
Wi7KfHBxSwa6yh9qfx2/DrzuGy38ion7gncucx+CdN0r2ykvM52kp1mMN+LC4Mtm
pmIPMui+hDkYRi6RnUVa4l/MNOVBiuXLjAu+NhwHZvzPJTvHvogoRRoMOZx+Ll+i
Y1Lpo7AGIhCNo8ois1uaiU0JkjU8JwTkX7RcKHOlWChD6esBWXJPhZ/s4R8NS1Yo
89B7sUgs9OA6JaKz2S9lRAQtLbUiLN3YfZa9ELtAH0SXI+iWZRbXnUE8ly8+tcN2
b/vjd+HwqAYHus1kCmMR1Te4I/059d3YjBKZtqah8CAWiU3SjqQwLApi/VJbWA0D
RGjH2pwlUOZIZStzsA9t2UEFWWqoWGs52W3rdJWJNftVErWhrzN2S/WCZHO5EWLA
QbuHbfa1TrKZPTv61kPRnwMQ1YNHNxsXg341SlUnGBu1JduT1JXk+ZebGhiESG1n
SSrpLgEATk05xqNDXIhN9gala9FVf1J6DQp3tC7Wa5JmpyKz6Lt+VHuywOiIqFR4
nItNg/LENhVjpJc69fA4SQnvHPu8Bh2EZYQKQ+/JLrBN+CtCFt5uFWgc2h+twO3d
hwsbgUULa2NL0MnjLu91zFkityCyBfpEz5HIKRzMn3XWUJqA4Hk=
=Wb6G
-----END PGP SIGNATURE-----

--Apple-Mail=_444EEA50-3065-49C0-A153-021AF493BF2F--
