Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6B1027A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2019 16:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbfKSPGh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Nov 2019 10:06:37 -0500
Received: from mout.web.de ([217.72.192.78]:53845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfKSPGh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Nov 2019 10:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574175980;
        bh=0zo7dDCKLAG/971IKZsBHSalBSXIX3bS03JGhfTsm+8=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=lsUVirKRFb2klkSrAhBgEtS5KmRGHQJqv90Ouqh7mHWcd6sNDP6vCkX89gQBXT7jr
         0zOHZNaCyKPgdh2hoNz39Q/U1vQaoLtd1j6k33R9kW1txDR0TFRoSxZran4a1PTs+W
         w0Qj+TLXgBz1ung5rWMSLuyfQuFTrl+lSt5QcjM8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.93.164]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LhvyA-1i31WI2VPu-00n7DX; Tue, 19
 Nov 2019 16:06:20 +0100
Subject: Re: [PATCH v3 10/13] exfat: add nls operations
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        =?UTF-8?Q?Valdis_Kl=c4=93tnieks?= <valdis.kletnieks@vt.edu>,
        linkinjeon@gmail.com
References: <20191119093718.3501-1-namjae.jeon@samsung.com>
 <CGME20191119094026epcas1p3eea5c655f3b89383e02c0097c491f0bc@epcas1p3.samsung.com>
 <20191119093718.3501-11-namjae.jeon@samsung.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <705cb02b-7707-af52-c2b5-70660debc619@web.de>
Date:   Tue, 19 Nov 2019 16:06:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191119093718.3501-11-namjae.jeon@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a+CKAml7B0/J/jY8wDGOYDt4BF9yEXk82djMmrglT4v/2w80zx6
 8yJlQTkxYNm2noHcVhZYbaStojM4qHlJQjSjk13Bd4pln+1rB/H7kCo61WhcXISps7rWGnV
 l9ZN3NjmsPkJMGz8ol6mzxiufnf+uRxiMQjtVHj0f0NwAveNlRZ57b1Ul0Ka4O1eVsp7Jl0
 xzQDfUdcONsTT9RPeAl6A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hJOtlFpI/Ms=:nXdX6fBbKgf5iGIRtchLJo
 vYB3hsPZJD5bi+C4IbuzJg9kQpPVA83QdpaH0mQHHeewF8+ajS6r6i7B5uqXNXJ0lMfuoAkqk
 8VvGoW7QUDPocxN98q+V7s3Dplzf3f5T7NZTgGkrC51TJJyVB3aXvn33iTE/aU4dFQReJMygd
 F2HUubYFvRqzO/6nu3nga4J8hQFSNXTyrDNlV7k/bHFIJgZUVZSwL10wTy12bmCyfLcXp6Z2k
 LA2sBLKhMOCGgVPxQ7YxR8GQONKNMV8L7qRRR/dMuNvjDQrZXrIEpYqYCZ+N5WNAUB5/zBnpN
 w0e6L/SZGSDYPwav76Zn5AjTiSyIs31o90DCks+8ES2rZi2xnanIOZJvqfR2tyW7D+E4otaHy
 Twmz2S/+rlv2YTR+YZD1d7X9aB4X+r1iQh1P5gNX2p9Sm56df54GPKVxYkwYHITNJRx4DQII4
 wJQNenU3ezdmLTB93CgcpGfhyPPMGzhy28dKNSxemj4bSyf6/xmOXxdp16wllWppVuSUWffiF
 poijsKeDgGV9J9u3jPtsBHbtQTryOPGp4jHgZf0lPD4J1xb6tBBmyUZwZPCDbb60tFntAKvwi
 ifEelxGn/EpIlA1xnUN1VnBApfE1B6wHx2PdMtLqgYZcRIJmjsoJXAR/qaVHhZjV03hzXeNxq
 PlmPQQmSNHGTwFVX3JSP1qs0e2rZpNHa7khk1IPKfd02zVbzuOl17WNDW2wtQQwvrqpJtSz7v
 a5cHIxepSGwFF2ETB7XM5a5mNxqKIVyVf1CjJkXW1mKlR6RIgKo5/xosaYnExxdmPRl4x/k8H
 hrDOY2rnDJW6BrS2HU1urb/wIBf5qQWA2OMZVbEyPFeoFJ+PmnKJz65F7xwW1W6Vpu77cz551
 MA487lg9mpolhB0e5oVIBUojJ9TTYVqtFy5KGLPCzbUV0VZWLaLYQ6k+3/6Omo7aO9As2gHLD
 GyGp7quaAaZ6zfh64JBPq19c/fFYGu0dLQnCv4pi7gq6sjooZF6ifU8c90wl9K+4SDxw/CQ2O
 jSWrp9hO1Q+Nib8s5sfDmCMtXJh4hsnwzU/zI5Nw+kcqzBCuGp+NbQECVSS1GwWB/kedDZc7L
 lXKOp1eOnSXn682FFF7qZXlZxmihMGMij9jheMmYlDj0OHy/wbVMUY6p+0K09GbhiHR5Hr7Z3
 xnTeDMZV79PI2p8MThvgX1bH5Ctgc68idsjt9v7LXw4BywOI6cconBevLAzEDWQB6u+XoYX28
 /cp8UqIA+5iKVS+kuKOpAmvIDAX9Q/MYb7xThghqR6/UDegJdlj9hqR1qUnQ=
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=E2=80=A6
> +++ b/fs/exfat/nls.c
=E2=80=A6
> +static int exfat_load_upcase_table(struct super_block *sb,
> +		sector_t sector, unsigned long long num_sectors,
> +		unsigned int utbl_checksum)
> +{
=E2=80=A6
> +error:
> +	if (bh)
> +		brelse(bh);

I am informed in the way that this function tolerates the passing
of null pointers.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/in=
clude/linux/buffer_head.h?id=3Daf42d3466bdc8f39806b26f593604fdc54140bcb#n2=
92
https://elixir.bootlin.com/linux/v5.4-rc8/source/include/linux/buffer_head=
.h#L292

Thus I suggest to omit the extra pointer check also at similar places.

Can the label =E2=80=9Crelease_bh=E2=80=9D be more helpful?

Regards,
Markus
