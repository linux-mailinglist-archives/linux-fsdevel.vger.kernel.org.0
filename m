Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F3C252B76
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Aug 2020 12:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgHZKfc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Aug 2020 06:35:32 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:59567 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728097AbgHZKfb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Aug 2020 06:35:31 -0400
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3CE89206462B6;
        Wed, 26 Aug 2020 12:35:28 +0200 (CEST)
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        it+linux-fsdevel@molgen.mpg.de
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Warnings about filesystem timestamp support until 2038
Message-ID: <cdbeeb71-8029-3049-852c-6f2561fdd622@molgen.mpg.de>
Date:   Wed, 26 Aug 2020 12:35:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dear Deepa,


Commit v5.3-rc6-4-gf8b92ba67c5d3 (mount: Add mount warning for impending 
timestamp expiry) [1] results in a lot of warnings on our systems.

     xfs filesystem being mounted at /amd/salvadorthegunzerker/0 
supports timestamps until 2038 (0x7fffffff)

Unfortunately, I am missing the motivation for adding the warning in the 
commit message. Why is it warned about and what should users do about 
it? In our case, what should XFS and ext4 filesystem users do?


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f8b92ba67c5d3a9e9468320078a97d950a3e748b
