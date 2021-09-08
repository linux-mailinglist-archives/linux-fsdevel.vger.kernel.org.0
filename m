Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA10403B65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348814AbhIHOWi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Sep 2021 10:22:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:42616 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbhIHOWh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Sep 2021 10:22:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51]:37094)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mNyS5-002ZZZ-SF; Wed, 08 Sep 2021 08:21:25 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95]:42036 helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1mNyS4-00BBdJ-GW; Wed, 08 Sep 2021 08:21:25 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "Fields\, Bruce" <bfields@redhat.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
        <CAHc6FU4foW+9ZwTRis3DXSJSMAvdb4jXcq7EFFArYgX7FQ1QYg@mail.gmail.com>
        <YTYoEDT+YOtCHXW0@work-vm>
        <CAJfpegvbkmdneMxMjYMuNM4+RmWT8S7gaTiDzaq+TCzb0UrQrw@mail.gmail.com>
        <YTfcT1JUactPhwSA@redhat.com>
        <CAJfpegumUMsQ1Zk4MjnSXhrcnX_RJfM5LJ2oL6W3Um_wFNPRFQ@mail.gmail.com>
Date:   Wed, 08 Sep 2021 09:20:32 -0500
In-Reply-To: <CAJfpegumUMsQ1Zk4MjnSXhrcnX_RJfM5LJ2oL6W3Um_wFNPRFQ@mail.gmail.com>
        (Miklos Szeredi's message of "Wed, 8 Sep 2021 09:37:17 +0200")
Message-ID: <87lf47tahb.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1mNyS4-00BBdJ-GW;;;mid=<87lf47tahb.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+SrgV0tKVopvxRdxK+6dEdGv6cwF2N0VI=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 550 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.7%), parse: 1.02 (0.2%),
         extract_message_metadata: 13 (2.3%), get_uri_detail_list: 1.62 (0.3%),
         tests_pri_-1000: 11 (2.0%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.14 (0.2%), tests_pri_-90: 154 (27.9%), check_bayes:
        151 (27.5%), b_tokenize: 9 (1.6%), b_tok_get_all: 8 (1.5%),
        b_comp_prob: 2.9 (0.5%), b_tok_touch_all: 127 (23.1%), b_finish: 0.98
        (0.2%), tests_pri_0: 346 (62.9%), check_dkim_signature: 0.63 (0.1%),
        check_dkim_adsp: 2.3 (0.4%), poll_dns_idle: 0.52 (0.1%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 0/1] Relax restrictions on user.* xattr
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Tue, 7 Sept 2021 at 23:40, Vivek Goyal <vgoyal@redhat.com> wrote:
>>
>> On Mon, Sep 06, 2021 at 04:56:44PM +0200, Miklos Szeredi wrote:
>> > On Mon, 6 Sept 2021 at 16:39, Dr. David Alan Gilbert
>> > <dgilbert@redhat.com> wrote:
>> >
>> > > IMHO the real problem here is that the user/trusted/system/security
>> > > 'namespaces' are arbitrary hacks rather than a proper namespacing
>> > > mechanism that allows you to create new (nested) namespaces and associate
>> > > permissions with each one.
>> >
>> > Indeed.
>> >
>> > This is what Eric Biederman suggested at some point for supporting
>> > trusted xattrs within a user namespace:
>> >
>> > | For trusted xattrs I think it makes sense in principle.   The namespace
>> > | would probably become something like "trusted<ns-root-uid>.".
>> >
>> > Theory sounds simple enough.  Anyone interested in looking at the details?
>>
>> So this namespaced trusted.* xattr domain will basically avoid the need
>> to have CAP_SYS_ADMIN in init_user_ns, IIUC.  I guess this is better
>> than giving CAP_SYS_ADMIN in init_user_ns.
>
> That's the objective, yes.  I think the trick is getting filesystems
> to store yet another xattr type.

Using the uid of the root user of a user namespace is probably the best
idea we have so far for identifying a user namespace in persistent
on-disk meta-data.  We ran into a little trouble using that idea
for file capabilities.

The key problem was there are corner cases where some nested user
namespaces have the same root user id as their parent namespaces.  This
has the potential to allow privilege escalation if the creator of the
user namespace does not have sufficient capabilities.

The solution we adopted can be seen in db2e718a4798 ("capabilities:
require CAP_SETFCAP to map uid 0").

That solution is basically not allowing the creation of user namespaces
that could have problems.  I think use trusted xattrs this way the code
would need to treat CAP_SYS_ADMIN the same way it currently treats
CAP_SETFCAP.

Eric
