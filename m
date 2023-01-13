Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5316690E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 09:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjAMI35 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 03:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbjAMI2n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:28:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153E741A44;
        Fri, 13 Jan 2023 00:28:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id k12so668475plk.0;
        Fri, 13 Jan 2023 00:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VLC7TZZXnaqDaWj2wbfmnziBNdGj5R8BVjWt4nNr0yE=;
        b=VwoqfjOKNifd4Gdbr9it6nl5Lb4cMyi5QFoXlfatgHE5tJqxsc4wHtFl/YzUU7NNGx
         crk9JiDHFSqFcJ5JDmpLoA5o93MsvAX6f78xwTVpzRqbDcDvmzMBmJk2Xe0HQ6vw20nX
         TRfIC64FRjyXG6A1uatBm0/bBIFwq+sG3E3ejBWOW2SVmZI9WwlM1d3WHsqkkH2vIDdo
         aQsZuiTFkgNof3KQjVPNUdE4NO8vicZ4KvimljusJqrkdyeFHJrD6CDcoUa8gx5jdYq4
         Iq8HclmpZ5IYGGICCzTGh1wcvIOBSn899tCF+ailuvgimKTA+8JEPX/C4aW26iINkNB0
         FFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLC7TZZXnaqDaWj2wbfmnziBNdGj5R8BVjWt4nNr0yE=;
        b=QBMuuMupPElRAU7IhuRYRCnUD5c6/p+uHsVVedyINxXbPLF5ICizGh4gPFaQwXwc4g
         fTsN9aawdaS8CDjDDK+N/3PS6ucJh95zrCmjjux61fAQVZ94iIC4hEBhV0CkdCYNe/py
         mudEl2qJQoYQpsK4m2ngjuLKj5BhJAhBU6GTBf68I7boMs/yj1PfcSEyI0WwVypzX4lK
         7NsFeAC2SDBgcx6lidnatDUtlOQ6ON8g9LwYY7YZrEEn4h+WQKb4XzyWvrlKdWkYNfrK
         muOEvpS5T0cW0USDeS3lOO5XvaE/4BPuCVmvWP4IIaFB4iRtB+7EDYz1v+OcBTCZi211
         4dSA==
X-Gm-Message-State: AFqh2kqeygScxVQG+9AfzKcyPP5TiA7V0jd4k/lQYmQGN1IClXkHy/no
        Fdg9Yx6owR6nD/GJhyycPg8=
X-Google-Smtp-Source: AMrXdXtpbBHEu+sRHK+9sENr7APamiKs+e1RqZk8NOg21UfvDV/t7UgFQd4c/rJCC0/2emd5IbaJbg==
X-Received: by 2002:a05:6a20:3d18:b0:aa:5fed:8d6 with SMTP id y24-20020a056a203d1800b000aa5fed08d6mr116861886pzi.15.1673598516624;
        Fri, 13 Jan 2023 00:28:36 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id d2-20020aa797a2000000b005895f9657ebsm8452638pfq.70.2023.01.13.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:28:35 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 858FD103F81; Fri, 13 Jan 2023 15:28:32 +0700 (WIB)
Date:   Fri, 13 Jan 2023 15:28:32 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, krisman@collabora.com,
        tglx@linutronix.de, luto@kernel.org, oleg@redhat.com,
        peterz@infradead.org, ebiederm@xmission.com,
        akpm@linux-foundation.org, adobriyan@gmail.com, corbet@lwn.net,
        shuah@kernel.org, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 3/3] prctl,syscall_user_dispatch: add a getter for
 configuration info
Message-ID: <Y8EWMIwSh+C9vI9H@debian.me>
References: <20230109153348.5625-1-gregory.price@memverge.com>
 <20230109153348.5625-4-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yA8dJtpF3fHzClWq"
Content-Disposition: inline
In-Reply-To: <20230109153348.5625-4-gregory.price@memverge.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--yA8dJtpF3fHzClWq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 09, 2023 at 10:33:48AM -0500, Gregory Price wrote:
> This patch implements simple getter interface for syscall user dispatch
> configuration info.

s/This patch implements/Implement/

> +
> +A thread can fetch the current Syscall User Dispatch configuration with =
the following prctl:

This should have been ended with double colon (::) to make below code code
block, to be consistent with syscall_user_dispatch definition below.

> +
> +  prctl(PR_GET_SYSCALL_USER_DISPATCH, <dispatch_config>))
> +
> +<dispatch_config> is a pointer to a ``struct syscall_user_dispatch`` as =
defined in ``linux/include/linux/syscall_user_dispatch.h``::
> +
> +  struct syscall_user_dispatch {
> +        char __user *selector;
> +        unsigned long offset;
> +        unsigned long len;
> +        bool    on_dispatch;
> +  };
> +

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--yA8dJtpF3fHzClWq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8EWMAAKCRD2uYlJVVFO
o5QKAQDwk44puo8nMY7eLSJ3hT/GfAVGstunBN+zZ7mX3dq2ygD/cYErO9aAo5O0
OHm/XR0ibobn02a7AgPe/exot2A2Pwo=
=Rh/d
-----END PGP SIGNATURE-----

--yA8dJtpF3fHzClWq--
