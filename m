Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C600612F5AB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 09:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgACIoJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jan 2020 03:44:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33964 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgACIoJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:44:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so41679962wrr.1;
        Fri, 03 Jan 2020 00:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wpD/6DTuwbigjHCA/o7EMJw93xJaBjyDyEiLPgWqJJc=;
        b=mlZpNNff/qedkvnBWrceuPOTF2vKYZ9zhE+EBwz3qU+C1EuM+3v4WeJ9FtpV39rY1s
         eVAUOi9RBj5dP/i+BnBeQ+bdVMRNHclB0vgjDGvzePLRvZ8cqitV8M0ZCZYZQvlyZ3OZ
         P2BZ84hBgBFc7c84Z/amjquJ/kghUToD1vbsME/Wev8dcJuuY8Ln53LZM7ZBqeXILs7X
         k4IE2lY1NQZ2r+LP/OY41M6ErUMeqScoYJLNg6oC+WlLbSxBLj9UCou6l5oZ2AZvNdFV
         h/tJwCFg21vHvmBtXrGmgvu+n1qGKFfTbNIySXyd7ity/LThB91szujBEoDWn+pNB/l0
         tPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wpD/6DTuwbigjHCA/o7EMJw93xJaBjyDyEiLPgWqJJc=;
        b=Lq7B2sWC3MyS8r+EchTu0dP5O6inFsuqjG/KOHTDZJdUu1sR2O5iynQrAVrFQcpE+K
         aCOkcDKvDjtLk0zUeSFp75rX1TVYHfGQ1NrkU6jW1OHe05cEjgDW6sgSmhlFT1F8ttvl
         TMocWfxeZlApLSSyPrrUf6EroS0i+YQUUgKeYTo9XAAfHDZgTgENZlqT1DczjLxeb7EP
         LpaU6yWfLsYzsZPN8nwU2GqlK+XDyJIH4M++kkutb3Ui2GUocK7jX5CMtNaz3AMifgJo
         0hTC+sUFGv20KS7vMSg0E/7pxT5Pw70BKUG6isPeOFykItAmcWT5K1qtRS1tifbN2jxl
         ffiA==
X-Gm-Message-State: APjAAAWBcUZQ9CtCT6avD0G9Fz9VGa7dlzNzPHYZVXGdCWnjwyqivjfT
        R9SM2OWv8T2CnIyvKGmo0ng=
X-Google-Smtp-Source: APXvYqwnTSmXYD7phPs5A9se1DbEYruQ+lnYzvLFX3B+NPj5gayWwnvL2tM+oQ3M808O6qy2Htl5og==
X-Received: by 2002:adf:f28c:: with SMTP id k12mr85152511wro.360.1578041046918;
        Fri, 03 Jan 2020 00:44:06 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b68sm11257968wme.6.2020.01.03.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 00:44:06 -0800 (PST)
Date:   Fri, 3 Jan 2020 09:44:04 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com
Subject: Re: [PATCH v9 10/13] exfat: add nls operations
Message-ID: <20200103084404.tv3fchjmw3ltmwrr@pali>
References: <20200102082036.29643-1-namjae.jeon@samsung.com>
 <CGME20200102082407epcas1p4cf10cd3d0ca2903707ab01b1cc523a05@epcas1p4.samsung.com>
 <20200102082036.29643-11-namjae.jeon@samsung.com>
 <20200102135502.hkey7z45gnprinpp@pali>
 <003101d5c204$5046e9a0$f0d4bce0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <003101d5c204$5046e9a0$f0d4bce0$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 03 January 2020 16:06:25 Namjae Jeon wrote:
> > On Thursday 02 January 2020 16:20:33 Namjae Jeon wrote:
> > > This adds the implementation of nls operations for exfat.
> > >
> > > Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
> > > Signed-off-by: Sungjong Seo <sj1557.seo@samsung.com>
> > > ---
> > >  fs/exfat/nls.c | 809
> > > +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 809 insertions(+)
> > >  create mode 100644 fs/exfat/nls.c
> > >
> > > diff --git a/fs/exfat/nls.c b/fs/exfat/nls.c new file mode 100644
> > > index 000000000000..af52328e28ff
> > > --- /dev/null
> > > +++ b/fs/exfat/nls.c
> > 
> > ...
> > 
> > > +int exfat_nls_uni16s_to_vfsname(struct super_block *sb,
> > > +		struct exfat_uni_name *uniname, unsigned char *p_cstring,
> > > +		int buflen)
> > > +{
> > > +	if (EXFAT_SB(sb)->options.utf8)
> > > +		return __exfat_nls_utf16s_to_vfsname(sb, uniname, p_cstring,
> > > +				buflen);
> > > +	return __exfat_nls_uni16s_to_vfsname(sb, uniname, p_cstring,
> > buflen);
> > > +}
> > 
> > Hello, I'm looking at this function and basically it do nothing.
> > Or was it supposed that this function should do something more for UTF-8
> > encoding?
> > 
> > There is one if- statement, but in both branches is executed exactly
> > same code.
> > 
> > And executed function just pass same arguments as current callee
> > function.
> > 
> > So calls to exfat_nls_uni16s_to_vfsname() can be replaced by direct
> > calls to __exfat_nls_uni16s_to_vfsname().
> Ah, The function names are similar, but not same. see utf16s/uni16s.
> 
> Thanks!

Ou, sorry for that :-(

I will look again and more deeply at this encoding code as I think there
can be some problem with processing utf-16 buffers...

> > 
> > Or maybe better, rename __exfat_nls_uni16s_to_vfsname() function to
> > exfat_nls_uni16s_to_vfsname().
> > 
> > > +int exfat_nls_vfsname_to_uni16s(struct super_block *sb,
> > > +		const unsigned char *p_cstring, const int len,
> > > +		struct exfat_uni_name *uniname, int *p_lossy)
> > > +{
> > > +	if (EXFAT_SB(sb)->options.utf8)
> > > +		return __exfat_nls_vfsname_to_utf16s(sb, p_cstring, len,
> > > +				uniname, p_lossy);
> > > +	return __exfat_nls_vfsname_to_uni16s(sb, p_cstring, len, uniname,
> > > +			p_lossy);
> > > +}
> > 
> > And same for this function.
> > 
> > --
> > Pali Rohár
> > pali.rohar@gmail.com
> 
> 

-- 
Pali Rohár
pali.rohar@gmail.com
