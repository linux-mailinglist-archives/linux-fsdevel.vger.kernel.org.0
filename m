Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A22CB145424
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 12:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729083AbgAVL73 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 06:59:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54067 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgAVL73 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 06:59:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id m24so6529998wmc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jan 2020 03:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BhxPVdDn3Z4CWsuQOzp+pXDi/cOhHkkVUOHbOPLR28k=;
        b=ns7bOSUs+XnBZLxuYkQhXCqrHEfFp8h+Q5NU7jXO+pSvG37TjS8rAGWJ2Wg5qinT87
         LH+GLZS/c9WO+7AxbOLn1YwL8Xkm3y0EHaB1FGWcreACiwOLl58EKAcXq3ayz/ZGTIVh
         FcmEAvHpB0xBs/j/U6VXSOW5MNev6a0P3PCzPha/enOVitUtjGtyg/2nG7BM++vQAJLC
         h/nSt6Tv1WU28QveYxGjguqTDXzHlkxDSfCWKyFmu4VcBJgTaW+0OJcHFEfSkxuQ5H4v
         eM4Bjirs/hNZFC+dVueZLhYoyF/mh8d053lTCF/i2nuds/4M5f97qNnYfMGEs/XbXWQP
         1A9Q==
X-Gm-Message-State: APjAAAXwKUAZFKscNf4Ukcygnm48Rusxtz84T8PY/yBvijMhfFJYB1vW
        87jWye8xS46mY90aXOKflxw=
X-Google-Smtp-Source: APXvYqy5pWrmdMYHeRQcPqrPAInWTrBV+N316JaWfM3TKaooeOlM7u5oTbqt/HE5mt0+7pDPdJrEpg==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr2581017wml.71.1579694367672;
        Wed, 22 Jan 2020 03:59:27 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id p17sm3638585wmk.30.2020.01.22.03.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 03:59:27 -0800 (PST)
Date:   Wed, 22 Jan 2020 12:59:26 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, lsf-pc@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: [LSF/MM/BPF TOPIC] Do not pin pages for various direct-io scheme
Message-ID: <20200122115926.GW29276@dhcp22.suse.cz>
References: <20200122023100.75226-1-jglisse@redhat.com>
 <ba250f19-cc51-f1dc-3236-58be1f291db3@kernel.dk>
 <20200122045723.GC76712@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122045723.GC76712@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue 21-01-20 20:57:23, Jerome Glisse wrote:
> We can also discuss what kind of knobs we want to expose so that
> people can decide to choose the tradeof themself (ie from i want low
> latency io-uring and i don't care wether mm can not do its business; to
> i want mm to never be impeded in its business and i accept the extra
> latency burst i might face in io operations).

I do not think it is a good idea to make this configurable. How can
people sensibly choose between the two without deep understanding of
internals?

-- 
Michal Hocko
SUSE Labs
