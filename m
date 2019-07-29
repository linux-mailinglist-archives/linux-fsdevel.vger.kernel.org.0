Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57407933C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 20:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbfG2Sku (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 14:40:50 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37144 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388194AbfG2Sku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:40:50 -0400
Received: by mail-pf1-f195.google.com with SMTP id 19so28463147pfa.4
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jul 2019 11:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=c9/8Rh/PmNBtDsfSlxlvjUW0TMBITRO0xXOaucnIy5U=;
        b=PeN3CR/RrBeup8lLCBs5nka7WEvkCupyNAq3N8jkyLq/xAzLtJEHAp56OY0y5NVThD
         g8NHwDxK43zbbZ2jQiPCAH0TENtoqQeBWG3xf0TI8ngZ/x4q4rPfDBDlubAxlz530z0g
         DhUk1LjmjvbEDvqwpQiM1tr4T+IJHh+1PeBNWE5CGaWJTkT8lCYmiBYN2XHI53CruEWi
         dXJYK2U45WlrwTbBEMP+SC0Kt94vP8vclG7HEMO4m2atI0Uv6iwv5M882dUpE7A1tWeX
         X1RPCT57K1v9QLZBTB6kcfAT/b1NphSHID1IpaJJMf5PG48NU3jG5sGcTM9Q4wSHbINq
         E0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=c9/8Rh/PmNBtDsfSlxlvjUW0TMBITRO0xXOaucnIy5U=;
        b=UPeXNW/aGIaa3sWDxiF+s90OHvvrXjutvWkdU+Ez15dTF+S7Gmh5UMYOz8Rs0Jmcrr
         SNRk7cdwMi8Et+4bhMnJHdvE9SEa4mIqdmJxLOx7L/WJimMZo7Fq62sv2j1weo8258oX
         XOGfhFpLBa3rBOYnvJTy3hkx1fHj1UC9Z3DspLDTfD4Q1/TYpHjOunCFx+WWx0O/iQ0L
         Cu1WxzqcH6LYrWXeofLzwkUTyNKcjICpg0jEcJ4SWq/szWnrl+l7qEvcADxc/pFRXNSb
         1oHpx/FNjvjFU+q/Uo1ozYwmY5Nwe/Xp5mDb79TLcz6upnBXpAHr4l4ACQFAo3xwXuFU
         LjuA==
X-Gm-Message-State: APjAAAUfZa/4Eg4bNFkoTpKdX/iJdK7LaY27TwbhsfF9wMl9b3/etrIf
        JCboHD9z2Qh9VfZmROZKHwk=
X-Google-Smtp-Source: APXvYqxzI7UBorBe7dvBc479FfdDUU3sYfR2Td6Y2nUJ+ymPSy/TnW+y++V3ZtwnGFQIRRQesqjyxA==
X-Received: by 2002:a17:90a:9a95:: with SMTP id e21mr12916257pjp.98.1564425649638;
        Mon, 29 Jul 2019 11:40:49 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id h16sm67151345pfo.34.2019.07.29.11.40.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 11:40:48 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <3D2360FA-AD48-48AE-B1CE-D1CF58C1B8AB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D99D7753-DBA9-49E5-A7C2-D04048D1DD65";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Date:   Mon, 29 Jul 2019 12:40:44 -0600
In-Reply-To: <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area> <20190726225508.GA13729@mit.edu>
 <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_D99D7753-DBA9-49E5-A7C2-D04048D1DD65
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jul 26, 2019, at 8:59 PM, Damien Le Moal <damien.lemoal@wdc.com> =
wrote:
>=20
> On 2019/07/27 7:55, Theodore Y. Ts'o wrote:
>> On Sat, Jul 27, 2019 at 08:44:23AM +1000, Dave Chinner wrote:
>>>>=20
>>>> This looks like something that could hit every file systems, so
>>>> shouldn't we fix this in common code?  We could also look into
>>>> just using memalloc_nofs_save for the page cache allocation path
>>>> instead of the per-mapping gfp_mask.
>>>=20
>>> I think it has to be the entire IO path - any allocation from the
>>> underlying filesystem could recurse into the top level filesystem
>>> and then deadlock if the memory reclaim submits IO or blocks on
>>> IO completion from the upper filesystem. That's a bloody big hammer
>>> for something that is only necessary when there are stacked
>>> filesystems like this....
>>=20
>> Yeah.... that's why using memalloc_nofs_save() probably makes the =
most
>> sense, and dm_zoned should use that before it calls into ext4.
>=20
> Unfortunately, with this particular setup, that will not solve the =
problem.
> dm-zoned submit BIOs to its backend drive in response to XFS activity. =
The
> requests for these BIOs are passed along to the kernel tcmu HBA and =
end up in
> that HBA command ring. The commands themselves are read from the ring =
and
> executed by the tcmu-runner user process which executes them doing
> pread()/pwrite() to the ext4 file. The tcmu-runner process being a =
different
> context than the dm-zoned worker thread issuing the BIO,
> memalloc_nofs_save/restore() calls in dm-zoned will have no effect.

One way to handle this is to pass on PF_MEMALLOC/memalloc_nofs_save =
state
in the BIO so that the worker thread will also get the correct behaviour
when it is processing this IO submission.

> We tried a simpler setup using loopback mount (XFS used directly in an =
ext4
> file) and running the same workload. We failed to recreate a similar =
deadlock in
> this case, but I am strongly suspecting that it can happen too. It is =
simply
> much harder to hit because the IO path from XFS to ext4 is all =
in-kernel and
> asynchronous, whereas tcmu-runner ZBC handler is a synchronous QD=3D1 =
path for IOs
> which makes it relatively easy to get inter-dependent writes or =
read+write
> queued back-to-back and create the deadlock.
>=20
> So back to Dave's point, we may be needing the big-hammer solution in =
the case
> of stacked file systems, while a non-stack setups do not necessarily =
need it
> (that is for the FS to decide). But I do not see how to implement this =
big
> hammer conditionally. How can a file system tell if it is at the top =
of the
> stack (big hammer not needed) or lower than the top level (big hammer =
needed) ?
>=20
> One simple hack would be an fcntl() or mount option to tell the FS to =
use
> GFP_NOFS unconditionally, but avoiding the bug would mean making sure =
that the
> applications or system setup is correct. So not so safe.

Cheers, Andreas






--Apple-Mail=_D99D7753-DBA9-49E5-A7C2-D04048D1DD65
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl0/PawACgkQcqXauRfM
H+B1KA//WBsbz6WuzLRUPgCl0u9LuehEbAVHADxQwJMap50KpEmWoLkqvGDyrvdi
GhPRIq/RIYDZ6nPyy1w5I7EZBunEh4d/T5VdCEMgkcphxElvgjD2SJABQ5hRwonu
C7lHXTW2sgjWRzbDS3xuM7AyqvYcsWgwtRIW+zdCSdV/nYjW40cZb33XxsEoi9iQ
MQlE0iAjXIuDd7o3cU/XhxdpGVIJRqtrwchjZX4ThEkjzpo/mqh4oh1H9li8iWPy
wYhbgMuCkZSOtDvthw3zhtjZ79/eQZ2FPiM67imBSxBDVbCkQtkUja2K3SG6Phnq
rwuTIwytd4NaVssP5JU+3Opxym6ngGkEPSqQob75MssgcktQFyEhrzffMNl47Gxa
eB+kfJ1rjQjNow+wTGbmkBm+HoB/T3ArL9il7XfrsR8l0KL0YJ5Kruen2LUPlSIG
JR8tfziVfOhxP5bQyguOjtvXES9WbiCB+So86ed56YjBCsZf/+wmGaTxSYeTnXQQ
i68JJLEYRnyMRl7PeQL3V303w1Yp3PSXHXUHDZ70FYS6SJ1Kv2NSJt2kn0lkMe0w
Vw2KzWCehPM2qTC0WyQHdScds48QEUs6XVX9oTcV/1TH0ynUj9fneEWA3TybxYNR
YUvWQL8gTeyfmxHabewi0lrxwFQ6zvcXbZ1Vp3sjkqcK4ZmuFwo=
=PPZf
-----END PGP SIGNATURE-----

--Apple-Mail=_D99D7753-DBA9-49E5-A7C2-D04048D1DD65--
