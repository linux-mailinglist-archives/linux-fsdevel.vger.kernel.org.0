Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC5459F679
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Aug 2022 11:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236157AbiHXJiw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Aug 2022 05:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236374AbiHXJie (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:38:34 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6001796742;
        Wed, 24 Aug 2022 02:38:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w138so13337041pfc.10;
        Wed, 24 Aug 2022 02:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=SKcPpqHKjW4e2dhAdJ5zvkqLvQknUi1MfWlt2XH7w80=;
        b=h9RlhLc54hOltb+I54bC5StmQ37NtKmehwI/TwS0dzGaCKZD05iCyNGSpEg32HWW0z
         3HheDjW0jnjnBqwmR0ywQsIfPY30imJC8OoEXKBm11Kv0XmWmKo2hQwsU54+ZyB7+6d+
         ZlBNQeaUriKgIpkCck03aEk+XtmH0m5HntfEz0fwHNtUBSHPmwKqObYiFwQsaAlRjxWP
         WR1yRSzf6N0KIgQFSljyFssDPR3CnVT31xiQ4QYaf9qLi4clcaiIFc9V6HklueBlMPYb
         G/I7wdhqR68fH4Hv7sy59Xk9N7VoqiVSg7DxDAdNFDOGTamwV0acq1nuXCehDIt5H/BG
         F6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SKcPpqHKjW4e2dhAdJ5zvkqLvQknUi1MfWlt2XH7w80=;
        b=StLtdT7FKJIt29Ol0OWFyzAb5lnEKR1QY8oMDNojfllhygpNacbQGYIS6QvDumC51J
         eNe5YEt1+Vp25izInIzxhRSfXBw5sP0JVX/ain8OYO/k1w+YHgG87BrODZBi2gXvDxMM
         dLfx8WvFD89tILSzEdKw5JrkYRKDPG2lyYI5AmQwfaNUWsGkFvxgM//kViBAWy/PkyDV
         wAlMnyAD7kktdZLB6wRCqS1U7gCauv71AISVDgLuhGn0vF8FUQtRimzzO3kcH+GYOAYB
         3XtM9Jr0n539tP7ac+Z4TftvO+qMGqEDbhy7d1KHuLaQoLs60UTTbyhQyE7m8PEz3FBD
         +S1w==
X-Gm-Message-State: ACgBeo35Ja/bwPBYBONYL1zTN6bbB8DEMq/NKz9xr0Gj1MociIsBwCNk
        oK4mhoCZgml4d4BMcLZkS2g=
X-Google-Smtp-Source: AA6agR7YCKWuZ9M6+27u0mPvnyXfOLCELSkowfRppRNp4tSNBgB+dNOwgPdc1czPKWmmQmhsT0ol2A==
X-Received: by 2002:a05:6a00:ac6:b0:530:3197:48b6 with SMTP id c6-20020a056a000ac600b00530319748b6mr29136227pfl.80.1661333911296;
        Wed, 24 Aug 2022 02:38:31 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-21.three.co.id. [180.214.233.21])
        by smtp.gmail.com with ESMTPSA id mt4-20020a17090b230400b001fb18855440sm914547pjb.31.2022.08.24.02.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 02:38:30 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CDFA210119B; Wed, 24 Aug 2022 16:38:26 +0700 (WIB)
Date:   Wed, 24 Aug 2022 16:38:26 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     xu xin <cgel.zte@gmail.com>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, adobriyan@gmail.com,
        willy@infradead.org, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH v3 2/2] ksm: add profit monitoring documentation
Message-ID: <YwXxkqTM66aO1Y9l@debian.me>
References: <20220824070559.219977-1-xu.xin16@zte.com.cn>
 <20220824070821.220092-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6K/xkb9YUOfBCWvM"
Content-Disposition: inline
In-Reply-To: <20220824070821.220092-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--6K/xkb9YUOfBCWvM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 24, 2022 at 07:08:21AM +0000, xu xin wrote:
> +1) How to determine whether KSM save memory or consume memory in system-=
wide
> +range? Here is a simple approximate calculation for reference:
> +
> +	general_profit =3D~ pages_sharing * sizeof(page) - (all_rmap_items) *
> +	         sizeof(rmap_item);
> +
> +where all_rmap_items can be easily obtained by summing ``pages_sharing``,
> +``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
> +
> +2) The KSM profit inner a single process can be similarly obtained by the
> +following approximate calculation:
> +
> +	process_profit =3D~ ksm_merging_sharing * sizeof(page) -
> +			  ksm_rmp_items * sizeof(rmap_item).
> +

The profit formula above can be put into code blocks. Also, align the
numbered list texts, like:

---- >8 ----

diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-gui=
de/mm/ksm.rst
index 40bc11f6fa15fa..7e3092fe407e37 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -194,22 +194,22 @@ be merged, but some may not be abled to be merged aft=
er being checked
 several times, which are unprofitable memory consumed.
=20
 1) How to determine whether KSM save memory or consume memory in system-wi=
de
-range? Here is a simple approximate calculation for reference:
+   range? Here is a simple approximate calculation for reference::
=20
 	general_profit =3D~ pages_sharing * sizeof(page) - (all_rmap_items) *
 	         sizeof(rmap_item);
=20
-where all_rmap_items can be easily obtained by summing ``pages_sharing``,
-``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
+   where all_rmap_items can be easily obtained by summing ``pages_sharing`=
`,
+   ``pages_shared``, ``pages_unshared`` and ``pages_volatile``.
=20
 2) The KSM profit inner a single process can be similarly obtained by the
-following approximate calculation:
+   following approximate calculation::
=20
 	process_profit =3D~ ksm_merging_sharing * sizeof(page) -
 			  ksm_rmp_items * sizeof(rmap_item).
=20
-where both ksm_merging_sharing and ksm_rmp_items are shown under the direc=
tory
-``/proc/<pid>/``.
+   where both ksm_merging_sharing and ksm_rmp_items are shown under the
+   directory ``/proc/<pid>/``.
=20
 From the perspective of application, a high ratio of ``ksm_rmp_items`` to
 ``ksm_merging_sharing`` means a bad madvise-applied policy, so developers =
or

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--6K/xkb9YUOfBCWvM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYwXxiQAKCRD2uYlJVVFO
o9aKAQCeUXLi0ItbLyz2LIdrV2OFgXZOlmIWc6VYlyKgeBA9UAD5AVrDVXP2Ew0h
0AKb+kU+/YVqox6NvvlZm0p6IPiuLAg=
=v9oU
-----END PGP SIGNATURE-----

--6K/xkb9YUOfBCWvM--
