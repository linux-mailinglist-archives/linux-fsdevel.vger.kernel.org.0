Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6921F081C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Jun 2020 20:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgFFSSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 14:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728812AbgFFSSF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 14:18:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B90F20760;
        Sat,  6 Jun 2020 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591467485;
        bh=t7wqDR7wEpns2huirFDRDLQiWcQrd8e54+X0JMUW6Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwL0lZUyXV0DEXw6C8dg4xkl5oazFJEOP+uolRlYR2lgWX0IoRldzE/MGpV2ioDjO
         r/atlR3Yn4wfwTFsrQ+4GY01+XIyfosXielabV68cCPMs+oxymAD6l0fKbKm8hr3EK
         bLob7rD/+ehH9LMIeyO0Jzf//5V8RvpdqCnvAlWo=
Date:   Sat, 6 Jun 2020 20:18:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org
Subject: Re: [kernfs] ea7c5fc39a: stress-ng.stream.ops_per_sec 11827.2%
 improvement
Message-ID: <20200606181802.GA15638@kroah.com>
References: <159038562460.276051.5267555021380171295.stgit@mickey.themaw.net>
 <20200606155216.GU12456@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200606155216.GU12456@shao2-debian>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 06, 2020 at 11:52:16PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a 11827.2% improvement of stress-ng.stream.ops_per_sec due to commit:
> 
> 
> commit: ea7c5fc39ab005b501e0c7666c29db36321e4f74 ("[PATCH 1/4] kernfs: switch kernfs to use an rwsem")
> url: https://github.com/0day-ci/linux/commits/Ian-Kent/kernfs-proposed-locking-and-concurrency-improvement/20200525-134849
> 

Seriously?  That's a huge performance increase, and one that feels
really odd.  Why would a stress-ng test be touching sysfs?

thanks,

greg k-h
