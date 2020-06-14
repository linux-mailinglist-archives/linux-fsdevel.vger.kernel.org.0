Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28111F8765
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jun 2020 09:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgFNHMl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 03:12:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNHMk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:12:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72E7B20714;
        Sun, 14 Jun 2020 07:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592118760;
        bh=0vN1w9ETUOy/X7MD4cx87lWgTNrDzSyXiwMz9T1CyeA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=emUfJCiKDRvZYA9vTPzurljz+hHAFSsF1POBOJeAZlSsuDkdk+mJU0KsKE45mtvgk
         ERE3ROK1Akj2xkMvKApmgrwh9s+m+uicxQJxX0nKUpfCBBhBRAXLSkHVErHU437Wzx
         9yUjfCV0OuK0m1KnLN8T9x4L6khXelo1AHYMkvjc=
Date:   Sun, 14 Jun 2020 09:12:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] proc/fd: Remove unnecessary variable initialisations
 in seq_show()
Message-ID: <20200614071235.GA2629255@kroah.com>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:45:57PM +0200, Markus Elfring wrote:
> > 'files' will be immediately reassigned. 'f_flags' and 'file' will be
> > overwritten in the if{} or seq_show() directly exits with an error.
> > so we don't need to consume CPU resources to initialize them.
> 
> I suggest to improve also this change description.
> 
> * Should the mentioned identifiers refer to variables?
> 
> * Will another imperative wording be preferred?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b791d1bdf9212d944d749a5c7ff6febdba241771#n151
> 
> * I propose to extend the patch a bit more.
>   How do you think about to convert the initialisation for the variable “ret”
>   also into a later assignment?
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
