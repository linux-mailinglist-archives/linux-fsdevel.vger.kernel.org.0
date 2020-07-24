Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D326D22CEB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Jul 2020 21:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgGXTe0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Jul 2020 15:34:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38102 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgGXTe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:34:26 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jz3SY-0004V4-Rg; Fri, 24 Jul 2020 13:34:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jz3SX-0001HJ-4f; Fri, 24 Jul 2020 13:34:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Serge Hallyn <serge@hallyn.com>,
        Andrei Vagin <avagin@gmail.com>,
        =?utf-8?Q?=C3=81kos?= Uzonyi <uzonyi.akos@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>
References: <20200724001248.GC25522@altlinux.org>
        <CAK8P3a0JM8dytW6C8P9HoPcGksg0d5JCut1yT7JzBcUCAm-WcQ@mail.gmail.com>
        <20200724102848.GA1654@altlinux.org>
Date:   Fri, 24 Jul 2020 14:31:19 -0500
In-Reply-To: <20200724102848.GA1654@altlinux.org> (Dmitry V. Levin's message
        of "Fri, 24 Jul 2020 13:28:49 +0300")
Message-ID: <878sf8ogl4.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1jz3SX-0001HJ-4f;;;mid=<878sf8ogl4.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/cDxh9ZbG5MfX7w6erKvG5kP72UnbZSUY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong,
        XM_B_Unicode autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4996]
        *  0.7 XMSubLong Long Subject
        *  0.0 XM_B_Unicode BODY: Testing for specific types of unicode
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1241 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 11 (0.9%), b_tie_ro: 9 (0.8%), parse: 6 (0.5%),
        extract_message_metadata: 16 (1.3%), get_uri_detail_list: 2.5 (0.2%),
        tests_pri_-1000: 6 (0.5%), tests_pri_-950: 1.91 (0.2%),
        tests_pri_-900: 1.19 (0.1%), tests_pri_-90: 396 (31.9%), check_bayes:
        394 (31.7%), b_tokenize: 10 (0.8%), b_tok_get_all: 39 (3.2%),
        b_comp_prob: 3.8 (0.3%), b_tok_touch_all: 337 (27.1%), b_finish: 1.23
        (0.1%), tests_pri_0: 372 (30.0%), check_dkim_signature: 0.73 (0.1%),
        check_dkim_adsp: 2.4 (0.2%), poll_dns_idle: 407 (32.8%), tests_pri_10:
        2.1 (0.2%), tests_pri_500: 423 (34.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs/nsfs.c: fix ioctl support of compat processes
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Michael,

As the original author of NS_GET_OWNER_UID can you take a look at this?

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> On Fri, Jul 24, 2020 at 11:20:26AM +0200, Arnd Bergmann wrote:
>> On Fri, Jul 24, 2020 at 2:12 AM Dmitry V. Levin <ldv@altlinux.org> wrote:
>> >
>> > According to Documentation/driver-api/ioctl.rst, in order to support
>> > 32-bit user space running on a 64-bit kernel, each subsystem or driver
>> > that implements an ioctl callback handler must also implement the
>> > corresponding compat_ioctl handler.  The compat_ptr_ioctl() helper can
>> > be used in place of a custom compat_ioctl file operation for drivers
>> > that only take arguments that are pointers to compatible data
>> > structures.
>> >
>> > In case of NS_* ioctls only NS_GET_OWNER_UID accepts an argument, and
>> > this argument is a pointer to uid_t type, which is universally defined
>> > to __kernel_uid32_t.
>> 
>> This is potentially dangerous to rely on, as there are two parts that
>> are mismatched:
>> 
>> - user space does not see the kernel's uid_t definition, but has its own,
>>   which may be either the 16-bit or the 32-bit type. 32-bit uid_t was
>>   introduced with linux-2.3.39 in back in 2000. glibc was already
>>   using 32-bit uid_t at the time in user space, but uclibc only changed
>>   in 2003, and others may have been even later.
>> 
>> - the ioctl command number is defined (incorrectly) as if there was no
>>   argument, so if there is any user space that happens to be built with
>>   a 16-bit uid_t, this does not get caught.
>
> Note that NS_GET_OWNER_UID is provided on 32-bit architectures, too, so
> this 16-bit vs 32-bit uid_t issue was exposed to userspace long time ago
> when NS_GET_OWNER_UID was introduced, and making NS_GET_OWNER_UID
> available for compat processes won't make any difference, as the mismatch
> is not between native and compat types, but rather between 16-bit and
> 32-bit uid_t types.
>
> I agree it would be correct to define NS_GET_OWNER_UID as
> _IOR(NSIO, 0x4, uid_t) instead of _IO(NSIO, 0x4), but nobody Cc'ed me
> on this topic when NS_GET_OWNER_UID was discussed, and that ship has long
> sailed.
>
>> > This change fixes compat strace --pidns-translation.
>> > 
>> > Note: when backporting this patch to stable kernels, commit
>> > "compat_ioctl: add compat_ptr_ioctl()" is needed as well.
>> > 
>> > Reported-by: Ákos Uzonyi <uzonyi.akos@gmail.com>
>> > Fixes: 6786741dbf99 ("nsfs: add ioctl to get an owning user namespace for ns file descriptor")
>> > Cc: stable@vger.kernel.org # v4.9+
>> > Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
>> > ---
>> >  fs/nsfs.c | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/fs/nsfs.c b/fs/nsfs.c
>> > index 800c1d0eb0d0..a00236bffa2c 100644
>> > --- a/fs/nsfs.c
>> > +++ b/fs/nsfs.c
>> > @@ -21,6 +21,7 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
>> >  static const struct file_operations ns_file_operations = {
>> >         .llseek         = no_llseek,
>> >         .unlocked_ioctl = ns_ioctl,
>> > +       .compat_ioctl   = compat_ptr_ioctl,
>> >  };
>> >
>> >  static char *ns_dname(struct dentry *dentry, char *buffer, int buflen)

Thank you,
Eric
