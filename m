Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1AA1554F8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgBGJqQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:46:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:52940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgBGJqP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:46:15 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC4C722314;
        Fri,  7 Feb 2020 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581068775;
        bh=ZRczVq8huS30y5na4+I2se7v9Uv/Sjaw+uD78GP3QtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHgfkjw0Ypl+1TcQRFuzJAfU1WwSx87eqQZZ8FgBcbTay1WBHfcRR58zgp/Eu6SdL
         +w/EeOG/Bc05fx1OKZKACJoYxSo36OFwHANIQTblgVou81ATSucC/Sv5IB4KSS4IBD
         F/tKrKJmPUKtQTecJlUUQkmhLXDiuM1WLieFnuJo=
Date:   Fri, 7 Feb 2020 10:46:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     valdis.kletnieks@vt.edu, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 02/22] staging: exfat: Rename variable "Month" to "mont"h
Message-ID: <20200207094612.GA562325@kroah.com>
References: <20200127101343.20415-1-pragat.pandya@gmail.com>
 <20200127101343.20415-3-pragat.pandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127101343.20415-3-pragat.pandya@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:43:23PM +0530, Pragat Pandya wrote:
> Change all the occurrences of "Month" to "month" in exfat.

Your subject line is a bit "odd" :(

Anyway, can you rebase this series and resend only what you want to do
here instead of me having to randomly pick out different parts?

thanks,

greg k-h
