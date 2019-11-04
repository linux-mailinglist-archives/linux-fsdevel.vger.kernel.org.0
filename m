Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1579DEE419
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2019 16:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbfKDPoU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 10:44:20 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:58238 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbfKDPoT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 10:44:19 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iReWg-0001fq-Dd; Mon, 04 Nov 2019 08:44:18 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iReWf-000835-Ge; Mon, 04 Nov 2019 08:44:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list\:FILESYSTEMS \(VFS and infrastructure\)" 
        <linux-fsdevel@vger.kernel.org>
References: <74a91362-247c-c749-5200-7bdce704ed9e@gmail.com>
        <87d0e8g5f4.fsf@x220.int.ebiederm.org>
        <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com>
Date:   Mon, 04 Nov 2019 09:44:05 -0600
In-Reply-To: <f272bdd3-526d-6737-c906-143d5e5fc478@gmail.com> (Topi
        Miettinen's message of "Sun, 3 Nov 2019 21:38:50 +0200")
Message-ID: <87h83jejei.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iReWf-000835-Ge;;;mid=<87h83jejei.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/SMoGN16q2hVm978SNtdL3kX2YwA8k1Q=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4946]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Topi Miettinen <toiwoton@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 487 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.6 (0.9%), b_tie_ro: 3.3 (0.7%), parse: 1.08
        (0.2%), extract_message_metadata: 4.3 (0.9%), get_uri_detail_list:
        1.84 (0.4%), tests_pri_-1000: 3.9 (0.8%), tests_pri_-950: 1.62 (0.3%),
        tests_pri_-900: 1.43 (0.3%), tests_pri_-90: 25 (5.1%), check_bayes: 23
        (4.7%), b_tokenize: 5 (1.1%), b_tok_get_all: 8 (1.7%), b_comp_prob:
        2.8 (0.6%), b_tok_touch_all: 3.3 (0.7%), b_finish: 0.85 (0.2%),
        tests_pri_0: 428 (88.0%), check_dkim_signature: 0.45 (0.1%),
        check_dkim_adsp: 2.7 (0.6%), poll_dns_idle: 1.11 (0.2%), tests_pri_10:
        2.2 (0.5%), tests_pri_500: 6 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> On 3.11.2019 20.50, Eric W. Biederman wrote:
>> Topi Miettinen <toiwoton@gmail.com> writes:
>>
>>> Several items in /proc/sys need not be accessible to unprivileged
>>> tasks. Let the system administrator change the permissions, but only
>>> to more restrictive modes than what the sysctl tables allow.
>>
>> This looks quite buggy.  You neither update table->mode nor
>> do you ever read from table->mode to initialize the inode.
>> I am missing something in my quick reading of your patch?
>
> inode->i_mode gets initialized in proc_sys_make_inode().
>
> I didn't want to touch the table, so that the original permissions can
> be used to restrict the changes made. In case the restrictions are
> removed as suggested by Theodore Ts'o, table->mode could be
> changed. Otherwise I'd rather add a new field to store the current
> mode and the mode field can remain for reference. As the original
> author of the code from 2007, would you let the administrator to
> chmod/chown the items in /proc/sys without restrictions (e.g. 0400 ->
> 0777)?

At an architectural level I think we need to do this carefully and have
a compelling reason.  The code has survived nearly the entire life of
linux without this capability.

I think right now the common solution is to mount another file over the
file you are trying to hide/limit.  Changing the permissions might be
better but that is not at all clear.

Do you have specific examples of the cases where you would like to
change the permissions?

>> The not updating table->mode almost certainly means that as soon as the
>> cached inode is invalidated the mode changes will disappear.  Not to
>> mention they will fail to propogate between  different instances of
>> proc.
>>
>> Loosing all of your changes at cache invalidation seems to make this a
>> useless feature.
>
> At least different proc instances seem to work just fine here (they
> show the same changes), but I suppose you are right about cache
> invalidation.

It is going to take the creation of a pid namespace to see different
proc instances.  All mounts of the proc within the same pid_namespace
return the same instance.

Eric

