Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF624957A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jan 2022 02:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbiAUBKx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 20:10:53 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbiAUBKw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 20:10:52 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3ED411F45843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642727451;
        bh=jHIs3XKzhPz//rxsayW/LeWaylwWk5P+YYlJwHwjTNc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=d/45kpz7h1Gh3Fee/A+jedC+TvoXnUVF7l8ZKMR6NoSTrSg5ujani40PMzMSnbnwN
         WP6wYw9iU883Yw18oiZSo5NNTEzFpxK8Zm8XhrtpDRO9siR//g1CzQCHVm1HNidhjt
         EjAkMzEMH6i/H6SVFxfhKlkW73E7C5F13zKxKs0Zlb/mztZUt/Ea3+HiOkgeTVrdsP
         +CMe27c4rvBR/8P80dE/AJqC/ZZFrgy33rxC0hc7RagSfMQbDZRiW3DQ4PAztXYwLF
         LaYWkxlKNb+z8mhY2LG2/uY15OKOGIHfYhy/aryR3L+9+XpqJYac/JjmemufolP/tI
         8ykwdwKmLHupA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH] unicode: clean up the Kconfig symbol confusion
Organization: Collabora
References: <20220118065614.1241470-1-hch@lst.de>
Date:   Thu, 20 Jan 2022 20:10:47 -0500
In-Reply-To: <20220118065614.1241470-1-hch@lst.de> (Christoph Hellwig's
        message of "Tue, 18 Jan 2022 07:56:14 +0100")
Message-ID: <87zgnp51wo.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Christoph Hellwig <hch@lst.de> writes:

> Turn the CONFIG_UNICODE symbol into a tristate that generates some always
> built in code and remove the confusing CONFIG_UNICODE_UTF8_DATA symbol.
>
> Note that a lot of the IS_ENALBED() checks could be turned from cpp
> statements into normal ifs, but this change is intended to be fairly
> mechanic, so that should be cleaned up later.

Hi,

Just a typo s/ENALBED/ENABLED/.

> Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

I fixed the typo and pushed the patch to a linux-next visible branch

https://git.kernel.org/pub/scm/linux/kernel/git/krisman/unicode.git/commit/?h=for-next&id=5298d4bfe80f6ae6ae2777bcd1357b0022d98573

I'm also sending a patch series shortly turning IS_ENABLED into part of
the code flow where possible.

Thank you,

-- 
Gabriel Krisman Bertazi
