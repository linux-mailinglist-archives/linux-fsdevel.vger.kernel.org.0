Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06F592F38FD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404093AbhALSio (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 13:38:44 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:60528 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392028AbhALSio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:38:44 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kzOYL-004nlM-OM; Tue, 12 Jan 2021 11:38:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1kzOYK-005CSt-IX; Tue, 12 Jan 2021 11:38:01 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org, "Serge E. Hallyn" <serge@hallyn.com>,
        <linux-api@vger.kernel.org>
References: <20201207163255.564116-1-mszeredi@redhat.com>
        <20201207163255.564116-2-mszeredi@redhat.com>
        <87czyoimqz.fsf@x220.int.ebiederm.org>
        <20210111134916.GC1236412@miu.piliscsaba.redhat.com>
        <874kjnm2p2.fsf@x220.int.ebiederm.org>
        <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
Date:   Tue, 12 Jan 2021 12:36:58 -0600
In-Reply-To: <CAJfpegtKMwTZwENX7hrVGUVRWgNTf4Tr_bRxYrPpPAH_D2fH-Q@mail.gmail.com>
        (Miklos Szeredi's message of "Tue, 12 Jan 2021 10:43:05 +0100")
Message-ID: <87bldugfxx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1kzOYK-005CSt-IX;;;mid=<87bldugfxx.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX198By4slrZJIYiPN3b1y747982LQZfcFyE=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_TooManySym_03,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <miklos@szeredi.hu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 612 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (1.4%), b_tie_ro: 7 (1.2%), parse: 1.07 (0.2%),
        extract_message_metadata: 28 (4.6%), get_uri_detail_list: 3.3 (0.5%),
        tests_pri_-1000: 28 (4.5%), tests_pri_-950: 14 (2.3%), tests_pri_-900:
        1.26 (0.2%), tests_pri_-90: 124 (20.2%), check_bayes: 122 (19.9%),
        b_tokenize: 19 (3.1%), b_tok_get_all: 16 (2.6%), b_comp_prob: 4.3
        (0.7%), b_tok_touch_all: 78 (12.7%), b_finish: 1.04 (0.2%),
        tests_pri_0: 393 (64.2%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.6 (0.4%), poll_dns_idle: 0.87 (0.1%), tests_pri_10:
        2.4 (0.4%), tests_pri_500: 9 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 01/10] vfs: move cap_convert_nscap() call into vfs_setxattr()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> writes:

> On Tue, Jan 12, 2021 at 1:15 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>>
>> Miklos Szeredi <miklos@szeredi.hu> writes:
>>
>> > On Fri, Jan 01, 2021 at 11:35:16AM -0600, Eric W. Biederman wrote:
>
>> > For one: a v2 fscap is supposed to be equivalent to a v3 fscap with a rootid of
>> > zero, right?
>>
>> Yes.  This assumes that everything is translated into the uids of the
>> target filesystem.
>>
>> > If so, why does cap_inode_getsecurity() treat them differently (v2 fscap
>> > succeeding unconditionally while v3 one being either converted to v2, rejected
>> > or left as v3 depending on current_user_ns())?
>>
>> As I understand it v2 fscaps have always succeeded unconditionally.  The
>> only case I can see for a v2 fscap might not succeed when read is if the
>> filesystem is outside of the initial user namespace.
>
> Looking again, it's rather confusing.  cap_inode_getsecurity()
> currently handles the following cases:
>
> v1: -> fails with -EINVAL
>
> v2: -> returns unconverted xattr
>
> v3:
>  a) rootid is mapped in the current namespace to non-zero:
>      -> convert rootid
>
>  b) rootid owns the current or ancerstor namespace:
>      -> convert to v2
>
>  c) rootid is not mapped and is not owner:
>      -> return -EOPNOTSUPP -> falls back to unconverted v3
>
> So lets take the example, where a tmpfs is created in a private user
> namespace and one file has a v2 cap and the other an equivalent v3 cap
> with a zero rootid.  This is the result when looking at it from
>
> 1) the namespace of the fs:
> ---------------------------------------
> t = cap_dac_override+eip
> tt = cap_dac_override+eip
>
> 2) the initial namespace:
> ---------------------------------------
> t = cap_dac_override+eip
> tt = cap_dac_override+eip [rootid=1000]
>
> 3) an unrelated namespace:
> ---------------------------------------
> t = cap_dac_override+eip
> tt = cap_dac_override+eip
>
> Note: in this last case getxattr will actually return a v3 cap with
> zero rootid for "tt" which getcap does not display due to being zero.
> I could do a setup with a nested namespaces that better demonstrate
> the confusing nature of this, but I think this also proves the point.

