Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317FB1D70D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 May 2020 08:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgERGX3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 May 2020 02:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERGX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 May 2020 02:23:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73642C061A0C;
        Sun, 17 May 2020 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zmDenp7FJVk0qEChp/8vOq7H+ikcbyONDjlE6Bfir70=; b=fYuqdYV2oiyyyrVbKTLbjx1UWv
        6tceZf+hdlXvdYXsekdp03s0X2HYCv6BzfcWLaNBp9BvBCGT08fE7jAaEcfqQGqwcF7JHvrSDjYmi
        CyWC7NJeVFWYHyjqhYMhpZwQJaivcFmmM4s246+D+E2m4CXL+uDaH9sFImidOsWY1N7/HcELSuRPF
        zcVkz6Ny5AQibizOahgP9UEpvVJBXt3uP5WziTcrmnA5XAZCZmYSd3Ad6AqB30V9q3CKq2zX6odX9
        vHJl44a74vCpHCmPJkp9zpCIXla7LRLd5vj1c8R00oWcllxcNzpke+V/N4oNOJmswnrh0w2sE0E3x
        QJ4Cvsbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jaZAt-0007LB-Ns; Mon, 18 May 2020 06:22:55 +0000
Date:   Sun, 17 May 2020 23:22:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        ebiederm@xmission.com, jeyu@kernel.org, jmorris@namei.org,
        keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200518062255.GB15641@infradead.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
 <20200513181736.GA24342@infradead.org>
 <20200515212933.GD11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515212933.GD11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 09:29:33PM +0000, Luis Chamberlain wrote:
> On Wed, May 13, 2020 at 11:17:36AM -0700, Christoph Hellwig wrote:
> > Can you also move kernel_read_* out of fs.h?  That header gets pulled
> > in just about everywhere and doesn't really need function not related
> > to the general fs interface.
> 
> Sure, where should I dump these?

Maybe a new linux/kernel_read_file.h?  Bonus points for a small top
of the file comment explaining the point of the interface, which I
still don't get :)
