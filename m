Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81E9D116F06
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Dec 2019 15:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfLIOeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Dec 2019 09:34:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33660 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbfLIOeI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:34:08 -0500
Received: by mail-lj1-f193.google.com with SMTP id 21so15934710ljr.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 09 Dec 2019 06:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AoNQf5ZMoCElTqidsuopSf1YvkHAPV4/P6EB7Uneuvg=;
        b=astmu+VzoufKgfnh2KlgyOKlv8EQzwyGVqN0FUxogpSLoBvLsfzybSHAWBIzxPUc87
         ebLIifRVfXjoq+BJqfnstDRV6TqLqrCyNDCBeFWW9B1N4NuSSm0UC/8Ff0Tc8HhsVK1F
         5p06xrYejxV0WhGG2gT/8q3uiayRX0GhvsbHMzpO0KnUStsAaitNYKcU+BBQQnubyF6k
         qL7gYVk2rIFpNwUDGj8/W4HoyVz8bD8tzpUgI0Qq66iDt3Y/FS9dLG+nnWj86aVLr3AA
         08sk0iWQNSjtvYmNIbES9Y0TcToWAOVa68JEuD9X1xgXaQ4qZT7LHYjrJ5l3wOGrx/3N
         +blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AoNQf5ZMoCElTqidsuopSf1YvkHAPV4/P6EB7Uneuvg=;
        b=HmKkINbaAfiNRKc5Xxv97Vcc3LFHjxAHFHwZ285JUGkFT6bcheTTFdt2Y3BH9Js8Ls
         US1exFuZpTxeRH2GZ86X9+dmK4SW4TLkMD2ZYi484w2YghKIu2EokHy4tLNgZG9/RGQM
         NJtm2h5OY7DrFW8G+pzJERdwQ4rYkedzVDvIA/ByGDCXN8Ss7XfsmuFFj2dEp6cYFnY7
         PX/4QiJDSe3+GgWhuSlp/ZFp/ARffG16D4CAh2zs6TNKb4gqy5AHz9qRAfWbob4EZv6h
         u7pQamVId4NjOtCe1TuF9MHqjWob1mTJdup4qbwONaBFBuaj4FwbXhd7MHZmv/f40T4c
         VA8A==
X-Gm-Message-State: APjAAAWTPAc3T7uwck45NyRuFJsZA5+Ck1tCF2ZIrnjvkUSxHlPbEEOn
        LSDJG5/yg/rwK9NMRMpmKMtIbjT4zCFT0r6l
X-Google-Smtp-Source: APXvYqyUOwif3e2lN9GiZs8y0rrGcMI5dg1fFlH1INrpUiLDPNw7V1JPpBLwnm559j9p3bNwXBllSQ==
X-Received: by 2002:a2e:3609:: with SMTP id d9mr10237389lja.188.1575902046437;
        Mon, 09 Dec 2019 06:34:06 -0800 (PST)
Received: from msk1wst115n.omp.ru (mail.omprussia.ru. [5.134.221.218])
        by smtp.gmail.com with ESMTPSA id v24sm23611ljc.18.2019.12.09.06.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Dec 2019 06:34:05 -0800 (PST)
Message-ID: <e45222ab3f6292c013c93126078396f4b212d904.camel@dubeyko.com>
Subject: Re: [PATCH 01/41] fs/adfs: inode: update timestamps to centisecond
 precision
From:   Vyacheslav Dubeyko <slava@dubeyko.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Date:   Mon, 09 Dec 2019 17:34:05 +0300
In-Reply-To: <20191209140357.GJ25745@shell.armlinux.org.uk>
References: <20191209110731.GD25745@shell.armlinux.org.uk>
         <E1ieGtm-0004ZY-DD@rmk-PC.armlinux.org.uk>
         <59711cf492815c5bba93d641398011ea2341f635.camel@dubeyko.com>
         <20191209140357.GJ25745@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2019-12-09 at 14:03 +0000, Russell King - ARM Linux admin
wrote:
> > > 
> On Mon, Dec 09, 2019 at 04:54:55PM +0300, Vyacheslav Dubeyko wrote:
> > On Mon, 2019-12-09 at 11:08 +0000, Russell King wrote:

<snipped>

> > >  	sb->s_fs_info = asb;
> > > +	sb->s_time_gran = 10000000;
> > 
> > I believe it's not easy to follow what this granularity means.
> > Maybe,
> > it makes sense to introduce some constant and to add some comment?
> 
> Or simply name it "s_time_gran_ns" so the units are in the name.
> 

Sounds good. :) But why namely 10000000?

Thanks,
Viacheslav Dubeyko.


