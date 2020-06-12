Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C21E1F7BE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 19:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgFLRAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:00:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D9C03E96F;
        Fri, 12 Jun 2020 10:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=LB92fBYU7FIFr1cqrh9b2+gYP6egb7aYQX2MBBJTLlQ=; b=PqGggWcKugbvK/p3Jmkq4v0f8f
        KodxE7sDJyvfzUdXYv8y080mGvzFWv0kNg5UbIfwicX/DwYaihiSS5+HrqITy87E0feUrHX3Q04qE
        ekGgI0+EtkN+ikT7CMSYl1OK7QA6stAMGYW5Z93Zjinl+3ex5oipfh6uGbdQuwCSL5Bqei1POdAJn
        pXdm8qMeFvqWVkJxlO6EyrRk1rD5Qldo80dJ5YT1xgrp/GxGRwu9ZMSko7Ri6Rc0X0FtkowJ0b+IU
        ADWVlfdxoI6/2hMjSgxHYHHdIrvZOD4J0EXwOEhW8S6oPP4cSVqQxpaSRB4y6v3oSyleuWbGzZDC5
        xs62Ebjg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjn2f-0003nu-It; Fri, 12 Jun 2020 17:00:33 +0000
Date:   Fri, 12 Jun 2020 10:00:33 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Kaitao Cheng <pilgrimtao@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH v2] proc/fd: Remove unnecessary variable initialisations
 in seq_show()
Message-ID: <20200612170033.GF8681@bombadil.infradead.org>
References: <20200612160946.21187-1-pilgrimtao@gmail.com>
 <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fdada40-370d-37b3-3aab-bfbedaa1804f@web.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:45:57PM +0200, Markus Elfring wrote:
> > 'files' will be immediately reassigned. 'f_flags' and 'file' will be
> > overwritten in the if{} or seq_show() directly exits with an error.
> > so we don't need to consume CPU resources to initialize them.
> 
> I suggest to improve also this change description.
> 
> * Should the mentioned identifiers refer to variables?
> 
> * Will another imperative wording be preferred?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=b791d1bdf9212d944d749a5c7ff6febdba241771#n151
> 
> * I propose to extend the patch a bit more.
>   How do you think about to convert the initialisation for the variable “ret”
>   also into a later assignment?

Please stop commenting on people's changelogs.  You add no value.
