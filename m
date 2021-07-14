Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2913D3C888B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 18:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbhGNQWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 12:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhGNQWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 12:22:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E0C06175F;
        Wed, 14 Jul 2021 09:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6k+GYIhQTkYbyjaDzT+pMB7id1aYgH8TvvkB8cj7Dug=; b=AZQzi3yzTdmbz0+Js1+gKXZznt
        0wWIqRZnN4Vi/weblEmxEOV3131Xl/UGWZwRC+5rVcv3ywrVATwytoLlQfoo/MNayYC0Ch0UdJqGl
        ph5eFL5b5AX+2daANSrbSYOwq2uhSU+Iax76CBPzSMekNG+o/yJwT2FyhFN960DN8ZZ48kpR0FB+q
        QBeFPpJR8sF59/mSpHLtXQl3NK5LaRzqUlwW/pvDWksNNkWgVqf1CulJGLyAu/vSaN1qNWhDGgmj7
        actnJ6hPsyEsc/2ktLj1qAr2EOpY6kb2qOTRR0TSFe8mXQkxJT9SZHytJJa+rNKh2TTRoC3HexHqh
        zNPKrPRA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m3haJ-002Mdo-I5; Wed, 14 Jul 2021 16:18:13 +0000
Date:   Wed, 14 Jul 2021 17:18:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Rafa?? Mi??ecki <zajec5@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] vboxsf fixes for 5.14-1
Message-ID: <YO8OP7vzHIuKvO6X@infradead.org>
References: <30c7ec73-4ad5-3c4e-4745-061eb22f2c8a@redhat.com>
 <CAHk-=wjW7Up3KD-2EqVg7+ca8Av0-rC5Kd7yK+=m6Dwk3D4Q+A@mail.gmail.com>
 <YO30DKw5FKLz4QuF@zeniv-ca.linux.org.uk>
 <bea2bcf2-02f6-f247-9e06-7b9ec154377a@gmail.com>
 <YO755O8JnxG44YaT@kroah.com>
 <7f4a96bc-3912-dfb6-4a32-f0c6487d977b@gmail.com>
 <20210714161352.GA22357@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714161352.GA22357@magnolia>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 09:13:52AM -0700, Darrick J. Wong wrote:
> Porting to fs/iomap can be done after merge, so long as the ntfs3
> driver doesn't depend on crazy reworking of buffer heads or whatever.
> AFAICT it didn't, so ... yes, my earlier statements still apply: "later
> as a clean up".

I on the other hand hate piling up mor of this legacy stuff, as it tends
to not be cleaned up by the submitted.  Example: erofs still hasn't
switched to iomap despite broad claims, also we still have a huge
backlog in the switch to the new mount API.
