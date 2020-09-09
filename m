Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D530262ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 14:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730193AbgIIM5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 08:57:33 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35698 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730168AbgIIM4c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:56:32 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kFzcp-0005yj-AB; Wed, 09 Sep 2020 06:54:59 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kFzco-0004SP-M1; Wed, 09 Sep 2020 06:54:59 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Hao Lee <haolee.swjtu@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200729151740.GA3430@haolee.github.io>
        <20200908130656.GC22780@haolee.github.io>
        <20200908184857.GT1236603@ZenIV.linux.org.uk>
        <20200908231156.GA23779@haolee.github.io>
Date:   Wed, 09 Sep 2020 07:54:44 -0500
In-Reply-To: <20200908231156.GA23779@haolee.github.io> (Hao Lee's message of
        "Tue, 8 Sep 2020 23:11:56 +0000")
Message-ID: <87k0x39kkr.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kFzco-0004SP-M1;;;mid=<87k0x39kkr.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cGAlwG5SJvXhASPH3BzmknXhShGQlYMk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa03 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Hao Lee <haolee.swjtu@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 286 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.8 (1.3%), b_tie_ro: 2.6 (0.9%), parse: 0.64
        (0.2%), extract_message_metadata: 2.5 (0.9%), get_uri_detail_list:
        1.07 (0.4%), tests_pri_-1000: 2.7 (0.9%), tests_pri_-950: 0.98 (0.3%),
        tests_pri_-900: 0.79 (0.3%), tests_pri_-90: 57 (20.1%), check_bayes:
        56 (19.7%), b_tokenize: 4.9 (1.7%), b_tok_get_all: 6 (2.0%),
        b_comp_prob: 1.54 (0.5%), b_tok_touch_all: 42 (14.6%), b_finish: 0.61
        (0.2%), tests_pri_0: 202 (70.9%), check_dkim_signature: 0.38 (0.1%),
        check_dkim_adsp: 2.3 (0.8%), poll_dns_idle: 0.84 (0.3%), tests_pri_10:
        2.7 (0.9%), tests_pri_500: 6 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs: Eliminate a local variable to make the code more clear
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hao Lee <haolee.swjtu@gmail.com> writes:

> On Tue, Sep 08, 2020 at 07:48:57PM +0100, Al Viro wrote:
>> On Tue, Sep 08, 2020 at 01:06:56PM +0000, Hao Lee wrote:
>> > ping
>> > 
>> > On Wed, Jul 29, 2020 at 03:21:28PM +0000, Hao Lee wrote:
>> > > The dentry local variable is introduced in 'commit 84d17192d2afd ("get
>> > > rid of full-hash scan on detaching vfsmounts")' to reduce the length of
>> > > some long statements for example
>> > > mutex_lock(&path->dentry->d_inode->i_mutex). We have already used
>> > > inode_lock(dentry->d_inode) to do the same thing now, and its length is
>> > > acceptable. Furthermore, it seems not concise that assign path->dentry
>> > > to local variable dentry in the statement before goto. So, this function
>> > > would be more clear if we eliminate the local variable dentry.
>> 
>> How does it make the function more clear?  More specifically, what
>> analysis of behaviour is simplified by that?
>
> When I first read this function, it takes me a few seconds to think
> about if the local variable dentry is always equal to path->dentry and
> want to know if it has special purpose. This local variable may confuse
> other people too, so I think it would be better to eliminate it.

I tend to have the opposite reaction.  I read your patch and wonder
why path->dentry needs to be reread what is changing path that I can not see.
my back.

Now for clarity it would probably help to do something like:

diff --git a/fs/namespace.c b/fs/namespace.c
index bae0e95b3713..430f3b4785e3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2206,7 +2206,7 @@ static struct mountpoint *lock_mount(struct path *path)
                return mp;
        }
        namespace_unlock();
-       inode_unlock(path->dentry->d_inode);
+       inode_unlock(dentry->d_inode);
        path_put(path);
        path->mnt = mnt;
        dentry = path->dentry = dget(mnt->mnt_root);


So at least the inode_lock and inode_unlock are properly paired.

At first glance inode_unlock using path->dentry instead of dentry
appears to be an oversight in 84d17192d2af ("get rid of full-hash scan
on detaching vfsmounts").  


Eric
