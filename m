Return-Path: <linux-fsdevel+bounces-47359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10CEA9C7DB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 13:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61491BC4A33
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04D1C7019;
	Fri, 25 Apr 2025 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sernet.de header.i=@sernet.de header.b="sm0aI01L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.sernet.de (mail.sernet.de [185.199.217.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C054022DFB6
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Apr 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.199.217.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745581241; cv=none; b=kPGVBkmaERJAwJ51HSRnN1mBJ0JGhzwAaXsCtrKuf+CparCyldZT1X0Fg7gFn2dPLmoCRBnzRDNJZWql+TxW9z44ga7M5Dh9AaE/Te7JAhvXDsfM+M9PAdPPRz27cWXqBR+P3r4NID/oz4RIxTLzEweZuXp/kXDtM8GktZnydpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745581241; c=relaxed/simple;
	bh=fZA5VwWDJzT7s1XtXV+i27EDcypQjIMw0KdYu1pMZEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3U7oOin8PGDz99iQXf8UNpj/leRvV7+s9hC31AFlkhe3myfckluPWOODmKjtBMqvvwrrT/XjjSlVuutEGWTu1B4xDBl1IG7fZ052IQZbZTt4SmExBaXE44r7kPMT86UhByENH7IEm6UDvLNpaqs6jHd3qffKTMcrxwJMabMT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=SerNet.DE; spf=pass smtp.mailfrom=sernet.de; dkim=pass (2048-bit key) header.d=sernet.de header.i=@sernet.de header.b=sm0aI01L; arc=none smtp.client-ip=185.199.217.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=SerNet.DE
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sernet.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sernet.de;
	s=20210621-rsa; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6mV+Bjw+FSYjQ+Cq4/20B1K+PXrFg47CbdQbXqBITlA=; b=sm0aI01LyreIuPAbbAn18anWdH
	oXD25KxmcSsv4V2nkgvF1uzyiA6ySAStV0Btbi86QxGq+NuyUSQ0A8XtL3kklhXx6F/hahpWT2ZO/
	0+fM4Tz/GzD4erbxM+f1s67tNDfIB5sB+uf/IcoN1j+1zDuSwu5cmOlFH0SpenFMrCWwseh5sVX4b
	hE2s1Xvnv+HO9vURE9gnfS2JrhbDp3rrdx9DjTuW/rzfY2rdYOki1XvgSAHSXO/1jFFq8z2wdjCfx
	vRSf+Bjwp8BQ4dhhyRashAK53OzImiAp1zHsos5AuxYit0zQ1OuIULis+yrbF38gQ99c14KKvlWRD
	E/h9tQyw==;
Date: Fri, 25 Apr 2025 13:40:26 +0200
From: =?iso-8859-1?Q?Bj=F6rn?= JACKE <bjacke@SerNet.DE>
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: casefold is using unsuitable case mapping table
Message-ID: <20250425114026.GA1032053@sernet.de>
References: <20250422123141.GD855798@sernet.de>
 <87h62dtjyk.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h62dtjyk.fsf@mailhost.krisman.be>
X-Q: Die Schriftsteller koennen nicht so schnell schreiben, wie die
 Regierungen Kriege machen; denn das Schreiben verlangt Denkarbeit. - Brecht

On 2025-04-24 at 15:53 -0400 Gabriel Krisman Bertazi sent off:
> The big problem is that each of the big OS vendors chose specific
> semantics of what to casefold.  APFS does NFD + full casefolding[1],
> right?  except for "some code-points". I'm not sure what they do with ß,
> tbh. I could never find any documentation on the specific code-points
> they add/ignore.

Apple basically stores the files in NFD and do casefolding but not those lossy
folding rules that make "ß" and "ss" equal. I have an overview of filesystems
and their encodings written up at
https://www.j3e.de/linux/convmv/man/#Filesystem-issues - that might be
interesting for the discussion also.