Yes.  There is real confusion on the reading case when the namespaces
do not match.

> At this point userspace simply cannot determine whether the returned
> cap is in any way valid or not.
>
> The following semantics would make a ton more sense, since getting a
> v2 would indicate that rootid is unknown:

> - if cap is v2 convert to v3 with zero rootid
> - after this, check if rootid needs to be translated, if not return v3
> - if yes, try to translate to current ns, if succeeds return translated v3
> - if not mappable, return v2
>
> Hmm?

So there is the basic question do we want to read the raw bytes on disk
or do we want to return something meaningful to the reader.  As the
existing tools use the xattr interface to set/clear fscaps returning
data to user space rather than raw bytes seems the perfered interface.

My ideal semantics would be:

- If current_user_ns() == sb->s_user_ns return the raw data.

  I don't know how to implement this first scenario while permitting
  stacked filesystems.
  
- Calculate the cpu_vfs_cap_data as get_vfs_caps_from_disk does.
  That gives the meaning of the xattr.

- If "from_kuid(current_userns(), krootid) == 0" return a v2 cap.

- If "rootid_owns_currentns()" return a v2 cap.

- Else return an error.  Probably a permission error.

  The fscap simply can not make sense to the user if the rootid does not
  map.  Return a v2 cap would imply that the caps are present on the
  executable (in the current context) which they are not.


>> > Anyway, here's a patch that I think fixes getxattr() layering for
>> > security.capability.  Does basically what you suggested.  Slight change of
>> > semantics vs. v1 caps, not sure if that is still needed, getxattr()/setxattr()
>> > hasn't worked for these since the introduction of v3 in 4.14.
>> > Untested.
>>
>> Taking a look.  The goal of change how these operate is to make it so
>> that layered filesystems can just pass through the data if they don't
>> want to change anything (even with the user namespaces of the
>> filesystems in question are different).
>>
>> Feedback on the code below:
>> - cap_get should be in inode_operations like get_acl and set_acl.
>
> So it's not clear to me why xattr ops are per-sb and acl ops are per-inode.

I don't know why either.  What I do see is everything except
inode->i_sb->s_xattr (the list of xattr handlers) is in
inode_operations.

Especially permission.  So just for consistency I would keep everything
in the inode_operations.

>> - cap_get should return a cpu_vfs_cap_data.
>>
>>   Which means that only make_kuid is needed when reading the cap from
>>   disk.
>
> It also means translating the cap bits back and forth between disk and
> cpu endian.  Not a big deal, but...

For the very rare case of userspace reading and writing them.

For the common case of actually using them it should be optimal, and
it allows for non-standard implementations.  Anything where someone gets
clever we want the bits to be in cpu format to make mistakes harder.

>>   Which means that except for the rootid_owns_currentns check (which
>>   needs to happen elsewhere) default_cap_get should be today's
>>   get_vfs_cap_from_disk.
>
> That's true.   So what's the deal with v1 caps?  Support was silently
> dropped for getxattr/setxattr but remained in get_vfs_caps_from_disk()
> (I guess to not break legacy disk images), but maybe it's time to
> deprecate v1 caps completely?

I really don't remember.  When I look I see they appear to be a subset
of v2 caps.  I would have to look to see if they bits might have a
different meaning.

>> - With the introduction of cap_get I believe commoncap should stop
>>   implementing the security_inode_getsecurity hook, and rather have
>>   getxattr observe is the file capability xatter and call the new
>>   vfs_cap_get then translate to a v2 or v3 cap as appropriate when
>>   returning the cap to userspace.
>
> Confused.  vfs_cap_get() is the one the layered filesystem will
> recurse with, so it must not translate the cap.   The one to do that
> would be __vfs_getxattr(), right?

So there are two layers that I am worrying about.

The layer dealing with fscaps knowing they are fscaps.  That is
vfs_cap_get and friends.

Then there is the layer dealing with xattrs which should also handle
fscaps.  So that the xattr layer stacks properly I believe we need to
completely bypass vfs_getxattr and friends and at the edge of userspace
before there is any possibility of interception call vfs_cap_get and
translate the result to a form userspace can consume.

With xattrs and caps we are in part of the kernel that hasn't seen a lot
of attention and so is not the best factored.  So I am proposing we fix
up the abstractions to make it easier to implement stacked fscap support.

Eric
