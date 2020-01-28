Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A40314AFA0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 07:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgA1GPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 01:15:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39994 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1GPZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:15:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id t204so11452105qke.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jan 2020 22:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=IX6vC1lqC7B6QSvzPSA4RSu0dRAbEMHe13lqUpG29i8=;
        b=VKXqwFjmNXdB/wJW5knEKaf8vqMoxWZxZenXmtRbHfj2GkPH84URj6RIU7kuu9br/n
         cO100UpGyUFr7n85BLlnvIKAGP009/Hcaf4XQmBvgCO4s5t20dg0E/x5WFuF1JfPexca
         qKucwEcgFyhAQqLSQGzAgwSYxg/Krp1wdD+33iDC3XcjfzHjLG/WmY7kCH57ovDlVBWy
         CInbxtz0nSTJ/aPX70647beyykTi1bIki7ecWq/g+4KVqa/PF299NRyKANNx082/SYZg
         a66f6lAnlak0GqZDiNdAB9xuMjwBEyXfJgmNT0Lq1U8INg0B+xHSCqmhtit3iHj6blvY
         73tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=IX6vC1lqC7B6QSvzPSA4RSu0dRAbEMHe13lqUpG29i8=;
        b=InJbzRV0pYQvEAG1ZDLSM+LqmHYi4xGL5PzHfoUz1OqskhH59vv4EGQB4wyB2qv7E6
         69P0SLYLPPHs97Y+2uWP8PMtkwDJmKEd/REWozsZ4sX2OHB7QUV7I0saBToPJNZ1m3GW
         ewig8rRx9EQBGgmmZ/tBXIMqKDuh8FfGH4O1rrJzb0LEHqlrMJfKW7lC+KF+ie9EsDR+
         E2mUwd6Z2KQa2br6SGm6hbxceKoOVPXrJlJ4U3heNmT/PfD+0fJkznWV0XcEnmKXFwup
         vninjttnWlJ34aAnTwbA+5yvaqAjedvsd2od30W5+Je9TN3KISZkUquQeDa7S66Bi+gs
         Oa3Q==
X-Gm-Message-State: APjAAAWptmp68vFR6Qb/CodEwH7PM4WEkuHQLoMXT1Kr88RgwxHGbToP
        3qDc4dTeqHtGRH03lEzikV4iuQ==
X-Google-Smtp-Source: APXvYqz7X3XsotDyp2Rkn3xurztaEfQuChOv10+xbCcj0AINYcjgBapre5/9nAD2nqzDixYkJRy09Q==
X-Received: by 2002:a37:814:: with SMTP id 20mr20434739qki.314.1580192124338;
        Mon, 27 Jan 2020 22:15:24 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e16sm11951755qtc.85.2020.01.27.22.15.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 22:15:23 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: mmotm 2020-01-23-21-12 uploaded (efi)
Date:   Tue, 28 Jan 2020 01:15:22 -0500
Message-Id: <E600649B-A8CA-48D3-AD86-A2BAAE0BCA25@lca.pw>
References: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>, linux-fsdevel@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <CAKv+Gu8ZcO3jRMuMJL_eTmWtuzJ+=qEA9muuN5DpdpikFLwamg@mail.gmail.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



> On Jan 25, 2020, at 2:06 AM, Ard Biesheuvel <ard.biesheuvel@linaro.org> wr=
ote:
>=20
> Should be fixed by
>=20
> https://lore.kernel.org/linux-efi/20200121093912.5246-1-ardb@kernel.org/

Cc kasan-devel@

If everyone has to disable KASAN for the whole subdirectories like this, I a=
m worried about we are losing testing coverage fairly quickly. Is there a bu=
g in compiler?=
