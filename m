Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39E77A54A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjIRU6S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 16:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjIRU6N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 16:58:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE5E1137
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:58:03 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c59c40b840so64235ad.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 13:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695070683; x=1695675483; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tauh1TRK/BMeBu2l0gaSo+cZtciZh4ApAYeMwZDiN0w=;
        b=EtjCD8XVeuyu4XPhxQV+t9HYnYbdWObJjfzOR6vxv4ywzcteSLd7/vnG2MUSzDQt0O
         LG3v00URknQcK8wR6BKbWHM6eXxfkaSoTz3oz+YjLfafcEqWoJnyWOQMsRNxOTVXNPt1
         k2+lRenwmrczPR68IB+I7VjepnnPHVIkCEGo9oCT9gNgE61pRdv1/i+GTi8g92PWdnpH
         L5pXGhySoxVwoCymRI4vbFm7w6Lx9+eU8phNMgqBFG8qk8Mr7IzfHSlpL9Nfmq4N0fxV
         SyKHj8YGRldXW5vDWguPg+toMxg+W7nv35SzMx4cGWB8jM0fT8CS+mDmZDCF/b9Kq0cs
         dwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695070683; x=1695675483;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tauh1TRK/BMeBu2l0gaSo+cZtciZh4ApAYeMwZDiN0w=;
        b=g8RzBkic7Ct8RqY3zXwwITvrIql0TXry+ALBKkX2BMDI0nZClx4Yh6tq3jWCMzxj7V
         NM5gGf/8eLUIuNF2u644v/Dr66zTJFIx1IE0Drungfnwot29JbXSMjUGPmNAqskSgHll
         mCCgiuLzw1XT4UiYW9P0sPLs2KSru/C5L/iJl6u1ImXVRqYKQGMHRnYDDw0/QrCs47fC
         57jmc7mFWF9NvRZe3GXifliN+ofMoCxdIFs9LqhAcMGVpTlvM2h9d94VSJDfZOySkc2w
         4GO3ukYi+k15p1EVTn8HIN59etFmweECub8Tpsz2KhcikRmwc9A3haE6n7Qp7KyEd85H
         wDzw==
X-Gm-Message-State: AOJu0Yyoov+BdPxv2qnKIesZTf0s4HU3WDU+iaWYmeziSpvHCpRxn0aE
        bbO3UaG94h1TVgcivg5Ag+xz+A==
X-Google-Smtp-Source: AGHT+IHW/N9kktGUP1je9DFFNRd7ALIMHRTanWQ0GwsItBzOAA3iVWzYW3fREWh2c3rpYKzuxfVf5w==
X-Received: by 2002:a17:903:24e:b0:1bc:6799:3f6c with SMTP id j14-20020a170903024e00b001bc67993f6cmr10039131plh.35.1695070683210;
        Mon, 18 Sep 2023 13:58:03 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 9-20020a170902c20900b001b87d3e845bsm2813998pll.149.2023.09.18.13.58.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Sep 2023 13:58:02 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <59DA5D4F-8242-4BD4-AE1C-FC5A6464E377@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5D26C71F-6AC4-4378-9A44-BBCB7136D1A4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
Date:   Mon, 18 Sep 2023 14:58:00 -0600
In-Reply-To: <20230918-grafik-zutreffen-995b321017ae@brauner>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
References: <20230913152238.905247-1-mszeredi@redhat.com>
 <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner>
 <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner>
 <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_5D26C71F-6AC4-4378-9A44-BBCB7136D1A4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Sep 18, 2023, at 7:51 AM, Christian Brauner <brauner@kernel.org> wrote:
> 
> 
>> The type and subtype are naturally limited to sane sizes, those are
>> not an issue.
> 
> What's the limit for fstype actually? I don't think there is one.
> There's one by chance but not by design afaict?
> 
> Maybe crazy idea:
> That magic number thing that we do in include/uapi/linux/magic.h
> is there a good reason for this or why don't we just add a proper,
> simple enum:
> 
> enum {
> 	FS_TYPE_ADFS        1
> 	FS_TYPE_AFFS        2
> 	FS_TYPE_AFS         3
> 	FS_TYPE_AUTOFS      4
> 	FS_TYPE_EXT2	    5
> 	FS_TYPE_EXT3	    6
> 	FS_TYPE_EXT4	    7
> 	.
> 	.
> 	.
> 	FS_TYPE_MAX
> }
> 
> that we start returning from statmount(). We can still return both the
> old and the new fstype? It always felt a bit odd that fs developers to
> just select a magic number.

Yes, there is a very good reason that there isn't an enum for filesystem
type, which is because this API would be broken if it encounters any
filesystem that is not listed there.  Often a single filesystem driver in
the kernel will have multiple different magic numbers to handle versions,
endianness, etc.

Having a 32-bit magic number allows decentralized development with low
chance of collision, and using new filesystems without having to patch
every kernel for this new API to work with that filesystem.  Also,
filesystems come and go (though more slowly) over time, and keeping the
full list of every filesystem ever developed in the kernel enum would be
a headache.

The field in the statmnt() call would need to be at a fixed-size 32-bit
value in any case, so having it return the existing magic will "just work"
because userspace tools already know and understand these magic values,
while introducing an in-kernel enum would be broken for multiple reasons.

Cheers, Andreas






--Apple-Mail=_5D26C71F-6AC4-4378-9A44-BBCB7136D1A4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUIudgACgkQcqXauRfM
H+ANkBAAswMy3DnkxDykTG0XPE8YNdNKUuKmr8Ybnx3zZSYjr6gt0M9Z1RjbfXwb
/gD7LMA5LRDiD18iwMdA7xhAhzCSFdycXADobuQQihqo5gAwRlm4iMDLharQlJSr
OP5T5z92C7iBtV2ntUZ+vq0Ojh0jshFZXpwcWSMzoG5AD+lY5ci+ML+2fvKdCNbJ
jUaY2xlOEu5TDwJeI52lT5gxKWezZHxk1oPWtFrAmyenRHDhe6Hq8fL36EtpHyTI
iBzu3chvZ073H9i72vZt34nQBy7MATe3k4mRQQhsGhKuJGmXY2s/zil60fBzR2oh
vqW5JGq4cj/HTjDNyjED8wS5yeAlvKFlAL53ojeM6VhipOR9IGUEb+RYefmcVaZ+
ZyK3IgXrfFNhfLNxlrT33S8Y+EhPg5b8iFF06aroPs4hmwIpMy2whpnmjcQju84w
4zVjFSo1spBY39cU6YWxGogITC/VT9WOtv4+ckr1Xn4gnMr3PFs7XnAumh3kC1a1
JqmHbw38TLOFXAFV2Nkc6MWHdxCDjmFr24OkpoaR4sv+QxnK7v62JN8NIBGeVlDC
+jV5+LjSC2l502sVAqbOxamoTfv3u7r2UvB0zddiirtKl3/dUjwCmXFms90STFxP
OnbdmtAnZu5wK1yWNVUojzLnWliZmcFAfLA1/lVTl1ttjlmG0Sw=
=7iPD
-----END PGP SIGNATURE-----

--Apple-Mail=_5D26C71F-6AC4-4378-9A44-BBCB7136D1A4--
