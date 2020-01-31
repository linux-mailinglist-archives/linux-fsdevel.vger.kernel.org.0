Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E00614F05D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2020 17:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgAaQGI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jan 2020 11:06:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:45310 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAaQGH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:06:07 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so8648455ioi.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Jan 2020 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVz24Zsr9oNwygj5KgYpb3eR7TSSOJlPu0ZbOqwsN6M=;
        b=LSIZgQLDBrbMF2c2mc0G16882YEC+pORFZ+BuRqUUByLgL6cREuO90VwCGtCkiqp6m
         Y51NDYZde8B48PX0kJHedMpNqaBC1qN0AGUzH29VCQbsaIJmvaNdscKK+ur+VKh3LEo5
         68cLuxRDjUCLlq6K8McDLXJ9gzK1Wy1fcqewQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVz24Zsr9oNwygj5KgYpb3eR7TSSOJlPu0ZbOqwsN6M=;
        b=OvAI3OmBOfgVQ9D9M7NVoJDB/irAfaYxodUdqbe0Ymtyxe8gQtG8ZNmWzsHI95cE9s
         YCUTFL0IgjEs82eE08HOfT8mSi5//p1kZdUJ4WRK1LdZ7PzThaVpBWcpvR3mL/H1UyNE
         gijyk/gz+qddUCq79WKvp2ozZNiHAs6Nlmr/JGYYo3JQVmWY13u4CoTF8JNxTDREGU0H
         oCKyLBSr2W4mdTIQ86VJ1KVMwHapbKfFKS2M/2GMGAVpNydoXwMRqZZz0ltMHTNEqPzG
         o1HeycR5KyXnTTv23/aOHUUg+n1kEohFMyEf/n37sIwAAq9WyBZNBavGpuOoVP09+jzV
         wWog==
X-Gm-Message-State: APjAAAWSPdSyaLUCr2YGF1pvm+XwDXOMOEDqdW5eIMZoDoqN5CBtpo9F
        dKIUuxpEQuIQgfvqHotlDRQFE+vdN8JVX0c974KZKQ==
X-Google-Smtp-Source: APXvYqw8nWvq0z2rl2ol8fNciDRX4bI2WxLTZO8ZpnCO1z+LhYcMVTHBMDtVW1nG8eUMrjPOmV29IWcNlf232p94GQ4=
X-Received: by 2002:a02:9988:: with SMTP id a8mr9166334jal.33.1580486767189;
 Fri, 31 Jan 2020 08:06:07 -0800 (PST)
MIME-Version: 1.0
References: <20200131115004.17410-1-mszeredi@redhat.com> <20200131115004.17410-5-mszeredi@redhat.com>
 <CAOQ4uxgV9KbE9ROCi5=RmXe1moqnmwWqaZ98jDjLcpDuM70RGQ@mail.gmail.com>
 <CAJfpegvMz-nHOb3GkoU_afqRrBKt-uvOXL6GxWLa3MVhwNGLpg@mail.gmail.com> <CAOQ4uxificaCG4uVRh94WC-nSNbGSqtmNt6Bx92j1chF_Khpmw@mail.gmail.com>
In-Reply-To: <CAOQ4uxificaCG4uVRh94WC-nSNbGSqtmNt6Bx92j1chF_Khpmw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 31 Jan 2020 17:05:56 +0100
Message-ID: <CAJfpegvkVaDVpk9fdqBoX5mmwH4Op2cEpU-5mF-pH=faShYycg@mail.gmail.com>
Subject: Re: [PATCH 4/4] ovl: alllow remote upper
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Vivek Goyal <vgoyal@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 31, 2020 at 4:50 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> I checked - afs has d_automount and gfs2 is d_hash.
> They do not qualify as any layer.

DCACHE_NEED_AUTOMOUNT doesn't work that way: it's set on specific
automount-point dentries only.  So AFS won't be disqualified based on
that criteria.   But afs also does not have RENAME_WHITEOUT, so that's
fine.

Thanks,
MIklos
