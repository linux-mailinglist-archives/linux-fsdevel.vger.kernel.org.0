Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5501C4B663F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 09:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiBOIgy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 03:36:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbiBOIgx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:36:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E20399EE1;
        Tue, 15 Feb 2022 00:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=+wSOWyUveQs4v/OCD6Y3hItiienipzVxB3XYEj5tLdQ=; b=wllaFPVA29WPjhExj7DZD52OsR
        HJUVJhbFAa9muNK0mlNEiGDIY2SrjAqclbpZfSF0EfjuNbQMbeTDlwZ/wfK/VrOmx+0LhUbHXU0no
        uT3IsqpbNlcK+y6cpWcGMVxQbLAU5aBHUYWfKfEDJ7DWSpj/7sagNwJJV1pmiq7tAZHwj2T7ZUeRp
        18KTKt28e+PNNI23ayxxzOsx9HPdCJHCLQBARKhpWr0NUxzctbY/pGljWRG6TFSL7rjTpz5CFn23M
        KRXXSnE5SbJDYip7D+Q9gw9Vs7j6M69KRFqw0huRoqai9GLoutTYULKvPc1vdYUe+IHgoScgquCsZ
        GF6KuZww==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJtKB-001k66-E1; Tue, 15 Feb 2022 08:36:39 +0000
Date:   Tue, 15 Feb 2022 00:36:39 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     =?utf-8?B?6IuP5a626K6t?= <sujiaxun@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: move oom_kill sysctls to their own file
Message-ID: <YgtmF8MCJGN/ZvNo@bombadil.infradead.org>
References: <20220215030257.11150-1-sujiaxun@uniontech.com>
 <YgtWZ0B7OzluiOkr@bombadil.infradead.org>
 <b86e23bf-1b90-6e31-66d9-10f9785ff8ed@uniontech.com>
 <Ygtdgp9P8+887VMm@bombadil.infradead.org>
 <7058b3c2-5c22-f163-1f1a-3906d9b7e047@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7058b3c2-5c22-f163-1f1a-3906d9b7e047@uniontech.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 04:23:48PM +0800, 苏家训 wrote:
> 
> 
> 在 2022/2/15 16:00, Luis Chamberlain 写道:
> > On Tue, Feb 15, 2022 at 03:56:10PM +0800, 苏家训 wrote:
> > > I checked the patch using ./scripts/checkpatch.pl and found no errors.
> > 
> > ./scripts/get_maintainer.pl, not checkpatch.
> > 
> >    Luis
> > 
> I checked the patch using ./scripts/get_maintainer.pl. Is there something
> wrong with my sending?
> src/linux-next$ ./scripts/get_maintainer.pl
> 0001-mm-move-oom_kill-sysctls-to-their-own-file.patch
> Luis Chamberlain <mcgrof@kernel.org> (maintainer: PROC SYSCTL)
> Kees Cook <keescook@chromium.org> (maintainer:PROC SYSCTL)
> Iurii Zaikin <yzaikin@google.com> (maintainer:PROC SYSCTL)
> Andrew Morton <akpm@linux-foundation.org> (maintainer:MEMORY MANAGEMENT)
> linux-kernel@vger.kernel.org (open list)
> linux-fsdevel@vger.kernel.org (open list: PROC SYSCTL)
> linux-mm@kvack.org (open list:MEMORY MANAGEMENT)

Looks good, sorry for the noise.

  Luis

