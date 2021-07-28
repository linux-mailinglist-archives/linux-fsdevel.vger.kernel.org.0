Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10183D8904
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jul 2021 09:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhG1Hlo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jul 2021 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233277AbhG1Hln (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jul 2021 03:41:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2DCC061757;
        Wed, 28 Jul 2021 00:41:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so2962240pjh.3;
        Wed, 28 Jul 2021 00:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3gyKs31H8DmWFPMAtNTmsj5Y1115XQKa+6v265+MF98=;
        b=QPu+Xan/QfEel2lNwA6ZQhbMilq9UteGKnrllrkZPvNwLRhg0S3qj4s90qHn2xz5l8
         gTSMklmYaUeB6fQPHQZHVY9jPgtLDojxLzKnpdRSZioEB7reKaZgUPaMaIZ9eed02LuH
         PpJy0MsbsyXcon9DIIBmRgTe4UZ9bSc93nUgMeheh7F99nvyA5VCd4LCEPyJf1lSRwf0
         xjzGAPFL+1bDLKkPhTczAZtX5/upHfbIdvsDahSHga7KNj7W1A6bfjRrtqgHIHX30G4z
         8CaicVMaFgOhxTm1spcOTKAuqHil3FpknfxE9g0U9NbnlUOPYHw65wPWYlaNKuR8ueZH
         OxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3gyKs31H8DmWFPMAtNTmsj5Y1115XQKa+6v265+MF98=;
        b=RixPIpWngY0omGymjCT/WJZbAcgVrTX0Bq+DgW6Kcp3TuckkFOW8Zig3fpNf5YX2EX
         ArvnVe6VNq8URdlfWOBtexFvUn0GGetd02HirfdqwizxbtNnQtemEVodxNayNozO1eJZ
         quPFMjC5roTeQjfj3sU2wmoLM4yD8KtannJZ1+WI3bKjMODEtv/BDHI6kgKNjvvX7uTd
         WmgPhtHiS/iwjKK7CVfCfEUMATx90V2FGfP2Cumco5Q+LnG+iYJvT6eqGHlLi6bxGCXU
         Pz7m9hVe6cvlCnXamsJwvi/zDgGDW06hZQEnetK7obQ95QrtSZnWVWhBm9kZiPIDsJYW
         +A/w==
X-Gm-Message-State: AOAM530258c8U3cR4oGzhC/R7Qe+xlQGpLZTQoiNFey+D2eccIIhNdjT
        UuV4+4Zo9oyIFp+rLrQu9OY=
X-Google-Smtp-Source: ABdhPJzlHENqMVVGhp6QfQiRNFBo4bVChcVgOZ4iDyoLYi5WaZre5bP2oK0YfEh38riCyflQczQMBQ==
X-Received: by 2002:a17:902:8648:b029:129:dda4:ddc2 with SMTP id y8-20020a1709028648b0290129dda4ddc2mr22168302plt.4.1627458102256;
        Wed, 28 Jul 2021 00:41:42 -0700 (PDT)
Received: from localhost (udp264798uds.hawaiiantel.net. [72.253.242.87])
        by smtp.gmail.com with ESMTPSA id x14sm6540101pfq.143.2021.07.28.00.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 00:41:41 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 27 Jul 2021 21:41:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     viro@zeniv.linux.org.uk, lizefan.x@bytedance.com,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] misc_cgroup: add support for nofile limit
Message-ID: <YQEKNPrrOuyxTarN@mtj.duckdns.org>
References: <3fd94563b4949ffbfe10e7d18ac1df3852b103a6.1626966339.git.brookxu@tencent.com>
 <YP8ovYqISzKC43mt@mtj.duckdns.org>
 <b2ff6f80-8ec6-e260-ec42-2113e8ce0a18@gmail.com>
 <YQA1D1GRiF9+px/s@mtj.duckdns.org>
 <ca2bdc60-f117-e917-85b1-8c9ec0c6942f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca2bdc60-f117-e917-85b1-8c9ec0c6942f@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 28, 2021 at 11:17:08AM +0800, brookxu wrote:
> Yeah we can adjust file-max through sysctl, but in many cases we adjust it according
> to the actual load of the machine, not for abnormal tasks. Another problem is that in
> practical applications, kmem_limit will cause some minor problems. In many cases,
> kmem_limit is disabled. Limit_in_bytes mainly counts user pages and pagecache, which
> may cause files_cache to be out of control. In this case, if file-max is set to MAX,
> we may have a risk in the abnormal scene, which prevents us from recovering from the
> abnormal scene. Maybe I missed something.

Kmem control is always on in cgroup2 and has been in wide production use for
years now. If there are problems with it, we need to fix them. That really
doesn't justify adding another feature.

Thanks.

-- 
tejun
