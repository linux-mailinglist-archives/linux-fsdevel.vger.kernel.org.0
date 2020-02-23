Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634FC1696B9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Feb 2020 09:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgBWIHu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 23 Feb 2020 03:07:50 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:34892 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726208AbgBWIHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 23 Feb 2020 03:07:50 -0500
Received: from mr1.cc.vt.edu (mr1.cc.ipv6.vt.edu [IPv6:2607:b400:92:8300:0:31:1732:8aa4])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01N87mu0021572
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 03:07:48 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
        by mr1.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 01N87hBJ010337
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 03:07:48 -0500
Received: by mail-qk1-f198.google.com with SMTP id k133so5928441qke.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Feb 2020 00:07:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=xr+dDzI9JDrsuRpKKcdMlTjc/FX5VYBQYyf/vKZ+Y+k=;
        b=fTlN7L9jMLnCJjc2HbOx/MWtNwnpGjh7HlBcwoXqHaaNu0Aw5clTOTZvZ8ZmFvgUZu
         aBw3Dnp1BBBnBW6weg93r+3d4gWio8XRY2pQRAdDAwZLp+OKRq2hI8r9wwkIKdztLtlT
         gU3AJB0FYXjyxwo7qjswNkcxNcK2lpefFMyjSLBdZN8SRwF5x98gN7UcgVf2gaWFCaBU
         WSl8BQG5NvPW6wDXME2B0weLuiV3tUAfjoFpIT0gdm7vFANNRwjEWJ3nBqRAnNXzRW9m
         oe5rrsKMeeg2/YxS60lipV6tt0DxzLqtw+c93cxvFY0ybzDTqF8rWgzSzDDvKE2vd7hc
         m5XQ==
X-Gm-Message-State: APjAAAWEKJXnk2+QYJLkZng4Xu99LdW7c8mWBQdAj9TG9f43EdqwAFRB
        dizTCOdtpN0qNaP3tzgCsfih5+cYRb3JsIf5YmDhxloLbt8w4SM+1xhH0sn9YN1gLAkjbOg1BXY
        Q5ceQ4+7gPkWizUMVD33d0TnX/ttXYasUyWQH
X-Received: by 2002:ae9:e207:: with SMTP id c7mr41501809qkc.128.1582445263657;
        Sun, 23 Feb 2020 00:07:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUbNtLeeLWsKBubaqRUN1o+nqZ96PrUxD1hYlN1VBbq91UR6oUeFaiEmFjwwDt0lm9qBstgg==
X-Received: by 2002:ae9:e207:: with SMTP id c7mr41501787qkc.128.1582445263393;
        Sun, 23 Feb 2020 00:07:43 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id o7sm4256962qkd.119.2020.02.23.00.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 00:07:42 -0800 (PST)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kaaira Gupta <kgupta@es.iitr.ac.in>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: exfat: remove exfat_fat_sync()
In-Reply-To: <20200219161738.GA22282@kaaira-HP-Pavilion-Notebook>
References: <20200219161738.GA22282@kaaira-HP-Pavilion-Notebook>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1582445261_2081P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Sun, 23 Feb 2020 03:07:41 -0500
Message-ID: <225301.1582445261@turing-police>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--==_Exmh_1582445261_2081P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Feb 2020 21:47:38 +0530, you said:
> exfat_fat_sync() is not called anywhere, hence remove it from
> exfat_cache.c and exfat.h

Yes, it's a leftover from the fat/vfat support that got taken out.

Acked-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

--==_Exmh_1582445261_2081P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXlIyzAdmEQWDXROgAQKS3xAAvMVO5+PRiwz05fvVZ6rxxmqLw7nTxig6
PLLEw4hV86kyStXxxsUTkeT68F/nIT/FgqBc7eB8gSXLB7te/w/4VeZAmfM7j979
jJq2MZkNyrsONGnZwu6y+0MU9HXZw5ITanxlG+zVK3Y7YFKvK022W0jaBQLKx4pG
aUGdnHwKRkzdOHs4eSEI/VuEb4FadQ4GMCbdXvm0C1D5ifN9mcfqMGOCmAu8VmOv
/IB1dqKcKuPcQ2HBU+jvra74ovNAsXbtQ5f+fpJOov/cUYgv7CdvrIzSm6f/z9N9
faXxQ4DuO2c+muF1U7V7fMSwuhXxxPBEOQw/Ek3cnRVyW0T4O7IodPMfLsifqX9Z
1FWYcRCzu4tx6VsVqijuJX6BUYmVZu1UDevbZxcvEil5SGG2EYCn9F77aLVrtyVc
QgfdjdMNdrdAJg2GWTn2BDuqaz9G2UgRJRMz+/JjKaB23HohzJuOc5pxJH4LAsb7
45z9ayLUBRBRV2w5MUODKQLdeZiNvZLLalOlyiS7+sTo6N4ivX0DqHjoTGnaYA6i
UDq2Wv9pnIN4QRp+yCunl30YgqXLyY+deCL7hL02ofwYKKwVRgAnfRBMajKINtuq
FCMAcGX1hhZYvfSeRCkoBAiNNoQley8RGlguJWwVdAdfu5Yy4zyOtVePMAggyjLv
BMcwJcDQPuI=
=xN/F
-----END PGP SIGNATURE-----

--==_Exmh_1582445261_2081P--
