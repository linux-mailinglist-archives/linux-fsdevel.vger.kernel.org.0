Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F43321759A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 19:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgGGRug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 13:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728211AbgGGRuf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:50:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C94C061755;
        Tue,  7 Jul 2020 10:50:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 651CF2A39FD
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v10 1/4] unicode: Add utf8_casefold_hash
Organization: Collabora
References: <20200707113123.3429337-1-drosen@google.com>
        <20200707113123.3429337-2-drosen@google.com>
Date:   Tue, 07 Jul 2020 13:50:27 -0400
In-Reply-To: <20200707113123.3429337-2-drosen@google.com> (Daniel Rosenberg's
        message of "Tue, 7 Jul 2020 04:31:20 -0700")
Message-ID: <877dvftdss.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Daniel Rosenberg <drosen@google.com> writes:

> This adds a case insensitive hash function to allow taking the hash
> without needing to allocate a casefolded copy of the string.
>
> The existing d_hash implementations for casefolding allocates memory
> within rcu-walk, by avoiding it we can be more efficient and avoid
> worrying about a failed allocation.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>

Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

-- 
Gabriel Krisman Bertazi
