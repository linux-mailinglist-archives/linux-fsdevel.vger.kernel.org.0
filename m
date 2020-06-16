Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7011FA9FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 09:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgFPHe3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 03:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgFPHe3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 03:34:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DAAC05BD43;
        Tue, 16 Jun 2020 00:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6e05mEMN5r0vauFG93kV9PdfbM94bPRc4VAqYDDZqsI=; b=Szn1gACICyddKGEwiy4LJBcHl3
        cmi9//PszUFgUgpX6jZafC5n3U7ntXj4wD0lWiJjQDRdfBJsDkA8aQKgIpeQ3QPbrtZGw41QIMfWL
        Memnv9zVHJmQX50ZYz/UeGnPKsj4gvKeURU9jvJOwq1cSeYDMB6p2en3BmfXB5qQMDOBvXJiCRpx+
        LFI9MCVD0SRxxEMkT502zpgu/Mrx5od3PizTtv5MWWx6cAPti2FzWOi76guW9HHAYkHztrOTeHAq4
        Anpd8GC7uZljRzq/JvWYODpBKKq5WzYa1VLMtc6dGskmMoY2nFAAEWAYk9l69Q02xq0jPZVfeIgxf
        q+DDL2CQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl66x-0002Tx-3V; Tue, 16 Jun 2020 07:34:23 +0000
Date:   Tue, 16 Jun 2020 00:34:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 1/8] fs: introduce kernel_pread_file* support
Message-ID: <20200616073423.GC30385@infradead.org>
References: <20200615194151.7011-1-scott.branden@broadcom.com>
 <20200615194151.7011-2-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615194151.7011-2-scott.branden@broadcom.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Seriously, no more additions to fs.h for this interface please.  As
requested before as the very first thing move it out of this header
used by just about every file in the kernel.  That is in addition
to all the other issues with the interface.
