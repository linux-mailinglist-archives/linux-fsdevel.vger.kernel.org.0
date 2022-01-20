Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0652C494DFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 13:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241857AbiATMce (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 07:32:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiATMcd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:32:33 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC76C061574;
        Thu, 20 Jan 2022 04:32:32 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id j2so27941012edj.8;
        Thu, 20 Jan 2022 04:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+EwLT/2jDgcvr2DeZgLKH9n4CqCysJdE2z1e9Aoco+Y=;
        b=cGeHy5YkiSyNGK+p1vG6CVLVXaAWpgHMgA2iL3VtDxeBxfNnWUfTEu2ZcmIuWtZjUi
         2GGw7+PUEcTakt6JjD6hwNvVFJgeOgs1JFrIJXRphXUxBKKzEwu4mgZk4GxRNQ+ms5Cm
         l/TNWmBOi6gVlv/HTQobi/VNUvjJsQ62A5N9pS76dkS58Bj1Tlkb7Z6Oms2GuSnKHv+F
         FUjNI2GRTFOI+AM9IDk3ov9Z1q/5hk+Ubw7rfeCjTSEQwahxjJTKp96/PJRM0xx8o05e
         vgFwHDe5Y9lMHa3xdh+mz/EriWYxcQ10kQzm75qBoxa4ersPSPKGIj4lZqviap8sXIFE
         PV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+EwLT/2jDgcvr2DeZgLKH9n4CqCysJdE2z1e9Aoco+Y=;
        b=dG7empm/31ixstGBHh8avY32y3tWflWG2pLx0y91myRFMCOzRi0a8cg5QkdjlDqSQ1
         KsIvBb/DkxeYklR6DTe72gYH13aGIgu1xPms/JytY3ubZfJGLDWT+Im6ngC+Ohx072Vs
         kPsvdZaW83iRy35aTTQpVysYKmbyYxOjz1wKGwQsVfSyq91aIhH0Hy6uQ6ErpikXrNPf
         /zHtf0ai7JCrAW8vrCtAX+fIolAVYVNZ4vofzRewKQf/Wl/uCywLTiyFiTjpaAbIS2D+
         DLWwWy5j/cMn/CzRFAP/87GdrRqg/uJETczro7rim2xnk2Kx5Xn3HkwTbtf1gLoJZ7A3
         FMuA==
X-Gm-Message-State: AOAM530Mkr+Knq5hd3q82bnUT9uVcDIBYBOMvhZFcq1FEB2yhK/shhzX
        OUSh2pTavOQQllYmE1A5zA==
X-Google-Smtp-Source: ABdhPJwH6zjYa5j5HcdiO6U7G5sNFguznEq7iDkXMSqZuOwt1jjJjuvKGiecydxCoecEwVmwHdC29Q==
X-Received: by 2002:a05:6402:26ce:: with SMTP id x14mr18394913edd.147.1642681951589;
        Thu, 20 Jan 2022 04:32:31 -0800 (PST)
Received: from localhost.localdomain ([46.53.254.155])
        by smtp.gmail.com with ESMTPSA id w27sm964224ejb.90.2022.01.20.04.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 04:32:31 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:32:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, stephen.s.brennan@oracle.com,
        legion@kernel.org, cyphar@cyphar.com
Subject: Re: [PATCH v2] proc: "mount -o lookup=" support
Message-ID: <YelWXWKZkR//mD8i@localhost.localdomain>
References: <YegysyqL3LvljK66@localhost.localdomain>
 <20220119162423.eqbyefywhtzm22tr@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220119162423.eqbyefywhtzm22tr@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 05:24:23PM +0100, Christian Brauner wrote:
> On Wed, Jan 19, 2022 at 06:48:03PM +0300, Alexey Dobriyan wrote:
> > From 61376c85daab50afb343ce50b5a97e562bc1c8d3 Mon Sep 17 00:00:00 2001
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Date: Mon, 22 Nov 2021 20:41:06 +0300
> > Subject: [PATCH 1/1] proc: "mount -o lookup=..." support
> > 
> > Docker implements MaskedPaths configuration option
> > 
> > 	https://github.com/estesp/docker/blob/9c15e82f19b0ad3c5fe8617a8ec2dddc6639f40a/oci/defaults.go#L97
> > 
> > to disable certain /proc files. It overmounts them with /dev/null.
> > 
> > Implement proper mount option which selectively disables lookup/readdir
> > in the top level /proc directory so that MaskedPaths doesn't need
> > to be updated as time goes on.
> 
> I might've missed this when this was sent the last time so maybe it was
> clearly explained in an earlier thread: What's the reason this needs to
> live in the kernel?

The reasons are:
	MaskedPaths or equivalents are blacklists, not future proof

	MaskedPaths is applied at container creation once,
	lookup= is applied at mount time surely but names aren't
	required to exist to be filtered (read: some silly ISV module
	gets loaded, creates /proc entries, containers get them with all
	security holes)

> The MaskedPaths entry is optional so runtimes aren't required to block
> anything by default and this mostly makes sense for workloads that run
> privileged.
> 
> In addition MaskedPaths is a generic option which allows to hide any
> existing path, not just proc. Even in the very docker-specific defaults
> /sys/firmware is covered.

Sure, the patch is for /proc only. MaskedPaths can't overmount with
/dev/null file which doesn't exist yet.

> I do see clear value in the subset= and hidepid= options. They are
> generally useful independent of opinionated container workloads. I don't
> see the same for lookup=.
> 
> An alternative I find more sensible is to add a new value for subset=
> that hides anything(?) that only global root should have read/write
> access too.
