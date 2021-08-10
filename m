Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AB93E55C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236647AbhHJIq6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 04:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbhHJIq5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 04:46:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C67C0613D3;
        Tue, 10 Aug 2021 01:46:35 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id m9so27894109ljp.7;
        Tue, 10 Aug 2021 01:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=EwRWG/gC2fE5xGCjSTzADsLHIR4c/x7Q7wLTB3Mw2aw=;
        b=N5x9Ponuc1QqmsFp4XPQOgs8joInICnknQS3MCZEqQsjjGGEi+lkxJOCpFj3owuo1m
         ddWmthUpjTgDPzdysdSC9IK6hOHtq/H/OntfnCiC59SeK1WA/oUZ+TjRxik/8ds0ifVB
         jdVyFNYfjdrrIh00sAGZisV8zX4Ljx5QKtKoOFNOlA0se8cDVZU5n2rPyUiNsOHwdffB
         sFe5TXVWJi+NC3DYlv8J6Ov8wXIVp5p7Vs0kwqSuLYJS0P/ixpAP/H0fvGZQvgtrqsy+
         5Q52giUwcPlZLFZ87k5HZGrj8VIQYnDeuepMrs8DgXvVqXZvkB7WDBvc5Wh1QbvscFmz
         zrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EwRWG/gC2fE5xGCjSTzADsLHIR4c/x7Q7wLTB3Mw2aw=;
        b=BMoRqgBspjSdh01b1LZJA7NfKNIQWDrk8iBfHgwonq25yZmVSgvdEuoeZ8wKs8owbX
         mkRF7/8y8e1pd6Nr/Najl6uwfCXZhL1VvEaDXgQ/afn5q7ukjWGL0ED846BveU9ppEO+
         qwSLEopEjc6HlfBA+9KKsm2aNyzQKQRoNq8EfgkOY98Dc4WJE2XqCl63pY0hcy1uCqpA
         DKW8OBkChNOweBM9O80UtU1UOVTm4soZ4WNUdhuXWk/yB+qkVd6LlcHIV1KQUziL9Kfo
         hgavr7joHiokCxRn8mhCZxo92wwgp+4WQCvp9qDnvq9XvfqR0Ix1LfUwHW187CsUh53s
         9AGA==
X-Gm-Message-State: AOAM533/DYcZFkcS5QtaNQ1Fe46lDYAj1vfs4YBLSn/Xa+6Rvtk3gACL
        CH5wTRjRpxx2ks0QYDKba4U=
X-Google-Smtp-Source: ABdhPJz6oVxnweXT2dqwWQnEyppFAKlUjrcaw18qilP/WoRKuTtyE+F+lB0uEg4OHT36Sj9Mhd6l0A==
X-Received: by 2002:a05:651c:983:: with SMTP id b3mr18480409ljq.287.1628585193977;
        Tue, 10 Aug 2021 01:46:33 -0700 (PDT)
Received: from kari-VirtualBox (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id t17sm1978398lfe.303.2021.08.10.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 01:46:33 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:46:31 +0300
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-kernel@vger.kernel.org, dsterba@suse.cz, aaptel@suse.com,
        willy@infradead.org, rdunlap@infradead.org, joe@perches.com,
        mark@harmstone.com, nborisov@suse.com,
        linux-ntfs-dev@lists.sourceforge.net, anton@tuxera.com,
        dan.carpenter@oracle.com, hch@lst.de, ebiggers@kernel.org,
        andy.lavr@gmail.com, oleksandr@natalenko.name
Subject: Re: [PATCH v27 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20210810084631.63cmowvgjs5lj4au@kari-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210810081955.b5vdsfc2tdaabbgo@pali>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 10:19:55AM +0200, Pali Rohár wrote:
> On Tuesday 10 August 2021 10:47:40 Kari Argillander wrote:
> > On Thu, Jul 29, 2021 at 04:49:41PM +0300, Konstantin Komarov wrote:
> > > This adds Kconfig, Makefile and doc
> > > 
> > > Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > > ---
> > >  Documentation/filesystems/ntfs3.rst | 107 ++++++++++++++++++++++++++++
> > 
> > Still missing Documentation/filesystems/index.rst as I stated before
> > https://lore.kernel.org/linux-fsdevel/20210103220739.2gkh6gy3iatv4fog@kari-VirtualBox/
> > 
> > >  fs/ntfs3/Kconfig                    |  46 ++++++++++++
> > >  fs/ntfs3/Makefile                   |  36 ++++++++++
> > >  3 files changed, 189 insertions(+)
> > >  create mode 100644 Documentation/filesystems/ntfs3.rst
> > >  create mode 100644 fs/ntfs3/Kconfig
> > >  create mode 100644 fs/ntfs3/Makefile
> > > 
> > > diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
> > 
> > 
> > > +Mount Options
> > > +=============
> > > +
> > > +The list below describes mount options supported by NTFS3 driver in addition to
> > > +generic ones.
> > > +
> > > +===============================================================================
> > > +
> > > +nls=name		This option informs the driver how to interpret path
> > > +			strings and translate them to Unicode and back. If
> > > +			this option is not set, the default codepage will be
> > > +			used (CONFIG_NLS_DEFAULT).
> > > +			Examples:
> > > +				'nls=utf8'
> > 
> > It seems that kernel community will start use iocharset= as default. nls
> > option can still be alias but will need deprecated message. See message
> > https://lore.kernel.org/linux-fsdevel/20200102211855.gg62r7jshp742d6i@pali/
> > 
> > and current work from Pali
> > https://lore.kernel.org/linux-fsdevel/20210808162453.1653-1-pali@kernel.org/
> > 
> > This is still RFC state so probably no horry, but good to know stuff. I
> > also added Pali so he also knows.
> 
> I was already in loop :-)

Yeah just added To: so that you really know someone mention you.

> Anyway, yes, above RFC patch migrates all drivers to use iocharset=
> mount option as it is the option which is already used by most fs
> drivers. So argument is consistency.
> 
> But having the preferred mount option name in new fs drivers would
> decrease work needed to done in that patch series.

Yeah it would be prefered that before this gets Linus tree then this
will use iocharset. Because this driver will probably replace NTFS
driver some day I think it is still good idea to make nls= alias. And
also because Paragon's own customers will might use it and there is
already many many users who uses ntfs3 because it is included some "must
have kernel patch lists".

