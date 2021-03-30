Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B342A34EF3B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhC3RTm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 13:19:42 -0400
Received: from sonic308-15.consmr.mail.ne1.yahoo.com ([66.163.187.38]:39144
        "EHLO sonic308-15.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231579AbhC3RTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 13:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617124754; bh=ruyO0cQ+SgSQWudmya9nza7wW/yADfiYRBpz8TMh36s=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject:Reply-To; b=HplM0UKnpq/9DdV6lsRY/M1isjl2YLLsbqw3DcrX+nOgFdK4krDUpQxiTbYI/WlqakD7cQPmJ90P16vq2GG9KKHb9X0INa1EuhTNNZQLSyIBsr8UfCLa8RD0SrJqCtbjIrMEANYev6eHHOxR2BOc21DvxCxpkWz22diRqlDT8zWmb34DiTEBuxZ7B/eusI6lsb8pluymDmVM11ljvdAXpFtd0EJgdYCKIZGnQmg+MDMh3RRN9EWRIEOAjqMMKatEehEkUsQcerpoS8v9Vshi0KmaibvPoZKvN/PQ+DDeoao5i8anCF8b+obsn0rMdZtl/6st+Y+JWoRIdsci+rsG8Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617124754; bh=pVpUf8xS6K4cmM3oPBMPienrreZdKdvyFyvJwE+6XoG=; h=X-Sonic-MF:Subject:To:From:Date:From:Subject; b=VEhsrdgZ5Q32/XMNunZjeXt1aSGtqT0QLZEqd2MImKCorTsbfvjQfuThelGjaR1CyWmqjF3JJThx3WIKahTYHNnB3XAP8V0N9Lep+RydqezA7+xKlkiwDZzE1+jlOmShhvHuFa4JQvYT5KUxrw9EvCQFM11ciPTkEFrYNPvuVKCUCoZtmYQuiG0eTeiiVNuEOcxNEpJT6m158vsW85B+9PNyoyjLurUMzZsupBY9zPRgcp6BErvmKFU6BwH9DSTF8vUGW5oFbJ+taHUnSAWpgILkvd6vZfPXbfFUhMTiS6wugtgvSQ2yr78XMCXF6y3mXzlwXbJMHLLm6TMagjT8xQ==
X-YMail-OSG: fImJ3scVM1kPoQOwuUA7zhBZfaHcfqM4Zi.uBqG3qrP08og_H9G31t8lL6CrdmJ
 SYsSBZQhKeKQWk9InqI_5fEon2BVR_SnMFkOt8fEF8zhvXysgIAMJpIhJALr3lDWIAcZVBU8y1XG
 rKnRhgWdNAQy7UT7KVVh0fx7ZmrYQXir5e57SCi92cgddnq.RuXVRRHp4xV0Ip4Nk34SUbqGluZh
 WBT9Yz.2RWeviFBRkNl3707vMUMMEYuSFxc6qvroKTTov0oZEVjYBEM0HmKMtnV8.ZifNcTb7OG5
 sXvSb6iYo8CSm031EFXCAhb5AiUvaTxcy3_sRTuHUqWHqy5rDsr0q1r2jn.SKP8ZdeD_0b_pbK56
 Li0C26TvF6jkA61OSGFq0GXVVnqv1J8xqOzbDrnO73nmr4TDgsKRhg3sXmpcUKV1T1clljor6_oo
 xjLZ9rg4w4xkJoi8Dcg9eLHO6SSW__VCoXY8PrBzSUA54DLE9BB54_aCYiuhdxvlL3SBusiA_enU
 gRRd35F8.N6P067qANabRBBp4Kh9P30msGLDzezk.PH5ka2Czjv6tOj_.OHa7S42Q5r2oL8tR3A1
 Qs41_uDLksSt_s3K.Bvcs.P0ndoXECzJcwsuo5xdKgq6sGLFHxZ5fulYo1Q3XNSBTtkmI3WNVz8j
 Z5w9VNSCXjN8GCA9MiZDVcA6gGEVBieBjei1ObRKMB7Ipp2f0LNCbJt4Lo65cbPFhKdsspODnAZV
 WlWIiFmFhMvHyLYWwUlJUNw._HfoHT2IQJC36IXk8zFVLp.g5Ae8jx5bDZb1IDGfiC10jVMNY_1F
 urMKiWw0HdlVnwnGy8MvEDU4NoSj.a8YqjhKKPXxkWatkxh44Qqx35hBbsKOp7CDTOKYHPUFiza_
 YPmo6btThj0WiaPfkvD8h8PgjablQdDKHHah13z297balD7_XZNa.riB3mg.1Ee6j50LhTCeADvN
 .33i93mWLrq9AhImZ.CsqTV.9CUTaTcG3KIbz0m.IUf6y.7LaT_iFXiXX3T1T8LbTLFFyet5rhgv
 c2ZExhCvZSV_qAxzQOOpoYaWfZg55Db3pnvl_5hq34cHCc3WcKVeDjnPInwP1S.qA_Ck5KXLqF_7
 kFqetRLrL3pfy955EPCTP1yXjfzItC_jBqlfVKQpS165aVtfyETxYpxfSX9gZ5LPnFXuocV_Q_P6
 1_B744VigVUMJV0nmyE_UNQ2E_awfZhD.gIm0rXnwshigYzUH6M3rY0mHawxqIOl7Plirul4BzPx
 0y885j9aRNnghVhjo9BNwv4ZA0PpS5ClN3qUCUYBE4seYTP8C31G39uZn_BVAa28pSgVPWkBssvj
 GvCjhpLqsf480L9uuQoUkDyyhE1SR8Tz5a86xIyaBN4mKcqB6c7ofDkYwP.iohuTV5yQMVK0und5
 lVRrTHmuGJ97Pk68Jgni.Nr5Y9KYry6LJUZGG5HUkh8LVbBcllOeJ0_.auV4Nh6yX_tvq0QaBy1o
 S.ONX_0bSvmZB.gIqYSxE5YYFm4u0g_fjssqhjeeFoKgSj5SvBciiBqFOmkQDgnFBhuy8WJjotC1
 FgmsrGszlAJVr_OXxC8fU4yWcxqd1RzlJ2KvMn.s4yEE6Jjvr5IIv4U2TQQrgEWMI7pd_TFmnGXY
 U7ZKsQnv3FKlLCt3kM4MwNvReLD24dkGto.7ynkQgG.xPh7BD1r6vxdq0GsTh0.sfTFnlP8jUWcg
 9Pv5dQFjMP227B_GUfpTIZQfKDV2UUjsX2Tn0qZduyPsTG7DbJh3MqPyVQ4xbI_ReDnexuP7rkrs
 X2fMUKU1XkIx5PVYByP2t7oeAn.5kTCW9tZHwtH23pD1izDwHRwWMjzigY_ELaJqWBLcTmganQFu
 fwUwgEyrKzDRsldZvizj0NmiIyT1VwTZo9pxskSkxmZbqww.noQTAQ6QyT7z9_w4uolV8EVVwGb3
 QYlaMj__YlsESMmly4R.5hRsAPTkYZdcXI7qLc4h.eapO7wtBD4s9xTMg1GDR8eU0msTj0ypJLGZ
 UP4dbjaZ2e5RnDClHESp6LKwVNSJCdsChoXDJHW3Obm.t6ZAHD0famCuFXlpiRCvUIFwsOF9tSE3
 rr3egZPpTg_ZhzuJ5LmKeDj1n3VijumQsyjCmco17c8gKj3bkauBjmPIaEgPPwi.5xob8sAfnIOI
 vwFlK8Cg2tIRZuyd3EPaNej7G.aPZv8t1qSW2ROi.e47ObN0wSXc9o48fQM7iIYAAO.MwaBoPHKV
 vG_vwOW7G7WO2rAWoVdC0YtLahjZlRG1rE.PKiqZrgTmM0Wgll8hHcCEUkEq_5KXDNibbL5jd_MX
 9W3apjfS9_4W7sYh8YhAOESkR0vQmIOx2vA1wa5pxFblUAYOLWofwwxyc0jXzcA0EFxHwWlT7Y_U
 ymSMi.jQ2xjQIS6ishciTQujUcYHiL8l1lXzgdpakHUnfft7l7brII3_jyL5sFBNX1kM0l1f6DER
 Qr49Nu5pWTRseySGJ1_DOhNolzNaLzySX8.vw0vctb6gErloMLmczRbGDqwOdODpYgB4kv34XQz6
 hxyeSbetoJsZYExsiElEmpXzfdLUo9cLonmpbb4W6tRY_k91KK172Iwxhmssc.pGtN5orM7o97yt
 Pna_lDftkWC3ZJNJxSF9jbKvZApovbobHOMQm.byw2EEZB4fKFSjtZ20PqCjoktM42H3aK274vKe
 I.KibKbpMKZgNUyAQiKXOo4Su3LY8fBSjmNY1bcJU2MFmJ3lYMPeDYZuPdmmoxq2Lmg25Z6F_Hnj
 SqTyjhgU0eewYMRMV3f9629JueG_6tEMgLRm7mhlp5gd.UDKB.R4DbPUcOWi7qeDIn2AmG4t12Ux
 7mYF0DvSwEpd437TI1_Gez3abTnVYwlCt8Og5eRRKZQUUjyRpd7QJew1o_jNsg3G8KCh4sm7jqoK
 Cs3bDKxE6rtEk1.SADmDPy1nbMsUJAP6zC3A0klN_mR03NBuKFiYc1my5ydsuh3Os3i1MtkyKn.j
 wpIezwoCikU1lGFOrrGOy90_cifVnde5eJlM_59AtoeU.WuEYRvWkeyQo5XSpQESj1S_DuZkeBby
 Gxw1D8BhSoTm0kJzo5kow.i_VosG9QlZy70TmM51eYCIGFC_c_YrgsBi0LDME68zWzaichL8b8IU
 5V.dhUDp.MCKTZwvmg0xlV0vSCdlzUPJVm8_jODTbvQFAQarYCXG1YKezmvmIMv28R34_1QAl0LE
 r4YBrpQjMQ0iyk19kjK6U52t2aASosLQcHPuPrii7rRTr4vHzdUzzpTd4vAf2hivM4k_naLgRqxa
 E20OzTlxtJSjXjqFZazGNAl8PCVIwxeO2JiaPYO2LiIG.mGv8AI1R3zkQTc1qzcyRY0_E.hmM2Uz
 lSWp0PQhnGCSXqMzROu6xJwRXp__HGRA6PVmsIRFZ9LFExeZKxDTjT9_0rVFmxv2jPSzO5jKhvsW
 gNjWyeTObmg7xaheSCOQUAhwU3BZ36QNfVE8PzC2WIey5rGSvYPbBSbxVc9u9hapLG5Hrjz3i.P6
 XbJaAy.GXjgmrE3v4bdkcVHBZSQteUdHXvrHHcWlh_e4JYufLx2oItjAZcrAkm_.eeV362OB1YkR
 PARYg4hCBgKz5tYL5HXRXbMH1G1rvBRRJX8hGZ0DcWXYy8zvA6Z4.XKKadUdQBBWcOPGuKqwzT3F
 YQoLnu6bpHBSSDxepTDVqBarfxhNO0XYK7G.NbuQMBtSgJY2pQ8femaLurvDGSe3rw9lS0VjYxs2
 MAVPvVdLO_wx7_Y_4i01N9bYzQb.r4cZD76bMmXqoeskBp835dpxPdMxIAMe_Bl7IgjiM1lFH0dz
 IFa5FBWFz5vI_tpiL.t6HVASQc38GAGSDM12gz75D2UwJ7NhVGiD3sr9VobCtjN4xWjoYVSiBI82
 UTNLy9iYJvcfh1ZfU7brPwpLPQZ4_kIQwY1cQpOtbAvL.MstC34CwJ4zhmx3YPWA1KzCqe6wRKlz
 xo6ZOGHHu0x7gTpU-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Tue, 30 Mar 2021 17:19:14 +0000
Received: by kubenode501.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID c7906aa3130534e56463b91725399b85;
          Tue, 30 Mar 2021 17:19:13 +0000 (UTC)
Subject: Re: [PATCH v5 1/1] fs: Allow no_new_privs tasks to call chroot(2)
To:     =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        James Morris <jmorris@namei.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        David Howells <dhowells@redhat.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jannh@google.com>,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        kernel-hardening@lists.openwall.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@linux.microsoft.com>
References: <20210316203633.424794-1-mic@digikod.net>
 <20210316203633.424794-2-mic@digikod.net>
 <fef10d28-df59-640e-ecf7-576f8348324e@digikod.net>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <85ebb3a1-bd5e-9f12-6d02-c08d2c0acff5@schaufler-ca.com>
Date:   Tue, 30 Mar 2021 10:19:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <fef10d28-df59-640e-ecf7-576f8348324e@digikod.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Mailer: WebService/1.1.17936 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/2021 10:01 AM, Micka=C3=ABl Sala=C3=BCn wrote:
> Hi,
>
> Is there new comments on this patch? Could we move forward?

I don't see that new comments are necessary when I don't see
that you've provided compelling counters to some of the old ones.
It's possible to use minimal privilege with CAP_SYS_CHROOT.
It looks like namespaces provide alternatives for all your
use cases. The constraints required to make this work are quite
limiting. Where is the real value add?

>
> Regards,
>  Micka=C3=ABl
>
>
> On 16/03/2021 21:36, Micka=C3=ABl Sala=C3=BCn wrote:
>> From: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>>
>> Being able to easily change root directories enables to ease some
>> development workflow and can be used as a tool to strengthen
>> unprivileged security sandboxes.  chroot(2) is not an access-control
>> mechanism per se, but it can be used to limit the absolute view of the=

>> filesystem, and then limit ways to access data and kernel interfaces
>> (e.g. /proc, /sys, /dev, etc.).
>>
>> Users may not wish to expose namespace complexity to potentially
>> malicious processes, or limit their use because of limited resources.
>> The chroot feature is much more simple (and limited) than the mount
>> namespace, but can still be useful.  As for containers, users of
>> chroot(2) should take care of file descriptors or data accessible by
>> other means (e.g. current working directory, leaked FDs, passed FDs,
>> devices, mount points, etc.).  There is a lot of literature that discu=
ss
>> the limitations of chroot, and users of this feature should be aware o=
f
>> the multiple ways to bypass it.  Using chroot(2) for security purposes=

>> can make sense if it is combined with other features (e.g. dedicated
>> user, seccomp, LSM access-controls, etc.).
>>
>> One could argue that chroot(2) is useless without a properly populated=

>> root hierarchy (i.e. without /dev and /proc).  However, there are
>> multiple use cases that don't require the chrooting process to create
>> file hierarchies with special files nor mount points, e.g.:
>> * A process sandboxing itself, once all its libraries are loaded, may
>>   not need files other than regular files, or even no file at all.
>> * Some pre-populated root hierarchies could be used to chroot into,
>>   provided for instance by development environments or tailored
>>   distributions.
>> * Processes executed in a chroot may not require access to these speci=
al
>>   files (e.g. with minimal runtimes, or by emulating some special file=
s
>>   with a LD_PRELOADed library or seccomp).
>>
>> Allowing a task to change its own root directory is not a threat to th=
e
>> system if we can prevent confused deputy attacks, which could be
>> performed through execution of SUID-like binaries.  This can be
>> prevented if the calling task sets PR_SET_NO_NEW_PRIVS on itself with
>> prctl(2).  To only affect this task, its filesystem information must n=
ot
>> be shared with other tasks, which can be achieved by not passing
>> CLONE_FS to clone(2).  A similar no_new_privs check is already used by=

>> seccomp to avoid the same kind of security issues.  Furthermore, becau=
se
>> of its security use and to avoid giving a new way for attackers to get=

>> out of a chroot (e.g. using /proc/<pid>/root, or chroot/chdir), an
>> unprivileged chroot is only allowed if the calling process is not
>> already chrooted.  This limitation is the same as for creating user
>> namespaces.
>>
>> This change may not impact systems relying on other permission models
>> than POSIX capabilities (e.g. Tomoyo).  Being able to use chroot(2) on=

>> such systems may require to update their security policies.
>>
>> Only the chroot system call is relaxed with this no_new_privs check; t=
he
>> init_chroot() helper doesn't require such change.
>>
>> Allowing unprivileged users to use chroot(2) is one of the initial
>> objectives of no_new_privs:
>> https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html=

>> This patch is a follow-up of a previous one sent by Andy Lutomirski:
>> https://lore.kernel.org/lkml/0e2f0f54e19bff53a3739ecfddb4ffa9a6dbde4d.=
1327858005.git.luto@amacapital.net/
>>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Christian Brauner <christian.brauner@ubuntu.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
>> Cc: Eric W. Biederman <ebiederm@xmission.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: Jann Horn <jannh@google.com>
>> Cc: John Johansen <john.johansen@canonical.com>
>> Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
>> Cc: Serge Hallyn <serge@hallyn.com>
>> Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@linux.microsoft.com>
>> Reviewed-by: Kees Cook <keescook@chromium.org>
>> Link: https://lore.kernel.org/r/20210316203633.424794-2-mic@digikod.ne=
t
>> ---
>>
>> Changes since v4:
>> * Use READ_ONCE(current->fs->users) (found by Jann Horn).
>> * Remove ambiguous example in commit description.
>> * Add Reviewed-by Kees Cook.
>>
>> Changes since v3:
>> * Move the new permission checks to a dedicated helper
>>   current_chroot_allowed() to make the code easier to read and align
>>   with user_path_at(), path_permission() and security_path_chroot()
>>   calls (suggested by Kees Cook).
>> * Remove now useless included file.
>> * Extend commit description.
>> * Rebase on v5.12-rc3 .
>>
>> Changes since v2:
>> * Replace path_is_under() check with current_chrooted() to gain the sa=
me
>>   protection as create_user_ns() (suggested by Jann Horn). See commit
>>   3151527ee007 ("userns:  Don't allow creation if the user is chrooted=
")
>>
>> Changes since v1:
>> * Replace custom is_path_beneath() with existing path_is_under().
>> ---
>>  fs/open.c | 23 +++++++++++++++++++++--
>>  1 file changed, 21 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/open.c b/fs/open.c
>> index e53af13b5835..480010a551b2 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -532,6 +532,24 @@ SYSCALL_DEFINE1(fchdir, unsigned int, fd)
>>  	return error;
>>  }
>> =20
>> +static inline int current_chroot_allowed(void)
>> +{
>> +	/*
>> +	 * Changing the root directory for the calling task (and its future
>> +	 * children) requires that this task has CAP_SYS_CHROOT in its
>> +	 * namespace, or be running with no_new_privs and not sharing its
>> +	 * fs_struct and not escaping its current root (cf. create_user_ns()=
).
>> +	 * As for seccomp, checking no_new_privs avoids scenarios where
>> +	 * unprivileged tasks can affect the behavior of privileged children=
=2E
>> +	 */
>> +	if (task_no_new_privs(current) && READ_ONCE(current->fs->users) =3D=3D=20
1 &&
>> +			!current_chrooted())
>> +		return 0;
>> +	if (ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>> +		return 0;
>> +	return -EPERM;
>> +}
>> +
>>  SYSCALL_DEFINE1(chroot, const char __user *, filename)
>>  {
>>  	struct path path;
>> @@ -546,9 +564,10 @@ SYSCALL_DEFINE1(chroot, const char __user *, file=
name)
>>  	if (error)
>>  		goto dput_and_out;
>> =20
>> -	error =3D -EPERM;
>> -	if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
>> +	error =3D current_chroot_allowed();
>> +	if (error)
>>  		goto dput_and_out;
>> +
>>  	error =3D security_path_chroot(&path);
>>  	if (error)
>>  		goto dput_and_out;
>>

