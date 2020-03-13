Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28AF318401C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 05:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCMExj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 00:53:39 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:20752 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCMExi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:53:38 -0400
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 02D4rNx3024834;
        Fri, 13 Mar 2020 13:53:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 02D4rNx3024834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1584075204;
        bh=w3Y1PyEPxiBVRuK/A0Q7y3Dyq4APs/2kQeU8OKCr8ZA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1qbYSOTgDX4Vgx5faAXlOdhiqgn8tPaNi0xwFJsuOFnT4BLAWTiK3CZJmA3YjgRfz
         vyGTQpfSMRynbM6aqYEOjHc7CxQ+lbb8YufLNjhi4t38klppChvz9JP+V8XTbiIFUP
         5pTz+otNvR6HGM1QC37YTNKQ0vAUwB/kTXjWTu75106a+XtDrFiJKO4uf4FbXMLpNq
         T41aOe2KIWiZZSSLRQR/DISiswtiCzk192xhd5v5aQX31dmV68iAvDZyvsuIO+nmt9
         BZmKxJ2821C3miI56kSQC2LkBBtoe9ej/p+krgV340LKS//8zuAKesgotob+NafjtI
         2iEU6JlZvKTaA==
X-Nifty-SrcIP: [209.85.217.43]
Received: by mail-vs1-f43.google.com with SMTP id p7so3070212vso.6;
        Thu, 12 Mar 2020 21:53:23 -0700 (PDT)
X-Gm-Message-State: ANhLgQ36P4o1pMBIh4BkFEZ41wAcOIkMlHqKnhDENQ+EJC0yA6/WWx9y
        pwrVPG2XXhveo0fJJnWvzJIfPpIRJ8dpvC8Tq0E=
X-Google-Smtp-Source: ADFU+vuj8oh8CmqdPfS+e+blxWFNJKVra9+A1Sx+9bsoEaPEfI9I+52/E35yuOeItildQOuicmCENQ6ligLyO/1nQsQ=
X-Received: by 2002:a67:33cb:: with SMTP id z194mr8322970vsz.155.1584075202592;
 Thu, 12 Mar 2020 21:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200312041232.wBVu2sBcq%akpm@linux-foundation.org>
 <c6c4e6fb-30f3-60a1-6bc0-25daa84d479d@infradead.org> <a8343b1f-7e87-d34d-a71b-86d20a8a3aff@linaro.org>
In-Reply-To: <a8343b1f-7e87-d34d-a71b-86d20a8a3aff@linaro.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 13 Mar 2020 13:52:46 +0900
X-Gmail-Original-Message-ID: <CAK7LNARaR9_GPE+uU9Fh73850dwJXKETyF4gJxats_hrhgwzAg@mail.gmail.com>
Message-ID: <CAK7LNARaR9_GPE+uU9Fh73850dwJXKETyF4gJxats_hrhgwzAg@mail.gmail.com>
Subject: Re: mmotm 2020-03-11-21-11 uploaded (sound/soc/codecs/wcd9335.c)
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        mhocko@suse.cz, mm-commits@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 13, 2020 at 1:59 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> Adding+ Masahiro Yamada for more inputs w.r.t kconfig.
>
>
> Kconfig side we have:
>
> config SND_SOC_ALL_CODECS
>          tristate "Build all ASoC CODEC drivers"
>          imply SND_SOC_WCD9335
>
> config SND_SOC_WCD9335
>          tristate "WCD9335 Codec"
>          depends on SLIMBUS
>         ...
>
> The implied symbol SND_SOC_WCD9335 should be set based on direct
> dependency, However in this case, direct dependency SLIMBUS=m where as
> SND_SOC_WCD9335=y. I would have expected to be SND_SOC_WCD9335=m in this
> case.
>
> Is this a valid possible case or a bug in Kconfig?
>

The patch exist:
https://patchwork.kernel.org/patch/11414795/


However, this caused another problem, then
got reverted in linux-next.

It fixed it too, so hopefully
this will be solved soon.



-- 
Best Regards
Masahiro Yamada
