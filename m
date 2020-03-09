Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF09C17E7C1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 20:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCITDM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 15:03:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727387AbgCITDM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:03:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84A2A20866;
        Mon,  9 Mar 2020 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583780590;
        bh=2ET3zVpeRnpZ3ROIgi4aRDyuRkEQHwxlCnxa1J2mWo8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G1cvtl4Gkr6EzsVT6JjBcmK6wCd6qVWhh40OJo9VKdX5D6E7jD00fD35yiEOzL9xx
         jTg/NjNIYTN+MxhCFabcL0qtrxDhA+q8ngnEseAEGlkrfpwCI24dFEeECa+CQYzb2n
         T2zpDS/zVEcGc8Z25uhQ0o4uzuExUC+IJCdZbFRQ=
Date:   Mon, 9 Mar 2020 20:03:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bruno Thomsen <bruno.thomsen@gmail.com>, miklos@szeredi.hu
Cc:     michael+lkml@stapelberg.ch, fuse-devel@lists.sourceforge.net,
        kyle.leet@gmail.com, linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Bruno Thomsen <bth@kamstrup.com>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
Message-ID: <20200309190307.GA377052@kroah.com>
References: <CAH+2xPBuLsVjwStj4hQHDEbogKW+mXd2p66DG9X2F8nW+doyHw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH+2xPBuLsVjwStj4hQHDEbogKW+mXd2p66DG9X2F8nW+doyHw@mail.gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 10:31:42AM +0100, Bruno Thomsen wrote:
> Hi,
> 
> First of all, sorry for the incorrect reply as I was not subscribed to
> the mailing list.
> 
> A colleague and I have tested Miklos patch[1] on top of Fedora 31
> 5.5.7 kernel and it fixes a kernel oops[2] when using rootless
> containers in Podman. Fix has been running for a few days now,
> and the issue was normally reproducible within a few minutes.
> 
> Tested-by: Bruno Thomsen <bruno.thomsen@gmail.com>
> 
> /Bruno
> 
> [1] https://lore.kernel.org/linux-fsdevel/CAJfpegvBguKcNZk-p7sAtSuNH_7HfdCyYvo8Wh7X6P=hT=kPrA@mail.gmail.com/

Any plan on getting this merged into Linus's tree?

greg k-h
