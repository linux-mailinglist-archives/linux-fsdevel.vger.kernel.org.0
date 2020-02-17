Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC59160A45
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 07:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgBQGL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 01:11:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:33878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQGLz (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:11:55 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08B620679;
        Mon, 17 Feb 2020 06:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581919915;
        bh=Emlzzc2erw8Gutp6n3O2iO9K4KcYC3JCWbweTckIHkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z8PMynEbAw8Omnzwsxph7oqrZ4NWZsnwH1B9VK4q4SVCSwPxVS7NcOUx05kEfPtK6
         VZUx2OjvLIaGy2d1YOKH2J9cln6MrmVj3QR2doqIjGqIhpkOlt24GwnfXBn7hm5/U9
         oNQ0CLBdKMScHL6BWAOT4fIvffoTUu0EPW6x1VaI=
Date:   Mon, 17 Feb 2020 07:11:51 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.mitsubishielectric.co.jp>
Cc:     "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.mitsubishielectric.co.jp>,
        "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.mitsubishielectric.co.jp>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] staging: exfat: remove DOSNAMEs.
Message-ID: <20200217061151.GA58638@kroah.com>
References: <20200214033140.72339-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
 <20200214161810.GA3964830@kroah.com>
 <TY1PR01MB1578EA0B95FE3C29D0F9A64190160@TY1PR01MB1578.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY1PR01MB1578EA0B95FE3C29D0F9A64190160@TY1PR01MB1578.jpnprd01.prod.outlook.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 17, 2020 at 01:54:07AM +0000, Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp wrote:
> > I think you might need to rebase again, this patch doesn't apply at all to my tree :(
> 
> Thanks for your comments.
> I'll try to rebase with 'staging-next' branch.
> Is this correct?

Yes it is, thanks.

greg k-h
