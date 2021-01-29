Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01630907C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Jan 2021 00:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhA2XOF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Jan 2021 18:14:05 -0500
Received: from out01.mta.xmission.com ([166.70.13.231]:42448 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhA2XN6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Jan 2021 18:13:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l5cx0-00Emze-6X; Fri, 29 Jan 2021 16:13:15 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l5cwy-002GUC-R0; Fri, 29 Jan 2021 16:13:13 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
        <20210119162204.2081137-3-mszeredi@redhat.com>
        <8735yw8k7a.fsf@x220.int.ebiederm.org>
        <20210128165852.GA20974@mail.hallyn.com>
        <CAJfpegt34fO8tUw8R2_ZxxKHBdBO_-quf+-f3N8aZmS=1oRdvQ@mail.gmail.com>
        <20210129153807.GA1130@mail.hallyn.com>
Date:   Fri, 29 Jan 2021 17:11:53 -0600
In-Reply-To: <20210129153807.GA1130@mail.hallyn.com> (Serge E. Hallyn's
        message of "Fri, 29 Jan 2021 09:38:07 -0600")
Message-ID: <87h7mzs5hi.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l5cwy-002GUC-R0;;;mid=<87h7mzs5hi.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18W1y1AR5d72TwyxxJebrT3ffLS07ppVcc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMNoVowels,
        XMSubLong autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Serge E. Hallyn" <serge@hallyn.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 439 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 14 (3.3%), b_tie_ro: 12 (2.8%), parse: 1.13
        (0.3%), extract_message_metadata: 14 (3.1%), get_uri_detail_list: 2.2
        (0.5%), tests_pri_-1000: 5.0 (1.1%), tests_pri_-950: 1.32 (0.3%),
        tests_pri_-900: 1.17 (0.3%), tests_pri_-90: 174 (39.7%), check_bayes:
        171 (39.0%), b_tokenize: 6 (1.4%), b_tok_get_all: 9 (2.0%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 149 (33.9%), b_finish: 1.40
        (0.3%), tests_pri_0: 214 (48.8%), check_dkim_signature: 0.72 (0.2%),
        check_dkim_adsp: 8 (1.8%), poll_dns_idle: 0.03 (0.0%), tests_pri_10:
        2.3 (0.5%), tests_pri_500: 8 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> On Thu, Jan 28, 2021 at 08:44:26PM +0100, Miklos Szeredi wrote:
>> On Thu, Jan 28, 2021 at 6:09 PM Serge E. Hallyn <serge@hallyn.com> wrote:
>> >
>> > On Tue, Jan 19, 2021 at 07:34:49PM -0600, Eric W. Biederman wrote:
>> > > Miklos Szeredi <mszeredi@redhat.com> writes:
>> > >
>> > > >     if (!rootid_owns_currentns(kroot)) {
>> > > > -           kfree(tmpbuf);
>> > > > -           return -EOPNOTSUPP;
>> > > > +           size = -EOVERFLOW;
>> >
>> > Why this change?  Christian (cc:d) noticed that this is a user visible change.
>> > Without this change, if you are in a userns which has different rootid, the
>> > EOVERFLOW tells vfs_getxattr to vall back to __vfs_getxattr() and so you can
>> > see the v3 capability with its rootid.
>> >
>> > With this change, you instead just get EOVERFLOW.
>> 
>> Why would the user want to see nonsense (in its own userns) rootid and
>> what would it do with it?
>
> They would know that the data is there.

But an error of -EOVERFLOW still indicates data is there.
You just don't get the data because it can not be represented.

>> Please give an example where an untranslatable rootid would make any
>> sense at all to the user.
>
> I may have accidentally, from init_user_ns, as uid 1000, set an
> fscap with rootid 100001 instead of 100000, and wonder why the
> cap is not working in the container where 100000 is root.

Getting -EOVERFLOW when attempting to read the cap from inside
the user namespace will immediately tell you what is wrong. The rootid
does not map.

That is how all the non-mapping situations are handled.  Either
-EOVERFLOW or returning INVALID_UID/the unmapped user id aka nobody.

The existing code is wrong because it returns a completely untranslated
uid, which is completely non-sense.

An argument could be made for returning a rootid of 0xffffffff aka
INVALID_UID in a v3 cap xattr when the rootid can not be mapped.  I
think that is what we do with posix_acls that contain ids that don't
map.  My sense is returning -EOVERFLOW inside the container and
returning the v3 cap xattr outside the container will most quickly get
the problem diagnosed, and will be the most likely to not cause
problems.

If there is a good case for returning a v3 cap with rootid of 0xffffffff
instead of -EOVERFLOW we can do that.  Right now I don't see anything
that would be compelling in either direction.

Eric




