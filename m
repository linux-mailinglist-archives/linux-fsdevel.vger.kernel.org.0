Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4224C211158
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 18:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgGAQz2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 12:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:58200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730955AbgGAQz1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:55:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23D72071A;
        Wed,  1 Jul 2020 16:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593622527;
        bh=GvtsGp11yx4CyQuZ9RgW9RmPb9CbIpEadx+tC5GAmYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wef9XUjzZgqElVeeA6mWBmPRS8DJOiCuCsDfm+qOciiluO0lS0zIQcl7Ga69d16hG
         kMLS+YRdNuRemWr0BPaYksQuagE3DzG/PhEy+VeVyIAsCbzA6H/+IcdoLlR+PbvDFC
         jIowDjMEDK75H9txsXow2QCgtEQTvKB5z2gMVQbo=
Date:   Wed, 1 Jul 2020 18:55:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Jessica Yu <jeyu@kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH v3 1/1] fs: move kernel_read_file* to its own include file
Message-ID: <20200701165513.GA3176669@kroah.com>
References: <20200617161218.18487-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617161218.18487-1-scott.branden@broadcom.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 17, 2020 at 09:12:18AM -0700, Scott Branden wrote:
> Move kernel_read_file* out of linux/fs.h to its own linux/kernel_read_file.h
> include file. That header gets pulled in just about everywhere
> and doesn't really need functions not related to the general fs interface.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Scott Branden <scott.branden@broadcom.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
