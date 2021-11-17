Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAD6454C50
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Nov 2021 18:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhKQRq7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 12:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhKQRq7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 12:46:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A84C061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 09:44:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so5865392pjb.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Nov 2021 09:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
        b=Pv9ANnOgMM3OWe87npnRfFAHy06jY7erPMdRcRc3VaKoizlrQvir6ceQnBEYeLyHYq
         r090jiPNw0sW2/Hep475ohjoYTOQRdpvhHcth1Xy44B2FrZqXQwnGcHV2wnXbXiiNy2O
         MDFnhNTzB1g4/CDk+YjqQXYVRalwhzm8GBHuQpfxBToXDBsfgLgdgSQoTQw5N7NkHGFW
         TO5GeE55hpjrU15s7LrDdGRZzL745vjZFcejg91qo0BT5VlwUF4cAT1X4T2RsJHhvJDD
         yt9A6syUQNrss5NuJD0lDiesCY4CCjNhydNUyUTp9hI7U9JLuZ9oCU9X4sETOzbxu27f
         +aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qvHf9aM+bFVV8YG4MJi5X6jszYRFNPnvYw8P8XxAMSs=;
        b=lhM/+Nc7zImufLcQ2nSXdhW1AwwRVgfUo3mHt5DiLnHA+RDDnnLzeoeLV2AiGNBCQW
         anZaJKCNR3yV+Xvx+i8CNDA7qToE+4Oq3LzhMBaksdu+qqc8g5r1j6M06+r+EOaThLXu
         Bnbcd1edCRe4Jvg1poF81GLzG2T+2uOn6V3FYwsfsZNS2mPrFLeRMzkvpY0DJ1rpYy35
         6j+u6DgSRhtAsYea44xonMb/lJtwXO9bffY+qU9x0JdmNGmARRbydRPOxB+tR9x01BNq
         SVrOD3kJjfQD1WTDeVrSEx6DO46WGVRsDzaQ44iI838bx1a1mzpZahnKhtMzGbnmMabj
         AEbQ==
X-Gm-Message-State: AOAM531ERAw/m1ClJKHzXmq+iVsTm3T0tlC4zR6S9JQdEZSc+3x7liPI
        7ledKfXuuHB9uJvzpPVli3bJ/vh/ylCCMzJHEIbWSA==
X-Google-Smtp-Source: ABdhPJzkkUh8z9sNK4035DW8QI/H+P4iSKXjlSdI0PBBNtw2VKYOtUcKXKOrARUi3RsvsZHwUrgnG1t18LSvWsJCfmc=
X-Received: by 2002:a17:902:6acb:b0:142:76c3:d35f with SMTP id
 i11-20020a1709026acb00b0014276c3d35fmr57313687plt.89.1637171039968; Wed, 17
 Nov 2021 09:43:59 -0800 (PST)
MIME-Version: 1.0
References: <20211109083309.584081-1-hch@lst.de> <20211109083309.584081-4-hch@lst.de>
In-Reply-To: <20211109083309.584081-4-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 17 Nov 2021 09:43:46 -0800
Message-ID: <CAPcyv4hzWBZfex=C2_+nNLFKODw8+E9NSgK50COqE748cfEKTg@mail.gmail.com>
Subject: Re: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
To:     Christoph Hellwig <hch@lst.de>
Cc:     Mike Snitzer <snitzer@redhat.com>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 9, 2021 at 12:33 AM Christoph Hellwig <hch@lst.de> wrote:
>
> CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Applied.
