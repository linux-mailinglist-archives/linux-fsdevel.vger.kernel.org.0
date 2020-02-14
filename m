Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82AA115F74E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 21:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389405AbgBNUCP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 15:02:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389352AbgBNUCO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 15:02:14 -0500
Received: from localhost (unknown [12.246.51.142])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E25C2465D;
        Fri, 14 Feb 2020 20:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581710533;
        bh=iKkjnAjK2qRuw6EPVeGwQLbPNxV16s5T5iR1HhE3JOc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YDGLP3c/zic7UDxjcou+8zuUSL9tozcKucWgYu4CV6lZUKjf1pj7HTo3kFG/jLGXV
         GhSASbADLjT46cHWpBFKSrizQmeqa+5hCxd+5Gp5fdM3jTBFoJF+FgE68rl9U/9/KD
         qn7svYMI/ouOjLaiqeW7iuntd8VN915HkUdrj4o4=
Date:   Fri, 14 Feb 2020 08:18:10 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.mitsubishielectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH v2 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200214161810.GA3964830@kroah.com>
References: <20200214033140.72339-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214033140.72339-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 14, 2020 at 12:31:39PM +0900, Tetsuhiro Kohada wrote:
> remove 'dos_name','ShortName' and related definitions.
> 
> 'dos_name' and 'ShortName' are definitions before VFAT.
> These are never used in exFAT.
> 
> Signed-off-by: Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
> ---
> Changes in v2:
> - Rebase to linux-next-next-20200213.

I think you might need to rebase again, this patch doesn't apply at all
to my tree :(

sorry,

greg k-h
