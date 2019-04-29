Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63511DA9C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 05:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfD2DKG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Apr 2019 23:10:06 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:51524 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfD2DKG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:10:06 -0400
X-Greylist: delayed 161115 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Apr 2019 23:10:03 EDT
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x3T39r1q016871;
        Mon, 29 Apr 2019 12:09:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x3T39r1q016871
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1556507394;
        bh=D6/eHEGu1S/FgjaRhL+TDpUVhVgXkf1tnSwVBxG2mpI=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=XRcprZIF2wGKBMmYSTpLbQfAbNmSAMHisJs4xA88NzhGpL7nAQjWoeqGWNIjqfSyw
         NZtPgqYmwhoIpq8la6IPIC+ggry5UWQhtsofmgR1wj/sYGvexinSUR9xmMN3dp9X50
         oagtHTJL2vU8p2s7WHgWpdynf0e5in994+tEEFkfx1JmlW+NsW9tcYRIz/2Cq+qD9B
         Ta9UfNkXZ96ba8ovKsOXQEGqteAle0LArbzgqfBprOQ7GUGvsFAEvMyYHgwIkOuaTg
         zOxipQ33dUA0anPBhCW7XMY/cGTkya1rK29XogoDfbuEvraF2HvQmh1ul3uE+5KMR8
         q/ZVZ+lU/FzfA==
X-Nifty-SrcIP: [209.85.221.170]
Received: by mail-vk1-f170.google.com with SMTP id l17so1980970vke.7;
        Sun, 28 Apr 2019 20:09:53 -0700 (PDT)
X-Gm-Message-State: APjAAAX+f3saOK7soeT9QSILkkyDwEyHsSlpY5ZkkndX1yKo/dACE9DA
        Q+9UyQ3wGIV6E8DNEWUupeMA3cFSqyLSEoOrCQI=
X-Google-Smtp-Source: APXvYqw0bG8CrWXMrxSWRjM4j1ygj/A090lPp2tsPXHl6m/HimipQzSsHgb6CJKrA93+n4itgvz1HpCs5J32rhJs1o4=
X-Received: by 2002:a1f:9d0a:: with SMTP id g10mr2112150vke.0.1556507392399;
 Sun, 28 Apr 2019 20:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <1556346241-10451-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK7LNAS2vTGF0dYJ67Ct2xDL=7qxYhhK-VoVHfkqDu0d8ULd+g@mail.gmail.com> <20190428174315.GC24089@mit.edu>
In-Reply-To: <20190428174315.GC24089@mit.edu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 29 Apr 2019 12:09:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNASQqbWL_Lvn+=9PX41kbHNEB4K9dVS0LS=X-h0FEN9FHg@mail.gmail.com>
Message-ID: <CAK7LNASQqbWL_Lvn+=9PX41kbHNEB4K9dVS0LS=X-h0FEN9FHg@mail.gmail.com>
Subject: Re: [PATCH] unicode: refactor the rule for regenerating utf8data.h
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olaf Weber <olaf@sgi.com>,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 29, 2019 at 2:44 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> Thanks, for the suggestion and the patch!  I agree it's much better
> with your proposed change (and it gets mkutf8data out of your hair :-)

Yes, this is my main motivation.

>
> I did need to make one change to your patch in order for it to work
> correctly with a build directory.  That is, to support
>
>         make -O /build/ext4 REGENERATE_UTF8DATA=1 fs/unicode/
>
> I'll apply it to the ext4 git tree with this change.


Thanks for the suggestion.

My first thought was "don't do this",
but it would be better to make it work with O= option.

However, even with your fix-up, it won't work correctly.

If O= is given, the newly-generated utf8data.h will be
put in the object tree.

It will co-exist with the old check-in utf8data.h
and the old one will be included because
the include paths in the srctree are searched first.

I will send v2 shortly so that O= build will work
correctly.

Thanks.





>                                    - Ted
>
> diff --git a/fs/unicode/Makefile b/fs/unicode/Makefile
> index 1a109b7a1da9..45955264ac04 100644
> --- a/fs/unicode/Makefile
> +++ b/fs/unicode/Makefile
> @@ -14,13 +14,13 @@ $(obj)/utf8-norm.o: $(obj)/utf8data.h
>
>  quiet_cmd_utf8data = GEN     $@
>        cmd_utf8data = $(obj)/mkutf8data \
> -               -a $(src)/DerivedAge.txt \
> -               -c $(src)/DerivedCombiningClass.txt \
> -               -p $(src)/DerivedCoreProperties.txt \
> -               -d $(src)/UnicodeData.txt \
> -               -f $(src)/CaseFolding.txt \
> -               -n $(src)/NormalizationCorrections.txt \
> -               -t $(src)/NormalizationTest.txt \
> +               -a $(srctree)/$(src)/DerivedAge.txt \
> +               -c $(srctree)/$(src)/DerivedCombiningClass.txt \
> +               -p $(srctree)/$(src)/DerivedCoreProperties.txt \
> +               -d $(srctree)/$(src)/UnicodeData.txt \
> +               -f $(srctree)/$(src)/CaseFolding.txt \
> +               -n $(srctree)/$(src)/NormalizationCorrections.txt \
> +               -t $(srctree)/$(src)/NormalizationTest.txt \
>                 -o $@
>
>  $(obj)/utf8data.h: $(filter %.txt, $(cmd_utf8data)) $(obj)/mkutf8data FORCE



-- 
Best Regards
Masahiro Yamada
