Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90BB288D40
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbgJIPri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 11:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389144AbgJIPri (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 11:47:38 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47EF20658;
        Fri,  9 Oct 2020 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602258457;
        bh=YrZvXgpNpQFMPy1K3qREb5b4WS6IxWnTEICmVQrbelw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0qMHyT/vvQ2hUlPVJSCVY1jTmFG3N7/WfU2egHZUjxUIVY628t2MDujj6UhW6vxwO
         /+nLdUPZGou1WuFdIW9mzURWrnD+2mK7L3FKi/sQMYqcSqqZrewgIEv/BV5giDtKRM
         sRl34eVr15c+4mljjx17dF0HZCYRniCiiVpkpgCk=
Received: by pali.im (Postfix)
        id 74CD2515; Fri,  9 Oct 2020 17:47:34 +0200 (CEST)
Date:   Fri, 9 Oct 2020 17:47:34 +0200
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
Message-ID: <20201009154734.andv4es3azkkskm5@pali>
References: <20200911141018.2457639-1-almaz.alexandrovich@paragon-software.com>
 <20200911141018.2457639-9-almaz.alexandrovich@paragon-software.com>
 <20200921132631.q6jfmbhqf6j6ay5t@pali>
 <7facb550be6449c2b35f467ab1716224@paragon-software.com>
 <20200926082324.npbljzb3ydkfbswy@pali>
 <940ff3bbce3e4c8b9cb5666c3f5c113f@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <940ff3bbce3e4c8b9cb5666c3f5c113f@paragon-software.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 09 October 2020 15:31:10 Konstantin Komarov wrote:
> From: Pali Rohár <pali@kernel.org>
> Sent: Saturday, September 26, 2020 11:23 AM
> > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; dsterba@suse.cz; aaptel@suse.com;
> > willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmstone.com; nborisov@suse.com
> > Subject: Re: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
> > 
> > On Friday 25 September 2020 16:30:19 Konstantin Komarov wrote:
> > > From: Pali Rohár <pali@kernel.org>
> > > Sent: Monday, September 21, 2020 4:27 PM
> > > > To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
> > > > Cc: linux-fsdevel@vger.kernel.org; viro@zeniv.linux.org.uk; linux-kernel@vger.kernel.org; dsterba@suse.cz; aaptel@suse.com;
> > > > willy@infradead.org; rdunlap@infradead.org; joe@perches.com; mark@harmstone.com; nborisov@suse.com
> > > > Subject: Re: [PATCH v5 08/10] fs/ntfs3: Add Kconfig, Makefile and doc
> > > >
> > > > On Friday 11 September 2020 17:10:16 Konstantin Komarov wrote:
> > > > > +Mount Options
> > > > > +=============
> > > > > +
> > > > > +The list below describes mount options supported by NTFS3 driver in addition to
> > > > > +generic ones.
> > > > > +
> > > > > +===============================================================================
> > > > > +
> > > > > +nls=name		This option informs the driver how to interpret path
> > > > > +			strings and translate them to Unicode and back. If
> > > > > +			this option is not set, the default codepage will be
> > > > > +			used (CONFIG_NLS_DEFAULT).
> > > > > +			Examples:
> > > > > +				'nls=utf8'
> > > > > +
> > > > > +nls_alt=name		This option extends "nls". It will be used to translate
> > > > > +			path string to Unicode if primary nls failed.
> > > > > +			Examples:
> > > > > +				'nls_alt=cp1251'
> > > >
> > > > Hello! I'm looking at other filesystem drivers and no other with UNICODE
> > > > semantic (vfat, udf, isofs) has something like nls_alt option.
> > > >
> > > > So do we really need it? And if yes, it should be added to all other
> > > > UNICODE filesystem drivers for consistency.
> > > >
> > > > But I'm very sceptical if such thing is really needed. nls= option just
> > > > said how to convert UNICODE code points for userpace. This option is
> > > > passed by userspace (when mounting disk), so userspace already know what
> > > > it wanted. And it should really use this encoding for filenames (e.g.
> > > > utf8 or cp1251) which already told to kernel.
> > >
> > > Hi Pali! Thanks for the feedback. We do not consider the nls_alt option as the must have
> > > one. But it is very nice "QOL-type" mount option, which may help some amount of
> > > dual-booters/Windows users to avoid tricky fails with files originated on non-English
> > > Windows systems. One of the cases where this one may be useful is the case of zipping
> > > files with non-English names (e.g. Polish etc) under Windows and then unzipping the archive
> > > under Linux. In this case unzip will likely to fail on those files, as archive stores filenames not
> > > in utf.
> > 
> > Hello!
> > 
> > Thank you for providing example. Now I can imagine the problem which
> > this option is trying to "workaround".
> > 
> > Personally, I think that this is the issue of the program which is
> > unzipping content of the archive. If files are in archive are stored in
> > different encoding, then user needs to provide information in which it
> > is stored. Otherwise it would be broken.
> > 
> 
> Hi Pali! Partially it is the issue of the program. But such issue may affect
> a lot of programs, esp. given that this case is somehwat niche for the Linux,
> because it origins in Windows. We may assume it is unlikely a lot of programs
> will try/are trying to support this case. The mount option, on the other hand,
> gives this ability without relying on the application itself.

Hello! I understand this issue. But what you have described is basically
filesystem independent, this may happen also on ext4 with UNICODE
support and also on fat32 with VFAT support.

Therefore I do not think it is good idea to have e.g. nls_alt=cp1251
option directly in just one filesystem driver.

This would just make ntfs driver inconsistent with other Linux UNICODE
filesystem drivers and it would cause more problems that application
unzip is working with ntfs driver, but does not work with vfat or ext4
driver.

I would really suggest to not include this nls_alt option into
filesystem driver. And rather come up with some universal solution for
all UNICODE filesystem drivers. There are multiple solutions, e.g.
implement option in VFS layer and propagate it to UNICODE fs drivers, OR
implement NLS codepage which would handle it...

Inconsistency of one FS driver with all other would really cause
problems if not now, then in future.

This issue which you described is already there, also without ntfs
driver. And still adding something for ntfs driver looks like a
workaround or hack for that issue. Not a solution.

> > Also this your approach with nls=utf-8 and nls_alt=cp1251 is broken. I
> > can provide you string encoded in cp1251 which is also valid UTF-8
> > sequence.
> > 
> > For example: sequence of bytes "d0 93".
> > 
> > In cp1251 it is Р“, but also it is valid UTF-8 sequence for Г (CYRILLIC
> > CAPITAL LETTER GHE).
> > 
> > Because cp1251 is set as nls_alt, you would get UTF-8 interpretation.
> > And for all other invalid UTF-8 sequences you would get cp1251.
> > 
> > For me it looks like you are trying to implement workaround based on
> > some heuristic in kernel for userspace application which handles
> > encoding incorrectly. And because all CP???? encodings are defined at
> > full 8bit space and UTF-8 is subset of 8bit space, it would never work
> > correctly.
> > 
> 
> In this case, the whole string will be treated as UTF-8 string, no matter of
> what's the value of "nls_alt" option. The option's related logic starts to be applied
> only for those strings which contain "invalid" UTF-8 character. And it works not in
> symbol-by-symbol way, but applies to the whole string. So if a string does not
> contain invalid UTF-8, the "nls_alt" won't be applied, even if set. And if the string
> contains invalid UTF-8 AND "nls_alt" is set, then the logic will be applied with assumption
> that user, when set the "nls_alt" had in mind that he may be in such situation.
> 
> When it is coming to valid UTF-8 sequences, which are actually meant to represent another
> encoding, there is ambiguity, which seems unable to be resolved both with and without
> the "nls_alt". But at least those cases, when the sequence is incorrect UTF-8, but correct
> e.g. CP-1251, may be solved with the "nls_alt", but not without it. 
> 
> It is not covering all the cases, but covers at least those, which otherwise lead to inability
> operating with the file (e.g. error during unzip). Also it is set only explicitly by the user.
> 
> We'll follow the community opinion in our implementation, just want to make sure the
> solution is understood correctly. Regarding the "nls_alt", it doesn't seem
> to be harmful in any way, but may help some amount of users to overcome interoperability
> issues.
> 
> > Also I do not think that kernel is correct place for workarounding
> > userspace applications which handles encoding incorrectly.
> > 
> > > Windows have that "Language for non-Unicode programs" setting, which controls the
> > > encoding used for the described (and similar) cases.
> > 
> > This windows setting is something different. It is system wide option
> > which affects -A WINAPI functions and defines one fixed 8bit encoding
> > (ACP) which should be used for converting UTF-16 strings (wchar_t*) into
> > 8bit (char*) ACP encoding.
> > 
> > It is something similar to Unix CODESET set in LC_CTYPE from locale. But
> > not the same.
> > 
> > > Overall, it's kinda niche mount option, but we suppose it's legit for Windows-originated filesystems.
> > > What do you think on this, Pali?
> > 
> > I think this is not only for Windows-orientated FS, but rather for all
> > filesystems which store filenames in UNICODE (as opposite of sequence of
> > bytes).
> > 
> > E.g. ext4 now has extension for storing (and validating) that filenames
> > are also in UNICODE (on disk it is in UTF-8).
> > 
> > Same for Beos FS or UDF fs (on DVD/BD-R). In most cases these fs are
> > mounted with nls=utf-8 to interpret UNICODE as utf-8.
> > 
> > And none of these fs have such nls_alt option as I show above, it cannot
> > work reliable.
> 
> Thanks.
