Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF832761E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 22:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgIWUU0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 16:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIWUU0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:20:26 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FCC0613CE
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 13:20:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id p16so388506pgi.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2020 13:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=cawNlI0OBKtIQ0KdzyyghVREjOInrlMEeEFMJYyPyMg=;
        b=WLToDqeokMU8rHOcjDVIpn8qIBFpHj0WiImyPBd5KoIa4udZG0jJ9bubIlOm+1odmB
         mEPgsbuhhpYir8HOnTKP/W3P3CArR7bsHwi2Y5Gm2hXl3B+BKe/B8ZM6JXtivu1M5+Pn
         CrHXRsVZMWfO9bSe3hgKXLg+Kf2fzybeVRskoMw+kSVM1OuWyJeCpYB+JTgkVu7FNpFl
         ck2JftyCObDKJhyQtCO0vQeahI52S8OYOw7/fSVc4rGKw/K23btt//SuaDiLd/Zpcd1S
         33Eukv4sUgkCVL6mHUd1ro96wkoWaSsVQDj1htPUENdZqZEYYQXDw97uUNCp8gcxMo/F
         qqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=cawNlI0OBKtIQ0KdzyyghVREjOInrlMEeEFMJYyPyMg=;
        b=ZMfhUBOuHv9ojXjjokZo6XPH9l8BXVaEnRm6pNDu9ciMVncB75fiIw3XDKX2xfsKDo
         YPP1A5xsiHHs0xYNNcZ8psQUvlnml0764T/mcO8EnWtRtdcRgdkTkDR8dpNTDD/nTHIk
         IFW4Sz/iQ0hERetEBgor+5nTWpTUt3AsnoHs7jd1DprriPWvvOqwKEg0hTkDSAS5eJwI
         jHlgeYtZkZ0LwH+gnjMJ+zypLAy0j2sKBTnoFVRIPQ2+PjjP99PgtZLVUBB7/uGGcsKg
         lO6xKvaSjSNY2wlUdwFp5yeqB+ivlehO8hq9pcHjs4acdVNrNCbhLZEEouWz/cqYTjSw
         kAVw==
X-Gm-Message-State: AOAM532gGj7gWhQFcQCkfXdmrvczFYYSruZPOcVrlIn0QUJgzj8V1ylO
        LQAUEkIfv95GdOnrlV2tlaX0DQ==
X-Google-Smtp-Source: ABdhPJxhvBq+Eo73Q/WISSDItZKa5jnqbgsZcIA8jcX3dQgRtd4KJvMrdxxqaXij5SwfwG+sN1fHSA==
X-Received: by 2002:a63:ea16:: with SMTP id c22mr1193908pgi.326.1600892425538;
        Wed, 23 Sep 2020 13:20:25 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c68sm499860pfc.31.2020.09.23.13.20.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 13:20:21 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6405814C-6899-43EC-B40D-8F4DE382AAFF@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9E222F09-4434-47E0-96BE-6160413F5B87";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: A bug in ext4 with big directories (was: NVFS XFS metadata)
Date:   Wed, 23 Sep 2020 14:20:17 -0600
In-Reply-To: <20200923094457.GB6719@quack2.suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
To:     Jan Kara <jack@suse.cz>
References: <alpine.LRH.2.02.2009160649560.20720@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gW6AvR+RaShHdQzOaEPv9nrq5myXDmywuoCTYDZxk-hw@mail.gmail.com>
 <alpine.LRH.2.02.2009161254400.745@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gD0ZFkfajKTDnJhEEjf+5Av-GH+cHRFoyhzGe8bNEgAA@mail.gmail.com>
 <alpine.LRH.2.02.2009161359540.20710@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2009191336380.3478@file01.intranet.prod.int.rdu2.redhat.com>
 <20200922050314.GB12096@dread.disaster.area>
 <alpine.LRH.2.02.2009220815420.16480@file01.intranet.prod.int.rdu2.redhat.com>
 <20200923024528.GD12096@dread.disaster.area>
 <alpine.LRH.2.02.2009230459450.1800@file01.intranet.prod.int.rdu2.redhat.com>
 <20200923094457.GB6719@quack2.suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_9E222F09-4434-47E0-96BE-6160413F5B87
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

[cut down CC list, since I don't think most people care about this detail]

On Sep 23, 2020, at 3:44 AM, Jan Kara <jack@suse.cz> wrote:
> 
> On Wed 23-09-20 05:20:55, Mikulas Patocka wrote:
>> There seems to be a bug in ext4 - when I create very large directory, ext4
>> fails with -ENOSPC despite the fact that there is plenty of free space and
>> free inodes on the filesystem.
>> 
>> How to reproduce:
>> download the program dir-test:
>> http://people.redhat.com/~mpatocka/benchmarks/dir-test.c
>> 
>> # modprobe brd rd_size=67108864
>> # mkfs.ext4 /dev/ram0
>> # mount -t ext4 /dev/ram0 /mnt/test
>> # dir-test /mnt/test/ 8000000 8000000
>> deleting: 7999000
>> 2540000
>> file 2515327 can't be created: No space left on device
>> # df /mnt/test
>> /dev/ram0        65531436 633752 61525860   2% /mnt/test
>> # df -i /mnt/test
>> /dev/ram0        4194304 1881547 2312757   45% /mnt/test
> 
> Yeah, you likely run out of space in ext4 directory h-tree. You can enable
> higher depth h-trees with large_dir feature (mkfs.ext4 -O large_dir). Does
> that help?

You can also enable this feature on an existing filesystem by running
"tune2fs -O large_dir /dev/sdX".  It might need to be unmounted, not sure.

Cheers, Andreas






--Apple-Mail=_9E222F09-4434-47E0-96BE-6160413F5B87
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9rrgIACgkQcqXauRfM
H+CDBRAAqDyfR9AyxE6fb6bkKrCe3fONDcE4hbDyahkJQzNoBvsHKEYDobw7+fQu
5GOLA6dck6OrdPXjA2RmH1l5S+fs/ygFhtOg472y5YU5FDaOknhM4/miqdwRhwNr
ERkg6saOm0nuYfxOViSJOhy+LI4X07HJBDhZzqSsRx2UEx8muFga1JyD/4Tj9mEi
2e44HqTWq6TvoSticvL9RLbOxyDRgKqhrIeNswb3X/ywRoi7rk5Cf0cKvEHlP/Rq
gooKI66wf/XIastQqqX+euUGgTYcpLsl6LNgbI6gPbU8lXzmOLTaITjgeqbwiK6v
6trKghVHG4/5z2uwL1O3utyf1YLOLGGSDKt22OGgHpAw2xKLjILP1v6+eT/EE8WX
iQxBfnS31qagTuE9BaymRqHNd2YvcFaGq+cGoQ/6jObcIIhuibhtWGvILWfZtylw
WXaxuzGfX5OyJsc2LXY+7PmZlIUNrXOFrQOcSRhG0CyxIo3t1vytFziRFLrna6pB
QCg+LOJGbTm7XmdJZjRalEMQ4768n8SoCuP5M7HuD8/DVaYoxXTOGWyvENbbLl0J
0olKvV1acgE/yxsuu/lsK2tmePm8nxA7n6lTdJ9eii0ZOzTTvvjKfGiswNXouYHl
sTPT+kuCVSjB2IL9ZTy5fIpnJe/VBGg9Ihz7y2ZCyZwxtn35uVY=
=7A6x
-----END PGP SIGNATURE-----

--Apple-Mail=_9E222F09-4434-47E0-96BE-6160413F5B87--
