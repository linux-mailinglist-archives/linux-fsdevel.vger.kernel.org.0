Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E511405E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jan 2020 10:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgAQJMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jan 2020 04:12:49 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36473 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgAQJMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:12:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so21915015wru.3;
        Fri, 17 Jan 2020 01:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=9CWsLIqrwr5TTd8YCdk6c0DzhIAalvDRij2MWOTKamY=;
        b=lhgfgKE6EJRm2r/haIoK6XaxGkEeldPrTIUTJe8hm4n3MBfQwXTGIfYHmUCej37+Aa
         qhom8q3kuKaMIzma4dLvW6JHgF8UB59+pVTgnzYLpcsMOsrl2H2oXapx951+uEF/9Ehf
         /u+IgExKvlV6VhEhd4CtFR05GEUudpDjupKLJgGHRDkbsC5w54dCWi+C07kuc2Ki84Mo
         jJ/AufZc2OFwud68n5+0CyqLPQroEPvLmt5Of4LfrOGUMuo6bUzDYaG44hhHYf5jm+V8
         SHtMyBmUlLCnPLP0YeV1cPqCO29knY+QqsaShro0uEHYZ/38J/2I/J8q4VBquWFz+IJ9
         UBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=9CWsLIqrwr5TTd8YCdk6c0DzhIAalvDRij2MWOTKamY=;
        b=MALrUIXgmJaISQP/8O9sIM2oBdnx2yIB7NlTujQ6md9V62DbcudoMzTWGMkt0TVjpy
         CoKBENVRauAhJjBK178D+z03PU6FlPWjDowSLXiYoidIgO0JlFptZTbcNEwccHQlpn1Z
         iyqcmUcfBnCnb95ii0ULG3R5OD60ArvF98+d91/8j6GNYXmZhYanbrOOD72xJYh0WRsG
         Pwcy23ri2mGa/U063TCk+4M6cbMiv667dnOlShsaMt+W5ra9vkiiCruq1taYPW2fBxDX
         v3/fA+YmIxp+I430z6/G62p/CMUHjQNqJuSY9zXeFIV87pFXpRs7X0qley0LXqMmjrIj
         PBgQ==
X-Gm-Message-State: APjAAAXaj5VGlPkw7dEPRAZJ6i5MYrqMIYTQb6Yarn45oEoK6H3qEDfR
        pj67ejftkGbJtS/FGC4BQYY=
X-Google-Smtp-Source: APXvYqywXwV7gAnLawo5RzJtIA5adPds/GcA0eswqRb5VaeqYfgpTVOyApPsfA1b8TxRigDunLGCiA==
X-Received: by 2002:adf:8041:: with SMTP id 59mr1934966wrk.257.1579252367494;
        Fri, 17 Jan 2020 01:12:47 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id b16sm34694644wrj.23.2020.01.17.01.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 01:12:46 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:12:45 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu, hch@lst.de,
        sj1557.seo@samsung.com, linkinjeon@gmail.com, arnd@arndb.de
Subject: Re: [PATCH v10 11/14] exfat: add Kconfig and Makefile
Message-ID: <20200117091245.ginzffry7anqofju@pali>
References: <20200115082447.19520-1-namjae.jeon@samsung.com>
 <CGME20200115082825epcas1p1f22ddca6dbf5d70e65d3b0e3c25c3a59@epcas1p1.samsung.com>
 <20200115082447.19520-12-namjae.jeon@samsung.com>
 <20200115093915.cjef2jadiwe2eul4@pali>
 <002f01d5cced$ba0828b0$2e187a10$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <002f01d5cced$ba0828b0$2e187a10$@samsung.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Friday 17 January 2020 13:22:27 Namjae Jeon wrote:
> > > +config EXFAT_DEFAULT_IOCHARSET
> > > +	string "Default iocharset for exFAT"
> > > +	default "utf8"
> > > +	depends on EXFAT_FS
> > > +	help
> > > +	  Set this to the default input/output character set you'd
> > > +	  like exFAT to use. It should probably match the character set
> > > +	  that most of your exFAT filesystems use, and can be overridden
> > > +	  with the "iocharset" mount option for exFAT filesystems.
> > 
> > Hello! This description is incorrect. iocharset option specify what
> > character set is expected by VFS layer and not character set used by exFAT
> > filesystem. exFAT filesystem always uses UTF-16 as this is the only
> > allowed by exFAT specification.
> Hi Pali,
> 
> Could you please review updated description ?
> 
> diff --git a/fs/exfat/Kconfig b/fs/exfat/Kconfig
> index 9eeaa6d06..f2b0cf2c1 100644
> --- a/fs/exfat/Kconfig
> +++ b/fs/exfat/Kconfig
> @@ -15,7 +15,7 @@ config EXFAT_DEFAULT_IOCHARSET
>         default "utf8"
>         depends on EXFAT_FS
>         help
> -         Set this to the default input/output character set you'd
> -         like exFAT to use. It should probably match the character set
> -         that most of your exFAT filesystems use, and can be overridden
> -         with the "iocharset" mount option for exFAT filesystems.
> +         Set this to the default input/output character set to use for
> +         converting between the encoding is used for user visible filename and
> +         UTF-16 character that exfat filesystem use. and can be overridden with
> +         the "iocharset" mount option for exFAT filesystems.

Hello! This is much better. Fine for me.

-- 
Pali Rohár
pali.rohar@gmail.com
