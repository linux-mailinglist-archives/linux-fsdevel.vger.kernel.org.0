Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1025A1F766E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 12:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgFLKCA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 06:02:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:36206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgFLKB7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:01:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A15FB207D8;
        Fri, 12 Jun 2020 10:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591956119;
        bh=xFacIB852PBLC/3e4BDu950ODxUlC/jBtFDBNjC/Xrs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VNYglQsRlly8rbbI+CxH46C6AJYu3iMe73SHsZPQ8KMvuRDNKxK0VZ1KUmCVcwxeY
         Yu5NeF//kbEJ2XcA0RVpWu8pKF98Xn692Eq0Zu9o/GjPNe/BX1Mrp1WGx03veLMdDR
         1QN5YWBRBZ8rm9u0JTKknELf8bSXnmj4EgPz7ChU=
Date:   Fri, 12 Jun 2020 12:01:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Tetsuhiro Kohada <kohada.t2@gmail.com>,
        linux-fsdevel@vger.kernel.org,
        Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>,
        Takahiro Mori <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        Hirotaka Motai <motai.hirotaka@aj.mitsubishielectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exfat: remove EXFAT_SB_DIRTY flag
Message-ID: <20200612100150.GC3157576@kroah.com>
References: <4591596d-b33c-7e6d-803b-3375064bcf3f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4591596d-b33c-7e6d-803b-3375064bcf3f@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:48:20AM +0200, Markus Elfring wrote:
> > remove EXFAT_SB_DIRTY flag and related codes.
> 
> I suggest to omit this sentence because a similar information
> is provided a bit later again for this change description.
> 
> 
> > If performe 'sync' in this state, VOL_DIRTY will not be cleared.
> 
> Please improve this wording.
> 
> 
> Would you like to add the tag “Fixes” to the commit message?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b791d1bdf9212d944d749a5c7ff6febdba241771#n183
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
