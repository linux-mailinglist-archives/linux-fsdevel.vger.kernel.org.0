Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672175676CD
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jul 2022 20:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbiGESs0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jul 2022 14:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiGESsY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:48:24 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473851E2
        for <linux-fsdevel@vger.kernel.org>; Tue,  5 Jul 2022 11:48:21 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id 5so5841809plk.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Jul 2022 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BSbXCfRZzu1sc0QuV1HkqqBljeY0zd38lwwZDh0JnJo=;
        b=Kd3cpipzlwnLlnKJdcxPG025r3TV9ZWDL3aoqgYfurx5lzDvGaGX6BfmdHnPHDcvgt
         L8l8pOu5ADDKplKfhC9gddERsmEvM0OaGl9+IrErYXh5YDbD79yVw0nUj7fqRJWhY54d
         TsDVr6Hx3Ff9rvr7l//f6QsgivhiFy3t7DYMJSSDTfMbwQujMpA43mfepIefrWrITL9h
         6nKfst5ovb+aJRGhUGNYtuUFRUR5HLOqF0u4XFsH5szb2dBeLlKmIWVN1UW9P+F6bho6
         zz7weIyxss9qXo1Lp1m8hHl9nZinzypxQg2g5mT0mYlNlk3dBW8vtIsbwCfRXJjM/Q4q
         8Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BSbXCfRZzu1sc0QuV1HkqqBljeY0zd38lwwZDh0JnJo=;
        b=mnNJWe0BCm5xm/lAJny5y0AfTw3SEdN7HHRWhCjfueuKshb0UMEPhcOWyKHvdte19/
         zga21kTA9jOzOBhsdQ9ET4TPk7tbCvoydcQIetuAioglleyRD9NzQOlwmpd8P+amfSJH
         Use8Mo9E1FSJ/9FBwiOc8NaJkRhiGvSrQli2SODgab8MHA8YTUHRvRQP2eIflVYkXr4J
         t3cHdLpKd4SjluxjIafmrjmCIBAub5EOEEyzhWS+mHLyVc/oQsulnbQgA/DowKPjmBKt
         CzCKjg6oamgmeayg+qRBdnO0naBVNp+1/OViTEoFnhuqe6YNAotrSnqBNfQhh4b56+qc
         WHWQ==
X-Gm-Message-State: AJIora/LbsRgheK9pvAXOMZrWJobQG12987LJqF9SdEykaj9ZX+1P0xQ
        +yve9dUsjMfE4kJnCeXONq45Of7ZnvUXkWq+
X-Google-Smtp-Source: AGRyM1sxnzrQt04QNWvyPseXhRPtfc0YDoXI6e9lhzpzrHLkgjmCcHcFZz2sRm0/5o54Dzag9tgBoA==
X-Received: by 2002:a17:90b:1e02:b0:1ec:d979:4a8e with SMTP id pg2-20020a17090b1e0200b001ecd9794a8emr42406028pjb.181.1657046900696;
        Tue, 05 Jul 2022 11:48:20 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id z15-20020a1709027e8f00b0015e8d4eb273sm7258665pla.189.2022.07.05.11.48.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2022 11:48:20 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FC073359-35EA-4F86-AA9C-8419919CB37C@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_981A43CC-F6C0-4259-9094-62E96A5B913D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [man-pages PATCH RESEND] statx.2: correctly document STATX_ALL
Date:   Tue, 5 Jul 2022 12:48:18 -0600
In-Reply-To: <20220705183614.16786-1-ebiggers@kernel.org>
Cc:     linux-man@vger.kernel.org,
        Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org
To:     Eric Biggers <ebiggers@kernel.org>
References: <20220705183614.16786-1-ebiggers@kernel.org>
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


--Apple-Mail=_981A43CC-F6C0-4259-9094-62E96A5B913D
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 5, 2022, at 12:36 PM, Eric Biggers <ebiggers@kernel.org> wrote:
> 
> From: Eric Biggers <ebiggers@google.com>
> 
> Since kernel commit 581701b7efd6 ("uapi: deprecate STATX_ALL"),
> STATX_ALL is deprecated.  It doesn't include STATX_MNT_ID, and it won't
> include any future flags.  Update the man page accordingly.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> man2/statx.2 | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/man2/statx.2 b/man2/statx.2
> index a8620be6f..561e64f7b 100644
> --- a/man2/statx.2
> +++ b/man2/statx.2
> @@ -244,8 +244,9 @@ STATX_SIZE	Want stx_size
> STATX_BLOCKS	Want stx_blocks
> STATX_BASIC_STATS	[All of the above]
> STATX_BTIME	Want stx_btime
> +STATX_ALL	The same as STATX_BASIC_STATS | STATX_BTIME.
> +         	This is deprecated and should not be used.
> STATX_MNT_ID	Want stx_mnt_id (since Linux 5.8)
> -STATX_ALL	[All currently available fields]
> .TE
> .in
> .PP
> 
> base-commit: 88646725187456fad6f17552e96c50c93bd361dc
> --
> 2.37.0
> 


Cheers, Andreas






--Apple-Mail=_981A43CC-F6C0-4259-9094-62E96A5B913D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmLEh3IACgkQcqXauRfM
H+Bybw/+Pfq6HNtfpFER9B59gYEuQP9dk44QUXQXTQ/3vFIumU4EpsN6GE61QNr7
8GFr105CssEsBaN7Vp8X8lfbvbOi8T2G11kU/N8DUoCGIrJH9QLMdCxPxJSUg2jr
QTVf5NU3+JH1ouZJCDr5j+OlyorweejdDYbth++JUH+REIPyq0oFNNvrqd1as5Cm
9DWsqBHHLFkeuErjmzJSBapqt2ckzUFe0I6qoVRfgFWz+UiOVW3eo954dF1FYcP4
OeTzwnwU2Y9j+tXIvaTENiTuzpaA9WxJFcdZqJWtkUVCFdIbjkP15fN58+PN0foD
+kAxLeXuisHGiny2KED3pdfiJqzDE7UGAjzvGhkVStoRuuv5BRqUOOOQ1aDcNVaP
dFyLU+7i2X+E8WM8vyqUgpBG7v+cCm+CUVopPllcpgxbecnjKqcbT9g9eg+N5bwm
W7r80rwO0YUdIEKU3zfe8sxHarOF+DVM4KznAl+zNO90zcZWbWDuD5joxVnrDBk/
QcQdxgeW+oJC0GXSHWBbaiFwnZnagOKkWps9ogb06DWMRmmWFQXPc3RuT7UDbR4G
TPi2VdqxzAhFUjeiLyVwl292I1c5I+xPnoCx1laiys+wlTRJhTf6a7wQcRFOdn02
B1fnurJYzG9bzVNL8auPbSVuix8fFo/qrpxVuQokCU9VoLONZho=
=d8bg
-----END PGP SIGNATURE-----

--Apple-Mail=_981A43CC-F6C0-4259-9094-62E96A5B913D--
