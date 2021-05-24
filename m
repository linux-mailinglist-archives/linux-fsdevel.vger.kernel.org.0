Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3371B38F0EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 May 2021 18:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhEXQGw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 May 2021 12:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbhEXQFO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 May 2021 12:05:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E266BC0612A3;
        Mon, 24 May 2021 08:19:59 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B7C131F41D90
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     amir73il@gmail.com, kernel@collabora.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>, jack@suse.com,
        dhowells@redhat.com, khazhy@google.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 00/11] File system wide monitoring
Organization: Collabora
References: <20210521024134.1032503-1-krisman@collabora.com>
        <YKmS0KyZ6RoCw4We@mit.edu>
Date:   Mon, 24 May 2021 11:19:50 -0400
In-Reply-To: <YKmS0KyZ6RoCw4We@mit.edu> (Theodore Y. Ts'o's message of "Sat,
        22 May 2021 19:25:05 -0400")
Message-ID: <87h7isp3ah.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Y. Ts'o" <tytso@mit.edu> writes:

> Hi Gabriel,
>
> Quick question; what userspace program are you using to test this
> feature?  Do you have a custom testing program you are using?  If so,
> could share it?

Hello Ted,

I'm using the program in patch 10, to watch and print notifications ,
along with corrupt filesystems. I trigger operations via command line
and watch the reports flow. I have slightly modified the sample code to
test marks disappearing at inopportune times, but that's trivial to
recreate with the samples code.

I plan to write more automated tests for LTP, once we settle on this
design.

-- 
Gabriel Krisman Bertazi
