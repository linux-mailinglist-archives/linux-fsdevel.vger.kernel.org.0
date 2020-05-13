Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385F01D1D45
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 20:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbgEMSSB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 14:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733175AbgEMSSA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 14:18:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BFEC061A0C;
        Wed, 13 May 2020 11:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6a106r24oix+PzCyy+USaUUOw38g4Aznt/gPVHR4CZk=; b=NasOCRNjdTTlMhsT2lorgYHFy5
        QBRktg40d0jEZqAChN2WrlD0midarXRz0wMmnjfyZAEWjK10RPb+fyJgygSYNPHhSN3J8qKu2+O7I
        XfXm/8V6OQ+FXQI7MtR8o2Fz6DhA+E6/F7FgKLj2gjQFDotR2yUxJFdLq4RRd9sG9k+oS68wOMGI9
        rfrhF+VUYXPGzU3vUHzYYoePYrH95pF/7yNphdB3+gZo/uJ0MD2eIc0TIg+HvIoLc1Wil5CzV7Yzf
        P6Y9VbfQ6J6sobDlUhm45wV70aKwIR5eXOgEtIVWxy2cIzyBwJrg41GCqC2clcM21YaCIYzrNsMPo
        Khn3K6Lg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYvwm-0006WX-HZ; Wed, 13 May 2020 18:17:36 +0000
Date:   Wed, 13 May 2020 11:17:36 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, ebiederm@xmission.com, jeyu@kernel.org,
        jmorris@namei.org, keescook@chromium.org, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        nayna@linux.ibm.com, zohar@linux.ibm.com,
        scott.branden@broadcom.com, dan.carpenter@oracle.com,
        skhan@linuxfoundation.org, geert@linux-m68k.org,
        tglx@linutronix.de, bauerman@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fs: reduce export usage of kerne_read*() calls
Message-ID: <20200513181736.GA24342@infradead.org>
References: <20200513152108.25669-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513152108.25669-1-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Can you also move kernel_read_* out of fs.h?  That header gets pulled
in just about everywhere and doesn't really need function not related
to the general fs interface.
