Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAF625788
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Nov 2022 11:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbiKKKBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Nov 2022 05:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiKKKBG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:01:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FE712A9D;
        Fri, 11 Nov 2022 02:01:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 63C4FB824B3;
        Fri, 11 Nov 2022 10:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD66C433C1;
        Fri, 11 Nov 2022 10:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668160861;
        bh=J/SNzBV26xb9ZimfbKHbIygGDSH+VKjLiTdatAabHUg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CWAMCDwd0DNVCl2n+7x7qRgOt8XV8Dum5DDdsSz+t1u5huY/MLARrguHiUdUkHO53
         +8ZOASRWR+VcG2m3itoXLWX7f4ESIiKjnlXkrqR4Us/XzwMZ7oGB5sPhAwfr3+JvH/
         5sgkZVhebQlU7SeOoUmHSJXHf+145tg4HjnrD4Yx6tEi1i6m39+in4gusS61XdjiDD
         vIqI3X0q0mi6pj9MVKX8X7Dn4R8AULo0/paUx3NC5YVGCN5JC07HmeJaUYTdbao34g
         ZnWvPXTgMqfNCngRNgLD5SJ97W3IwLHPJMLamNWBjnz3GjUDlswBJ8isO/knD78mu4
         BBCC1c1HKu5bw==
Message-ID: <a2409d054aab173dbff062b41b3add1dcd3c9b45.camel@kernel.org>
Subject: Re: [PATCH v3 13/15] fcntl: remove FASYNC_MAGIC
From:   Jeff Layton <jlayton@kernel.org>
To:     Ahelenia =?UTF-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 11 Nov 2022 05:00:58 -0500
In-Reply-To: <756e6016fab23e95d891b6284fbf52184135ee46.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
References: <cover.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
         <756e6016fab23e95d891b6284fbf52184135ee46.1668128257.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2022-11-11 at 02:14 +0100, Ahelenia Ziemia=C5=84ska wrote:
> We have largely moved away from this approach, and we have better
> debugging instrumentation nowadays: kill it.
>=20
> Link: https://lore.kernel.org/linux-doc/YyMlovoskUcHLEb7@kroah.com/
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>
> ---
>  Documentation/process/magic-number.rst                    | 1 -
>  Documentation/translations/it_IT/process/magic-number.rst | 1 -
>  Documentation/translations/zh_CN/process/magic-number.rst | 1 -
>  Documentation/translations/zh_TW/process/magic-number.rst | 1 -
>  fs/fcntl.c                                                | 6 ------
>  include/linux/fs.h                                        | 3 ---
>  6 files changed, 13 deletions(-)
>=20
> diff --git a/Documentation/process/magic-number.rst b/Documentation/proce=
ss/magic-number.rst
> index e59c707ec785..6e432917a5a8 100644
> --- a/Documentation/process/magic-number.rst
> +++ b/Documentation/process/magic-number.rst
> @@ -68,6 +68,5 @@ Changelog::
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  Magic Name            Number           Structure                File
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/translations/it_IT/process/magic-number.rst b/=
Documentation/translations/it_IT/process/magic-number.rst
> index 37a539867b6f..7d4c117ac626 100644
> --- a/Documentation/translations/it_IT/process/magic-number.rst
> +++ b/Documentation/translations/it_IT/process/magic-number.rst
> @@ -74,6 +74,5 @@ Registro dei cambiamenti::
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  Nome magico           Numero           Struttura                File
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/translations/zh_CN/process/magic-number.rst b/=
Documentation/translations/zh_CN/process/magic-number.rst
> index 8a3a3e872c52..c17e3f20440a 100644
> --- a/Documentation/translations/zh_CN/process/magic-number.rst
> +++ b/Documentation/translations/zh_CN/process/magic-number.rst
> @@ -57,6 +57,5 @@ Linux =E9=AD=94=E6=9C=AF=E6=95=B0
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  =E9=AD=94=E6=9C=AF=E6=95=B0=E5=90=8D              =E6=95=B0=E5=AD=97    =
         =E7=BB=93=E6=9E=84                     =E6=96=87=E4=BB=B6
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/Documentation/translations/zh_TW/process/magic-number.rst b/=
Documentation/translations/zh_TW/process/magic-number.rst
> index 7ace7834f7f9..e2eeb74e7192 100644
> --- a/Documentation/translations/zh_TW/process/magic-number.rst
> +++ b/Documentation/translations/zh_TW/process/magic-number.rst
> @@ -60,6 +60,5 @@ Linux =E9=AD=94=E8=A1=93=E6=95=B8
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>  =E9=AD=94=E8=A1=93=E6=95=B8=E5=90=8D              =E6=95=B8=E5=AD=97    =
         =E7=B5=90=E6=A7=8B                     =E6=96=87=E4=BB=B6
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> -FASYNC_MAGIC          0x4601           fasync_struct            ``includ=
e/linux/fs.h``
>  CCB_MAGIC             0xf2691ad2       ccb                      ``driver=
s/scsi/ncr53c8xx.c``
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> diff --git a/fs/fcntl.c b/fs/fcntl.c
> index 146c9ab0cd4b..e366a3804108 100644
> --- a/fs/fcntl.c
> +++ b/fs/fcntl.c
> @@ -924,7 +924,6 @@ struct fasync_struct *fasync_insert_entry(int fd, str=
uct file *filp, struct fasy
>  	}
> =20
>  	rwlock_init(&new->fa_lock);
> -	new->magic =3D FASYNC_MAGIC;
>  	new->fa_file =3D filp;
>  	new->fa_fd =3D fd;
>  	new->fa_next =3D *fapp;
> @@ -988,11 +987,6 @@ static void kill_fasync_rcu(struct fasync_struct *fa=
, int sig, int band)
>  		struct fown_struct *fown;
>  		unsigned long flags;
> =20
> -		if (fa->magic !=3D FASYNC_MAGIC) {
> -			printk(KERN_ERR "kill_fasync: bad magic number in "
> -			       "fasync_struct!\n");
> -			return;
> -		}
>  		read_lock_irqsave(&fa->fa_lock, flags);
>  		if (fa->fa_file) {
>  			fown =3D &fa->fa_file->f_owner;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e654435f1651..acfd5db5341a 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1345,15 +1345,12 @@ static inline int locks_lock_file_wait(struct fil=
e *filp, struct file_lock *fl)
> =20
>  struct fasync_struct {
>  	rwlock_t		fa_lock;
> -	int			magic;
>  	int			fa_fd;
>  	struct fasync_struct	*fa_next; /* singly linked list */
>  	struct file		*fa_file;
>  	struct rcu_head		fa_rcu;
>  };
> =20
> -#define FASYNC_MAGIC 0x4601
> -
>  /* SMP safe fasync helpers: */
>  extern int fasync_helper(int, struct file *, int, struct fasync_struct *=
*);
>  extern struct fasync_struct *fasync_insert_entry(int, struct file *, str=
uct fasync_struct **, struct fasync_struct *);

Reviewed-by: Jeff Layton <jlayton@kernel.org>
