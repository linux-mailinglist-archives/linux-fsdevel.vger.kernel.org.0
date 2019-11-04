Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2DAEF14C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 00:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbfKDXl4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Nov 2019 18:41:56 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:58128 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729817AbfKDXl4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Nov 2019 18:41:56 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iRlys-0003Z2-Cb; Mon, 04 Nov 2019 16:41:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1iRlyr-0000zR-Ha; Mon, 04 Nov 2019 16:41:54 -0700
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
        <87h83jejei.fsf@x220.int.ebiederm.org>
        <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com>
Date:   Mon, 04 Nov 2019 17:41:40 -0600
In-Reply-To: <eb2da7e4-23ff-597a-08e1-e0555d490f6f@gmail.com> (Topi
        Miettinen's message of "Mon, 4 Nov 2019 19:58:55 +0200")
Message-ID: <87tv7jciq3.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1iRlyr-0000zR-Ha;;;mid=<87tv7jciq3.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18AaWiq4pZEpAPJi78BflGOh+DMoEBcnOg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3549]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Topi Miettinen <toiwoton@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 476 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.1 (0.7%), b_tie_ro: 2.2 (0.5%), parse: 0.93
        (0.2%), extract_message_metadata: 4.3 (0.9%), get_uri_detail_list: 2.2
        (0.5%), tests_pri_-1000: 3.6 (0.8%), tests_pri_-950: 1.27 (0.3%),
        tests_pri_-900: 1.08 (0.2%), tests_pri_-90: 26 (5.4%), check_bayes: 24
        (5.0%), b_tokenize: 8 (1.7%), b_tok_get_all: 9 (1.8%), b_comp_prob:
        3.0 (0.6%), b_tok_touch_all: 2.4 (0.5%), b_finish: 0.49 (0.1%),
        tests_pri_0: 420 (88.2%), check_dkim_signature: 0.56 (0.1%),
        check_dkim_adsp: 2.2 (0.5%), poll_dns_idle: 0.68 (0.1%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 6 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] Allow restricting permissions in /proc/sys
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Topi Miettinen <toiwoton@gmail.com> writes:

> On 4.11.2019 17.44, Eric W. Biederman wrote:
>> Topi Miettinen <toiwoton@gmail.com> writes:
>>
>>> On 3.11.2019 20.50, Eric W. Biederman wrote:
>>>> Topi Miettinen <toiwoton@gmail.com> writes:
>>>>
>>>>> Several items in /proc/sys need not be accessible to unprivileged
>>>>> tasks. Let the system administrator change the permissions, but only
>>>>> to more restrictive modes than what the sysctl tables allow.
>>>>
>>>> This looks quite buggy.  You neither update table->mode nor
>>>> do you ever read from table->mode to initialize the inode.
>>>> I am missing something in my quick reading of your patch?
>>>
>>> inode->i_mode gets initialized in proc_sys_make_inode().
>>>
>>> I didn't want to touch the table, so that the original permissions can
>>> be used to restrict the changes made. In case the restrictions are
>>> removed as suggested by Theodore Ts'o, table->mode could be
>>> changed. Otherwise I'd rather add a new field to store the current
>>> mode and the mode field can remain for reference. As the original
>>> author of the code from 2007, would you let the administrator to
>>> chmod/chown the items in /proc/sys without restrictions (e.g. 0400 ->
>>> 0777)?
>>
>> At an architectural level I think we need to do this carefully and have
>> a compelling reason.  The code has survived nearly the entire life of
>> linux without this capability.
>
> I'd be happy with only allowing restrictions to access for
> now. Perhaps later with more analysis, also relaxing changes and maybe
> UID/GID changes can be allowed.

Let's find the use case where someone cares before we think about that.

>> I think right now the common solution is to mount another file over the
>> file you are trying to hide/limit.  Changing the permissions might be
>> better but that is not at all clear.
>>
>> Do you have specific examples of the cases where you would like to
>> change the permissions?
>
> Unprivileged applications typically do not need to access most items
> in /proc/sys, so I'd like to gradually find out which are needed. So
> far I've seen no problems with 0500 mode for directories abi, crypto,
> debug, dev, fs, user or vm.

But if there is no problem in letting everyone access the information
why reduce the permissions?

> I'm also using systemd's InaccessiblePaths to limit access (which
> mounts an inaccessible directory over the path), but that's a bit too
> big hammer. For example there are over 100 files in /proc/sys/kernel,
> perhaps there will be issues when creating a mount for each, and that
> multiplied by a number of services.

My sense is that if there is any kind of compelling reason to make
world-readable values not world-readable, and it doesn't break anything
(except malicious applications) than a kernel patch is probably the way
to go.

Policy knobs like this on proc tend to break in normal maintenance
because they are not used enough so I am not a big fan of adding policy
knobs just because we can.

> I see no problems by using Firejail (which uses PID namespacing) with
> v2, the permissions in /proc/sys are the same as outside the
> namespace.

Thank you for testing.

Eric
