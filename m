Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E138B557FB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jun 2022 18:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiFWQZB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jun 2022 12:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbiFWQY7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jun 2022 12:24:59 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C0F39166
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 09:24:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id cv13so51091pjb.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jun 2022 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=bcyfxdYDvwFKE4FcRkASoG03KisaDjvMQmq4ODLZY6Y=;
        b=Q6EkS8J9o1kRFWTS1Sz7yUZQrVb9iZj6pO/U9kzzfvvlgRxFnL50FsOu6QYctzx4Zj
         4AFwrrYShyaBMbMo/S//DCItdhB6Xhidd85LbLLCxhVPWdWfApQ8g/jLGL/zYxjMnhmB
         xugmETGHUFP/NTpUaNxC3LJ8uNd1GAVXJfdx/0rp85cdY7Ghk6qITrxSFopDdfiLvenO
         RRWQfBglfzjZeMXnkcJFN4vOV1vf6TcRPzixwqDrnxZlAnKBAJNAfji+cLcxuPTwVecy
         yQOMeWEt/s2lxyaOoO1+OBzNWKgwuofTfgyeF7a8/TNbKiIEVB21YyJebVkm9tDvvBw2
         jkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=bcyfxdYDvwFKE4FcRkASoG03KisaDjvMQmq4ODLZY6Y=;
        b=GBf1Shd+tVOVCx0z2AYr4QEJAFMiFVQtXekP0Y17q6rAYrmeX7ZKtAoKUcoODh7+kn
         tTxk+FJYDX8un3K13nhMrNJT0AH53K5ONalwBWjQbh9V2tFoXy3qbLc/tge27UDNTN+2
         eo1biRpjncLAQmkMl85hTnSmJ/fOSMJj93qNUl/V/I3spjolyPvs7uMJaLXG/RuIzdPL
         KoK63N2R1HRIg6dV2i7/7OT+k0PogP7gOkdlxCxEJc3/nDfDVuxuH9cld2jRVBe0A9CN
         /Sm7ALNuxZpf55LXbluNrDlsCQ4jAjWj9hLtb0Rfw8hb+sfyCpyGVoGgWqcfDc9w6UDT
         0qfQ==
X-Gm-Message-State: AJIora/Z24KKnoeExKacbjXpuRwtNgHSBFeSkF6+cYQ0HLBQg3PJuqIR
        mpBKs22WbezMh+qcewGtv6hfPQ==
X-Google-Smtp-Source: AGRyM1ukROTsV74eiDORs7U9DuEV5/TMYhdqOiMfNTcV5f2UeXO0T5u5WYzf57Iazk83XTH31glX2g==
X-Received: by 2002:a17:90b:3b81:b0:1ec:e852:22db with SMTP id pc1-20020a17090b3b8100b001ece85222dbmr4865881pjb.77.1656001497135;
        Thu, 23 Jun 2022 09:24:57 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id jh21-20020a170903329500b0016a109c7606sm11075493plb.259.2022.06.23.09.24.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 09:24:56 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <622BA3BB-03EA-4271-8A2E-2ADAFB574155@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1B6FC5B2-556F-4A2D-9F1C-A60D36468C15";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [man-pages RFC PATCH] statx.2, open.2: document STATX_DIOALIGN
Date:   Thu, 23 Jun 2022 10:27:19 -0600
In-Reply-To: <YrSOm2murB4Bc1RQ@magnolia>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
References: <20220616202141.125079-1-ebiggers@kernel.org>
 <YrSOm2murB4Bc1RQ@magnolia>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_1B6FC5B2-556F-4A2D-9F1C-A60D36468C15
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jun 23, 2022, at 10:02 AM, Darrick J. Wong <djwong@kernel.org> wrote:
> 
> On Thu, Jun 16, 2022 at 01:21:41PM -0700, Eric Biggers wrote:
>> From: Eric Biggers <ebiggers@google.com>
>> 
>> @@ -244,8 +249,11 @@ STATX_SIZE	Want stx_size
>> STATX_BLOCKS	Want stx_blocks
>> STATX_BASIC_STATS	[All of the above]
>> STATX_BTIME	Want stx_btime
>> +STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
>> +         	This is deprecated and should not be used.
> 
> STATX_ALL is deprecated??  I was under the impression that _ALL meant
> all the known bits for that kernel release, but...

For userspace STATX_ALL doesn't make sense, and it isn't used by the kernel.

Firstly, that would be a compile-time value for an application, so it
may be incorrect for the kernel the code is actually run on (either too
many or too few bits could be set).

Secondly, it isn't really useful for an app to request "all attributes"
if it doesn't know what they all mean, as that potentially adds useless
overhead.  Better for it to explicitly request the attributes that it
needs.  If that is fewer than the kernel could return it is irrelevant,
since the app would ignore them anyway.

The kernel will already ignore and mask attributes that *it* doesn't
understand, so requesting more is fine and STATX_ALL doesn't help this.

Cheers, Andreas






--Apple-Mail=_1B6FC5B2-556F-4A2D-9F1C-A60D36468C15
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmK0lGcACgkQcqXauRfM
H+CkuA//avp4Tuh55VpE8yHOQ8z64y5vrwNesx7bZ8atQCuwyhbJlvdTGn27SVv1
4j1+/hWy3q+Jsot1ja0njROgu9KlOetTJ7qK4tlq4buIjBuB1izLfyGtSUtRezui
Z93g7NQEpOSFyNwknXMz2vTB4gOxgMd0V9jCkElXXC+EClReBJq/Jts+/qNH8cnU
j2kdedwlaAg3zMbSWbygM0DxumX1YB0dCYuK/SyyAyjWr4I5mHFqHeyZf3ej2fVB
g/wUfgv7Ku50XluSp4/deoA8R/TJbCkQikvKS4S9pI/LqMeOEZ6moyIJ8KRyWKSs
wbSn8e2E49hUrxKO15kQx2vIs1BS1WLN1PWmv4TVnkTmfkuf7iUVVMxlU3Jfifcx
qZXhYvTv7UvL/oV12MJHzQiYR/YUytHzdeliMC+sDa/tCyWE0UZMAZaKFgO9vV9h
gdHfsvdNabGbFBE8ul5auWUT6QaqmytVQOk6239FD/gHD3Vw4ZVptZKDziYfwULV
JgVDmWSi8RzmV3F+g3Lr9oGWqFbErsl+QWm80wXaC7yxHm3C2wKKqwPx6bfFbucT
PuSiilxCV7qDXmDRISKNt/JMaLsxh8w+15v92wWhacEtgMzIyVsjudfePb2wiUtw
bLbXOh9Pj4DCci4an5lxVhj8jEYThvOPq1FlB6e7qhrXwoGwugE=
=83Nf
-----END PGP SIGNATURE-----

--Apple-Mail=_1B6FC5B2-556F-4A2D-9F1C-A60D36468C15--
