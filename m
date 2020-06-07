Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 698F21F0933
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Jun 2020 03:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgFGBO7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 Jun 2020 21:14:59 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:54425 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728723AbgFGBO7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 Jun 2020 21:14:59 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 0571DtHP003723;
        Sun, 7 Jun 2020 10:13:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Sun, 07 Jun 2020 10:13:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 0571Dnfn003612
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sun, 7 Jun 2020 10:13:55 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently
 unmantained
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, akpm@linux-foundation.org,
        ast@kernel.org, davem@davemloft.net, viro@zeniv.linux.org.uk,
        bpf <bpf@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200329005528.xeKtdz2A0%akpm@linux-foundation.org>
 <13fb3ab7-9ab1-b25f-52f2-40a6ca5655e1@i-love.sakura.ne.jp>
 <202006051903.C44988B@keescook> <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <4a82a143-29f1-6f5c-a83f-0cede795c262@i-love.sakura.ne.jp>
Date:   Sun, 7 Jun 2020 10:13:46 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/06/07 4:20, Eric W. Biederman wrote:
> Kees, Tesuo.  Unless someone chimes in and says they care I will
> rebase this patch onto -rc1 to ensure I haven't missed something
> because of the merge window and send this to Linus.

Is the exec support of bpfilter already supported by distributions?
I can see that RHEL8's 4.18 kernel contains several changelogs
( https://git.centos.org/rpms/kernel/blob/c8/f/SPECS/kernel.spec )
that might be relevant to the exec support of bpfilter.
If it is not supported yet, removing the code would be a choice.

