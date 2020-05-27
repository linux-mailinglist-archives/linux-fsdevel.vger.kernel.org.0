Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DEF1E5152
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 May 2020 00:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgE0Wfs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 18:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgE0Wfr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 18:35:47 -0400
Received: from omr1.cc.vt.edu (omr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:c6:2117:b0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC65C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 15:35:47 -0700 (PDT)
Received: from mr1.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04RMZjaX005894
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 18:35:45 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04RMZe4F002979
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 18:35:45 -0400
Received: by mail-qk1-f200.google.com with SMTP id d145so923403qkg.22
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2020 15:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=wAfrgwiy8FRYZqVG4if/0XphI1xwoqduQ4nX1CyB3XQ=;
        b=d4cZ45fkDu8svgxs8Nwr7al+3gHJPQK91zA2YFmpBR14clW/Z9cDx26XoFrHOvN56C
         VOL1GF2vZGL/gALWUqYJh9kVpUXAcTbCs7Qh9vLC6CJEEqe7Oxr36fuELvBIKVVlg3Us
         9UXsB8uwgmFbsCGc9rnFjyLh7ovDJmK/mqYc3X/QEF5ibzMgPMPdZJe8VSzkkdaIUXAl
         SkV4CxRZ+Z9thgwtg2zrxFotk2Np+n+uM1jprYhXI3lo7Bvjze273A+GX52WU0CSOQya
         1SFFbGPKaQnQw/nckGvzT8fK79fLyY5AvkDPSuuVfYh9tKY2i31pC1r3K9hkhQ4f4GqJ
         2mvA==
X-Gm-Message-State: AOAM530Kz0EZP1vdNTWRV3Wm+xe8RNVS5ZxzEWVwWzwxSkuinSUHTRnw
        aPVPwmsUw/jJYSTSVqS8R0FEHHGF6Q3qXDDeN02g8wcNcK8lj9zXbij89OQD61Q6N4/YZNSyPi5
        nDkxsjos08hVOCS1rjJoW0XdyUFdGDD1jPEU1
X-Received: by 2002:ad4:5624:: with SMTP id cb4mr244721qvb.154.1590618940013;
        Wed, 27 May 2020 15:35:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvSOV04NC8GPpLZ3kCE1Jln8ku1I0WYDMmMd8SFB2kWTPSoZpLpaIek+ain75HZ4nTzoLQeQ==
X-Received: by 2002:ad4:5624:: with SMTP id cb4mr244700qvb.154.1590618939680;
        Wed, 27 May 2020 15:35:39 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id w3sm3519357qkb.85.2020.05.27.15.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:35:38 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: fix execfd build regression
In-Reply-To: <877dwx3u9y.fsf@x220.int.ebiederm.org>
References: <20200527134911.1024114-1-arnd@arndb.de>
 <877dwx3u9y.fsf@x220.int.ebiederm.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590618937_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 27 May 2020 18:35:37 -0400
Message-ID: <441347.1590618937@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1590618937_16657P
Content-Type: text/plain; charset=us-ascii

On Wed, 27 May 2020 17:08:57 -0500, Eric W. Biederman said:

> Is there an easy to build-test configuration that includes
> binfmt_elf_fdpic?

I tripped over it with a 'make ARM=arch allmodconfig', but any
config that includes CONFIG_BINFMT_ELF_FDPIC should suffice.
I haven't checked the 'depends' for that variable though...

> I have this sense that it might be smart to unify binfmt_elf
> and binftm_elf_fdpic to the extent possible, and that will take build
> tests.

Bring it on! :)


--==_Exmh_1590618937_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXs7rOAdmEQWDXROgAQKfFg/6A1io4tXqeORzdvfNlEZnJZC5ZT1M+b1V
yC+vexxgJY/0oRN5y+76+hhBckAoacD4ABy9sH755aKwaPbsnmo9v3DCLK8W/Dxr
taIQ7NlSDWm9F4gTo4nkiutbogP5QjYbAnJdO5h/TrUN/HzOvf2TrJ43WYBxGQrE
4Tpy8knIfdZb/MNlSA0zbcqzzs3oZ4UxQvVs/xJ0NsLoR7FvVIELhEovxd+mpwLH
/Ynf2K73gIHhamKCRvCA3YZuXX1qWZPAr0XjJ/FcIWc8LsQD4WDksPKzYJjHun0B
sh/7aVPzd9HYcotsNamWAkdJL4wtH1LSItSS1TxX69FAN4OchXhiSZlHtPlJ1sI0
US2WjWffW0xC9rzJFTNvhft4FuB2AJlP4bJmuH7QXyR2UH0IG51J2LhQkzBwb7EV
bxa7pUV7lVrqEvB1nFc4nYC441kT8MlGF3AQh1W74InfeB7Os1nLrvVlzsoCXrFn
l7WLHTgi9Vtb7DXDmQz76+cpdq35NMbQL3+Aiqv/SphmTDIt8ePQ0hgH/5p3snGf
jh1zhjyQeRfgZj7cs0FpGtUhgO0cA1TcBhyPadUju1IVk5yut5hfPREd6dC2VmJS
Il5MuZFGpGfXkaLnE2EgnEVNmzXDQi2TnYguqvhtOgJPn9dl+X4EeR7rpTERWlkH
nBq+1ugzGtw=
=ccnE
-----END PGP SIGNATURE-----

--==_Exmh_1590618937_16657P--
