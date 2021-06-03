Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F6339AD6A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 00:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFCWEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 18:04:38 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39304 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 18:04:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lovQR-009J4M-1W; Thu, 03 Jun 2021 16:02:51 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=email.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lovQB-0016WB-Cw; Thu, 03 Jun 2021 16:02:50 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Ian Kent <raven@themaw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>, Eric Sandeen <sandeen@sandeen.net>,
        Fox Chen <foxhlchen@gmail.com>,
        Brice Goglin <brice.goglin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162218354775.34379.5629941272050849549.stgit@web.messagingengine.com>
        <162218364554.34379.636306635794792903.stgit@web.messagingengine.com>
        <87czt2q2pl.fsf@disp2133>
        <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
Date:   Thu, 03 Jun 2021 17:02:28 -0500
In-Reply-To: <CAJfpegsVxoL8WgQa7hFXAg4RBbA-suaeo5pZ5EE7HDpL0rT03A@mail.gmail.com>
        (Miklos Szeredi's message of "Thu, 3 Jun 2021 20:06:38 +0200")
Message-ID: <87y2bqli8b.fsf@disp2133>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lovQB-0016WB-Cw;;;mid=<87y2bqli8b.fsf@disp2133>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+G9lB5nC8jUvCdCdERpz90oQIIf4sP1Xk=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15049 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.1%), b_tie_ro: 9 (0.1%), parse: 0.97 (0.0%),
         extract_message_metadata: 19 (0.1%), get_uri_detail_list: 2.3 (0.0%),
        tests_pri_-1000: 3.2 (0.0%), tests_pri_-950: 1.23 (0.0%),
        tests_pri_-900: 1.03 (0.0%), tests_pri_-90: 144 (1.0%), check_bayes:
        142 (0.9%), b_tokenize: 9 (0.1%), b_tok_get_all: 22 (0.1%),
        b_comp_prob: 2.8 (0.0%), b_tok_touch_all: 104 (0.7%), b_finish: 1.10
        (0.0%), tests_pri_0: 7441 (49.4%), check_dkim_signature: 0.86 (0.0%),
        check_dkim_adsp: 6008 (39.9%), poll_dns_idle: 13411 (89.1%),
        tests_pri_10: 2.4 (0.0%), tests_pri_500: 7424 (49.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [REPOST PATCH v4 2/5] kernfs: use VFS negative dentry caching
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Thu, 3 Jun 2021 at 19:26, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Ian Kent <raven@themaw.net> writes:
>>
>> > If there are many lookups for non-existent paths these negative lookups
>> > can lead to a lot of overhead during path walks.
>> >
>> > The VFS allows dentries to be created as negative and hashed, and caches
>> > them so they can be used to reduce the fairly high overhead alloc/free
>> > cycle that occurs during these lookups.
>> >
>> > Signed-off-by: Ian Kent <raven@themaw.net>
>> > ---
>> >  fs/kernfs/dir.c |   55 +++++++++++++++++++++++++++++++++----------------------
>> >  1 file changed, 33 insertions(+), 22 deletions(-)
>> >
>> > diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
>> > index 4c69e2af82dac..5151c712f06f5 100644
>> > --- a/fs/kernfs/dir.c
>> > +++ b/fs/kernfs/dir.c
>> > @@ -1037,12 +1037,33 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
>> >       if (flags & LOOKUP_RCU)
>> >               return -ECHILD;
>> >
>> > -     /* Always perform fresh lookup for negatives */
>> > -     if (d_really_is_negative(dentry))
>> > -             goto out_bad_unlocked;
>> > +     mutex_lock(&kernfs_mutex);
>> >
>> >       kn = kernfs_dentry_node(dentry);
>> > -     mutex_lock(&kernfs_mutex);
>>
>> Why bring kernfs_dentry_node inside the mutex?
>>
>> The inode lock of the parent should protect negative to positive
>> transitions not the kernfs_mutex.  So moving the code inside
>> the mutex looks unnecessary and confusing.
>
> Except that d_revalidate() may or may not be called with parent lock
> held.

I grant that this works because kernfs_io_lookup today holds
kernfs_mutex over d_splice_alias.

The problem is that the kernfs_mutex only should be protecting the
kernfs data structures not the vfs data structures.

Reading through the code history that looks like a hold over from when
sysfs lived in the dcache before it was reimplemented as a distributed
file system.  So it was probably a complete over sight and something
that did not matter.

The big problem is that if the code starts depending upon the
kernfs_mutex (or the kernfs_rwsem) to provide semantics the rest of the
filesystems does not the code will diverge from the rest of the
filesystems and maintenance will become much more difficult.

Diverging from other filesystems and becoming a maintenance pain has
already been seen once in the life of sysfs and I don't think we want to
go back there.

Further extending the scope of lock, when the problem is that the
locking is causing problems seems like the opposite of the direction we
want the code to grow.

I really suspect all we want kernfs_dop_revalidate doing for negative
dentries is something as simple as comparing the timestamp of the
negative dentry to the timestamp of the parent dentry, and if the
timestamp has changed perform the lookup.  That is roughly what
nfs does today with negative dentries.

The dentry cache will always lag the kernfs_node data structures, and
that is fundamental.  We should take advantage of that to make the code
as simple and as fast as we can not to perform lots of work that creates
overhead.

Plus the kernfs data structures should not change much so I expect
there will be effectively 0 penalty in always performing the lookup of a
negative dentry when the directory itself has changed.

Eric
