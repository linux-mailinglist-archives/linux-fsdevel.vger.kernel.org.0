Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400C7699AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Feb 2023 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBPRIJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Feb 2023 12:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBPRII (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:08:08 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408631E0F
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 09:08:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id a23so1685772pga.13
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Feb 2023 09:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=M/2sJEtgCqWcHpyGZltlmPEurvS6k94QmmYnvcA73iU=;
        b=HrngW0waqUUxWaiLQaqsCTivnazUQTmHjOxeLm/mFtO19NgCdcrwi37YEy0pxkPocb
         BzneYYkc1A/e/REiS3zJk3ZB5d3u3mvOsv/kcc4aqABPkqdtgP6exurBCsgOisGjl+bV
         YciY56Z/S2iH3oYj5q4CeS1Az3UyTPAc4McPga1/ofbz0ChWWLnziUnMDPq+nqKqUn+Z
         uS1ll6Mzo7zc1uEhQZvxseGqB+QzfDgMxJR6Q2N/28YXO9Nr+DsTqFPD7O9AZK8Yfes3
         FzMv9aEfH2kkTyEzmp2LApIX42OvkqIwgKBg8dI8iKazf5t2cQVl1/UmWnKgqBYE/pVy
         0hWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/2sJEtgCqWcHpyGZltlmPEurvS6k94QmmYnvcA73iU=;
        b=upTggneuDsCFNqB8FF2UNPVXvR0w/Ztxi7cj+ZjeB17W4hOJ3bwq+oY/DBPwZM3VKn
         4AT26sORQYWhgHO+OJyTHI+22w5s7pnsY9ln+apQrYw6lITx6RSM4HlXoR5Sdb6LdDhy
         +f9S/foYWkQBm88ENcZZ4CZFMwOFPWK9GE/mEkN8vYoN8FhswW18HGFYSV5dMeeovSLq
         5W1XTB2LWn6mJwIjxaNsPv7VDEXOwcXG1TqdYmKNEa55MopDMUTdsStsSJOzMmjhwl88
         lHG6Beu0KpHyjagpseFZqjCnOheXcaqqVgW9Ety/KbxmYWcibBWcYXxJxPCG/S3gAxlk
         vhrg==
X-Gm-Message-State: AO0yUKWVq25SnvJXBWhGJD4E96YuvMhyEAdCzLfsVcaJ1m+cT6XyOBkx
        ezNyzfNHsDzDVmMm6oH21nivdg==
X-Google-Smtp-Source: AK7set/vsgz2uYkbAgIUfKJq8MNuQDSWydhwoc+XsfsLDQnsHATccPNNhCSyzm6SRxLozkV9aFO81g==
X-Received: by 2002:a62:6386:0:b0:5a8:4c55:db6f with SMTP id x128-20020a626386000000b005a84c55db6fmr5338963pfb.19.1676567285185;
        Thu, 16 Feb 2023 09:08:05 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b00592591d1634sm1597492pfu.97.2023.02.16.09.08.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 09:08:04 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <542D3378-3214-4D0D-AA63-5A149E2B00EE@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_2AA5044B-1570-4816-8AA0-ED824D970CD1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 7/8] ext4: Use rbtrees to manage PAs instead of inode
 i_prealloc_list
Date:   Thu, 16 Feb 2023 10:07:39 -0700
In-Reply-To: <20230210143753.ofh6wouk7vi7ygcl@quack3>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rookxu <brookxu.cn@gmail.com>,
        Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
References: <20230116080216.249195-8-ojaswin@linux.ibm.com>
 <20230116122334.k2hlom22o2hlek3m@quack3>
 <Y8Z413XTPMr//bln@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230117110335.7dtlq4catefgjrm3@quack3>
 <Y8jizbGg6l2WxJPF@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230127144312.3m3hmcufcvxxp6f4@quack3>
 <Y9zHkMx7w4Io0TTv@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <Y+OGkVvzPN0RMv0O@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230209105418.ucowiqnnptbpwone@quack3>
 <Y+UzQJRIJEiAr4Z4@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230210143753.ofh6wouk7vi7ygcl@quack3>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_2AA5044B-1570-4816-8AA0-ED824D970CD1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Feb 10, 2023, at 7:37 AM, Jan Kara <jack@suse.cz> wrote:
> So I belive mballoc tries to align everything (offsets & lengths)
> to powers of two to reduce fragmentation and simplify the work for
> the buddy allocator.  If ac->ac_b_ex.fe_len is a power-of-two, the
> alignment makes sense. But once we had to resort to higher allocator
> passes and just got some random-length extent, the alignment stops
> making sense.

In addition to optimizing for the buddy allocator, the other reason that
the allocations are aligned to power-of-two offsets is to better align
with underlying RAID stripes.  Otherwise, unaligned writes will cause
parity read-modify-write updates to multiple RAID stripes.  This alignment
can also help (though to a lesser degree) with NAND flash erase blocks.

Cheers, Andreas






--Apple-Mail=_2AA5044B-1570-4816-8AA0-ED824D970CD1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmPuYtsACgkQcqXauRfM
H+Cu9g//YCZ+jwypTgq+CU4GrHRWfQgwIIsAagt/+hIQ49+p2psufXRuWBYuVvXo
JhbGVzk6yztNm81QBZp1unYEnm5Gkkeq7AD1J19zE3v2muHTU413Xf5UFTP7ZzLt
6s84jHucEbPITzX+YkxxbAMF819KdgN7UDMnJ9K5mC1bvJtFOE5TWkMXCZSZEyhb
Njg2UWRZ1L+JfFejIPmiDStL89Ae4ryhatVYg5LLEGmXMNx1Su/n2Vd8mqzq6KnF
Ek0Z8Hz1XI0GGNugZiG+LziCzGXsE53in34LXUwXd7ZnU/OIZ0B/GF6q8SbKW2C5
VdrED+FifNFXsxhUCxDhfl5wEO8TASMPaUuF6qbNXsXF3cSPb3qb+ec5e+0EycjC
TpGGPHDo2Ik3/wLtGJ/oTl9sdv8SPDxlStfL4+oL6jmcGOoF2Ihh9Hg80UnQHLnR
9dWU6PYcR8KKBaqJH9euWzLr6cTx8MxBzZDDUCJxT6UWpK+WjBebLazSarvVqS4h
yxAGZDaKtF3CjYkb24nrrz7yUDTO7uaj93NJO5ADwg4KszHAVxBSUStxKgCyUR/Y
bEigne4D7B7TaH4l2kPckhfwwCpxnhqmCoYqAyWqKHRySkXxFVcjw4/ApLQ+/KPX
2UlaN5gf6z8PUSkp0mXLCWBFDsXvJTFqF1gy7Fv2YfCHaaMBKaI=
=C/5g
-----END PGP SIGNATURE-----

--Apple-Mail=_2AA5044B-1570-4816-8AA0-ED824D970CD1--
