Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06E2D17CD68
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 11:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgCGKCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 05:02:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbgCGKB7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 05:01:59 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DEB4206D5;
        Sat,  7 Mar 2020 10:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583575318;
        bh=K57qheI3BUpEK74C2M8dStCHv7ATP2ASTLRAtzGxQpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ucBz2YSHIN/jLFT1Th7tmwlEMgYBachNyqUpxAr3o8UYYjXUF0ZxCqSWqwyvRPyge
         RDbJFh1lkxwghJX9TvLBD37F1kfD6g9JTLON/X6d5H+Z/G/iTKg0cRlHsaAX76Mpoe
         3V8RCtWDkNx5m/OlnSPoVSu1kgrGR4qnj5TmKZDY=
Date:   Sat, 7 Mar 2020 11:01:54 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
Message-ID: <20200307110154.719572e4@onda.lan>
In-Reply-To: <alpine.DEB.2.21.2003062214500.5521@felia>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
        <20200304131035.731a3947@lwn.net>
        <alpine.DEB.2.21.2003042145340.2698@felia>
        <e43f0cf0117fbfa8fe8c7e62538fd47a24b4657a.camel@perches.com>
        <alpine.DEB.2.21.2003062214500.5521@felia>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Em Fri, 6 Mar 2020 22:17:49 +0100 (CET)
Lukas Bulwahn <lukas.bulwahn@gmail.com> escreveu:

> On Wed, 4 Mar 2020, Joe Perches wrote:
> 
> > On Wed, 2020-03-04 at 21:50 +0100, Lukas Bulwahn wrote:  
> > > 
> > > On Wed, 4 Mar 2020, Jonathan Corbet wrote:
> > >   
> > > > On Wed,  4 Mar 2020 08:29:50 +0100
> > > > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:  
> > > > > Jonathan, pick pick this patch for doc-next.  
> > > > 
> > > > Sigh, I need to work a MAINTAINERS check into my workflow...
> > > >   
> > > 
> > > I getting closer to have zero warnings on the MAINTAINER file matches and 
> > > then, I would set up a bot following the mailing lists to warn when anyone
> > > sends a patch that potentially introduces such warning.  
> > 
> > Hey Lukas.
> > 
> > I wrote a hacky script that sent emails
> > for invalid MAINTAINER F: and X: patterns
> > a couple years back.
> > 
> > I ran it in September 2018 and March 2019.
> > 
> > It's attached if you want to play with it.
> > The email sending bit is commented out.
> > 
> > The script is used like:
> > 
> > $ perl ./scripts/get_maintainer.pl --self-test=patterns | \
> >   cut -f2 -d: | \
> >   while read line ; do \
> >     perl ./dump_section.perl $line \
> >   done
> >   
> 
> Thanks, Joe. That is certainly helpful, I will try to make use of it in 
> the future; fortunately, there really not too many invalid F: patterns 
> left, and I can send the last few patches out myself.

Talking about problems at MAINTAINERS file, while the entries are
supposed to be in alphabetical order, there are some things at the
wrong place there.

This can easily seen with:

	$ cat MAINTAINERS |grep -E '^[A-Z][A-Z]' >a;sort -f a >b;diff -U1 a b|less

See for example the first hunk:

@@ -54,3 +54,2 @@
 ALACRITECH GIGABIT ETHERNET DRIVER
-FORCEDETH GIGABIT ETHERNET DRIVER
 ALCATEL SPEEDTOUCH USB DRIVER

The FORCEDETH entry is completely misplaced.

Same happens here:

@@ -529,4 +529,2 @@
 DIOLAN U2C-12 I2C DRIVER
-FILESYSTEM DIRECT ACCESS (DAX)
-DEVICE DIRECT ACCESS (DAX)
 DIRECTORY NOTIFICATION (DNOTIFY)

With this name, the FILESYSTEM DIRECT ACCESS (DAX) is also misplaced.
Maybe it was called something else starting with DEVICE in the past?

In any case, I wonder if it would make sense to re-order at least those 
completely out order entries. On a quick check,  there are only 16 entries
that seem to be really wrong, if we compare just the first two
characters of the entries names.

I'm using this small perl script to check:

	open IN, "MAINTAINERS";
	my $prev = "00";
	while (<IN>) {
		next if (m/THE REST/);
		if (m/^([A-Z\d][A-Z\d])/) {
			$cur = $1;
			$entry = $_;
			$entry =~ s/\s+$//;
			print "$entry < $full_prev\n" if ($cur lt $prev);
			$prev = $cur;
			$full_prev = $entry;
		}
	}

It got those results:

	ALCATEL SPEEDTOUCH USB DRIVER < FORCEDETH GIGABIT ETHERNET DRIVER
	AMAZON ANNAPURNA LABS FIC DRIVER < ARM PRIMECELL VIC PL190/PL192 DRIVER
	802.11 (including CFG80211/NL80211) < CFAG12864BFB LCD FRAMEBUFFER DRIVER
	DEVICE DIRECT ACCESS (DAX) < FILESYSTEM DIRECT ACCESS (DAX)
	GASKET DRIVER FRAMEWORK < GCC PLUGINS
	NXP FSPI DRIVER < OBJAGG
	OMFS FILESYSTEM < ONION OMEGA2+ BOARD
	FLYSKY FSIA6B RC RECEIVER < PHOENIX RC FLIGHT CONTROLLER ADAPTER
	HANTRO VPU CODEC DRIVER < ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
	REALTEK WIRELESS DRIVER (rtlwifi family) < RTL8187 WIRELESS DRIVER
	EMMC CMDQ HOST CONTROLLER INTERFACE (CQHCI) DRIVER < SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) DRIVER
	SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) MICROCHIP DRIVER < SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
	SERIAL LOW-POWER INTER-CHIP MEDIA BUS (SLIMbus) < SLEEPABLE READ-COPY UPDATE (SRCU)
	EXTRA BOOT CONFIG < STMMAC ETHERNET DRIVER
	TEMPO SEMICONDUCTOR DRIVERS < TRIVIAL PATCHES
	RCMM REMOTE CONTROLS DECODER < WINBOND CIR DRIVER

	
Regards,
Mauro
