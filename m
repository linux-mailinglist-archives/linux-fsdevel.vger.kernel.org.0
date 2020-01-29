Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3335614D175
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 20:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgA2Txe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 14:53:34 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45188 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgA2Txe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 14:53:34 -0500
Received: by mail-pg1-f194.google.com with SMTP id b9so319426pgk.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jan 2020 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=O1J0Skt7EGzo7DImuZD5iQuaAKj6lr5i+y+YnafPYZ0=;
        b=k8pZpK4F0A7B3N6h1/ZkDVW0I89LsuFvJImxWb5w69Q5IPrIXlwiExFj+bq8vujnhw
         3k47A+Jml62AqTvAAxkNXAXXGiRVnfCq9jSnRp7bqHNLSnJQ6r2b7MlWNIDE6nYQYig8
         hKjf4x+jVAkvjsDhZpBdNh4HNJSH9k4gmV+sY4AtqaSqEs2NweamdDCTzE+C/q9qvZAW
         qevfgTHw+BxoGBILDjt95iA8fu9Vm7vvFljongRdEASSjTqaYr3QR5sDmp4Xc0rUHaS0
         uR2oJWhRMrGBamwsj63kr8rXQoATKcxT22iSBtyVO43PyF7RBIX8R4pWW+fO6RDV5UdN
         trFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=O1J0Skt7EGzo7DImuZD5iQuaAKj6lr5i+y+YnafPYZ0=;
        b=U+HNd2sT5D4H4ur9x2PHse8wsRvYWf296ytbrWtA1S/MBdlKWSGT+yURJ+1qMBXK0+
         40fGkp0WwEknoF+PLrf3fyF4pK1dP3ZPkVLUeuE+gCQ1Nesp4+xIvyLOxt/5GY7cMToW
         Un+XjFT2g15Kwp8jCaAl2jnU09XlIwcVcY5oRQUObLRKV2Zsjn2GcAhrJtJKWg0dLvUW
         ov8XAP1iO7d8fQDbG8llr4STfc7mn/nKgQSmwOw8exuQXa2m1RbSv8Est30vG2y7vlQF
         P/7gmEDywMRyATVi6g7tk1EJptUQuivpjU/CKsXomJvNHpFrqNcWkMiA5aDSK4746z5c
         j7Iw==
X-Gm-Message-State: APjAAAUScjXKVMjM10jftBomKpKlguOap1++l2wx4OUI9oq4hgYDKxli
        fSCeZI35beJeKQMky9rxGBzQGw==
X-Google-Smtp-Source: APXvYqxepjSpKWpk0VO8hZOPjHrO0qSgKnELVasdyMAJW8AWB3zKkcsURzWwG6CRQ6gHqlOJbMcyPQ==
X-Received: by 2002:aa7:9191:: with SMTP id x17mr1304639pfa.38.1580327613276;
        Wed, 29 Jan 2020 11:53:33 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id y75sm3734450pfb.116.2020.01.29.11.53.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:53:32 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E53F868C-2454-4254-B7F1-52E7D887B996@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_90FCEBAF-35BA-4C05-858C-7FBF4BB27827";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH RFC] ext4: skip concurrent inode updates in lazytime
 optimization
Date:   Wed, 29 Jan 2020 12:53:29 -0700
In-Reply-To: <158031264567.6836.126132376018905207.stgit@buzz>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
References: <158031264567.6836.126132376018905207.stgit@buzz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_90FCEBAF-35BA-4C05-858C-7FBF4BB27827
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jan 29, 2020, at 8:44 AM, Konstantin Khlebnikov =
<khlebnikov@yandex-team.ru> wrote:
>=20
> Function ext4_update_other_inodes_time() implements optimization which
> opportunistically updates times for inodes within same inode table =
block.
>=20
> For now	concurrent inode lookup by number does not scale well =
because
> inode hash table is protected with single spinlock. It could become =
very
> hot at concurrent writes to fast nvme when inode cache has enough =
inodes.
>=20
> Probably someday inode hash will become searchable under RCU.
> (see linked patchset by David Howells)
>=20
> Let's skip concurrent updates instead of wasting cpu time at spinlock.

