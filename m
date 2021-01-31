Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3740309EEB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Jan 2021 21:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbhAaU3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 31 Jan 2021 15:29:10 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:44520 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhAaU1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 31 Jan 2021 15:27:32 -0500
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l6HGT-009MEC-Oc; Sun, 31 Jan 2021 11:16:01 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1l6HGS-007la5-Nm; Sun, 31 Jan 2021 11:16:01 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <20210119162204.2081137-1-mszeredi@redhat.com>
        <20210119162204.2081137-3-mszeredi@redhat.com>
        <8735yw8k7a.fsf@x220.int.ebiederm.org>
        <20210128165852.GA20974@mail.hallyn.com>
        <87o8h8x1a6.fsf@x220.int.ebiederm.org>
        <20210129154839.GC1130@mail.hallyn.com>
        <87im7fuzdq.fsf@x220.int.ebiederm.org>
        <20210130020652.GB7163@mail.hallyn.com>
Date:   Sun, 31 Jan 2021 12:14:39 -0600
In-Reply-To: <20210130020652.GB7163@mail.hallyn.com> (Serge E. Hallyn's
        message of "Fri, 29 Jan 2021 20:06:52 -0600")
Message-ID: <87h7mxotww.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1l6HGS-007la5-Nm;;;mid=<87h7mxotww.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+rdqZ6i33bsph+88xrIBEvUyfFA5QciIc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
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
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;"Serge E. Hallyn" <serge@hallyn.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 464 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (2.3%), b_tie_ro: 9 (2.0%), parse: 0.91 (0.2%),
         extract_message_metadata: 13 (2.7%), get_uri_detail_list: 2.4 (0.5%),
        tests_pri_-1000: 4.5 (1.0%), tests_pri_-950: 1.24 (0.3%),
        tests_pri_-900: 1.01 (0.2%), tests_pri_-90: 92 (19.8%), check_bayes:
        90 (19.4%), b_tokenize: 8 (1.8%), b_tok_get_all: 8 (1.8%),
        b_comp_prob: 3.0 (0.7%), b_tok_touch_all: 67 (14.4%), b_finish: 0.97
        (0.2%), tests_pri_0: 329 (71.0%), check_dkim_signature: 0.54 (0.1%),
        check_dkim_adsp: 2.0 (0.4%), poll_dns_idle: 0.48 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] security.capability: fix conversions on getxattr
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Serge E. Hallyn" <serge@hallyn.com> writes:

> On Fri, Jan 29, 2021 at 04:55:29PM -0600, Eric W. Biederman wrote:
>> "Serge E. Hallyn" <serge@hallyn.com> writes:
>> 
>> > On Thu, Jan 28, 2021 at 02:19:13PM -0600, Eric W. Biederman wrote:
>> >> "Serge E. Hallyn" <serge@hallyn.com> writes:
>> >> 
>> >> > On Tue, Jan 19, 2021 at 07:34:49PM -0600, Eric W. Biederman wrote:
>> >> >> Miklos Szeredi <mszeredi@redhat.com> writes:
>> >> >> 
>> >> >> > If a capability is stored on disk in v2 format cap_inode_getsecurity() will
>> >> >> > currently return in v2 format unconditionally.
>> >> >> >
>> >> >> > This is wrong: v2 cap should be equivalent to a v3 cap with zero rootid,
>> >> >> > and so the same conversions performed on it.
>> >> >> >
>> >> >> > If the rootid cannot be mapped v3 is returned unconverted.  Fix this so
>> >> >> > that both v2 and v3 return -EOVERFLOW if the rootid (or the owner of the fs
>> >> >> > user namespace in case of v2) cannot be mapped in the current user
>> >> >> > namespace.
>> >> >> 
>> >> >> This looks like a good cleanup.
>> >> >
>> >> > Sorry, I'm not following.  Why is this a good cleanup?  Why should
>> >> > the xattr be shown as faked v3 in this case?
>> >> 
>> >> If the reader is in &init_user_ns.  If the filesystem was mounted in a
>> >> user namespace.   Then the reader looses the information that the
>> >
>> > Can you be more precise about "filesystem was mounted in a user namespace"?
>> > Is this a FUSE thing, the fs is marked as being mounted in a non-init userns?
>> > If that's a possible case, then yes that must be represented as v3.  Using
>> > is_v2header() may be the simpler way to check for that, but the more accurate
>> > check would be "is it v2 header and mounted by init_user_ns".
>> 
>> I think the filesystems current relevant are fuse,overlayfs,ramfs,tmpfs.
>> 
>> > Basically yes, in as many cases as possible we want to just give a v2
>> > cap because more userspace knows what to do with that, but a non-init-userns
>> > mounted fs which provides a v2 fscap should have it represented as v3 cap
>> > with rootid being the kuid that owns the userns.
>> 
>> That is the case we that is being fixed in the patch.
>> 
>> > Or am I still thinking wrongly?  Wouldn't be entirely surprised :)
>> 
>> No you got it.
>
> So then can we make faking a v3 gated on whether
>     sb->s_user_ns != &init_user_ns ?

Sort of.

What Miklos's patch implements is always treating a v2 cap xattr on disk
as v3 internally.

>  	if (is_v2header((size_t) ret, cap)) {
>  		root = 0;
>  	} else if (is_v3header((size_t) ret, cap)) {
>  		nscap = (struct vfs_ns_cap_data *) tmpbuf;
>  		root = le32_to_cpu(nscap->rootid);
>  	} else {
>  		size = -EINVAL;
>  		goto out_free;
>  	}

Then v3 is returned if:
>  	/* If the root kuid maps to a valid uid in current ns, then return
>  	 * this as a nscap. */
>  	mappedroot = from_kuid(current_user_ns(), kroot);
>  	if (mappedroot != (uid_t)-1 && mappedroot != (uid_t)0) {

After that we verify that the fs capability can be seen by the caller
as a v2 cap xattr with:

> >  	if (!rootid_owns_currentns(kroot)) {
> > 		size = -EOVERFLOW;
> > 		goto out_free;

Anything that passes that test and does not encounter a memory
allocation error is returned as a v2.

...

Which in practice does mean that if sb->s_user_ns != &init_user_ns, 
then mappedroot != 0, and is returned as a v3.

The rest of the logic takes care of all of the other crazy silly
combinations.  Like a user namespace that identity maps uid 0,
and then mounts a filesystem.

Eric



