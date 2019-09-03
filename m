Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB0A73CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2019 21:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbfICTj0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 15:39:26 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:40764 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfICTj0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:39:26 -0400
Received: by mail-pl1-f175.google.com with SMTP id y10so2443876pll.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Sep 2019 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=QAQYaagWiERgEYSt1jNIKS0am0ErrH6wjeHanHKKcNA=;
        b=QnIp1fDJqRyOldM1ryAsqsjNuHJDfJOz/B4BUmyCJSUWJ9wWmohNEdu3NxYyY/DuZe
         rTJMdMtTpe4cEwX1dydMuRurKyHrAXveBl2A0JQQRGceUD3GTESJqRXNAV9l2ZTgSQe5
         nOMp9PuLYr4Ohd8KrvHFSEUawsxVOjgE0nLA1oiM8lqgvQilYcJfNR8YThDI8g1KT0JE
         7zImba+MRo+jjlDqOgTE0a+GcS7jLHr1BVLxzkngixW8z2HFeneyuqY5JrM+QQG+uQ4s
         cEa5NPlQYLCAyQ7LUAH0GMhXUefMO5F1t7utrIXqF9SGvMBRf9LBB9iE6EwgooP1bFfw
         NhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=QAQYaagWiERgEYSt1jNIKS0am0ErrH6wjeHanHKKcNA=;
        b=TBoc8+9JMHxIHlAsP9hXytEvOvGr+OjOOt9VU5WLzzsRc07HBIhYGHZ2bqYYB4ewc6
         ZKiQA3bXsTXkKpQONjRb20Z7VX7uarRoti/JR4pX7THHMvLXiOdBmS5CPa6xvOQL9IyC
         cudXFD3HgDZ4UahWjFh0zrbo2hYMcrfjDhxGUjcGcQt1WGhGVgpJsPHwExg8EqVF/v2v
         3JyqWgfkIGlqbBnYeXYw73886fLjdRF43achtIvrakQJAcA1eAhTosJddFgMRT+dTERn
         RA4LyBC7EUYUSVsKok+THCzY3Dx9EdcczElCqP0E/m41/lhASFFeBErekX4fU3gscjZe
         gO+w==
X-Gm-Message-State: APjAAAXQxxhtp4N+09PC9GJqEFiwaduFuzh2LaFg7TJZuV/nI9L01s1V
        hvuX7MxoWuAFuWXbKJZfGpJ6gQ==
X-Google-Smtp-Source: APXvYqxR1S4PXbktbKlWF4DEU/EpC0EIS87sVhV8IF3uV2Yvg3XVAykHNL7FMjzXLbRJxXRNUhKzKA==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr34936684plb.230.1567539565224;
        Tue, 03 Sep 2019 12:39:25 -0700 (PDT)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a134sm15364871pfa.162.2019.09.03.12.39.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 12:39:24 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <82F89AEA-994B-44B5-93E7-CD339E4F78F6@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_112DDE64-E949-4D04-98BE-2EFD8AB64FF8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: "beyond 2038" warnings from loopback mount is noisy
Date:   Tue, 3 Sep 2019 13:39:16 -0600
In-Reply-To: <1567534549.5576.62.camel@lca.pw>
Cc:     Deepa Dinamani <deepa.kernel@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
To:     Qian Cai <cai@lca.pw>
References: <1567523922.5576.57.camel@lca.pw>
 <CABeXuvoPdAbDr-ELxNqUPg5n84fubZJZKiryERrXdHeuLhBQjQ@mail.gmail.com>
 <CABeXuvq7n+ZW7-HOiur+cyQXBjYKKWw1nRgFTJXTBZ9JNusPeg@mail.gmail.com>
 <1567534549.5576.62.camel@lca.pw>
X-Mailer: Apple Mail (2.3273)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_112DDE64-E949-4D04-98BE-2EFD8AB64FF8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Sep 3, 2019, at 12:15 PM, Qian Cai <cai@lca.pw> wrote:
> 
> On Tue, 2019-09-03 at 09:36 -0700, Deepa Dinamani wrote:
>> We might also want to consider updating the file system the LTP is
>> being run on here.
> 
> It simply format (mkfs.ext4) a loop back device on ext4 with the kernel.
> 
> CONFIG_EXT4_FS=m
> # CONFIG_EXT4_USE_FOR_EXT2 is not set
> # CONFIG_EXT4_FS_POSIX_ACL is not set
> # CONFIG_EXT4_FS_SECURITY is not set
> # CONFIG_EXT4_DEBUG is not set
> 
> using e2fsprogs-1.44.6. Do you mean people now need to update the kernel to
> enable additional config to avoid the spam of warnings now?

Strange.  The defaults for mkfs.ext4 _should_ default to use options that
allow enough space for the extra timestamps.

Can you please provide "dumpe2fs -h" output for your filesystem, and the
formatting options that you used when creating this filesystem.

Cheers, Andreas






--Apple-Mail=_112DDE64-E949-4D04-98BE-2EFD8AB64FF8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl1uwWQACgkQcqXauRfM
H+AIug/9GlnFvkS1eOwspAuQldeaS7e8chBl6B4F/KG73KautsnCZJv6Qfp9GCuL
TpR0AP7CvHKmW+RlOMtURO+LxtWq1Uu4iVqcu4M+SQ53h7e6tLUxjaS+x6In+upw
3UgJ/x6cM+PoIS7fxKCqkd9kyuZUNxXdiISAqRfzq1g7Ty7CyyGLWI+alaq+txQ6
nTxtGYbyZNDbg9Es4hGmu6VO0B4OxIWBHdIiEzJiWcmMcybFmDsbOQpuGHqCUQ4C
8u0/eL+5HSpzvuRo9KttGFU9Y27gdAsMvSQ6uwvbQUgNpIRW/Q7iSkbIS8s/+hnk
9Z4i4DHAOqRNJMYTH3uOQhXj0zvYDg/OkTledfMr4UKwOfUuOPqwAgeBukEjdIvn
rX6TB7xggDzkg0YMtqSzj6N/g7m1VoKAujv9hezZs3cSNsnxc1x+m3LmUMhmnrZD
S/Ye+PKYARl/+F1yaWe5Ws8OKp/ITfA0c7uHGebTqOG/GolZThYMbSH0/vi4k84F
pOxdS33XZ9NE3RQSntTVFrvZ0NK0mAVNmCSea03JlNW1PamF3jfDMoLr+/0jP4Dx
z+TA3tLFxFUYVgScGNyVI3k/X1imI14UUOSCsmWycfgUUTldMD/xcgyNAHqp9a0R
vCC3ZqAaAJ9k2dnKeUhlNeO2PjA1+nsrvfG495J2ds4fpjEiYUg=
=usX9
-----END PGP SIGNATURE-----

--Apple-Mail=_112DDE64-E949-4D04-98BE-2EFD8AB64FF8--
