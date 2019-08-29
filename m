Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9333A1F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2019 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbfH2PpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Aug 2019 11:45:14 -0400
Received: from mout.web.de ([212.227.15.4]:46381 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727454AbfH2PpO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567093501;
        bh=bXJWF3tk3i4nXE+uokgXyj7lI9V3sCZKNmOFOxiGkHo=;
        h=X-UI-Sender-Class:To:Cc:References:Subject:From:Date:In-Reply-To;
        b=sOKrqC4bueOJXvz3mC5dNvtMiU5Fsg5iByTtkLq2uEEkxdqc2wNKv3z6i3mjsTfIZ
         dWuaFhYOhdRFvnn0uS96Fx5pRw3rslKNFcAa6Xc/XUDBF5jCkpHeaU6rGBwOspvYIC
         dspUI8WKKpntphU/eYdleZtUn5ipkhXy+YEAChaw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.172.157]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0McnaL-1hlQDN3hNR-00Hze7; Thu, 29
 Aug 2019 17:45:01 +0200
To:     devel@driverdev.osuosl.org, linux-fsdevel@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20190828160817.6250-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: exfat: add exfat filesystem code to staging
From:   Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d5c289ef-6c5c-ecdc-0e73-c5bd410b3d26@web.de>
Date:   Thu, 29 Aug 2019 17:44:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190828160817.6250-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SiioPfBZvgue4c8y1oMvSjEly2OccD75gLWn2AXYvJSCoSbrafc
 MAod5N8SDEBFEGx4E+K4cBKMwLm1xN2wY7tApjfosA0W73LAgxYAAFprnLZrsglijuIBkzI
 ZtpAtsAwF7AmwON+VSc/4trDy3TP/1NNTfKpP5BVXf+PCfFnwtd5GSCq90GFq8C414CZ/8g
 7MIa58axNya8lYQbDPm5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ihi8zAPp8Qc=:VOZXQt4thrAHwgY/ANnzAZ
 Yqmdu7z09Fkz4wpGd0JFFxmn1wPUT2XsQpw+b8eGin7YHfbMtmtlRuKClqXNWMcY8I8Dyb+rH
 P7u/N0N+uvnI2ecTFPgs9BCmFBea0e7OQqWfOjQWcqZYC06W0mh0qfcw2+RtkpS4xEW2XF1Hr
 7KkeFzoIwwzEDdNMpFYxF5HFtQ5uHSMQLzGPWWzBvLDTMqG2XesJ8amRQjX+EXRdfiIR3xQMj
 vUMzZJhcEgMqyJxgXnaJ+KAPeYsvSXC5TBHekRhkd0FRbg01DjfslijRkeIvbxmaDteJhA2ey
 0V1l0Q+P8W8ec+LKly8C+8aoy/t1AVExesKCXiKYJcmwkaghGkU9DTf91VLavNMCEBP/mjbrf
 FWnDnv0vCukYpeD8vgJdtehkz3pGsWbkvR8LxvSoYdDKWvfUlkQNI683EQ7xIZlfm1LBm1rBQ
 X0oyyYcceZ9sZG/y0pIDXY4Kp1RuaxtcMMRZXizH0c7lPMzzB+Lj90QOF6tCBT/G9UOJe8Tok
 2n1QYOI5vxKqsukjxzXEl/FpEoDTVJdIPuJal+A/Bhak9b9YRfoHA5WrVXUGDSIVYt1CeEs+L
 swO8Wh0LZjUkcOsgJQd0FQNUJP/etOJvtqfSYQ45+t+YfEz1u3NwsDjRVMhRvzoQ2eWTELh2p
 3qpufflpXvnOmQmybLg56/E+P2OA7siHCqhLvyU9VGtliKp98D26nUgCfyzoK/mUpgZvIsu80
 9otQyZ/0v6zDsD0/7s8age/pxbMZshPN3WULsob3QJRew/0Gm1MJhSN246z6AXIPsRebE2EkW
 y0ZzfssO7727K+G2scgQpAzKyxeWcaIU2wWdc5BW/VEYV0/V95TUWTQSe93kANaLhVFgCY4Ot
 Igzw/v8Vg9xnmHSIn5v83fm2RKXDfoOcgMJpyOmuwl6GfAA1ii4AhGcPWTVZO5B6rIYolPRjR
 ciuzv8bDlrQwk9vBW8pP2u6ZjQ8RXJkgJueYsP7jjdyau4/vOOtk6y5fOp/03uFTk2o/whDN+
 RsE/prG3XhFsBqeuzWDABCVb3VX3IAk4C3mU/VCmhPoyoKutKuLz3dos+js1n45H9cXIxpEjC
 dv9MLrtnyJkKmch3SAGk/hYSQR7wdesKthRlHAd5REyHiF2+FUx1+uojRgQ//fPDIIEqL9P1S
 LMO5N7TqzLZMhpmJdwznSeEjJufWKCd4EewLGr3q/OLilHhw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +++ b/drivers/staging/exfat/exfat_core.c
> @@ -0,0 +1,3704 @@
=E2=80=A6
> +static s32 __load_upcase_table(struct super_block *sb, sector_t sector,
> +			       u32 num_sectors, u32 utbl_checksum)
> +{
=E2=80=A6
> +error:

An other label would be nicer, wouldn't it?


> +	if (tmp_bh)
> +		brelse(tmp_bh);

This inline function tolerates the passing of null pointers.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/linux/buffer_head.h?id=3D9cf6b756cdf2cd38b8b0dac2567f7c6daf5e79d5#n2=
92
https://elixir.bootlin.com/linux/v5.3-rc6/source/include/linux/buffer_head=
.h#L292

Thus I suggest to omit the extra pointer check at affected places.


> +++ b/drivers/staging/exfat/exfat_super.c
> @@ -0,0 +1,4137 @@
=E2=80=A6
> +// FIXME use commented lines
> +// static int exfat_default_codepage =3D CONFIG_EXFAT_DEFAULT_CODEPAGE;

Is such information still relevant anyhow?


> +static int exfat_fill_super(struct super_block *sb, void *data, int sil=
ent)
> +{
=E2=80=A6
> +out_fail:
> +	if (root_inode)
> +		iput(root_inode);

I am informed in the way that this function tolerates the passing
of null pointers.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/inode.c?id=3D9cf6b756cdf2cd38b8b0dac2567f7c6daf5e79d5#n1564
https://elixir.bootlin.com/linux/v5.3-rc6/source/fs/inode.c#L1564

Thus I suggest to omit the extra pointer check also at this place.

Regards,
Markus
