Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7DD142919
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jan 2020 12:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgATLTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jan 2020 06:19:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45935 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgATLTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jan 2020 06:19:19 -0500
Received: by mail-wr1-f65.google.com with SMTP id j42so29078468wrj.12;
        Mon, 20 Jan 2020 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=sAKBI8tLvGzr6UvLomua7UpEPoIAkM60jCOjbm0hIrQ=;
        b=DmyWJdqghx6XRc275lGOaD/9JdK4XbHgV8V33ihri7Or9AYpu0acSKzt+aioLHFALE
         vaDTdHM7uPeSlMFYFzmNrPQGflhokrHJwmd3AkUm6ru7oDv2j0TK+fLxwLd4UM34xgO8
         RTa9TtzELAT9bm6JKpFUEhvsXBSPogxvZCrLo3LrSmKqhl+dOzABmGPirpqkqPKHo8c1
         xr+jA+6KLH+Ycw6CRP/FsQNoogSw6Gd1lx2rD1eBsld/Ij9Is/3Jf6y7xYXVvt5ng5nB
         2vflSU+B1/4+eXV7BhhbuOi3wb6rfQM/+FC5BUvVoNfT2Y/oceTXEoiId2V9erY0oIOl
         CGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=sAKBI8tLvGzr6UvLomua7UpEPoIAkM60jCOjbm0hIrQ=;
        b=AoX7dS1E9W/FBml8jDB3WAvFRTxNOkka5tUVWgG4GwU3V4IVcZWE19hk2bcpGOPVZF
         368ZeKBobwWkWBoC4kOfvh31CjaFgsx7rBwWSnJ4Jcg5oX9FL9heskDHf4h210r5roxv
         QpI+4sd8xh38YLHEI+Ktxgkw3cOfBaJyY+cqJcI/g1c76/KpGql4s6tMF7NYp2zaccvi
         84UPSHlqD+R6J0XFOGMEBjT+UsqVdGRdDY6AYRQfNEtdqa7vv7HAyPu47rDZvsxKLwjz
         qm4rKkQeC+KsccnMMkskp2DwiEihrCSEjK4aAywmTML3XKUTQ/HhRXsqhsJaTalZGVRT
         eZtw==
X-Gm-Message-State: APjAAAV+UNHjwjtEnEXErV3JdUeId1KwHMXG0vlP8n5XLJlLy9aq0+/q
        OxqINJNQC2LsxU/ulN9hIbDF5jOM
X-Google-Smtp-Source: APXvYqyHiPSvBEx6WZ0DOYYYLyEIUDktPV86NCVVv1OSHvFMGWvNsohU8URtj259sSIh2bxFyNIMiQ==
X-Received: by 2002:adf:bc87:: with SMTP id g7mr17959302wrh.121.1579519158079;
        Mon, 20 Jan 2020 03:19:18 -0800 (PST)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id u1sm291600wmc.5.2020.01.20.03.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2020 03:19:17 -0800 (PST)
Date:   Mon, 20 Jan 2020 12:19:16 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Namjae Jeon <linkinjeon@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: vfat: Broken case-insensitive support for UTF-8
Message-ID: <20200120111916.pc2ml2farnga3yen@pali>
References: <20200119221455.bac7dc55g56q2l4r@pali>
 <20200119230809.GW8904@ZenIV.linux.org.uk>
 <20200119233348.es5m63kapdvyesal@pali>
 <20200120000931.GX8904@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120000931.GX8904@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Monday 20 January 2020 00:09:31 Al Viro wrote:
> On Mon, Jan 20, 2020 at 12:33:48AM +0100, Pali Rohár wrote:
> 
> > > Does the behaviour match how Windows handles that thing?
> > 
> > Linux behavior does not match Windows behavior.
> > 
> > On Windows is FAT32 (fastfat.sys) case insensitive and file names "č"
> > and "Č" are treated as same file. Windows does not allow you to create
> > both files. It says that file already exists.
> 
> So how is the mapping specified in their implementation?  That's
> obviously the mapping we have to match.

FAT specification (fatgen103.doc) is just parody for specifications.
E.g. it requires you to use pencil and paper during implementation...

About case insensitivity I found in specification these parts:

"The UNICODE name passed to the file system is converted to upper case."

"UNICODE solves the case mapping problem prevalent in some OEM code
pages by always providing a translation for lower case characters to a
single, unique upper case character."

Which basically says nothing... I can deduce from it that for mapping
table should be used Unicode standard.

But we already know that in that specifications are mistakes. And
relevant is Microsoft FAT implementation (fastfat.sys). It is now open
source on github, so we can inspect how it implements upper case
conversion.

> > > That's the only reason to support that garbage at all...
> > 
> > What do you mean by garbage?
> 
> Case-insensitive anything... the only reason to have that crap at all
> is that native implementations are basically forcing it as fs
> image correctness issue.

You are right. But we need to deal with it.

> It's worthless on its own merits, but
> we can't do something that amounts to corrupting fs image when
> we access it for write.

If we implement same upper case conversion as in reference
implementation (fastfat.sys) then we prevent "corrupting fs".

-- 
Pali Rohár
pali.rohar@gmail.com
