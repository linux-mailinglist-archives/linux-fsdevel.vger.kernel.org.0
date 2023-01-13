Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1C5669188
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 09:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbjAMIrv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240624AbjAMIrg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:47:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991011B6;
        Fri, 13 Jan 2023 00:47:35 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s67so14534042pgs.3;
        Fri, 13 Jan 2023 00:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SfX4E9lAQTiCNe2WNeORIp1pzZfAvGpZpdGEvbDnlyc=;
        b=FA2PkXo40PTOZYx3fxDCAEVYqqt/aJ28vKXIT+/OG5gG88oxA3RIVnETZN+bp4ZJTF
         kyF53YHEl9t40vrkQqqETXN8inTGS/GMe4EEoLUx1hAkkkolxbDvYy7ArOSeRzTrAadX
         +xgr5ndeAafzqENk4iwuCSTvmiDLL5OiXiR0OUihm8UcITi7ymzpemY+6Xer5O3Bey9H
         q8pIxE4lqxveTlM1QggUyhuwQfiLJ6Ppgj4XjWH31yT50NbXPUg7tNMEuopybjx5R8xj
         8+l3dlLWgi5yioVMx+L3/6c8wMfp6k6Z65rS9ls7/E7LK6bz5pM2xzMtlM/clvCG3c40
         A+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SfX4E9lAQTiCNe2WNeORIp1pzZfAvGpZpdGEvbDnlyc=;
        b=BRG0G3kTNPll2e1J23Fjj9pThMrPmWLF/tvA3T3KPD42rbTyFaFL+f8zaRQhKcYsDS
         jCDBpJjlAD138T82/XcUX+M8kXDtHp1lEMCSpJKLKTFuVw3i2YOCc4Kq4MeL82z8Kb/P
         zjNMogMvpjJdfIAmGH2YhC5b5TERi6qio1VyvXHmaiSJC6V3STzMwtWwTKP8RWRehVG4
         WgmLCR3BJIUnztw3i8tLA6AmKVfLe/3ed0YWMUnnl5OVkd5/wp5OOzZN2pdtFIdu2pem
         td3U/o1jZmZEAnfll/rbpGGkRIQezkg1a8BDO+nroiEAuRKxf0nmJKVAv94Vwbh4dA1i
         sOfg==
X-Gm-Message-State: AFqh2koBnQskA7jO/tpNUaWRjxB2zD3mG1wjfBPO4l8pAtlJ3gQf1Ako
        sYd8pPvU7kb4P4+fltt+xPJYCdXM5Kk=
X-Google-Smtp-Source: AMrXdXsIT1IpsscVvp+29qA/1VxuWJa0lYCge8Y5cmbtwzE4RDuocftm8wsRks7SHyZbZ0aidvMNyA==
X-Received: by 2002:aa7:93cf:0:b0:58a:f300:42c9 with SMTP id y15-20020aa793cf000000b0058af30042c9mr13405587pff.22.1673599655122;
        Fri, 13 Jan 2023 00:47:35 -0800 (PST)
Received: from debian.me (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id x3-20020aa79563000000b005815533e156sm13197858pfq.44.2023.01.13.00.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 00:47:34 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id A121A104D0B; Fri, 13 Jan 2023 15:47:31 +0700 (WIB)
Date:   Fri, 13 Jan 2023 15:47:31 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     yang.yang29@zte.com.cn, akpm@linux-foundation.org,
        hannes@cmpxchg.org, willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iamjoonsoo.kim@lge.com, ran.xiaokai@zte.com.cn
Subject: Re: [PATCH linux-next v2] swap_state: update shadow_nodes for
 anonymous page
Message-ID: <Y8Eao1l0qRVLKK7e@debian.me>
References: <202301131550455361823@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FfqVFWjacRZfxsuZ"
Content-Disposition: inline
In-Reply-To: <202301131550455361823@zte.com.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--FfqVFWjacRZfxsuZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2023 at 03:50:45PM +0800, yang.yang29@zte.com.cn wrote:
> This patch updates shadow_nodes of anonymous page when swap
> cache is add or delete.

By what?

> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index cb9aaa00951d..7a003d8abb37 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -94,6 +94,8 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t =
entry,
>  	unsigned long i, nr =3D folio_nr_pages(folio);
>  	void *old;
>=20
> +	xas_set_update(&xas, workingset_update_node);
> +
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_swapcache(folio), folio);
>  	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
> @@ -145,6 +147,8 @@ void __delete_from_swap_cache(struct folio *folio,
>  	pgoff_t idx =3D swp_offset(entry);
>  	XA_STATE(xas, &address_space->i_pages, idx);
>=20
> +	xas_set_update(&xas, workingset_update_node);
> +
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  	VM_BUG_ON_FOLIO(!folio_test_swapcache(folio), folio);
>  	VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
> @@ -252,6 +256,8 @@ void clear_shadow_from_swap_cache(int type, unsigned =
long begin,
>  		struct address_space *address_space =3D swap_address_space(entry);
>  		XA_STATE(xas, &address_space->i_pages, curr);
>=20
> +		xas_set_update(&xas, workingset_update_node);
> +
>  		xa_lock_irq(&address_space->i_pages);
>  		xas_for_each(&xas, old, end) {
>  			if (!xa_is_value(old))

Adding xas_set_update() call?

In any case, please explain what you are doing above in imperative mood
(no "This patch does foo" but "Do foo" instead).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--FfqVFWjacRZfxsuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8EangAKCRD2uYlJVVFO
o/BdAQDMnNlScYe1V+iOgxiyUqa+4s6U6CuxgqAm32d4eSqx3AEAlj1BCKBcygkF
cWXy2GN8ry6qwub9QEaS1RFWFhC6Ews=
=a99s
-----END PGP SIGNATURE-----

--FfqVFWjacRZfxsuZ--
