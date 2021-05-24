Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC338E007
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 06:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhEXEGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 00:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbhEXEGE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 00:06:04 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1AEC061574;
        Sun, 23 May 2021 21:04:36 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id eb9so13549852qvb.6;
        Sun, 23 May 2021 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nqRkhxYWrBKziCZNlhSeVxNcNJInHoerMGrV1hjRFTc=;
        b=ibLlxq3jkgNf6+jcggM2Z6qldi1rekTcxcGshC8o/SrNEQryDT4CCun6+SdF/6AGOa
         zhGFXRHurSAt9E/gIMDYmmVOxeUVvIaE2HjKMYdynZsw8tD3K7TYppWlJUkXjd9BTsxI
         lEGWgfwDaXsfmvHWBJbbQ4p9xGZkNQRl4pRxvWRJx8eO2/AynmxktYkz6g9rvNt2z8qq
         yRu1NYFmhZVE5m4oss64JmOsXUrzE1sPtN8ohhcrdBnXFraJJ/gxZaCrtd9WjQ/ui54a
         0+Fqx9LDtUTUtmF+V31Wlc2OVG25TvGN0EwxUq2G9Et0QL+cZzWa3SaQqjJgPzKq/Fz1
         v6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqRkhxYWrBKziCZNlhSeVxNcNJInHoerMGrV1hjRFTc=;
        b=hBbRXLdy3C0oeoDFsCSVKmFNu9J3ygoFfexWqYQ1R0YKctXDeLeXuR5pLP12fdPEad
         Oyc8QcspJ34W8uzMS3kt6ilHTYojXXUfDZK4YJyGKGSxKPed4a6XskRa80kZk/mm0EMx
         Veyv+R/r3xa0acm8X+FENDW8wzodmn+hkx7Wd3wHobOBRi9ZKBY9vLARhkX9caUgHeED
         oF20Dfb9xKpmgCUtmcM5W5AOQ/93w/eA0ou1NVWHGYcCrIivChBgckXNHmYOKu12E+F/
         dtiIuyx34nwX/MWMerbj5moOBVs6a+NmAQDMKsnAFvFKUnYgtqICCSu65e4G0Z3TfvPm
         LbDA==
X-Gm-Message-State: AOAM530CZzeVKmLxU/1IsE2dMrqI8N7/gcTmDyCEAbtsAkArZpdJ7Jvt
        ZglmeBbwJ+pr2/dsl7rmTYbQ3Ll16ydT
X-Google-Smtp-Source: ABdhPJzoEz12a1L/5UGzxL7pPm/Lx7QHwu8+pfNQ/KQTLQyext0RAS31VilFpVU5htioZ1dVAhjpyQ==
X-Received: by 2002:ad4:510e:: with SMTP id g14mr26952272qvp.5.1621829076054;
        Sun, 23 May 2021 21:04:36 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id 2sm10191987qtr.64.2021.05.23.21.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 21:04:35 -0700 (PDT)
Date:   Mon, 24 May 2021 00:04:32 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>
Subject: Re: [PATCH 1/3] Initial bcachefs support
Message-ID: <YKsl0ORHo/mhuUBx@moria.home.lan>
References: <20210427164419.3729180-1-kent.overstreet@gmail.com>
 <20210427164419.3729180-2-kent.overstreet@gmail.com>
 <YJfzVSGu2BbE4oMY@desktop>
 <YKrchSzj8Zo4CnDs@moria.home.lan>
 <20210524035604.GD60846@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524035604.GD60846@e18g06458.et15sqa>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 24, 2021 at 11:56:04AM +0800, Eryu Guan wrote:
> On Sun, May 23, 2021 at 06:51:49PM -0400, Kent Overstreet wrote:
> [snip]
> 
> > > >  	;;
> > > > @@ -1179,6 +1197,19 @@ _repair_scratch_fs()
> > > >  	fi
> > > >  	return $res
> > > >          ;;
> > > > +    bcachefs)
> > > > +	fsck -t $FSTYP -n $SCRATCH_DEV 2>&1
> > > 
> > > _repair_scratch_fs() is supposed to actually fix the errors, does
> > > "fsck -n" fix errors for bcachefs?
> > 
> > No - but with bcachefs fsck finding errors _always_ indicates a bug, so for the
> > purposes of these tests I think this is the right thing to do - I don't want the
> > tests to pass if fsck is finding and fixing errors.
> 
> Then _check_scratch_fs() should be used instead, which will fail the
> test if any fsck finds any corruptions. _repair_scratch_fs() is meant to
> fix errors, and only report failure when there's unfixable errors.

I see no reason to make such a change to generic tests that were written for
other filesystems, when this gets me exactly what I want.
