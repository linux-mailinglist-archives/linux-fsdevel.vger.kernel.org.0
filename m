Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14BFA2AE03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2019 07:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbfE0FgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 May 2019 01:36:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46130 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfE0FgL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 May 2019 01:36:11 -0400
Received: by mail-pg1-f194.google.com with SMTP id v9so2040612pgr.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 22:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0Q+RZAfq2/iYUwVm8pEyCIzzp6Mp3PG1pvjpD0Wsst8=;
        b=y4LhP/pQHr/aVhOdEQODLTvwAmzQ67WSkXpzCM/HejrDe230d148gN4Zts0idcGdtp
         cW+9IThLSkY5AzVNjS3DeJOO6TVm6k9PY1QUtyZngouTPpDpcL2aT0G6HJ712nA+Shfs
         JWiWvhkroDQCVT4Br4uZcJeoBxvUki8nX/ZenVYl8o222qwiqppQKHbnFsopGBQ3JTXL
         kdeZ8TImTUXtAKBwaaiPPTgsUvWF5PWcSzpCxYCWn3ID2SnWMRBWLuDo28OdS9NTZjcE
         QJB4/q8RAimf0U2giJd/wUu5uiqcNyZn//ROTsBgIHY4avUbe1Jd/pGeTNprUgeQ5FpL
         gCQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0Q+RZAfq2/iYUwVm8pEyCIzzp6Mp3PG1pvjpD0Wsst8=;
        b=TWOFwyVj+OW2R7UjoLpY0LpbzmsXdd+lMlWJPoQGxodxHM72XV7KDxJHw7fMJ34sIv
         xxftjAycRLUCZjHq6jAkAalh34y3MHMzEVEW+8SUIAv4Pa+PFCVBiXl8FPfh9bI40j/G
         Q8b4LQ2H5IaokBoCEYke8Tvk3XfHikxcsL1sm1bgZJbXieuS9qgxZsZ7r4RBx/aZHvXH
         EijOBm+mlWANa8GpiRm/rqbJIkyDKiBH0Wy6AAjGczLC4ZIJlUPgd25jfBl26DK3DSou
         wukRR/vYk2qLLrEsAZFJCLdBIO8msw/d0R52WPR0+TmOdH9Qk01w1doAqDD7gI0L0AHq
         mGVg==
X-Gm-Message-State: APjAAAU8jk4Y86m7R1745YsrGFZfyEs7iWGTXzWRnCeX3LauFTxVjeGv
        jQBf0JzrlDWaa/nEBtR/HUBAmw==
X-Google-Smtp-Source: APXvYqzFRF/BPlpg9hW/21jo+Byitv9HhiLCQ4GA/cvSqp0OGNLRNbe5FkFRRJM1JGCZFeOHofoKcw==
X-Received: by 2002:a17:90a:af8d:: with SMTP id w13mr28696380pjq.143.1558935370849;
        Sun, 26 May 2019 22:36:10 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m101sm18083986pjb.2.2019.05.26.22.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 May 2019 22:36:09 -0700 (PDT)
Date:   Sun, 26 May 2019 22:36:07 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Scott Branden <scott.branden@broadcom.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 3/3] soc: qcom: mdt_loader: add offset to
 request_firmware_into_buf
Message-ID: <20190527053607.GV31438@minitux>
References: <20190523025113.4605-1-scott.branden@broadcom.com>
 <20190523025113.4605-4-scott.branden@broadcom.com>
 <20190523055212.GA22946@kroah.com>
 <c12872f5-4dc3-9bc4-f89b-27037dc0b6ff@broadcom.com>
 <20190523165605.GB21048@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523165605.GB21048@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 23 May 09:56 PDT 2019, Greg Kroah-Hartman wrote:

> On Thu, May 23, 2019 at 09:41:49AM -0700, Scott Branden wrote:
> > Hi Greg,
> > 
> > On 2019-05-22 10:52 p.m., Greg Kroah-Hartman wrote:
> > > On Wed, May 22, 2019 at 07:51:13PM -0700, Scott Branden wrote:
> > > > Adjust request_firmware_into_buf API to allow for portions
> > > > of firmware file to be read into a buffer.  mdt_loader still
> > > > retricts request fo whole file read into buffer.
> > > > 
> > > > Signed-off-by: Scott Branden <scott.branden@broadcom.com>
> > > > ---
> > > >   drivers/soc/qcom/mdt_loader.c | 7 +++++--
> > > >   1 file changed, 5 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
> > > > index 1c488024c698..ad20d159699c 100644
> > > > --- a/drivers/soc/qcom/mdt_loader.c
> > > > +++ b/drivers/soc/qcom/mdt_loader.c
> > > > @@ -172,8 +172,11 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
> > > >   		if (phdr->p_filesz) {
> > > >   			sprintf(fw_name + fw_name_len - 3, "b%02d", i);
> > > > -			ret = request_firmware_into_buf(&seg_fw, fw_name, dev,
> > > > -							ptr, phdr->p_filesz);
> > > > +			ret = request_firmware_into_buf
> > > > +						(&seg_fw, fw_name, dev,
> > > > +						 ptr, phdr->p_filesz,
> > > > +						 0,
> > > > +						 KERNEL_PREAD_FLAG_WHOLE);
> > > So, all that work in the first 2 patches for no real change at all?  Why
> > > are these changes even needed?
> > 
> > The first two patches allow partial read of files into memory.
> > 
> > Existing kernel drivers haven't need such functionality so, yes, there
> > should be no real change
> > 
> > with first two patches other than adding such partial file read support.
> > 
> > We have a new driver in development which needs partial read of files
> > supported in the kernel.
> 
> As I said before, I can not take new apis without any in-kernel user.
> So let's wait for your new code that thinks it needs this, and then we
> will be glad to evaluate all of this at that point in time.
> 

The .mdt files are ELF files split to avoid having to allocate large
(5-60MB) chunks of temporary firmware buffers while installing the
segments.

But for multiple reasons it would be nice to be able to load the
non-split ELF files and the proposed interface would allow this.

So I definitely like the gist of the series.

> To do so otherwise is to have loads of unused "features" aquiring cruft
> in the kernel source, and you do not want that.
> 

Agreed.

I'll take the opportunity and see if I can implement this (support for
non-split Qualcomm firmware) based on the patches in this series.

Regards,
Bjorn
