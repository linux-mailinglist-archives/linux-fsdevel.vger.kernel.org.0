Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D373F527B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Aug 2021 22:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhHWU5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Aug 2021 16:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232237AbhHWU5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Aug 2021 16:57:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D753C061575
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 13:56:31 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d17so10881749plr.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Aug 2021 13:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc/aN0oRmNAXm6mXAGLkDsuBBboDWXtU8orOhuBIg2Q=;
        b=B1PN8/oQCmXbi6l3QVCMPVcI3O4p3WLJA2eJeCS8TyZ/9O3zP1YyDhITU4ZcQUMu9A
         8Jv3FvTsSNw0wedo++tDncepWpg5fNlx5yOWydCxJxO2LvZgmafOowgtsiW33KkmxXri
         JicnY3m49d7Mh7sxoVHfKYR9tR4vxLm0cTOPiz13j1eLGWJpH4EqBXIsByJu+wugislF
         s6cQkVjauCeFLAIH7yrSgJ+rNWkZxDUHqX64XCMW3WAknCaEAVdKpKS94amQp5lRvzVE
         JLGKD1TjCujv8RstgFNxXr4d9/bplk1r3u+5Pw+HrYG4JEKzIAam/KjQAVW3vquIOGjY
         zzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc/aN0oRmNAXm6mXAGLkDsuBBboDWXtU8orOhuBIg2Q=;
        b=EYxtAcpoLKsvhJZpmSgzoXoaiHMPKJwrLe1yzVVrVqIaknIrC+cOIbCv8XZe6bMqiq
         d+tCb67HDia8OedIK3KEZWDZrhCjKKIZDbMcBuD8IVotMAR1mJE8iBWKFOGJ2fEaYFgC
         gtyWIj5DF60VUSgm2K9GYLKuYg0oujzc97q/oglCU5zOGTl/FlCBGHVcOl8eJ4piXr2t
         BodKrsu5WT3ukqL+2VeuwL0ykiU0VDv0o449EMtCtmfr62K3M7r2m56Ur1HB3a3fL28Q
         +6rmVWavhH3M8o+znPALFLkeT178orEgZg2baODLGT5hRKbO8nDu/nbNMHyX0taQKuYz
         AnMQ==
X-Gm-Message-State: AOAM5329v4Lc7UR9MJb3O0/ZtdnJabUTqcuuhBT4QtlAU7fYCzq2as07
        CkpGPkuRW7kVoRt7pzPIO4yxXd3JjDFd68g2qkhrRQ==
X-Google-Smtp-Source: ABdhPJzahdnrNond377llVfK4n8/pb9BvsPDfdsBxiv7TsIPXVvYqFPJnZxVBQsD+DCyRAqPYzTF7GnMCMP9/MlvOFQ=
X-Received: by 2002:a17:902:edd0:b0:135:b351:bd5a with SMTP id
 q16-20020a170902edd000b00135b351bd5amr2063016plk.52.1629752190557; Mon, 23
 Aug 2021 13:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210823123516.969486-1-hch@lst.de> <20210823123516.969486-5-hch@lst.de>
In-Reply-To: <20210823123516.969486-5-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 23 Aug 2021 13:56:19 -0700
Message-ID: <CAPcyv4j2-8OPHDowaH0ogZP5qKM6rkGVgjjPPRt1k2DC_SpnFw@mail.gmail.com>
Subject: Re: [PATCH 4/9] dax: mark dax_get_by_host static
To:     Christoph Hellwig <hch@lst.de>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 23, 2021 at 5:39 AM Christoph Hellwig <hch@lst.de> wrote:
>
> And move the code around a bit to avoid a forward declaration.

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
