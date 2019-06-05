Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71435854
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jun 2019 10:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfFEINE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 04:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:38778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbfFEINE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:13:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 455772075C;
        Wed,  5 Jun 2019 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559722383;
        bh=93lPZPoK1JhJhOgE1GB3XAmEenhb5pgYNCcngZSfVCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eqPEzhfm+mkz1rP0CgJZV9awvJBNXBuRcqT+ilCPLoP0gwknLDHMvX4F5m9zCop8U
         84TzlNrABj84RSwcqTt7WMtw0TxXzVI4dOemlR3jLbM3yROOl0NbxjQ+Je/v/S3/uE
         3dotGPa8vedQPR0A4+Y4tbeeBVzDaLiAssy7PsEc=
Date:   Wed, 5 Jun 2019 10:13:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Garrett <mjg59@google.com>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
        linux-fsdevel@vger.kernel.org, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>
Subject: Re: [WIP RFC PATCH 0/6] Generic Firmware Variable Filesystem
Message-ID: <20190605081301.GA23180@kroah.com>
References: <20190520062553.14947-1-dja@axtens.net>
 <316a0865-7e14-b36a-7e49-5113f3dfc35f@linux.vnet.ibm.com>
 <87zhmzxkzz.fsf@dja-thinkpad.axtens.net>
 <20190603072916.GA7545@kroah.com>
 <87tvd6xlx9.fsf@dja-thinkpad.axtens.net>
 <b2312934-42a6-f2e7-61d2-3d95222a1699@linux.vnet.ibm.com>
 <CACdnJutpgxd0Se-UDR4Gw3s+KfTuHprUTqFqxq+qu17vd4xr7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACdnJutpgxd0Se-UDR4Gw3s+KfTuHprUTqFqxq+qu17vd4xr7Q@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 04, 2019 at 01:05:45PM -0700, Matthew Garrett wrote:
> On Tue, Jun 4, 2019 at 1:01 PM Nayna <nayna@linux.vnet.ibm.com> wrote:
> > It seems efivars were first implemented in sysfs and then later
> > separated out as efivarfs.
> > Refer - Documentation/filesystems/efivarfs.txt.
> >
> > So, the reason wasn't that sysfs should not be used for exposing
> > firmware variables,
> > but for the size limitations which seems to come from UEFI Specification.
> >
> > Is this limitation valid for the new requirement of secure variables ?
> 
> I don't think the size restriction is an issue now, but there's a lot
> of complex semantics around variable deletion and immutability that
> need to be represented somehow.

Ah, yeah, that's the reason it would not work in sysfs, forgot all about
that, thanks.

greg k-h
