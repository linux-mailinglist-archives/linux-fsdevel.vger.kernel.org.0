Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6492E2A3805
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 01:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgKCAuw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 19:50:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgKCAuw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 19:50:52 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CF4C0617A6
        for <linux-fsdevel@vger.kernel.org>; Mon,  2 Nov 2020 16:50:52 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id i26so12299657pgl.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 02 Nov 2020 16:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=88pPz8pjG9ldMk/QPG8AG1B3fhppK1H+mRg4pHEfEDY=;
        b=1k2NkodrGPaxaU9oyah8UzNCYDEjpiiMMa7MvUQjERWh2F0VYVGB5169Mw6v3TgA0c
         JQsr9tlgrZ+t1wnwpeecRBbR5M3gd9hUJt106Eoia087zbWUQVbl/Bi1n9hVioYWZ0w7
         fX/421EOWL6KBOkjpWZ9TJfM7L3gDVX7WzM7zM3jz4BRAE8IED8hP+lkj3RMMLDsgR8d
         LGs6sLPP10nDUtqLPUtSUXrSaBi1Mil7wCY8aYrH1d5ZlspyAvMH9ZigKDXsKCVczlU8
         CX3L99Lzpz5UyYdSDrk7kQCZ6am8s0Ut22KjziIozS7LncvwTn0XKY/SKjivU7WvZ5uo
         7Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=88pPz8pjG9ldMk/QPG8AG1B3fhppK1H+mRg4pHEfEDY=;
        b=WbjKf1QGDPFuxLGBba15sefjwbDnEUzNSR7w+zeHIYQLCxDsNg22MJlfprHzFT/V5/
         LTDdejHg6tubJHsuK6ptNxhn61+Vo2Zxd//b1KCkC4nrzDtvVhnmvjNtkIrbpOvnkPZx
         p1frYhCq5mayKhu/glVXW9ckpXIRt+erC2styJcADwcRKasKhFdVJnI6JDu2V1j2ALK2
         aOXiLGS7h7C708SF6WJb9xN7Z+KJ5OzfPBuXDUu1N7nt6V8HUqu5HzQruexHA93CZvFM
         N/HEVM21ZDHeIMT+cmEOMJazdLdjJKerYt3wolOK+zh3esK8o4GGJLzrpEyvSHVjyD6V
         AwHg==
X-Gm-Message-State: AOAM533IT6lL6sg0F63H13u4ocPcXyu/wus31cebl7s/wgS6VPnYfrVF
        V11xYRWnubYzRXHEnBe5dG3kWA==
X-Google-Smtp-Source: ABdhPJxM/pu1RvNOaweW8wC2Ba4h+teEI9+8lduTdju3ypNFoMZ1Qu82nr06w8S5qyJ0yIfxRL6NpA==
X-Received: by 2002:a63:3c1c:: with SMTP id j28mr7599809pga.167.1604364651496;
        Mon, 02 Nov 2020 16:50:51 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 132sm2840358pfy.15.2020.11.02.16.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 16:50:50 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7CCB9FA6-DE85-4E3F-B3F1-7144F01589D4@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_371D7085-4417-47D2-9B58-9CE8331344FA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] fs/aio.c: Cosmetic
Date:   Mon, 2 Nov 2020 17:50:46 -0700
In-Reply-To: <20201102215809.17312-1-colomar.6.4.3@gmail.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alejandro Colomar <colomar.6.4.3@gmail.com>
References: <20201102152439.315640-1-colomar.6.4.3@gmail.com>
 <20201102215809.17312-1-colomar.6.4.3@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--Apple-Mail=_371D7085-4417-47D2-9B58-9CE8331344FA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 2, 2020, at 2:58 PM, Alejandro Colomar <colomar.6.4.3@gmail.com> =
wrote:
> Changes:
> - Consistently use 'unsigned int', instead of 'unsigned'.
> - Add a blank line after variable declarations.
> - Move variable declarations to the top of functions.
> - Add a blank line at the top of functions if there are no =
declarations.

I'd agree that the other changes are following kernel coding style, but
I've never heard of leaving a blank line at the start of functions =
without
any local variables.  I don't see anything in process/coding-style.rst =
to
support this change, nor are the majority of variable-less functions
formatted this way, and it seems to just be a waste of vertical space.

Cheers, Andreas






--Apple-Mail=_371D7085-4417-47D2-9B58-9CE8331344FA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+gqWcACgkQcqXauRfM
H+A9QA/7BMfqa7d4Rxvdvr8ROUPltUp3AL93VOvAfuFCPAZK9O356Qo3SdLHFBKP
GFbyf1idAIL+e71wdJuRGwE3nD2q1OUl5c7K8ajjRNtuxO8FIahqjhfrSbnwsLwl
a4QiO6uZRTA9q8ByeXvCQntnkHqSTFg1GZO8OCvVaT/nv6YP0DLu2AwIJaIdcjme
5HSPh6BG8YlIOq13GbLb1JxQwbYUViszEW1pHQ4uDxMcXnZR4icUabandQ7Kat3m
4mH4M3n3ti6Lh7Sf+enajsznZAXeVCaRCgk2OklyymNzl8jYduKNrOPBo4jK8yU2
0knidVldo16pa0f7nGrhbYG3nUO+gYXVrF7nO2SwUj3k1AAU1sHvh1kR9sZ8r+eJ
53qqFdSHkCKK+cWj5PtBMwC/ljEiDU3oMrM/X25giKKxLV2GdKe+hGy+MphghhZL
3TYNHYdeUiVhIIzW9U+kZEWdK89hqSplC7B3xMF1ubzRJkcX6WD6o1iB8z0kERWr
eUZMQeMpLOR/vFGdks3+Z0hgS9IqbtPtk9guJlFVGqkY5r023lT8w4kWmpDubuDa
XzNkPu/j3TZ2oVmCgzzzi01ckZ9l/u9elOtzjFv16QOQLcjAatSbgg36ixNVbC50
SiR+OMMNYmPSBfl4p0g2fg5e/aUOAvqNPcVWcp/6++t+nWf8AMM=
=HCM2
-----END PGP SIGNATURE-----

--Apple-Mail=_371D7085-4417-47D2-9B58-9CE8331344FA--
