Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B98305D42
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313298AbhAZWfI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389571AbhAZRPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 12:15:33 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BE0C0617AB
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 09:15:18 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e9so10140869plh.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Jan 2021 09:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=1OK/MeZJl5NxcxE5Dh3B9A8mhymxtTUZmx4FhDUsbPY=;
        b=YSoe4Og20hwhN3jDWuBKZemxXDk8zdksEMCbNyCSJd3tiWbTzRb+W9uW3a5uOhG3d9
         rg8Sy/x3/uSR/WISwkBhusJBuXFs4f4Ew4Qx/Jzz/Shs4zEFqL8mf+4nDfgloe3+rFjh
         4Z5CzHrhnd+Yh7ACoDyVMAdTdaDgSzVskofOCzQ4mBFt704fFg4xFGcjrPN1kfXdrT1A
         eC6JVtYjxgYOjvXJVp+Mv7Je+LLbaqnJqm4jymgtvDrLgw/wy6XLpaQf5gKF5P9Wm3O1
         C5Y6xZVt9ubUtDF9Vz8Bfte6yAyhuafOIDPoBiVOVPPaIsdz+9USmmhqKflYgYDbObVx
         5sNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1OK/MeZJl5NxcxE5Dh3B9A8mhymxtTUZmx4FhDUsbPY=;
        b=e14LPofO9/rYow8afK00+bbpFPTWRmsay9iDwJ7VZIDjT2MM1FSVh9Dz/PVnFFAy7Y
         lBf0qTE6YjXK6iXGUgC1Lz/nKARJTWGGiY+5MFZaZpbGgpwvkMQC+l2Lj+RzUWOpuTeF
         uSKQ6zw7KaeWizF6iYDOj6GodbdQcFcFWEQLLbRbzb/fnZy7X8B0LaVjINmnK418gYK5
         ccHqRentpiBNZX6k+NX0e/5hlEdXF8A9QKiIp/bCWdXPjM+4K4/bdUO+IbbjNXmanpZA
         MWJEcJNMHnqvxhEN9VpnK2wAx4L2zYOxkIeGPMdDQhSke3zxY6sIHD8ktCTF2IwCOmAV
         lBIg==
X-Gm-Message-State: AOAM531MmcCsggdZ9UrDJrelk9RU33kpK8Xk3LEH77nwf04o0PMV4qIH
        fJPAbEdgMAhaSmR+wPOGtheABA==
X-Google-Smtp-Source: ABdhPJzOSgrY4m5BUz2N9eCvyppN9VeNapOvVp4cm1RzAFoqiJTviLaRuKIxY/kCtYXUJmQ2bygfSQ==
X-Received: by 2002:a17:90a:f309:: with SMTP id ca9mr807823pjb.11.1611681318027;
        Tue, 26 Jan 2021 09:15:18 -0800 (PST)
Received: from [192.168.10.175] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id c11sm2783512pjv.3.2021.01.26.09.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 09:15:17 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: Getting a new fs in the kernel
Date:   Tue, 26 Jan 2021 10:15:15 -0700
Message-Id: <D66E412C-ED63-4FF7-A0F9-C78EF846AAF4@dilger.ca>
References: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAE1WUT7xJyx_gbxJu3r9DJGbqSkWZa-moieiDWC0bue2CxwAwg@mail.gmail.com>
To:     Amy Parker <enbyamy@gmail.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Jan 26, 2021, at 09:25, Amy Parker <enbyamy@gmail.com> wrote:
>=20
> =EF=BB=BFKernel development newcomer here. I've begun creating a concept f=
or a
> new filesystem, and ideally once it's completed, rich, and stable I'd
> try to get it into the kernel.

Hello Amy, and welcome.=20

I guess the first question to ask is what would be unique and valuable
about the new filesystem compared to existing filesystems in the kernel?

Given that maintaining a new filesystem adds ongoing maintenance
efforts, there has to be some added value before it would be accepted.
Also, given that filesystems are storing critical data for users, and
problems in the code can lead to data loss that can't be fixed by a reboot,
like many other software bugs, it takes a very long time for filesystems
to become stable enough for general use (the general rule of thumb is 10
years before a new filesystem is stable enough for general use).=20

Often, if you have ideas for new functionality, it makes more sense to
add this into the framework of an existing filesystem (e.g. data verity,
data encryption, metadata checksum, DAX, etc. were all added to ext4).

Not only does this simplify efforts in terms of ongoing maintenance, but
it also means many more users will benefit from your development effort
in a much shorter timeframe. Otherwise, users would have to stop
using their existing filesystem before
they started using yours, and that is
a very slow process, because your filesystem would have to be much
better at *something* before they would make that switch.=20

> What would be the process for this? I'd assume a patch sequence, but
> they'd all be dependent on each other, and sending in tons of
> dependent patches doesn't sound like a great idea. I've seen requests
> for pulls, but since I'm new here I don't really know what to do.

Probably the first step, before submitting any patches, would be to
provide a description of your work, and how it improves on the current
filesystems in the kernel. It may be that there are existing projects that
duplicate this effort, and combining resources will result in a 100% done
filesystem rather than two 80% done
projects...

Note that I don't want to discourage you from participating in the Linux
filesystem development community, but there are definitely considerations
going both ways wrt. accepting a new filesystem into the kernel. It may be
that your ideas, time, and efforts are better spent in contributing to an
exiting project.  It may also be that you have something groundbreaking
work, and I look forward to reading about what that is.=20

Cheers, Andreas=
