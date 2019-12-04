Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E574113457
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 19:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbfLDSXt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 13:23:49 -0500
Received: from mail-pj1-f41.google.com ([209.85.216.41]:33059 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbfLDSDZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 13:03:25 -0500
Received: by mail-pj1-f41.google.com with SMTP id r67so140416pjb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2019 10:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ijtrVw014HGnTW9f8Rq13/UqYaPlJnd5tBfrouhme2o=;
        b=AgpV/o1mZnIgpAoH4UnBkTb2AeEunM3wEMYlVCwuhsRc6nHGn5DE/z4qeh3ghh7U0v
         wr+NUpnjFmgN1P8892diAPNYpY9tOeprR3UYoD4VYXMxu+EvknPXfN/fmiEwVL5wXAg0
         XfWR408SuH8S99y6n0G6t9sAx41qS+xGg5g3myoDHxM4i2LXjlkO4llddsvG97ePbY0r
         VOQlH2Ptc8TKsbkSDyYFY67mDb7GmTxAesh/wNPYehgkXnzYnY/hKXfOcpT8A7EgJ3qF
         R6nr+Ue9+CovAkhG/6RcwfL82u395TdL+Ws/iP+odjGMyIyuKQpyOuFchN3x4+rZE6PL
         fCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ijtrVw014HGnTW9f8Rq13/UqYaPlJnd5tBfrouhme2o=;
        b=p1BNfU3qV4J2vUEVGKYBb5aWrwvZX3djb8CGjrGLnrKqX7RNp99665Y5Y4EygaZz4/
         3PASUtbropdjozIi6iNHDRJP0FSMywm+tUnyHVwmtyWGWNSbOw8ENA989NXzLQL4xJLW
         PnDd/Ia0te+gllJJ9fNKfXT/yw1kpSl9cG/RjnE11RQ4sNBerlWiOqFVVy4YKcN517r8
         5yaOfyLIvZm1pusGVw7G32lhxUU9bNNNI3KNFiXcAc5YB2MYl9XUP4Gc5xtNN2xnZuxb
         3UC/TqSe8eLciXQ3TnY/Nm5Hg9bH6bHxuXTIHEgacZNpFkinP5N+S6GS3YegzEVIfHWR
         A5Yg==
X-Gm-Message-State: APjAAAWDh435uaj9pmRhj+D4N4y1Vxpri5Y+fiuLKBOks2TJd7aGejII
        CbSqr8uVeC1zavi4bnzYyGtqwQ==
X-Google-Smtp-Source: APXvYqyzYudsKkRidnGnkIulUuTR6Y+Np/HmPhERtPjwaOBOpllO4bNdwLkfP8g5KfKzCW8F2YK7Pg==
X-Received: by 2002:a17:90a:1b45:: with SMTP id q63mr4697389pjq.91.1575482605037;
        Wed, 04 Dec 2019 10:03:25 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id k60sm7536612pjh.22.2019.12.04.10.03.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Dec 2019 10:03:24 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <6C8DAF47-CA09-4F3B-BF32-2D7044C1EE78@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_E878DF10-FEBB-4C96-9C44-6FDCE30B3F8D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC] Thing 1: Shardmap fox Ext4
Date:   Wed, 4 Dec 2019 11:03:18 -0700
In-Reply-To: <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Daniel Phillips <daniel@phunq.net>
References: <176a1773-f5ea-e686-ec7b-5f0a46c6f731@phunq.net>
 <20191127142508.GB5143@mit.edu>
 <6b6242d9-f88b-824d-afe9-d42382a93b34@phunq.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_E878DF10-FEBB-4C96-9C44-6FDCE30B3F8D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Dec 1, 2019, at 6:45 PM, Daniel Phillips <daniel@phunq.net> wrote:
> 
> On 2019-11-27 6:25 a.m., Theodore Y. Ts'o wrote:
>> (3) It's not particularly well documented...
> 
> We regard that as an issue needing attention. Here is a pretty picture
> to get started:
> 
>   https://github.com/danielbot/Shardmap/wiki/Shardmap-media-format

The shardmap diagram is good conceptually, but it would be useful
to add a legend on the empty side of the diagram that shows the on-disk
structures.

