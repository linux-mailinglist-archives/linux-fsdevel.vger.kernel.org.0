Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDE3BEC0E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jul 2021 18:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhGGQ1G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jul 2021 12:27:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24321 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbhGGQ1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jul 2021 12:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625675064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qEsZZ/0O4o5bTbASh+biKErXxNZpBbbABCYpuVEWvyc=;
        b=OjAz2rcJxisXuhyg2+Trze0j6EXUpOdQFU/3dgA35WJ60llrFYt47KPeFDqnBbcIoUkxj5
        W6T59igJWpxbrEUOjjoRqxge80i8zb0iGiECRvh+wy3YsEqpD9kgLeM6HR58XKcdTK8opr
        sZg8xxV+7h96oGv87owTkV6Y8rZCSQs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-ifjGFH5tNvq-k2S1FJNQQw-1; Wed, 07 Jul 2021 12:24:23 -0400
X-MC-Unique: ifjGFH5tNvq-k2S1FJNQQw-1
Received: by mail-qv1-f70.google.com with SMTP id b3-20020ad451830000b02902a94b1b914dso1981122qvp.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jul 2021 09:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=qEsZZ/0O4o5bTbASh+biKErXxNZpBbbABCYpuVEWvyc=;
        b=kj9WsUX5yb37BuWTlsz3FxpNRdzwfXPxFxI6Tg35m40hne0xccxAn8ELHZhRcShiqy
         2BGaOJJUT1LCHlGutsYIHR3WwqaxRXvLiXZ23tmL9rj7WVxPNztcD238li4RNFYyoSU0
         v2zGijWO2dCjm8ThuPQiUiow3mcK7pJUQcUG9g08Rq/sRxQEuEBcR7iWg+DB3rBQ54oB
         qsajGXjrzO9AozCFMCn/I2Bpr3wpFUDmxTJ8jv1xIjD+ujpfqre9PdDuwwOf2Ey3Bhv0
         Bg1rMkwd/WUQSMhqVaVDtIgRaMUxqdjMzz79L1I8nzglPsQYCSGSTjmFOVi4/zaLhBU1
         5q9Q==
X-Gm-Message-State: AOAM530n2hewF0BHV3incdivdf5Cb1hIaQYoshLhXPKo6m5zpsNk3nJY
        Ub3yjkTKJyX9WpOVxg/sgAvkDqGLLukfJ2hdkqHEDTrsI1ip6HTvUh/MCgeoid5BSEIagC7WGvg
        WDKNd1wqpVojew3qiG2s2DfRjeA==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr3095383qvr.27.1625675063190;
        Wed, 07 Jul 2021 09:24:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy8h38YNl800VQzSLlJgAFjPYiQEEC7N9g58pFwfpXXAZ88Go+b12DUBSc2i9qwi+QUhpUliw==
X-Received: by 2002:a05:6214:1087:: with SMTP id o7mr3095371qvr.27.1625675063045;
        Wed, 07 Jul 2021 09:24:23 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id d15sm6909443qtb.72.2021.07.07.09.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 09:24:22 -0700 (PDT)
Message-ID: <1d185630b8de45c079dd62f630b86ce076c01e5e.camel@redhat.com>
Subject: Re: dead code in ceph
From:   Jeff Layton <jlayton@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Date:   Wed, 07 Jul 2021 12:24:21 -0400
In-Reply-To: <CAH2r5mupFZHQFM+aYgCMQ9Whh67LfnSLg-Dsu4jasvtz1Ap0oA@mail.gmail.com>
References: <CAH2r5mupFZHQFM+aYgCMQ9Whh67LfnSLg-Dsu4jasvtz1Ap0oA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2021-07-07 at 10:09 -0500, Steve French wrote:
> cache.h:int ceph_readpages_from_fscache(struct inode *inode,

Ahh, thanks! I'll spin up a patch to clean some of that up.

Cheers!
-- 
Jeff Layton <jlayton@redhat.com>

