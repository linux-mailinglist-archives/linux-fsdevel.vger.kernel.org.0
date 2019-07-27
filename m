Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9562A77869
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 13:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfG0LUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jul 2019 07:20:30 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:43290 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfG0LU3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jul 2019 07:20:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hrKkV-0001FM-Fn; Sat, 27 Jul 2019 05:20:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1hrKkU-0002QG-KR; Sat, 27 Jul 2019 05:20:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
References: <20190726115956.ifj5j4apn3tmwk64@brauner.io>
        <CAHk-=wgK254RkZg9oAv+Wt4V9zqYJMm3msTofvTUfA9dJw6piQ@mail.gmail.com>
        <20190726232220.GM1131@ZenIV.linux.org.uk>
        <878sskqp7p.fsf@xmission.com>
        <20190727022826.GO1131@ZenIV.linux.org.uk>
Date:   Sat, 27 Jul 2019 06:20:18 -0500
In-Reply-To: <20190727022826.GO1131@ZenIV.linux.org.uk> (Al Viro's message of
        "Sat, 27 Jul 2019 03:28:26 +0100")
Message-ID: <87h877pvv1.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1hrKkU-0002QG-KR;;;mid=<87h877pvv1.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Vq3Lzknntv8YcPI8xoS/ElyuyKem99zY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 394 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.0 (0.8%), b_tie_ro: 2.1 (0.5%), parse: 1.09
        (0.3%), extract_message_metadata: 13 (3.3%), get_uri_detail_list: 2.0
        (0.5%), tests_pri_-1000: 7 (1.7%), tests_pri_-950: 1.26 (0.3%),
        tests_pri_-900: 1.04 (0.3%), tests_pri_-90: 22 (5.5%), check_bayes: 20
        (5.1%), b_tokenize: 6 (1.6%), b_tok_get_all: 7 (1.8%), b_comp_prob:
        2.2 (0.6%), b_tok_touch_all: 2.7 (0.7%), b_finish: 0.64 (0.2%),
        tests_pri_0: 333 (84.5%), check_dkim_signature: 0.49 (0.1%),
        check_dkim_adsp: 3.5 (0.9%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.2 (0.6%), tests_pri_500: 8 (1.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: Regression in 5.3 for some FS_USERNS_MOUNT (aka user-namespace-mountable) filesystems
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Fri, Jul 26, 2019 at 07:46:18PM -0500, Eric W. Biederman wrote:
>
>> If someone had bothered to actually look at how I was proposing to clean
>> things up before the new mount api we would already have that.  Sigh.
>> 
>> You should be able to get away with something like this which moves the
>> checks earlier and makes things clearer.  My old patch against the pre
>> new mount api code.
>
> Check your instances of ->permission(); AFAICS in all cases it's (in
> current terms)
> 	return ns_capable(fc->user_ns, CAP_SYS_ADMIN) ? 0 : -EPERM;


Yes.  Because I refactored all of the logic to be in terms of current
before we even get to the filesystem.  The idea is on a per filesystem
basis to know which namespaces for the filesystem will be selected
and to check those.

Since all that version of the patch converts is the old API we know
from only looking at current what needs to be checked.

> In principle I like killing FS_USERNS_MOUNT flag, but when a method
> is always either NULL or exact same function...

Either you are being dramatic or you read the patch much too quickly.

userns_mount_permission covers the common case of FS_USERNS_MOUNT.
Then there are the cases where you need to know how the filesystem is
going to map current into the filesystem that will be mounted.  Those
are: proc_mount_permission, sysfs_mount_permission,
mqueue_mount_permission, cgroup_mount_permission,

So yes I agree the function of interest is always capable in some form,
we just need the filesystem specific logic to check to see if we will
have capable over the filesystem that will be mounted.

I don't doubt that the new mount api has added a few new complexities.

*Shrug*  I have done my best to keep it simple, and to help avoid
breaking changes.   When you never post your patches for public review,
and don't take any feedback it is difficult to give help.

Eric