> In ext4, we decided to have no exceptions. Just do plain NFD + CF.  That
> means we do C+F from the table below:
> 
>   https://www.unicode.org/Public/12.1.0/ucd/CaseFolding.txt
> 
> Which includes ß->SS.  We could argue forever whether that doesn't make
> sense for language X, such as German.  I'm not a German speaker but
> friends said it would be common to see straße uppercased to STRASSE there,
> even though the 2017 agreement abolished it in favor of ẞ.  So what is
> the right way?

I am a German speaker, so I can shed light on that. "ß" and "ss" are definetely
not equal. If your Name is "Groß" this is a different Name than "Gross". The
word "Ma0e" exists and the word "Masse" existist, they are something completely
different. The only thing to say here is that people without that letter on the
keyboard often use "ss" as a fallback, just like writing "ae" is a common
fallback for writing "ä". In a filesystem they should not be projected on the
same file.

The main problem that was made when the casefolding was introduced in the Linux
kernel was to use all of the cases listed in
https://www.unicode.org/Public/12.1.0/ucd/CaseFolding.txt
If you grep for all the F flagged cases there (grep " F;") you will get 104
"casefold" rules, which are essentially bogous for filesystem casefolding. They
mainly reduce the number of valid codepoints for filenames. Apart of the German
"ß" they also contain ligatures and combinations of greek letters, which are
being "equalized". All of those reduced codepoints can be unique characters of
filenames on ci Windows or Apple filesystems, they are not considered for
casefolding in any way, except for the "simple" (S flagged) casefolding of the
corresponding codepoint.

Those F flagged casefolding make sense for cases like CTRL-F in browsers, there
you want to find places, where a "fi" ligature (ﬁ) is used if you search for
"fi" but in filenames you need to be able to use both. At least this is what
all operating systems with case-insensitive filesystems do (except for Linux
till now).


> My point is we can't rely fully on languages to argue the right
> semantics.  There are no right semantics.  And Languages are also alive
> and changing. There are many other examples where full casefold will
> look stupid; for instance, one would argue we should also translate the
> T column (i.e non-Turkish languages).

The Turkish language with the dottet/dotless i/I is a very special and
exceptional case, ci is not being done for that in any other ci filesystem
implementation. The i/I case doesn't really matter in this discussion.


> It is not useless.  Android and Wine emulators have been using it just
> fine for years.  We also cannot break compatibility for them.

I understand that we can't break compatibility with it but we should try to
find a way to improve the current situation, which is far from being good.


> > Can this be changed without causing too much hassle?
> 
> We attempted to do a much smaller change recently in commit
> 5c26d2f1d3f5, because we assumed no one would be trying to create files
> with silly stuff like ZWSP (U+200B). Turns out there is a reasonable
> use-case for that with Variation Selectors, and we had to revert it.  So
> we need to be very careful with any changes here, so people don't lose
> access to their files on a kernel update.  Even with that, more
> casefolding flavor will cause all sorts of compatibility issues when
> moving data across volumes, so I'd be very wary of having more than one
> flavor.

especially becasue files should be movable also from other platforms also, we
should be very close to what other platforms do here. The fact that our
casefolding is significantly recuding the number of possible codepoints (the
104 F flagged ones), causes a major interoperability problem.


> What are the exact requirements for samba?  Do you only fold the C
> column? Do you need stuff like compatibility normalization?

For Samba it's required that we don't have a reduced set of valid Unicode
characters. And that means that the F flaged mappings are not being used. The
Turkish T mapping should also not be used.
Mappings we should use:
- the "C"ommonand  and
- the "S"imple
flagged mappings from the Unicode mapping table only.

I understand that it's difficult to change this as we store hashes of the
current lowercase version of the filenames. I'm not an expert enough in the
filesystem code to come up with a good idea how to solve this though.
Eventually we can use different versions of casefolding tables and store in the
filesystem, which version to use?

