Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DA3229451
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730422AbgGVJBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 05:01:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39451 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgGVJBk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595408499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MODKfj6PEnGdaynq2BuHvt1PqpJxgvTxzRg0/ny+Tz4=;
        b=DbWp2jXcZgo+H89WwX+dcSUD7E8fPmvI8JaYJ5Q7wPkfpfYuOGlOC5yXUfUCs3HjZZqWee
        7YlGaUzOT8FCsdMftcCHO+27YMBuhf1yrVclgXQUgcB3otYnuFp5V7eNt5Az2vUqLxz3eQ
        LFmOW5TOBDO1YtELgPOYvxHZHKJz9+0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-f5PPy5gIMcWr9D_8pazmqg-1; Wed, 22 Jul 2020 05:01:37 -0400
X-MC-Unique: f5PPy5gIMcWr9D_8pazmqg-1
Received: by mail-wm1-f70.google.com with SMTP id x8so348716wmk.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 02:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MODKfj6PEnGdaynq2BuHvt1PqpJxgvTxzRg0/ny+Tz4=;
        b=qBA4sSzn9oRBeeI4qL29sjHKLqNpUDssubRZtK7FwC2B/bQkJQh+LUSDy/yruqZUo3
         4N7E1roQKJ+0DjiTSUkPdOJS8jECdw/wNw+9QnlHBplyKH6zgQt6JgbHewuQhqxFKwNk
         Q8XpITikMGxqYMCLhdThxOU69lhMWAW9lui/tYN6JWO4c6GyO2G2RjWt8Y2DLVR0ucE/
         ghHii+C0kFVMF55nHvu8coiE+Gnj3mPEWgNPOXZQDy5s6K8ANpuKIXJ42FmUmZLvqFFx
         nv23doKOAqNOdAivo/RlYZbMN8IWO5vjatm74rPM7TxUU5n69PVXOn4Sjf9iENFY0+Ly
         NgVw==
X-Gm-Message-State: AOAM531Q3UZQQvPQyYlcaVAameUAa9JiCsKA9RGsYHNb8/qdl+zA51w6
        fv3z++/NvYG29DE5A/L+a9V1cj22C8reNBAZuFRVSurpp0Vuup4lsw1gIuvyyhWjYKFIBPNhGuA
        FcmtTbRCsWpeVCJsOlBGCOILb+Q==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr32620171wrq.56.1595408495914;
        Wed, 22 Jul 2020 02:01:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIN3tzPA5jdW0eMoFjUkNdVR9b4YY5dHx3s7a3dm4qYN4GPi73083gER3O1dnqvdtozPBvjQ==
X-Received: by 2002:a5d:40ca:: with SMTP id b10mr32620152wrq.56.1595408495715;
        Wed, 22 Jul 2020 02:01:35 -0700 (PDT)
Received: from localhost.localdomain ([151.29.94.4])
        by smtp.gmail.com with ESMTPSA id v12sm29607001wrs.2.2020.07.22.02.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 02:01:34 -0700 (PDT)
Date:   Wed, 22 Jul 2020 11:01:32 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     He Zhe <zhe.he@windriver.com>
Cc:     viro@zeniv.linux.org.uk, axboe@kernel.dk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: Enlarge recursion limit to allow vhost to work
Message-ID: <20200722090132.GB14912@localhost.localdomain>
References: <20200410114720.24838-1-zhe.he@windriver.com>
 <20200703081209.GN9670@localhost.localdomain>
 <cbecaad6-48fc-3c52-d764-747ea91dc3fa@windriver.com>
 <20200706064557.GA26135@localhost.localdomain>
 <20200713132211.GB5564@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132211.GB5564@localhost.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 13/07/20 15:22, Juri Lelli wrote:

[...]

> Gentle ping about this issue (mainly addressing relevant maintainers and
> potential reviewers). It's easily reproducible with PREEMPT_RT.

Ping. Any comment at all? :-)

Thanks,

Juri

