Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD90214AF4
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Jul 2020 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgGEHea (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 5 Jul 2020 03:34:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:48772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgGEHea (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:34:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C32720702;
        Sun,  5 Jul 2020 07:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593934470;
        bh=M0Nl0piVJywOWOh5GkXic1ooxXaj3OJL4yQvkIzhHc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jeRjaa14xmg7VN1dNQTqNABuDjz5ik3ypPX5CDQdd7lbMcZ42I3Ycp9dJuLQ356ST
         SPZAkO62/Dsek+qBJK8A0e8Q9d6LJKUyfiOf7dlPWFfUTKqe7J6ahukX/P0Qtqo/hC
         SzJg6nSCHZ5Rp5Ld0cao8dQSiNJ8ZXaKlQjmSuDY=
Date:   Sun, 5 Jul 2020 09:34:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     viro@zeniv.linux.org.uk, mtk.manpages@gmail.com, shuah@kernel.org,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: add readfile(2) selftests
Message-ID: <20200705073426.GA37944@kroah.com>
References: <20200704140250.423345-1-gregkh@linuxfoundation.org>
 <20200704140250.423345-4-gregkh@linuxfoundation.org>
 <fdaa31b7-b045-e38b-680a-01f0389e6acc@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdaa31b7-b045-e38b-680a-01f0389e6acc@gmx.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Jul 05, 2020 at 03:41:48AM +0200, Heinrich Schuchardt wrote:
> On 7/4/20 4:02 PM, Greg Kroah-Hartman wrote:
> > Test the functionality of readfile(2) in various ways.
> 
> Hello Greg,
> 
> I expect readfile() to generate fanotify events FAN_OPEN_PERM, FAN_OPEN,
> FAN_ACCESS_PERM, FAN_ACCESS, FAN_CLOSE_NOWRITE in this sequence.

Yes, it should, I don't think I do anything unique here when it comes to
vfs accesses that would go around those events.

> Looking at patch 1/3 you took care of notifications. Would this deserve
> testing here?

Possibly, do we have other in-tree tests of syscalls that validate those
events properly being created?

thanks,

greg k-h
