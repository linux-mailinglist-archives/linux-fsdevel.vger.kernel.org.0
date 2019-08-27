Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6689F410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2019 22:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731237AbfH0U13 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Aug 2019 16:27:29 -0400
Received: from mail-pg1-f176.google.com ([209.85.215.176]:45009 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbfH0U13 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Aug 2019 16:27:29 -0400
Received: by mail-pg1-f176.google.com with SMTP id i18so82701pgl.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2019 13:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=TqVwbxKMUNXiv+2Sw/vG/0pgchbearhEw8bUzRJkVZU=;
        b=aU3EuYSDw2WZ2piHuRuaNbWw3AbbCTXqS93Q+YyWa+Ey7C9ZEmlNSo/sSGM7grSfgr
         0AHg60HK3UnDnXyLy3i9itPzcVdv19R1CwTPqEelWNPbiPgoTe8FP0aTLUujuQTnjYh9
         QwH55IIL4XUeX3miWtFqALKBZ9cWjkldrl2RmWC0941DWnCi9ONl2AjxxL5HRqFQZnoN
         bEi5WuziKRLTyH+1QNQj7fh3sw+bKMBjRmmWtjFy8QkYFoKe3QIUrPhxPuMAfzAowfAy
         x83qF6DQmHeak80PvhRuUzh3CL4Fceu/KCybXcL6OUNhIeA9ewypSifhPaf57G2EYbXH
         jVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=TqVwbxKMUNXiv+2Sw/vG/0pgchbearhEw8bUzRJkVZU=;
        b=EC4gaVUy2oY/SFFAKbHHlmOFDIdhtT21PU7RilUfZxj/7vfBJbSpvooniRqvwu+stW
         ZJ5iEVWFoSoluEA9dyMV41citRMgSgICd3g95bK1/d3e73Py8Yq0XPRm+BR0/cX6a+A7
         lVpG/7sLtsce6do28oOVm9an5YkXneaVKPkkuSZ2EMYE4jVycSz3FR/n9YDvQkGweyNM
         Ugz6bunudYIHZZPo58rObZwKzz1I6TsaqfWrI6uLyKW1/eOdhl+085M7XLAew0F6nkCo
         telJaNp58mOqvAokg7E1yQmkNg+qjeR92fPYQuPNs1HIe2iH06O+1JixXU6JPKbZcsU1
         Qy8A==
X-Gm-Message-State: APjAAAXQA+7tKjOX3PM9pARdlXrOTbeJUIja0sQTVjD02paOAmoIKPZW
        gunQ5kcHva7kDO5u8SnWhhyyEQ==
X-Google-Smtp-Source: APXvYqz68CSgzKmd3aAWyfkWzJMqno+lVeiEGeQrheQv9WB8zKVQbx0SCfVNuMCO3qovuhVjGe8wyQ==
X-Received: by 2002:a17:90a:234e:: with SMTP id f72mr540540pje.121.1566937648062;
        Tue, 27 Aug 2019 13:27:28 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 71sm166596pfw.157.2019.08.27.13.27.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 13:27:27 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <5FEB4E1B-B21B-418D-801D-81FF7C6C069F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_031F4A52-617E-48C4-9F94-D54C49A7DE87";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: ext4 fsck vs. kernel recovery policy
Date:   Tue, 27 Aug 2019 14:27:25 -0600
In-Reply-To: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jan Kara <jack@suse.com>,
        Colin King <colin.king@canonical.com>,
        Ryan Harper <ryan.harper@canonical.com>
To:     dann frazier <dann.frazier@canonical.com>
References: <CALdTtnuRqgZ=By1JQ0yJJYczUPxxYCWPkAey4BjBkmj77q7aaA@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_031F4A52-617E-48C4-9F94-D54C49A7DE87
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Aug 27, 2019, at 1:10 PM, dann frazier <dann.frazier@canonical.com> wrote:
> 
> hey,
>  I'm curious if there's a policy about what types of unclean
> shutdowns 'e2fsck -p' can recover, vs. what the kernel will
> automatically recover on mount. We're seeing that unclean shutdowns w/
> data=journal,journal_csum frequently result in invalid checksums that
> causes the kernel to abort recovery, while 'e2fsck -p' resolves the
> issue non-interactively.

The kernel journal recovery will only replay the journal blocks.  It
doesn't do any check and repair of filesystem correctness.  During and
after e2fsck replays the journal blocks it still does basic correctness
checking, and if an error is found it will fall back to a full scan.

> Driver for this question is that some Ubuntu installs set fstab's
> passno=0 for the root fs - which I'm told is based on the assumption
> that both kernel & e2fsck -p have parity when it comes to automatic
> recovery - that's obviously does not appear to be the case - but I
> wanted to confirm whether or not that is by design.

The first thing to figure out is why there are errors with the journal
blocks.  That can cause problems for both the kernel and e2fsck journal
replay.

Using data=journal is not a common option, so it is likely that the
issue relates to this.  IMHO, using data=journal could be helpful for
small file writes and/or sync IO, but there have been discussions lately
about removing this functionality.  If you have some use case that shows
real improvements with data=journal, please let us know.

Cheers, Andreas






--Apple-Mail=_031F4A52-617E-48C4-9F94-D54C49A7DE87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1lki0ACgkQcqXauRfM
H+AvaRAAvqUcuo7xYZyKQX2X10qNZqCO7atjkpd8TvDvJRDdgUF9FcPNEUutTxiV
B/mFiFPSmT98Gj7vOIW/bVrZ9vA8WN0juwsQDpZOztoA8fTe24CPzZnZPWDKiFii
AH1LsdEg7ocMoaFYQ9U+lGQ/CFlbQtDrvbm2lVbQ7ncN5so2UuBJ8ruZNts4tv39
vSjqLfnm9vUp+2+YdbT2rHtaVE/X665gA2UvCqMsw2hrXkXtRzaA7duNXYQ+6F21
++tMjni289g2ahB5owhNHZgjHm2Pxc7WXFZcvpsb0hngc6csMrBiHlH4JosW/qOW
C0+xP6f4fvhRHpxvnOJ5Bu1OGeUGRJuSlMoGiO5W1TLykUQ3YGeIGDO2ScraTlgG
SxzYPdCO2x5qh4jOZHD61UYxr8cGM3bEHoY+xjNyGaeJIwmsAaNtay0QuakE50aD
hkXhIaRoTazVJYO9hb0Ab0L/1OSqZPIE5esSkIYe1GNX97X/lJkGr2WbIchy+O55
pczFktWWmiBsJTWljqr8BEPEaDCYil6/8VWzp0iBiZRg5ZhKH52VgGfsJxELcCk9
Ug/lau1n+ux2zEauwNSaxqnnaLOetPnxK1Q8Xb2T9oJhepTSVgSUNp3QxWgmOb8U
BCT7aS2I8T1KEQ3OiB+Tl9k3XK1myis+OwLW17t3LMSP5NUD4+A=
=Ty3I
-----END PGP SIGNATURE-----

--Apple-Mail=_031F4A52-617E-48C4-9F94-D54C49A7DE87--
