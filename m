Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA0276226
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 22:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgIWUav (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 16:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUau (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 16:30:50 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1739C0613CE;
        Wed, 23 Sep 2020 13:30:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3695329C66D
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Daniel Rosenberg <drosen@google.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org, kernel-team@android.com
Subject: Re: [PATCH 1/5] ext4: Use generic casefolding support
Organization: Collabora
References: <20200923010151.69506-1-drosen@google.com>
        <20200923010151.69506-2-drosen@google.com>
        <20200923054714.GB9538@sol.localdomain>
Date:   Wed, 23 Sep 2020 16:30:45 -0400
In-Reply-To: <20200923054714.GB9538@sol.localdomain> (Eric Biggers's message
        of "Tue, 22 Sep 2020 22:47:14 -0700")
Message-ID: <87o8lw5j7u.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> writes:

> On Wed, Sep 23, 2020 at 01:01:47AM +0000, Daniel Rosenberg wrote:
>> This switches ext4 over to the generic support provided in
>> the previous patch.
>> 
>> Since casefolded dentries behave the same in ext4 and f2fs, we decrease
>> the maintenance burden by unifying them, and any optimizations will
>> immediately apply to both.
>> 
>> Signed-off-by: Daniel Rosenberg <drosen@google.com>
>> Reviewed-by: Eric Biggers <ebiggers@google.com>
>
> You could also add Gabriel's Reviewed-by from last time:
> https://lkml.kernel.org/linux-fsdevel/87lfh4djdq.fsf@collabora.com/

Yep, I was gonna say that. Assuming nothing changed from the last
submission in the other series.

Thanks,

-- 
Gabriel Krisman Bertazi
