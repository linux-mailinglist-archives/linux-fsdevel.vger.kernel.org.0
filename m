Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CADAD185CA1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 14:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgCON2g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Mar 2020 09:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:49970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgCON2f (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Mar 2020 09:28:35 -0400
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1E12205ED;
        Sun, 15 Mar 2020 13:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584278914;
        bh=6VL/H/fTc3ziDKl4ULVbrOSq8rNetGVmJTFMcpXCkwA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dUVX/eh5b6xSz6I7bSIs+vBQ4l/qg7PgUSe/uRoocsZteCanIj9ukl0cBTIogxVK+
         KWMZ0FuDC+ZMWizm0cjNAUNza9V59MH9b2fNuWS+agYgUwCIC02FfN5oLXS6iUWtQS
         LZMkQv0eh0/R510A+oxnybTBbZbQUmfX83W2j11M=
Date:   Sun, 15 Mar 2020 14:28:24 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Eric Biggers <ebiggers@google.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org,
        "Tobin C. Harding" <tobin@kernel.org>, kernel@vivo.com
Subject: Re: [PATCH 2/2] doc: zh_CN: add translation for virtiofs
Message-ID: <20200315142824.4860f4a8@coco.lan>
In-Reply-To: <20200315092810.87008-3-wenhu.wang@vivo.com>
References: <20200315092810.87008-1-wenhu.wang@vivo.com>
        <20200315092810.87008-3-wenhu.wang@vivo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Sun, 15 Mar 2020 02:28:00 -0700
Wang Wenhu <wenhu.wang@vivo.com> escreveu:

> Translate virtiofs.rst in Documentation/filesystems/ into Chinese.
>=20
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  Documentation/filesystems/virtiofs.rst        |  2 +
>  .../translations/zh_CN/filesystems/index.rst  |  2 +
>  .../zh_CN/filesystems/virtiofs.rst            | 62 +++++++++++++++++++
>  3 files changed, 66 insertions(+)
>  create mode 100644 Documentation/translations/zh_CN/filesystems/virtiofs=
.rst
>=20
> diff --git a/Documentation/filesystems/virtiofs.rst b/Documentation/files=
ystems/virtiofs.rst
> index 4f338e3cb3f7..7c4301d962f8 100644
> --- a/Documentation/filesystems/virtiofs.rst
> +++ b/Documentation/filesystems/virtiofs.rst
> @@ -1,3 +1,5 @@
> +.. _virtiofs_index:
> +
>  .. SPDX-License-Identifier: GPL-2.0

Please place the SPDX header at the top of the document.

Regards,
Mauro

> =20
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> diff --git a/Documentation/translations/zh_CN/filesystems/index.rst b/Doc=
umentation/translations/zh_CN/filesystems/index.rst
> index a47dd86d6196..205680ec790d 100644
> --- a/Documentation/translations/zh_CN/filesystems/index.rst
> +++ b/Documentation/translations/zh_CN/filesystems/index.rst
> @@ -25,3 +25,5 @@ Linux Kernel=E4=B8=AD=E7=9A=84=E6=96=87=E4=BB=B6=E7=B3=
=BB=E7=BB=9F
> =20
>  .. toctree::
>     :maxdepth: 2
> +
> +   virtiofs
> diff --git a/Documentation/translations/zh_CN/filesystems/virtiofs.rst b/=
Documentation/translations/zh_CN/filesystems/virtiofs.rst
> new file mode 100644
> index 000000000000..2a36cd417f8b
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/filesystems/virtiofs.rst
> @@ -0,0 +1,62 @@
> +.. raw:: latex
> +
> +	\renewcommand\thesection*
> +	\renewcommand\thesubsection*
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: :ref:`Documentation/filesystems/virtiofs.rst <virtiofs_index>`
> +
> +=E8=AF=91=E8=80=85
> +::
> +
> +	=E4=B8=AD=E6=96=87=E7=89=88=E7=BB=B4=E6=8A=A4=E8=80=85=EF=BC=9A =E7=8E=
=8B=E6=96=87=E8=99=8E Wang Wenhu <wenhu.wang@vivo.com>
> +	=E4=B8=AD=E6=96=87=E7=89=88=E7=BF=BB=E8=AF=91=E8=80=85=EF=BC=9A =E7=8E=
=8B=E6=96=87=E8=99=8E Wang Wenhu <wenhu.wang@vivo.com>
> +	=E4=B8=AD=E6=96=87=E7=89=88=E6=A0=A1=E8=AF=91=E8=80=85:  =E7=8E=8B=E6=
=96=87=E8=99=8E Wang Wenhu <wenhu.wang@vivo.com>
> +
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +virtiofs: virtio-fs =E4=B8=BB=E6=9C=BA<->=E5=AE=A2=E6=9C=BA=E5=85=B1=E4=
=BA=AB=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Copyright (C) 2019 Red Hat, Inc. =EF=BC=88=E8=AF=91=E8=80=85=E6=B3=A8=
=EF=BC=9A=E8=8B=B1=E6=96=87=E7=89=88=E7=89=88=E6=9D=83=E4=BF=A1=E6=81=AF=EF=
=BC=89
> +
> +=E4=BB=8B=E7=BB=8D
> +=3D=3D=3D=3D
> +Linux=E7=9A=84virtiofs=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=AE=9E=E7=
=8E=B0=E4=BA=86=E4=B8=80=E4=B8=AA=E5=8D=8A=E8=99=9A=E6=8B=9F=E5=8C=96VIRTIO=
=E7=B1=BB=E5=9E=8B=E2=80=9Cvirtio-fs=E2=80=9D=E8=AE=BE=E5=A4=87=E7=9A=84=E9=
=A9=B1=E5=8A=A8=EF=BC=8C=E9=80=9A=E8=BF=87=E8=AF=A5\
> +=E7=B1=BB=E5=9E=8B=E8=AE=BE=E5=A4=87=E5=AE=9E=E7=8E=B0=E5=AE=A2=E6=9C=BA=
<->=E4=B8=BB=E6=9C=BA=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=85=B1=E4=BA=AB=
=E3=80=82=E5=AE=83=E5=85=81=E8=AE=B8=E5=AE=A2=E6=9C=BA=E6=8C=82=E8=BD=BD=E4=
=B8=80=E4=B8=AA=E5=B7=B2=E7=BB=8F=E5=AF=BC=E5=87=BA=E5=88=B0=E4=B8=BB=E6=9C=
=BA=E7=9A=84=E7=9B=AE=E5=BD=95=E3=80=82
> +
> +=E5=AE=A2=E6=9C=BA=E9=80=9A=E5=B8=B8=E9=9C=80=E8=A6=81=E8=AE=BF=E9=97=AE=
=E4=B8=BB=E6=9C=BA=E6=88=96=E8=80=85=E8=BF=9C=E7=A8=8B=E7=B3=BB=E7=BB=9F=E4=
=B8=8A=E7=9A=84=E6=96=87=E4=BB=B6=E3=80=82=E4=BD=BF=E7=94=A8=E5=9C=BA=E6=99=
=AF=E5=8C=85=E6=8B=AC=EF=BC=9A=E5=9C=A8=E6=96=B0=E5=AE=A2=E6=9C=BA=E5=AE=89=
=E8=A3=85=E6=97=B6=E8=AE=A9=E6=96=87=E4=BB=B6=E5=AF=B9=E5=85=B6\
> +=E5=8F=AF=E8=A7=81=EF=BC=9B=E4=BB=8E=E4=B8=BB=E6=9C=BA=E4=B8=8A=E7=9A=84=
=E6=A0=B9=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=90=AF=E5=8A=A8=EF=BC=9B=E5=
=AF=B9=E6=97=A0=E7=8A=B6=E6=80=81=E6=88=96=E4=B8=B4=E6=97=B6=E5=AE=A2=E6=9C=
=BA=E6=8F=90=E4=BE=9B=E6=8C=81=E4=B9=85=E5=AD=98=E5=82=A8=E5=92=8C=E5=9C=A8=
=E5=AE=A2=E6=9C=BA=E4=B9=8B=E9=97=B4=E5=85=B1=E4=BA=AB=E7=9B=AE=E5=BD=95=E3=
=80=82
> +
> +=E5=B0=BD=E7=AE=A1=E5=9C=A8=E6=9F=90=E4=BA=9B=E4=BB=BB=E5=8A=A1=E5=8F=AF=
=E8=83=BD=E9=80=9A=E8=BF=87=E4=BD=BF=E7=94=A8=E5=B7=B2=E6=9C=89=E7=9A=84=E7=
=BD=91=E7=BB=9C=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=AE=8C=E6=88=90=EF=BC=
=8C=E4=BD=86=E6=98=AF=E5=8D=B4=E9=9C=80=E8=A6=81=E9=9D=9E=E5=B8=B8=E9=9A=BE=
=E4=BB=A5=E8=87=AA=E5=8A=A8=E5=8C=96=E7=9A=84=E9=85=8D=E7=BD=AE\
> +=E6=AD=A5=E9=AA=A4=EF=BC=8C=E4=B8=94=E5=B0=86=E5=AD=98=E5=82=A8=E7=BD=91=
=E7=BB=9C=E6=9A=B4=E9=9C=B2=E7=BB=99=E5=AE=A2=E6=9C=BA=E3=80=82=E8=80=8Cvir=
tio-fs=E8=AE=BE=E5=A4=87=E9=80=9A=E8=BF=87=E6=8F=90=E4=BE=9B=E4=B8=8D=E7=BB=
=8F=E8=BF=87=E7=BD=91=E7=BB=9C=E7=9A=84=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=
=E8=AE=BF=E9=97=AE=E6=96=87=E4=BB=B6\
> +=E7=9A=84=E8=AE=BE=E8=AE=A1=E6=96=B9=E5=BC=8F=E8=A7=A3=E5=86=B3=E4=BA=86=
=E8=BF=99=E4=BA=9B=E9=97=AE=E9=A2=98=E3=80=82
> +
> +=E5=8F=A6=E5=A4=96=EF=BC=8Cvirto-fs=E8=AE=BE=E5=A4=87=E5=8F=91=E6=8C=A5=
=E4=BA=86=E4=B8=BB=E5=AE=A2=E6=9C=BA=E5=85=B1=E5=AD=98=E7=9A=84=E4=BC=98=E7=
=82=B9=E6=8F=90=E9=AB=98=E4=BA=86=E6=80=A7=E8=83=BD=EF=BC=8C=E5=B9=B6=E4=B8=
=94=E6=8F=90=E4=BE=9B=E4=BA=86=E7=BD=91=E7=BB=9C=E6=96=87=E4=BB=B6=E7=B3=BB=
=E7=BB=9F=E6=89=80=E4=B8=8D=E5=85=B7=E5=A4=87
> +=E7=9A=84=E4=B8=80=E4=BA=9B=E8=AF=AD=E4=B9=89=E5=8A=9F=E8=83=BD=E3=80=82
> +
> +=E7=94=A8=E6=B3=95
> +=3D=3D=3D=3D
> +=E4=BB=A5``myfs``=E6=A0=87=E7=AD=BE=E5=B0=86=E6=96=87=E4=BB=B6=E7=B3=BB=
=E7=BB=9F=E6=8C=82=E8=BD=BD=E5=88=B0``/mnt``:
> +
> +.. code-block:: sh
> +
> +  guest# mount -t virtiofs myfs /mnt
> +
> +=E8=AF=B7=E6=9F=A5=E9=98=85 https://virtio-fs.gitlab.io/ =E4=BA=86=E8=A7=
=A3=E9=85=8D=E7=BD=AEQEMU=E5=92=8Cvirtiofsd=E5=AE=88=E6=8A=A4=E7=A8=8B=E5=
=BA=8F=E7=9A=84=E8=AF=A6=E7=BB=86=E4=BF=A1=E6=81=AF=E3=80=82
> +
> +=E5=86=85=E5=B9=95
> +=3D=3D=3D=3D
> +=E7=94=B1=E4=BA=8Evirtio-fs=E8=AE=BE=E5=A4=87=E5=B0=86FUSE=E5=8D=8F=E8=
=AE=AE=E7=94=A8=E4=BA=8E=E6=96=87=E4=BB=B6=E7=B3=BB=E7=BB=9F=E8=AF=B7=E6=B1=
=82=EF=BC=8C=E5=9B=A0=E6=AD=A4Linux=E7=9A=84virtiofs=E6=96=87=E4=BB=B6=E7=
=B3=BB=E7=BB=9F=E4=B8=8EFUSE=E6=96=87\
> +=E4=BB=B6=E7=B3=BB=E7=BB=9F=E5=AE=A2=E6=88=B7=E7=AB=AF=E7=B4=A7=E5=AF=86=
=E9=9B=86=E6=88=90=E5=9C=A8=E4=B8=80=E8=B5=B7=E3=80=82=E5=AE=A2=E6=9C=BA=E5=
=85=85=E5=BD=93FUSE=E5=AE=A2=E6=88=B7=E7=AB=AF=E8=80=8C=E4=B8=BB=E6=9C=BA=
=E5=85=85=E5=BD=93FUSE=E6=9C=8D=E5=8A=A1=E5=99=A8=EF=BC=8C=E5=86=85=E6=A0=
=B8=E4=B8=8E=E7=94=A8=E6=88=B7=E7=A9=BA\
> +=E9=97=B4=E4=B9=8B=E9=97=B4=E7=9A=84/dev/fuse=E6=8E=A5=E5=8F=A3=E7=94=B1=
virtio-fs=E8=AE=BE=E5=A4=87=E6=8E=A5=E5=8F=A3=E4=BB=A3=E6=9B=BF=E3=80=82
> +
> +FUSE=E8=AF=B7=E6=B1=82=E8=A2=AB=E7=BD=AE=E4=BA=8E=E8=99=9A=E6=8B=9F=E9=
=98=9F=E5=88=97=E4=B8=AD=E7=94=B1=E4=B8=BB=E6=9C=BA=E5=A4=84=E7=90=86=E3=80=
=82=E4=B8=BB=E6=9C=BA=E5=A1=AB=E5=85=85=E7=BC=93=E5=86=B2=E5=8C=BA=E4=B8=AD=
=E7=9A=84=E5=93=8D=E5=BA=94=E9=83=A8=E5=88=86=EF=BC=8C=E8=80=8C=E5=AE=A2=E6=
=9C=BA=E5=A4=84=E7=90=86=E8=AF=B7=E6=B1=82=E7=9A=84=E5=AE=8C=E6=88=90=E9=83=
=A8=E5=88=86=E3=80=82
> +
> +=E5=B0=86/dev/fuse=E6=98=A0=E5=B0=84=E5=88=B0=E8=99=9A=E6=8B=9F=E9=98=9F=
=E5=88=97=E9=9C=80=E8=A6=81=E8=A7=A3=E5=86=B3/dev/fuse=E5=92=8C=E8=99=9A=E6=
=8B=9F=E9=98=9F=E5=88=97=E4=B9=8B=E9=97=B4=E8=AF=AD=E4=B9=89=E4=B8=8A=E7=9A=
=84=E5=B7=AE=E5=BC=82=E3=80=82=E6=AF=8F=E6=AC=A1=E8=AF=BB=E5=8F=96\
> +/dev/fuse=E8=AE=BE=E5=A4=87=E6=97=B6=EF=BC=8CFUSE=E5=AE=A2=E6=88=B7=E7=
=AB=AF=E9=83=BD=E5=8F=AF=E4=BB=A5=E9=80=89=E6=8B=A9=E8=A6=81=E4=BC=A0=E8=BE=
=93=E7=9A=84=E8=AF=B7=E6=B1=82=EF=BC=8C=E4=BB=8E=E8=80=8C=E5=8F=AF=E4=BB=A5=
=E4=BD=BF=E6=9F=90=E4=BA=9B=E8=AF=B7=E6=B1=82=E4=BC=98=E5=85=88=E4=BA=8E=E5=
=85=B6=E4=BB=96\
> +=E8=AF=B7=E6=B1=82=E3=80=82=E8=99=9A=E6=8B=9F=E9=98=9F=E5=88=97=E6=9C=89=
=E5=85=B6=E9=98=9F=E5=88=97=E8=AF=AD=E4=B9=89=EF=BC=8C=E6=97=A0=E6=B3=95=E6=
=9B=B4=E6=94=B9=E5=B7=B2=E5=85=A5=E9=98=9F=E8=AF=B7=E6=B1=82=E7=9A=84=E9=A1=
=BA=E5=BA=8F=E3=80=82=E5=9C=A8=E8=99=9A=E6=8B=9F=E9=98=9F=E5=88=97=E5=B7=B2=
=E6=BB=A1=E7=9A=84=E6=83=85=E5=86=B5=E4=B8=8B=E5=B0=A4
> +=E5=85=B6=E5=85=B3=E9=94=AE=EF=BC=8C=E5=9B=A0=E4=B8=BA=E6=AD=A4=E6=97=B6=
=E4=B8=8D=E5=8F=AF=E8=83=BD=E5=8A=A0=E5=85=A5=E9=AB=98=E4=BC=98=E5=85=88=E7=
=BA=A7=E7=9A=84=E8=AF=B7=E6=B1=82=E3=80=82=E4=B8=BA=E4=BA=86=E8=A7=A3=E5=86=
=B3=E6=AD=A4=E5=B7=AE=E5=BC=82=EF=BC=8Cvirtio-fs=E8=AE=BE=E5=A4=87=E9=87=87=
=E7=94=A8=E2=80=9Chiprio=E2=80=9D\
> +=EF=BC=88=E9=AB=98=E4=BC=98=E5=85=88=E7=BA=A7=EF=BC=89=E8=99=9A=E6=8B=9F=
=E9=98=9F=E5=88=97=EF=BC=8C=E4=B8=93=E9=97=A8=E7=94=A8=E4=BA=8E=E6=9C=89=E5=
=88=AB=E4=BA=8E=E6=99=AE=E9=80=9A=E8=AF=B7=E6=B1=82=E7=9A=84=E9=AB=98=E4=BC=
=98=E5=85=88=E7=BA=A7=E8=AF=B7=E6=B1=82=E3=80=82



Thanks,
Mauro