Do you have any benchmark numbers to confirm that this is an =
improvement?
The performance results should be included here in the commit message, =
so
that the patch reviewers can make a useful decision about the patch, and
in the future if this patch is shown to be a regression for some other
workload we can see what workload(s) it originally improved performance =
on.

Cheers, Andreas

>=20
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Link: =
https://lore.kernel.org/lkml/155620449631.4720.8762546550728087460.stgit@w=
arthog.procyon.org.uk/
> ---
> fs/ext4/inode.c |    7 +++++++
> 1 file changed, 7 insertions(+)
>=20
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 629a25d999f0..dc3e1b38e3ed 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4849,11 +4849,16 @@ static int other_inode_match(struct inode * =
inode, unsigned long ino,
> static void ext4_update_other_inodes_time(struct super_block *sb,
> 					  unsigned long orig_ino, char =
*buf)
> {
> +	static DEFINE_SPINLOCK(lock);
> 	struct other_inode oi;
> 	unsigned long ino;
> 	int i, inodes_per_block =3D EXT4_SB(sb)->s_inodes_per_block;
> 	int inode_size =3D EXT4_INODE_SIZE(sb);
>=20
> +	/* Don't bother inode_hash_lock with concurrent updates. */
> +	if (!spin_trylock(&lock))
> +		return;
> +
> 	oi.orig_ino =3D orig_ino;
> 	/*
> 	 * Calculate the first inode in the inode table block.  Inode
> @@ -4867,6 +4872,8 @@ static void ext4_update_other_inodes_time(struct =
super_block *sb,
> 		oi.raw_inode =3D (struct ext4_inode *) buf;
> 		(void) find_inode_nowait(sb, ino, other_inode_match, =
&oi);
> 	}
> +
> +	spin_unlock(&lock);
> }
>=20
> /*
>=20


Cheers, Andreas






--Apple-Mail=_90FCEBAF-35BA-4C05-858C-7FBF4BB27827
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4x4rkACgkQcqXauRfM
H+AI4xAAtCNCAc8g1SRvfOYA1NkrVzL/spg4AtLaZsJnAoovtkEpFiRbjEKtjd3x
KHLtA7/pkHudciIn3sAedWE+4qeONez4DxtfN7Y/zJRleOqWFONSiQ5ogjLqauAH
4Bb2YNz3EGvDCgVJaunWvzDFRvztq+LhFWZiWzDaXsc4AczEjXKldFcYKn8/xU9k
AOUfxxs+CsV06zXUI+dHSE25m5Rp2qMlvZtbLqtoFW2AoRrpRmiZp0hNnoIM+hYn
HWJT3VQhcvZZSLjAxIcFBSDNCxtZSYTdQETCbPe1CUY1IpRdQ8SW03kFO/t1aeGO
34ji63Raw3N1ICn/J00QsVFbny9cFXPk9K5XAbAnVv7qGdMqSRiMQtlbGtrsRqLW
WuSpcMLxCt6z1zH4rq0lvsubvXInvB3lgoa+//bqTHonFGnEpV7GfQo1uRF93EZ3
+tbj2IIF5CKaqtHu3964FuHCiiIQWwJ9QL1oP67QP4a9DH9gyLg9WGcHmZ5Cwl6U
NH5IrcPglS1Mpe2Ylr3mo0ZqQTUx/QTWAkcmFeM0XR1XA+HZJ6aZtQlHspOWbWXy
x9wDXTYXG+1ArZ8msxj8CYqakuurk7ZfJXJICasu5FjE2VUTzstCRc9j68Nec+3a
nJdwIykLPgAB1MUzVnLMo5l/6mKqmgfjG/1QCeImG4r30waJ+H4=
=mSDd
-----END PGP SIGNATURE-----

--Apple-Mail=_90FCEBAF-35BA-4C05-858C-7FBF4BB27827--
