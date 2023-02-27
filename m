Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209A6A3872
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Feb 2023 03:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjB0CVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Feb 2023 21:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjB0CVU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:21:20 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D70C1C325;
        Sun, 26 Feb 2023 18:17:13 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id u5so1824946plq.7;
        Sun, 26 Feb 2023 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg/EVQFvAajZS4rtWyEAh6Z6igbC+w6ofAggl5IlIFU=;
        b=Ukb0X0ZCepXJJlx2GkNihtFkEHFqgMvs8iyQSGqctV7fPAJdB41cn06EtTqyc14SLd
         dBdoQeqlHF0M2QVF256LiBozc/M1rin0YTsI7WEtTAUO+nQjGAgMj32ZTFX2kJ6DGjtb
         YJ5QeBVhPyidHW65yjWeyF/sJJXa9nU5Ud7lr/81USHTUoz1AcCjqXzvzQVviFM8ROb3
         F1qdMZbZThQPXdIN2i1oZC6AQUuk8wFOJVNLxBUw63CmhMrSqoovK2A7e8aOMNAwMVNF
         2cAF/NQCbQNzlm0HZd6Yfh4qLyi9ZkAdMRf0hHViM6R+1t6443/cfBtq4OGakCQW5G93
         itHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg/EVQFvAajZS4rtWyEAh6Z6igbC+w6ofAggl5IlIFU=;
        b=N4XUE6DanmBh6qsme+Nf+n/piZsF+ue16tGAdKSZovawqeXA6e8W3TFCjZnVuByxlX
         5l+o/eJZ8xqL2pgeg89wi7m3wTZCPFzJb8juAEbEZj1CUI3+UVchQBfwXu+mHQIrw+pG
         dPLndMcSUM2q70Xo8JAyUOKOaECXP0y807Q3tgiWL2pnW1z/fyXcTB9eeki3sLN95k/i
         Rs+Cde1OHgUCzgPP+QPRnMc9PL6qGyZCD90FGGlu325CHoE2mnyyT9u+W4rVTFab5tqH
         rW2AjoSOwaKoPl2ZR2roFl56K03mKicqdVbmjMdgAEmVpaGYbv/1PDppdGeDOyzsUCzi
         ePxQ==
X-Gm-Message-State: AO0yUKUwKdZ5+ZOU7tQRx0KVHNAoCPdNdE4MkxK2lZ4YQRsgZlX296SK
        /MXNiPsQebd3eD7ehorHAyOjVeJhu/0=
X-Google-Smtp-Source: AK7set8I+e7NYaQG/v240GdZ9N4OyBEVhfatokypeo1WQQJp18ekqLtCli8WLTgpUpVguAoEsZEi5g==
X-Received: by 2002:a17:902:f9cb:b0:19c:f80c:df90 with SMTP id kz11-20020a170902f9cb00b0019cf80cdf90mr4358207plb.45.1677464163978;
        Sun, 26 Feb 2023 18:16:03 -0800 (PST)
Received: from debian.me (subs02-180-214-232-8.three.co.id. [180.214.232.8])
        by smtp.gmail.com with ESMTPSA id e23-20020a170902ed9700b001964c8164aasm3272679plj.129.2023.02.26.18.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 18:16:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 5E730103521; Mon, 27 Feb 2023 09:15:59 +0700 (WIB)
Date:   Mon, 27 Feb 2023 09:15:58 +0700
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
Subject: Re: [RFC PATCH v1 2/2] Documentation: btrfs: Document the influence
 of wq_cpu_set to thread_pool option
Message-ID: <Y/wSXlp3vTEA6eo3@debian.me>
References: <20230226162639.20559-1-ammarfaizi2@gnuweeb.org>
 <20230226162639.20559-3-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fDFresKap0HjLffm"
Content-Disposition: inline
In-Reply-To: <20230226162639.20559-3-ammarfaizi2@gnuweeb.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--fDFresKap0HjLffm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 26, 2023 at 11:26:39PM +0700, Ammar Faizi wrote:
> +        Since 6.5, if *wq_cpu_set* is set, the default value will be the=
 number of
> +        online CPUs in the CPU wq_cpu_set plus 2.
> +
 =20
Why will the behavior be introduced in such future version (6.5)?

--=20
An old man doll... just what I always wanted! - Clara

--fDFresKap0HjLffm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY/wSVgAKCRD2uYlJVVFO
o2EFAP9iZ+Zv1BNkYVDso1HKU2Uz0akR+IpxjX6+ElY9Si7A3QD/cgWI94cx9XeY
9eYiqqdMAPVW1tcwpYNSJXZVE4gCZQU=
=NmA9
-----END PGP SIGNATURE-----

--fDFresKap0HjLffm--
