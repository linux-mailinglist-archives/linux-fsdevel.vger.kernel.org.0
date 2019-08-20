Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8A95F59
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 15:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfHTNBX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 09:01:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53872 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728283AbfHTNBW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 09:01:22 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55FD6C05975D
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 13:01:22 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t9so7042858wrx.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2019 06:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=JyfdeLkkR8GtG7vbX84FfM/uenohypR3GvPDvYTRWXk=;
        b=TR6keh4t3maBJh7XvJLv6G6vBeyS1dvnGvEZ2f67z2CVlL2WHUlSYSFahoNO8mPse8
         WeOMsJhs6aeVPYzRxIkejKE9csXSvhBvHms5yr4RJqaV2b1eC9uPjX4r1NbhcShsotxI
         xZifL5z0wd2bRgvfFM1nKv1KKGJ/NfBPJsX7dMN6O7TPu6lIY6f8WuLZ1yCklHFIKRfd
         gRWqAwIEb54UaXjdltpahc5MZ1IOG233NB2g8+1YsF6BYa+6jbEYAj3goNuG5v/cTJs+
         SKhIZoC+I6aLEdTidrVGyxhCJD/0WjSzHFvuzjxdXsp59vU2EAsElhn/tUJwb4jEk4vv
         PFCQ==
X-Gm-Message-State: APjAAAWOGGUfzBNaE1LWHPBsGSCv0z7V8Gf4/aHVzw2qeHqKJysljHp5
        psJwIIPJg+KzFK6uB4RDLo/7jzm1Llvys6dgixCLlJaFGWb6t4p2kT2qolWKu3L5GRpcYubqKdl
        mIXx9by/VTHW/lmGq+PjdXZTlyA==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr17215536wmb.116.1566306081128;
        Tue, 20 Aug 2019 06:01:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwW/Mm7Yp1DuKc2DpARm+BXm2IBc4i04bqTY3rcNb283e8Tyj6owuE5dBd43XuSSQL15LjkMw==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr17215522wmb.116.1566306080906;
        Tue, 20 Aug 2019 06:01:20 -0700 (PDT)
Received: from pegasus.maiolino.io (ip-89-103-126-188.net.upcbroadband.cz. [89.103.126.188])
        by smtp.gmail.com with ESMTPSA id a19sm58231285wra.2.2019.08.20.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 06:01:20 -0700 (PDT)
Date:   Tue, 20 Aug 2019 15:01:18 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 8/9] Use FIEMAP for FIBMAP calls
Message-ID: <20190820130117.gcemlpfrkqlpaaiz@pegasus.maiolino.io>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        linux-fsdevel@vger.kernel.org, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
References: <20190808082744.31405-1-cmaiolino@redhat.com>
 <20190808082744.31405-9-cmaiolino@redhat.com>
 <20190814111837.GE1885@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814111837.GE1885@lst.de>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 14, 2019 at 01:18:37PM +0200, Christoph Hellwig wrote:
> The whole FIEMAP_KERNEL_FIBMAP thing looks very counter productive.
> bmap() should be able to make the right decision based on the passed
> in flags, no need to have a fake FIEMAP flag for that.

Using the FIEMAP_KERNEL_FIBMAP flag, is a way to tell filesystems from where the
request came from, so filesystems can handle it differently. For example, we
can't allow in XFS a FIBMAP request on a COW/RTIME inode, and we use the FIBMAP
flag in such situations.

We could maybe check for the callback in fieinfo->fi_cb instead of using the
flag, but I don't see how much more productive this could be.

Maybe a helper, something like

#define is_fibmap(f)	((f->fi_cb) == fiemap_fill_kernel_extent)


But again, I don't know how much better this is comparing with a flag

Cheers
-- 
Carlos
