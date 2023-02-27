Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F2D6A3885
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 03:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbjB0C2y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 21:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbjB0C2j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:28:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A951C1117E;
        Sun, 26 Feb 2023 18:25:40 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id z2so5209051plf.12;
        Sun, 26 Feb 2023 18:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hHZTgSlpKE4LIn15B/ORfKT+gPur6wAz8idvFdiTNJI=;
        b=JoMigEaVjrulpdbYAFLEB+IGtdUClKFM9Vfpu5yTwWybPb9UghvO0tber+vuESH0q9
         A974e9/mmVu5bLNRozv/8JUJY9HNo+qZN8JRvuq/h4dm2F4Mc8r6+z9/0afyqSh4XXc4
         5Z97famY7jrrFUrzsUbowPsFtNwlb3gtqurhoJkkThut+JUDPM4jhKyyO7Et+O1ZitrS
         HRXJtYdEIgwtyD7ahL09gRTULruG+Knyvk9EgmYnNsxKE1G8e5Zv6fHY0Ea5WyCpgPhv
         T7tzhWGSaeoCM3PrjAgAPYqCJPZi8GYF6kc3zMEsNmSGF571k7LDyhDqKAEzYnUvEpu0
         LC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHZTgSlpKE4LIn15B/ORfKT+gPur6wAz8idvFdiTNJI=;
        b=i/1KK8p3FSlH8dbmOsgeFts7XMSoDb726PRxXtHJl7F5tO5ZPYLwi8xkCB4C/sacvJ
         18ADsBlX5kCpGemciAj5F6zO8fAkSkoj6blRaIX+BIbCVc8B7t/kMmi6qkAU0/1pu3pW
         jl2SkP/YWJJ44KmGu0WISPNt9sdKcH1NosFeV5yxn3ekMVLdFU3YCdCIFUTzOFOy63sB
         5zmzGh+xzdoVlYSo/IDDIgNaRBYpdd4YQumsMZIdafP4A6NN0VrgpDy2PAD0aI3t5sB5
         Gc/X+EIYY3NMsW4DKesEyU/UaI0PsnVWirFAUi4cJEOL0TdWFiXAPsK6KaShtRghptQy
         9zZg==
X-Gm-Message-State: AO0yUKWC34LOFMH1/qTAvByoKXIyGzsbzHAGvdjvFuYsgB3r5hu78EnY
        B6nCqOuAinDpV00VL4Ab1qZoV5cGbEc=
X-Google-Smtp-Source: AK7set+J2ZeWgrcLSeKaiJGdC79xTBG9RP4R+lD4mt0PXmAM+MLPVx2EYLXe+AmCvdP02xoL9nVNiw==
X-Received: by 2002:a17:90b:1b4e:b0:233:ee67:8eb3 with SMTP id nv14-20020a17090b1b4e00b00233ee678eb3mr26341909pjb.24.1677464659440;
        Sun, 26 Feb 2023 18:24:19 -0800 (PST)
Received: from debian.me (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id gd5-20020a17090b0fc500b00233cde36909sm4937800pjb.21.2023.02.26.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 18:24:18 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7485C103566; Mon, 27 Feb 2023 09:24:16 +0700 (WIB)
Date:   Mon, 27 Feb 2023 09:24:16 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     Filipe Manana <fdmanana@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Btrfs Mailing List <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fsdevel Mailing List <linux-fsdevel@vger.kernel.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>
Subject: Re: [RFC PATCH v1 1/2] Documentation: btrfs: Document wq_cpu_set
 mount option
Message-ID: <Y/wUUBf9fuIAPsNw@debian.me>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
 <20230226162639.20559-2-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ukRh/UPC1xIBjl4m"
Content-Disposition: inline
In-Reply-To: <20230226162639.20559-2-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ukRh/UPC1xIBjl4m
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2023 at 11:26:38PM +0700, Ammar Faizi wrote:
> +wq_cpu_set=3D<cpu_set>
> +        (since: 6.5, default: all online CPUs)

Why will the knob be introduced in 6.5 instead?

> +
> +        Btrfs workqueues can slow sensitive user tasks down because they=
 can use any
> +        online CPU to perform heavy workloads on an SMP system. This opt=
ion is used to
> +        isolate the Btrfs workqueues to a set of CPUs. It is helpful to =
avoid
> +        sensitive user tasks being preempted by Btrfs heavy workqueues.
> +
> +        The *cpu_set* is a dot-separated list of decimal numbers and ran=
ges. The
> +        numbers are CPU numbers, the ranges are inclusive. For example:

"*cpu_set* is a dot-separated list of CPU numbers. Both individual
number and range (inclusive) can be listed".

> +
> +                - *wq_cpu_set=3D0.3-7* will use CPUs 0, 3, 4, 5, 6 and 7.
> +
> +                - *wq_cpu_set=3D0.4.1.5* will use CPUs 0, 1, 4 and 5.
> +
> +        This option is similar to the taskset bitmask except that the co=
mma separator
> +        is replaced with a dot. The reason for this is that the mount op=
tion parser
> +        uses commas to separate mount options.

"... replaced by dots, since commas has already been used as mount
options separator".

> +        If *wq_cpu_set* option is specificed and the *thread_pool* optio=
n is also
> +        specified, the thread pool size will be set to the value of *thr=
ead_pool*
> +        option.

"If both options are set ..."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--ukRh/UPC1xIBjl4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/wUUAAKCRD2uYlJVVFO
o6ytAP4h1dqQViPAwxmi7eiXFMCVNLJengTqe0yhgCEtb7TxpwD/axvKL/zwz0dL
7Q4S1q2eB0m1R8FKdXKrAJ2MMo0AMwU=
=c2Vp
-----END PGP SIGNATURE-----

--ukRh/UPC1xIBjl4m--
