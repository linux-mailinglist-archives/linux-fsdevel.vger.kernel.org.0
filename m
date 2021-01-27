Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA06D30513B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237120AbhA0Eq0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237876AbhA0EAF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 23:00:05 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84113C061573;
        Tue, 26 Jan 2021 19:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=VU7YJf7mWfMYEHV3k5oxL8edagAxKHbwFXX/X3Di06I=; b=mTvPerrFiTIRiKpNEHzd53A/uc
        muKcKRlLyiW+EMFXPrXS+aCGgSdTz5VZspPRyBntyzCm4im54lHTOQARlQOp4i0O95Bicm/q6OPy1
        LCgiapGNGmaNVrwzoElogghXS8/AOI0SkxZ+WxO8yeX0DAsrDtKrfKbI4Lg1aKTDcB18rss0hhXAa
        P9UdDGdQPjn31Tl4bzv/ee9scnHt+uEyvrHql70mFf778MyyN17SO7jVWXsdHKIy65anwFPDFTxPg
        gAYrUtEczZMj4v5WFLom0CGUaaSeLfrpmsZyAto/EUCbPhNyHXE2I/NBab00H+w6hemTm4hOlw7p1
        wwaIp2YA==;
Received: from [2601:1c0:6280:3f0::7650]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1l4bzH-0008LS-2A; Wed, 27 Jan 2021 03:59:23 +0000
Subject: Re: [PATCH 1/2] fs/efs/inode.c: follow style guide
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Amy Parker <enbyamy@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAE1WUT55QViS=XE9QUTDp1KQ1_5fwuddLY3+2XSrMdoOuCOyYg@mail.gmail.com>
 <5d005259-feec-686d-dc32-e1b10cf74459@infradead.org>
Message-ID: <df3e21ea-1626-ba3a-a009-6b3c5e33a260@infradead.org>
Date:   Tue, 26 Jan 2021 19:59:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <5d005259-feec-686d-dc32-e1b10cf74459@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 7:46 PM, Randy Dunlap wrote:
> Hi Amy,
> 
> What mail client did you use?
> It is breaking (splitting) long lines into shorter lines and that
> makes it not possible to apply the patch cleanly.
> 
> You can see this problem below or on the web in an email archive.
> 
> Possibly Documentation/process/email-clients.rst can help you.

Also tabs in the source file have been converted to spaces.

It would be good if you could email a patch to yourself and then
see if you can apply cleanly it to your source tree (after removing
any conflicting patches, of course -- or use a different source
tree).


-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
netiquette: https://people.kernel.org/tglx/notes-about-netiquette
