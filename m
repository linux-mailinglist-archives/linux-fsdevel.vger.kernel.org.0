Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 273141AA32
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 06:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbfELEEX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 00:04:23 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:44881 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfELEEX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 00:04:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id y25so7112535oih.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2019 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RzgA+6+EFYb44zZTJjo6jx4GiNW1O3bLEXgu/Gl4EW0=;
        b=mH00+FARm1cnffwncJnuHa/IEVhAurR8VlnHoIyiRa7gPnNWcsYnzaFXy/oVMbU+bg
         TxxuFbIaa19bRZKWY7GfsDlwY8TS5qEJFN50c8eZt0b/Lkad3o1ylZ0RuBH4l+DSiBfj
         5u/OLN81nsp+9ugAtwy9476uOl9anJFKjGhmLSqSKyoy9H1gdhcQVSiEK7ESPFI6Qlni
         +5QhXXOqAcY9j9TYlW6d3zRrJtppXQNjDH14/RGume/B3FtZ1sh628ZPmfhh8NbXMHyJ
         1TeqLYc4PdW+2DY6K0cLzJzTKm1naXM8enyjDICjQ1GP17oZhJnTgdMkb3lOig9V5dXK
         Hrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RzgA+6+EFYb44zZTJjo6jx4GiNW1O3bLEXgu/Gl4EW0=;
        b=mK6180NyC2hhO9SFf2jVeyBd6XOyxzMiqC8Dv+xH1yLHa5l5l71VOUwDfou3Bwf68J
         nMYmr88pwVs1uxfNF6SWOLV/Fm0+eHWFFNHZDhAw0lfXS6fplzVPGcGrDX7kYwFbFhVt
         WsbB9tEmkdCSFh1hKuixvXSA41KpkYGe+T68VsIG83QMLmUjoxTBgs8KvEPIFlrP0DlM
         kkM6QSp3al/n2IfNanEt431Wil46rwha6kYDxqIUIRqxwDVhAApfF4JR4InQGCGH4QxI
         c7ahwlqMjLlpjYrF5CifGX+Sfu83OKWrg7dKpHJGTHJXMYxxjSpNvF9Dow72uyizOtgS
         +ALg==
X-Gm-Message-State: APjAAAUVecrL4wUFseD+QxOIcs79xpuB5RZsveRM3jq2pB4XvWjTnB0X
        5CRQ0idkfim9g1OVafquvyav0Q==
X-Google-Smtp-Source: APXvYqxY/B42HDdJiyzauyCigddH18X40ZSXGB7ycP8OI+mXnxCdV3RnVEgUugDeDm9FrNbRGk137w==
X-Received: by 2002:a05:6808:46:: with SMTP id v6mr3990661oic.108.1557633862136;
        Sat, 11 May 2019 21:04:22 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id w5sm3610467otg.34.2019.05.11.21.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 21:04:21 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] initramfs: add support for xattrs in the initial
 ram disk
To:     Andy Lutomirski <luto@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        initramfs@vger.kernel.org, Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        silviu.vlasceanu@huawei.com, dmitry.kasatkin@huawei.com,
        takondra@cisco.com, kamensky@cisco.com,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        james.w.mcmechan@gmail.com
References: <20190509112420.15671-1-roberto.sassu@huawei.com>
 <CALCETrXy7gqmmy37=nrMAisGadZ+qbjZjXtWFF8Crq86xNpsfA@mail.gmail.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <4aee6e10-0eec-1d76-af66-dc8c7b68b766@landley.net>
Date:   Sat, 11 May 2019 23:04:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CALCETrXy7gqmmy37=nrMAisGadZ+qbjZjXtWFF8Crq86xNpsfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/11/19 5:44 PM, Andy Lutomirski wrote:
> I read some of those emails.  ISTM that adding TAR support should be
> seriously considered.  Sure, it's baroque, but it's very, very well
> supported, and it does exactly what we need.

Which means you now have two parsers supported in parallel forevermore, and are
reversing the design decision initially made when this went in without new info.

Also, I just did a tar implementation for toybox: It took me a month to debug it
(_not_ starting from scratch but from a submission), I only just added sparse
file support (because something in the android build was generating a sparse
file), there are historical tarballs I know it won't extract (I'm just testing
against what the current one produces with the default flags), and I haven't
even started on xattr support yet.

Instead I was experimenting with corner cases like "S records replace the
prefix[] field starting at byte 386 with an offset/length pair array, but
prefix[] starts at 345, do those first 41 bytes still function as a prefix and
is there any circumstance under which existing tar binaries will populate them?
Also, why does every instance of an S record generated by gnu/tar end with a
gratuitous length zero segment?"

"cpio -H newc" is a _much_ simpler format. And posix no longer specifies
_either_ format usefully, hasn't for years. From toybox tar's header comment:

 * For the command, see
 *   http://pubs.opengroup.org/onlinepubs/007908799/xcu/tar.html
 * For the modern file format, see
 *
http://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html#tag_20_92_13_06
 *   https://en.wikipedia.org/wiki/Tar_(computing)#File_format
 *   https://www.gnu.org/software/tar/manual/html_node/Tar-Internals.html

And no, that isn't _enough_ information, you still have to "tar | hd" a lot and
squint. (There's no current spec, it's pieced together from multiple sources
because posix abdicated responsibility for this to Jorg Schilling.)

Rob

P.S. Yes that gnu/dammit page starts with a "this will be deleted" comment which
according to archive.org has been there for over a dozen years.

P.P.S. Sadly, if you want an actually standardized standard format where
implementations adhere to the standard: IETF RFC 1991 was published in 1996 and
remains compatible with files an archivers in service. Or we could stick with
cpio and make minor changes to it, since we have to remain backwards compatible
with it _anyway_....
