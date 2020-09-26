Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF012797EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Sep 2020 10:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgIZIX2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 26 Sep 2020 04:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgIZIX1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 Sep 2020 04:23:27 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB3B020878;
        Sat, 26 Sep 2020 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601108607;
        bh=wITLVVzqw/4Gk3HJIgwI4h6LRF3X+gDtOPA/5VvuV/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iL9QB/smYYV6fhCm+I84mqen5WFjrj2NwY8JPl0HWzIyWMpJ0gVZCMgaIFCIFYZNy
         zRad8SJ7ZqAHe0TC3gWsaFOfhd5FH9/Z3Gw6/1LlXIBdGZNw5+DFMPiAkTeZ4+wMPb
         uUXwSLX5D6dNpnWbxh+yyl2uYcRxpbwkZAfArF8c=
Received: by pali.im (Postfix)
        id 57FE2FB2; Sat, 26 Sep 2020 10:23:24 +0200 (CEST)
Date:   Sat, 26 Sep 2020 10:23:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "aaptel@suse.com" <aaptel@suse.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "joe@perches.com" <joe@perches.com>,
        "mark@harmstone.com" <mark@harmstone.com>,
        "nborisov@suse.com" <nborisov@suse.com>
Subject: Re: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
Message-ID: <20200926082324.npbljzb3ydkfbswy@pali>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-9-almaz.alexandrovich@paragon-software.com>
 <20200921132631.q6jfmbhqf6j6ay5t@pali>
 <7facb550be6449c2b35f467ab1716224@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7facb550be6449c2b35f467ab1716224@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 25 September 2020 16:30:19 Konstantin Komarov wrote:
> From: Pali Rohár <pali@kernel.org>
> Sent: Monday, September 21, 2020 4:27 PM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; dsterba@suse.cz; aaptel@suse.com;
> > willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmstone.com; nborisov@suse.com
> > Subject: Re: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
> > 
> > On Friday 11 September 2020 17:10:16 Konstantin Komarov wrote:
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
> > > +
> > > +nls_alt=name		This option extends "nls". It will be used to translate
> > > +			path string to Unicode if primary nls failed.
> > > +			Examples:
> > > +				'nls_alt=cp1251'
> > 
> > Hello! I'm looking at other filesystem drivers and no other with UNICODE
> > semantic (vfat, udf, isofs) has something like nls_alt option.
> > 
> > So do we really need it? And if yes, it should be added to all other
> > UNICODE filesystem drivers for consistency.
> > 
> > But I'm very sceptical if such thing is really needed. nls= option just
> > said how to convert UNICODE code points for userpace. This option is
> > passed by userspace (when mounting disk), so userspace already know what
> > it wanted. And it should really use this encoding for filenames (e.g.
> > utf8 or cp1251) which already told to kernel.
> 
> Hi Pali! Thanks for the feedback. We do not consider the nls_alt option as the must have
> one. But it is very nice "QOL-type" mount option, which may help some amount of
> dual-booters/Windows users to avoid tricky fails with files originated on non-English
> Windows systems. One of the cases where this one may be useful is the case of zipping
> files with non-English names (e.g. Polish etc) under Windows and then unzipping the archive
> under Linux. In this case unzip will likely to fail on those files, as archive stores filenames not
> in utf.

Hello!

Thank you for providing example. Now I can imagine the problem which
this option is trying to "workaround".

Personally, I think that this is the issue of the program which is
unzipping content of the archive. If files are in archive are stored in
different encoding, then user needs to provide information in which it
is stored. Otherwise it would be broken.

Also this your approach with nls=utf-8 and nls_alt=cp1251 is broken. I
can provide you string encoded in cp1251 which is also valid UTF-8
sequence.

For example: sequence of bytes "d0 93".

In cp1251 it is Р“, but also it is valid UTF-8 sequence for Г (CYRILLIC
CAPITAL LETTER GHE).

Because cp1251 is set as nls_alt, you would get UTF-8 interpretation.
And for all other invalid UTF-8 sequences you would get cp1251.

For me it looks like you are trying to implement workaround based on
some heuristic in kernel for userspace application which handles
encoding incorrectly. And because all CP???? encodings are defined at
full 8bit space and UTF-8 is subset of 8bit space, it would never work
correctly.

Also I do not think that kernel is correct place for workarounding
userspace applications which handles encoding incorrectly.

> Windows have that "Language for non-Unicode programs" setting, which controls the
> encoding used for the described (and similar) cases.

This windows setting is something different. It is system wide option
which affects -A WINAPI functions and defines one fixed 8bit encoding
(ACP) which should be used for converting UTF-16 strings (wchar_t*) into
8bit (char*) ACP encoding.

It is something similar to Unix CODESET set in LC_CTYPE from locale. But
not the same.

> Overall, it's kinda niche mount option, but we suppose it's legit for Windows-originated filesystems.
> What do you think on this, Pali?

I think this is not only for Windows-orientated FS, but rather for all
filesystems which store filenames in UNICODE (as opposite of sequence of
bytes).

E.g. ext4 now has extension for storing (and validating) that filenames
are also in UNICODE (on disk it is in UTF-8).

Same for Beos FS or UDF fs (on DVD/BD-R). In most cases these fs are
mounted with nls=utf-8 to interpret UNICODE as utf-8.

And none of these fs have such nls_alt option as I show above, it cannot
work reliable.
