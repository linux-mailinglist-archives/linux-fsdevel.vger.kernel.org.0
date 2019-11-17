Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED819FF9DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Nov 2019 14:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfKQNal (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 17 Nov 2019 08:30:41 -0500
Received: from mout.web.de ([212.227.17.11]:42953 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbfKQNal (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 17 Nov 2019 08:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1573997425;
        bh=fs8EIzdE6o0M6xTF24WLLY76qhiXvAckElAXZNS6GcE=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=GcONIYUHlAHo1D9DvWcN19p8MMXYZ6pEl9KBfWu5ikLFRVdBTza/mko4ig3ViVrtu
         MKRUzdUDeAPOINICOjtU8zaC1BzdVoHo0sfsgOVRlNRKGs3F1G49wPMO1O1zI4quJM
         HL4129fn8bHY+K9h5WuGnZN+EszsJMxTcTNKCYzM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkLb-1igXdG1NWJ-00Am9p; Sun, 17
 Nov 2019 14:30:25 +0100
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191113081800.7672-3-namjae.jeon@samsung.com>
Subject: Re: [PATCH 02/13] exfat: add super block operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <9e9bac40-109c-3349-24da-532c540638c2@web.de>
Date:   Sun, 17 Nov 2019 14:30:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191113081800.7672-3-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x6FPQUW77SXUsE0vAGDnH2vv/GMkx23DD2vq9A22ez2SrO6lGIP
 Kfhf7UvkrXGY2LkLKwiPXyrwRELCjHuc3ppwRjw+qyIyqsKqw5Ye86uPHDX4hcT7SwHucbn
 0cMwaOw7OUjX9+6zx0oEplPX6+XnmHywpfF0m77sF5BvmJGDF0Hq028oucBAmGpHbsk3e3K
 rF7y/OeetHj44jgKX63tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lpOfVsHDkRc=:JWhm/kgUtsa+I84khD40nk
 jxG6BN4TShPK56P/QYBPe3oOh6Z2DPbtGvKZwTuX1/byELef8NGl6E+3xR1Uw2htCwTDrLacU
 4Wcuqcaztn8GIPm293hAf1dpSoEaVHuPRtv8uouBoHd4zC0ZUpaTqujlHQoVmcTR2beBJHE2d
 vU+A5NLFhFwk8ZYwUQnB+VlXdzVOXuMUSq3A5e/YSWK4uOjpcNcfzDTrcPYq976mnulmDbMa2
 sSeWrXKC03ncgYm5oTD11RcIJpsgXhQKq38tErsOmvb+5jWJy72h9z8qrDa8kBjNX6NmaAnSa
 JETLLXYTRmewUUMSVSuUKpAdJkkGjFxa1vZe07HRA8tMs1bn1oEkCGOZx+wP/KNL0IY+l/49d
 rmv/MIP3zX9Rjhtl7L+OqRaLoAUzV9umsZN6qGSBORvfldrMhATXc36Yzb4wflirhS2JYnZSS
 FGXwdpKp+VyRNVebO6NL0UMfKx2sWsLr7rxxk7ajYTrIu5x8K73J5pH+EI9fHzUCngwDlouYj
 bPhWiNjw8O4BqEcVUXkhu3Wys1iMJZ2Xopv0oR7oCsu78/EhKfsfGcMeytIAQgnOV/mmty5db
 ZsXb/TytRsNF5q61HtBAkQWbNKkd18ocruqYN6beu+doF9ZUCYpV+1V9ATdC29YxK6f3/nxUg
 dt0xwQBygyPYPoMt/8sVON+qMd49pTFVvq+qL+V+tTJryKJeUeCqoN09mbqvgoJUS8CtTuIqO
 mD2PDQFtCTbXB0FuBmgffarY9HqttE0eHahG6wZBTZKF68N+GL7xTmavw8ktcS6NDXwXNazeG
 odPtCgiIvumWmdxzmEVmi7qm16LllyfeXPRaM02afoF39whwdZicXBJ6APhzspvQb82SN5Uad
 Kg+N7iYXx4KSXlWpiGYE+rVOBPcbuj1rmIsq8K1umRRVTMnKToKyEaH/A8485iAMZxmsJD8P2
 QM+XeCcDj4cj9gXR9ftInWeUt3o0mgIqDQQTCy7NXwLUrnCG8KEkQ74yW/q/KTzsjRq5h+3tL
 GhjYj/kgf+SAzBMgPWQURD46O0gcyjJNm8K8nVkKPgh1QhZjWHA8KDMxe9WbJVaDRg+xyHJGO
 g3/6OXm/3x0SEvwIMhxLoVlyVGu2fpOZyU3Psi4vEexiXBQqER+tSiUs2zNDaoh9p10RDqssh
 scPAADp/eQl3p/UoTglNLJsQhWlepcFbLgJCzcs0qmz/B2/M+lFHtsJGE3YqwZ+2x+mJqjQAU
 gpJsu8xNa+UcsSOKUQyf8FBUJN636LD5on48FhbAni5p2lzdCx1XfqPLA5Bo=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/super.c
=E2=80=A6
> +static int exfat_show_options(struct seq_file *m, struct dentry *root)
> +{
=E2=80=A6
> +	seq_printf(m, ",fmask=3D%04o", opts->fs_fmask);
> +	seq_printf(m, ",dmask=3D%04o", opts->fs_dmask);

How do you think about to combine these two function calls into a single o=
ne?


> +static int __exfat_fill_super(struct super_block *sb)
> +{
=E2=80=A6
> +		exfat_msg(sb, KERN_ERR, "unable to read boot sector");
> +		ret =3D -EIO;
> +		goto out;
=E2=80=A6

Would you like to simplify this place?

+		return -EIO;


=E2=80=A6
> +		exfat_msg(sb, KERN_ERR, "failed to load upcase table");
> +		goto out;

Would you like to omit this label?

+		return ret;


> +static int exfat_fill_super(struct super_block *sb, struct fs_context *=
fc)
> +{
=E2=80=A6
> +		exfat_msg(sb, KERN_ERR, "failed to recognize exfat type");
> +		goto failed_mount;

The local variable =E2=80=9Croot_inode=E2=80=9D contains still a null poin=
ter at this place.

* Thus I would find a jump target like =E2=80=9Creset_s_root=E2=80=9D more=
 appropriate.

* Can the corresponding pointer initialisation be omitted then?


=E2=80=A6
> +failed_mount:
> +	if (root_inode)
> +		iput(root_inode);
=E2=80=A6

I am informed in the way that this function tolerates the passing
of null pointers.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/inode.c?id=3D1d4c79ed324ad780cfc3ad38364ba1fd585dd2a8#n1567
https://elixir.bootlin.com/linux/v5.4-rc7/source/fs/inode.c#L1567

Thus I suggest to omit the extra pointer check also at this place.


> +static int __init init_exfat_fs(void)
> +{
=E2=80=A6
+	err =3D exfat_cache_init();
+	if (err)
+		goto error;

Can it be nicer to return directly?


=E2=80=A6
> +	if (!exfat_inode_cachep)
> +		goto error;

Can an other jump target like =E2=80=9Cshutdown_cache=E2=80=9D be more app=
ropriate?


> +	err =3D register_filesystem(&exfat_fs_type);
> +	if (err)
> +		goto error;
=E2=80=A6

Can the label =E2=80=9Cdestroy_cache=E2=80=9D be more appropriate?


Regards,
Markus
