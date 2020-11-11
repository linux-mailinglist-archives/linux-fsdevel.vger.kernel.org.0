Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBD32AEA48
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 08:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgKKHm5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 02:42:57 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:52832 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgKKHm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:42:56 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kckmM-003IQR-Fi; Wed, 11 Nov 2020 00:42:54 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1kckmL-00084a-Bq; Wed, 11 Nov 2020 00:42:54 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alexey Gladkov <legion@kernel.org>
References: <1e796f9e008fb78fb96358ff74f39bd4865a7c88.1604926010.git.gladkov.alexey@gmail.com>
        <CAJfpegua_ahmNa4p0me6R10wtcPpQVKNiKQOVKjuNW67RHFOOA@mail.gmail.com>
        <87v9ee2wer.fsf@x220.int.ebiederm.org>
        <CAJfpegugWh7r=h9T+fbb7FKrz2JpWtA==ck2iYq1DYJ25_-WyA@mail.gmail.com>
Date:   Wed, 11 Nov 2020 01:42:43 -0600
In-Reply-To: <CAJfpegugWh7r=h9T+fbb7FKrz2JpWtA==ck2iYq1DYJ25_-WyA@mail.gmail.com>
        (Miklos Szeredi's message of "Mon, 9 Nov 2020 21:24:13 +0100")
Message-ID: <87d00ks5jg.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kckmL-00084a-Bq;;;mid=<87d00ks5jg.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18F4elmEH4+n1AOxCJe/UXOuE16/PqSCfY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 729 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (1.6%), b_tie_ro: 10 (1.4%), parse: 1.27
        (0.2%), extract_message_metadata: 19 (2.6%), get_uri_detail_list: 4.7
        (0.6%), tests_pri_-1000: 14 (1.9%), tests_pri_-950: 1.25 (0.2%),
        tests_pri_-900: 0.98 (0.1%), tests_pri_-90: 72 (9.9%), check_bayes: 70
        (9.6%), b_tokenize: 12 (1.6%), b_tok_get_all: 12 (1.7%), b_comp_prob:
        4.1 (0.6%), b_tok_touch_all: 39 (5.3%), b_finish: 0.93 (0.1%),
        tests_pri_0: 437 (59.9%), check_dkim_signature: 0.57 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 158 (21.7%), tests_pri_10:
        2.9 (0.4%), tests_pri_500: 166 (22.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RESEND PATCH v3] fuse: Abort waiting for a response if the daemon receives a fatal signal
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Mon, Nov 9, 2020 at 7:54 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Mon, Nov 9, 2020 at 1:48 PM Alexey Gladkov <gladkov.alexey@gmail.com> wrote:
>> >>
>> >> This patch removes one kind of the deadlocks inside the fuse daemon. The
>> >> problem appear when the fuse daemon itself makes a file operation on its
>> >> filesystem and receives a fatal signal.
>> >>
>> >> This deadlock can be interrupted via fusectl filesystem. But if you have
>> >> many fuse mountpoints, it will be difficult to figure out which
>> >> connection to break.
>> >>
>> >> This patch aborts the connection if the fuse server receives a fatal
>> >> signal.
>> >
>> > The patch itself might be acceptable, but I have some questions.
>> >
>> > To logic of this patch says:
>> >
>> > "If a task having the fuse device open in it's fd table receives
>> > SIGKILL (and filesystem was initially mounted in a non-init user
>> > namespace), then abort the filesystem operation"
>> >
>> > You just say "server" instead of "task having the fuse device open in
>> > it's fd table" which is sloppy to say the least.  It might also lead
>> > to regressions, although I agree that it's unlikely.
>> >
>> > Also how is this solving any security issue?   Just create the request
>> > loop using two fuse filesystems and the deadlock avoidance has just
>> > been circumvented.   So AFAICS "selling" this as a CVE fix is not
>> > appropriate.
>>
>> The original report came in with a CVE on it.  So referencing that CVE
>> seems reasonable.  Even if the issue isn't particularly serious.  It is
>> very annoying not to be able to kill processes with SIGKILL or the OOM
>> killer.
>>
>> You have a good point about the looping issue.  I wonder if there is a
>> way to enhance this comparatively simple approach to prevent the more
>> complex scenario you mention.
>
> Let's take a concrete example:
>
> - task A is "server" for fuse fs a
> - task B is "server" for fuse fs b
> - task C: chmod(/a/x, ...)
> - task A: read UNLINK request
> - task A: chmod(/b/x, ...)
> - task B: read UNLINK request
> - task B: chmod (/a/x, ...)
>
> Now B is blocking on i_mutex on x , A is waiting for reply from B, C
> is holding i_mutex on x and waiting for reply from A.
>
> At this point B is truly uninterruptible (and I'm not betting large
> sums on Al accepting killable VFS locks patches), so killing B is out.
>
> Killing A with this patch does nothing, since A does not have b's dev
> fd in its fdtable.
>
> Killing C again does nothing, since it has no fuse dev fd at all.
>
>> Does tweaking the code to close every connection represented by a fuse
>> file descriptor after a SIGKILL has been delevered create any problems?
>
> In the above example are you suggesting that SIGKILL on A would abort
> "a" from fs b's code?   Yeah, that would work, I guess.  Poking into
> another instance this way sounds pretty horrid, though.

Yes.  That is what I am suggesting.

Layering purity it does not have.  It is also fragile as it only
handles interactions between fuse instances.

The advantage is that it is a very small amount of code.  I think there
is enough care to get a small change like that in.  (With a big fat
comment describing why it is imperfect).  I don't know if there is
enough care to get the general solution (you describe below) implemented
and merged in any kind of timely manner.

>> > What's the reason for making this user-ns only?  If we drop the
>> > security aspect, then I don't see any reason not to do this
>> > unconditionally.
>>
>>
>> > Also note, there's a proper solution for making fuse requests always
>> > killable, and that is to introduce a shadow locking that ensures
>> > correct fs operation in the face of requests that have returned and
>> > released their respective VFS locks.   Now this would be a much more
>> > complex solution, but also a much more correct one, not having issues
>> > with correctly defining what a server is (which is not a solvable
>> > problem).
>>
>> Is this the solution that was removed at some point from fuse,
>> or are you talking about something else?
>>
>> I think you are talking about adding a set of fuse specific locks
>> so fuse does not need to rely on the vfs locks.  I don't quite have
>> enough insight to see that bigger problem so if you can expand in more
>> detail I would appreciate it.
>
> Okay, so the problem with making the wait_event() at the end of
> request_wait_answer() killable is that it would allow compromising the
> server's integrity by unlocking the VFS level lock (which protects the
> fs) while the server hasn't yet finished the request.
>
> The way this would be solvable is to add a fuse level lock for each
> VFS level lock.   That lock would be taken before the request is sent
> to userspace and would be released when the answer is received.
> Normally there would be zero contention on these shadow locks, but if
> a request is forcibly killed, then the VFS lock is released and the
> shadow lock now protects the filesystem.
>
> This wouldn't solve the case where a fuse fs is deadlocked on a VFS
> lock (e.g. task B), but would allow tasks blocked directly on a fuse
> filesystem to be killed (e.g. task A or C, both of which would unwind
> the deadlock).

Are we just talking the inode lock here?

I am trying to figure out if this is a straight forward change.
Or if it will take a fair amount of work.

If the change is just wordy we can probably do the good version and call
fuse well and truly fixed.  But I don't currently see the problem well
enough to know what the good change would look like even on a single
code path.

Eric