> 
> This needs some explaining. The bottom part of the directory file is
> a simple linear range of directory blocks, with a freespace map block
> appearing once every 4K blocks or so. This freespace mapping needs a
> post of its own, it is somewhat subtle. This will be a couple of posts
> in the future.
> 
> The Shardmap index appears at a higher logical address, sufficiently
> far above the directory base to accommodate a reasonable number of
> record entry blocks below it. We try not to place the index at so high
> an address that the radix tree gets extra levels, slowing everything
> down.
> 
> When the index needs to be expanded, either because some shard exceeded
> a threshold number of entries, or the record entry blocks ran into the
> the bottom of the index, then a new index tier with more shards is
> created at a higher logical address. The lower index tier is not copied
> immediately to the upper tier, but rather, each shard is incrementally
> split when it hits the threshold because of an insert. This bounds the
> latency of any given insert to the time needed to split one shard, which
> we target nominally at less than one millisecond. Thus, Shardmap takes a
> modest step in the direction of real time response.
> 
> Each index tier is just a simple array of shards, each of which fills
> up with 8 byte entries from bottom to top. The count of entries in each
> shard is stored separately in a table just below the shard array. So at
> shard load time, we can determine rapidly from the count table which
> tier a given shard belongs to. There are other advantages to breaking
> the shard counts out separately having to do with the persistent memory
> version of Shardmap, interesting details that I will leave for later.
> 
> When all lower tier shards have been deleted, the lower tier may be
> overwritten by the expanding record entry block region. In practice,
> a Shardmap file normally has just one tier most of the time, the other
> tier existing only long enough to complete the incremental expansion
> of the shard table, insert by insert.
> 
> There is a small header in the lowest record entry block, giving the
> positions of the one or two index tiers, count of entry blocks, and
> various tuning parameters such as maximum shard size and average depth
> of cache hash collision lists.
> 
> That is it for media format. Very simple, is it not? My next post
> will explain the Shardmap directory block format, with a focus on
> deficiencies of the traditional Ext2 format that were addressed.
> 
> Regards,
> 
> Daniel


Cheers, Andreas






--Apple-Mail=_E878DF10-FEBB-4C96-9C44-6FDCE30B3F8D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3n9OcACgkQcqXauRfM
H+AzhQ/+LelpZVYoTlu0opEs5vyM+LBrYxtxWSYLpaFZMSFNERgkFMDEjbSF0qWp
dIIZ4iOlI8OArkugvZk85BzQgQY8ZUZizyQSdzFBXDt/d9Gyew/Sbntkuv0UMZS+
HhVM1Jr8tgFLYqjAijm+mDVyPh1ZAAMo9+jYAKTLQwOdqovCBtLRD9v7HOaCSYlU
dZ094nsG7mDVmWztOO4KLG419h50OUK+q2nnuLwjV6Por0kA9penEo7XjZLecuIz
X2GdIecu0SWh4E7hbsKjylkOC8AKQYibgv380MOJaNp9WBYeoHv3HaXmO0achr6T
f5vHbhFoKRpochhRkKAOlknEY1h89AkyfqyDTfA95Yw0nND9nG8+PLUVOfP9mt72
INqEdUY4gVIRR488YG3Dn9X4yGva6tI5v5oDx7JLvVa5Josk57AMIuvKIdsqluF0
7g+lFY50CnWzfiATloSLhJEB3BohIm4PrLWyyjn27EE/BJpsZSvABxfDGpOSuCPr
cNr68nQ4dw3E4PzTpuxhF3L/wlQNiG6OUbdFPfeyxxZfcoCFKrphzDWAW9iySS3x
2P7kKDVP8SiCZQ5NUWtc8/YI6MwhA6Lcz7fQYL8+9DWdN2Ha1PZ1lU+/CqrAZIbJ
It472/u392OJbPcAWJ5Gze52JsEDeLfj1ZzV58+MHmCvqoKJxb8=
=M/DF
-----END PGP SIGNATURE-----

--Apple-Mail=_E878DF10-FEBB-4C96-9C44-6FDCE30B3F8D--
