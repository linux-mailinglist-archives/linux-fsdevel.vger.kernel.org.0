Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2733C8858
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhGNQIw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhGNQIw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:08:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2A0C06175F;
        Wed, 14 Jul 2021 09:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=BiCvi+xpFl7gJwbD11pdFh8bwy+RGhUE6mwJAV6RuBs=; b=MKcP9PsKXStlDCEAvJPRgO9MQ8
        HHiw5y/9ONALDl4oitZS30Ao2KS4tq0lR9CMcOigv3X4aNUru20oAFZhsC8Ra4KbODj4TCojRx/sN
        IM3wAL+c/rbC/zHgNzw85sHSfiYDaCCB3FB9jqkzrBpJVomc46MB/SV+rUhpoukwiqYWk7TihdNaX
        KbJDluP9xzECqjUUZ2Hb/hwyxYhzt+fSe7uGMB4OQuIvVcHkaqzwUQnM3NZ0Ge2vQARKmlG8K3zCV
        JCWP9loK19HCfIzoEz2yPhtNU08zBlxqvNXz1fBvIzKV5/lOHAgxzjCkzv/sPjlMraDVpR8LT9hjl
        j9PfzGeA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3hNo-002M1J-Ql; Wed, 14 Jul 2021 16:05:19 +0000
Date:   Wed, 14 Jul 2021 17:05:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YO8LOKR/vRUgggTx@casper.infradead.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
 <YO755O8JnxG44YaT@kroah.com>
 <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:59:19PM +0200, Rafał Miłecki wrote:
> In short I'd say: missing feedback.

Uh, with all due respect: Fuck you.

I've provided feedback, and Paragon have done a fantastic job of
responding to it.  Pretending that the filesystem has simply been
ignored is hugely disrespectful of my time and those at Paragon.

I'm supportive of ntfs3 being included, FWIW.  It looks to be
in much better shape than the existing fs/ntfs.
