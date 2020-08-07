Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B57523F40B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Aug 2020 22:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgHGU6y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Aug 2020 16:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgHGU6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Aug 2020 16:58:54 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962E4C061756;
        Fri,  7 Aug 2020 13:58:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id EBC47299758
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Unicode patches for v5.9
Organization: Collabora
References: <87blkap6az.fsf@collabora.com>
Date:   Fri, 07 Aug 2020 16:58:48 -0400
In-Reply-To: <87blkap6az.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Mon, 20 Jul 2020 11:14:28 -0400")
Message-ID: <87tuxe5g1j.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Gabriel Krisman Bertazi <krisman@collabora.com> writes:

> The following changes since commit 9c94b39560c3a013de5886ea21ef1eaf21840cb9:
>
>   Merge tag 'ext4_for_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4 (2020-04-05 10:54:03 -0700)
>

Hi Ted,

Sorry for the ping, I understand you are extra busy :)

Do you have any concerns about this PR for 5.9?  I believe it wasn't
pulled into your tree for the 5.9 ext4 PR.  Anything I can do here to
improve my process?

Thanks,


-- 
Gabriel Krisman Bertazi
